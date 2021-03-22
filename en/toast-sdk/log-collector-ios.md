## TOAST > User Guide for TOAST SDK > TOAST Log & Crash > iOS

> [Notice]
> From TOAST SDK 0.13.0, it is possible to analyze and analyze crashes from devices using arm64e architecture (iPhone XS, XR, XS Max, iPad Pros 3rd).

## Prerequisites

1\. [Install TOAST SDK](./getting-started-ios).
2\. [Enable Log & Crash Search](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/) in [TOAST console](https://console.cloud.toast.com).
3\.[Check AppKey](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/#appkey) in Log & Crash Search. 

## Configuration of TOAST Logger

* TOAST Logger SDK for iOS is configured as follows.

| Service  | Cocoapods Pod Name | Framework | Dependency | Build Settings |
| --- | --- | --- | --- | --- |
| TOAST Log & Crash | ToastLogger | ToastLogger.framework | [External & Optional]<br/> * CrashReporter.framework (Toast) |  |
| Mandatory   | ToastCore<br/>ToastCommon | ToastCore.framework<br/>ToastCommon.framework | | OTHER_LDFLAGS = (<br/>    "-ObjC",<br/>    "-lc++" <br/>); |

## Apply TOAST SDK to Xcode Projects

### 1. Apply Cococapods 

* Create a podfile to add pods to TOAST SDK. 

```podspec
platform :ios, '9.0'
use_frameworks!

target '{YOUR PROJECT TARGET NAME}' do
    pod 'ToastLogger'
end
```

### 2. Apply TOAST SDK with Binary Downloads  

#### Link Frameworks

* The entire iOS SDK can be downloaded from [Downloads](../../../Download/#toast-sdk) of TOAST.  
* Add **ToastLogger.framework**, **ToastCore.framework**, **ToastCommon.framework** to the Xcode Project.
* To enable Crash Report of TOAST Logger, CrashReporter.framework which is distributed as well, must be added to the project. 
![linked_frameworks_logger](http://static.toastoven.net/toastcloud/sdk/ios/logger_link_frameworks_logger.png)

#### Project Settings

* Add **-lc++** and **-ObjC** to **Other Linker Flags** at **Build Settings**.
    * **Project Target > Build Settings > Linking > Other Linker Flags**
![other_linker_flags](http://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags.png)

* To directly download or build **CrashReporter.framework**, the **Bitcode** at **Build Settings** must be changed to **NO**.  
    * **Project Target > Build Settings > Build Options > Enable Bitcode**
![enable_bitcode](http://static.toastoven.net/toastcloud/sdk/ios/overview_settings_bitcode.png)
> CrashReporter.framework downloaded from [Downloads](../../../Download/#toast-sdk) of TOAST supports bitCode.

## TOAST Symbol Uploader 적용

### 프로젝트의 디버그 설정 변경
* 빌드 설정을 변경하여 프로젝트의 디버그 정보 형식을 변경해야합니다.
* Xcode -> Project Target -> Build Settings -> Debug Information Format -> Debug -> DWARF with dSYM File

### 개발 환경에서 Run Script를 사용하여 자동 업로드

* Xcode -> Project Target -> Build Phases -> + -> New Run Script Phase
* 표시되는 새 Run Script 섹션을 펼칩니다.
* Shell(셸) 필드 아래에 있는 스크립트 필드에서 새 실행 스크립트를 추가합니다.
```
if [ "${CONFIGURATION}" = "Debug" ]; then
    ${PODS_ROOT}/ToastSymbolUploader/toastcloud.sdk-*/run --app-key LOG_N_CRASH_SEARCH_DEV_APPKEY
fi
```
* LOG_N_CRASH_SEARCH_APPKEY에는 Log&Crash Search의 AppKey를 입력해야합니다.
* Run Script 섹션 하단의 Input Files에 dSYM의 기본 경로를 설정합니다.
    * ${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}/Contents/Resources/DWARF/${TARGET_NAME}

![symbol_uploader_script_pods_path](http://static.toastoven.net/toastcloud/sdk/ios/symbol_uploader_guide_script_pods_path.png)

### Symbol Uploader를 사용하여 직접 업로드

* SymbolUploader 사용법

```
USAGE: symbol-uploader -ak <ak> -pv <pv> [-sz <sz>] <path> [--verbose]

ARGUMENTS:
  <path>                  dSYM file path is must be entered. 

OPTIONS:
  -ak, --app-key <ak>     [Log&Crash Search]'s AppKey must be entered. 
  -pv, --project-version <pv>
                          Project version must be entered. 
  -sz, --service-zone <sz>
                          You can choose between real, alpha, and demo. (default: real)
  --verbose               Show more debugging information 
  -h, --help              Show help information.

```

* Xcode의 Run Script를 사용하지 않고 사용자가 원하는 시점에 아래와 같은 방법으로 SymbolUploader를 사용하여 직접 Symbol을 업로드 할 수 있습니다.

```
./SymbolUploader --app-key {APP_KEY} --project-version {CFBundleShortVersionString || MARKETING_VERSION} {symbol path(~/Project.dSYM)}
```

> `동일한 버전의 Symbol이 이미 업로드되어 있는 경우 SymbolUploader는 업로드되어 있는 Symbol을 제거하고 업로드를 수행합니다.`
> 이때 두 Symbol 파일의 `파일명이 다를 경우 업로드되어 있던 Symbol은 제거되지 않습니다.`
> Log & Crash Search 콘솔에서 업로드되어 있는 Symbol을 제거해야 합니다.
> https://console.toast.com/-> 조직 선택 -> 프로젝트 선택 -> Anaytics -> Log & Crash Search -> 설정 -> 심벌 파일

### Precautions when using CrashReport

* Crash analysis of devices using the arm64e architecture requires the use of PLCrashReporter, which is distributed with the TOAST Logger.
    * Crash analysis of devices using the arm64e architecture is not possible if you use a PLCrashReporter that is downloaded or built directly from a location other than the [Downloads](../../../Download/#toast-sdk) of TOAST.
    
## Initialize TOAST Logger SDK 

* Set appkey issued from Log & Crash Search. 

### Specifications for Initialization API

``` objc
// Initialize
+ (void)initWithConfiguration:(ToastLoggerConfiguration *)configuration;
```

### Example of Initialization Procedure

```objc
ToastLoggerConfiguration *configuration = [ToastLoggerConfiguration configurationWithAppKey:@"YOUR_APP_KEY"];
[ToastLogger initWithConfiguration:configuration];
```

## Send Logs 

* TOAST Logger provides log-sending functions of five levels. 

### Specifications for Log Sending API 

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
[ToastLogger info:@"TOAST Log & Crash Search!"];
```

## Set User-defined Fields 

* Set a user-defined field as wanted.  
* With user-defined field setting, set values are sent to server along with logs, every time Log Sending API is called. 

### Specifications for User-defined Field Setting API 

```objc
// Add User-Defined Field 
+ (void)setUserFieldWithValue:(NSString *)value forKey:(NSString *)key;
```
* User-defined field is same as the value exposed as "Selected Field"in "Log & Crash Search Console" > "Log Search Tab". 
* That is, it is same as custom parameter of Log & Crash Search, and you can find more details on restrictions of "field" value in [Restrictions of Custom Field](http://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/api-guide/).

#### Restrictions for User-Defined Fields

* Cannot use already [Reserved Fields](./log-collector-reserved-fields).  
  Check reserved fields at "Basic Parameters" from [Restrictions of User-Defined Fields](http://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/api-guide/).
* Use characters from "A-Z, a-z, 0-9, -, and _" for a field name, starting with "A-Z, or a-z". 
* Replace spaces within a field name by "_". 

### Usage Example of User-Defined Fields
```objc
// Add User-Defined Field
[ToastLogger setUserFieldWithValue:@"USER_VALUE" forKey:@"USER_KEY"];
```

## Collect Crash Logs
* TOAST Logger sends crash information to logs.
* It is enabled along with TOAST Logger initilization, by setting.  
* To send crash logs, PLCrashReporter is applied. 

### Set Enable CrashReporter 

* It is enabled by setting, along with TOAST Logger initialization. 
* In order not to send crash logs, CrashReporter must be disabled.  

> If the User ID is set, you can check the user-specific crash experience in the 'Crash User' section of the Log&Crash Search console.
> User ID setting can be checked in [Getting Started](./getting-started-ios/#set-userid).

#### Enable CrashReporter 
```objc
// CrashReporter Enable Configuration
ToastLoggerConfiguration *configuration = [ToastLoggerConfiguration configurationWithAppKey:@"YOUR_APP_KEY" 
                                                                        enableCrashReporter:YES];

[ToastLogger initWithConfiguration:configuration];
```
#### Disable CrashReporter 
```objc

// CrashReporter Disable Configuration
ToastLoggerConfiguration *configuration = [ToastLoggerConfiguration configurationWithAppKey:@"YOUR_APP_KEY" 
                                                                        enableCrashReporter:NO];

[ToastLogger initWithConfiguration:configuration];
```

## Set Additional Information in Time for Crash Occurrence before Sending

* Additional information can be set immediately after crash occurs. 
* With user-defined field setting for Block at setShouldReportCrashHandler, additional information can be configured precisely when a crash occurs

### Specifications for Data Adapter API 
```objc
+ (void)setShouldReportCrashHandler:(void (^)(void))handler;
```

### Usage Example of Data Adapter 

```objc
[ToastLogger setShouldReportCrashHandler:^{
  
  //Send, via user-defined field, wanted information from crash occurrence
  // Add User-Defined Field 
  [ToastLogger setUserFieldWithValue:@"USER_VALUE" forKey:@"USER_KEY"];

}];
```

## Further Tasks after Sending Logs

* With delegate registered, further tasks can be executed after logs are sent.

### Specifications for Set Delegate API

```objc
+ (void)setDelegate:(id<ToastLoggerDelegate>) delegate;
@end

### Specifications for Delegate API

@protocol ToastLoggerDelegate <NSObject>
@optional
// Sending logs succeeded
- (void)toastLogDidSuccess:(ToastLog *)log;

// Sending logs failed
- (void)toastLogDidFail:(ToastLog *)log error:(NSError *)error;

// Save within SDK for re-sending if log-sending fails due to network errors
- (void)toastLogDidSave:(ToastLog *)log;

// Filter by filter setting
- (void)toastLogDidFilter:(ToastLog *)log logFilter:(ToastLogFilter *)logFilter;
@end
```


### Usage Example of Delegate 

```objc
#import <ToastLogger/ToastLogger.h>

@interface AppDelegate () <UIApplicationDelegate, ToastLoggerDelegate>

@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // ...

    // Initialize
    ToastLoggerConfiguration *configuration = [ToastLoggerConfiguration configurationWithAppKey:@"YOUR_APP_KEY" 
                                                                            enableCrashReporter:YES];
    [ToastLogger initWithConfiguration:configuration];

    // Set Delegate
    [[ToastLogger setDelegate:self];

    return YES;
}

#pragma mark - ToastLoggerDelegate
// Sending logs succeeded
- (void)toastLogDidSuccess:(ToastLog *)log {
      // ...
 }

// Sending logs failed
- (void)toastLogDidFail:(ToastLog *)log error:(NSError *)error {
      // ...
}

// Save within SDK for re-sending if log-sending fails due to network erros
- (void)toastLogDidSave:(ToastLog *)log {
      // ...
}

// Filter by filter setting
- (void)toastLogDidFilter:(ToastLog *)log logFilter:(ToastLogFilter *)logFilter {
      // ...
}

@end
```

## Network Insights

* Network Insights measure delay time and response values by calling URL registered in console. They may be applied to measure delays and response vales of many countries around the world (according to national codes on a device). 

> With Network Insights enabled in console, it is requested for one time via URL registered in the console when TOAST Logger is initialized. 

### Enable Network Insights

1. Go to [TOAST Console](https://console.toast.com/) and select [Log & Crash Search].
2. Select [Settings].
3. Click the [Setting for Sending Logs] tab.
4. Enable "Network Insights Logs".

### URL Setting

1. Go to [TOAST Console](https://console.toast.com/) and select [Log & Crash Search].
2. Select [Network Insights].
3. Click the [URL Setting] tab.
4. Enter URL to measure and click [Add].

