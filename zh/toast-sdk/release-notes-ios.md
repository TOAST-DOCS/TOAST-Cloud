## TOAST > User Guide for TOAST SDK > Release Notes > iOS

## 0.16.0 (2019.07.23)

### TOAST Logger 

#### 개선 사항 
- 심볼이 존재하는 바이너리의 경우 CrashReport CallStack에 심볼 문자열이 포함되도록 개선
- CrashReport Reason 이 출력되지 않는 현상 수정

### TOAST IAP

#### 개선 사항

* 결제 성공 상태에서 이전 결제 상태로 변경되는 문제 수정
* 앱 내 구입이 허용되지 않은 상태에서 결제가 요청되던 문제 수정
* 프로모션 결제 개선

### TOAST Push

#### 개선 사항

* 메세지 / 액션 수신 delegate 변경

## 0.15.0 (2019.06.25)

### TOAST IAP

#### 개선 사항

* 신규 결제, 프로모션 결제, 미소비 내역 조회 요청시 미완료 결제건 재처리 로직 추가

### TOAST Push

#### 추가 사항

* 초기화 시 국가, 언어코드 설정 기능 추가
* 토큰 정보 업데이트 기능 추가
* 알림 옵션 설정 기능 추가

#### 개선 사항

* 알림 옵션의 기본 설정 변경 
    * 앱 실행 중에는 알림을 표시하지 않도록 변경
        * 이전과 동일한 동작을 위해서는 [여기](./push-ios/#_6)를 확인하세요.    

## 0.14.1 (2019.05.16)

### TOAST IAP

#### Fixed

* Improved non-purchasing phenomena when tried to purchase the same product as reprocessing in progress.

### TOAST Push

#### Fixed

* Fixes a bug that was incorrectly collected for indicator events according to the device calendar settings.

## 0.14.0 (2019.05.14)

### Common

#### Fixed

* Network error code integration
* Improvement in safety

### TOAST IAP

#### Fixed

* Improved purchasing restore
    * Adds a restore feature for missing payments based on AppStore receipt 
    * Add restore failure error code
* Adding a store request(promotion) flag to the purchase result class
* Expand reprocessing target
* Improve purchase flow

### TOAST Push

#### Fixed

* Improvement in safety
* Adding message id in payload that is passed to delegate
* In the case of VoIP, which does not require consent to receive a advertisement message or a night advertisement message, a message is received regardless of whether the user agrees to receive it or not

## 0.13.0 (2019.03.26)

### Common

#### Fixed

* Improved Usability of Public Class
  * Add Description
  * Support Nullability, NSCoding, NSCopying

### TOAST Core

#### Fixed

* Add Internal Exception Processing

### TOAST Logger

#### Added

* Support for Crash analysis of devices using the arm64e architecture
* Change PLCrashReporter Dependency

#### Fixed

* Change Configuration Interface
  * Deprecate
    * configurationWithProjectKey
  * Add
    * configurationWithAppKey

#### Bug Fixed

* Modify a problem that may not update the UserID of the Log that is sent at the time of UserID setup

### TOAST IAP

#### Fixed

* Add Internal Exception Processing

### TOAST Push

#### Added

* Add unregisterToken API

## 0.12.4 (2019.03.19)

### TOAST Core

#### Fixed

* Add a exception 

## 0.12.3 (2019.02.26)

### TOAST Core, Common

#### Fixed

* Add a exception for util function

### TOAST IAP

#### Fixed

* Add products information caching 
* Add a exception 

## 0.12.2 (2019.02.08) - Hotfix

### TOAST Core

#### Fixed

* Add a defense code for crashes in ToastTransfer

## 0.12.1 (2019.01.08)

### TOAST IAP

#### Fixed

* Fixed an issue where VerifyEnd could not be reprocessed under certain circumstances

## 0.12.0 (2018.12.27)

### TOAST Core

#### Fixed

* Add a defense code for crashes in ToastTransfer

### TOAST Push

#### Fixed 

* New Functions 

### TOAST IAP

#### Fixed

* Added exception handling for UserID verification logic to handle reprocessed transactions delivered by Apple
* Add a defense code for crashes in ToastOperation

## 0.11.1 (2018.12.04)

### TOAST IAP

#### Added 

* New Functions 


## 0.11.0 (2018.11.20)

### TOAST Log & Crash

#### Added 

* Network Insights


## 0.9.0 (2018.09.04)

### TOAST Log & Crash

#### Added

* New Functions
