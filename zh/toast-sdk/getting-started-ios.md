## TOAST > User Guide for TOAST SDK > Getting Started > iOS

## Supporting Environment

* iOS 8.0 or higher
* The latest version of XCode (version 10 or higher)

## Configuration of TOAST SDK

* TOAST SDK for iOS is configured as follows: 
    * [TOAST Logger](./log-collector-ios) SDK
    * [TOAST In-app Purchase AppStore](./iap-ios) SDK
    * [TOAST Push](./push-ios) SDK

* TOAST SDK services can be selectively applied for your needs.

| Service | Cocoapods Pod Name | Carthage | Framework | Dependency | Build Settings |
| ------- | ------------------ | -------- | --------- | ---------- | -------------- |
| All | ToastSDK | git nhn/toastcloud.sdk<br> | ToastCore.framework<br>ToastCommon.framework<br>ToastLogger.framework<br>ToastIAP.framework<br>ToastPush.framework |  |  |
| Mandatory | ToastCore<br>ToastCommon |  | ToastCore.framework<br>ToastCommon.framework |  | OTHER\_LDFLAGS = (<br>"-ObjC",<br>"-lc++"<br>); |
| TOAST Log & Crash | ToastLogger |  | ToastLogger.framework | [External & Optional]<br>\* CrashReporter.framework (Toast) |  |
| TOAST IAP | ToastIAP |  | ToastIAP.framework | \* StoreKit.framework<br><br>[Optional]<br>\* libsqlite3.tdb |  |
| TOAST Push | ToastPush |  | ToastPush.framework | \* UserNotifications.framework<br><br>[Optional]<br>\* PushKit.framework |  |

## Apply TOAST SDK to Xcode Projects

### 1. Apply TOAST SDK with Cococapods

* Create a podfile and add pods to TOAST SDK.

```podspec
platform :ios, '8.0'
use_frameworks!

target '{YOUR PROJECT TARGET NAME}' do
    pod 'ToastSDK'
end
```

### 2. Apply TOAST SDK with Carthage

* Cartfile을 생성하여 TOAST SDK의 Release Github Repository를 추가합니다.
```
github "nhn/toastcloud.sdk"
```

* 생성된 Carthage/Build 폴더의 Framework를 Xcode 프로젝트에 추가합니다. 
![carthage_import_framework](http://static.toastoven.net/toastcloud/sdk/ios/carthage_setting_01.png)

* 프로젝트에 다음과 같이 프레임워크(framework)가 추가된 것을 확인합니다.
![import_carthage_frameworks_complete](http://static.toastoven.net/toastcloud/sdk/ios/carthage_setting_02.png)

* TOAST SDK를 사용하기 위해 [프레임워크 설정](./getting-started-ios/#Link-Frameworks)과 [Project Setting](./getting-started-ios/#Project-Settings)을 추가합니다.

> 서비스 중 원하는 기능을 선택하여 사용하기 위해서는 서비스별로 필요한 Framework만 선택하여 프로젝트에 추가해야 합니다.
> 서비스별로 필요한 Framework는 [TOAST SDK의 구성](./getting-started-ios/#Configuration-of-TOAST-SDK)에서 확인 할 수 있습니다. 

### 3. Apply TOAST SDK with Binary Downloads

#### Link Frameworks

* The entire iOS SDK can be downloaded from [Downloads](../../../Download/#toast-sdk) of TOAST.  
![import_frameworks](http://static.toastoven.net/toastcloud/sdk/ios/overview_import_frameworks_folder.png)

* To enable Crash Report of TOAST Logger, CrashReporter.framework which is distributed as well, must be added to the project.
![import_external_framework](http://static.toastoven.net/toastcloud/sdk/ios/overview_import_external_folder.png)

* Check frameworks are added to the project, as below:  
![import_frameworks_complete](http://static.toastoven.net/toastcloud/sdk/ios/overview_import_complete_folder.png)

* To use TOAST IAP, StoreKit.framework must be linked additionally.
![linked__storekit_frameworks](http://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_StoreKit.png)

* To use TOAST Push, UserNotifications.framework must be linked addtionally.
![linked__usernotifications_frameworks](http://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_UserNotifications.png)


#### Project Settings

* Add **-lc++** and **-ObjC** to **Other Linker Flags** at **Build Settings**.
    * **Project Target > Build Settings > Linking > Other Linker Flags**
![other_linker_flags](http://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags.png)

* To directly download or build **CrashReporter.framework**, the **Bitcode** at **Build Settings** must be changed to **NO**.  
    * **Project Target > Build Settings > Build Options > Enable Bitcode**
![enable_bitcode](http://static.toastoven.net/toastcloud/sdk/ios/overview_settings_bitcode.png)
> CrashReporter.framework downloaded from [Downloads](../../../Download/#toast-sdk) of TOAST supports bitCode.

### Import Framework

Import the framework to use.

```objc
#import <ToastCore/ToastCore.h>
#import <ToastLogger/ToastLogger.h>
#import <ToastIAP/ToastIAP.h>
#import <ToastPush/ToastPush.h>
```

## Set UserID

* User ID can be set for ToastSDK and it is for common usage at each module of TOAST SDK.
* Send such set user ID to a server, along with logs, whenever Log Sending API of TOAST Logger is called.

### Specifications for UserID API

```objc
+ (void)setUserID:(NSString *)userID;
```

### Usage Example of UserID Setting

```objc
[ToastSDK setUserID:@"TOAST-USER"];
```
## Set Debug Mode

* To check logs within TOAST SDK, the debug mode can be set.
* To inquire of TOAST SDK, enable the debug mode for faster response.  

### Specifications for Debug Mode API


```objc
+ (void)setDebugMode:(BOOL)debugMode;
```

### Usage Example of Debug Mode Setting

```objc
[ToastSDK setDebugMode:YES];    // or NO
```

> (Caution) To release an app, the debug mode must be disabled.  

## Use TOAST Service

* User Guide for [TOAST Log & Crash](./log-collector-ios)
* User Guide for [TOAST In-app Purchase](./iap-ios)
* User Guide for [TOAST Push](./push-ios)
