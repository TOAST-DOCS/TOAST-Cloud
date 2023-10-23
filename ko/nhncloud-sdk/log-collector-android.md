## NHN Cloud > SDK 사용 가이드 > Log & Crash > Android

## 사전 준비

1. [NHN Cloud SDK](./getting-started-android)을 설치합니다.
2. [NHN Cloud 콘솔](https://console.nhncloud.com)에서 [Log & Crash Search를 활성화](https://nhncloud.com/ko/Data%20&%20Analytics/Log%20&%20Crash%20Search/ko/console-guide/)합니다.
3. Log & Crash Search에서 [AppKey를 확인](https://nhncloud.com/ko/Data%20&%20Analytics/Log%20&%20Crash%20Search/ko/console-guide/#appkey)합니다.

## 라이브러리 설정
- 아래 코드를 build.gradle에 추가합니다.

```groovy
repositories {
    mavenCentral()
}

dependencies {
    implementation 'com.nhncloud.android:nhncloud-logger:1.8.1'
    ...
}
```

## NHN Cloud Logger SDK 초기화

- 초기화는 반드시 Application#onCreate에서 진행되어야 합니다.

> 초기화를 진행하지 않고, NhnCloudLogger를 사용하는 경우 초기화 오류가 발생합니다.

- Log & Crash Search에서 발급 받은 AppKey를 설정합니다.

```java
// Initialize Logger
NhnCloudLoggerConfiguration configuration = NhnCloudLoggerConfiguration.newBuilder()
        .setAppKey(YOUR_APP_KEY)            // Log & Crash Search AppKey
        .build();

NhnCloudLogger.initialize(configuration);
```

## 로그 전송

NHN Cloud Logger는 5가지 레벨의 로그 전송 함수를 제공합니다.

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
NhnCloudLogger.warn("NHN Cloud Log & Crash Search!");
```

## 사용자 정의 필드 설정

원하는 사용자 정의 필드를 설정합니다.
사용자 정의 필드를 설정하면 로그 전송 API를 호출할 때마다 설정한 값을 로그와 함께 서버로 전송합니다.

### setUserField API 명세

```java
static void setUserField(String field, Object value);
```

*  사용자 정의 필드는 **Log & Crash Search > 로그 검색**을 클릭한 후 **로그 검색** 화면의 **선택한 필드**에 표시되는 값과 같습니다.

#### 커스텀 필드 제약 사항

* 이미 [예약된 필드](./log-collector-reserved-fields)는 사용할 수 없습니다.
* 필드 이름은 'A-Z, a-z'로 시작하고 'A-Z, a-z, 0-9, -, _' 문자를 사용할 수 있습니다.
* 필드 이름의 공백은 '_'로 치환됩니다.

### setUserField 사용 예

```java
NhnCloudLogger.setUserField("nickname", "randy");
```

## 로그 전송 후 추가 작업 진행

콜백 함수를 등록하면 로그 전송 후 추가 작업을 진행할 수 있습니다.

### setLoggerListener API 명세

```java
static void setLoggerListener(NhnCloudLoggerListener listener);
```

### setLoggerListener 사용 예

```java
NhnCloudLogger.setLoggerListener(new NhnCloudLoggerListener() {
    @Override
    public void onSuccess(LogEntry log) {
        // 로그 전송 성공
    }

    @Override
    public void onFilter(LogEntry log, LogFilter filter) {
        // 로그 필터링
    }

    @Override
    public void onSave(LogEntry log) {
        // 네트워크 단절 등으로 로그 전송에 실패한 경우 재전송을 위해 SDK 내부 저장
    }

    @Override
    public void onError(LogEntry log, Exception e) {
        // 로그 전송 실패
    }
});
```

## 크래시 로그 수집

NHN Cloud Logger는 앱에서 예상하지 못한 크래시가 발생한 경우 크래시 정보를 서버에 기록합니다.

### 크래시 로그 수집 사용 여부 설정

크래시 로그 전송 기능은 setEnabledCrashReporter() 메서드를 사용하여 활성화 또는 비활성화할 수 있습니다.

```java
// Initialize Logger
NhnCloudLoggerConfiguration configuration = NhnCloudLoggerConfiguration.newBuilder()
        .setAppKey(YOUR_APP_KEY)            // Log & Crash Search AppKey
        .setEnabledCrashReporter(true)              // Enable or Disable Crash Reporter
        .build();

NhnCloudLogger.initialize(configuration);
```

> User ID가 설정되어 있으면 Log&Crash Search 콘솔의 `크래시 사용자` 항목에서 사용자별 크래시 경험을 확인 할 수 있습니다.
> User ID 설정은 [시작하기](./getting-started-android/#userid)에서 확인 가능합니다.

### Handled Exception API 사용

Android 플랫폼에서는 try/catch 구문에서 예외와 관련된 내용을 NHN Cloud Logger의 Handled Exception API를 사용하여 전송할 수 있습니다.
이렇게 전송한 예외 로그는 콘솔에서 **Log & Crash Search > 앱 크래시 검색**을 클릭하고 **오류 유형**에서 **Handled**를 클릭해 조회할 수 있습니다.
자세한 Log & Crash 콘솔 사용 방법은 [콘솔 사용 가이드](http://nhncloud.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/)를 참고하세요.

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
    NhnCloudLogger.report("message", e, userFields);
}
```

## 크래시 발생 시점에 추가 정보를 설정하여 전송

크래시 발생 직후, 추가 정보를 설정할 수 있습니다.
setUserField는 크래시 시점과 관계없이 아무때나 설정할 수 있고, setCrashDataAdapter의 경우 정확히 크래시가 발생한 시점에 추가 정보를 설정할 수 있습니다.

### setCrashDataAdapter API 명세

```java
static void setCrashDataAdapter(CrashDataAdapter adapter);
```

* CrashDataAdapter의 getUserFields 함수를 통해 리턴하는 Map 자료 구조의 키값은 위에서 설명한 setUserField의 'field값'과 같은 제약 조건을 갖습니다.

### setCrashDataAdapter 사용 예

```java
NhnCloudLogger.setCrashDataAdapter(new CrashDataAdapter() {
    @Override
    public Map<String, Object> getUserFields() {
        Map<String, Object> userFields = new HashMap<>();
        userFields.put("UserField", "UserValue");
        return userFields;
    }
});
```

## Network Insights

Network Insights는 콘솔에 등록한 URL을 호출하여 지연 시간과 응답값을 측정합니다. 이를 활용해 세계 여러 나라(디바이스의 국가 코드 기준)에서의 지연 시간과 응답값을 측정할 수 있습니다.

> 콘솔을 통해 Network Insights 기능을 활성화하면 NHN Cloud Logger를 초기화할 때 콘솔에 등록한 URL로 1회 요청합니다.

### Network Insights 활성화

Network Insights를 활성화하는 방법은 다음과 같습니다.

1. [NHN Cloud Console](https://console.nhncloud.com/)에서 **Log & Crash Search** 서비스를 클릭합니다.
2. **설정** 메뉴를 클릭합니다.
3. **로그 전송 설정** 탭을 클릭합니다.
4. **Network Insights 로그**를 활성화합니다.

### URL 설정

URL을 설정하는 방법은 다음과 같습니다.

1. [NHN Cloud Console](https://console.nhncloud.com/)에서 **Log & Crash Search** 서비스를 클릭합니다.
2. **네트워크 인사이트** 메뉴를 클릭합니다.
3. **URL 설정** 탭을 클릭합니다.
4. 측정하려는 URL을 입력하고 **추가** 버튼을 클릭합니다.
