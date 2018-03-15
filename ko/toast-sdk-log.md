## Analytics > Log & Crash Search > TOAST SDK 사용 가이드 > Log Collection

TOAST Logger SDK는 Log & Crash Search 수집 서버에 로그를 전송하는 기능을 제공합니다.

* [Android 설정](#android)
* [iOS 설정](#ios)
* [Unity 설정](#unity)

## Introduction
### 주요기능
| 기능 | 설명 |
| -- | -- |
| 로그 전송 | 로그를 수집 서버로 전송합니다. |
| 조회 및 검색 | Log & Crash Search에서 전송된 로그를 조회 및 검색이 가능합니다. |

### Prerequisites

1\. [Install the TOAST SDK](./toast-sdk-overview.md)

2\. [TOAST 콘솔](https://console.cloud.toast.com)에서 [Log & Crash Search를 활성화](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/)합니다.

3\. Log & Crash Search에서 [AppKey를 확인](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/#appkey)합니다.

## Android
### Initialize

onCreate() 메소드에서 Logger를 초기화합니다.
Log & Crash Search에서 발급받은 AppKey를 ProjectKey로 설정합니다.

```java
// Initialize Logger
ToastLoggerConfiguration loggerConfiguration = new ToastLoggerConfiguration.Builder()
        .setProjectKey(YOUR_PROJECT_KEY)            // Log & Crash Search AppKey
        .setProjectVersion(YOUR_PROJECT_VERSION)    // App Version
        .build();

ToastLogger.initialize(loggerConfiguration);
```

### Send Log

TOAST Logger는 5가지 레벨의 로그 전송 함수를 제공합니다.

```java
// DEBUG 레벨 로그
ToastLogger.debug(tag, message);

// INFO 레벨 로그
ToastLogger.info(tag, message);

// WARN 레벨 로그
ToastLogger.warn(tag, message);

// ERROR 레벨 로그
ToastLogger.error(tag, message);

// FATAL 레벨 로그
ToastLogger.fatal(tag, message);
```

### Set UserID 

사용자 아이디를 설정합니다.
설정된 사용자 아이디는 "UserID" 필드로 Log & Crash Search에서 조회할 수 있습니다.

```java
ToastLogger.setUserId(userId);
```

### Set User Field

사용자가 원하는 필드를 설정합니다.

```java
ToastLogger.setUserField("UserField", "UserValue");
```

> 이미 예약된 필드는 사용할 수 없습니다.

### Log Callback

로그를 전송 후 전송 결과를 Callback을 통해 확인할 수 있습니다.

```java
ToastLogger.setListener(new ToastLoggerListener() {
    @Override
    public void onSuccess(LogObject log) {
        // 로그 전송에 성공하였습니다.
    }

    @Override
    public void onFiltered(LogObject log, LogFilter filter) {
        // 로그 필터에 의해 로그가 필터링되었습니다.
    }

    @Override
    public void onSaved(LogObject log) {
        // 네트워크 차단으로 로그가 저장되었습니다.
    }

    @Override
    public void onError(LogObject log, int errorCode, String errorMessage) {
        // 전송에 실패하였습니다.
    }
});
```

## iOS
### Initialize

Log & Crash Search에서 발급받은 AppKey를 ProjectKey로 설정합니다.

```objc
TCISLoggerConfiguration *configuration = [TCISLoggerConfiguration configurationWithProjectKey:YOUR_PROJECT_KEY
                                                                               projectVersion:YOUR_PROJECT_VERSION];

[TCISLogger loggerConfiguration:configuration];
```

### Send Log

TOAST Logger는 5가지 레벨의 로그 전송 함수를 제공합니다.

```objc
// DEBUG Level log
[TCISLogger debugWithLogTag:tag message:message];

// INFO Level log
[TCISLogger infoWithLogTag:tag message:message];

// WARN Level log
[TCISLogger warnWithLogTag:tag message:message];

// ERROR Level log
[TCISLogger errorWithLogTag:tag message:message];

// FATAL Level log
[TCISLogger fatalWithLogTag:tag message:message];
```

### Set UserID

사용자 아이디를 설정합니다.
설정된 사용자 아이디는 "UserID" 필드로 Log & Crash Search에서 조회할 수 있습니다.

```objc
[TCISLogger setUserID:userID];
```

### Set User Field

사용자가 원하는 필드를 설정합니다.

```objc
NSMutableDictionary<NSString*, NSString*> *userField = [[NSMutableDictionary alloc] init];
[userField setObject:@"UserValue" forKey:@"UserKey"];

[TCISLogger addUserLogField:userField];
```

> 이미 예약된 필드는 사용할 수 없습니다.

### Log Callback

로그를 전송 후 전송 결과를 Callback을 통해 확인할 수 있습니다.

```objc
//Delegate Setting
@interface YOURCLASSS : SUBCLASS <TCISLoggerDelegate>

// ...
[TCISLogger setDelegate:self];
// ...

- (void)instanceLogger:(TCISInstanceLogger *)instanceLogger
   didSendSuccessedLog:(TCISLog *)log {
    // Successed Log Send
}

- (void)instanceLogger:(TCISInstanceLogger *)instanceLogger
      didSendFailedLog:(TCISLog *)log
                 error:(NSError *)error {
    // Failed Log Send
}

- (void)instanceLogger:(TCISInstanceLogger *)instanceLogger
           didSavedLog:(TCISLog *)log {
    // Saved Log -> Network not Connected
}

- (void)instanceLogger:(TCISInstanceLogger *)instanceLogger
        didFilteredLog:(TCISLog *)log
             logFilter:(TCISLogFilter *)logFilter {
    // Filterd Log
}
```

## Unity
### Initialize

Log & Crash Search에서 발급받은 AppKey를 ProjectKey로 설정합니다.

```cs
// Initialize Logger
ToastLoggerConfiguration configuration = ScriptableObject.CreateInstance<ToastLoggerConfiguration> ();
configuration.setProjectKey (YOUR_PROJECT_KEY);
configuration.setProjectVersion (YOUR_PROJECT_VERSION);

ToastLogger.initialize (configuration);
```

### Send Log

TOAST Logger는 5가지 레벨의 로그 전송 함수를 제공합니다.

```cs
// DEBUG 레벨 로그
ToastLogger.debug(tag, message);

// INFO 레벨 로그
ToastLogger.info(tag, message);

// WARN 레벨 로그
ToastLogger.warn(tag, message);

// ERROR 레벨 로그
ToastLogger.error(tag, message);

// FATAL 레벨 로그
ToastLogger.fatal(tag, message);
```

### Set UserID

사용자 아이디를 설정합니다.
설정된 사용자 아이디는 "UserID" 필드로 Log & Crash Search에서 조회할 수 있습니다.

```cs
ToastLogger.setUserId(userId);
```

### Set User Field

사용자가 원하는 필드를 설정합니다.

```cs
ToastLogger.setUserField("UserField", "UserValue");
```

> 이미 예약된 필드는 사용할 수 없습니다.

### Log Callback

로그를 전송 후 전송 결과를 Callback을 통해 확인할 수 있습니다.

```cs
void Start() {
    ToastLogger.initialize (consoleConfig);
}

void OnEnable () {
    ToastLogger.StartListening ("onSuccess", onSuccessFunction);
    ToastLogger.StartListening ("onFiltered", onSavedFunction);
    ToastLogger.StartListening ("onFiltered", onFilteredFunction);
    ToastLogger.StartListening ("onError", onErrorFunction);
}

void OnDisable () {
    ToastLogger.StopListening ("onSuccess", onSuccessFunction);
    ToastLogger.StopListening ("onFiltered", onSavedFunction);
    ToastLogger.StopListening ("onFiltered", onFilteredFunction);
    ToastLogger.StopListening ("onError", onErrorFunction);
}

void onSuccessFunction(ToastLogResult result){
    // 로그 전송에 성공하였습니다.
}

void onSavedFunction(ToastLogResult result){
    // 네트워크 차단으로 로그가 저장되었습니다.
}

void onFilteredFunction(ToastLogResult result){
   // 로그 필터에 의해 로그가 필터링되었습니다.
}

void onErrorFunction(ToastLogResult result){
     // 전송에 실패하였습니다.
}
```
