## NHN Cloud > SDK 사용 가이드 > IAP > Android

<a id="prerequisites"></a>

## 事前準備

1. [NHN Cloud SDK](./getting-started-android)をインストールします。
2. [NHN Cloud コンソール](https://console.nhncloud.com)で [IAP サービスを有効化](/Mobile%20Service/IAP/ja/console-guide/)します。
3. IAP コンソールで [AppKey を確認](/Mobile%20Service/IAP/ja/console-guide/#appkey)します。

<a id="console-guide-for-stores"></a>

## ストア別コンソールガイド

- [Google コンソールガイド](/Mobile%20Service/IAP/ja/console-google-guide/)
- [ONE store コンソールガイド](/Mobile%20Service/IAP/ja/console-onestore-guide/)
- [Galaxy Store コンソールガイド](/Mobile%20Service/IAP/ja/console-galaxystore-guide/)
- [Mycard コンソールガイド](/Mobile%20Service/IAP/ja/mycard-guide/)
- [Amazon コンソールガイド](/Mobile%20Service/IAP/ja/console-amazon-guide/)
- [Huawei コンソールガイド](/Mobile%20Service/IAP/ja/console-huawei-guide/)

> Google Play でサブスクリプション商品を販売する場合は、[リアルタイムのサブスクリプション状態を受信するための Google 通知設定](/Mobile%20Service/IAP/ja/console-google-guide/#google_1)を行う必要があります。

<a id="in-app-purchase-guide-for-each-store-type"></a>

## ストア別アプリ内課金ガイド

- [Android Developers アプリ内課金](https://developer.android.com/google/play/billing)
- [ONE store アプリ内課金 API V7（SDK V21）案内およびダウンロード](https://onestore-dev.gitbook.io/dev/tools/tools)
- [Galaxy Store アプリ内課金 API 案内およびダウンロード](https://developer.samsung.com/iap/overview.html)
- [Amazon Appstore アプリ内課金 API 案内およびダウンロード](https://developer.amazon.com/docs/in-app-purchasing/iap-overview.html)
- [Huawei App Gallery アプリ内課金 API 案内およびダウンロード](https://developer.huawei.com/consumer/kr/hms/huawei-iap)

<a id="library-setting"></a>

## ライブラリ設定

<a id="google-play-store"></a>

### Google Play Store

- Google Play Store のアプリ内課金を使用するには、以下のように build.gradle に依存性を追加します。

```groovy
repositories {
    google()
    mavenCentral()
}

dependencies {
    implementation 'com.nhncloud.android:nhncloud-iap-google:1.12.0'
    ...
}
```

<a id="one-store"></a>

### ONE store

- ONE store のアプリ内課金を使用するには、以下のように build.gradle に依存性を追加します。
- ONE store V19 の場合は、V19 IAP SDK を[ダウンロード](https://github.com/ONE-store/onestore_iap_release/tree/iap19-release/android_app_sample/app/libs)して libs ディレクトリにコピーし、依存性を合わせて追加します。

```groovy
repositories {
    mavenCentral()
    // ONE store 統合バージョン(V21)
    maven { url 'https://repo.onestore.co.kr/repository/onestore-sdk-public' }
}

dependencies {
    // ONE store 統合バージョン(V21)
    implementation 'com.onestorecorp.sdk:sdk-iap:21.00.01'
    implementation 'com.onestorecorp.sdk:sdk-configuration-kr:1.0.0'
    implementation 'com.nhncloud.android:nhncloud-iap-onestore2:1.12.0'

    // ONE store V17
    implementation 'com.nhncloud.android:nhncloud-iap-onestore:1.12.0'
    
    // ONE store V19
    implementation files('libs/iap_sdk-v19.01.00.aar')
    implementation 'com.nhncloud.android:nhncloud-iap-onestore-v19:1.12.0'
    ...
}
```

> ONE store 統合バージョン(V21) のアプリ内課金は、Android 6.0(API レベル 23) 以上で動作します。

<a id="galaxy-store"></a>

### Galaxy Store

- Galaxy Store のアプリ内課金を使用するには、以下のように build.gradle に依存性を追加します。

```groovy
repositories {
    mavenCentral()
}

dependencies {
    implementation 'com.nhncloud.android:nhncloud-iap-galaxy:1.12.0'
    ...
}
```

<a id="amazon-appstore"></a>

### Amazon Appstore

- Amazon Appstore のアプリ内課金を使用するには、以下のように build.gradle に依存性を追加します。

```groovy
repositories {
    mavenCentral()
}

dependencies {
    implementation 'com.nhncloud.android:nhncloud-iap-amazon:1.12.0'
    ...
}
```

<a id="huawei-app-gallery"></a>

### Huawei App Gallery

- AppGallery Connection 構成ファイル(agconnect-service.json) を追加します。
    - [AppGallery Connect](https://developer.huawei.com/consumer/en/service/josp/agc/index.html) にサインインし、**[マイプロジェクト]** をクリックします。
    - プロジェクトでアプリを選択します。
    - **[Project settings]** > **[General information]** に移動します。
    - **[App information]** から **agconnect-service.json** ファイルをダウンロードします。
    - **agconnect-service.json** ファイルをアプリのルートディレクトリにコピーします。

- 以下のように、ルートレベルの build.gradle に App Gallery Connect プラグインを追加します。

```groovy
buildscript {
    repositories {
        google()
        mavenCentral()
        // Configure the Maven repository address for the HMS Core SDK.
        maven {url 'https://developer.huawei.com/repo/'}
    }
    dependencies {
        ...
        // Add the AppGallery Connect plugin configuration. You are advised to use the latest plugin version.
        classpath 'com.huawei.agconnect:agcp:1.9.0.300'
    }
}
```

- 以下のように、アプリレベルの build.gradle に依存性を追加します。

```groovy
apply plugin: 'com.huawei.agconnect'

repositories {
    mavenCentral()
    maven {url 'https://developer.huawei.com/repo/'}
}

dependencies {
    implementation 'com.nhncloud.android:nhncloud-iap-huawei:1.12.0'
    ...
}
```

<a id="mycard"></a>

### MyCard

- MyCard のアプリ内課金を使用するには、以下のように build.gradle に依存性を追加します。

```groovy
repositories {
    mavenCentral()
}

dependencies {
    implementation 'com.nhncloud.android:nhncloud-iap-mycard:1.12.0'
    ...
}
```

<a id="androidmanifest-setting"></a>

## AndroidManifest 設定

<a id="one-store-purchase-screen-setting-optional"></a>

### ONE store 決済画面設定（オプション）

ONE store は全体決済画面とポップアップ決済画面をサポートします。
AndroidManifest.xml に meta-data を追加することで、全体決済画面（"full"）またはポップアップ決済画面（"popup"）を選択できます。
meta-data を設定しない場合、デフォルト値（"full"）が適用されます。

```xml
<application
  ...>
  <meta-data android:name="iap:view_option" android:value="popup | full"/>
</application>
```

| 決済画面 | 設定値 |
| -- | -- |
| 全体決済画面 | "full" |
| ポップアップ決済画面 | "popup" |

詳細については、[ONE store 決済画面設定](https://dev.onestore.co.kr/devpoc/reference/view/Tools)を参照してください。

<a id="app-targeting-android-11-or-higher-one-store-galaxy-store-amazon-appstore"></a>

### Android 11 以上をターゲットにするアプリ（ONE store、Galaxy Store、Amazon Appstore）

Android 11 では、アプリがユーザーのデバイスにインストールされている他のアプリをクエリし、相互作用する方法が変更されます。
Android 11 以上をターゲットにするアプリで ONE store、Galaxy Store、または Amazon Appstore 決済を使用するには、以下のように AndroidManifest.xml に `queries` 要素または権限を定義する必要があります。

<a id="one-store-2"></a>

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

<a id="galaxy-store-2"></a>

#### Galaxy Store

```xml
<queries>
    <package android:name="com.sec.android.app.samsungapps" />
</queries>
```

<a id="amazon-appstore-2"></a>

### Amazon Appstore

Amazon Appstore では、`queries` 要素の代わりに権限を追加します。

```xml
<uses-permission
    android:name="android.permission.QUERY_ALL_PACKAGES"
    tools:ignore="QueryAllPackagesPermission" />
```

`queries` 要素は Android Gradle Plugin 4.1 以上で動作します。
以前のバージョンの Android Gradle Plugin を使用する場合は、[Android 11 でのパッケージの可視性に向けた Gradle ビルドの準備](https://android-developers.googleblog.com/2020/07/preparing-your-build-for-package-visibility-in-android-11.html)を参照してください。

> <span style="color:#e11d21">**注意！)**</span> QUERY_ALL_PACKAGES 権限を Google Play Store に適用しないよう注意してください。

<a id="mycard-2"></a>

### MyCard

<a id="androidname-setting"></a>

#### android:name 設定

android:name を定義していない場合は、次のように追加します。

```xml
<application
  android:name="com.nhncloud.android.iap.mycard.NhnCloudMyCardApplication"
  ...>
  ...
</application>
```

android:name を定義している場合は、[Application](https://developer.android.com/reference/android/app/Application) クラスの代わりに NhnCloudMyCardApplication クラスを継承します。

```xml
<application
  android:name=".MyApplication"
  ...>
  ...
</application>
```

```java
class MyApplication extends NhnCloudMyCardApplication {
    ...
}
```

<a id="test-payment-mode-option"></a>

#### テスト決済モード（オプション）

決済テストを行うには、`test_mode` を追加します。`test_mode` を設定しない場合、デフォルト値は false です。

```xml
<application
  ...>
  <meta-data android:name="iap:test_mode" android:value="true | false"/>
</application>
```

<a id="store-codes"></a>

## ストアコード

| ストア | コード |
| ----------- | ---------- |
| Google Play | "GG" |
| ONE store | "ONESTORE" |
| Galaxy store | "GALAXY" |
| Amazon Appstore | "AMAZON" |
| Huawei App Gallery | "HUAWEI" |
| MyCard | "MYCARD" |

> [注記] ストアコードは [IapStoreCode](./iap-android/#iapstorecode) クラスに定義されています。

<a id="product-types"></a>

## 商品の種類

- 現在サポートしている商品の種類は3つで、消費性商品、サブスクリプション商品、消費性サブスクリプション商品があります。

| 商品名    | 商品タイプ             | 説明                                     |
| ------ | ---------------- | -------------------------------------- |
| 消費性商品 | "CONSUMABLE"     | 消費可能な一回性の商品です。ゲーム内通貨やメディアファイルは消費性商品の例です。 |
| サブスクリプション商品  | "AUTO_RENEWABLE" | 指定された間隔および価格で決済が自動的に繰り返される商品です。<br>オンライン雑誌や音楽ストリーミングサービスはサブスクリプションの例です。 |
| 消費性サブスクリプション商品 | "CONSUMABLE_AUTO_RENEWABLE" | 消費可能なサブスクリプション商品です。<br>定期的にゲーム内通貨やアイテムなどを支給する決済方式です。 |

> [注記] サブスクリプション商品と消費性サブスクリプション商品は、**Google Play ストア**のみサポートします。

<a id="in-app-purchase-iap-setting"></a>

## アプリ内課金設定

* [NhnCloudIapConfiguration](./iap-android/#nhncloudiapconfiguration) オブジェクトはアプリ内課金の設定情報を含んでいます。
* [NhnCloudIapConfiguration](./iap-android/#nhncloudiapconfiguration) オブジェクトは [NhnCloudIapConfiguration.Builder](./iap-android/#nhncloudiapconfigurationbuilder) を使用して作成できます。
* IAP コンソールで発行された [AppKey](/Mobile%20Service/IAP/ja/console-guide/#appkey) を setAppKey メソッドを使用して設定します。
* setStoreCode メソッドを使用して、アプリ内課金に使用する [ストアコード](./iap-android/#_3) を設定します。

<a id="example-of-iap-setting"></a>

### アプリ内課金設定の例

```java
NhnCloudIapConfiguration configuration =
    NhnCloudIapConfiguration.newBuilder(getApplicationContext())
                .setAppKey(YOUR_APP_KEY)
                .setStoreCode(IapStoreCode.GOOGLE_PLAY_STORE)
                .build();
```

<a id="initialize-iap"></a>

## アプリ内課金の初期化

- NhnCloudIap.initialize() メソッドを呼び出して、NHN Cloud IAP を初期化します。

<a id="specification-for-iap-initialization-api"></a>

### アプリ内課金初期化 API 明細

* アプリ内課金は NhnCloudIap.initialize メソッドを使用して初期化します。
* NhnCloudIap.initialize メソッドは [NhnCloudIapConfiguration.Builder](./iap-android/#nhncloudiapconfigurationbuilder) で生成された [NhnCloudIapConfiguration](./iap-android/#nhncloudiapconfiguration) オブジェクトをパラメータとして使用します。

```java
/* NhnCloudIap.java */
public static void initialize(NhnCloudIapConfiguration configuration)
```

| Parameters    |                                    |
| ------------- | ---------------------------------- |
| configuration | NhnCloudIapConfiguration: アプリ内課金設定情報 |

<a id="example-of-iap-initialization"></a>

### アプリ内課金初期化の例

- NhnCloudIap を初期化します。

> [注記] 初期化は必ず Application#onCreate で行う必要があります。

```java
public class MainApplication extends Application {
    @Override
    public void onCreate() {
        super.onCreate();
        initializeNhnCloudIap();
    }

    /**
     * NhnCloudIap を初期化します。
     */
    private void initializeNhnCloudIap() {
        NhnCloudIapConfiguration configuration = NhnCloudIapConfiguration.newBuilder(getApplicationContext())
                .setAppKey(YOUR_APP_KEY)
                .setStoreCode(IapStoreCode.GOOGLE_PLAY_STORE)
                .build();
        NhnCloudIap.initialize(configuration);
    }
}
```

<a id="service-login"></a>

## サービスログイン

* NHN Cloud SDK で提供するすべての商品（IAP、Log & Crash など）は、同一のユーザー ID を使用します。
    * [NhnCloudSdk.setUserId](/nhncloud/ja/nhncloud-sdk/getting-started-android/#userid) でユーザー ID を設定できます。
    * ユーザー ID を設定していない場合、決済は進行されません。
* サービスログイン段階で、ユーザー ID の設定、未消費決済履歴の照会、有効化されたサブスクリプション商品の照会機能を実装することをお勧めします。

<a id="login"></a>

### ログイン

```java
// Login.
NhnCloudSdk.setUserId(userId);
```

<a id="logout"></a>

### ログアウト

```java
// Logout.
NhnCloudSdk.setUserId(null);
```

> [注記] サービスログアウト時には、必ずユーザー ID を null に設定してください。これにより、プロモーションコードがリディームされたり、決済再処理が動作した際に誤ったユーザー ID で購入が進行されることを防ぐことができます。

<a id="register-purchases-update-listener"></a>

## 決済アップデートリスナーの登録

* アプリ内で購入した決済とGoogle Playストアアプリでのプロモーションリデームまたはサブスクリプション状態の変更（復元、定期決済の再申請など）の際に、NhnCloudIapに設定された[IapService.PurchasesUpdatedListener](./iap-android/#iapservicepurchasesupdatedlistener)を通じて決済結果が通知されます。
* 決済アップデートリスナーはNhnCloudIap.registerPurchasesUpdatedListenerメソッドを使用して登録できます。
* [IapService.PurchasesUpdatedListener](./iap-android/#iapservicepurchasesupdatedlistener)を通じて渡された[IapPurchaseResult](./iap-android/#iappurchaseresult)リストから決済情報を確認できます。

> [注記] 決済アップデートリスナーはActivity.onCreate()で登録し、Activity.onDestroy()で必ず解除してください。

<a id="specification-for-registering-purchases-update-listener-api"></a>

### 決済アップデートリスナー登録 API 明細

```java
/* NhnCloudIap.java */
public static void registerPurchasesUpdatedListener(IapService.PurchasesUpdatedListener listener)
public static void unregisterPurchasesUpdatedListener(IapService.PurchasesUpdatedListener listener)
```

| Method                             | Parameters |                                          | Description            |
| ---------------------------------- | ---------- | ---------------------------------------- | ---------------------- |
| registerPurchasesUpdatedListener   | listener   | IapService.<br>PurchasesUpdatedListener: <br>決済アップデートリスナー | 決済アップデートリスナーを登録します。    |
| unregisterPurchasesUpdatedListener | listener   | IapService.<br>PurchasesUpdatedListener: <br>登録解除するリスナー | 決済アップデートリスナーの登録を解除します。 |

<a id="example-of-registering-purchases-update-listener"></a>

#### 決済アップデートリスナー登録例

```java
public class MainActivity extends AppCompatActivity {
    /**
     * アプリ内で消費性商品、サブスクリプション、プロモーション商品を購入したときに結果を通知します。
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

        // onCreateが呼び出されたときにListenerを登録します。
        NhnCloudIap.registerPurchasesUpdatedListener(mPurchaseUpdatedListener);
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        // onDestroy()が呼び出されたときに必ずListenerを削除します。
        NhnCloudIap.unregisterPurchasesUpdatedListener(mPurchaseUpdatedListener);
    }
}
```

> [注記] 決済結果がIapService.PurchasesUpdatedListenerに通知される前にActivityが終了すると、決済データが失われる可能性があります。
> 決済を安全に処理するために、決済結果を通知される前にユーザーがActivityを終了（戻るボタンまたは終了ボタンのクリック）できないようにする必要があります。

<a id="query-product-list"></a>

## 商品リスト照会

* IAPコンソールに登録された商品のうち、使用可能な商品リストを照会します。
* IAPコンソールに登録された商品のうち、購入可能な商品は [IapProductDetails](./iap-android/#iapproductdetails) リスト(Product Details List)として返されます。
* IAPコンソールに登録された商品のうち、ストアに登録されていない商品は [IapProduct](./iap-android/#iapproduct) リスト(Invalid Product List)として返されます。

<a id="specification-for-product-list-query-api"></a>

### 商品リスト照会 API 명세

```java
/* NhnCloudIap.java */
public static void queryProductDetails(Activity activity,
                                       IapService.ProductDetailsResponseListener listener)
```

| Method              | Parameters |                                          |
| ------------------- | ---------- | ---------------------------------------- |
| queryProductDetails | activity   | Activity: 現在アクティブなActivity               |
|                     | listener   | IapService.<br>ProductDetailsResponseListener: <br>商品照会結果リスナー |


<a id="example-of-product-list-query"></a>

### 商品リスト照会の例

```java
/**
 * 購入可能な商品を照会します。
 * <p>
 * productDetails : 購入可能な商品リスト
 * invalidProducts : NHN Cloud IAP コンソールに商品を登録したが、ストアに登録されていない商品
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

    NhnCloudIap.queryProductDetails(MainActivity.this, responseListener);
}
```

<a id="purchase-products"></a>

## 商品の購入

* NHN Cloud IAPはストアに登録された商品IDを使用して商品を購入できます。
* 商品情報はNhnCloudIap.queryProductDetails()メソッドを呼び出して返された[IapProductDetails](./iap-android/#iapproductdetails)オブジェクトに含まれています。
* 商品IDはIapProductDetails.getProductId()メソッドを使用して取得できます。
* 商品の購入は[IapPurchaseFlowParams](./iap-android/#iappurchaseflowparams)オブジェクトに商品IDを設定した後、NhnCloudIap.launchPurchaseFlow()メソッドを通じて購入ステップを開始します。
* [IapPurchaseFlowParams](./iap-android/#iappurchaseflowparams)オブジェクトは[IapPurchaseFlowParams.Builder](./iap-android/#iappurchaseflowparamsbuilder)を使用して作成できます。
* 商品購入の結果はNhnCloudIapに登録した[IapService.PurchasesUpdatedListener](./iap-android/#iapservicepurchasesupdatedlistener)を通じて返されます。

<a id="specification-for-product-purchase-iap"></a>

### 商品購入IAP明細

```java
/* NhnCloudIap.java */
public static void launchPurchaseFlow(Activity activity,
                                      IapPurchaseFlowParams params)
```

| Method             | Parameters |                                          |
| ------------------ | ---------- | ---------------------------------------- |
| launchPurchaseFlow | activity   | Activity: 現在アクティブなActivity               |
|                    | params     | IapPurchaseFlowParams: 購入情報パラメータ |

<a id="example-of-product-purchase"></a>

### 商品購入の例

```java
/**
 * 商品を購入します。
 */
void launchPurchaseFlow(Activity activity, String productId) {
    IapPurchaseFlowParams params = IapPurchaseFlowParams.newBuilder()
            .setProductId(productId)
            .build();
    NhnCloudIap.launchPurchaseFlow(activity, params);
}
```

<a id="set-user-data"></a>

### ユーザーデータ設定

* NHN Cloud IAPは購入リクエスト時にユーザー情報を追加できます。
* ユーザー情報はIapPurchaseFlowParams.BuilderのsetDeveloperPayload()メソッドで設定します。
* 設定されたユーザー情報は未消費決済照会および有効化されたサブスクリプション照会時に返される[IapPurchase](./iap-android/#iappurchase)のgetDeveloperPayload()メソッドで確認できます。

```java
String userData = "User Data"
IapPurchaseFlowParams params = IapPurchaseFlowParams.newBuilder()
       .setProductId(productId)
       .setDeveloperPayload(userData)
       .build();
NhnCloudIap.launchPurchaseFlow(activity, params);
```

> Google Play Storeでプロモーションコードを使用して商品を購入した場合、ユーザーデータは使用できません。

<a id="query-unconsumed-purchases"></a>

## 未消費決済照会

* まだ消費されていない一回性商品(CONSUMABLE)と消費性サブスクリプション商品(CONSUMABLE_AUTO_RENEWABLE)の情報を照会します。
* ユーザーに商品を付与した後、[Consume API](/Mobile%20Service/IAP/ja/api-guide-for-toast-sdk/#consume-api)を使用して商品を消費します。
* 未消費決済は NhnCloudIap.queryConsumablePurchases() メソッドを使用して照会できます。
* [IapQueryPurchasesParams](./iap-android/#iapquerypurchasesparams)を利用して、現在のストアまたはすべてのストアの未消費決済を照会できます。
* 照会結果は[IapService.PurchasesResponseListener](./iap-android/#iapservicepurchasesresponselistener)を通じて[IapPurchase](./iap-android/#iappurchase)オブジェクトリストとして返されます。

<a id="specification-for-unconsumed-purchases-query-api"></a>

### 未消費決済照会 API 명세

```java
/* NhnCloudIap.java */
public static void queryConsumablePurchases(Activity activity,
                                            IapQueryPurchasesParams params,
                                            IapService.PurchasesResponseListener listener)
```

| Method                   | Parameters |                                          |
| ------------------------ | ---------- | ---------------------------------------- |
| queryConsumablePurchases | activity   | Activity: 現在アクティブなActivity               |
|                          | params     | IapQueryPurchasesParams: 未消費購入履歴照会パラメータ |
|                          | listener   | IapService.PurchasesResponseListener: <br>未消費購入履歴照会結果リスナー |

<a id="example-of-unconsumed-purchases-query"></a>

### 未消費決済照会の例

```java
/**
 * 未消費決済履歴を照会します。
 */
void queryConsumablePurchases(boolean isQueryAllStores) {
    IapQueryPurchasesParams params = IapQueryPurchasesParams.newBuilder()
        .setQueryAllStores(isQueryAllStores) // すべてのストアを照会: true、現在のストアを照会: false
        .build();
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
    NhnCloudIap.queryConsumablePurchases(MainActivity.this, params, responseListenr);
}
```

<a id="query-activated-subscription"></a>

## アクティブなサブスクリプションの照会

* User ID を基準に、アクティブなサブスクリプション商品（AUTO_RENEWABLE & CONSUMABLE_AUTO_RENEWABLE）を照会できます。
* 決済が完了したサブスクリプション商品は、使用期間が残っている場合、引き続き照会できます。
* アクティブなサブスクリプションは、NhnCloudIap.queryActivatedPurchases() メソッドを使用して照会できます。
* [IapQueryPurchasesParams](./iap-android/#iapquerypurchasesparams) を利用して、現在のストアまたはすべてのストアのアクティブなサブスクリプションを照会できます。
* 照会結果は [IapService.PurchasesResponseListener](./iap-android/#iapservicepurchasesresponselistener) を通じて、[IapPurchase](./iap-android/#iappurchase) オブジェクトのリストとして返されます。
* iOS でサブスクライブした商品を Android でも照会できます。

> 現在、サブスクリプション商品は Google Play Store のみサポートしています。

<a id="specification-for-activated-subscription-query-api"></a>

### アクティブなサブスクリプション照会 API の仕様

```java
/* NhnCloudIap.java */
public static void queryActivatedPurchases(Activity activity,
                                           IapQueryPurchasesParams params,
                                           PurchasesResponseListener listener)
```

| Method                  | Parameters |                                          |
| ----------------------- | ---------- | ---------------------------------------- |
| queryActivatedPurchases | activity   | Activity: 現在アクティブな Activity               |
|                         | params     | IapQueryPurchasesParams: アクティブなサブスクリプション照会パラメータ |
|                         | listener   | IapService.PurchasesResponseListener: <br>アクティブなサブスクリプション照会結果リスナー |

<a id="example-of-activated-subscription-query"></a>

### アクティブなサブスクリプション照会の例

```java
/**
 * アクティブなサブスクリプション商品の照会
 */
void queryActivatedPurchases(boolean isQueryAllStores) {
    IapQueryPurchasesParams params = IapQueryPurchasesParams.newBuilder()
        .setQueryAllStores(isQueryAllStores) // すべてのストアを照会: true、現在のストアを照会: false
        .build();
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
    NhnCloudIap.queryActivatedPurchases(MainActivity.this, params, responseListener);
}
```

<a id="query-subscription-status"></a>

## サブスクリプション状態の照会

* User ID を基準に購入したサブスクリプション商品の状態を照会できます。
* 期限切れのサブスクリプション商品は、includeExpiredSubscriptions の設定で照会または除外できます。（default: false）
* サブスクリプション商品の状態は、NhnCloudIap.querySubscriptionsStatus() メソッドを使用して照会できます。
* 照会結果は [IapService.SubscriptionsStatusResponseListener](./iap-android/#iapservicesubscriptionsstatusresponselistener) を通じて [IapSubscriptionStatus](./iap-android/#iapsubscriptionstatus) オブジェクトのリストとして返されます。
* [IapSubscriptionStatus](./iap-android/#iapsubscriptionstatus) で使用するサブスクリプション状態コードは [IapSubscriptionStatus.StatusCode](./iap-android/#iapsubscriptionstatusstatuscode) に定義されています。

```
現在、サブスクリプション商品は Google Play Store のみをサポートしています。
```

<a id="specification-for-subscription-status-query-api"></a>

### サブスクリプション状態照会 API 仕様

```java
/* NhnCloudIap.java */
public static void querySubscriptionsStatus(Activity activity,
                                            boolean includeExpiredSubscriptions,
                                            IapService.SubscriptionsStatusResponseListener listener)
```

| Method | Parameters |  |
| --- | --- | --- |
| querySubscriptionsStatus | activity | Activity: 現在アクティブな Activity |
|  | includeExpiredSubscriptions | boolean:<br>サブスクリプションが期限切れになったサブスクリプション商品の状態を含めるかどうか |
|  | listener | IapService.SubscriptionsStatusResponseListener:<br>サブスクリプション状態照会結果リスナー |

<a id="example-of-subscription-status-query"></a>

### サブスクリプション状態照会の例

```java
/**
 * サブスクリプション状態の照会
 */
private void querySubscriptionsStatus() {
    SubscriptionsStatusResponseListener listener =
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
    NhnCloudIap.querySubscriptionsStatus(MainActivity.this, false, listener);
}
```

<a id="google-store-subscription-feature"></a>

## Google Play Store サブスクリプション(定期決済)機能

Google Play Store のサブスクリプション決済の更新や有効期限切れなど、ライフサイクルに応じたイベントを処理する方法について説明します。
詳細については、[定期決済別機能追加](https://developer.android.com/google/play/billing/billing_subscriptions)を参照してください。

<a id="subscription-lifecycle-handling"></a>

### サブスクリプションライフサイクルの処理

Google Play Store のサブスクリプションは、ライフサイクルの間にさまざまな状態変化を経ており、アプリは各状態に応じて対応する必要があります。

* **アクティブ状態(Active)**: 定期決済コンテンツにアクセスでき、自動更新が進行中の状態
* **取消(Cancelled)**: 定期決済コンテンツにアクセスできますが、ユーザーがサブスクリプション商品を利用しないとして取り消し、自動更新が停止された状態
* **猶予期間(In grace period)**: 決済手段の問題により定期決済が失敗しましたが、定期決済コンテンツにはアクセスできる状態（ユーザーが決済手段を変更するのを待機している状態）
* **アカウント保留(On hold)**: 決済手段の問題により定期決済が失敗し、保留状態（猶予期間が有効になっている場合、猶予期間中に決済手段を変更しなかったため決済が保留された状態）
* **一時停止(Pause)**: 定期決済商品を一時的に停止した状態
* **有効期限切れ(Expired)**: 定期決済商品が有効期限切れになった状態

| 状態 | 未消費決済照会<br>(NhnCloudIap.queryConsumablePurchases) | 有効化されたサブスクリプション照会<br>(NhnCloudIap.queryActivatedPurchases) | 有効期限 | 自動更新 |
| --- | --- | --- | --- | --- |
| アクティブ状態 (Active) | Yes | Yes | 未来時間 | Yes |
| 取消 (Cancelled) | Yes | Yes | 未来時間 | No |
| 猶予期間 (In grace period) | No | Yes | 未来時間 | Yes |
| アカウント保留 (On hold) | No | No | 過去時間 | Yes |
| 一時停止 (Pause) | No | No | 過去時間 | Yes |
| 有効期限切れ (Expired) | No | No | 過去時間 | No |

<a id="grace-period"></a>

### 猶予期間

猶予期間が有効になっている場合、決済周期の終了時に決済手段に問題があると、定期決済は猶予期間に移行します。
<span style="color:#e11d21">猶予期間中、ユーザーは定期決済コンテンツにアクセスできる必要があります。</span>
詳細については、[猶予期間](https://developer.android.com/google/play/billing/subs#grace)を参照してください。

> <span style="color:#e11d21">**注意!)**</span> 猶予期間中に決済手段の変更などによって復元された場合、自動更新を再開します。NHN Cloud IAP は更新された決済件を決済アップデートリスナー(IapService.PurchaseUpdatedListener)を通じて決済結果を通知します。ゲームやアプリは、重要な動作中に決済アップデートリスナーによって不要なポップアップがユーザーに表示されないよう注意してください。

<a id="ordinary-subscription-product-autorenewable"></a>

#### 一般サブスクリプション商品 (AUTO_RENEWABLE))

* 猶予期間中、一般サブスクリプション商品は定期決済コンテンツにアクセスできる必要があります。
* 猶予期間中は NhnCloudIap.queryActivatedPurchases() で照会できます。

<a id="consumable-subscription-product-consumableautorenewable"></a>

#### 消費性サブスクリプション商品 (CONSUMABLE_AUTO_RENEWABLE)

* 猶予期間が開始されると、Googleは新しいレシートを発行しますが、決済手段を変更しない場合はアカウント保留状態になるか取り消されます。
* 消費性サブスクリプション商品は、猶予期間中に商品を消費できないよう NhnCloudIap.queryConsumablePurchases() では照会されません。

<a id="account-hold"></a>

### アカウント保留

アカウント保留とは、決済手段の問題により更新が失敗した際のユーザー状態を指します。
決済に失敗すると猶予期間中に再試行し、猶予期間中も決済が失敗すると定期決済の状態は保留状態になります。
アカウント保留状態のユーザーは定期決済コンテンツにアクセスできません。
アカウント保留期間は最大30日間です。
アカウント保留期間が終了する前に決済手段を変更しない場合、取り消し処理されます。
詳細については、[アカウント保留](https://developer.android.com/google/play/billing/subs#account-hold)を参照してください。

> <span style="color:#e11d21">**注意!)**</span> アカウント保留期間中に決済手段の変更などによって復元された場合、自動更新を再開します。NHN Cloud IAP は更新された決済件を決済アップデートリスナー(IapService.PurchaseUpdatedListener)を通じて決済結果を通知します。ゲームやアプリは、重要な動作中に決済アップデートリスナーによって不要なポップアップがユーザーに表示されないよう注意してください。

<a id="ordinary-subscription-product-autorenewable-2"></a>

#### 一般サブスクリプション商品 (AUTO_RENEWABLE))

* アカウント保留期間中、一般サブスクリプション商品は定期決済コンテンツにアクセスできません。
* アカウント保留期間中は NhnCloudIap.queryActivatedPurchases() で照会されません。

<a id="consumable-subscription-product-consumableautorenewable-2"></a>

#### 消費性サブスクリプション商品 (CONSUMABLE_AUTO_RENEWABLE)

* アカウント保留期間中、消費性サブスクリプション商品は新しい購入を生成しません。
* アカウント保留期間中は NhnCloudIap.queryConsumablePurchases() で新しい購入が照会されません。

<a id="pause"></a>

### 一時停止

一時停止機能を設定すると、ユーザーが定期決済を1週間から3か月の間で一時停止できます。
定期決済の一時停止は、現在のサブスクリプション期間が終了した後に適用されます。
一時停止期間が終了すると、定期決済が自動的に再開されます。
詳細については、[一時停止](https://developer.android.com/google/play/billing/subs#pause)を参照してください。

> <span style="color:#e11d21">**注意!)**</span> 一時停止期間が終了すると、自動更新を再開します。NHN Cloud IAP は更新された決済件を決済アップデートリスナー(IapService.PurchaseUpdatedListener)を通じて決済結果を通知します。ゲームやアプリは、重要な動作中に決済アップデートリスナーによって不要なポップアップがユーザーに表示されないよう注意してください。

<a id="ordinary-subscription-product-autorenewable-3"></a>

#### 一般サブスクリプション商品 (AUTO_RENEWABLE))

* 一時停止期間中、一般サブスクリプション商品は定期決済コンテンツにアクセスできません。
* 一時停止期間中は NhnCloudIap.queryActivatedPurchases() で照会されません。

<a id="consumable-subscription-product-consumableautorenewable-3"></a>

#### 消費性サブスクリプション商品 (CONSUMABLE_AUTO_RENEWABLE)

* 一時停止期間中、消費性サブスクリプション商品は新しい購入を生成しません。
* 一時停止期間中は NhnCloudIap.queryConsumablePurchases() で新しい購入が照会されません。

<a id="resubscription"></a>

### 定期決済の再申請

定期決済の再申請機能を設定すると、ユーザーが定期決済の有効期限日から12か月以内に取り消した定期決済を再申請できます。
定期決済の再申請では、新しい定期決済および購入トークンが生成されます。
定期決済が有効期限切れになった後、ユーザーはGoogle Playの定期決済センターを通じて、有効期限切れから1年以内に同じ商品を再購入できます。
詳細については、[定期決済の再申請](https://developer.android.com/google/play/billing/subs#resubscribe)を参照してください。

> <span style="color:#e11d21">**注意!)**</span> アプリやゲーム内の画面から購入が行われないため、ユーザーデータ(IapPurchase.getDeveloperPayload())は使用できません。
> <span style="color:#e11d21">**注意!)**</span> Google Play Store で定期決済の再申請によりサブスクリプション商品を購入した場合、NHN Cloud IAP は購入した決済件を決済アップデートリスナー(IapService.PurchaseUpdatedListener)を通じて決済結果を通知します。ゲームやアプリは、重要な動作中に決済アップデートリスナーによって不要なポップアップがユーザーに表示されないよう注意してください。

<a id="nhn-cloud-iap-class-reference"></a>

## NHN Cloud IAP Class Reference

<a id="nhncloudiapconfiguration"></a>

### NhnCloudIapConfiguration

NHN Cloud IAP 初期化メソッドのパラメータとして使用されるアプリ内課金設定情報です。

```java
/* NhnCloudIapConfiguration.java */
public String getAppKey();
public String getStoreCode();
```

| Method       | Returns |                                     |
| ------------ | ------- | ----------------------------------- |
| getAppKey    | String  | IAPサービスアプリキー                         |
| getStoreCode | String  | ストアコード情報 ("GG" or "ONESTORE", "GALAXY", ...) |

<a id="nhncloudiapconfigurationbuilder"></a>

### NhnCloudIapConfiguration.Builder

IAP サービスのアプリキーやストアの種類などを入力して、[NhnCloudIapConfiguration](./iap-android/#nhncloudiapconfiguration) オブジェクトを作成します。

```java
/* NhnCloudIapConfiguration.java */
public void setAppKey(String appKey)
public void setStoreCode(String storeCode)
```

| Method       | Parameters |                     | Description                              |
| ------------ | ---------- | ------------------- | ---------------------------------------- |
| setAppKey    | appKey     | String: IAP サービスアプリキー | TOAST IAP コンソールで作成したアプリキーを設定します。      |
| setStoreCode | storeCode  | String: ストアコード情報   | ストアコードを設定します。<br>("GG" or "ONESTORE", "GALAXY", ...) |

<a id="iapstorecode"></a>

### IapStoreCode

```java
/* IapStoreCode.java */
String GOOGLE_PLAY_STORE
String ONE_STORE
String GALAXY_STORE
String AMAZON_APP_STORE
String HUAWEI_APP_GALLERY
String MYCARD
```

* GOOGLE_PLAY_STORE<br>Google Play ストアのアプリ内課金を使用します。<br>Constant Value: "GG"
* ONE_STORE<br>ONE store のアプリ内課金を使用します。<br>Constant Value: "ONESTORE"
* GALAXY_STORE<br>Galaxy store のアプリ内課金を使用します。<br>Constant Value: "GALAXY"
* AMAZON_APP_STORE<br>Amazon Appstore のアプリ内課金を使用します。<br>Constant Value: "AMAZON"
* HUAWEI_APP_GALLERY<br>Huawei App Gallery のアプリ内課金を使用します。<br>Constant Value: "HUAWEI"
* MYCARD<br>MyCard のアプリ内課金を使用します。<br>Constant Value: "MYCARD"

<a id="iappurchaseresult"></a>

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
| getPurchase | IapPurchase | 決済情報を含む IapPurchase オブジェクトを返します。 |
| getCode     | int         | 決済結果コードを返します。                 |
| getMessage  | String      | 決済結果メッセージを返します。                |
| getCause    | Throwable   | 決済失敗の原因を返します。                 |
| isSuccess   | boolean     | 決済成功の有無を返します。                 |
| isFailure   | boolean     | 決済失敗の有無を返します。                 |

<a id="iapresult"></a>

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
| isSuccess  | boolean   | 成功の有無を返します。  |
| isFailure  | boolean   | 失敗の有無を返します。  |

<a id="iappurchase"></a>

### IapPurchase

* IapPurchase オブジェクトで決済情報を確認できます。

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
public String getDeveloperPayload()
```

| Method               | Returns |                                        |
| -------------------- | ------- | -------------------------------------- |
| getPaymentId         | String  | 決済 ID を返します。                           |
| getOriginalPaymentId | String  | 元の決済 ID を返します。                         |
| getPaymentSequence   | String  | 決済固有番号を返します。                           |
| getProductId         | String  | 商品 ID を返します。                           |
| getProductType       | String  | 商品タイプを返します。                            |
| getUserId            | String  | ユーザー ID を返します。                         |
| getPrice             | float   | 価格情報を返します。                             |
| getPriceCurrencyCode | String  | 通貨情報を返します。                             |
| getAccessToken       | String  | 消費に使用するトークンを返します。                      |
| getPurchaseType      | String  | 商品タイプを返します。                            |
| getPurchaseTime      | long    | 商品購入時間を返します。                           |
| getExpiryTime        | long    | サブスクリプション商品の残り時間を返します。                 |
| getDeveloperPayload  | String  | ユーザーデータを返します。                          |

<a id="iapproductdetails"></a>

### IapProductDetails

* IapProductDetails オブジェクトで商品の詳細情報を確認できます。
* NHN Cloud IAP コンソールに登録された情報と、Google Play コンソールまたは ONE store Developer に登録された詳細情報を含みます。

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

| Method                | Returns |                        |
| --------------------- | ------- | ---------------------- |
| getProductId          | String  | 商品の ID                 |
| getProductSequence    | String  | 商品固有番号                 |
| getPrice              | float   | 価格                     |
| getLocalizedPrice     | String  | 現地価格                   |
| getPriceCurrencyCode  | String  | 通貨                     |
| getPriceAmountMicros  | long    | 1,000,000 単位の価格        |
| getFreeTrialPeriod    | String  | 無料使用期間                 |
| getSubscriptionPeriod | String  | 購読期間                   |
| getProductType        | String  | 商品タイプ                  |
| getProductTitle       | String  | 商品タイトル (title)         |
| getProductDescription | String  | 商品説明                   |
| isActivated           | boolean | 商品の有効化状態               |

<a id="iapproduct"></a>

### IapProduct

* NHN Cloud IAP コンソールに登録された概要情報を確認できます。

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
| getProductId          | String  | 商品の ID       |
| getProductSequence    | String  | 商品固有番号     |
| getProductType        | String  | 商品タイプ        |
| getProductTitle       | String  | 商品タイトル(title) |
| getProductDescription | String  | 商品の説明        |
| isActivated           | boolean | 商品の有効化状態    |

<a id="iappurchaseflowparams"></a>

### IapPurchaseFlowParams

* IapPurchaseFlowParams は購入しようとする商品情報を含みます。

```java
/* IapPurchaseFlowParams.java */
public String getProductId()
```

| Method       | Returns |       |
| ------------ | ------- | ----- |
| getProductId | String  | 商品 ID |

<a id="iappurchaseflowparamsbuilder"></a>

### IapPurchaseFlowParams.Builder

* IapPurchaseFlowParams オブジェクトを作成します。

```java
/* IapPurchaseFlowParams.java */
public void setProductId(String productId)
```

| Method       | Parameters |               | Description   |
| ------------ | ---------- | ------------- | ------------- |
| setProductId | productId  | String: 商品 ID | 商品 ID を設定します。 |

<a id="iapquerypurchasesparams"></a>

### IapQueryPurchasesParams

* IapQueryPurchasesParams は照会する条件を設定します。

```java
/* IapQueryPurchasesParams.java */
public String isQueryAllStores()
```

| Method           | Returns  |              |
| ---------------- | -------- | ------------ |
| isQueryAllStores | boolean  | すべてのストアを照会 |

<a id="iapquerypurchasesparamsbuilder"></a>

### IapQueryPurchasesParams.Builder

* IapQueryPurchasesParams オブジェクトを作成します。

```java
/* IapQueryPurchasesParams.java */
public void setQueryAllStores(boolean isQueryAllStores)
```

| Method            | Parameters        |                       | Description       |
| ----------------- | ----------------- | --------------------- | ----------------- |
| setQueryAllStores | isQueryAllStores  | boolean: すべてのストアを照会 | 照会範囲を設定します。 |

<a id="iapsubscriptionstatus"></a>

### IapSubscriptionStatus

* IapSubscriptionStatus オブジェクトで購読状態情報を確認できます。
* 購読状態コードは IapSubscriptionStatus.StatusCode に定義されています。

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
| getPaymentId | String | 決済 ID を返します。 |
| getOriginalPaymentId | String | 元の決済 ID を返します。 |
| getPaymentSequence | String | 決済固有番号を返します。 |
| getProductId | String | 商品 ID を返します。 |
| getProductType | String | 商品タイプを返します。 |
| getProductSeq | String | 商品固有番号を返します。 |
| getUserId | String | ユーザー ID を返します。 |
| getPrice | float | 価格情報を返します。 |
| getPriceCurrencyCode | String | 通貨情報を返します。 |
| getAccessToken | String | 消費に使用するトークンを返します。 |
| getPurchaseType | String | 決済タイプを返します。<br>"Test" or "Promo" or null |
| getPurchaseTime | long | 商品購入時間を返します。 |
| getExpiryTime | long | 購読商品の残り時間を返します。 |
| getDeveloperPayload | String | ユーザーデータを返します。 |
| getStatusCode | int | 購読状態コードを返します。 |
| getStatusDescription | String | 購読状態コードの説明を返します。 |

<a id="iapsubscriptionstatusstatuscode"></a>

### IapSubscriptionStatus.StatusCode

* 구독 상태를 나타내는 코드 입니다。

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
| ON\_HOLD | 5 | アカウント保留 | 定期決済がアカウント保留状態になりました（有効になっている場合）。 |
| IN\_GRACE\_PERIOD | 6 | 猶予期間 | 定期決済が猶予期間状態に移行しました（有効になっている場合）。 |
| PAUSED | 10 | 一時停止 | サブスクリプションが一時停止されました。 |
| REVOKED | 12 | 解除 | 定期決済が有効期限前にユーザーによってキャンセルされました。 |
| EXPIRED | 13 | 有効期限切れ | 定期決済の有効期限が切れました。 |
| UNKNOWN | 9999 | 未定義 | 定義されていない状態です。 |

<a id="iapservicepurchasesupdatedlistener"></a>

### IapService.PurchasesUpdatedListener

* 決済情報が更新されたとき、IapService.PurchasesUpdatedListener を継承して実装したオブジェクトの onPurchasesUpdated メソッドを通じて通知されます。

```java
void onPurchasesUpdated(List<IapPurchaseResult> purchaseResults)
```

<a id="iapservicepurchasesresponselistener"></a>

### IapService.PurchasesResponseListener

* 未消費決済の照会またはアクティブなサブスクリプションの照会時に、IapService.PurchasesResponseListener を継承して実装したオブジェクトの onPurchasesResponse メソッドを通じて通知されます。

```java
void onPurchasesResponse(IapResult result,
                         List<IapPurchase> purchaseList)
```

<a id="iapservicesubscriptionsstatusresponselistener"></a>

### IapService.SubscriptionsStatusResponseListener

* サブスクリプション状態の照会時に、SubscriptionsStatusResponseListener を継承して実装したオブジェクトの onSubscriptionsStatusResponse メソッドを通じて通知されます。

```java
void onSubscriptionsStatusResponse(IapResult result,
                                   List<IapSubscriptionStatus> subscriptionsStatus);
```

<a id="error-codes"></a>

## エラーコード

<a id="common-error-codes"></a>

### 共通エラーコード

| RESULT                 | CODE | DESC                                     |
| ---------------------- | ---- | ---------------------------------------- |
| FEATURE_NOT_SUPPORTED  | -2   | リクエストした機能はサポートしていません。<br>Requested feature is not supported. |
| SERVICE_DISCONNECTED   | -1   | ストアサービスが接続されていません。<br>Store service is not connected. |
| OK                     | 0    | 成功。<br>Success.                          |
| USER_CANCELED          | 1    | ユーザーキャンセル。<br>User canceled.                |
| SERVICE_UNAVAILABLE    | 2    | ネットワークが接続されていません。<br>Network connection is down. |
| BILLING_UNAVAILABLE    | 3    | リクエストされたタイプに対してAPI Versionがサポートされていません。<br>API version is not supported for the type requested. |
| PRODUCT_UNAVAILABLE    | 4    | リクエストした商品は使用できません。<br>Requested product is not available. |
| DEVELOPER_ERROR        | 5    | 無効な引数がAPIに提供されました。開発段階で発生するエラーです。<br>Developer error. |
| ERROR                  | 6    | API操作中に深刻なエラーが発生しました。<br>Fatal error during the API action. |
| PRODUCT_ALREADY_OWNED  | 7    | すでに所持している商品のため、購入できませんでした。<br>Failure to purchase since item is already owned. |
| PRODUCT_NOT_OWNED      | 8    | 所持していない商品のため、消費できません。<br>Failure to consume since item is not owned. |
| USER_ID_NOT_REGISTERED | 9    | ユーザーIDが登録されていません。<br>User ID Is not registered. |
| NETWORK_ERROR          | 12   | ネットワークエラーが発生しました。<br>A network error occurred during the operation. |
| UNDEFINED_ERROR        | 9999 | 定義されていないエラー。<br>Undefined error.           |

<a id="server-error-codes"></a>

### サーバーエラーコード

| RESULT                    | CODE | DESC                                     |
| ------------------------- | ---- | ---------------------------------------- |
| INACTIVATED_APP           | 101  | 有効化されていないアプリです。<br>App is not active.     |
| VERIFY_PURCHASE_FAILED    | 103  | 決済検証に失敗しました。<br>Failure to verify purchase. |
| PURCHASE_ALREADY_CONSUMED | 104  | すでに消費された購入です。<br>Purchase already consumed. |
| PURCHASE_ALREADY_REFUNDED | 105  | 払い戻された購入です。<br>Purchase already refunded. |
| PURCHASE_LIMIT_EXCEEDED   | 106  | 購入限度を超えました。<br>Purchase limit exceeded. |

<a id="one-store-error-codes"></a>

### ONE store エラーコード

| RESULT                   | CODE | DESC                                     |
| ------------------------ | ---- | ---------------------------------------- |
| ONESTORE_NEED_LOGIN      | 301  | ONE store サービスにログインしていません。<br>ONE store service is not logged in. |
| ONESTORE_NEED_UPDATE     | 302  | ONE store サービスがアップデートまたはインストールされていません。<br>ONE store service is not updated or installed. |
| ONESTORE_SECURITY_ERROR  | 303  | 異常なアプリから決済がリクエストされました。<br>Abnormal purchase request. |
| ONESTORE_PURCHASE_FAILED | 304  | 決済リクエストに失敗しました。<br>Purchase request failed. |

<a id="galaxy-store-error-codes"></a>

### Galaxy store エラーコード

| RESULT                   | CODE | DESC                                     |
| ------------------------ | ---- | ---------------------------------------- |
| GALAXY_NOT_LOGGED_IN      | 501  | Galaxy store サービスにログインしていません。<br>Galaxy service is not logged in. |
| GALAXY_NOT_UPDATED     | 502  | Galaxy store サービスがアップデートまたはインストールされていません。<br>Galaxy service is not updated or installed. |
| GALAXY_PURCHASE_FAILED  | 503  | 異常なアプリから決済がリクエストされました。<br>Galaxy purchase failed. |
| GALAXY_SERVICE_DENIED | 504  | 決済リクエストに失敗しました。<br>PurGalaxy service denied. |