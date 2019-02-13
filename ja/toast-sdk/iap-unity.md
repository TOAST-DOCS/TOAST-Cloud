## TOAST > TOAST SDK使用ガイド > TOAST IAP > Unity

## Prerequisites

1. [Install the TOAST SDK](./getting-started-unity)
2. [TOASTコンソール](https://console.cloud.toast.com)で[Mobile Service \> IAPを有効化](https://docs.toast.com/ko/Mobile%20Service/IAP/ko/console-guide/)します。
3. IAPで[AppKeyを確認](https://docs.toast.com/ko/Mobile%20Service/IAP/ko/console-guide/#appkey)します。

## Android設定
### Gradleビルド設定
- mainTemplate.gradleのdependencies項目に下記の内容を追加します。

#### Google Play Store

```groovy
dependencies {
    if (GradleVersion.current() >= GradleVersion.version("4.2")) {
        implementation 'com.toast.android:toast-unity-iap-google:0.14.0'
    } else {
        compile 'com.toast.android:toast-unity-iap-google:0.14.0'
    }
}
```

#### One Store

```groovy
dependencies {
    if (GradleVersion.current() >= GradleVersion.version("4.2")) {
        implementation 'com.toast.android:toast-unity-iap-onestore:0.14.0'
    } else {
        compile 'com.toast.android:toast-unity-iap-onestore:0.14.0'
    }
}
```

## iOS設定
### Capabilities設定
- XCodeプロジェクトの設定でCapabilitiesタブを選択します。
- In-App Purchase項目をONにします。

### 必須フレームワーク追加
- iOSでIAP機能を使用するには、Storekit.frameworkが必要です。
- XCodeプロジェクトの設定でStorekit.frameworkを追加してください。

## サポートするストアおよびサービスの種類

| プラットフォーム | ストア | サポートするサービスの種類 |
|---|---|---|
| Android | Google Play Store | 消費性サービス、購読サービス |
| Android | One Store | 消費性サービス |
| iOS | Apple App Store | 消費性サービス、購読サービス |

## TOAST IAP SDK初期化
[ToastIapConfiguration](./iap-unity/#toastiapconfiguration)を利用してTOAST IAPコンソールで発行されたAppKeyとストアコード([StoreCode](./iap-unity/#storecode))を設定します。
初期化と同時に購入結果を受け取れるPurchaseUpdateListenerを登録します。

> **初期化タイミング**
> TOAST IAP SDKの初期化は、アプリ実行直後、最初の1回のみ行う必要があり、
> ユーザーIDを設定(下記[サービスログイン](./iap-unity/#_4)項目参照)する前に行う必要があります。

### 初期化API仕様
```csharp
public delegate void PurchaseUpdateListener(ToastResult result, IapPurchase purchase);

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
- サービスログイン段階でユーザーID設定、未消費決済履歴照会、有効になっている購読サービス照会機能の実装を推奨します。

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

## サービスリスト照会
- IAPコンソールに登録されたサービスのうち、使用可能なサービスリストを照会します。
    - IAPコンソールに登録されたサービスのうち、購入可能なサービスは[ProductDetailsResult](./iap-unity/#productdetailsresult)のProductプロパティ([IapProduct](./iap-unity/#iapproduct))で返されます。
    - IAPコンソールに登録されたサービスのうち、ストアに登録されていないサービスは[ProductDetailsResult](./iap-unity/#productdetailsresult) InvalidProductsプロパティ([IapProduct](./iap-unity/#iapproduct))で返されます。

### サービスリスト照会API仕様

```csharp
public static void RequestProductDetails(ToastCallback<ProductDetailsResult> callback);
```

### サービスリスト照会例

```csharp
ToastIap.RequestProductDetails((result, productDetailsResult) =>
{
    if (result.IsSuccessful)
    {
        var products = productDetailsResult.Products;
        foreach (var product in products)
        {
            var name = product.Name;
            var localizedPrice = product.LocalizedPrice;
            // ...
        }
    }
});
```

## サービス購入
- TOAST IAPは、ストアに登録されたサービスIDを使用してサービスを購入できます。
    - サービスIDは、サービスリスト照会時に取得できます。
- サービス購入結果は、初期化時に登録したPurchaseUpdateListenerを通して返されます。
    - 購入結果は[IapPurchase](./iap-unity/#iappurchase)を返します。

### サービス購入API仕様

```csharp
public static void Purchase(string productId);
```

### サービス購入例

```csharp
var productId = userSelectedProductId;
ToastIap.Purchase(productId);
```

## 未消費決済照会
- まだ消費されていない消費性サービス情報を照会します。
    - 未消費決済照会の結果は[IapPurchase](./iap-unity/#iappurchase)オブジェクトのリストで返されます。
- ユーザーにサービスを支給された後[Consume API](../../../Mobile%20Service/IAP/ko/api-guide-for-toast-sdk/#consume-api)を使用してサービスを消費します。

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

## 有効になっている購読照会
- User ID基準で有効になっている購読サービスを照会できます。
    - 決済が完了した購読サービスは、使用期間が残っている場合、継続して照会できます。
    - 有効になっている購読照会の結果は[IapPurchase](./iap-unity/#iappurchase)オブジェクトのリストで返されます。
- Androidで購読したサービスをiOSでも、またはiOSで購読したサービスをAndroidでも照会できます。

### 有効になっている購読照会API仕様

```csharp
public static void RequestActivePurchases(ToastCallback<List<IapPurchase>> callback);
```

### 有効になっている購読照会例

```csharp
ToastIap.RequestActivePurchases((result, purchases) =>
{
    if (result.IsSuccessful)
    {
        // 有効になっている購読照会成功
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
| Products | List<IapProduct> | 使用可能なサービス情報を返します。 |
| InvalidProducts | List<IapProduct> | TOAST IAPコンソールにサービスを登録しましたが、ストアに登録されていないサービスを返します。 |


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
| Id | string | サービスのID |
| Name | string | サービス名 |
| ProductType | string | サービスタイプ |
| IsActive | bool | サービスが有効になっているか |
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
| ProductId | string | サービスID | 
| ProductType | string | サービスタイプ | 
| UserId | string | ユーザーID | 
| Price | float | 価格 | 
| PriceCurrencyCode | string | 通貨情報 | 
| AccessToken | string | 消費に使用されるトークン | 
| PurchaseTime | long | サービス購入時間 | 
| ExpiryTime | long | 購読サービスの残り時間 | 


## FAQ
### Android

#### Question.1
**購入中(または購入完了直後)にアプリをバックグラウンドに変更し、アプリアイコンでアプリを再び起動するとユーザーキャンセルエラーがコールバックで返されます。どうしたらいいですか？**

#### Answer.1
UnityアクティビティのlaunchModeがsingleTaskのため発生する問題です。決済ウィンドウが破壊されるとユーザーキャンセルと認識するため、ユーザーキャンセルエラーが返されます。
もしストアで決済が完了した状態なら、アプリを再起動するか未消費決済照会を呼び出すことで再処理できます。再処理が完了すると、ユーザーにアイテムを支給できるようになります。
再処理ができていない状態で再度決済を試行すると、すでに保有中のサービスというエラーが返されます。(これによりユーザーの重複決済を回避することができます)
