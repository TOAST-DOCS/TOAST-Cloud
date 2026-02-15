## NHN Cloud > SDK使用ガイド > 開始する > Windows C++ 

## サポート環境
* Windows 7
* Windows 8
* Windows 10
* Windows 11

## NHN Cloud SDKの構成

Windows C++用NHN Cloud SDKの構成は次のとおりです。 

| Directory | Description | 
|---|---|
| dump_syms.exe| PDB(*.pdb)ファイルからクラッシュ分析用シンボル(*.sym)を抽出 |
| include| C++ヘッダファイル |
| x86| C++ Windows 32bitライブラリ |
| x64| C++ Windows 64bitライブラリ |
| nhncloudsdk_example | サンプルプロジェクト |

## NHN Cloud SDKをVisual Studioプロジェクトに適用する 

NHN Cloudの[Downloads](../../../Download/#toast-sdk)ページでNHN Cloud Windows C++ SDKをダウンロードします。 

### ライブラリを含める 

1. メニューバーの**Project**タブで**Properties**を選択します。 
2. **C/C++ > General > Additional Include Directories**でSdkのヘッダファイルパスを設定します。 
3. **Linker > General > Additional Library Directories**でビルド環境(Debug/Release)とTarget Machine(x86、x64)に応じてライブラリを含めます。 
4. **Linker > Input > Additional Dependencies**でビルド環境(Debug/Release)とTarget Machine(x86、x64)に応じて追加するlibを入力します。 
[参考] [https://msdn.microsoft.com/ko-kr/library/ms235636.aspx](https://msdn.microsoft.com/ko-kr/library/ms235636.aspx)

### nhncloudsdk_exmple
* Visual Studio 2019で作成したサンプルプロジェクトです。

## NHN Cloud Log & Crash Search Service使用

* [Log & Crash](./log-collector-windows)使用ガイド
