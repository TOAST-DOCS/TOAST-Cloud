## TOAST > TOAST SDK 사용 가이드 > Crash Reporter > iOS

## Prerequisites

TOAST Crash SDK는 [TOAST Logger](./log-collector-ios)를 사용하여 크래시 정보를 Log&Crash Search 수집 서버로 전송합니다.

1\. [Install the TOAST SDK](./getting-started-ios)
2\. [TOAST 콘솔](https://console.cloud.toast.com)에서 [Log&Crash Search를 활성화](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/)합니다.
3\. Log&Crash Search에서 [AppKey를 확인](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/#appkey)합니다.
4\. [TOAST Logger를 초기화](./log-collector-ios#initialize)합니다.

## Initialize

```objc
[TCISCrash setConfigurationLogger: [TCISLogger instanceLogger] ];
```

## Set User Field

사용자가 원하는 필드를 설정합니다.

```objc
// Dictionary를 통한 UserField 추가
// UserFiled에 추가되는 형태가 아닌 UserFiled 전체가 갱신
NSMutableDictionary<NSString*, NSString*> *userField = [[NSMutableDictionary alloc] init];  
[userField setObject:@"USER_VALUE" forKey:@"USER_KEY"];
[TCISCrash setUserField:userField];

// 단일 UserField 추가
[TCISCrash setUserFieldWithValue:@"USER_VALUE" forKey:@"USER_KEY"];
```

> 이미 예약된 필드는 사용할 수 없습니다.
> 필드명은 "A-Z, a-z"로 시작하고 "A-Z, a-z, 0-9, -, _" 문자를 사용할 수 있습니다.
> 필드명 내에 공백은 "\_" 로 치환됩니다.

## Set Data Adapter

크래시 발생 시 추가 정보를 설정할 수 있습니다.

```objc
[TCISCrash setUserFieldIntoTCISCrashBlock:^{
  
  //Set User Field 를 통해 Crash가 발생한 상황에서 얻고자 하는 정보를 함께 전송
  
}];
```

## Crash Callback

크래시 정보를 전송 후 전송 결과를 받기 원할때에는 Callback을 통해 확인할 수 있습니다.
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

// 네트워크 등의 이유로 크래시 로그 전송이 실패한 경우 재전송을 위한 SDK 내부 저장
- (void)crashLoggerInstance:(TCISInstanceLogger *)instanceLogger
           didSavedCrashLog:(TCISLog *)crashLog;

// Filter 설정에 의해 필터링
- (void)crashLoggerInstance:(TCISInstanceLogger *)instanceLogger
        didFilteredCrashLog:(TCISLog *)crashLog
                  logFilter:(TCISLogFilter *)logFilter;

@end
```
