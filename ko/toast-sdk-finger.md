## Analytics > Log & Crash Search > TOAST SDK 사용 가이드 > Device Finger Printing

TOAST DFP SDK는 기기 정보 및 어플리케이션 상호 작용 이벤트를 수집하여 부정행위(Fraud) 탐지의 정확도 향상에 사용합니다.

* [Android 설정](#Android)
* [iOS 설정](#iOS)
* [Unity 설정](#Unity)

## Introduction
### Prerequisites

1\. [Install the TOAST SDK](./toast-sdk-overview.md)

2\. [TOAST 콘솔](https://console.cloud.toast.com)에서 [Log & Crash Search를 활성화](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/)합니다.

3\. [TOAST Logger를 초기화](./toast-sdk-log.md)합니다.

## Android
### Initialize

onCreate() 메소드에서 ToastDfp를 초기화합니다.

```java
// Initialize DFP
ToastDfp.initialize();
```

### Set Priority

수집 정보에 대한 우선순위를 설정합니다.

```java
ToastDfp.setPriority(DfpPriority.PRIORITY_1);
```

#### Priority

| 우선순위 | Value |  |
| -- | -- | -- |
| 1 | PRIORITY_1 | 우선순위 1 정보를 전송합니다. |
| 2 | PRIORITY_2 | 우선순위 1~2 정보를 전송합니다. |
| 3 | PRIORITY_3 | 우선순위 1~3 정보를 전송합니다. |
| 4 | PRIORITY_4 | 우선순위 1~4 정보를 전송합니다. |
| Default  | PRIORITY_ALL | 모든 정보를 전송합니다. |

### Add User Data

사용자가 원하는 데이터를 추가합니다.

```java
ToastDfp.addDfpValue("UserDataField", "UserDataValue");
```

> 이미 예약된 필드는 사용할 수 없습니다.


## iOS
### Initialize

``` objc
TCISDFPConfiguration *configuration = [TCISDFPConfiguration configurationWithProjectKey:YOUR_PROJECT_KEY
                                                                      projectVersion:YOUR_PROJECT_VERSION];
    
[TCISDFP initWithConfiguration:configuration];
[TCISDFP startUpdatingLocation];
[TCISDFP setUserIdentifier:@"test_user"];
```

### Set UserID

사용자 아이디를 설정합니다.
설정된 사용자 아이디는 "UserID" 필드로 Log & Crash Search에서 조회할 수 있습니다.

``` objc
[TCISDFP setUserIdentifier:userID];
```

### Set Priority

수집 정보에 대한 우선순위를 설정합니다.

``` objc
[TCISDFP setPriority:TCISDFPPriority_1];
```

#### Priority

| 우선순위 | Value |  |
| ---- | ----- | --- |
| 1 | TCISDFPPriority_1 | 우선순위 1 정보를 전송합니다. |
| 2 | TCISDFPPriority_2 | 우선순위 1~2 정보를 전송합니다. |
| 3 | TCISDFPPriority_3 | 우선순위 1~3 정보를 전송합니다. |
| 4 | TCISDFPPriority_4 | 우선순위 1~4 정보를 전송합니다. |
| Default | TCISDFPPriority_All | 모든 정보를 전송합니다. |

### Location Data

사용자 위치 정보를 수집합니다.

``` objc
[TCISDFP startUpdatingLocation];
[TCISDFP stopUpdatingLocation];
```

> 위치 정보 수집을 위해서는 plist 파일에 NSLocationWhenInUseUsageDescription 항목 정의가 필요하며, 최초 실행시 권한 요청 Alert 창이 표시됩니다.

### Set User Data

사용자가 원하는 데이터를 추가합니다.

``` objc
[TCISDFP setUserField:@"UserValue" key:@"UserKey"];  // 추가
```

> 이미 예약된 필드는 사용할 수 없습니다.

### Start Service

추가 설정 완료 후에 서비스 시작 함수를 호출해야 수집을 시작합니다.

``` objc
[TCISDFP startService];
[TCISDFP stopService];
```

### User Event

DFP 수집 주기와는 별개로 생성한 유저 이벤트를 즉시 전송합니다.

``` objc
TCISDFPUserEvent *event = [[TCISDFPUserEvent alloc] initWithName:USER_EVENT_NAME];
[event setValue:@"UserEventValue" forKey:@"UserEventKey"];

[TCISDFP sendUserEvent:event];
```

## Unity (준비중)