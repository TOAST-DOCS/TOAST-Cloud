## NHN Cloud > SDK 사용 가이드 > Log & Crash > iOS

## Prerequisites

1. [NHN Cloud SDK](./getting-started-ios)를 설치합니다.
2. [NHN Cloud 콘솔](https://console.nhncloud.com)에서 [Log & Crash Search를 활성화](https://docs.nhncloud.com/ko/Data%20&%20Analytics/Log%20&%20Crash%20Search/ko/console-guide/)합니다.
3. Log & Crash Search에서 [AppKey를 확인](https://docs.nhncloud.com/ko/Data%20&%20Analytics/Log%20&%20Crash%20Search/ko/console-guide/#appkey)합니다.

## NHN Cloud Logger 구성

* iOS용 NHN Cloud Logger SDK의 구성은 다음과 같습니다.

| Service  | Cocoapods Pod Name | Framework | Dependency | Build Settings |
| --- | --- | --- | --- | --- |
| Log & Crash | NHNCloudLogger | NHNCloudLogger.framework | [External & Optional]<br/> * CrashReporter.framework (NHNCloud) |  |
| Mandatory   | NHNCloudCore<br/>NHNCloudCommon | NHNCloudCore.framework<br/>NHNCloudCommon.framework | | OTHER_LDFLAGS = (<br/>    "-ObjC",<br/>    "-lc++" <br/>); |

## NHN Cloud Logger SDK를 Xcode 프로젝트에 적용

### 1. Cococapods 적용

* Podfile을 생성하여 NHN Cloud SDK에 대한 pod를 추가합니다.

```podspec
platform :ios, '11.0'
use_frameworks!

target '{YOUR PROJECT TARGET NAME}' do
    pod 'NHNCloudLogger'
end
```

### 2. Swift Package Manager를 사용해 NHN Cloud SDK 적용

* XCode에서 **File > Add Packages...** 메뉴를 선택합니다.
* Package URL에 'https://github.com/nhn/nhncloud.ios.sdk'를 넣고 **Add Package** 버튼을 선택합니다.
* NHNCloudLogger를 선택합니다.

![swift_package_manager](https://static.toastoven.net/toastcloud/sdk/ios/swiftpackagemanager01.png)

#### 프로젝트 설정

* **Build Settings**의 **Other Linker Flags**에 **-lc++**와 **-ObjC** 항목을 추가합니다.
    * **Project Target > Build Settings > Linking > Other Linker Flags**
![other_linker_flags](https://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags_202206.png)

### 3. 바이너리를 다운로드하여 NHN Cloud SDK 적용

#### 프레임워크 설정

* NHN Cloud의 [Downloads](../../../Download/#toast-sdk) 페이지에서 전체 iOS SDK를 다운로드할 수 있습니다.
* Xcode Project에 **NHNCloudLogger.framework**, **NHNCloudCore.framework**, **NHNCloudCommon.framework**를 추가합니다.
* NHN Cloud Logger의 Crash Report 기능을 사용하려면 함께 배포되는 **CrashReporter.framework**도 프로젝트에 추가해야 합니다.
![linked_frameworks_logger](https://static.toastoven.net/toastcloud/sdk/ios/logger_link_frameworks_logger_202206.png)

#### 프로젝트 설정

* **Build Settings**의 **Other Linker Flags**에 **-lc++**와 **-ObjC** 항목을 추가합니다.
    * **Project Target > Build Settings > Linking > Other Linker Flags**
![other_linker_flags](https://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags_202206.png)

* **CrashReporter.framework**를 직접 다운로드하거나 빌드한 경우에는 **Build Setting**의 **Enable Bitcode**의 값을 **NO**로 변경해야 합니다.
    * **Project Target > Build Settings > Build Options > Enable Bitcode**
![enable_bitcode](https://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags_202206.png)
> NHN Cloud의 [Downloads](../../../Download/#toast-sdk) 페이지에서 다운로드한 CrashReporter.framework는 bitCode를 지원합니다.

## NHN Cloud Symbol Uploader 적용

### 프로젝트의 디버그 설정 변경
* 빌드 설정을 변경하여 프로젝트의 디버그 정보 형식을 변경해야합니다.
* Xcode -> Project Target -> Build Settings -> Debug Information Format -> Debug -> DWARF with dSYM File

### 개발 환경에서 Run Script를 사용하여 자동 업로드

* Xcode -> Project Target -> Build Phases -> + -> New Run Script Phase
* 표시되는 새 Run Script 섹션을 펼칩니다.
* Shell(셸) 필드 아래에 있는 스크립트 필드에서 새 실행 스크립트를 추가합니다.
```
if [ "${CONFIGURATION}" = "Debug" ]; then
    ${PODS_ROOT}/NHNCloudSymbolUploader/nhncloud.ios.sdk-*/run --app-key LOG_N_CRASH_SEARCH_DEV_APPKEY
fi
```
* LOG_N_CRASH_SEARCH_APPKEY에는 Log & Crash Search의 앱키를 입력해야합니다.
* Run Script 섹션 하단의 Input Files에 dSYM의 기본 경로를 설정합니다.
    * ${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}/Contents/Resources/DWARF/${TARGET_NAME}

![symbol_uploader_script_pods_path](https://static.toastoven.net/toastcloud/sdk/ios/symbol_uploader_guide_script_pods_path_202206.png)

### Symbol Uploader를 사용하여 직접 업로드

* SymbolUploader 사용법

```
USAGE: symbol-uploader -ak <ak> -pv <pv> [-sz <sz>] <path> [--verbose]

ARGUMENTS:
  <path>                  dSYM file path is must be entered. 

OPTIONS:
  -ak, --app-key <ak>     [Log&Crash Search]'s AppKey must be entered. 
  -pv, --project-version <pv>
                          Project version must be entered. 
  -sz, --service-zone <sz>
                          You can choose between real, alpha, and demo. (default: real)
  --verbose               Show more debugging information 
  -h, --help              Show help information.

```

* Xcode의 Run Script를 사용하지 않고 사용자가 원하는 시점에 아래와 같은 방법으로 SymbolUploader를 사용하여 직접 Symbol을 업로드 할 수 있습니다.

```
./SymbolUploader --app-key {APP_KEY} --project-version {CFBundleShortVersionString || MARKETING_VERSION} {symbol path(~/Project.dSYM)}
```

> `동일한 버전의 Symbol이 이미 업로드되어 있는 경우 SymbolUploader는 업로드되어 있는 Symbol을 제거하고 업로드를 수행합니다.`
> 이때 두 Symbol 파일의 `파일명이 다를 경우 업로드되어 있던 Symbol은 제거되지 않습니다.`
> Log & Crash Search 콘솔에서 업로드되어 있는 Symbol을 제거해야 합니다.
> https://console.nhncloud.com/-> 조직 선택 -> 프로젝트 선택 -> Anaytics -> Log & Crash Search -> 설정 -> 심벌 파일

### CrashReport 사용시 주의사항

* arm64e 아키텍처를 사용하는 기기의 크래시 분석을 위해서는 NHN Cloud Logger와 함께 배포되는 PLCrashReporter를 사용해야 합니다.
    * NHN Cloud의 [Downloads](../../../Download/#toast-sdk) 페이지가 아닌 다른 곳에서 다운로드하거나 직접 빌드한 PLCrashReporter를 사용할 경우 arm64e 아키텍처를 사용하는 기기의 크래시 분석이 불가능합니다.

## NHN Cloud Logger SDK 초기화

* Log & Crash Search에서 발급 받은 AppKey를 설정합니다.

### 초기화 API 명세

``` objc
// 초기화
+ (void)initWithConfiguration:(NHNCloudLoggerConfiguration *)configuration;
```

### 초기화 예

```objc
NHNCloudLoggerConfiguration *configuration = [NHNCloudLoggerConfiguration configurationWithAppKey:@"YOUR_APP_KEY"];
[NHNCloudLogger initWithConfiguration:configuration];
```

## 로그 전송

* NHN Cloud Logger는 5가지 레벨의 로그 전송 함수를 제공합니다.

### 로그 전송 API 명세

```objc
// DEBUG Level log
+ (void)debug:(NSString *)message;

// INFO Level log
+ (void)info:(NSString *)message;

// WARN Level log
+ (void)warn:(NSString *)message;

// ERROR Level log
+ (void)error:(NSString *)message;

// FATAL Level log
+ (void)fatal:(NSString *)message;
```

### 로그 전송 API 사용 예

```objc
[NHNCloudLogger info:@"NHN Cloud Log & Crash Search!"];
```

## 사용자 정의 필드 설정

* 원하는 사용자 정의 필드를 설정합니다.
* 사용자 정의 필드를 설정하면 로그 전송 API를 호출할 때마다 설정한 값을 로그와 함께 서버로 전송합니다.

### 사용자 정의 필드 API 명세

```objc
// 사용자 정의 필드 추가
+ (void)setUserFieldWithValue:(NSString *)value forKey:(NSString *)key;
```

* 사용자 정의 필드는 **Log & Crash Search > 로그 검색**을 클릭한 후 **로그 검색** 화면의 **선택한 필드**에 표시되는 값과 같습니다.

#### 사용자 정의 필드 제약사항

* 이미 [예약된 필드](./log-collector-reserved-fields)는 사용할 수 없습니다.  
* 필드 이름은 'A-Z, a-z'로 시작하고 'A-Z, a-z, 0-9, -, _' 문자를 사용할 수 있습니다.
* 필드 이름의 공백은 '_'로 치환됩니다.


### 사용자 정의 필드 사용 예
```objc
// 사용자 정의 필드 추가
[NHNCloudLogger setUserFieldWithValue:@"USER_VALUE" forKey:@"USER_KEY"];
```

## 크래시 로그 수집
* NHN Cloud Logger는 크래시 정보를 로그로 전송하는 기능을 제공합니다.
* NHN Cloud Logger를 초기화할 때 함께 활성화되고 사용 여부를 설정할 수 있습니다.
* 크래시 로그를 전송하려면 PLCrashReporter를 사용합니다.

### CrashReporter 사용 여부 설정
* CrashReporter 기능은 기본적으로 NHN Cloud Logger를 초기화할 때 함께 활성화됩니다.
* NHN Cloud Logger를 초기화할 때 사용 여부를 설정할 수 있습니다.
* 크래시 로그 전송을 기능을 사용하지 않으려면 CrashReporter 기능을 비활성화해야 합니다.

> 사용자 아이디가 설정되어 있으면 Log & Crash Search 콘솔의 `크래시 사용자` 항목에서 사용자별 크래시 경험을 확인할 수 있습니다.
> 사용자 아이디 설정은 [시작하기](./getting-started-ios/#사용자-아이디-설정)에서 확인 가능합니다.

#### CrashReporter 활성화
```objc
// CrashReporter 활성화
NHNCloudLoggerConfiguration *configuration = [NHNCloudLoggerConfiguration configurationWithAppKey:@"YOUR_APP_KEY" enableCrashReporter:YES];

[NHNCloudLogger initWithConfiguration:configuration];
```
#### CrashReporter 비활성화
```objc
// CrashReporter 비활성화
NHNCloudLoggerConfiguration *configuration = [NHNCloudLoggerConfiguration configurationWithAppKey:@"YOUR_APP_KEY" enableCrashReporter:NO];

[NHNCloudLogger initWithConfiguration:configuration];
```

## 크래시 발생 시점에 추가 정보를 설정하여 전송

* 크래시 발생 직후, 추가 정보를 설정할 수 있습니다.
* setShouldReportCrashHandler의 Block에서 사용자 정의 필드를 설정하면 정확히 크래시가 발생한 시점에 추가 정보를 설정할 수 있습니다.

### Data Adapter API 명세
```objc
+ (void)setShouldReportCrashHandler:(void (^)(void))handler;
```

### Data Adapter 사용 예

```objc
[NHNCloudLogger setShouldReportCrashHandler:^{
  // 사용자 정의 필드 를 통해 Crash가 발생한 상황에서 얻고자 하는 정보를 함께 전송    
  // 사용자 정의 필드 추가
  [NHNCloudLogger setUserFieldWithValue:@"USER_VALUE" forKey:@"USER_KEY"];

}];
```

## 로그 전송 후 추가작업 진행

* Delegate를 등록하면 로그 전송 후 추가 작업을 진행할 수 있습니다.


### Delegate 설정 API 명세
```objc
+ (void)setDelegate:(id<NHNCloudLoggerDelegate>) delegate;
```

### Delegate API 명세

``` objc
@protocol NHNCloudLoggerDelegate <NSObject>
@optional
// 로그 전송 성공
- (void)nhnCloudLogDidSuccess:(NHNCloudLog *)log;

// 로그 전송 실패
- (void)nhnCloudLogDidFail:(NHNCloudLog *)log error:(NSError *)error;

// 네트워크 단절 등의 이유로 로그 전송에 실패한 경우 재전송을 위해 SDK 내부 저장
- (void)nhnCloudLogDidSave:(NHNCloudLog *)log;

// 로그 필터링
- (void)nhnCloudLogDidFilter:(NHNCloudLog *)log logFilter:(NHNCloudLogFilter *)logFilter;
@end
```


### Delegate 설정 및 사용 예

```objc
#import <NHNCloudLogger/NHNCloudLogger.h>

@interface AppDelegate () <UIApplicationDelegate, NHNCloudLoggerLoggerDelegate>

@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // ...

    // 초기화
    NHNCloudLoggerConfiguration *configuration = [NHNCloudLoggerConfiguration configurationWithAppKey:@"YOUR_APP_KEY" enableCrashReporter:YES];
    [NHNCloudLogger initWithConfiguration:configuration];

    // Delegate 설정
    [[NHNCloudLogger setDelegate:self];

    return YES;
}

#pragma mark - NHNCloudLoggerDelegate
// 로그 전송 성공
- (void)nhnCloudLogDidSuccess:(NHNCloudLog *)log {
      // ...
 }

// 로그 전송 실패
- (void)nhnCloudLogDidFail:(NHNCloudLog *)log error:(NSError *)error {
      // ...
}

// 네트워크 단절 등의 이유로 로그 전송에 실패한 경우 재전송을 위해 SDK 내부 저장
- (void)nhnCloudLogDidSave:(NHNCloudLog *)log {
      // ...
}

// 로그 필터링
- (void)nhnCloudLogDidFilter:(NHNCloudLog *)log logFilter:(NHNCloudLogFilter *)logFilter {
      // ...
}

@end
```

## Network Insights
* Network Insights는 콘솔에 등록한 URL을 호출하여 지연 시간과 응답값을 측정합니다. 이를 활용하여 세계 여러 나라(디바이스의 국가 코드 기준)에서의 지연 시간과 응답값을 측정할 수 있습니다.

> 콘솔을 통해 Network Insights 기능을 활성화하면 NHN Cloud Logger를 초기화할 때, 콘솔에 등록한 URL로 1회 요청합니다.

### Network Insights 활성화

1. [NHN Cloud Console](https://console.nhncloud.com/)에서 **Log & Crash Search** 서비스를 클릭합니다.
2. **설정** 메뉴를 클릭합니다.
3. **로그 전송 설정** 탭을 클릭합니다.
4. **Network Insights 로그**를 활성화합니다.

### URL 설정

1. [NHN Cloud Console](https://console.nhncloud.com/)에서 **Log & Crash Search** 서비스를 클릭합니다.
2. **네트워크 인사이트** 메뉴를 클릭합니다.
3. **URL 설정** 탭을 클릭합니다.
4. 측정하려는 URL을 입력하고 **추가** 버튼을 클릭합니다.

## 공공기관용 NHN Cloud Logger 
* NHN Cloud Logger는 공공기관용 클라우드 환경을 지원합니다.

### 공공기관용 NHN Cloud Logger 설정하기 
* NHNCloudLoggerConfiguration의 cloudEnvironment property로 공공기관용 클라우드 사용 설정이 가능합니다. 

```objc
typedef NS_ENUM(NSInteger, NHNCloudEnvironment) {
    NHNCloudEnvironmentPublic = 0,
    NHNCloudEnvironmentGovernment = 1,
};

@property (nonatomic) NHNCloudEnvironment cloudEnvironment;
```
* 설정하지 않을 경우 기본값은 `NHNCloudEnvironmentPublic`입니다. 

#### 공공기관용 NHN Cloud Logger 초기화 예

```objc
NHNCloudLoggerConfiguration *configuration = [NHNCloudLoggerConfiguration configurationWithAppKey:@"YOUR_APP_KEY"];
[configuration setCloudEnvironment:NHNCloudEnvironmentGovernment];

[NHNCloudLogger initWithConfiguration:configuration];
```

### 공공기관용 NHN Cloud Logger 사용 시 주의사항

* 공공기관용 Log & Crash Search는 아래 기능을 지원하지 않습니다.
    * Console Settings
        * Console Settings을 사용하도록 설정할 경우 Default Settings이 적용됩니다. 
            * 모든 Log 전송
            * 필터 비활성화
            * Session / Crash Log 비활성화
            * Network Insight 비활성화
    * CrashReporter 
    * Network Insight

