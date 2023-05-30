## NHN Cloud > SDK使用ガイド > Push > Android

## 事前準備

1. [NHN Cloud SDK](./getting-started-android)をインストールします。
2. [NHN Cloudコンソール](https://console.nhncloud.com)で、[Pushサービスを有効化](https://nhncloud.com/ja/Notification/Push/ja/console-guide/)します。
3. PushコンソールでAppKeyを確認します。

## Push提供者別ガイド

* [Firebase Cloud Messaging (以下FCM)ガイド](https://firebase.google.com/docs/cloud-messaging/)
* `Tencent Push Notification (QQ) 2020年11月サービス終了`

## ライブラリ設定

### FCM
* FCM用SDKをインストールするには、下記のコードをbuild.gradleに追加します。

```groovy
repositories {
    google()
    mavenCentral()
}

dependencies {
    implementation 'com.nhncloud.android:nhncloud-push-fcm:1.5.1'
    ...
}
```

### ADM
* NHN Cloud ADM Pushを使用するために、以下のようにbuild.gradleに依存関係を追加します。

```groovy
repositories {
    google()
    mavenCentral()
}

dependencies {
    implementation 'com.nhncloud.android:nhncloud-push-adm:1.5.1'
    ...
}
```

## Firebase Cloud Messagingの設定

### プロジェクトおよびアプリ追加
* [Firebaseコンソール](https://console.firebase.google.com/?hl=ko)でプロジェクトを作成します。
* コンソールの上部にある歯車ボタンをクリックして**プロジェクト設定**に移動します。
* プロジェクト設定の**マイアプリ**で、**AndroidアプリにFirebase追加**をクリックします。
* **Androidパッケージ名**、**アプリニックネーム(選択事項)**を入力し、**アプリ登録**ボタンをクリックします。
* **google-services.jsonダウンロード**ボタンをクリックして、設定情報をダウンロードします。
* ダウンロードした **google-services.json**ファイルをアプリのモジュール(アプリレベル)ディレクトリーに移動します。
* 詳細は、[AndroidプロジェクトにFirebase追加](https://firebase.google.com/docs/android/setup)をご参照ください。

### build.gradle設定
#### ルートレベルのbuild.gradle
* ルートレベルのbuild.gradleに、下記のコードを追加します。

```groovy
buildscript {
    // ...
    dependencies {
        // ...
        classpath "com.google.gms:google-services:$google_services_version" // google-services plugin
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
* アプリモジュールのbuild.gradleに、下記のコードを追加します。

```groovy
apply plugin: 'com.android.application'

android {
  // ...
}

// ADD THIS AT THE BOTTOM
apply plugin: 'com.google.gms.google-services'
```

## Amazon Device Messageing設定

### プロジェクトおよびアプリ追加

* [Amazon Developerコンソール](https://developer.amazon.com/settings/console/home)に移動します。
* 上部**Apps & Services**の**My Apps**に移動します。
* **Add New App**で**Android**を選択し、アプリ情報を入力してアプリを登録します。
* **Androidパッケージ名**、**アプリニックネーム(任意)**を入力し、**アプリ登録**ボタンをクリックします。

### API Key追加

* **My Apps**で登録したアプリを選択し、左側メニューで**App Service**をクリックします。
* Device Messagingで**Security Profile**を作成し、登録します。
* **View Security Profile**に移動して **Android/Kindle Settings**メニューkからAPI Keyを作成します。
* 作成したAPI Keyをコピーしてプロジェクトの**assets**フォルダに**api_key.txt**ファイルとして保存します。
* 詳細については、[Amazon Device Messageing - Obtain Credentials](https://developer.amazon.com/docs/adm/obtain-credentials.html)を参照してください。

### ADM SDKのダウンロード

* Amazon Developerの[Amazon Device Messaging (ADM) SDKs](https://developer.amazon.com/docs/apps-and-games/sdk-downloads.html#adm)からADM SDKをダウンロードします。
* ダウンロードした**amazon-device-messaging-1.2.0.jar**ファイルをプロジェクトの**amazon/libs**フォルダに保存します。

#### アプリモジュールのbuild.gradle
```groovy
dependencies {
    //...
    compileOnly files('amazon/libs/amazon-device-messaging-1.2.0.jar')
}
```

### Proguard設定

* Proguardを使用する場合 <b>[proguard-rules.pro](http://proguard-rules.pro)</b>ファイルに以下のように追加します。

```groovy
-libraryjars amazon/libs/amazon-device-messaging-1.2.0.jar
-dontwarn com.amazon.device.messaging.**
-keep class com.amazon.device.messaging.** { *; }
-keep public class * extends com.amazon.device.messaging.ADMMessageReceiver
-keep public class * extends com.amazon.device.messaging.ADMMessageHandlerBase
-keep public class * extends com.amazon.device.messaging.ADMMessageHandlerJobBase
```

## Push初期化
* NhnCloudPush.initializeを呼び出してNHN Cloud Pushを初期化します。
* [NhnCloudPushConfiguration](./push-android/#nhncloudpushconfiguration)オブジェクトは、Push設定情報を含んでいます。
* [NhnCloudPushConfiguration](./push-android/#nhncloudpushconfiguration)オブジェクトは、NhnCloudPushConfiguration.Builderを使用して作成できます。
* Pushコンソールで発行されたAppKeyをNhnCloudPushConfiguration.newBuilderの引数に渡します。
* 使用したいPushTypeを初期化の呼び出し時にお届けしなければなりません。

### FCM初期化例

```java
NhnCloudPushConfiguration configuration =
    NhnCloudPushConfiguration.newBuilder(context, "YOUR_APP_KEY")
            .build();

NhnCloudPush.initialize(PushType.FCM, configuration);
```

### ADM初期化例

```java
NhnCloudPushConfiguration configuration =
    NhnCloudPushConfiguration.newBuilder(context, "YOUR_APP_KEY")
            .build();

NhnCloudPush.initialize(PushType.ADM, configuration);
```

> NhnCloudPush.initialize(NhnCloudPushConfiguration)はDeprecatedされました。
> NhnCloudPush.initialize(NhnCloudPushConfiguration)を使用して初期化する場合PushTypeは自動的にFCMに設定されます。

## サービスログイン
* NHN Cloud SDKで提供するすべてのサービス(Push、IAP、Log & Crashなど)は、1つの同じユーザーIDを使用します。
    * [NhnCloudSdk.setUserId](./getting-started-android/#userid)にユーザーIDを設定できます。
* サービスログイン段階でユーザーID設定、トークン登録機能を実装することを推奨します。
* トークンの登録後、ユーザーIDを設定または変更すると、トークン情報を更新します。

### サービスログイン例

```java
public void onLogin(String userId) {
    // Login.
    NhnCloudSdk.setUserId(userId);
    // トークン登録など
}
```

## トークン登録
* NhnCloudPush.registerToken()メソッドを使用してPushトークンをNHN Cloud Pushサーバーに転送します。 この時、受信同意可否(NhnCloudPushAgreement)をパラメータで伝えます。
* 最初のトークン登録時のユーザー名が設定されていなければ、端末識別子を使用して登録します。
* トークンの登録に成功すると、Push メッセージを受信することができます。

### 受信同意設定
* 韓国情報通信網法規定(第50条から第50条の8)に従い、トークン登録時の通知/広告性/夜間広告性プッシュメッセージ受信に同意するかも一緒に入力を受けます。メッセージ送信時に受信に同意しているかを基準に自動的にフィルタリングします。
    * [KISAガイドへ](https://www.kisa.or.kr/2060301/form?postSeq=19)
    * [法令へ（韓国語）](http://www.law.go.kr/법령/정보통신망이용촉진및정보보호등에관한법률/%2820130218,11322,20120217%29/제50조)
* NhnCloudPushAgreementに受信同意の可否を設定し、トークン登録時にNHN Cloud Pushサーバーに転送します。

### トークン登録例
```java
NhnCloudPushAgreement agreement = NhnCloudPushAgreement.newBuilder(true)  // 通知を受信するか
        .setAllowAdvertisements(true)       // 広告を受信するか
        .setAllowNightAdvertisements(true)  // 夜間広告を受信するか
        .build();

NhnCloudPush.registerToken(context, agreement, new RegisterTokenCallback() {
    @Override
    public void onRegister(@NonNull PushResult result,
                           @Nullable String token) {

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
* NHN Cloud Pushサーバーに登録されているトークン情報を照会します。

### トークン情報照会例
```java
NhnCloudPush.queryTokenInfo(ㅊontext, new QueryTokenInfoCallback() {
    @Override
    public void onQuery(@NonNull PushResult result, @Nullable TokenInfo tokenInfo) {
        if (result.isSuccess()) {
            // トークン情報照会成功
            String token = tokenInfo.getToken();
            NhnCloudPushAgreement agreement = tokenInfo.getAgreement();

        } else {
            // トークン情報照会失敗
            int code = result.getCode();
            String message = result.getMessage();
        }
    }
});
```

## トークン解除
* NHN Cloud Push サーバーに登録されたトークンを解除します。 解除されたトークンはメッセージの送信対象外となります。
* `サービスログアウト後にメッセージ受信をご希望にならなければトークンを解除しなければなりません。`
* `トークンが解除されても端末のお知らせ権限は回収されません。`

>すでに解除されたトークンを解除すると、「既に解除されたトークンです（Already a token has been unregistered）」というメッセージと一緒に成功を返します。

### トークン解除例
```java
NhnCloudPush.unregisterToken(mContext, new UnregisterTokenCallback() {
    @Override
    public void onUnregister(@NonNull PushResult result,
                             @Nullable String unregisteredToken) {

        if (result.isSuccess()) {
            // トークン解除成功
        } else {
            // トークン解除失敗
            int code = result.getCode();
            String message = result.getMessage();
        }
    }
});
```

## メッセージ受信
* Pushメッセージを受信時に、OnReceiveMessageListenerを通じて通知を受けることができます。
* Pushメッセージ受信リスナーは、NhnCloudPush.setOnReceiveMessageListenerメソッドを使用して登録できます。
* OnReceiveMessageListenerに渡された[NhnCloudPushMessage](./push-android/#nhncloudpushmessage)オブジェクトからメッセージ情報を確認できます。
* アプリが実行されていな場合でも、メッセージの受信通知を受信するためには`Application#onCreate`に登録してください。

> メッセージを受信時にユーザーがアプリを使用中(Foreground)の場合、通知を表示しません。
> Foregroundかどうかは、OnReceiveMessageListener#onReceiveに伝達されるisForegroundで確認できます。

### メッセージ受信リスナー登録例

``` java
public class MyApplication extends Application {
    @Override
    public void onCreate() {
        // ...

        NhnCloudPush.setOnReceiveMessageListener(new OnReceiveMessageListener() {
            @Override
            public void onReceive(@NonNull NhnCloudPushMessage message,
                                  boolean isForeground) {

                // ユーザーがアプリ使用中にも通知を表示
                if (isForeground) {
                    NhnCloudNotification.notify(getApplicationContext(), message);
                }
            }
        });

        // ...
    }
}
```

## 通知権限

* Android 13 (APIレベル33)以上で通知表示のためにPOST\_NOTIFICATIONS権限が必要です。
* 基本的にNHN Cloud SDK(バージョン1.2.0以上)にはマニフェストにPOST\_NOTIFICATIONS権限が含まれています。
* アプリで通知を表示するにはランタイム権限をリクエストしなければならず、ユーザーがこの権限を付与するまでアプリで通知を表示できません。

### Android 13(APIレベル33)以上をターゲティングするアプリの通知権限

* Android 13(APIレベル33)以上をターゲティングする時、requestPostNotificationsPermission APIを利用して通知ランタイム権限をリクエストできます。

``` java
if (Build.VERSION.SDK_INT >= 33) {
    NhnCloudNotification.requestPostNotificationsPermission(this, PERMISSION_REQUEST_CODE);
}
```

### Android 12(APIレベル32)以下をターゲティングするアプリの通知権限

* Android 12(APIレベル32)以下をターゲティングする場合、アプリがフォアグラウンドにする時、アプリで通知チャンネルを初めて作成するとAndroidで自動的にユーザーに権限をリクエストします。
* アプリがバックグラウンドで実行中の時、最初の通知チャンネルを作る場合、アプリを開くまで通知が表示されず、ユーザーに通知権限をリクエストしません。
すなわち、アプリを開きユーザーが権限を受け入れる前は通知が表示されません。
* Android 12(APIレベル32)以下をターゲティングするアプリは、アプリ初回実行時に通知チャンネルを作成してユーザーに権限をリクエストする必要があります。

``` java
if (Build.VERSION.SDK_INT <= 32) {
    NotificationChannel channel = NhnCloudNotification.getNotificationChannel(this);
    if (channel == null) {
        NhnCloudNotification.createNotificationChannel(this);
    }
}
```

## 通知クリック

* ユーザーが公開された通知をクリックしアプリが実行された時に、OnClickListenerを通じて通知を受けることができます。
* 通知クリックリスナーは、NhnCloudNotification.setOnClickListener関数を使用して登録できます。
* アプリが実行されていない場合でも通知クリック通知を受けるためには、`Application#onCreate` から登録する必要があります。

### 通知クリックリスナー登録例

```java
public class MyApplication extends Application {
    @Override
    public void onCreate() {
        // ...

        NhnCloudNotification.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(@NonNull NhnCloudPushMessage message) {
                // メッセージ内容に基づいてページ移動などのサービスロジック実行が可能です。
                Map<String, String> extras = message.getExtras();
            }
        });

        // ...
    }
}
```

## 通知設定

## 通知設定

### 基本通知チャネル名の設定
* 通知チャンネル名は、Android 8.0(API レベル26) 以上の端末の通知設定に表示するチャンネル名です。
* 通知に別途チャンネルを設定しない場合は、基本の通知チャンネルに通知がリクエストされます。
* 通知の基本オプション設定時、適用のための基本通知チャンネルが新しく作成されます。
* `Application#onCreate`で登録したり、AndroidManifest.xmlファイルにメタデータとして定義できます。

> 基本通知チャンネル名を設定しない場合、アプリケーション名で自動設定されます。

#### デフォルト通知チャネル名の設定例
##### コードでの設定例
```java
public class MyApplication extends Application {
    @Override
    public void onCreate() {
        // ...

        NhnCloudNotification.setDefaultChannelName(context, "YOUR_CHANNEL_NAME");

        // ...
    }
}
```

##### AndroidManifest.xmlメタデータでの定義例
```xml
<!-- デフォルトチャンネルの名前設定 -->
<meta-data android:name="com.toast.sdk.push.notification.default_channel_name"
           android:value="@string/default_notification_channel_name"/>
```

### 通知基本オプション設定
* 通知の優先順位、小さなアイコン、背景色、LEDライト、振動、通知音を設定します。
* アプリがフォアグラウンド状態である場合、通知を表示するかどうかを設定します。
* バッジアイコンを使用するかどうかを設定します。
* Android 8.0(APIレベル26)以上の端末では、基本通知チャンネルにのみオプションが適用されます。
* `Application#onCreate`で登録したり、AndroidManifest.xmlファイルにメタデータとして定義できます。

#### 通知基本オプションの設定例
##### コードでの設定例
**全通知オプションを変更する場合**
```java
public class MyApplication extends Application {
    @Override
    public void onCreate() {
        // ...

        NhnCloudNotificationOptions defaultOptions = new NhnCloudNotificationOptions.Builder()
                .setPriority(NotificationCompat.PRIORITY_HIGH)  // 通知優先順位設定
                .setColor(0x0085AA)                             // 通知背景色設定
                .setLights(Color.RED, 0, 300)                   // LEDライト設定
                .setSmallIcon(R.drawable.ic_notification)       // 小さなアイコン設定
                .setSound(context, R.raw.dingdong1)             // 通知音設定
                .setVibratePattern(new long[] {500, 700, 1000}) // 振動パターン設定
                .enableForeground(true)                         // フォアグラウンド通知表示設定
                .enableBadge(true)                              // バッジアイコン使用設定
                .build();

        NhnCloudNotification.setDefaultOptions(context, defaultOptions);

        // ...
    }
}
```

**設定された通知オプションの一部のみ変更する場合**
```java
public class MyApplication extends Application {
    @Override
    public void onCreate() {
        // ...

        // 設定済みの基本通知オプション取得
        NhnCloudNotificationOptions defaultOptions = NhnCloudNotification.getDefaultOptions(context);

        // 通知オプションオブジェクトからビルダー作成
        NhnCloudNotificationOptions newDefaultOptions = defaultOptions.buildUpon()
                .enableForeground(true)      // フォアグラウンド通知の表示設定のみ変更
                .build();

        NhnCloudNotification.setDefaultOptions(context, newDefaultOptions);

        // ...
    }
}
```

##### AndroidManifest.xmlメタデータで定義例
```xml
<!-- 通知優先順位 -->
<meta-data android:name="com.toast.sdk.push.notification.default_priority"
           android:value="1"/>
<!-- 通知背景色 -->
<meta-data android:name="com.toast.sdk.push.notification.default_background_color"
           android:resource="@color/defaultNotificationColor"/>
<!-- LEDライト -->
<meta-data android:name="com.toast.sdk.push.notification.default_light_color"
           android:value="#0000ff"/>
<meta-data android:name="com.toast.sdk.push.notification.default_light_on_ms"
           android:value="0"/>
<meta-data android:name="com.toast.sdk.push.notification.default_light_off_ms"
           android:value="500"/>
<!-- 小さなアイコン -->
<meta-data android:name="com.toast.sdk.push.notification.default_small_icon"
           android:resource="@drawable/ic_notification"/>
<!-- 通知音 -->
<meta-data android:name="com.toast.sdk.push.notification.default_sound"
           android:value="notification_sound"/>
<!-- 振動パターン -->
<meta-data android:name="com.toast.sdk.push.notification.default_vibrate_pattern"
           android:resource="@array/default_vibrate_pattern"/>
<!-- バッジアイコン使用 -->
<meta-data android:name="com.toast.sdk.push.notification.badge_enabled"
           android:value="true"/>
<!-- アプリ実行中の通知表示 -->
<meta-data android:name="com.toast.sdk.push.notification.foreground_enabled"
           android:value="false"/>
```

### 通知音設定
* プッシュ発送時soundフィールドを追加すると、ローカルリソース（mp3、wavファイル）を通知音として設定することができます。（アンドロイド8.0未満でのみ動作）
* お知らせはアプリケーション リソース フォルダ下位の raw フォルダにあるローカル リソースのみ使用可能です。
    * 例) main/res/raw/notification_sound.wav

## リッチメッセージ

### リッチメッセージとは？
* リッチメッセージは、お知らせのタイトル、本文と共にイメージをお知らせに表現し、ボタン、返信などのアクションを追加します。

### サポートするリッチメッセージ

#### ボタン
| タイプ | 機能 | アクション |
| --- | ------- | --- |
| アプリを開く (OPEN_APP) | アプリを実行します。 | PushAction.ActionType.OPEN_APP |
| URLを開く (OPEN_URL) | URLで移動<br/>(ウェブURLアドレスもしくはアプリカスタムスキームを実行) | PushAction.ActionType.OPEN_URL |
| 返信 (REPLY) | 通知から返信を送ります。 | PushAction.ActionType.REPLY |
| 通知削除 (DISMISS) | 現在の通知を削除します。 | PushAction.ActionType.DISMISS |

* 返信(REPLY)ボタンはAndroid 7.0(APIレベル24)以上から使用できます。

> ボタンは最大3個までサポートします。

#### メディア
* アプリケーション内のリソースID、Android Assetsファイル経路、URLでファイル指定が可能です。
* 画像以外の動画、音などのメディアはサポートしません。
* 画像は、縦と横の比率が2:1の画像を推奨します。
    * Small : 512 x 256
    * Medium : 1024 x 512
    * Large : 2048 x 1024

> ウェブ URL を使用すると、メディア ファイルのダウンロードに時間がかかります。

#### 大きなアイコン
* アプリケーション内のリソースID、Android Assetsファイル経路、URLでファイル指定が可能です。
* 大きいアイコンの画像は、1:1の割合を推奨します。

> 使用済み画像が1:1の比率ではない場合、強制的に1:1に変更されるため、期待とは異なる画像が露出されることがあります。

#### グループ
* 同じキーの通知を1つにまとめます。
* Android 7.0(APIレベル24)以上から使用できます。

### 通知アクションリスナー登録
* ユーザーが通知のボタン、または返信送信ボタンをクリックすると、通知アクション リスナーに通知します。
* [PushAction](./push-android/#pushaction) オブジェクトでアクション情報を確認できます。
* アプリが実行中でない場合でもメッセージ受信通知を受けるためには`Application#onCreate`から登録する必要があります。

#### 通知アクションリスナー登録例

``` java
public class MyApplication extends Application {
    @Override
    public void onCreate() {
        // ...

        NhnCloudNotification.setOnActionListener(new OnActionListener() {
            @Override
            public void onAction(@NonNull PushAction action) {
                // 返信アクションの場合、サービスサーバーにその内容を転送
                if (action.getActionType() == PushAction.ActionType.REPLY) {
                    // ユーザーが入力した返信内容を取得
                    String userText = action.getUserText();
                    // サービスサーバーにユーザー入力内容を送信
                }
            }
        });

        // ...
    }
}
```

## ユーザー定義メッセージ処理
* メッセージの受信後、別の処理過程を実行したり、受信したメッセージの内容を修正して通知を表示しなければならない場合は、[NhnCloudPushMessageReceiver](./push-android/#nhncloudpushmessagereceiver)を継承するブロードキャストを実装する必要があります。
* NhnCloudPushMessageReceiverを継承したブロートキャストは、AndroidManifest.xmlも必ず登録しなければなりません。
* メッセージを受信すると、onMessageReceived関数で受信したメッセージが伝達されます。

> **(注意)**
> 1. onMessageReceived関数でメッセージ受信後に通知表示をリクエスト(notify)しないと、通知が表示されません。
> 2. 通知を直接作成する場合は、Pushサービスコンテンツを通知のコンテンツインテントとして設定することで、指標収集が可能になります。(以下の指標収集機能の追加セクション参照)

### NhnCloudPushMessagingService実装コード例
```java
public class MyPushMessageReceiver extends NhnCloudPushMessageReceiver {
    @Override
    public void onMessageReceived(@NonNull Context context,
                                  @NonNull NhnCloudRemoteMessage remoteMessage) {

        // チャンネルID変更
        remoteMessage.setChannelId("channel");

        // メッセージ内容修正
        NhnCloudPushMessage message = remoteMessage.getMessage();
        CharSequence title = message.getTitle();

        message.setTitle("[Modified] " + title);

        // 実行インテント設定(未設定の場合、パッケージの基本メインアクティビティ実行)
        Intent launchIntent = new Intent(context, MainActivity.class);

        PendingIntent contentIntent = PendingIntent.getActivity(
                context,
                REQUEST_CODE,
                launchIntent,
                PendingIntent.FLAG_UPDATE_CURRENT);

        // ユーザーがアプリ使用中の場合とそうでない場合を区別して通知を表示したい場合
        if (!isAppForeground()) {
            // 通知作成および表示
            notify(context, remoteMessage, contentIntent);

        } else {
            // 特定UI画面の表示
            NhnCloud.makeText(context, message.title, NhnCloud.LENGTH_SHORT).show();
        }
    }
}
```

### AndroidManifest.xml 登録例
> **(注意)**
> 1. NhnCloudPushMessageReceiverを使う場合は、必ずpermissionを設定しなければなりません。
> 2. APIレベル31以上をターゲットとする時、exportedプロパティを設定する必要があります。 

```xml
<manifest>
    <application>
    <receiver android:name=".NhnCloudPushSampleReceiver"
        android:permission="${applicationId}.toast.push.permission.RECEIVE"
        android:exported="false">
        <intent-filter>
            <action android:name="com.toast.android.push.MESSAGE_EVENT" />
            </intent-filter>
    </receiver>

        <!-- 省略 -->
    </application>

    <!-- 省略 -->
</manifest>
```

### 指標収集機能の追加(FCM Only)
* 通知を直接作成する場合、指標収集機能を使用するにはgetContentIntent()関数を使用して作成したインテントを通知のコンテンツインテントに設定する必要があります。

#### 指標収集機能追加例
```java
public class MyPushMessageReceiver extends NhnCloudPushMessageReceiver {
    private NotificationManager mManager = null;

    @Override
    public void onMessageReceived(
            @NonNull Context context,
            @NonNull NhnCloudRemoteMessage remoteMessage) {

        // メッセージ内容の取得
        NhnCloudPushMessage message = remoteMessage.getMessage();

        //NotificationManagerの作成
        if (mManager == null) {
            mManager = (NotificationManager) context.getSystemService(Context.NOTIFICATION_SERVICE);
            if  (mManager == null) {
                Log.e(TAG, "Failed to get NotificationManager");
                return;
            }
        }

        // チャンネル設定
        String channelId = "YOUR_CHANNEL_ID";
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            NotificationChannel channel = mManager.getNotificationChannel(channelId);
            if (channel == null) {
                String channelName = "YOUR_CHANNEL_NAME";
                createNotificationChannel(channelId, channelName);
            }
        }

        // 実行インテントの設定
        Intent launchIntent = new Intent(context, MainActivity.class);

        // 指標転送を含むコンテンツインテントの作成
        PendingIntent contentIntent;
        contentIntent = getContentIntent(context, remoteMessage, launchIntent);

        //通知作成
        NotificationCompat.Builder builder = new NotificationCompat.Builder(context, channelId);
        builder.setContentTitle(message.getTitle())
                .setContentText(message.getBody())
                .setSmallIcon(R.drawable.ic_notification)
                .setContentIntent(contentIntent)
                .setAutoCancel(true);
     
        notify(context, NotificationUtils.createNewId(), builder.build());
    }
    ...
}
```

## Emoji使用
> **(注意)**
> 機器でサポートしていないemojiを使用した場合には、表示されないことがあります。

## ユーザータグ

* [ユーザータグ](https://nhncloud.com/ja/Notification/Push/ja/console-guide/#_16) 機能はさまざまなユーザーIDをひとつのタグでまとめ、それを利用してメッセージを送信することができます。
* タグ名ではなく、タグID(8桁の文字列)に基づいて動作します。タグIDはコンソール > タグメニューから作成·確認できます。

### ユーザータグ修正

#### ユーザータグ修正例

* 入力されたタグIDリストを追加またはアップデートし、最終反映されたタグIDリストを返します。

```java
// 追加するタグIDリスト作成
Set<String> tagIds = new HashSet<>();
tagIds.add(TAG_ID_1);   // e.g. "ZZPP00b6" (8桁の文字列)
tagIds.add(TAG_ID_2);

// ログインされているユーザーIDのタグIDリスト追加
NhnCloudPush.addUserTag(tagIds, new UserTagCallback() {
    @Override
    public void onResult(@NonNull PushResult result, @Nullable Set<String> tagIds) {
        if (result.isSuccess()) {
            // ユーザータグID追加成功
        } else {
            // ユーザータグID追加失敗
            int errorCode = result.getCode();
            String errorMessage = result.getMessage();
        }
    }
});

// ログインされているユーザーIDのタグIDリストアップデート(既存のタグIDリストは削除され、入力した値に設定)
NhnCloudPush.setUserTag(tagIds, new UserTagCallback() {
    @Override
    public void onResult(@NonNull PushResult result, @Nullable Set<String> tagIds) {
        if (result.isSuccess()) {
            // ユーザータグIDリストアップデート成功
        } else {
            // ユーザータグIDリストアップデート失敗
            int errorCode = result.getCode();
            String errorMessage = result.getMessage();
        }
    }
});
```

### ユーザータグ取得

* 現在のユーザーに登録されたすべてのタグIDリストを返します。

#### ユーザータグ取得例

```java
// ログインされているユーザーIDの全タグIDリストを返します。
NhnCloudPush.getUserTag(new UserTagCallback() {
    @Override
    public void onResult(@NonNull PushResult result, @Nullable Set<String> tagIds) {
        if (result.isSuccess()) {
            // ユーザータグIDリスト取得成功
        } else {
            // ユーザータグIDリスト取得失敗
            int errorCode = result.getCode();
            String errorMessage = result.getMessage();
        }
    }
});
```

### ユーザータグの削除

#### ユーザータグの削除例

* 入力されたユーザータグIDリストを削除し、最終的に反映されたタグIDリストを返します。

```java
// 削除するタグIDリスト作成
Set<String> tagIds = new HashSet<>();
tagIds.add(TAG_ID_1);   // e.g. "ZZPP00b6" (8桁の文字列)
tagIds.add(TAG_ID_2);

// ログインされているユーザーIDのタグIDリスト削除
NhnCloudPush.removeUserTag(tagIds, new UserTagCallback() {
    @Override
    public void onResult(@NonNull PushResult result, @Nullable Set<String> tagIds) {
        if (result.isSuccess()) {
            // ユーザータグIDリスト削除成功
        } else {
            // ユーザータグIDリスト削除失敗
            int errorCode = result.getCode();
            String errorMessage = result.getMessage();
        }
    }
});

// ログインされているユーザーIDの全タグIDリスト削除
NhnCloudPush.removeAllUserTag(new UserTagCallback() {
    @Override
    public void onResult(@NonNull PushResult result, @Nullable Set<String> tagIds) {
        if (result.isSuccess()) {
            // 全ユーザータグ削除成功
        } else {
            // 全ユーザータグ削除失敗
            int errorCode = result.getCode();
            String errorMessage = result.getMessage();
        }
    }
});
```

## NHN Cloud Push Class Reference
### NhnCloudPushConfiguration
* NHN Cloud Pushを初期化する時に渡されるPush設定情報です。

```java
/* NhnCloudPushConfiguration.java */
public String getAppKey();
public static Builder newBuilder(@NonNull Context context, @NonNull String appKey);
```

| Method | Returns | |
|---|---|---|
| getAppKey | String | Pushサービスアプリキーを返します。 |
| static newBuilder | NhnCloudPushConfiguration.Builder | NhnCloudPushConfigurationオブジェクト作成のためのビルダーを作成します。 |

### PushResult
* 非同期APIの呼び出し時に、コールバックのレスポンスに返される結果オブジェクトです。


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
* トークン情報照会呼び出し時、コールバックで返されるトークン情報が入っているオブジェクトです。

```java
/* TokenInfo.java */
public String getPushType();
public NhnCloudPushAgreement getAgreement();
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
| getAgreement | NhnCloudPushAgreement | 通知/広告/夜間広告などに同意しているかを返します。 |
| getTimeZone | String | タイムゾーンを返します。 |
| getCountry | String | 国コードを返します。 |
| getLanguage | String | 言語コードを返します。 |
| getUserId | String | ユーザーIDを返します。 |
| getActivatedDateTime | Date | トークンの最近の登録日時を返します。 |
| getToken | String | トークンを返します。 |

### NhnCloudRemoteMessage
* メッセージ受信リスナー、カスタムレシーバからのメッセージ受信時に返されるオブジェクトです。

``` java
/* NhnCloudRemoteMessage.java */
public String getChannelId();
public void setChannelId(String channelId);
public NhnCloudPushMessage getMessage();
public String getSenderId();
```

| Method | Returns | |
|---|---|---|
| getChannelId | String | チャンネルIDを返します。 |
| setChannelId |  | チャンネルIDを設定します。 |
| getMessage | NhnCloudPushMessage | メッセージオブジェクトを返します。|
| getSenderId | String | 発信者 ID を返します (FCM Only)|

### NhnCloudPushMessage
* 受信したメッセージ内容を含むオブジェクトです。

``` java
/* NhnCloudPushMessage.java */
public String getMessageId();
public String getPusyType();
public String getTitle();
public void setTitle(String title);
public String getBody();
public void setBody(String body);
public RichMessage getRichMessage();
public Map<String, String> getExtras();
```

| Method | Returns | |
|---|---|---|
| getMessageId | String | メッセージ識別子を返します。 |
| getPusyType | String | PushTypeを返します。 |
| getTitle | String | メッセージタイトルを返します。 |
| setTitle |  | メッセージタイトルを設定します。 |
| getBody | String | メッセージ内容を取得します。 |
| setBody |  | メッセージ内容を設定します。 |
| getRichMessage | RichMessage | リッチメッセージ情報を返します。 |
| getExtras |  | 受信したメッセージ全体を返します。 |


### PushAction
* ボタンアクション受信時に返されるオブジェクトがあります。

``` java
/* PushAction.java */
public ActionType getActionType();
public String getNotificationId();
public String getNotificationChannel();
public NhnCloudPushMessage getMessage();
public String getuserText();
```

| Method | Returns | |
|---|---|---|
| getActionType | ActionType | ActionTypeを返します。 |
| getNotificationId | String | アクションが実行された通知のIDを返します。 |
| getNotificationChannel | String | アクションが実行された通知のチャンネルを返します。 |
| getMessage | NhnCloudPushMessage | アクションが設定された通知のメッセージ情報を返します。 |
| getuserText | RichMessage | ユーザーが入力した文字列を返します。 |

### NhnCloudPushMessageReceiver
* メッセージ内容の修正、実行インテント定義、通知の直接生成などの機能のためには、ユーザーが実装する必要があるオブジェクトです。

``` java
/* NhnCloudPushMessageReceiver.java */
public final boolean isAppForeground();
public final void notify(Context context, NhnCloudRemoteMessage message);
public final void notify(Context context, NhnCloudRemoteMessage message, PendingIntent contentIntent);
public final void notify(Context context, int notificationId, Notification notification);
@Deprecated
public final PendingIntent getNotificationServiceIntent(Context context, NhnCloudRemoteMessage message, PendingIntent contentIntent);
public final PendingIntent getContentIntent(Context context, NhnCloudRemoteMessage message, Intent launchIntent);
```

| Method | Returns | Parameters | |
|---|---|---|---|
| isAppForeground | boolean |  | 現在アプリを使用中かどうかを返します。 |
| notify | | Context, NhnCloudRemoteMessage | 基本実行インテントで通知を生成および表示します。 |
| notify | | Context, NhnCloudRemoteMessage, PendingIntent | ユーザー実行インテントで通知を生成および表示します。 |
| notify | | Context, int, Notification |  ユーザー通知を特定のIDで表示します。 |
| @Deprecated <br>getNotificationServiceIntent | PendingIntent | Context, NhnCloudRemoteMessage, PendingIntent | 指標転送を含むユーザー実行インテントを返します。 <br> Android 12 (APIレベル31)以上では正常に動作しないため、代わりにgetContentIntent()を使用する必要があります。 |
| getContentIntent | PendingIntent | Context, NhnCloudRemoteMessage, Intent | 指標転送を含むユーザー実行インテントを返します。 |

### NhnCloudNotificationOptions
* デフォルト通知オプション設定時、優先順位、小さなアイコン、背景色、LED、振動、通知音、フォアグラウンドの通知露出情報を設定するオブジェクトです。

``` java
/* NhnCloudNotificationOptions.java */
public int getPriority();
public int getSmallIcon();
public int getColor();
public int getLightColor();
public int getLightOnMs();
public int getLightOffMs();
public long[] getVibratePattern();
public Uri getSound();
public boolean isForegroundEnabled();
public boolean isBadgeEnabled();
public Builder buildUpon();
```

| Method | Returns | Parameters | |
|---|---|---|---|
| getPriority | int |  | 優先順位を返します。 |
| getSmallIcon | int | | 小アイコンのリソース識別子を返します。 |
| getColor | int | | 背景色を返します。  |
| getLightColor | int | | LEDの色を返します。 |
| getLightOnMs | int | | LEDライトが点灯する時の時間を返します。 |
| getLightOffMs | int | | LEDライトが消える時の時間を返します。 |
| getVibratePattern | long[] | | 振動のパターンを返します。|
| getSound | Uri | | 通知音のUriを返します。 |
| isForegroundEnabled | boolean | | フォアグラウンド通知の使用するかを返します。|
| isBadgeEnabled | boolean | | バッジアイコンの使用の有無を返します。 |
| buildUpon | NhnCloudNotificationOptions#Builder | | 現在のオプション情報に基づき、ビルダーを返します。 |
