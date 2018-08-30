## TOAST > TOAST SDK 사용 가이드 > TOAST Logger > Unity

## Prerequisites

1\. [Install the TOAST SDK](./getting-started-unity)
2\. [TOAST 콘솔](https://console.cloud.toast.com)에서 [Log & Crash Search를 활성화](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/)합니다.
3\. Log & Crash Search에서 [AppKey를 확인](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/#appkey)합니다.

## TOAST Logger SDK 초기화

Log & Crash Search에서 발급받은 AppKey를 ProjectKey로 설정합니다.
크래시 정보를 Log & Crash Search 웹콘솔에서 분석하기 위해서는 ToastLoggerConfiguration의 EnableCrashReporter를 true로 설정합니다.

```csharp
ToastLogger.Initialize("YOUR_PROJECT_KEY", "YOUR_PROJECT_VERSION");

var loggerConfiguration = new ToastLoggerConfiguration();
loggerConfiguration.ProjectKey = "YOUR_PROJECT_KEY";
loggerConfiguration.EnableCrashReporter = true;

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

사용자 정의 원하는 필드를 설정합니다. 
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