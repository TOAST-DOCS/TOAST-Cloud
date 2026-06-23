# フレームワークAPI

**NHN Cloud > Public API 사용 가이드 > フレームワークAPI**

## 概要
次に紹介するAPIを通じて、プロジェクトメンバーを作成したり役割を付与したりするなど、組織とプロジェクトを管理できます。
フレームワークAPIは、呼び出し時の認証/認可のためにUser Access Keyトークンを使用します。User Access KeyトークンはUser Access Keyをベースに発行されるBearerタイプの一時的なアクセストークンです。User Access Keyトークンの発行および使用に関する詳細については、[User Access Key トークン](/nhncloud/ja/public-api/user-access-key-token)を参照してください。

<a id="public-api-domain"></a>

### Public API ドメイン
`https://core.api.nhncloudservice.com/`

<a id="common"></a>

### 共通

<a id="request"></a>

#### リクエスト
Public APIを呼び出す際は、以下のRequest Headerを必ず含める必要があります。


| 区分 | 名前 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
| Header |  x-nhn-authorization | String| Yes | ユーザーが発行したBearerタイプトークン |

<a id="response"></a>

#### レスポンス
Public APIのレスポンス時、以下のヘッダ部分がレスポンス本文に含まれます。
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
|   isSuccessful | Boolean | No | 成功の有無  |
|   resultCode | Integer| No | 結果コード。成功時は0が返され、失敗時はエラーコードが返されます  |
|   resultMessage | String| No | 結果メッセージ  |

<a id="common-types"></a>

#### 共通タイプ
<a id="共通タイプ"></a>


| 名前 | タイプ | サイズ | 説明 | 
|------------ | ------------- | ------------- | ------------ |
| org-id | String | 16文字 | 組織ID |
| project-id | String | 8文字 | プロジェクトID |
| product-id | String | 8文字 | サービスID |
| user-access-key-id | String | 20文字 | User Access Key ID |
| project-app-key | String | 20文字 | プロジェクトのアプリキー |
| product-app-key | String | 16文字 | サービスのアプリキー |
| uuid | String | 36文字 | メンバーのUUID |


!!! danger "警告"
    * **組織管理 > ガバナンス設定 > 組織ガバナンス設定 > IP ACL設定**からIP ACLを設定した場合、フレームワークAPIの呼び出し時にも当該設定が適用されます。


<a id="api"></a>

### API


!!! danger "警告"
    APIのレスポンスには、ガイドに記載されていないフィールドが追加される場合があります。新しいフィールドが追加されてもエラーが発生しないように開発してください。また、DBへの保存時にカラムサイズが変更される場合があるため、余裕を持って設定してください。


| メソッド | HTTPリクエスト | 説明 |
|------------- | ------------- | -------------|
| POST |[/v1/projects/{project-id}/members](#プロジェクトメンバー作成) | プロジェクトメンバー作成 |
| POST |[/v1/organizations/{org-id}/projects](#add-project) | プロジェクト追加 |
| DELETE |[/v1/projects/{project-id}/members/{target-uuid}](#プロジェクトメンバー単件削除) | プロジェクトメンバー単件削除 |
| DELETE |[/v1/projects/{project-id}](#プロジェクト削除) | プロジェクト削除 |
| DELETE |[/v1/projects/{project-id}/products/{product-id}/disable](#プロジェクトサービス終了) | プロジェクトサービス終了 |
| POST |[/v1/projects/{project-id}/products/{product-id}/enable](#プロジェクトサービス利用) | プロジェクトサービス利用 |
| GET |[/v1/organizations/{org-id}/roles](#組織ロール一覧照会) | 組織ロール一覧照会 |
| GET |[/v1/projects/{project-id}/roles](#プロジェクトロール一覧照会) | プロジェクトロール一覧照会 |
| GET |[/v1/organizations/{org-id}/domains](#組織ドメイン検索) | 組織ドメイン検索 |
| GET |[/v1/organizations/{org-id}/members/{member-uuid}](#組織メンバー単件照会) | 組織メンバー単件照会 |
| POST |[/v1/organizations/{org-id}/members/search](#組織メンバー一覧照会) | 組織メンバー一覧照会 |
| GET |[/v1/organizations/{org-id}/project-role-groups](#組織のプロジェクト共通ロールグループ全体照会) | 組織のプロジェクト共通ロールグループ全体照会 |
| GET |[/v1/product-uis/hierarchy](#サービス階層構造照会) | サービス階層構造照会 |
| GET |[/v1/projects/{project-id}/products/{product-id}](#get-service-used-by-project) | プロジェクトで使用中のサービス照会 |
| GET |[/v1/projects/{project-id}/members/{member-uuid}](#プロジェクトメンバー単件照会) | プロジェクトメンバー単件照会 |
| POST |[/v1/projects/{project-id}/members/search](#プロジェクトメンバー一覧照会) | プロジェクトメンバー一覧照会 |
| GET |[/v1/projects/{project-id}/project-role-groups/{role-group-id}](#プロジェクトロールグループ単件照会) | プロジェクトロールグループ単件照会 |
| GET |[/v1/organizations/{org-id}/project-role-groups/{role-group-id}](#組織のプロジェクト共通ロールグループ単件照会) | 組織のプロジェクト共通ロールグループ単件照会 |
| GET |[/v1/projects/{project-id}/project-role-groups](#プロジェクトロールグループ全体照会) | プロジェクトロールグループ全体照会 |
| GET |[/v1/organizations/{org-id}/projects](#組織に属するプロジェクト一覧照会) | 組織に属するプロジェクト一覧照会 |
| GET |[/v1/organizations/{org-id}/governances](#使用中の組織ガバナンス一覧照会) | 使用中の組織ガバナンス一覧照会 |
| POST |[/v1/organizations/{org-id}/project-role-groups](#組織のプロジェクト共通ロールグループ作成) | 組織のプロジェクト共通ロールグループ作成 |
| DELETE |[/v1/organizations/{org-id}/project-role-groups](#組織のプロジェクト共通ロールグループ削除) | 組織のプロジェクト共通ロールグループ削除 |
| PUT |[/v1/organizations/{org-id}/project-role-groups/{role-group-id}/infos](#組織のプロジェクト共通ロールグループ情報修正) | 組織のプロジェクト共通ロールグループ情報修正 |
| PUT |[/v1/organizations/{org-id}/project-role-groups/{role-group-id}/roles](#組織のプロジェクト共通ロールグループロール修正) | 組織のプロジェクト共通ロールグループロール修正 |
| POST |[/v1/projects/{project-id}/project-role-groups](#プロジェクトロールグループ作成) | プロジェクトロールグループ作成 |
| DELETE |[/v1/projects/{project-id}/project-role-groups](#プロジェクトロールグループ削除) | プロジェクトロールグループ削除 |
| PUT |[/v1/projects/{project-id}/project-role-groups/{role-group-id}/infos](#プロジェクトロールグループ情報修正) | プロジェクトロールグループ情報修正 |
| PUT |[/v1/projects/{project-id}/project-role-groups/{role-group-id}/roles](#プロジェクトロールグループロール修正) | プロジェクトロールグループロール修正 |
| GET |[/v1/organizations/{org-id}/org-role-groups](#組織ロールグループ全体照会) | 組織ロールグループ全体照会 |
| GET |[/v1/organizations/{org-id}/org-role-groups/{role-group-id}](#組織ロールグループ単件照会) | 組織ロールグループ単件照会 |
| POST |[/v1/organizations/{org-id}/org-role-groups](#組織ロールグループ作成) | 組織ロールグループ作成 |
| DELETE |[/v1/organizations/{org-id}/org-role-groups](#組織ロールグループ削除) | 組織ロールグループ削除 |
| PUT |[/v1/organizations/{org-id}/org-role-groups/{role-group-id}/infos](#組織ロールグループ情報修正) | 組織ロールグループ情報修正 |
| PUT |[/v1/organizations/{org-id}/org-role-groups/{role-group-id}/roles](#組織ロールグループロール修正) | 組織ロールグループロール修正 |
| PUT |[/v1/organizations/{org-id}/members/{member-uuid}](#組織メンバーロール修正) | 組織メンバーロール修正 |
| PUT |[/v1/projects/{project-id}/members/{member-uuid}](#プロジェクトメンバーロール修正) | プロジェクトメンバーロール修正 |
| GET |[/v1/iam/organizations/{org-id}/members/{member-uuid}](#組織IAMアカウント単件照会) | 組織 IAM アカウント単件照会 |
| GET |[/v1/iam/organizations/{org-id}/members](#組織IAMアカウント一覧照会) | 組織 IAM アカウント一覧照会 |
| POST |[/v1/iam/organizations/{org-id}/members](#組織IAMアカウント追加) | 組織 IAM アカウント追加 |
| POST |[/v1/iam/organizations/{org-id}/members/{member-id}/send-password-setup-mail](#IAMアカウントパスワード変更メール送信) | IAM アカウントパスワード変更メール送信 |
| PUT |[/v1/iam/organizations/{org-id}/members/{member-uuid}](#組織IAMアカウント情報修正) | 組織 IAM アカウント情報修正 |
| POST |[/v1/iam/organizations/{org-id}/members/{member-id}/set-password](#組織IAMアカウントパスワード変更) | 組織 IAM アカウントパスワード変更 |
| GET |[/v1/iam/organizations/{org-id}/settings/session](#組織IAMアカウントログインセッション設定情報照会) | 組織 IAM アカウントログインセッション設定情報照会 |
| GET |[/v1/iam/organizations/{org-id}/settings/security-mfa](#組織IAMアカウントログイン2次認証設定照会) | 組織 IAM アカウントログイン2次認証設定照会 |
| GET |[/v1/iam/organizations/{org-id}/settings/security-login-fail](#組織IAMアカウントログイン失敗セキュリティ設定照会) | 組織 IAM アカウントログイン失敗セキュリティ設定照会 |
| GET |[/v1/iam/organizations/{org-id}/settings/password-rule](#組織IAMアカウントパスワードポリシー照会) | 組織 IAM アカウントパスワードポリシー照会 |
| GET |[/v1/organizations/{org-id}/products/ip-acl](#組織IPACLリスト照会) | 組織 IP ACL 一覧照会 |
| POST |[/v1/billing/contracts/basic/products/prices/search](#従量制に登録されたサービス価格照会) | 従量制に登録されたサービス価格照会 |
| GET |[/v1/billing/contracts/basic/products](#従量制に登録されたサービス一覧照会) | 従量制に登録されたサービス一覧照会 |
| GET | [/v1/authentications/projects/{project-id}/project-appkeys](#プロジェクト統合Appkey照会) | プロジェクト統合 Appkey 照会 |
| GET |[/v1/authentications/user-access-keys](#UserAccessKeyIDリスト照会) | User Access Key ID 一覧照会 |
| POST | [/v1/authentications/projects/{project-id}/project-appkeys](#プロジェクト統合Appkey登録) | プロジェクト統合 Appkey 登録 |
| POST |[/v1/authentications/user-access-keys](#UserAccessKeyID登録) | User Access Key ID 登録 |
| DELETE | [/v1/authentications/projects/{project-id}/project-appkeys/{app-key}](#プロジェクト統合Appkey削除) | プロジェクト統合 Appkey 削除 |
| PUT |[/v1/authentications/user-access-keys/{user-access-key-id}/secretkey-reissue](#UserAccessKeyIDシークレットキー再発行) | User Access Key ID シークレットキー再発行 |
| PUT |[/v1/authentications/user-access-keys/{user-access-key-id}](#UserAccessKeyIDステータス修正) | User Access Key ID ステータス修正 |
| DELETE |[/v1/authentications/user-access-keys/{user-access-key-id}](#UserAccessKeyID削除) | User Access Key ID 削除 |
| GET    | [/v1/authentications/user-access-keys/{user-access-key-id}/tokens](#list-tokens) | トークン一覧照会 |
| DELETE | [/v1/authentications/user-access-keys/{user-access-key-id}/tokens](#トークン複数件失効) | トークン複数件失効 |
| POST |[/v1/iam/projects/{project-id}/members](#プロジェクトIAMアカウント作成) | プロジェクト IAM アカウント作成 |
| DELETE |[/v1/iam/projects/{project-id}/members](#プロジェクトIAMアカウント複数件削除) | プロジェクト IAM アカウント複数件削除 |
| GET |[/v1/iam/projects/{project-id}/members/{member-uuid}](#プロジェクトメンバー単件照会) | プロジェクト IAM アカウント単件照会 |
| GET |[/v1/iam/projects/{project-id}/members](#プロジェクトIAMアカウント一覧照会) | プロジェクト IAM アカウント一覧照会 |
| PUT |[/v1/iam/projects/{project-id}/members/{member-uuid}](#プロジェクトIAMアカウントロール修正) | プロジェクト IAM アカウントロール修正 |
| GET |[/v1/authentications/organizations/{org-id}/user-access-keys](#組織配下メンバーの全認証情報一覧照会) | 組織配下メンバーの認証情報一覧照会 |
| GET | [/v1/organizations](#自分の組織一覧照会) | 自分の組織一覧照会 |
| POST | [/v1/organizations](#自分の組織追加) | 自分の組織追加 |
| DELETE | [/v1/organizations/{org-id}](#組織単件削除) | 組織単件削除 |
| GET | [/v1/products](#list-service-information) | サービス情報一覧照会 |
| GET | [/v1/messages/role](#ロール説明多言語照会) | ロール説明多言語照会 |



<a id="create-project-member"></a>

#### プロジェクトメンバー作成

> POST "/v1/projects/{project-id}/members"

プロジェクトにメンバーを追加する API です。

##### 必要権限
`Project.Member.Create`

##### リクエストパラメータ



| 区分 | 名前 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | メンバーを追加するプロジェクト ID | 
| Request Body | request | CreateMemberRequest| Yes | リクエスト |




###### CreateMemberRequest


!!! danger "警告"
    リクエスト時に memberUuid、email、userCode のいずれか 1 つは必ず値が必要です。<br>memberUuid > email > userCode の順に値があるか確認し、値があればそのメンバーをプロジェクトメンバーとして追加します。<br>1 回のリクエストで作成できるプロジェクトメンバーは 1 名のみです。


| 名前 | タイプ | 必須 | 説明 |  
|------------ | ------------- | ------------- | ------------ |
|   assignRoles | List&lt;UserAssignRoleProtocol>| Yes | ユーザーに割り当てるロールのリスト  |
|   memberUuid | String| No | 追加するメンバーの UUID  |
|   email | String| No | 追加するメンバーのメールアドレス  |
|   userCode | String| No | 追加する IAM アカウント ID  |


###### UserAssignRoleProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   roleId | String| Yes | ロール ID  |
|   conditions | List&lt;AssignAttributeConditionProtocol>| No | ロール条件属性  |


###### AssignAttributeConditionProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   attributeId | String| Yes | 条件属性 ID  |
|   attributeOperatorTypeCode | String| Yes | 条件属性演算子<br>条件属性のデータ型によって使用できる演算子が異なります<br><ul><li>ALLOW</li><li>ALL_CONTAINS</li><li>ANY_CONTAINS</li><li>ANY_MATCH</li><li>BETWEEN</li><li>BEYOND</li><li>FALSE</li><li>GREATER_THAN</li><li>GREATER_THAN_OR_EQUAL_TO</li><li>LESS_THAN</li><li>LESS_THAN_OR_EQUAL_TO</li><li>NONE_MATCH</li><li>NOT_ALLOW</li><li>NOT_CONTAINS</li><li>TRUE</li></ul>  |
|   attributeValues | List&lt;String>| Yes | 条件属性の値  |


##### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### レスポンス


| 名前 | タイプ           | 必須 | 説明 |   
|------------ |--------------| ------- | ------------ |
|   header | [共通レスポンス](#response) | Yes |


<a id="add-project"></a>

#### プロジェクト追加

> POST "/v1/organizations/{org-id}/projects"

組織にプロジェクトを追加する API です。

##### 必要権限
`Organization.Project.Create`

##### リクエストパラメータ



| 구분 | 이름 | 타입 | 필수 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
| Path |org-id | String| Yes | プロジェクトを追加する組織 ID | 
| Request Body | request | CreateProjectRequest| Yes | リクエスト |


###### CreateProjectRequest


| 이름 | 타입 | 필수 | 説明 |   
|------------ | ------------- | ------ | ------------ |
|   description | String| No | プロジェクトの説明（最大 100 文字）|
|   projectName | String| Yes| プロジェクト名（最大 40 文字）|


##### レスポンス本文

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
###### レスポンス

| 이름 | 타입 | 필수 | 説明 |   
|------------ | ------------- | --------- | ------------ |
|   header | [共通レスポンス](#応답)| Yes  |
|   regDateTime | Date| Yes   | プロジェクト作成日時 | 
|   description | String| No   | プロジェクトの説明 | 
|   ownerId | String| Yes   | プロジェクトオーナーメンバー ID | 
|   projectName | String| Yes   | プロジェクト名 | 
|   projectId | String| Yes   | プロジェクト ID | 
|   orgId | String| Yes   | 組織 ID | 
|   projectStatusCode | String| Yes   | プロジェクトステータス<br><ul><li>STABLE: 正常に使用中の状態</li><li>CLOSED: 支払いが完了しプロジェクトが正常にクローズされた状態</li><li>BLOCKED: 管理者によって使用が禁止された状態</li><li>TERMINATED: 延滞によりすべてのリソースが削除された状態</li><li>DISABLED: すべてのサービスがクローズされているが、料金が支払われていない状態</li></ul> | 


<a id="delete-a-single-project-member"></a>

#### プロジェクトメンバー単件削除

> DELETE "/v1/projects/{project-id}/members/{target-uuid}"

ユーザーを該当プロジェクトから削除する API です。

##### 必要権限
`Project.Member.Delete`

##### リクエストパラメータ



| 구분 | 名前 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | プロジェクト ID | 
|  Path |target-uuid | String| Yes | 削除対象メンバー UUID | 




##### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### レスポンス


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------- | ------------ |
|   header | [共通レスポンス](#response)| Yes |



<a id="delete-a-project"></a>

#### プロジェクト削除

> DELETE "/v1/projects/{project-id}"

プロジェクトを削除する API です。

##### 必要権限
以下のリストのいずれか 1 つの権限が必要です。
* `Organization.Project.Delete`
* `Project.Delete`

##### リクエストパラメータ



| 구분 | 이름 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | 削除するプロジェクト ID | 






##### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### レスポンス


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------- | ------------ |
|   header | [共通レスポンス](#response)| Yes |



<a id="disable-project-service"></a>

#### プロジェクトサービス終了

> DELETE "/v1/projects/{project-id}/products/{product-id}/disable"

該当プロジェクトでユーザーが指定したサービスを無効化するAPIです。

##### 必要権限
`サービス名:Product.Delete`

##### リクエストパラメータ


| 区分 | 名前 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | サービスを終了するプロジェクトID | 
|  Path |product-id | String| Yes | サービスID | 





##### レスポンス本文

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

###### レスポンス


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------- | ------------ |
|   header | [共通レスポンス](#response)| Yes |
|   childProducts | List&lt;ChildProduct>| No   | 該当サービスのサブサービス情報です。サブサービスが存在しない場合は含まれません。<br>サブサービスを先に無効化してから、該当サービスを無効化する必要があります。|

###### ChildProduct


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | --------- | ------------ |
|   productId | String| Yes  | サブサービスID | 
|   productName | String| Yes  | サブサービス名 |
|   statusCode | String| Yes |   サービス状態（STABLE、CLOSED） |


<a id="enable-service-for-project"></a>

#### プロジェクトサービス利用

> POST "/v1/projects/{project-id}/products/{product-id}/enable"

該当プロジェクトでユーザーが指定したサービスを利用できるように有効化をリクエストするAPIです。

##### 必要権限
`サービス名:Product.Create`

##### リクエストパラメータ



| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |product-id | String| Yes | サービスID | 
|  Path |project-id | String| Yes | サービスを利用するプロジェクトID | 


##### レスポンス本文

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

###### レスポンス


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------- | ------------ |
|   header | [共通レスポンス](#response)| Yes |
|   appKey | String| Yes | 該当プロジェクトで利用中のサービスのアプリキー情報|
|   parentProduct | ParentProduct| No | 上位サービス情報がある場合は該当情報を表示し、上位サービスがない場合は含まない |
|   secretKey | String| No| 該当プロジェクトで利用中のサービスに対するシークレットキー情報<br> シークレットキーを利用するサービスでのみ提供 |


###### ParentProduct


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | --------- | ------------ |
|   productId | String| Yes  | サービスID |
|   productName | String| Yes  | サービス名 |
|   statusCode | String| Yes | サービス状態(STABLE, CLOSED) |





<a id="list-organization-roles"></a>

#### 組織ロール一覧照会

> GET "/v1/organizations/{org-id}/roles"

組織ユーザーに付与できるロールの一覧を取得するAPIです。

##### 必要権限
`Organization.RoleGroup.List`

##### リクエストパラメータ



| 区分 | 名前 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 組織ID |
|  Query |categoryTypeCodes | List&lt;String> | No | ロール/権限/ロールグループカテゴリー区分（ROLE、PERMISSION、ROLE_GROUP） |
|  Query |roleNameLike | String| No | ロール/権限/ロールグループ名 |
|  Query |limit | Integer| No | ページごとの表示件数、デフォルト値 20 | 
|  Query |page | Integer| No | 対象ページ、デフォルト値 1 |



##### レスポンス本文

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



###### レスポンス


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------- | ------------ |
|   header | [共通レスポンス](#response)| Yes |
|   roles | List&lt;RoleProtocol>| Yes  | ロール一覧 |
|   totalCount | Integer| Yes  | 総件数 |

###### RoleProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   categoryKey | String| Yes | ロール/権限カテゴリー分類キー<br><ul><li>RoleGroup: プロジェクトロールグループ</li><li>OrgRoleGroup: 組織ロールグループ</li><li>OrgRole: 組織ロール</li><li>ProjectRole: プロジェクトロール</li><li>BillingRole: Billing関連ロール</li><li>OrgServiceRole: 組織サービスロール</li><li>ProjectServiceRole: プロジェクトサービスロール</li><li>SystemRole: システム生成ロール</li></ul>  |
|   categoryTypeCode | String| Yes | ロールグループ/ロール/権限区分コード（ORG_ROLE_GROUP、PERMISSION、ROLE、ROLE_GROUP、SYSTEM） |
|   description | String| Yes | ロール/権限の説明  |
|   roleCategory | String| Yes | ロール/権限カテゴリー大分類（ORG_ROLE、ORG_ROLE_GROUP、ORG_SERVICE_ROLE、PROJECT_ROLE、PROJECT_ROLE_GROUP、PROJECT_SERVICE_ROLE、SYSTEM_ROLE） |
|   roleId | String| Yes | ロール/権限ID  |
|   roleName | String| Yes | ロール/権限名  |


<a id="list-project-roles"></a>

#### プロジェクト役割一覧照会

> GET "/v1/projects/{project-id}/roles"

プロジェクトユーザーに付与できる役割の一覧を要求する API です。

##### 必要権限
`Project.RoleGroup.List`

##### リクエストパラメータ


| 区分 | 名前 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | プロジェクト ID | 
|  Query |categoryTypeCodes | List&lt;String> | No | ロール/権限/ロールグループカテゴリー区分 (ROLE, PERMISSION, ROLE_GROUP) |
|  Query |roleNameLike | String| No | ロール/権限/ロールグループ名 |
|  Query |limit | Integer| No | ページあたりの表示件数、デフォルト値 20 | 
|  Query |page | Integer| No | 対象ページ、デフォルト値 1 |


##### レスポンス本文

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


###### レスポンス


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------- | ------------ |
|   header | [共通レスポンス](#response)| Yes |
|   roles | List&lt;[RoleProtocol](#roleprotocol)>| Yes  | ロール一覧 |
|   totalCount | Integer| Yes  | 総件数 |

<a id="search-organization-domains"></a>

#### 組織ドメイン検索

> GET "/v1/organizations/{org-id}/domains"

特定の組織のドメインを照会する API です。

##### 必要権限
`Organization.Domain.List`

##### リクエストパラメータ



| 区分 | 名前 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 照会する組織の ID | 




##### レスポンス本文

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

###### レスポンス


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------- | ------------ |
|   header | [共通レスポンス](#response)| Yes |
|   domainList | List&lt;OrgDomainProtocol>| Yes  |


###### OrgDomainProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | --------- | ------------ |
|   orgDomainId | String| Yes | 組織ドメイン ID |
|   orgDomainName | String| Yes | 組織ドメイン名 |


<a id="get-organization-member"></a>

#### 組織メンバー単件照会

> GET "/v1/organizations/{org-id}/members/{member-uuid}"

組織に所属するメンバーを照会する API です。

##### 必要権限
`Organization.Member.Get`

##### リクエストパラメータ



| 구분 | 이름 | 타입 | 필수 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | メンバーを照会する組織 ID | 
|  Path |member-uuid | String| Yes | 照会するメンバーの UUID | 





##### レスポンス本文

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
      "description": "説明",
      "categoryTypeCode": "ORG_ROLE_GROUP",
      "conditions": [ {
        "attributeId": "attributeId",
        "attributeOperatorTypeCode": "ALLOW",
        "attributeValues": [ "attributeValues", "attributeValues" ],
        "attributeDescription": "条件属性の説明",
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

###### レスポンス


| 이름 | 타입 | 필수 | 説明 |   
|------------ | ------------- | ------- | ------------ |
|   header | [共通レスポンス](#response)| Yes |
|   orgMember | OrgMemberRoleBundleProtocol| No  | 追加されたメンバー情報。エラー時は含まれません |

###### OrgMemberRoleBundleProtocol


| 이름 | 타입 | 필수 | 説明 |   
|------------ | ------------- | ----- | ------------ |
|   email | String| Yes | メンバーのメールアドレス |
|   id | String| No | メンバー ID（IAM アカウントのみ提供） |
|   inviteStatusCode | String| Yes |   COMPLETE, EXPIRE, UNKNOWN, WAIT |
|   joinYmdt | Date| Yes | 組織メンバー登録日時 |
|   memberName | String| Yes| メンバー名 |
|   memberTypeCode | String| Yes| アカウント区分（TOAST_CLOUD: NHN Cloud アカウント、IAM: IAM アカウント） |
|   memberUuid | String| Yes| メンバーの UUID |
|   recentLoginYmdt | Date| Yes| 最終ログイン日時 |
|   recentPasswordModifyYmdt | Date| No| 最終パスワード変更日時 |
|   roleCode | String| No| ロール ID |
|   roles | List&lt;RoleBundleProtocol>| No | 関連ロールリスト（条件属性を含む）  |
|   secondFactorCertificationYn | String| No| 2段階ログイン設定有無（NHN Cloud アカウントのみ提供） |


###### RoleBundleProtocol
| 이름 | 타입 | 필수 | 説明 |   
|------------ | ------------- | ----- | ------------ |
|   roleId | String| Yes |  ロール ID |
|   roleName | String| Yes |  ロール名 |
|   description | String| No |  ロールの説明 |
|   categoryKey | String| Yes | ロール/権限カテゴリー分類キー<br><ul><li>RoleGroup: プロジェクトロールグループ</li><li>OrgRoleGroup: 組織ロールグループ</li><li>OrgRole: 組織ロール</li><li>ProjectRole: プロジェクトロール</li><li>BillingRole: Billing 関連ロール</li><li>OrgServiceRole: 組織サービスロール</li><li>ProjectServiceRole: プロジェクトサービスロール</li><li>SystemRole: システム生成ロール</li></ul>  |
|   categoryTypeCode | String| Yes | ロールグループ/ロール/権限区分コード（ORG_ROLE_GROUP, PERMISSION, ROLE, ROLE_GROUP, SYSTEM） |
|   conditions | List&lt;AttributeConditionProtocol>| No | 条件属性リスト |
|   roleApplyPolicyCode | String| Yes | ロール使用有無  ALLOW, DENY |
|   regDateTime | Date| Yes |  ロール作成日時 |



###### AttributeConditionProtocol


| 이름 | 타입 | 필수 | 説明 |   
|------------ | ------------- | ----- | ------------ |
|   attributeDataTypeCode | String| Yes |  条件属性データタイプ（BOOLEAN, DATETIME, DAY_OF_WEEK, IPADDRESS, NUMERIC, STRING, TIME） |
|   attributeDescription | String| No | 条件属性の説明 |
|   attributeId | String| Yes | 条件属性 ID |
|   attributeName | String| Yes | 条件属性名 |
|   attributeOperatorTypeCode | String| Yes | 条件属性演算子<br>条件属性データタイプによって使用できる演算子が異なります<br><ul><li>ALLOW</li><li>ALL_CONTAINS</li><li>ANY_CONTAINS</li><li>ANY_MATCH</li><li>BETWEEN</li><li>BEYOND</li><li>FALSE</li><li>GREATER_THAN</li><li>GREATER_THAN_OR_EQUAL_TO</li><li>LESS_THAN</li><li>LESS_THAN_OR_EQUAL_TO</li><li>NONE_MATCH</li><li>NOT_ALLOW</li><li>NOT_CONTAINS</li><li>TRUE</li></ul> |
|   attributeValues | List&lt;String>| Yes| 条件属性値 |



<a id="list-organization-members"></a>

#### 組織メンバー一覧照会

> POST "/v1/organizations/{org-id}/members/search"

該当組織に所属する NHN Cloud メンバーの一覧を照会する API です。

##### 必要権限
`Organization.Member.List`

##### リクエストパラメータ



| 区分 | 名前 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 組織 ID | 
| Request Body | request | SearchOrgMembersRequest| Yes | リクエスト |


###### SearchOrgMembersRequest


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | --------- | ------------ |
|   memberStatusCodes | List&lt;String>| No | 照会するメンバーの状態<br><ul><li>STABLE: 招待完了</li><li>INVITED: 招待中</li><li>BLOCKED</li><li>NOT_EXIST</li><li>WITHDRAW</li></ul> |
|   roleIds | Set&lt;String>| No  | メンバーに付与されたロール ID |
|   paging | PagingBean| No  |

###### PagingBean


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   limit | Integer| No | 1ページあたりの表示件数、デフォルト値 20  |
|   page | Integer| No | 対象ページ、デフォルト値 1  |




##### レスポンス本文

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
###### レスポンス


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------- | ------------ |
|   header | [共通レスポンス](#response)| Yes |
|   orgMembers | List&lt;OrgMemberWithInviteMemberrotocol>| Yes | 組織メンバー一覧 |
|   paging | PagingResponse| Yes | ページ情報 |

###### OrgMemberWithInviteMemberProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----- | ------------ |
|   email | String| Yes | メンバーのメールアドレス |
|   inviteStatusCode | String| No | メンバーの招待状態（COMPLETE、EXPIRE、UNKNOWN、WAIT） |
|   joinYmdt | Date| Yes | メンバー登録日時 |
|   maskingEmail | String| Yes | メンバーのマスクされたメールアドレス |
|   memberName | String| Yes| メンバーの名前 |
|   memberTypeCode | String| Yes| メンバー区分（TOAST_CLOUD: NHN Cloud アカウント、IAM: IAM アカウント） |
|   memberUuid | String| No| メンバーの UUID<br>招待中の場合は値を返しません |
|   recentLoginYmdt | Date| Yes| 最終ログイン日時 |
|   recentPasswordModifyYmdt | Date| No| 最終パスワード変更日時 |
|   secondFactorCertificationYn | String| No|  2段階ログイン設定の有無（NHN Cloud メンバーのみ提供） |

###### PagingResponse


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   limit | Integer| No | 1ページあたりの表示件数、デフォルト値 20  |
|   page | Integer| No | 対象ページ、デフォルト値 1  |
|   totalCount | Long| Yes | 総件数  |




<a id="view-all-common-role-groups-for-projects-in-the-organization"></a>

#### 組織のプロジェクト共通ロールグループ全体照会

> GET "/v1/organizations/{org-id}/project-role-groups"

組織で設定したプロジェクト共通ロールグループの一覧を照会する API です。

##### 必要な権限
`Organization.Project.RoleGroup.List`

##### リクエストパラメータ



| 区分 | 名前 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 照会対象の組織 ID | 
|  Query |descriptionLike | String| No | 説明 | 
|  Query |roleGroupNameLike | String| No | ロールグループ名 |
|  Query |limit | Integer| No | ページあたりの表示件数、デフォルト値 20 |
|  Query |page | Integer| No | 対象ページ、デフォルト値 1 |






##### レスポンス本文

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



###### レスポンス


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | --------- | ------------ |
|   header | [共通レスポンス](#response)| Yes  |
|   paging | [PagingResponse](#pagingresponse)| Yes  |
|   roleGroups | List&lt;RoleGroupProtocol>| Yes | プロジェクトで使用可能なロールグループ一覧  |


###### RoleGroupProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----- | ------------ |
|   description | String| No | ロールグループの説明 |
|   regDateTime | Date| Yes | ロールグループの作成日時 |
|   roleGroupId | String| Yes | ロールグループ ID |
|   roleGroupName | String| Yes| ロールグループの名前 |
|   roleGroupType | String| Yes | ロールグループの種類<br><ul><li>ORG: プロジェクト共通ロールグループ</li><li>ORG_ROLE_GROUP: 組織ロールグループ</li><li>PROJECT: プロジェクトロールグループ</li> |


<a id="get-service-hierarchy"></a>

#### サービス階層構造の照会

> GET "/v1/product-uis/hierarchy"

請求書に表示されるホームページカテゴリーおよびホームページサービス情報を返す API です。

##### 必要権限
メンバーであれば、特定の権限なしに呼び出すことができる API です。<br>
ただし、組織サービスを照会する場合は、該当組織またはその組織配下にあるプロジェクトのメンバーである必要があります。

##### リクエストパラメータ



| 区分 | 名前 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Query |productUiType | String| Yes | サービス UI タイプ<br><ul><li>PROJECT: プロジェクトサービス</li><li>ORG: 組織サービス</li><li>MARKET_PLACE: マーケットプレイスサービス</li></ul> |
|  Query |orgId | String| No | サービス UI タイプが ORG の場合、組織 ID を必ず入力する必要があります |




##### レスポンス本文

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

###### レスポンス


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------- | ------------ |
|   header | [共通レスポンス](#response)| Yes |
|   productUiList | List&lt;ProductUiHierarchyProtocol>| Yes  | ホームページカテゴリーサービス UI 一覧 |

###### ProductUiHierarchyProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----- | ------------ |
|   children | List&lt;ProductUiHierarchyProtocol>| No | ホームページサービスのサービス UI 一覧 |
|   manualLink | String| No|
|   parentProductUiId | String| No| サービス UI 区分 |
|   productId | String| No|
|   productUiId | String| No| サービス UI 識別キー |
|   productUiName | String| No|


<a id="get-service-used-by-project"></a>

#### プロジェクトで使用中のサービス照会

> GET "/v1/projects/{project-id}/products/{product-id}"

* プロジェクトで使用中の特定サービス情報を照会する API

##### 必要権限
`サービス名:ProductAppKey.Get`

##### リクエストパラメータ



| 区分 | 名前 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | 照会対象プロジェクト ID |
|  Path |product-id | String| Yes | 照会対象サービス ID |




##### レスポンス本文

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

###### レスポンス


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------- | ------------ |
|   header | [共通レスポンス](#response)| Yes |
|   hasUpdateSecretKeyPermission | Boolean| Yes | シークレットキー再発行可能権限  |
|   product | ProjectProductRelationAndProductProtocol| Yes  | 指定したサービス ID に対してプロジェクトで使用中のサービス情報を返します。エラー時は含まれません |


###### ProjectProductRelationAndProductProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   appKey | String| Yes | 該当プロジェクトで利用中のサービスのアプリキー情報  |
|   externalId | String| No | テナント ID<br>サービスにテナント ID が存在する場合にのみ提供 |
|   productId | String| Yes | サービス ID  |
|   productName | String| Yes | サービス名  |
|   productSecretKeyCode | String| No | シークレットキー使用有無<br>T: 使用する<br>その他: 使用しない（F、N） |
|   productStatusCode | String| Yes | サービスステータス（STABLE、CLOSED） |
|   projectId | String| Yes | 該当サービスを使用するプロジェクト ID  |
|   relationDate | Date| Yes | サービス利用開始日時  |
|   secretKey | String| Yes | サービス SecretKey<br>secretKey を使用するサービスでのみ提供  |
|   statusCode | String| Yes | 該当サービスの利用ステータス（STABLE、CLOSED） |
|   updateDate | Date| No | サービス最終更新日時  |
|   updateUuid | String| No | サービスアプリキー更新者 UUID  |


<a id="get-project-member"></a>

#### プロジェクトメンバー単件照会

> GET "/v1/projects/{project-id}/members/{member-uuid}"

プロジェクトに所属する特定のメンバーを照会する API です。

##### 必要権限
`Project.Member.Get`

##### リクエストパラメータ



| 区分 | 名前 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | メンバーを照会するプロジェクト ID |
|  Path |member-uuid | String| Yes | 照会するメンバーの UUID |




##### レスポンス本文

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


###### レスポンス


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------- | ------------ |
|   header | [共通レスポンス](#response)| Yes |
|   projectMember | ProjectMemberRoleBundleProtocol| Yes  | 追加されたメンバー情報。エラー時は含まれません |


###### ProjectMemberRoleBundleProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   emailAddress | String| No | メンバーのメールアドレス  |
|   maskingEmail | String| No | メンバーのマスクされたメール  |
|   memberName | String| No | メンバー名  |
|   memberTypeCode | String| No | メンバー区分（IAM、TOAST_CLOUD） |
|   relationDateTime | Date| No | メンバー追加日時  |
|   roles | List&lt;RoleBundleProtocol>| No | 関連ロール一覧（条件属性を含む）  |
|   statusCode | String| No | 招待ステータスコード（COMPLETE、EXPIRE、UNKNOWN、WAIT） |
|   uuid | String| No | メンバーの UUID  |


[RoleBundleProtocol](#rolebundleprotocol)



<a id="list-project-members"></a>

#### プロジェクトメンバー一覧照会

> POST "/v1/projects/{project-id}/members/search"

プロジェクトに所属するメンバーの一覧を照会するための API です。

##### 必要権限
`Project.Member.List`

##### リクエストパラメータ


| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | 照会するプロジェクト ID | 
| Request Body | request | SearchProjectMembersRequest| Yes | リクエスト |



###### SearchProjectMembersRequest


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ----------- | ------------ |
|   memberStatusCodes | List&lt;String>| No | プロジェクトメンバーのステータスコード (INVITED, STABLE) |
|   roleIds | List&lt;String>| No | ロール ID 一覧  |
|   paging | [PagingBean](#pagingbean) | No   |





##### レスポンス本文

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

###### レスポンス


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------- | ------------ |
|   header | [共通レスポンス](#응답)| Yes |
|   paging | [PagingResponse](#pagingresponse)| Yes  |
|   projectMembers | List&lt;ProjectMemberProtocol>| Yes | プロジェクトメンバー  |



###### ProjectMemberProtocol


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------------- | ------------ |
|   emailAddress | String| No | メンバーのメールアドレス  |
|   maskingEmail | String| No | メンバーのマスクされたメール  |
|   memberName | String| No | メンバー名  |
|   memberTypeCode | String| No | メンバー区分 |
|   relationDateTime | Date| No | メンバー追加日時  |
|   statusCode | String| No | 招待ステータスコード (COMPLETE, EXPIRE, UNKNOWN, WAIT) |
|   uuid | String| No | メンバー UUID  |


<a id="get-project-role-group"></a>

#### プロジェクト役割グループ単件照会

> GET "/v1/projects/{project-id}/project-role-groups/{role-group-id}"

プロジェクトの役割グループを照会する API です。

##### 必要権限
`Project.RoleGroup.Get`

##### リクエストパラメータ



| 구분 | 이름 | 타입 | 필수 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | 照会対象プロジェクト ID | 
|  Path |role-group-id | String| Yes | プロジェクト役割グループ ID<br>プロジェクト共通役割グループ ID は照会不可 | 




##### レスポンス本文

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

###### レスポンス


| 이름 | 타입 | 필수 | 説明 |   
|------------ | ------------- | --------- | ------------ |
|   header | [共通レスポンス](#응답)| Yes |
|   roleGroup | RoleGroupBundleProtocol| Yes | 関連ロールを含む役割グループ  |

###### RoleGroupBundleProtocol

| 이름 | 타입 | 필수 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   roleGroupId | String| No | 役割グループ ID  |
|   roleGroupName | String| No | 役割グループ名  |
|   description | String| No | 役割グループの説明  |
|   roleGroupType | String| No | 役割グループ区分（組織、プロジェクト）  |
|   roles | List&lt;[RoleBundleProtocol](#rolebundleprotocol)>| No | 関連ロール一覧  |
|   regDateTime | Date| No | 登録日時  |



<a id="view-a-common-role-group-for-the-project-in-the-organization"></a>

#### 組織のプロジェクト共通ロールグループ単件照会

> GET "/v1/organizations/{org-id}/project-role-groups/{role-group-id}"

プロジェクト共通ロールグループを照会する API です。

##### 必要権限
`Organization.Project.RoleGroup.Get`

##### リクエストパラメータ


| 区分 | 名前 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 照会対象の組織 ID | 
|  Path |role-group-id | String| Yes | プロジェクト共通ロールグループ ID | 


##### レスポンス本文

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


###### レスポンス


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | --------- | ------------ |
|   header | [共通レスポンス](#response)| Yes |
|   roleGroup | [RoleGroupBundleProtocol](#rolegroupbundleprotocol) | Yes | 関連ロールを含むロールグループ  |




<a id="list-all-project-role-groups"></a>

#### プロジェクト役割グループ全件照会

> GET "/v1/projects/{project-id}/project-role-groups"

プロジェクトの役割グループを全件照会する API です。

##### 必要権限
`Project.RoleGroup.List`

##### リクエストパラメータ


| 区分 | 名前 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | 照会対象プロジェクト ID | 
|  Query |descriptionLike | String| No | 説明 |
|  Query |roleGroupNameLike | String| No | 役割グループ名 |
|  Query |limit | Integer| No | ページあたりの表示件数、デフォルト値 20 |
|  Query |page | Integer| No | 対象ページ、デフォルト値 1 |



##### レスポンス本文

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

###### レスポンス


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | --------- | ------------ |
|   header | [共通レスポンス](#response)| Yes  |
|   paging | [PagingResponse](#pagingresponse)| Yes  |
|   roleGroups | List&lt;[RoleGroupProtocol](#rolegroupprotocol)>| Yes | プロジェクトで使用可能な役割グループリスト  |

<a id="list-projects-in-organization"></a>

#### 組織に属するプロジェクト一覧照会

> GET "/v1/organizations/{org-id}/projects"

特定の組織に属する STABLE 状態のプロジェクト一覧を照会する API です。

##### 必要権限
組織のメンバー

##### リクエストパラメータ


| 区分 | 名前 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 照会する組織の ID | 
|  Query |memberUuid | String| No | 組織のメンバー UUID |
|  Query |projectName | String| No | プロジェクト名 |
|  Query |page | Integer| No | 対象ページ、デフォルト値 1 |
|  Query |limit | Integer| No | 1ページあたりの表示件数、デフォルト値 20 |


##### レスポンス本文

```json
{
  "projectList": [ {
    "regDateTime": "2000-01-23T04:56:07.000+00:00",
    "delDateTime": "2000-01-23T04:56:07.000+00:00",
    "description": "説明",
    "orgId": "orgId",
    "projectStatusCode": "STABLE",
    "modDateTime": "2000-01-23T04:56:07.000+00:00",
    "projectName": "プロジェクト名",
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


###### レスポンス


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------- | ------------ |
|   header | [共通レスポンス](#response)| Yes |
|   paging | [PagingResponse](#pagingresponse) | Yes |
|   projectList | List&lt;OrgProjectMemberRoleProtocol>| Yes |



###### OrgProjectMemberRoleProtocol

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----- | ------------ |
|   delDateTime | Date| No | プロジェクト削除日時 |
|   description | String| No | プロジェクトの説明 |
|   modDateTime | Date| No| プロジェクト修正日時 |
|   orgId | String| Yes| プロジェクトが属する組織 ID |
|   projectId | String| Yes| プロジェクト ID |
|   projectName | String| Yes| プロジェクト名 |
|   projectStatusCode | String| Yes | プロジェクトの状態<br><ul><li>STABLE: 正常に使用中の状態</li><li>CLOSED: 支払いが完了し、プロジェクトが正常に終了した状態</li><li>BLOCKED: 管理者によって使用が禁止された状態</li><li>TERMINATED: 延滞により、すべてのリソースが削除された状態</li><li>DISABLED: すべてのサービスが終了しているが、支払いが完了していない状態</li></ul> |
|   regDateTime | Date| Yes| プロジェクト登録日時 |


<a id="list-organization-governance-in-use"></a>

#### 使用中の組織ガバナンス一覧照会

> GET "/v1/organizations/{org-id}/governances"

有効化されているガバナンスを照会する API です。

##### 必要な権限
`Organization.Governance.List`

##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 |
|------------- |------------- | ------------- | ------------- | ------------- |
| Path | org-id | String | Yes | 照会対象の組織 ID |



##### レスポンス本文

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



###### レスポンス


| 名前 | タイプ | 必須 | 説明 |
|------------ | ------------- | ----------- | ------------ |
| header | [共通レスポンス](#response) | Yes | |
| usingGovernances | List&lt;GovernanceProtocol&gt; | No | 使用中のガバナンス一覧 |


###### GovernanceProtocol


| 名前 | タイプ | 必須 | 説明 |
|------------ | ------------- | ------------- | ------------ |
| governanceTypeCode | String | No | ガバナンスタイプ<br>- APPROVE_PROCESS: 承認処理<br>- BLOCK_STORAGE_SNAPSHOT: Block Storage の Snapshot 機能使用有無<br>- IAAS_RESOURCE_PROTECTION_AND_SEPARATED_NETWORK: IaaS リソースの権限制御および接続端末の制限設定<br>- PRIVACY_PROTECTION: 個人情報保護<br>- UNIQUE_INSTANCE_NAME: インスタンス名の重複防止 |
| regDatetime | Date | No | ガバナンス使用設定日時 |

<a id="create-a-common-role-group-for-projects-in-the-organization"></a>

#### 組織のプロジェクト共通ロールグループの作成

> POST "/v1/organizations/{org-id}/project-role-groups"

プロジェクト共通ロールグループを作成するAPIです。


##### 必要権限
`Organization.Project.RoleGroup.Create`

##### リクエストパラメータ

| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 組織ID | 
| Request Body | request | CreateRoleGroupRequest| Yes | リクエスト |

###### CreateRoleGroupRequest

| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------------- | ------------ |
|   description | String| No | ロールグループの説明  |
|   roleGroupName | String| Yes | ロールグループ名  |
|   roles | List&lt;AssignRoleProtocol>| Yes | ロールグループに割り当てるロールのリスト  |


###### AssignRoleProtocol


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------------- | ------------ |
|   conditions | List&lt;[AssignAttributeConditionProtocol](#assignattributeconditionprotocol)>| No | ロール条件属性  |
|   roleApplyPolicyCode | String| Yes | ロール使用有無  ALLOW, DENY |
|   roleId | String| Yes | ロールID  |




##### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### レスポンス

| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#response)| Yes   |


<a id="delete-a-project-common-role-group-in-the-organization"></a>

#### 組織のプロジェクト共通ロールグループの削除

> DELETE "/v1/organizations/{org-id}/project-role-groups"

プロジェクト共通ロールグループを削除する API です。

##### 必要な権限
`Organization.Project.RoleGroup.Delete`

##### リクエストパラメータ


| 区分 | 名前 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 組織 ID | 
| Request Body | request | DeleteRoleGroupRequest| Yes | リクエスト |


###### DeleteRoleGroupRequest


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   roleGroupIds | List&lt;String>| Yes | ロールグループ ID 一覧  |


##### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#response)| Yes   |

<a id="modify-your-organizations-project-common-role-group-information"></a>

#### 組織のプロジェクト共通ロールグループ情報の修正

> PUT "/v1/organizations/{org-id}/project-role-groups/{role-group-id}/infos"

プロジェクト共通ロールグループの名前と説明を修正する API です。

##### 必要な権限
`Organization.Project.RoleGroup.Update`

##### リクエストパラメータ


| 区分 | 名前 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 組織 ID | 
|  Path |role-group-id | String| Yes | ロールグループ ID | 
| Request Body | request | UpdateRoleGroupInfoRequest| Yes | リクエスト |


###### UpdateRoleGroupInfoRequest


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   description | String| No | ロールグループの説明  |
|   roleGroupName | String| Yes | ロールグループ名  |



##### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#response)| Yes   |

<a id="modify-your-organizations-project-common-roles-group-roles"></a>

#### 組織のプロジェクト共通ロールグループのロール修正

> PUT "/v1/organizations/{org-id}/project-role-groups/{role-group-id}/roles"

プロジェクト共通ロールグループのロールを修正する API です。

##### 必要権限
`Organization.Project.RoleGroup.Update`

##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 組織ID | 
|  Path |role-group-id | String| Yes | ロールグループID | 
| Request Body | request | UpdateRoleGroupRequest| Yes | リクエスト |


###### UpdateRoleGroupRequest


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   roles | List&lt;[AssignRoleProtocol](#assignroleprotocol)>| Yes | ロールグループに割り当てるロールリスト  |




##### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#response)| Yes   |

<a id="create-project-role-group"></a>

#### プロジェクト役割グループ作成

> POST "/v1/projects/{project-id}/project-role-groups"

プロジェクトに役割グループを作成する API です。


##### 必要権限
`Project.RoleGroup.Create`

##### リクエストパラメータ


| 区分 | 名前 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | プロジェクト ID | 
| Request Body | request | [CreateRoleGroupRequest](#createrolegrouprequest)| Yes | リクエスト |





##### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#response)| Yes   |

<a id="delete-project-role-group"></a>

#### プロジェクトロールグループの削除

> DELETE "/v1/projects/{project-id}/project-role-groups"

プロジェクトロールグループを削除する API です。


##### 必要な権限
`Project.RoleGroup.Delete`

##### リクエストパラメータ


| 区分 | 名前 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | プロジェクト ID | 
| Request Body | request | [DeleteRoleGroupRequest](#deleterolegrouprequest)| Yes | リクエスト |




##### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#response)| Yes   |

<a id="edit-project-role-group-information"></a>

#### プロジェクトロールグループ情報の修正

> PUT "/v1/projects/{project-id}/project-role-groups/{role-group-id}/infos"

プロジェクトロールグループの名前と説明を修正する API です。

##### 必須権限
`Project.RoleGroup.Update`

##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | プロジェクト ID | 
|  Path |role-group-id | String| Yes | ロールグループ ID | 
| Request Body | request |[UpdateRoleGroupInfoRequest](#updaterolegroupinforequest)| Yes | リクエスト |


##### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#response)| Yes   |


<a id="modify-project-role-group-roles"></a>

#### プロジェクトロールグループのロール修正

> PUT "/v1/projects/{project-id}/project-role-groups/{role-group-id}/roles"

プロジェクトロールグループのロールを修正する API です。

##### 必要な権限
`Project.RoleGroup.Update`

##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 |
|------------- |------------- | ------------- | ------------- | ------------- |
|  Path |project-id | String| Yes | プロジェクト ID |
|  Path |role-group-id | String| Yes | ロールグループ ID |
| Request Body | request | UpdateRoleGroupRequest| Yes | リクエスト |

###### UpdateRoleGroupRequest

| 名前 | タイプ | 必須 | 説明 |
|------------ | ------------- | ------------- | ------------ |
|   roles | List&lt;[AssignRoleProtocol](#assignroleprotocol)>| Yes | ロールグループに割り当てるロールリスト |

##### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### レスポンス

| 名前 | タイプ | 必須 | 説明 |
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#response)| Yes   |


<a id="list-all-organization-role-groups"></a>

#### 組織ロールグループ全件照会

> GET "/v1/organizations/{org-id}/org-role-groups"

組織のロールグループを全件照会する API です。

##### 必要権限

`Organization.RoleGroup.List`

##### 요청 파라미터

| 구분 | 이름 | 타입 | 필수 | 설명 |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| Path | org-id | String | Yes | 照会対象の組織 ID |
| Query | descriptionLike | String | No | 説明（該当の文字列が含まれる結果を照会） |
| Query | roleGroupNameLike | String | No | ロールグループ名（該当の文字列が含まれる結果を照会） |
| Query | limit | Integer | No | ページあたりの表示件数（デフォルト: 20、最小値: 1、最大値: 2000） |
| Query | page | Integer | No | 対象ページ（デフォルト: 1、最小値: 1） |

##### レスポンス本文

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

###### レスポンス

| 이름 | 타입 | 필수 | 설명 |
| ------------ | ------------- | --------- | ------------ |
| header | [共通レスポンス](#응답) | Yes | |
| paging | [PagingResponse](#pagingresponse) | Yes | |
| roleGroups | List&lt;[RoleGroupProtocol](#rolegroupprotocol)> | Yes | 組織で使用可能なロールグループ一覧 |

<a id="get-an-organization-role-group"></a>

#### 組織ロールグループ単件照会

> GET "/v1/organizations/{org-id}/org-role-groups/{role-group-id}"

組織のロールグループを照会する API です。

##### 必要権限

`Organization.RoleGroup.Get`

##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| Path | org-id | String | Yes | 照会対象の組織 ID |
| Path | role-group-id | String | Yes | 組織ロールグループ ID |

##### レスポンス本文

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

###### レスポンス

| 名前 | タイプ | 必須 | 説明 |
| ------------ | ------------- | --------- | ------------ |
| header | [共通レスポンス](#応답) | Yes | |
| roleGroup | [RoleGroupBundleProtocol](#rolegroupbundleprotocol) | Yes | 関連ロールを含むロールグループ |

<a id="create-organization-role-group"></a>

#### 組織ロールグループ作成

> POST "/v1/organizations/{org-id}/org-role-groups"

組織にロールグループを作成する API です。

##### 必要な権限

`Organization.RoleGroup.Create`

##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| Path | org-id | String | Yes | 組織 ID |
| Request Body | request | [CreateRoleGroupRequest](#createrolegrouprequest) | Yes | リクエスト |

##### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### レスポンス

| 名前 | タイプ | 必須 | 説明 |
| ------------ | ------------- | ----------- | ------------ |
| header | [共通レスポンス](#response) | Yes | |

<a id="delete-organization-role-group"></a>

#### 組織ロールグループ削除

> DELETE "/v1/organizations/{org-id}/org-role-groups"

組織ロールグループを削除する API です。

##### 必要な権限

`Organization.RoleGroup.Delete`

##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| Path | org-id | String | Yes | 組織ID |
| Request Body | request | [DeleteRoleGroupRequest](#deleterolegrouprequest) | Yes | リクエスト |

##### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### レスポンス

| 名前 | タイプ | 必須 | 説明 |
| ------------ | ------------- | ----------- | ------------ |
| header | [共通レスポンス](#response) | Yes | |

<a id="modify-organization-role-group-information"></a>

#### 組織ロールグループ情報の修正

> PUT "/v1/organizations/{org-id}/org-role-groups/{role-group-id}/infos"

組織ロールグループの名前と説明を修正する API です。

##### 必須権限

`Organization.RoleGroup.Update`

##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| Path | org-id | String | Yes | 組織ID |
| Path | role-group-id | String | Yes | ロールグループID |
| Request Body | request | [UpdateRoleGroupInfoRequest](#updaterolegroupinforequest) | Yes | リクエスト |

##### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### レスポンス

| 名前 | タイプ | 必須 | 説明 |
| ------------ | ------------- | ----------- | ------------ |
| header | [共通レスポンス](#response) | Yes | |


<a id="modify-organization-role-group-roles"></a>

#### 組織ロールグループのロール修正

> PUT "/v1/organizations/{org-id}/org-role-groups/{role-group-id}/roles"

組織ロールグループのロールを修正する API です。

##### 必要権限

`Organization.RoleGroup.Update`

##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| Path | org-id | String | Yes | 組織ID |
| Path | role-group-id | String | Yes | ロールグループID |
| Request Body | request | UpdateRoleGroupRequest | Yes | リクエスト |

###### UpdateRoleGroupRequest

| 名前 | タイプ | 必須 | 説明 |
| ------------ | ------------- | ------------- | ------------ |
| roles | List&lt;[AssignRoleProtocol](#assignroleprotocol)> | Yes | ロールグループに割り当てるロールのリスト |

##### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### レスポンス

| 名前 | タイプ | 必須 | 説明 |
| ------------ | ------------- | ----------- | ------------ |
| header | [共通レスポンス](#response) | Yes | |


<a id="modify-organization-member-role"></a>

#### 組織メンバーロールの修正

> PUT "/v1/organizations/{org-id}/members/{member-uuid}"

該当組織に所属するメンバーのロールを修正する API です。


##### 必要な権限
`Organization.Member.Update`


##### リクエストパラメータ


| 区分 | 名前 | タイプ | 必須 | 説明 |
|------------- |------------- | ------------- | ------------- | ------------- |
|  Path |org-id | String| Yes | 組織 ID |
|  Path |member-uuid | String| Yes | 修正するメンバーの UUID |
| Request Body | request | UpdateMemberRoleRequest| Yes | リクエスト |


###### UpdateMemberRoleRequest


| 名前 | タイプ | 必須 | 説明 |
|------------ | ------------- | ------------- | ------------ |
|   assignRoles | List&lt;[UserAssignRoleProtocol](#userassignroleprotocol)>| Yes | ユーザーに割り当てるロールのリスト |


##### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### レスポンス

| 名前 | タイプ | 必須 | 説明 |
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#response)| Yes   |

<a id="modify-project-member-role"></a>

#### プロジェクトメンバーロールの修正

> PUT "/v1/projects/{project-id}/members/{member-uuid}"

プロジェクトで指定したメンバーのロールを修正する API です。

##### 必要権限
`Project.Member.Update`

##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | プロジェクト ID | 
|  Path |member-uuid | String| Yes | ロール変更対象メンバーの UUID | 
| Request Body | request | [UpdateMemberRoleRequest](#updatememberrolerequest)| Yes | リクエスト |




##### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#レスポンス)| Yes   |

<a id="get-organization-iam-account"></a>

#### 組織 IAM アカウント単件照会

> GET "/v1/iam/organizations/{org-id}/members/{member-uuid}"

組織に所属する IAM アカウントを照会する API です。

##### 必要権限
`Organization.Member.Iam.Get`


##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 照会する組織 ID | 
|  Path |member-uuid | String| Yes | 照会する組織の IAM アカウント UUID | 


##### レスポンス本文

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

###### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#response)| Yes   |
|   orgMember | OrgIamMemberRoleBundleProtocol| No  |

###### OrgIamMemberRoleBundleProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----- | ------------ |
|   corporate | String| No | 会社名 |
|   country | String| No | 国籍（組織オーナーの国籍） |
|   createdAt | Date| No | 作成日時 |
|   creationType | String| No| アカウントの作成タイプ |
|   department | String| No| 部署名 |
|   emailAddress | String| Yes | IAM アカウントのメールアドレス  |
|   englishName | String| No| 英語名 | 
|   id | String| Yes | IAM アカウント UUID  |
|   idProviderId | String| No| 外部認証を使用する場合、認証機関 ID |
|   idProviderType | String| No| service: IAM アカウント直接ログイン<br>sso: カスタマー SSO 連携 |
|   idProviderUserId | String| No| 外部認証機関が提供したユーザー ID |
|   lastAccessedAt | Date| No| アカウントの最終接続日時。ない場合は null を返します |
|   lastLoggedInAt | Date| No| アカウントの最終ログイン日時。ない場合は null を返します |
|   lastLoggedInIp | String| No| アカウントの最終ログイン IP アドレス。ない場合は null を返します |
|   maskingEmail | String| No | IAM アカウントのマスキングされたメールアドレス  |
|   mobilePhone | String| No | IAM アカウントの携帯電話番号  |
|   mobilePhoneCountryCode | String| No| 携帯電話番号の国コード（英字 2 文字） |
|   name | String| Yes | IAM アカウントの名前  |
|   nativeName | String| No| 母国語名 |
|   nickname | String| No| ユーザーの別名 |
|   officeHoursBegin | String| No| 業務開始時間（例: 09:00） |
|   officeHoursEnd | String| No| 業務終了時間（例: 18:00） |
|   organizationId | String| Yes | IAM アカウントの組織 ID  |
|   passwordChangedAt | Date| No| アカウントの最終パスワード変更日時。ない場合は null を返します |
|   position | String| No| 役職 |
|   profileImageUrl | String| No| プロフィール画像 URL |
|   roles | List&lt;[RoleBundleProtocol](#rolebundleprotocol)>| No | 関連ロール一覧（条件属性を含む）  |
|   saasRoles | List&lt;IamMemberRole>| No | IAM アカウントロール  |
|   status | String| No| アカウントの状態 |
|   telephone | String| No | IAM アカウントの電話番号  |
|   userCode | String| Yes | IAM アカウント ID  |



###### IamMemberRole


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------- | ------------ |
|   productId | String| No |
|   productName | String| No |
|   role | String| No |


<a id="list-organization-iam-accounts"></a>

#### 組織 IAM アカウント一覧照会

> GET "/v1/iam/organizations/{org-id}/members"

該当組織に所属する IAM アカウントの一覧を照会する API です。

##### 必要権限
`Organization.Member.Iam.List`

##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 組織ID | 
|  Query |email | String| No | IAM アカウントのメールアドレス |
|  Query |emailLike | String| No |  |
|  Query |idProviderType | String| No | service: IAM アカウント直接ログイン<br>sso: 顧客 SSO 連携 |
|  Query |nameLike | String| No |  |
|  Query |statuses | List&lt;String>| No |  |
|  Query |userCode | String| No | IAM アカウント ID |
|  Query |userCodeLike | String| No |  |
|  Query |limit | Integer| No | ページあたりの表示件数、デフォルト値 20 |
|  Query |page | Integer| No | 対象ページ、デフォルト値 1 |

##### レスポンス本文

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


###### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#response)| Yes   |
|   orgMembers | List&lt;IamOrgMemberProtocol>| No | 組織 IAM アカウント一覧  |
|   paging | [PagingResponse](#pagingresponse)| No  |

###### IamOrgMemberProtocol

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | --------- | ------------ |
| id | String | No | IAM アカウント UUID | 
| userCode | String | Yes | ログイン時に使用する IAM アカウント ID | 
| name | String | Yes | IAM アカウントのユーザー名 | 
| emailAddress | String |  Yes | IAM アカウントのメールアドレス<br>お知らせの受信またはパスワード変更案内メール受信時に使用されます |
| maskingEmail | String | No | IAM アカウントのマスクされたメールアドレス |
| mobilePhone | String | No | IAM アカウントの携帯電話番号 |
| telephone | String | No | IAM アカウントの電話番号 |
| position | String | No | 役職 |
| department | String | No | 部署名 |
| corporate | String | No | 会社名  |
| profileImageUrl | String | No | プロフィール画像 URL |
| englishName | String | No | 英語名 |
| nativeName | String | No | 母国語名 |
| nickname | String | No | ユーザーの別名 |
| officeHoursBegin | String | No | 業務開始時間 例: 09:00 |
| officeHoursEnd | String | No | 業務終了時間 例: 18:00 |
| status | String | Yes | アカウント状態を変更できます<br><ul><li>member: 正常利用状態</li><li>leaved: 退会リクエスト</li></ul>作成時は必ず member を指定する必要があります |
| creationType | String | No | 作成日時 |
| idProviderId | String | No | 外部認証を使用する場合、認証機関 ID |
| idProviderType | String | No | service: IAM アカウント直接ログイン（デフォルト値）<br>sso: 顧客 SSO 連携（連携されていない場合は設定不可） |
| idProviderUserId | String | No | 外部認証機関が提供したユーザー ID |
| createdAt | Date | No | 作成日時 |
| lastAccessedAt | Date | No | 最終アクセス日時 |
| lastLoggedInAt | Date | No | 最終ログイン日時 |
| lastLoggedInIp | String | No | 最終ログイン IP |
| passwordChangedAt | Date | No | パスワード変更日時 |
| mobilePhoneCountryCode | String | No | 携帯電話番号の国コード 2 桁英字 |
| organizationId | String | No | IAM アカウントの組織 ID |
| country | String | No | 国籍（組織 Owner の国籍） |


<a id="add-organization-iam-account"></a>

#### 組織IAMアカウント追加

> POST "/v1/iam/organizations/{org-id}/members"

組織にIAMアカウントを追加するAPIです。

##### 必要権限
`Organization.Member.Iam.Create`


##### リクエストパラメータ

| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 組織ID | 
| Request Body | request | AddIamOrgMemberRequest| Yes | リクエスト |

###### AddIamOrgMemberRequest


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ----------- | ------------ |
|   member | [AddIamOrgMemberProtocol](#addiamorgmemberprotocol)| Yes   |


###### AddIamOrgMemberProtocol

| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | --------- | ------------ |
| userCode | String | Yes | ログイン時に使用するIAMアカウントID | 
| name | String | Yes | IAMアカウントのユーザー名 | 
| emailAddress | String |  Yes | IAMアカウントのメールアドレス<br>お知らせの受信やパスワード変更案内メールの受信時に使用されます |
| mobilePhone | String | No | IAMアカウントの携帯電話番号 |
| telephone | String | No | IAMアカウントの電話番号 |
| position | String | No | 役職 |
| department | String | No | 部署名 |
| corporate | String | No | 会社名 |
| profileImageUrl | String | No | プロフィール画像URL |
| englishName | String | No | 英語名 |
| nativeName | String | No | 母国語名 |
| nickname | String | No | ユーザーの別名 |
| officeHoursBegin | String | No | 業務開始時間 例: 09:00 |
| officeHoursEnd | String | No | 業務終了時間 例: 18:00 |
| status | String | Yes | アカウント状態を変更できます<br><ul><li>member: 正常利用状態</li><li>leaved: 退会リクエスト</li></ul>作成時は必ず member を指定する必要があります |
| creationType | String | No | 連携(sso)、招待(invited)、登録(registred) |
| mobilePhoneCountryCode | String | No | 携帯電話番号の国コード（2桁英字）。携帯電話番号を入力する場合は必須 |



##### レスポンス本文

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


###### レスポンス

| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#response)| Yes   |
|   uuid | String| No | IAMアカウントUUID  |




<a id="send-iam-account-password-change-email"></a>

#### IAM アカウントのパスワード変更メール送信

> POST "/v1/iam/organizations/{org-id}/members/{member-id}/send-password-setup-mail"

IAM アカウントのパスワードを変更できるメールを送信する API です。

##### 必要な権限
`Organization.Member.Iam.Update`


##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 対象となる組織 ID | 
|  Path |member-id | String| Yes | パスワードを変更する IAM アカウントの UUID | 
| Request Body | request | SendPasswordSetupMailRequest| Yes | リクエスト |



###### SendPasswordSetupMailRequest


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | --------- | ------------ |
|   locale | String| Yes | ユーザーのロケール情報<br>例: ko |
|   returnUrl | String| Yes | メール変更通知メールを通じてパスワードを変更した後に移動するページのアドレス情報<br>移動先のアドレス情報には、必ず toast.com、dooray.com または nhncloud.com ドメインを入力する必要があります |


##### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#response)| Yes   |

<a id="modify-organization-iam-account"></a>

#### 組織 IAM アカウント情報の修正

> PUT "/v1/iam/organizations/{org-id}/members/{member-uuid}"

組織の IAM アカウント情報を修正する API です。

##### 必要権限
`Organization.Member.Iam.Update`

##### リクエストパラメータ

| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 対象となる組織 ID | 
|  Path |member-uuid | String| Yes | 修正する IAM アカウントの UUID | 
| Request Body | request | UpdateIamMemberRequest| Yes | リクエスト |


###### UpdateIamMemberRequest


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ----------- | ------------ |
|   member | [UpdateIamOrgMemberProtocol](#updateiamorgmemberprotocol)| Yes   |


###### UpdateIamOrgMemberProtocol

| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | --------- | ------------ |
| userCode | String | Yes | ログイン時に使用する IAM アカウント ID | 
| name | String | Yes | IAM アカウントのユーザー名 | 
| emailAddress | String |  Yes | IAM アカウントのメールアドレス<br>お知らせの受信やパスワード変更案内メールの受信時に使用されます |
| mobilePhone | String | No | IAM アカウントの携帯電話番号 |
| telephone | String | No | IAM アカウントの電話番号 |
| position | String | No | 役職 |
| department | String | No | 部署名 |
| corporate | String | No | 会社名 |
| profileImageUrl | String | No | プロフィール画像 URL |
| englishName | String | No | 英語名 |
| nativeName | String | No | 母国語名 |
| nickname | String | No | ユーザーの別名 |
| officeHoursBegin | String | No | 業務開始時間 例: 09:00 |
| officeHoursEnd | String | No | 業務終了時間 例: 18:00 |
| status | String | Yes | アカウント状態を変更できます<br><ul><li>member: 正常利用状態</li><li>leaved: 退会リクエスト</li></ul>作成時は必ず member を指定する必要があります |
| creationType | String | No | 連携 (sso)、招待 (invited)、登録 (registred) |
| idProviderUserId | String | No | 外部認証機関が提供したユーザー ID |
| mobilePhoneCountryCode | String | No | 携帯電話番号の国コード（2桁の英字）。携帯電話番号を入力する場合は必須 |


##### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### レスポンス

| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#응답)| Yes   |

<a id="change-organization-iam-account-password"></a>

#### 組織IAMアカウントのパスワード変更

> POST "/v1/iam/organizations/{org-id}/members/{member-id}/set-password"

組織IAMアカウントのパスワードを変更するAPIです。

##### 必要権限
`Organization.Member.Iam.Update`

##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 対象となる組織ID | 
|  Path |member-id | String| Yes | パスワードを変更するIAMアカウントのUUID | 
| Request Body | request | UpdateIamPasswordRequest| Yes | リクエスト |


###### UpdateIamPasswordRequest


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | --------- | ------------ |
|   password | String| Yes  | 設定するパスワード | 


##### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#응답)| Yes   |

<a id="list-organization-ip-acls"></a>

#### 組織 IP ACL 一覧照会

> GET "/v1/organizations/{org-id}/products/ip-acl"

IP ACL 設定を照会する API です。

##### 必要権限
`Organization.Governance.IpAcl.List`

##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 組織 ID | 


##### レスポンス本文

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


###### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#response)| Yes   |
|   orgIpAcl | List&lt;OrgIpAclProtocol>| Yes  | 設定結果。空のリストの場合は未設定の状態 |

###### OrgIpAclProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | --------- | ------------ |
|   ips | List&lt;String>| Yes  | 許可 IP 一覧 | 
|   productId | String| Yes  | サービス ID<br>undefined の場合は共通設定 |

<a id="view-organization-iam-account-sign-in-session-settings-information"></a>

#### 組織 IAM アカウントのログインセッション設定情報を照会

> GET "/v1/iam/organizations/{org-id}/settings/session"

ログインセッション設定情報を照会する API です。

##### 必要な権限
`Organization.Setting.Iam.Get`

##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 組織 ID | 


##### レスポンス本文

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


##### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
| header | [共通レスポンス](#response)| Yes   |
| result | Content | Yes | 設定内容 |

###### Content

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   multiSessionsLimit | Integer| Yes | 許可するマルチセッション数  |
|   sessionTimeoutMinutes | Integer| Yes | セッションタイムアウト |
|   mobileSessionTimeoutMinutes | Integer| Yes | モバイルセッションタイムアウト |
|   sessionType | String| Yes | fixed/idle。デフォルト値は fixed  |

<a id="view-settings-for-organizational-iam-account-login-two-factor-authentication"></a>

#### 組織IAMアカウントログイン2次認証に関する設定を照会

> GET "/v1/iam/organizations/{org-id}/settings/security-mfa"

ログイン2次認証に関する設定を照会するAPIです。

##### 必要権限
`Organization.Setting.Iam.Get`

##### リクエストパラメータ


| 区分 | 名前 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 組織ID | 

##### レスポンス本文

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


##### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   header | [共通レスポンス](#response)| Yes   |
|   result | Result| No |  レスポンス内容<br>設定したことがない場合はnullが返されます |

###### Result
| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   range | Integer| No | 組織/サービスの区分<br>organization（共通設定）、services（サービス別設定）  |
|   organizationMfaSetting | OrganizationMfaSetting| No | 組織のMFA設定情報<br>共通設定 |
|   serviceMfaSettings | ServiceMfaSettings| No | サービス別MFA設定情報  |


###### OrganizationMfaSetting

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   type | String| No | MFAタイプ<br>none（設定なし）、totp（Google OTP）、email（メール） |
|   bypassByIp | BypassByIp| No | 例外IP  |

###### ServiceMfaSettings


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   serviceId | Sting| No | サービスID  |
|   type | String| No | MFAタイプ<br>none（設定なし）、totp（Google OTP）、email（メール） |
|   bypassByIp | BypassByIp| No | サービスタイプ。none、totp、email |

###### BypassByIp

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   enable | Boolean| No | 有効化状態<br>true（使用中）、false（未使用）  |
|   ipList | List&lt;String>| No | 例外IPリスト |

<a id="view-organization-iam-account-login-failure-security-settings"></a>

#### 組織 IAM アカウントのログイン失敗セキュリティ設定を照会

> GET "/v1/iam/organizations/{org-id}/settings/security-login-fail"

ログイン失敗セキュリティ設定を照会する API です。

##### 必要権限
`Organization.Setting.Iam.Get`

##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 組織 ID | 


##### レスポンス本文

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


##### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
| header | [共通レスポンス](#応답)| Yes   |
| result | Result | No | ログイン失敗セキュリティを設定した場合にのみ返され、設定していない場合は null が返されます |

###### Result

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   enable | Boolean| Yes | 有効化状態<br>true（使用中）、false（未使用）  |
|   loginFailCount | LoginFailCount| No | ログイン失敗セキュリティ設定 |


###### LoginFailCount

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   limit | Integer| No | 試行許容回数 |
|   blockMinutes | Integer| No | ログイン禁止時間  |

<a id="get-organization-iam-account-password-policy"></a>

#### 組織 IAM アカウントパスワードポリシーの照会

> GET "/v1/iam/organizations/{org-id}/settings/password-rule"

パスワードポリシーの設定を照会する API です。

##### 必要な権限
`Organization.Setting.Iam.Get`

##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 組織 ID | 


##### レスポンス本文

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

##### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
| header | [共通レスポンス](#응답)| Yes   |
| result | Content | Yes | 設定内容 |

###### Content

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
| schemaVersion | Integer| Yes | スキーマバージョン  |
| value | Value| Yes | パスワードポリシー |

###### Value

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
| ruleType | String | Yes | パスワードポリシー<br>default（デフォルトパスワードポリシー）、custom（ユーザーパスワードポリシー） |
| passwordConstraints | PasswordConstraints | Yes | パスワード強度 |
| passwordExpiry | PasswordExpiry | Yes | パスワード有効期限 |
| limitPasswordReuse | LimitPasswordReuse | Yes | パスワード再利用制限 |
| applyRule | String | Yes | パスワードポリシーの適用タイミング<br>onChangePassword（パスワード変更時に適用）、onLogin（即時適用） |

###### PasswordConstraints

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
| minLength | integer | Yes | パスワードの最小長 |
| mustNotIncludeIllegalSequence | boolean | Yes | 英字 1 文字以上<br>true（設定）、false（設定しない） |
| mustIncludeUpperCase | boolean | Yes | 英大文字 1 文字以上<br>true（設定）、false（設定しない） |
| mustIncludeLowerCase | boolean | Yes | 英小文字 1 文字以上<br>true（設定）、false（設定しない） |
| mustIncludeNumberCase | boolean | Yes | 数字 1 文字以上<br>true（設定）、false（設定しない） |
| mustIncludeSpecialCase | boolean | Yes | 特殊文字 1 文字以上<br>true（設定）、false（設定しない） |

###### PasswordExpiry

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
| enable | Boolean | Yes | 使用有無<br>true（設定）、false（設定しない） |
| expiryDays | Integer | Yes | 有効期限（日数） |
| allowExpend | Boolean | Yes | 有効期限切れ時の延長可否<br>true（可能）、false（不可） |

###### LimitPasswordReuse

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
| enable | Boolean | Yes | 使用有無<br>true（設定）、false（設定しない） |
| limitCount | Integer | Yes | 再利用制限回数 |

<a id="get-service-prices-registered-in-pay-as-you-go"></a>

#### 従量制に登録されたサービス価格照会

> POST "/v1/billing/contracts/basic/products/prices/search"

カウンターに設定された単価を照会する API です。
各言語ごとに表示名、金額計算のための種類を確認できます。


##### 必要権限
メンバーであれば特定の権限なしに呼び出し可能な API です。

##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Query |limit | Integer| No |  |
| Request Body | request | GetContractProductPriceRequest| Yes | リクエスト |

##### GetContractProductPriceRequest
| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | --------- | ------------ |
|  counterNames | List&lt;String>| No | サービスメタの counter Name リスト<br>ない場合は全件検索します |
|   paging | Paging| No  |

###### Paging

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   limit | Integer| No | ページあたりの表示件数、デフォルト値 20  |
|   page | Integer| No | 対象ページ、デフォルト値 1  |


##### レスポンス本文

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

###### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#response)| Yes   |
|   paging | PagingResponse| Yes | ソート基準なしのページング結果を返します  |
|   prices | List&lt;ContractProductPriceProtocol>| Yes | カウンターの単価情報を配列で返します<br>エラー時は含まれません  |

###### PagingResponse

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------- | ------------ |
|   limit | Integer| Yes | 照会件数の制限<br>デフォルト値は 20 |
|   page | Integer| Yes |
|   totalCount | Integer| Yes |

###### ContractProductPriceProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   contractDiscountPolicyId | String| Yes | 約定料金ポリシー ID  |
|   contractId | String| Yes | 約定 ID  |
|   counterName | String| Yes | カウンター  |
|   displayNameEn | String| No | カウンターの英語名  |
|   displayNameJa | String| No | カウンターの日本語名  |
|   displayNameKo | String| Yes | カウンターの韓国語名  |
|   displayNameZh | String| No | カウンターの中国語名<br>現在は英語で表示されます |
|   monthFrom | String| Yes | 単価情報が有効な開始月（含む）  |
|   monthTo | String| Yes | 単価情報が有効な終了月（含まない）  |
|   originalPrice | BigDecimal| Yes | 単価  |
|   price | BigDecimal| Yes | 単価  |
|   rangeFrom | BigDecimal| Yes | 単価に該当する使用量範囲の開始（含まない）  |
|   rangeTo | BigDecimal| Yes | 単価に該当する使用量範囲の終了（含む）  |
|   seq | Long| Yes | シリアル番号  |
|   slidingCalculationTypeCode | String| Yes | スライディング料金計算タイプ<br>NONE、SECTION_SUM、SECTION_SELECTED |
|   useFixPriceYn | String| Yes | 固定金額の有無（Y: 固定金額、N: 単価計算）<br>Y: 範囲に入った場合、price が金額になります<br>N:（使用量 × 単価）が金額になります |

<a id="list-services-registered-for-pay-as-you-go"></a>

#### 従量制に登録されたサービス一覧照会

> GET "/v1/billing/contracts/basic/products"

請求書に表示されるメインカテゴリとサブカテゴリ、および含まれるカウンターの一覧を提供するAPIです。

##### 必要権限
メンバーであれば、特定の権限なしに呼び出し可能なAPIです。

##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Query |limit | Integer| No | 照会する件数の制限<br>デフォルト値は20 |
|  Query |page | Integer| No |  |


##### レスポンス本文

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


###### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#response)| Yes   |
|   paging | [PagingResponse](#pagingresponse)| Yes  |
|   products | List&lt;ProductMetadata>| Yes | サービスメタ情報一覧  |


###### ProductMetadata


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   budgetUsageTypeYn | String| No | 予算使用量タイプ Yn  Y, N |
|   calcUnitCode | String| Yes | 金額計算時に使用する単位（メータリング単位を精算単位に変換して金額計算を実行する）、明細書に表示する単位<br>KB, MB, GB, TB, SECONDS, MINUTE, HOURS, DAYS, MB_HOURS, GB_SECONDS, GB_HOURS, GB_DAYS, CORE_SECONDS, CORE_HOURS, CORE_DAYS, USERS, MAU, MAD, DAU, CALLS, COUNTS, CCU, VCPU_HOURS, COUNT_HOURS |
|   categoryMain | String| Yes | メインカテゴリ  |
|   categorySub | String| Yes | サブカテゴリ  |
|   chargingTypeId | String| Yes | 課金タイプID  |
|   convertUsageTypeCode | String| Yes | 使用量変換タイプコード  NONE, HOUR_AVERAGE, DAY_AVERAGE |
|   counterName | String| Yes | カウンター  |
|   counterTypeCode | String| Yes | 使用量の集計方法<br><ul><li>DELTA: 増加値（HOURLY_SUM）</li><li>GAUGE: 時間最大値の合計（HOURLY_MAXに変更予定）</li><li>HOURLY_LATEST: 1時間の間に収集されたデータのうち、最後に収集されたメータリングデータの合計</li><li>DAILY_MAX: 日最大値の合計</li><li>MONTHLY_MAX: 月最大値</li><li>STATUS: 使用状況</li><ul> |
|   description | String| No | カウターの説明  |
|   displayOrder | Integer| Yes | 表示順序  |
|   marketPlaceMandatoryUsePeriod | Integer| No | マーケットプレイス必須使用期間  |
|   meterUnitCode | String| Yes | サービスのメータリング保存時の使用量単位<br>BYTES, KB, MB, GB, TB, CORE, HOURS, MINUTE, USERS, MAU, MAD, DAU, CALLS, COUNTS, CCU, SECONDS |
|   minUsage | BigDecimal| Yes | 最小使用量  |
|   parentCounterName | String| Yes | 親カウター名  |
|   productId | String| Yes | サービスID  |
|   productMetadataStatusCode | String| Yes | カウンターステータスコード  STABLE, CLOSED |
|   productUiId | String| Yes | Webサイトカテゴリ/Webサイトサービス識別ID  |
|   regionTypeCode | String| Yes | カウンター名が所属するリージョンコード<br><ul><li>GLOBAL: Globalサービスに属するカウンター名</li><li>NONE: GLOBALと同じ意味</li><li>KR1: KR1リージョンに属するカウンター名</li><li>KR2: KR2リージョンに属するカウンター名</li><li>...: 該当リージョンに属するカウンター名</li><ul>  |
|   unit | Long| Yes | 精算単位  |
|   unitName | String| Yes | 請求書に表示する名前  |
|   usageAggregationUnitCode | String| No | 使用量集計単位<br>RESOURCE_ID, COUNTER_NAME |


<a id="list-project-integrated-appkeys"></a>

#### プロジェクト統合 Appkey 照会

> GET "/v1/authentications/projects/{project-id}/project-appkeys"

プロジェクトで使用中のプロジェクト統合 Appkey 一覧を照会する API です。

##### 必要権限
`Project.ProjectAppKey.List`

##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | 照会対象プロジェクト ID | 


##### レスポンス本文

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

###### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | --------- | ------------ |
|   header | [共通レスポンス](#response)| Yes |
|   authenticationList | List&lt;ProjectAppKeyResponse>| No | プロジェクト統合 Appkey 一覧 |

###### ProjectAppKeyResponse

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   authId | String| No | 内部的に管理する認証手段 ID  |
|   appKey | String| No | コンソールに表示されるプロジェクト統合 Appkey  |
|   authStatus | String| No | 認証ステータスコード（STABLE、STOP、BLOCKED） |
|   projectId | String| No | プロジェクト ID |
|   lastUsedDatetime | Date| No | 最終使用日時  |
|   modDatetime | Date| No | 削除日時  |
|   reIssueDatetime | Date| No | 再生成日時  |
|   regDatetime | Date| No | 作成日時  |

<a id="list-user-access-key-ids"></a>

#### User Access Key ID 목록 조회

> GET "/v1/authentications/user-access-keys"

メンバーの User Access Key ID 一覧を照会する API です。

##### 필요 권한
会員であれば特定の権限なしに呼び出せる API です。


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
    "tokenFormatCode" : "OPAQUE",
    "lastUsedDatetime": "2000-01-23T04:56:07.000+00:00",
    "reIssueDatetime": "2000-01-23T04:56:07.000+00:00",
    "regDatetime": "2000-01-23T04:56:07.000+00:00",
    "lastTokenUsedDatetime": "2025-02-11T01:30:56.771Z",
    "validTokenCount": 0
  } ]
}
```


###### 응답


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [공통 응답](#응답)| Yes   |
|   authentications | List&lt;UserAccessKeyResponse>| No | 認証情報一覧  |

###### UserAccessKeyResponse

| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------------- | ------------ |
|   authId | String| No | 内部で管理する認証手段 ID  |
|   userAccessKeyID | String| No | User Access Key ID  |
|   secretAccessKey | String| No | シークレットキー（マスク処理済み）  |
|   authStatus | String| No | 認証ステータスコード（STABLE、STOP、BLOCKED） |
|   uuid | String| No | ユーザー UUID |
|   lastUsedDatetime | Date| No | User Access Key ID で認証した最終日時 |
|   modDatetime | Date| No | 削除日時  |
|   reIssueDatetime | Date| No | 再生成日時  |
|   regDatetime | Date| No | 作成日時  |
|   tokenExpiryPeriod | Long| No | トークン有効期限（秒単位）  |
|   tokenFormatCode | String | No | トークンフォーマットコード（OPAQUE、JWT）  |
|   lastTokenUsedDatetime | Long| No | トークンで認証/認可した最終日時              |
|   validTokenCount | Long| No | 有効なトークン数                       |


<a id="register-a-project-integrated-appkey"></a>

#### プロジェクト統合Appkeyの登録

> POST "/v1/authentications/projects/{project-id}/project-appkeys"

プロジェクトで使用する AppKey を作成する API です。

##### 必要な権限
`Project.ProjectAppKey.Create`


##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
| Path | project-id | String| Yes | AppKey を登録するプロジェクト ID |
| Request Body | request | AddProjectAppKeyRequest| Yes | リクエスト |

###### AddProjectAppKeyRequest

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   appkeyAlias | String | Yes   | プロジェクト統合 Appkey の別名<br>100 文字以内 |


##### レスポンス本文

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

###### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#response)| Yes   |
|   authentication | ResponseProtocol| No  |

###### ResponseProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----- | ------------ |
|   authId | String| No | 内部的に管理する認証手段の ID  |
|   appKey | String| No | プロジェクト統合 Appkey |

<a id="register-user-access-key-id"></a>

#### User Access Key ID 登録

> POST "/v1/authentications/user-access-keys"

メンバーの User Access Key ID を登録する API です。

##### 必要権限
会員であれば特定の権限なしに呼び出し可能な API です。

##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
| Request Body | PostUserAppKeyRequest | PostUserAppKeyRequest| Yes |  | |


###### PostUserAppKeyRequest

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   tokenFormatCode | String | No | トークンフォーマットコード<br>OPAQUE と JWT フォーマットを提供しており、現在 JWT フォーマットトークンは EasyQueue サービスでのみ使用可能<br>デフォルト値は OPAQUE |
|   tokenExpiryPeriod | Long| No | トークン有効期間<br>秒単位であり、OPAQUE フォーマットトークンの場合のデフォルト値は 1 日、JWT トークンは 1 時間<br>OPAQUE フォーマットトークンは最小 1 分、最大 1 日まで有効なトークンを作成可能で、JWT フォーマットトークンは最小 1 分、最大 1 時間まで有効なトークンを作成可能 |


##### レスポンス本文

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

###### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#response)| Yes   |
|   authentication | ResponseProtocol| No  |

###### ResponseProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----- | ------------ |
|   authId | String| No | 内部的に管理する認証手段 ID  |
|   userAccessKeyID | String| No | User Access Key ID  |
|   secretAccessKey | String| No | シークレットキー |
|   tokenExpiryPeriod | Long| No | トークン有効期間（秒単位）
|   tokenFormatCode | String | No | トークンフォーマットコード（OPAQUE、JWT） |

<a id="delete-project-integrated-appkey"></a>

#### プロジェクト統合Appkeyの削除

> DELETE "/v1/authentications/projects/{project-id}/project-appkeys/{app-key}"

プロジェクトAppKeyを削除するAPIです。

##### 必要権限
`Project.ProjectAppKey.Delete`


##### リクエストパラメータ


| 区分 | 名前 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
| Path | project-id | String| Yes | 対象プロジェクトID |
|  Path |app-key | String| Yes | 削除するプロジェクト統合Appkey | 


##### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```
###### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#response)| Yes   |


<a id="reissue-the-user-access-key-id-secret-key"></a>

#### User Access Key ID 비밀 키 재発行

> PUT "/v1/authentications/user-access-keys/{user-access-key-id}/secretkey-reissue"

User Access Key ID のシークレットキーを再発行する API です。


##### 必要な権限
自分の User Access Key ID のシークレットキーのみ再発行可能

##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 |
|------------- |------------- | ------------- | ------------- | ------------- |
| Path | user-access-key-id | String | Yes | User Access Key ID |
| Request Body | request | ReissueSecretKeyRequest | Yes | リクエスト |


###### ReissueSecretKeyRequest

| 名前 | タイプ | 必須 | 説明 |
|------------ |---------|----|-------------------------------------------------|
| needExpireTokens | Boolean | No | 発行済みトークンの有効期限切れにするかどうか（true: 有効期限切れにする、false: 有効期限切れにしない）<br>デフォルト値: false |

##### レスポンス本文

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

###### レスポンス


| 名前 | タイプ | 必須 | 説明 |
|------------ | ------------- | --------- | ------------ |
| header | [共通レスポンス](#response) | Yes | |
| authentication | ResponseProtocol | No | |

###### ResponseProtocol


| 名前 | タイプ | 必須 | 説明 |
|------------ | ------------- | ----------- | ------------ |
| secretAccessKey | String | Yes | シークレットキー |

<a id="modify-user-access-key-id-status"></a>

#### User Access Key ID 状態の修正

> PUT "/v1/authentications/user-access-keys/{user-access-key-id}"

メンバーの User Access Key ID の状態を変更する API です。<br>
OPAQUE トークン用の User Access Key ID を停止すると OPAQUE トークンも同時に有効期限切れになります。JWT トークン用の User Access Key ID は停止しても JWT トークンは有効期限切れになりません。

##### 必要な権限
自分の User Access Key ID のみ修正可能

##### リクエストパラメータ


| 区分 | 名前 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path | user-access-key-id | String| Yes | User Access Key ID | 
| Request Body | request | UpdateUserAccessKeyStatusRequest| Yes | リクエスト |


###### UpdateUserAccessKeyStatusRequest

| 名前 | タイプ | 必須 | 説明 |   
|----------- | ------------- | ------------- | ------------ |
| status | String| Yes | 変更するステータス（STOP: 停止、STABLE: 使用中） |


##### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#response)| Yes   |

<a id="delete-a-user-access-key-id"></a>

#### User Access Key ID 削除

> DELETE "/v1/authentications/user-access-keys/{user-access-key-id}"

User Access Key ID を削除する API です。

##### 必要権限
自分の User Access Key ID のみ削除可能

##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path | user-access-key-id | String| Yes | User Access Key ID | 


##### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### レスポンス


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------- | ------------ |
|   header | [共通レスポンス](#response)| Yes |


<a id="list-tokens"></a>

#### トークン一覧照会

> GET "/v1/authentications/user-access-keys/{user-access-key-id}/tokens"

User Access Key ID で発行した OPAQUE トークンの一覧を照会する API です。

##### 必要権限
自身の User Access Key ID で発行したトークンのみ照会可能

##### リクエストパラメータ

| 구분 | 이름 | タイプ | 必須  | 説明                                                                           | 
|------------- |------------- | ------------- |-----|------------------------------------------------------------------------------| 
|  Path | user-access-key-id | String| Yes | User Access Key ID                                                           | 
|  Query | token | String| No  | トークン全文<br>部分検索はサポートしていません                                                        | 
|  Query | status | String| No  | トークンステータス<br>ACTIVE: アクティブ、EXPIRED: 有効期限切れ                                             | 
|  Query | lastAccessDatetimeFrom | Date| No  | トークン最終使用日時<br>指定した日時以降に使用されたトークンを照会します<br>例: `2025-02-11T00:56:50.902Z` | 
|  Query | expireDatetimeFrom | Date| No  | トークン有効期限日時<br>指定した日時以降に有効期限が切れたトークンを照会します<br>例: `2025-02-11T00:56:50.902Z`   | 
|  Query | regDatetimeFrom | Date| No  | トークン登録日時<br>指定した日時以降に作成されたトークンを照会します<br>例: `2025-02-11T00:56:50.902Z`   |
|  Query | page | Integer| No  | 対象ページ<br>デフォルト値: 1                                                                |
|  Query | limit | Integer| No  | ページあたりの表示件数<br>デフォルト値: 20                                                            |



##### レスポンス本文

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

###### レスポンス


| 名前 | タイプ           | 必須  | 説明                 |   
|------------ |--------------|-----|--------------------|
|   header | [共通レスポンス](#レスポンス) | Yes |
|   paging | [PagingResponse](#pagingresponse)| Yes  |
|   accessToken | String       | Yes | マスキング処理されたトークン         |
|   expireDatetime | Date         | No  | トークン有効期限             |
|   lastAccessDatetime | Date         | Yes | トークンで認証/認可した最終日時 |
|   regDatetime | Date         | Yes | トークン作成日時           |
|   status | String       | Yes | トークンステータス              |
|   tokenId | Long         | Yes | トークン ID              |


<a id="expire-multiple-tokens"></a>

#### トークン複数件の有効期限切れ

> DELETE "/v1/authentications/user-access-keys/{user-access-key-id}/tokens"

User Access Key ID で発行した OPAQUE トークンを複数件まとめて有効期限切れにする API です。<br>
JWT トークンを発行した User Access Key ID でリクエストしても、JWT トークンは有効期限切れになりません。<br>
リクエストでトークン ID とトークン目録がいずれも空の場合、該当 User Access Key ID で発行されたすべてのトークンが有効期限切れになります。<br>
トークン ID とトークン目録の両方がある場合は、両方が一致するトークンのみ削除されます。リクエストに含まれる User Access Key ID の所有者以外のユーザーが呼び出した場合、トークンは有効期限切れになりません。

##### 必要な権限
自分の User Access Key ID で発行したトークンのみ有効期限切れにできます。

##### リクエストパラメータ

| 구분           | 이름                 | タイプ             | 必須  | 説明                 | 
|--------------|--------------------|-----------------|-----|--------------------| 
| Path         | user-access-key-id | String          | Yes | User Access Key ID | 
| Request Body | tokenIds           | List&lt;Long>   | No  | トークン ID リスト        | 
| Request Body         | tokens             | List&lt;String> | No   | トークンリスト          | 


##### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### レスポンス


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------- | ------------ |
|   header | [共通レスポンス](#response)| Yes |


<a id="create-project-iam-account"></a>

#### プロジェクト IAM アカウント作成

> POST "/v1/iam/projects/{project-id}/members"

IAM アカウントをプロジェクトメンバーとして追加する API です。

##### 必要権限
`Project.Member.Iam.Create`

##### リクエストパラメータ



| 구분 | 이름 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | メンバーを追加するプロジェクト ID | 
| Request Body | request | AddIamProjectMemberRequest| Yes | リクエスト |




###### AddIamProjectMemberRequest


!!! danger "警告"
    1 回のリクエストで作成できるプロジェクトメンバーは 1 名のみです。


| 이름 | タイプ | 必須 | 説明 |  
|------------ | ------------- | ------------- | ------------ |
|   assignRoles | List&lt;UserAssignRoleProtocol>| Yes | ユーザーに割り当てるロールのリスト  |
|   memberUuid | String| Yes | 追加するメンバーの UUID  |


###### UserAssignRoleProtocol


| 이름 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   roleId | String| Yes | ロール ID  |
|   conditions | List&lt;AssignAttributeConditionProtocol>| No | ロールの条件属性  |


###### AssignAttributeConditionProtocol


| 이름 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   attributeId | String| Yes | 条件属性 ID  |
|   attributeOperatorTypeCode | String| Yes | 条件属性の演算子<br>条件属性のデータ型によって使用できる演算子が異なります<br><ul><li>ALLOW</li><li>ALL_CONTAINS</li><li>ANY_CONTAINS</li><li>ANY_MATCH</li><li>BETWEEN</li><li>BEYOND</li><li>FALSE</li><li>GREATER_THAN</li><li>GREATER_THAN_OR_EQUAL_TO</li><li>LESS_THAN</li><li>LESS_THAN_OR_EQUAL_TO</li><li>NONE_MATCH</li><li>NOT_ALLOW</li><li>NOT_CONTAINS</li><li>TRUE</li></ul>  |
|   attributeValues | List&lt;String>| Yes | 条件属性の値  |


##### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### レスポンス


| 이름 | タイプ           | 必須 | 説明 |   
|------------ |--------------| ------- | ------------ |
|   header | [共通レスポンス](#response) | Yes |


<a id="delete-multiple-project-iam-accounts"></a>

#### プロジェクト IAM アカウントの複数削除

> DELETE "/v1/iam/projects/{project-id}/members"

IAM アカウントを該当プロジェクトから削除する API です。

##### 必要権限
`Project.Member.Iam.Delete`

##### 요청 파라미터



| 구분 | 이름 | 타입 | 필수 | 설명  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | プロジェクト ID | 
|  Request Body |request | DeleteMembersRequest | Yes | リクエスト | 


###### DeleteMembersRequest


| 이름 | 타입 | 필수 | 설명 |  
|------------ | ------------- | ------------- | ------------ |
|   memberUuids | List&lt;String>| Yes | 削除対象アカウントの UUID リスト |


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

###### レスポンス


| 이름 | 타입 | 필수 | 설명 |   
|------------ | ------------- | ------- | ------------ |
|   header | [共通レスポンス](#응답)| Yes |


<a id="get-project-iam-account"></a>

#### プロジェクト IAM アカウント単件照会

> GET "/v1/iam/projects/{project-id}/members/{member-uuid}"

プロジェクトに所属する特定の IAM メンバーを照会する API です。

##### 必要権限
`Project.Member.Iam.Get`

##### リクエストパラメータ



| 区分 | 名前 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | メンバーを照会するプロジェクト ID |
|  Path |member-uuid | String| Yes | 照会するメンバー UUID |




##### レスポンス本文

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


###### レスポンス


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------- | ------------ |
|   header | [共通レスポンス](#response)| Yes |
|   projectMember | ProjectIamMemberRoleBundleProtocol| Yes  | 追加されたメンバー情報。エラー時は含まれません |


###### ProjectMemberRoleBundleProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   uuid | String| Yes | メンバー UUID  |
|   id | String| Yes | ID  |
|   name | String| No | 名前  |
|   emailAddress | String| No | メンバーのメールアドレス  |
|   maskingEmail | String| No | メンバーのマスキングされたメール  |
|   mobilePhone | String| No | 電話番号  |
|   relationDateTime | Date| No | メンバー追加日時  |
|   joinYmdt | Date| No | 登録日時  |
|   recentLoginYmdt | Date| No | 最終ログイン日時  |
|   recentPasswordModifyYmdt | Date| No | 最終パスワード変更日時  |
|   roles | List&lt;RoleBundleProtocol>| No | 関連ロール一覧（条件属性を含む）  |


[RoleBundleProtocol](#rolebundleprotocol)



<a id="list-project-iam-accounts"></a>

#### プロジェクト IAM アカウント一覧照会

> GET "/v1/iam/projects/{project-id}/members"

プロジェクトに所属する IAM メンバーの一覧を照会するための API です。

##### 必要権限
`Project.Member.Iam.List`

##### リクエストパラメータ


| 区分 | 名前 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | 照会するプロジェクト ID | 
|  Query |limit | Integer| No | ページあたりの表示件数、デフォルト値 20 |
|  Query |page | Integer| No | 対象ページ、デフォルト値 1 |


##### レスポンス本文

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

###### レスポンス


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------- | ------------ |
|   header | [共通レスポンス](#応답)| Yes |
|   paging | [PagingResponse](#pagingresponse)| Yes  |
|   projectMembers | List&lt;IamProjectMemberProtocol>| Yes | プロジェクトメンバー一覧  |



###### IamProjectMemberProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   uuid | String| Yes | メンバー UUID  |
|   id | String| Yes | ID  |
|   name | String| No | 名前  |
|   emailAddress | String| No | メンバーのメールアドレス  |
|   maskingEmail | String| No | メンバーのマスキングされたメール  |
|   mobilePhone | String| No | 電話番号  |
|   relationDateTime | Date| No | メンバー追加日時  |
|   joinYmdt | Date| No | 登録日時  |
|   recentLoginYmdt | Date| No | 最近のログイン日時  |
|   recentPasswordModifyYmdt | Date| No | 最近のパスワード変更日時  |


<a id="modify-project-iam-account-role"></a>

#### プロジェクト IAM アカウントロールの変更

> PUT "/v1/iam/projects/{project-id}/members/{member-uuid}"

プロジェクトで指定した IAM メンバーのロールを変更する API です。

##### 必要権限
`Project.Member.Iam.Update`

##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | プロジェクト ID | 
|  Path |member-uuid | String| Yes | ロール変更対象メンバーの UUID | 
| Request Body | request | [UpdateMemberRoleRequest](#updatememberrolerequest)| Yes | リクエスト |




##### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#response)| Yes   |


<a id="view-all-credentials-of-members-under-organizations"></a>

#### 組織配下メンバーの認証情報一覧照会

> GET "/v1/authentications/organizations/{org-id}/user-access-keys"

組織に所属するメンバーおよびプロジェクトメンバーの認証情報を照会する API です。

##### 必要な権限
`Organization.UserAccessKey.List`

##### リクエストパラメータ



| 区分 | 名前 | タイプ | 必須 | 説明 |
|------------- |------------- | ------------- | ------------- | ------------- |
|  Path |org-id | String| Yes | UserAccessKey を照会する組織 ID |
|  Query |paging | Paging| No | ページあたりの表示件数、デフォルト値 20 |




##### レスポンス本文

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


###### レスポンス


| 名前 | タイプ | 必須 | 説明 |
|------------ | ------------- | ------- | ------------ |
|   header | [共通レスポンス](#response)| Yes |
|   paging | [PagingResponse](#pagingresponse)| Yes  |
|   authenticationList | List&lt;UserAccessKeyResponseV7>| Yes  | メンバーごとの認証キー情報 |


###### UserAccessKeyResponseV7

| 名前 | タイプ | 必須 | 説明 |
|------------|--------|------|-----------------------------|
| authId | String | Yes | 認証手段 ID（マスキング処理） |
| uuid | String | Yes | ユーザー UUID |
| userAccessKeyID | String | Yes | User Access Key ID（マスキング処理） |
| secretAccessKey | String | No | シークレットキー（空白処理） |
| authStatusCode | String | Yes | 認証ステータスコード（STABLE、STOP、BLOCKED） |
| tokenExpiryPeriod | Long | No | トークン有効期限の周期 |
| regDatetime | Date | No | 作成日時 |
| modDatetime | Date | No | 削除日時 |
| lastUsedDatetime | Date | No | 最終使用日時 |
| reIssueDatetime | Date | No | secretAccessKey 再生成日時 |
| lastTokenUsedDatetime | Date | No | トークン最終使用日時 |
| validTokenCount | Long | No | 有効なトークン数 |

<a id="list-my-organizations"></a>

#### 自分の組織一覧の照会

> GET /v1/organizations

##### 必要な権限
メンバーであれば、特定の権限なしに呼び出せる API です。

**[Query Parameter]**

| 名前 | タイプ | 必須 | 説明 |
|---|---|---|---|
| orgName | String | No | 組織名 |
| orgNameMatchTypeCode | String | No | 組織名の検索タイプ（EXACT: 完全一致、LIKE: 部分一致、デフォルト値: LIKE） |
| page | Integer | No | 対象ページ、デフォルト値 1 |
| limit | Integer | No | ページあたりの表示件数、デフォルト値 20 |

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

**[Response Body 説明]**

| 名前 | タイプ | 必須 | 説明 |
|---|---|---|---|
| header | [共通レスポンス](#response) | Yes | |
| orgList | List&lt;OrgMemberRelationProtocol> | Yes | 組織一覧情報 |
| paging | [PagingResponse](#pagingresponse) | Yes | ページング情報 |

###### OrgMemberRelationProtocol

| 名前 | タイプ | 必須 | 説明 |
|---|---|---|---|
| org | OrgProtocol | Yes | 組織情報 |
| orgMember | OrgMemberProtocol | Yes | 組織/プロジェクトメンバー情報 |
| orgOwner | OwnerProtocol | Yes | 組織 Owner 情報 |

###### OrgProtocol

| 名前 | タイプ | 必須 | 説明 |
|---|---|---|---|
| orgId | String | Yes | 組織 ID |
| orgName | String | Yes | 組織名 |
| orgStatusCode | String | Yes | 組織ステータスコード（STABLE、CLOSED） |
| ownerUuid | String | Yes | 組織 Owner UUID |
| regDateTime | Date | Yes | 組織作成日時 |
| remainingJobCode | String | Yes | 組織の後続作業（NONE、IAM_ORG_CREATE、IAM_ORG_UPDATE、IAM_ORG_DELETE） |
| ipAclTypeCode | String | Yes | 組織 IP ACL タイプコード（COMMON、INDIVIDUAL） |
| orgDomainList | List&lt;OrgDomainProtocol> | Yes | 組織ドメイン一覧 |

###### OrgMemberProtocol

| 名前 | タイプ | 必須 | 説明 |
|---|---|---|---|
| existOrgMember | Boolean | Yes | 組織メンバーの存在有無 |
| orgOwner | Boolean | Yes | 組織 Owner かどうか |

###### OwnerProtocol

| 名前 | タイプ | 必須 | 説明 |
|---|---|---|---|
| email | String | Yes | 組織 Owner のメールアドレス |
| name | String | Yes | 組織 Owner の名前 |
| restrictStatusCode | String | Yes | 組織 Owner の制約ステータス（HOLD、MEMBER_BLOCKED、RESOURCE_BLOCKED、RESOURCE_DELETED、STABLE、UNPAID） |
| country | String | Yes | 組織 Owner の国コード |
| restrictTypes | List&lt;String> | Yes | 組織 Owner の制約リスト |

###### OrgDomainProtocol

| 名前 | タイプ | 必須 | 説明 |
|---|---|---|---|
| domainId | String | Yes | 組織ドメイン ID |
| domainName | String | Yes | 組織ドメイン名 |


<a id="add-your-own-organization"></a>

#### 自身の組織を追加

> POST /v1/organizations

自身の組織を追加する API です。

##### 必要権限
メンバーであれば、特定の権限なしに呼び出せる API です。

##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
| Request Body | request | [CreateOrgRequest](#createorgrequest)| Yes | リクエスト |


###### CreateOrgRequest

| 名前 | タイプ | 必須 | 説明 |
|---|---|---|---|
| orgName | String | Yes | 作成する組織名（最大 70 文字） |


##### レスポンス本文

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

###### レスポンス


| 名前 | タイプ | 必須 | 説明 |
|---|---|---|---|
| header | [共通レスポンス](#response) | Yes | |
| orgId | String | Yes | 組織 ID |
| orgName | String | Yes | 組織名 |
| owner | [Owner](#owner) | Yes | 組織 Owner 情報 |

###### Owner

| 名前 | タイプ | 必須 | 説明 |
|---|---|---|---|
| email | String | Yes | 組織 Owner のメールアドレス |
| name | String | Yes | 組織 Owner の名前 |
| ownerId | String | Yes | 組織 Owner ID |
| restrictTypes | List&lt;String> | Yes | 制約対象リスト |


<a id="delete-organization"></a>

#### 組織の単件削除

> DELETE /v1/organizations/{org-id}

自分の組織を削除する API です。

##### 必要権限
`Organization.Delete`

##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 組織ID |


##### レスポンス本文

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "resultMessage"
  }
}
```

###### レスポンス

| 名前 | タイプ | 必須 | 説明 |
|---|---|---|---|
| header | [共通レスポンス](#response) | Yes | |


<a id="list-service-information"></a>

#### サービス情報一覧照会

> GET /v1/products

提供されているサービスの一覧を照会する API です。

##### 必要権限
メンバーであれば、特定の権限なしに呼び出せる API です。

##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 |
|---|---|---|---|---|
| Query | productId | String | No | サービス ID |
| Query | productCategoryCode | String | No | サービスカテゴリーコード（PROJECT、ORG、MARKET_PLACE） |
| Query | productName | String | No | サービス名 |
| Query | productNameLike | String | No | サービス名 Like 検索 |
| Query | limit | Integer | No | ページあたりの表示件数、デフォルト値 20 |
| Query | page | Integer | No | 対象ページ、デフォルト値 1 |


##### レスポンス本文

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

###### レスポンス


| 名前 | タイプ | 必須 | 説明 |
|---|---|---|---|
| header | [共通レスポンス](#response) | Yes | |
| paging | [PagingResponse](#pagingresponse) | Yes | |
| products | List&lt;Product> | Yes | サービス情報一覧 |

###### Product

| 名前 | タイプ | 必須 | 説明 |
|---|---|---|---|
| parentProductId | String | No | 親サービス ID |
| productCategoryCode | String | Yes | サービスカテゴリーコード（PROJECT、ORG、MARKET_PLACE） |
| productId | String | Yes | サービス ID |
| productName | String | Yes | サービス名 |


<a id="list-role-multilingual-descriptions"></a>

#### 役割説明の多言語照会

> GET /v1/messages/role

役割の多言語一覧を取得する API です。

##### 必要な権限
メンバーであれば、特定の権限なしに呼び出せる API です。

##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明  | 
|------------- |------------- | ------------- | ------------- | ------------- | 
| Query |messageType | String| No | メッセージタイプ<br><ul><li>MESSAGE</li><li>ERROR</li></ul> |
| Query |languages | List&lt;String>| No | 言語<br><ul><li>KO_KR</li><li>JA_JP</li><li>EN_US</li><li>ZH_CN</li></ul> |
| Query |keyword | String| No | 検索キーワード |
| Query |messageId | String| No | メッセージID |
| Query |limit | Integer| Yes | ページあたりの表示件数 | 
| Query |page | Integer| Yes | 対象ページ |


##### レスポンス本文

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

###### レスポンス


| 名前 | タイプ | 必須 | 説明 |
|---|---|---|---|
| header | [共通レスポンス](#response) | Yes | |
| messages | List&lt;MessageProtocol> | Yes | メッセージ一覧 |
| paging | [PagingResponse](#pagingresponse)| Yes | |

###### MessageProtocol

| 名前 | タイプ | 必須 | 説明 |
|---|---|---|---|
| i18nMessageSeq | Long | No | メッセージ順番 |
| categoryId | String | No | カテゴリーID |
| messageId | String | No | メッセージID |
| messageType | String | No | メッセージタイプ（MESSAGE、ERROR） |
| description | String | No | 説明 |
| koKr | String | No | 韓国語メッセージ |
| enUs | String | No | 英語メッセージ |
| jaJp | String | No | 日本語メッセージ |
| zhCn | String | No | 中国語メッセージ |


<a id="error-codes"></a>

### エラーコード

| 結果コード | 説明                                                                                  | 対応措置                                                      |
| ---------- |-------------------------------------------------------------------------------------|---------------------------------------------------------|
| 80007 | 有効期限切れまたは存在しないトークンを使用して呼び出した場合に発生するエラー                                          | 新しいトークンを発行して使用します                                         |
| -6 | 権限のない呼び出し元が呼び出した場合に発生するエラー                                                      | 呼び出し元に適切な権限を付与します                                        |
| -8 | 組織 IP ACL ポリシーによって IP 検証が失敗した場合に発生するエラー                                              | 組織 IP ACL に該当する IP が登録されているか確認します                            |
| 404 | 存在しない API を呼び出した場合に発生                                                                       | 呼び出す API の httpmethod、uri を確認します                            |
| 400<br>501<br>502<br>503<br>504<br>505 | リクエストパラメータが適切でない場合に発生するエラー                                                          | リクエストパラメータの必須値および設定可能な値などを確認します                           |
| 500 | 異常なシステムエラー                                                                          | 担当者にお問い合わせください                                            |
| 1000 | パラメータが正しくない場合に発生するエラー <br> 組織 IAM アカウント API - `IAM アカウントパスワード変更メール送信` リクエスト値 returnUrl が許可されたドメインでない場合に発生（許可されたドメイン: toast.com、dooray.com、nhncloud.com） | リクエストパラメータを確認します                                              |
| 1201 | サーバー内部の API リクエストが失敗した場合に発生するエラー | エラーメッセージに含まれるエラーメッセージとコードをもとに解決します<br>含まれるエラーメッセージとコードだけでは解決が困難な場合は担当者にお問い合わせください                      |
| 10005<br>70008<br>1104 | リクエストパラメータが適切でない場合に発生するエラー | リクエストパラメータの必須値および設定可能な値などを確認します |
| 10009 | 組織またはプロジェクトに存在しないロールを付与しようとした場合に発生するエラー                                               | メンバーに存在するロールを付与するよう変更します                                  |
| 10010 | ロールグループ削除時、プロジェクトメンバー（招待中のメンバーを含む）に該当ロールグループのみが付与されている場合に発生するエラー<br>プロジェクトメンバーのロール変更時、何もロールを付与しない場合に発生するエラー| 1) 削除しようとするロールグループ`のみ`を持つプロジェクトメンバー（招待中のメンバーを含む）のロールを別のロールに変更、または該当メンバーを削除します <br> 2) プロジェクトメンバーのロール変更時、リクエストにロールの値を設定してリクエストします |
| 10012 | プロジェクトメンバー削除時、該当メンバーが削除されることでプロジェクトに ADMIN ロールを持つメンバーが存在しなくなる場合に発生するエラー        | 1) 削除対象以外の他のプロジェクトメンバーに ADMIN ロールを付与します <br>2) ADMIN ロール以外の対象を削除します|
| 12100 | プロジェクトメンバーが存在しない場合に発生するエラー                                                          | 存在するプロジェクトメンバーの UUID を使用します                                    |
| 12107 | リクエスト uuid と対象 uuid が同一であることが許可されていない API で同一の場合に発生するエラー                              | 対象 uuid とリクエスト uuid を異なる値に設定します                               |
| 12400 | 存在しないまたは削除されたプロジェクトにメンバーを追加しようとした場合に発生するエラー                                               | 存在するプロジェクトにメンバーを追加するよう変更します                                  |
| 12401 | プロジェクト作成時、該当プロジェクトの組織 Owner アカウントに設定されたプロジェクト作成数の制限を超えた場合に発生するエラー                    | 1) 使用していないプロジェクトを削除してプロジェクト作成可能数を確保します <br>2) 担当者を通じてプロジェクト最大作成数の調整をリクエストします |
| 12500 | プロジェクト削除時、使用中のサービスが存在する場合に発生するエラー                                                  | 該当プロジェクトの使用中のサービスをすべて無効化してからプロジェクトの削除を試みます             |
| 13001 | サービスの有効化/無効化に失敗した場合に発生するエラー                                                           | 担当者にお問い合わせください                                           |
| 13002 | すでに有効化状態のサービスを再度有効化した場合に発生するエラー                                    | 既に有効化されているサービスを活用します              |
| 13004 | 有効化できないサービスを有効化しようとした場合に発生するエラー                                                     | 有効化可能なサービスに対して有効化を行います                                    |
| 13006 | 法人専用サービスの有効化時、組織 Owner のメンバータイプが法人でない場合に発生するエラー                                    | 法人アカウントタイプを持つ組織 Owner の組織配下のプロジェクトでサービスの有効化を試みます             |
| 22006 | 追加時にすでに存在する場合に発生 | 重複したリクエストが来ないよう処理します |
| 22013 | 組織 Owner のロールを変更しようとした場合に発生するエラー                                                        | 組織 Owner を対象としたロール変更はできません                                |
| 22016 | 組織が存在しない場合に発生するエラー                                                              | 存在する組織の orgId でリクエストしているか確認します                              |
| 23005 | 組織 ID に該当する組織が存在しない場合に発生するエラー                                                   | 担当者にお問い合わせください                                             |
| 30015 | プロジェクト AppKey の作成制限回数を超えた場合に発生するエラー <br> プロジェクト統合 Appkey API - `プロジェクト統合 Appkey 作成` で作成されるプロジェクト AppKey の作成可能回数は 3 個であり、3 個を超えた場合にエラーが発生します | 使用していないプロジェクト統合 Appkey を削除してから再試行します                               |
| 40017 | プロジェクトが存在しない場合に発生するエラー                                                           | 存在するプロジェクトに対して API をリクエストします                                   |
| 40028<br>13003 | プロジェクトが存在しない場合（作成後に削除した場合）に発生するエラー                                              | 存在するプロジェクトに対して API をリクエストします                                   |
| 40054 | サービス有効化時、先に有効化されなければならないサービスが有効化されていない場合に発生するエラー                               | 先に有効化が必要なサービスを有効化します                               |
| 40057 | サービス無効化時、先に無効化されなければならないサービスが無効化されていない場合に発生するエラー                            | 先に無効化が必要なサービスを無効化します                              |
| 50007 | 有効でないメンバーの場合に発生するエラー<br>（存在しないメンバー、または休眠・退会状態のメンバーは有効ではありません）<br>組織作成 API - API 呼び出し時、uuid が有効でない場合 | 有効なメンバーの uuid に修正します                                 |
| 60003 | DB にデータが存在しない場合に発生するエラー<br>プロジェクト統合 Appkey API - `プロジェクト統合 Appkey 削除` で削除する AppKey が存在しない場合に発生するエラー | 1) 担当者にお問い合わせください <br>2) 存在する AppKey を削除対象のアプリキー値に設定します  |
| 62004 | ロールグループ作成時、同一名称のロールグループが存在する場合に発生するエラー                                           | 重複しない名称に変更します                                         |
| 62008 | ロールグループの修正・削除およびロールグループへのロール追加/削除時、ロールグループ ID が存在しない場合に発生                            | 存在するロールグループ ID を使用するよう変更します                                |
| 62009 | ロールグループ作成時、ロールが有効でないロールの場合に発生                                                   | 有効なロールを使用するよう変更します                                       |
| 62011 | ロールグループ削除時、通知グループで使用中であるために発生                                                        | 通知グループを削除してからロールグループを削除するよう変更します                              |
| 62014 | ロールグループの削除およびロールグループへのロール追加/削除時、ロールグループを割り当てていたメンバーへのロールのサービスへの通知が失敗した場合                       | 担当者にお問い合わせください                                            |
| 62019 | 組織メンバーに許可されていないロールを付与しようとした場合                      | 担当者にお問い合わせください                                            |
| 72005 | 請求関連の API 呼び出しが失敗した場合に発生するエラー                                                         | 担当者にお問い合わせください                                            |
| 70013 | 利用中のサービスが存在する場合に発生するエラー                                                             | 利用中のサービスを無効化します                                           |
| 70014 | メンバー退会条件を満たしていない場合に発生するエラー<br> IAM アカウント - 1) 使用中のサービスがある場合 2) 削除されていないプロジェクトがある場合 3) 該当メンバーが任意のプロジェクトに ADMIN ロールで存在する場合| 各メンバータイプに応じた退会条件を満たすよう設定します                          |
| 70024 | 決済手段が正常に登録されていない場合に発生するエラー                                                     | 決済手段を登録します                                                 |
| 70032 | 未払いによりメンバーがブロックされた場合に発生するエラー                                                       | 該当アカウントが持つ未払い請求書を決済します                                     |
| -200201 | user-code の長さ条件が一致しない場合に発生するエラー                                                           | 20 文字以内の小文字、数字、特殊文字（-、_、.）が使用可能です。<br>特殊文字（-、_、.）は先頭および末尾には使用できません。|
| -200202 | user-code のフォーマット条件が一致しない場合に発生するエラー                                                | 小文字、数字、特殊文字（-、_、.）が使用可能です。<br>特殊文字（-、_、.）は先頭および末尾には使用できません。|
| -200203 | 名前の長さ条件が一致しない場合に発生するエラー                                                       | 60 文字以内の長さ要件を満たすよう名前の長さを修正します                           |
| -200204 | メンバーの作成・修正時に user-code が重複する場合に発生するエラー                                                | 重複しない user-code に変更してリクエストします                             |