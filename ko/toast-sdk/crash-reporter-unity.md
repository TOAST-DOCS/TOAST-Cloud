## TOAST > TOAST SDK 사용 가이드 > TOAST Crash Reporter > Unity

## Prerequisites

TOAST Crash SDK는 [TOAST Logger](./log-collector-unity)를 사용하여 크래시 정보를 Log&Crash Search 수집 서버로 전송합니다.

1\. [Install the TOAST SDK](./getting-started-unity)
2\. [TOAST 콘솔](https://console.cloud.toast.com)에서 [Log&Crash Search를 활성화](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/)합니다.
3\. Log&Crash Search에서 [AppKey를 확인](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/#appkey)합니다.
4\. [TOAST Logger를 초기화](./log-collector-unity#initialize)합니다.

## Initialize

ToastCrash를 초기화합니다. 
ToastCrash는 ToastLogger에 의존하고 있습니다. ToastLogger의 초기화를 먼저 해주세요.
초기화를 하면 크래시 발생 시 크래시 정보가 OS 별(Android, iOS)로 수집됩니다.

```csharp
ToastLogger.Initialize("YOUR_PROJECT_KEY", "YOUR_PROJECT_VERSION");
ToastCrash.Initialize();
```

## Send Handled Exception

TOAST Crash는 5가지 레벨의 Handled 예외 정보를 전송할 수 있습니다.

```csharp
try
{
    doSomething();
}catch(Exception e)
{
    // Debug, Info, Warn, Error, Fatal 등을 사용할 수 있습니다.
    ToastCrash.Debug("YOUR_MESSAGE", exception);
    // ToastCrash.Info("YOUR_MESSAGE", exception);
    // ToastCrash.Warn("YOUR_MESSAGE", exception);
    // ToastCrash.Error("YOUR_MESSAGE", exception);
    // ToastCrash.Fatal("YOUR_MESSAGE", exception);
}
```

### Send using Application.logMessageReceived

- 사용자가 [Application.logMessageReceived](https://docs.unity3d.com/ScriptReference/Application-logMessageReceived.html)을 구현하면, Debug.LogException 을 이용해서 예외 로그를 전송할 수 있습니다.
- **TOAST SDK에서는 Exception 레벨의 로그만 서버로 전송하는 것을 권장합니다.**
- **Application.logMessageReceived 이벤트 등록 시 구현에 따라 과도한 로그 전송이 발생할 수도 있습니다. 사용에 주의가 필요합니다.**

```csharp
public class MainController : MonoBehaviour
{
    void Awake()
    {
        Application.logMessageReceived += (condition, trace, type) =>
        {
            switch (type)
            {
                case LogType.Exception:
                    ToastCrash.Report(ToastCrash.LogLevel.Error, "Catch in callback", condition, trace);
                    break;
            }
        };
    }
}
```

## Set User Field

사용자가 원하는 필드를 설정합니다.
설정된 사용자 필드는 Log&Crash Search에서 조회할 수 있습니다.

```csharp
ToastCrash.SetUserField("YOUR_CUSTOM_KEY", "YOUR_CUSTOM_VALUE");
```

> 이미 예약된 필드는 사용할 수 없습니다.
> 필드명은 "A-Z, a-z"로 시작하고 "A-Z, a-z, 0-9, -, _" 문자를 사용할 수 있습니다.
> 필드명 내에 공백은 "\_" 로 치환됩니다.

