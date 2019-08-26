## TOAST > User Guide for TOAST SDK > TOAST Push > Android

## 사전 준비

1\. [TOAST SDK](./getting-started-android)를 설치합니다.
2\. [TOAST 콘솔](https://console.cloud.toast.com)에서 [Push 서비스를 활성화](https://docs.toast.com/ko/Notification/Push/ko/console-guide/)합니다.
3\. Push 콘솔에서 AppKey를 확인합니다.

## Push 제공자별 가이드

- [Firebase Cloud Messaging (이하 FCM) 가이드](https://firebase.google.com/docs/cloud-messaging/)
- [Tencent Push Notification (이하 Tencent) 가이드](https://xg.qq.com/docs/)

## 라이브러리 설정

### FCM
- FCM용 SDK를 설치하려면 아래 코드를 build.gradle에 추가합니다.

```groovy
dependencies {
    implementation 'com.toast.android:toast-push-fcm:0.18.0'
    ...
}
```

### Tencent
- Tencent용 SDK를 설치하려면 아래 코드를 build.gradle에 추가합니다.

```groovy
dependencies {
    implementation 'com.toast.android:toast-push-tencent:0.18.0'
    ...
}
```

## Firebase Cloud Messaging 설정

### 프로젝트 및 앱 추가
- 기존 Firebase 프로젝트가 없다면, [Firebase 콘솔](https://console.firebase.google.com/?hl=ko)에서 프로젝트를 생성합니다.
- 콘솔의 상단에 있는 톱니바퀴 버튼을 클릭해서 **프로젝트 설정**으로 이동합니다.
- 프로젝트 설정의 **내 앱** 에서 **Android 앱에 Firebase 추가**를 클릭합니다.
- **Android 패키지 이름**, **앱 닉네임 (선택사항)** 을 입력하고 **앱 등록** 버튼을 클릭합니다.
- **google-services.json 다운로드** 버튼을 클릭해서 설정 정보를 다운로드합니다. 그리고 **다음** 버튼을 클릭합니다.
    - 만약 다운로드를 안하고 넘어갔더라도 프로젝트 설정에서 다시 다운로드 가능합니다.
- 다음 스텝인 **Firebase SDK 추가** 는 아래 별도의 가이드를 참고하면 되기 때문에 바로 **다음** 버튼을 클릭합니다.
- 다음 스텝인 **앱을 실행하여 설치 확인** 도 **_이 단계 건너뛰기_** 를 클릭해서 넘어갑니다.

### build.gradle 설정
#### 루트 수준의 build.gradle
- 루트 수준의 build.gradle에 아래 코드를 추가합니다.

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

#### 앱 모듈의 build.gradle
- 앱 모듈의 build.gradle에 아래 코드를 추가합니다.

```groovy
apply plugin: 'com.android.application'

android {
  // ...
}

// ADD THIS AT THE BOTTOM
apply plugin: 'com.google.gms.google-services'
```

### google-services.json 추가
- 앱 모듈의 루트 경로에 앞서 다운로드한 google-services.json을 복사합니다.

## Tencent Push Notification 설정
- 기존 Tencent 프로젝트가 없다면, [Tencent 콘솔](https://xg.qq.com/)에서 프로젝트를 생성합니다.
- 웹 우측에 어플리케이션 등록을 선택합니다.
- 어플리케이션을 등록하면 AccessID와 Accesskey가 생성됩니다.

### build.gradle 설정
#### 앱 모듈의 build.gradle
- 앱 모듈의 build.gradle에 아래 코드를 추가합니다.

```groovy
apply plugin: 'com.android.application'

android {
    ...
    defaultConfig {
        ...
        ndk {
        // 빌드하고자 하는 cpu 유형을 추가 합니다.
        // 필요 시 추가 : 'x86', 'x86_64', 'mips', 'mips64'
        abiFilters 'armeabi', 'armeabi-v7a', 'arm64-v8a'
        }

        manifestPlaceholders = [
            XG_ACCESS_ID:"accessid",
            XG_ACCESS_KEY : "accesskey",
        ]
    }
}
```

### gradle.properties 설정
- 루트 수준의 gradle.properties에 아래 코드를 추가합니다.

```groovy
android.useDeprecatedNdk = true
```

### Android P 호환방법
- Android 9.0 이상에서 target API 28을 사용하는 경우, network_security_config.xml의 파일을 추가합니다.

```xml
<?xml version="1.0" encoding="utf-8"?>
<network-security-config>
    <domain-config cleartextTrafficPermitted="true">
        <domain includeSubdomains="true">182.254.116.117</domain>
        <domain includeSubdomains="true">pingma.qq.com</domain>
    </domain-config>
</network-security-config>
```

- AndroidManifest에 application에 android:networkSecurityConfig 설정을 추가합니다.
- 자세한 설명은 [security-config](https://developer.android.com/training/articles/security-config?hl=ko)를 참고하십시오.

```xml
<?xml version="1.0" encoding="utf-8"?>
<manifest ... >
    <application android:networkSecurityConfig="@xml/network_security_config"
    ... >
        ...
    </application>
</manifest>
```

### Apache HTTP 클라이언트 라이브러리 추가하기
- AndroidManifest에 다음 설정을 추가합니다.
- 자세한 설명은 [Android 6.0 변경사항](https://developer.android.com/about/versions/marshmallow/android-6.0-changes?hl=ko)을 참고하십시오.

```xml
android {
    useLibrary 'org.apache.http.legacy'
}
```

## Push 설정
- [ToastPushConfiguration](./push-android/#toastpushconfiguration) 객체는 Push 설정 정보를 포함하고 있습니다.
- [ToastPushConfiguration](./push-android/#toastpushconfiguration) 객체는 ToastPushConfiguration.Builder를 사용하여 생성할 수 있습니다.
- Push 콘솔에서 발급받은 AppKey를 ToastPushConfiguration.newBuilder 매개변수로 전달합니다.

### Push 설정 예시

```java
ToastPushConfiguration configuration =
    ToastPushConfiguration.newBuilder(getApplicationContext(), "YOUR_APP_KEY")
            .build();
```

## Push 초기화
- ToastPush.initialize를 호출하여 TOAST Push를 초기화합니다.
- 사용하기를 원하는 PushType 을 초기화 호출시 전달해야 합니다.

### FCM 초기화 예시

```java
ToastPush.initialize(PushType.FCM, configuration);
```

### Tencent 초기화 예시
```java
ToastPush.initialize(PushType.TENCENT, configuration);
```

## 서비스 로그인
- TOAST SDK에서 제공하는 모든 상품(Push, IAP, Log & Crash등)은 하나의 동일한 사용자 아이디를 사용합니다.
    - [ToastSdk.setUserId](./getting-started-android/#userid)로 사용자 아이디를 설정할 수 있습니다.
    - 사용자 아이디를 설정하지 않은 경우, 토큰을 등록할 수 없습니다.
- 서비스 로그인 단계에서 사용자 아이디 설정, 토큰 등록 기능을 구현하는 것을 권장합니다.

### 서비스 로그인 예제

```java
public void onLogin(String userId) {
    // Login.
    ToastSdk.setUserId(userId);
    // 토큰 등록 등
}
```

## 수신 동의 설정
- 정보통신망법 규정(제50조부터 제50조의 8)에 따라 토큰 등록 시 알림/홍보성/야간홍보성 푸시 메시지 수신에 관한 동의 여부도 함께 입력받습니다. 메시지 발송 시 수신 동의 여부를 기준으로 자동으로 필터링합니다.
    - [KISA 가이드 바로 가기](https://spam.kisa.or.kr/spam/sub62.do)
    - [법령 바로 가기](http://www.law.go.kr/법령/정보통신망이용촉진및정보보호등에관한법률/%2820130218,11322,20120217%29/제50조)

### 수신 동의 설정 예시
```java
ToastPushAgreement agreement = ToastPushAgreement.newBuilder(/* 알림 수신 여부 */ true)
        .setAllowAdvertisements(/* 광고 수신 여부 */ true)
        .setAllowNightAdvertisements(/* 야간 광고 수신 여부 */ true)
        .build();
```

## 토큰 등록
- 각 Push 제공자가 제공하는 토큰을 획득하여, TOAST Push 서버로 전송합니다.
- 토큰이 성공적으로 등록되면, Push를 수신할 수 있습니다.

### 토큰 등록 예시
```java
ToastPush.registerToken(context, agreement, new RegisterTokenCallback() {
    @Override
    public void onRegister(@NonNull PushResult result,
                           @Nullable String token) {

        if (result.isSuccess()) {
            // 토큰 등록 성공
        } else {
            // 토큰 등록 실패
            int code = result.getCode();
            String message = result.getMessage();
        }
    }
});
```

## 토큰 정보 조회
- TOAST Push 서버에 등록된 토큰 정보를 조회합니다.

### 토큰 정보 조회 예시
```java
ToastPush.queryTokenInfo(mContext, new QueryTokenInfoCallback() {
    @Override
    public void onQuery(@NonNull PushResult result,
                        @Nullable TokenInfo tokenInfo) {

        if (result.isSuccess()) {
            String token = tokenInfo.getToken();
            ToastPushAgreement agreement = tokenInfo.getAgreement();
            // 토큰 정보 조회 성공
        } else {
            // 토큰 정보 조회 실패
            int code = result.getCode();
            String message = result.getMessage();
        }
    }
});
```

## 토큰 해제
- 가장 최근에 등록된 토큰을 해제합니다. 토큰이 해제되면 푸시를 더 이상 받을 수 없게 됩니다.

> 이미 해제된 토큰을 해제하면 "이미 해제된 토큰입니다(Already a token has been unregistered)" 라는 메시지와 함께 성공이 반환됩니다.

### 토큰 해제 예시
```java
ToastPush.unregisterToken(mContext, new UnregisterTokenCallback() {
    @Override
    public void onUnregister(@NonNull PushResult result,
                             @Nullable String unregisteredToken) {

        if (result.isSuccess()) {
            // 토큰 해제 성공시
        } else {
            // 토큰 해제 실패시
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

## 알림 기본값 설정

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

### 기본 알림 채널 설정
- 안드로이드 8.0(API 레벨 26) 이상 부터는 알림 채널을 반드시 사용해야 합니다.
- 기본 알림 채널을 설정하면 SDK가 알림 생성시 기본 알림 채널로 알림을 등록합니다.
- **알림 채널 ID**는 알림 채널을 식별하기 위한 값으로 앱에서 유일한 값으로 설정해야 합니다.
- **알림 채널 이름**은 사용자에게 노출되는 알림 채널의 이름입니다.

> 기본 알림 채널을 설정하지 않으면 아래값으로 기본 알림 채널을 생성합니다.
> **알림 채널 ID** : 임의의 UUID를 ID로 사용합니다.
> **알림 채널 이름** : 애플리케이션의 이름을 알림 채널 이름으로 사용합니다.

### 기본 알림 채널 설정 예시
```java
// 기본 채널만 설정
ToastNotification.setDefaultNotificationChannel(
    context,
    "YOUR_NOTIFICATION_CHANNEL_ID",
    "YOUR_NOTIFICATION_CHANNEL_NAME");

// 기본 채널과 기본 옵션 동시에 설정
ToastNotification.setDefaultNotificationChannel(
    context,
    "YOUR_NOTIFICATION_CHANNEL_ID",
    "YOUR_NOTIFICATION_CHANNEL_NAME",
    defaultOptions);
```

## 알림 리소스 설정

### 알림 소리 리소스
- 푸시 발송 시 sound 필드를 추가하면 로컬 리소스(mp3, wav)를 알림 소리로 설정할 수 있습니다. (안드로이드 8.0 미만에서만 동작)
    - 푸시 발송 시 sound 필드에 로컬 리소스 이름만(확장자 제외) 입력해야 합니다.
- 로컬 리소스는 반드시 리소스 폴더 하위의 raw 폴더에 있어야 합니다.
    - 예) main/res/raw/dingdong1.wav

## 리치 메시지

### 리치 메시지란?
- **리치 메시지**란 제목, 본문과 함께 수신할 수 있는 다양하고 풍부한 메시지입니다.

### 지원하는 리치 메시지
#### 버튼
- 알림 제거 : 현재 알림을 제거합니다.
- 앱 열기 : 앱을 실행합니다.
- URL 열기 : 특정 URL로 이동합니다.
    - 웹 URL 입력시 브라우져가 실행됩니다.
    - Custom scheme을 이용한 Activity/BroadcastReceiver 실행이 가능합니다.
- 답장 전송 : 알림에서 바로 답장을 보냅니다.
    - 안드로이드 7.0(API 레벨 24) 이상에서만 사용 가능합니다.

> 버튼은 최대 3개까지 지원합니다.

#### 미디어
- 이미지 : 알림에 이미지를 추가합니다. (내부, 외부 이미지 모두 지원)
    - 이미지는 가로와 세로 비율이 2:1인 이미지를 권장합니다.
    - 다른 비율의 이미지는 잘린채로 노출될 수 있습니다.
- 그 외 : 그 외의 미디어(동영상, 소리 등)는 지원하지 않습니다.

#### 큰 아이콘
- 알림에 큰 아이콘을 추가합니다. (내부, 외부 이미지 모두 지원)
    - 큰 아이콘의 이미지는 1:1 비율을 권장합니다.
    - 다른 비율의 이미지는 강제로 비율이 1:1로 변경되기 때문에 기대와 다른 이미지가 노출될 수 있습니다.

#### 그룹
- 같은 키의 알림들을 하나로 묶습니다.
- 안드로이드 7.0(API 레벨 24) 이상에서만 사용가능합니다.

### 리치 메시지 변환 방법
- 리치 메시지는 TOAST Push의 웹콘솔에서 전송할 수 있습니다. 또한 메시지 발송 API의 richMessage 필드를 추가해서 전송할 수도 있습니다.
- 리치 메시지를 정해진 형태로 전송했다면, 별도의 변환 과정없이 리치 메시지 알림이 등록됩니다.

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
                    // 서비스 서버로 사용자 입력 내용 전송
                }
            }
        });
    }
}
```

## 사용자 정의 메시지 처리
- 수신한 메시지를 수정하거나 인텐트를 변경, 알림을 직접 생성해야하는 경우, [ToastPushMessageReceiver](./push-android/#toastpushmessagereceiver)를 상속해서 onMessageReceived 메소드를 구현해야합니다.
- ToastPushMessageReceiver를 구현한 브로트캐스트는 AndroidManifest.xml 에도 반드시 등록해야 합니다.
- 알림 생성, 인텐트 생성 등의 추가 기능을 제공합니다.

> **(주의)**
> 1. 수신한 메시지를 이용해 알림을 직접 생성할 경우, 오픈 지표 수집을 위해 별도의 처리가 필요 필요합니다. (아래 지표 수집 기능 추가 섹션 참고)

### ToastPushMessagingService 구현 코드 예
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

        // 사용자가 앱을 사용중이지 않을 때만 알림을 노출하도록하고 싶은 경우
        if (!isAppForeground()) {
            // 알림 생성 및 노출
            notify(context, remoteMessage, launchIntent);
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
- 알림을 직접 생성하는 경우, 지표 수집 기능을 사용하려면 createAnalyticsContentIntent() 메소드를 사용하여 생성한 인텐트를 사용해야합니다.

#### 지표 수집 기능 추가 예
```java
public class ToastPushSampleMessageReceiver extends ToastPushMessageReceiver {
    @Override
    public void onMessageReceived(@NonNull Context context,
                                  @NonNull ToastRemoteMessage remoteMessage) {

        ToastPushMessage message = remoteMessage.getMessage();

        // 사용자 실행 인텐트 생성
        Intent launchIntent = new Intent(context, MainActivity.class);

        // 지표 전송을 포함한 실행 인텐트 생성 기능 제공
        PendingIntent contentIntent = createAnalyticsContentIntent(context, remoteMessage, launchIntent);

        NotificationCompat.Builder builder = new NotificationCompat.Builder(context, "YOUR_CHANNE_ID");
        // (중략)
        builder.setContentIntent(contentIntent);

        notify(context, builder.build());
    }
}
```

## Emoji 사용
> **(주의)**
> 기기에서 지원하지 않는 emoji를 사용한 경우, 표시되지 않을 수 있습니다.
> Tencent의 경우, emoji를 사용하면 메세지가 수신되지 않을 수 있습니다.

## TOAST Push Class Reference
### ToastPushConfiguration
- TOAST Push를 초기화할 때 전달되는 Push 설정 정보입니다.

```java
/* ToastPushConfiguration.java */
public String getAppKey();
public static Builder newBuilder(@NonNull Context context, @NonNull String appKey);
```

| Method | Returns | |
|---|---|---|
| getAppKey | String | Push 서비스 앱 키를 반환합니다. |
| static newBuilder | ToastPushConfiguration.Builder | ToastPushConfiguration 객체 생성을 위한 빌더를 생성합니다. |

### PushResult
- 비동기 API 호출시 콜백의 응답으로 반환되는 결과 객체입니다.


```java
/* PushResult.java */
public int getCode();
public String getMessage();
public boolean isSuccess();
public boolean isFailure();
```

| Method | Returns | |
|---|---|---|
| getCode | int | 결과 코드를 반환합니다. |
| getMessage | int | 결과 메시지를 반환합니다. |
| isSuccess | boolean | 성공 여부를 반환합니다. |
| isFailure | boolean | 실패 여부를 반환합니다. |

### TokenInfo
- 토큰 정보 조회 호출시 콜백으로 반환되는 토큰 정보를 담고 있는 객체입니다.

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
| getPushType | String | Push 타입을 반환합니다. |
| getAgreement | ToastPushAgreement | 알림/광고/야간 광고 등 동의 여부를 반환합니다. |
| getTimeZone | String | 타임존을 반환합니다. |
| getCountry | String | 국가 코드를 반환합니다. |
| getLanguage | String | 언어 코드를 반환합니다. |
| getUserId | String | 사용자 ID를 반환합니다. |
| getActivatedDateTime | Date | 토큰의 최근 등록 일시를 반환합니다. |
| getToken | String | 토큰을 반환합니다. |

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
public final void notify(Context context, ToastRemoteMessage message, Intent userIntent);
public final void notify(Context context, Notification notification);
public final void notify(Context context, int notificationId, Notification notification);
public final PendingIntent createAnalyticsContentIntent(Context context, ToastRemoteMessage message);
public final PendingIntent createAnalyticsContentIntent(Context context, ToastRemoteMessage message, Intent userIntent);
```

| Method | Returns | Parameters | |
|---|---|---|---|
| isAppForeground | boolean |  | 현재 앱을 사용중인지 여부를 반환합니다. |
| notify | | Context, ToastRemoteMessage | 기본 실행 인텐트로 알림을 생성 및 노출합니다. |
| notify | | Context, ToastRemoteMessage, Intent | 사용자 실행 인텐트로 알림을 생성 및 노출합니다. |
| notify | | Context, Notification | 사용자 알림을 노출합니다. |
| notify | | Context, int, Notification | 사용자 알림을 특정 ID로 노출합니다. |
| createAnalyticsContentIntent | PendingIntent | Context, ToastRemoteMessage | 지표 전송을 포함하는 기본 실행 인텐트를 반환합니다. |
| createAnalyticsContentIntent | PendingIntent | Context, ToastRemoteMessage, Intent | 지표 전송을 포함하는 사용자 실행 인텐트를 반환합니다. |

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
