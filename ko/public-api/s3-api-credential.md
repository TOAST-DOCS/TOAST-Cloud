<!-- pre-align:aligned sig=3b7c984c2dfe -->

# S3 API 자격 증명

**NHN Cloud > Public API 사용 가이드 > API 인증 방식 > S3 API 자격 증명**

S3 API 자격 증명은 NHN Cloud에서 Amazon S3 호환 API를 지원하는 서비스 API를 사용하기 위한 AWS EC2 형식의 인증 키입니다. Access Key와 Secret Key로 구성되며, S3 호환 API 호출 시 인증 수단으로 사용됩니다. S3 API 자격 증명은 NHN Cloud 콘솔에서 직접 발급하거나 API를 통해 발급할 수 있습니다.


!!! danger "주의"
    * S3 API 자격 증명은 유효 기간이 없는 고정 키 기반 인증 방식으로 키가 외부에 노출될 경우 누구나 유출된 키를 이용하여 리소스에 접근할 수 있습니다.
    * 키는 외부 저장소 또는 코드에 포함되지 않도록 안전하게 보관하고, 유출이 의심될 경우 즉시 해당 자격 증명을 삭제한 뒤 재발급해야 합니다.
    * S3 API 자격 증명을 발급받은 사용자가 프로젝트에 대한 접근 권한을 잃거나 NHN Cloud를 탈퇴하여 계정이 삭제되면 해당 자격 증명은 즉시 만료되어 사용할 수 없습니다.


!!! tip "알아두기"
    S3 API 자격 증명은 사용자별로 프로젝트당 최대 3개까지 발급할 수 있습니다.


<a id="issue-s3-api-credentials"></a>
## S3 API 자격 증명 발급하기 { #issue-s3-api-credentials }

<a id="issue-via-console"></a>
### 콘솔에서 발급하기 { #issue-via-console }

Amazon S3 호환 API를 지원하는 서비스 콘솔에서 S3 API 자격 증명을 발급할 수 있습니다. 콘솔에서 발급할 경우 Secret Key는 발급 직후에만 확인할 수 있으므로 반드시 별도로 보관하세요. 자세한 내용은 각 서비스의 콘솔 가이드를 참고하세요.

<a id="issue-via-api"></a>
### API로 발급하기 { #issue-via-api }

API를 이용해 S3 API 자격 증명을 발급하려면 인증 토큰이 필요합니다. 인증 토큰 발급 방법은 [IaaS 토큰](/nhncloud/ko/public-api/iaas-token/)을 참고하세요.

```
POST https://api-identity-infrastructure.nhncloudservice.com/v2.0/users/{api-user-id}/credentials/OS-EC2

Content-Type: application/json
X-Auth-Token: {token-id}
```

<a id="issue-via-api-request"></a>
#### 요청

| 이름 | 구분 | 타입 | 필수 | 설명 |
| --- | --- | --- | --- | --- |
| api-user-id | URL | String | O | API 사용자 ID |
| tenant_id | Body | String | O | 사용할 서비스 콘솔의 **API 엔드포인트 설정**에서 확인한 테넌트 ID |


<details><summary>예시</summary>
<p>

```json
{
    "tenant_id": "84c9e9a51aea402e95389c08ac562ac5"
}
```

</p>
</details>


<a id="issue-via-api-response"></a>
#### 응답

| 이름 | 종류 | 속성 | 설명 |
| --- | --- | --- | --- |
| access | Body | String | S3 API 자격 증명 접근 키 |
| secret | Body | String | S3 API 자격 증명 비밀 키 |
| user_id | Body | String | API 사용자 ID |
| tenant_id | Body | String | 테넌트 ID |
| created_at | Body | String | S3 API 자격 증명 생성 시간 |
| accessed_at | Body | String | S3 API 자격 증명 마지막 접근 시간 |


<details><summary>예시</summary>
<p>

```json
{
    "credential": {
        "access": "253a3c7ca27f4731a9c757addfac29ca",
        "tenant_id": "84c9e9a51aea402e95389c08ac562ac5",
        "secret": "be057f235abf45ee8e2ba14edc5fb253",
        "user_id": "84db0c80-3c39-11e7-b29c-005056ac1497",
        "created_at": "2024-10-19T08:24:46.000000Z",
        "accessed_at": "2024-10-19T08:24:46.000000Z"
    }
}
```

</p>
</details>


<a id="get-s3-api-credentials"></a>
## S3 API 자격 증명 조회하기 { #get-s3-api-credentials }

발급된 S3 API 자격 증명 목록을 조회합니다.

```
GET https://api-identity-infrastructure.nhncloudservice.com/v2.0/users/{user-id}/credentials/OS-EC2

X-Auth-Token: {token-id}
```

<a id="get-s3-api-credentials-request"></a>
#### 요청

| 이름 | 구분 | 타입 | 필수 | 설명 |
| --- | --- | --- | --- | --- |
| user-id | URL | String | O | API 사용자 ID |
| X-Auth-Token | Header | String | O | 발급받은 인증 토큰 ID |


<a id="get-s3-api-credentials-response"></a>
#### 응답

| 이름 | 종류 | 속성 | 설명 |
| --- | --- | --- | --- |
| access | Body | String | S3 API 자격 증명 접근 키 |
| secret | Body | String | S3 API 자격 증명 비밀 키 |
| user_id | Body | String | API 사용자 ID |
| tenant_id | Body | String | 테넌트 ID |
| created_at | Body | String | S3 API 자격 증명 생성 시간 |
| accessed_at | Body | String | S3 API 자격 증명 마지막 접근 시간 |


<details><summary>예시</summary>
<p>

```json
{
    "credentials": [
        {
            "access": "253a3c7ca27f4731a9c757addfac29ca",
            "tenant_id": "84c9e9a51aea402e95389c08ac562ac5",
            "secret": "be057f235abf45ee8e2ba14edc5fb253",
            "user_id": "84db0c80-3c39-11e7-b29c-005056ac1497",
            "created_at": "2024-10-19T08:24:46.000000Z",
            "accessed_at": "2024-10-19T08:30:42.000000Z"
        }
    ]
}
```

</p>
</details>


<a id="delete-s3-api-credentials"></a>
## S3 API 자격 증명 삭제하기 { #delete-s3-api-credentials }

발급된 S3 API 자격 증명을 삭제합니다. 유출이 의심되는 경우 해당 자격 증명을 삭제한 뒤 새로 발급하세요.

```
DELETE https://api-identity-infrastructure.nhncloudservice.com/v2.0/users/{user-id}/credentials/OS-EC2/{access}

X-Auth-Token: {token-id}
```

<a id="delete-s3-api-credentials-request"></a>
#### 요청

| 이름 | 구분 | 타입 | 필수 | 설명 |
| --- | --- | --- | --- | --- |
| user-id | URL | String | O | API 사용자 ID |
| access | URL | String | O | 삭제할 S3 API Access Key |
| X-Auth-Token | Header | String | O | 발급받은 인증 토큰 ID |


<a id="use-s3-api-credentials"></a>
## S3 API 자격 증명 사용하기 { #use-s3-api-credentials }

S3 API 자격 증명은 S3 호환 API 호출 시 AWS Signature Version 4 서명 방식으로 인증에 사용됩니다. 발급받은 Access Key와 Secret Key를 AWS SDK 또는 S3 호환 클라이언트에 설정하여 S3 호환 API를 호출할 수 있습니다. 자세한 사용 방법은 각 서비스의 S3 호환 API 가이드를 참고하세요.
