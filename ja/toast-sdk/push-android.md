## TOAST > TOAST SDK使用ガイド > TOAST Push > Android

## 事前準備

1\. [TOAST SDK](./getting-started-android)をインストールします。
2\. [TOASTコンソール](https://console.cloud.toast.com)で、[Pushサービスを有効化](https://docs.toast.com/ko/Notification/Push/ko/console-guide/)します。
3\. PushコンソールでAppKeyを確認します。

## Push提供者別ガイド

* [Firebase Cloud Messaging (以下FCM)ガイド](https://firebase.google.com/docs/cloud-messaging/)
* ~~[Tencent Push Notification (이하 Tencent) 가이드](https://xg.qq.com/docs/)~~ `2020년 11월 서비스 종료`

## ライブラリ設定

### FCM
* FCM用SDKをインストールするには、下記のコードをbuild.gradleに追加します。

```groovy
dependencies {
    implementation 'com.toast.android:toast-push-fcm:0.24.2’
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
* 다운로드 받은 **google-services.json** 파일을 앱의 모듈(앱 수준) 디렉터리로 이동합니다.
* 자세한 사항은 [Android 프로젝트에 Firebase 추가](https://firebase.google.com/docs/android/setup)을 참고하세요.

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

## Push初期化
* ToastPush.initializeを呼び出してTOAST Pushを初期化します。
* [ToastPushConfiguration](./push-android/#toastpushconfiguration)オブジェクトは、Push設定情報を含んでいます。
* [ToastPushConfiguration](./push-android/#toastpushconfiguration)オブジェクトは、ToastPushConfiguration.Builderを使用して作成できます。
* Pushコンソールで発行されたAppKeyをToastPushConfiguration.newBuilderの引数に渡します。
* 使用したいPushTypeを初期化の呼び出し時にお届けしなければなりません。

### FCM初期化例

```java
ToastPushConfiguration configuration =
    ToastPushConfiguration.newBuilder(context, "YOUR_APP_KEY")
            .build();

ToastPush.initialize(configuration);
```

## サービスログイン
* TOAST SDKで提供するすべてのサービス(Push、IAP、Log & Crashなど)は、1つの同じユーザーIDを使用します。
    * [ToastSdk.setUserId](./getting-started-android/#userid)にユーザーIDを設定できます。
* サービスログイン段階でユーザーID設定、トークン登録機能を実装することを推奨します。
* トークンの登録後、ユーザーIDを設定または変更すると、トークン情報を更新します。

### サービスログイン例

```java
public void onLogin(String userId) {
    // Login.
    ToastSdk.setUserId(userId);
    // トークン登録など
}
```

## トークン登録
* ToastPush.registerToken()メソッドを使用してPushトークンをTOAST Pushサーバーに転送します。 この時、受信同意可否(ToastPushAgreement)をパラメータで伝えます。
* 最初のトークン登録時のユーザー名が設定されていなければ、端末識別子を使用して登録します。
* トークンの登録に成功すると、Push メッセージを受信することができます。

### 受信同意設定
* 韓国情報通信網法規定(第50条から第50条の8)に従い、トークン登録時の通知/広告性/夜間広告性プッシュメッセージ受信に同意するかも一緒に入力を受けます。メッセージ送信時に受信に同意しているかを基準に自動的にフィルタリングします。
    * [KISAガイドへ](https://spam.kisa.or.kr/spam/sub62.do)
    * [法令へ](http://www.law.go.kr/법령/정보통신망이용촉진및정보보호등에관한법률/%2820130218,11322,20120217%29/제50조)
* ToastPushAgreementに受信同意の可否を設定し、トークン登録時にTOAST Pushサーバーに転送します。

### トークン登録例
```java
ToastPushAgreement agreement = ToastPushAgreement.newBuilder(true)  // 通知を受信するか
        .setAllowAdvertisements(true)       // 広告を受信するか
        .setAllowNightAdvertisements(true)  // 夜間広告を受信するか
        .build();

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
* TOAST Pushサーバーに登録されているトークン情報を照会します。

### トークン情報照会例
```java
ToastPush.queryTokenInfo(ㅊontext, new QueryTokenInfoCallback() {
    @Override
    public void onQuery(@NonNull PushResult result, @Nullable TokenInfo tokenInfo) {
        if (result.isSuccess()) {
            // トークン情報照会成功
            String token = tokenInfo.getToken();
            ToastPushAgreement agreement = tokenInfo.getAgreement();

        } else {
            // トークン情報照会失敗
            int code = result.getCode();
            String message = result.getMessage();
        }
    }
});
```

## トークン解除
* TOAST Push サーバーに登録されたトークンを解除します。 解除されたトークンはメッセージの送信対象外となります。
* `サービスログアウト後にメッセージ受信をご希望にならなければトークンを解除しなければなりません。`
* `トークンが解除されても端末のお知らせ権限は回収されません。`

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

## 메시지 수신
* Push 메시지 수신 시 OnReceiveMessageListener 를 통해 통지 받을 수 있습니다.
* Push 메시지 수신 리스너는 ToastPush.setOnReceiveMessageListener 메서드를 사용하여 등록할 수 있습니다.
* OnReceiveMessageListener 에 전달된 [ToastPushMessage](./push-android/#toastpushmessage) 객체를 통해 메시지 정보를 확인 할 수 있습니다.
* 앱이 실행 중이지 않을 때도 메시지 수신 통지를 받기 위해서는 `Application#onCreate` 에서 등록해야 합니다.

> 메시지 수신 시 사용자가 앱을 사용 중(Foreground)일 경우 알림을 노출하지 않습니다.
> Foreground 여부는 OnReceiveMessageListener#onReceive 에 전달되는 isForeground 를 통해 확인 할 수 있습니다.

### 메시지 수신 리스너 등록 예시

``` java
public class MyApplication extends Application {
    @Override
    public void onCreate() {
        // ...

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

        // ...
    }
}
```

## 알림 클릭

* 사용자가 노출된 알림을 클릭하여 앱이 실행되었을 때 OnClickListener 를 통해 통지 받울 수 있습니다.
* 알림 클릭 리스너는 ToastNotification.setOnClickListener 함수를 사용하여 등록할 수 있습니다.
* 앱이 실행 중이지 않을 때도 알림 클릭 통지를 받기 위해서는 `Application#onCreate` 에서 등록해야 합니다.

### 알림 클릭 리스너 등록 예시

```java
public class MyApplication extends Application {
    @Override
    public void onCreate() {
        // ...

        ToastNotification.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(@NonNull ToastPushMessage message) {
                // 메시지 내용을 기반으로 페이지 이동 등의 서비스 로직 수행이 가능합니다.
                Map<String, String> extras = message.getExtras();
            }
        });

        // ...
    }
}
```

## 알림 설정

## 알림 설정

### 기본 알림 채널명 설정
* 알림 채널명은 안드로이드 8.0(API 레벨 26) 이상 단말기의 알림 설정에 노출되는 채널의 이름입니다.
* 알림에 별도의 채널을 설정하지 않았으면 기본 알림 채널로 알림이 요청됩니다.
* 알림 기본 옵션 설정시 적용을 위해 기본 알림 채널이 새로 생성됩니다.
* `Application#onCreate` 에서 등록하거나 AndroidManifest.xml 파일에 메타 데이터로 정의할 수 있습니다.

> 기본 알림 채널명을 설정하지 않으면 어플리케이션의 이름으로 자동 설정됩니다.

#### 기본 알림 채널명 설정 예시
##### 코드에서 설정 예시
```java
public class MyApplication extends Application {
    @Override
    public void onCreate() {
        // ...

        ToastNotification.setDefaultChannelName(context, "YOUR_CHANNEL_NAME");

        // ...
    }
}
```

##### AndroidManifest.xml 메타 데이터로 정의 예시
```xml
<!-- 기본 채널의 이름 설정 -->
<meta-data android:name="com.toast.sdk.push.notification.default_channel_name"
           android:value="@string/default_notification_channel_name"/>
```

### 알림 기본 옵션 설정
* 알림의 우선 순위, 작은 아이콘, 배경색, LED 라이트, 진동, 알림음을 설정합니다.
* 앱이 포그라운드 상태일 때의 알림 노출 여부를 설정합니다.
* 배지 아이콘의 사용 여부를 설정합니다.
* 안드로이드 8.0(API 레벨 26) 이상 단말기에서는 기본 알림 채널에만 옵션이 적용 됩니다.
* `Application#onCreate` 에서 등록하거나 AndroidManifest.xml 파일에 메타 데이터로 정의할 수 있습니다.

#### 알림 기본 옵션 설정 예시
##### 코드에서 설정 예시
**전체 알림 옵션을 변경할 경우**
```java
public class MyApplication extends Application {
    @Override
    public void onCreate() {
        // ...

        ToastNotificationOptions defaultOptions = new ToastNotificationOptions.Builder()
                .setPriority(NotificationCompat.PRIORITY_HIGH)  // 알림 우선 순위 설정
                .setColor(0x0085AA)                             // 알림 배경색 설정
                .setLights(Color.RED, 0, 300)                   // LED 라이트 설정
                .setSmallIcon(R.drawable.ic_notification)       // 작은 아이콘 설정
                .setSound(context, R.raw.dingdong1)             // 알림음 설정
                .setVibratePattern(new long[] {500, 700, 1000}) // 진동 패턴 설정
                .enableForeground(true)                         // 포그라운드 알림 노출 설정
                .enableBadge(true)                              // 배지 아이콘 사용 설정
                .build();

        ToastNotification.setDefaultOptions(context, defaultOptions);

        // ...
    }
}
```

**설정된 알림 옵션 중 일부만 변경할 경우**
```java
public class MyApplication extends Application {
    @Override
    public void onCreate() {
        // ...

        // 설정된 기본 알림 옵션 획득
        ToastNotificationOptions defaultOptions = ToastNotification.getDefaultOptions(context);

        // 알림 옵션 객체로부터 빌더 생성
        ToastNotificationOptions newDefaultOptions = defaultOptions.buildUpon()
                .enableForeground(true)      // 포그라운드 알림 노출 여부 설정만 변경
                .build();

        ToastNotification.setDefaultOptions(context, newDefaultOptions);

        // ...
    }
}
```

##### AndroidManifest.xml 메타 데이터로 정의 예시
```xml
<!-- 알림 우선 순위 -->
<meta-data android:name="com.toast.sdk.push.notification.default_priority"
           android:value="1"/>
<!-- 알림 배경색 -->
<meta-data android:name="com.toast.sdk.push.notification.default_background_color"
           android:resource="@color/defaultNotificationColor"/>
<!-- LED 라이트 -->
<meta-data android:name="com.toast.sdk.push.notification.default_light_color"
           android:value="#0000ff"/>
<meta-data android:name="com.toast.sdk.push.notification.default_light_on_ms"
           android:value="0"/>
<meta-data android:name="com.toast.sdk.push.notification.default_light_off_ms"
           android:value="500"/>
<!-- 작은 아이콘 -->
<meta-data android:name="com.toast.sdk.push.notification.default_small_icon"
           android:resource="@drawable/ic_notification"/>
<!-- 알림음 -->
<meta-data android:name="com.toast.sdk.push.notification.default_sound"
           android:value="notification_sound"/>
<!-- 진동 패턴 -->
<meta-data android:name="com.toast.sdk.push.notification.default_vibrate_pattern"
           android:resource="@array/default_vibrate_pattern"/>
<!-- 배지 아이콘 사용 -->
<meta-data android:name="com.toast.sdk.push.notification.badge_enabled"
           android:value="true"/>
<!-- 앱 실행 중 알림 노출 -->
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

> ボタンは最大3個までサポートします。

#### 미디어
* 어플리케이션내의 리소스 아이디, 안드로이드 Assets 파일 경로, URL로 파일 지정이 가능합니다.
* 이미지 외의 동영상, 소리 등의 미디어는 지원하지 않습니다.
* 이미지는 가로와 세로 비율이 2:1인 이미지를 권장합니다.
    * Small : 512 x 256
    * Medium : 1024 x 512
    * Large : 2048 x 1024

> 웹 URL 사용시 미디어 파일 다운로드 시간이 소요됩니다.

#### 큰 아이콘
* 어플리케이션내의 리소스 아이디, 안드로이드 Assets 파일 경로, URL로 파일 지정이 가능합니다.
* 큰 아이콘의 이미지는 1:1 비율을 권장합니다.

> 사용된 이미지가 1:1 비율이 아닌 경우 강제로 1:1로 변경되기 때문에 기대와 다른 이미지가 노출될 수 있습니다.

#### グループ
* 同じキーの通知を1つにまとめます。
* Android 7.0(APIレベル24)以上でのみ使用可能です。

### 알림 액션 리스너 등록
* 사용자가 알림의 버튼 혹은 답장 전송 버튼 클릭시 알림 액션 리스너로 통지합니다.
* [PushAction](./push-android/#pushaction) 객체로 액션 정보를 확인 가능합니다.
* 앱이 실행중이지 않을 때에도 메세지 수신 통지를 받기 위해서는 `Application#onCreate` 에서 등록해야 합니다.

#### 알림 액션 리스너 등록 예시

``` java
public class MyApplication extends Application {
    @Override
    public void onCreate() {
        // ...

        ToastNotification.setOnActionListener(new OnActionListener() {
            @Override
            public void onAction(@NonNull PushAction action) {
                // 답장 액션일 경우, 서비스 서버로 해당 내용을 전송
                if (action.getActionType() == PushAction.ActionType.REPLY) {
                    // 사용자가 입력한 답장 내용 획득
                    String userText = action.getUserText();
                    // 서비스 서버로 사용자 입력 내용 전송
                }
            }
        });

        // ...
    }
}
```

## 사용자 정의 메시지 처리
* 메시지 수신 후 별도의 처리 과정을 수행하거나 수신한 메시지의 내용을 수정해 알림을 노출해야하는 경우 [ToastPushMessageReceiver](./push-android/#toastpushmessagereceiver)를 상속 구현하는 브로드캐스트를 구현해야 합니다.
* ToastPushMessageReceiver를 상속 구현한 브로트캐스트는 AndroidManifest.xml 에도 반드시 등록해야 합니다.
* 메시지 수신시 onMessageReceived 함수로 수신된 메시지가 전달됩니다.

> **(주의)**
> 1. onMessageReceived 함수에서 메시지 수신 후 알림 노출을 요청(notify)하지 않으면 알림이 노출되지 않습니다.
> 2. 알림을 직접 생성할 경우 Push 서비스 인텐트를 알림의 콘텐츠 인텐트로 설정해야만 지표 수집이 가능합니다. (아래 지표 수집 기능 추가 섹션 참고)

### ToastPushMessagingService 구현 코드 예
```java
public class MyPushMessageReceiver extends ToastPushMessageReceiver {
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

### AndroidManifest.xml 등록 예
> **(주의)**
> ToastPushMessageReceiver를 사용하는 경우, 반드시 permission을 설정해야 합니다.

```xml
<manifest>
    <application>
    <receiver android:name=".ToastPushSampleReceiver"
        android:permission="${applicationId}.toast.push.permission.RECEIVE">
        <intent-filter>
            <action android:name="com.toast.android.push.MESSAGE_EVENT" />
            </intent-filter>
    </receiver>

        <!-- 생략 -->
    </application>

    <!-- 생략 -->
</manifest>
```

### 지표 수집 기능 추가 (FCM Only)
* 알림을 직접 생성하는 경우, 지표 수집 기능을 사용하려면 getNotificationServiceIntent() 함수를 사용하여 생성한 인텐트를 알림의 콘텐츠 인텐트로 설정해야합니다.

#### 지표 수집 기능 추가 예
```java
public class MyPushMessageReceiver extends ToastPushMessageReceiver {
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
        PendingIntent serviceIntent = getNotificationServiceIntent(context, remoteMessage, contentIntent);

        NotificationCompat.Builder builder = new NotificationCompat.Builder(context, "YOUR_CHANNE_ID");
        // (중략)
        builder.setContentIntent(serviceIntent);

        notify(context, builder.build());
    }
}
```

## Emoji使用
> **(注意)**
> 機器でサポートしていないemojiを使用した場合には、表示されないことがあります。

## 사용자 태그

* [사용자 태그](https://docs.toast.com/ko/Notification/Push/ko/console-guide/#_16) 기능은 여러 사용자 아이디를 하나의 태그로 묶고 이를 활용하여 메시지 발송이 가능합니다.
* 태그명이 아닌 태그 아이디(8자리 문자열)를 기반으로 동작하며, 태그 아이디는 콘솔 > 태그 메뉴에서 생성 및 확인 가능합니다.

### 사용자 태그 수정

#### 사용자 태그 수정 예

* 입력 받은 태그 아이디 목록을 추가 혹은 업데이트하고 최종 반영된 태그 아이디 목록을 반환합니다.

```java
// 추가할 태그 아이디 목록 생성
Set<String> tagIds = new HashSet<>();
tagIds.add(TAG_ID_1);   // e.g. "ZZPP00b6" (8자리 문자열)
tagIds.add(TAG_ID_2);

// 로그인되어 있는 사용자 아이디의 태그 아이디 목록 추가
ToastPush.addUserTag(tagIds, new UserTagCallback() {
    @Override
    public void onResult(@NonNull PushResult result, @Nullable Set<String> tagIds) {
        if (result.isSuccess()) {
            // 사용자 태그 아이디 추가 성공
        } else {
            // 사용자 태그 아이디 추가 실패
            int errorCode = result.getCode();
            String errorMessage = result.getMessage();
        }
    }
});

// 로그인되어 있는 사용자 아이디의 태그 아이디 목록 업데이트 (기존 태그 아이디 목록은 삭제되고 입력한 값으로 설정)
ToastPush.setUserTag(tagIds, new UserTagCallback() {
    @Override
    public void onResult(@NonNull PushResult result, @Nullable Set<String> tagIds) {
        if (result.isSuccess()) {
            // 사용자 태그 아이디 목록 업데이트 성공
        } else {
            // 사용자 태그 아이디 목록 업데이트 실패
            int errorCode = result.getCode();
            String errorMessage = result.getMessage();
        }
    }
});
```

### 사용자 태그 획득

* 현재 사용자에 등록된 모든 태그 아이디 목록을 반환합니다.

#### 사용자 태그 획득 예

```java
// 로그인되어 있는 사용자 아이디의 전체 태그 아이디 목록을 반환
ToastPush.getUserTag(new UserTagCallback() {
    @Override
    public void onResult(@NonNull PushResult result, @Nullable Set<String> tagIds) {
        if (result.isSuccess()) {
            // 사용자 태그 아이디 목록 획득 성공
        } else {
            // 사용자 태그 아이디 목록 획득 실패
            int errorCode = result.getCode();
            String errorMessage = result.getMessage();
        }
    }
});
```

### 사용자 태그 삭제

#### 사용자 태그 삭제 예

* 입력 받은 사용자 태그 아이디 목록을 삭제하고, 최종 반영된 태그 아이디 목록을 반환합니다.

```java
// 삭제할 태그 아이디 목록 생성
Set<String> tagIds = new HashSet<>();
tagIds.add(TAG_ID_1);   // e.g. "ZZPP00b6" (8자리 문자열)
tagIds.add(TAG_ID_2);

// 로그인되어 있는 사용자 아이디의 태그 아이디 목록 삭제
ToastPush.removeUserTag(tagIds, new UserTagCallback() {
    @Override
    public void onResult(@NonNull PushResult result, @Nullable Set<String> tagIds) {
        if (result.isSuccess()) {
            // 사용자 태그 아이디 목록 삭제 성공
        } else {
            // 사용자 태그 아이디 목록 삭제 실패
            int errorCode = result.getCode();
            String errorMessage = result.getMessage();
        }
    }
});

// 로그인되어 있는 사용자 아이디의 전체 태그 아이디 목록 삭제
ToastPush.removeAllUserTag(new UserTagCallback() {
    @Override
    public void onResult(@NonNull PushResult result, @Nullable Set<String> tagIds) {
        if (result.isSuccess()) {
            // 전체 사용자 태그 삭제 성공
        } else {
            // 전체 사용자 태그 삭제 실패
            int errorCode = result.getCode();
            String errorMessage = result.getMessage();
        }
    }
});
```

## TOAST Push Class Reference
### ToastPushConfiguration
* TOAST Pushを初期化する時に渡されるPush設定情報です。

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

### ToastRemoteMessage
* 메세지 수신 리스너, 커스텀 리시버에서 메세지 수신시 반환되는 객체 입니다.

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
* 수신한 메세지 내용을 담는 객체 입니다.

``` java
/* ToastPushMessage.java */
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
| getMessageId | String | 메시지 식별자를 반환합니다. |
| getPusyType | String | PushType을 반환합니다. |
| getTitle | String | 메세지 타이틀을 반환합니다. |
| setTitle |  | 메세지 타이틀을 설정합니다. |
| getBody | String | 메세지 내용을 반환합니다. |
| setBody |  | 메세지 내용을 설정합니다. |
| getRichMessage | RichMessage | 리치 메세지 정보를 반환합니다. |
| getExtras |  | 수신된 메세지 전체를 반환합니다. |


### PushAction
* 버튼 액션 수신시 반환되는 객체 있니다.

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
* 메세지 내용 수정, 실행 인텐트 정의, 알림 직접 생성 등의 기능을 위해서는 사용자가 구현해야하는 객체 입니다.

``` java
/* ToastPushMessageReceiver.java */
public final boolean isAppForeground();
public final void notify(Context context, ToastRemoteMessage message);
public final void notify(Context context, ToastRemoteMessage message, PendingIntent contentIntent);
public final void notify(Context context, int notificationId, Notification notification);
public final PendingIntent getNotificationServiceIntent(Context context, ToastRemoteMessage message, PendingIntent contentIntent);
```

| Method | Returns | Parameters | |
|---|---|---|---|
| isAppForeground | boolean |  | 현재 앱을 사용중인지 여부를 반환합니다. |
| notify | | Context, ToastRemoteMessage | 기본 실행 인텐트로 알림을 생성 및 노출합니다. |
| notify | | Context, ToastRemoteMessage, PendingIntent | 사용자 실행 인텐트로 알림을 생성 및 노출합니다. |
| notify | | Context, int, Notification | 사용자 알림을 특정 ID로 노출합니다. |
| getNotificationServiceIntent | PendingIntent | Context, ToastRemoteMessage, PendingIntent | 지표 전송을 포함하는 사용자 실행 인텐트를 반환합니다. |

### ToastNotificationOptions
* 기본 알림 옵션 설정시 우선순위, 작은 아이콘, 배경색, LED, 진동, 알림음, 포그라운드 알림 노출 정보를 설정하는 객체입니다.

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
public boolean isForegroundEnabled();
public boolean isBadgeEnabled();
public Builder buildUpon();
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
| isForegroundEnabled | boolean | | 포그라운드 알림 사용 여부를 반환합니다. |
| isBadgeEnabled | boolean | | 배지 아이콘 사용 여부를 반환합니다. |
| buildUpon | ToastNotificationOptions#Builder | | 현재 옵션 정보를 기반으로 빌더를 반환합니다. |
