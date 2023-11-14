## NHN Cloud > SDK 사용 가이드 > 개요

NHN Cloud SDK는 [NHN Cloud](https://nhncloud.com/)의 다양한 서비스 라이브러리(SDK)를 간편하게 적용할 수 있게 한 통합 라이브러리(SDK)입니다. NHN Cloud 서비스를 사용하여 애플리케이션을 개발할 때, 개별 서비스의 라이브러리를 각각 적용하는 불편함 없이 한 번에 적용할 수 있습니다. 
여러 서비스의 통합 개발 환경을 제공하지만, 원하는 기능만 선택할 수 있기 때문에 사용 공간을 절약할 수 있습니다. NHN Cloud SDK는 사용하는 프로그래밍 언어와 플랫폼에 최적화된 라이브러리로, 익숙한 개발 환경을 제공합니다.

> 현재는 iOS, Android, Unity3D, Windows C++의 개발 환경만 제공합니다. 향후 더욱 다양한 프로그래밍 언어와 플랫폼을 지원할 예정입니다.

## 지원하는 서비스

NHN Cloud SDK는 다음과 같은 서비스를 제공합니다.

- [Log & Crash Search](https://www.nhncloud.com/service/data-analytics/log-crash-search)
- [IAP](https://www.nhncloud.com/service/mobile-service/iap)
- [Push](https://www.nhncloud.com/service/notification/push)
- [OCR](https://www.nhncloud.com/service/ai-service/ocr)

> 개별 SDK를 제공하는 서비스는 앞으로 NHN Cloud SDK를 통해 개발할 수 있게 지원할 예정입니다.

## 특징

- Android는 Gradle, iOS는 CocoaPods를 활용한 빌드 환경을 지원합니다.
- Unity Plugin을 제공합니다.
- 사용하려는 서비스 전체 또는 일부 서비스를 선택해 적용할 수 있습니다.
- 개별 서비스에서 독자적으로 제공했던 SDK의 불편 사항을 개선했습니다.

## NHN Cloud SDK 시작하기

### Android

NHN Cloud Android SDK는 **mavenCentral**를 통해 배포되며 간단한 Gradle 설정만으로 사용할 수 있습니다.

- [Android 시작하기](./getting-started-android)

### iOS

NHN Cloud iOS SDK는 **Github**를 통해 배포되며 간단한 **Cocoapods**, **Carthage**, **Swift Package Manager** 설정만으로 사용할 수 있습니다.

- [iOS 시작하기](./getting-started-ios)

### Unity

NHN Cloud Unity SDK는 Android, iOS 플랫폼을 지원합니다.

- [Unity 시작하기](./getting-started-unity)

### Windows C++

NHN Cloud Windows C++ SDK는 Windows 7, 10(32/64bit) 환경을 지원합니다.

- [Windows C++ 시작하기](./getting-started-windows)

## Log & Crash

Log & Crash Search 수집 서버에 로그를 전송하는 기능을 제공합니다. 수집된 로그는 NHN Cloud 콘솔의 **Log & Crash Search** 메뉴를 클릭해 확인할 수 있습니다.

- [Log & Crash Search 서비스 확인](https://nhncloud.com/service/data-analytics/log-crash-search)
                                

### 주요 기능

| 기능      | 설명                                       |
| ------- | ---------------------------------------- |
| 로그 전송   | 로그를 수집 서버로 전송합니다.                        |
| 조회 및 검색 | NHN Cloud 콘솔에서 로그를 조회하거나 조건에 맞는 로그를 검색할 수 있습니다. |
| 크래시 리포트 | 예상치 못한 크래시가 발생하는 경우 Log & Crash Search 수집 서버로 크래시 로그를 전송합니다. |

### 사용 가이드

- [Log & Crash > Android](./log-collector-android) 사용 가이드
- [Log & Crash > iOS](./log-collector-ios) 사용 가이드
- [Log & Crash > Unity](./log-collector-unity) 사용 가이드
- [Log & Crash > Windows C++](./log-collector-windows) 사용 가이드

## NHN Cloud IAP

모바일 통합 인앱 결제 서비스를 제공합니다.

- [IAP 서비스 확인하기](https://www.nhncloud.com/service/mobile-service/iap)

### 주요 기능

| 기능 | 설명 |
| -- | -- |
| 일반 결제 | 일회성 상품을 판매할 수 있습니다. |
| 구독 결제 | 구독 상품을 판매할 수 있습니다. |
| 재처리 | 불안전하게 종료된 구매 프로세스를 복원할 수 있습니다. |

### 사용 가이드

- [IAP > Android](./iap-android) 사용 가이드
- [IAP > iOS](./iap-ios) 사용 가이드

## NHN Cloud Push

NHN Cloud Push SDK를 사용하여 Push 서비스를 손쉽게 적용할 수 있습니다.
콘솔을 통해 알림 메시지를 안정적으로 전송하고 전송 결과를 확인할 수 있습니다.

### 사용 가이드

- [Push > Android](./push-android) 사용 가이드
- [Push > iOS](./push-ios) 사용 가이드