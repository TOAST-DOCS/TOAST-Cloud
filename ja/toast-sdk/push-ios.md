## NHN Cloud > NHN Cloud SDK使用ガイド > NHN Cloud Push > iOS

## Prerequisites

1\. [TOAST SDK](./getting-started-ios)を設置します。
2\. [TOASTコンソール](https://console.cloud.toast.com)で [Notification \> Pushを有効化](http://docs.toast.com/ko/Notification/Push/ko/console-guide/)します。
3\. PushでAppKeyを確認します。

## APNSガイド
* [APNSガイド](https://developer.apple.com/library/archive/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/APNSOverview.html)

## TOAST Pushの構成

* iOS用TOAST Push SDKの構成は下記のとおりです。

| Service  | Cocoapods Pod Name | Framework | Dependency | Build Settings |
| --- | --- | --- | --- | --- |
| NHN Cloud Push | NHN CloudPush | ToastPush.framework | UserNotifications.framework<br/><br/>[NHN CloudVoIP]<br/>PushKit.framework<br/>CallKit.framework | |
| Mandatory   | NHN CloudCore<br/>NHN CloudCommon | ToastCore.framework<br/>ToastCommon.framework | | OTHER_LDFLAGS = (<br/>    "-ObjC",<br/>    "-lc++" <br/>); |

## TOAST Push SDKをXcodeプロジェクトに適用

### 1. Cococapodsによる適用

* Podfileを作成してTOAST SDKのPodを追加します。

``` podspec
platform :ios, '9.0'
use_frameworks!

target '{YOUR PROJECT TARGET NAME}' do
    pod 'ToastPush'
end
```

### 2. バイナリーをダウンロードしてTOAST SDKに適用

#### フレームワーク設定

* TOASTの [Downloads](../../../Download/#toast-sdk)ベージでiOS SDKをダウンロードできます。
* Xcode Projectに、**ToastPush.framework**、 **ToastCore.framework**、 **ToastCommon.framework**、 **UserNotifications.framework**を追加します。
* UserNotifications.frameworkは下記の方法で追加できます。
![linked_usernotifications_frameworks](http://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_UserNotifications.png)

#### プロジェクト設定

* **Build Settings**の**Other Linker Flags**に、 **-lc++** と **-ObjC**の項目を追加します。
    * **Project Target > Build Settings > Linking > Other Linker Flags**
![other_linker_flags](http://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags.png)

### Capabilities設定

* TOAST Pushを使用するには、Capabilitiesで**Push Notification**、 **Background Modes**の項目を有効化する必要があります。
    * **Project Target > Signing & Capabilities > + Capability > Push Notification**
![add_capability_push_notifications](http://static.toastoven.net/toastcloud/sdk/ios/add_capability_notifications.png)
    * **Project Target > Signing & Capabilities > + Capability > Background Modes**
![add_capability_background_modes](http://static.toastoven.net/toastcloud/sdk/ios/add_capability_background_modes.png)
    * **Background Modes**の項目の中で、**Remote notifications**を有効化してください。
![capabilities](http://static.toastoven.net/toastcloud/sdk/ios/push_capabilities.png)

## Xcode11 / iOS13の変更点
* 共通
    * Xcode11でTOAST SDK 0.18.0未満のバージョンを使用するプロジェクトは、iOS13でトークン登録に失敗する問題が発生します。
    * `Xcode11以上を使用する場合、TOAST SDK 0.18.0以上のバージョンを利用してください。(Xcode11, iOS13)`
* VoIP
    * iOS13以上から、VoIPメッセージを受信後に、CallKitへレポートしないとメッセージの受信が制限されます。([PushKit pushRegistryガイド](https://developer.apple.com/documentation/pushkit/pkpushregistrydelegate/2875784-pushregistry))
    * CallKitを使用した電話受信画面は、アプリに直接と実装する必要があります。

## サービスログイン

* TOAST SDKで提供するすべての商品(Push, IAP, Log & Crash, ...)は、ひとつのユーザーIDを共有します。

### ログイン

* `初回トークン登録時に、ユーザーIDが設定されていない場合は、デバイス識別子を使用して登録します。` ([トークン登録セクション参照](https://docs.toast.com/ja/TOAST/ja/toast-sdk/push-ios/#_10))
* `トークン登録後、ユーザーIDを設定、または変更すると、トークン情報を更新します。`

``` objc
// サービスログイン、ユーザーID設定
[ToastSDK setUserID:@"INPUT_USER_ID"];
```

### ログアウト

* `ログアウトしても登録されたトークンは削除されません。`

``` objc
// サービスログアウト、ユーザーIDをnilに設定
[ToastSDK setUserID:nil];
```

## TOAST Push SDK初期化

* `初期化をしない状態では、トークン登録、および照会機能を使用できません。`
* [ToastPushConfiguration](./push-ios/#toastpushconfiguration) オブジェクトにTOASTクラウドサーバーで発行されたPush AppKeyを設定します。
* `開発環境では、必ずToastPushConfigurationのsandboxプロパティをYESに設定しないと、開発用認証書で送信したメッセージの受信ができません。`

### 初期化APIの明細

``` objc
// 初期化、およびDelegate設定
+ (void)initWithConfiguration:(ToastPushConfiguration *)configuration
                     delegate:(nullable id<ToastPushDelegate>)delegate;

// 初期化
+ (void)initWithConfiguration:(ToastPushConfiguration *)configuration;

// Delegate設定
+ (void)setDelegate:(nullable id<ToastPushDelegate>)delegate;
```

### Delegate API明細
* アプリが実行中の状態で通知メッセージを受信すると、[ToastPushMessage](./push-ios/#toastpushmessage) オブジェクトで受信したメッセージの内容が伝達されます。
* ユーザーが通知を実行(クリック)してアプリが実行された時、[ToastPushMessage](./push-ios/#toastpushmessage)オブジェクトで実行された通知メッセージの内容がユーザーに通知されます。
* ユーザーが通知内のボタンを実行(クリック)した時、[ToastPushNotificationAction](./push-ios/#toastpushnotificationaction)オブジェクトが実行されたボタンのアクション情報がシステムに伝達されます。
* `スムーズにメッセージ受信が行えるように、application:didFinishLaunchingWithOptions: 関数でDelegate設定をお勧めいたします。`

``` objc
@protocol ToastPushDelegate <NSObject>

@optional

// メッセージ受信
- (void)didReceiveNotificationWithMessage:(ToastPushMessage *)message;

// 通知実行(クリック)
- (void)didReceiveNotificationResponseWithMessage:(ToastPushMessage *)message

// 通知アクション(ボタン)実行
- (void)didReceiveNotificationAction:(ToastPushNotificationAction *)action

@end
```

### 初期化、およびDelegate設定例

``` objc
#import <ToastPush/ToastPush.h>

@interface AppDelegate () <UIApplicationDelegate, ToastPushDelegate>

@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // ...

    // 設定オブジェクトを作成します。
    ToastPushConfiguration *configuration = [[ToastPushConfiguration alloc] initWithAppKey:@"INPUT_YOUR_APPKEY"];

#if DEBUG
    // 開発環境(Debug)では、必ず、以下のsandboxプロパティをYESに設定しなければなりません。設定しないと、開発用認証書で送信したメッセージの受信ができなくなります。
    configuration.sandbox = YES;
#endif

    // 初期化と同時に、Delegateを設定します。
    [ToastPush initWithConfiguration:configuration 
                            delegate:self];

    return YES;
}

#pragma mark - ToastPushDelegate
// メッセージ受信
- (void)didReceiveNotificationWithMessage:(ToastPushMessage *)message {
    // ...
}

// 通知応答(実行)
- (void)didReceiveNotificationResponseWithMessage:(ToastPushMessage *)message {
    // ...
}

// 通知アクション(ボタン、返信)実行
- (void)didReceiveNotificationAction:(ToastPushNotificationAction *)action {
    // ...
}
```

## 通知オプションの設定

* [ToastNotificationOptions](./push-ios/#toastnotificationoptions) オブジェクトで通知オプション設定が可能です。

| オプション名 | 説明 | デフォルト値 |
| --- | --- | --- |
| foregroundEnabled | アプリがフォアグラウンド状態の時に通知を表示するか | NO |
| badgeEnabled | バッジアイコンを使用するか | YES |
| soundEnabled | 通知音を使用するか | YES |

* アプリがフォアグラウンド状態の時は、通知を表示させないのが基本動作となっているため、通知オプションを設定する必要があります。
### 通知オプション設定API

``` objc
+ (void)setNotificationOptions:(nullable ToastNotificationOptions *)options;
```

### 通知オプションの設定例

``` objc
ToastNotificationOptions *options = [[ToastNotificationOptions alloc] init];
options.foregroundEnabled = YES;    // フォアグラウンド通知使用設定 (default : NO)
options.badgeEnabled = YES;         // バッジアイコン使用設定 (default : YES)
options.soundEnabled = YES;         // 通知音使用設定(default : YES)
    
[ToastPush setNotificationOptions:options];
```

## トークン登録

* 発行されたトークン情報をTOASTクラウドサーバーに登録します。この時、受信同意(ToastPushAgreement)をパラメーターで伝達します。
* 初めて実行される際、ユーザーに通知を許可するかどうかを返信するようリクエストします。ユーザーからの通知許諾が得られなかった場合、トークン登録は失敗します。
* 初回登録時にユーザーIDが設定されていない場合は、デバイス識別子を使用して登録します。

### 受信同意設定

* 韓国における情報通信網法の規定(第50条から第50条の8)に基づき、トークン登録時の通知/広報性/夜間の広報性Pushメッセージ受信に関して、同意するかも、同時に入力されます。メッセージの送信時に、ユーザーが受信同意をしているかを基準に自動的にフィルタリングします。
    * [KISAガイドへのショートカット（韓国語）](https://spam.kisa.or.kr/spam/sub62.do)
    * [法令へのショートカット（韓国語）](http://www.law.go.kr/법령/정보통신망이용촉진및정보보호등에관한법률/%2820130218,11322,20120217%29/제50조)
* [ToastPushAgreement](./push-ios/#toastpushagreement) オブジェクトにユーザー通知メッセージの同意情報を設定します。
### トークン登録、および受信同意設定API

``` objc
// トークン登録、および受信同意設定
+ (void)registerWithAgreement:(ToastPushAgreement *)agreement
            completionHandler:(nullable void (^)(ToastPushTokenInfo * _Nullable tokenInfo, NSError * _Nullable error))completionHandler;

// すでに設定された受信同意情報を使用してトークン登録
+ (void)registerWithCompletionHandler:(nullable void (^)(ToastPushTokenInfo * _Nullable tokenInfo, NSError * _Nullable error))completionHandler;
```

### トークン登録、および受信同意設定例

``` objc
ToastPushAgreement *agreement = [[ToastPushAgreement alloc] initWithAllowNotifications:YES]; // 通知メッセージの受信同意
agreement.allowAdvertisements = YES;        // 広報性メッセージの受信同意
agreement.allowNightAdvertisements = YES;   // 夜間広報性通知メッセージの受信同意

[ToastPush registerWithAgreement:agreement
               completionHandler:^(ToastPushTokenInfo *tokenInfo, NSError *error) {

    if (error == nil) {
        // トークン登録成功
        NSLog(@"Successfully registered : %@", tokenInfo.deviceToken);
        
    } else {
        // トークン登録失敗
        NSLog(@"Failed to register : %@", error.localizedDescription);
    }
}];
```

## トークン情報照会

* 現在のデバイスで最後に登録に成功したトークンと設定情報を照会します。
* トークン照会が成功すると、 [ToastPushTokenInfo](./push-ios/#toastpushtokeninfo) オブジェクトにトークン設定情報を返します。

### トークン情報照会API

``` objc
+ (void)queryTokenInfoWithCompletionHandler:(void (^)(ToastPushTokenInfo * _Nullable tokenInfo, NSError * _Nullable error))completionHandler;
```

### トークン情報照会の例

``` objc
[ToastPush queryTokenInfoWithCompletionHandler:^(ToastPushTokenInfo *tokenInfo, NSError *error) {
    if (error == nil) {
        // トークン情報照会成功
        NSLog(@"Successfully query token info : %@", [tokenInfo description]);
        
    } else {
        // トークン情報照会失敗
        NSLog(@"Failed to query token info : %@", error.localizedDescription);
    }
}];
```

## トークン解除

* TOASTクラウドサーバーに登録されたトークンを解除します。解除されたトークンはメッセージの送信対象から除外されます。
* `サービスログアウト後にメッセージの受信を希望しない場合、トークンを解除してください`
* `トークンが解除されても端末上の通知権限は回収されません。`

### トークン解除API

``` objc
+ (void)unregisterWithCompletionHandler:(nullable void (^)(NSString * _Nullable deviceToken, NSError * _Nullable error))completionHandler;
```

### トークン解除例

``` objc
[ToastPush unregisterWithCompletionHandler:^(NSString *deviceToken, NSError *error) {
    if (error == nil) {
        // トークン解除成功
        NSLog(@"Successfully unregistered token : %@", deviceToken);
        
    } else {
        // トークン解除失敗
        NSLog(@"Failed to unregister : %@", error.localizedDescription);
    }
}];
```

## リッチメッセージ

* リッチメッセージは、通知のタイトル、本文とともにメディア(イメージ、ビデオ、オーディオ)を通知に表現し、ボタン、返信などのアクションを追加します。
* `リッチメッセージの受信は、iOS 10.0+ 以上からサポートします。`
* リッチメッセージの表示には、ユーザーアプリケーションにToastPushServiceExtensionを継承するNotification Service Extensionを実装する必要があります。(Notification Service Extensionの追加方法は、[Notification Service Extension](./push-ios/#notification-service-extension) セクションを参照)

### サポートするリッチメッセージ

#### ボタン

| タイプ | 機能 | アクション |
| --- | ------- | --- |
| アプリを開く(OPEN_APP) | アプリケーション実行 | ToastPushNotificationActionOpenApp |
| URLを開く(OPEN_URL) | URLに移動<br/>(ウェブサイトのURL、またはアプリカスタムスキームを実行) | ToastPushNotificationActionOpenURL |
| 返信(REPLY) | 通知から返信を転送 | ToastPushNotificationActionReply |
| 取消(DISMISS) | 現在の通知を取消| ToastPushNotificationActionDismiss |

> ボタンは、メッセージあたり最大 3つまでサポートします。

#### メディア

| タイプ | サポートするフォーマット | 最大サイズ | 推奨事項 |
| --- | ------- | --- | --- |
| 画像 | JPEG, PNG, GIF | 10 MB | 横画像推奨<br>最大サイズ : 1038 x 1038 |
| 動画 | MPEG, MPEG3Video, MPEG4, AVIMovie | 50 MB |  |
| 音声 | WaveAudio, MP3, MPEG4Audio | 5 MB |  |

> ウェブURLを使用する場合は、メディアファイルのダウンロードに時間がかかります。

## 指標収集

* クライアントでPushメッセージの受信とユーザー通知実行に対する指標を収集して、TOASTクラウドサーバーに送信します。
* 収集した内容は統計タブでご確認いただけます。
* `指標の収集のためには、Push SDKの初期化、あるいはinfo.plistファイルにAppKeyが定義されている必要があります。`

### 受信(Received)指標収集設定

* `受信指標の収集は、iOS 10.0+以上からサポートします。`
* 受信指標は、Notification Service Extensionに追加したToast Push SDKで自動的に収集されます。
* 受信指標を収集には、ユーザーアプリケーションにToastPushServiceExtensionを継承するNotification Service Extensionを実装しなければなりません。(Notification Service Extension追加方法は、 [Notification Service Extension](./push-ios/#notification-service-extension)セクション参照)
* Notification Service Extensionの生成者で、[Toast Push SDK初期化](./push-ios/#toast-push-sdk)、あるいは**エクステンションのinfo.plistファイル**にAppKeyが定義されていないと、受信指標の収集ができません。

#### 初期化による受信指標収集の設定例

* `アプリケーションとエクステンションは一緒にインストールされますが、分離した別々のサンドボックス環境であるため、アプリケーションの初期化とは別に、エスステンションでも初期化しなければなりません。`

``` objc
@implementation NotificationService

- (instancetype)init {
    self = [super init];

    if (self) {
        // 指標送信にのみ使用されるため、AppKeyのみ設定してください。
        ToastPushConfiguration *configuration = [[ToastPushConfiguration alloc] initWithAppKey:@"INPUT_YOUR_APPKEY"];

        [ToastPush initWithConfiguration:configuration];
    }

    return self;
}

@end
```

#### info.plist定義による受信指標収集の設定例

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

* 実行指標は、アプリケーションに追加したToast Push SDKから自動的に収集されます。
* [Toast Push SDK 初期化](./push-ios/#toast-push-sdk)、あるいは**アプリケーションのinfo.plistファイル**にAppKeyが定義されている場合、実行指標の収集が可能です。

#### info.plist定義による受信指標収集の設定例

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

* `iOS 10.0+からサポートします。`
* リッチメッセージ、受信指標を収集するためには、アプリケーションにToastPushServiceExtensionを継承する Notification Service Extension必ず実装してください。

### Notification Service Extensionの作成

* **File New > Target > iOS > Notification Service Extension**
![create_ext](http://static.toastoven.net/toastcloud/sdk/ios/push_create_ext.png)

### Notification Service Extension設定

* アプリのプロジェクト設定と同様に、Extensionの[プロジェクト設定](./push-ios/#프로젝트-설정)を追加します。
* `iOSのExtensionはアプリと一緒にインストールされますが、アプリとは分離された別のサンドボックス環境であるため、コンテナを共有することはできません。`

### Notification Service Extension設定例

* 作成したNotificationServiceクラスにToastPushServiceExtensionを継承する必要があります。
* ユーザー定義処理ロジックがない場合は、継承するだけでもリッチメッセージと受信指標の収集機能が動作します。

``` objc
#import <UserNotifications/UserNotifications.h>
#import <ToastPush/ToastPush.h>

@interface NotificationService : ToastPushServiceExtension

@end
```

## ユーザー·タグ

* [ユーザー·タグ](https://docs.toast.com/ko/Notification/Push/ko/console-guide/#_16)能は、複数のユーザー IDをひとつのタグで結びつけ、それを活用してメッセージを送信することができます。
* タグ名ではなく、タグID(8桁の文字列)に基づいて動作し、タグIDはコンソール > タグメニューから作成・確認できます。

### ユーザー·タグ設定API

``` objc
// ユーザーIDのタグIDリスト追加
+ (void)addUserTagWithIdentifiers:(NSSet<NSString *> *)tagIdentifiers
                completionHandler:(nullable void (^)(NSSet<NSString *> * _Nullable tagIdentifiers, NSError * _Nullable error))completionHandler;

// ユーザーIDのタグIDリストアップデート
+ (void)setUserTagWithIdentifiers:(nullable NSSet<NSString *> *)tagIdentifiers
                completionHandler:(nullable void (^)(NSError * _Nullable error))completionHandler;

// ユーザーIDのタグIDリスト取得
+ (void)getUserTagWithCompletionHandler:(void (^)(NSSet<NSString *> * _Nullable tagIdentifiers, NSError * _Nullable error))completionHandler;

// ユーザーIDのタグIDリスト獲得
+ (void)removeUserTagWithIdentifiers:(NSSet<NSString *> *)tagIdentifiers
                   completionHandler:(nullable void (^)(NSSet<NSString *> * _Nullable tagIdentifiers, NSError * _Nullable error))completionHandler;

// ユーザーIDの全タグ削除
+ (void)removeAllUserTagWithCompletionHandler:(nullable void (^)(NSError * _Nullable error))completionHandler;
```

### ユーザータグ修正

#### ユーザータグ修正例

* 入力されたタグIDリストを追加またはアップデートし、最終的に反映されたタグIDリストを返します。

``` objc
// 追加するタグIDリスト作成
NSMutableSet<NSString *> *tagIDs = [NSMutableSet set];
[tagIDs addObject:TAG_ID_1];    // e.g. "ZZPP00b6" (8桁の文字列)
[tagIDs addObject:TAG_ID_2];

// ログインされているユーザーIDのタグIDリスト追加
[ToastPush addUserTagWithIdentifiers:tagIDs
                    cmpletionHandler:^(NSSet<NSString *> *tagIdentifiers, NSError *error) {
    
    if (error == nil) {
        // タグIDリスト追加成功
    } else {
        // タグIDリスト追加失敗
    }
}];

// ログインされているユーザーIDのタグIDリストアップデート(既存のタグIDリストは削除され、入力した値で設定)
[ToastPush setUserTagWithIdentifiers:tagIDs
                    cmpletionHandler:^(NSError *error) {
    
    if (error == nil) {
        // タグIDリストアップデート成功
    } else {
        // タグIDリストアップデート成功
    }
}];
```

### ユーザータグ取得

* 現在のユーザーに登録されたすべてのタグIDリストを返します。

#### ユーザータグ取得例

``` objc
// ログインされているユーザーIDの全タグIDリストを返します。
[ToastPush getUserTagWithCompletionHandler:^(NSSet<NSString *> *tagIdentifiers, NSError *error) {
    if (error == nil) {
        // タグIDリスト獲得成功
    } else {
        // タグIDリスト獲得失敗
    }
}];
```

### ユーザータグの削除

#### ユーザータグの削除例

* 入力されたユーザータグIDリストを削除し、最終的に反映されたタグIDリストを返します。

``` objc
// 削除するタグIDリスト作成
NSMutableSet<NSString *> *tagIDs = [NSMutableSet set];
[tagIDs addObject:TAG_ID_1];    // e.g. "ZZPP00b6" (8桁の文字列)
[tagIDs addObject:TAG_ID_2];

// ログインされているユーザーIDのタグIDリスト削除
[ToastPush removeUserTagWithIdentifiers:tagIDs
                      completionHandler:^(NSSet<NSString *> *tagIdentifiers, NSError *error) {
    if (error == nil) {
        // タグIDリスト削除成功
    } else {
        // タグIDリスト削除失敗
    }
}];

// ログインされているユーザーIDの全タグIDリスト削除
[ToastPush removeAllUserTagWithCompletionHandler:^(NSError *error) {
    if (error == nil) {
        // 全ユーザータグ削除成功
    } else {
        // 全ユーザータグ削除成功
    }
}];
```

## VoIP

* `VoIP機能はiOS 10.0以上からサポートします。`
### フレームワーク設定

* TOAST PushのVoIP機能を使うには、**PushKit.framework**、**CallKit.framework**を追加する必要があります。
* PushKit.framework、CallKit.frameworkは以下の方法で追加できます。
![linked_pushkit_frameworks](http://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_PushKit.png)
![linked_callkit_frameworks](http://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_CallKit.png)
![linked_frameworks_push](http://static.toastoven.net/toastcloud/sdk/ios/push_link_frameworks_push.png)

### Capabilities設定

* **Project Target > Signing & Capabilities > + Capability > Background Modes**
![add_capability_background_modes](http://static.toastoven.net/toastcloud/sdk/ios/add_capability_background_modes.png)

* **Voice over IP**項目を有効化する必要があります。
![capabilities](http://static.toastoven.net/toastcloud/sdk/ios/push_capabilities_voip.png)

### 初期化

* `VoIP機能は[Toast Push SDK 初期化](./push-ios/#toast-push-sdk)がされていなければ使用できません。`
* `VoIP機能はToast Push SDKのサブモジュールで別途分離されています。`

### Delegate設定

* VoIPメッセージを受信すると、[ToastPushMessage](./push-ios/#toastpushmessage)オブジェクトで受信したメッセージの内容が伝達されます。
* `スムーズにメッセージを受信するために application:didFinishLaunchingWithOptions: 関数でDelegate設定をお勧めします。`

#### Delegate API

``` objc
@protocol ToastVoIPDelegate <NSObject>

// メッセージ受信
- (void)didReceiveIncomingVoiceCallWithMessage:(ToastPushMessage *)message;

@end
```

#### Delegate設定例

``` objc
// VoIPサブモジュールを追加します。
#import <ToastPush/ToastVoIP.h>

@interface AppDelegate () <UIApplicationDelegate, ToastVoIPDelegate>

@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // ...

    // Delegatを設定します。
    [ToastVoIP setDelegate:self];

    return YES;
}

#pragma mark - ToastVoIPDelegate
// メッセージ受信
- (void)didReceiveIncomingVoiceCallWithMessage:(ToastPushMessage *)message {
    // ...
}
```

### トークン登録

* 発行されたVoIPトークン情報をTOASTクラウドサーバに登録します。
* VoIP機能は別途ユーザー権限あるいは同意情報は必要ありません。

#### トークン登録API

```objc
+ (void)registerWithCompletionHandler:(nullable void (^)(ToastPushTokenInfo * _Nullable tokenInfo, NSError * _Nullable error))completionHandler;
```

#### トークン登録例

```objc
[ToastVoIP registerWithCompletionHandler:^(ToastPushTokenInfo *tokenInfo, NSError *error) {
    if (error == nil) {
        // トークン登録成功
        NSLog(@"Successfully registered : %@", tokenInfo.deviceToken);
        
    } else {
        // トークン登録失敗
        NSLog(@"Failed to register : %@", error.localizedDescription);
    }
}];
```

### トークン情報照会

* 現在のデバイスで最後に登録に成功したトークンと設定情報を照会します。
* トークン照会情報に成功すると、[ToastPushTokenInfo](./push-ios/#toastpushtokeninfo)オブジェクトにトークンの設定情報が返されます。

#### トークン情報照会API

```objc
@interface ToastVoIP : NSObject
+ (void)queryTokenInfoWithCompletionHandler:(void (^)(ToastPushTokenInfo * _Nullable tokenInfo, NSError * _Nullable error))completionHandler;
```

#### トークン情報照会例

```objc
[ToastVoIP queryTokenInfoWithCompletionHandler:^(ToastPushTokenInfo *tokenInfo, NSError *error) {
    if (error == nil) {
        // トークン情報照会成功
        NSLog(@"Successfully query token info : %@", [tokenInfo description]);
        
    } else {
        // トークン情報照会失敗
        NSLog(@"Failed to query token info : %@", error.localizedDescription);
    }
}];
```

### トークン解除

* TOASTクラウドサーバーに登録されたトークンを解除します。 解除されたトークンは、メッセージの送信対象から除外されます。
* `サービスログアウト後にメッセージの受信を希望されない場合、トークンを解除してください。`

#### トークン解除API

```objc
+ (void)unregisterWithCompletionHandler:(nullable void (^)(NSString * _Nullable deviceToken, NSError * _Nullable error))completionHandler;
```

#### トークン解除例

```objc
[ToastVoIP unregisterWithCompletionHandler:^(NSString *deviceToken, NSError *error) {
    if (error == nil) {
        // トークン解除成功
        NSLog(@"Successfully unregistered token : %@", deviceToken);
        
    } else {
        // トークン解除失敗
        NSLog(@"Failed to unregister : %@", error.localizedDescription);
    }
}];
```

## エラー·コード

### Push機能エラーコード
```objc
extern NSErrorDomain const ToastPushErrorDomain;

typedef NS_ERROR_ENUM(ToastPushErrorDomain, ToastPushError) {
    ToastPushErrorUnknown = 0,              // 不明
    ToastPushErrorNotInitialized = 1,       // 初期化していない
    ToastPushErrorUserInvalid = 2,          // ユーザーID未設定
    ToastPushErrorPermissionDenied = 3,     // 権限獲得失敗
    ToastPushErrorSystemFailed = 4,         // システムによる失敗
    ToastPushErrorTokenInvalid = 5,         // トークン値がないか、無効
    ToastPushErrorAlreadyInProgress = 6,    // すでに進行中
    ToastPushErrorParameterInvalid = 7,     // 無効な変数
    ToastPushErrorNotSupported = 8,         // サポートしていない機能
};
```

### ネットワークエラーコード
``` objc
extern NSErrorDomain const ToastHttpErrorDomain;

typedef NS_ERROR_ENUM(ToastHttpErrorDomain, ToastHttpError) {
    ToastHttpErrorNetworkNotAvailable = 100,        // ネットワーク使用不可
    ToastHttpErrorRequestFailed = 101,              // HTTP Status Codeが200でない、あるいはサーバーで要求を正しく読み取れない
    ToastHttpErrorRequestTimeout = 102,             // タイムアウト
    ToastHttpErrorRequestInvalid = 103,             // 誤ったリクエスト (パラメーターエラーなど)
    ToastHttpErrorURLInvalid = 104,                 // URLエラー
    ToastHttpErrorResponseInvalid = 105,            // サーバー応答エラー
    ToastHttpErrorAlreadyInprogress = 106,          // 同一リクエストですでに実行中
    ToastHttpErrorRequiresSecureConnection = 107,   // Allow Arbitrary Loads未設定
};
```

## NHN Cloud Push Class Reference

### ToastPushConfiguration
* TOAST Pushを初期化する際に配信されるPush設定情報です。

``` objc
@interface ToastPushConfiguration : NSObject

// サービスAppKey
@property (nonatomic, copy, readonly) NSString *appKey;

// サービスゾーン
@property (nonatomic) ToastServiceZone serviceZone;

// 国コード (予約メッセージ送信時、基準時間となる国コード)
@property (nonatomic, copy) NSString *countryCode;

// 言語コード（多言語メッセージ送信時の言語選択基準）
@property (nonatomic, copy) NSString *languageCode;

// タイムゾーン
@property (nonatomic, copy) NSString *timezone;

// Sandbox(Debug)環境設定
@property (nonatomic) BOOL sandbox;


+ (instancetype)configurationWithAppKey:(NSString *)appKey;

- (instancetype)initWithAppKey:(NSString *)appKey;

@end
```

### ToastNotificationOptions
* TOAST Pushを初期化する際に配信される通知設定情報です。

``` objc
@interface ToastNotificationOptions : NSObject

// アプリ実行中に通知に表示するか
@property (nonatomic) BOOL foregroundEnabled;

// バッジアイコンを使用するか
@property (nonatomic) BOOL badgeEnabled;

// 通知音を使用するか
@property (nonatomic) BOOL soundEnabled;

@end
```


### NHN CloudPushAgreement

``` objc
@interface ToastPushAgreement : NSObject

// 通知表示に同意するか
@property (nonatomic, assign) BOOL allowNotifications;

// 広告通知表示に同意するか
@property (nonatomic, assign) BOOL allowAdvertisements;

// 夜間広告性通知に同意するか
@property (nonatomic, assign) BOOL allowNightAdvertisements;


+ (instancetype)agreementWithAllowNotifications:(BOOL)allowNotifications;

* (instancetype)initWithAllowNotifications:(BOOL)allowNotifications;

@end
```

### ToastPushMessage
* メッセージの受信時に返されるオブジェクトです。

```objc
@interface ToastPushMessage : NSObject

@property (nonatomic, readonly) NSString *identifier;

@property (nonatomic, readonly, nullable) NSString *title;

@property (nonatomic, readonly, nullable) NSString *body;

@property (nonatomic, readonly) NSInteger badge;

@property (nonatomic, readonly, nullable) ToastPushRichMessage *richMessage;

@property (nonatomic, readonly) NSDictionary<NSString *, NSString *> *payload;

@end
```

### ToastPushMessage
* 受信したメッセージの内容のうち、リッチメッセージの内容を含むオブジェクトです。

```objc
@interface ToastPushRichMessage : NSObject

@property (nonatomic, readonly, nullable) ToastPushMedia *media;

@property (nonatomic, readonly, nullable) NSArray<ToastPushButton *> *buttons;

@end
```

### ToastPushMedia
* 受信したリッチメッセージの中で、メディアの内容を含むオブジェクトです。

```objc
@interface ToastPushMedia : NSObject

@property (nonatomic, readonly) ToastPushMediaType mediaType;

@property (nonatomic, readonly) NSString *source;

@end
```

### ToastPushButton
* 受信したリッチメッセージの内容のうち、ボタンの内容を含むオブジェクトです。

```objc
@interface ToastPushButton : NSObject

@property (nonatomic, readonly) NSString *identifier;

@property (nonatomic, readonly) ToastPushButtonType buttonType;

@property (nonatomic, readonly) NSString *name;

@property (nonatomic, readonly, nullable) NSString *link;

@property (nonatomic, readonly, nullable) NSString *hint;

@property (nonatomic, readonly, nullable) NSString *submit;

@end
```

### ToastPushNotificationAction
* 通知アクション（ボタン、返信）受信時に返されるオブジェクトです。

```objc
typedef NS_ENUM(NSInteger, ToastPushNotificationActionType) {
    ToastPushNotificationActionDismiss = 0,
    ToastPushNotificationActionOpenApp = 1,
    ToastPushNotificationActionOpenURL = 2,
    ToastPushNotificationActionReply = 3,
};


@interface ToastPushNotificationAction : NSObject <NSCoding, NSCopying>

@property (nonatomic, readonly) NSString *actionIdentifier;

@property (nonatomic, readonly) NSString *categoryIdentifier;

@property (nonatomic, readonly) ToastPushNotificationActionType actionType;

@property (nonatomic, readonly) ToastPushButton *button;

@property (nonatomic, readonly) ToastPushMessage *message;

@property (nonatomic, readonly, nullable) NSString *userText;

@end
```

### ToastPushTokenInfo
* トークン情報の照会リクエスト時に返されるトークン情報オブジェクトです。
``` objc
typedef NSString *ToastPushType NS_STRING_ENUM;
// APNSタイプ
extern ToastPushType const ToastPushTypeAPNS;
// VoIPタイプ
extern ToastPushType const ToastPushTypeVoIP;


@interface ToastPushTokenInfo : NSObject

// ユーザーID
@property (nonatomic, readonly) NSString *userID;

// トークン
@property (nonatomic, readonly) NSString *deviceToken;

// 国コード
@property (nonatomic, readonly) NSString *countryCode;

// 言語設定
@property (nonatomic, readonly) NSString *languageCode;

// Pushトークンタイプ
@property (nonatomic, readonly) ToastPushType pushType;

// 通知表示に同意するか
@property (nonatomic, readonly) BOOL allowNotifications;

// 広告通知表示に同意するか
@property (nonatomic, readonly) BOOL allowAdvertisements;

// 夜間広告性表示に同意するか
@property (nonatomic, readonly) BOOL allowNightAdvertisements;

// 標準時間帯
@property (nonatomic, readonly) NSString *timezone;

// トークンアップデート時間
@property (nonatomic, readonly) NSString *updateDateTime;

// サンドボックス環境で登録されたトークンかを確認
@property (nonatomic, getter=isSandbox) BOOL sandbox;

@end
```
