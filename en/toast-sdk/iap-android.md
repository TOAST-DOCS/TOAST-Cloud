## TOAST > User Guide for TOAST SDK > TOAST IAP > Android

## Prerequisites

1\. [Install TOAST SDK](./getting-started-android)

2.[Enable IAP service](https://docs.toast.com/ko/Mobile%20Service/IAP/ko/console-guide/#iap-appkey) [in TOAST console](https://console.cloud.toast.com).

3\. [Check AppKey](https://docs.toast.com/ko/Mobile%20Service/IAP/ko/console-guide/#appkey) in IAP console.

## Store Types
- [Google Play Store](https://developer.android.com/google/play/billing)
- [ONE store v17](https://dev.onestore.co.kr/devpoc/reference/view/Tools)
- [Galaxy store](https://developer.samsung.com/iap/overview.html)

## Library Setting
- To use In-App Purchase of Google Play Store, add dependency to build.gradle, as below:

```groovy
dependencies {
    implementation 'com.toast.android:toast-iap-google:0.24.4'
    ...
}
```

- To use In-App Purchase of ONE store, add dependency to build.gradle, as below:

```groovy
dependencies {
    implementation 'com.toast.android:toast-iap-onestore:0.24.4'
    ...
}
```

- To use In-App Purchase of Galaxy store, add dependency to build.gradle, as below:

```groovy
dependencies {
    implementation 'com.toast.android:toast-iap-galaxy:0.24.4'
    ...
}
```

> Galaxy Store in-app purchases works on Android 4.3 (API level 18) or higher.

## AndroidManifest Settings

### ONE store purchase screen setting (optional)

ONE store supports full purchase screen and pop-up purchase screen.
You can add meta-data to AndroidManifest.xml to select the full purchase screen ("full") or popup purchase screen ("popup").
If meta-data is not set, the default ("full") is applied.

```xml
<application
  ...>
  <meta-data android:name="iap:view_option" android:value="popup | full"/>
</application>
```

| Purchase Screen | Value |
| -- | -- |
| Full Purchase Screen | "full" |
| Popup Purchase Screen | "popup" |

For more information, see [One Store Billing Screen](https://dev.onestore.co.kr/devpoc/reference/view/Tools).

### Android 11 이상을 타겟팅하는 앱 (only ONE store)

Android 11에서는 앱이 사용자가 기기에 설치한 다른 앱을 쿼리하고 상호작용하는 방법을 변경합니다.
Android 11 이상을 타겟팅하는 앱에서 ONE store 결제를 사용하려면 아래와 같이 AndroidManifest.xml에 'queries' 요소를 정의해야합니다.

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

'queries' 요소는 Android Gradle Plugin 4.1 이상 동작합니다.
이전 버전의 Android Gradle Plugin을 사용하려면 [Android 11에서 패키지 가시성을 위해 Gradle 빌드 준비](https://android-developers.googleblog.com/2020/07/preparing-your-build-for-package-visibility-in-android-11.html)을 참고하세요.

## Store Codes

| Store | Code |
| ---- | ---- |
| Google Play Store| "GG" |
| ONE store | "ONESTORE" |
| Galaxy store | "GALAXY" |

> Note : Store codes are defined in the  [IapStoreCode](./iap-android/#iapstorecode) class.

## Product Types

- Three types of products are currently supported: consumable products and subscription products, consumable subscription products.

| Product Name | Product Type | Description |
| ---- | ------ | ------ |
| Consumable Products | "CONSUMABLE" | Consumable Products refer to consumable one-time products, <br>such as products within a game, and media files. |
| Subscription Products | "AUTO_RENEWABLE" | Subscription products refer to products <br>which are automatically paid at specific intervals and prices, <br>such as online magazines and music streaming services.  |
| Consumable Subscription Products | "CONSUMABLE_AUTO_RENEWABLE" | 소비가 가능한 구독 상품<br>정기적으로 게임내 재화, 아이템 등을 지급하는 결제 방식입니다. |

> Note :Subscription products and Consumable subscription products are supported by Google Play Store only.

## In-App Purchase (IAP) Setting

* [ToastIapConfiguration](./iap-android/#toastiapconfiguration) includes IAP setting information.
* [ToastIapConfiguration](./iap-android/#toastiapconfiguration) can be created by using [ToastIapConfiguration.Builder](./iap-android/#toastiapconfigurationbuilder).
* [AppKey](https://docs.toast.com/ko/Mobile%20Service/IAP/ko/console-guide/#appkey) issued from IAP console can be set by using setAppKey.
* With the setStoreCode method, set [Store Code](./iap-android/#_3) for IAP.

### Example of IAP Setting

```java
ToastIapConfiguration configuration =
    ToastIapConfiguration.newBuilder(getApplicationContext())
                .setAppKey(YOUR_APP_KEY)
                .setStoreCode(IapStoreCode.GOOGLE_PLAY_STORE)
                .build();
```

## Initialize IAP

- Call ToastIap.initialize() method to initialize TOAST IAP.  

### Specifications for IAP Initialization API

* Initialize IAP by using ToastIap.initialize.
* The ToastIap.initialize method applies [ToastIapConfiguration](./iap-android/#toastiapconfiguration) created with [ToastIapConfiguration.Builder](./iap-android/#toastiapconfigurationbuilder) as parameter.

```java
/* ToastIap.java */
public static void initialize(ToastIapConfiguration configuration)
```

| Parameters | |
| ---- | ---- |
| configuration | ToastIapConfiguration: Information for IAP setting |

### Example of IAP Initialization

- Initialize ToastIap.

> Note: Initialization must be executed in Application#onCreate.

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

* All TOAST SDK products (including IAP and Log & Crash) are based on a same user ID.
    * Set user ID with[ToastSdk.setUserId](https://docs.toast.com/ko/TOAST/ko/toast-sdk/getting-started-android/#userid).
    * Cannot make purchases when user ID is not set.
* It is recommended to set user ID, query unconsumed purchase history, and search enabled subscription products, during service login.

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

> Note: User ID must be set as null for a service logout so as to prevent promotion codes redeemed or purchase with wrong user ID when reprocessing purchase operates.

## Register Purchases Update Listener

* Purchase results are notified via [IapService.PurchasesUpdatedListener](./iap-android/#iapservicepurchasesupdatedlistener) configured in Toastlap.
* Purchases update listener can be registered by using the ToastIap.registerPurchasesUpdatedListener method.
* Purchase information is available on the list of [IapPurchaseResult](./iap-android/#iappurchaseresult) delivered by [IapService.PurchasesUpdatedListener](./iap-android/#iapservicepurchasesupdatedlistener).

> Note: Purchases update listener must be registered in Activity.onCreate() and unregistered in Activity.onDestroy().

### Specifications for Registering Purchases Upload Listener API

```java
/* ToastIap.java */
public static void registerPurchasesUpdatedListener(IapService.PurchasesUpdatedListener listener)
public static void unregisterPurchasesUpdatedListener(IapService.PurchasesUpdatedListener listener)
```

| Method | Parameters |  | Description |
| ---- | ---- | ---- | ---- |
| registerPurchasesUpdatedListener | listener | IapService.<br>PurchasesUpdatedListener: <br>Purchases Update Listener | Purchases update listener is registered. |
| unregisterPurchasesUpdatedListener | listener | IapService.<br>PurchasesUpdatedListener: <br>Listener to unregister | Purchases update listener is unregistered. |

#### Example of Registering Purchases Update Listener

```java
public class MainActivity extends AppCompatActivity {
    /**
     * Notifies the result of purchasing consumable products, subscription products, or promotional products.
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

        // Register Listener when onCreate is called.
        ToastIap.registerPurchasesUpdatedListener(mPurchaseUpdatedListener);
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        // Must remove Listener when onDestroy() is called.
        ToastIap.unregisterPurchasesUpdatedListener(mPurchaseUpdatedListener);
    }
}
```

> [Note] If this activity is terminated before the transaction result is notified to IapService.PurchasesUpdatedListener, the transaction data could be lost.
> For safer processing of transaction, users must be restricted from terminating their activity (clicking Back or Quit button) until they get the transaction result.

## Query Product List

* Query available list of products which are registered in IAP Console.
* Available products to purchase among those registered in IAP Console are returned to [IapProductDetails](./iap-android/#iapproductdetails) (Product Details List).
* Products unregistered to store among those registered in IAP Console are returned to [IapProduct ](./iap-android/#iapproduct)(Invalid Product List).

### Specifications for Product List Query API

```java
/* ToastIap.java */
public static void queryProductDetails(Activity activity,
                                       IapService.ProductDetailsResponseListener listener)
```
| Method | Parameters |  |
| ---- | ---- | ---- |
| queryProductDetails | activity | Activity: Currently activated activity |
|  | listener | IapService.<br>ProductDetailsResponseListener: <br>Product query result listener |

### Example of Product List Query

```java
/**
 * Products available to purchase are queried.
 * <p>
 * productDetails: List of available products to purchase
 * invalidProducts: Products  registered in TOAST IAP Console but not in a store
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

* TOAST IAP supports product purchase by using product ID registered at store.
* Product information is included to [IapProductDetails](./iap-android/#iapproductdetails) which is returned by calling ToastIap.queryProductDetails().
* Product ID can be obtained by using IapProductDetails.getProductId().
* Product purchase begins via ToastIap.launchPurchaseFlow(), after setting product ID to [IapPurchaseFlowParams](./iap-android/#iappurchaseflowparams).  
* [IapPurchaseFlowParams](./iap-android/#iappurchaseflowparams) can be created by using [IapPurchaseFlowParams.Builder](./iap-android/#iappurchaseflowparamsbuilder).
* Result of product purchase is returned through [IapService.PurchasesUpdatedListener](./iap-android/#iapservicepurchasesupdatedlistener) registered in TOAST IAP.

### Specifications for Product Purchase IAP

```java
/* ToastIap.java */
public static void launchPurchaseFlow(Activity activity,
                                      IapPurchaseFlowParams params)
```

| Method | Parameters |  |
| ---- | ---- | ---- |
| launchPurchaseFlow | activity | Activity: Currently activated activity |
|  | params | IapPurchaseFlowParams: Parameter for purchase information |

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
## User Data Setting

* TOAST IAP can add user information when requesting purchase.
* User information is set to setDeveloperPayload() method of IapPurchaseFlowParams$Builder.
* Set user information can be identified as a getDeveloperPayload() method of [IapPurchase](./iap-android/#iappurchase) returned during unconsumed query and activated subscription query.

```java
String userData = "userData"
IapPurchaseFlowParams params = IapPurchaseFlowParams.newBuilder()
setProductId (productId)
.setDeveloperPayload(userData)
.build();
ToastIap.launchPurchaseFlow (activity, params);
```

If you purchased a product with a promotional code from the Google Play Store, you cannot use user data.

## Query Unconsumed Purchases

* Query information of unconsumed one-time products(CONSUMABLE) and consumable subscription products(CONSUMABLE_AUTO_RENEWABLE).
* Product, after provided to user, can be consumed by using [Consume API](https://docs.toast.com/en/Mobile%20Service/IAP/en/api-guide-for-toast-sdk/#consume-api).
* Unconsumed purchase can be queried by using the ToastIap.queryConsumablePurchases() method.
* Query results are returned to the [IapPurchase](./iap-android/#iappurchase) object list via [IapService.PurchasesResponseListener](./iap-android/#iapservicepurchasesresponselistener).

### Specifications for Unconsumed Purchases Query API

```java
/* ToastIap.java */
public static void queryConsumablePurchases(Activity activity,
                                            IapService.PurchasesResponseListener listener)
```

| Method | Parameters |  |
| ---- | ---- | ---- |
| queryConsumablePurchases | activity | Activity: Currently activated activity |
|  | listener | IapService.PurchasesResponseListener: <br>Query result listener for unconsumed purchase details |

### Example of Unconsumed Purchases Query

```java
/**
 * List of unconsumed purchases is queried.
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

* Activated subscription products(AUTO_RENEWABLE & CONSUMABLE_AUTO_RENEWABLE) can be queried for user ID.
* Completely-paid subscription products can be queried as long as usage period remains.
* Activated subscription can be queried by using the ToastIap.queryActivatedPurchases() method.
* Query results are returned via [IapService.PurchasesResponseListener](./iap-android/#iapservicepurchasesresponselistener) to [IapPurchase](./iap-android/#iappurchase).
* Subscription products of iOS can be queried in Android as well.

> Subscription products are currently supported by Google Play Store only.

### Specifications for Activated Subscription Query API

```java
/* ToastIap.java */
public static void queryActivatedPurchases(Activity activity,
                                           PurchasesResponseListener listener)
```

| Method | Parameters |  |
| ---- | ---- | ---- |
| queryActivatedPurchases | activity | Activity: Currently activated activity |
|  | listener | IapService.PurchasesResponseListener: <br>Query result listener for activated subscription |

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

## Google Store subscription (recurring billing) feature

This explains how to process events related to life cycles, such as Google Store subscription payment renewals and expiries.
For further details, please refer to [Add Features For Each Recurring Billing](https://developer.android.com/google/play/billing/billing_subscriptions).

### Subscription life cycle processing

Subscriptions on the Google Store go through various status changes throughout their life cycle and an app must respond to each.

* **Active**: recurring billing content can be accessed, and auto-renewal is enabled
* **Cancelled**: recurring billing content can be accessed, but the user has cancelled the subscription product and auto-renewal has been halted
* **In grace period**: recurring billing has failed due to a payment method problem but recurring billing content can still be accessed (waiting for the user to change the payment method)
* **On hold**: a payment method problem has caused recurring billing to fail, placing the account on hold (If grace period has been enabled, the payment method was not changed during the grace period and payment has been placed on hold)
* **Pause**: a recurring billing product have been put on pause
* **Expired**: a recurring billing product has expired

| Status | Query consumable purchases<br>(ToastIap.queryConsumablePurchases) | Query activated purchases<br>(ToastIap.queryActivatedPurchases) | Expiry time | Auto-renewal |
| --- | --- | --- | --- | --- |
| Active state | Yes | Yes | Future time | Yes |
| Cancelled | Yes | Yes | Future time | No |
| In grace period | No | Yes | Future time | Yes |
| On hold | No | No | Past time | Yes |
| Pause | No | No | Past time | Yes |
| Expired | No | No | Past time | No |

### Grace period

If grace period has been enabled, when there is a problem with the payment method when a billing cycle ends recurring billing will transition to a grace period.
<span style="color:#e11d21">During a grace period the user must be able to access recurring billing content.</span>
For further details please refer to [Grace period](https://developer.android.com/google/play/billing/subs#grace)

> <span style="color:#e11d21">**Warning!)**</span> If recovery is performed through a payment method change, etc. during the grace period, auto-renewal resumes. The TOAST IAP notifies of the payment results regarding the renewed purchase through the purchase update listener (IapService.PurchaseUpdatedListener). The game or app must make sure that an unnecessary popup isn't exposed to the user by the purchase update listener during an important action.

#### Ordinary subscription product (AUTO_RENEWABLE))

* During a grace period ordinary subscription products must be able to access recurring billing content.
* Queries can be made with ToastIap.queryActivatedPurchases() during grace period.

#### Consumable subscription product (CONSUMABLE_AUTO_RENEWABLE)

* Once grace period begins, Google issues a new receipt. If the payment method isn’t modified, however, the payment is placed on hold or cancelled.
* Consumable subscription products cannot be queried with ToastIap.queryConsumablePurchases()to prevent consumption of products during grace period.

### On hold

This refers to a user state where renewal failed due to a payment method problem.
If payment fails, more attempts will be made during grace period. If payment fails during the grace period as well, the recurring billing is placed on hold.
Users placed on hold cannot access recurring billing content.
Account hold period is 30 days maximum.
If the payment method is not changed before the hold period ends, the subscription will be cancelled.
For further details, please refer to [Account hold](https://developer.android.com/google/play/billing/subs#account-hold)

> <span style="color:#e11d21">**Warning!)**</span> If recovery is performed through a payment method change, etc. during the account hold period, auto-renewal resumes. The TOAST IAP notifies of the payment results regarding the renewed purchase through the purchase update listener (IapService.PurchaseUpdatedListener). The game or app must make sure that an unnecessary popup isn't exposed to the user by the purchase update listener during an important action.

#### Ordinary subscription product (AUTO_RENEWABLE))

* During account hold period ordinary subscription products must be able to access recurring billing content.
* Queries through ToastIap.queryActivatedPurchases() are unavailable while subscription is on hold.

#### Consumable subscription product (CONSUMABLE_AUTO_RENEWABLE)

* Consumable subscription products do not create new purchases while subscription is on hold.
* Queries for new purchases through ToastIap.queryConsumablePurchases()are unavailable while subscription is on hold.

### Pause

Using the pause function allows the user to pause the recurring billing for anywhere from 1 week to 3 months.
Recurring billing pausing will take effect after the current subscription period ends.
When the pause period ends, recurring billing will automatically resume.
For further details, please refer to [Pause](https://developer.android.com/google/play/billing/subs#pause)

> <span style="color:#e11d21">**Warning!)**</span> Auto-renewal resumes when the pause period is over. The TOAST IAP notifies of the payment results regarding the renewed purchase through the purchase update listener (IapService.PurchaseUpdatedListener). The game or app must make sure that an unnecessary popup isn't exposed to the user by the purchase update listener during an important action.

#### Ordinary subscription product (AUTO_RENEWABLE))

* During pause period ordinary subscription products must be able to access recurring billing content.
* Queries through ToastIap.queryActivatedPurchases() are unavailable while subscription is paused.

#### Consumable subscription product (CONSUMABLE_AUTO_RENEWABLE)

* Consumable subscription products do not create new purchases while subscription is paused.
* Queries for new purchases through ToastIap.queryConsumablePurchases()are unavailable while subscription is paused.

### Reapplying for recurring billing

Setting the recurring billing resubscribe function will allow the user to reapply for recurring billing that has been cancelled within 12 months of the expiry of the recurring billing.
Recurring billing resubscription will create a new recurring billing and purchase token.
After a recurring billing has expired, the user can use the Google Play recurring billing center to repurchase the same product for up to 1 years after expiry.
For further details please refer to [Recurring Billing Resubscription](https://developer.android.com/google/play/billing/subs#resubscribe)

> <span style="color:#e11d21">**Warning!)**</span> User data (IapPurchase.getDeveloperPayload()) cannot be used because purchases are not carried out in an in-app or game screen.
> <span style="color:#e11d21">**Warning!)**</span> If recurring billing resubscription was used to purchase a subscription product from the Google Play Store, the TOAST IAP notifies of the payment results regarding the purchase through the purchase update listener (IapService.PurchaseUpdatedListener). The game or app must make sure that an unnecessary popup isn't exposed to the user by the purchase update listener during an important action.

## TOAST IAP Class Reference

### ToastIapConfiguration

Refers to IAP configuration information which is applied as parameter for TOAST IAP initialization method.

```java
/* ToastIapConfiguration.java */
public String getAppKey();
public String getStoreCode();
```

| Method | Returns |  |
| ---- | ---- | ---- |
| getAppKey | String | IAP service appkey |
| getStoreCode | String | Store code information ("GG" or "ONESTORE", "GALAXY", ...) |

### ToastIapConfiguration.Builder

IAP service app key and store type are entered to create [ToastIapConfiguration](./iap-android/#toastiapconfiguration) object.  

```java
/* ToastIapConfiguration.java */
public void setAppKey(String appKey)
public void setStoreCode(String storeCode)
```

| Method | Parameters |  | Description |
| ---- | ---- | ---- | ---- |
| setAppKey | appKey | String: IAP service appkey | Set appkey created in TOAST IAP Console. |
| setStoreCode | storeCode | String: Store code information | Set store code. <br>("GG" or "ONESTORE", "GALAXY", ...) |

### IapStoreCode

```java
/* IapStoreCode.java */
String GOOGLE_PLAY_STORE
String ONE_STORE
String GALAXY_STORE
```

* GOOGLE_PLAY_STORE<br>Applies Google Play Store in-app purchase.<br>Constant Value: "GG"
* ONE_STORE<br>Applies ONE store in-app purchase. <br>Constant Value: "ONESTORE"
* GALAXY_STORE<br>Applies Galaxy store in-app purchase. <br>Constant Value: "GALAXY"

### IapPurchaseResult

* Includes purchase result and information.

```java
/* IapPurchaseResult.java */
public IapPurchase getPurchase()
public boolean isSuccess()
public boolean isFailure()
public int getCode()
public String getMessage()
public Throwable getCause()
```

| Method | Returns |  |
| ---- | ---- | ---- |
| getPurchase | IapPurchase | Return IaPPurchase which contains purchase information. |
| getCode | int | Return purchase result code. |
| getMessage | String | Return purchase result message. |
| getCause | Throwable | Return cause of failed purchase. |
| isSuccess | boolean | Return if purchase is successful |
| isFailure | boolean | Return if purchase is failed |

### IapResult

```java
/* IapResult.java */
public boolean isSuccess()
public boolean isFailure()
public int getCode()
public String getMessage()
public Throwable getCause()
```

| Method | Returns |  |
| ---- | ---- | ---- |
| getCode | int | Return result code. |
| getMessage | String | Return result message. |
| getCause | Throwable | Return cause of failure. |
| isSuccess | boolean | Return if Successful |
| isFailure | boolean | Return if Failed |

### IapPurchase

* Purchase information is available via IapPurchase object.  

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

| Method | Returns | |
| ---- | ---- | ---- |
| getPaymentId | String | Return payment ID. |
| getOriginalPaymentId | String | Return original payment ID. |
| getPaymentSequence | String | Return original payment number. |
| getProductId | String | Return product ID. |
| getProductType | String | Return product type. |
| getUserId | String | Return user ID. |
| getPrice | float | Return price information. |
| getPriceCurrencyCode | String | Return currency information. |
| getAccessToken | String | Return token for consumption. |
| getPurchaseType | String | Return product type. |
| getPurchaseTime | long | Return product purchase time. |
| getExpiryTime | long | Return remaining time of subscription product. |

### IapProductDetails

* Detail product information is available with lapProductDetails.
* Includes information registered in TOAST IAP Console and Google Play Console or ONE store Developer.

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

| Method | Returns | |
| ---- | ---- | ---- |
| getProductId | String | Product ID |
| getProductSequence | String | Original product number |
| getPrice | float | Price |
| getLocalizedPrice | String | Local price |
| getPriceCurrencyCode | String | Currency |
| getPriceAmountMicros | long | Price by 1,000,000 |
| getFreeTrialPeriod | String | Free trial period |
| getSubscriptionPeriod | String | Subscription period |
| getProductType | String | Product type |
| getProductTitle | String | Product title |
| getProductDescription | String | Product description |
| isActivated | boolean | If product is activated |

### IapProduct

* Brief information registered in TOAST IAP Console is available.

```java
/* IapProduct.java */
public String getProductId()
public String getProductSequence()
public String getProductType()
public String getProductTitle()
public String getProductDescription()
public boolean isActivated()
```

| Method | Returns | |
| ---- | ---- | ---- |
| getProductId | String | Product ID |
| getProductSequence | String | Original product number |
| getProductType | String | Product type |
| getProductTitle | String | Product title |
| getProductDescription | String | Product description |
| isActivated | boolean | If product is activated |

### IapPurchaseFlowParams

* IapPurchaseFlowParams includes information of a product to purchase.

```java
/* IapPurchaseFlowParams.java */
public String getProductId()
```

| Method | Returns | |
| ---- | ---- | ---- |
| getProductId | String | Product ID |

### IapPurchaseFlowParams.Builder

* Creates IapPurchaseFlowParams.

```java
/* IapPurchaseFlowParams.java */
public void setProductId(String productId)
```

| Method | Parameters |  | Description |
| ---- | ---- | ---- | ---- |
| setProductId | productId | String: Product ID | Product ID is set. |

### IapService.PurchasesUpdatedListener

* Purchase information, if updated, is notified via onPurchasesUpdated of an object inherited with IapService.PurchasesUpdatedListener.

```java
void onPurchasesUpdated(List<IapPurchaseResult> purchaseResults)
```

### IapService.PurchasesResponseListener

* Unconsumed purchase or activated subscription, when queried, is notified via onPurchasesResponse of an object inherited with IapService.PurchasesResponseListener.

```java
void onPurchasesResponse(IapResult result,
                         List<IapPurchase> purchaseList)
```

## Error Codes

### Common

| RESULT | CODE | DESC |
| ------ | ---- | ---- |
| FEATURE_NOT_SUPPORTED | -2 | Requested feature is not supported.<br> |
| SERVICE_DISCONNECTED | -1 | Store service is not connected.<br> |
| OK | 0 | Succeeded<br> |
| USER_CANCELED | 1 | User cancelled.<br> |
| SERVICE_UNAVAILABLE | 2 | Network is not connected.<br> |
| BILLING_UNAVAILABLE | 3 | API version is not supported for the requested type.<br> |
| PRODUCT_UNAVAILABLE | 4 | Requested product is not available.<br> |
| DEVELOPER_ERROR | 5 | Provided invalid parameter to API: a common error during development phase. <br> |
| ERROR | 6 | Fatal error occurred during API action.<br> |
| PRODUCT_ALREADY_OWNED | 7 | Failed to purchase as it is already owned.<br> |
| PRODUCT_NOT_OWNED | 8 | Cannot consume as it is not owned.<br> |
| USER_ID_NOT_REGISTERED | 9 | User ID Is not registered.<br> |
| UNDEFINED_ERROR | 9999 | Undefined Error<br> |

### Server

| RESULT | CODE | DESC |
| ------ | ---- | ---- |
| INACTIVATED_APP | 101 | App is not activated.<br> |
| NETOWRK_NOT_CONNECTED | 102 | Network is not connected.<br> |
| VERIFY_PURCHASE_FAILED | 103 | Failed to verify purchase.<br> |
| CONSUMED_PURCHASE | 104 | Purchase is already consumed.<br> |
| REFUNDED_PURCHASE | 105 | Purchase is already refunded.<br> |

### ONE store

| RESULT | CODE | DESC |
| ------ | ---- | ---- |
| ONESTORE_NEED_LOGIN | 301 | Not logged-in to ONE store Service.<br> |
| ONESTORE_NEED_UPDATE | 302 | ONE store Service is not updated or installed.<br> |
| ONESTORE_SECURITY_ERROR | 303 | Purchase requested from abnormal app.<br> |
| ONESTORE_PURCHASE_FAILED | 304 | Failed to request for purchase.<br> |

### Galaxy storeエラーコード

| RESULT                   | CODE | DESC                                     |
| ------------------------ | ---- | ---------------------------------------- |
| GALAXY_NOT_LOGGED_IN      | 501  | Galaxy service is not logged in.<br> |
| GALAXY_NOT_UPDATED     | 502  | Galaxy service is not updated or installed.<br> |
| GALAXY_PURCHASE_FAILED  | 503  | Galaxy purchase failed.<br> |
| GALAXY_SERVICE_DENIED | 504  | PurGalaxy service denied.<br> |
