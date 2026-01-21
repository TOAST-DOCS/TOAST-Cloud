# Authentication Overview

**NHN Cloud > Public API > API Authentication Method > Authentication Overview**

Public API는 각 서비스에서 설정한 인증 방식에 따라 요청을 검증한 뒤 API 백엔드로 전달합니다. 이 문서에서는 NHN Cloud Public API에서 사용되는 인증 방식을 설명합니다.

## 인증 방식 비교
NHN Cloud의 Public API는 인증을 위해 User Access Key 토큰, IaaS 토큰, User Access Key, Appkey, 프로젝트 통합 Appkey를 지원하며, 각 인증 방식은 적용 범위, 발급 개수, 만료 여부 등에 차이가 있습니다.

| 인증 방식 | 특징 | 적용 범위 | 발급 개수 제한 | 만료 여부 |
| --- | --- | --- | --- | --- |
| User Access Key 토큰 | 역할/권한 기반 ABAC 인가 | * 인증<br>* 인가 | 제한 없음 | 있음 |
| IaaS 토큰 | * OpenStack 인프라 인증<br>* 프로젝트 권한 반영 | * 인증<br>* 인가 | 제한 없음 | 있음 |
| User Access Key | 계정 기반 인증 | * 인증<br>* 인가(API 버전에 따라 다름) | * NHN Cloud 계정당 최대 5개<br>* IAM 계정당 최대 5개 | 없음 |
| Appkey | 서비스별 고정 키 기반 인증 | 인증 | 서비스당 1개(서비스 활성화 시 자동 생성) | 없음 |
| 프로젝트 통합 Appkey | 프로젝트 단위 통합 인증 | 인증 | 프로젝트당 최대 3개 | 없음 |

!!! tip "알아두기"
    NHN Cloud Object Storage 서비스는 AWS의 Amazon S3 API와 호환되는 API를 제공합니다. Amazon S3 호환 API를 사용하려면 AWS EC2 형태의 S3 API 자격 증명을 발급해야 합니다. S3 API 자격 증명에 대한 자세한 설명은 [S3 API Credentials](https://docs.nhncloud.com/en/Storage/Object%20Storage/en/s3-api-guide/#s3-api-credentials)에서 확인할 수 있습니다. 

NHN Cloud Public API는 API마다 서로 다른 인증 방식을 지원합니다. [Supported Authentication Methods](https://docs.nhncloud.com/en/nhncloud/en/public-api/supported-authentication-methods)에서 각 API가 제공하는 인증 방식을 확인한 뒤, 해당 인증 방식을 사용해 API 요청을 인증하세요.

