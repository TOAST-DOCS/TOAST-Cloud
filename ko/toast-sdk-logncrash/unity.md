## Analytics > Log & Crash Search > TOAST SDK 사용 가이드 > Unity

## Prerequisites

1\. [TOAST 콘솔](https://console.cloud.toast.com)에서 [Log&Crash Search를 활성화](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/)합니다.

2\. Log & Crash Search에서 [AppKey를 확인](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/#appkey)합니다.

## Component SDKs

Unity용 TOAST SDK는 다음과 같은 SDK로 구성되어 있습니다.

* [TOAST Logger](#log-collector) SDK
* [TOAST Crash](#crash-reporter) SDK

전체 TOAST SDK 기능이 필요하지 않은 경우 앱에 필요한 SDK만 사용할 수 있습니다.

| Unity Package | Service |
| --- | --- |
|  | Log Collection |
|  | Crash Reporter |

## Getting Started Unity SDK

### Environments

* Android 4.0.3 이상
* iOS 8.0 이상
* Unity 5.3.4 이상

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

1\. Adding the TOAST SDK Component

* 유니티 에디터에서, 새로운 GameObject를 생성합니다.
* GameObject의 이름을 "TOAST SDK Initializer"로 변경합니다.
* TOAST SDK Initializer를 선택하고, Hierarchy 창에서 Add Component를 눌러 "ToastSDK" 스크립트를 추가합니다.

![toast_sdk_initializer](http://static.toastoven.net/toastcloud/sdk/unity/unity_setup_toast_sdk_initializer.png)

2\. initializing TOAST SDK

* ToastSDK 스크립트에 ProjectKey와 ProjectVersion을 입력합니다.

![input_project_settings](http://static.toastoven.net/toastcloud/sdk/unity/unity_setup_input_project_settings.png)

3\. Configure Unity Build and Player Settings

* Unity에는 TOAST SDK가 서버로 로그를 전송하는데 영향을 주는 몇가지 설정들이 있습니다.
* 이 설정들의 효과를 간략히 설명하고 TOAST SDK의 권장 설정에 대해 설명합니다.

| 목록 | 설정 | 권장 설정 |
| --- | --- | ----- |
| Build Settings | Script Debugging | OFF |
| Player Settings > Debugging and crash reporting | On .Net UnhandledException | Silent Exit |
| Player Settings > Debugging and crash reporting | Enable CrashReport API | Disabled |
| Player Settings > Other Settings | Script Call Optimization | Slow and Safe |

#### Script Debugging

* Crash의 StackTrace에서 Crash가 발생한 LineNumber를 가져옴니다. Release의 경우 OFF로 설정합니다.

#### On .Net UnhandledException

* On .Net UnhandledException를 Crash로 설정할 경우 예외 발생 시, 즉시 앱이 종료됩니다. 
* Silent Exit로 설정해야 Unity Exceptoin을 캡처할 수 있습니다.

#### Enable CrashReport API

* Unity CrashReporter API를 활성화 합니다. Toast Crash SDK를 사용하는 경우 Disabled로 설정합니다.

#### Script Call Optimization

* Runtime C# Crash 로그를 수집하고자 하는 경우 Slow and Safe로 설정해야 합니다.

## Log Collector

### Initialize

Log & Crash Search에서 발급받은 AppKey를 ProjectKey로 설정합니다.

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
설정된 사용자 아이디는 "UserID" 필드로 Log & Crash Search에서 조회할 수 있습니다.

```cs
ToastLogger.setUserId(userId);
```

### Set User Field

사용자가 원하는 필드를 설정합니다.

```cs
ToastLogger.setUserField("UserField", "UserValue");
```

> 이미 예약된 필드는 사용할 수 없습니다.

### Log Callback

로그를 전송 후 전송 결과를 Callback을 통해 확인할 수 있습니다.

```cs
void Start() {
    ToastLogger.initialize (consoleConfig);
}

void OnEnable () {
    ToastLogger.StartListening ("onSuccess", onSuccessFunction);
    ToastLogger.StartListening ("onFiltered", onSavedFunction);
    ToastLogger.StartListening ("onFiltered", onFilteredFunction);
    ToastLogger.StartListening ("onError", onErrorFunction);
}

void OnDisable () {
    ToastLogger.StopListening ("onSuccess", onSuccessFunction);
    ToastLogger.StopListening ("onFiltered", onSavedFunction);
    ToastLogger.StopListening ("onFiltered", onFilteredFunction);
    ToastLogger.StopListening ("onError", onErrorFunction);
}

void onSuccessFunction(ToastLogResult result){
    // 로그 전송에 성공하였습니다.
}

void onSavedFunction(ToastLogResult result){
    // 네트워크 차단으로 로그가 저장되었습니다.
}

void onFilteredFunction(ToastLogResult result){
   // 로그 필터에 의해 로그가 필터링되었습니다.
}

void onErrorFunction(ToastLogResult result){
     // 전송에 실패하였습니다.
}
```

## Crash Reporter

### Initialize

### Send Handled Exception

TOAST Crash는 5가지 레벨의 예외 정보를 전송할 수 있습니다.

```cs

```

#### Using

```cs

```

### Set User Field

사용자가 원하는 필드를 설정합니다.

```cs
```

> 이미 예약된 필드는 사용할 수 없습니다.

