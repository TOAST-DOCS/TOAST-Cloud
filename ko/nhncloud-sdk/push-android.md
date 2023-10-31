## NHN Cloud > SDK 사용 가이드 > Push > Android

## 사전 준비

1. [NHN Cloud SDK](./getting-started-android)를 설치합니다.
2. [NHN Cloud 콘솔](https://console.nhncloud.com)에서 [Push 서비스를 활성화](https://nhncloud.com/ko/Notification/Push/ko/console-guide/)합니다.
3. Push 콘솔에서 AppKey를 확인합니다.

## Push 제공자별 가이드

* [Firebase Cloud Messaging (이하 FCM) 가이드](https://firebase.google.com/docs/cloud-messaging/)
* `Tencent Push Notification (QQ) 2020년 11월 서비스 종료`

## 라이브러리 설정

### FCM
* NHN Cloud FCM Push를 사용하기 위해 아래와 같이 build.gradle에 의존성을 추가합니다.

```groovy
repositories {
    google()
    mavenCentral()
}

dependencies {
    implementation 'com.nhncloud.android:nhncloud-push-fcm:1.8.1'
    ...
}
```

### ADM
* NHN Cloud ADM Push를 사용하기 위해 아래와 같이 build.gradle에 의존성을 추가합니다.

```groovy
repositories {
    google()
    mavenCentral()
}

dependencies {
    implementation 'com.nhncloud.android:nhncloud-push-adm:1.8.1'
    ...
}
```

## Firebase Cloud Messaging 설정

### 프로젝트 및 앱 추가

* [Firebase 콘솔](https://console.firebase.google.com/?hl=ko)에서 프로젝트를 생성합니다.
* 콘솔의 상단에 있는 톱니바퀴 버튼을 클릭해서 **프로젝트 설정**으로 이동합니다.
* 프로젝트 설정의 **내 앱** 에서 **Android 앱에 Firebase 추가**를 클릭합니다.
* **Android 패키지 이름**, **앱 닉네임 (선택사항)** 을 입력하고 **앱 등록** 버튼을 클릭합니다.
* **google-services.json 다운로드** 버튼을 클릭해서 설정 정보를 다운로드합니다.
* 다운로드 받은 **google-services.json** 파일을 앱의 모듈(앱 수준) 디렉터리로 이동합니다.
* 자세한 사항은 [Android 프로젝트에 Firebase 추가](https://firebase.google.com/docs/android/setup)을 참고하세요.

### build.gradle 설정
#### 루트 수준의 build.gradle
* 루트 수준의 build.gradle에 아래 코드를 추가합니다.

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

#### 앱 모듈의 build.gradle
* 앱 모듈의 build.gradle에 아래 코드를 추가합니다.

```groovy
apply plugin: 'com.android.application'

android {
  // ...
}

// ADD THIS AT THE BOTTOM
apply plugin: 'com.google.gms.google-services'
```

## Amazon Device Messaging 설정

### 프로젝트 및 앱 추가

* [Amazon Developer 콘솔](https://developer.amazon.com/settings/console/home)로 이동합니다.
* 상단 **Apps & Services**의 **My Apps**로 이동합니다.
* **Add New App**에서 **Android**를 선택 후 앱 정보를 입력하여 앱을 등록합니다.
* **Android 패키지 이름**, **앱 닉네임 (선택사항)**을 입력하고 **앱 등록** 버튼을 클릭합니다.

### API Key 추가

* **My Apps**에서 등록한 앱을 선택하고 좌측 메뉴에서 **App Service**를 클릭합니다.
* Device Messaging에서 **Security Profile**을 생성하고 등록합니다.
* **View Security Profile**로 이동하여 **Android/Kindle Settings** 메뉴에서 API Key를 생성합니다.
* 생성한 API Key를 복사하여 프로젝트의 **assets** 폴더에 **api_key.txt** 파일로 저장합니다.
* 자세한 사항은 [Amazon Device Messaging - Obtain Credentials](https://developer.amazon.com/docs/adm/obtain-credentials.html)를 참고하세요.

### ADM SDK 다운로드

* Amazon Developer의 [Amazon Device Messaging (ADM) SDKs](https://developer.amazon.com/docs/apps-and-games/sdk-downloads.html#adm)에서 ADM SDK를 다운로드합니다.
* 다운로드한 **amazon-device-messaging-1.2.0.jar** 파일을 프로젝트의 **amazon/libs** 폴더에 저장합니다.

#### 앱 모듈의 build.gradle
```groovy
dependencies {
    //...
    compileOnly files('amazon/libs/amazon-device-messaging-1.2.0.jar')
}
```

### Proguard 설정

* Proguard를 사용하는 경우 <b>[proguard-rules.pro](http://proguard-rules.pro)</b> 파일에 아래와 같이 추가합니다.

```groovy
-libraryjars amazon/libs/amazon-device-messaging-1.2.0.jar
-dontwarn com.amazon.device.messaging.**
-keep class com.amazon.device.messaging.** { *; }
-keep public class * extends com.amazon.device.messaging.ADMMessageReceiver
-keep public class * extends com.amazon.device.messaging.ADMMessageHandlerBase
-keep public class * extends com.amazon.device.messaging.ADMMessageHandlerJobBase
```

## Push 초기화

* NhnCloudPush.initialize를 호출하여 NHN Cloud Push를 초기화합니다.
* [NhnCloudPushConfiguration](./push-android/#nhncloudpushconfiguration) 객체는 Push 설정 정보를 포함하고 있습니다.
* [NhnCloudPushConfiguration](./push-android/#nhncloudpushconfiguration) 객체는 NhnCloudPushConfiguration.Builder를 사용하여 생성할 수 있습니다.
* Push 콘솔에서 발급 받은 AppKey를 NhnCloudPushConfiguration.newBuilder 매개변수로 전달합니다.
* 사용하기를 원하는 PushType을 초기화 호출시 전달해야 합니다.

### FCM 초기화 예시

```java
NhnCloudPushConfiguration configuration =
    NhnCloudPushConfiguration.newBuilder(context, "YOUR_APP_KEY")
            .build();

NhnCloudPush.initialize(PushType.FCM, configuration);
```

### ADM 초기화 예시

```java
NhnCloudPushConfiguration configuration =
    NhnCloudPushConfiguration.newBuilder(context, "YOUR_APP_KEY")
            .build();

NhnCloudPush.initialize(PushType.ADM, configuration);
```

> NhnCloudPush.initialize(NhnCloudPushConfiguration)는 Deprecated 되었습니다.
> NhnCloudPush.initialize(NhnCloudPushConfiguration)를 사용하여 초기화할 경우 PushType은 자동으로 FCM으로 설정됩니다.


## 서비스 로그인
* NHN Cloud SDK에서 제공하는 모든 상품(Push, IAP, Log & Crash등)은 하나의 동일한 사용자 아이디를 사용합니다.
    * [NhnCloudSdk.setUserId](./getting-started-android/#userid)로 사용자 아이디를 설정할 수 있습니다.
* 서비스 로그인 단계에서 사용자 아이디 설정, 토큰 등록 기능을 구현하는 것을 권장합니다.
* 토큰 등록 후 사용자 아이디를 설정 또는 변경하면 토큰 정보를 갱신합니다.

### 서비스 로그인 예제

```java
public void onLogin(String userId) {
    // Login.
    NhnCloudSdk.setUserId(userId);
    // 토큰 등록 등
}
```

## 토큰 등록
* NhnCloudPush.registerToken() 메서드를 사용하여 Push 토큰을 NHN Cloud Push 서버로 전송합니다. 이때 수신 동의 여부(NhnCloudPushAgreement)를 파라미터로 전달합니다.
* 최초 토큰 등록 시 사용자 아이디가 설정되어 있지 않으면, 단말기 식별자를 사용하여 등록합니다.
* 토큰이 성공적으로 등록되면, Push 메시지를 수신할 수 있습니다.

### 수신 동의 설정
* 정보통신망법 규정(제50조부터 제50조의 8)에 따라 토큰 등록 시 알림/홍보성/야간홍보성 Push 메시지 수신에 관한 동의 여부도 함께 입력받습니다. 메시지 발송 시 수신 동의 여부를 기준으로 자동으로 필터링합니다.
    * [KISA 가이드 바로 가기](https://www.kisa.or.kr/2060301/form?postSeq=19)
    * [법령 바로 가기](http://www.law.go.kr/법령/정보통신망이용촉진및정보보호등에관한법률/%2820130218,11322,20120217%29/제50조)
* NhnCloudPushAgreement에 수신 동의 여부를 설정하여 토큰 등록 시 NHN Cloud Push 서버로 전송합니다.

### 토큰 등록 및 수신 동의 설정 예시
```java
// 수신 동의 설정 객체 생성
NhnCloudPushAgreement agreement = NhnCloudPushAgreement.newBuilder(true)  // 알림 메시지 수신 동의
        .setAllowAdvertisements(true)       // 홍보성 알림 메시지 수신 동의
        .setAllowNightAdvertisements(true)  // 야간 홍보성 아림 메시지 수신 동의
        .build();

// 토큰 등록 및 수신 동의 설정
NhnCloudPush.registerToken(context, agreement, new RegisterTokenCallback() {
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
* NHN Cloud Push 서버에 등록된 토큰 정보를 조회합니다.

### 토큰 정보 조회 예시
```java
NhnCloudPush.queryTokenInfo(context, new QueryTokenInfoCallback() {
    @Override
    public void onQuery(@NonNull PushResult result,
                        @Nullable TokenInfo tokenInfo) {

        if (result.isSuccess()) {
            // 토큰 정보 조회 성공
            String token = tokenInfo.getToken();
            NhnCloudPushAgreement agreement = tokenInfo.getAgreement();
        } else {
            // 토큰 정보 조회 실패
            int code = result.getCode();
            String message = result.getMessage();
        }
    }
});
```

## 토큰 해제
* NHN Cloud Push 서버에 등록된 토큰을 해제합니다. 해제된 토큰은 메시지 발송 대상에서 제외됩니다.
* `서비스 로그아웃 후에 메시지 수신을 원치 않으시면 토큰을 해제해야 합니다.`
* `토큰이 해제되어도 단말기 상에 알림 권한은 회수되지 않습니다.`

> 이미 해제된 토큰을 해제하면 "이미 해제된 토큰입니다(Already a token has been unregistered)" 라는 메시지와 함께 성공이 반환됩니다.

### 토큰 해제 예시
```java
NhnCloudPush.unregisterToken(mContext, new UnregisterTokenCallback() {
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

## 메시지 수신
* Push 메시지 수신 시 OnReceiveMessageListener 를 통해 통지 받을 수 있습니다.
* Push 메시지 수신 리스너는 NhnCloudPush.setOnReceiveMessageListener 함수를 사용하여 등록할 수 있습니다.
* OnReceiveMessageListener 에 전달된 [NhnCloudPushMessage](./push-android/#nhncloudpushmessage) 객체를 통해 메시지 정보를 확인 할 수 있습니다.
* 앱이 실행 중이지 않을 때도 메시지 수신 통지를 받기 위해서는 `Application#onCreate` 에서 등록해야 합니다.

> 메시지 수신 시 사용자가 앱을 사용 중(Foreground)일 경우 알림을 노출하지 않습니다.
> Foreground 여부는 OnReceiveMessageListener#onReceive 에 전달되는 isForeground 를 통해 확인 할 수 있습니다.

### 메시지 수신 리스너 등록 예시
``` java
public class MyApplication extends Application {
    @Override
    public void onCreate() {
        // ...

        NhnCloudPush.setOnReceiveMessageListener(new OnReceiveMessageListener() {
            @Override
            public void onReceive(@NonNull NhnCloudPushMessage message,
                                  boolean isForeground) {

                // 사용자가 앱을 사용 중 일 때에도 알림을 노출
                if (isForeground) {
                    NhnCloudNotification.notify(getApplicationContext(), message);
                }
            }
        });

        // ...
    }
}
```

## 알림 권한

* Android 13(API 레벨 33) 이상에서 알림 표시를 위해 POST\_NOTIFICATIONS 권한이 필요합니다.
* 기본적으로 NHN Cloud SDK(1.2.0 버전 이상)에는 매니페스트에 POST\_NOTIFICATIONS 권한이 포함되어 있습니다.
* 앱에서 알림을 표시하려면 런타임 권한을 요청해야 하며 사용자가 이 권한을 부여할 때까지 앱에서 알림을 표시할 수 없습니다.

### Android 13(API 레벨 33) 이상을 타겟팅하는 앱의 알림 권한

* Android 13(API 레벨 33) 이상을 타겟팅 시 requestPostNotificationsPermission API를 이용하여 알림 런타임 권한을 요청할 수 있습니다.

``` java
if (Build.VERSION.SDK_INT >= 33) {
    NhnCloudNotification.requestPostNotificationsPermission(this, PERMISSION_REQUEST_CODE);
}
```

### Android 12(API 레벨 32) 이하를 타겟팅하는 앱의 알림 권한

* Android 12(API 레벨 32) 이하를 타겟팅 시 앱이 포그라운드에 있을 때 앱에서 알림 채널을 처음 만들면 Android에서 자동으로 사용자에게 권한을 요청합니다.
* 앱이 백그라운드에서 실행 중일 때 첫 알림 채널을 만드는 경우 앱을 열 때까지 알림이 표시되지 않고 사용자에게 알림 권한을 요청하지 않습니다.
즉, 앱을 열고 사용자가 권한을 수락하기 전에 알림이 노출되지 않습니다.
* Android 12(API 레벨 32) 이하를 타겟팅하는 앱은 앱 처음 실행 시에 알림 채널을 생성하여 사용자에게 권한을 요청해야 합니다.

``` java
if (Build.VERSION.SDK_INT <= 32) {
    NotificationChannel channel = NhnCloudNotification.getNotificationChannel(this);
    if (channel == null) {
        NhnCloudNotification.createNotificationChannel(this);
    }
}
```

## 알림 클릭
* 사용자가 노출된 알림을 클릭하여 앱이 실행되었을 때 OnClickListener 를 통해 통지 받울 수 있습니다.
* 알림 클릭 리스너는 NhnCloudNotification.setOnClickListener 함수를 사용하여 등록할 수 있습니다.
* 앱이 실행 중이지 않을 때도 알림 클릭 통지를 받기 위해서는 `Application#onCreate` 에서 등록해야 합니다.

### 알림 클릭 리스너 등록 예시
```java
public class MyApplication extends Application {
    @Override
    public void onCreate() {
        // ...

        NhnCloudNotification.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(@NonNull NhnCloudPushMessage message) {
                // 메시지 내용을 기반으로 페이지 이동 등의 서비스 로직 수행이 가능합니다.
                Map<String, String> extras = message.getExtras();
            }
        });

        // ...
    }
}
```

## 알림 설정

### 기본 알림 채널명 설정
* 알림 채널명은 안드로이드 8.0(API 레벨 26) 이상 단말기의 알림 설정에 노출되는 채널의 이름입니다.
* 알림에 별도의 채널을 설정하지 않았으면 기본 알림 채널로 알림이 요청됩니다.
* 알림 기본 옵션 설정시 적용을 위해 기본 알림 채널이 새로 생성됩니다.
* `Application#onCreate` 에서 등록하거나 AndroidManifest.xml 파일에 메타 데이터로 정의할 수 있습니다.

> 기본 알림 채널명을 설정하지 않으면 애플리케이션의 이름으로 자동 설정됩니다.

#### 기본 알림 채널명 설정 예시
##### 코드에서 설정 예시
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

        NhnCloudNotificationOptions defaultOptions = new NhnCloudNotificationOptions.Builder()
                .setPriority(NotificationCompat.PRIORITY_HIGH)  // 알림 우선 순위 설정
                .setColor(0x0085AA)                             // 알림 배경색 설정
                .setLights(Color.RED, 0, 300)                   // LED 라이트 설정
                .setSmallIcon(R.drawable.ic_notification)       // 작은 아이콘 설정
                .setSound(context, R.raw.dingdong1)             // 알림음 설정
                .setVibratePattern(new long[] {500, 700, 1000}) // 진동 패턴 설정
                .enableForeground(true)                         // 포그라운드 알림 노출 설정
                .enableBadge(true)                              // 배지 아이콘 사용 설정
                .build();

        NhnCloudNotification.setDefaultOptions(context, defaultOptions);

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
        NhnCloudNotificationOptions defaultOptions = NhnCloudNotification.getDefaultOptions(context);

        // 알림 옵션 객체로부터 빌더 생성
        NhnCloudNotificationOptions newDefaultOptions = defaultOptions.buildUpon()
                .enableForeground(true)      // 포그라운드 알림 노출 여부 설정만 변경
                .build();

        NhnCloudNotification.setDefaultOptions(context, newDefaultOptions);

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

### 알림음 설정
* Push 메시지 발송 시 sound 필드를 추가하면 로컬 리소스(mp3, wav)를 알림음으로 설정할 수 있습니다. (안드로이드 8.0 미만에서만 동작)
* 알림음은 애플리케이션 리소스 폴더 하위의 raw 폴더에 있는 로컬 리소스만 사용 가능합니다.
    * 예) main/res/raw/notification_sound.wav

## 리치 메시지

* 리치 메시지는 알림의 제목, 본문과 함께 이미지를 알림에 표현하고 버튼, 답장 등의 액션을 추가합니다.

### 지원하는 리치 메시지

#### 버튼
| 유형 | 기능 | 액션 |
| --- | ------- | --- |
| 앱 열기 (OPEN_APP) | 애플리케이션 실행 | PushAction.ActionType.OPEN_APP |
| URL 열기 (OPEN_URL) | URL로 이동<br/>(웹 URL 주소 혹은 앱 커스텀 스킴 실행) | PushAction.ActionType.OPEN_URL |
| 답장 (REPLY) | 알림에서 답장 전송 | PushAction.ActionType.REPLY |
| 취소 (DISMISS) | 현재 알림 취소 | PushAction.ActionType.DISMISS |

* 답장 (REPLY) 버튼은 안드로이드 7.0(API 레벨 24) 이상부터 사용 가능합니다.

> 버튼은 메시지당 최대 3개까지 지원합니다.

#### 미디어
* 애플리케이션내의 리소스 아이디, 안드로이드 Assets 파일 경로, URL로 파일 지정이 가능합니다.
* 이미지 외의 동영상, 소리 등의 미디어는 지원하지 않습니다.
* 이미지는 가로와 세로 비율이 2:1인 이미지를 권장합니다.
    * Small : 512 x 256
    * Medium : 1024 x 512
    * Large : 2048 x 1024

> 웹 URL 사용시 미디어 파일 다운로드 시간이 소요됩니다.

#### 큰 아이콘
* 애플리케이션내의 리소스 아이디, 안드로이드 Assets 파일 경로, URL로 파일 지정이 가능합니다.
* 큰 아이콘의 이미지는 1:1 비율을 권장합니다.

> 사용된 이미지가 1:1 비율이 아닌 경우 강제로 1:1로 변경되기 때문에 기대와 다른 이미지가 노출될 수 있습니다.

#### 그룹
* 동일한 그룹키를 갖는 알림들이 그룹핑되어 표현됩니다.
* 안드로이드 7.0(API 레벨 24) 이상부터 사용 가능합니다.

### 알림 액션 리스너 등록
* 사용자가 알림의 버튼 혹은 답장 전송 버튼 클릭시 알림 액션 리스너로 통지합니다.
* [PushAction](./push-android/#pushaction) 객체로 액션 정보를 확인 가능합니다.
* 앱이 실행중이지 않을 때에도 메시지 수신 통지를 받기 위해서는 `Application#onCreate` 에서 등록해야 합니다.

#### 알림 액션 리스너 등록 예시

``` java
public class MyApplication extends Application {
    @Override
    public void onCreate() {
        // ...

        NhnCloudNotification.setOnActionListener(new OnActionListener() {
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
* 메시지 수신 후 별도의 처리 과정을 수행하거나 수신한 메시지의 내용을 수정해 알림을 노출해야하는 경우 [NhnCloudPushMessageReceiver](./push-android/#nhncloudpushmessagereceiver)를 상속 구현하는 브로드캐스트를 구현해야 합니다.
* NhnCloudPushMessageReceiver를 상속 구현한 브로트캐스트는 AndroidManifest.xml 에도 반드시 등록해야 합니다.
* 메시지 수신시 onMessageReceived 함수로 수신된 메시지가 전달됩니다.

> **(주의)**
> 1. onMessageReceived 함수에서 메시지 수신 후 알림 노출을 요청(notify)하지 않으면 알림이 노출되지 않습니다.
> 2. 알림을 직접 생성할 경우 Push 서비스 인텐트를 알림의 콘텐츠 인텐트로 설정해야만 지표 수집이 가능합니다. (아래 지표 수집 기능 추가 섹션 참고)

### NhnCloudPushMessagingService 구현 코드 예
```java
public class MyPushMessageReceiver extends NhnCloudPushMessageReceiver {
    @Override
    public void onMessageReceived(@NonNull Context context,
                                  @NonNull NhnCloudRemoteMessage remoteMessage) {

        // 채널 아이디 변경
        remoteMessage.setChannelId("channel");

        // 메시지 내용 수정
        NhnCloudPushMessage message = remoteMessage.getMessage();
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
            NhnCloud.makeText(context, message.title, NhnCloud.LENGTH_SHORT).show();
        }
    }
}
```

### AndroidManifest.xml 등록 예
> **(주의)**
> 1. NhnCloudPushMessageReceiver를 사용하는 경우, 반드시 permission을 설정해야 합니다.
> 2. API 레벨 31 이상 타겟팅 시 exported 속성을 설정해야 합니다. 

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

        <!-- 생략 -->
    </application>

    <!-- 생략 -->
</manifest>
```

### 지표 수집 기능 추가 (FCM Only)
* 알림을 직접 생성하는 경우, 지표 수집 기능을 사용하려면 getContentIntent() 함수를 사용하여 생성한 인텐트를 알림의 콘텐츠 인텐트로 설정해야 합니다.

#### 지표 수집 기능 추가 예
```java
public class MyPushMessageReceiver extends NhnCloudPushMessageReceiver {
    private NotificationManager mManager = null;

    @Override
    public void onMessageReceived(
            @NonNull Context context,
            @NonNull NhnCloudRemoteMessage remoteMessage) {

        // 메시지 내용 획득
        NhnCloudPushMessage message = remoteMessage.getMessage();

        //NotificationManager 생성
        if (mManager == null) {
            mManager = (NotificationManager) context.getSystemService(Context.NOTIFICATION_SERVICE);
            if  (mManager == null) {
                Log.e(TAG, "Failed to get NotificationManager");
                return;
            }
        }

        // 채널 설정
        String channelId = "YOUR_CHANNEL_ID";
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            NotificationChannel channel = mManager.getNotificationChannel(channelId);
            if (channel == null) {
                String channelName = "YOUR_CHANNEL_NAME";
                createNotificationChannel(channelId, channelName);
            }
        }

        // 실행 인텐트 설정
        Intent launchIntent = new Intent(context, MainActivity.class);

        // 지표 전송을 포함한 컨텐츠 인텐트 생성
        PendingIntent contentIntent;
        contentIntent = getContentIntent(context, remoteMessage, launchIntent);

        //알림 생성
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

## Emoji 사용
> **(주의)**
> 기기에서 지원하지 않는 emoji를 사용한 경우, 표시되지 않을 수 있습니다.

## 사용자 태그

* [사용자 태그](https://nhncloud.com/ko/Notification/Push/ko/console-guide/#_16) 기능은 여러 사용자 아이디를 하나의 태그로 묶고 이를 활용하여 메시지 발송이 가능합니다.
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
NhnCloudPush.addUserTag(tagIds, new UserTagCallback() {
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
NhnCloudPush.setUserTag(tagIds, new UserTagCallback() {
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
NhnCloudPush.getUserTag(new UserTagCallback() {
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
NhnCloudPush.removeUserTag(tagIds, new UserTagCallback() {
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
NhnCloudPush.removeAllUserTag(new UserTagCallback() {
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

## NHN Cloud Push Class Reference
### NhnCloudPushConfiguration
* NHN Cloud Push를 초기화할 때 전달되는 Push 설정 정보입니다.

```java
/* NhnCloudPushConfiguration.java */
public String getAppKey();
public static Builder newBuilder(@NonNull Context context, @NonNull String appKey);
```

| Method | Returns | |
|---|---|---|
| getAppKey | String | Push 서비스 앱 키를 반환합니다. |
| static newBuilder | NhnCloudPushConfiguration.Builder | NhnCloudPushConfiguration 객체 생성을 위한 빌더를 생성합니다. |

### PushResult
* 비동기 API 호출시 콜백의 응답으로 반환되는 결과 객체입니다.


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
* 토큰 정보 조회 요청시 반환되는 토큰 정보 객체입니다.

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
| getPushType | String | Push 타입을 반환합니다. |
| getAgreement | NhnCloudPushAgreement | 알림/광고/야간 광고 등 동의 여부를 반환합니다. |
| getTimeZone | String | 타임존을 반환합니다. |
| getCountry | String | 국가 코드를 반환합니다. |
| getLanguage | String | 언어 코드를 반환합니다. |
| getUserId | String | 사용자 ID를 반환합니다. |
| getActivatedDateTime | Date | 토큰의 최근 등록 일시를 반환합니다. |
| getToken | String | 토큰을 반환합니다. |

### NhnCloudRemoteMessage
* 메시지 수신 리스너, 커스텀 리시버에서 메시지 수신시 반환되는 객체 입니다.

``` java
/* NhnCloudRemoteMessage.java */
public String getChannelId();
public void setChannelId(String channelId);
public NhnCloudPushMessage getMessage();
public String getSenderId();
```

| Method | Returns | |
|---|---|---|
| getChannelId | String | 채널 ID를 반환합니다. |
| setChannelId |  | 채널 ID를 설정합니다. |
| getMessage | NhnCloudPushMessage | 메시지 객체를 반환합니다. |
| getSenderId | String | 발신자 ID를 반환합니다. (FCM Only) |

### NhnCloudPushMessage
* 수신한 메시지 내용을 담는 객체 입니다.

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
| getMessageId | String | 메시지 식별자를 반환합니다. |
| getPusyType | String | PushType을 반환합니다. |
| getTitle | String | 메시지 타이틀을 반환합니다. |
| setTitle |  | 메시지 타이틀을 설정합니다. |
| getBody | String | 메시지 내용을 반환합니다. |
| setBody |  | 메시지 내용을 설정합니다. |
| getRichMessage | RichMessage | 리치 메시지 정보를 반환합니다. |
| getExtras |  | 수신된 메시지 전체를 반환합니다. |


### PushAction
* 알림 액션 수신시 반환되는 객체 입니다.

``` java
/* PushAction.java */
public ActionType getActionType();
public String getNotificationId();
public String getNotificationChannel();
public NhnCloudPushMessage getMessage();
public String getUserText();
```

| Method | Returns | |
|---|---|---|
| getActionType | ActionType | ActionType을 반환합니다. |
| getNotificationId | String | 액션이 실행된 알림의 ID을 반환합니다. |
| getNotificationChannel | String | 액션이 실행된 알림의 채널을 반환합니다. |
| getMessage | NhnCloudPushMessage | 액션이 실행된 알림의 메시지 정보를 반환합니다. |
| getUserText | RichMessage | 사용자가 입력한 문자열을 반환합니다. |

### NhnCloudPushMessageReceiver
* 메시지 내용 수정, 실행 인텐트 정의, 알림 직접 생성 등의 기능을 위해서는 사용자가 구현해야하는 객체 입니다.

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
| isAppForeground | boolean |  | 현재 앱을 사용중인지 여부를 반환합니다. |
| notify | | Context, NhnCloudRemoteMessage | 기본 실행 인텐트로 알림을 생성 및 노출합니다. |
| notify | | Context, NhnCloudRemoteMessage, PendingIntent | 사용자 실행 인텐트로 알림을 생성 및 노출합니다. |
| notify | | Context, int, Notification | 사용자 알림을 특정 ID로 노출합니다. |
| @Deprecated <br>getNotificationServiceIntent | PendingIntent | Context, NhnCloudRemoteMessage, PendingIntent | 지표 전송을 포함하는 사용자 실행 인텐트를 반환합니다. <br> Android 12 (API 레벨 31) 이상부터 정상 동작 하지 않으며, 대신 getContentIntent()를 사용해야 합니다. |
| getContentIntent | PendingIntent | Context, NhnCloudRemoteMessage, Intent | 지표 전송을 포함하는 사용자 실행 인텐트를 반환합니다. |

### NhnCloudNotificationOptions
* 기본 알림 옵션 설정시 우선순위, 작은 아이콘, 배경색, LED, 진동, 알림음, 포그라운드 알림 노출 정보를 설정하는 객체입니다.

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
| buildUpon | NhnCloudNotificationOptions#Builder | | 현재 옵션 정보를 기반으로 빌더를 반환합니다. |
