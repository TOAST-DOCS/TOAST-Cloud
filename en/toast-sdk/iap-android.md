## TOAST > TOAST SDK User Guide > TOAST IAP > Android

## Prerequisites

1. [Install TOAST SDK](./getting-started-android).
2. [Enable IAP service](https://docs.toast.com/ko/Mobile%20Service/IAP/ko/console-guide/#iap-appkey) in [TOAST console](https://console.cloud.toast.com).
3. [Check AppKey](https://docs.toast.com/ko/Mobile%20Service/IAP/ko/console-guide/#appkey) in IAP console.

## In-App Purchase Guide for Each Store Type

- [Android Developers In-App Purchase](https://developer.android.com/google/play/billing)
- [ONE store In-App Purchase API V5 (SDK V17) Guide and Download](https://dev.onestore.co.kr/devpoc/reference/view/Tools)
- [Galaxy store In-App Purchase API Guide and Download](https://developer.samsung.com/iap/overview.html)

## Library Setting

- To use in-app purchase of Google Play Store, add dependency to build.gradle as below:

```groovy
repositories {
    google()
    mavenCentral()
}

dependencies {
    implementation 'com.toast.android:toast-iap-google:0.28.0'
    ...
}
```

- To use in-app purchase of ONE store, add dependency to build.gradle as below:

```groovy
repositories {
    mavenCentral()
}

dependencies {
    implementation 'com.toast.android:toast-iap-onestore:0.28.0'
    ...
}
```

- To use in-app purchase of Galaxy store, add dependency to build.gradle as below:

```groovy
repositories {
    mavenCentral()
}

dependencies {
    implementation 'com.toast.android:toast-iap-galaxy:0.28.0'
    ...
}
```

> Galaxy Store in-app purchase works on Android 4.3 (API level 18) or higher.

## AndroidManifest Setting

### ONE store purchase screen setting (optional)

ONE store supports full purchase screen and pop-up purchase screen.
You can add metadata to AndroidManifest.xml to select the full purchase screen ("full") or pop-up purchase screen ("popup").
If metadata is not set, the default value ("full") is applied.

```xml
<application
  ...>
  <meta-data android:name="iap:view_option" android:value="popup | full"/>
</application>
```

| Purchase Screen | Setting Value |
| -- | -- |
| Full Purchase Screen | "full" |
| Pop-up Purchase Screen | "popup" |

For more information, see [ONE store Purchase Screen Setting](https://dev.onestore.co.kr/devpoc/reference/view/Tools).

### App targeting Android 11 or higher (ONE store, Galaxy Store)

In Android 11, an app queries other apps that the user installed on the device and changes the way to interact with the apps.
To use ONE store or Galaxy Store purchase in an app targeting Android 11 or higher, you must define 'queries' element in AndroidManifest.xml as below.

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

The 'queries' element works in Android Gradle Plugin 4.1 or higher.
To use a lower version of Android Gradle Plugin, see [Preparing your Gradle build for package visibility in Android 11](https://android-developers.googleblog.com/2020/07/preparing-your-build-for-package-visibility-in-android-11.html).

## Store Codes

| Store         | Code         |
| ----------- | ---------- |
| Google Play Store | "GG"       |
| ONE store   | "ONESTORE" |
| Galaxy store | "GALAXY" |

> [Note] Store codes are defined in the [IapStoreCode](./iap-android/#iapstorecode) class.

## Product Types

- Three types of products are currently supported: consumable products, subscription products, and consumable subscription products.

| Product Name    | Product Type             | Description                                     |
| ------ | ---------------- | -------------------------------------- |
| Consumable products | "CONSUMABLE"     | Examples of Consumable Products: consumable one-time products, in-game goods, and media files. |
| Subscription products  | "AUTO_RENEWABLE" | Examples of Subscription products: products that are automatically purchased at specific interval and price, <br>and online magazines and music streaming services. |
| Consumable subscription products | "CONSUMABLE_AUTO_RENEWABLE" | A subscription product that can be consumed<br>This is a payment method that provides in-game goods and items periodically. |

> [Note] Subscription products and consumable subscription products are supported by **Google Play Store** only.

## In-App Purchase (IAP) Setting

* [ToastIapConfiguration](./iap-android/#toastiapconfiguration) object includes IAP setting information.
* [ToastIapConfiguration](./iap-android/#toastiapconfiguration) object can be created by using [ToastIapConfiguration.Builder](./iap-android/#toastiapconfigurationbuilder).
* Use the setAppKey method to set [AppKey](https://docs.toast.com/ko/Mobile%20Service/IAP/ko/console-guide/#appkey) issued from IAP console.
* Use the setStoreCode method to set [Store Code](./iap-android/#_3) for IAP.

### Example of IAP Setting

```java
ToastIapConfiguration configuration =
    ToastIapConfiguration.newBuilder(getApplicationContext())
                .setAppKey(YOUR_APP_KEY)
                .setStoreCode(IapStoreCode.GOOGLE_PLAY_STORE)
                .build();
```

## Initialize IAP

- Call the ToastIap.initialize() method to initialize TOAST IAP.

### Specification for IAP Initialization API

* IAP is initialized by using the ToastIap.initialize method.
* The ToastIap.initialize method uses [ToastIapConfiguration](./iap-android/#toastiapconfiguration) object created by [ToastIapConfiguration.Builder](./iap-android/#toastiapconfigurationbuilder) as a parameter.

```java
/* ToastIap.java */
public static void initialize(ToastIapConfiguration configuration)
```

| Parameters    |                                    |
| ------------- | ---------------------------------- |
| configuration | ToastIapConfiguration: Information for IAP setting |

### Example of IAP Initialization

- Initialize ToastIap.

> [Note] Initialization must be performed in Application#onCreate.

```java
public class MainApplication extends Application {
    @Override
    public void onCreate() {
        super.onCreate();
        initializeToastIap();
    }

    /**
     * Initialize ToastIap.
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

## Service Login

* All products provided by TOAST SDK, such as IAP and Log & Crash, use the same user ID.
    * User ID can be set with [ToastSdk.setUserId](https://docs.toast.com/ko/TOAST/ko/toast-sdk/getting-started-android/#userid).
    * When user ID is not set, purchase cannot proceed.
* It is recommended to implement the following features in service login step: user ID setting, querying unconsumed purchase history, and querying active subscription products.

### Login

```java
// Login.
ToastSdk.setUserId(userId);
```

### Logout

```java
// Logout.
ToastSdk.setUserId(null);
```

> [Note] When the service is logged out, user ID must be set to null. Otherwise, promotion codes might be redeemed or purchase with wrong user ID might occur in purchase reprocessing operation.

## Register Purchases Update Listener

* When promotion redemption or subscription status change (recovery, resubscription, etc.) occurs on in-app purchases or  Google Play Store app, the purchase result is notified via [IapService.PurchasesUpdatedListener](./iap-android/#iapservicepurchasesupdatedlistener) set in ToastIap.
* Purchases update listener can be registered by using the ToastIap.registerPurchasesUpdatedListener method.
* Purchase information is available on the list of [IapPurchaseResult](./iap-android/#iappurchaseresult) delivered by [IapService.PurchasesUpdatedListener](./iap-android/#iapservicepurchasesupdatedlistener).

> Note: Purchases update listener must be registered in Activity.onCreate() and unregistered in Activity.onDestroy().

### Specification for Registering Purchases Update Listener API

```java
/* ToastIap.java */
public static void registerPurchasesUpdatedListener(IapService.PurchasesUpdatedListener listener)
public static void unregisterPurchasesUpdatedListener(IapService.PurchasesUpdatedListener listener)
```

| Method                             | Parameters |                                          | Description            |
| ---------------------------------- | ---------- | ---------------------------------------- | ---------------------- |
| registerPurchasesUpdatedListener   | listener   | IapService.<br>PurchasesUpdatedListener: <br>Listener for update on purchases | Registers purchases update listener.    |
| unregisterPurchasesUpdatedListener | listener   | IapService.<br>PurchasesUpdatedListener: <br>Listener to unregister | Unregisters purchases update listener. |

#### Example of Registering Purchases Update Listener

```java
public class MainActivity extends AppCompatActivity {
    /**
     * Notifies the result of purchasing consumable products, subscription products, or promotion products in the app.
     */
    private IapService.PurchasesUpdatedListener mPurchaseUpdatedListener =
            new IapService.PurchasesUpdatedListener() {
                @Override
                public void onPurchasesUpdated(@NonNull List<IapPurchaseResult> purchaseResults) {
                    for (IapPurchaseResult purchaseResult : purchaseResults) {
                        if (purchaseResult.isSuccess()) {
                            // Succeeded
                            IapPurchase purchase = purchaseResult.getPurchase();
                        } else {
                            // Failed
                        }
                    }
                }
            };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // Register the listener when onCreate is called.
        ToastIap.registerPurchasesUpdatedListener(mPurchaseUpdatedListener);
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        // Must remove the listener when onDestroy() is called.
        ToastIap.unregisterPurchasesUpdatedListener(mPurchaseUpdatedListener);
    }
}
```

> [Note] If the activity is terminated before the purchase result is notified to IapService.PurchasesUpdatedListener, the purchase  data can be lost.
> To process the purchase safely, users must be restricted from terminating the activity (clicking Back or Quit button) until they get the purchase result.

## Query Product List

* Query the list of available products among the ones registered in IAP console.
* Products that can be purchased among those registered in IAP console are returned in [IapProductDetails](./iap-android/#iapproductdetails) list (Product Details List).
* Products unregistered in the store among those registered in IAP console are returned as the [IapProduct ](./iap-android/#iapproduct) list (Invalid Product List).

### Specification for Product List Query API

```java
/* ToastIap.java */
public static void queryProductDetails(Activity activity,
                                       IapService.ProductDetailsResponseListener listener)
```

| Method              | Parameters |                                          |
| ------------------- | ---------- | ---------------------------------------- |
| queryProductDetails | activity   | Activity: Currently active activity               |
|                     | listener   | IapService.<br>ProductDetailsResponseListener: <br>Listener for product query result |


### Example of Product List Query

```java
/**
 * Query the products available for purchase.
 * <p>
 * productDetails: List of products available for purchase
 * invalidProducts: Products registered in TOAST IAP console but not in a store
 */
void queryProductDetails() {
    IapService.ProductDetailsResponseListener responseListener =
            new IapService.ProductDetailsResponseListener() {
                @Override
                public void onProductDetailsResponse(@NonNull IapResult result,
                                                     @Nullable List<IapProductDetails> productDetails,
                                                     @Nullable List<IapProduct> invalidProducts) {
                    if (result.isSuccess()) {
                        // Query Succeeded
                    } else {
                        // Query Failed
                    }
                }
            }

    ToastIap.queryProductDetails(MainActivity.this, responseListener);
}
```

## Purchase Products

* TOAST IAP supports product purchase by using product ID registered at the store.
* Product information is included in the [IapProductDetails](./iap-android/#iapproductdetails) object that is returned by calling the ToastIap.queryProductDetails() method.
* Product ID can be obtained by using the IapProductDetails.getProductId() method.
* Product purchase begins via ToastIap.launchPurchaseFlow(), after setting product ID on [IapPurchaseFlowParams](./iap-android/#iappurchaseflowparams).
* The [IapPurchaseFlowParams](./iap-android/#iappurchaseflowparams) object can be created by using [IapPurchaseFlowParams.Builder](./iap-android/#iappurchaseflowparamsbuilder).
* The result of product purchase is returned via [IapService.PurchasesUpdatedListener](./iap-android/#iapservicepurchasesupdatedlistener) registered in TOAST IAP.

### Specification for Product Purchase IAP

```java
/* ToastIap.java */
public static void launchPurchaseFlow(Activity activity,
                                      IapPurchaseFlowParams params)
```

| Method             | Parameters |                                   |
| ------------------ | ---------- | --------------------------------- |
| launchPurchaseFlow | activity   | Activity: Currently active activity        |
|                    | params     | IapPurchaseFlowParams: Parameter for purchase information |

### Example of Product Purchase

```java
/**
 * Purchase a product.
 */
void launchPurchaseFlow(Activity activity, String productId) {
    IapPurchaseFlowParams params = IapPurchaseFlowParams.newBuilder()
            .setProductId(productId)
            .build();
    ToastIap.launchPurchaseFlow(activity, params);
}
```

### Set User Data

* TOAST IAP can add user information when requesting purchase.
* User information is set with the setDeveloperPayload() method of IapPurchaseFlowParams.Builder.
* You can check the configured user information with the getDeveloperPayload() method of [IapPurchase](./iap-android/#iappurchase), which is returned when you query unconsumed purchase and activated subscription.

```java
String userData = "User Data"
IapPurchaseFlowParams params = IapPurchaseFlowParams.newBuilder()
       .setProductId(productId)
       .setDeveloperPayload(userData)
       .build();
ToastIap.launchPurchaseFlow(activity, params);
```

If a user purchased a product with a promotion code from the Google Play Store, the user data cannot be used.

## Query Unconsumed Purchases

* Query the information of unconsumed one-time products (CONSUMABLE) and consumable subscription products (CONSUMABLE_AUTO_RENEWABLE).
* After a product is provided to a user, the product can be consumed by using [Consume API](https://docs.toast.com/en/Mobile%20Service/IAP/en/api-guide-for-toast-sdk/#consume-api).
* Unconsumed purchase can be queried by using the ToastIap.queryConsumablePurchases() method.
* Query results are returned as the [IapPurchase](./iap-android/#iappurchase) object list via [IapService.PurchasesResponseListener](./iap-android/#iapservicepurchasesresponselistener).

### Specification for Unconsumed Purchases Query API

```java
/* ToastIap.java */
public static void queryConsumablePurchases(Activity activity,
                                            IapService.PurchasesResponseListener listener)
```

| Method                   | Parameters |                                          |
| ------------------------ | ---------- | ---------------------------------------- |
| queryConsumablePurchases | activity   | Activity: Currently active activity               |
|                          | listener   | IapService.PurchasesResponseListener: <br>Listener for query result of unconsumed purchase details |

### Example of Unconsumed Purchases Query

```java
/**
 * Query the list of unconsumed purchases.
 */
void queryConsumablePurchases() {
    PurchasesResponseListener responseListenr =
            new IapService.PurchasesResponseListener() {
                @Override
                public void onPurchasesResponse(@NonNull IapResult result,
                                                @Nullable List<IapPurchase> purchases) {
                    if (result.isSuccess()) {
                        // Succeeded
                    } else {
                        // Failed
                    }
                }
            };
    ToastIap.queryConsumablePurchases(MainActivity.this, responseListenr);
}
```

## Query Activated Subscription

* You can query activated subscription products (AUTO_RENEWABLE & CONSUMABLE_AUTO_RENEWABLE) by user ID.
* Subscription products for which purchase has been completed can be queried as long as usage period remains.
* Activated subscription can be queried by using the ToastIap.queryActivatedPurchases() method.
* Query results are returned as the [IapPurchase](./iap-android/#iappurchase) object list via [IapService.PurchasesResponseListener](./iap-android/#iapservicepurchasesresponselistener).
* Products subscribed in iOS can be queried in Android as well.

> Subscription products are currently supported by Google Play Store only.

### Specification for Activated Subscription Query API

```java
/* ToastIap.java */
public static void queryActivatedPurchases(Activity activity,
                                           PurchasesResponseListener listener)
```

| Method                  | Parameters |                                          |
| ----------------------- | ---------- | ---------------------------------------- |
| queryActivatedPurchases | activity   | Activity: Currently active activity               |
|                         | listener   | IapService.PurchasesResponseListener: <br>Listener for query result of activated subscription |

### Example of Activated Subscription Query

```java
/**
 * Query activated subscription products
 */
void queryActivatedPurchases() {
    PurchasesResponseListener responseListener =
            new IapService.PurchasesResponseListener() {
                @Override
                public void onPurchasesResponse(@NonNull IapResult result,
                                                @Nullable List<IapPurchase> purchases) {
                    if (result.isSuccess()) {
                        // Succeeded
                    } else {
                        // Failed
                    }
                }
            };
    ToastIap.queryActivatedPurchases(MainActivity.this, responseListener);
}
```

## Query Subscription Status

* You can query the status of purchased subscription product by user ID.
* Expired subscription products can be included or excluded from the query with the includeExpiredSubscriptions setting. (default: false)
* The status of subscription product can be queried by using the ToastIap.querySubscriptionsStatus() method.
* Query results are returned as the [IapSubscriptionStatus](./iap-android/#iapsubscriptionstatus) object list via [IapService.SubscriptionsStatusResponseListener](./iap-android/#iapservicesubscriptionsstatusresponselistener).
* The subscription status codes used by [IapSubscriptionStatus](./iap-android/#iapsubscriptionstatus) are defined in [IapSubscriptionStatus.StatusCode](./iap-android/#iapsubscriptionstatusstatusCode).

```
Subscription products are currently supported by Google Play Store only.
```

### Specification for Subscription Status Query API

```java
/* ToastIap.java */
public static void querySubscriptionsStatus(Activity activity,
                                            boolean includeExpiredSubscriptions,
                                            IapService.SubscriptionsStatusResponseListener listener)
```

| Method | Parameters |  |
| --- | --- | --- |
| querySubscriptionsStatus | activity | Activity: Currently active activity |
|  | includeExpiredSubscriptions | boolean:<br>whether or not to include the status of expired subscription products |
|  | listener | IapService.SubscriptionsStatusResponseListener:<br>Listener for query result of subscription status |

### Example of Subscription Status Query

```java
/**
 * Subscription Status Query
 */
private void querySubscriptionsStatus() {
    SubscriptionsStatusResponseListener listener =
            new SubscriptionsStatusResponseListener() {
                @Override
                public void onSubscriptionsStatusResponse(@NonNull String storeCode,
                                                          @Nullable List<IapSubscriptionStatus> subscriptionsStatus) {
                    if (result.isSuccess()) {
                        // Succeeded
                    } else {
                        // Failed
                    }
                }
            };
    ToastIap.querySubscriptionsStatus(MainActivity.this, false, listener);
}
```

## Google Store Subscription Feature

This section explains how to handle subscription lifecycle events in Google Store, such as renewals and expirations.
For further details, refer to [Add Features For Each Subscription](https://developer.android.com/google/play/billing/billing_subscriptions).

### Subscription Lifecycle Handling

Subscriptions on the Google Store go through various status changes throughout their lifecycle and an app must respond to each status.

* **Active**: A state where subscription content can be accessed and auto-renewal is enabled
* **Cancelled**: A state where subscription content can be accessed, but the user has cancelled the subscription product and auto-renewal has been stopped
* **In grace period**: A state where subscription has failed due to a payment method problem but subscription content can still be accessed (waiting for the user to change the payment method)
* **On hold**: A state where a payment method problem has caused subscription to fail, placing the account on hold (If grace period is enabled, the payment method was not changed during grace period and payment has been placed on hold)
* **Pause**: A state where a subscription product has been put on pause
* **Expired**: A state where a subscription product has expired

| Status | Query unconsumed purchases<br>(ToastIap.queryConsumablePurchases) | Query activated subscriptions<br>(ToastIap.queryActivatedPurchases) | Expiry time | Auto-renewal |
| --- | --- | --- | --- | --- |
| Active | Yes | Yes | Future time | Yes |
| Cancelled | Yes | Yes | Future time | No |
| In grace period | No | Yes | Future time | Yes |
| On hold | No | No | Past time | Yes |
| Pause | No | No | Past time | Yes |
| Expired | No | No | Past time | No |

### Grace period

If grace period is enabled, subscriptions transition to grace period if there are issues in the payment method at the end of a billing cycle.
<span style="color:#e11d21">During grace period, the user should be able to access subscription content.</span>
For further details, refer to [Grace period](https://developer.android.com/google/play/billing/subs#grace).

> <span style="color:#e11d21">**Warning!)**</span> If a user recovers subscription by fixing the payment method, etc. during the grace period, auto-renewal is resumed. TOAST IAP notifies of the payment results regarding the renewed purchase through the purchase update listener (IapService.PurchaseUpdatedListener). The game or app must make sure that an unnecessary pop-up isn't exposed to the user by the purchase update listener during an important action.

#### Ordinary subscription product (AUTO_RENEWABLE))

* During grace period, ordinary subscription products must be able to access subscription content.
* During grace period, they can be queried with ToastIap.queryActivatedPurchases().

#### Consumable subscription product (CONSUMABLE_AUTO_RENEWABLE)

* Once grace period begins, Google issues a new receipt. However, if a user does not fix the payment method, the payment is placed on hold or cancelled.
* Consumable subscription products cannot be queried with ToastIap.queryConsumablePurchases() to prevent consumption of the products during grace period.

### Account hold

Account hold refers to a user's state when renewal failed due to a payment method issue.
If payment fails, more attempts will be made during grace period. If payment fails even during the grace period, the subscription is placed on hold.
Users placed on hold cannot access subscription content.
Account hold period is up to 30 days.
If the payment method is not fixed before the account hold period ends, the subscription will be cancelled.
For further details, refer to [Account hold](https://developer.android.com/google/play/billing/subs#account-hold).

> <span style="color:#e11d21">**Warning!)**</span> If a user recovers subscription by fixing the payment method, etc. during the account hold period, auto-renewal is resumed. TOAST IAP notifies of the payment results regarding the renewed purchase through the purchase update listener (IapService.PurchaseUpdatedListener). The game or app must make sure that an unnecessary pop-up isn't exposed to the user by the purchase update listener during an important action.

#### Ordinary subscription product (AUTO_RENEWABLE))

* During account hold period, ordinary subscription products cannot access subscription content.
* During account hold period, they cannot be queried with ToastIap.queryActivatedPurchases().

#### Consumable subscription product (CONSUMABLE_AUTO_RENEWABLE)

* During account hold period, consumable subscription products do not create new purchases.
* During account hold period, new purchases cannot be queried using ToastIap.queryConsumablePurchases().

### Pause

Setting the pause feature allows the user to pause the subscription for a time period from 1 week to 3 months.
The pause of subscription will take effect after the current subscription period ends.
When the pause period ends, subscription will automatically resume.
For further details, refer to [Pause](https://developer.android.com/google/play/billing/subs#pause).

> <span style="color:#e11d21">**Warning!)**</span> When the pause period is over, auto-renewal is resumed. TOAST IAP notifies of the payment results regarding the renewed purchase through the purchase update listener (IapService.PurchaseUpdatedListener). The game or app must make sure that an unnecessary pop-up isn't exposed to the user by the purchase update listener during an important action.

#### Ordinary subscription product (AUTO_RENEWABLE))

* During pause period, ordinary subscription products cannot access subscription content.
* During pause period, they cannot be queried with ToastIap.queryActivatedPurchases().

#### Consumable subscription product (CONSUMABLE_AUTO_RENEWABLE)

* During pause period, consumable subscription products do not create new purchases.
* During pause period, new purchases cannot be quried with ToastIap.queryConsumablePurchases().

### Resubscription

Setting the resubscription feature will allow the user to reapply for subscription that has been cancelled within 12 months of the expiry of the subscription.
Resubscription will create a new subscription and purchase token.
After a subscription has expired, the user can use the Google Play Subscription Center to repurchase the same product for up to 1 year after expiry.
For further details, refer to [Resubscribe](https://developer.android.com/google/play/billing/subs#resubscribe).

> <span style="color:#e11d21">**Warning!)**</span> User data (IapPurchase.getDeveloperPayload()) cannot be used because purchases are not carried out in an in-app or game screen.
> <span style="color:#e11d21">**Warning!)**</span> If resubscription was used to purchase a subscription product from the Google Play Store, the TOAST IAP notifies of the payment results regarding the purchase through the purchase update listener (IapService.PurchaseUpdatedListener). The game or app must make sure that an unnecessary pop-up isn't exposed to the user by the purchase update listener during an important action.

## TOAST IAP Class Reference

### ToastIapConfiguration

IAP configuration information which is used as a parameter for the TOAST IAP initialization method.

```java
/* ToastIapConfiguration.java */
public String getAppKey();
public String getStoreCode();
```

| Method       | Returns |                                     |
| ------------ | ------- | ----------------------------------- |
| getAppKey    | String  | IAP service Appkey                         |
| getStoreCode | String  | Store code information ("GG" or "ONESTORE", "GALAXY", ...) |

### ToastIapConfiguration.Builder

Accepts IAP service Appkey and store type as inputs and creates an [ToastIapConfiguration](./iap-android/#toastiapconfiguration) object.

```java
/* ToastIapConfiguration.java */
public void setAppKey(String appKey)
public void setStoreCode(String storeCode)
```

| Method       | Parameters |                     | Description                              |
| ------------ | ---------- | ------------------- | ---------------------------------------- |
| setAppKey    | appKey     | String: IAP service Appkey | Set Appkey created in TOAST IAP console.      |
| setStoreCode | storeCode  | String: Store code information   | Set store code. <br>("GG" or "ONESTORE", "GALAXY", ...) |

### IapStoreCode

```java
/* IapStoreCode.java */
String GOOGLE_PLAY_STORE
String ONE_STORE
String GALAXY_STORE
```

* GOOGLE_PLAY_STORE<br>Uses Google Play Store in-app purchase.<br>Constant Value: "GG"
* ONE_STORE<br>Uses ONE store in-app purchase. <br>Constant Value: "ONESTORE"
* GALAXY_STORE<br>Uses Galaxy store in-app purchase. <br>Constant Value: "GALAXY"

### IapPurchaseResult

* An object that Includes purchase result and purchase information.

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
| getPurchase | IapPurchase | Returns the IaPPurchase object that contains purchase information. |
| getCode     | int         | Returns a purchase result code.                 |
| getMessage  | String      | Returns a purchase result message.                |
| getCause    | Throwable   | Returns cause of failed purchase.                 |
| isSuccess   | boolean     | Returns whether the purchase succeeded.                 |
| isFailure   | boolean     | Returns whether the purchase failed.                 |

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
| getCode    | int       | Returns a result code.  |
| getMessage | String    | Returns a result message. |
| getCause   | Throwable | Returns cause of failure.  |
| isSuccess  | boolean   | Returns whether it succeeded.  |
| isFailure  | boolean   | Returns whether it failed.  |

### IapPurchase

* An IapPurchase object lets you check the purchase information.

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
| getPaymentId         | String  | Returns payment ID.        |
| getOriginalPaymentId | String  | Returns original payment ID.     |
| getPaymentSequence   | String  | Returns payment sequence number.     |
| getProductId         | String  | Returns product ID.        |
| getProductType       | String  | Returns product type.        |
| getUserId            | String  | Returns user ID.       |
| getPrice             | float   | Returns price information.        |
| getPriceCurrencyCode | String  | Returns currency information.        |
| getAccessToken       | String  | Returns token used for consumption.  |
| getPurchaseType      | String  | Returns product purchase type.        |
| getPurchaseTime      | long    | Returns product purchase time.     |
| getExpiryTime        | long    | Returns remaining time of subscription product. |
| getDeveloperPayload  | String  | Returns user data. |

### IapProductDetails

* An lapProductDetails object lets you check detailed product information.
* This object includes detailed information registered in TOAST IAP console and Google Play Console or ONE store Developer.

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
| getProductId          | String  | Product ID          |
| getProductSequence    | String  | Product sequence number        |
| getPrice              | float   | Price              |
| getLocalizedPrice     | String  | Local price           |
| getPriceCurrencyCode  | String  | Currency              |
| getPriceAmountMicros  | long    | Price by 1,000,000 unit |
| getFreeTrialPeriod    | String  | Free trial period        |
| getSubscriptionPeriod | String  | Subscription period           |
| getProductType        | String  | Product type           |
| getProductTitle       | String  | Product title    |
| getProductDescription | String  | Product description           |
| isActivated           | boolean | Whether the product is activated       |

### IapProduct

* Lets you check brief information registered in TOAST IAP console.

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
| getProductId          | String  | Product ID       |
| getProductSequence    | String  | Product sequence number     |
| getProductType        | String  | Product type        |
| getProductTitle       | String  | Product title |
| getProductDescription | String  | Product description        |
| isActivated           | boolean | Whether the product is activated    |

### IapPurchaseFlowParams

* IapPurchaseFlowParams includes information of a product to purchase.

```java
/* IapPurchaseFlowParams.java */
public String getProductId()
```

| Method       | Returns |       |
| ------------ | ------- | ----- |
| getProductId | String  | Product ID |

### IapPurchaseFlowParams.Builder

* Creates IapPurchaseFlowParams.

```java
/* IapPurchaseFlowParams.java */
public void setProductId(String productId)
```

| Method       | Parameters |               | Description   |
| ------------ | ---------- | ------------- | ------------- |
| setProductId | productId  | String: Product ID | Set the Product ID. |

### IapSubscriptionStatus

* An IapSubscriptionStatus object lets you check the subscription status.
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
| getStoreCode | String | Returns store code. |
| getPaymentId | String | Returns payment ID. |
| getOriginalPaymentId | String | Returns original payment ID. |
| getPaymentSequence | String | Returns payment sequence number. |
| getProductId | String | Returns product ID. |
| getProductType | String | Returns product type. |
| getProductSeq | String | Returns payment sequence number. |
| getUserId | String | Returns user ID. |
| getPrice | float | Returns price information. |
| getPriceCurrencyCode | String | Returns currency information. |
| getAccessToken | String | Returns token used for consumption. |
| getPurchaseType | String | Returns purchase type.<br>"Test" or "Promo" or null |
| getPurchaseTime | long | Returns product purchase time. |
| getExpiryTime | long | Returns remaining time of subscription product. |
| getDeveloperPayload | String | Returns user data. |
| getStatusCode | int | Returns subscription status code. |
| getStatusDescription | String | Returns description for subscription status code. |

### IapSubscriptionStatus.StatusCode

* Codes representing the subscription status.

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
| ACTIVE | 0 | Active | Subscription is active. |
| CANCELED | 3 | Canceled | Subscription has been canceled. |
| ON\_HOLD | 5 | Account hold | Subscription was put on hold (if enabled). |
| IN\_GRACE\_PERIOD | 6 | Grace period | Subscription entered grace period (if enabled). |
| PAUSED | 10 | Paused | Subscription was paused. |
| REVOKED | 12 | Revoked | Subscription was canceled by the user before expiry time. |
| EXPIRED | 13 | Expired | Subscription has expired. |
| UNKNOWN | 9999 | Undefined | Undefined status. |

### IapService.PurchasesUpdatedListener

* When payment information is updated, it is notified through the onPurchasesUpdated method of the object that inherits and implements IapService.PurchasesUpdatedListener.

```java
void onPurchasesUpdated(List<IapPurchaseResult> purchaseResults)
```

### IapService.PurchasesResponseListener

* When a query for unconsumed purchase or activated subscription occurs, it is notified through the onPurchasesResponse method of the object that inherits and implements IapService.PurchasesResponseListener.

```java
void onPurchasesResponse(IapResult result,
                         List<IapPurchase> purchaseList)
```

### IapService.SubscriptionsStatusResponseListener

* When a query for subscription status occurs, it is notified through the onSubscriptionsStatusResponse method of the object that inherits and implements SubscriptionsStatusResponseListener.

```java
void onSubscriptionsStatusResponse(IapResult result,
                                   List<IapSubscriptionStatus> subscriptionsStatus);
```

## Error Codes

### Common Error Codes

| RESULT                 | CODE | DESC                                     |
| ---------------------- | ---- | ---------------------------------------- |
| FEATURE_NOT_SUPPORTED  | -2   | Requested feature is not supported. |
| SERVICE_DISCONNECTED   | -1   | Store service is not connected. |
| OK                     | 0    | Success.                          |
| USER_CANCELED          | 1    | User canceled.                |
| SERVICE_UNAVAILABLE    | 2    | Network connection is down. |
| BILLING_UNAVAILABLE    | 3    | API version is not supported for the requested type. |
| PRODUCT_UNAVAILABLE    | 4    | Requested product is not available. |
| DEVELOPER_ERROR        | 5    | Invalid argument provided for API, which is a common error in development phase. |
| ERROR                  | 6    | Fatal error occurred during API action. |
| PRODUCT_ALREADY_OWNED  | 7    | Failed to purchase an item as it is already owned. |
| PRODUCT_NOT_OWNED      | 8    | Cannot consume an item as it is not owned. |
| USER_ID_NOT_REGISTERED | 9    | User ID is not registered. |
| UNDEFINED_ERROR        | 9999 | Undefined error.           |

### Server Error Codes

| RESULT                    | CODE | DESC                                     |
| ------------------------- | ---- | ---------------------------------------- |
| INACTIVATED_APP           | 101  | App is not activated.     |
| NETWORK_NOT_CONNECTED     | 102  | Network is not connected. |
| VERIFY_PURCHASE_FAILED    | 103  | Failed to verify purchase. |
| PURCHASE_ALREADY_CONSUMED | 104  | Purchase is already consumed. |
| PURCHASE_ALREADY_REFUNDED | 105  | Purchase is already refunded. |
| PURCHASE_LIMIT_EXCEEDED   | 106  | Purchase limit was exceeded. |

### ONE store Error Codes

| RESULT                   | CODE | DESC                                     |
| ------------------------ | ---- | ---------------------------------------- |
| ONESTORE_NEED_LOGIN      | 301  | ONE store service is not logged in. |
| ONESTORE_NEED_UPDATE     | 302  | ONE store service is not updated or installed. |
| ONESTORE_SECURITY_ERROR  | 303  | Purchase requested from an abnormal app. |
| ONESTORE_PURCHASE_FAILED | 304  | Purchase request failed. |

### Galaxy Store Error Codes

| RESULT                   | CODE | DESC                                     |
| ------------------------ | ---- | ---------------------------------------- |
| GALAXY_NOT_LOGGED_IN      | 501  | Galaxy service is not logged in. |
| GALAXY_NOT_UPDATED     | 502  | Galaxy service is not updated or installed. |
| GALAXY_PURCHASE_FAILED  | 503  | Purchase requested from an abnormal app. |
| GALAXY_SERVICE_DENIED | 504  | Purchase request failed. |
