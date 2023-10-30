## NHN Cloud > SDK User Guide > Getting Started > Android

## Supported Environment

* Android 4.0.3 or higher
* The latest version of Android Studio (version 2.2 or higher)

## NHN Cloud SDK Components

NHN Cloud SDK for Android consists of the following:

* Common SDK
* Core SDK
* [Logger](./log-collector-android) SDK
* [Native Crash Reporter](./log-collector-ndk) SDK
* In-app Purchase Core SDK
* [In-app Purchase Google Play Store](./iap-android) SDK
* [In-app Purchase OneStore](./iap-android) SDK
* Push Core SDK
* [Push Firebase Cloud Messaging](./push-android) SDK
* [Credit Card Recognizer](./creditcard-recognizer-android) SDK

You can selectively apply the required feature among the services provided by NHN Cloud SDK.

| Gradle Dependency                           | Service           |
| ------------------------------------------- | ----------------- |
| com.nhncloud.android:nhncloud-common:1.8.1       | Common      |
| com.nhncloud.android:nhncloud-core:1.8.1         | Core        |
| com.nhncloud.android:nhncloud-logger:1.8.1       | Log & Crash |
| com.nhncloud.android:nhncloud-crash-reporter-ndk:1.8.1       | Native Crash Reporter |
| com.nhncloud.android:nhncloud-iap-core:1.8.1     | In-app Purchase Core |
| com.nhncloud.android:nhncloud-iap-google:1.8.1   | In-app Purchase <br>Google Play Store |
| com.nhncloud.android:nhncloud-iap-onestore:1.8.1 | In-app Purchase <br>ONE store |
| com.nhncloud.android:nhncloud-iap-galaxy:1.8.1 | In-app Purchase <br>Galaxy Store |
| com.nhncloud.android:nhncloud-push-core:1.8.1    | Push Core   |
| com.nhncloud.android:nhncloud-push-fcm:1.8.1    | Push <br>Firebase Cloud Messaging |
| com.nhncloud.android:nhncloud-creditcard-recognizer:1.8.1    | Credit Card Recognizer |

## Apply NHN Cloud SDK to Android Studio Projects

### 1. Build Android with Gradle

To use all NHN Cloud SDK services, set dependency as shown below.

> If you are using Unity, separate dependency setting is required.
> For more details, see [Guide for Unity](./getting-started-unity/#android).

```groovy
repositories {
  mavenCentral()
}

dependencies {
  implementation 'com.nhncloud.android:nhncloud-sdk:1.8.1'
}
```

The following describes how to set dependency for each product of NHN Cloud SDK.

- [Library setting for Logger](./log-collector-android/#_1)
- [Library setting for Native Crash Reporter](./log-collector-ndk/#_1)
- [Library setting for In-app Purchase](./iap-android/#_2)
- [Library setting for Push](./push-android/#_2)
- [Library setting for Credit Card Recognizer](./creditcard-recognizer-android/#_1)

### 2. Build Android with AAR

Android SDK can be downloaded from the [Downloads](../../../Download/#toast-sdk) page.

## Set User ID

User ID can be set for NHN Cloud SDK.
The configured User ID is commonly used in each module of NHN Cloud SDK.
Whenever Log Sending API of NhnCloudLogger is called, the configured User ID is sent to a server along with logs.

### Specification for User ID Setting API

```java
/* NhnCloudSdk.java */
public static void setUserId(String userId);
```

| Parameters | |
| -- | -- |
| userId | String: User ID|

### Example of User ID Setting

#### Login

```java
// Login.
NhnCloudSdk.setUserId(userId);
```

#### Logout

```java
// Logout.
NhnCloudSdk.setUserId(null);
```

## Set Debug Mode

To check internal logs of NHN Cloud SDK, the debug mode can be set.
When you make an inquiry regarding NHN Cloud SDK, sending the logs with the debug mode enabled can be helpful for faster response.

### Specification for Debug Mode Setting API

```java
/* NhnCloudSdk.java */
public static void setDebugMode(boolean debug);
```

| Parameters | |
| -- | -- |
| debug | boolean: true to enable debug mode, false otherwise.|

### Usage Example of Debug Mode Setting

#### Enable Debug Mode

```java
// Enable debug mode.
NhnCloudSdk.setDebugMode(true);
```

#### Disable Debug Mode

```java
// Disable debug mode.
NhnCloudSdk.setDebugMode(false);
```

> [Caution] The debug mode must be disabled before releasing an app.

## Use NHN Cloud Services

* User Guide for [Log & Crash](./log-collector-android)
* User Guide for [Native Crash Reporter](./log-collector-ndk)
* User Guide for [In-app Purchase](./iap-android)
* User Guide for [Push](./push-android)
* User Guide for [Credit Card Recognizer](./creditcard-recognizer-android)
