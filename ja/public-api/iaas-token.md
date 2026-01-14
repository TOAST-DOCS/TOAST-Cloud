# IaaSトークン

**NHN Cloud > Public API > API認証方式 > IaaSトークン**

IaaS 토큰은 NHN Cloud의 OpenStack 기반 인프라 서비스(IaaS)에서 사용하는 인증 토큰입니다. Keystone 인증 서버를 통해 발급되며 Compute, Block Storage, Network 등 인프라 리소스 제어 API를 호출할 때 사용합니다.

## 사전 작업
### API 엔드포인트 확인

NHN Cloud 기본 인프라 서비스 API는 타입과 리전별로 엔드포인트가 분리되어 있습니다. 단, Identity API는 모든 리전에서 동일한 엔드포인트를 사용합니다.

| 타입         | 리전                                                 | 엔드포인트                                             |
| ------------ | ---------------------------------------------------- | ------------------------------------------------------- |
| identity     | 모든 리전                                            | https://api-identity-infrastructure.nhncloudservice.com |
| compute      | 한국(판교) 리전<br>한국(평촌) 리전<br>일본(도쿄) 리전<br>미국(캘리포니아) 리전 | https://kr1-api-instance-infrastructure.nhncloudservice.com<br>https://kr2-api-instance-infrastructure.nhncloudservice.com<br>https://jp1-api-instance-infrastructure.nhncloudservice.com<br>https://us1-api-instance-infrastructure.nhncloudservice.com |
| network      | 한국(판교) 리전<br>한국(평촌) 리전<br>일본(도쿄) 리전<br>미국(캘리포니아) 리전 | https://kr1-api-network-infrastructure.nhncloudservice.com<br>https://kr2-api-network-infrastructure.nhncloudservice.com<br>https://jp1-api-network-infrastructure.nhncloudservice.com<br>https://us1-api-network-infrastructure.nhncloudservice.com |
| image        | 한국(판교) 리전<br>한국(평촌) 리전<br>일본(도쿄) 리전<br>미국(캘리포니아) 리전 | https://kr1-api-image-infrastructure.nhncloudservice.com<br>https://kr2-api-image-infrastructure.nhncloudservice.com<br>https://jp1-api-image-infrastructure.nhncloudservice.com<br>https://us1-api-image-infrastructure.nhncloudservice.com |
| volumev2     | 한국(판교) 리전<br>한국(평촌) 리전<br>일본(도쿄) 리전<br> | https://kr1-api-block-storage-infrastructure.nhncloudservice.com<br>https://kr2-api-block-storage-infrastructure.nhncloudservice.com<br>https://jp1-api-block-storage-infrastructure.nhncloudservice.com<br>https://us1-api-block-storage-infrastructure.nhncloudservice.com |
| nasv1        | 한국(판교) 리전<br>한국(평촌) 리전                    | https://kr1-api-nas-infrastructure.nhncloudservice.com<br>https://kr2-api-nas-infrastructure.nhncloudservice.com |
| object-store | 한국(판교) 리전<br>한국(평촌) 리전<br>일본(도쿄) 리전<br> | https://kr1-api-object-storage.nhncloudservice.com<br>https://kr2-api-object-storage.nhncloudservice.com<br>https://jp1-api-object-storage.nhncloudservice.com<br>https://us1-api-object-storage.nhncloudservice.com |
| key-manager  | 한국(판교) 리전<br>한국(평촌) 리전<br>일본(도쿄) 리전<br> | https://kr1-api-key-manager-infrastructure.nhncloudservice.com<br>https://kr2-api-key-manager-infrastructure.nhncloudservice.com<br>https://jp1-api-key-manager-infrastructure.nhncloudservice.com<br>https://us1-api-key-manager-infrastructure.nhncloudservice.com |

### 테넌트 ID 확인

API 요청에 포함되는 테넌트 ID는 **Compute > Instance** 페이지의 **API 엔드포인트 설정**에서 확인합니다.

### API 비밀번호 설정

NHN Cloud 기본 인프라 서비스 API를 사용하려면 NHN Cloud 계정 비밀번호와는 별개로 API 비밀번호를 설정해야 합니다. API 비밀번호는 계정별로 생성됩니다. 한 프로젝트에서 설정된 비밀번호는 사용자가 속한 모든 프로젝트에서 사용할 수 있습니다.

1. **Compute > Instance** 페이지의 **API 엔드포인트 설정**을 클릭합니다.<br>
![C_IaaS_apiendpointsettings_ja](http://static.toastoven.net/toast/public_api/C_IaaS_apiendpointsettings_ja.png)
2. **API 엔드포인트 설정** 모달 창 아래의 **API 비밀번호 설정**에 원하는 API 비밀번호를 지정합니다.<br>
![C_IaaS_setapipassword_0_ja](http://static.toastoven.net/toast/public_api/C_IaaS_setapipassword_0_ja.png)

!!! tip "알아두기"
    * 현재 사용 중인 비밀번호로는 변경할 수 없습니다.
    * API 비밀번호 변경 시 기존 인증 토큰은 더 이상 사용할 수 없으며, 재발급이 필요합니다.

## IaaS 토큰 발급 요청하기
토큰 발급은 `identity` 타입 엔드포인트를 이용합니다. `identity` 서비스 엔드포인트는 리전에 관계없이 `https://api-identity-infrastructure.nhncloudservice.com`입니다.<br>
API를 호출할 때 필요한 토큰을 발급합니다. NHN Cloud에서는 프로젝트 한정 토큰(project-scoped token)을 사용합니다.

!!! danger "주의"
   * 사용자가 프로젝트에서 권한을 잃을 경우 해당 자격 증명은 만료되어 사용할 수 없습니다.
   * NHN Cloud를 탈퇴하여 계정이 삭제되는 경우 해당 계정으로 발급한 모든 자격 증명은 만료되어 사용할 수 없습니다.

```
POST /v2.0/tokens
```

### 요청

| 이름                | 구분 | 타입  | 필수 | 설명                                       |
| ------------------- | ---- | ------ | ---- | ------------------------------------------ |
| tenantId            | Body | String | O    | 토큰을 발급 받을 테넌트 ID                  |
| passwordCredentials | Body | Object | O    | 인증을 위한 사용자 정보 객체                |
| username            | Body | String	| O    | NHN Cloud 계정 ID(이메일 형식), IAM 계정 ID |
| password            | Body | String	| O    | API 비밀번호                                |

 
<details><summary>예시</summary>
<p>

```json
{
    "auth": {
        "tenantId": "f5073eaa26b64cffbee89411df94ce01",
        "passwordCredentials": {
            "username": "user@example.com",
            "password": "secretsecret"
        }
    }
}
```

</p>
</details>

### 응답

| 이름 | 종류 | 속성 | 설명 |
|---|---|---|---|
| access | Body | Object | `access` 객체 |
| access.token | Body | Object | `token` 객체 |
| access.token.issued_at | Body | Datetime | 토큰 발급 시간(UTC)<br>`YYYY-MM-DDThh:mm:ss.SSSSSS`의 형태 |
| access.token.expires | Body | Datetime | 토큰 만료 시간(UTC)<br>`YYYY-MM-DDThh:mm:ssZ`의 형태 |
| access.token.id | Body | String | 토큰 ID |
| access.token.tenant | Body | Object | `tenant` 객체 |
| access.token.tenant.description | Body | String | 테넌트 설명 |
| access.token.tenant.enabled | Body | String | 테넌트의 활성화 여부<br>활성화되지 않으면 토큰 발급 및 API 호출 불가 |
| access.token.tenant.id | Body | String | 테넌트 ID |
| access.token.tenant.name | Body | String | 테넌트 이름 |
| access.serviceCatalog | Body | Object | `serviceCatalog` 객체 |
| access.serviceCatalog.endpoints | Body | Object | `endpoint` 객체 |
| access.serviceCatalog.endpoints_links | Body | String | 엔드포인트 링크 |
| access.serviceCatalog.type | Body | String | 엔드포인트 서비스 타입 |
| access.serviceCatalog.name | Body | String | 엔드포인트 서비스 이름 |
| access.user | Body | Object | `user` 객체 |
| access.metadata | Body | Object | `metadata` 객체 |


<details><summary>예시</summary>
<p>

```json
{
  "access": {
    "token": {
      "id": "e42a092ed6ee4d99949bf25f5f6ecc60",
      "expires": "2020-04-29T15:31:21Z",
      "tenant": {
        "id": "f5073eaa26b64cffbee89411df94ce01",
        "name": "c_VKkasVsh",
        "groupId": "XEj2zkHrbA7modGU",
        "description": "",
        "enabled": true,
        "project_domain": "NORMAL"
      },
      "issued_at": "2020-04-29T03:32:28.000405"
    },
    "serviceCatalog": [
      {
        "endpoints": [
          {
            "region": "KR2",
            "publicURL": "https://kr2-api-instance-infrastructure.nhncloudservice.com/v2/f5073eaa26b64cffbee89411df94ce01"
          },
          {
            "region": "KR1",
            "publicURL": "https://kr1-api-instance-infrastructure.nhncloudservice.com/v2/f5073eaa26b64cffbee89411df94ce01"
          }
        ],
        "type": "compute",
        "name": "nova"
      },
      {
        "endpoints": [
          {
            "region": "KR2",
            "publicURL": "https://kr2-api-image-infrastructure.nhncloudservice.com"
          },
          {
            "region": "KR1",
            "publicURL": "https://kr1-api-image-infrastructure.nhncloudservice.com"
          }
        ],
        "type": "image",
        "name": "glance"
      },
      {
        "endpoints": [
          {
            "region": "KR1",
            "publicURL": "https://api-identity-infrastructure.nhncloudservice.com/v2.0"
          }
        ],
        "type": "identity",
        "name": "keystone"
      },
      {
        "endpoints": [
          {
            "region": "KR2",
            "publicURL": "https://kr2-api-key-manager-infrastructure.nhncloudservice.com"
          },
          {
            "region": "KR1",
            "publicURL": "https://kr1-api-key-manager-infrastructure.nhncloudservice.com"
          }
        ],
        "type": "key-manager",
        "name": "barbican"
      },
      {
        "endpoints": [
          {
            "region": "KR2",
            "publicURL": "https://kr2-api-block-storage-infrastructure.nhncloudservice.com/v2/f5073eaa26b64cffbee89411df94ce01"
          },
          {
            "region": "KR1",
            "publicURL": "https://kr1-api-block-storage-infrastructure.nhncloudservice.com/v2/f5073eaa26b64cffbee89411df94ce01"
          }
        ],
        "type": "volumev2",
        "name": "cinderv2"
      },
      {
        "endpoints": [
          {
            "region": "KR2",
            "publicURL": "https://kr2-api-network-infrastructure.nhncloudservice.com"
          },
          {
            "region": "KR1",
            "publicURL": "https://kr1-api-network-infrastructure.nhncloudservice.com"
          }
        ],
        "type": "network",
        "name": "neutron"
      }
    ],
    "user": {
      "id": "436f727b7c9142f896ddd56be591dd7f",
      "username": "37be6ac0-d660-11e7-ae46-005056ac1497",
      "name": "37be6ac0-d660-11e7-ae46-005056ac1497",
      "roles": [
        {
          "name": "project_admin"
        }
      ],
      "roles_links": []
    },
    "metadata": {
      "roles": [
        "9fe2ff9ee4384b1894a90878d3e92bab"
      ],
      "is_admin": 0
    }
  }
}
```

</p>
</details>


## IaaS 토큰 사용하기

IaaS 토큰은 HTTP 요청 헤더에 포함해 전달합니다. API 호출 시 아래 예시와 같이 요청 헤더에 IaaS 토큰을 설정해 호출하세요.

* HTTP 헤더 형식 예시

```
X-Auth-Token: {IaaS Token}
```

사용자가 HTTP 헤더에 토큰을 담아 서버에 요청을 보내면 서버가 토큰의 유효성을 확인한 뒤 요청을 승인하거나 거부합니다.


