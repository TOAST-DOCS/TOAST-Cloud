# Public API Overview

**NHN Cloud > Public API > Public API Overview**

NHN Cloud Public APIs are REST APIs that allow external systems or user applications to control and integrate with NHN Cloud services and resources.

This document provides a comprehensive overview of NHN Cloud Public API usage, including required authentication methods, support status by API, framework APIs, and partner management APIs. It is designed for developers integrating the Public API, service planners seeking to understand authentication methods, and system operators considering API-based automation.


!!! tip "Note"
    * Since API behavior and response formats vary by service, please refer to the specific API guide for each service for more details.
    * Authentication methods vary across Framework APIs, Partner Management APIs, and individual services; some methods are only supported by specific services. You can check the supported authentication methods for each Public API in the [Supported Authentication Methods](https://docs.nhncloud.com/en/nhncloud/en/public-api/supported-authentication-methods) section.

## Getting started with Public API

* [Authentication Overview](https://docs.nhncloud.com/en/nhncloud/en/public-api/auth-method-overview)
* [Supported Authentication Methods](https://docs.nhncloud.com/en/nhncloud/en/public-api/supported-authentication-methods)
* [Service API](https://docs.nhncloud.com/en/nhncloud/en/public-api/service-api)
* [Framework API](https://docs.nhncloud.com/en/nhncloud/en/public-api/framework-api/)
* [Partner Management API Guide](https://docs.nhncloud.com/en/nhncloud/en/public-api/partner-api/)
* [Release Notes](https://docs.nhncloud.com/en/nhncloud/en/public-api/release-notes/)

## Glossary

| Terms | Description |
| --- | --- |
| Public API | A REST API provided by NHN Cloud that enables external systems or user applications to control and integrate with NHN Cloud services and resources. It is a comprehensive concept that encompasses Service APIs, Framework APIs, and Partner Management APIs |
| Service API | An API that enables external systems or user applications to control and integrate with individual NHN Cloud services and their respective resources  |
| Framework API | An API to manage NHN Cloud organizations and projects |
| Partner Management API | API that allows NHN Cloud partners or authorized users to manage organizations, projects, and billing information within the partner cloud, as well as query product metering data |
| Authentication | The process of verifying and validating the identity of a subject |
| Authorization | The process of verifying and granting permissions to an authenticated subject, determining whether they have the right to access specific resources, use certain features, or perform specific actions |
| Bearer token | A type of security token that grants access to anyone in possession of the token | 
| Keystone | A service responsible for authentication and authorization within OpenStack. It ensures secure access to resources by verifying the identities of users and services and granting appropriate permissions |

