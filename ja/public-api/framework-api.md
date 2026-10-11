<!-- machine_translated: true -->

<!-- pre-align:aligned sig=252b1c33d7f4 -->

# フレームワークAPI

**NHN Cloud > Public API使用ガイド > フレームワークAPI**

<a id="overview"></a>
## 概要 { #overview }
以下で紹介するAPIを通じて、プロジェクトメンバーを作成したり、ロールを付与するなど、組織とプロジェクトを管理できます。
フレームワークAPIは、呼び出し時の認証/認可のためにUser Access Keyトークンを使用します。User Access Keyトークンは、User Access Keyに基づいて発行されるBearerタイプの一時的なアクセストークンです。User Access Keyトークンの発行及び使用に関する詳細は、[User Access Keyトークン](./user-access-key-token/)を参照してください。

<a id="public-api-domain"></a>
### Public APIドメイン { #public-api-domain }
`https://core.api.nhncloudservice.com/`

<a id="common"></a>
### 共通 { #common }

<a id="common-request"></a>
#### リクエスト
Public APIを呼び出す時、下記のRequest Headerを必ず含める必要があります。


| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
| Header |  x-nhn-authorization | String| Y | ユーザーが発行されたBearerタイプトークン |

<a id="common-response"></a>
#### レスポンス
Public APIの返却時、下記のヘッダ部分がレスポンス本文に含まれます。
```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   isSuccessful | Boolean | N | 成否 |
|   resultCode | Integer| N | 結果コード。成功した場合は0が返され、失敗した場合はエラーコードを返します。  |
|   resultMessage | String| N | 結果メッセージ |

<a id="common-type"></a>
#### 共通タイプ


| 名前 | タイプ | サイズ | 説明 | 
|------------ | ------------- | ------------- | ------------ |
| org-id | String | 16文字 | 組織ID |
| project-id | String | 8文字 | プロジェクトID |
| product-id | String | 8文字 | サービスID |
| user-access-key-id | String | 20文字 | User Access Key ID |
| project-app-key | String | 20文字 | プロジェクトのアプリキー |
| product-app-key | String | 16文字 | サービスのアプリキー |
| uuid | String | 36文字 | メンバーのUUID |


<a id="api"></a>
### API { #api }


!!! danger "注意"
    APIのレスポンスはガイドに明示されていないフィールドが追加される可能性があるため、新しいフィールドが追加されてもエラーが発生しないように開発する必要があります。<br>また、DB保存時、カラムサイズが変更される可能性があるため、余裕を持って設定する必要があります。


| メソッド | HTTPリクエスト | 説明 |
|------------- | ------------- | -------------|
| POST |[/v1/projects/{project-id}/members](#create-a-project-member) | プロジェクトメンバー作成 |
| POST |[/v1/organizations/{org-id}/projects](#add-a-project) | プロジェクト追加 |
| DELETE |[/v1/projects/{project-id}/members/{target-uuid}](#delete-a-single-project-member) | プロジェクトメンバー単件削除 |
| DELETE |[/v1/projects/{project-id}](#delete-a-project) | プロジェクト削除 |
| DELETE |[/v1/projects/{project-id}/products/{product-id}/disable](#end-a-project-service) | プロジェクトサービス終了 |
| POST |[/v1/projects/{project-id}/products/{product-id}/enable](#use-a-service-product) | プロジェクトサービス利用 |
| GET |[/v1/organizations/{org-id}/roles](#list-organization-roles) | 組織ロールリスト照会 |
| GET |[/v1/projects/{project-id}/roles](#list-project-roles) | プロジェクトロールリスト照会 |
| GET |[/v1/organizations/{org-id}/domains](#search-for-an-organization-domain) | 組織ドメイン検索 |
| GET |[/v1/organizations/{org-id}/members/{member-uuid}](#view-a-organization-member) | 組織メンバー単件照会 |
| POST |[/v1/organizations/{org-id}/members/search](#list-organization-members) | 組織メンバーリスト照会 |
| GET |[/v1/organizations/{org-id}/project-role-groups](#view-all-common-role-groups-for-projects-in-the-organization) | 組織のプロジェクト共通ロールグループ全体照会 |
| GET |[/v1/product-uis/hierarchy](#view-service-hierarchy) | サービス階層構造照会 |
| GET |[/v1/projects/{project-id}/products/{product-id}](#view-a-service-used-in-the-project) | プロジェクトで使用中のサービス照会 |
| GET |[/v1/projects/{project-id}/members/{member-uuid}](#view-a-project-member) | プロジェクトメンバー単件照会 |
| POST |[/v1/projects/{project-id}/members/search](#list-project-members) | プロジェクトメンバーリスト照会 |
| GET |[/v1/projects/{project-id}/project-role-groups/{role-group-id}](#view-a-project-role-group) | プロジェクトロールグループ単件照会 |
| GET |[/v1/organizations/{org-id}/project-role-groups/{role-group-id}](#view-a-common-role-group-for-the-project-in-the-organization) | 組織のプロジェクト共通ロールグループ単件照会 |
| GET |[/v1/projects/{project-id}/project-role-groups](#view-all-project-role-groups) | プロジェクトロールグループ全体照会 |
| GET |[/v1/organizations/{org-id}/projects](#list-projects-in-your-organization) | 組織に属するプロジェクトリスト照会 |
| GET |[/v1/organizations/{org-id}/governances](#list-organization-governance-in-use) | 使用中の組織ガバナンスリスト照会 |
| POST |[/v1/organizations/{org-id}/project-role-groups](#create-a-common-role-group-for-projects-in-the-organization) | 組織のプロジェクト共通ロールグループ作成 |
| DELETE |[/v1/organizations/{org-id}/project-role-groups](#delete-a-project-common-role-group-in-the-organization) | 組織のプロジェクト共通ロールグループ削除 |
| PUT |[/v1/organizations/{org-id}/project-role-groups/{role-group-id}/infos](#modify-your-organizations-project-common-role-group-information) | 組織のプロジェクト共通ロールグループ情報修正 |
| PUT |[/v1/organizations/{org-id}/project-role-groups/{role-group-id}/roles](#modify-your-organizations-project-common-roles-group-roles) | 組織のプロジェクト共通ロールグループロール修正 |
| POST |[/v1/projects/{project-id}/project-role-groups](#create-a-project-role-group) | プロジェクトロールグループ作成 |
| DELETE |[/v1/projects/{project-id}/project-role-groups](#delete-a-project-role-group) | プロジェクトロールグループ削除 |
| PUT |[/v1/projects/{project-id}/project-role-groups/{role-group-id}/infos](#edit-project-role-group-information) | プロジェクトロールグループ情報修正 |
| PUT |[/v1/projects/{project-id}/project-role-groups/{role-group-id}/roles](#modify-project-role-group-roles) | プロジェクトロールグループロール修正 |
| GET |[/v1/organizations/{org-id}/org-role-groups](#view-all-organization-role-groups) | 組織ロールグループ全体照会 |
| GET |[/v1/organizations/{org-id}/org-role-groups/{role-group-id}](#view-a-single-organization-role-group) | 組織ロールグループ単件照会 |
| POST |[/v1/organizations/{org-id}/org-role-groups](#create-organization-role-group) | 組織ロールグループ作成 |
| DELETE |[/v1/organizations/{org-id}/org-role-groups](#delete-organization-role-group) | 組織ロールグループ削除 |
| PUT |[/v1/organizations/{org-id}/org-role-groups/{role-group-id}/infos](#modify-organization-role-group-information) | 組織ロールグループ情報修正 |
| PUT |[/v1/organizations/{org-id}/org-role-groups/{role-group-id}/roles](#modify-an-organization-role-groups-role) | 組織ロールグループロール修正 |
| PUT |[/v1/organizations/{org-id}/members/{member-uuid}](#modify-organization-member-roles) | 組織メンバーロール修正 |
| PUT |[/v1/projects/{project-id}/members/{member-uuid}](#modify-project-member-roles) | プロジェクトメンバーロール修正 |
| GET |[/v1/iam/organizations/{org-id}/members/{member-uuid}](#view-organization-iam-members) | 組織IAMアカウント単件照会 |
| GET |[/v1/iam/organizations/{org-id}/members](#list-organization-iam-members) | 組織IAMアカウントリスト照会 |
| POST |[/v1/iam/organizations/{org-id}/members](#add-an-organization-iam-member) | 組織IAMアカウント追加 |
| POST |[/v1/iam/organizations/{org-id}/members/{member-id}/send-password-setup-mail](#send-an-iam-member-password-change-email) | IAMアカウントパスワード変更メール送信 |
| PUT |[/v1/iam/organizations/{org-id}/members/{member-uuid}](#modify-organization-iam-member-information) | 組織IAMアカウント情報修正 |
| POST |[/v1/iam/organizations/{org-id}/members/{member-id}/set-password](#change-an-organization-iam-member-password) | 組織IAMアカウントパスワード変更 |
| GET |[/v1/iam/organizations/{org-id}/settings/session](#view-organization-iam-sign-in-session-settings-information) | 組織IAMアカウントログインセッション設定情報を照会 |
| GET |[/v1/iam/organizations/{org-id}/settings/security-mfa](#view-settings-for-organizational-iam-sign-in-second-factor-authentication) | 組織IAMアカウントログイン2段階認証の設定を照会 |
| GET |[/v1/iam/organizations/{org-id}/settings/security-login-fail](#view-organization-iam-login-failure-security-settings) | 組織IAMアカウントログイン失敗セキュリティ設定を照会 |
| GET |[/v1/iam/organizations/{org-id}/settings/password-rule](#get-your-organizations-iam-account-password-policy) | 組織IAMアカウントパスワードポリシー照会 |
| GET |[/v1/organizations/{org-id}/products/ip-acl](#listorganization-ip-acls) | 組織IP ACLリスト照会 |
| POST |[/v1/billing/contracts/basic/products/prices/search](#get-the-price-of-a-service-on-a-pay-as-you-go-subscription) | 従量制に登録されたサービス価格照会 |
| GET |[/v1/billing/contracts/basic/products](#list-services-enrolled-in-a-pay-as-you-go-subscription) | 従量制に登録されたサービスリスト照会 |
| GET |[/v1/billing/members/payment-statements](#view-charges-by-payment-statement) | 請求書別利用金額照会 |
| GET |[/v1/billing/members/payment-statements/charge-summaries](#view-charge-summaries-by-scope) | 請求グループ、組織、プロジェクト別利用金額照会 |
| GET |[/v1/billing/members/payment-statements/usages](#view-individual-charge-lines) | 詳細内訳利用金額照会 |
| GET |[/v1/billing/members/payment-statements/dimensions](#view-charge-filter-dimensions) | 利用金額検索条件値リスト照会 |
| GET | [/v1/authentications/projects/{project-id}/project-appkeys](#get-project-integrated-appkey) | プロジェクト統合Appkey照会 |
| GET |[/v1/authentications/user-access-keys](#listuser-access-key-ids) | User Access Key IDリスト照会 |
| POST | [/v1/authentications/projects/{project-id}/project-appkeys](#register-a-integrated-project-appkey) | プロジェクト統合Appkey登録 |
| POST |[/v1/authentications/user-access-keys](#register-a-user-access-key-id) | User Access Key ID登録 |
| DELETE | [/v1/authentications/projects/{project-id}/project-appkeys/{app-key}](#delete-a-project-integrated-appkey) | プロジェクト統合Appkey削除 |
| PUT |[/v1/authentications/user-access-keys/{user-access-key-id}/secretkey-reissue](#reissue-the-user-access-key-id-secret-key) | User Access Key IDシークレットキーの再発行 |
| PUT |[/v1/authentications/user-access-keys/{user-access-key-id}](#modify-user-access-key-id-status) | User Access Key ID状態修正 |
| DELETE |[/v1/authentications/user-access-keys/{user-access-key-id}](#delete-a-user-access-key-id) | User Access Key ID削除 |
| GET    | [/v1/authentications/user-access-keys/{user-access-key-id}/tokens](#get-a-list-of-tokens)                               | トークンリスト照会                 |
| DELETE | [/v1/authentications/user-access-keys/{user-access-key-id}/tokens](#expire-multiple-tokens)                               | トークン複数期限切れ                  |
| POST |[/v1/iam/projects/{project-id}/members](#create-a-project-iam-account) | プロジェクトIAMアカウント作成 |
| DELETE |[/v1/iam/projects/{project-id}/members](#delete-multiple-project-iam-accounts) | プロジェクトIAMアカウント一括削除 |
| GET |[/v1/iam/projects/{project-id}/members/{member-uuid}](#view-a-project-member) | プロジェクトIAMアカウント単件照会 |
| GET |[/v1/iam/projects/{project-id}/members](#view-project-iam-accounts) | プロジェクトIAMアカウントリスト照会 |
| PUT |[/v1/iam/projects/{project-id}/members/{member-uuid}](#modify-project-iam-account-roles) | プロジェクトIAMアカウントロール修正 |
| GET |[/v1/authentications/organizations/{org-id}/user-access-keys](#view-all-credentials-of-members-under-organizations) | 組織下位メンバー認証情報リスト照会 |
| GET | [/v1/organizations](#view-your-own-organization-list) | 自分の組織一覧の照会 |
| POST | [/v1/organizations](#add-your-own-organization) | 自分の組織の追加 |
| DELETE | [/v1/organizations/{org-id}](#delete-a-single-organization) | 組織の個別削除 |
| GET | [/v1/products](#retrieve-service-information-list) | サービス情報リスト照会 |
| GET | [/v1/messages/role](#view-role-descriptions-by-multiple-language) | ロール説明多言語照会 |


<a id="create-a-project-member"></a>
### プロジェクトメンバー作成 { #create-a-project-member }

> POST "/v1/projects/{project-id}/members"

プロジェクトにメンバーを追加するAPIです。

<a id="create-a-project-member-required-permissions"></a>
#### 必要権限
`Project.Member.Create`

<a id="create-a-project-member-request-parameter"></a>
#### リクエストパラメータ



| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Y | メンバーを追加するプロジェクトID | 
| Request Body | request | CreateMemberRequest| Y | リクエスト |




##### CreateMemberRequest


!!! danger "注意"
    リクエスト時、memberUuid, email, userCodeのいずれかの値が必ず必要です。<br>memberUuid > email > userCodeの順に値があることをチェックしている場合は、そのメンバーをプロジェクトメンバーとして追加します。<br>1つのリクエストで1人のプロジェクトメンバーのみ作成できます。


| 名前 | タイプ | 必須 | 説明 |  
|------------ | ------------- | ------------- | ------------ |
|   assignRoles | List&lt;UserAssignRoleProtocol>| Y | ユーザーに割り当てるロールリスト |
|   memberUuid | String| N | 追加するメンバーのUUID  |
|   email | String| N | 追加するメンバーのメールアドレス |
|   userCode | String| N | 追加するIAMメンバーID  |


##### UserAssignRoleProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   roleId | String| Y | ロールID  |
|   conditions | List&lt;AssignAttributeConditionProtocol>| N | ロール条件属性 |


##### AssignAttributeConditionProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   attributeId | String| Y | 条件属性ID  |
|   attributeOperatorTypeCode | String| Y | 条件属性演算子<br>条件属性データ型によって使用できる演算子が異なる<br><ul><li>ALLOW</li><li>ALL_CONTAINS</li><li>ANY_CONTAINS</li><li>ANY_MATCH</li><li>BETWEEN</li><li>BEYOND</li><li>FALSE</li><li>GREATER_THAN</li><li>GREATER_THAN_OR_EQUAL_TO</li><li>LESS_THAN</li><li>LESS_THAN_OR_EQUAL_TO</li><li>NONE_MATCH</li><li>NOT_ALLOW</li><li>NOT_CONTAINS</li><li>TRUE</li></ul>  |
|   attributeValues | List&lt;String>| Y | 条件属性値 |


<a id="create-a-project-member-response-body"></a>
#### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

##### レスポンス


| 名前 | タイプ          | 必須 | 説明 |   
|------------ |--------------| ------- | ------------ |
|   header | [共通レスポンス](#common-response) | Y |


<a id="add-a-project"></a>
### プロジェクト追加 { #add-a-project }

> POST "/v1/organizations/{org-id}/projects"

組織にプロジェクトを追加するAPIです。

<a id="add-a-project-required-permissions"></a>
#### 必要権限
`Organization.Project.Create`

<a id="add-a-project-request-parameter"></a>
#### リクエストパラメータ



| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
| Path |org-id | String| Y | プロジェクトを追加する組織ID | 
| Request Body | request | CreateProjectRequest| Y | リクエスト |


##### CreateProjectRequest


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------ | ------------ |
|   description | String| N | プロジェクトの説明(最大100文字) |
|   projectName | String| Y| プロジェクト名(最大40文字) |


<a id="add-a-project-response-body"></a>
#### レスポンス本文

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
##### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | --------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y  |
|   regDateTime | Date| Y   | プロジェクト作成日時 | 
|   description | String| N   | プロジェクトの説明 | 
|   ownerId | String| Y   | プロジェクト所有者メンバーID | 
|   projectName | String| Y   | プロジェクト名 | 
|   projectId | String| Y   | プロジェクトID | 
|   orgId | String| Y   | 組織ID | 
|   projectStatusCode | String| Y   | プロジェクトの状態<br><ul><li>STABLE：正常に使用中の状態</li><li>CLOSED：決済が完了し、正常に終了した状態</li><li>BLOCKED：管理者によって使用が禁止された状態</li><li>TERMINATED：延滞により、全てのリソースが削除された状態</li><li>DISABLED：全てのサービスが閉じた状態であるが、料金が支払われていない状態</li></ul> |


<a id="delete-a-single-project-member"></a>
### プロジェクトメンバー単件削除 { #delete-a-single-project-member }

> DELETE "/v1/projects/{project-id}/members/{target-uuid}"

ユーザーを該当プロジェクトから削除するAPIです。

<a id="delete-a-single-project-member-required-permissions"></a>
#### 必要権限
`Project.Member.Delete`

<a id="delete-a-single-project-member-request-parameter"></a>
#### リクエストパラメータ



| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Y | プロジェクトID | 
|  Path |target-uuid | String| Y | 削除対象メンバーUUID | 




<a id="delete-a-single-project-member-response-body"></a>
#### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

##### レスポンス


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y |



<a id="delete-a-project"></a>
### プロジェクト削除 { #delete-a-project }

> DELETE "/v1/projects/{project-id}"

プロジェクトを削除するAPIです。

<a id="delete-a-project-required-permissions"></a>
#### 必要権限
以下のリストのいずれかの権限が必要です。
* `Organization.Project.Delete`
* `Project.Delete`

<a id="delete-a-project-request-parameter"></a>
#### リクエストパラメータ



| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Y | 削除するプロジェクトID | 






<a id="delete-a-project-response-body"></a>
#### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

##### レスポンス


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y |



<a id="end-a-project-service"></a>
### プロジェクトサービス終了 { #end-a-project-service }

> DELETE "/v1/projects/{project-id}/products/{product-id}/disable"

当該プロジェクトでユーザーが指定したサービスを利用しないように無効にするAPIです。

<a id="end-a-project-service-required-permissions"></a>
#### 必要権限
`サービス名:Product.Delete`

<a id="end-a-project-service-request-parameter"></a>
#### リクエストパラメータ


| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Y | サービスを終了するプロジェクトID | 
|  Path |product-id | String| Y | サービスID | 





<a id="end-a-project-service-response-body"></a>
#### レスポンス本文

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

##### レスポンス


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y |
|   childProducts | List&lt;ChildProduct>| N   | 該当サービスの下位サービス情報で、下位サービスがない場合は含まれません。<br>下位サービスを先に無効化してから、該当サービスを無効化する必要があります。|

##### ChildProduct


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | --------- | ------------ |
|   productId | String| Y  | 	下位サービスID | 
|   productName | String| Y  | 下位サービス名 |
|   statusCode | String| Y | サービス状態(STABLE, CLOSED) |


<a id="use-a-service-product"></a>
### プロジェクトサービス利用 { #use-a-service-product }

> POST "/v1/projects/{project-id}/products/{product-id}/enable"

該当プロジェクトでユーザーが指定したサービスを利用できるように有効化リクエストするAPIです。

<a id="use-a-service-product-required-permissions"></a>
#### 必要権限
`サービス名:Product.Create`

<a id="use-a-service-product-request-parameter"></a>
#### リクエストパラメータ



| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |product-id | String| Y | サービスID | 
|  Path |project-id | String| Y | サービスを利用するプロジェクトID | 


<a id="use-a-service-product-response-body"></a>
#### レスポンス本文

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

##### レスポンス


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y |
|   appKey | String| Y | 該当プロジェクトで利用中のサービスのアプリキー情報|
|   parentProduct | ParentProduct| N | 上位サービス情報がある場合はその情報を表示し、上位サービスがない場合は含みません。 |
|   secretKey | String| N| 該当プロジェクトで利用中のサービスのシークレットキー情報<br> シークレットキーを利用するサービスでのみ提供 |


##### ParentProduct


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | --------- | ------------ |
|   productId | String| Y  | サービスID |
|   productName | String| Y  | サービス名 |
|   statusCode | String| Y | サービス状態(STABLE, CLOSED) |





<a id="list-organization-roles"></a>
### 組織ロールリスト照会 { #list-organization-roles }

> GET "/v1/organizations/{org-id}/roles"

組織ユーザーに付与できるロールのリストをリクエストするAPIです。

<a id="list-organization-roles-required-permissions"></a>
#### 必要権限
`Organization.RoleGroup.List`

<a id="list-organization-roles-request-parameter"></a>
#### リクエストパラメータ



| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Y | 組織ID |
|  Query |categoryTypeCodes | List&lt;String> | N | ロール/権限/ロールグループカテゴリー区分(ROLE, PERMISSION, ROLE_GROUP) |
|  Query |roleNameLike | String| N | ロール/権限/ロールグループ名 |
|  Query |limit | Integer| N | 1ページあたりの表示件数、デフォルト値20 | 
|  Query |page | Integer| N | 対象ページ、デフォルト値1 |



<a id="list-organization-roles-response-body"></a>
#### レスポンス本文

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



##### レスポンス


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y |
|   roles | List&lt;RoleProtocol>| Y  | ロールリスト |
|   totalCount | Integer| Y  | 総数 |

##### RoleProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   categoryKey | String| Y | ロール/権限カテゴリー分類キー<br><ul><li>RoleGroup:プロジェクトロールグループ</li><li>OrgRoleGroup:組織ロールグループ</li><li>OrgRole:組織ロール</li><li>ProjectRole:プロジェクトロール</li><li>BillingRole: Billing関連ロール</li><li>OrgServiceRole:組織サービスロール</li><li>ProjectServiceRole:プロジェクトサービスロール</li><li>SystemRole:システム作成ロール</li></ul>  |
|   categoryTypeCode | String| Y | ロールグループ/ロール/権限区分コード(ORG_ROLE_GROUP, PERMISSION, ROLE, ROLE_GROUP, SYSTEM) |
|   description | String| Y | ロール/権限の説明 |
|   roleCategory | String| Y | ロール/権限カテゴリー大分類(ORG_ROLE, ORG_ROLE_GROUP, ORG_SERVICE_ROLE, PROJECT_ROLE, PROJECT_ROLE_GROUP, PROJECT_SERVICE_ROLE, SYSTEM_ROLE) |
|   roleId | String| Y | ロール/権限ID  |
|   roleName | String| Y | ロール/権限名 |


<a id="list-project-roles"></a>
### プロジェクトロールリスト照会 { #list-project-roles }

> GET "/v1/projects/{project-id}/roles"

プロジェクトユーザーに付与できるロールのリストをリクエストするAPIです。

<a id="list-project-roles-required-permissions"></a>
#### 必要権限
`Project.RoleGroup.List`

<a id="list-project-roles-request-parameter"></a>
#### リクエストパラメータ


| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Y | プロジェクトID | 
|  Query |categoryTypeCodes | List&lt;String> | N | ロール/権限/ロールグループカテゴリー区分(ROLE, PERMISSION, ROLE_GROUP) |
|  Query |roleNameLike | String| N | ロール/権限/ロールグループ名 |
|  Query |limit | Integer| N | 1ページあたりの表示件数、デフォルト値20 | 
|  Query |page | Integer| N | 対象ページ、デフォルト値1 |


<a id="list-project-roles-response-body"></a>
#### レスポンス本文

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


##### レスポンス


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y |
|   roles | List&lt;[RoleProtocol](#roleprotocol)>| Y  | ロールリスト |
|   totalCount | Integer| Y  | 総数 |

<a id="search-for-an-organization-domain"></a>
### 組織ドメイン検索 { #search-for-an-organization-domain }

> GET "/v1/organizations/{org-id}/domains"

特定組織のドメインを照会するAPIです。

<a id="search-for-an-organization-domain-required-permissions"></a>
#### 必要権限
`Organization.Domain.List`

<a id="search-for-an-organization-domain-request-parameter"></a>
#### リクエストパラメータ



| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Y | 照会する組織のID | 




<a id="search-for-an-organization-domain-response-body"></a>
#### レスポンス本文

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

##### レスポンス


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y |
|   domainList | List&lt;OrgDomainProtocol>| Y  |


##### OrgDomainProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | --------- | ------------ |
|   orgDomainId | String| Y | 組織ドメインID |
|   orgDomainName | String| Y | 組織ドメイン名 |


<a id="view-a-organization-member"></a>
### 組織メンバー単件照会 { #view-a-organization-member }

> GET "/v1/organizations/{org-id}/members/{member-uuid}"

組織に所属するメンバーを照会するAPIです。

<a id="view-a-organization-member-required-permissions"></a>
#### 必要権限
`Organization.Member.Get`

<a id="view-a-organization-member-request-parameter"></a>
#### リクエストパラメータ



| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Y | メンバーを照会する組織ID | 
|  Path |member-uuid | String| Y | 	照会するメンバーUUID | 





<a id="view-a-organization-member-response-body"></a>
#### レスポンス本文

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

##### レスポンス


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y |
|   orgMember | OrgMemberRoleBundleProtocol| N  | 追加されたメンバー情報、エラーの場合は含まれません。 |

##### OrgMemberRoleBundleProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----- | ------------ |
|   email | String| Y | メンバーメール |
|   id | String| N | メンバーID(IAMメンバーのみ提供) |
|   inviteStatusCode | String| Y |   COMPLETE, EXPIRE, UNKNOWN, WAIT |
|   joinYmdt | Date| Y | 組織メンバー登録日時 |
|   memberName | String| Y| 	メンバー名 |
|   memberTypeCode | String| Y| メンバー区分(TOAST_CLOUD: NHN Cloudメンバー、 IAM: IAMメンバー) |
|   memberUuid | String| Y| メンバーのUUID |
|   recentLoginYmdt | Date| Y| 最後のログイン日時 |
|   recentPasswordModifyYmdt | Date| N| 最後のパスワード変更日時 |
|   roleCode | String| N| ロールID |
|   roles | List&lt;RoleBundleProtocol>| N | 関連ロールリスト(条件属性を含む)  |
|   secondFactorCertificationYn | String| N| 2段階ログイン設定の有無(NHN Cloudメンバーのみ提供) |


##### RoleBundleProtocol
| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----- | ------------ |
|   roleId | String| Y | ロールID |
|   roleName | String| Y | ロール名 |
|   description | String| N | ロールの説明 |
|   categoryKey | String| Y | ロール/権限カテゴリー分類キー<br><ul><li>RoleGroup:プロジェクトロールグループ</li><li>OrgRoleGroup:組織ロールグループ</li><li>OrgRole:組織ロール</li><li>ProjectRole:プロジェクトロール</li><li>BillingRole: Billing関連ロール</li><li>OrgServiceRole:組織サービスロール</li><li>ProjectServiceRole:プロジェクトサービスロール</li><li>SystemRole:システム作成ロール</li></ul>  |
|   categoryTypeCode | String| Y | ロールグループ/ロール/権限区分コード(ORG_ROLE_GROUP, PERMISSION, ROLE, ROLE_GROUP, SYSTEM) |
|   conditions | List&lt;AttributeConditionProtocol>| N | 条件属性リスト |
|   roleApplyPolicyCode | String| Y | ロール使用有無ALLOW, DENY |
|   regDateTime | Date| Y | ロール作成日時 |



##### AttributeConditionProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----- | ------------ |
|   attributeDataTypeCode | String| Y | 条件属性データ型(BOOLEAN, DATETIME, DAY_OF_WEEK, IPADDRESS, NUMERIC, STRING, TIME) |
|   attributeDescription | String| N | 条件属性の説明 |
|   attributeId | String| Y | 条件属性ID |
|   attributeName | String| Y | 条件属性名 |
|   attributeOperatorTypeCode | String| Y | 条件属性演算子<br>条件属性データ型によって使用できる演算子が異なります<br><ul><li>ALLOW</li><li>ALL_CONTAINS</li><li>ANY_CONTAINS</li><li>ANY_MATCH</li><li>BETWEEN</li><li>BEYOND</li><li>FALSE</li><li>GREATER_THAN</li><li>GREATER_THAN_OR_EQUAL_TO</li><li>LESS_THAN</li><li>LESS_THAN_OR_EQUAL_TO</li><li>NONE_MATCH</li><li>NOT_ALLOW</li><li>NOT_CONTAINS</li><li>TRUE</li></ul> |
|   attributeValues | List&lt;String>| Y| 条件属性値 |



<a id="list-organization-members"></a>
### 組織メンバーリスト照会 { #list-organization-members }

> POST "/v1/organizations/{org-id}/members/search"

該当組織に所属するNHN Cloudメンバーリストを照会するAPIです。

<a id="list-organization-members-required-permissions"></a>
#### 必要権限
`Organization.Member.List`

<a id="list-organization-members-request-parameter"></a>
#### リクエストパラメータ



| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Y | 組織ID | 
| Request Body | request | SearchOrgMembersRequest| Y | リクエスト |


##### SearchOrgMembersRequest


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | --------- | ------------ |
|   memberStatusCodes | List&lt;String>| N | 照会するメンバーの状態<br><ul><li>STABLE:招待完了</li><li>INVITED:招待中</li><li>BLOCKED</li><li>NOT_EXIST</li><li>WITHDRAW</li></ul> |
|   roleIds | Set&lt;String>| N  | メンバーが付与されたロールID |
|   paging | PagingBean| N  |

##### PagingBean


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   limit | Integer| N | 1ページあたりの表示件数、デフォルト値20  |
|   page | Integer| N | 対象ページ、デフォルト値1  |




<a id="list-organization-members-response-body"></a>
#### レスポンス本文

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
##### レスポンス


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y |
|   orgMembers | List&lt;OrgMemberWithInviteMemberProtocol>| Y | 組織メンバーリスト |
|   paging | PagingResponse| Y | ページ情報 |

##### OrgMemberWithInviteMemberProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----- | ------------ |
|   email | String| Y | メンバーのメールアドレス |
|   inviteStatusCode | String| N | メンバーの招待状態(COMPLETE, EXPIRE, UNKNOWN, WAIT) |
|   joinYmdt | Date| Y | メンバー加入日時 |
|   maskingEmail | String| Y | メンバーのマスキングされたメール |
|   memberName | String| Y| メンバーの名前 |
|   memberTypeCode | String| Y| メンバー区分(TOAST_CLOUD: NHN Cloudメンバー、 IAM: IAMメンバー) |
|   memberUuid | String| N| メンバーのUUID<br>招待中の場合は値を返しません。 |
|   recentLoginYmdt | Date| Y| 最後のログイン日時 |
|   recentPasswordModifyYmdt | Date| N| 最後のパスワード変更日時 |
|   secondFactorCertificationYn | String| N|  2段階ログイン設定有無(NHN Cloudメンバーのみ提供) |

##### PagingResponse


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   limit | Integer| N | 1ページあたりの表示件数、デフォルト値20  |
|   page | Integer| N | 対象ページ、デフォルト値1  |
|   totalCount | Long| Y | 総件数 |




<a id="view-all-common-role-groups-for-projects-in-the-organization"></a>
### 組織のプロジェクト共通ロールグループ全体照会 { #view-all-common-role-groups-for-projects-in-the-organization }

> GET "/v1/organizations/{org-id}/project-role-groups"

組織で設定したプロジェクト共通ロールグループリストを照会するAPIです。

<a id="view-all-common-role-groups-for-projects-in-the-organization-required-permissions"></a>
#### 必要権限
`Organization.Project.RoleGroup.List`

<a id="view-all-common-role-groups-for-projects-in-the-organization-request-parameter"></a>
#### リクエストパラメータ



| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Y | 照会対象組織ID | 
|  Query |descriptionLike | String| N | 説明 | 
|  Query |roleGroupNameLike | String| N | ロールグループ名 |
|  Query |limit | Integer| N | 1ページあたりの表示件数、デフォルト値20 |
|  Query |page | Integer| N | 対象ページ、デフォルト値1 |






<a id="view-all-common-role-groups-for-projects-in-the-organization-response-body"></a>
#### レスポンス本文

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



##### レスポンス


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | --------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y  |
|   paging | [PagingResponse](#pagingresponse)| Y  |
|   roleGroups | List&lt;RoleGroupProtocol>| Y | プロジェクトで使用可能なロールグループリスト |


##### RoleGroupProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----- | ------------ |
|   description | String| N | ロールグループの説明 |
|   regDateTime | Date| Y | ロールグループ作成日時 |
|   roleGroupId | String| Y | ロールグループID |
|   roleGroupName | String| Y| ロールグループの名前 |
|   roleGroupType | String| Y | ロールグループの種類<br><ul><li>ORG:プロジェクト共通ロールグループ</li><li>ORG_ROLE_GROUP:組織ロールグループ</li><li>PROJECT:プロジェクトロールグループ</li> |


<a id="view-service-hierarchy"></a>
### サービス階層構造照会 { #view-service-hierarchy }

> GET "/v1/product-uis/hierarchy"

請求書に表示されるWebサイトカテゴリー、 Webサイトサービス情報を返すAPIです。

<a id="view-service-hierarchy-required-permissions"></a>
#### 必要権限
会員であれば、特定の権限なしで呼び出すことができるAPIです。
ただし、組織サービスを照会する場合は、その組織や組織の下にあるプロジェクトメンバーでなければなりません。

<a id="view-service-hierarchy-request-parameter"></a>
#### リクエストパラメータ



| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Query |productUiType | String| Y | サービスUIタイプ<br><ul><li>PROJECT:プロジェクトサービス</li><li>ORG:組織サービス</li><li>MARKET_PLACE:マーケットプレイスサービス</li></ul> |
|  Query |orgId | String| Conditional | サービスUIタイプがORGの場合、組織IDを必ず入力する必要があります。 |




<a id="view-service-hierarchy-response-body"></a>
#### レスポンス本文

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

##### レスポンス


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y |
|   productUiList | List&lt;ProductUiHierarchyProtocol>| Y  | WebサイトカテゴリーサービスUIリスト |

##### ProductUiHierarchyProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----- | ------------ |
|   children | List&lt;ProductUiHierarchyProtocol>| N | ホームページサービスUIリスト |
|   manualLink | String| N|
|   parentProductUiId | String| N| サービスUI区分 |
|   productId | String| N|
|   productUiId | String| N| サービスUI識別キー |
|   productUiName | String| N|


<a id="view-a-service-used-in-the-project"></a>
### プロジェクトで使用中のサービス照会 { #view-a-service-used-in-the-project }

> GET "/v1/projects/{project-id}/products/{product-id}"

* プロジェクトで使用中の特定サービス情報を照会するAPI

<a id="view-a-service-used-in-the-project-required-permissions"></a>
#### 必要権限
`サービス名:ProductAppKey.Get`

<a id="view-a-service-used-in-the-project-request-parameter"></a>
#### リクエストパラメータ



| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Y | 照会対象プロジェクトID |
|  Path |product-id | String| Y | 照会対象サービスID |




<a id="view-a-service-used-in-the-project-response-body"></a>
#### レスポンス本文

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

##### レスポンス


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y |
|   hasUpdateSecretKeyPermission | Boolean| Y | 秘密鍵再発行可能権限 |
|   product | ProjectProductRelationAndProductProtocol| Y  | 指定したサービスIDに対して、プロジェクトで使用しているサービス情報を返し、エラー時は含みません。 |


##### ProjectProductRelationAndProductProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   appKey | String| Y | 該当プロジェクトで利用中のサービスのアプリキー情報 |
|   externalId | String| N | テナントID<br>サービスにテナントIDが存在する場合にのみ提供 |
|   productId | String| Y | サービスID  |
|   productName | String| Y | サービス名 |
|   productSecretKeyCode | String| N | 秘密鍵使用有無<br>T:使用する<br>その他:使用しない(F, N) |
|   productStatusCode | String| Y | サービス状態(STABLE, CLOSED) |
|   projectId | String| Y | 該当サービスを使用するプロジェクトID  |
|   relationDate | Date| Y | サービス利用開始日時 |
|   secretKey | String| Y | サービスSecretKey<br>secretKeyを利用するサービスでのみ提供 |
|   statusCode | String| Y | 該当サービスの利用状態(STABLE, CLOSED) |
|   updateDate | Date| N | サービス最終修正日時 |
|   updateUuid | String| N | サービスアプリキー修正者UUID  |


<a id="view-a-project-member"></a>
### プロジェクトメンバー単件照会 { #view-a-project-member }

> GET "/v1/projects/{project-id}/members/{member-uuid}"

プロジェクトに所属する特定メンバーを照会するAPIです。

<a id="view-a-project-member-required-permissions"></a>
#### 必要権限
`Project.Member.Get`

<a id="view-a-project-member-request-parameter"></a>
#### リクエストパラメータ



| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Y | メンバーを照会するプロジェクトID |
|  Path |member-uuid | String| Y | 照会するメンバーUUID |




<a id="view-a-project-member-response-body"></a>
#### レスポンス本文

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


##### レスポンス


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y |
|   projectMember | ProjectMemberRoleBundleProtocol| Y  | 追加されたメンバー情報、エラー時は含まれません。 |


##### ProjectMemberRoleBundleProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   emailAddress | String| N | メンバーのメールアドレス |
|   maskingEmail | String| N | メンバーのマスキングされたメールアドレス |
|   memberName | String| N | メンバー名 |
|   memberTypeCode | String| N | メンバー区分(IAM, TOAST_CLOUD) |
|   relationDateTime | Date| N | メンバー追加時間 |
|   roles | List&lt;RoleBundleProtocol>| N | 関連ロールリスト(条件属性を含む)  |
|   statusCode | String| N | 招待ステータスコード(COMPLETE, EXPIRE, UNKNOWN, WAIT) |
|   uuid | String| N | メンバーUUID  |


[RoleBundleProtocol](#rolebundleprotocol)



<a id="list-project-members"></a>
### プロジェクトメンバーリスト照会 { #list-project-members }

> POST "/v1/projects/{project-id}/members/search"

プロジェクトに所属するメンバーリストを照会するためのAPIです。

<a id="list-project-members-required-permissions"></a>
#### 必要権限
`Project.Member.List`

<a id="list-project-members-request-parameter"></a>
#### リクエストパラメータ


| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Y | 照会するプロジェクトID | 
| Request Body | request | SearchProjectMembersRequest| Y | リクエスト |



##### SearchProjectMembersRequest


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   memberStatusCodes | List&lt;String>| N | プロジェクトメンバーステータスコード(INVITED, STABLE) |
|   roleIds | List&lt;String>| N | ロールIDリスト |
|   paging | [PagingBean](#pagingbean) | N   |





<a id="list-project-members-response-body"></a>
#### レスポンス本文

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

##### レスポンス


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y |
|   paging | [PagingResponse](#pagingresponse)| Y  |
|   projectMembers | List&lt;ProjectMemberProtocol>| Y | プロジェクトメンバー |



##### ProjectMemberProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   emailAddress | String| N | メンバーのメールアドレス |
|   maskingEmail | String| N | メンバーのマスキングされたメールアドレス |
|   memberName | String| N | メンバー名 |
|   memberTypeCode | String| N | メンバー区分 |
|   relationDateTime | Date| N | メンバー追加時間 |
|   statusCode | String| N | 招待ステータスコード(COMPLETE, EXPIRE, UNKNOWN, WAIT) |
|   uuid | String| N | メンバーUUID  |


<a id="view-a-project-role-group"></a>
### プロジェクトロールグループ単件照会 { #view-a-project-role-group }

> GET "/v1/projects/{project-id}/project-role-groups/{role-group-id}"

プロジェクトのロールグループを照会するAPIです。

<a id="view-a-project-role-group-required-permissions"></a>
#### 必要権限
`Project.RoleGroup.Get`

<a id="view-a-project-role-group-request-parameter"></a>
#### リクエストパラメータ



| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Y | 照会対象プロジェクトID | 
|  Path |role-group-id | String| Y | プロジェクトロールグループID<br>プロジェクト共通ロールグループIDは照会不可 | 




<a id="view-a-project-role-group-response-body"></a>
#### レスポンス本文

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

##### レスポンス


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | --------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y |
|   roleGroup | RoleGroupBundleProtocol| Y | 関連ロールを含むロールグループ |

##### RoleGroupBundleProtocol

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   roleGroupId | String| N | ロールグループID  |
|   roleGroupName | String| N | ロールグループ名 |
|   description | String| N | ロールグループの説明 |
|   roleGroupType | String| N | ロールグループ区分(組織、プロジェクト)  |
|   roles | List&lt;[RoleBundleProtocol](#rolebundleprotocol)>| N | 関連ロールリスト |
|   regDateTime | Date| N | 登録日時 |



<a id="view-a-common-role-group-for-the-project-in-the-organization"></a>
### 組織のプロジェクト共通ロールグループ単件照会 { #view-a-common-role-group-for-the-project-in-the-organization }

> GET "/v1/organizations/{org-id}/project-role-groups/{role-group-id}"

プロジェクト共通ロールグループを照会するAPIです。

<a id="view-a-common-role-group-for-the-project-in-the-organization-required-permissions"></a>
#### 必要権限
`Organization.Project.RoleGroup.Get`

<a id="view-a-common-role-group-for-the-project-in-the-organization-request-parameter"></a>
#### リクエストパラメータ


| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Y | 照会対象組織ID | 
|  Path |role-group-id | String| Y | プロジェクト共通ロールグループID | 


<a id="view-a-common-role-group-for-the-project-in-the-organization-response-body"></a>
#### レスポンス本文

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


##### レスポンス


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | --------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y |
|   roleGroup | [RoleGroupBundleProtocol](#rolegroupbundleprotocol) | Y | 関連ロールを含むロールグループ |




<a id="view-all-project-role-groups"></a>
### プロジェクトロールグループ全体照会 { #view-all-project-role-groups }

> GET "/v1/projects/{project-id}/project-role-groups"

プロジェクトのロールグループを全体照会するAPIです。

<a id="view-all-project-role-groups-required-permissions"></a>
#### 必要権限
`Project.RoleGroup.List`

<a id="view-all-project-role-groups-request-parameter"></a>
#### リクエストパラメータ


| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Y | 照会対象プロジェクトID | 
|  Query |descriptionLike | String| N | 説明 |
|  Query |roleGroupNameLike | String| N | ロールグループ名 |
|  Query |limit | Integer| N | 1ページあたりの表示件数、デフォルト値20 |
|  Query |page | Integer| N | 対象ページ、デフォルト値1 |



<a id="view-all-project-role-groups-response-body"></a>
#### レスポンス本文

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

##### レスポンス


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | --------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y  |
|   paging | [PagingResponse](#pagingresponse)| Y  |
|   roleGroups | List&lt;[RoleGroupProtocol](#rolegroupprotocol)>| Y | プロジェクトで使用可能なロールグループリスト |

<a id="list-projects-in-your-organization"></a>
### 組織に属するプロジェクトリスト照会 { #list-projects-in-your-organization }

> GET "/v1/organizations/{org-id}/projects"

特定組織に属するSTABLE状態のプロジェクトリストを照会するAPIです。

<a id="list-projects-in-your-organization-required-permissions"></a>
#### 必要権限
組織のメンバー

<a id="list-projects-in-your-organization-request-parameter"></a>
#### リクエストパラメータ


| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Y | 照会する組織のID | 
|  Query |memberUuid | String| N | 組織のメンバーUUID |
|  Query |projectName | String| N | プロジェクト名 |
|  Query |page | Integer| N | 対象ページ、デフォルト値1 |
|  Query |limit | Integer| N | 1ページあたりの表示件数、デフォルト値20 |


<a id="list-projects-in-your-organization-response-body"></a>
#### レスポンス本文

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


##### レスポンス


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y |
|   paging | [PagingResponse](#pagingresponse) | Y |
|   projectList | List&lt;OrgProjectMemberRoleProtocol>| Y |



##### OrgProjectMemberRoleProtocol

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----- | ------------ |
|   delDateTime | Date| N | プロジェクト削除日時 |
|   description | String| N | プロジェクトの説明 |
|   modDateTime | Date| N| プロジェクト修正日時 |
|   orgId | String| Y| プロジェクトが属する組織ID |
|   projectId | String| Y| プロジェクトID |
|   projectName | String| Y| プロジェクト名 |
|   projectStatusCode | String| Y   | プロジェクトの状態<br><ul><li>STABLE：正常に使用中の状態</li><li>CLOSED：支払いが完了し、プロジェクトが正常に閉じた状態</li><li>BLOCKED：管理者によって使用が禁止された状態</li><li>TERMINATED：延滞により、全てのリソースが削除された状態</li><li>DISABLED：全てのサービスが閉じた状態であるが、料金が支払われていない状態</li></ul> |
|   regDateTime | Date| Y| プロジェクト登録日時 |


<a id="list-organization-governance-in-use"></a>
### 使用中の組織ガバナンスリスト照会 { #list-organization-governance-in-use }

> GET "/v1/organizations/{org-id}/governances"

有効になっているガバナンスを照会するAPIです。

<a id="list-organization-governance-in-use-required-permissions"></a>
#### 必要権限
`Organization.Governance.List`

<a id="list-organization-governance-in-use-request-parameter"></a>
#### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Y | 照会対象組織ID | 



<a id="list-organization-governance-in-use-response-body"></a>
#### レスポンス本文

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



##### レスポンス


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y   |
|   usingGovernances | List&lt;GovernanceProtocol>| N | 使用中のガバナンスリスト |


##### GovernanceProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   governanceTypeCode | String| N | ガバナンスタイプ<br>- APPROVE_PROCESS: 承認処理<br>- BLOCK_STORAGE_SNAPSHOT: BlockStorageのSnapshot機能使用可否<br>- IAAS_RESOURCE_PROTECTION_AND_SEPARATED_NETWORK: IAASリソース権限制御及び接続端末制限設定<br>- PRIVACY_PROTECTION: 個人情報保護<br>- UNIQUE_INSTANCE_NAME: インスタンス名重複防止 |
|   regDatetime | Date| N | ガバナンス使用設定日時 |


<a id="create-a-common-role-group-for-projects-in-the-organization"></a>
### 組織のプロジェクト共通ロールグループ作成 { #create-a-common-role-group-for-projects-in-the-organization }

> POST "/v1/organizations/{org-id}/project-role-groups"

プロジェクト共通ロールグループを作成するAPIです。


<a id="create-a-common-role-group-for-projects-in-the-organization-required-permissions"></a>
#### 必要権限
`Organization.Project.RoleGroup.Create`

<a id="create-a-common-role-group-for-projects-in-the-organization-request-parameter"></a>
#### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Y | 組織ID | 
| Request Body | request | CreateRoleGroupRequest| Y | リクエスト |

##### CreateRoleGroupRequest

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   description | String| N | ロールグループの説明 |
|   roleGroupName | String| Y | ロールグループ名 |
|   roles | List&lt;AssignRoleProtocol>| Y | ロールグループに割り当てるロールリスト |


##### AssignRoleProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   conditions | List&lt;[AssignAttributeConditionProtocol](#assignattributeconditionprotocol)>| N | ロール条件属性 |
|   roleApplyPolicyCode | String| Y | ロール使用有無ALLOW, DENY |
|   roleId | String| Y | ロールID  |




<a id="create-a-common-role-group-for-projects-in-the-organization-response-body"></a>
#### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

##### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y   |


<a id="delete-a-project-common-role-group-in-the-organization"></a>
### 組織のプロジェクト共通ロールグループ削除 { #delete-a-project-common-role-group-in-the-organization }

> DELETE "/v1/organizations/{org-id}/project-role-groups"

プロジェクト共通ロールグループを削除するAPIです。

<a id="delete-a-project-common-role-group-in-the-organization-required-permissions"></a>
#### 必要権限
`Organization.Project.RoleGroup.Delete`

<a id="delete-a-project-common-role-group-in-the-organization-request-parameter"></a>
#### リクエストパラメータ


| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Y | 組織ID | 
| Request Body | request | DeleteRoleGroupRequest| Y | リクエスト |


##### DeleteRoleGroupRequest


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   roleGroupIds | List&lt;String>| Y | ロールグループIDリスト |


<a id="delete-a-project-common-role-group-in-the-organization-response-body"></a>
#### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

##### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y   |

<a id="modify-your-organizations-project-common-role-group-information"></a>
### 組織のプロジェクト共通ロールグループ情報修正 { #modify-your-organizations-project-common-role-group-information }

> PUT "/v1/organizations/{org-id}/project-role-groups/{role-group-id}/infos"

プロジェクト共通ロールグループの名前と説明を修正するAPIです。

<a id="modify-your-organizations-project-common-role-group-information-required-permissions"></a>
#### 必要権限
`Organization.Project.RoleGroup.Update`

<a id="modify-your-organizations-project-common-role-group-information-request-parameter"></a>
#### リクエストパラメータ


| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Y | 組織ID | 
|  Path |role-group-id | String| Y | ロールグループID | 
| Request Body | request | UpdateRoleGroupInfoRequest| Y | リクエスト |


##### UpdateRoleGroupInfoRequest


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   description | String| N | ロールグループの説明 |
|   roleGroupName | String| Y | ロールグループ名 |



<a id="modify-your-organizations-project-common-role-group-information-response-body"></a>
#### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

##### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y   |

<a id="modify-your-organizations-project-common-roles-group-roles"></a>
### 組織のプロジェクト共通ロールグループロール修正 { #modify-your-organizations-project-common-roles-group-roles }

> PUT "/v1/organizations/{org-id}/project-role-groups/{role-group-id}/roles"

プロジェクト共通ロールグループのロールを修正するAPIです。

<a id="modify-your-organizations-project-common-roles-group-roles-required-permissions"></a>
#### 必要権限
`Organization.Project.RoleGroup.Update`

<a id="modify-your-organizations-project-common-roles-group-roles-request-parameter"></a>
#### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Y | 組織ID | 
|  Path |role-group-id | String| Y | ロールグループID | 
| Request Body | request | UpdateRoleGroupRequest| Y | リクエスト |


##### UpdateRoleGroupRequest


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   roles | List&lt;[AssignRoleProtocol](#assignroleprotocol)>| Y | ロールグループに割り当てるロールリスト |




<a id="modify-your-organizations-project-common-roles-group-roles-response-body"></a>
#### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

##### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y   |

<a id="create-a-project-role-group"></a>
### プロジェクトロールグループ作成 { #create-a-project-role-group }

> POST "/v1/projects/{project-id}/project-role-groups"

プロジェクトにロールグループを作成するAPIです。


<a id="create-a-project-role-group-required-permissions"></a>
#### 必要権限
`Project.RoleGroup.Create`

<a id="create-a-project-role-group-request-parameter"></a>
#### リクエストパラメータ


| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Y | プロジェクトID | 
| Request Body | request | [CreateRoleGroupRequest](#createrolegrouprequest)| Y | リクエスト |





<a id="create-a-project-role-group-response-body"></a>
#### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

##### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y   |

<a id="delete-a-project-role-group"></a>
### プロジェクトロールグループ削除 { #delete-a-project-role-group }

> DELETE "/v1/projects/{project-id}/project-role-groups"

プロジェクトロールグループを削除するAPIです。


<a id="delete-a-project-role-group-required-permissions"></a>
#### 必要権限
`Project.RoleGroup.Delete`

<a id="delete-a-project-role-group-request-parameter"></a>
#### リクエストパラメータ


| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Y | プロジェクトID | 
| Request Body | request | [DeleteRoleGroupRequest](#deleterolegrouprequest)| Y | リクエスト |





<a id="delete-a-project-role-group-response-body"></a>
#### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

##### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y   |

<a id="edit-project-role-group-information"></a>
### プロジェクトロールグループ情報修正 { #edit-project-role-group-information }

> PUT "/v1/projects/{project-id}/project-role-groups/{role-group-id}/infos"

プロジェクトロールグループの名前と説明を修正するAPIです。

<a id="edit-project-role-group-information-required-permissions"></a>
#### 必要権限
`Project.RoleGroup.Update`

<a id="edit-project-role-group-information-request-parameter"></a>
#### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Y | プロジェクトID | 
|  Path |role-group-id | String| Y | ロールグループID | 
| Request Body | request |[UpdateRoleGroupInfoRequest](#updaterolegroupinforequest)| Y | リクエスト |





<a id="edit-project-role-group-information-response-body"></a>
#### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

##### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y   |


<a id="modify-project-role-group-roles"></a>
### プロジェクトロールグループロール修正 { #modify-project-role-group-roles }

> PUT "/v1/projects/{project-id}/project-role-groups/{role-group-id}/roles"

プロジェクトロールグループのロールを修正するAPIです。

<a id="modify-project-role-group-roles-required-permissions"></a>
#### 必要権限
`Project.RoleGroup.Update`

<a id="modify-project-role-group-roles-request-parameter"></a>
#### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Y | プロジェクトID | 
|  Path |role-group-id | String| Y | ロールグループID | 
| Request Body | request | UpdateRoleGroupRequest| Y | リクエスト |

##### UpdateRoleGroupRequest


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   roles | List&lt;[AssignRoleProtocol](#assignroleprotocol)>| Y | ロールグループに割り当てるロールリスト |





<a id="modify-project-role-group-roles-response-body"></a>
#### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

##### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y   |

<a id="view-all-organization-role-groups"></a>
### 組織ロールグループ全件照会 { #view-all-organization-role-groups }

> GET "/v1/organizations/{org-id}/org-role-groups"
組織のロールグループを全件照会するAPIです。

<a id="view-all-organization-role-groups-required-permission"></a>
#### 必要権限

`Organization.RoleGroup.List`

<a id="view-all-organization-role-groups-request-parameter"></a>
#### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| Path | org-id | String | Y | 照会対象組織ID |
| Query | descriptionLike | String | N | 説明(該当文字列が含まれる結果照会) |
| Query | roleGroupNameLike | String | N | ロールグループ名(該当文字列が含まれる結果照会) |
| Query | limit | Integer | N | 1ページあたりの表示件数(デフォルト値: 20、最小値: 1、最大値: 2000) |
| Query | page | Integer | N | 対象ページ(デフォルト値: 1、最小値: 1) |

<a id="view-all-organization-role-groups-response-body"></a>
#### レスポンス本文

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

##### レスポンス

| 名前 | タイプ | 必須 | 説明 |
| ------------ | ------------- | --------- | ------------ |
| header | [共通レスポンス](#common-response) | Y | |
| paging | [PagingResponse](#pagingresponse) | Y | |
| roleGroups | List&lt;[RoleGroupProtocol](#rolegroupprotocol)> | Y | 組織で使用可能なロールグループリスト |

<a id="view-a-single-organization-role-group"></a>
### 組織ロールグループ個別照会 { #view-a-single-organization-role-group }

> GET "/v1/organizations/{org-id}/org-role-groups/{role-group-id}"
組織のロールグループを照会するAPIです。

<a id="view-a-single-organization-role-group-required-permission"></a>
#### 必要権限

`Organization.RoleGroup.Get`

<a id="view-a-single-organization-role-group-request-parameter"></a>
#### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| Path | org-id | String | Y | 照会対象組織ID |
| Path | role-group-id | String | Y | 組織ロールグループID | 

<a id="view-a-single-organization-role-group-response-body"></a>
#### レスポンス本文

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

##### レスポンス

| 名前 | タイプ | 必須 | 説明 |
| ------------ | ------------- | --------- | ------------ |
| header | [共通レスポンス](#common-response) | Y | |
| roleGroup | [RoleGroupBundleProtocol](#rolegroupbundleprotocol) | Y | 関連ロールを含むロールグループ |

<a id="create-organization-role-group"></a>
### 組織ロールグループ作成 { #create-organization-role-group }

> POST "/v1/organizations/{org-id}/org-role-groups"
組織にロールグループを作成するAPIです。

<a id="create-organization-role-group-required-permission"></a>
#### 必要権限

`Organization.RoleGroup.Create`

<a id="create-organization-role-group-request-parameter"></a>
#### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| Path | org-id | String | Y | 組織ID |
| Request Body | request | [CreateRoleGroupRequest](#createrolegrouprequest) | Y | リクエスト |

<a id="create-organization-role-group-response-body"></a>
#### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

##### レスポンス

| 名前 | タイプ | 必須 | 説明 |
| ------------ | ------------- | ----------- | ------------ |
| header | [共通レスポンス](#common-response) | Y | |

<a id="delete-organization-role-group"></a>
### 組織ロールグループ削除 { #delete-organization-role-group }

> DELETE "/v1/organizations/{org-id}/org-role-groups"
組織ロールグループを削除するAPIです。

<a id="delete-organization-role-group-required-permission"></a>
#### 必要権限

`Organization.RoleGroup.Delete`

<a id="delete-organization-role-group-request-parameter"></a>
#### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| Path | org-id | String | Y | 組織ID |
| Request Body | request | [DeleteRoleGroupRequest](#deleterolegrouprequest) | Y | リクエスト |

<a id="delete-organization-role-group-response-body"></a>
#### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

##### レスポンス

| 名前 | タイプ | 必須 | 説明 |
| ------------ | ------------- | ----------- | ------------ |
| header | [共通レスポンス](#common-response) | Y | |

<a id="modify-organization-role-group-information"></a>
### 組織ロールグループ情報修正 { #modify-organization-role-group-information }

> PUT "/v1/organizations/{org-id}/org-role-groups/{role-group-id}/infos"
組織ロールグループの名前と説明を修正するAPIです。

<a id="modify-organization-role-group-information-required-permission"></a>
#### 必要権限

`Organization.RoleGroup.Update`

<a id="modify-organization-role-group-information-request-parameter"></a>
#### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| Path | org-id | String | Y | 組織ID |
| Path | role-group-id | String | Y | ロールグループID |
| Request Body | request | [UpdateRoleGroupInfoRequest](#updaterolegroupinforequest) | Y | リクエスト |

<a id="modify-organization-role-group-information-response-body"></a>
#### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

##### レスポンス

| 名前 | タイプ | 必須 | 説明 |
| ------------ | ------------- | ----------- | ------------ |
| header | [共通レスポンス](#common-response) | Y | |


<a id="modify-an-organization-role-groups-role"></a>
### 組織ロールグループロール修正 { #modify-an-organization-role-groups-role }

> PUT "/v1/organizations/{org-id}/org-role-groups/{role-group-id}/roles"
組織ロールグループのロールを修正するAPIです。

<a id="modify-an-organization-role-groups-role-required-permission"></a>
#### 必要権限

`Organization.RoleGroup.Update`

<a id="modify-an-organization-role-groups-role-request-parameter"></a>
#### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| Path | org-id | String | Y | 組織ID |
| Path | role-group-id | String | Y | ロールグループID |
| Request Body | request | UpdateRoleGroupRequest | Y | リクエスト |

##### UpdateRoleGroupRequest

| 名前 | タイプ | 必須 | 説明 |
| ------------ | ------------- | ------------- | ------------ |
| roles | List&lt;[AssignRoleProtocol](#assignroleprotocol)> | Y | ロールグループに割り当てるロールリスト |

<a id="modify-an-organization-role-groups-role-response-body"></a>
#### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

##### レスポンス

| 名前 | タイプ | 必須 | 説明 |
| ------------ | ------------- | ----------- | ------------ |
| header | [共通レスポンス](#common-response) | Y | |


<a id="modify-organization-member-roles"></a>
### 組織メンバーロール修正 { #modify-organization-member-roles }

> PUT "/v1/organizations/{org-id}/members/{member-uuid}"

該当組織に所属するメンバーのロールを修正するAPIです。


<a id="modify-organization-member-roles-required-permissions"></a>
#### 必要権限
`Organization.Member.Update`


<a id="modify-organization-member-roles-request-parameter"></a>
#### リクエストパラメータ


| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Y | 組織ID | 
|  Path |member-uuid | String| Y | 修正するメンバーのUUID | 
| Request Body | request | UpdateMemberRoleRequest| Y | リクエスト |


##### UpdateMemberRoleRequest


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   assignRoles | List&lt;[UserAssignRoleProtocol](#userassignroleprotocol)>| Y | ユーザーに割り当てるロールリスト |





<a id="modify-organization-member-roles-response-body"></a>
#### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

##### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y   |

<a id="modify-project-member-roles"></a>
### プロジェクトメンバーロール修正 { #modify-project-member-roles }

> PUT "/v1/projects/{project-id}/members/{member-uuid}"

プロジェクトで指定したメンバーのロールを修正するAPIです。

<a id="modify-project-member-roles-required-permissions"></a>
#### 必要権限
`Project.Member.Update`

<a id="modify-project-member-roles-request-parameter"></a>
#### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Y | プロジェクトID | 
|  Path |member-uuid | String| Y | ロール変更対象メンバーUUID | 
| Request Body | request | [UpdateMemberRoleRequest](#updatememberrolerequest)| Y | リクエスト |




<a id="modify-project-member-roles-response-body"></a>
#### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

##### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y   |

<a id="view-organization-iam-members"></a>
### 組織IAMメンバー単件照会 { #view-organization-iam-members }

> GET "/v1/iam/organizations/{org-id}/members/{member-uuid}"

組織に所属するIAMメンバーを照会するAPIです。

<a id="view-organization-iam-members-required-permissions"></a>
#### 必要権限
`Organization.Member.Iam.Get`


<a id="view-organization-iam-members-request-parameter"></a>
#### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Y | 照会する組織ID | 
|  Path |member-uuid | String| Y | 照会する組織のIAMメンバーUUID | 


<a id="view-organization-iam-members-response-body"></a>
#### レスポンス本文

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

##### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y   |
|   orgMember | OrgIamMemberRoleBundleProtocol| N  |

##### OrgIamMemberRoleBundleProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----- | ------------ |
|   corporate | String| N | 会社名 |
|   country | String| N | 国籍(組織Ownerの国籍) |
|   createdAt | Date| N | 作成日時 |
|   creationType | String| N| メンバーの作成タイプ |
|   department | String| N| 部署名 |
|   emailAddress | String| Y | IAMメンバーメールアドレス |
|   englishName | String| N| 英語名 | 
|   id | String| Y | IAMメンバーUUID  |
|   idProviderId | String| N| 外部認証を使用する場合、認証機関ID |
|   idProviderType | String| N| service: IAM直接ログイン<br>sso:顧客SSO連動 |
|   idProviderUserId | String| N| 外部認証機関が提供したユーザーID |
|   lastAccessedAt | Date| N| メンバーの最後の接続日時、ない場合はnullを返す |
|   lastLoggedInAt | Date| N| メンバーの最後のログイン日時、ない場合はnullを返す |
|   lastLoggedInIp | String| N| メンバーの最後のログインIPアドレス、ない場合はnullを返す |
|   maskingEmail | String| N | IAMアカウントのマスキングされたメールアドレス  |
|   mobilePhone | String| N | IAMメンバーの携帯電話番号 |
|   mobilePhoneCountryCode | String| N| 携帯電話番号国コード2桁英字 |
|   name | String| Y | IAMメンバーの名前 |
|   nativeName | String| N| 母国語名 |
|   nickname | String| N| ユーザーの別名 |
|   officeHoursBegin | String| N| 業務開始時間 例: 09:00 |
|   officeHoursEnd | String| N| 業務終了時間 例: 18:00 |
|   organizationId | String| Y | IAMメンバーの組織ID  |
|   passwordChangedAt | Date| N| メンバーの最後のパスワード変更日時、ない場合はnullを返す |
|   position | String| N| 役職 |
|   profileImageUrl | String| N| プロフィールイメージURL |
|   roles | List&lt;[RoleBundleProtocol](#rolebundleprotocol)>| N | 関連ロールリスト(条件属性を含む)  |
|   saasRoles | List&lt;IamMemberRole>| N | IAMメンバーロール |
|   status | String| N| メンバーの状態 |
|   telephone | String| N | IAMメンバーの電話番号 |
|   userCode | String| Y | IAMメンバーID  |



##### IamMemberRole


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------- | ------------ |
|   productId | String| N |
|   productName | String| N |
|   role | String| N |


<a id="list-organization-iam-members"></a>
### 組織IAMメンバーリスト照会 { #list-organization-iam-members }

> GET "/v1/iam/organizations/{org-id}/members"

該当組織に所属するIAMメンバーリストを照会するAPIです。

<a id="list-organization-iam-members-required-permissions"></a>
#### 必要権限
`Organization.Member.Iam.List`

<a id="list-organization-iam-members-request-parameter"></a>
#### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Y | 組織ID | 
|  Query |email | String| N | IAMメンバーのメールアドレス |
|  Query |emailLike | String| N |  |
|  Query |idProviderType | String| N | service: IAM直接ログイン<br>sso:顧客SSO連動 |
|  Query |nameLike | String| N |  |
|  Query |statuses | List&lt;String>| N |  |
|  Query |userCode | String| N | IAMメンバーID |
|  Query |userCodeLike | String| N |  |
|  Query |limit | Integer| N | 1ページあたりの表示件数、デフォルト値20 |
|  Query |page | Integer| N | 対象ページ、デフォルト値1 |

<a id="list-organization-iam-members-response-body"></a>
#### レスポンス本文

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


##### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y   |
|   orgMembers | List&lt;IamOrgMemberProtocol>| N | 組織IAMメンバーリスト |
|   paging | [PagingResponse](#pagingresponse)| N  |

##### IamOrgMemberProtocol

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | --------- | ------------ |
| id | String | N | IAMメンバーUUID | 
| userCode | String | Y | ログイン時に使用するIAMメンバーID | 
| name | String | Y | IAMメンバーのユーザー名 | 
| emailAddress | String |  Y | IAMメンバーのメールアドレス<br>告知を受信したり、パスワード変更案内メール受信する際に使用されます |
| maskingEmail | String | N | IAMメンバーのマスキングされたメールアドレス |
| mobilePhone | String | N | IAMメンバーの携帯電話番号 |
| telephone | String | N | IAMメンバー電話番号 |
| position | String | N | 役職 |
| department | String | N | 部署名 |
| corporate | String | N | 会社名 |
| profileImageUrl | String | N | プロフィールイメージURL |
| englishName | String | N | 英語名 |
| nativeName | String | N | 母国語名 |
| nickname | String | N | ユーザーニックネーム |
| officeHoursBegin | String | N | 業務開始時間例：09:00 |
| officeHoursEnd | String | N | 業務終了時間例：18:00 |
| status | String | Y | メンバーの状態を変更できる<br><ul><li>member:正常利用状態</li><li>leaved:退会リクエスト</li></ul>作成時には必ずmemberを指定する必要があります |
| creationType | String | N | 連携(sso)、招待(invited)、登録(registered) |
| idProviderId | String | N | 外部認証を使用する場合、認証機関ID |
| idProviderType | String | N | service: IAM直接ログイン(デフォルト値)<br>sso:顧客SSO連動(連動されていない場合は設定不可) |
| idProviderUserId | String | N | 外部認証機関が提供したユーザーID |
| createdAt | Date | N | 作成日時 |
| lastAccessedAt | Date | N | 最終接続日時 |
| lastLoggedInAt | Date | N | 最終ログイン日時 |
| lastLoggedInIp | String | N | 最後にログインしたIP |
| passwordChangedAt | Date | N | パスワード変更日時 |
| mobilePhoneCountryCode | String | N | 携帯電話番号国コード2桁英字 |
| organizationId | String | N | IAMメンバーの組織ID |
| country | String | N | 国籍(組織Ownerの国籍) |





<a id="add-an-organization-iam-member"></a>
### 組織IAMメンバー追加 { #add-an-organization-iam-member }

> POST "/v1/iam/organizations/{org-id}/members"

組織にIAMメンバーを追加するAPIです。

<a id="add-an-organization-iam-member-required-permissions"></a>
#### 必要権限
`Organization.Member.Iam.Create`


<a id="add-an-organization-iam-member-request-parameter"></a>
#### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Y | 組織ID | 
| Request Body | request | AddIamOrgMemberRequest| Y | リクエスト |

##### AddIamOrgMemberRequest


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   member | [AddIamOrgMemberProtocol](#addiamorgmemberprotocol)| Y   |


##### AddIamOrgMemberProtocol

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | --------- | ------------ |
| userCode | String | Y | ログイン時に使用するIAMアカウントID | 
| name | String | Y | IAMアカウントのユーザー名 | 
| emailAddress | String |  Y | IAMアカウントのメールアドレス<br>告知を受信したりパスワード変更案内メールを受信するのに使用される |
| mobilePhone | String | N | IAMアカウントの携帯電話番号 |
| telephone | String | N | IAMアカウントの電話番号 |
| position | String | N | 役職 |
| department | String | N | 部署名 |
| corporate | String | N | 会社名 |
| profileImageUrl | String | N | プロフィールイメージURL |
| englishName | String | N | 英語名 |
| nativeName | String | N | 母国語名 |
| nickname | String | N | ユーザーニックネーム |
| officeHoursBegin | String | N | 業務開始時間例：09:00 |
| officeHoursEnd | String | N | 業務終了時間例：18:00 |
| status | String | Y | アカウント状態を変更できる<br><ul><li>member:正常利用状態</li><li>leaved:退会リクエスト</li></ul>作成時には必ずmemberを指定する必要がある |
| creationType | String | N | 連動(sso)、招待(invited)、登録(registered) |
| mobilePhoneCountryCode | String | N | 携帯電話番号国コード2桁英字、携帯電話番号を入力する場合は必須 |



<a id="add-an-organization-iam-member-response-body"></a>
#### レスポンス本文

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


##### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y   |
|   uuid | String| N | IAMメンバーUUID  |




<a id="send-an-iam-member-password-change-email"></a>
### IAMメンバーパスワード変更メール送信 { #send-an-iam-member-password-change-email }

> POST "/v1/iam/organizations/{org-id}/members/{member-id}/send-password-setup-mail"

IAMメンバーのパスワードを変更できるメールを送信するAPIです。

<a id="send-an-iam-member-password-change-email-required-permissions"></a>
#### 必要権限
`Organization.Member.Iam.Update`


<a id="send-an-iam-member-password-change-email-request-parameter"></a>
#### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Y | 対象となる組織ID | 
|  Path |member-id | String| Y | パスワードを変更するIAMメンバーのUUID | 
| Request Body | request | SendPasswordSetupMailRequest| Y | リクエスト |



##### SendPasswordSetupMailRequest


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | --------- | ------------ |
|   locale | String| Y | ユーザーのロケール情報<br>例：ko |
|   returnUrl | String| Y | メール変更通知メールを介してパスワードを変更した後に移動するページアドレス情報<br>移動するアドレス情報には必ずtoast.com, dooray.comまたはnhncloud.comドメインを入力する必要があります。 |


<a id="send-an-iam-member-password-change-email-response-body"></a>
#### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

##### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y   |

<a id="modify-organization-iam-member-information"></a>
### 組織IAMメンバー情報修正 { #modify-organization-iam-member-information }

> PUT "/v1/iam/organizations/{org-id}/members/{member-uuid}"

組織のIAMメンバー情報を修正するAPIです。

<a id="modify-organization-iam-member-information-required-permissions"></a>
#### 必要権限
`Organization.Member.Iam.Update`

<a id="modify-organization-iam-member-information-request-parameter"></a>
#### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Y | 	対象となる組織ID | 
|  Path |member-uuid | String| Y | 変更するIAMメンバーのUUID | 
| Request Body | request | UpdateIamMemberRequest| Y | リクエスト |


##### UpdateIamMemberRequest


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   member | [UpdateIamOrgMemberProtocol](#updateiamorgmemberprotocol)| Y   |

##### UpdateIamOrgMemberProtocol

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | --------- | ------------ |
| userCode | String | Y | ログイン時に使用するIAMアカウントID | 
| name | String | Y | IAMアカウントのユーザー名 | 
| emailAddress | String |  Y | IAMアカウントのメールアドレス<br>告知を受信したりパスワード変更案内メールを受信するのに使用される |
| mobilePhone | String | N | IAMアカウントの携帯電話番号 |
| telephone | String | N | IAMアカウントの電話番号 |
| position | String | N | 役職 |
| department | String | N | 部署名 |
| corporate | String | N | 会社名 |
| profileImageUrl | String | N | プロフィールイメージURL |
| englishName | String | N | 英語名 |
| nativeName | String | N | 母国語名 |
| nickname | String | N | ユーザーニックネーム |
| officeHoursBegin | String | N | 業務開始時間例：09:00 |
| officeHoursEnd | String | N | 業務終了時間例：18:00 |
| status | String | Y | アカウント状態を変更できる<br><ul><li>member:正常利用状態</li><li>leaved:退会リクエスト</li></ul>作成時には必ずmemberを指定する必要がある |
| creationType | String | N | 連動(sso)、招待(invited)、登録(registered) |
| idProviderUserId | String | N | 外部認証機関が提供したユーザーID |
| mobilePhoneCountryCode | String | N | 携帯電話番号国コード2桁英字、携帯電話番号を入力する場合は必須 |


<a id="modify-organization-iam-member-information-response-body"></a>
#### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

##### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y   |

<a id="change-an-organization-iam-member-password"></a>
### 組織IAMメンバーパスワード変更 { #change-an-organization-iam-member-password }

> POST "/v1/iam/organizations/{org-id}/members/{member-id}/set-password"

組織IAMメンバーのパスワードを変更するAPIです。

<a id="change-an-organization-iam-member-password-required-permissions"></a>
#### 必要権限
`Organization.Member.Iam.Update`

<a id="change-an-organization-iam-member-password-request-parameter"></a>
#### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Y | 対象となる組織ID | 
|  Path |member-id | String| Y | パスワードを変更するIAMメンバーのUUID | 
| Request Body | request | UpdateIamPasswordRequest| Y | リクエスト |


##### UpdateIamPasswordRequest


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | --------- | ------------ |
|   password | String| Y  | 設定するパスワード | 


<a id="change-an-organization-iam-member-password-response-body"></a>
#### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

##### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y   |

<a id="listorganization-ip-acls"></a>
### 組織IP ACLリスト照会 { #listorganization-ip-acls }

> GET "/v1/organizations/{org-id}/products/ip-acl"

IP ACL設定を照会するAPIです。

<a id="listorganization-ip-acls-required-permissions"></a>
#### 必要権限
`Organization.Governance.IpAcl.List`

<a id="listorganization-ip-acls-request-parameter"></a>
#### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Y | 組織ID | 


<a id="listorganization-ip-acls-response-body"></a>
#### レスポンス本文

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


##### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y   |
|   orgIpAcl | List&lt;OrgIpAclProtocol>| Y  | 設定結果、空リストの場合は設定されていない状態 |

##### OrgIpAclProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | --------- | ------------ |
|   ips | List&lt;String>| Y  | 許可IP | 
|   productId | String| Y  | サービスID<br>`undefined`の場合、共通設定|

<a id="view-organization-iam-sign-in-session-settings-information"></a>
### 組織IAMログインセッション設定情報を照会 { #view-organization-iam-sign-in-session-settings-information }

> GET "/v1/iam/organizations/{org-id}/settings/session"

ログインセッション設定情報を照会するAPIです。

<a id="view-organization-iam-sign-in-session-settings-information-required-permissions"></a>
#### 必要権限
`Organization.Setting.Iam.Get`

<a id="view-organization-iam-sign-in-session-settings-information-request-parameter"></a>
#### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Y | 組織ID | 


<a id="view-organization-iam-sign-in-session-settings-information-response-body"></a>
#### レスポンス本文

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
#### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
| header | [共通レスポンス](#common-response)| Y   |
| result | Content | Y | 設定内容 |

##### Content

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   multiSessionsLimit | Integer| Y | 許可マルチセッション数 |
|   sessionTimeoutMinutes | Integer| Y | 	セッションタイムアウト |
|   mobileSessionTimeoutMinutes | Integer| Y | 	モバイルセッションタイムアウト |
|   sessionType | String| Y | `fixed`/`idle`. デフォルト値は`fixed`  |

<a id="view-settings-for-organizational-iam-sign-in-second-factor-authentication"></a>
### 組織IAMログイン2段階認証の設定を照会 { #view-settings-for-organizational-iam-sign-in-second-factor-authentication }

> GET "/v1/iam/organizations/{org-id}/settings/security-mfa"

ログイン2段階認証の設定を照会するAPIです。

<a id="view-settings-for-organizational-iam-sign-in-second-factor-authentication-required-permissions"></a>
#### 必要権限
`Organization.Setting.Iam.Get`

<a id="view-settings-for-organizational-iam-sign-in-second-factor-authentication-request-parameter"></a>
#### リクエストパラメータ


| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Y | 組織ID | 

<a id="view-settings-for-organizational-iam-sign-in-second-factor-authentication-response-body"></a>
#### レスポンス本文

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
#### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y   |
|   result | Result| N | レスポンス内容<br>設定したことがない場合はnullが返されます。 |

##### Result
| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   range | Integer| N | 組織/サービス区分<br>organization(共通設定), services(サービス別設定)  |
|   organizationMfaSetting | OrganizationMfaSetting| N | 組織MFA設定情報<br>共通設定 |
|   serviceMfaSettings | ServiceMfaSettings| N | サービス別MFA設定情報  |


##### OrganizationMfaSetting

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   type | String| N | MFAタイプ<br>none(設定しない), totp(Google OTP), email(メール) |
|   bypassByIp | BypassByIp| N | 例外IP  |

##### ServiceMfaSettings


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   serviceId | String| N | サービスID  |
|   type | String| N | MFAタイプ<br>none(設定しない), totp(Google OTP), email(メール) |
|   bypassByIp | BypassByIp| N | 例外IP |

##### BypassByIp

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   enable | Boolean| N | 有効化状態<br>`true`(使用中), `false`(使用しない)  |
|   ipList | List&lt;String>| N | 例外IPリスト |

<a id="view-organization-iam-login-failure-security-settings"></a>
### 組織IAMログイン失敗セキュリティ設定を照会 { #view-organization-iam-login-failure-security-settings }

> GET "/v1/iam/organizations/{org-id}/settings/security-login-fail"

ログイン失敗セキュリティ設定を照会するAPIです。

<a id="view-organization-iam-login-failure-security-settings-required-permissions"></a>
#### 必要権限
`Organization.Setting.Iam.Get`

<a id="view-organization-iam-login-failure-security-settings-request-parameter"></a>
#### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Y | 組織ID | 


<a id="view-organization-iam-login-failure-security-settings-response-body"></a>
#### レスポンス本文

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
#### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
| header | [共通レスポンス](#common-response)| Y   |
| result | Result | N | ログイン失敗セキュリティを設定した場合のみ返され、設定しない場合はnullが返されます。 |

##### Result

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   enable | Boolean| Y | 有効化状態<br>`true`(使用中), `false`(使用しない)  |
|   loginFailCount | LoginFailCount| N | ログイン失敗セキュリティ設定 |


##### LoginFailCount

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   limit | Integer| N | 試行許可回数 |
|   blockMinutes | Integer| N | ログイン禁止時間 |

<a id="get-your-organizations-iam-account-password-policy"></a>
### 組織 IAM アカウントパスワードポリシー照会 { #get-your-organizations-iam-account-password-policy }

> GET "/v1/iam/organizations/{org-id}/settings/password-rule"

パスワードポリシーの設定を照会する API です。

<a id="get-your-organizations-iam-account-password-policy-required-permissions"></a>
#### 必要な権限

`Organization.Setting.Iam.Get`

<a id="get-your-organizations-iam-account-password-policy-request-parameter"></a>
#### 要請パラメータ

| 区分 | 名前 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Y | 組織ID |

<a id="get-your-organizations-iam-account-password-policy-response-body"></a>
#### レスポンスボディ

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

<a id="get-your-organizations-iam-account-password-policy-response"></a>
#### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
| header | [共通レスポンス](#common-response)| Y   |
| result | Content | Y | 設定内容 |

##### Content

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
| schemaVersion | Integer| Y | スキーマバージョン  |
| value | Value| Y |  パスワードポリシー |

##### Value

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
| ruleType | String | Y | パスワードポリシー<br>`default`(デフォルトのパスワードポリシー), `custom`(カスタムパスワードポリシー) |
| passwordConstraints | PasswordConstraints | Y | パスワード強度 |
| passwordExpiry | PasswordExpiry | Y | パスワード有効期限 |
| limitPasswordReuse | LimitPasswordReuse | Y | パスワード再利用制限 |
| applyRule | String | Y | パスワードポリシーの適用タイミング<br>`onChangePassword`(パスワード変更時に適用), `onLogin`(即座に適用) |

##### PasswordConstraints

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
| minLength | Integer | Y | パスワードの最小文字数 |
| mustNotIncludeIllegalSequence | Boolean | Y | 英字1文字以上<br>true(設定), false(設定しない) |
| mustIncludeUpperCase | Boolean | Y | 英大文字1文字以上<br>true(設定), false(設定しない) |
| mustIncludeLowerCase | Boolean | Y | 英小文字1文字以上<br>true(設定), false(設定しない) |
| mustIncludeNumberCase | Boolean | Y | 数字1文字以上<br>true(設定), false(設定しない) |
| mustIncludeSpecialCase | Boolean | Y | 特殊文字1文字以上<br>true(設定), false(設定しない) |

##### PasswordExpiry

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
| enable | Boolean | Y | 使用有無<br>true(設定), false(設定しない) |
| expiryDays | Integer | Y | 有効期間 |
| allowExpend | Boolean | Y | 有効期限切れ時の延長可否<br>true(可能), false(不可) |

##### LimitPasswordReuse

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
| enable | Boolean | Y | 使用有無<br>true(設定), false(設定しない) |
| limitCount | Integer | Y | 再利用制限回数 |

<a id="get-the-price-of-a-service-on-a-pay-as-you-go-subscription"></a>
### 従量制に登録された商品価格照会 { #get-the-price-of-a-service-on-a-pay-as-you-go-subscription }

> POST "/v1/billing/contracts/basic/products/prices/search"

カウンターに設定された単価を照会するAPIです。
言語ごとに表示名、金額計算のための種類を知ることができます。


<a id="get-the-price-of-a-service-on-a-pay-as-you-go-subscription-required-permissions"></a>
#### 必要権限
会員であれば特定の権限なしで呼び出し可能なAPIです。

<a id="get-the-price-of-a-service-on-a-pay-as-you-go-subscription-request-parameter"></a>
#### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Query |limit | Integer| N |  |
| Request Body | request | GetContractProductPriceRequest| Y | リクエスト |

<a id="get-the-price-of-a-service-on-a-pay-as-you-go-subscription-getcontractproductpricerequest"></a>
#### GetContractProductPriceRequest
| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | --------- | ------------ |
|  counterNames | List&lt;String>| N | 商品メタのcounter Nameリスト<br>ない場合は全体検索する |
|   paging | Paging| N  |

##### Paging

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   limit | Integer| N | 1ページあたりの表示件数、デフォルト値20  |
|   page | Integer| N | 対象ページ、デフォルト値1  |


<a id="get-the-price-of-a-service-on-a-pay-as-you-go-subscription-response-body"></a>
#### レスポンス本文

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

##### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y   |
|   paging | PagingResponse| Y | ソート基準がないページング結果を返す |
|   prices | List&lt;ContractProductPriceProtocol>| Y | カウンターの単価情報を配列で返す<br>エラー時は含まれません。  |

##### PagingResponse

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------- | ------------ |
|   limit | Integer| Y | 照会される数制限<br>デフォルト値は20 |
|   page | Integer| Y |
|   totalCount | Integer| Y |

##### ContractProductPriceProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   contractDiscountPolicyId | String| Y | 約定料金ポリシーID  |
|   contractId | String| Y | 約定ID  |
|   counterName | String| Y | カウンター |
|   displayNameEn | String| N | 	カウンターの英語名 |
|   displayNameJa | String| N | カウンターの日本語名 |
|   displayNameKo | String| Y | カウンターの韓国語名 |
|   displayNameZh | String| N | 	カウンターの中国語名<br>現在は英語で表示されます |
|   monthFrom | String| Y | 単価情報が有効な開始月(含む)  |
|   monthTo | String| Y | 単価情報が有効な終了月(含まない)  |
|   originalPrice | BigDecimal| Y | 単価 |
|   price | BigDecimal| Y | 単価 |
|   rangeFrom | BigDecimal| Y | 単価に属する使用量範囲開始(含まない)  |
|   rangeTo | BigDecimal| Y | 単価に属する使用量範囲終了(含む)  |
|   seq | Long| Y | シリアル番号 |
|   slidingCalculationTypeCode | String| Y | スライディング料金計算タイプ<br>`NONE`, `SECTION_SUM`, `SECTION_SELECTED` |
|   useFixPriceYn | String| Y | 固定金額かどうか(Y:固定金額、 N:単価計算)<br>Y:範囲に入る場合priceが金額になる<br>N: (使用量x単価)が金額になる |

<a id="list-services-enrolled-in-a-pay-as-you-go-subscription"></a>
### 従量制に登録されたサービスリスト照会 { #list-services-enrolled-in-a-pay-as-you-go-subscription }

> GET "/v1/billing/contracts/basic/products"

請求書に表示されるメインカテゴリーとサブカテゴリー及び含まれるカウンターのリストを提供するAPIです。

<a id="list-services-enrolled-in-a-pay-as-you-go-subscription-required-permissions"></a>
#### 必要権限
会員であれば特定の権限なしで呼び出し可能なAPIです。

<a id="list-services-enrolled-in-a-pay-as-you-go-subscription-request-parameter"></a>
#### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Query |limit | Integer| N | 照会される数制限<br>デフォルト値は20 |
|  Query |page | Integer| N |  |


<a id="list-services-enrolled-in-a-pay-as-you-go-subscription-response-body"></a>
#### レスポンス本文

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


##### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y   |
|   paging | [PagingResponse](#pagingresponse)| Y  |
|   products | List&lt;ProductMetadata>| Y | サービスメタ情報リスト |


##### ProductMetadata


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   budgetUsageTypeYn | String| N | 予算使用量タイプYn  Y, N |
|   calcUnitCode | String| Y | 金額計算時に使用する単位(計量単位を精算単位に変換して金額計算を行う)、明細書に表示する単位<br>KB, MB, GB, TB, SECONDS, MINUTE, HOURS, DAYS, MB_HOURS, GB_SECONDS, GB_HOURS, GB_DAYS, CORE_SECONDS, CORE_HOURS, CORE_DAYS, USERS, MAU, MAD, DAU, CALLS, COUNTS, CCU, VCPU_HOURS, COUNT_HOURS |
|   categoryMain | String| Y | メインカテゴリー |
|   categorySub | String| Y | サブカテゴリー |
|   chargingTypeId | String| Y | 課金タイプID  |
|   convertUsageTypeCode | String| Y | 使用量変換タイプコード  `NONE`, `HOUR_AVERAGE`, `DAY_AVERAGE` |
|   counterName | String| Y | カウンター |
|   counterTypeCode | String| Y | 使用量の合算方法<br><ul><li>DELTA: 増加値(HOURLY_SUM)</li><li>GAUGE: 時間最大値の合計(HOURLY_MAXに変更予定)</li><li>HOURLY_LATEST: 1時間の間に収集されたデータのうち、最も遅く収集されたメータリングデータの合計</li><li>DAILY_MAX: 日最大値の合計</li><li>MONTHLY_MAX: 月最大値</li><li>STATUS: 使用状況</li><ul> |
|   description | String| N | カウンターの説明 |
|   displayOrder | Integer| Y | 表示順序 |
|   marketPlaceMandatoryUsePeriod | Integer| N | マーケットプレイス必須使用期間 |
|   meterUnitCode | String| Y | サービスでメータリング保存時の使用量単位<br>BYTES, KB, MB, GB, TB, CORE, HOURS, MINUTE, USERS, MAU, MAD, DAU, CALLS, COUNTS, CCU, SECONDS |
|   minUsage | BigDecimal| Y | 最小使用量 |
|   parentCounterName | String| Y | 親カウンター名 |
|   productId | String| Y | サービスID  |
|   productMetadataStatusCode | String| Y | カウンターステータスコード  `STABLE`, `CLOSED` |
|   productUiId | String| Y | Webサイトカテゴリー/Webサイトサービス識別ID  |
|   regionTypeCode | String| Y | カウンターネームが所属するリージョンコード<br><ul><li>GLOBAL: Globalサービスに属するカウンターネーム</li><li>NONE: GLOBALと同じ意味</li><li>KR1: KR1リージョンに属するカウンターネーム</li><li>KR2: KR2リージョンに属するカウンターネーム</li><li>...:該当リージョンに属するカウンターネーム</li><ul>  |
|   unit | Long| Y | 精算単位 |
|   unitName | String| Y | 請求書に表示する名前 |
|   usageAggregationUnitCode | String| N | 使用量集計単位<br>RESOURCE_ID, COUNTER_NAME |

<a id="view-charges-by-payment-statement"></a>
### 請求書別利用金額照会 { #view-charges-by-payment-statement }

> GET "/v1/billing/members/payment-statements"

請求書単位の利用金額を照会するAPIです。

<a id="view-charges-by-payment-statement-required-permissions"></a>
#### 必要な権限
`Member.PaymentStatement.Get`

<a id="view-charges-by-payment-statement-request-parameter"></a>
#### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Query |month | String| Y | 請求月（yyyy-MM） |
|  Query |paymentGroupIds | List&lt;String>| N | 決済グループIDフィルタ（複数）<br>未指定の場合、照会可能なすべての決済グループを照会します。 |

<a id="view-charges-by-payment-statement-response-body"></a>
#### レスポンス本文

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
    "paymentInfo": "[ヒュンダイカード] 4403***",
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

##### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y   |
|   paymentStatementCharges | List&lt;Charge>| Y | 決済グループ別利用金額リスト  |

##### Charge

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   uuid | String| Y | メンバーUUID  |
|   paymentGroupId | String| Y | 決済グループID  |
|   month | Date| Y | 請求月  |
|   country | String| Y | 国コード  |
|   paymentStatusCode | String| Y | 決済ステータスコード<br><ul><li>REGISTERED: 登録</li><li>READY: 決済待機</li><li>PAID: 決済完了</li><li>ERROR: 運営者確認が必要な状態</li></ul> |
|   autoPaymentTypeCode | String| Y | 決済手段タイプ  |
|   paymentInfo | String| N | 決済手段情報  |
|   chargeAmount | Long| Y | 利用金額  |
|   totalDiscountAmount | Long| Y | 割引金額  |
|   totalExtraAmount | Long| Y | 割増金額  |
|   taxAmount | Long| Y | 消費税額（切り捨て前）  |
|   freeCreditAmount | Long| Y | 無料クレジット使用金額（全体型・制限型合計）  |
|   paidCreditAmount | Long| Y | 有料クレジット使用金額（全体型・制限型合計）  |
|   freeCreditAllAmount | Long| Y | 全体型無料クレジット使用金額  |
|   freeCreditLimitAmount | Long| Y | 制限型無料クレジット使用金額  |
|   paidCreditAllAmount | Long| Y | 全体型有料クレジット使用金額  |
|   paidCreditLimitAmount | Long| Y | 制限型有料クレジット使用金額  |
|   totalCreditAmount | Long| Y | クレジット総使用金額  |
|   prePaidTotalAmount | Long| Y | 前払い適用金額  |
|   cutoffAmount | Long| Y | 切り捨て金額（500ウォン未満）  |
|   lateFeeAmount | Long| Y | 延滞料  |
|   totalAmount | Long| Y | 最終請求金額（消費税込み）  |
|   chargedSupplyAmount | Long| Y | 実供給価額<br>クレジット・前払い・切り捨てを反映した実請求金額 |
|   chargedTaxAmount | Long| Y | 実消費税<br>クレジット・前払い・切り捨てを反映した実請求金額 |
|   chargedTotalAmount | Long| Y | 実決済金額<br>実供給価額＋実消費税＋延滞料 |
|   receiptStatusCode | String| Y | 売上伝票ステータスコード<br><ul><li>NONE: 売上伝票を表示できない状態</li><li>EXIST: 売上伝票を表示できる状態</li></ul> |
|   refundAccountRegisterStatusCode | String| N | 返金口座登録ステータスコード<br><ul><li>ALLOW: 返金口座登録Open状態</li><li>DENY: 返金口座登録Close状態（デフォルト）</li></ul> |


<a id="view-charge-summaries-by-scope"></a>
### ビリンググループ、組織、プロジェクト別利用料金照会 { #view-charge-summaries-by-scope }

> GET "/v1/billing/members/payment-statements/charge-summaries"

利用料金をビリンググループ/組織/プロジェクト単位で集計して照会するAPIです。

!!! danger "注意"
    * 2020年5月以降の請求月のみ照会できます。
    * `groupBy`には決済グループ(PAYMENT_GROUP)を指定することはできません。決済グループ単位の利用料金は[請求書別利用料金照会](#view-charges-by-payment-statement)を使用してください。

<a id="view-charge-summaries-by-scope-required-permissions"></a>
#### 必要な権限
`Member.PaymentStatement.Get`

<a id="view-charge-summaries-by-scope-request-parameter"></a>
#### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Query |month | String| Y | 請求月(yyyy-MM)<br>2020-05以降のみサポート |
|  Query |groupBy | String| Y | 集計基準(単一)<br><ul><li>BILLING_GROUP: ビリンググループ</li><li>ORG: 組織</li><li>PROJECT: プロジェクト</li></ul> |
|  Query |paymentGroupIds | List&lt;String>| N | 決済グループIDフィルタ(複数、最大10件) |
|  Query |billingGroupIds | List&lt;String>| N | ビリンググループIDフィルタ(複数、最大10件) |
|  Query |orgIds | List&lt;String>| N | 組織IDフィルタ(複数、最大10件) |
|  Query |projectIds | List&lt;String>| N | プロジェクトIDフィルタ(複数、最大10件) |
|  Query |cursor | String| N | 次のページカーソル<br>未指定の場合、最初のページを照会 |
|  Query |size | Integer| N | ページあたりの表示件数(10〜100)<br>デフォルト20 |

<a id="view-charge-summaries-by-scope-response-body"></a>
#### レスポンス本文

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
    "billingGroupName": "請求グループ名",
    "orgId": "eNWZ3jZq2FsMSHaQ",
    "orgName": "組織名",
    "projectId": "KGDeiKUq",
    "projectName": "プロジェクト名",
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

##### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y   |
|   groupBy | String| Y | リクエストした集計基準  |
|   chargeSummaries | List&lt;ChargeSummary>| Y | 請求グループ、組織、プロジェクト別の利用金額リスト  |
|   nextCursor | String| N | 次のページカーソル<br>最後のページの場合はnull |

##### ChargeSummary

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- |----| ----------- |
|   paymentGroupId | String| Y  | 決済グループID |
|   billingGroupId | String| Y  | 請求グループID |
|   billingGroupName | String| N  | 請求グループ名 |
|   orgId | String| N  | 組織ID<br>`groupBy=ORG`、`groupBy=PROJECT`の場合のみ返却 |
|   orgName | String| N  | 組織名<br>`groupBy=ORG`、`groupBy=PROJECT`の場合のみ返却 |
|   projectId | String| N  | プロジェクトID<br>`groupBy=PROJECT`の場合のみ返却 |
|   projectName | String| N  | プロジェクト名<br>`groupBy=PROJECT`の場合のみ返却 |
|   country | String| Y  | 国コード  |
|   chargeAmount | Long| Y  | 利用金額  |
|   contractDiscountAmount | Long| Y  | 契約による割引金額 |
|   ocpDiscountAmount | Long| Y  | Optimized Cost Plans(OCPs)割引金額 |
|   billingGroupDiscountAmount | Long| Y  | 請求グループ割引金額 |
|   projectDiscountAmount | Long| Y  | プロジェクト割引金額 |
|   totalDiscountAmount | Long| Y  | 割引金額合計 |
|   contractExtraAmount | Long| Y  | 契約による割増金額 |
|   billingGroupExtraAmount | Long| Y  | 請求グループ割増金額 |
|   projectExtraAmount | Long| Y  | プロジェクト割増金額 |
|   totalExtraAmount | Long| Y  | 割増金額合計 |
|   totalCreditLimitAmount | Long| Y  | 制限型クレジット適用金額 |
|   prePaidTotalAmount | Long| Y  | 前払い適用金額 |
|   totalAmount | Long| Y  | 最終金額（消費税別）<br>利用金額 - 割引金額 + 割増金額 - 制限型クレジット適用金額 - 前払い適用金額 |


<a id="view-individual-charge-lines"></a>
### 詳細明細の利用金額照会 { #view-individual-charge-lines }

> GET "/v1/billing/members/payment-statements/usages"

詳細明細単位の利用金額を照会するAPIです。

!!! danger "注意"
    * 2020年5月以降の請求月のみ照会できます。

<a id="view-individual-charge-lines-required-permissions"></a>
#### 必要な権限
`Member.PaymentStatement.Get`

<a id="view-individual-charge-lines-request-parameter"></a>
#### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Query |month | String| Y | 請求月(yyyy-MM)<br>2020-05以降のみサポート |
|  Query |paymentGroupIds | List&lt;String>| N | 決済グループIDフィルタ(複数、最大10件) |
|  Query |billingGroupIds | List&lt;String>| N | ビリンググループIDフィルタ(複数、最大10件) |
|  Query |orgIds | List&lt;String>| N | 組織IDフィルタ(複数、最大10件) |
|  Query |projectIds | List&lt;String>| N | プロジェクトIDフィルタ(複数、最大10件) |
|  Query |categoryMains | List&lt;String>| N | メインカテゴリフィルタ(複数、最大10件) |
|  Query |regions | List&lt;String>| N | リージョンフィルタ(複数、最大10件) |
|  Query |stationIds | List&lt;String>| N | ステーションIDフィルタ(複数、最大10件) |
|  Query |cursor | String| N | 次ページカーソル<br>未指定の場合は先頭ページを照会 |
|  Query |size | Integer| N | ページあたりの表示件数(10〜100)<br>デフォルト: 20 |

<a id="view-individual-charge-lines-response-body"></a>
#### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  },
  "usages": [ {
    "projectId": "KGDeiKUq",
    "projectName": "プロジェクト名",
    "resourceId": "5f1ab1a1-4e6e-4f66-9b1e-2b3f5c6d7e8f",
    "resourceName": "インスタンス名",
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
    "unitName": "時間",
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

##### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y   |
|   usages | List&lt;UsageLine>| Y | 詳細内訳リスト  |
|   nextCursor | String| N | 次のページカーソル<br>最後のページの場合はnull |

##### UsageLine

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   projectId | String| N | プロジェクトID  |
|   projectName | String| N | プロジェクト名  |
|   resourceId | String| N | リソースID  |
|   resourceName | String| N | リソース名  |
|   parentResourceId | String| N | 親リソースID  |
|   parentResourceName | String| N | 親リソース名  |
|   counterName | String| N | カウンター名  |
|   categoryMain | String| N | メインカテゴリ  |
|   categorySub | String| N | サブカテゴリ  |
|   regionTypeCode | String| N | リージョンタイプコード  |
|   stationId | String| N | ステーションID  |
|   stationName | String| N | ステーション名  |
|   displayNameKo | String| N | 課金単位表示名(ko)  |
|   displayNameEn | String| N | 課金単位表示名(en)  |
|   displayNameJa | String| N | 課金単位表示名(ja)  |
|   displayNameZh | String| N | 課金単位表示名(zh)  |
|   unitName | String| N | 単位名  |
|   unit | Long| Y | 課金単位  |
|   usageVolume | BigDecimal| Y | 使用量  |
|   unitPrice | BigDecimal| Y | 従量制単価  |
|   contractUnitPrice | BigDecimal| Y | 契約制単価  |
|   chargeAmount | Long| Y | 利用金額(従量制)  |
|   contractAmount | Long| Y | 契約適用金額  |
|   discountAmount | Long| Y | 契約割引金額  |
|   discountTypeCode | String| N | 割引タイプコード<br>BASIC, CONTRACT, OCP |
|   prePaidAmount | Long| Y | 前払い適用金額  |
|   costPlanOrderId | String| N | Optimized Cost Plans(OCPs) 注文ID  |


<a id="view-charge-filter-dimensions"></a>
### 利用金額検索条件値リスト照会 { #view-charge-filter-dimensions }

> GET "/v1/billing/members/payment-statements/dimensions"

利用金額照会時にフィルタとして使用できる検索条件区分（`dimension`）ごとの選択肢リストを照会するAPIです。

!!! danger "注意"
    * 2020年5月以降の請求月のみ照会できます。

!!! tip "ポイント"
    * [ビリンググループ、組織、プロジェクト別利用金額照会](#view-charge-summaries-by-scope)と同じ対象から選択肢を抽出するため、ここで照会した値をそのままフィルタとして使用できます。
    * 検索条件区分（`dimension`）は決済グループ > ビリンググループ > 組織 > プロジェクトの階層を持ち、上位検索条件区分（`parentDimension`）と各選択肢の上位識別子・名前が一緒に返されます。


<a id="view-charge-filter-dimensions-required-permissions"></a>
#### 必要な権限
`Member.PaymentStatement.Get`

<a id="view-charge-filter-dimensions-request-parameter"></a>
#### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Query |dimension | String| Y | 照会する検索条件の区分（単一）<br><ul><li>PAYMENT_GROUP: 決済グループ</li><li>BILLING_GROUP: ビリンググループ</li><li>ORG: 組織</li><li>PROJECT: プロジェクト</li></ul> |
|  Query |month | String| Y | 請求月（yyyy-MM）<br>2020-05以降のみサポート |
|  Query |paymentGroupIds | List&lt;String>| N | 決済グループIDフィルタ（複数、最大10件） |
|  Query |billingGroupIds | List&lt;String>| N | ビリンググループIDフィルタ（複数、最大10件） |
|  Query |orgIds | List&lt;String>| N | 組織IDフィルタ（複数、最大10件） |
|  Query |orgOwnerIds | List&lt;String>| N | 組織オーナーUUIDフィルタ（複数、最大10件）<br>該当請求月に指定したUUIDが所有する組織の利用料金がある値のみ返します。 |
|  Query |cursor | String| N | 次のページカーソル<br>未指定の場合は最初のページを照会します |
|  Query |size | Integer| N | 1ページあたりの表示件数（10〜100）<br>デフォルト20 |

<a id="view-charge-filter-dimensions-response-body"></a>
#### レスポンス本文

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
    "name": "プロジェクト名",
    "ownerId": "4ea1d0b8-6bbd-4b3c-b1a9-9f4c6e6a1d2f",
    "parentId": "eNWZ3jZq2FsMSHaQ",
    "parentName": "組織名"
  } ],
  "nextCursor": "S0dEZWlLVXE"
}
```

##### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y   |
|   uuid | String| Y | 照会対象メンバーUUID  |
|   dimension | String| Y | 照会した検索条件の区分<br>PAYMENT_GROUP, BILLING_GROUP, ORG, PROJECT |
|   parentDimension | String| N | 上位検索条件の区分<br>最上位(PAYMENT_GROUP)の場合はnull |
|   values | List&lt;DimensionValue>| Y | 検索条件区分別フィルタ選択肢リスト  |
|   nextCursor | String| N | 次のページカーソル<br>最終ページの場合はnull |

##### DimensionValue

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   id | String| Y | 識別子  |
|   name | String| Y | 表示名  |
|   ownerId | String| N | 所有者UUID<br>`dimension=ORG`、`dimension=PROJECT`の場合は所属組織の所有者 |
|   parentId | String| N | 上位検索条件区分の識別子<br>最上位(決済グループ)の場合はnull |
|   parentName | String| N | 上位検索条件区分の表示名<br>最上位(決済グループ)の場合はnull |


<a id="get-project-integrated-appkey"></a>
### プロジェクト統合Appkey照会 { #get-project-integrated-appkey }

> GET "/v1/authentications/projects/{project-id}/project-appkeys"

プロジェクトで使用中のプロジェクト統合Appkey一覧を照会するAPIです。

<a id="get-project-integrated-appkey-required-permissions"></a>
#### 必要権限
`Project.ProjectAppKey.List`

<a id="get-project-integrated-appkey-request-parameter"></a>
#### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Y | 照会対象プロジェクトID | 


<a id="get-project-integrated-appkey-response-body"></a>
#### レスポンス本文

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

##### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | --------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y |
|   authenticationList | List&lt;ProjectAppKeyResponse>| N | プロジェクト統合Appkey一覧 |

##### ProjectAppKeyResponse

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   authId | String| N | 内部的に管理する認証手段ID  |
|   appKey | String| N | コンソールに表示されるプロジェクト統合Appkey |
|   authStatus | String| N | 認証ステータスコード(STABLE, STOP, BLOCKED) |
|   projectId | String| N | プロジェクトID |
|   lastUsedDatetime | Date| N | 最終使用日時 |
|   modDatetime | Date| N | 削除日時 |
|   reIssueDatetime | Date| N | 再作成日時 |
|   regDatetime | Date| N | 作成日時 |

<a id="listuser-access-key-ids"></a>
### User Access Key IDリスト照会 { #listuser-access-key-ids }

> GET "/v1/authentications/user-access-keys"

メンバーのUser Access Key IDリストを照会するAPIです。

<a id="listuser-access-key-ids-required-permissions"></a>
#### 必要権限
会員であれば特定の権限なしで呼び出し可能なAPIです。


<a id="listuser-access-key-ids-response-body"></a>
#### レスポンス本文

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
    "modDateTime": "2000-01-23T04:56:07.000+00:00",
    "authId": "authId",
    "uuid": "uuid",
    "tokenExpiryPeriod": 0,
    "tokenFormatCode" : "OPAQUE",    
    "lastUsedDatetime": "2000-01-23T04:56:07.000+00:00",
    "reIssueDatetime": "2000-01-23T04:56:07.000+00:00",
    "regDatetime": "2000-01-23T04:56:07.000+00:00"
    "regDatetime": "2000-01-23T04:56:07.000+00:00",
    "lastTokenUsedDatetime": "2025-02-11T01:30:56.771Z",
    "validTokenCount": 0
  } ]
}
```


##### レスポンス


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y   |
|   authentications | List&lt;UserAccessKeyResponse>| N | 認証情報リスト |

##### UserAccessKeyResponse

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   authId | String| N | 内部的に管理する認証手段ID  |
|   userAccessKeyID | String| N | User Access Key ID  |
|   secretAccessKey | String| N | 秘密鍵(マスキング処理されます)  |
|   authStatus | String| N | 認証ステータスコード(STABLE, STOP, BLOCKED) |
|   uuid | String| N | ユーザーUUID |
|   lastUsedDatetime | Date| N | User Access Key IDで最後に認証した日時 |
|   modDatetime | Date| N | 削除日時 |
|   reIssueDatetime | Date| N | 再作成日時 |
|   regDatetime | Date| N | 作成日時 |
|   tokenExpiryPeriod | Long| N | トークン有効期限周期(秒単位)  |
|   tokenFormatCode | String | N | トークンフォーマットコード(OPAQUE、JWT) |
|   lastTokenUsedDatetime | Long| N | トークンで最後に認証/認可した日時           |
|   validTokenCount | Long| N | 有効なトークン数                    |

<a id="register-a-integrated-project-appkey"></a>
### プロジェクト統合Appkey登録 { #register-a-integrated-project-appkey }

> POST "/v1/authentications/projects/{project-id}/project-appkeys"

プロジェクトで使用するアプリキーを作成するAPIです。

<a id="register-a-integrated-project-appkey-required-permissions"></a>
#### 必要権限
`Project.ProjectAppKey.Create`


<a id="register-a-integrated-project-appkey-request-parameter"></a>
#### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
| Path | project-id | String| Y | AppKeyを登録するプロジェクトID |
| Request Body | request | AddProjectアプリキーRequest| Y | リクエスト |

##### AddProjectAppKeyRequest

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   appkeyAlias | String | Y   | プロジェクト統合Appkeyエイリアス<br>100文字制限 |


<a id="register-a-integrated-project-appkey-response-body"></a>
#### レスポンス本文

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

##### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y   |
|   authentication | ResponseProtocol| N  |

##### ResponseProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----- | ------------ |
|   authId | String| N | 内部的に管理する認証手段ID  |
|   appKey | String| N | プロジェクト統合Appkey |

<a id="register-a-user-access-key-id"></a>
### User Access Key ID登録 { #register-a-user-access-key-id }

> POST "/v1/authentications/user-access-keys"

メンバーのUser Access Key IDを登録するAPIです。

<a id="register-a-user-access-key-id-required-permissions"></a>
#### 必要権限
会員であれば特定の権限なしで呼び出し可能なAPIです。

<a id="register-a-user-access-key-id-request-parameter"></a>
#### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
| Request Body | PostUserAppKeyRequest | PostUserAppKeyRequest| Y |  | |


##### PostUserAppKeyRequest

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   tokenFormatCode | String | N | トークンフォーマットコード<br>OPAQUEとJWTフォーマットを提供し、現在JWTフォーマットトークンはEasyQueueサービスでのみ使用可能<br>デフォルト値はOPAQUE |
|   tokenExpiryPeriod | Long| N | トークン有効期限<br>秒単位であり、OPAQUEフォーマットトークンの場合はデフォルト値が1日、JWTトークンは1時間<br>OPAQUEフォーマットトークンは最小1分から最大1日まで有効なトークンを作成可能で、JWTフォーマットトークンは最小1分から最大1時間まで有効なトークンを作成可能 |


<a id="register-a-user-access-key-id-response-body"></a>
#### レスポンス本文

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

##### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y   |
|   authentication | ResponseProtocol| N  |

##### ResponseProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----- | ------------ |
|   authId | String| N | 内部的に管理する認証手段ID  |
|   userAccessKeyID | String| N | User Access Key ID  |
|   secretAccessKey | String| N | 秘密鍵 |
|   tokenExpiryPeriod | Long| N | トークン有効期限(秒単位)

|   tokenFormatCode | String | N | トークンフォーマットコード(OPAQUE、JWT) |

<a id="delete-a-project-integrated-appkey"></a>
### プロジェクト統合Appkey削除 { #delete-a-project-integrated-appkey }

> DELETE "/v1/authentications/projects/{project-id}/project-appkeys/{app-key}"

プロジェクトアプリキーを削除するAPIです。

<a id="delete-a-project-integrated-appkey-required-permissions"></a>
#### 必要権限
`Project.ProjectAppKey.Delete`


<a id="delete-a-project-integrated-appkey-request-parameter"></a>
#### リクエストパラメータ


| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
| Path | project-id | String| Y | 対象プロジェクトID |
|  Path |app-key | String| Y | 削除するプロジェクト統合Appkey |


<a id="delete-a-project-integrated-appkey-response-body"></a>
#### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```
##### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y   |


<a id="reissue-the-user-access-key-id-secret-key"></a>
### User Access Key ID秘密鍵再発行 { #reissue-the-user-access-key-id-secret-key }

> PUT "/v1/authentications/user-access-keys/{user-access-key-id}/secretkey-reissue"

User Access Key IDの秘密鍵を再発行するAPIです。<br>
OPAQUEトークン用のUser Access Key IDを停止するとOPAQUEトークンも一緒に期限切れになり、JWTトークン用のUser Access Key IDは停止してもJWTトークンは期限切れになりません。

<a id="reissue-the-user-access-key-id-secret-key-required-permissions"></a>
#### 必要権限
自分のUser Access Key ID秘密鍵のみ再発行可能

<a id="reissue-the-user-access-key-id-secret-key-request-parameter"></a>
#### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |user-access-key-id | String| Y | User Access Key ID | 
| Request Body | request | ReissueSecretKeyRequest| Y | リクエスト |


##### ReissueSecretKeyRequest

| 名前 | タイプ   | 必須 | 説明                                             |   
|------------ |---------|----|---------------------------------------------------|
|   needExpireTokens | Boolean | N | 発行されたトークンが期限切れかどうか(true:期限切れ、false:期限切れではない)<br>デフォルト値false |


<a id="reissue-the-user-access-key-id-secret-key-response-body"></a>
#### レスポンス本文

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

##### レスポンス


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | --------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y |
|   authentication | ResponseProtocol| N  |

##### ResponseProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   secretAccessKey | String| Y   | シークレットキー |

<a id="modify-user-access-key-id-status"></a>
### User Access Key ID状態の修正 { #modify-user-access-key-id-status }

> PUT "/v1/authentications/user-access-keys/{user-access-key-id}"

メンバーのUser Access Key IDの状態を変更するAPIです。

<a id="modify-user-access-key-id-status-required-permissions"></a>
#### 必要権限
自分のUser Access Key IDのみ修正可能

<a id="modify-user-access-key-id-status-request-parameter"></a>
#### リクエストパラメータ


| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path | user-access-key-id | String| Y | User Access Key ID | 
| Request Body | request | UpdateUserAccessKeyStatusRequest| Y | リクエスト |


##### UpdateUserAccessKeyStatusRequest

| 名前 | タイプ | 必須 | 説明 |   
|----------- | ------------- | ------------- | ------------ |
|   status | String| Y | 変更する状態(STOP:停止、 STABLE:使用) |

<a id="modify-user-access-key-id-status-response-body"></a>
#### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

##### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y   |

<a id="delete-a-user-access-key-id"></a>
### User Access Key ID削除 { #delete-a-user-access-key-id }

> DELETE "/v1/authentications/user-access-keys/{user-access-key-id}"

User Access Key IDを削除するAPIです。

<a id="delete-a-user-access-key-id-required-permissions"></a>
#### 必要権限
自分のUser Access Key IDのみ削除可能

<a id="delete-a-user-access-key-id-request-parameter"></a>
#### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path | user-access-key-id | String| Y | User Access Key ID | 


<a id="delete-a-user-access-key-id-response-body"></a>
#### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

##### レスポンス


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y |


<a id="get-a-list-of-tokens"></a>
### トークンリスト照会 { #get-a-list-of-tokens }

> GET "/v1/authentications/user-access-keys/{user-access-key-id}/tokens"
User Access Key IDで発行したOPAQUE トークンリストを照会するAPIです。

<a id="get-a-list-of-tokens-required-permissions"></a>
#### 必要権限
自分のUser Access Key IDで発行したトークンのみ照会可能

<a id="get-a-list-of-tokens-request-parameters"></a>
#### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明                                                                        | 
|------------- |------------- | ------------- |-----|------------------------------------------------------------------------------| 
|  Path | user-access-key-id | String| Y | User Access Key ID                                                           | 
|  Query | token | String| N  | トークン専門<br>部分検索はサポートしない                                                    | 
|  Query | status | String| N  | トークン状態<br>ACTIVE:有効、EXPIRED:期限切れ                                           | 
|  Query | lastAccessDatetimeFrom | Date| N  | トークンの最終使用日時<br>指定した時間より大きいか同じ時間に使用されたトークンを照会<br>例：`2025-02-11T00:56:50.902Z` | 
|  Query | expireDatetimeFrom | Date| N  | トークン有効期限<br>指定した時間より大きいか同じ時間に期限切れになったトークンを照会<br>例：`2025-02-11T00:56:50.902Z`   | 
|  Query | regDatetimeFrom | Date| N  | トークン登録日時<br>指定した時間より大きいか同じ時間に作成されたトークンを照会<br>例：`2025-02-11T00:56:50.902Z`   |
|  Query | page | Integer| N  | 対象ページ<br>デフォルト値1                                                                |
|  Query | limit | Integer| N  | 1ページあたりの表示件数<br>デフォルト値20                                                            |



<a id="get-a-list-of-tokens-response-body"></a>
#### レスポンス本文

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

##### レスポンス


| 名前 | タイプ        | 必須 | 説明              |   
|------------ |--------------|-----|--------------------|
|   header | [共通レスポンス](#common-response) | Y |
|   paging | [PagingResponse](#pagingresponse)| Y  |
|   accessToken | String       | Y | マスキング処理されたトークン      |
|   expireDatetime | Date         | N  | トークン有効期限           |
|   lastAccessDatetime | Date         | Y | トークンで最後に認証/認可した日時 |
|   regDatetime | Date         | Y | トークン作成日時        |
|   status | String       | Y | トークン状態           |
|   tokenId | Long         | Y | トークンID              |


<a id="expire-multiple-tokens"></a>
### トークン複数期限切れ { #expire-multiple-tokens }

> DELETE "/v1/authentications/user-access-keys/{user-access-key-id}/tokens"
User Access Key IDで発行した複数のOPAQUEトークンを一括で失効させるAPIです。<br>
JWTトークンを発行したUser Access Key IDでリクエストしても、JWTトークンは期限切れになりません。<br>
リクエストでトークンIDとトークンリストが全て空の状態であれば、そのUser Access Key IDで発行された全てのトークンが期限切れになります。
トークンIDとトークン一覧が両方ある場合は両方が一致するトークンのみ削除され、リクエストに含まれるUser Access Key IDの所有者ではない他のユーザーが呼び出した場合、トークンは期限切れになりません。

<a id="expire-multiple-tokens-required-permissions"></a>
#### 必要権限
自分のUser Access Key IDで発行したトークンのみ期限切れにすることができます

<a id="expire-multiple-tokens-request-parameters"></a>
#### リクエストパラメータ

| 区分        | 名前              | タイプ           | 必須 | 説明              | 
|--------------|--------------------|-----------------|-----|--------------------| 
| Path         | user-access-key-id | String          | Y | User Access Key ID | 
| Request Body | tokenIds           | List&lt;Long>   | N  | トークンIDリスト        | 
| Request Body         | tokens             | List&lt;String> | N   | トークンリスト       | 

<a id="expire-multiple-tokens-response-body"></a>
#### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

##### レスポンス


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y |


<a id="create-a-project-iam-account"></a>
### プロジェクトIAMアカウント作成 { #create-a-project-iam-account }

> POST "/v1/iam/projects/{project-id}/members"
IAMアカウントをプロジェクトメンバーとして追加するAPIです。

<a id="create-a-project-iam-account-required-permissions"></a>
#### 必要権限
`Project.Member.Iam.Create`

<a id="create-a-project-iam-account-request-parameter"></a>
#### リクエストパラメータ



| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Y | メンバーを追加するプロジェクトID | 
| Request Body | request | AddIamProjectMemberRequest| Y | リクエスト |




##### AddIamProjectMemberRequest


!!! danger "注意"
    1つのリクエストで1人のプロジェクトメンバーのみ作成できます。


| 名前 | タイプ | 必須 | 説明 |  
|------------ | ------------- | ------------- | ------------ |
|   assignRoles | List&lt;UserAssignRoleProtocol>| Y | ユーザーに割り当てるロールリスト |
|   memberUuid | String| Y | 追加するメンバーのUUID  |


##### UserAssignRoleProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   roleId | String| Y | ロールID  |
|   conditions | List&lt;AssignAttributeConditionProtocol>| N | ロール条件属性 |


##### AssignAttributeConditionProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   attributeId | String| Y | 条件属性ID  |
|   attributeOperatorTypeCode | String| Y | 条件属性演算子<br>条件属性のデータ型によって使用できる演算子が異なります。<br><ul><li>ALLOW</li><li>ALL_CONTAINS</li><li>ANY_CONTAINS</li><li>ANY_MATCH</li><li>BETWEEN</li><li>BEYOND</li><li>FALSE</li><li>GREATER_THAN</li><li>GREATER_THAN_OR_EQUAL_TO</li><li>LESS_THAN</li><li>LESS_THAN_OR_EQUAL_TO</li><li>NONE_MATCH</li><li>NOT_ALLOW</li><li>NOT_CONTAINS</li><li>TRUE</li></ul>  |
|   attributeValues | List&lt;String>| Y | 条件属性値 |


<a id="create-a-project-iam-account-response-body"></a>
#### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

##### レスポンス


| 名前 | タイプ         | 必須 | 説明 |   
|------------ |--------------| ------- | ------------ |
|   header | [共通レスポンス](#common-response) | Y |


<a id="delete-multiple-project-iam-accounts"></a>
### プロジェクトIAMアカウント一括削除 { #delete-multiple-project-iam-accounts }

> DELETE "/v1/iam/projects/{project-id}/members"
IAMアカウントを該当プロジェクトから削除するAPIです。

<a id="delete-multiple-project-iam-accounts-required-permissions"></a>
#### 必要権限
`Project.Member.Iam.Delete`

<a id="delete-multiple-project-iam-accounts-request-parameter"></a>
#### リクエストパラメータ



| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Y | プロジェクトID | 
|  Request Body |request | DeleteMembersRequest | Y | リクエスト | 


##### DeleteMembersRequest


| 名前 | タイプ | 必須 | 説明 |  
|------------ | ------------- | ------------- | ------------ |
|   memberUuids | List&lt;String>| Y | 削除する対象アカウントのUUIDリスト |


<a id="delete-multiple-project-iam-accounts-response-body"></a>
#### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

##### レスポンス


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y |


<a id="view-a-project-iam-account"></a>
### プロジェクトIAMアカウント単件照会 { #view-a-project-iam-account }

> GET "/v1/iam/projects/{project-id}/members/{member-uuid}"
プロジェクトに所属する特定IAMアカウントを照会するAPIです。

<a id="view-a-project-iam-account-required-permissions"></a>
#### 必要権限
`Project.Member.Iam.Get`

<a id="view-a-project-iam-account-request-parameter"></a>
#### リクエストパラメータ



| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Y | メンバーを照会するプロジェクトID |
|  Path |member-uuid | String| Y | 照会するメンバーUUID |




<a id="view-a-project-iam-account-response-body"></a>
#### レスポンス本文

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


##### レスポンス


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y |
|   projectMember | ProjectIamMemberRoleBundleProtocol| Y  | 追加されたメンバー情報、エラー時は含まれません。 |


##### ProjectMemberRoleBundleProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   uuid | String| Y | メンバーUUID  |
|   id | String| Y | ID  |
|   name | String| N | 名前 |
|   emailAddress | String| N | メンバーメールアドレス |
|   maskingEmail | String| N | メンバーのマスキングされたメールアドレス |
|   mobilePhone | String| N | 電話番号  |
|   relationDateTime | Date| N | メンバー追加時間 |
|   joinYmdt | Date| N | 加入日時 |
|   recentLoginYmdt | Date| N | 最近のログイン日時 |
|   recentPasswordModifyYmdt | Date| N | 最近のパスワード変更日時 |
|   roles | List&lt;RoleBundleProtocol>| N | 関連ロールリスト(条件属性含む)  |


[RoleBundleProtocol](#rolebundleprotocol)



<a id="view-project-iam-accounts"></a>
### プロジェクトIAMアカウントリスト照会 { #view-project-iam-accounts }

> GET "/v1/iam/projects/{project-id}/members"
プロジェクトに所属するIAMアカウントリストを照会するためのAPIです。

<a id="view-project-iam-accounts-required-permissions"></a>
#### 必要権限
`Project.Member.Iam.List`

<a id="view-project-iam-accounts-request-parameter"></a>
#### リクエストパラメータ


| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Y | 照会するプロジェクトID | 
|  Query |limit | Integer| N | 1ページあたりの表示件数、デフォルト値20 |
|  Query |page | Integer| N | 対象ページ、デフォルト値1 |





<a id="view-project-iam-accounts-response-body"></a>
#### レスポンス本文

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

##### レスポンス


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y |
|   paging | [PagingResponse](#pagingresponse)| Y  |
|   projectMembers | List&lt;IamProjectMemberProtocol>| Y | プロジェクトメンバーリスト |



##### IamProjectMemberProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   uuid | String| Y | メンバーUUID  |
|   id | String| Y | ID  |
|   name | String| N | 名前 |
|   emailAddress | String| N | メンバーメールアドレス |
|   maskingEmail | String| N | メンバーのマスキングされたメール |
|   mobilePhone | String| N | 電話番号  |
|   relationDateTime | Date| N | メンバー追加時間 |
|   joinYmdt | Date| N | 加入日時 |
|   recentLoginYmdt | Date| N | 最近のログイン日時 |
|   recentPasswordModifyYmdt | Date| N | 最近のパスワード変更日時 |


<a id="modify-project-iam-account-roles"></a>
### プロジェクトIAMアカウントロール修正 { #modify-project-iam-account-roles }

> PUT "/v1/iam/projects/{project-id}/members/{member-uuid}"
プロジェクトで指定したIAMアカウントのロールを変更するAPIです。

<a id="modify-project-iam-account-roles-required-permissions"></a>
#### 必要権限
`Project.Member.Iam.Update`

<a id="modify-project-iam-account-roles-request-parameter"></a>
#### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Y | プロジェクトID | 
|  Path |member-uuid | String| Y | ロール変更対象メンバーUUID | 
| Request Body | request | [UpdateMemberRoleRequest](#updatememberrolerequest)| Y | リクエスト |




<a id="modify-project-iam-account-roles-response-body"></a>
#### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

##### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y   |


<a id="view-all-credentials-of-members-under-organizations"></a>
### 組織下位メンバー認証情報リスト照会 { #view-all-credentials-of-members-under-organizations }

> GET "/v1/authentications/organizations/{org-id}/user-access-keys"
組織に所属するメンバー及びプロジェクトメンバーの認証情報を照会するAPIです。

<a id="view-all-credentials-of-members-under-organizations-required-permissions"></a>
#### 必要権限
`Organization.UserAccessKey.List`

<a id="view-all-credentials-of-members-under-organizations-request-parameter"></a>
#### リクエストパラメータ



| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Y | UserAccessKeyを照会する組織ID |
|  Query |paging | Paging| N | 1ページあたりの表示件数、デフォルト値20 |




<a id="view-all-credentials-of-members-under-organizations-response-body"></a>
#### レスポンス本文

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


##### レスポンス


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------- | ------------ |
|   header | [共通レスポンス](#common-response)| Y |
|   paging | [PagingResponse](#pagingresponse)| Y  |
|   authenticationList | List&lt;UserAccessKeyResponseV7>| Y  | メンバーごとの認証キー情報 |


##### UserAccessKeyResponseV7

| 名前 | タイプ | 必須 | 説明 |
|------------|--------|------|-----------------------------|
| authId | String | Y | 認証手段ID(マスキング処理) |
| uuid | String | Y | ユーザーUUID |
| userAccessKeyID | String | Y | User Access Key ID(マスキング処理) |
| secretAccessKey | String | N | 秘密鍵(空白処理) |
| authStatusCode | String | Y | 認証ステータスコード(STABLE, STOP, BLOCKED) |
| tokenExpiryPeriod | Long | N | トークン有効期限 |
| regDatetime | Date | N | 作成日時 |
| modDatetime | Date | N | 削除日時 |
| lastUsedDatetime | Date | N | 最終使用日時 |
| reIssueDatetime | Date | N | secretAccessKey再作成日時 |
| lastTokenUsedDatetime | Date | N | トークン最終使用日時 |
| validTokenCount | Long | N | 有効なトークン数 |

<a id="view-your-own-organization-list"></a>
### 自分の組織一覧の照会 { #view-your-own-organization-list }

**[Method, URL]**
```
GET /v1/organizations
```

<a id="view-your-own-organization-list-required-permission"></a>
#### 必要な権限
会員であれば特定の権限なしで呼び出し可能なAPIです。

**[Query Parameter]**

| 名前 | 型 | 必須 | 説明 |
|---|---|---|---|
| orgName | String | N | 組織名 |
| orgNameMatchTypeCode | String | N | 組織名の検索タイプ(EXACT:完全一致、LIKE:部分一致、デフォルト値: LIKE) |
| page | Integer | N | 対象ページ、デフォルト1 |
| limit | Integer | N | ページあたりの表示件数、デフォルト20 |

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

**[Response Bodyの説明]**

| 名前 | 型 | 必須 | 説明 |
|---|---|---|---|
| header | [共通レスポンス](#common-response) | Y | |
| orgList | List&lt;OrgMemberRelationProtocol> | Y | 組織一覧情報 |
| paging | [PagingResponse](#pagingresponse) | Y | ページング情報 |

##### OrgMemberRelationProtocol

| 名前 | 型 | 必須 | 説明 |
|---|---|---|---|
| org | OrgProtocol | Y | 組織情報 |
| orgMember | OrgMemberProtocol | Y | 組織/プロジェクトメンバー情報 |
| orgOwner | OwnerProtocol | Y | 組織オーナー情報 |

##### OrgProtocol

| 名前 | 型 | 必須 | 説明 |
|---|---|---|---|
| orgId | String | Y | 組織ID |
| orgName | String | Y | 組織名 |
| orgStatusCode | String | Y | 組織ステータスコード(STABLE, CLOSED) |
| ownerUuid | String | Y | 組織オーナーUUID |
| regDateTime | Date | Y | 組織作成日時 |
| remainingJobCode | String | Y | 組織の残りタスク(NONE, IAM_ORG_CREATE, IAM_ORG_UPDATE, IAM_ORG_DELETE) |
| ipAclTypeCode | String | Y | 組織IP ACLタイプコード(COMMON, INDIVIDUAL) |
| orgDomainList | List&lt;OrgDomainProtocol> | Y | 組織ドメイン一覧 |

##### OrgMemberProtocol

| 名前 | 型 | 必須 | 説明 |
|---|---|---|---|
| existOrgMember | Boolean | Y | 組織メンバーの存在有無 |
| orgOwner | Boolean | Y | 組織オーナーかどうか |

##### OwnerProtocol

| 名前 | 型 | 必須 | 説明 |
|---|---|---|---|
| email | String | Y | 組織オーナーのメールアドレス |
| name | String | Y | 組織オーナーの名前 |
| restrictStatusCode | String | Y | 組織オーナーの制約ステータス(HOLD, MEMBER_BLOCKED, RESOURCE_BLOCKED, RESOURCE_DELETED, STABLE, UNPAID) |
| country | String | Y | 組織オーナーの国コード |
| restrictTypes | List&lt;String> | Y | 組織オーナーの制約一覧 |

##### OrgDomainProtocol

| 名前 | 型 | 必須 | 説明 |
|---|---|---|---|
| domainId | String | Y | 組織ドメインID |
| domainName | String | Y | 組織ドメイン名 |


<a id="add-your-own-organization"></a>
### 自分の組織の追加 { #add-your-own-organization }

> POST /v1/organizations
自身の組織を追加するAPIです。

<a id="add-your-own-organization-required-permission"></a>
#### 必要な権限
会員であれば特定の権限なしで呼び出し可能なAPIです。

<a id="add-your-own-organization-request-parameter"></a>
#### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明  |
|------------- |------------- | ------------- | ------------- | ------------- | 
| Request Body | request | [CreateOrgRequest](#createorgrequest)| Y | リクエスト |


##### CreateOrgRequest

| 名前 | 型 | 必須 | 説明 |
|---|---|---|---|
| orgName | String | Y | 作成する組織名(最大70文字) |


<a id="add-your-own-organization-response-body"></a>
#### レスポンス本文

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

##### レスポンス

| 名前 | 型 | 必須 | 説明 |
|---|---|---|---|
| header | [共通レスポンス](#common-response) | Y | |
| orgId | String | Y | 組織ID |
| orgName | String | Y | 組織名 |
| owner | [Owner](#owner) | Y | 組織オーナー情報 |

##### Owner

| 名前 | 型 | 必須 | 説明 |
|---|---|---|---|
| email | String | Y | 組織オーナーのメールアドレス |
| name | String | Y | 組織オーナーの名前 |
| ownerId | String | Y | 組織オーナーID |
| restrictTypes | List&lt;String> | Y | 制約対象一覧 |


<a id="delete-a-single-organization"></a>
### 組織の個別削除 { #delete-a-single-organization }

> DELETE /v1/organizations/{org-id}
自身の組織を削除するAPIです。

<a id="delete-a-single-organization-required-permission"></a>
#### 必要な権限
`Organization.Delete`

<a id="delete-a-single-organization-request-parameters"></a>
#### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明  |
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Y | 組織ID |


<a id="delete-a-single-organization-response-body"></a>
#### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

##### レスポンス

| 名前 | 型 | 必須 | 説明 |
|---|---|---|---|
| header | [共通レスポンス](#common-response) | Y | |


<a id="retrieve-service-information-list"></a>
### サービス情報一覧照会 { #retrieve-service-information-list }

> GET /v1/products
提供されるサービス一覧を照会するAPIです。

<a id="retrieve-service-information-list-required-permissions"></a>
#### 必要な権限
会員であれば特定の権限なしで呼び出し可能なAPIです。

<a id="retrieve-service-information-list-request-parameters"></a>
#### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明  |
|---|---|---|---|---|
|  Query | productId | String | N | サービスID |
|  Query | productCategoryCode | String | N | サービスカテゴリーコード(PROJECT、ORG、MARKET_PLACE) |
|  Query | productName | String | N | サービス名 |
|  Query | productNameLike | String | N | サービス名Like検索 |
|  Query | limit | Integer| N | ページごとの表示件数、デフォルト値20 |
|  Query | page | Integer| N | 対象ページ、デフォルト値1 |


<a id="retrieve-service-information-list-response-body"></a>
#### レスポンス本文

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

##### レスポンス


| 名前 | 型 | 必須 | 説明 |
|---|---|---|---|
| header | [共通レスポンス](#common-response) | Y | |
| paging | [PagingResponse](#pagingresponse)| Y | |
| products | List&lt;Product> | Y | サービス情報一覧 |

##### Product

| 名前 | タイプ | 必須 | 説明 |
|---|---|---|---|
| parentProductId | String | N | 親サービスID |
| productCategoryCode | String | Y | サービスカテゴリーコード(PROJECT、ORG、MARKET_PLACE) |
| productId | String | Y | サービスID |
| productName | String | Y | サービス名 |


<a id="view-role-descriptions-by-multiple-language"></a>
### ロール説明多言語照会 { #view-role-descriptions-by-multiple-language }

> GET /v1/messages/role
ロールの多言語リストを取得するAPIです。

<a id="view-role-descriptions-by-multiple-language-required-permission"></a>
#### 必要権限
会員であれば特定の権限なしで呼び出し可能なAPIです。

<a id="view-role-descriptions-by-multiple-language-request-parameter"></a>
#### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
| Query |messageType | String| N | メッセージタイプ<br><ul><li>MESSAGE</li><li>ERROR</li></ul> |
| Query |languages | List&lt;String>| N | 言語<br><ul><li>KO_KR</li><li>JA_JP</li><li>EN_US</li><li>ZH_CN</li></ul> |
| Query |keyword | String| N | 検索キーワード |
| Query |messageId | String| N | メッセージID |
| Query |limit | Integer| Y | ページあたりの表示件数 | 
| Query |page | Integer| Y | 対象ページ |


<a id="view-role-descriptions-by-multiple-language-response-body"></a>
#### レスポンス本文

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
      "koKr": "韓国語メッセージ",
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

##### レスポンス


| 名前 | タイプ | 必須 | 説明 |
|---|---|---|---|
| header | [共通レスポンス](#common-response) | Y | |
| messages | List&lt;MessageProtocol> | Y | メッセージリスト |
| paging | [PagingResponse](#pagingresponse)| Y | |

##### MessageProtocol

| 名前 | タイプ | 必須 | 説明 |
|---|---|---|---|
| i18nMessageSeq | Long | N | メッセージ連番 |
| categoryId | String | N | カテゴリーID |
| messageId | String | N | メッセージID |
| messageType | String | N | メッセージタイプ(MESSAGE, ERROR) |
| description | String | N | 説明 |
| koKr | String | N | 韓国語メッセージ |
| enUs | String | N | 英語メッセージ |
| jaJp | String | N | 日本語メッセージ |
| zhCn | String | N | 中国語メッセージ |


<a id="error-code"></a>
### エラーコード { #error-code }

| 結果コード | 説明                                                                              | 措置                                                  |
| ---------- |-------------------------------------------------------------------------------------|---------------------------------------------------------|
| 80007 | 期限切れまたは存在しないトークンを使用して呼び出した場合に発生するエラー                                      | 新しいトークンを発行して使用                                     |
| -6 | 権限のない呼び出し者が呼び出した場合に発生するエラー                                                  | 呼び出し者に適切な権限を付与                                    |
| -8 | 組織IP ACLポリシーによってIP検証が失敗した場合に発生するエラー                                          | 組織IP ACLに該当IPが登録されているかどうかを確認                        |
| 404 | 存在しないAPI呼び出し時に発生                                                                   | 呼び出すAPIのhttpmethod,uriを確認                        |
| 400<br>501<br>502<br>503<br>504<br>505 | リクエストパラメータが適切でない場合に発生するエラー                                                      | リクエストパラメータの必須値及び設定可能な値を確認                       |
| 500 | 異常システムエラー                                                                      | 担当者にお問い合わせください。                                         |
| 1000 | パラメータが正しくない場合に発生するエラー <br> 組織IAMメンバーAPI - `IAMメンバーパスワード変更メール送信`リクエスト値returnUrlが許可されたドメインでない場合に発生(許可されたドメイン: toast.com, dooray.com, nhncloud.com) | リクエストパラメータ確認                                          |
| 1201 | サーバーの内部的なAPIリクエストが失敗して発生するエラー | エラーメッセージに含まれるエラーメッセージとコードをもとに解決<br>含まれるエラーメッセージとコードだけでは解決が難しい場合は、担当者にお問い合わせください。                   |
| 10005<br>70008<br>1104 | リクエストパラメータが適切でない場合に発生するエラー｜リクエストパラメータの必須値や設定可能な値などを確認 |
| 10009 | 組織またはプロジェクトに存在しないロールを付与する際に発生するエラー｜メンバーに存在するロールを付与するように変更                              |
| 10010 | ロールグループを削除する際、プロジェクトメンバー(招待中のメンバーを含む)にそのロールグループのみ付与されている場合に発生するエラー<br>プロジェクトメンバーのロールを変更する際、何のロールも付与しない場合に発生するエラー<br> 1)削除しようとするロールグループを持つプロジェクトメンバー(招待中のメンバーを含む)のロールを他のロールに変更するか、またはそのメンバーを削除する <br> 2)プロジェクトメンバーロールを変更する際、リクエストにロールの値を設定してリクエストする |
| 10012 | プロジェクトメンバーを削除する際、そのメンバーが削除され、そのプロジェクトにADMINロールを持つメンバーが存在しなくなった場合に発生するエラー    | 1)削除対象ではない他のプロジェクトメンバーにADMINロールうぃ付与 <br>2) ADMINロールではない対象を削除|
| 12100 | プロジェクトメンバーが存在しない場合に発生するエラー                                                      | 存在するプロジェクトメンバーUUID使用                                |
| 12107 | リクエストuuidと対象uuidが同じであることが許可されていないAPIで、uuidが同じ場合に発生するエラー                          | 対象uuidとリクエストuuidを別々に設定                           |
| 12400 | 存在しない、または削除されたプロジェクトにメンバーを追加する場合に発生するエラー                                           | 存在するプロジェクトにメンバーを追加するように変更                              |
| 12401 | プロジェクト作成時、該当プロジェクトの組織OWNERアカウントに設定されたプロジェクト作成数制限を超過した場合に発生するエラー                | 1)使用しないプロジェクトを削除して作成可能なプロジェクト数を確保 <br>2)担当者を通じてプロジェクト最大作成数調整リクエスト |
| 12500 | プロジェクトを削除する際、使用中のサービスが存在する場合に発生するエラー                                              | 該当プロジェクトの使用中のサービスをすべて無効化処理した後、プロジェクト削除処理を試みる         |
| 13001 | サービス有効化/無効化に失敗した場合に発生するエラー                                                       | 担当者にお問い合わせください。                                        |
| 13002 | すでに有効状態のサービスを再度有効化した場合に発生するエラー                                | 既に有効になっているサービスを活用          |
| 13004 | 有効化できないサービスを有効化した場合に発生するエラー                                                 | 有効化可能なサービスを有効化                                |
| 13006 | 法人専用サービス有効化、組織OWNERのメンバータイプが法人でない場合に発生するエラー                                | 法人アカウントタイプを持つ組織OWNERの組織下位プロジェクトでサービス有効化を試行         |
| 22006 | 追加時にすでに存在する場合に発生 | 重複したリクエストが来ないように処理 |
| 22013 | 組織OWNERのロールを変更しようとしたときに発生するエラー                                                    | 組織オーナーを対象にロールの変更はできません                            |
| 22016 | 組織が存在しない場合に発生するエラー                                                          | 存在する組織のorgIdでリクエストしているか確認                          |
| 23005 | 組織IDに該当する組織が存在しない場合に発生するエラー                                               | 担当者お問い合わせください                                         |
| 30015 | プロジェクトAppKeyの作成制限回数を超過した場合に発生するエラー <br> プロジェクト統合Appkey API - `プロジェクト統合Appkey作成`で作成されるプロジェクトAppKeyの作成可能回数は3個であり、3個を超過した場合にエラー発生 | 未使用のプロジェクト統合Appkeyを削除した後に再試行 |
| 40017 | プロジェクトが存在しない場合に発生するエラー                                                       | 存在するプロジェクトに対してAPIリクエスト                               |
| 40028<br>13003 | プロジェクトが存在しない場合(作成した後に削除した場合)発生するエラー                                          | 存在するプロジェクトに対してAPIリクエスト                               |
| 40054 | サービスを有効化する際、先に有効化されるべきサービスが有効化されていない場合に発生するエラー                           | 先に有効化されるべきサービスの有効化処理                           |
| 40057 | サービスを無効化する際、先に無効化されるべきサービスが無効化されていない場合に発生するエラー                           | 先に無効化されるべきサービスの無効化処理                           |
| 50007 | 有効ではないメンバーの場合に発生するエラー<br>(存在しないメンバー、休眠及び退会状態のメンバーは無効)<br>組織作成API - API呼び出し時、 uuidが有効ではない場合 | 有効なメンバーのuuidに修正                             |
| 60003 | DBにデータがない場合に発生するエラー<br>プロジェクト統合Appkey API - `プロジェクト統合Appkey削除`で削除するAppKeyがない場合に発生するエラー | 1)担当者にお問い合わせください <br>2)存在するAppKeyを削除対象AppKey値として設定 |
| 62004 | ロールグループ作成時に同じ名前のロールグループが存在する場合に発生するエラー                                       | 重複していない名前に変更                                     |
| 62008 | ロールグループ修正、削除及びロールグループにロール追加/削除時にロールグループIDが存在しない場合に発生                        | 存在するロールグループIDを使用するように変更                            |
| 62009 | ロールグループを作成する際、ロールが無効である場合に発生                                               | 有効なロールを使用するように変更                                   |
| 62011 | ロールグループを削除する際、通知グループで使用中の場合に発生                                                    | 通知グループを削除した後、ロールグループを削除するように変更                          |
| 62014 | ロールグループの削除及びロールグループにロール追加/削除する際、ロールグループを割り当てたメンバーがロールをサービスに通知するのに失敗                   | 担当者にお問い合わせください                                        |
| 62019 | 組織メンバーに許可されていないロールを付与しようとする場合                  | 担当者にお問い合わせください                                        |
| 72005 | ビリング関連APIの呼び出しが失敗したときに発生するエラー                                                     | 担当者にお問い合わせください                                        |
| 70013 | 利用中のサービスが存在するときに発生するエラー                                                         | 利用中のサービス無効化                                       |
| 70014 | メンバー退会条件を満たさない場合に発生するエラー<br> IAM - 1)使用中のサービスがある場合2)削除されていないプロジェクトがある場合3)該当メンバーが任意のプロジェクトにADMINロールで存在する場合 | 各メンバータイプに合った退会条件を満たすように設定                      |
| 70024 | 決済手段が正常に登録されていない場合に発生するエラー                                                 | 決済手段を登録                                             |
| 70032 | 未払でメンバーブロックになった場合に発生するエラー                                                   | 該当アカウントが持っている未払の請求書の決済                                 |
| -200201 | user-code長さ条件が合わない場合に発生するエラー                                                       | 20文字以内の小文字、数字、特殊文字(-, _, .)使用可能。<br>特殊文字(-, _, .)は最初と最後には使用できない。|
| -200202 | user-codeフォーマット条件が合わない場合に発生するエラー                                            | 小文字、数字、特殊文字(-, _, .)使用可能。<br>特殊文字(-, _, .)は最初と最後には使用できない。|
| -200203 | 名前の長さの条件が合わない場合に発生するエラー                                                   | 60文字以内の長さの要件を満たすように名前の長さを修正                       |
| -200204 | メンバー作成修正時にuser-codeが重複する場合に発生するエラー                                            | 重複しないuser-codeに変更してリクエスト                         |
