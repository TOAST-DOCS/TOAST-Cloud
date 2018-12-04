## TOAST > TOAST SDK Guide > TOAST Log & Crash > Android

## Prerequisites

1\. [Install the TOAST SDK](./getting-started-android)
2\. [TOAST 콘솔](https://console.cloud.toast.com)에서 [Log & Crash Search를 활성화](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/)합니다.
3\. Log & Crash Search에서 [AppKey를 확인](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/#appkey)합니다.
4\. [TOAST SDK를 초기화](./getting-started-android/#toast-sdk_1)합니다.

## 라이브러리 설정
- 아래 코드를 build.gradle에 추가합니다.

```groovy
dependencies {
    implementation 'com.toast.android:toast-logger:0.12.0'
    ...
}
```

## TOAST Logger SDK 초기화

onCreate() 메서드에서 Logger를 초기화합니다.
Log & Crash Search에서 발급받은 AppKey를 ProjectKey로 설정합니다.

```java
// Initialize Logger
ToastLoggerConfiguration configuration = ToastLoggerConfiguration.newBuilder()
        .setProjectKey(YOUR_PROJECT_KEY)            // Log & Crash Search AppKey
        .build();

ToastLogger.initialize(configuration);
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

### setLoggerListener API 명세

```java
static void setLoggerListener(ToastLoggerListener listener);
```

### setLoggerListener 사용 예

```java
ToastLogger.setLoggerListener(new ToastLoggerListener() {
    @Override
    public void onSuccess(LogEntry log) {
        // 로그 전송 성공.
    }

    @Override
    public void onFilter(LogEntry log, LogFilter filter) {
        // Filter 설정에 의해 필터링
    }

    @Override
    public void onSave(LogEntry log) {
        // 네트워크 등의 이유로 로그 전송이 실패한 경우 재전송을 위해 SDK 내부 저장
    }

    @Override
    public void onError(LogEntry log, Exception e) {
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
ToastLoggerConfiguration configuration = ToastLoggerConfiguration.newBuilder()
        .setProjectKey(YOUR_PROJECT_KEY)            // Log & Crash Search AppKey
        .setEnabledCrashReporter(true)              // Enable or Disable Crash Reporter
        .build();

ToastLogger.initialize(configuration);
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
setUserField는 크래시 시점과 관계없이 아무 때나 설정할 수 있고, setCrashDataAdapter의 경우 정확히 크래시가 발생한 시점에 추가 정보를 설정할 수 있습니다.

### setCrashDataAdapter API 명세

```java
static void setCrashDataAdapter(CrashDataAdapter adapter);
```
* CrashDataAdapter의 getUserFields 함수를 통해 리턴하는 Map 자료구조의 키값은 위에서 설명한 setUserField의 "field"값과 동일한 제약 조건을 갖습니다.

### setCrashDataAdapter 사용 예

```java
ToastLogger.setCrashDataAdapter(new CrashDataAdapter() {
    @Override
    public Map<String, Object> getUserFields() {
        Map<String, Object> userFields = new HashMap<>();
        userFields.put("UserField", "UserValue");
        return userFields;
    }
});
```

## Network Insights
Network Insights는 콘솔에 등록한 URL을 호출하여 지연시간 및 응답 값을 측정합니다. 이를 활용하여 세계 여러 나라(디바이스의 국가 코드 기준)에서의 지연시간과 응답 값을 측정할 수 있습니다.

> 콘솔을 통해 Network Insights 기능을 활성화하면 TOAST Logger 초기화 시에, 콘솔에 등록한 URL로 1회 요청합니다.

### Network Insights 활성화

1. [TOAST Console](https://console.toast.com/) 에서 [Log & Crash Search] 서비스를 선택합니다.
2. [설정] 메뉴를 선택합니다.
3. [로그 전송 설정] 탭을 선택합니다.
4. "Network Insights 로그"를 활성화합니다.

### URL 설정

1. [TOAST Console](https://console.toast.com/) 에서 [Log & Crash Search] 서비스를 선택합니다.
2. [네트워크 인사이트] 메뉴를 선택합니다.
3. [URL 설정] 탭을 선택합니다.
4. 측정하고 자하는 URL을 입력 후 [추가] 버튼을 클릭합니다.




