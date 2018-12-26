## TOAST > TOAST SDK 사용 가이드 > 시작하기 > Android

## 지원 환경

* Android 4.0.3 이상
* Android Studio 최신 버전(버전 2.2 이상)

## TOAST SDK의 구성

Android용 TOAST SDK의 구성은 다음과 같습니다.

* TOAST Common SDK
* TOAST Core SDK
* [TOAST Logger](./log-collector-android) SDK
* TOAST In-app Purchase Core SDK
* [TOAST In-app Purchase Google Play Store](./iap-android) SDK
* [TOAST In-app Purchase OneStore](./iap-android) SDK

TOAST SDK가 제공하는 서비스 중 원하는 기능을 선택해 적용할 수 있습니다.

| Gradle Dependency                           | Service           |
| ------------------------------------------- | ----------------- |
| com.toast.android:toast-common:0.13.0       | TOAST Common      |
| com.toast.android:toast-core:0.13.0         | TOAST Core        |
| com.toast.android:toast-logger:0.13.0       | TOAST Log & Crash |
| com.toast.android:toast-iap-core:0.13.0     | TOAST In-app Purchase Core |
| com.toast.android:toast-iap-google:0.13.0   | TOAST In-app Purchase <br>Google Play Store |
| com.toast.android:toast-iap-onestore:0.13.0 | TOAST In-app Purchase <br>OneStore |

## TOAST SDK를 Android Studio 프로젝트에 적용

### 1. Gradle을 사용해서 TOAST SDK 적용

TOAST SDK의 모든 서비스를 사용하려면 아래와 같이 종속성(dependency)을 설정합니다.

> 유니티를 사용하는 경우, 별도의 종속성 설정을 해야합니다. 
> 자세한 내용은 [유니티 가이드](./getting-started-unity/#android)를 참고해주세요.

```groovy
dependencies {
  implementation 'com.toast.android:toast-sdk:0.13.0'
}
```

TOAST SDK가 제공하는 상품별 설정 방법은 다음과 같습니다.

- [TOAST Logger 라이브러리 설정](./log-collector-android/#_1)
- [TOAST In-app Purchase 라이브러리 설정](./iap-android/#_2)

### 2. 바이너리를 다운로드하여 TOAST SDK 적용

TOAST의 [Downloads](../../../Download/#toast-sdk) 페이지에서 전체 Android SDK를 다운로드합니다.

## UserID 설정

TOASAT SDK에 UserID를 설정할 수 있습니다.
설정한 UserID는 TOAST SDK의 각 모듈에서 공통으로 사용됩니다.
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

TOAST SDK의 내부 로그를 확인하려면 디버그 모드를 설정할 수 있습니다.
TOAST SDK와 관련해 문의하실 때는 디버그 모드를 활성화해서 전달해 주시면 빠르게 지원해드릴 수 있습니다.

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

## TOAST 서비스 사용

* [TOAST Log & Crash](./log-collector-android) 사용 가이드
* [TOAST In-app Purchase](./iap-android) 사용 가이드



