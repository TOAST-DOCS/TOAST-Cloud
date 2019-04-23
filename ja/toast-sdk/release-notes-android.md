## TOAST > TOAST SDK使用ガイド > リリースノート > Android

## 0.16.0 (2019.04.23)

### TOAST Push

#### 機能を追加

* Tencent Push追加します。
* ユーザーメッセージ処理機能を追加。
    * メッセージを受信すると、ユーザーが定義したreceiverがメッセージを処理します。

## 0.15.0 (2019.03.26)

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

## 0.14.3 (2019.03.08)

### TOAST IAP

#### バグ修正

* アプリでProguardを適用する場合には、APIが正常に動作しない問題を解決。

## 0.14.2 (2019.03.04)

### TOAST Push

#### バグ修正

* FCMトークンを獲得することができない場合は、クラッシュが発生する問題を解決。

## 0.14.1 (2019.01.29)

### TOAST IAP

#### バグ修正

* （旧）IAP SDK決済件を処理していないエラーを修正。

## 0.14.0 (2019.01.08)

### TOAST IAP

#### 機能追加

* TOAST IAP Unity Plugin追加.

## 0.13.0 (2018.12.27)

### TOAST Core

#### 機能改善

* ToastSdk.initialize()メソッドdeprecated.
    * Application起動時に自動的に呼び出すように変更

### TOAST Push

#### 機能追加

* 新規機能追加
    * Firebase Cloud Messaging(FCM)

## 0.12.0 (2018.12.04)

### TOAST IAP

#### 追加事項

* 新規機能追加
    * Google Playストア(消費性商品、購読商品)
    * ONE store(消費性商品)

## 0.11.0 (2018.11.20)

### TOAST Log & Crash

#### 追加事項

* Network Insights機能追加

## 0.9.0 (2018.09.04)

### TOAST Log & Crash

#### 追加事項

* 新規機能追加
