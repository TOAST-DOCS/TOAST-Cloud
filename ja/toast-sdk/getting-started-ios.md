## TOAST > TOAST SDK使用ガイド > 開始する > iOS 
 
## サポート環境 
 
* iOS 9.0以上 
* XCode最新バージョン(バージョン10以上) 
 
## TOAST SDKの構成 
 
* iOS用TOAST SDKの構成は次のとおりです。 
    * [TOAST Logger](./log-collector-ios) SDK 
    * [TOAST In-app Purchase AppStore](./iap-ios) SDK 
    * [TOAST Push](./push-ios) SDK 
 
* TOAST SDKが提供するサービスの中から、希望する機能を選択して適用できます。 
 
| Service | Cocoapods Pod Name | Carthage | Framework | Dependency | Build Settings | 
| ------- | ------------------ | -------- | --------- | ---------- | -------------- | 
| All | ToastSDK | binary "https://nh.nu/toast" | ToastCore.framework<br>ToastCommon.framework<br>ToastLogger.framework<br>ToastIAP.framework<br>ToastPush.framework |  |  | 
| Mandatory | ToastCore<br>ToastCommon |  | ToastCore.framework<br>ToastCommon.framework |  | OTHER\_LDFLAGS = (<br>"-ObjC",<br>"-lc++"<br>); | 
| TOAST Log & Crash | ToastLogger |  | ToastLogger.framework | [External & Optional]<br>\* CrashReporter.framework (Toast) |  | 
| TOAST IAP | ToastIAP |  | ToastIAP.framework | \* StoreKit.framework<br><br>[Optional]<br>\* libsqlite3.tdb |  | 
| TOAST Push | ToastPush |  | ToastPush.framework | \* UserNotifications.framework<br><br>[Optional]<br>\* PushKit.framework |  | 
 
## TOAST SDKをXcodeプロジェクトに適用 
 
### 1. Cococapodsを使用してTOAST SDK適用 
 
* Podfileを作成してTOAST SDKのPodを追加します。 
 
```podspec 
platform :ios, '9.0' 
use_frameworks! 
 
target '{YOUR PROJECT TARGET NAME}' do 
    pod 'ToastSDK' 
end 
``` 
 
### 2. Carthageを使用してTOAST SDK適用
 
* Cartfileを作成してTOAST SDKを追加します。

```sh
# Full URL
binary "https://api-storage.cloud.toast.com/v1/AUTH_f9e3dc598ca142d3820e1c19343d5428/carthage/ToastSDK.json" 

# Short URL 
binary "https://nh.nu/toast"
```
 
* 作成されたCarthage/BuildフォルダのFrameworkをXcodeプロジェクトに追加します。  
![carthage_import_framework](http://static.toastoven.net/toastcloud/sdk/ios/carthage01.png) 
 
* プロジェクトに次のようにフレームワーク(framework)が追加されたことを確認します。 
![import_carthage_frameworks_complete](http://static.toastoven.net/toastcloud/sdk/ios/carthage02.png) 
![import_carthage_frameworks_complete](http://static.toastoven.net/toastcloud/sdk/ios/carthage03.png)
 
* TOAST SDKを使用するために**フレームワーク設定**と**プロジェクト設定**を行う必要があります。
 
> サービスのいずれかの機能を選択して使用するには、サービスごとに必要なFrameworkのみ選択してプロジェクトに追加する必要があります。 
> サービスごとに必要なFrameworkは[TOAST SDKの構成](./getting-started-ios/#toast-sdk)で確認できます。  
 
### 3. バイナリをダウンロードしてTOAST SDK適用 
 
#### Link Frameworks 
 
* TOASTの[Downloads](../../../Download/#toast-sdk)ページで全体iOS SDKをダウンロードできます。 
![import_frameworks](http://static.toastoven.net/toastcloud/sdk/ios/overview_import_frameworks_folder.png) 
 
* TOAST LoggerのCrash Report機能を使用するには、一緒に配布されるCrashReporter.frameworkもプロジェクトに追加する必要があります。 
![import_external_framework](http://static.toastoven.net/toastcloud/sdk/ios/overview_import_external_folder.png) 
 
* プロジェクトに次のようにフレームワーク(framework)が追加されたことを確認します。 
![import_frameworks_complete](http://static.toastoven.net/toastcloud/sdk/ios/overview_import_complete_folder.png) 
 
* TOAST IAP機能を使用するには、StoreKit.frameworkを追加する必要があります。 
![linked__storekit_frameworks](http://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_StoreKit.png) 
 
* TOAST Push機能を使用するには、UserNotifications.frameworkを追加する必要があります。 
![linked__usernotifications_frameworks](http://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_UserNotifications.png) 
 
##### xcframework
* xcframeworkを使用するとarm simulatorでもToastSDKを使用できます。
![xcframework01](http://static.toastoven.net/toastcloud/sdk/ios/xcframework01.png)
![xcframework01](http://static.toastoven.net/toastcloud/sdk/ios/xcframework02.png)

#### Project Settings 
 
* **Build Settings**の**Other Linker Flags**に**-lc++**と**-ObjC**項目を追加します。 
    * **Project Target > Build Settings > Linking > Other Linker Flags** 
![other_linker_flags](http://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags.png) 
 
* **CrashReporter.framewor**を直接ダウンロードするか、ビルドした場合は**Build Settings**の**Enable Bitcode**の値を**NO**に変更する必要があります。 
    * **Project Target > Build Settings > Build Options > Enable Bitcode** 
![enable_bitcode](http://static.toastoven.net/toastcloud/sdk/ios/overview_settings_bitcode.png) 
> TOASTの[Downloads](../../../Download/#toast-sdk)ページでダウンロードしたCrashReporter.frameworkは、bitCodeをサポートします。 
 
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
* 設定したUserIDは、TOAST SDKの各モジュールで共通使用されます。 
* TOAST Loggerのログ送信APIを呼び出すたびに、設定したユーザーIDをログと一緒にサーバーに送信します。 
 
### UserID API仕様 
 
```objc 
+ (void)setUserID:(NSString *)userID; 
``` 
 
### UserID設定使用例 
 
```objc 
[ToastSDK setUserID:@"TOAST-USER"]; 
``` 
## デバッグモード設定 
 
* TOAST SDKの内部ログを確認するために、デバッグモードを設定できます。 
* TOAST SDKに関するお問い合わせの際は、デバッグモードを有効にしていただくと、迅速にサポートできます。 
 
### デバッグモード設定API仕様 
 
 
```objc 
+ (void)setDebugMode:(BOOL)debugMode; 
``` 
 
### デバッグモード設定使用例 
 
```objc 
[ToastSDK setDebugMode:YES];    // or NO 
``` 
 
> [注意]アプリをリリースする場合、デバッグモードを無効化する必要があります。 
 
## TOAST Service使用 
 
* [TOAST Log & Crash](./log-collector-ios)使用ガイド 
* [TOAST In-app Purchase](./iap-ios)使用ガイド 
* [TOAST Push](./push-ios)使用ガイド 
