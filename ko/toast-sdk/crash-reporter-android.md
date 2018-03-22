## TOAST > TOAST SDK 사용 가이드 > TOAST Crash Reporter > Android

## Prerequisites

TOAST Crash SDK는 [TOAST Logger](./log-collector-android)를 사용하여 크래시 정보를 Log&Crash Search 수집 서버로 전송합니다.

1\. [Install the TOAST SDK](./getting-started-android)
2\. [TOAST 콘솔](https://console.cloud.toast.com)에서 [Log&Crash Search를 활성화](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/)합니다.
3\. Log&Crash Search에서 [AppKey를 확인](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/#appkey)합니다.
4\. [TOAST Logger를 초기화](./log-collector-android#initialize)합니다.  
> 주의 : TOAST Crash SDK 기능을 사용하기 위해서는 TOAST Logger 초기화가 선행되어야 합니다.

## TOAST Crash SDK 초기화

onCreate() 메소드에서 TOAST Crash SDK를 초기화합니다.
> 주의 : TOAST Crash SDK 기능을 사용하기 위해서는 TOAST Logger 초기화가 선행되어야 합니다.  [TOAST Logger 초기화 안내](./log-collector-android#initialize)를 확인하세요.

```java
// Initialize Crash
ToastCrash.initialize();
```

## Handled Exception API 사용하기

TOAST Crash는 5가지 레벨의 예외(Handled Exception) 로그를 전송할 수 있습니다. Android 플랫폼의 경우 try/catch 구문에서 예외와 관련된 내용을 TOAST Crash SDK의 Handled Exception API를 사용하여 전송할 수 있습니다. 이렇게 전송한 예외 로그는 "Log & Crash Search 콘솔" > "App Crash Search 탭"의 오류 유형에서 Handled로 필터링하여 조회할 수 있습니다. 자세한 Log & Crash 콘솔 사용 방법은 [콘솔 사용 가이드](http://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/)를 참고하세요.


### Handled Exception log API 명세
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

### 사용 예

```java
try {
    // User Codes...
} catch (Exception e) {
    ToastCrash.debug(TAG, "Handled Exception", e);
}
```

## 크래시 발생 시 전송하는 사용자 정의 필드 설정하기 

크래시 발생 시 추가 정보 전달을 위해 사용자 정의 필드를 사용할 수 있습니다. setUserField API는 크래시 발생 시점과 상관없이 키 밸류 형태의 추가 정보를 설정할 수 있고, 설정한 추가 정보는 크래시 발생 시에 Log & Crash Search로 서버로 전송합니다.

### setUserField API 명세
```java
ToastCrash.setUserField(field, value);
```
*  "field"는 "Log & Crash Search 콘솔" > "Log Search 탭"에 "선택한 필드"로 노출되는 값과 동일합니다. 즉, Log & Crash Search의 커스텀 파라미터와 동일한 것으로 "field"값의 상세한 제약 사항은 [커스텀 필드의 제약사항](http://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/api-guide/)에서 확인할 수 있습니다.

* 커스텀 필드 제약사항
    * 이미 예약된 필드는 사용할 수 없습니다. 예약된 필드는 [커스텀 필드의 제약사항](http://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/api-guide/) 항목의 "기본 파라미터"를 확인하세요.
    * 필드명은 "A-Z, a-z"로 시작하고 "A-Z, a-z, 0-9, -, _" 문자를 사용할 수 있습니다.
    * 필드명 내에 공백은 "\_" 로 치환됩니다.
* 동일한 키에 대해 값을 여러 번 변경하면, 최종으로 변경한 값이 적용됩니다.

### setUserField 사용 예

```java
ToastCrash.setUserField("UserField", "UserValue");
```


## 크래시 발생 시점에 추가 정보를 설정하여 전송하기

크래시 발생 직후, 추가 정보를 설정할 수 있습니다. setUserField는 크래시 시점과 관계없이 아무 때나 설정할 수 있고, setDataAdapter의 경우 정확히 크래시가 발생한 시점에 추가 정보를 설정할 수 있습니다.

### setDataAdapter API 명세
```java
ToastCrash.setDataAdapter(adapter);
```
* CrashDataAdapter의 getUserFields 함수를 통해 리턴하는 Map 자료구조의 키값은 위에서 설명한 setUserField의 "field"값과 동일한 제약 조건을 갖습니다.

### setDataAdapter 사용 예

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

## 크래시 로그 전송 후 추가작업 진행하기

콜백 함수를 등록하면 크래시 로그 전송 후 추가 작업을 진행할 수 있습니다.

### setListener API 명세    
```java
ToastCrash.setListener(listener);
```

### setDataAdapter 사용 예

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

