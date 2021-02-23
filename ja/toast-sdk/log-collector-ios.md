## NHN Cloud > NHN Cloud SDK使用ガイド > NHN Cloud Log & Crash > iOS

> [告知]
> NHN Cloud SDK 0.13.0でarm64eアーキテクチャを使用する機器(iPhone XS、XR、XS Max、iPad Pros 3rd)で発生したクラッシュ集計、分析が可能です。

## Prerequisites

1\. [NHN Cloud SDK](./getting-started-ios)をインストールします。
2\. [NHN Cloudコンソール](https://console.cloud.toast.com)で、[Log & Crash Searchを有効化](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/)します。
3\. Log & Crash Searchで、[AppKeyを確認](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/#appkey)します。

## NHN Cloud Logger構成

* iOS用NHN Cloud Logger SDKの構成は次のとおりです。

| Service  | Cocoapods Pod Name | Framework | Dependency | Build Settings |
| --- | --- | --- | --- | --- |
| NHN Cloud Log & Crash | NHN CloudLogger | ToastLogger.framework | [External & Optional]<br/> * CrashReporter.framework (Toast) |  |
| Mandatory   | NHN CloudCore<br/>NHN CloudCommon | ToastCore.framework<br/>ToastCommon.framework | | OTHER_LDFLAGS = (<br/>    "-ObjC",<br/>    "-lc++" <br/>); |

## NHN Cloud Logger SDKをXcodeプロジェクトに適用

### 1. Cococapods適用

* Podfileを作成して、NHN Cloud SDKに対するpodを追加します。

```podspec
platform :ios, '9.0'
use_frameworks!

target '{YOUR PROJECT TARGET NAME}' do
    pod 'ToastLogger'
end
```

### 2. バイナリをダウンロードしてNHN Cloud SDK適用

#### Link Frameworks

* NHN Cloudの[Downloads](../../../Download/#toast-sdk)ページで、全体iOS SDKをダウンロードできます。
* Xcode Projectに**ToastLogger.framework**、**ToastCore.framework**、**ToastCommon.framework**を追加します。
* NHN Cloud LoggerのCrash Report機能を使用するには、一緒に配布される**CrashReporter.framework**もプロジェクトに追加する必要があります。
![linked_frameworks_logger](http://static.toastoven.net/toastcloud/sdk/ios/logger_link_frameworks_logger.png)

#### Project Settings

* **Build Settings**の**Other Linker Flags**に**-lc++**と**-ObjC**項目を追加します。
    * **Project Target > Build Settings > Linking > Other Linker Flags**
![other_linker_flags](http://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags.png)

* **CrashReporter.framewor**を直接ダウンロードするか、ビルドした場合は**Build Settings**の**Enable Bitcode**の値を**NO**に変更する必要があります。
    * **Project Target > Build Settings > Build Options > Enable Bitcode**
![enable_bitcode](http://static.toastoven.net/toastcloud/sdk/ios/overview_settings_bitcode.png)

> NHN Cloudの[Downloads](../../../Download/#toast-sdk)ページでダウンロードしたCrashReporter.frameworkは、bitCodeをサポートします。

### CrashReport 使用時注意事項

* arm64eアーキテクチャを使用する機器のクラッシュ・分析のためにはNHN Cloud Loggerと一緒に配布されるPLCrashReporterを使用しなければなりません。
      * NHN Cloudの[Downloads](../../../Download/#toast-sdk)ページではない他の場所でダウンロードしたり、直接ビルドしたPLCrashReporterを使用する場合、arm64eアーキテクチャを使用する機器のクラッシュ分析が不可能です。

## NHN Cloud Logger SDK初期化

* Log & Crash Searchで発行されたAppKeyを設定します。


### 初期化API仕様

``` objc
// 초기화
+ (void)initWithConfiguration:(ToastLoggerConfiguration *)configuration;
```

### 初期化プロセス例

```objc
ToastLoggerConfiguration *configuration = [ToastLoggerConfiguration configurationWithAppKey:@"YOUR_APP_KEY"];
[ToastLogger initWithConfiguration:configuration];
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
[ToastLogger info:@"TOAST Log & Crash Search!"];
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
[ToastLogger setUserFieldWithValue:@"USER_VALUE" forKey:@"USER_KEY"];
```

## クラッシュログの収集
* NHN Cloud Loggerは、クラッシュ情報をログに送信する機能を提供します。
* NHN Cloud Loggerを初期化する時、一緒に有効になり、使用するかを設定できます。
* クラッシュログを送信するには、PLCrashReporterを使用します。

### CrashReporter使用するかの設定
* CrashReporter機能は、基本的にNHN Cloud Loggerを初期化する時に一緒に有効になります。
* NHN Cloud Loggerを初期化する時、使用するかを設定できます。
* クラッシュログ送信機能を使用しない場合は、CrashReporter機能を無効にする必要があります。

> UserIDが設定されている場合、Log＆Crash Searchコンソールの`Crash User`セクションでユーザー固有のクラッシュ体験を確認できます。
> UserIDの設定は[開始する]（./getting-started-ios/#UserID設定）で確認できます。

#### CrashReporter有効化
```objc
// CrashReporter Enable Configuration
ToastLoggerConfiguration *configuration = [ToastLoggerConfiguration configurationWithAppKey:@"YOUR_APP_KEY" 
                                                                        enableCrashReporter:YES];

[ToastLogger initWithConfiguration:configuration];
```
#### CrashReporter無効化
```objc
// CrashReporter Disable Configuration
ToastLoggerConfiguration *configuration = [ToastLoggerConfiguration configurationWithAppKey:@"YOUR_APP_KEY" 
                                                                        enableCrashReporter:NO];

[ToastLogger initWithConfiguration:configuration];
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
[ToastLogger setShouldReportCrashHandler:^{
  // ユーザー定義フィールドを通してCrashが発生した状況から得たい情報を一緒に送信
  // ユーザー定義フィールド追加
  [ToastLogger setUserFieldWithValue:@"USER_VALUE" forKey:@"USER_KEY"];

}];
```

## ログ送信後、追加作業進行

* Delegateを登録すると、ログ送信後に追加作業を進行できます。


### Delegate API仕様

```objc
+ (void)setDelegate:(id<ToastLoggerDelegate>) delegate;
@end
```

### Delegate API仕様

``` objc
@protocol ToastLoggerDelegate <NSObject>
@optional
// ログ送信成功
- (void)toastLogDidSuccess:(ToastLog *)log;

// ログ送信失敗
- (void)toastLogDidFail:(ToastLog *)log error:(NSError *)error;

// ネットワーク切断などの理由でログの送信に失敗した場合、再送信のためにSDK内部保存
- (void)toastLogDidSave:(ToastLog *)log;

// ログフィルタリング
- (void)toastLogDidFilter:(ToastLog *)log logFilter:(ToastLogFilter *)logFilter;
@end
```


### Delegate使用例

```objc
#import <ToastLogger/ToastLogger.h>

@interface AppDelegate () <UIApplicationDelegate, ToastLoggerDelegate>

@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // ...

    // 초기화
    ToastLoggerConfiguration *configuration = [ToastLoggerConfiguration configurationWithAppKey:@"YOUR_APP_KEY" 
                                                                            enableCrashReporter:YES];
    [ToastLogger initWithConfiguration:configuration];

    // Delegate 설정
    [[ToastLogger setDelegate:self];

    return YES;
}

#pragma mark - ToastLoggerDelegate
// ログ送信成功
- (void)toastLogDidSuccess:(ToastLog *)log {
      // ...
 }

// ログ送信失敗
- (void)toastLogDidFail:(ToastLog *)log error:(NSError *)error {
      // ...
}

// ネットワーク切断などの理由でログ送信に失敗した場合、再送信のためにSDK内部保存
- (void)toastLogDidSave:(ToastLog *)log {
      // ...
}

// ログフィルタリング
- (void)toastLogDidFilter:(ToastLog *)log logFilter:(ToastLogFilter *)logFilter {
      // ...
}

@end
```

## Network Insights
* Network Insightsは、コンソールに登録したURLを呼び出して、遅延時間とレスポンス値を測定します。これを活用して複数の国(デバイスの国コード基準)からの遅延時間とレスポンス値を測定できます。

> コンソールからNetwork Insights機能を有効にすると、NHN Cloud Loggerを初期化する時、コンソールに登録したURLで1回要請します。

### Network Insights有効化

1. [NHN Cloud Console](https://console.toast.com/)で**Log & Crash Search**サービスをクリックします。
2. **設定**メニューをクリックします。
3. **ログ送信設定**タブをクリックします。
4. **Network Insightsログ**を有効にします。

### URL設定

1. [NHN Cloud Console](https://console.toast.com/)で**Log & Crash Search**サービスをクリックします。
2. **ネットワークインサイト**メニューをクリックします。
3. **URL設定**タブをクリックします。
4. 測定するにはURLを入力して**追加**ボタンをクリックします。
