## NHN Cloud > SDK User Guide > IAP > Unity

## Prerequisites

1. [Install the NHN Cloud SDK](./getting-started-unity)
2. [Enable Mobile Service \> IAP](https://docs.nhncloud.com/ko/Mobile%20Service/IAP/ko/console-guide/) in [NHN Cloud console](https://console.nhncloud.com).
3. [Check AppKey](https://docs.nhncloud.com/ko/Mobile%20Service/IAP/ko/console-guide/#appkey) in IAP.

## Android Setup
### Set Up Gradle Build
- In the Unity Editor, open the Build Settings windows (Player Settings > Publishing Settings > Build).
- Select Gradle from the Build System drop-down menu.
- Use the Custom Gradle Template by selecting the checkbox under Build System.
- Add the code below to dependencies of mainTemplate.gradle.

#### Google Play Store

```groovy
repositories {
  google()
  mavenCentral()
}

dependencies {
  implementation 'com.nhncloud.android:nhncloud-iap-google:1.7.0'
**DEPS**}
```

#### One Store

```groovy
repositories {
  mavenCentral()
}

dependencies {
  implementation 'com.nhncloud.android:nhncloud-iap-onestore:1.7.0'
**DEPS**}
```

#### Galaxy Store

```groovy
repositories {
  mavenCentral()
}

dependencies {
  implementation 'com.nhncloud.android:nhncloud-iap-galaxy:1.7.0'
**DEPS**}
```

#### Amazon Appstore

```groovy
repositories {
  mavenCentral()
}

dependencies {
  implementation 'com.nhncloud.android:nhncloud-iap-amazon:1.7.0'
**DEPS**}
```

#### Huawei App Gallery

- Add the AppGallery Connection configuration file (agconnect-service.json).
    - Log in to [AppGallery Connect](https://developer.huawei.com/consumer/en/service/josp/agc/index.html) and then click **My Projects**.
    - Select an app from your project.
    - Go to **Project settings** > **General information**.
    - Download the **agconnect-service.json** file from **App information**.
    - Copy the **agconnect-service.json** file to the root directory of your app.
- Set up the App Gallery Connect plugin and dependencies as follows.

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
    classpath 'com.huawei.agconnect:agcp:1.7.0.300'
	}
}

repositories {
  mavenCentral()
}

apply plugin: 'com.android.application'
apply plugin: 'com.huawei.agconnect'

dependencies {
  implementation 'com.nhncloud.android:nhncloud-iap-huawei:1.7.0'
**DEPS**}
```

## iOS Setup
### Set Up Capabilities
- Select the Capabilities tab in the XCode project settings.
- Set In-App Purchase to ON.

### Add a Required Framework
- To use the IAP feature in iOS, StoreKit.framework is required.
- Add Storekit.framework in XCode project settings.

## Supported Stores and Product Types

| Platform | Store | Supported Product Types |
|---|---|---|
| Android | Google Play Store | Consumable products, subscription products, consumable subscription products |
| Android | ONE store | Consumable products |
| iOS | Apple App Store | Consumable products, subscription products, consumable subscription products |

## NHN Cloud IAP SDK Initialization
Use [ToastIapConfiguration](./iap-unity/#toastiapconfiguration) to set the AppKey issued from the NHN Cloud IAP console and store code ([StoreCode](./iap-unity/#storecode)).
During initialization, register PurchaseUpdateListener that can receive the purchase result.

> **Timing of Initialization**
> NHN Cloud IAP SDK initialization must be performed only once immediately after app execution,
> and before setting the user ID (see [Service Login](./iap-unity/#_4)).

### Specification for Initialization API
```csharp
public delegate void PurchaseUpdateListener(string transactionId, ToastResult result, IapPurchase purchase);

public static void Initialize(ToastIapConfiguration configuration, PurchaseUpdateListener listener);
```

### Example of Initialization

```csharp
ToastIap.Initialize(new ToastIapConfiguration
{
    AppKey = "YOUR_IAP_APP_KEY",
    StoreCode = StoreCode.GooglePlayStore
}, (result, purchase) =>
{
    if (result.IsSuccessful)
    {
        // Purchase succeeded
    }
    else
    {
        // Purchase failed
    }
});
```


## Service Login
- All products provided by NHN Cloud SDK (IAP, Log & Crash, etc.) use the same user ID.
    - User ID can be set with ToastSdk.UserId.
    - When user ID is not set, purchase cannot proceed.
- It is recommended to implement the following features in service login step: user ID setting, querying unconsumed purchase history, and querying active subscription products.

### Login

```csharp
// Login
ToastSdk.UserId = "USER_ID";
```

### Logout

```csharp
// Logout
ToastSdk.UserId = null;
```

> [Note] When the service is logged out, user ID must be set to null. Otherwise, promotion codes might be redeemed or purchase with wrong user ID might occur in purchase reprocessing operation.

## Query Product List
- Query the list of available products among the ones registered in ICP console.
    - Products that can be purchased among the ones registered in ICP console are returned as the Product property ([IapProduct](./iap-unity/#iapproduct)) of [ProductDetailsResult](./iap-unity/#productdetailsresult).
    - Products that are not registered in the store among the ones registered in ICP console are returned as the InvalidProducts property ([IapProduct](./iap-unity/#iapproduct)) of [ProductDetailsResult](./iap-unity/#productdetailsresult).

### Specification for Product List Query API

```csharp
public static void RequestProductDetails(ToastCallback<ProductDetailsResult> callback);
```

### Example of Product List Query

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

## Purchase Products
- NHN Cloud IAP supports product purchase by using product ID registered at the store.
    - Product ID can be retrieved when querying the product list.
- The result of product purchase is returned via PurchaseUpdateListener registered during the initialization.
    - The purchase result returns [IapPurchase](./iap-unity/#iappurchase).

### Specification for Product Purchase API

```csharp
public static void Purchase(string productId, developerPayload = "");
```

- NHN Cloud IAP can add user information with developerPayload when requesting purchase.

### Example of Product Purchase

```csharp
var productId = userSelectedProductId;
ToastIap.Purchase(productId);
```

```csharp
var productId = userSelectedProductId;
ToastIap.Purchase(productId, developerPayload);
```

## Query Unconsumed Purchases
- Query information on consumable products that are not consumed yet.
    - The result of unconsumed purchases query is returned as a list of [IapPurchase](./iap-unity/#iappurchase) object.
- After a product is provided to a user, the product can be consumed by using [Consume API](../../../Mobile%20Service/IAP/ko/api-guide-for-toast-sdk/#consume-api).

### Specification for Unconsumed Purchases Query API

```csharp
public static void RequestConsumablePurchases(bool isQueryAllStores, ToastCallback<List<IapPurchase>> callback);
```

### Example of Unconsumed Purchases Query

```csharp
// Query all stores
ToastIap.RequestConsumablePurchases(true, (result, purchases) =>
{
    if (result.IsSuccessful)
    {
        // Querying unconsumed purchases  for all stores succeeded
    }
});
```

```csharp
// Query the current store
ToastIap.RequestConsumablePurchases(false, (result, purchases) =>
{
    if (result.IsSuccessful)
    {
        // Querying unconsumed purchases for the current store succeeded
    }
});
```

## Restore Subscription
- You can restore an activated subscription product by user ID.
    - Subscription products for which purchase has been completed can be restored as long as usage period remains.
    - The result of subscription product restoration query is returned as a list of [IapPurchase](./iap-unity/#iappurchase) object.
- Only the products subscribed in iOS can be restored.

### Specification for Subscription Restoration API

```csharp
public static void RequestRestorePurchases(ToastCallback<List<IapPurchase>> callback);
```

### Subscription Restoration Example

```csharp
ToastIap.RequestRestorePurchases((result, purchases) =>
{
    if (result.IsSuccessful)
    {
        // Subscription restoration query succeeded
    }
});
```

## Query Activated Subscription
- You can query an activated subscription product by user ID.
    - Subscription products for which purchase has been completed can be queried as long as usage period remains.
    - The result of activated subscription query is returned as a list of [IapPurchase](./iap-unity/#iappurchase) object.
- You can query products subscribed on Android in iOS, or products subscribed on iOS in Android.

### Specification for Activated Subscription Query API

```csharp
public static void RequestActivatedPurchases(bool isQueryAllStores, ToastCallback<List<IapPurchase>> callback);
```

### Example of Activated Subscription Query

```csharp
// Query activated subscriptions for all stores
ToastIap.RequestActivatedPurchases(true, (result, purchases) =>
{
    if (result.IsSuccessful)
    {
        // Query activated subscriptions for all stores
    }
});
```

```csharp
// Query activated subscriptions for the current store
ToastIap.RequestActivatedPurchases(false, (result, purchases) =>
{
    if (result.IsSuccessful)
    {
        // Query activated subscriptions for the current store
    }
});
```

## Query Subscription Status

- You can query the status of purchased subscription product by user ID.
- The result of subscription status query is returned as a list of [IapSubscriptionStatus](./iap-android/#iapsubscriptionstatus) object.
- Subscription status can be checked with the [IapSubscriptionStatus](./iap-android/#iapsubscriptionstatus).GetStatus() method.
- Subscription status codes are defined in  [IapSubscriptionStatus.Status](./iap-android/#iapsubscriptionstatusstatus).

### Specification for Subscription Status Query API

```csharp
public static void RequestSubscriptionsStatus(
            bool includeExpiredSubscriptions,
            ToastCallback<List<IapSubscriptionStatus>> callback);
```

### Example of Subscription Status Query

```csharp
ToastIap.RequestSubscriptionsStatus(true, (result, subscriptionsStatus) =>
{
    if (result.IsSuccessful)
    {
        // Success
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
| AppKey | string | Set IAP service Appkey. |
| StoreCode | StoreCode | Set the store code. |


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
| GooglePlayStore | Google Play Store (Android Only) |
| AppleAppStore | Apple App Store (iOS Only) |
| OneStore | ONE store (Android Only) |
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
| IsSuccessful | bool | Returns whether the result is successful. |
| Code | int | Returns a result code. <br/> (0 for success) |
| Message | string | Returns a result message. |

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
| Products | List<IapProduct> | Returns information of available products. |
| InvalidProducts | List<IapProduct> | Returns products that are registered in NHN Cloud IAP console but not registered in the store. |


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
| Id | string | Product ID |
| Name | string | Product name |
| ProductType | string | Product type |
| IsActive | bool | Whether the product is activated or not |
| Price | float | Price |
| Currency | string | Currency |
| LocalizedPrice | string | Local price |

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
| PaymentId | string | Payment ID |
| PaymentSequence | string | Payment sequence number |
| OriginalPaymentId | string | Original payment ID |
| ProductId | string | Product ID |
| ProductType | string | Product type |
| UserId | string | User ID |
| Price | float | Price |
| PriceCurrencyCode | string | Currency information |
| AccessToken | string | Token used for consumption |
| PurchaseTime | long | Product purchase time |
| ExpiryTime | long | Expiry time for subscription product |

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
| GetProductId | string | Payment ID |
| GetProductType | string | Payment sequence number |
| GetPaymentId | string | Original payment ID |
| GetOriginalPaymentId | string | Product ID |
| GetPaymentSequence | string | Product type |
| GetUserId | string | User ID |
| GetPrice | float | Price |
| GetPriceCurrencyCode | string | Currency information |
| GetAccessToken | string | Token used for consumption |
| GetPurchaseTime | long | Product purchase time |
| GetExpiryTime | long | Expiry time for subscription product |
| GetDeveloperPayload | string | Developer payload |
| GetStatus | Status | Subscription status |
| GetStatusDescription | string | Subscription status description |

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
| Active | 0 | Active | Subscription is active. |
| Canceled | 3 | Canceled | Subscription has been canceled. |
| OnHold | 5 | Account hold | Subscription was put on hold (if enabled). |
| InGracePeriod | 6 | Grace period | Subscription entered grace period (if enabled). |
| Paused | 10 | Paused | Subscription was paused. |
| Revoked | 12 | Revoked | Subscription was canceled by the user before expiry time. |
| Expired | 13 | Expired | Subscription has expired. |
| Unknown | 9999 | Undefined | Undefined status. |

## Error code

### Common Error Codes
| Error code | Description |
|---|---|
| 50000 | Not initialized |
| 50001 | Feature not supported |
| 50002 | Unsupported store code |
| 50003 | Product not available |
| 50004 | Product already owned |
| 50006 | Incorrect user ID |
| 50007 | User canceled payment |
| 50009 | Failed receipt verification |
| 50011 | Failed to renew subscription |
| 50015 | Product not owned |
| 50103 | Product already consumed |
| 50104 | Product already refunded |
| 50105 | Purchase limit exceeded |
| 59999 | Unknown error. Please check error message |

### Server error code

| Error code | Description |
|---|---|
| 10000 | Invalid request |
| 10002 | Not connected to network |
| 10003 | Server response failed |
| 10004 | Timeout occurred |
| 10005 | Invalid server return value |
| 10010 | App not activated |

### App store error code

| Error code | Description |
|---|---|
| 50005 | A request is already in progress |
| 50008 | Store payment failed |
| 50010 | Failed to change purchase status |
| 50012 | Cannot proceed with purchase due to refund |
| 50013 | Recovery failed |
| 50014 | Cannot make purchases now. (e.g. in-app purchase restrictions) |

### ONE store error code

| Error code | Description |
|---|---|
| 51000 | Not logged into ONE Store services |
| 51001 | ONE Store service has not been updated or installed |
| 51002 | Payment requested from abnormal app |
| 51003 | Payment request failed |

### Galaxy Store Error Codes

| Error code | Description |
|---|---|
| 53000 | Not logged into Galaxy Store services |
| 53001 | Galaxy Store service has not been updated or installed |
| 53002 | Payment requested from abnormal app |
| 51003 | Payment request failed |

## FAQ
### Android

#### Question.1
**If I switch an app to the background during purchase (or immediately after the purchase is complete) and re-enter the app with the app icon, a user cancellation error is returned as a callback. What should I do?**

#### Answer.1
This issue occurs because the launchMode of the Unity activity is singleTask . As the payment window is destroyed, it is recognized as a user cancellation, so a user cancellation error is returned.
If the payment has been completed in the store, you can re-process it by restarting the app or calling the unconsumed purchase inquiry. Once the reprocessing is complete, you will be able to issue the item to the user.
If the user tries to purchase again when reprocessing is not completed, an error indicating that the product is already owned will be returned (this prevents duplicate payments by the user).
