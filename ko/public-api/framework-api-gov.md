## NHN Cloud > Public API > 프레임워크 API

### 개요
다음에서 소개하는 API를 통해 프로젝트 멤버를 생성하거나 역할을 부여하는 등 조직과 프로젝트를 관리할 수 있습니다.
API 사용을 위해서는 [API 호출 및 인증](https://docs.gov-nhncloud.com/ko/nhncloud/ko/public-api/api-authentication)을 통해 발급받은 Bearer 타입의 토큰이 필요합니다.
API 호출 시, API 인증을 받은 멤버의 권한을 검사합니다.

### Public API 도메인
`https://core.api.gov-nhncloudservice.com/`

### 공통

#### 요청
Public API를 호출할 때는 아래 Request Header를 반드시 포함해야 합니다.


| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
| Header |  x-nhn-authorization | String| Yes | 사용자가 발급받은 Bearer 타입 토큰 |


#### 응답
Public API 반환 시 아래 헤더 부분이 응답 본문에 포함됩니다.
```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------------- | ------------ |
|   isSuccessful | Boolean | No | 성공 여부  |
|   resultCode | Integer| No | 결과 코드. 성공 시 0이 반환되며, 실패 시 오류 코드 반환  |
|   resultMessage | String| No | 결과 메시지  |

#### 공통 타입


| 이름 | 타입 | 크기 | 설명 | 
|------------ | ------------- | ------------- | ------------ |
| org-id | String | 16자 | 조직 ID |
| project-id | String | 8자 | 프로젝트 ID |
| product-id | String | 8자 | 서비스(상품) ID |
| user-access-key-id | String | 20자 | User Access Key ID |
| project-app-key | String | 20자 | 프로젝트의 AppKey |
| product-app-key | String | 16자 | 서비스의 AppKey |
| uuid | String | 36자 | 멤버의 UUID |


#### 거버넌스 IP ACL 설정

**조직 관리 > 거버넌스 설정 > 조직 거버넌스 설정 > IP ACL 설정**을 통해 IP ACL을 설정했을 경우, 프레임워크 API 호출 시에도 해당 설정이 적용됩니다.


### API

> 주의<br>
> API의 응답은 가이드에 명시되지 않은 필드가 추가될 수 있으므로, 새로운 필드가 추가되어도 오류가 발생하지 않도록 개발해야 합니다.<br>
> 또한 DB 저장 시, 칼럼 사이즈가 변경될 수 있으므로 여유 있게 설정해야 합니다.

| 메서드 | HTTP 요청 | 설명 |
|------------- | ------------- | -------------|
| POST |[/v1/projects/{project-id}/members](#프로젝트-멤버-생성) | 프로젝트 멤버 생성 |
| POST |[/v1/organizations/{org-id}/projects](#프로젝트-추가) | 프로젝트 추가 |
| DELETE |[/v1/projects/{project-id}/members/{target-uuid}](#프로젝트-멤버-단건-삭제) | 프로젝트 멤버 단건 삭제 |
| DELETE |[/v1/projects/{project-id}](#프로젝트-삭제) | 프로젝트 삭제 |
| DELETE |[/v1/projects/{project-id}/products/{product-id}/disable](#프로젝트-상품-종료) | 프로젝트 상품 종료 |
| POST |[/v1/projects/{project-id}/products/{product-id}/enable](#프로젝트-상품-이용) | 프로젝트 상품 이용 |
| GET |[/v1/organizations/{org-id}/roles](#조직-역할-목록-조회) | 조직 역할 목록 조회 |
| GET |[/v1/projects/{project-id}/roles](#프로젝트-역할-목록-조회) | 프로젝트 역할 목록 조회 |
| GET |[/v1/organizations/{org-id}/domains](#조직-도메인-검색) | 조직 도메인 검색 |
| GET |[/v1/organizations/{org-id}/members/{member-uuid}](#조직-멤버-단건-조회) | 조직 멤버 단건 조회 |
| POST |[/v1/organizations/{org-id}/members/search](#조직-멤버-목록-조회) | 조직 멤버 목록 조회 |
| GET |[/v1/organizations/{org-id}/project-role-groups](#조직의-프로젝트-공통-역할-그룹-전체-조회) | 조직의 프로젝트 공통 역할 그룹 전체 조회 |
| GET |[/v1/product-uis/hierarchy](#상품-계층-구조-조회) | 상품 계층 구조 조회 |
| GET |[/v1/projects/{project-id}/products/{product-id}](#프로젝트-사용-중인-상품-조회) | 프로젝트 사용 중인 상품 조회 |
| GET |[/v1/projects/{project-id}/members/{member-uuid}](#프로젝트-멤버-단건-조회) | 프로젝트 멤버 단건 조회 |
| POST |[/v1/projects/{project-id}/members/search](#프로젝트-멤버-목록-조회) | 프로젝트 멤버 목록 조회 |
| GET |[/v1/projects/{project-id}/project-role-groups/{role-group-id}](#프로젝트-역할-그룹-단건-조회) | 프로젝트 역할 그룹 단건 조회 |
| GET |[/v1/organizations/{org-id}/project-role-groups/{role-group-id}](#조직의-프로젝트-공통-역할-그룹-단건-조회) | 조직의 프로젝트 공통 역할 그룹 단건 조회 |
| GET |[/v1/projects/{project-id}/project-role-groups](#프로젝트-역할-그룹-전체-조회) | 프로젝트 역할 그룹 전체 조회 |
| GET |[/v1/organizations/{org-id}/projects](#조직에-속한-프로젝트-목록-조회) | 조직에 속한 프로젝트 목록 조회 |
| GET |[/v1/organizations/{org-id}/governances](#사용-중인-조직-거버넌스-목록-조회) | 사용 중인 조직 거버넌스 목록 조회 |
| POST |[/v1/organizations/{org-id}/project-role-groups](#조직의-프로젝트-공통-역할-그룹-생성) | 조직의 프로젝트 공통 역할 그룹 생성 |
| DELETE |[/v1/organizations/{org-id}/project-role-groups](#조직의-프로젝트-공통-역할-그룹-삭제) | 조직의 프로젝트 공통 역할 그룹 삭제 |
| PUT |[/v1/organizations/{org-id}/project-role-groups/{role-group-id}/infos](#조직의-프로젝트-공통-역할-그룹-정보-수정) | 조직의 프로젝트 공통 역할 그룹 정보 수정 |
| PUT |[/v1/organizations/{org-id}/project-role-groups/{role-group-id}/roles](#조직의-프로젝트-공통-역할-그룹-역할-수정) | 조직의 프로젝트 공통 역할 그룹 역할 수정 |
| POST |[/v1/projects/{project-id}/project-role-groups](#프로젝트-역할-그룹-생성) | 프로젝트 역할 그룹 생성 |
| DELETE |[/v1/projects/{project-id}/project-role-groups](#프로젝트-역할-그룹-삭제) | 프로젝트 역할 그룹 삭제 |
| PUT |[/v1/projects/{project-id}/project-role-groups/{role-group-id}/infos](#프로젝트-역할-그룹-정보-수정) | 프로젝트 역할 그룹 정보 수정 |
| PUT |[/v1/projects/{project-id}/project-role-groups/{role-group-id}/roles](#프로젝트-역할-그룹-역할-수정) | 프로젝트 역할 그룹 역할 수정 |
| PUT |[/v1/organizations/{org-id}/members/{member-uuid}](#조직-멤버-역할-수정) | 조직 멤버 역할 수정 |
| PUT |[/v1/projects/{project-id}/members/{member-uuid}](#프로젝트-멤버-역할-수정) | 프로젝트 멤버 역할 수정 |
| GET |[/v1/iam/organizations/{org-id}/members/{member-uuid}](#조직-iam-멤버-단건-조회) | 조직 IAM 멤버 단건 조회 |
| GET |[/v1/iam/organizations/{org-id}/members](#조직-iam-멤버-목록-조회) | 조직 IAM 멤버 목록 조회 |
| POST |[/v1/iam/organizations/{org-id}/members](#조직-iam-멤버-추가) | 조직 IAM 멤버 추가 |
| POST |[/v1/iam/organizations/{org-id}/members/{member-id}/send-password-setup-mail](#iam-멤버-비밀번호-변경-이메일-전송) | IAM 멤버 비밀번호 변경 이메일 전송 |
| PUT |[/v1/iam/organizations/{org-id}/members/{member-uuid}](#조직-iam-멤버-정보-수정) | 조직 IAM 멤버 정보 수정 |
| POST |[/v1/iam/organizations/{org-id}/members/{member-id}/set-password](#조직-iam-멤버-비밀번호-변경) | 조직 IAM 멤버 비밀번호 변경 |
| GET |[/v1/iam/organizations/{org-id}/settings/session](#조직-iam-로그인-세션-설정-정보를-조회) | 조직 IAM 로그인 세션 설정 정보를 조회 |
| GET |[/v1/iam/organizations/{org-id}/settings/security-mfa](#조직-iam-로그인-2차-인증에-대한-설정을-조회) | 조직 IAM 로그인 2차 인증에 대한 설정을 조회 |
| GET |[/v1/iam/organizations/{org-id}/settings/security-login-fail](#조직-iam-로그인-실패-보안-설정을-조회) | 조직 IAM 로그인 실패 보안 설정을 조회 |
| GET |[/v1/organizations/{org-id}/products/ip-acl](#조직-ip-acl-목록-조회) | 조직 IP ACL 목록 조회 |
| POST |[/v1/billing/contracts/basic/products/prices/search](#종량제에-등록된-상품-가격-조회) | 종량제에 등록된 상품 가격 조회 |
| GET |[/v1/billing/contracts/basic/products](#종량제에-등록된-상품-목록-조회) | 종량제에 등록된 상품 목록 조회 |
| GET |[/v1/authentications/projects/{project-id}/project-appkeys](#프로젝트-appkey-조회) | 프로젝트 AppKey 조회 |
| GET |[/v1/authentications/user-access-keys](#user-access-key-id-목록-조회) | User Access Key ID 목록 조회 |
| POST |[/v1/authentications/projects/{project-id}/project-appkeys](#프로젝트-appkey-등록) | 프로젝트 AppKey 등록 |
| POST |[/v1/authentications/user-access-keys](#user-access-key-id-등록) | User Access Key ID 등록 |
| DELETE |[/v1/authentications/projects/{project-id}/project-appkeys/{app-key}](#프로젝트-appkey-삭제) | 프로젝트 AppKey 삭제 |
| PUT |[/v1/authentications/user-access-keys/{user-access-key-id}/secretkey-reissue](#user-access-key-id-비밀-키-재발급) | User Access Key ID 비밀 키 재발급 |
| PUT |[/v1/authentications/user-access-keys/{user-access-key-id}](#user-access-key-id-상태-수정) | User Access Key ID 상태 수정 |
| DELETE |[/v1/authentications/user-access-keys/{user-access-key-id}](#user-access-key-id-삭제) | User Access Key ID 삭제 |




#### 프로젝트 멤버 생성
> POST "/v1/projects/{project-id}/members"

프로젝트에 멤버를 추가하는 API입니다.

##### 필요 권한
`Project.Member.Create`

##### 요청 파라미터



| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | 멤버를 추가할 프로젝트 ID | 
| Request Body | request | CreateMemberRequest| Yes | 요청 |




###### CreateMemberRequest
> 주의<br>
> 요청 시 memberUuid, email, userCode 중 하나는 반드시 값이 있어야 합니다.<br>
> memberUuid > email > userCode 순으로 값이 있는지 체크하고 있으면 해당 멤버를 프로젝트 멤버로 추가합니다.<br>
> 한 요청에 한 명의 프로젝트 멤버만 만들 수 있습니다.


| 이름 | 타입 | 필수 | 설명 |  
|------------ | ------------- | ------------- | ------------ |
|   assignRoles | List&lt;UserAssignRoleProtocol>| Yes | 사용자에게 할당할 역할 목록  |
|   memberUuid | String| No | 추가할 멤버의 UUID  |
|   email | String| No | 추가할 멤버의 이메일  |
|   userCode | String| No | 추가할 IAM 멤버 ID  |


###### UserAssignRoleProtocol


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------------- | ------------ |
|   roleId | String| Yes | 역할 ID  |
|   conditions | List&lt;AssignAttributeConditionProtocol>| No | 역할 조건 속성  |


###### AssignAttributeConditionProtocol


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------------- | ------------ |
|   attributeId | String| Yes | 조건 속성 ID  |
|   attributeOperatorTypeCode | String| Yes | 조건 속성 연산자<br>조건 속성 데이터 타입에 따라 사용할 수 있는 연산자가 다름<br><ul><li>ALLOW</li><li>ALL_CONTAINS</li><li>ANY_CONTAINS</li><li>ANY_MATCH</li><li>BETWEEN</li><li>BEYOND</li><li>FALSE</li><li>GREATER_THAN</li><li>GREATER_THAN_OR_EQUAL_TO</li><li>LESS_THAN</li><li>LESS_THAN_OR_EQUAL_TO</li><li>NONE_MATCH</li><li>NOT_ALLOW</li><li>NOT_CONTAINS</li><li>TRUE</li></ul>  |
|   attributeValues | List&lt;String>| Yes | 조건 속성 값  |


##### 응답 본문

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### 응답


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------- | ------------ |
|   header | [공통 응답](#response)| Yes |



#### 프로젝트 추가
> POST "/v1/organizations/{org-id}/projects"

조직에 프로젝트를 추가하는 API입니다.

##### 필요 권한
`Organization.Project.Create`

##### 요청 파라미터



| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
| Path |org-id | String| Yes | 프로젝트를 추가할 조직 ID | 
| Request Body | request | CreateProjectRequest| Yes | 요청 |


###### CreateProjectRequest


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------ | ------------ |
|   description | String| No | 프로젝트 설명(최대 100자) |
|   projectName | String| Yes| 프로젝트 이름(최대 40자) |


##### 응답 본문

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
###### 응답

| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | --------- | ------------ |
|   header | [공통 Response](#response)| Yes  |
|   regDateTime | Date| Yes   | 프로젝트 생성 일시 | 
|   description | String| No   | 프로젝트 설명 | 
|   ownerId | String| Yes   | 프로젝트 소유자 멤버 ID | 
|   projectName | String| Yes   | 프로젝트 이름 | 
|   projectId | String| Yes   | 프로젝트 ID | 
|   orgId | String| Yes   | 조직 ID | 
|   projectStatusCode | String| Yes   | 프로젝트 상태<br><ul><li>STABLE: 정상적으로 사용 중인 상태</li><li>CLOSED: 지불이 완료되어 프로젝트가 잘 닫힌 상태</li><li>BLOCKED: 관리자에 의해 사용이 금지된 상태</li><li>TERMINATED: 연체로 인해 모든 리소스가 삭제된 상태</li><li>DISABLED: 모든 상품이 닫힌 상태지만 값이 지불되지 않은 상태</li></ul> | 



#### 프로젝트 멤버 단건 삭제
> DELETE "/v1/projects/{project-id}/members/{target-uuid}"

사용자를 해당 프로젝트에서 삭제하는 API입니다.

##### 필요 권한
`Project.Member.Delete`

##### 요청 파라미터



| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | 프로젝트 ID | 
|  Path |target-uuid | String| Yes | 삭제 대상 멤버 UUID | 




##### 응답 본문

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### 응답


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------- | ------------ |
|   header | [공통 응답](#response)| Yes |




#### 프로젝트 삭제
> DELETE "/v1/projects/{project-id}"

프로젝트를 삭제하는 API입니다.

##### 필요 권한
아래 목록 중 하나의 권한이 필요합니다.
* `Organization.Project.Delete`
* `Project.Delete`

##### 요청 파라미터



| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | 삭제할 프로젝트 ID | 






##### 응답 본문

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### 응답


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------- | ------------ |
|   header | [공통 응답](#response)| Yes |




#### 프로젝트 상품 종료
> DELETE "/v1/projects/{project-id}/products/{product-id}/disable"

해당 프로젝트에서 사용자가 지정한 서비스를 더 이상 이용하지 않도록 비활성화하는 API입니다.

##### 필요 권한
`상품명:Product.Delete`

##### 요청 파라미터


| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | 서비스를 종료하려는 프로젝트 ID | 
|  Path |product-id | String| Yes | 서비스 ID | 





##### 응답 본문

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

###### 응답


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------- | ------------ |
|   header | [공통 응답](#response)| Yes |
|   childProducts | List&lt;ChildProduct>| No   | 해당 서비스의 하위 서비스 정보로, 하위 서비스가 없으면 포함하지 않음.<br>하위 서비스를 먼저 비활성화하고 해당 서비스를 비활성화해야 함.|

###### ChildProduct


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | --------- | ------------ |
|   productId | String| Yes  | 	하위 서비스 ID | 
|   productName | String| Yes  | 하위 서비스 이름 |
|   statusCode | String| Yes |   서비스 상태(STABLE, CLOSED) |



#### 프로젝트 상품 이용
> POST "/v1/projects/{project-id}/products/{product-id}/enable"

해당 프로젝트에서 사용자가 지정한 서비스를 이용할 수 있도록 활성화 요청하는 API입니다.

##### 필요 권한
`상품명:Product.Create`

##### 요청 파라미터



| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |product-id | String| Yes | 서비스 ID | 
|  Path |project-id | String| Yes | 서비스를 이용하려는 프로젝트 ID | 


##### 응답 본문

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

###### 응답


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------- | ------------ |
|   header | [공통 응답](#response)| Yes |
|   appKey | String| Yes | 해당 프로젝트에서 이용 중인 서비스의 AppKey 정보|
|   parentProduct | ParentProduct| No | 상위 서비스 정보가 있으면 해당 정보를 표시하며, 상위 서비스가 없으면 포함하지 않음 |
|   secretKey | String| No| 해당 프로젝트에서 이용 중인 서비스에 대한 비밀 키 정보<br> 비밀 키를 이용하는 서비스에서만 제공 |


###### ParentProduct


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | --------- | ------------ |
|   productId | String| Yes  | 서비스 ID |
|   productName | String| Yes  | 서비스 이름 |
|   statusCode | String| Yes | 서비스 상태(STABLE, CLOSED) |






#### 조직 역할 목록 조회
> GET "/v1/organizations/{org-id}/roles"

조직 사용자에게 부여할 수 있는 역할 목록을 요청하는 API입니다.

##### 필요 권한
`Organization.RoleGroup.List`

##### 요청 파라미터



| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 조직 ID |
|  Query |categoryTypeCodes | List&lt;String> | No | 역할/권한/역할 그룹 카테고리 구분(ROLE, PERMISSION, ROLE_GROUP) |
|  Query |roleNameLike | String| No | 역할/권한/역할 그룹명 |
|  Query |limit | Integer| No | 페이지당 표시 건수, 기본값 20 | 
|  Query |page | Integer| No | 대상 페이지, 기본값 1 |



##### 응답 본문

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



###### 응답


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------- | ------------ |
|   header | [공통 응답](#response)| Yes |
|   roles | List&lt;RoleProtocol>| Yes  | 역할 목록 |
|   totalCount | Integer| Yes  | 총 개수 |

###### RoleProtocol


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------------- | ------------ |
|   categoryKey | String| Yes | 역할/권한 카테고리 분류 키<br><ul><li>RoleGroup: 프로젝트 역할 그룹</li><li>OrgRoleGroup: 조직 역할 그룹</li><li>OrgRole: 조직 역할</li><li>ProjectRole: 프로젝트 역할</li><li>BillingRole: Billing 관련 역할</li><li>OrgServiceRole: 조직 서비스 역할</li><li>ProjectServiceRole: 프로젝트 서비스 역할</li><li>SystemRole: 시스템 생성 역할</li></ul>  |
|   categoryTypeCode | String| Yes | 역할 그룹/역할/권한 구분 코드(ORG_ROLE_GROUP, PERMISSION, ROLE, ROLE_GROUP, SYSTEM) |
|   description | String| Yes | 역할/권한 설명  |
|   roleCategory | String| Yes | 역할/권한 카테고리 대분류(ORG_ROLE, ORG_ROLE_GROUP, ORG_SERVICE_ROLE, PROJECT_ROLE, PROJECT_ROLE_GROUP, PROJECT_SERVICE_ROLE, SYSTEM_ROLE) |
|   roleId | String| Yes | 역할/권한 ID  |
|   roleName | String| Yes | 역할/권한 이름  |



#### 프로젝트 역할 목록 조회
> GET "/v1/projects/{project-id}/roles"

프로젝트 사용자에게 부여할 수 있는 역할 목록을 요청하는 API입니다.

##### 필요 권한
`Project.RoleGroup.List`

##### 요청 파라미터


| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | 프로젝트 ID | 
|  Query |categoryTypeCodes | List&lt;String> | No | 역할/권한/역할 그룹 카테고리 구분(ROLE, PERMISSION, ROLE_GROUP) |
|  Query |roleNameLike | String| No | 역할/권한/역할 그룹명 |
|  Query |limit | Integer| No | 페이지당 표시 건수, 기본값 20 | 
|  Query |page | Integer| No | 대상 페이지, 기본값 1 |


##### 응답 본문

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


###### 응답


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------- | ------------ |
|   header | [공통 응답](#response)| Yes |
|   roles | List&lt;[RoleProtocol](#roleprotocol)>| Yes  | 역할 목록 |
|   totalCount | Integer| Yes  | 총 개수 |


#### 조직 도메인 검색
> GET "/v1/organizations/{org-id}/domains"

특정 조직의 도메인을 조회하는 API입니다.

##### 필요 권한
`Organization.Domain.List`

##### 요청 파라미터



| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 조회할 조직의 ID | 




##### 응답 본문

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

###### 응답


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------- | ------------ |
|   header | [공통 응답](#response)| Yes |
|   domainList | List&lt;OrgDomainProtocol>| Yes  |


###### OrgDomainProtocol


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | --------- | ------------ |
|   orgDomainId | String| Yes | 조직 도메인 ID |
|   orgDomainName | String| Yes | 조직 도메인 이름 |



#### 조직 멤버 단건 조회
> GET "/v1/organizations/{org-id}/members/{member-uuid}"

조직에 소속된 멤버를 조회하는 API입니다.

##### 필요 권한
`Organization.Member.Get`

##### 요청 파라미터



| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 멤버를 조회할 조직 ID | 
|  Path |member-uuid | String| Yes | 	조회할 멤버 UUID | 





##### 응답 본문

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

###### 응답


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------- | ------------ |
|   header | [공통 응답](#response)| Yes |
|   orgMember | OrgMemberRoleBundleProtocol| No  | 추가된 멤버 정보, 오류 시 포함되지 않음 |

###### OrgMemberRoleBundleProtocol


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ----- | ------------ |
|   email | String| Yes | 멤버 이메일 |
|   id | String| No | 멤버 ID(IAM 멤버만 제공) |
|   inviteStatusCode | String| Yes |   COMPLETE, EXPIRE, UNKNOWN, WAIT |
|   joinYmdt | Date| Yes | 조직 멤버 등록 일시 |
|   memberName | String| Yes| 	멤버 이름 |
|   memberTypeCode | String| Yes| 멤버 구분(TOAST_CLOUD: NHN Cloud 멤버, IAM: IAM 멤버) |
|   memberUuid | String| Yes| 멤버의 UUID |
|   recentLoginYmdt | Date| Yes| 마지막 로그인 일시 |
|   recentPasswordModifyYmdt | Date| No| 마지막 비밀번호 변경 일시 |
|   roleCode | String| No| 역할 ID |
|   roles | List&lt;RoleBundleProtocol>| No | 연관 역할 목록(조건 속성 포함)  |
|   secondFactorCertificationYn | String| No| 2단계 로그인 설정 여부(NHN Cloud 멤버만 제공) |


###### RoleBundleProtocol
| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ----- | ------------ |
|   roleId | String| Yes |  역할 ID |
|   roleName | String| Yes |  역할 이름 |
|   description | String| No |  역할 설명 |
|   categoryKey | String| Yes | 역할/권한 카테고리 분류 키<br><ul><li>RoleGroup: 프로젝트 역할 그룹</li><li>OrgRoleGroup: 조직 역할 그룹</li><li>OrgRole: 조직 역할</li><li>ProjectRole: 프로젝트 역할</li><li>BillingRole: Billing 관련 역할</li><li>OrgServiceRole: 조직 서비스 역할</li><li>ProjectServiceRole: 프로젝트 서비스 역할</li><li>SystemRole: 시스템 생성 역할</li></ul>  |
|   categoryTypeCode | String| Yes | 역할 그룹/역할/권한 구분 코드(ORG_ROLE_GROUP, PERMISSION, ROLE, ROLE_GROUP, SYSTEM) |
|   conditions | List&lt;AttributeConditionProtocol>| No | 조건 속성 목록 |
|   roleApplyPolicyCode | String| Yes | 역할 사용 여부  ALLOW, DENY |
|   regDateTime | Date| Yes |  역할 생성 일시 |



###### AttributeConditionProtocol


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ----- | ------------ |
|   attributeDataTypeCode | String| Yes |  조건 속성 데이터 타입(BOOLEAN, DATETIME, DAY_OF_WEEK, IPADDRESS, NUMERIC, STRING, TIME) |
|   attributeDescription | String| No | 조건 속성 설명 |
|   attributeId | String| Yes | 조건 속성 ID |
|   attributeName | String| Yes | 조건 속성 이름 |
|   attributeOperatorTypeCode | String| Yes | 조건 속성 연산자<br>조건 속성 데이터 타입에 따라 사용할 수 있는 연산자가 다름<br><ul><li>ALLOW</li><li>ALL_CONTAINS</li><li>ANY_CONTAINS</li><li>ANY_MATCH</li><li>BETWEEN</li><li>BEYOND</li><li>FALSE</li><li>GREATER_THAN</li><li>GREATER_THAN_OR_EQUAL_TO</li><li>LESS_THAN</li><li>LESS_THAN_OR_EQUAL_TO</li><li>NONE_MATCH</li><li>NOT_ALLOW</li><li>NOT_CONTAINS</li><li>TRUE</li></ul> |
|   attributeValues | List&lt;String>| Yes| 조건 속성 값 |




#### 조직 멤버 목록 조회
> POST "/v1/organizations/{org-id}/members/search"

해당 조직에 소속된 NHN Cloud 멤버 목록을 조회하는 API입니다.

##### 필요 권한
`Organization.Member.List`

##### 요청 파라미터



| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 조직 ID | 
| Request Body | request | SearchOrgMembersRequest| Yes | 요청 |


###### SearchOrgMembersRequest


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | --------- | ------------ |
|   memberStatusCodes | List&lt;String>| No | 조회할 멤버의 상태<br><ul><li>STABLE: 초대 완료</li><li>INVITED: 초대 중</li><li>BLOCKED</li><li>NOT_EXIST</li><li>WITHDRAW</li></ul> |
|   roleIds | Set&lt;String>| No  | 멤버들이 부여받은 역할 ID들 |
|   paging | PagingBean| No  |

###### PagingBean


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------------- | ------------ |
|   limit | Integer| No | 페이지당 표시 건수, 기본값 20  |
|   page | Integer| No | 대상 페이지, 기본값 1  |




##### 응답 본문

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
###### 응답


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------- | ------------ |
|   header | [공통 응답](#response)| Yes |
|   orgMembers | List&lt;OrgMemberWithInviteMemberrotocol>| Yes | 조직 멤버 목록 |
|   paging | PagingResponse| Yes | 페이지 정보 |

###### OrgMemberWithInviteMemberProtocol


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ----- | ------------ |
|   email | String| Yes | 멤버의 이메일 주소 |
|   inviteStatusCode | String| No | 멤버의 초대 상태(COMPLETE, EXPIRE, UNKNOWN, WAIT) |
|   joinYmdt | Date| Yes | 멤버 가입 일시 |
|   maskingEmail | String| Yes | 멤버의 마스킹된 이메일  |
|   memberName | String| Yes| 멤버의 이름 |
|   memberTypeCode | String| Yes| 멤버 구분(TOAST_CLOUD: NHN Cloud 멤버, IAM: IAM 멤버) |
|   memberUuid | String| No| 멤버의 UUID<br>초대 중인 경우 값을 반환하지 않음 |
|   recentLoginYmdt | Date| Yes| 마지막 로그인 일시 |
|   recentPasswordModifyYmdt | Date| No| 마지막 비밀번호 변경 일시 |
|   secondFactorCertificationYn | String| No|  2단계 로그인 설정 여부(NHN Cloud 멤버만 제공) |

###### PagingResponse


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------------- | ------------ |
|   limit | Integer| No | 페이지당 표시 건수, 기본값 20  |
|   page | Integer| No | 대상 페이지, 기본값 1  |
|   totalCount | Long| Yes | 총 건수  |





#### 조직의 프로젝트 공통 역할 그룹 전체 조회
> GET "/v1/organizations/{org-id}/project-role-groups"

조직에서 설정한 프로젝트 공통 역할 그룹 목록을 조회하는 API입니다.

##### 필요 권한
`Organization.Project.RoleGroup.List`

##### 요청 파라미터



| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 조회 대상 조직 ID | 
|  Query |descriptionLike | String| No | 설명 | 
|  Query |roleGroupNameLike | String| No | 역할 그룹명 |
|  Query |limit | Integer| No | 페이지당 표시 건수, 기본값 20 |
|  Query |page | Integer| No | 대상 페이지, 기본값 1 |






##### 응답 본문

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



###### 응답


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | --------- | ------------ |
|   header | [공통 Response](#response)| Yes  |
|   paging | [PagingResponse](#pagingresponse)| Yes  |
|   roleGroups | List&lt;RoleGroupProtocol>| Yes | 프로젝트에서 사용 가능한 역할 그룹 목록  |


###### RoleGroupProtocol


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ----- | ------------ |
|   description | String| No | 역할 그룹 설명 |
|   regDateTime | Date| Yes | 역할 그룹 생성 일시 |
|   roleGroupId | String| Yes | 역할 그룹 ID |
|   roleGroupName | String| Yes| 역할 그룹의 이름 |
|   roleGroupType | String| Yes | 역할 그룹의 종류<br><ul><li>ORG: 프로젝트 공통 역할 그룹</li><li>ORG_ROLE_GROUP: 조직 역할 그룹</li><li>PROJECT: 프로젝트 역할 그룹</li> |



#### 상품 계층 구조 조회
> GET "/v1/product-uis/hierarchy"

청구서에 노출되는 홈페이지 카테고리, 홈페이지 서비스 정보를 반환하는 API입니다.

##### 필요 권한
NHN Cloud 멤버이면 특정한 권한 없이 호출할 수 있는 API입니다.<br>
단, 조직 상품을 조회하는 경우에는 해당 조직이나 조직 하위에 있는 프로젝트 멤버여야만 합니다.

##### 요청 파라미터



| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Query |productUiType | String| Yes | 상품 UI 타입<br><ul><li>PROJECT: 프로젝트 상품</li><li>ORG: 조직 상품</li><li>MARKET_PLACE: 마켓플레이스 상품</li></ul> |
|  Query |orgId | String| No | 상품 UI 타입이 ORG인 경우, 조직 ID를 반드시 입력해야 함 |




##### 응답 본문

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

###### 응답


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------- | ------------ |
|   header | [공통 응답](#response)| Yes |
|   productUiList | List&lt;ProductUiHierarchyProtocol>| Yes  | 홈페이지 카테고리 상품 UI 목록 |

###### ProductUiHierarchyProtocol


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ----- | ------------ |
|   children | List&lt;ProductUiHierarchyProtocol>| No | 홈페이지 서비스 상품 UI 목록 |
|   manualLink | String| No|
|   parentProductUiId | String| No| 상품 UI 구분 |
|   productId | String| No|
|   productUiId | String| No| 상품 UI 식별 키 |
|   productUiName | String| No|



#### 프로젝트에서 사용 중인 상품 조회
> GET "/v1/projects/{project-id}/products/{product-id}"

* 프로젝트에서 사용 중인 특정 서비스 정보를 조회하는 API

##### 필요 권한
`상품명:ProductAppKey.Get`

##### 요청 파라미터



| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | 조회 대상 프로젝트 ID |
|  Path |product-id | String| Yes | 조회 대상 서비스 ID |




##### 응답 본문

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

###### 응답


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------- | ------------ |
|   header | [공통 응답](#response)| Yes |
|   hasUpdateSecretKeyPermission | Boolean| Yes | 비밀 키 재발급 가능 권한  |
|   product | ProjectProductRelationAndProductProtocol| Yes  | 지정한 서비스 ID에 대해서 프로젝트에서 사용 중인 서비스 정보를 반환, 오류 시 포함하지 않음 |


###### ProjectProductRelationAndProductProtocol


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------------- | ------------ |
|   appKey | String| Yes | 해당 프로젝트에서 이용 중인 서비스의 AppKey 정보  |
|   externalId | String| No | 테넌트 ID<br>서비스에 테넌트 ID가 존재하는 경우에만 제공 |
|   productId | String| Yes | 서비스 ID  |
|   productName | String| Yes | 상품 이름  |
|   productSecretKeyCode | String| No | 비밀 키 사용 여부<br>T: 사용함<br>나머지: 사용하지 않음(F, N) |
|   productStatusCode | String| Yes | 서비스 상태(STABLE, CLOSED) |
|   projectId | String| Yes | 해당 서비스를 사용하는 프로젝트 ID  |
|   relationDate | Date| Yes | 서비스 이용 시작 일시  |
|   secretKey | String| Yes | 서비스 SecretKey<br>secretKey를 이용하는 서비스에서만 제공  |
|   statusCode | String| Yes | 해당 서비스의 이용 상태(STABLE, CLOSED) |
|   updateDate | Date| No | 서비스 최종 수정 일시  |
|   updateUuid | String| No | 서비스 AppKey 수정자 UUID  |



#### 프로젝트 멤버 단건 조회
> GET "/v1/projects/{project-id}/members/{member-uuid}"

프로젝트에 소속된 특정 멤버를 조회하는 API입니다.

##### 필요 권한
`Project.Member.Get`

##### 요청 파라미터



| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | 멤버를 조회할 프로젝트 ID |
|  Path |member-uuid | String| Yes | 조회할 멤버 UUID |




##### 응답 본문

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


###### 응답


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------- | ------------ |
|   header | [공통 응답](#response)| Yes |
|   projectMember | ProjectMemberRoleBundleProtocol| Yes  | 추가된 멤버 정보, 오류 시 포함되지 않음 |


###### ProjectMemberRoleBundleProtocol


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------------- | ------------ |
|   emailAddress | String| No | 멤버 이메일 주소  |
|   maskingEmail | String| No | 멤버의 마스킹된 이메일  |
|   memberName | String| No | 멤버 이름  |
|   memberTypeCode | String| No | 멤버 구분(IAM, TOAST_CLOUD) |
|   relationDateTime | Date| No | 멤버 추가 시간  |
|   roles | List&lt;RoleBundleProtocol>| No | 연관 역할 목록(조건 속성 포함)  |
|   statusCode | String| No | 초대 상태 코드(COMPLETE, EXPIRE, UNKNOWN, WAIT) |
|   uuid | String| No | 멤버 UUID  |


[RoleBundleProtocol](#rolebundleprotocol)




#### 프로젝트 멤버 목록 조회
> POST "/v1/projects/{project-id}/members/search"

프로젝트에 소속된 멤버 목록을 조회하기 위한 API입니다.

##### 필요 권한
`Project.Member.List`

##### 요청 파라미터


| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | 조회할 프로젝트 ID | 
| Request Body | request | SearchProjectMembersRequest| Yes | 요청 |



###### SearchProjectMembersRequest


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ----------- | ------------ |
|   memberStatusCodes | List&lt;String>| No | 프로젝트 멤버 상태 코드(INVITED, STABLE) |
|   roleIds | List&lt;String>| No | 역할 ID 목록  |
|   paging | [PagingBean](#pagingbean) | No   |





##### 응답 본문

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

###### 응답


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------- | ------------ |
|   header | [공통 응답](#response)| Yes |
|   paging | [PagingResponse](#pagingresponse)| Yes  |
|   projectMembers | List&lt;ProjectMemberProtocol>| Yes | 프로젝트 멤버  |



###### ProjectMemberProtocol


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------------- | ------------ |
|   emailAddress | String| No | 멤버 이메일 주소  |
|   maskingEmail | String| No | 멤버의 마스킹된 이메일  |
|   memberName | String| No | 멤버 이름  |
|   memberTypeCode | String| No | 멤버 구분 |
|   relationDateTime | Date| No | 멤버 추가 시간  |
|   statusCode | String| No | 초대 상태 코드(COMPLETE, EXPIRE, UNKNOWN, WAIT) |
|   uuid | String| No | 멤버 UUID  |



#### 프로젝트 역할 그룹 단건 조회
> GET "/v1/projects/{project-id}/project-role-groups/{role-group-id}"

프로젝트의 역할 그룹을 조회하는 API입니다.

##### 필요 권한
`Project.RoleGroup.Get`

##### 요청 파라미터



| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | 조회 대상 프로젝트 ID | 
|  Path |role-group-id | String| Yes | 프로젝트 역할 그룹 ID<br>프로젝트 공통 역할 그룹 ID는 조회 불가 | 




##### 응답 본문

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

###### 응답


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | --------- | ------------ |
|   header | [공통 응답](#response)| Yes |
|   roleGroup | RoleGroupBundleProtocol| Yes | 연관 역할을 포함한 역할 그룹  |

###### RoleGroupBundleProtocol

| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------------- | ------------ |
|   roleGroupId | String| No | 역할 그룹 ID  |
|   roleGroupName | String| No | 역할 그룹 이름  |
|   description | String| No | 역할 그룹 설명  |
|   roleGroupType | String| No | 역할 그룹 구분(조직, 프로젝트)  |
|   roles | List&lt;[RoleBundleProtocol](#rolebundleprotocol)>| No | 연관 역할 목록  |
|   regDateTime | Date| No | 등록 일시  |




#### 조직의 프로젝트 공통 역할 그룹 단건 조회
> GET "/v1/organizations/{org-id}/project-role-groups/{role-group-id}"

프로젝트 공통 역할 그룹을 조회하는 API입니다.

##### 필요 권한
`Organization.Project.RoleGroup.Get`

##### 요청 파라미터


| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 조회 대상 조직 ID | 
|  Path |role-group-id | String| Yes | 프로젝트 공통 역할 그룹 ID | 


##### 응답 본문

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


###### 응답


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | --------- | ------------ |
|   header | [공통 응답](#response)| Yes |
|   roleGroup | [RoleGroupBundleProtocol](#rolegroupbundleprotocol) | Yes | 연관 역할을 포함한 역할 그룹  |





#### 프로젝트 역할 그룹 전체 조회
> GET "/v1/projects/{project-id}/project-role-groups"

프로젝트의 역할 그룹을 전체 조회하는 API입니다.

##### 필요 권한
`Project.RoleGroup.List`

##### 요청 파라미터


| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | 조회 대상 프로젝트 ID | 
|  Query |descriptionLike | String| No | 설명 |
|  Query |roleGroupNameLike | String| No | 역할 그룹명 |
|  Query |limit | Integer| No | 페이지당 표시 건수, 기본값 20 |
|  Query |page | Integer| No | 대상 페이지, 기본값 1 |



##### 응답 본문

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

###### 응답


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | --------- | ------------ |
|   header | [공통 Response](#response)| Yes  |
|   paging | [PagingResponse](#pagingresponse)| Yes  |
|   roleGroups | List&lt;[RoleGroupProtocol](#rolegroupprotocol)>| Yes | 프로젝트에서 사용 가능한 역할 그룹 목록  |


#### 조직에 속한 프로젝트 목록 조회
> GET "/v1/organizations/{org-id}/projects"

특정 조직에 속한 STABLE 한 상태의 프로젝트 목록을 조회하는 API입니다.

##### 필요 권한
조직의 멤버

##### 요청 파라미터


| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 조회할 조직의 ID | 
|  Query |memberUuid | String| No | 조직의 멤버 UUID |
|  Query |projectName | String| No | 프로젝트 이름 |
|  Query |page | Integer| No | 대상 페이지, 기본값 1 |
|  Query |limit | Integer| No | 페이지당 표시 건수, 기본값 20 |


##### 응답 본문

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


###### 응답


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------- | ------------ |
|   header | [공통 응답](#response)| Yes |
|   paging | [PagingResponse](#pagingresponse) | Yes |
|   projectList | List&lt;OrgProjectMemberRoleProtocol>| Yes |



###### OrgProjectMemberRoleProtocol

| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ----- | ------------ |
|   delDateTime | Date| No | 프로젝트 삭제 일시 |
|   description | String| No | 프로젝트 설명 |
|   modDateTime | Date| No| 프로젝트 수정 일시 |
|   orgId | String| Yes| 프로젝트가 속한 조직 ID |
|   projectId | String| Yes| 프로젝트 ID |
|   projectName | String| Yes| 프로젝트 이름 |
|   projectStatusCode | String| Yes | 프로젝트 상태<br><ul><li>STABLE: 정상적으로 사용 중인 상태</li><li>CLOSED: 지불이 완료되어 프로젝트가 잘 닫힌 상태</li><li>BLOCKED: 관리자에 의해 사용이 금지된 상태</li><li>TERMINATED: 연체로 인해 모든 리소스가 삭제된 상태</li><li>DISABLED: 모든 상품이 닫힌 상태지만 값이 지불되지 않은 상태</li></ul> |
|   regDateTime | Date| Yes| 프로젝트 등록 일시 |



#### 사용 중인 조직 거버넌스 목록 조회
> GET "/v1/organizations/{org-id}/governances"

활성화된 거버넌스를 조회하는 API입니다.

##### 필요 권한
`Organization.Governance.List`

##### 요청 파라미터

| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 조회 대상 조직 ID | 



##### 응답 본문

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



###### 응답


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [공통 Response](#response)| Yes   |
|   usingGovernances | List&lt;GovernanceProtocol>| No | 사용 중인 거버넌스 목록  |


###### GovernanceProtocol


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------------- | ------------ |
|   governanceTypeCode | String| No | 거버넌스 타입  |
|   regDatetime | Date| No | 거버넌스 사용 설정 일시  |



#### 조직의 프로젝트 공통 역할 그룹 생성
> POST "/v1/organizations/{org-id}/project-role-groups"

프로젝트 공통 역할 그룹을 생성하는 API입니다.


##### 필요 권한
`Organization.Project.RoleGroup.Create`

##### 요청 파라미터

| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 조직 ID | 
| Request Body | request | CreateRoleGroupRequest| Yes | 요청 |

###### CreateRoleGroupRequest


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------------- | ------------ |
|   description | String| No | 역할 그룹 설명  |
|   roleGroupName | String| Yes | 역할 그룹 이름  |
|   roles | List&lt;AssignRoleProtocol>| Yes | 역할 그룹에 할당할 역할 목록  |


###### AssignRoleProtocol


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------------- | ------------ |
|   conditions | List&lt;[AssignAttributeConditionProtocol](#assignattributeconditionprotocol)>| No | 역할 조건 속성  |
|   roleApplyPolicyCode | String| Yes | 역할 사용 여부  ALLOW, DENY |
|   roleId | String| Yes | 역할 ID  |




##### 응답 본문

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### 응답

| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [공통 Response](#response)| Yes   |



#### 조직의 프로젝트 공통 역할 그룹 삭제
> DELETE "/v1/organizations/{org-id}/project-role-groups"

프로젝트 공통 역할 그룹을 삭제하는 API입니다.

##### 필요 권한
`Organization.Project.RoleGroup.Delete`

##### 요청 파라미터


| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 조직 ID | 
| Request Body | request | DeleteRoleGroupRequest| Yes | 요청 |


###### DeleteRoleGroupRequest


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------------- | ------------ |
|   roleGroupIds | List&lt;String>| Yes | 역할 그룹 ID 목록  |


##### 응답 본문

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### 응답

| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [공통 Response](#response)| Yes   |


#### 조직의 프로젝트 공통 역할 그룹 정보 수정
> PUT "/v1/organizations/{org-id}/project-role-groups/{role-group-id}/infos"

프로젝트 공통 역할 그룹의 이름과 설명을 수정하는 API입니다.

##### 필요 권한
`Organization.Project.RoleGroup.Update`

##### 요청 파라미터


| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 조직 ID | 
|  Path |role-group-id | String| Yes | 역할 그룹 ID | 
| Request Body | request | UpdateRoleGroupInfoRequest| Yes | 요청 |


###### UpdateRoleGroupInfoRequest


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------------- | ------------ |
|   description | String| No | 역할 그룹 설명  |
|   roleGroupName | String| Yes | 역할 그룹 이름  |



##### 응답 본문

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### 응답

| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [공통 Response](#response)| Yes   |


#### 조직의 프로젝트 공통 역할 그룹 역할 수정
> PUT "/v1/organizations/{org-id}/project-role-groups/{role-group-id}/roles"

프로젝트 공통 역할 그룹의 역할을 수정하는 API입니다.

##### 필요 권한
`Organization.Project.RoleGroup.Update`

##### 요청 파라미터

| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 조직 ID | 
|  Path |role-group-id | String| Yes | 역할 그룹 ID | 
| Request Body | request | UpdateRoleGroupRequest| Yes | 요청 |


###### UpdateRoleGroupRequest


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------------- | ------------ |
|   roles | List&lt;[AssignRoleProtocol](#assignroleprotocol)>| Yes | 역할 그룹에 할당할 역할 목록  |




##### 응답 본문

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### 응답

| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [공통 Response](#response)| Yes   |


#### 프로젝트 역할 그룹 생성
> POST "/v1/projects/{project-id}/project-role-groups"

프로젝트에 역할 그룹을 생성하는 API입니다.


##### 필요 권한
`Project.RoleGroup.Create`

##### 요청 파라미터


| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | 프로젝트 ID | 
| Request Body | request | [CreateRoleGroupRequest](#createrolegrouprequest)| Yes | 요청 |





##### 응답 본문

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### 응답

| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [공통 Response](#response)| Yes   |


#### 프로젝트 역할 그룹 삭제
> DELETE "/v1/projects/{project-id}/project-role-groups"

프로젝트 역할 그룹을 삭제하는 API입니다.


##### 필요 권한
`Project.RoleGroup.Delete`

##### 요청 파라미터


| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | 프로젝트 ID | 
| Request Body | request | [DeleteRoleGroupRequest](#deleterolegrouprequest)| Yes | 요청 |





##### 응답 본문

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### 응답

| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [공통 Response](#response)| Yes   |


#### 프로젝트 역할 그룹 정보 수정
> PUT "/v1/projects/{project-id}/project-role-groups/{role-group-id}/infos"

프로젝트 역할 그룹의 이름과 설명을 수정하는 API입니다.

##### 필요 권한
`Project.RoleGroup.Update`

##### 요청 파라미터

| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | 프로젝트 ID | 
|  Path |role-group-id | String| Yes | 역할 그룹 ID | 
| Request Body | request |[UpdateRoleGroupInfoRequest](#updaterolegroupinforequest)| Yes | 요청 |





##### 응답 본문

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### 응답

| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [공통 Response](#response)| Yes   |



#### 프로젝트 역할 그룹 역할 수정
> PUT "/v1/projects/{project-id}/project-role-groups/{role-group-id}/roles"

프로젝트 역할 그룹의 역할을 수정하는 API입니다.

##### 필요 권한
`Project.RoleGroup.Update`

##### 요청 파라미터

| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | 프로젝트 ID | 
|  Path |role-group-id | String| Yes | 역할 그룹 ID | 
| Request Body | request | UpdateRoleGroupRequest| Yes | 요청 |

###### UpdateRoleGroupRequest


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------------- | ------------ |
|   roles | List&lt;[AssignRoleProtocol](#assignroleprotocol)>| Yes | 역할 그룹에 할당할 역할 목록  |





##### 응답 본문

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### 응답

| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [공통 Response](#response)| Yes   |


#### 조직 멤버 역할 변경
> PUT "/v1/organizations/{org-id}/members/{member-uuid}"

해당 조직에 소속된 멤버의 역할을 수정하는 API입니다.


##### 필요 권한
`Organization.Member.Update`


##### 요청 파라미터


| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 조직 ID | 
|  Path |member-uuid | String| Yes | 수정할 멤버의 UUID | 
| Request Body | request | UpdateMemberRoleRequest| Yes | 요청 |


###### UpdateMemberRoleRequest


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------------- | ------------ |
|   assignRoles | List&lt;[UserAssignRoleProtocol](#userassignroleprotocol)>| Yes | 사용자에게 할당할 역할 목록  |





##### 응답 본문

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### 응답

| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [공통 Response](#response)| Yes   |


#### 프로젝트 멤버 역할 수정
> PUT "/v1/projects/{project-id}/members/{member-uuid}"

프로젝트에서 지정한 멤버의 역할을 변경하는 API입니다.

##### 필요 권한
`Project.Member.Update`

##### 요청 파라미터

| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | 프로젝트 ID | 
|  Path |member-uuid | String| Yes | 역할 변경 대상 멤버 UUID | 
| Request Body | request | [UpdateMemberRoleRequest](#updatememberrolerequest)| Yes | 요청 |




##### 응답 본문

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### 응답

| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [공통 Response](#response)| Yes   |


#### 조직 IAM 멤버 단건 조회
> GET "/v1/iam/organizations/{org-id}/members/{member-uuid}"

조직에 소속된 IAM 멤버를 조회하는 API입니다.

##### 필요 권한
`Organization.Member.Iam.Get`


##### 요청 파라미터

| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 조회할 조직 ID | 
|  Path |member-uuid | String| Yes | 조회할 조직의 IAM 멤버 UUID | 


##### 응답 본문

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

###### 응답

| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [공통 Response](#response)| Yes   |
|   orgMember | OrgIamMemberRoleBundleProtocol| No  |

###### OrgIamMemberRoleBundleProtocol


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ----- | ------------ |
|   corporate | String| No |
|   country | String| No |
|   createdAt | Date| No |
|   creationType | String| No| 멤버의 생성 타입 |
|   department | String| No|
|   emailAddress | String| Yes | IAM 멤버 이메일 주소  |
|   englishName | String| No|
|   id | String| Yes | IAM 멤버 UUID  |
|   idProviderId | String| No|
|   idProviderType | String| No| service: IAM 직접 로그인<br>sso: 고객 SSO 연동 |
|   idProviderUserId | String| No|
|   lastAccessedAt | Date| No| 멤버의 마지막 접속 일시, 없을 경우 null 반환 |
|   lastLoggedInAt | Date| No| 멤버의 마지막 로그인 일시, 없을 경우 null 반환 |
|   lastLoggedInIp | String| No| 멤버의 마지막 로그인 IP 주소, 없을 경우 null 반환 |
|   maskingEmail | String| No | IAM 멤버의 마스킹된 이메일주소  |
|   mobilePhone | String| No | IAM 멤버의 휴대폰 번호  |
|   mobilePhoneCountryCode | String| No|
|   name | String| Yes | IAM 멤버의 이름  |
|   nativeName | String| No|
|   nickname | String| No|
|   officeHoursBegin | String| No|
|   officeHoursEnd | String| No|
|   organizationId | String| Yes | IAM 멤버의 조직 ID  |
|   passwordChangedAt | Date| No| 멤버의 마지막 비밀번호 변경 일시, 없을 경우 null 반환 |
|   position | String| No|
|   profileImageUrl | String| No|
|   roles | List&lt;[RoleBundleProtocol](#rolebundleprotocol)>| No | 연관 역할 목록(조건 속성 포함)  |
|   saasRoles | List&lt;IamMemberRole>| No | IAM 멤버 역할  |
|   status | String| No| 멤버의 상태 |
|   telephone | String| No | IAM 멤버의 전화번호  |
|   userCode | String| Yes | IAM 멤버 ID  |



###### IamMemberRole


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------- | ------------ |
|   productId | String| No |
|   productName | String| No |
|   role | String| No |



#### 조직 IAM 멤버 목록 조회
> GET "/v1/iam/organizations/{org-id}/members"

해당 조직에 소속된 IAM 멤버 목록을 조회하는 API입니다.

##### 필요 권한
`Organization.Member.Iam.List`

##### 요청 파라미터

| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 조직 ID | 
|  Query |email | String| No | IAM 멤버의 이메일 주소 |
|  Query |emailLike | String| No |  |
|  Query |idProviderType | String| No | service: IAM 직접 로그인<br>sso: 고객 SSO 연동 |
|  Query |nameLike | String| No |  |
|  Query |statuses | List&lt;String>| No |  |
|  Query |userCode | String| No | IAM 멤버 ID |
|  Query |userCodeLike | String| No |  |
|  Query |limit | Integer| No | 페이지당 표시 건수, 기본값 20 |
|  Query |page | Integer| No | 대상 페이지, 기본값 1 |

##### 응답 본문

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


###### 응답

| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [공통 Response](#response)| Yes   |
|   orgMembers | List&lt;IamOrgMemberProtocol>| No | 조직 IAM 멤버 목록  |
|   paging | [PagingResponse](#pagingresponse)| No  |

###### IamOrgMemberProtocol

| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | --------- | ------------ |
| header | [공통 Response](#response)| Yes | protocol이 response에 있는 경우에만 필수값 |
| id | String | No | IAM 멤버 UUID | 
| userCode | String | Yes | 로그인 시 사용할 IAM 멤버 ID | 
| name | String | Yes | IAM 멤버의 사용자 이름 | 
| emailAddress | String |  Yes | IAM 멤버의 이메일 주소<br>공지를 수신하거나 비밀번호 변경 안내 메일 수신 시 사용됨 |
| maskingEmail | String | No | IAM 멤버의 마스킹된 이메일 주소 |
| mobilePhone | String | No | IAM 멤버의 휴대폰 번호 |
| telephone | String | No | IAM 멤버 전화번호 |
| position | String | No |  |
| department | String | No |  |
| corporate | String | No |  |
| profileImageUrl | String | No |  |
| englishName | String | No |  |
| nativeName | String | No |  |
| nickname | String | No |  |
| officeHoursBegin | String | No |  |
| officeHoursEnd | String | No |  |
| status | String | Yes | 멤버 상태를 변경할 수 있음<br><ul><li>member: 정상 이용 상태</li><li>leaved: 탈퇴 요청</li></ul>생성 시에는 반드시 member를 지정해야 함 |
| creationType | String | No |  |
| idProviderId | String | No |  |
| idProviderType | String | No | service: IAM 직접 로그인(기본값)<br>sso: 고객 SSO 연동(연동되지 않은 경우 설정 불가) |
| idProviderUserId | String | No |  |
| createdAt | Date | No | 생성 일시 |
| lastAccessedAt | Date | No | 마지막 접속일시 |
| lastLoggedInAt | Date | No | 마지막 로그인일시 |
| lastLoggedInIp | String | No | 마지막 로그인 한 IP |
| passwordChangedAt | Date | No | 비밀번호 변경 일시 |
| mobilePhoneCountryCode | String | No | 휴대폰 번호 입력 시 필수  |
| organizationId | String | No | IAM 멤버의 조직 ID |
| country | String | No |  |
| saasRoles | List&lt;[IamMemberRole](#iammemberrole)> | No | IAM 역할 |






#### 조직 IAM 멤버 추가
> POST "/v1/iam/organizations/{org-id}/members"

조직에 IAM 멤버를 추가하는 API입니다.

##### 필요 권한
`Organization.Member.Iam.Create`


##### 요청 파라미터

| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 조직 ID | 
| Request Body | request | AddIamOrgMemberRequest| Yes | 요청 |

###### AddIamOrgMemberRequest


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ----------- | ------------ |
|   member | [IamOrgMemberProtocol](#iamorgmemberprotocol)| Yes   |




##### 응답 본문

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


###### 응답

| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [공통 Response](#response)| Yes   |
|   uuid | String| No | IAM 멤버 UUID  |





#### IAM 멤버 비밀번호 변경 이메일 전송
> POST "/v1/iam/organizations/{org-id}/members/{member-id}/send-password-setup-mail"

IAM 멤버의 비밀번호를 변경할 수 있는 이메일을 전송하는 API입니다.

##### 필요 권한
`Organization.Member.Iam.Update`


##### 요청 파라미터

| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 대상이 되는 조직 ID | 
|  Path |member-id | String| Yes | 비밀번호를 변경하려는 IAM 멤버의 UUID | 
| Request Body | request | SendPasswordSetupMailRequest| Yes | 요청 |



###### SendPasswordSetupMailRequest


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | --------- | ------------ |
|   locale | String| No  | 사용자의 로케일 정보<br>예: ko |
|   returnUrl | String| No  | 이메일 변경 알림 메일을 통해서 비밀번호를 변경한 이후 이동할 페이지 주소 정보<br>이동할 주소 정보에는 반드시 toast.com, dooray.com 또는 nhncloud.com 도메인을 입력해야 함 |


##### 응답 본문

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### 응답

| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [공통 Response](#response)| Yes   |


#### 조직 IAM 멤버 정보 수정
> PUT "/v1/iam/organizations/{org-id}/members/{member-uuid}"

조직의 IAM 멤버 정보를 수정하는 API입니다.

##### 필요 권한
`Organization.Member.Iam.Update`

##### 요청 파라미터

| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 	대상이 되는 조직 ID | 
|  Path |member-uuid | String| Yes | 변경하려는 IAM 멤버의 UUID | 
| Request Body | request | UpdateIamMemberRequest| Yes | 요청 |


###### UpdateIamMemberRequest


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ----------- | ------------ |
|   member | [IamOrgMemberProtocol](#iamorgmemberprotocol)| Yes   |



##### 응답 본문

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### 응답

| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [공통 Response](#response)| Yes   |


#### 조직 IAM 멤버 비밀번호 변경
> POST "/v1/iam/organizations/{org-id}/members/{member-id}/set-password"

조직 IAM 멤버의 비밀번호를 변경하는 API입니다.

##### 필요 권한
`Organization.Member.Iam.Update`

##### 요청 파라미터

| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 대상이 되는 조직 ID | 
|  Path |member-id | String| Yes | 비밀번호를 변경하려는 IAM 멤버의 UUID | 
| Request Body | request | UpdateIamPasswordRequest| Yes | 요청 |


###### UpdateIamPasswordRequest


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | --------- | ------------ |
|   password | String| Yes  | 설정할 비밀번호 | 


##### 응답 본문

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### 응답

| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [공통 Response](#response)| Yes   |


#### 조직 IP ACL 목록 조회
> GET "/v1/organizations/{org-id}/products/ip-acl"

IP ACL 설정을 조회하는 API입니다.

##### 필요 권한
`Organization.Governance.IpAcl.List`

##### 요청 파라미터

| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 조직 ID | 


##### 응답 본문

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


###### 응답

| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [공통 Response](#response)| Yes   |
|   orgIpAcl | List&lt;OrgIpAclProtocol>| Yes  | 설정 결과, 빈 목록이면 설정이 안된 상태 |

###### OrgIpAclProtocol


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | --------- | ------------ |
|   ips | List&lt;String>| Yes  | 허용 IP들 | 
|   productId | String| Yes  | 상품 ID<br>undefined이면 공통 설정|


#### 조직 IAM 로그인 세션 설정 정보를 조회
> GET "/v1/iam/organizations/{org-id}/settings/session"

로그인 세션 설정 정보를 조회하는 API입니다.

##### 필요 권한
`Organization.Setting.Iam.Get`

##### 요청 파라미터

| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 조직 ID | 


##### 응답 본문

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


##### 응답

| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------------- | ------------ |
| header | [공통 Response](#response)| Yes   |
| result | Content | Yes | 설정 내용 |

###### Content

| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------------- | ------------ |
|   multiSessionsLimit | Integer| Yes | 허용 멀티 세션 수  |
|   sessionTimeoutMinutes | Integer| Yes | 	세션 타임아웃 |
|   mobileSessionTimeoutMinutes | Integer| Yes | 	모바일 세션 타임아웃 |
|   sessionType | String| Yes | fixed/idle. 기본값은 fixed  |


#### 조직 IAM 로그인 2차 인증에 대한 설정을 조회
> GET "/v1/iam/organizations/{org-id}/settings/security-mfa"

로그인 2차 인증에 대한 설정을 조회하는 API입니다.

##### 필요 권한
`Organization.Setting.Iam.Get`

##### 요청 파라미터


| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 조직 ID | 

##### 응답 본문

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


##### 응답

| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------------- | ------------ |
|   header | [공통 Response](#response)| Yes   |
|   result | Result| No |  응답 내용<br>설정한 적이 없으면 null이 반환됨 |

###### Result
| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ----------- | ------------ |
|   range | Integer| No | 조직/서비스 여부<br>organization(공통 설정), services(서비스별 설정)  |
|   organizationMfaSetting | OrganizationMfaSetting| No | 조직 mfa 설정 정보<br>공통 설정 |
|   serviceMfaSettings | ServiceMfaSettings| No | 서비스별 mfa 설정 정보  |


###### OrganizationMfaSetting

| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------------- | ------------ |
|   type | String| No | mfa 타입<br>none(설정 안함), totp(Google OTP), email(이메일) |
|   bypassByIp | BypassByIp| No | 예외 IP  |

###### ServiceMfaSettings


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------------- | ------------ |
|   serviceId | Sting| No | 서비스 ID  |
|   type | String| No | mfa 타입<br>none(설정 안함), totp(Google OTP), email(이메일) |
|   bypassByIp | BypassByIp| No | 서비스 타입. none, totp, email |

###### BypassByIp

| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------------- | ------------ |
|   enable | Boolean| No | 활성화 여부<br>true(사용 중), false(사용 안함)  |
|   ipList | List&lt;String>| No | 예외 IP 목록 |


#### 조직 IAM 로그인 실패 보안 설정을 조회
> GET "/v1/iam/organizations/{org-id}/settings/security-login-fail"

로그인 실패 보안 설정을 조회하는 API입니다.

##### 필요 권한
`Organization.Setting.Iam.Get`

##### 요청 파라미터

| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 조직 ID | 


##### 응답 본문

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


##### 응답

| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------------- | ------------ |
| header | [공통 Response](#response)| Yes   |
| result | Result | No | 로그인 실패 보안을 설정한 경우에만 반환되며, 설정하지 않으면 null이 반환됨 |

###### Result

| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ----------- | ------------ |
|   enable | Boolean| Yes | 활성화 여부<br>true(사용 중), false(사용 안함)  |
|   loginFailCount | LoginFailCount| No | 로그인 실패 보안 설정 |


###### LoginFailCount

| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------------- | ------------ |
|   limit | Integer| No | 시도 허용 횟수 |
|   blockMinutes | Integer| No | 로그인 금지 시간  |


#### 종량제에 등록된 상품 가격 조회
> POST "/v1/billing/contracts/basic/products/prices/search"

카운터에 설정된 단가를 조회하는 API입니다.
각 언어별로 노출명, 금액 계산을 위한 종류를 알 수 있습니다.


##### 필요 권한
NHN Cloud 회원이면 호출 가능한 API

##### 요청 파라미터

| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Query |limit | Integer| No |  |
| Request Body | request | GetContractProductPriceRequest| Yes | 요청 |

##### GetContractProductPriceRequest
| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | --------- | ------------ |
|  counterNames | List&lt;String>| No | 상품 메타의 counter Name 목록<br>없을 경우 전체 검색함 |
|   paging | Paging| No  |

###### Paging

| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------------- | ------------ |
|   limit | Integer| No | 페이지당 표시 건수, 기본값 20  |
|   page | Integer| No | 대상 페이지, 기본값 1  |


##### 응답 본문

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

###### 응답

| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [공통 Response](#response)| Yes   |
|   paging | PagingResponse| Yes | 정렬 기준이 없는 페이징 결과 반환  |
|   prices | List&lt;ContractProductPriceProtocol>| Yes | 카운터의 단가 정보를 배열로 반환<br>오류 시 포함되지 않음  |

###### PagingResponse

| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------- | ------------ |
|   limit | Integer| Yes | 조회되는 개수 제한<br>기본값은 20 |
|   page | Integer| Yes |
|   totalCount | Integer| Yes |

###### ContractProductPriceProtocol


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------------- | ------------ |
|   contractDiscountPolicyId | String| Yes | 약정 요금 정책 아이디  |
|   contractId | String| Yes | 약정 아이디  |
|   counterName | String| Yes | 카운터  |
|   displayNameEn | String| No | 	카운터의 영어 이름  |
|   displayNameJa | String| No | 카운터의 일본어 이름  |
|   displayNameKo | String| Yes | 카운터의 한국어 이름  |
|   displayNameZh | String| No | 	카운터의 중국어 이름<br>현재는 영어로 노출됨 |
|   monthFrom | String| Yes | 단가 정보가 유효한 시작월(포함)  |
|   monthTo | String| Yes | 단가 정보가 유효한 종료월(미포함)  |
|   originalPrice | BigDecimal| Yes | 단가  |
|   price | BigDecimal| Yes | 단가  |
|   rangeFrom | BigDecimal| Yes | 단가에 속하게 되는 사용량 범위 시작(미포함)  |
|   rangeTo | BigDecimal| Yes | 단가에 속하게 되는 사용량 범위 종료(포함)  |
|   seq | Long| Yes | 일련번호  |
|   slidingCalculationTypeCode | String| Yes | 슬라이딩 요금 계산 유형<br>NONE, SECTION_SUM, SECTION_SELECTED |
|   useFixPriceYn | String| Yes | 고정 금액  여부(Y: 고정 금액 , N: 단가 계산)<br>Y: 범위에 들어올 경우 price가 금액이 됨<br>N: (사용량 x 단가)가 금액이 됨 |


#### 종량제에 등록된 상품 목록 조회
> GET "/v1/billing/contracts/basic/products"

청구서에 노출되는 메인 카테고리와 서브 카테고리 및 포함되는 카운터의 목록을 제공하는 API입니다.

##### 필요 권한
NHN Cloud 회원이면 호출 가능한 API

##### 요청 파라미터

| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Query |limit | Integer| No | 조회되는 개수 제한<br>기본값은 20 |
|  Query |page | Integer| No |  |


##### 응답 본문

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


###### 응답

| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [공통 Response](#response)| Yes   |
|   paging | PagingResponse| Yes  |
|   products | List&lt;ProductMetadata>| Yes | 상품 메타 정보 목록  |


[PagingResponse](#pagingresponse)

###### ProductMetadata


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------------- | ------------ |
|   budgetUsageTypeYn | String| No | 예산 사용량 타입 Yn  Y, N |
|   calcUnitCode | String| Yes | 금액 계산 시 사용할 단위(미터링 단위를 정산 단위로 변환하여 금액 계산을 수행함), 명세서에 노출할 단위<br>KB, MB, GB, TB, SECONDS, MINUTE, HOURS, DAYS, MB_HOURS, GB_SECONDS, GB_HOURS, GB_DAYS, CORE_SECONDS, CORE_HOURS, CORE_DAYS, USERS, MAU, MAD, DAU, CALLS, COUNTS, CCU, VCPU_HOURS, COUNT_HOURS |
|   categoryMain | String| Yes | 메인 카테고리  |
|   categorySub | String| Yes | 서브 카테고리  |
|   chargingTypeId | String| Yes | 과금 유형 ID  |
|   convertUsageTypeCode | String| Yes | 사용량 변환 타입 코드  NONE, HOUR_AVERAGE, DAY_AVERAGE |
|   counterName | String| Yes | 카운터  |
|   counterTypeCode | String| Yes | 사용량의 합산에 대한 방법<br><ul><li>DELTA: 증가값(HOURLY_SUM)</li><li>GAUGE: 시간 최대값의 합(HOURLY_MAX로 변경 예정)</li><li>HOURLY_LATEST: 1시간 동안 수집된 데이터 중 가장 나중에 수집된 미터링 데이터의 합</li><li>DAILY_MAX: 일 최대값의 합</li><li>MONTHLY_MAX: 월 최대값</li><li>STATUS: 사용 현황</li><ul> |
|   description | String| No | 카운터 설명  |
|   displayOrder | Integer| Yes | 노출 순서  |
|   marketPlaceMandatoryUsePeriod | Integer| No | 마켓플레이스 필수 사용 기간  |
|   meterUnitCode | String| Yes | 서비스에서 미터링 저장 시 사용량 단위<br>BYTES, KB, MB, GB, TB, CORE, HOURS, MINUTE, USERS, MAU, MAD, DAU, CALLS, COUNTS, CCU, SECONDS |
|   minUsage | BigDecimal| Yes | 최소 사용량  |
|   parentCounterName | String| Yes | 부모 카운터 이름  |
|   productId | String| Yes | 상품 아이디  |
|   productMetadataStatusCode | String| Yes | 카운터 상태 코드  STABLE, CLOSED |
|   productUiId | String| Yes | 홈페이지 카테고리/홈페이지 서비스 식별 ID  |
|   regionTypeCode | String| Yes | 카운터네임이 소속된 리전 코드<br><ul><li>GLOBAL: Global 상품에 속한 카운터네임</li><li>NONE: GLOBAL과 동일한 의미</li><li>KR1: KR1 리전에 속한 카운터네임</li><li>KR2: KR2 리전에 속한 카운터네임</li><li>...: 해당 리전에 속한 카운터네임</li><ul>  |
|   unit | Long| Yes | 정산 단위  |
|   unitName | String| Yes | 청구서에 노출할 이름  |
|   usageAggregationUnitCode | String| No | 사용량 집계 단위<br>RESOURCE_ID, COUNTER_NAME |



#### 프로젝트 AppKey 조회
> GET "/v1/authentications/projects/{project-id}/project-appkeys"

프로젝트에서 사용 중인 프로젝트 AppKey 목록을 조회하는 API입니다.

##### 필요 권한
`Project.ProjectAppKey.List`

##### 요청 파라미터

| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | 조회 대상 프로젝트 ID | 


##### 응답 본문

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

###### 응답

| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | --------- | ------------ |
|   header | [공통 응답](#response)| Yes |
|   authenticationList | List&lt;ProjectAppKeyResponse>| No | 프로젝트 AppKey 목록 |

###### ProjectAppKeyResponse

| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------------- | ------------ |
|   authId | String| No | 내부적으로 관리하는 인증 수단 아이디  |
|   appKey | String| No | 콘솔에 노출되는 프로젝트 AppKey  |
|   authStatus | String| No | 인증 상태 코드(STABLE, STOP, BLOCKED) |
|   projectId | String| No | 프로젝트 ID |
|   lastUsedDatetime | Date| No | 마지막 사용 일시  |
|   modDatetime | Date| No | 삭제 일시  |
|   reIssueDatetime | Date| No | 재생성 일시  |
|   regDatetime | Date| No | 생성 일시  |


#### User Access Key ID 목록 조회
> GET "/v1/authentications/user-access-keys"

멤버의 User Access Key ID 목록을 조회하는 API입니다.

##### 필요 권한
NHN Cloud 회원이면 호출 가능한 API


##### 응답 본문

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
    "regDatetime": "2000-01-23T04:56:07.000+00:00"
  } ]
}
```


###### 응답


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [공통 Response](#response)| Yes   |
|   authentications | List&lt;UserAccessKeyResponse>| No | 인증 정보 목록  |

###### UserAccessKeyResponse

| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------------- | ------------ |
|   authId | String| No | 내부적으로 관리하는 인증 수단 아이디  |
|   userAccessKeyID | String| No | User Access Key ID  |
|   secretAccessKey | String| No | 비밀 키(마스킹 처리됨)  |
|   authStatus | String| No | 인증 상태 코드(STABLE, STOP, BLOCKED) |
|   uuid | String| No | 사용자 UUID |
|   lastUsedDatetime | Date| No | 마지막 사용 일시  |
|   modDatetime | Date| No | 삭제 일시  |
|   reIssueDatetime | Date| No | 재생성 일시  |
|   regDatetime | Date| No | 생성 일시  |
|   tokenExpiryPeriod | Long| No | 토큰 만료 주기(초 단위)  |



#### 프로젝트 AppKey 등록
> POST "/v1/authentications/projects/{project-id}/project-appkeys"

프로젝트에서 사용할 AppKey를 생성하는 API입니다.

##### 필요 권한
`Project.ProjectAppKey.Create`


##### 요청 파라미터

| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
| Path | project-id | String| Yes | AppKey를 등록할 프로젝트 ID |
| Request Body | request | AddProjectAppKeyRequest| Yes | 요청 |

###### AddProjectAppKeyRequest

| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ----------- | ------------ |
|   appkeyAlias | String | Yes   | 프로젝트 AppKey 별칭<br>100자 제한 |


##### 응답 본문

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

###### 응답

| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [공통 Response](#response)| Yes   |
|   authentication | ResponseProtocol| No  |

###### ResponseProtocol


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ----- | ------------ |
|   authId | String| No | 내부적으로 관리하는 인증 수단 아이디  |
|   appKey | String| No | 프로젝트 AppKey |


#### User Access Key ID 등록
> POST "/v1/authentications/user-access-keys"

멤버의 User Access Key ID를 등록하는 API입니다.

##### 필요 권한
NHN Cloud 회원이면 호출 가능한 API

##### 요청 파라미터

| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
| Request Body | PostUserAppKeyRequest | PostUserAppKeyRequest| Yes |  | |


###### PostUserAppKeyRequest

| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------------- | ------------ |
|   tokenExpiryPeriod | Long| No | 토큰 만료 기간<br>초 단위이며, 기본값은 하루 |


##### 응답 본문

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

###### 응답

| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [공통 Response](#response)| Yes   |
|   authentication | ResponseProtocol| No  |

###### ResponseProtocol


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ----- | ------------ |
|   authId | String| No | 내부적으로 관리하는 인증 수단 아이디  |
|   userAccessKeyID | String| No | User Access Key ID  |
|   secretAccessKey | String| No | 비밀키 |
|   tokenExpiryPeriod | Long| No | 토큰 만료 기간(초 단위) |



#### 프로젝트 AppKey 삭제
> DELETE "/v1/authentications/projects/{project-id}/project-appkeys/{app-key}"

프로젝트 AppKey를 삭제하는 API입니다.

##### 필요 권한
`Project.ProjectAppKey.Delete`


##### 요청 파라미터


| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
| Path | project-id | String| Yes | 대상 프로젝트 ID |
|  Path |app-key | String| Yes | 삭제할 프로젝트 AppKey | 


##### 응답 본문

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```
###### 응답

| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [공통 Response](#response)| Yes   |



#### User Access Key ID 비밀 키 재발급
> PUT "/v1/authentications/user-access-keys/{user-access-key-id}/secretkey-reissue"

User Access Key ID의 비밀 키를 재발급하는 API입니다.


### 필요 권한
`Project.ProjectAppKey.UpdateSecretKey`

##### 요청 파라미터

| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |user-access-key-id | String| Yes | User Access Key ID | 


##### 응답 본문

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

###### 응답


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | --------- | ------------ |
|   header | [공통 응답](#response)| Yes |
|   authentication | ResponseProtocol| No  |

###### ResponseProtocol


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ----------- | ------------ |
|   secretAccessKey | String| Yes   | 비밀키 |


#### User Access Key ID 상태 수정
> PUT "/v1/authentications/user-access-keys/{user-access-key-id}"

멤버의 User Access Key ID 상태를 변경하는 API입니다.

##### 요청 파라미터


| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path | user-access-key-id | String| Yes | User Acess Key ID | 
| Request Body | request | UpdateUserAccessKeyStatusRequest| Yes | 요청 |


###### UpdateUserAccessKeyStatusRequest

| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------------- | ------------ |
|   status | String| Yes | 변경할 프로젝트 AppKey 상태(STOP: 중지, STABLE: 사용) |


##### 응답 본문

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### 응답

| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [공통 Response](#response)| Yes   |


#### User Access Key ID 삭제
> DELETE "/v1/authentications/user-access-keys/{user-access-key-id}"

User Access Key ID를 삭제하는 API입니다.


##### 필요 권한
`Project.ProjectAppKey.Delete`

##### 요청 파라미터

| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path | user-access-key-id | String| Yes | User Access Key ID | 


##### 응답 본문

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```


##### 응답 본문

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### 응답


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------- | ------------ |
|   header | [공통 응답](#response)| Yes |


### 오류 코드

| 결과 코드 | 설명                                                                                  | 조치                                                      |
| ---------- |-------------------------------------------------------------------------------------|---------------------------------------------------------|
| 80007 | 만료되었거나 존재하지 않는 토큰을 사용해서 호출한 경우 발생하는 오류                                          | 새로운 토큰을 발급하여 사용                                         |
| -6 | 권한 없는 호출자가 호출한 경우에 발생하는 오류                                                      | 호출자에게 적절한 권한을 부여                                        |
| -8 | 조직 IP ACL 정책에 의해 IP 검증이 실패한 경우 발생하는 오류                                              | 조직 IP ACL에 해당 IP가 등록되었는지 확인                            |
| 404 | 없는 API 호출 시 발생                                                                       | 호출하는 API의 httpmethod,uri를 확인                            |
| 400<br>501<br>502<br>503<br>504<br>505 | 요청 파라미터가 적절하지 않을 때 발생하는 오류                                                          | 요청 파라미터의 필수값 및 설정 가능한 값 등을 확인                           |
| 500 | 비정상 시스템 오류                                                                          | 담당자에게 문의                                            |
| 1000 | 파라미터가 잘못될 경우 발생하는 오류 <br> 조직 IAM 멤버 API - `IAM 멤버 비밀번호 변경 이메일 전송` 요청 값 returnUrl 이 허가된 도메인이 아닐 때 발생(허가된 도메인: toast.com, dooray.com, nhncloud.com) | 요청 파라미터 확인                                              |
| 1201 | 서버 내부적인 API 요청이 실패하여 발생하는 오류 |  오류 메시지에 포함된 오류 메시지와 코드를 바탕으로 해결<br>포함된 오류 메시지와 코드만으로는 해결이 어려울 경우 담당자에게 문의                      |
| 10005<br>70008<br>1104 | 요청 파라미터가 적절하지 않을 때 발생하는 오류 | 요청 파라미터의 필수값 및 설정 가능한 값 등을 확인 |
| 10009 | 조직 또는 프로젝트에 존재하지 않은 역할을 부여할 때 발생하는 오류                                               | 멤버에게 존재하는 역할을 부여하도록 변경                                  |
| 10010 | 역할 그룹 삭제 시, 프로젝트 멤버(초대중인 멤버 포함)에 해당 역할 그룹만 부여된 경우 발생하는 오류<br>프로젝트 멤버 역할 변경 시, 아무 역할도 부여하지 않을 때 발생하는 오류| 1) 삭제하려는 역할 그룹`만` 가진 프로젝트 멤버 멤버(초대중인 멤버 포함)들의 역할을 다른 역할로 변경 또는 해당 멤버들 삭제 <br> 2) 프로젝트 멤버 역할 변경 시, 요청에 역할에 대한 값을 설정하여 요청 |
| 10012 | 프로젝트 멤버 삭제 시, 해당 멤버가 삭제되면서 해당 프로젝트에 ADMIN 역할을 가진 멤버가 더 이상 존재하지 않을 경우 발생하는 오류        | 1) 삭제 대상이 아닌 다른 프로젝트 멤버에게 ADMIN 역할 부여 <br>2) ADMIN 역할이 아닌 대상을 삭제|
| 12100 | 프로젝트 멤버가 존재하지 않을 때 발생하는 오류                                                          | 존재하는 프로젝트 멤버 UUID 사용                                    |
| 12107 | 요청 uuid와 대상 uuid가 동일한 것이 허용되지 않는 API에서 동일할 경우 발생하는 오류                              | 대상 uuid와 요청 uuid를 다르게 설정                               |
| 12400 | 존재하지 않거나 삭제된 프로젝트에 멤버를 추가할 경우 발생하는 오류                                               | 존재하는 프로젝에 멤버 추가하도록 변경                                  |
| 12401 | 프로젝트 생성 시, 해당 프로젝트의 조직 OWNER 계정에 설정된 프로젝트 생성 개수 제한을 초과했을 경우 발생하는 오류                    | 1) 사용하지 않는 프로젝트를 삭제하여 생성 가능한 프로젝트 수 확보 <br>2) 담당자를 통해 프로젝트 최대 생성 개수 조정 요청 |
| 12500 | 프로젝트 삭제 시, 사용 중인 서비스가 존재할 때 발생하는 오류                                                  | 해당 프로젝트의 사용 중인 서비스 전부 비활성화 처리 후 프로젝트 삭제 처리 시도             |
| 13001 | 서비스 활성화/비활성화 실패 시 발생하는 오류                                                           | 담당자에게 문의                                           |
| 13002 | 이미 활성화 상태인 서비스를 다시 활성화했을 경우 발생하는 오류                                    | 기존에 활성화된 서비스를 활용              |
| 13004 | 활성화 불가능한 서비스를 활성화했을 경우 발생하는 오류                                                     | 활성화 가능한 서비스에 대해 활성화                                    |
| 13006 | 법인 전용 서비스 활성화, 조직 OWNER의 멤버 타입이 법인이 아닐 경우 발생하는 오류                                    | 법인 계정 타입을 가진 조직 OWNER의 조직 하위 프로젝트에서 서비스 활성화 시도             |
| 22006 | 추가 시 이미 존재하는 경우 발생 | 중복된 요청이 오지 않도록 처리 |
| 22013 | 조직 OWNER의 역할을 변경 시도했을 때 발생하는 오류                                                        | 조직 오너를 대상으로 역할 변경은 불가능                                |
| 22016 | 조직이 존재하지 않을 때 발생하는 오류                                                              | 존재하는 조직의 orgId로 요청하는지 확인                              |
| 23005 | 조직 ID에 해당하는 조직이 존재하지 않을 때 발생하는 오류                                                   | 담당자 문의                                             |
| 30015 | 프로젝트 AppKey의 생성 제한 횟수를 초과할 경우 발생하는 오류 <br> 프로젝트 AppKey API - `프로젝트 AppKey 생성`에서 생성되는 프로젝트 AppKey의 생성 가능 횟수는 3개이며 3개를 초과할 경우 오류 발생 | 사용하지 않은 프로젝트 AppKey 삭제 후 재시도                               |
| 40017 | 프로젝트가 존재하지 않을 경우 발생하는 오류                                                           | 존재하는 프로젝트에 대해 API 요청                                   |
| 40028<br>13003 | 프로젝트가 존재하지 않을 경우(생성했다가 삭제한 경우) 발생하는 오류                                              | 존재하는 프로젝트에 대해 API 요청                                   |
| 40054 | 서비스 활성화 시, 먼저 활성화되어야 하는 서비스가 활성화 되어있지 않은 경우 발생하는 오류                               | 먼저 활성화가 되어야 하는 서비스 활성화 처리                               |
| 40057 | 서비스 비활성화 시, 먼저 비활성화 되어야 하는 서비스가 비활성화 되어있지 않은 경우 발생하는 오류                            | 먼저 비활성화가 되어야 하는 서비스 비활성화 처리                              |
| 50007 | 유효하지 않은 멤버일 때, 발생하는 오류<br>(존재하지 않는 멤버이거나, 휴면 및 탈퇴 상태의 멤버는 유효하지 않음)<br>조직 생성 API - API 호출 시, uuid가 유효하지 않을 경우 | 유효한 멤버의 uuid로 수정                                 |
| 60003 | DB에 데이터가 없을 경우 발생하는 오류<br>프로젝트 AppKey API - `프로젝트 AppKey 삭제` 에서 삭제할 AppKey가 없을 경우 발생하는 오류 | 1) 담당자 문의 <br>2) 존재하는 AppKey를 삭제 대상 AppKey 값으로 설정  |
| 62004 | 역할 그룹 생성 시 동일한 이름의 역할 그룹이 존재하는 경우 발생하는 오류                                           | 중복되지 않은 이름으로 변경                                         |
| 62008 | 역할 그룹 수정, 삭제 및 역할 그룹에 역할 추가/삭제 시 역할 그룹 ID가 존재하지 않는 경우 발생                            | 존재하는 역할 그룹 ID를 사용하도록 변경                                |
| 62009 | 역할 그룹 생성 시 역할이 유효하지 않은 역할인 경우 발생                                                   | 유효한 역할을 사용하도록 변경                                       |
| 62011 | 역할 그룹 삭제 시 알림 그룹에서 사용 중이어서 발생                                                        | 알림 그룹 삭제 후 역할 그룹을 삭제하도록 변경                              |
| 62014 | 역할 그룹 삭제 및 역할 그룹에 역할 추가/삭제 시 역할 그룹을 할당했던 멤버들이 역할을 서비스에 통지하는데 실패                       | 담당자에게 문의                                            |
| 62019 | 조직 멤버에게 허용되지 않는 역할을 부여하려는 경우                      | 담당자에게 문의                                            |
| 72005 | 빌링 관련 API 호출이 실패할 때 발생하는 오류                                                         | 담당자에게 문의                                            |
| 70013 | 이용 중인 서비스가 존재할 때 발생하는 오류                                                             | 이용 중인 서비스 비활성화                                           |
| 70014 | 멤버 탈퇴 조건을 만족하지 않을 경우 발생하는 오류<br> IAM - 1) 사용 중인 서비스가 있을 때 2) 삭제되지 않은 프로젝트가 있을 때 3) 해당 멤버가 임의의 프로젝트에 ADMIN 역할로 존재할 때| 각 멤버 타입에 맞는 탈퇴 조건을 만족하도록 설정                          |
| 70024 | 결제 수단이 정상적으로 등록되지 않았을 때 발생하는 오류                                                     | 결제수단 등록                                                 |
| 70032 | 미납으로 인해 멤버 블록이 되었을 경우 발생하는 오류                                                       | 해당 계정이 가진 미납 청구서 결제                                     |
| -200201 | user-code 길이 조건이 맞지 않는 경우 발생하는 오류                                                           | 20자 이내의 소문자, 숫자, 특수문자(-, _, .) 사용 가능.<br>특수문자(-, _, .)는 제일 앞과 제일 뒤에는 사용할 수 없음.|
| -200202 | user-code 포맷 조건이 맞지 않는 경우 발생하는 오류                                                | 소문자, 숫자, 특수문자(-, _, .) 사용 가능.<br>특수문자(-, _, .)는 제일 앞과 제일 뒤에는 사용할 수 없음.|
| -200203 | 이름 길이 조건이 맞지 않는 경우 발생하는 오류                                                       | 60자 이내의 길이 요건을 만족하도록 이름 길이 수정                           |
| -200204 | 멤버 생성 수정시 user-code가 겹치는 경우 발생하는 오류                                                | 중복되지 않는 user-code로 변경하여 요청                             |