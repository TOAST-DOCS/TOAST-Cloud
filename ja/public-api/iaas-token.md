# IaaSトークン

**NHN Cloud > Public API使用ガイド > API認証方式 > IaaSトークン**

IaaSトークンは、NHN CloudのOpenStackベースのインフラサービス(IaaS)で使用する認証トークンです。Keystone認証サーバーを通じて発行され、Compute、Block Storage、Networkなどのインフラリソース制御APIを呼び出す際に使用します。

## 事前作業
### APIエンドポイントの確認

NHN Cloudの基本インフラサービスAPIは、タイプとリージョンごとにエンドポイントが分かれています。ただし、Identity APIは全てのリージョンで同一のエンドポイントを使用します。

| タイプ        | リージョン                                                | エンドポイント                                            |
| ------------ | ---------------------------------------------------- | ------------------------------------------------------- |
| identity     | 全リージョン                                            | https://api-identity-infrastructure.nhncloudservice.com |
| compute      | 韓国(パンギョ)リージョン<br>韓国(ピョンチョン)リージョン<br>日本(東京)リージョン<br>米国(カリフォルニア)リージョン | https://kr1-api-instance-infrastructure.nhncloudservice.com<br>https://kr2-api-instance-infrastructure.nhncloudservice.com<br>https://jp1-api-instance-infrastructure.nhncloudservice.com<br>https://us1-api-instance-infrastructure.nhncloudservice.com |
| network      | 韓国(パンギョ)リージョン<br>韓国(ピョンチョン)リージョン<br>日本(東京)リージョン<br>米国(カリフォルニア)リージョン | https://kr1-api-network-infrastructure.nhncloudservice.com<br>https://kr2-api-network-infrastructure.nhncloudservice.com<br>https://jp1-api-network-infrastructure.nhncloudservice.com<br>https://us1-api-network-infrastructure.nhncloudservice.com |
| image        | 韓国(パンギョ)リージョン<br>韓国(ピョンチョン)リージョン<br>日本(東京)リージョン<br>米国(カリフォルニア)リージョン | https://kr1-api-image-infrastructure.nhncloudservice.com<br>https://kr2-api-image-infrastructure.nhncloudservice.com<br>https://jp1-api-image-infrastructure.nhncloudservice.com<br>https://us1-api-image-infrastructure.nhncloudservice.com |
| volumev2     | 韓国(パンギョ)リージョン<br>韓国(ピョンチョン)リージョン<br>日本(東京)リージョン<br> | https://kr1-api-block-storage-infrastructure.nhncloudservice.com<br>https://kr2-api-block-storage-infrastructure.nhncloudservice.com<br>https://jp1-api-block-storage-infrastructure.nhncloudservice.com<br>https://us1-api-block-storage-infrastructure.nhncloudservice.com |
| nasv1        | 韓国(パンギョ)リージョン<br>韓国(ピョンチョン)リージョン                    | https://kr1-api-nas-infrastructure.nhncloudservice.com<br>https://kr2-api-nas-infrastructure.nhncloudservice.com |
| object-store | 韓国(パンギョ)リージョン<br>韓国(ピョンチョン)リージョン<br>日本(東京)リージョン<br> | https://kr1-api-object-storage.nhncloudservice.com<br>https://kr2-api-object-storage.nhncloudservice.com<br>https://jp1-api-object-storage.nhncloudservice.com<br>https://us1-api-object-storage.nhncloudservice.com |
| key-manager  | 韓国(パンギョ)リージョン<br>韓国(ピョンチョン)リージョン<br>日本(東京)リージョン<br> | https://kr1-api-key-manager-infrastructure.nhncloudservice.com<br>https://kr2-api-key-manager-infrastructure.nhncloudservice.com<br>https://jp1-api-key-manager-infrastructure.nhncloudservice.com<br>https://us1-api-key-manager-infrastructure.nhncloudservice.com |

### テナントIDの確認

APIリクエストに含まれるテナントIDは、**Compute > Instance** ページの **APIエンドポイント設定** で確認します。

### APIパスワード設定

NHN Cloudの基本インフラサービスAPIを使用するには、NHN Cloudアカウントのパスワードとは別にAPIパスワードを設定する必要があります。APIパスワードはアカウントごとに作成されます。あるプロジェクトで設定されたパスワードは、ユーザーが所属する全てのプロジェクトで使用できます。

1) **Compute > Instance** ページの **APIエンドポイント設定**をクリックします。

![C_IaaS_apiendpointsettings_ja](http://static.toastoven.net/toast/public_api/C_IaaS_apiendpointsettings_ja.png)

2) **APIエンドポイント設定** モーダルウィンドウ下部の **APIパスワード設定** で任意のAPIパスワードを指定します。

![C_IaaS_setapipassword_0_ja](http://static.toastoven.net/toast/public_api/C_IaaS_setapipassword_0_ja.png)


!!! tip "参考"
    * 現在使用中のパスワードには変更できません。
    * APIパスワード変更時、既存の認証トークンは使用できなくなるため、再発行が必要です。


## IaaSトークンの発行リクエスト

トークン発行は `identity` タイプのエンドポイントを利用します。`identity` サービスのエンドポイントは、リージョンに関係なく `https://api-identity-infrastructure.nhncloudservice.com` です。<br>
APIを呼び出す際に必要なトークンを発行します。NHN Cloudではプロジェクト限定トークン(project-scoped token)を使用します。


!!! danger "注意"
    * ユーザーがプロジェクトでの権限を失った場合、該当のクレデンシャルは無効となり使用できません。
    * NHN Cloudを退会してアカウントが削除された場合、そのアカウントで発行した全てのクレデンシャルは無効となり使用できません。


```
POST /v2.0/tokens
```


### リクエスト

| 名前                | 区分 | タイプ  | 必須 | 説明                                       |
| ------------------- | ---- | ------ | ---- | ------------------------------------------ |
| tenantId            | Body | String | O    | トークンを発行するテナントID                  |
| passwordCredentials | Body | Object | O    | 認証のためのユーザー情報オブジェクト                |
| username            | Body | String	| O    | NHN CloudアカウントID(メール形式)、IAMアカウントID |
| password            | Body | String	| O    | APIパスワード                               |

 
<details><summary>例</summary>
<p>

```json
{
    "auth": {
        "tenantId": "f5073eaa26b64cffbee89411df94ce01",
        "passwordCredentials": {
            "username": "user@example.com",
            "password": "secretsecret"
        }
    }
}
```

</p>
</details>


### レスポンス

| 名前 | 種類 | 属性 | 説明 |
|---|---|---|---|
| access | Body | Object | `access` オブジェクト |
| access.token | Body | Object | `token` オブジェクト |
| access.token.issued_at | Body | Datetime | トークン発行時刻(UTC)<br>`YYYY-MM-DDThh:mm:ss.SSSSSS`の形式 |
| access.token.expires | Body | Datetime | トークン有効期限(UTC)<br>`YYYY-MM-DDThh:mm:ssZ`の形式 |
| access.token.id | Body | String | トークンID |
| access.token.tenant | Body | Object | `tenant` オブジェクト |
| access.token.tenant.description | Body | String | テナント説明 |
| access.token.tenant.enabled | Body | String | テナントの有効化状態<br>有効化されていない場合、トークン発行及びAPI呼び出し不可 |
| access.token.tenant.id | Body | String | テナントID |
| access.token.tenant.name | Body | String | テナント名 |
| access.serviceCatalog | Body | Object | `serviceCatalog` オブジェクト |
| access.serviceCatalog.endpoints | Body | Object | `endpoint` オブジェクト |
| access.serviceCatalog.endpoints_links | Body | String | エンドポイントリンク |
| access.serviceCatalog.type | Body | String | エンドポイントサービスタイプ |
| access.serviceCatalog.name | Body | String | エンドポイントサービス名 |
| access.user | Body | Object | `user` オブジェクト |
| access.metadata | Body | Object | `metadata` オブジェクト |


<details><summary>例</summary>
<p>

```json
{
  "access": {
    "token": {
      "id": "e42a092ed6ee4d99949bf25f5f6ecc60",
      "expires": "2020-04-29T15:31:21Z",
      "tenant": {
        "id": "f5073eaa26b64cffbee89411df94ce01",
        "name": "c_VKkasVsh",
        "groupId": "XEj2zkHrbA7modGU",
        "description": "",
        "enabled": true,
        "project_domain": "NORMAL"
      },
      "issued_at": "2020-04-29T03:32:28.000405"
    },
    "serviceCatalog": [
      {
        "endpoints": [
          {
            "region": "KR2",
            "publicURL": "https://kr2-api-instance-infrastructure.nhncloudservice.com/v2/f5073eaa26b64cffbee89411df94ce01"
          },
          {
            "region": "KR1",
            "publicURL": "https://kr1-api-instance-infrastructure.nhncloudservice.com/v2/f5073eaa26b64cffbee89411df94ce01"
          }
        ],
        "type": "compute",
        "name": "nova"
      },
      {
        "endpoints": [
          {
            "region": "KR2",
            "publicURL": "https://kr2-api-image-infrastructure.nhncloudservice.com"
          },
          {
            "region": "KR1",
            "publicURL": "https://kr1-api-image-infrastructure.nhncloudservice.com"
          }
        ],
        "type": "image",
        "name": "glance"
      },
      {
        "endpoints": [
          {
            "region": "KR1",
            "publicURL": "https://api-identity-infrastructure.nhncloudservice.com/v2.0"
          }
        ],
        "type": "identity",
        "name": "keystone"
      },
      {
        "endpoints": [
          {
            "region": "KR2",
            "publicURL": "https://kr2-api-key-manager-infrastructure.nhncloudservice.com"
          },
          {
            "region": "KR1",
            "publicURL": "https://kr1-api-key-manager-infrastructure.nhncloudservice.com"
          }
        ],
        "type": "key-manager",
        "name": "barbican"
      },
      {
        "endpoints": [
          {
            "region": "KR2",
            "publicURL": "https://kr2-api-block-storage-infrastructure.nhncloudservice.com/v2/f5073eaa26b64cffbee89411df94ce01"
          },
          {
            "region": "KR1",
            "publicURL": "https://kr1-api-block-storage-infrastructure.nhncloudservice.com/v2/f5073eaa26b64cffbee89411df94ce01"
          }
        ],
        "type": "volumev2",
        "name": "cinderv2"
      },
      {
        "endpoints": [
          {
            "region": "KR2",
            "publicURL": "https://kr2-api-network-infrastructure.nhncloudservice.com"
          },
          {
            "region": "KR1",
            "publicURL": "https://kr1-api-network-infrastructure.nhncloudservice.com"
          }
        ],
        "type": "network",
        "name": "neutron"
      }
    ],
    "user": {
      "id": "436f727b7c9142f896ddd56be591dd7f",
      "username": "37be6ac0-d660-11e7-ae46-005056ac1497",
      "name": "37be6ac0-d660-11e7-ae46-005056ac1497",
      "roles": [
        {
          "name": "project_admin"
        }
      ],
      "roles_links": []
    },
    "metadata": {
      "roles": [
        "9fe2ff9ee4384b1894a90878d3e92bab"
      ],
      "is_admin": 0
    }
  }
}
```

</p>
</details>


## IaaSトークンの使用

IaaSトークンはHTTPリクエストヘッダに含めて送信します。API呼び出し時、以下の例のようにリクエストヘッダにIaaSトークンを設定して呼び出してください。

* HTTPヘッダ形式の例
```
X-Auth-Token: {IaaS Token}
```

ユーザーがHTTPヘッダにトークンを含めてサーバーにリクエストを送信すると、サーバーはトークンの有効性を確認した後、リクエストを承認または拒否します。
