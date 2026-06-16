<!-- pre-align:aligned sig=d17880a2d123 -->

## Analytics > Log & Crash Search > TOAST SDK使用ガイド > Android

<a id="prerequisites"></a>

## Prerequisites

1. [TOASTコンソール](https://console.toast.com)で[Log&Crash Searchを有効化](/Data%20&%20Analytics/Log%20&%20Crash%20Search/ko/console-guide/)します。

2. Log & Crash Searchで[AppKeyを確認](/Data%20&%20Analytics/Log%20&%20Crash%20Search/ko/console-guide/#appkey)します。

<a id="component-sdks"></a>

## Component SDKs

Android用TOAST SDKは下記のSDKで構成されています。

* [TOAST Logger](#log-collector) SDK
* [TOAST Crash](#crash-reporter) SDK

TOAST SDKの全機能が必要ない場合は、アプリに必要なSDKだけを使うことができます。

| Gradle Dependency | Service |
| --- | --- |
| com.toast.android:toast-logger:1.0.0 | Log Collection |
| com.toast.android:toast-crash:1.0.0 | Crash Reporter |

<a id="getting-started-android-sdk"></a>

## Getting Started Android SDK

<a id="environments"></a>

### Environments

* Android 4.0.3以上
* Android Studio最新バージョン(バージョン2.2以上)

<a id="add-toast-sdk-to-your-project"></a>

### Add TOAST SDK to Your Project

プロジェクトにTOAST SDKを使う場合、いくつかの基本的な作業を実行してAndroid Studioプロジェクトを準備する必要があります。

build.gradleファイルにTOAST SDKの依存関係を追加します。

```groovy
dependencies {
  // ...
  compile 'com.toast.android:toast-sdk:1.0.0'
  // ...
}
```

<a id="intiailize-toast-sdk"></a>

### Intiailize TOAST SDK

TOAST SDKの色んな商品を使うためにはApplication#onCreateでTOAST SDKを初期化する必要があります。

```java
public class YourApplication extends Application {
    @Override
    public void onCreate() {
        super.onCreate();
        // ...

        // Initialize TOAST SDK
        ToastSdk.initialize(getApplicationContext());
    }
}
```

<a id="log-collector"></a>

## Log Collector

<a id="initialize"></a>

### Initialize

onCreate()メソッドでLoggerを初期化します。
Log & Crash Searchで発行されたAppKeyをProjectKeyに設定します。

```java
// Initialize Logger
ToastLoggerConfiguration loggerConfiguration = new ToastLoggerConfiguration.Builder()
        .setProjectKey(YOUR_PROJECT_KEY)            // Log & Crash Search AppKey
        .setProjectVersion(YOUR_PROJECT_VERSION)    // App Version
        .build();

ToastLogger.initialize(loggerConfiguration);
```

<a id="send-log"></a>

### Send Log

TOAST Loggerは5つのレベルのログ送信関数を提供します。

```java
// DEBUGレベルログ
ToastLogger.debug(tag, message);

// INFOレベルログ
ToastLogger.info(tag, message);

// WARNレベルログ
ToastLogger.warn(tag, message);

// ERRORレベルログ
ToastLogger.error(tag, message);

// FATALレベルログ
ToastLogger.fatal(tag, message);
```

<a id="set-userid"></a>

### Set UserID

ユーザーIDを設定します。
設定されたユーザーIDは"UserID"フィールドで、Log & Crash Searchで照会できます。

```java
ToastLogger.setUserId(userId);
```

<a id="set-user-field"></a>

### Set User Field

ユーザーが希望するフィールドを設定します。

```java
ToastLogger.setUserField("UserField", "UserValue");
```

> 予約済みのフィールドは使用できません。
> フィールド名は"A-Z, a-z"で始まり、"A-Z, a-z, 0-9, -, _"文字を使用できます。
> フィールド名内の空白は"\_"に置換されます。

<a id="log-callback"></a>

### Log Callback

ログを送信した後、送信結果をCallbackで確認できます。

```java
ToastLogger.setListener(new ToastLoggerListener() {
    @Override
    public void onSuccess(LogObject log) {
        // ログ送信に成功しました。
    }

    @Override
    public void onFiltered(LogObject log, LogFilter filter) {
        // ログフィルタによってログがフィルタリングされました。
    }

    @Override
    public void onSaved(LogObject log) {
        // ネットワークブロックでログが保存されました。
    }

    @Override
    public void onError(LogObject log, int errorCode, String errorMessage) {
        // 送信に失敗しました。
    }
});
```

<a id="crash-reporter"></a>

## Crash Reporter

<a id="initialize-2"></a>

### Initialize

onCreate()メソッドでToastCrashを初期化します。

```java
// Initialize Crash
ToastCrash.initialize();
```

<a id="send-handled-exception"></a>

### Send Handled Exception

TOAST Crashは5つのレベルの例外情報を送信できます。

```java
// DEBUGレベルの例外情報の送信
ToastCrash.debug(tag, message, throwable);

// INFOレベルの例外情報の送信
ToastCrash.info(tag, message, throwable);

// WARNレベルの例外情報の送信
ToastCrash.warn(tag, message, throwable);

// ERRORレベルの例外情報の送信
ToastCrash.error(tag, message, throwable);

// FATALレベルの例外情報の送信
ToastCrash.fatal(tag, message, throwable);
```

<a id="using"></a>

#### Using

```java
try {
    // User Codes...
} catch (Exception e) {
    ToastCrash.debug(TAG, "Handled Exception", e);
}
```

<a id="set-user-field-2"></a>

### Set User Field

ユーザーが希望するフィールドを設定します。

```java
ToastCrash.setUserField("UserField", "UserValue");
```

> 予約済みのフィールドは使用できません。
> フィールド名は"A-Z, a-z"で始まり、"A-Z, a-z, 0-9, -, _"文字を使用できます。
> フィールド名内の空白は"\_"に置換されます。

<a id="set-data-adapter"></a>

### Set Data Adapter

クラッシュ発生時の追加情報を設定できます。

```java
ToastCrash.setDataAdapter(new CrashDataAdapter() {
    @Override
    public Map<String, Object> getUserFields() {
        Map<String, Object> userFields = new HashMap<>();
        userFields.put("UserField", "UserValue");
        return userFields;
    }
});
```

<a id="crash-callback"></a>

### Crash Callback

クラッシュ情報を送信した後、送信結果をCallbackで確認できます。

```java
ToastCrash.setListener(new CrashListener() {
    @Override
    public void onSuccess(LogObject log) {
        // クラッシュ情報の送信に成功しました。
    }

    @Override
    public void onFiltered(LogObject log, LogFilter filter) {
        // ログフィルタによってクラッシュ情報がフィルタリングされました。
    }

    @Override
    public void onSaved(LogObject log) {
        // ネットワークブロックでクラッシュ情報が保存されました。
    }

    @Override
    public void onError(LogObject log, int errorCode, String errorMessage) {
        // 送信に失敗しました。
    }
});
```
