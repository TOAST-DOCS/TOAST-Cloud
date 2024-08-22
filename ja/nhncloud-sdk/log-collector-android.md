## NHN Cloud > SDK使用ガイド > Log & Crash > Android

## 事前準備

1. [NHN Cloud SDK](./getting-started-android)をインストールします。
2. [NHN Cloudコンソール](https://console.nhncloud.com)で[Log & Crash Searchを有効化](/Data%20&%20Analytics/Log%20&%20Crash%20Search/ja/console-guide/)します。
3. Log & Crash Searchで[AppKeyを確認](/Data%20&%20Analytics/Log%20&%20Crash%20Search/ja/console-guide/#appkey)します。

## ライブラリ設定
- 下記コードをbuild.gradleに追加します。

```groovy
repositories {
    mavenCentral()
}

dependencies {
    implementation 'com.nhncloud.android:nhncloud-logger:1.9.2'
    ...
}
```

## NHN Cloud Logger SDK初期化

- 初期化は、Application#onCreateで行う必要があります。

> 初期化を行わずにNhnCloudLoggerを使用すると、初期化エラーが発生します。

- Log & Crash Searchで発行されたAppKeyを設定します。

```java
// Initialize Logger
NhnCloudLoggerConfiguration configuration = NhnCloudLoggerConfiguration.newBuilder()
        .setAppKey(YOUR_APP_KEY)            // Log & Crash Search AppKey
        .build();

NhnCloudLogger.initialize(configuration);
```

## ログ送信

NHN Cloud Loggerは5つのレベルのログ送信関数を提供します。

### ログ送信API仕様

```java
// DEBUGレベルのログ
static void debug(String message);

// INFOレベルのログ
static void info(String message);

// WARNレベルのログ
static void warn(String message);

// ERRORレベルのログ
static void error(String message);

// FATALレベルのログ
static void fatal(String message);
```

### ログ送信API使用例

```java
NhnCloudLogger.warn("NHN Cloud Log & Crash Search!");
```

## ユーザー定義フィールド設定

希望するユーザー定義フィールドを設定します。
ユーザー定義フィールドを設定すると、ログ送信APIを呼び出すたびに設定した値をログと一緒にサーバーに送信します。

### setUserField API仕様

```java
static void setUserField(String field, Object value);
```

* ユーザー定義フィールドは**Log & Crash Search > ログ検索**をクリックした後**ログ検索**画面の **選択したフィールド**に表示される値と同じです。

#### カスタムフィールドの制約事項

* すでに[予約されているフィールド](./log-collector-reserved-fields)は使用できません。
* フィールド名には'A-Z、a-z、0-9、-、_'を使用できます。最初の文字は'A-Z、a-z'のみ使用できます。
* フィールド名のスペースは、'_'に置換されます。

### setUserField使用例

```java
NhnCloudLogger.setUserField("nickname", "randy");
```

## ログ送信後、追加作業進行

コールバック関数を登録すると、ログ送信後に追加作業を進行できます。

### setLoggerListener API仕様

```java
static void setLoggerListener(NhnCloudLoggerListener listener);
```

### setLoggerListener使用例

```java
NhnCloudLogger.setLoggerListener(new NhnCloudLoggerListener() {
    @Override
    public void onSuccess(LogEntry log) {
        // ログ送信成功
    }

    @Override
    public void onFilter(LogEntry log, LogFilter filter) {
        // ログフィルタリング
    }

    @Override
    public void onSave(LogEntry log) {
        // ネットワーク切断などでログの送信に失敗した場合、再送信のためにSDK内部保存
    }

    @Override
    public void onError(LogEntry log, Exception e) {
        // ログ送信失敗
    }
});
```

## クラッシュログの収集

NHN Cloud Loggerは、アプリで予期せぬクラッシュが発生した場合に、クラッシュ情報をサーバーに記録します。

### クラッシュログ収集を使用するかの設定

クラッシュログ送信機能は、setEnabledCrashReporter()メソッドを使用して有効化または無効化できます。

```java
// Initialize Logger
NhnCloudLoggerConfiguration configuration = NhnCloudLoggerConfiguration.newBuilder()
        .setAppKey(YOUR_APP_KEY)            // Log & Crash Search AppKey
        .setEnabledCrashReporter(true)              // Enable or Disable Crash Reporter
        .build();

NhnCloudLogger.initialize(configuration);
```

> UserIDが設定されている場合、Log＆Crash Searchコンソールの`Crash User`セクションでユーザー固有のクラッシュ体験を確認できます。
> UserIDの設定は[開始する]（./getting-started-android/#userid）で確認できます。

### Handled Exception API使用

Androidプラットフォームでは、try/catch構文で例外に関する内容を、NHN Cloud LoggerのHandled Exception APIを使用して送信できます。
このように送信した例外ログは、コンソールで**Log & Crash Search > アプリクラッシュ検索**をクリックし、**エラータイプ**で**Handled**をクリックして照会できます。
Log & Crashコンソールの詳細な使用方法は、[コンソール使用ガイド](http://nhncloud.com/ja/Analytics/Log%20&%20Crash%20Search/ja/console-guide/)を参照してください。

### Handled Exception Log API仕様

```java
// 例外情報送信
static void report(@NonNull String message, @NonNull Throwable throwable);

// ユーザーフィールドと一緒に例外情報送信
static void report(@NonNull String message,
                   @NonNull Throwable throwable,
                   @Nullable Map<String, Object> userFields);
```

### 使用例

```java
try {
    // User Codes...
} catch (Exception e) {
    Map<String, Object> userFields = new HashMap<>();
    NhnCloudLogger.report("message", e, userFields);
}
```

## クラッシュ発生時に追加情報を設定して送信

クラッシュ発生直後、追加情報を設定できます。
setUserFieldは、クラッシュ時点に関わらず、いつでも設定でき、 setCrashDataAdapterの場合は、正確にクラッシュが発生した時点に追加情報を設定できます。

### setCrashDataAdapter API仕様

```java
static void setCrashDataAdapter(CrashDataAdapter adapter);
```

* CrashDataAdapterのgetUserFields関数を通してリターンするMap資料構造のキー値は、上で説明したsetUserFieldの'field値'と同じ制約条件を持ちます。

### setCrashDataAdapter使用例

```java
NhnCloudLogger.setCrashDataAdapter(new CrashDataAdapter() {
    @Override
    public Map<String, Object> getUserFields() {
        Map<String, Object> userFields = new HashMap<>();
        userFields.put("UserField", "UserValue");
        return userFields;
    }
});
```

## Network Insights

Network Insightsは、コンソールに登録したURLを呼び出して遅延時間とレスポンス値を測定します。これを活用して複数の国(デバイスの国コード基準)での遅延時間とレスポンス値を測定できます。

> コンソールからNetwork Insights機能を有効にすると、TOAST Loggerを初期化する時、コンソールに登録したURLで1回要請します。

### Network Insights有効化

Network Insightsを有効にする方法は次のとおりです。

1. [NHN Cloud Console](https://console.nhncloud.com/)で**Log & Crash Search**サービスをクリックします。
2. **設定**メニューをクリックします。
3. **ログ送信設定**タブをクリックします。
4. **Network Insightsログ**を有効にします。

### URL設定

URLを設定する方法は次のとおりです。

1. [NHN Cloud Console](https://console.nhncloud.com/)で**Log & Crash Search**サービスをクリックします。
2. **ネットワークインサイト**メニューをクリックします。
3. **URL設定**タブをクリックします。
4. 測定するには、URLを入力して**追加**ボタンをクリックします。
