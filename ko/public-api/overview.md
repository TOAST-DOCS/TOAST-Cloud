# Public API 개요

**NHN Cloud > Public API > Public API 개요**

NHN Cloud의 Public API는 NHN Cloud의 서비스와 리소스를 외부 시스템 또는 사용자 애플리케이션에서 제어하거나 연동할 수 있도록 제공하는 REST API입니다.

이 문서는 Public API 호출 시 필요한 인증 방법, Public API별 인증 방식 지원 현황, 프레임워크 API, 파트너 관리 API 등 Public API 활용에 필요한 전반인 내용을 설명합니다. NHN Cloud Public API를 연동하고자 하는 개발자, API 인증 방식을 이해하고자 하는 서비스 기획자, API 기반으로 자동화를 고려하는 시스템 운영자가 이 문서를 활용할 수 있습니다.


!!! tip "알아두기"
    * 서비스마다 API의 동작 방식과 응답 형식이 다르므로 자세한 내용은 각 서비스의 API 가이드를 참고하세요.
    * 프레임워크 API, 파트너 관리 API, 각 서비스마다 지원하는 API 인증 방식이 다르며, 일부 인증 방식은 특정 서비스에서만 지원합니다. 각 Public API별 지원되는 인증 방식은 [인증 방식 지원 현황](https://docs.nhncloud.com/ko/nhncloud/ko/public-api/supported-authentication-methods)에서 확인할 수 있습니다.

## Public API 시작하기

* [인증 방식 개요](https://docs.nhncloud.com/ko/nhncloud/ko/public-api/auth-method-overview)
* [인증 방식 지원 현황](https://docs.nhncloud.com/ko/nhncloud/ko/public-api/supported-authentication-methods)
* [서비스 API](https://docs.nhncloud.com/ko/nhncloud/ko/public-api/service-api)
* [프레임워크 API](https://docs.nhncloud.com/ko/nhncloud/ko/public-api/framework-api/)
* [파트너 관리 API](https://docs.nhncloud.com/ko/nhncloud/ko/public-api/partner-api/)
* [릴리스 노트](https://docs.nhncloud.com/ko/nhncloud/ko/public-api/release-notes/)

## 용어 정리

| 용어 | 설명 |
| --- | --- |
| Public API | NHN Cloud에서 제공하는 REST API로, NHN Cloud 서비스와 리소스를 외부 시스템 또는 사용자 애플리케이션에서 제어하거나 연동할 수 있도록 지원. 서비스 API, 프레임워크 API, 파트너 관리 API를 모두 포함하는 개념 |
| 서비스 API | NHN Cloud에서 제공하는 개별 서비스와 해당 서비스의 리소스를 외부 시스템 또는 사용자 애플리케이션에서 제어하거나 연동할 수 있도록 지원하는 API  |
| 프레임워크 API | NHN Cloud 조직과 프로젝트를 관리하는 API |
| 파트너 관리 API | NHN Cloud 파트너 또는 파트너로부터 권한을 부여 받은 사용자가 파트너 클라우드의 조직과 프로젝트, 빌링 정보 등을 관리하고 상품 미터링을 조회할 수 있는 API |
| 인증(Authentication) | 어떤 주체의 신원을 확인하고 증명함 |
| 인가(Authorization) | 인증을 통해 신원이 확인된 주체에게 특정 리소스나 기능에 접근하거나 동작을 수행할 권한이 있는지 확인하고 허용하는 과정 |
| Bearer 토큰 | 토큰을 소유한 사용자에게 접근 권한을 부여하는 보안 토큰의 유형 | 
| Keystone | OpenStack의 인증 및 권한 부여 작업을 담당하는 서비스. 사용자와 서비스의 신원을 확인하고 적절한 권한을 부여하여 리소스에 대한 안전한 접근을 보장함 |

