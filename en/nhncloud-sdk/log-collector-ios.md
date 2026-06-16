<!-- pre-align:aligned sig=754cf2cb5d13 -->

## NHN Cloud > SDK User Guide > Log & Crash > iOS

<a id="prerequisites"></a>

## Prerequisites

1. [Install NHN Cloud SDK](./getting-started-ios).
2. [Enable Log & Crash Search](/Data%20&%20Analytics/Log%20&%20Crash%20Search/en/console-guide/) in [NHN Cloud console](https://console.nhncloud.com).
3. [Check AppKey](/Data%20&%20Analytics/Log%20&%20Crash%20Search/en/console-guide/#check-appkey) in Log & Crash Search.

<a id="configuration-of-nhn-cloud-logger"></a>

## Configuration of NHN Cloud Logger

* NHN Cloud Logger SDK for iOS is configured as follows.

| Service  | Cocoapods Pod Name | Framework | Dependency | Build Settings |
| --- | --- | --- | --- | --- |
| Log & Crash | NHNCloudLogger | NHNCloudLogger.framework | [External & Optional]<br/> * CrashReporter.framework (NHNCloud) |  |
| Mandatory   | NHNCloudCore<br/>NHNCloudCommon | NHNCloudCore.framework<br/>NHNCloudCommon.framework | | OTHER_LDFLAGS = (<br/>    "-ObjC",<br/>    "-lc++" <br/>); |

<a id="apply-nhn-cloud-sdk-to-xcode-projects"></a>

## Apply NHN Cloud SDK to Xcode Projects

<a id="apply-cococapods"></a>

### 1. Apply Cococapods

* Create a Podfile to add a pod for NHN Cloud SDK.

```podspec
platform :ios, '11.0'
use_frameworks!

target '{YOUR PROJECT TARGET NAME}' do
    pod 'NHNCloudLogger'
end
```

<a id="apply-nhn-cloud-sdk-with-swift-package-manager"></a>

### 2. Apply NHN Cloud SDK with Swift Package Manager

* Go to **File > Add Packages...** from XCode.
* For the Package URL, enter 'https://github.com/nhn/nhncloud.ios.sdk' and select **Add Package**.
* Select NHNCloudLogger.

![swift_package_manager](https://static.toastoven.net/toastcloud/sdk/ios/swiftpackagemanager01.png)

<a id="set-up-project"></a>

#### Set up Project

* Add **-lc++** and **-ObjC** entries to **Other Linker Flags** in **Build Settings**
    * **Project Target > Build Settings > Linking > Other Linker Flags**
![other_linker_flags](https://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags_202206.png)

<a id="apply-nhn-cloud-sdk-by-downloading-binaries"></a>

### 3. Apply NHN Cloud SDK by Downloading Binaries

<a id="set-up-framework"></a>

#### Set up Framework

* The entire iOS SDK can be downloaded from [Downloads](../../../Download/#toast-sdk) of NHN Cloud.
* Add **NHNCloudLogger.framework**, **NHNCloudCore.framework**, **NHNCloudCommon.framework** to the Xcode Project.
* To enable Crash Report of NHN Cloud Logger, CrashReporter.framework which is distributed as well, must be added to the project.
![linked_frameworks_logger](https://static.toastoven.net/toastcloud/sdk/ios/logger_link_frameworks_logger_202206.png)

<a id="set-up-project-2"></a>

#### Set up Project

* Add **-lc++** and **-ObjC** to **Other Linker Flags** at **Build Settings**.
    * **Project Target > Build Settings > Linking > Other Linker Flags**
![other_linker_flags](https://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags_202206.png)

* To directly download or build **CrashReporter.framework**, the **Bitcode** at **Build Settings** must be changed to **NO**.
    * **Project Target > Build Settings > Build Options > Enable Bitcode**
![enable_bitcode](https://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags_202206.png)
> CrashReporter.framework downloaded from [Downloads](../../../Download/#toast-sdk) of NHN Cloud supports bitCode.

<a id="apply-nhn-cloud-symbol-uploader"></a>

## Apply NHN Cloud Symbol Uploader

<a id="change-project-debug-settings"></a>

### Change Project Debug Settings
* You must change build settings to change the debug information format of the project.
* Xcode -> Project Target -> Build Settings -> Debug Information Format -> Debug -> DWARF with dSYM File

<a id="upload-automatically-using-run-script-in-development-environment"></a>

### Upload Automatically Using Run Script in Development Environment

* Xcode -> Project Target -> Build Phases -> + -> New Run Script Phase
* Expand the new Run Script section that shows up.
* In the script field below the Shell field, add a new run script.
```
if [ "${CONFIGURATION}" = "Debug" ]; then
    ${PODS_ROOT}/NHNCloudSymbolUploader/nhncloud.ios.sdk-*/run --app-key LOG_N_CRASH_SEARCH_DEV_APPKEY
fi
```
* In LOG_N_CRASH_SEARCH_APPKEY, enter AppKey of Log & Crash Search.
* On Input Files under the Run Script section, set the default path of dSYM.
    * ${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}/Contents/Resources/DWARF/${TARGET_NAME}

![symbol_uploader_script_pods_path](https://static.toastoven.net/toastcloud/sdk/ios/symbol_uploader_guide_script_pods_path_202206.png)

<a id="upload-manually-using-symbol-uploader"></a>

### Upload Manually Using Symbol Uploader

* SymbolUploader Usage

```
USAGE: symbol-uploader -ak <ak> -pv <pv> [-sz <sz>] <path> [--verbose]

ARGUMENTS:
  <path>                  dSYM file path is must be entered.

OPTIONS:
  -ak, --app-key <ak>     [Log & Crash Search]'s AppKey must be entered.
  -pv, --project-version <pv>
                          Project version must be entered.
  -sz, --service-zone <sz>
                          You can choose between real, alpha, and demo. (default: real)
  --verbose               Show more debugging information
  -h, --help              Show help information.

```

* Without using Xcode's Run Script, you can upload symbols manually using SymbolUploader in the following way at any time you want.

```
./SymbolUploader --app-key {APP_KEY} --project-version {CFBundleShortVersionString || MARKETING_VERSION} {symbol path(~/Project.dSYM)}
```

> `If a symbol with the same version has already been uploaded, SymbolUploader removes the uploaded symbol and performs uploading.`
> At this time, if the filenames of the two symbol files are different, the uploaded symbol will not be removed.
> You need to remove the uploaded symbol from the Log & Crash Search console.
> https://console.nhncloud.com/-> Select Organization -> Select Project -> Anaytics -> Log & Crash Search -> Settings -> Symbol Files

<a id="precautions-when-using-crashreport"></a>

### Precautions when using CrashReport

* Crash analysis of devices using the arm64e architecture requires the use of PLCrashReporter, which is distributed with the NHN Cloud Logger.
    * Crash analysis of devices using the arm64e architecture is not possible if you use a PLCrashReporter that is downloaded or built directly from a location other than the [Downloads](../../../Download/#toast-sdk) of NHN Cloud.

<a id="initialize-nhn-cloud-logger-sdk"></a>

## Initialize NHN Cloud Logger SDK

* Set Appkey issued from Log & Crash Search.

<a id="specification-for-initialization-api"></a>

### Specification for Initialization API

``` objc
// Initialize
+ (void)initWithConfiguration:(NHNCloudLoggerConfiguration *)configuration;
```

<a id="example-of-initialization-procedure"></a>

### Example of Initialization Procedure

```objc
NHNCloudLoggerConfiguration *configuration = [NHNCloudLoggerConfiguration configurationWithAppKey:@"YOUR_APP_KEY"];
[NHNCloudLogger initWithConfiguration:configuration];
```

<a id="send-logs"></a>

## Send Logs

* NHN Cloud Logger provides log-sending functions of five levels.

<a id="specification-for-log-sending-api"></a>

### Specification for Log Sending API

```objc
// DEBUG level log
+ (void)debug:(NSString *)message;

// INFO level log
+ (void)info:(NSString *)message;

// WARN level log
+ (void)warn:(NSString *)message;

// ERROR level log
+ (void)error:(NSString *)message;

// FATAL level log
+ (void)fatal:(NSString *)message;
```

<a id="usage-example-of-log-sending-api"></a>

### Usage Example of Log Sending API

```objc
[NHNCloudLogger info:@"NHN Cloud Log & Crash Search!"];
```

<a id="set-user-defined-fields"></a>

## Set User-defined Fields

* Set a user-defined field as wanted.
* With user-defined field setting, set values are sent to server along with logs, every time Log Sending API is called.

<a id="specification-for-user-defined-field-setting-api"></a>

### Specification for User-defined Field Setting API

```objc
// Add User-Defined Field
+ (void)setUserFieldWithValue:(NSString *)value forKey:(NSString *)key;
```

* User-defined field is same as the value exposed as "Selected Field"in "Log & Crash Search Console" > "Log Search Tab".

<a id="restrictions-for-user-defined-fields"></a>

#### Restrictions for User-Defined Fields

* Cannot use already [Reserved Fields](./log-collector-reserved-fields).
* Use characters from "A-Z, a-z, 0-9, -, and _" for a field name, starting with "A-Z, or a-z".
* Replace spaces within a field name by "_".


<a id="usage-example-of-user-defined-fields"></a>

### Usage Example of User-Defined Fields
```objc
// Add User-Defined Field
[NHNCloudLogger setUserFieldWithValue:@"USER_VALUE" forKey:@"USER_KEY"];
```

<a id="collect-crash-logs"></a>

## Collect Crash Logs
* NHN Cloud Logger sends crash information to logs.
* It is enabled along with NHN Cloud Logger initialization, by setting.
* To send crash logs, PLCrashReporter is applied.

<a id="set-whether-to-enable-crashreporter"></a>

### Set Whether to Enable CrashReporter
* By default, CrashReporter is enabled when NHN Cloud Logger is initialized.
* During NHN Cloud Logger initialization, you can set whether to use CrashReporter or not.
* In order not to send crash logs, CrashReporter must be disabled.

> If the User ID is set, you can check the user-specific crash experience in the 'Crash User' section of the Log & Crash Search console.
> User ID setting can be checked in [Getting Started](./getting-started-ios/#set-userid).

<a id="enable-crashreporter"></a>

#### Enable CrashReporter
```objc
// CrashReporter Enable Configuration
NHNCloudLoggerConfiguration *configuration = [NHNCloudLoggerConfiguration configurationWithAppKey:@"YOUR_APP_KEY" enableCrashReporter:YES];

[NHNCloudLogger initWithConfiguration:configuration];
```
<a id="disable-crashreporter"></a>

#### Disable CrashReporter
```objc

// CrashReporter Disable Configuration
NHNCloudLoggerConfiguration *configuration = [NHNCloudLoggerConfiguration configurationWithAppKey:@"YOUR_APP_KEY" enableCrashReporter:NO];

[NHNCloudLogger initWithConfiguration:configuration];
```

<a id="set-additional-information-in-time-for-crash-occurrence-before-sending"></a>

## Set Additional Information in Time for Crash Occurrence before Sending

* Additional information can be set immediately after crash occurs.
* With user-defined field setting for Block at setShouldReportCrashHandler, additional information can be configured precisely when a crash occurs

<a id="specification-for-data-adapter-api"></a>

### Specification for Data Adapter API
```objc
+ (void)setShouldReportCrashHandler:(void (^)(void))handler;
```

<a id="usage-example-of-data-adapter"></a>

### Usage Example of Data Adapter

```objc
[NHNCloudLogger setShouldReportCrashHandler:^{

  //Send, via user-defined field, wanted information from crash occurrence
  // Add User-Defined Field
  [NHNCloudLogger setUserFieldWithValue:@"USER_VALUE" forKey:@"USER_KEY"];

}];
```

<a id="further-tasks-after-sending-logs"></a>

## Further Tasks after Sending Logs

* With delegate registered, further tasks can be executed after logs are sent.


<a id="specification-for-set-delegate-api"></a>

### Specification for Set Delegate API
```objc
+ (void)setDelegate:(id<NHNCloudLoggerDelegate>) delegate;
```

<a id="specification-for-delegate-api"></a>

### Specification for Delegate API

``` objc
@protocol NHNCloudLoggerDelegate <NSObject>
@optional
// Sending logs succeeded
- (void)nhnCloudLogDidSuccess:(NHNCloudLog *)log;

// Sending logs failed
- (void)nhnCloudLogDidFail:(NHNCloudLog *)log error:(NSError *)error;

// Save within SDK for re-sending if log-sending fails due to network errors
- (void)nhnCloudLogDidSave:(NHNCloudLog *)log;

// Filter by filter setting
- (void)nhnCloudLogDidFilter:(NHNCloudLog *)log logFilter:(NHNCloudLogFilter *)logFilter;
@end
```


<a id="usage-example-of-delegate"></a>

### Usage Example of Delegate

```objc
#import <NHNCloudLogger/NHNCloudLogger.h>

@interface AppDelegate () <UIApplicationDelegate, NHNCloudLoggerLoggerDelegate>

@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // ...

    // Initialize
    NHNCloudLoggerConfiguration *configuration = [NHNCloudLoggerConfiguration configurationWithAppKey:@"YOUR_APP_KEY" enableCrashReporter:YES];
    [NHNCloudLogger initWithConfiguration:configuration];

    // Set Delegate
    [[NHNCloudLogger setDelegate:self];

    return YES;
}

#pragma mark - NHNCloudLoggerDelegate
// Sending logs succeeded
- (void)nhnCloudLogDidSuccess:(NHNCloudLog *)log {
      // ...
 }

// Sending logs failed
- (void)nhnCloudLogDidFail:(NHNCloudLog *)log error:(NSError *)error {
      // ...
}

// Save within SDK for re-sending if log-sending fails due to network errors
- (void)nhnCloudLogDidSave:(NHNCloudLog *)log {
      // ...
}

// Filter by filter setting
- (void)nhnCloudLogDidFilter:(NHNCloudLog *)log logFilter:(NHNCloudLogFilter *)logFilter {
      // ...
}

@end
```

<a id="network-insights"></a>

## Network Insights
* Network Insights measure delay time and response values by calling URL registered in console. They may be applied to measure delays and response vales of many countries around the world (according to national codes on a device).

> With Network Insights enabled in console, it is requested for one time via URL registered in the console when NHN Cloud Logger is initialized.

<a id="enable-network-insights"></a>

### Enable Network Insights

1. Go to [NHN Cloud Console](https://console.nhncloud.com/) and select [Log & Crash Search].
2. Select [Settings].
3. Click the [Setting for Sending Logs] tab.
4. Enable "Network Insights Logs".

<a id="url-setting"></a>

### URL Setting

1. Go to [NHN Cloud Console](https://console.nhncloud.com/) and select [Log & Crash Search].
2. Select [Network Insights].
3. Click the [URL Setting] tab.
4. Enter URL to measure and click [Add].

<a id="nhn-cloud-logger-for-government-agencies"></a>

## NHN Cloud Logger for Government Agencies

<!-- TODO: translate body -->

<a id="set-nhn-cloud-logger-for-government-agencies"></a>

### Set NHN Cloud Logger for government agencies 
* You can configure the settings to use the cloud for government agencies by using cloudEnvironment property of NHNCloudLoggerConfiguration. 

```objc
typedef NS_ENUM(NSInteger, NHNCloudEnvironment) {
    NHNCloudEnvironmentPublic = 0,
    NHNCloudEnvironmentGovernment = 1,
};

@property (nonatomic) NHNCloudEnvironment cloudEnvironment;
```
* When not set, the default is `NHNCloudEnvironmentPublic`. 

<a id="example-of-initializing-nhn-cloud-logger-for-government-agencies"></a>

#### Example of initializing NHN Cloud Logger for government agencies

```objc
NHNCloudLoggerConfiguration *configuration = [NHNCloudLoggerConfiguration configurationWithAppKey:@"YOUR_APP_KEY"];
[configuration setCloudEnvironment:NHNCloudEnvironmentGovernment];

[NHNCloudLogger initWithConfiguration:configuration];
```

<a id="precautions-when-using-nhn-cloud-logger-for-government-agencies"></a>

### Precautions when using NHN Cloud Logger for government agencies

* The following features are not supported for Log & Crash Search for government agencies.
    * Console Settings
        * When you set to use Console Settings, the default settings are applied.
            * Send all logs
            * Filter disabled
            * Session / Crash Log disabled
            * Network Insight disabled
    * CrashReporter 
    * Network Insight

