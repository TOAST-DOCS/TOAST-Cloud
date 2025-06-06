## NHN Cloud > SDK 사용 가이드 > 릴리스 노트 > iOS

## 1.9.0 (2025. 04. 29.)
### NHN Cloud Push
#### 기능 추가 
* Notification Hub 지원 
    * NHNCloudPush SDK에서  Notification Hub를 이용할 수 있습니다.
    * NHNCloudPushConfiguration의 serviceType 프로퍼티에 NHNCloudPushServiceTypeNotificationHub 값을 설정하여 사용 가능합니다.

## 1.8.6 (2024. 11. 15.)
### NHN Cloud Push
#### 개선 사항
* DeviceID를 설정할 수 있는 API 추가 

## 1.8.5 (2024. 10. 08.)
### NHN Cloud IAP
#### 개선 사항
* 결제 상세정보 전송 기능 개선

## 1.8.4 (2024. 09. 11.)
### NHN Cloud Push
#### 개선 사항
* Notification 중복 수신 문제 개선(iOS 18 Beta)
    * iOS 18에서 애플리케이션이 Foreground 상태일 때 Notification이 중복 수신되지 않도록 합니다(OS 버그).

## 1.8.3 (2024. 07. 23.)
### 공통
#### 개선 사항
* 안정성 개선

## 1.8.2 (2024. 06. 25.)
### 공통
#### 개선 사항
* 안정성 개선

## 1.8.1 (2024. 02. 27.)
### 공통
#### 개선 사항
* Privacy manifest 적용  

### NHN Cloud Push
#### 개선 사항
* 특정 환경에서 메시지 클릭 액션이 즉시 동작하지 않는 문제를 수정    

## 1.8.0 (2024. 01. 23.)
### NHN Cloud IAP
#### 개선 사항
* 결제 검증 방식 개선
    * 신규 SDK에서도 (구)영수증 검증을 사용 가능하도록 개선 
        * [(신)영수증 검증 + Notification V2](/Mobile%20Service/IAP/ko/console-apple-guide/#notification-v2)
        * [(구)영수증 검증 + Notification V1 (Deprecated)](/Mobile%20Service/IAP/ko/console-apple-guide/#notification-v1-deprecated)

## 1.7.1 (2023. 12. 19.)
### 공통
#### 개선 사항
* 서명 적용
    * 배포되는 바이너리에 `NHN Cloud Corp.` 서명이 적용되었습니다. 

### Logger 
#### 개선 사항
* Instance Logger의 NetworkInsight 안정성 개선 

### SymbolUploader(v0.0.4)
#### 개선 사항
* 안정성 개선

## 1.7.0 (2023. 11. 14.)
### 공통
#### 개선 사항
* 최소 지원 버전 상향
    * 9.0 > 11.0
* 미지원 아키텍처 지원 종료
    *  i386, armv7s, armv7

### NHN Cloud IAP
#### 개선 사항
* 결제 검증 방식 변경 - [(신)영수증 검증 + Notification V2](/Mobile%20Service/IAP/ko/console-apple-guide/#notification-v2)

## 1.6.2 (2023. 08. 29.)
### 공통
#### 개선 사항
* CountryCode 획득 실패 문제 수정

### NHN Cloud OCR
#### 기능 추가
* 신용카드/신분증 인식 결과 데이터에 인식 영역 추가

## 1.6.1 (2023. 07. 25.)
### NHN Cloud IAP
#### 개선 사항
* 결제 상세정보 전송 기능 개선

## 1.6.0 (2023. 07. 11.)
### NHN Cloud OCR
#### 기능 추가
* OCR(ID Card Recognizer) 추가

## 1.5.0 (2023. 06. 27.)
### NHN Cloud Push
#### 개선 사항
* 토큰 등록 기능 개선
    * 앱의 알림 권한과 무관하게 토큰을 등록할 수 있는 옵션을 제공합니다.

#### SymbolUploader(v0.0.3)
* 안정성 개선

## 1.4.0 (2023. 05. 30.)
### 공통
#### 개선 사항
* SPM(swift package manager) 배포 방식 추가

### NHN Cloud IAP
#### 기능 추가
* 결제 상세정보 전송 기능 추가 
    * IAP 콘솔의 Transaction 탭에서 결제 상세정보를 조회할 수 있습니다.

#### SymbolUploader(v0.0.2)
* run script 개선 
    * Cocoapods, SPM 대응 추가

## 1.3.1 (2023. 05. 19.) - Hotfix
### NHN Cloud Push
#### 개선 사항
* 토큰 등록 기능 개선
    * 토큰 등록 시 앱의 알림 설정이 비활성화되어 있을 경우 다시 `NHNCloudPushErrorPermissionDenied`를 반환합니다.

## 1.3.0 (2023. 02. 28.)
### 공통
#### 개선 사항
* 안정성 개선

## 1.2.1 (2023. 01. 31.)
### NHN Cloud Push
#### 개선 사항
* 토큰 등록 기능 개선

### NHN Cloud OCR
#### 개선 사항
* 신용카드 인식 성능 개선
* 안정성 개선

## 1.2.0 (2022. 11. 29.)
### NHN Cloud Logger
#### 기능 추가
* 공공기관용 Logger 지원

### NHN Cloud Push
#### 개선 사항
* 푸시 이벤트 전송 개선

### NHN Cloud OCR
#### 개선 사항
* UI 개선

## 1.1.0 (2022. 10. 25.)
### 공통
#### 개선 사항
* 안정성 개선

### NHN Cloud IAP
#### 기능 추가
* [모든 스토어] 활성화 구독 조회 및 미소비 결제 내역 조회 API 추가

### NHN Cloud OCR
#### 기능 추가
* OCR(Credit Card Recognizer) 추가

## 1.0.0 (2022. 07. 12.)
### 공통
#### 개선 사항
* 안정성 개선
* NHN Cloud SDK로 모듈명 변경
	* TOAST SDK는 Deprecated 되었습니다.

## 0.30.0 (2022. 03. 29.)
### TOAST IAP
#### 기능 추가
* ToastPurchaseResult에 샌드박스 결제 여부 추가 (sandboxPayment)

## 0.29.2 (2021. 11. 23.)
### TOAST Push
#### 개선 사항
* 안정성 개선

## 0.29.1 (2021. 10. 26.)
### TOAST IAP
#### 개선 사항
* 안정성 개선

## 0.29.0 (2021. 07. 06.)
### 공통
#### 개선 사항
* 안정성 개선

### TOAST IAP
#### 기능 추가
* 월 결제 한도 기능 추가

## 0.28.0 (2021. 05. 25.)
### 공통
#### 개선 사항
* xcframework 추가
    * arm Simulator 지원 추가

### TOAST Logger
#### CrashReporter (BuildInfo 20210525)
* 아키텍쳐 분류 방식 개선
    * iOS14 Core Library가 심볼리케이션되지 않는 문제 개선

## 0.27.2 (2021. 03. 23.)
### 공통
#### 개선 사항
* 안정성 개선

### TOAST Logger
#### SymbolUploader (v0.0.1)
* SymbolUploader 추가

## 0.27.1 (2020. 11. 24.)
### TOAST IAP
#### 개선 사항
* 구독 상품 재구매 오류 수정 (iOS 14 )
- Appstore로부터 상품 정보 획득 실패 시 ToastProductsResponse가 nil을 반환하도록 변경

### TOAST Push
#### 개선 사항
* 토큰 해제 요청 시 등록된 토큰이 없을 경우 Callback이 발생하지 않는 문제 개선

## 0.27.0 (2020. 09. 11.)
### TOAST IAP
#### 기능 추가
* ToastProduct에 지역화된 상품정보 추가 (localizedTitle, localizedDescription)

#### 기능 개선
* iOS 14 beta 변경 사항 대응
    * 결제 실패 Delegate가 수신되지 않는 문제 개선

### TOAST Push
#### 개선 사항
* 안정성 개선

## 0.26.0 (2020. 07. 28.)
### TOAST Push
#### 기능 추가
* 사용자 태그 기능 지원

## 0.25.1 (2020. 07. 03.)
### TOAST Logger
#### 개선 사항
* 안정성 개선

### TOAST Push
#### 개선 사항
* 안정성 개선

## 0.25.0 (2020. 06. 23.)
### 공통
#### 개선 사항
* 안정성 개선

### TOAST Push
#### 개선 사항
* 알림 옵션 설정 인터페이스 분리

## 0.24.1 (2020. 05. 26.)
### TOAST Push
#### 기능 개선
* 토큰 등록 기능 개선

## 0.24.0 (2020. 04. 28.)
### 공통
* TOAST SDK 최소 지원버전 상향 (iOS 8.0 -> iOS 9.0)
* 안정성 개선

### TOAST IAP
#### 추가 사항
* 프로모션 결제의 진행 여부를 선택할 수 있도록 Optional Delegate 추가

### TOAST Push
#### 개선 사항
* 안정성 개선

## 0.23.0 (2020. 03. 24.)
### TOAST Logger
#### 개선 사항
* CrashReport CallStack에 잘못된 문자열이 포함될 수 있는 문제 수정

### TOAST Push
#### 추가 사항
* 알림 옵션 설정 기능 추가
    * 초기화시에 포그라운드 알림 노출, 배지 아이콘 사용, 알림음 사용 여부에 대한 설정이 가능합니다.

## 0.22.1 (2020. 02. 25.)
### TOAST Push
#### 개선 사항
* 토큰 등록 기능 개선
    * 최초 토큰 등록 시 사용자 아이디가 설정되어 있지 않으면, 단말기 식별자를 사용하여 등록합니다.
    * 토큰 등록 후 사용자 아이디를 설정 또는 변경하면 토큰 정보를 갱신합니다.

## 0.22.0 (2020. 02. 11.)
### TOAST IAP
#### 개선 사항
* 안정성 개선

## 0.21.0 (2019. 12. 24.)
### TOAST Logger
#### 개선 사항
* Crash 발생 위치 분류 방식 개선을 위한 데이터 추가

### TOAST IAP
#### 개선 사항
* API 보안 기능 추가
* 안정성 개선
* Swift 인터페이스 추가 정의

## 0.20.1 (2019. 12. 04.)
### 공통
#### 개선 사항
* 초기화 로직 개선

## 0.20.0 (2019. 11. 26.)
### TOAST Push
#### 개선 사항
* 토큰 등록 / 삭제 결과 통지를 콜백 구조로 변경, Delegate 삭제
* 이전에 등록한 동의여부 정보로 토큰을 재등록하는 기능 추가
* VoIP 기능 서브모듈로 분리
* Swift 인터페이스 추가 정의

## 0.19.3 (2019. 10. 29.)
### 공통
#### 버그 수정
* Xcode 11 미만에서 링커 오류 발생 현상 수정

## 0.19.2 (2019. 10. 25.)
### TOAST Push
#### 개선 사항
* (구) TCPushSDK 마이그레이션 지원

## 0.19.1 (2019. 10. 18.)
### TOAST Push
#### 개선 사항
* 토큰 등록 기능 개선

## 0.19.0 (2019. 10. 15.)
### TOAST Push
#### 추가 사항
* 알림 실행에 대한 통지 기능 추가

## 0.18.0 (2019. 10. 01.)
### 공통
#### 개선 사항
* iOS 13 / Xcode 11 대응

### TOAST IAP
#### 추가 사항
* 구매 요청시 사용자 데이터 설정 기능 추가
#### 개선 사항
* 복원 기능 수행 후 복원된 결제건만 반환하도록 변경

### TOAST Push
#### 개선 사항
* ToastPushConfiguration 객체의 Nullability 속성 변경
* 리치 메시지 생성 로직 개선으로 ToastPushMedia 객체의 sourceType, extension 프로퍼티 삭제
* 리치 메시지의 소스 정보에 한글 URL 지원
#### 버그 수정
* 콘솔 설정에 메시지 수신/확인 기능이 사용 안함으로 설정되어 있는 경우 리치 메시지가 정상적으로 표시되지 않던 버그 수정
* iOS 13 이상 환경에서 단말기 토큰을 획득하지 못하는 버그 수정

## 0.17.0 (2019. 08. 27.)
### 공통
#### 개선 사항
* 안정성 개선

### TOAST IAP
#### 추가 사항
* 자동 갱신형 소비성 구독 상품 추가
#### 개선 사항
* 상품 목록 조회시 invalidProducts 에 유효한 상품 목록이 반환되던 문제 수정

### TOAST Push
#### 개선 사항
* 푸쉬 메시지에 알림음을 설정하지 않고 발송시 기본 알림음이 설정되도록 개선

## 0.16.1 (2019. 07. 29.)
### 공통
#### 개선 사항
* 국가코드를 획득하지 못하는 문제 수정

## 0.16.0 (2019. 07. 23.)
### TOAST Logger
#### 개선 사항
* 심볼이 존재하는 바이너리의 경우 CrashReport CallStack에 심볼 문자열이 포함되도록 개선
* CrashReport Reason 이 출력되지 않는 현상 수정

### TOAST IAP
#### 개선 사항
* 결제 성공 상태에서 이전 결제 상태로 변경되는 문제 수정
* 앱 내 구입이 허용되지 않은 상태에서 결제가 요청되던 문제 수정
* 프로모션 결제 개선

### TOAST Push
#### 개선 사항
* 메시지 / 액션 수신 delegate 변경

## 0.15.0 (2019. 06. 25.)
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

## 0.14.1 (2019. 05. 16.)
### TOAST IAP
#### 개선 사항
* 처리중인 재처리 결제건과 동일한 상품 구매시 보유한 상품으로 처리되는 현상 개선

### TOAST Push
#### 개선 사항
* 단말기 캘린더 설정에 따라 지표 이벤트 발생 시간이 잘못 수집되던 버그 수정

## 0.14.0 (2019. 05. 14.)
### 공통
#### 개선 사항
* 네트워크 관련 에러 코드 통합
* 안정성 개선

### TOAST IAP
#### 개선 사항
* 구매 복원 기능 개선
    * AppStore 구매 내역을 기준으로 누락된 결제의 복원 기능 추가
    * 복원 실패 에러 코드 추가
* 결제 결과 클래스에 스토어 요청(프로모션) 여부 추가
* 재처리 대상 확대
* 결제 흐름 개선

### TOAST Push
#### 개선 사항
* 안정성 개선
* 메시지 수신 Delegate 로 전달되는 payload 정보에 메시지 ID 정보 추가
* 광고성 메시지 수신 동의, 야간 광고성 메시지 수신 동의가 불필요한 VoIP 의 경우 수신 동의 여부와 관계 없이 메시지 수신

## 0.13.0 (2019. 03. 26.)
### 공통
#### 개선 사항
* Public Class의 사용성 개선
  * Description 추가
  * Nullability, NSCoding, NSCopying 지원

### TOAST Core
#### 개선 사항
* 내부 예외 처리 추가

### TOAST Logger
#### 추가 사항
* arm64e 아키텍처를 사용하는 기기의 Crash 분석 지원
* PLCrashReporter Dependency 변경

#### 개선 사항
* Configuration Interface 변경
  * Deprecate
    * configurationWithProjectKey
  * Add
    * configurationWithAppKey
* UserID 설정 시점에 따라 전송하는 Log의 UserID가 갱신되지 않을 수 있는 문제 수정

### TOAST IAP
#### 개선 사항
* 내부 예외 처리 추가

### TOAST Push
#### 추가 사항
* 토큰 삭제 API 추가

## 0.12.4 (2019. 03. 19.)
### TOAST Core
#### 개선 사항
* 예외처리 추가

## 0.12.3 (2019. 02. 26.)
### TOAST Core, Common
#### 개선 사항
* 유틸 기능의 예외처리 추가

### TOAST IAP
#### 개선 사항
* 상품정보 캐싱 추가
* 예외처리 추가

## 0.12.2 (2019. 02. 08.) - Hotfix
### TOAST Core
#### 개선 사항
* ToastTransfer에서 간헐적으로 발생하던 Crash 방지를 위해 방어코드 추가

## 0.12.1 (2019. 01. 08.)
### TOAST IAP
#### 개선 사항
* 특정 상황에서 결제 상태가 VerifyEnd인 결제의 재처리가 동작하지 않던 문제 수정

## 0.12.0 (2018. 12. 27.)
### TOAST Core
#### 개선 사항
* ToastTransfer에서 간헐적으로 발생하던 Crash 방지를 위해 방어코드 추가

### TOAST Push
#### 추가 사항
* 신규 기능 추가

### TOAST IAP
#### 개선 사항
* Apple에서 재처리해주는 Transaction의 처리가 가능하도록 UserID Check 로직의 예외처리 추가
* ToastOperation에서 간헐적으로 발생하던 Crash 방지를 위해 방어코드 추가


## 0.11.1 (2018. 12. 04.)
### TOAST IAP
#### 추가 사항
* 신규 기능 추가


## 0.11.0 (2018. 11. 20.)
### TOAST Log & Crash
#### 추가 사항
* Network Insights 기능 추가


## 0.9.0 (2018. 09. 04.)
### TOAST Log & Crash
#### 추가 사항
* 신규 기능 추가
