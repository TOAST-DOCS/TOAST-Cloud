<!-- pre-align:aligned sig=d8ddfaa7a83d -->

## NHN Cloud > SDK User Guide > Getting Started > iOS

<a id="supported-environment"></a>

## Supported Environment

* iOS 11.0 or higher
* The latest version of XCode (version 14 or higher)

<a id="nhn-cloud-sdk-components"></a>

## NHN Cloud SDK Components

* NHN Cloud SDK for iOS consists of the following:
    * [Logger](./log-collector-ios) SDK
    * [In-app Purchase AppStore](./iap-ios) SDK
    * [Push](./push-ios) SDK
     [OCR](./creditcard-recognizer-ios) SDK

* You can selectively apply the required feature among the services provided by NHN Cloud SDK.

| Service | Cocoapods Pod Name | Carthage | Framework | Deployment Target | Dependency | Build Settings |
| --- | --- | --- | --- | --- | --- | --- |
| All | NHNCloudSDK | binary "[https://nh.nu/nhncloudsdk](https://nh.nu/nhncloudsdk) | NHNCloudCore.framework<br>NHNCloudCommon.framework<br>NHNCloudLogger.framework<br>NHNCloudIAP.framework<br>NHNCloudPush.framework |  |  |  |
| Mandatory | NHNCloudCore<br>NHNCloudCommon |  | NHNCloudCore.framework<br>NHNCloudCommon.framework | 11.0 |  | OTHER\_LDFLAGS = (<br>"-ObjC",<br>"-lc++"<br>); |
| Log & Crash | NHNCloudLogger |  | NHNCloudLogger.framework | 11.0 | [External & Optional]<br>\* CrashReporter.framework (NHNCloud) |  |
| IAP | NHNCloudIAP |  | NHNCloudIAP.framework | 11.0 | \* StoreKit.framework<br><br>[Optional]<br>\* libsqlite3.tdb |  |
| Push | NHNCloudPush |  | NHNCloudPush.framework | 11.0 | \* UserNotifications.framework<br><br>[Optional]<br>\* PushKit.framework |  |
| OCR | NHNCloudOCR |  | NHNCloudOCR.framework | 11.0 | \* Vision.framework<br>\* AVFoundation.framework |  |

<a id="apply-nhn-cloud-sdk-to-xcode-projects"></a>

## Apply NHN Cloud SDK to Xcode Projects

<a id="apply-nhn-cloud-sdk-with-cococapods"></a>

### 1. Apply NHN Cloud SDK with Cococapods

* Create a Podfile and add a pod for NHN Cloud SDK.

```podspec
platform :ios, '11.0'
use_frameworks!

target '{YOUR PROJECT TARGET NAME}' do
    pod 'NHNCloudSDK'
end
```

<a id="apply-nhn-cloud-sdk-with-swift-package-manager"></a>

### 2. Apply NHN Cloud SDK with Swift Package Manager

* Go to **File > Add Packages...** from XCode.
* For the Package URL, enter 'https://github.com/nhn/nhncloud.ios.sdk' and select **Add Package**.
* Select a library you want to add.

![swift_package_manager](https://static.toastoven.net/toastcloud/sdk/ios/swiftpackagemanager01.png)

<a id="set-up-project"></a>

#### Set up Project

* Add **-lc++** and **-ObjC** entries to **Other Linker Flags** in **Build Settings**.
    * **Project Target > Build Settings > Linking > Other Linker Flags**
![other_linker_flags](https://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags_202206.png)

<a id="apply-nhn-cloud-sdk-with-carthage"></a>

### 3. Apply NHN Cloud SDK with Carthage

* Create a Cartfile and add NHN Cloud SDK.

```sh
# Full URL
binary "https://api-storage.cloud.toast.com/v1/AUTH_f9e3dc598ca142d3820e1c19343d5428/carthage/NHNCloudSDK.json"

# Short URL
binary "https://nh.nu/nhncloudsdk"
```

* Add the frameworks in the created Carthage/Build folder to the Xcode project.
![carthage_import_framework](https://static.toastoven.net/toastcloud/sdk/ios/carthage01_202206.png)

* Check that the frameworks have been added to the project as shown below.
![import_carthage_frameworks_complete](https://static.toastoven.net/toastcloud/sdk/ios/carthage02_202206.png)
![import_carthage_frameworks_complete](https://static.toastoven.net/toastcloud/sdk/ios/carthage03_202206.png)

* To use NHN Cloud SDK, you must perform **Framework setting** and **Project setting**.

> To use desired features among the services selectively, you need to choose only the required frameworks per service and add them to the project.
> For details on required frameworks per service, see [NHN Cloud SDK Components](./getting-started-ios/#toast-sdk).

<a id="apply-nhn-cloud-sdk-by-downloading-binaries"></a>

### 4. Apply NHN Cloud SDK by Downloading Binaries

<a id="frameworks-setup"></a>

#### Frameworks Setup

* The entire iOS SDK can be downloaded from the [Downloads](../../../Download/#toast-sdk) page of NHN Cloud.
![import_frameworks](https://static.toastoven.net/toastcloud/sdk/ios/overview_import_frameworks_folder_202206.png)

* To use the Crash Report feature of Logger, CrashReporter.framework which is released along with the service, must be added to the project.
![import_external_framework](https://static.toastoven.net/toastcloud/sdk/ios/overview_import_external_folder_202206.png)

* Check that the frameworks have been added to the project as shown below.
![import_frameworks_complete](https://static.toastoven.net/toastcloud/sdk/ios/overview_import_complete_folder_202206.png)

* To use the IAP feature, StoreKit.framework must be added.
![linked__storekit_frameworks](https://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_StoreKit_202206.png)

* To use the Push feature, UserNotifications.framework must be added.
![linked__usernotifications_frameworks](https://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_UserNotifications_202206.png)

##### xcframework
* Using xcframework allows you to use NHN Cloud SDK even in arm simulator.
![xcframework01](https://static.toastoven.net/toastcloud/sdk/ios/xcframework01_202206.png)
![xcframework01](https://static.toastoven.net/toastcloud/sdk/ios/xcframework02_202206.png)

<a id="project-settings"></a>

#### Project Settings

* Add **-lc++** and **-ObjC** to **Other Linker Flags** under **Build Settings**.
    * **Project Target > Build Settings > Linking > Other Linker Flags**
![other_linker_flags](https://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags_202206.png)

* If you directly downloaded or built **CrashReporter.framework**, the **Enable Bitcode** under **Build Settings** must be changed to **No**.
    * **Project Target > Build Settings > Build Options > Enable Bitcode**
![enable_bitcode](https://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags_202206.png)
> CrashReporter.framework downloaded from the [Downloads](../../../Download/#toast-sdk) page of NHN Cloud supports bitcode.

<a id="import-framework"></a>

### Import Framework

* Import the frameworks to use.

```objc
#import <NHNCloudCore/NHNCloudCore.h>
#import <NHNCloudLogger/NHNCloudLogger.h>
#import <NHNCloudIAP/NHNCloudIAP.h>
#import <NHNCloudPush/NHNCloudPush.h>
#import <NHNCloudOCR/NHNCloudOCR.h>
```

<a id="set-user-id"></a>

## Set User ID

* User ID can be set for NHN Cloud SDK.
* The configured User ID is commonly used in each module of NHN Cloud SDK.
* Whenever Log Sending API of NHN Cloud Logger is called, the configured User ID is sent to a server along with logs.

<a id="specification-for-user-id-setting-api"></a>

### Specification for User ID Setting API

```objc
+ (void)setUserID:(NSString *)userID;
```

<a id="usage-example-of-user-id-setting"></a>

### Usage Example of User ID Setting

```objc
[NHNCloudSDK setUserID:@"NHNCLOUD-USER"];
```
<a id="set-debug-mode"></a>

## Set Debug Mode

* To check logs within NHN Cloud SDK, the debug mode can be set.
* When you make an inquiry regarding NHN Cloud SDK, sending the logs with the debug mode enabled can be helpful for faster response.

<a id="specification-for-debug-mode-api"></a>

### Specification for Debug Mode API


```objc
+ (void)setDebugMode:(BOOL)debugMode;
```

<a id="usage-example-of-debug-mode-setting"></a>

### Usage Example of Debug Mode Setting

```objc
[NHNCloudSDK setDebugMode:YES];    // or NO
```

> [Caution] The debug mode must be disabled before releasing an app.

<a id="use-nhn-cloud-service"></a>

## Use NHN Cloud Service

* User Guide for [Log & Crash](./log-collector-ios)
* User Guide for [In-app Purchase](./iap-ios)
* User Guide for [Push](./push-ios)
* User Guide for [OCR](./creditcard-recognizer-ios)
