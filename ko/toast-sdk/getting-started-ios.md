## TOAST > TOAST SDK 사용 가이드 > 시작하기 > iOS

## 지원 환경

* iOS 8.0 이상
* XCode 최신 버전(버전 10 이상)

## TOAST SDK의 구성

* iOS용 TOAST SDK의 구성은 다음과 같습니다.
    * [TOAST Logger](./log-collector-ios) SDK
    * [TOAST In-app Purchase AppStore](./iap-ios) SDK
    * [TOAST Push](./push-ios) SDK

* TOAST SDK가 제공하는 서비스 중 원하는 기능을 선택해 적용할 수 있습니다.

| Service | Cocoapods Pod Name | Carthage | Framework | Dependency | Build Settings |
| ------- | ------------------ | -------- | --------- | ---------- | -------------- |
| All | ToastSDK | git nhn/toastcloud.sdk<br> | ToastCore.framework<br>ToastCommon.framework<br>ToastLogger.framework<br>ToastIAP.framework<br>ToastPush.framework |  |  |
| Mandatory | ToastCore<br>ToastCommon |  | ToastCore.framework<br>ToastCommon.framework |  | OTHER\_LDFLAGS = (<br>"-ObjC",<br>"-lc++"<br>); |
| TOAST Log & Crash | ToastLogger |  | ToastLogger.framework | [External & Optional]<br>\* CrashReporter.framework (Toast) |  |
| TOAST IAP | ToastIAP |  | ToastIAP.framework | \* StoreKit.framework<br><br>[Optional]<br>\* libsqlite3.tdb |  |
| TOAST Push | ToastPush |  | ToastPush.framework | \* UserNotifications.framework<br><br>[Optional]<br>\* PushKit.framework |  |

## TOAST SDK를 Xcode 프로젝트에 적용

### 1. Cococapods를 사용해 TOAST SDK 적용

* Podfile을 생성하여 TOAST SDK에 대한 Pod을 추가합니다.

```podspec
platform :ios, '8.0'
use_frameworks!

target '{YOUR PROJECT TARGET NAME}' do
    pod 'ToastSDK'
end
```

### 2. Carthage를 사용해 TOAST SDK 적용
#### Cartfile 설정
* Cartfile을 생성하여 TOAST SDK의 Release Github Repository를 추가합니다.
```
github "nhn/toastcloud.sdk"
```

#### SDK 가져오기 (import)
* 생성된 Carthage/Build 폴더의 Framework를 Xcode 프로젝트에 추가합니다. 
![carthage_import_framework](http://static.toastoven.net/toastcloud/sdk/ios/carthage_setting_01.png)

* 프로젝트에 다음과 같이 프레임워크(framework)가 추가된 것을 확인합니다.
![import_carthage_frameworks_complete](http://static.toastoven.net/toastcloud/sdk/ios/carthage_setting_02.png)

#### 필수 Framework 추가와 프로젝트 설정
* TOAST SDK를 사용하기 위해 [필수 Framework](./getting-started-ios/#필수-Framework-추가)와 [프로젝트 설정](./getting-started-ios/#프로젝트-설정)을 추가합니다.

> 서비스 중 원하는 기능을 선택하여 사용하기 위해서는 서비스별로 필요한 Framework만 선택하여 프로젝트에 추가해야 합니다.
> 서비스별로 필요한 Framework는 [TOAST SDK의 구성](./getting-started-ios/#TOAST-SDK의-구성)에서 확인 할 수 있습니다. 

### 3. 바이너리를 다운로드하여 TOAST SDK 적용

#### SDK 가져오기(import)

* TOAST의 [Downloads](../../../Download/#toast-sdk) 페이지에서 전체 iOS SDK를 다운로드할 수 있습니다.
![import_frameworks](http://static.toastoven.net/toastcloud/sdk/ios/overview_import_frameworks_folder.png)

* TOAST Logger의 Crash Report 기능을 사용하려면 함께 배포되는 CrashReporter.framework도 프로젝트에 추가해야 합니다.
![import_external_framework](http://static.toastoven.net/toastcloud/sdk/ios/overview_import_external_folder.png)

* 프로젝트에 다음과 같이 프레임워크(framework)가 추가된 것을 확인합니다.
![import_frameworks_complete](http://static.toastoven.net/toastcloud/sdk/ios/overview_import_complete_folder.png)

#### 필수 Framework 추가
* TOAST IAP 기능을 사용하려면 StoreKit.framework를 추가해야 합니다.
![linked__storekit_frameworks](http://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_StoreKit.png)

* TOAST Push 기능을 사용하려면 UserNotifications.framework를 추가해야 합니다.
![linked__usernotifications_frameworks](http://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_UserNotifications.png)


### 프로젝트 설정

* **Build Settings**의 **Other Linker Flags**에 **-lc++**와 **-ObjC** 항목을 추가합니다.
    * **Project Target > Build Settings > Linking > Other Linker Flags**
![other_linker_flags](http://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags.png)

* **CrashReporter.framewor**를 직접 다운로드하거나 빌드한 경우에는 **Build Setting**의 **Enable Bitcode**의 값을 **NO**로 변경해야 합니다.
    * **Project Target > Build Settings > Build Options > Enable Bitcode**을 클릭하고 **NO**를 클릭합니다.
![enable_bitcode](http://static.toastoven.net/toastcloud/sdk/ios/overview_settings_bitcode.png)
> TOAST의 [Downloads](../../../Download/#toast-sdk) 페이지에서 다운로드한 CrashReporter.framework는 bitCode를 지원합니다.

### 프레임워크 가져오기

* 사용하려는 프레임워크를 가져옵니다(import).

```objc
#import <ToastCore/ToastCore.h>
#import <ToastLogger/ToastLogger.h>
#import <ToastIAP/ToastIAP.h>
#import <ToastPush/ToastPush.h>
```

## 사용자 아이디 설정

* TOASAT SDK에 사용자 아이디를 설정할 수 있습니다.
* 설정한 사용자 아이디는 TOAST SDK의 각 모듈에서 공통으로 사용됩니다.
* TOAST Logger의 로그 전송 API를 호출할 때마다 설정한 사용자 아이디를 로그와 함께 서버로 전송합니다.

### 사용자 아이디 설정 API 명세

```objc
+ (void)setUserID:(NSString *)userID;
```

### 사용자 아이디 설정 사용 예

```objc
[ToastSDK setUserID:@"TOAST-USER"];
```
## 디버그 모드 설정

* TOAST SDK의 내부 로그를 확인하기 위해 디버그 모드를 설정할 수 있습니다.
* TOAST SDK와 관련해 문의하실 때는 디버그 모드를 활성화한 후 콘솔 로그를 전달해 주시면 빠르게 지원해드릴 수 있습니다.

### 디버그 모드 설정 API 명세


```objc
+ (void)setDebugMode:(BOOL)debugMode;
```

### 디버그 모드 설정 사용 예

```objc
[ToastSDK setDebugMode:YES];    // or NO
```

> [주의] 어플리케이션 배포시에는 디버그 모드를 `반드시` 비활성화해야 합니다.

## TOAST Service 사용

* [TOAST Log & Crash](./log-collector-ios) 사용 가이드
* [TOAST In-app Purchase](./iap-ios) 사용 가이드
* [TOAST Push](./push-ios) 사용 가이드
