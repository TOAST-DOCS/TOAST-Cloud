## NHN Cloud > SDK使用ガイド > Log & Crash > Windows C++

## 事前準備

1. [Install the NHN Cloud SDK](./getting-started-windows)
2. [NHN Cloudコンソール](https://console.cloud.nhncloud.com)で[Log & Crash Searchを有効化](https://docs.nhncloud.com/ja/Data%20&%20Analytics/Log%20&%20Crash%20Search/ko/console-guide/)します。
3. Log & Crash Searchで[AppKeyを確認](https://docs.nhncloud.com/ko/Data%20&%20Analytics/Log%20&%20Crash%20Search/ko/console-guide/#appkey)します。

## NHN Cloud SDKの初期化

Log & Crash Searchで発行されたAppKeyをProjectKeyに設定します。

```cpp
...
#include "NHNCloudLogger.h"

nhncloud::logger::NHNCloudLogger* g_nhncloud_lnc = nullptr; // NHN Cloud SDK - Log & crash search
...

// グローバル変数にNHN Cloud SDKインスタンスを割り当てます。
g_nhncloud_lnc = nhncloud::logger::NHNCloudLogger::GetInstance();

// NHNCloudLoggerを初期化する時、必要な設定情報を入力します。
nhncloud::logger::NHNCloudLoggerConfiguration* loggerConf = nhncloud::logger::NHNCloudLoggerConfiguration::GetInstance();

...
// Log & Crash Searchコンソールで確認したアプリケーションキーを入力します。
loggerConf->setProjectKey(appkey);

// 現在アプリケーションのバージョン情報を入力します。バージョン情報はシンボルファイルを登録する過程で入力するバージョン情報と一致する必要があります。
loggerConf->setProjectVersion(version);
...

if (!g_nhncloud_lnc->initialize(loggerConf))
{
	// すでに初期化されているか、アプリケーションキーを入力していない場合に初期化が失敗します。
	::MessageBox(g_mainWnd, _T("Failed to initialize NHN Cloud SDK."), _T("Alert"), MB_OK);
	return false;
}

```

## UserID設定

ユーザーIDを設定できます。
UserIDを設定すると、ログ送信APIを呼び出した時に、ログと一緒にユーザーIDもサーバーに送信します。
ユーザーIDは初期化前後に関係なく設定できます。

```cpp
    nhncloud::logger::NHNCloudLogger* pLogger = nhncloud::logger::NHNCloudLogger::GetInstance();
    pLogger->setUserId(pUserID);
    pLogger->getUserId();
```

* setUserId
    * ユーザーIDを設定します。
* getUserId
    * 現在設定されているユーザーIDを取得します。

## ログ送信

NHN Cloud Loggerは、5つのレベルのログ送信関数を提供します。

### ログ送信
* DEBUG、INFO、WARN、ERROR、FATALレベルのログを明示的に送信
	* char*、wchar_t*型をすべてサポートします。
	* userFieldsはユーザー定義フィールドをより簡単に使用するためのヘルパークラスです。
```cpp
void debug(const wchar_t* message, NHNCloudLoggerUserFields* userFields = NULL);
void info(const wchar_t* message, NHNCloudLoggerUserFields* userFields = NULL);
void warn(const wchar_t* message, NHNCloudLoggerUserFields* userFields = NULL);
void error(const wchar_t* message, NHNCloudLoggerUserFields* userFields = NULL);
void fatal(const wchar_t* message, NHNCloudLoggerUserFields* userFields = NULL);
```
* ログレベルと、メッセージを明示的に送信
```cpp
void log(NHNCLOUD_LOGGER_LEVEL logLevel, const char* message, NHNCloudLoggerUserFields* userFields = nullptr);
```

## ユーザー定義フィールドの追加
### 方法1：NHNCloudLoggerインスタンスAPI使用

* NHNCloudLoggerインスタンスで直接管理するユーザー定義フィールドです。

```cpp
bool addUserField(const char* key, const wchar_t* value);
void removeUserField(const char* key);
void clearUserFileds();

...

g_nhncloud_lnc->addUserField("nickname", "randy");
g_nhncloud_lnc->removeUserField("nickname");
g_nhncloud_lnc->cleareUserField();

```

### 方法2：NHNCloudLoggerUserFieldsクラス使用

```cpp
nhncloud::logger::NHNCloudLoggerUserFields* pUserFieldHelper = nhncloud::logger::NHNCloudLoggerUserFields::GetInstance();	// ユーザー定義フィールドヘルパークラスを取得します。

pUserFieldHelper->insert("userCustomKeyHelper01", L"NHNCloudLoggerUserFieldsヘルパークラスに追加したユーザー定義フィールド\r\nCustom fields added with the NHNCloudLoggerUserFields helper class");
pUserFieldHelper->insert("userCustomKeyHelper02", L"clear()関数で今まで定義したユーザーフィールドを簡単に整理できます。\r\nWith the clear() function, you can simply clear the custom fields you have defined so far.");
pUserFieldHelper->insert("userCustomKeyHelper03", L"log()関数で送信する時、NHNCloudLoggerUserFieldsクラスに定義したユーザーフィールドはログオブジェクトにコピーされます。\r\nWhen sending to the log() function, the user fields defined in the NHNCloudLoggerUserFields class are copied to the log object.");

g_nhncloud_lnc->log(level, pLogMessage, pUserFieldHelper);	// ユーザー定義フィールドと一緒にログを送信します。

pUserFieldHelper->clear(); // 上で設定したユーザー定義フィールドをすべて削除します。

```

* ユーザー定義フィールドは、**Log & Crash Search > ログ検索**をクリックした後、**ログ検索**画面の**選択したフィールド**に表示される値と同じです。

#### ユーザー定義(カスタム)フィールドの制約事項

* すでに[予約されているフィールド](./log-collector-reserved-fields)は使用できません。
* フィールド名は"A-Z, a-z"で始まり、"A-Z, a-z, 0-9, -, _"文字を使用できます。
* フィールド名のスペースは、'_'に置換されます。


## クラッシュログの収集
* クラッシュが発生すると、SDKを含む実行ファイルからクラッシュダンプを送信するのが基本動作です。
* クラッシュ発生時、ユーザーにエラー画面を表示して追加情報を収集できます。

### クラッシュログの収集と環境設定

```cpp

#include "NHNCloudLogger.h"

nhncloud::logger::NHNCloudLogger* g_nhncloud_lnc = nullptr;  // NHN Cloud SDK - Log & crash search
...

// グローバル変数にNHN Cloud SDKインスタンスを割り当てます。
g_nhncloud_lnc = nhncloud::logger::NHNCloudLogger::GetInstance();

// NHNCloudLoggerを初期化する時、必要な設定情報を入力します。
nhncloud::logger::NHNCloudLoggerConfiguration* loggerConf = nhncloud::logger::NHNCloudLoggerConfiguration::GetInstance();

...
// Log & Crash Searchコンソールで確認したアプリケーションキーを入力します。
loggerConf->setProjectKey(appkey);

// 現在アプリケーションのバージョン情報を入力します。バージョン情報はシンボルファイルを登録する過程で入力するバージョン情報と一致する必要があります。
loggerConf->setProjectVersion(version);

// クラッシュ収集有効 - 基本的に有効状態です。クラッシュの収集を望まない場合はfalseに設定します。
loggerConf->enableCrashReporter(true);

// 別途のプロセスで動作するクラッシュレポート(CrashReporter.exe)を使用するにはenableSilenceMode(false)に設定します。
loggerConf->enableSilenceMode(false);

// 別途のプロセスで動作するクラッシュレポートに表示するメッセージを定義します。定義しない場合は基本メッセージが表示されます。
loggerConf->setCrashReporterMessage(NHNCLOUD_LANGUAGE_KOREAN, "エラーが発生した状況。\n");

// 別途のプロセスにクラッシュを送信しますが、ユーザーにUIを表示したくない場合はexposeExternalCrashReporterUI(false)に設定します。
//loggerConf->exposeExternalCrashReporterUI(false);
...

// 初期化が終わったら、クラッシュの収集が可能です。
if (!g_nhncloud_lnc->initialize(loggerConf))
{
	// すでに初期化されているか、アプリケーションキーを入力していない場合に初期化が失敗します。
	::MessageBox(g_mainWnd, _T("Failed to initialize NHN Cloud SDK."), _T("Alert"), MB_OK);
	return false;
}


```

### クラッシュログ送信テスト

* クラッシュログの送信をテストするには、実際に例外(Exception)が発生する必要があります。
* クラッシュログの送信は、enableCrashReporterがtrueの場合にSDKが自動的に実行します。
* Access Violation例
```cpp

void CsampleDlg::OnBnClickedCrash()
{
    // TODO: Add your control notification handler code here
    int *i = reinterpret_cast<int*>(0x45);
    *i = 5;
}
```

### クラッシュログの解析

NHN Cloud Windows SDKで発生したクラッシュを解析するには、シンボルファイルを作成してWebコンソールにアップロードする必要があります。

#### シンボルファイルの作成

* シンボルファイルを作成するには、配布ファイルのパスでdump_syms.exeを使用する必要があります。
* より簡単な例は配布ファイルパスで`nhncloudsdk_example`サンプルプロジェクトのビルド後にイベントをご覧ください。
* コマンドプロンプトを実行し、下記のような方式で.symファイルを作成します。
    * sampleはサンプルプロジェクトの名称です。

```
dump_syms sample.pdb > sample.sym
```

* そしてsample.symをzipに圧縮して、[コンソールサーバーにアップロード](https://docs.nhncloud.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/#_24)します。
    * コンソールアップロードする時に入力するバージョンは、初期化する時にsetProjectVersionに入力したバージョンと同じ値である必要があります。
