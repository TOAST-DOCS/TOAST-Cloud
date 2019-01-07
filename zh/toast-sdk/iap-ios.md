## TOAST > User Guide for TOAST SDK > TOAST IAP > iOS

## Prerequisites

1. [Install TOAST SDK](./getting-started-ios).
2. [Enable Mobile Service \> IAP](https://docs.toast.com/ko/Mobile%20Service/IAP/ko/console-guide/) in [TOAST console](https://console.cloud.toast.com).
3.  [Check AppKey ](https://docs.toast.com/ko/Mobile%20Service/IAP/ko/console-guide/#appkey)in IAP.

## Configuration of TOAST IAP

TOAST Logger SDK for iOS is configured as follows.

| Service  | Cocoapods Pod Name | Framework | Dependency | Build Settings |
| --- | --- | --- | --- | --- | 
| TOAST IAP | ToastIAP | ToastIAP.framework | * StoreKit.framework<br/><br/>[Optional]<br/> * libsqlite3.tdb | |
| Mandatory   | ToastCore<br/>ToastCommon | ToastCore.framework<br/>ToastCommon.framework | | OTHER_LDFLAGS = (<br/>    "-ObjC",<br/>    "-lc++" <br/>); |

## Apply TOAST SDK to Xcode Projects

### Apply Cococapods 

Create a podfile to add pods to TOAST SDK. 

```podspec
platform :ios, '8.0'
use_frameworks!

target '{YOUR PROJECT TARGET NAME}' do
    pod 'ToastIAP'
end
```

Open a created workspace and import SDK to use. 

```objc
#import <ToastCore/ToastCore.h>
#import <ToastIAP/ToastIAP.h>
```


### Apply TOAST SDK with Binary Downloads  

#### Import SDK

The entire iOS SDK can be downloaded from [Downloads](../../../Download/#toast-sdk) of TOAST.  

Add **ToastIAP.framework**, **ToastCore.framework**, **ToastCommon.framework**, `StoreKit.framework` to the Xcode Project.

> StoreKit.framework can be added in the following way.

![linked_storekit_frameworks](http://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_StoreKit.png)

![linked_frameworks_iap](http://static.toastoven.net/toastcloud/sdk/ios/iap_link_frameworks_iap.png)

#### Project Settings

Add "-lc++" and "-ObjC" to "Other Linker Flags" at "Build Settings". 

* Project Target - Build Settings - Linking - Other Linker Flags

![other_linker_flags](http://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags.png)

#### Import Framework 

Import the framework to use. 

```objc
#import <ToastCore/ToastCore.h>
#import <ToastIAP/ToastIAP.h>
```

## Service Login 

* All TOAST SDK products (including IAP and Log & Crash) are based on a same user ID. 

### Login

`Without user ID set, purchase, query of activated products, or query of consumed details are not available. `

``` objc
// Set user ID after service login is completed
[ToastSDK setUserID:@"INPUT_USER_ID"];
```

### Logout

``` objc
// Set user ID as nil after service logout is completed
[ToastSDK setUserID:nil];
```

## Initialize TOAST IAP SDK 

Set appkey issued from TOAST IAP. 
Reprocessing for uncompleted purchases is executed along with initialization.  
Therefore, for flawless reprocessing, user ID must be set first before initialization. 
All purchase results, including reprocessing, are delivered through delegate, so it is recommended to set delegate before or along with initialization.   

``` objc
ToastIAPConfiguration *configuration = [[ToastIAPConfiguration alloc] initWithAppKey:@"INPUT_YOUR_APPKEY"];

[ToastIAP initWithConfiguration:configuration delegate:self];
```

### Specifications for Initialization API

``` objc
@interface ToastIAP : NSObject

// Initialize
+ (void)initWithConfiguration:(ToastIAPConfiguration *)configuration;

// Set Delegate 
+ (void)setDelegate:(nullable id<ToastInAppPurchaseDelegate>)delegate;

// Initialize and Set Delegate
+ (void)initWithConfiguration:(ToastIAPConfiguration *)configuration
                     delegate:(nullable id<ToastInAppPurchaseDelegate>)delegate;

// ...

@end
```

### Specifications for Delegate API

Register delegate to proceed follow-ups after purchase. 

``` objc
@protocol ToastInAppPurchaseDelegate <NSObject>

// Purchase Succeeded 
- (void)didReceivePurchaseResult:(ToastPurchaseResult *)purchase;

// Purchase Failed
- (void)didFailPurchaseProduct:(NSString *)productIdentifier withError:(NSError *)error;

@end
```

### Example of Initialization Procedure

``` objc
#import <UIKit/UIKit.h>
#import <ToastIAP/ToastIAP.h>

@interface ViewController () <ToastInAppPurchaseDelegate>

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Initialize and Set Delegate 
    ToastIAPConfiguration *configuration =[[ToastIAPConfiguration alloc] initWithAppKey:@"INPUT_YOUR_APPKEY"];

    [ToastIAP initWithConfiguration:configuration delegate:self];
}

// Purchase Succeeded 
- (void)didReceivePurchaseResult:(ToastPurchaseResult *)purchase {
    NSLog(@"Successfully purchased");
}

// Purchase Failed
- (void)didFailPurchaseProduct:(NSString *)productIdentifier withError:(NSError *)error {
    NSLog(@"Failed to purchase: %@", erorr);
}

@end
```

## Query Product List

Query the list of products which are set as USE IAP, among those registered in the console.  
Products that failed to obtain product information from store (Apple) are indicated as invalidProducts. 

### Specifications for Product List Query API

``` objc
@interface ToastIAP : NSObject

// ...

// Query Product List 
+ (void)requestProductsWithCompletionHandler:(nullable void (^)(ToastProductsResponse * _Nullable response, NSError * _Nullable error))completionHandler;

// ...

@end
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

`Do not support Upgrades, Downgrades, and Modification for auto-renewable subscription products.`
Only one product must be registered to one subscription group.

``` objc
// Failed to Obtain Product Types 
ToastProductTypeUnknown = 0

// Consumable Products 
ToastProductTypeConsumable = 1

// Auto-Renewable Subscription Products 
ToastProductTypeAutoRenewableSubscription = 2
```

## Purchase Products 

Purchase results are delivered through a delegate.  
If an app is closed during purchase, or purchase is suspended due to network error, such purchase is reprocessed during initialization of IAP SDK when the app is re-executed.  

### Request for Purchase with Product Objects 

Purchase is requested by using ToastProduct object of query result of product list. 

#### Specifications for Purchase with Product Objects API 

``` objc
@interface ToastIAP : NSObject

// ...

// Purchase Product 
+ (void)purchaseWithProduct:(ToastProduct *)product;

// ...

@end
```

#### Usage Example of Purchase with Product Objects API 

``` objc
@property (nonatomic) NSArray <ToastProduct *> *products;

// Query Product List 
[ToastIAP requestProductsWithCompletionHandler:^(ToastProductsResponse *response, NSError *error) {

    if (error == nil) {
        // Save purchasable product list 
        self.products = response.products;

    } else {
        NSLog(@"Failed to request products: %@", error);
    }
}

// Request for Purchase Product 
[ToastIAP purchaseWithProduct:self.products[0]];
```

### Purchase Requests using Product ID 

When product list is managed by each service, purchase can be requested only by product ID. 
For a product which cannot be purchased, an error will be delivered indicating purchase is unavailable through delegate. 

#### Specifications for Purchase with Product ID API 

``` objc
@interface ToastIAP (Additional)

// ...

// Purchase Product 
+ (void)purchaseWithProductIdentifier:(NSString *)productIdentifier;

// ...

@end
```

#### Usage Example of Purchase with Product ID API 

``` objc
// Request for Purchase Product 
[ToastIAP purchaseWithProductIdentifier:@"PRODUCT_IDENTIFIER"];
```

## Query Activated Purchase List 

Query activated list of purchases (products that are not expired but currently under subscription) for current user ID.  
Android subscription can also be queried for a same user ID.  

### Specifications for Activated Purchase List API 

``` objc
@interface ToastIAP : NSObject

// ...

// Query Activated Purchase List 
+ (void)requestActivePurchasesWithCompletionHandler:(nullable void (^)(NSArray<ToastPurchaseResult *> * _Nullable purchases, NSError * _Nullable error))completionHandler;

// ...

@end
```

### Usage Example of Activated Purchase List Query API 

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

Query the list of restorable purchases by current user ID.  

### Specifications for Restoring Purchase API 

``` objc
@interface ToastIAP : NSObject

// ...

// Restore Purchase 
+ (void)restoreWithCompletionHandler:(nullable void (^)(NSArray<ToastPurchaseResult *> * _Nullable purchases, NSError * _Nullable error))completionHandler;

// ...

@end
```

### Usage Example of Restoring Purchase API 

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

## Query Unconsumed Purchase List 

An consumable product must be processed as consumed after product is provided. List of unconsumed purchases is to be queried.  

### Specifications for Unconsumed Purchase Query API

``` objc
@interface ToastIAP : NSObject

// ...

// Query Unconsumed Purchases 
+ (void)requestConsumablePurchasesWithCompletionHandler:(nullable void (^)(NSArray<ToastPurchaseResult *> * _Nullable purchases, NSError * _Nullable error))completionHandler;

// ...

@end
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

Consumable products must be processed as consumed through REST API or Consume API of SDK, after products are provided.

### Specifications for Consumption API 

``` objc
@interface ToastIAP (Additional)

// ...

+ (void)consumeWithPurchaseResult:(ToastPurchaseResult *)result
                completionHandler:(nullable void (^)(NSError * _Nullable error))completionHandler;

// ...

@end
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

For auto-renewable subscription products, users must be provided with a subscription management page. 
> [Apple Guide](https://developer.apple.com/library/archive/documentation/NetworkingInternet/Conceptual/StoreKitGuide/Chapters/Subscriptions.html#//apple_ref/doc/uid/TP40008267-CH7-SW19)

Without configuring a separate UI, call URL as below to display subscription management page. 
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

To remain compatible with (old) IAP SDK, reprocessing is supported for incomplete purchases created by (old) IAP SDK.
>To enable compatibility with (old) IAP SDK, additionally link `sqlite3 Library(libsqlite3.tdb)`.  

![linked_sqlite3](http://static.toastoven.net/toastcloud/sdk/ios/iap_link_sqlite3.png)

### Specifications for Reprocessing Incomplete Purchase API 

``` objc
@interface ToastIAP (Additional)

// ...

+ (void)processesIncompletePurchasesWithCompletionHandler:(nullable void (^)(NSArray <ToastPurchaseResult *> * _Nullable results, NSError * _Nullable error))completionHandler;

// ...

@end
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

### Error Codes 
```objc
typedef NS_ENUM(NSUInteger, ToastIAPErrorCode) {
    ToastIAPErrorUnknown = 0,                       // Unknown 
    
    ToastIAPErrorNotInitialized = 1,                // Not Initialized 
    ToastIAPErrorStoreNotAvailable = 2,             // Store is unavailable 
    ToastIAPErrorProductNotAvailable = 3,           // Failed to obtain product information 
    ToastIAPErrorProductInvalid = 4,                // Inconsistency of IDs between original payment and current product   
    ToastIAPErrorAlreadyOwned = 5,                  // Product is already owned 
    ToastIAPErrorAlreadyInProgress = 6,             // Request is already processing 
    ToastIAPErrorUserInvalid = 7,                   // Inconsistency of IDs between current user and paid user  
    ToastIAPErrorPaymentInvalid = 8,                // Failed to obtain futher payment information (ApplicationUsername)
    ToastIAPErrorPaymentCancelled = 9,              // Store payment cancelled 
    ToastIAPErrorPaymentFailed = 10,                // Store payment failed
    ToastIAPErrorVerifyFailed = 11,                 // Receipt verification failed 
    ToastIAPErrorChangePurchaseStatusFailed = 12,   // Change of purchase status failed  
    ToastIAPErrorPurchaseStatusInvalid = 13,        // Unavailable to purchase 
    ToastIAPErrorExpired = 14,                      // Subscription expired 
    
    ToastIAPErrorNetworkNotAvailable = 100,         // Network is unavailable 
    ToastIAPErrorNetworkFailed = 101,               //HTTP Status Code is not 200 
    ToastIAPErrorTimeout = 102,                     // Timeout
    ToastIAPErrorParameterInvalid = 103,            // Error in request parameter
    ToastIAPErrorResponseInvalid = 104,             // Error in server respone 
};
```