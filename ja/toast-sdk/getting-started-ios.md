## NHN Cloud > NHN Cloud SDK使用ガイド > 開始する > iOS

## サポート環境

* iOS 9.0以上
* XCode最新バージョン(バージョン10以上)

## NHN Cloud SDKの構成

* iOS用NHN Cloud SDKの構成は次のとおりです。
    * [NHN Cloud Logger](./log-collector-ios) SDK
    * [NHN Cloud In-app Purchase AppStore](./iap-ios) SDK
    * [NHN Cloud Push](./push-ios) SDK

* NHN Cloud SDKが提供するサービスの中から、希望する機能を選択して適用できます。

| Service | Cocoapods Pod Name | Carthage | Framework | Dependency | Build Settings |
| ------- | ------------------ | -------- | --------- | ---------- | -------------- |
| All | NHN CloudSDK | github nhn/toastcloud.sdk<br> | ToastCore.framework<br>ToastCommon.framework<br>ToastLogger.framework<br>ToastIAP.framework<br>ToastPush.framework |  |  |
| Mandatory | NHN CloudCore<br>NHN CloudCommon |  | ToastCore.framework<br>ToastCommon.framework |  | OTHER\_LDFLAGS = (<br>"-ObjC",<br>"-lc++"<br>); |
| NHN Cloud Log & Crash | NHN CloudLogger |  | ToastLogger.framework | [External & Optional]<br>\* CrashReporter.framework (Toast) |  |
| NHN Cloud IAP | NHN CloudIAP |  | ToastIAP.framework | \* StoreKit.framework<br><br>[Optional]<br>\* libsqlite3.tdb |  |
| NHN Cloud Push | NHN CloudPush |  | ToastPush.framework | \* UserNotifications.framework<br><br>[Optional]<br>\* PushKit.framework |  |

## NHN Cloud SDKをXcodeプロジェクトに適用

### 1. Cococapodsを使用してNHN Cloud SDK適用

* Podfileを作成してNHN Cloud SDKのPodを追加します。

```podspec
platform :ios, '9.0'
use_frameworks!

target '{YOUR PROJECT TARGET NAME}' do
    pod 'ToastSDK'
end
```

### 2. Carthage를 사용해 NHN Cloud SDK 적용

* Cartfile을 생성하여 NHN Cloud SDK의 Release Github Repository를 추가합니다.
```
github "nhn/toastcloud.sdk"
```

* 생성된 Carthage/Build 폴더의 Framework를 Xcode 프로젝트에 추가합니다. 
![carthage_import_framework](http://static.toastoven.net/toastcloud/sdk/ios/carthage_setting_01.png)

* 프로젝트에 다음과 같이 프레임워크(framework)가 추가된 것을 확인합니다.
![import_carthage_frameworks_complete](http://static.toastoven.net/toastcloud/sdk/ios/carthage_setting_02.png)

* NHN Cloud SDK를 사용하기 위해 **프레임워크 설정**과 **프로젝트 설정**을 해야합니다.

> 서비스 중 원하는 기능을 선택하여 사용하기 위해서는 서비스별로 필요한 Framework만 선택하여 프로젝트에 추가해야 합니다.
> 서비스별로 필요한 Framework는 [NHN Cloud SDK의 구성](./getting-started-ios/#toast-sdk)에서 확인 할 수 있습니다. 

### 3. バイナリをダウンロードしてNHN Cloud SDK適用

#### Link Frameworks

* NHN Cloudの[Downloads](../../../Download/#toast-sdk)ページで全体iOS SDKをダウンロードできます。
![import_frameworks](http://static.toastoven.net/toastcloud/sdk/ios/overview_import_frameworks_folder.png)

* NHN Cloud LoggerのCrash Report機能を使用するには、一緒に配布されるCrashReporter.frameworkもプロジェクトに追加する必要があります。
![import_external_framework](http://static.toastoven.net/toastcloud/sdk/ios/overview_import_external_folder.png)

* プロジェクトに次のようにフレームワーク(framework)が追加されたことを確認します。
![import_frameworks_complete](http://static.toastoven.net/toastcloud/sdk/ios/overview_import_complete_folder.png)

* NHN Cloud IAP機能を使用するには、StoreKit.frameworkを追加する必要があります。
![linked__storekit_frameworks](http://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_StoreKit.png)

* NHN Cloud Push機能を使用するには、UserNotifications.frameworkを追加する必要があります。
![linked__usernotifications_frameworks](http://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_UserNotifications.png)


#### Project Settings

* **Build Settings**の**Other Linker Flags**に**-lc++**と**-ObjC**項目を追加します。
    * **Project Target > Build Settings > Linking > Other Linker Flags**
![other_linker_flags](http://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags.png)

* **CrashReporter.framewor**を直接ダウンロードするか、ビルドした場合は**Build Settings**の**Enable Bitcode**の値を**NO**に変更する必要があります。
    * **Project Target > Build Settings > Build Options > Enable Bitcode**
![enable_bitcode](http://static.toastoven.net/toastcloud/sdk/ios/overview_settings_bitcode.png)
> NHN Cloudの[Downloads](../../../Download/#toast-sdk)ページでダウンロードしたCrashReporter.frameworkは、bitCodeをサポートします。

### フレームワークのインポート

* 使用するフレームワークをインポートします(import)。

```objc
#import <ToastCore/ToastCore.h>
#import <ToastLogger/ToastLogger.h>
#import <ToastIAP/ToastIAP.h>
#import <ToastPush/ToastPush.h>
```

## UserID設定

* TOASAT SDKにユーザーIDを設定できます。
* 設定したUserIDは、NHN Cloud SDKの各モジュールで共通使用されます。
* NHN Cloud Loggerのログ送信APIを呼び出すたびに、設定したユーザーIDをログと一緒にサーバーに送信します。

### UserID API仕様

```objc
+ (void)setUserID:(NSString *)userID;
```

### UserID設定使用例

```objc
[ToastSDK setUserID:@"TOAST-USER"];
```
## デバッグモード設定

* NHN Cloud SDKの内部ログを確認するために、デバッグモードを設定できます。
* NHN Cloud SDKに関するお問い合わせの際は、デバッグモードを有効にしていただくと、迅速にサポートできます。

### デバッグモード設定API仕様


```objc
+ (void)setDebugMode:(BOOL)debugMode;
```

### デバッグモード設定使用例

```objc
[NHN CloudSDK setDebugMode:YES];    // or NO
```

> [注意]アプリをリリースする場合、デバッグモードを無効化する必要があります。

## NHN Cloud Service使用

* [NHN Cloud Log & Crash](./log-collector-ios)使用ガイド
* [NHN Cloud In-app Purchase](./iap-ios)使用ガイド
* [NHN Cloud Push](./push-ios)使用ガイド
