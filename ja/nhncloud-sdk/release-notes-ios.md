<!-- pre-align:aligned sig=58f2c1b24700 -->

## NHN Cloud > User Guide for SDK > Release Notes > iOS

<a id="90-2025-04-29"></a>

## 1.9.0 (2025. 04. 29.)
<a id="nhn-cloud-push"></a>

### NHN Cloud Push
<a id="added-features"></a>

#### 機能追加 
* Notification Hubサポート 
    * NHNCloudPush SDKでNotification Hubを利用できます。
    * NHNCloudPushConfigurationのserviceTypeプロパティにNHNCloudPushServiceTypeNotificationHub値を設定して使用可能です。

<a id="86-2024-11-15"></a>

## 1.8.6 (2024. 11. 15.)
<a id="nhn-cloud-push-2"></a>

### NHN Cloud Push
<a id="improved"></a>

#### 改善事項
* DeviceIDを設定できるAPIを追加 

<a id="85-2024-10-08"></a>

## 1.8.5 (2024. 10. 08.)
<a id="nhn-cloud-iap"></a>

### NHN Cloud IAP
<a id="improved-2"></a>

#### 改善事項
* 決済詳細情報送信機能の改善

<a id="84-2024-09-11"></a>

## 1.8.4 (2024. 09. 11.)
<a id="nhn-cloud-push-3"></a>

### NHN Cloud Push
<a id="improved-3"></a>

#### 改善事項
* Notification重複受信問題の改善(iOS 18 Beta)
    * iOS 18でアプリケーションがForeground状態の時にNotificationが重複して受信されないようにします(OSバグ)。

<a id="83-2024-07-23"></a>

## 1.8.3 (2024. 07. 23.)
<a id="common"></a>

### 共通
<a id="improved-4"></a>

#### 改善事項
* 安定性改善

<a id="82-2024-06-25"></a>

## 1.8.2 (2024. 06. 25.)
<a id="common-2"></a>

### 共通
<a id="improved-5"></a>

#### 改善事項
* 安定性改善

<a id="81-2024-02-27"></a>

## 1.8.1 (2024. 02. 27.)
<a id="common-3"></a>

### 共通
<a id="improved-6"></a>

#### 改善事項
* Privacy manifest適用 

<a id="nhn-cloud-push-4"></a>

### NHN Cloud Push
<a id="improved-7"></a>

#### 改善事項
* 特定環境でメッセージクリックアクションがすぐに動作しない問題を修正   

<a id="80-2024-01-23"></a>

## 1.8.0 (2024. 01. 23.)
<a id="nhn-cloud-iap-2"></a>

### NHN Cloud IAP
<a id="improved-8"></a>

#### 改善事項
* 決済検証方式の改善
    * 新規SDKでも(旧)領収書検証を使用できるように改善
        * [(新)領収書検証 + Notification V2](/Mobile%20Service/IAP/ja/console-apple-guide/#notification-v2)
        * [(旧)領収書検証 + Notification V1 (Deprecated)](/Mobile%20Service/IAP/ja/console-apple-guide/#notification-v1-deprecated)

<a id="71-2023-12-19"></a>

## 1.7.1 (2023. 12. 19.)
<a id="common-4"></a>

### 共通
<a id="improved-9"></a>

#### 改善事項
* 署名適用
    * 配布されるバイナリに`NHN Cloud Corp.`署名が適用されました。

<a id="logger"></a>

### Logger 
<a id="improved-10"></a>

#### 改善事項
* Instance LoggerのNetworkInsight安定性の改善 

<a id="symboluploaderv004"></a>

### SymbolUploader(v0.0.4)
<a id="improved-11"></a>

#### 改善事項
* 安定性改善

<a id="70-2023-11-14"></a>

## 1.7.0 (2023. 11. 14.)
<a id="common-5"></a>

### 共通
<a id="improved-12"></a>

#### 改善事項
* 最小サポートバージョンの引き上げ
    * 9.0 > 11.0
* 未サポートアーキテクチャのサポート終了
    *  i386, armv7s, armv7

<a id="nhn-cloud-iap-3"></a>

### NHN Cloud IAP
<a id="improved-13"></a>

#### 改善事項
* 決済検証方法の変更 - [(新)領収書検証 + Notification V2](/Mobile%20Service/IAP/ja/console-apple-guide/#notification-v2)

<a id="62-2023-08-29"></a>

## 1.6.2 (2023. 08. 29.)
<a id="common-6"></a>

### 共通
<a id="improved-14"></a>

#### 改善事項
* CountryCode取得に失敗する問題を修正

<a id="nhn-cloud-ocr"></a>

### NHN Cloud OCR
<a id="added-features-2"></a>

#### 機能追加
* クレジットカード/身分証認識結果データに認識領域を追加

<a id="61-2023-07-25"></a>

## 1.6.1 (2023. 07. 25.)
<a id="nhn-cloud-iap-4"></a>

### NHN Cloud IAP
<a id="improved-15"></a>

#### 改善事項
* 決済詳細情報送信機能の改善

<a id="60-2023-07-11"></a>

## 1.6.0 (2023. 07. 11.)
<a id="nhn-cloud-ocr-2"></a>

### NHN Cloud OCR
<a id="added-features-3"></a>

#### 機能追加
* OCR(ID Card Recognizer)追加

<a id="50-2023-06-27"></a>

## 1.5.0 (2023. 06. 27.)
<a id="nhn-cloud-push-5"></a>

### NHN Cloud Push
<a id="improved-16"></a>

#### 改善事項
* トークン登録機能の改善
    * アプリの通知権限とは関係なくトークンを登録できるオプションを提供します。

<a id="symboluploaderv003"></a>

#### SymbolUploader(v0.0.3)
* 安定性の改善

<a id="40-2023-05-30"></a>

## 1.4.0 (2023. 05. 30.)
<a id="common-7"></a>

### 共通
<a id="improved-17"></a>

#### 改善事項
* SPM(swift package manager)配布方式を追加

<a id="nhn-cloud-iap-5"></a>

### NHN Cloud IAP
<a id="added-featrues"></a>

#### 機能追加
* 決済詳細情報送信機能を追加 
    * IAPコンソールのTransactionタブで決済詳細情報を照会できます。

<a id="symboluploaderv002"></a>

#### SymbolUploader(v0.0.2)
* run script改善 
    * Cocoapods, SPM対応追加
    
<a id="31-2023-05-19---hotfix"></a>

## 1.3.1 (2023. 05. 19.) - Hotfix
<a id="nhn-cloud-push-6"></a>

### NHN Cloud Push
<a id="improved-18"></a>

#### 改善事項
* トークン登録機能改善
    * トークン登録時にアプリの通知設定が無効になっている場合、再度`NHNCloudPushErrorPermissionDenied`を返します。

<a id="30-2023-02-28"></a>

## 1.3.0 (2023. 02. 28.)
<a id="common-8"></a>

### 共通
<a id="improved-19"></a>

#### 改善事項
* 安定性改善

<a id="21-2023-01-31"></a>

## 1.2.1 (2023. 01. 31.)
<a id="nhn-cloud-push-7"></a>

### NHN Cloud Push
<a id="improved-20"></a>

#### 改善事項
* トークン登録機能の改善

<a id="nhn-cloud-ocr-3"></a>

### NHN Cloud OCR
<a id="improved-21"></a>

#### 改善事項
* クレジットカード認識性能の改善
* 安定性の改善

<a id="20-2022-11-29"></a>

## 1.2.0 (2022. 11. 29.)
<a id="nhn-cloud-logger"></a>

### NHN Cloud Logger
<a id="added-features-4"></a>

#### 機能追加
* 公共機関用Loggerをサポート

<a id="nhn-cloud-push-8"></a>

### NHN Cloud Push
<a id="improved-22"></a>

#### 改善事項
* プッシュイベント転送の改善

<a id="nhn-cloud-ocr-4"></a>

### NHN Cloud OCR
<a id="improved-23"></a>

#### 改善事項
* UI改善

<a id="10-2022-10-25"></a>

## 1.1.0 (2022. 10. 25.)
<a id="common-9"></a>

### 共通
<a id="improvements"></a>

#### 改善事項
* 安定性改善

<a id="nhn-cloud-iap-6"></a>

### NHN Cloud IAP
<a id="added-features-5"></a>

#### 機能追加
* [すべてのストア]有効購読照会および未消費決済履歴照会APIの追加

<a id="nhn-cloud-ocr-5"></a>

### NHN Cloud OCR
<a id="added-features-6"></a>

#### 機能追加
* OCR(Credit Card Recognizer)追加

<a id="00-2022-07-12"></a>

## 1.0.0 (2022. 07. 12.)
<a id="common-10"></a>

### 共通
<a id="improvements-2"></a>

#### 改善事項
* 安定性改善
* モジュール名NHN Cloud SDKに変更
    * TOAST SDKはDeprecatedになりました。

<a id="300-2022-03-29"></a>

## 0.30.0 (2022. 03. 29.)
<a id="toast-iap"></a>

### TOAST IAP
<a id="added-features-7"></a>

#### 機能追加
* ToastPurchaseResultにサンドボックス決済かどうかを追加(sandboxPayment)

<a id="292-2021-11-23"></a>

## 0.29.2 (2021. 11. 23.)
<a id="toast-push"></a>

### TOAST Push
<a id="improvements-3"></a>

#### 改善事項
* 安全性の改善

<a id="291-2021-10-26"></a>

## 0.29.1 (2021. 10. 26.)
<a id="toast-iap-2"></a>

### TOAST IAP
<a id="improvements-4"></a>

#### 改善事項
* 安全性の改善

<a id="290-2021-07-06"></a>

## 0.29.0 (2021. 07. 06.)
<a id="common-11"></a>

### 共通
<a id="improvements-5"></a>

#### 改善事項
* 安全性の改善

<a id="toast-iap-3"></a>

### TOAST IAP
<a id="added-features-8"></a>

#### 機能追加
* 月決済限度機能の追加

<a id="280-2021-05-25"></a>

## 0.28.0 (2021. 05. 25.)
<a id="common-12"></a>

### 共通
<a id="improvements-6"></a>

#### 改善事項
* xcframework追加
    * arm Simulatorサポートの追加

<a id="toast-logger"></a>

### TOAST Logger
<a id="crashreporter-buildinfo-20210525"></a>

#### CrashReporter (BuildInfo 20210525)
* アーキテクチャ分類方式の改善
    * iOS14 Core Libraryがシンボリケーションされない問題を改善

<a id="272-2021-03-23"></a>

## 0.27.2 (2021. 03. 23.)
<a id="common-13"></a>

### 共通
<a id="improvements-7"></a>

#### 改善事項
* 安全性の改善

<a id="toast-logger-2"></a>

### TOAST Logger
<a id="symboluploader-v001"></a>

#### SymbolUploader (v0.0.1)
* SymbolUploader追加

<a id="271-2020-11-24"></a>

## 0.27.1 (2020. 11. 24.) 
<a id="toast-iap-4"></a>

### TOAST IAP 
<a id="improvements-8"></a>

#### 改善事項 
* サブスクリプションプロダクトの再購入エラー修正 (iOS 14 ) 
- Appstoreからプロダクト情報を得られなかった場合、ToastProductsResponseがnilを返すように変更 
 
<a id="toast-push-2"></a>

### TOAST Push 
<a id="improvements-9"></a>

#### 改善事項 
* トークン解除リクエスト時に、登録されたトークンがない場合、Callbackが発生しない問題の改善 
 
<a id="270-2020-09-11"></a>

## 0.27.0 (2020. 09. 11.) 
<a id="toast-iap-5"></a>

### TOAST IAP 
<a id="added-features-9"></a>

#### 機能追加 
* ToastProductにローカライズされたプロダクト情報の追加 (localizedTitle、 localizedDescription) 
 
<a id="improvements-10"></a>

#### 機能改善 
* iOS 14 beta変更事項に対応  
    * 決済失敗のDelegateが受信できない問題の改善 
     
<a id="toast-push-3"></a>

### TOAST Push 
<a id="improvements-11"></a>

#### 改善事項 
* 安全性の改善 
     
<a id="260-2020-07-28"></a>

## 0.26.0 (2020. 07. 28.) 
<a id="toast-push-4"></a>

### TOAST Push 
<a id="added-features-10"></a>

#### 機能追加 
* ユーザータグ機能のサポート 
 
<a id="251-2020-07-03"></a>

## 0.25.1 (2020. 07. 03.) 
<a id="toast-logger-3"></a>

### TOAST Logger  
<a id="improvements-12"></a>

#### 改善事項 
* 安全性の改善 
 
<a id="toast-push-5"></a>

### TOAST Push 
<a id="improvements-13"></a>

#### 改善事項 
* 安全性の改善 
 
<a id="250-2020-06-23"></a>

## 0.25.0 (2020. 06. 23.) 
<a id="common-14"></a>

### 共通 
<a id="improvements-14"></a>

#### 改善事項 
* 安全性の改善 
 
<a id="toast-push-6"></a>

### TOAST Push 
<a id="improvements-15"></a>

#### 改善事項 
* 通知オプション設定のインターフェイスを分離 
 
<a id="241-2020-05-26"></a>

## 0.24.1 (2020. 05. 26.) 
<a id="toast-push-7"></a>

### TOAST Push 
<a id="improvements-16"></a>

#### 機能改善 
* トークン登録の機能改善 
 
<a id="240-2020-04-28"></a>

## 0.24.0 (2020. 04. 28.) 
<a id="common-15"></a>

### 共通 
* TOAST SDKサポートバージョンの最小バージョンを変更(iOS 8.0 -> iOS 9.0) 
* 安全性の改善 
 
<a id="toast-iap-6"></a>

### TOAST IAP  
<a id="added-features-11"></a>

#### 追加事項 
* プロモーション決済の実行するか選択できるOptional Delegateを追加 
 
<a id="toast-push-8"></a>

### TOAST Push 
<a id="improvements-17"></a>

#### 改善事項  
* 安全性の改善 
 
<a id="230-2020-03-24"></a>

## 0.23.0 (2020. 03. 24.) 
<a id="toast-logger-4"></a>

### TOAST Logger  
<a id="improvements-18"></a>

#### 改善事項 
* CrashReport CallStackに誤った文字列が含まれて可能性がある問題を修正 
 
<a id="toast-push-9"></a>

### TOAST Push 
<a id="added-features-12"></a>

#### 追加事項 
* 通知オプション設定の機能追加 
    * 初期化時にフォアグラウンドで通知を表示するか、バッジアイコンの表示するか、通知音を使用するかの設定が可能 
     
<a id="221-2020-02-25"></a>

## 0.22.1 (2020. 02. 25.) 
<a id="toast-push-10"></a>

### TOAST Push 
<a id="improvements-19"></a>

#### 改善事項 
* トークン登録の機能改善 
    * 初回トークン登録時にユーザーIDが設定されていない場合は、デバイス識別子を使用して登録します。 
    * トークンに登録した後、ユーザーIDを設定、または変更すると、トークン情報を更新します。 
     
<a id="220-2020-02-11"></a>

## 0.22.0 (2020. 02. 11.) 
<a id="toast-iap-7"></a>

### TOAST IAP 
<a id="improvements-20"></a>

#### 改善事項 
* 安全性の改善 
 
 
<a id="210-2019-12-24"></a>

## 0.21.0 (2019. 12. 24.) 
<a id="toast-logger-5"></a>

### TOAST Logger 
<a id="improvements-21"></a>

#### 改善事項 
* Crash発生の位置情報の分類方式を改善するため、データを追加 
 
<a id="toast-iap-8"></a>

### TOAST IAP 
<a id="improvements-22"></a>

#### 改善事項 
* APIセキュリティ機能の追加
* 安全性の改善 
* Swiftインターフェイス追加定義 
 
<a id="201-2019-12-04"></a>

## 0.20.1 (2019. 12. 04.) 
 
<a id="common-16"></a>

### 共通 
 
<a id="improvements-23"></a>

#### 改善事項 
 
* 初期化ロジックの改善 
 
<a id="200-2019-11-26"></a>

## 0.20.0 (2019. 11. 26.) 
 
<a id="toast-push-11"></a>

### TOAST Push 
 
<a id="improvements-24"></a>

#### 改善事項 
 
* トークン登録/削除結果通知を、コールバック構造に変更、Delegate削除 
* 以前登録した同意情報でトークンを再登録する機能追加 
* VoIP機能をサブモジュールに分離 
* Swiftインターフェイスを追加定義 
 
<a id="193-2019-10-29"></a>

## 0.19.3 (2019. 10. 29.) 
 
<a id="common-17"></a>

### 共通 
 
<a id="bug-fixes"></a>

#### バグ修正 
 
* Xcode 11未満でリンカーエラー発生の問題を修正 
 
<a id="192-2019-10-25"></a>

## 0.19.2 (2019. 10. 25.) 
 
<a id="toast-push-12"></a>

### TOAST Push 
 
<a id="improvements-25"></a>

#### 改善事項 
 
* (旧) TCPushSDKマイグレーションのサポート 
 
<a id="191-2019-10-18"></a>

## 0.19.1 (2019. 10. 18.) 
 
<a id="toast-push-13"></a>

### TOAST Push 
 
<a id="improvements-26"></a>

#### 改善事項 
 
* トークン登録の機能改善 
 
<a id="190-2019-10-15"></a>

## 0.19.0 (2019. 10. 15.) 
 
<a id="toast-push-14"></a>

### TOAST Push 
 
<a id="added-features-13"></a>

#### 追加事項 
 
* 通知実行に対する通知の機能を追加 
 
<a id="180-2019-10-01"></a>

## 0.18.0 (2019. 10. 01.) 
 
<a id="common-18"></a>

### 共通 
 
<a id="improvements-27"></a>

#### 改善事項 
 
* iOS 13 / Xcode 11対応
 
<a id="toast-iap-9"></a>

### TOAST IAP 
 
<a id="added-features-14"></a>

#### 追加事項 
 
* 購入リクエスト時にユーザーデータ設定をの機能を追加 
 
<a id="improvements-28"></a>

#### 改善事項 
 
* 復元機能を実行した後、復元された決済の項目のみ返すよう変更 
 
<a id="toast-push-15"></a>

### TOAST Push 
 
<a id="improvements-29"></a>

#### 改善事項 
 
* ToastPushConfigurationオブジェクトのNullabilityプロパティの変更 
* リッチメッセージ作成ロジックの改善により、ToastPushMediaオブジェクトのsourceType、extensionのプロパティを削除 
* リッチメッセージのソース情報にハングルURLも対応 
 
<a id="bug-fixes-2"></a>

#### バグ修正 
 
* コンソール設定で、メッセージ受信/確認の機能が未使用と設定されている場合、リッチメッセージが正常に表示されなかったバグを修正 
* iOS 13以上の環境でデバイストークンを獲得できないバグを修正 
 
<a id="170-2019-08-27"></a>

## 0.17.0 (2019. 08. 27.) 
 
<a id="common-19"></a>

### 共通 
 
<a id="improvements-30"></a>

#### 改善事項  
* 安全性の改善 
 
<a id="toast-iap-10"></a>

### TOAST IAP 
 
<a id="added-features-15"></a>

#### 追加事項 
 
* 自動更新型の消費性サブスクリプションプロダクトの追加 
 
<a id="improvements-31"></a>

#### 改善事項 
 
* プロダクト一覧を照会時、invalidProductsに有効な商品が返されていた問題を修正 
 
<a id="toast-push-16"></a>

### TOAST Push 
 
<a id="improvements-32"></a>

#### 改善事項 
 
* プッシュメッセージに通知音を設定せず、送信時のデフォルト通知音が設定されるよう改善 
 
<a id="161-2019-07-29"></a>

## 0.16.1 (2019. 07. 29.) 
 
<a id="common-20"></a>

### 共通 
 
<a id="improvements-33"></a>

#### 改善事項  
* 国名コードを取得できない問題を修正 
 
<a id="160-2019-07-23"></a>

## 0.16.0 (2019. 07. 23.) 
 
<a id="toast-logger-6"></a>

### TOAST Logger  
 
<a id="improvements-34"></a>

#### 改善事項  
* シンボルが存在するバイナリーの場合、CrashReport CallStackにシンボル文字が含まれるよう改善 
* CrashReport Reasonが出力されない問題の修正 
 
<a id="toast-iap-11"></a>

### TOAST IAP 
 
<a id="improvements-35"></a>

#### 改善事項 
 
* 決済成功状態から以前の決済状態に変更される問題を修正 
* アプリ内での購入が許可されていない状態で決済がリクエストされていた問題を修正 
* プロモーション決済の改善 
 
<a id="toast-push-17"></a>

### TOAST Push 
 
<a id="improvements-36"></a>

#### 改善事項 
 
* メッセージ/アクションの受信delegate変更 
 
<a id="150-2019-06-25"></a>

## 0.15.0 (2019. 06. 25.) 
 
<a id="toast-iap-12"></a>

### TOAST IAP 
 
<a id="improvements-37"></a>

#### 改善事項 
 
* 新規決済、プロモーション決済、未消費内訳の詳細をリクエストすると、未完了決済のアイテムを再処理するロジックを追加 
 
<a id="toast-push-18"></a>

### TOAST Push 
 
<a id="added-features-16"></a>

#### 追加事項 
 
* 初期化すると、国、言語コード設定を行う機能を追加 
* トークン情報のアップデート機能を追加 
* 通知オプション設定機能を追加 
 
<a id="improvements-38"></a>

#### 改善事項 
 
* 通知オプションの基本設定の変更 
    * アプリ実行中は通知を表示しないよう変更 
        * 以前と同じ動作をするためには[こちら](./push-ios/#_6)を確認してください。 
         
<a id="141-2019-05-16"></a>

## 0.14.1 (2019. 05. 16.) 
 
<a id="toast-iap-13"></a>

### TOAST IAP 
 
<a id="improvements-39"></a>

#### 改善事項 
 
* 処理中の再処理決済件と同一の商品購買時に保有した商品に処理される現象改善 
 
<a id="toast-push-19"></a>

### TOAST Push 
 
<a id="improvements-40"></a>

#### 改善事項 
 
* 端末機カレンダーの設定によって、地表イベントの発生時間が誤って収集されていたバグ修正 
 
<a id="140-2019-05-14"></a>

## 0.14.0 (2019. 05. 14.) 
 
<a id="common-21"></a>

### 共通 
 
<a id="improvements-41"></a>

#### 改善事項 
 
* Networkエラーコードの統合 
* 安全性改善 
 
<a id="toast-iap-14"></a>

### TOAST IAP 
 
<a id="improvements-42"></a>

#### 改善事項 
 
* 購買復元機能の改善 
    * AppStore購買内訳をベースに漏れた決済の復元機能を追加  
    * 復元失敗エラーコード追加 
* 購入結果クラスへのストア要求(プロモーション)フラグの追加 
* 再処理対象の拡大 
* 決済の流れ改善 
 
<a id="toast-push-20"></a>

### TOAST Push 
 
<a id="improvements-43"></a>

#### 改善事項 
 
* 安全性改善 
* メッセージ受信Delegate で配信されるpayload 情報にメッセージID 情報追加 
* 広告性メッセージ受信同意、夜間広告性メッセージ受信同意が不要なVoIPの場合、受信同意可否に関わらずメッセージ受信 
 
<a id="130-2019-03-26"></a>

## 0.13.0 (2019. 03. 26.) 
 
<a id="common-22"></a>

### 共通 
 
<a id="improvements-44"></a>

#### 改善事項 
 
* Public Classの使用性改善 
  * Description追加 
  * Nullability、 NSCoding、 NSCopyingの支援 
 
<a id="toast-core"></a>

### TOAST Core 
 
<a id="improvements-45"></a>

#### 改善事項 
 
* 内部例外処理追加 
 
<a id="toast-logger-7"></a>

### TOAST Logger 
 
<a id="added-features-17"></a>

#### 追加事項 
 
* arm64eアーキテクチャを使用する機器のCrash分析支援 
* PLCrashReporter Dependency 変更 
 
<a id="improvements-46"></a>

#### 改善事項 
 
* Configuration Interface 変更 
  * Deprecate 
    * configurationWithProjectKey 
  * Add 
    * configurationWithAppKey 
 
* UserIDの設定時点によって転送するLogのUserIDが更新されないかもしれない問題修正 
 
<a id="toast-iap-15"></a>

### TOAST IAP 
 
<a id="improvements-47"></a>

#### 改善事項 
 
* 内部例外処理追加 
 
<a id="toast-push-21"></a>

### TOAST Push 
 
<a id="added-features-18"></a>

#### 追加事項 
 
* unregisterToken API の追加 
 
<a id="124-2019-03-19"></a>

## 0.12.4 (2019. 03. 19.) 
 
<a id="toast-core-2"></a>

### TOAST Core 
 
<a id="improvements-48"></a>

#### 改善事項 
 
* 例外を追加する 
 
<a id="123-2019-02-26"></a>

## 0.12.3 (2019. 02. 26.) 
 
<a id="toast-core-common"></a>

### TOAST Core、 Common 
 
<a id="improvements-49"></a>

#### 改善事項 
 
* util関数に例外を追加 
 
<a id="toast-iap-16"></a>

### TOAST IAP 
 
<a id="improvements-50"></a>

#### 改善事項 
 
* 商品情報のキャッシングを追加する 
* 例外を追加する 
 
<a id="122-2019-02-08---hotfix"></a>

## 0.12.2 (2019. 02. 08.) - Hotfix 
 
<a id="toast-core-3"></a>

### TOAST Core 
 
<a id="improvements-51"></a>

#### 改善事項 
 
* ToastTransferで断続的に発生していたCrashを防止するためのコードを追加 
 
<a id="121-2019-01-08"></a>

## 0.12.1 (2019. 01. 08.) 
 
<a id="toast-iap-17"></a>

### TOAST IAP 
 
<a id="improvements-52"></a>

#### 改善事項 
 
* 特定状況で決済状態がVerifyEndの決済の再処理が動作しない問題の修正 
 
<a id="120-2018-12-27"></a>

## 0.12.0 (2018. 12. 27.) 
 
<a id="toast-core-4"></a>

### TOAST CORE 
 
<a id="improvements-53"></a>

#### 改善事項 
 
* ToastTransferで断続的に発生していたCrashを防止するためのコードを追加 
 
<a id="toast-push-22"></a>

### TOAST Push 
 
<a id="added-features-19"></a>

#### 追加事項 
 
* 新規機能追加 
 
<a id="toast-iap-18"></a>

### TOAST IAP 
 
<a id="improvements-54"></a>

#### 改善事項 
 
* Appleで再処理するTransactionの処理ができるようにUserID Checkロジックの例外処理を追加 
* ToastOperationで断続的に発生していたCrashを防止するためのコードを追加  
 
 
<a id="111-2018-12-04"></a>

## 0.11.1 (2018. 12. 04.) 
 
<a id="toast-iap-19"></a>

### TOAST IAP 
 
<a id="added-features-20"></a>

#### 追加事項 
 
* 新規機能追加 
 
 
<a id="110-2018-11-20"></a>

## 0.11.0 (2018. 11. 20.) 
 
<a id="toast-log-crash"></a>

### TOAST Log & Crash 
 
<a id="added-features-21"></a>

#### 追加事項 
 
* Network Insights機能追加 
 
 
<a id="90-2018-09-04"></a>

## 0.9.0 (2018. 09. 04.) 
 
<a id="toast-log-crash-2"></a>

### TOAST Log & Crash 
 
<a id="added-features-22"></a>

#### 追加事項 
 
* 新規機能追加 
