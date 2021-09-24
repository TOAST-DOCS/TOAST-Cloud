## NHN Cloud > NHN Cloud SDK使用ガイド > NHN Cloud Log & Crash > Android (NDK)

## Android NDKクラッシュレポート

Androidアプリにネイティブライブラリーが含まれる場合、簡単なビルド設定でネイティブコードに対する全体スタック追跡と詳細なエラーレポートを利用できるようになります。

* NHN Cloud Crash Reporter for NDKは、**NHN Cloud 0.21.0以上**で使用可能です。
* NHN Cloud Crash Reporter for NDKは、NHN Cloud Loggerを通じてクラッシュログを送信します。
* NHN Cloud LoggerとNHN Cloud Crash Reporter for NDKライブラリーは、**同一バージョンの使用を推奨**します。
* NHN Cloud Crash Reporter for NDKは NHN Cloud Loggerの初期化時にクラッシュの検知を開始します。
* NHN Cloud Crash Reporter for NDKを使用するためには、**r17c以上のNDK**が必要です。

### 事前準備

1. [NHN Cloud Log & Crash](./log-collector-android)事前準備

### ライブラリー設定
- アプリレベルbuild.gradleで、依存性を追加します。

```groovy
repositories {
    mavenCentral()
}

dependencies {
    // ...

    // Add the TOAST Logger dependency
    implementation 'com.toast.android:toast-logger:0.27.3'

    // Add the TOAST Crash Reporter for NDK dependency
    implementation 'com.toast.android:toast-crash-reporter-ndk:0.27.3'
}
```

### クラッシュ分析

* Nativeクラッシュが発生すると、ダンプ(.dmp)ファイルが生成されます。
* 生成されたダインプファイルを解析する過程を、**Symbolication**といいます。
* 正確なスタック追跡のためには、必ずシンボルファイルをアップロードしてください。
* シンボルファイルがアップロードされたら、クラッシュ発生時にLog & Crash Searchのコンソールにおいて、分析されたクラッシュ情報を閲覧できます。

#### シンボルファイルのアップロード

* シンボルファイルはProjectの特定パスに {library name}.soというファイル名で作成されます。
* アップロードファイルの最大サイズは、500MBです。
* {library name}.soを {library name}.so.zipに圧縮して、[Log & Crash Search > 設定 > シンボルファイル]からアップロードします。

#### シンボルファイルのパス

- ndk-build : {PROJECT}/obj/local/{ANDROID_ABI} 配下に .soファイルが作成されます。
- cmake : {PROJECT}/build/intermediates/{VARIANTS}/obj/{ANDROID_ABI}配下の.soファイルが作成されます。
