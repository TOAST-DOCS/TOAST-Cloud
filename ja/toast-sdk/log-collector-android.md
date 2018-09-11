## TOAST > TOAST SDK Guide > TOAST Log & Crash > Android

## Prerequisites

1\. [Install the TOAST SDK](./getting-started-android)
2\. [TOAST 콘솔](https://console.cloud.toast.com)에서 [Log & Crash Search를 활성화](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/)합니다.
3\. Log & Crash Search에서 [AppKey를 확인](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/#appkey)합니다.
4\. [TOAST SDK를 초기화](./getting-started-android/#toast-sdk_1)합니다.

## TOAST Logger SDK 초기화

onCreate() 메서드에서 Logger를 초기화합니다.
Log&Crash Search에서 발급받은 AppKey를 ProjectKey로 설정합니다.

```java
// Initialize Logger
ToastLoggerConfiguration loggerConfiguration = new ToastLoggerConfiguration.Builder()
    .setProjectKey(YOUR_PROJECT_KEY)            // Log & Crash Search AppKey
    .build();

ToastLogger.initialize(loggerConfiguration);
```

## 로그 전송하기

TOAST Logger는 5가지 레벨의 로그 전송 함수를 제공합니다.

### 로그 전송 API 명세

```java
// DEBUG 레벨 로그
static void debug(String message);

// INFO 레벨 로그
static void info(String message);

// WARN 레벨 로그
static void warn(String message);

// ERROR 레벨 로그
static void error(String message);

// FATAL 레벨 로그
static void fatal(String message);
```

### 로그 전송 API 사용 예

```java
ToastLogger.warn("TOAST Log & Crash Search!");
```

## 사용자 정의 필드 설정하기

사용자 정의 원하는 필드를 설정합니다.
사용자 정의 필드를 설정하면 로그 전송 API를 호출할 때마다 설정한 값을 로그와 함께 서버로 전송합니다.

### setUserField API 명세

```java
static void setUserField(String field, Object value);
```

*  사용자 정의 필드는 "Log & Crash Search 콘솔" > "Log Search 탭"에 "선택한 필드"로 노출되는 값과 동일합니다.
즉, Log & Crash Search의 커스텀 파라미터와 동일한 것으로 "field"값의 상세한 제약 사항은 [커스텀 필드의 제약사항](http://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/api-guide/)에서 확인할 수 있습니다.

#### 커스텀 필드 제약사항

* 이미 [예약된 필드](./log-collector-reserved-fields)는 사용할 수 없습니다.
예약된 필드는 [커스텀 필드의 제약사항](http://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/api-guide/) 항목의 "기본 파라미터"를 확인하세요.
* 필드명은 "A-Z, a-z"로 시작하고 "A-Z, a-z, 0-9, -, _" 문자를 사용할 수 있습니다.
* 필드명 내에 공백은 "\_"로 치환됩니다.

### setUserField 사용 예

```java
ToastLogger.setUserField("nickname", "randy");
```

## 로그 전송 후 추가작업 진행하기

콜백 함수를 등록하면 로그 전송 후 추가 작업을 진행할 수 있습니다.

### setListener API 명세

```java
static void setListener(ToastLoggerListener listener);
```

### setListener 사용 예

```java
ToastLogger.setListener(new ToastLoggerListener() {
    @Override
    public void onSuccess(LogObject log) {
    // 로그 전송 성공.
    }

    @Override
    public void onFiltered(LogObject log, LogFilter filter) {
    // Filter 설정에 의해 필터링
    }

    @Override
    public void onSaved(LogObject log) {
    // 네트워크 등의 이유로 로그 전송이 실패한 경우 재전송을 위해 SDK 내부 저장
    }

    @Override
    public void onError(LogObject log, int errorCode, String errorMessage) {
    // 로그 전송 실패.
    }
});
```

## 크래시 로그 수집

TOAST Logger는 앱에서 예상치 못한 크래시가 발생한 경우 크래시 정보를 서버에 기록합니다.

### 크래시 로그 수집 사용 여부 설정

크래시 로그 전송 기능은 setEnabledCrashReporter() 메소드를 사용하여 활성화 또는 비활성화 할 수 있습니다.

```java
// Initialize Logger
ToastLoggerConfiguration loggerConfiguration = new ToastLoggerConfiguration.Builder()
    .setProjectKey(YOUR_PROJECT_KEY)            // Log & Crash Search AppKey
    .setProjectVersion(YOUR_PROJECT_VERSION)    // App Version
    .setEnabledCrashReporter(true)              // Enable or Disable Crash Reporter
    .build();

ToastLogger.initialize(loggerConfiguration);
```

### Handled Exception API 사용하기

Android 플랫폼의 경우 try/catch 구문에서 예외와 관련된 내용을 TOAST Logger의 Handled Exception API를 사용하여 전송할 수 있습니다.
이렇게 전송한 예외 로그는 "Log & Crash Search 콘솔" > "App Crash Search 탭"의 오류 유형에서 Handled로 필터링하여 조회할 수 있습니다.
자세한 Log & Crash 콘솔 사용 방법은 [콘솔 사용 가이드](http://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/)를 참고하세요.

### Handled Exception Log API 명세

```java
// 예외 정보 전송
static void report(@NonNull String message, @NonNull Throwable throwable);

// 사용자 필드와 함께 예외 정보 전송
static void report(@NonNull String message,
@NonNull Throwable throwable,
@Nullable Map<String, Object> userFields);

// ExceptionLog를 사용한 예외 정보 전송
static void report(@NonNull ExceptionLog log)
```

### 사용 예

```java
try {
    // User Codes...
} catch (Exception e) {
    Map<String, Object> userFields = new HashMap<>();
    ToastLogger.report("message", e, userFields);
}
```

## 크래시 발생 시점에 추가 정보를 설정하여 전송하기

크래시 발생 직후, 추가 정보를 설정할 수 있습니다.
setUserField는 크래시 시점과 관계없이 아무 때나 설정할 수 있고, setDataAdapter의 경우 정확히 크래시가 발생한 시점에 추가 정보를 설정할 수 있습니다.

### setDataAdapter API 명세

```java
static void setDataAdapter(CrashDataAdapter adapter);
```
* CrashDataAdapter의 getUserFields 함수를 통해 리턴하는 Map 자료구조의 키값은 위에서 설명한 setUserField의 "field"값과 동일한 제약 조건을 갖습니다.

### setDataAdapter 사용 예

```java
ToastLogger.setDataAdapter(new CrashDataAdapter() {
    @Override
    public Map<String, Object> getUserFields() {
        Map<String, Object> userFields = new HashMap<>();
        userFields.put("UserField", "UserValue");
        return userFields;
    }
});
```






