## TOAST > TOAST SDK使用ガイド > 開始する > Android

## サポート環境

* Android 4.0.3以上
* Android Studio最新バージョン(バージョン2.2以上)

## TOAST SDKの構成

Android用TOAST SDKの構成は次のとおりです。

* TOAST Common SDK
* TOAST Core SDK
* [TOAST Logger](./log-collector-android) SDK
* TOAST In-app Purchase Core SDK
* [TOAST In-app Purchase Google Play Store](./iap-android) SDK
* [TOAST In-app Purchase OneStore](./iap-android) SDK
* TOAST Push Core SDK
* [TOAST Push Firebase Cloud Messaging](./push-android) SDK

TOAST SDKが提供するサービスの中から、希望する機能を選択して適用できます。

| Gradle Dependency | Service |
| --- | --- |
| com.toast.android:toast-common:0.20.1       | TOAST Common      |
| com.toast.android:toast-core:0.20.1         | TOAST Core        |
| com.toast.android:toast-logger:0.20.1       | TOAST Log & Crash |
| com.toast.android:toast-iap-core:0.20.1     | TOAST In-app Purchase Core |
| com.toast.android:toast-iap-google:0.20.1   | TOAST In-app Purchase <br>Google Play Store |
| com.toast.android:toast-iap-onestore:0.20.1 | TOAST In-app Purchase <br>OneStore |
| com.toast.android:toast-push-core:0.20.1    | TOAST Push Core   |
| com.toast.android:toast-push-fcm:0.20.1    | TOAST Push <br>Firebase Cloud Messaging |
| com.toast.android:toast-push-tencent:0.20.1    | TOAST Push <br>Tencent Push Notification |

## TOAST SDKをAndroid Studioプロジェクトに適用

### 1. Gradleを使用してAndroidビルド

TOAST SDKのすべてのサービスを使用するには、下記のように従属性(dependency)を設定します。

> Unityを使用する場合、別途の従属性設定を行う必要があります。
> 詳細は[Unityガイド](./getting-started-unity/#android)を参照してください。

```groovy
dependencies {
  implementation 'com.toast.android：toast-sdk：0.18.0'
}
```

TOAST SDKが提供するサービス別の設定方法は次のとおりです。

- [TOAST Loggerライブラリ設定](./log-collector-android/#_1)
- [TOAST In-app Purchaseライブラリ設定](./iap-android/#_2)
- [TOAST Pushライブラリ設定](./push-android/#_2)

### 2. AARを使用してAndroidビルド

Android SDKは[Downloads](../../../Download/#toast-sdk)ページでダウンロードできます。

## UserID設定

TOASAT SDKにUserIDを設定できます。
設定したUserIDは、TOAST SDKの各モジュールで共通使用されます。
ToastLoggerのログ送信APIを呼び出すたびに、設定したUserIDをログと一緒にサーバーに送信します。

### UserID設定API仕様

```java
/* ToastSdk.java */
public static void setUserId(String userId);
```

| Parameters | |
| -- | -- |
| userId | String：ユーザーID|

### UserID設定例

#### ログイン

```java
// Login.
ToastSdk.setUserId(userId);
```

#### ログアウト

```java
// Logout.
ToastSdk.setUserId(null);
```

## デバッグモード設定

TOAST SDKの内部ログを確認するために、デバッグモードを設定できます。
TOAST SDKに関するお問い合わせの際は、デバッグモードを有効にしていただくと、迅速にサポートできます。

### デバッグモード設定API仕様

```java
/* ToastSdk.java */
public static void setDebugMode(boolean debug);
```

| Parameters | |
| -- | -- |
| debug | boolean：デバッグモードを有効にするにはtrue、無効にする場合はfalse。|

### デバッグモード設定使用例

#### デバッグモード有効化

```java
// Enable debug mode.
ToastSdk.setDebugMode(true);
```

#### デバッグモード無効化

```java
// Disable debug mode.
ToastSdk.setDebugMode(false);
```

> [注意]アプリをリリースする時は、デバッグモードを無効化する必要があります。

## TOASTサービス使用

* [TOAST Log & Crash](./log-collector-android)使用ガイド
* [TOAST In-app Purchase](./iap-android)使用ガイド
* [TOAST Push](./push-android)使用ガイド
