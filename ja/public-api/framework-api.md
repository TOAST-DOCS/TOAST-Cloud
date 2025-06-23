## NHN Cloud > Public API > フレームワークAPI

### 概要
以下で紹介するAPIを通じて、プロジェクトメンバーを作成したり、ロールを付与するなど、組織とプロジェクトを管理できます。
APIを使用するためには、[API呼び出しと認証](api-authentication.md)で発行されたBearerタイプのトークンが必要です。
API呼び出し時、API認証を受けたメンバーの権限を検査します。

### Public APIドメイン
`https://core.api.nhncloudservice.com/`

### 共通

#### リクエスト
<a id="リクエスト"></a>
Public APIを呼び出す時、下記のRequest Headerを必ず含める必要があります。


| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
| Header |  x-nhn-authorization | String| Yes | ユーザーが発行されたBearerタイプトークン |


#### レスポンス
<a id="レスポンス"></a>
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
|   isSuccessful | Boolean | No | 成否 |
|   resultCode | Integer| No | 結果コード。成功した場合は0が返され、失敗した場合はエラーコードを返します。  |
|   resultMessage | String| No | 結果メッセージ |

#### 共通タイプ
<a id="共通-タイプ"></a>


| 名前 | タイプ | サイズ | 説明 | 
|------------ | ------------- | ------------- | ------------ |
| org-id | String | 16文字 | 組織ID |
| project-id | String | 8文字 | プロジェクトID |
| product-id | String | 8文字 | サービス(商品) ID |
| user-access-key-id | String | 20文字 | User Access Key ID |
| project-app-key | String | 20文字 | プロジェクトのAppKey |
| product-app-key | String | 16文字 | サービスのAppKey |
| uuid | String | 36文字 | メンバーのUUID |


#### ガバナンスIP ACL設定
<a id="ガバナンス-IP-ACL-設定"></a>

**組織管理 > ガバナンス設定 > 組織ガバナンス設定 > IP ACL設定**でIP ACLを設定した場合、フレームワークAPI呼び出し時にもその設定が適用されます。


### API

> 注意<br>
> APIのレスポンスはガイドに明示されていないフィールドが追加される可能性があるため、新しいフィールドが追加されてもエラーが発生しないように開発する必要があります。<br>
> また、DB保存時、カラムサイズが変更される可能性があるため、余裕を持って設定する必要があります。

| メソッド | HTTPリクエスト | 説明 |
|------------- | ------------- | -------------|
| POST |[/v1/projects/{project-id}/members](#プロジェクト-メンバー-作成) | プロジェクトメンバー作成 |
| POST |[/v1/organizations/{org-id}/projects](#プロジェクト-追加) | プロジェクト追加 |
| DELETE |[/v1/projects/{project-id}/members/{target-uuid}](#プロジェクト-メンバー-単件-削除) | プロジェクトメンバー単件削除 |
| DELETE |[/v1/projects/{project-id}](#プロジェクト-削除) | プロジェクト削除 |
| DELETE |[/v1/projects/{project-id}/products/{product-id}/disable](#プロジェクト-商品-終了) | プロジェクト商品終了 |
| POST |[/v1/projects/{project-id}/products/{product-id}/enable](#プロジェクト-商品-利用) | プロジェクト商品利用 |
| GET |[/v1/organizations/{org-id}/roles](#組織-ロール-リスト-照会) | 組織ロールリスト照会 |
| GET |[/v1/projects/{project-id}/roles](#プロジェクト-ロール-リスト-照会) | プロジェクトロールリスト照会 |
| GET |[/v1/organizations/{org-id}/domains](#組織-ドメイン-検索) | 組織ドメイン検索 |
| GET |[/v1/organizations/{org-id}/members/{member-uuid}](#組織-メンバー-単件-照会) | 組織メンバー単件照会 |
| POST |[/v1/organizations/{org-id}/members/search](#組織-メンバー-リスト-照会) | 組織メンバーリスト照会 |
| GET |[/v1/organizations/{org-id}/project-role-groups](#組織の-プロジェクト-共通-ロール-グループ-全体-照会) | 組織のプロジェクト共通ロールグループ全体照会 |
| GET |[/v1/product-uis/hierarchy](#商品-階層-構造-照会) | 商品階層構造照会 |
| GET |[/v1/projects/{project-id}/products/{product-id}](#プロジェクトで-使用-中の-商品-照会) | プロジェクトで使用中の商品照会 |
| GET |[/v1/projects/{project-id}/members/{member-uuid}](#プロジェクト-メンバー-単件-照会) | プロジェクトメンバー単件照会 |
| POST |[/v1/projects/{project-id}/members/search](#プロジェクト-メンバー-リスト-照会) | プロジェクトメンバーリスト照会 |
| GET |[/v1/projects/{project-id}/project-role-groups/{role-group-id}](#プロジェクト-ロール-グループ-単件-照会) | プロジェクトロールグループ単件照会 |
| GET |[/v1/organizations/{org-id}/project-role-groups/{role-group-id}](#組織の-プロジェクト-共通-ロール-グループ-単件-照会) | 組織のプロジェクト共通ロールグループ単件照会 |
| GET |[/v1/projects/{project-id}/project-role-groups](#プロジェクト-ロール-グループ-全体-照会) | プロジェクトロールグループ全体照会 |
| GET |[/v1/organizations/{org-id}/projects](#組織に-属する-プロジェクト-リスト-照会) | 組織に属するプロジェクトリスト照会 |
| GET |[/v1/organizations/{org-id}/governances](#使用-中の-組織-ガバナンス-リスト-照会) | 使用中の組織ガバナンスリスト照会 |
| POST |[/v1/organizations/{org-id}/project-role-groups](#組織の-プロジェクト-共通-ロール-グループ-作成) | 組織のプロジェクト共通ロールグループ作成 |
| DELETE |[/v1/organizations/{org-id}/project-role-groups](#組織の-プロジェクト-共通-ロール-グループ-削除) | 組織のプロジェクト共通ロールグループ削除 |
| PUT |[/v1/organizations/{org-id}/project-role-groups/{role-group-id}/infos](#組織の-プロジェクト-共通-ロール-グループ-情報-修正) | 組織のプロジェクト共通ロールグループ情報修正 |
| PUT |[/v1/organizations/{org-id}/project-role-groups/{role-group-id}/roles](#組織の-プロジェクト-共通-ロール-グループ-ロール-修正) | 組織のプロジェクト共通ロールグループロール修正 |
| POST |[/v1/projects/{project-id}/project-role-groups](#プロジェクト-ロール-グループ-作成) | プロジェクトロールグループ作成 |
| DELETE |[/v1/projects/{project-id}/project-role-groups](#プロジェクト-ロール-グループ-削除) | プロジェクトロールグループ削除 |
| PUT |[/v1/projects/{project-id}/project-role-groups/{role-group-id}/infos](#プロジェクト-ロール-グループ-情報-修正) | プロジェクトロールグループ情報修正 |
| PUT |[/v1/projects/{project-id}/project-role-groups/{role-group-id}/roles](#プロジェクト-ロール-グループ-ロール-修正) | プロジェクトロールグループロール修正 |
| PUT |[/v1/organizations/{org-id}/members/{member-uuid}](#組織-メンバー-ロール-修正) | 組織メンバーロール修正 |
| PUT |[/v1/projects/{project-id}/members/{member-uuid}](#プロジェクト-メンバー-ロール-修正) | プロジェクトメンバーロール修正 |
| GET |[/v1/iam/organizations/{org-id}/members/{member-uuid}](#組織-IAM-メンバー-単件-照会) | 組織IAMメンバー単件照会 |
| GET |[/v1/iam/organizations/{org-id}/members](#組織-IAM-メンバー-リスト-照会) | 組織IAMメンバーリスト照会 |
| POST |[/v1/iam/organizations/{org-id}/members](#組織-IAM-メンバー-追加) | 組織IAMメンバー追加 |
| POST |[/v1/iam/organizations/{org-id}/members/{member-id}/send-password-setup-mail](#IAM-メンバー-パスワード-変更-メール-送信) | IAMメンバーパスワード変更メール送信 |
| PUT |[/v1/iam/organizations/{org-id}/members/{member-uuid}](#組織-IAM-メンバー-情報-修正) | 組織IAMメンバー情報修正 |
| POST |[/v1/iam/organizations/{org-id}/members/{member-id}/set-password](#組織-IAM-メンバー-パスワード-変更) | 組織IAMメンバーパスワード変更 |
| GET |[/v1/iam/organizations/{org-id}/settings/session](#組織-IAM-ログイン-セッション-設定-情報を-照会) | 組織IAMログインセッション設定情報を照会 |
| GET |[/v1/iam/organizations/{org-id}/settings/security-mfa](#組織-IAM-ログイン-2次-認証-の-設定を-照会) | 組織IAMログイン2段階認証の設定を照会 |
| GET |[/v1/iam/organizations/{org-id}/settings/security-login-fail](#組織-IAM-ログイン-失敗-セキュリティ-設定を-照会) | 組織IAMログイン失敗セキュリティ設定を照会 |
| GET |[/v1/organizations/{org-id}/products/ip-acl](#組織-IP-ACL-リスト-照会) | 組織IP ACLリスト照会 |
| POST |[/v1/billing/contracts/basic/products/prices/search](#従量制に-登録された-商品-価格-照会) | 従量制に登録された商品価格照会 |
| GET |[/v1/billing/contracts/basic/products](#従量制に-登録された-商品-リスト-照会) | 従量制に登録された商品リスト照会 |
| GET |[/v1/authentications/projects/{project-id}/project-appkeys](#プロジェクト-AppKey-照会) | プロジェクトAppKey照会 |
| GET |[/v1/authentications/user-access-keys](#User-Access-Key-ID-リスト-照会) | User Access Key IDリスト照会 |
| POST |[/v1/authentications/projects/{project-id}/project-appkeys](#プロジェクト-AppKey-登録) | プロジェクトAppKey登録 |
| POST |[/v1/authentications/user-access-keys](#User-Access-Key-ID-登録) | User Access Key ID登録 |
| DELETE |[/v1/authentications/projects/{project-id}/project-appkeys/{app-key}](#プロジェクト-AppKey-削除) | プロジェクトAppKey削除 |
| PUT |[/v1/authentications/user-access-keys/{user-access-key-id}/secretkey-reissue](#User-Access-Key-ID-秘密-鍵-再発行) | User Access Key ID秘密鍵の再発行 |
| PUT |[/v1/authentications/user-access-keys/{user-access-key-id}](#User-Access-Key-ID-状態-修正) | User Access Key ID状態修正 |
| DELETE |[/v1/authentications/user-access-keys/{user-access-key-id}](#User-Access-Key-ID-削除) | User Access Key ID削除 |
| GET    | [/v1/authentications/user-access-keys/{user-access-key-id}/tokens](#トークン-リスト-照会)                               | トークンリスト照会                 |
| DELETE | [/v1/authentications/user-access-keys/{user-access-key-id}/tokens](#トークン-複数-期限切れ)                               | トークン複数期限切れ                  |
| POST |[/v1/iam/projects/{project-id}/members](#プロジェクト-IAM-アカウント-作成) | プロジェクトIAMアカウント作成 |
| DELETE |[/v1/iam/projects/{project-id}/members](#プロジェクト-IAM-アカウント-一括-削除) | プロジェクトIAMアカウント一括削除 |
| GET |[/v1/iam/projects/{project-id}/members/{member-uuid}](#プロジェクト-メンバー-単件-照会) | プロジェクトIAMアカウント単件照会 |
| GET |[/v1/iam/projects/{project-id}/members](#プロジェクト-IAM-アカウント-リスト-照会) | プロジェクトIAMアカウントリスト照会 |
| PUT |[/v1/iam/projects/{project-id}/members/{member-uuid}](#プロジェクト-IAM-アカウント-ロール-修正) | プロジェクトIAMアカウントロール修正 |
| GET |[/v1/authentications/organizations/{org-id}/user-access-keys](#組織-下位-メンバーの-全ての-認証情報-リスト-照会) | 組織下位メンバー認証情報リスト照会 |



<a id="プロジェクト-メンバー-作成"></a>
#### プロジェクトメンバー作成

> POST "/v1/projects/{project-id}/members"

プロジェクトにメンバーを追加するAPIです。

##### 必要権限
`Project.Member.Create`

##### リクエストパラメータ



| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | メンバーを追加するプロジェクトID | 
| Request Body | request | CreateMemberRequest| Yes | リクエスト |




###### CreateMemberRequest
> 注意<br>
> リクエスト時、memberUuid, email, userCodeのいずれかの値が必ず必要です。
> memberUuid > email > userCodeの順に値があることをチェックしている場合は、そのメンバーをプロジェクトメンバーとして追加します。<br>
> 1つのリクエストで1人のプロジェクトメンバーのみ作成できます。


| 名前 | タイプ | 必須 | 説明 |  
|------------ | ------------- | ------------- | ------------ |
|   assignRoles | List&lt;UserAssignRoleProtocol>| Yes | ユーザーに割り当てるロールリスト |
|   memberUuid | String| No | 追加するメンバーのUUID  |
|   email | String| No | 追加するメンバーのメールアドレス |
|   userCode | String| No | 追加するIAMメンバーID  |


###### UserAssignRoleProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   roleId | String| Yes | ロールID  |
|   conditions | List&lt;AssignAttributeConditionProtocol>| No | ロール条件属性 |


###### AssignAttributeConditionProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   attributeId | String| Yes | 条件属性ID  |
|   attributeOperatorTypeCode | String| Yes | 条件属性演算子<br>条件属性データ型によって使用できる演算子が異なる<br><ul><li>ALLOW</li><li>ALL_CONTAINS</li><li>ANY_CONTAINS</li><li>ANY_MATCH</li><li>BETWEEN</li><li>BEYOND</li><li>FALSE</li><li>GREATER_THAN</li><li>GREATER_THAN_OR_EQUAL_TO</li><li>LESS_THAN</li><li>LESS_THAN_OR_EQUAL_TO</li><li>NONE_MATCH</li><li>NOT_ALLOW</li><li>NOT_CONTAINS</li><li>TRUE</li></ul>  |
|   attributeValues | List&lt;String>| Yes | 条件属性値 |


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


| 名前 | タイプ          | 必須 | 説明 |   
|------------ |--------------| ------- | ------------ |
|   header | [共通レスポンス](#レスポンス) | Yes |


<a id="プロジェクト-追加"></a>
#### プロジェクト追加

> POST "/v1/organizations/{org-id}/projects"

組織にプロジェクトを追加するAPIです。

##### 必要権限
`Organization.Project.Create`

##### リクエストパラメータ



| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
| Path |org-id | String| Yes | プロジェクトを追加する組織ID | 
| Request Body | request | CreateProjectRequest| Yes | リクエスト |


###### CreateProjectRequest


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------ | ------------ |
|   description | String| No | プロジェクトの説明(最大100文字) |
|   projectName | String| Yes| プロジェクト名(最大40文字) |


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

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | --------- | ------------ |
|   header | [共通レスポンス](#レスポンス)| Yes  |
|   regDateTime | Date| Yes   | プロジェクト作成日時 | 
|   description | String| No   | プロジェクトの説明 | 
|   ownerId | String| Yes   | プロジェクト所有者メンバーID | 
|   projectName | String| Yes   | プロジェクト名 | 
|   projectId | String| Yes   | プロジェクトID | 
|   orgId | String| Yes   | 組織ID | 
|   projectStatusCode | String| Yes   | プロジェクトの状態<br><ul><li>STABLE：正常に使用中の状態</li><li>CLOSED：支払いが完了し、プロジェクトが正常に閉じた状態</li><li>BLOCKED：管理者によって使用が禁止された状態</li><li>TERMINATED：延滞により、全てのリソースが削除された状態</li><li>DISABLED：全ての商品が閉じた状態であるが、値が支払われていない状態</li></ul> | 


<a id="プロジェクト-メンバー-単件-削除"></a>
#### プロジェクトメンバー単件削除

> DELETE "/v1/projects/{project-id}/members/{target-uuid}"

ユーザーを該当プロジェクトから削除するAPIです。

##### 必要権限
`Project.Member.Delete`

##### リクエストパラメータ



| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | プロジェクトID | 
|  Path |target-uuid | String| Yes | 削除対象メンバーUUID | 




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
|   header | [共通レスポンス](#レスポンス)| Yes |



<a id="プロジェクト-削除"></a>
#### プロジェクト削除

> DELETE "/v1/projects/{project-id}"

プロジェクトを削除するAPIです。

##### 必要権限
以下のリストのいずれかの権限が必要です。
* `Organization.Project.Delete`
* `Project.Delete`

##### リクエストパラメータ



| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | 削除するプロジェクトID | 






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
|   header | [共通レスポンス](#レスポンス)| Yes |



<a id="プロジェクト-商品-終了"></a>
#### プロジェクト商品終了

> DELETE "/v1/projects/{project-id}/products/{product-id}/disable"

当該プロジェクトでユーザーが指定したサービスを利用しないように無効にするAPIです。

##### 必要権限
`商品名:Product.Delete`

##### リクエストパラメータ


| 区分 | 名前 | タイプ | 必須 | 説明 | 
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
|   header | [共通レスポンス](#レスポンス)| Yes |
|   childProducts | List&lt;ChildProduct>| No   | 該当サービスの下位サービス情報で、下位サービスがない場合は含まれません。<br>下位サービスを先に無効にして、該当サービスを無効化する必要があります。|

###### ChildProduct


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | --------- | ------------ |
|   productId | String| Yes  | 	下位サービスID | 
|   productName | String| Yes  | 下位サービス名 |
|   statusCode | String| Yes | サービス状態(STABLE, CLOSED) |


<a id="プロジェクト-商品-利用"></a>
#### プロジェクト商品利用

> POST "/v1/projects/{project-id}/products/{product-id}/enable"

該当プロジェクトでユーザーが指定したサービスを利用できるように有効化リクエストするAPIです。

##### 必要権限
`商品名:Product.Create`

##### リクエストパラメータ



| 区分 | 名前 | タイプ | 必須 | 説明 | 
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


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------- | ------------ |
|   header | [共通レスポンス](#レスポンス)| Yes |
|   appKey | String| Yes | 該当プロジェクトで利用中のサービスのAppKey情報|
|   parentProduct | ParentProduct| No | 上位サービス情報がある場合はその情報を表示し、上位サービスがない場合は含みません。 |
|   secretKey | String| No| 該当プロジェクトで利用中のサービスの秘密鍵情報<br> 秘密鍵を利用するサービスでのみ提供 |


###### ParentProduct


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | --------- | ------------ |
|   productId | String| Yes  | サービスID |
|   productName | String| Yes  | サービス名 |
|   statusCode | String| Yes | サービス状態(STABLE, CLOSED) |





<a id="組織-ロール-リスト-照会"></a>
#### 組織ロールリスト照会

> GET "/v1/organizations/{org-id}/roles"

組織ユーザーに付与できるロールのリストをリクエストするAPIです。

##### 必要権限
`Organization.RoleGroup.List`

##### リクエストパラメータ



| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 組織ID |
|  Query |categoryTypeCodes | List&lt;String> | No | ロール/権限/ロールグループカテゴリー区分(ROLE, PERMISSION, ROLE_GROUP) |
|  Query |roleNameLike | String| No | ロール/権限/ロールグループ名 |
|  Query |limit | Integer| No | 1ページあたりの表示件数、デフォルト値20 | 
|  Query |page | Integer| No | 対象ページ、デフォルト値1 |



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
|   header | [共通レスポンス](#レスポンス)| Yes |
|   roles | List&lt;RoleProtocol>| Yes  | ロールリスト |
|   totalCount | Integer| Yes  | 総数 |

###### RoleProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   categoryKey | String| Yes | ロール/権限カテゴリー分類キー<br><ul><li>RoleGroup:プロジェクトロールグループ</li><li>OrgRoleGroup:組織ロールグループ</li><li>OrgRole:組織ロール</li><li>ProjectRole:プロジェクトロール</li><li>BillingRole: Billing関連ロール</li><li>OrgServiceRole:組織サービスロール</li><li>ProjectServiceRole:プロジェクトサービスロール</li><li>SystemRole:システム作成ロール</li></ul>  |
|   categoryTypeCode | String| Yes | ロールグループ/ロール/権限区分コード(ORG_ROLE_GROUP, PERMISSION, ROLE, ROLE_GROUP, SYSTEM) |
|   description | String| Yes | ロール/権限の説明 |
|   roleCategory | String| Yes | ロール/権限カテゴリー大分類(ORG_ROLE, ORG_ROLE_GROUP, ORG_SERVICE_ROLE, PROJECT_ROLE, PROJECT_ROLE_GROUP, PROJECT_SERVICE_ROLE, SYSTEM_ROLE) |
|   roleId | String| Yes | ロール/権限ID  |
|   roleName | String| Yes | ロール/権限名 |


<a id="プロジェクト-ロール-リスト-照会"></a>
#### プロジェクトロールリスト照会

> GET "/v1/projects/{project-id}/roles"

プロジェクトユーザーに付与できるロールのリストをリクエストするAPIです。

##### 必要権限
`Project.RoleGroup.List`

##### リクエストパラメータ


| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | プロジェクトID | 
|  Query |categoryTypeCodes | List&lt;String> | No | ロール/権限/ロールグループカテゴリー区分(ROLE, PERMISSION, ROLE_GROUP) |
|  Query |roleNameLike | String| No | ロール/権限/ロールグループ名 |
|  Query |limit | Integer| No | 1ページあたりの表示件数、デフォルト値20 | 
|  Query |page | Integer| No | 対象ページ、デフォルト値1 |


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
|   header | [共通レスポンス](#レスポンス)| Yes |
|   roles | List&lt;[RoleProtocol](#roleprotocol)>| Yes  | ロールリスト |
|   totalCount | Integer| Yes  | 総数 |

<a id="組織-ドメイン-検索"></a>
#### 組織ドメイン検索

> GET "/v1/organizations/{org-id}/domains"

特定組織のドメインを照会するAPIです。

##### 必要権限
`Organization.Domain.List`

##### リクエストパラメータ



| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 照会する組織のID | 




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
|   header | [共通レスポンス](#レスポンス)| Yes |
|   domainList | List&lt;OrgDomainProtocol>| Yes  |


###### OrgDomainProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | --------- | ------------ |
|   orgDomainId | String| Yes | 組織ドメインID |
|   orgDomainName | String| Yes | 組織ドメイン名 |


<a id="組織-メンバー-単件-照会"></a>
#### 組織メンバー単件照会

> GET "/v1/organizations/{org-id}/members/{member-uuid}"

組織に所属するメンバーを照会するAPIです。

##### 必要権限
`Organization.Member.Get`

##### リクエストパラメータ



| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | メンバーを照会する組織ID | 
|  Path |member-uuid | String| Yes | 	照会するメンバーUUID | 





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

###### レスポンス


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------- | ------------ |
|   header | [共通レスポンス](#レスポンス)| Yes |
|   orgMember | OrgMemberRoleBundleProtocol| No  | 追加されたメンバー情報、エラーの場合は含まれません。 |

###### OrgMemberRoleBundleProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----- | ------------ |
|   email | String| Yes | メンバーメール |
|   id | String| No | メンバーID(IAMメンバーのみ提供) |
|   inviteStatusCode | String| Yes |   COMPLETE, EXPIRE, UNKNOWN, WAIT |
|   joinYmdt | Date| Yes | 組織メンバー登録日時 |
|   memberName | String| Yes| 	メンバー名 |
|   memberTypeCode | String| Yes| メンバー区分(TOAST_CLOUD: NHN Cloudメンバー、 IAM: IAMメンバー) |
|   memberUuid | String| Yes| メンバーのUUID |
|   recentLoginYmdt | Date| Yes| 最後のログイン日時 |
|   recentPasswordModifyYmdt | Date| No| 最後のパスワード変更日時 |
|   roleCode | String| No| ロールID |
|   roles | List&lt;RoleBundleProtocol>| No | 関連ロールリスト(条件属性を含む)  |
|   secondFactorCertificationYn | String| No| 2段階ログイン設定の有無(NHN Cloudメンバーのみ提供) |


###### RoleBundleProtocol
| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----- | ------------ |
|   roleId | String| Yes | ロールID |
|   roleName | String| Yes | ロール名 |
|   description | String| No | ロールの説明 |
|   categoryKey | String| Yes | ロール/権限カテゴリー分類キー<br><ul><li>RoleGroup:プロジェクトロールグループ</li><li>OrgRoleGroup:組織ロールグループ</li><li>OrgRole:組織ロール</li><li>ProjectRole:プロジェクトロール</li><li>BillingRole: Billing関連ロール</li><li>OrgServiceRole:組織サービスロール</li><li>ProjectServiceRole:プロジェクトサービスロール</li><li>SystemRole:システム作成ロール</li></ul>  |
|   categoryTypeCode | String| Yes | ロールグループ/ロール/権限区分コード(ORG_ROLE_GROUP, PERMISSION, ROLE, ROLE_GROUP, SYSTEM) |
|   conditions | List&lt;AttributeConditionProtocol>| No | 条件属性リスト |
|   roleApplyPolicyCode | String| Yes | ロール使用有無ALLOW, DENY |
|   regDateTime | Date| Yes | ロール作成日時 |



###### AttributeConditionProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----- | ------------ |
|   attributeDataTypeCode | String| Yes | 条件属性データ型(BOOLEAN, DATETIME, DAY_OF_WEEK, IPADDRESS, NUMERIC, STRING, TIME) |
|   attributeDescription | String| No | 条件属性の説明 |
|   attributeId | String| Yes | 条件属性ID |
|   attributeName | String| Yes | 条件属性名 |
|   attributeOperatorTypeCode | String| Yes | 条件属性演算子<br>条件属性データ型によって使用できる演算子が異なります<br><ul><li>ALLOW</li><li>ALL_CONTAINS</li><li>ANY_CONTAINS</li><li>ANY_MATCH</li><li>BETWEEN</li><li>BEYOND</li><li>FALSE</li><li>GREATER_THAN</li><li>GREATER_THAN_OR_EQUAL_TO</li><li>LESS_THAN</li><li>LESS_THAN_OR_EQUAL_TO</li><li>NONE_MATCH</li><li>NOT_ALLOW</li><li>NOT_CONTAINS</li><li>TRUE</li></ul> |
|   attributeValues | List&lt;String>| Yes| 条件属性値 |



<a id="組織-メンバー-リスト-照会"></a>
#### 組織メンバーリスト照会

> POST "/v1/organizations/{org-id}/members/search"

該当組織に所属するNHN Cloudメンバーリストを照会するAPIです。

##### 必要権限
`Organization.Member.List`

##### リクエストパラメータ



| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 組織ID | 
| Request Body | request | SearchOrgMembersRequest| Yes | リクエスト |


###### SearchOrgMembersRequest


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | --------- | ------------ |
|   memberStatusCodes | List&lt;String>| No | 照会するメンバーの状態<br><ul><li>STABLE:招待完了</li><li>INVITED:招待中</li><li>BLOCKED</li><li>NOT_EXIST</li><li>WITHDRAW</li></ul> |
|   roleIds | Set&lt;String>| No  | メンバーが付与されたロールID |
|   paging | PagingBean| No  |

###### PagingBean


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   limit | Integer| No | 1ページあたりの表示件数、デフォルト値20  |
|   page | Integer| No | 対象ページ、デフォルト値1  |




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
|   header | [共通レスポンス](#レスポンス)| Yes |
|   orgMembers | List&lt;OrgMemberWithInviteMemberrotocol>| Yes | 組織メンバーリスト |
|   paging | PagingResponse| Yes | ページ情報 |

###### OrgMemberWithInviteMemberProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----- | ------------ |
|   email | String| Yes | メンバーのメールアドレス |
|   inviteStatusCode | String| No | メンバーの招待状態(COMPLETE, EXPIRE, UNKNOWN, WAIT) |
|   joinYmdt | Date| Yes | メンバー加入日時 |
|   maskingEmail | String| Yes | メンバーのマスキングされたメール |
|   memberName | String| Yes| メンバーの名前 |
|   memberTypeCode | String| Yes| メンバー区分(TOAST_CLOUD: NHN Cloudメンバー、 IAM: IAMメンバー) |
|   memberUuid | String| No| メンバーのUUID<br>招待中の場合は値を返しません。 |
|   recentLoginYmdt | Date| Yes| 最後のログイン日時 |
|   recentPasswordModifyYmdt | Date| No| 最後のパスワード変更日時 |
|   secondFactorCertificationYn | String| No|  2段階ログイン設定有無(NHN Cloudメンバーのみ提供) |

###### PagingResponse


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   limit | Integer| No | 1ページあたりの表示件数、デフォルト値20  |
|   page | Integer| No | 対象ページ、デフォルト値1  |
|   totalCount | Long| Yes | 総件数 |




<a id="組織の-プロジェクト-共通-ロール-グループ-全体-照会"></a>
#### 組織のプロジェクト共通ロールグループ全体照会

> GET "/v1/organizations/{org-id}/project-role-groups"

組織で設定したプロジェクト共通ロールグループリストを照会するAPIです。

##### 必要権限
`Organization.Project.RoleGroup.List`

##### リクエストパラメータ



| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 照会対象組織ID | 
|  Query |descriptionLike | String| No | 説明 | 
|  Query |roleGroupNameLike | String| No | ロールグループ名 |
|  Query |limit | Integer| No | 1ページあたりの表示件数、デフォルト値20 |
|  Query |page | Integer| No | 対象ページ、デフォルト値1 |






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
|   header | [共通レスポンス](#レスポンス)| Yes  |
|   paging | [PagingResponse](#pagingresponse)| Yes  |
|   roleGroups | List&lt;RoleGroupProtocol>| Yes | プロジェクトで使用可能なロールグループリスト |


###### RoleGroupProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----- | ------------ |
|   description | String| No | ロールグループの説明 |
|   regDateTime | Date| Yes | ロールグループ作成日時 |
|   roleGroupId | String| Yes | ロールグループID |
|   roleGroupName | String| Yes| ロールグループの名前 |
|   roleGroupType | String| Yes | ロールグループの種類<br><ul><li>ORG:プロジェクト共通ロールグループ</li><li>ORG_ROLE_GROUP:組織ロールグループ</li><li>PROJECT:プロジェクトロールグループ</li> |


<a id="商品-階層-構造-照会"></a>
#### 商品階層構造照会

> GET "/v1/product-uis/hierarchy"

請求書に表示されるWebサイトカテゴリー、 Webサイトサービス情報を返すAPIです。

##### 必要権限
会員であれば、特定の権限なしで呼び出すことができるAPIです。
ただし、組織商品を照会する場合は、その組織や組織の下にあるプロジェクトメンバーでなければなりません。

##### リクエストパラメータ



| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Query |productUiType | String| Yes | 商品UIタイプ<br><ul><li>PROJECT:プロジェクト商品</li><li>ORG:組織商品</li><li>MARKET_PLACE:マーケットプレイス商品</li></ul> |
|  Query |orgId | String| No | 商品UIタイプがORGの場合、組織IDを必ず入力する必要があります。 |




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
|   header | [共通レスポンス](#レスポンス)| Yes |
|   productUiList | List&lt;ProductUiHierarchyProtocol>| Yes  | Webサイトカテゴリー商品UIリスト |

###### ProductUiHierarchyProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----- | ------------ |
|   children | List&lt;ProductUiHierarchyProtocol>| No | Webサイトサービス商品UIリスト |
|   manualLink | String| No|
|   parentProductUiId | String| No| 商品UI区分 |
|   productId | String| No|
|   productUiId | String| No| 商品UI識別キー |
|   productUiName | String| No|


<a id="プロジェクトで-使用-中の-商品-照会"></a>
#### プロジェクトで使用中の商品照会

> GET "/v1/projects/{project-id}/products/{product-id}"

* プロジェクトで使用中の特定サービス情報を照会するAPI

##### 必要権限
`商品名:ProductAppKey.Get`

##### リクエストパラメータ



| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | 照会対象プロジェクトID |
|  Path |product-id | String| Yes | 照会対象サービスID |




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
|   header | [共通レスポンス](#レスポンス)| Yes |
|   hasUpdateSecretKeyPermission | Boolean| Yes | 秘密鍵再発行可能権限 |
|   product | ProjectProductRelationAndProductProtocol| Yes  | 指定したサービスIDに対して、プロジェクトで使用しているサービス情報を返し、エラー時は含みません。 |


###### ProjectProductRelationAndProductProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   appKey | String| Yes | 該当プロジェクトで利用中のサービスのAppKey情報 |
|   externalId | String| No | テナントID<br>サービスにテナントIDが存在する場合にのみ提供 |
|   productId | String| Yes | サービスID  |
|   productName | String| Yes | 商品名 |
|   productSecretKeyCode | String| No | 秘密鍵使用有無<br>T:使用する<br>その他:使用しない(F, N) |
|   productStatusCode | String| Yes | サービス状態(STABLE, CLOSED) |
|   projectId | String| Yes | 該当サービスを使用するプロジェクトID  |
|   relationDate | Date| Yes | サービス利用開始日時 |
|   secretKey | String| Yes | サービスSecretKey<br>secretKeyを利用するサービスでのみ提供 |
|   statusCode | String| Yes | 該当サービスの利用状態(STABLE, CLOSED) |
|   updateDate | Date| No | サービス最終修正日時 |
|   updateUuid | String| No | サービスAppKey修正者UUID  |


<a id="プロジェクト-メンバー-単件-照会"></a>
#### プロジェクトメンバー単件照会

> GET "/v1/projects/{project-id}/members/{member-uuid}"

プロジェクトに所属する特定メンバーを照会するAPIです。

##### 必要権限
`Project.Member.Get`

##### リクエストパラメータ



| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | メンバーを照会するプロジェクトID |
|  Path |member-uuid | String| Yes | 照会するメンバーUUID |




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
|   header | [共通レスポンス](#レスポンス)| Yes |
|   projectMember | ProjectMemberRoleBundleProtocol| Yes  | 追加されたメンバー情報、エラー時は含まれません。 |


###### ProjectMemberRoleBundleProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   emailAddress | String| No | メンバーのメールアドレス |
|   maskingEmail | String| No | メンバーのマスキングされたメールアドレス |
|   memberName | String| No | メンバー名 |
|   memberTypeCode | String| No | メンバー区分(IAM, TOAST_CLOUD) |
|   relationDateTime | Date| No | メンバー追加時間 |
|   roles | List&lt;RoleBundleProtocol>| No | 関連ロールリスト(条件属性を含む)  |
|   statusCode | String| No | 招待ステータスコード(COMPLETE, EXPIRE, UNKNOWN, WAIT) |
|   uuid | String| No | メンバーUUID  |


[RoleBundleProtocol](#rolebundleprotocol)



<a id="プロジェクト-メンバー-リスト-照会"></a>
#### プロジェクトメンバーリスト照会

> POST "/v1/projects/{project-id}/members/search"

プロジェクトに所属するメンバーリストを照会するためのAPIです。

##### 必要権限
`Project.Member.List`

##### リクエストパラメータ


| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | 照会するプロジェクトID | 
| Request Body | request | SearchProjectMembersRequest| Yes | リクエスト |



###### SearchProjectMembersRequest


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   memberStatusCodes | List&lt;String>| No | プロジェクトメンバーステータスコード(INVITED, STABLE) |
|   roleIds | List&lt;String>| No | ロールIDリスト |
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


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------- | ------------ |
|   header | [共通レスポンス](#レスポンス)| Yes |
|   paging | [PagingResponse](#pagingresponse)| Yes  |
|   projectMembers | List&lt;ProjectMemberProtocol>| Yes | プロジェクトメンバー |



###### ProjectMemberProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   emailAddress | String| No | メンバーのメールアドレス |
|   maskingEmail | String| No | メンバーのマスキングされたメールアドレス |
|   memberName | String| No | メンバー名 |
|   memberTypeCode | String| No | メンバー区分 |
|   relationDateTime | Date| No | メンバー追加時間 |
|   statusCode | String| No | 招待ステータスコード(COMPLETE, EXPIRE, UNKNOWN, WAIT) |
|   uuid | String| No | メンバーUUID  |


<a id="プロジェクト-ロール-グループ-単件-照会"></a>
#### プロジェクトロールグループ単件照会

> GET "/v1/projects/{project-id}/project-role-groups/{role-group-id}"

プロジェクトのロールグループを照会するAPIです。

##### 必要権限
`Project.RoleGroup.Get`

##### リクエストパラメータ



| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | 照会対象プロジェクトID | 
|  Path |role-group-id | String| Yes | プロジェクトロールグループID<br>プロジェクト共通ロールグループIDは照会不可 | 




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
|   header | [共通レスポンス](#レスポンス)| Yes |
|   roleGroup | RoleGroupBundleProtocol| Yes | 関連ロールを含むロールグループ |

###### RoleGroupBundleProtocol

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   roleGroupId | String| No | ロールグループID  |
|   roleGroupName | String| No | ロールグループ名 |
|   description | String| No | ロールグループの説明 |
|   roleGroupType | String| No | ロールグループ区分(組織、プロジェクト)  |
|   roles | List&lt;[RoleBundleProtocol](#rolebundleprotocol)>| No | 関連ロールリスト |
|   regDateTime | Date| No | 登録日時 |



<a id="組織の-プロジェクト-共通-ロール-グループ-単件-照会"></a>
#### 組織のプロジェクト共通ロールグループ単件照会

> GET "/v1/organizations/{org-id}/project-role-groups/{role-group-id}"

プロジェクト共通ロールグループを照会するAPIです。

##### 必要権限
`Organization.Project.RoleGroup.Get`

##### リクエストパラメータ


| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 照会対象組織ID | 
|  Path |role-group-id | String| Yes | プロジェクト共通ロールグループID | 


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
|   header | [共通レスポンス](#レスポンス)| Yes |
|   roleGroup | [RoleGroupBundleProtocol](#rolegroupbundleprotocol) | Yes | 関連ロールを含むロールグループ |




<a id="プロジェクト-ロール-グループ-全体-照会"></a>
#### プロジェクトロールグループ全体照会

> GET "/v1/projects/{project-id}/project-role-groups"

プロジェクトのロールグループを全体照会するAPIです。

##### 必要権限
`Project.RoleGroup.List`

##### リクエストパラメータ


| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | 照会対象プロジェクトID | 
|  Query |descriptionLike | String| No | 説明 |
|  Query |roleGroupNameLike | String| No | ロールグループ名 |
|  Query |limit | Integer| No | 1ページあたりの表示件数、デフォルト値20 |
|  Query |page | Integer| No | 対象ページ、デフォルト値1 |



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
|   header | [共通レスポンス](#レスポンス)| Yes  |
|   paging | [PagingResponse](#pagingresponse)| Yes  |
|   roleGroups | List&lt;[RoleGroupProtocol](#rolegroupprotocol)>| Yes | プロジェクトで使用可能なロールグループリスト |

<a id="組織に-属する-プロジェクト-リスト-照会"></a>
#### 組織に属するプロジェクトリスト照会

> GET "/v1/organizations/{org-id}/projects"

特定組織に属するSTABLE状態のプロジェクトリストを照会するAPIです。

##### 必要権限
組織のメンバー

##### リクエストパラメータ


| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 照会する組織のID | 
|  Query |memberUuid | String| No | 組織のメンバーUUID |
|  Query |projectName | String| No | プロジェクト名 |
|  Query |page | Integer| No | 対象ページ、デフォルト値1 |
|  Query |limit | Integer| No | 1ページあたりの表示件数、デフォルト値20 |


##### レスポンス本文

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


###### レスポンス


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------- | ------------ |
|   header | [共通レスポンス](#レスポンス)| Yes |
|   paging | [PagingResponse](#pagingresponse) | Yes |
|   projectList | List&lt;OrgProjectMemberRoleProtocol>| Yes |



###### OrgProjectMemberRoleProtocol

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----- | ------------ |
|   delDateTime | Date| No | プロジェクト削除日時 |
|   description | String| No | プロジェクトの説明 |
|   modDateTime | Date| No| プロジェクト修正日時 |
|   orgId | String| Yes| プロジェクトが属する組織ID |
|   projectId | String| Yes| プロジェクトID |
|   projectName | String| Yes| プロジェクト名 |
|   projectStatusCode | String| Yes   | プロジェクトの状態<br><ul><li>STABLE：正常に使用中の状態</li><li>CLOSED：支払いが完了し、プロジェクトが正常に閉じた状態</li><li>BLOCKED：管理者によって使用が禁止された状態</li><li>TERMINATED：延滞により、全てのリソースが削除された状態</li><li>DISABLED：全ての商品が閉じた状態であるが、値が支払われていない状態</li></ul> | 
|   regDateTime | Date| Yes| プロジェクト登録日時 |


<a id="使用-中の-組織-ガバナンス-リスト-照会"></a>
#### 使用中の組織ガバナンスリスト照会

> GET "/v1/organizations/{org-id}/governances"

有効になっているガバナンスを照会するAPIです。

##### 必要権限
`Organization.Governance.List`

##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 照会対象組織ID | 



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
|   header | [共通レスポンス](#レスポンス)| Yes   |
|   usingGovernances | List&lt;GovernanceProtocol>| No | 使用中のガバナンスリスト |


###### GovernanceProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   governanceTypeCode | String| No | ガバナンスタイプ |
|   regDatetime | Date| No | ガバナンス使用設定日時 |


<a id="組織の-プロジェクト-共通-ロール-グループ-作成"></a>
#### 組織のプロジェクト共通ロールグループ作成

> POST "/v1/organizations/{org-id}/project-role-groups"

プロジェクト共通ロールグループを作成するAPIです。


##### 必要権限
`Organization.Project.RoleGroup.Create`

##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 組織ID | 
| Request Body | request | CreateRoleGroupRequest| Yes | リクエスト |

###### CreateRoleGroupRequest

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   description | String| No | ロールグループの説明 |
|   roleGroupName | String| Yes | ロールグループ名 |
|   roles | List&lt;AssignRoleProtocol>| Yes | ロールグループに割り当てるロールリスト |


###### AssignRoleProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   conditions | List&lt;[AssignAttributeConditionProtocol](#assignattributeconditionprotocol)>| No | ロール条件属性 |
|   roleApplyPolicyCode | String| Yes | ロール使用有無ALLOW, DENY |
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

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#レスポンス)| Yes   |


<a id="組織の-プロジェクト-共通-ロール-グループ-削除"></a>
#### 組織のプロジェクト共通ロールグループ削除

> DELETE "/v1/organizations/{org-id}/project-role-groups"

プロジェクト共通ロールグループを削除するAPIです。

##### 必要権限
`Organization.Project.RoleGroup.Delete`

##### リクエストパラメータ


| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 組織ID | 
| Request Body | request | DeleteRoleGroupRequest| Yes | リクエスト |


###### DeleteRoleGroupRequest


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   roleGroupIds | List&lt;String>| Yes | ロールグループIDリスト |


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

<a id="組織の-プロジェクト-共通-ロール-グループ-情報-修正"></a>
#### 組織のプロジェクト共通ロールグループ情報修正

> PUT "/v1/organizations/{org-id}/project-role-groups/{role-group-id}/infos"

プロジェクト共通ロールグループの名前と説明を修正するAPIです。

##### 必要権限
`Organization.Project.RoleGroup.Update`

##### リクエストパラメータ


| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 組織ID | 
|  Path |role-group-id | String| Yes | ロールグループID | 
| Request Body | request | UpdateRoleGroupInfoRequest| Yes | リクエスト |


###### UpdateRoleGroupInfoRequest


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   description | String| No | ロールグループの説明 |
|   roleGroupName | String| Yes | ロールグループ名 |



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

<a id="組織の-プロジェクト-共通-ロール-グループ-ロール-修正"></a>
#### 組織のプロジェクト共通ロールグループロール修正

> PUT "/v1/organizations/{org-id}/project-role-groups/{role-group-id}/roles"

プロジェクト共通ロールグループのロールを修正するAPIです。

##### 必要権限
`Organization.Project.RoleGroup.Update`

##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 組織ID | 
|  Path |role-group-id | String| Yes | ロールグループID | 
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
|   header | [共通レスポンス](#レスポンス)| Yes   |

<a id="プロジェクト-ロール-グループ-作成"></a>
#### プロジェクトロールグループ作成

> POST "/v1/projects/{project-id}/project-role-groups"

プロジェクトにロールグループを作成するAPIです。


##### 必要権限
`Project.RoleGroup.Create`

##### リクエストパラメータ


| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | プロジェクトID | 
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
|   header | [共通レスポンス](#レスポンス)| Yes   |

<a id="プロジェクト-ロール-グループ-削除"></a>
#### プロジェクトロールグループ削除

> DELETE "/v1/projects/{project-id}/project-role-groups"

プロジェクトロールグループを削除するAPIです。


##### 必要権限
`Project.RoleGroup.Delete`

##### リクエストパラメータ


| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | プロジェクトID | 
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
|   header | [共通レスポンス](#レスポンス)| Yes   |

<a id="プロジェクト-ロール-グループ-情報-修正"></a>
#### プロジェクトロールグループ情報修正

> PUT "/v1/projects/{project-id}/project-role-groups/{role-group-id}/infos"

プロジェクトロールグループの名前と説明を修正するAPIです。

##### 必要権限
`Project.RoleGroup.Update`

##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | プロジェクトID | 
|  Path |role-group-id | String| Yes | ロールグループID | 
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
|   header | [共通レスポンス](#レスポンス)| Yes   |


<a id="プロジェクト-ロール-グループ-ロール-修正"></a>
#### プロジェクトロールグループロール修正

> PUT "/v1/projects/{project-id}/project-role-groups/{role-group-id}/roles"

プロジェクトロールグループのロールを修正するAPIです。

##### 必要権限
`Project.RoleGroup.Update`

##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | プロジェクトID | 
|  Path |role-group-id | String| Yes | ロールグループID | 
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
|   header | [共通レスポンス](#レスポンス)| Yes   |

<a id="組織-メンバー-ロール-変更"></a>
#### 組織メンバーロール変更

> PUT "/v1/organizations/{org-id}/members/{member-uuid}"

該当組織に所属するメンバーのロールを修正するAPIです。


##### 必要権限
`Organization.Member.Update`


##### リクエストパラメータ


| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 組織ID | 
|  Path |member-uuid | String| Yes | 修正するメンバーのUUID | 
| Request Body | request | UpdateMemberRoleRequest| Yes | リクエスト |


###### UpdateMemberRoleRequest


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   assignRoles | List&lt;[UserAssignRoleProtocol](#userassignroleprotocol)>| Yes | ユーザーに割り当てるロールリスト |





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

<a id="プロジェクト-メンバー-ロール-修正"></a>
#### プロジェクトメンバーロール修正

> PUT "/v1/projects/{project-id}/members/{member-uuid}"

プロジェクトで指定したメンバーのロールを変更するAPIです。

##### 必要権限
`Project.Member.Update`

##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | プロジェクトID | 
|  Path |member-uuid | String| Yes | ロール変更対象メンバーUUID | 
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

<a id="組織-IAM-メンバー-単件-照会"></a>
#### 組織IAMメンバー単件照会

> GET "/v1/iam/organizations/{org-id}/members/{member-uuid}"

組織に所属するIAMメンバーを照会するAPIです。

##### 必要権限
`Organization.Member.Iam.Get`


##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 照会する組織ID | 
|  Path |member-uuid | String| Yes | 照会する組織のIAMメンバーUUID | 


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
|   header | [共通レスポンス](#レスポンス)| Yes   |
|   orgMember | OrgIamMemberRoleBundleProtocol| No  |

###### OrgIamMemberRoleBundleProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----- | ------------ |
|   corporate | String| No | 会社名 |
|   country | String| No | 国籍(組織Ownerの国籍) |
|   createdAt | Date| No | 作成日時 |
|   creationType | String| No| メンバーの作成タイプ |
|   department | String| No| 部署名 |
|   emailAddress | String| Yes | IAMメンバーメールアドレス |
|   englishName | String| No| 英語名 | 
|   id | String| Yes | IAMメンバーUUID  |
|   idProviderId | String| No| 外部認証を使用する場合、認証機関ID |
|   idProviderType | String| No| service: IAM直接ログイン<br>sso:顧客SSO連動 |
|   idProviderUserId | String| No|
|   lastAccessedAt | Date| No| メンバーの最後の接続日時、ない場合はnullを返す |
|   lastLoggedInAt | Date| No| メンバーの最後のログイン日時、ない場合はnullを返す |
|   lastLoggedInIp | String| No| メンバーの最後のログインIPアドレス、ない場合はnullを返す |
|   maskingEmail | String| No | IAMメンバーのマスキングされたメールアドレス |
|   mobilePhone | String| No | IAMメンバーの携帯電話番号 |
|   mobilePhoneCountryCode | String| No| 携帯電話番号国コード2桁英字 |
|   name | String| Yes | IAMメンバーの名前 |
|   nativeName | String| No|
|   nickname | String| No|
|   officeHoursBegin | String| No|
|   officeHoursEnd | String| No|
|   organizationId | String| Yes | IAMメンバーの組織ID  |
|   passwordChangedAt | Date| No| メンバーの最後のパスワード変更日時、ない場合はnullを返す |
|   position | String| No| 役職 |
|   profileImageUrl | String| No| プロフィールイメージURL |
|   roles | List&lt;[RoleBundleProtocol](#rolebundleprotocol)>| No | 関連ロールリスト(条件属性を含む)  |
|   saasRoles | List&lt;IamMemberRole>| No | IAMメンバーロール |
|   status | String| No| メンバーの状態 |
|   telephone | String| No | IAMメンバーの電話番号 |
|   userCode | String| Yes | IAMメンバーID  |



###### IamMemberRole


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------- | ------------ |
|   productId | String| No |
|   productName | String| No |
|   role | String| No |


<a id="組織-IAM-メンバー-リスト-照会"></a>
#### 組織IAMメンバーリスト照会

> GET "/v1/iam/organizations/{org-id}/members"

該当組織に所属するIAMメンバーリストを照会するAPIです。

##### 必要権限
`Organization.Member.Iam.List`

##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 組織ID | 
|  Query |email | String| No | IAMメンバーのメールアドレス |
|  Query |emailLike | String| No |  |
|  Query |idProviderType | String| No | service: IAM直接ログイン<br>sso:顧客SSO連動 |
|  Query |nameLike | String| No |  |
|  Query |statuses | List&lt;String>| No |  |
|  Query |userCode | String| No | IAMメンバーID |
|  Query |userCodeLike | String| No |  |
|  Query |limit | Integer| No | 1ページあたりの表示件数、デフォルト値20 |
|  Query |page | Integer| No | 対象ページ、デフォルト値1 |

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
|   header | [共通レスポンス](#レスポンス)| Yes   |
|   orgMembers | List&lt;IamOrgMemberProtocol>| No | 組織IAMメンバーリスト |
|   paging | [PagingResponse](#pagingresponse)| No  |

###### IamOrgMemberProtocol

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | --------- | ------------ |
| id | String | No | IAMメンバーUUID | 
| userCode | String | Yes | ログイン時に使用するIAMメンバーID | 
| name | String | Yes | IAMメンバーのユーザー名 | 
| emailAddress | String |  Yes | IAMメンバーのメールアドレス<br>告知を受信したり、パスワード変更案内メール受信する際に使用されます |
| maskingEmail | String | No | IAMメンバーのマスキングされたメールアドレス |
| mobilePhone | String | No | IAMメンバーの携帯電話番号 |
| telephone | String | No | IAMメンバー電話番号 |
| position | String | No | 役職 |
| department | String | No | 部署名 |
| corporate | String | No | 会社名 |
| profileImageUrl | String | No | プロフィールイメージURL |
| englishName | String | No | 英語名 |
| nativeName | String | No | 母国語名 |
| nickname | String | No | ユーザーニックネーム |
| officeHoursBegin | String | No | 業務開始時間例：09:00 |
| officeHoursEnd | String | No | 業務終了時間例：18:00 |
| status | String | Yes | メンバーの状態を変更できる<br><ul><li>member:正常利用状態</li><li>leaved:退会リクエスト</li></ul>作成時には必ずmemberを指定する必要があります |
| creationType | String | No | 作成日時 |
| idProviderId | String | No | 外部認証を使用する場合、認証機関ID |
| idProviderType | String | No | service: IAM直接ログイン(デフォルト値)<br>sso:顧客SSO連動(連動されていない場合は設定不可) |
| idProviderUserId | String | No | 外部認証機関が提供したユーザーID |
| createdAt | Date | No | 作成日時 |
| lastAccessedAt | Date | No | 最終接続日時 |
| lastLoggedInAt | Date | No | 最終ログイン日時 |
| lastLoggedInIp | String | No | 最後にログインしたIP |
| passwordChangedAt | Date | No | パスワード変更日時 |
| mobilePhoneCountryCode | String | No | 携帯電話番号国コード2桁英字 |
| organizationId | String | No | IAMメンバーの組織ID |
| country | String | No | 国籍(組織Ownerの国籍) |





<a id="組織-IAM-メンバー-追加"></a>
#### 組織IAMメンバー追加

> POST "/v1/iam/organizations/{org-id}/members"

組織にIAMメンバーを追加するAPIです。

##### 必要権限
`Organization.Member.Iam.Create`


##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 組織ID | 
| Request Body | request | AddIamOrgMemberRequest| Yes | リクエスト |

###### AddIamOrgMemberRequest


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   member | [AddIamOrgMemberProtocol](#addiamorgmemberprotocol)| Yes   |


###### AddIamOrgMemberProtocol

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | --------- | ------------ |
| userCode | String | Yes | ログイン時に使用するIAMアカウントID | 
| name | String | Yes | IAMアカウントのユーザー名 | 
| emailAddress | String |  Yes | IAMアカウントのメールアドレス<br>告知を受信したりパスワード変更案内メールを受信するのに使用される |
| mobilePhone | String | No | IAMアカウントの携帯電話番号 |
| telephone | String | No | IAMアカウントの電話番号 |
| position | String | No | 役職 |
| department | String | No | 部署名 |
| corporate | String | No | 会社名 |
| profileImageUrl | String | No | プロフィールイメージURL |
| englishName | String | No | 英語名 |
| nativeName | String | No | 母国語名 |
| nickname | String | No | ユーザーニックネーム |
| officeHoursBegin | String | No | 業務開始時間例：09:00 |
| officeHoursEnd | String | No | 業務終了時間例：18:00 |
| status | String | Yes | アカウント状態を変更できる<br><ul><li>member:正常利用状態</li><li>leaved:退会リクエスト</li></ul>作成時には必ずmemberを指定する必要がある |
| creationType | String | No | 連動(sso)、招待(invited)、登録(registred) |
| mobilePhoneCountryCode | String | No | 携帯電話番号国コード2桁英字、携帯電話番号を入力する場合は必須 |



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

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#レスポンス)| Yes   |
|   uuid | String| No | IAMメンバーUUID  |




<a id="IAM-メンバー-パスワード-変更-メール-送信"></a>
#### IAMメンバーパスワード変更メール送信

> POST "/v1/iam/organizations/{org-id}/members/{member-id}/send-password-setup-mail"

IAMメンバーのパスワードを変更できるメールを送信するAPIです。

##### 必要権限
`Organization.Member.Iam.Update`


##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 対象となる組織ID | 
|  Path |member-id | String| Yes | パスワードを変更するIAMメンバーのUUID | 
| Request Body | request | SendPasswordSetupMailRequest| Yes | リクエスト |



###### SendPasswordSetupMailRequest


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | --------- | ------------ |
|   locale | String| Yes  | ユーザーのロケール情報<br>例：ko |
|   returnUrl | String| Yes  | メール変更通知メールを介してパスワードを変更した後に移動するページアドレス情報<br>移動するアドレス情報には必ずtoast.com, dooray.comまたはnhncloud.comドメインを入力する必要があります。 |


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

<a id="組織-IAM-メンバー-情報-修正"></a>
#### 組織IAMメンバー情報修正

> PUT "/v1/iam/organizations/{org-id}/members/{member-uuid}"

組織のIAMメンバー情報を修正するAPIです。

##### 必要権限
`Organization.Member.Iam.Update`

##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 	対象となる組織ID | 
|  Path |member-uuid | String| Yes | 変更するIAMメンバーのUUID | 
| Request Body | request | UpdateIamMemberRequest| Yes | リクエスト |


###### UpdateIamMemberRequest


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   member | [UpdateIamOrgMemberProtocol](#updateiamorgmemberprotocol)| Yes   |

###### UpdateIamOrgMemberProtocol

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | --------- | ------------ |
| userCode | String | Yes | ログイン時に使用するIAMアカウントID | 
| name | String | Yes | IAMアカウントのユーザー名 | 
| emailAddress | String |  Yes | IAMアカウントのメールアドレス<br>告知を受信したりパスワード変更案内メールを受信するのに使用される |
| mobilePhone | String | No | IAMアカウントの携帯電話番号 |
| telephone | String | No | IAMアカウントの電話番号 |
| position | String | No | 役職 |
| department | String | No | 部署名 |
| corporate | String | No | 会社名 |
| profileImageUrl | String | No | プロフィールイメージURL |
| englishName | String | No | 英語名 |
| nativeName | String | No | 母国語名 |
| nickname | String | No | ユーザーニックネーム |
| officeHoursBegin | String | No | 業務開始時間例：09:00 |
| officeHoursEnd | String | No | 業務終了時間例：18:00 |
| status | String | Yes | アカウント状態を変更できる<br><ul><li>member:正常利用状態</li><li>leaved:退会リクエスト</li></ul>作成時には必ずmemberを指定する必要がある |
| creationType | String | No | 連動(sso)、招待(invited)、登録(registred) |
| idProviderUserId | String | No | 外部認証機関が提供したユーザーID |
| mobilePhoneCountryCode | String | No | 携帯電話番号国コード2桁英字、携帯電話番号を入力する場合は必須 |


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

<a id="組織-IAM-メンバー-パスワード-変更"></a>
#### 組織IAMメンバーパスワード変更

> POST "/v1/iam/organizations/{org-id}/members/{member-id}/set-password"

組織IAMメンバーのパスワードを変更するAPIです。

##### 必要権限
`Organization.Member.Iam.Update`

##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 対象となる組織ID | 
|  Path |member-id | String| Yes | パスワードを変更するIAMメンバーのUUID | 
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
|   header | [共通レスポンス](#レスポンス)| Yes   |

<a id="組織-IP-ACL-リスト-照会"></a>
#### 組織IP ACLリスト照会

> GET "/v1/organizations/{org-id}/products/ip-acl"

IP ACL設定を照会するAPIです。

##### 必要権限
`Organization.Governance.IpAcl.List`

##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | 組織ID | 


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
|   header | [共通レスポンス](#レスポンス)| Yes   |
|   orgIpAcl | List&lt;OrgIpAclProtocol>| Yes  | 設定結果、空リストの場合は設定されていない状態 |

###### OrgIpAclProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | --------- | ------------ |
|   ips | List&lt;String>| Yes  | 許可IP | 
|   productId | String| Yes  | 商品ID<br>undefinedの場合、共通設定|

<a id="組織-IAM-ログイン-セッション-設定-情報を-照会"></a>
#### 組織IAMログインセッション設定情報を照会

> GET "/v1/iam/organizations/{org-id}/settings/session"

ログインセッション設定情報を照会するAPIです。

##### 必要権限
`Organization.Setting.Iam.Get`

##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 | 
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
| header | [共通レスポンス](#レスポンス)| Yes   |
| result | Content | Yes | 設定内容 |

###### Content

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   multiSessionsLimit | Integer| Yes | 許可マルチセッション数 |
|   sessionTimeoutMinutes | Integer| Yes | 	セッションタイムアウト |
|   mobileSessionTimeoutMinutes | Integer| Yes | 	モバイルセッションタイムアウト |
|   sessionType | String| Yes | fixed/idle. デフォルト値はfixed  |

<a id="組織-IAM-ログイン-2次-認証-の-設定を-照会"></a>
#### 組織IAMログイン2段階認証の設定を照会

> GET "/v1/iam/organizations/{org-id}/settings/security-mfa"

ログイン2段階認証の設定を照会するAPIです。

##### 必要権限
`Organization.Setting.Iam.Get`

##### リクエストパラメータ


| 区分 | 名前 | タイプ | 必須 | 説明 | 
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
|   header | [共通レスポンス](#レスポンス)| Yes   |
|   result | Result| No | レスポンス内容<br>設定したことがない場合はnullが返されます。 |

###### Result
| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   range | Integer| No | 組織/サービス<br>organization(共通設定), services(サービス別設定)  |
|   organizationMfaSetting | OrganizationMfaSetting| No | 組織mfa設定情報<br>共通設定 |
|   serviceMfaSettings | ServiceMfaSettings| No | サービス別mfa設定情報 |


###### OrganizationMfaSetting

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   type | String| No | mfaタイプ<br>none(設定しない), totp(Google OTP), email(メール) |
|   bypassByIp | BypassByIp| No | 例外IP  |

###### ServiceMfaSettings


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   serviceId | Sting| No | サービスID  |
|   type | String| No | mfaタイプ<br>none(設定しない), totp(Google OTP), email(メール) |
|   bypassByIp | BypassByIp| No | サービスタイプ。 none, totp, email |

###### BypassByIp

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   enable | Boolean| No | 有効化かどうか<br>true(使用中), false(使用しない)  |
|   ipList | List&lt;String>| No | 例外IPリスト |

<a id="組織-IAM-ログイン-失敗-セキュリティ-設定を-照会"></a>
#### 組織IAMログイン失敗セキュリティ設定を照会

> GET "/v1/iam/organizations/{org-id}/settings/security-login-fail"

ログイン失敗セキュリティ設定を照会するAPIです。

##### 必要権限
`Organization.Setting.Iam.Get`

##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 | 
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
| header | [共通レスポンス](#レスポンス)| Yes   |
| result | Result | No | ログイン失敗セキュリティを設定した場合のみ返され、設定しない場合はnullが返されます。 |

###### Result

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   enable | Boolean| Yes | 有効かどうか<br>true(使用中), false(使用しない)  |
|   loginFailCount | LoginFailCount| No | ログイン失敗セキュリティ設定 |


###### LoginFailCount

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   limit | Integer| No | 試行許可回数 |
|   blockMinutes | Integer| No | ログイン禁止時間 |

<a id="従量制に-登録された-商品-価格-照会"></a>
#### 従量制に登録された商品価格照会

> POST "/v1/billing/contracts/basic/products/prices/search"

カウンターに設定された単価を照会するAPIです。
言語ごとに表示名、金額計算のための種類を知ることができます。


##### 必要権限
会員であれば呼び出し可能なAPI

##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Query |limit | Integer| No |  |
| Request Body | request | GetContractProductPriceRequest| Yes | リクエスト |

##### GetContractProductPriceRequest
| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | --------- | ------------ |
|  counterNames | List&lt;String>| No | 商品メタのcounter Nameリスト<br>ない場合は全体検索する |
|   paging | Paging| No  |

###### Paging

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   limit | Integer| No | 1ページあたりの表示件数、デフォルト値20  |
|   page | Integer| No | 対象ページ、デフォルト値1  |


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
|   header | [共通レスポンス](#レスポンス)| Yes   |
|   paging | PagingResponse| Yes | ソート基準がないページング結果を返す |
|   prices | List&lt;ContractProductPriceProtocol>| Yes | カウンターの単価情報を配列で返す<br>エラー時は含まれません。  |

###### PagingResponse

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------- | ------------ |
|   limit | Integer| Yes | 照会される数制限<br>デフォルト値は20 |
|   page | Integer| Yes |
|   totalCount | Integer| Yes |

###### ContractProductPriceProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   contractDiscountPolicyId | String| Yes | 約定料金ポリシーID  |
|   contractId | String| Yes | 約定ID  |
|   counterName | String| Yes | カウンター |
|   displayNameEn | String| No | 	カウンターの英語名 |
|   displayNameJa | String| No | カウンターの日本語名 |
|   displayNameKo | String| Yes | カウンターの韓国語名 |
|   displayNameZh | String| No | 	カウンターの中国語名<br>現在は英語で表示されます |
|   monthFrom | String| Yes | 単価情報が有効な開始月(含む)  |
|   monthTo | String| Yes | 単価情報が有効な終了月(含まない)  |
|   originalPrice | BigDecimal| Yes | 単価 |
|   price | BigDecimal| Yes | 単価 |
|   rangeFrom | BigDecimal| Yes | 単価に属する使用量範囲開始(含まない)  |
|   rangeTo | BigDecimal| Yes | 単価に属する使用量範囲終了(含む)  |
|   seq | Long| Yes | シリアル番号 |
|   slidingCalculationTypeCode | String| Yes | スライディング料金計算タイプ<br>NONE, SECTION_SUM, SECTION_SELECTED |
|   useFixPriceYn | String| Yes | 固定金額かどうか(Y:固定金額、 N:単価計算)<br>Y:範囲に入る場合priceが金額になる<br>N: (使用量x単価)が金額になる |

<a id="従量制に-登録された-商品-リスト-照会"></a>
#### 従量制に登録された商品リスト照会

> GET "/v1/billing/contracts/basic/products"

請求書に表示されるメインカテゴリーとサブカテゴリー及び含まれるカウンターのリストを提供するAPIです。

##### 必要権限
会員であれば呼び出し可能なAPI

##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Query |limit | Integer| No | 照会される数制限<br>デフォルト値は20 |
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
|   header | [共通レスポンス](#レスポンス)| Yes   |
|   paging | [PagingResponse](#pagingresponse)| Yes  |
|   products | List&lt;ProductMetadata>| Yes | 商品メタ情報リスト |


###### ProductMetadata


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   budgetUsageTypeYn | String| No | 予算使用量タイプYn  Y, N |
|   calcUnitCode | String| Yes | 金額計算時に使用する単位(計量単位を精算単位に変換して金額計算を行う)、明細書に表示する単位<br>KB, MB, GB, TB, SECONDS, MINUTE, HOURS, DAYS, MB_HOURS, GB_SECONDS, GB_HOURS, GB_DAYS, CORE_SECONDS, CORE_HOURS, CORE_DAYS, USERS, MAU, MAD, DAU, CALLS, COUNTS, CCU, VCPU_HOURS, COUNT_HOURS |
|   categoryMain | String| Yes | メインカテゴリー |
|   categorySub | String| Yes | サブカテゴリー |
|   chargingTypeId | String| Yes | 課金タイプID  |
|   convertUsageTypeCode | String| Yes | 使用量変換タイプコードNONE, HOUR_AVERAGE, DAY_AVERAGE |
|   counterName | String| Yes | カウンター |
|   counterTypeCode | String| Yes | 使用量の合算方法<br><ul><li>DELTA:増加値(HOURLY_SUM)</li><li>GAUGE:時間最大値の合計(HOURLY_MAXに変更予定)</li><li>HOURLY_LATEST: 1時間の間に収集されたデータのうち、最も遅く収集されたメータリングデータの合計</li><li>DAILY_MAX:日最大値の合計</li><li>MONTHLY_MAX:月最大値</li><li>STATUS:使用状況</li><ul> |
|   description | String| No | カウンターの説明 |
|   displayOrder | Integer| Yes | 表示順序 |
|   marketPlaceMandatoryUsePeriod | Integer| No | マーケットプレイス必須使用期間 |
|   meterUnitCode | String| Yes | サービスでメータリング保存時の使用量単位<br>BYTES, KB, MB, GB, TB, CORE, HOURS, MINUTE, USERS, MAU, MAD, DAU, CALLS, COUNTS, CCU, SECONDS |
|   minUsage | BigDecimal| Yes | 最小使用量 |
|   parentCounterName | String| Yes | 親カウンター名 |
|   productId | String| Yes | 商品ID  |
|   productMetadataStatusCode | String| Yes | カウンターステータスコードSTABLE, CLOSED |
|   productUiId | String| Yes | Webサイトカテゴリー/Webサイトサービス識別ID  |
|   regionTypeCode | String| Yes | カウンターネームが所属するリージョンコード<br><ul><li>GLOBAL: Global商品に属するカウンターネーム</li><li>NONE: GLOBALと同じ意味</li><li>KR1: KR1リージョンに属するカウンターネーム</li><li>KR2: KR2リージョンに属するカウンターネーム</li><li>...:該当リージョンに属するカウンターネーム</li><ul>  |
|   unit | Long| Yes | 精算単位 |
|   unitName | String| Yes | 請求書に表示する名前 |
|   usageAggregationUnitCode | String| No | 使用量集計単位<br>RESOURCE_ID, COUNTER_NAME |


<a id="プロジェクト-AppKey-照会"></a>
#### プロジェクトAppKey照会

> GET "/v1/authentications/projects/{project-id}/project-appkeys"

プロジェクトで使用中のプロジェクトAppKeyリストを照会するAPIです。

##### 必要権限
`Project.ProjectAppKey.List`

##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | 照会対象プロジェクトID | 


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
|   header | [共通レスポンス](#レスポンス)| Yes |
|   authenticationList | List&lt;ProjectAppKeyResponse>| No | プロジェクトAppKeyリスト |

###### ProjectAppKeyResponse

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   authId | String| No | 内部的に管理する認証手段ID  |
|   appKey | String| No | コンソールに表示されるプロジェクトAppKey  |
|   authStatus | String| No | 認証ステータスコード(STABLE, STOP, BLOCKED) |
|   projectId | String| No | プロジェクトID |
|   lastUsedDatetime | Date| No | 最終使用日時 |
|   modDatetime | Date| No | 削除日時 |
|   reIssueDatetime | Date| No | 再作成日時 |
|   regDatetime | Date| No | 作成日時 |

<a id="User-Access-Key-ID-リスト-照会"></a>
#### User Access Key IDリスト照会

> GET "/v1/authentications/user-access-keys"

メンバーのUser Access Key IDリストを照会するAPIです。

##### 必要権限
会員であれば呼び出し可能なAPI


##### レスポンス本文

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
    "lastUsedDatetime": "2000-01-23T04:56:07.000+00:00",
    "reIssueDatetime": "2000-01-23T04:56:07.000+00:00",
    "regDatetime": "2000-01-23T04:56:07.000+00:00"
    "regDatetime": "2000-01-23T04:56:07.000+00:00",
    "lastTokenUsedDatetime": "2025-02-11T01:30:56.771Z",
    "validTokenCount": 0
  } ]
}
```


###### レスポンス


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#レスポンス)| Yes   |
|   authentications | List&lt;UserAccessKeyResponse>| No | 認証情報リスト |

###### UserAccessKeyResponse

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   authId | String| No | 内部的に管理する認証手段ID  |
|   userAccessKeyID | String| No | User Access Key ID  |
|   secretAccessKey | String| No | 秘密鍵(マスキング処理されます)  |
|   authStatus | String| No | 認証ステータスコード(STABLE, STOP, BLOCKED) |
|   uuid | String| No | ユーザーUUID |
|   lastUsedDatetime | Date| No | User Access Key IDで最後に認証した日時 |
|   modDatetime | Date| No | 削除日時 |
|   reIssueDatetime | Date| No | 再作成日時 |
|   regDatetime | Date| No | 作成日時 |
|   tokenExpiryPeriod | Long| No | トークン有効期限周期(秒単位)  |
|   lastTokenUsedDatetime | Long| No | トークンで最後に認証/認可した日時           |
|   validTokenCount | Long| No | 有効なトークン数                    |

<a id="プロジェクト-AppKey-登録"></a>
#### プロジェクトAppKey登録

> POST "/v1/authentications/projects/{project-id}/project-appkeys"

プロジェクトで使用するAppKeyを作成するAPIです。

##### 必要権限
`Project.ProjectAppKey.Create`


##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
| Path | project-id | String| Yes | AppKeyを登録するプロジェクトID |
| Request Body | request | AddProjectAppKeyRequest| Yes | リクエスト |

###### AddProjectAppKeyRequest

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   appkeyAlias | String | Yes   | プロジェクトAppKeyエイリアス<br>100文字制限 |


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
|   header | [共通レスポンス](#レスポンス)| Yes   |
|   authentication | ResponseProtocol| No  |

###### ResponseProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----- | ------------ |
|   authId | String| No | 内部的に管理する認証手段ID  |
|   appKey | String| No | プロジェクトAppKey |

<a id="User-Access-Key-ID-登録"></a>
#### User Access Key ID登録

> POST "/v1/authentications/user-access-keys"

メンバーのUser Access Key IDを登録するAPIです。

##### 必要権限
会員であれば呼び出し可能なAPI

##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
| Request Body | PostUserAppKeyRequest | PostUserAppKeyRequest| Yes |  | |


###### PostUserAppKeyRequest

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   tokenExpiryPeriod | Long| No | トークンの有効期限<br>秒単位で、デフォルト値は1日です。 |


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
    "tokenExpiryPeriod": 0
  }
}
```

###### レスポンス

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   header | [共通レスポンス](#レスポンス)| Yes   |
|   authentication | ResponseProtocol| No  |

###### ResponseProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----- | ------------ |
|   authId | String| No | 内部的に管理する認証手段ID  |
|   userAccessKeyID | String| No | User Access Key ID  |
|   secretAccessKey | String| No | 秘密鍵 |
|   tokenExpiryPeriod | Long| No | トークンの有効期限(秒単位) |


<a id="プロジェクト-AppKey-削除"></a>
#### プロジェクトAppKey削除

> DELETE "/v1/authentications/projects/{project-id}/project-appkeys/{app-key}"

プロジェクトAppKeyを削除するAPIです。

##### 必要権限
`Project.ProjectAppKey.Delete`


##### リクエストパラメータ


| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
| Path | project-id | String| Yes | 対象プロジェクトID |
|  Path |app-key | String| Yes | 削除するプロジェクトAppKey | 


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


<a id="User-Access-Key-ID-秘密-鍵-再発行"></a>
#### User Access Key ID秘密鍵再発行

> PUT "/v1/authentications/user-access-keys/{user-access-key-id}/secretkey-reissue"

User Access Key IDの秘密鍵を再発行するAPIです。


### 必要権限
自分のUser Access Key ID秘密鍵のみ再発行可能

##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |user-access-key-id | String| Yes | User Access Key ID | 
| Request Body | request | ReissueSecretKeyRequest| Yes | リクエスト |


###### ReissueSecretKeyRequest

| 名前 | タイプ   | 必須 | 説明                                             |   
|------------ |---------|----|---------------------------------------------------|
|   needExpireTokens | Boolean | No | 発行されたトークンが期限切れかどうか(true:期限切れ、false:期限切れではない)<br>デフォルト値false |


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
|   header | [共通レスポンス](#レスポンス)| Yes |
|   authentication | ResponseProtocol| No  |

###### ResponseProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ----------- | ------------ |
|   secretAccessKey | String| Yes   | 秘密鍵 |

<a id="User-Access-Key-ID-状態-修正"></a>
#### User Access Key ID状態の修正

> PUT "/v1/authentications/user-access-keys/{user-access-key-id}"

メンバーのUser Access Key IDの状態を変更するAPIです。

### 必要権限
自分のUser Access Key IDのみ修正可能

##### リクエストパラメータ


| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path | user-access-key-id | String| Yes | User Acess Key ID | 
| Request Body | request | UpdateUserAccessKeyStatusRequest| Yes | リクエスト |


###### UpdateUserAccessKeyStatusRequest

| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   status | String| Yes | 変更するプロジェクトAppKey状態(STOP:停止、 STABLE:使用) |

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

<a id="User-Access-Key-ID-削除"></a>
#### User Access Key ID削除

> DELETE "/v1/authentications/user-access-keys/{user-access-key-id}"

User Access Key IDを削除するAPIです。

##### 必要権限
自分のUser Access Key IDのみ削除可能

##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 | 
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
|   header | [共通レスポンス](#レスポンス)| Yes |


<a id="トークン-リスト-照会"></a>
#### トークンリスト照会

> GET "/v1/authentications/user-access-keys/{user-access-key-id}/tokens"
User Access Key IDで発行したトークンリストを照会するAPIです。

##### 必要権限
自分のUser Access Key IDで発行したトークンのみ照会可能

##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明                                                                        | 
|------------- |------------- | ------------- |-----|------------------------------------------------------------------------------| 
|  Path | user-access-key-id | String| Yes | User Access Key ID                                                           | 
|  Query | token | String| No  | トークン専門<br>部分検索はサポートしない                                                    | 
|  Query | status | String| No  | トークン状態<br>ACTIVE:有効、EXPIRED:期限切れ                                           | 
|  Query | lastAccessDatetimeFrom | Date| No  | トークンの最終使用日時<br>指定した時間より大きいか同じ時間に使用されたトークンを照会<br>例：`2025-02-11T00:56:50.902Z` | 
|  Query | expireDatetimeFrom | Date| No  | トークン有効期限<br>指定した時間より大きいか同じ時間に期限切れになったトークンを照会<br>例：`2025-02-11T00:56:50.902Z`   | 
|  Query | regDatetimeFrom | Date| No  | トークン登録日時<br>指定した時間より大きいか同じ時間に作成されたトークンを照会<br>例：`2025-02-11T00:56:50.902Z`   |
|  Query | page | Integer| No  | 対象ページ<br>デフォルト値1                                                                |
|  Query | limit | Integer| No  | 1ページあたりの表示件数<br>デフォルト値20                                                            |



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


| 名前 | タイプ        | 必須 | 説明              |   
|------------ |--------------|-----|--------------------|
|   header | [共通レスポンス](#レスポンス) | Yes |
|   paging | [PagingResponse](#pagingresponse)| Yes  |
|   accessToken | String       | Yes | マスキング処理されたトークン      |
|   expireDatetime | Date         | No  | トークン有効期限           |
|   lastAccessDatetime | Date         | Yes | トークンで最後に認証/認可した日時 |
|   regDatetime | Date         | Yes | トークン作成日時        |
|   status | String       | Yes | トークン状態           |
|   tokenId | Long         | Yes | トークンID              |


<a id="トークン-複数-期限切れ"></a>
#### トークン複数期限切れ

> DELETE "/v1/authentications/user-access-keys/{user-access-key-id}/tokens"
User Access Key IDで発行したトークンを複数期限切れにするAPIです。<br>
リクエストでトークンIDとトークンリストが全て空の状態であれば、そのUser Access Key IDで発行された全てのトークンが期限切れになります。
トークンIDとトークンリストの両方が存在する場合、両方が一致するトークンだけが削除され、<br>
リクエストに含まれるUser Access Key IDの所有者以外のユーザーが呼び出すと、トークンは期限切れになりません。

##### 必要権限
自分のUser Access Key IDで発行したトークンのみ期限切れにすることができます

##### リクエストパラメータ

| 区分        | 名前              | タイプ           | 必須 | 説明              | 
|--------------|--------------------|-----------------|-----|--------------------| 
| Path         | user-access-key-id | String          | Yes | User Access Key ID | 
| Request Body | tokenIds           | List&lt;Long>   | No  | トークンIDリスト        | 
| Request Body         | tokens             | List&lt;String> | No   | トークンリスト       | 

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
|   header | [共通レスポンス](#レスポンス)| Yes |


<a id="プロジェクト-IAM-アカウント-作成"></a>
#### プロジェクトIAMアカウント作成

> POST "/v1/iam/projects/{project-id}/members"
IAMアカウントをプロジェクトメンバーとして追加するAPIです。

##### 必要権限
`Project.Member.Iam.Create`

##### リクエストパラメータ



| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | メンバーを追加するプロジェクトID | 
| Request Body | request | AddIamProjectMemberRequest| Yes | リクエスト |




###### AddIamProjectMemberRequest
> 注意<br>
> 1つのリクエストで1名のプロジェクトメンバーを作成できます。

| 名前 | タイプ | 必須 | 説明 |  
|------------ | ------------- | ------------- | ------------ |
|   assignRoles | List&lt;UserAssignRoleProtocol>| Yes | ユーザーに割り当てるロールリスト |
|   memberUuid | String| Yes | 追加するメンバーのUUID  |


###### UserAssignRoleProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   roleId | String| Yes | ロールID  |
|   conditions | List&lt;AssignAttributeConditionProtocol>| No | ロール条件属性 |


###### AssignAttributeConditionProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   attributeId | String| Yes | 条件属性ID  |
|   attributeOperatorTypeCode | String| Yes | 条件属性演算子<br>条件属性のデータ型によって使用できる演算子が異なります。<br><ul><li>ALLOW</li><li>ALL_CONTAINS</li><li>ANY_CONTAINS</li><li>ANY_MATCH</li><li>BETWEEN</li><li>BEYOND</li><li>FALSE</li><li>GREATER_THAN</li><li>GREATER_THAN_OR_EQUAL_TO</li><li>LESS_THAN</li><li>LESS_THAN_OR_EQUAL_TO</li><li>NONE_MATCH</li><li>NOT_ALLOW</li><li>NOT_CONTAINS</li><li>TRUE</li></ul>  |
|   attributeValues | List&lt;String>| Yes | 条件属性値 |


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


| 名前 | タイプ         | 必須 | 説明 |   
|------------ |--------------| ------- | ------------ |
|   header | [共通レスポンス](#レスポンス) | Yes |


<a id="プロジェクト-IAM-アカウント-一括-削除"></a>
#### プロジェクトIAMアカウント一括削除

> DELETE "/v1/iam/projects/{project-id}/members"
IAMアカウントを該当プロジェクトから削除するAPIです。

##### 必要権限
`Project.Member.Iam.Delete`

##### リクエストパラメータ



| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | プロジェクトID | 
|  Request Body |request | DeleteMembersRequest | Yes | リクエスト | 


###### DeleteMembersRequest


| 名前 | タイプ | 必須 | 説明 |  
|------------ | ------------- | ------------- | ------------ |
|   memberUuids | List&lt;String>| Yes | 削除する対象アカウントのUUIDリスト |


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
|   header | [共通レスポンス](#レスポンス)| Yes |


<a id="プロジェクト-IAM-アカウント-単件-照会"></a>
#### プロジェクトIAMアカウント単件照会

> GET "/v1/iam/projects/{project-id}/members/{member-uuid}"
プロジェクトに所属する特定IAMアカウントを照会するAPIです。

##### 必要権限
`Project.Member.Iam.Get`

##### リクエストパラメータ



| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | メンバーを照会するプロジェクトID |
|  Path |member-uuid | String| Yes | 照会するメンバーUUID |




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
|   header | [共通レスポンス](#レスポンス)| Yes |
|   projectMember | ProjectIamMemberRoleBundleProtocol| Yes  | 追加されたメンバー情報、エラー時は含まれません。 |


###### ProjectMemberRoleBundleProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   uuid | String| Yes | メンバーUUID  |
|   id | String| Yes | ID  |
|   name | String| No | 名前 |
|   emailAddress | String| No | メンバーメールアドレス |
|   maskingEmail | String| No | メンバーのマスキングされたメールアドレス |
|   mobilePhone | String| No | 電話番号 |
|   relationDateTime | Date| No | メンバー追加時間 |
|   joinYmdt | Date| No | 加入日時 |
|   recentLoginYmdt | Date| No | 最近のログイン日時 |
|   recentPasswordModifyYmdt | Date| No | 最近のパスワード変更日時 |
|   roles | List&lt;RoleBundleProtocol>| No | 関連ロールリスト(条件属性含む)  |


[RoleBundleProtocol](#rolebundleprotocol)



<a id="プロジェクト-IAM-アカウント-リスト-照会"></a>
#### プロジェクトIAMアカウントリスト照会

> GET "/v1/iam/projects/{project-id}/members"
プロジェクトに所属するIAMアカウントリストを照会するためのAPIです。

##### 必要権限
`Project.Member.Iam.List`

##### リクエストパラメータ


| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | 照会するプロジェクトID | 
|  Query |limit | Integer| No | 1ページあたりの表示件数、デフォルト値20 |
|  Query |page | Integer| No | 対象ページ、デフォルト値1 |





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
|   header | [共通レスポンス](#レスポンス)| Yes |
|   paging | [PagingResponse](#pagingresponse)| Yes  |
|   projectMembers | List&lt;IamProjectMemberProtocol>| Yes | プロジェクトメンバーリスト |



###### IamProjectMemberProtocol


| 名前 | タイプ | 必須 | 説明 |   
|------------ | ------------- | ------------- | ------------ |
|   uuid | String| Yes | メンバーUUID  |
|   id | String| Yes | ID  |
|   name | String| No | 名前 |
|   emailAddress | String| No | メンバーメールアドレス |
|   maskingEmail | String| No | メンバーのマスキングされたメール |
|   mobilePhone | String| No | 電話番号 |
|   relationDateTime | Date| No | メンバー追加時間 |
|   joinYmdt | Date| No | 加入日時 |
|   recentLoginYmdt | Date| No | 最近のログイン日時 |
|   recentPasswordModifyYmdt | Date| No | 最近のパスワード変更日時 |


<a id="プロジェクト-IAM-アカウント-ロール-修正"></a>
#### プロジェクトIAMアカウントロール修正

> PUT "/v1/iam/projects/{project-id}/members/{member-uuid}"
プロジェクトで指定したIAMアカウントのロールを変更するAPIです。

##### 必要権限
`Project.Member.Iam.Update`

##### リクエストパラメータ

| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |project-id | String| Yes | プロジェクトID | 
|  Path |member-uuid | String| Yes | ロール変更対象メンバーUUID | 
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


<a id="組織-下位-メンバーの-全ての-認証情報-リスト-照会"></a>
#### 組織下位メンバー認証情報リスト照会

> GET "/v1/authentications/organizations/{org-id}/user-access-keys"
組織に所属するメンバー及びプロジェクトメンバーの認証情報を照会するAPIです。

##### 必要権限
`Organization.UserAccessKey.List`

##### リクエストパラメータ



| 区分 | 名前 | タイプ | 必須 | 説明 | 
|------------- |------------- | ------------- | ------------- | ------------- | 
|  Path |org-id | String| Yes | UserAccessKeyを照会する組織ID |
|  Query |paging | Paging| No | 1ページあたりの表示件数、デフォルト値20 |




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
|   header | [共通レスポンス](#レスポンス)| Yes |
|   paging | [PagingResponse](#pagingresponse)| Yes  |
|   authenticationList | List&lt;UserAccessKeyResponseV7>| Yes  | メンバーごとの認証キー情報 |


###### UserAccessKeyResponseV7

| 名前 | タイプ | 必須 | 説明 |
|------------|--------|------|-----------------------------|
| authId | String | Yes | 認証手段ID(マスキング処理) |
| uuid | String | Yes | ユーザーUUID |
| userAccessKeyID | String | Yes | User Access Key ID(マスキング処理) |
| secretAccessKey | String | No | 秘密鍵(空白処理) |
| authStatusCode | String | Yes | 認証ステータスコード(STABLE, STOP, BLOCKED) |
| tokenExpiryPeriod | Long | No | トークン有効期限 |
| regDatetime | Date | No | 作成日時 |
| modDatetime | Date | No | 削除日時 |
| lastUsedDatetime | Date | No | 最終使用日時 |
| reIssueDatetime | Date | No | secretAccessKey再作成日時 |
| lastTokenUsedDatetime | Date | No | トークン最終使用日時 |
| validTokenCount | Long | No | 有効なトークン数 |




### エラーコード

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
| 30015 | プロジェクトAppKeyの作成制限回数を超えた場合に発生するエラー <br> プロジェクトAppKey API - `プロジェクトAppKey作成`で作成されるプロジェクトAppKeyの作成可能回数は3つで、3つを超えるとエラー発生 | 使用しないプロジェクトAppKeyを削除して再試行                           |
| 40017 | プロジェクトが存在しない場合に発生するエラー                                                       | 存在するプロジェクトに対してAPIリクエスト                               |
| 40028<br>13003 | プロジェクトが存在しない場合(作成した後に削除した場合)発生するエラー                                          | 存在するプロジェクトに対してAPIリクエスト                               |
| 40054 | サービスを有効化する際、先に有効化されるべきサービスが有効化されていない場合に発生するエラー                           | 先に有効化されるべきサービスの有効化処理                           |
| 40057 | サービスを無効化する際、先に無効化されるべきサービスが無効化されていない場合に発生するエラー                           | 先に無効化されるべきサービスの無効化処理                           |
| 50007 | 有効ではないメンバーの場合に発生するエラー<br>(存在しないメンバー、休眠及び退会状態のメンバーは無効)<br>組織作成API - API呼び出し時、 uuidが有効ではない場合 | 有効なメンバーのuuidに修正                             |
| 60003 | DBにデータがない場合に発生するエラー<br>プロジェクトAppKey API - `プロジェクトAppKey削除`で削除するAppKeyがない場合に発生するエラー | 1)担当者にお問い合わせください <br>2)存在するAppKeyを削除対象AppKey値として設定 |
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
