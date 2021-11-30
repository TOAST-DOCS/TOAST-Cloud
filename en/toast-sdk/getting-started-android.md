## TOAST > TOAST SDK User Guide > Getting Started > Android

## Supported Environment

* Android 4.0.3 or higher
* The latest version of Android Studio (version 2.2 or higher)

## TOAST SDK Components

TOAST SDK for Android consists of the following:

* TOAST Common SDK
* TOAST Core SDK
* [TOAST Logger](./log-collector-android) SDK
* [TOAST Native Crash Reporter](./log-collector-ndk) SDK
* TOAST In-app Purchase Core SDK
* [TOAST In-app Purchase Google Play Store](./iap-android) SDK
* [TOAST In-app Purchase OneStore](./iap-android) SDK
* TOAST Push Core SDK
* [TOAST Push Firebase Cloud Messaging](./push-android) SDK

You can selectively apply the required feature among the services provided by TOAST SDK.

| Gradle Dependency                           | Service           |
| ------------------------------------------- | ----------------- |
| com.toast.android:toast-common:0.29.0       | TOAST Common      |
| com.toast.android:toast-core:0.29.0         | TOAST Core        |
| com.toast.android:toast-logger:0.29.0       | TOAST Log & Crash |
| com.toast.android:toast-crash-reporter-ndk:0.29.0       | TOAST Native Crash Reporter |
| com.toast.android:toast-iap-core:0.29.0     | TOAST In-app Purchase Core |
| com.toast.android:toast-iap-google:0.29.0   | TOAST In-app Purchase <br>Google Play Store |
| com.toast.android:toast-iap-onestore:0.29.0 | TOAST In-app Purchase <br>OneStore |
| com.toast.android:toast-iap-galaxy:0.29.0 | TOAST In-app Purchase <br>GalaxyStore |
| com.toast.android:toast-push-core:0.29.0    | TOAST Push Core   |
| com.toast.android:toast-push-fcm:0.29.0    | TOAST Push <br>Firebase Cloud Messaging |

## Apply TOAST SDK to Android Studio Projects

### 1. Build Android with Gradle

To use all TOAST SDK services, set dependency as shown below.

> If you are using Unity, separate dependency setting is required.
> For more details, see [Guide for Unity](./getting-started-unity/#android).

```groovy
repositories {
  mavenCentral()
}

dependencies {
  implementation 'com.toast.android:toast-sdk:0.29.0'
}
```

The following describes how to set dependency for each product of TOAST SDK.

- [Library setting for TOAST Logger](./log-collector-android/#_1)
- [Library setting for TOAST Native Crash Reporter](./log-collector-ndk/#_1)
- [Library setting for TOAST In-app Purchase](./iap-android/#_2)
- [Library setting for TOAST Push](./push-android/#_2)

### 2. Build Android with AAR

Android SDK can be downloaded from the [Downloads](../../../Download/#toast-sdk) page.

## Set User ID

User ID can be set for Toast SDK.
The configured User ID is commonly used in each module of TOAST SDK.
Whenever Log Sending API of ToastLogger is called, the configured User ID is sent to a server along with logs.

### Specification for User ID Setting API

```java
/* ToastSdk.java */
public static void setUserId(String userId);
```

| Parameters | |
| -- | -- |
| userId | String: User ID|

### Example of User ID Setting

#### Login

```java
// Login.
ToastSdk.setUserId(userId);
```

#### Logout

```java
// Logout.
ToastSdk.setUserId(null);
```

## Set Debug Mode

To check internal logs of TOAST SDK, the debug mode can be set.
When you make an inquiry regarding TOAST SDK, sending the logs with the debug mode enabled can be helpful for faster response.

### Specification for Debug Mode Setting API

```java
/* ToastSdk.java */
public static void setDebugMode(boolean debug);
```

| Parameters | |
| -- | -- |
| debug | boolean: true to enable debug mode, false otherwise.|

### Usage Example of Debug Mode Setting

#### Enable Debug Mode

```java
// Enable debug mode.
ToastSdk.setDebugMode(true);
```

#### Disable Debug Mode

```java
// Disable debug mode.
ToastSdk.setDebugMode(false);
```

> [Caution] The debug mode must be disabled before releasing an app.

## Use TOAST Services

* User Guide for [TOAST Log & Crash](./log-collector-android)
* User Guide for [TOAST Native Crash Reporter](./log-collector-ndk)
* User Guide for [TOAST In-app Purchase](./iap-android)
* User Guide for [TOAST Push](./push-android)
