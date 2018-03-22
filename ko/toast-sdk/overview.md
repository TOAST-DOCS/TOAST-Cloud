## TOAST > TOAST SDK 사용 가이드 > 개요

TOAST SDK는 [TOAST](https://toast.com/)에서 제공하는 다양한 서비스의 라이브러리(SDK)를 한 번에 간편하게 적용할 수 있도록 제공하는 통합 라이브러리(SDK)입니다. 여러 TOAST 서비스를 사용하여 애플리케이션을 개발할 때, 개별 서비스의 라이브러리를 각각 적용하는 불편함 없이 한 번에 적용할 수 있습니다.
여러 서비스의 통합 개발 환경을 제공하지만, 원하는 기능만 선택할 수 있기 때문에 사용 공간을 절약할 수 있습니다. TOAST SDK는 사용하는 프로그래밍 언어와 플랫폼에 최적화된 라이브러리로 이질감 없는 개발 환경을 제공합니다.

> 현재는 iOS, Android, Unity3D의 개발 환경을 제공하고 있고, 향후 더욱 다양한 프로그래밍 언어와 플랫폼을 지원할 예정입니다.

## 지원하는 서비스

* [Log & Crash Search](https://toast.com/service/analytics/log_crash_search)

> IAP, PUSH 등 개별 SDK를 제공하는 서비스는 앞으로 TOAST SDK를 통해 개발할 수 있도록 지원할 예정입니다.

## 특징

* Android는 Gradle, iOS는 CocoaPods를 활용한 빌드 환경을 지원합니다.
* Unity Plugin을 제공합니다.
* 사용하고자 하는 서비스 전체 또는 일부 서비스를 선택 적용할 수 있습니다.
* 개별 서비스에서 독자적으로 제공했던 SDK의 불편사항을 개선하였습니다.
* TOAST 콘솔을 통해 SDK의 설정을 변경할 수 있으므로 앱을 다시 빌드하여 배포하는 불편함이 없습니다.

## Getting Started TOAST SDK

### Android

TOAST Android SDK는 **jCenter**를 통해 배포되고 있으며 간단한 Gradle 설정만으로 사용할 수 있습니다.

* [Android 시작하기](./getting-started-android)

### iOS

TOAST iOS SDK는 **CocoaPods**으로 Project Setting 및 Framework Dependency를 관리를 지원합니다.

* [iOS 시작하기](./getting-started-ios)

### Unity

TOAST Unity SDK는 Android, iOS 플랫폼을 지원하고 있습니다.

* [Unity 시작하기](./getting-started-unity)

## TOAST Logger

Log & Crash Search 수집 서버에 로그를 전송하는 기능을 제공합니다.
수집된 로그는 TOAST 콘솔의 Log & Crash Search 메뉴를 선택하여 열람할 수 있습니다.

* [Log & Crash Serach 서비스 확인하기](https://toast.com/service/analytics/log_crash_search)

### 주요 기능

| 기능 | 설명 |
| -- | -- |
| 로그 전송 | 로그를 수집 서버로 전송합니다. |
| 조회 및 검색 | TOAST 콘솔에서 로그를 조회하거나 조건에 맞는 로그를 검색할 수 있습니다. |

### 사용 가이드

* [TOAST Logger > Android](./log-collector-android) 사용 가이드
* [TOAST Logger > iOS](./log-collector-ios) 사용 가이드
* [TOAST Logger > Unity](./log-collector-unity) 사용 가이드

## TOAST Crash Reporter

예상치 못한 크래시가 발생하는 경우 Log & Crash Search 수집 서버로 크래시 로그를 전송합니다.
TOAST 콘솔 화면에서 크래시 발생 현황에 대한 통계, 크래시 원인 분석에 필요한 콜 스택 등을 확인할 수 있습니다. 

* 크래시 로그 확인을 위해서는 Symbolication File이 등록되어야 합니다.  
Symbolication File 등록과 관련한 내용은 [Log & Crash Search의 콘솔 사용 가이드](http://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/)에서 확인할 수 있습니다.

### 주요 기능

| 기능 | 설명 |
| -- | -- |
| 크래시 로그 전송| 앱에서 발생한 크래시 정보를 전송합니다. |
| Handled Exceptions(Android, Unity) | try/catch statement에서 발생한 예외 정보를 전송합니다. |

* Android 플랫폼과 Unity로 개발된 앱의 경우 개발자 편의를 위해 "Handled Exception" 타입을 지원합니다.  
Handled Exception 타입은 "Log & Crash Search 콘솔" > "App Crash Search" 탭에서 필터 유형을 Crash와 Handled로 쉽게 필터링하여 조회할 수 있는 기능을 제공합니다.  
자세한 Log & Crash 콘솔 사용 방법은 [콘솔 사용 가이드](http://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/)를 참고하세요.

### 사용 가이드

* [TOAST Crash Reporter > Android](./crash-reporter-android) 사용 가이드
* [TOAST Crash Reporter > iOS](./crash-reporter-ios) 사용 가이드
* [TOAST Crash Reporter > Unity](./crash-reporter-unity) 사용 가이드

