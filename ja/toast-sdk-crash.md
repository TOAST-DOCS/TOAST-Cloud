## Analytics > Log & Crash Search > TOAST SDK Guide > Crash Reporter

TOAST Crash SDK는 앱에서 발생하는 Crash 정보를 Log & Crash Search 수집 서버로 전송하는 기능을 제공합니다.

* [Android 설정](#Android)
* [iOS 설정](#iOS)
* [Unity 설정](#Unity)

## Introduction
### 주요 기능

| 기능 | 설명 |
| -- | -- |
| Detecting a Crash Occurred | 앱에서 발생한 Crash 정보를 전송합니다. |
| Handled Exceptions | try/catch statement에서 발생한 예외 정보를 전송합니다. (only Android)|

### Prerequisites

1\. [Install the TOAST SDK](./toast-sdk-overview.md)

2\. [TOAST 콘솔](https://console.cloud.toast.com)에서 [Log & Crash Search를 활성화](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/)합니다.

3\. [TOAST Logger를 초기화](./toast-sdk-log.md)합니다.

## Android
### Initialize

onCreate() 메소드에서 ToastCrash를 초기화합니다.

```java
// Initialize Crash
ToastCrash.initialize();
```

### Send Handled Exception

TOAST Crash는 5가지 레벨의 예외 정보를 전송할 수 있습니다.

```java
// DEBUG 레벨의 예외 정보 전송
ToastCrash.debug(tag, message, throwable);

// INFO 레벨의 예외 정보 전송
ToastCrash.info(tag, message, throwable);

// WARN 레벨의 예외 정보 전송
ToastCrash.warn(tag, message, throwable);

// ERROR 레벨의 예외 정보 전송
ToastCrash.error(tag, message, throwable);

// FATAL 레벨의 예외 정보 전송
ToastCrash.fatal(tag, message, throwable);
```

#### Using

```java
try {
    // User Codes...
} catch (Exception e) {
    ToastCrash.debug(TAG, "Handled Exception", e);
}
```

### Set User Field

사용자가 원하는 필드를 설정합니다.

```java
ToastCrash.setUserField("UserField", "UserValue");
```

> 이미 예약된 필드는 사용할 수 없습니다.

### Set Data Adapter

크래시 발생 시 추가 정보를 설정할 수 있습니다.

```java
ToastCrash.setDataAdapter(new CrashDataAdapter() {
    @Override
    public Map<String, Object> getUserFields() {
        Map<String, Object> userFields = new HashMap<>();
        userFields.put("UserField", "UserValue");
        return userFields;
    }
});
```

### Crash Callback

크래시 정보를 전송 후 전송 결과를 Callback을 통해 확인할 수 있습니다.

```java
ToastCrash.setListener(new CrashListener() {
    @Override
    public void onSuccess(LogObject log) {
        // 크래시 정보 전송
     전송에 성공하였습니다.
    }

    @Override
    public void onFiltered(LogObject log, LogFilter filter) {
        // 로그 필터에 의해 크래시 정보가 필터링되었습니다.
    }

    @Override
    public void onSaved(LogObject log) {
        // 네트워크 차단으로 크래시 정보가 저장되었습니다.
    }

    @Override
    public void onError(LogObject log, int errorCode, String errorMessage) {
        // 전송에 실패하였습니다.
    }
});
```

## iOS
### Initialize

```objc
[TCISCrash setConfigurationLogger: [TCISLogger instanceLogger] ];
```

### Set Data Adapter

크래시 발생 시 추가 정보를 설정할 수 있습니다.

```objc
[TCISCrash setUserFieldIntoTCISCrashBlock:^{

    [TCISCrash setUserField:@"UserFieldValue01" forKey:@"UserFieldKey01"];
    [TCISCrash setUserField:@"UserFieldValue02" forKey:@"UserFieldKey02"];
    [TCISCrash setUserField:@"UserFieldValue03" forKey:@"UserFieldKey03"];

}];
```

### Crash Callback

크래시 정보를 전송 후 전송 결과를 Callback을 통해 확인할 수 있습니다.

```objc
- (void)crashLoggerInstance:(TCISInstanceLogger *)instanceLogger
   didSendSuccessedCrashLog:(TCISLog *)crashLog {
    // Successed Crash Send
}

- (void)crashLoggerInstance:(TCISInstanceLogger *)instanceLogger
      didSendFailedCrashLog:(TCISLog *)crashLog
                      error:(NSError *)error {
    // Failed Crash Send
}

- (void)crashLoggerInstance:(TCISInstanceLogger *)instanceLogger
           didSavedCrashLog:(TCISLog *)crashLog {
    // Saved Crash -> Network not Connected
}

- (void)crashLoggerInstance:(TCISInstanceLogger *)instanceLogger
        didFilteredCrashLog:(TCISLog *)crashLog
                  logFilter:(TCISLogFilter *)logFilter {
    // Filterd Crash
}

```

## Unity
### Initialize

ToastCrash를 초기화합니다.

```cs
// Initialize Crash
ToastCrash.initialize();
```

### Send Handled Exception

TOAST Crash는 5가지 레벨의 예외 정보를 전송할 수 있습니다.

```cs
// DEBUG 레벨의 예외 정보 전송
ToastCrash.debug(tag, message, stackTrace);

// INFO 레벨의 예외 정보 전송
ToastCrash.info(tag, message, stackTrace);

// WARN 레벨의 예외 정보 전송
ToastCrash.warn(tag, message, stackTrace);

// ERROR 레벨의 예외 정보 전송
ToastCrash.error(tag, message, stackTrace);

// FATAL 레벨의 예외 정보 전송
ToastCrash.fatal(tag, message, stackTrace);
```

#### Try&Catch를 통한 로그 수집

try&catch를 사용하여 런타임 중 방생한 오류를 서버로 전송합니다.

```cs
try {
    // User Codes...
} catch {
    ToastCrash.fatal(TAG, "Handled Exception", stackTrace);
}
```

#### Application.RegisterLogCallback을 통한 로그 수집

- 사용자가 [Application.RegisterLogCallback](https://docs.unity3d.com/ScriptReference/Application.LogCallback.html)을 구현하면, ToastCrash.crashReporter 함수를 사용하여 C# 오류를 서버로 전송 합니다.

- TOAST SDK에서는 Exception과 Assert 레벨의 오류를 서버로 전송하는 것을 권장합니다.

- UnityEngineDebugLogFilter는 UnityEngine.Debug 클래스를 통해 발생한 로그를 필터링 합니다. TOAST SDK에서는 UnityEngine.Debug 로그는 필터링 하는 것을 권장합니다.

```cs
public class ExampleClass : MonoBehaviour {

   void OnEnable() {
        // RegisterLogCallback 등록
        Application.RegisterLogCallback(HandleLog);
    }

   void OnDisable() {
        // RegisterLogCallback 해제
        Application.RegisterLogCallback(null);
    }

    // UnityEngine Debug Log Filter
    bool UnityEngineDebugLogFilter(string stackTrace) {
        if (stackTrace.Contains ("UnityEngine.Debug")) {
            return true;
        }
        return false;
    }

   void HandleLog(string condition, string stackTrace, LogType type) {
        if (UnityEngineDebugLogFilter(stackTrace)){
            return;
        }

        if (type == LogType.Exception || type == LogType.Assert) {
            ToastCrash.crashReporter(TAG, condition, stackTrace, type);
        }
    }

}
```

### Set User Field

사용자가 원하는 필드를 설정합니다.

```cs
ToastCrash.setUserField("UserField", "UserValue");
```

> 이미 예약된 필드는 사용할 수 없습니다.

### Handled Exception Callback

Handled Exception 정보를 전송 후 전송 결과를 Callback을 통해 확인할 수 있습니다.

```cs
void Start() {
    ToastCrash.initialize();
}

void OnEnable () {
    ToastCrash.StartListening ("onSuccess", onSuccessFunction);
    ToastCrash.StartListening ("onFiltered", onSavedFunction);
    ToastCrash.StartListening ("onFiltered", onFilteredFunction);
    ToastCrash.StartListening ("onError", onErrorFunction);
}

void OnDisable () {
    ToastCrash.StopListening ("onSuccess", onSuccessFunction);
    ToastCrash.StopListening ("onFiltered", onSavedFunction);
    ToastCrash.StopListening ("onFiltered", onFilteredFunction);
    ToastCrash.StopListening ("onError", onErrorFunction);
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
