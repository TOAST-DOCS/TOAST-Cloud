## TOAST > TOAST SDK 사용 가이드 > TOAST Logger > Reserved Fields

### 예약된 필드 정의

예약된 필드는 TOAST SDK 내부에서 정의하여 사용하고 있는 필드명입니다.

사용자가 예약된 필드를 추가하여 사용하려는 경우 필드명에 'reserved_'라는 접두사가 추가됩니다.

예약된 필드의 검사 조건은 대소 문자와 관계없이 문자열을 비교합니다.

### 예약된 필드의 사용 예

* 예약된 필드와 대소문자가 같은 경우

```
sendTime -> reserved_sendTime

```

* 예약된 필드와 대소문자가 같은 않은 경우

```
SENDTIME -> reserved_SENDTIME

```

### 예약된 필드 목록

| key | description |
| --- | ----------- |
| projectName | 프로젝트 이름 |
| projectVersion | 프로젝트 버전 |
| logVersion | 로그 전송 API 버전  |
| logType | 로그 타입 |
| logSource | 로그 소스 |
| logLevel | 로그 레벨 |
| body | 메세지 |
| sendTime | 로그 전송 시간 |
| createTime | 로그 생성 시간 |
| lncBulkIndex, | 로그 전송 순서 |
| transactionID | 로그 고유번호 |
| DeviceModel | 디바이스 모델 |
| Carrier | 통신사 정보  |
| CountryCode | 국가 정보 |
| Platform | 플랫폼 정보 |
| NetworkType | 네트워크 타입 |
| DeviceID | 디바이스 식별번호 |
| SessionID | 세션 아이디 |
| launchedID | 앱 설치 고유 번호 |
| UserID | 유저 아이디 |
| SdkVersion | SDK 버전 |
| CrashStyle | Crash 발생 언어 |
| SymMethod | Crash 해석 방법 |
| dmpData | Crash 정보 |
| FreeMemory | 여유 메모리 |
| FreeDiskSpace | 여유 디스크 공간 |
| SinkVersion | DB 저장 모듈 버전 |
| errorCode | 에러 코드 |
| crashMeta | Crash 메타 데이터 |
| SymResult | Crash 분석 결과 |
| ExceptionType | Crash 타입 |
| Location | Crash 발생 위치  |
| lncIssueID | 이슈 아이디 |
