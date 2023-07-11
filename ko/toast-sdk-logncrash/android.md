## Analytics > Log & Crash Search > TOAST SDK 사용 가이드 > Android

## Prerequisites

1. [TOAST 콘솔](https://console.toast.com)에서 [Log&Crash Search를 활성화](https://nhncloud.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/)합니다.

2. Log & Crash Search에서 [AppKey를 확인](https://nhncloud.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/#appkey)합니다.

## Component SDKs

Android용 TOAST SDK는 다음과 같은 SDK로 구성되어 있습니다.

* [TOAST Logger](#log-collector) SDK
* [TOAST Crash](#crash-reporter) SDK

전체 TOAST SDK 기능이 필요하지 않은 경우 앱에 필요한 SDK만 사용할 수 있습니다.

| Gradle Dependency | Service |
| --- | --- |
| com.toast.android:toast-logger:1.0.0 | Log Collection |
| com.toast.android:toast-crash:1.0.0 | Crash Reporter |

## Getting Started Android SDK

### Environments

* Android 4.0.3 이상
* Android Studio 최신 버전 (버전 2.2 이상)

### Add TOAST SDK to Your Project

프로젝트에 TOAST SDK를 사용하려는 경우 몇 가지 기본적인 작업을 수행하여 Android Studio 프로젝트를 준비해야 합니다.

build.gradle 파일에 TOAST SDK에 대한 종속성을 추가합니다.

```groovy
dependencies {
  // ...
  compile 'com.toast.android:toast-sdk:1.0.0'
  // ...
}
```

### Intiailize TOAST SDK

TOAST SDK의 다양한 상품을 사용하기 위해서는 Application#onCreate에 TOAST SDK를 초기화해야 합니다.

```java
public class YourApplication extends Application {
    @Override
    public void onCreate() {
        super.onCreate();
        // ...

        // Initialize TOAST SDK
        ToastSdk.initialize(getApplicationContext());
    }
}
```

## Log Collector

### Initialize

onCreate() 메소드에서 Logger를 초기화합니다.
Log & Crash Search에서 발급 받은 AppKey를 ProjectKey로 설정합니다.

```java
// Initialize Logger
ToastLoggerConfiguration loggerConfiguration = new ToastLoggerConfiguration.Builder()
        .setProjectKey(YOUR_PROJECT_KEY)            // Log & Crash Search AppKey
        .setProjectVersion(YOUR_PROJECT_VERSION)    // App Version
        .build();

ToastLogger.initialize(loggerConfiguration);
```

### Send Log

TOAST Logger는 5가지 레벨의 로그 전송 함수를 제공합니다.

```java
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

```java
ToastLogger.setUserId(userId);
```

### Set User Field

사용자가 원하는 필드를 설정합니다.

```java
ToastLogger.setUserField("UserField", "UserValue");
```

> 이미 예약된 필드는 사용할 수 없습니다.
> 필드명은 "A-Z, a-z"로 시작하고 "A-Z, a-z, 0-9, -, _" 문자를 사용할 수 있습니다.
> 필드명 내에 공백은 "\_" 로 치환됩니다.

### Log Callback

로그를 전송 후 전송 결과를 Callback을 통해 확인할 수 있습니다.

```java
ToastLogger.setListener(new ToastLoggerListener() {
    @Override
    public void onSuccess(LogObject log) {
        // 로그 전송에 성공하였습니다.
    }

    @Override
    public void onFiltered(LogObject log, LogFilter filter) {
        // 로그 필터에 의해 로그가 필터링되었습니다.
    }

    @Override
    public void onSaved(LogObject log) {
        // 네트워크 차단으로 로그가 저장되었습니다.
    }

    @Override
    public void onError(LogObject log, int errorCode, String errorMessage) {
        // 전송에 실패하였습니다.
    }
});
```

## Crash Reporter

### Initialize

onCreate() 메소드에서 ToastCrash를 초기화합니다.

```java
// Initialize Crash
ToastCrash.initialize();
```

### Send Handled Exception

TOAST Crash는 5가지 레벨의 예외 정보를 전송할 수 있습니다.

```java
// DEBUG 레벨의 예외 정보 전송
ToastCrash.debug(tag, message, throwable);

// INFO 레벨의 예외 정보 전송
ToastCrash.info(tag, message, throwable);

// WARN 레벨의 예외 정보 전송
ToastCrash.warn(tag, message, throwable);

// ERROR 레벨의 예외 정보 전송
ToastCrash.error(tag, message, throwable);

// FATAL 레벨의 예외 정보 전송
ToastCrash.fatal(tag, message, throwable);
```

#### Using

```java
try {
    // User Codes...
} catch (Exception e) {
    ToastCrash.debug(TAG, "Handled Exception", e);
}
```

### Set User Field

사용자가 원하는 필드를 설정합니다.

```java
ToastCrash.setUserField("UserField", "UserValue");
```

> 이미 예약된 필드는 사용할 수 없습니다.
> 필드명은 "A-Z, a-z"로 시작하고 "A-Z, a-z, 0-9, -, _" 문자를 사용할 수 있습니다.
> 필드명 내에 공백은 "\_" 로 치환됩니다.

### Set Data Adapter

크래시 발생 시 추가 정보를 설정할 수 있습니다.

```java
ToastCrash.setDataAdapter(new CrashDataAdapter() {
    @Override
    public Map<String, Object> getUserFields() {
        Map<String, Object> userFields = new HashMap<>();
        userFields.put("UserField", "UserValue");
        return userFields;
    }
});
```

### Crash Callback

크래시 정보를 전송 후 전송 결과를 Callback을 통해 확인할 수 있습니다.

```java
ToastCrash.setListener(new CrashListener() {
    @Override
    public void onSuccess(LogObject log) {
        // 크래시 정보 전송에 성공하였습니다.
    }

    @Override
    public void onFiltered(LogObject log, LogFilter filter) {
        // 로그 필터에 의해 크래시 정보가 필터링되었습니다.
    }

    @Override
    public void onSaved(LogObject log) {
        // 네트워크 차단으로 크래시 정보가 저장되었습니다.
    }

    @Override
    public void onError(LogObject log, int errorCode, String errorMessage) {
        // 전송에 실패하였습니다.
    }
});
```
