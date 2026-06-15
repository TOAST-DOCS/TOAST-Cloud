<!-- pre-align:aligned sig=f489a938dab7 -->

## NHN Cloud > SDK使用ガイド > Log & Crash > Android (Symbol Uploader)

<a id="prerequisites"></a>

## 事前準備

1. Androidプロジェクトに[NHN Cloud Loggerを追加](/nhncloud/ja/nhncloud-sdk/log-collector-android/)します。
2. Androidアプリにネイティブライブラリが含まれている場合は、[NHN Cloud Crash Reporter for NDKを追加](/nhncloud/ja/nhncloud-sdk/log-collector-ndk/)します。

<a id="library-setting"></a>

## ライブラリ設定

プロジェクトレベルのbuild.gradleファイルにNHN Cloud Gradle Pluginをbuildscript依存性項目に追加します。

```groovy
buildscript {
    repositories {
        mavenCentral()
    }

    dependencies {
        // ...

        // Add the NHN Cloud Gradle Plugin
        classpath "com.toast.android:toast-gradle-plugin:0.0.1"
    }
}
```

アプリレベルのbuild.gradleファイルにNHN Cloud Gradle Pluginを適用します。

```groovy
// Apply the NHN Cloud Gradle Plugin
apply plugin: 'com.toast.android.toast-services'
```

<a id="enable-mappingtxt-file-upload"></a>

## mapping.txtファイルアップロード使用設定

ProGuard、R8でコード難読化されているスタックトレースを人が読むことができるコードにレンダリングするには、ビルド時に作成されたマッピングファイルをNHN Cloud Log & Crash Searchにアップロードする必要があります。
NHN Cloud Gradle Pluginにはマッピングファイルのアップロードを自動化する`uploadMappingFile{BUILD_VARIANT}`タスクが含まれています。このタスクを有効にするには`mappingFileUploadEnabled`が`true`に設定されていることを確認します。


マッピングファイルのアップロードタスクを有効にするには、アプリレベルのbuild.gradleファイルで`mappingFileUploadEnabled`を`true`に設定します。

```groovy
toastServices {
    crashReporter {
        appKey "appKey"
        mappingFileUploadEnabled true
    }
}
```

<a id="enable-native-symbol-file-upload"></a>

## Native symbolファイルのアップロード使用設定

NDK異常終了から読み取り可能なスタックトレースを作成するには、NHN Cloud Log & Crash Searchでネイティブバイナリのシンボルについて把握する必要があります。
NHN Cloud Gradle Pluginにはネイティブシンボルファイルのアップロードを自動化する`uploadSymbolFile{BUILD_VARIANT}`タスクが含まれています。
このタスクを有効にするには、`nativeSymbolUploadEnabled`が`true`に設定されていることを確認します。

ファイルアップロードタスクを有効にするには、アプリレベルのbuild.gradleファイルで`nativeSymbolUploadEnabled`を`true`に設定します。

```groovy
toastServices {
    crashReporter {
        appKey "appKey"
        nativeSymbolUploadEnabled true
    }
}
```

<a id="configure-build-variants"></a>

## ビルド変形構成

Build TypesまたはProduct Flavors、Variantsの構成に応じてアプリケーションキーおよびアップロードを有効にするかどうかを設定できます。

```groovy
toastServices {
    crashReporter {
        buildTypes {
            debug {
            }
            release {
                mappingFileUploadEnabled true
                nativeSymbolUploadEnabled false
            }
        }
        productFlavors {
            alpha {
                appKey "alphaAppKey"
                serviceZone "ALPHA"
            }
            real {
                appKey "realAppKey"
                serviceZone "REAL"
            }
            staging {
            }
            prod {
            }
        }
        variants {
            realProdRelease.nativeSymbolUploadEnabled = true
        }
    }
}
```

<a id="execute-the-file-upload-task"></a>

## ファイルアップロードタスク実行

マッピングファイルまたはネイティブシンボルファイルをTOAST Log & Crash Searchにアップロードするには、アップロードタスクを明示的に呼び出す必要があります。
例えば次のとおりです。

```
> ./gradlew app:assemble{BUILD_VARIANT}
            app:uploadMappingFile{BUILD_VARIANT}
            app:uploadSymbolFile{BUILD_VARIANT}
```
