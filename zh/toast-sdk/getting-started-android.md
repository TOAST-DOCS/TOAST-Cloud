## NHN Cloud > User Guide for NHN Cloud SDK > Getting Started > Android

## Supporting Environment

* Android 4.0.3 or higher
* The latest version of Android Studio (version 2.2 or higher)

## Configuration of NHN Cloud SDK

NHN Cloud SDK for Android is configured as follows:  

* NHN Cloud Common SDK
* NHN Cloud Core SDK
* [NHN Cloud Logger](./log-collector-android) SDK
* [NHN Cloud Native Crash Reporter](./log-collector-ndk) SDK
* NHN Cloud In-app Purchase Core SDK
* [NHN Cloud In-app Purchase Google Play Store](./iap-android) SDK
* [NHN Cloud In-app Purchase OneStore](./iap-android) SDK
* NHN Cloud Push Core SDK
* [NHN Cloud Push Firebase Cloud Messaging](./push-android) SDK

NHN Cloud SDK services can be selectively applied for your needs.

| Gradle Dependency | Service |
| --- | --- |
| com.toast.android:toast-common:0.24.4       | TOAST Common      |
| com.toast.android:toast-core:0.24.4         | TOAST Core        |
| com.toast.android:toast-logger:0.24.4       | TOAST Log & Crash |
| com.toast.android:toast-crash-reporter-ndk:0.24.4       | TOAST Native Crash Reporter |
| com.toast.android:toast-iap-core:0.24.4     | TOAST In-app Purchase Core |
| com.toast.android:toast-iap-google:0.24.4   | TOAST In-app Purchase <br>Google Play Store |
| com.toast.android:toast-iap-onestore:0.24.4 | TOAST In-app Purchase <br>OneStore |
| com.toast.android:toast-iap-galaxy:0.24.4 | TOAST In-app Purchase <br>GalaxyStore |
| com.toast.android:toast-push-core:0.24.4    | TOAST Push Core   |
| com.toast.android:toast-push-fcm:0.24.4    | TOAST Push <br>Firebase Cloud Messaging |

## Apply NHN Cloud SDK to Android Studio Projects

### 1. Build Android with Gradle

Set dependency as below, to use all NHN Cloud SDK services.  

> For Unity users, dependency must be set separately.  
> For more details, see [Guide for Unity](./getting-started-unity/#android).

```groovy
dependencies {
  implementation 'com.toast.android:toast-sdk:0.24.4'
}
```

Following describe how to set for each product of NHN Cloud SDK.

- [Setting Library of NHN Cloud Logger](./log-collector-android/#_1)
- [Setting Library of NHN Cloud Native Crash Reporter](./log-collector-ndk/#_1)
- [Setting Library of NHN Cloud In-app Purchase](./iap-android/#_2)
- [Setting Library of NHN Cloud Push](./push-android/#_2)

### 2. Build Android with AAR  

Android SDK can be downloaded from [Downloads](../../../Download/#toast-sdk).


## Set UserID

User ID can be set for NHN CloudSDK and it is for common usage at each module of NHN Cloud SDK.
Send such set user ID to a server, along with logs, whenever Log Sending API of NHN Cloud Logger is called.

### Specifications for User ID Setting API

```java
/* ToastSdk.java */
public static void setUserId(String userId);
```

| Parameters | |
| -- | -- |
| userId | String: User ID |

### Example of UserID Setting

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

To check logs within NHN Cloud SDK, the debug mode can be set.
To inquire of NHN Cloud SDK, enable the debug mode for faster response.  

### Specifications for Debug Mode Setting API

```java
/* ToastSdk.java */
public static void setDebugMode(boolean debug);
```

| Parameters | |
| -- | -- |
| debug | boolean: True to enable debug mode, or False |

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

> (Caution) To release an app, the debug mode must be disabled.

## Use NHN Cloud Service

* User Guide for [NHN Cloud Log & Crash](./log-collector-android)
* User Guide for [NHN Cloud Native Crash Reporter](./log-collector-ndk)
* User Guide for [NHN Cloud In-app Purchase](./iap-android)
* User Guide for [NHN Cloud Push](./push-android)
