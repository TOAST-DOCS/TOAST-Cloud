## NHN Cloud > SDK使用ガイド > 開始する > iOS

## サポート環境

* iOS 9.0以上
* XCode最新バージョン(バージョン13以上)

## NHN Cloud SDKの構成

* iOS用NHN Cloud SDKの構成は次のとおりです。
    * [Logger](./log-collector-ios) SDK
    * [In-app Purchase AppStore](./iap-ios) SDK
    * [Push](./push-ios) SDK
     [OCR](./creditcard-recognizer-ios) SDK

* NHN Cloud SDKが提供するサービスの中から、希望する機能を選択して適用できます。

| Service | Cocoapods Pod Name | Carthage | Framework | Deployment Target | Dependency | Build Settings |
| --- | --- | --- | --- | --- | --- | --- |
| All | NHNCloudSDK | binary "[https://nh.nu/nhncloudsdk](https://nh.nu/nhncloudsdk) | NHNCloudCore.framework<br>NHNCloudCommon.framework<br>NHNCloudLogger.framework<br>NHNCloudIAP.framework<br>NHNCloudPush.framework |  |  |  |
| Mandatory | NHNCloudCore<br>NHNCloudCommon |  | NHNCloudCore.framework<br>NHNCloudCommon.framework | 9.0 |  | OTHER\_LDFLAGS = (<br>"-ObjC",<br>"-lc++"<br>); |
| Log & Crash | NHNCloudLogger |  | NHNCloudLogger.framework | 9.0 | [External & Optional]<br>\* CrashReporter.framework (NHNCloud) |  |
| IAP | NHNCloudIAP |  | NHNCloudIAP.framework | 9.0 | \* StoreKit.framework<br><br>[Optional]<br>\* libsqlite3.tdb |  |
| Push | NHNCloudPush |  | NHNCloudPush.framework | 9.0 | \* UserNotifications.framework<br><br>[Optional]<br>\* PushKit.framework |  |
| OCR | NHNCloudOCR |  | NHNCloudOCR.framework | 11.0 | \* Vision.framework<br>\* AVFoundation.framework |  |

## NHN Cloud SDKをXcodeプロジェクトに適用

### 1. Cococapodsを使用してNHN Cloud SDK適用

* Podfileを作成してNHN Cloud SDKのPodを追加します。

```podspec
platform :ios, '11.0'
use_frameworks!

target '{YOUR PROJECT TARGET NAME}' do
    pod 'NHNCloudSDK'
end
```

### 2. Swift Package Managerを使用してNHN Cloud SDK適用

* XCodeで**File > Add Packages...**メニューを選択します。
* Package URLに'https://github.com/nhn/nhncloud.ios.sdk'を入れて**Add Package**ボタンを選択します。
* 追加したいLibraryを選択します。

![swift_package_manager](https://static.toastoven.net/toastcloud/sdk/ios/swiftpackagemanager01.png)

#### プロジェクト設定

* **Build Settings**の **Other Linker Flags**に**-lc++**と**-ObjC**項目を追加します。
    * **Project Target > Build Settings > Linking > Other Linker Flags**
![other_linker_flags](https://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags_202206.png)

### 3. Carthageを使用してNHN Cloud SDK適用

* Cartfileを作成してNHN Cloud SDKを追加します。

```sh
# Full URL
binary "https://api-storage.cloud.toast.com/v1/AUTH_f9e3dc598ca142d3820e1c19343d5428/carthage/NHNCloudSDK.json"

# Short URL
binary "https://nh.nu/nhncloudsdk"
```

* 作成されたCarthage/BuildフォルダのFrameworkをXcodeプロジェクトに追加します。  
![carthage_import_framework](https://static.toastoven.net/toastcloud/sdk/ios/carthage01_202206.png)

* プロジェクトに次のようにフレームワーク(framework)が追加されたことを確認します。
![import_carthage_frameworks_complete](https://static.toastoven.net/toastcloud/sdk/ios/carthage02_202206.png)
![import_carthage_frameworks_complete](https://static.toastoven.net/toastcloud/sdk/ios/carthage03_202206.png)

* NHN Cloud SDKを使用するために**フレームワーク設定**と**プロジェクト設定**を行う必要があります。

> サービスのいずれかの機能を選択して使用するには、サービスごとに必要なFrameworkのみ選択してプロジェクトに追加する必要があります。
> サービスごとに必要なFrameworkは[NHN Cloud SDKの構成](./getting-started-ios/#toast-sdk)で確認できます。  

### 4. バイナリをダウンロードしてNHN Cloud SDK適用

#### Link Frameworks

* NHN Cloudの[Downloads](../../../Download/#toast-sdk)ページで全体iOS SDKをダウンロードできます。
![import_frameworks](https://static.toastoven.net/toastcloud/sdk/ios/overview_import_frameworks_folder_202206.png)

* NHN Cloud LoggerのCrash Report機能を使用するには、一緒に配布されるCrashReporter.frameworkもプロジェクトに追加する必要があります。
![import_external_framework](https://static.toastoven.net/toastcloud/sdk/ios/overview_import_external_folder_202206.png)

* プロジェクトに次のようにフレームワーク(framework)が追加されたことを確認します。
![import_frameworks_complete](https://static.toastoven.net/toastcloud/sdk/ios/overview_import_complete_folder_202206.png)

* IAP機能を使用するには、StoreKit.frameworkを追加する必要があります。
![linked__storekit_frameworks](https://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_StoreKit_202206.png)

* Push機能を使用するには、UserNotifications.frameworkを追加する必要があります。
![linked__usernotifications_frameworks](https://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_UserNotifications_202206.png)

##### xcframework
* xcframeworkを使用するとarm simulatorでもNHN Cloud SDKを使用できます。
![xcframework01](https://static.toastoven.net/toastcloud/sdk/ios/xcframework01_202206.png)
![xcframework01](https://static.toastoven.net/toastcloud/sdk/ios/xcframework02_202206.png)

#### Project Settings

* **Build Settings**の**Other Linker Flags**に**-lc++**と**-ObjC**項目を追加します。
    * **Project Target > Build Settings > Linking > Other Linker Flags**
![other_linker_flags](https://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags_202206.png)

* **CrashReporter.framework**を直接ダウンロードするか、ビルドした場合は**Build Settings**の**Enable Bitcode**の値を**NO**に変更する必要があります。
    * **Project Target > Build Settings > Build Options > Enable Bitcode**
![enable_bitcode](https://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags_202206.png)
> NHN Cloud SDKの[Downloads](../../../Download/#toast-sdk)ページでダウンロードしたCrashReporter.frameworkは、bitCodeをサポートします。

### フレームワークのインポート

* 使用するフレームワークをインポートします(import)。

```objc
#import <NHNCloudCore/NHNCloudCore.h>
#import <NHNCloudLogger/NHNCloudLogger.h>
#import <NHNCloudIAP/NHNCloudIAP.h>
#import <NHNCloudPush/NHNCloudPush.h>
#import <NHNCloudOCR/NHNCloudOCR.h>
```

## UserID設定

* NHN Cloud SDKにユーザーIDを設定できます。
* 設定したUserIDは、NHN Cloud SDKの各モジュールで共通使用されます。
* NHN Cloud SDK Loggerのログ送信APIを呼び出すたびに、設定したユーザーIDをログと一緒にサーバーに送信します。

### UserID API仕様

```objc
+ (void)setUserID:(NSString *)userID;
```

### UserID設定使用例

```objc
[NHNCloudSDK setUserID:@"NHNCloud-USER"];
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
[NHNCloudSDK setDebugMode:YES];    // or NO
```

> [注意]アプリをリリースする場合、デバッグモードを無効化する必要があります。

## NHN Cloud SDK Service使用

* [Log & Crash](./log-collector-ios)使用ガイド
* [In-app Purchase](./iap-ios)使用ガイド
* [Push](./push-ios)使用ガイド
* [OCR](./creditcard-recognizer-ios)使用ガイド
