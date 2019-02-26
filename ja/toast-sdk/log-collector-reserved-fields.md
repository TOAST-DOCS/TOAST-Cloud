## TOAST > TOAST SDK使用ガイド > TOAST Log & Crash > 予約されているフィールド

### 予約されているフィールド定義

予約されているフィールドは、TOAST SDK内部で定義して使用しているフィールド名です。
TOAST SDKで予約されているユーザーフィールドを使用する場合、フィールド名に'reserved_'が追加されます。
予約されているフィールドの検査条件は、大文字/小文字の区別をせずに文字列を比較します。

### 予約されているフィールドの使用例

* 予約されているフィールドと大文字/小文字が同じ場合

```
sendTime -> reserved_sendTime

```

* 予約されているフィールドと大文字/小文字が異なる場合

```
SENDTIME -> reserved_SENDTIME

```

### 予約されているフィールドリスト

| key | description |
| --- | ----------- |
| projectName | プロジェクト名 |
| projectVersion | プロジェクトバージョン |
| logVersion | ログ送信APIバージョン |
| logType | ログタイプ |
| logSource | ログソース |
| logLevel | ログレベル |
| body | メッセージ |
| sendTime | ログ送信時間 |
| createTime | ログ作成時間 |
| lncBulkIndex | ログ送信順序 |
| transactionID | ログ固有番号 |
| DeviceModel | デバイスモデル |
| Carrier | 通信社情報 |
| CountryCode | 国情報 |
| Platform | プラットフォーム情報 |
| NetworkType | ネットワークタイプ |
| DeviceID | デバイス識別番号 |
| SessionID | セッションID |
| launchedID | アプリインストール固有番号 |
| UserID | ユーザーID |
| SdkVersion | SDKバージョン |
| CrashStyle | クラッシュ発生言語 |
| SymMethod | クラッシュ解析方法 |
| dmpData | クラッシュ情報 |
| FreeMemory | 空きメモリ |
| FreeDiskSpace | 空きディスクスペース |
| SinkVersion | DB保存モジュールバージョン |
| errorCode | エラーコード |
| errorCode | エラーコード |
| crashMeta | クラッシュメタデータ |
| SymResult | クラッシュ分析結果 |
| ExceptionType | クラッシュタイプ |
| Location | クラッシュ発生位置 |
| lncIssueID | イシューID |
