# 認証方式概要

**NHN Cloud > Public API使用ガイド > API認証方式 > 認証方式概要**

Public APIは、各サービスで設定された認証方式に従ってリクエストを検証した後、APIバックエンドに転送します。このドキュメントでは、NHN Cloud Public APIで使用される認証方式について説明します。

## 認証方式の比較

NHN CloudのPublic APIは、認証のためにUser Access Keyトークン、IaaSトークン、User Access Key、Appkey、プロジェクト統合Appkeyをサポートしており、各認証方式は適用範囲、発行数、有効期限の有無などに違いがあります。

| 認証方式 | 特徴 | 適用範囲 | 発行数制限 | 有効期限の有無 |
| --- | --- | --- | --- | --- |
| User Access Keyトークン | ロール/権限ベースのABAC認可 | - 認証<br>- 認可 | 制限なし | あり |
| IaaSトークン | - OpenStackインフラ認証<br>- プロジェクト権限の反映 | - 認証<br>- 認可 | 制限なし | あり |
| User Access Key | アカウントベース認証 | - 認証<br>- 認可(APIバージョンにより異なる) | - NHN Cloudアカウントあたり最大5個<br>- IAMアカウントあたり最大5個 | なし |
| Appkey | サービス別固定キーベース認証 | 認証 | サービスあたり1個(サービス有効化時に自動生成) | なし |
| プロジェクト統合Appkey | プロジェクト単位統合認証 | 認証 | プロジェクトあたり最大3個 | なし |


!!! tip "参考"
    NHN Cloud Object Storageサービスは、AWSのAmazon S3 APIと互換性のあるAPIを提供します。Amazon S3互換APIを使用するには、AWS EC2形式のS3 APIクレデンシャルを発行する必要があります。S3 APIクレデンシャルに関する詳細な説明は、[S3 APIクレデンシャル(S3 API Credential)](https://docs.nhncloud.com/ja/Storage/Object%20Storage/ja/s3-api-guide/#s3-api-s3-api-credential)で確認できます。


NHN Cloud Public APIは、APIごとに異なる認証方式をサポートします。[認証方式のサポート状況](https://docs.nhncloud.com/ja/nhncloud/ja/public-api/supported-authentication-methods)で各APIが提供する認証方式を確認した後、該当する認証方式を使用してAPIリクエストを認証してください。
