<!-- pre-align:aligned sig=2ab3282ba364 -->

# Authentication Overview

**NHN Cloud > Public API User Guide > API Authentication Method > Authentication Overview**

Public APIs validate requests based on the authentication method configured for each service before forwarding them to the API backend. This document describes the authentication methods used for NHN Cloud Public APIs.

<a id="compare-authentication-methods"></a>
## Compare Authentication Methods { #compare-authentication-methods }

NHN Cloud Public APIs support User Access Key tokens, IaaS tokens, User Access Keys, Appkeys, Project Integrated Appkeys, and S3 API Credentials. Each method varies in terms of scope, issuance limits, and expiration policy.

| Authentication Methods | Features | Scope of Application | Issuance Limit | Expiration |
| --- | --- | --- | --- | --- |
| User access key token | Role/privilege-based ABAC authorization | - Authentication<br>- Authorization | No limit | Yes |
| IaaS tokens | - OpenStack infrastructure certification<br>- Reflect project permissions | - Authentication<br>- Authorization | No limit | Yes |
| User access key | Account-based authentication | - Authentication<br>- Authorization (depends on API version) | - Up to 5 per NHN Cloud account<br>- Up to 5 per IAM account | None |
| Appkey | Service-specific static key-based authentication | Authentication | One per service (automatically created when the service is enabled) | None |
| Project integrated Appkey | Project-level integrated authentication | Authentication | Up to 3 per project | None |
| S3 API Credentials | AWS EC2-style static key-based authentication | Authentication | Up to 3 per project | None |


NHN Cloud Public APIs support different authentication methods for each API. After checking the authentication methods provided by each API in [Supported Authentication Methods](https://docs.nhncloud.com/en/nhncloud/en/public-api/supported-authentication-methods), use the corresponding method to authenticate your API requests.

