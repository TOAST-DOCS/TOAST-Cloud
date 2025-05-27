## NHN Cloud > Public API > Framework API

### Overview
The following APIs allow you to manage your organization and projects, such as creating project members and assigning roles.
To use the APIs, you need a token of type Bearer, which is issued through [API calls and authentication](api-authentication.md).
When you make an API call, the API checks the permissions of the authenticated member.

### Public API Domain
`https://core.api.nhncloudservice.com/`

### Common

#### Request
<a id="Request"></a>
When calling the Public API, you must include the Request Header below.


| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
| Header |  x-nhn-authorization | String| Yes | Bearer type token issued to the user |


#### Response
<a id="Response"></a>
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
|   isSuccessful | Boolean | No | Successful or not  |
|   resultCode | Integer| No | Result code. 0 is returned on success, or an error code on failure.  |
|   resultMessage | String| No | Result message  |

#### Common Type
<a id="common-type"></a>


| Name | Type | Size | Description | 
|------------ | ------------- | ------------- | ------------ |
| org-id | String | 16 characters | Organization ID |
| project-id | String | 8 characters | Project ID |
| product-id | String | 8 characters | Service (product) ID |
| user-access-key-id | String | 20 characters | User Access Key ID |
| project-app-key | String | 20 characters | The project's AppKey |
| product-app-key | String | 16 characters | The service's AppKey |
| UUID | String | 36 characters | Member's UUID |


#### Set up governance IP ACLs
<a id="Set-governance-IP-ACL"></a>

If you set IP ACLs through **Organization Management > Governance Settings > Organization Governance Settings > IP ACL Settings**, those settings are also applied to calls to the framework API.


### API

> [Caution]<br>
> Responses from the API can have fields added that are not specified in the guide, so they should be developed so that new fields added do not cause errors.<br>
> Also, when saving the DB, the column size may change, so you should set it generously.

| Method | HTTP Request | Description |
|------------- | ------------- | -------------|
| POST |[/v1/projects/{project-id}/members](#프로젝트-멤버-생성) | Create a project member |
| POST |[/v1/organizations/{org-id}/projects](#프로젝트-추가) | Add a project |
| DELETE |[/v1/projects/{project-id}/members/{target-uuid}](#프로젝트-멤버-단건-삭제) | Delete a single project member |
| DELETE |[/v1/projects/{project-id}](#프로젝트-삭제) | Delete a project |
| DELETE |[/v1/projects/{project-id}/products/{product-id}/disable](#프로젝트-상품-종료) | End a project product |
| POST |[/v1/projects/{project-id}/products/{product-id}/enable](#프로젝트-상품-이용) | Use a project product |
| GET |[/v1/organizations/{org-id}/roles](#조직-역할-목록-조회) | List organization roles |
| GET |[/v1/projects/{project-id}/roles](#프로젝트-역할-목록-조회) | List project roles |
| GET |[/v1/organizations/{org-id}/domains](#조직-도메인-검색) | Search for an organization domain |
| GET |[/v1/organizations/{org-id}/members/{member-uuid}](#조직-멤버-단건-조회) | View a organization member |
| POST |[/v1/organizations/{org-id}/members/search](#조직-멤버-목록-조회) | List organization members |
| GET |[/v1/organizations/{org-id}/project-role-groups](#조직의-프로젝트-공통-역할-그룹-전체-조회) | View all common role groups for projects in the organization |
| GET |[/v1/product-uis/hierarchy](#상품-계층-구조-조회) | View product hierarchy |
| GET |[/v1/projects/{project-id}/products/{product-id}](#프로젝트에서-사용-중인-상품-조회) | View a product used in the project |
| GET |[/v1/projects/{project-id}/members/{member-uuid}](#프로젝트-멤버-단건-조회) | View a project member |
| POST |[/v1/projects/{project-id}/members/search](#프로젝트-멤버-목록-조회) | List project members |
| GET |[/v1/projects/{project-id}/project-role-groups/{role-group-id}](#프로젝트-역할-그룹-단건-조회) | View a project role group |
| GET |[/v1/organizations/{org-id}/project-role-groups/{role-group-id}](#조직의-프로젝트-공통-역할-그룹-단건-조회) | View a common role group for the project in the organization |
| GET |[/v1/projects/{project-id}/project-role-groups](#프로젝트-역할-그룹-전체-조회) | View all project role groups |
| GET |[/v1/organizations/{org-id}/projects](#조직에-속한-프로젝트-목록-조회) | List projects in your organization |
| GET |[/v1/organizations/{org-id}/governances](#사용-중인-조직-거버넌스-목록-조회) | List organization governance in use |
| POST |[/v1/organizations/{org-id}/project-role-groups](#조직의-프로젝트-공통-역할-그룹-생성) | Create a common role group for projects in the organization |
| DELETE |[/v1/organizations/{org-id}/project-role-groups](#조직의-프로젝트-공통-역할-그룹-삭제) | Delete a project common role group in the organization |
| PUT |[/v1/organizations/{org-id}/project-role-groups/{role-group-id}/infos](#조직의-프로젝트-공통-역할-그룹-정보-수정) | Modify your organization's project common role group information |
| PUT |[/v1/organizations/{org-id}/project-role-groups/{role-group-id}/roles](#조직의-프로젝트-공통-역할-그룹-역할-수정) | Modify your organization's project common roles group roles |
| POST |[/v1/projects/{project-id}/project-role-groups](#프로젝트-역할-그룹-생성) | Create a project role group |
| DELETE |[/v1/projects/{project-id}/project-role-groups](#프로젝트-역할-그룹-삭제) | Delete a project role group |
| PUT |[/v1/projects/{project-id}/project-role-groups/{role-group-id}/infos](#프로젝트-역할-그룹-정보-수정) | Edit project role group information |
| PUT |[/v1/projects/{project-id}/project-role-groups/{role-group-id}/roles](#프로젝트-역할-그룹-역할-수정) | Modify project role group roles |
| PUT |[/v1/organizations/{org-id}/members/{member-uuid}](#조직-멤버-역할-수정) | Modify organization member roles |
| PUT |[/v1/projects/{project-id}/members/{member-uuid}](#프로젝트-멤버-역할-수정) | Modify project member roles |
| GET |[/v1/iam/organizations/{org-id}/members/{member-uuid}](#조직-IAM-멤버-단건-조회) | View organization IAM members |
| GET |[/v1/iam/organizations/{org-id}/members](#조직-IAM-멤버-목록-조회) | List organization IAM members |
| POST |[/v1/iam/organizations/{org-id}/members](#조직-IAM-멤버-추가) | Add an organization IAM member |
| POST |[/v1/iam/organizations/{org-id}/members/{member-id}/send-password-setup-mail](#IAM-멤버-비밀번호-변경-이메일-전송) | Send an IAM member password change email |
| PUT |[/v1/iam/organizations/{org-id}/members/{member-uuid}](#조직-IAM-멤버-정보-수정) | Modify organization IAM member information |
| POST |[/v1/iam/organizations/{org-id}/members/{member-id}/set-password](#조직-IAM-멤버-비밀번호-변경) | Change an organization IAM member password |
| GET |[/v1/iam/organizations/{org-id}/settings/session](#조직-IAM-로그인-세션-설정-정보를-조회) | View organization IAM sign-in session settings information |
| GET |[/v1/iam/organizations/{org-id}/settings/security-mfa](#조직-IAM-로그인-2차-인증에-대한-설정을-조회) | View settings for organizational IAM sign-in second factor authentication |
| GET |[/v1/iam/organizations/{org-id}/settings/security-login-fail](#조직-IAM-로그인-실패-보안-설정을-조회) | View Organization IAM Login Failure Security Settings |
| GET |[/v1/iam/organizations/{org-id}/settings/password-rule](#조직-IAM-계정-비밀번호-정책-조회) | Get your organization's IAM account password policy |
| GET |[/v1/organizations/{org-id}/products/ip-acl](#조직-IP-ACL-목록-조회) | Listorganization IP ACLs |
| POST |[/v1/billing/contracts/basic/products/prices/search](#종량제에-등록된-상품-가격-조회) | Get the price of a product on a pay-as-you-go subscription |
| GET |[/v1/billing/contracts/basic/products](#종량제에-등록된-상품-목록-조회) | List products enrolled in a pay-as-you-go subscription |
| GET |[/v1/authentications/projects/{project-id}/project-appkeys](#프로젝트-AppKey-조회) | Get Project AppKey |
| GET |[/v1/authentications/user-access-keys](#User-Access-Key-ID-목록-조회) | ListUser Access Key IDs |
| POST |[/v1/authentications/projects/{project-id}/project-appkeys](#프로젝트-AppKey-등록) | Register a project AppKey |
| POST |[/v1/authentications/user-access-keys](#User-Access-Key-ID-등록) | Register a User Access Key ID |
| DELETE |[/v1/authentications/projects/{project-id}/project-appkeys/{app-key}](#프로젝트-AppKey-삭제) | Delete a project AppKey |
| PUT |[/v1/authentications/user-access-keys/{user-access-key-id}/secretkey-reissue](#User-Access-Key-ID-비밀-키-재발급) | Reissue the User Access Key ID secret key |
| PUT |[/v1/authentications/user-access-keys/{user-access-key-id}](#User-Access-Key-ID-상태-수정) | Modify User Access Key ID status |
| DELETE |[/v1/authentications/user-access-keys/{user-access-key-id}](#User-Access-Key-ID-삭제) | Delete a User Access Key ID |
| GET    | [/v1/authentications/user-access-keys/{user-access-key-id}/tokens](#토큰-목록-조회)                               | Get Token list                    |
| DELETE | [/v1/authentications/user-access-keys/{user-access-key-id}/tokens](#토큰-다건-만료)                               | Expire multiple tokens                    |
| POST |[/v1/iam/projects/{project-id}/members](#프로젝트-IAM-계정-생성) | Create a project IAM account |
| DELETE |[/v1/iam/projects/{project-id}/members](#프로젝트-IAM-계정-다건-삭제) | Delete multiple project IAM accounts |
| GET |[/v1/iam/projects/{project-id}/members/{member-uuid}](#프로젝트-멤버-단건-조회) | View a project IAM account |
| GET |[/v1/iam/projects/{project-id}/members](#프로젝트-IAM-계정-목록-조회) | View project IAM accounts |
| PUT |[/v1/iam/projects/{project-id}/members/{member-uuid}](#프로젝트-IAM-계정-역할-수정) | Modify project IAM account roles |
| GET |[/v1/authentications/organizations/{org-id}/user-access-keys](#조직-하위-멤버의-모든-인증정보-리스트-조회) | View all credentials of members under organizations |



<a id="프로젝트-멤버-생성"></a>
#### Create a project member

> POST "/v1/projects/{project-id}/members"

API to add members to a project.

##### Required permissions
`Project.Member.Create`

##### Request Parameter



| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | The project ID to which you want to add the member | 
| Request Body | request | CreateMemberRequest| Yes | Request |




###### CreateMemberRequest
> [Caution]<br>
> At least one of memberUuid, email, and userCode must have a value when requested.<br>
> If you're checking for values in the order memberUuid > email > userCode, add that member as a project member.<br>
> Only one project member can be created in a request.


| Name | Type | Required | Description |  
|------------ | ------------- | ------------- | ------------ |
|   assignRoles | List<UserAssignRoleProtocol>| Yes | List of roles to assign to users  |
|   memberUuid | String| No | UUID of the member to add  |
|   email | String| No | The email of the member you want to add  |
|   userCode | String| No | IAM member ID to add  |


###### UserAssignRoleProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   roleId | String| Yes | Role ID  |
|   conditions | List<AssignAttributeConditionProtocol>| No | Role condition attribute  |


###### AssignAttributeConditionProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   attributeId | String| Yes | Condition attribute ID  |
|   attributeOperatorTypeCode | String| Yes | Condition attribute operator<br>Available operators vary depending on the conditional attribute data type<br><ul><li>ALLOW</li><li>ALL_CONTAINS</li><li>ANY_CONTAINS</li><li>ANY_MATCH</li><li>BETWEEN</li><li>BEYOND</li><li>FALSE</li><li>GREATER_THAN</li><li>GREATER_THAN_OR_EQUAL_TO</li><li>LESS_THAN</li><li>LESS_THAN_OR_EQUAL_TO</li><li>NONE_MATCH</li><li>NOT_ALLOW</li><li>NOT_CONTAINS</li><li>TRUE</li></ul>  |
|   attributeValues | List<String>| Yes | Condition attribute value  |


##### Response Body

```json
{
  "header" : {
    "isSuccessful" : true,
    "resultCode" : 0,
    "resultMessage" : "resultMessage"
  }
}
```

###### Response


| Name | Type           | Required | Description |   
|------------ |--------------| ------- | ------------ |
|   header | [Common response](#Response) | Yes |


<a id="프로젝트-추가"></a>
#### Add a project

> POST "/v1/organizations/{org-id}/projects"

API to add projects to your organization.

##### Required permissions
`Organization.Project.Create`

##### Request Parameter



| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
| Path |org-id | String| Yes | Organization ID to add the project to | 
| Request Body | request | CreateProjectRequest| Yes | Request |


###### CreateProjectRequest


| Name | Type | Required | Description |   
|------------ | ------------- | ------ | ------------ |
|   description | String| No | Project description (up to 100 characters) |
|   projectName | String| Yes| Project name (up to 40 characters) |


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
|   header | [Common response](#Response)| Yes  |
|   regDateTime | Date| Yes   | When the project is created | 
|   description | String| No   | Project description | 
|   ownerId | String| Yes   | Project owner member ID | 
|   projectName | String| Yes   | Project name | 
|   projectId | String| Yes   | Project ID | 
|   orgId | String| Yes   | Organization ID | 
|   projectStatusCode | String| Yes   | Project status<br><ul><li>STABLE: In normal use</li><li>CLOSED: The payment has been made and the project is well closed.</li><li>BLOCKED: Prohibited by administrator</li><li>TERMINATED: All resources have been deleted due to delinquency.</li><li>DISABLED: All products are closed but not paid for</li></ul> | 


<a id="프로젝트-멤버-단건-삭제"></a>
#### Delete a single project member

> DELETE "/v1/projects/{project-id}/members/{target-uuid}"

API to delete a user from a project.

##### Required permissions
`Project.Member.Delete`

##### Request Parameter



| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | Project ID | 
|  Path |target-uuid | String| Yes | Member UUID to delete | 




##### Response Body

```json
{
  "header" : {
    "isSuccessful" : true,
    "resultCode" : 0,
    "resultMessage" : "resultMessage"
  }
}
```

###### Response


| Name | Type | Required | Description |   
|------------ | ------------- | ------- | ------------ |
|   header | [Common response](#Response)| Yes |



<a id="프로젝트-삭제"></a>
#### Delete a project

> DELETE "/v1/projects/{project-id}"

API to delete a project.

##### Required permissions
You'll need one permission from the list below
* `Organization.Project.Delete`
* `Project.Delete`

##### Request Parameter



| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | Project ID to delete | 






##### Response Body

```json
{
  "header" : {
    "isSuccessful" : true,
    "resultCode" : 0,
    "resultMessage" : "resultMessage"
  }
}
```

###### Response


| Name | Type | Required | Description |   
|------------ | ------------- | ------- | ------------ |
|   header | [Common response](#Response)| Yes |



<a id="프로젝트-상품-종료"></a>
#### End a project product

> DELETE "/v1/projects/{project-id}/products/{product-id}/disable"

API to disable a user-specified service so that it is no longer used by this project.

##### Required permissions
`Product Name: Product.Delete`

##### Request Parameter


| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | Project ID of the project you want to shut down | 
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
|   header | [Common response](#Response)| Yes |
|   childProducts | List<ChildProduct>| No   | Subservice information for that service, not included if there are no subservices.<br>Requires you to disable the child service first and then disable the service.|

###### ChildProduct


| Name | Type | Required | Description |   
|------------ | ------------- | --------- | ------------ |
|   productId | String| Yes  | 	Subservice ID | 
|   productName | String| Yes  | Subservice name |
|   statusCode | String| Yes |   Service status (STABLE, CLOSED) |


<a id="프로젝트-상품-이용"></a>
#### Use a project product

> POST "/v1/projects/{project-id}/products/{product-id}/enable"

An API that requests to enable a service you specify to be available in your project.

##### Required permissions
`Product Name: Product.Create`

##### Request Parameter



| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |product-id | String| Yes | Service ID | 
|  Path |project-id | String| Yes | The ID of the project you want to use the service for | 


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
|   header | [Common response](#Response)| Yes |
|   appKey | String| Yes | AppKey information for the service your project is using|
|   parentProduct | ParentProduct| No | Shows parent service information if it exists, or does not include it if no parent service exists |
|   secretKey | String| No| Secret key information for the service your project is using.<br> Only available for services that use secret keys |


###### ParentProduct


| Name | Type | Required | Description |   
|------------ | ------------- | --------- | ------------ |
|   productId | String| Yes  | Service ID |
|   productName | String| Yes  | Service name |
|   statusCode | String| Yes | Service status (STABLE, CLOSED) |





<a id="조직-역할-목록-조회"></a>
#### List organization roles

> GET "/v1/organizations/{org-id}/roles"

API to request a list of roles that can be granted to users in your organization.

##### Required permissions
`Organization.RoleGroup.List`

##### Request Parameter



| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | Organization ID |
|  Query |categoryTypeCodes | List<String> | No | Role/Permission/Role Group Category Distinction (ROLE, PERMISSION, ROLE_GROUP) |
|  Query |roleNameLike | String| No | Role/privilege/role group name |
|  Query |limit | Integer| No | Number of displays per page, default 20 | 
|  Query |page | Integer| No | Target Page, default 1 |



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
|   header | [Common response](#Response)| Yes |
|   roles | List<RoleProtocol>| Yes  | Roles list |
|   totalCount | Integer| Yes  | Total count |

###### RoleProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   categoryKey | String| Yes | Role/Privilege Category Taxonomy Key<br><ul><li>RoleGroup: Project role group</li><li>OrgRoleGroup: Organization Role Group</li><li>OrgRole: Organization Role</li><li>ProjectRole: Project role</li><li>BillingRole: Billing-related roles</li><li>OrgServiceRole: Organization Service Role</li><li>ProjectServiceRole: Project service role</li><li>SystemRole: System-generated role</li></ul>  |
|   categoryTypeCode | String| Yes | Role group/role/privilege distinguishing codes (ORG_ROLE_GROUP, PERMISSION, ROLE, ROLE_GROUP, SYSTEM) |
|   description | String| Yes | Role/privilege description  |
|   roleCategory | String| Yes | Role/Privilege Category Broad Classification (ORG_ROLE, ORG_ROLE_GROUP, ORG_SERVICE_ROLE, PROJECT_ROLE, PROJECT_ROLE_GROUP, PROJECT_SERVICE_ROLE, SYSTEM_ROLE) |
|   roleId | String| Yes | Role/Privilege ID  |
|   roleName | String| Yes | Role/privilege name  |


<a id="프로젝트-역할-목록-조회"></a>
#### List project roles

> GET "/v1/projects/{project-id}/roles"

API to request a list of roles that can be granted to project users.

##### Required permissions
`Project.RoleGroup.List`

##### Request Parameter


| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | Project ID | 
|  Query |categoryTypeCodes | List<String> | No | Role/Permission/Role Group Category Distinction (ROLE, PERMISSION, ROLE_GROUP) |
|  Query |roleNameLike | String| No | Role/privilege/role group name |
|  Query |limit | Integer| No | Number of displays per page, default 20 | 
|  Query |page | Integer| No | Target Page, default 1 |


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
|   header | [Common response](#Response)| Yes |
|   roles | List<[RoleProtocol](#roleprotocol)>| Yes  | Roles list |
|   totalCount | Integer| Yes  | Total count |

<a id="조직-도메인-검색"></a>
#### Search for an organization domain

> GET "/v1/organizations/{org-id}/domains"

API to look up domains for a specific organization.

##### Required permissions
`Organization.Domain.List`

##### Request Parameter



| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | The ID of the organization to look up | 




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
|   header | [Common response](#Response)| Yes |
|   domainList | List<OrgDomainProtocol>| Yes  |


###### OrgDomainProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | --------- | ------------ |
|   orgDomainId | String| Yes | Organization domain ID |
|   orgDomainName | String| Yes | Organization domain name |


<a id="조직-멤버-단건-조회"></a>
#### View a organization member

> GET "/v1/organizations/{org-id}/members/{member-uuid}"

API to get members belonging to an organization.

##### Required permissions
`Organization.Member.Get`

##### Request Parameter



| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | Organization ID for which you want to look up members | 
|  Path |member-uuid | String| Yes | 	Member UUID to look up | 





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
|   header | [Common response](#Response)| Yes |
|   orgMember | OrgMemberRoleBundleProtocol| No  | Added member information, not included on error |

###### OrgMemberRoleBundleProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ----- | ------------ |
|   email | String| Yes | Member email |
|   id | String| No | Member ID (available only to IAM members) |
|   inviteStatusCode | String| Yes |   COMPLETE, EXPIRE, UNKNOWN, WAIT |
|   joinYmdt | Date| Yes | Organization member enrollment date |
|   memberName | String| Yes| 	Member name |
|   memberTypeCode | String| Yes| Member classification (TOAST_CLOUD: NHN Cloud member, IAM: IAM member) |
|   memberUuid | String| Yes| Member's UUID |
|   recentLoginYmdt | Date| Yes| Last login date |
|   recentPasswordModifyYmdt | Date| No| Date of last password change |
|   roleCode | String| No| Role ID |
|   roles | List<RoleBundleProtocol>| No | List of related roles (with condition attributes)  |
|   secondFactorCertificationYn | String| No| Whether to set up two-step sign-in (available to NHN Cloud members only) |


###### RoleBundleProtocol
| Name | Type | Required | Description |   
|------------ | ------------- | ----- | ------------ |
|   roleId | String| Yes |  Role ID |
|   roleName | String| Yes |  Role name |
|   description | String| No |  Role descriptions |
|   categoryKey | String| Yes | Role/Privilege Category Taxonomy Key<br><ul><li>RoleGroup: Project role group</li><li>OrgRoleGroup: Organization Role Group</li><li>OrgRole: Organization Role</li><li>ProjectRole: Project role</li><li>BillingRole: Billing-related roles</li><li>OrgServiceRole: Organization Service Role</li><li>ProjectServiceRole: Project service role</li><li>SystemRole: System-generated role</li></ul>  |
|   categoryTypeCode | String| Yes | Role group/role/privilege distinguishing codes (ORG_ROLE_GROUP, PERMISSION, ROLE, ROLE_GROUP, SYSTEM) |
|   conditions | List<AttributeConditionProtocol>| No | Condition attributes |
|   roleApplyPolicyCode | String| Yes | Whether the role is enabled ALLOW, DENY |
|   regDateTime | Date| Yes |  When the role was created |



###### AttributeConditionProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ----- | ------------ |
|   attributeDataTypeCode | String| Yes |  Conditional attribute data type (BOOLEAN, DATETIME, DAY_OF_WEEK, IPADDRESS, NUMERIC, STRING, TIME) |
|   attributeDescription | String| No | Condition attribute description |
|   attributeId | String| Yes | Condition attribute ID |
|   attributeName | String| Yes | Condition attribute name |
|   attributeOperatorTypeCode | String| Yes | Condition attribute operator<br>Available operators vary depending on the conditional attribute data type<br><ul><li>ALLOW</li><li>ALL_CONTAINS</li><li>ANY_CONTAINS</li><li>ANY_MATCH</li><li>BETWEEN</li><li>BEYOND</li><li>FALSE</li><li>GREATER_THAN</li><li>GREATER_THAN_OR_EQUAL_TO</li><li>LESS_THAN</li><li>LESS_THAN_OR_EQUAL_TO</li><li>NONE_MATCH</li><li>NOT_ALLOW</li><li>NOT_CONTAINS</li><li>TRUE</li></ul> |
|   attributeValues | List<String>| Yes| Condition attribute value |



<a id="조직-멤버-목록-조회"></a>
#### List organization members

> POST "/v1/organizations/{org-id}/members/search"

API to get a list of NHN Cloud members belonging to an organization.

##### Required permissions
`Organization.Member.List`

##### Request Parameter



| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | Organization ID | 
| Request Body | request | SearchOrgMembersRequest| Yes | Request |


###### SearchOrgMembersRequest


| Name | Type | Required | Description |   
|------------ | ------------- | --------- | ------------ |
|   memberStatusCodes | List<String>| No | Status of the member to look up<br><ul><li>STABLE: Invitation complete</li><li>INVITED: Invited</li><li>BLOCKED</li><li>NOT_EXIST</li><li>Withdraw</li></ul> |
|   roleIds | Set<String>| No  | Role IDs assigned to members |
|   paging | PagingBean| No  |

###### PagingBean


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   limit | Integer| No | Number of displays per page, default 20  |
|   page | Integer| No | Target Page, default 1  |




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
|   header | [Common response](#Response)| Yes |
|   orgMembers | List<OrgMemberWithInviteMemberrotocol>| Yes | Organization member list |
|   paging | PagingResponse| Yes | About the page |

###### OrgMemberWithInviteMemberProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ----- | ------------ |
|   email | String| Yes | The member's email address |
|   inviteStatusCode | String| No | Member's invitation status (COMPLETE, EXPIRE, UNKNOWN, WAIT) |
|   joinYmdt | Date| Yes | When you joined |
|   maskingEmail | String| Yes | Member's masked email  |
|   memberName | String| Yes| Member's name |
|   memberTypeCode | String| Yes| Member classification (TOAST_CLOUD: NHN Cloud member, IAM: IAM member) |
|   memberUuid | String| No| Member's UUID<br>Doesn't return a value if you're inviting |
|   recentLoginYmdt | Date| Yes| Last login date |
|   recentPasswordModifyYmdt | Date| No| Date of last password change |
|   secondFactorCertificationYn | String| No|  Whether to set up two-step sign-in (available to NHN Cloud members only) |

###### PagingResponse


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   limit | Integer| No | Number of displays per page, default 20  |
|   page | Integer| No | Target Page, default 1  |
|   totalCount | Long| Yes | Total number of cases  |




<a id="조직의-프로젝트-공통-역할-그룹-전체-조회"></a>
#### View all common role groups for projects in the organization

> GET "/v1/organizations/{org-id}/project-role-groups"

API to get a list of project common role groups set up by your organization.

##### Required permissions
`Organization.Project.RoleGroup.List`

##### Request Parameter



| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | Organization ID for the lookup | 
|  Query |descriptionLike | String| No | Description | 
|  Query |roleGroupNameLike | String| No | Role group name |
|  Query |limit | Integer| No | Number of displays per page, default 20 |
|  Query |page | Integer| No | Target Page, default 1 |






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
|   header | [Common response](#Response)| Yes  |
|   paging | [PagingResponse](#pagingresponse)| Yes  |
|   roleGroups | List<RoleGroupProtocol>| Yes | List of available role groups in your project  |


###### RoleGroupProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ----- | ------------ |
|   description | String| No | Role group descriptions |
|   regDateTime | Date| Yes | When the role group was created |
|   roleGroupId | String| Yes | Role group ID |
|   roleGroupName | String| Yes| Name of the role group |
|   roleGroupType | String| Yes | Types of role groups<br><ul><li>ORG: Project common role group</li><li>ORG_ROLE_GROUP: Organization role group</li><li>PROJECT: Project role group</li> |


<a id="상품-계층-구조-조회"></a>
#### View product hierarchy

> GET "/v1/product-uis/hierarchy"

API to return homepage category, homepage service information that is exposed on the bill.

##### Required Permissions
This API can be called without specific permissions if you are signed up to NHN Cloud.<br>
However, if you're viewing an organization's products, you must be a member of a project in that organization or a project under that organization.

##### Request Parameter



| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Query |productUiType | String| Yes | Product UI Types<br><ul><li>PROJECT: Project product</li><li>ORG: Organization Products</li><li>MARKET_PLACE: Marketplace products</li></ul> |
|  Query |orgId | String| No | Organization ID must be entered if the product UI type is ORG |




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
|   header | [Common response](#Response)| Yes |
|   productUiList | List<ProductUiHierarchyProtocol>| Yes  | Homepage Category Product UI List |

###### ProductUiHierarchyProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ----- | ------------ |
|   children | List<ProductUiHierarchyProtocol>| No | Homepage Service Product UI List |
|   manualLink | String| No|
|   parentProductUiId | String| No| Product UI divisions |
|   productId | String| No|
|   productUiId | String| No| Product UI identification key |
|   productUiName | String| No|


<a id="프로젝트에서-사용-중인-상품-조회"></a>
#### View a product used in the project

> GET "/v1/projects/{project-id}/products/{product-id}"

* APIs to get information about specific services used by your project

##### Required permissions
`Product Name: ProductAppKey.Get`

##### Request Parameter



| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | Project ID to look up |
|  Path |product-id | String| Yes | Service ID to look up |




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
|   header | [Common response](#Response)| Yes |
|   hasUpdateSecretKeyPermission | Boolean| Yes | Permission to reissue secret keys  |
|   product | ProjectProductRelationAndProductProtocol| Yes  | Returns information about the services being used by the project for the specified service ID, not including on error |


###### ProjectProductRelationAndProductProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   appKey | String| Yes | AppKey information for the service your project is using  |
|   externalId | String| No | Tenant ID<br>Only available if the tenant ID exists for the service |
|   productId | String| Yes | Service ID  |
|   productName | String| Yes | Product name  |
|   productSecretKeyCode | String| No | Whether to use a secret key<br>T: Enabled<br>Others: Not used (F, N) |
|   productStatusCode | String| Yes | Service status (STABLE, CLOSED) |
|   projectId | String| Yes | The project ID that uses the service  |
|   relationDate | Date| Yes | When you started using the service  |
|   secretKey | String| Yes | Service SecretKey<br>Only available on services that use secretKey  |
|   statusCode | String| Yes | The service's usage status (STABLE, CLOSED) |
|   updateDate | Date| No | Service last modified date  |
|   updateUuid | String| No | Service AppKey Modifier UUID  |


<a id="프로젝트-멤버-단건-조회"></a>
#### View a project member

> GET "/v1/projects/{project-id}/members/{member-uuid}"

API to get a specific member of a project.

##### Required permissions
`Project.Member.Get`

##### Request Parameter



| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | Project ID to look up members |
|  Path |member-uuid | String| Yes | Member UUID to look up |




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
|   header | [Common response](#Response)| Yes |
|   projectMember | ProjectMemberRoleBundleProtocol| Yes  | Added member information, not included on error |


###### ProjectMemberRoleBundleProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   emailAddress | String| No | Member email address  |
|   maskingEmail | String| No | Member's masked email  |
|   memberName | String| No | Member name  |
|   memberTypeCode | String| No | Member Distinction (IAM, TOAST_CLOUD) |
|   relationDateTime | Date| No | Time to add members  |
|   roles | List<RoleBundleProtocol>| No | List of related roles (with condition attributes)  |
|   statusCode | String| No | Invitation status codes (COMPLETE, EXPIRE, UNKNOWN, WAIT) |
|   UUID | String| No | Member UUID  |


[RoleBundleProtocol](#rolebundleprotocol)



<a id="프로젝트-멤버-목록-조회"></a>
#### List project members

> POST "/v1/projects/{project-id}/members/search"

API for getting a list of members belonging to a project.

##### Required permissions
`Project.Member.List`

##### Request Parameter


| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | Project ID to look up | 
| Request Body | request | SearchProjectMembersRequest| Yes | Request |



###### SearchProjectMembersRequest


| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   memberStatusCodes | List<String>| No | Project member status codes (INVITED, STABLE) |
|   roleIds | List<String>| No | List of role IDs  |
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
|   header | [Common response](#Response)| Yes |
|   paging | [PagingResponse](#pagingresponse)| Yes  |
|   projectMembers | List<ProjectMemberProtocol>| Yes | Project members  |



###### ProjectMemberProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   emailAddress | String| No | Member email address  |
|   maskingEmail | String| No | Member's masked email  |
|   memberName | String| No | Member name  |
|   memberTypeCode | String| No | Separate members |
|   relationDateTime | Date| No | Time to add members  |
|   statusCode | String| No | Invitation status codes (COMPLETE, EXPIRE, UNKNOWN, WAIT) |
|   UUID | String| No | Member UUID  |


<a id="프로젝트-역할-그룹-단건-조회"></a>
#### View a project role group

> GET "/v1/projects/{project-id}/project-role-groups/{role-group-id}"

API to get a project's role groups.

##### Required permissions
`Project.RoleGroup.Get`

##### Request Parameter



| In | Name | Type | Required | Description  | 
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
|   header | [Common response](#Response)| Yes |
|   roleGroup | RoleGroupBundleProtocol| Yes | Role groups with related roles  |

###### RoleGroupBundleProtocol

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   roleGroupId | String| No | Role group ID  |
|   roleGroupName | String| No | Role group name  |
|   description | String| No | Role group descriptions  |
|   roleGroupType | String| No | Role group distinction (organization, project)  |
|   roles | [List<RoleBundleProtocol>](#rolebundleprotocol)| No | List related roles  |
|   regDateTime | Date| No | Registered date and time  |



<a id="조직의-프로젝트-공통-역할-그룹-단건-조회"></a>
#### View a common role group for the project in the organization

> GET "/v1/organizations/{org-id}/project-role-groups/{role-group-id}"

API to get project common role groups.

##### Required permissions
`Organization.Project.RoleGroup.Get`

##### Request Parameter


| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | Organization ID for the lookup | 
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
|   header | [Common response](#Response)| Yes |
|   roleGroup | [RoleGroupBundleProtocol](#rolegroupbundleprotocol) | Yes | Role groups with related roles  |




<a id="프로젝트-역할-그룹-전체-조회"></a>
#### View all project role groups

> GET "/v1/projects/{project-id}/project-role-groups"

API to get all role groups in a project.

##### Required permissions
`Project.RoleGroup.List`

##### Request Parameter


| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | Project ID to look up | 
|  Query |descriptionLike | String| No | Description |
|  Query |roleGroupNameLike | String| No | Role group name |
|  Query |limit | Integer| No | Number of displays per page, default 20 |
|  Query |page | Integer| No | Target Page, default 1 |



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
|   header | [Common response](#Response)| Yes  |
|   paging | [PagingResponse](#pagingresponse)| Yes  |
|   roleGroups | List<[RoleGroupProtocol](#rolegroupprotocol)>| Yes | List of available role groups in your project  |

<a id="조직에-속한-프로젝트-목록-조회"></a>
#### List projects in your organization

> GET "/v1/organizations/{org-id}/projects"

API to get a list of projects in a STABLE state that belong to a specific organization.

##### Required permissions
Members of an organization

##### Request Parameter


| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | The ID of the organization to look up | 
|  Query |memberUuid | String| No | Organization member UUID |
|  Query |projectName | String| No | Project name |
|  Query |page | Integer| No | Target Page, default 1 |
|  Query |limit | Integer| No | Number of displays per page, default 20 |


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
|   header | [Common response](#Response)| Yes |
|   paging | [PagingResponse](#pagingresponse) | Yes |
|   projectList | List<OrgProjectMemberRoleProtocol>| Yes |



###### OrgProjectMemberRoleProtocol

| Name | Type | Required | Description |   
|------------ | ------------- | ----- | ------------ |
|   delDateTime | Date| No | Project deletion date |
|   description | String| No | Project description |
|   modDateTime | Date| No| Project modification date |
|   orgId | String| Yes| The organization ID the project belongs to |
|   projectId | String| Yes| Project ID |
|   projectName | String| Yes| Project name |
|   projectStatusCode | String| Yes | Project status<br><ul><li>STABLE: In normal use</li><li>CLOSED: The payment has been made and the project is well closed.</li><li>BLOCKED: Prohibited by administrator</li><li>TERMINATED: All resources have been deleted due to delinquency.</li><li>DISABLED: All products are closed but not paid for</li></ul> |
|   regDateTime | Date| Yes| Project registration date |


<a id="사용-중인-조직-거버넌스-목록-조회"></a>
#### List organization governance in use

> GET "/v1/organizations/{org-id}/governances"

API to get the active governance.

##### Required permissions
`Organization.Governance.List`

##### Request Parameter

| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | Organization ID for the lookup | 



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
|   header | [Common response](#Response)| Yes   |
|   usingGovernances | List<GovernanceProtocol>| No | List governance in use  |


###### GovernanceProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   governanceTypeCode | String| No | Governance type  |
|   regDatetime | Date| No | When to enable governance  |


<a id="조직의-프로젝트-공통-역할-그룹-생성"></a>
#### Create a common role group for projects in the organization

> POST "/v1/organizations/{org-id}/project-role-groups"

API to create project common role groups.


##### Required permissions
`Organization.Project.RoleGroup.Create`

##### Request Parameter

| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | Organization ID | 
| Request Body | request | CreateRoleGroupRequest| Yes | Request |

###### CreateRoleGroupRequest

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   description | String| No | Role group descriptions  |
|   roleGroupName | String| Yes | Role group name  |
|   roles | List<AssignRoleProtocol>| Yes | List roles to assign to a role group  |


###### AssignRoleProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   conditions | List<[AssignAttributeConditionProtocol](#assignattributeconditionprotocol)>| No | Role condition attribute  |
|   roleApplyPolicyCode | String| Yes | Whether the role is enabled ALLOW, DENY |
|   roleId | String| Yes | Role ID  |




##### Response Body

```json
{
  "header" : {
    "isSuccessful" : true,
    "resultCode" : 0,
    "resultMessage" : "resultMessage"
  }
}
```

###### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common response](#Response)| Yes   |


<a id="조직의-프로젝트-공통-역할-그룹-삭제"></a>
#### Delete a project common role group in the organization

> DELETE "/v1/organizations/{org-id}/project-role-groups"

API to delete a project common role group.

##### Required permissions
`Organization.Project.RoleGroup.Delete`

##### Request Parameter


| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | Organization ID | 
| Request Body | request | DeleteRoleGroupRequest| Yes | Request |


###### DeleteRoleGroupRequest


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   roleGroupIds | List<String>| Yes | List of role group IDs  |


##### Response Body

```json
{
  "header" : {
    "isSuccessful" : true,
    "resultCode" : 0,
    "resultMessage" : "resultMessage"
  }
}
```

###### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common response](#Response)| Yes   |

<a id="조직의-프로젝트-공통-역할-그룹-정보-수정"></a>
#### Modify your organization's project common role group information

> PUT "/v1/organizations/{org-id}/project-role-groups/{role-group-id}/infos"

API to modify the name and description of a project's common role group.

##### Required permissions
`Organization.Project.RoleGroup.Update`

##### Request Parameter


| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | Organization ID | 
|  Path |role-group-id | String| Yes | Role group ID | 
| Request Body | request | UpdateRoleGroupInfoRequest| Yes | Request |


###### UpdateRoleGroupInfoRequest


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   description | String| No | Role group descriptions  |
|   roleGroupName | String| Yes | Role group name  |



##### Response Body

```json
{
  "header" : {
    "isSuccessful" : true,
    "resultCode" : 0,
    "resultMessage" : "resultMessage"
  }
}
```

###### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common response](#Response)| Yes   |

<a id="조직의-프로젝트-공통-역할-그룹-역할-수정"></a>
#### Modify your organization's project common roles group roles

> PUT "/v1/organizations/{org-id}/project-role-groups/{role-group-id}/roles"

API to modify roles in the project common roles group.

##### Required permissions
`Organization.Project.RoleGroup.Update`

##### Request Parameter

| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | Organization ID | 
|  Path |role-group-id | String| Yes | Role group ID | 
| Request Body | request | UpdateRoleGroupRequest| Yes | Request |


###### UpdateRoleGroupRequest


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   roles | List<[AssignRoleProtocol](#assignroleprotocol)>| Yes | List roles to assign to a role group  |




##### Response Body

```json
{
  "header" : {
    "isSuccessful" : true,
    "resultCode" : 0,
    "resultMessage" : "resultMessage"
  }
}
```

###### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common response](#Response)| Yes   |

<a id="프로젝트-역할-그룹-생성"></a>
#### Create a project role group

> POST "/v1/projects/{project-id}/project-role-groups"

API to create role groups in your project.


##### Required permissions
`Project.RoleGroup.Create`

##### Request Parameter


| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | Project ID | 
| Request Body | request | [CreateRoleGroupRequest](#createrolegrouprequest)| Yes | Request |





##### Response Body

```json
{
  "header" : {
    "isSuccessful" : true,
    "resultCode" : 0,
    "resultMessage" : "resultMessage"
  }
}
```

###### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common response](#Response)| Yes   |

<a id="프로젝트-역할-그룹-삭제"></a>
#### Delete a project role group

> DELETE "/v1/projects/{project-id}/project-role-groups"

API to delete a project role group.


##### Required permissions
`Project.RoleGroup.Delete`

##### Request Parameter


| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | Project ID | 
| Request Body | request | [DeleteRoleGroupRequest](#deleterolegrouprequest)| Yes | Request |





##### Response Body

```json
{
  "header" : {
    "isSuccessful" : true,
    "resultCode" : 0,
    "resultMessage" : "resultMessage"
  }
}
```

###### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common response](#Response)| Yes   |

<a id="프로젝트-역할-그룹-정보-수정"></a>
#### Edit project role group information

> PUT "/v1/projects/{project-id}/project-role-groups/{role-group-id}/infos"

API to modify the name and description of a project role group.

##### Required permissions
`Project.RoleGroup.Update`

##### Request Parameter

| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | Project ID | 
|  Path |role-group-id | String| Yes | Role group ID | 
| Request Body | request |[UpdateRoleGroupInfoRequest](#updaterolegroupinforequest)| Yes | Request |





##### Response Body

```json
{
  "header" : {
    "isSuccessful" : true,
    "resultCode" : 0,
    "resultMessage" : "resultMessage"
  }
}
```

###### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common response](#Response)| Yes   |


<a id="프로젝트-역할-그룹-역할-수정"></a>
#### Modify project role group roles

> PUT "/v1/projects/{project-id}/project-role-groups/{role-group-id}/roles"

API to modify roles in the project role group.

##### Required permissions
`Project.RoleGroup.Update`

##### Request Parameter

| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | Project ID | 
|  Path |role-group-id | String| Yes | Role group ID | 
| Request Body | request | UpdateRoleGroupRequest| Yes | Request |

###### UpdateRoleGroupRequest


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   roles | List<[AssignRoleProtocol](#assignroleprotocol)>| Yes | List roles to assign to a role group  |





##### Response Body

```json
{
  "header" : {
    "isSuccessful" : true,
    "resultCode" : 0,
    "resultMessage" : "resultMessage"
  }
}
```

###### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common response](#Response)| Yes   |

<a id="조직-멤버-역할-변경"></a>
#### Change organization member roles

> PUT "/v1/organizations/{org-id}/members/{member-uuid}"

API to modify the roles of members who belong to this organization.


##### Required permissions
`Organization.Member.Update`


##### Request Parameter


| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | Organization ID | 
|  Path |member-uuid | String| Yes | UUID of the member to modify | 
| Request Body | request | UpdateMemberRoleRequest| Yes | Request |


###### UpdateMemberRoleRequest


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   assignRoles | List<[UserAssignRoleProtocol](#userassignroleprotocol)>| Yes | List of roles to assign to users  |





##### Response Body

```json
{
  "header" : {
    "isSuccessful" : true,
    "resultCode" : 0,
    "resultMessage" : "resultMessage"
  }
}
```

###### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common response](#Response)| Yes   |

<a id="프로젝트-멤버-역할-수정"></a>
#### Modify project member roles

> PUT "/v1/projects/{project-id}/members/{member-uuid}"

API to change the role of a specified member in a project.

##### Required permissions
`Project.Member.Update`

##### Request Parameter

| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | Project ID | 
|  Path |member-uuid | String| Yes | Member UUID to change role to | 
| Request Body | request | [UpdateMemberRoleRequest](#updatememberrolerequest)| Yes | Request |




##### Response Body

```json
{
  "header" : {
    "isSuccessful" : true,
    "resultCode" : 0,
    "resultMessage" : "resultMessage"
  }
}
```

###### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common response](#Response)| Yes   |

<a id="조직-IAM-멤버-단건-조회"></a>
#### View organization IAM members

> GET "/v1/iam/organizations/{org-id}/members/{member-uuid}"

API to get the IAM members in your organization.

##### Required permissions
`Organization.Member.Iam.Get`


##### Request Parameter

| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | Organization ID to look up | 
|  Path |member-uuid | String| Yes | The IAM member UUID of the organization to look up | 


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
|   header | [Common response](#Response)| Yes   |
|   orgMember | OrgIamMemberRoleBundleProtocol| No  |

###### OrgIamMemberRoleBundleProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ----- | ------------ |
|   corporate | String| No |
|   country | String| No |
|   createdAt | Date| No |
|   creationType | String| No| Member's creation type |
|   department | String| No|
|   emailAddress | String| Yes | IAM member email address  |
|   englishName | String| No|
|   id | String| Yes | IAM member UUID  |
|   idProviderId | String| No|
|   idProviderType | String| No| service: IAM direct sign-in<br>SSO: Customer SSO integration |
|   idProviderUserId | String| No|
|   lastAccessedAt | Date| No| The member's last access date, returning null if not present |
|   lastLoggedInAt | Date| No| The member's last login date, returning null if not found |
|   lastLoggedInIp | String| No| The member's last login IP address, returning null if not present |
|   maskingEmail | String| No | Masked email addresses for IAM members  |
|   mobilePhone | String| No | IAM member's cell phone number  |
|   mobilePhoneCountryCode | String| No|
|   name | String| Yes | Name of the IAM member  |
|   nativeName | String| No|
|   nickname | String| No|
|   officeHoursBegin | String| No|
|   officeHoursEnd | String| No|
|   organizationId | String| Yes | Organization ID of the IAM member  |
|   passwordChangedAt | Date| No| When the member's last password was changed, returning null if none |
|   position | String| No|
|   profileImageUrl | String| No|
|   roles | [List<RoleBundleProtocol>](#rolebundleprotocol)| No | List of related roles (with condition attributes)  |
|   saasRoles | List<IamMemberRole>| No | IAM member roles  |
|   String | String| No| Member's status |
|   telephone | String| No | IAM member's phone number  |
|   userCode | String| Yes | IAM member ID  |



###### IamMemberRole


| Name | Type | Required | Description |   
|------------ | ------------- | ------- | ------------ |
|   productId | String| No |
|   productName | String| No |
|   String | String| No |


<a id="조직-IAM-멤버-목록-조회"></a>
#### List organization IAM members

> GET "/v1/iam/organizations/{org-id}/members"

API to get a list of IAM members that belong to this organization.

##### Required permissions
`Organization.Member.Iam.List`

##### Request Parameter

| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | Organization ID | 
|  Query |email | String| No | IAM member's email address |
|  Query |emailLike | String| No |  |
|  Query |idProviderType | String| No | service: IAM direct sign-in<br>SSO: Customer SSO integration |
|  Query |nameLike | String| No |  |
|  Query |statuses | List<String>| No |  |
|  Query |userCode | String| No | IAM member ID |
|  Query |userCodeLike | String| No |  |
|  Query |limit | Integer| No | Number of displays per page, default 20 |
|  Query |page | Integer| No | Target Page, default 1 |

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
    "saasRoles": [ {
      "role": "role",
      "productId": "productId",
      "productName": "productName"
    } ],
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
|   header | [Common response](#Response)| Yes   |
|   orgMembers | List<IamOrgMemberProtocol>| No | Organization IAM member list  |
|   paging | [PagingResponse](#pagingresponse)| No  |

###### IamOrgMemberProtocol

| Name | Type | Required | Description |   
|------------ | ------------- | --------- | ------------ |
| header | [Common response](#Response)| Yes | Required only if protocol is in response |
| id | String | No | IAM member UUID | 
| userCode | String | Yes | IAM member ID to use for sign-in | 
| name | String | Yes | Username of the IAM member | 
| emailAddress | String |  Yes | IAM member's email address<br>Used to receive notifications or to change your password. |
| maskingEmail | String | No | Masked email addresses for IAM members |
| mobilePhone | String | No | IAM member's cell phone number |
| telephone | String | No | IAM member phone number |
| position | String | No |  |
| department | String | No |  |
| corporate | String | No |  |
| profileImageUrl | String | No |  |
| englishName | String | No |  |
| nativeName | String | No |  |
| nickname | String | No |  |
| officeHoursBegin | String | No |  |
| officeHoursEnd | String | No |  |
| String | String | Yes | Member status can be changed<br><ul><li>member: in good standing</li><li>leaved: Request to leave</li></ul>Must specify member at creation time |
| creationType | String | No |  |
| idProviderId | String | No |  |
| idProviderType | String | No | service: IAM direct sign-in (default)<br>SSO: Customer SSO integration (cannot be set up if not integrated) |
| idProviderUserId | String | No |  |
| createdAt | Date | No | Date and time of creation |
| lastAccessedAt | Date | No | Date of last access |
| lastLoggedInAt | Date | No | Date of last login |
| lastLoggedInIp | String | No | Last logged in IP |
| passwordChangedAt | Date | No | When to change your password |
| mobilePhoneCountryCode | String | No | Required when entering a mobile phone number  |
| organizationId | String | No | Organization ID of the IAM member |
| country | String | No |  |
| saasRoles | List<[IamMemberRole](#iammemberrole)> | No | IAM roles |





<a id="조직-IAM-멤버-추가"></a>
#### Add an organization IAM member

> POST "/v1/iam/organizations/{org-id}/members"

API to add IAM members to your organization.

##### Required permissions
`Organization.Member.Iam.Create`


##### Request Parameter

| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | Organization ID | 
| Request Body | request | AddIamOrgMemberRequest| Yes | Request |

###### AddIamOrgMemberRequest


| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   member | [IamOrgMemberProtocol](#iamorgmemberprotocol)| Yes   |




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
|   header | [Common response](#Response)| Yes   |
|   UUID | String| No | IAM member UUID  |




<a id="IAM-멤버-비밀번호-변경-이메일-전송"></a>
#### Send an IAM member password change email

> POST "/v1/iam/organizations/{org-id}/members/{member-id}/send-password-setup-mail"

API to send an email to an IAM member to change their password.

##### Required permissions
`Organization.Member.Iam.Update`


##### Request Parameter

| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | Target organization ID | 
|  Path |member-id | String| Yes | UUID of the IAM member whose password you want to change | 
| Request Body | request | SendPasswordSetupMailRequest| Yes | Request |



###### SendPasswordSetupMailRequest


| Name | Type | Required | Description |   
|------------ | ------------- | --------- | ------------ |
|   locale | String| Yes  | User's locale information<br>Example: en |
|   returnUrl | String| Yes  | The address of the page you'll be directed to after you change your password via email change notification.<br>You must enter the toast.com, dooray.com, or nhncloud.com domain in the Go To address information |


##### Response Body

```json
{
  "header" : {
    "isSuccessful" : true,
    "resultCode" : 0,
    "resultMessage" : "resultMessage"
  }
}
```

###### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common response](#Response)| Yes   |

<a id="조직-IAM-멤버-정보-수정"></a>
#### Modify organization IAM member information

> PUT "/v1/iam/organizations/{org-id}/members/{member-uuid}"

API to modify your organization's IAM member information.

##### Required permissions
`Organization.Member.Iam.Update`

##### Request Parameter

| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 	Target organization ID | 
|  Path |member-uuid | String| Yes | UUID of the IAM member you want to change | 
| Request Body | request | UpdateIamMemberRequest| Yes | Request |


###### UpdateIamMemberRequest


| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   member | [IamOrgMemberProtocol](#iamorgmemberprotocol)| Yes   |



##### Response Body

```json
{
  "header" : {
    "isSuccessful" : true,
    "resultCode" : 0,
    "resultMessage" : "resultMessage"
  }
}
```

###### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common response](#Response)| Yes   |

<a id="조직-IAM-멤버-비밀번호-변경"></a>
#### Change an organization IAM member password

> POST "/v1/iam/organizations/{org-id}/members/{member-id}/set-password"

API to change the password of an organization IAM member.

##### Required permissions
`Organization.Member.Iam.Update`

##### Request Parameter

| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | Target organization ID | 
|  Path |member-id | String| Yes | UUID of the IAM member whose password you want to change | 
| Request Body | request | UpdateIamPasswordRequest| Yes | Request |


###### UpdateIamPasswordRequest


| Name | Type | Required | Description |   
|------------ | ------------- | --------- | ------------ |
|   password | String| Yes  | Password to set | 


##### Response Body

```json
{
  "header" : {
    "isSuccessful" : true,
    "resultCode" : 0,
    "resultMessage" : "resultMessage"
  }
}
```

###### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common response](#Response)| Yes   |

<a id="조직-IP-ACL-목록-조회"></a>
#### Listorganization IP ACLs

> GET "/v1/organizations/{org-id}/products/ip-acl"

API to get IP ACL settings.

##### Required permissions
`Organization.Governance.IpAcl.List`

##### Request Parameter

| In | Name | Type | Required | Description  | 
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
|   header | [Common response](#Response)| Yes   |
|   orgIpAcl | List<OrgIpAclProtocol>| Yes  | If the result is an empty list, the setting is not set. |

###### OrgIpAclProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | --------- | ------------ |
|   ips | List<String>| Yes  | Allowed IPs | 
|   productId | String| Yes  | Product ID<br>If undefined, set to Common Settings|

<a id="조직-IAM-로그인-세션-설정-정보를-조회"></a>
#### View organization IAM sign-in session settings information

> GET "/v1/iam/organizations/{org-id}/settings/session"

API to get login session settings information.

##### Required permissions
`Organization.Setting.Iam.Get`

##### Request Parameter

| In | Name | Type | Required | Description  | 
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
| header | [Common response](#Response)| Yes   |
| result | Content | Yes | Setup contents |

###### Content

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   multiSessionsLimit | Integer| Yes | Number of multisessions allowed  |
|   sessionTimeoutMinutes | Integer| Yes | 	Session timeouts |
|   mobileSessionTimeoutMinutes | Integer| Yes | 	Mobile session timeout |
|   sessionType | String| Yes | fixed/idle. The default is fixed  |

<a id="조직-IAM-로그인-2차-인증에-대한-설정을-조회"></a>
#### View settings for organizational IAM sign-in second factor authentication

> GET "/v1/iam/organizations/{org-id}/settings/security-mfa"

API to get settings for login two-factor authentication.

##### Required permissions
`Organization.Setting.Iam.Get`

##### Request Parameter


| In | Name | Type | Required | Description  | 
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
|   header | [Common response](#Response)| Yes   |
|   result | Result| No |  Response content<br>If never set, null is returned |

###### Result
| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   range | Integer| No | Organization/Service status<br>organization (common settings), services (service-specific settings)  |
|   organizationMfaSetting | OrganizationMfaSetting| No | About organizational MFA settings<br>Common Settings |
|   serviceMfaSettings | ServiceMfaSettings| No | About service-specific MFA settings  |


###### OrganizationMfaSetting

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   String | String| No | MFA type<br>none (no setting), totp (Google OTP), email (email) |
|   bypassByIp | BypassByIp| No | Exception IP  |

###### ServiceMfaSettings


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   serviceId | Sting| No | Service ID  |
|   String | String| No | MFA type<br>none (no setting), totp (Google OTP), email (email) |
|   bypassByIp | BypassByIp| No | Service type. none, totp, email |

###### BypassByIp

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   String | Boolean| No | Activated or not<br>true (enabled), false (disabled)  |
|   ipList | List<String>| No | List of exception IPs |

<a id="조직-IAM-로그인-실패-보안-설정을-조회"></a>
#### View Organization IAM Login Failure Security Settings

> GET "/v1/iam/organizations/{org-id}/settings/security-login-fail"

API to get login failure security settings.

##### Required permissions
`Organization.Setting.Iam.Get`

##### Request Parameter

| In | Name | Type | Required | Description  | 
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
| header | [Common response](#Response)| Yes   |
| result | Result | No | Returned only if login failure security is set, otherwise null is returned |

###### Result

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   String | Boolean| Yes | Activated or not<br>true (enabled), false (disabled)  |
|   loginFailCount | LoginFailCount| No | Setting up login failure security |


###### LoginFailCount

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   limit | Integer| No | Number of attempts allowed |
|   blockMinutes | Integer| No | Login ban time  |

<a id="조직-IAM-계정-비밀번호-정책-조회"></a>
#### Get your organization's IAM account password policy

> GET "/v1/iam/organizations/{org-id}/settings/password-rule"

API to get settings for password policies.

##### Required permissions
`Organization.Setting.Iam.Get`

##### Request Parameter

| In | Name | Type | Required | Description  | 
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
| header | [Common response](#응답)| Yes   |
| result | Content | Yes | Setup contents |

###### Content

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
| schemaVersion | Integer| Yes | Schema version  |
| value | Value| Yes |  Password policy |

###### Value

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
| ruleType | String | Yes | Password policy<br>default (default password policy), custom (user password policy) |
| passwordConstraints | PasswordConstraints | Yes | Password strength |
| passwordExpiry | PasswordExpiry | Yes | Password expiration |
| limitPasswordReuse | LimitPasswordReuse | Yes | Limit password reuse |
| applyRule | String | Yes | When to enforce password policies<br>onChangePassword (applies when password changes), onLogin (applies immediately) |

###### PasswordConstraints

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
| minLength | integer | Yes | Password minimum length |
| mustNotIncludeIllegalSequence | boolean | Yes | At least one alphanumeric character<br>true (set), false (not set) |
| mustIncludeUpperCase | boolean | Yes | At least one uppercase letter<br>true (set), false (not set) |
| mustIncludeLowerCase | boolean | Yes | At least one lowercase letter<br>true (set), false (not set) |
| mustIncludeNumberCase | boolean | Yes | At least one number<br>true (set), false (not set) |
| mustIncludeSpecialCase | boolean | Yes | One or more special characters<br>true (set), false (not set) |

###### PasswordExpiry

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
| String | Boolean | Yes | Enabled or not<br>true (set), false (not set) |
| expiryDays | Integer | Yes | Expiration period |
| allowExpend | Boolean | Yes | Extendable on expiration<br>true (possible), false (impossible) |

###### LimitPasswordReuse

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
| String | Boolean | Yes | Enabled or not<br>true (set), false (not set) |
| limitCount | Integer | Yes | Number of reuse limits |

<a id="종량제에-등록된-상품-가격-조회"></a>
#### Get the price of a product on a pay-as-you-go subscription

> POST "/v1/billing/contracts/basic/products/prices/search"

API to get the unit price set on a counter.
For each language, you can get the impression name and type for calculating the amount.


##### Required permissions
APIs that can be called if you have signed up to NHN Cloud

##### Request Parameter

| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Query |limit | Integer| No |  |
| Request Body | request | GetContractProductPriceRequest| Yes | Request |

##### GetContractProductPriceRequest
| Name | Type | Required | Description |   
|------------ | ------------- | --------- | ------------ |
|  counterNames | List<String>| No | List of counter names in the product meta<br>Full search box if not found |
|   paging | Paging| No  |

###### Paging

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   limit | Integer| No | Number of displays per page, default 20  |
|   page | Integer| No | Target Page, default 1  |


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
|   header | [Common response](#Response)| Yes   |
|   paging | PagingResponse| Yes | Return paging results with no sorting criteria  |
|   prices | List<ContractProductPriceProtocol>| Yes | Returns unit price information from counters as an array<br>Not included on error  |

###### PagingResponse

| Name | Type | Required | Description |   
|------------ | ------------- | ------- | ------------ |
|   limit | Integer| Yes | Limit the number of views<br>Default value is 1. |
|   page | Integer| Yes |
|   totalCount | Integer| Yes |

###### ContractProductPriceProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   contractDiscountPolicyId | String| Yes | Commitment Rate Policy ID  |
|   contractId | String| Yes | Commitment ID  |
|   counterName | String| Yes | Counters  |
|   displayNameEn | String| No | 	English name of the counter  |
|   displayNameJa | String| No | Japanese name of the counter  |
|   displayNameKo | String| Yes | Korean name of the counter  |
|   displayNameZh | String| No | 	Chinese name of the counter<br>Currently exposed in English |
|   monthFrom | String| Yes | The start month for which unit price information is valid (inclusive)  |
|   monthTo | String| Yes | Ending month for which unit price information is valid (not included)  |
|   originalPrice | BigDecimal| Yes | Unit price  |
|   price | BigDecimal| Yes | Unit price  |
|   rangeFrom | BigDecimal| Yes | Start of usage range that falls under unit price (not included)  |
|   rangeTo | BigDecimal| Yes | Ending usage ranges that fall under unit pricing (inclusive)  |
|   seq | Long| Yes | Serial number  |
|   slidingCalculationTypeCode | String| Yes | Types of sliding fee calculations<br>NONE, SECTION_SUM, SECTION_SELECTED |
|   useFixPriceYn | String| Yes | Fixed amount or not (Y: Fixed amount , N: Unit price calculation)<br>Y: price becomes an amount if it falls in the range<br>N: (Usage x Unit Price) becomes an amount |

<a id="종량제에-등록된-상품-목록-조회"></a>
#### List products enrolled in a pay-as-you-go subscription

> GET "/v1/billing/contracts/basic/products"

API that provides a list of the main categories and subcategories exposed in the bill, and the counters they contain.

##### Required permissions
APIs that can be called if you have signed up to NHN Cloud

##### Request Parameter

| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Query |limit | Integer| No | Limit the number of views<br>Default value is 1. |
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
|   header | [Common response](#Response)| Yes   |
|   paging | [PagingResponse](#pagingresponse)| Yes  |
|   products | List<ProductMetadata>| Yes | Product meta information list  |


###### ProductMetadata


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   budgetUsageTypeYn | String| No | Budget Usage Type Yn Y, N |
|   calcUnitCode | String| Yes | Units to use when calculating amounts (converts metering units to settlement units to calculate amounts), units to expose on statements<br>KB, MB, GB, TB, SECONDS, MINUTE, HOURS, DAYS, MB_HOURS, GB_SECONDS, GB_HOURS, GB_DAYS, CORE_SECONDS, CORE_HOURS, CORE_DAYS, USERS, MAU, MAD, DAU, CALLS, COUNTS, CCU, VCPU_HOURS, COUNT_HOURS |
|   categoryMain | String| Yes | Main Categories  |
|   categorySub | String| Yes | Subcategories  |
|   chargingTypeId | String| Yes | Billing type ID  |
|   convertUsageTypeCode | String| Yes | Usage conversion type codes NONE, HOUR_AVERAGE, DAY_AVERAGE |
|   counterName | String| Yes | Counters  |
|   counterTypeCode | String| Yes | Methods for summing usage<br><ul><li>DELTA: Incremental value (HOURLY_SUM)</li><li>GAUGE: Sum of hourly maximums (to be changed to HOURLY_MAX)</li><li>HOURLY_LATEST: The sum of the latest metering data collected in a one-hour period.</li><li>DAILY_MAX: Sum of daily maximums</li><li>MONTHLY_MAX: Monthly maximum</li><li>STATUS: Usage status</li><ul> |
|   description | String| No | Counter descriptions  |
|   displayOrder | Integer| Yes | Exposure order  |
|   marketPlaceMandatoryUsePeriod | Integer| No | Marketplace mandatory usage period  |
|   meterUnitCode | String| Yes | Usage units when storing metering in a service<br>BYTES, KB, MB, GB, TB, CORE, HOURS, MINUTE, USERS, MAU, MAD, DAU, CALLS, COUNTS, CCU, SECONDS |
|   minUsage | BigDecimal| Yes | Minimum usage  |
|   parentCounterName | String| Yes | Parent counter name  |
|   productId | String| Yes | Product ID  |
|   productMetadataStatusCode | String| Yes | Counter status codes STABLE, CLOSED |
|   productUiId | String| Yes | Homepage Category/Homepage Service Identification ID  |
|   regionTypeCode | String| Yes | The region code the countername belongs to<br><ul><li>GLOBAL: Countername belonging to the Global product</li><li>NONE: Same meaning as GLOBAL</li><li>KR1: Countername belonging to the KR1 region</li><li>KR2: Countername belonging to the KR2 region</li><li>If you are not sure which region you are in, you can use the following...: Counternames that belong to this region</li><ul>  |
|   unit | Long| Yes | Settlement units  |
|   unitName | String| Yes | Name to appear on the invoice  |
|   usageAggregationUnitCode | String| No | Usage aggregation units<br>RESOURCE_ID, COUNTER_NAME |


<a id="프로젝트-AppKey-조회"></a>
#### Get Project AppKey

> GET "/v1/authentications/projects/{project-id}/project-appkeys"

API to get a list of project AppKeys being used by the project.

##### Required permissions
`Project.ProjectAppKey.List`

##### Request Parameter

| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | Project ID to look up | 


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
|   header | [Common response](#Response)| Yes |
|   authenticationList | List<ProjectAppKeyResponse>| No | Project AppKey List |

###### ProjectAppKeyResponse

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   authId | String| No | Internally managed authentication method ID  |
|   appKey | String| No | Project AppKey exposed to the console  |
|   authStatus | String| No | Authentication status codes (STABLE, STOP, BLOCKED) |
|   projectId | String| No | Project ID |
|   lastUsedDatetime | Date| No | Date of last use  |
|   modDatetime | Date| No | Date and time of deletion  |
|   reIssueDatetime | Date| No | Regeneration time  |
|   regDatetime | Date| No | Date and time of creation  |

<a id="User-Access-Key-ID-목록-조회"></a>
#### ListUser Access Key IDs

> GET "/v1/authentications/user-access-keys"

API to get a list of a member's User Access Key IDs.

##### Required permissions
APIs that can be called if you have signed up to NHN Cloud


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
|   header | [Common response](#Response)| Yes   |
|   authentications | List<UserAccessKeyResponse>| No | List credentials  |

###### UserAccessKeyResponse

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   authId | String| No | Internally managed authentication method ID  |
|   userAccessKeyID | String| No | User Access Key ID  |
|   secretAccessKey | String| No | Secret key (masked)  |
|   authStatus | String| No | Authentication status codes (STABLE, STOP, BLOCKED) |
|   UUID | String| No | User UUID |
|   lastUsedDatetime | Date| No | Date of last use you authenticated with User Access Key ID  |
|   modDatetime | Date| No | Date and time of deletion  |
|   reIssueDatetime | Date| No | Regeneration time  |
|   regDatetime | Date| No | Date and time of creation  |
|   tokenExpiryPeriod | Long| No | Token expiration cycle (in seconds)  |
|   lastTokenUsedDatetime | Long| No | Last time you authenticated/authorized with a token              |
|   validTokenCount | Long| No | Number of valid tokens                      |


<a id="프로젝트-AppKey-등록"></a>
#### Register a project AppKey

> POST "/v1/authentications/projects/{project-id}/project-appkeys"

API to generate an AppKey for use in your project.

##### Required permissions
`Project.ProjectAppKey.Create`


##### Request Parameter

| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
| Path | project-id | String| Yes | The project ID where you want to register the AppKey |
| Request Body | request | AddProjectAppKeyRequest| Yes | Request |

###### AddProjectAppKeyRequest

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   appkeyAlias | String | Yes   | Project AppKey aliases<br>100-character limit |


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
|   header | [Common response](#Response)| Yes   |
|   authentication | ResponseProtocol| No  |

###### ResponseProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ----- | ------------ |
|   authId | String| No | Internally managed authentication method ID  |
|   appKey | String| No | Project AppKey |

<a id="User-Access-Key-ID-등록"></a>
#### Register a User Access Key ID

> POST "/v1/authentications/user-access-keys"

API to register a member's User Access Key ID.

##### Required permissions
APIs that can be called if you have signed up to NHN Cloud

##### Request Parameter

| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
| Request Body | PostUserAppKeyRequest | PostUserAppKeyRequest| Yes |  | |


###### PostUserAppKeyRequest

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   tokenExpiryPeriod | Long| No | Token expiration period<br>seconds, with a default of |


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
    "tokenExpiryPeriod": 0
  }
}
```

###### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common response](#Response)| Yes   |
|   authentication | ResponseProtocol| No  |

###### ResponseProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ----- | ------------ |
|   authId | String| No | Internally managed authentication method ID  |
|   userAccessKeyID | String| No | User Access Key ID  |
|   secretAccessKey | String| No | Secret key |
|   tokenExpiryPeriod | Long| No | Token expiration period (in seconds) |


<a id="프로젝트-AppKey-삭제"></a>
#### Delete a project AppKey

> DELETE "/v1/authentications/projects/{project-id}/project-appkeys/{app-key}"

API to delete a project AppKey.

##### Required permissions
`Project.ProjectAppKey.Delete`


##### Request Parameter


| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
| Path | project-id | String| Yes | Target project ID |
|  Path |app-key | String| Yes | Project AppKey to delete | 


##### Response Body

```json
{
  "header" : {
    "isSuccessful" : true,
    "resultCode" : 0,
    "resultMessage" : "resultMessage"
  }
}
```
###### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common response](#Response)| Yes   |


<a id="User-Access-Key-ID-비밀-키-재발급"></a>
#### Reissue the User Access Key ID secret key

> PUT "/v1/authentications/user-access-keys/{user-access-key-id}/secretkey-reissue"

API to reissue the secret key for a User Access Key ID.


### Required Permissions
Can only reissue the secret key for the user's own User Access Key ID

##### Request Parameter

| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |user-access-key-id | String| Yes | User Access Key ID | 
| Request Body | request | ReissueSecretKeyRequest| Yes | Request |


###### ReissueSecretKeyRequest

| Name | Type | Required | Description  |                                               |   
|------------ |---------|----|---------------------------------------------------|
|   needExpireTokens | Boolean | No | Issued token expired or not(true: Expired, false: Not expired)<br>Default false |

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
|   header | [Common response](#Response)| Yes |
|   authentication | ResponseProtocol| No  |

###### ResponseProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   secretAccessKey | String| Yes   | Secret key |

<a id="User-Access-Key-ID-상태-수정"></a>
#### Modify User Access Key ID status

> PUT "/v1/authentications/user-access-keys/{user-access-key-id}"

API to change the state of a member's User Access Key ID.

### Required Permissions
Can only modify the user's own User Access Key ID

##### Request Parameter


| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path | user-access-key-id | String| Yes | User Acess Key ID | 
| Request Body | request | UpdateUserAccessKeyStatusRequest| Yes | Request |


###### UpdateUserAccessKeyStatusRequest

| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   String | String| Yes | Project AppKey state to change (STOP: Stop, STABLE: Enable) |


##### Response Body

```json
{
  "header" : {
    "isSuccessful" : true,
    "resultCode" : 0,
    "resultMessage" : "resultMessage"
  }
}
```

###### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common response](#Response)| Yes   |

<a id="User-Access-Key-ID-삭제"></a>
#### Delete a User Access Key ID

> DELETE "/v1/authentications/user-access-keys/{user-access-key-id}"

API to delete a User Access Key ID.

##### Required permissions
Can only delete the user's own User Access Key ID

##### Request Parameter

| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path | user-access-key-id | String| Yes | User Access Key ID | 


##### Response Body

```json
{
  "header" : {
    "isSuccessful" : true,
    "resultCode" : 0,
    "resultMessage" : "resultMessage"
  }
}
```

###### Response


| Name | Type | Required | Description |   
|------------ | ------------- | ------- | ------------ |
|   header | [Common response](#응답)| Yes |


<a id="토큰-목록-조회"></a>
#### Get a List of Tokens

> GET "/v1/authentications/user-access-keys/{user-access-key-id}/tokens"

API to get a list of tokens issued with a User Access Key ID.

##### Required Permissions
Only tokens issued with your own User Access Key ID can be viewed

##### Request Parameters

| In | Name | Type | Required  | Description                                                                           | 
|------------- |------------- | ------------- |-----|------------------------------------------------------------------------------| 
|  Path | user-access-key-id | String| Yes | User Access Key ID                                                           | 
|  Query | token | String| No  | Token body<br>Partial search not supported                                                        | 
|  Query | String | String| No  | Token status<br>ACTIVE: Active, EXPIRED: Expired                                             | 
|  Query | lastAccessDatetimeFrom | Date| No  | Date of last token use<br>Get  tokens used at a time greater than or equal to the specified time<br>Example: `2025-02-11T00:56:50.902Z` | 
|  Query | expireDatetimeFrom | Date| No  | Token expiration date<br>Get  tokens expired at a time greater than or equal to the specified time<br>Example: `2025-02-11T00:56:50.902Z`   | 
|  Query | regDatetimeFrom | Date| No  | Token registration date<br>Get  tokens created at a time greater than or equal to the specified time<br>Example: `2025-02-11T00:56:50.902Z`   |
|  Query | page | Integer| No  | Target page<br>Default 1                                                                |
|  Query | limit | Integer| No  | Items per page<br>Default 20                                                            |



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
|   header | [Common response](#응답) | Yes |
|   paging | [PagingResponse](#pagingresponse)| Yes  |
|   accessToken | String       | Yes | Masked token         |
|   expireDatetime | Date         | No  | Token expiration date             |
|   lastAccessDatetime | Date         | Yes | Last time you authenticated/authorized with a token |
|   regDatetime | Date         | Yes | Token creation date           |
|   String | String       | Yes | Token status              |
|   tokenId | Long         | Yes | Token ID              |


<a id="토큰-다건-만료"></a>
#### Expire multiple tokens

> DELETE "/v1/authentications/user-access-keys/{user-access-key-id}/tokens"

API to expire multiple tokens issued with a User Access Key ID.<br>
If both the token ID and token list are empty in the request, all tokens issued to that User Access Key ID will expire.<br>
If you have both a token ID and a list of tokens, only tokens that match both are deleted,<br>
Tokens do not expire when invoked by a user other than the owner of the User Access Key ID in the request.

##### Required Permissions
Only tokens issued with your own User Access Key ID can expire

##### Request Parameters

| In           | Name                 | Type              | Required  | Description                 | 
|--------------|--------------------|-----------------|-----|--------------------| 
| Path         | user-access-key-id | String          | Yes | User Access Key ID | 
| Request Body | tokenIds           | List<Long>   | No  | List of token IDs           | 
| Request Body         | tokens             | List<String> | No   | List of tokens          | 

##### Response Body

```json
{
  "header" : {
    "isSuccessful" : true,
    "resultCode" : 0,
    "resultMessage" : "resultMessage"
  }
}
```

###### Response


| Name | Type | Required | Description |   
|------------ | ------------- | ------- | ------------ |
|   header | [Common response](#Response)| Yes |


<a id="프로젝트-IAM-계정-생성"></a>
#### Create a project IAM account

> POST "/v1/iam/projects/{project-id}/members"

API to add an IAM account as a project member.

##### Required permissions
`Project.Member.Iam.Create`

##### Request Parameter



| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | The project ID to which you want to add the member | 
| Request Body | request | AddIamProjectMemberRequest| Yes | Request |




###### AddIamProjectMemberRequest
> [Caution]<br>
> Only one project member can be created in a request.


| Name | Type | Required | Description |  
|------------ | ------------- | ------------- | ------------ |
|   assignRoles | List<UserAssignRoleProtocol>| Yes | List of roles to assign to users  |
|   memberUuid | String| Yes | UUID of the member to add  |


###### UserAssignRoleProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   roleId | String| Yes | Role ID  |
|   conditions | List<AssignAttributeConditionProtocol>| No | Role condition attribute  |


###### AssignAttributeConditionProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   attributeId | String| Yes | Condition attribute ID  |
|   attributeOperatorTypeCode | String| Yes | Condition attribute operator<br>Available operators vary depending on the conditional attribute data type<br><ul><li>ALLOW</li><li>ALL_CONTAINS</li><li>ANY_CONTAINS</li><li>ANY_MATCH</li><li>BETWEEN</li><li>BEYOND</li><li>FALSE</li><li>GREATER_THAN</li><li>GREATER_THAN_OR_EQUAL_TO</li><li>LESS_THAN</li><li>LESS_THAN_OR_EQUAL_TO</li><li>NONE_MATCH</li><li>NOT_ALLOW</li><li>NOT_CONTAINS</li><li>TRUE</li></ul>  |
|   attributeValues | List<String>| Yes | Condition attribute value  |


##### Response Body

```json
{
  "header" : {
    "isSuccessful" : true,
    "resultCode" : 0,
    "resultMessage" : "resultMessage"
  }
}
```

###### Response


| Name | Type           | Required | Description |   
|------------ |--------------| ------- | ------------ |
|   header | [Common response](#응답) | Yes |


<a id="프로젝트-IAM-계정-다건-삭제"></a>
#### Delete multiple project IAM accounts

> DELETE "/v1/iam/projects/{project-id}/members"

API to delete IAM accounts from a project.

##### Required permissions
`Project.Member.Iam.Delete`

##### Request Parameter



| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | Project ID | 
|  Request Body |request | DeleteMembersRequest | Yes | Request | 


###### DeleteMembersRequest


| Name | Type | Required | Description |  
|------------ | ------------- | ------------- | ------------ |
|   memberUuids | List<String>| Yes | List of UUIDs of the target accounts to delete |


##### Response Body

```json
{
  "header" : {
    "isSuccessful" : true,
    "resultCode" : 0,
    "resultMessage" : "resultMessage"
  }
}
```

###### Response


| Name | Type | Required | Description |   
|------------ | ------------- | ------- | ------------ |
|   header | [Common response](#응답)| Yes |


<a id="프로젝트-IAM-계정-단건-조회"></a>
#### View a project IAM account

> GET "/v1/iam/projects/{project-id}/members/{member-uuid}"

API to get a specific IAM account who is part of a project.

##### Required permissions
`Project.Member.Iam.Get`

##### Request Parameter



| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | Project ID to look up members |
|  Path |member-uuid | String| Yes | Member UUID to look up |




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
|   header | [Common response](#응답)| Yes |
|   projectMember | ProjectIamMemberRoleBundleProtocol| Yes  | Added member information, not included on error |


###### ProjectMemberRoleBundleProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   UUID | String| Yes | Member UUID  |
|   id | String| Yes | ID  |
|   name | String| No | Name  |
|   emailAddress | String| No | Member email address  |
|   maskingEmail | String| No | Member's masked email  |
|   mobilePhone | String| No | Phone number  |
|   relationDateTime | Date| No | Time to add members  |
|   joinYmdt | Date| No | Date to joined  |
|   recentLoginYmdt | Date| No | Date of last login  |
|   recentPasswordModifyYmdt | Date| No | Date of last password change  |
|   roles | List<RoleBundleProtocol>| No | List of related roles (with condition attributes)  |


[RoleBundleProtocol](#rolebundleprotocol)



<a id="프로젝트-IAM-계정-목록-조회"></a>
#### View project IAM accounts

> GET "/v1/iam/projects/{project-id}/members"

API to get a list of IAM accounts who are part of a project.

##### Required permissions
`Project.Member.Iam.List`

##### Request Parameter


| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | Project ID to look up | 
|  Query |limit | Integer| No | Number of displays per page, default 20 |
|  Query |page | Integer| No | Target Page, default 1 |





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
|   header | [Common response](#응답)| Yes |
|   paging | [PagingResponse](#pagingresponse)| Yes  |
|   projectMembers | List<IamProjectMemberProtocol>| Yes | Project member list  |



###### IamProjectMemberProtocol


| Name | Type | Required | Description |   
|------------ | ------------- | ------------- | ------------ |
|   UUID | String| Yes | Member UUID  |
|   id | String| Yes | ID  |
|   name | String| No | Name  |
|   emailAddress | String| No | Member email address  |
|   maskingEmail | String| No | Member's masked email  |
|   mobilePhone | String| No | Phone number  |
|   relationDateTime | Date| No | Time to add members  |
|   joinYmdt | Date| No | Date to joined  |
|   recentLoginYmdt | Date| No | Date of last login  |
|   recentPasswordModifyYmdt | Date| No | Date of last password change  |


<a id="프로젝트-IAM-계정-역할-수정"></a>
#### Modify project IAM account roles

> PUT "/v1/iam/projects/{project-id}/members/{member-uuid}"

API to change the role of a specified IAM account in a project.

##### Required permissions
`Project.Member.Iam.Update`

##### Request Parameter

| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | Project ID | 
|  Path |member-uuid | String| Yes | Member UUID to change role to | 
| Request Body | request | [UpdateMemberRoleRequest](#updatememberrolerequest)| Yes | Request |




##### Response Body

```json
{
  "header" : {
    "isSuccessful" : true,
    "resultCode" : 0,
    "resultMessage" : "resultMessage"
  }
}
```

###### Response

| Name | Type | Required | Description |   
|------------ | ------------- | ----------- | ------------ |
|   header | [Common response](#응답)| Yes   |


<a id="조직-하위-멤버의-모든-인증정보-리스트-조회"></a>
#### View all credentials of members under organizations

> GET "/v1/authentications/organizations/{org-id}/user-access-keys"

API to get the credentials of members in the organization or project.

##### Required permissions
`Organization.UserAccessKey.List`

##### Request Parameter



| In | Name | Type | Required | Description  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | Organization ID to look up the UserAccessKey for |
|  Query |paging | Paging| No | Number of displays per page, default 20 |




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
|   header | [Common response](#응답)| Yes |
|   paging | [PagingResponse](#pagingresponse)| Yes  |
|   authenticationList | List<UserAccessKeyResponseV7>| Yes  | Member-specific authentication key information |


###### UserAccessKeyResponseV7

| Name | Type | Required | Description |
|------------|--------|------|-----------------------------|
| authId | String | Yes | Authentication Method ID (masked) |
| UUID | String | Yes | User UUID |
| userAccessKeyID | String | Yes | User Access Key ID (masked) |
| secretAccessKey | String | No | Secret key (whitespace) |
| authStatusCode | String | Yes | Authentication status codes (STABLE, STOP, BLOCKED) |
| tokenExpiryPeriod | Long | No | Token expiration cycle |
| regDatetime | Date | No | Date and time of creation |
| modDatetime | Date | No | Date and time of deletion |
| lastUsedDatetime | Date | No | Date of last use |
| reIssueDatetime | Date | No | secretAccessKey regeneration timeout |
| lastTokenUsedDatetime | Date | No | Date of last token use |
| validTokenCount | Long | No | Number of valid tokens |






### Error Code

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
| 30015 | Error when exceeding the limit on the number of generated project AppKeys <br> Project AppKey API - The number of project AppKeys generated `by Generate Project AppKey`is 3, and an error occurs if more than 3 are generated. | Delete an unused project AppKey and retry                               |
| 40017 | Errors that occur when a project doesn't exist                                                           | Make an API request for an existing project                                   |
| 40028<br>13003 | Errors that occur when a project doesn't exist (created and then deleted)                                              | Make an API request for an existing project                                   |
| 40054 | Error when activating a service, if a service that should be activated first is not activated                               | Handle activating services that need to be activated first                               |
| 40057 | When disabling a service, an error occurs if a service that should be disabled first is not disabled                            | Handle disabling services that should be disabled first                              |
| 50007 | Invalid members, errors that occur<br>(Members that don't exist, are dormant, or are withdrawn are not valid)<br>Organization creation API - When making API calls, if the uuid is invalid | Modify with the UUID of a valid member                                 |
| 60003 | Errors that occur when there is no data in the DB<br>Error when there are no AppKeys to delete in Project `AppKey` API - `Delete Project AppKeys`  | 1) Contact a representative <br>2) Set the existing AppKey to the value of the AppKey to be deleted  |
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