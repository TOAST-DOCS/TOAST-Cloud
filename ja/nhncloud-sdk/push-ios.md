## NHN Cloud > SDK使用ガイド > Push > iOS

## Prerequisites

1. [NHN Cloud SDK](./getting-started-ios)を設置します。
2. [NHN Cloudコンソール](https://console.nhncloud.com)で [Notification \> Pushを有効化](http://docs.nhncloud.com/ja/Notification/Push/ja/console-guide/)します。
3. PushでAppKeyを確認します。

## APNSガイド
* [APNSガイド](https://developer.apple.com/library/archive/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/APNSOverview.html)

## NHN Cloud Pushの構成

* iOS用NHN Cloud Push SDKの構成は下記のとおりです。

| Service  | Cocoapods Pod Name | Framework | Dependency | Build Settings |
| --- | --- | --- | --- | --- |
| NHN Cloud Push | NHNCloudPush | NHNCloudPush.framework | UserNotifications.framework<br/><br/>[NHNCloudVoIP]<br/>PushKit.framework<br/>CallKit.framework | |
| Mandatory   | NHNCloudCore<br/>NHNCloudCommon | NHNCloudCore.framework<br/>NHNCloudCommon.framework | | OTHER_LDFLAGS = (<br/>    "-ObjC",<br/>    "-lc++" <br/>); |

## NHN Cloud Push SDKをXcodeプロジェクトに適用

### 1. Cococapodsによる適用

* Podfileを作成してNHN Cloud SDKのPodを追加します。

``` podspec
platform :ios, '11.0'
use_frameworks!

target '{YOUR PROJECT TARGET NAME}' do
    pod 'NHNCloudPush'
end
```

### 2. Swift Package Managerを使用してNHN Cloud SDK適用

* XCodeで**File > Add Packages...**メニューを選択します。
* Package URLに'https://github.com/nhn/nhncloud.ios.sdk'を入れて**Add Package**ボタンを選択します。
* NHNCloudPushを選択します。

![swift_package_manager](https://static.toastoven.net/toastcloud/sdk/ios/swiftpackagemanager01.png)

#### プロジェクト設定

* **Build Settings**の **Other Linker Flags**に**-lc++**と**-ObjC**項目を追加します。
    * **Project Target > Build Settings > Linking > Other Linker Flags**
![other_linker_flags](https://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags_202206.png)

### 3. バイナリーをダウンロードしてNHN Cloud SDKに適用

#### フレームワーク設定

* NHN Cloudの [Downloads](../../../Download/#toast-sdk)ベージでiOS SDKをダウンロードできます。
* Xcode Projectに、**NHNCloudPush.framework**, **NHNCloudCore.framework**, **NHNCloudCommon.framework, UserNotifications.framework**を追加します。
* UserNotifications.frameworkは下記の方法で追加できます。
![linked_usernotifications_frameworks](https://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_UserNotifications_202206.png)

#### プロジェクト設定

* **Build Settings**の**Other Linker Flags**に、 **-lc++** と **-ObjC**の項目を追加します。
    * **Project Target > Build Settings > Linking > Other Linker Flags**
![other_linker_flags](https://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags_202206.png)

### Capabilities設定

* NHN Cloud Pushを使用するには、Capabilitiesで**Push Notification**、 **Background Modes**の項目を有効化する必要があります。
    * **Project Target > Signing & Capabilities > + Capability > Push Notification**
![add_capability_push_notifications](https://static.toastoven.net/toastcloud/sdk/ios/add_capability_notifications_202206.png)
    * **Project Target > Signing & Capabilities > + Capability > Background Modes**
![add_capability_background_modes](https://static.toastoven.net/toastcloud/sdk/ios/add_capability_background_modes_202206.png)
    * **Background Modes**の項目の中で、**Remote notifications**を有効化してください。
![capabilities](https://static.toastoven.net/toastcloud/sdk/ios/push_capabilities_202206.png)

## Xcode11 / iOS13の変更点
* VoIP
    * iOS13以上から、VoIPメッセージを受信後に、CallKitへレポートしないとメッセージの受信が制限されます。([PushKit pushRegistryガイド](https://developer.apple.com/documentation/pushkit/pkpushregistrydelegate/2875784-pushregistry))
    * CallKitを使用した電話受信画面は、アプリに直接と実装する必要があります。

## サービスログイン

* NHN Cloud SDKで提供するすべての商品(Push, IAP, Log & Crash, ...)は、ひとつのユーザーIDを共有します。

### ログイン

* `初回トークン登録時に、ユーザーIDが設定されていない場合は、デバイス識別子を使用して登録します。` ([トークン登録セクション参照](./push-ios/#_9))
* `トークン登録後、ユーザーIDを設定、または変更すると、トークン情報を更新します。`

``` objc
// サービスログイン、ユーザーID設定
[NHNCloudSDK setUserID:@"INPUT_USER_ID"];
```

### ログアウト

* `ログアウトしても登録されたトークンは削除されません。`

``` objc
// サービスログアウト、ユーザーIDをnilに設定
[NHNCloudSDK setUserID:nil];
```

## NHN Cloud Push SDK初期化

* `初期化をしない状態では、トークン登録、および照会機能を使用できません。`
* [NHNCloudPushConfiguration](./push-ios/#nhncloudpushconfiguration) オブジェクトにNHN Cloudクラウドサーバーで発行されたPush AppKeyを設定します。
* `開発環境では、必ずNHNCloudPushConfigurationのsandboxプロパティをYESに設定しないと、開発用認証書で送信したメッセージの受信ができません。`

### 初期化APIの明細

``` objc
// 初期化、およびDelegate設定
+ (void)initWithConfiguration:(NHNCloudPushConfiguration *)configuration
                     delegate:(nullable id<NHNCloudPushDelegate>)delegate;

// 初期化
+ (void)initWithConfiguration:(NHNCloudPushConfiguration *)configuration;

// Delegate設定
+ (void)setDelegate:(nullable id<NHNCloudPushDelegate>)delegate;
```

### Delegate API明細
* アプリが実行中の状態で通知メッセージを受信すると、[NHNCloudPushMessage](./push-ios/#nhncloudpushmessage) オブジェクトで受信したメッセージの内容が伝達されます。
* ユーザーが通知を実行(クリック)してアプリが実行された時、[NHNCloudPushMessage](./push-ios/#nhncloudpushmessage)オブジェクトで実行された通知メッセージの内容がユーザーに通知されます。
* ユーザーが通知内のボタンを実行(クリック)した時、[NHNCloudPushNotificationAction](./push-ios/#nhncloudpushnotificationaction)オブジェクトが実行されたボタンのアクション情報がシステムに伝達されます。
* `スムーズにメッセージ受信が行えるように、application:didFinishLaunchingWithOptions: 関数でDelegate設定をお勧めいたします。`

``` objc
@protocol NHNCloudPushDelegate <NSObject>

@optional

// メッセージ受信
- (void)didReceiveNotificationWithMessage:(NHNCloudPushMessage *)message;

// 通知実行(クリック)
- (void)didReceiveNotificationResponseWithMessage:(NHNCloudPushMessage *)message

// 通知アクション(ボタン)実行
- (void)didReceiveNotificationAction:(NHNCloudPushNotificationAction *)action

@end
```

### 初期化、およびDelegate設定例

``` objc
#import <NHNCloudPush/NHNCloudPush.h>

@interface AppDelegate () <UIApplicationDelegate, NHNCloudPushDelegate>

@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // ...

    // 設定オブジェクトを作成します。
    NHNCloudPushConfiguration *configuration = [[NHNCloudPushConfiguration alloc] initWithAppKey:@"INPUT_YOUR_APPKEY"];

#if DEBUG
    // 開発環境(Debug)では、必ず、以下のsandboxプロパティをYESに設定しなければなりません。設定しないと、開発用認証書で送信したメッセージの受信ができなくなります。
    configuration.sandbox = YES;
#endif

// 通知許可権限を取得できなくてもトークンを登録したい場合は、alwaysAllowTokenRegistrationプロパティの値をYESに変更する必要があります。
    configuration.alwaysAllowTokenRegistration = NO;

    // 初期化と同時に、Delegateを設定します。
    [NHNCloudPush initWithConfiguration:configuration
                               delegate:self];

    return YES;
}

#pragma mark - NHNCloudPushDelegate
// メッセージ受信
- (void)didReceiveNotificationWithMessage:(NHNCloudPushMessage *)message {
    // ...
}

// 通知応答(実行)
- (void)didReceiveNotificationResponseWithMessage:(NHNCloudPushMessage *)message {
    // ...
}

// 通知アクション(ボタン、返信)実行
- (void)didReceiveNotificationAction:(NHNCloudPushNotificationAction *)action {
    // ...
}
```

## 通知オプションの設定

* [NHNCloudNotificationOptions](./push-ios/#nhncloudnotificationoptions) オブジェクトで通知オプション設定が可能です。

| オプション名 | 説明 | デフォルト値 |
| --- | --- | --- |
| foregroundEnabled | アプリがフォアグラウンド状態の時に通知を表示するか | NO |
| badgeEnabled | バッジアイコンを使用するか | YES |
| soundEnabled | 通知音を使用するか | YES |

* アプリがフォアグラウンド状態の時は、通知を表示させないのが基本動作となっているため、通知オプションを設定する必要があります。
### 通知オプション設定API

``` objc
+ (void)setNotificationOptions:(nullable NHNCloudNotificationOptions *)options;
```

### 通知オプションの設定例

``` objc
NHNCloudNotificationOptions *options = [[NHNCloudNotificationOptions alloc] init];
options.foregroundEnabled = YES;    // フォアグラウンド通知使用設定 (default : NO)
options.badgeEnabled = YES;         // バッジアイコン使用設定 (default : YES)
options.soundEnabled = YES;         // 通知音使用設定(default : YES)

[NHNCloudPush setNotificationOptions:options];
```

## トークン登録

* 発行されたトークン情報をNHN Cloudクラウドサーバーに登録します。この時、受信同意(NHNCloudPushAgreement)をパラメーターで伝達します。
* 初回実行の場合、ユーザーに通知許可権限を要求します(alwaysAllowTokenRegistrationのデフォルト値はfalseです)。
    * NHNCloudPushConfigurationのalwaysAllowTokenRegistrationの値がfalseの場合。
        * 通知許可権限を取得できなかった場合、トークンの登録は失敗します。
    * NHNCloudPushConfigurationのalwaysAllowTokenRegistrationの値がtrueの場合。
        * 通知許可権限を取得できなかった場合でも、トークンを登録します。
* 初回登録時にユーザーIDが設定されていない場合は、デバイス識別子を使用して登録します。

### 受信同意設定

* 韓国における情報通信網法の規定(第50条から第50条の8)に基づき、トークン登録時の通知/広報性/夜間の広報性Pushメッセージ受信に関して、同意するかも、同時に入力されます。メッセージの送信時に、ユーザーが受信同意をしているかを基準に自動的にフィルタリングします。
    * [KISAガイドへのショートカット（韓国語）](https://www.kisa.or.kr/2060301/form?postSeq=19)
    * [法令へ（韓国語）](http://www.law.go.kr/법령/정보통신망이용촉진및정보보호등에관한법률/%2820130218,11322,20120217%29/제50조)
* [NHNCloudPushAgreement](./push-ios/#nhncloudpushagreement) オブジェクトにユーザー通知メッセージの同意情報を設定します。
### トークン登録、および受信同意設定API

``` objc
// トークン登録、および受信同意設定
+ (void)registerWithAgreement:(NHNCloudPushAgreement *)agreement
            completionHandler:(nullable void (^)(NHNCloudPushTokenInfo * _Nullable tokenInfo, NSError * _Nullable error))completionHandler;

// すでに設定された受信同意情報を使用してトークン登録
+ (void)registerWithCompletionHandler:(nullable void (^)(NHNCloudPushTokenInfo * _Nullable tokenInfo, NSError * _Nullable error))completionHandler;
```

### トークン登録、および受信同意設定例

``` objc
NHNCloudPushAgreement *agreement = [[NHNCloudPushAgreement alloc] initWithAllowNotifications:YES]; // 通知メッセージの受信同意
agreement.allowAdvertisements = YES;        // 広報性メッセージの受信同意
agreement.allowNightAdvertisements = YES;   // 夜間広報性通知メッセージの受信同意

[NHNCloudPush registerWithAgreement:agreement
                  completionHandler:^(NHNCloudPushTokenInfo *tokenInfo, NSError *error) {

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
* トークン照会が成功すると、 [NHNCloudPushTokenInfo](./push-ios/#nhncloudpushtokeninfo) オブジェクトにトークン設定情報を返します。

### トークン情報照会API

``` objc
+ (void)queryTokenInfoWithCompletionHandler:(void (^)(NHNCloudPushTokenInfo * _Nullable tokenInfo, NSError * _Nullable error))completionHandler;
```

### トークン情報照会の例

``` objc
[NHNCloudPush queryTokenInfoWithCompletionHandler:^(NHNCloudPushTokenInfo *tokenInfo, NSError *error) {
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

* NHN Cloudクラウドサーバーに登録されたトークンを解除します。解除されたトークンはメッセージの送信対象から除外されます。
* `サービスログアウト後にメッセージの受信を希望しない場合、トークンを解除してください`
* `トークンが解除されても端末上の通知権限は回収されません。`

### トークン解除API

``` objc
+ (void)unregisterWithCompletionHandler:(nullable void (^)(NSString * _Nullable deviceToken, NSError * _Nullable error))completionHandler;
```

### トークン解除例

``` objc
[NHNCloudPush unregisterWithCompletionHandler:^(NSString *deviceToken, NSError *error) {
    if (error == nil) {
        // トークン解除成功
        NSLog(@"Successfully unregistered token : %@", deviceToken);

    } else {
        // トークン解除失敗
        NSLog(@"Failed to unregister : %@", error.localizedDescription);
    }
}];
```

## リッチメッセージ

* リッチメッセージは、通知のタイトル、本文とともにメディア(イメージ、ビデオ、オーディオ)を通知に表現し、ボタン、返信などのアクションを追加します。
* `リッチメッセージの受信は、iOS 10.0+ 以上からサポートします。`
* リッチメッセージの表示には、ユーザーアプリケーションにNHNCloudPushServiceExtensionを継承するNotification Service Extensionを実装する必要があります。(Notification Service Extensionの追加方法は、[Notification Service Extension](./push-ios/#notification-service-extension) セクションを参照)

### サポートするリッチメッセージ

#### ボタン

| タイプ | 機能 | アクション |
| --- | ------- | --- |
| アプリを開く(OPEN_APP) | アプリケーション実行 | NHNCloudPushNotificationActionOpenApp |
| URLを開く(OPEN_URL) | URLに移動<br/>(ウェブサイトのURL、またはアプリカスタムスキームを実行) | NHNCloudPushNotificationActionOpenURL |
| 返信(REPLY) | 通知から返信を転送 | NHNCloudPushNotificationActionReply |
| 取消(DISMISS) | 現在の通知を取消| NHNCloudtPushNotificationActionDismiss |

> ボタンは、メッセージあたり最大 3つまでサポートします。

#### メディア

| タイプ | サポートするフォーマット | 最大サイズ | 推奨事項 |
| --- | ------- | --- | --- |
| 画像 | JPEG, PNG, GIF | 10 MB | 横画像推奨<br>最大サイズ : 1038 x 1038 |
| 動画 | MPEG, MPEG3Video, MPEG4, AVIMovie | 50 MB |  |
| 音声 | WaveAudio, MP3, MPEG4Audio | 5 MB |  |

> ウェブURLを使用する場合は、メディアファイルのダウンロードに時間がかかります。

## 指標収集

* クライアントでPushメッセージの受信とユーザー通知実行に対する指標を収集して、NHN Cloudクラウドサーバーに送信します。
* 収集した内容は統計タブでご確認いただけます。
* `指標の収集のためには、Push SDKの初期化、あるいはinfo.plistファイルにAppKeyが定義されている必要があります。`

### 受信(Received)指標収集設定

* `受信指標の収集は、iOS 10.0+以上からサポートします。`
* 受信指標は、Notification Service Extensionに追加したNHN Cloud Push SDKで自動的に収集されます。
* 受信指標を収集には、ユーザーアプリケーションにNHNCloudPushServiceExtensionを継承するNotification Service Extensionを実装しなければなりません。(Notification Service Extension追加方法は、 [Notification Service Extension](./push-ios/#notification-service-extension)セクション参照)
* Notification Service Extensionの生成者で、[NHN Cloud Push SDK初期化](./push-ios/#nhn-cloud-push-sdk)、あるいは**エクステンションのinfo.plistファイル**にAppKeyが定義されていないと、受信指標の収集ができません。

#### 初期化による受信指標収集の設定例

* `アプリケーションとエクステンションは一緒にインストールされますが、分離した別々のサンドボックス環境であるため、アプリケーションの初期化とは別に、エスステンションでも初期化しなければなりません。`

``` objc
@implementation NotificationService

- (instancetype)init {
    self = [super init];

    if (self) {
        // 指標送信にのみ使用されるため、AppKeyのみ設定してください。
        NHNCloudPushConfiguration *configuration = [[NHNCloudPushConfiguration alloc] initWithAppKey:@"INPUT_YOUR_APPKEY"];

        [NHNCloudPush initWithConfiguration:configuration];
    }

    return self;
}

@end
```

#### info.plist定義による受信指標収集の設定例

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

### 実行(Opened)指標収集設定

* 実行指標は、アプリケーションに追加したNHN Cloud Push SDKから自動的に収集されます。
* [NHN Cloud Push SDK初期化](./push-ios/#nhn-cloud-push-sdk)、あるいは**アプリケーションのinfo.plistファイル**にAppKeyが定義されている場合、実行指標の収集が可能です。

#### info.plist定義による受信指標収集の設定例

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

* `iOS 10.0+からサポートします。`
* リッチメッセージ、受信指標を収集するためには、アプリケーションにNHNCloudPushServiceExtensionを継承する Notification Service Extension必ず実装してください。

### Notification Service Extensionの作成

* **File New > Target > iOS > Notification Service Extension**
![create_ext](https://static.toastoven.net/toastcloud/sdk/ios/push_create_ext_202206.png)

### Notification Service Extension設定

* アプリのプロジェクト設定と同様に、Extensionの[プロジェクト設定](./push-ios/#プロジェクト-設定)を追加します。
* `iOSのExtensionはアプリと一緒にインストールされますが、アプリとは分離された別のサンドボックス環境であるため、コンテナを共有することはできません。`

### Notification Service Extension設定例

* 作成したNotificationServiceクラスにNHNCloudPushServiceExtensionを継承する必要があります。
* ユーザー定義処理ロジックがない場合は、継承するだけでもリッチメッセージと受信指標の収集機能が動作します。

``` objc
#import <UserNotifications/UserNotifications.h>
#import <NHNCloudPush/NHNCloudPush.h>

@interface NotificationService : NHNCloudPushServiceExtension

@end
```

## ユーザー·タグ

* [ユーザー·タグ](/Notification/Push/ja/console-guide/#_16)能は、複数のユーザー IDをひとつのタグで結びつけ、それを活用してメッセージを送信することができます。
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
[NHNCloudPush addUserTagWithIdentifiers:tagIDs
                      completionHandler:^(NSSet<NSString *> *tagIdentifiers, NSError *error) {

    if (error == nil) {
        // タグIDリスト追加成功
    } else {
        // タグIDリスト追加失敗
    }
}];

// ログインされているユーザーIDのタグIDリストアップデート(既存のタグIDリストは削除され、入力した値で設定)
[NHNCloudPush setUserTagWithIdentifiers:tagIDs
                      completionHandler:^(NSError *error) {

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
[NHNCloudPush getUserTagWithCompletionHandler:^(NSSet<NSString *> *tagIdentifiers, NSError *error) {
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
[NHNCloudPush removeUserTagWithIdentifiers:tagIDs
                         completionHandler:^(NSSet<NSString *> *tagIdentifiers, NSError *error) {
    if (error == nil) {
        // タグIDリスト削除成功
    } else {
        // タグIDリスト削除失敗
    }
}];

// ログインされているユーザーIDの全タグIDリスト削除
[NHNCloudPush removeAllUserTagWithCompletionHandler:^(NSError *error) {
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

* NHN Cloud PushのVoIP機能を使うには、**PushKit.framework**、**CallKit.framework**を追加する必要があります。
* PushKit.framework、CallKit.frameworkは以下の方法で追加できます。
![linked_pushkit_frameworks](https://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_PushKit_202206.png)
![linked_callkit_frameworks](https://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_CallKit_202206.png)
![linked_frameworks_push](https://static.toastoven.net/toastcloud/sdk/ios/push_link_frameworks_push_202206.png)

### Capabilities設定

* **Project Target > Signing & Capabilities > + Capability > Background Modes**
![add_capability_background_modes](https://static.toastoven.net/toastcloud/sdk/ios/add_capability_background_modes_202206.png)

* **Voice over IP**項目を有効化する必要があります。
![capabilities](https://static.toastoven.net/toastcloud/sdk/ios/push_capabilities_voip_202206.png)

### 初期化

* VoIP機能は[NHN Cloud Push SDK 初期化](./push-ios/#nhn-cloud-push-sdk)がされていなければ使用できません。
* VoIP機能はNHN Cloud Push SDKのサブモジュールで別途分離されています。

### Delegate設定

* VoIPメッセージを受信すると、[NHNCloudPushMessage](./push-ios/#nhncloudpushmessage)オブジェクトで受信したメッセージの内容が伝達されます。
* `スムーズにメッセージを受信するために application:didFinishLaunchingWithOptions: 関数でDelegate設定をお勧めします。`

#### Delegate API

``` objc
@protocol NHNCloudVoIPDelegate <NSObject>

// メッセージ受信
- (void)didReceiveIncomingVoiceCallWithMessage:(NHNCloudPushMessage *)message;

@end
```

#### Delegate設定例

``` objc
// VoIPサブモジュールを追加します。
#import <NHNCloudPush/NHNCloudVoIP.h>

@interface AppDelegate () <UIApplicationDelegate, NHNCloudVoIPDelegate>

@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // ...

    // Delegatを設定します。
    [NHNCloudVoIP setDelegate:self];

    return YES;
}

#pragma mark - NHNCloudVoIPDelegate
// メッセージ受信
- (void)didReceiveIncomingVoiceCallWithMessage:(NHNCloudPushMessage *)message {
    // ...
}
```

### トークン登録

* 発行されたVoIPトークン情報をNHN Cloudクラウドサーバに登録します。
* VoIP機能は別途ユーザー権限あるいは同意情報は必要ありません。

#### トークン登録API

```objc
+ (void)registerWithCompletionHandler:(nullable void (^)(NHNCloudPushTokenInfo * _Nullable tokenInfo, NSError * _Nullable error))completionHandler;
```

#### トークン登録例

```objc
[NHNCloudVoIP registerWithCompletionHandler:^(NHNCloudPushTokenInfo *tokenInfo, NSError *error) {
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
* トークン照会情報に成功すると、[NHNCloudPushTokenInfo](./push-ios/#nhncloudpushtokeninfo)オブジェクトにトークンの設定情報が返されます。

#### トークン情報照会API

```objc
@interface NHNCloudVoIP : NSObject
+ (void)queryTokenInfoWithCompletionHandler:(void (^)(NHNCloudPushTokenInfo * _Nullable tokenInfo, NSError * _Nullable error))completionHandler;
```

#### トークン情報照会例

```objc
[NHNCloudVoIP queryTokenInfoWithCompletionHandler:^(NHNCloudPushTokenInfo *tokenInfo, NSError *error) {
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

* NHN Cloudクラウドサーバーに登録されたトークンを解除します。 解除されたトークンは、メッセージの送信対象から除外されます。
* `サービスログアウト後にメッセージの受信を希望されない場合、トークンを解除してください。`

#### トークン解除API

```objc
+ (void)unregisterWithCompletionHandler:(nullable void (^)(NSString * _Nullable deviceToken, NSError * _Nullable error))completionHandler;
```

#### トークン解除例

```objc
[NHNCloudVoIP unregisterWithCompletionHandler:^(NSString *deviceToken, NSError *error) {
    if (error == nil) {
        // トークン解除成功
        NSLog(@"Successfully unregistered token : %@", deviceToken);

    } else {
        // トークン解除失敗
        NSLog(@"Failed to unregister : %@", error.localizedDescription);
    }
}];
```

## エラー·コード

### Push機能エラーコード
```objc
extern NSErrorDomain const NHNCloudPushErrorDomain;

typedef NS_ERROR_ENUM(NHNCloudPushErrorDomain, NHNCloudPushError) {
    NHNCloudPushErrorUnknown = 0,              // 不明
    NHNCloudPushErrorNotInitialized = 1,       // 初期化していない
    NHNCloudPushErrorUserInvalid = 2,          // ユーザーID未設定
    NHNCloudPushErrorPermissionDenied = 3,     // 権限獲得失敗
    NHNCloudPushErrorSystemFailed = 4,         // システムによる失敗
    NHNCloudPushErrorTokenInvalid = 5,         // トークン値がないか、無効
    NHNCloudPushErrorAlreadyInProgress = 6,    // すでに進行中
    NHNCloudPushErrorParameterInvalid = 7,     // 無効な変数
    NHNCloudPushErrorNotSupported = 8,         // サポートしていない機能
};
```

### ネットワークエラーコード
``` objc
extern NSErrorDomain const NHNCloudHttpErrorDomain;

typedef NS_ERROR_ENUM(NHNCloudHttpErrorDomain, NHNCloudHttpError) {
    NHNCloudHHttpErrorNetworkNotAvailable = 100,        // ネットワーク使用不可
    NHNCloudHHttpErrorRequestFailed = 101,              // HTTP Status Codeが200でない、あるいはサーバーで要求を正しく読み取れない
    NHNCloudHHttpErrorRequestTimeout = 102,             // タイムアウト
    NHNCloudHHttpErrorRequestInvalid = 103,             // 誤ったリクエスト (パラメーターエラーなど)
    NHNCloudHHttpErrorURLInvalid = 104,                 // URLエラー
    NHNCloudHHttpErrorResponseInvalid = 105,            // サーバー応答エラー
    NHNCloudHHttpErrorAlreadyInprogress = 106,          // 同一リクエストですでに実行中
    NHNCloudHHttpErrorRequiresSecureConnection = 107,   // Allow Arbitrary Loads未設定
};
```

## NHN Cloud Push Class Reference

### NHNCloudPushConfiguration
* NHN Cloud Pushを初期化する際に配信されるPush設定情報です。

``` objc
@interface NHNCloudPushConfiguration : NSObject

// サービスAppKey
@property (nonatomic, copy, readonly) NSString *appKey;

// サービスゾーン
@property (nonatomic) NHNCloudServiceZone serviceZone;

// 国コード (予約メッセージ送信時、基準時間となる国コード)
@property (nonatomic, copy) NSString *countryCode;

// 言語コード（多言語メッセージ送信時の言語選択基準）
@property (nonatomic, copy) NSString *languageCode;

// タイムゾーン
@property (nonatomic, copy) NSString *timezone;

// Sandbox(Debug)環境設定
@property (nonatomic) BOOL sandbox;

// ユーザーが通知許可権限を拒否しても、トークンを登録するかどうか
@property (nonatomic) BOOL alwaysAllowTokenRegistration;


+ (instancetype)configurationWithAppKey:(NSString *)appKey;

- (instancetype)initWithAppKey:(NSString *)appKey;

@end
```

### NHNCloudNotificationOptions
* NHN Cloud Pushを初期化する際に配信される通知設定情報です。

``` objc
@interface NHNCloudNotificationOptions : NSObject

// アプリ実行中に通知に表示するか
@property (nonatomic) BOOL foregroundEnabled;

// バッジアイコンを使用するか
@property (nonatomic) BOOL badgeEnabled;

// 通知音を使用するか
@property (nonatomic) BOOL soundEnabled;

@end
```


### NHNCloudPushAgreement

``` objc
@interface NHNCloudPushAgreement : NSObject

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

### NHNCloudPushMessage
* メッセージの受信時に返されるオブジェクトです。

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
* 受信したメッセージの内容のうち、リッチメッセージの内容を含むオブジェクトです。

```objc
@interface NHNCloudPushRichMessage : NSObject

@property (nonatomic, readonly, nullable) NHNCloudPushMedia *media;

@property (nonatomic, readonly, nullable) NSArray<NHNCloudPushButton *> *buttons;

@end
```

### NHNCloudPushMedia
* 受信したリッチメッセージの中で、メディアの内容を含むオブジェクトです。

```objc
@interface NHNCloudPushMedia : NSObject

@property (nonatomic, readonly) NHNCloudPushMediaType mediaType;

@property (nonatomic, readonly) NSString *source;

@end
```

### NHNCloudPushButton
* 受信したリッチメッセージの内容のうち、ボタンの内容を含むオブジェクトです。

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
* 通知アクション（ボタン、返信）受信時に返されるオブジェクトです。

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
* トークン情報の照会リクエスト時に返されるトークン情報オブジェクトです。
``` objc
typedef NSString *NHNCloudPushType NS_STRING_ENUM;
// APNSタイプ
extern NHNCloudPushType const NHNCloudPushTypeAPNS;
// VoIPタイプ
extern NHNCloudPushType const NHNCloudPushTypeVoIP;


@interface NHNCloudPushTokenInfo : NSObject

// ユーザーID
@property (nonatomic, readonly) NSString *userID;

// トークン
@property (nonatomic, readonly) NSString *deviceToken;

// 国コード
@property (nonatomic, readonly) NSString *countryCode;

// 言語設定
@property (nonatomic, readonly) NSString *languageCode;

// Pushトークンタイプ
@property (nonatomic, readonly) NHNCloudPushType pushType;

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
