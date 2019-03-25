## TOAST > TOAST SDK 사용 가이드 > 릴리스 노트 > Android

## 0.15.0 (2019.03.26)

### TOAST Log & Crash

#### 기능 개선

* ToastLoggerConfiguration의 ProjectKey가 AppKey로 명칭 변경
    * 기존 setProjectKey는 계속 사용 가능

### TOAST Push

#### 기능 추가

* 토큰 해제 API 추가.
* sound 필드 추가시 알림의 소리를 설정할 수 있는 기능 추가.
    * 안드로이드 8.0 미만에서만 동작

## 0.14.3 (2019.03.08)

### TOAST IAP

#### 버그 수정

* 앱에서 Proguard를 적용하는 경우, API가 정상적으로 동작하지 않는 문제 해결.

## 0.14.2 (2019.03.04)

### TOAST Push

#### 버그 수정

* FCM 토큰을 획득할 수 없는 경우, 크래시가 발생하는 문제 해결

## 0.14.1 (2019.01.29)

### TOAST IAP

#### 버그 수정

* (구)IAP SDK 결제건을 처리하지 못하는 에러 수정.

## 0.14.0 (2019.01.08)

### TOAST IAP

#### 기능 추가

* TOAST IAP Unity Plugin 추가.

## 0.13.0 (2018.12.27)

### TOAST Core

#### 기능 개선

* ToastSdk.initialize() 메소드 deprecated.
    * Application 시작 시에 자동으로 호출되도록 변경

### TOAST Push

#### 기능 추가

* 신규 기능 추가
    * Firebase Cloud Messaging(FCM) 

## 0.12.0 (2018.12.04)

### TOAST IAP

#### 추가 사항

* 신규 기능 추가
    * Google Play 스토어(소비성 상품, 구독 상품)
    * ONE store(소비성 상품)

## 0.11.0 (2018.11.20)

### TOAST Log & Crash

#### 추가 사항

* Network Insights 기능 추가

## 0.9.0 (2018.09.04)

### TOAST Log & Crash

#### 추가 사항

* 신규 기능 추가

