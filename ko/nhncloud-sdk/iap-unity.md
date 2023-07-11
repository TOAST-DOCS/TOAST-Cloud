## NHN Cloud > SDK 사용 가이드 > IAP > Unity

## Prerequisites

1. [Install the NHN Cloud SDK](./getting-started-unity)
2. [NHN Cloud 콘솔](https://console.nhncloud.com)에서 [Mobile Service \> IAP를 활성화](https://docs.nhncloud.com/ko/Mobile%20Service/IAP/ko/console-guide/)합니다.
3. IAP에서 [AppKey를 확인](https://docs.nhncloud.com/ko/Mobile%20Service/IAP/ko/console-guide/#appkey)합니다.

## Android 설정
### Gradle 빌드 설정
- Unity Editor에서, Build Settings 창을 엽니다. (Player Settings > Publishing Settings > Build).
- Build System 목록에서 Gradle을 선택합니다.
- Build System 하위의 체크 박스를 선택하여 Custom Gradle Template을 사용합니다.
- mainTemplate.gradle의 dependencies 항목에 아래 내용을 추가합니다.

#### Google Play Store

```groovy
repositories {
  google()
  mavenCentral()
}

dependencies {
  implementation 'com.nhncloud.android:nhncloud-iap-google:1.7.0'
**DEPS**}
```

#### One Store

```groovy
repositories {
  mavenCentral()
}

dependencies {
  implementation 'com.nhncloud.android:nhncloud-iap-onestore:1.7.0'
**DEPS**}
```

#### Galaxy Store

```groovy
repositories {
  mavenCentral()
}

dependencies {
  implementation 'com.nhncloud.android:nhncloud-iap-galaxy:1.7.0'
**DEPS**}
```

#### Amazon Appstore

```groovy
repositories {
  mavenCentral()
}

dependencies {
  implementation 'com.nhncloud.android:nhncloud-iap-amazon:1.7.0'
**DEPS**}
```

#### Huawei App Gallery

- AppGallery Connection 구성 파일(agconnect-service.json)을 추가합니다.
    - [AppGallery Connect](https://developer.huawei.com/consumer/en/service/josp/agc/index.html)에 로그인한 다음 **내 프로젝트**를 클릭합니다.
    - 프로젝트에서 앱을 선택합니다.
    - **Project settings** > **General information**으로 이동합니다.
    - **App information**에서 **agconnect-service.json** 파일을 다운로드합니다.
    - **agconnect-service.json** 파일을 앱의 루트 디렉토리에 복사합니다.
- 아래와 같이 App Gallery Connect 플러그인과 의존성을 설정합니다.

```groovy
buildscript {
	repositories {
		mavenCentral()

		// Huawei Repository
		maven {url 'https://developer.huawei.com/repo/'}
	}

	dependencies {
    ...

		// Huawei App Gallery Plugin
    classpath 'com.huawei.agconnect:agcp:1.7.0.300'
	}
}

repositories {
  mavenCentral()
}

apply plugin: 'com.android.application'
apply plugin: 'com.huawei.agconnect'

dependencies {
  implementation 'com.nhncloud.android:nhncloud-iap-huawei:1.7.0'
**DEPS**}
```

## iOS 설정
### Capabilities 설정
- XCode 프로젝트의 설정에서 Capabilities 탭을 선택합니다.
- In-App Purchase 항목을 ON 합니다.

### 필수 프레임워크 추가
- iOS에서 IAP 기능을 사용하기 위해서는 Storekit.framework가 반드시 필요합니다.
- XCode 프로젝트의 설정에서 Storekit.framework을 추가해주세요.

## 지원하는 스토어 및 상품 종류

| 플랫폼 | 스토어 | 지원하는 상품 종류 |
|---|---|---|
| Android | Google Play Store | 소비성 상품, 구독 상품, 소비성 구독 상품 |
| Android | One Store | 소비성 상품 |
| iOS | Apple App Store | 소비성 상품, 구독 상품, 소비성 구독 상품 |

## NHN Cloud IAP SDK 초기화
[ToastIapConfiguration](./iap-unity/#toastiapconfiguration)을 이용해서 NHN Cloud IAP 콘솔에서 발급 받은 Appkey와 스토어 코드([StoreCode](./iap-unity/#storecode))를 설정합니다.
초기화와 함께 구매 결과를 받을 수 있는 PurchaseUpdateListener를 등록합니다.

> **초기화 시점**
> NHN Cloud IAP SDK 초기화는 반드시 앱 실행 직후 최초 1회만 해야 하며,
> 사용자 ID를 설정(아래 [서비스 로그인](./iap-unity/#_4) 항목 참고)하기 전에 초기화를 해야 합니다.

### 초기화 API 명세
```csharp
public delegate void PurchaseUpdateListener(string transactionId, ToastResult result, IapPurchase purchase);

public static void Initialize(ToastIapConfiguration configuration, PurchaseUpdateListener listener);
```

### 초기화 예시

```csharp
ToastIap.Initialize(new ToastIapConfiguration
{
    AppKey = "YOUR_IAP_APP_KEY",
    StoreCode = StoreCode.GooglePlayStore
}, (result, purchase) =>
{
    if (result.IsSuccessful)
    {
        // 결제 성공
    }
    else
    {
        // 결제 실패
    }
});
```

## 서비스 로그인
- NHN Cloud SDK에서 제공하는 모든 상품(IAP, Log & Crash 등)은 하나의 동일한 사용자 아이디를 사용합니다.
    - ToastSdk.UserId 로 사용자 아이디를 설정할 수 있습니다.
    - 사용자 아이디를 설정하지 않은 경우, 결제가 진행되지 않습니다.
- 서비스 로그인 단계에서 사용자 아이디 설정, 미소비 결제 내역 조회, 활성화된 구독 상품 조회 기능을 구현하는 것을 권장합니다.

### 로그인

```csharp
// Login
ToastSdk.UserId = "USER_ID";
```

### 로그아웃

```csharp
// Logout
ToastSdk.UserId = null;
```

> [참고] 서비스 로그아웃 시 반드시 유저 아이디를 null로 설정해야 프로모션 코드가 리딤되거나 결제 재처리 동작시 잘못된 사용자 아이디로 구매가 진행되는 것을 방지할 수 있습니다.

## 상품 목록 조회
- IAP 콘솔에 등록된 상품 중 사용 가능한 상품 목록을 조회합니다.
    - IAP 콘솔에 등록된 상품 중 구매 가능한 상품은 [ProductDetailsResult](./iap-unity/#productdetailsresult)의 Product 프로퍼티([IapProduct](./iap-unity/#iapproduct))로 반환됩니다.
    - IAP 콘솔에 등록된 상품 중 스토어에 등록되지 않은 상품은 [ProductDetailsResult](./iap-unity/#productdetailsresult) InvalidProducts 프로퍼티([IapProduct](./iap-unity/#iapproduct))로 반환됩니다.

### 상품 목록 조회 API 명세

```csharp
public static void RequestProductDetails(ToastCallback<ProductDetailsResult> callback);
```

### 상품 목록 조회 예시

```csharp
ToastIap.RequestProductDetails((result, productDetailsResult) =>
{
    if (result.IsSuccessful)
    {
        var products = productDetailsResult.Products;
        foreach (var product in products)
        {
            var name = product.ProductName;
            var localizedPrice = product.LocalizedPrice;
            // ...
        }
    }
});
```

## 상품 구매
- NHN Cloud IAP는 스토어에 등록된 상품 ID를 사용하여 상품을 구매할 수 있습니다.
    - 상품 ID는 상품 목록 조회시 획득할 수 있습니다.
- 상품 구매 결과는 초기화시 등록한 PurchaseUpdateListener를 통해 반환됩니다.
    - 구매 결과는 [IapPurchase](./iap-unity/#iappurchase)를 반환합니다.

### 상품 구매 API 명세

```csharp
public static void Purchase(string productId, developerPayload = "");
```

- NHN Cloud IAP는 구매 요청 시 developerPayload를 통해 사용자 정보를 추가할 수 있습니다.

### 상품 구매 예시

```csharp
var productId = userSelectedProductId;
ToastIap.Purchase(productId);
```

```csharp
var productId = userSelectedProductId;
ToastIap.Purchase(productId, developerPayload);
```

## 미소비 결제 조회
- 아직 소비되지 않은 소비성 상품 정보를 조회합니다.
    - 미소비 결제 조회의 결과는 [IapPurchase](./iap-unity/#iappurchase) 객체의 리스트로 반환됩니다.
- 사용자에게 상품을 지급된 후 [Consume API](../../../Mobile%20Service/IAP/ko/api-guide-for-toast-sdk/#consume-api)를 사용하여 상품을 소비합니다.

### 미소비 결제 조회 API 명세

```csharp
public static void RequestConsumablePurchases(bool isQueryAllStores, ToastCallback<List<IapPurchase>> callback);
```

### 미소비 결제 조회 예시

```csharp
// 모든 스토어 조회
ToastIap.RequestConsumablePurchases(true, (result, purchases) =>
{
    if (result.IsSuccessful)
    {
        // 모든 스토어 미소비 결제 조회 성공
    }
});
```

```csharp
// 현재 스토어 조회
ToastIap.RequestConsumablePurchases(false, (result, purchases) =>
{
    if (result.IsSuccessful)
    {
        // 현재 스토어 미소비 결제 조회 성공
    }
});
```

## 구독 복원
- User ID 기준으로 활성화된 구독 상품을 복원할 수 있습니다.
    - 결제가 완료된 구독 상품은 사용 기간이 남아 있는 경우 계속해서 복원할 수 있습니다.
    - 구독 상품 복원 조회의 결과는 [IapPurchase](./iap-unity/#iappurchase) 객체의 리스트로 반환됩니다.
- iOS에서만 구독한 상품을 복원 가능합니다.

### 구독 복원 API 명세

```csharp
public static void RequestRestorePurchases(ToastCallback<List<IapPurchase>> callback);
```

### 구독 복원 예시

```csharp
ToastIap.RequestRestorePurchases((result, purchases) =>
{
    if (result.IsSuccessful)
    {
        // 구독 복원 조회 성공
    }
});
```

## 활성화된 구독 조회
- User ID 기준으로 활성화된 구독 상품을 조회할 수 있습니다.
    - 결제가 완료된 구독 상품은 사용 기간이 남아 있는 경우 계속해서 조회할 수 있습니다.
    - 활성화된 구독 조회의 결과는 [IapPurchase](./iap-unity/#iappurchase) 객체의 리스트로 반환됩니다.
- Android에서 구독한 상품을 iOS에서도, 혹은 iOS에서 구독한 상품을 Android에서도 조회 가능합니다.

### 활성화된 구독 조회 API 명세

```csharp
public static void RequestActivatedPurchases(bool isQueryAllStores, ToastCallback<List<IapPurchase>> callback);
```

### 활성화된 구독 조회 예시

```csharp
// 모든 스토어에서 활성화된 구독 조회
ToastIap.RequestActivatedPurchases(true, (result, purchases) =>
{
    if (result.IsSuccessful)
    {
        // 모든 스토어에서 활성화된 구독 조회
    }
});
```

```csharp
// 현재 스토어에서 활성화된 구독 조회
ToastIap.RequestActivatedPurchases(false, (result, purchases) =>
{
    if (result.IsSuccessful)
    {
        // 현재 스토어에서 활성화된 구독 조회 성공
    }
});
```

## 구독 상태 조회

- User ID 기준으로 구입한 구독 상품의 상태를 조회할 수 있습니다.
- 구독 상태 조회 결과는 [IapSubscriptionStatus](./iap-android/#iapsubscriptionstatus) 객체의 리스트로 반환됩니다.
- 구독 상태는 [IapSubscriptionStatus](./iap-android/#iapsubscriptionstatus).GetStatus() 메서드로 확인할 수 있습니다.
- 구독 상태 코드는 [IapSubscriptionStatus.Status](./iap-android/#iapsubscriptionstatusstatus)에 정의되어 있습니다.

### 구독 상태 조회 API 명세

```csharp
public static void RequestSubscriptionsStatus(
            bool includeExpiredSubscriptions,
            ToastCallback<List<IapSubscriptionStatus>> callback);
```

### 구독 상태 조회 예시

```csharp
ToastIap.RequestSubscriptionsStatus(true, (result, subscriptionsStatus) =>
{
    if (result.IsSuccessful)
    {
        // 성공
    }
});
```

## NHN Cloud IAP Class Reference

### ToastIapConfiguration

```csharp
public class ToastIapConfiguration
{
    public string AppKey { get; set; }
    public StoreCode StoreCode { get; set; }
}
```

| Property | Returns | Description |
|---|---|---|
| AppKey | string | IAP 서비스 앱 키를 설정합니다. |
| StoreCode | StoreCode | 스토어 코드를 설정합니다. |


### StoreCode

```csharp
public enum StoreCode
{
    GooglePlayStore,
    AppleAppStore,
    OneStore,
    AmazonAppStore,
    HuaweiAppGallery
}
```

| Value | Description |
|---|---|
| GooglePlayStore | 구글 플레이 스토어 (Android Only) |
| AppleAppStore | 애플 앱 스토어 (iOS Only) |
| OneStore | 원 스토어 (Android Only) |
| AmazonAppStore | 아마존 앱스토어 (Android Only) |
| HuaweiAppGallery | Huawei App Gallery (Android Only) |

### ToastResult<T>
```csharp
public class ToastResult
{
    public bool IsSuccessful { get; }
    public int Code { get; }
    public string Message { get; }
}
```

| Property | Returns | Description |
|---|---|---|
| IsSuccessful | bool | 결과 성공 여부를 반환합니다. |
| Code | int | 결과 코드를 반환합니다. <br/> (성공은 0을 반환) |
| Message | string | 결과 메시지를 반환합니다. |

### ProductDetailsResult
```csharp
public class ProductDetailsResult
{
    public List<IapProduct> Products { get; }
    public List<IapProduct> InvalidProducts { get; }
}
```

| Property | Returns | Description |
|---|---|---|
| Products | List<IapProduct> | 사용가능한 상품 정보들을 반환합니다. |
| InvalidProducts | List<IapProduct> | NHN Cloud IAP 콘솔에 상품을 등록하였지만 스토어에 등록되지 않은 상품들을 반환합니다. |


### IapProduct
```csharp
public class IapProduct
{
    public string Id { get; }
    public string Name { get; }
    public string ProductType { get; }
    public bool IsActive { get; }
    public float Price { get; }
    public string Currency { get; }
    public string LocalizedPrice { get; }
}
```

| Property | Returns | Description |
|---|---|---|
| Id | string | 상품의 ID |
| Name | string | 상품 이름 |
| ProductType | string | 상품 유형 |
| IsActive | bool | 상품 활성화 여부 |
| Price | float | 가격 |
| Currency | string | 통화 |
| LocalizedPrice | string | 현지 가격 |

### IapPurchase
```csharp
public class IapPurchase
{
    public string PaymentId { get; }
    public string PaymentSequence { get; }
    public string OriginalPaymentId { get; }
    public string ProductId { get; }
    public string ProductType { get; }
    public string UserId { get; }
    public float Price { get; }
    public string PriceCurrencyCode { get; }
    public string AccessToken { get; }
    public long PurchaseTime { get; }
    public long ExpiryTime { get; }
}
```

| Property | Returns | Description |
|---|---|---|
| PaymentId | string | 결제 ID |
| PaymentSequence | string | 결제 고유 번호 |
| OriginalPaymentId | string | 원본 결제 ID |
| ProductId | string | 상품 ID |
| ProductType | string | 상품 유형 |
| UserId | string | 사용자 ID |
| Price | float | 가격 |
| PriceCurrencyCode | string | 통화 정보 |
| AccessToken | string | 소비에 사용되는 토큰 |
| PurchaseTime | long | 상품 구매 시간 |
| ExpiryTime | long | 구독 상품의 남은 시간 |

### IapSubscriptionStatus

```csharp
public class IapSubscriptionStatus
{
    public string GetProductId();
    public string GetProductType();
    public string GetPaymentId();
    public string GetOriginalPaymentId();
    public string GetPaymentSequence();
    public string GetUserId();
    public float GetPrice();
    public string GetPriceCurrencyCode();
    public string GetAccessToken();
    public long GetPurchaseTime();
    public long GetExpiryTime();
    public string GetDeveloperPayload();
    public Status GetStatus();
    public string GetStatusDescription();
}
```

| Method | Returns | Description |
|---|---|---|
| GetProductId | string | 결제 ID |
| GetProductType | string | 결제 고유 번호 |
| GetPaymentId | string | 원본 결제 ID |
| GetOriginalPaymentId | string | 상품 ID |
| GetPaymentSequence | string | 상품 유형 |
| GetUserId | string | 사용자 ID |
| GetPrice | float | 가격 |
| GetPriceCurrencyCode | string | 통화 정보 |
| GetAccessToken | string | 소비에 사용되는 토큰 |
| GetPurchaseTime | long | 상품 구매 시간 |
| GetExpiryTime | long | 구독 상품의 남은 시간 |
| GetDeveloperPayload | string | 개발자 페이로드 |
| GetStatus | Status | 구독 상태 |
| GetStatusDescription | string | 구독 상태 설명 |

### IapSubscriptionStatus.Status

```csharp
public enum Status
{
    Active = 0,
    Canceled = 3,
    OnHold = 5,
    InGracePeriod = 6,
    Paused = 10,
    Revoked = 12,
    Expired = 13,
    Unknown = 9999
}
```

| Name | Code | Status | Description |
| --- | --- | --- | --- |
| Active | 0 | 활성 | 구독이 활성 상태입니다. |
| Canceled | 3 | 취소 | 구독이 취소되었습니다. |
| OnHold | 5 | 계정 보류 | 정기 결제가 계정 보류 상태가 되었습니다(사용 설정된 경우). |
| InGracePeriod | 6 | 유예 기간 | 정기 결제가 유예 기간 상태로 전환되었습니다(사용 설정된 경우). |
| Paused | 10 | 일시 중지 | 구독이 일시 중지되었습니다. |
| Revoked | 12 | 해지 | 정기 결제가 만료 시간 전에 사용자에 의해 취소되었습니다. |
| Expired | 13 | 만료 | 정기 결제가 만료되었습니다. |
| Unknown | 9999 | 미정의 | 정의 되지 않은 상태입니다. |

## 오류 코드

### 공통 오류 코드
| 에러 코드 | 설명 |
|---|---|
| 50000 | 초기화 되지 않았습니다 |
| 50001 | 지원하지 않는 기능입니다 |
| 50002 | 지원하지 않는 스토어 코드입니다 |
| 50003 | 사용할 수 없는 상품입니다 |
| 50004 | 이미 소유중인 상품입니다 |
| 50006 | 사용자 아이디가 잘못되었습니다 |
| 50007 | 사용자가 결제를 취소했습니다 |
| 50009 | 영수증 검증에 실패했습니다 |
| 50011 | 구독 갱신이 실패했습니다 |
| 50015 | 소유하고 있지 않은 상품입니다. |
| 50103 | 이미 소비된 상품 입니다. |
| 50104 | 이미 환불된 상품 입니다. |
| 50105 | 구매 한도를 초과했습니다. |
| 59999 | 알 수 없는 에러입니다. 에러 메시지를 확인해주세요. |

### 서버 오류 코드

| 에러 코드 | 설명 |
|---|---|
| 10000 | 잘못된 요청입니다. |
| 10002 | 네트워크가 연결되지 않았습니다. |
| 10003 | 서버 응답이 실패했습니다. |
| 10004 | 타임아웃이 발생했습니다. |
| 10005 | 유효하지 않은 서버 응답값입니다. |
| 10010 | 활성화 되지 않은 앱입니다. |

### App store 오류 코드

| 에러 코드 | 설명 |
|---|---|
| 50005 | 이미 진행중인 요청이 있습니다. |
| 50008 | 스토어에서 결제가 실패했습니다 |
| 50010 | 구매상태 변경에 실패했습니다 |
| 50012 | 환불로 인해 구매를 진행할 수 없습니다 |
| 50013 | 복원에 실패했습니다. |
| 50014 | 구매 진행 불가 상태입니다. (e.g. 앱 내 구입 제한 설정) |

### ONE store 오류 코드

| 에러 코드 | 설명 |
|---|---|
| 51000 | ONE store 서비스에 로그인되어 있지 않습니다. |
| 51001 | ONE store 서비스가 업데이트 또는 설치되지 않았습니다. |
| 51002 | 비정상 앱에서 결제를 요청하였습니다. |
| 51003 | 결제 요청에 실패했습니다. |

### Galaxy store 오류 코드

| 에러 코드 | 설명 |
|---|---|
| 53000 | Galaxy store 서비스에 로그인되어 있지 않습니다. |
| 53001 | Galaxy store 서비스가 업데이트 또는 설치되지 않았습니다. |
| 53002 | 비정상 앱에서 결제를 요청하였습니다. |
| 51003 | 결제 요청에 실패했습니다. |

## FAQ
### Android

#### Question.1
**구매 중(혹은 구매 완료 직후)에 앱을 백그라운드로 전환했다가 앱 아이콘으로 앱에 다시 진입하면 사용자 취소 에러가 콜백으로 반환됩니다. 어떻게 해야할까요?**

#### Answer.1
유니티 액티비티의 launchMode가 singleTask 이기 때문에 발생하는 문제입니다. 결제창이 파괴되면서 사용자 취소로 인식하기 때문에 사용자 취소 에러가 반환됩니다.
만약 스토어에서 결제가 완료된 상태라면, 앱을 재시작거나 미소비 결제 조회 호출을 통해 재처리를 할 수 있습니다. 재처리가 완료되면 사용자에게 아이템을 지급할 수 있게 됩니다.
재처리가 되지 않은 상태에서 다시 결제를 시도하면, 이미 소유중인 상품이라는 오류가 반환됩니다. (이를 통해 사용자의 중복결제를 피할 수 있습니다)
