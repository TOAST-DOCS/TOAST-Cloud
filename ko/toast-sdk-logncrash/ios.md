## Analytics > Log & Crash Search > TOAST SDK 사용 가이드 > Android

## Prerequisites

1\. [TOAST 콘솔](https://console.cloud.toast.com)에서 [Log&Crash Search를 활성화](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/)합니다.

2\. Log & Crash Search에서 [AppKey를 확인](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/#appkey)합니다.

## Component SDKs

Android용 TOAST SDK는 다음과 같은 SDK로 구성되어 있습니다.

* [TOAST Logger](#log-collector) SDK
* [TOAST Crash](#crash-reporter) SDK

전체 TOAST SDK 기능이 필요하지 않은 경우 앱에 필요한 SDK만 사용할 수 있습니다.

| Framework | Service |
| --- | --- |
| ToastLogger | Log Collection |
| ToastCrash | Crash Reporter |

## Getting Started iOS SDK

### Environments

* iOS 8.0 이상
* XCode 최신 버전 (버전 9 이상)

### Add TOAST SDK to Your Project

프로젝트에 TOAST SDK를 사용하려는 경우 몇 가지 기본적인 작업을 수행하여 XCode 프로젝트를 준비해야 합니다.

#### CococaPods

```podspec
platform :ios, '8.0'
use_frameworks!

target '{YOUR PROJECT TARGET NAME}' do
    pod 'ToastSDK'
end
```

생성된 Workspace를 열어 사용자고자하는 SDK를 Import 합니다.

```objc
#import <ToastCore/ToastCore.h>
#import <ToastCommon/ToastCommon.h>
#import <ToastLogger/ToastLogger.h>
#import <ToastCrash/ToastCrash.h>
```

#### Manual Import

##### SDK import

다운로드 받은 framework 들을 프로젝트에 추가 합니다.

![import_frameworks](http://static.toastoven.net/toastcloud/sdk/ios/overview_import_frameworks.png)

ToastCrash를 사용하기 위해서는 함께 배포되는 PLCrashReporter도 프로젝트에 함께 추가해야합니다.

![import_external_framework](http://static.toastoven.net/toastcloud/sdk/ios/overview_import_external.png)

프로젝트에 다음과 같이 Framework 들이 추가 된 것을 확인합니다.

![import_frameworks_complete](http://static.toastoven.net/toastcloud/sdk/ios/overview_import_complete.png)

ToastSDK를 사용하기 위해서는 프로젝트에 아래와 같이 Framework와 Library가 추가되어야 합니다.

![link_frameworks](http://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks.png)

##### Project Settings

C++을 사용하여 개발된 Logger를 위해 다음과 같이 Other Linker Flags 에 "-lc++" 항목을 추가해야합니다.
SDK에 속한 모든 Objective-C Class 로드를 위해 "-ObjC" 항목을 추가해야합니다.

* Project Target - Build Settings - Linking - Other Linker Flags

![other_linker_flags](http://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags.png)

함께 배포되는 PLCRashreporter가 아닌 직접 받거나 빌드한 PLCrashReport를 사용할 경우에는 Build Setting의 Enable Bitcode의 값을 NO로 변경해야 합니다.

* Project Target - Build Settings - Build Options - Enable Bitcode - "NO"

![enable_bitcode](http://static.toastoven.net/toastcloud/sdk/ios/overview_settings_bitcode.png)


##### import framework 

사용하고자 하는 Framework를 import 한 뒤 사용합니다.

```objc
#import <ToastCore/ToastCore.h>
#import <ToastCommon/ToastCommon.h>
#import <ToastLogger/ToastLogger.h>
#import <ToastCrash/ToastCrash.h>
```

### Intiailize TOAST SDK

TOAST SDK의 다양한 상품을 사용하기 위해서는 Application#onCreate에 TOAST SDK를 초기화해야 합니다.

```java
public class YourApplication extends Application {
    @Override
    public void onCreate() {
        super.onCreate();
        // ...

        // Initialize TOAST SDK
        ToastSdk.initialize(getApplicationContext());
    }
}
```

## Log Collector

### Initialize

Log & Crash Search에서 발급받은 AppKey를 ProjectKey로 설정합니다.

```objc
TCISLoggerConfiguration *configuration = [TCISLoggerConfiguration configurationWithProjectKey:@"YOUR_PROJECT_KEY"
                                                                               projectVersion:@"YOUR_PROJECT_VERSION"];

[TCISLogger loggerConfiguration:configuration];
```

### Send Log

TOAST Logger는 5가지 레벨의 로그 전송 함수를 제공합니다.

```objc
// DEBUG Level log
[TCISLogger debugWithLogTag:@"tag" message:@"message"];

// INFO Level log
[TCISLogger infoWithLogTag:@"tag" message:@"message"];

// WARN Level log
[TCISLogger warnWithLogTag:@"tag" message:@"message"];

// ERROR Level log
[TCISLogger errorWithLogTag:@"tag" message:@"message"];

// FATAL Level log
[TCISLogger fatalWithLogTag:@"tag" message:@"message"];
```

### Set UserID

사용자 아이디를 설정합니다.
설정된 사용자 아이디는 "UserID" 필드로 Log & Crash Search에서 조회할 수 있습니다.

```objc
[TCISLogger setUserID:@"USER_ID"];
```

### Set User Field

사용자가 원하는 필드를 설정합니다.

```objc
// 단일 UserField 추가
[TCISLogger addUserLogFieldWithValue:@"USER_VALUE" forKey:@"USER_KEY"];

// 다수의 UserField 추가
NSMutableDictionary<NSString*, NSString*> *userField = [[NSMutableDictionary alloc] init];
[userField setObject:@"USER_VALUE_1" forKey:@"USER_KEY_1"];
[userField setObject:@"USER_VALUE_2" forKey:@"USER\_KEY_2"];

[TCISLogger addUserLogField:userField];
```

> 이미 예약된 필드는 사용할 수 없습니다.
> KEY 문자열 내에 공백은 "\_"로 치환됩니다.
> 공백 문자열과 "\_" 는 KEY 문자열의 처음에 올 수 없습니다.

### Log Callback

로그를 전송 후 전송 결과를 Callback을 통해 확인할 수 있습니다.

```objc
// Delegate Setting
@interface YOURCLASSS : SUBCLASS <TCISLoggerDelegate>

// ...
[TCISLogger setDelegate:self];
// ...

@protocol TCISLoggerDelegate <NSObject>

@optional

// 로그 전송 성공
- (void)instanceLogger:(TCISInstanceLogger *)instanceLogger
   didSendSuccessedLog:(TCISLog *)log;

// 로그 전송 실패
- (void)instanceLogger:(TCISInstanceLogger *)instanceLogger
      didSendFailedLog:(TCISLog *)log
                 error:(NSError *)error;

// 네트워크 등의 이유로 로그 전송이 실패한 경우 재전송을 위한 로컬 DB 저장
- (void)instanceLogger:(TCISInstanceLogger *)instanceLogger
           didSavedLog:(TCISLog *)log;

// Filter 설정에 의해 필터링
- (void)instanceLogger:(TCISInstanceLogger *)instanceLogger
        didFilteredLog:(TCISLog *)log
             logFilter:(TCISLogFilter *)logFilter;

@end
```

## Crash Reporter

### Initialize

```objc
[TCISCrash setConfigurationLogger: [TCISLogger instanceLogger] ];
```

### Set User Field

사용자가 원하는 필드를 설정합니다.

```objc
// 단일 UserField 추가
[TCISCrash setUserField:@"USER_VALUE" forKey:@"USER_KEY"];

// 다수의 UserField 추가
NSMutableDictionary<NSString*, NSString*> *userField = [[NSMutableDictionary alloc] init];
[userField setObject:@"USER_VALUE_1" forKey:@"USER_KEY_1"];
[userField setObject:@"USER_VALUE_2" forKey:@"USER\_KEY_2"];

[TCISCrash setUserField:userField];
```

> 이미 예약된 필드는 사용할 수 없습니다.
> KEY 문자열 내에 공백은 "\_"로 치환됩니다.
> 공백 문자열과 "\_" 는 KEY 문자열의 처음에 올 수 없습니다.

### Set Data Adapter

크래시 발생 시 크래시 로그 전송 전에 특정 Block을 수행하도록 설정할 수 있습니다.

```objc
[TCISCrash setUserFieldIntoTCISCrashBlock:^{

	// Input your code

}];
```
> 이미 예약된 필드는 사용할 수 없습니다.

### Crash Callback

크래시 정보를 전송 후 전송 결과를 Callback을 통해 확인할 수 있습니다.
```objc
// Delegate Setting
@interface YOURCLASSS : SUBCLASS <TCISCrashDelegate>

// ...
[TCISCrash enableCrashDelegate:self];
// ...


@protocol TCISCrashDelegate <NSObject>

@optional

// 크래시 로그 전송 성공
- (void)crashLoggerInstance:(TCISInstanceLogger *)instanceLogger
   didSendSuccessedCrashLog:(TCISLog *)crashLog;

// 크래시 로그 전송 실패
- (void)crashLoggerInstance:(TCISInstanceLogger *)instanceLogger
      didSendFailedCrashLog:(TCISLog *)crashLog
                      error:(NSError *)error;

// 네트워크 등의 이유로 크래시 로그 전송이 실패한 경우 재전송을 위한 로컬 DB 저장
- (void)crashLoggerInstance:(TCISInstanceLogger *)instanceLogger
           didSavedCrashLog:(TCISLog *)crashLog;

// Filter 설정에 의해 필터링
- (void)crashLoggerInstance:(TCISInstanceLogger *)instanceLogger
        didFilteredCrashLog:(TCISLog *)crashLog
                  logFilter:(TCISLogFilter *)logFilter;

@end
```