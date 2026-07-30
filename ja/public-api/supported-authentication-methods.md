<!-- pre-align:aligned sig=84ac22d367fd -->

# 認証方式のサポート状況

**NHN Cloud > Public API使用ガイド > API認証方式 > 認証方式のサポート状況**

NHN CloudのPublic APIは、認証のためにUser Access Keyトークン、IaaSトークン、User Access Key、Appkey、プロジェクト統合Appkey、S3 API 認証情報をサポートします。
Public APIごとにサポートする認証方式が異なり、一部の認証方式は特定のバージョンでのみサポートされます。

<a id="check-authentication-methods-for-framework-and-partner-management-apis"></a>
## フレームワークAPI及びパートナー管理APIの認証方式の確認 { #check-authentication-methods-for-framework-and-partner-management-apis }

フレームワークAPI及びパートナー管理APIは、認証のためにUser Access Keyトークンを使用します。User Access Keyトークンの発行及びAPI呼び出しに関する詳細は、[User Access Keyトークン](https://docs.nhncloud.com/ja/nhncloud/ja/public-api/user-access-key-token)を参照してください。

フレームワークAPI及びパートナー管理APIの使用に関する詳細は、それぞれ[フレームワークAPI](https://docs.nhncloud.com/ja/nhncloud/ja/public-api/framework-api/)と[パートナー管理APIガイド](https://docs.nhncloud.com/ja/nhncloud/ja/public-api/partner-api/)を参照してください。


<a id="check-authentication-methods-for-each-service-api"></a>
## サービスAPI別認証方式の確認 { #check-authentication-methods-for-each-service-api }

使用するサービスでサポートされているAPI認証方式を確認してください。
次の表には、各サービスAPIがサポートする認証方式が全て記載されています。APIのバージョンやタイプによってサポートする認証方式が異なる場合があるため、使用中のバージョンのAPIガイドでサポートする認証方式を確認してください。


| サービスカテゴリ          | サービス                                          | User Access Key トークン | IaaS トークン | User Access Key | Appkey | プロジェクト統合 Appkey | S3 API 認証情報 |
| ----------------------- | ---------------------------------------------- | ------------------ | ------- | --------------- | ------ | -------------- | ------------------ |
| **Compute**             | Instance                                       |                    | O       |                 |        |                |                    |
|                         | Cloud Functions                                | O                  |         |                 |        |                |                    |
|                         | Image                                          |                    | O       |                 |        |                |                    |
|                         | Virtual Desktop                                |                    | O       |                 |        |                |                    |
| **Container**           | NHN Kubernetes Service (NKS)                   |                    | O       |                 |        |                |                    |
|                         | NHN Container Registry (NCR)                   | O                  |         | O               |        |                |                    |
|                         | NHN Container Service (NCS)                    | O                  |         |                 |        |                |                    |
| **Network**             | VPC                                            |                    | O       |                 |        |                |                    |
|                         | Flow Log                                       |                    | O       |                 |        |                |                    |
|                         | Floating IP                                    |                    | O       |                 |        |                |                    |
|                         | Network ACL                                    |                    | O       |                 |        |                |                    |
|                         | Security Groups                                |                    | O       |                 |        |                |                    |
|                         | Load Balancer                                  |                    | O       |                 |        |                |                    |
|                         | Transit Hub                                    |                    | O       |                 |        |                |                    |
|                         | Internet Gateway                               |                    | O       |                 |        |                |                    |
|                         | Colocation Gateway                             |                    | O       |                 |        |                |                    |
|                         | NAT Gateway                                    |                    | O       |                 |        |                |                    |
|                         | Service Gateway                                |                    | O       |                 |        |                |                    |
|                         | Traffic Mirroring                              |                    | O       |                 |        |                |                    |
|                         | Private DNS                                    |                    | O       |                 |        |                |                    |
|                         | DNS Plus                                       |                    |         |                 | O      | O              |                    |
| **Storage**             | Block Storage                                  |                    | O       |                 |        |                |                    |
|                         | NAS                                            |                    | O       |                 |        |                |                    |
|                         | Object Storage                                 |                    | O       |                 |        |                | O                  |
| **Database**            | RDS for MySQL                                  | O                  |         | O               | O      | O              |                    |
|                         | RDS for MariaDB                                | O                  |         | O               | O      | O              |                    |
|                         | RDS for PostgreSQL                             | O                  |         |                 |        |                |                    |
| **Monitoring**          | Service Monitoring                             |                    |         |                 | O      |                |                    |
| **Game**                | Gamebase                                       |                    |         |                 | O      |                |                    |
|                         | Leaderboard                                    |                    |         |                 | O      |                |                    |
|                         | Launching                                      |                    |         |                 | O      |                |                    |
| **Security**            | NHN AppGuard                                   |                    |         | O               | O      |                |                    |
|                         | Server Security Check                          |                    |         |                 | O      |                |                    |
|                         | Security Monitoring                            |                    |         |                 | O      |                |                    |
|                         | Secure Key Manager                             | O                  |         | O               | O      | O              |                    |
|                         | Security Advisor                               |                    |         |                 | O      |                |                    |
| **Content Delivery**    | CDN                                            |                    |         |                 | O      | O              |                    |
|                         | Image Manager                                  |                    |         |                 | O      | O              |                    |
| **Notification**        | Notification Hub                               | O                  |         |                 |        |                |                    |
|                         | Push                                           |                    |         |                 | O      |                |                    |
|                         | SMS                                            |                    |         |                 | O      |                |                    |
|                         | RCS Bizmessage                                 |                    |         |                 | O      |                |                    |
|                         | Email                                          |                    |         |                 | O      |                |                    |
|                         | KakaoTalk Bizmessage                           |                    |         |                 | O      |                |                    |
| **AI Service**          | Face Recognition                               | O                  |         |                 | O      | O              |                    |
|                         | OCR                                            | O                  |         |                 | O      | O              |                    |
|                         | Text to Speech                                 |                    |         |                 | O      | O              |                    |
|                         | Speech to Text                                 |                    |         |                 | O      | O              |                    |
| **Application Service** | ROLE                                           |                    |         |                 | O      | O              |                    |
|                         | API Gateway                                    |                    |         |                 | O      | O              |                    |
|                         | RTCS                                           |                    |         |                 | O      |                |                    |
|                         | ShortURL                                       |                    |         |                 | O      |                |                    |
|                         | File-Crafter                                   |                    |         |                 | O      |                |                    |
| **Search**              | Cloud Search                                   |                    |         |                 | O      |                |                    |
|                         | Autocomplete                                   |                    |         |                 | O      |                |                    |
|                         | Corporation Search                             |                    |         |                 | O      |                |                    |
| **Data & Analytics**    | Log & Crash Search                             |                    |         |                 | O      |                |                    |
|                         | EasyQueue                                      | O                  |         |                 |        |                |                    |
|                         | Data Lake Storage                              |                    |         |                 |        |                | O                  |
| **Dev Tools**           | Pipeline                                       | O                  |         | O               |        |                |                    |
|                         | Deploy                                         | O                  |         | O               | O      |                |                    |
| **Management**          | Certificate Manager                            | O                  | O       |                 | O      |                |                    |
|                         | Private CA                                     | O                  |         |                 |        |                |                    |
| **Governance & Audit**  | CloudTrail                                     |                    |         | O               | O      |                |                    |
|                         | Resource Watcher                               |                    |         | O               | O      |                |                    |
