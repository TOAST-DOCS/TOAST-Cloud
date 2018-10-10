## TOAST > TOAST SDK 사용 가이드 > TOAST Log & Crash > iOS

## Prerequisites

1\. [Install the TOAST SDK](./getting-started-ios)
2\. [TOAST 콘솔](https://console.cloud.toast.com)에서 [Log & Crash Search를 활성화](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/)합니다.
3\. Log & Crash Search에서 [AppKey를 확인](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/#appkey)합니다.

## TOAST Logger SDK 초기화

Log & Crash Search에서 발급받은 AppKey를 ProjectKey로 설정합니다.

```objc
[ToastLogger initWithConfiguration:[ToastLoggerConfiguration configurationWithProjectKey:@"YOUR_PROJECT_KEY"]];
```

## 로그 전송하기

TOAST Logger는 5가지 레벨의 로그 전송 함수를 제공합니다.

### 로그 전송 API 명세

```objc
@interface ToastLogger : NSObject

//...

// DEBUG Level log
+ (void)debug:(NSString *)message;

// INFO Level log
+ (void)info:(NSString *)message;

// WARN Level log
+ (void)warn:(NSString *)message;

// ERROR Level log
+ (void)error:(NSString *)message;

// FATAL Level log
+ (void)fatal:(NSString *)message;

//...

@end
```

### 로그 전송 API 사용 예

```objc
[ToastLogger info:@"TOAST Log & Crash Search!"];
```

## 사용자 정의 필드 설정하기

사용자 정의 원하는 필드를 설정합니다. 
사용자 정의 필드를 설정하면 로그 전송 API를 호출할 때마다 설정한 값을 로그와 함께 서버로 전송합니다.

### 사용자 정의 필드 API 명세

```objc
@interface ToastLogger : NSObject

// ...
// UserField 추가
+ (void)setUserFieldWithValue:(NSString *)value forKey:(NSString *)key;
// ...

@end
```

*  사용자 정의 필드는 "Log & Crash Search 콘솔" > "Log Search 탭"에 "선택한 필드"로 노출되는 값과 동일합니다.  
즉, Log & Crash Search의 커스텀 파라미터와 동일한 것으로 "field"값의 상세한 제약 사항은 [커스텀 필드의 제약사항](http://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/api-guide/)에서 확인할 수 있습니다.

#### 사용자 정의 필드 제약사항

* 이미 [예약된 필드](./log-collector-reserved-fields)는 사용할 수 없습니다.  
예약된 필드는 [커스텀 필드의 제약사항](http://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/api-guide/) 항목의 "기본 파라미터"를 확인하세요.
* 필드명은 "A-Z, a-z"로 시작하고 "A-Z, a-z, 0-9, -, _" 문자를 사용할 수 있습니다.
* 필드명 내에 공백은 "\_"로 치환됩니다.

### 사용자 정의 필드 사용 예
```objc
// UserField 추가
[ToastLogger setUserFieldWithValue:@"USER_VALUE" forKey:@"USER_KEY"];
```

## 크래시 로그 수집
TOAST Logger는 크래시 정보를 로그로 전송하는 기능을 제공합니다.
ToastLogger 초기화 시에 함께 활성화되고 사용여부를 설정할 수 있습니다. 
크래시 로그 전송을 위해 PLCrashReporter를 사용합니다.

### CrashReporter 사용 여부 설정
CrashReporter 기능은 기본적으로 ToastLogger를 초기화할 때 함께 활성화됩니다.
```objc
[ToastLogger initWithConfiguration:[ToastLoggerConfiguration configurationWithProjectKey:@"YOUR_PROJECT_KEY"]];
```
ToastLogger 초기화 시에 사용 여부를 설정할 수 있습니다.
크래시 로그 전송을 기능을 사용하지 않으려면 CrashReporter 기능을 비활성화해야 합니다. 

#### CrashReporter 활성화
```objc
// CrashReporter Enable Configuration
ToastLoggerConfiguration *configuration = [ToastLoggerConfiguration configurationWithProjectKey:@"YOUR_PROJECT_KEY" enableCrashReporter:YES];

[ToastLogger initWithConfiguration:configuration];
```
#### CrashReporter 비활성화
```objc

// CrashReporter Disable Configuration
ToastLoggerConfiguration *configuration = [ToastLoggerConfiguration configurationWithProjectKey:@"YOUR_PROJECT_KEY" enableCrashReporter:NO];

[ToastLogger initWithConfiguration:configuration];
```

## 크래시 발생 시점에 추가 정보를 설정하여 전송하기

크래시 발생 직후, 추가 정보를 설정할 수 있습니다.
setShouldReportCrashHandler의 Block에서 사용자 정의 필드를 설정하면 정확히 크래시가 발생한 시점에 추가 정보를 설정할 수 있습니다.

### Data Adapter API 명세
```objc
@interface ToastLogger : NSObject

//...

+ (void)setShouldReportCrashHandler:(void (^)(void))handler;

//...

@end
```

### Data Adapter 사용 예

```objc
[ToastLogger setShouldReportCrashHandler:^{
  
  //사용자 정의 필드 를 통해 Crash가 발생한 상황에서 얻고자 하는 정보를 함께 전송    
  // UserField 추가
  [ToastLogger setUserFieldWithValue:@"USER_VALUE" forKey:@"USER_KEY"];

}];
```

## 로그 전송 후 추가작업 진행하기

Delegate를 등록하면 로그 전송 후 추가 작업을 진행할 수 있습니다.


### Delegate API 명세
```objc
@interface ToastLogger : NSObject

// ...

+ (void)setDelegate:(id<ToastLoggerDelegate>) delegate;

// ...
@end


@protocol ToastLoggerDelegate <NSObject>
@optional
// 로그 전송 성공
- (void)toastLogDidSuccess:(ToastLog *)log;

// 로그 전송 실패
- (void)toastLogDidFail:(ToastLog *)log error:(NSError *)error;

// 네트워크 등의 이유로 로그 전송이 실패한 경우 재전송을 위해 SDK 내부 저장
- (void)toastLogDidSave:(ToastLog *)log;

// Filter 설정에 의해 필터링
- (void)toastLogDidFilter:(ToastLog *)log logFilter:(ToastLogFilter *)logFilter;
@end
```


### Delegate 사용 예

```objc
// Delegate Setting
@interface YOURCLASSS : SUBCLASS <ToastLoggerDelegate>

// ...

[ToastLogger setDelegate:self];

// ...

- (void)toastLogDidSuccess:(ToastLog *)log {
      // 로그 전송 성공
 }

- (void)toastLogDidFail:(ToastLog *)log error:(NSError *)error {
      // 로그 전송 실패
}
- (void)toastLogDidSave:(ToastLog *)log {
      // 네트워크 등의 이유로 로그 전송이 실패한 경우 재전송을 위해 SDK 내부 저장
}

- (void)toastLogDidFilter:(ToastLog *)log logFilter:(ToastLogFilter *)logFilter {
      // Filter 설정에 의해 필터링
}

@end
```

