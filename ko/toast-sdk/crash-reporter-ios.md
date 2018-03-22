## TOAST > TOAST SDK 사용 가이드 > TOAST Crash Reporter > iOS

## Prerequisites

TOAST Crash SDK는 [TOAST Logger](./log-collector-ios)를 사용하여 크래시 정보를 Log&Crash Search 수집 서버로 전송합니다.

1\. [Install the TOAST SDK](./getting-started-ios)
2\. [TOAST 콘솔](https://console.cloud.toast.com)에서 [Log&Crash Search를 활성화](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/)합니다.
3\. Log&Crash Search에서 [AppKey를 확인](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/#appkey)합니다.
4\. [TOAST Logger를 초기화](./log-collector-ios#initialize)합니다.

## TOAST Crash SDK 초기화

> 주의 : TOAST Crash SDK 기능을 사용하기 위해서는 TOAST Logger 초기화가 선행되어야 합니다.
```objc
[TCISCrash initWithLogger:[TCISLogger instanceLogger] ];
```

## 크래시 발생 시 전송하는 사용자 정의 필드 설정하기

크래시 발생 시 추가 정보 전달을 위해 사용자 정의 필드를 사용할 수 있습니다. 
사용자 정의 필드 API는 크래시 발생 시점과 상관없이 키 밸류 형태의 추가 정보를 설정할 수 있고, 설정한 추가 정보는 크래시 발생 시에 Log & Crash Search로 서버로 전송합니다.

### 사용자 정의 필드 API 명세

```objc
@interface TCISCrash : NSObject

// ...

// Dictionary를 통한 UserField 설정
+ (void)setUserField:(NSDictionary<NSString *, NSString *> *)userField;

// UserField 추가
+ (void)setUserFieldWithValue:(NSString *)value forKey:(NSString *)key;

// ...

@end
```

* "field"는 "Log & Crash Search 콘솔" > "Log Search 탭"에 "선택한 필드"로 노출되는 값과 동일합니다.  
즉, Log & Crash Search의 커스텀 파라미터와 동일한 것으로 "field"값의 상세한 제약 사항은 [커스텀 필드의 제약사항](http://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/api-guide/)에서 확인할 수 있습니다.
* 동일한 키에 대해 값을 여러 번 변경하면, 최종으로 변경한 값이 적용됩니다.

#### 사용자 정의 필드 제약사항

* 이미 예약된 필드는 사용할 수 없습니다. 예약된 필드는 [커스텀 필드의 제약사항](http://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/api-guide/) 항목의 "기본 파라미터"를 확인하세요.
* 필드명은 "A-Z, a-z"로 시작하고 "A-Z, a-z, 0-9, -, _" 문자를 사용할 수 있습니다.
* 필드명 내에 공백은 "\_"로 치환됩니다.


### 사용자 정의 필드 사용 예

```objc

// Dictionary를 통한 UserField 설정
NSMutableDictionary<NSString*, NSString*> *userField = [[NSMutableDictionary alloc] init];
[userField setObject:@"USER_VALUE" forKey:@"USER_KEY"];
[TCISCrash setUserField:userField];

// UserField 추가
[TCISCrash setUserFieldWithValue:@"USER_VALUE" forKey:@"USER_KEY"];

```
## 크래시 발생 시점에 추가 정보를 설정하여 전송하기

크래시 발생 직후, 추가 정보를 설정할 수 있습니다.
setShouldReportCrashHandler의 Block에서 사용자 정의 필드를 설정하면 정확히 크래시가 발생한 시점에 추가 정보를 설정할 수 있습니다.

### Data Adapter API 명세
```objc
@interface TCISCrash : NSObject

//...

+ (void)setShouldReportCrashHandler:(void (^)(void))handler;

//...

@end
```

### Data Adapter 사용 예

```objc
[TCISCrash setShouldReportCrashHandler:^{
  
  //사용자 정의 필드 를 통해 Crash가 발생한 상황에서 얻고자 하는 정보를 함께 전송
  
  // Dictionary를 통한 UserField 설정
  NSMutableDictionary<NSString*, NSString*> *userField = [[NSMutableDictionary alloc] init];
  [userField setObject:@"USER_VALUE" forKey:@"USER_KEY"];
  [TCISCrash setUserField:userField];
  
  // UserField 추가
  [TCISCrash setUserFieldWithValue:@"USER_VALUE" forKey:@"USER_KEY"];

}];
```

## 크래시 로그 전송 후 추가 작업 진행하기

Delegate를 등록하면 크래시 로그 전송 후 추가 작업을 진행할 수 있습니다.


### Delegate API 명세
```objc
@interface TCISCrash : NSObject

// ...

+ (void)setDelegate:(id<TCISCrashDelegate>) crashDelegate;

// ...
@end

@protocol TCISCrashDelegate <NSObject>
@optional
// 크래시 로그 전송 성공
- (void)crashLogger:(TCISInstanceLogger *)crashLogger
 didSuccessCrashLog:(TCISLog *)crashLog;

// 크래시 로그 전송 실패
- (void)crashLogger:(TCISInstanceLogger *)crashLogger
    didFailCrashLog:(TCISLog *)crashLog
              error:(NSError *)error;

// 네트워크 등의 이유로 크래시 로그 전송이 실패한 경우 재전송을 위한 SDK 내부 저장
- (void)crashLogger:(TCISInstanceLogger *)crashLogger
    didSaveCrashLog:(TCISLog *)crashLog;

// Filter 설정에 의해 필터링
- (void)crashLogger:(TCISInstanceLogger *)crashLogger
  didFilterCrashLog:(TCISLog *)crashLog
          logFilter:(TCISLogFilter *)logFilter;
@end
```


### Delegate 사용 예

```objc
// Delegate Setting
@interface YOURCLASSS : SUBCLASS <TCISCrashDelegate>

// ...

[TCISCrash setDelegate:self];

// ...

- (void)crashLogger:(TCISInstanceLogger *)crashLogger
 didSuccessCrashLog:(TCISLog *)crashLog {
  // 크래시 로그 전송 성공
 }

- (void)crashLogger:(TCISInstanceLogger *)crashLogger
    didFailCrashLog:(TCISLog *)crashLog
              error:(NSError *)error {
  // 크래시 로그 전송 실패
}

- (void)crashLogger:(TCISInstanceLogger *)crashLogger
    didSaveCrashLog:(TCISLog *)crashLog {
  // 네트워크 등의 이유로 크래시 로그 전송이 실패한 경우 재전송을 위한 SDK 내부 저장
}

- (void)crashLogger:(TCISInstanceLogger *)crashLogger
  didFilterCrashLog:(TCISLog *)crashLog
          logFilter:(TCISLogFilter *)logFilter {
  // Filter 설정에 의해 필터링
}

```
