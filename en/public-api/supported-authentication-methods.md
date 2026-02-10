# Supported Authentication Methods

**NHN Cloud > Public API User Guide > API Authentication Method > Supported Authentication Methods**

NHN Cloud Public APIs support User Access Key tokens, IaaS tokens, User Access Keys, Appkeys, and Project Integrated Appkeys.
Authentication methods vary across Public APIs, and certain methods are only supported by specific APIs.

## Check Authentication Methods for Framework and Partner Management APIs

Framework APIs and Partner Management APIs use User Access Key tokens for authentication. For more information on issuing User Access Key tokens and making API calls, please refer to the [User Access Key Token](https://docs.nhncloud.com/en/nhncloud/en/public-api/user-access-key-token) documentation

For more information on using Framework APIs and Partner Management APIs, please refer to the [Framework API](https://docs.nhncloud.com/en/nhncloud/en/public-api/framework-api/) and [Partner Management API](https://docs.nhncloud.com/en/nhncloud/en/public-api/partner-api/) documentation, respectively.


## Check Authentication Methods for Each Service API

Check the API authentication methods supported by the service you intend to use.


| Service Category           | Service                                          | User Access Key Token | IaaS Token | User Access Key | Appkey | Project Integrated Appkey |
| ----------------------- | ---------------------------------------------- | ------------------ | ------- | --------------- | ------ | -------------- |
| **Compute**             | Instance                                       |                    | O       |                 |        |                |
|                         | Key Pair                                       |                    | O       |                 |        |                |
|                         | GPU Instance                                   |                    | O       |                 |        |                |
|                         | Image                                          |                    | O       |                 |        |                |
|                         | Virtual Desktop                                |                    | O       |                 |        |                |
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

!!! tip "Note"
    <span style="color:red">*</span> Object Storage service provides APIs compatible with the Amazon S3 API. To use these S3-compatible APIs, you must issue S3 API credentials in the AWS EC2 format. Detailed information can be found in [S3 API Credential](https://docs.nhncloud.com/en/Storage/Object%20Storage/en/s3-api-guide/#s3-api-credentials).



