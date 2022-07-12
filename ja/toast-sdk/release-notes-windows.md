## NHN Cloud > SDK使用ガイド > リリースノート > Windows C++

## 2.0.0.1 (2022.07.12)
Download : [nhncloud-sdk-windows-2.0.0.1.zip](https://static.toastoven.net/toastcloud/sdk_download/toast/windows/2.0.0/nhncloud-sdk-windows-2.0.0.1.zip)
* NHNCloudLoggerモジュール名の変更
	* ToastLoggerはDeprecatedになりました。
* ログ転送時のメモリリークを修正
* User IDがMBCS/UNICODE関数によって異なる値が反映される問題を修正
* クラッシュログ転送時、ログタイプフィルタ設定が適用されない問題を修正

## 1.0.0.5 (2021.03.31)
Download : [toast-sdk-windows-1.0.0.5.zip](https://static.toastoven.net/toastcloud/sdk_download/toast/windows/1.0.0/toast-sdk-windows-1.0.0.5.zip)
* バグ修正
* 一部APIのインタフェースを修正
* ユーザー定義フィールド使用時の入力値を検証
* 断続的にBase64デコードが失敗する問題を修正
* 外部プロセスでクラッシュダンプを送信すると断続的に失敗する問題を修正
* 配布バイナリ構造を 変更
	* サンプルプロジェクト含む


## 0.9.4.3 (2019.10.10)
Download : [toast-sdk-windows-0.9.4.3.zip](https://static.toastoven.net/toastcloud/sdk_download/toast/windows/0.9.4/toast-sdk-windows-0.9.4.3.zip)

### TOAST Log & Crash

#### バグ修正

* x86でpure virtual call / invalid parameterのクラッシュログが残らない問題を修正

## 0.9.3.0 (2019.07.23)
Download : [toast-sdk-windows-0.9.3.0.zip](https://static.toastoven.net/toastcloud/sdk_download/toast/windows/0.9.3/toast-sdk-windows-0.9.3.0.zip)

### TOAST Log & Crash

#### 追加事項

* Initialize()関数の成功/失敗処理
	* boolのリターン値変更
* SessionId 一般ログにも追加
* Setting情報を持っていなかった場合、すでに保存されていたSetting情報で処理
* Static library提供
	* visual studio 2015 (vc14)バージョンを提供
* xpバージョンを提供

## 0.9.0.12 (2018.09.04)
Download : [toast-sdk-windows-0.9.0.12.zip](https://static.toastoven.net/toastcloud/sdk_download/toast/windows/0.9.0/toast-sdk-windows-0.9.0.12.zip)

### TOAST Log & Crash

#### 追加事項

* 新規機能追加
