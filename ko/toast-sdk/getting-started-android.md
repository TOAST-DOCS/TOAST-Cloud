## TOAST > TOAST SDK 사용 가이드 > 시작하기 > Android

## 지원 환경

* Android 4.0.3 이상
* Android Studio 최신 버전 (버전 2.2 이상)

## TOAST SDK의 구성

Android 용 TOAST SDK의 구성은 다음과 같습니다.

* [TOAST Logger](./log-collector-android) SDK
* [TOAST Crash](./crash-reporter-android) SDK

TOAST SDK가 제공하는 모든 서비스에서 원하는 기능을 선택하여 적용할 수 있습니다.

| Gradle Dependency | Service |
| --- | --- |
| com.toast.android:toast-logger:1.0.0 | TOAST Logger |
| com.toast.android:toast-crash:1.0.0 | TOAST Crash Reporter |

## TOAST SDK를 Android Studio 프로젝트에 적용하기

### 1. Gradle을 사용해서 TOAST SDK 적용하기

build.gradle 파일에 TOAST SDK에 대한 종속성을 추가합니다.

```groovy
dependencies {
  // ...
  compile 'com.toast.android:toast-sdk:1.0.0'
  // ...
}
```

### 2. 바이너리 다운로드로 TOAST SDK 적용하기

TOAST의 [Downloads](../../../Download/#toast-sdk) 페이지에서 전체 Android SDK를 다운로드 받을 수 있습니다.

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

## 하나의 TOAST SDK로 여러 TOAST 서비스 선택하여 이용합니다.

* [TOAST Logger](./log-collector-android) 사용 가이드
* [TOAST Crash Reporter](./crash-reporter-android) 사용 가이드

