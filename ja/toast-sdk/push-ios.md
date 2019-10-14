## TOAST > TOAST SDK使用ガイド > TOAST Push > iOS

## Prerequisites

1\. [TOAST SDK](./getting-started-ios)をインストールします。
2\. [TOASTコンソール](https://console.cloud.toast.com)で、[Notification \> Pushを有効化](http://docs.toast.com/ko/Notification/Push/ko/console-guide/)します。
3\. PushでAppKeyを確認します。

## APNSガイド
[APNSガイド](https://developer.apple.com/library/archive/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/APNSOverview.html)

## TOAST Pushの構成

iOS用TOAST Push SDKの構成は次のとおりです。

| Service  | Cocoapods Pod Name | Framework | Dependency | Build Settings |
| --- | --- | --- | --- | --- |
| TOAST Push | ToastPush | ToastPush.framework | UserNotifications.framework<br/><br/>[Optional]<br/>PushKit.framework<br/>CallKit.framework | |
| Mandatory   | ToastCore<br/>ToastCommon | ToastCore.framework<br/>ToastCommon.framework | | OTHER_LDFLAGS = (<br/>    "-ObjC",<br/>    "-lc++" <br/>); |

## TOAST Push SDKをXcodeプロジェクトに適用

### 1. Cococapodsの適用

Podfileを作成して、TOAST SDKに対するPodを追加します。

``` podspec
platform :ios, '8.0'
use_frameworks!

target '{YOUR PROJECT TARGET NAME}' do
    pod 'ToastPush'
end
```

作成されたWorkspaceを開き、使用するSDKをインポートします(import)。

``` objc
#import <ToastCore/ToastCore.h>
#import <ToastPush/ToastPush.h>
```

### 2. バイナリをダウンロードして、TOAST SDKを適用

#### SDKのインポート(import)

TOASTの[Downloads](../../../Download/#toast-sdk)ページで、全体iOS SDKをダウンロードできます。

Xcode Projectに**ToastPush.framework**、**ToastCore.framework**、**ToastCommon.framework**、`UserNotifications.framework`を追加します。

> UserNotifications.frameworkは、下記の方法で追加できます。

![linked_usernotifications_frameworks](http://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_UserNotifications.png)

TOAST PushのVoIP機能を使用するには、`PushKit.framework, CallKit.framework`を追加する必要があります。

> PushKit.framework, CallKit.frameworkは、下記の方法で追加できます。

![linked_pushkit_frameworks](http://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_PushKit.png)

![linked_callkit_frameworks](http://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_CallKit.png)

![linked_frameworks_push](http://static.toastoven.net/toastcloud/sdk/ios/push_link_frameworks_push.png)

#### Project Settings

**Build Settings**の**Other Linker Flags**に、**-lc++**と**-ObjC**項目を追加します。

**Project Target > Build Settings > Linking > Other Linker Flags**をクリックして追加できます。

![other_linker_flags](http://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags.png)

#### フレームワークのインポート

使用するフレームワークをインポートします(import)。

```objc
#import <ToastCore/ToastCore.h>
#import <ToastPush/ToastPush.h>
```

## Capabilities Setting

TOAST Pushを使用するには、Capabilitiesで**Push Notification**、**Background Modes**項目を有効にする必要があります。

**Project Target > Capabilities > Push Notification > ON**

![capabilities_push_notification](http://static.toastoven.net/toastcloud/sdk/ios/capability_push_notification.png)

**Project Target > Capabilities > Background Modes > ON**

APNS 機能を使用するには,`Remote notifications`項目を活性化する必要があります。
VoIP機能を使用するには,`Voice over IP`項目を活性化する必要があります。

![capabilities_background_modes](http://static.toastoven.net/toastcloud/sdk/ios/capability_background_modes.png)

## Xcode11 변경 사항
Xcode11부터 TOAST SDK 0.18.0 미만 버전을 사용하는 프로젝트는 iOS13에서 토큰 등록에 실패하는 문제가 발생합니다.
`Xcode11 이상을 사용할 경우 TOAST SDK 0.18.0 이상의 버전을 사용해야 합니다. (Xcode11, iOS13)`

## サービスログイン

* TOAST SDKで提供するすべてのサービス(Push、IAP、Log & Crashなど)は、同じユーザーID1つのみを使用します。

### ログイン

`ユーザーIDが設定されていない状態では、トークンの登録および照会機能を使用できません。`

``` objc
// サービスログイン完了後、ユーザーID設定
[ToastSDK setUserID:@"INPUT_USER_ID"];
```

### ログアウト

`ログアウトしても登録された通知は解除されません。`

``` objc
// サービスログアウト完了後、ユーザーIDをnilに設定
[ToastSDK setUserID:nil];
```

## TOAST Push SDKの初期化

Pushで発行されたAppKeyを設定します。
`初期化しない状態では、トークンの登録および照会機能を使用できません。`
`Delegate 설정이 된 후 메시지 수신에 대한 통지를 받을 수 있습니다.`
`원활한 메시지 수신을 위해 application:didFinishLaunchingWithOptions: 함수에서 Delegate 설정을 권장합니다.`
`개발환경에서는 반드시 ToastPushConfiguration 의 sandbox 프로퍼티를 YES로 설정해야 개발용 인증서로 발송한 메시지의 수신이 가능합니다.`

### 初期化API仕様

``` objc

@interface ToastPush : NSObject

// ...

// 初期化およびDelegate設定
+ (void)initWithConfiguration:(ToastPushConfiguration *)configuration
                     delegate:(nullable id<ToastPushDelegate>)delegate;

// Delegate設定
+ (void)setDelegate:(nullable id<ToastPushDelegate>)delegate;

// 初期化
+ (void)initWithConfiguration:(ToastPushConfiguration *)configuration;

// カテゴリー設定
+ (void)setCategories:(nullable NSSet<UNNotificationCategory *> *)categories;

// お知らせオプション設定
// iOS 8.0+ : UIUserNotificationType
// iOS 10.0+ : UNAuthorizationOptions
// default : UNAuthorizationOptionSound | UNAuthorizationOptionBadge
+ (void)setOptions:(NSInteger)options;

@end
```

### Configuration API仕様

``` objc
@interface ToastPushConfiguration : NSObject

// サービスアプリケーションキー
@property (nonatomic, copy, readonly) NSString *appKey;

// サービスゾーン
@property (nonatomic) ToastServiceZone serviceZone;

// プッシュタイプ(APNS、VoIP)
@property (nonatomic) NSSet<ToastPushType> *pushTypes;

// 国コード (예약 메시지 발송시 기준 시간이 되는 국가코드)
@property (nonatomic, copy) NSString *countryCode;

// 言語設定 (다국어 메시지 발송시 언어 선택 기준)
@property (nonatomic, copy) NSString *languageCode;

// Sandbox(Debug)環境設定
@property (nonatomic) BOOL sandbox;


// アプリケーションキーのみ設定して作成
- (instancetype)initWithAppKey:(NSString *)appKey;

// アプリケーションキー、プッシュタイプを設定して作成
- (instancetype)initWithAppKey:(NSString *)appKey
                     pushTypes:(NSSet<ToastPushType> *)pushTypes;

@end
```

### Delegate API仕様

トークンの登録、トークン解除、プッシュ受信すると、通知アクションの受信後に、追加の機能を提供するためDelegateを登録する必要があります。

``` objc
@protocol ToastPushDelegate <NSObject>

@optional

// トークン登録成功
- (void)didRegisterWithDeviceToken:(NSString *)deviceToken
                           forType:(ToastPushType)type;

// トークン登録失敗
- (void)didFailToRegisterForType:(ToastPushType)type
                       withError:(NSError *)error;

// トークン解題成功
- (void)didUnregisterWithDeviceToken:(nullable NSString *)deviceToken
                             forType:(ToastPushType)type;

// トークン解題失敗
- (void)didFailToUnregisterWithDeviceToken:(NSString *)deviceToken
                                   forType:(ToastPushType)type
                                     error:(NSError *)error;

// メッセージ受信
- (void)didReceivePushMessage:(ToastPushMessage *)message
                      forType:(ToastPushType)type;

// 通知アクション受信 (APNS, iOS 10.0+)
- (void)didReceivePushAction:(ToastPushAction *)action;

// 알림 실행 (APNS)
- (void)didReceiveNotificationResponseForPushMessage:(ToastPushMessage *)message;

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

### 初期化プロセス例

``` objc
#import <ToastPush/ToastPush.h>

@interface AppDelegate () <UIApplicationDelegate, ToastPushDelegate>

@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // アプリケーションキーのみ設定する場合、pushTypesはデフォルトでAPNSのみ設定されます。
    ToastPushConfiguration *configuration = [[ToastPushConfiguration alloc] initWithAppKey:@"INPUT_YOUR_APPKEY"];

    // VoIP使用またはAPNSと一緒に使用する場合、下記のようにNSSetに設定します。
    configuration.pushTypes = [NSSet setWithObjects:ToastPushTypeAPNS, ToastPushTypeVoIP, nil];

#if DEBUG
    // 開発環境(Debug)では、必ず下記sandboxプロパティをYESに設定する必要があります。
    configuration.sandbox = YES;
#endif

    // delegateを一緒に設定します。
    [ToastPush initWithConfiguration:configuration delegate:self];

    return YES;
}

#pragma mark - ToastPushDelegates
// トークン登録成功
- (void)didRegisterWithDeviceToken:(NSString *)deviceToken
                           forType:(ToastPushType)type {
    // ...
}

// トークン登録失敗
- (void)didFailToRegisterForType:(ToastPushType)type
                       withError:(NSError *)error {
    // ...
}

// メッセージ受信
- (void)didReceivePushMessage:(ToastPushMessage *)message
                      forType:(ToastPushType)type {
    // ...
}

// 通知アクション(ボタン)受信(iOS 10.0+)
- (void)didReceivePushAction:(ToastPushAction *)action {
    // ...
}

// トークンの登録を解除成功
- (void)didUnregisterWithDeviceToken:(nullable NSString *)deviceToken
                             forType:(ToastPushType)type {
     // ...
}

// トークンの登録解除に失敗し
- (void)didFailToUnregisterWithDeviceToken:(NSString *)deviceToken
                                   forType:(ToastPushType)type
                                     error:(NSError *)error {[
     // ...
}

// 알림 실행
- (void)didReceiveNotificationResponseForPushMessage:(ToastPushMessage *)message {
    // ...
}

```

### 알림 옵션 설정

알림 옵션은 다음과 같이 설정되어 있습니다.
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

## トークン登録

初期化時に、設定されたプッシュタイプ別にOSに登録し、発行されたトークン情報をTOASTクラウドサーバーに登録します。
トークン登録結果は、初期化時に設定されたDelegateを通して伝達されます。

### トークン登録API仕様

``` objc
@interface ToastPush : NSObject

// ...

// トークン登録
+ (void)registerWithAgreement:(ToastPushAgreement *)agreement;

// ...

@end
```

### Agreement API仕様

``` objc
@interface ToastPushAgreement : NSObject

// 通知の表示に同意するか
@property (nonatomic, assign) BOOL allowNotifications;

// 広告性通知の表示に同意するか
@property (nonatomic, assign) BOOL allowAdvertisements;

// 夜間広告性通知に同意するか
@property (nonatomic, assign) BOOL allowNightAdvertisements;

// 初期化
- (instancetype)init;

- (instancetype)initWithAllowNotifications:(BOOL)allowNotifications;

@end
```

### トークン登録例

``` objc
ToastPushAgreement *agreement = [[ToastPushAgreement alloc] init];
agreement.allowNotifications = YES;
agreement.allowAdvertisements = YES;
agreement.allowNightAdvertisements = NO;

[ToastPush registerWithAgreement:agreement];
```

## トークン照会

現在のユーザーIDに登録された最も新しいトークンと設定情報を照会します。

### トークン照会API仕様

``` objc
@interface ToastPush : NSObject

// ...

// トークン照会
+ (void)requestTokenInfoForPushType:(ToastPushType)type
                  completionHandler:(nullable void (^) (ToastPushTokenInfo * _Nullable tokenInfo, NSError * _Nullable error))completionHandler;

// ...

@end
```

### トークン情報API仕様

``` objc
@interface ToastPushTokenInfo : NSObject

// ユーザーID
@property (nonatomic, readonly) NSString *userID;

// トークン
@property (nonatomic, readonly) NSString *deviceToken;

// 国コード
@property (nonatomic, readonly) NSString *countryCode;

// 言語設定
@property (nonatomic, readonly) NSString *languageCode;

// プッシュタイプ
@property (nonatomic, readonly) NSString *pushType;

// 通知の表示に同意するか
@property (nonatomic, readonly) BOOL allowNotifications;

// 広告性通知の表示に同意するか
@property (nonatomic, readonly) BOOL allowAdvertisements;

// 夜間広告性通知の表示に同意するか
@property (nonatomic, readonly) BOOL allowNightAdvertisements;

// 標準時間帯
@property (nonatomic, readonly) NSString *timezone;

// トークンアップデート時間
@property (nonatomic, readonly) NSString *updateDateTime;

@end
```

### トークン照会例

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

## トークン解除

初期化時に設定された情報（プッシュタイプ、サンドボックスの存在）に基づいて登録済みトークンを登録解除します。
`サービスログアウト後にメッセージ受信を望まない場合はトークンを解除してください。`
設定された情報に対応するトークンが存在しない場合、または登録解除が成功した場合は、登録解除成功デリゲートを呼び出します。 
トークンの登録解除結果は、初期化時にデリゲートセットを介して渡されます。

### トークン登録解除APIの仕様

``` objc

@interface ToastPush : NSObject

// ...

// トークン解除
+ (void)unregisterToken;

// ...

@end

```

### トークン登録解除の例

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

## リッチメッセージの受信

`リッチメッセージ受信は、iOS 10.0+以上からサポートします。`
通知メッセージにメディア(画像、動画、音声)とボタンを表現するには、アプリケーションに[Notification Service Extension](./push-ios/#notification-service-extension)が追加されている必要があります。

### リッチメッセージの受信設定例

`NotificationServiceクラスに、ToastPushServiceExtensionを拡張実装する必要があります。`

``` objc
#import <UserNotifications/UserNotifications.h>
#import <ToastPush/ToastPush.h>

@interface NotificationService : ToastPushServiceExtension

@end
```

## 指標の収集

クライアントからプッシュメッセージ受信および通知からアプリケーションを実行したかがサーバーに送信されます。
この内容は統計タブで確認できます。

### 受信(Received)指標収集設定

`受信指標の収集は、iOS 10.0+以上からサポートします。`
受信指標収集のためには、アプリケーションに[Notification Service Extension](./push-ios/#notification-service-extension)が追加されている必要があります。
Toast Push SDK初期化または`NotificationServiceExtensionのinfo.plistファイル`内部にアプリケーションキーを設定すると、指標の送信が可能です。

#### Toast Push SDKを初期化して、受信指標を収集する設定例

``` objc
@implementation NotificationService

- (instancetype)init {
    self = [super init];

    if (self) {
        // 指標の送信にのみ使用されるので、アプリケーションキーのみの設定でも支障ありません。
        ToastPushConfiguration *configuration = [[ToastPushConfiguration alloc] initWithAppKey:@"INPUT_YOUR_APPKEY"];

        [ToastPush initWithConfiguration:configuration delegate:nil];
    }

    return self;
}

@end
```

#### info.plistを設定して受信指標を収集する設定の例

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

### 実行(Opened)指標収集設定

実行指標の収集と送信は、SDK内部で自動的に行われます。
[Toast Push SDK初期化](./push-ios/#toast-push-sdk)または`Applicationのinfo.plistファイル`内部にアプリケーションキーを設定すると指標の送信が可能です。

#### info.plistを設定して受信指標を収集する設定の例

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

`iOS 10.0+ からサポートします。`
リッチメッセージの受信、受信指標収集のためには、アプリケーションにNotificationServiceExtensionを作成および設定する必要があります。

### Notification Service Extension作成

**File New > Target > iOS > Notification Service Extension**

![create_ext](http://static.toastoven.net/toastcloud/sdk/ios/push_create_ext.png)

### Notification Service Extensionの設定

앱의 프로젝트 설정과 동일하게 Extension의 [프로젝트 설정](http://docs.toast.com/ko/TOAST/ko/toast-sdk/push-ios/#toast-push-sdk-xcode)을 추가합니다.
`Extension은 앱과 함께 설치되지만 앱과는 분리된 별도의 Sandbox 환경입니다.`

NotificationService 클래스에 ToastPushServiceExtension 을 확장구현 해야 합니다.

``` objc
#import <UserNotifications/UserNotifications.h>
#import <ToastPush/ToastPush.h>

@interface NotificationService : ToastPushServiceExtension

@end
```

### エラーコード
```objc
typedef NS_ENUM(NSUInteger, ToastPushErrorCode) {
    ToastPushErrorUnknown               = 0,    // 不明
    ToastPushErrorNotInitialize         = 1,    // 初期化しない
    ToastPushErrorUserInvalid           = 2,    // ユーザーID未設定
    ToastPushErrorPermissionDenied      = 3,    // 権限取得失敗
    ToastPushErrorSystemFailed          = 4,    // システムエラー
    ToastPushErrorTokenInvalid          = 5,    // トークン値がないか、有効ではない
    ToastPushErrorAlreadyInProgress     = 6,    // 要請がすでに進行中

    ToastPushErrorNetworkNotAvailable   = 100,  // ネットワーク使用不可
    ToastPushErrorNetworkFailed         = 101,  // HTTP Status Codeが200ではない
    ToastPushErrorTimeout               = 102,  // タイムアウト
    ToastPushErrorParameterInvalid      = 103,  // 要請パラメータエラー
    ToastPushErrorResponseInvalid       = 104,  // サーバーレスポンスエラー
};
```
