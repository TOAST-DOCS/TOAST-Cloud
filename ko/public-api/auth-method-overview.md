<!-- pre-align:aligned sig=2ab3282ba364 -->

# 인증 방식 개요

**NHN Cloud > Public API 사용 가이드 > API 인증 방식 > 인증 방식 개요**

Public API는 각 서비스에서 설정한 인증 방식에 따라 요청을 검증한 뒤 API 백엔드로 전달합니다. 이 문서에서는 NHN Cloud Public API에서 사용되는 인증 방식을 설명합니다.

<a id="compare-authentication-methods"></a>
## 인증 방식 비교 { #compare-authentication-methods }

NHN Cloud의 Public API는 인증을 위해 User Access Key 토큰, IaaS 토큰, User Access Key, Appkey, 프로젝트 통합 Appkey, S3 API 자격 증명을 지원하며, 각 인증 방식은 적용 범위, 발급 개수, 만료 여부 등에 차이가 있습니다.

| 인증 방식 | 특징 | 적용 범위 | 발급 개수 제한 | 만료 여부 |
| --- | --- | --- | --- | --- |
| User Access Key 토큰 | 역할/권한 기반 ABAC 인가 | - 인증<br>- 인가 | 제한 없음 | 있음 |
| IaaS 토큰 | - OpenStack 인프라 인증<br>- 프로젝트 권한 반영 | - 인증<br>- 인가 | 제한 없음 | 있음 |
| User Access Key | 계정 기반 인증 | - 인증<br>- 인가(API 버전에 따라 다름) | - NHN Cloud 계정당 최대 5개<br>- IAM 계정당 최대 5개 | 없음 |
| Appkey | 서비스별 고정 키 기반 인증 | 인증 | 서비스당 1개(서비스 활성화 시 자동 생성) | 없음 |
| 프로젝트 통합 Appkey | 프로젝트 단위 통합 인증 | 인증 | 프로젝트당 최대 3개 | 없음 |
| S3 API 자격 증명 | AWS EC2 형식의 고정 키 기반 인증 | 인증 | 사용자별 프로젝트당 최대 3개 | 없음 |



NHN Cloud Public API는 API마다 서로 다른 인증 방식을 지원합니다. [인증 방식 지원 현황](/Support-Status/ko/supported-authentication-methods/)에서 각 API가 제공하는 인증 방식을 확인한 뒤, 해당 인증 방식을 사용해 API 요청을 인증하세요.

