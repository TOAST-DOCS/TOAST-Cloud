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
    implementation 'com.toast.android:toast-push-fcm:0.17.0’
    ...
}
```

### Tencent
- Tencent用SDKをインストールするには、下記のコードをbuild.gradleに追加します。

```groovy
dependencies {
    implementation 'com.toast.android:toast-push-tencent:0.17.0’
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

## Tencent Push Notification 設定
- 既存のTencentのプロジェクトがない場合は、[Tencentコンソール]（https://xg.qq.com/）でプロジェクトを作成します。
- ウェブ右側にアプリケーションの登録を選択します。
- アプリケーションを登録すると、AccessIDとAccesskeyが生成されます。

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

### Android P対応
- Android 9.0以上でtarget API 28を使用している場合は、network_security_config.xmlのファイルを追加します。

```xml
<?xml version="1.0" encoding="utf-8"?>
<network-security-config>
    <domain-config cleartextTrafficPermitted="true">
        <domain includeSubdomains="true">182.254.116.117</domain>
        <domain includeSubdomains="true">pingma.qq.com</domain>
    </domain-config>
</network-security-config>
```

- AndroidManifestにapplicationにandroid：networkSecurityConfig設定を追加します。
- 詳細については、[security-config]（https://developer.android.com/training/articles/security-config?hl=ko）を参照してください。

```xml
<?xml version="1.0" encoding="utf-8"?>
<manifest ... >
    <application android:networkSecurityConfig="@xml/network_security_config"
    ... >
        ...
    </application>
</manifest>
```

### Apache HTTPクライアントライブラリ設定
- AndroidManifestに以下の設定を追加します。
- 詳細については、[Android 6.0の変更]（https://developer.android.com/about/versions/marshmallow/android-6.0-changes?hl=ko）を参照します。

```xml
android {
    useLibrary 'org.apache.http.legacy'
}
```

### Push設定例

```java
ToastPushConfiguration configuration =
    ToastPushConfiguration.newBuilder(getApplicationContext(), "YOUR_APP_KEY")
            .build();
```

## Push初期化
- ToastPush.initializeを呼び出してTOAST Pushを初期化します。
- 사용하기를 원하는 PushType 을 초기화 호출시 전달해야 합니다.

### FCM初期化例

```java
ToastPush.initialize(PushType.FCM, configuration);
```

### Tencent初期化例
```java
ToastPush.initialize(PushType.TENCENT, configuration);
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
- 最近登録されたトークンを解除します。トークンが解除されると、プッシュをこれ以上受けることができなくなります。

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
            int code = result.getCode();
            String message = result.getMessage();
        }
    }
});
```

## 토큰 정보 업데이트
- 사용자 아이디, 국가 코드, 언어 코드, 알림 메시지 수신 동의 등의 토큰 정보를 업데이트합니다.
- [UpdateTokenInfoParams](./push-android/#updatetokeninfoparams) 객체를 생성하여 업데이트 항목을 설정합니다.
- 생성한 [UpdateTokenInfoParams](./push-android/#updatetokeninfoparams) 객체를 ToastPush.updateTokenInfo() 메소드의 파라미터로 전달합니다.

### 토큰 정보 업데이트 예시

``` java
UpdateTokenInfoParams params = UpdateTokenInfoParams.newBuilder()
                .setLanguage(preferences.getLanguage())
                .setAgreement(agreement)
                .build();

ToastPush.updateTokenInfo(mContext, params, new UpdateTokenInfoCallback() {
    @Override
    public void onUpdate(@NonNull PushResult result,
                         @Nullable TokenInfo tokenInfo) {

        if (result.isSuccess()) {
            // 토큰 정보 업데이트 성공시
        } else {
            // 토큰 정보 업데이트 실패시
            int code = result.getCode();
            String message = result.getMessage();
        }
    }
});
```

## 메시지 수신
- 푸시 메시지 수신 시 OnReceiveMessageListener 를 통해 통지 받을 수 있습니다.
- 푸시 메시지 수신 리스너는 ToastPush.setOnReceiveMessageListener 메서드를 사용하여 등록할 수 있습니다.
- OnReceiveMessageListener 에 전달된 [ToastPushMessage](./push-android/#toastpushmessage) 객체를 통해 메시지 정보를 확인 할 수 있습니다.
- 앱이 실행 중이지 않을 때도 메시지 수신 통지를 받기 위해서는 `Application#onCreate` 에서 등록해야 합니다.

> 메시지 수신 시 사용자가 앱을 사용 중(Foreground)일 경우 알림을 노출하지 않습니다.
> Foreground 여부는 OnReceiveMessageListener#onReceive 에 전달되는 isForeground 를 통해 확인 할 수 있습니다.

### 메시지 수신 리스너 등록 예시

``` java
public class ToastPushSampleApplication extends Application {
    @Override
    public void onCreate() {
        ToastPush.setOnReceiveMessageListener(new OnReceiveMessageListener() {
            @Override
            public void onReceive(@NonNull ToastPushMessage message,
                                  boolean isForeground) {

                // 사용자가 앱을 사용 중 일 때에도 알림을 노출
                if (isForeground) {
                    ToastNotification.notify(getApplicationContext(), message);
                }
            }
        });
    }
}
```

## 通知デフォルト値設定

### 알림 기본 옵션 설정
- 알림의 우선 순위, 작은 아이콘, 배경색, LED 라이트, 진동, 알림음을 설정합니다.
- 알림 기본 옵션 적용을 위해서는 `Application#onCreate` 에서 등록해야 합니다.
- 안드로이드 8.0(API 레벨 26) 이상 단말기에서는 기본 옵션 적용을 위해 기본 알림 채널이 재생성 됩니다.

#### 알림 기본 옵션 설정 예시
```java
ToastNotificationOptions defaultOptions = new ToastNotificationOptions.Builder(context)
        .setPriority(NotificationCompat.PRIORITY_HIGH)
        .setColor(0x0085AA)
        .setLights(Color.RED, 0, 300)
        .setSmallIcon(R.drawable.ic_notification)
        .setSound(R.raw.dingdong1)
        .setVibratePattern(new long[] {500, 700, 1000})
        .build();

ToastNotification.setDefaultOptions(context, defaultOptions);
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

ToastNotification.setDefaultNotificationChannel(
    context,
    "YOUR_NOTIFICATION_CHANNEL_ID",
    "YOUR_NOTIFICATION_CHANNEL_NAME",
    defaultOptions);
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

### 버튼 액션 리스너 등록
- 사용자가 리치 메세지의 버튼 선택 시 액션 리스너로 통지합니다.
- 리치 메시지의 답장(혹은 응답) 버튼을 사용하는 경우, 액션 리스너에서 사용자 입력 메세지에 대한 처리가 필요합니다.
- [PushAction](./push-android/#pushaction) 객체로 액션 정보를 확인 가능합니다.
- 앱이 실행중이지 않을 때에도 메세지 수신 통지를 받기 위해서는 `Application#onCreate` 에서 등록해야 합니다.

#### 버튼 액션 리스너 등록 예시

``` java
public class ToastPushSampleApplication extends Application {
    @Override
    public void onCreate() {
        ToastNotification.setOnActionListener(new OnActionListener() {
            @Override
            public void onAction(@NonNull PushAction action) {
                // 답장 액션일 경우, 서비스 서버로 해당 내용을 전송
                if (action.getActionType() == PushAction.ActionType.REPLY) {
                    String userText = action.getUserText();
                    // e.g. 서비스 서버로 사용자 입력 내용 전송
                }
            }
        });
    }
}
```

## ユーザー定義メッセージの処理
- 수신한 메시지를 수정하거나 인텐트를 변경, 알림을 직접 생성해야하는 경우, [ToastPushMessageReceiver](./push-android/#toastpushmessagereceiver)를 상속해서 onMessageReceived 메소드를 구현해야합니다.
- ToastPushMessageReceiverを実装したブロードキャストはAndroidManifest.xmlにも必ず登録する必要があります。
- 알림 생성, 인텐트 생성 등의 추가 기능을 제공합니다.

> **(注意)**
> 1. 수신한 메시지를 이용해 알림을 직접 생성할 경우, 오픈 지표 수집을 위해 별도의 처리가 필요 필요합니다. (아래 지표 수집 기능 추가 섹션 참고)

### ToastPushMessagingService例示
```java
public class ToastPushSampleMessageReceiver extends ToastPushMessageReceiver {
    @Override
    public void onMessageReceived(@NonNull Context context,
                                  @NonNull ToastRemoteMessage remoteMessage) {

        // 채널 아이디 변경
        remoteMessage.setChannelId("channel");

        // 메세지 내용 수정
        ToastPushMessage message = remoteMessage.getMessage();
        CharSequence title = message.getTitle();

        message.setTitle("[Modified] " + title);

        // 실행 인텐트 설정 (미설정시 패키지 기본 메인 액티비티 실행)
        Intent launchIntent = new Intent(context, MainActivity.class);

        PendingIntent contentIntent = PendingIntent.getActivity(
                context,
                REQUEST_CODE,
                launchIntent,
                PendingIntent.FLAG_UPDATE_CURRENT);

        // 사용자가 앱을 사용중일때와 그렇지 않을때를 구분하여 알림을 노출하고 싶은 경우
        if (!isAppForeground()) {
            // 알림 생성 및 노출
            notify(context, remoteMessage, contentIntent);

        } else {
            // 특정 UI 화면 노출
            Toast.makeText(context, message.title, Toast.LENGTH_SHORT).show();
        }
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
- 알림을 직접 생성하는 경우, 지표 수집 기능을 사용하려면 createAnalyticsContentIntent() 메소드를 사용하여 생성한 인텐트를 사용해야합니다.

#### 指標の収集機能の例
```java
public class ToastPushSampleMessageReceiver extends ToastPushMessageReceiver {
    @Override
    public void onMessageReceived(@NonNull Context context,
                                  @NonNull ToastRemoteMessage remoteMessage) {

        ToastPushMessage message = remoteMessage.getMessage();

        // 사용자 실행 인텐트 생성
        Intent launchIntent = new Intent(context, MainActivity.class);

        PendingIntent contentIntent = PendingIntent.getActivity(
                context,
                REQUEST_CODE,
                launchIntent,
                PendingIntent.FLAG_UPDATE_CURRENT);

        // 지표 전송을 포함한 실행 인텐트 생성 기능 제공
        PendingIntent analyticsIntent = createAnalyticsContentIntent(context, remoteMessage, contentIntent);

        NotificationCompat.Builder builder = new NotificationCompat.Builder(context, "YOUR_CHANNE_ID");
        // (중략)
        builder.setContentIntent(analyticsIntent);

        notify(context, builder.build());
    }
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

### UpdateTokenInfoParams
- 토큰 정보 업데이트 호출시 업데이트할 정보를 설정하는 객체입니다.

``` java
/* UpdateTokenInfoParams.java */
public String getUserId();
public String getCountry();
public String getLanguage();
public String getTimeZone();
public String getAgreement();

public static Builder newBuilder();
```

| Method | Returns | |
|---|---|---|
| getUserId | String | 사용자 ID를 반환합니다. |
| getCountry | String | 국가 코드를 반환합니다. |
| getLanguage | String | 언어 코드를 반환합니다. |
| getTimeZone | String | 타임존을 반환합니다. |
| getAgreement | ToastPushAgreement | 알림/광고/야간 광고 등 동의 여부를 반환합니다. |
| static newBuilder | UpdateTokenInfoParams.Builder | UpdateTokenInfoParams 객체 생성을 위한 빌더를 생성합니다. |

### ToastRemoteMessage
- 메세지 수신 리스너, 커스텀 리시버에서 메세지 수신시 반환되는 객체 입니다.

``` java
/* ToastRemoteMessage.java */
public String getChannelId();
public void setChannelId(String channelId);
public ToastPushMessage getMessage();
public String getSenderId();
```

| Method | Returns | |
|---|---|---|
| getChannelId | String | 채널 ID를 반환합니다. |
| setChannelId |  | 채널 ID를 설정합니다. |
| getMessage | ToastPushMessage | 메세지 객체를 반환합니다. |
| getSenderId | String | 발신자 ID를 반환합니다. (FCM Only) |

### ToastPushMessage
- 수신한 메세지 내용을 담는 객체 입니다.

``` java
/* ToastPushMessage.java */
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
| getPusyType | String | PushType을 반환합니다. |
| getTitle | String | 메세지 타이틀을 반환합니다. |
| setTitle |  | 메세지 타이틀을 설정합니다. |
| getBody | String | 메세지 내용을 반환합니다. |
| setBody |  | 메세지 내용을 설정합니다. |
| getRichMessage | RichMessage | 리치 메세지 정보를 반환합니다. |
| getExtras |  | 수신된 메세지 전체를 반환합니다. |


### PushAction
- 버튼 액션 수신시 반환되는 객체 있니다.

``` java
/* PushAction.java */
public ActionType getActionType();
public String getNotificationId();
public String getNotificationChannel();
public ToastPushMessage getMessage();
public String getuserText();
```

| Method | Returns | |
|---|---|---|
| getActionType | ActionType | ActionType을 반환합니다. |
| getNotificationId | String | 액션이 실행된 알림의 ID을 반환합니다. |
| getNotificationChannel | String | 액션이 실행된 알림의 채널을 반환합니다. |
| getMessage | ToastPushMessage | 액션이 실행된 알림의 메세지 정보를 반환합니다. |
| getuserText | RichMessage | 사용자가 입력한 문자열을 반환합니다. |

### ToastPushMessageReceiver
- 메세지 내용 수정, 실행 인텐트 정의, 알림 직접 생성 등의 기능을 위해서는 사용자가 구현해야하는 객체 입니다.

``` java
/* ToastPushMessageReceiver.java */
public final boolean isAppForeground();
public final void notify(Context context, ToastRemoteMessage message);
public final void notify(Context context, ToastRemoteMessage message, PendingIntent contentIntent);
public final void notify(Context context, Notification notification);
public final void notify(Context context, int notificationId, Notification notification);
public final PendingIntent createAnalyticsContentIntent(Context context, ToastRemoteMessage message);
public final PendingIntent createAnalyticsContentIntent(Context context, ToastRemoteMessage message, PendingIntent contentIntent);
```

| Method | Returns | Parameters | |
|---|---|---|---|
| isAppForeground | boolean |  | 현재 앱을 사용중인지 여부를 반환합니다. |
| notify | | Context, ToastRemoteMessage | 기본 실행 인텐트로 알림을 생성 및 노출합니다. |
| notify | | Context, ToastRemoteMessage, PendingIntent | 사용자 실행 인텐트로 알림을 생성 및 노출합니다. |
| notify | | Context, Notification | 사용자 알림을 노출합니다. |
| notify | | Context, int, Notification | 사용자 알림을 특정 ID로 노출합니다. |
| createAnalyticsContentIntent | PendingIntent | Context, ToastRemoteMessage | 지표 전송을 포함하는 기본 실행 인텐트를 반환합니다. |
| createAnalyticsContentIntent | PendingIntent | Context, ToastRemoteMessage, PendingIntent | 지표 전송을 포함하는 사용자 실행 인텐트를 반환합니다. |

### ToastNotificationOptions
- 기본 알림 옵션 설정시 우선순위, 작은 아이콘, 배경색, LED, 진동, 알림음의 정보를 설정하는 객체입니다.

``` java
/* ToastNotificationOptions.java */
public int getPriority();
public int getSmallIcon();
public int getColor();
public int getLightColor();
public int getLightOnMs();
public int getLightOffMs();
public long[] getVibratePattern();
public Uri getSound();
```

| Method | Returns | Parameters | |
|---|---|---|---|
| getPriority | int |  | 우선 순위를 반환합니다. |
| getSmallIcon | int | | 작은 아이콘의 리소스 식별자를 반환합니다. |
| getColor | int | | 배경색을 반환합니다. |
| getLightColor | int | | LED 색을 반환합니다. |
| getLightOnMs | int | | LED 불이 들어올 때의 시간을 반환합니다. |
| getLightOffMs | int | | LED 불이 나갈 때의 시간을 반환합니다. |
| getVibratePattern | long[] | | 진동의 패턴을 반환합니다. |
| getSound | Uri | | 알림음의 Uri 를 반환합니다. |
