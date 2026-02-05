# IaaS Token

**NHN Cloud > Public API > API Authentication Method > IaaS Token**

The IaaS token is an authentication token used for NHN Cloud's OpenStack-based infrastructure services (IaaS). Issued through the Keystone authentication server, these tokens are used to call APIs for controlling infrastructure resources such as Compute, Block Storage, and Network.

## Prerequisites
### Verify API endpoints

The NHN Cloud basic infrastructure service APIs have separate endpoints for each type and region. However, the Identity API uses the same endpoint in all regions.

| Type         | Region                                                 | Endpoint                                             |
| ------------ | ---------------------------------------------------- | ------------------------------------------------------- |
| identity     | All regions                                            | https://api-identity-infrastructure.nhncloudservice.com |
| compute      | Korea (Pangyo) region<br>Korea (Pyeongchon) region<br>Japan (Tokyo) region<br>USA (California) region | https://kr1-api-instance-infrastructure.nhncloudservice.com<br>https://kr2-api-instance-infrastructure.nhncloudservice.com<br>https://jp1-api-instance-infrastructure.nhncloudservice.com<br>https://us1-api-instance-infrastructure.nhncloudservice.com |
| network      | Korea (Pangyo) region<br>Korea (Pyeongchon) region<br>Japan (Tokyo) region<br>USA (California) region | https://kr1-api-network-infrastructure.nhncloudservice.com<br>https://kr2-api-network-infrastructure.nhncloudservice.com<br>https://jp1-api-network-infrastructure.nhncloudservice.com<br>https://us1-api-network-infrastructure.nhncloudservice.com |
| image        | Korea (Pangyo) region<br>Korea (Pyeongchon) region<br>Japan (Tokyo) region<br>USA (California) region | https://kr1-api-image-infrastructure.nhncloudservice.com<br>https://kr2-api-image-infrastructure.nhncloudservice.com<br>https://jp1-api-image-infrastructure.nhncloudservice.com<br>https://us1-api-image-infrastructure.nhncloudservice.com |
| volumev2     | Korea (Pangyo) region<br>Korea (Pyeongchon) region<br>Japan (Tokyo) region<br> | https://kr1-api-block-storage-infrastructure.nhncloudservice.com<br>https://kr2-api-block-storage-infrastructure.nhncloudservice.com<br>https://jp1-api-block-storage-infrastructure.nhncloudservice.com<br>https://us1-api-block-storage-infrastructure.nhncloudservice.com |
| nasv1        | Korea (Pangyo) region<br>Korea (Pyeongchon) region                    | https://kr1-api-nas-infrastructure.nhncloudservice.com<br>https://kr2-api-nas-infrastructure.nhncloudservice.com |
| object-store | Korea (Pangyo) region<br>Korea (Pyeongchon) region<br>Japan (Tokyo) region<br> | https://kr1-api-object-storage.nhncloudservice.com<br>https://kr2-api-object-storage.nhncloudservice.com<br>https://jp1-api-object-storage.nhncloudservice.com<br>https://us1-api-object-storage.nhncloudservice.com |
| key-manager  | Korea (Pangyo) region<br>Korea (Pyeongchon) region<br>Japan (Tokyo) region<br> | https://kr1-api-key-manager-infrastructure.nhncloudservice.com<br>https://kr2-api-key-manager-infrastructure.nhncloudservice.com<br>https://jp1-api-key-manager-infrastructure.nhncloudservice.com<br>https://us1-api-key-manager-infrastructure.nhncloudservice.com |

### Verify Tenant ID

The tenant ID that is included in the API request is found in the **Set API Endpoint** on the **Compute > Instance** page.

### Set the API Password

To use NHN Cloud infrastructure service APIs, you must set an API password separately from your NHN Cloud account password. API passwords are created per account; once set, a password can be used across all projects to which the user belongs.

1) On the **Compute > Instance** page, click **Set API Endpoint**.

![C_IaaS_apiendpointsettings_en](http://static.toastoven.net/toast/public_api/C_IaaS_apiendpointsettings_en.png)

2) Specify the desired API password in **Set the API Password** under **Set API Endpoint** modal pane.

![C_IaaS_setapipassword_0_en](http://static.toastoven.net/toast/public_api/C_IaaS_setapipassword_0_en.png)


!!! tip "Note"
    * You cannot change the password you are currently using.
    * Even if you change your API password, the previously issued authentication token will no longer be available and will need to be reissued.


## Request IaaS Token Issuance

To issue tokens, use the `identity`-type endpoint. The `identity` service endpoint is `https://api-identity-infrastructure.nhncloudservice.com`, which remains the same regardless of the region.<br>
This process issues the tokens required to call APIs. NHN Cloud uses project-scoped tokens.


!!! danger "Caution"
    * If a user loses their permissions within a project, the corresponding credentials will expire and can no longer be used.
    * If you leave NHN Cloud and your account is deleted, all credentials issued to the account will expire and become unavailable.


```
POST /v2.0/tokens
```


### Request

| Name                | Category | Type  | Required | Description                                       |
| ------------------- | ---- | ------ | ---- | ------------------------------------------ |
| tenantId            | Body | String | O    | Target Tenant ID                  |
| passwordCredentials | Body | Object | O    | User information objects for authentication                |
| username            | Body | String	| O    | NHN Cloud account ID (email format), IAM account ID |
| password            | Body | String	| O    | API password                                |

 
<details><summary>Example</summary>
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


### Response

| Name | Type | Property | Description |
|---|---|---|---|
| access | Body | Object | `access` object |
| access.token | Body | Object | `token` object |
| access.token.issued_at | Body | Datetime | Token issuance time (UTC)<br>`YYYY-MM-DDThh:mm:ss.SSSSSS` format |
| access.token.expires | Body | Datetime | Token expiry time (UTC)<br>`YYYY-MM-DDThh:mm:ssZ` format |
| access.token.id | Body | String | Token ID |
| access.token.tenant | Body | Object | `tenant` object |
| access.token.tenant.description | Body | String | Tenant description |
| access.token.tenant.enabled | Body | String | Tenant enabled<br>If not enabled, tokens cannot be issued and API calls cannot be made |
| access.token.tenant.id | Body | String | Tenant ID |
| access.token.tenant.name | Body | String | Tenant name |
| access.serviceCatalog | Body | Object | `serviceCatalog` object |
| access.serviceCatalog.endpoints | Body | Object | `endpoint` object |
| access.serviceCatalog.endpoints_links | Body | String | Endpoint link |
| access.serviceCatalog.type | Body | String | Endpoint service type |
| access.serviceCatalog.name | Body | String | Endpoint service name |
| access.user | Body | Object | `user` object |
| access.metadata | Body | Object | `metadata` object |


<details><summary>Example</summary>
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


## Use IaaS tokens

IaaS tokens are included in the HTTP request header. When calling an API, set the IaaS token in the request header as shown in the example below.

* HTTP header format examples
```
X-Auth-Token: {IaaS Token}
```

When a user sends a request with a token in the HTTP header, the server validates the token and then approves or rejects the request.


