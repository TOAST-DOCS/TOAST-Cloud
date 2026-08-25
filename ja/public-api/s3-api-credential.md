<!-- pre-align:aligned sig=3b7c984c2dfe -->

# S3 API 認証情報

**NHN Cloud > Public API 使用ガイド > API 認証方式 > S3 API 認証情報**

S3 API 認証情報は、NHN CloudでAmazon S3互換APIをサポートするサービスAPIを使用するためのAWS EC2形式の認証キーです。Access KeyとSecret Keyで構成され、S3互換APIの呼び出し時に認証手段として使用されます。S3 API 認証情報は、NHN Cloudコンソールから直接発行するか、APIを使用して発行できます。


!!! danger "注意"
    * S3 API 認証情報は、有効期限のない固定キーベースの認証方式であり、キーが外部に公開された場合、流出したキーを利用して誰でもリソースにアクセスできます。
    * キーは、外部リポジトリやコードに含まれないように安全に保管し、流出が疑われる場合は、即座に該当の認証情報を削除して再発行する必要があります。
    * S3 API 認証情報の発行を受けたユーザーがプロジェクトへのアクセス権限を失うか、NHN Cloudを退会してアカウントが削除されると、該当の認証情報は即座に期限切れとなり使用できなくなります。


!!! tip "ポイント"
    S3 API 認証情報は、ユーザーごとにプロジェクトあたり最大3個まで発行できます。


<a id="issue-s3-api-credentials"></a>
## S3 API 認証情報の発行 { #issue-s3-api-credentials }

<a id="issue-via-console"></a>
### コンソールからの発行 { #issue-via-console }

Amazon S3互換APIをサポートするサービスコンソールから、S3 API 認証情報を発行できます。コンソールから発行する場合、Secret Keyは発行直後にのみ確認できるため、必ず別途保管してください。詳細は、各サービスのコンソールガイドを参照してください。

<a id="issue-via-api"></a>
### APIでの発行 { #issue-via-api }

APIを利用してS3 API 認証情報を発行するには、認証トークンが必要です。認証トークンの発行方法は、[IaaS トークン](/nhncloud/ko/public-api/iaas-token/)を参照してください。

```
POST https://api-identity-infrastructure.nhncloudservice.com/v2.0/users/{api-user-id}/credentials/OS-EC2

Content-Type: application/json
X-Auth-Token: {token-id}
```

<a id="issue-via-api-request"></a>
#### リクエスト

| 名前 | 区分 | タイプ | 必須 | 説明 |
| --- | --- | --- | --- | --- |
| api-user-id | URL | String | O | API ユーザーID |
| tenant_id | Body | String | O | 使用するサービスコンソールの **API エンドポイント設定**で確認したテナントID |


<details><summary>例</summary>
<p>

```json
{
    "tenant_id": "84c9e9a51aea402e95389c08ac562ac5"
}
```

</p>
</details>


<a id="issue-via-api-response"></a>
#### レスポンス

| 名前 | 種類 | プロパティ | 説明 |
| --- | --- | --- | --- |
| access | Body | String | S3 API 認証情報のアクセスキー |
| secret | Body | String | S3 API 認証情報のシークレットキー |
| user_id | Body | String | API ユーザーID |
| tenant_id | Body | String | テナントID |
| created_at | Body | String | S3 API 認証情報の作成時間 |
| accessed_at | Body | String | S3 API 認証情報の最終アクセス時間 |


<details><summary>例</summary>
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
## S3 API 認証情報の照会 { #get-s3-api-credentials }

発行されたS3 API 認証情報の一覧を照会します。

```
GET https://api-identity-infrastructure.nhncloudservice.com/v2.0/users/{user-id}/credentials/OS-EC2

X-Auth-Token: {token-id}
```

<a id="get-s3-api-credentials-request"></a>
#### リクエスト

| 名前 | 区分 | タイプ | 必須 | 説明 |
| --- | --- | --- | --- | --- |
| user-id | URL | String | O | API ユーザーID |
| X-Auth-Token | Header | String | O | 発行された認証トークンID |


<a id="get-s3-api-credentials-response"></a>
#### レスポンス

| 名前 | 種類 | プロパティ | 説明 |
| --- | --- | --- | --- |
| access | Body | String | S3 API 認証情報のアクセスキー |
| secret | Body | String | S3 API 認証情報のシークレットキー |
| user_id | Body | String | API ユーザーID |
| tenant_id | Body | String | テナントID |
| created_at | Body | String | S3 API 認証情報の作成時間 |
| accessed_at | Body | String | S3 API 認証情報の最終アクセス時間 |


<details><summary>例</summary>
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
## S3 API 認証情報の削除 { #delete-s3-api-credentials }

発行されたS3 API 認証情報を削除します。流出が疑われる場合は、該当の認証情報を削除してから新たに発行してください。

```
DELETE https://api-identity-infrastructure.nhncloudservice.com/v2.0/users/{user-id}/credentials/OS-EC2/{access}

X-Auth-Token: {token-id}
```

<a id="delete-s3-api-credentials-request"></a>
#### リクエスト

| 名前 | 区分 | タイプ | 必須 | 説明 |
| --- | --- | --- | --- | --- |
| user-id | URL | String | O | API ユーザーID |
| access | URL | String | O | 削除するS3 API Access Key |
| X-Auth-Token | Header | String | O | 発行された認証トークンID |


<a id="use-s3-api-credentials"></a>
## S3 API 認証情報の使用 { #use-s3-api-credentials }

S3 API 認証情報は、S3互換APIの呼び出し時にAWS Signature Version 4 署名方式で認証に使用されます。発行されたAccess KeyとSecret KeyをAWS SDKまたはS3互換クライアントに設定することで、S3互換APIを呼び出すことができます。詳細な使用方法は、各サービスのS3互換APIガイドを参照してください。
