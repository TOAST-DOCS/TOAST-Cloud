<!-- pre-align:aligned sig=df783d99cb29 -->

## NHN Cloud > SDK 사용 가이드 > 릴리스 노트 > Android

<a id="121-october-28-2025"></a>

## 1.12.1 (2025. 10. 28.)

<a id="nhn-cloud-ocr"></a>

### NHN Cloud OCR

<a id="bug-fixes"></a>

#### 버그 수정

* 폴더블 디바이스(Fold 시리즈) 대응
    * 신용카드 인식 과정에서 세로 모드 가이드 영역이 화면을 벗어나던 문제를 수정했습니다.
* 카메라 프리뷰 화면 동기화 이슈 개선

<a id="120-july-29-2025"></a>

## 1.12.0 (2025. 07. 29.)

<a id="nhn-cloud-sdk"></a>

### NHN Cloud SDK

<a id="improved"></a>

#### 기능 개선

* 최소 지원 버전 상향
    * Android 최소 지원 버전이 API 16(Android 4.1)에서 API 22(Android 5.1)로 상향되었습니다.
    * NHN Cloud Android SDK에서 사용하는 일부 API는 TLS 1.0 및 TLS 1.1 지원이 곧 종료될 예정이며, TLS 1.2 이상만 지원됩니다.
    * 이는 보안 강화를 위한 조치이며, SDK를 업데이트하지 않더라도 v1.12.0 미만 버전을 Android 5.1(API 22) 미만 환경에서 사용할 경우 일부 API가 정상적으로 동작하지 않을 수 있습니다.
* 16KB 페이지 크기 지원
    * 2025년 11월 1일부터 Google Play에 제출하는 Android 15(API 34) 이상 기기를 타겟팅하는 모든 신규 앱 및 기존 앱 업데이트는 64비트 기기에서 16KB 페이지 크기 지원이 필수입니다.
    * 이에 따라 NHN Cloud SDK는 16KB 페이지 크기를 지원합니다.
    * 지원 모듈
        * NHN Cloud Logger
        * NHN Cloud OCR

<a id="nhn-cloud-ocr-2"></a>

### NHN Cloud OCR

<a id="fixed"></a>

#### 버그 수정

* 카메라 프리뷰 화면 동기화 이슈 개선
    * 카메라 프리뷰 화면과 Surface 버퍼 해상도의 동기화 로직을 개선하였습니다.

<a id="111-june-5-2025"></a>

## 1.11.1 (2025. 06. 05.)

<a id="nhn-cloud-push"></a>

### NHN Cloud Push

<a id="fixed-2"></a>

#### 버그 수정

* Notification Hub API 도메인 오류 수정
    * 잘못 설정된 Notification Hub API 도메인을 수정하여 API 호출 오류를 해결하였습니다.

<a id="110-april-29-2025"></a>

## 1.11.0 (2025. 04. 29.)

<a id="nhn-cloud-push-2"></a>

### NHN Cloud Push

<a id="added"></a>

#### 기능 추가

* Notification Hub 지원
    * NHN Cloud Push SDK에서 Notification Hub 사용을 지원합니다.
    * NhnCloudPushConfiguration.Builder.setServiceType(String) 메서드에 PushServiceType.NOTIFICATION_HUB를 설정하여 사용할 수 있습니다.

<a id="100-march-25-2025"></a>

## 1.10.0 (2025. 03. 25.)

<a id="nhn-cloud-iap"></a>

### NHN Cloud IAP

<a id="added-2"></a>

#### 기능 추가

* ONE store 버전 통합
    * ONE store v17, v19, v21 버전을 하나로 통합하였습니다.
    * nhncloud-iap-onestore2 모듈을 사용하면 ONE store IAP SDK를 통합된 버전으로 업데이트하여 사용할 수 있습니다.
    * 통합 대상:
        * nhncloud-iap-onestore
        * nhncloud-iap-onestore-v19
        * nhncloud-iap-onestore-v21
* ONE store 구독 지원
    * ONE store 통합 버전(nhncloud-iap-onestore2)에서 구독형 상품을 지원합니다.
    * 이를 통해 ONE store에서도 정기 결제 기반의 상품을 제공할 수 있습니다.

<a id="improved-2"></a>

#### 기능 개선

* ONE store 결제 히스토리 로그 지원
    * ONE store 통합 버전(nhncloud-iap-onestore2)부터 콘솔에서 결제 히스토리 로그를 확인할 수 있습니다.

<a id="95-january-23-2025"></a>

## 1.9.5 (2025. 01. 23.)

<a id="nhn-cloud-iap-2"></a>

### NHN Cloud IAP

<a id="improved-3"></a>

#### 기능 개선

* Google Play Billing Library(PBL) 업데이트
    * Google Play Billing Library(PBL)가 7.1.1로 업데이트되었습니다.
* NHN Cloud IAP Google Library 최소 지원 버전 상향
    * NHN Cloud IAP Google Library(nhncloud-iap-google)의 최소 지원 버전이 21로 상향되었습니다.

<a id="nhn-cloud-push-3"></a>

### NHN Cloud Push

<a id="improved-4"></a>

#### 기능 개선

* 알림 진동 설정 API 추가
    * 알림 수신 시 진동 여부를 설정할 수 있는 기능이 추가되었습니다.
    * NhnCloudNotificationOptions.Builder의 enableVibration(boolean)을 사용해 진동 여부를 설정할 수 있습니다.

<a id="94-november-15-2024"></a>

## 1.9.4 (2024. 11. 15.)

<a id="nhn-cloud-push-4"></a>

### NHN Cloud Push

<a id="improved-5"></a>

#### 기능 개선

* Device ID 설정 기능 추가
    * 사용자의 Device ID를 Push 서비스에서 사용할 수 있도록 설정하는 API(NhnCloudPush.setDeviceId)를 추가했습니다.

<a id="93-october-8-2024"></a>

## 1.9.3 (2024. 10. 08.)

<a id="nhn-cloud-iap-3"></a>

### NHN Cloud IAP

<a id="fixed-3"></a>

#### 버그 수정

* 원스토어 v19 및 v21에서 IapProductDetails.getLocalizedPrice() 메서드가 반환하는 값에 통화 기호가 포함되지 않는 문제 수정
    * '₩1,000'과 같이 로컬 통화 형식으로 반환되도록 수정하였습니다.

<a id="nhn-cloud-push-5"></a>

### NHN Cloud Push

<a id="fixed-4"></a>

#### 버그 수정

* Google Services 설정 파일(google-services.json) 누락 시 잘못된 오류가 발생하는 문제 수정
    * java.lang.IllegalStateException 대신 java.lang.ExceptionInInitializerError가 발생하는 문제를 수정하였습니다.
    * 이제 올바르게 IllegalStateException이 발생합니다.

<a id="92-august-27-2024"></a>

## 1.9.2 (2024. 08. 27.)

<a id="nhn-cloud-logger"></a>

### NHN Cloud Logger

<a id="fixed-5"></a>

#### 버그 수정

* Native Crash Reporting 오류 수정
    * Android 13 이상 특정 디바이스에서 간헐적으로 Native Crash 로그가 리포팅되지 않는 문제를 수정하였습니다.

<a id="nhn-cloud-iap-4"></a>

### NHN Cloud IAP

<a id="improved-6"></a>

#### 기능 개선

* Amazon 결제 재처리 개선
    * 앱을 삭제한 뒤 재설치하거나 앱 데이터를 삭제하면 실패한 결제가 재처리될 때 신규 구매 건으로 처리되는 문제를 개선하였습니다.

<a id="91-july-23-2024"></a>

## 1.9.1 (2024. 07. 23.)

<a id="nhn-cloud-iap-5"></a>

### NHN Cloud IAP

<a id="improved-7"></a>

#### 기능 개선

* Amazon 결제 재처리 개선
    * 구매 진행 중 앱 종료 또는 네트워크 차단 등으로 인해 결제를 실패한 경우 해당 결제를 재처리할 때 신규 구매 건으로 처리하는 문제를 개선하였습니다.
* 원스토어 v19 SDK 업데이트(v19.01.00)
    * Android 14(API Level 34) 이상을 타기팅하는 앱은 iap_sdk-v19.01.00.aar을 사용해야 합니다.

<a id="90-may-28-2024"></a>

## 1.9.0 (2024. 05. 28.)

<a id="nhn-cloud-iap-6"></a>

### NHN Cloud IAP

<a id="improved-8"></a>

#### 기능 개선

* Google Play Billing Library(PBL) 6.2.1 업데이트
    * Google 정책에 따라 PBL 5.x를 사용하는 앱은 2024년 11월 1일 부터 PBL 6.x로 업데이트 해야 합니다.
        * 신규 앱 출시: 2024년 8월 1일
        * 기존 앱 업데이트: 2024년 11월 1일
    * Android 4.4(API 19)를 지원하려면 추가 설정이 필요합니다. 자세한 사항은 [NHN Cloud > SDK 사용 가이드 > IAP > Android](./iap-android)를 참고하세요.
* Google IAP Library(nhncloud-iap-google)의 최소 지원 버전이 19로 상향되었습니다.
* IapResult.NETWORK_ERROR 코드 추가
    * NHN Cloud IAP 1.9.0부터 기존 IapResult.NETWORK_NOT_CONNECTED 코드가 IapResult.NETWORK_ERROR 코드로 반환됩니다.
    * IapResult.NETWORK_NOT_CONNECTED 응답 코드가 삭제되었습니다.
* 결제 히스토리 정보에 **사용자 취소(canceled)**, **결제 보류(pending)** 상태가 추가되었습니다.

<a id="fixed-6"></a>

#### 버그 수정

* 원스토어 외부결제 후 화면 방향 전환 시 상태바가 비정상적으로 노출되는 문제를 해결하였습니다.

<a id="86-may-7-2024"></a>

## 1.8.6 (2024. 05. 07.)

<a id="nhn-cloud-ocr-3"></a>

### NHN Cloud OCR

<a id="fixed-7"></a>

#### 버그 수정

* 네트워크 시간 초과로 신용카드 인식에 실패하는 문제를 수정하였습니다.

<a id="85-february-27-2024"></a>

## 1.8.5 (2024. 02. 27.)

<a id="nhn-cloud-logger-2"></a>

### NHN Cloud Logger

<a id="fixed-8"></a>

#### 버그 수정

* 크래시 로그가 중복해서 전송되는 문제를 수정하였습니다.

<a id="84-january-25-2024"></a>

## 1.8.4 (2024. 01. 25.)

<a id="nhn-cloud-sdk-2"></a>

### NHN Cloud SDK

<a id="improved-9"></a>

#### 기능 개선

* 안정성 개선
    * ProGuard 미적용 시 비정상 종료되는 문제를 수정하였습니다.

<a id="83-january-23-2024"></a>

## 1.8.3 (2024. 01. 23.)

<a id="nhn-cloud-iap-7"></a>

### NHN Cloud IAP

<a id="improved-10"></a>

#### 기능 개선

* MyCard SDK 업데이트
    * Android 14 대응

<a id="82-december-19-2023"></a>

## 1.8.2 (2023. 12. 19.)

<a id="nhn-cloud-ocr-4"></a>

### NHN Cloud OCR

<a id="improved-11"></a>

#### 기능 개선

* 안정성 개선

<a id="81-october-31-2023"></a>

## 1.8.1 (2023. 10. 31.)

<a id="nhn-cloud-ocr-5"></a>

### NHN Cloud OCR

<a id="improved-12"></a>

#### 기능 개선
* Credit Card Recognizer UI 개선
    * 보안이 강화된 TextView를 적용합니다.

<a id="fixed-9"></a>

#### 버그 수정
* Camera Focus 이슈 수정
    * 일부 저사양 디바이스에서 Auto Focus가 동작하지 않는 문제를 수정합니다.

<a id="80-september-26-2023"></a>

## 1.8.0 (2023. 09. 26.)

<a id="nhn-cloud-iap-8"></a>

### NHN Cloud IAP

<a id="improved-13"></a>

#### 기능 개선

* Google Billing Client 5.2.1 업데이트
    * 구글 정책에 따라 Android 14 이상을 타겟팅하는 앱은 NHN Cloud IAP 1.8.0 이상으로 업데이트해야 합니다.

<a id="nhn-cloud-ocr-6"></a>

### NHN Cloud OCR

<a id="improved-14"></a>

#### 기능 개선

* Camera 개선
    * Camera Preview 화면이 디스플레이를 가득 채우도록 변경합니다.
* 최소 지원 버전이 API 22로 상향되었습니다.

<a id="71-august-29-2023"></a>

## 1.7.1 (2023. 08. 29.)

<a id="nhn-cloud-iap-9"></a>

### NHN Cloud IAP

<a id="improved-15"></a>

#### 기능 개선

* MyCard 테스트 결제 개선
* MyCard 최소 지원 버전이 API 21로 상향되었습니다.

<a id="70-july-11-2023"></a>

## 1.7.0 (2023. 07. 11.)

<a id="nhn-cloud-ocr-7"></a>

### NHN Cloud OCR

<a id="added-3"></a>

#### 기능 추가

* OCR(ID Card Recognizer) 추가

<a id="60-june-20-2023"></a>

## 1.6.0 (2023. 06. 20.)

<a id="nhn-cloud-iap-10"></a>

### NHN Cloud IAP

<a id="added-4"></a>

#### 기능 추가

* ONE store v21 추가

<a id="nhn-cloud-logger-3"></a>

### NHN Cloud Logger

<a id="improved-16"></a>

#### 기능 개선

* Android Gradle Plugin 8.0 지원

<a id="51-may-30-2023"></a>

## 1.5.1 (2023. 05. 30.)

<a id="nhn-cloud-iap-11"></a>

### NHN Cloud IAP

<a id="added-5"></a>

#### 기능 추가

* 결제 상세정보 전송 기능 추가
    * IAP 콘솔의 Transaction 탭에서 결제 상세정보를 조회할 수 있습니다.

<a id="50-april-5-2023"></a>

## 1.5.0 (2023. 04. 05.)

<a id="nhn-cloud-sdk-3"></a>

### NHN Cloud SDK

<a id="improved-17"></a>

#### 기능 개선

* 안정성 개선

<a id="nhn-cloud-iap-12"></a>

### NHN Cloud IAP

<a id="added-6"></a>

#### 기능 추가

* MyCard IAP 추가

<a id="43-march-24-2023"></a>

## 1.4.3 (2023. 03. 24.)

<a id="nhn-cloud-ocr-8"></a>

### NHN Cloud OCR

<a id="fixed-10"></a>

#### 버그 수정

* NoClassDefFoundError 이슈 수정

<a id="42-february-28-2023"></a>

## 1.4.2 (2023. 02. 28.)

<a id="nhn-cloud-ocr-9"></a>

### NHN Cloud OCR

<a id="improved-18"></a>

#### 기능 개선

* 안정성 개선

<a id="41-january-11-2023"></a>

## 1.4.1 (2023. 01. 11.)

<a id="nhn-cloud-push-6"></a>

### NHN Cloud Push

<a id="improved-19"></a>

#### 기능 개선

* 푸시 지표 전송 및 이벤트 처리 개선

<a id="40-november-29-2022"></a>

## 1.4.0 (2022. 11. 29.)

<a id="nhn-cloud-logger-4"></a>

### NHN Cloud Logger

<a id="added-7"></a>

#### 기능 추가

* 공공기관용 Logger 지원

<a id="nhn-cloud-ocr-10"></a>

### NHN Cloud OCR

<a id="improved-20"></a>

#### 기능 개선

* UI 개선

<a id="fixed-11"></a>

#### 버그 수정

* 카메라 초기화 시 크래시 이슈 수정

<a id="nhn-cloud-push-7"></a>

### NHN Cloud Push

<a id="improved-21"></a>

#### 기능 개선

* 푸시 이벤트 전송 개선
* Intent의 flags가 변경되는 이슈 수정
    * NhnCloudPushMessageReceiver.getContentIntent() 호출 시 전달되는 Intent에 설정된 flags가 유지되지 않는 이슈가 수정되었습니다.

<a id="30-october-25-2022"></a>

## 1.3.0 (2022. 10. 25.)

<a id="nhn-cloud-ocr-11"></a>

### NHN Cloud OCR

<a id="added-8"></a>

#### 기능 추가

* OCR(Credit Card Recognizer) 추가

<a id="nhn-cloud-iap-13"></a>

### NHN Cloud IAP

<a id="added-9"></a>

#### 기능 추가

* [모든 스토어] 활성화 구독 조회 및 미소비 결제 내역 조회 API 추가

<a id="nhn-cloud-push-8"></a>

### NHN Cloud Push

<a id="fixed-12"></a>

#### 버그 수정

* NHN Cloud SDK 1.0.0 이상 버전에서 ToastPushMessageReceiver 사용 시 클릭 이벤트 수신 및 지표 수집 불가 오류 수정

<a id="20-october-4-2022"></a>

## 1.2.0 (2022. 10. 04.)

<a id="nhn-cloud-sdk-4"></a>

### NHN Cloud SDK

<a id="improved-22"></a>

#### 기능 개선

* AndroidX 지원
    * 최소 지원 버전이 API 16으로 상향되었습니다.

<a id="nhn-cloud-push-9"></a>

### NHN Cloud Push

<a id="improved-23"></a>

#### 기능 개선

* Android 13 대응
    * POST_NOTIFICATION 권한을 요청할 수 있는 API가 추가되었습니다.
    * Notification 채널을 생성할 수 있는 API가 추가되었습니다.  

<a id="10-september-6-2022"></a>

## 1.1.0 (2022. 09. 06.)

<a id="nhn-cloud-iap-14"></a>

### NHN Cloud IAP

<a id="added-10"></a>

#### 기능 추가

* ONE store v19 추가

<a id="improved-24"></a>

#### 기능 개선

* Google Billing Client 5.0.0 업데이트

<a id="00-july-12-2022"></a>

## 1.0.0 (2022. 07. 12.)

<a id="nhn-cloud-sdk-5"></a>

### NHN Cloud SDK

<a id="improved-25"></a>

#### 기능 개선

* NHN Cloud Android SDK로 모듈명 변경
	* TOAST Android SDK는 Deprecated 되었습니다.

<a id="311-june-14-2022"></a>

## 0.31.1 (2022. 06. 14.)

<a id="toast-logger"></a>

### TOAST Logger

<a id="improved-26"></a>

#### 기능 개선

* TOAST Logger 안정화

<a id="310-may-10-2022"></a>

## 0.31.0 (2022. 05. 10.)

<a id="toast-iap"></a>

### TOAST IAP

<a id="added-11"></a>

#### 기능 추가

* ONE store 외부 결제 추가

<a id="toast-push"></a>

### TOAST Push

<a id="added-12"></a>

#### 기능 추가

* 하나의 Firebase 프로젝트에 등록된 다수의 안드로이드 앱 지원

<a id="301-may-3-2022"></a>

## 0.30.1 (2022. 05. 03.)

<a id="toast-iap-2"></a>

### TOAST IAP

<a id="improved-27"></a>

#### 기능 개선

* ONE store v16 아이템 조회 로직 개선

<a id="300-april-26-2022"></a>

## 0.30.0 (2022. 04. 26.)

<a id="toast-push-2"></a>

### TOAST Push

<a id="added-13"></a>

#### 기능 추가

- ADM(Amazon Device Messaging) 추가

<a id="292-march-29-2022"></a>

## 0.29.2 (2022. 03. 29.)

<a id="toast-push-3"></a>

### TOAST Push

<a id="fixed-13"></a>

#### 버그 수정

* 토큰 갱신 시 토큰이 등록되지 않는 문제 수정

<a id="291-february-22-2022"></a>

## 0.29.1 (2022. 02. 22.)

<a id="toast-push-4"></a>

### TOAST Push

<a id="fixed-14"></a>

#### 버그 수정

* Google Play 서비스가 설치되어 있지 않은 디바이스에서 FCM 토큰 획득 시 크래시 이슈 수정

<a id="290-december-07-2021"></a>

## 0.29.0 (2021. 12. 07.)

<a id="toast-iap-3"></a>

### TOAST IAP

<a id="added-14"></a>

#### 기능 추가

* 화웨이 스토어(Huawei App Gallery) 추가

<a id="280-november-23-2021"></a>

## 0.28.0 (2021. 11. 23.)

<a id="toast-iap-4"></a>

### TOAST IAP

<a id="added-15"></a>

#### 기능 추가

* Amazon Appstore 추가

<a id="toast-push-5"></a>

### TOAST Push

<a id="improved-28"></a>

#### 기능 개선

* Android 12 대응
    * Pending intents mutability.
    * Notification trampoline restrictions.
    * Safer component exporting (android.exported).

> Notification을 직접 생성하는 경우 지표 수집이 가능한 PendingIntent를 반환하는 ToastPushMessageReceiver.getContentIntent()가 추가되었습니다.
이는 Android 12 이상에서 일부 기능이 정상 동작하지 않는 ToastPushMessageReceiver.getNotificationServiceIntent()를 대체합니다.

<a id="274-october-26-2021"></a>

## 0.27.4 (2021. 10. 26.)

<a id="toast-push-6"></a>

### TOAST Push

<a id="fixed-15"></a>

#### 버그 수정

* 사용자 알림 채널 설정이 초기화되는 오류 수정

<a id="273-september-28-2021"></a>

## 0.27.3 (2021. 09. 28.)

<a id="toast-iap-5"></a>

### TOAST IAP

<a id="improved-29"></a>

#### 기능 개선

* ONE store v16 테스트 결제 프로세스 개선

<a id="272-september-06-2021"></a>

## 0.27.2 (2021. 09. 06.)

<a id="toast-logger-2"></a>

### TOAST Logger

<a id="fixed-16"></a>

#### 버그 수정

* DeviceModel이 "UNKNOWN"으로 표시되는 오류 수정
    * 유니티에서 크래시 발생 시 DeviceModel이 "UNKNOWN"으로 표시되는 오류가 수정되었습니다.

<a id="271-august-24-2021"></a>

## 0.27.1 (2021. 08. 24.)

<a id="toast-iap-6"></a>

### TOAST IAP

<a id="improved-30"></a>

#### 기능 개선

* 구글 구독 결제 프로세스 개선
* ONE store v16 결제 프로세스 개선

<a id="270-august-03-2021"></a>

## 0.27.0 (2021. 08. 03.)

<a id="toast-iap-7"></a>

### TOAST IAP

<a id="added-16"></a>

#### 기능 추가

* ONE store v16 추가

<a id="260-july-06-2021"></a>

## 0.26.0 (2021. 07. 06.)

<a id="toast-iap-8"></a>

### TOAST IAP

<a id="added-17"></a>

#### 기능 추가

* 월 결제 한도 기능 추가

<a id="toast-push-7"></a>

### TOAST Push

<a id="fixed-17"></a>

#### 버그 수정

* Firebase Messaging 22.0.0 이상 대응
    * Firebase Messaging 22.0.0 이상에서 발생하는 오류가 수정되었습니다.

<a id="250-april-27-2021"></a>

## 0.25.0 (2021. 04. 27.)

<a id="toast-iap-9"></a>

### TOAST IAP

<a id="added-18"></a>

#### 기능 추가

* 구글 구독 상태 조회 API 추가
    * 구글 구독 상태를 조회할 수 있는 querySubscriptionsStatus API 가 추가되었습니다.

<a id="improved-31"></a>

#### 기능 개선

* 구글 결제 라이브러리 업데이트
    * 구글 결제 라이브러리 BillingClient 3.0.3이 적용되었습니다.

<a id="fixed-18"></a>

#### 버그 수정

* Android 11 이상에서 간헐적으로 "취소" 가 반환되는 오류를 수정하였습니다.

<a id="244-january-12-2021"></a>

## 0.24.4 (2021. 01. 12.)

<a id="toast-push-8"></a>

### TOAST Push

<a id="improved-32"></a>

#### 기능 개선

* FCM 토큰 갱신시 업데이트 로직 개선

<a id="toast-gradle-plugin-001"></a>

### TOAST Gradle Plugin (0.0.1)

<a id="added-19"></a>

#### 기능 추가

* Symbol Uploader 기능 추가

<a id="243-december-08-2020"></a>

## 0.24.3 (2020. 12. 08.)

<a id="toast-push-9"></a>

### TOAST Push

<a id="improved-33"></a>

#### 기능 개선

* Tencent QQ 서비스 종료에 따른 모듈 삭제

<a id="242-november-24-2020"></a>

## 0.24.2 (2020. 11. 24.)

<a id="toast-push-10"></a>

### TOAST Push

<a id="fixed-19"></a>

#### 버그 수정

* 사용자 아이디 설정과 동시에 토큰 등록 요청시 단말기 식별자로 등록되던 문제 해결

<a id="241-october-30-2020"></a>

## 0.24.1 (2020. 10. 30.)

<a id="toast-iap-10"></a>

### TOAST IAP

<a id="fixed-20"></a>

#### 버그 수정

* Galaxy Store 인앱 결제 오류 수정
    * Galaxy Apps(Galaxy Store 이전 앱 명칭) 3.x 이하 버전에서 Timeout이 발생하는 오류를 수정하였습니다.

<a id="240-october-27-2020"></a>

## 0.24.0 (2020. 10. 27.)

<a id="toast-iap-11"></a>

### TOAST IAP

<a id="added-20"></a>

#### 기능 추가

* Galaxy Store 추가

<a id="improved-34"></a>

#### 기능 개선

* 구글 결제 라이브러리 업데이트
    * 구글 결제 라이브러리 BillingClient 3.0.1이 적용되었습니다.
    * 2021년 8월 2일 부터 모든 새로운 앱은 결제라이브러리 버전 3 이상을 사용해야합니다.
    * 2021년 11월 1일까지 기존 앱에 대한 모든 업데이트는 결제 라이브러리 버전 3 이상을 사용해야합니다.
    * 자세한 사항은 [Meet Google Play Billing Library Version 3](https://android-developers.googleblog.com/2020/06/meet-google-play-billing-library.html)을 참고하세요.
* 구글 정기 결제(구독) 상태 변경에 따른 대응
    * 구글 구독 결제의 갱신 및 만료와 같은 수명주기 동안 다양한 상태 변경(유예 기간, 계정 보류, 복원, 일시중지, 정기 결제 재신청 등)에 대응하였습니다.

<a id="toast-push-11"></a>

### TOAST Push

<a id="improved-35"></a>

#### 기능 개선

* 알림 답장 기능 미지원 단말기에서는 답장 기능의 버튼이 생성되지 않도록 수정

<a id="fixed-21"></a>

#### 버그 수정

* 특정 상황에서 알림 채널이 새로 생성되는 버그 수정

<a id="232-october-06-2020"></a>

## 0.23.2 (2020. 10. 06.)

<a id="toast-iap-12"></a>

### TOAST IAP

<a id="fixed-22"></a>

#### 버그 수정

* 구독 이슈 수정.
    * 구독이 "계정 보류" 또는 "유예 기간" 상태에서 결제 수단 수정으로 복원된 경우 IapService.PurchasesUpdatedListener를 통해 에러가 통지되지 않도록 수정하였습니다.

<a id="231-september-11-2020"></a>

## 0.23.1 (2020. 09. 11.)

<a id="toast-push-12"></a>

### TOAST Push

<a id="improved-36"></a>

#### 기능 개선

* 토큰 등록 로직 개선

<a id="230-july-28-2020"></a>

## 0.23.0 (2020. 07. 28.)

<a id="toast-push-13"></a>

### TOAST Push

<a id="added-21"></a>

#### 기능 추가

* 사용자 태그 기능 지원

<a id="220-june-23-2020"></a>

## 0.22.0 (2020. 06. 23.)

<a id="toast-iap-13"></a>

### TOAST IAP

<a id="improved-37"></a>

#### 기능 개선

`TOAST IAP SDK 0.22.0 이상으로 업데이트 시 반드시 강제 업데이트를 진행해야 합니다.`

* Google Play Billing Library BillingClient 2.2.1 적용

<a id="toast-push-14"></a>

### TOAST Push

<a id="improved-38"></a>

#### 기능 개선

* 기본 알림 옵션 설정 기능 개선

<a id="212-may-26-2020"></a>

## 0.21.2 (2020. 05. 26.)

<a id="toast-push-15"></a>

### TOAST Push

<a id="improved-39"></a>

#### 기능 개선

* 토큰 등록 기능 개선

<a id="211-april-28-2020"></a>

## 0.21.1 (2020. 04. 28.)

<a id="toast-push-16"></a>

### TOAST Push

<a id="improved-40"></a>

#### 기능 개선

* 안정성 개선

<a id="toast-logger-3"></a>

### TOAST Logger

<a id="improved-41"></a>

#### 기능 개선

* Native Crash Reporting 기능 개선

<a id="210-march-24-2020"></a>

## 0.21.0 (2020. 03. 24.)

<a id="toast-logger-4"></a>

### TOAST Logger

<a id="added-22"></a>

#### 기능 추가

* Native Crash Reporting (NDK) 기능 추가

<a id="toast-push-17"></a>

### TOAST Push

<a id="improved-42"></a>

#### 기능 개선

* 기본 알림 옵션에 설정 가능한 항목 추가
    * 포그라운드 알림 노출 여부 설정이 추가되었습니다.
    * 배지 아이콘 사용 여부 설정이 추가되었습니다.

<a id="203-february-25-2020"></a>

## 0.20.3 (2020. 02. 25.)

<a id="toast-push-18"></a>

### TOAST Push

<a id="improved-43"></a>

#### 기능 개선

* 토큰 등록 기능 개선
    * 최초 토큰 등록 시 사용자 아이디가 설정되어 있지 않으면, 단말기 식별자를 사용하여 등록합니다.
    * 토큰 등록 후 ToastSdk.setUserId() 를 사용하여 사용자 아이디를 설정 또는 변경하면 토큰 정보를 갱신합니다.

<a id="202-january-21-2020"></a>

## 0.20.2 (2020. 01. 21.)

<a id="toast-push-19"></a>

### TOAST Push

<a id="improved-44"></a>

#### 기능 개선

* 지표 수집 기능 개선
* 기본 알림 채널 생성 로직 개선

<a id="201-january-07-2020"></a>

## 0.20.1 (2020. 01. 07.)

<a id="toast-push-20"></a>

### TOAST Push

<a id="improved-45"></a>

#### 기능 개선

* Assets 리소스 지원
    * Assets 경로의 이미지 리소스를 지원합니다.
* 기본 옵션 설정 방법 개선
    * AndroidManifest의 meta-data을 사용하여 알림 기본 옵션을 설정할 수 있습니다.

<a id="toast-iap-14"></a>

### TOAST IAP

<a id="improved-46"></a>

#### 기능 개선
* 보안 강화
    * 내부 보안 정책을 강화하였습니다.

<a id="fixed-23"></a>

#### 버그 수정

* "Bad base64 Exception" 오류 수정
    * TOAST SDK를 사용하지 않은 결제건 처리 시에 "Bad Base64 Exception"이 발생하는 오류를 수정하였습니다.

<a id="194-november-26-2019"></a>

## 0.19.4 (2019. 11. 26.)

<a id="toast-push-21"></a>

### TOAST Push

<a id="improved-47"></a>

#### 기능 개선

* (구) pushsdk 데이터 마이그레이션 지원.
    * (구) pushsdk 에서 업데이트 한 경우 모든 데이터를 TOAST SDK 로 마이그레이션 합니다.

<a id="193-october-18-2019"></a>

## 0.19.3 (2019. 10. 18.)

<a id="toast-push-22"></a>

### TOAST Push

<a id="improved-48"></a>

#### 기능 개선

* 토큰 등록 기능 개선.

<a id="192-october-15-2019"></a>

## 0.19.2 (2019. 10. 15.)

<a id="toast-push-23"></a>

### TOAST Push

<a id="added-23"></a>

#### 기능 추가

* 알림 클릭시 통지 기능 추가.
    * 사용자가 알림을 클릭하여 앱이 실행되었을 때에 대한 리스너를 등록할 수 있습니다.
* 배지 기능 지원.
    * 알림 수신시 배지 아이콘과 앱 숏컷 화면에 배지 카운트가 노출됩니다.

<a id="improved-49"></a>

#### 기능 개선

* 알림 기본 스타일 지정.
    * 미디어를 포함하지 않는 알림은 BigTextStyle 로 지정되어 두 줄 이상의 메시지도 표현됩니다.

<a id="191-october-02-2019"></a>

## 0.19.1 (2019. 10. 02.)

<a id="toast-iap-15"></a>

### TOAST IAP

<a id="added-24"></a>

#### 기능 추가

* Unity Android IAP Plugin에 구매 요청 시 사용자 데이터를 영수증에 포함할 수 있는 기능이 추가되었습니다.

<a id="190-october-01-2019"></a>

## 0.19.0 (2019. 10. 01.)

<a id="toast-iap-16"></a>

### TOAST IAP

<a id="added-25"></a>

#### 기능 추가

* Android IAP 라이브러리에 구매 요청 시 사용자 데이터를 영수증에 포함할 수 있는 기능이 추가되었습니다.

<a id="toast-push-24"></a>

### TOAST Push

<a id="improved-50"></a>

#### 기능 개선

* 사용자 정의 메시지 리시버 사용성 개선.
    * 알림 노출 요청시 사용자 콘텐츠 인텐트 타입이 PendingIntent 로 변경되었습니다.

<a id="180-august-27-2019"></a>

## 0.18.0 (2019. 08. 27.)

<a id="toast-iap-17"></a>

### TOAST IAP

<a id="added-26"></a>

#### 기능 추가

* 소비성 구독 상품 추가.
    * 상품 타입에 소비 가능한 구독 상품이 추가되었습니다.

<a id="fixed-24"></a>

#### 버그 수정

* Google Play Store 앱 업데이트 시, 결제 결과가 2회 이상 통지되는 오류가 수정되었습니다.

<a id="toast-push-25"></a>

### TOAST Push

<a id="added-27"></a>

#### 기능 추가

* 기본 알림 옵션 설정 기능 추가.
    * 작은 아이콘, 진동, 알림음 등의 기본 옵션을 설정할 수 있습니다.

<a id="171-july-23-2019"></a>

## 0.17.1 (2019. 07. 23.)

<a id="toast-push-26"></a>

### TOAST Push

<a id="added-28"></a>

#### 기능 추가

* 커스텀 리시버 사용시 메시지 객체내에 FCM 발신자 ID 정보 추가.

<a id="170-june-25-2019"></a>

## 0.17.0 (2019. 06. 25.)

<a id="toast-pus"></a>

### TOAST Push

<a id="added-29"></a>

#### 기능 추가

* 토큰 정보 업데이트 기능 추가.
    * 언어 및 국가 정보 등의 정보를 업데이트할 수 있습니다.
* 메시지 수신 통지 기능 추가.
* 리치 메시지 버튼의 액션("Open", "Dismiss", "Reply", etc) 통지 기능 추가.

<a id="improved-51"></a>

#### 기능 개선

* 초기화 개선.
    * PushType ("FCM", "TENCENT", etc)으로 초기화가 가능합니다.
* 앱 상태에 따른 알림 노출 정책 변경.
    * 사용자가 앱을 사용 중(Foreground)일 때는 알림을 노출하지 않습니다.
* 사용자 정의 메시지 리시버 사용성 개선.
    * 사용자 정의 메시지 수정 및 알림 생성이 간편해졌습니다.
    * 사용자 정의 알림의 지표 전송이 간편해졌습니다.

<a id="162-june-21-2019"></a>

## 0.16.2 (2019. 06. 21.)

<a id="toast-iap-18"></a>

### TOAST IAP

<a id="improved-52"></a>

#### 기능 개선

* 사용자 아이디가 변경되었을 때 동작 개선
* (구)IAP SDK v1.5.3 이전 결제건의 재처리 개선

<a id="toast-logger-5"></a>

### TOAST Logger

<a id="fixed-25"></a>

#### 버그 수정

* 크래시 오류 수정

<a id="161-may-02-2019"></a>

## 0.16.1 (2019. 05. 02.)

<a id="toast-sdk"></a>

### TOAST SDK

<a id="fixed-26"></a>

#### Fixed

* 'toast-sdk'에서 'toast-push-tencent' 의존성 제거.

<a id="160-april-23-2019"></a>

## 0.16.0 (2019. 04. 23.)

<a id="toast-push-27"></a>

### TOAST Push

<a id="added-30"></a>

#### 기능 추가

* Tencent 푸시 추가.
* 사용자 메시지 처리 기능 추가.
    * 메시지가 수신되면 사용자가 정의한 receiver가 메시지를 처리합니다.

<a id="150-march-26-2019"></a>

## 0.15.0 (2019. 03. 26.)

<a id="toast-log-crash"></a>

### TOAST Log & Crash

<a id="improved-53"></a>

#### 기능 개선

* ProjectKey가 AppKey로 명칭 변경
    * 기존 setProjectKey는 계속 사용 가능

<a id="toast-iap-19"></a>

### TOAST IAP

<a id="added-31"></a>

#### 기능 추가

* 중국 마켓 추가.

<a id="toast-push-28"></a>

### TOAST Push

<a id="added-32"></a>

#### 기능 추가

* 토큰 해제 API 추가.
* sound 필드 추가시 알림의 소리를 설정할 수 있는 기능 추가.
    * 안드로이드 8.0 미만에서만 동작

<a id="143-march-08-2019"></a>

## 0.14.3 (2019. 03. 08.)

<a id="toast-iap-20"></a>

### TOAST IAP

<a id="fixed-27"></a>

#### 버그 수정

* 앱에서 Proguard를 적용하는 경우, API가 정상적으로 동작하지 않는 문제 해결.

<a id="142-march-04-2019"></a>

## 0.14.2 (2019. 03. 04.)

<a id="toast-push-29"></a>

### TOAST Push

<a id="fixed-28"></a>

#### 버그 수정

* FCM 토큰을 획득할 수 없는 경우, 크래시가 발생하는 문제 해결

<a id="141-january-29-2019"></a>

## 0.14.1 (2019. 01. 29.)

<a id="toast-iap-21"></a>

### TOAST IAP

<a id="fixed-29"></a>

#### 버그 수정

* (구)IAP SDK 결제건을 처리하지 못하는 에러 수정.

<a id="140-january-08-2019"></a>

## 0.14.0 (2019. 01. 08.)

<a id="toast-iap-22"></a>

### TOAST IAP

<a id="added-33"></a>

#### 기능 추가

* TOAST IAP Unity Plugin 추가.

<a id="130-december-27-2018"></a>

## 0.13.0 (2018. 12. 27.)

<a id="toast-core"></a>

### TOAST Core

<a id="improved-54"></a>

#### 기능 개선

* ToastSdk.initialize() 메소드 deprecated.
    * Application 시작 시에 자동으로 호출되도록 변경

<a id="toast-push-30"></a>

### TOAST Push

<a id="added-34"></a>

#### 기능 추가

* 신규 기능 추가
    * Firebase Cloud Messaging(FCM)

<a id="120-december-04-2018"></a>

## 0.12.0 (2018. 12. 04.)

<a id="toast-iap-23"></a>

### TOAST IAP

<a id="added-35"></a>

#### 추가 사항

* 신규 기능 추가
    * Google Play Store(소비성 상품, 구독 상품)
    * ONE store(소비성 상품)

<a id="110-november-20-2018"></a>

## 0.11.0 (2018. 11. 20.)

<a id="toast-log-crash-2"></a>

### TOAST Log & Crash

<a id="added-36"></a>

#### 추가 사항

* Network Insights 기능 추가

<a id="90-september-04-2018"></a>

## 0.9.0 (2018. 09. 04.)

<a id="toast-log-crash-3"></a>

### TOAST Log & Crash

<a id="added-37"></a>

#### 추가 사항

* 신규 기능 추가
