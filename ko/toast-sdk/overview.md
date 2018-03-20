## TOAST > TOAST SDK 사용 가이드 > 개요

TOAST SDK는 [TOAST](https://toast.com/) 상품을 손쉽고 빠르게 사용할 수 있는 통합 서비스를 제공합니다.

프로그래밍 언어 또는 플랫폼에 맞게 제공되는 API를 통해 애플리케이션에서 TOAST SDK를 더욱 간편하게 사용할 수 있습니다.

> 보다 다양한 프로그래밍 언어와 플랫폼이 지원될 예정입니다.

## Getting Started TOAST SDK

### Android

TOAST Android SDK는 `jCenter`를 통해 배포되고 있으며 간단한 Gradle 설정으로 손쉽게 사용할 수 있습니다.

* [Android 시작하기](./getting-started-android)

### iOS

TOAST iOS SDK는 `CocoaPods`를 지원하여 Project Setting 및 Framework Dependency를 간편하게 적용할 수 있습니다.

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
