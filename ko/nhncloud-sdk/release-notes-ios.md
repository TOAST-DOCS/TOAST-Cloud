<!-- pre-align:aligned sig=58f2c1b24700 -->

## NHN Cloud > SDK 사용 가이드 > 릴리스 노트 > iOS

<a id="90-2025-04-29"></a>

## 1.9.0 (2025. 04. 29.)
<a id="nhn-cloud-push"></a>

### NHN Cloud Push
<a id="added-features"></a>

#### 기능 추가 
* Notification Hub 지원 
    * NHNCloudPush SDK에서  Notification Hub를 이용할 수 있습니다.
    * NHNCloudPushConfiguration의 serviceType 프로퍼티에 NHNCloudPushServiceTypeNotificationHub 값을 설정하여 사용 가능합니다.

<a id="86-2024-11-15"></a>

## 1.8.6 (2024. 11. 15.)
<a id="nhn-cloud-push-2"></a>

### NHN Cloud Push
<a id="improved"></a>

#### 개선 사항
* DeviceID를 설정할 수 있는 API 추가 

<a id="85-2024-10-08"></a>

## 1.8.5 (2024. 10. 08.)
<a id="nhn-cloud-iap"></a>

### NHN Cloud IAP
<a id="improved-2"></a>

#### 개선 사항
* 결제 상세정보 전송 기능 개선

<a id="84-2024-09-11"></a>

## 1.8.4 (2024. 09. 11.)
<a id="nhn-cloud-push-3"></a>

### NHN Cloud Push
<a id="improved-3"></a>

#### 개선 사항
* Notification 중복 수신 문제 개선(iOS 18 Beta)
    * iOS 18에서 애플리케이션이 Foreground 상태일 때 Notification이 중복 수신되지 않도록 합니다(OS 버그).

<a id="83-2024-07-23"></a>

## 1.8.3 (2024. 07. 23.)
<a id="common"></a>

### 공통
<a id="improved-4"></a>

#### 개선 사항
* 안정성 개선

<a id="82-2024-06-25"></a>

## 1.8.2 (2024. 06. 25.)
<a id="common-2"></a>

### 공통
<a id="improved-5"></a>

#### 개선 사항
* 안정성 개선

<a id="81-2024-02-27"></a>

## 1.8.1 (2024. 02. 27.)
<a id="common-3"></a>

### 공통
<a id="improved-6"></a>

#### 개선 사항
* Privacy manifest 적용  

<a id="nhn-cloud-push-4"></a>

### NHN Cloud Push
<a id="improved-7"></a>

#### 개선 사항
* 특정 환경에서 메시지 클릭 액션이 즉시 동작하지 않는 문제를 수정    

<a id="80-2024-01-23"></a>

## 1.8.0 (2024. 01. 23.)
<a id="nhn-cloud-iap-2"></a>

### NHN Cloud IAP
<a id="improved-8"></a>

#### 개선 사항
* 결제 검증 방식 개선
    * 신규 SDK에서도 (구)영수증 검증을 사용 가능하도록 개선 
        * [(신)영수증 검증 + Notification V2](/Mobile%20Service/IAP/ko/console-apple-guide/#notification-v2)
        * [(구)영수증 검증 + Notification V1 (Deprecated)](/Mobile%20Service/IAP/ko/console-apple-guide/#notification-v1-deprecated)

<a id="71-2023-12-19"></a>

## 1.7.1 (2023. 12. 19.)
<a id="common-4"></a>

### 공통
<a id="improved-9"></a>

#### 개선 사항
* 서명 적용
    * 배포되는 바이너리에 `NHN Cloud Corp.` 서명이 적용되었습니다. 

<a id="logger"></a>

### Logger 
<a id="improved-10"></a>

#### 개선 사항
* Instance Logger의 NetworkInsight 안정성 개선 

<a id="symboluploaderv004"></a>

### SymbolUploader(v0.0.4)
<a id="improved-11"></a>

#### 개선 사항
* 안정성 개선

<a id="70-2023-11-14"></a>

## 1.7.0 (2023. 11. 14.)
<a id="common-5"></a>

### 공통
<a id="improved-12"></a>

#### 개선 사항
* 최소 지원 버전 상향
    * 9.0 > 11.0
* 미지원 아키텍처 지원 종료
    *  i386, armv7s, armv7

<a id="nhn-cloud-iap-3"></a>

### NHN Cloud IAP
<a id="improved-13"></a>

#### 개선 사항
* 결제 검증 방식 변경 - [(신)영수증 검증 + Notification V2](/Mobile%20Service/IAP/ko/console-apple-guide/#notification-v2)

<a id="62-2023-08-29"></a>

## 1.6.2 (2023. 08. 29.)
<a id="common-6"></a>

### 공통
<a id="improved-14"></a>

#### 개선 사항
* CountryCode 획득 실패 문제 수정

<a id="nhn-cloud-ocr"></a>

### NHN Cloud OCR
<a id="added-features-2"></a>

#### 기능 추가
* 신용카드/신분증 인식 결과 데이터에 인식 영역 추가

<a id="61-2023-07-25"></a>

## 1.6.1 (2023. 07. 25.)
<a id="nhn-cloud-iap-4"></a>

### NHN Cloud IAP
<a id="improved-15"></a>

#### 개선 사항
* 결제 상세정보 전송 기능 개선

<a id="60-2023-07-11"></a>

## 1.6.0 (2023. 07. 11.)
<a id="nhn-cloud-ocr-2"></a>

### NHN Cloud OCR
<a id="added-features-3"></a>

#### 기능 추가
* OCR(ID Card Recognizer) 추가

<a id="50-2023-06-27"></a>

## 1.5.0 (2023. 06. 27.)
<a id="nhn-cloud-push-5"></a>

### NHN Cloud Push
<a id="improved-16"></a>

#### 개선 사항
* 토큰 등록 기능 개선
    * 앱의 알림 권한과 무관하게 토큰을 등록할 수 있는 옵션을 제공합니다.

<a id="symboluploaderv003"></a>

#### SymbolUploader(v0.0.3)
* 안정성 개선

<a id="40-2023-05-30"></a>

## 1.4.0 (2023. 05. 30.)
<a id="common-7"></a>

### 공통
<a id="improved-17"></a>

#### 개선 사항
* SPM(swift package manager) 배포 방식 추가

<a id="nhn-cloud-iap-5"></a>

### NHN Cloud IAP
<a id="added-featrues"></a>

#### 기능 추가
* 결제 상세정보 전송 기능 추가 
    * IAP 콘솔의 Transaction 탭에서 결제 상세정보를 조회할 수 있습니다.

<a id="symboluploaderv002"></a>

#### SymbolUploader(v0.0.2)
* run script 개선 
    * Cocoapods, SPM 대응 추가

<a id="31-2023-05-19---hotfix"></a>

## 1.3.1 (2023. 05. 19.) - Hotfix
<a id="nhn-cloud-push-6"></a>

### NHN Cloud Push
<a id="improved-18"></a>

#### 개선 사항
* 토큰 등록 기능 개선
    * 토큰 등록 시 앱의 알림 설정이 비활성화되어 있을 경우 다시 `NHNCloudPushErrorPermissionDenied`를 반환합니다.

<a id="30-2023-02-28"></a>

## 1.3.0 (2023. 02. 28.)
<a id="common-8"></a>

### 공통
<a id="improved-19"></a>

#### 개선 사항
* 안정성 개선

<a id="21-2023-01-31"></a>

## 1.2.1 (2023. 01. 31.)
<a id="nhn-cloud-push-7"></a>

### NHN Cloud Push
<a id="improved-20"></a>

#### 개선 사항
* 토큰 등록 기능 개선

<a id="nhn-cloud-ocr-3"></a>

### NHN Cloud OCR
<a id="improved-21"></a>

#### 개선 사항
* 신용카드 인식 성능 개선
* 안정성 개선

<a id="20-2022-11-29"></a>

## 1.2.0 (2022. 11. 29.)
<a id="nhn-cloud-logger"></a>

### NHN Cloud Logger
<a id="added-features-4"></a>

#### 기능 추가
* 공공기관용 Logger 지원

<a id="nhn-cloud-push-8"></a>

### NHN Cloud Push
<a id="improved-22"></a>

#### 개선 사항
* 푸시 이벤트 전송 개선

<a id="nhn-cloud-ocr-4"></a>

### NHN Cloud OCR
<a id="improved-23"></a>

#### 개선 사항
* UI 개선

<a id="10-2022-10-25"></a>

## 1.1.0 (2022. 10. 25.)
<a id="common-9"></a>

### 공통
<a id="improvements"></a>

#### 개선 사항
* 안정성 개선

<a id="nhn-cloud-iap-6"></a>

### NHN Cloud IAP
<a id="added-features-5"></a>

#### 기능 추가
* [모든 스토어] 활성화 구독 조회 및 미소비 결제 내역 조회 API 추가

<a id="nhn-cloud-ocr-5"></a>

### NHN Cloud OCR
<a id="added-features-6"></a>

#### 기능 추가
* OCR(Credit Card Recognizer) 추가

<a id="00-2022-07-12"></a>

## 1.0.0 (2022. 07. 12.)
<a id="common-10"></a>

### 공통
<a id="improvements-2"></a>

#### 개선 사항
* 안정성 개선
* NHN Cloud SDK로 모듈명 변경
	* TOAST SDK는 Deprecated 되었습니다.

<a id="300-2022-03-29"></a>

## 0.30.0 (2022. 03. 29.)
<a id="toast-iap"></a>

### TOAST IAP
<a id="added-features-7"></a>

#### 기능 추가
* ToastPurchaseResult에 샌드박스 결제 여부 추가 (sandboxPayment)

<a id="292-2021-11-23"></a>

## 0.29.2 (2021. 11. 23.)
<a id="toast-push"></a>

### TOAST Push
<a id="improvements-3"></a>

#### 개선 사항
* 안정성 개선

<a id="291-2021-10-26"></a>

## 0.29.1 (2021. 10. 26.)
<a id="toast-iap-2"></a>

### TOAST IAP
<a id="improvements-4"></a>

#### 개선 사항
* 안정성 개선

<a id="290-2021-07-06"></a>

## 0.29.0 (2021. 07. 06.)
<a id="common-11"></a>

### 공통
<a id="improvements-5"></a>

#### 개선 사항
* 안정성 개선

<a id="toast-iap-3"></a>

### TOAST IAP
<a id="added-features-8"></a>

#### 기능 추가
* 월 결제 한도 기능 추가

<a id="280-2021-05-25"></a>

## 0.28.0 (2021. 05. 25.)
<a id="common-12"></a>

### 공통
<a id="improvements-6"></a>

#### 개선 사항
* xcframework 추가
    * arm Simulator 지원 추가

<a id="toast-logger"></a>

### TOAST Logger
<a id="crashreporter-buildinfo-20210525"></a>

#### CrashReporter (BuildInfo 20210525)
* 아키텍쳐 분류 방식 개선
    * iOS14 Core Library가 심볼리케이션되지 않는 문제 개선

<a id="272-2021-03-23"></a>

## 0.27.2 (2021. 03. 23.)
<a id="common-13"></a>

### 공통
<a id="improvements-7"></a>

#### 개선 사항
* 안정성 개선

<a id="toast-logger-2"></a>

### TOAST Logger
<a id="symboluploader-v001"></a>

#### SymbolUploader (v0.0.1)
* SymbolUploader 추가

<a id="271-2020-11-24"></a>

## 0.27.1 (2020. 11. 24.)
<a id="toast-iap-4"></a>

### TOAST IAP
<a id="improvements-8"></a>

#### 개선 사항
* 구독 상품 재구매 오류 수정 (iOS 14 )
- Appstore로부터 상품 정보 획득 실패 시 ToastProductsResponse가 nil을 반환하도록 변경

<a id="toast-push-2"></a>

### TOAST Push
<a id="improvements-9"></a>

#### 개선 사항
* 토큰 해제 요청 시 등록된 토큰이 없을 경우 Callback이 발생하지 않는 문제 개선

<a id="270-2020-09-11"></a>

## 0.27.0 (2020. 09. 11.)
<a id="toast-iap-5"></a>

### TOAST IAP
<a id="added-features-9"></a>

#### 기능 추가
* ToastProduct에 지역화된 상품정보 추가 (localizedTitle, localizedDescription)

<a id="improvements-10"></a>

#### 기능 개선
* iOS 14 beta 변경 사항 대응
    * 결제 실패 Delegate가 수신되지 않는 문제 개선

<a id="toast-push-3"></a>

### TOAST Push
<a id="improvements-11"></a>

#### 개선 사항
* 안정성 개선

<a id="260-2020-07-28"></a>

## 0.26.0 (2020. 07. 28.)
<a id="toast-push-4"></a>

### TOAST Push
<a id="added-features-10"></a>

#### 기능 추가
* 사용자 태그 기능 지원

<a id="251-2020-07-03"></a>

## 0.25.1 (2020. 07. 03.)
<a id="toast-logger-3"></a>

### TOAST Logger
<a id="improvements-12"></a>

#### 개선 사항
* 안정성 개선

<a id="toast-push-5"></a>

### TOAST Push
<a id="improvements-13"></a>

#### 개선 사항
* 안정성 개선

<a id="250-2020-06-23"></a>

## 0.25.0 (2020. 06. 23.)
<a id="common-14"></a>

### 공통
<a id="improvements-14"></a>

#### 개선 사항
* 안정성 개선

<a id="toast-push-6"></a>

### TOAST Push
<a id="improvements-15"></a>

#### 개선 사항
* 알림 옵션 설정 인터페이스 분리

<a id="241-2020-05-26"></a>

## 0.24.1 (2020. 05. 26.)
<a id="toast-push-7"></a>

### TOAST Push
<a id="improvements-16"></a>

#### 기능 개선
* 토큰 등록 기능 개선

<a id="240-2020-04-28"></a>

## 0.24.0 (2020. 04. 28.)
<a id="common-15"></a>

### 공통
* TOAST SDK 최소 지원버전 상향 (iOS 8.0 -> iOS 9.0)
* 안정성 개선

<a id="toast-iap-6"></a>

### TOAST IAP
<a id="added-features-11"></a>

#### 추가 사항
* 프로모션 결제의 진행 여부를 선택할 수 있도록 Optional Delegate 추가

<a id="toast-push-8"></a>

### TOAST Push
<a id="improvements-17"></a>

#### 개선 사항
* 안정성 개선

<a id="230-2020-03-24"></a>

## 0.23.0 (2020. 03. 24.)
<a id="toast-logger-4"></a>

### TOAST Logger
<a id="improvements-18"></a>

#### 개선 사항
* CrashReport CallStack에 잘못된 문자열이 포함될 수 있는 문제 수정

<a id="toast-push-9"></a>

### TOAST Push
<a id="added-features-12"></a>

#### 추가 사항
* 알림 옵션 설정 기능 추가
    * 초기화시에 포그라운드 알림 노출, 배지 아이콘 사용, 알림음 사용 여부에 대한 설정이 가능합니다.

<a id="221-2020-02-25"></a>

## 0.22.1 (2020. 02. 25.)
<a id="toast-push-10"></a>

### TOAST Push
<a id="improvements-19"></a>

#### 개선 사항
* 토큰 등록 기능 개선
    * 최초 토큰 등록 시 사용자 아이디가 설정되어 있지 않으면, 단말기 식별자를 사용하여 등록합니다.
    * 토큰 등록 후 사용자 아이디를 설정 또는 변경하면 토큰 정보를 갱신합니다.

<a id="220-2020-02-11"></a>

## 0.22.0 (2020. 02. 11.)
<a id="toast-iap-7"></a>

### TOAST IAP
<a id="improvements-20"></a>

#### 개선 사항
* 안정성 개선

<a id="210-2019-12-24"></a>

## 0.21.0 (2019. 12. 24.)
<a id="toast-logger-5"></a>

### TOAST Logger
<a id="improvements-21"></a>

#### 개선 사항
* Crash 발생 위치 분류 방식 개선을 위한 데이터 추가

<a id="toast-iap-8"></a>

### TOAST IAP
<a id="improvements-22"></a>

#### 개선 사항
* API 보안 기능 추가
* 안정성 개선
* Swift 인터페이스 추가 정의

<a id="201-2019-12-04"></a>

## 0.20.1 (2019. 12. 04.)
<a id="common-16"></a>

### 공통
<a id="improvements-23"></a>

#### 개선 사항
* 초기화 로직 개선

<a id="200-2019-11-26"></a>

## 0.20.0 (2019. 11. 26.)
<a id="toast-push-11"></a>

### TOAST Push
<a id="improvements-24"></a>

#### 개선 사항
* 토큰 등록 / 삭제 결과 통지를 콜백 구조로 변경, Delegate 삭제
* 이전에 등록한 동의여부 정보로 토큰을 재등록하는 기능 추가
* VoIP 기능 서브모듈로 분리
* Swift 인터페이스 추가 정의

<a id="193-2019-10-29"></a>

## 0.19.3 (2019. 10. 29.)
<a id="common-17"></a>

### 공통
<a id="bug-fixes"></a>

#### 버그 수정
* Xcode 11 미만에서 링커 오류 발생 현상 수정

<a id="192-2019-10-25"></a>

## 0.19.2 (2019. 10. 25.)
<a id="toast-push-12"></a>

### TOAST Push
<a id="improvements-25"></a>

#### 개선 사항
* (구) TCPushSDK 마이그레이션 지원

<a id="191-2019-10-18"></a>

## 0.19.1 (2019. 10. 18.)
<a id="toast-push-13"></a>

### TOAST Push
<a id="improvements-26"></a>

#### 개선 사항
* 토큰 등록 기능 개선

<a id="190-2019-10-15"></a>

## 0.19.0 (2019. 10. 15.)
<a id="toast-push-14"></a>

### TOAST Push
<a id="added-features-13"></a>

#### 추가 사항
* 알림 실행에 대한 통지 기능 추가

<a id="180-2019-10-01"></a>

## 0.18.0 (2019. 10. 01.)
<a id="common-18"></a>

### 공통
<a id="improvements-27"></a>

#### 개선 사항
* iOS 13 / Xcode 11 대응

<a id="toast-iap-9"></a>

### TOAST IAP
<a id="added-features-14"></a>

#### 추가 사항
* 구매 요청시 사용자 데이터 설정 기능 추가
<a id="improvements-28"></a>

#### 개선 사항
* 복원 기능 수행 후 복원된 결제건만 반환하도록 변경

<a id="toast-push-15"></a>

### TOAST Push
<a id="improvements-29"></a>

#### 개선 사항
* ToastPushConfiguration 객체의 Nullability 속성 변경
* 리치 메시지 생성 로직 개선으로 ToastPushMedia 객체의 sourceType, extension 프로퍼티 삭제
* 리치 메시지의 소스 정보에 한글 URL 지원
<a id="bug-fixes-2"></a>

#### 버그 수정
* 콘솔 설정에 메시지 수신/확인 기능이 사용 안함으로 설정되어 있는 경우 리치 메시지가 정상적으로 표시되지 않던 버그 수정
* iOS 13 이상 환경에서 단말기 토큰을 획득하지 못하는 버그 수정

<a id="170-2019-08-27"></a>

## 0.17.0 (2019. 08. 27.)
<a id="common-19"></a>

### 공통
<a id="improvements-30"></a>

#### 개선 사항
* 안정성 개선

<a id="toast-iap-10"></a>

### TOAST IAP
<a id="added-features-15"></a>

#### 추가 사항
* 자동 갱신형 소비성 구독 상품 추가
<a id="improvements-31"></a>

#### 개선 사항
* 상품 목록 조회시 invalidProducts 에 유효한 상품 목록이 반환되던 문제 수정

<a id="toast-push-16"></a>

### TOAST Push
<a id="improvements-32"></a>

#### 개선 사항
* 푸쉬 메시지에 알림음을 설정하지 않고 발송시 기본 알림음이 설정되도록 개선

<a id="161-2019-07-29"></a>

## 0.16.1 (2019. 07. 29.)
<a id="common-20"></a>

### 공통
<a id="improvements-33"></a>

#### 개선 사항
* 국가코드를 획득하지 못하는 문제 수정

<a id="160-2019-07-23"></a>

## 0.16.0 (2019. 07. 23.)
<a id="toast-logger-6"></a>

### TOAST Logger
<a id="improvements-34"></a>

#### 개선 사항
* 심볼이 존재하는 바이너리의 경우 CrashReport CallStack에 심볼 문자열이 포함되도록 개선
* CrashReport Reason 이 출력되지 않는 현상 수정

<a id="toast-iap-11"></a>

### TOAST IAP
<a id="improvements-35"></a>

#### 개선 사항
* 결제 성공 상태에서 이전 결제 상태로 변경되는 문제 수정
* 앱 내 구입이 허용되지 않은 상태에서 결제가 요청되던 문제 수정
* 프로모션 결제 개선

<a id="toast-push-17"></a>

### TOAST Push
<a id="improvements-36"></a>

#### 개선 사항
* 메시지 / 액션 수신 delegate 변경

<a id="150-2019-06-25"></a>

## 0.15.0 (2019. 06. 25.)
<a id="toast-iap-12"></a>

### TOAST IAP
<a id="improvements-37"></a>

#### 개선 사항
* 신규 결제, 프로모션 결제, 미소비 내역 조회 요청시 미완료 결제건 재처리 로직 추가

<a id="toast-push-18"></a>

### TOAST Push
<a id="added-features-16"></a>

#### 추가 사항
* 초기화 시 국가, 언어코드 설정 기능 추가
* 토큰 정보 업데이트 기능 추가
* 알림 옵션 설정 기능 추가

<a id="improvements-38"></a>

#### 개선 사항
* 알림 옵션의 기본 설정 변경
    * 앱 실행 중에는 알림을 표시하지 않도록 변경
        * 이전과 동일한 동작을 위해서는 [여기](./push-ios/#_6)를 확인하세요.

<a id="141-2019-05-16"></a>

## 0.14.1 (2019. 05. 16.)
<a id="toast-iap-13"></a>

### TOAST IAP
<a id="improvements-39"></a>

#### 개선 사항
* 처리중인 재처리 결제건과 동일한 상품 구매시 보유한 상품으로 처리되는 현상 개선

<a id="toast-push-19"></a>

### TOAST Push
<a id="improvements-40"></a>

#### 개선 사항
* 단말기 캘린더 설정에 따라 지표 이벤트 발생 시간이 잘못 수집되던 버그 수정

<a id="140-2019-05-14"></a>

## 0.14.0 (2019. 05. 14.)
<a id="common-21"></a>

### 공통
<a id="improvements-41"></a>

#### 개선 사항
* 네트워크 관련 에러 코드 통합
* 안정성 개선

<a id="toast-iap-14"></a>

### TOAST IAP
<a id="improvements-42"></a>

#### 개선 사항
* 구매 복원 기능 개선
    * AppStore 구매 내역을 기준으로 누락된 결제의 복원 기능 추가
    * 복원 실패 에러 코드 추가
* 결제 결과 클래스에 스토어 요청(프로모션) 여부 추가
* 재처리 대상 확대
* 결제 흐름 개선

<a id="toast-push-20"></a>

### TOAST Push
<a id="improvements-43"></a>

#### 개선 사항
* 안정성 개선
* 메시지 수신 Delegate 로 전달되는 payload 정보에 메시지 ID 정보 추가
* 광고성 메시지 수신 동의, 야간 광고성 메시지 수신 동의가 불필요한 VoIP 의 경우 수신 동의 여부와 관계 없이 메시지 수신

<a id="130-2019-03-26"></a>

## 0.13.0 (2019. 03. 26.)
<a id="common-22"></a>

### 공통
<a id="improvements-44"></a>

#### 개선 사항
* Public Class의 사용성 개선
  * Description 추가
  * Nullability, NSCoding, NSCopying 지원

<a id="toast-core"></a>

### TOAST Core
<a id="improvements-45"></a>

#### 개선 사항
* 내부 예외 처리 추가

<a id="toast-logger-7"></a>

### TOAST Logger
<a id="added-features-17"></a>

#### 추가 사항
* arm64e 아키텍처를 사용하는 기기의 Crash 분석 지원
* PLCrashReporter Dependency 변경

<a id="improvements-46"></a>

#### 개선 사항
* Configuration Interface 변경
  * Deprecate
    * configurationWithProjectKey
  * Add
    * configurationWithAppKey
* UserID 설정 시점에 따라 전송하는 Log의 UserID가 갱신되지 않을 수 있는 문제 수정

<a id="toast-iap-15"></a>

### TOAST IAP
<a id="improvements-47"></a>

#### 개선 사항
* 내부 예외 처리 추가

<a id="toast-push-21"></a>

### TOAST Push
<a id="added-features-18"></a>

#### 추가 사항
* 토큰 삭제 API 추가

<a id="124-2019-03-19"></a>

## 0.12.4 (2019. 03. 19.)
<a id="toast-core-2"></a>

### TOAST Core
<a id="improvements-48"></a>

#### 개선 사항
* 예외처리 추가

<a id="123-2019-02-26"></a>

## 0.12.3 (2019. 02. 26.)
<a id="toast-core-common"></a>

### TOAST Core, Common
<a id="improvements-49"></a>

#### 개선 사항
* 유틸 기능의 예외처리 추가

<a id="toast-iap-16"></a>

### TOAST IAP
<a id="improvements-50"></a>

#### 개선 사항
* 상품정보 캐싱 추가
* 예외처리 추가

<a id="122-2019-02-08---hotfix"></a>

## 0.12.2 (2019. 02. 08.) - Hotfix
<a id="toast-core-3"></a>

### TOAST Core
<a id="improvements-51"></a>

#### 개선 사항
* ToastTransfer에서 간헐적으로 발생하던 Crash 방지를 위해 방어코드 추가

<a id="121-2019-01-08"></a>

## 0.12.1 (2019. 01. 08.)
<a id="toast-iap-17"></a>

### TOAST IAP
<a id="improvements-52"></a>

#### 개선 사항
* 특정 상황에서 결제 상태가 VerifyEnd인 결제의 재처리가 동작하지 않던 문제 수정

<a id="120-2018-12-27"></a>

## 0.12.0 (2018. 12. 27.)
<a id="toast-core-4"></a>

### TOAST Core
<a id="improvements-53"></a>

#### 개선 사항
* ToastTransfer에서 간헐적으로 발생하던 Crash 방지를 위해 방어코드 추가

<a id="toast-push-22"></a>

### TOAST Push
<a id="added-features-19"></a>

#### 추가 사항
* 신규 기능 추가

<a id="toast-iap-18"></a>

### TOAST IAP
<a id="improvements-54"></a>

#### 개선 사항
* Apple에서 재처리해주는 Transaction의 처리가 가능하도록 UserID Check 로직의 예외처리 추가
* ToastOperation에서 간헐적으로 발생하던 Crash 방지를 위해 방어코드 추가


<a id="111-2018-12-04"></a>

## 0.11.1 (2018. 12. 04.)
<a id="toast-iap-19"></a>

### TOAST IAP
<a id="added-features-20"></a>

#### 추가 사항
* 신규 기능 추가


<a id="110-2018-11-20"></a>

## 0.11.0 (2018. 11. 20.)
<a id="toast-log-crash"></a>

### TOAST Log & Crash
<a id="added-features-21"></a>

#### 추가 사항
* Network Insights 기능 추가


<a id="90-2018-09-04"></a>

## 0.9.0 (2018. 09. 04.)
<a id="toast-log-crash-2"></a>

### TOAST Log & Crash
<a id="added-features-22"></a>

#### 추가 사항
* 신규 기능 추가
