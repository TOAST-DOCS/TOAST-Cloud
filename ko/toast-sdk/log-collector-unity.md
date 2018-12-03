## TOAST > TOAST SDK 사용 가이드 > TOAST Log & Crash > Unity

## Prerequisites

1\. [Install the TOAST SDK](./getting-started-unity)
2\. [TOAST 콘솔](https://console.cloud.toast.com)에서 [Log & Crash Search를 활성화](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/)합니다.
3\. Log & Crash Search에서 [AppKey를 확인](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/#appkey)합니다.
4\. [TOAST SDK를 초기화](./getting-started-unity#toast-sdk_1)합니다.

### mainTemplate.gradle 설정 방법
- mainTemplate.gradle의 dependencies 항목에 아래 내용을 추가합니다.

```groovy
dependencies {
    if (GradleVersion.current() >= GradleVersion.version("4.2")) {
        implementation 'com.toast.android:toast-unity-logger:0.12.0'
    } else {
        compile 'com.toast.android:toast-unity-logger:0.12.0'
    }
}
```

## TOAST Logger SDK 초기화

Log & Crash Search에서 발급받은 AppKey를 ProjectKey로 설정합니다.

```csharp
var loggerConfiguration = new ToastLoggerConfiguration
{
    ProjectKey = "YOUR_PROJECT_KEY"
};

ToastLogger.Initialize(loggerConfiguration);
```

## 로그 전송하기

TOAST Logger는 5가지 레벨의 로그를 전송할 수 있습니다. 
사용자 필드를 추가해서 보낼 수도 있습니다.

### 로그 전송 API 명세

```csharp
// DEBUG 레벨 로그
ToastLogger.Debug(message);
ToastLogger.Debug(message, userFields);

// INFO 레벨 로그
ToastLogger.Info(message);
ToastLogger.Info(message, userFields);

// WARN 레벨 로그
ToastLogger.Warn(message);
ToastLogger.Warn(message, userFields);

// ERROR 레벨 로그
ToastLogger.Error(message);
ToastLogger.Error(message, userFields);

// FATAL 레벨 로그
ToastLogger.Fatal(message);
ToastLogger.Fatal(message, userFields);
```

### 로그 전송 API 사용 예

```csharp
ToastLogger.Debug("TOAST Log & Crash Search!", new Dictionary<string, string>
{
    { "Scene", "Main" }
});
```

## 사용자 정의 필드 설정하기

원하는 사용자 정의 필드를 설정합니다. 
사용자 정의 필드를 설정하면 로그 전송 API를 호출할 때마다 설정한 값을 로그와 함께 서버로 전송합니다.

### 사용자 정의 필드 설정 API 명세
```csharp
ToastLogger.SetUserField(userField, userValue);
```

*  사용자 정의 필드는 "Log & Crash Search 콘솔" > "Log Search 탭"에 "선택한 필드"로 노출되는 값과 동일합니다. 
즉, Log & Crash Search의 커스텀 파라미터와 동일한 것으로 "field"값의 상세한 제약 사항은 [커스텀 필드의 제약사항](http://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/api-guide/)에서 확인할 수 있습니다.
* 동일한 키에 대해 값을 여러 번 변경하면, 최종으로 변경한 값이 적용됩니다.

#### 커스텀 필드 제약사항
* 이미 [예약된 필드](./log-collector-reserved-fields)는 사용할 수 없습니다. 예약된 필드는 [커스텀 필드의 제약사항](http://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/api-guide/) 항목의 "기본 파라미터"를 확인하세요.
* 필드명은 "A-Z, a-z"로 시작하고 "A-Z, a-z, 0-9, -, _" 문자를 사용할 수 있습니다.
* 필드명 내에 공백은 "\_" 로 치환됩니다.

### 사용자 정의 필드 설정 API 사용 예
```csharp
ToastLogger.SetUserField("GameObject", gameObject.name);
```

## 로그 전송 후 추가작업 진행하기
- 리스너를 등록하면 로그 전송 후 추가 작업을 진행할 수 있습니다.

### SetLoggerListener API 명세

```csharp
public interface IToastLoggerListener
{
    void OnSuccess(LogEntry log);
    void OnFilter(LogEntry log, LogFilter filter);
    void OnSave(LogEntry log);
    void OnError(LogEntry log, string errorMessage);
}

static void SetLoggerListener(IToastLoggerListener listener);
```

### SetLoggerListener 사용 예

```csharp
public class SampleLoggerListener : IToastLoggerListener
{
    public void OnSuccess(LogEntry log)
    {
        // 로그 전송 성공시 처리
    }

    public void OnFilter(LogEntry log, LogFilter filter)
    {
        // 로그 필터링시 처리
    }

    public void OnSave(LogEntry log)
    {
        // 네트워크 단절 등으로 인한 실패시 로그 재전송을 위해 파일에 저장되었을 경우
    }

    public void OnError(LogEntry log, string errorMessage)
    {
        // 로그 전송 실패시 처리
    }
}

ToastLogger.SetLoggerListener(new SampleLoggerListener());
```

## 크래시 로그 수집

ToastLogger를 초기화하면 모바일 환경에서 크래시가 발생했을 경우, 자동으로 크래시 로그가 전송됩니다.
크래시 로그 전송을 비활성화하고 싶은 경우 아래와 같이 ToastLoggerConfiguration 객체의 EnableCrashReporter 프로퍼티를 false 로 설정하면 됩니다.
각 플랫폼별 크래시 로그에 대한 정보는 아래 링크를 확인하면 됩니다.

- [Android 크래시 로그 수집](./log-collector-android/#_5)
- [iOS 크래시 로그 수집](./log-collector-ios/#_5)

```csharp
var loggerConfiguration = new ToastLoggerConfiguration
{
    ProjectKey = "YOUR_PROJECT_KEY",
    EnableCrashReporter = false // 크래시 로그 비활성화
};
```

## Handled Exception 전송하기

TOAST Logger는 일반/크래시 로그 뿐만 아니라, try/catch 구문에서 예외와 관련된 내용을 Report API를 사용하여 전송할 수 있습니다.
이렇게 전송한 예외 로그는 "Log & Crash Search 콘솔" > "App Crash Search 탭"의 오류 유형에서 "Handled"로 필터링하여 조회할 수 있습니다. 
자세한 Log & Crash 콘솔 사용 방법은 [콘솔 사용 가이드](http://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/)를 참고하세요.

### Handled Exception Log API 명세

```csharp
// Handled Exception 로그 전송
var logLevel = ToastLogLevel.ERROR;
ToastLogger.Report(logLevel, message, exception);
```

### Handled Exception Log API 사용 예

```csharp
try
{
    doSomethingWrong();
}catch(Exception e)
{
    // Debug, Info, Warn, Error, Fatal 등을 사용할 수 있습니다.
    ToastLogger.Report(ToastLogLevel.ERROR, "YOUR_MESSAGE", exception);
}
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