## NHN Cloud > SDK 사용 가이드 > Push > iOS

## Prerequisites

1. [NHN Cloud SDK](./getting-started-ios)를 설치합니다.
2. [NHN Cloud 콘솔](https://console.nhncloud.com)에서 [Notification \> Push를 활성화](http://docs.nhncloud.com/ko/Notification/Push/ko/console-guide/)합니다.
3. Push에서 AppKey를 확인합니다.

## APNS 가이드
* [APNS 가이드](https://developer.apple.com/library/archive/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/APNSOverview.html)

## NHN Cloud Push 구성

* iOS용 NHN Cloud Push SDK의 구성은 다음과 같습니다.

| Service  | Cocoapods Pod Name | Framework | Dependency | Build Settings |
| --- | --- | --- | --- | --- |
| Push | NHNCloudPush | NHNCloudPush.framework | UserNotifications.framework<br/><br/>[NHNCloudVoIP]<br/>PushKit.framework<br/>CallKit.framework | |
| Mandatory   | NHNCloudCore<br/>NHNCloudCommon | NHNCloudCore.framework<br/>NHNCloudCommon.framework | | OTHER_LDFLAGS = (<br/>    "-ObjC",<br/>    "-lc++" <br/>); |

## NHN Cloud Push SDK를 Xcode 프로젝트에 적용

### 1. Cococapods 을 통한 적용

* Podfile을 생성하여 NHN Cloud SDK에 대한 Pod을 추가합니다.

``` podspec
platform :ios, '11.0'
use_frameworks!

target '{YOUR PROJECT TARGET NAME}' do
    pod 'NHNCloudPush'
end
```

### 2. Swift Package Manager를 사용해 NHN Cloud SDK 적용

* XCode에서 **File > Add Packages...** 메뉴를 선택합니다.
* Package URL에 'https://github.com/nhn/nhncloud.ios.sdk'를 넣고 **Add Package** 버튼을 선택합니다.
* NHNCloudPush를 선택합니다.

![swift_package_manager](https://static.toastoven.net/toastcloud/sdk/ios/swiftpackagemanager01.png)

#### 프로젝트 설정

* **Build Settings**의 **Other Linker Flags**에 **-lc++**와 **-ObjC** 항목을 추가합니다.
    * **Project Target > Build Settings > Linking > Other Linker Flags**
![other_linker_flags](https://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags_202206.png)

### 3. 바이너리를 다운로드하여 NHN Cloud SDK 적용

#### 프레임워크 설정

* NHN Cloud의 [Downloads](../../../Download/#toast-sdk) 페이지에서 전체 iOS SDK를 다운로드할 수 있습니다.
* Xcode Project에 **NHNCloudPush.framework**, **NHNCloudCore.framework**, **NHNCloudCommon.framework, UserNotifications.framework**를 추가합니다.
* UserNotifications.framework는 아래 방법으로 추가할 수 있습니다.
![linked_usernotifications_frameworks](https://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_UserNotifications_202206.png)

#### 프로젝트 설정

* **Build Settings**의 **Other Linker Flags**에 **-lc++**와 **-ObjC** 항목을 추가합니다.
    * **Project Target > Build Settings > Linking > Other Linker Flags**
![other_linker_flags](https://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags_202206.png)

### Capabilities 설정

* NHN Cloud Push를 사용하려면 Capabilities에서 **Push Notification**, **Background Modes** 항목을 활성화해야 합니다.
    * **Project Target > Signing & Capabilities > + Capability > Push Notification**
![add_capability_push_notifications](https://static.toastoven.net/toastcloud/sdk/ios/add_capability_notifications_202206.png)
    * **Project Target > Signing & Capabilities > + Capability > Background Modes**
![add_capability_background_modes](https://static.toastoven.net/toastcloud/sdk/ios/add_capability_background_modes_202206.png)
    * **Background Modes** 항목 중 **Remote notifications**를 활성화해야 합니다.
![capabilities](https://static.toastoven.net/toastcloud/sdk/ios/push_capabilities_202206.png)

## Xcode11 / iOS13 변경 사항
* VoIP
    * iOS13 이상부터 VoIP 메시지 수신 후에 CallKit 으로 리포트하지 않으면 메시지 수신이 제한됩니다. ([PushKit pushRegistry 가이드](https://developer.apple.com/documentation/pushkit/pkpushregistrydelegate/2875784-pushregistry))
    * CallKit 을 사용한 전화 수신 화면은 앱에서 직접 구현해야 합니다.

## 서비스 로그인

* NHN Cloud SDK에서 제공하는 모든 상품(Push, IAP, Log & Crash, ...)은 하나의 사용자 아이디를 공유합니다.

### 로그인

* `최초 토큰 등록 시 사용자 아이디가 설정되어 있지 않으면, 단말기 식별자를 사용하여 등록합니다.` ([토큰 등록 섹션 참고](https://docs.nhncloud.com/ko/nhncloud/ko/toast-sdk/push-ios/#_10))
* `토큰 등록 후 사용자 아이디를 설정 또는 변경하면 토큰 정보를 갱신합니다.`

``` objc
// 서비스 로그인, 사용자 아이디 설정
[NHNCloudSDK setUserID:@"INPUT_USER_ID"];
```

### 로그아웃

* `로그아웃 하여도 등록된 토큰은 삭제되지 않습니다.`

``` objc
// 서비스 로그아웃, 사용자 아이디를 nil로 설정
[NHNCloudSDK setUserID:nil];
```

## NHN Cloud Push SDK 초기화

* `초기화를 하지 않은 상태에서는 토큰 등록 및 조회 기능을 사용할 수 없습니다.`
* [NHNCloudPushConfiguration](./push-ios/#nhncloudpushconfiguration) 객체에 NHN Cloud 서버에서 발급 받은 Push AppKey를 설정합니다.
* `개발환경에서는 반드시 NHNCloudPushConfiguration의 sandbox 프로퍼티를 YES로 설정해야 개발용 인증서로 발송한 메시지의 수신이 가능합니다.`

### 초기화 API 명세

``` objc
// 초기화 및 Delegate 설정
+ (void)initWithConfiguration:(NHNCloudPushConfiguration *)configuration
                     delegate:(nullable id<NHNCloudPushDelegate>)delegate;

// 초기화
+ (void)initWithConfiguration:(NHNCloudPushConfiguration *)configuration;

// Delegate 설정
+ (void)setDelegate:(nullable id<NHNCloudPushDelegate>)delegate;
```

### Delegate API 명세
* 앱이 실행 중인 상태에서 알림 메시지 수신 시 [NHNCloudPushMessage](./push-ios/#nhncloudpushmessage) 객체로 수신 받은 메시지의 내용이 전달됩니다.
* 사용자가 알림을 실행(클릭)하여 앱이 실행되었을 때 [NHNCloudPushMessage](./push-ios/#nhncloudpushmessage) 객체로 실행된 알림 메시지의 내용이 전달됩니다.
* 사용자가 알림 상의 버튼을 실행(클릭) 하였을 때 [NHNCloudPushNotificationAction](./push-ios/#nhncloudpushnotificationaction) 객체로 실행된 버튼의 액션 정보가 전달됩니다.
* `원활한 메시지 수신을 위해 application:didFinishLaunchingWithOptions: 함수에서 Delegate 설정을 권장합니다.`

``` objc
@protocol NHNCloudPushDelegate <NSObject>

@optional

// 메시지 수신
- (void)didReceiveNotificationWithMessage:(NHNCloudPushMessage *)message;

// 알림 실행(클릭)
- (void)didReceiveNotificationResponseWithMessage:(NHNCloudPushMessage *)message

// 알림 액션(버튼) 실행
- (void)didReceiveNotificationAction:(NHNCloudPushNotificationAction *)action

@end
```

### 초기화 및 Delegate 설정 예

``` objc
#import <NHNCloudPush/NHNCloudPush.h>

@interface AppDelegate () <UIApplicationDelegate, NHNCloudPushDelegate>

@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // ...

    // 설정 객체를 생성합니다.
    NHNCloudPushConfiguration *configuration = [[NHNCloudPushConfiguration alloc] initWithAppKey:@"INPUT_YOUR_APPKEY"];

#if DEBUG
    // 개발환경(Debug)에서는 꼭 아래 sandbox 프로퍼티를 YES로 설정해야 개발용 인증서로 발송한 메시지의 수신이 가능합니다.
    configuration.sandbox = YES;
#endif

    // 알림 허용 권한을 획득하지 못하더라도 토큰을 등록하고 싶은 경우 alwaysAllowTokenRegistration 프로퍼티의 값을 YES로 변경해야합니다. 기본값은 NO입니다.
    configuration.alwaysAllowTokenRegistration = NO;

    // 초기화와 동시에 Delegate를 설정 합니다.
    [NHNCloudPush initWithConfiguration:configuration
                               delegate:self];

    return YES;
}

#pragma mark - NHNCloudPushDelegate
// 메시지 수신
- (void)didReceiveNotificationWithMessage:(NHNCloudPushMessage *)message {
    // ...
}

// 알림 응답(실행)
- (void)didReceiveNotificationResponseWithMessage:(NHNCloudPushMessage *)message {
    // ...
}

// 알림 액션(버튼, 답장) 실행
- (void)didReceiveNotificationAction:(NHNCloudPushNotificationAction *)action {
    // ...
}
```

## 알림 옵션 설정

* [NHNCloudNotificationOptions](./push-ios/#nhncloudnotificationoptions) 객체로 알림 옵션 설정이 가능합니다.

| 옵션명 | 설명 | 기본값 |
| --- | --- | --- |
| foregroundEnabled | 앱이 포그라운드 상태일때의 알림 노출 여부 | NO |
| badgeEnabled | 배지 아이콘 사용 여부 | YES |
| soundEnabled | 알림음 사용 여부 | YES |

* 앱이 포그라운드 상태일 때는 알림을 노출하지 않는 것이 기본 동작이므로 알림 노출을 원하시면, 알림 옵션을 설정해야 합니다.

### 알림 옵션 설정 API 명세

``` objc
+ (void)setNotificationOptions:(nullable NHNCloudNotificationOptions *)options;
```

### 알림 옵션 설정 예

``` objc
NHNCloudNotificationOptions *options = [[NHNCloudNotificationOptions alloc] init];
options.foregroundEnabled = YES;    // 포그라운드 알림 사용 설정 (default : NO)
options.badgeEnabled = YES;         // 배지 아이콘 사용 설정 (default : YES)
options.soundEnabled = YES;         // 알림음 사용 설정 (default : YES)

[NHNCloudPush setNotificationOptions:options];
```

## 토큰 등록

* 발급 받은 토큰 정보를 NHN Cloud 서버에 등록합니다. 이때 수신 동의 여부(NHNCloudPushAgreement)를 파라미터로 전달합니다.
* 최초 실행일 경우 사용자에게 알림 허용 권한을 요청합니다(alwaysAllowTokenRegistration의 기본값은 false입니다.).
    * NHNCloudPushConfiguration의 alwaysAllowTokenRegistration 값이 false일 경우
        * 알림 허용 권한을 획득하지 못한 경우 토큰 등록은 실패합니다.
    * NHNCloudPushConfiguration의 alwaysAllowTokenRegistration 값이 true일 경우
        * 알림 허용 권한을 획득하지 못하더라도 토큰을 등록합니다.
* 최초 토큰 등록 시 사용자 아이디가 설정되어 있지 않으면, 단말기 식별자를 사용하여 등록합니다.

### 수신 동의 설정

* 정보통신망법 규정(제50조부터 제50조의 8)에 따라 토큰 등록 시 알림/홍보성/야간홍보성 Push 메시지 수신에 관한 동의 여부도 함께 입력받습니다. 메시지 발송 시 수신 동의 여부를 기준으로 자동으로 필터링합니다.
    * [KISA 가이드 바로 가기](https://www.kisa.or.kr/2060301/form?postSeq=19)
    * [법령 바로 가기](http://www.law.go.kr/법령/정보통신망이용촉진및정보보호등에관한법률/%2820130218,11322,20120217%29/제50조)
* [NHNCloudPushAgreement](./push-ios/#nhncloudpushagreement) 객체에 사용자 알림 메시지 수신 동의 정보를 설정합니다.

### 토큰 등록 및 수신 동의 설정 API 명세

``` objc
// 토큰 등록 및 수신 동의 설정
+ (void)registerWithAgreement:(NHNCloudPushAgreement *)agreement
            completionHandler:(nullable void (^)(NHNCloudPushTokenInfo * _Nullable tokenInfo, NSError * _Nullable error))completionHandler;

// 기존에 설정된 수신 동의 정보를 사용하여 토큰 등록
+ (void)registerWithCompletionHandler:(nullable void (^)(NHNCloudPushTokenInfo * _Nullable tokenInfo, NSError * _Nullable error))completionHandler;
```

### 토큰 등록 및 수신 동의 설정 예

``` objc
NHNCloudPushAgreement *agreement = [[NHNCloudPushAgreement alloc] initWithAllowNotifications:YES]; // 알림 메시지 수신 동의
agreement.allowAdvertisements = YES;        // 홍보성 알림 메시지 수신 동의
agreement.allowNightAdvertisements = YES;   // 야간 홍보성 알림 메시지 수신 동의

[NHNCloudPush registerWithAgreement:agreement
                  completionHandler:^(NHNCloudPushTokenInfo *tokenInfo, NSError *error) {

    if (error == nil) {
        // 토큰 등록 성공
        NSLog(@"Successfully registered : %@", tokenInfo.deviceToken);

    } else {
        // 토큰 등록 실패
        NSLog(@"Failed to register : %@", error.localizedDescription);
    }
}];
```

## 토큰 정보 조회

* 현재 단말기에서 마지막으로 등록에 성공한 토큰과 설정 정보를 조회합니다.
* 토큰 조회 정보 성공 시 [NHNCloudPushTokenInfo](./push-ios/#nhncloudpushtokeninfo) 객체로 토큰의 설정 정보가 반환됩니다.

### 토큰 정보 조회 API 명세

``` objc
+ (void)queryTokenInfoWithCompletionHandler:(void (^)(NHNCloudPushTokenInfo * _Nullable tokenInfo, NSError * _Nullable error))completionHandler;
```

### 토큰 정보 조회 예

``` objc
[NHNCloudPush queryTokenInfoWithCompletionHandler:^(NHNCloudPushTokenInfo *tokenInfo, NSError *error) {
    if (error == nil) {
        // 토큰 정보 조회 성공
        NSLog(@"Successfully query token info : %@", [tokenInfo description]);

    } else {
        // 토큰 정보 조회 실패
        NSLog(@"Failed to query token info : %@", error.localizedDescription);
    }
}];
```

## 토큰 해제

* NHN Cloud 서버에 등록된 토큰을 해제합니다. 해제된 토큰은 메시지 발송 대상에서 제외됩니다.
* `서비스 로그아웃 후에 메시지 수신을 원치 않으시면 토큰을 해제해야 합니다.`
* `토큰이 해제되어도 단말기 상에 알림 권한은 회수되지 않습니다.`

### 토큰 해제 API 명세

``` objc
+ (void)unregisterWithCompletionHandler:(nullable void (^)(NSString * _Nullable deviceToken, NSError * _Nullable error))completionHandler;
```

### 토큰 해제 예

``` objc
[NHNCloudPush unregisterWithCompletionHandler:^(NSString *deviceToken, NSError *error) {
    if (error == nil) {
        // 토큰 해제 성공
        NSLog(@"Successfully unregistered token : %@", deviceToken);

    } else {
        // 토큰 해제 실패
        NSLog(@"Failed to unregister : %@", error.localizedDescription);
    }
}];
```

## 리치 메시지

* 리치 메시지는 알림의 제목, 본문과 함께 미디어(이미지, 비디오, 오디오)를 알림에 표현하고 버튼, 답장 등의 액션을 추가합니다.
* `리치 메시지 수신은 iOS 10.0+ 이상부터 지원합니다.`
* 리치 메시지 표현을 위해서는 사용자 애플리케이션에 NHNCloudPushServiceExtension를 상속 구현하는 Notification Service Extension을 구현해야 합니다. (Notification Service Extension 추가 방법은 아래 [Notification Service Extension](./push-ios/#notification-service-extension) 섹션 참고)

### 지원하는 리치 메시지

#### 버튼

| 유형 | 기능 | 액션 |
| --- | ------- | --- |
| 앱 열기 (OPEN_APP) | 애플리케이션 실행 | NHNCloudPushNotificationActionOpenApp |
| URL 열기 (OPEN_URL) | URL로 이동<br/>(웹 URL 주소 혹은 앱 커스텀 스킴 실행) | NHNCloudPushNotificationActionOpenURL |
| 답장 (REPLY) | 알림에서 답장 전송 | NHNCloudPushNotificationActionReply |
| 취소 (DISMISS) | 현재 알림 취소 | NHNCloudPushNotificationActionDismiss |

> 버튼은 메시지당 최대 3개까지 지원합니다.

#### 미디어

| 유형 | 지원 포멧 | 최대 크기 | 권장 사항 |
| --- | ------- | --- | --- |
| 이미지 | JPEG, PNG, GIF | 10 MB | 가로 이미지 권장<br>최대 크기 : 1038 x 1038 |
| 동영상 | MPEG, MPEG3Video, MPEG4, AVIMovie | 50 MB |  |
| 소리 | WaveAudio, MP3, MPEG4Audio | 5 MB |  |

> 웹 URL 사용시 미디어 파일 다운로드 시간이 소요됩니다.

## 지표 수집

* 클라이언트에서 Push 메시지 수신 및 사용자 알림 실행에 대한 지표를 수집하여 NHN Cloud 서버로 전송합니다.
* 수집된 내용은 통계 탭에서 확인할 수 있습니다.
* `지표 수집을 위해서는 Push SDK 초기화 혹은 info.plist 파일에 앱키가 정의되어 있어야 합니다.`

### 수신(Received) 지표 수집 설정

* `수신 지표 수집은 iOS 10.0+ 이상부터 지원합니다.`
* 수신 지표는 Notification Service Extension에 추가한 NHN Cloud Push SDK 에서 자동으로 수집됩니다.
* 수신 지표 수집을 위해서는 사용자 애플리케이션에 NHNCloudPushServiceExtension를 상속 구현하는 Notification Service Extension을 구현해야 합니다. (Notification Service Extension 추가 방법은 아래 [Notification Service Extension](./push-ios/#notification-service-extension) 섹션 참고)
* Notification Service Extension 생성자에서 [NHN Cloud Push SDK 초기화](./push-ios/#nhn-cloud-push-sdk) 혹은 **익스텐션의 info.plist 파일**에 앱키가 정의되어 있어야 수신 지표 수집이 가능합니다.

#### 초기화를 통한 수신 지표 수집 설정 예

* `애플리케이션과 익스텐션은 함께 설치되지만 서로 분리된 별도의 샌드박스 환경이기 때문에 애플리케이션에서의 초기화와는 별개로 익스텐션에서도 초기화를 해야합니다.`

``` objc
@implementation NotificationService

- (instancetype)init {
    self = [super init];

    if (self) {
        // 지표 전송에만 사용되므로 앱키만 설정하셔도 됩니다.
        NHNCloudPushConfiguration *configuration = [[NHNCloudPushConfiguration alloc] initWithAppKey:@"INPUT_YOUR_APPKEY"];

        [NHNCloudPush initWithConfiguration:configuration];
    }

    return self;
}

@end
```

#### info.plist 정의를 통한 수신 지표 수집 설정 예

* Property List

![plist_ext](https://static.toastoven.net/toastcloud/sdk/ios/push_plist_ext_202206.png)

* Source Code

``` xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">

<key>NHNCloudSDK</key>
<dict>
    <key>NHNCloudPush</key>
    <dict>
        <key>AppKey</key>
        <string>[INPUT_YOUR_APPKEY]</string>
    </dict>
</dict>
```

### 실행(Opened) 지표 수집 설정

* 실행 지표는 애플리케이션에 추가한 NHN Cloud Push SDK 에서 자동으로 수집됩니다.
* [NHN Cloud Push SDK 초기화](./push-ios/#nhn-cloud-push-sdk) 혹은 **애플리케이션의 info.plist 파일**에 앱키가 정의되어 있어야 실행 지표 수집이 가능합니다.

#### info.plist 정의를 통한 수신 지표 수집 설정 예

* Property List

![plist_app](https://static.toastoven.net/toastcloud/sdk/ios/push_plist_app_202206.png)

* Source Code

``` xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">

<key>NHNCloudSDK</key>
<dict>
    <key>NHNCloudPush</key>
    <dict>
        <key>AppKey</key>
        <string>[INPUT_YOUR_APPKEY]</string>
    </dict>
</dict>
```

## Notification Service Extension

* `iOS 10.0+ 부터 지원합니다.`
* 리치 메시지, 수신 지표 수집을 위해서는 애플리케이션에 NHNCloudPushServiceExtension를 상속 구현하는 Notification Service Extension을 반드시 구현해야 합니다.

### Notification Service Extension 생성

* **File New > Target > iOS > Notification Service Extension**
![create_ext](https://static.toastoven.net/toastcloud/sdk/ios/push_create_ext_202206.png)

### Notification Service Extension 설정

* 앱의 프로젝트 설정과 동일하게 Extension의 [프로젝트 설정](./push-ios/#프로젝트-설정)을 추가합니다.
* `iOS의 Extension은 앱과 함께 설치되지만 앱과는 분리된 별도의 샌드박스 환경이라 컨테이너를 공유하지 않습니다.`

### Notification Service Extension 설정 예

* 생성된 NotificationService 클래스에 NHNCloudPushServiceExtension 을 상속해야 합니다.
* 별도의 사용자 정의 처리 로직이 없는 경우 상속만으로도 리치 메시지와 수신 지표 수집 기능이 동작합니다.

``` objc
#import <UserNotifications/UserNotifications.h>
#import <NHNCloudPush/NHNCloudPush.h>

@interface NotificationService : NHNCloudPushServiceExtension

@end
```

## 사용자 태그

* [사용자 태그](https://docs.nhncloud.com/ko/Notification/Push/ko/console-guide/#_16) 기능은 여러 사용자 아이디를 하나의 태그로 묶고 이를 활용하여 메시지 발송이 가능합니다.
* 태그명이 아닌 태그 아이디(8자리 문자열)를 기반으로 동작하며, 태그 아이디는 콘솔 > 태그 메뉴에서 생성 및 확인 가능합니다.

### 사용자 태그 설정 API 명세

``` objc
// 사용자 아이디의 태그 아이디 목록 추가
+ (void)addUserTagWithIdentifiers:(NSSet<NSString *> *)tagIdentifiers
                completionHandler:(nullable void (^)(NSSet<NSString *> * _Nullable tagIdentifiers, NSError * _Nullable error))completionHandler;

// 사용자 아이디의 태그 아이디 목록 업데이트
+ (void)setUserTagWithIdentifiers:(nullable NSSet<NSString *> *)tagIdentifiers
                completionHandler:(nullable void (^)(NSError * _Nullable error))completionHandler;

// 사용자 아이디의 태그 아이디 목록 획득
+ (void)getUserTagWithCompletionHandler:(void (^)(NSSet<NSString *> * _Nullable tagIdentifiers, NSError * _Nullable error))completionHandler;

// 사용자 아이디의 태그 아이디 목록 삭제
+ (void)removeUserTagWithIdentifiers:(NSSet<NSString *> *)tagIdentifiers
                   completionHandler:(nullable void (^)(NSSet<NSString *> * _Nullable tagIdentifiers, NSError * _Nullable error))completionHandler;

// 사용자 아이디의 전체 태그 삭제
+ (void)removeAllUserTagWithCompletionHandler:(nullable void (^)(NSError * _Nullable error))completionHandler;
```

### 사용자 태그 수정

#### 사용자 태그 수정 예

* 입력 받은 태그 아이디 목록을 추가 혹은 업데이트하고 최종 반영된 태그 아이디 목록을 반환합니다.

``` objc
// 추가할 태그 아이디 목록 생성
NSMutableSet<NSString *> *tagIDs = [NSMutableSet set];
[tagIDs addObject:TAG_ID_1];    // e.g. "ZZPP00b6" (8자리 문자열)
[tagIDs addObject:TAG_ID_2];

// 로그인되어 있는 사용자 아이디의 태그 아이디 목록 추가
[NHNCloudPush addUserTagWithIdentifiers:tagIDs
                      completionHandler:^(NSSet<NSString *> *tagIdentifiers, NSError *error) {

    if (error == nil) {
        // 태그 아이디 목록 추가 성공
    } else {
        // 태그 아이디 목록 추가 실패
    }
}];

// 로그인되어 있는 사용자 아이디의 태그 아이디 목록 업데이트 (기존 태그 아이디 목록은 삭제되고 입력한 값으로 설정)
[NHNCloudPush setUserTagWithIdentifiers:tagIDs
                      completionHandler:^(NSError *error) {

    if (error == nil) {
        // 태그 아이디 목록 업데이트 성공
    } else {
        // 태그 아이디 목록 업데이트 실패
    }
}];
```

### 사용자 태그 획득

* 현재 사용자에 등록된 모든 태그 아이디 목록을 반환합니다.

#### 사용자 태그 획득 예

``` objc
// 로그인되어 있는 사용자 아이디의 전체 태그 아이디 목록을 반환
[NHNCloudPush getUserTagWithCompletionHandler:^(NSSet<NSString *> *tagIdentifiers, NSError *error) {
    if (error == nil) {
        // 태그 아이디 목록 획득 성공
    } else {
        // 태그 아이디 목록 획득 실패
    }
}];
```

### 사용자 태그 삭제

#### 사용자 태그 삭제 예

* 입력 받은 사용자 태그 아이디 목록을 삭제하고, 최종 반영된 태그 아이디 목록을 반환합니다.

``` objc
// 삭제할 태그 아이디 목록 생성
NSMutableSet<NSString *> *tagIDs = [NSMutableSet set];
[tagIDs addObject:TAG_ID_1];    // e.g. "ZZPP00b6" (8자리 문자열)
[tagIDs addObject:TAG_ID_2];

// 로그인되어 있는 사용자 아이디의 태그 아이디 목록 삭제
[NHNCloudPush removeUserTagWithIdentifiers:tagIDs
                         completionHandler:^(NSSet<NSString *> *tagIdentifiers, NSError *error) {
    if (error == nil) {
        // 태그 아이디 목록 삭제 성공
    } else {
        // 태그 아이디 목록 삭제 실패
    }
}];

// 로그인되어 있는 사용자 아이디의 전체 태그 아이디 목록 삭제
[NHNCloudPush removeAllUserTagWithCompletionHandler:^(NSError *error) {
    if (error == nil) {
        // 전체 사용자 태그 삭제 성공
    } else {
        // 전체 사용자 태그 삭제 실패
    }
}];
```

## VoIP

* `VoIP 기능은 iOS 10.0 이상부터 지원합니다.`

### 프레임워크 설정

* NHN Cloud Push의 VoIP 기능을 사용하려면 **PushKit.framework**, **CallKit.framework**를 추가해야 합니다.
* PushKit.framework, CallKit.framework는 아래 방법으로 추가할 수 있습니다.
![linked_pushkit_frameworks](https://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_PushKit_202206.png)
![linked_callkit_frameworks](https://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_CallKit_202206.png)
![linked_frameworks_push](https://static.toastoven.net/toastcloud/sdk/ios/push_link_frameworks_push_202206.png)

### Capabilities 설정

* **Project Target > Signing & Capabilities > + Capability > Background Modes**
![add_capability_background_modes](https://static.toastoven.net/toastcloud/sdk/ios/add_capability_background_modes_202206.png)

* **Voice over IP** 항목을 활성화해야 합니다.
![capabilities](https://static.toastoven.net/toastcloud/sdk/ios/push_capabilities_voip_202206.png)

### 초기화

* VoIP 기능은 [NHN Cloud Push SDK 초기화](./push-ios/#nhn-cloud-push-sdk)가 되어 있어야 사용 가능합니다.
* VoIP 기능은 NHN Cloud Push SDK의 서브모듈로 별도 분리되어 있습니다.

### Delegate 설정

* VoIP 메시지 수신 시 [NHNCloudPushMessage](./push-ios/#nhncloudpushmessage) 객체로 수신 받은 메시지의 내용이 전달됩니다.
* `원활한 메시지 수신을 위해 application:didFinishLaunchingWithOptions: 함수에서 Delegate 설정을 권장합니다.`

#### Delegate API 명세

``` objc
@protocol NHNCloudVoIPDelegate <NSObject>

// 메시지 수신
- (void)didReceiveIncomingVoiceCallWithMessage:(NHNCloudPushMessage *)message;

@end
```

#### Delegate 설정 예

``` objc
// VoIP 서브모듈을 추가합니다.
#import <NHNCloudPush/NHNCloudVoIP.h>

@interface AppDelegate () <UIApplicationDelegate, NHNCloudVoIPDelegate>

@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // ...

    // Delegate를 설정합니다.
    [NHNCloudVoIP setDelegate:self];

    return YES;
}

#pragma mark - NHNCloudVoIPDelegate
// 메시지 수신
- (void)didReceiveIncomingVoiceCallWithMessage:(NHNCloudPushMessage *)message {
    // ...
}
```

### 토큰 등록

* 발급 받은 VoIP 토큰 정보를 NHN Cloud 서버에 등록합니다.
* VoIP 기능은 별도의 사용자 권한 및 동의 정보가 필요없습니다.

#### 토큰 등록 API 명세

```objc
+ (void)registerWithCompletionHandler:(nullable void (^)(NHNCloudPushTokenInfo * _Nullable tokenInfo, NSError * _Nullable error))completionHandler;
```

#### 토큰 등록 예

```objc
[NHNCloudVoIP registerWithCompletionHandler:^(NHNCloudPushTokenInfo *tokenInfo, NSError *error) {
    if (error == nil) {
        // 토큰 등록 성공
        NSLog(@"Successfully registered : %@", tokenInfo.deviceToken);

    } else {
        // 토큰 등록 실패
        NSLog(@"Failed to register : %@", error.localizedDescription);
    }
}];
```

### 토큰 정보 조회

* 현재 단말기에서 마지막으로 등록에 성공한 토큰과 설정 정보를 조회합니다.
* 토큰 조회 정보 성공 시 [NHNCloudPushTokenInfo](./push-ios/#nhncloudpushtokeninfo) 객체로 토큰의 설정 정보가 반환됩니다.

#### 토큰 정보 조회 API 명세

```objc
@interface NHNCloudVoIP : NSObject
+ (void)queryTokenInfoWithCompletionHandler:(void (^)(NHNCloudPushTokenInfo * _Nullable tokenInfo, NSError * _Nullable error))completionHandler;
```

#### 토큰 정보 조회 예

```objc
[NHNCloudVoIP queryTokenInfoWithCompletionHandler:^(NHNCloudPushTokenInfo *tokenInfo, NSError *error) {
    if (error == nil) {
        // 토큰 정보 조회 성공
        NSLog(@"Successfully query token info : %@", [tokenInfo description]);

    } else {
        // 토큰 정보 조회 실패
        NSLog(@"Failed to query token info : %@", error.localizedDescription);
    }
}];
```

### 토큰 해제

* NHN Cloud 서버에 등록된 토큰을 해제합니다. 해제된 토큰은 메시지 발송 대상에서 제외됩니다.
* `서비스 로그아웃 후에 메시지 수신을 원치 않으시면 토큰을 해제해야 합니다.`

#### 토큰 해제 API 명세

```objc
+ (void)unregisterWithCompletionHandler:(nullable void (^)(NSString * _Nullable deviceToken, NSError * _Nullable error))completionHandler;
```

#### 토큰 헤제 예

```objc
[NHNCloudVoIP unregisterWithCompletionHandler:^(NSString *deviceToken, NSError *error) {
    if (error == nil) {
        // 토큰 해제 성공
        NSLog(@"Successfully unregistered token : %@", deviceToken);

    } else {
        // 토큰 해제 실패
        NSLog(@"Failed to unregister : %@", error.localizedDescription);
    }
}];
```

## 에러 코드

### Push 기능 에러 코드
```objc
extern NSErrorDomain const NHNCloudPushErrorDomain;

typedef NS_ERROR_ENUM(NHNCloudPushErrorDomain, NHNCloudPushError) {
    NHNCloudPushErrorUnknown = 0,              // 알 수 없음
    NHNCloudPushErrorNotInitialized = 1,       // 초기화하지 않음
    NHNCloudPushErrorUserInvalid = 2,          // 사용자 아이디 미설정
    NHNCloudPushErrorPermissionDenied = 3,     // 권한 획득 실패
    NHNCloudPushErrorSystemFailed = 4,         // 시스템에 의한 실패
    NHNCloudPushErrorTokenInvalid = 5,         // 토큰 값이 없거나 유효하지 않음
    NHNCloudPushErrorAlreadyInProgress = 6,    // 이미 진행 중
    NHNCloudPushErrorParameterInvalid = 7,     // 매개변수 오류
    NHNCloudPushErrorNotSupported = 8,         // 지원하지 않는 기능
    NHNCloudPushErrorClientFailed = 9,         // 서버 오류
};
```

### 네트워크 에러 코드
``` objc
extern NSErrorDomain const NHNCloudHttpErrorDomain;

typedef NS_ERROR_ENUM(NHNCloudHttpErrorDomain, NHNCloudHttpError) {
    NHNCloudHttpErrorNetworkNotAvailable = 100,        // 네트워크 사용 불가
    NHNCloudHttpErrorRequestFailed = 101,              // HTTP Status Code 가 200이 아니거나 서버에서 요청을 제대로 읽지 못함
    NHNCloudHttpErrorRequestTimeout = 102,             // 타임아웃
    NHNCloudHttpErrorRequestInvalid = 103,             // 잘못된 요청 (파라미터 오류 등)
    NHNCloudHttpErrorURLInvalid = 104,                 // URL 오류
    NHNCloudHttpErrorResponseInvalid = 105,            // 서버 응답 오류
    NHNCloudHttpErrorAlreadyInprogress = 106,          // 동일 요청 이미 수행 중
    NHNCloudHttpErrorRequiresSecureConnection = 107,   // Allow Arbitrary Loads 미설정
};
```

## NHN Cloud Push Class Reference

### NHNCloudPushConfiguration
* NHN Cloud Push를 초기화할 때 전달되는 Push 설정 정보입니다.

``` objc
@interface NHNCloudPushConfiguration : NSObject

// 서비스 앱키
@property (nonatomic, copy, readonly) NSString *appKey;

// 서비스 존
@property (nonatomic) NHNCloudServiceZone serviceZone;

// 국가 코드 (예약 메시지 발송시 기준 시간이 되는 국가코드)
@property (nonatomic, copy) NSString *countryCode;

// 언어 코드 (다국어 메시지 발송시 언어 선택 기준)
@property (nonatomic, copy) NSString *languageCode;

// 타임존
@property (nonatomic, copy) NSString *timezone;

// Sandbox(Debug) 환경 설정
@property (nonatomic) BOOL sandbox;

// 사용자가 알림 허용 권한을 거부해도 토큰을 등록할지 여부
@property (nonatomic) BOOL alwaysAllowTokenRegistration;


+ (instancetype)configurationWithAppKey:(NSString *)appKey;

- (instancetype)initWithAppKey:(NSString *)appKey;

@end
```

### NHNCloudNotificationOptions
* NHN Cloud Push를 초기화할 때 전달되는 알림 설정 정보입니다.

``` objc
@interface NHNCloudNotificationOptions : NSObject

// 앱 실행 중 알림 노출 여부
@property (nonatomic) BOOL foregroundEnabled;

// 배지 아이콘 사용 여부
@property (nonatomic) BOOL badgeEnabled;

// 알림음 사용 여부
@property (nonatomic) BOOL soundEnabled;

@end
```


### NHNCloudPushAgreement

``` objc
@interface NHNCloudPushAgreement : NSObject

// 알림 표시 동의 여부
@property (nonatomic, assign) BOOL allowNotifications;

// 광고성 알림 표시 동의 여부
@property (nonatomic, assign) BOOL allowAdvertisements;

// 야간 광고성 알림 동의 여부
@property (nonatomic, assign) BOOL allowNightAdvertisements;


+ (instancetype)agreementWithAllowNotifications:(BOOL)allowNotifications;

* (instancetype)initWithAllowNotifications:(BOOL)allowNotifications;

@end
```

### NHNCloudPushMessage
* 메시지 수신시 반환되는 객체입니다.

```objc
@interface NHNCloudPushMessage : NSObject

@property (nonatomic, readonly) NSString *identifier;

@property (nonatomic, readonly, nullable) NSString *title;

@property (nonatomic, readonly, nullable) NSString *body;

@property (nonatomic, readonly) NSInteger badge;

@property (nonatomic, readonly, nullable) NHNCloudPushRichMessage *richMessage;

@property (nonatomic, readonly) NSDictionary<NSString *, NSString *> *payload;

@end
```

### NHNCloudPushMessage
* 수신한 메시지 내용 중 리치메시지 내용을 담는 객체 입니다.

```objc
@interface NHNCloudPushRichMessage : NSObject

@property (nonatomic, readonly, nullable) NHNCloudPushMedia *media;

@property (nonatomic, readonly, nullable) NSArray<NHNCloudPushButton *> *buttons;

@end
```

### NHNCloudPushMedia
* 수신한 리치메시지 중 미디어 내용을 담는 객체 입니다.

```objc
@interface NHNCloudPushMedia : NSObject

@property (nonatomic, readonly) NHNCloudPushMediaType mediaType;

@property (nonatomic, readonly) NSString *source;

@end
```

### NHNCloudPushButton
* 수신한 리치메시지 내용 중 버튼 내용을 담는 객체 입니다.

```objc
@interface NHNCloudPushButton : NSObject

@property (nonatomic, readonly) NSString *identifier;

@property (nonatomic, readonly) NHNCloudPushButtonType buttonType;

@property (nonatomic, readonly) NSString *name;

@property (nonatomic, readonly, nullable) NSString *link;

@property (nonatomic, readonly, nullable) NSString *hint;

@property (nonatomic, readonly, nullable) NSString *submit;

@end
```

### NHNCloudPushNotificationAction
* 알림 액션(버튼, 답장) 수신시 반환되는 객체 입니다.

```objc
typedef NS_ENUM(NSInteger, NHNCloudPushNotificationActionType) {
    NHNCloudPushNotificationActionDismiss = 0,
    NHNCloudPushNotificationActionOpenURL = 2,
    NHNCloudPushNotificationActionOpenApp = 1,
    NHNCloudPushNotificationActionReply = 3,
};


@interface NHNCloudPushNotificationAction : NSObject <NSCoding, NSCopying>

@property (nonatomic, readonly) NSString *actionIdentifier;

@property (nonatomic, readonly) NSString *categoryIdentifier;

@property (nonatomic, readonly) NHNCloudPushNotificationActionType actionType;

@property (nonatomic, readonly) NHNCloudPushButton *button;

@property (nonatomic, readonly) NHNCloudPushMessage *message;

@property (nonatomic, readonly, nullable) NSString *userText;

@end
```

### NHNCloudPushTokenInfo
* 토큰 정보 조회 요청시 반환되는 토큰 정보 객체입니다.

``` objc
typedef NSString *NHNCloudPushType NS_STRING_ENUM;
// APNS 타입
extern NHNCloudPushType const NHNCloudPushTypeAPNS;
// VoIP 타입
extern NHNCloudPushType const NHNCloudPushTypeVoIP;


@interface NHNCloudPushTokenInfo : NSObject

// 사용자 아이디
@property (nonatomic, readonly) NSString *userID;

// 토큰
@property (nonatomic, readonly) NSString *deviceToken;

// 국가 코드
@property (nonatomic, readonly) NSString *countryCode;

// 언어 설정
@property (nonatomic, readonly) NSString *languageCode;

// Push 토큰 타입
@property (nonatomic, readonly) NHNCloudPushType pushType;

// 알림 표시 동의 여부
@property (nonatomic, readonly) BOOL allowNotifications;

// 광고성 알림 표시 동의 여부
@property (nonatomic, readonly) BOOL allowAdvertisements;

// 야간 광고성 알림 표시 동의 여부
@property (nonatomic, readonly) BOOL allowNightAdvertisements;

// 표준시간대
@property (nonatomic, readonly) NSString *timezone;

// 토큰 업데이트 시간
@property (nonatomic, readonly) NSString *updateDateTime;

// 샌드박스 환경에서 등록된 토큰인지 확인
@property (nonatomic, getter=isSandbox) BOOL sandbox;

@end
```