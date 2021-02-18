## NHN Cloud > NHN Cloud SDK使用ガイド > 開始する > Windows C++

## サポート環境

* Windows 7
* Windows 10

## NHN Cloud SDKの構成

Windows C++用NHN Cloud SDKの構成は次のとおりです。

| Directory | Description |
|---|---|
| docs/ | Windows SDK文書 |
| include/toast/ | C++ ヘッダファイル |
| windows-sdk/lib32/ | C++ Windows 32bitライブラリ |
| windows-sdk/lib64/ | C++ Windows 64bitライブラリ |
| windows-sdk-sample/ | サンプルプロジェクト |

## NHN Cloud SDKをVisual Studioプロジェクトに適用する

NHN Cloudの[Downloads](../../../Download/#toast-sdk)ページでNHN Cloud Windows C++ SDKをダウンロードします。

### ライブラリを含める

1. メニューバーの**Project**タブで**Properties**を選択します。
2. **C/C++ > General > Additional Include Directories**でSdkのヘッダファイルパスを設定します。
3. **Linker > General > Additional Library Directories**でビルド環境(Debug/Release)とTarget Machine(x86、x64)に応じてライブラリを含めます。
4. **Linker > Input > Additional Dependencies**でビルド環境(Debug/Release)とTarget Machine(x86、x64)に応じて追加するlibを入力します。

[参考] [https://msdn.microsoft.com/ko-kr/library/ms235636.aspx](https://msdn.microsoft.com/ko-kr/library/ms235636.aspx)

## NHN Cloud Serviceの使用

* [NHN Cloud Log & Crash](./log-collector-windows)使用ガイド
