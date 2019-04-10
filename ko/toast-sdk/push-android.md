## TOAST > TOAST SDK 사용 가이드 > TOAST Push > Android

## 사전 준비

1\. [TOAST SDK](./getting-started-android)를 설치합니다.
2\. [TOAST 콘솔](https://console.cloud.toast.com)에서 [Push 서비스를 활성화](https://docs.toast.com/ko/Notification/Push/ko/console-guide/)합니다.
3\. Push 콘솔에서 AppKey를 확인합니다.

## Push 제공자별 가이드

- [Firebase Cloud Messaging (이하 FCM) 가이드](https://firebase.google.com/docs/cloud-messaging/)

## 라이브러리 설정

- FCM용 SDK를 설치하려면 아래 코드를 build.gradle에 추가합니다.

```groovy
dependencies {
    implementation 'com.toast.android:toast-push-fcm:0.15.0'
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

## Push 설정
- [ToastPushConfiguration](./push-android/#toastpushconfiguration) 객체는 Push 설정 정보를 포함하고 있습니다.
- [ToastPushConfiguration](./push-android/#toastpushconfiguration) 객체는 ToastPushConfiguration.Builder를 사용하여 생성할 수 있습니다.
- Push 콘솔에서 발급받은 AppKey를 ToastPushConfiguration.newBuilder 매개변수로 전달합니다.

### Push 설정 예시

```java
ToastPushConfiguration.Builder configuration = 
    ToastPushConfiguration.newBuilder(getApplicationContext(), "YOUR_APP_KEY")
            .build();
```

## Push 초기화
- ToastPush.initialize를 호출하여 TOAST Push를 초기화합니다.
- 사용하기를 원하는 PushProvider의 객체를 초기화 호출시 전달해야 합니다.

### FCM 초기화 예시

```java
PushProvider provider = FirebaseMessagingPushProvider.getProvider();
ToastPush.initialize(provider, configuration);
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
    public void onRegister(@NonNull PushResult result, @Nullable String token) {
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
    public void onQuery(@NonNull PushResult result, @Nullable TokenInfo tokenInfo) {
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
가장 최근에 등록된 토큰을 해제합니다. 토큰이 해제되면 푸시를 더 이상 받을 수 없게 됩니다.

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
        }
    }
});
```

## 알림 기본값 설정

### 작은 아이콘 기본값 설정
- 알림의 작은 아이콘의 기본값을 설정합니다.
- 작은 아이콘의 기본값을 설정하면 SDK가 알림 생성시 기본값으로 설정된 작은 아이콘을 알림에 등록합니다.

#### 작은 아이콘 기본값 설정 예시
```java
ToastNotification.setDefaultSmallIcon(context, R.drawable.ic_notification);
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
ToastNotification.setDefaultNotificationChannel(context, 
    "YOUR_NOTIFICATION_CHANNEL_ID", 
    "YOUR_NOTIFICATION_CHANNEL_NAME");
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
    - Custom scheme을 이용한 Activity/BroadcastReceiver 이동도 가능
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

### ReplyActionListener 등록
- 리치 메시지의 답장(혹은 응답) 버튼을 사용하는 경우, 사용자의 입력 메시지를 받아서 별도의 처리가 필요합니다.
- 이를 위해서 ReplyActionListener 를 제공합니다.
- ReplyActionListener는 **반드시** Application의 onCreate 에서 등록해야 합니다.

> (주의) 사용자가 입력을 완료하고 전송 버튼을 누르면 알림(Notification)은 로딩바가 노출되며 알림이 제거되지 않습니다.
> 따라서 답장 처리가 완료되면 알림(Notification)을 제거하거나 업데이트하는 코드를 추가해야합니다.
> 아래 예제 코드를 참고해주세요.

#### ReplyActionListener 등록 예제

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
