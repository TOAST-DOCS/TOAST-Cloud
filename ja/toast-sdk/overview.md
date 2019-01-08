## TOAST > User Guide for TOAST SDK > Overview

TOAST SDK is an integrated library (SDK) which conveniently applies libraries of many services (SDKs) provided by [TOAST](https://toast.com/), at once. With TOAST SDK, there is no need to apply individual library of different services for the development of applications requiring many TOAST services. 
Although an integrated development environment is provided for many services, functions are optional so as to save usage space. TOAST SDK library is optimized for each programming language and platform of choice, and provides no-strange environment for development. 

> Currently supports for iOS, Android, Unity3D, and Windows C++, and more programming languages and platforms are to be supported in the near future.

## Supported Services

TOAST SDK provides the following services: 

- [Log & Crash Search](https://toast.com/service/analytics/log_crash_search)

- [IAP](https://www.toast.com/service/mobile-service/iap)

- [Push](https://www.toast.com/service/notification/push)

> Further service development providing individual SDKs are to be supported via TOAST SDK.  

## Features

- Support Gradle for Android, and CocoaPods for iOS, for the build environment.  
- Provide Unity Plugins. 
- Apply the whole or parts of the services, depending on the needs.  
- Improved inconvenient standalone SDK services provided  by individual services. 

## Getting Started 

### Android

TOAST Android SDK is distributed via **jCenter** and enabled only with simple Gradle settings.  

- [Get started with Android](https://docs.toast.com/en/TOAST/en/toast-sdk/getting-started-android)

### iOS

TOAST iOS SDK supports the management of Project Setting and Framework Dependency with **CocoaPods**. 

- [Get started with iOS](https://docs.toast.com/en/TOAST/en/toast-sdk/getting-started-ios)

### Unity

TOAST Unity SDK supports Android and iOS platforms. 

- [Get started with Unity](https://docs.toast.com/en/TOAST/en/toast-sdk/getting-started-unity)

### Windows C++

TOAST Windows C++ SDK supports Windows 7 and 10 (32/64 bits). 

- [Get started with Windows C++](https://docs.toast.com/en/TOAST/en/toast-sdk/getting-started-windows)

## TOAST Log & Crash

Sends logs to a collector server of Log & Crash Search.  
Collected logs can be retrieved by selecting from the Log & Crash Search Menu on TOAST console. 

- [Find out Log & Crash Search Service](https://toast.com/service/analytics/log_crash_search)

### Main Features

| Feature          | Description                                                  |
| ---------------- | ------------------------------------------------------------ |
| Sending Logs     | Send logs to a collector server.                             |
| Query and Search | Logs can be queried or searched for conditions from TOAST Console. |
| Crash Reports    | Unexpected crashes are sent to a collector server of Log & Crash Search. |

### User Guides

- User Guide for [TOAST Log & Crash > Android](https://docs.toast.com/en/TOAST/en/toast-sdk/log-collector-android) 
- User Guide for [TOAST Log & Crash > iOS](https://docs.toast.com/en/TOAST/en/toast-sdk/log-collector-ios) 
- User Guide for [TOAST Log & Crash > Unity](https://docs.toast.com/en/TOAST/en/toast-sdk/log-collector-unity) 
- User Guide for [TOAST Log & Crash > Windows C++](https://docs.toast.com/en/TOAST/en/toast-sdk/log-collector-windows) 

## TOAST IAP

Supports integrated mobile In-App Payment service. 

* [Find out IAP Service](https://www.toast.com/service/mobile-service/iap)

### Main Features

| Feature | Description |
| -- | -- |
| General Payment | Sell one-time products. |
| Subscription Payment | Sell subscription products. |
| Re-processing | Restore incompletely-closed purchase process. |

### User Guides

* User Guide for [TOAST IAP > Android](./iap-android) 
* User Guide for [TOAST IAP > iOS](./iap-ios) 

## TOAST Push

### 사용 가이드

* User Guide for [TOAST Push > Android](./push-android) 
* User Guide for [TOAST Push > iOS](./push-ios) 
