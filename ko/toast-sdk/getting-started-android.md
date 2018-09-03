## TOAST > TOAST SDK 사용 가이드 > 시작하기 > Android

## 지원 환경

* Android 4.0.3 이상
* Android Studio 최신 버전 (버전 2.2 이상)

## TOAST SDK의 구성

Android 용 TOAST SDK의 구성은 다음과 같습니다.

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
  compile 'com.toast.android:toast-sdk:0.9.0'
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
        // ...

        // Initialize TOAST SDK
        ToastSdk.initialize(getApplicationContext());
    }
}
```

## TOAST SDK 사용자 추가
TOAST SDK는 UserID 설정을 통해 로그를 전송하는 사용자를 식별할 수 있습니다.

```java
public class YourApplication extends Application {
    @Override
    public void onCreate() {
        super.onCreate();
        // ...

        // Set UserID
        ToastSdk.setUserId("user_identifier");

        // Initialize TOAST SDK
        ToastSdk.initialize(getApplicationContext());
    }
}
```

## TOAST Service 사용하기

* [TOAST Logger](./log-collector-android) 사용 가이드

