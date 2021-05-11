## TOAST > TOAST SDK 사용 가이드 > 릴리스 노트 > Windows C++
## 1.0.0.5 (2021.03.31)
* 버그 수정
* 일부 API 인터페이스 수정
* 사용자 정의 필드 사용시 입력값 검증 
* 간헐적으로 Base64 디코딩 실패하는 경우 수정
* 외부 프로세스로 크래시덤프 전송시 간헐적으로 실패하는 문제 수정
* 배포 바이너리 구조 변경
	* 샘플 프로젝트 포함
	
	
## 0.9.4.3 (2019.10.10)

### TOAST Log & Crash

#### 버그 수정

* x86에서 pure virtual call / invalid parameter 크래쉬로그가 남지 않는 현상 처리

## 0.9.3.0 (2019.07.23)

### TOAST Log & Crash

#### 추가 사항

* Intialize() 함수 성공/실패 처리
	* bool로 리턴값 변경
* SessionId 일반로그에도 추가
* Setting 정보 못가져왔을때 이전에 저장된 Setting 정보로 처리
* Static libarary 제공
	* visual studio 2015 (vc14) 버전 제공
* xp 버전 제공 

## 0.9.0.12 (2018.09.04)

### TOAST Log & Crash

#### 추가 사항

* 신규 기능 추가