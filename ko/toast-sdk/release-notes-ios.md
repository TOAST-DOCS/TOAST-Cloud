## TOAST > TOAST SDK 사용 가이드 > 릴리스 노트 > iOS

## 0.13.0 (2019.03.26)

### 공통

#### 기능 개선

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
