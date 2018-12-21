## TOAST > TOAST SDK 사용 가이드 > TOAST Log & Crash > iOS

> [공지]
> 현재 arm64e 아키텍처를 사용하는 신규기기(iPhone XS, XR, XS Max, iPad Pros 3rd)에서 크래시가 발생한 경우에는 크래시 발생 건수의 집계만 가능하며, 크래시 내용의 분석(스택추적)이 되지 않습니다. 
> 빠른 시일 내에 신규기기에 대한 분석(스택추적) 기능을 제공하도록 하겠습니다.

## Prerequisites

1\. [TOAST SDK](./getting-started-ios)를 설치합니다.
2\. [TOAST 콘솔](https://console.cloud.toast.com)에서 [Log & Crash Search를 활성화](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/)합니다.
3\. Log & Crash Search에서 [AppKey를 확인](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/#appkey)합니다.

## Cococapods 적용

Podfile을 생성하여 TOAST SDK에 대한 pod를 추가합니다.

```podspec
platform :ios, '8.0'
use_frameworks!

target '{YOUR PROJECT TARGET NAME}' do
    pod 'ToastLogger'
end
```

생성된 Workspace를 열어 사용할 SDK를 가져옵니다(import).

```objc
#import <ToastCore/ToastCore.h>
#import <ToastLogger/ToastLogger.h>
```

## TOAST Logger SDK 초기화

Log & Crash Search에서 발급받은 AppKey를 ProjectKey로 설정합니다.

```objc
[ToastLogger initWithConfiguration:[ToastLoggerConfiguration configurationWithProjectKey:@"YOUR_PROJECT_KEY"]];
```

## 로그 전송

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

## 사용자 정의 필드 설정

원하는 사용자 정의 필드를 설정합니다. 
사용자 정의 필드를 설정하면 로그 전송 API를 호출할 때마다 설정한 값을 로그와 함께 서버로 전송합니다.

### 사용자 정의 필드 API 명세

```objc
@interface ToastLogger : NSObject

// ...
// 사용자 정의 필드 추가
+ (void)setUserFieldWithValue:(NSString *)value forKey:(NSString *)key;
// ...

@end
```

*  사용자 정의 필드는 **Log & Crash Search > 로그 검색**을 클릭한 후 **로그 검색** 화면의 **선택한 필드**에 표시되는 값과 같습니다. 
  
#### 사용자 정의 필드 제약사항

* 이미 [예약된 필드](./log-collector-reserved-fields)는 사용할 수 없습니다.  
* 필드 이름은 'A-Z, a-z'로 시작하고 'A-Z, a-z, 0-9, -, _' 문자를 사용할 수 있습니다.
* 필드 이름의 공백은 '_'로 치환됩니다.


### 사용자 정의 필드 사용 예
```objc
// 사용자 정의 필드 추가
[ToastLogger setUserFieldWithValue:@"USER_VALUE" forKey:@"USER_KEY"];
```

## 크래시 로그 수집
TOAST Logger는 크래시 정보를 로그로 전송하는 기능을 제공합니다.
TOAST Logger를 초기화할 때 함께 활성화되고 사용 여부를 설정할 수 있습니다. 
크래시 로그를 전송하려면 PLCrashReporter를 사용합니다.

### CrashReporter 사용 여부 설정
CrashReporter 기능은 기본적으로 TOAST Logger를 초기화할 때 함께 활성화됩니다.
```objc
[ToastLogger initWithConfiguration:[ToastLoggerConfiguration configurationWithProjectKey:@"YOUR_PROJECT_KEY"]];
```
TOAST Logger를 초기화할 때 사용 여부를 설정할 수 있습니다.
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

## 크래시 발생 시점에 추가 정보를 설정하여 전송

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
  
  // 사용자 정의 필드 를 통해 Crash가 발생한 상황에서 얻고자 하는 정보를 함께 전송    
  // 사용자 정의 필드 추가
  [ToastLogger setUserFieldWithValue:@"USER_VALUE" forKey:@"USER_KEY"];

}];
```

## 로그 전송 후 추가작업 진행

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

// 네트워크 단절 등의 이유로 로그 전송에 실패한 경우 재전송을 위해 SDK 내부 저장
- (void)toastLogDidSave:(ToastLog *)log;

// 로그 필터링
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
      // 네트워크 단절 등의 이유로 로그 전송에 실패한 경우 재전송을 위해 SDK 내부 저장
}

- (void)toastLogDidFilter:(ToastLog *)log logFilter:(ToastLogFilter *)logFilter {
      // 로그 필터링
}

@end
```

## Network Insights
Network Insights는 콘솔에 등록한 URL을 호출하여 지연 시간과 응답값을 측정합니다. 이를 활용하여 세계 여러 나라(디바이스의 국가 코드 기준)에서의 지연 시간과 응답값을 측정할 수 있습니다.

> 콘솔을 통해 Network Insights 기능을 활성화하면 TOAST Logger를 초기화할 때, 콘솔에 등록한 URL로 1회 요청합니다.

### Network Insights 활성화

Network Insights를 활성화하는 방법은 다음과 같습니다.

1. [TOAST Console](https://console.toast.com/)에서 **Log & Crash Search** 서비스를 클릭합니다.
2. **설정** 메뉴를 클릭합니다.
3. **로그 전송 설정** 탭을 클릭합니다.
4. **Network Insights 로그**를 활성화합니다.

### URL 설정

URL을 설정하는 방법은 다음과 같습니다.

1. [TOAST Console](https://console.toast.com/)에서 **Log & Crash Search** 서비스를 클릭합니다.
2. **네트워크 인사이트** 메뉴를 클릭합니다.
3. **URL 설정** 탭을 클릭합니다.
4. 측정하려는 URL을 입력하고 **추가** 버튼을 클릭합니다.
