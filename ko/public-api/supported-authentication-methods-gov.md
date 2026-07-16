# 인증 방식 지원 현황

**NHN Cloud > Public API 사용 가이드 > API 인증 방식 > 인증 방식 지원 현황**

NHN Cloud의 Public API는 인증을 위해 User Access Key 토큰, IaaS 토큰, User Access Key, Appkey, 프로젝트 통합 Appkey, S3 API 자격 증명을 지원합니다.
Public API마다 지원하는 인증 방식이 다르며, 일부 인증 방식은 특정 버전에서만 지원합니다.

## 프레임워크 API 및 파트너 관리 API 인증 방식 확인하기

프레임워크 API 및 파트너 관리 API는 인증을 위해 User Access Key 토큰을 사용합니다. User Access Key 토큰 발급 및 API 호출에 대한 자세한 내용은 [User Access Key 토큰](https://docs.gov-nhncloud.com/ko/nhncloud/ko/public-api/user-access-key-token-gov)을 참고하세요.

프레임워크 API 및 파트너 관리 API 사용에 대한 자세한 내용은 각각 [프레임워크 API](https://docs.gov-nhncloud.com/ko/nhncloud/ko/public-api/framework-api-gov/)와 [파트너 관리 API](https://docs.gov-nhncloud.com/ko/nhncloud/ko/public-api/partner-api-gov/)를 참고하세요.


## 서비스 API별 인증 방식 확인하기
사용할 서비스에서 지원하는 API 인증 방식을 확인하세요.
다음 표에는 각 서비스 API가 지원하는 인증 방식이 모두 표시되어 있습니다. API 버전 또는 유형에 따라 지원하는 인증 방식이 다를 수 있으므로 사용 중인 버전의 API 가이드에서 지원하는 인증 방식을 확인하세요.

| 서비스 카테고리           | 서비스                                          | User Access Key 토큰 | IaaS 토큰 | User Access Key | Appkey | 프로젝트 통합 Appkey | S3 API 자격 증명 |
| ----------------------- | ---------------------------------------------- | ------------------ | ------- | --------------- | ------ | -------------- | ------------------ |
| **Compute**             | Instance                                       |                    | O       |                 |        |                |                    |
|                         | GPU Instance                                   |                    | O       |                 |        |                |                    |
|                         | Image                                          |                    | O       |                 |        |                |                    |
|                         | Virtual Desktop                                |                    | O       |                 |        |                |                    |
| **Container**           | NHN Kubernetes Service (NKS)                   |                    | O       |                 |        |                |                    |
|                         | NHN Container Registry (NCR)                   | O                  |         | O               |        |                |                    |
|                         | NHN Container Service (NCS)                    | O                  |         |                 |        |                |                    |
| **Network**             | VPC                                            |                    | O       |                 |        |                |                    |
|                         | Network Interface                              |                    | O       |                 |        |                |                    |
|                         | Routing                                        |                    | O       |                 |        |                |                    |
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
| **Security**            | Security Monitoring                            |                    |         |                 | O      |                |                    |
|                         | Secure Key Manager                             | O                  |         | O               | O      | O              |                    |
|                         | Security Advisor                               |                    |         |                 | O      |                |                    |
| **Content Delivery**    | CDN                                            |                    |         |                 | O      | O              |                    |
| **Machine Learning**    | AI EasyMaker                                   | O                  |         |                 |        |                |                    |
| **Application Service** | API Gateway                                    |                    |         |                 | O      | O              |                    |
| **Data & Analytics**    | Log & Crash Search                             |                    |         |                 | O      |                |                    |
| **Dev Tools**           | Pipeline                                       | O                  |         | O               |        |                |                    |
|                         | Deploy                                         | O                  |         | O               | O      |                |                    |
| **Management**          | Certificate Manager                            | O                  | O       |                 | O      |                |                    |
| **Governance & Audit**  | CloudTrail                                     |                    |         | O               | O      |                |                    |
|                         | Resource Watcher                               |                    |         | O               | O      |                |                    |




