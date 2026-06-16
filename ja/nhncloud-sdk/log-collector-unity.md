<!-- pre-align:aligned sig=c0fef3006554 -->

## NHN Cloud > SDK 使用ガイド > Log & Crash > Unity

<a id="prerequisites"></a>

## Prerequisites

1. [Install the NHN Cloud SDK](./getting-started-unity)
2. [NHN Cloud コンソール](https://console.nhncloud.com)で、[Log & Crash Search を有効化](/Data%20&%20Analytics/Log%20&%20Crash%20Search/ja/console-guide/)します。
3. Log & Crash Search で、[AppKey を確認](/Data%20&%20Analytics/Log%20&%20Crash%20Search/ja/console-guide/#appkey)します。
4. [NHN Cloud SDK を初期化](./getting-started-unity#toast-sdk_1)します。

<a id="supported-platforms"></a>

## サポートプラットフォーム

- iOS
- Android
- Standalone
- WebGL

<a id="for-android"></a>

## Android 設定

<a id="gradle-build-settings"></a>

### Gradle ビルド設定

- Unity Editor で、Build Settings ウィンドウを開きます。 （Player Settings> Publishing Settings> Build）。
- Build System リストから Gradle を選択します。
- Build System サブのチェックボックスを選択して、Custom Gradle Template を使用します。
- mainTemplate.gradle の dependencies 項目に下記の内容を追加します。

```groovy
apply plugin: 'com.android.application'

repositories {
  mavenCentral()
}

dependencies {
	implementation fileTree(dir: 'libs', include: ['*.jar'])
    implementation 'com.nhncloud.android:nhncloud-unity-logger:1.7.0'
**DEPS**}
```

<a id="for-ios"></a>

## iOS 設定

<a id="player-settings"></a>

### Player Settings 設定

- Unity の iOS ビルド設定には、Logger がサーバーにログを送信する際に影響を与えるいくつかの設定があります。
- この設定の効果と Logger の推奨設定を説明します。

| メニュー                         | リスト                        | 設定                       | 推奨設定      |
| -------------------------------- | ----------------------------- | -------------------------- | ------------- |
| Edit > Project Settings > Player | Debugging and crash reporting | On .Net UnhandledException | Silent Exit   |
| Edit > Project Settings > Player | Debugging and crash reporting | Enable CrashReport API     | Disabled      |
| Edit > Project Settings > Player | Other Settings                | Script Call Optimization   | Slow and Safe |

##### On .Net UnhandledException

- **Silent Exit**値を推奨します。
  - On .Net UnhandledException を Crash に設定すると、例外発生時に即時にアプリが終了します。
  - Silent Exit に設定すると、Unity Exception をキャプチャできます。

##### Enable CrashReport API

- **Disabled**値を推奨します。
  - Unity CrashReporter API が有効になっているかを表す値です。
  - 有効になっていれば、Logger のクラッシュログ収集に影響を与えることがあります。

##### Script Call Optimization

- **Slow and Safe**値を推奨します。
  - Runtime C# Crash ログを収集したい場合、Slow and Safe に設定する必要があります。

<a id="nhn-cloud-logger-namespace"></a>

## NHN Cloud Logger namespace

```csharp
using Toast.Logger;
```

<a id="initialize-nhn-cloud-logger-sdk"></a>

## NHN Cloud Logger SDK 初期化

Log & Crash Search で発行された AppKey を ProjectKey に設定します。

```csharp
var loggerConfiguration = new ToastLoggerConfiguration
{
    ProjectKey = "YOUR_PROJECT_KEY"
};

ToastLogger.Initialize(loggerConfiguration);
```

<a id="send-logs"></a>

## ログを送信する

NHN Cloud Logger は、5 つのレベルのログを送信できます。
ユーザーフィールドを追加して送ることもできます。

<a id="specification-for-log-sending-api"></a>

### ログ送信 API 仕様

```csharp
// DEBUGレベルのログ
ToastLogger.Debug(message);
ToastLogger.Debug(message, userFields);

// INFOレベルのログ
ToastLogger.Info(message);
ToastLogger.Info(message, userFields);

// WARNレベルのログ
ToastLogger.Warn(message);
ToastLogger.Warn(message, userFields);

// ERRORレベルのログ
ToastLogger.Error(message);
ToastLogger.Error(message, userFields);

// FATALレベルのログ
ToastLogger.Fatal(message);
ToastLogger.Fatal(message, userFields);
```

<a id="usage-example-of-log-sending-api"></a>

### ログ送信 API 使用例

```csharp
ToastLogger.Debug("NHN Cloud Log & Crash Search!", new Dictionary<string, string>
{
    { "Scene", "Main" }
});
```

<a id="set-user-defined-fields"></a>

## ユーザー定義フィールドを設定する

希望するユーザー定義フィールドを設定します。
ユーザー定義フィールドを設定すると、ログ送信 API を呼び出すたびに設定した値をログと一緒にサーバーに送信します。

<a id="specification-for-user-defined-field-setting-api"></a>

### ユーザー定義フィールド設定 API 仕様

```csharp
ToastLogger.SetUserField(userField, userValue);
```

- ユーザー定義フィールドは、"Log & Crash Search コンソール" > "Log Search タブ"の"選択したフィールド"に表示される値と同じです。
- 同じキーの値を複数回変更すると、最後に変更した値が適用されます。

<a id="restrictions-of-user-defined-fields"></a>

#### カスタムフィールド制約事項

- すでに[予約されているフィールド](./log-collector-reserved-fields)は使用できません。
- フィールド名には'A-Z、a-z、0-9、-、\_'を使用できます。最初の文字は'A-Z、a-z'のみ使用できます。
- フィールド名のスペースは、'\_'に置換されます。

<a id="usage-example-of-user-defined-field-setting-api"></a>

### ユーザー定義フィールド設定 API 使用例

```csharp
ToastLogger.SetUserField("GameObject", gameObject.name);
```

<a id="further-tasks-after-sending-logs"></a>

## ログ送信後、追加作業を進行する

- リスナーを登録すると、ログ送信後に追加作業を進行します。

<a id="specification-for-setloggerlistener-api"></a>

### SetLoggerListener API 仕様

```csharp
public interface IToastLoggerListener
{
    void OnSuccess(LogEntry log);
    void OnFilter(LogEntry log, LogFilter filter);
    void OnSave(LogEntry log);
    void OnError(LogEntry log, string errorMessage);
}

static void SetLoggerListener(IToastLoggerListener listener);
```

<a id="usage-example-of-setloggerlistener"></a>

### SetLoggerListener 使用例

```csharp
public class SampleLoggerListener : IToastLoggerListener
{
    public void OnSuccess(LogEntry log)
    {
        // ログ送信成功時の処理
    }

    public void OnFilter(LogEntry log, LogFilter filter)
    {
        // ログフィルタリング時の処理
    }

    public void OnSave(LogEntry log)
    {
        // ネットワーク切断などによる失敗時のログ再送信のために、ファイルに保存された場合
    }

    public void OnError(LogEntry log, string errorMessage)
    {
        // ログ送信失敗時の処理
    }
}

ToastLogger.SetLoggerListener(new SampleLoggerListener());
```

<a id="collect-crash-logs"></a>

## クラッシュログの収集

NHN Cloud Logger では、Unity のクラッシュを大きく 2 つに分類します。

- ネイティブプラットフォームで発生したクラッシュ(アプリが強制終了する)
- Unity で発生した予期せぬ例外(アプリが強制終了しない)

> **なぜLogExceptionとして出力されたログもクラッシュログとして収集するのですか？**
> サードパーティライブラリの中にLogExceptionを通してユーザーコードの例外を表示する場合が稀にあるからです。
> クラッシュログをフィルタリングしたい場合は、以下の**クラッシュログフィルタリングを行う**を参照してください。

ToastLogger を初期化すると、モバイル環境でクラッシュが発生した場合、または Unity で予期せぬ例外が発生した場合、自動的にクラッシュログが送信されます。
クラッシュログの送信を無効化したい場合は、下記のように ToastLoggerConfiguration オブジェクトの EnableCrashReporter プロパティを false に設定してください。
各プラットフォーム別のクラッシュログ情報は、下記のリンクを確認してください。

- [Android クラッシュログの収集](./log-collector-android/#_7)
- [iOS クラッシュログの収集](./log-collector-ios/#_6)

```csharp
var loggerConfiguration = new ToastLoggerConfiguration
{
    ProjectKey = "YOUR_PROJECT_KEY",
    EnableCrashReporter = false // クラッシュログの無効化
};
```

> UserID が設定されている場合、Log＆Crash Search コンソールの`Crash User`セクションでユーザー固有のクラッシュ体験を確認できます。
> UserID の設定は[開始する]（./getting-started-unity/＃userid）で確認できます。

<a id="further-tasks-after-sending-crash-logs"></a>

## クラッシュログを送信後、追加作業を進行する

- クラッシュリスナーを登録すると、クラッシュログ送信後に追加作業を進行できます。

> **Unity で予期せぬ例外が発生した場合にのみ動作します。**
> ネイティブプラットフォームで発生したクラッシュに対するリスナーは提供しません。

<a id="specification-for-setcrashlistener-api"></a>

### SetCrashListener API 仕様

```csharp
public delegate void CrashListener(bool isSuccess, LogEntry logEntry);

public static void SetCrashListener(CrashListener listener);
```

<a id="usage-example-of-setcrashlistener-api"></a>

### SetCrashListener API 使用例

```csharp
ToastLogger.SetCrashListener((isSuccess, log) =>
{
    if (isSuccess)
    {
        Application.Quit();
    }
});
```

<a id="filtering-the-crash-log"></a>

## クラッシュログフィルタリングを行う

- Unityを利用していると、収集を望まない例外ログやクラッシュログが収集されることがあります。
- NHN Cloud Loggerは、収集を望まないクラッシュログをフィルタリングする機能をサポートします。
  - この機能はUnityの例外に限定した機能です。

<a id="specification-for-addcrashfilter-api"></a>

### AddCrashFilter APIの仕様

```csharp
public delegate bool CrashFilter(CrashLogData logData);

public class CrashLogData
{
    public LogType LogType { get; }

    public string Condition { get; }

    public string StackTrace { get; }
}

public static void AddCrashFilter(CrashFilter filter);
```

- CrashLogDataのプロパティは、[Application.LogCallbackの引数と同じ](https://docs.unity3d.com/ScriptReference/Application.LogCallback.html)です。

<a id="usage-example-of-addcrashfilter-api"></a>

### AddCrashFilter APIの使用例

```csharp
ToastLogger.AddCrashFilter(crashLogData => crashLogData.Condition.Contains("UnityEngine.Debug.Log"));
```

<a id="send-handled-exceptions"></a>

## Handled Exception 送信

NHN Cloud Logger は、一般/クラッシュログだけでなく、try/catch 構文で例外に関連する内容を Report API を使用して送信できます。
こうして送信した例外ログは、"Log & Crash Search コンソール" > "App Crash Search タブ"のエラータイプで"Handled"でフィルタリングして照会できます。
Log & Crash コンソールの詳細な使用方法は、[コンソール使用ガイド](http://docs.nhncloud.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/)を参照してください。

<a id="specification-for-handled-exception-log-api"></a>

### Handled Exception Log API 詳細

```csharp
// Handled Exceptionログ送信
var logLevel = ToastLogLevel.ERROR;
ToastLogger.Report(logLevel, message, exception);
```

<a id="usage-example-of-handled-exception-log-api"></a>

### Handled Exception Log API 使用例

```csharp
try
{
    doSomethingWrong();
}catch(Exception e)
{
    // Debug、Info、Warn、Error、Fatalなどを使用できます。
    ToastLogger.Report(ToastLogLevel.ERROR, "YOUR_MESSAGE", exception);
}
```

<a id="network-insights"></a>

## Network Insights

Network Insights は、コンソールに登録した URL を呼び出して、遅延時間およびレスポンス値を測定します。これを活用して複数の国(デバイスの国コード基準)での遅延時間とレスポンス値を測定できます。

> コンソールから Network Insights 機能を有効にすると、NHN Cloud Logger 初期化時に、コンソールに登録した URL で 1 回要請します。

<a id="enable-network-insights"></a>

### Network Insights 有効化

1. [NHN Cloud Console](https://console.nhncloud.com/)で、[Log & Crash Search]サービスを選択します。
2. [設定]メニューを選択します。
3. [ログ送信設定]タブを選択します。
4. "Network Insights ログ"を有効にします。

<a id="url-setting"></a>

### URL 設定

1. [NHN Cloud Console](https://console.nhncloud.com/)で、[Log & Crash Search]サービスを選択します。
2. [ネットワークインサイト]メニューを選択します。
3. [URL 設定]タブを選択します。
4. 測定する URL を入力後、[追加]ボタンをクリックします。
