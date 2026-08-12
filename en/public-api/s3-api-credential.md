<!-- pre-align:aligned sig=3b7c984c2dfe -->

# S3 API Credentials

**NHN Cloud > Public API User Guide > Authentication Methods > S3 API Credentials**

S3 API credentials are AWS EC2-format authentication keys used to call the service APIs that support the Amazon S3 Compatible API in NHN Cloud. They consist of an Access Key and a Secret Key, and are used as the authentication method when calling the S3 compatible API. You can issue S3 API credentials directly from the NHN Cloud console or through the API.


!!! danger "Caution"
    * S3 API credentials use a fixed-key authentication method with no expiration date. If a key is exposed externally, anyone can use the leaked key to access resources.
    * Store keys securely so that they are not included in external storage or code. If a leak is suspected, delete the credentials immediately, and then reissue them.
    * If the user who issued the S3 API credentials loses access permission to the project, or if the user's account is deleted after withdrawing from NHN Cloud, the credentials expire immediately and can no longer be used.


!!! tip "Note"
    Up to 3 S3 API credentials can be issued per project for each user.


<a id="issue-s3-api-credentials"></a>
## Issue S3 API Credentials { #issue-s3-api-credentials }

<a id="issue-via-console"></a>
### Issue via Console { #issue-via-console }

You can issue S3 API credentials from the console of a service that supports the Amazon S3 Compatible API. When issuing credentials from the console, the Secret Key can only be checked immediately after issuance, so be sure to store it separately. For more information, see the console guide for each service.

<a id="issue-via-api"></a>
### Issue via API { #issue-via-api }

To obtain credentials using the API, an authentication token is required. To obtain the authentication token, refer to [IaaS Token](/nhncloud/en/public-api/iaas-token/).

```
POST https://api-identity-infrastructure.nhncloudservice.com/v2.0/users/{api-user-id}/credentials/OS-EC2

Content-Type: application/json
X-Auth-Token: {token-id}
```

<a id="issue-via-api-request"></a>
#### Request

| Name | Category | Type | Required | Description |
| --- | --- | --- | --- | --- |
| api-user-id | URL | String | O | API user ID |
| tenant_id | Body | String | O | Tenant ID found in **API Endpoint Settings** of the console for the service to use |


<details><summary>Example</summary>
<p>

```json
{
    "tenant_id": "84c9e9a51aea402e95389c08ac562ac5"
}
```

</p>
</details>


<a id="issue-via-api-response"></a>
#### Response

| Name | Type | Property | Description |
| --- | --- | --- | --- |
| access | Body | String | Access key of the S3 API credentials |
| secret | Body | String | Secret key of the S3 API credentials |
| user_id | Body | String | API user ID |
| tenant_id | Body | String | Tenant ID |
| created_at | Body | String | Creation time of the S3 API credentials |
| accessed_at | Body | String | Last access time of the S3 API credentials |


<details><summary>Example</summary>
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
## Get S3 API Credentials { #get-s3-api-credentials }

Retrieves a list of issued S3 API credentials.

```
GET https://api-identity-infrastructure.nhncloudservice.com/v2.0/users/{user-id}/credentials/OS-EC2

X-Auth-Token: {token-id}
```

<a id="get-s3-api-credentials-request"></a>
#### Request

| Name | Category | Type | Required | Description |
| --- | --- | --- | --- | --- |
| user-id | URL | String | O | API user ID |
| X-Auth-Token | Header | String | O | Issued authentication token ID |


<a id="get-s3-api-credentials-response"></a>
#### Response

| Name | Type | Property | Description |
| --- | --- | --- | --- |
| access | Body | String | Access key of the S3 API credentials |
| secret | Body | String | Secret key of the S3 API credentials |
| user_id | Body | String | API user ID |
| tenant_id | Body | String | Tenant ID |
| created_at | Body | String | Creation time of the S3 API credentials |
| accessed_at | Body | String | Last access time of the S3 API credentials |


<details><summary>Example</summary>
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
## Delete S3 API Credentials { #delete-s3-api-credentials }

Deletes the issued S3 API credentials. If a leak is suspected, delete the credentials, and then reissue them.

```
DELETE https://api-identity-infrastructure.nhncloudservice.com/v2.0/users/{user-id}/credentials/OS-EC2/{access}

X-Auth-Token: {token-id}
```

<a id="delete-s3-api-credentials-request"></a>
#### Request

| Name | Category | Type | Required | Description |
| --- | --- | --- | --- | --- |
| user-id | URL | String | O | API user ID |
| access | URL | String | O | S3 API Access Key to delete |
| X-Auth-Token | Header | String | O | Issued authentication token ID |


<a id="use-s3-api-credentials"></a>
## Use S3 API Credentials { #use-s3-api-credentials }

S3 API credentials are used for authentication with the AWS Signature Version 4 signing method when calling the S3 compatible API. You can call the S3 compatible API by configuring the issued Access Key and Secret Key in an AWS SDK or an S3 compatible client. For more information about how to use, see the S3 compatible API guide for each service.
