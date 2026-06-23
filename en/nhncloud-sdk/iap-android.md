## NHN Cloud > SDK User Guide > IAP > Android

<a id="prerequisites"></a>

## Prerequisites

1. [Install NHN Cloud SDK](./getting-started-android).
2. [Enable the IAP service](/Mobile%20Service/IAP/en/console-guide/) in the [NHN Cloud console](https://console.nhncloud.com).
3. [Check the AppKey](/Mobile%20Service/IAP/en/console-guide/#appkey) in the IAP console.

<a id="console-guide-for-stores"></a>

## Console guide by store

- [Google console guide](/Mobile%20Service/IAP/en/console-google-guide/)
- [ONE store console guide](/Mobile%20Service/IAP/en/console-onestore-guide/)
- [Galaxy Store console guide](/Mobile%20Service/IAP/en/console-galaxystore-guide/)
- [Mycard console guide](/Mobile%20Service/IAP/en/mycard-guide/)
- [Amazon console guide](/Mobile%20Service/IAP/en/console-amazon-guide/)
- [Huawei console guide](/Mobile%20Service/IAP/en/console-huawei-guide/)

> If you sell subscription products on Google Play, you must [set up Google Notifications to receive real-time subscription status](/Mobile%20Service/IAP/en/console-google-guide/#google_1).

<a id="in-app-purchase-guide-for-each-store-type"></a>

## In-App Purchase Guide by Store

- [Android Developers In-App Purchases](https://developer.android.com/google/play/billing)
- [ONE store In-App Purchase API V7 (SDK V21) Guide and Download](https://onestore-dev.gitbook.io/dev/tools/tools)
- [Galaxy Store In-App Purchase API Guide and Download](https://developer.samsung.com/iap/overview.html)
- [Amazon Appstore In-App Purchase API Guide and Download](https://developer.amazon.com/docs/in-app-purchasing/iap-overview.html)
- [Huawei App Gallery In-App Purchase API Guide and Download](https://developer.huawei.com/consumer/kr/hms/huawei-iap)

<a id="library-setting"></a>

## Library Settings

<a id="google-play-store"></a>

### Google Play Store

- To use in-app purchases on Google Play Store, add the dependency to build.gradle as follows.

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

- To use in-app purchases on ONE store, add the dependency to build.gradle as follows.
- For ONE store V19, [download](https://github.com/ONE-store/onestore_iap_release/tree/iap19-release/android_app_sample/app/libs) the V19 IAP SDK, copy it to the libs directory, and add the dependency.

```groovy
repositories {
    mavenCentral()
    // ONE store integrated version (V21)
    maven { url 'https://repo.onestore.co.kr/repository/onestore-sdk-public' }
}

dependencies {
    // ONE store integrated version (V21)
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

> In-app purchases in the ONE store integrated version (V21) require Android 6.0 (API level 23) or later.

<a id="galaxy-store"></a>

### Galaxy Store

- To use in-app purchases on Galaxy Store, add the dependency to build.gradle as follows.

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

- To use in-app purchases on Amazon Appstore, add the dependency to build.gradle as follows.

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

- Add the AppGallery Connection configuration file (agconnect-service.json).
    - Sign in to [AppGallery Connect](https://developer.huawei.com/consumer/ko/service/josp/agc/index.html) and click **My projects**.
    - Select your app in the project.
    - Go to **Project settings** > **General information**.
    - In **App information**, download the **agconnect-service.json** file.
    - Copy the **agconnect-service.json** file to the root directory of your app.

- Add the App Gallery Connect plugin to the root-level build.gradle as follows.

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

- Add the dependency to the app-level build.gradle as follows.

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

- To use in-app purchases with MyCard, add the dependency to build.gradle as follows.

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

## AndroidManifest configuration

<a id="one-store-purchase-screen-setting-optional"></a>

### ONE store payment screen settings (optional)

ONE store supports a full payment screen and a popup payment screen.
You can add meta-data to AndroidManifest.xml to select either the full payment screen ("full") or the popup payment screen ("popup").
If you do not set meta-data, the default value ("full") is applied.

```xml
<application
  ...>
  <meta-data android:name="iap:view_option" android:value="popup | full"/>
</application>
```

| Payment Screen | Setting Value |
| -- | -- |
| Full payment screen | "full" |
| Popup payment screen | "popup" |

For more information, see [ONE store payment screen settings](https://dev.onestore.co.kr/devpoc/reference/view/Tools).

<a id="app-targeting-android-11-or-higher-one-store-galaxy-store-amazon-appstore"></a>

### Apps targeting Android 11 or higher (ONE store, Galaxy Store, Amazon Appstore)

Android 11 changes how apps query and interact with other apps that the user has installed on the device.
To use ONE store, Galaxy Store, or Amazon Appstore payments in apps targeting Android 11 or higher, you must define a 'queries' element or permissions in AndroidManifest.xml as shown below.

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

For Amazon Appstore, add permissions instead of the 'queries' element.

```xml
<uses-permission
    android:name="android.permission.QUERY_ALL_PACKAGES"
    tools:ignore="QueryAllPackagesPermission" />
```

The 'queries' element works with Android Gradle Plugin 4.1 or higher.
If you are using an earlier version of Android Gradle Plugin, see [Preparing your build for package visibility in Android 11](https://android-developers.googleblog.com/2020/07/preparing-your-build-for-package-visibility-in-android-11.html).

> <span style="color:#e11d21">**Caution!**</span> Do not apply the QUERY_ALL_PACKAGES permission to Google Play Store.

<a id="mycard-2"></a>

### MyCard

<a id="androidname-setting"></a>

#### Configure android:name

If android:name is not defined, add it as follows.

```xml
<application
  android:name="com.nhncloud.android.iap.mycard.NhnCloudMyCardApplication"
  ...>
  ...
</application>
```

If android:name is already defined, inherit from the NhnCloudMyCardApplication class instead of the [Application](https://developer.android.com/reference/android/app/Application) class.


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

#### Test payment mode (optional)

To test payments, add 'test_mode'. If 'test_mode' is not set, the default value is false.

```xml
<application
  ...>
  <meta-data android:name="iap:test_mode" android:value="true | false"/>
</application>
```

<a id="store-codes"></a>

## Store codes

| Store | Code |
| ----------- | ---------- |
| Google Play | "GG" |
| ONE store | "ONESTORE" |
| Galaxy store | "GALAXY" |
| Amazon Appstore | "AMAZON" |
| Huawei App Gallery | "HUAWEI" |
| MyCard | "MYCARD" |

> [Note] Store codes are defined in the [IapStoreCode](./iap-android/#iapstorecode) class.

<a id="product-types"></a>

## Product Types

- There are currently three supported product types: consumable products, subscription products, and consumable subscription products.

| Product Name | Product Type | Description |
| ------ | ---------------- | -------------------------------------- |
| Consumable product | "CONSUMABLE" | A one-time consumable product. In-game currency and media files are examples of consumable products. |
| Subscription product | "AUTO_RENEWABLE" | A product that is automatically billed at regular intervals and prices. <br>Online magazines and music streaming services are examples of subscriptions. |
| Consumable subscription product | "CONSUMABLE_AUTO_RENEWABLE" | A consumable subscription product.<br>A billing method that regularly grants in-game currency, items, and more. |

> [Note] Subscription products and consumable subscription products are only supported on the **Google Play Store**.

<a id="in-app-purchase-iap-setting"></a>

## In-App Purchase Settings

* The [NhnCloudIapConfiguration](./iap-android/#nhncloudiapconfiguration) object contains in-app purchase configuration information.
* You can create a [NhnCloudIapConfiguration](./iap-android/#nhncloudiapconfiguration) object by using [NhnCloudIapConfiguration.Builder](./iap-android/#nhncloudiapconfigurationbuilder).
* Set the [AppKey](/Mobile%20Service/IAP/en/console-guide/#appkey) issued from the IAP console by using the setAppKey method.
* Set the [store code](./iap-android/#_3) to use for in-app purchases by using the setStoreCode method.

<a id="example-of-iap-setting"></a>

### In-App Purchase Settings Example

```java
NhnCloudIapConfiguration configuration =
    NhnCloudIapConfiguration.newBuilder(getApplicationContext())
                .setAppKey(YOUR_APP_KEY)
                .setStoreCode(IapStoreCode.GOOGLE_PLAY_STORE)
                .build();
```

<a id="initialize-iap"></a>

## Initialize In-App Purchase

- Call the NhnCloudIap.initialize() method to initialize NHN Cloud IAP.

<a id="specification-for-iap-initialization-api"></a>

### In-App Purchase Initialization API Specification

* Use the NhnCloudIap.initialize method to initialize in-app purchase.
* The NhnCloudIap.initialize method takes the [NhnCloudIapConfiguration](./iap-android/#nhncloudiapconfiguration) object created by [NhnCloudIapConfiguration.Builder](./iap-android/#nhncloudiapconfigurationbuilder) as a parameter.

```java
/* NhnCloudIap.java */
public static void initialize(NhnCloudIapConfiguration configuration)
```

| Parameters    |                                    |
| ------------- | ---------------------------------- |
| configuration | NhnCloudIapConfiguration: In-app purchase configuration |

<a id="example-of-iap-initialization"></a>

### In-App Purchase Initialization Example

- Initialize NhnCloudIap.

> [Note] Initialization must be performed in Application#onCreate.

```java
public class MainApplication extends Application {
    @Override
    public void onCreate() {
        super.onCreate();
        initializeNhnCloudIap();
    }

    /**
     * Initializes NhnCloudIap.
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

## Service login

* All products provided by the NHN Cloud SDK (IAP, Log & Crash, etc.) use a single user ID.
    * You can set the user ID with [NhnCloudSdk.setUserId](/nhncloud/en/nhncloud-sdk/getting-started-android/#userid).
    * If you do not set a user ID, payments will not proceed.
* We recommend that you implement the following features during the service login step: setting a user ID, querying unconsumed payment history, and querying active subscription products.

<a id="login"></a>

### Login

```java
// Login.
NhnCloudSdk.setUserId(userId);
```

<a id="logout"></a>

### Logout

```java
// Logout.
NhnCloudSdk.setUserId(null);
```

> [Note] When logging out of the service, you must set the user ID to null to prevent purchases from proceeding with an incorrect user ID when a promotional code is redeemed or payment reprocessing occurs.

<a id="register-purchases-update-listener"></a>

## Register a Payment Update Listener

* When a payment is made in-app, or when a promotion is redeemed or a subscription status changes (restoration, subscription renewal, etc.) in the Google Play Store app, the payment result is notified via the [IapService.PurchasesUpdatedListener](./iap-android/#iapservicepurchasesupdatedlistener) configured in NhnCloudIap.
* You can register a payment update listener using the NhnCloudIap.registerPurchasesUpdatedListener method.
* You can check payment information through the list of [IapPurchaseResult](./iap-android/#iappurchaseresult) delivered via the [IapService.PurchasesUpdatedListener](./iap-android/#iapservicepurchasesupdatedlistener).

> [Note] The payment update listener must be registered in Activity.onCreate() and unregistered in Activity.onDestroy().

<a id="specification-for-registering-purchases-update-listener-api"></a>

### Payment Update Listener Registration API Specifications

```java
/* NhnCloudIap.java */
public static void registerPurchasesUpdatedListener(IapService.PurchasesUpdatedListener listener)
public static void unregisterPurchasesUpdatedListener(IapService.PurchasesUpdatedListener listener)
```

| Method                             | Parameters |                                          | Description            |
| ---------------------------------- | ---------- | ---------------------------------------- | ---------------------- |
| registerPurchasesUpdatedListener   | listener   | IapService.<br>PurchasesUpdatedListener: <br>Payment update listener | Registers a payment update listener.    |
| unregisterPurchasesUpdatedListener | listener   | IapService.<br>PurchasesUpdatedListener: <br>Listener to unregister | Unregisters a payment update listener. |

<a id="example-of-registering-purchases-update-listener"></a>

#### Example of Registering a Payment Update Listener

```java
public class MainActivity extends AppCompatActivity {
    /**
     * Notifies the result when a consumable product, subscription, or promotion product is purchased in-app.
     */
    private IapService.PurchasesUpdatedListener mPurchaseUpdatedListener =
            new IapService.PurchasesUpdatedListener() {
                @Override
                public void onPurchasesUpdated(@NonNull List<IapPurchaseResult> purchaseResults) {
                    for (IapPurchaseResult purchaseResult : purchaseResults) {
                        if (purchaseResult.isSuccess()) {
                            // Success
                            IapPurchase purchase = purchaseResult.getPurchase();
                        } else {
                            // Failure
                        }
                    }
                }
            };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // Register the listener when onCreate is called.
        NhnCloudIap.registerPurchasesUpdatedListener(mPurchaseUpdatedListener);
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        // Make sure to remove the listener when onDestroy() is called.
        NhnCloudIap.unregisterPurchasesUpdatedListener(mPurchaseUpdatedListener);
    }
}
```

> [Note] If the Activity is terminated before the payment result is notified via IapService.PurchasesUpdatedListener, the payment data may be lost.
> To process payments safely, you must prevent users from closing the Activity (by clicking the Back button or the Exit button) before the payment result is notified.

<a id="query-product-list"></a>

## List products

* Retrieves a list of available products registered in the IAP console.
* Products that can be purchased are returned as an [IapProductDetails](./iap-android/#iapproductdetails) list (Product Details List).
* Products registered in the IAP console but not registered in the store are returned as an [IapProduct](./iap-android/#iapproduct) list (Invalid Product List).

<a id="specification-for-product-list-query-api"></a>

### Query product list API specification

```java
/* NhnCloudIap.java */
public static void queryProductDetails(Activity activity,
                                       IapService.ProductDetailsResponseListener listener)
```

| Method              | Parameters |                                          |
| ------------------- | ---------- | ---------------------------------------- |
| queryProductDetails | activity   | Activity: The currently active Activity               |
|                     | listener   | IapService.<br>ProductDetailsResponseListener: <br>Listener for product query results |


<a id="example-of-product-list-query"></a>

### Product list query example

```java
/**
 * Retrieves products available for purchase.
 * <p>
 * productDetails : List of products available for purchase
 * invalidProducts : Products registered in the NHN Cloud IAP console but not registered in the store
 */
void queryProductDetails() {
    IapService.ProductDetailsResponseListener responseListener =
            new IapService.ProductDetailsResponseListener() {
                @Override
                public void onProductDetailsResponse(@NonNull IapResult result,
                                                     @Nullable List<IapProductDetails> productDetails,
                                                     @Nullable List<IapProduct> invalidProducts) {
                    if (result.isSuccess()) {
                        // Query successful
                    } else {
                        // Query failed
                    }
                }
            }

    NhnCloudIap.queryProductDetails(MainActivity.this, responseListener);
}
```

<a id="purchase-products"></a>

## Purchase Products

* You can purchase products in NHN Cloud IAP by using the product ID registered in the store.
* Product information is included in the [IapProductDetails](./iap-android/#iapproductdetails) object returned by calling the NhnCloudIap.queryProductDetails() method.
* You can get the product ID by using the IapProductDetails.getProductId() method.
* To purchase a product, set the product ID in the [IapPurchaseFlowParams](./iap-android/#iappurchaseflowparams) object, and then start the purchase flow by using the NhnCloudIap.launchPurchaseFlow() method.
* You can create the [IapPurchaseFlowParams](./iap-android/#iappurchaseflowparams) object by using [IapPurchaseFlowParams.Builder](./iap-android/#iappurchaseflowparamsbuilder).
* The product purchase result is returned through the [IapService.PurchasesUpdatedListener](./iap-android/#iapservicepurchasesupdatedlistener) registered in NhnCloudIap.

<a id="specification-for-product-purchase-iap"></a>

### Purchase Products IAP Specification

```java
/* NhnCloudIap.java */
public static void launchPurchaseFlow(Activity activity,
                                      IapPurchaseFlowParams params)
```

| Method             | Parameters |                                                        |
| ------------------ | ---------- | ------------------------------------------------------ |
| launchPurchaseFlow | activity   | Activity: The currently active Activity                |
|                    | params     | IapPurchaseFlowParams: Purchase information parameters |

<a id="example-of-product-purchase"></a>

### Example of Product Purchase

```java
/**
 * Purchases a product.
 */
void launchPurchaseFlow(Activity activity, String productId) {
    IapPurchaseFlowParams params = IapPurchaseFlowParams.newBuilder()
            .setProductId(productId)
            .build();
    NhnCloudIap.launchPurchaseFlow(activity, params);
}
```

<a id="set-user-data"></a>

### Set User Data

* NHN Cloud IAP allows you to add user information when making a purchase request.
* User information is set using the setDeveloperPayload() method of IapPurchaseFlowParams.Builder.
* You can check the set user information using the getDeveloperPayload() method of [IapPurchase](./iap-android/#iappurchase) returned when querying unconsumed purchases and active subscriptions.

```java
String userData = "User Data"
IapPurchaseFlowParams params = IapPurchaseFlowParams.newBuilder()
       .setProductId(productId)
       .setDeveloperPayload(userData)
       .build();
NhnCloudIap.launchPurchaseFlow(activity, params);
```

> If you purchase a product using a promotion code on the Google Play Store, user data cannot be used.

<a id="query-unconsumed-purchases"></a>

## Query unconsumed purchases

* Retrieves information on one-time products (CONSUMABLE) and consumable subscription products (CONSUMABLE_AUTO_RENEWABLE) that have not yet been consumed.
* After granting products to the user, consume the products by using the [Consume API](/Mobile%20Service/IAP/en/api-guide-for-toast-sdk/#consume-api).
* You can query unconsumed purchases by using the NhnCloudIap.queryConsumablePurchases() method.
* You can query unconsumed purchases for the current store or all stores by using [IapQueryPurchasesParams](./iap-android/#iapquerypurchasesparams).
* The query results are returned as a list of [IapPurchase](./iap-android/#iappurchase) objects through [IapService.PurchasesResponseListener](./iap-android/#iapservicepurchasesresponselistener).

<a id="specification-for-unconsumed-purchases-query-api"></a>

### Query unconsumed purchases API specification

```java
/* NhnCloudIap.java */
public static void queryConsumablePurchases(Activity activity,
                                            IapQueryPurchasesParams params,
                                            IapService.PurchasesResponseListener listener)
```

| Method                   | Parameters |                                          |
| ------------------------ | ---------- | ---------------------------------------- |
| queryConsumablePurchases | activity   | Activity: The currently active Activity               |
|                          | params     | IapQueryPurchasesParams: Parameters for querying unconsumed purchase history |
|                          | listener   | IapService.PurchasesResponseListener: <br>Listener for unconsumed purchase history query results |

<a id="example-of-unconsumed-purchases-query"></a>

### Query unconsumed purchases example

```java
/**
 * Queries unconsumed purchase history.
 */
void queryConsumablePurchases(boolean isQueryAllStores) {
    IapQueryPurchasesParams params = IapQueryPurchasesParams.newBuilder()
        .setQueryAllStores(isQueryAllStores) // Query all stores: true, query current store: false
        .build();
    PurchasesResponseListener responseListenr =
            new IapService.PurchasesResponseListener() {
                @Override
                public void onPurchasesResponse(@NonNull IapResult result,
                                                @Nullable List<IapPurchase> purchases) {
                    if (result.isSuccess()) {
                        // Success
                    } else {
                        // Failure
                    }
                }
            };
    NhnCloudIap.queryConsumablePurchases(MainActivity.this, params, responseListenr);
}
```

<a id="query-activated-subscription"></a>

## Query activated subscriptions

* You can query activated subscription products (AUTO_RENEWABLE & CONSUMABLE_AUTO_RENEWABLE) based on the user ID.
* Subscription products that have been paid for can continue to be queried as long as the usage period remains.
* You can query activated subscriptions by using the NhnCloudIap.queryActivatedPurchases() method.
* You can query activated subscriptions for the current store or all stores by using [IapQueryPurchasesParams](./iap-android/#iapquerypurchasesparams).
* The query result returns a list of [IapPurchase](./iap-android/#iappurchase) objects through [IapService.PurchasesResponseListener](./iap-android/#iapservicepurchasesresponselistener).
* Subscription products purchased on iOS can also be queried on Android.

> Subscription products currently only support the Google Play Store.

<a id="specification-for-activated-subscription-query-api"></a>

### Activated subscription query API specification

```java
/* NhnCloudIap.java */
public static void queryActivatedPurchases(Activity activity,
                                           IapQueryPurchasesParams params,
                                           PurchasesResponseListener listener)
```

| Method                  | Parameters |                                          |
| ----------------------- | ---------- | ---------------------------------------- |
| queryActivatedPurchases | activity   | Activity: The currently active Activity               |
|                         | params     | IapQueryPurchasesParams: Parameters for querying activated subscriptions |
|                         | listener   | IapService.PurchasesResponseListener: <br>Listener for activated subscription query results |

<a id="example-of-activated-subscription-query"></a>

### Example of activated subscription query

```java
/**
 * Query activated subscription products
 */
void queryActivatedPurchases(boolean isQueryAllStores) {
    IapQueryPurchasesParams params = IapQueryPurchasesParams.newBuilder()
        .setQueryAllStores(isQueryAllStores) // Query all stores: true, Query current store: false
        .build();
    PurchasesResponseListener responseListener =
            new IapService.PurchasesResponseListener() {
                @Override
                public void onPurchasesResponse(@NonNull IapResult result,
                                                @Nullable List<IapPurchase> purchases) {
                    if (result.isSuccess()) {
                        // Success
                    } else {
                        // Failure
                    }
                }
            };
    NhnCloudIap.queryActivatedPurchases(MainActivity.this, params, responseListener);
}
```

<a id="query-subscription-status"></a>

## Query Subscription Status

* You can view the status of subscription products purchased based on the user ID.
* Expired subscription products can be included or excluded using the includeExpiredSubscriptions setting. (default: false)
* You can query the subscription product status by using the NhnCloudIap.querySubscriptionsStatus() method.
* The query result returns a list of [IapSubscriptionStatus](./iap-android/#iapsubscriptionstatus) objects through [IapService.SubscriptionsStatusResponseListener](./iap-android/#iapservicesubscriptionsstatusresponselistener).
* The subscription status codes used by [IapSubscriptionStatus](./iap-android/#iapsubscriptionstatus) are defined in [IapSubscriptionStatus.StatusCode](./iap-android/#iapsubscriptionstatusstatuscode).

```
Subscription products currently only support the Google Play Store.
```

<a id="specification-for-subscription-status-query-api"></a>

### Subscription Status Query API Specification

```java
/* NhnCloudIap.java */
public static void querySubscriptionsStatus(Activity activity,
                                            boolean includeExpiredSubscriptions,
                                            IapService.SubscriptionsStatusResponseListener listener)
```

| Method | Parameters |  |
| --- | --- | --- |
| querySubscriptionsStatus | activity | Activity: The currently active Activity |
|  | includeExpiredSubscriptions | boolean:<br>Whether to include the status of expired subscription products |
|  | listener | IapService.SubscriptionsStatusResponseListener:<br>Listener for the subscription status query result |

<a id="example-of-subscription-status-query"></a>

### Subscription Status Query Example

```java
/**
 * Query subscription status
 */
private void querySubscriptionsStatus() {
    SubscriptionsStatusResponseListener listener =
            new SubscriptionsStatusResponseListener() {
                @Override
                public void onSubscriptionsStatusResponse(@NonNull String storeCode,
                                                          @Nullable List<IapSubscriptionStatus> subscriptionsStatus) {
                    if (result.isSuccess()) {
                        // Success
                    } else {
                        // Failure
                    }
                }
            };
    NhnCloudIap.querySubscriptionsStatus(MainActivity.this, false, listener);
}
```

<a id="google-store-subscription-feature"></a>

## Google Play Store subscription (recurring billing) features

This section explains how to handle lifecycle events such as renewals and expirations for subscription billing on the Google Play Store.
For more information, see [Add subscription-specific features](https://developer.android.com/google/play/billing/billing_subscriptions).

<a id="subscription-lifecycle-handling"></a>

### Handle subscription lifecycle

A Google Play Store subscription goes through various state changes during its lifecycle, and your app must respond to each state accordingly.

* **Active**: The user has access to subscription content and auto-renewal is in progress.
* **Cancelled**: The user has access to subscription content, but auto-renewal is stopped because the user cancelled the subscription.
* **In grace period**: The subscription payment failed due to a payment method issue, but the user still has access to subscription content (waiting for the user to update their payment method).
* **On hold**: The subscription payment failed due to a payment method issue and the account is on hold (if the grace period was enabled, the payment was put on hold because the payment method was not updated during the grace period).
* **Paused**: The subscription is temporarily paused.
* **Expired**: The subscription has expired.

| Status | Consumable purchases query<br>(NhnCloudIap.queryConsumablePurchases) | Active subscription query<br>(NhnCloudIap.queryActivatedPurchases) | Expiration time | Auto-renewal |
| --- | --- | --- | --- | --- |
| Active | Yes | Yes | Future time | Yes |
| Cancelled | Yes | Yes | Future time | No |
| In grace period | No | Yes | Future time | Yes |
| On hold | No | No | Past time | Yes |
| Paused | No | No | Past time | Yes |
| Expired | No | No | Past time | No |

<a id="grace-period"></a>

### Grace period

If the grace period is enabled and there is a problem with the payment method at the end of a billing cycle, the subscription transitions to the grace period.
<span style="color:#e11d21">During the grace period, users must be able to access subscription content.</span>
For more information, see [Grace period](https://developer.android.com/google/play/billing/subs#grace).

> <span style="color:#e11d21">**Caution!)**</span> If the subscription is restored during the grace period (for example, by updating the payment method), auto-renewal resumes. NHN Cloud IAP notifies you of the renewed payment result through the payment update listener (IapService.PurchaseUpdatedListener). Games and apps must ensure that the payment update listener does not expose unnecessary pop-ups to users during critical operations.

<a id="ordinary-subscription-product-autorenewable"></a>

#### Standard subscription product (AUTO_RENEWABLE))

* Standard subscription products must be able to access subscription content during the grace period.
* They can be queried with NhnCloudIap.queryActivatedPurchases() during the grace period.

<a id="consumable-subscription-product-consumableautorenewable"></a>

#### Consumable subscription product (CONSUMABLE_AUTO_RENEWABLE)

* When the grace period begins, Google issues a new receipt, but if the payment method is not updated, the account will transition to on hold or be cancelled.
* Consumable subscription products are not returned by NhnCloudIap.queryConsumablePurchases() during the grace period to prevent the product from being consumed.

<a id="account-hold"></a>

### Account hold

Account hold refers to the state of a user when renewal fails due to a payment method issue.
If a payment fails, it is retried during the grace period; if the payment continues to fail during the grace period, the subscription status becomes on hold.
Users in the account hold state cannot access subscription content.
The account hold period is up to 30 days.
If the payment method is not updated before the account hold period ends, the subscription is cancelled.
For more information, see [Account hold](https://developer.android.com/google/play/billing/subs#account-hold).

> <span style="color:#e11d21">**Caution!)**</span> If the subscription is restored during the account hold period (for example, by updating the payment method), auto-renewal resumes. NHN Cloud IAP notifies you of the renewed payment result through the payment update listener (IapService.PurchaseUpdatedListener). Games and apps must ensure that the payment update listener does not expose unnecessary pop-ups to users during critical operations.

<a id="ordinary-subscription-product-autorenewable-2"></a>

#### Standard subscription product (AUTO_RENEWABLE))

* Standard subscription products cannot access subscription content during the account hold period.
* They are not returned by NhnCloudIap.queryActivatedPurchases() during the account hold period.

<a id="consumable-subscription-product-consumableautorenewable-2"></a>

#### Consumable subscription product (CONSUMABLE_AUTO_RENEWABLE)

* Consumable subscription products do not generate new purchases during the account hold period.
* New purchases are not returned by NhnCloudIap.queryConsumablePurchases() during the account hold period.

<a id="pause"></a>

### Pause

If you enable the pause feature, users can pause their subscription for a period of between 1 week and 3 months.
A subscription pause takes effect after the current subscription period ends.
When the pause period ends, the subscription automatically resumes.
For more information, see [Pause](https://developer.android.com/google/play/billing/subs#pause).

> <span style="color:#e11d21">**Caution!)**</span> When the pause period ends, auto-renewal resumes. NHN Cloud IAP notifies you of the renewed payment result through the payment update listener (IapService.PurchaseUpdatedListener). Games and apps must ensure that the payment update listener does not expose unnecessary pop-ups to users during critical operations.

<a id="ordinary-subscription-product-autorenewable-3"></a>

#### Standard subscription product (AUTO_RENEWABLE))

* Standard subscription products cannot access subscription content during the pause period.
* They are not returned by NhnCloudIap.queryActivatedPurchases() during the pause period.

<a id="consumable-subscription-product-consumableautorenewable-3"></a>

#### Consumable subscription product (CONSUMABLE_AUTO_RENEWABLE)

* Consumable subscription products do not generate new purchases during the pause period.
* New purchases are not returned by NhnCloudIap.queryConsumablePurchases() during the pause period.

<a id="resubscription"></a>

### Resubscription

If you enable the resubscription feature, users can resubscribe to a cancelled subscription within 12 months of the subscription's expiration date.
Resubscription creates a new subscription and purchase token.
After a subscription expires, users can repurchase the same product through the Google Play subscription center for up to one year after expiration.
For more information, see [Resubscription](https://developer.android.com/google/play/billing/subs#resubscribe).

> <span style="color:#e11d21">**Caution!)**</span> Because the purchase is not processed within the app or game screen, user data (IapPurchase.getDeveloperPayload()) is not available.
> <span style="color:#e11d21">**Caution!)**</span> When a subscription product is purchased through resubscription on the Google Play Store, NHN Cloud IAP notifies you of the purchased payment result through the payment update listener (IapService.PurchaseUpdatedListener). Games and apps must ensure that the payment update listener does not expose unnecessary pop-ups to users during critical operations.

<a id="nhn-cloud-iap-class-reference"></a>

## NHN Cloud IAP Class Reference

<a id="nhncloudiapconfiguration"></a>

### NhnCloudIapConfiguration

In-app purchase configuration information used as a parameter for the NHN Cloud IAP initialization method.

```java
/* NhnCloudIapConfiguration.java */
public String getAppKey();
public String getStoreCode();
```

| Method       | Returns |                                     |
| ------------ | ------- | ----------------------------------- |
| getAppKey    | String  | App key of the IAP service                         |
| getStoreCode | String  | Store code information ("GG" or "ONESTORE", "GALAXY", ...) |

<a id="nhncloudiapconfigurationbuilder"></a>

### NhnCloudIapConfiguration.Builder

Creates a [NhnCloudIapConfiguration](./iap-android/#nhncloudiapconfiguration) object by taking an IAP service Appkey, store type, and other parameters.

```java
/* NhnCloudIapConfiguration.java */
public void setAppKey(String appKey)
public void setStoreCode(String storeCode)
```

| Method       | Parameters |                     | Description                              |
| ------------ | ---------- | ------------------- | ---------------------------------------- |
| setAppKey    | appKey     | String: IAP service Appkey | Sets the Appkey created in the TOAST IAP console.      |
| setStoreCode | storeCode  | String: Store code information   | Sets the store code.<br>("GG" or "ONESTORE", "GALAXY", ...) |

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

* GOOGLE_PLAY_STORE<br>Uses Google Play Store in-app purchases.<br>Constant Value: "GG"
* ONE_STORE<br>Uses ONE store in-app purchases.<br>Constant Value: "ONESTORE"
* GALAXY_STORE<br>Uses Galaxy store in-app purchases.<br>Constant Value: "GALAXY"
* AMAZON_APP_STORE<br>Uses Amazon Appstore in-app purchases.<br>Constant Value: "AMAZON"
* HUAWEI_APP_GALLERY<br>Uses Huawei App Gallery in-app purchases.<br>Constant Value: "HUAWEI"
* MYCARD<br>Uses MyCard in-app purchases.<br>Constant Value: "MYCARD"

<a id="iappurchaseresult"></a>

### IapPurchaseResult

* An object that contains the payment result and payment information.

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
| getPurchase | IapPurchase | Returns an IapPurchase object that contains the payment information. |
| getCode     | int         | Returns the payment result code.                 |
| getMessage  | String      | Returns the payment result message.                |
| getCause    | Throwable   | Returns the cause of the payment failure.                 |
| isSuccess   | boolean     | Returns whether the payment was successful.                 |
| isFailure   | boolean     | Returns whether the payment failed.                 |

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
| getCode    | int       | Returns the result code.  |
| getMessage | String    | Returns the result message. |
| getCause   | Throwable | Returns the cause of the failure.  |
| isSuccess  | boolean   | Returns whether the operation was successful.  |
| isFailure  | boolean   | Returns whether the operation failed.  |

<a id="iappurchase"></a>

### IapPurchase

* You can check payment information with the IapPurchase object.

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

| Method               | Returns |                      |
| -------------------- | ------- | -------------------- |
| getPaymentId         | String  | Returns the payment ID.        |
| getOriginalPaymentId | String  | Returns the original payment ID.     |
| getPaymentSequence   | String  | Returns the unique payment sequence number.     |
| getProductId         | String  | Returns the product ID.        |
| getProductType       | String  | Returns the product type.        |
| getUserId            | String  | Returns the user ID.       |
| getPrice             | float   | Returns the price information.        |
| getPriceCurrencyCode | String  | Returns the currency information.        |
| getAccessToken       | String  | Returns the token used for consumption.  |
| getPurchaseType      | String  | Returns the product type.        |
| getPurchaseTime      | long    | Returns the time of product purchase.     |
| getExpiryTime        | long    | Returns the remaining time of a subscription product. |
| getDeveloperPayload  | String  | Returns the user data. |

<a id="iapproductdetails"></a>

### IapProductDetails

* You can check product details using the IapProductDetails object.
* It includes information registered in the NHN Cloud IAP console and detailed information registered in the Google Play Console or ONE store Developer.

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

| Method                | Returns |                                  |
| --------------------- | ------- | -------------------------------- |
| getProductId          | String  | Product ID                       |
| getProductSequence    | String  | Unique product number            |
| getPrice              | float   | Price                            |
| getLocalizedPrice     | String  | Localized price                  |
| getPriceCurrencyCode  | String  | Currency                         |
| getPriceAmountMicros  | long    | Price in units of 1,000,000      |
| getFreeTrialPeriod    | String  | Free trial period                |
| getSubscriptionPeriod | String  | Subscription period              |
| getProductType        | String  | Product type                     |
| getProductTitle       | String  | Product title                    |
| getProductDescription | String  | Product description              |
| isActivated           | boolean | Whether the product is activated |

<a id="iapproduct"></a>

### IapProduct

* You can view brief information registered in the NHN Cloud IAP console.

```java
/* IapProduct.java */
public String getProductId()
public String getProductSequence()
public String getProductType()
public String getProductTitle()
public String getProductDescription()
public boolean isActivated()
```

| Method                | Returns |                                    |
| --------------------- | ------- | ---------------------------------- |
| getProductId          | String  | Product ID                         |
| getProductSequence    | String  | Unique product number              |
| getProductType        | String  | Product type                       |
| getProductTitle       | String  | Product title                      |
| getProductDescription | String  | Product description                |
| isActivated           | boolean | Whether the product is activated   |

<a id="iappurchaseflowparams"></a>

### IapPurchaseFlowParams

* IapPurchaseFlowParams contains information about the product to purchase.

```java
/* IapPurchaseFlowParams.java */
public String getProductId()
```

| Method       | Returns |            |
| ------------ | ------- | ---------- |
| getProductId | String  | Product ID |

<a id="iappurchaseflowparamsbuilder"></a>

### IapPurchaseFlowParams.Builder

* Creates an IapPurchaseFlowParams object.

```java
/* IapPurchaseFlowParams.java */
public void setProductId(String productId)
```

| Method       | Parameters |                      | Description         |
| ------------ | ---------- | -------------------- | ------------------- |
| setProductId | productId  | String: product ID   | Sets the product ID. |

<a id="iapquerypurchasesparams"></a>

### IapQueryPurchasesParams

* IapQueryPurchasesParams sets the conditions for querying.

```java
/* IapQueryPurchasesParams.java */
public String isQueryAllStores()
```

| Method           | Returns  |                    |
| ---------------- | -------- | ------------------ |
| isQueryAllStores | boolean  | Query all stores   |

<a id="iapquerypurchasesparamsbuilder"></a>

### IapQueryPurchasesParams.Builder

* Creates an IapQueryPurchasesParams object.

```java
/* IapQueryPurchasesParams.java */
public void setQueryAllStores(boolean isQueryAllStores)
```

| Method            | Parameters       |                             | Description             |
| ----------------- | ---------------- | --------------------------- | ----------------------- |
| setQueryAllStores | isQueryAllStores | boolean: query all stores   | Sets the query scope.   |

<a id="iapsubscriptionstatus"></a>

### IapSubscriptionStatus

* You can check the subscription status information using the IapSubscriptionStatus object.
* Subscription status codes are defined in IapSubscriptionStatus.StatusCode.

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
| getStoreCode | String | Returns the store code. |
| getPaymentId | String | Returns the payment ID. |
| getOriginalPaymentId | String | Returns the original payment ID. |
| getPaymentSequence | String | Returns the unique payment number. |
| getProductId | String | Returns the product ID. |
| getProductType | String | Returns the product type. |
| getProductSeq | String | Returns the unique product number. |
| getUserId | String | Returns the user ID. |
| getPrice | float | Returns the price information. |
| getPriceCurrencyCode | String | Returns the currency information. |
| getAccessToken | String | Returns the token used for consumption. |
| getPurchaseType | String | Returns the purchase type.<br>"Test" or "Promo" or null |
| getPurchaseTime | long | Returns the product purchase time. |
| getExpiryTime | long | Returns the remaining time of the subscription product. |
| getDeveloperPayload | String | Returns the developer payload. |
| getStatusCode | int | Returns the subscription status code. |
| getStatusDescription | String | Returns the description of the subscription status code. |

<a id="iapsubscriptionstatusstatuscode"></a>

### IapSubscriptionStatus.StatusCode

* Represents the subscription status codes.

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
| ACTIVE | 0 | Active | The subscription is active. |
| CANCELED | 3 | Canceled | The subscription has been canceled. |
| ON\_HOLD | 5 | Account hold | The recurring payment is placed on account hold (if enabled). |
| IN\_GRACE\_PERIOD | 6 | Grace period | The recurring payment has transitioned to a grace period state (if enabled). |
| PAUSED | 10 | Paused | The subscription has been paused. |
| REVOKED | 12 | Revoked | The recurring payment was canceled by the user before the expiration time. |
| EXPIRED | 13 | Expired | The recurring payment has expired. |
| UNKNOWN | 9999 | Undefined | The status is not defined. |

<a id="iapservicepurchasesupdatedlistener"></a>

### IapService.PurchasesUpdatedListener

* When payment information is updated, you are notified through the `onPurchasesUpdated` method of an object that extends `IapService.PurchasesUpdatedListener`.

```java
void onPurchasesUpdated(List<IapPurchaseResult> purchaseResults)
```

<a id="iapservicepurchasesresponselistener"></a>

### IapService.PurchasesResponseListener

* When querying unconsumed payments or active subscriptions, you are notified through the `onPurchasesResponse` method of an object that extends `IapService.PurchasesResponseListener`.

```java
void onPurchasesResponse(IapResult result,
                         List<IapPurchase> purchaseList)
```

<a id="iapservicesubscriptionsstatusresponselistener"></a>

### IapService.SubscriptionsStatusResponseListener

* When querying subscription status, you are notified through the `onSubscriptionsStatusResponse` method of an object that extends `SubscriptionsStatusResponseListener`.

```java
void onSubscriptionsStatusResponse(IapResult result,
                                   List<IapSubscriptionStatus> subscriptionsStatus);
```

<a id="error-codes"></a>

## Error Codes

<a id="common-error-codes"></a>

### Common Error Codes

| RESULT                 | CODE | DESC                                     |
| ---------------------- | ---- | ---------------------------------------- |
| FEATURE_NOT_SUPPORTED  | -2   | Requested feature is not supported. |
| SERVICE_DISCONNECTED   | -1   | Store service is not connected. |
| OK                     | 0    | Success. |
| USER_CANCELED          | 1    | User canceled. |
| SERVICE_UNAVAILABLE    | 2    | Network connection is down. |
| BILLING_UNAVAILABLE    | 3    | API version is not supported for the type requested. |
| PRODUCT_UNAVAILABLE    | 4    | Requested product is not available. |
| DEVELOPER_ERROR        | 5    | Developer error. |
| ERROR                  | 6    | Fatal error during the API action. |
| PRODUCT_ALREADY_OWNED  | 7    | Failure to purchase since item is already owned. |
| PRODUCT_NOT_OWNED      | 8    | Failure to consume since item is not owned. |
| USER_ID_NOT_REGISTERED | 9    | User ID is not registered. |
| NETWORK_ERROR          | 12   | A network error occurred during the operation. |
| UNDEFINED_ERROR        | 9999 | Undefined error. |

<a id="server-error-codes"></a>

### Server Error Codes

| RESULT                    | CODE | DESC                                     |
| ------------------------- | ---- | ---------------------------------------- |
| INACTIVATED_APP           | 101  | App is not active. |
| VERIFY_PURCHASE_FAILED    | 103  | Failure to verify purchase. |
| PURCHASE_ALREADY_CONSUMED | 104  | Purchase already consumed. |
| PURCHASE_ALREADY_REFUNDED | 105  | Purchase already refunded. |
| PURCHASE_LIMIT_EXCEEDED   | 106  | Purchase limit exceeded. |

<a id="one-store-error-codes"></a>

### ONE store Error Codes

| RESULT                   | CODE | DESC                                     |
| ------------------------ | ---- | ---------------------------------------- |
| ONESTORE_NEED_LOGIN      | 301  | ONE store service is not logged in. |
| ONESTORE_NEED_UPDATE     | 302  | ONE store service is not updated or installed. |
| ONESTORE_SECURITY_ERROR  | 303  | Abnormal purchase request. |
| ONESTORE_PURCHASE_FAILED | 304  | Purchase request failed. |

<a id="galaxy-store-error-codes"></a>

### Galaxy store Error Codes

| RESULT                   | CODE | DESC                                     |
| ------------------------ | ---- | ---------------------------------------- |
| GALAXY_NOT_LOGGED_IN     | 501  | Galaxy service is not logged in. |
| GALAXY_NOT_UPDATED       | 502  | Galaxy service is not updated or installed. |
| GALAXY_PURCHASE_FAILED   | 503  | Galaxy purchase failed. |
| GALAXY_SERVICE_DENIED    | 504  | Galaxy service denied. |