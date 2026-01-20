# Supported Authentication Methods

**NHN Cloud > Public API > API Authentication Method > Supported Authentication Methods**

NHN Cloud의 Public API는 인증을 위해 User Access Key 토큰, IaaS 토큰, User Access Key, Appkey, 프로젝트 통합 Appkey를 지원합니다.
Public API마다 지원하는 인증 방식이 다르며, 일부 인증 방식은 특정 API에서만 지원합니다.

## 프레임워크 API 및 파트너 관리 API 인증 방식 확인하기

프레임워크 API 및 파트너 관리 API는 인증을 위해 User Access Key 토큰을 사용합니다. User Access Key 토큰 발급 및 API 호출에 대한 자세한 내용은 [User Access Key Token](https://docs.nhncloud.com/en/nhncloud/en/public-api/api-auth-method/user-access-key-token)을 참고하세요.

프레임워크 API 및 파트너 관리 API 사용에 대한 자세한 내용은 각각 [Framework API](https://docs.nhncloud.com/en/nhncloud/en/public-api/framework-api/)와 [Partner Management API](https://docs.nhncloud.com/en/nhncloud/en/public-api/partner-api/)를 참고하세요.


## 서비스별 인증 방식 확인하기
사용할 서비스에서 지원하는 API 인증 방식을 확인하세요.


| 서비스 카테고리           | 서비스                                          | User Access Key 토큰 | IaaS 토큰 | User Access Key | Appkey | 프로젝트 통합 Appkey |
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



!!! tip "알아두기"
    <span style="color:red">*</span> Object Storage 서비스는 AWS의 Amazon S3 API와 호환되는 API를 제공합니다. Amazon S3 호환 API를 사용하려면 AWS EC2 형태의 S3 API 자격 증명을 발급해야 합니다. S3 API 자격 증명에 대한 자세한 설명은 [S3 API Credential](https://docs.nhncloud.com/en/Storage/Object%20Storage/en/s3-api-guide/#s3-api-credentials)에서 확인할 수 있습니다.



