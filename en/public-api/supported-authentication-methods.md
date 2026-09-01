<!-- pre-align:aligned sig=84ac22d367fd -->

# Supported Authentication Methods

**NHN Cloud > Public API User Guide > API Authentication Method > Supported Authentication Methods**

NHN Cloud Public APIs support User Access Key tokens, IaaS tokens, User Access Keys, Appkeys, Project Integrated Appkeys, and S3 API Credentials.
Authentication methods vary across Public APIs, and certain methods are only supported by specific versions.

<a id="check-authentication-methods-for-framework-and-partner-management-apis"></a>
## Check Authentication Methods for Framework and Partner Management APIs { #check-authentication-methods-for-framework-and-partner-management-apis }

Framework APIs and Partner Management APIs use User Access Key tokens for authentication. For more information on issuing User Access Key tokens and making API calls, please refer to the [User Access Key Token](./user-access-key-token/) documentation

For more information on using Framework APIs and Partner Management APIs, please refer to the [Framework API](./framework-api/) and [Partner Management API](./partner-api/) documentation, respectively.


<a id="check-authentication-methods-for-each-service-api"></a>
## Check Authentication Methods for Each Service API { #check-authentication-methods-for-each-service-api }

Check the API authentication methods supported by the service you intend to use.
The following table shows all the authentication methods supported by each service API. Supported authentication methods may vary depending on the API version or type, so check the authentication methods supported in the API guide for the version you are using.


| Service Category           | Service                                          | User Access Key Token | IaaS Token | User Access Key | Appkey | Project Integrated Appkey | S3 API Credentials |
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



