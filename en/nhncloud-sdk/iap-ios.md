## NHN Cloud > SDK User Guide > IAP > iOS

## Prerequisites

1. Install [NHN Cloud SDK](./getting-started-ios).
2. [Enable Mobile Service \> IAP](https://docs.nhncloud.com/en/Mobile%20Service/IAP/en/console-guide/) in [NHN Cloud console](https://console.nhncloud.com).
3. [Check AppKey](https://docs.nhncloud.com/en/Mobile%20Service/IAP/en/console-guide/#appkey) in IAP.

## NHN Cloud IAP Components

NHN Cloud IAP SDK for iOS consists of the following:

| Service  | Cocoapods Pod Name | Framework | Dependency | Build Settings |
| --- | --- | --- | --- | --- |
| IAP | NHNCloudIAP | NHNCloudIAP.framework | * StoreKit.framework<br/><br/>[Optional]<br/> * libsqlite3.tdb | |
| Mandatory   | NHNCloudCore<br/>NHNCloudCommon | NHNCloudCore.framework<br/>NHNCloudCommon.framework | | OTHER_LDFLAGS = (<br/>    "-ObjC",<br/>    "-lc++" <br/>); |


## Apply NHN Cloud IAP SDK to Xcode Projects

### 1. Apply using Cococapods

* Create a Podfile and add a pod for NHN Cloud SDK.

```podspec
platform :ios, '11.0'
use_frameworks!

target '{YOUR PROJECT TARGET NAME}' do
    pod 'NHNCloudIAP'
end
```

### 2. Apply NHN Cloud SDK with Swift Package Manager

* Go to **File > Add Packages...** from XCode.
* For the Package URL, enter 'https://github.com/nhn/nhncloud.ios.sdk' and select **Add Package**.
* Select NHNCloudIAP.

![swift_package_manager](https://static.toastoven.net/toastcloud/sdk/ios/swiftpackagemanager01.png)

#### Set up Project

* Add **-lc++** and **-ObjC** entries to **Other Linker Flags** in **Build Settings**.
    * **Project Target > Build Settings > Linking > Other Linker Flags**
![other_linker_flags](https://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags_202206.png)

### 3. Apply NHN Cloud SDK by Downloading Binaries

#### Frameworks Setup

* The entire iOS SDK can be downloaded from the [Downloads](../../../Download/#toast-sdk) page of NHN Cloud.
* Add **NHNCloudIAP.framework**, **NHNCloudCore.framework**, **NHNCloudCommon.framework, StoreKit.framework** to the Xcode Project.
* StoreKit.framework can be added in the following way.
![linked_storekit_frameworks](https://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_StoreKit_202206.png)

![linked_frameworks_iap](https://static.toastoven.net/toastcloud/sdk/ios/iap_link_frameworks_iap_202206.png)

#### Project Setup

* Add **-lc++** and **-ObjC** to **Other Linker Flags** under **Build Settings**.
    * **Project Target > Build Settings > Linking > Other Linker Flags**
![other_linker_flags](https://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags_202206.png)


### Capabilities Setup

* To use NHN Cloud IAP, you must enable the **In-App Purchase** option in Capabilities.
    * **Project Target > Capabilities > In-App Purchase**
![capabilities_iap](https://static.toastoven.net/toastcloud/sdk/ios/capability_iap_202206.png)

## Service Login

* All products provided by NHN Cloud SDK (Log & Crash, IAP, Push, etc.) share one user ID.

### Login

* `Without setting the user ID, features such as purchase, query of activated products, or query of unconsumed details are not available. `

``` objc
// Set user ID after service login is completed
[NHNCloudSDK setUserID:@"INPUT_USER_ID"];
```

### Logout

``` objc
// Set user ID to nil after service logout is completed
[NHNCloudSDK setUserID:nil];
```

## Initialize NHN Cloud IAP SDK

* Set the [AppKey](https://docs.nhncloud.com/en/Mobile%20Service/IAP/en/console-guide/#appkey) issued from IAP console on the [NHNCloudIAPConfiguration](./iap-ios/#nhncloudiapconfiguration) object.
* NHN Cloud IAP uses the [NHNCloudIAPConfiguration](./iap-ios/#nhncloudiapconfiguration) object as a parameter for initialization.

### Specification for Initialization API

``` objc
// Initialize
+ (void)initWithConfiguration:(NHNCloudIAPConfiguration *)configuration;
// Set delegate
+ (void)setDelegate:(nullable id<NHNCloudInAppPurchaseDelegate>)delegate;
// Initialize and set delegate
+ (void)initWithConfiguration:(NHNCloudIAPConfiguration *)configuration
                     delegate:(nullable id<NHNCloudInAppPurchaseDelegate>)delegate;
```

### Specification for Delegate API

* If you register [NHNCloudInAppPurchaseDelegate](./iap-ios/#nhncloudinapppurchasedelegate), you can receive notifications on purchase result and the decision of whether to proceed with promotion payment.
    * You can decide whether to proceed with the promotion payment in SDK or request payment directly when the user wants.
* The purchases for which payment is completed by reprocessing are not delegated, but are reflected on the list of unconsumed products (for consumable products) and the list of activated subscriptions (for subscription products).
* `To receive notifications on payment result, Delegate must be set before purchase of a product.`


``` objc
@protocol NHNCloudInAppPurchaseDelegate <NSObject>

// Purchase succeeded
- (void)didReceivePurchaseResult:(NHNCloudPurchaseResult *)purchase;

// Purchase failed
- (void)didFailPurchaseProduct:(NSString *)productIdentifier withError:(NSError *)error;

@optional
// Select how to proceed with the promotion payment
- (BOOL)shouldAddStorePurchaseForProduct:(NHNCloudProduct *)product API_AVAILABLE(ios(11.0));
@end
```

### Example of Initialization Procedure

``` objc
#import <UIKit/UIKit.h>
#import <NHNCloudIAP/NHNCloudIAP.h>

@interface ViewController () <NHNCloudInAppPurchaseDelegate>
@end

@implementation ViewController

- (void)initializeNHNCloudIAP {
    // Initialize and set delegate
    NHNCloudIAPConfiguration *configuration = [NHNCloudIAPConfiguration configurationWithAppKey:@"INPUT_YOUE_APPKEY"];

    [NHNCloudIAP initWithConfiguration:configuration delegate:self];
}

// Purchase succeeded
- (void)didReceivePurchaseResult:(NHNCloudPurchaseResult *)purchase {
    NSLog(@"Successfully purchased");
}

// Purchase failed
- (void)didFailPurchaseProduct:(NSString *)productIdentifier withError:(NSError *)error {
    NSLog(@"Failed to purchase: %@", error);
}

// Select how to proceed with the promotion payment
- (BOOL)shouldAddStorePurchaseForProduct:(NHNCloudProduct *)product {
    /*
    * return YES;
        * Make the requested promotion payment performed in SDK.
        * Payment window will show up after initialization and login.
    */
    return YES;

    /*
    * return NO;
        * Promotion payment will be terminated.
        * After storing the product object, you can proceed with payment using the stored object at a later time.
    */
    self.promotionProduct = product;
    return NO;
}

@end
```

## Query Product List

* Products registered in IAP console are returned as the [NHNCloudProductResponse](./iap-ios/#nhncloudproductresponse) object.
* Among the products registered in IAP console, products that can be purchased are returned as products ([NHNCloudProduct](./iap-ios/#nhncloudproduct)).
* Among the products registered in IAP console, products for which product information could not be obtained from Apple Store are returned as invalidProducts ([NHNCloudProduct](./iap-ios/#nhncloudproduct)).

### Specification for Product List Query API

``` objc
+ (void)requestProductsWithCompletionHandler:(nullable void (^)(NHNCloudProductsResponse * _Nullable response, NSError * _Nullable error))completionHandler;
```

### Usage Example of Product List Query API

``` objc
[NHNCloudIAP requestProductsWithCompletionHandler:^(NHNCloudProductsResponse *response, NSError *error) {
    if (error == nil) {
        NSArray<NHNCloudProduct *> *products = response.products;
        NSLog(@"Products : %@", products);

        // Failed to obtain product information from store
        NSArray<NHNCloudProduct *> *invalidProducts = response.invalidProducts;
        NSLog(@"Invalid Products : %@", invalidProducts);

    } else {
        NSLog(@"Failed to request products: %@", error);
    }
}
```

### Product Types

| Product Name    | Product Type             | Description                                     |
| ------ | ---------------- | -------------------------------------- |
| Consumable product | NHNCloudProductTypeConsumable     | Consumable one-time products. <br/>This can be used for in-game goods, coins, or products that can be purchased repeatedly. |
| Auto-renewable subscription product  | NHNCloudProductTypeAutoRenewableSubscription | Products that are automatically purchased at specific interval and price. <br>This can be used for access to magazines and music streaming services, and advertisement removal. |
| Auto-renewable consumable subscription product | NHNCloudProductTypeConsumableSubscription | Products that are automatically purchased at specific interval and price. <br/>This can be used to provide consumable products at specific interval and price. |

> `Upgrade, downgrade, and modification of auto-renewable subscription products are not supported.`
> `Only one product must be registered to one subscription group.`


``` objc
typedef NS_ENUM(NSInteger, NHNCloudProductType) {
    // Failed to obtain product types
    NHNCloudProductTypeUnknown = 0,
    // Consumable products
    NHNCloudProductTypeConsumable = 1,
    // Auto-renewable subscription products
    NHNCloudProductTypeAutoRenewableSubscription = 2,
    // Auto-renewable consumable subscription products
    NHNCloudProductTypeConsumableSubscription = 3
};
```

## Purchase Product

* A purchase result is passed via [NHNCloudInAppPurchaseDelegate](./iap-ios/#nhncloudinapppurchasedelegate) that has been set.
* If an app is closed during the purchase process or the purchase is interrupted due to a network error, etc., reprocessing will be performed after the IAP SDK initialization of the next app launch.
* When you request purchase, you can add user data.
* User data is returned in the [NHNCloudPurchaseResult](./iap-ios/#nhncloudpurchaseresult) object of a payment result (purchase success delegate, unconsumed payment details, activated subscription, purchase restoration).
* If the product cannot be purchased, an error indicating that the product is not available for purchase is passed via [NHNCloudInAppPurchaseDelegate](./iap-ios/#nhncloudinapppurchasedelegate).
* You can request purchase using the [NHNCloudProduct](./iap-ios/#nhncloudproduct) object or a product ID.

### Specification for Product Purchase API

``` objc
// Request product purchase
+ (void)purchaseWithProduct:(NHNCloudProduct *)product;
// Add user data when requesting product purchase
+ (void)purchaseWithProduct:(NHNCloudProduct *)product payload:(NSString *)payload;
// Request purchase with a product ID
+ (void)purchaseWithProductIdentifier:(NSString *)productIdentifier;
// Add user data when requesting purchase with a product ID
+ (void)purchaseWithProductIdentifier:(NSString *)productIdentifier payload:(NSString *)payload;
```

### Usage Example of Product Purchase API

``` objc
// Request product purchase
[NHNCloudIAP purchaseWithProduct:self.products[0] payload:@"DEVELOPER_PAYLOAD"];
// or
// Request purchase with a product ID
[NHNCloudIAP purchaseWithProductIdentifier:@"PRODUCT_IDENTIFIER" payload:@"DEVELOPER_PAYLOAD"];
```

## Query Activated Subscription List

* Query list of activated subscriptions for the current user ID.
* Subscription products (auto-renewal subscription, auto-renewal consumable subscription) for which payment is completed are returned as the [NHNCloudPurchaseResult](./iap-ios/#nhncloudpurchaseresult) objects until they are expired.
* If the user ID is the same, subscription products purchased on Android can also be queried.

### Specification for Activated Subscription List API

``` objc
// Query an activated subscription list in App Store
+ (void)requestActiveSubscriptionsWithCompletionHandler:(nullable void (^)(NSArray<NHNCloudPurchaseResult *> * _Nullable purchases, NSError * _Nullable error))completionHandler;

// Query the list of activated subscriptions in all markets (such as App Store, Google Play, and ONE Store)
+ (void)requestAllMarketsActiveSubscriptionsWithCompletionHandler:(nullable void (^)(NSArray<NHNCloudPurchaseResult *> * _Nullable purchases, NSError * _Nullable error))completionHandler;
```

### Usage Example of Activated Subscription List Query API

``` objc
[NHNCloudIAP requestActiveSubscriptionsWithCompletionHandler:^(NSArray<NHNCloudPurchaseResult *> *purchases, NSError *error) {
    if (error == nil) {
        for (NHNCloudPurchaseResult *purchase in purchases) {
            // Activate access for subscription products
        }
    } else {
        NSLog(@"Failed to request active purchases : %@", error);
    }
}];
```

## Restore Purchases

* Restore purchases based on the items purchased with the user's AppStore account and reflect it on the IAP console.
* Use this feature if purchased subscription products cannot be queried or activated.
* Restored purchases including the expired purchases are returned a an [NHNCloudPurchaseResult](./iap-ios/#nhncloudpurchaseresult) object.
* In case of auto-renewable consumable subscription products, if there is purchases that is not reflected, it can be queried from the unconsumed purchases after restoration.

### Specification for Purchase Restoration API

``` objc
// Restore purchase
+ (void)restoreWithCompletionHandler:(nullable void (^)(NSArray<NHNCloudPurchaseResult *> * _Nullable purchases, NSError * _Nullable error))completionHandler;
```

### Usage Example of Purchase Restoration API

``` objc
[NHNCloudIAP restoreWithCompletionHandler:^(NSArray<NHNCloudPurchaseResult *> *purchases, NSError *error) {
    if (error == nil) {
        for (NHNCloudPurchaseResult *purchase in purchases) {
            NSLog(@"Restored purchase : %@", purchase);
        }
    } else {
        NSLog(@"Failed to request restore : %@", error);
    }
}];
```

## Query Unconsumed Purchases

* An consumable product must be processed as consumed after product is provided.
* Purchases that have not been processed as consumed are returned a an [NHNCloudPurchaseResult](./iap-ios/#nhncloudpurchaseresult) object.
* Auto-renewable consumable subscription products can be queried from the unconsumed purchases whenever a renewal occurs.

### Specification for Unconsumed Purchase Query API

``` objc
// Query unconsumed purchases for App Store
+ (void)requestConsumablePurchasesWithCompletionHandler:(nullable void (^)(NSArray<NHNCloudPurchaseResult *> * _Nullable purchases, NSError * _Nullable error))completionHandler;

// Query unconsumed purchases for all markets (such as App Store, Google Play, and ONE Store)
+ (void)requestAllMarketsConsumablePurchasesWithCompletionHandler:(nullable void (^)(NSArray<NHNCloudPurchaseResult *> * _Nullable purchases, NSError * _Nullable error))completionHandler;
```

### Usage Example of Unconsumed Purchase Query API

``` objc
[NHNCloudIAP requestConsumablePurchasesWithCompletionHandler:^(NSArray<NHNCloudPurchaseResult *> *purchases, NSError *error) {
    if (error == nil) {
        NSLog(@"Consumable Purchases : %@", purchases);
    } else {
        NSLog(@"Failed to request consumable : %@", error);
    }
}
```

## Consume Consumable Products

* Consumable products must be processed as consumed through REST API or Consume API of SDK, after products are provided.

### Specification for Consumption API

``` objc
+ (void)consumeWithPurchaseResult:(NHNCloudPurchaseResult *)result
                completionHandler:(nullable void (^)(NSError * _Nullable error))completionHandler;
```

### Usage Example of Consumption API

``` objc
// Query Unconsumed Purchases
[NHNCloudIAP requestConsumablePurchasesWithCompletionHandler:^(NSArray<NHNCloudPurchaseResult *> *purchases, NSError *error) {
    if (error == nil) {
        for (NHNCloudPurchaseResult *purchaseResult in purchases) {
            //  Process as Product Provided
            // ...

            // Process as Consumed after Product is Provided
            [NHNCloudIAP consumeWithPurchaseResult:purchaseResult
                              completionHandler:^(NSError *error) {
                                    if (error == nil) {
                                        NSLog(@"Successfully consumed");

                                    } else {
                                        NSLog(@"Failed to consume : %@", error);

                                        // Retreive Product Provided
                                        // ...
                                    }
                              }];
        }

    } else {
        NSLog(@"Failed to request consumable : %@", error);
    }
}
```

## Provide Subscription Product Management Page

* When auto-renewable subscription products are used, the Manage Subscriptions page must be provided to users.
> [Apple Guide](https://developer.apple.com/documentation/storekit/in-app_purchase/original_api_for_in-app_purchase/subscriptions_and_offers/handling_subscriptions_billing?language=objc)

* Without configuring a separate UI, you must display the Manage Subscriptions page by calling the URL below.

```
https://apps.apple.com/account/subscriptions
itms-apps://buy.itunes.apple.com/WebObjects/MZFinance.woa/wa/manageSubscription
```

### Connect to Manage Subscription Page

```objc
[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://apps.apple.com/account/subscriptions"] options: @{} completionHandler:nil];
```

Or

```objc
[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://buy.itunes.apple.com/WebObjects/MZFinance.woa/wa/manageSubscriptions"] options: @{} completionHandler:nil];
```

The Manage Subscriptions page of App Store is connected.

> `Service App` appears in the return to previous app button in the top left corner of an iOS device.

## Remain Compatible with (old) IAP SDK

* To remain compatible with (old) IAP SDK, reprocessing is supported for incomplete purchases created by (old) IAP SDK.
* >To enable compatibility with (old) IAP SDK, additionally link `sqlite3 Library(libsqlite3.tdb)`.
![linked_sqlite3](https://static.toastoven.net/toastcloud/sdk/ios/iap_link_sqlite3_202206.png)

### Specification for Reprocessing Incomplete Purchase API

``` objc
+ (void)processesIncompletePurchasesWithCompletionHandler:(nullable void (^)(NSArray <NHNCloudPurchaseResult *> * _Nullable results, NSError * _Nullable error))completionHandler;
```

### Usage Example of Reprocessing Incomplete Purchase

``` objc
// Request for Reprocessing Incomplete Purchase
[NHNCloudIAP processesIncompletePurchasesWithCompletionHandler:^(NSArray<NHNCloudPurchaseResult *> *results, NSError *error) {
    if (error == nil) {
        for (NHNCloudPurchaseResult *purchaseResult in results) {
            // Process as Product Provided
            // ...

            // Process as Consumed after Product Provided
            [NHNCloudIAP consumeWithPurchaseResult:purchaseResult
                              completionHandler:^(NSError *error) {
                                    if (error == nil) {
                                        NSLog(@"Successfully consumed");

                                    } else {
                                        NSLog(@"Failed to consume : %@", error);

                                        // Retrieve Product Provided
                                        // ...
                                    }
                              }];
        }

    } else {
        NSLog(@"Failed to process incomplete purchases : %@", error);
    }
}];
```


## NHN Cloud IAP Class Reference

### NHNCloudIAPConfiguration

IAP configuration information which is used as a parameter for the NHN Cloud IAP initialization method.

```objc
@interface NHNCloudIAPConfiguration : NSObject <NSCoding, NSCopying>

// IAP service Appkey
@property (nonatomic, copy, readonly) NSString *appKey;
// Service zone
@property (nonatomic) NHNCloudServiceZone serviceZone;

+ (instancetype)configurationWithAppKey:(NSString *)appKey;

- (instancetype)initWithAppKey:(NSString *)appKey
NS_SWIFT_NAME(init(appKey:));

@end
```

## NHNCloudInAppPurchaseDelegate

Lets you be notified of the purchase result and set how to perform a promotion purchase.

```objc
@protocol NHNCloudInAppPurchaseDelegate <NSObject>

// Purchase succeeded
- (void)didReceivePurchaseResult:(NHNCloudPurchaseResult *)purchase
NS_SWIFT_NAME(didReceivePurchase(purchase:));

// Purchase failed
- (void)didFailPurchaseProduct:(NSString *)productIdentifier withError:(NSError *)error
NS_SWIFT_NAME(didFailPurchase(productIdentifier:error:));

@optional
// Select how to proceed with the promotion payment
- (BOOL)shouldAddStorePurchaseForProduct:(NHNCloudProduct *)product API_AVAILABLE(ios(11.0));

@end
```

## NHNCloudProductResponse

Lets you check the product list information.

```objc
@interface NHNCloudProductsResponse : NSObject <NSCoding, NSCopying>

// List of products that can be used for purchase, which are registered in IAP console and Apple Store
@property (nonatomic, copy, readonly) NSArray<NHNCloudProduct *> *products;
// List of products for which product information could not be obtained from Apple Store
@property (nonatomic, copy, readonly) NSArray<NHNCloudProduct *> *invalidProducts;

@end
```

## NHNCloudProduct

Lets you check information of a product registered in NHN Cloud IAP console.

```objc
@interface NHNCloudProduct : NSObject <NSCoding, NSCopying>

// Product ID
@property (nonatomic, copy, readonly) NSString *productIdentifier;
// Product sequence number
@property (nonatomic, readonly) long productSeq;
// Product name (IAP console)
@property (nonatomic, copy, readonly, nullable) NSString *productName;
// Product type
@property (nonatomic, readonly) NHNCloudProductType productType;
// Price
@property (nonatomic, copy, readonly, nullable) NSDecimalNumber *price;
// Currency
@property (nonatomic, copy, readonly, nullable) NSString *currency;
// Local product name (AppStoreConnect)
@property (nonatomic, copy, readonly, nullable) NSString *localizedTitle;
// Local product description (AppStoreConnect)
@property (nonatomic, copy, readonly, nullable) NSString *localizedDescription;
// Local price
@property (nonatomic, copy, readonly, nullable) NSString *localizedPrice;
// Whether the product is activated or not
@property (nonatomic, readonly, getter=isActive) BOOL active;
// Store code "AS"
@property (nonatomic, copy, readonly) NSString *storeCode;

@end
```

## NHNCloudPurchaseResult

Lets you check the purchase information.

```objc
@interface NHNCloudPurchaseResult : NSObject <NSCoding, NSCopying>

// User ID
@property (nonatomic, copy, readonly) NSString *userID;
// Store code "AS"
@property (nonatomic, copy, readonly) NSString *storeCode;
// Product ID
@property (nonatomic, copy, readonly) NSString *productIdentifier;
// Product sequence number
@property (nonatomic, readonly) long productSeq;
// Product type
@property (nonatomic, readonly) NHNCloudProductType productType;
// Price
@property (nonatomic, copy, readonly) NSDecimalNumber *price;
// Currency
@property (nonatomic, copy, readonly) NSString *currency;
// Payment sequence number payment ID
@property (nonatomic, copy, readonly) NSString *paymentSeq;
// Token used for consumption
@property (nonatomic, copy, readonly) NSString *accessToken;
// Transaction ID
@property (nonatomic, copy, readonly) NSString *transactionIdentifier;
// Original transaction ID
@property (nonatomic, copy, readonly, nullable) NSString *originalTransactionIdentifier;
// Product purchase time
@property (nonatomic, readonly) NSTimeInterval purchaseTime;
// Expiry time of a subscription product
@property (nonatomic, readonly) NSTimeInterval expiryTime;
// Whether it is promotion payment or not
@property (nonatomic, readonly, getter=isStorePayment) BOOL storePayment;
// Whether it is sandbox payment or not
@property (nonatomic, readonly, getter=isSandboxPayment) BOOL sandboxPayment;
// User data
@property (nonatomic, readonly, copy, nullable) NSString *payload;

@end
```

## Error Codes
```objc
// IAP Error
static NSString *const NHNCloudIAPErrorDomain = @"com.nhncloud.iap";

typedef NS_ENUM(NSUInteger, NHNCloudIAPError) {
    NHNCloudIAPErrorUnknown = 0,                       // Unknown
    NHNCloudIAPErrorNotInitialized = 1,                // Not Initialized
    NHNCloudIAPErrorStoreNotAvailable = 2,             // Store is unavailable
    NHNCloudIAPErrorProductNotAvailable = 3,           // Failed to get product information
    NHNCloudIAPErrorProductInvalid = 4,                // Inconsistency of IDs between original payment and current product
    NHNCloudIAPErrorAlreadyOwned = 5,                  // Product is already owned
    NHNCloudIAPErrorAlreadyInProgress = 6,             // Request is already processing
    NHNCloudIAPErrorUserInvalid = 7,                   // Inconsistency of IDs between current user and paid user
    NHNCloudIAPErrorPaymentInvalid = 8,                // Failed to get further payment information (ApplicationUsername)
    NHNCloudIAPErrorPaymentCancelled = 9,              // Store payment cancelled
    NHNCloudIAPErrorPaymentFailed = 10,                // Store payment failed
    NHNCloudIAPErrorVerifyFailed = 11,                 // Receipt verification failed
    NHNCloudIAPErrorChangePurchaseStatusFailed = 12,   // Change of purchase status failed
    NHNCloudIAPErrorPurchaseStatusInvalid = 13,        // Unavailable to purchase
    NHNCloudIAPErrorExpired = 14,                      // Subscription expired
    NHNCloudIAPErrorRenewalPaymentNotFound = 15,       // Renewal payment information not found in receipt
    NHNCloudIAPErrorRestoreFailed = 16,                // Failed to restore
    NHNCloudIAPErrorPaymentNotAvailable = 17,          // Status of purchase inoperative (e.g. setting purchase restrictions in app)
    NHNCloudIAPErrorPurchaseLimitExceeded = 18,        // Monthly purchase limit exceeded
};

// Network Error
static NSString *const NHNCloudHttpErrorDomain = @"com.nhncloud.http";

typedef NS_ENUM(NSUInteger, NHNCloudHttpError) {
    NHNCloudHttpErrorNetworkNotAvailable = 100,        // Network is unavailable
    NHNCloudHttpErrorRequestFailed = 101,              // HTTP Status Code is not 200 or can not read request
    NHNCloudHttpErrorRequestTimeout = 102,             // Timeout
    NHNCloudHttpErrorRequestInvalid = 103,             // Request is invalid
    NHNCloudHttpErrorURLInvalid = 104,                 // URL is invalid
    NHNCloudHttpErrorResponseInvalid = 105,            // Response is invalid
    NHNCloudHttpErrorAlreadyInprogress = 106,          // Request is already in progress
    NHNCloudHttpErrorRequiresSecureConnection = 107,   // Do not set Allow Arbitrary Loads
};
```
