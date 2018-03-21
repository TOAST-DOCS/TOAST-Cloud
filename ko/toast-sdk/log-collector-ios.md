## TOAST > TOAST SDK 사용 가이드 > TOAST Logger > iOS

## Prerequisites

1\. [Install the TOAST SDK](./getting-started-ios)
2\. [TOAST 콘솔](https://console.cloud.toast.com)에서 [Log&Crash Search를 활성화](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/)합니다.
3\. Log&Crash Search에서 [AppKey를 확인](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/#appkey)합니다.

## Initialize

Log&Crash Search에서 발급받은 AppKey를 ProjectKey로 설정합니다.

```objc
TCISLoggerConfiguration *configuration = [TCISLoggerConfiguration configurationWithProjectKey:@"YOUR_PROJECT_KEY"
                                                                               projectVersion:@"YOUR_PROJECT_VERSION"];

[TCISLogger setConfiguration:configuration];
```

## Send Log

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

## Set UserID

사용자 아이디를 설정합니다.
설정된 사용자 아이디는 "UserID" 필드로 Log&Crash Search에서 조회할 수 있습니다.

```objc
[TCISLogger setUserID:@"USER_ID"];
```

## Set User Field

사용자가 원하는 필드를 설정합니다.

```objc
// Dictionary를 통한 UserField 설정
NSMutableDictionary<NSString*, NSString*> *userField = [[NSMutableDictionary alloc] init];  
[userField setObject:@"USER_VALUE" forKey:@"USER_KEY"];
[TCISLogger setUserLogField: userField];

// UserField 추가
[TCISLogger setUserLogFieldWithValue:@"USER_VALUE" forKey:@"USER_KEY"];
```

> 이미 예약된 필드는 사용할 수 없습니다.
> 필드명은 "A-Z, a-z"로 시작하고 "A-Z, a-z, 0-9, -, _" 문자를 사용할 수 있습니다.
> 필드명 내에 공백은 "\_" 로 치환됩니다.

## Log Callback

로그를 전송 후 전송 결과를 받기 원할때에는 Callback을 통해 확인할 수 있습니다.

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

// 네트워크 등의 이유로 로그 전송이 실패한 경우 재전송을 위한 SDK 내부 저장
- (void)instanceLogger:(TCISInstanceLogger *)instanceLogger
           didSavedLog:(TCISLog *)log;

// Filter 설정에 의해 필터링
- (void)instanceLogger:(TCISInstanceLogger *)instanceLogger
        didFilteredLog:(TCISLog *)log
             logFilter:(TCISLogFilter *)logFilter;

@end
```

## Using the Other Service

* [TOAST Crash Reporter > iOS](./crash-reporter-ios) 사용 가이드

