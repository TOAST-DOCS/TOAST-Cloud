## TOAST > TOAST SDK 사용 가이드 > TOAST Push > Android

## 사전 준비

1. [TOAST SDK](./getting-started-android)를 설치합니다.
2. [TOAST 콘솔](https://console.cloud.toast.com)에서 [Push 서비스를 활성화](https://docs.toast.com/ko/Notification/Push/ko/console-guide/)합니다.
3. Push 콘솔에서 AppKey를 확인합니다.

## Push 제공자별 가이드

- [Firebase Cloud Messaging (이하 FCM) 가이드](https://firebase.google.com/docs/cloud-messaging/)

## 라이브러리 설정

- FCM용 SDK를 설치하려면 아래 코드를 build.gradle에 추가합니다.

```groovy
dependencies {
    implementation 'com.toast.android:toast-push-fcm:0.13.0'
    ...
}
```

## Firebase Cloud Messaging 설정

> (Firebase Cloud Messaging 웹콘솔 가이드 작성 예정)

## Push 설정
- ToastPushConfiguration 객체는 Push 설정 정보를 포함하고 있습니다.
- ToastPushConfiguration 객체는 ToastPushConfiguration.Builder를 사용하여 생성할 수 있습니다.
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

```java
// Login.
ToastSdk.setUserId(userId);
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

## 알림 기본값 설정

> (작성 예정) 아이콘, 채널, 색상 설정

## 리치 메시지

> (작성 예정) 간단한 설명과 ReplyActionListener 등록법
> 간단한 설명만 하고 기본 리시버가 알아서 변환해서 알림 등록해준다고 설명할 예정

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