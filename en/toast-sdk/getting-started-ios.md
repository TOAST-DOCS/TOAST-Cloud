## NHN Cloud > User Guide for NHN Cloud SDK > Getting Started > iOS

## Supporting Environment

* iOS 9.0 or higher
* The latest version of XCode (version 10 or higher)

## Configuration of NHN Cloud SDK

* NHN Cloud SDK for iOS is configured as follows: 
    * [NHN Cloud Logger](./log-collector-ios) SDK
    * [NHN Cloud In-app Purchase AppStore](./iap-ios) SDK
    * [NHN Cloud Push](./push-ios) SDK

* NHN Cloud SDK services can be selectively applied for your needs.

| Service | Cocoapods Pod Name | Carthage | Framework | Dependency | Build Settings |
| ------- | ------------------ | -------- | --------- | ---------- | -------------- |
| All | NHN CloudSDK | github nhn/toastcloud.sdk<br> | ToastCore.framework<br>ToastCommon.framework<br>ToastLogger.framework<br>ToastIAP.framework<br>ToastPush.framework |  |  |
| Mandatory | NHN CloudCore<br>NHN CloudCommon |  | ToastCore.framework<br>ToastCommon.framework |  | OTHER\_LDFLAGS = (<br>"-ObjC",<br>"-lc++"<br>); |
| NHN Cloud Log & Crash | NHN CloudLogger |  | ToastLogger.framework | [External & Optional]<br>\* CrashReporter.framework (Toast) |  |
| NHN Cloud IAP | NHN CloudIAP |  | ToastIAP.framework | \* StoreKit.framework<br><br>[Optional]<br>\* libsqlite3.tdb |  |
| NHN Cloud Push | NHN CloudPush |  | ToastPush.framework | \* UserNotifications.framework<br><br>[Optional]<br>\* PushKit.framework |  |

## Apply NHN Cloud SDK to Xcode Projects

### 1. Apply NHN Cloud SDK with Cococapods

* Create a podfile and add pods to NHN Cloud SDK.

```podspec
platform :ios, '9.0'
use_frameworks!

target '{YOUR PROJECT TARGET NAME}' do
    pod 'ToastSDK'
end
```

### 2. Apply NHN Cloud SDK with Carthage

* Cartfile을 생성하여 NHN Cloud SDK의 Release Github Repository를 추가합니다.
```
github "nhn/toastcloud.sdk"
```

* 생성된 Carthage/Build 폴더의 Framework를 Xcode 프로젝트에 추가합니다. 
![carthage_import_framework](http://static.toastoven.net/toastcloud/sdk/ios/carthage_setting_01.png)

* 프로젝트에 다음과 같이 프레임워크(framework)가 추가된 것을 확인합니다.
![import_carthage_frameworks_complete](http://static.toastoven.net/toastcloud/sdk/ios/carthage_setting_02.png)

* NHN Cloud SDK를 사용하기 위해 **프레임워크 설정**과 **프로젝트 설정**을 해야합니다.

> 서비스 중 원하는 기능을 선택하여 사용하기 위해서는 서비스별로 필요한 Framework만 선택하여 프로젝트에 추가해야 합니다.
> 서비스별로 필요한 Framework는 [NHN Cloud SDK의 구성](./getting-started-ios/#toast-sdk)에서 확인 할 수 있습니다. 

### 3. Apply NHN Cloud SDK with Binary Downloads

#### Link Frameworks

* The entire iOS SDK can be downloaded from [Downloads](../../../Download/#toast-sdk) of NHN Cloud.  
![import_frameworks](http://static.toastoven.net/toastcloud/sdk/ios/overview_import_frameworks_folder.png)

* To enable Crash Report of NHN Cloud Logger, CrashReporter.framework which is distributed as well, must be added to the project.
![import_external_framework](http://static.toastoven.net/toastcloud/sdk/ios/overview_import_external_folder.png)

* Check frameworks are added to the project, as below:  
![import_frameworks_complete](http://static.toastoven.net/toastcloud/sdk/ios/overview_import_complete_folder.png)

* To use NHN Cloud IAP, StoreKit.framework must be linked additionally.
![linked__storekit_frameworks](http://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_StoreKit.png)

* To use NHN Cloud Push, UserNotifications.framework must be linked addtionally.
![linked__usernotifications_frameworks](http://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_UserNotifications.png)


#### Project Settings

* Add **-lc++** and **-ObjC** to **Other Linker Flags** at **Build Settings**.
    * **Project Target > Build Settings > Linking > Other Linker Flags**
![other_linker_flags](http://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags.png)

* To directly download or build **CrashReporter.framework**, the **Bitcode** at **Build Settings** must be changed to **NO**.  
    * **Project Target > Build Settings > Build Options > Enable Bitcode**
![enable_bitcode](http://static.toastoven.net/toastcloud/sdk/ios/overview_settings_bitcode.png)
> CrashReporter.framework downloaded from [Downloads](../../../Download/#toast-sdk) of NHN Cloud supports bitCode.

### Import Framework

Import the framework to use.

```objc
#import <ToastCore/ToastCore.h>
#import <ToastLogger/ToastLogger.h>
#import <ToastIAP/ToastIAP.h>
#import <ToastPush/ToastPush.h>
```

## Set UserID

* User ID can be set for NHN CloudSDK and it is for common usage at each module of NHN Cloud SDK.
* Send such set user ID to a server, along with logs, whenever Log Sending API of NHN Cloud Logger is called.

### Specifications for UserID API

```objc
+ (void)setUserID:(NSString *)userID;
```

### Usage Example of UserID Setting

```objc
[ToastSDK setUserID:@"TOAST-USER"];
```
## Set Debug Mode

* To check logs within NHN Cloud SDK, the debug mode can be set.
* To inquire of NHN Cloud SDK, enable the debug mode for faster response.  

### Specifications for Debug Mode API


```objc
+ (void)setDebugMode:(BOOL)debugMode;
```

### Usage Example of Debug Mode Setting

```objc
[ToastSDK setDebugMode:YES];    // or NO
```

> (Caution) To release an app, the debug mode must be disabled.  

## Use NHN Cloud Service

* User Guide for [NHN Cloud Log & Crash](./log-collector-ios)
* User Guide for [NHN Cloud In-app Purchase](./iap-ios)
* User Guide for [NHN Cloud Push](./push-ios)
