## TOAST > TOAST SDK 사용 가이드 > 개요

TOAST SDK는 [TOAST](https://toast.com/)에서 제공하는 다양한 서비스 라이브러리를 한 번에 간편하게 적용할 수 있도록 제공하는 통합 라이브러리입니다. 여러 TOAST 서비스를 사용하여 애플리케이션을 개발할 때, 개별 서비스의 라이브러리를 각각 적용하는 불편함 없이 한 번에 적용할 수 있습니다.
TOAST에서 제공하는 여러 서비스의 통합 개발 환경을 제공하지만, 원하는 기능만 선택할 수 있기 때문에 사용 공간을 절약할 수 있습니다.
사용하는 프로그래밍 언어와 플랫폼에 최적화된 라이브러리로 이질감 없는 개발 환경을 제공합니다.

> 현재는 iOS, Android, Unity3D의 개발 환경을 제공하고 있고, 향후 더욱 다양한 프로그래밍 언어와 플랫폼을 지원할 예정입니다.

## 특징

* Android Gradle, iOS CocoaPods를 지원합니다.
* Unity Plugin을 제공합니다.
* 사용하고자 하는 서비스 전체 또는 일부 서비스를 선택적으로 적용 가능합니다.
* 개별 서비스에서 독자적으로 제공했던 SDK의 불편사항을 개선하였습니다.
* TOAST 콘솔을 통한 SDK 환경 설정을 제공하여 앱의 재배포 없이 설정 변경이 가능합니다.

## Getting Started TOAST SDK

### Android

TOAST Android SDK는 **jCenter**를 통해 배포되고 있으며 간단한 Gradle 설정으로 손쉽게 사용할 수 있습니다.

* [Android 시작하기](./getting-started-android)

### iOS

TOAST iOS SDK는 **CocoaPods**를 지원하여 Project Setting 및 Framework Dependency를 간편하게 적용할 수 있습니다.

* [iOS 시작하기](./getting-started-ios)

### Unity

TOAST Unity SDK는 Android, iOS 플랫폼을 지원하고 있으며 간편한 설정으로 다양한 TOAST 상품을 이용할 수 있습니다.

* [Unity 시작하기](./getting-started-unity)

## Log Collector

Log&Crash Search 수집 서버에 로그를 전송하는 기능을 제공합니다.
수집된 로그는 Log&Crash Search에서 쉽고 빠르게 조회할 수 있습니다.

### 주요기능

| 기능 | 설명 |
| -- | -- |
| 로그 전송 | 로그를 수집 서버로 전송합니다. |
| 조회 및 검색 | Log&Crash Search에서 전송된 로그를 조회 및 검색이 가능합니다. |

### 사용 가이드

* [Log Collector > Android](./log-collector-android) 사용 가이드
* [Log Collector > iOS](./log-collector-ios) 사용 가이드
* [Log Collector > Unity](./log-collector-unity) 사용 가이드

## Crash Reporter

앱에서 발생하는 Crash 정보를 Log&Crash Search 수집 서버로 전송하는 기능을 제공합니다.
Log&Crash Search에서 크래시를 분석하여 발생 원인에 대한 다양한 정보와 통계를 확인할 수 있습니다.

### 주요 기능

| 기능 | 설명 |
| -- | -- |
| Detecting a Crash Occurred | 앱에서 발생한 Crash 정보를 전송합니다. |
| Handled Exceptions | try/catch statement에서 발생한 예외 정보를 전송합니다. (only Android)|

### 사용 가이드

* [Crash Reporter > Android](./crash-reporter-android) 사용 가이드
* [Crash Reporter > iOS](./crash-reporter-ios) 사용 가이드
* [Crash Reporter > Unity](./crash-reporter-unity) 사용 가이드
