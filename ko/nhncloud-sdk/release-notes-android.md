## NHN Cloud > SDK 사용 가이드 > 릴리스 노트 > Android

## 1.8.1 (2023. 10. 31.)

### NHN Cloud OCR

#### 기능 개선
* Credit Card Recognizer UI 개선
    * 보안이 강화된 TextView를 적용합니다.

#### 버그 수정
* Camera Focus 이슈 수정
    * 일부 저사양 디바이스에서 Auto Focus가 동작하지 않는 문제를 수정합니다.

## 1.8.0 (2023. 09. 26.)

### NHN Cloud IAP

#### 기능 개선

* Google Billing Client 5.2.1 업데이트
    * 구글 정책에 따라 Android 14 이상을 타겟팅하는 앱은 NHN Cloud IAP 1.8.0 이상으로 업데이트해야 합니다.

### NHN Cloud OCR

#### 기능 개선

* Camera 개선
    * Camera Preview 화면이 디스플레이를 가득 채우도록 변경합니다.
* 최소 지원 버전이 API 22로 상향되었습니다.

## 1.7.1 (2023. 08. 29.)

### NHN Cloud IAP

#### 기능 개선

* MyCard 테스트 결제 개선
* MyCard 최소 지원 버전이 API 21로 상향되었습니다.

## 1.7.0 (2023. 07. 11.)

### NHN Cloud OCR

#### 기능 추가

* OCR(ID Card Recognizer) 추가

## 1.6.0 (2023. 06. 20.)

### NHN Cloud IAP

#### 기능 추가

* ONE store v21 추가

### NHN Cloud Logger

#### 기능 개선

* Android Gradle Plugin 8.0 지원

## 1.5.1 (2023. 05. 30.)

### NHN Cloud IAP

#### 기능 추가

* 결제 상세정보 전송 기능 추가 
    * IAP 콘솔의 Transaction 탭에서 결제 상세정보를 조회할 수 있습니다.

## 1.5.0 (2023. 04. 05.)

### NHN Cloud SDK

#### 기능 개선

* 안정성 개선

### NHN Cloud IAP

#### 기능 추가

* MyCard IAP 추가

## 1.4.3 (2023. 03. 24.)

### NHN Cloud OCR

#### 버그 수정

* NoClassDefFoundError 이슈 수정

## 1.4.2 (2023. 02. 28.)

### NHN Cloud OCR

#### 기능 개선

* 안정성 개선

## 1.4.1 (2023. 01. 11.)

### NHN Cloud Push

#### 기능 개선

* 푸시 지표 전송 및 이벤트 처리 개선

## 1.4.0 (2022. 11. 29.)

### NHN Cloud Logger

#### 기능 추가

* 공공기관용 Logger 지원

### NHN Cloud OCR

#### 기능 개선

* UI 개선

#### 버그 수정

* 카메라 초기화 시 크래시 이슈 수정

### NHN Cloud Push

#### 기능 개선

* 푸시 이벤트 전송 개선
* Intent의 flags가 변경되는 이슈 수정
    * NhnCloudPushMessageReceiver.getContentIntent() 호출 시 전달되는 Intent에 설정된 flags가 유지되지 않는 이슈가 수정되었습니다.

## 1.3.0 (2022. 10. 25.)

### NHN Cloud OCR

#### 기능 추가

* OCR(Credit Card Recognizer) 추가

### NHN Cloud IAP

#### 기능 추가

* [모든 스토어] 활성화 구독 조회 및 미소비 결제 내역 조회 API 추가

### NHN Cloud Push

#### 버그 수정

* NHN Cloud SDK 1.0.0 이상 버전에서 ToastPushMessageReceiver 사용 시 클릭 이벤트 수신 및 지표 수집 불가 오류 수정

## 1.2.0 (2022. 10. 04.)

### NHN Cloud SDK

#### 기능 개선

* AndroidX 지원
    * 최소 지원 버전이 API 16으로 상향되었습니다.

### NHN Cloud Push

#### 기능 개선

* Android 13 대응
    * POST_NOTIFICATION 권한을 요청할 수 있는 API가 추가되었습니다.
    * Notification 채널을 생성할 수 있는 API가 추가되었습니다.  

## 1.1.0 (2022. 09. 06.)

### NHN Cloud IAP

#### 기능 추가

* ONE store v19 추가

#### 기능 개선

* Google Billing Client 5.0.0 업데이트

## 1.0.0 (2022. 07. 12.)

### NHN Cloud SDK

#### 기능 개선

* NHN Cloud Android SDK로 모듈명 변경
	* TOAST Android SDK는 Deprecated 되었습니다.

## 0.31.1 (2022. 06. 14.)

### TOAST Logger

#### 기능 개선

* TOAST Logger 안정화

## 0.31.0 (2022. 05. 10.)

### TOAST IAP

#### 기능 추가

* ONE store 외부 결제 추가

### TOAST Push

#### 기능 추가

* 하나의 Firebase 프로젝트에 등록된 다수의 안드로이드 앱 지원

## 0.30.1 (2022. 05. 03.)

### TOAST IAP

#### 기능 개선

* ONE store v16 아이템 조회 로직 개선

## 0.30.0 (2022. 04. 26.)

### TOAST Push

#### 기능 추가

- ADM(Amazon Device Messaging) 추가

## 0.29.2 (2022. 03. 29.)

### TOAST Push

#### 버그 수정

* 토큰 갱신 시 토큰이 등록되지 않는 문제 수정

## 0.29.1 (2022. 02. 22.)

### TOAST Push

#### 버그 수정

* Google Play 서비스가 설치되어 있지 않은 디바이스에서 FCM 토큰 획득 시 크래시 이슈 수정

## 0.29.0 (2021. 12. 07.)

### TOAST IAP

#### 기능 추가

* 화웨이 스토어(Huawei App Gallery) 추가

## 0.28.0 (2021. 11. 23.)

### TOAST IAP

#### 기능 추가

* Amazon Appstore 추가

### TOAST Push

#### 기능 개선

* Android 12 대응
    * Pending intents mutability.
    * Notification trampoline restrictions.
    * Safer component exporting (android.exported).

> Notification을 직접 생성하는 경우 지표 수집이 가능한 PendingIntent를 반환하는 ToastPushMessageReceiver.getContentIntent()가 추가되었습니다.
이는 Android 12 이상에서 일부 기능이 정상 동작하지 않는 ToastPushMessageReceiver.getNotificationServiceIntent()를 대체합니다.

## 0.27.4 (2021. 10. 26.)

### TOAST Push

#### 버그 수정

* 사용자 알림 채널 설정이 초기화되는 오류 수정

## 0.27.3 (2021. 09. 28.)

### TOAST IAP

#### 기능 개선

* ONE store v16 테스트 결제 프로세스 개선

## 0.27.2 (2021. 09. 06.)

### TOAST Logger

#### 버그 수정

* DeviceModel이 "UNKNOWN"으로 표시되는 오류 수정
    * 유니티에서 크래시 발생 시 DeviceModel이 "UNKNOWN"으로 표시되는 오류가 수정되었습니다.

## 0.27.1 (2021. 08. 24.)

### TOAST IAP

#### 기능 개선

* 구글 구독 결제 프로세스 개선
* ONE store v16 결제 프로세스 개선

## 0.27.0 (2021. 08. 03.)

### TOAST IAP

#### 기능 추가

* ONE store v16 추가

## 0.26.0 (2021. 07. 06.)

### TOAST IAP

#### 기능 추가

* 월 결제 한도 기능 추가

### TOAST Push

#### 버그 수정

* Firebase Messaging 22.0.0 이상 대응
    * Firebase Messaging 22.0.0 이상에서 발생하는 오류가 수정되었습니다.

## 0.25.0 (2021. 04. 27.)

### TOAST IAP

#### 기능 추가

* 구글 구독 상태 조회 API 추가
    * 구글 구독 상태를 조회할 수 있는 querySubscriptionsStatus API 가 추가되었습니다.

#### 기능 개선

* 구글 결제 라이브러리 업데이트
    * 구글 결제 라이브러리 BillingClient 3.0.3이 적용되었습니다.

#### 버그 수정

* Android 11 이상에서 간헐적으로 "취소" 가 반환되는 오류를 수정하였습니다.

## 0.24.4 (2021. 01. 12.)

### TOAST Push

#### 기능 개선

* FCM 토큰 갱신시 업데이트 로직 개선

### TOAST Gradle Plugin (0.0.1)

#### 기능 추가

* Symbol Uploader 기능 추가

## 0.24.3 (2020. 12. 08.)

### TOAST Push

#### 기능 개선

* Tencent QQ 서비스 종료에 따른 모듈 삭제

## 0.24.2 (2020. 11. 24.)

### TOAST Push

#### 버그 수정

* 사용자 아이디 설정과 동시에 토큰 등록 요청시 단말기 식별자로 등록되던 문제 해결

## 0.24.1 (2020. 10. 30.)

### TOAST IAP

#### 버그 수정

* Galaxy Store 인앱 결제 오류 수정
    * Galaxy Apps(Galaxy Store 이전 앱 명칭) 3.x 이하 버전에서 Timeout이 발생하는 오류를 수정하였습니다.

## 0.24.0 (2020. 10. 27.)

### TOAST IAP

#### 기능 추가

* Galaxy Store 추가

#### 기능 개선

* 구글 결제 라이브러리 업데이트
    * 구글 결제 라이브러리 BillingClient 3.0.1이 적용되었습니다.
    * 2021년 8월 2일 부터 모든 새로운 앱은 결제라이브러리 버전 3 이상을 사용해야합니다.
    * 2021년 11월 1일까지 기존 앱에 대한 모든 업데이트는 결제 라이브러리 버전 3 이상을 사용해야합니다.
    * 자세한 사항은 [Meet Google Play Billing Library Version 3](https://android-developers.googleblog.com/2020/06/meet-google-play-billing-library.html)을 참고하세요.
* 구글 정기 결제(구독) 상태 변경에 따른 대응
    * 구글 구독 결제의 갱신 및 만료와 같은 수명주기 동안 다양한 상태 변경(유예 기간, 계정 보류, 복원, 일시중지, 정기 결제 재신청 등)에 대응하였습니다.

### TOAST Push

#### 기능 개선

* 알림 답장 기능 미지원 단말기에서는 답장 기능의 버튼이 생성되지 않도록 수정

#### 버그 수정

* 특정 상황에서 알림 채널이 새로 생성되는 버그 수정

## 0.23.2 (2020. 10. 06.)

### TOAST IAP

#### 버그 수정

* 구독 이슈 수정.
    * 구독이 "계정 보류" 또는 "유예 기간" 상태에서 결제 수단 수정으로 복원된 경우 IapService.PurchasesUpdatedListener를 통해 에러가 통지되지 않도록 수정하였습니다.

## 0.23.1 (2020. 09. 11.)

### TOAST Push

#### 기능 개선

* 토큰 등록 로직 개선

## 0.23.0 (2020. 07. 28.)

### TOAST Push

#### 기능 추가

* 사용자 태그 기능 지원

## 0.22.0 (2020. 06. 23.)

### TOAST IAP

#### 기능 개선

`TOAST IAP SDK 0.22.0 이상으로 업데이트 시 반드시 강제 업데이트를 진행해야 합니다.`

* Google Play Billing Library BillingClient 2.2.1 적용

### TOAST Push

#### 기능 개선

* 기본 알림 옵션 설정 기능 개선

## 0.21.2 (2020. 05. 26.)

### TOAST Push

#### 기능 개선

* 토큰 등록 기능 개선

## 0.21.1 (2020. 04. 28.)

### TOAST Push

#### 기능 개선

* 안정성 개선

### TOAST Logger

#### 기능 개선

* Native Crash Reporting 기능 개선

## 0.21.0 (2020. 03. 24.)

### TOAST Logger

#### 기능 추가

* Native Crash Reporting (NDK) 기능 추가

### TOAST Push

#### 기능 개선

* 기본 알림 옵션에 설정 가능한 항목 추가
    * 포그라운드 알림 노출 여부 설정이 추가되었습니다.
    * 배지 아이콘 사용 여부 설정이 추가되었습니다.

## 0.20.3 (2020. 02. 25.)

### TOAST Push

#### 기능 개선

* 토큰 등록 기능 개선
    * 최초 토큰 등록 시 사용자 아이디가 설정되어 있지 않으면, 단말기 식별자를 사용하여 등록합니다.
    * 토큰 등록 후 ToastSdk.setUserId() 를 사용하여 사용자 아이디를 설정 또는 변경하면 토큰 정보를 갱신합니다.

## 0.20.2 (2020. 01. 21.)

### TOAST Push

#### 기능 개선

* 지표 수집 기능 개선
* 기본 알림 채널 생성 로직 개선

## 0.20.1 (2020. 01. 07.)

### TOAST Push

#### 기능 개선

* Assets 리소스 지원
    * Assets 경로의 이미지 리소스를 지원합니다.
* 기본 옵션 설정 방법 개선
    * AndroidManifest의 meta-data을 사용하여 알림 기본 옵션을 설정할 수 있습니다.

### TOAST IAP

#### 기능 개선
* 보안 강화
    * 내부 보안 정책을 강화하였습니다.

#### 버그 수정

* "Bad base64 Exception" 오류 수정
    * TOAST SDK를 사용하지 않은 결제건 처리 시에 "Bad Base64 Exception"이 발생하는 오류를 수정하였습니다.

## 0.19.4 (2019. 11. 26.)

### TOAST Push

#### 기능 개선

* (구) pushsdk 데이터 마이그레이션 지원.
    * (구) pushsdk 에서 업데이트 한 경우 모든 데이터를 TOAST SDK 로 마이그레이션 합니다.

## 0.19.3 (2019. 10. 18.)

### TOAST Push

#### 기능 개선

* 토큰 등록 기능 개선.

## 0.19.2 (2019. 10. 15.)

### TOAST Push

#### 기능 추가

* 알림 클릭시 통지 기능 추가.
    * 사용자가 알림을 클릭하여 앱이 실행되었을 때에 대한 리스너를 등록할 수 있습니다.
* 배지 기능 지원.
    * 알림 수신시 배지 아이콘과 앱 숏컷 화면에 배지 카운트가 노출됩니다.

#### 기능 개선

* 알림 기본 스타일 지정.
    * 미디어를 포함하지 않는 알림은 BigTextStyle 로 지정되어 두 줄 이상의 메시지도 표현됩니다.

## 0.19.1 (2019. 10. 02.)

### TOAST IAP

#### 기능 추가

* Unity Android IAP Plugin에 구매 요청 시 사용자 데이터를 영수증에 포함할 수 있는 기능이 추가되었습니다.

## 0.19.0 (2019. 10. 01.)

### TOAST IAP

#### 기능 추가

* Android IAP 라이브러리에 구매 요청 시 사용자 데이터를 영수증에 포함할 수 있는 기능이 추가되었습니다.

### TOAST Push

#### 기능 개선

* 사용자 정의 메시지 리시버 사용성 개선.
    * 알림 노출 요청시 사용자 콘텐츠 인텐트 타입이 PendingIntent 로 변경되었습니다.

## 0.18.0 (2019. 08. 27.)

### TOAST IAP

#### 기능 추가

* 소비성 구독 상품 추가.
    * 상품 타입에 소비 가능한 구독 상품이 추가되었습니다.

#### 버그 수정

* Google Play Store 앱 업데이트 시, 결제 결과가 2회 이상 통지되는 오류가 수정되었습니다.

### TOAST Push

#### 기능 추가

* 기본 알림 옵션 설정 기능 추가.
    * 작은 아이콘, 진동, 알림음 등의 기본 옵션을 설정할 수 있습니다.

## 0.17.1 (2019. 07. 23.)

### TOAST Push

#### 기능 추가

* 커스텀 리시버 사용시 메시지 객체내에 FCM 발신자 ID 정보 추가.

## 0.17.0 (2019. 06. 25.)

### TOAST Push

#### 기능 추가

* 토큰 정보 업데이트 기능 추가.
    * 언어 및 국가 정보 등의 정보를 업데이트할 수 있습니다.
* 메시지 수신 통지 기능 추가.
* 리치 메시지 버튼의 액션("Open", "Dismiss", "Reply", etc) 통지 기능 추가.

#### 기능 개선

* 초기화 개선.
    * PushType ("FCM", "TENCENT", etc)으로 초기화가 가능합니다.
* 앱 상태에 따른 알림 노출 정책 변경.
    * 사용자가 앱을 사용 중(Foreground)일 때는 알림을 노출하지 않습니다.
* 사용자 정의 메시지 리시버 사용성 개선.
    * 사용자 정의 메시지 수정 및 알림 생성이 간편해졌습니다.
    * 사용자 정의 알림의 지표 전송이 간편해졌습니다.

## 0.16.2 (2019. 06. 21.)

### TOAST IAP

#### 기능 개선

* 사용자 아이디가 변경되었을 때 동작 개선
* (구)IAP SDK v1.5.3 이전 결제건의 재처리 개선

### TOAST Logger

#### 버그 수정

* 크래시 오류 수정

## 0.16.1 (2019. 05. 02.)

### TOAST SDK

#### Fixed

* 'toast-sdk'에서 'toast-push-tencent' 의존성 제거.

## 0.16.0 (2019. 04. 23.)

### TOAST Push

#### 기능 추가

* Tencent 푸시 추가.
* 사용자 메시지 처리 기능 추가.
    * 메시지가 수신되면 사용자가 정의한 receiver가 메시지를 처리합니다.

## 0.15.0 (2019. 03. 26.)

### TOAST Log & Crash

#### 기능 개선

* ProjectKey가 AppKey로 명칭 변경
    * 기존 setProjectKey는 계속 사용 가능

### TOAST IAP

#### 기능 추가

* 중국 마켓 추가.

### TOAST Push

#### 기능 추가

* 토큰 해제 API 추가.
* sound 필드 추가시 알림의 소리를 설정할 수 있는 기능 추가.
    * 안드로이드 8.0 미만에서만 동작

## 0.14.3 (2019. 03. 08.)

### TOAST IAP

#### 버그 수정

* 앱에서 Proguard를 적용하는 경우, API가 정상적으로 동작하지 않는 문제 해결.

## 0.14.2 (2019. 03. 04.)

### TOAST Push

#### 버그 수정

* FCM 토큰을 획득할 수 없는 경우, 크래시가 발생하는 문제 해결

## 0.14.1 (2019. 01. 29.)

### TOAST IAP

#### 버그 수정

* (구)IAP SDK 결제건을 처리하지 못하는 에러 수정.

## 0.14.0 (2019. 01. 08.)

### TOAST IAP

#### 기능 추가

* TOAST IAP Unity Plugin 추가.

## 0.13.0 (2018. 12. 27.)

### TOAST Core

#### 기능 개선

* ToastSdk.initialize() 메소드 deprecated.
    * Application 시작 시에 자동으로 호출되도록 변경

### TOAST Push

#### 기능 추가

* 신규 기능 추가
    * Firebase Cloud Messaging(FCM)

## 0.12.0 (2018. 12. 04.)

### TOAST IAP

#### 추가 사항

* 신규 기능 추가
    * Google Play Store(소비성 상품, 구독 상품)
    * ONE store(소비성 상품)

## 0.11.0 (2018. 11. 20.)

### TOAST Log & Crash

#### 추가 사항

* Network Insights 기능 추가

## 0.9.0 (2018. 09. 04.)

### TOAST Log & Crash

#### 추가 사항

* 신규 기능 추가
