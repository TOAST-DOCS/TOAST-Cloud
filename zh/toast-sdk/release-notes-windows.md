## NHN Cloud > SDK User Guide > Release Notes > Windows C++

## 2.0.0.1 (2022.07.12)
Download : [nhncloud-sdk-windows-2.0.0.1.zip](https://static.toastoven.net/toastcloud/sdk_download/toast/windows/2.0.0/nhncloud-sdk-windows-2.0.0.1.zip)
* NHNCloudLogger 모듈명 변경
	* ToastLogger는 Deprecated 되었습니다.
* 로그 전송 시 메모리 누수 수정
* User ID가 MBCS/UNICODE 함수에 따라 다르게 반영되는 문제 수정
* Crash 로그 전송시 로그 유형 필터 설정이 적용되지 않는 문제 수정

## 1.0.0.5 (2021.03.31)
Download : [toast-sdk-windows-1.0.0.5.zip](https://static.toastoven.net/toastcloud/sdk_download/toast/windows/1.0.0/toast-sdk-windows-1.0.0.5.zip)
* Bug fixes
* Changed some API interfaces
* Added a feature to validate input values when using custom fields
* Fixed issues of intermittent Base64 decoding failure
* Fixed issues of intermittent failure when sending crash dumps to external processes
* Changed the structure of distributed binary
	* Sample project included

## 0.9.4.3 (2019.10.10)
Download : [toast-sdk-windows-0.9.4.3.zip](https://static.toastoven.net/toastcloud/sdk_download/toast/windows/0.9.4/toast-sdk-windows-0.9.4.3.zip)


### TOAST Log & Crash

#### Bug Fixes

* Fixed an issue where no crash log remains for pure virtual call / invalid parameter on x86

## 0.9.3.0 (2019.07.23)
Download : [toast-sdk-windows-0.9.3.0.zip](https://static.toastoven.net/toastcloud/sdk_download/toast/windows/0.9.3/toast-sdk-windows-0.9.3.0.zip)

### TOAST Log & Crash

#### Added Features

* Initialize() function success/failure handling
	* Changed the return value to bool
* Added SessionId to general log
* When setting information cannot be retrieved, process with the previously saved setting information.
* Provides a static library
	* Visual studio 2015 (vc14) version provided
* Provides xp version

## 0.9.0.12 (2018.09.04)
Download : [toast-sdk-windows-0.9.0.12.zip](https://static.toastoven.net/toastcloud/sdk_download/toast/windows/0.9.0/toast-sdk-windows-0.9.0.12.zip)

### TOAST Log & Crash

#### Added

* New Functions

