## TOAST > TOAST SDK 사용 가이드 > 시작하기 > Android

## 지원 환경

* Android 4.0.3 이상
* Android Studio 최신 버전 (버전 2.2 이상)

## TOAST SDK의 구성

Android 용 TOAST SDK의 구성은 다음과 같습니다.

* TOAST Common SDK
* TOAST Core SDK
* [TOAST Logger](./log-collector-android) SDK

TOAST SDK가 제공하는 서비스 중 원하는 기능을 선택하여 적용할 수 있습니다.

| Gradle Dependency | Service |
| --- | --- |
| com.toast.android:toast-common:0.9.0 | TOAST Common |
| com.toast.android:toast-core:0.9.0 | TOAST Core |
| com.toast.android:toast-logger:0.9.0 | TOAST Logger (Log & Crash) |

## TOAST SDK를 Android Studio 프로젝트에 적용하기

### 1. Gradle을 사용해서 TOAST SDK 적용하기

build.gradle 파일에 TOAST SDK에 대한 종속성을 추가합니다.

```groovy
dependencies {
  // ...
  implementation 'com.toast.android:toast-sdk:0.9.0'
  // ...
}
```

### 2. 바이너리 다운로드로 TOAST SDK 적용하기

TOAST의 [Downloads](../../../Download/#toast-sdk) 페이지에서 전체 Android SDK를 다운로드할 수 있습니다.

## TOAST SDK 초기화하기

TOAST SDK 사용을 위한 초기화를 Application#onCreate에서 수행합니다.

```java
public class YourApplication extends Application {
    @Override
    public void onCreate() {
        super.onCreate();
        // Initialize TOAST SDK
        ToastSdk.initialize(getApplicationContext());
        // ...
    }
}
```

## UserID 설정하기

ToastSDK에 사용자 아이디를 설정할 수 있습니다.
설정한 사용자 아이디는 TOAST SDK의 각 모듈에서 다양한 용도로 사용하게 됩니다.
예를 들어 TOAST Logger 에서는 설정한 사용자 아이디를 로그 필드에 넣어서 함께 전송합니다.
따라서 설정한 사용자 아이디를 "UserID" 필드로 Log & Crash Search 콘솔을 통해 손쉽게 필터링하여 조회할 수 있습니다.

### UserID API 명세

```java
// ToastSdk.class
public static void setUserId(String userId);
```

### UserID 설정 사용 예

```java
// Set UserID
ToastSdk.setUserId("user_identifier");
```

## 디버그 모드 설정하기

TOAST SDK의 내부 로그 확인을 위해서 디버그 모드를 설정할 수 있습니다.
TOAST SDK 문의를 하실 경우, 디버그 모드를 활성화해서 전달해주시면 빠른 지원을 받을 수 있습니다.

### 디버그 모드 설정 API 명세

```java
public static void setDebugMode(boolean debug);
```

### 디버그 모드 설정 사용 예

```java
ToastSdk.setDebugMode(true); // or false
```

> (주의) 앱을 릴리즈할 경우, 반드시 디버그 모드를 비활성화 해야 합니다.

## TOAST Service 사용하기

* [TOAST Logger](./log-collector-android) 사용 가이드

