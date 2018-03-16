## TOAST > TOAST SDK 사용 가이드 > 개요

TOAST SDK는 [TOAST](https://toast.com/) 상품을 손쉽고 빠르게 사용할 수 있는 통합 서비스를 제공합니다.

## Android
### Prerequisites

* Android 4.0.3 이상
* Android Studio 최신 버전 (버전 2.2 이상)

### Add TOAST SDK to Your Project

#### Add SDK

프로젝트에 TOAST SDK를 사용하려는 경우 몇 가지 기본적인 작업을 수행하여 Android Studio 프로젝트를 준비해야 합니다.

build.gradle 파일에 TOAST SDK에 대한 종속성을 추가합니다.

```groovy
dependencies {
  // ...
  compile 'com.toast.android:toast-sdk:0.0.4'
  // ...
}
```

### Available libraries

TOAST SDK는 다음과 같은 라이브러리를 사용할 수 있습니다.

| Gradle Dependency | Service |
| --- | --- |
| com.toast.android:toast-logger:0.0.4 | Log Collection |
| com.toast.android:toast-crash:0.0.4 | Crash Reporter |
| com.toast.android:toast-dfp:0.0.4 | Device Finger Printing |

### Intiailize TOAST SDK

TOAST SDK의 다양한 상품을 사용하기 위해서는 Application#onCreate에 TOAST SDK를 초기화해야 합니다.

```java
public class YourApplication extends Application {
    @Override
    public void onCreate() {
        super.onCreate();
        // ...

        // Initialize TOAST SDK
        ToastSdk.initialize(getApplicationContext());
    }
}
```


## iOS
### Prerequisites

* iOS 8.0 이상
* XCode 최신 버전 (버전 8 이상)

### Add TOAST SDK to Your Project

#### Add SDK

프로젝트에 TOAST SDK를 사용하려는 경우 몇 가지 기본적인 작업을 수행하여 XCode 프로젝트를 준비해야 합니다.

##### CococaPods

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
#import <ToastDFP/ToastDFP.h>
```

##### Manual Import

###### SDK import

다운로드 받은 framework 들을 프로젝트에 추가 합니다.

![import_framework](http://static.toastoven.net/toastcloud/sdk/ios/01_import_framework.png)

ToastCrash를 사용하기 위해서는 함께 배포되는 PLCrashReporter도 프로젝트에 함께 추가해야합니다.

![import_external_framework](http://static.toastoven.net/toastcloud/sdk/ios/02_import_external_framework.png)

프로젝트에 다음과 같이 Framework 들이 추가 된 것을 확인합니다.

![import_success](http://static.toastoven.net/toastcloud/sdk/ios/03_import_success.png)


ToastSDK 사용을 위해 다음과 같이 libresolv9 Library를 추가합니다.

* Project Target - General - Linked Frameworks and Libraries - libresolv.9

![import_library01](http://static.toastoven.net/toastcloud/sdk/ios/04_import_library_01.png)

ToastSDK를 사용하기 위해서는 프로젝트에 아래와 같이 Framework와 Library가 추가되어야 합니다.

![import_library02](http://static.toastoven.net/toastcloud/sdk/ios/04_import_library_02.png)

###### Project Settings

C++을 사용하여 개발된 Logger를 위해 다음과 같이 Other Linker Flags 에 "-lc++" 항목을 추가해야합니다.

* Project Target - Build Settings - Linking - Other Linker Flags - "-lc++"

![other_linker_flags](http://static.toastoven.net/toastcloud/sdk/ios/06_project_setting.png)

함께 배포되는 PLCRashreporter가 아닌 직접 받거나 빌드한 PLCrashReport를 사용할 경우에는 Build Setting의 Enable Bitcode의 값을 NO로 변경해야 합니다.

* Project Target - Build Settings - Build Options - Enable Bitcode - "NO"

![enable_bitcode](http://static.toastoven.net/toastcloud/sdk/ios/05_project_setting.png)


###### import framework 

사용하고자 하는 Framework를 import 한 뒤 사용합니다.

```objc
#import <ToastCore/ToastCore.h>
#import <ToastCommon/ToastCommon.h>
#import <ToastLogger/ToastLogger.h>
#import <ToastCrash/ToastCrash.h>
#import <ToastDFP/ToastDFP.h>
```


### Available libraries

| Framework | Service |
| --- | --- |
| ToastLogger | Log Collection |
| ToastCrash | Crash Reporter |
| ToastDFP | Device Finger Printing |


## Unity
### Prerequisites

* Android 4.0.3 이상
* iOS 8.0 이상
* Unity 5.3.4 이상

### Add TOAST SDK to Your Project

최신의 Unity Plugin을 다운로드 합니다. Unity Plugin은 아래와 같이 구성되어 있습니다.

| 아이템 | 내용 |
| --- | --- |
| Plugins/Android | Android 플러그인 입니다. |
| Plugins/iOS | iOS 플러그인 입니다. |
| Toast/Script | 초기화와 TOAST SDK를 호출하는 C# 스크립트 입니다. |
| Toast/Demo | 샘플 앱 입니다. |

#### Add SDK

프로젝트에 TOAST SDK를 사용하려는 경우 몇 가지 기본적인 작업을 수행하여 Unity 프로젝트에 적용합니다.

다운로드 받은 "toast-unity-sdk.unitypackage"를 더블 클릭하여 프로젝트에 포함합니다.

![import_unitypackage](http://static.toastoven.net/toastcloud/sdk/unity/unity_setup_import_unitypackage.png)

### Initialize TOAST SDK

1\. Adding the TOAST SDK Component

* 유니티 에디터에서, 새로운 GameObject를 생성합니다.
* GameObject의 이름을 "TOAST SDK Initializer"로 변경합니다.
* TOAST SDK Initializer를 선택하고, Hierarchy 창에서 Add Component를 눌러 "ToastSDK" 스크립트를 추가합니다.

![toast_sdk_initializer](http://static.toastoven.net/toastcloud/sdk/unity/unity_setup_toast_sdk_initializer.png)

2\. initializing TOAST SDK

* ToastSDK 스크립트에 ProjectKey와 ProjectVersion을 입력합니다.

![input_project_settings](http://static.toastoven.net/toastcloud/sdk/unity/unity_setup_input_project_settings.png)

3\. Configure Unity Build and Player Settings

* Unity에는 TOAST SDK가 서버로 로그를 전송하는데 영향을 주는 몇가지 설정들이 있습니다.
* 이 설정들의 효과를 간략히 설명하고 TOAST SDK의 권장 설정에 대해 설명합니다.

| 목록 | 설정 | 권장 설정 |
| --- | --- | ----- |
| Build Settings | Script Debugging | OFF |
| Player Settings > Debugging and crash reporting | On .Net UnhandledException | Silent Exit |
| Player Settings > Debugging and crash reporting | Enable CrashReport API | Disabled |
| Player Settings > Other Settings | Script Call Optimization | Slow and Safe |

#### Script Debugging

* Crash의 StackTrace에서 Crash가 발생한 LineNumber를 가져옴니다. Release의 경우 OFF로 설정합니다.

#### On .Net UnhandledException

* On .Net UnhandledException를 Crash로 설정할 경우 예외 발생 시, 즉시 앱이 종료됩니다. 
* Silent Exit로 설정해야 Unity Exceptoin을 캡처할 수 있습니다.

#### Enable CrashReport API

* Unity CrashReporter API를 활성화 합니다. Toast Crash SDK를 사용하는 경우 Disabled로 설정합니다.

#### Script Call Optimization

* Runtime C# Crash 로그를 수집하고자 하는 경우 Slow and Safe로 설정해야 합니다.


## Next steps

* [Logger](./toast-sdk-log.md)
* [Crash Reporter](./toast-sdk-crash.md)
* [Device Finger Printing](./toast-sdk-finger.md)
