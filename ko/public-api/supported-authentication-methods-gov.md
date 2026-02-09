# 인증 방식 지원 현황

**NHN Cloud > Public API 사용 가이드 > API 인증 방식 > 인증 방식 지원 현황**

NHN Cloud의 Public API는 인증을 위해 User Access Key 토큰, IaaS 토큰, User Access Key, Appkey, 프로젝트 통합 Appkey를 지원합니다.
Public API마다 지원하는 인증 방식이 다르며, 일부 인증 방식은 특정 API에서만 지원합니다.

## 프레임워크 API 및 파트너 관리 API 인증 방식 확인하기

프레임워크 API 및 파트너 관리 API는 인증을 위해 User Access Key 토큰을 사용합니다. User Access Key 토큰 발급 및 API 호출에 대한 자세한 내용은 [User Access Key 토큰](https://docs.gov-nhncloud.com/ko/nhncloud/ko/public-api/user-access-key-token-gov)을 참고하세요.

프레임워크 API 및 파트너 관리 API 사용에 대한 자세한 내용은 각각 [프레임워크 API](https://docs.gov-nhncloud.com/ko/nhncloud/ko/public-api/framework-api-gov/)와 [파트너 관리 API](https://docs.gov-nhncloud.com/ko/nhncloud/ko/public-api/partner-api-gov/)를 참고하세요.


## 서비스 API별 인증 방식 확인하기
사용할 서비스에서 지원하는 API 인증 방식을 확인하세요.


| 서비스 카테고리           | 서비스                                          | User Access Key 토큰 | IaaS 토큰 | User Access Key | Appkey | 프로젝트 통합 Appkey |
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

!!! tip "알아두기"
    <span style="color:red">*</span> Object Storage 서비스는 AWS의 Amazon S3 API와 호환되는 API를 제공합니다. Amazon S3 호환 API를 사용하려면 AWS EC2 형태의 S3 API 자격 증명을 발급해야 합니다. S3 API 자격 증명에 대한 자세한 설명은 [S3 API 자격 증명(S3 API Credential)](https://docs.gov-nhncloud.com/ko/Storage/Object%20Storage/ko/s3-api-guide-gov/#s3-api-s3-api-credential)에서 확인할 수 있습니다.



