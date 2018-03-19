## TOAST > TOAST SDK 사용 가이드 > Log Collector > Android

## Prerequisites

1\. [Install the TOAST SDK](./getting-started-android)
2\. [TOAST 콘솔](https://console.cloud.toast.com)에서 [Log&Crash Search를 활성화](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/)합니다.
3\. Log & Crash Search에서 [AppKey를 확인](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/#appkey)합니다.

## Initialize

onCreate() 메소드에서 Logger를 초기화합니다.
Log & Crash Search에서 발급받은 AppKey를 ProjectKey로 설정합니다.

```java
// Initialize Logger
ToastLoggerConfiguration loggerConfiguration = new ToastLoggerConfiguration.Builder()
        .setProjectKey(YOUR_PROJECT_KEY)            // Log & Crash Search AppKey
        .setProjectVersion(YOUR_PROJECT_VERSION)    // App Version
        .build();

ToastLogger.initialize(loggerConfiguration);
```

## Send Log

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

## Set UserID 

사용자 아이디를 설정합니다.
설정된 사용자 아이디는 "UserID" 필드로 Log & Crash Search에서 조회할 수 있습니다.

```java
ToastLogger.setUserId(userId);
```

## Set User Field

사용자가 원하는 필드를 설정합니다.

```java
ToastLogger.setUserField("UserField", "UserValue");
```

> 이미 예약된 필드는 사용할 수 없습니다.
> 필드명은 "A-Z, a-z"로 시작하고 "A-Z, a-z, 0-9, -, _" 문자를 사용할 수 있습니다.
> 필드명 내에 공백은 "\_" 로 치환됩니다.

## Log Callback

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


## Using The Other Service

* [Crash Reporter > Android](./crash-reporter-android) 사용 가이드

