## TOAST > TOAST SDK使用ガイド > TOAST IAP > Unity

## Prerequisites

1. [Install the TOAST SDK](./getting-started-unity)
2. [TOASTコンソール](https://console.cloud.toast.com)で[Mobile Service \> IAPを有効化](https://docs.toast.com/ko/Mobile%20Service/IAP/ko/console-guide/)します。
3. IAPで[AppKeyを確認](https://docs.toast.com/ko/Mobile%20Service/IAP/ko/console-guide/#appkey)します。

## Android設定
### Gradleビルド設定
- Unity Editorで、Build Settingsウィンドウを開きます。 （Player Settings> Publishing Settings> Build）。
- Build SystemリストからGradleを選択します。
- Build Systemサブのチェックボックスを選択して、Custom Gralde Templateを使用します。
- mainTemplate.gradleのdependencies項目に下記の内容を追加します。

#### Google Play Store

```groovy
apply plugin: 'com.android.application'

repositories {
    google()
    mavenCentral()
}

dependencies {
	implementation fileTree(dir: 'libs', include: ['*.jar'])
    implementation 'com.toast.android:toast-unity-iap-google:0.25.0'
**DEPS**}
```

#### One Store

```groovy
repositories {
    mavenCentral()
}

apply plugin: 'com.android.application'

dependencies {
	implementation fileTree(dir: 'libs', include: ['*.jar'])
    implementation 'com.toast.android:toast-unity-iap-onestore:0.25.0'
**DEPS**}
```

#### Galaxy Store

```groovy
repositories {
    mavenCentral()
}

apply plugin: 'com.android.application'

dependencies {
	implementation fileTree(dir: 'libs', include: ['*.jar'])
    implementation 'com.toast.android:toast-unity-iap-galaxy:0.25.0'
**DEPS**}
```

## iOS設定
### Capabilities設定
- XCodeプロジェクトの設定でCapabilitiesタブを選択します。
- In-App Purchase項目をONにします。

### 必須フレームワーク追加
- iOSでIAP機能を使用するには、Storekit.frameworkが必要です。
- XCodeプロジェクトの設定でStorekit.frameworkを追加してください。

## サポートするストアおよび商品の種類

| プラットフォーム | ストア | サポートする商品の種類 |
|---|---|---|
| Android | Google Play Store | 消費性商品、購読商品, 消費性購読商品 |
| Android | One Store | 消費性商品 |
| iOS | Apple App Store | 消費性商品、購読商品, 消費性購読商品 |

## TOAST IAP SDK初期化
[ToastIapConfiguration](./iap-unity/#toastiapconfiguration)を利用してTOAST IAPコンソールで発行されたAppKeyとストアコード([StoreCode](./iap-unity/#storecode))を設定します。
初期化と同時に購入結果を受け取れるPurchaseUpdateListenerを登録します。

> **初期化タイミング**
> TOAST IAP SDKの初期化は、アプリ実行直後、最初の1回のみ行う必要があり、
> ユーザーIDを設定(下記[サービスログイン](./iap-unity/#_4)項目参照)する前に行う必要があります。

### 初期化API仕様
```csharp
public delegate void PurchaseUpdateListener(string transactionId, ToastResult result, IapPurchase purchase);

public static void Initialize(ToastIapConfiguration configuration, PurchaseUpdateListener listener);
```

### 初期化例

```csharp
ToastIap.Initialize(new ToastIapConfiguration
{
    AppKey = "YOUR_IAP_APP_KEY",
    StoreCode = StoreCode.GooglePlayStore
}, (result, purchase) =>
{
    if (result.IsSuccessful)
    {
        // 決済成功
    }
    else
    {
        // 決済失敗
    }
});
```

## サービスログイン
- TOAST SDKで提供するすべてのサービス(IAP, Log & Crashなど)は、1つの同じユーザーIDを使用します。
    - ToastSdk.UserIdでユーザーIDを設定できます。
    - ユーザーIDを設定しない場合、決済が行われません。
- サービスログイン段階でユーザーID設定、未消費決済履歴照会、有効になっている購読商品照会機能の実装を推奨します。

### ログイン

```csharp
// Login
ToastSdk.UserId = "USER_ID";
```

### ログアウト

```csharp
// Logout
ToastSdk.UserId = null;
```

> [参考]サービスログアウト時に、必ずユーザーIDをnullに設定してください。プロモーションコードが使われたり、決済再処理動作時に誤ったユーザーIDで購入が行われることを防止できます。

## 商品リスト照会
- IAPコンソールに登録された商品のうち、使用可能な商品リストを照会します。
    - IAPコンソールに登録された商品のうち、購入可能な商品は[ProductDetailsResult](./iap-unity/#productdetailsresult)のProductプロパティ([IapProduct](./iap-unity/#iapproduct))で返されます。
    - IAPコンソールに登録された商品のうち、ストアに登録されていない商品は[ProductDetailsResult](./iap-unity/#productdetailsresult) InvalidProductsプロパティ([IapProduct](./iap-unity/#iapproduct))で返されます。

### 商品リスト照会API仕様

```csharp
public static void RequestProductDetails(ToastCallback<ProductDetailsResult> callback);
```

### 商品リスト照会例

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

## 商品購入
- TOAST IAPは、ストアに登録された商品IDを使用して商品を購入できます。
    - 商品IDは、商品リスト照会時に取得できます。
- 商品購入結果は、初期化時に登録したPurchaseUpdateListenerを通して返されます。
    - 購入結果は[IapPurchase](./iap-unity/#iappurchase)を返します。

### 商品購入API仕様

```csharp
public static void Purchase(string productId, developerPayload = "");
```

- TOAST IAP는 구매 요청 시 developerPayload를 통해 사용자 정보를 추가할 수 있습니다.

### 商品購入例

```csharp
var productId = userSelectedProductId;
ToastIap.Purchase(productId);
```

```csharp
var productId = userSelectedProductId;
ToastIap.Purchase(productId);
```

```csharp
var productId = userSelectedProductId;
ToastIap.Purchase(productId, developerPayload);
```

## 未消費決済照会
- まだ消費されていない消費性商品情報を照会します。
    - 未消費決済照会の結果は[IapPurchase](./iap-unity/#iappurchase)オブジェクトのリストで返されます。
- ユーザーに商品を支給した後[Consume API](../../../Mobile%20Service/IAP/ko/api-guide-for-toast-sdk/#consume-api)を使用して商品を消費します。

### 未消費決済照会API仕様

```csharp
public static void RequestConsumablePurchases(ToastCallback<List<IapPurchase>> callback);
```

### 未消費決済照会例

```csharp
ToastIap.RequestConsumablePurchases((result, purchases) =>
{
    if (result.IsSuccessful)
    {
        // 未消費決済照会成功
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

## 有効になっている購読照会
- User ID基準で有効になっている購読商品を照会できます。
    - 決済が完了した購読商品は、使用期間が残っている場合、継続して照会できます。
    - 有効になっている購読照会の結果は[IapPurchase](./iap-unity/#iappurchase)オブジェクトのリストで返されます。
- Androidで購読した商品をiOSでも、またはiOSで購読した商品をAndroidでも照会できます。

### 有効になっている購読照会API仕様

```csharp
public static void RequestActivatedPurchases(ToastCallback<List<IapPurchase>> callback);
```

### 有効になっている購読照会例

```csharp
ToastIap.RequestActivatedPurchases((result, purchases) =>
{
    if (result.IsSuccessful)
    {
        // 有効になっている購読照会成功
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
| AppKey | string | IAPサービスアプリキーを設定します。 |
| StoreCode | StoreCode | ストアコードを設定します。 |


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
| GooglePlayStore | GooglePlayStore(Android Only) |
| AppleAppStore | AppleAppStore(iOS Only) |
| OneStore | OneStore(Android Only) |

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
| IsSuccessful | bool | 結果が成功したかを返します。 |
| Code | int | 結果コードを返します。 <br/> (成功は0を返す) |
| Message | string | 結果メッセージを返します。 |

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
| Products | List<IapProduct> | 使用可能な商品情報を返します。 |
| InvalidProducts | List<IapProduct> | TOAST IAPコンソールに商品を登録しましたが、ストアに登録されていない商品を返します。 |


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
| Id | string | 商品のID |
| Name | string | 商品名 |
| ProductType | string | 商品タイプ |
| IsActive | bool | 商品が有効になっているか |
| Price | float | 価格 |
| Currency | string | 通貨 |
| LocalizedPrice | string | 現地価格 |

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
| PaymentId | string | 決済ID |
| PaymentSequence | string | 決済固有番号 |
| OriginalPaymentId | string | 原本決済ID |
| ProductId | string | 商品ID |
| ProductType | string | 商品タイプ |
| UserId | string | ユーザーID |
| Price | float | 価格 |
| PriceCurrencyCode | string | 通貨情報 |
| AccessToken | string | 消費に使用されるトークン |
| PurchaseTime | long | 商品購入時間 |
| ExpiryTime | long | 購読商品の残り時間 |

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
| 59999 | 알 수 없는 에러입니다. 에러 메시지를 확인해주세요 |

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
**購入中(または購入完了直後)にアプリをバックグラウンドに変更し、アプリアイコンでアプリを再び起動するとユーザーキャンセルエラーがコールバックで返されます。どうしたらいいですか？**

#### Answer.1
UnityアクティビティのlaunchModeがsingleTaskのため発生する問題です。決済ウィンドウが破壊されるとユーザーキャンセルと認識するため、ユーザーキャンセルエラーが返されます。
もしストアで決済が完了した状態なら、アプリを再起動するか未消費決済照会を呼び出すことで再処理できます。再処理が完了すると、ユーザーにアイテムを支給できるようになります。
再処理ができていない状態で再度決済を試行すると、すでに保有中の商品というエラーが返されます。(これによりユーザーの重複決済を回避することができます)
