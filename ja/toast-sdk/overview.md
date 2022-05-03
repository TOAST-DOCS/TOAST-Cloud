## NHN Cloud > SDK使用ガイド > 概要 
 
NHN Cloud SDKは、[NHN Cloud](https://toast.com/)の多様なサービスライブラリ(SDK)を簡単に適用できるようにした統合ライブラリ(SDK)です。 NHN Cloudサービスを使用してアプリケーションを開発する時、個別サービスのライブラリをそれぞれ適用する煩わしさがなく、一度に適用できます。 
複数のサービスの統合開発環境を提供しますが、希望する機能だけを選択できるため、使用スペースを節約できます。NHN Cloud SDKは、使用するプログラミング言語とプラットフォームに最適化されたライブラリで、慣れた開発環境を提供します。 
 
> 現在はiOS、Android、Unity3D、Windows C++の開発環境のみ提供します。今後さらに多様なプログラミング言語とプラットフォームをサポートする予定です。 
 
## サポートするサービス 
 
NHN Cloud SDKは、次のようなサービスを提供します。 
 
- [Log & Crash Search](https://toast.com/service/analytics/log_crash_search) 
- [IAP](https://www.toast.com/service/mobile-service/iap) 
- [Push](https://www.toast.com/service/notification/push) 
 
> 個別SDKを提供するサービスは、今後NHN Cloud SDKを通して開発できるようにサポートする予定です。 
 
## 特徴 
 
- AndroidはGradle、iOSはCocoaPodsを活用したビルド環境をサポートします。 
- Unity Pluginを提供します。 
- 使用するには、サービス全体または一部サービスを選択して適用できます。 
- 個別サービスで独自に提供していたSDKの不便な点を改善しました。 
 
## NHN Cloud SDKを開始する 
 
### Android 
 
NHN Cloud Android SDKは、**mavenCentral**で配布され、簡単なGradle設定だけで使用できます。 
 
- [Androidで開始する](./getting-started-android) 
 
### iOS 
 
NHN Cloud iOS SDKは、**Github**で配布され、簡単な**CocoaPods**, **Carthage**設定だけで使用できます。 
 
 
- [iOSで開始する](./getting-started-ios) 
 
### Unity 
 
NHN Cloud Unity SDKは、Android、iOSプラットフォームをサポートします。 
 
- [Unityで開始する](./getting-started-unity) 
 
### Windows C++ 
 
NHN Cloud Windows C++ SDKは、Windows 7、10(32/64bit)環境をサポートします。 
 
- [Windows C++で開始する](./getting-started-windows) 
 
## Log & Crash 
 
Log & Crash Search収集サーバーにログを送信する機能を提供します。収集されたログは、NHN Cloudコンソールの**Log & Crash Search**メニューをクリックして確認できます。 
 
- [Log & Crash Searchサービス確認](https://toast.com/service/analytics/log_crash_search) 
 
### 主な機能 
 
| 機能   | 説明                                    | 
| ------- | ---------------------------------------- | 
| ログ送信 | ログを収集サーバーに送信します。                        | 
| 照会および検索 | NHN Cloudコンソールでログを照会したり、条件に合ったログを検索できます。 | 
| クラッシュレポート | 予期せぬクラッシュが発生した場合、Log & Crash Search収集サーバーにクラッシュログを送信します。 | 
 
### 使用ガイド 
 
- [Log & Crash > Android](./log-collector-android)使用ガイド 
- [Log & Crash > iOS](./log-collector-ios)使用ガイド 
- [Log & Crash > Unity](./log-collector-unity)使用ガイド 
- [Log & Crash > Windows C++](./log-collector-windows)使用ガイド 
 
## NHN Cloud IAP 
 
モバイル統合アプリ内決済サービスを提供します。 
 
- [IAPサービスを確認する](https://www.toast.com/service/mobile-service/iap) 
 
### 主な機能 
 
| 機能 | 説明 | 
| -- | -- | 
| 一般決済 | 一回性商品を販売できます。 | 
| 購読決済 | 購読商品を販売できます。 | 
| 再処理 | 不安定な形で終了した購入プロセスを復元できます。 | 
 
### 使用ガイド 
 
- [IAP > Android](./iap-android)使用ガイド 
- [IAP > iOS](./iap-ios)使用ガイド 
 
## NHN Cloud Push 
 
NHN Cloud Push SDKを使用して、Pushサービスを簡単に適用できます。 
コンソールから通知メッセージを安定的に送信し、送信結果を確認できます。 
 
### 使用ガイド 
 
- [Push > Android](./push-android)使用ガイド 
- [Push > iOS](./push-ios)使用ガイド 
