## Analytics > Log & Crash Search > TOAST SDK 사용 가이드 > Unity

## Prerequisites

1. [TOAST 콘솔](https://console.toast.com)에서 [Log&Crash Search를 활성화](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/)합니다.

2. Log & Crash Search에서 [AppKey를 확인](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/#appkey)합니다.

## Component SDKs



## Getting Started Unity SDK



### Add TOAST SDK to Your Project

최신의 Unity Plugin을 다운로드 합니다. Unity Plugin은 아래와 같이 구성되어 있습니다.

| 아이템 | 내용 |
| --- | --- |
| Plugins/Android | Android 플러그인 입니다. |
| Plugins/iOS | iOS 플러그인 입니다. |
| Toast/Script | 초기화와 TOAST SDK를 호출하는 C# 스크립트 입니다. |
| Toast/Demo | 샘플 앱 입니다. |

프로젝트에 TOAST SDK를 사용하려는 경우 몇 가지 기본적인 작업을 수행하여 Unity 프로젝트에 적용합니다.

다운로드 받은 "toast-unity-sdk.unitypackage"를 더블 클릭하여 프로젝트에 포함합니다.

![import_unitypackage](http://static.toastoven.net/toastcloud/sdk/unity/unity_setup_import_unitypackage.png)

### Initialize TOAST SDK

1. Adding the TOAST SDK Component

* 유니티 에디터에서, 새로운 GameObject를 생성합니다.
* GameObject의 이름을 "TOAST SDK Initializer"로 변경합니다.
* TOAST SDK Initializer를 선택하고, Hierarchy 창에서 Add Component를 눌러 "ToastSDK" 스크립트를 추가합니다.

![toast_sdk_initializer](http://static.toastoven.net/toastcloud/sdk/unity/unity_setup_toast_sdk_initializer.png)

2. initializing TOAST SDK

* ToastSDK 스크립트에 ProjectKey와 ProjectVersion을 입력합니다.

![input_project_settings](http://static.toastoven.net/toastcloud/sdk/unity/unity_setup_input_project_settings.png)

3. Configure Unity Build and Player Settings



## Log Collector

### Initialize

Log & Crash Search에서 발급 받은 AppKey를 ProjectKey로 설정합니다.

```cs
// Initialize Logger
ToastLoggerConfiguration configuration = ScriptableObject.CreateInstance<ToastLoggerConfiguration> ();
configuration.setProjectKey (YOUR_PROJECT_KEY);
configuration.setProjectVersion (YOUR_PROJECT_VERSION);

ToastLogger.initialize (configuration);
```

### Send Log

TOAST Logger는 5가지 레벨의 로그 전송 함수를 제공합니다.

```cs
// DEBUG 레벨 로그
ToastLogger.debug(tag, message);

// INFO 레벨 로그
ToastLogger.info(tag, message);

// WARN 레벨 로그
ToastLogger.warn(tag, message);

// ERROR 레벨 로그
ToastLogger.error(tag, message);

// FATAL 레벨 로그
ToastLogger.fatal(tag, message);
```

### Set UserID

사용자 아이디를 설정합니다.
설정된 사용자 아이디는 "UserID" 필드로 Log&Crash Search에서 조회할 수 있습니다.

```cs
ToastLogger.setUserId(userId);
```

### Set User Field

사용자가 원하는 필드를 설정합니다.

```cs
ToastLogger.setUserField("UserField", "UserValue");
```

> 이미 예약된 필드는 사용할 수 없습니다.
> 필드명은 "A-Z, a-z"로 시작하고 "A-Z, a-z, 0-9, -, _" 문자를 사용할 수 있습니다.
> 필드명 내에 공백은 "\_" 로 치환됩니다.

## Crash Reporter

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

#### Using

```cs
try {
    // User Codes...
} catch {
    ToastCrash.fatal(TAG, "Handled Exception", stackTrace);
}
```

#### Application.RegisterLogCallback을 통한 로그 수집

* 사용자가 [Application.RegisterLogCallback](https://docs.unity3d.com/ScriptReference/Application.LogCallback.html)을 구현하면, ToastCrash.crashReporter 함수를 사용하여 C# 오류를 서버로 전송 합니다.

* TOAST SDK에서는 Exception과 Assert 레벨의 오류를 서버로 전송하는 것을 권장합니다.

* UnityEngineDebugLogFilter는 UnityEngine.Debug 클래스를 통해 발생한 로그를 필터링 합니다. TOAST SDK에서는 UnityEngine.Debug 로그는 필터링 하는 것을 권장합니다.

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
> 필드명은 "A-Z, a-z"로 시작하고 "A-Z, a-z, 0-9, -, _" 문자를 사용할 수 있습니다.
> 필드명 내에 공백은 "\_" 로 치환됩니다.


