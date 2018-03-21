## TOAST > TOAST SDK 사용 가이드 > 시작하기 > iOS

## Environments

* iOS 8.0 이상
* XCode 최신 버전 (버전 9 이상)

## Component SDKs

iOS용 TOAST SDK는 다음과 같은 SDK로 구성되어 있습니다.

* [TOAST Logger](./log-collector-ios) SDK
* [TOAST Crash](./crash-reporter-ios) SDK

전체 TOAST SDK 기능이 필요하지 않은 경우 앱에 필요한 SDK만 사용할 수 있습니다.

| Framework | Service |
| --- | --- |
| ToastLogger | Log Collection |
| ToastCrash | Crash Reporter |

## Add TOAST SDK to Your Project

프로젝트에 TOAST SDK를 사용하려는 경우 몇 가지 기본적인 작업을 수행하여 XCode 프로젝트를 준비해야 합니다.

### CococaPods

```podspec
platform :ios, '8.0'
use_frameworks!

target '{YOUR PROJECT TARGET NAME}' do
    pod 'ToastSDK'
end
```

생성된 Workspace를 열어 사용자고자하는 SDK를 Import 합니다.

```objc
#import <ToastCore/ToastCore.h>
#import <ToastCommon/ToastCommon.h>
#import <ToastLogger/ToastLogger.h>
#import <ToastCrash/ToastCrash.h>
```

### Manual Import

#### SDK import

다운로드 받은 framework 들을 프로젝트에 추가 합니다.

![import_frameworks](http://static.toastoven.net/toastcloud/sdk/ios/overview_import_frameworks.png)

ToastCrash를 사용하기 위해서는 함께 배포되는 PLCrashReporter도 프로젝트에 함께 추가해야합니다.

![import_external_framework](http://static.toastoven.net/toastcloud/sdk/ios/overview_import_external.png)

프로젝트에 다음과 같이 Framework 들이 추가 된 것을 확인합니다.

![import_frameworks_complete](http://static.toastoven.net/toastcloud/sdk/ios/overview_import_complete.png)

ToastSDK를 사용하기 위해서는 프로젝트에 아래와 같이 Framework와 Library가 추가되어야 합니다.

![link_frameworks](http://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks.png)

#### Project Settings

C++을 사용하여 개발된 Logger를 위해 다음과 같이 Other Linker Flags 에 "-lc++" 항목을 추가해야합니다.
SDK에 속한 모든 Objective-C Class 로드를 위해 "-ObjC" 항목을 추가해야합니다.

* Project Target - Build Settings - Linking - Other Linker Flags

![other_linker_flags](http://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags.png)

함께 배포되는 PLCrashReporter가 아닌 직접 받거나 빌드한 PLCrashReporter를 사용할 경우에는 Build Setting의 Enable Bitcode의 값을 NO로 변경해야 합니다.

* Project Target - Build Settings - Build Options - Enable Bitcode - "NO"

![enable_bitcode](http://static.toastoven.net/toastcloud/sdk/ios/overview_settings_bitcode.png)


#### import framework 

사용하고자 하는 Framework를 import 한 뒤 사용합니다.

```objc
#import <ToastCore/ToastCore.h>
#import <ToastCommon/ToastCommon.h>
#import <ToastLogger/ToastLogger.h>
#import <ToastCrash/ToastCrash.h>
```

## Using the TOAST Service

* [Log Collector](./log-collector-ios) 사용 가이드
* [Crash Reporter](./crash-reporter-ios) 사용 가이드

