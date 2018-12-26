## TOAST > User Guide for TOAST SDK > TOAST Log & Crash > iOS

> [Notice]
> Crash logs from new devices using the arm64e architecture (iPhone XS, XR, XS Max, and iPad Pros 3rd) can only count the number of occurrences, and analysis of crash content is not yet supported.
> We will provide analysis capabilities for new devices in the near future.

## Prerequisites

1\. [Install TOAST SDK](./getting-started-ios).
2\. [Enable Log & Crash Search](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/) in [TOAST console](https://console.cloud.toast.com).
3\.[Check AppKey](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/#appkey) in Log & Crash Search. 

## Apply Cococapods 

Create a podfile to add pods to TOAST SDK. 

```podspec
platform :ios, '8.0'
use_frameworks!

target '{YOUR PROJECT TARGET NAME}' do
    pod 'ToastLogger'
end
```

Open a created workspace and import SDK to use. 

```objc
#import <ToastCore/ToastCore.h>
#import <ToastLogger/ToastLogger.h>
```

## Initialize TOAST Logger SDK 

Set appkey issued from Log & Crash Search as ProjectKey.

```objc
[ToastLogger initWithConfiguration:[ToastLoggerConfiguration configurationWithProjectKey:@"YOUR_PROJECT_KEY"]];
```

## Send Logs 

TOAST Logger provides log-sending functions of five levels. 

### Specifications for Log Sending API 

```objc
@interface ToastLogger : NSObject

//...

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

//...

@end
```

### Usage Example of Log Sending API 

```objc
[ToastLogger info:@"TOAST Log & Crash Search!"];
```

## Set User-defined Fields 

Set a user-defined field as wanted.  
With user-defined field setting, set values are sent to server along with logs, every time Log Sending API is called. 

### Specifications for User-defined Field Setting API 

```objc
@interface ToastLogger : NSObject

// ...
// Add a UserField 
+ (void)setUserFieldWithValue:(NSString *)value forKey:(NSString *)key;
// ...

@end
```

*  User-defined field is same as the value exposed as "Selected Field"in "Log & Crash Search Console" > "Log Search Tab". 
That is, it is same as custom parameter of Log & Crash Search, and you can find more details on restrictions of "field" value in [Restrictions of Custom Field](http://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/api-guide/).

#### Restrictions for User-Defined Fields

- Cannot use already [Reserved Fields](./log-collector-reserved-fields).  
  Check reserved fields at "Basic Parameters" from [Restrictions of User-Defined Fields](http://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/api-guide/).
- Use characters from "A-Z, a-z, 0-9, -, and _" for a field name, starting with "A-Z, or a-z". 
- Replace spaces within a field name by "_". 

### Usage Example of User-Defined Fields
```objc
// Add a UserField
[ToastLogger setUserFieldWithValue:@"USER_VALUE" forKey:@"USER_KEY"];
```

## Collect Crash Logs
TOAST Logger sends crash information to logs.
It is enabled along with ToastLogger initilization, by setting.  
To send crash logs, PLCrashReporter is applied. 

### Set Enable CrashReporter 
CrashReporter is enabled, on principle, along with initialization of TOASTLogger.  
```objc
[ToastLogger initWithConfiguration:[ToastLoggerConfiguration configurationWithProjectKey:@"YOUR_PROJECT_KEY"]];
```
It is enabled by setting, along with ToastLogger initialization. 
In order not to send crash logs, CrashReporter must be disabled.  

#### Enable CrashReporter 
```objc
// CrashReporter Enable Configuration
ToastLoggerConfiguration *configuration = [ToastLoggerConfiguration configurationWithProjectKey:@"YOUR_PROJECT_KEY" enableCrashReporter:YES];

[ToastLogger initWithConfiguration:configuration];
```
#### Disable CrashReporter 
```objc

// CrashReporter Disable Configuration
ToastLoggerConfiguration *configuration = [ToastLoggerConfiguration configurationWithProjectKey:@"YOUR_PROJECT_KEY" enableCrashReporter:NO];

[ToastLogger initWithConfiguration:configuration];
```

## Set Additional Information in Time for Crash Occurrence before Sending

Additional information can be set immediately after crash occurs. 
setUserField can be set anytime regardless of crash occurrence, whilesetCrashDataAdapter can be set at an accurate timing when a crash occurs.

### Specifications for Data Adapter API 
```objc
@interface ToastLogger : NSObject

//...

+ (void)setShouldReportCrashHandler:(void (^)(void))handler;

//...

@end
```

### Usage Example of Data Adapter 

```objc
[ToastLogger setShouldReportCrashHandler:^{
  
  //Send, via user-defined field, wanted information from crash occurrence
  // Add a UserField 
  [ToastLogger setUserFieldWithValue:@"USER_VALUE" forKey:@"USER_KEY"];

}];
```

## Further Tasks after Sending Logs

With delegate registered, further tasks can be executed after logs are sent.


### Specifications for Delegate API
```objc
@interface ToastLogger : NSObject

// ...

+ (void)setDelegate:(id<ToastLoggerDelegate>) delegate;

// ...
@end


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
// Delegate Setting
@interface YOURCLASSS : SUBCLASS <ToastLoggerDelegate>

// ...

[ToastLogger setDelegate:self];

// ...

- (void)toastLogDidSuccess:(ToastLog *)log {
      // Sending logs succeeded
 }

- (void)toastLogDidFail:(ToastLog *)log error:(NSError *)error {
      // Sending logs failed
}
- (void)toastLogDidSave:(ToastLog *)log {
      // Save within SDK for re-sending if log-sending fails due to network erros
}

- (void)toastLogDidFilter:(ToastLog *)log logFilter:(ToastLogFilter *)logFilter {
      // Filter by filter setting
}

@end
```

## Network Insights

Network Insights measure delay time and response values by calling URL registered in console. They may be applied to measure delays and response vales of many countries around the world (according to national codes on a device). 

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

