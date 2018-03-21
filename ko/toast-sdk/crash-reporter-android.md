## TOAST > TOAST SDK 사용 가이드 > Crash Reporter > Android

## Prerequisites

TOAST Crash SDK는 [TOAST Logger](./log-collector-android)를 사용하여 크래시 정보를 Log&Crash Search 수집 서버로 전송합니다.

1\. [Install the TOAST SDK](./getting-started-android)
2\. [TOAST 콘솔](https://console.cloud.toast.com)에서 [Log&Crash Search를 활성화](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/)합니다.
3\. Log&Crash Search에서 [AppKey를 확인](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/#appkey)합니다.
4\. [TOAST Logger를 초기화](./log-collector-android#initialize)합니다.

## Initialize

onCreate() 메소드에서 ToastCrash를 초기화합니다.

```java
// Initialize Crash
ToastCrash.initialize();
```

## Send Handled Exception

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

### Using

```java
try {
    // User Codes...
} catch (Exception e) {
    ToastCrash.debug(TAG, "Handled Exception", e);
}
```

## Set User Field

사용자가 원하는 필드를 설정합니다.

```java
ToastCrash.setUserField("UserField", "UserValue");
```

> 이미 예약된 필드는 사용할 수 없습니다.
> 필드명은 "A-Z, a-z"로 시작하고 "A-Z, a-z, 0-9, -, _" 문자를 사용할 수 있습니다.
> 필드명 내에 공백은 "\_" 로 치환됩니다.

## Set Data Adapter

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

## Crash Callback

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

