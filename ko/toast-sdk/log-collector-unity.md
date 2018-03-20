## TOAST > TOAST SDK 사용 가이드 > Log Collector > Unity

## Prerequisites

1\. [Install the TOAST SDK](./getting-started-unity)
2\. [TOAST 콘솔](https://console.cloud.toast.com)에서 [Log&Crash Search를 활성화](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/)합니다.
3\. Log&Crash Search에서 [AppKey를 확인](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/#appkey)합니다.

## Initialize

Log&Crash Search에서 발급받은 AppKey를 ProjectKey로 설정합니다.

```csharp
ToastLogger.Initialize("YOUR_PROJECT_KEY", "YOUR_PROJECT_VERSION");
```

## Send Log

TOAST Logger는 5가지 레벨의 로그를 전송할 수 있습니다. 
사용자 필드를 추가해서 보낼 수도 있습니다.

```csharp
// Debug, Info, Warn, Error, Fatal 등을 사용할 수 있습니다.
ToastLogger.Debug("YOUR_MESSAGE");
ToastLogger.Info("YOUR_MESSAGE");
ToastLogger.Warn("YOUR_MESSAGE");
ToastLogger.Error("YOUR_MESSAGE");
ToastLogger.Fatal("YOUR_MESSAGE");

// 사용자 필드 추가해서 로그 전송 (1)
ToastLogger.Debug("YOUR_MESSAGE", new Dictionary<string, string>
{
    { "YOUR_CUSTOM_KEY", "YOUR_CUSTOM_VALUE" }
});

// 사용자 필드 추가해서 로그 전송 (2)
var userFields = new Dictionary<string, string>();
userFields.Add("YOUR_CUSTOM_KEY", "YOUR_CUSTOM_VALUE");
ToastLogger.Debug("YOUR_MESSAGE", userFields);
```

## Set UserID 

사용자 아이디를 가져오거나 설정할 수 있습니다.
설정된 사용자 아이디는 "UserID" 필드로 Log&Crash Search에서 조회할 수 있습니다.

```csharp
ToastLogger.UserId = "USER_ID";
```

## Set User Field

사용자가 원하는 필드를 설정합니다.

```csharp
ToastLogger.SetUserField("YOUR_CUSTOM_KEY", "YOUR_CUSTOM_VALUE");
```

> 이미 예약된 필드는 사용할 수 없습니다.
> 필드명은 "A-Z, a-z"로 시작하고 "A-Z, a-z, 0-9, -, _" 문자를 사용할 수 있습니다.
> 필드명 내에 공백은 "\_" 로 치환됩니다.

## Using the Other Service

* [Crash Reporter > Unity](./crash-reporter-unity) 사용 가이드

