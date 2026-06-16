<!-- pre-align:aligned sig=df783d99cb29 -->

## NHN Cloud > SDK使用ガイド > リリースノート > Android

<a id="121-october-28-2025"></a>

## 1.12.1 (2025. 10. 28.)

<a id="nhn-cloud-ocr"></a>

### NHN Cloud OCR

<a id="bug-fixes"></a>

#### バグ修正

* 折りたたみ端末(Foldシリーズ)対応
    * クレジットカード認識プロセスで、縦モードのガイド領域が画面からはみ出していた問題を修正しました。
* カメラプレビュー画面の同期問題の改善

<a id="120-july-29-2025"></a>

## 1.12.0 (2025. 07. 29.)

<a id="nhn-cloud-sdk"></a>

### NHN Cloud SDK

<a id="improved"></a>

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

<a id="nhn-cloud-ocr-2"></a>

### NHN Cloud OCR

<a id="fixed"></a>

#### バグ修正

* カメラプレビュー画面の同期問題の改善
    * カメラプレビュー画面とSurfaceバッファ解像度の同期ロジックを改善しました。

<a id="111-june-5-2025"></a>

## 1.11.1 (2025. 06. 05.)

<a id="nhn-cloud-push"></a>

### NHN Cloud Push

<a id="fixed-2"></a>

#### バグ修正

* Notification Hub APIドメインエラー修正
    * 誤って設定されたNotification Hub APIドメインを修正し、API呼び出しエラーを解消しました。
    
<a id="110-april-29-2025"></a>

## 1.11.0 (2025. 04. 29.)

<a id="nhn-cloud-push-2"></a>

### NHN Cloud Push

<a id="added"></a>

#### 機能追加

* Notification Hubサポート
    * NHN Cloud Push SDKでNotification Hubの使用をサポートします。
    * NhnCloudPushConfiguration.Builder.setServiceType(String)メソッドにPushServiceType.NOTIFICATION_HUBを設定して使用できます。
    
<a id="100-march-25-2025"></a>

## 1.10.0 (2025. 03. 25.)

<a id="nhn-cloud-iap"></a>

### NHN Cloud IAP

<a id="added-2"></a>

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

<a id="improved-2"></a>

#### 機能改善

* ONE store決済履歴ログをサポート
    * ONE store統合バージョン(nhncloud-iap-onestore2)からコンソールで決済履歴ログを確認できます。
    
<a id="95-january-23-2025"></a>

## 1.9.5 (2025. 01. 23.)

<a id="nhn-cloud-iap-2"></a>

### NHN Cloud IAP

<a id="improved-3"></a>

#### 機能改善

* Google Play Billing Library(PBL)アップデート
    * Google Play Billing Library(PBL)が7.1.にアップデートされました。
* NHN Cloud IAP Google Libraryの最小サポートバージョンの引き上げ
    * NHN Cloud IAP Google Library(nhncloud-iap-google)の最小サポートバージョンが21に変更されました。

<a id="nhn-cloud-push-3"></a>

### NHN Cloud Push

<a id="improved-4"></a>

#### 機能改善

* 通知振動設定API追加
    * 通知受信時の振動有無を設定できる機能が追加されました。
    * NhnCloudNotificationOptions.BuilderのenableVibration(boolean)を使用して振動の有無を設定できます。

<a id="94-november-15-2024"></a>

## 1.9.4 (2024. 11. 15.)

<a id="nhn-cloud-push-4"></a>

### NHN Cloud Push

<a id="improved-5"></a>

#### 機能改善

* Device ID設定機能を追加
    * ユーザーのDevice IDをPushサービスで使用できるように設定するAPI(NhnCloudPush.setDeviceId)を追加しました。
    
<a id="93-october-8-2024"></a>

## 1.9.3 (2024. 10. 08.)
<a id="nhn-cloud-iap-3"></a>

### NHN Cloud IAP

<a id="fixed-3"></a>

#### バグ修正

* ONEstore v19及びv21でIapProductDetails.getLocalizedPrice()メソッドが返す値に通貨記号が含まれない問題を修正
    * '₩1,000'のようにローカル通貨の形式で返されるように修正しました。

<a id="nhn-cloud-push-5"></a>

### NHN Cloud Push

<a id="fixed-4"></a>

#### バグ修正

* Google Services設定ファイル(google-services.json)がない場合に誤ったエラーが発生する問題
    * java.lang.IllegalStateExceptionの代わりにjava.lang.ExceptionInInitializerErrorが発生する問題を修正しました。
    * IllegalStateExceptionが正しく発生するようになりました。

<a id="92-august-27-2024"></a>

## 1.9.2 (2024. 08. 27.)

<a id="nhn-cloud-logger"></a>

### NHN Cloud Logger

<a id="fixed-5"></a>

#### バグ修正

* Native Crash Reportingエラー修正
    * Android 1以降の特定のデバイスでNative Crashログが断続的に報告されない問題を修正しました。

<a id="nhn-cloud-iap-4"></a>

### NHN Cloud IAP

<a id="improved-6"></a>

#### 機能改善

* Amazon決済の再処理を改善
    * アプリを削除した後に再インストールしたり、アプリデータを削除すると、失敗した決済が再処理されるときに新規購入件として処理される問題を改善しました。

<a id="91-july-23-2024"></a>

## 1.9.1 (2024. 07. 23.)

<a id="nhn-cloud-iap-5"></a>

### NHN Cloud IAP

<a id="improved-7"></a>

#### 機能改善

* Amazon決済再処理の改善
    * 購入進行中にアプリ終了またはネットワークブロックなどで決済に失敗した場合、その決済を再処理する際に新規購入案件として処理する問題を改善しました。
* ONEstore v19 SDKアップデート(v19.01.00)
    * Android 14(API Level 34)以上をターゲットとするアプリは、iap_sdk-v19.01.00.aarを使用する必要があります。

<a id="90-may-28-2024"></a>

## 1.9.0 (2024. 05. 07)

<a id="nhn-cloud-iap-6"></a>

### NHN Cloud IAP

<a id="improved-8"></a>

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

<a id="fixed-6"></a>

#### バグ修正

* ONEstoreの外部決済後、画面の向きを変更した時にステータスバーが正常に表示されない問題を修正しました。

<a id="86-may-7-2024"></a>

## 1.8.6 (2024. 05. 07)

<a id="nhn-cloud-ocr-3"></a>

### NHN Cloud OCR

<a id="fixed-7"></a>

#### バグ修正

* ネットワークタイムアウトでクレジットカードの認識に失敗する問題を修正しました。

<a id="85-february-27-2024"></a>

## 1.8.5 (2024. 02. 27.)

<a id="nhn-cloud-logger-2"></a>

### NHN Cloud Logger

<a id="fixed-8"></a>

#### バグ修正

* クラッシュログが重複して送信される問題を修正しました。

<a id="84-january-25-2024"></a>

## 1.8.4 (2024. 01. 25.)

<a id="nhn-cloud-sdk-2"></a>

### NHN Cloud SDK

<a id="improved-9"></a>

#### 機能改善

* 安定性改善
    * ProGuard未適用時に異常終了する問題を修正しました。

<a id="83-january-23-2024"></a>

## 1.8.3 (2024. 01. 23.)

<a id="nhn-cloud-iap-7"></a>

### NHN Cloud IAP

<a id="improved-10"></a>

#### 機能改善

* MyCard SDKアップデート
    * Android 14対応

<a id="82-december-19-2023"></a>

## 1.8.2 (2023. 12. 19.)

<a id="nhn-cloud-ocr-4"></a>

### NHN Cloud OCR

<a id="improved-11"></a>

#### 機能改善

* 安定性改善

<a id="81-october-31-2023"></a>

## 1.8.1 (2023. 10. 31.)

<a id="nhn-cloud-ocr-5"></a>

### NHN Cloud OCR

<a id="improved-12"></a>

#### 機能改善
* Credit Card Recognizer UI改善
    * セキュリティが強化されたTextViewを適用します。

<a id="fixed-9"></a>

#### バグ修正
* Camera Focusの問題を修正
    * 一部の低仕様デバイスでAuto Focusが動作しない問題を修正します。

<a id="80-september-26-2023"></a>

## 1.8.0 (2023. 09. 26.)

<a id="nhn-cloud-iap-8"></a>

### NHN Cloud IAP

<a id="improved-13"></a>

#### 機能改善

* Google Billing Client 5.2.1アップデート
    * Googleのポリシーにより、Android 14 以上をターゲットとするアプリは NHN Cloud IAP 1.8.0 以上にアップデートする必要があります。

<a id="nhn-cloud-ocr-6"></a>

### NHN Cloud OCR

<a id="improved-14"></a>

#### 機能改善

* Cameraの改善
    * Camera Preview画面がディスプレイを全て満たすように変更します。
* 最低サポートバージョンがAPI 22に引き上げられました。

<a id="71-august-29-2023"></a>

## 1.7.1 (2023. 08. 29.)

<a id="nhn-cloud-iap-9"></a>

### NHN Cloud IAP

<a id="improved-15"></a>

#### 機能改善

* MyCardテスト決済改善
* MyCard の最小サポートバージョンが API 21 に引き上げられました。

<a id="70-july-11-2023"></a>

## 1.7.0 (2023. 07. 11.)

<a id="nhn-cloud-ocr-7"></a>

### NHN Cloud OCR

<a id="added-3"></a>

#### 機能追加

* OCR(ID Card Recognizer)追加

<a id="60-june-20-2023"></a>

## 1.6.0 (2023. 06. 20.)

<a id="nhn-cloud-iap-10"></a>

### NHN Cloud IAP

<a id="added-4"></a>

#### 機能追加

* ONE store v21追加

<a id="nhn-cloud-logger-3"></a>

### NHN Cloud Logger

<a id="improved-16"></a>

#### 機能改善

* Android Gradle Plugin 8.0をサポート

<a id="51-may-30-2023"></a>

## 1.5.1 (2023. 05. 30.)

<a id="nhn-cloud-iap-11"></a>

### NHN Cloud IAP

<a id="added-5"></a>

#### 機能追加

* 決済詳細情報送信機能を追加
    * IAPコンソールのTransactionタブで決済詳細情報を照会できます。

<a id="50-april-5-2023"></a>

## 1.5.0 (2023. 04. 05.)

<a id="nhn-cloud-sdk-3"></a>

### NHN Cloud SDK

<a id="improved-17"></a>

#### 機能改善

* 安定性改善

<a id="nhn-cloud-iap-12"></a>

### NHN Cloud IAP

<a id="added-6"></a>

#### 機能追加

* MyCard IAP追加

<a id="43-march-24-2023"></a>

## 1.4.3 (2023. 03. 24.)

<a id="nhn-cloud-ocr-8"></a>

### NHN Cloud OCR

<a id="fixed-10"></a>

#### バグ修正

* NoClassDefFoundErrorイシューを修正

<a id="42-february-28-2023"></a>

## 1.4.2 (2023. 02. 28.)

<a id="nhn-cloud-ocr-9"></a>

### NHN Cloud OCR

<a id="improved-18"></a>

#### 機能改善

* 安定性改善

<a id="41-january-11-2023"></a>

## 1.4.1 (2023. 01. 11.)

<a id="nhn-cloud-push-6"></a>

### NHN Cloud Push

<a id="improved-19"></a>

#### 機能改善

* プッシュ指標送信およびイベント処理の改善

<a id="40-november-29-2022"></a>

## 1.4.0 (2022. 11. 29.)

<a id="nhn-cloud-logger-4"></a>

### NHN Cloud Logger

<a id="added-7"></a>

#### 機能追加

* 公共機関用Loggerをサポート

<a id="nhn-cloud-ocr-10"></a>

### NHN Cloud OCR

<a id="improved-20"></a>

#### 機能改善

* UI改善

<a id="fixed-11"></a>

#### バグ修正

* カメラ初期化時にクラッシュする問題を修正

<a id="nhn-cloud-push-7"></a>

### NHN Cloud Push

<a id="improved-21"></a>

#### 機能改善

* プッシュイベント転送の改善
* Intentのflagsが変更される問題を修正
    * NhnCloudPushMessageReceiver.getContentIntent()呼び出し時に渡されるIntentに設定されたflagsが維持されない問題が修正されました。

<a id="30-october-25-2022"></a>

## 1.3.0 (2022. 10. 25.)

<a id="nhn-cloud-ocr-11"></a>

### NHN Cloud OCR

<a id="added-8"></a>

#### 機能追加

* OCR(Credit Card Recognizer)追加

<a id="nhn-cloud-iap-13"></a>

### NHN Cloud IAP

<a id="added-9"></a>

#### 機能追加

* [すべてのストア]有効購読照会および未消費決済履歴照会API追加

<a id="nhn-cloud-push-8"></a>

### NHN Cloud Push

<a id="fixed-12"></a>

#### バグ修正

* NHN Cloud SDK 1.0.0以上バージョンでToastPushMessageReceiver使用時、クリックイベント受信および指標収集不可エラーを修正

<a id="20-october-4-2022"></a>

## 1.2.0 (2022. 10. 04.)

<a id="nhn-cloud-sdk-4"></a>

### NHN Cloud SDK

<a id="improved-22"></a>

#### 機能改善

* AndroidXサポート
    * 最小サポートバージョンがAPI 16に変更されました。

<a id="nhn-cloud-push-9"></a>

### NHN Cloud Push

<a id="improved-23"></a>

#### 機能改善

* Android 13対応
    * POST_NOTIFICATION権限をリクエストできるAPIが追加されました。
    * Notificationチャンネルを作成できるAPIが追加されました。  

<a id="10-september-6-2022"></a>

## 1.1.0 (2022. 09. 06.)

<a id="nhn-cloud-iap-14"></a>

### NHN Cloud IAP

<a id="added-10"></a>

#### 機能追加

* ONEstore v19追加

<a id="improved-24"></a>

#### 機能改善

* Google Billing Client 5.0.0アップデート

<a id="00-july-12-2022"></a>

## 1.0.0 (2022. 07. 12.)

<a id="nhn-cloud-sdk-5"></a>

### NHN Cloud SDK

<a id="improved-25"></a>

#### 機能改善

* モジュール名をNHN Cloud Android SDKに変更
	* TOAST Android SDKはDeprecatedになりました。

<a id="311-june-14-2022"></a>

## 0.31.1 (2022. 06. 14.)

<a id="toast-logger"></a>

### TOAST Logger

<a id="improved-26"></a>

#### 機能改善

* TOAST Logger安定化

<a id="310-may-10-2022"></a>

## 0.31.0 (2022. 05. 10.)

<a id="toast-iap"></a>

### TOAST IAP

<a id="added-11"></a>

#### 機能追加

* ONEstore外部決済の追加

<a id="toast-push"></a>

### TOAST Push

<a id="added-12"></a>

#### 機能追加

* 1つのFirebaseプロジェクトに登録された複数のAndroidアプリをサポート

<a id="301-may-3-2022"></a>

## 0.30.1 (2022. 05. 03.)

<a id="toast-iap-2"></a>

### TOAST IAP

<a id="improved-27"></a>

#### 機能改善

* ONEstore v16アイテム照会ロジックの改善

<a id="300-april-26-2022"></a>

## 0.30.0 (2022. 04. 26.)

<a id="toast-push-2"></a>

### TOAST Push

<a id="added-13"></a>

#### 機能追加

- ADM(Amazon Device Messaging) 追加

<a id="292-march-29-2022"></a>

## 0.29.2 (2022. 03. 29.)

<a id="toast-push-3"></a>

### TOAST Push

<a id="fixed-13"></a>

#### バグ修正

* トークン更新時にトークンが登録できない問題の修正

<a id="291-february-22-2022"></a>

## 0.29.1 (2022. 02. 22.)

<a id="toast-push-4"></a>

### TOAST Push

<a id="fixed-14"></a>

#### バグ修正

* Google PlayサービスがインストールされていないデバイスでFCMトークン取得時にクラッシュする問題を修正

<a id="290-december-07-2021"></a>

## 0.29.0 (2021. 12. 07.)

<a id="toast-iap-3"></a>

### TOAST IAP

<a id="added-14"></a>

#### 機能追加

* ファーウェイストア(Huawei App Gallery)追加

<a id="280-november-23-2021"></a>

## 0.28.0 (2021. 11. 23.)

<a id="toast-iap-4"></a>

### TOAST IAP

<a id="added-15"></a>

#### 機能追加

* Amazon Appstore追加

<a id="toast-push-5"></a>

### TOAST Push

<a id="improved-28"></a>

#### 機能改善

* Android 12対応
    * Pending intents mutability.
    * Notification trampoline restrictions.
    * Safer component exporting (android.exported).

> Notificationを直接作成する場合、指標の収集が可能なPendingIntentを返すToastPushMessageReceiver.getContentIntent()が追加されました。
これはAndroid 12以上で一部の機能が正常に動作しないToastPushMessageReceiver.getNotificationServiceIntent()に代わるものです。

<a id="274-october-26-2021"></a>

## 0.27.4 (2021. 10. 26.)

<a id="toast-push-6"></a>

### TOAST Push

<a id="fixed-15"></a>

#### バグ修正

* ユーザー通知チャンネル設定が初期化されるエラーを修正

<a id="273-september-28-2021"></a>

## 0.27.3 (2021. 09. 28.)

<a id="toast-iap-5"></a>

### TOAST IAP

<a id="improved-29"></a>

#### 機能改善

* ONEstore v16テスト決済プロセスを改善

<a id="272-september-06-2021"></a>

## 0.27.2 (2021. 09. 06.)

<a id="toast-logger-2"></a>

### TOAST Logger

<a id="fixed-16"></a>

#### バグ修正

* DeviceModelが「UNKNOWN」と表示されるエラーを修正
    * Unityでクラッシュ発生時、DeviceModelが「UNKNOWN」と表示されるエラーを修正しました。

<a id="271-august-24-2021"></a>

## 0.27.1 (2021. 08. 24.)

<a id="toast-iap-6"></a>

### TOAST IAP

<a id="improved-30"></a>

#### 機能改善

* Google定期購入決済プロセスを改善
* ONEstore v16決済プロセスを改善

<a id="270-august-03-2021"></a>

## 0.27.0 (2021. 08. 03.)

<a id="toast-iap-7"></a>

### TOAST IAP

<a id="added-16"></a>

#### 機能追加

* ONE store v16追加

<a id="260-july-06-2021"></a>

## 0.26.0 (2021. 07. 06.)

<a id="toast-iap-8"></a>

### TOAST IAP

<a id="added-17"></a>

#### 機能追加

* 月決済限度機能を追加

<a id="toast-push-7"></a>

### TOAST Push

<a id="fixed-17"></a>

#### バグ修正

* Firebase Messaging 22.0.0以上対応
    * Firebase Messaging 22.0.0以上で発生するエラーを修正しました。

<a id="250-april-27-2021"></a>

## 0.25.0 (2021. 04. 27.)

<a id="toast-iap-9"></a>

### TOAST IAP

<a id="added-18"></a>

#### 機能追加

* Google定期購入状態照会APIを追加
    * Google定期購入の状態を照会できるquerySubscriptionsStatus APIを追加します。

<a id="improved-31"></a>

#### 機能改善

* Google 決済ライブラリアップデート
    * Google 決済ライブラリBillingClient 3.0.3が適用されました。

<a id="fixed-18"></a>

#### バグ修正

* Android 11以上で「キャンセル」が繰り返し発生する問題を修正しました。

<a id="244-january-12-2021"></a>

## 0.24.4 (2021. 01. 12.)

<a id="toast-push-8"></a>

### TOAST Push

<a id="improved-32"></a>

#### 機能改善

* FCMトークン更新時のアップデートロジックの改善

<a id="toast-gradle-plugin-001"></a>

### TOAST Gradle Plugin (0.0.1)

<a id="added-19"></a>

#### 機能追加

* Symbol Uploader機能追加

<a id="243-december-08-2020"></a>

## 0.24.3 (2020. 12. 08.)

<a id="toast-push-9"></a>

### TOAST Push

<a id="improved-33"></a>

#### 機能改善

* Tencent QQサービス終了後のモジュール削除

<a id="242-november-24-2020"></a>

## 0.24.2 (2020. 11. 24.)

<a id="toast-push-10"></a>

### TOAST Push

<a id="fixed-19"></a>

#### バグ修正

* ユーザーID設定と同時にトークン登録リクエストした際、デバイス識別子として登録されていた問題を解決

<a id="241-october-30-2020"></a>

## 0.24.1 (2020. 10. 30.)

<a id="toast-iap-10"></a>

### TOAST IAP

<a id="fixed-20"></a>

#### バグ修正

* Galaxy Storeのアプリ内決済エラー修正
    * Galaxy Apps(Galaxy Store以前のアプリ名称)3.x以下のバージョンでTimeoutが発生するエラーを修正しました。

<a id="240-october-27-2020"></a>

## 0.24.0 (2020. 10. 27.)

<a id="toast-iap-11"></a>

### TOAST IAP

<a id="added-20"></a>

#### 機能追加

* Galaxy Store追加

<a id="improved-34"></a>

#### 機能改善

* Google決済ライブラリーのアップデート
    * Google決済ライブラリーBilling Client 3.0.1が適用されました。
    * 2021年8月2日より、すべての新しいアプリは決済ライブラリバージョン3以上を使用しなければなりません。
    * 2021年11月1日まで既存アプリに対するすべてのアップデートは、決済ライブラリバージョン3以上を使用する必要があります。
    * 詳細は[Meet Google Play Billing Library Version 3](https://android-developers.googleblog.com/2020/06/meet-google-play-billing-library.html)を参照してください。
* Google定期決済(サブスクリプション)ステータス変更による対応
    * Google定期購入決済の更新および満了などのライフサイクルの間、様々な状態の変更(猶予期間、アカウント保留、復元、一時停止、定期決済の再申請など)に対応しました。

<a id="toast-push-11"></a>

### TOAST Push

<a id="improved-35"></a>

#### 機能改善

* 通知返信機能をサポートしていない端末では返信機能のボタンが表示されないよう修正

<a id="fixed-21"></a>

#### バグ修正

* 特定の状況で通知チャネルが新しく作成されるバグ修正

<a id="232-october-06-2020"></a>

## 0.23.2 (2020. 10. 06.)

<a id="toast-iap-12"></a>

### TOAST IAP

<a id="fixed-22"></a>

#### バグ修正

* 定期購入関連の不具合修正
    * 定期購入が「アカウント保留」または「猶予期間」の状態から、決済手段の修正により復元された場合、IapService.PurchasesUpdatedListenerを通してエラーが通知されないよう修正しました。

<a id="231-september-11-2020"></a>

## 0.23.1 (2020. 09. 11.)

<a id="toast-push-12"></a>

### TOAST Push

<a id="improved-36"></a>

#### 機能改善

* トークン登録ロジックの改善

<a id="230-july-28-2020"></a>

## 0.23.0 (2020. 07. 28.)

<a id="toast-push-13"></a>

### TOAST Push

<a id="added-21"></a>

#### 機能追加

* ユーザータグ機能サポート

<a id="220-june-23-2020"></a>

## 0.22.0 (2020. 06. 23.)

<a id="toast-iap-13"></a>

### TOAST IAP

<a id="improved-37"></a>

#### 機能改善

`TOAST IAP SDK 0.22.0以上でアップデートする際は、必ず強制アップデートを実行してください。`

* Google Play Billing Library BillingClient 2.2.1適用

<a id="toast-push-14"></a>

### TOAST Push

<a id="improved-38"></a>

#### 機能改善

* ユーザータグ機能のサポート

<a id="212-may-26-2020"></a>

## 0.21.2 (2020. 05. 26.)

<a id="toast-push-15"></a>

### TOAST Push

<a id="improved-39"></a>

#### 機能改善

* トークン登録機能の改善

<a id="211-april-28-2020"></a>

## 0.21.1 (2020. 04. 28.)

<a id="toast-push-16"></a>

### TOAST Push

<a id="improved-40"></a>

#### 機能改善

* 安全性の改善

<a id="toast-logger-3"></a>

### TOAST Logger

<a id="improved-41"></a>

#### 機能改善

* Native Crash Reporting機能の改善

<a id="210-march-24-2020"></a>

## 0.21.0 (2020. 03. 24.)

<a id="toast-logger-4"></a>

### TOAST Logger

<a id="added-22"></a>

#### 機能追加

* Native Crash Reporting (NDK)機能の追加

<a id="toast-push-17"></a>

### TOAST Push

<a id="improved-42"></a>

#### 機能改善

* 基本通知オプションに設定可能な項目を追加
    * フォアグラウンド時に通知の表示の有無の選択設定が追加されました。
    * バッジアイコン使用の有無の設定が追加されました。

<a id="203-february-25-2020"></a>

## 0.20.3 (2020. 02. 25.)

<a id="toast-push-18"></a>

### TOAST Push

<a id="improved-43"></a>

#### 機能改善

* トークン登録機能の改善
    * 初回トークン登録時にユーザーIDが設定されていない場合は、デバイス識別子を使用して登録します。
    * トークンに登録した後、ToastSdk.setUserId()を使用してユーザーIDを設定または変更すると、トークン情報を更新します。

<a id="202-january-21-2020"></a>

## 0.20.2 (2020. 01. 21.)

<a id="toast-push-19"></a>

### TOAST Push

<a id="improved-44"></a>

#### 機能改善

* 指標収集機能の改善
* 基本通知チャンネル作成ロジックを改善

<a id="201-january-07-2020"></a>

## 0.20.1 (2020. 01. 07.)

<a id="toast-push-20"></a>

### TOAST Push

<a id="improved-45"></a>

#### 機能改善

* Assetsリソースサポート
    * Assetsパスのイメージリソースをサポートします。
* 基本オプションの設定方法の改善
    * AndroidManifestのmeta-dataを使用して通知の基本オプションを設定できます。

<a id="toast-iap-14"></a>

### TOAST IAP

<a id="improved-46"></a>

#### 機能改善
* セキュリティ強化
    * 内部のセキュリティポリシーを強化しました。

<a id="fixed-23"></a>

#### バグ修正

* "Bad base64 Exception"のエラー修正
    * TOAST SDKを使用しない決済アイテム処理時に「Bad Base64 Exception」が発生するエラーを修正しました。

<a id="194-november-26-2019"></a>

## 0.19.4 (2019. 11. 26.)

<a id="toast-push-21"></a>

### TOAST Push

<a id="improved-47"></a>

#### 機能改善

* (旧) pushsdkデータマイグレーションをサポート。
    * (旧) pushsdkでアップデートした場合、すべてのデータをTOAST SDKにマイグレーションします。

<a id="193-october-18-2019"></a>

## 0.19.3 (2019. 10. 18.)

<a id="toast-push-22"></a>

### TOAST Push

<a id="improved-48"></a>

#### 機能改善

* トークン登録機能の改善。

<a id="192-october-15-2019"></a>

## 0.19.2 (2019. 10. 15.)

<a id="toast-push-23"></a>

### TOAST Push

<a id="added-23"></a>

#### 機能追加

* 通知をクリックすると通知する機能を追加。
    * ユーザーが通知をクリックし、アプリが実行された場合のリスナー登録が可能です。
* バッチ機能をサポート。
    * 通知を受信すると、バッチアイコンとアプリのショートカット画面にバッチカウントが表示されます。

<a id="improved-49"></a>

#### 機能改善

* 通知の基本スタイルの指定。
    * メディアを含まない通知は、BigTextStyleに指定され、2行以上のメッセージも表示されます。

<a id="191-october-02-2019"></a>

## 0.19.1 (2019. 10. 02.)

<a id="toast-iap-15"></a>

### TOAST IAP

<a id="added-24"></a>

#### 機能追加

* Unity Android IAP Pluginに購入をリクエストすると、ユーザーデータを領収書に含めることができる機能が追加されました。

<a id="190-october-01-2019"></a>

## 0.19.0 (2019. 10. 01.)

<a id="toast-iap-16"></a>

### TOAST IAP

<a id="added-25"></a>

#### 機能追加
* Android IAPライブラリーに購入リクエストの際、ユーザーデータを領主書へ含めることができる機能が追加されました。


<a id="toast-push-24"></a>

### TOAST Push

<a id="improved-50"></a>

#### 機能改善

* ユーザー定義メッセージレシーバーの使用性を改善。
    * 通知の表示をリクエストすると、ユーザーのコンテンツインテントタイプが、PendingIntentに変更されます。

<a id="180-august-27-2019"></a>

## 0.18.0 (2019. 08. 27.)

<a id="toast-iap-17"></a>

### TOAST IAP

<a id="added-26"></a>

#### 機能追加

* 消費性定期購入商品を追加。
    * プロダクトタイプに消費可能な定期購入商品が追加されました。

<a id="fixed-24"></a>

#### バグ修正

* Google Play Storeでのアプリアップデートの際、決済結果が2回以上通知されるエラーを修正しました。

<a id="toast-push-25"></a>

### TOAST Push

<a id="added-27"></a>

#### 機能追加

* 基本通知オプション設定機能の追加
    * 小さいアイコン、振動、通知音等の基本オプションを選択できます。

<a id="171-july-23-2019"></a>

## 0.17.1 (2019. 07. 23.)

<a id="toast-push-26"></a>

### TOAST Push

<a id="added-28"></a>

#### 機能追加

* カスタムレシーバ使用時、メッセージオブジェクト内にFCM発信者ID情報追加。

<a id="170-june-25-2019"></a>

## 0.17.0 (2019. 06. 25.)

<a id="toast-pus"></a>

### TOAST Push

<a id="added-29"></a>

#### 機能追加

* トークン情報アップデート機能追加。
    * 言語や国などの情報をアップデートすることができます。
* メッセージ受信通知機能追加。
* リッチメッセージボタンのアクション("Open", "Dismiss", "Reply", etc)通知機能追加。

<a id="improved-51"></a>

#### 機能改善

* 初期化を改善。
    * PushType ("FCM"、"TENCENT"、 etc)で初期化が可能です。
* アプリの状態による通知表示ポリシーの変更。
    * ユーザーがアプリを使用中(Foreground)の時は、通知を表示しません。
* ユーザー定義メッセージレシーバーの使用性を改善。
    * ユーザー定義メッセージの修正および通知作成が簡単になりました。
    * ユーザー定義通知の指標送信が簡単になりました。

<a id="162-june-21-2019"></a>

## 0.16.2 (2019. 06. 21.)

<a id="toast-iap-18"></a>

### TOAST IAP

<a id="improved-52"></a>

#### 機能改善

* ユーザーIDが変更された場合の動作改善
* (旧)IAP SDK v1.5.3以前の決済アイテムの再処理

<a id="toast-logger-5"></a>

### TOAST Logger

<a id="fixed-25"></a>

#### バグ修正

* クラッシュエラー修正

<a id="161-may-02-2019"></a>

## 0.16.1 (2019. 05. 02.)

<a id="toast-sdk"></a>

### TOAST SDK

<a id="fixed-26"></a>

#### Fixed

* 'toast-sdk'で'toast-push-tencent'依存を取り除く。

<a id="160-april-23-2019"></a>

## 0.16.0 (2019. 04. 23.)

<a id="toast-push-27"></a>

### TOAST Push

<a id="added-30"></a>

#### 機能を追加

* Tencent Push追加します。
* ユーザーメッセージ処理機能を追加。
    * メッセージを受信すると、ユーザーが定義したreceiverがメッセージを処理します。

<a id="150-march-26-2019"></a>

## 0.15.0 (2019. 03. 26.)

<a id="toast-log-crash"></a>

### TOAST Log & Crash

<a id="improved-53"></a>

#### 機能改善

* ProjectKeyがAppKeyに名称変更
    *既存のsetProjectKeyは引き続き使用可能

<a id="toast-iap-19"></a>

### TOAST IAP

<a id="added-31"></a>

#### 機能追加

* 中国のマーケットを追加。

<a id="toast-push-28"></a>

### TOAST Push

<a id="added-32"></a>

#### 機能追加

*トークン解除APIを追加。
* soundフィールドを追加する時に通知の音を設定することができる機能を追加。
    *アンドロイド8.0未満でのみ動作

<a id="143-march-08-2019"></a>

## 0.14.3 (2019. 03. 08.)

<a id="toast-iap-20"></a>

### TOAST IAP

<a id="fixed-27"></a>

#### バグ修正

* アプリでProguardを適用する場合には、APIが正常に動作しない問題を解決。

<a id="142-march-04-2019"></a>

## 0.14.2 (2019. 03. 04.)

<a id="toast-push-29"></a>

### TOAST Push

<a id="fixed-28"></a>

#### バグ修正

* FCMトークンを獲得することができない場合は、クラッシュが発生する問題を解決。

<a id="141-january-29-2019"></a>

## 0.14.1 (2019. 01. 29.)

<a id="toast-iap-21"></a>

### TOAST IAP

<a id="fixed-29"></a>

#### バグ修正

* （旧）IAP SDK決済件を処理していないエラーを修正。

<a id="140-january-08-2019"></a>

## 0.14.0 (2019. 01. 08.)

<a id="toast-iap-22"></a>

### TOAST IAP

<a id="added-33"></a>

#### 機能追加

* TOAST IAP Unity Plugin追加。

<a id="130-december-27-2018"></a>

## 0.13.0 (2018. 12. 27.)

<a id="toast-core"></a>

### TOAST Core

<a id="improved-54"></a>

#### 機能改善

* ToastSdk.initialize()メソッドdeprecated.
    * Application起動時に自動的に呼び出すように変更

<a id="toast-push-30"></a>

### TOAST Push

<a id="added-34"></a>

#### 機能追加

* 新規機能追加
    * Firebase Cloud Messaging(FCM)

<a id="120-december-04-2018"></a>

## 0.12.0 (2018. 12. 04.)

<a id="toast-iap-23"></a>

### TOAST IAP

<a id="added-35"></a>

#### 追加事項

* 新規機能追加
    * Google Play Store(消費性商品、購読商品)
    * ONE store(消費性商品)

<a id="110-november-20-2018"></a>

## 0.11.0 (2018. 11. 20.)

<a id="toast-log-crash-2"></a>

### TOAST Log & Crash

<a id="added-36"></a>

#### 追加事項

* Network Insights機能追加

<a id="90-september-04-2018"></a>

## 0.9.0 (2018. 09. 04.)

<a id="toast-log-crash-3"></a>

### TOAST Log & Crash

<a id="added-37"></a>

#### 追加事項

* 新規機能追加

