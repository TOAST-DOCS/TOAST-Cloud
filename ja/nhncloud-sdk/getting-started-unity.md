## NHN Cloud > SDK 사用ガイド > はじめに > Unity

<a id="supported-environment"></a>

## Supported Environment

* Unity 5.5.0 以上
* Android 4.0.3 以上
* iOS 8.0 以上
* XCode 最新バージョン（バージョン 9 以上）

<a id="nhn-cloud-sdk-components"></a>

## NHN Cloud SDK の構成

Unity 用 NHN Cloud SDK の構成は次のとおりです。

* [Logger](./log-collector-unity) SDK
* [IAP](./iap-unity) SDK

NHN Cloud SDK が提供するサービスの中から、使用したい機能を選択して適用できます。

| Unity package | Service |
| --- | --- |
| TOAST-Logger-UnityPlugin.unitypackage | Log & Crash |
| TOAST-IAP-UnityPlugin.unitypackage | IAP |
| TOAST-Sample-UnityPlugin.unitypackage | Sample |

<a id="structure-of-unity-package"></a>

### Unity package の構造

Unity 用 NHN Cloud SDK は、次のフォルダ構造になっています。

| Directory | Description | Unity package |
|---|---|---|
| Toast | NHN Cloud SDK のルートフォルダ | All |
| Toast/Common | SDK の共通モジュールフォルダ | All |
| Toast/Logger | Logger モジュールフォルダ | Logger、Sample |
| Toast/IAP | IAP モジュールフォルダ | IAP、Sample |
| Toast/Sample | SDK サンプルフォルダ | Sample |

<a id="apply-nhn-cloud-sdk-to-unity-projects"></a>

## NHN Cloud SDK を Unity プロジェクトに適用

NHN Cloud の [Download](../../../Download/#toast-sdk) ページから NHN Cloud SDK Unity をダウンロードします。

<a id="import-unity-package"></a>

### Unity package のインポート

ダウンロードした Unity Package をダブルクリックして、プロジェクトに追加します。

<a id="run-the-sample"></a>

### Sample の実行

Unity 用 NHN Cloud SDK には、別途の Sample Unity Package があります。Sample を実行する方法は次のとおりです。

1. Sample Unity Package をダブルクリックして、プロジェクトに追加します。
2. **File > Build Settings** で Toast/Sample/Sample.unity を **Scenes In Build** に追加します。
3. Android または iOS でビルドします。
4. ビルドされたアプリケーションを実行します。

> （注意）Unity SDK は現在、Android と iOS のみをサポートしています。
> Unity Editor では正常に動作しません。（サポート予定）

<a id="android-build-setup"></a>

## Android ビルド設定

<a id="unity-play-services-resolver"></a>

### Unity Play Services Resolver

* NHN Cloud SDK Unity（0.19.0〜）バージョンには、Unity Play Services Resolver ライブラリとともに配布されます。
* このライブラリは、Android 関連ライブラリ（例：AAR）の依存性を自動的に解決し、Unity プロジェクトにコピーします。

<a id="using-gradle-build-settings"></a>

#### Gradle ビルド設定を使用する場合

* Gradle ビルド設定は以下にあります。
* 以下のようにオプションを無効にし、受け取ったプラグインを削除してから使用します。
	1. Unity エディターで Assets（アセット）> Play Services Resolver（Play サービスリゾルバー）> Android Resolver（Android リゾルバー）> Settings（設定）を選択します。
	2. 設定で「Enable Auto-Resolution」と「Enable Resolution On Build」オプションを無効にします。
	3. Assets/Plugins/Android にある AAR ファイルを削除します。

<a id="using-the-provided-aar-libraries"></a>

#### AAR ライブラリの提供

* AAR ライブラリを圧縮ファイルとして添付して提供しています。
* 以下のようにオプションを無効にし、受け取ったプラグインを削除してから使用します。
	1. Unity エディターで Assets（アセット）> Play Services Resolver（Play サービスリゾルバー）> Android Resolver（Android リゾルバー）> Settings（設定）を選択します。
	2. 設定で「Enable Auto-Resolution」と「Enable Resolution On Build」オプションを無効にします。
	3. Assets/Plugins/Android にある AAR ファイルを削除します。

<a id="gradle-build-setup"></a>

### Gradle Build 設定

* NHN Cloud SDK は Android ビルド時に Gradle ビルドを使用します。

<a id="how-to-set-up-gradle-build"></a>

#### Gradle ビルド設定方法
1. **File > Build Settings > Android** を選択します。
2. **Build System** を **Gradle (New)** に選択します。
3. ビルドします。
    - Signing 関連のエラーが発生した場合は、Development Build オプションを有効にしてビルドを進めます。

<a id="create-a-gradle-template-file"></a>

#### Gradle Template ファイルの作成
##### 2017.2 以上
- **Edit > Project Settings > Player** の Publishing Settings で Custom Gradle Template を有効にします。
    - Build System を Gradle に選択しないと、Custom Gradle Template のトグルが有効になりません。
- オプションを有効にすると、Assets/Plugins/Android フォルダに mainTemplate.gradle が生成されます。

##### 2017.2 未満
- Unity インストールフォルダにある mainTemplate.gradle ファイルを Assets/Plugins/Android フォルダにコピーします。

> Windows：（Unity インストールフォルダ）\Editor\Data\PlaybackEngines\AndroidPlayer\Tools\GradleTemplates
> macOS：（Unity インストールフォルダ）/PlaybackEngines/AndroidPlayer/Tools/GradleTemplates

<a id="set-up-maintemplategradle"></a>

#### mainTemplate.gradle の設定
- mainTemplate.gradle に mavenCentral と Google リポジトリを追加します。
- 各モジュールごとに Android Unity プラグインがあり、使用したいモジュールのプラグインを mainTemplate.gradle に追加します。
    - Android Unity プラグインの追加に関するガイドは、モジュールごとのガイドを参照してください。

```groovy
allprojects {
    repositories {
        mavenCentral()
        maven {
            url 'https://maven.google.com'
        }

        flatDir {
            dirs 'libs'
        }
    }
}
```

<a id="proguard-setup"></a>

### Proguard 設定
- Android Unity Plugin 0.12.0 以上のバージョンを使用する場合、別途の設定は不要です。
    - Proguard を適用したい場合は、0.12.0 以上にアップデートしてください。

<a id="android-build-issue-faq"></a>

### Android ビルド失敗 FAQ

<a id="when-library-conflict-occurs"></a>

#### ライブラリ競合が発生した場合

> **ビルドエラーログ**
> com.android.build.api.transform.TransformException:java.util.zip.ZipException: duplicate entry: android/support/annotation/AnimRes.class See the Console for details.

- 上記のようなビルドエラーログが発生した場合、ライブラリ競合が発生しています。
- NHN Cloud SDK は依存ライブラリをできる限り持たないよう設計されていますが、唯一 **com.android.support:support-annotations** に依存しています。
- プロジェクトに support-annotations ライブラリが jar または aar ファイルとして存在する場合、ライブラリ競合が発生します。
- jar または aar ファイルとして存在する support-annotations のバージョンを確認し、以下のように修正するとビルドできます。

##### support-annotations のバージョンが 27.1.1 以下の場合
- 該当ファイルを削除します。

##### support-annotations のバージョンが 27.1.1 を超える場合
- 以下のように exclude を追加します。
```groovy
if (GradleVersion.current() >= GradleVersion.version("4.2")) {
    implementation('com.toast.android:toast-unity-XXX:X.X.X') {
        exclude group: 'com.android.support', module: 'support-annotations'
    }
} else {
    compile('com.toast.android:toast-unity-XXX:X.X.X') {
        exclude group: 'com.android.support', module: 'support-annotations'
    }
}
```

<a id="when-an-ndk-related-error-occurs"></a>

#### NDK 関連エラーが発生した場合
- Gradle を設定してビルドすると、以下のようなエラーが発生する場合があります。
> No toolchains found in the NDK toolchains folder for ABI with prefix: mips64el-linux-android
- このエラーは、NDK のバージョンが高く mips をサポートしなくなったことで発生する問題です。
    - Android Gradle Plugin を 3.2.1 以上にアップデートすると解決します。
    - 特定の Unity バージョンでは Android Gradle Plugin をアップデートできないため、Android SDK がインストールされたフォルダの ndk-bundle フォルダを削除すると問題が解決します。
    - IL2CPP ビルドに必要な NDK は、Android SDK 配下ではなく別のフォルダで管理するとバージョン管理が容易です。

<a id="ios-build-setup"></a>

## iOS ビルド設定

<a id="modify-xcode-build-settings"></a>

### Xcode ビルド設定の修正
* iOS で NHN Cloud SDK を使用するには、Xcode で以下の設定を追加する必要があります。

<a id="other-linker-flag-option"></a>

#### Other Linker Flag オプション
* Other Linker Flag オプションに **-ObjC**、**-lc++** を追加します。

<a id="enable-bitcode-option"></a>

#### Enable Bitcode オプション
* Enable Bitcode オプションを **NO** に設定します。

<a id="unity-play-services-resolver-2"></a>

### Unity Play Services Resolver

* NHN Cloud SDK Unity（0.19.0〜）バージョンには、Unity Play Services Resolver ライブラリとともに配布されます。
* このライブラリは、iOS CocoaPods を使用するライブラリの依存性を自動的に解決します。

> 注記）iOS の依存性は CocoaPods を使用して識別します。CocoaPods はビルド後の処理段階で実行されます。

* Unity 5.6 以上を使用する場合、必要な TOAST SDK ネイティブプラグインを含む xcworkspace が生成されます。標準の Xcode プロジェクトの代わりに、生成された xcworkspace を使用する必要があります。
* 以前のバージョンの Unity を使用する場合、依存性は標準 Xcode プロジェクトに含まれます。

<a id="using-the-provided-ios-framework"></a>

#### iOS framework の提供

* iOS framework を圧縮ファイルとして添付して提供しています。
* 以下のようにオプションを無効にして使用します。
	1. Unity エディターで Assets（アセット）> Play Services Resolver（Play サービスリゾルバー）> iOS Resolver（iOS リゾルバー）> Settings（設定）を選択します。
	2. 設定ですべてのオプションを無効にします。

<a id="initialize-nhn-cloud-sdk"></a>

## NHN Cloud SDK の初期化

NHN Cloud SDK を使用するには、最初のシーンのコンポーネントのいずれか一つの Start で初期化を実行します。

> 初期化を行わずに他の API を呼び出すと、正常に動作しません。

```csharp
public class GameStartBehaviour : MonoBehaviour
{
    void Start()
    {
        ToastSdk.Initialize();
    }
}
```

<a id="set-user-id"></a>

## UserID の設定

NHN Cloud SDK にユーザー ID を設定できます。
設定した UserID は NHN Cloud SDK の各モジュールで共通して使用されます。
ToastLogger のログ送信 API を呼び出すたびに、設定したユーザー ID をログとともにサーバーへ送信します。

<a id="specification-for-user-id-setting-api"></a>

### UserID 設定 API 仕様
```csharp
ToastSdk.UserId = userId;
```

<a id="usage-example-of-user-id-setting"></a>

### UserID 設定の使用例
```csharp
ToastSdk.UserId = "TOAST";
```

<a id="set-debug-mode"></a>

## デバッグモードの設定

NHN Cloud SDK の内部ログを確認するために、デバッグモードを設定できます。
NHN Cloud SDK へお問い合わせの際は、デバッグモードを有効にしてからご連絡いただくと、迅速にサポートできます。

<a id="specification-for-debug-mode-setting-api"></a>

### デバッグモード設定 API 仕様
```csharp
ToastSdk.DebugMode = true; // or false
```

> （注意）ゲームをリリースする場合は、必ずデバッグモードを無効にしてください。

<a id="use-nhn-cloud-service"></a>

## NHN Cloud Service の使用

* [Log & Crash](./log-collector-unity) 使用ガイド
* [IAP](./iap-unity) 使用ガイド