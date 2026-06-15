<!-- pre-align:aligned sig=48d2b659f224 -->

## NHN Cloud > SDK使用ガイド > 開始する > Android

<a id="supported-environment"></a>

## サポート環境

* Android 5.1(API 22)以上

<a id="nhn-cloud-sdk-components"></a>

## NHN Cloud SDKの構成

Android用NHN Cloud SDKの構成は次のとおりです。

* Common SDK
* Core SDK
* [Logger](./log-collector-android) SDK
* [Native Crash Reporter](./log-collector-ndk) SDK
* In-app Purchase Core SDK
* [In-app Purchase Google Play Store](./iap-android) SDK
* [In-app Purchase OneStore](./iap-android) SDK
* Push Core SDK
* [Push Firebase Cloud Messaging](./push-android) SDK
* [Credit Card Recognizer](./creditcard-recognizer-android) SDK

NHN Cloud SDKが提供するサービスの中から、希望する機能を選択して適用できます。

| Gradle Dependency                           | Service           |
| ------------------------------------------- | ----------------- |
| com.nhncloud.android:nhncloud-common:1.12.0       | Common      |
| com.nhncloud.android:nhncloud-core:1.12.0         | Core        |
| com.nhncloud.android:nhncloud-logger:1.12.0       | Log & Crash |
| com.nhncloud.android:nhncloud-crash-reporter-ndk:1.12.0       | Native Crash Reporter |
| com.nhncloud.android:nhncloud-iap-core:1.12.0     | In-app Purchase Core |
| com.nhncloud.android:nhncloud-iap-google:1.12.0   | In-app Purchase <br>Google Play Store |
| com.nhncloud.android:nhncloud-iap-onestore2:1.12.0 | In-app Purchase <br>ONE store(統合バージョン) |
| com.nhncloud.android:nhncloud-iap-onestore:1.12.0 | In-app Purchase <br>ONE store(v17) |
| com.nhncloud.android:nhncloud-iap-onestore-v16:1.12.0 | In-app Purchase <br>ONE store(v16) |
| com.nhncloud.android:nhncloud-iap-onestore-v19:1.12.0 | In-app Purchase <br>ONE store(v19) |
| com.nhncloud.android:nhncloud-iap-onestore-v21:1.12.0 | In-app Purchase <br>ONE store(v21) |
| com.nhncloud.android:nhncloud-iap-galaxy:1.12.0 | In-app Purchase <br>Galaxy Store |
| com.nhncloud.android:nhncloud-push-core:1.12.0    | Push Core   |
| com.nhncloud.android:nhncloud-push-fcm:1.12.0    | Push <br>Firebase Cloud Messaging |
| com.nhncloud.android:nhncloud-creditcard-recognizer:1.12.0    | Credit Card Recognizer |

<a id="apply-nhn-cloud-sdk-to-android-studio-projects"></a>

## NHN Cloud SDKをAndroid Studioプロジェクトに適用

<a id="build-android-with-gradle"></a>

### 1. Gradleを使用してAndroidビルド

NHN Cloud SDKのすべてのサービスを使用するには、下記のように従属性(dependency)を設定します。

```groovy
repositories {
  mavenCentral()
}

dependencies {
  implementation 'com.nhncloud.android：nhncloud-sdk：1.12.0'
}
```

NHN Cloud SDKが提供するサービス別の設定方法は次のとおりです。

- [Loggerライブラリ設定](./log-collector-android/#_1)
- [Native Crash Reporterライブラリ設定](./log-collector-ndk/#_1)
- [In-app Purchaseライブラリ設定](./iap-android/#_2)
- [Pushライブラリ設定](./push-android/#_2)
- [Credit Card Recognizerライブラリ設定](./creditcard-recognizer-android/#_1)

<a id="build-android-with-aar"></a>

### 2. AARを使用してAndroidビルド

Android SDKは[Downloads](../../../Download/#toast-sdk)ページでダウンロードできます。

<a id="set-user-id"></a>

## UserID設定

NHN Cloud SDKにUserIDを設定できます。
設定したUserIDは、NHN Cloud SDKの各モジュールで共通使用されます。
NhnCloudLoggerのログ送信APIを呼び出すたびに、設定したUserIDをログと一緒にサーバーに送信します。

<a id="specification-for-user-id-setting-api"></a>

### UserID設定API仕様

```java
/* NhnCloudSdk.java */
public static void setUserId(String userId);
```

| Parameters | |
| -- | -- |
| userId | String：ユーザーID|

<a id="example-of-user-id-setting"></a>

### UserID設定例

<a id="login"></a>

#### ログイン

```java
// Login.
NhnCloudSdk.setUserId(userId);
```

<a id="logout"></a>

#### ログアウト

```java
// Logout.
NhnCloudSdk.setUserId(null);
```

<a id="set-debug-mode"></a>

## デバッグモード設定

NHN Cloud SDKの内部ログを確認するために、デバッグモードを設定できます。
NHN Cloud SDKに関するお問い合わせの際は、デバッグモードを有効にしていただくと、迅速にサポートできます。

<a id="specification-for-debug-mode-setting-api"></a>

### デバッグモード設定API仕様

```java
/* NhnCloudSdk.java */
public static void setDebugMode(boolean debug);
```

| Parameters | |
| -- | -- |
| debug | boolean：デバッグモードを有効にするにはtrue、無効にする場合はfalse。|

<a id="usage-example-of-debug-mode-setting"></a>

### デバッグモード設定使用例

<a id="enable-debug-mode"></a>

#### デバッグモード有効化

```java
// Enable debug mode.
NhnCloudSdk.setDebugMode(true);
```

<a id="disable-debug-mode"></a>

#### デバッグモード無効化

```java
// Disable debug mode.
NhnCloudSdk.setDebugMode(false);
```

> [注意]アプリをリリースする時は、デバッグモードを無効化する必要があります。

<a id="use-nhn-cloud-services"></a>

## NHN Cloudサービス使用

* [Log & Crash](./log-collector-android)使用ガイド
* [Native Crash Reporter](./log-collector-ndk)使用ガイド
* [In-app Purchase](./iap-android)使用ガイド
* [Push](./push-android)使用ガイド
* [Credit Card Recognizer](./creditcard-recognizer-android)使用ガイド
