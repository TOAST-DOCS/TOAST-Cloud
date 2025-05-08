## NHN Cloud > SDK使用ガイド > 開始する > Android

## サポート環境

* Android 4.0.3以上
* Android Studio最新バージョン(バージョン2.2以上)

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
| com.nhncloud.android:nhncloud-common:1.10.0       | Common      |
| com.nhncloud.android:nhncloud-core:1.10.0         | Core        |
| com.nhncloud.android:nhncloud-logger:1.10.0       | Log & Crash |
| com.nhncloud.android:nhncloud-crash-reporter-ndk:1.10.0       | Native Crash Reporter |
| com.nhncloud.android:nhncloud-iap-core:1.10.0     | In-app Purchase Core |
| com.nhncloud.android:nhncloud-iap-google:1.10.0   | In-app Purchase <br>Google Play Store |
| com.nhncloud.android:nhncloud-iap-onestore2:1.10.0 | In-app Purchase <br>ONE store(統合バージョン) |
| com.nhncloud.android:nhncloud-iap-onestore:1.10.0 | In-app Purchase <br>ONE store(v17) |
| com.nhncloud.android:nhncloud-iap-onestore-v16:1.10.0 | In-app Purchase <br>ONE store(v16) |
| com.nhncloud.android:nhncloud-iap-onestore-v19:1.10.0 | In-app Purchase <br>ONE store(v19) |
| com.nhncloud.android:nhncloud-iap-onestore-v21:1.10.0 | In-app Purchase <br>ONE store(v21) |
| com.nhncloud.android:nhncloud-iap-galaxy:1.10.0 | In-app Purchase <br>Galaxy Store |
| com.nhncloud.android:nhncloud-push-core:1.10.0    | Push Core   |
| com.nhncloud.android:nhncloud-push-fcm:1.10.0    | Push <br>Firebase Cloud Messaging |
| com.nhncloud.android:nhncloud-creditcard-recognizer:1.10.0    | Credit Card Recognizer |

## NHN Cloud SDKをAndroid Studioプロジェクトに適用

### 1. Gradleを使用してAndroidビルド

NHN Cloud SDKのすべてのサービスを使用するには、下記のように従属性(dependency)を設定します。

> Unityを使用する場合、別途の従属性設定を行う必要があります。
> 詳細は[Unityガイド](./getting-started-unity/#android)を参照してください。

```groovy
repositories {
  mavenCentral()
}

dependencies {
  implementation 'com.nhncloud.android：nhncloud-sdk：1.10.0'
}
```

NHN Cloud SDKが提供するサービス別の設定方法は次のとおりです。

- [Loggerライブラリ設定](./log-collector-android/#_1)
- [Native Crash Reporterライブラリ設定](./log-collector-ndk/#_1)
- [In-app Purchaseライブラリ設定](./iap-android/#_2)
- [Pushライブラリ設定](./push-android/#_2)
- [Credit Card Recognizerライブラリ設定](./creditcard-recognizer-android/#_1)

### 2. AARを使用してAndroidビルド

Android SDKは[Downloads](../../../Download/#toast-sdk)ページでダウンロードできます。

## UserID設定

NHN Cloud SDKにUserIDを設定できます。
設定したUserIDは、NHN Cloud SDKの各モジュールで共通使用されます。
NhnCloudLoggerのログ送信APIを呼び出すたびに、設定したUserIDをログと一緒にサーバーに送信します。

### UserID設定API仕様

```java
/* NhnCloudSdk.java */
public static void setUserId(String userId);
```

| Parameters | |
| -- | -- |
| userId | String：ユーザーID|

### UserID設定例

#### ログイン

```java
// Login.
NhnCloudSdk.setUserId(userId);
```

#### ログアウト

```java
// Logout.
NhnCloudSdk.setUserId(null);
```

## デバッグモード設定

NHN Cloud SDKの内部ログを確認するために、デバッグモードを設定できます。
NHN Cloud SDKに関するお問い合わせの際は、デバッグモードを有効にしていただくと、迅速にサポートできます。

### デバッグモード設定API仕様

```java
/* NhnCloudSdk.java */
public static void setDebugMode(boolean debug);
```

| Parameters | |
| -- | -- |
| debug | boolean：デバッグモードを有効にするにはtrue、無効にする場合はfalse。|

### デバッグモード設定使用例

#### デバッグモード有効化

```java
// Enable debug mode.
NhnCloudSdk.setDebugMode(true);
```

#### デバッグモード無効化

```java
// Disable debug mode.
NhnCloudSdk.setDebugMode(false);
```

> [注意]アプリをリリースする時は、デバッグモードを無効化する必要があります。

## NHN Cloudサービス使用

* [Log & Crash](./log-collector-android)使用ガイド
* [Native Crash Reporter](./log-collector-ndk)使用ガイド
* [In-app Purchase](./iap-android)使用ガイド
* [Push](./push-android)使用ガイド
* [Credit Card Recognizer](./creditcard-recognizer-android)使用ガイド
