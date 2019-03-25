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
| TOAST Push | ToastPush | ToastPush.framework | * UserNotifications.framework<br/><br/>[Optional]<br/> * PushKit.framework | |
| Mandatory   | ToastCore<br/>ToastCommon | ToastCore.framework<br/>ToastCommon.framework | | OTHER_LDFLAGS = (<br/>    "-ObjC",<br/>    "-lc++" <br/>); |

## TOAST IAP SDKをXcodeプロジェクトに適用

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

TOAST PushのVoIP機能を使用するには、`PushKit.framework`を追加する必要があります。

> PushKit.frameworkは、下記の方法で追加できます。

![linked_pushkit_frameworks](http://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_PushKit.png)

![linked_frameworks_push](http://static.toastoven.net/toastcloud/sdk/ios/push_link_frameworks_push.png)

#### Project Settings

**Build Settings**の**Other Linker Flags**に、**-lc++**と**-ObjC**項目を追加します。

**Project Target > Build Settings > Linking > Other Linker Flags**をクリックして追加できます。

![other_linker_flags](http://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags.png)

#### フレームワークのインポート

使用するフレームワークをインポートします(import)。

```objc
#import <ToastCore/ToastCore.h>
#import <ToastIAP/ToastIAP.h>
```

## Capabilities Setting

TOAST Pushを使用するには、Capabilitiesで**Push Notification**、**Background Modes**項目を有効にする必要があります。

**Project Target > Capabilities > Push Notification > ON**

![capabilities_push_notification](http://static.toastoven.net/toastcloud/sdk/ios/capability_push_notification.png)

**Project Target > Capabilities > Background Modes > ON**

![capabilities_background_modes](http://static.toastoven.net/toastcloud/sdk/ios/capability_background_modes.png)

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
`円滑なメッセージ受信のためにapplication:didFinishLaunchingWithOptions：関数で初期化を実行することを推奨します。`

### 初期化API仕様

``` objc

@interface ToastPush : NSObject

// ...

// 初期化およびDelegate設定
+ (void)initWithConfiguration:(ToastPushConfiguration *)configuration
                     delegate:(nullable id<ToastPushDelegate>)delegate;

// カテゴリー設定(iOS 10.0+)
+ (void)setCategories:(nullable NSSet<UNNotificationCategory *> *)categories NS_AVAILABLE_IOS(10_0);

// ...

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

Delegateを登録すると、トークンの登録後、トークン解除後、あるいはメッセージ/アクション受信後に追加の作業を進めることができます。

``` objc
@protocol ToastPushDelegate <NSObject>

@optional

// トークン登録成功
- (void)didRegisterWithDeviceToken:(NSString *)deviceToken
                           forType:(ToastPushType)type;

// トークン登録失敗
- (void)didFailToRegisterForType:(ToastPushType)type
                       withError:(NSError *)error;

// プッシュ受信
- (void)didReceivePushWithPayload:(NSDictionary *)payload
                          forType:(ToastPushType)type;

// 通知アクション受信(APNS)
- (void)didReceiveNotificationActionWithIdentifier:(NSString *)actionIdentifier
                                categoryIdentifier:(NSString *)categoryIdentifier
                                           payload:(NSDictionary *)payload
                                          userText:(nullable NSString *)userText;

// トークンの登録を解除成功
- (void)didUnregisterWithDeviceToken:(nullable NSString *)deviceToken
                            pushType:(ToastPushType)pushType;

// トークンの登録解除に失敗し
- (void)didFailToUnregisterWithDeviceToken:(NSString *)deviceToken
                                  pushType:(ToastPushType)pushType
                                     error:(NSError *)error;

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
- (void)didReceivePushWithPayload:(NSDictionary *)payload
                          forType:(ToastPushType)type {
    // ...
}

// 通知アクション(ボタン)受信(iOS 10.0+)
- (void)didReceiveNotificationActionWithIdentifier:(NSString *)actionIdentifier
                                categoryIdentifier:(NSString *)categoryIdentifier
                                           payload:(NSDictionary *)payload
                                          userText:(nullable NSString *)userText NS_AVAILABLE_IOS(10_0) {
    // ...
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
                            pushType:(ToastPushType)pushType {
    
    NSLog(@"Success to unregister token : %@", deviceToken);
}

- (void)didFailToUnregisterWithDeviceToken:(NSString *)deviceToken
                                  pushType:(ToastPushType)pushType
                                     error:(NSError *)error {
    
    NSLog(@"Failed to unregister token, error : %@", error);
}

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

NotificationServiceクラスにToastPushServiceExtensionを拡張実装する必要があります。

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
