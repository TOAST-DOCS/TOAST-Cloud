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
    implementation 'com.toast.android:toast-iap-google:0.24.2'
    ...
}
```

- To use In-App Purchase of ONE store, add dependency to build.gradle, as below:

```groovy
dependencies {
    implementation 'com.toast.android:toast-iap-onestore:0.24.2'
    ...
}
```

- To use In-App Purchase of Galaxy store, add dependency to build.gradle, as below:

```groovy
dependencies {
    implementation 'com.toast.android:toast-iap-galaxy:0.24.2'
    ...
}
```

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

> [참고] 결제 결과가 IapService.PurchasesUpdatedListener로 통지되기 전 Activity가 종료되면 결제 데이터가 유실될 수 있습니다.
> 결제를 안전하게 처리하기 위해 결제 결과를 통지받기 전, 사용자가 Activity를 종료(백 버튼 또는 종료 버튼 클릭)할 수 없도록 해야 합니다.

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

## 구글 스토어 구독(정기 결제) 기능

구글 스토어의 구독 결제의 갱신 및 만료와 같은 수명주기에 따른 이벤트를 처리하는 방법을 설명합니다.
자세한 사항은 [정기 결제별 기능 추가](https://developer.android.com/google/play/billing/billing_subscriptions)을 참고하세요.

### 구독 수명 주기 처리

구글 스토어의 구독은 수명주기 동안 다양한 상태 변경을 거치며 앱은 각 상태에 따라 대응해야합니다.

* **활성화 상태(Active)**: 정기 결제 콘텐츠에 엑세스 할 수 있으며 자동 갱신이 진행되는 상태
* **취소(Cancelled)**: 정기 결제 콘텐츠에 엑세스 할 수 있으나 사용자가 구독 상품을 더 이상 사용하지 않는다고 취소하여 자동 갱신이 정지된 상태
* **유예 기간 (In grace period)**: 결제 수단 문제로 정기 결제가 실패하였으나 정기 결제 콘텐츠에는 엑세스 할 수 있는 상태 (사용자가 결제 수단을 변경하기를 기다리는 상태)
* **계정 보류 (On hold)**: 결제 수단 문제로 정기 결제가 실패하여 보류 상태 (유예 기간이 사용 설정되어있다면 유예 기간 동안 결제 수단을 변경하지 않아 결제가 보류된 상태)
* **일시중지 (Pause)**: 정기 결제 상품을 일시적으로 중지한 상태
* **만료 (Expired)**: 정기 결제 상품이 만료된 상태

| 상태 | 미소비 결제 조회<br>(ToastIap.queryConsumablePurchases) | 활성화된 구독 조회<br>(ToastIap.queryActivatedPurchases) | 만료 시간 | 자동 갱신 여부 |
| --- | --- | --- | --- | --- |
| 활성화 상태 (Active) | Yes | Yes | 미래시간 | Yes |
| 취소 (Cancelled) | Yes | Yes | 미래시간 | No |
| 유예 기간 (In grace period) | No | Yes | 미래시간 | Yes |
| 계정 보류 (On hold) | No | No | 과거시간 | Yes |
| 일시중지 (Pause) | No | No | 과거시간 | Yes |
| 만료 (Expired) | No | No | 과거시간 | No |

### 유예 기간

유예 기간이 사용 설정된 경우 결제 주기가 끝날 때 결제 수단에 문제가 있다면 정기 결제는 유예 기간으로 전환됩니다.
<span style="color:#e11d21">유예 기간 동안 사용자는 정기 결제 콘텐츠에 엑세스 할 수 있어야 합니다.</span>
자세한 사항은 [유예 기간](https://developer.android.com/google/play/billing/subs#grace)을 참고하세요.

> <span style="color:#e11d21">**주의!)**</span> 유예 기간 중 결제 수단 수정 등으로 복원되면 자동 갱신을 재개합니다. TOAST IAP는 갱신된 결제건을 결제 업데이트 리스너(IapService.PurchaseUpdatedListener)를 통해 결제 결과를 통지합니다. 게임이나 앱은 중요한 동작 중 결제 업데이트 리스너에 의해 불필요한 팝업이 사용자에게 노출되지 않도록 주의해야합니다.

#### 일반 구독 상품 (AUTO_RENEWABLE))

* 유예 기간 동안 일반 구독 상품은 정기 결제 콘텐츠에 엑세스 할 수 있어야 합니다.
* 유예 기간 동안 ToastIap.queryActivatedPurchases()로 조회할 수 있습니다.

#### 소비성 구독 상품 (CONSUMABLE_AUTO_RENEWABLE)

* 유예 기간이 시작되면 구글은 새로운 영수증을 발급하나 결제 수단을 수정하지 않으면 계정 보류 상태가 되거나 취소됩니다.
* 소비성 구독 상품은 유예 기간 동안 상품을 소비할 수 없도록 ToastIap.queryConsumablePurchases()로 조회되지 않습니다.

### 계정 보류

계정 보류는 결제 수단 문제로 갱신이 실패했을 때의 사용자 상태를 말합니다.
결제에 실패하면 유예 기간 동안 재시도하고, 유예 기간 동안에도 결제가 실패하면 정기 결제 상태는 보류 상태가 됩니다.
계정 보류 상태가 사용자는 정기 결제 콘텐츠에 액세스 할 수 없습니다.
계정 보류 기간은 최대 30일입니다.
계정 보류 기간이 종료되기 전에 결제 수단을 수정하지 않으면 취소 처리됩니다.
자세한 사항은 [계정 보류](https://developer.android.com/google/play/billing/subs#account-hold)를 참고하세요.

> <span style="color:#e11d21">**주의!)**</span> 계정 보류 기간 중 결제 수단 수정 등으로 복원되면 자동 갱신을 재개합니다. TOAST IAP는 갱신된 결제건을 결제 업데이트 리스너(IapService.PurchaseUpdatedListener)를 통해 결제 결과를 통지합니다. 게임이나 앱은 중요한 동작 중 결제 업데이트 리스너에 의해 불필요한 팝업이 사용자에게 노출되지 않도록 주의해야합니다.

#### 일반 구독 상품 (AUTO_RENEWABLE))

* 계정 보류 기간 동안 일반 구독 상품은 정기 결제 콘텐츠에 엑세스 할 수 없습니다.
* 계정 보류 기간 동안 ToastIap.queryActivatedPurchases()로 조회되지 않습니다.

#### 소비성 구독 상품 (CONSUMABLE_AUTO_RENEWABLE)

* 계정 보류 기간 동안 소비성 구독 상품은 새로운 구매를 생성하지 않습니다.
* 계정 보류 기간 동안 ToastIap.queryConsumablePurchases()로 새로운 구매가 조회되지 않습니다.

### 일시중지

일시중지 기능을 설정하면 사용자가 정기 결제를 1주일에서 3개월 사이로 일시중지 할 수 있습니다.
정기 결제 일시중지는 현재 구독 기간이 종료된 이후에 적용됩니다.
일시중지 기간이 끝나면 정기 결제가 자동으로 재개됩니다.
자세한 사항은 [일시중지](https://developer.android.com/google/play/billing/subs#pause)를 참고하세요.

> <span style="color:#e11d21">**주의!)**</span> 일시중지 기간이 끝나면 자동 갱신을 재개합니다. TOAST IAP는 갱신된 결제건을 결제 업데이트 리스너(IapService.PurchaseUpdatedListener)를 통해 결제 결과를 통지합니다. 게임이나 앱은 중요한 동작 중 결제 업데이트 리스너에 의해 불필요한 팝업이 사용자에게 노출되지 않도록 주의해야합니다.

#### 일반 구독 상품 (AUTO_RENEWABLE))

* 일시중지 기간 동안 일반 구독 상품은 정기 결제 콘텐츠에 엑세스 할 수 없습니다.
* 일시중지 기간 동안 ToastIap.queryActivatedPurchases()로 조회되지 않습니다.

#### 소비성 구독 상품 (CONSUMABLE_AUTO_RENEWABLE)

* 일시중지 기간 동안 소비성 구독 상품은 새로운 구매를 생성하지 않습니다.
* 일시중지 기간 동안 ToastIap.queryConsumablePurchases()로 새로운 구매가 조회되지 않습니다.

### 정기 결제 재신청

정기 결제 재신청 기능을 설정하면 사용자가 정기 결제 만료일로 부터 12개월 이내에 취소한 정기 결제를 재신청할 수 있습니다.
정기 결제 재신청은 새 정기 결제 및 구매 토큰이 생성됩니다.
정기 결제가 만료된 이후 사용자는 구글 플레이 정기 결제 센터를 통해 만료 후 1년까지 동일한 상품을 다시 구매할 수 있습니다.
자세한 사항은 [정기 결제 재신청](https://developer.android.com/google/play/billing/subs#resubscribe)을 참고하세요.

> <span style="color:#e11d21">**주의!)**</span> 앱이나 게임 내 화면에서 구매가 진행되지 않으므로 사용자 데이터(IapPurchase.getDeveloperPayload())를 사용할 수 없습니다.
> <span style="color:#e11d21">**주의!)**</span> 구글 플레이 스토어에서 정기 결제 재신청으로 구독 상품을 구매할 경우 TOAST IAP는 구매한 결제건을 결제 업데이트 리스너(IapService.PurchaseUpdatedListener)를 통해 결제 결과를 통지합니다. 게임이나 앱은 중요한 동작 중 결제 업데이트 리스너에 의해 불필요한 팝업이 사용자에게 노출되지 않도록 주의해야합니다.

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