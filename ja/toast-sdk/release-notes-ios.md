## TOAST > TOAST SDK使用ガイド > リリースノート > iOS

## 0.14.1 (2019.05.16)

### TOAST IAP

#### 改善事項

* 処理中の再処理決済件と同一の商品購買時に保有した商品に処理される現象改善

### TOAST Push

#### 改善事項

* 端末機カレンダーの設定によって,地表イベントの発生時間が誤って収集されていたバグ修正

## 0.14.0 (2019.05.14)

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
* 広告性メッセージ受信同意,夜間広告性メッセージ受信同意が不要なVoIPの場合,受信同意可否に関わらずメッセージ受信

## 0.13.0 (2019.03.26)

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

#### 不具合修正

* UserIDの設定時点によって転送するLogのUserIDが更新されないかもしれない問題修正

### TOAST IAP

#### 改善事項

* 内部例外処理追加

### TOAST Push

#### 追加事項

* unregisterToken API の追加

## 0.12.4 (2019.03.19)

### TOAST Core

#### 改善事項

* 例外を追加する

## 0.12.3 (2019.02.26)

### TOAST Core, Common

#### 改善事項

* util関数に例外を追加

### TOAST IAP

#### 改善事項

* 商品情報のキャッシングを追加する
* 例外を追加する

## 0.12.2 (2019.02.08) - Hotfix

### TOAST Core

#### 改善事項

* ToastTransferで断続的に発生していたCrashを防止するためのコードを追加

## 0.12.1 (2019.01.08)

### TOAST IAP

#### 改善事項

* 特定状況で決済状態がVerifyEndの決済の再処理が動作しない問題の修正

## 0.12.0 (2018.12.27)

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


## 0.11.1 (2018.12.04)

### TOAST IAP

#### 追加事項

* 新規機能追加


## 0.11.0 (2018.11.20)

### TOAST Log & Crash

#### 追加事項

* Network Insights機能追加


## 0.9.0 (2018.09.04)

### TOAST Log & Crash

#### 追加事項

* 新規機能追加
