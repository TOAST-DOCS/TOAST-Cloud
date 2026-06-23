# Framework API

**NHN Cloud > Public API User Guide > Framework API**

## Overview
The following APIs allow you to manage your organization and projects, such as creating project members and assigning roles.
Framework APIs use User Access Key tokens for authentication/authorization when making API calls. A User Access Key token is a temporary access token of the Bearer type that is issued based on a User Access Key. For more information on issuing and using User Access Key tokens, please refer to the [User Access Key Token](/nhncloud/en/public-api/user-access-key-token).

<a id="public-api-domain"></a>

### Public API Domain
`https://core.api.nhncloudservice.com/`

<a id="common"></a>

### Common

<a id="request"></a>

#### Request
When calling the Public API, you must include the following Request Header.


| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
| Header |  x-nhn-authorization | String| Yes | Bearer-type token issued to the user |

<a id="response"></a>

#### Response
When the Public API returns a response, the following header is included in the response body.
```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   isSuccessful | Boolean | No | Success  |
|   resultCode | Integer| No | Result code. Returns 0 on success, or an error code on failure.  |
|   resultMessage | String| No | Result message  |

<a id="common-types"></a>

#### Common Types
<a id="공통-타입"></a>


| Name | Type | Size | Description | 
|------------ | ------------- | ------------- | ------------ |
| org-id | String | 16 characters | Organization ID |
| project-id | String | 8 characters | Project ID |
| product-id | String | 8 characters | Service ID |
| user-access-key-id | String | 20 characters | User Access Key ID |
| project-app-key | String | 20 characters | App key for the project |
| product-app-key | String | 16 characters | App key for the service |
| uuid | String | 36 characters | Member UUID |


!!! danger "Caution"
    * If you configure IP ACL through **Organization Management > Governance Settings > Organization Governance Settings > IP ACL Settings**, the configuration is also applied when calling Framework APIs.


<a id="api"></a>

### API


!!! danger "Caution"
    Responses from the API can have fields added that are not specified in the guide, so they should be developed so that new fields added do not cause errors. Also, when saving the DB, the column size may change, so you should set it generously.


| Method | HTTP Request | Description |
|------------- | ------------- | -------------|
| POST |[/v1/projects/{project-id}/members](#create-project-member) | Create project member |
| POST |[/v1/organizations/{org-id}/projects](#add-project) | Add project |
| DELETE |[/v1/projects/{project-id}/members/{target-uuid}](#delete-a-single-project-member) | Delete a single project member |
| DELETE |[/v1/projects/{project-id}](#delete-a-project) | Delete project |
| DELETE |[/v1/projects/{project-id}/products/{product-id}/disable](#disable-project-service) | Disable project service |
| POST |[/v1/projects/{project-id}/products/{product-id}/enable](#enable-service-for-project) | Enable project service |
| GET |[/v1/organizations/{org-id}/roles](#list-organization-roles) | List organization roles |
| GET |[/v1/projects/{project-id}/roles](#list-project-roles) | List project roles |
| GET |[/v1/organizations/{org-id}/domains](#search-organization-domains) | Search organization domains |
| GET |[/v1/organizations/{org-id}/members/{member-uuid}](#get-organization-member) | Get a single organization member |
| POST |[/v1/organizations/{org-id}/members/search](#list-organization-members) | List organization members |
| GET |[/v1/organizations/{org-id}/project-role-groups](#view-all-common-role-groups-for-projects-in-the-organization) | List all project common role groups in an organization |
| GET |[/v1/product-uis/hierarchy](#get-service-hierarchy) | Retrieve service hierarchy |
| GET |[/v1/projects/{project-id}/products/{product-id}](#get-service-used-by-project) | Retrieve services in use in a project |
| GET |[/v1/projects/{project-id}/members/{member-uuid}](#get-project-member) | Get a single project member |
| POST |[/v1/projects/{project-id}/members/search](#list-project-members) | List project members |
| GET |[/v1/projects/{project-id}/project-role-groups/{role-group-id}](#get-project-role-group) | Get a single project role group |
| GET |[/v1/organizations/{org-id}/project-role-groups/{role-group-id}](#view-a-common-role-group-for-the-project-in-the-organization) | Get a single project common role group in an organization |
| GET |[/v1/projects/{project-id}/project-role-groups](#list-all-project-role-groups) | List all project role groups |
| GET |[/v1/organizations/{org-id}/projects](#list-projects-in-organization) | List projects in an organization |
| GET |[/v1/organizations/{org-id}/governances](#list-organization-governance-in-use) | List organization governances in use |
| POST |[/v1/organizations/{org-id}/project-role-groups](#create-a-common-role-group-for-projects-in-the-organization) | Create project common role group in an organization |
| DELETE |[/v1/organizations/{org-id}/project-role-groups](#delete-a-project-common-role-group-in-the-organization) | Delete project common role groups in an organization |
| PUT |[/v1/organizations/{org-id}/project-role-groups/{role-group-id}/infos](#modify-your-organizations-project-common-role-group-information) | Modify project common role group information in an organization |
| PUT |[/v1/organizations/{org-id}/project-role-groups/{role-group-id}/roles](#modify-your-organizations-project-common-roles-group-roles) | Modify roles in a project common role group in an organization |
| POST |[/v1/projects/{project-id}/project-role-groups](#create-project-role-group) | Create project role group |
| DELETE |[/v1/projects/{project-id}/project-role-groups](#delete-project-role-group) | Delete project role groups |
| PUT |[/v1/projects/{project-id}/project-role-groups/{role-group-id}/infos](#edit-project-role-group-information) | Modify project role group information |
| PUT |[/v1/projects/{project-id}/project-role-groups/{role-group-id}/roles](#modify-project-role-group-roles) | Modify roles in a project role group |
| GET |[/v1/organizations/{org-id}/org-role-groups](#list-all-organization-role-groups) | List all organization role groups |
| GET |[/v1/organizations/{org-id}/org-role-groups/{role-group-id}](#get-an-organization-role-group) | Get a single organization role group |
| POST |[/v1/organizations/{org-id}/org-role-groups](#create-organization-role-group) | Create organization role group |
| DELETE |[/v1/organizations/{org-id}/org-role-groups](#delete-organization-role-group) | Delete organization role groups |
| PUT |[/v1/organizations/{org-id}/org-role-groups/{role-group-id}/infos](#modify-organization-role-group-information) | Modify organization role group information |
| PUT |[/v1/organizations/{org-id}/org-role-groups/{role-group-id}/roles](#modify-organization-role-group-roles) | Modify roles in an organization role group |
| PUT |[/v1/organizations/{org-id}/members/{member-uuid}](#modify-organization-member-role) | Modify organization member roles |
| PUT |[/v1/projects/{project-id}/members/{member-uuid}](#modify-project-member-role) | Modify project member roles |
| GET |[/v1/iam/organizations/{org-id}/members/{member-uuid}](#get-organization-iam-account) | Get a single organization IAM account |
| GET |[/v1/iam/organizations/{org-id}/members](#list-organization-iam-accounts) | List organization IAM accounts |
| POST |[/v1/iam/organizations/{org-id}/members](#add-organization-iam-account) | Add organization IAM account |
| POST |[/v1/iam/organizations/{org-id}/members/{member-id}/send-password-setup-mail](#send-iam-account-password-change-email) | Send IAM account password change email |
| PUT |[/v1/iam/organizations/{org-id}/members/{member-uuid}](#modify-organization-iam-account) | Modify organization IAM account information |
| POST |[/v1/iam/organizations/{org-id}/members/{member-id}/set-password](#change-organization-iam-account-password) | Change organization IAM account password |
| GET |[/v1/iam/organizations/{org-id}/settings/session](#view-organization-iam-account-sign-in-session-settings-information) | View organization IAM sign-in session settings information |
| GET |[/v1/iam/organizations/{org-id}/settings/security-mfa](#view-settings-for-organizational-iam-account-login-two-factor-authentication) | View settings for organizational IAM sign-in second factor authentication |
| GET |[/v1/iam/organizations/{org-id}/settings/security-login-fail](#view-organization-iam-account-login-failure-security-settings) | View Organization IAM Login Failure Security Settings |
| GET |[/v1/iam/organizations/{org-id}/settings/password-rule](#get-organization-iam-account-password-policy) | Retrieve organization IAM account password policy |
| GET |[/v1/organizations/{org-id}/products/ip-acl](#list-organization-ip-acls) | List organization IP ACLs |
| POST |[/v1/billing/contracts/basic/products/prices/search](#get-service-prices-registered-in-pay-as-you-go) | Retrieve service prices registered under the pay-as-you-go plan |
| GET |[/v1/billing/contracts/basic/products](#list-services-registered-for-pay-as-you-go) | List services registered under the pay-as-you-go plan |
| GET | [/v1/authentications/projects/{project-id}/project-appkeys](#list-project-integrated-appkeys) | Retrieve project integrated Appkey |
| GET |[/v1/authentications/user-access-keys](#list-user-access-key-ids) | List User Access Key IDs |
| POST | [/v1/authentications/projects/{project-id}/project-appkeys](#register-a-project-integrated-appkey) | Register project integrated Appkey |
| POST |[/v1/authentications/user-access-keys](#register-user-access-key-id) | Register User Access Key ID |
| DELETE | [/v1/authentications/projects/{project-id}/project-appkeys/{app-key}](#delete-project-integrated-appkey) | Delete project integrated Appkey |
| PUT |[/v1/authentications/user-access-keys/{user-access-key-id}/secretkey-reissue](#reissue-the-user-access-key-id-secret-key) | Reissue the User Access Key ID secret key |
| PUT |[/v1/authentications/user-access-keys/{user-access-key-id}](#modify-user-access-key-id-status) | Modify User Access Key ID status |
| DELETE |[/v1/authentications/user-access-keys/{user-access-key-id}](#delete-a-user-access-key-id) | Delete User Access Key ID |
| GET    | [/v1/authentications/user-access-keys/{user-access-key-id}/tokens](#list-tokens) | List tokens |
| DELETE | [/v1/authentications/user-access-keys/{user-access-key-id}/tokens](#expire-multiple-tokens) | Expire multiple tokens |
| POST |[/v1/iam/projects/{project-id}/members](#create-project-iam-account) | Create project IAM account |
| DELETE |[/v1/iam/projects/{project-id}/members](#delete-multiple-project-iam-accounts) | Delete multiple project IAM accounts |
| GET |[/v1/iam/projects/{project-id}/members/{member-uuid}](#get-project-member) | Get a single project IAM account |
| GET |[/v1/iam/projects/{project-id}/members](#list-project-iam-accounts) | List project IAM accounts |
| PUT |[/v1/iam/projects/{project-id}/members/{member-uuid}](#modify-project-iam-account-role) | Modify project IAM account roles |
| GET |[/v1/authentications/organizations/{org-id}/user-access-keys](#view-all-credentials-of-members-under-organizations) | List authentication credentials of organization sub-members |
| GET | [/v1/organizations](#list-my-organizations) | List your organizations |
| POST | [/v1/organizations](#add-your-own-organization) | Add your organization |
| DELETE | [/v1/organizations/{org-id}](#delete-organization) | Delete a single organization |
| GET | [/v1/products](#list-service-information) | List service information |
| GET | [/v1/messages/role](#list-role-multilingual-descriptions) | Retrieve multilingual role descriptions |



<a id="create-project-member"></a>

#### Create Project Member

> POST "/v1/projects/{project-id}/members"

API to add a member to a project.

##### Required Permissions
`Project.Member.Create`

##### Request Parameters



| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | Project ID to add a member to | 
| Request Body | request | CreateMemberRequest| Yes | Request |




###### CreateMemberRequest


!!! danger "Caution"
    At least one of memberUuid, email, and userCode must have a value when requested.<br>The system checks for a value in the order of memberUuid > email > userCode, and adds the member as a project member if a value is found.<br>Only one project member can be created in a request.


| Name | Type | Required | Description |  
|------------ | ------------- | ------------- | ------------ |
|   assignRoles | List&lt;UserAssignRoleProtocol>| Yes | List of roles to assign to the user  |
|   memberUuid | String| No | UUID of the member to add  |
|   email | String| No | Email of the member to add  |
|   userCode | String| No | IAM account ID to add  |


###### UserAssignRoleProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   roleId | String| Yes | Role ID  |
|   conditions | List&lt;AssignAttributeConditionProtocol>| No | Role condition attributes  |


###### AssignAttributeConditionProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   attributeId | String| Yes | Condition attribute ID  |
|   attributeOperatorTypeCode | String| Yes | Condition attribute operator<br>Available operators vary depending on the conditional attribute data type<br><ul><li>ALLOW</li><li>ALL_CONTAINS</li><li>ANY_CONTAINS</li><li>ANY_MATCH</li><li>BETWEEN</li><li>BEYOND</li><li>FALSE</li><li>GREATER_THAN</li><li>GREATER_THAN_OR_EQUAL_TO</li><li>LESS_THAN</li><li>LESS_THAN_OR_EQUAL_TO</li><li>NONE_MATCH</li><li>NOT_ALLOW</li><li>NOT_CONTAINS</li><li>TRUE</li></ul>  |
|   attributeValues | List&lt;String>| Yes | Condition attribute values  |


##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### Response


| Name | Type           | Required | Description |   
|------------ |--------------| ------- | ------------ |
|   header | [Common Response](#response) | Yes |


<a id="add-project"></a>

#### Add Project

> POST "/v1/organizations/{org-id}/projects"

Adds a project to an organization.

##### Required Permissions
`Organization.Project.Create`

##### Request Parameters



| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
| Path | org-id | String | Yes | Organization ID to add the project to | 
| Request Body | request | CreateProjectRequest | Yes | Request |


###### CreateProjectRequest


| Name | Type | Required | Description |   
|------------ | ------------- | ------ | ------------ |
|   description | String | No | Project description (up to 100 characters) |
|   projectName | String | Yes | Project name (up to 40 characters) |


##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  },
  "project": {
    "regDateTime": "2000-01-23T04:56:07.000+00:00",
    "description": "description",
    "projectName": "projectName",
    "projectId": "projectId",
    "orgId": "orgId",
    "projectStatusCode": "STABLE"
  }
}
```
###### Response

| Name | Type | Required | Description |   
|------------ | ------------- | --------- | ------------ |
|   header | [Common response](#response) | Yes  |
|   regDateTime | Date | Yes   | Project creation date and time | 
|   description | String | No   | Project description | 
|   ownerId | String | Yes   | Project owner member ID | 
|   projectName | String | Yes   | Project name | 
|   projectId | String | Yes   | Project ID | 
|   orgId | String | Yes   | Organization ID | 
|   projectStatusCode | String | Yes   | Project status<br><ul><li>STABLE: The project is in normal use.</li><li>CLOSED: The payment has been made and the project is well closed.</li><li>BLOCKED: The project has been blocked by an administrator.</li><li>TERMINATED: All resources have been deleted due to overdue payment.</li><li>DISABLED: All services are closed but the payment has not been made.</li></ul> | 


<a id="delete-a-single-project-member"></a>

#### Delete a Single Project Member

> DELETE "/v1/projects/{project-id}/members/{target-uuid}"

API to delete a user from a project.

##### Required Permissions
`Project.Member.Delete`

##### Request Parameters



| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | Project ID | 
|  Path |target-uuid | String| Yes | Member UUID to delete | 




##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### Response


| Name | Type | Required | Description |   
|------------ | ------------- | ------- | ------------ |
|   header | [Common Response](#response)| Yes |



<a id="delete-a-project"></a>

#### Delete a Project

> DELETE "/v1/projects/{project-id}"

API to delete a project.

##### Required Permissions
You'll need one permission from the list below
* `Organization.Project.Delete`
* `Project.Delete`

##### Request Parameters



| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | Project ID to delete | 






##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### Response


| Name | Type | Required | Description |   
|------------ | ------------- | ------- | ------------ |
|   header | [Common Response](#response)| Yes |



<a id="disable-project-service"></a>

#### Disable Project Service

> DELETE "/v1/projects/{project-id}/products/{product-id}/disable"

API to disable a user-specified service so that it is no longer used by this project.

##### Required Permissions
`ServiceName:Product.Delete`

##### Request Parameters


| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | ID of the project for which to disable the service | 
|  Path |product-id | String| Yes | Service ID | 





##### Response Body

```json
{
  "childProducts": [ {
    "productId": "productId",
    "productName": "productName",
    "statusCode": "STABLE"
  } ],
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### Response


| Name | Type | Required | Description |   
|------------ | ------------- | ------- | ------------ |
|   header | [Common Response](#response)| Yes |
|   childProducts | List&lt;ChildProduct>| No   | Subservice information for that service, not included if there are no subservices.<br>Requires you to disable the child service first and then disable the service.|

###### ChildProduct


| Name | Type | Required | Description |   
|------------ | ------------- | --------- | ------------ |
|   productId | String| Yes  | 	Child service ID | 
|   productName | String| Yes  | Child service name |
|   statusCode | String| Yes |   Service status (STABLE, CLOSED) |


<a id="enable-service-for-project"></a>

#### Enable Service for Project

> POST "/v1/projects/{project-id}/products/{product-id}/enable"

This API requests activation to enable a service specified by the user in the project.

##### Required Permissions
`서비스명:Product.Create`

##### Request Parameters



| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |product-id | String| Yes | Service ID | 
|  Path |project-id | String| Yes | ID of the project for which to enable the service | 


##### Response Body

```json
{
  "secretKey": "secretKey",
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  },
  "appKey": "appKey",
  "parentProduct": {
    "productId": "productId",
    "productName": "productName",
    "statusCode": "STABLE"
  }
}
```

###### Response


| Name | Type | Required | Description |   
|------------ | ------------- | ------- | ------------ |
|   header | [Common Response](#response)| Yes |
|   appKey | String| Yes | AppKey information for the service your project is using|
|   parentProduct | ParentProduct| No | Shows parent service information if it exists, or does not include it if no parent service exists |
|   secretKey | String| No| Secret key information for the service your project is using<br> Provided only for services that use a secret key |


###### ParentProduct


| Name | Type | Required | Description |   
|------------ | ------------- | --------- | ------------ |
|   productId | String| Yes  | Service ID |
|   productName | String| Yes  | Service name |
|   statusCode | String| Yes | The service's usage status (STABLE, CLOSED) |





<a id="list-organization-roles"></a>

#### List Organization Roles

> GET "/v1/organizations/{org-id}/roles"

API to request a list of roles that can be granted to users in your organization.

##### Required Permissions
`Organization.RoleGroup.List`

##### Request Parameters



| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | Organization ID |
|  Query |categoryTypeCodes | List&lt;String> | No | Role/Permission/Role Group Category Distinction (ROLE, PERMISSION, ROLE_GROUP) |
|  Query |roleNameLike | String| No | Role/permission/role group name |
|  Query |limit | Integer| No | Number of items per page; default is 20 | 
|  Query |page | Integer| No | Target page; default is 1 |



##### Response Body

```json
{
  "roles": [ {
    "roleId": "roleId",
    "roleName": "roleName",
    "categoryKey": "categoryKey",
    "description": "description",
    "roleCategory": "ORG_ROLE",
    "categoryTypeCode": "ORG_ROLE_GROUP"
  }],
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  },
  "totalCount": 0
}
```



###### Response


| Name | Type | Required | Description |   
|------------ | ------------- | ------- | ------------ |
|   header | [Common Response](#response)| Yes |
|   roles | List&lt;RoleProtocol>| Yes  | Role list |
|   totalCount | Integer| Yes  | Total count |

###### RoleProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   categoryKey | String| Yes | Role/privilege category classification key<br><ul><li>RoleGroup: Project role group</li><li>OrgRoleGroup: Organization role group</li><li>OrgRole: Organization role</li><li>ProjectRole: Project role</li><li>BillingRole: Billing-related role</li><li>OrgServiceRole: Organization service role</li><li>ProjectServiceRole: Project service role</li><li>SystemRole: System-generated role</li></ul>  |
|   categoryTypeCode | String| Yes | Role group/role/privilege distinguishing codes (ORG_ROLE_GROUP, PERMISSION, ROLE, ROLE_GROUP, SYSTEM) |
|   description | String| Yes | Role/privilege description  |
|   roleCategory | String| Yes | Role/Privilege Category Broad Classification (ORG_ROLE, ORG_ROLE_GROUP, ORG_SERVICE_ROLE, PROJECT_ROLE, PROJECT_ROLE_GROUP, PROJECT_SERVICE_ROLE, SYSTEM_ROLE) |
|   roleId | String| Yes | Role/privilege ID  |
|   roleName | String| Yes | Role/privilege name  |


<a id="list-project-roles"></a>

#### List Project Roles

> GET "/v1/projects/{project-id}/roles"

API to request a list of roles that can be granted to project users.

##### Required Permissions
`Project.RoleGroup.List`

##### Request Parameters


| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | Project ID | 
|  Query |categoryTypeCodes | List&lt;String> | No | Role/Permission/Role Group Category Distinction (ROLE, PERMISSION, ROLE_GROUP) |
|  Query |roleNameLike | String| No | Role/permission/role group name |
|  Query |limit | Integer| No | Number of items per page, default 20 | 
|  Query |page | Integer| No | Target page, default 1 |


##### Response Body

```json
{
  "roles": [ {
    "roleId": "roleId",
    "roleName": "roleName",
    "categoryKey": "categoryKey",
    "description": "description",
    "roleCategory": "ORG_ROLE",
    "categoryTypeCode": "ORG_ROLE_GROUP"
  }],
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  },
  "totalCount": 0
}
```


###### Response


| Name | Type | Required | Description |   
|------------ | ------------- | ------- | ------------ |
|   header | [Common Response](#response)| Yes |
|   roles | List&lt;[RoleProtocol](#roleprotocol)>| Yes  | Role list |
|   totalCount | Integer| Yes  | Total count |

<a id="search-organization-domains"></a>

#### Search Organization Domains

> GET "/v1/organizations/{org-id}/domains"

API to look up domains for a specific organization.

##### Required Permissions
`Organization.Domain.List`

##### Request Parameters



| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | ID of the organization to look up | 




##### Response Body

```json
{
  "domainList": [
    {
      "domainId": "string",
      "domainName": "string"
    }
  ],
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "string"
  }
}
```

###### Response


| Name | Type | Required | Description |   
|------------ | ------------- | ------- | ------------ |
|   header | [Common Response](#response)| Yes |
|   domainList | List&lt;OrgDomainProtocol>| Yes  |


###### OrgDomainProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | --------- | ------------ |
|   orgDomainId | String| Yes | Organization domain ID |
|   orgDomainName | String| Yes | Organization domain name |


<a id="get-organization-member"></a>

#### Get Organization Member

> GET "/v1/organizations/{org-id}/members/{member-uuid}"

Retrieves a member belonging to the organization.

##### Required Permissions
`Organization.Member.Get`

##### Request Parameters



| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | Organization ID from which to retrieve the member | 
|  Path |member-uuid | String| Yes | 	UUID of the member to retrieve | 





##### Response Body

```json
{
  "orgMember": {
    "memberUuid": "memberUuid",
    "roleId": "roleId",
    "memberTypeCode": "memberTypeCode",
    "roles": [ {
      "regDateTime": "2000-01-23T04:56:07.000+00:00",
      "roleApplyPolicyCode": "ALLOW",
      "roleId": "roleId",
      "roleName": "roleName",
      "categoryKey": "categoryKey",
      "description": "description",
      "categoryTypeCode": "ORG_ROLE_GROUP",
      "conditions": [ {
        "attributeId": "attributeId",
        "attributeOperatorTypeCode": "ALLOW",
        "attributeValues": [ "attributeValues", "attributeValues" ],
        "attributeDescription": "attributeDescription",
        "attributeName": "attributeName",
        "attributeDataTypeCode": "BOOLEAN"
      }]
    }],
    "inviteStatusCode": "COMPLETE",
    "memberName": "memberName",
    "recentPasswordModifyYmdt": "2000-01-23T04:56:07.000+00:00",
    "recentLoginYmdt": "2000-01-23T04:56:07.000+00:00",
    "roleCode": "roleCode",
    "secondFactorCertificationYn": "secondFactorCertificationYn",
    "id": "id",
    "joinYmdt": "2000-01-23T04:56:07.000+00:00",
    "email": "email"
  },
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### Response


| Name | Type | Required | Description |   
|------------ | ------------- | ------- | ------------ |
|   header | [Common Response](#response)| Yes |
|   orgMember | OrgMemberRoleBundleProtocol| No  | Member information; not included on error |

###### OrgMemberRoleBundleProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ----- | ------------ |
|   email | String| Yes | Member email |
|   id | String| No | Member ID (available for IAM accounts only) |
|   inviteStatusCode | String| Yes |   COMPLETE, EXPIRE, UNKNOWN, WAIT |
|   joinYmdt | Date| Yes | Date and time the organization member was registered |
|   memberName | String| Yes| 	Member name |
|   memberTypeCode | String| Yes| Account type (TOAST_CLOUD: NHN Cloud account, IAM: IAM account) |
|   memberUuid | String| Yes| Member UUID |
|   recentLoginYmdt | Date| Yes| Date and time of last sign-in |
|   recentPasswordModifyYmdt | Date| No| Date and time of last password change |
|   roleCode | String| No| Role ID |
|   roles | List&lt;RoleBundleProtocol>| No | List of associated roles (including condition attributes)  |
|   secondFactorCertificationYn | String| No| Whether two-step sign-in is configured (available for NHN Cloud accounts only) |


###### RoleBundleProtocol
| Name | Type | Required | Description |   
|------------ | ------------- | ----- | ------------ |
|   roleId | String| Yes |  Role ID |
|   roleName | String| Yes |  Role name |
|   description | String| No |  Role description |
|   categoryKey | String| Yes | Role/permission category classification key<br><ul><li>RoleGroup: Project role group</li><li>OrgRoleGroup: Organization role group</li><li>OrgRole: Organization role</li><li>ProjectRole: Project role</li><li>BillingRole: Billing-related role</li><li>OrgServiceRole: Organization service role</li><li>ProjectServiceRole: Project service role</li><li>SystemRole: System-generated role</li></ul>  |
|   categoryTypeCode | String| Yes | Role group/role/privilege distinguishing codes (ORG_ROLE_GROUP, PERMISSION, ROLE, ROLE_GROUP, SYSTEM) |
|   conditions | List&lt;AttributeConditionProtocol>| No | List of condition attributes |
|   roleApplyPolicyCode | String| Yes | Whether the role is applied: ALLOW, DENY |
|   regDateTime | Date| Yes |  Date and time the role was created |



###### AttributeConditionProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ----- | ------------ |
|   attributeDataTypeCode | String| Yes |  Conditional attribute data type (BOOLEAN, DATETIME, DAY_OF_WEEK, IPADDRESS, NUMERIC, STRING, TIME) |
|   attributeDescription | String| No | Condition attribute description |
|   attributeId | String| Yes | Condition attribute ID |
|   attributeName | String| Yes | Condition attribute name |
|   attributeOperatorTypeCode | String| Yes | Condition attribute operator<br>Available operators vary depending on the conditional attribute data type<br><ul><li>ALLOW</li><li>ALL_CONTAINS</li><li>ANY_CONTAINS</li><li>ANY_MATCH</li><li>BETWEEN</li><li>BEYOND</li><li>FALSE</li><li>GREATER_THAN</li><li>GREATER_THAN_OR_EQUAL_TO</li><li>LESS_THAN</li><li>LESS_THAN_OR_EQUAL_TO</li><li>NONE_MATCH</li><li>NOT_ALLOW</li><li>NOT_CONTAINS</li><li>TRUE</li></ul> |
|   attributeValues | List&lt;String>| Yes| Condition attribute value |



<a id="list-organization-members"></a>

#### List Organization Members

> POST "/v1/organizations/{org-id}/members/search"

API to get a list of NHN Cloud members that belong to this organization.

##### Required Permissions
`Organization.Member.List`

##### Request Parameters



| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | Organization ID | 
| Request Body | request | SearchOrgMembersRequest| Yes | Request |


###### SearchOrgMembersRequest


| Name | Type | Required | Description |   
|------------ | ------------- | --------- | ------------ |
|   memberStatusCodes | List&lt;String>| No | Status of members to retrieve<br><ul><li>STABLE: Invitation complete</li><li>INVITED: Invitation in progress</li><li>BLOCKED</li><li>NOT_EXIST</li><li>WITHDRAW</li></ul> |
|   roleIds | Set&lt;String>| No  | Role IDs assigned to the members |
|   paging | PagingBean| No  |

###### PagingBean


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   limit | Integer| No | Number of items per page, default: 20  |
|   page | Integer| No | Target page, default: 1  |




##### Response Body

```json
{
  "orgMembers": [ {
    "memberUuid": "memberUuid",
    "memberTypeCode": "memberTypeCode",
    "inviteStatusCode": "COMPLETE",
    "maskingEmail": "maskingEmail",
    "memberName": "memberName",
    "secondFactorCertificationYn": "secondFactorCertificationYn",
    "id": "id",
    "joinYmdt": "2000-01-23T04:56:07.000+00:00",
    "recentPasswordModifyYmdt": "2000-01-23T04:56:07.000+00:00",
    "email": "email",
    "recentLoginYmdt": "2000-01-23T04:56:07.000+00:00"
  }],
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  },
  "paging": {
    "limit": 0,
    "page": 6,
    "totalCount": 1
  }
}
```
###### Response


| Name | Type | Required | Description |   
|------------ | ------------- | ------- | ------------ |
|   header | [Common Response](#response)| Yes |
|   orgMembers | List&lt;OrgMemberWithInviteMemberrotocol>| Yes | Organization member list |
|   paging | PagingResponse| Yes | Paging information |

###### OrgMemberWithInviteMemberProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ----- | ------------ |
|   email | String| Yes | Member's email address |
|   inviteStatusCode | String| No | Member's invitation status (COMPLETE, EXPIRE, UNKNOWN, WAIT) |
|   joinYmdt | Date| Yes | Member join date and time |
|   maskingEmail | String| Yes | Member's masked email  |
|   memberName | String| Yes| Member's name |
|   memberTypeCode | String| Yes| Member type (TOAST_CLOUD: NHN Cloud account, IAM: IAM account) |
|   memberUuid | String| No| Member's UUID<br>Not returned when the member has a pending invitation |
|   recentLoginYmdt | Date| Yes| Most recent login date and time |
|   recentPasswordModifyYmdt | Date| No| Most recent password change date and time |
|   secondFactorCertificationYn | String| No|  Whether to set up two-step sign-in (available to NHN Cloud members only) |

###### PagingResponse


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   limit | Integer| No | Number of items per page, default: 20  |
|   page | Integer| No | Target page, default: 1  |
|   totalCount | Long| Yes | Total count  |




<a id="view-all-common-role-groups-for-projects-in-the-organization"></a>

#### View all common role groups for projects in the organization

> GET "/v1/organizations/{org-id}/project-role-groups"

API to get a list of project common role groups set up by your organization.

##### Required Permissions
`Organization.Project.RoleGroup.List`

##### Request Parameters



| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | Organization ID to query | 
|  Query |descriptionLike | String| No | Description | 
|  Query |roleGroupNameLike | String| No | Role group name |
|  Query |limit | Integer| No | Number of results per page, default 20 |
|  Query |page | Integer| No | Target page, default 1 |






##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  },
  "paging": {
    "limit": 0,
    "page": 6,
    "totalCount": 1
  },
  "roleGroups": [ {
    "regDateTime": "2000-01-23T04:56:07.000+00:00",
    "roleGroupType": "ORG",
    "description": "description",
    "roleGroupName": "roleGroupName",
    "roleGroupId": "roleGroupId"
  } ]
}
```



###### Response


| Name | Type | Required | Description |   
|------------ | ------------- | --------- | ------------ |
|   header | [Common response](#response)| Yes  |
|   paging | [PagingResponse](#pagingresponse)| Yes  |
|   roleGroups | List&lt;RoleGroupProtocol>| Yes | List of available role groups in your project  |


###### RoleGroupProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ----- | ------------ |
|   description | String| No | Role group description |
|   regDateTime | Date| Yes | Date and time the role group was created |
|   roleGroupId | String| Yes | Role group ID |
|   roleGroupName | String| Yes| Name of the role group |
|   roleGroupType | String| Yes | Type of role group<br><ul><li>ORG: Project common role group</li><li>ORG_ROLE_GROUP: Organization role group</li><li>PROJECT: Project role group</li> |


<a id="get-service-hierarchy"></a>

#### Get Service Hierarchy

> GET "/v1/product-uis/hierarchy"

API to return homepage category, homepage service information that is exposed on the bill.

##### Required Permissions
This API can be called without specific permissions if you are a member.<br>
However, if you're viewing an organization's services, you must be a member of a project in that organization or a project under that organization.

##### Request Parameters



| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Query |productUiType | String| Yes | Service UI type<br><ul><li>PROJECT: Project service</li><li>ORG: Organization service</li><li>MARKET_PLACE: Marketplace service</li></ul> |
|  Query |orgId | String| No | Organization ID must be entered if the service UI type is ORG |




##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  },
  "productUiList": [ {
    "productUiId": "productUiId",
    "parentProductUiId": "parentProductUiId",
    "children": [ null ],
    "productUiName": "productUiName",
    "productId": "productId",
    "manualLink": "manualLink"
  } ]
}
```

###### Response


| Name | Type | Required | Description |   
|------------ | ------------- | ------- | ------------ |
|   header | [Common response](#response)| Yes |
|   productUiList | List&lt;ProductUiHierarchyProtocol>| Yes  | Homepage category service UI list |

###### ProductUiHierarchyProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ----- | ------------ |
|   children | List&lt;ProductUiHierarchyProtocol>| No | Homepage service UI list |
|   manualLink | String| No|
|   parentProductUiId | String| No| Service UI category |
|   productId | String| No|
|   productUiId | String| No| Service UI identification key |
|   productUiName | String| No|


<a id="get-service-used-by-project"></a>

#### Get Service Used by Project

> GET "/v1/projects/{project-id}/products/{product-id}"

* APIs to get information about specific services used by your project

##### Required Permissions
`서비스명:ProductAppKey.Get`

##### Request Parameters



| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | ID of the project to query |
|  Path |product-id | String| Yes | ID of the service to query |




##### Response Body

```json
{
  "hasUpdateSecretKeyPermission": true,
  "product": {
    "updateDate": "updateDate",
    "productId": "productId",
    "relationDate": "relationDate",
    "secretKey": "secretKey",
    "externalId": "externalId",
    "productSecretKeyCode": "F",
    "productName": "productName",
    "updateUuid": "updateUuid",
    "appKey": "appKey",
    "productStatusCode": "STABLE",
    "projectId": "projectId",
    "statusCode": "STABLE"
  },
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### Response


| Name | Type | Required | Description |   
|------------ | ------------- | ------- | ------------ |
|   header | [Common Response](#response)| Yes |
|   hasUpdateSecretKeyPermission | Boolean| Yes | Permission to reissue the secret key  |
|   product | ProjectProductRelationAndProductProtocol| Yes  | Returns information about the services being used by the project for the specified service ID, not including on error |


###### ProjectProductRelationAndProductProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   appKey | String| Yes | AppKey information for the service your project is using  |
|   externalId | String| No | Tenant ID<br>Only available if the tenant ID exists for the service |
|   productId | String| Yes | Service ID  |
|   productName | String| Yes | Service name  |
|   productSecretKeyCode | String| No | Whether to use the secret key<br>T: Used<br>Other: Not used (F, N) |
|   productStatusCode | String| Yes | Service status (STABLE, CLOSED) |
|   projectId | String| Yes | ID of the project that uses the service  |
|   relationDate | Date| Yes | Service start date and time  |
|   secretKey | String| Yes | Service SecretKey<br>Available only for services that use the secretKey  |
|   statusCode | String| Yes | The service's usage status (STABLE, CLOSED) |
|   updateDate | Date| No | Date and time of the last modification to the service  |
|   updateUuid | String| No | UUID of the user who last modified the service AppKey  |


<a id="get-project-member"></a>

#### Get Project Member

> GET "/v1/projects/{project-id}/members/{member-uuid}"

API to get a specific member of a project.

##### Required Permissions
`Project.Member.Get`

##### Request Parameters



| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | Project ID to retrieve members from |
|  Path |member-uuid | String| Yes | UUID of the member to retrieve |




##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  },
  "projectMember": {
    "emailAddress": "emailAddress",
    "memberTypeCode": "IAM",
    "roles": [ {
      "regDateTime": "2000-01-23T04:56:07.000+00:00",
      "roleApplyPolicyCode": "ALLOW",
      "roleId": "roleId",
      "roleName": "roleName",
      "categoryKey": "categoryKey",
      "description": "description",
      "categoryTypeCode": "ORG_ROLE_GROUP",
      "conditions": [ {
        "attributeId": "attributeId",
        "attributeOperatorTypeCode": "ALLOW",
        "attributeValues": [ "attributeValues", "attributeValues" ],
        "attributeDescription": "attributeDescription",
        "attributeName": "attributeName",
        "attributeDataTypeCode": "BOOLEAN"
      } ]
    } ],
    "maskingEmail": "maskingEmail",
    "memberName": "memberName",
    "relationDateTime": "2000-01-23T04:56:07.000+00:00",
    "uuid": "uuid",
    "statusCode": "COMPLETE"
  }
}
```


###### Response


| Name | Type | Required | Description |   
|------------ | ------------- | ------- | ------------ |
|   header | [Common Response](#response)| Yes |
|   projectMember | ProjectMemberRoleBundleProtocol| Yes  | Added member information, not included on error |


###### ProjectMemberRoleBundleProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   emailAddress | String| No | Member email address  |
|   maskingEmail | String| No | Masked email of the member  |
|   memberName | String| No | Member name  |
|   memberTypeCode | String| No | Member type (IAM, TOAST_CLOUD) |
|   relationDateTime | Date| No | Date and time the member was added  |
|   roles | List&lt;RoleBundleProtocol>| No | List of related roles (with condition attributes)  |
|   statusCode | String| No | Invitation status codes (COMPLETE, EXPIRE, UNKNOWN, WAIT) |
|   uuid | String| No | Member UUID  |


[RoleBundleProtocol](#rolebundleprotocol)



<a id="list-project-members"></a>

#### List Project Members

> POST "/v1/projects/{project-id}/members/search"

API for getting a list of members belonging to a project.

##### Required Permissions
`Project.Member.List`

##### Request Parameters


| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | Project ID to query | 
| Request Body | request | SearchProjectMembersRequest| Yes | Request |



###### SearchProjectMembersRequest


| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   memberStatusCodes | List&lt;String>| No | Project member status codes (INVITED, STABLE) |
|   roleIds | List&lt;String>| No | Role ID list  |
|   paging | [PagingBean](#pagingbean) | No   |





##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  },
  "paging": {
    "limit": 0,
    "page": 6,
    "totalCount": 1
  },
  "projectMembers": [ {
    "emailAddress": "emailAddress",
    "memberTypeCode": "TOAST_CLOUD",
    "maskingEmail": "maskingEmail",
    "memberName": "memberName",
    "relationDateTime": "2000-01-23T04:56:07.000+00:00",
    "uuid": "uuid",
    "statusCode": "COMPLETE"
  } ]
}
```

###### Response


| Name | Type | Required | Description |   
|------------ | ------------- | ------- | ------------ |
|   header | [Common Response](#response)| Yes |
|   paging | [PagingResponse](#pagingresponse)| Yes  |
|   projectMembers | List&lt;ProjectMemberProtocol>| Yes | Project members  |



###### ProjectMemberProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   emailAddress | String| No | Member email address  |
|   maskingEmail | String| No | Member's masked email  |
|   memberName | String| No | Member name  |
|   memberTypeCode | String| No | Member type |
|   relationDateTime | Date| No | Time the member was added  |
|   statusCode | String| No | Invitation status codes (COMPLETE, EXPIRE, UNKNOWN, WAIT) |
|   uuid | String| No | Member UUID  |


<a id="get-project-role-group"></a>

#### Get Project Role Group

> GET "/v1/projects/{project-id}/project-role-groups/{role-group-id}"

API to get a project role group.

##### Required Permissions
`Project.RoleGroup.Get`

##### Request Parameters



| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | Project ID to look up | 
|  Path |role-group-id | String| Yes | Project role group ID<br>Project common role group IDs cannot be looked up | 




##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  },
  "roleGroup": {
    "regDateTime": "2000-01-23T04:56:07.000+00:00",
    "roleGroupType": "ORG",
    "roles": [ {
      "regDateTime": "2000-01-23T04:56:07.000+00:00",
      "roleApplyPolicyCode": "ALLOW",
      "roleId": "roleId",
      "roleName": "roleName",
      "categoryKey": "categoryKey",
      "description": "description",
      "categoryTypeCode": "ORG_ROLE_GROUP",
      "conditions": [ {
        "attributeId": "attributeId",
        "attributeOperatorTypeCode": "ALLOW",
        "attributeValues": [ "attributeValues", "attributeValues" ],
        "attributeDescription": "attributeDescription",
        "attributeName": "attributeName",
        "attributeDataTypeCode": "BOOLEAN"
      } ]
    } ],
    "description": "description",
    "roleGroupName": "roleGroupName",
    "roleGroupId": "roleGroupId"
  }
}
```

###### Response


| Name | Type | Required | Description |   
|------------ | ------------- | --------- | ------------ |
|   header | [Common response](#response)| Yes |
|   roleGroup | RoleGroupBundleProtocol| Yes | Role group including associated roles  |

###### RoleGroupBundleProtocol

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   roleGroupId | String| No | Role group ID  |
|   roleGroupName | String| No | Role group name  |
|   description | String| No | Role group description  |
|   roleGroupType | String| No | Role group type (organization, project)  |
|   roles | List&lt;[RoleBundleProtocol](#rolebundleprotocol)>| No | List of associated roles  |
|   regDateTime | Date| No | Registration date and time  |



<a id="view-a-common-role-group-for-the-project-in-the-organization"></a>

#### View a Common Role Group for the Project in the Organization

> GET "/v1/organizations/{org-id}/project-role-groups/{role-group-id}"

API to get a project common role group.

##### Required Permissions
`Organization.Project.RoleGroup.Get`

##### Request Parameters


| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | Organization ID to retrieve | 
|  Path |role-group-id | String| Yes | Project common role group ID | 


##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  },
  "roleGroup": {
    "regDateTime": "2000-01-23T04:56:07.000+00:00",
    "roleGroupType": "ORG",
    "roles": [ {
      "regDateTime": "2000-01-23T04:56:07.000+00:00",
      "roleApplyPolicyCode": "ALLOW",
      "roleId": "roleId",
      "roleName": "roleName",
      "categoryKey": "categoryKey",
      "description": "description",
      "categoryTypeCode": "ORG_ROLE_GROUP",
      "conditions": [ {
        "attributeId": "attributeId",
        "attributeOperatorTypeCode": "ALLOW",
        "attributeValues": [ "attributeValues", "attributeValues" ],
        "attributeDescription": "attributeDescription",
        "attributeName": "attributeName",
        "attributeDataTypeCode": "BOOLEAN"
      } ]
    } ],
    "description": "description",
    "roleGroupName": "roleGroupName",
    "roleGroupId": "roleGroupId"
  }
}
```


###### Response


| Name | Type | Required | Description |   
|------------ | ------------- | --------- | ------------ |
|   header | [Common Response](#response)| Yes |
|   roleGroup | [RoleGroupBundleProtocol](#rolegroupbundleprotocol) | Yes | Role group including associated roles  |




<a id="list-all-project-role-groups"></a>

#### List All Project Role Groups

> GET "/v1/projects/{project-id}/project-role-groups"

API to get all role groups in a project.

##### Required Permissions
`Project.RoleGroup.List`

##### Request Parameters


| Category | Name | Type | Required | Description |
|------------- |------------- | ------------- | ------------- | ------------- |
| Path | project-id | String | Yes | ID of the project to query |
| Query | descriptionLike | String | No | Description |
| Query | roleGroupNameLike | String | No | Role group name |
| Query | limit | Integer | No | Number of items to display per page. Default: 20 |
| Query | page | Integer | No | Target page. Default: 1 |



##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  },
  "paging": {
    "limit": 0,
    "page": 6,
    "totalCount": 1
  },
  "roleGroups": [ {
    "regDateTime": "2000-01-23T04:56:07.000+00:00",
    "roleGroupType": "ORG",
    "description": "description",
    "roleGroupName": "roleGroupName",
    "roleGroupId": "roleGroupId"
  } ]
}
```

###### Response


| Name | Type | Required | Description |
|------------ | ------------- | --------- | ------------ |
| header | [Common Response](#response) | Yes | |
| paging | [PagingResponse](#pagingresponse) | Yes | |
| roleGroups | List&lt;[RoleGroupProtocol](#rolegroupprotocol)> | Yes | List of available role groups in your project |

<a id="list-projects-in-organization"></a>

#### List Projects in Organization

> GET "/v1/organizations/{org-id}/projects"

API to get a list of projects in a STABLE state that belong to a specific organization.

##### Required Permissions
Organization members

##### Request Parameters


| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | Organization ID to retrieve | 
|  Query |memberUuid | String| No | Member UUID of the organization |
|  Query |projectName | String| No | Project name |
|  Query |page | Integer| No | Target page; default is 1 |
|  Query |limit | Integer| No | Number of items per page; default is 20 |


##### Response Body

```json
{
  "projectList": [ {
    "regDateTime": "2000-01-23T04:56:07.000+00:00",
    "delDateTime": "2000-01-23T04:56:07.000+00:00",
    "description": "description",
    "orgId": "orgId",
    "projectStatusCode": "STABLE",
    "modDateTime": "2000-01-23T04:56:07.000+00:00",
    "projectName": "projectName",
    "projectId": "projectId"
  } ],
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  },
  "paging": {
    "limit": 0,
    "page": 6,
    "totalCount": 1
  }
}
```


###### Response


| Name | Type | Required | Description |   
|------------ | ------------- | ------- | ------------ |
|   header | [Common Response](#response)| Yes |
|   paging | [PagingResponse](#pagingresponse) | Yes |
|   projectList | List&lt;OrgProjectMemberRoleProtocol>| Yes |



###### OrgProjectMemberRoleProtocol

| Name | Type | Required | Description |   
|------------ | ------------- | ----- | ------------ |
|   delDateTime | Date| No | Project deletion date and time |
|   description | String| No | Project description |
|   modDateTime | Date| No| Project modification date and time |
|   orgId | String| Yes| Organization ID that the project belongs to |
|   projectId | String| Yes| Project ID |
|   projectName | String| Yes| Project name |
|   projectStatusCode | String| Yes | Project status<br><ul><li>STABLE: The project is in normal use</li><li>CLOSED: The payment has been made and the project is well closed.</li><li>BLOCKED: The project has been blocked by an administrator</li><li>TERMINATED: All resources have been deleted due to overdue payment</li><li>DISABLED: All services are closed but payment has not been made</li></ul> |
|   regDateTime | Date| Yes| Project registration date and time |


<a id="list-organization-governance-in-use"></a>

#### List organization governance in use

> GET "/v1/organizations/{org-id}/governances"

Retrieves active governance settings.

##### Required Permissions
`Organization.Governance.List`

##### Request Parameters

| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | Organization ID to look up | 



##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  },
  "usingGovernances": [ {
    "regDatetime": "2000-01-23T04:56:07.000+00:00",
    "governanceTypeCode": "governanceTypeCode"
  } ]
}
```



###### Response


| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common Response](#response)| Yes   |
|   usingGovernances | List&lt;GovernanceProtocol>| No | List of governance in use  |


###### GovernanceProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   governanceTypeCode | String| No | Governance type<br>- APPROVE_PROCESS: Approval processing<br>- BLOCK_STORAGE_SNAPSHOT: Whether to use the Snapshot feature of BlockStorage<br>- IAAS_RESOURCE_PROTECTION_AND_SEPARATED_NETWORK: Set control of IaaS resource permissions and restriction on terminal access<br>- PRIVACY_PROTECTION: Privacy protection<br>- UNIQUE_INSTANCE_NAME: Prevention of duplicate instance names |
|   regDatetime | Date| No | Date and time when the governance was enabled  |

<a id="create-a-common-role-group-for-projects-in-the-organization"></a>

#### Create a common role group for projects in the organization

> POST "/v1/organizations/{org-id}/project-role-groups"

API to create project common role groups.


##### Required Permissions
`Organization.Project.RoleGroup.Create`

##### Request Parameters

| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | Organization ID | 
| Request Body | request | CreateRoleGroupRequest| Yes | Request |

###### CreateRoleGroupRequest

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   description | String| No | Role group description  |
|   roleGroupName | String| Yes | Role group name  |
|   roles | List&lt;AssignRoleProtocol>| Yes | List of roles to assign to the role group  |


###### AssignRoleProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   conditions | List&lt;[AssignAttributeConditionProtocol](#assignattributeconditionprotocol)>| No | Role condition attributes  |
|   roleApplyPolicyCode | String| Yes | Whether to use the role: ALLOW, DENY |
|   roleId | String| Yes | Role ID  |




##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common Response](#response)| Yes   |


<a id="delete-a-project-common-role-group-in-the-organization"></a>

#### Delete a project common role group in the organization

> DELETE "/v1/organizations/{org-id}/project-role-groups"

API to delete a project common role group.

##### Required Permissions
`Organization.Project.RoleGroup.Delete`

##### Request Parameters


| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | Organization ID | 
| Request Body | request | DeleteRoleGroupRequest| Yes | Request |


###### DeleteRoleGroupRequest


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   roleGroupIds | List&lt;String>| Yes | Role group ID list  |


##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common Response](#response)| Yes   |

<a id="modify-your-organizations-project-common-role-group-information"></a>

#### Modify your organization's project common role group information

> PUT "/v1/organizations/{org-id}/project-role-groups/{role-group-id}/infos"

API to modify the name and description of a project's common role group.

##### Required Permissions
`Organization.Project.RoleGroup.Update`

##### Request Parameters


| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | Organization ID | 
|  Path |role-group-id | String| Yes | Role group ID | 
| Request Body | request | UpdateRoleGroupInfoRequest| Yes | Request |


###### UpdateRoleGroupInfoRequest


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   description | String| No | Role group description  |
|   roleGroupName | String| Yes | Role group name  |



##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common Response](#response)| Yes   |

<a id="modify-your-organizations-project-common-roles-group-roles"></a>

#### Modify your organization's project common roles group roles

> PUT "/v1/organizations/{org-id}/project-role-groups/{role-group-id}/roles"

API to modify roles in the project common roles group.

##### Required Permissions
`Organization.Project.RoleGroup.Update`

##### Request Parameters

| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | Organization ID | 
|  Path |role-group-id | String| Yes | Role group ID | 
| Request Body | request | UpdateRoleGroupRequest| Yes | Request |


###### UpdateRoleGroupRequest


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   roles | List&lt;[AssignRoleProtocol](#assignroleprotocol)>| Yes | List of roles to assign to the role group  |




##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common Response](#response)| Yes   |

<a id="create-project-role-group"></a>

#### Create Project Role Group

> POST "/v1/projects/{project-id}/project-role-groups"

API to create role groups in your project.


##### Required Permissions
`Project.RoleGroup.Create`

##### Request Parameters


| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | Project ID | 
| Request Body | request | [CreateRoleGroupRequest](#createrolegrouprequest)| Yes | Request |





##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common response](#response)| Yes   |

<a id="delete-project-role-group"></a>

#### Delete project role group

> DELETE "/v1/projects/{project-id}/project-role-groups"

API to delete a project role group.


##### Required Permissions
`Project.RoleGroup.Delete`

##### Request Parameters


| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | Project ID | 
| Request Body | request | [DeleteRoleGroupRequest](#deleterolegrouprequest)| Yes | Request |





##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common Response](#response)| Yes   |

<a id="edit-project-role-group-information"></a>

#### Edit project role group information

> PUT "/v1/projects/{project-id}/project-role-groups/{role-group-id}/infos"

API to modify the name and description of a project role group.

##### Required Permissions
`Project.RoleGroup.Update`

##### Request Parameters

| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | Project ID | 
|  Path |role-group-id | String| Yes | Role Group ID | 
| Request Body | request |[UpdateRoleGroupInfoRequest](#updaterolegroupinforequest)| Yes | Request |


##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common Response](#response)| Yes   |


<a id="modify-project-role-group-roles"></a>

#### Modify Project Role Group Roles

> PUT "/v1/projects/{project-id}/project-role-groups/{role-group-id}/roles"

API to modify roles in the project role group.

##### Required Permissions
`Project.RoleGroup.Update`

##### Request Parameters

| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | Project ID | 
|  Path |role-group-id | String| Yes | Role group ID | 
| Request Body | request | UpdateRoleGroupRequest| Yes | Request |

###### UpdateRoleGroupRequest


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   roles | List&lt;[AssignRoleProtocol](#assignroleprotocol)>| Yes | List of roles to assign to the role group  |


##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common Response](#response)| Yes   |


<a id="list-all-organization-role-groups"></a>

#### List All Organization Role Groups

> GET "/v1/organizations/{org-id}/org-role-groups"

API to get all role groups in an organization.

##### Required Permissions

`Organization.RoleGroup.List`

##### Request Parameters

| Category | Name | Type | Required | Description |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| Path | org-id | String | Yes | Organization ID to query |
| Query | descriptionLike | String | No | Description (retrieves results containing the specified string) |
| Query | roleGroupNameLike | String | No | Role group name (retrieves results containing the specified string) |
| Query | limit | Integer | No | Number of items per page (default: 20, minimum: 1, maximum: 2,000) |
| Query | page | Integer | No | Target page (default: 1, minimum: 1) |

##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  },
  "paging": {
    "limit": 0,
    "page": 6,
    "totalCount": 1
  },
  "roleGroups": [
    {
      "regDateTime": "2000-01-23T04:56:07.000+00:00",
      "roleGroupType": "ORG_ROLE_GROUP",
      "description": "description",
      "roleGroupName": "roleGroupName",
      "roleGroupId": "roleGroupId"
    }
  ]
}
```

###### Response

| Name | Type | Required | Description |
| ------------ | ------------- | --------- | ------------ |
| header | [Common Response](#response) | Yes | |
| paging | [PagingResponse](#pagingresponse) | Yes | |
| roleGroups | List&lt;[RoleGroupProtocol](#rolegroupprotocol)> | Yes | List of role groups available in the organization |

<a id="get-an-organization-role-group"></a>

#### Get an Organization Role Group

> GET "/v1/organizations/{org-id}/org-role-groups/{role-group-id}"

API to get an organization's role groups.

##### Required Permission

`Organization.RoleGroup.Get`

##### Request Parameters

| Category | Name | Type | Required | Description |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| Path | org-id | String | Yes | ID of the organization to retrieve |
| Path | role-group-id | String | Yes | Organization role group ID | 

##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  },
  "roleGroup": {
    "regDateTime": "2000-01-23T04:56:07.000+00:00",
    "roleGroupType": "ORG_ROLE_GROUP",
    "roles": [
      {
        "regDateTime": "2000-01-23T04:56:07.000+00:00",
        "roleApplyPolicyCode": "ALLOW",
        "roleId": "roleId",
        "roleName": "roleName",
        "categoryKey": "categoryKey",
        "description": "description",
        "categoryTypeCode": "ROLE",
        "conditions": [
          {
            "attributeId": "attributeId",
            "attributeOperatorTypeCode": "ALLOW",
            "attributeValues": [
              "attributeValues",
              "attributeValues"
            ],
            "attributeDescription": "attributeDescription",
            "attributeName": "attributeName",
            "attributeDataTypeCode": "BOOLEAN"
          }
        ]
      }
    ],
    "description": "description",
    "roleGroupName": "roleGroupName",
    "roleGroupId": "roleGroupId"
  }
}
```

###### Response

| Name | Type | Required | Description |
| ------------ | ------------- | --------- | ------------ |
| header | [Common Response](#response) | Yes | |
| roleGroup | [RoleGroupBundleProtocol](#rolegroupbundleprotocol) | Yes | Role groups with related roles |

<a id="create-organization-role-group"></a>

#### Create Organization Role Group

> POST "/v1/organizations/{org-id}/org-role-groups"

Creates role groups in an organization.

##### Required Permissions

`Organization.RoleGroup.Create`

##### Request Parameters

| Category | Name | Type | Required | Description |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| Path | org-id | String | Yes | Organization ID |
| Request Body | request | [CreateRoleGroupRequest](#createrolegrouprequest) | Yes | Request |

##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### Response

| Name | Type | Required | Description |
| ------------ | ------------- | ----------- | ------------ |
| header | [Common response](#response) | Yes | |

<a id="delete-organization-role-group"></a>

#### Delete Organization Role Group

> DELETE "/v1/organizations/{org-id}/org-role-groups"

API to delete an organization role group.

##### Required Permissions

`Organization.RoleGroup.Delete`

##### Request Parameters

| Category | Name | Type | Required | Description |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| Path | org-id | String | Yes | Organization ID |
| Request Body | request | [DeleteRoleGroupRequest](#deleterolegrouprequest) | Yes | Request |

##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### Response

| Name | Type | Required | Description |
| ------------ | ------------- | ----------- | ------------ |
| header | [Common Response](#response) | Yes | |

<a id="modify-organization-role-group-information"></a>

#### Modify Organization Role Group Information

> PUT "/v1/organizations/{org-id}/org-role-groups/{role-group-id}/infos"

API to modify the name and description of an organization role group.

##### Required Permissions

`Organization.RoleGroup.Update`

##### Request Parameters

| Category | Name | Type | Required | Description |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| Path | org-id | String | Yes | Organization ID |
| Path | role-group-id | String | Yes | Role group ID |
| Request Body | request | [UpdateRoleGroupInfoRequest](#updaterolegroupinforequest) | Yes | Request |

##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### Response

| Name | Type | Required | Description |
| ------------ | ------------- | ----------- | ------------ |
| header | [Common response](#response) | Yes | |


<a id="modify-organization-role-group-roles"></a>

#### Modify Organization Role Group Roles

> PUT "/v1/organizations/{org-id}/org-role-groups/{role-group-id}/roles"

API to modify roles in the organization role group.

##### Required Permissions

`Organization.RoleGroup.Update`

##### Request Parameters

| Category | Name | Type | Required | Description |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| Path | org-id | String | Yes | Organization ID |
| Path | role-group-id | String | Yes | Role group ID |
| Request Body | request | UpdateRoleGroupRequest | Yes | Request |

###### UpdateRoleGroupRequest

| Name | Type | Required | Description |
| ------------ | ------------- | ------------- | ------------ |
| roles | List&lt;[AssignRoleProtocol](#assignroleprotocol)> | Yes | List of roles to assign to the role group |

##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### Response

| Name | Type | Required | Description |
| ------------ | ------------- | ----------- | ------------ |
| header | [Common Response](#response) | Yes | |


<a id="modify-organization-member-role"></a>

#### Modify Organization Member Role

> PUT "/v1/organizations/{org-id}/members/{member-uuid}"

API to modify the roles of members in the organization.


##### Required Permissions
`Organization.Member.Update`


##### Request Parameters


| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | Organization ID | 
|  Path |member-uuid | String| Yes | UUID of the member to modify | 
| Request Body | request | UpdateMemberRoleRequest| Yes | Request |


###### UpdateMemberRoleRequest


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   assignRoles | List&lt;[UserAssignRoleProtocol](#userassignroleprotocol)>| Yes | List of roles to assign to the user  |


##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common Response](#response)| Yes   |

<a id="modify-project-member-role"></a>

#### Modify Project Member Role

> PUT "/v1/projects/{project-id}/members/{member-uuid}"

API to modify the role of a specified member in a project.

##### Required Permissions
`Project.Member.Update`

##### Request Parameters

| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | Project ID | 
|  Path |member-uuid | String| Yes | Member UUID to change role to | 
| Request Body | request | [UpdateMemberRoleRequest](#updatememberrolerequest)| Yes | Request |




##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common response](#response)| Yes   |

<a id="get-organization-iam-account"></a>

#### Get Organization IAM Account

> GET "/v1/iam/organizations/{org-id}/members/{member-uuid}"

Retrieves an IAM account that belongs to an organization.

##### Required Permissions
`Organization.Member.Iam.Get`


##### Request Parameters

| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | Organization ID to retrieve | 
|  Path |member-uuid | String| Yes | IAM account UUID of the organization to retrieve | 


##### Response Body

```json
{
  "orgMember": {
    "country": "country",
    "englishName": "englishName",
    "nativeName": "nativeName",
    "passwordChangedAt": "2000-01-23T04:56:07.000+00:00",
    "lastLoggedInAt": "2000-01-23T04:56:07.000+00:00",
    "roles": [ {
      "regDateTime": "2000-01-23T04:56:07.000+00:00",
      "roleApplyPolicyCode": "ALLOW",
      "roleId": "roleId",
      "roleName": "roleName",
      "categoryKey": "categoryKey",
      "description": "description",
      "categoryTypeCode": "ORG_ROLE_GROUP",
      "conditions": [ {
        "attributeId": "attributeId",
        "attributeOperatorTypeCode": "ALLOW",
        "attributeValues": [ "attributeValues", "attributeValues" ],
        "attributeDescription": "attributeDescription",
        "attributeName": "attributeName",
        "attributeDataTypeCode": "BOOLEAN"
      } ]
    }],
    "officeHoursEnd": "officeHoursEnd",
    "userCode": "userCode",
    "organizationId": "organizationId",
    "createdAt": "2000-01-23T04:56:07.000+00:00",
    "emailAddress": "emailAddress",
    "lastLoggedInIp": "lastLoggedInIp",
    "nickname": "nickname",
    "idProviderId": "idProviderId",
    "mobilePhoneCountryCode": "mobilePhoneCountryCode",
    "id": "id",
    "department": "department",
    "saasRoles": [ {
      "role": "role",
      "productId": "productId",
      "productName": "productName"
    }],
    "profileImageUrl": "profileImageUrl",
    "lastAccessedAt": "2000-01-23T04:56:07.000+00:00",
    "maskingEmail": "maskingEmail",
    "telephone": "telephone",
    "creationType": "creationType",
    "idProviderType": "idProviderType",
    "officeHoursBegin": "officeHoursBegin",
    "mobilePhone": "mobilePhone",
    "corporate": "corporate",
    "idProviderUserId": "idProviderUserId",
    "name": "name",
    "position": "position",
    "status": "status"
  },
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common Response](#response)| Yes   |
|   orgMember | OrgIamMemberRoleBundleProtocol| No  |

###### OrgIamMemberRoleBundleProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ----- | ------------ |
|   corporate | String| No | Company name |
|   country | String| No | Nationality (nationality of the organization owner) |
|   createdAt | Date| No | Creation date and time |
|   creationType | String| No| Account creation type |
|   department | String| No| Department name |
|   emailAddress | String| Yes | IAM account email address  |
|   englishName | String| No| English name | 
|   id | String| Yes | IAM account UUID  |
|   idProviderId | String| No| ID of the authentication provider when using external authentication |
|   idProviderType | String| No| service: Direct IAM account login<br>sso: Customer SSO integration |
|   idProviderUserId | String| No| User ID provided by the external authentication provider |
|   lastAccessedAt | Date| No| The account's last access date, returning null if not present |
|   lastLoggedInAt | Date| No| The account's last login date, returning null if not present |
|   lastLoggedInIp | String| No| The member's last login IP address, returning null if not present |
|   maskingEmail | String| No | Masked email address of the IAM account  |
|   mobilePhone | String| No | Mobile phone number of the IAM account  |
|   mobilePhoneCountryCode | String| No| Two-letter country code for mobile phone numbers |
|   name | String| Yes | Name of the IAM account  |
|   nativeName | String| No| Native language name |
|   nickname | String| No| User nickname |
|   officeHoursBegin | String| No| Work start time, e.g., 09:00 |
|   officeHoursEnd | String| No| Work end time, e.g., 18:00 |
|   organizationId | String| Yes | Organization ID of the IAM account  |
|   passwordChangedAt | Date| No| Date of last password change for the account. Returns null if not present. |
|   position | String| No| Position |
|   profileImageUrl | String| No| Profile image URL |
|   roles | List&lt;[RoleBundleProtocol](#rolebundleprotocol)>| No | List of associated roles (including condition attributes)  |
|   saasRoles | List&lt;IamMemberRole>| No | IAM account roles  |
|   status | String| No| Account status |
|   telephone | String| No | Phone number of the IAM account  |
|   userCode | String| Yes | IAM account ID  |



###### IamMemberRole


| Name | Type | Required | Description |   
|------------ | ------------- | ------- | ------------ |
|   productId | String| No |
|   productName | String| No |
|   role | String| No |


<a id="list-organization-iam-accounts"></a>

#### List Organization IAM Accounts

> GET "/v1/iam/organizations/{org-id}/members"

API to get a list of IAM accounts that belong to this organization.

##### Required Permissions
`Organization.Member.Iam.List`

##### Request Parameters

| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | Organization ID | 
|  Query |email | String| No | Email address of the IAM account |
|  Query |emailLike | String| No |  |
|  Query |idProviderType | String| No | service: Direct IAM account login<br>sso: Customer SSO integration |
|  Query |nameLike | String| No |  |
|  Query |statuses | List&lt;String>| No |  |
|  Query |userCode | String| No | IAM account ID |
|  Query |userCodeLike | String| No |  |
|  Query |limit | Integer| No | Number of items per page, default 20 |
|  Query |page | Integer| No | Target page, default 1 |

##### Response Body

```json
{
  "orgMembers": [ {
    "country": "country",
    "englishName": "englishName",
    "nativeName": "nativeName",
    "passwordChangedAt": "2000-01-23T04:56:07.000+00:00",
    "lastLoggedInAt": "2000-01-23T04:56:07.000+00:00",
    "officeHoursEnd": "officeHoursEnd",
    "userCode": "userCode",
    "organizationId": "organizationId",
    "createdAt": "2000-01-23T04:56:07.000+00:00",
    "emailAddress": "emailAddress",
    "lastLoggedInIp": "lastLoggedInIp",
    "nickname": "nickname",
    "idProviderId": "idProviderId",
    "mobilePhoneCountryCode": "mobilePhoneCountryCode",
    "id": "id",
    "department": "department",
    "profileImageUrl": "profileImageUrl",
    "lastAccessedAt": "2000-01-23T04:56:07.000+00:00",
    "maskingEmail": "maskingEmail",
    "telephone": "telephone",
    "creationType": "creationType",
    "idProviderType": "idProviderType",
    "officeHoursBegin": "officeHoursBegin",
    "mobilePhone": "mobilePhone",
    "corporate": "corporate",
    "idProviderUserId": "idProviderUserId",
    "name": "name",
    "position": "position",
    "status": "status"
  } ],
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  },
  "paging": {
    "limit": 0,
    "page": 6,
    "totalCount": 1
  }
}
```


###### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common response](#response)| Yes   |
|   orgMembers | List&lt;IamOrgMemberProtocol>| No | List of organization IAM accounts  |
|   paging | [PagingResponse](#pagingresponse)| No  |

###### IamOrgMemberProtocol

| Name | Type | Required | Description |   
|------------ | ------------- | --------- | ------------ |
| id | String | No | IAM account UUID | 
| userCode | String | Yes | IAM account ID used to log in | 
| name | String | Yes | Username of the IAM account | 
| emailAddress | String |  Yes | Email address of the IAM account<br>Used to receive notifications or to change your password. |
| maskingEmail | String | No | Masked email address of the IAM account |
| mobilePhone | String | No | Mobile phone number of the IAM account |
| telephone | String | No | Phone number of the IAM account |
| position | String | No | Position |
| department | String | No | Department |
| corporate | String | No | Company name  |
| profileImageUrl | String | No | Profile image URL |
| englishName | String | No | English name |
| nativeName | String | No | Native name |
| nickname | String | No | User nickname |
| officeHoursBegin | String | No | Office hours start time, e.g., 09:00 |
| officeHoursEnd | String | No | Office hours end time, e.g., 18:00 |
| status | String | Yes | You can change the account status.<br><ul><li>member: Active status</li><li>leaved: Withdrawal requested</li></ul>Must specify member at creation time |
| creationType | String | No | Creation date and time |
| idProviderId | String | No | Authentication provider ID when using external authentication |
| idProviderType | String | No | service: Direct IAM account login (default)<br>sso: Customer SSO integration (cannot be configured if not integrated) |
| idProviderUserId | String | No | User ID provided by the external authentication provider |
| createdAt | Date | No | Creation date and time |
| lastAccessedAt | Date | No | Last access date and time |
| lastLoggedInAt | Date | No | Last login date and time |
| lastLoggedInIp | String | No | Last logged-in IP address |
| passwordChangedAt | Date | No | Password change date and time |
| mobilePhoneCountryCode | String | No | Two-letter country code for mobile phone numbers  |
| organizationId | String | No | Organization ID of the IAM account |
| country | String | No | Nationality (nationality of the organization owner) |




<a id="add-organization-iam-account"></a>

#### Add Organization IAM Account

> POST "/v1/iam/organizations/{org-id}/members"

Adds an IAM account to an organization.

##### Required Permissions
`Organization.Member.Iam.Create`


##### Request Parameters

| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | Organization ID | 
| Request Body | request | AddIamOrgMemberRequest| Yes | Request |

###### AddIamOrgMemberRequest


| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   member | [AddIamOrgMemberProtocol](#addiamorgmemberprotocol)| Yes   |


###### AddIamOrgMemberProtocol

| Name | Type | Required | Description |   
|------------ | ------------- | --------- | ------------ |
| userCode | String | Yes | IAM account ID to use for signing in | 
| name | String | Yes | User name of the IAM account | 
| emailAddress | String |  Yes | Email address of the IAM account<br>Used to receive notifications or to change your password. |
| mobilePhone | String | No | Mobile phone number of the IAM account |
| telephone | String | No | Phone number of the IAM account |
| position | String | No | Job title |
| department | String | No | Department name |
| corporate | String | No | Company name |
| profileImageUrl | String | No | Profile image URL |
| englishName | String | No | English name |
| nativeName | String | No | Name in native language |
| nickname | String | No | User nickname |
| officeHoursBegin | String | No | Work start time example: 09:00 |
| officeHoursEnd | String | No | Work end time example: 18:00 |
| status | String | Yes | The account status can be changed<br><ul><li>member: Active status</li><li>leaved: Withdrawal request</li></ul>Must specify member at creation time |
| creationType | String | No | Integration (sso), invitation (invited), registration (registred) |
| mobilePhoneCountryCode | String | No | Country code for mobile phone numbers, required when entering a mobile phone number  |



##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  },
  "uuid": "uuid"
}
```


###### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common Response](#response)| Yes   |
|   uuid | String| No | IAM account UUID  |




<a id="send-iam-account-password-change-email"></a>

#### Send IAM Account Password Change Email

> POST "/v1/iam/organizations/{org-id}/members/{member-id}/send-password-setup-mail"

API to send an email to an IAM account to change their password.

##### Required Permissions
`Organization.Member.Iam.Update`


##### Request Parameters

| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | ID of the target organization | 
|  Path |member-id | String| Yes | UUID of the IAM account whose password is to be changed | 
| Request Body | request | SendPasswordSetupMailRequest| Yes | Request |



###### SendPasswordSetupMailRequest


| Name | Type | Required | Description |   
|------------ | ------------- | --------- | ------------ |
|   locale | String| Yes | User's locale information<br>Example: ko |
|   returnUrl | String| Yes | The address of the page you'll be directed to after you change your password via email change notification.<br>You must enter the toast.com, dooray.com, or nhncloud.com domain in the Go To address information |


##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common response](#response)| Yes   |

<a id="modify-organization-iam-account"></a>

#### Modify Organization IAM Account

> PUT "/v1/iam/organizations/{org-id}/members/{member-uuid}"

Modifies the IAM account information of an organization.

##### Required Permissions
`Organization.Member.Iam.Update`

##### Request Parameters

| Category | Name | Type | Required | Description |
|------------- |------------- | ------------- | ------------- | ------------- |
| Path | org-id | String | Yes | Organization ID of the target |
| Path | member-uuid | String | Yes | UUID of the IAM account to update |
| Request Body | request | UpdateIamMemberRequest | Yes | Request |


###### UpdateIamMemberRequest


| Name | Type | Required | Description |
|------------ | ------------- | ----------- | ------------ |
| member | [UpdateIamOrgMemberProtocol](#updateiamorgmemberprotocol) | Yes | |


###### UpdateIamOrgMemberProtocol

| Name | Type | Required | Description |
|------------ | ------------- | --------- | ------------ |
| userCode | String | Yes | IAM account ID to use for signing in |
| name | String | Yes | Username of the IAM account |
| emailAddress | String | Yes | Email address of the IAM account<br>Used to receive notifications or to change your password. |
| mobilePhone | String | No | Mobile phone number of the IAM account |
| telephone | String | No | Phone number of the IAM account |
| position | String | No | Job title |
| department | String | No | Department name |
| corporate | String | No | Company name |
| profileImageUrl | String | No | Profile image URL |
| englishName | String | No | English name |
| nativeName | String | No | Native language name |
| nickname | String | No | User nickname |
| officeHoursBegin | String | No | Work start time example: 09:00 |
| officeHoursEnd | String | No | Work end time example: 18:00 |
| status | String | Yes | Specifies the account status.<br><ul><li>member: Active status</li><li>leaved: Withdrawal requested</li></ul>Must specify member at creation time |
| creationType | String | No | Integration (sso), invitation (invited), registration (registred) |
| idProviderUserId | String | No | User ID provided by an external authentication authority |
| mobilePhoneCountryCode | String | No | Country code for mobile phone numbers, required when entering a mobile phone number |


##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### Response

| Name | Type | Required | Description |
|------------ | ------------- | ----------- | ------------ |
| header | [Common response](#response) | Yes | |

<a id="change-organization-iam-account-password"></a>

#### Change Organization IAM Account Password

> POST "/v1/iam/organizations/{org-id}/members/{member-id}/set-password"

API to change the password of an organization IAM account.

##### Required Permissions
`Organization.Member.Iam.Update`

##### Request Parameters

| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | Target organization ID | 
|  Path |member-id | String| Yes | UUID of the IAM account whose password is to be changed | 
| Request Body | request | UpdateIamPasswordRequest| Yes | Request |


###### UpdateIamPasswordRequest


| Name | Type | Required | Description |   
|------------ | ------------- | --------- | ------------ |
|   password | String| Yes  | Password to set | 


##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common response](#response)| Yes   |

<a id="list-organization-ip-acls"></a>

#### List Organization IP ACLs

> GET "/v1/organizations/{org-id}/products/ip-acl"

API to get IP ACL settings.

##### Required Permissions
`Organization.Governance.IpAcl.List`

##### Request Parameters

| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | Organization ID | 


##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  },
  "orgIpAcl": [ {
    "productId": "productId",
    "ips": [ "ips" ]
  } ]
}
```


###### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common response](#response)| Yes   |
|   orgIpAcl | List&lt;OrgIpAclProtocol>| Yes  | If the result is an empty list, the setting is not set. |

###### OrgIpAclProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | --------- | ------------ |
|   ips | List&lt;String>| Yes  | Allowed IPs | 
|   productId | String| Yes  | Service ID<br>If undefined, applies the common setting|

<a id="view-organization-iam-account-sign-in-session-settings-information"></a>

#### View Organization IAM Account Sign-in Session Settings Information

> GET "/v1/iam/organizations/{org-id}/settings/session"

API to get login session settings information.

##### Required Permissions
`Organization.Setting.Iam.Get`

##### Request Parameters

| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | Organization ID | 


##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": ""
  },
  "result": {
    "content": {
      "multiSessionsLimit": 1,
      "sessionTimeoutMinutes": 10,
      "mobileSessionTimeoutMinutes": 10,
      "sessionType": "fixed"
    }
  }
}
```


##### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
| header | [Common Response](#response)| Yes   |
| result | Content | Yes | Settings content |

###### Content

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   multiSessionsLimit | Integer| Yes | Number of concurrent sessions allowed  |
|   sessionTimeoutMinutes | Integer| Yes | Session timeout (minutes) |
|   mobileSessionTimeoutMinutes | Integer| Yes | Mobile session timeout (minutes) |
|   sessionType | String| Yes | fixed/idle. The default is fixed.  |

<a id="view-settings-for-organizational-iam-account-login-two-factor-authentication"></a>

#### View Settings for Organizational IAM Account Login Two-Factor Authentication

> GET "/v1/iam/organizations/{org-id}/settings/security-mfa"

API to get settings for login two-factor authentication.

##### Required Permissions
`Organization.Setting.Iam.Get`

##### Request Parameters


| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | Organization ID | 

##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": ""
  },
  "result": {
    "range": "organization",
    "organizationMfaSetting": {
      "type": "email",
      "bypassByIp": {
        "enable": true
        "ipList": [
          "1.1.1.1",
          "1.1.1.1/24"
        ]
      }
    },
    "serviceMfaSettings": [{
      "serviceId": "{toast-service-id}",
      "type": "totp",
      "bypassByIp": {
        "enable": true
        "ipList": [
          "1.1.1.1",
          "1.1.1.1/24"
        ]
      }
    }]
  }
}
```


##### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   header | [Common Response](#response)| Yes   |
|   result | Result| No |  Response content<br>If never set, null is returned |

###### Result
| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   range | Integer| No | Whether organization or service<br>organization (common settings), services (per-service settings)  |
|   organizationMfaSetting | OrganizationMfaSetting| No | Organization MFA settings<br>Common settings |
|   serviceMfaSettings | ServiceMfaSettings| No | Per-service MFA settings  |


###### OrganizationMfaSetting

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   type | String| No | MFA type<br>none (not configured), totp (Google OTP), email (email) |
|   bypassByIp | BypassByIp| No | Exception IP  |

###### ServiceMfaSettings


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   serviceId | String| No | Service ID  |
|   type | String| No | MFA type<br>none (not configured), totp (Google OTP), email (email) |
|   bypassByIp | BypassByIp| No | Service type. none, totp, email |

###### BypassByIp

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   enable | Boolean| No | Whether enabled<br>true (enabled), false (disabled)  |
|   ipList | List&lt;String>| No | Exception IP list |

<a id="view-organization-iam-account-login-failure-security-settings"></a>

#### View Organization IAM Account Login Failure Security Settings

> GET "/v1/iam/organizations/{org-id}/settings/security-login-fail"

API to get login failure security settings.

##### Required Permissions
`Organization.Setting.Iam.Get`

##### Request Parameters

| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | Organization ID | 


##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": ""
  },
  "result": {
    "enable": false,
    "loginFailCount": {
      "limit": "5",
      "blockMinutes": "2"
    }
  }
}
```


##### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
| header | [Common Response](#response)| Yes   |
| result | Result | No | Returned only if login failure security is set, otherwise null is returned |

###### Result

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   enable | Boolean| Yes | Whether it is enabled<br>true (enabled), false (disabled)  |
|   loginFailCount | LoginFailCount| No | Login failure security settings |


###### LoginFailCount

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   limit | Integer| No | Number of allowed attempts |
|   blockMinutes | Integer| No | Login lockout duration |

<a id="get-organization-iam-account-password-policy"></a>

#### Get Organization IAM Account Password Policy

> GET "/v1/iam/organizations/{org-id}/settings/password-rule"

Retrieves the password policy settings.

##### Required Permission
`Organization.Setting.Iam.Get`

##### Request Parameters

| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | Organization ID | 


##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": ""
  },
  "result": {
    "content": {
      "schemaVersion": 1,
      "value": {
        "ruleType": "default",
        "passwordConstraints": {
          "minLength": 8,
          "mustNotIncludeIllegalSequence": true,
          "mustIncludeUpperCase": true,
          "mustIncludeLowerCase": true,
          "mustIncludeNumberCase": true,
          "mustIncludeSpecialCase": true
        },
        "passwordExpiry": {
          "enabled": true,
          "expiryDays": 90,
          "allowExpend": true
        },
        "limitPasswordReuse": {
          "enabled": true,
          "limitCount": 1
        },
        "applyRule": "onChangePassword"
      }
    }
  }
}
```

##### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
| header | [Common Response](#response)| Yes   |
| result | Content | Yes | Settings |

###### Content

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
| schemaVersion | Integer| Yes | Schema version  |
| value | Value| Yes |  Password policy |

###### Value

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
| ruleType | String | Yes | Password policy<br>default (default password policy), custom (custom password policy) |
| passwordConstraints | PasswordConstraints | Yes | Password strength |
| passwordExpiry | PasswordExpiry | Yes | Password expiration |
| limitPasswordReuse | LimitPasswordReuse | Yes | Password reuse limit |
| applyRule | String | Yes | Password policy application timing<br>onChangePassword (applied on password change), onLogin (applied immediately) |

###### PasswordConstraints

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
| minLength | integer | Yes | Minimum password length |
| mustNotIncludeIllegalSequence | boolean | Yes | At least one letter<br>true (enabled), false (disabled) |
| mustIncludeUpperCase | boolean | Yes | At least one uppercase letter<br>true (enabled), false (disabled) |
| mustIncludeLowerCase | boolean | Yes | At least one lowercase letter<br>true (enabled), false (disabled) |
| mustIncludeNumberCase | boolean | Yes | At least one number<br>true (enabled), false (disabled) |
| mustIncludeSpecialCase | boolean | Yes | At least one special character<br>true (enabled), false (disabled) |

###### PasswordExpiry

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
| enable | Boolean | Yes | Whether to enable<br>true (enabled), false (disabled) |
| expiryDays | Integer | Yes | Expiration period |
| allowExpend | Boolean | Yes | Extend upon Expiration<br>true (allowed), false (not allowed) |

###### LimitPasswordReuse

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
| enable | Boolean | Yes | Whether to enable<br>true (enabled), false (disabled) |
| limitCount | Integer | Yes | Password reuse limit count |

<a id="get-service-prices-registered-in-pay-as-you-go"></a>

#### Get Service Prices Registered in Pay-as-You-Go

> POST "/v1/billing/contracts/basic/products/prices/search"

API to get the unit price set on a counter.
For each language, you can get the impression name and type for calculating the amount.


##### Required Permissions
Available to all members.

##### Request Parameters

| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Query |limit | Integer| No |  |
| Request Body | request | GetContractProductPriceRequest| Yes | Request |

##### GetContractProductPriceRequest
| Name | Type | Required | Description |   
|------------ | ------------- | --------- | ------------ |
|  counterNames | List&lt;String>| No | List of counter names in service metadata<br>If not provided, retrieves all |
|   paging | Paging| No  |

###### Paging

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   limit | Integer| No | Number of items per page, default 20  |
|   page | Integer| No | Target page, default 1  |


##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  },
  "paging": {
    "limit": 6,
    "page": 1,
    "totalCount": 5
  },
  "prices": [ {
    "contractDiscountPolicyId": "jxzEL2C09G20oDX3",
    "originalPrice": 0.8008281904610115,
    "monthFrom": "monthFrom",
    "displayNameJa": "displayNameJa",
    "rangeFrom": 1.4658129805029452,
    "monthTo": "monthTo",
    "counterName": "counterName",
    "slidingCalculationTypeCode": "NONE",
    "rangeTo": 5.962133916683182,
    "displayNameZh": "displayNameZh",
    "price": 6.027456183070403,
    "contractId": "3YVRwIVU",
    "displayNameEn": "displayNameEn",
    "displayNameKo": "displayNameKo",
    "seq": 5,
    "useFixPriceYn": "N"
  } ]
}
```

###### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common Response](#response)| Yes   |
|   paging | PagingResponse| Yes | Returns pagination results with no sort order  |
|   prices | List&lt;ContractProductPriceProtocol>| Yes | Returns the unit price information of the counter as an array<br>Not included in case of error  |

###### PagingResponse

| Name | Type | Required | Description |   
|------------ | ------------- | ------- | ------------ |
|   limit | Integer| Yes | Limit on the number of items to retrieve<br>Default is 20 |
|   page | Integer| Yes |
|   totalCount | Integer| Yes |

###### ContractProductPriceProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   contractDiscountPolicyId | String| Yes | Commitment pricing policy ID  |
|   contractId | String| Yes | Commitment ID  |
|   counterName | String| Yes | Counter  |
|   displayNameEn | String| No | English name of the counter  |
|   displayNameJa | String| No | Japanese name of the counter  |
|   displayNameKo | String| Yes | Korean name of the counter  |
|   displayNameZh | String| No | Chinese name of the counter<br>Currently displayed in English |
|   monthFrom | String| Yes | Start month of the valid unit price information (inclusive)  |
|   monthTo | String| Yes | End month of the valid unit price information (exclusive)  |
|   originalPrice | BigDecimal| Yes | Unit price  |
|   price | BigDecimal| Yes | Unit price  |
|   rangeFrom | BigDecimal| Yes | Start of usage range that falls under unit price (not included)  |
|   rangeTo | BigDecimal| Yes | Ending usage ranges that fall under unit pricing (inclusive)  |
|   seq | Long| Yes | Sequence number  |
|   slidingCalculationTypeCode | String| Yes | Sliding rate calculation type<br>NONE, SECTION_SUM, SECTION_SELECTED |
|   useFixPriceYn | String| Yes | Fixed amount or not (Y: Fixed amount , N: Unit price calculation)<br>Y: If within range, the price becomes the amount<br>N: (Usage × unit price) becomes the amount |

<a id="list-services-registered-for-pay-as-you-go"></a>

#### List Services Registered for Pay-as-You-Go

> GET "/v1/billing/contracts/basic/products"

API that provides a list of the main categories and subcategories exposed in the bill, and the counters they contain.

##### Required Permissions
Any member can call this API without specific permissions.

##### Request Parameters

| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Query |limit | Integer| No | Limit on the number of results returned.<br>Default value is 20 |
|  Query |page | Integer| No |  |


##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  },
  "paging": {
    "limit": 6,
    "page": 1,
    "totalCount": 5
  },
  "products": [ {
    "productId": "KGDeiKUq",
    "unitName": "hours",
    "regionTypeCode": "regionTypeCode",
    "calcUnitCode": "HOURS",
    "displayOrder": 0,
    "minUsage": 2.3021358869347655,
    "description": "description",
    "productUiId": "CQvbgjJw",
    "categorySub": "eNWZ3jZq2FsMSHaQ",
    "convertUsageTypeCode": "NONE",
    "marketPlaceMandatoryUsePeriod": 5,
    "counterName": "c2.small",
    "meterUnitCode": "HOURS",
    "counterTypeCode": "DELTA",
    "unit": 1,
    "categoryMain": "eNWZ3jZq2FsMSHaQ",
    "parentCounterName": "parentCounterName",
    "budgetUsageTypeYn": "Y",
    "chargingTypeId": "API CALLS",
    "productMetadataStatusCode": "STABLE",
    "usageAggregationUnitCode": "RESOURCE_ID"
  } ]
}
```


###### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common Response](#response)| Yes   |
|   paging | [PagingResponse](#pagingresponse)| Yes  |
|   products | List&lt;ProductMetadata>| Yes | List of service metadata  |


###### ProductMetadata


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   budgetUsageTypeYn | String| No | Budget usage type Yn  Y, N |
|   calcUnitCode | String| Yes | Units to use when calculating amounts (converts metering units to settlement units to calculate amounts), units to expose on statements<br>KB, MB, GB, TB, SECONDS, MINUTE, HOURS, DAYS, MB_HOURS, GB_SECONDS, GB_HOURS, GB_DAYS, CORE_SECONDS, CORE_HOURS, CORE_DAYS, USERS, MAU, MAD, DAU, CALLS, COUNTS, CCU, VCPU_HOURS, COUNT_HOURS |
|   categoryMain | String| Yes | Main category  |
|   categorySub | String| Yes | Sub category  |
|   chargingTypeId | String| Yes | Billing type ID  |
|   convertUsageTypeCode | String| Yes | Usage conversion type code  NONE, HOUR_AVERAGE, DAY_AVERAGE |
|   counterName | String| Yes | Counter  |
|   counterTypeCode | String| Yes | Method for aggregating usage<br><ul><li>DELTA: Incremental value (HOURLY_SUM)</li><li>GAUGE: Sum of hourly maximums (to be changed to HOURLY_MAX)</li><li>HOURLY_LATEST: The sum of the latest metering data collected in a one-hour period.</li><li>DAILY_MAX: Sum of daily maximums</li><li>MONTHLY_MAX: Monthly maximum</li><li>STATUS: Usage status</li><ul> |
|   description | String| No | Counter description  |
|   displayOrder | Integer| Yes | Display order  |
|   marketPlaceMandatoryUsePeriod | Integer| No | Marketplace mandatory usage period  |
|   meterUnitCode | String| Yes | Usage unit when storing metering data in the service<br>BYTES, KB, MB, GB, TB, CORE, HOURS, MINUTE, USERS, MAU, MAD, DAU, CALLS, COUNTS, CCU, SECONDS |
|   minUsage | BigDecimal| Yes | Minimum usage  |
|   parentCounterName | String| Yes | Parent counter name  |
|   productId | String| Yes | Service ID  |
|   productMetadataStatusCode | String| Yes | Counter status code  STABLE, CLOSED |
|   productUiId | String| Yes | Homepage category/homepage service identification ID  |
|   regionTypeCode | String| Yes | Region code that the counter name belongs to<br><ul><li>GLOBAL: Counter names belonging to Global services</li><li>NONE: Same meaning as GLOBAL</li><li>KR1: Counter names belonging to the KR1 region</li><li>KR2: Counter names belonging to the KR2 region</li><li>...: Counter names belonging to the corresponding region</li><ul>  |
|   unit | Long| Yes | Settlement unit  |
|   unitName | String| Yes | Name to display on the bill  |
|   usageAggregationUnitCode | String| No | Usage aggregation unit<br>RESOURCE_ID, COUNTER_NAME |


<a id="list-project-integrated-appkeys"></a>

#### List Project Integrated Appkeys

> GET "/v1/authentications/projects/{project-id}/project-appkeys"

API to get a list of project integrated Appkeys being used by the project.

##### Required Permissions
`Project.ProjectAppKey.List`

##### Request Parameters

| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | Project ID to query | 


##### Response Body

```json
{
  "authenticationList": [ {
    "appKey": "appKey",
    "authStatus": "STABLE",
    "modDatetime": "2000-01-23T04:56:07.000+00:00",
    "authId": "authId",
    "projectId": "projectId",
    "lastUsedDatetime": "2000-01-23T04:56:07.000+00:00",
    "reIssueDatetime": "2000-01-23T04:56:07.000+00:00",
    "regDatetime": "2000-01-23T04:56:07.000+00:00"
  } ],
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### Response

| Name | Type | Required | Description |   
|------------ | ------------- | --------- | ------------ |
|   header | [Common Response](#response)| Yes |
|   authenticationList | List&lt;ProjectAppKeyResponse>| No | List of project integrated Appkeys |

###### ProjectAppKeyResponse

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   authId | String| No | ID of the authentication method managed internally  |
|   appKey | String| No | Project integrated Appkey displayed in the console  |
|   authStatus | String| No | Authentication status codes (STABLE, STOP, BLOCKED) |
|   projectId | String| No | Project ID |
|   lastUsedDatetime | Date| No | Last used date and time  |
|   modDatetime | Date| No | Deletion date and time  |
|   reIssueDatetime | Date| No | Reissue date and time  |
|   regDatetime | Date| No | Creation date and time  |

<a id="list-user-access-key-ids"></a>

#### List User Access Key IDs

> GET "/v1/authentications/user-access-keys"

API to get a list of a member's User Access Key IDs.

##### Required Permissions
Available to all members.


##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  },
  "authentications": [ {
    "userAccessKeyID": "userAccessKeyID",
    "secretAccessKey": "secretAccessKey",
    "authStatus": "STABLE",
    "modDatetime": "2000-01-23T04:56:07.000+00:00",
    "authId": "authId",
    "uuid": "uuid",
    "tokenExpiryPeriod": 0,
    "tokenFormatCode" : "OPAQUE",
    "lastUsedDatetime": "2000-01-23T04:56:07.000+00:00",
    "reIssueDatetime": "2000-01-23T04:56:07.000+00:00",
    "regDatetime": "2000-01-23T04:56:07.000+00:00",
    "lastTokenUsedDatetime": "2025-02-11T01:30:56.771Z",
    "validTokenCount": 0
  } ]
}
```


###### Response


| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common Response](#response)| Yes   |
|   authentications | List&lt;UserAccessKeyResponse>| No | Authentication information list  |

###### UserAccessKeyResponse

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   authId | String| No | Internally managed authentication method ID  |
|   userAccessKeyID | String| No | User Access Key ID  |
|   secretAccessKey | String| No | Secret key (masked)  |
|   authStatus | String| No | Authentication status codes (STABLE, STOP, BLOCKED) |
|   uuid | String| No | User UUID |
|   lastUsedDatetime | Date| No | Last date and time of authentication with the User Access Key ID |
|   modDatetime | Date| No | Deletion date and time  |
|   reIssueDatetime | Date| No | Regeneration date and time  |
|   regDatetime | Date| No | Creation date and time  |
|   tokenExpiryPeriod | Long| No | Token expiry period (in seconds)  |
|   tokenFormatCode | String | No | Token format code (OPAQUE, JWT)  |
|   lastTokenUsedDatetime | Long| No | Last date and time of authentication/authorization with a token              |
|   validTokenCount | Long| No | Number of valid tokens                       |


<a id="register-a-project-integrated-appkey"></a>

#### Register a Project Integrated Appkey

> POST "/v1/authentications/projects/{project-id}/project-appkeys"

API to generate an AppKey for use in your project.

##### Required Permissions
`Project.ProjectAppKey.Create`


##### Request Parameters

| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
| Path | project-id | String| Yes | The project ID where you want to register the AppKey |
| Request Body | request | AddProjectAppKeyRequest| Yes | Request |

###### AddProjectAppKeyRequest

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   appkeyAlias | String | Yes   | Project Integrated Appkey alias<br>Maximum 100 characters |


##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  },
  "authentication": {
    "appKey": "appKey",
    "authId": "authId"
  }
}
```

###### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common Response](#response)| Yes   |
|   authentication | ResponseProtocol| No  |

###### ResponseProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ----- | ------------ |
|   authId | String| No | Internally managed authentication method ID  |
|   appKey | String| No | Project Integrated Appkey |

<a id="register-user-access-key-id"></a>

#### Register User Access Key ID

> POST "/v1/authentications/user-access-keys"

API to register a member's User Access Key ID.

##### Required Permissions
Available to all members.

##### Request Parameters

| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
| Request Body | PostUserAppKeyRequest | PostUserAppKeyRequest| Yes |  | |


###### PostUserAppKeyRequest

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   tokenFormatCode | String | No | Token format code<br>Supports OPAQUE and JWT formats. Currently, JWT format tokens are available only in the EasyQueue service.<br>The default value is OPAQUE |
|   tokenExpiryPeriod | Long| No | Token validity period<br>Specified in seconds. For OPAQUE format tokens, the default is one day; for JWT tokens, the default is one hour.<br>OPAQUE format tokens can be issued with a validity period of at least one minute and up to one day. JWT format tokens can be issued with a validity period of at least one minute and up to one hour. |


##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  },
  "authentication": {
    "userAccessKeyID": "userAccessKeyID",
    "secretAccessKey": "secretAccessKey",
    "authId": "authId",
    "tokenExpiryPeriod": 0,
    "tokenFormatCode": "OPAQUE"
  }
}
```

###### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common Response](#response)| Yes   |
|   authentication | ResponseProtocol| No  |

###### ResponseProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ----- | ------------ |
|   authId | String| No | Internally managed authentication method ID  |
|   userAccessKeyID | String| No | User Access Key ID  |
|   secretAccessKey | String| No | Secret key |
|   tokenExpiryPeriod | Long| No | Token validity period (in seconds)
|   tokenFormatCode | String | No | Token format code (OPAQUE, JWT) |

<a id="delete-project-integrated-appkey"></a>

#### Delete Project Integrated Appkey

> DELETE "/v1/authentications/projects/{project-id}/project-appkeys/{app-key}"

API to delete a project AppKey.

##### Required Permissions
`Project.ProjectAppKey.Delete`


##### Request Parameters


| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
| Path | project-id | String| Yes | Target project ID |
|  Path |app-key | String| Yes | Project integrated Appkey to delete | 


##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```
###### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common Response](#response)| Yes   |


<a id="reissue-the-user-access-key-id-secret-key"></a>

#### Reissue the User Access Key ID Secret Key

> PUT "/v1/authentications/user-access-keys/{user-access-key-id}/secretkey-reissue"

API to reissue the secret key for a User Access Key ID.


##### Required Permissions
Only your own User Access Key ID secret key can be reissued.

##### Request Parameters

| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |user-access-key-id | String| Yes | User Access Key ID | 
| Request Body | request | ReissueSecretKeyRequest| Yes | Request |


###### ReissueSecretKeyRequest

| Name | Type      | Required | Description                                                |   
|------------ |---------|----|---------------------------------------------------|
|   needExpireTokens | Boolean | No | Whether to expire the issued tokens (true: expire, false: do not expire)<br>Default: false |

##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  },
  "authentication": {
    "secretAccessKey": "secretAccessKey"
  }
}
```

###### Response


| Name | Type | Required | Description |   
|------------ | ------------- | --------- | ------------ |
|   header | [Common Response](#response)| Yes |
|   authentication | ResponseProtocol| No  |

###### ResponseProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   secretAccessKey | String| Yes   | Secret key |

<a id="modify-user-access-key-id-status"></a>

#### Modify User Access Key ID Status

> PUT "/v1/authentications/user-access-keys/{user-access-key-id}"

API to change the state of a member's User Access Key ID.<br>
If you deactivate the User Access Key ID for OPAQUE tokens, the OPAQUE tokens also expire. However, deactivating the User Access Key ID for JWT tokens does not expire the JWT tokens.

##### Required Permissions
You can only modify your own User Access Key ID.

##### Request Parameters


| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path | user-access-key-id | String| Yes | User Access Key ID | 
| Request Body | request | UpdateUserAccessKeyStatusRequest| Yes | Request |


###### UpdateUserAccessKeyStatusRequest

| Name | Type | Required | Description |   
|----------- | ------------- | ------------- | ------------ |
| status | String| Yes | Status to change (STOP: deactivated, STABLE: active) |


##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common response](#response)| Yes   |

<a id="delete-a-user-access-key-id"></a>

#### Delete a User Access Key ID

> DELETE "/v1/authentications/user-access-keys/{user-access-key-id}"

API to delete a User Access Key ID.

##### Required Permissions
You can only delete your own User Access Key ID.

##### Request Parameters

| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path | user-access-key-id | String| Yes | User Access Key ID | 


##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### Response


| Name | Type | Required | Description |   
|------------ | ------------- | ------- | ------------ |
|   header | [Common Response](#response)| Yes |


<a id="list-tokens"></a>

#### List Tokens

> GET "/v1/authentications/user-access-keys/{user-access-key-id}/tokens"

API to get a list of OPAQUE tokens issued with a User Access Key ID.

##### Required Permissions
Only tokens issued with your own User Access Key ID can be retrieved.

##### Request Parameters

| Category | Name | Type | Required | Description                                                                           | 
|------------- |------------- | ------------- |-----|------------------------------------------------------------------------------| 
|  Path | user-access-key-id | String| Yes | User Access Key ID                                                           | 
|  Query | token | String| No  | Full token<br>Partial search is not supported                                                        | 
|  Query | status | String| No  | Token status<br>ACTIVE: Active, EXPIRED: Expired                                             | 
|  Query | lastAccessDatetimeFrom | Date| No  | Token last used at<br>Get tokens used at a time greater than or equal to the specified time<br>Example: `2025-02-11T00:56:50.902Z` | 
|  Query | expireDatetimeFrom | Date| No  | Token expiration date and time<br>Get tokens expired at a time greater than or equal to the specified time<br>Example: `2025-02-11T00:56:50.902Z`   | 
|  Query | regDatetimeFrom | Date| No  | Token registered at<br>Get tokens created at a time greater than or equal to the specified time<br>Example: `2025-02-11T00:56:50.902Z`   |
|  Query | page | Integer| No  | Target page<br>Default: 1                                                                |
|  Query | limit | Integer| No  | Number of items per page<br>Default: 20                                                            |



##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  },
  "tokens": [
    {
      "accessToken": "string",
      "expireDatetime": "2025-02-11T00:56:50.902Z",
      "lastAccessDatetime": "2025-02-11T00:56:50.902Z",
      "regDatetime": "2025-02-11T00:56:50.902Z",
      "status": "ACTIVE",
      "tokenId": 0
    }
  ],
  "totalItems": 0
}
```

###### Response


| Name | Type           | Required  | Description                 |   
|------------ |--------------|-----|--------------------|
|   header | [Common Response](#response) | Yes |
|   paging | [PagingResponse](#pagingresponse)| Yes  |
|   accessToken | String       | Yes | Masked token         |
|   expireDatetime | Date         | No  | Token expiration date             |
|   lastAccessDatetime | Date         | Yes | Last date and time of authentication/authorization with the token |
|   regDatetime | Date         | Yes | Token creation date and time           |
|   status | String       | Yes | Token status              |
|   tokenId | Long         | Yes | Token ID              |


<a id="expire-multiple-tokens"></a>

#### Expire Multiple Tokens

> DELETE "/v1/authentications/user-access-keys/{user-access-key-id}/tokens"

API to expire multiple OPAQUE tokens issued with a User Access Key ID.<br>
JWT tokens do not expire even if you make a request with the User Access Key ID that issued the JWT token.<br>
If both the token ID and token list are empty in the request, all tokens issued to that User Access Key ID will expire.<br>
If you have both a token ID and a list of tokens, only tokens that match both are deleted, and tokens do not expire when invoked by a user other than the owner of the User Access Key ID in the request.

##### Required Permissions
Only tokens issued with your own User Access Key ID can expire

##### Request Parameters

| Category     | Name               | Type            | Required | Description        | 
|--------------|--------------------|-----------------|----------|--------------------|
| Path         | user-access-key-id | String          | Yes      | User Access Key ID | 
| Request Body | tokenIds           | List&lt;Long>   | No       | Token ID list      | 
| Request Body | tokens             | List&lt;String> | No       | Token list         | 


##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### Response


| Name | Type | Required | Description |   
|------------ | ------------- | ------- | ------------ |
|   header | [Common response](#response)| Yes |


<a id="create-project-iam-account"></a>

#### Create Project IAM Account

> POST "/v1/iam/projects/{project-id}/members"

API to add an IAM account as a project member.

##### Required Permissions
`Project.Member.Iam.Create`

##### Request Parameters



| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | Project ID to add members to | 
| Request Body | request | AddIamProjectMemberRequest| Yes | Request |




###### AddIamProjectMemberRequest


!!! danger "Caution"
    Only one project member can be created in a request.


| Name | Type | Required | Description |  
|------------ | ------------- | ------------- | ------------ |
|   assignRoles | List&lt;UserAssignRoleProtocol>| Yes | List of roles to assign to the user  |
|   memberUuid | String| Yes | UUID of the member to add  |


###### UserAssignRoleProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   roleId | String| Yes | Role ID  |
|   conditions | List&lt;AssignAttributeConditionProtocol>| No | Role condition attributes  |


###### AssignAttributeConditionProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   attributeId | String| Yes | Condition attribute ID  |
|   attributeOperatorTypeCode | String| Yes | Condition attribute operator<br>Available operators vary depending on the conditional attribute data type<br><ul><li>ALLOW</li><li>ALL_CONTAINS</li><li>ANY_CONTAINS</li><li>ANY_MATCH</li><li>BETWEEN</li><li>BEYOND</li><li>FALSE</li><li>GREATER_THAN</li><li>GREATER_THAN_OR_EQUAL_TO</li><li>LESS_THAN</li><li>LESS_THAN_OR_EQUAL_TO</li><li>NONE_MATCH</li><li>NOT_ALLOW</li><li>NOT_CONTAINS</li><li>TRUE</li></ul>  |
|   attributeValues | List&lt;String>| Yes | Condition attribute values  |


##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### Response


| Name | Type           | Required | Description |   
|------------ |--------------| ------- | ------------ |
|   header | [Common response](#response) | Yes |


<a id="delete-multiple-project-iam-accounts"></a>

#### Delete Multiple Project IAM Accounts

> DELETE "/v1/iam/projects/{project-id}/members"

API to delete IAM accounts from a project.

##### Required Permissions
`Project.Member.Iam.Delete`

##### Request Parameters



| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | Project ID | 
|  Request Body |request | DeleteMembersRequest | Yes | Request | 


###### DeleteMembersRequest


| Name | Type | Required | Description |  
|------------ | ------------- | ------------- | ------------ |
|   memberUuids | List&lt;String>| Yes | List of UUIDs of the target accounts to delete |


##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### Response


| Name | Type | Required | Description |   
|------------ | ------------- | ------- | ------------ |
|   header | [Common Response](#response)| Yes |


<a id="get-project-iam-account"></a>

#### Get Project IAM Account

> GET "/v1/iam/projects/{project-id}/members/{member-uuid}"

API to get a specific IAM account who is part of a project.

##### Required Permissions
`Project.Member.Iam.Get`

##### Request Parameters



| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | Project ID to get a member from |
|  Path |member-uuid | String| Yes | Member UUID to get |




##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  },
  "projectMember": {
    "uuid": "uuid",
    "id": "id",
    "emailAddress": "emailAddress",
    "maskingEmail": "maskingEmail",
    "name": "memberName",
    "relationDateTime": "2000-01-23T04:56:07.000+00:00",
    "roles": [ {
      "regDateTime": "2000-01-23T04:56:07.000+00:00",
      "roleApplyPolicyCode": "ALLOW",
      "roleId": "roleId",
      "roleName": "roleName",
      "categoryKey": "categoryKey",
      "description": "description",
      "categoryTypeCode": "ORG_ROLE_GROUP",
      "conditions": [ {
        "attributeId": "attributeId",
        "attributeOperatorTypeCode": "ALLOW",
        "attributeValues": [ "attributeValues", "attributeValues" ],
        "attributeDescription": "attributeDescription",
        "attributeName": "attributeName",
        "attributeDataTypeCode": "BOOLEAN"
      } ]
    } ]
  }
}
```


###### Response


| Name | Type | Required | Description |   
|------------ | ------------- | ------- | ------------ |
|   header | [Common Response](#response)| Yes |
|   projectMember | ProjectIamMemberRoleBundleProtocol| Yes  | Added member information, not included on error |


###### ProjectMemberRoleBundleProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   uuid | String| Yes | Member UUID  |
|   id | String| Yes | ID  |
|   name | String| No | Name  |
|   emailAddress | String| No | Member email address  |
|   maskingEmail | String| No | Masked email of the member  |
|   mobilePhone | String| No | Phone number  |
|   relationDateTime | Date| No | Time when the member was added  |
|   joinYmdt | Date| No | Registration date and time  |
|   recentLoginYmdt | Date| No | Most recent login date and time  |
|   recentPasswordModifyYmdt | Date| No | Most recent password change date and time  |
|   roles | List&lt;RoleBundleProtocol>| No | List of related roles (with condition attributes)  |


[RoleBundleProtocol](#rolebundleprotocol)



<a id="list-project-iam-accounts"></a>

#### List Project IAM Accounts

> GET "/v1/iam/projects/{project-id}/members"

API for getting a list of IAM members belonging to a project.

##### Required Permissions
`Project.Member.Iam.List`

##### Request Parameters


| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | Project ID to query | 
|  Query |limit | Integer| No | Number of items per page, default: 20 |
|  Query |page | Integer| No | Target page, default: 1 |




##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  },
  "paging": {
    "limit": 0,
    "page": 6,
    "totalCount": 1
  },
  "projectMembers": [ {
    "uuid": "uuid",
    "id": "id",
    "emailAddress": "emailAddress",
    "maskingEmail": "maskingEmail",
    "memberName": "memberName",
    "relationDateTime": "2000-01-23T04:56:07.000+00:00"
  } ]
}
```

###### Response


| Name | Type | Required | Description |   
|------------ | ------------- | ------- | ------------ |
|   header | [Common Response](#response)| Yes |
|   paging | [PagingResponse](#pagingresponse)| Yes  |
|   projectMembers | List&lt;IamProjectMemberProtocol>| Yes | Project member list  |



###### IamProjectMemberProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   uuid | String| Yes | Member UUID  |
|   id | String| Yes | ID  |
|   name | String| No | Name  |
|   emailAddress | String| No | Member email address  |
|   maskingEmail | String| No | Masked email for the member  |
|   mobilePhone | String| No | Phone number  |
|   relationDateTime | Date| No | Time when the member was added  |
|   joinYmdt | Date| No | Registration date and time  |
|   recentLoginYmdt | Date| No | Date and time of most recent login  |
|   recentPasswordModifyYmdt | Date| No | Date and time of most recent password change  |


<a id="modify-project-iam-account-role"></a>

#### Modify Project IAM Account Role

> PUT "/v1/iam/projects/{project-id}/members/{member-uuid}"

API to change the role of a specified IAM member in a project.

##### Required Permissions
`Project.Member.Iam.Update`

##### Request Parameters

| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | Project ID | 
|  Path |member-uuid | String| Yes | Member UUID to change role to | 
| Request Body | request | [UpdateMemberRoleRequest](#updatememberrolerequest)| Yes | Request |




##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common Response](#response)| Yes   |


<a id="view-all-credentials-of-members-under-organizations"></a>

#### View all credentials of members under organizations

> GET "/v1/authentications/organizations/{org-id}/user-access-keys"

API to get the credentials of members in an organization or project.

##### Required Permissions
`Organization.UserAccessKey.List`

##### Request Parameters



| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | Organization ID to retrieve the UserAccessKey for |
|  Query |paging | Paging| No | Number of items displayed per page, default 20 |




##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  },
  "authenticationList": [
    {
      "authId": "makedAuthId",
      "uuid": "uuid",
      "userAccessKeyID": "maskedUserAccessKeyID",
      "secretAccessKey": "",
      "tokenExpiryPeriod": 86400,
      "regDatetime": "2024-05-03T10:27:58.000+00:00",
      "modDatetime": "2024-05-03T10:27:58.000+00:00",
      "lastUsedDatetime": "2024-08-16T14:09:37.000+00:00",
      "reIssueDatetime": "2024-08-29T12:00:45.000+00:00",
      "lastTokenUsedDatetime": null,
      "validTokenCount": null,
      "authStatus": "STABLE"
    }
  ],
  "paging": {
    "limit": 0,
    "page": 6,
    "totalCount": 1
  },
}
```


###### Response


| Name | Type | Required | Description |   
|------------ | ------------- | ------- | ------------ |
|   header | [Common response](#response)| Yes |
|   paging | [PagingResponse](#pagingresponse)| Yes  |
|   authenticationList | List&lt;UserAccessKeyResponseV7>| Yes  | Authentication key information per member |


###### UserAccessKeyResponseV7

| Name | Type | Required | Description |
|------------|--------|------|-----------------------------|
| authId | String | Yes | Authentication method ID (masked) |
| uuid | String | Yes | User UUID |
| userAccessKeyID | String | Yes | User Access Key ID (masked) |
| secretAccessKey | String | No | Secret key (blank) |
| authStatusCode | String | Yes | Authentication status code (STABLE, STOP, BLOCKED) |
| tokenExpiryPeriod | Long | No | Token expiry period |
| regDatetime | Date | No | Created at |
| modDatetime | Date | No | Deleted at |
| lastUsedDatetime | Date | No | Last used at |
| reIssueDatetime | Date | No | secretAccessKey regenerated at |
| lastTokenUsedDatetime | Date | No | Token last used at |
| validTokenCount | Long | No | Number of valid tokens |

<a id="list-my-organizations"></a>

#### List My Organizations

> GET /v1/organizations

##### Required Permissions
Available to all members.

**[Query Parameter]**

| Name | Type | Required | Description |
|---|---|---|---|
| orgName | String | No | Organization name |
| orgNameMatchTypeCode | String | No | Organization name search type (EXACT: exact match, LIKE: partial match, default: LIKE) |
| page | Integer | No | Target page, default: 1 |
| limit | Integer | No | Number of items per page, default: 20 |

**[Response Body]**
```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  },
  "orgList": [
    {
      "org": {
        "orgId": "org-id",
        "orgName": "organization-name",
        "orgStatusCode": "STABLE",
        "ownerUuid": "owner-uuid",
        "regDateTime": "2023-01-01T00:00:00+09:00",
        "remainingJobCode": "NONE",
        "ipAclTypeCode": "COMMON",
        "orgDomainList": [
          {
            "domainId": "domain-id",
            "domainName": "domain-name"
          }
        ]
      },
      "orgMember": {
        "existOrgMember": true,
        "orgOwner": true
      },
      "orgOwner": {
        "email": "owner@example.com",
        "name": "owner-name",
        "restrictStatusCode": "STABLE",
        "country": "KR",
        "restrictTypes": []
      }
    }
  ],
  "paging": {
    "page": 1,
    "limit": 20,
    "totalCount": 1
  }
}
```

**[Response Body Description]**

| Name | Type | Required | Description |
|---|---|---|---|
| header | [Common Response](#response) | Yes | |
| orgList | List&lt;OrgMemberRelationProtocol> | Yes | Organization list information |
| paging | [PagingResponse](#pagingresponse) | Yes | Paging information |

###### OrgMemberRelationProtocol

| Name | Type | Required | Description |
|---|---|---|---|
| org | OrgProtocol | Yes | Organization information |
| orgMember | OrgMemberProtocol | Yes | Organization/project member information |
| orgOwner | OwnerProtocol | Yes | Organization Owner information |

###### OrgProtocol

| Name | Type | Required | Description |
|---|---|---|---|
| orgId | String | Yes | Organization ID |
| orgName | String | Yes | Organization name |
| orgStatusCode | String | Yes | Organization status code (STABLE, CLOSED) |
| ownerUuid | String | Yes | Organization Owner UUID |
| regDateTime | Date | Yes | Organization creation date and time |
| remainingJobCode | String | Yes | Subsequent organization task (NONE, IAM_ORG_CREATE, IAM_ORG_UPDATE, IAM_ORG_DELETE) |
| ipAclTypeCode | String | Yes | Organization IP ACL type code (COMMON, INDIVIDUAL) |
| orgDomainList | List&lt;OrgDomainProtocol> | Yes | Organization domain list |

###### OrgMemberProtocol

| Name | Type | Required | Description |
|---|---|---|---|
| existOrgMember | Boolean | Yes | Whether an organization member exists |
| orgOwner | Boolean | Yes | Whether the member is the organization Owner |

###### OwnerProtocol

| Name | Type | Required | Description |
|---|---|---|---|
| email | String | Yes | Organization Owner email |
| name | String | Yes | Organization Owner name |
| restrictStatusCode | String | Yes | Organization Owner restriction status (HOLD, MEMBER_BLOCKED, RESOURCE_BLOCKED, RESOURCE_DELETED, STABLE, UNPAID) |
| country | String | Yes | Organization Owner country code |
| restrictTypes | List&lt;String> | Yes | Organization Owner restriction list |

###### OrgDomainProtocol

| Name | Type | Required | Description |
|---|---|---|---|
| domainId | String | Yes | Organization domain ID |
| domainName | String | Yes | Organization domain name |


<a id="add-your-own-organization"></a>

#### Add Your Own Organization

> POST /v1/organizations

Adds your own organization.

##### Required Permissions
Available to all members.

##### Request Parameters

| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
| Request Body | request | [CreateOrgRequest](#createorgrequest)| Yes | Request |


###### CreateOrgRequest

| Name | Type | Required | Description |
|---|---|---|---|
| orgName | String | Yes | Organization name (up to 70 characters) |


##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  },
  "orgId": "org-id",
  "orgName": "organization-name",
  "owner": {
    "email": "owner@example.com",
    "name": "owner-name",
    "ownerId": "owner-uuid",
    "restrictTypes": []
  }
}
```

###### Response


| Name | Type | Required | Description |
|---|---|---|---|
| header | [Common Response](#response) | Yes | |
| orgId | String | Yes | Organization ID |
| orgName | String | Yes | Organization name |
| owner | [Owner](#owner) | Yes | Organization Owner information |

###### Owner

| Name | Type | Required | Description |
|---|---|---|---|
| email | String | Yes | Organization Owner email |
| name | String | Yes | Organization Owner name |
| ownerId | String | Yes | Organization Owner ID |
| restrictTypes | List&lt;String> | Yes | List of restricted targets |


<a id="delete-organization"></a>

#### Delete Organization

> DELETE /v1/organizations/{org-id}

Deletes the organization.

##### Required Permissions
`Organization.Delete`

##### Request Parameters

| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | Organization ID |


##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### Response

| Name | Type | Required | Description |
|---|---|---|---|
| header | [Common Response](#response) | Yes | |


<a id="list-service-information"></a>

#### List Service Information

> GET /v1/products

Retrieves a list of available services.

##### Required Permissions
Available to all members.

##### Request Parameters

| Category | Name | Type | Required | Description |
|---|---|---|---|---|
| Query | productId | String | No | Service ID |
| Query | productCategoryCode | String | No | Service category code (PROJECT, ORG, MARKET_PLACE) |
| Query | productName | String | No | Service name |
| Query | productNameLike | String | No | Service name (LIKE search) |
| Query | limit | Integer | No | Number of displays per page, default 20 |
| Query | page | Integer | No | Target page, default 1 |


##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  },
  "paging": {
    "limit": 1,
    "page": 1,
    "totalCount": 1
  },
  "products": [
    {
      "parentProductId": "productId",
      "productCategoryCode": "PROJECT",
      "productId": "productId",
      "productName": "productName"
    }
  ]
}
```

###### Response


| Name | Type | Required | Description |
|---|---|---|---|
| header | [Common Response](#response) | Yes | |
| paging | [PagingResponse](#pagingresponse) | Yes | |
| products | List&lt;Product> | Yes | List of service information |

###### Product

| Name | Type | Required | Description |
|---|---|---|---|
| parentProductId | String | No | Parent service ID |
| productCategoryCode | String | Yes | Service category code (PROJECT, ORG, MARKET_PLACE) |
| productId | String | Yes | Service ID |
| productName | String | Yes | Service name |


<a id="list-role-multilingual-descriptions"></a>

#### List Role Multilingual Descriptions

> GET /v1/messages/role

Retrieves a list of role descriptions in multiple languages.

##### Required Permissions
Available to all members.

##### Request Parameters

| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
| Query |messageType | String| No | Message type<br><ul><li>MESSAGE</li><li>ERROR</li></ul> |
| Query |languages | List&lt;String>| No | Language<br><ul><li>KO_KR</li><li>JA_JP</li><li>EN_US</li><li>ZH_CN</li></ul> |
| Query |keyword | String| No | Search keyword |
| Query |messageId | String| No | Message ID |
| Query |limit | Integer| Yes | Number of items per page | 
| Query |page | Integer| Yes | Target page |


##### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  },
  "messages": [
    {
      "i18nMessageSeq": 0,
      "categoryId": "categoryId",
      "messageId": "messageId",
      "messageType": "MESSAGE",
      "description": "description",
      "koKr": "Korean message",
      "enUs": "English message",
      "jaJp": "日本語メッセージ",
      "zhCn": "中文消息"
    }
  ],
  "paging": {
    "limit": 10,
    "page": 1,
    "totalCount": 100
  }
}
```

###### Response


| Name | Type | Required | Description |
|---|---|---|---|
| header | [Common Response](#response) | Yes | |
| messages | List&lt;MessageProtocol> | Yes | Message list |
| paging | [PagingResponse](#pagingresponse)| Yes | |

###### MessageProtocol

| Name | Type | Required | Description |
|---|---|---|---|
| i18nMessageSeq | Long | No | Message sequence number |
| categoryId | String | No | Category ID |
| messageId | String | No | Message ID |
| messageType | String | No | Message type (MESSAGE, ERROR) |
| description | String | No | Description |
| koKr | String | No | Korean message |
| enUs | String | No | English message |
| jaJp | String | No | Japanese message |
| zhCn | String | No | Chinese message |


<a id="error-codes"></a>

### Error Codes

| Result Code | Description | Action |
| ---------- |---|---|
| 80007 | Error when calling with an expired or non-existent token | Issue a new token and use it |
| -6 | Error when called by an unauthorized caller | Grant the caller appropriate permissions |
| -8 | Error when IP verification fails due to organization IP ACL policy | Check if the IP is registered in the organization IP ACL |
| 404 | Occurs when calling a non-existent API | Check the HTTP method and URI of the calling API |
| 400<br>501<br>502<br>503<br>504<br>505 | Error when request parameters are not appropriate | Check the required values and configurable values of the request parameters |
| 500 | Abnormal system error | Contact the administrator |
| 1000 | Error when parameters are incorrect <br> Organization IAM account API - `IAM account password change email send` occurs when the request value returnUrl is not an authorized domain (authorized domains: toast.com, dooray.com, nhncloud.com) | Check the request parameters |
| 1201 | Error caused by an internal server API request failure | Resolve based on the error message and code included in the error response.<br>If the issue cannot be resolved with the included message and code alone, contact the administrator |
| 10005<br>70008<br>1104 | Error when request parameters are not appropriate | Check the required values and configurable values of the request parameters |
| 10009 | Error when assigning a role that does not exist in the organization or project | Change to assign an existing role to the member |
| 10010 | Error when deleting a role group, when project members (including those being invited) are granted only that role group<br>Error when changing project member roles, if no role is assigned | 1) Change the roles of project members (including those being invited) whose only role group is the one to be deleted to other roles, or delete them <br> 2) When changing project member roles, set a value for the role in the request |
| 10012 | Error when deleting a project member, if the member is deleted and the project no longer has a member with the ADMIN role | 1) Assign the ADMIN role to another project member who is not the deletion target <br>2) Delete a target that does not have the ADMIN role |
| 12100 | Error when a project member does not exist | Use an existing project member UUID |
| 12107 | Error when the request UUID and target UUID are the same in an API that does not allow them to be the same | Set the target UUID and request UUID to be different |
| 12400 | Error when adding a member to a project that does not exist or has been deleted | Change to add the member to an existing project |
| 12401 | Error when the number of projects created exceeds the limit set for the organization owner account when creating a project | 1) Delete unused projects to secure the number of projects that can be created <br>2) Request an increase in the maximum number of projects through the administrator |
| 12500 | Error when there are services in use when deleting a project | Disable all services in use for the project, then attempt to delete the project |
| 13001 | Error when service activation or deactivation fails | Contact the administrator |
| 13002 | Error when a service that is already activated is activated again | Use the previously activated service |
| 13004 | Error when activating a service that cannot be activated | Activate only services that can be activated |
| 13006 | Error when activating a service for corporations only, if the organization owner's member type is not a corporation | Attempt to activate the service in a project under an organization whose owner has a corporate account type |
| 22006 | Occurs when a duplicate already exists when adding | Handle to prevent duplicate requests |
| 22013 | Error when attempting to change the organization owner's role | Changing the role of an organization owner is not allowed |
| 22016 | Error when the organization does not exist | Check whether the request is made with the orgId of an existing organization |
| 23005 | Error when an organization corresponding to the organization ID does not exist | Contact the administrator |
| 30015 | Error when the project AppKey creation limit is exceeded <br> Project integrated Appkey API - the number of project AppKeys that can be created in `Create project integrated Appkey` is 3; an error occurs if this is exceeded | Delete unused project integrated Appkeys, then retry |
| 40017 | Error when the project does not exist | Make API requests for existing projects |
| 40028<br>13003 | Error when the project does not exist (in cases where it was created and then deleted) | Make API requests for existing projects |
| 40054 | Error when activating a service, if a service that must be activated first has not been activated | Activate the prerequisite service first |
| 40057 | Error when deactivating a service, if a service that must be deactivated first has not been deactivated | Deactivate the prerequisite service first |
| 50007 | Error when a member is invalid<br>(A member who does not exist, or is dormant or withdrawn, is invalid)<br>Organization creation API - occurs when the UUID is invalid when the API is called | Update to the UUID of a valid member |
| 60003 | Error when there is no data in the DB<br>Project integrated Appkey API - error when there is no AppKey to delete in `Delete project integrated Appkey` | 1) Contact the administrator <br>2) Set an existing AppKey as the app key value to be deleted |
| 62004 | Error when a role group with the same name already exists when creating a role group | Change to a non-duplicate name |
| 62008 | Occurs when the role group ID does not exist when modifying or deleting a role group, or when adding or removing roles from a role group | Change to use an existing role group ID |
| 62009 | Occurs when the role is invalid when creating a role group | Change to use a valid role |
| 62011 | Occurs when the role group is in use by a notification group when deleting a role group | Delete the notification group first, then delete the role group |
| 62014 | Occurs when members who were assigned the role group fail to notify the service of roles when deleting a role group or adding or removing roles from a role group | Contact the administrator |
| 62019 | When attempting to assign a role that is not allowed to organization members | Contact the administrator |
| 72005 | Error when a billing-related API call fails | Contact the administrator |
| 70013 | Error when a service in use exists | Disable the service in use |
| 70014 | Error when the member withdrawal conditions are not met<br>IAM account - 1) when a service is in use 2) when a project that has not been deleted exists 3) when the member exists in the ADMIN role on any project | Configure to meet the withdrawal conditions for each member type |
| 70024 | Error when a payment method has not been registered properly | Register a payment method |
| 70032 | Error when a member is blocked due to non-payment | Pay the outstanding invoices for the account |
| -200201 | Error when the user-code length condition is not met | Up to 20 characters. Lowercase letters, numbers, and special characters (-, _, .) are allowed.<br>Special characters (-, _, .) cannot be used at the beginning or end. |
| -200202 | Error when the user-code format condition is not met | Lowercase letters, numbers, and special characters (-, _, .) are allowed.<br>Special characters (-, _, .) cannot be used at the beginning or end. |
| -200203 | Error when the name length condition is not met | Adjust the name length to meet the requirement of up to 60 characters |
| -200204 | Error when the user-code is duplicated when creating or modifying a member | Change to a non-duplicate user-code and retry |