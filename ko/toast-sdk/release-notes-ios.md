## TOAST > TOAST SDK 사용 가이드 > 릴리스 노트 > iOS

## 0.15.0 (2019.06.25)

### TOAST IAP

#### 개선 사항

* 신규 결제, 프로모션 결제, 미소비 내역 조회 요청시 미완료 결제건 재처리 로직 추가

### TOAST Push

#### 추가 사항

* 알림 옵션 설정 기능 추가
* 토큰 정보 업데이트 기능 추가

#### 개선 사항

* 초기화시 국가코드, 언어코드 설정기능 추가
* 알림 기본 설정 변경 
    * [앱 실행 중 알림을 표시하지 않도록 변경](./push-ios/#_6)


## 0.14.1 (2019.05.16)

### TOAST IAP

#### 개선 사항

* 처리중인 재처리 결제건과 동일한 상품 구매시 보유한 상품으로 처리되는 현상 개선

### TOAST Push

#### 개선 사항

* 단말기 캘린더 설정에 따라 지표 이벤트 발생 시간이 잘못 수집되던 버그 수정

## 0.14.0 (2019.05.14)

### 공통

#### 개선 사항

* 네트워크 관련 에러 코드 통합
* 안전성 개선

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

* 안전성 개선
* 메세지 수신 Delegate 로 전달되는 payload 정보에 메세지 ID 정보 추가
* 광고성 메세지 수신 동의, 야간 광고성 메세지 수신 동의가 불필요한 VoIP 의 경우 수신 동의 여부와 관계 없이 메세지 수신

## 0.13.0 (2019.03.26)

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

#### 수정 사항

* UserID 설정 시점에 따라 전송하는 Log의 UserID가 갱신되지 않을 수 있는 문제 수정

### TOAST IAP

#### 개선 사항

* 내부 예외 처리 추가

### TOAST Push

#### 추가 사항

* 토큰 삭제 API 추가

## 0.12.4 (2019.03.19)

### TOAST Core

#### 개선 사항

* 예외처리 추가

## 0.12.3 (2019.02.26)

### TOAST Core, Common

#### 개선 사항

* 유틸 기능의 예외처리 추가

### TOAST IAP

#### 개선 사항

* 상품정보 캐싱 추가
* 예외처리 추가

## 0.12.2 (2019.02.08) - Hotfix

### TOAST Core

#### 개선 사항

* ToastTransfer에서 간헐적으로 발생하던 Crash 방지를 위해 방어코드 추가

## 0.12.1 (2019.01.08)

### TOAST IAP

#### 개선 사항

* 특정 상황에서 결제 상태가 VerifyEnd인 결제의 재처리가 동작하지 않던 문제 수정

## 0.12.0 (2018.12.27)

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


## 0.11.1 (2018.12.04)

### TOAST IAP

#### 추가 사항

* 신규 기능 추가


## 0.11.0 (2018.11.20)

### TOAST Log & Crash

#### 추가 사항

* Network Insights 기능 추가


## 0.9.0 (2018.09.04)

### TOAST Log & Crash

#### 추가 사항

* 신규 기능 추가
