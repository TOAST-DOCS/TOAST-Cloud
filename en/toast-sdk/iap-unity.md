## TOAST > User Guide for TOAST SDK > TOAST IAP > Unity

## Prerequisites

1. [Install the TOAST SDK](./getting-started-unity)
2. [TOAST 콘솔](https://console.cloud.toast.com)에서 [Mobile Service \> IAP를 활성화](https://docs.toast.com/en/Mobile%20Service/IAP/en/console-guide/)합니다.
3. IAP에서 [AppKey를 확인](https://docs.toast.com/en/Mobile%20Service/IAP/en/console-guide/#appkey)합니다.

## Android 설정
### Gradle 빌드 설정
- Unity Editor에서, Build Settings 창을 엽니다. (Player Settings > Publishing Settings > Build).
- Build System 목록에서 Gradle을 선택합니다.
- Build System 하위의 체크 박스를 선택하여 Custom Gralde Template을 사용합니다.
- mainTemplate.gradle의 dependencies 항목에 아래 내용을 추가합니다.

#### Google Play Store

```groovy
apply plugin: 'com.android.application'

dependencies {
	implementation fileTree(dir: 'libs', include: ['*.jar'])
    implementation 'com.toast.android:toast-unity-iap-google:0.21.1'
**DEPS**}
```

#### One Store

```groovy
apply plugin: 'com.android.application'

dependencies {
	implementation fileTree(dir: 'libs', include: ['*.jar'])
    implementation 'com.toast.android:toast-unity-iap-onestore:0.21.1'
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

## TOAST IAP SDK 초기화
[ToastIapConfiguration](./iap-unity/#toastiapconfiguration)을 이용해서 TOAST IAP 콘솔에서 발급받은 AppKey와 스토어 코드([StoreCode](./iap-unity/#storecode))를 설정합니다.
초기화와 함께 구매 결과를 받을 수 있는 PurchaseUpdateListener를 등록합니다.

> **초기화 시점**
> TOAST IAP SDK 초기화는 반드시 앱 실행 직후 최초 1회만 해야 하며, 
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
- TOAST SDK에서 제공하는 모든 상품(IAP, Log & Crash등)은 하나의 동일한 사용자 아이디를 사용합니다.
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
- TOAST IAP는 스토어에 등록된 상품 ID를 사용하여 상품을 구매할 수 있습니다.
    - 상품 ID는 상품 목록 조회시 획득할 수 있습니다.
- 상품 구매 결과는 초기화시 등록한 PurchaseUpdateListener를 통해 반환됩니다.
    - 구매 결과는 [IapPurchase](./iap-unity/#iappurchase)를 반환합니다.

### 상품 구매 API 명세

```csharp
public static void Purchase(string productId, developerPayload = "");
```

- TOAST IAP는 구매 요청 시 developerPayload를 통해 사용자 정보를 추가할 수 있습니다.

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
- 사용자에게 상품을 지급된 후 [Consume API](../../../Mobile%20Service/IAP/en/api-guide-for-toast-sdk/#consume-api)를 사용하여 상품을 소비합니다.

### 미소비 결제 조회 API 명세

```csharp
public static void RequestConsumablePurchases(ToastCallback<List<IapPurchase>> callback);
```

### 미소비 결제 조회 예시

```csharp
ToastIap.RequestConsumablePurchases((result, purchases) =>
{
    if (result.IsSuccessful)
    {
        // 미소비 결제 조회 성공
    }
});
```

## 구독 복원
- User ID 기준으로 구독 상품을 복원할 수 있습니다.
    - 결제가 완료된 구독 상품은 사용 기간이 남아 있는 경우 계속해서 복원할 수 있습니다.
    - 구독 상품 복원 조회의 결과는 [IapPurchase](./iap-unity/#iappurchase) 객체의 리스트로 반환됩니다.
- iOS에서만 구독한 상품을 복원 가능합니다.
    - 사용자의 AppStore 계정으로 구매한 내역을 기준으로 구매 내역을 복원하여 IAP 콘솔에 반영합니다. 

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
public static void RequestActivatedPurchases(ToastCallback<List<IapPurchase>> callback);
```

### 활성화된 구독 조회 예시

```csharp
ToastIap.RequestActivatedPurchases((result, purchases) =>
{
    if (result.IsSuccessful)
    {
        // 활성화된 구독 조회 성공
    }
});
```

## TOAST IAP Class Reference

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
    OneStore
}
```

| Value | Description |
|---|---|
| GooglePlayStore | 구글 플레이 스토어 (Android Only) |
| AppleAppStore | 애플 앱 스토어 (iOS Only) |
| OneStore | 원 스토어 (Android Only) |

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
| InvalidProducts | List<IapProduct> | TOAST IAP 콘솔에 상품을 등록하였지만 스토어에 등록되지 않은 상품들을 반환합니다. |


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


## FAQ
### Android

#### Question.1
**구매 중(혹은 구매 완료 직후)에 앱을 백그라운드로 전환했다가 앱 아이콘으로 앱에 다시 진입하면 사용자 취소 에러가 콜백으로 반환됩니다. 어떻게 해야할까요?**

#### Answer.1
유니티 액티비티의 launchMode가 singleTask 이기 때문에 발생하는 문제입니다. 결제창이 파괴되면서 사용자 취소로 인식하기 때문에 사용자 취소 에러가 반환됩니다.
만약 스토어에서 결제가 완료된 상태라면, 앱을 재시작거나 미소비 결제 조회 호출을 통해 재처리를 할 수 있습니다. 재처리가 완료되면 사용자에게 아이템을 지급할 수 있게 됩니다.
재처리가 되지 않은 상태에서 다시 결제를 시도하면, 이미 소유중인 상품이라는 오류가 반환됩니다. (이를 통해 사용자의 중복결제를 피할 수 있습니다)
