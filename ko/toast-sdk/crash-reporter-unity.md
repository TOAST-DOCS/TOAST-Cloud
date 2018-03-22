## TOAST > TOAST SDK 사용 가이드 > TOAST Crash Reporter > Unity

## Prerequisites

TOAST Crash SDK는 [TOAST Logger](./log-collector-unity)를 사용하여 크래시 정보를 Log & Crash Search 수집 서버로 전송합니다.

1\. [Install the TOAST SDK](./getting-started-unity)
2\. [TOAST 콘솔](https://console.cloud.toast.com)에서 [Log & Crash Search를 활성화](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/)합니다.
3\. Log & Crash Search에서 [AppKey를 확인](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/#appkey)합니다.
4\. [TOAST Logger를 초기화](./log-collector-unity#toast-logger-sdk)합니다.

> 주의 : TOAST Crash SDK 기능을 사용하기 위해서는 TOAST Logger 초기화가 선행되어야 합니다.

## TOAST Crash SDK 초기화

ToastCrash를 초기화합니다. 
초기화를 하면 크래시 발생 시 크래시 정보가 OS 별(Android, iOS)로 수집됩니다.

> 주의 : TOAST Crash SDK 기능을 사용하기 위해서는 TOAST Logger 초기화가 선행되어야 합니다.
[TOAST Logger 초기화 안내](./log-collector-unity#toast-logger-sdk)를 확인하세요.

```csharp
ToastCrash.Initialize();
```

## Handled Exception 전송하기

TOAST Crash는 5가지 레벨의 예외(Handled Exception) 로그를 전송할 수 있습니다. Unity 플랫폼의 경우 try/catch 구문에서 예외와 관련된 내용을 TOAST Crash SDK의 Handled Exception API를 사용하여 전송할 수 있습니다. 
이렇게 전송한 예외 로그는 "Log & Crash Search 콘솔" > "App Crash Search 탭"의 오류 유형에서 Handled로 필터링하여 조회할 수 있습니다. 
자세한 Log & Crash 콘솔 사용 방법은 [콘솔 사용 가이드](http://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/)를 참고하세요.

### Handled Exception Log API 명세

```csharp
// DEBUG 레벨 로그
ToastCrash.Debug(message, exception);

// INFO 레벨 로그
ToastCrash.Info(message, exception);

// WARN 레벨 로그
ToastCrash.Warn(message, exception);

// ERROR 레벨 로그
ToastCrash.Error(message, exception);

// FATAL 레벨 로그
ToastCrash.Fatal(message, exception);
```

### Handled Exception Log API 사용 예

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

## 크래시 발생 시 전송하는 사용자 정의 필드 설정하기

크래시 발생 시 추가 정보 전달을 위해 사용자 정의 필드를 사용할 수 있습니다. setUserField API는 크래시 발생 시점과 상관없이 키 밸류 형태의 추가 정보를 설정할 수 있고, 설정한 추가 정보는 크래시 발생 시에 Log & Crash Search로 서버로 전송합니다.

### 사용자 정의 필드 설정 API 명세

```csharp
ToastCrash.SetUserField(userFieldKey, userFieldValue);
```

*  "field"는 "Log & Crash Search 콘솔" > "Log Search 탭"에 "선택한 필드"로 노출되는 값과 동일합니다. 
즉, Log & Crash Search의 커스텀 파라미터와 동일한 것으로 "field"값의 상세한 제약 사항은 [커스텀 필드의 제약사항](http://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/api-guide/)에서 확인할 수 있습니다.
* 동일한 키에 대해 값을 여러 번 변경하면, 최종으로 변경한 값이 적용됩니다.

#### 커스텀 필드 제약사항

* 이미 예약된 필드는 사용할 수 없습니다. 예약된 필드는 [커스텀 필드의 제약사항](http://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/api-guide/) 항목의 "기본 파라미터"를 확인하세요.
* 필드명은 "A-Z, a-z"로 시작하고 "A-Z, a-z, 0-9, -, _" 문자를 사용할 수 있습니다.
* 필드명 내에 공백은 "\_"로 치환됩니다.

### 사용자 정의 필드 설정 API 사용 예

```csharp
ToastCrash.SetUserField("GameObject", gameObject.name);
```

### (참고) Unity Log 이벤트 등록하기

- 사용자가 [Application.logMessageReceived](https://docs.unity3d.com/ScriptReference/Application-logMessageReceived.html) 에 이벤트를 등록하면, Debug.LogException 을 이용해서 예외 로그를 전송할 수 있습니다.
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