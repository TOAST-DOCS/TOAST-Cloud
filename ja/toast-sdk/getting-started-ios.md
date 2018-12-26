## TOAST > User Guide for TOAST SDK > Getting Started > iOS

## Supporting Environment 

* iOS 8.0 or higher
* The latest version of XCode (version 9 or higher)

## Configuration of TOAST SDK

TOAST SDK for iOS is configured as follows: 

* [TOAST Logger](./log-collector-ios) SDK
* [TOAST In-app Purchase AppStore](./iap-ios) SDK

TOAST SDK services can be selectively applied for your needs. 

| Service  | Cocoapods Pod Name | Framework | Dependency | Build Settings |
| --- | --- | --- | --- | --- |
| All | ToastSDK | ToastCore.framework<br/>ToastCommon.framework<br/>ToastLogger.framework<br/>ToastIAP.framework |  |  |
| Mandatory   | ToastCore<br/>ToastCommon | ToastCore.framework<br/>ToastCommon.framework | | OTHER_LDFLAGS = (<br/>    "-ObjC",<br/>    "-lc++" <br/>); |
| TOAST Log & Crash | ToastLogger | ToastLogger.framework | [External & Optional]<br/> * CrashReporter.framework | ENABLE_BITCODE = NO; |
| TOAST IAP | ToastIAP | ToastIAP.framework | * StoreKit.framework<br/><br/>[Optional]<br/> * libsqlite3.tdb | |
| TOAST Push | ToastPush | ToastPush.framework | * UserNotifications.framework<br/><br/>[Optional]<br/> * PushKit.framework | |

## Apply TOAST SDK to Xcode Projects

### 1. Apply TOAST SDK with Cococapods

Create a podfile and add pods to TOAST SDK. 

```podspec
platform :ios, '8.0'
use_frameworks!

target '{YOUR PROJECT TARGET NAME}' do
    pod 'ToastSDK'
end
```

Open a created workspace and import SDK to use. 

```objc
#import <ToastCore/ToastCore.h>
#import <ToastLogger/ToastLogger.h>
#import <ToastIAP/ToastIAP.h>
#import <ToastPush/ToastPush.h>
```

### 2. Apply TOAST SDK with Binary Downloads 

#### Import SDK

The entire iOS SDK can be downloaded from [Downloads](../../../Download/#toast-sdk) of TOAST.  

![import_frameworks](http://static.toastoven.net/toastcloud/sdk/ios/overview_import_frameworks_folder.png)

To enable Crash Report of TOAST Logger, CrashReporter.framework which is distributed as well, must be added to the project. 

![import_external_framework](http://static.toastoven.net/toastcloud/sdk/ios/overview_import_external_folder.png)

Check frameworks are added to the project, as below:  

![import_frameworks_complete](http://static.toastoven.net/toastcloud/sdk/ios/overview_import_complete_folder.png)

> To use TOAST IAP, StoreKit.framework must be linked additionally. 

![linked__storekit_frameworks](http://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_StoreKit.png)

![linked_frameworks](http://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_noAdSupport_IAP.png)

> To use TOAST Push, UserNotifications.framework must be linked addtionally.

![linked__usernotifications_frameworks](http://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_UserNotifications.png)

> To user TOAST Push's VoIP, PushKit.framework must be linked addtionally.

![linked__pushkit_frameworks](http://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_PushKit.png)

![linked_frameworks](http://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_Push.png)


#### Project Settings

Add "-lc++" and "-ObjC" to "Other Linker Flags" at "Build Settings". 

* Project Target - Build Settings - Linking - Other Linker Flags

![other_linker_flags](http://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags.png)

To directly download or build CrashReporter.framework, the Bitcode at Build Setting must be changed to NO.  

* Project Target - Build Settings - Build Options - Enable Bitcode - "NO"

![enable_bitcode](http://static.toastoven.net/toastcloud/sdk/ios/overview_settings_bitcode.png)
> CrashReporter.framework downloaded from [Downloads](../../../Download/#toast-sdk) of TOAST supports bitCode. 

#### Import Framework 

Import the framework to use. 

```objc
#import <ToastCore/ToastCore.h>
#import <ToastLogger/ToastLogger.h>
#import <ToastIAP/ToastIAP.h>
#import <ToastPush/ToastPush.h>
```

## Set UserID 

User ID can be set for ToastSDK and it is for common usage at each module of TOAST SDK.
Send such set user ID to a server, along with logs, whenever Log Sending API of TOAST Logger is called. 

### Specifications for UserID API

```objc
@interface ToastSDK : NSObject

//...

+ (void)setUserID:(NSString *)userID;

//...

@end
```

### Usage Example of UserID Setting

```objc
[ToastSDK setUserID:@"TOAST-USER"];
```
## Set Debug Mode

To check logs within TOAST SDK, the debug mode can be set. 
To inquire of TOAST SDK, enable the debug mode for faster response.  

### Specifications for Debug Mode API 


```objc
@interface ToastSDK : NSObject

//...

+ (void)setDebugMode:(BOOL)debugMode;

//...

@end
```

### Usage Example of Debug Mode Setting 

```objc
// Set Debug Mode.
[ToastSDK setDebugMode:YES];// or NO
```

> (Caution) To release an app, the debug mode must be disabled.  

## Use TOAST Service 

* User Guide for [TOAST Log & Crash](./log-collector-ios) 
* User Guide for [TOAST In-app Purchase](./iap-ios) 
* User Guide for [TOAST Push](./push-ios)
