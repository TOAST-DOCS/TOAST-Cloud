## TOAST > User Guide for TOAST SDK > Release Notes > Android

## 0.17.1 (2019.07.23)

### TOAST Push

#### 기능 추가

* 커스텀 리시버 사용시 메세지 객체내에 FCM 발신자 ID 정보 추가.

## 0.17.0 (2019.06.25)

### TOAST Push

#### 기능 추가

* 토큰 정보 업데이트 기능 추가.
    * 언어 및 국가 정보 등의 정보를 업데이트할 수 있습니다.
* 메세지 수신 통지 기능 추가.
* 리치 메세지 버튼의 액션("Open", "Dismiss", "Reply", etc) 통지 기능 추가.

#### 기능 개선

* 초기화 개선.
    * PushType ("FCM", "TENCENT", etc)으로 초기화가 가능합니다.
* 앱 상태에 따른 알림 노출 정책 변경.
    * 사용자가 앱을 사용 중(Foreground)일 때는 알림을 노출하지 않습니다.
* 사용자 정의 메세지 리시버 사용성 개선.
    * 사용자 정의 메시지 수정 및 알림 생성이 간편해졌습니다.
    * 사용자 정의 알림의 지표 전송이 간편해졌습니다.

## 0.16.2 (2019.06.21)

### TOAST IAP

#### 기능 개선

* 사용자 아이디가 변경되었을 때 동작 개선
* (구)IAP SDK v1.5.3 이전 결제건의 재처리 개선

### TOAST Logger

#### 버그 수정

* 크래시 오류 수정

## 0.16.1 (2019.05.02)

### TOAST SDK

#### Fixed

* Removed 'toast-push-tencent' dependencies from 'toast-sdk'.


## 0.16.0 (2019.04.23)

### TOAST Push

#### Added

* Added Tencent Push.
* Added CustomReceiver.
    * Once the message is received, the message is processed by a user-defined receiver.

## 0.15.0 (2019.03.26)

### TOAST Log & Crash

#### Improved

* Rename ProjectKey to AppKey
    * setProjectKey is still available

### TOAST IAP

#### Added

* Added chinese markets.

### TOAST Push

#### Added

* Added API to unregister a token.
* Added a feature that sets notification's sound when adding a 'sound' field.
    * Only under Android 8.0

## 0.14.3 (2019.03.08)

### TOAST IAP

#### Fixed

* Fixed a issue that doesn't work APIs when a application applies Proguard.

## 0.14.2 (2019.03.04)

### TOAST Push

#### Fixed

* Fixed a crash that occurs when could not obtain a FCM token.

## 0.14.1 (2019.01.29)

### TOAST IAP

#### Fixed

* Fixed an error that could not reprocess old IAP SDK purchases.

## 0.14.0 (2019.01.08)

### TOAST IAP

#### Added

* Added TOAST IAP Unity Plugin.

## 0.13.0 (2018.12.27)

### TOAST Core

#### Improved

* ToastSdk.initialize() is deprecated.
    * It is called automatically on application start.

### TOAST Push

#### Added

* New Functions
    * Firebase Cloud Messaging(FCM)

## 0.12.0 (2018.12.04)

### TOAST IAP

#### Added

* New Functions
    * Google Play Store (One-Time/Subscription Products)
    * ONE store (One-Time Products)

## 0.11.0 (2018.11.20)

### TOAST Log & Crash

#### Added

* Network Insights

## 0.9.0 (2018.09.04)

### TOAST Log & Crash

#### Added

* New Functions
