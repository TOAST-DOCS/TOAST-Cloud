# 認証方式のサポート状況

**NHN Cloud > Public API使用ガイド > API認証方式 > 認証方式のサポート状況**

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
|                         | Key Pair                                       |                    | O       |                 |        |                |
|                         | GPU Instance                                   |                    | O       |                 |        |                |
|                         | Image                                          |                    | O       |                 |        |                |
| **Container**           | NHN Kubernetes Service (NKS)                   |                    | O       |                 |        |                |
|                         | NHN Container Registry (NCR)                   | O                  |         | O               |        |                |
|                         | NHN Container Service (NCS)                    | O                  |         |                 |        |                |
| **Network**             | VPC                                            |                    | O       |                 |        |                |
|                         | Subnet                                         |                    | O       |                 |        |                |
|                         | Network Interface                              |                    | O       |                 |        |                |
|                         | Flow Log                                       |                    | O       |                 |        |                |
|                         | Routing                                        |                    | O       |                 |        |                |
|                         | Floating IP                                    |                    | O       |                 |        |                |
|                         | Network ACL                                    |                    | O       |                 |        |                |
|                         | Security Groups                                |                    | O       |                 |        |                |
|                         | Load Balancer                                  |                    | O       |                 |        |                |
|                         | Transit Hub                                    |                    | O       |                 |        |                |
|                         | Internet Gateway                               |                    | O       |                 |        |                |
|                         | Peering Gateway                                |                    | O       |                 |        |                |
|                         | Colocation Gateway                             |                    | O       |                 |        |                |
|                         | NAT Gateway                                    |                    | O       |                 |        |                |
|                         | VPN Gateway(Site-to-Site VPN)                  |                    | O       |                 |        |                |
|                         | Service Gateway                                |                    | O       |                 |        |                |
|                         | Traffic Mirroring                              |                    | O       |                 |        |                |
|                         | Private DNS                                    |                    | O       |                 |        |                |
|                         | DNS Plus                                       |                    |         |                 | O      | O              |
| **Storage**             | Block Storage                                  |                    | O       |                 |        |                |
|                         | NAS                                            |                    | O       |                 |        |                |
|                         | Object Storage<span style="color:red">*</span> |                    | O       |                 |        |                |
| **Database**            | RDS for MySQL                                  |                    |         | O               | O      | O              |
|                         | RDS for MariaDB                                |                    |         | O               | O      | O              |
|                         | RDS for PostgreSQL                             | O                  |         |                 |        |                |
| **Monitoring**          | Service Monitoring                             |                    |         |                 | O      |                |
| **Game**                | Leaderboard                                    |                    |         |                 | O      |                |
|                         | Launching                                      |                    |         |                 | O      |                |
|                         | Smart Downloader                               |                    |         |                 | O      |                |
| **Security**            | NHN AppGuard                                   |                    |         | O               | O      |                |
|                         | Server Security Check                          |                    |         |                 | O      |                |
|                         | Security Monitoring                            |                    |         |                 | O      |                |
|                         | Secure Key Manager API v1.0                    |                    |         |                 | O      | O              |
|                         | Secure Key Manager API v1.2                    |                    |         | O               | O      | O              |
|                         | Security Advisor                               |                    |         |                 | O      |                |
| **Content Delivery**    | CDN                                            |                    |         |                 | O      | O              |
|                         | Image Manager                                  |                    |         |                 | O      | O              |
| **Notification**        | Notification Hub                               | O                  |         |                 |        |                |
|                         | Push                                           |                    |         |                 | O      |                |
|                         | SMS                                            |                    |         |                 | O      |                |
|                         | RCS Bizmessage                                 |                    |         |                 | O      |                |
|                         | Email                                          |                    |         |                 | O      |                |
|                         | KakaoTalk Bizmessage                           |                    |         |                 | O      |                |
| **AI Service**          | Face Recognition                               |                    |         |                 | O      | O              |
|                         | AI Fashion                                     |                    |         |                 | O      | O              |
|                         | OCR                                            |                    |         |                 | O      | O              |
|                         | Text to Speech                                 |                    |         |                 | O      | O              |
|                         | Speech to Text                                 |                    |         |                 | O      | O              |
| **Machine Learning**    | AI EasyMaker                                   | O                  |         |                 |        |                |
| **Application Service** | ROLE                                           |                    |         |                 | O      | O              |
|                         | API Gateway                                    |                    |         |                 | O      | O              |
|                         | RTCS                                           |                    |         |                 | O      |                |
|                         | ShortURL                                       |                    |         |                 | O      |                |
|                         | File-Crafter                                   |                    |         |                 | O      |                |
| **Search**              | Cloud Search                                   |                    |         |                 | O      |                |
|                         | Autocomplete                                   |                    |         |                 | O      |                |
|                         | Corporation Search                             |                    |         |                 | O      |                |
| **Data & Analytics**    | Log & Crash Search                             |                    |         |                 | O      |                |
| **Dev Tools**           | Pipeline                                       |                    |         | O               |        |                |
|                         | Deploy                                         |                    |         | O               | O      |                |
| **Management**          | Certificate Manager API v1.0                   |                    |         |                 | O      |                |
|                         | Certificate Manager API v1.1                   |                    |O        |                 |        |                |
|                         | Certificate Manager API v1.2                   |                    |         |                 | O      |                |
|                         | Certificate Manager API v1.3                   | O                  |         |                 |        |                |
| **Bill**                | e-Tax                                          |                    |         |                 | O      |                |
| **Governance & Audit**  | CloudTrail                                     |                    |         | O               | O      |                |
|                         | Resource Watcher                               |                    |         | O               | O      |                |


<br>

!!! tip "参考"
    <span style="color:red">*</span> Object Storageサービスは、AWSのAmazon S3 APIと互換性のあるAPIを提供します。Amazon S3互換APIを使用するには、AWS EC2形式のS3 APIクレデンシャルを発行する必要があります。S3 APIクレデンシャルに関する詳細な説明は、[S3 APIクレデンシャル(S3 API Credential)](https://docs.nhncloud.com/ja/Storage/Object%20Storage/ja/s3-api-guide/#s3-api-s3-api-credential)で確認できます。
