<!-- pre-align:aligned sig=68b848be7257 -->

## NHN Cloud > SDK使用ガイド > リリースノート > Windows C++

<a id="002-20240123"></a>

## 2.0.0.2 (2024.01.23)
Download : [nhncloud-sdk-windows-2.0.0.2.zip](https://static.toastoven.net/toastcloud/sdk_download/toast/windows/2.0.0/nhncloud-sdk-windows-2.0.0.2.zip)
* 重複ログフィルタリング改善
* CrashReporter実行時のハンドルリーク問題を修正
* その他安定性の改善

<a id="001-20220712"></a>

## 2.0.0.1 (2022.07.12)
Download : [nhncloud-sdk-windows-2.0.0.1.zip](https://static.toastoven.net/toastcloud/sdk_download/toast/windows/2.0.0/nhncloud-sdk-windows-2.0.0.1.zip)
* NHNCloudLoggerモジュール名の変更
	* ToastLoggerはDeprecatedになりました。
* ログ転送時のメモリリークを修正
* User IDがMBCS/UNICODE関数によって異なる値が反映される問題を修正
* クラッシュログ転送時、ログタイプフィルタ設定が適用されない問題を修正

<a id="005-20210331"></a>

## 1.0.0.5 (2021.03.31)
Download : [toast-sdk-windows-1.0.0.5.zip](https://static.toastoven.net/toastcloud/sdk_download/toast/windows/1.0.0/toast-sdk-windows-1.0.0.5.zip)
* バグ修正
* 一部APIのインタフェースを修正
* ユーザー定義フィールド使用時の入力値を検証
* 断続的にBase64デコードが失敗する問題を修正
* 外部プロセスでクラッシュダンプを送信すると断続的に失敗する問題を修正
* 配布バイナリ構造を 変更
	* サンプルプロジェクト含む


<a id="943-20191010"></a>

## 0.9.4.3 (2019.10.10)
Download : [toast-sdk-windows-0.9.4.3.zip](https://static.toastoven.net/toastcloud/sdk_download/toast/windows/0.9.4/toast-sdk-windows-0.9.4.3.zip)

<a id="toast-log-crash"></a>

### TOAST Log & Crash

<a id="bug-fixes"></a>

#### バグ修正

* x86でpure virtual call / invalid parameterのクラッシュログが残らない問題を修正

<a id="930-20190723"></a>

## 0.9.3.0 (2019.07.23)
Download : [toast-sdk-windows-0.9.3.0.zip](https://static.toastoven.net/toastcloud/sdk_download/toast/windows/0.9.3/toast-sdk-windows-0.9.3.0.zip)

<a id="toast-log-crash-2"></a>

### TOAST Log & Crash

<a id="added-features"></a>

#### 追加事項

* Initialize()関数の成功/失敗処理
	* boolのリターン値変更
* SessionId 一般ログにも追加
* Setting情報を持っていなかった場合、すでに保存されていたSetting情報で処理
* Static library提供
	* visual studio 2015 (vc14)バージョンを提供
* xpバージョンを提供

<a id="9012-20180904"></a>

## 0.9.0.12 (2018.09.04)
Download : [toast-sdk-windows-0.9.0.12.zip](https://static.toastoven.net/toastcloud/sdk_download/toast/windows/0.9.0/toast-sdk-windows-0.9.0.12.zip)

<a id="toast-log-crash-3"></a>

### TOAST Log & Crash

<a id="added"></a>

#### 追加事項

* 新規機能追加
