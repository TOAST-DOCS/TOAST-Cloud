## NHN Cloud > SDK使用ガイド > IAP > Unity

## Prerequisites

1. [Install the NHN Cloud SDK](./getting-started-unity)
2. [NHN Cloudコンソール](https://console.cloud.toast.com)で[Mobile Service \> IAPを有効化](https://docs.toast.com/ko/Mobile%20Service/IAP/ko/console-guide/)します。
3. IAPで[AppKeyを確認](https://docs.toast.com/ko/Mobile%20Service/IAP/ko/console-guide/#appkey)します。

## Android設定
### Gradleビルド設定
- Unity Editorで、Build Settingsウィンドウを開きます。 （Player Settings> Publishing Settings> Build）。
- Build SystemリストからGradleを選択します。
- Build Systemサブのチェックボックスを選択して、Custom Gradle Templateを使用します。
- mainTemplate.gradleのdependencies項目に下記の内容を追加します。

#### Google Play Store

```groovy
repositories {
  google()
  mavenCentral()
}

dependencies {
  implementation 'com.toast.android:toast-iap-google:0.29.2'
**DEPS**}
```

#### One Store

```groovy
repositories {
  mavenCentral()
}

dependencies {
  implementation 'com.toast.android:toast-iap-onestore:0.29.2'
**DEPS**}
```

#### Galaxy Store

```groovy
repositories {
  mavenCentral()
}

dependencies {
  implementation 'com.toast.android:toast-iap-galaxy:0.29.2'
**DEPS**}
```

#### Amazon Appstore

```groovy
repositories {
  mavenCentral()
}

dependencies {
  implementation 'com.toast.android:toast-iap-amazon:0.29.2'
**DEPS**}
```

#### Huawei App Gallery

- AppGallery Connection構成ファイル(agconnect-service.json)を追加します。
    - [AppGallery Connect](https://developer.huawei.com/consumer/en/service/josp/agc/index.html)にログインし、**マイプロジェクト**をクリックします。
    - プロジェクトでアプリを選択します。
    - **Project settings** > **General information**に移動します。
    - **App information**から**agconnect-service.json**ファイルをダウンロードします。
    - **agconnect-service.json** ファイルをアプリのルートディレクトリにコピーします。
- 以下のようにApp Gallery Connectプラグインと依存関係を設定します。

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
    classpath 'com.huawei.agconnect:agcp:1.6.0.300'
	}
}

repositories {
  mavenCentral()
}

apply plugin: 'com.android.application'
apply plugin: 'com.huawei.agconnect'

dependencies {
  implementation 'com.toast.android:toast-iap-huawei:0.29.2'
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

## NHN Cloud IAP SDK初期化
[ToastIapConfiguration](./iap-unity/#toastiapconfiguration)を利用してNHN Cloud IAPコンソールで発行されたAppKeyとストアコード([StoreCode](./iap-unity/#storecode))を設定します。
初期化と同時に購入結果を受け取れるPurchaseUpdateListenerを登録します。

> **初期化タイミング**
> NHN Cloud IAP SDKの初期化は、アプリ実行直後、最初の1回のみ行う必要があり、
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
- NHN Cloud SDKで提供するすべてのサービス(IAP, Log & Crashなど)は、1つの同じユーザーIDを使用します。
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
- NHN Cloud IAPは、ストアに登録された商品IDを使用して商品を購入できます。
    - 商品IDは、商品リスト照会時に取得できます。
- 商品購入結果は、初期化時に登録したPurchaseUpdateListenerを通して返されます。
    - 購入結果は[IapPurchase](./iap-unity/#iappurchase)を返します。

### 商品購入API仕様

```csharp
public static void Purchase(string productId, developerPayload = "");
```

- NHN Cloud IAPは購入リクエスト時にdeveloperPayloadを介してユーザー情報を追加できます。

### 商品購入例

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

## サブスクリプションの復元
- User IDごとにサブスクリプション商品を復元できます。
    - 決済が完了したサブスクリプション商品は、使用期間が残っている場合、継続して復元できます。
    - サブスクリプション商品の復元照会の結果は[IapPurchase](./iap-unity/#iappurchase)オブジェクトのリストで返されます。
- iOSでのみ購読した商品を復元できます。

### サブスクリプション復元APIの仕様

```csharp
public static void RequestRestorePurchases(ToastCallback<List<IapPurchase>> callback);
```

### サブスクリプションの復元例

```csharp
ToastIap.RequestRestorePurchases((result, purchases) =>
{
    if (result.IsSuccessful)
    {
        // サブスクリプションの復元照会成功
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

## サブスクリプション状態照会

- 各User IDで購入したサブスクリプション商品の状態を照会できます。
- サブスクリプション状態の照会結果は[IapSubscriptionStatus](./iap-android/#iapsubscriptionstatus)オブジェクトのリストで返されます。
- サブスクリプションの状態は[IapSubscriptionStatus](./iap-android/#iapsubscriptionstatus).GetStatus()メソッドで確認できます。
- サブスクリプションのステータスコードは[IapSubscriptionStatus.Status](./iap-android/#iapsubscriptionstatusstatus)に定義されています。

### サブスクリプション状態照会APIの仕様

```csharp
public static void RequestSubscriptionsStatus(
            bool includeExpiredSubscriptions,
            ToastCallback<List<IapSubscriptionStatus>> callback);
```

### サブスクリプションの状態照会例

```csharp
ToastIap.RequestSubscriptionsStatus(true, (result, subscriptionsStatus) =>
{
    if (result.IsSuccessful)
    {
        // 成功
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
| AppKey | string | IAPサービスアプリキーを設定します。 |
| StoreCode | StoreCode | ストアコードを設定します。 |


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
| GooglePlayStore | Google Play Store(Android Only) |
| AppleAppStore | Apple App Store(iOS Only) |
| OneStore | One Store(Android Only) |
| AmazonAppStore | Amazon Appstore (Android Only) |
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
| InvalidProducts | List<IapProduct> | NHN Cloud IAPコンソールに商品を登録しましたが、ストアに登録されていない商品を返します。 |


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
| GetProductId | string | 決済ID |
| GetProductType | string | 決済固有番号 |
| GetPaymentId | string | 元の決済ID |
| GetOriginalPaymentId | string | 商品ID |
| GetPaymentSequence | string | 商品タイプ |
| GetUserId | string | ユーザーID |
| GetPrice | float | 価格 |
| GetPriceCurrencyCode | string | 通貨情報 |
| GetAccessToken | string | 消費に使用されるトークン |
| GetPurchaseTime | long | 商品購入時間 |
| GetExpiryTime | long | サブスクリプション商品の残り時間 |
| GetDeveloperPayload | string | 開発者ペイロード |
| GetStatus | Status | サブスクリプションの状態 |
| GetStatusDescription | string | サブスクリプション状態の説明 |

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
| Active | 0 | アクティブ | サブスクリプションがアクティブ状態です。 |
| Canceled | 3 | キャンセル | サブスクリプションがキャンセルされました。 |
| OnHold | 5 | アカウント保留 | 定期決済がアカウント保留状態になりました(使用する設定になっている場合)。 |
| InGracePeriod | 6 | 猶予期間 | 定期決済が猶予期間状態に変わりました(使用する設定になっている場合)。 |
| Paused | 10 | 一時停止 | サブスクリプションが一時停止しました。 |
| Revoked | 12 | 解約 | 定期決済が有効期限前にユーザーによってキャンセルされました。 |
| Expired | 13 | 有効期限切れ | 定期決済の期限が切れました。 |
| Unknown | 9999 | 未定義 | 定義されていない状態です。 |

## エラーコード

### 共通エラーコード
| エラーコード | 説明 |
|---|---|
| 50000 | 初期化されていません |
| 50001 | サポートしていない機能です |
| 50002 | サポートしないストアコードです |
| 50003 | 使用できない商品です |
| 50004 | すでに所有している商品です |
| 50006 | ユーザーIDが間違っています |
| 50007 | ユーザーが決済をキャンセルしました |
| 50009 | 領収書の検証に失敗しました |
| 50011 | サブスクリプションの更新が失敗しました |
| 50015 | 所有していない商品です。 |
| 50103 | すでに消費した商品です。 |
| 50104 | すでに返金された商品です。 |
| 50105 | 購入限度を超過しました。 |
| 59999 | 不明なエラーです。エラーメッセージを確認してください。 |

### サーバーエラーコード

| エラーコード | 説明 |
|---|---|
| 10000 | 無効なリクエストです。 |
| 10002 | ネットワークが接続されていません。 |
| 10003 | サーバーレスポンスが失敗しました。 |
| 10004 | タイムアウトが発生しました。 |
| 10005 | 有効ではないサーバーレスポンス値です。 |
| 10010 | 有効になっていないアプリです。 |

### App storeエラーコード

| エラーコード | 説明 |
|---|---|
| 50005 | すでに進行中のリクエストがあります。 |
| 50008 | ストアで決済が失敗しました |
| 50010 | 購入状態の変更に失敗しました |
| 50012 | 返金により購入を進めることができません |
| 50013 | 復元に失敗しました。 |
| 50014 | 購入進行不可状態です。 (e.g. アプリ内の購入制限設定) |

### ONE storeエラーコード

| エラーコード | 説明 |
|---|---|
| 51000 | ONE storeサービスにログインしていません。 |
| 51001 | ONE storeサービスが更新またはインストールされていません。 |
| 51002 | 正常ではないアプリから決済をリクエストしました。 |
| 51003 | 決済のリクエストに失敗しました。 |

### Galaxy storeエラーコード

| エラーコード | 説明 |
|---|---|
| 53000 | Galaxy storeサービスにログインしていません。 |
| 53001 | Galaxy storeサービスが更新またはインストールされていません。 |
| 53002 | 正常ではないアプリから決済をリクエストしました。 |
| 51003 | 決済のリクエストに失敗しました。 |

## FAQ
### Android

#### Question.1
**購入中(または購入完了直後)にアプリをバックグラウンドに変更し、アプリアイコンでアプリを再び起動するとユーザーキャンセルエラーがコールバックで返されます。どうしたらいいですか？**

#### Answer.1
UnityアクティビティのlaunchModeがsingleTaskのため発生する問題です。決済ウィンドウが破壊されるとユーザーキャンセルと認識するため、ユーザーキャンセルエラーが返されます。
もしストアで決済が完了した状態なら、アプリを再起動するか未消費決済照会を呼び出すことで再処理できます。再処理が完了すると、ユーザーにアイテムを支給できるようになります。
再処理ができていない状態で再度決済を試行すると、すでに保有中の商品というエラーが返されます。(これによりユーザーの重複決済を回避することができます)
