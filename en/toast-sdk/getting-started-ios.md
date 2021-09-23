## TOAST > TOAST SDK User Guide > Getting Started > iOS

## Supported Environment

* iOS 9.0 or higher
* The latest version of XCode (version 10 or higher)

## TOAST SDK Components

* TOAST SDK for iOS consists of the following:
    * [TOAST Logger](./log-collector-ios) SDK
    * [TOAST In-app Purchase AppStore](./iap-ios) SDK
    * [TOAST Push](./push-ios) SDK

* You can selectively apply the required feature among the services provided by TOAST SDK.

| Service | Cocoapods Pod Name | Carthage | Framework | Dependency | Build Settings |
| ------- | ------------------ | -------- | --------- | ---------- | -------------- |
| All | ToastSDK | binary "https://nh.nu/toast" | ToastCore.framework<br>ToastCommon.framework<br>ToastLogger.framework<br>ToastIAP.framework<br>ToastPush.framework |  |  |
| Mandatory | ToastCore<br>ToastCommon |  | ToastCore.framework<br>ToastCommon.framework |  | OTHER\_LDFLAGS = (<br>"-ObjC",<br>"-lc++"<br>); |
| TOAST Log & Crash | ToastLogger |  | ToastLogger.framework | [External & Optional]<br>\* CrashReporter.framework (Toast) |  |
| TOAST IAP | ToastIAP |  | ToastIAP.framework | \* StoreKit.framework<br><br>[Optional]<br>\* libsqlite3.tdb |  |
| TOAST Push | ToastPush |  | ToastPush.framework | \* UserNotifications.framework<br><br>[Optional]<br>\* PushKit.framework |  |

## Apply TOAST SDK to Xcode Projects

### 1. Apply TOAST SDK with Cococapods

* Create a Podfile and add a pod for TOAST SDK.

```podspec
platform :ios, '9.0'
use_frameworks!

target '{YOUR PROJECT TARGET NAME}' do
    pod 'ToastSDK'
end
```

### 2. Apply TOAST SDK with Carthage

* Create a Cartfile and add TOAST SDK.

```sh
# Full URL
binary "https://api-storage.cloud.toast.com/v1/AUTH_f9e3dc598ca142d3820e1c19343d5428/carthage/ToastSDK.json"

# Short URL
binary "https://nh.nu/toast"
```

* Add the frameworks in the created Carthage/Build folder to the Xcode project.
![carthage_import_framework](http://static.toastoven.net/toastcloud/sdk/ios/carthage01.png)

* Check that the frameworks have been added to the project as shown below.
![import_carthage_frameworks_complete](http://static.toastoven.net/toastcloud/sdk/ios/carthage02.png)
![import_carthage_frameworks_complete](http://static.toastoven.net/toastcloud/sdk/ios/carthage03.png)

* To use TOAST SDK, you must perform **Framework setting** and **Project setting**.

> To use desired features among the services selectively, you need to choose only the required frameworks per service and add them to the project.
> For details on required frameworks per service, see [TOAST SDK Components](./getting-started-ios/#toast-sdk).

### 3. Apply TOAST SDK by Downloading Binaries

#### Frameworks Setup

* The entire iOS SDK can be downloaded from the [Downloads](../../../Download/#toast-sdk) page of TOAST.
![import_frameworks](http://static.toastoven.net/toastcloud/sdk/ios/overview_import_frameworks_folder.png)

* To use the Crash Report feature of TOAST Logger, CrashReporter.framework which is released along with the service, must be added to the project.
![import_external_framework](http://static.toastoven.net/toastcloud/sdk/ios/overview_import_external_folder.png)

* Check that the frameworks have been added to the project as shown below.
![import_frameworks_complete](http://static.toastoven.net/toastcloud/sdk/ios/overview_import_complete_folder.png)

* To use the TOAST IAP feature, StoreKit.framework must be added.
![linked__storekit_frameworks](http://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_StoreKit.png)

* To use the TOAST Push feature, UserNotifications.framework must be added.
![linked__usernotifications_frameworks](http://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_UserNotifications.png)

##### xcframework
* Using xcframework allows you to use ToastSDK even in arm simulator.
![xcframework01](http://static.toastoven.net/toastcloud/sdk/ios/xcframework01.png)
![xcframework01](http://static.toastoven.net/toastcloud/sdk/ios/xcframework02.png)

#### Project Settings

* Add **-lc++** and **-ObjC** to **Other Linker Flags** under **Build Settings**.
    * **Project Target > Build Settings > Linking > Other Linker Flags**
![other_linker_flags](http://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags.png)

* If you directly downloaded or built **CrashReporter.framework**, the **Enable Bitcode** under **Build Settings** must be changed to **No**.
    * **Project Target > Build Settings > Build Options > Enable Bitcode**
![enable_bitcode](http://static.toastoven.net/toastcloud/sdk/ios/overview_settings_bitcode.png)
> CrashReporter.framework downloaded from the [Downloads](../../../Download/#toast-sdk) page of TOAST supports bitcode.

### Import Framework

* Import the frameworks to use.

```objc
#import <ToastCore/ToastCore.h>
#import <ToastLogger/ToastLogger.h>
#import <ToastIAP/ToastIAP.h>
#import <ToastPush/ToastPush.h>
```

## Set User ID

* User ID can be set for ToastSDK.
* The configured User ID is commonly used in each module of TOAST SDK.
* Whenever Log Sending API of Toast Logger is called, the configured User ID is sent to a server along with logs.

### Specification for User ID Setting API

```objc
+ (void)setUserID:(NSString *)userID;
```

### Usage Example of User ID Setting

```objc
[ToastSDK setUserID:@"TOAST-USER"];
```
## Set Debug Mode

* To check logs within TOAST SDK, the debug mode can be set.
* When you make an inquiry regarding TOAST SDK, sending the logs with the debug mode enabled can be helpful for faster response.

### Specification for Debug Mode API


```objc
+ (void)setDebugMode:(BOOL)debugMode;
```

### Usage Example of Debug Mode Setting

```objc
[ToastSDK setDebugMode:YES];    // or NO
```

> [Caution] The debug mode must be disabled before releasing an app.

## Use TOAST Service

* User Guide for [TOAST Log & Crash](./log-collector-ios)
* User Guide for [TOAST In-app Purchase](./iap-ios)
* User Guide for [TOAST Push](./push-ios)
