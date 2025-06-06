## NHN Cloud > User Guide for SDK > Release Notes > iOS

## 1.9.0 (2025. 04. 29.)
### NHN Cloud Push
#### 機能追加 
* Notification Hubサポート 
    * NHNCloudPush SDKでNotification Hubを利用できます。
    * NHNCloudPushConfigurationのserviceTypeプロパティにNHNCloudPushServiceTypeNotificationHub値を設定して使用可能です。

## 1.8.6 (2024. 11. 15.)
### NHN Cloud Push
#### 改善事項
* DeviceIDを設定できるAPIを追加 

## 1.8.5 (2024. 10. 08.)
### NHN Cloud IAP
#### 改善事項
* 決済詳細情報送信機能の改善

## 1.8.4 (2024. 09. 11.)
### NHN Cloud Push
#### 改善事項
* Notification重複受信問題の改善(iOS 18 Beta)
    * iOS 18でアプリケーションがForeground状態の時にNotificationが重複して受信されないようにします(OSバグ)。

## 1.8.3 (2024. 07. 23.)
### 共通
#### 改善事項
* 安定性改善

## 1.8.2 (2024. 06. 25.)
### 共通
#### 改善事項
* 安定性改善

## 1.8.1 (2024. 02. 27.)
### 共通
#### 改善事項
* Privacy manifest適用 

### NHN Cloud Push
#### 改善事項
* 特定環境でメッセージクリックアクションがすぐに動作しない問題を修正   

## 1.8.0 (2024. 01. 23.)
### NHN Cloud IAP
#### 改善事項
* 決済検証方式の改善
    * 新規SDKでも(旧)領収書検証を使用できるように改善
        * [(新)領収書検証 + Notification V2](/Mobile%20Service/IAP/ja/console-apple-guide/#notification-v2)
        * [(旧)領収書検証 + Notification V1 (Deprecated)](/Mobile%20Service/IAP/ja/console-apple-guide/#notification-v1-deprecated)

## 1.7.1 (2023. 12. 19.)
### 共通
#### 改善事項
* 署名適用
    * 配布されるバイナリに`NHN Cloud Corp.`署名が適用されました。

### Logger 
#### 改善事項
* Instance LoggerのNetworkInsight安定性の改善 

### SymbolUploader(v0.0.4)
#### 改善事項
* 安定性改善

## 1.7.0 (2023. 11. 14.)
### 共通
#### 改善事項
* 最小サポートバージョンの引き上げ
    * 9.0 > 11.0
* 未サポートアーキテクチャのサポート終了
    *  i386, armv7s, armv7

### NHN Cloud IAP
#### 改善事項
* 決済検証方法の変更 - [(新)領収書検証 + Notification V2](/Mobile%20Service/IAP/ja/console-apple-guide/#notification-v2)

## 1.6.2 (2023. 08. 29.)
### 共通
#### 改善事項
* CountryCode取得に失敗する問題を修正

### NHN Cloud OCR
#### 機能追加
* クレジットカード/身分証認識結果データに認識領域を追加

## 1.6.1 (2023. 07. 25.)
### NHN Cloud IAP
#### 改善事項
* 決済詳細情報送信機能の改善

## 1.6.0 (2023. 07. 11.)
### NHN Cloud OCR
#### 機能追加
* OCR(ID Card Recognizer)追加

## 1.5.0 (2023. 06. 27.)
### NHN Cloud Push
#### 改善事項
* トークン登録機能の改善
    * アプリの通知権限とは関係なくトークンを登録できるオプションを提供します。

#### SymbolUploader(v0.0.3)
* 安定性の改善

## 1.4.0 (2023. 05. 30.)
### 共通
#### 改善事項
* SPM(swift package manager)配布方式を追加

### NHN Cloud IAP
#### 機能追加
* 決済詳細情報送信機能を追加 
    * IAPコンソールのTransactionタブで決済詳細情報を照会できます。

#### SymbolUploader(v0.0.2)
* run script改善 
    * Cocoapods, SPM対応追加
    
## 1.3.1 (2023. 05. 19.) - Hotfix
### NHN Cloud Push
#### 改善事項
* トークン登録機能改善
    * トークン登録時にアプリの通知設定が無効になっている場合、再度`NHNCloudPushErrorPermissionDenied`を返します。

## 1.3.0 (2023. 02. 28.)
### 共通
#### 改善事項
* 安定性改善

## 1.2.1 (2023. 01. 31.)
### NHN Cloud Push
#### 改善事項
* トークン登録機能の改善

### NHN Cloud OCR
#### 改善事項
* クレジットカード認識性能の改善
* 安定性の改善

## 1.2.0 (2022. 11. 29.)
### NHN Cloud Logger
#### 機能追加
* 公共機関用Loggerをサポート

### NHN Cloud Push
#### 改善事項
* プッシュイベント転送の改善

### NHN Cloud OCR
#### 改善事項
* UI改善

## 1.1.0 (2022. 10. 25.)
### 共通
#### 改善事項
* 安定性改善

### NHN Cloud IAP
#### 機能追加
* [すべてのストア]有効購読照会および未消費決済履歴照会APIの追加

### NHN Cloud OCR
#### 機能追加
* OCR(Credit Card Recognizer)追加

## 1.0.0 (2022. 07. 12.)
### 共通
#### 改善事項
* 安定性改善
* モジュール名NHN Cloud SDKに変更
    * TOAST SDKはDeprecatedになりました。

## 0.30.0 (2022. 03. 29.)
### TOAST IAP
#### 機能追加
* ToastPurchaseResultにサンドボックス決済かどうかを追加(sandboxPayment)

## 0.29.2 (2021. 11. 23.)
### TOAST Push
#### 改善事項
* 安全性の改善

## 0.29.1 (2021. 10. 26.)
### TOAST IAP
#### 改善事項
* 安全性の改善

## 0.29.0 (2021. 07. 06.)
### 共通
#### 改善事項
* 安全性の改善

### TOAST IAP
#### 機能追加
* 月決済限度機能の追加

## 0.28.0 (2021. 05. 25.)
### 共通
#### 改善事項
* xcframework追加
    * arm Simulatorサポートの追加

### TOAST Logger
#### CrashReporter (BuildInfo 20210525)
* アーキテクチャ分類方式の改善
    * iOS14 Core Libraryがシンボリケーションされない問題を改善

## 0.27.2 (2021. 03. 23.)
### 共通
#### 改善事項
* 安全性の改善

### TOAST Logger
#### SymbolUploader (v0.0.1)
* SymbolUploader追加

## 0.27.1 (2020. 11. 24.) 
### TOAST IAP 
#### 改善事項 
* サブスクリプションプロダクトの再購入エラー修正 (iOS 14 ) 
- Appstoreからプロダクト情報を得られなかった場合、ToastProductsResponseがnilを返すように変更 
 
### TOAST Push 
#### 改善事項 
* トークン解除リクエスト時に、登録されたトークンがない場合、Callbackが発生しない問題の改善 
 
## 0.27.0 (2020. 09. 11.) 
### TOAST IAP 
#### 機能追加 
* ToastProductにローカライズされたプロダクト情報の追加 (localizedTitle、 localizedDescription) 
 
#### 機能改善 
* iOS 14 beta変更事項に対応  
    * 決済失敗のDelegateが受信できない問題の改善 
     
### TOAST Push 
#### 改善事項 
* 安全性の改善 
     
## 0.26.0 (2020. 07. 28.) 
### TOAST Push 
#### 機能追加 
* ユーザータグ機能のサポート 
 
## 0.25.1 (2020. 07. 03.) 
### TOAST Logger  
#### 改善事項 
* 安全性の改善 
 
### TOAST Push 
#### 改善事項 
* 安全性の改善 
 
## 0.25.0 (2020. 06. 23.) 
### 共通 
#### 改善事項 
* 安全性の改善 
 
### TOAST Push 
#### 改善事項 
* 通知オプション設定のインターフェイスを分離 
 
## 0.24.1 (2020. 05. 26.) 
### TOAST Push 
#### 機能改善 
* トークン登録の機能改善 
 
## 0.24.0 (2020. 04. 28.) 
### 共通 
* TOAST SDKサポートバージョンの最小バージョンを変更(iOS 8.0 -> iOS 9.0) 
* 安全性の改善 
 
### TOAST IAP  
#### 追加事項 
* プロモーション決済の実行するか選択できるOptional Delegateを追加 
 
### TOAST Push 
#### 改善事項  
* 安全性の改善 
 
## 0.23.0 (2020. 03. 24.) 
### TOAST Logger  
#### 改善事項 
* CrashReport CallStackに誤った文字列が含まれて可能性がある問題を修正 
 
### TOAST Push 
#### 追加事項 
* 通知オプション設定の機能追加 
    * 初期化時にフォアグラウンドで通知を表示するか、バッジアイコンの表示するか、通知音を使用するかの設定が可能 
     
## 0.22.1 (2020. 02. 25.) 
### TOAST Push 
#### 改善事項 
* トークン登録の機能改善 
    * 初回トークン登録時にユーザーIDが設定されていない場合は、デバイス識別子を使用して登録します。 
    * トークンに登録した後、ユーザーIDを設定、または変更すると、トークン情報を更新します。 
     
## 0.22.0 (2020. 02. 11.) 
### TOAST IAP 
#### 改善事項 
* 安全性の改善 
 
 
## 0.21.0 (2019. 12. 24.) 
### TOAST Logger 
#### 改善事項 
* Crash発生の位置情報の分類方式を改善するため、データを追加 
 
### TOAST IAP 
#### 改善事項 
* APIセキュリティ機能の追加
* 安全性の改善 
* Swiftインターフェイス追加定義 
 
## 0.20.1 (2019. 12. 04.) 
 
### 共通 
 
#### 改善事項 
 
* 初期化ロジックの改善 
 
## 0.20.0 (2019. 11. 26.) 
 
### TOAST Push 
 
#### 改善事項 
 
* トークン登録/削除結果通知を、コールバック構造に変更、Delegate削除 
* 以前登録した同意情報でトークンを再登録する機能追加 
* VoIP機能をサブモジュールに分離 
* Swiftインターフェイスを追加定義 
 
## 0.19.3 (2019. 10. 29.) 
 
### 共通 
 
#### バグ修正 
 
* Xcode 11未満でリンカーエラー発生の問題を修正 
 
## 0.19.2 (2019. 10. 25.) 
 
### TOAST Push 
 
#### 改善事項 
 
* (旧) TCPushSDKマイグレーションのサポート 
 
## 0.19.1 (2019. 10. 18.) 
 
### TOAST Push 
 
#### 改善事項 
 
* トークン登録の機能改善 
 
## 0.19.0 (2019. 10. 15.) 
 
### TOAST Push 
 
#### 追加事項 
 
* 通知実行に対する通知の機能を追加 
 
## 0.18.0 (2019. 10. 01.) 
 
### 共通 
 
#### 改善事項 
 
* iOS 13 / Xcode 11対応
 
### TOAST IAP 
 
#### 追加事項 
 
* 購入リクエスト時にユーザーデータ設定をの機能を追加 
 
#### 改善事項 
 
* 復元機能を実行した後、復元された決済の項目のみ返すよう変更 
 
### TOAST Push 
 
#### 改善事項 
 
* ToastPushConfigurationオブジェクトのNullabilityプロパティの変更 
* リッチメッセージ作成ロジックの改善により、ToastPushMediaオブジェクトのsourceType、extensionのプロパティを削除 
* リッチメッセージのソース情報にハングルURLも対応 
 
#### バグ修正 
 
* コンソール設定で、メッセージ受信/確認の機能が未使用と設定されている場合、リッチメッセージが正常に表示されなかったバグを修正 
* iOS 13以上の環境でデバイストークンを獲得できないバグを修正 
 
## 0.17.0 (2019. 08. 27.) 
 
### 共通 
 
#### 改善事項  
* 安全性の改善 
 
### TOAST IAP 
 
#### 追加事項 
 
* 自動更新型の消費性サブスクリプションプロダクトの追加 
 
#### 改善事項 
 
* プロダクト一覧を照会時、invalidProductsに有効な商品が返されていた問題を修正 
 
### TOAST Push 
 
#### 改善事項 
 
* プッシュメッセージに通知音を設定せず、送信時のデフォルト通知音が設定されるよう改善 
 
## 0.16.1 (2019. 07. 29.) 
 
### 共通 
 
#### 改善事項  
* 国名コードを取得できない問題を修正 
 
## 0.16.0 (2019. 07. 23.) 
 
### TOAST Logger  
 
#### 改善事項  
* シンボルが存在するバイナリーの場合、CrashReport CallStackにシンボル文字が含まれるよう改善 
* CrashReport Reasonが出力されない問題の修正 
 
### TOAST IAP 
 
#### 改善事項 
 
* 決済成功状態から以前の決済状態に変更される問題を修正 
* アプリ内での購入が許可されていない状態で決済がリクエストされていた問題を修正 
* プロモーション決済の改善 
 
### TOAST Push 
 
#### 改善事項 
 
* メッセージ/アクションの受信delegate変更 
 
## 0.15.0 (2019. 06. 25.) 
 
### TOAST IAP 
 
#### 改善事項 
 
* 新規決済、プロモーション決済、未消費内訳の詳細をリクエストすると、未完了決済のアイテムを再処理するロジックを追加 
 
### TOAST Push 
 
#### 追加事項 
 
* 初期化すると、国、言語コード設定を行う機能を追加 
* トークン情報のアップデート機能を追加 
* 通知オプション設定機能を追加 
 
#### 改善事項 
 
* 通知オプションの基本設定の変更 
    * アプリ実行中は通知を表示しないよう変更 
        * 以前と同じ動作をするためには[こちら](./push-ios/#_6)を確認してください。 
         
## 0.14.1 (2019. 05. 16.) 
 
### TOAST IAP 
 
#### 改善事項 
 
* 処理中の再処理決済件と同一の商品購買時に保有した商品に処理される現象改善 
 
### TOAST Push 
 
#### 改善事項 
 
* 端末機カレンダーの設定によって、地表イベントの発生時間が誤って収集されていたバグ修正 
 
## 0.14.0 (2019. 05. 14.) 
 
### 共通 
 
#### 改善事項 
 
* Networkエラーコードの統合 
* 安全性改善 
 
### TOAST IAP 
 
#### 改善事項 
 
* 購買復元機能の改善 
    * AppStore購買内訳をベースに漏れた決済の復元機能を追加  
    * 復元失敗エラーコード追加 
* 購入結果クラスへのストア要求(プロモーション)フラグの追加 
* 再処理対象の拡大 
* 決済の流れ改善 
 
### TOAST Push 
 
#### 改善事項 
 
* 安全性改善 
* メッセージ受信Delegate で配信されるpayload 情報にメッセージID 情報追加 
* 広告性メッセージ受信同意、夜間広告性メッセージ受信同意が不要なVoIPの場合、受信同意可否に関わらずメッセージ受信 
 
## 0.13.0 (2019. 03. 26.) 
 
### 共通 
 
#### 改善事項 
 
* Public Classの使用性改善 
  * Description追加 
  * Nullability、 NSCoding、 NSCopyingの支援 
 
### TOAST Core 
 
#### 改善事項 
 
* 内部例外処理追加 
 
### TOAST Logger 
 
#### 追加事項 
 
* arm64eアーキテクチャを使用する機器のCrash分析支援 
* PLCrashReporter Dependency 変更 
 
#### 改善事項 
 
* Configuration Interface 変更 
  * Deprecate 
    * configurationWithProjectKey 
  * Add 
    * configurationWithAppKey 
 
* UserIDの設定時点によって転送するLogのUserIDが更新されないかもしれない問題修正 
 
### TOAST IAP 
 
#### 改善事項 
 
* 内部例外処理追加 
 
### TOAST Push 
 
#### 追加事項 
 
* unregisterToken API の追加 
 
## 0.12.4 (2019. 03. 19.) 
 
### TOAST Core 
 
#### 改善事項 
 
* 例外を追加する 
 
## 0.12.3 (2019. 02. 26.) 
 
### TOAST Core、 Common 
 
#### 改善事項 
 
* util関数に例外を追加 
 
### TOAST IAP 
 
#### 改善事項 
 
* 商品情報のキャッシングを追加する 
* 例外を追加する 
 
## 0.12.2 (2019. 02. 08.) - Hotfix 
 
### TOAST Core 
 
#### 改善事項 
 
* ToastTransferで断続的に発生していたCrashを防止するためのコードを追加 
 
## 0.12.1 (2019. 01. 08.) 
 
### TOAST IAP 
 
#### 改善事項 
 
* 特定状況で決済状態がVerifyEndの決済の再処理が動作しない問題の修正 
 
## 0.12.0 (2018. 12. 27.) 
 
### TOAST CORE 
 
#### 改善事項 
 
* ToastTransferで断続的に発生していたCrashを防止するためのコードを追加 
 
### TOAST Push 
 
#### 追加事項 
 
* 新規機能追加 
 
### TOAST IAP 
 
#### 改善事項 
 
* Appleで再処理するTransactionの処理ができるようにUserID Checkロジックの例外処理を追加 
* ToastOperationで断続的に発生していたCrashを防止するためのコードを追加  
 
 
## 0.11.1 (2018. 12. 04.) 
 
### TOAST IAP 
 
#### 追加事項 
 
* 新規機能追加 
 
 
## 0.11.0 (2018. 11. 20.) 
 
### TOAST Log & Crash 
 
#### 追加事項 
 
* Network Insights機能追加 
 
 
## 0.9.0 (2018. 09. 04.) 
 
### TOAST Log & Crash 
 
#### 追加事項 
 
* 新規機能追加 
