## NHN Cloud > SDK User Guide > Log & Crash > iOS

## Prerequisites

1. [Install NHN Cloud SDK](./getting-started-ios).
2. [Enable Log & Crash Search](https://docs.nhncloud.com/en/Data%20&%20Analytics/Log%20&%20Crash%20Search/en/console-guide/) in [NHN Cloud console](https://console.nhncloud.com).
3. [Check AppKey](https://docs.nhncloud.com/en/Data%20&%20Analytics/Log%20&%20Crash%20Search/en/console-guide/#appkey) in Log & Crash Search.

## Configuration of NHN Cloud Logger

* NHN Cloud Logger SDK for iOS is configured as follows.

| Service  | Cocoapods Pod Name | Framework | Dependency | Build Settings |
| --- | --- | --- | --- | --- |
| Log & Crash | NHNCloudLogger | NHNCloudLogger.framework | [External & Optional]<br/> * CrashReporter.framework (NHNCloud) |  |
| Mandatory   | NHNCloudCore<br/>NHNCloudCommon | NHNCloudCore.framework<br/>NHNCloudCommon.framework | | OTHER_LDFLAGS = (<br/>    "-ObjC",<br/>    "-lc++" <br/>); |

## Apply NHN Cloud SDK to Xcode Projects

### 1. Apply Cococapods

* Create a Podfile to add a pod for NHN Cloud SDK.

```podspec
platform :ios, '11.0'
use_frameworks!

target '{YOUR PROJECT TARGET NAME}' do
    pod 'NHNCloudLogger'
end
```

### 2. Apply NHN Cloud SDK with Swift Package Manager

* Go to **File > Add Packages...** from XCode.
* For the Package URL, enter 'https://github.com/nhn/nhncloud.ios.sdk' and select **Add Package**.
* Select NHNCloudLogger.

![swift_package_manager](https://static.toastoven.net/toastcloud/sdk/ios/swiftpackagemanager01.png)

#### Set up Project

* Add **-lc++** and **-ObjC** entries to **Other Linker Flags** in **Build Settings**
    * **Project Target > Build Settings > Linking > Other Linker Flags**
![other_linker_flags](https://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags_202206.png)

### 3. Apply NHN Cloud SDK by Downloading Binaries

#### Set up Framework

* The entire iOS SDK can be downloaded from [Downloads](../../../Download/#toast-sdk) of NHN Cloud.
* Add **NHNCloudLogger.framework**, **NHNCloudCore.framework**, **NHNCloudCommon.framework** to the Xcode Project.
* To enable Crash Report of NHN Cloud Logger, CrashReporter.framework which is distributed as well, must be added to the project.
![linked_frameworks_logger](https://static.toastoven.net/toastcloud/sdk/ios/logger_link_frameworks_logger_202206.png)

#### Set up Project

* Add **-lc++** and **-ObjC** to **Other Linker Flags** at **Build Settings**.
    * **Project Target > Build Settings > Linking > Other Linker Flags**
![other_linker_flags](https://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags_202206.png)

* To directly download or build **CrashReporter.framework**, the **Bitcode** at **Build Settings** must be changed to **NO**.
    * **Project Target > Build Settings > Build Options > Enable Bitcode**
![enable_bitcode](https://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags_202206.png)
> CrashReporter.framework downloaded from [Downloads](../../../Download/#toast-sdk) of NHN Cloud supports bitCode.

## Apply NHN Cloud Symbol Uploader

### Change Project Debug Settings
* You must change build settings to change the debug information format of the project.
* Xcode -> Project Target -> Build Settings -> Debug Information Format -> Debug -> DWARF with dSYM File

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

### Precautions when using CrashReport

* Crash analysis of devices using the arm64e architecture requires the use of PLCrashReporter, which is distributed with the NHN Cloud Logger.
    * Crash analysis of devices using the arm64e architecture is not possible if you use a PLCrashReporter that is downloaded or built directly from a location other than the [Downloads](../../../Download/#toast-sdk) of NHN Cloud.

## Initialize NHN Cloud Logger SDK

* Set Appkey issued from Log & Crash Search.

### Specification for Initialization API

``` objc
// Initialize
+ (void)initWithConfiguration:(NHNCloudLoggerConfiguration *)configuration;
```

### Example of Initialization Procedure

```objc
NHNCloudLoggerConfiguration *configuration = [NHNCloudLoggerConfiguration configurationWithAppKey:@"YOUR_APP_KEY"];
[NHNCloudLogger initWithConfiguration:configuration];
```

## Send Logs

* NHN Cloud Logger provides log-sending functions of five levels.

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

### Usage Example of Log Sending API

```objc
[NHNCloudLogger info:@"NHN Cloud Log & Crash Search!"];
```

## Set User-defined Fields

* Set a user-defined field as wanted.
* With user-defined field setting, set values are sent to server along with logs, every time Log Sending API is called.

### Specification for User-defined Field Setting API

```objc
// Add User-Defined Field
+ (void)setUserFieldWithValue:(NSString *)value forKey:(NSString *)key;
```

* User-defined field is same as the value exposed as "Selected Field"in "Log & Crash Search Console" > "Log Search Tab".

#### Restrictions for User-Defined Fields

* Cannot use already [Reserved Fields](./log-collector-reserved-fields).
* Use characters from "A-Z, a-z, 0-9, -, and _" for a field name, starting with "A-Z, or a-z".
* Replace spaces within a field name by "_".


### Usage Example of User-Defined Fields
```objc
// Add User-Defined Field
[NHNCloudLogger setUserFieldWithValue:@"USER_VALUE" forKey:@"USER_KEY"];
```

## Collect Crash Logs
* NHN Cloud Logger sends crash information to logs.
* It is enabled along with NHN Cloud Logger initialization, by setting.
* To send crash logs, PLCrashReporter is applied.

### Set Whether to Enable CrashReporter
* By default, CrashReporter is enabled when NHN Cloud Logger is initialized.
* During NHN Cloud Logger initialization, you can set whether to use CrashReporter or not.
* In order not to send crash logs, CrashReporter must be disabled.

> If the User ID is set, you can check the user-specific crash experience in the 'Crash User' section of the Log & Crash Search console.
> User ID setting can be checked in [Getting Started](./getting-started-ios/#set-userid).

#### Enable CrashReporter
```objc
// CrashReporter Enable Configuration
NHNCloudLoggerConfiguration *configuration = [NHNCloudLoggerConfiguration configurationWithAppKey:@"YOUR_APP_KEY" enableCrashReporter:YES];

[NHNCloudLogger initWithConfiguration:configuration];
```
#### Disable CrashReporter
```objc

// CrashReporter Disable Configuration
NHNCloudLoggerConfiguration *configuration = [NHNCloudLoggerConfiguration configurationWithAppKey:@"YOUR_APP_KEY" enableCrashReporter:NO];

[NHNCloudLogger initWithConfiguration:configuration];
```

## Set Additional Information in Time for Crash Occurrence before Sending

* Additional information can be set immediately after crash occurs.
* With user-defined field setting for Block at setShouldReportCrashHandler, additional information can be configured precisely when a crash occurs

### Specification for Data Adapter API
```objc
+ (void)setShouldReportCrashHandler:(void (^)(void))handler;
```

### Usage Example of Data Adapter

```objc
[NHNCloudLogger setShouldReportCrashHandler:^{

  //Send, via user-defined field, wanted information from crash occurrence
  // Add User-Defined Field
  [NHNCloudLogger setUserFieldWithValue:@"USER_VALUE" forKey:@"USER_KEY"];

}];
```

## Further Tasks after Sending Logs

* With delegate registered, further tasks can be executed after logs are sent.


### Specification for Set Delegate API
```objc
+ (void)setDelegate:(id<NHNCloudLoggerDelegate>) delegate;
```

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

## Network Insights
* Network Insights measure delay time and response values by calling URL registered in console. They may be applied to measure delays and response vales of many countries around the world (according to national codes on a device).

> With Network Insights enabled in console, it is requested for one time via URL registered in the console when NHN Cloud Logger is initialized.

### Enable Network Insights

1. Go to [NHN Cloud Console](https://console.nhncloud.com/) and select [Log & Crash Search].
2. Select [Settings].
3. Click the [Setting for Sending Logs] tab.
4. Enable "Network Insights Logs".

### URL Setting

1. Go to [NHN Cloud Console](https://console.nhncloud.com/) and select [Log & Crash Search].
2. Select [Network Insights].
3. Click the [URL Setting] tab.
4. Enter URL to measure and click [Add].

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

#### Example of initializing NHN Cloud Logger for government agencies

```objc
NHNCloudLoggerConfiguration *configuration = [NHNCloudLoggerConfiguration configurationWithAppKey:@"YOUR_APP_KEY"];
[configuration setCloudEnvironment:NHNCloudEnvironmentGovernment];

[NHNCloudLogger initWithConfiguration:configuration];
```

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

