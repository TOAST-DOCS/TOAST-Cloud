## TOAST > TOAST SDK使用ガイド > 開始するUnity

## サポート環境

* Unity 5.5.0以上
* Android 4.0.3以上
* iOS 8.0以上
* XCode最新バージョン(バージョン9以上)

## TOAST SDKの構成

Unity用TOAST SDKの構成は次のとおりです。

* [TOAST Logger](./log-collector-unity) SDK
* [TOAST IAP](./iap-unity) SDK

TOAST SDKが提供するサービスの中から、希望する機能を選択して適用できます。

| Unity package | Service |
| --- | --- |
| TOAST-Logger-UnityPlugin.unitypackage | TOAST Log & Crash |
| TOAST-IAP-UnityPlugin.unitypackage | TOAST IAP |
| TOAST-Sample-UnityPlugin.unitypackage | Sample |

### Unity package構造

Unity用TOAST SDKは、次のようなフォルダ構造になっています。

| Directory | Description | Unity package |
|---|---|---|
| Toast | TOAST SDKのルートフォルダ | All |
| Toast/Common | TOAST SDKの共通モジュールフォルダ | All |
| Toast/Logger | TOAST Loggerモジュールフォルダ | Logger, Sample |
| Toast/IAP | TOAST IAPモジュールフォルダ | IAP, Sample |
| Toast/Sample | SDKサンプルフォルダ | Sample |

## TOAST SDKをUnityプロジェクトに適用

TOASTの[Download](../../../Download/#toast-sdk)ページでTOAST SDK Unityをダウンロードします。

### Unity packageのインポート

ダウンロードしたUnity Packageをダブルクリックしてプロジェクトに含めます。

### Sample実行

Unity用TOAST SDKは、別途のSample Unity Packageがあります。Sampleを実行する方法は次のとおりです。

1. Sample Unity Packageをダブルクリックしてプロジェクトに含めます。
2. **File > Build Settings**でToast/Sample/Sample.unityを**Scenes In Build**に追加します。
3. AndroidまたはiOSでビルドします。
4. ビルドされたアプリケーションを実行します。

> (注意) Unity SDKは現在Android、iOSのみをサポートします。
> Unity Editorでは正常に動作しません。 (サポート予定)

## 設定

### Andrroid

### Unity Play Services Resolver  

* TOAST SDK Unity(0.19.0~) 버전에는 Unity Play Services Resolver 라이브러리와 함께 배포됩니다.  
* 이 라이브러리는 안드로이드 관련 라이브러리(예:AAR)에 대한 종속성을 자동으로 해결하여 Unity 프로젝트에 복사됩니다.  

#### Gradle 빌드 설정을 사용할 경우

* Gradle 빌드 설정은 아래에 있습니다.  
* 아래와 같이 옵션을 제거하고 받은 플러그인을 제거하고 사용하시면 됩니다 .
	1. Unity 편집기에서 Assets(애셋) > Play Services Resolver(Play 서비스 리졸버) > Android Resolver(Android 리졸버) > Settings(세팅)을 선택합니다.
	2. 설정에서 "Enable Auto-Resolution"과 "Enable Resolution On Build" 옵션을 끕니다.	 
	3. Assets/Plugins/Android에 있는 AAR파일을 제거합니다.

#### AAR 라이브러리 제공

* AAR 라이브러리들을 압축파일로 첨부해서 제공하고 있습니다.  
* 아래와 같이 옵션을 제거하고 받은 플러그인을 제거하고 사용하시면 됩니다 .
	1. Unity 편집기에서 Assets(애셋) > Play Services Resolver(Play 서비스 리졸버) > Android Resolver(Android 리졸버) > Settings(세팅)을 선택합니다.
	2. 설정에서 "Enable Auto-Resolution"과 "Enable Resolution On Build" 옵션을 끕니다.
	3. Assets/Plugins/Android에 있는 AAR파일을 제거합니다.

### Gradle Build設定

* TOAST SDKは、Androidビルド時にGradleビルドを使用します。

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
* iOSでTOAST SDKを使用するには、Xcodeで下記の設定を追加する必要があります。

#### Other Linker Flagオプション
* Other Linker Flagオプションに**-ObjC**、**-lc++**を追加します。

#### Enable Bitcodeオプション
* Enable Bitcodeオプションを**NO**に設定します。

### Unity Play Services Resolver  

* TOAST SDK Unity(0.19.0~) 버전에는 Unity Play Services Resolver 라이브러리와 함께 배포됩니다.  
* 이 라이브러리는 iOS CocoaPods을 사용하는 라이브러리에 대한 종속성을 자동으로 해결해줍니다.

> 참고) iOS 종속성은 CocoaPods를 사용하여 식별합니다. CocoaPods는 빌드 후 처리단계에서 실행됩니다.

* Unity 5.6이상을 사용하는 경우 필요한 TOAST SDK native plugin을 포하하는 xcworkspace가 생성됩니다. 표준 xcode 프로젝트 대신 생성된 xcworkspace를 사용해야 합니다.
* 이전 버전의 Unity를 사용할 때 종속성이 표준 Xcode 프로젝트에 포함됩니다.

#### iOS framework 제공

* iOS framework들을 압축파일로 첨부해서 제공하고 있습니다.  
* 아래와 같이 옵션을 제거하고 사용하시면 됩니다.  
	1. Unity 편집기에서 Assets(애셋) > Play Services Resolver(Play 서비스 리졸버) > iOS Resolver(iOS 리졸버) > Settings(세팅)을 선택합니다.
	2. 설정에서 모든 옵션을 끕니다.

## TOAST SDK初期化

TOAST SDKを使用するために最初のSceneのコンポーネントの中から1つのStartで初期化を実行します。

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

TOAST SDKにユーザーIDを設定できます。
設定したUserIDは、ToastSDKの各モジュールで共通使用されます。
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

TOAST SDKの内部ログ確認するために、デバッグモードを設定できます。
TOAST SDKに関するお問い合わせの際は、デバッグモードを有効にしていただくと、迅速にサポートできます。

### デバッグモード設定API仕様
```csharp
ToastSdk.DebugMode = true; // or false
```

> (注意)ゲームをリリースする場合、必ずデバッグモードを無効にする必要があります。

## TOAST Serviceを使用する

* [TOAST Log & Crash](./log-collector-unity)使用ガイド
* [TOAST IAP](./iap-unity)使用ガイド
