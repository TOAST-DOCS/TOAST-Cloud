## NHN Cloud > User Guide for NHN Cloud SDK > Overview

NHN Cloud SDK is an integrated library (SDK) which conveniently applies libraries of many services (SDKs) provided by [NHN Cloud](https://toast.com/), at once. With TOAST SDK, there is no need to apply individual library of different services for the development of applications requiring many NHN Cloud services. 
Although an integrated development environment is provided for many services, functions are optional so as to save usage space. NHN Cloud SDK library is optimized for each programming language and platform of choice, and provides no-strange environment for development. 

> Currently supports for iOS, Android, Unity3D, and Windows C++, and more programming languages and platforms are to be supported in the near future.

## Supported Services

NHN Cloud SDK provides the following services: 

- [Log & Crash Search](https://toast.com/service/analytics/log_crash_search)

- [IAP](https://www.toast.com/service/mobile-service/iap)

- [Push](https://www.toast.com/service/notification/push)

> Further service development providing individual SDKs are to be supported via NHN Cloud SDK.  

## Features

- Support Gradle for Android, and CocoaPods for iOS, for the build environment.  
- Provide Unity Plugins. 
- Apply the whole or parts of the services, depending on the needs.  
- Improved inconvenient standalone SDK services provided  by individual services. 

## Getting Started 

### Android

NHN Cloud Android SDK is distributed via **jCenter** and enabled only with simple Gradle settings.  

- [Get started with Android](https://docs.toast.com/en/TOAST/en/toast-sdk/getting-started-android)

### iOS

NHN Cloud Android SDK is distributed via **Github** and enabled only with simple **CocoaPods**, **Carthage** settings.  

- [Get started with iOS](https://docs.toast.com/en/TOAST/en/toast-sdk/getting-started-ios)

### Unity

NHN Cloud Unity SDK supports Android and iOS platforms. 

- [Get started with Unity](https://docs.toast.com/en/TOAST/en/toast-sdk/getting-started-unity)

### Windows C++

NHN Cloud Windows C++ SDK supports Windows 7 and 10 (32/64 bits). 

- [Get started with Windows C++](https://docs.toast.com/en/TOAST/en/toast-sdk/getting-started-windows)

## NHN Cloud Log & Crash

Sends logs to a collector server of Log & Crash Search.  
Collected logs can be retrieved by selecting from the Log & Crash Search Menu on NHN Cloud console. 

- [Find out Log & Crash Search Service](https://toast.com/service/analytics/log_crash_search)

### Main Features

| Feature          | Description                                                  |
| ---------------- | ------------------------------------------------------------ |
| Sending Logs     | Send logs to a collector server.                             |
| Query and Search | Logs can be queried or searched for conditions from NHN Cloud Console. |
| Crash Reports    | Unexpected crashes are sent to a collector server of Log & Crash Search. |

### User Guides

- User Guide for [NHN Cloud Log & Crash > Android](https://docs.toast.com/en/TOAST/en/toast-sdk/log-collector-android) 
- User Guide for [NHN Cloud Log & Crash > iOS](https://docs.toast.com/en/TOAST/en/toast-sdk/log-collector-ios) 
- User Guide for [NHN Cloud Log & Crash > Unity](https://docs.toast.com/en/TOAST/en/toast-sdk/log-collector-unity) 
- User Guide for [NHN Cloud Log & Crash > Windows C++](https://docs.toast.com/en/TOAST/en/toast-sdk/log-collector-windows) 

## NHN Cloud IAP

Supports integrated mobile In-App Payment service. 

* [Find out IAP Service](https://www.toast.com/service/mobile-service/iap)

### Main Features

| Feature | Description |
| -- | -- |
| General Payment | Sell one-time products. |
| Subscription Payment | Sell subscription products. |
| Re-processing | Restore incompletely-closed purchase process. |

### User Guides

* User Guide for [NHN Cloud IAP > Android](./iap-android) 
* User Guide for [NHN Cloud IAP > iOS](./iap-ios) 

## NHN Cloud Push

### 사용 가이드

* User Guide for [NHN Cloud Push > Android](./push-android) 
* User Guide for [NHN Cloud Push > iOS](./push-ios) 
