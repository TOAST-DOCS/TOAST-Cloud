# Public API 概要

**NHN Cloud > Public API > Public API 概要**

NHN CloudのPublic APIは、NHN Cloudのサービスとリソースを外部システムやユーザーアプリケーションから制御または連携できるように提供するREST APIです。

このドキュメントでは、Public API呼び出し時に必要な認証方法、Public APIごとの認証方式サポート状況、フレームワークAPI、パートナー管理APIなど、Public APIの活用に必要な全般的な内容を説明します。NHN Cloud Public APIを連携しようとする開発者、API認証方式を理解しようとするサービスプランナー、APIベースでの自動化を検討しているシステム管理者がこのドキュメントを活用できます。


!!! tip 「ポイント」
    * サービスごとにAPIの動作方式やレスポンス形式が異なるため、詳細は各サービスのAPIガイドを参照してください。
    * フレームワークAPI、パートナー管理API、各サービスごとにサポートするAPI認証方式が異なり、一部の認証方式は特定のサービスでのみサポートされます。各Public APIでサポートされる認証方式は[認証方式のサポート状況](https://docs.nhncloud.com/ja/nhncloud/ja/public-api/supported-authentication-methods)で確認できます。

## Public APIを始める

* [認証方式概要](https://docs.nhncloud.com/ja/nhncloud/ja/public-api/auth-method-overview)
* [認証方式のサポート状況](https://docs.nhncloud.com/ja/nhncloud/ja/public-api/supported-authentication-methods)
* [サービスAPI](https://docs.nhncloud.com/ja/nhncloud/ja/public-api/service-api)
* [フレームワークAPI](https://docs.nhncloud.com/ja/nhncloud/ja/public-api/framework-api/)
* [パートナー管理APIガイド](https://docs.nhncloud.com/ja/nhncloud/ja/public-api/partner-api/)
* [リリースノート](https://docs.nhncloud.com/ja/nhncloud/ja/public-api/release-notes/)

## 用語集

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
