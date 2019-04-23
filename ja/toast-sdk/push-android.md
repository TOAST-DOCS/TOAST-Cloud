## TOAST > TOAST SDK使用ガイド > TOAST Push > Android

## 事前準備

1\. [TOAST SDK](./getting-started-android)をインストールします。
2\. [TOASTコンソール](https://console.cloud.toast.com)で、[Pushサービスを有効化](https://docs.toast.com/ko/Notification/Push/ko/console-guide/)します。
3\. PushコンソールでAppKeyを確認します。

## Push提供者別ガイド

- [Firebase Cloud Messaging (以下FCM)ガイド](https://firebase.google.com/docs/cloud-messaging/)
- [Tencent Push Notification (以下 Tencent) 가이드](https://xg.qq.com/docs/)

## ライブラリ設定

### FCM
- FCM用SDKをインストールするには、下記のコードをbuild.gradleに追加します。

```groovy
dependencies {
    implementation 'com.toast.android:toast-push-fcm:0.16.0’
    ...
}
```

### Tencent
- Tencent用SDKをインストールするには、下記のコードをbuild.gradleに追加します。

```groovy
dependencies {
    implementation 'com.toast.android:toast-push-tencent:0.16.0’
    ...
}
```

## Firebase Cloud Messagingの設定

### プロジェクトおよびアプリ追加
- 既存Firebaseプロジェクトがない場合、[Firebaseコンソール](https://console.firebase.google.com/?hl=ko)でプロジェクトを作成します。
- コンソールの上部にある歯車ボタンをクリックして**プロジェクト設定**に移動します。
- プロジェクト設定の**マイアプリ**で、**AndroidアプリにFirebase追加**をクリックします。
- **Androidパッケージ名**、**アプリニックネーム(選択事項)**を入力し、**アプリ登録**ボタンをクリックします。
- **google-services.jsonダウンロード**ボタンをクリックして、設定情報をダウンロードします。そして**次へ**ボタンをクリックします。
    - もしダウンロードをせずにスキップしても、プロジェクト設定から再度ダウンロード可能です。
- 次のステップ**Firebase SDK追加**は、下記の別途ガイドを参考すればよいので、すぐに**次へ**ボタンをクリックします。
- 次のステップ**アプリを実行してインストール確認**も、**_この段階をスキップ_**をクリックしてスキップします。

### build.gradle設定
#### ルートレベルのbuild.gradle
- ルートレベルのbuild.gradleに、下記のコードを追加します。

```groovy
buildscript {
    // ...
    dependencies {
        // ...
        classpath 'com.google.gms:google-services:4.2.0' // google-services plugin
    }
}

allprojects {
    // ...
    repositories {
        // ...
        google() // Google's Maven repository
    }
}
```

#### アプリモジュールのbuild.gradle
- アプリモジュールのbuild.gradleに、下記のコードを追加します。

```groovy
apply plugin: 'com.android.application'

android {
  // ...
}

// ADD THIS AT THE BOTTOM
apply plugin: 'com.google.gms.google-services'
```

### google-services.jsonの追加
- アプリモジュールのルートパスに、ダウンロードしたgoogle-services.jsonをコピーします。

## Push設定
- [ToastPushConfiguration](./push-android/#toastpushconfiguration)オブジェクトは、Push設定情報を含んでいます。
- [ToastPushConfiguration](./push-android/#toastpushconfiguration)オブジェクトは、ToastPushConfiguration.Builderを使用して作成できます。
- Pushコンソールで発行されたAppKeyをToastPushConfiguration.newBuilderの引数に渡します。

## Tencent Push Notification 설정
- 기존 Tencent 프로젝트가 없다면, [Tencent 콘솔](https://xg.qq.com/)에서 프로젝트를 생성합니다.
- 웹 우측에 어플리케이션 등록을 선택합니다.
- 어플리케이션을 등록하면 AccessID와 Accesskey가 생성됩니다.

### build.gradle 設定
#### ルートレベルのbuild.gradle
- アプリモジュールのbuild.gradleに、下記のコードを追加します。

```groovy
apply plugin: 'com.android.application'

android {
    ...
    defaultConfig {
        ...
        ndk {
        // ビルドしようとするcpuの種類を追加します。
        // 必要に応じて追加 : 'x86', 'x86_64', 'mips', 'mips64'
        abiFilters 'armeabi', 'armeabi-v7a', 'arm64-v8a'
        }
        
        manifestPlaceholders = [
            XG_ACCESS_ID:"accessid",
            XG_ACCESS_KEY : "accesskey",
        ]
    }
}
```

### gradle.properties 設定
- ルートレベルのgradle.propertiesに、下記のコードを追加します。

```groovy
android.useDeprecatedNdk = true
```

### Push設定例

```java
ToastPushConfiguration.Builder configuration =
    ToastPushConfiguration.newBuilder(getApplicationContext(), "YOUR_APP_KEY")
            .build();
```

## Push初期化
- ToastPush.initializeを呼び出してTOAST Pushを初期化します。
- 使用したいPushProviderのオブジェクトを初期化呼び出し時に渡す必要があります。

### FCM初期化例

```java
PushProvider provider = FirebaseMessagingPushProvider.getProvider();
ToastPush.initialize(provider, configuration);
```

### Tencent初期化例
```java
PushProvider provider = TencentMessagingPushProvider.getProvider();
ToastPush.initialize(provider, configuration);
```

## サービスログイン
- TOAST SDKで提供するすべてのサービス(Push、IAP、Log & Crashなど)は、1つの同じユーザーIDを使用します。
    - [ToastSdk.setUserId](./getting-started-android/#userid)にユーザーIDを設定できます。
    - ユーザーIDを設定していない場合、トークンを登録できません。
- サービスログイン段階でユーザーID設定、トークン登録機能を実装することを推奨します。

### サービスログイン例

```java
public void onLogin(String userId) {
    // Login.
    ToastSdk.setUserId(userId);
    // トークン登録など
}
```

## 受信同意設定
- 韓国情報通信網法規定(第50条から第50条の8)に従い、トークン登録時の通知/広告性/夜間広告性プッシュメッセージ受信に同意するかも一緒に入力を受けます。メッセージ送信時に受信に同意しているかを基準に自動的にフィルタリングします。
    - [KISAガイドへ](https://spam.kisa.or.kr/spam/sub62.do)
    - [法令へ](http://www.law.go.kr/법령/정보통신망이용촉진및정보보호등에관한법률/%2820130218,11322,20120217%29/제50조)

### 受信同意設定例
```java
ToastPushAgreement agreement = ToastPushAgreement.newBuilder(/*通知を受信するか*/ true)
        .setAllowAdvertisements(/* 広告を受信するか*/ true)
        .setAllowNightAdvertisements(/*夜間広告を受信するか*/ true)
        .build();
```

## トークン登録
- 各Push提供者が提供するトークンを取得し、TOAST Pushサーバーに送信します。
- トークンの登録に成功すると、Pushを受信できます。

### トークン登録例
```java
ToastPush.registerToken(context, agreement, new RegisterTokenCallback() {
    @Override
    public void onRegister(@NonNull PushResult result, @Nullable String token) {
        if (result.isSuccess()) {
            // トークン登録成功
        } else {
            // トークン登録失敗
            int code = result.getCode();
            String message = result.getMessage();
        }
    }
});
```

## トークン情報照会
- TOAST Pushサーバーに登録されているトークン情報を照会します。

### トークン情報照会例
```java
ToastPush.queryTokenInfo(mContext, new QueryTokenInfoCallback() {
    @Override
    public void onQuery(@NonNull PushResult result, @Nullable TokenInfo tokenInfo) {
        if (result.isSuccess()) {
            String token = tokenInfo.getToken();
            ToastPushAgreement agreement = tokenInfo.getAgreement();
            // トークン情報照会成功
        } else {
            // トークン情報照会失敗
            int code = result.getCode();
            String message = result.getMessage();
        }
    }
});
```

## トークン解除
最近登録されたトークンを解除します。トークンが解除されると、プッシュをこれ以上受けることができなくなります。

>すでに解除されたトークンを解除すると、「既に解除されたトークンです（Already a token has been unregistered）」というメッセージと一緒に成功を返します。

### トークン解除例
```java
ToastPush.unregisterToken(mContext, new UnregisterTokenCallback() {
    @Override
    public void onUnregister(@NonNull PushResult result,
                             @Nullable String unregisteredToken) {
        if (result.isSuccess()) {
            // トークン解除成功
        } else {
            // トークン解除失敗
        }
    }
});
```

## 通知デフォルト値設定

### 小さいアイコンのデフォルト値設定
- 通知の小さいアイコンのデフォルト値を設定します。
- 小さいアイコンのデフォルト値を設定すると、SDKが通知作成時にデフォルト値に設定された小さいアイコンを通知に登録します。

#### 小さいアイコンデフォルト値設定例
```java
ToastNotification.setDefaultSmallIcon(context, R.drawable.ic_notification);
```

### 基本通知チャンネル設定
- Android 8.0(APIレベル26)以上からは、通知チャンネルを使用する必要があります。
- 基本通知チャンネルを設定すると、SDKが通知作成時に、基本通知チャンネルで通知を登録します。
- **通知チャンネルID**は、通知チャンネルを識別するための値で、アプリでユニークな値に設定する必要があります。
- **通知チャンネル名**は、ユーザーに表示される通知チャンネルの名前です。

> 基本通知チャンネルを設定しない場合、下記の値で基本通知チャンネルを作成します。
> **通知チャンネルID**：任意のUUIDをIDに使用します。
> **通知チャンネル名**：アプリケーションの名前を通知チャンネル名に使用します。

### 基本通知チャンネルの設定例
```java
ToastNotification.setDefaultNotificationChannel(context,
    "YOUR_NOTIFICATION_CHANNEL_ID",
    "YOUR_NOTIFICATION_CHANNEL_NAME");
```

## 通知リソース設定

### 通知音リソース
- プッシュ発送時soundフィールドを追加すると、ローカルリソース（mp3、wavファイル）を通知音として設定することができます。（アンドロイド8.0未満でのみ動作）
    - プッシュ発送時soundフィールドにローカルリソースの名前だけ（拡張子を除く）を入力する必要があります。
- ローカルリソースは、必ずリソースフォルダ下位のrawフォルダにする必要があります。
    - 例) main/res/raw/dingdong1.wav

## リッチメッセージ

### リッチメッセージとは？
- **リッチメッセージ**とは、タイトル、本文と一緒に受信できるリッチなメッセージです。

### サポートするリッチメッセージ
#### ボタン
- 通知削除：現在の通知を削除します。
- アプリを開く：アプリを実行します。
- URLを開く：特定のURLに移動します。
    - Custom schemeを利用したActivity/BroadcastReceiver移動も可能
- 返信：通知から返信を送ります。
    - Android 7.0(APIレベル24)以上でのみ使用可能です。

> ボタンは最大3個までサポートします。

#### メディア
- 画像：通知に画像を追加します。 (内部、外部画像をサポート)
    - 画像の横と縦の比率は2:1を推奨します。
    - 異なる比率の画像は、見切れて表示されることがあります。
- その他：その他のメディア(動画、音声など)はサポートしていません。

#### 大きなアイコン
- 通知に大きなアイコンを追加します。 (内部、外部画像をサポート)
    - 大きなアイコンの画像は、1:1の比率を推奨します。
    - 異なる比率の画像は、強制的に比率が1:1に変更されるため、期待と異なる画像が表示されることがあります。

#### グループ
- 同じキーの通知を1つにまとめます。
- Android 7.0(APIレベル24)以上でのみ使用可能です。

### リッチメッセージの変換方法
- リッチメッセージは、TOAST PushのWebコンソールで送信できます。また、メッセージ送信APIのrichMessageフィールドを追加して、送信することもできます。
- リッチメッセージを決められた形式で送信した場合、別途の変換プロセスを経ずにリッチメッセージ通知が登録されます。

### ReplyActionListenerの登録
- リッチメッセージの返信(またはレスポンス)ボタンを使用する場合、ユーザーの入力メッセージを受け取って別途の処理が必要です。
- このためにReplyActionListenerを提供します。
- ReplyActionListenerは、**必ず**ApplicationのonCreateで登録してください。

> (注意)ユーザーが入力を完了して送信ボタンを押すと、通知(Notification)はローディングバーが表示され、通知が削除されません。
> したがって、返信処理が完了したら通知(Notification)を削除するか、アップデートするコードを追加する必要があります。
> 下記のサンプルコードを参考にしてください。

#### ReplyActionListener登録例

```java
public class ToastPushSampleApplication extends Application {
    @Override
    public void onCreate() {
        ToastNotification.setReplyActionListener(new ReplyActionListener() {
            @Override
            public void onReceiveReplyAction(@NonNull Context context, @NonNull ReplyActionResult result) {
                // Do Something (ex. Send message contents to server)

                // Choice 1. Remove previous reply notification with notification id
                NotificationManagerCompat.from(context).cancel(result.getNotificationId());

                // Choice 2. Update previous reply notification with notification id
                NotificationManagerCompat.from(context).notify(result.getNotificationId(),
                        new NotificationCompat.Builder(context, result.getNotificationChannel())
                                .setSmallIcon(/* Resource ID of your icon */ getDefaultIcon(context))
                                .setContentTitle("Send")
                                .setContentText("Success to send message")
                                .build());
            }
        });
    }
}
```

## ユーザー定義メッセージの処理
- 直接受信したメッセージを処理したい場合には、ToastPushMessageReceiverを継承してonMessageReceivedメソッドを実装する必要があります。
- ToastPushMessageReceiverを実装したブロードキャストはAndroidManifest.xmlにも必ず登録する必要があります。

> **(注意)**
> 1. 受信したメッセージを直接処理する場合には、通知（Notification）の処理は、ユーザーが自分であります。
> 2. 受信したメッセージを直接処理する場合には、「受信」/「オープン」の指標の機能のために追加の作業が必要です。（下の指標の収集機能を追加セクションを参)

### ToastPushMessagingService例示
```java
public class UserCustomReceiver extends ToastPushMessageReceiver {
    @Override
    public void onMessageReceived(@NonNull Context context, @NonNull ToastRemoteMessage remoteMessage) {
        final ToastPushMessage message = remoteMessage.getMessage();
        final CharSequence title = message.getTitle();
        final CharSequence body = message.getBody();
        final RichMessage richMessage = message.getRichMessage();
        final Map<String, String> extras = message.getExtras();

        // 通知の処理
    }
}
```

### AndroidManifest.xml例示
> **(注意)**
> ToastPushMessageReceiverを使用する場合には、permissionが必要です。

```xml
<manifest>
    <application>
    <receiver android:name=".ToastPushSampleReceiver"
        android:permission="${applicationId}.toast.push.permission.RECEIVE">
        <intent-filter>
            <action android:name="com.toast.android.push.MESSAGE_EVENT" />
            </intent-filter>
    </receiver>

        <!-- 省略 -->
    </application>

    <!-- 省略 -->
</manifest>
```

### 指標の収集機能を有効に(FCM Only)
- 受信したメッセージを直接処理する場合には、指標の収集機能を有効にするために追加の作業が必要です。
- ToastPushAnalyticsNotificationExtenderを作成し、NotificationCompat.Builderを展開します。

#### 指標の収集機能の例
```java
@Override
public void onMessageReceived(@NonNull ToastRemoteMessage remoteMessage) {
    final ToastPushMessage message = remoteMessage.getMessage();

    NotificationCompat.Builder builder = new NotificationCompat.Builder(context, "YOUR_CHANNE_ID");
    // (省略)

    Intent launchIntent = new Intent(context, MainActivity.class); // 알림 클릭시 동작을 Intent로 정의함
    ToastPushAnalyticsNotificationExtender extender = new ToastPushAnalyticsNotificationExtender(launchIntent);
    builder = extender.extend(context, message, builder);

    Notification notification = builder.build();
}
```
## Emoji使用
> **(注意)**
> 機器でサポートしていないemojiを使用した場合には、表示されないことがあります。
> Tencentの場合には、emojiを使用すると、メッセージが受信されない場合があります。

## TOAST Push Class Reference
### ToastPushConfiguration
- TOAST Pushを初期化する時に渡されるPush設定情報です。

```java
/* ToastPushConfiguration.java */
public String getAppKey();
public static Builder newBuilder(@NonNull Context context, @NonNull String appKey);
```

| Method | Returns | |
|---|---|---|
| getAppKey | String | Pushサービスアプリキーを返します。 |
| static newBuilder | ToastPushConfiguration.Builder | ToastPushConfigurationオブジェクト作成のためのビルダーを作成します。 |

### PushResult
- 非同期APIの呼び出し時に、コールバックのレスポンスに返される結果オブジェクトです。


```java
/* PushResult.java */
public int getCode();
public String getMessage();
public boolean isSuccess();
public boolean isFailure();
```

| Method | Returns | |
|---|---|---|
| getCode | int | 結果コードを返します。 |
| getMessage | int | 結果メッセージを返します。 |
| isSuccess | boolean | 成功したかを返します。 |
| isFailure | boolean | 失敗したかを返します。 |

### TokenInfo
- トークン情報照会呼び出し時、コールバックで返されるトークン情報が入っているオブジェクトです。

```java
/* TokenInfo.java */
public String getPushType();
public ToastPushAgreement getAgreement();
public String getTimeZone();
public String getCountry();
public String getLanguage();
public String getUserId();
public Date getActivatedDateTime();
public String getToken();
```

| Method | Returns | |
|---|---|---|
| getPushType | String | Pushタイプを返します。 |
| getAgreement | ToastPushAgreement | 通知/広告/夜間広告などに同意しているかを返します。 |
| getTimeZone | String | タイムゾーンを返します。 |
| getCountry | String | 国コードを返します。 |
| getLanguage | String | 言語コードを返します。 |
| getUserId | String | ユーザーIDを返します。 |
| getActivatedDateTime | Date | トークンの最近の登録日時を返します。 |
| getToken | String | トークンを返します。 |
