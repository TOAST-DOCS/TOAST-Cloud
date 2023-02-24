## NHN Cloud > SDK使用ガイド > Log & Crash > iOS

## Prerequisites

1. [NHN Cloud SDK](./getting-started-ios)をインストールします。
2. [NHN Cloudコンソール](https://console.nhncloud.com)で、[Log & Crash Searchを有効化](https://docs.nhncloud.com/ja/Data%20&%20Analytics/Log%20&%20Crash%20Search/ja/console-guide/)します。
3. Log & Crash Searchで、[AppKeyを確認](https://docs.nhncloud.com/ja/Data%20&%20Analytics/Log%20&%20Crash%20Search/ja/console-guide/#appkey)します。

## NHN Cloud Logger構成

* iOS用NHN Cloud Logger SDKの構成は次のとおりです。

| Service  | Cocoapods Pod Name | Framework | Dependency | Build Settings |
| --- | --- | --- | --- | --- |
| Log & Crash | NHNCloudLogger | NHNCloudLogger.framework | [External & Optional]<br/> * CrashReporter.framework (NHNCloud) |  |
| Mandatory   | NHNCloudCore<br/>NHNCloudCommon | NHNCloudCore.framework<br/>NHNCloudCommon.framework | | OTHER_LDFLAGS = (<br/>    "-ObjC",<br/>    "-lc++" <br/>); |

## NHN Cloud Logger SDKをXcodeプロジェクトに適用

### 1. Cococapods適用

* Podfileを作成して、Log & Crash SDKに対するpodを追加します。

```podspec
platform :ios, '9.0'
use_frameworks!

target '{YOUR PROJECT TARGET NAME}' do
    pod 'NHNCloudLogger'
end
```

### 2. バイナリをダウンロードしてNHN Cloud SDK適用

#### Link Frameworks

* NHN Cloudの[Downloads](../../../Download/#toast-sdk)ページで、全体iOS SDKをダウンロードできます。
* Xcode Projectに**NHNCloudLogger.framework**, **NHNCloudCore.framework**, **NHNCloudCommon.framework**を追加します。
* NHN Cloud LoggerのCrash Report機能を使用するには、一緒に配布される**CrashReporter.framework**もプロジェクトに追加する必要があります。
![linked_frameworks_logger](https://static.toastoven.net/toastcloud/sdk/ios/logger_link_frameworks_logger_202206.png)

#### Project Settings

* **Build Settings**の**Other Linker Flags**に**-lc++**と**-ObjC**項目を追加します。
    * **Project Target > Build Settings > Linking > Other Linker Flags**
![other_linker_flags](https://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags_202206.png)

* **CrashReporter.framewor**を直接ダウンロードするか、ビルドした場合は**Build Settings**の**Enable Bitcode**の値を**NO**に変更する必要があります。
    * **Project Target > Build Settings > Build Options > Enable Bitcode**
![enable_bitcode](https://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags_202206.png)
> NHN Cloudの[Downloads](../../../Download/#toast-sdk)ページでダウンロードしたCrashReporter.frameworkは、bitCodeをサポートします。

## NHN Cloud Symbol Uploader適用

### プロジェクトのデバッグ設定を変更
* ビルド設定を変更してプロジェクトのデバッグ情報形式を変更する必要があります。
* Xcode -> Project Target -> Build Settings -> Debug Information Format -> Debug -> DWARF with dSYM File

### 開発環境でRun Scriptを使用して自動アップロード

* Xcode -> Project Target -> Build Phases -> + -> New Run Script Phase
* 表示される新しいRun Scriptセクションを展開します。
* Shell(シェル)フィールドの下にあるスクリプトフィールドで新しい実行スクリプトを追加します。
```
if [ "${CONFIGURATION}" = "Debug" ]; then
    ${PODS_ROOT}/NHNCloudSymbolUploader/nhncloud.ios.sdk-*/run --app-key LOG_N_CRASH_SEARCH_DEV_APPKEY
fi
```
* LOG_N_CRASH_SEARCH_APPKEYにはLog & Crash SearchのAppKeyを入力する必要があります。
* Run Scriptセクションの下にあるInput FilesにdSYMの基本パスを設定します。
    * ${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}/Contents/Resources/DWARF/${TARGET_NAME}

![symbol_uploader_script_pods_path](https://static.toastoven.net/toastcloud/sdk/ios/symbol_uploader_guide_script_pods_path_202206.png)

### Symbol Uploaderを使用して直接アップロード

* SymbolUploaderの使い方

```
USAGE: symbol-uploader -ak <ak> -pv <pv> [-sz <sz>] <path> [--verbose]

ARGUMENTS:
  <path>                  dSYM file path is must be entered. 

OPTIONS:
  -ak, --app-key <ak>     [Log&Crash Search]'s AppKey must be entered. 
  -pv, --project-version <pv>
                          Project version must be entered. 
  -sz, --service-zone <sz>
                          You can choose between real, alpha, and demo. (default: real)
  --verbose               Show more debugging information 
  -h, --help              Show help information.

```

* XcodeのRun Scriptを使用せずにユーザーが任意の時点で、次のような方法でSymbolUploaderを使用して直接Symbolをアップロードできます。

```
./SymbolUploader --app-key {APP_KEY} --project-version {CFBundleShortVersionString || MARKETING_VERSION} {symbol path(~/Project.dSYM)}
```

> `同じバージョンのSymbolがすでにアップロードされている場合、SymbolUploaderはアップロードされているSymbolを削除してアップロードを実行します。`
> この時、2つのSymbolファイルの`ファイル名が異なる場合、アップロードされていたSymbolは削除されません。`
> Log & Crash SearchコンソールからアップロードされているSymbolを削除する必要があります。
> https://console.nhncloud.com/→組織選択→プロジェクト選択→ Anaytics → Log & Crash Search →設定→シンボルファイル

### CrashReport 使用時注意事項

* arm64eアーキテクチャを使用する機器のクラッシュ・分析のためにはNHN Cloud Loggerと一緒に配布されるPLCrashReporterを使用しなければなりません。
      * NHN Cloudの[Downloads](../../../Download/#toast-sdk)ページではない他の場所でダウンロードしたり、直接ビルドしたPLCrashReporterを使用する場合、arm64eアーキテクチャを使用する機器のクラッシュ分析が不可能です。

## NHN Cloud Logger SDK初期化

* Log & Crash Searchで発行されたAppKeyを設定します。

### 初期化API仕様

``` objc
// 初期化
+ (void)initWithConfiguration:(NHNCloudLoggerConfiguration *)configuration;
```

### 初期化プロセス例

```objc
NHNCloudLoggerConfiguration *configuration = [NHNCloudLoggerConfiguration configurationWithAppKey:@"YOUR_APP_KEY"];
[NHNCloudLogger initWithConfiguration:configuration];
```

## ログ送信

* NHN Cloud Loggerは、5つのレベルのログ送信関数を提供します。

### ログ送信API仕様

```objc
// DEBUG Level log
+ (void)debug:(NSString *)message;

// INFO Level log
+ (void)info:(NSString *)message;

// WARN Level log
+ (void)warn:(NSString *)message;

// ERROR Level log
+ (void)error:(NSString *)message;

// FATAL Level log
+ (void)fatal:(NSString *)message;
```

### ログ送信API使用例

```objc
[NHNCloudLogger info:@"NHN Cloud Log & Crash Search!"];
```

## ユーザー定義フィールド設定

* 希望するユーザー定義フィールドを設定します。
* ユーザー定義フィールドを設定すると、ログ送信APIを呼び出すたびに設定した値をログと一緒にサーバーに送信します。

### ユーザー定義フィールドAPI仕様

```objc
// ユーザー定義フィールド追加
+ (void)setUserFieldWithValue:(NSString *)value forKey:(NSString *)key;
```

* ユーザー定義フィールドは、**Log & Crash Search > ログ検索**をクリックした後、**ログ検索**画面の**選択したフィールド**に表示される値と同じです。

#### ユーザー定義フィールド制約事項

* すでに[予約されているフィールド](./log-collector-reserved-fields)は使用できません。
* フィールド名には'A-Z、a-z、0-9、-、_'を使用できます。最初の文字は'A-Z、a-z'のみ使用できます。
* フィールド名のスペースは、'_'に置換されます。


### ユーザー定義フィールド使用例
```objc
// ユーザー定義フィールド追加
[NHNCloudLogger setUserFieldWithValue:@"USER_VALUE" forKey:@"USER_KEY"];
```

## クラッシュログの収集
* NHN Cloud Loggerは、クラッシュ情報をログに送信する機能を提供します。
* NHN Cloud Loggerを初期化する時、一緒に有効になり、使用するかを設定できます。
* クラッシュログを送信するには、PLCrashReporterを使用します。

### CrashReporter使用するかの設定
* CrashReporter機能は、基本的にNHN Cloud Loggerを初期化する時に一緒に有効になります。
* NHN Cloud Loggerを初期化する時、使用するかを設定できます。
* クラッシュログ送信機能を使用しない場合は、CrashReporter機能を無効にする必要があります。

> UserIDが設定されている場合、Log ＆Crash Searchコンソールの`Crash User`セクションでユーザー固有のクラッシュ体験を確認できます。
> UserIDの設定は[開始する]（./getting-started-ios/#UserID設定）で確認できます。

#### CrashReporter有効化
```objc
// CrashReporter Enable Configuration
NHNCloudLoggerConfiguration *configuration = [NHNCloudLoggerConfiguration configurationWithAppKey:@"YOUR_APP_KEY" enableCrashReporter:YES];

[NHNCloudLogger initWithConfiguration:configuration];
```
#### CrashReporter無効化
```objc
// CrashReporter Disable Configuration
NHNCloudLoggerConfiguration *configuration = [NHNCloudLoggerConfiguration configurationWithAppKey:@"YOUR_APP_KEY" enableCrashReporter:NO];

[NHNCloudLogger initWithConfiguration:configuration];
```

## クラッシュ発生時に追加情報を設定して送信

* クラッシュ発生直後、追加情報を設定できます。
* setShouldReportCrashHandlerのBlockでユーザー定義フィールドを設定すると、正確にクラッシュが発生した時点に追加情報を設定できます。

### Data Adapter API仕様
```objc
+ (void)setShouldReportCrashHandler:(void (^)(void))handler;
```

### Data Adapter使用例

```objc
[NHNCloudLogger setShouldReportCrashHandler:^{
  // ユーザー定義フィールドを通してCrashが発生した状況から得たい情報を一緒に送信
  // ユーザー定義フィールド追加
  [NHNCloudLogger setUserFieldWithValue:@"USER_VALUE" forKey:@"USER_KEY"];

}];
```

## ログ送信後、追加作業進行

* Delegateを登録すると、ログ送信後に追加作業を進行できます。


### Delegate API仕様
```objc
+ (void)setDelegate:(id<NHNCloudLoggerDelegate>) delegate;
```

### Delegate API仕様

``` objc
@protocol NHNCloudLoggerDelegate <NSObject>
@optional
// ログ送信成功
- (void)nhnCloudLogDidSuccess:(NHNCloudLog *)log;

// ログ送信失敗
- (void)nhnCloudLogDidFail:(NHNCloudLog *)log error:(NSError *)error;

// ネットワーク切断などの理由でログの送信に失敗した場合、再送信のためにSDK内部保存
- (void)nhnCloudLogDidSave:(NHNCloudLog *)log;

// ログフィルタリング
- (void)nhnCloudLogDidFilter:(NHNCloudLog *)log logFilter:(NHNCloudLogFilter *)logFilter;
@end
```


### Delegate使用例

```objc
#import <NHNCloudLogger/NHNCloudLogger.h>

@interface AppDelegate () <UIApplicationDelegate, NHNCloudLoggerLoggerDelegate>

@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // ...

    // 初期化
    NHNCloudLoggerConfiguration *configuration = [NHNCloudLoggerConfiguration configurationWithAppKey:@"YOUR_APP_KEY" enableCrashReporter:YES];
    [NHNCloudLogger initWithConfiguration:configuration];

    // Delegate設定
    [[NHNCloudLogger setDelegate:self];

    return YES;
}

#pragma mark - NHNCloudLoggerDelegate
// ログ送信成功
- (void)nhnCloudLogDidSuccess:(NHNCloudLog *)log {
      // ...
 }

// ログ送信失敗
- (void)nhnCloudLogDidFail:(NHNCloudLog *)log error:(NSError *)error {
      // ...
}

// ネットワーク切断などの理由でログ送信に失敗した場合、再送信のためにSDK内部保存
- (void)nhnCloudLogDidSave:(NHNCloudLog *)log {
      // ...
}

// ログフィルタリング
- (void)nhnCloudLogDidFilter:(NHNCloudLog *)log logFilter:(NHNCloudLogFilter *)logFilter {
      // ...
}

@end
```

## Network Insights
* Network Insightsは、コンソールに登録したURLを呼び出して、遅延時間とレスポンス値を測定します。これを活用して複数の国(デバイスの国コード基準)からの遅延時間とレスポンス値を測定できます。

> コンソールからNetwork Insights機能を有効にすると、NHN Cloud Loggerを初期化する時、コンソールに登録したURLで1回要請します。

### Network Insights有効化

1. [NHN Cloud Console](https://console.nhncloud.com/)で**Log & Crash Search**サービスをクリックします。
2. **設定**メニューをクリックします。
3. **ログ送信設定**タブをクリックします。
4. **Network Insightsログ**を有効にします。

### URL設定

1. [NHN Cloud Console](https://console.nhncloud.com/)で**Log & Crash Search**サービスをクリックします。
2. **ネットワークインサイト**メニューをクリックします。
3. **URL設定**タブをクリックします。
4. 測定するにはURLを入力して**追加**ボタンをクリックします。

### 公共機関用NHN Cloud Loggerを設定する
* NHNCloudLoggerConfigurationのcloudEnvironment propertyで公共機関用クラウド使用設定を行うことができます。

```objc
typedef NS_ENUM(NSInteger, NHNCloudEnvironment) {
    NHNCloudEnvironmentPublic = 0,
    NHNCloudEnvironmentGovernment = 1,
};

@property (nonatomic) NHNCloudEnvironment cloudEnvironment;
```
* 設定しない場合のデフォルト値は`NHNCloudEnvironmentPublic`です。 

#### 公共機関用NHN Cloud Loggerの初期化例

```objc
NHNCloudLoggerConfiguration *configuration = [NHNCloudLoggerConfiguration configurationWithAppKey:@"YOUR_APP_KEY"];
[configuration setCloudEnvironment:NHNCloudEnvironmentGovernment];

[NHNCloudLogger initWithConfiguration:configuration];
```

### 公共機関用NHN Cloud Logger使用時の注意事項

* 公共機関用Log & Crash Searchは、以下の機能をサポートしません。
    * Console Settings
        * Console Settingsを使用するように設定する場合、Default Settingsが適用されます。 
            * すべてのLogを転送
            * フィルタ無効
            * Session / Crash Log無効
            * Network Insight無効
    * CrashReporter 
    * Network Insight
