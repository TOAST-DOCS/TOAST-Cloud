## NHN Cloud > SDK 사용 가이드 > Log & Crash > Unity

## Prerequisites

1. [Install the NHN Cloud SDK](./getting-started-unity)
2. [NHN Cloud 콘솔](https://console.nhncloud.com)에서 [Log & Crash Search를 활성화](https://docs.nhncloud.com/ko/Data%20&%20Analytics/Log%20&%20Crash%20Search/ko/console-guide/)합니다.
3. Log & Crash Search에서 [AppKey를 확인](https://docs.nhncloud.com/ko/Data%20&%20Analytics/Log%20&%20Crash%20Search/ko/console-guide/#appkey)합니다.
4. [NHN Cloud SDK를 초기화](./getting-started-unity#toast-sdk_1)합니다.

## 지원 플랫폼

- iOS
- Android
- Standalone
- WebGL

## Android 설정

### Gradle 빌드 설정

- Unity Editor에서, Build Settings 창을 엽니다. (Player Settings > Publishing Settings > Build).
- Build System 목록에서 Gradle을 선택합니다.
- Build System 하위의 체크 박스를 선택하여 Custom Gradle Template을 사용합니다.
- mainTemplate.gradle의 dependencies 항목에 아래 내용을 추가합니다.

```groovy
apply plugin: 'com.android.application'

repositories {
  mavenCentral()
}

dependencies {
	implementation fileTree(dir: 'libs', include: ['*.jar'])
    implementation 'com.nhncloud.android:nhncloud-unity-logger:1.7.0'
**DEPS**}
```

## iOS 설정

### Player Settings 설정

- Unity 의 iOS 빌드 설정에는 Logger 가 서버로 로그를 전송하는데 영향을 주는 몇가지 설정들이 있습니다.
- 이 설정들의 효과를 간략히 설명하고 Logger 의 권장 설정에 대해 설명합니다.

| 메뉴                             | 목록                          | 설정                       | 권장 설정     |
| -------------------------------- | ----------------------------- | -------------------------- | ------------- |
| Edit > Project Settings > Player | Debugging and crash reporting | On .Net UnhandledException | Silent Exit   |
| Edit > Project Settings > Player | Debugging and crash reporting | Enable CrashReport API     | Disabled      |
| Edit > Project Settings > Player | Other Settings                | Script Call Optimization   | Slow and Safe |

##### On .Net UnhandledException

- **Silent Exit** 값을 권장합니다.
  - On .Net UnhandledException를 Crash로 설정할 경우 예외 발생 시, 즉시 앱이 종료됩니다.
  - Silent Exit로 설정해야 Unity Exception을 캡처할 수 있습니다.

##### Enable CrashReport API

- **Disabled** 값을 권장합니다.
  - Unity CrashReporter API 활성화 여부를 표현하는 값입니다.
  - 활성화 되어있으면 Logger 의 크래시 로그 수집에 영향을 줄 수 있습니다.

##### Script Call Optimization

- **Slow and Safe** 값을 권장합니다.
  - Runtime C# Crash 로그를 수집하고자 하는 경우 Slow and Safe로 설정해야 합니다.

## NHN Cloud Logger 네임스페이스

```csharp
using Toast.Logger;
```

## NHN Cloud Logger SDK 초기화

Log & Crash Search에서 발급 받은 AppKey를 ProjectKey로 설정합니다.

```csharp
var loggerConfiguration = new ToastLoggerConfiguration
{
    ProjectKey = "YOUR_PROJECT_KEY"
};

ToastLogger.Initialize(loggerConfiguration);
```

## 로그 전송하기

NHN Cloud Logger는 5가지 레벨의 로그를 전송할 수 있습니다.
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
ToastLogger.Debug("NHN Cloud Log & Crash Search!", new Dictionary<string, string>
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

- 사용자 정의 필드는 "Log & Crash Search 콘솔" > "Log Search 탭"에 "선택한 필드"로 노출되는 값과 동일합니다.
- 동일한 키에 대해 값을 여러 번 변경하면, 최종으로 변경한 값이 적용됩니다.

#### 커스텀 필드 제약사항

- 이미 [예약된 필드](./log-collector-reserved-fields)는 사용할 수 없습니다.
- 필드명은 "A-Z, a-z"로 시작하고 "A-Z, a-z, 0-9, -, \_" 문자를 사용할 수 있습니다.
- 필드명 내에 공백은 "\_" 로 치환됩니다.

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

NHN Cloud Logger 에서는 유니티의 크래시를 크게 두 가지로 분류합니다.

- 네이티브 플랫폼에서 발생한 크래시 (앱이 강제 종료됨)
- 유니티에서 발생한 예기치 못한 예외와 LogException을 통해서 출력된 로그 (앱이 강제 종료되지 않음)

> **왜 LogException으로 출력된 로그도 크래시 로그로 수집하나요?**
> 써드파티 라이브러리 중에 LogException를 통해서 사용자 코드의 예외를 노출하는 경우가 더러 있기 때문입니다.
> 크래시 로그를 필터링 하고 싶다면 아래 **크래시 로그 필터링하기** 를 참고해주세요.

ToastLogger를 초기화하면 모바일 환경에서 크래시가 발생했을 경우, 혹은 유니티에서 예기치 못한 예외가 발생했을 경우, 자동으로 크래시 로그가 전송됩니다.
크래시 로그 전송을 비활성화하고 싶은 경우 아래와 같이 ToastLoggerConfiguration 객체의 EnableCrashReporter 프로퍼티를 false 로 설정하면 됩니다.
각 플랫폼별 크래시 로그에 대한 정보는 아래 링크를 확인하면 됩니다.

- [Android 크래시 로그 수집](./log-collector-android/#_7)
- [iOS 크래시 로그 수집](./log-collector-ios/#_5)

```csharp
var loggerConfiguration = new ToastLoggerConfiguration
{
    ProjectKey = "YOUR_PROJECT_KEY",
    EnableCrashReporter = false // 크래시 로그 비활성화
};
```

> User ID가 설정되어 있으면 Log&Crash Search 콘솔의 `크래시 사용자` 항목에서 사용자별 크래시 경험을 확인 할 수 있습니다.
> User ID 설정은 [시작하기](./getting-started-unity/#userid)에서 확인 가능합니다.

## 크래시 로그 전송 후 추가작업 진행하기

- 크래시 리스너를 등록하면 크래시 로그 전송 후 추가 작업을 진행할 수 있습니다.

> **유니티에서 예기치 못한 예외가 발생했을 경우에만 동작합니다.**
> 네이티브 플랫폼에서 발생한 크래시에 대한 리스너는 제공하지 않습니다.

### SetCrashListener API 명세

```csharp
public delegate void CrashListener(bool isSuccess, LogEntry logEntry);

public static void SetCrashListener(CrashListener listener);
```

### SetCrashListener API 사용 예

```csharp
ToastLogger.SetCrashListener((isSuccess, log) =>
{
    if (isSuccess)
    {
        Application.Quit();
    }
});
```

## 크래시 로그 필터링하기

- 유니티를 이용하다보면 수집을 원하지 않는 예외 로그 혹은 크래시 로그들이 수집될 수 있습니다.
- NHN Cloud Logger는 수집을 원하지 않는 크래시 로그를 필터링 하는 기능을 지원합니다.
  - 해당 기능은 유니티 예외에 한정된 기능입니다.

### AddCrashFilter API 명세

```csharp
public delegate bool CrashFilter(CrashLogData logData);

public class CrashLogData
{
    public LogType LogType { get; }

    public string Condition { get; }

    public string StackTrace { get; }
}

public static void AddCrashFilter(CrashFilter filter);
```

- CrashLogData의 프로퍼티들은 [Application.LogCallback의 매개변수와 동일](https://docs.unity3d.com/ScriptReference/Application.LogCallback.html)합니다.

### AddCrashFilter API 사용 예

```csharp
ToastLogger.AddCrashFilter(crashLogData => crashLogData.Condition.Contains("UnityEngine.Debug.Log"));
```

## Handled Exception 전송하기

NHN Cloud Logger는 일반/크래시 로그 뿐만 아니라, try/catch 구문에서 예외와 관련된 내용을 Report API를 사용하여 전송할 수 있습니다.
이렇게 전송한 예외 로그는 "Log & Crash Search 콘솔" > "App Crash Search 탭"의 오류 유형에서 "Handled"로 필터링하여 조회할 수 있습니다.
자세한 Log & Crash 콘솔 사용 방법은 [콘솔 사용 가이드](http://docs.nhncloud.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/)를 참고하세요.

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

> 콘솔을 통해 Network Insights 기능을 활성화하면 NHN Cloud Logger 초기화 시에, 콘솔에 등록한 URL로 1회 요청합니다.

### Network Insights 활성화

1. [NHN Cloud Console](https://console.nhncloud.com/) 에서 [Log & Crash Search] 서비스를 선택합니다.
2. [설정] 메뉴를 선택합니다.
3. [로그 전송 설정] 탭을 선택합니다.
4. "Network Insights 로그"를 활성화합니다.

### URL 설정

1. [NHN Cloud Console](https://console.nhncloud.com/) 에서 [Log & Crash Search] 서비스를 선택합니다.
2. [네트워크 인사이트] 메뉴를 선택합니다.
3. [URL 설정] 탭을 선택합니다.
4. 측정하고 자하는 URL을 입력 후 [추가] 버튼을 클릭합니다.
