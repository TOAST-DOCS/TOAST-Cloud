## TOAST > TOAST SDK使用ガイド > TOAST Log & Crash > Windows C++

## 事前準備

1\. [Install the TOAST SDK](./getting-started-windows)
2\. [TOASTコンソール](https://console.cloud.toast.com)で、[Log & Crash Searchを有効化](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/)します。
3\. Log & Crash Searchで[AppKeyを確認](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/#appkey)します。

## TOAST Logger SDKの初期化

Log & Crash Searchで発行されたAppKeyをProjectKeyに設定します。

```
...
#include "toast/ToastLogger.h"

using namespace toast::logger;
...

ToastLogger* logger = GetToastLogger();

ToastLoggerConfiguration* loggerConf = GetToastLoggerConfiguration();
...
loggerConf->setProjectKey(appkey);
loggerConf->setProjectVersion(version);
...

if (_logger != NULL)
{
    _logger->initialize(loggerConf);
}
```

## UserIDの設定

ToastSDKにユーザーIDを設定できます。
設定したUserIDは、ToastSDKの各モジュールで共通で使用されます。
ToastLoggerのログ送信APIを呼び出すたびに、設定したユーザーIDをログと一緒にサーバーに送信します。


```

ToastLogger* _logger = GetToastLogger();

_logger->setUserId("userId");

_logger->initialize(loggerConf);

_logger->getUserId();
```

* setUserId
    * ユーザーIDを設定します。
* getUserId
    * 現在設定されているユーザーIDを取得します。

## ログ送信

TOAST Loggerは、5つのレベルのログ送信関数を提供します。

### ログ送信 

```
// 一般ログ
_logger->log(level, message, _userFieldMap);

// DEBUGレベルのログ
_logger->debug(level, message, _userFieldMap);

// INFOレベルのログ
_logger->info(level, message, _userFieldMap);

// WARNレベルのログ
_logger->warn(String message);

// ERRORレベルのログ
_logger->error(String message);

// FATALレベルのログ
_logger->fatal(String message);
```

## ユーザー定義フィールドの追加

```

ToastLoggerUserFields* _userFieldMap = CreateToastLoggerUserFields();

_userFieldMap->insert(key, value);

if (_userFieldMap != NULL)
{
    if (_userFieldMap->size() > 0)
    {
        _logger->log(level, message, _userFieldMap);
    }
    else
    {
        _logger->log(level, message);
    }
}
```

* ユーザーフィールドは、特定ログにのみ適用したいフィールド情報を入れます。
* ToastLoggerUserFieldsは、下記のような関数をサポートします。
    * insert：データ挿入
    * erase：データ削除
    * clear：全体削除
    * size：サイズ
    * find：データ探索
    * empty：空の状態かどうか

* ユーザー定義フィールドは、**Log & Crash Search > ログ検索**をクリックした後、**ログ検索**画面の**選択したフィールド**に表示される値と同じです。

#### カスタムフィールド制約事項

* すでに[予約されているフィールド](./log-collector-reserved-fields)は使用できません。  
* フィールド名には'A-Z、a-z、0-9、-、_'を使用できます。最初の文字は'A-Z、a-z'のみ使用できます。
* フィールド名のスペースは、'_'に置換されます。

### addUserField / removeUserFiled / cleareUserField使用例

```
_logger->addUserField("nickname", "randy");
_logger->removeUserField("nickname");
_logger->cleareUserField();
```

## クラッシュログの収集

クラッシュレポーター(CrashRepoter.exe)は、クラッシュ情報をログに送信する機能を提供します。
クラッシュが発生すると、クラッシュレポーターからクラッシュ情報をログに送信します。
ToastLoggerを初期化する時、クラッシュレポーターを使用するかを設定できます。
クラッシュレポーターダイアログボックスを使用するかどうか、カスタムメッセージを設定できます。 


### クラッシュログ有効化およびクラッシュレポーター 

```
...
#include "toast/ToastLogger.h"

using namespace toast::logger;
...

ToastLogger* logger = GetToastLogger();

ToastLoggerConfiguration* loggerConf = GetToastLoggerConfiguration();
...
// クラッシュログが有効になっているか
loggerConf->enableCrashReporter(true);	
// クラッシュレポーターダイアログを使用するか
loggerConf->enableSilenceMode(false);	
// クラッシュレポーターダイアログに表示されるメッセージを定義 
// (定義しない場合、基本メッセージが表示される。)
loggerConf->setCrashReporterMessage(TOAST_LANGUAGE_KOREAN, "エラーが発生した状況…\n");
...

if (_logger != NULL)
{
    _logger->initialize(loggerConf);
}
```

### クラッシュログ送信テスト 

* クラッシュログの送信をテストするには、実際に例外(Exception)が発生する必要があります。
* クラッシュログの送信は、enableCrashReporterがtrueの場合にSDKが自動的に実行します。

```

void CsampleDlg::OnBnClickedCrash()
{
    // TODO: Add your control notification handler code here
    int *i = reinterpret_cast<int*>(0x45);
    *i = 5;
}
```

### クラッシュログの解析

TOAST Windows SDKで発生したクラッシュを解析するには、シンボルファイルを作成してWebコンソールにアップロードする必要があります。

#### シンボルファイル作成

* シンボルファイルを作成するには、開発環境に合ったdump_symsが必要です。
    * [dump\_syms\_vc1600 : vs2010](http://static.toastoven.net/toastcloud/tools/dump_syms_vc1600.zip)
    * [dump\_syms\_vc1700 : vs2012](http://static.toastoven.net/toastcloud/tools/dump_syms_vc1700.zip)
    * [dump\_syms\_vc1800 : vs2013](http://static.toastoven.net/toastcloud/tools/dump_syms_vc1800.zip)
    * [dump\_syms\_vc1900 : vs2015](http://static.toastoven.net/toastcloud/tools/dump_syms_vc1900.zip)
* コマンドプロンプトを実行し、下記のような方式で.symファイルを作成します。
    * sampleはサンプルプロジェクトの名称です。

```
dump_syms sample.pdb > sample.sym
```

* そしてsample.symをzipに圧縮して、[コンソールサーバーにアップロード](https://alpha-docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/#_25)します。
    * コンソールアップロードする時に入力するバージョンは、初期化する時にsetProjectVersionに入力したバージョンと同じ値である必要があります。
