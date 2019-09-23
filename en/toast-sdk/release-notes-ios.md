## TOAST > User Guide for TOAST SDK > Release Notes > iOS

## 0.18.0 (2019.10.01)

### TOAST Push

#### 개선 사항

* ToastPushConfiguration 객체의 Nullability 속성 변경
* 리치 메시지 생성 로직 개선으로 ToastPushMedia 객체의 sourceType, extension 프로퍼티 삭제

#### 버그 수정

* 콘솔 설정에 메시지 수신/확인 기능이 사용 안함으로 설정되어 있는 경우 리치 메시지가 정상적으로 표시되지 않던 버그 수정

## 0.17.0 (2019.08.27)

### 공통

#### 개선 사항 
* 안전성 개선

### TOAST IAP

#### 추가 사항

* 자동 갱신형 소비성 구독 상품 추가 

#### 개선 사항

* 상품 목록 조회시 invalidProducts 에 유효한 상품 목록이 반환되던 문제 수정

### TOAST Push

#### 개선 사항

* 푸쉬 메시지에 알림음을 설정하지 않고 발송시 기본 알림음이 설정되도록 개선

## 0.16.1 (2019.07.29)

### 공통

#### 개선 사항 
* 국가코드를 획득하지 못하는 문제 수정 

## 0.16.0 (2019.07.23)

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
* 메시지 수신 Delegate 로 전달되는 payload 정보에 메시지 ID 정보 추가
* 광고성 메시지 수신 동의, 야간 광고성 메시지 수신 동의가 불필요한 VoIP 의 경우 수신 동의 여부와 관계 없이 메시지 수신

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
