## TOAST > TOAST SDK 사용 가이드 > 시작하기 > Android

## Component SDKs

Android용 TOAST SDK는 다음과 같은 SDK로 구성되어 있습니다.

* [TOAST Logger](./log-collection-android) SDK
* [TOAST Crash](./crash-reporter-android) SDK

전체 TOAST SDK 기능이 필요하지 않은 경우 앱에 필요한 SDK만 사용할 수 있습니다.

| Gradle Dependency | Service |
| --- | --- |
| com.toast.android:toast-logger:1.0.0 | Log Collection |
| com.toast.android:toast-crash:1.0.0 | Crash Reporter |

## Environments

* Android 4.0.3 이상
* Android Studio 최신 버전 (버전 2.2 이상)

## Add TOAST SDK to Your Project

프로젝트에 TOAST SDK를 사용하려는 경우 몇 가지 기본적인 작업을 수행하여 Android Studio 프로젝트를 준비해야 합니다.

build.gradle 파일에 TOAST SDK에 대한 종속성을 추가합니다.

```groovy
dependencies {
  // ...
  compile 'com.toast.android:toast-sdk:1.0.0'
  // ...
}
```

## Intiailize TOAST SDK

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

## Next Step

* [Log Collector](./log-collection-android) 사용 가이드
* [Crash Reporter](./crash-reporter-android) 사용 가이드

