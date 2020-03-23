## TOAST > TOAST SDK使用ガイド > TOAST IAP > Android

## 事前準備

1\. [TOAST SDK](./getting-started-android)をインストールします。
2\. [TOASTコンソール](https://console.cloud.toast.com)で[IAPサービスを有効化](https://docs.toast.com/ko/Mobile%20Service/IAP/ko/console-guide/#iap-appkey)します。
3\. IAPコンソールで[AppKeyを確認](https://docs.toast.com/ko/Mobile%20Service/IAP/ko/console-guide/#appkey)します。

## ストア別アプリ内決済ガイド

- [Android Developersアプリ内決済](https://developer.android.com/google/play/billing)
- [ONE storeアプリ内決済API V5 (SDK V17)案内およびダウンロード](https://dev.onestore.co.kr/devpoc/reference/view/IAP_v17)

## ライブラリ設定

- Google Play Storeのアプリ内決済を使用するには、下記のようにbuild.gradleに依存性を追加します。

```groovy
dependencies {
    implementation 'com.toast.android:toast-iap-google:0.21.0'
    ...
}
```

- ONE storeのアプリ内決済を使用するには、下記のようにbuild.gradleに依存性を追加します。

```groovy
dependencies {
    implementation 'com.toast.android:toast-iap-onestore:0.21.0'
    ...
}
```

## AndroidManifest設定

### ONE store購入画面設定（オプション）

ONE storeは全決済画面とポップアップ決済画面をサポートします。
AndroidManifest.xmlにmeta-dataを追加して、全決済画面（"full"）またはポップアップ決済画面（"popup"）を選択することができます。
メタデータが設定されていない場合は、デフォルト（ "full"）が適用されます。

```xml
<application
  ...>
  <meta-data android:name="iap:view_option" android:value="popup | full"/>
</application>
```

| 決済画面 | 設定値 |
| -- | -- |
| 全決済画面 | "full" |
| ポップアップ決済画面 | "popup" |

詳細については、[ワンストア決済画面設定]（https://dev.onestore.co.kr/devpoc/reference/view/IAP_v17_04_preparation#HAndroidManifestD30CC77CC124C815）を確認してください。

## ストアコード

| ストア       | コード       |
| ----------- | ---------- |
| Google Play | "GG"       |
| ONE store   | "ONESTORE" |

> [参考]ストアコードは[IapStoreCode](./iap-android/#iapstorecode)クラスに定義されています。

## 商品の種類

- 現在サポートしている商品の種類は3本で、消費性商品、サブスクリプションの商品、消費性のサブスクリプションの商品があります。

| 商品名   | 商品タイプ           | 説明                                   |
| ------ | ---------------- | -------------------------------------- |
| 消費性商品 | "CONSUMABLE"     | 消費可能な一回性商品。ゲーム内マネー、メディアファイルなどがあります。 |
| 購読商品 | "AUTO_RENEWABLE" | 指定された間隔および価格で決済が自動的に繰り返される商品。 <br>オンライン雑誌および音楽ストリーミングサービスなどがあります。 |
| Consumable Subscription Products | "CONSUMABLE_AUTO_RENEWABLE" | 소비가 가능한 구독 상품<br>정기적으로 게임내 재화, 아이템 등을 지급하는 결제 방식입니다. |

> Note :Subscription products and Consumable subscription products are supported by Google Play Store only.

## アプリ内決済設定

* [ToastIapConfiguration](./iap-android/#toastiapconfiguration)オブジェクトは、アプリ内決済設定情報を含んでいます。
* [ToastIapConfiguration](./iap-android/#toastiapconfiguration)オブジェクトは、[ToastIapConfiguration.Builder](./iap-android/#toastiapconfigurationbuilder)を使用して作成できます。
* IAPコンソールで発行された[AppKey](https://docs.toast.com/ko/Mobile%20Service/IAP/ko/console-guide/#appkey)を、setAppKeyメソッドを使用して設定します。
* setStoreCodeメソッドを使用して、アプリ内決済に使用する[ストアコード](./iap-android/#_3)を設定します。

### アプリ内決済設定例

```java
ToastIapConfiguration configuration =
    ToastIapConfiguration.newBuilder(getApplicationContext())
                .setAppKey(YOUR_APP_KEY)
                .setStoreCode(IapStoreCode.GOOGLE_PLAY_STORE)
                .build();
```

## アプリ内決済の初期化

- ToastIap.initialize()メソッドを呼び出してTOAST IAPを初期化します。

### アプリ内決済初期化API仕様

* アプリ内決済は、ToastIap.initializeメソッドを使用して初期化します。
* ToastIap.initializeメソッドは、[ToastIapConfiguration.Builder](./iap-android/#toastiapconfigurationbuilder)で作成された[ToastIapConfiguration](./iap-android/#toastiapconfiguration)オブジェクトをパラメータに使用します。

```java
/* ToastIap.java */
public static void initialize(ToastIapConfiguration configuration)
```

| Parameters    |                                    |
| ------------- | ---------------------------------- |
| configuration | ToastIapConfiguration：アプリ内決済設定情報 |

### アプリ内決済初期化例

- ToastIapを初期化します。

> [参考]初期化は、必ずApplication#onCreateで進行する必要があります。

```java
public class MainApplication extends Application {
    @Override
    public void onCreate() {
        super.onCreate();
        initializeToastIap();
    }

    /**
     * ToastIapを初期化します。
     */
    private void initializeToastIap() {
        ToastIapConfiguration configuration = ToastIapConfiguration.newBuilder(getApplicationContext())
                .setAppKey(YOUR_APP_KEY)
                .setStoreCode(IapStoreCode.GOOGLE_PLAY_STORE)
                .build();
        ToastIap.initialize(configuration);
    }
}
```

## サービスログイン

* TOAST SDKで提供するすべてのサービス(IAP、Log & Crashなど)は、1つの同じユーザーIDを使用します。
    * [ToastSdk.setUserId](https://docs.toast.com/ko/TOAST/ko/toast-sdk/getting-started-android/#userid)でユーザーIDを設定できます。
    * ユーザーIDを設定していない場合、決済が行われません。
* サービスログイン段階でユーザーID設定、未消費決済履歴照会、有効になっている購読商品照会機能を導入することを推奨します。

### ログイン

```java
// Login.
ToastSdk.setUserId(userId);
```

### ログアウト

```java
// Logout.
ToastSdk.setUserId(null);
```

> [参考]サービスログアウト時に、必ずユーザーIDをnullに設定してください。プロモーションコードが使われたり、決済再処理動作時に誤ったユーザーIDで購入が行われることを防止できます。

## 決済アップデートリスナー登録

* 決済結果は、ToastIapに設定された[IapService.PurchasesUpdatedListener](./iap-android/#iapservicepurchasesupdatedlistener)を通して通知されます。
* 決済アップデートリスナーは、ToastIap.registerPurchasesUpdatedListenerメソッドを使用して登録できます。
* [IapService.PurchasesUpdatedListener](./iap-android/#iapservicepurchasesupdatedlistener)を通して伝達された[IapPurchaseResult](./iap-android/#iappurchaseresult)リストから決済情報を確認できます。

> [参考]決済アップデートリスナーは、Activity.onCreate()で登録し、Activity.onDestroy()で解除する必要があります。

### 決済アップデートリスナー登録API仕様

```java
/* ToastIap.java */
public static void registerPurchasesUpdatedListener(IapService.PurchasesUpdatedListener listener)
public static void unregisterPurchasesUpdatedListener(IapService.PurchasesUpdatedListener listener)
```

| Method                             | Parameters |                                          | Description            |
| ---------------------------------- | ---------- | ---------------------------------------- | ---------------------- |
| registerPurchasesUpdatedListener   | listener   | IapService.<br>PurchasesUpdatedListener: <br>決済アップデートリスナー | 決済アップデートリスナーを登録します。    |
| unregisterPurchasesUpdatedListener | listener   | IapService.<br>PurchasesUpdatedListener: <br>登録解除するリスナー | 決済アップデートリスナー登録を解除します。 |

#### 決済アップデートリスナーの登録例

```java
public class MainActivity extends AppCompatActivity {
    /**
     * アプリ内で消費性商品、購読、プロモーション商品を購入した時、結果を通知します。
     */
    private IapService.PurchasesUpdatedListener mPurchaseUpdatedListener =
            new IapService.PurchasesUpdatedListener() {
                @Override
                public void onPurchasesUpdated(@NonNull List<IapPurchaseResult> purchaseResults) {
                    for (IapPurchaseResult purchaseResult : purchaseResults) {
                        if (purchaseResult.isSuccess()) {
                            // 成功
                            IapPurchase purchase = purchaseResult.getPurchase();
                        } else {
                            // 失敗
                        }
                    }
                }
            };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // onCreateが呼び出された時、Listenerを登録します。
        ToastIap.registerPurchasesUpdatedListener(mPurchaseUpdatedListener);
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        // onDestroy()が呼び出された時、必ずListenerを削除します。
        ToastIap.unregisterPurchasesUpdatedListener(mPurchaseUpdatedListener);
    }
}
```

> [참고] 결제 결과가 IapService.PurchasesUpdatedListener로 통지되기 전 Activity가 종료되면 결제 데이터가 유실될 수 있습니다.
> 결제를 안전하게 처리하기 위해 결제 결과를 통지받기 전, 사용자가 Activity를 종료(백 버튼 또는 종료 버튼 클릭)할 수 없도록 해야 합니다.

## 商品リスト照会

* IAPコンソールに登録された商品のうち、使用可能な商品リストを照会します。
* IAPコンソールに登録された商品のうち、購入可能な商品は[IapProductDetails](./iap-android/#iapproductdetails)リスト(Product Details List)で返されます。
* IAPコンソールに登録された商品のうち、ストアに登録されていない商品は[IapProduct](./iap-android/#iapproduct)リスト(Invalid Product List)で返されます。

### 商品リスト照会API仕様

```java
/* ToastIap.java */
public static void queryProductDetails(Activity activity,
                                       IapService.ProductDetailsResponseListener listener)
```

| Method              | Parameters |                                          |
| ------------------- | ---------- | ---------------------------------------- |
| queryProductDetails | activity   | Activity: 現在有効になっているActivity               |
|                     | listener   | IapService.<br>ProductDetailsResponseListener: <br>商品照会結果リスナー |


### 商品リスト照会例

```java
/**
 * 購入可能な商品を照会します。
 * <p>
 * productDetails ：購入可能な商品リスト
 * invalidProducts ：TOAST IAPコンソールに商品を登録しましたが、ストアに登録されていない商品
 */
void queryProductDetails() {
    IapService.ProductDetailsResponseListener responseListener =
            new IapService.ProductDetailsResponseListener() {
                @Override
                public void onProductDetailsResponse(@NonNull IapResult result,
                                                     @Nullable List<IapProductDetails> productDetails,
                                                     @Nullable List<IapProduct> invalidProducts) {
                    if (result.isSuccess()) {
                        // 照会成功
                    } else {
                        // 照会失敗
                    }
                }
            }

    ToastIap.queryProductDetails(MainActivity.this, responseListener);
}
```

## 商品購入

* TOAST IAPは、ストアに登録された商品IDを使用して商品を購入できます。
* 商品情報はToastIap.queryProductDetails()メソッドを呼び出して返された[IapProductDetails](./iap-android/#iapproductdetails)オブジェクトに含まれています。
* 商品IDは、IapProductDetails.getProductId()メソッドを使用して獲得できます。
* 商品購入は[IapPurchaseFlowParams](./iap-android/#iappurchaseflowparams)オブジェクトに商品IDを設定した後、ToastIap.launchPurchaseFlow()メソッドを通して購入ステップを開始します。
* [IapPurchaseFlowParams](./iap-android/#iappurchaseflowparams)オブジェクトは、[IapPurchaseFlowParams.Builder](./iap-android/#iappurchaseflowparamsbuilder)を使用して作成できます。
* 商品購入結果は、ToastIapに登録した[IapService.PurchasesUpdatedListener](./iap-android/#iapservicepurchasesupdatedlistener)を通して返されます。

### 商品購入IAP仕様

```java
/* ToastIap.java */
public static void launchPurchaseFlow(Activity activity,
                                      IapPurchaseFlowParams params)
```

| Method             | Parameters |                                   |
| ------------------ | ---------- | --------------------------------- |
| launchPurchaseFlow | activity   | Activity: 現在有効になっているActivity        |
|                    | params     | IapPurchaseFlowParams:購入情報パラメータ |

### 商品購入例

```java
/**
 * 商品を購入します。
 */
void launchPurchaseFlow(Activity activity, String productId) {
    IapPurchaseFlowParams params = IapPurchaseFlowParams.newBuilder()
            .setProductId(productId)
            .build();
    ToastIap.launchPurchaseFlow(activity, params);
}
```
##ユーザーデータ設定

* TOAST IAPは、購入要求時にユーザー情報を追加することができます。
*ユーザー情報は、IapPurchaseFlowParams.BuilderのsetDeveloperPayloadメソッドに設定します。
*固定されたユーザー情報は、未消費決済照会とアクティブなサブスクリプション照会時に返される[IapPurchase](./iap-android / #iappurchase)のgetDeveloperPayloadメソッドで確認できます。

``java
String userData = "userData"
IapPurchase FlowParams params = IapPurchase FlowParams.newBuilder()
.setProductId(productId)
.setDeveloperPayload(userData)
.build()
ToastIap. launchPurchase Flow(activity、params)
````

Googleプレイストアでプロモーションコードで商品を購入した場合は、ユーザーデータは利用できません。

## 未消費決済照会

* まだ消費されていない一回の商品(CONSUMABLE)と消費性購読商品(CONSUMABLE_AUTO_RENEWABLE)情報を照会します。
* ユーザーに商品を支給した後、[Consume API](https://docs.toast.com/en/Mobile%20Service/IAP/en/api-guide-for-toast-sdk/#consume-api)を使用して商品を消費します。
* 未消費決済は、ToastIap.queryConsumablePurchases()メソッドを使用して照会できます。
* 照会結果は、[IapService.PurchasesResponseListener](./iap-android/#iapservicepurchasesresponselistener)を通して[IapPurchase](./iap-android/#iappurchase)オブジェクトリストで返されます。

### 未消費決済照会API仕様

```java
/* ToastIap.java */
public static void queryConsumablePurchases(Activity activity,
                                            IapService.PurchasesResponseListener listener)
```

| Method                   | Parameters |                                          |
| ------------------------ | ---------- | ---------------------------------------- |
| queryConsumablePurchases | activity   | Activity: 現在有効になっているActivity               |
|                          | listener   | IapService.PurchasesResponseListener: <br>未消費購入履歴照会結果リスナー |

### 未消費決済照会例

```java
/**
 * 未消費決済履歴を照会します。
 */
void queryConsumablePurchases() {
    PurchasesResponseListener responseListenr =
            new IapService.PurchasesResponseListener() {
                @Override
                public void onPurchasesResponse(@NonNull IapResult result,
                                                @Nullable List<IapPurchase> purchases) {
                    if (result.isSuccess()) {
                        // 成功
                    } else {
                        // 失敗
                    }
                }
            };
    ToastIap.queryConsumablePurchases(MainActivity.this, responseListenr);
}
```

## 有効になっている購読の照会

* User IDベースで有効になっている購読商品(AUTO_RENEWABLE & CONSUMABLE_AUTO_RENEWABLE)を照会できます。
* 決済が完了した購読商品は、使用期間が残っている場合、継続して照会できます。
* 有効になっている購読は、ToastIap.queryActivatedPurchases()メソッドを使用して照会できます。
* 照会結果は、[IapService.PurchasesResponseListener](./iap-android/#iapservicepurchasesresponselistener)を通して[IapPurchase](./iap-android/#iappurchase)オブジェクトリストに返されます。
* iOSで購読した商品をAndroidでも照会可能です。

> 現在、購読商品はGoogle Playストアのみサポートします。

### 有効になっている購読照会API仕様

```java
/* ToastIap.java */
public static void queryActivatedPurchases(Activity activity,
                                           PurchasesResponseListener listener)
```

| Method                  | Parameters |                                          |
| ----------------------- | ---------- | ---------------------------------------- |
| queryActivatedPurchases | activity   | Activity: 現在有効になっているActivity               |
|                         | listener   | IapService.PurchasesResponseListener: <br>有効になっている購読照会結果リスナー |

### 有効になっている購読照会例

```java
/**
 * 有効になっている購読商品照会
 */
void queryActivatedPurchases() {
    PurchasesResponseListener responseListener =
            new IapService.PurchasesResponseListener() {
                @Override
                public void onPurchasesResponse(@NonNull IapResult result,
                                                @Nullable List<IapPurchase> purchases) {
                    if (result.isSuccess()) {
                        // 成功
                    } else {
                        // 失敗
                    }
                }
            };
    ToastIap.queryActivatedPurchases(MainActivity.this, responseListener);
}
```

## TOAST IAP Class Reference

### ToastIapConfiguration

TOAST IAP初期化メソッドのパラメータに使用されるアプリ内決済設定情報です。

```java
/* ToastIapConfiguration.java */
public String getAppKey();
public String getStoreCode();
```

| Method       | Returns |                                     |
| ------------ | ------- | ----------------------------------- |
| getAppKey    | String  | IAPサービスアプリキー                        |
| getStoreCode | String  | ストアコード情報("GG" or "ONESTORE", ...) |

### ToastIapConfiguration.Builder

IAPサービスアプリキー、ストア種類などを入力し、[ToastIapConfiguration](./iap-android/#toastiapconfiguration)オブジェクトを作成します。

```java
/* ToastIapConfiguration.java */
public void setAppKey(String appKey)
public void setStoreCode(String storeCode)
```

| Method       | Parameters |                     | Description                              |
| ------------ | ---------- | ------------------- | ---------------------------------------- |
| setAppKey    | appKey     | String: IAPサービスアプリキー | TOAST IAPコンソールで作成したアプリキーを設定します。      |
| setStoreCode | storeCode  | String: ストアコード情報 | ストアコードを設定します。<br>("GG" or "ONESTORE", ...) |

### IapStoreCode

```java
/* IapStoreCode.java */
String GOOGLE_PLAY_STORE
String ONE_STORE
```

* GOOGLE_PLAY_STORE<br>Google Playストアアプリ内決済を使用します。<br>Constant Value: "GG"
* ONE_STORE<br>ONE storeアプリ内決済を使用します。<br>Constant Value: "ONESTORE"

### IapPurchaseResult

* 決済結果および決済情報を含むオブジェクトです。

```java
/* IapPurchaseResult.java */
public IapPurchase getPurchase()
public boolean isSuccess()
public boolean isFailure()
public int getCode()
public String getMessage()
public Throwable getCause()
```

| Method      | Returns     |                                  |
| ----------- | ----------- | -------------------------------- |
| getPurchase | IapPurchase | 決済情報があるIapPurchaseオブジェクトを返します。 |
| getCode     | int         | 決済結果コードを返します。                 |
| getMessage  | String      | 決済結果メッセージを返します。                |
| getCause    | Throwable   | 決済失敗原因を返します。                 |
| isSuccess   | boolean     | 決済に成功したかを返します。                 |
| isFailure   | boolean     | 決済に失敗したかを返します。                 |

### IapResult

```java
/* IapResult.java */
public boolean isSuccess()
public boolean isFailure()
public int getCode()
public String getMessage()
public Throwable getCause()
```

| Method     | Returns   |                |
| ---------- | --------- | -------------- |
| getCode    | int       | 結果コードを返します。  |
| getMessage | String    | 結果メッセージを返します。 |
| getCause   | Throwable | 失敗原因を返します。  |
| isSuccess  | boolean   | 成功したかを返します。  |
| isFailure  | boolean   | 失敗したかを返します。  |

### IapPurchase

* IapPurchaseオブジェクトで、決済情報を確認できます。

```java
/* IapPurchase.java */
public String getPaymentId()
public String getOriginalPaymentId()
public String getPaymentSequence()
public String getProductId()
public String getProductType()
public String getUserId()
public float getPrice()
public String getPriceCurrencyCode()
public String getAccessToken()
public String getPurchaseType()
public String getPurchaseTime()
public String getExpiryTime()
```

| Method               | Returns |                      |
| -------------------- | ------- | -------------------- |
| getPaymentId         | String  | 決済IDを返します。        |
| getOriginalPaymentId | String  | 原本決済IDを返します。     |
| getPaymentSequence   | String  | 決済固有番号を返します。     |
| getProductId         | String  | 商品IDを返します。        |
| getProductType       | String  | 商品タイプを返します。        |
| getUserId            | String  | ユーザーIDを返します。       |
| getPrice             | float   | 価格情報を返します。        |
| getPriceCurrencyCode | String  | 通貨情報を返します。        |
| getAccessToken       | String  | 消費に使用されるトークンを返します。  |
| getPurchaseType      | String  | 商品タイプを返します。        |
| getPurchaseTime      | long    | 商品購入時間を返します。     |
| getExpiryTime        | long    | 購読商品の残り時間を返します。 |

### IapProductDetails

* IapProductDetailsオブジェクトで、商品詳細情報を確認できます。
* TOAST IAPコンソールに登録された情報とGoogle PlayコンソールまたはONE store Developerに登録された詳細な情報を含みます。

```java
/* IapProductDetails.java */
public String getProductId()
public String getProductSequence()
public float getPrice()
public String getLocalizedPrice()
public String getPriceCurrencyCode()
public long getPriceAmountMicros()
public String getFreeTrialPeriod()
public String getSubscriptionPeriod()
public String getProductType()
public String getProductTitle()
public String getProductDescription()
public boolean isActivated()
```

| Method                | Returns |                 |
| --------------------- | ------- | --------------- |
| getProductId          | String  | 商品のID          |
| getProductSequence    | String  | 商品固有番号      |
| getPrice              | float   | 価格            |
| getLocalizedPrice     | String  | 現地価格         |
| getPriceCurrencyCode  | String  | 通貨             |
| getPriceAmountMicros  | long    | 1,000,000単位価格|
| getFreeTrialPeriod    | String  | 無料使用期間      |
| getSubscriptionPeriod | String  | 購読期間         |
| getProductType        | String  | 商品タイプ         |
| getProductTitle       | String  | 商品タイトル(title)    |
| getProductDescription | String  | 商品説明         |
| isActivated           | boolean | 商品が有効になっているか      |

### IapProduct

* TOAST IAPコンソールに登録された簡略な情報を確認できます。

```java
/* IapProduct.java */
public String getProductId()
public String getProductSequence()
public String getProductType()
public String getProductTitle()
public String getProductDescription()
public boolean isActivated()
```

| Method                | Returns |              |
| --------------------- | ------- | ------------ |
| getProductId          | String  | 商品のID       |
| getProductSequence    | String  | 商品固有番号   |
| getProductType        | String  | 商品タイプ      |
| getProductTitle       | String  | 商品タイトル(title) |
| getProductDescription | String  | 商品説明      |
| isActivated           | boolean | 商品が有効になっているか   |

### IapPurchaseFlowParams

* IapPurchaseFlowParamsは、購入しようとする商品情報を含みます。

```java
/* IapPurchaseFlowParams.java */
public String getProductId()
```

| Method       | Returns |       |
| ------------ | ------- | ----- |
| getProductId | String  | 商品ID |

### IapPurchaseFlowParams.Builder

* IapPurchaseFlowParamsオブジェクトを作成します。

```java
/* IapPurchaseFlowParams.java */
public void setProductId(String productId)
```

| Method       | Parameters |               | Description   |
| ------------ | ---------- | ------------- | ------------- |
| setProductId | productId  | String: 商品ID | 商品IDを設定します。 |

### IapService.PurchasesUpdatedListener

* 決済情報がアップデートされた時、IapService.PurchasesUpdatedListenerを継承実装したオブジェクトのonPurchasesUpdatedメソッドを通して通知されます。

```java
void onPurchasesUpdated(List<IapPurchaseResult> purchaseResults)
```

### IapService.PurchasesResponseListener

* 未消費決済照会または有効化された購読の照会時、IapService.PurchasesResponseListenerを継承実装したオブジェクトのonPurchasesResponseメソッドを通して通知されます。

```java
void onPurchasesResponse(IapResult result,
                         List<IapPurchase> purchaseList)
```

## エラーコード

### 共通エラーコード

| RESULT                 | CODE | DESC                                     |
| ---------------------- | ---- | ---------------------------------------- |
| FEATURE_NOT_SUPPORTED  | -2   | 要請した機能はサポートしません。<br>Requested feature is not supported. |
| SERVICE_DISCONNECTED   | -1   | ストアサービスに接続できませんでした。<br>Store service is not connected. |
| OK                     | 0    | 成功。<br>Success.                          |
| USER_CANCELED          | 1    | ユーザーキャンセル。<br>User canceled.                |
| SERVICE_UNAVAILABLE    | 2    | ネットワークが接続されませんでした。<br>Network connection is down. |
| BILLING_UNAVAILABLE    | 3    | 要請されたタイプに対して、API Versionがサポートされていません。<br>API version is not supported for the type requested. |
| PRODUCT_UNAVAILABLE    | 4    | 要請した商品を使用できません。<br>Requested product is not available. |
| DEVELOPER_ERROR        | 5    | 無効な引数がAPIに提供されました。開発段階で発生するエラーです。<br>Developer error. |
| ERROR                  | 6    | API作業中に深刻なエラーが発生しました。<br>Fatal error during the API action. |
| PRODUCT_ALREADY_OWNED  | 7    | すでに所持している商品のため、購入できませんでした。<br>Failure to purchase since item is already owned. |
| PRODUCT_NOT_OWNED      | 8    | 所持していない商品のため、消費できません。<br>Failure to consume since item is not owned. |
| USER_ID_NOT_REGISTERED | 9    | ユーザーIDが登録されていません。<br>User ID Is not registered. |
| UNDEFINED_ERROR        | 9999 | 定義されていないエラー<br>Undefined error.           |

### サーバーエラーコード

| RESULT                 | CODE | DESC                                     |
| ---------------------- | ---- | ---------------------------------------- |
| INACTIVATED_APP        | 101  | 有効になっていないアプリです。<br>App is not active.     |
| NETOWRK_NOT_CONNECTED  | 102  | ネットワークが接続されていません。<br>Network not connected. |
| VERIFY_PURCHASE_FAILED | 103  | 決済の検証に失敗しました。<br>Failure to verify purchase. |
| CONSUMED_PURCHASE      | 104  | すでに消費した購入です。<br>Purchase already consumed. |
| REFUNDED_PURCHASE      | 105  | 返金された購入です。<br>Purchase already refunded. |

### ONE storeエラーコード

| RESULT                   | CODE | DESC                                     |
| ------------------------ | ---- | ---------------------------------------- |
| ONESTORE_NEED_LOGIN      | 301  | ONE storeサービスにログインしていません。<br>ONE store service is not logged in. |
| ONESTORE_NEED_UPDATE     | 302  | ONE storeサービスがアップデートまたはインストールされませんでした。<br>ONE store service is not updated or installed. |
| ONESTORE_SECURITY_ERROR  | 303  | 正常ではないアプリで決済を要請しました。<br>Abnormal purchase request. |
| ONESTORE_PURCHASE_FAILED | 304  | 決済要請に失敗しました。<br>Purchase request failed. |
