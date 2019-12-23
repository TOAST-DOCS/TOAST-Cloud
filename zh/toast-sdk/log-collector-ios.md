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
platform :ios, '8.0'
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

