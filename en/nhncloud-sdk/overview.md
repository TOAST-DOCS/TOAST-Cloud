## NHN Cloud > SDK User Guide > Overview

NHN Cloud SDK is an integrated library that lets you conveniently apply various service libraries of [NHN Cloud](https://nhncloud.com/). When you use NHN Cloud services to develop an application, you can apply them all at once without applying each library of individual services.
Although the SDK provides an integrated development environment for many services, you can save storage space by selecting only the required features. NHN Cloud SDK is a library optimized for each programming language and platform of your choice, and provides familiar development environment.

> Currently, NHN Cloud SDK provides development environment for iOS, Android, Unity3D, and Windows C++. More programming languages and platforms are to be supported in the future.

## Supported Services

NHN Cloud SDK provides the following services:

- [Log & Crash Search](https://www.nhncloud.com/service/data-analytics/log-crash-search)
- [IAP](https://www.nhncloud.com/service/mobile-service/iap)
- [Push](https://www.nhncloud.com/service/notification/push)
- [OCR](https://www.nhncloud.com/service/ai-service/ocr)

> Services providing individual SDK are to be supported for development via NHN Cloud SDK.

## Features

- Supports build environment that uses Gradle for Android and CocoaPods for iOS.
- Provides Unity Plugins.
- Lets you select and apply the whole or part of the services, depending on the needs.
- Improved the inconvenience of SDK that was separately provided by individual services.

## Getting Started with NHN Cloud SDK

### Android

NHN Cloud Android SDK is deployed on **mavenCentral** and requires only simple Gradle settings for use.

- [Get started for Android](https://docs.nhncloud.com/en/nhncloud/en/toast-sdk/getting-started-android)

### iOS

NHN Cloud iOS SDK is released on **Github** and requires only simple **Cocoapods**, **Carthage**, **Swift Package Manager** settings for use.

- [Get started for iOS](https://docs.nhncloud.com/en/nhncloud/en/toast-sdk/getting-started-ios)

### Unity

NHN Cloud Unity SDK supports Android and iOS platforms.

- [Get started for Unity](https://docs.nhncloud.com/en/nhncloud/en/toast-sdk/getting-started-unity)

### Windows C++

NHN Cloud Windows C++ SDK supports Windows 7 and 10 (32/64 bits) environments.

- [Get started for Windows C++](https://docs.nhncloud.com/en/nhncloud/en/toast-sdk/getting-started-windows)

## Log & Crash

This service provides capability to send logs to a collector server of Log & Crash Search. You can check the collected logs by clicking the **Log & Crash Search** menu on NHN Cloud console.

- [Find out Log & Crash Search Service](https://nhncloud.com/service/data-analytics/log-crash-search)

### Main Features

| Feature      | Description                                       |
| ------- | ---------------------------------------- |
| Sending Logs   | Sends logs to a collector server.                        |
| View and Search | Provides features to view logs or search for logs that meet criteria in NHN Cloud Console. |
| Crash Reports | When an unexpected crash occurs, sends the crash logs to a collector server of Log & Crash Search. |

### User Guides

- User Guide for [Log & Crash > Android](https://docs.nhncloud.com/en/nhncloud/en/toast-sdk/log-collector-android)
- User Guide for [Log & Crash > iOS](https://docs.nhncloud.com/en/nhncloud/en/toast-sdk/log-collector-ios)
- User Guide for [Log & Crash > Unity](https://docs.nhncloud.com/en/nhncloud/en/toast-sdk/log-collector-unity)
- User Guide for [Log & Crash > Windows C++](https://docs.nhncloud.com/en/nhncloud/en/toast-sdk/log-collector-windows)

## NHN Cloud IAP

This service provides integrated mobile in-app payment (IAP) service.

- [Find out IAP Service](https://www.nhncloud.com/service/mobile-service/iap)

### Main Features

| Feature | Description |
| -- | -- |
| General Payment | Provides features to sell one-time products. |
| Subscription Payment | Provides features to sell subscription products. |
| Re-processing | Provides features to restore incompletely-terminated purchase process. |

### User Guides

- User Guide for [IAP > Android](./iap-android)
- User Guide for [IAP > iOS](./iap-ios)

## NHN Cloud Push

NHN Cloud Push SDK allows you to apply push notification service easily.
On console, you can send the notification message in a stable manner and check the result.

### User Guides

- User Guide for [Push > Android](./push-android)
- User Guide for [Push > iOS](./push-ios)
