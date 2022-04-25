## NHN Cloud > SDK 사용 가이드 > 시작하기 > Android

## 지원 환경

* Android 4.0.3 이상
* Android Studio 최신 버전(버전 2.2 이상)

## NHN Cloud SDK의 구성

Android용 NHN Cloud SDK의 구성은 다음과 같습니다.

* Common SDK
* Core SDK
* [Logger](./log-collector-android) SDK
* [Native Crash Reporter](./log-collector-ndk) SDK
* In-app Purchase Core SDK
* [In-app Purchase Google Play Store](./iap-android) SDK
* [In-app Purchase OneStore](./iap-android) SDK
* Push Core SDK
* [Push Firebase Cloud Messaging](./push-android) SDK

NHN Cloud SDK가 제공하는 서비스 중 원하는 기능을 선택해 적용할 수 있습니다.

| Gradle Dependency                           | Service           |
| ------------------------------------------- | ----------------- |
| com.toast.android:toast-common:0.29.2       | Common      |
| com.toast.android:toast-core:0.29.2         | Core        |
| com.toast.android:toast-logger:0.29.2       | Log & Crash |
| com.toast.android:toast-crash-reporter-ndk:0.29.2       | Native Crash Reporter |
| com.toast.android:toast-iap-core:0.29.2     | In-app Purchase Core |
| com.toast.android:toast-iap-google:0.29.2   | In-app Purchase <br>Google Play Store |
| com.toast.android:toast-iap-onestore:0.29.2 | In-app Purchase <br>ONE store |
| com.toast.android:toast-iap-galaxy:0.29.2 | In-app Purchase <br>Galaxy Store |
| com.toast.android:toast-push-core:0.29.2    | Push Core   |
| com.toast.android:toast-push-fcm:0.29.2    | Push <br>Firebase Cloud Messaging |

## NHN Cloud SDK를 Android Studio 프로젝트에 적용

### 1. Gradle을 사용하여 Android 빌드

NHN Cloud SDK의 모든 서비스를 사용하려면 아래와 같이 종속성(dependency)을 설정합니다.

> 유니티를 사용하는 경우, 별도의 종속성 설정을 해야합니다.
> 자세한 내용은 [유니티 가이드](./getting-started-unity/#android)를 참고해주세요.

```groovy
repositories {
  mavenCentral()
}

dependencies {
  implementation 'com.toast.android:toast-sdk:0.29.2'
}
```

NHN Cloud SDK가 제공하는 상품별 설정 방법은 다음과 같습니다.

- [Logger 라이브러리 설정](./log-collector-android/#_1)
- [Native Crash Reporter 라이브러리 설정](./log-collector-ndk/#_1)
- [In-app Purchase 라이브러리 설정](./iap-android/#_2)
- [Push 라이브러리 설정](./push-android/#_2)

### 2. AAR을 사용하여 Android 빌드

Android SDK는 [Downloads](../../../Download/#toast-sdk) 페이지에서 다운로드할 수 있습니다.

## UserID 설정

NHN Cloud SDK에 UserID를 설정할 수 있습니다.
설정한 UserID는 NHN Cloud SDK의 각 모듈에서 공통으로 사용됩니다.
ToastLogger의 로그 전송 API를 호출할 때마다 설정한 UserID를 로그와 함께 서버로 전송합니다.

### UserID 설정 API 명세

```java
/* ToastSdk.java */
public static void setUserId(String userId);
```

| Parameters | |
| -- | -- |
| userId | String: 사용자 아이디.|

### UserID 설정 예

#### 로그인

```java
// Login.
ToastSdk.setUserId(userId);
```

#### 로그아웃

```java
// Logout.
ToastSdk.setUserId(null);
```

## 디버그 모드 설정

NHN Cloud SDK의 내부 로그를 확인하려면 디버그 모드를 설정할 수 있습니다.
NHN Cloud SDK와 관련해 문의하실 때는 디버그 모드를 활성화해서 전달해 주시면 빠르게 지원해드릴 수 있습니다.

### 디버그 모드 설정 API 명세

```java
/* ToastSdk.java */
public static void setDebugMode(boolean debug);
```

| Parameters | |
| -- | -- |
| debug | boolean: 디버그 모드를 활성화하려면 true, 아니면 false.|

### 디버그 모드 설정 사용 예

#### 디버그 모드 활성화

```java
// Enable debug mode.
ToastSdk.setDebugMode(true);
```

#### 디버그 모드 비활성화

```java
// Disable debug mode.
ToastSdk.setDebugMode(false);
```

> [주의] 앱을 릴리스할 때는 반드시 디버그 모드를 비활성화해야 합니다.

## NHN Cloud 서비스 사용

* [Log & Crash](./log-collector-android) 사용 가이드
* [Native Crash Reporter](./log-collector-ndk) 사용 가이드
* [In-app Purchase](./iap-android) 사용 가이드
* [Push](./push-android) 사용 가이드
