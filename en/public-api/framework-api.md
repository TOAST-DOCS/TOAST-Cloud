<!-- machine_translated: true -->

<!-- pre-align:aligned sig=7c85e8979232 -->

# Framework API

**NHN Cloud > Public API User Guide > Framework API**

<a id="overview"></a>
## Overview { #overview }
The following APIs allow you to manage your organization and projects, such as creating project members and assigning roles.
Framework API uses User Access Key tokens for authentication and authorization when making API calls. The User Access Key token is a temporary, Bearer-type access token issued from a User Access Key. For more information on issuing and using User Access Key tokens, please refer to the [User Access Key Token](./user-access-key-token/).

<a id="public-api-domain"></a>
### Public API Domain { #public-api-domain }
`https://core.api.nhncloudservice.com/`

<a id="common"></a>
### Common { #common }

<a id="common-request"></a>
#### Request
When calling the Public API, you must include the Request Header below.


| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
| Header |  x-nhn-authorization | String| Y | Bearer type token issued to the user |

<a id="common-response"></a>
#### Response
When the Public API returns, the header part below is included in the response body.
```json
{
  "header" : {
    "isSuccessful" : true,
    "resultCode" : 0,
    "resultMessage" : "resultMessage"
  }
}
```

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   isSuccessful | Boolean | N | Successful or not  |
|   resultCode | Integer| N | Result code. 0 is returned on success, or an error code on failure.  |
|   resultMessage | String| N | Result message  |

<a id="common-type"></a>
#### Common Type


| Name | Type | Size | Description | 
|------------ | ------------- | ------------- | ------------ |
| org-id | String | 16 characters | Organization ID |
| project-id | String | 8 characters | Project ID |
| product-id | String | 8 characters | Service ID |
| user-access-key-id | String | 20 characters | User Access Key ID |
| project-app-key | String | 20 characters | The project's AppKey |
| product-app-key | String | 16 characters | The service's AppKey |
| uuid | String | 36 characters | Member's UUID |


!!! danger "Caution"
    If you set IP ACLs through **Organization Management > Governance Settings > Organization Governance Settings > IP ACL Settings**, those settings are also applied to calls to the framework API.


<a id="api"></a>
### API { #api }


!!! danger "Caution"
    Responses from the API can have fields added that are not specified in the guide, so they should be developed so that new fields added do not cause errors.<br>Also, when saving the DB, the column size may change, so you should set it generously.


| Method | HTTP Request | Description |
|------------- | ------------- | -------------|
| POST |[/v1/projects/{project-id}/members](#create-a-project-member) | Create a project member |
| POST |[/v1/organizations/{org-id}/projects](#add-a-project) | Add a project |
| DELETE |[/v1/projects/{project-id}/members/{target-uuid}](#delete-a-single-project-member) | Delete a single project member |
| DELETE |[/v1/projects/{project-id}](#delete-a-project) | Delete a project |
| DELETE |[/v1/projects/{project-id}/products/{product-id}/disable](#end-a-project-service) | End a project service |
| POST |[/v1/projects/{project-id}/products/{product-id}/enable](#use-a-service-product) | Use a project service |
| GET |[/v1/organizations/{org-id}/roles](#list-organization-roles) | List organization roles |
| GET |[/v1/projects/{project-id}/roles](#list-project-roles) | List project roles |
| GET |[/v1/organizations/{org-id}/domains](#search-for-an-organization-domain) | Search for an organization domain |
| GET |[/v1/organizations/{org-id}/members/{member-uuid}](#view-a-organization-member) | View a organization member |
| POST |[/v1/organizations/{org-id}/members/search](#list-organization-members) | List organization members |
| GET |[/v1/organizations/{org-id}/project-role-groups](#view-all-common-role-groups-for-projects-in-the-organization) | View all common role groups for projects in the organization |
| GET |[/v1/product-uis/hierarchy](#view-service-hierarchy) | View service hierarchy |
| GET |[/v1/projects/{project-id}/products/{product-id}](#view-a-service-used-in-the-project) | View a service used in the project |
| GET |[/v1/projects/{project-id}/members/{member-uuid}](#view-a-project-member) | View a project member |
| POST |[/v1/projects/{project-id}/members/search](#list-project-members) | List project members |
| GET |[/v1/projects/{project-id}/project-role-groups/{role-group-id}](#view-a-project-role-group) | View a project role group |
| GET |[/v1/organizations/{org-id}/project-role-groups/{role-group-id}](#view-a-common-role-group-for-the-project-in-the-organization) | View a common role group for the project in the organization |
| GET |[/v1/projects/{project-id}/project-role-groups](#view-all-project-role-groups) | View all project role groups |
| GET |[/v1/organizations/{org-id}/projects](#list-projects-in-your-organization) | List projects in your organization |
| GET |[/v1/organizations/{org-id}/governances](#list-organization-governance-in-use) | List organization governance in use |
| POST |[/v1/organizations/{org-id}/project-role-groups](#create-a-common-role-group-for-projects-in-the-organization) | Create a common role group for projects in the organization |
| DELETE |[/v1/organizations/{org-id}/project-role-groups](#delete-a-project-common-role-group-in-the-organization) | Delete a project common role group in the organization |
| PUT |[/v1/organizations/{org-id}/project-role-groups/{role-group-id}/infos](#modify-your-organizations-project-common-role-group-information) | Modify your organization's project common role group information |
| PUT |[/v1/organizations/{org-id}/project-role-groups/{role-group-id}/roles](#modify-your-organizations-project-common-roles-group-roles) | Modify your organization's project common roles group roles |
| POST |[/v1/projects/{project-id}/project-role-groups](#create-a-project-role-group) | Create a project role group |
| DELETE |[/v1/projects/{project-id}/project-role-groups](#delete-a-project-role-group) | Delete a project role group |
| PUT |[/v1/projects/{project-id}/project-role-groups/{role-group-id}/infos](#edit-project-role-group-information) | Edit project role group information |
| PUT |[/v1/projects/{project-id}/project-role-groups/{role-group-id}/roles](#modify-project-role-group-roles) | Modify project role group roles |
| GET |[/v1/organizations/{org-id}/org-role-groups](#view-all-organization-role-groups) | View all organization role groups |
| GET |[/v1/organizations/{org-id}/org-role-groups/{role-group-id}](#view-a-single-organization-role-group) | View a single organization role group |
| POST |[/v1/organizations/{org-id}/org-role-groups](#create-organization-role-group) | Create an organization role group |
| DELETE |[/v1/organizations/{org-id}/org-role-groups](#delete-organization-role-group) | Delete an organization role group |
| PUT |[/v1/organizations/{org-id}/org-role-groups/{role-group-id}/infos](#modify-organization-role-group-information) | Modify an organization role group information |
| PUT |[/v1/organizations/{org-id}/org-role-groups/{role-group-id}/roles](#modify-an-organization-role-groups-role) | Modify an organization role group's role |
| PUT |[/v1/organizations/{org-id}/members/{member-uuid}](#modify-organization-member-roles) | Modify organization member roles |
| PUT |[/v1/projects/{project-id}/members/{member-uuid}](#modify-project-member-roles) | Modify project member roles |
| GET |[/v1/iam/organizations/{org-id}/members/{member-uuid}](#view-organization-iam-members) | View organization IAM members |
| GET |[/v1/iam/organizations/{org-id}/members](#list-organization-iam-members) | List organization IAM members |
| POST |[/v1/iam/organizations/{org-id}/members](#add-an-organization-iam-member) | Add an organization IAM member |
| POST |[/v1/iam/organizations/{org-id}/members/{member-id}/send-password-setup-mail](#send-an-iam-member-password-change-email) | Send an IAM member password change email |
| PUT |[/v1/iam/organizations/{org-id}/members/{member-uuid}](#modify-organization-iam-member-information) | Modify organization IAM member information |
| POST |[/v1/iam/organizations/{org-id}/members/{member-id}/set-password](#change-an-organization-iam-member-password) | Change an organization IAM member password |
| GET |[/v1/iam/organizations/{org-id}/settings/session](#view-organization-iam-sign-in-session-settings-information) | View organization IAM sign-in session settings information |
| GET |[/v1/iam/organizations/{org-id}/settings/security-mfa](#view-settings-for-organizational-iam-sign-in-second-factor-authentication) | View settings for organizational IAM sign-in second factor authentication |
| GET |[/v1/iam/organizations/{org-id}/settings/security-login-fail](#view-organization-iam-login-failure-security-settings) | View Organization IAM Login Failure Security Settings |
| GET |[/v1/iam/organizations/{org-id}/settings/password-rule](#get-your-organizations-iam-account-password-policy) | Get your organization's IAM account password policy |
| GET |[/v1/organizations/{org-id}/products/ip-acl](#listorganization-ip-acls) | Listorganization IP ACLs |
| POST |[/v1/billing/contracts/basic/products/prices/search](#get-the-price-of-a-service-on-a-pay-as-you-go-subscription) | Get the price of a service on a pay-as-you-go subscription |
| GET |[/v1/billing/contracts/basic/products](#list-services-enrolled-in-a-pay-as-you-go-subscription) | List services enrolled in a pay-as-you-go subscription |
| GET |[/v1/billing/members/payment-statements](#view-charges-by-payment-statement) | View charges by payment statement |
| GET |[/v1/billing/members/payment-statements/charge-summaries](#view-charge-summaries-by-scope) | View charges by billing group, organization, and project |
| GET |[/v1/billing/members/payment-statements/usages](#view-individual-charge-lines) | View charges by individual charge line |
| GET |[/v1/billing/members/payment-statements/dimensions](#view-charge-filter-dimensions) | List charge filter dimension values |
| GET |[/v1/authentications/projects/{project-id}/project-appkeys](#get-project-integrated-appkey) | Get Project AppKey |
| GET |[/v1/authentications/user-access-keys](#listuser-access-key-ids) | ListUser Access Key IDs |
| POST |[/v1/authentications/projects/{project-id}/project-appkeys](#register-a-integrated-project-appkey) | Register a project AppKey |
| POST |[/v1/authentications/user-access-keys](#register-a-user-access-key-id) | Register a User Access Key ID |
| DELETE |[/v1/authentications/projects/{project-id}/project-appkeys/{app-key}](#delete-a-project-integrated-appkey) | Delete a project AppKey |
| PUT |[/v1/authentications/user-access-keys/{user-access-key-id}/secretkey-reissue](#reissue-the-user-access-key-id-secret-key) | Reissue the User Access Key ID secret key |
| PUT |[/v1/authentications/user-access-keys/{user-access-key-id}](#modify-user-access-key-id-status) | Modify User Access Key ID status |
| DELETE |[/v1/authentications/user-access-keys/{user-access-key-id}](#delete-a-user-access-key-id) | Delete a User Access Key ID |
| GET    | [/v1/authentications/user-access-keys/{user-access-key-id}/tokens](#get-a-list-of-tokens)                               | Get Token list                    |
| DELETE | [/v1/authentications/user-access-keys/{user-access-key-id}/tokens](#expire-multiple-tokens)                               | Expire multiple tokens                    |
| POST |[/v1/iam/projects/{project-id}/members](#create-a-project-iam-account) | Create a project IAM account |
| DELETE |[/v1/iam/projects/{project-id}/members](#delete-multiple-project-iam-accounts) | Delete multiple project IAM accounts |
| GET |[/v1/iam/projects/{project-id}/members/{member-uuid}](#view-a-project-member) | View a project IAM account |
| GET |[/v1/iam/projects/{project-id}/members](#view-project-iam-accounts) | View project IAM accounts |
| PUT |[/v1/iam/projects/{project-id}/members/{member-uuid}](#modify-project-iam-account-roles) | Modify project IAM account roles |
| GET |[/v1/authentications/organizations/{org-id}/user-access-keys](#view-all-credentials-of-members-under-organizations) | View all credentials of members under organizations |
| GET | [/v1/organizations](#view-your-own-organization-list) | View your own organization list |
| POST | [/v1/organizations](#add-your-own-organization) | Add your own organization |
| DELETE | [/v1/organizations/{org-id}](#delete-a-single-organization) | Delete a single organization |
| GET | [/v1/products](#retrieve-service-information-list) | View service information lists |
| GET | [/v1/messages/role](#view-role-descriptions-by-multiple-language) | View role descriptions in multiple languages |


<a id="create-a-project-member"></a>
### Create a project member { #create-a-project-member }

> POST "/v1/projects/{project-id}/members"

API to add members to a project.

<a id="create-a-project-member-required-permissions"></a>
#### Required permissions
`Project.Member.Create`

<a id="create-a-project-member-request-parameter"></a>
#### Request Parameter



| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Y | The project ID to which you want to add the member | 
| Request Body | request | CreateMemberRequest| Y | Request |




##### CreateMemberRequest


!!! danger "Caution"
    At least one of memberUuid, email, and userCode must have a value when requested.<br>If you're checking for values in the order memberUuid > email > userCode, add that member as a project member.<br>Only one project member can be created in a request.


| Name | Type | Required | Description |  
|------------ | ------------- | ------------- | ------------ |
|   assignRoles | List<UserAssignRoleProtocol>| Y | List of roles to assign to users  |
|   memberUuid | String| N | UUID of the member to add  |
|   email | String| N | The email of the member you want to add  |
|   userCode | String| N | IAM member ID to add  |


##### UserAssignRoleProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   roleId | String| Y | Role ID  |
|   conditions | List<AssignAttributeConditionProtocol>| N | Role condition attribute  |


##### AssignAttributeConditionProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   attributeId | String| Y | Condition attribute ID  |
|   attributeOperatorTypeCode | String| Y | Condition attribute operator<br>Available operators vary depending on the conditional attribute data type<br><ul><li>ALLOW</li><li>ALL_CONTAINS</li><li>ANY_CONTAINS</li><li>ANY_MATCH</li><li>BETWEEN</li><li>BEYOND</li><li>FALSE</li><li>GREATER_THAN</li><li>GREATER_THAN_OR_EQUAL_TO</li><li>LESS_THAN</li><li>LESS_THAN_OR_EQUAL_TO</li><li>NONE_MATCH</li><li>NOT_ALLOW</li><li>NOT_CONTAINS</li><li>TRUE</li></ul>  |
|   attributeValues | List<String>| Y | Condition attribute value  |


<a id="create-a-project-member-response-body"></a>
#### Response Body

```json
{
  "header" : {
    "isSuccessful" : true,
    "resultCode" : 0,
    "resultMessage" : "resultMessage"
  }
}
```

##### Response


| Name | Type           | Required | Description |   
|------------ |--------------| ------- | ------------ |
|   header | [Common response](#common-response) | Y |


<a id="add-a-project"></a>
### Add a project { #add-a-project }

> POST "/v1/organizations/{org-id}/projects"

API to add projects to your organization.

<a id="add-a-project-required-permissions"></a>
#### Required permissions
`Organization.Project.Create`

<a id="add-a-project-request-parameter"></a>
#### Request Parameter



| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
| Path |org-id | String| Y | Organization ID to add the project to | 
| Request Body | request | CreateProjectRequest| Y | Request |


##### CreateProjectRequest


| Name | Type | Required | Description |   
|------------ | ------------- | ------ | ------------ |
|   description | String| N | Project description (up to 100 characters) |
|   projectName | String| Y| Project name (up to 40 characters) |


<a id="add-a-project-response-body"></a>
#### Response Body

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
##### Response

| Name | Type | Required | Description |   
|------------ | ------------- | --------- | ------------ |
|   header | [Common response](#common-response)| Y  |
|   regDateTime | Date| Y   | When the project is created | 
|   description | String| N   | Project description | 
|   ownerId | String| Y   | Project owner member ID | 
|   projectName | String| Y   | Project name | 
|   projectId | String| Y   | Project ID | 
|   orgId | String| Y   | Organization ID | 
|   projectStatusCode | String| Yes   | Project status<br><ul><li>STABLE: In normal use</li><li>CLOSED: The payment has been made and the project is well closed.</li><li>BLOCKED: Prohibited by administrator</li><li>TERMINATED: All resources have been deleted due to delinquency.</li><li>DISABLED: All services are closed but not paid for</li></ul> |


<a id="delete-a-single-project-member"></a>
### Delete a single project member { #delete-a-single-project-member }

> DELETE "/v1/projects/{project-id}/members/{target-uuid}"

API to delete a user from a project.

<a id="delete-a-single-project-member-required-permissions"></a>
#### Required permissions
`Project.Member.Delete`

<a id="delete-a-single-project-member-request-parameter"></a>
#### Request Parameter



| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Y | Project ID | 
|  Path |target-uuid | String| Y | Member UUID to delete | 




<a id="delete-a-single-project-member-response-body"></a>
#### Response Body

```json
{
  "header" : {
    "isSuccessful" : true,
    "resultCode" : 0,
    "resultMessage" : "resultMessage"
  }
}
```

##### Response


| Name | Type | Required | Description |   
|------------ | ------------- | ------- | ------------ |
|   header | [Common response](#common-response)| Y |



<a id="delete-a-project"></a>
### Delete a project { #delete-a-project }

> DELETE "/v1/projects/{project-id}"

API to delete a project.

<a id="delete-a-project-required-permissions"></a>
#### Required permissions
You'll need one permission from the list below
* `Organization.Project.Delete`
* `Project.Delete`

<a id="delete-a-project-request-parameter"></a>
#### Request Parameter



| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Y | Project ID to delete | 






<a id="delete-a-project-response-body"></a>
#### Response Body

```json
{
  "header" : {
    "isSuccessful" : true,
    "resultCode" : 0,
    "resultMessage" : "resultMessage"
  }
}
```

##### Response


| Name | Type | Required | Description |   
|------------ | ------------- | ------- | ------------ |
|   header | [Common response](#common-response)| Y |



<a id="end-a-project-service"></a>
### End a project service { #end-a-project-service }

> DELETE "/v1/projects/{project-id}/products/{product-id}/disable"

API to disable a user-specified service so that it is no longer used by this project.

<a id="end-a-project-service-required-permissions"></a>
#### Required permissions
`Service Name: Product.Delete`

<a id="end-a-project-service-request-parameter"></a>
#### Request Parameter


| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Y | Project ID of the project you want to shut down | 
|  Path |product-id | String| Y | Service ID | 





<a id="end-a-project-service-response-body"></a>
#### Response Body

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

##### Response


| Name | Type | Required | Description |   
|------------ | ------------- | ------- | ------------ |
|   header | [Common response](#common-response)| Y |
|   childProducts | List&lt;ChildProduct>| N   | Subservice information for that service, not included if there are no subservices.<br>Requires you to disable the child service first and then disable the service.|

##### ChildProduct


| Name | Type | Required | Description |   
|------------ | ------------- | --------- | ------------ |
|   productId | String| Y  | 	Subservice ID | 
|   productName | String| Y  | Subservice name |
|   statusCode | String| Y |   Service status (STABLE, CLOSED) |


<a id="use-a-service-product"></a>
### Use a service product { #use-a-service-product }

> POST "/v1/projects/{project-id}/products/{product-id}/enable"

An API that requests to enable a service you specify to be available in your project.

<a id="use-a-service-product-required-permissions"></a>
#### Required permissions
`Service Name: Product.Create`

<a id="use-a-service-product-request-parameter"></a>
#### Request Parameter



| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |product-id | String| Y | Service ID | 
|  Path |project-id | String| Y | The ID of the project you want to use the service for | 


<a id="use-a-service-product-response-body"></a>
#### Response Body

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

##### Response


| Name | Type | Required | Description |   
|------------ | ------------- | ------- | ------------ |
|   header | [Common response](#common-response)| Y |
|   appKey | String| Y | AppKey information for the service your project is using|
|   parentProduct | ParentProduct| N | Shows parent service information if it exists, or does not include it if no parent service exists |
|   secretKey | String| N| Secret key information for the service your project is using.<br> Only available for services that use secret keys |


##### ParentProduct


| Name | Type | Required | Description |   
|------------ | ------------- | --------- | ------------ |
|   productId | String| Y  | Service ID |
|   productName | String| Y  | Service name |
|   statusCode | String| Y | Service status (STABLE, CLOSED) |





<a id="list-organization-roles"></a>
### List organization roles { #list-organization-roles }

> GET "/v1/organizations/{org-id}/roles"

API to request a list of roles that can be granted to users in your organization.

<a id="list-organization-roles-required-permissions"></a>
#### Required permissions
`Organization.RoleGroup.List`

<a id="list-organization-roles-request-parameter"></a>
#### Request Parameter



| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Y | Organization ID |
|  Query |categoryTypeCodes | List<String> | N | Role/Permission/Role Group Category Distinction (ROLE, PERMISSION, ROLE_GROUP) |
|  Query |roleNameLike | String| N | Role/privilege/role group name |
|  Query |limit | Integer| N | Number of displays per page, default 20 | 
|  Query |page | Integer| N | Target Page, default 1 |



<a id="list-organization-roles-response-body"></a>
#### Response Body

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



##### Response


| Name | Type | Required | Description |   
|------------ | ------------- | ------- | ------------ |
|   header | [Common response](#common-response)| Y |
|   roles | List<RoleProtocol>| Y  | Roles list |
|   totalCount | Integer| Y  | Total count |

##### RoleProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   categoryKey | String| Y | Role/Privilege Category Taxonomy Key<br><ul><li>RoleGroup: Project role group</li><li>OrgRoleGroup: Organization Role Group</li><li>OrgRole: Organization Role</li><li>ProjectRole: Project role</li><li>BillingRole: Billing-related roles</li><li>OrgServiceRole: Organization Service Role</li><li>ProjectServiceRole: Project service role</li><li>SystemRole: System-generated role</li></ul>  |
|   categoryTypeCode | String| Y | Role group/role/privilege distinguishing codes (ORG_ROLE_GROUP, PERMISSION, ROLE, ROLE_GROUP, SYSTEM) |
|   description | String| Y | Role/privilege description  |
|   roleCategory | String| Y | Role/Privilege Category Broad Classification (ORG_ROLE, ORG_ROLE_GROUP, ORG_SERVICE_ROLE, PROJECT_ROLE, PROJECT_ROLE_GROUP, PROJECT_SERVICE_ROLE, SYSTEM_ROLE) |
|   roleId | String| Y | Role/Privilege ID  |
|   roleName | String| Y | Role/privilege name  |


<a id="list-project-roles"></a>
### List project roles { #list-project-roles }

> GET "/v1/projects/{project-id}/roles"

API to request a list of roles that can be granted to project users.

<a id="list-project-roles-required-permissions"></a>
#### Required permissions
`Project.RoleGroup.List`

<a id="list-project-roles-request-parameter"></a>
#### Request Parameter


| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Y | Project ID | 
|  Query |categoryTypeCodes | List<String> | N | Role/Permission/Role Group Category Distinction (ROLE, PERMISSION, ROLE_GROUP) |
|  Query |roleNameLike | String| N | Role/privilege/role group name |
|  Query |limit | Integer| N | Number of displays per page, default 20 | 
|  Query |page | Integer| N | Target Page, default 1 |


<a id="list-project-roles-response-body"></a>
#### Response Body

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


##### Response


| Name | Type | Required | Description |   
|------------ | ------------- | ------- | ------------ |
|   header | [Common response](#common-response)| Y |
|   roles | List<[RoleProtocol](#roleprotocol)>| Y  | Roles list |
|   totalCount | Integer| Y  | Total count |

<a id="search-for-an-organization-domain"></a>
### Search for an organization domain { #search-for-an-organization-domain }

> GET "/v1/organizations/{org-id}/domains"

API to look up domains for a specific organization.

<a id="search-for-an-organization-domain-required-permissions"></a>
#### Required permissions
`Organization.Domain.List`

<a id="search-for-an-organization-domain-request-parameter"></a>
#### Request Parameter



| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Y | The ID of the organization to look up | 




<a id="search-for-an-organization-domain-response-body"></a>
#### Response Body

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

##### Response


| Name | Type | Required | Description |   
|------------ | ------------- | ------- | ------------ |
|   header | [Common response](#common-response)| Y |
|   domainList | List<OrgDomainProtocol>| Y  |


##### OrgDomainProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | --------- | ------------ |
|   orgDomainId | String| Y | Organization domain ID |
|   orgDomainName | String| Y | Organization domain name |


<a id="view-a-organization-member"></a>
### View a organization member { #view-a-organization-member }

> GET "/v1/organizations/{org-id}/members/{member-uuid}"

API to get members belonging to an organization.

<a id="view-a-organization-member-required-permissions"></a>
#### Required permissions
`Organization.Member.Get`

<a id="view-a-organization-member-request-parameter"></a>
#### Request Parameter



| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Y | Organization ID for which you want to look up members | 
|  Path |member-uuid | String| Y | 	Member UUID to look up | 





<a id="view-a-organization-member-response-body"></a>
#### Response Body

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

##### Response


| Name | Type | Required | Description |   
|------------ | ------------- | ------- | ------------ |
|   header | [Common response](#common-response)| Y |
|   orgMember | OrgMemberRoleBundleProtocol| N  | Added member information, not included on error |

##### OrgMemberRoleBundleProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ----- | ------------ |
|   email | String| Y | Member email |
|   id | String| N | Member ID (available only to IAM members) |
|   inviteStatusCode | String| Y |   COMPLETE, EXPIRE, UNKNOWN, WAIT |
|   joinYmdt | Date| Y | Organization member enrollment date |
|   memberName | String| Y| 	Member name |
|   memberTypeCode | String| Y| Member classification (TOAST_CLOUD: NHN Cloud member, IAM: IAM member) |
|   memberUuid | String| Y| Member's UUID |
|   recentLoginYmdt | Date| Y| Last login date |
|   recentPasswordModifyYmdt | Date| N| Date of last password change |
|   roleCode | String| N| Role ID |
|   roles | List<RoleBundleProtocol>| N | List of related roles (with condition attributes)  |
|   secondFactorCertificationYn | String| N| Whether to set up two-step sign-in (available to NHN Cloud members only) |


##### RoleBundleProtocol
| Name | Type | Required | Description |   
|------------ | ------------- | ----- | ------------ |
|   roleId | String| Y |  Role ID |
|   roleName | String| Y |  Role name |
|   description | String| N |  Role descriptions |
|   categoryKey | String| Y | Role/Privilege Category Taxonomy Key<br><ul><li>RoleGroup: Project role group</li><li>OrgRoleGroup: Organization Role Group</li><li>OrgRole: Organization Role</li><li>ProjectRole: Project role</li><li>BillingRole: Billing-related roles</li><li>OrgServiceRole: Organization Service Role</li><li>ProjectServiceRole: Project service role</li><li>SystemRole: System-generated role</li></ul>  |
|   categoryTypeCode | String| Y | Role group/role/privilege distinguishing codes (ORG_ROLE_GROUP, PERMISSION, ROLE, ROLE_GROUP, SYSTEM) |
|   conditions | List<AttributeConditionProtocol>| N | Condition attributes |
|   roleApplyPolicyCode | String| Y | Whether the role is enabled ALLOW, DENY |
|   regDateTime | Date| Y |  When the role was created |



##### AttributeConditionProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ----- | ------------ |
|   attributeDataTypeCode | String| Y |  Conditional attribute data type (BOOLEAN, DATETIME, DAY_OF_WEEK, IPADDRESS, NUMERIC, STRING, TIME) |
|   attributeDescription | String| N | Condition attribute description |
|   attributeId | String| Y | Condition attribute ID |
|   attributeName | String| Y | Condition attribute name |
|   attributeOperatorTypeCode | String| Y | Condition attribute operator<br>Available operators vary depending on the conditional attribute data type<br><ul><li>ALLOW</li><li>ALL_CONTAINS</li><li>ANY_CONTAINS</li><li>ANY_MATCH</li><li>BETWEEN</li><li>BEYOND</li><li>FALSE</li><li>GREATER_THAN</li><li>GREATER_THAN_OR_EQUAL_TO</li><li>LESS_THAN</li><li>LESS_THAN_OR_EQUAL_TO</li><li>NONE_MATCH</li><li>NOT_ALLOW</li><li>NOT_CONTAINS</li><li>TRUE</li></ul> |
|   attributeValues | List<String>| Y| Condition attribute value |



<a id="list-organization-members"></a>
### List organization members { #list-organization-members }

> POST "/v1/organizations/{org-id}/members/search"

API to get a list of NHN Cloud members belonging to an organization.

<a id="list-organization-members-required-permissions"></a>
#### Required permissions
`Organization.Member.List`

<a id="list-organization-members-request-parameter"></a>
#### Request Parameter



| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Y | Organization ID | 
| Request Body | request | SearchOrgMembersRequest| Y | Request |


##### SearchOrgMembersRequest


| Name | Type | Required | Description |   
|------------ | ------------- | --------- | ------------ |
|   memberStatusCodes | List<String>| N | Status of the member to look up<br><ul><li>STABLE: Invitation complete</li><li>INVITED: Invited</li><li>BLOCKED</li><li>NOT_EXIST</li><li>Withdraw</li></ul> |
|   roleIds | Set<String>| N  | Role IDs assigned to members |
|   paging | PagingBean| N  |

##### PagingBean


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   limit | Integer| N | Number of displays per page, default 20  |
|   page | Integer| N | Target Page, default 1  |




<a id="list-organization-members-response-body"></a>
#### Response Body

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
##### Response


| Name | Type | Required | Description |   
|------------ | ------------- | ------- | ------------ |
|   header | [Common response](#common-response)| Y |
|   orgMembers | List&lt;OrgMemberWithInviteMemberProtocol>| Y | Organization member list |
|   paging | PagingResponse| Y | About the page |

##### OrgMemberWithInviteMemberProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ----- | ------------ |
|   email | String| Y | The member's email address |
|   inviteStatusCode | String| N | Member's invitation status (COMPLETE, EXPIRE, UNKNOWN, WAIT) |
|   joinYmdt | Date| Y | When you joined |
|   maskingEmail | String| Y | Member's masked email  |
|   memberName | String| Y| Member's name |
|   memberTypeCode | String| Y| Member classification (TOAST_CLOUD: NHN Cloud member, IAM: IAM member) |
|   memberUuid | String| N| Member's UUID<br>Doesn't return a value if you're inviting |
|   recentLoginYmdt | Date| Y| Last login date |
|   recentPasswordModifyYmdt | Date| N| Date of last password change |
|   secondFactorCertificationYn | String| N|  Whether to set up two-step sign-in (available to NHN Cloud members only) |

##### PagingResponse


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   limit | Integer| N | Number of displays per page, default 20  |
|   page | Integer| N | Target Page, default 1  |
|   totalCount | Long| Y | Total number of cases  |




<a id="view-all-common-role-groups-for-projects-in-the-organization"></a>
### View all common role groups for projects in the organization { #view-all-common-role-groups-for-projects-in-the-organization }

> GET "/v1/organizations/{org-id}/project-role-groups"

API to get a list of project common role groups set up by your organization.

<a id="view-all-common-role-groups-for-projects-in-the-organization-required-permissions"></a>
#### Required permissions
`Organization.Project.RoleGroup.List`

<a id="view-all-common-role-groups-for-projects-in-the-organization-request-parameter"></a>
#### Request Parameter



| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Y | Organization ID for the lookup | 
|  Query |descriptionLike | String| N | Description | 
|  Query |roleGroupNameLike | String| No | Role group name |
|  Query |limit | Integer| N | Number of displays per page, default 20 |
|  Query |page | Integer| N | Target Page, default 1 |






<a id="view-all-common-role-groups-for-projects-in-the-organization-response-body"></a>
#### Response Body

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



##### Response


| Name | Type | Required | Description |   
|------------ | ------------- | --------- | ------------ |
|   header | [Common response](#common-response)| Y  |
|   paging | [PagingResponse](#pagingresponse)| Y  |
|   roleGroups | List<RoleGroupProtocol>| Y | List of available role groups in your project  |


##### RoleGroupProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ----- | ------------ |
|   description | String| N | Role group descriptions |
|   regDateTime | Date| Y | When the role group was created |
|   roleGroupId | String| Y | Role group ID |
|   roleGroupName | String| Y| Name of the role group |
|   roleGroupType | String| Y | Types of role groups<br><ul><li>ORG: Project common role group</li><li>ORG_ROLE_GROUP: Organization role group</li><li>PROJECT: Project role group</li> |


<a id="view-service-hierarchy"></a>
### View service hierarchy { #view-service-hierarchy }

> GET "/v1/product-uis/hierarchy"

API to return homepage category, homepage service information that is exposed on the bill.

<a id="view-service-hierarchy-required-permissions"></a>
#### Required Permissions
This API can be called without specific permissions if you are signed up to NHN Cloud.<br>
However, if you're viewing an organization's services, you must be a member of a project in that organization or a project under that organization.

<a id="view-service-hierarchy-request-parameter"></a>
#### Request Parameter



| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Query |productUiType | String| Y | Service UI Types<br><ul><li>PROJECT: Project service</li><li>ORG: Organization services</li><li>MARKET_PLACE: Marketplace services</li></ul> |
|  Query |orgId | String| Conditional | Organization ID must be entered if the product UI type is ORG |




<a id="view-service-hierarchy-response-body"></a>
#### Response Body

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

##### Response


| Name | Type | Required | Description |   
|------------ | ------------- | ------- | ------------ |
|   header | [Common response](#common-response)| Y |
|   productUiList | List<ProductUiHierarchyProtocol>| Y  | Homepage Category Service UI List |

##### ProductUiHierarchyProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ----- | ------------ |
|   children | List&lt;ProductUiHierarchyProtocol>| N | Homepage Service UI List |
|   manualLink | String| N|
|   parentProductUiId | String| N| Service UI divisions |
|   productId | String| N|
|   productUiId | String| N| Service UI identification key |
|   productUiName | String| N|


<a id="view-a-service-used-in-the-project"></a>
### View a service used in the project { #view-a-service-used-in-the-project }

> GET "/v1/projects/{project-id}/products/{product-id}"

* APIs to get information about specific services used by your project

<a id="view-a-service-used-in-the-project-required-permissions"></a>
#### Required permissions
`Service Name: ProductAppKey.Get`

<a id="view-a-service-used-in-the-project-request-parameter"></a>
#### Request Parameter



| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Y | Project ID to look up |
|  Path |product-id | String| Y | Service ID to look up |




<a id="view-a-service-used-in-the-project-response-body"></a>
#### Response Body

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

##### Response


| Name | Type | Required | Description |   
|------------ | ------------- | ------- | ------------ |
|   header | [Common response](#common-response)| Y |
|   hasUpdateSecretKeyPermission | Boolean| Y | Permission to reissue secret keys  |
|   product | ProjectProductRelationAndProductProtocol| Y  | Returns information about the services being used by the project for the specified service ID, not including on error |


##### ProjectProductRelationAndProductProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   appKey | String| Y | AppKey information for the service your project is using  |
|   externalId | String| N | Tenant ID<br>Only available if the tenant ID exists for the service |
|   productId | String| Y | Service ID  |
|   productName | String| Y | Service name  |
|   productSecretKeyCode | String| N | Whether to use a secret key<br>T: Enabled<br>Others: Not used (F, N) |
|   productStatusCode | String| Y | Service status (STABLE, CLOSED) |
|   projectId | String| Y | The project ID that uses the service  |
|   relationDate | Date| Y | When you started using the service  |
|   secretKey | String| Y | Service SecretKey<br>Only available on services that use secretKey  |
|   statusCode | String| Y | The service's usage status (STABLE, CLOSED) |
|   updateDate | Date| N | Service last modified date  |
|   updateUuid | String| N | Service AppKey Modifier UUID  |


<a id="view-a-project-member"></a>
### View a project member { #view-a-project-member }

> GET "/v1/projects/{project-id}/members/{member-uuid}"

API to get a specific member of a project.

<a id="view-a-project-member-required-permissions"></a>
#### Required permissions
`Project.Member.Get`

<a id="view-a-project-member-request-parameter"></a>
#### Request Parameter



| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Y | Project ID to look up members |
|  Path |member-uuid | String| Y | Member UUID to look up |




<a id="view-a-project-member-response-body"></a>
#### Response Body

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


##### Response


| Name | Type | Required | Description |   
|------------ | ------------- | ------- | ------------ |
|   header | [Common response](#common-response)| Y |
|   projectMember | ProjectMemberRoleBundleProtocol| Y  | Added member information, not included on error |


##### ProjectMemberRoleBundleProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   emailAddress | String| N | Member email address  |
|   maskingEmail | String| N | Member's masked email  |
|   memberName | String| N | Member name  |
|   memberTypeCode | String| N | Member Distinction (IAM, TOAST_CLOUD) |
|   relationDateTime | Date| N | Time to add members  |
|   roles | List<RoleBundleProtocol>| N | List of related roles (with condition attributes)  |
|   statusCode | String| N | Invitation status codes (COMPLETE, EXPIRE, UNKNOWN, WAIT) |
|   uuid | String| N | Member UUID  |


[RoleBundleProtocol](#rolebundleprotocol)



<a id="list-project-members"></a>
### List project members { #list-project-members }

> POST "/v1/projects/{project-id}/members/search"

API for getting a list of members belonging to a project.

<a id="list-project-members-required-permissions"></a>
#### Required permissions
`Project.Member.List`

<a id="list-project-members-request-parameter"></a>
#### Request Parameter


| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Y | Project ID to look up | 
| Request Body | request | SearchProjectMembersRequest| Y | Request |



##### SearchProjectMembersRequest


| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   memberStatusCodes | List<String>| N | Project member status codes (INVITED, STABLE) |
|   roleIds | List<String>| N | List of role IDs  |
|   paging | [PagingBean](#pagingbean) | N   |





<a id="list-project-members-response-body"></a>
#### Response Body

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

##### Response


| Name | Type | Required | Description |   
|------------ | ------------- | ------- | ------------ |
|   header | [Common response](#common-response)| Y |
|   paging | [PagingResponse](#pagingresponse)| Y  |
|   projectMembers | List<ProjectMemberProtocol>| Y | Project members  |



##### ProjectMemberProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   emailAddress | String| N | Member email address  |
|   maskingEmail | String| N | Member's masked email  |
|   memberName | String| N | Member name  |
|   memberTypeCode | String| N | Separate members |
|   relationDateTime | Date| N | Time to add members  |
|   statusCode | String| N | Invitation status codes (COMPLETE, EXPIRE, UNKNOWN, WAIT) |
|   uuid | String| N | Member UUID  |


<a id="view-a-project-role-group"></a>
### View a project role group { #view-a-project-role-group }

> GET "/v1/projects/{project-id}/project-role-groups/{role-group-id}"

API to get a project's role groups.

<a id="view-a-project-role-group-required-permissions"></a>
#### Required permissions
`Project.RoleGroup.Get`

<a id="view-a-project-role-group-request-parameter"></a>
#### Request Parameter



| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Y | Project ID to look up | 
|  Path |role-group-id | String| Y | Project role group ID<br>Project common role group IDs cannot be looked up | 




<a id="view-a-project-role-group-response-body"></a>
#### Response Body

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

##### Response


| Name | Type | Required | Description |   
|------------ | ------------- | --------- | ------------ |
|   header | [Common response](#common-response)| Y |
|   roleGroup | RoleGroupBundleProtocol| Y | Role groups with related roles  |

##### RoleGroupBundleProtocol

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   roleGroupId | String| N | Role group ID  |
|   roleGroupName | String| N | Role group name  |
|   description | String| N | Role group descriptions  |
|   roleGroupType | String| N | Role group distinction (organization, project)  |
|   roles | [List<RoleBundleProtocol>](#rolebundleprotocol)| N | List related roles  |
|   regDateTime | Date| N | Registered date and time  |



<a id="view-a-common-role-group-for-the-project-in-the-organization"></a>
### View a common role group for the project in the organization { #view-a-common-role-group-for-the-project-in-the-organization }

> GET "/v1/organizations/{org-id}/project-role-groups/{role-group-id}"

API to get project common role groups.

<a id="view-a-common-role-group-for-the-project-in-the-organization-required-permissions"></a>
#### Required permissions
`Organization.Project.RoleGroup.Get`

<a id="view-a-common-role-group-for-the-project-in-the-organization-request-parameter"></a>
#### Request Parameter


| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Y | Organization ID for the lookup | 
|  Path |role-group-id | String| Y | Project common role group ID | 


<a id="view-a-common-role-group-for-the-project-in-the-organization-response-body"></a>
#### Response Body

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


##### Response


| Name | Type | Required | Description |   
|------------ | ------------- | --------- | ------------ |
|   header | [Common response](#common-response)| Y |
|   roleGroup | [RoleGroupBundleProtocol](#rolegroupbundleprotocol) | Y | Role groups with related roles  |




<a id="view-all-project-role-groups"></a>
### View all project role groups { #view-all-project-role-groups }

> GET "/v1/projects/{project-id}/project-role-groups"

API to get all role groups in a project.

<a id="view-all-project-role-groups-required-permissions"></a>
#### Required permissions
`Project.RoleGroup.List`

<a id="view-all-project-role-groups-request-parameter"></a>
#### Request Parameter


| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Y | Project ID to look up | 
|  Query |descriptionLike | String| N | Description |
|  Query |roleGroupNameLike | String| No | Role group name |
|  Query |limit | Integer| N | Number of displays per page, default 20 |
|  Query |page | Integer| N | Target Page, default 1 |



<a id="view-all-project-role-groups-response-body"></a>
#### Response Body

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

##### Response


| Name | Type | Required | Description |   
|------------ | ------------- | --------- | ------------ |
|   header | [Common response](#common-response)| Y  |
|   paging | [PagingResponse](#pagingresponse)| Y  |
|   roleGroups | List<[RoleGroupProtocol](#rolegroupprotocol)>| Y | List of available role groups in your project  |

<a id="list-projects-in-your-organization"></a>
### List projects in your organization { #list-projects-in-your-organization }

> GET "/v1/organizations/{org-id}/projects"

API to get a list of projects in a STABLE state that belong to a specific organization.

<a id="list-projects-in-your-organization-required-permissions"></a>
#### Required permissions
Members of an organization

<a id="list-projects-in-your-organization-request-parameter"></a>
#### Request Parameter


| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Y | The ID of the organization to look up | 
|  Query |memberUuid | String| N | Organization member UUID |
|  Query |projectName | String| N | Project name |
|  Query |page | Integer| N | Target Page, default 1 |
|  Query |limit | Integer| N | Number of displays per page, default 20 |


<a id="list-projects-in-your-organization-response-body"></a>
#### Response Body

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


##### Response


| Name | Type | Required | Description |   
|------------ | ------------- | ------- | ------------ |
|   header | [Common response](#common-response)| Y |
|   paging | [PagingResponse](#pagingresponse) | Y |
|   projectList | List<OrgProjectMemberRoleProtocol>| Y |



##### OrgProjectMemberRoleProtocol

| Name | Type | Required | Description |   
|------------ | ------------- | ----- | ------------ |
|   delDateTime | Date| N | Project deletion date |
|   description | String| N | Project description |
|   modDateTime | Date| N| Project modification date |
|   orgId | String| Y| The organization ID the project belongs to |
|   projectId | String| Y| Project ID |
|   projectName | String| Y| Project name |
|   projectStatusCode | String| Y | Project status<br><ul><li>STABLE: In normal use</li><li>CLOSED: The payment has been made and the project is well closed.</li><li>BLOCKED: Prohibited by administrator</li><li>TERMINATED: All resources have been deleted due to delinquency.</li><li>DISABLED: All services are closed but not paid for</li></ul> |
|   regDateTime | Date| Y| Project registration date |


<a id="list-organization-governance-in-use"></a>
### List organization governance in use { #list-organization-governance-in-use }

> GET "/v1/organizations/{org-id}/governances"

API to get the active governance.

<a id="list-organization-governance-in-use-required-permissions"></a>
#### Required permissions
`Organization.Governance.List`

<a id="list-organization-governance-in-use-request-parameter"></a>
#### Request Parameter

| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Y | Organization ID for the lookup | 



<a id="list-organization-governance-in-use-response-body"></a>
#### Response Body

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



##### Response


| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common response](#common-response)| Y   |
|   usingGovernances | List<GovernanceProtocol>| N | List governance in use  |


##### GovernanceProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   governanceTypeCode | String| No | Governance type<br>- APPROVE_PROCESS: Approval processing<br>- BLOCK_STORAGE_SNAPSHOT: Whether to use BlockStorage's Snapshot function<br>- IAAS_RESOURCE_PROTECTION_AND_SEPARATED_NETWORK: IAAS resource permission control and access terminal restriction settings<br>- PRIVACY_PROTECTION: privacy protection<br>- UNIQUE_INSTANCE_NAME: prevent instance name duplication |
|   regDatetime | Date| N | When to enable governance  |


<a id="create-a-common-role-group-for-projects-in-the-organization"></a>
### Create a common role group for projects in the organization { #create-a-common-role-group-for-projects-in-the-organization }

> POST "/v1/organizations/{org-id}/project-role-groups"

API to create project common role groups.


<a id="create-a-common-role-group-for-projects-in-the-organization-required-permissions"></a>
#### Required permissions
`Organization.Project.RoleGroup.Create`

<a id="create-a-common-role-group-for-projects-in-the-organization-request-parameter"></a>
#### Request Parameter

| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Y | Organization ID | 
| Request Body | request | CreateRoleGroupRequest| Y | Request |

##### CreateRoleGroupRequest

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   description | String| N | Role group descriptions  |
|   roleGroupName | String| Y | Role group name  |
|   roles | List<AssignRoleProtocol>| Y | List roles to assign to a role group  |


##### AssignRoleProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   conditions | List<[AssignAttributeConditionProtocol](#assignattributeconditionprotocol)>| N | Role condition attribute  |
|   roleApplyPolicyCode | String| Y | Whether the role is enabled ALLOW, DENY |
|   roleId | String| Y | Role ID  |




<a id="create-a-common-role-group-for-projects-in-the-organization-response-body"></a>
#### Response Body

```json
{
  "header" : {
    "isSuccessful" : true,
    "resultCode" : 0,
    "resultMessage" : "resultMessage"
  }
}
```

##### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common response](#common-response)| Y   |


<a id="delete-a-project-common-role-group-in-the-organization"></a>
### Delete a project common role group in the organization { #delete-a-project-common-role-group-in-the-organization }

> DELETE "/v1/organizations/{org-id}/project-role-groups"

API to delete a project common role group.

<a id="delete-a-project-common-role-group-in-the-organization-required-permissions"></a>
#### Required permissions
`Organization.Project.RoleGroup.Delete`

<a id="delete-a-project-common-role-group-in-the-organization-request-parameter"></a>
#### Request Parameter


| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Y | Organization ID | 
| Request Body | request | DeleteRoleGroupRequest| Y | Request |


##### DeleteRoleGroupRequest


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   roleGroupIds | List<String>| Y | List of role group IDs  |


<a id="delete-a-project-common-role-group-in-the-organization-response-body"></a>
#### Response Body

```json
{
  "header" : {
    "isSuccessful" : true,
    "resultCode" : 0,
    "resultMessage" : "resultMessage"
  }
}
```

##### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common response](#common-response)| Y   |

<a id="modify-your-organizations-project-common-role-group-information"></a>
### Modify your organization's project common role group information { #modify-your-organizations-project-common-role-group-information }

> PUT "/v1/organizations/{org-id}/project-role-groups/{role-group-id}/infos"

API to modify the name and description of a project's common role group.

<a id="modify-your-organizations-project-common-role-group-information-required-permissions"></a>
#### Required permissions
`Organization.Project.RoleGroup.Update`

<a id="modify-your-organizations-project-common-role-group-information-request-parameter"></a>
#### Request Parameter


| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Y | Organization ID | 
|  Path |role-group-id | String| Y | Role group ID | 
| Request Body | request | UpdateRoleGroupInfoRequest| Y | Request |


##### UpdateRoleGroupInfoRequest


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   description | String| N | Role group descriptions  |
|   roleGroupName | String| Y | Role group name  |



<a id="modify-your-organizations-project-common-role-group-information-response-body"></a>
#### Response Body

```json
{
  "header" : {
    "isSuccessful" : true,
    "resultCode" : 0,
    "resultMessage" : "resultMessage"
  }
}
```

##### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common response](#common-response)| Y   |

<a id="modify-your-organizations-project-common-roles-group-roles"></a>
### Modify your organization's project common roles group roles { #modify-your-organizations-project-common-roles-group-roles }

> PUT "/v1/organizations/{org-id}/project-role-groups/{role-group-id}/roles"

API to modify roles in the project common roles group.

<a id="modify-your-organizations-project-common-roles-group-roles-required-permissions"></a>
#### Required permissions
`Organization.Project.RoleGroup.Update`

<a id="modify-your-organizations-project-common-roles-group-roles-request-parameter"></a>
#### Request Parameter

| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Y | Organization ID | 
|  Path |role-group-id | String| Y | Role group ID | 
| Request Body | request | UpdateRoleGroupRequest| Y | Request |


##### UpdateRoleGroupRequest


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   roles | List<[AssignRoleProtocol](#assignroleprotocol)>| Y | List roles to assign to a role group  |




<a id="modify-your-organizations-project-common-roles-group-roles-response-body"></a>
#### Response Body

```json
{
  "header" : {
    "isSuccessful" : true,
    "resultCode" : 0,
    "resultMessage" : "resultMessage"
  }
}
```

##### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common response](#common-response)| Y   |

<a id="create-a-project-role-group"></a>
### Create a project role group { #create-a-project-role-group }

> POST "/v1/projects/{project-id}/project-role-groups"

API to create role groups in your project.


<a id="create-a-project-role-group-required-permissions"></a>
#### Required permissions
`Project.RoleGroup.Create`

<a id="create-a-project-role-group-request-parameter"></a>
#### Request Parameter


| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Y | Project ID | 
| Request Body | request | [CreateRoleGroupRequest](#createrolegrouprequest)| Y | Request |





<a id="create-a-project-role-group-response-body"></a>
#### Response Body

```json
{
  "header" : {
    "isSuccessful" : true,
    "resultCode" : 0,
    "resultMessage" : "resultMessage"
  }
}
```

##### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common response](#common-response)| Y   |

<a id="delete-a-project-role-group"></a>
### Delete a project role group { #delete-a-project-role-group }

> DELETE "/v1/projects/{project-id}/project-role-groups"

API to delete a project role group.


<a id="delete-a-project-role-group-required-permissions"></a>
#### Required permissions
`Project.RoleGroup.Delete`

<a id="delete-a-project-role-group-request-parameter"></a>
#### Request Parameter


| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Y | Project ID | 
| Request Body | request | [DeleteRoleGroupRequest](#deleterolegrouprequest)| Y | Request |





<a id="delete-a-project-role-group-response-body"></a>
#### Response Body

```json
{
  "header" : {
    "isSuccessful" : true,
    "resultCode" : 0,
    "resultMessage" : "resultMessage"
  }
}
```

##### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common response](#common-response)| Y   |

<a id="edit-project-role-group-information"></a>
### Edit project role group information { #edit-project-role-group-information }

> PUT "/v1/projects/{project-id}/project-role-groups/{role-group-id}/infos"

API to modify the name and description of a project role group.

<a id="edit-project-role-group-information-required-permissions"></a>
#### Required permissions
`Project.RoleGroup.Update`

<a id="edit-project-role-group-information-request-parameter"></a>
#### Request Parameter

| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Y | Project ID | 
|  Path |role-group-id | String| Y | Role group ID | 
| Request Body | request |[UpdateRoleGroupInfoRequest](#updaterolegroupinforequest)| Y | Request |





<a id="edit-project-role-group-information-response-body"></a>
#### Response Body

```json
{
  "header" : {
    "isSuccessful" : true,
    "resultCode" : 0,
    "resultMessage" : "resultMessage"
  }
}
```

##### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common response](#common-response)| Y   |


<a id="modify-project-role-group-roles"></a>
### Modify project role group roles { #modify-project-role-group-roles }

> PUT "/v1/projects/{project-id}/project-role-groups/{role-group-id}/roles"

API to modify roles in the project role group.

<a id="modify-project-role-group-roles-required-permissions"></a>
#### Required permissions
`Project.RoleGroup.Update`

<a id="modify-project-role-group-roles-request-parameter"></a>
#### Request Parameter

| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Y | Project ID | 
|  Path |role-group-id | String| Y | Role group ID | 
| Request Body | request | UpdateRoleGroupRequest| Y | Request |

##### UpdateRoleGroupRequest


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   roles | List<[AssignRoleProtocol](#assignroleprotocol)>| Y | List roles to assign to a role group  |





<a id="modify-project-role-group-roles-response-body"></a>
#### Response Body

```json
{
  "header" : {
    "isSuccessful" : true,
    "resultCode" : 0,
    "resultMessage" : "resultMessage"
  }
}
```

##### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common response](#common-response)| Y   |


<a id="view-all-organization-role-groups"></a>
### View All Organization Role Groups { #view-all-organization-role-groups }

> GET "/v1/organizations/{org-id}/org-role-groups"

An API to view all organization role groups.

<a id="view-all-organization-role-groups-required-permission"></a>
#### Required Permission

`Organization.RoleGroup.List`

<a id="view-all-organization-role-groups-request-parameter"></a>
#### Request Parameter

| Category | name | Type | Required | Description |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| Path | org-id | String | Y | Organization ID to be searched |
| Query | descriptionLike | String | N | Description (view results containing that string) |
| Query | roleGroupNameLike | String | N | Role group name (search for results containing that string) |
| Query | limit | Integer | N | Number of views per page (default: 20, minimum: 1, maximum: 2,000) |
| Query | page | Integer | N | target page (default: 1, minimum: 1) |

<a id="view-all-organization-role-groups-response-body"></a>
#### Response Body

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

##### Response

| Name | Type | Required | Description |
| ------------ | ------------- | --------- | ------------ |
| header | [Common Response](#common-response) | Y | |
| paging | [PagingResponse](#pagingresponse) | Y | |
| roleGroups | List&lt;[RoleGroupProtocol](#rolegroupprotocol)> | Y | List of role groups available in your organization |

<a id="view-a-single-organization-role-group"></a>
### View a Single Organization Role Group { #view-a-single-organization-role-group }

> GET "/v1/organizations/{org-id}/org-role-groups/{role-group-id}"

An API to view an organization's role group.

<a id="view-a-single-organization-role-group-required-permission"></a>
#### Required Permission

`Organization.RoleGroup.Get`

<a id="view-a-single-organization-role-group-request-parameter"></a>
#### Request Parameter

| Category | name | Type | Required | Description |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| Path | org-id | String | Y | Organization ID to be searched |
| Path | role-group-id | String | Y | Organization role group ID |

<a id="view-a-single-organization-role-group-response-body"></a>
#### Response Body

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

##### Response

| Name | Type | Required | Description |
| ------------ | ------------- | --------- | ------------ |
| header | [Common Response](#common-response) | Y | |
| roleGroup | [RoleGroupBundleProtocol](#rolegroupbundleprotocol) | Y | Role group with associated roles |

<a id="create-organization-role-group"></a>
### Create Organization Role Group { #create-organization-role-group }

> POST "/v1/organizations/{org-id}/org-role-groups"

An API to create a role group in the organization.

<a id="create-organization-role-group-required-permission"></a>
#### Required Permission

`Organization.RoleGroup.Create`

<a id="create-organization-role-group-request-parameter"></a>
#### Request Parameter

| Category | Name | Type | Required | Description |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| Path | org-id | String | Y | Organization ID |
| Request Body | request | [CreateRoleGroupRequest](#createrolegrouprequest) | Y | Request |

<a id="create-organization-role-group-response-body"></a>
#### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

##### Response

| Name | Type | Required | Description |
| ------------ | ------------- | ----------- | ------------ |
| header | [Common Response](#common-response) | Y | |

<a id="delete-organization-role-group"></a>
### Delete Organization Role Group { #delete-organization-role-group }

> DELETE "/v1/organizations/{org-id}/org-role-groups"

An API to delete organization role groups.

<a id="delete-organization-role-group-required-permission"></a>
#### Required Permission

`Organization.RoleGroup.Delete`

<a id="delete-organization-role-group-request-parameter"></a>
#### Request Parameter

| Category | Name | Type | Required | Description |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| Path | org-id | String | Y | Organization ID |
| Request Body | request | [DeleteRoleGroupRequest](#deleterolegrouprequest) | Y | Request |

<a id="delete-organization-role-group-response-body"></a>
#### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

##### Response

| Name | Type | Required | Description |
| ------------ | ------------- | ----------- | ------------ |
| header | [Common Response](#common-response) | Y | |

<a id="modify-organization-role-group-information"></a>
### Modify Organization Role Group Information { #modify-organization-role-group-information }

> PUT "/v1/organizations/{org-id}/org-role-groups/{role-group-id}/infos"

An API to modify the name and description of an organization role group.

<a id="modify-organization-role-group-information-required-permission"></a>
#### Required Permission

`Organization.RoleGroup.Update`

<a id="modify-organization-role-group-information-request-parameter"></a>
#### Request Parameter

| Category | name | Type | Required | Description |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| Path | org-id | String | Y | Organization ID |
| Path | role-group-id | String | Y | Role group ID |
| Request Body | request | [UpdateRoleGroupInfoRequest](#updaterolegroupinforequest) | Y | Request |

<a id="modify-organization-role-group-information-response-body"></a>
#### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

##### Response

| Name | Type | Required | Description |
| ------------ | ------------- | ----------- | ------------ |
| header | [Common Response](#common-response)| Y | |


<a id="modify-an-organization-role-groups-role"></a>
### Modify an Organization Role Group's Role { #modify-an-organization-role-groups-role }

> PUT "/v1/organizations/{org-id}/org-role-groups/{role-group-id}/roles"

An API to modify roles in an organization role group.

<a id="modify-an-organization-role-groups-role-required-permission"></a>
#### Required Permission

`Organization.RoleGroup.Update`

<a id="modify-an-organization-role-groups-role-request-parameter"></a>
#### Request Parameter

| Category | name | Type | Required | Description |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| Path | org-id | String | Y | Organization ID |
| Path | role-group-id | String | Y | Role group ID |
| Request Body | request | UpdateRoleGroupRequest | Y | Request |

##### UpdateRoleGroupRequest

| name | Type | Required | Description |
| ------------ | ------------- | ------------- | ------------ |
| roles | List&lt;[AssignRoleProtocol](#assignroleprotocol)> | Y | List of roles to assign to role group |

<a id="modify-an-organization-role-groups-role-response-body"></a>
#### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

##### Response

| Name | Type | Required | Description |
| ------------ | ------------- | ----------- | ------------ |
| header | [Common Response](#common-response) | Y | |


<a id="modify-organization-member-roles"></a>
### Modify organization member roles { #modify-organization-member-roles }

> PUT "/v1/organizations/{org-id}/members/{member-uuid}"

API to modify the roles of members who belong to this organization.


<a id="modify-organization-member-roles-required-permissions"></a>
#### Required permissions
`Organization.Member.Update`


<a id="modify-organization-member-roles-request-parameter"></a>
#### Request Parameter


| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Y | Organization ID | 
|  Path |member-uuid | String| Y | UUID of the member to modify | 
| Request Body | request | UpdateMemberRoleRequest| Y | Request |


##### UpdateMemberRoleRequest


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   assignRoles | List<[UserAssignRoleProtocol](#userassignroleprotocol)>| Y | List of roles to assign to users  |





<a id="modify-organization-member-roles-response-body"></a>
#### Response Body

```json
{
  "header" : {
    "isSuccessful" : true,
    "resultCode" : 0,
    "resultMessage" : "resultMessage"
  }
}
```

##### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common response](#common-response)| Y   |

<a id="modify-project-member-roles"></a>
### Modify project member roles { #modify-project-member-roles }

> PUT "/v1/projects/{project-id}/members/{member-uuid}"

API to modify the role of a specified member in a project.

<a id="modify-project-member-roles-required-permissions"></a>
#### Required permissions
`Project.Member.Update`

<a id="modify-project-member-roles-request-parameter"></a>
#### Request Parameter

| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Y | Project ID | 
|  Path |member-uuid | String| Y | Member UUID to change role to | 
| Request Body | request | [UpdateMemberRoleRequest](#updatememberrolerequest)| Y | Request |




<a id="modify-project-member-roles-response-body"></a>
#### Response Body

```json
{
  "header" : {
    "isSuccessful" : true,
    "resultCode" : 0,
    "resultMessage" : "resultMessage"
  }
}
```

##### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common response](#common-response)| Y   |

<a id="view-organization-iam-members"></a>
### View organization IAM members { #view-organization-iam-members }

> GET "/v1/iam/organizations/{org-id}/members/{member-uuid}"

API to get the IAM members in your organization.

<a id="view-organization-iam-members-required-permissions"></a>
#### Required permissions
`Organization.Member.Iam.Get`


<a id="view-organization-iam-members-request-parameter"></a>
#### Request Parameter

| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Y | Organization ID to look up | 
|  Path |member-uuid | String| Y | The IAM member UUID of the organization to look up | 


<a id="view-organization-iam-members-response-body"></a>
#### Response Body

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

##### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common response](#common-response)| Y   |
|   orgMember | OrgIamMemberRoleBundleProtocol| N  |

##### OrgIamMemberRoleBundleProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ----- | ------------ |
|   corporate | String| N |Company name |
|   country | String| N | Nationality (nationality of the organization owner) |
|   createdAt | Date| N | Date and time of creation |
|   creationType | String| N| Account creation type |
|   department | String| N|Department name |
|   emailAddress | String| Y | IAM account email address  |
|   englishName | String| N| English name | 
|   id | String| Y | IAM account UUID  |
|   idProviderId | String| No| Certification Authority ID (if using external authentication) |
|   idProviderType | String| N| service: IAM direct sign-in<br>SSO: Customer SSO integration |
|   idProviderUserId | String| No|User ID provided by an external certification authority |
|   lastAccessedAt | Date| N| The account's last access date, returning null if not present |
|   lastLoggedInAt | Date| N| The account's last login date, returning null if not found |
|   lastLoggedInIp | String| N| The account's last login IP address, returning null if not present |
|   maskingEmail | String| No | Masked email address of the IAM account  |
|   mobilePhone | String| N | IAM account's mobile phone number  |
|   mobilePhoneCountryCode | String| N|Country code for mobile phone numbers |
|   name | String| Y | Name of the IAM account  |
|   nativeName | String| N| Native language name |
|   nickname | String| N| User nickname |
|   officeHoursBegin | String| N| Work start time example: 09:00 |
|   officeHoursEnd | String| N| Work end time example: 18:00 |
|   organizationId | String| Y | Organization ID for the IAM account  |
|   passwordChangedAt | Date| N| When the account's last password was changed, returning null if none |
|   position | String| N| Position |
|   profileImageUrl | String| N| Profile image URL |
|   roles | [List<RoleBundleProtocol>](#rolebundleprotocol)| N | List of related roles (with condition attributes)  |
|   saasRoles | List<IamMemberRole>| N | IAM account roles  |
|   status | String| N| Account's status |
|   telephone | String| N | IAM account's phone number  |
|   userCode | String| Y | IAM account ID  |



##### IamMemberRole


| Name | Type | Required | Description |   
|------------ | ------------- | ------- | ------------ |
|   productId | String| N |
|   productName | String| N |
|   role | String| N |


<a id="list-organization-iam-members"></a>
### List organization IAM members { #list-organization-iam-members }

> GET "/v1/iam/organizations/{org-id}/members"

API to get a list of IAM members that belong to this organization.

<a id="list-organization-iam-members-required-permissions"></a>
#### Required permissions
`Organization.Member.Iam.List`

<a id="list-organization-iam-members-request-parameter"></a>
#### Request Parameter

| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Y | Organization ID | 
|  Query |email | String| N | IAM member's email address |
|  Query |emailLike | String| N |  |
|  Query |idProviderType | String| N | service: IAM direct sign-in<br>SSO: Customer SSO integration |
|  Query |nameLike | String| N |  |
|  Query |statuses | List<String>| N |  |
|  Query |userCode | String| N | IAM member ID |
|  Query |userCodeLike | String| N |  |
|  Query |limit | Integer| N | Number of displays per page, default 20 |
|  Query |page | Integer| N | Target Page, default 1 |

<a id="list-organization-iam-members-response-body"></a>
#### Response Body

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


##### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common response](#common-response)| Y   |
|   orgMembers | List<IamOrgMemberProtocol>| N | Organization IAM member list  |
|   paging | [PagingResponse](#pagingresponse)| N  |

##### IamOrgMemberProtocol

| Name | Type | Required | Description |   
|------------ | ------------- | --------- | ------------ |
| id | String | N | IAM account UUID | 
| userCode | String | Y | IAM account ID to use for sign-in | 
| name | String | Y | Username of the IAM account | 
| emailAddress | String |  Y | IAM account's email address<br>Used to receive notifications or to change your password. |
| maskingEmail | String | N | Masked email addresses for IAM accounts |
| mobilePhone | String | N | IAM account's mobile phone number |
| telephone | String | N | IAM account's phone number |
| position | String | N | Position |
| department | String | N | Department name |
| corporate | String | N | Company name  |
| profileImageUrl | String | N | Profile image URL |
| englishName | String | N | English name |
| nativeName | String | N | Native language name |
| nickname | String | N | User nickname |
| officeHoursBegin | String | N | Work start time example: 09:00 |
| officeHoursEnd | String | N | Work end time example: 18:00 |
| status | String | Y | Member status can be changed<br><ul><li>member: in good standing</li><li>leaved: Request to leave</li></ul>Must specify member at creation time |
| creationType | String | N | SSO, invited, and registered |
| idProviderId | String | N | Certification Authority ID (if using external authentication) |
| idProviderType | String | N | service: IAM direct sign-in (default)<br>SSO: Customer SSO integration (cannot be set up if not integrated) |
| idProviderUserId | String | N | User ID provided by an external certification authority |
| createdAt | Date | N | Date and time of creation |
| lastAccessedAt | Date | N | Last Access Date |
| lastLoggedInAt | Date | N | Last login date |
| lastLoggedInIp | String | N | Last logged in IP |
| passwordChangedAt | Date | N | When to change your password |
| mobilePhoneCountryCode | String | N | Country code for mobile phone numbers  |
| organizationId | String | N | Organization ID of the IAM account |
| country | String | N | Nationality (nationality of the organization owner) |





<a id="add-an-organization-iam-member"></a>
### Add an organization IAM member { #add-an-organization-iam-member }

> POST "/v1/iam/organizations/{org-id}/members"

API to add IAM members to your organization.

<a id="add-an-organization-iam-member-required-permissions"></a>
#### Required permissions
`Organization.Member.Iam.Create`


<a id="add-an-organization-iam-member-request-parameter"></a>
#### Request Parameter

| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Y | Organization ID | 
| Request Body | request | AddIamOrgMemberRequest| Y | Request |

##### AddIamOrgMemberRequest


| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   member | [AddIamOrgMemberProtocol](#addiamorgmemberprotocol)| Y   |


##### AddIamOrgMemberProtocol

| Name | Type | Required | Description |   
|------------ | ------------- | --------- | ------------ |
| userCode | String | Y | The IAM account ID to use for signing in | 
| name | String | Y | Username of the IAM account | 
| emailAddress | String |  Y | Email address of the IAM account<br>Used to receive notifications or password change. |
| mobilePhone | String | N | IAM account's mobile phone number |
| telephone | String | N | IAM account's phone number |
| position | String | N | Position |
| department | String | N | Department name |
| corporate | String | N | Company name |
| profileImageUrl | String | N | Profile image URL |
| englishName | String | N | English name |
| nativeName | String | N | Native language name |
| nickname | String | N | User nickname |
| officeHoursBegin | String | N | Work start time example: 09:00 |
| officeHoursEnd | String | N | Work end time example: 18:00 |
| status | String | Y | Member status can be changed<br><ul><li>member: in good standing</li><li>leaved: Request to leave</li></ul>Must specify member at creation time |
| creationType | String | N | SSO, invited, and registered |
| mobilePhoneCountryCode | String | N | Country code for mobile phone numbers, required when entering a mobile phone number  |



<a id="add-an-organization-iam-member-response-body"></a>
#### Response Body

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


##### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common response](#common-response)| Y   |
|   uuid | String| N | IAM member UUID  |




<a id="send-an-iam-member-password-change-email"></a>
### Send an IAM member password change email { #send-an-iam-member-password-change-email }

> POST "/v1/iam/organizations/{org-id}/members/{member-id}/send-password-setup-mail"

API to send an email to an IAM member to change their password.

<a id="send-an-iam-member-password-change-email-required-permissions"></a>
#### Required permissions
`Organization.Member.Iam.Update`


<a id="send-an-iam-member-password-change-email-request-parameter"></a>
#### Request Parameter

| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Y | Target organization ID | 
|  Path |member-id | String| Y | UUID of the IAM member whose password you want to change | 
| Request Body | request | SendPasswordSetupMailRequest| Y | Request |



##### SendPasswordSetupMailRequest


| Name | Type | Required | Description |   
|------------ | ------------- | --------- | ------------ |
|   locale | String| Yes  | User's locale information<br>Example: en |
|   returnUrl | String| Yes  | The address of the page you'll be directed to after you change your password via email change notification.<br>You must enter the toast.com, dooray.com, or nhncloud.com domain in the Go To address information |


<a id="send-an-iam-member-password-change-email-response-body"></a>
#### Response Body

```json
{
  "header" : {
    "isSuccessful" : true,
    "resultCode" : 0,
    "resultMessage" : "resultMessage"
  }
}
```

##### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common response](#common-response)| Y   |

<a id="modify-organization-iam-member-information"></a>
### Modify organization IAM member information { #modify-organization-iam-member-information }

> PUT "/v1/iam/organizations/{org-id}/members/{member-uuid}"

API to modify your organization's IAM member information.

<a id="modify-organization-iam-member-information-required-permissions"></a>
#### Required permissions
`Organization.Member.Iam.Update`

<a id="modify-organization-iam-member-information-request-parameter"></a>
#### Request Parameter

| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Y | 	Target organization ID | 
|  Path |member-uuid | String| Y | UUID of the IAM member you want to change | 
| Request Body | request | UpdateIamMemberRequest| Y | Request |


##### UpdateIamMemberRequest


| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   member | [UpdateIamOrgMemberProtocol](#updateiamorgmemberprotocol)| Y   |


##### UpdateIamOrgMemberProtocol

| Name | Type | Required | Description |   
|------------ | ------------- | --------- | ------------ |
| userCode | String | Y | IAM account ID to use for signing in | 
| name | String | Y | Username of the IAM account | 
| emailAddress | String |  Y | Email address of the IAM account<br>Used to receive notifications or password change. |
| mobilePhone | String | N | IAM account's mobile phone number |
| telephone | String | N | IAM account's phone number |
| position | String | N | Position |
| department | String | N | Department name |
| corporate | String | N | Company name |
| profileImageUrl | String | N | Profile image URL |
| englishName | String | N | English name |
| nativeName | String | N | Native language name |
| nickname | String | N | User nickname |
| officeHoursBegin | String | N | Work start time example: 09:00 |
| officeHoursEnd | String | N | Work end time example: 18:00 |
| status | String | Y | Member status can be changed<br><ul><li>member: in good standing</li><li>leaved: Request to leave</li></ul>Must specify member at creation time |
| creationType | String | No | SSO, invited, and registered |
| idProviderUserId | String | No | User ID provided by an external certification authority |
| mobilePhoneCountryCode | String | N | Country code for mobile phone numbers, required when entering a mobile phone number |


<a id="modify-organization-iam-member-information-response-body"></a>
#### Response Body

```json
{
  "header" : {
    "isSuccessful" : true,
    "resultCode" : 0,
    "resultMessage" : "resultMessage"
  }
}
```

##### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common response](#common-response)| Y   |

<a id="change-an-organization-iam-member-password"></a>
### Change an organization IAM member password { #change-an-organization-iam-member-password }

> POST "/v1/iam/organizations/{org-id}/members/{member-id}/set-password"

API to change the password of an organization IAM member.

<a id="change-an-organization-iam-member-password-required-permissions"></a>
#### Required permissions
`Organization.Member.Iam.Update`

<a id="change-an-organization-iam-member-password-request-parameter"></a>
#### Request Parameter

| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Y | Target organization ID | 
|  Path |member-id | String| Y | UUID of the IAM member whose password you want to change | 
| Request Body | request | UpdateIamPasswordRequest| Y | Request |


##### UpdateIamPasswordRequest


| Name | Type | Required | Description |   
|------------ | ------------- | --------- | ------------ |
|   password | String| Y  | Password to set | 


<a id="change-an-organization-iam-member-password-response-body"></a>
#### Response Body

```json
{
  "header" : {
    "isSuccessful" : true,
    "resultCode" : 0,
    "resultMessage" : "resultMessage"
  }
}
```

##### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common response](#common-response)| Y   |

<a id="listorganization-ip-acls"></a>
### Listorganization IP ACLs { #listorganization-ip-acls }

> GET "/v1/organizations/{org-id}/products/ip-acl"

API to get IP ACL settings.

<a id="listorganization-ip-acls-required-permissions"></a>
#### Required permissions
`Organization.Governance.IpAcl.List`

<a id="listorganization-ip-acls-request-parameter"></a>
#### Request Parameter

| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Y | Organization ID | 


<a id="listorganization-ip-acls-response-body"></a>
#### Response Body

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


##### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common response](#common-response)| Y   |
|   orgIpAcl | List&lt;OrgIpAclProtocol>| Y  | If the result is an empty list, the setting is not set. |

##### OrgIpAclProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | --------- | ------------ |
|   ips | List<String>| Y  | Allowed IPs | 
|   productId | String| Y  | Service ID<br>If undefined, set to Common Settings|

<a id="view-organization-iam-sign-in-session-settings-information"></a>
### View organization IAM sign-in session settings information { #view-organization-iam-sign-in-session-settings-information }

> GET "/v1/iam/organizations/{org-id}/settings/session"

API to get login session settings information.

<a id="view-organization-iam-sign-in-session-settings-information-required-permissions"></a>
#### Required permissions
`Organization.Setting.Iam.Get`

<a id="view-organization-iam-sign-in-session-settings-information-request-parameter"></a>
#### Request Parameter

| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Y | Organization ID | 


<a id="view-organization-iam-sign-in-session-settings-information-response-body"></a>
#### Response Body

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


<a id="view-organization-iam-sign-in-session-settings-information-response"></a>
#### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
| header | [Common response](#common-response)| Y   |
| result | Content | Y | Setup contents |

##### Content

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   multiSessionsLimit | Integer| Y | Number of multisessions allowed  |
|   sessionTimeoutMinutes | Integer| Y | 	Session timeouts |
|   mobileSessionTimeoutMinutes | Integer| Y | 	Mobile session timeout |
|   sessionType | String| Y | `fixed`/`idle`. The default is `fixed`  |

<a id="view-settings-for-organizational-iam-sign-in-second-factor-authentication"></a>
### View settings for organizational IAM sign-in second factor authentication { #view-settings-for-organizational-iam-sign-in-second-factor-authentication }

> GET "/v1/iam/organizations/{org-id}/settings/security-mfa"

API to get settings for login two-factor authentication.

<a id="view-settings-for-organizational-iam-sign-in-second-factor-authentication-required-permissions"></a>
#### Required permissions
`Organization.Setting.Iam.Get`

<a id="view-settings-for-organizational-iam-sign-in-second-factor-authentication-request-parameter"></a>
#### Request Parameter


| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Y | Organization ID | 

<a id="view-settings-for-organizational-iam-sign-in-second-factor-authentication-response-body"></a>
#### Response Body

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


<a id="view-settings-for-organizational-iam-sign-in-second-factor-authentication-response"></a>
#### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   header | [Common response](#common-response)| Y   |
|   result | Result| N |  Response content<br>If never set, null is returned |

##### Result
| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   range | Integer| No | Organization/Service status<br>organization (common settings), services (service-specific settings)  |
|   organizationMfaSetting | OrganizationMfaSetting| No | About organizational MFA settings<br>Common Settings |
|   serviceMfaSettings | ServiceMfaSettings| No | About service-specific MFA settings  |


##### OrganizationMfaSetting

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   type | String| N | MFA type<br>none (no setting), totp (Google OTP), email (email) |
|   bypassByIp | BypassByIp| N | Exception IP  |

##### ServiceMfaSettings


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   serviceId | String| N | Service ID  |
|   type | String| N | MFA type<br>none (no setting), totp (Google OTP), email (email) |
|   bypassByIp | BypassByIp| N | Exception IP |

##### BypassByIp

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   enable | Boolean| No | Enabled status<br>`true` (enabled), `false` (disabled)  |
|   ipList | List<String>| N | List of exception IPs |

<a id="view-organization-iam-login-failure-security-settings"></a>
### View Organization IAM Login Failure Security Settings { #view-organization-iam-login-failure-security-settings }

> GET "/v1/iam/organizations/{org-id}/settings/security-login-fail"

API to get login failure security settings.

<a id="view-organization-iam-login-failure-security-settings-required-permissions"></a>
#### Required permissions
`Organization.Setting.Iam.Get`

<a id="view-organization-iam-login-failure-security-settings-request-parameter"></a>
#### Request Parameter

| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Y | Organization ID | 


<a id="view-organization-iam-login-failure-security-settings-response-body"></a>
#### Response Body

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


<a id="view-organization-iam-login-failure-security-settings-response"></a>
#### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
| header | [Common response](#common-response)| Y   |
| result | Result | N | Returned only if login failure security is set, otherwise null is returned |

##### Result

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   enable | Boolean| Y | Enabled status<br>`true` (enabled), `false` (disabled)  |
|   loginFailCount | LoginFailCount| N | Setting up login failure security |


##### LoginFailCount

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   limit | Integer| N | Number of attempts allowed |
|   blockMinutes | Integer| N | Login ban time  |

<a id="get-your-organizations-iam-account-password-policy"></a>
### Get your organization's IAM account password policy { #get-your-organizations-iam-account-password-policy }

> GET "/v1/iam/organizations/{org-id}/settings/password-rule"

API to get settings for password policies.

<a id="get-your-organizations-iam-account-password-policy-required-permissions"></a>
#### Required permissions
`Organization.Setting.Iam.Get`

<a id="get-your-organizations-iam-account-password-policy-request-parameter"></a>
#### Request Parameter

| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Y | Organization ID | 


<a id="get-your-organizations-iam-account-password-policy-response-body"></a>
#### Response Body

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
```

<a id="get-your-organizations-iam-account-password-policy-response"></a>
#### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
| header | [Common response](#common-response)| Y   |
| result | Content | Y | Setup contents |

##### Content

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
| schemaVersion | Integer| Y | Schema version  |
| value | Value| Y |  Password policy |

##### Value

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
| ruleType | String | Y | Password policy<br>`default` (default password policy), `custom` (user password policy) |
| passwordConstraints | PasswordConstraints | Y | Password strength |
| passwordExpiry | PasswordExpiry | Y | Password expiration |
| limitPasswordReuse | LimitPasswordReuse | Y | Limit password reuse |
| applyRule | String | Y | When to enforce password policies<br>`onChangePassword` (applies when password changes), `onLogin` (applies immediately) |

##### PasswordConstraints

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
| minLength | Integer | Y | Password minimum length |
| mustNotIncludeIllegalSequence | Boolean | Y | At least one alphanumeric character<br>true (set), false (not set) |
| mustIncludeUpperCase | Boolean | Y | At least one uppercase letter<br>true (set), false (not set) |
| mustIncludeLowerCase | Boolean | Y | At least one lowercase letter<br>true (set), false (not set) |
| mustIncludeNumberCase | Boolean | Y | At least one number<br>true (set), false (not set) |
| mustIncludeSpecialCase | Boolean | Y | One or more special characters<br>true (set), false (not set) |

##### PasswordExpiry

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
| enable | Boolean | Y | Enabled or not<br>true (set), false (not set) |
| expiryDays | Integer | Y | Expiration period |
| allowExpend | Boolean | Y | Extendable on expiration<br>true (possible), false (impossible) |

##### LimitPasswordReuse

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
| enable | Boolean | Y | Enabled or not<br>true (set), false (not set) |
| limitCount | Integer | Y | Number of reuse limits |

<a id="get-the-price-of-a-service-on-a-pay-as-you-go-subscription"></a>
### Get the price of a service on a pay-as-you-go subscription { #get-the-price-of-a-service-on-a-pay-as-you-go-subscription }

> POST "/v1/billing/contracts/basic/products/prices/search"

API to get the unit price set on a counter.
For each language, you can get the impression name and type for calculating the amount.


<a id="get-the-price-of-a-service-on-a-pay-as-you-go-subscription-required-permissions"></a>
#### Required permissions
Available to all members. No specific permissions required.

<a id="get-the-price-of-a-service-on-a-pay-as-you-go-subscription-request-parameter"></a>
#### Request Parameter

| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Query |limit | Integer| N |  |
| Request Body | request | GetContractProductPriceRequest| Y | Request |

<a id="get-the-price-of-a-service-on-a-pay-as-you-go-subscription-getcontractproductpricerequest"></a>
#### GetContractProductPriceRequest
| Name | Type | Required | Description |   
|------------ | ------------- | --------- | ------------ |
|  counterNames | List<String>| N | List of counter names in the service meta<br>Full search box if not found |
|   paging | Paging| N  |

##### Paging

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   limit | Integer| N | Number of displays per page, default 20  |
|   page | Integer| N | Target Page, default 1  |


<a id="get-the-price-of-a-service-on-a-pay-as-you-go-subscription-response-body"></a>
#### Response Body

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

##### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common response](#common-response)| Y   |
|   paging | PagingResponse| Y | Return paging results with no sorting criteria  |
|   prices | List<ContractProductPriceProtocol>| Y | Returns unit price information from counters as an array<br>Not included on error  |

##### PagingResponse

| Name | Type | Required | Description |   
|------------ | ------------- | ------- | ------------ |
|   limit | Integer| Y | Limit the number of views<br>Default value is 1. |
|   page | Integer| Y |
|   totalCount | Integer| Y |

##### ContractProductPriceProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   contractDiscountPolicyId | String| Y | Commitment Rate Policy ID  |
|   contractId | String| Y | Commitment ID  |
|   counterName | String| Y | Counters  |
|   displayNameEn | String| N | 	English name of the counter  |
|   displayNameJa | String| N | Japanese name of the counter  |
|   displayNameKo | String| Y | Korean name of the counter  |
|   displayNameZh | String| N | 	Chinese name of the counter<br>Currently exposed in English |
|   monthFrom | String| Y | The start month for which unit price information is valid (inclusive)  |
|   monthTo | String| Y | Ending month for which unit price information is valid (not included)  |
|   originalPrice | BigDecimal| Y | Unit price  |
|   price | BigDecimal| Y | Unit price  |
|   rangeFrom | BigDecimal| Y | Start of usage range that falls under unit price (not included)  |
|   rangeTo | BigDecimal| Y | Ending usage ranges that fall under unit pricing (inclusive)  |
|   seq | Long| Y | Serial number  |
|   slidingCalculationTypeCode | String| Yes | Types of sliding fee calculations<br>`NONE`, `SECTION_SUM`, `SECTION_SELECTED` |
|   useFixPriceYn | String| Yes | Fixed amount or not (Y: Fixed amount, N: Unit price calculation)<br>Y: price becomes an amount if it falls in the range<br>N: (Usage x Unit Price) becomes an amount |

<a id="list-services-enrolled-in-a-pay-as-you-go-subscription"></a>
### List services enrolled in a pay-as-you-go subscription { #list-services-enrolled-in-a-pay-as-you-go-subscription }

> GET "/v1/billing/contracts/basic/products"

API that provides a list of the main categories and subcategories exposed in the bill, and the counters they contain.

<a id="list-services-enrolled-in-a-pay-as-you-go-subscription-required-permissions"></a>
#### Required permissions
Available to all members. No specific permissions required.

<a id="list-services-enrolled-in-a-pay-as-you-go-subscription-request-parameter"></a>
#### Request Parameter

| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Query |limit | Integer| N | Limit the number of views<br>Default value is 1. |
|  Query |page | Integer| N |  |


<a id="list-services-enrolled-in-a-pay-as-you-go-subscription-response-body"></a>
#### Response Body

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


##### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common response](#common-response)| Y   |
|   paging | [PagingResponse](#pagingresponse)| Y  |
|   products | List<ProductMetadata>| Y | Service meta information list  |


##### ProductMetadata


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   budgetUsageTypeYn | String| No | Budget Usage Type Yn Y, N |
|   calcUnitCode | String| Yes | Units to use when calculating amounts (converts metering units to settlement units to calculate amounts), units to expose on statements<br>KB, MB, GB, TB, SECONDS, MINUTE, HOURS, DAYS, MB_HOURS, GB_SECONDS, GB_HOURS, GB_DAYS, CORE_SECONDS, CORE_HOURS, CORE_DAYS, USERS, MAU, MAD, DAU, CALLS, COUNTS, CCU, VCPU_HOURS, COUNT_HOURS |
|   categoryMain | String| Yes | Main Categories  |
|   categorySub | String| Yes | Subcategories  |
|   chargingTypeId | String| Yes | Billing type ID  |
|   convertUsageTypeCode | String| Yes | Usage conversion type codes `NONE`, `HOUR_AVERAGE`, `DAY_AVERAGE` |
|   counterName | String| Yes | Counters  |
|   counterTypeCode | String| Yes | Methods for summing usage<br><ul><li>DELTA: Incremental value (HOURLY_SUM)</li><li>GAUGE: Sum of hourly maximums (to be changed to HOURLY_MAX)</li><li>HOURLY_LATEST: The sum of the latest metering data collected in a one-hour period.</li><li>DAILY_MAX: Sum of daily maximums</li><li>MONTHLY_MAX: Monthly maximum</li><li>STATUS: Usage status</li><ul> |
|   description | String| No | Counter descriptions  |
|   displayOrder | Integer| Yes | Exposure order  |
|   marketPlaceMandatoryUsePeriod | Integer| No | Marketplace mandatory usage period  |
|   meterUnitCode | String| Yes | Usage units when storing metering in a service<br>BYTES, KB, MB, GB, TB, CORE, HOURS, MINUTE, USERS, MAU, MAD, DAU, CALLS, COUNTS, CCU, SECONDS |
|   minUsage | BigDecimal| Yes | Minimum usage  |
|   parentCounterName | String| Yes | Parent counter name  |
|   productId | String| Yes | Service ID  |
|   productMetadataStatusCode | String| Yes | Counter status codes `STABLE`, `CLOSED` |
|   productUiId | String| Yes | Homepage Category/Homepage Service Identification ID  |
|   regionTypeCode | String| Yes | The region code the countername belongs to<br><ul><li>GLOBAL: Countername belonging to the Global service</li><li>NONE: Same meaning as GLOBAL</li><li>KR1: Countername belonging to the KR1 region</li><li>KR2: Countername belonging to the KR2 region</li><li>...: Counternames that belong to this region</li><ul>  |
|   unit | Long| Yes | Settlement units  |
|   unitName | String| Yes | Name to appear on the invoice  |
|   usageAggregationUnitCode | String| No | Usage aggregation units<br>RESOURCE_ID, COUNTER_NAME |

<a id="view-charges-by-payment-statement"></a>
### View Charges by Payment Statement { #view-charges-by-payment-statement }

> GET "/v1/billing/members/payment-statements"

Retrieves the usage amount per payment statement.

<a id="view-charges-by-payment-statement-required-permissions"></a>
#### Required Permission
`Member.PaymentStatement.Get`

<a id="view-charges-by-payment-statement-request-parameter"></a>
#### Request Parameters

| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Query |month | String| Y | Billing month (yyyy-MM) |
|  Query |paymentGroupIds | List&lt;String>| N | Payment group ID filter (multiple)<br>If not specified, retrieves all accessible payment groups |

<a id="view-charges-by-payment-statement-response-body"></a>
#### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  },
  "paymentStatementCharges": [ {
    "uuid": "4ea1d0b8-6bbd-4b3c-b1a9-9f4c6e6a1d2f",
    "paymentGroupId": "3YVRwIVU",
    "month": "2026-07-01T00:00:00.000+09:00",
    "country": "KR",
    "paymentStatusCode": "PAID",
    "autoPaymentTypeCode": "CREDIT_CARD",
    "paymentInfo": "[Hyundai Card] 4403***",
    "chargeAmount": 1000000,
    "totalDiscountAmount": 100000,
    "totalExtraAmount": 0,
    "taxAmount": 90000,
    "freeCreditAmount": 0,
    "paidCreditAmount": 0,
    "freeCreditAllAmount": 0,
    "freeCreditLimitAmount": 0,
    "paidCreditAllAmount": 0,
    "paidCreditLimitAmount": 0,
    "totalCreditAmount": 0,
    "prePaidTotalAmount": 0,
    "cutoffAmount": 0,
    "lateFeeAmount": 0,
    "totalAmount": 990000,
    "chargedSupplyAmount": 900000,
    "chargedTaxAmount": 90000,
    "chargedTotalAmount": 990000,
    "receiptStatusCode": "EXIST",
    "refundAccountRegisterStatusCode": "DENY"
  } ]
}
```

##### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common Response](#common-response)| Y   |
|   paymentStatementCharges | List&lt;Charge>| Y | List of usage amounts by payment group  |

##### Charge

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   uuid | String| Y | Member UUID  |
|   paymentGroupId | String| Y | Payment group ID  |
|   month | Date| Y | Billing month  |
|   country | String| Y | Country code  |
|   paymentStatusCode | String| Y | Payment status code<br><ul><li>REGISTERED: Registered</li><li>READY: Payment pending</li><li>PAID: Payment completed</li><li>ERROR: Operator verification required status</li></ul> |
|   autoPaymentTypeCode | String| Y | Payment method type  |
|   paymentInfo | String| N | Payment method information  |
|   chargeAmount | Long| Y | Amount used  |
|   totalDiscountAmount | Long| Y | Discount amount  |
|   totalExtraAmount | Long| Y | Surcharge amount  |
|   taxAmount | Long| Y | VAT (before truncation)  |
|   freeCreditAmount | Long| Y | Free credit used (total of all-type and limited-type)  |
|   paidCreditAmount | Long| Y | Paid credit used (total of all-type and limited-type)  |
|   freeCreditAllAmount | Long| Y | Free all credit used  |
|   freeCreditLimitAmount | Long| Y | Free limited credit used  |
|   paidCreditAllAmount | Long| Y | Paid all credit used  |
|   paidCreditLimitAmount | Long| Y | Paid limited credit used  |
|   totalCreditAmount | Long| Y | Total credit used  |
|   prePaidTotalAmount | Long| Y | Prepaid amount applied  |
|   cutoffAmount | Long| Y | Truncated amount (less than 500 won)  |
|   lateFeeAmount | Long| Y | Overdue amount  |
|   totalAmount | Long| Y | Final billing amount (inclusive of VAT)  |
|   chargedSupplyAmount | Long| Y | Actual supply amount<br>Actual billing amount with credit, prepayment, and truncation applied |
|   chargedTaxAmount | Long| Y | Actual VAT<br>Actual billing amount with credit, prepayment, and truncation applied |
|   chargedTotalAmount | Long| Y | Actual payment amount<br>Actual supply amount + actual VAT + overdue amount |
|   receiptStatusCode | String| Y | Sales voucher status code<br><ul><li>NONE: Status in which the sales voucher cannot be viewed</li><li>EXIST: Status in which the sales voucher can be viewed</li></ul> |
|   refundAccountRegisterStatusCode | String| N | Refund account registration status code<br><ul><li>ALLOW: Refund account registration open status</li><li>DENY: Refund account registration closed status (default)</li></ul> |


<a id="view-charge-summaries-by-scope"></a>
### View Charge Summaries by Billing Group, Organization, and Project { #view-charge-summaries-by-scope }

> GET "/v1/billing/members/payment-statements/charge-summaries"

Retrieves the usage charges aggregated by billing group, organization, or project.

!!! danger "Caution"
    * Only billing months after May 2020 can be retrieved.
    * You cannot specify a payment group (PAYMENT_GROUP) in `groupBy`. To retrieve charges by payment group, use [View Charges by Payment Statement](#view-charges-by-payment-statement).

<a id="view-charge-summaries-by-scope-required-permissions"></a>
#### Required Permission
`Member.PaymentStatement.Get`

<a id="view-charge-summaries-by-scope-request-parameter"></a>
#### Request Parameters

| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Query |month | String| Y | Billing month (yyyy-MM)<br>Supported from 2020-05 onwards |
|  Query |groupBy | String| Y | Aggregation criteria (single)<br><ul><li>BILLING_GROUP: Billing group</li><li>ORG: Organization</li><li>PROJECT: Project</li></ul> |
|  Query |paymentGroupIds | List&lt;String>| N | Payment group ID filter (multiple, up to 10) |
|  Query |billingGroupIds | List&lt;String>| N | Billing group ID filter (multiple, up to 10) |
|  Query |orgIds | List&lt;String>| N | Organization ID filter (multiple, up to 10) |
|  Query |projectIds | List&lt;String>| N | Project ID filter (multiple, up to 10) |
|  Query |cursor | String| N | Next page cursor<br>If not specified, retrieves the first page |
|  Query |size | Integer| N | Number of items per page (from 10 to 100)<br>Default: 20 |

<a id="view-charge-summaries-by-scope-response-body"></a>
#### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  },
  "groupBy": "PROJECT",
  "chargeSummaries": [ {
    "paymentGroupId": "3YVRwIVU",
    "billingGroupId": "LY9NQ7lvWvxGj3aW",
    "billingGroupName": "Billing group name",
    "orgId": "eNWZ3jZq2FsMSHaQ",
    "orgName": "Organization name",
    "projectId": "KGDeiKUq",
    "projectName": "Project name",
    "country": "KR",
    "chargeAmount": 1000000,
    "contractDiscountAmount": 50000,
    "ocpDiscountAmount": 0,
    "billingGroupDiscountAmount": 0,
    "projectDiscountAmount": 50000,
    "totalDiscountAmount": 100000,
    "contractExtraAmount": 0,
    "billingGroupExtraAmount": 0,
    "projectExtraAmount": 0,
    "totalExtraAmount": 0,
    "totalCreditLimitAmount": 0,
    "prePaidTotalAmount": 0,
    "totalAmount": 900000
  } ],
  "nextCursor": "S0dEZWlLVXE"
}
```

##### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common Response](#common-response)| Y   |
|   groupBy | String| Y | Aggregation criteria of the request  |
|   chargeSummaries | List&lt;ChargeSummary>| Y | List of usage amounts by billing group, organization, and project  |
|   nextCursor | String| N | Cursor for the next page<br>null if this is the last page |

##### ChargeSummary

| Name | Type | Required | Description |   
|------------ | ------------- |----| ----------- |
|   paymentGroupId | String| Y  | Payment group ID |
|   billingGroupId | String| Y  | Billing group ID |
|   billingGroupName | String| N  | Billing group name |
|   orgId | String| N  | Organization ID<br>Returned only when `groupBy=ORG` or `groupBy=PROJECT` |
|   orgName | String| N  | Organization name<br>Returned only when `groupBy=ORG` or `groupBy=PROJECT` |
|   projectId | String| N  | Project ID<br>Returned only when `groupBy=PROJECT` |
|   projectName | String| N  | Project name<br>Returned only when `groupBy=PROJECT` |
|   country | String| Y  | Country code  |
|   chargeAmount | Long| Y  | Amount used  |
|   contractDiscountAmount | Long| Y  | Amount discounted by commitment |
|   ocpDiscountAmount | Long| Y  | Optimized Cost Plans (OCPs) discount amount |
|   billingGroupDiscountAmount | Long| Y  | Billing group discount amount |
|   projectDiscountAmount | Long| Y  | Project discount amount |
|   totalDiscountAmount | Long| Y  | Total discount amount |
|   contractExtraAmount | Long| Y  | Amount surcharged by commitment |
|   billingGroupExtraAmount | Long| Y  | Billing group surcharge amount |
|   projectExtraAmount | Long| Y  | Project surcharge amount |
|   totalExtraAmount | Long| Y  | Total surcharge amount |
|   totalCreditLimitAmount | Long| Y  | Limited credit applied amount |
|   prePaidTotalAmount | Long| Y  | Pre-payment applied amount |
|   totalAmount | Long| Y  | Final amount (VAT excluded)<br>Amount used - discount amount + surcharge amount - limited credit applied amount - pre-payment applied amount |


<a id="view-individual-charge-lines"></a>
### View Individual Charge Lines { #view-individual-charge-lines }

> GET "/v1/billing/members/payment-statements/usages"

API to get the usage amount at the individual charge line level.

!!! danger "Caution"
    * Only billing months after May 2020 can be retrieved.

<a id="view-individual-charge-lines-required-permissions"></a>
#### Required Permission
`Member.PaymentStatement.Get`

<a id="view-individual-charge-lines-request-parameter"></a>
#### Request Parameters

| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Query |month | String| Y | Billing month (yyyy-MM)<br>Supported only from 2020-05 |
|  Query |paymentGroupIds | List&lt;String>| N | Payment group ID filter (multiple, up to 10) |
|  Query |billingGroupIds | List&lt;String>| N | Billing group ID filter (multiple, up to 10) |
|  Query |orgIds | List&lt;String>| N | Organization ID filter (multiple, up to 10) |
|  Query |projectIds | List&lt;String>| N | Project ID filter (multiple, up to 10) |
|  Query |categoryMains | List&lt;String>| N | Main category filter (multiple, up to 10) |
|  Query |regions | List&lt;String>| N | Region filter (multiple, up to 10) |
|  Query |stationIds | List&lt;String>| N | Station ID filter (multiple, up to 10) |
|  Query |cursor | String| N | Next page cursor<br>Retrieves the first page if not specified |
|  Query |size | Integer| N | Number of items per page (from 10 to 100)<br>Default 20 |

<a id="view-individual-charge-lines-response-body"></a>
#### Response body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  },
  "usages": [ {
    "projectId": "KGDeiKUq",
    "projectName": "Project name",
    "resourceId": "5f1ab1a1-4e6e-4f66-9b1e-2b3f5c6d7e8f",
    "resourceName": "Instance name",
    "counterName": "c2.small",
    "categoryMain": "Compute",
    "categorySub": "Instance",
    "regionTypeCode": "KR1",
    "stationId": "stationId",
    "stationName": "stationName",
    "displayNameKo": "c2.small",
    "displayNameEn": "c2.small",
    "displayNameJa": "c2.small",
    "displayNameZh": "c2.small",
    "unitName": "Hours",
    "unit": 1,
    "usageVolume": 720,
    "unitPrice": 61,
    "contractUnitPrice": 55,
    "chargeAmount": 43920,
    "contractAmount": 39600,
    "discountAmount": 4320,
    "discountTypeCode": "CONTRACT",
    "prePaidAmount": 0
  } ],
  "nextCursor": "MTAyNA"
}
```

##### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common Response](#common-response)| Y   |
|   usages | List&lt;UsageLine>| Y | Detailed list  |
|   nextCursor | String| N | Next page cursor<br>null if it is the last page |

##### UsageLine

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   projectId | String| N | Project ID  |
|   projectName | String| N | Project name  |
|   resourceId | String| N | Resource ID  |
|   resourceName | String| N | Resource name  |
|   parentResourceId | String| N | Parent resource ID  |
|   parentResourceName | String| N | Parent resource name  |
|   counterName | String| N | Counter name  |
|   categoryMain | String| N | Main category  |
|   categorySub | String| N | Sub category  |
|   regionTypeCode | String| N | Region type code  |
|   stationId | String| N | Station ID  |
|   stationName | String| N | Station name  |
|   displayNameKo | String| N | Billing unit display name (ko)  |
|   displayNameEn | String| N | Billing unit display name (en)  |
|   displayNameJa | String| N | Billing unit display name (ja)  |
|   displayNameZh | String| N | Billing unit display name (zh)  |
|   unitName | String| N | Unit name  |
|   unit | Long| Y | Charging unit  |
|   usageVolume | BigDecimal| Y | Usage  |
|   unitPrice | BigDecimal| Y | Pay-as-you-go unit price  |
|   contractUnitPrice | BigDecimal| Y | Commitment unit price  |
|   chargeAmount | Long| Y | Usage amount (pay-as-you-go)  |
|   contractAmount | Long| Y | Commitment applied amount  |
|   discountAmount | Long| Y | Commitment discount amount  |
|   discountTypeCode | String| N | Discount type code<br>BASIC, CONTRACT, OCP |
|   prePaidAmount | Long| Y | Prepaid applied amount  |
|   costPlanOrderId | String| N | Optimized Cost Plans (OCPs) order ID  |


<a id="view-charge-filter-dimensions"></a>
### Get List of Charge Filter Dimension Values { #view-charge-filter-dimensions }

> GET "/v1/billing/members/payment-statements/dimensions"

This API retrieves a list of options for each search condition category (`dimension`) that can be used as filters when viewing usage charges.

!!! danger "Caution"
    * You can only view billing months after May 2020.

!!! tip "Note"
    * Since options are extracted from the same targets as [View Usage Charges by Billing Group, Organization, and Project](#view-charge-summaries-by-scope), you can use the values retrieved here directly as filters.
    * The search condition category (`dimension`) has a hierarchy of Payment Group > Billing Group > Organization > Project, and the parent search condition category (`parentDimension`) and the parent identifier and name for each option are returned together.


<a id="view-charge-filter-dimensions-required-permissions"></a>
#### Required Permission
`Member.PaymentStatement.Get`

<a id="view-charge-filter-dimensions-request-parameter"></a>
#### Request Parameters

| Category | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Query |dimension | String| Y | Search condition type to query (single)<br><ul><li>PAYMENT_GROUP: Payment group</li><li>BILLING_GROUP: Billing group</li><li>ORG: Organization</li><li>PROJECT: Project</li></ul> |
|  Query |month | String| Y | Billing month (yyyy-MM)<br>Only supported from 2020-05 onwards |
|  Query |paymentGroupIds | List&lt;String>| N | Payment group ID filter (multiple, up to 10) |
|  Query |billingGroupIds | List&lt;String>| N | Billing group ID filter (multiple, up to 10) |
|  Query |orgIds | List&lt;String>| N | Organization ID filter (multiple, up to 10) |
|  Query |orgOwnerIds | List&lt;String>| N | Organization owner UUID filter (multiple, up to 10)<br>Returns only values for organizations owned by the specified UUID that have usage charges in the billing month. |
|  Query |cursor | String| N | Cursor for the next page<br>If not specified, retrieves the first page |
|  Query |size | Integer| N | Number of displays per page (10 to 100)<br>Default 20 |

<a id="view-charge-filter-dimensions-response-body"></a>
#### Response Body

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  },
  "uuid": "4ea1d0b8-6bbd-4b3c-b1a9-9f4c6e6a1d2f",
  "dimension": "PROJECT",
  "parentDimension": "ORG",
  "values": [ {
    "id": "KGDeiKUq",
    "name": "Project name",
    "ownerId": "4ea1d0b8-6bbd-4b3c-b1a9-9f4c6e6a1d2f",
    "parentId": "eNWZ3jZq2FsMSHaQ",
    "parentName": "Organization name"
  } ],
  "nextCursor": "S0dEZWlLVXE"
}
```

##### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common response](#common-response)| Y   |
|   uuid | String| Y | Member UUID to retrieve  |
|   dimension | String| Y | Search filter category retrieved<br>PAYMENT_GROUP, BILLING_GROUP, ORG, PROJECT |
|   parentDimension | String| N | Parent search filter category<br>null if top-level (PAYMENT_GROUP) |
|   values | List&lt;DimensionValue>| Y | List of filter options by search filter category  |
|   nextCursor | String| N | Next page cursor<br>null if it is the last page |

##### DimensionValue

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   id | String| Y | Identifier  |
|   name | String| Y | Display name  |
|   ownerId | String| N | Owner UUID<br>For `dimension=ORG` and `dimension=PROJECT`, the owner of the affiliated organization |
|   parentId | String| N | Parent search filter category identifier<br>null if top-level (billing group) |
|   parentName | String| N | Parent search filter category display name<br>null if top-level (billing group) |


<a id="get-project-integrated-appkey"></a>
### Get Project Integrated AppKey { #get-project-integrated-appkey }

> GET "/v1/authentications/projects/{project-id}/project-appkeys"

API to get a list of project integrated AppKeys being used by the project.

<a id="get-project-integrated-appkey-required-permissions"></a>
#### Required permissions
`Project.ProjectAppKey.List`

<a id="get-project-integrated-appkey-request-parameter"></a>
#### Request Parameter

| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Y | Project ID to look up | 


<a id="get-project-integrated-appkey-response-body"></a>
#### Response Body

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

##### Response

| Name | Type | Required | Description |   
|------------ | ------------- | --------- | ------------ |
|   header | [Common response](#common-response)| Y |
|   authenticationList | List<ProjectAppKeyResponse>| N | Project integrated AppKey List |

##### ProjectAppKeyResponse

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   authId | String| N | Internally managed authentication method ID  |
|   appKey | String| N | Project integrated AppKey exposed to the console  |
|   authStatus | String| N | Authentication status codes (STABLE, STOP, BLOCKED) |
|   projectId | String| N | Project ID |
|   lastUsedDatetime | Date| N | Date of last use  |
|   modDatetime | Date| N | Date and time of deletion  |
|   reIssueDatetime | Date| N | Regeneration time  |
|   regDatetime | Date| N | Date and time of creation  |

<a id="listuser-access-key-ids"></a>
### ListUser Access Key IDs { #listuser-access-key-ids }

> GET "/v1/authentications/user-access-keys"

API to get a list of a member's User Access Key IDs.

<a id="listuser-access-key-ids-required-permissions"></a>
#### Required permissions
Available to all members. No specific permissions required.


<a id="listuser-access-key-ids-response-body"></a>
#### Response Body

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
    "lastUsedDatetime": "2000-01-23T04:56:07.000+00:00",
    "reIssueDatetime": "2000-01-23T04:56:07.000+00:00",
    "regDatetime": "2000-01-23T04:56:07.000+00:00",
    "lastTokenUsedDatetime": "2025-02-11T01:30:56.771Z",
    "validTokenCount": 0
  } ]
}
```


##### Response


| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common response](#common-response)| Y   |
|   authentications | List<UserAccessKeyResponse>| N | List credentials  |

##### UserAccessKeyResponse

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   authId | String| N | Internally managed authentication method ID  |
|   userAccessKeyID | String| N | User Access Key ID  |
|   secretAccessKey | String| N | Secret key (masked)  |
|   authStatus | String| N | Authentication status codes (STABLE, STOP, BLOCKED) |
|   uuid | String| N | User UUID |
|   lastUsedDatetime | Date| N | Date of last use you authenticated with User Access Key ID  |
|   modDatetime | Date| N | Date and time of deletion  |
|   reIssueDatetime | Date| N | Regeneration time  |
|   regDatetime | Date| N | Date and time of creation  |
|   tokenExpiryPeriod | Long| N | Token expiration cycle (in seconds)  |
|   tokenFormatCode | String | N | Token format code (OPAQUE, JWT)  |
|   lastTokenUsedDatetime | Long| N | Last time you authenticated/authorized with a token              |
|   validTokenCount | Long| N | Number of valid tokens                      |


<a id="register-a-integrated-project-appkey"></a>
### Register a integrated project AppKey { #register-a-integrated-project-appkey }

> POST "/v1/authentications/projects/{project-id}/project-appkeys"

API to generate an AppKey for use in your project.

<a id="register-a-integrated-project-appkey-required-permissions"></a>
#### Required permissions
`Project.ProjectAppKey.Create`


<a id="register-a-integrated-project-appkey-request-parameter"></a>
#### Request Parameter

| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
| Path | project-id | String| Y | The project ID where you want to register the AppKey |
| Request Body | request | AddProjectAppKeyRequest| Y | Request |

##### AddProjectAppKeyRequest

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   appkeyAlias | String | Y   | Project integrated AppKey aliases<br>100-character limit |


<a id="register-a-integrated-project-appkey-response-body"></a>
#### Response Body

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

##### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common response](#common-response)| Y   |
|   authentication | ResponseProtocol| N  |

##### ResponseProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ----- | ------------ |
|   authId | String| N | Internally managed authentication method ID  |
|   appKey | String| N | Project integrated AppKey |

<a id="register-a-user-access-key-id"></a>
### Register a User Access Key ID { #register-a-user-access-key-id }

> POST "/v1/authentications/user-access-keys"

API to register a member's User Access Key ID.

<a id="register-a-user-access-key-id-required-permissions"></a>
#### Required permissions
Available to all members. No specific permissions required.

<a id="register-a-user-access-key-id-request-parameter"></a>
#### Request Parameter

| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
| Request Body | PostUserAppKeyRequest | PostUserAppKeyRequest| Y |  | |


##### PostUserAppKeyRequest

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   tokenFormatCode | String | No | Token format code<br>Supports OPAQUE and JWT formats. Currently, JWT format tokens are available only in the EasyQueue service.<br>Default value is OPAQUE |
|   tokenExpiryPeriod | Long| N | Token expiry period<br>Specified in seconds. For OPAQUE format tokens, the default is one day; for JWT tokens, the default is one hour.<br>OPAQUE format tokens can be issued with a validity period of at least one minute and up to one day. JWT format tokens can be issued with a validity period of at least one minute and up to one hour. |


<a id="register-a-user-access-key-id-response-body"></a>
#### Response Body

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

##### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common response](#common-response)| Y   |
|   authentication | ResponseProtocol| N  |

##### ResponseProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ----- | ------------ |
|   authId | String| N | Internally managed authentication method ID  |
|   userAccessKeyID | String| N | User Access Key ID  |
|   secretAccessKey | String| N | Secret key |
|   tokenExpiryPeriod | Long| N | Token expiration period (in seconds)

|   tokenFormatCode | String | N | Token format code (OPAQUE, JWT) |


<a id="delete-a-project-integrated-appkey"></a>
### Delete a project integrated AppKey { #delete-a-project-integrated-appkey }

> DELETE "/v1/authentications/projects/{project-id}/project-appkeys/{app-key}"

API to delete a project AppKey.

<a id="delete-a-project-integrated-appkey-required-permissions"></a>
#### Required permissions
`Project.ProjectAppKey.Delete`


<a id="delete-a-project-integrated-appkey-request-parameter"></a>
#### Request Parameter


| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
| Path | project-id | String| Y | Target project ID |
|  Path |app-key | String| Y | Project integrated AppKey to delete | 


<a id="delete-a-project-integrated-appkey-response-body"></a>
#### Response Body

```json
{
  "header" : {
    "isSuccessful" : true,
    "resultCode" : 0,
    "resultMessage" : "resultMessage"
  }
}
```
##### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common response](#common-response)| Y   |


<a id="reissue-the-user-access-key-id-secret-key"></a>
### Reissue the User Access Key ID secret key { #reissue-the-user-access-key-id-secret-key }

> PUT "/v1/authentications/user-access-keys/{user-access-key-id}/secretkey-reissue"

API to reissue the secret key for a User Access Key ID.


<a id="reissue-the-user-access-key-id-secret-key-required-permissions"></a>
#### Required Permissions
Can only reissue the secret key for the user's own User Access Key ID

<a id="reissue-the-user-access-key-id-secret-key-request-parameter"></a>
#### Request Parameter

| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |user-access-key-id | String| Y | User Access Key ID | 
| Request Body | request | ReissueSecretKeyRequest| Y | Request |


##### ReissueSecretKeyRequest

| Name | Type | Required | Description |   
|------------ |---------|----|---------------------------------------------------|
|   needExpireTokens | Boolean | N | Issued token expired or not(true: Expired, false: Not expired)<br>Default false |

<a id="reissue-the-user-access-key-id-secret-key-response-body"></a>
#### Response Body

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

##### Response


| Name | Type | Required | Description |   
|------------ | ------------- | --------- | ------------ |
|   header | [Common response](#common-response)| Y |
|   authentication | ResponseProtocol| N  |

##### ResponseProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   secretAccessKey | String| Y   | Secret key |

<a id="modify-user-access-key-id-status"></a>
### Modify User Access Key ID status { #modify-user-access-key-id-status }

> PUT "/v1/authentications/user-access-keys/{user-access-key-id}"

API to change the state of a member's User Access Key ID.<br>
If you deactivate the User Access Key ID for OPAQUE tokens, the OPAQUE tokens also expire. However, deactivating the User Access Key ID for JWT tokens does not expire the JWT tokens.

<a id="modify-user-access-key-id-status-required-permissions"></a>
#### Required Permissions
Can only modify the user's own User Access Key ID

<a id="modify-user-access-key-id-status-request-parameter"></a>
#### Request Parameter


| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path | user-access-key-id | String| Y | User Access Key ID | 
| Request Body | request | UpdateUserAccessKeyStatusRequest| Y | Request |


##### UpdateUserAccessKeyStatusRequest

| Name | Type | Required | Description |   
|----------- | ------------- | ------------- | ------------ |
| status | String| Y | State to change (STOP: Stop, STABLE: Enable) |


<a id="modify-user-access-key-id-status-response-body"></a>
#### Response Body

```json
{
  "header" : {
    "isSuccessful" : true,
    "resultCode" : 0,
    "resultMessage" : "resultMessage"
  }
}
```

##### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common response](#common-response)| Y   |

<a id="delete-a-user-access-key-id"></a>
### Delete a User Access Key ID { #delete-a-user-access-key-id }

> DELETE "/v1/authentications/user-access-keys/{user-access-key-id}"

API to delete a User Access Key ID.

<a id="delete-a-user-access-key-id-required-permissions"></a>
#### Required permissions
Can only delete the user's own User Access Key ID

<a id="delete-a-user-access-key-id-request-parameter"></a>
#### Request Parameter

| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path | user-access-key-id | String| Y | User Access Key ID | 


<a id="delete-a-user-access-key-id-response-body"></a>
#### Response Body

```json
{
  "header" : {
    "isSuccessful" : true,
    "resultCode" : 0,
    "resultMessage" : "resultMessage"
  }
}
```

##### Response


| Name | Type | Required | Description |   
|------------ | ------------- | ------- | ------------ |
|   header | [Common response](#common-response)| Y |


<a id="get-a-list-of-tokens"></a>
### Get a List of Tokens { #get-a-list-of-tokens }

> GET "/v1/authentications/user-access-keys/{user-access-key-id}/tokens"

API to get a list of OPAQUE tokens issued with a User Access Key ID.

<a id="get-a-list-of-tokens-required-permissions"></a>
#### Required Permissions
Only tokens issued with your own User Access Key ID can be viewed

<a id="get-a-list-of-tokens-request-parameters"></a>
#### Request Parameters

| In | Name | Type | Required  | Description                                                                           | 
|------------- |------------- | ------------- |-----|------------------------------------------------------------------------------| 
|  Path | user-access-key-id | String| Y | User Access Key ID                                                           | 
|  Query | token | String| N  | Token body<br>Partial search not supported                                                        | 
|  Query | status | String| N  | Token status<br>ACTIVE: Active, EXPIRED: Expired                                             | 
|  Query | lastAccessDatetimeFrom | Date| N  | Date of last token use<br>Get  tokens used at a time greater than or equal to the specified time<br>Example: `2025-02-11T00:56:50.902Z` | 
|  Query | expireDatetimeFrom | Date| N  | Token expiration date<br>Get  tokens expired at a time greater than or equal to the specified time<br>Example: `2025-02-11T00:56:50.902Z`   | 
|  Query | regDatetimeFrom | Date| N  | Token registration date<br>Get  tokens created at a time greater than or equal to the specified time<br>Example: `2025-02-11T00:56:50.902Z`   |
|  Query | page | Integer| N  | Target page<br>Default 1                                                                |
|  Query | limit | Integer| N  | Items per page<br>Default 20                                                            |



<a id="get-a-list-of-tokens-response-body"></a>
#### Response Body

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

##### Response


| Name | Type           | Required  | Description                 |   
|------------ |--------------|-----|--------------------|
|   header | [Common response](#common-response) | Y |
|   paging | [PagingResponse](#pagingresponse)| Y  |
|   accessToken | String       | Y | Masked token         |
|   expireDatetime | Date         | N  | Token expiration date             |
|   lastAccessDatetime | Date         | Y | Last time you authenticated/authorized with a token |
|   regDatetime | Date         | Y | Token creation date           |
|   status | String       | Y | Token status              |
|   tokenId | Long         | Y | Token ID              |


<a id="expire-multiple-tokens"></a>
### Expire multiple tokens { #expire-multiple-tokens }

> DELETE "/v1/authentications/user-access-keys/{user-access-key-id}/tokens"

API to expire multiple OPAQUE tokens issued with a User Access Key ID.<br>
Even if you make a request using the User Access Key ID that issued the JWT tokens, the JWT tokens do not expire.<br>
If both the token ID and token list are empty in the request, all tokens issued to that User Access Key ID will expire.<br>
If you have both a token ID and a list of tokens, only tokens that match both are deleted. Tokens do not expire when a request is made by a user other than the owner of the User Access Key ID in the request.

<a id="expire-multiple-tokens-required-permissions"></a>
#### Required Permissions
Only tokens issued with your own User Access Key ID can expire

<a id="expire-multiple-tokens-request-parameters"></a>
#### Request Parameters

| In           | Name                 | Type              | Required  | Description                 | 
|--------------|--------------------|-----------------|-----|--------------------| 
| Path         | user-access-key-id | String          | Y | User Access Key ID | 
| Request Body | tokenIds           | List<Long>   | N  | List of token IDs           | 
| Request Body         | tokens             | List<String> | N   | List of tokens          | 

<a id="expire-multiple-tokens-response-body"></a>
#### Response Body

```json
{
  "header" : {
    "isSuccessful" : true,
    "resultCode" : 0,
    "resultMessage" : "resultMessage"
  }
}
```

##### Response


| Name | Type | Required | Description |   
|------------ | ------------- | ------- | ------------ |
|   header | [Common response](#common-response)| Y |


<a id="create-a-project-iam-account"></a>
### Create a project IAM account { #create-a-project-iam-account }

> POST "/v1/iam/projects/{project-id}/members"

API to add an IAM account as a project member.

<a id="create-a-project-iam-account-required-permissions"></a>
#### Required permissions
`Project.Member.Iam.Create`

<a id="create-a-project-iam-account-request-parameter"></a>
#### Request Parameter



| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Y | The project ID to which you want to add the member | 
| Request Body | request | AddIamProjectMemberRequest| Y | Request |




##### AddIamProjectMemberRequest


!!! danger "Caution"
    Only one project member can be created in a request.


| Name | Type | Required | Description |  
|------------ | ------------- | ------------- | ------------ |
|   assignRoles | List<UserAssignRoleProtocol>| Y | List of roles to assign to users  |
|   memberUuid | String| Y | UUID of the member to add  |


##### UserAssignRoleProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   roleId | String| Y | Role ID  |
|   conditions | List<AssignAttributeConditionProtocol>| N | Role condition attribute  |


##### AssignAttributeConditionProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   attributeId | String| Y | Condition attribute ID  |
|   attributeOperatorTypeCode | String| Y | Condition attribute operator<br>Available operators vary depending on the conditional attribute data type<br><ul><li>ALLOW</li><li>ALL_CONTAINS</li><li>ANY_CONTAINS</li><li>ANY_MATCH</li><li>BETWEEN</li><li>BEYOND</li><li>FALSE</li><li>GREATER_THAN</li><li>GREATER_THAN_OR_EQUAL_TO</li><li>LESS_THAN</li><li>LESS_THAN_OR_EQUAL_TO</li><li>NONE_MATCH</li><li>NOT_ALLOW</li><li>NOT_CONTAINS</li><li>TRUE</li></ul>  |
|   attributeValues | List<String>| Y | Condition attribute value  |


<a id="create-a-project-iam-account-response-body"></a>
#### Response Body

```json
{
  "header" : {
    "isSuccessful" : true,
    "resultCode" : 0,
    "resultMessage" : "resultMessage"
  }
}
```

##### Response


| Name | Type           | Required | Description |   
|------------ |--------------| ------- | ------------ |
|   header | [Common response](#common-response) | Y |


<a id="delete-multiple-project-iam-accounts"></a>
### Delete multiple project IAM accounts { #delete-multiple-project-iam-accounts }

> DELETE "/v1/iam/projects/{project-id}/members"

API to delete IAM accounts from a project.

<a id="delete-multiple-project-iam-accounts-required-permissions"></a>
#### Required permissions
`Project.Member.Iam.Delete`

<a id="delete-multiple-project-iam-accounts-request-parameter"></a>
#### Request Parameter



| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Y | Project ID | 
|  Request Body |request | DeleteMembersRequest | Y | Request | 


##### DeleteMembersRequest


| Name | Type | Required | Description |  
|------------ | ------------- | ------------- | ------------ |
|   memberUuids | List<String>| Y | List of UUIDs of the target accounts to delete |


<a id="delete-multiple-project-iam-accounts-response-body"></a>
#### Response Body

```json
{
  "header" : {
    "isSuccessful" : true,
    "resultCode" : 0,
    "resultMessage" : "resultMessage"
  }
}
```

##### Response


| Name | Type | Required | Description |   
|------------ | ------------- | ------- | ------------ |
|   header | [Common response](#common-response)| Y |


<a id="view-a-project-iam-account"></a>
### View a project IAM account { #view-a-project-iam-account }

> GET "/v1/iam/projects/{project-id}/members/{member-uuid}"

API to get a specific IAM account who is part of a project.

<a id="view-a-project-iam-account-required-permissions"></a>
#### Required permissions
`Project.Member.Iam.Get`

<a id="view-a-project-iam-account-request-parameter"></a>
#### Request Parameter



| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Y | Project ID to look up members |
|  Path |member-uuid | String| Y | Member UUID to look up |




<a id="view-a-project-iam-account-response-body"></a>
#### Response Body

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


##### Response


| Name | Type | Required | Description |   
|------------ | ------------- | ------- | ------------ |
|   header | [Common response](#common-response)| Y |
|   projectMember | ProjectIamMemberRoleBundleProtocol| Y  | Added member information, not included on error |


##### ProjectMemberRoleBundleProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   uuid | String| Y | Member UUID  |
|   id | String| Y | ID  |
|   name | String| N | Name  |
|   emailAddress | String| N | Member email address  |
|   maskingEmail | String| N | Member's masked email  |
|   mobilePhone | String| N | Phone Number  |
|   relationDateTime | Date| N | Time to add members  |
|   joinYmdt | Date| N | Date to joined  |
|   recentLoginYmdt | Date| N | Date of last login  |
|   recentPasswordModifyYmdt | Date| N | Date of last password change  |
|   roles | List<RoleBundleProtocol>| N | List of related roles (with condition attributes)  |


[RoleBundleProtocol](#rolebundleprotocol)



<a id="view-project-iam-accounts"></a>
### View project IAM accounts { #view-project-iam-accounts }

> GET "/v1/iam/projects/{project-id}/members"

API to get a list of IAM accounts who are part of a project.

<a id="view-project-iam-accounts-required-permissions"></a>
#### Required permissions
`Project.Member.Iam.List`

<a id="view-project-iam-accounts-request-parameter"></a>
#### Request Parameter


| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Y | Project ID to look up | 
|  Query |limit | Integer| N | Number of displays per page, default 20 |
|  Query |page | Integer| N | Target Page, default 1 |





<a id="view-project-iam-accounts-response-body"></a>
#### Response Body

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

##### Response


| Name | Type | Required | Description |   
|------------ | ------------- | ------- | ------------ |
|   header | [Common response](#common-response)| Y |
|   paging | [PagingResponse](#pagingresponse)| Y  |
|   projectMembers | List<IamProjectMemberProtocol>| Y | Project member list  |



##### IamProjectMemberProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   uuid | String| Y | Member UUID  |
|   id | String| Y | ID  |
|   name | String| N | Name  |
|   emailAddress | String| N | Member email address  |
|   maskingEmail | String| N | Member's masked email  |
|   mobilePhone | String| N | Phone Number  |
|   relationDateTime | Date| N | Time to add members  |
|   joinYmdt | Date| N | Date to joined  |
|   recentLoginYmdt | Date| N | Date of last login  |
|   recentPasswordModifyYmdt | Date| N | Date of last password change  |


<a id="modify-project-iam-account-roles"></a>
### Modify project IAM account roles { #modify-project-iam-account-roles }

> PUT "/v1/iam/projects/{project-id}/members/{member-uuid}"

API to change the role of a specified IAM account in a project.

<a id="modify-project-iam-account-roles-required-permissions"></a>
#### Required permissions
`Project.Member.Iam.Update`

<a id="modify-project-iam-account-roles-request-parameter"></a>
#### Request Parameter

| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Y | Project ID | 
|  Path |member-uuid | String| Y | Member UUID to change role to | 
| Request Body | request | [UpdateMemberRoleRequest](#updatememberrolerequest)| Y | Request |




<a id="modify-project-iam-account-roles-response-body"></a>
#### Response Body

```json
{
  "header" : {
    "isSuccessful" : true,
    "resultCode" : 0,
    "resultMessage" : "resultMessage"
  }
}
```

##### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common response](#common-response)| Y   |


<a id="view-all-credentials-of-members-under-organizations"></a>
### View all credentials of members under organizations { #view-all-credentials-of-members-under-organizations }

> GET "/v1/authentications/organizations/{org-id}/user-access-keys"

API to get the credentials of members in the organization or project.

<a id="view-all-credentials-of-members-under-organizations-required-permissions"></a>
#### Required permissions
`Organization.UserAccessKey.List`

<a id="view-all-credentials-of-members-under-organizations-request-parameter"></a>
#### Request Parameter



| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Y | Organization ID to look up the UserAccessKey for |
|  Query |paging | Paging| N | Number of displays per page, default 20 |




<a id="view-all-credentials-of-members-under-organizations-response-body"></a>
#### Response Body

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


##### Response


| Name | Type | Required | Description |   
|------------ | ------------- | ------- | ------------ |
|   header | [Common response](#common-response)| Y |
|   paging | [PagingResponse](#pagingresponse)| Y  |
|   authenticationList | List<UserAccessKeyResponseV7>| Y  | Member-specific authentication key information |


##### UserAccessKeyResponseV7

| Name | Type | Required | Description |
|------------|--------|------|-----------------------------|
| authId | String | Y | Authentication Method ID (masked) |
| uuid | String | Y | User UUID |
| userAccessKeyID | String | Y | User Access Key ID (masked) |
| secretAccessKey | String | N | Secret key (whitespace) |
| authStatusCode | String | Y | Authentication status codes (STABLE, STOP, BLOCKED) |
| tokenExpiryPeriod | Long | N | Token expiration cycle |
| regDatetime | Date | N | Date and time of creation |
| modDatetime | Date | N | Date and time of deletion |
| lastUsedDatetime | Date | N | Date of last use |
| reIssueDatetime | Date | N | secretAccessKey regeneration timeout |
| lastTokenUsedDatetime | Date | N | Date of last token use |
| validTokenCount | Long | N | Number of valid tokens |

<a id="view-your-own-organization-list"></a>
### View your Own Organization List { #view-your-own-organization-list }

> GET /v1/organizations

<a id="view-your-own-organization-list-required-permission"></a>
#### Required Permission
Available to all members. No specific permissions required.

**[Query Parameter]**

| Name | Type | Required | Description |
|---|---|---|---|
| orgName | String | N | Organization name |
| orgNameMatchTypeCode | String | N | Search type for organization name (EXACT: exact match, LIKE: partial match, default: LIKE) |
| page | Integer | N | Target page, default: 1 |
| limit | Integer | N | No. of views per page, default: 20 |

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
| header | [Common response](#common-response) | Y | |
| orgList | List&lt;OrgMemberRelationProtocol> | Y | Organization lilst info |
| paging | [PagingResponse](#pagingresponse) | Y | Paging info |

##### OrgMemberRelationProtocol

| Name | Type | Required | Description |
|---|---|---|---|
| org | OrgProtocol | Y | Organization info |
| orgMember | OrgMemberProtocol | Y | Organization/project member info |
| orgOwner | OwnerProtocol | Y | Organization Owner info |

##### OrgProtocol

| Name | Type | Required | Description |
|---|---|---|---|
| orgId | String | Y | Organization ID |
| orgName | String | Y | Organization name |
| orgStatusCode | String | Y | Organization status code (STABLE, CLOSED) |
| ownerUuid | String | Y | Organization Owner UUID |
| regDateTime | Date | Y | Organization created on |
| remainingJobCode | String | Y | Organization follow-up actions (NONE, IAM_ORG_CREATE, IAM_ORG_UPDATE, IAM_ORG_DELETE) |
| ipAclTypeCode | String | Y | Type code for organization IP ACL (COMMON, INDIVIDUAL) |
| orgDomainList | List&lt;OrgDomainProtocol> | Y | Organization domain list |

##### OrgMemberProtocol

| Name | Type | Required | Description |
|---|---|---|---|
| existOrgMember | Boolean | Y | Organization member exists |
| orgOwner | Boolean | Y | Organization Owner |

##### OwnerProtocol

| Name | Type | Required | Description |
|---|---|---|---|
| email | String | Y | Organization Owner email |
| name | String | Y | Organization Owner name |
| restrictStatusCode | String | Y | Organization Owner restriction status (HOLD, MEMBER_BLOCKED, RESOURCE_BLOCKED, RESOURCE_DELETED, STABLE, UNPAID) |
| country | String | Y | Organization Owner country code |
| restrictTypes | List&lt;String> | Y | Organization Owner restriction list |

##### OrgDomainProtocol

| Name | Type | Required | Description |
|---|---|---|---|
| domainId | String | Y | Organization domain ID |
| domainName | String | Y | Organization domain name |


<a id="add-your-own-organization"></a>
### Add your own organization { #add-your-own-organization }

> POST /v1/organizations

An API to add your own organization.

<a id="add-your-own-organization-required-permission"></a>
#### Required Permission
Available to all members. No specific permissions required.

<a id="add-your-own-organization-request-parameter"></a>
#### Request Parameter

| Category | Name | Type | Required | Description |
|------------- |------------- | ------------- | ------------- | ------------- |
| Request Body | request | [CreateOrgRequest](#createorgrequest)| Y | Request |

##### CreateOrgRequest

| Name | Type | Required | Description |
|---|---|---|---|
| orgName | String | Y | Organization name to create (up to 70 characters) |


<a id="add-your-own-organization-response-body"></a>
#### Response Body

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

##### Response


| Name | Type | Required | Description |
|---|---|---|---|
| header | [Common response](#common-response) | Y | |
| orgId | String | Y | Organization ID |
| orgName | String | Y | Organization name |
| owner | [Owner](#owner) | Y | Organization Owner info |

##### Owner

| Name | Type | Required | Description |
|---|---|---|---|
| email | String | Y | Organization Owner email |
| name | String | Y | Organization Owner name |
| ownerId | String | Y | Organization Owner ID |
| restrictTypes | List&lt;String> | Y | List for restriction targets |


<a id="delete-a-single-organization"></a>
### Delete a single organization { #delete-a-single-organization }

> DELETE /v1/organizations/{org-id}

An API to delete your own organization.

<a id="delete-a-single-organization-required-permission"></a>
#### Required Permission
`Organization.Delete`

<a id="delete-a-single-organization-request-parameters"></a>
#### Request Parameters

| Category | Name | Type | Required | Description |
|------------- |------------- | ------------- | ------------- | ------------- |
| Path |org-id | String | Y | Organization ID |

<a id="delete-a-single-organization-response-body"></a>
#### Response Body

```json
{
"header": {
"isSuccessful": true,
"resultCode": 0,
"resultMessage": "resultMessage"
}
}
```

##### Response

| Name | Type | Required | Description |
|---|---|---|---|
| header | [Common Response](#common-response) | Y | |

<a id="retrieve-service-information-list"></a>
### Retrieve Service Information List { #retrieve-service-information-list }

> GET /v1/products

This API retrieves a list of available services.

<a id="retrieve-service-information-list-required-permissions"></a>
#### Required Permissions
Available to all members. No specific permissions required.

<a id="retrieve-service-information-list-request-parameters"></a>
#### Request Parameters

| Category | Name | Type | Required | Description |
|---|---|---|---|---|
| Query | productId | String | N | Service ID |
| Query | productCategoryCode | String | N | Service Category Code (PROJECT, ORG, MARKET_PLACE) |
| Query | productName | String | N | Service Name |
| Query | productNameLike | String | N | Service Name Like Search |
| Query | limit | Integer | N | Number of items displayed per page, default 20 |
| Query | page | Integer | N | Target page, default 1 |

<a id="retrieve-service-information-list-response-body"></a>
#### Response body

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

##### Response

| Name | Type | Required | Description |
|---|---|---|---|
| header | [common response](#common-response) | Y | |
| paging | [PagingResponse](#pagingresponse) | Y | |
| products | List<Product> | Y | Service Information List |

##### Product

| Name | Type | Required | Description |
|---|---|---|---|
| parentProductId | String | N | Parent Service ID |
| productCategoryCode | String | Y | Service Category Code (PROJECT, ORG, MARKET_PLACE) |
| productId | String | Y | Service ID |
| productName | String | Y | Service Name |

<a id="view-role-descriptions-by-multiple-language"></a>
### View Role Descriptions by Multiple Language { #view-role-descriptions-by-multiple-language }

> GET /v1/messages/role

This API retrieves a list of role descriptions in multiple languages.

<a id="view-role-descriptions-by-multiple-language-required-permission"></a>
#### Required Permission
Available to all members. No specific permissions required.

<a id="view-role-descriptions-by-multiple-language-request-parameter"></a>
#### Request parameter

| Category | Name | Type | Required | Description |
|------------- |------------- | ------------- | ------------- | ------------- |
| Query |messageType | String| N | Message Type<br><ul><li>MESSAGE</li><li>ERROR</li></ul> |
| Query |languages | List&lt;String>| N | Language<br><ul><li>KO_KR</li><li>JA_JP</li><li>EN_US</li><li>ZH_CN</li></ul> |
| Query |keyword | String| N | Search keyword |
| Query |messageId | String| N | Message ID |
| Query |limit | Integer| Y | Number of displays per page |
| Query |page | Integer| Y | Target page |


<a id="view-role-descriptions-by-multiple-language-response-body"></a>
#### Response body

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
      "koKr": "한국어 메시지",
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

##### Response


| Name | Type | Required | Description |
|---|---|---|---|
| header | [Common Response](#common-response) | Y | |
| messages | List<MessageProtocol> | Y | Message list |
| paging | [PagingResponse](#pagingresponse)| Y | |

##### MessageProtocol

| Name | Type | Required | Description |
|---|---|---|---|
| i18nMessageSeq | Long | N | Message sequence |
| categoryId | String | N | Category ID |
| messageId | String | N | Message ID |
| messageType | String | N | Message type (MESSAGE, ERROR) |
| description | String | N | Description |
| koKr | String | N | Korean message |
| enUs | String | N | English message |
| jaJp | String | N | Japanese message |
| zhCn | String | N | Chinese message |


<a id="error-code"></a>
### Error Code { #error-code }

| Result code | Description                                                                                  | Actions                                                      |
| ---------- |-------------------------------------------------------------------------------------|---------------------------------------------------------|
| 80007 | Errors when calling with an expired or non-existent token                                          | Issue and redeem a new token                                         |
| -6 | Errors that occur when invoked by unauthorized callers                                                      | Give callers the right permissions                                        |
| -8 | Errors that occur when IP validation fails by an organization's IP ACL policy                                              | Verify that the IP is registered in your organization's IP ACLs                            |
| 404 | Fired on API calls without                                                                       | Check the httpmethod,uri of the API you're calling                            |
| 400<br>501<br>502<br>503<br>Server connection failed<br>505 | Errors that occur when request parameters are not appropriate                                                          | Check request parameters for required and configurable values, etc.                           |
| 500 | Abnormal system errors                                                                          | Contact a representative                                            |
| 1000 | Errors that occur when parameters are incorrect <br> Organization `IAM` member API - `IAM member password change email send` request value returnUrl is not an authorized domain (authorized domains: toast.com, dooray.com, nhncloud.com) | Verify request parameters                                              |
| 1201 | Errors caused by failed API requests internal to the server |  Resolve based on the error message and code in the error message<br>Contact your representative if the included error message and code are not sufficient for resolution.                      |
| 10005<br>70008<br>1104 | Errors that occur when request parameters are not appropriate | Check request parameters for required and configurable values, etc. |
| 10009 | Errors when granting roles that don't exist in an organization or project                                               | Change to give members an existing role                                  |
| 10010 | Error when deleting a role group, when project members (including those being invited) are granted only that role group<br>Error when changing project member roles and not granting any roles| 1) Change the roles of project members (including those you're inviting) whose only role `groups` are the ones you want to delete to other roles, or delete them <br> 2) When changing the project member role, set the value for the role in the request by setting the Request |
| 10012 | Error when deleting a project member, if the member is deleted and the project no longer has a member with the ADMIN role.        | 1) Give the ADMIN role to another project member who is not targeted for deletion <br>2) Delete targets that are not in the ADMIN role|
| 12100 | Errors when project members don't exist                                                          | Use existing project member UUIDs                                    |
| 12107 | Error when request uuid and target uuid are the same in APIs that don't allow them to be the same                              | Make the target UUID different from the request UUID                               |
| 12400 | Errors when adding members to a non-existent or deleted project                                               | Change to add members to an existing project                                  |
| 12401 | Error when creating a project and exceeding the limit on the number of projects created set in the project's organization OWNER account                    | 1) Delete unused projects to free up the number of projects you can create <br>2) Request an adjustment to the maximum number of projects created through your representative |
| 12500 | When deleting a project, an error occurs when a service in use exists                                                  | Disable all services in use for the project and then attempt to process the project deletion             |
| 13001 | Errors that occur when enabling/disabling a service fails                                                           | Contact a representative                                           |
| 13002 | Errors that occur when you reactivate a service that is already active                                    | Leverage services that are already active              |
| 13004 | Error when enabling an unenabled service                                                     | Enable for activatable services                                    |
| 13006 | Enable Entity-only service, error when Organization OWNER's member type is not Entity                                    | Attempting to activate a service in an organization subproject of an organization OWNER with an entity account type             |
| 22006 | Fires if it already exists when added | Prevent duplicate requests from coming in |
| 22013 | Error when attempting to change the organization OWNER's role                                                        | You can't change roles for organization owners                                |
| 22016 | Errors that occur when an organization doesn't exist                                                              | Make sure you're requesting with the orgId of an existing organization                              |
| 23005 | Errors that occur when an organization does not exist for an organization ID                                                   | Contact a representative                                             |
| 30015 | Error when exceeding the limit on the number of generated project integrated AppKeys <br> Project integrated AppKey API - The number of project integrated AppKeys generated `by Generate Project AppKey`is 3, and an error occurs if more than 3 are generated. | Delete an unused project integrated AppKey and retry                               |
| 40017 | Errors that occur when a project doesn't exist                                                           | Make an API request for an existing project                                   |
| 40028<br>13003 | Errors that occur when a project doesn't exist (created and then deleted)                                              | Make an API request for an existing project                                   |
| 40054 | Error when activating a service, if a service that should be activated first is not activated                               | Handle activating services that need to be activated first                               |
| 40057 | When disabling a service, an error occurs if a service that should be disabled first is not disabled                            | Handle disabling services that should be disabled first                              |
| 50007 | Invalid members, errors that occur<br>(Members that don't exist, are dormant, or are withdrawn are not valid)<br>Organization creation API - When making API calls, if the uuid is invalid | Modify with the UUID of a valid member                                 |
| 60003 | Errors that occur when there is no data in the DB<br>Error when there are no integrated AppKeys to delete in Project `AppKey` API - `Delete Project Integrated AppKeys`  | 1) Contact a representative <br>2) Set the existing AppKey to the value of the AppKey to be deleted  |
| 62004 | Error when creating a role group if a role group with the same name exists                                           | Change to a non-duplicate name                                         |
| 62008 | Role group ID does not exist when editing, deleting, and adding/deleting roles to a role group                            | Change to use an existing role group ID                                |
| 62009 | Occurs if the role is an invalid role when creating a role group                                                   | Change to use a valid role                                       |
| 62011 | Role group deletion caused by being used by a notification group                                                        | Change to delete role groups after deleting notification groups                              |
| 62014 | When deleting a role group and adding/deleting roles to a role group, members who were assigned to the role group failed to notify the service of the roles.                       | Contact a representative                                            |
| 62019 | If you want to grant an organization member an unallowed role                      | Contact a representative                                            |
| 72005 | Errors that occur when billing-related API calls fail                                                         | Contact a representative                                            |
| 70013 | Errors that occur when a service you're using exists                                                             | Disable a service you're using                                           |
| 70014 | Error when member withdrawal conditions are not met<br> IAM - 1) when a service is in use 2) when a project exists that has not been deleted 3) when the member exists in the ADMIN role on any project| Set up withdrawal conditions for each member type                          |
| 70024 | Errors that occur when a payment method is not properly registered                                                     | Register a payment method                                                 |
| 70032 | Error when becoming a member block due to non-payment                                                       | Pay outstanding bills for that account                                     |
| -200201 | Errors that occur when the user-code length condition is not met                                                           | Lowercase letters, numbers, and special characters (-, \_, .) within 20 characters.<br>Special characters (-, \_, .) are not allowed in leading and trailing positions.|
| -200202 | Errors that occur when user-code formatting conditions are not met                                                | Accept lowercase letters, numbers, and special characters (-, \_, .).<br>Special characters (-, \_, .) are not allowed in leading and trailing positions.|
| -200203 | Errors that occur when the name length condition is not met                                                       | Modify the name length to meet the 60-character length requirement                           |
| -200204 | Error with overlapping user-code when modifying member creation                                                | Change to non-duplicate user-code to request                             |