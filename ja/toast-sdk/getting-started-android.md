## TOAST > User Guide for TOAST SDK > Getting Started > Android

## Supporting Environment

* Android 4.0.3 or higher
* The latest version of Android Studio (version 2.2 or higher)

## Configuration of TOAST SDK

TOAST SDK for Android is configured as follows:  

* TOAST Common SDK
* TOAST Core SDK
* [TOAST Logger](./log-collector-android) SDK
* TOAST In-app Purchase Core SDK
* [TOAST In-app Purchase Google Play Store](./iap-android) SDK
* [TOAST In-app Purchase OneStore](./iap-android) SDK

TOAST SDK services can be selectively applied for your needs. 

| Gradle Dependency | Service |
| --- | --- |
| com.toast.android:toast-common:0.12.0 | TOAST Common |
| com.toast.android:toast-core:0.12.0 | TOAST Core |
| com.toast.android:toast-logger:0.12.0 | TOAST Log & Crash |
| com.toast.android:toast-iap-core:0.12.0 | TOAST In-app Purchase Core |
| com.toast.android:toast-iap-google:0.12.0 | TOAST In-app Purchase <br>Google Play Store |
| com.toast.android:toast-iap-onestore:0.12.0 | TOAST In-app Purchase <br>OneStore |

## Apply TOAST SDK to Android Studio Projects 

### 1. Apply TOAST SDK with Gradle

Set dependency as below, to use all TOAST SDK services.  

> For Unity users, dependency must be set separately.  
> For more details, see [Guide for Unity](./getting-started-unity/#android).

```groovy
dependencies {
  implementation 'com.toast.android:toast-sdk:0.12.0'
}
```

Following describe how to set for each product of TOAST SDK. 

- [Setting Library of TOAST Logger](./log-collector-android/#_1)
- [Setting Library of TOAST In-app Purchase](./iap-android/#_2)

### 2. Apply TOAST SDK with Binary Downloads  

The entire Android SDK can be downloaded from [Downloads](../../../Download/#toast-sdk) of TOAST. 

## Initialize TOAST SDK 

- To use TOAST IAP SDK, TOAST SDK must be initialized. 
Initialization must be executed from Application#onCreate.

- `TOAST SDK, without initialization, cannot operate.`

### Specifications for Initialization API 

```java
/* ToastSdk.java */
public static void initialize(Context context)
```

| Parameters | |
| -- | -- |
| applicationContext | Context: Application Context |

### Example of Initialization 

```java
public class MainApplication extends Application {
    @Override
    public void onCreate() {
        super.onCreate();
        initializeToastSdk();
    }

    /**
     * Initialize ToastSdk.
     * <p>
     * To enable the ToastSdk debug mode, call ToastSdk.setDebugMode(boolean) and set True.  
     * <pre>
     * {@code
     * ToastSdk.setDebugMode(true);
     * }
     * </pre>
     */
    private void initializeToastSdk() {
        ToastSdk.setDebugMode(true);
        ToastSdk.initialize(getApplicationContext());
    }
}
```

## Set UserID 

User ID can be set for ToastSDK and it is for common usage at each module of TOAST SDK.
Send such set user ID to a server, along with logs, whenever Log Sending API of TOAST Logger is called. 

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

To check logs within TOAST SDK, the debug mode can be set. 
To inquire of TOAST SDK, enable the debug mode for faster response.  

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

## Use TOAST Service 

* User Guide for [TOAST Log & Crash](./log-collector-android) 
* User Guide for [TOAST In-app Purchase](./iap-android) 



