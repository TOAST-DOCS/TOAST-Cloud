## TOAST > TOAST SDK User Guide > TOAST IAP > iOS

## Prerequisites

1. Install [TOAST SDK](./getting-started-ios).
2. [Enable Mobile Service \> IAP](https://docs.toast.com/ko/Mobile%20Service/IAP/ko/console-guide/) in [TOAST console](https://console.cloud.toast.com).
3. [Check AppKey](https://docs.toast.com/ko/Mobile%20Service/IAP/ko/console-guide/#appkey) in IAP.

## TOAST IAP Components

TOAST IAP SDK for iOS consists of the following:

| Service  | Cocoapods Pod Name | Framework | Dependency | Build Settings |
| --- | --- | --- | --- | --- |
| TOAST IAP | ToastIAP | ToastIAP.framework | * StoreKit.framework<br/><br/>[Optional]<br/> * libsqlite3.tdb | |
| Mandatory   | ToastCore<br/>ToastCommon | ToastCore.framework<br/>ToastCommon.framework | | OTHER_LDFLAGS = (<br/>    "-ObjC",<br/>    "-lc++" <br/>); |


## Apply TOAST IAP SDK to Xcode Projects

### 1. Apply using Cococapods

* Create a Podfile and add a pod for TOAST SDK.

```podspec
platform :ios, '9.0'
use_frameworks!

target '{YOUR PROJECT TARGET NAME}' do
    pod 'ToastIAP'
end
```

### 2. Apply TOAST SDK by Downloading Binaries

#### Frameworks Setup

* The entire iOS SDK can be downloaded from the [Downloads](../../../Download/#toast-sdk) page of TOAST.
* Add **ToastIAP.framework**, **ToastCore.framework**, **ToastCommon.framework, StoreKit.framework** to the Xcode Project.
* StoreKit.framework can be added in the following way.
![linked_storekit_frameworks](http://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_StoreKit.png)

![linked_frameworks_iap](http://static.toastoven.net/toastcloud/sdk/ios/iap_link_frameworks_iap.png)

#### Project Setup

* Add **-lc++** and **-ObjC** to **Other Linker Flags** under **Build Settings**.
    * **Project Target > Build Settings > Linking > Other Linker Flags**
![other_linker_flags](http://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags.png)


### Capabilities Setup

* To use TOAST IAP, you must enable the **In-App Purchase** option in Capabilities.
    * **Project Target > Capabilities > In-App Purchase**
![capabilities_iap](http://static.toastoven.net/toastcloud/sdk/ios/capability_iap.png)

## Service Login

* All products provided by TOAST SDK (Log & Crash, IAP, Push, etc.) share one user ID.

### Login

* `Without setting the user ID, features such as purchase, query of activated products, or query of unconsumed details are not available. `

``` objc
// Set user ID after service login is completed
[ToastSDK setUserID:@"INPUT_USER_ID"];
```

### Logout

``` objc
// Set user ID to nil after service logout is completed
[ToastSDK setUserID:nil];
```

## Initialize TOAST IAP SDK

* Set the [AppKey](https://docs.toast.com/ko/Mobile%20Service/IAP/ko/console-guide/#appkey) issued from IAP console on the [ToastIAPConfiguration](./iap-ios/#toastiapconfiguration) object.
* TOAST IAP uses the [ToastIAPConfiguration](./iap-ios/#toastiapconfiguration) object as a parameter for initialization.

### Specification for Initialization API

``` objc
// Initialize
+ (void)initWithConfiguration:(ToastIAPConfiguration *)configuration;
// Set delegate
+ (void)setDelegate:(nullable id<ToastInAppPurchaseDelegate>)delegate;
// Initialize and set delegate
+ (void)initWithConfiguration:(ToastIAPConfiguration *)configuration
                     delegate:(nullable id<ToastInAppPurchaseDelegate>)delegate;
```

### Specification for Delegate API

* If you register [ToastInAppPurchaseDelegate](./iap-ios/#toastinapppurchasedelegate), you can receive notifications on purchase result and the decision of whether to proceed with promotion payment.
    * You can decide whether to proceed with the promotion payment in SDK or request payment directly when the user wants.
* The purchases for which payment is completed by reprocessing are not delegated, but are reflected on the list of unconsumed products (for consumable products) and the list of activated subscriptions (for subscription products).
* `To receive notifications on payment result, Delegate must be set before purchase of a product.`


``` objc
@protocol ToastInAppPurchaseDelegate <NSObject>

// Purchase succeeded
- (void)didReceivePurchaseResult:(ToastPurchaseResult *)purchase;

// Purchase failed
- (void)didFailPurchaseProduct:(NSString *)productIdentifier withError:(NSError *)error;

@optional
// Select how to proceed with the promotion payment
- (BOOL)shouldAddStorePurchaseForProduct:(ToastProduct *)product API_AVAILABLE(ios(11.0));
@end
```

### Example of Initialization Procedure

``` objc
#import <UIKit/UIKit.h>
#import <ToastIAP/ToastIAP.h>

@interface ViewController () <ToastInAppPurchaseDelegate>
@end

@implementation ViewController

- (void)initializeTosatIAP {
    // Initialize and set delegate
    ToastIAPConfiguration *configuration = [ToastIAPConfiguration configurationWithAppKey:@"INPUT_YOUE_APPKEY"];

    [ToastIAP initWithConfiguration:configuration delegate:self];
}

// Purchase succeeded
- (void)didReceivePurchaseResult:(ToastPurchaseResult *)purchase {
    NSLog(@"Successfully purchased");
}

// Purchase failed
- (void)didFailPurchaseProduct:(NSString *)productIdentifier withError:(NSError *)error {
    NSLog(@"Failed to purchase: %@", erorr);
}

// Select how to proceed with the promotion payment
- (BOOL)shouldAddStorePurchaseForProduct:(ToastProduct *)product {
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

* Products registered in IAP console are returned as the [ToastProductResponse](./iap-ios/#toastproductresponse) object.
* Among the products registered in IAP console, products that can be purchased are returned as products ([ToastProduct](./iap-ios/#toastproduct)).
* Among the products registered in IAP console, products for which product information could not be obtained from Apple Store are returned as invalidProducts ([ToastProduct](./iap-ios/#toastproduct)).

### Specification for Product List Query API

``` objc
+ (void)requestProductsWithCompletionHandler:(nullable void (^)(ToastProductsResponse * _Nullable response, NSError * _Nullable error))completionHandler;
```

### Usage Example of Product List Query API

``` objc
[ToastIAP requestProductsWithCompletionHandler:^(ToastProductsResponse *response, NSError *error) {
    if (error == nil) {
        NSArray<ToastProduct *> *products = response.products;
        NSLog(@"Products : %@", products);

        // Failed to obtain product information from store
        NSArray<ToastProduct *> *invalidProducts = response.invalidProducts;
        NSLog(@"Invalid Products : %@", invalidProducts);

    } else {
        NSLog(@"Failed to request products: %@", error);
    }
}
```

### Product Types

| Product Name    | Product Type             | Description                                     |
| ------ | ---------------- | -------------------------------------- |
| Consumable product | ToastProductTypeConsumable     | Consumable one-time products. <br/>This can be used for in-game goods, coins, or products that can be purchased repeatedly. |
| Auto-renewable subscription product  | ToastProductTypeAutoRenewableSubscription | Products that are automatically purchased at specific interval and price. <br>This can be used for access to magazines and music streaming services, and advertisement removal. |
| Auto-renewable consumable subscription product | ToastProductTypeConsumableSubscription | Products that are automatically purchased at specific interval and price. <br/>This can be used to provide consumable products at specific interval and price. |

> `Upgrade, downgrade, and modification of auto-renewable subscription products are not supported.`
> `Only one product must be registered to one subscription group.`


``` objc
typedef NS_ENUM(NSInteger, ToastProductType) {
    // Failed to obtain product types
    ToastProductTypeUnknown = 0,
    // Consumable products
    ToastProductTypeConsumable = 1,
    // Auto-renewable subscription products
    ToastProductTypeAutoRenewableSubscription = 2,
    // Auto-renewable consumable subscription products
    ToastProductTypeConsumableSubscription = 3
};
```

## Purchase Product

* A purchase result is passed via [ToastInAppPurchaseDelegate](./iap-ios/#toastinapppurchasedelegate) that has been set.
* If an app is closed during the purchase process or the purchase is interrupted due to a network error, etc., reprocessing will be performed after the IAP SDK initialization of the next app launch.
* When you request purchase, you can add user data.
* User data is returned in the [ToastPurchaseResult](./iap-ios/#toastpurchaseresult) object of a payment result (purchase success delegate, unconsumed payment details, activated subscription, purchase restoration).
* If the product cannot be purchased, an error indicating that the product is not available for purchase is passed via [ToastInAppPurchaseDelegate](./iap-ios/#toastinapppurchasedelegate).
* You can request purchase using the [ToastProduct](./iap-ios/#toastproduct) object or a product ID.

### Specification for Product Purchase API

``` objc
// Request product purchase
+ (void)purchaseWithProduct:(ToastProduct *)product;
// Add user data when requesting product purchase
+ (void)purchaseWithProduct:(ToastProduct *)product payload:(NSString *)payload;
// Request purchase with a product ID
+ (void)purchaseWithProductIdentifier:(NSString *)productIdentifier;
// Add user data when requesting purchase with a product ID
+ (void)purchaseWithProductIdentifier:(NSString *)productIdentifier payload:(NSString *)payload;
```

### Usage Example of Product Purchase API

``` objc
// Request product purchase
[ToastIAP purchaseWithProduct:self.products[0] payload:@"DEVELOPER_PAYLOAD"];
// or
// Request purchase with a product ID
[ToastIAP purchaseWithProductIdentifier:@"PRODUCT_IDENTIFIER" payload:@"DEVELOPER_PAYLOAD"];
```

## Query Activated Subscription List

* Query list of activated subscriptions for the current user ID.
* Subscription products (auto-renewal subscription, auto-renewal consumable subscription) for which payment is completed are returned as the [ToastPurchaseResult](./iap-ios/#toastpurchaseresult) objects until they are expired.
* If the user ID is the same, subscription products purchased on Android can also be queried.

### Specification for Activated Subscription List API

``` objc
// Query activated subscription list
+ (void)requestActivePurchasesWithCompletionHandler:(nullable void (^)(NSArray<ToastPurchaseResult *> * _Nullable purchases, NSError * _Nullable error))completionHandler;
```

### Usage Example of Activated Subscription List Query API

``` objc
[ToastIAP requestActivePurchasesWithCompletionHandler:^(NSArray<ToastPurchaseResult *> *purchases, NSError *error) {
    if (error == nil) {
        for (ToastPurchaseResult *purchase in purchases) {
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
* Restored purchases including the expired purchases are returned a an [ToastPurchaseResult](./iap-ios/#toastpurchaseresult) object.
* In case of auto-renewable consumable subscription products, if there is purchases that is not reflected, it can be queried from the unconsumed purchases after restoration.

### Specification for Purchase Restoration API

``` objc
// Restore purchase
+ (void)restoreWithCompletionHandler:(nullable void (^)(NSArray<ToastPurchaseResult *> * _Nullable purchases, NSError * _Nullable error))completionHandler;
```

### Usage Example of Purchase Restoration API

``` objc
[ToastIAP restoreWithCompletionHandler:^(NSArray<ToastPurchaseResult *> *purchases, NSError *error) {
    if (error == nil) {
        for (ToastPurchaseResult *purchase in purchases) {
            NSLog(@"Restored purchase : %@", purchase);
        }
    } else {
        NSLog(@"Failed to request restore : %@", error);
    }
}];
```

## Query Unconsumed Purchases

* An consumable product must be processed as consumed after product is provided.
* Purchases that have not been processed as consumed are returned a an [ToastPurchaseResult](./iap-ios/#toastpurchaseresult) object.
* Auto-renewable consumable subscription products can be queried from the unconsumed purchases whenever a renewal occurs.

### Specification for Unconsumed Purchase Query API

``` objc
// Query Unconsumed Purchases
+ (void)requestConsumablePurchasesWithCompletionHandler:(nullable void (^)(NSArray<ToastPurchaseResult *> * _Nullable purchases, NSError * _Nullable error))completionHandler;
```

### Usage Example of Unconsumed Purchase Query API

``` objc
[ToastIAP requestConsumablePurchasesWithCompletionHandler:^(NSArray<ToastPurchaseResult *> *purchases, NSError *error) {
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
+ (void)consumeWithPurchaseResult:(ToastPurchaseResult *)result
                completionHandler:(nullable void (^)(NSError * _Nullable error))completionHandler;
```

### Usage Example of Consumption API

``` objc
// Query Unconsumed Purchases
[ToastIAP requestConsumablePurchasesWithCompletionHandler:^(NSArray<ToastPurchaseResult *> *purchases, NSError *error) {
    if (error == nil) {
        for (ToastPurchaseResult *purchaseResult in purchases) {
            //  Process as Product Provided
            // ...

            // Process as Consumed after Product is Provided
            [ToastIAP consumeWithPurchaseResult:purchaseResult
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

## Provide Page for Subscription Products

* For auto-renewable subscription products, users must be provided with a subscription management page.
> [Apple Guide](https://developer.apple.com/library/archive/documentation/NetworkingInternet/Conceptual/StoreKitGuide/Chapters/Subscriptions.html#//apple_ref/doc/uid/TP40008267-CH7-SW19)

* Without configuring a separate UI, call URL as below to display subscription management page.

### Connect to Subscription Management Page on Safari
```
https://buy.itunes.apple.com/WebObjects/MZFinance.woa/wa/manageSubscriptions
```
```objc
[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://buy.itunes.apple.com/WebObjects/MZFinance.woa/wa/manageSubscriptions"]];
```
#### Management page on Safari is called in the following order:
1. Safari Opens
2. Popup Shows: Want to open in iTunes Store?
3. iTunes Store Opens
4. Connected to subscription management page on a popup

>  `Safari` appears for Return to Previous App on top left on an iOS Device.


### Connect to Subscription Management Page on Scheme
```
itms-apps://buy.itunes.apple.com/WebObjects/MZFinance.woa/wa/manageSubscriptions
```

```objc
[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://buy.itunes.apple.com/WebObjects/MZFinance.woa/wa/manageSubscriptions"]];
```

#### Management page on Scheme is called in the following order:
1. Subscription management page of App Store is directly connected with App-to-App call.

>  `Service App` appears for Return to Previous App on top left on an iOS device.


## Remain Compatible with (old) IAP SDK

* To remain compatible with (old) IAP SDK, reprocessing is supported for incomplete purchases created by (old) IAP SDK.
* >To enable compatibility with (old) IAP SDK, additionally link `sqlite3 Library(libsqlite3.tdb)`.
![linked_sqlite3](http://static.toastoven.net/toastcloud/sdk/ios/iap_link_sqlite3.png)

### Specification for Reprocessing Incomplete Purchase API

``` objc
+ (void)processesIncompletePurchasesWithCompletionHandler:(nullable void (^)(NSArray <ToastPurchaseResult *> * _Nullable results, NSError * _Nullable error))completionHandler;
```

### Usage Example of Reprocessing Incomplete Purchase

``` objc
// Request for Reprocessing Incomplete Purchase
[ToastIAP processesIncompletePurchasesWithCompletionHandler:^(NSArray<ToastPurchaseResult *> *results, NSError *error) {
    if (error == nil) {
        for (ToastPurchaseResult *purchaseResult in results) {
            // Process as Product Provided
            // ...

            // Process as Consumed after Product Provided
            [ToastIAP consumeWithPurchaseResult:purchaseResult
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


## TOAST IAP Class Reference

### ToastIAPConfiguration

IAP configuration information which is used as a parameter for the TOAST IAP initialization method.

```objc
@interface ToastIAPConfiguration : NSObject <NSCoding, NSCopying>

// IAP service Appkey
@property (nonatomic, copy, readonly) NSString *appKey;
// Service zone
@property (nonatomic) ToastServiceZone serviceZone;

+ (instancetype)configurationWithAppKey:(NSString *)appKey;

- (instancetype)initWithAppKey:(NSString *)appKey
NS_SWIFT_NAME(init(appKey:));

@end
```

## ToastInAppPurchaseDelegate

Lets you be notified of the purchase result and set how to perform a promotion purchase.

```objc
@protocol ToastInAppPurchaseDelegate <NSObject>

// Purchase succeeded
- (void)didReceivePurchaseResult:(ToastPurchaseResult *)purchase
NS_SWIFT_NAME(didReceivePurchase(purchase:));

// Purchase failed
- (void)didFailPurchaseProduct:(NSString *)productIdentifier withError:(NSError *)error
NS_SWIFT_NAME(didFailPurchase(productIdentifier:error:));

@optional
// Select how to proceed with the promotion payment
- (BOOL)shouldAddStorePurchaseForProduct:(ToastProduct *)product API_AVAILABLE(ios(11.0));

@end
```

## ToastProductResponse

Lets you check the product list information.

```objc
@interface ToastProductsResponse : NSObject <NSCoding, NSCopying>

// List of products that can be used for purchase, which are registered in IAP console and Apple Store
@property (nonatomic, copy, readonly) NSArray<ToastProduct *> *products;
// List of products for which product information could not be obtained from Apple Store
@property (nonatomic, copy, readonly) NSArray<ToastProduct *> *invalidProducts;

@end
```

## ToastProduct

Lets you check information of a product registered in TOAST IAP console.

```objc
@interface ToastProduct : NSObject <NSCoding, NSCopying>

// Product ID
@property (nonatomic, copy, readonly) NSString *productIdentifier;
// Product sequence number
@property (nonatomic, readonly) long productSeq;
// Product name (IAP console)
@property (nonatomic, copy, readonly, nullable) NSString *productName;
// Product type
@property (nonatomic, readonly) ToastProductType productType;
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

## ToastPurchaseResult

Lets you check the purchase information.

```objc
@interface ToastPurchaseResult : NSObject <NSCoding, NSCopying>

// User ID
@property (nonatomic, copy, readonly) NSString *userID;
// Store code "AS"
@property (nonatomic, copy, readonly) NSString *storeCode;
// Product ID
@property (nonatomic, copy, readonly) NSString *productIdentifier;
// Product sequence number
@property (nonatomic, readonly) long productSeq;
// Product type
@property (nonatomic, readonly) ToastProductType productType;
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
// 샌드박스 결제 여부
@property (nonatomic, readonly, getter=isSandboxPayment) BOOL sandboxPayment;
// User data
@property (nonatomic, readonly, copy, nullable) NSString *payload;

@end
```

## Error Codes
```objc
// IAP Error
static NSString *const ToastIAPErrorDomain = @"com.toast.iap";

typedef NS_ENUM(NSUInteger, ToastIAPErrorCode) {
    ToastIAPErrorUnknown = 0,                       // Unknown
    ToastIAPErrorNotInitialized = 1,                // Not Initialized
    ToastIAPErrorStoreNotAvailable = 2,             // Store is unavailable
    ToastIAPErrorProductNotAvailable = 3,           // Failed to get product information
    ToastIAPErrorProductInvalid = 4,                // Inconsistency of IDs between original payment and current product
    ToastIAPErrorAlreadyOwned = 5,                  // Product is already owned
    ToastIAPErrorAlreadyInProgress = 6,             // Request is already processing
    ToastIAPErrorUserInvalid = 7,                   // Inconsistency of IDs between current user and paid user
    ToastIAPErrorPaymentInvalid = 8,                // Failed to get further payment information (ApplicationUsername)
    ToastIAPErrorPaymentCancelled = 9,              // Store payment cancelled
    ToastIAPErrorPaymentFailed = 10,                // Store payment failed
    ToastIAPErrorVerifyFailed = 11,                 // Receipt verification failed
    ToastIAPErrorChangePurchaseStatusFailed = 12,   // Change of purchase status failed
    ToastIAPErrorPurchaseStatusInvalid = 13,        // Unavailable to purchase
    ToastIAPErrorExpired = 14,                      // Subscription expired
    ToastIAPErrorRenewalPaymentNotFound = 15,       // Renewal payment information not found in receipt
    ToastIAPErrorRestoreFailed = 16,                // Failed to restore
    ToastIAPErrorPaymentNotAvailable = 17,          // Status of purchase inoperative (e.g. setting purchase restrictions in app)
    ToastIAPErrorPurchaseLimitExceeded = 18,        // Monthly purchase limit exceeded
};

// Network Error
static NSString *const ToastHttpErrorDomain = @"com.toast.http";

typedef NS_ENUM(NSUInteger, ToastHttpErrorCode) {
    ToastHttpErrorNetworkNotAvailable = 100,        // Network is unavailable
    ToastHttpErrorRequestFailed = 101,              // HTTP Status Code is not 200 or can not read request
    ToastHttpErrorRequestTimeout = 102,             // Timeout
    ToastHttpErrorRequestInvalid = 103,             // Request is invalid
    ToastHttpErrorURLInvalid = 104,                 // URL is invalid
    ToastHttpErrorResponseInvalid = 105,            // Response is invalid
    ToastHttpErrorAlreadyInprogress = 106,          // Request is already in progress
    ToastHttpErrorRequiresSecureConnection = 107,   // Do not set Allow Arbitrary Loads
};
```
