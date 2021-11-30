## TOAST > TOAST SDK使用ガイド > TOAST IAP > Android

## 事前準備

1. [TOAST SDK](./getting-started-android)をインストールします。
2. [TOASTコンソール](https://console.cloud.toast.com)で[IAPサービスを有効化](https://docs.toast.com/ko/Mobile%20Service/IAP/ko/console-guide/#iap-appkey)します。
3. IAPコンソールで[AppKeyを確認](https://docs.toast.com/ko/Mobile%20Service/IAP/ko/console-guide/#appkey)します。

## ストア別アプリ内決済ガイド

- [Android Developersアプリ内決済](https://developer.android.com/google/play/billing)
- [ONE storeアプリ内決済API V5 (SDK V17)案内およびダウンロード](https://dev.onestore.co.kr/devpoc/reference/view/Tools)
- [Galaxy storeアプリ内課金APIのご案内とダウンロード](https://developer.samsung.com/iap/overview.html)
- [Amazon Appstoreアプリ内決済APIの案内とダウンロード](https://developer.amazon.com/docs/in-app-purchasing/iap-overview.html)

## ライブラリ設定

- Google Play Storeのアプリ内決済を使用するには、下記のようにbuild.gradleに依存性を追加します。

```groovy
repositories {
    google()
    mavenCentral()
}

dependencies {
    implementation 'com.toast.android:toast-iap-google:0.29.0'
    ...
}
```

- ONE storeのアプリ内決済を使用するには、下記のようにbuild.gradleに依存性を追加します。

```groovy
repositories {
    mavenCentral()
}

dependencies {
    implementation 'com.toast.android:toast-iap-onestore:0.29.0'
    ...
}
```

- Galaxy storeのアプリ内決済を使用するには、下記のようにbuild.gradleに依存性を追加します。

```groovy
repositories {
    mavenCentral()
}

dependencies {
    implementation 'com.toast.android:toast-iap-galaxy:0.29.0'
    ...
}
```

> Galaxy Store in-app purchases works on Android 4.3 (API level 18) or higher.

- Amazon Appstoreのアプリ内決済を使用するには、以下のようにbuild.gradleに依存関係を追加します。

```groovy
repositories {
    mavenCentral()
}

dependencies {
    implementation 'com.toast.android:toast-iap-amazon:0.29.0'
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

詳細については、[ワンストア決済画面設定]https://dev.onestore.co.kr/devpoc/reference/view/Tools）を確認してください。

### Android 11以上をターゲットにするアプリ(ONE store、Galaxy Store、Amazon Appstore)

Android 11では、ユーザーが端末にインストールした他のアプリをアプリが照会して、相互作用する方法を変更します。
Android 11以上をターゲットとするアプリでONE store、Galaxy StoreまたはAmazon Appstore決済を使用するには、以下のようにAndroidManifest.xmlに'queries'要素または権限を定義する必要があります。

#### ONE store

```xml
<queries>
    <intent>
        <action android:name="com.onestore.ipc.iap.IapService.ACTION" />
    </intent>
    <intent>
        <action android:name="android.intent.action.VIEW" />
        <data android:scheme="onestore" />
    </intent>
</queries>
```

#### Galaxy Store

```xml
<queries>
    <package android:name="com.sec.android.app.samsungapps" />
</queries>
```

### Amazon Appstore

Amazon Appstoreでは'queries'要素の代わりに権限を追加します。

```xml
<uses-permission
    android:name="android.permission.QUERY_ALL_PACKAGES"
    tools:ignore="QueryAllPackagesPermission" />
```

「queries」要素はAndroid Gradle Plugin 4.1以上で動作します。
以前のバージョンのAndroid Gradle Pluginを使用するには、[Android 11でパッケージ可視性のためにGradleビルド準備](https://android-developers.googleblog.com/2020/07/preparing-your-build-for-package-visibility-in-android-11.html)を参照してください。

> <span style="color:#e11d21">**注意!)**</span> QUERY_ALL_PACKAGES権限をGoogle Play Storeに適用しないように注意してください。

## ストアコード

| ストア      | コード      |
| ----------- | ---------- |
| Google Play | "GG"       |
| ONE store   | "ONESTORE" |
| Galaxy store | "GALAXY" |
| Amazon Appstore | "AMAZON" |

> [参考]ストアコードは[IapStoreCode](./iap-android/#iapstorecode)クラスに定義されています。

## 商品の種類

- 現在サポートしている商品の種類は3本で、消費性商品、サブスクリプションの商品、消費性のサブスクリプションの商品があります。

| 商品名  | 商品タイプ          | 説明                                  |
| ------ | ---------------- | -------------------------------------- |
| 消費性商品 | "CONSUMABLE"     | 消費可能な一回性商品。ゲーム内マネー、メディアファイルなどがあります。 |
| 購読商品 | "AUTO_RENEWABLE" | 指定された間隔および価格で決済が自動的に繰り返される商品。 <br>オンライン雑誌および音楽ストリーミングサービスなどがあります。 |
| Consumable Subscription Products | "CONSUMABLE_AUTO_RENEWABLE" | 消費が可能なサブスクリプション商品<br>定期的にゲーム内通貨、アイテムなどを支給する決済方式です。 |

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

> [参考]決済の結果がIapService.PurchasesUpdatedListenerで通知される前にActivityが終了すると、決済データが失われる場合があります。
> 決済を安全に処理するために、決済結果の通知を受け取る前にユーザーがActivityを終了(バックボタンまたは終了ボタンをタップ)できないようにする必要があります。

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
| queryProductDetails | activity   | Activity：現在有効になっているActivity               |
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
| launchPurchaseFlow | activity   | Activity：現在有効になっているActivity        |
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
| queryConsumablePurchases | activity   | Activity：現在有効になっているActivity               |
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
| queryActivatedPurchases | activity   | Activity：現在有効になっているActivity               |
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

## サブスクリプション状態照会

* 各User IDで購入したサブスクリプション商品の状態を照会できます。
* 有効期限が切れたサブスクリプション商品はincludeExpiredSubscriptions設定で照会または除外できます。 (default：false)
* サブスクリプション商品の状態はToastIap.querySubscriptionsStatus()メソッドを使用して照会できます。
* 照会結果は[IapService.SubscriptionsStatusResponseListener](./iap-android/#iapservicesubscriptionsstatusresponselistener)を介して[IapSubscriptionStatus](./iap-android/#iapsubscriptionstatus)オブジェクトリストを返します。
* [IapSubscriptionStatus](./iap-android/#iapsubscriptionstatus)使用するサブスクリプションステータスコードは[IapSubscriptionStatus.StatusCode](./iap-android/#iapsubscriptionstatusstatusCode)に定義されています。

```
現在サブスクリプション商品はGoogle Playストアのみサポートします。
```

### サブスクリプション状態照会APIの仕様

```java
/* ToastIap.java */
public static void querySubscriptionsStatus(Activity activity,
                                            boolean includeExpiredSubscriptions,
                                            IapService.SubscriptionsStatusResponseListener listener)
```

| Method | Parameters |  |
| --- | --- | --- |
| querySubscriptionsStatus | activity | Activity：現在有効になっているActivity |
|  | includeExpiredSubscriptions | boolean:<br>サブスクリプション有効期限切れのサブスクリプション商品の状態を含むかどうか |
|  | listener | IapService.SubscriptionsStatusResponseListener:<br>サブスクリプション状態照会結果リスナー |

### サブスクリプション状態照会例

```java
/**
 * サブスクリプション状態照会
 */
private void querySubscriptionsStatus() {
    SubscriptionsStatusResponseListener listener =
            new SubscriptionsStatusResponseListener() {
                @Override
                public void onSubscriptionsStatusResponse(@NonNull String storeCode,
                                                          @Nullable List<IapSubscriptionStatus> subscriptionsStatus) {
                    if (result.isSuccess()) {
                        // 成功
                    } else {
                        // 失敗
                    }
                }
            };
    ToastIap.querySubscriptionsStatus(MainActivity.this, false, listener);
}
```

## GooglePlayサブスクリプション(定期決済)機能

GooglePlayのサブスクリプション決済の更新および有効期限などのライフサイクルに応じたイベントを処理する方法を説明します。
詳細については[定期決済別機能追加](https://developer.android.com/google/play/billing/billing_subscriptions)を参照してください。

### サブスクリプションのライフサイクル処理

GooglePlayのサブスクリプションは、ライフサイクルの間にさまざまな状態変更を経て、アプリは各状態に応じて対応する必要があります。

* **アクティブ(Active)**：定期決済コンテンツにアクセスすることができ、自動更新が行われている状態
* **キャンセル(Cancelled)**：定期決済コンテンツにアクセスすることができるが、ユーザーがサブスクリプションキャンセルして自動更新が停止している状態
* **猶予期間(In grace period)**：決済方法の問題で定期決済が失敗したが、定期決済コンテンツにはアクセスすることができる状態(ユーザーが決済方法を変更するのを待っている状態)
* **アカウント保留(On hold)**：決済方法の問題で定期決済が失敗して保留状態(猶予期間を使用する設定になっている場合、猶予期間中に決済方法を変更しておらず、決済が保留になっている状態)
* **一時停止(Pause)**：定期決済商品を一時的に停止した状態
* **有効期限切れ(Expired)**：定期決済商品の期限が切れた状態

| 状態 | 未消費決済照会<br>(ToastIap.queryConsumablePurchases) | 有効なサブスクリプション照会<br>(ToastIap.queryActivatedPurchases) | 有効期限 | 自動更新するかどうか |
| --- | --- | --- | --- | --- |
| アクティブ(Active) | Yes | Yes | 未来の時間 | Yes |
| キャンセル(Cancelled) | Yes | Yes | 未来の時間 | No |
| 猶予期間(In grace period) | No | Yes | 未来の時間 | Yes |
| アカウント保留(On hold) | No | No | 過去の時間 | Yes |
| 一時停止(Pause) | No | No | 過去の時間 | Yes |
| 有効期限(Expired) | No | No | 過去の時間 | No |

### 猶予期間

猶予期間を使用する設定になっている場合、決済サイクルが終わる時に決済方法に問題があれば定期決済は猶予期間に切り替わります。
<span style="color:#e11d21">猶予期間中、ユーザーは定期決済コンテンツにアクセスできなければいけません。</span>
詳細については、[猶予期間](https://developer.android.com/google/play/billing/subs#grace)を参照してください。

> <span style="color:#e11d21">**注意！)**</span> 猶予期間中に決済方法の修正などで復元されると、自動更新を再開します。TOAST IAPは更新された決済の結果を決済アップデートリスナー(IapService.PurchaseUpdatedListener)を介して通知します。ゲームやアプリは重要な動作中に決済アップデートリスナーにより不要なポップアップがユーザーに表示されないように注意する必要があります。

#### 一般サブスクリプション商品(AUTO_RENEWABLE))

* 猶予期間中、一般サブスクリプション商品は定期決済コンテンツにアクセスできなければいけません。
* 猶予期間中、ToastIap.queryActivatedPurchases()で照会できます。

#### 消費性サブスクリプション商品(CONSUMABLE_AUTO_RENEWABLE)

* 猶予期間が始まると、Googleは新しい領収書を発行しますが、決済方法を修正しない場合はアカウント保留状態になったりキャンセルされます。
* 消費性サブスクリプション商品は、猶予期間中に商品を消費することができないようにToastIap.queryConsumablePurchases()で照会できません。

### アカウント保留

アカウント保留は、決済方法の問題で更新が失敗した時のユーザーの状態を指します。
決済に失敗した場合、猶予期間中に再試行を行い、猶予期間中にも決済が失敗した場合、定期決済状態は保留状態になります。
アカウント保留状態のユーザーは定期決済コンテンツにアクセスできません。
アカウント保留期間は最大30日です。
アカウント保留期間が終了する前に決済方法を修正しなかった場合、キャンセル処理されます。
詳細については、[アカウント保留](https://developer.android.com/google/play/billing/subs#account-hold)を参照してください。

> <span style="color:#e11d21">**注意！)**</span> アカウント保留期間中に決済方法の修正などで復元されると、自動更新を再開します。TOAST IAPは更新された決済の結果を決済アップデートリスナー(IapService.PurchaseUpdatedListener)を介して通知します。ゲームやアプリは重要な動作中に決済アップデートリスナーにより不要なポップアップがユーザーに表示されないように注意する必要があります。

#### 一般サブスクリプション商品(AUTO_RENEWABLE))

* アカウント保留期間中は、一般サブスクリプション商品は定期決済コンテンツにアクセスできません。
* アカウント保留期間中は、ToastIap.queryActivatedPurchases()で照会できません。

#### 消費性サブスクリプション商品(CONSUMABLE_AUTO_RENEWABLE)

* アカウント保留期間中に、消費性サブスクリプション商品は新しい購入を作成しません。
* アカウント保留期間中にToastIap.queryConsumablePurchases()で新しい購入が照会できません。

### 一時停止

一時停止機能を設定すると、ユーザーは定期決済を1週間から3か月の間、一時停止することができます。
定期決済の一時停止は、現在のサブスクリプション期間が終了した後に適用されます。
一時停止期間が終了すると定期決済が自動的に再開されます。
詳細については、[一時停止](https://developer.android.com/google/play/billing/subs#pause)を参照してください。

> <span style="color:#e11d21">**注意！)**</span> 一時停止期間が終了すると自動更新を再開します。TOAST IAPは更新された決済の結果を決済アップデートリスナー(IapService.PurchaseUpdatedListener)を介して通知します。ゲームやアプリは重要な動作中に決済アップデートリスナーにより不要なポップアップがユーザーに表示されないように注意する必要があります。

#### 一般サブスクリプション商品(AUTO_RENEWABLE))

* 一時停止期間中に一般サブスクリプション商品は定期決済コンテンツにアクセスできません。
* 一時停止期間中は、ToastIap.queryActivatedPurchases()で照会できません。

#### 消費性サブスクリプション商品(CONSUMABLE_AUTO_RENEWABLE)

* 一時停止期間中に消費性サブスクリプション商品は新しい購入を作成しません。
* 一時停止期間中にToastIap.queryConsumablePurchases()で新しい購入が照会できません。

### 定期決済の再申請

定期決済再申請機能を設定すると、ユーザーが定期決済の有効期限から12か月以内にキャンセルした定期決済を再申請できます。
定期決済の再申請は、新しい定期決済と購入トークンが作成されます。
定期決済の期限が切れた後、ユーザーはGoogle Play定期決済センターを介して期限が切れた後1年間、同じ商品を再購入することができます。
詳細については、[定期決済再申請](https://developer.android.com/google/play/billing/subs#resubscribe)を参照してください。

> <span style="color:#e11d21">**注意！)**</span> アプリやゲーム内画面で購入が行われないため、ユーザーデータ(IapPurchase.getDeveloperPayload())を使用できません。
> <span style="color:#e11d21">**注意！)**</span> Google Playストアにおいて、定期決済再申請でサブスクリプション商品を購入する場合、TOAST IAPは購入した決済の結果を決済アップデートリスナー(IapService.PurchaseUpdatedListener)を介して通知します。ゲームやアプリは重要な動作中に決済アップデートリスナーにより不要なポップアップがユーザーに表示されないように注意する必要があります。

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
| getAppKey    | String  | IAPサービスアプリキー                       |
| getStoreCode | String  | ストアコード情報("GG" or "ONESTORE", "GALAXY", ...) |

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
| setStoreCode | storeCode  | String：ストアコード情報 | ストアコードを設定します。<br>("GG" or "ONESTORE", "GALAXY", ...) |

### IapStoreCode

```java
/* IapStoreCode.java */
String GOOGLE_PLAY_STORE
String ONE_STORE
String GALAXY_STORE
String AMAZON_APP_STORE
```

* GOOGLE_PLAY_STORE<br>Google Playストアアプリ内決済を使用します。<br>Constant Value: "GG"
* ONE_STORE<br>ONE storeアプリ内決済を使用します。<br>Constant Value: "ONESTORE"
* GALAXY_STORE<br>Galaxy storeアプリ内決済を使用します。<br>Constant Value: "GALAXY"
* AMAZON_APP_STORE<br>Amazon Appstoreアプリ内決済を使用します。<br>Constant Value: "AMAZON"

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
| getProductSequence    | String  | 商品固有番号     |
| getPrice              | float   | 価格           |
| getLocalizedPrice     | String  | 現地価格        |
| getPriceCurrencyCode  | String  | 通貨            |
| getPriceAmountMicros  | long    | 1,000,000単位価格|
| getFreeTrialPeriod    | String  | 無料使用期間     |
| getSubscriptionPeriod | String  | 購読期間        |
| getProductType        | String  | 商品タイプ        |
| getProductTitle       | String  | 商品タイトル(title)    |
| getProductDescription | String  | 商品説明        |
| isActivated           | boolean | 商品が有効になっているか     |

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
| getProductSequence    | String  | 商品固有番号  |
| getProductType        | String  | 商品タイプ     |
| getProductTitle       | String  | 商品タイトル(title) |
| getProductDescription | String  | 商品説明     |
| isActivated           | boolean | 商品が有効になっているか  |

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
| setProductId | productId  | String：商品ID | 商品IDを設定します。 |

### IapSubscriptionStatus

* IapSubscriptionStatusオブジェクトでサブスクリプション状態情報を確認できます。
* サブスクリプションステータスコードはIapSubscriptionStatus.StatusCodeに定義されています。

```java
/* IapSubscriptionStatus.java */
public String getStoreCode()
public String getPaymentId()
public String getOriginalPaymentId()
public String getPaymentSequence()
public String getProductId()
public String getProductType()
public String getProductSequence()
public String getUserId()
public float getPrice()
public String getPriceCurrencyCode()
public String getAccessToken()
public String getPurchaseType()
public String getPurchaseTime()
public String getExpiryTime()
public String getDeveloperPayload()
public int getStatusCode()
public String getStatusDescription()
```

| Method | Returns |  |
| --- | --- | --- |
| getStoreCode | String | ストアコードを返します。 |
| getPaymentId | String | 決済IDを返します。 |
| getOriginalPaymentId | String | 元の決済IDを返します。 |
| getPaymentSequence | String | 決済固有番号を返します。 |
| getProductId | String | 商品IDを返します。 |
| getProductType | String | 商品タイプを返します。 |
| getProductSeq | String | 商品固有番号を返します。 |
| getUserId | String | ユーザーIDを返します。 |
| getPrice | float | 価格情報を返します。 |
| getPriceCurrencyCode | String | 通貨情報を返します。 |
| getAccessToken | String | 消費に使用されるトークンを返します。 |
| getPurchaseType | String | 決済タイプを返します。<br>"Test" or "Promo" or null |
| getPurchaseTime | long | 商品購入時間を返します。 |
| getExpiryTime | long | サブスクリプション商品の残り時間を返します。 |
| getDeveloperPayload | String | ユーザーデータを返します。 |
| getStatusCode | int | サブスクリプションのステータスコードを返します。 |
| getStatusDescription | String | サブスクリプションのステータスコードの説明を返します。 |

### IapSubscriptionStatus.StatusCode

* サブスクリプションの状態を表すコードです。

```java
/* IapSubscriptionStatus.java */
int ACTIVE
int CANCELED
int ON_HOLD
int IN_GRACE_PERIOD
int PAUSED
int REVOKED
int EXPIRED
int UNKNOWN
```

| Name | Code | Status | Description |
| --- | --- | --- | --- |
| ACTIVE | 0 | アクティブ | サブスクリプションがアクティブ状態です。 |
| CANCELED | 3 | キャンセル | サブスクリプションがキャンセルされました。 |
| ON\_HOLD | 5 | アカウント保留 | 定期決済がアカウント保留状態になりました(使用する設定になっている場合)。 |
| IN\_GRACE\_PERIOD | 6 | 猶予期間 | 定期決済が猶予期間状態になりました(使用する設定になっている場合)。 |
| PAUSED | 10 | 一時停止 | サブスクリプションが一時停止しました。 |
| REVOKED | 12 | 解約 | 定期決済が有効期限前にユーザーによってキャンセルされました。 |
| EXPIRED | 13 | 有効期限切れ | 定期決済の期限が切れました。 |
| UNKNOWN | 9999 | 未定義 | 定義されていない状態です。 |

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

### IapService.SubscriptionsStatusResponseListener

* サブスクリプションの状態を照会する時、SubscriptionsStatusResponseListenerを継承実装したオブジェクトのonSubscriptionsStatusResponseメソッドを介して通知されます。

```java
void onSubscriptionsStatusResponse(IapResult result,
                                   List<IapSubscriptionStatus> subscriptionsStatus);
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

| RESULT                    | CODE | DESC                                     |
| ------------------------- | ---- | ---------------------------------------- |
| INACTIVATED_APP           | 101  | 有効になっていないアプリです。<br>App is not active.     |
| NETWORK_NOT_CONNECTED     | 102  | ネットワークが接続されていません。<br>Network not connected. |
| VERIFY_PURCHASE_FAILED    | 103  | 決済の検証に失敗しました。<br>Failure to verify purchase. |
| PURCHASE_ALREADY_CONSUMED | 104  | すでに消費した購入です。<br>Purchase already consumed. |
| PURCHASE_ALREADY_REFUNDED | 105  | 返金された購入です。<br>Purchase already refunded. |
| PURCHASE_LIMIT_EXCEEDED   | 106  | 購入限度を超過しました。<br>Purchase limit exceeded. |

### ONE storeエラーコード

| RESULT                   | CODE | DESC                                     |
| ------------------------ | ---- | ---------------------------------------- |
| ONESTORE_NEED_LOGIN      | 301  | ONE storeサービスにログインしていません。<br>ONE store service is not logged in. |
| ONESTORE_NEED_UPDATE     | 302  | ONE storeサービスがアップデートまたはインストールされませんでした。<br>ONE store service is not updated or installed. |
| ONESTORE_SECURITY_ERROR  | 303  | 正常ではないアプリで決済を要請しました。<br>Abnormal purchase request. |
| ONESTORE_PURCHASE_FAILED | 304  | 決済要請に失敗しました。<br>Purchase request failed. |

### Galaxy storeエラーコード

| RESULT                   | CODE | DESC                                     |
| ------------------------ | ---- | ---------------------------------------- |
| GALAXY_NOT_LOGGED_IN      | 501  | Galaxy storeサービスにログインしていません。<br>Galaxy service is not logged in. |
| GALAXY_NOT_UPDATED     | 502  | Galaxy storeサービスがアップデートまたはインストールされませんでした。<br>Galaxy service is not updated or installed. |
| GALAXY_PURCHASE_FAILED  | 503  | 正常ではないアプリで決済を要請しました。<br>Galaxy purchase failed. |
| GALAXY_SERVICE_DENIED | 504  | 決済要請に失敗しました。<br>PurGalaxy service denied. |
