## TOAST > TOAST SDK 사용 가이드 > TOAST Push > iOS

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

## TOAST Push SDK를 Xcode 프로젝트에 적용

### 1. Cococapods 적용

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

### 2. 바이너리를 다운로드하여 TOAST SDK 적용

#### SDK 가져오기(import)

TOAST의 [Downloads](../../../Download/#toast-sdk) 페이지에서 전체 iOS SDK를 다운로드할 수 있습니다.

Xcode Project에 **ToastPush.framework**, **ToastCore.framework**, **ToastCommon.framework**, `UserNotifications.framework`를 추가합니다.

> UserNotifications.framework는 아래 방법으로 추가할 수 있습니다.

![linked_usernotifications_frameworks](http://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_UserNotifications.png)

TOAST Push의 VoIP 기능을 사용하려면 `PushKit.framework, CallKit.framework`를 추가해야 합니다.

> PushKit.framework, CallKit.framework는 아래 방법으로 추가할 수 있습니다.

![linked_pushkit_frameworks](http://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_PushKit.png)

![linked_callkit_frameworks](http://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_CallKit.png)

![linked_frameworks_push](http://static.toastoven.net/toastcloud/sdk/ios/push_link_frameworks_push.png)

#### Project Settings

**Build Settings**의 **Other Linker Flags**에 **-lc++**와 **-ObjC** 항목을 추가합니다.

**Project Target > Build Settings > Linking > Other Linker Flags**를 클릭해 추가할 수 있습니다.

![other_linker_flags](http://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags.png)

#### 프레임워크 가져오기

사용하려는 프레임워크를 가져옵니다(import).

```objc
#import <ToastCore/ToastCore.h>
#import <ToastPush/ToastPush.h>
```

## Capabilities Setting

TOAST Push를 사용하려면 Capabilities에서 **Push Notification**, **Background Modes** 항목을 활성화해야 합니다.

**Project Target > Capabilities > Push Notification > ON**

![capabilities_push_notification](http://static.toastoven.net/toastcloud/sdk/ios/capability_push_notification.png)

**Project Target > Capabilities > Background Modes > ON**

APNS 기능을 사용하려면 `Remote notifications` 항목을 활성화해야 합니다.
VoIP 기능을 사용하려면 `Voice over IP` 항목을 활성화해야 합니다.

![capabilities_background_modes](http://static.toastoven.net/toastcloud/sdk/ios/capability_background_modes.png)

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
`Delegate 설정이 된 후 메시지 수신에 대한 통지를 받을 수 있습니다.`
`원활한 메시지 수신을 위해 application:didFinishLaunchingWithOptions: 함수에서 Delegate 설정을 권장합니다.`
`개발환경에서는 반드시 ToastPushConfiguration 의 sandbox 프로퍼티를 YES로 설정해야 개발용 인증서로 발송한 메시지의 수신이 가능합니다.`

### 초기화 API 명세

``` objc

@interface ToastPush : NSObject

// 초기화 및 Delegate 설정
+ (void)initWithConfiguration:(ToastPushConfiguration *)configuration
                     delegate:(nullable id<ToastPushDelegate>)delegate;

// Delegate 설정
+ (void)setDelegate:(nullable id<ToastPushDelegate>)delegate;

// 초기화
+ (void)initWithConfiguration:(ToastPushConfiguration *)configuration;

// 카테고리 설정
+ (void)setCategories:(nullable NSSet<UNNotificationCategory *> *)categories;

// 알림 옵션 설정
// iOS 8.0+ : UIUserNotificationType
// iOS 10.0+ : UNAuthorizationOptions
// default : UNAuthorizationOptionSound | UNAuthorizationOptionBadge
+ (void)setOptions:(NSInteger)options;

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
@property (nonatomic, copy) NSSet<ToastPushType> *pushTypes;

// 국가 코드 (예약 메시지 발송시 기준 시간이 되는 국가코드)
@property (nonatomic, copy) NSString *countryCode;

// 언어 코드 (다국어 메시지 발송시 언어 선택 기준)
@property (nonatomic, copy) NSString *languageCode;

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

토큰 등록, 토큰 해제, 푸시 수신, 알림 액션 수신 이후 추가적인 기능을 제공하려면 Delegate를 등록해야합니다.

``` objc
@protocol ToastPushDelegate <NSObject>

@optional

// 토큰 등록 성공
- (void)didRegisterWithDeviceToken:(NSString *)deviceToken
                           forType:(ToastPushType)type;

// 토큰 등록 실패
- (void)didFailToRegisterForType:(ToastPushType)type
                       withError:(NSError *)error;

// 토큰 해제 성공
- (void)didUnregisterWithDeviceToken:(nullable NSString *)deviceToken
                             forType:(ToastPushType)type;

// 토큰 해제 실패
- (void)didFailToUnregisterWithDeviceToken:(NSString *)deviceToken
                                   forType:(ToastPushType)type
                                     error:(NSError *)error;

// 메시지 수신
- (void)didReceivePushMessage:(ToastPushMessage *)message
                      forType:(ToastPushType)type;

// 액션 수신 (APNS, iOS 10.0+)
- (void)didReceivePushAction:(ToastPushAction *)action API_AVAILABLE(ios(10.0));

@end
```

#### 메시지 객체 API 명세

```objc
// 메시지 객체
@interface ToastPushMessage : NSObject

@property (nonatomic, readonly) NSString *identifier;

@property (nonatomic, readonly, nullable) NSString *title;

@property (nonatomic, readonly, nullable) NSString *body;

@property (nonatomic, readonly) NSInteger badge;

@property (nonatomic, readonly, nullable) ToastPushRichMessage *richMessage;

@property (nonatomic, readonly) NSDictionary<NSString *, NSString *> *payload;

@end


// 리치 메시지 객체
@interface ToastPushRichMessage : NSObject

@property (nonatomic, readonly, nullable) ToastPushMedia *media;

@property (nonatomic, readonly, nullable) NSArray<ToastPushButton *> *buttons;

@end


// 미디어 객체
@interface ToastPushMedia : NSObject

@property (nonatomic, readonly) ToastPushMediaType mediaType;

@property (nonatomic, readonly) NSString *source;

@end


// 버튼 객체
@interface ToastPushButton : NSObject

@property (nonatomic, readonly) NSString *identifier;

@property (nonatomic, readonly) ToastPushButtonType buttonType;

@property (nonatomic, readonly) NSString *name;

@property (nonatomic, readonly, nullable) NSString *link;

@property (nonatomic, readonly, nullable) NSString *hint;

@property (nonatomic, readonly, nullable) NSString *submit;

@end
```

#### 액션 객체 API 명세

```objc
typedef NS_ENUM(NSInteger, ToastPushActionType) {
    ToastPushActionDismiss = 0,
    ToastPushActionOpenApp = 1,
    ToastPushActionOpenURL = 2,
    ToastPushActionReply = 3,
};

@interface ToastPushAction : NSObject

@property (nonatomic, readonly) NSString *actionIdentifier;

@property (nonatomic, readonly) NSString *categoryIdentifier;

@property (nonatomic, readonly) ToastPushActionType actionType;

@property (nonatomic, readonly, nullable) ToastPushButton *button;

@property (nonatomic, readonly, nullable) ToastPushMessage *message;

@property (nonatomic, readonly, nullable) NSString *userText;

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
    // 개발환경(Debug) 에서는 꼭 아래 sandbox 프로퍼티를 YES로 설정해야 개발용 인증서로 발송한 메시지의 수신이 가능합니다.
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

// 토큰 해제 성공
- (void)didUnregisterWithDeviceToken:(nullable NSString *)deviceToken
                             forType:(ToastPushType)type {
    // ...
}

// 토큰 해제 실패
- (void)didFailToUnregisterWithDeviceToken:(NSString *)deviceToken
                                   forType:(ToastPushType)type
                                     error:(NSError *)error {
    // ...
}

// 메시지 수신
- (void)didReceivePushMessage:(ToastPushMessage *)message
                      forType:(ToastPushType)type {
    // ...
}

// 알림 액션(버튼) 수신 (iOS 10.0+)
- (void)didReceivePushAction:(ToastPushAction *)action {
    // ...
}
```

### 알림 옵션 설정

알림 옵션은 아래와 같이 가본 설정되어 있습니다.
`앱 실행 중 알림을 표시하기 위해서는 옵션을 변경해야 합니다.`

```objc
UNAuthorizationOptionBadge | UNAuthorizationOptionSound
```

### 알림 옵션 설정 예

``` objc
// default : UNAuthorizationOptionBadge | UNAuthorizationOptionSound
// 사용자가 앱을 실행 중일 때도 알림이 노출되려면 옵션을 설정을 변경해주세요.
if (@available(iOS 10.0, *)) {
    [ToastPush setOptions:UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert];

} else {
    [ToastPush setOptions:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert];
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
ToastPushAgreement *agreement = [[ToastPushAgreement alloc] initWithAllowNotifications:YES];

// 광고성 메시지 수신 동의 여부 설정
agreement.allowAdvertisements = YES;
// 야간 광고성 메시지 수신 동의 여부 설정
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

## 토큰 해제

초기화시에 설정된 정보(푸쉬 타입, 샌드박스 유무)를 토대로 등록된 토큰을 해제합니다.
`서비스 로그아웃 후에 메시지 수신을 원치 않으시면 토큰을 해제해 주세요.`
만약 설정된 정보에 해당하는 토큰이 존재하지 않거나 해제에 성공한다면 해제 성공 Delegate를 호출합니다.
토큰 해제 결과는 초기화시에 설정된 Delegate를 통해 전달됩니다.

### 토큰 해제 API 명세

``` objc

@interface ToastPush : NSObject

// ...

// 토큰 해제
+ (void)unregisterToken;

// ...

@end

```

### 토큰 해제 예

``` objc

// ...

[ToastPush unregisterToken];

// ...

- (void)didUnregisterWithDeviceToken:(NSString *)deviceToken
                             forType:(ToastPushType)type {

    NSLog(@"Success to unregister token : %@", deviceToken);
}

- (void)didFailToUnregisterWithDeviceToken:(NSString *)deviceToken
                                   forType:(ToastPushType)type
                                     error:(NSError *)error {

    NSLog(@"Failed to unregister token, error : %@", error);
}

```

## 토큰 정보 업데이트

사용자 아이디, 국가코드, 언어코드, 메시지 동의 설정 등의 토큰 정보를 업데이트합니다.
등록되어있는 모든 토큰에 일괄 적용됩니다.
`토큰 정보 업데이트 요청은 앱 실행 후 토큰 등록이 된 상태에서만 가능합니다.`

### 토큰 정보 업데이트 API 명세

``` objc
@interface ToastPush : NSObject

// ...

// 토큰 정보 업데이트
+ (void)updateTokenInfo:(ToastPushTokenInfo *)tokenInfo
      completionHandler:(nullable void (^) (NSArray<ToastPushTokenInfo *> * _Nullable results, NSError * _Nullable error))completionHandler;

// ...

@end

```

### 토큰 정보 업데이트 예

``` objc

ToastPushMutableTokenInfo *tokenInfo = [[ToastPushMutableTokenInfo alloc] init];
// 업데이트하고자하는 항목만 설정
tokenInfo.languageCode = languageCode;
tokenInfo.agreement = agreement;

[ToastPush updateTokenInfo:tokenInfo
            completionHandler:^(NSArray<ToastPushTokenInfo *> *results, NSError *error) {
                if (error == nil) {
                    for (ToastPushTokenInfo *tokenInfo in results) {
                        // ...
                    }
                }
            }];

```

## 리치 메시지 수신

`리치 메시지 수신은 iOS 10.0+ 이상부터 지원합니다.`
알림 메시지에 미디어(이미지, 비디오, 오디오)와 버튼을 표현하기 위해서는 어플리케이션에 [Notification Service Extension](./push-ios/#notification-service-extension) 타겟이 추가되어 있어야만 합니다.

### 리치 메시지 수신 설정 예

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
수신 지표 수집을 위해서는 어플리케이션에 [Notification Service Extension](./push-ios/#notification-service-extension) 타겟이 추가되어 있어야만 합니다.
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
리치 메시지 수신, 수신 지표 수집을 위해서는 어플리케이션에 NotificationServiceExtension을 반드시 생성 및 설정해야만 합니다.

### Notification Service Extension 생성

**File New > Target > iOS > Notification Service Extension**

![create_ext](http://static.toastoven.net/toastcloud/sdk/ios/push_create_ext.png)

### Notification Service Extension 설정

앱의 프로젝트 설정과 동일하게 Extension의 [프로젝트 설정](http://docs.toast.com/ko/TOAST/ko/toast-sdk/push-ios/#toast-push-sdk-xcode)을 추가합니다.
`Extension은 앱과 함께 설치되지만 앱과는 분리된 별도의 Sandbox 환경입니다.`

NotificationService 클래스에 ToastPushServiceExtension 을 확장구현 해야 합니다.

``` objc
#import <UserNotifications/UserNotifications.h>
#import <ToastPush/ToastPush.h>

@interface NotificationService : ToastPushServiceExtension

@end
```

### 에러 코드
```objc
// Push 기능 관련 에러 코드
static NSString *const ToastPushErrorDomain = @"com.toast.push";

typedef NS_ENUM(NSUInteger, ToastPushErrorCode) {
    ToastPushErrorUnknown               = 0,    // 알수 없음
    ToastPushErrorNotInitialize         = 1,    // 초기화하지 않음
    ToastPushErrorUserInvalid           = 2,    // 사용자 아이디 미설정
    ToastPushErrorPermissionDenied      = 3,    // 권한 획득 실패
    ToastPushErrorSystemFailed          = 4,    // 시스템에 의한 실패
    ToastPushErrorTokenInvalid          = 5,    // 토큰 값이 없거나 유효하지 않음
    ToastPushErrorAlreadyInProgress     = 6,    // 이미 진행중
    ToastPushErrorParameterInvalid      = 7,    // 매계변수 오류
};

// 네트워크 관련 에러 코드
static NSString *const ToastHttpErrorDomain = @"com.toast.http";

typedef NS_ENUM(NSUInteger, ToastHttpErrorCode) {
    ToastHttpErrorNetworkNotAvailable = 100,        // 네트워크 사용 불가
    ToastHttpErrorRequestFailed = 101,              // HTTP Status Code 가 200이 아니거나 서버에서 요청을 제대로 읽지 못함
    ToastHttpErrorRequestTimeout = 102,             // 타임아웃
    ToastHttpErrorRequestInvalid = 103,             // 잘못된 요청 (파라미터 오류 등)
    ToastHttpErrorURLInvalid = 104,                 // URL 오류
    ToastHttpErrorResponseInvalid = 105,            // 서버 응답 오류
    ToastHttpErrorAlreadyInprogress = 106,          // 동일 요청 이미 수행중
    ToastHttpErrorRequiresSecureConnection = 107,   // Allow Arbitrary Loads 미설정
};
```