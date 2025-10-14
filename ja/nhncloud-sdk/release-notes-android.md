## NHN Cloud > SDK使用ガイド > リリースノート > Android

## 1.12.1 (2025. 10. 28.)

### NHN Cloud OCR

#### バグ修正

* 折りたたみ端末(Foldシリーズ)対応
    * クレジットカード認識プロセスで、縦モードのガイド領域が画面からはみ出していた問題を修正しました。
* カメラプレビュー画面の同期問題の改善

## 1.12.0 (2025. 07. 29.)

### NHN Cloud SDK

#### 機能改善

* 最小サポートバージョン引き上げ
    * Android最小サポートバージョンがAPI 16(Android 4.1)からAPI 22(Android 5.1)に引き上げられました。
    * NHN Cloud Android SDKで使用されている一部のAPIは、TLS 1.0およびTLS 1.1のサポートが近日中に終了し、TLS 1.2以降のみがサポートされます。
    * これはセキュリティ強化のための措置であり、SDKをアップデートしない場合でも、v1.12.0未満のバージョンをAndroid 5.1（API 22）未満の環境で使用すると、一部のAPIが正常に動作しない可能性があります。
* 16KBページサイズのサポート
    * 2025年11月1日以降、Google Playに提出するAndroid 15(API 34)以上をターゲットとするすべての新規アプリおよび既存アプリのアップデートは、64ビット端末で16KBページサイズのサポートが必須です。
    * これに伴い、NHN Cloud SDKは16KBページサイズをサポートします。
    * サポートモジュール
        * NHN Cloud Logger
        * NHN Cloud OCR

### NHN Cloud OCR

#### バグ修正

* カメラプレビュー画面の同期問題の改善
    * カメラプレビュー画面とSurfaceバッファ解像度の同期ロジックを改善しました。

## 1.11.1 (2025. 06. 05.)

### NHN Cloud Push

#### バグ修正

* Notification Hub APIドメインエラー修正
    * 誤って設定されたNotification Hub APIドメインを修正し、API呼び出しエラーを解消しました。
    
## 1.11.0 (2025. 04. 29.)

### NHN Cloud Push

#### 機能追加

* Notification Hubサポート
    * NHN Cloud Push SDKでNotification Hubの使用をサポートします。
    * NhnCloudPushConfiguration.Builder.setServiceType(String)メソッドにPushServiceType.NOTIFICATION_HUBを設定して使用できます。
    
## 1.10.0 (2025. 03. 25.)

### NHN Cloud IAP

#### 機能追加

* ONE storeバージョン統合
    * ONE store v17, v19, v21バージョンを1つに統合しました。
    * nhncloud-iap-onestore2モジュールを使用すると、ONE store IAP SDKを統合されたバージョンにアップデートして使用できます。
    * 統合対象：
        * nhncloud-iap-onestore
        * nhncloud-iap-onestore-v19
        * nhncloud-iap-onestore-v21
* ONE storeサブスクリプションをサポート
    * ONE store統合バージョン(nhncloud-iap-onestore2)でサブスクリプション型商品をサポートします。
    * これにより、ONE storeでも定期決済の商品を提供できます。

#### 機能改善

* ONE store決済履歴ログをサポート
    * ONE store統合バージョン(nhncloud-iap-onestore2)からコンソールで決済履歴ログを確認できます。
    
## 1.9.5 (2025. 01. 23.)

### NHN Cloud IAP

#### 機能改善

* Google Play Billing Library(PBL)アップデート
    * Google Play Billing Library(PBL)が7.1.にアップデートされました。
* NHN Cloud IAP Google Libraryの最小サポートバージョンの引き上げ
    * NHN Cloud IAP Google Library(nhncloud-iap-google)の最小サポートバージョンが21に変更されました。

### NHN Cloud Push

#### 機能改善

* 通知振動設定API追加
    * 通知受信時の振動有無を設定できる機能が追加されました。
    * NhnCloudNotificationOptions.BuilderのenableVibration(boolean)を使用して振動の有無を設定できます。

## 1.9.4 (2024. 11. 15.)

### NHN Cloud Push

#### 機能改善

* Device ID設定機能を追加
    * ユーザーのDevice IDをPushサービスで使用できるように設定するAPI(NhnCloudPush.setDeviceId)を追加しました。
    
## 1.9.3 (2024. 10. 08.)
### NHN Cloud IAP

#### バグ修正

* ONEstore v19及びv21でIapProductDetails.getLocalizedPrice()メソッドが返す値に通貨記号が含まれない問題を修正
    * '₩1,000'のようにローカル通貨の形式で返されるように修正しました。

### NHN Cloud Push

#### バグ修正

* Google Services設定ファイル(google-services.json)がない場合に誤ったエラーが発生する問題
    * java.lang.IllegalStateExceptionの代わりにjava.lang.ExceptionInInitializerErrorが発生する問題を修正しました。
    * IllegalStateExceptionが正しく発生するようになりました。

## 1.9.2 (2024. 08. 27.)

### NHN Cloud Logger

#### バグ修正

* Native Crash Reportingエラー修正
    * Android 1以降の特定のデバイスでNative Crashログが断続的に報告されない問題を修正しました。

### NHN Cloud IAP

#### 機能改善

* Amazon決済の再処理を改善
    * アプリを削除した後に再インストールしたり、アプリデータを削除すると、失敗した決済が再処理されるときに新規購入件として処理される問題を改善しました。

## 1.9.1 (2024. 07. 23.)

### NHN Cloud IAP

#### 機能改善

* Amazon決済再処理の改善
    * 購入進行中にアプリ終了またはネットワークブロックなどで決済に失敗した場合、その決済を再処理する際に新規購入案件として処理する問題を改善しました。
* ONEstore v19 SDKアップデート(v19.01.00)
    * Android 14(API Level 34)以上をターゲットとするアプリは、iap_sdk-v19.01.00.aarを使用する必要があります。

## 1.9.0 (2024. 05. 07)

### NHN Cloud IAP

#### 機能改善

* Google Play Billing Library(PBL) 6.2.1アップデート
    * Googleのポリシーにより、PBL 5.xを使用しているアプリは2024年11月1日からPBL 6.xにアップデートする必要があります。
        * 新規アプリのリリース： 2024年8月1日
        * 既存アプリアップデート: 2024年11月1日
    * Android 4.4(API 19)をサポートするには追加設定が必要です。詳細については、 [NHN Cloud > SDK使用ガイド > IAP > Android](./iap-android)を参考してください。
* Google IAP Library(nhncloud-iap-google)の最小サポートバージョンが19に変更されました。
* IapResult.NETWORK_ERRORコードを追加
    * NHN Cloud IAP 1.9.0から既存のIapResult.NETWORK_NOT_CONNECTEDコードがIapResult.NETWORK_ERRORコードとして返されます。
    * IapResult.NETWORK_NOT_CONNECTEDレスポンスコードが削除されました。
* 決済ヒストリー情報に**ユーザーキャンセル(canceled)**、**決済保留(pending)**状態が追加されました。

#### バグ修正

* ONEstoreの外部決済後、画面の向きを変更した時にステータスバーが正常に表示されない問題を修正しました。

## 1.8.6 (2024. 05. 07)

### NHN Cloud OCR

#### バグ修正

* ネットワークタイムアウトでクレジットカードの認識に失敗する問題を修正しました。

## 1.8.5 (2024. 02. 27.)

### NHN Cloud Logger

#### バグ修正

* クラッシュログが重複して送信される問題を修正しました。

## 1.8.4 (2024. 01. 25.)

### NHN Cloud SDK

#### 機能改善

* 安定性改善
    * ProGuard未適用時に異常終了する問題を修正しました。

## 1.8.3 (2024. 01. 23.)

### NHN Cloud IAP

#### 機能改善

* MyCard SDKアップデート
    * Android 14対応

## 1.8.2 (2023. 12. 19.)

### NHN Cloud OCR

#### 機能改善

* 安定性改善

## 1.8.1 (2023. 10. 31.)

### NHN Cloud OCR

#### 機能改善
* Credit Card Recognizer UI改善
    * セキュリティが強化されたTextViewを適用します。

#### バグ修正
* Camera Focusの問題を修正
    * 一部の低仕様デバイスでAuto Focusが動作しない問題を修正します。

## 1.8.0 (2023. 09. 26.)

### NHN Cloud IAP

#### 機能改善

* Google Billing Client 5.2.1アップデート
    * Googleのポリシーにより、Android 14 以上をターゲットとするアプリは NHN Cloud IAP 1.8.0 以上にアップデートする必要があります。

### NHN Cloud OCR

#### 機能改善

* Cameraの改善
    * Camera Preview画面がディスプレイを全て満たすように変更します。
* 最低サポートバージョンがAPI 22に引き上げられました。

## 1.7.1 (2023. 08. 29.)

### NHN Cloud IAP

#### 機能改善

* MyCardテスト決済改善
* MyCard の最小サポートバージョンが API 21 に引き上げられました。

## 1.7.0 (2023. 07. 11.)

### NHN Cloud OCR

#### 機能追加

* OCR(ID Card Recognizer)追加

## 1.6.0 (2023. 06. 20.)

### NHN Cloud IAP

#### 機能追加

* ONE store v21追加

### NHN Cloud Logger

#### 機能改善

* Android Gradle Plugin 8.0をサポート

## 1.5.1 (2023. 05. 30.)

### NHN Cloud IAP

#### 機能追加

* 決済詳細情報送信機能を追加
    * IAPコンソールのTransactionタブで決済詳細情報を照会できます。

## 1.5.0 (2023. 04. 05.)

### NHN Cloud SDK

#### 機能改善

* 安定性改善

### NHN Cloud IAP

#### 機能追加

* MyCard IAP追加

## 1.4.3 (2023. 03. 24.)

### NHN Cloud OCR

#### バグ修正

* NoClassDefFoundErrorイシューを修正

## 1.4.2 (2023. 02. 28.)

### NHN Cloud OCR

#### 機能改善

* 安定性改善

## 1.4.1 (2023. 01. 11.)

### NHN Cloud Push

#### 機能改善

* プッシュ指標送信およびイベント処理の改善

## 1.4.0 (2022. 11. 29.)

### NHN Cloud Logger

#### 機能追加

* 公共機関用Loggerをサポート

### NHN Cloud OCR

#### 機能改善

* UI改善

#### バグ修正

* カメラ初期化時にクラッシュする問題を修正

### NHN Cloud Push

#### 機能改善

* プッシュイベント転送の改善
* Intentのflagsが変更される問題を修正
    * NhnCloudPushMessageReceiver.getContentIntent()呼び出し時に渡されるIntentに設定されたflagsが維持されない問題が修正されました。

## 1.3.0 (2022. 10. 25.)

### NHN Cloud OCR

#### 機能追加

* OCR(Credit Card Recognizer)追加

### NHN Cloud IAP

#### 機能追加

* [すべてのストア]有効購読照会および未消費決済履歴照会API追加

### NHN Cloud Push

#### バグ修正

* NHN Cloud SDK 1.0.0以上バージョンでToastPushMessageReceiver使用時、クリックイベント受信および指標収集不可エラーを修正

## 1.2.0 (2022. 10. 04.)

### NHN Cloud SDK

#### 機能改善

* AndroidXサポート
    * 最小サポートバージョンがAPI 16に変更されました。

### NHN Cloud Push

#### 機能改善

* Android 13対応
    * POST_NOTIFICATION権限をリクエストできるAPIが追加されました。
    * Notificationチャンネルを作成できるAPIが追加されました。  

## 1.1.0 (2022. 09. 06.)

### NHN Cloud IAP

#### 機能追加

* ONEstore v19追加

#### 機能改善

* Google Billing Client 5.0.0アップデート

## 1.0.0 (2022. 07. 12.)

### NHN Cloud SDK

#### 機能改善

* モジュール名をNHN Cloud Android SDKに変更
	* TOAST Android SDKはDeprecatedになりました。

## 0.31.1 (2022. 06. 14.)

### TOAST Logger

#### 機能改善

* TOAST Logger安定化

## 0.31.0 (2022. 05. 10.)

### TOAST IAP

#### 機能追加

* ONEstore外部決済の追加

### TOAST Push

#### 機能追加

* 1つのFirebaseプロジェクトに登録された複数のAndroidアプリをサポート

## 0.30.1 (2022. 05. 03.)

### TOAST IAP

#### 機能改善

* ONEstore v16アイテム照会ロジックの改善

## 0.30.0 (2022. 04. 26.)

### TOAST Push

#### 機能追加

- ADM(Amazon Device Messaging) 追加

## 0.29.2 (2022. 03. 29.)

### TOAST Push

#### バグ修正

* トークン更新時にトークンが登録できない問題の修正

## 0.29.1 (2022. 02. 22.)

### TOAST Push

#### バグ修正

* Google PlayサービスがインストールされていないデバイスでFCMトークン取得時にクラッシュする問題を修正

## 0.29.0 (2021. 12. 07.)

### TOAST IAP

#### 機能追加

* ファーウェイストア(Huawei App Gallery)追加

## 0.28.0 (2021. 11. 23.)

### TOAST IAP

#### 機能追加

* Amazon Appstore追加

### TOAST Push

#### 機能改善

* Android 12対応
    * Pending intents mutability.
    * Notification trampoline restrictions.
    * Safer component exporting (android.exported).

> Notificationを直接作成する場合、指標の収集が可能なPendingIntentを返すToastPushMessageReceiver.getContentIntent()が追加されました。
これはAndroid 12以上で一部の機能が正常に動作しないToastPushMessageReceiver.getNotificationServiceIntent()に代わるものです。

## 0.27.4 (2021. 10. 26.)

### TOAST Push

#### バグ修正

* ユーザー通知チャンネル設定が初期化されるエラーを修正

## 0.27.3 (2021. 09. 28.)

### TOAST IAP

#### 機能改善

* ONEstore v16テスト決済プロセスを改善

## 0.27.2 (2021. 09. 06.)

### TOAST Logger

#### バグ修正

* DeviceModelが「UNKNOWN」と表示されるエラーを修正
    * Unityでクラッシュ発生時、DeviceModelが「UNKNOWN」と表示されるエラーを修正しました。

## 0.27.1 (2021. 08. 24.)

### TOAST IAP

#### 機能改善

* Google定期購入決済プロセスを改善
* ONEstore v16決済プロセスを改善

## 0.27.0 (2021. 08. 03.)

### TOAST IAP

#### 機能追加

* ONE store v16追加

## 0.26.0 (2021. 07. 06.)

### TOAST IAP

#### 機能追加

* 月決済限度機能を追加

### TOAST Push

#### バグ修正

* Firebase Messaging 22.0.0以上対応
    * Firebase Messaging 22.0.0以上で発生するエラーを修正しました。

## 0.25.0 (2021. 04. 27.)

### TOAST IAP

#### 機能追加

* Google定期購入状態照会APIを追加
    * Google定期購入の状態を照会できるquerySubscriptionsStatus APIを追加します。

#### 機能改善

* Google 決済ライブラリアップデート
    * Google 決済ライブラリBillingClient 3.0.3が適用されました。

#### バグ修正

* Android 11以上で「キャンセル」が繰り返し発生する問題を修正しました。

## 0.24.4 (2021. 01. 12.)

### TOAST Push

#### 機能改善

* FCMトークン更新時のアップデートロジックの改善

### TOAST Gradle Plugin (0.0.1)

#### 機能追加

* Symbol Uploader機能追加

## 0.24.3 (2020. 12. 08.)

### TOAST Push

#### 機能改善

* Tencent QQサービス終了後のモジュール削除

## 0.24.2 (2020. 11. 24.)

### TOAST Push

#### バグ修正

* ユーザーID設定と同時にトークン登録リクエストした際、デバイス識別子として登録されていた問題を解決

## 0.24.1 (2020. 10. 30.)

### TOAST IAP

#### バグ修正

* Galaxy Storeのアプリ内決済エラー修正
    * Galaxy Apps(Galaxy Store以前のアプリ名称)3.x以下のバージョンでTimeoutが発生するエラーを修正しました。

## 0.24.0 (2020. 10. 27.)

### TOAST IAP

#### 機能追加

* Galaxy Store追加

#### 機能改善

* Google決済ライブラリーのアップデート
    * Google決済ライブラリーBilling Client 3.0.1が適用されました。
    * 2021年8月2日より、すべての新しいアプリは決済ライブラリバージョン3以上を使用しなければなりません。
    * 2021年11月1日まで既存アプリに対するすべてのアップデートは、決済ライブラリバージョン3以上を使用する必要があります。
    * 詳細は[Meet Google Play Billing Library Version 3](https://android-developers.googleblog.com/2020/06/meet-google-play-billing-library.html)を参照してください。
* Google定期決済(サブスクリプション)ステータス変更による対応
    * Google定期購入決済の更新および満了などのライフサイクルの間、様々な状態の変更(猶予期間、アカウント保留、復元、一時停止、定期決済の再申請など)に対応しました。

### TOAST Push

#### 機能改善

* 通知返信機能をサポートしていない端末では返信機能のボタンが表示されないよう修正

#### バグ修正

* 特定の状況で通知チャネルが新しく作成されるバグ修正

## 0.23.2 (2020. 10. 06.)

### TOAST IAP

#### バグ修正

* 定期購入関連の不具合修正
    * 定期購入が「アカウント保留」または「猶予期間」の状態から、決済手段の修正により復元された場合、IapService.PurchasesUpdatedListenerを通してエラーが通知されないよう修正しました。

## 0.23.1 (2020. 09. 11.)

### TOAST Push

#### 機能改善

* トークン登録ロジックの改善

## 0.23.0 (2020. 07. 28.)

### TOAST Push

#### 機能追加

* ユーザータグ機能サポート

## 0.22.0 (2020. 06. 23.)

### TOAST IAP

#### 機能改善

`TOAST IAP SDK 0.22.0以上でアップデートする際は、必ず強制アップデートを実行してください。`

* Google Play Billing Library BillingClient 2.2.1適用

### TOAST Push

#### 機能改善

* ユーザータグ機能のサポート

## 0.21.2 (2020. 05. 26.)

### TOAST Push

#### 機能改善

* トークン登録機能の改善

## 0.21.1 (2020. 04. 28.)

### TOAST Push

#### 機能改善

* 安全性の改善

### TOAST Logger

#### 機能改善

* Native Crash Reporting機能の改善

## 0.21.0 (2020. 03. 24.)

### TOAST Logger

#### 機能追加

* Native Crash Reporting (NDK)機能の追加

### TOAST Push

#### 機能改善

* 基本通知オプションに設定可能な項目を追加
    * フォアグラウンド時に通知の表示の有無の選択設定が追加されました。
    * バッジアイコン使用の有無の設定が追加されました。

## 0.20.3 (2020. 02. 25.)

### TOAST Push

#### 機能改善

* トークン登録機能の改善
    * 初回トークン登録時にユーザーIDが設定されていない場合は、デバイス識別子を使用して登録します。
    * トークンに登録した後、ToastSdk.setUserId()を使用してユーザーIDを設定または変更すると、トークン情報を更新します。

## 0.20.2 (2020. 01. 21.)

### TOAST Push

#### 機能改善

* 指標収集機能の改善
* 基本通知チャンネル作成ロジックを改善

## 0.20.1 (2020. 01. 07.)

### TOAST Push

#### 機能改善

* Assetsリソースサポート
    * Assetsパスのイメージリソースをサポートします。
* 基本オプションの設定方法の改善
    * AndroidManifestのmeta-dataを使用して通知の基本オプションを設定できます。

### TOAST IAP

#### 機能改善
* セキュリティ強化
    * 内部のセキュリティポリシーを強化しました。

#### バグ修正

* "Bad base64 Exception"のエラー修正
    * TOAST SDKを使用しない決済アイテム処理時に「Bad Base64 Exception」が発生するエラーを修正しました。

## 0.19.4 (2019. 11. 26.)

### TOAST Push

#### 機能改善

* (旧) pushsdkデータマイグレーションをサポート。
    * (旧) pushsdkでアップデートした場合、すべてのデータをTOAST SDKにマイグレーションします。

## 0.19.3 (2019. 10. 18.)

### TOAST Push

#### 機能改善

* トークン登録機能の改善。

## 0.19.2 (2019. 10. 15.)

### TOAST Push

#### 機能追加

* 通知をクリックすると通知する機能を追加。
    * ユーザーが通知をクリックし、アプリが実行された場合のリスナー登録が可能です。
* バッチ機能をサポート。
    * 通知を受信すると、バッチアイコンとアプリのショートカット画面にバッチカウントが表示されます。

#### 機能改善

* 通知の基本スタイルの指定。
    * メディアを含まない通知は、BigTextStyleに指定され、2行以上のメッセージも表示されます。

## 0.19.1 (2019. 10. 02.)

### TOAST IAP

#### 機能追加

* Unity Android IAP Pluginに購入をリクエストすると、ユーザーデータを領収書に含めることができる機能が追加されました。

## 0.19.0 (2019. 10. 01.)

### TOAST IAP

#### 機能追加
* Android IAPライブラリーに購入リクエストの際、ユーザーデータを領主書へ含めることができる機能が追加されました。


### TOAST Push

#### 機能改善

* ユーザー定義メッセージレシーバーの使用性を改善。
    * 通知の表示をリクエストすると、ユーザーのコンテンツインテントタイプが、PendingIntentに変更されます。

## 0.18.0 (2019. 08. 27.)

### TOAST IAP

#### 機能追加

* 消費性定期購入商品を追加。
    * プロダクトタイプに消費可能な定期購入商品が追加されました。

#### バグ修正

* Google Play Storeでのアプリアップデートの際、決済結果が2回以上通知されるエラーを修正しました。

### TOAST Push

#### 機能追加

* 基本通知オプション設定機能の追加
    * 小さいアイコン、振動、通知音等の基本オプションを選択できます。

## 0.17.1 (2019. 07. 23.)

### TOAST Push

#### 機能追加

* カスタムレシーバ使用時、メッセージオブジェクト内にFCM発信者ID情報追加。

## 0.17.0 (2019. 06. 25.)

### TOAST Push

#### 機能追加

* トークン情報アップデート機能追加。
    * 言語や国などの情報をアップデートすることができます。
* メッセージ受信通知機能追加。
* リッチメッセージボタンのアクション("Open", "Dismiss", "Reply", etc)通知機能追加。

#### 機能改善

* 初期化を改善。
    * PushType ("FCM"、"TENCENT"、 etc)で初期化が可能です。
* アプリの状態による通知表示ポリシーの変更。
    * ユーザーがアプリを使用中(Foreground)の時は、通知を表示しません。
* ユーザー定義メッセージレシーバーの使用性を改善。
    * ユーザー定義メッセージの修正および通知作成が簡単になりました。
    * ユーザー定義通知の指標送信が簡単になりました。

## 0.16.2 (2019. 06. 21.)

### TOAST IAP

#### 機能改善

* ユーザーIDが変更された場合の動作改善
* (旧)IAP SDK v1.5.3以前の決済アイテムの再処理

### TOAST Logger

#### バグ修正

* クラッシュエラー修正

## 0.16.1 (2019. 05. 02.)

### TOAST SDK

#### Fixed

* 'toast-sdk'で'toast-push-tencent'依存を取り除く。

## 0.16.0 (2019. 04. 23.)

### TOAST Push

#### 機能を追加

* Tencent Push追加します。
* ユーザーメッセージ処理機能を追加。
    * メッセージを受信すると、ユーザーが定義したreceiverがメッセージを処理します。

## 0.15.0 (2019. 03. 26.)

### TOAST Log & Crash

#### 機能改善

* ProjectKeyがAppKeyに名称変更
    *既存のsetProjectKeyは引き続き使用可能

### TOAST IAP

#### 機能追加

* 中国のマーケットを追加。

### TOAST Push

#### 機能追加

*トークン解除APIを追加。
* soundフィールドを追加する時に通知の音を設定することができる機能を追加。
    *アンドロイド8.0未満でのみ動作

## 0.14.3 (2019. 03. 08.)

### TOAST IAP

#### バグ修正

* アプリでProguardを適用する場合には、APIが正常に動作しない問題を解決。

## 0.14.2 (2019. 03. 04.)

### TOAST Push

#### バグ修正

* FCMトークンを獲得することができない場合は、クラッシュが発生する問題を解決。

## 0.14.1 (2019. 01. 29.)

### TOAST IAP

#### バグ修正

* （旧）IAP SDK決済件を処理していないエラーを修正。

## 0.14.0 (2019. 01. 08.)

### TOAST IAP

#### 機能追加

* TOAST IAP Unity Plugin追加。

## 0.13.0 (2018. 12. 27.)

### TOAST Core

#### 機能改善

* ToastSdk.initialize()メソッドdeprecated.
    * Application起動時に自動的に呼び出すように変更

### TOAST Push

#### 機能追加

* 新規機能追加
    * Firebase Cloud Messaging(FCM)

## 0.12.0 (2018. 12. 04.)

### TOAST IAP

#### 追加事項

* 新規機能追加
    * Google Play Store(消費性商品、購読商品)
    * ONE store(消費性商品)

## 0.11.0 (2018. 11. 20.)

### TOAST Log & Crash

#### 追加事項

* Network Insights機能追加

## 0.9.0 (2018. 09. 04.)

### TOAST Log & Crash

#### 追加事項

* 新規機能追加

