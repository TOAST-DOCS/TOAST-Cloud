<!-- machine_translated: true -->

<!-- pre-align:aligned sig=65978a09ad39 -->

# Public API 概要

**NHN Cloud > Public API使用ガイド > Public API 概要**

NHN CloudのPublic APIは、NHN Cloudのサービスとリソースを外部システムやユーザーアプリケーションから制御または連携できるように提供するREST APIです。

このドキュメントでは、Public API呼び出し時に必要な認証方法、Public APIごとの認証方式サポート状況、フレームワークAPI、パートナー管理APIなど、Public APIの活用に必要な全般的な内容を説明します。NHN Cloud Public APIを連携しようとする開発者、API認証方式を理解しようとするサービスプランナー、APIベースでの自動化を検討しているシステム管理者がこのドキュメントを活用できます。


!!! tip "ヒント"
    * サービスごとに API の動作方式とレスポンス形式が異なるため、詳細については各サービスの API ガイドを参照してください。
    * フレームワーク API、パートナー管理 API、各サービスでサポートされる API 認証方式はそれぞれ異なり、一部の認証方式は特定のサービスでのみサポートされています。各 Public API でサポートされる認証方式は、[認証方式サポート状況](/Support-Status/ja/supported-authentication-methods/)で確認できます。

<a id="getting-started-with-public-api"></a>
## Public APIを始める { #getting-started-with-public-api }

* [認証方式の概要](./auth-method-overview/)
* [認証方式サポート状況](/Support-Status/ja/supported-authentication-methods/)
* [サービス API](./service-api/)
* [フレームワーク API](./framework-api/)
* [パートナー管理 API](./partner-api/)
* [リリースノート](./release-notes/)

<a id="glossary"></a>
## 用語集 { #glossary }

| 用語 | 説明 |
| --- | --- |
| Public API | NHN Cloudが提供するREST APIで、NHN Cloudサービスとリソースを外部システムまたはユーザーアプリケーションから制御または連携できるようサポート。サービスAPI、フレームワークAPI、パートナー管理APIを全て含む概念 |
| サービスAPI | NHN Cloudが提供する個別サービスと該当サービスのリソースを外部システムまたはユーザーアプリケーションから制御または連携できるようサポートするAPI |
| フレームワークAPI | NHN Cloud組織とプロジェクトを管理するAPI |
| パートナー管理API | NHN Cloudパートナーまたはパートナーから権限を付与されたユーザーが、パートナークラウドの組織とプロジェクト、ビリング情報などを管理し、商品のメータリングを照会できるAPI |
| 認証(Authentication) | ある主体の身元を確認し証明すること |
| 認可(Authorization) | 認証を通じて身元が確認された主体に対し、特定のリソースや機能へのアクセス、または操作を実行する権限があるかを確認し許可するプロセス |
| Bearerトークン | トークンを所有するユーザーにアクセス権限を付与するセキュリティトークンのタイプ |
| Keystone | OpenStackの認証及び権限付与作業を担当するサービス。ユーザーとサービスの身元を確認し、適切な権限を付与してリソースへの安全なアクセスを保証する |
