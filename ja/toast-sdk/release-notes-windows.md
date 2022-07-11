## NHN Cloud > SDK使用ガイド > リリースノート > Windows C++

## 2.0.0.1 (2022.07.12)
Download : [nhncloud-sdk-windows-2.0.0.1.zip](https://static.toastoven.net/toastcloud/sdk_download/toast/windows/2.0.0/nhncloud-sdk-windows-2.0.0.1.zip)
* NHNCloudLogger 모듈명 변경
	* ToastLogger는 Deprecated 되었습니다.
* 로그 전송 시 메모리릭 수정
* User ID가 MBCS/UNICODE 함수에 따라 다르게 반영되는 문제 수정
* Crash 로그 전송시 로그 유형 필터 설정이 적용되지 않는 문제 수정

## 1.0.0.5 (2021.03.31)
Download : [toast-sdk-windows-1.0.0.5.zip](https://static.toastoven.net/toastcloud/sdk_download/toast/windows/1.0.0/toast-sdk-windows-1.0.0.5.zip)
* 버그 수정
* 일부 API 인터페이스 수정
* 사용자 정의 필드 사용시 입력값 검증
* 간헐적으로 Base64 디코딩 실패하는 경우 수정
* 외부 프로세스로 크래시덤프 전송시 간헐적으로 실패하는 문제 수정
* 배포 바이너리 구조 변경
	* 샘플 프로젝트 포함


## 0.9.4.3 (2019.10.10)
Download : [toast-sdk-windows-0.9.4.3.zip](https://static.toastoven.net/toastcloud/sdk_download/toast/windows/0.9.4/toast-sdk-windows-0.9.4.3.zip)

### TOAST Log & Crash

#### バグ修正

* x86でpure virtual call / invalid parameterのクラッシュログが残らない問題を修正

## 0.9.3.0 (2019.07.23)
Download : [toast-sdk-windows-0.9.3.0.zip](https://static.toastoven.net/toastcloud/sdk_download/toast/windows/0.9.3/toast-sdk-windows-0.9.3.0.zip)

### TOAST Log & Crash

#### 追加事項

* Initialize()関数の成功/失敗処理
	* boolのリターン値変更
* SessionId 一般ログにも追加
* Setting情報を持っていなかった場合、すでに保存されていたSetting情報で処理
* Static library提供
	* visual studio 2015 (vc14)バージョンを提供
* xpバージョンを提供

## 0.9.0.12 (2018.09.04)
Download : [toast-sdk-windows-0.9.0.12.zip](https://static.toastoven.net/toastcloud/sdk_download/toast/windows/0.9.0/toast-sdk-windows-0.9.0.12.zip)

### TOAST Log & Crash

#### 追加事項

* 新規機能追加
