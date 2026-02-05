# 認証方式のサポート状況

**NHN Cloud > Public API > API認証方式 > 認証方式のサポート状況**

NHN CloudのPublic APIは、認証のためにUser Access Keyトークン、IaaSトークン、User Access Key、Appkey、プロジェクト統合Appkeyをサポートします。
Public APIごとにサポートする認証方式が異なり、一部の認証方式は特定のAPIでのみサポートされます。

## フレームワークAPI及びパートナー管理APIの認証方式の確認

フレームワークAPI及びパートナー管理APIは、認証のためにUser Access Keyトークンを使用します。User Access Keyトークンの発行及びAPI呼び出しに関する詳細は、[User Access Keyトークン](https://docs.nhncloud.com/ja/nhncloud/ja/public-api/user-access-key-token)を参照してください。

フレームワークAPI及びパートナー管理APIの使用に関する詳細は、それぞれ[フレームワークAPI](https://docs.nhncloud.com/ja/nhncloud/ja/public-api/framework-api/)と[パートナー管理APIガイド](https://docs.nhncloud.com/ja/nhncloud/ja/public-api/partner-api/)を参照してください。


## サービスAPI別認証方式の確認

使用するサービスでサポートされているAPI認証方式を確認してください。


| サービスカテゴリー          | サービス                                         | User Access Keyトークン | IaaSトークン | User Access Key | Appkey | プロジェクト統合Appkey |
| ----------------------- | ---------------------------------------------- | ------------------ | ------- | --------------- | ------ | -------------- |
| **Compute**             | Instance                                       |                    | O       |                 |        |                |
|                         | Image                                          |                    | O       |                 |        |                |
| **Container**           | NHN Kubernetes Service (NKS)                   |                    | O       |                 |        |                |
|                         | NHN Container Registry (NCR)                   |                    |         | O               |        |                |
|                         | NHN Container Service (NCS)                    | O                  |         |                 |        |                |
| **Network**             | VPC                                            |                    | O       |                 |        |                |
|                         | Flow Log                                       |                    | O       |                 |        |                |
|                         | Floating IP                                    |                    | O       |                 |        |                |
|                         | Network ACL                                    |                    | O       |                 |        |                |
|                         | Security Groups                                |                    | O       |                 |        |                |
|                         | Load Balancer                                  |                    | O       |                 |        |                |
|                         | Transit Hub                                    |                    | O       |                 |        |                |
|                         | Service Gateway                                |                    | O       |                 |        |                |
|                         | DNS Plus                                       |                    |         |                 | O      | O              |
| **Storage**             | Block Storage                                  |                    | O       |                 |        |                |
|                         | Object Storage<span style="color:red">*</span> |                    | O       |                 |        |                |
| **Database**            | RDS for MySQL                                  |                    |         | O               | O      | O              |
|                         | RDS for MariaDB                                |                    |         | O               | O      | O              |
|                         | RDS for PostgreSQL                             | O                  |         |                 |        |                |
| **Monitoring**          | Service Monitoring                             |                    |         |                 | O      |                |
| **Game**                | Gamebase                                       |                    |         |                 | O      |                |
|                         | Leaderboard                                    |                    |         |                 | O      |                |
|                         | Launching                                      |                    |         |                 | O      |                |
| **Security**            | NHN AppGuard                                   |                    |         | O               | O      |                |
|                         | Server Security Check                          |                    |         |                 | O      |                |
|                         | Webshell Threat Detector                       |                    |         |                 | O      |                |
|                         | Security Monitoring                            |                    |         |                 | O      |                |
|                         | Security Compliance                            |                    |         |                 | O      |                |
|                         | Security Advisor                               |                    |         |                 | O      |                |
|                         | NHN Bastion                                    |                    |         |                 | O      |                |
|                         | Secure Key Manager                             |                    |         | O               | O      | O              |
| **Content Delivery**    | CDN                                            |                    |         |                 | O      | O              |
|                         | Image Manager                                  |                    |         |                 | O      | O              |
| **Notification**        | Push                                           |                    |         |                 | O      |                |
|                         | SMS                                            |                    |         |                 | O      |                |
|                         | RCS Bizmessage                                 |                    |         |                 | O      |                |
|                         | Email                                          |                    |         |                 | O      |                |
|                         | KakaoTalk Bizmessage                           |                    |         |                 | O      |                |
|                         | Notification Hub                               | O                  |         |                 |        |                |
| **AI Service**          | Face Recognition                               |                    |         |                 | O      |                |
|                         | AI Fashion                                     |                    |         |                 | O      |                |
|                         | OCR                                            |                    |         |                 | O      |                |
|                         | Text to Speech                                 |                    |         |                 | O      |                |
|                         | Speech to Text                                 |                    |         |                 | O      |                |
| **Machine Learning**    | AI EasyMaker                                   |                    |         |                 | O      | O              |
| **Application Service** | ROLE                                           |                    |         |                 | O      | O              |
|                         | API Gateway                                    |                    |         |                 | O      | O              |
|                         | ShortURL                                       |                    |         |                 | O      |                |
|                         | File-Crafter                                   |                    |         |                 | O      |                |
| **Mobile Service**      | IAP                                            |                    |         |                 | O      |                |
| **Search**              | Cloud Search                                   |                    |         |                 | O      |                |
|                         | Autocomplete                                   |                    |         |                 | O      |                |
|                         | Corporation Search                             |                    |         |                 | O      |                |
| **Data & Analytics**    | Log & Crash Search                             |                    |         |                 | O      |                |
| **Dev Tools**           | Pipeline                                       |                    |         | O               |        |                |
|                         | Deploy                                         |                    |         | O               | O      |                |
| **Management**          | Certificate Manager                            |                    |         | O               | O      |                |
| **Contact Center**      | Contiple                                       |                    |         |                 | O      |                |
| **Governance & Audit**  | CloudTrail                                     |                    |         | O               | O      |                |
|                         | Resource Watcher                               |                    |         | O               | O      |                |


<br>

!!! tip 「ポイント」
    <span style="color:red">*</span> Object Storageサービスは、AWSのAmazon S3 APIと互換性のあるAPIを提供します。Amazon S3互換APIを使用するには、AWS EC2形式のS3 APIクレデンシャルを発行する必要があります。S3 APIクレデンシャルに関する詳細な説明は、[S3 APIクレデンシャル(S3 API Credential)](https://docs.nhncloud.com/ja/Storage/Object%20Storage/ja/s3-api-guide/#s3-api-s3-api-credential)で確認できます。
