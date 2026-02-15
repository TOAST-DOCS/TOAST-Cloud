## NHN Cloud > SDK使用ガイド > 開始するUnity

## サポート環境

* Unity 5.5.0以上
* Android 4.0.3以上
* iOS 8.0以上
* XCode最新バージョン(バージョン9以上)

## NHN Cloud SDKの構成

Unity用NHN CloudSDKの構成は次のとおりです。

* [Logger](./log-collector-unity) SDK
* [IAP](./iap-unity) SDK

NHN Cloud SDKが提供するサービスの中から、希望する機能を選択して適用できます。

| Unity package | Service |
| --- | --- |
| TOAST-Logger-UnityPlugin.unitypackage | Log & Crash |
| TOAST-IAP-UnityPlugin.unitypackage | IAP |
| TOAST-Sample-UnityPlugin.unitypackage | Sample |

### Unity package構造

Unity用NHN Cloud SDKは、次のようなフォルダ構造になっています。

| Directory | Description | Unity package |
|---|---|---|
| Toast | NHN Cloud SDKのルートフォルダ | All |
| Toast/Common | SDKの共通モジュールフォルダ | All |
| Toast/Logger | Loggerモジュールフォルダ | Logger, Sample |
| Toast/IAP | IAPモジュールフォルダ | IAP, Sample |
| Toast/Sample | SDKサンプルフォルダ | Sample |

## NHN Cloud SDKをUnityプロジェクトに適用

NHN Cloudの[Download](../../../Download/#toast-sdk)ページでNHN Cloud SDK Unityをダウンロードします。

### Unity packageのインポート

ダウンロードしたUnity Packageをダブルクリックしてプロジェクトに含めます。

### Sample実行

Unity用NHN Cloud SDKは、別途のSample Unity Packageがあります。Sampleを実行する方法は次のとおりです。

1. Sample Unity Packageをダブルクリックしてプロジェクトに含めます。
2. **File > Build Settings**でToast/Sample/Sample.unityを**Scenes In Build**に追加します。
3. AndroidまたはiOSでビルドします。
4. ビルドされたアプリケーションを実行します。

> (注意) Unity SDKは現在Android、iOSのみをサポートします。
> Unity Editorでは正常に動作しません。 (サポート予定)

## 設定

### Android

### Unity Play Services Resolver  

* NHN Cloud SDK Unity(0.19.0～)バージョンはUnity Play Services Resolverライブラリと一緒に配布されます。  
* このライブラリはAndroid関連ライブラリ(例：AAR)の依存関係を自動的に解決してUnityプロジェクトにコピーされます。  

#### Gradleビルド設定を使用する場合

* Gradleビルド設定は以下にあります。
* 以下のようにオプションを削除して、受信したプラグインを削除して使用してください。
	1. UnityエディタでAssets(アセット) > Play Services Resolver(Playサービスレゾルバ) > Android Resolver(Androidレゾルバ) > Settings(セッティング)を選択します。
	2. 設定で"Enable Auto-Resolution"と"Enable Resolution On Build"オプションをオフにします。
	3. Assets/Plugins/AndroidにあるAARファイルを削除します。

#### AARライブラリ提供

* AARライブラリなどを圧縮ファイルで添付して提供しています。
* 以下のようにオプションを削除して、受信したプラグインを削除して使用してください。
	1. UnityエディタでAssets(アセット) > Play Services Resolver(Playサービスレゾルバ) > Android Resolver(Androidレゾルバ) > Settings(セッティング)を選択します。
	2. 設定で"Enable Auto-Resolution"と"Enable Resolution On Build"オプションをオフにします。
	3. Assets/Plugins/AndroidにあるAARファイルを削除します。

### Gradle Build設定

* NHN Cloud SDKは、Androidビルド時にGradleビルドを使用します。

#### Gradleビルド設定方法
1. **File > Build Settings > Android**を選択します。
2. **Build System**を**Gradle (New)**に選択
3. Build
    - Signing関連エラーが発生する場合、Development BuildオプションをOnにしてビルドを進行してください。

#### Gradle Templateファイル作成
##### 2017.2以上
- **Edit > Project Settings > Player**のPublishing SettingsのCustom Gradle Templateを有効にします。
    - Build SystemをGradleに選択すると、Custom Gradle Templateのトグルが有効になります。
- オプションを有効にすると、 Assets/Plugins/AndroidフォルダにmainTemplate.gradleが作成されます。

##### 2017.2未満
- UnityインストールフォルダにあるmainTemplate.gradleファイルをAssets/Plugins/Androidフォルダにコピーします。

> Windows： (Unityインストールフォルダ)\Editor\Data\PlaybackEngines\AndroidPlayer\Tools\GradleTemplates
> macOS： (Unityインストールフォルダ)/PlaybackEngines/AndroidPlayer/Tools/GradleTemplates

#### mainTemplate.gradle設定
- mainTemplate.gradleにmavenCentralとGoogleリポジトリを追加します。
- 各モジュール別にAndroid Unityプラグインがあり、使用したいモジュールのプラグインをmainTemplate.gradleに追加します。
    - Android Unityプラグイン追加に関するガイドは、モジュール別ガイドを確認してください。

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

#### NDK関連エラー発生時
- Gradleを設定してビルドを行うと、下記のようなエラーが発生することがあります。
> No toolchains found in the NDK toolchains folder for ABI with prefix: mips64el-linux-android
- このエラーは、NDKのバージョンが高いためにmipsをサポートしなくなることで発生する問題です。
    - これはAndroid Gradle Pluginを3.2.1以上にアップデートすると解決します。
    - 特定UnityバージョンではAndroid Gradle Pluginをアップデートできないため、Android SDKがインストールされたフォルダのndk-bundleフォルダを削除すると問題が解決します。
    - IL2CPPビルドに必要なNDKは、Android SDKの下位ではなく、別途のフォルダで管理するとバージョン管理が容易です。

### Proguard設定
- Android Unity Plugin 0.12.0以上のバージョンを使用する場合は、別途の設定が不要です。
    - Proguardを適用したい場合、 0.12.0以上にアップデートしてください。


### iOS

### Xcodeビルド設定修正
* iOSでNHN Cloud SDKを使用するには、Xcodeで下記の設定を追加する必要があります。

#### Other Linker Flagオプション
* Other Linker Flagオプションに**-ObjC**、**-lc++**を追加します。

#### Enable Bitcodeオプション
* Enable Bitcodeオプションを**NO**に設定します。

### Unity Play Services Resolver  

* NHN Cloud SDK Unity(0.19.0～)バージョンにはUnity Play Services Resolverライブラリと一緒に配布されます。  
* このライブラリはiOS CocoaPodsを使用するライブラリの依存関係を自動的に解決します。

> 参考) iOSの依存関係はCocoaPodsを使用して識別します。 CocoaPodsはビルド後、処理段階で実行されます。

* Unity 5.6以上を使用する場合、必要なTOAST SDK native pluginを含むxcworkspaceが作成されます。標準xcodeプロジェクトの代わりに作成されたxcworkspaceを使用する必要があります。
* 以前のバージョンのUnityを使用する時、依存関係が標準Xcodeプロジェクトに含まれます。

#### iOS framework提供

* iOS frameworkなどを圧縮ファイルで添付して提供しています。
* 以下のようにオプションを削除して使用してください。
	1. UnityエディタでAssets(アセット) > Play Services Resolver(Playサービスレゾルバ) > iOS Resolver(iOSレゾルバ) > Settings(セッティング)を選択します。
	2. 設定ですべてのオプションをオフにします。

## NHN Cloud SDK初期化

NHN Cloud SDKを使用するために最初のSceneのコンポーネントの中から1つのStartで初期化を実行します。

> 初期化せずに他のAPIを呼び出す場合、正常に動作しません。

```csharp
public class GameStartBehaviour : MonoBehaviour
{
    void Start()
    {
        ToastSdk.Initialize();
    }
}
```

## UserID設定

NHN Cloud SDKにユーザーIDを設定できます。
設定したUserIDは、NHN Cloud SDKの各モジュールで共通使用されます。
ToastLoggerのログ送信APIを呼び出すたびに、設定したユーザーIDをログと一緒にサーバーに送信します。

### UserID設定API仕様
```csharp
ToastSdk.UserId = userId;
```

### UserID設定使用例
```csharp
ToastSdk.UserId = "TOAST";
```

## デバッグモードを設定する

NHN Cloud SDKの内部ログ確認するために、デバッグモードを設定できます。
NHN Cloud SDKに関するお問い合わせの際は、デバッグモードを有効にしていただくと、迅速にサポートできます。

### デバッグモード設定API仕様
```csharp
ToastSdk.DebugMode = true; // or false
```

> (注意)ゲームをリリースする場合、必ずデバッグモードを無効にする必要があります。

## NHN Cloud Serviceを使用する

* [Log & Crash](./log-collector-unity)使用ガイド
* [IAP](./iap-unity)使用ガイド
