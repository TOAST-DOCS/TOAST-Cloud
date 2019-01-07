## TOAST > User Guide for TOAST SDK > TOAST Push > iOS

## Prerequisites

1\. [TOAST SDK](./getting-started-ios)를 설치합니다.
2\. [TOAST 콘솔](https://console.cloud.toast.com)에서 [Notification \> Push를 활성화](http://docs.toast.com/ko/Notification/Push/ko/console-guide/)합니다.
3\. Push에서 AppKey를 확인합니다.

## APNS 가이드
[APNS 가이드](https://developer.apple.com/library/archive/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/APNSOverview.html)

## TOAST Push 구성

iOS용 TOAST Push SDK의 구성은 다음과 같습니다.

| Service  | Cocoapods Pod Name | Framework | Dependency | Build Settings |
| --- | --- | --- | --- | --- | 
| TOAST Push | ToastPush | ToastPush.framework | * UserNotifications.framework<br/><br/>[Optional]<br/> * PushKit.framework | |
| Mandatory   | ToastCore<br/>ToastCommon | ToastCore.framework<br/>ToastCommon.framework | | OTHER_LDFLAGS = (<br/>    "-ObjC",<br/>    "-lc++" <br/>); |

## TOAST IAP SDK를 Xcode 프로젝트에 적용

### Cococapods 적용

Podfile을 생성하여 TOAST SDK에 대한 Pod을 추가합니다.

``` podspec
platform :ios, '8.0'
use_frameworks!

target '{YOUR PROJECT TARGET NAME}' do
    pod 'ToastPush'
end
```

생성된 Workspace를 열어 사용하려는 SDK를 가져옵니다(import).

``` objc
#import <ToastCore/ToastCore.h>
#import <ToastPush/ToastPush.h>
```

### 바이너리를 다운로드하여 TOAST SDK 적용 

#### SDK 가져오기(import)

TOAST의 [Downloads](../../../Download/#toast-sdk) 페이지에서 전체 iOS SDK를 다운로드할 수 있습니다.

Xcode Project에 **ToastPush.framework**, **ToastCore.framework**, **ToastCommon.framework**, `UserNotifications.framework`를 추가합니다.

> UserNotifications.framework는 아래 방법으로 추가할 수 있습니다.

TOAST Push의 VoIP 기능을 사용하려면 `PushKit.framework`를 추가해야 합니다.

![linked_usernotifications_frameworks](http://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_UserNotifications.png)

> PushKit.framework는 아래 방법으로 추가할 수 있습니다.

![linked_pushkit_frameworks](http://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_PushKit.png)

![linked_frameworks_push](http://static.toastoven.net/toastcloud/sdk/ios/push_link_frameworks_push.png)

#### Project Settings

**Build Settings**의 **Other Linker Flags**에 **-lc++**와 **-ObjC** 항목을 추가합니다.

**Project Target > Build Settings > Linking > Other Linker Flags**를 클릭해 추가할 수 있습니다.

![other_linker_flags](http://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags.png)

#### 프레임워크 가져오기 

사용하려는 프레임워크를 가져옵니다(import).

```objc
#import <ToastCore/ToastCore.h>
#import <ToastIAP/ToastIAP.h>
```

## 서비스 로그인

* TOAST SDK에서 제공하는 모든 상품(Push, IAP, Log & Crash등)은 같은 사용자 ID 하나만 사용합니다.

### 로그인

`사용자 ID가 설정되지 않은 상태에서는 토큰 등록 및 조회 기능을 사용할 수 없습니다.`

``` objc
// 서비스 로그인 완료 후 사용자 ID 설정
[ToastSDK setUserID:@"INPUT_USER_ID"];
```

### 로그아웃

`로그아웃 하여도 등록된 알림은 해제되지 않습니다.`

``` objc
// 서비스 로그아웃 완료 후 사용자 ID를 nil로 설정
[ToastSDK setUserID:nil];
```

## TOAST Push SDK 초기화

Push에서 발급받은 AppKey를 설정합니다.
`초기화를 하지 않은 상태에서는 토큰 등록 및 조회 기능을 사용할 수 없습니다.`
`원활한 메세지 수신을 위해 application:didFinishLaunchingWithOptions: 함수에서 초기화 수행하시기를 권장합니다.`

### 초기화 API 명세

``` objc

@interface ToastPush : NSObject

// ...

// 초기화 및 Delegate 설정
+ (void)initWithConfiguration:(ToastPushConfiguration *)configuration
                     delegate:(nullable id<ToastPushDelegate>)delegate;

// 카테고리 설정 (iOS 10.0+)
+ (void)setCategories:(nullable NSSet<UNNotificationCategory *> *)categories NS_AVAILABLE_IOS(10_0);

// ...

@end
```

### Configuration API 명세

``` objc
@interface ToastPushConfiguration : NSObject

// 서비스 앱키
@property (nonatomic, copy, readonly) NSString *appKey;

// 서비스 존
@property (nonatomic) ToastServiceZone serviceZone;

// 푸시 타입(APNS, VoIP)
@property (nonatomic) NSSet<ToastPushType> *pushTypes;

// Sandbox(Debug) 환경 설정
@property (nonatomic) BOOL sandbox;


// 앱키만 설정하여 생성
- (instancetype)initWithAppKey:(NSString *)appKey;

// 앱키, 푸시타입을 설정하여 생성
- (instancetype)initWithAppKey:(NSString *)appKey
                     pushTypes:(NSSet<ToastPushType> *)pushTypes;

@end
```

### Delegate API 명세

Delegate를 등록하면 토큰 등록 후 혹은 메세지 / 액션 수신 후 추가 작업을 진행할 수 있습니다.

``` objc
@protocol ToastPushDelegate <NSObject>

@optional

// 토큰 등록 성공
- (void)didRegisterWithDeviceToken:(NSString *)deviceToken
                           forType:(ToastPushType)type;

// 토큰 등록 실패
- (void)didFailToRegisterForType:(ToastPushType)type
                       withError:(NSError *)error;

// 푸시 수신
- (void)didReceivePushWithPayload:(NSDictionary *)payload
                          forType:(ToastPushType)type;

// 알림 액션 수신 (APNS)
- (void)didReceiveNotificationActionWithIdentifier:(NSString *)actionIdentifier
                                categoryIdentifier:(NSString *)categoryIdentifier
                                           payload:(NSDictionary *)payload
                                          userText:(nullable NSString *)userText;

@end
```

### 초기화 과정 예

``` objc
#import <ToastPush/ToastPush.h>

@interface AppDelegate () <UIApplicationDelegate, ToastPushDelegate>

@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // 앱키만 설정할 경우 pushTypes 는 기본으로 APNS 만 설정됩니다.
    ToastPushConfiguration *configuration = [[ToastPushConfiguration alloc] initWithAppKey:@"INPUT_YOUR_APPKEY"];

    // VoIP 사용 혹은 APNS 와 함께 사용할 경우 아래와 같이 NSSet 으로 설정합니다.
    configuration.pushTypes = [NSSet setWithObjects:ToastPushTypeAPNS, ToastPushTypeVoIP, nil];

#if DEBUG
    // 개발환경(Debug) 에서는 꼭 아래 sandbox 프로퍼티를 YES로 설정해야 합니다.
    configuration.sandbox = YES;
#endif

    // delegate 를 함께 설정 합니다.
    [ToastPush initWithConfiguration:configuration delegate:self];

    return YES;
}

#pragma mark - ToastPushDelegates
// 토큰 등록 성공
- (void)didRegisterWithDeviceToken:(NSString *)deviceToken
                           forType:(ToastPushType)type {
    // ...
}

// 토큰 등록 실패
- (void)didFailToRegisterForType:(ToastPushType)type
                       withError:(NSError *)error {
    // ...
}

// 메세지 수신
- (void)didReceivePushWithPayload:(NSDictionary *)payload
                          forType:(ToastPushType)type {
    // ...
}

// 알림 액션(버튼) 수신 (iOS 10.0+)
- (void)didReceiveNotificationActionWithIdentifier:(NSString *)actionIdentifier
                                categoryIdentifier:(NSString *)categoryIdentifier
                                           payload:(NSDictionary *)payload
                                          userText:(nullable NSString *)userText NS_AVAILABLE_IOS(10_0) {
    // ...
}
```

## 토큰 등록

초기화시에 설정된 푸시 타입별로 OS 에 등록하고, 발급 받은 토큰 정보를 토스트 클라우드 서버에 등록합니다.
토큰 등록 결과는 초기화시에 설정된 Delegate를 통해 전달됩니다.

### 토큰 등록 API 명세

``` objc
@interface ToastPush : NSObject

// ...

// 토큰 등록
+ (void)registerWithAgreement:(ToastPushAgreement *)agreement;

// ...

@end
```

### Agreement API 명세

``` objc
@interface ToastPushAgreement : NSObject

// 알림 표시 동의 여부
@property (nonatomic, assign) BOOL allowNotifications;

// 광고성 알림 표시 동의 여부
@property (nonatomic, assign) BOOL allowAdvertisements;

// 야간 광고성 알림 동의 여부
@property (nonatomic, assign) BOOL allowNightAdvertisements;

// 초기화
- (instancetype)init;

- (instancetype)initWithAllowNotifications:(BOOL)allowNotifications;

@end
```

### 토큰 등록 예

``` objc
ToastPushAgreement *agreement = [[ToastPushAgreement alloc] init];
agreement.allowNotifications = YES;
agreement.allowAdvertisements = YES;
agreement.allowNightAdvertisements = NO;

[ToastPush registerWithAgreement:agreement];
```

## 토큰 조회

현재 사용자 아이디로 등록된 가장 최근 토큰과 설정정보를 조회 합니다.

### 토큰 조회 API 명세

``` objc
@interface ToastPush : NSObject

// ...

// 토큰 조회
+ (void)requestTokenInfoForPushType:(ToastPushType)type
                  completionHandler:(nullable void (^) (ToastPushTokenInfo * _Nullable tokenInfo, NSError * _Nullable error))completionHandler;

// ...

@end
```

### 토큰 정보 API 명세

``` objc
@interface ToastPushTokenInfo : NSObject

// 사용자 아이디
@property (nonatomic, readonly) NSString *userID;

// 토큰
@property (nonatomic, readonly) NSString *deviceToken;

// 국가 코드
@property (nonatomic, readonly) NSString *countryCode;

// 언어 설정
@property (nonatomic, readonly) NSString *languageCode;

// 푸시 타입
@property (nonatomic, readonly) NSString *pushType;

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

@end
```

### 토큰 조회 예

``` objc
+ (void)requestTokenInfoForPushType:(ToastPushType)type
                  completionHandler:(void (^) (ToastPushTokenInfo *tokenInfo, NSError *error))completionHandler {
                                      if (error == nil) {
                                          NSLog(@"Success : %@", tokenInfo);

                                      } else {
                                          NSLog(@"Fail : %@", error);
                                      }
                                  }];
```

## 리치 메세지 수신

`리치 메세지 수신은 iOS 10.0+ 이상부터 지원합니다.`
알림 메세지에 미디어(이미지, 비디오, 오디오)와 버튼을 표현하기 위해서는 어플리케이션에 [Notification Service Extension](./push-ios/#notification-service-extension) 이 추가되어 있어야만 합니다.

### 리치 메세지 수신 설정 예

`NotificationService 클래스에 ToastPushServiceExtension 을 확장구현 해야 합니다.`

``` objc
#import <UserNotifications/UserNotifications.h>
#import <ToastPush/ToastPush.h>

@interface NotificationService : ToastPushServiceExtension

@end
```

## 지표 수집

클라이언트에서 푸시 메시지 수신 및 알림에 의한 애플리케이션 실행 여부가 서버에 전송됩니다.
이 내용은 통계 탭에서 확인할 수 있습니다.

### 수신(Received) 지표 수집 설정

`수신 지표 수집은 iOS 10.0+ 이상부터 지원합니다.`
수신 지표 수집을 위해서는 어플리케이션에 [Notification Service Extension](./push-ios/#notification-service-extension) 이 추가되어 있어야만 합니다.
Toast Push SDK 초기화 혹은 `NotificationServiceExtension의 info.plist 파일` 내부에 앱키를 설정하셔야만 지표 전송이 가능합니다.

#### Toast Push SDK 초기화를 통한 수신 지표 수집 설정 예

``` objc
@implementation NotificationService

- (instancetype)init {
    self = [super init];

    if (self) {
        // 지표 전송에만 사용되므로 앱키만 설정하셔도 됩니다.
        ToastPushConfiguration *configuration = [[ToastPushConfiguration alloc] initWithAppKey:@"INPUT_YOUR_APPKEY"];

        [ToastPush initWithConfiguration:configuration delegate:nil];
    }

    return self;
}

@end
```

#### info.plist 설정을 통한 수신 지표 수집 설정 예

* Property List

![plist_ext](http://static.toastoven.net/toastcloud/sdk/ios/push_plist_ext.png)

* Source Code

``` xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">

<key>ToastSDK</key>
<dict>
    <key>ToastPush</key>
    <dict>
        <key>AppKey</key>
        <string>[INPUT_YOUR_APPKEY]</string>
    </dict>
</dict>
```

### 실행(Opened) 지표 수집 설정

실행 지표의 수집과 전송은 SDK 내부에서 자동으로 진행됩니다.
[Toast Push SDK 초기화](./push-ios/#toast-push-sdk) 혹은 `Application의 info.plist 파일` 내부에 앱키를 설정하셔야만 지표 전송이 가능합니다.

#### info.plist 설정을 통한 수신 지표 수집 설정 예

* Property List

![plist_app](http://static.toastoven.net/toastcloud/sdk/ios/push_plist_app.png)

* Source Code

``` xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">

<key>ToastSDK</key>
<dict>
    <key>ToastPush</key>
    <dict>
        <key>AppKey</key>
        <string>[INPUT_YOUR_APPKEY]</string>
    </dict>
</dict>
```

## Notification Service Extension

`iOS 10.0+ 부터 지원합니다.`
리치 메세지 수신, 수신 지표 수집을 위해서는 어플리케이션에 NotificationServiceExtension을 반드시 생성 및 설정해야만 합니다.

### Notification Service Extension 생성

**File New > Target > iOS > Notification Service Extension**

![create_ext](http://static.toastoven.net/toastcloud/sdk/ios/push_create_ext.png)

### Notification Service Extension 설정

NotificationService 클래스에 ToastPushServiceExtension 을 확장구현 해야 합니다.

``` objc
#import <UserNotifications/UserNotifications.h>
#import <ToastPush/ToastPush.h>

@interface NotificationService : ToastPushServiceExtension

@end
```

### 에러 코드
```objc
typedef NS_ENUM(NSUInteger, ToastPushErrorCode) {
    ToastPushErrorUnknown               = 0,    // 알수 없음
    ToastPushErrorNotInitialize         = 1,    // 초기화하지 않음
    ToastPushErrorUserInvalid           = 2,    // 사용자 아이디 미설정
    ToastPushErrorPermissionDenied      = 3,    // 권한 획득 실패
    ToastPushErrorSystemFailed          = 4,    // 시스템 에러
    ToastPushErrorTokenInvalid          = 5,    // 토큰 값이 없거나 유효하지 않음
    ToastPushErrorAlreadyInProgress     = 6,    // 요청이 이미 진행중
    
    ToastPushErrorNetworkNotAvailable   = 100,  // 네트워크 사용 불가
    ToastPushErrorNetworkFailed         = 101,  // HTTP Status Code 가 200이 아님
    ToastPushErrorTimeout               = 102,  // 타임아웃
    ToastPushErrorParameterInvalid      = 103,  // 요청 파라미터 오류
    ToastPushErrorResponseInvalid       = 104,  // 서버 응답 오류
};
```