# パートナー管理APIガイド

**NHN Cloud > Public API > パートナー管理APIガイド**

## パートナー管理APIの共通情報

### APIエンドポイント

パートナー管理APIを呼び出すためのエンドポイント情報です。<br>
パートナーまたはパートナーから権限を付与されたユーザーのみが呼び出し可能なAPIであり、一般ユーザーは使用できません。

| リージョン  | エンドポイント |
|--------| ----- |
| Global | https://core.api.nhncloudservice.com/ |

### 認証及び権限

パートナー管理APIを使用するには、以下の認証ヘッダが必要です。

| ヘッダ名 | 説明 |
| --- | --- |
| x-nhn-authorization | API認証のためのトークン([API認証](api-authentication.md)を参照) |

### レスポンス共通情報

全てのAPIは、以下の共通のレスポンス構造を持ちます。

<details>
  <summary><strong>成功レスポンス</strong></summary>

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "SUCCESS"
  }
}
```

</details>

<details>
  <summary><strong>失敗レスポンス</strong></summary>

```json
{
  "header": {
    "isSuccessful": false,
    "resultCode": 400,
    "resultMessage": "Invalid parameter"
  }
}
```

</details>

| 名前 | 型 | 説明 |
| --- | --- | --- |
| header.isSuccessful | Boolean | 成否 |
| header.resultCode | Integer | 結果コード(成功時: 0) |
| header.resultMessage | String | 結果メッセージ |

!!! warning "APIレスポンスフィールドの拡張性"
    APIレスポンスには、以下に明記されていないフィールドが追加されることがあります。新しいフィールドが追加されてもエラーが発生しないように注意してください。


## パートナーユーザーの組織使用量一覧の照会

パートナーユーザーの請求金額、組織別使用金額、商品別使用金額、割増情報を提供します。

!!! tip "パートナー契約の検証"
    当該パートナーとパートナーユーザーが、指定された月にパートナー契約を結んでいた状態であるかを確認します。

!!! tip 「ポイント」
    利用月はyyyy-MM形式で入力する必要があります。

### 必要な権限
`Partner.Payment.Get`

### リクエスト

```
GET /v1/billing/partners/{partnerId}/payments/{month}
```

### リクエストパラメータ

| 名前 | 区分 | 型 | 必須 | 説明 |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | パートナーID |
| month | Path | String | Y | 利用月(yyyy-MM形式) |
| partnerUserUuid | Query | String | Y | パートナーユーザーUUID |
| lang | Header | String | N | 言語設定(デフォルト: ko_KR、設定可能な値: ko_KR、ja_JP、en_US) |

### リクエストボディ

このAPIはリクエストボディを要求しません。

### レスポンス

<details>
  <summary><strong>レスポンス例</strong></summary>

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "SUCCESS"
  },
  "payment": {
    "charge": 100000,
    "totalAmount": 110000,
    "taxAmount": 10000,
    "currency": "KRW",
    "orgList": [
      {
        "orgName": "テスト組織",
        "charge": 100000
      }
    ],
    "usageSummaryList": [
      {
        "categoryMain": "COMPUTE",
        "categorySub": "INSTANCE",
        "counterName": "c2.small",
        "displayName": "c2.smallインスタンス",
        "displayOrder": 1,
        "price": 50000,
        "usage": 100.0
      }
    ],
    "extraSummaryList": [
      {
        "description": "プロジェクト割増",
        "extraPrice": 5000
      }
    ]
  }
}
```

</details>

#### 基本レスポンス構造

| 名前 | 型 | 説明 |
| --- | --- | --- |
| payment | Object | 決済情報 |
| payment.charge | Long | 使用金額 + プロジェクト割増金額 |
| payment.totalAmount | Long | 請求金額(使用金額 + 付加税額) |
| payment.taxAmount | Long | 付加税額 |
| payment.currency | String | 通貨<br>langに応じて該当言語で返されます |
| payment.orgList | List&lt;Object&gt; | 組織別使用量一覧 |
| payment.usageSummaryList | List&lt;Object&gt; | 使用量要約一覧 |
| payment.extraSummaryList | List&lt;Object&gt; | プロジェクト割増要約一覧 |

**orgList**

| 名前 | 型 | 説明 |
| --- | --- | --- |
| orgName | String | 組織名 |
| charge | Long | 組織別使用金額 |

**usageSummaryList**

| 名前 | 型 | 説明 |
| --- | --- | --- |
| categoryMain | String | メインカテゴリー |
| categorySub | String | サブカテゴリー |
| counterName | String | カウンター名 |
| displayName | String | 課金単位表示名(ロケール別) |
| displayOrder | Integer | 表示順 |
| price | Long | 利用金額(パートナー用のため、契約金額は提供されません) |
| productUiId | String | WebサイトサービスUI ID |
| usage | BigDecimal | 使用量 |

**extraSummaryList**

| 名前 | 型 | 説明 |
| --- | --- | --- |
| description | String | 割増の説明 |
| extraPrice | Long | プロジェクト割増金額 |


## パートナーユーザーの組織一覧の照会

パートナーユーザーの組織一覧を照会します。

!!! tip "パートナー契約の検証"
    当該パートナーとパートナーユーザーが、指定された月にパートナー契約を結んでいた状態であるかを確認します。

### 必要な権限
`Partner.Organization.List`

### リクエスト

```
GET /v1/billing/partners/{partnerId}/payments/{month}/organizations
```

### リクエストパラメータ

| 名前 | 区分 | 型 | 必須 | 説明 |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | パートナーID |
| month | Path | String | Y | 利用月(yyyy-MM形式) |
| partnerUserUuid | Query | String | Y | パートナーユーザーUUID |

### リクエストボディ

このAPIはリクエストボディを要求しません。

### レスポンス

<details>
  <summary><strong>レスポンス例</strong></summary>

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "SUCCESS"
  },
  "organizations": [
    {
      "orgId": "org123",
      "orgName": "テスト組織",
      "orgStatusCode": "STABLE",
      "orgCreationType": "USER",
      "cloudType": "PUBLIC"
    }
  ]
}
```

</details>

| 名前 | 型 | 説明 |
| --- | --- | --- |
| organizations | List&lt;Object&gt; | 組織一覧 |
| organizations[].orgId | String | 組織ID |
| organizations[].orgName | String | 組織名 |
| organizations[].orgStatusCode | String | 組織ステータス(STABLE:正常、CLOSED:削除済み) |
| organizations[].orgCreationType | String | 組織作成タイプ(USER:お客様が作成した組織、SYSTEM:システムが作成した組織) |
| organizations[].cloudType | String | クラウドタイプ |


## パートナーユーザーの組織別請求金額の照会

特定組織の詳細な利用金額、割引及び割増金額を照会します。

!!! tip "パートナー契約の検証"
    当該パートナーとパートナーユーザーが指定された月にパートナー契約を結んでいたか、また当該組織のオーナーがその月にパートナーユーザーであったかを確認します。

### 必要な権限
`Partner.Organization.Usage.Get`

### リクエスト

```
GET /v1/billing/partners/{partnerId}/payments/{month}/organizations/{orgId}/usage
```

### リクエストパラメータ

| 名前 | 区分 | 型 | 必須 | 説明 |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | パートナーID |
| month | Path | String | Y | 利用月(yyyy-MM形式) |
| orgId | Path | String | Y | 組織ID |
| lang | Header | String | N | 言語設定(デフォルト: ko_KR、設定可能な値: ko_KR、ja_JP、en_US) |

### リクエストボディ

このAPIはリクエストボディを要求しません。

### レスポンス

<details>
  <summary><strong>レスポンス例</strong></summary>

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "SUCCESS"
  },
  "org": {
    "orgId": "org123",
    "orgName": "テスト組織",
    "totalAmount": 95000,
    "usagePrice": 100000,
    "contractUsagePrice": 95000,
    "contractDiscountPrice": 5000,
    "contractExtraPrice": 0,
    "totalCredit": 0,
    "country": "KR",
    "creditUsages": [
      {
        "balanceTypeCode": "FREE_CREDIT",
        "balanceTypeName": "無料クレジット",
        "i18nBalanceTypeNameMap": {
          "ko_KR": "無料クレジット",
          "en_US": "Free Credit"
        },
        "usageAmount": 5000
      }
    ],
    "projectDiscount": {
      "totalAdjustment": 5000,
      "details": [
        {
          "projectId": "project123",
          "projectName": "テストプロジェクト",
          "adjustment": 5000,
          "adjustmentTypeCode": "CONTRACT_DISCOUNT",
          "description": "契約割引"
        }
      ]
    },
    "projectExtra": {
      "totalAdjustment": 0,
      "details": []
    },
    "projects": [
      {
        "projectId": "project123",
        "projectName": "テストプロジェクト",
        "totalAmount": 95000,
        "usagePrice": 100000,
        "contractUsagePrice": 95000
      }
    ]
  }
}
```

</details>

#### 基本レスポンス構造

| 名前 | 型 | 説明 |
| --- | --- | --- |
| org | Object | 組織情報 |
| org.orgId | String | 組織ID |
| org.orgName | String | 組織名 |
| org.totalAmount | Long | 組織の最終金額 |
| org.usagePrice | Long | 利用金額 |
| org.contractUsagePrice | Long | 契約割引/割増が適用された利用金額の合計 |
| org.contractDiscountPrice | Long | 契約による割引額 |
| org.contractExtraPrice | Long | 契約による割増額 |
| org.totalCredit | Long | クレジットの最終金額 |
| org.country | String | 国コード |
| org.creditUsages | List&lt;Object&gt; | クレジット使用金額 |
| org.projectDiscount | Object | プロジェクト別割引詳細履歴一覧 |
| org.projectExtra | Object | プロジェクト別割増詳細履歴一覧 |
| org.projects | List&lt;Object&gt; | プロジェクト一覧 |

**creditUsages**

| 名前 | 型 | 説明 |
| --- | --- | --- |
| balanceTypeCode | String | キャンペーンタイプ |
| balanceTypeName | String | キャンペーンタイプ名 |
| i18nBalanceTypeNameMap | Object | キャンペーンタイプ名の多言語コード |
| usageAmount | Long | クレジット使用金額 |

**projectDiscount**

| 名前 | 型 | 説明 |
| --- | --- | --- |
| totalAdjustment | Long | 割引金額の合計 |
| details | List&lt;Object&gt; | 詳細履歴 |
| details[].projectId | String | プロジェクトID |
| details[].projectName | String | プロジェクト名 |
| details[].adjustment | Long | 割引金額 |
| details[].adjustmentTypeCode | String | 割引タイプ<br>- CONTRACT_EXTRA:契約割増<br>- CONTRACT_PENALTY:契約違約金<br>- CONTRACT_DISCOUNT:契約割引<br>- CONTRACT_PAYBACK:パートナーペイバック<br>- STATIC_EXTRA:固定金額割増<br>- PERCENT_DISCOUNT:パーセント割引<br>- COUPON:クーポン<br>- STATIC_DISCOUNT:固定金額割引<br>- CUTOFF: 500KRW未満切り捨て |
| details[].description | String | 割引履歴 |

**projectExtra**

| 名前 | 型 | 説明 |
| --- | --- | --- |
| totalAdjustment | Long | 割増金額の合計 |
| details | List&lt;Object&gt; | 詳細履歴 |
| details[].projectId | String | プロジェクトID |
| details[].projectName | String | プロジェクト名 |
| details[].adjustment | Long | 割増金額 |
| details[].adjustmentTypeCode | String | 割増タイプ<br>- CONTRACT_EXTRA:契約割増<br>- CONTRACT_PENALTY:契約違約金<br>- CONTRACT_DISCOUNT:契約割引<br>- CONTRACT_PAYBACK:パートナーペイバック<br>- STATIC_EXTRA:固定金額割増<br>- PERCENT_DISCOUNT:パーセント割引<br>- COUPON:クーポン<br>- STATIC_DISCOUNT:固定金額割引<br>- CUTOFF: 500KRW未満切り捨て |
| details[].description | String | 割増履歴 |

**projects**

| 名前 | 型 | 説明 |
| --- | --- | --- |
| projectId | String | プロジェクトID |
| projectName | String | プロジェクト名 |
| totalAmount | Long | プロジェクトの最終金額 |
| usagePrice | Long | プロジェクト利用金額の合計 |
| contractUsagePrice | Long | 契約割引/割増を適用した利用金額の合計 |


## パートナーユーザーのプロジェクト一覧の照会

パートナーユーザーのプロジェクト一覧を照会します。

!!! tip "パートナー契約の検証"
    当該パートナーとパートナーユーザーが、指定された月にパートナー契約を結んでいた状態であるかを確認します。

### 必要な権限
`Partner.Project.List`

### リクエスト

```
GET /v1/billing/partners/{partnerId}/payments/{month}/projects
```

### リクエストパラメータ

| 名前 | 区分 | 型 | 必須 | 説明 |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | パートナーID |
| month | Path | String | Y | 利用月(yyyy-MM形式) |
| partnerUserUuid | Query | String | Y | パートナーユーザーUUID |

### リクエストボディ

このAPIはリクエストボディを要求しません。

### レスポンス

<details>
  <summary><strong>レスポンス例</strong></summary>

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "SUCCESS"
  },
  "projects": [
    {
      "orgId": "org123",
      "orgName": "テスト組織",
      "orgCreationType": "USER",
      "orgStatusCode": "STABLE",
      "projectId": "project123",
      "projectName": "テストプロジェクト",
      "projectCreationType": "USER",
      "projectStatusCode": "STABLE"
    }
  ]
}
```

</details>

| 名前 | 型 | 説明 |
| --- | --- | --- |
| projects | List&lt;Object&gt; | プロジェクト一覧 |
| projects[].orgId | String | 組織ID |
| projects[].orgName | String | 組織名 |
| projects[].orgCreationType | String | 組織作成タイプ<br><br>- USER:お客様が作成した組織<br>- SYSTEM:システムが作成した組織(主に会員型マーケットプレイスで使用) |
| projects[].orgStatusCode | String | 組織ステータス<br><br>- STABLE:正常<br>- CLOSED:削除済み |
| projects[].projectId | String | プロジェクトID |
| projects[].projectName | String | プロジェクト名 |
| projects[].projectCreationType | String | プロジェクト作成タイプ<br><br>- USER:お客様が作成したプロジェクト<br>- SYSTEM:システムが作成したプロジェクト(主に組織商品、会員型マーケットプレイスで使用) |
| projects[].projectStatusCode | String | プロジェクトステータス<br><br>- STABLE:正常<br>- CLOSED:削除済み |


## パートナーユーザーのプロジェクト詳細使用量の照会

特定プロジェクトの詳細な使用量を照会します。

!!! danger "注意"
    使用量を照会する際は、ページングを適切に使用してパフォーマンスを最適化してください。

!!! tip "パートナー契約の検証"
    当該パートナーとパートナーユーザーが指定された月にパートナー契約を結んでいたか、また当該プロジェクトが属する組織のオーナーがその月にパートナーユーザーであったかを確認します。

### 必要な権限
`Partner.Project.Usage.Get`

### リクエスト

```
GET /v1/billing/partners/{partnerId}/payments/{month}/projects/{projectId}/usage
```

### リクエストパラメータ

| 名前 | 区分 | 型 | 必須 | 説明 |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | パートナーID |
| month | Path | String | Y | 利用月(yyyy-MM形式) |
| projectId | Path | String | Y | プロジェクトID |
| lang | Header | String | N | 言語設定(デフォルト: ko_KR、設定可能な値: ko_KR、ja_JP、en_US) |
| usageSchemaTypeCode | Query | String | N | 使用量の包含有無<br>使用量の照会方法を従来の方法にするか、新規にグループ化された方法にするかを決定します<br>(デフォルト: NO_GROUP)<br><br>- NO_GROUP:使用量がグループ化されずにそのまま表示される方式 <br>- GROUP_BY_PARENT_RESOURCE:親リソース別にグループ化はされるが、具体的な使用量は提供されない方式。返されるtotalItemsを通じて親リソースがいくつ存在するか確認可能<br>- GROUP_BY_PARENT_RESOURCE_INCLUDE_USAGES:親リソース別にグループ化した後、どの親リソースでグループ化されたかとその詳細な使用量まで提供される方式 |
| page | Query | Integer | N | 選択したページ(デフォルト: 1、最小: 1)<br>usageSchemaTypeCodeがNO_GROUPの場合は使用できません |
| itemsPerPage | Query | Integer | N | ページに表示される項目数、未記入の場合は全て照会(最小: 0)<br>usageSchemaTypeCodeがNO_GROUPの場合は使用できません |
| categoryMain | Query | String | N | メインカテゴリー<br>usageSchemaTypeCodeがNO_GROUPの場合は使用できません |
| regionTypeCode | Query | String | N | リージョンタイプコード(最大20文字)<br>usageSchemaTypeCodeがNO_GROUPの場合は使用できません |

### リクエストボディ

このAPIはリクエストボディを要求しません。

### レスポンス

<details>
  <summary><strong>レスポンス例</strong></summary>

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "SUCCESS"
  },
  "project": {
    "projectId": "project123",
    "projectName": "テストプロジェクト",
    "totalAmount": 50000,
    "usagePrice": 45000,
    "contractUsagePrice": 43000,
    "contractDiscountPrice": 2000,
    "contractExtraPrice": 0,
    "totalCredit": 5000,
    "country": "KR",
    "creditUsages": [
      {
        "balanceTypeCode": "FREE_CREDIT",
        "balanceTypeName": "無料クレジット",
        "usageAmount": 5000
      }
    ],
    "projectDiscount": {
      "totalAdjustment": 2000,
      "details": [
        {
          "projectId": "project123",
          "projectName": "テストプロジェクト",
          "adjustment": 2000,
          "adjustmentTypeCode": "CONTRACT_DISCOUNT",
          "description": "契約割引"
        }
      ]
    },
    "projectExtra": {
      "totalAdjustment": 0,
      "details": []
    },
    "usageGroups": [
      {
        "categoryMain": "COMPUTE",
        "stationId": "KR1",
        "stationName": "韓国(パンギョ)リージョン",
        "regionTypeCode": "KR",
        "needType": false,
        "totalItems": 1,
        "totalPrice": 45000,
        "usagePrice": 45000,
        "usageResourceGroups": [
          {
            "parentResourceId": "parent-resource-123",
            "parentResourceName": "親リソース",
            "usages": [
              {
                "categoryMain": "COMPUTE",
                "categorySub": "INSTANCE",
                "contractId": "contract123",
                "contractPrice": 23000,
                "contractUnitPrice": 958.33,
                "counterName": "c2.small",
                "displayNameEn": "c2.small Instance",
                "displayNameJa": "c2.small インスタンス", 
                "displayNameKo": "c2.smallインスタンス",
                "displayNameZh": "c2.small 实例",
                "displayOrder": 1,
                "parentResourceId": "parent-resource-123",
                "parentResourceName": "親リソース",
                "price": 24000,
                "productUiId": "compute-instance",
                "projectId": "project123",
                "projectName": "テストプロジェクト",
                "rangeFrom": 0,
                "regionTypeCode": "KR",
                "resourceId": "resource123",
                "resourceName": "test-instance",
                "seq": 1,
                "stationId": "KR1",
                "stationName": "韓国(パンギョ)リージョン",
                "unit": 1,
                "unitName": "hours",
                "unitPrice": 1000.0,
                "usage": 24.0,
                "useFixPrice": false
              }
            ]
          }
        ],
        "usages": [
          {
            "counterName": "c2.small",
            "counterType": "DELTA",
            "productId": "compute",
            "projectId": "project123",
            "resourceId": "instance-123",
            "resourceName": "test-instance",
            "parentResourceId": null,
            "usage": 24.0,
            "usedTime": "2024-01-01T00:00:00Z"
          }
        ]
      }
    ]
  }
}
```

</details>

#### 基本レスポンス構造

| 名前 | 型 | 説明 |
| --- | --- | --- |
| project | Object | プロジェクト情報 |
| project.projectId | String | プロジェクトID |
| project.projectName | String | プロジェクト名 |
| project.totalAmount | Long | プロジェクトの最終金額 |
| project.usagePrice | Long | 利用金額 |
| project.contractUsagePrice | Long | 契約割引/割増が適用された利用金額の合計 |
| project.contractDiscountPrice | Long | 契約による割引額 |
| project.contractExtraPrice | Long | 契約による割増額 |
| project.totalCredit | Long | クレジットの最終金額 |
| project.country | String | 国コード |
| project.creditUsages | List&lt;Object&gt; | クレジット使用金額 |
| project.projectDiscount | Object | プロジェクト別割引詳細履歴 |
| project.projectExtra | Object | プロジェクト別割増詳細履歴 |
| project.usageGroups | List&lt;Object&gt; | 使用量グループ一覧 |

**creditUsages**

| 名前 | 型 | 説明 |
| --- | --- | --- |
| balanceTypeCode | String | キャンペーンタイプ(財布タイプ) |
| balanceTypeName | String | キャンペーンタイプ名(財布タイプ名) |
| i18nBalanceTypeNameMap | Object | キャンペーンタイプ名の多言語コード |
| usageAmount | Long | クレジット使用金額 |

**projectDiscount**

| 名前 | 型 | 説明 |
| --- | --- | --- |
| totalAdjustment | Long | 割引金額の合計 |
| details | List&lt;Object&gt; | 詳細履歴 |
| details[].projectId | String | プロジェクトID |
| details[].projectName | String | プロジェクト名 |
| details[].adjustment | Long | 割引金額 |
| details[].adjustmentTypeCode | String | 割引タイプ<br>- CONTRACT_EXTRA:契約割増<br>- CONTRACT_PENALTY:契約違約金<br>- CONTRACT_DISCOUNT:契約割引<br>- CONTRACT_PAYBACK:パートナーペイバック<br>- STATIC_EXTRA:固定金額割増<br>- PERCENT_DISCOUNT:パーセント割引<br>- COUPON:クーポン<br>- STATIC_DISCOUNT:固定金額割引<br>- CUTOFF: 500KRW未満切り捨て |
| details[].description | String | 割引履歴 |

**projectExtra**

| 名前 | 型 | 説明 |
| --- | --- | --- |
| totalAdjustment | Long | 割増金額の合計 |
| details | List&lt;Object&gt; | 詳細履歴 |
| details[].projectId | String | プロジェクトID |
| details[].projectName | String | プロジェクト名 |
| details[].adjustment | Long | 割増金額 |
| details[].adjustmentTypeCode | String | 割増タイプ<br>- CONTRACT_EXTRA:契約割増<br>- CONTRACT_PENALTY:契約違約金<br>- CONTRACT_DISCOUNT:契約割引<br>- CONTRACT_PAYBACK:パートナーペイバック<br>- STATIC_EXTRA:固定金額割増<br>- PERCENT_DISCOUNT:パーセント割引<br>- COUPON:クーポン<br>- STATIC_DISCOUNT:固定金額割引<br>- CUTOFF: 500KRW未満切り捨て |
| details[].description | String | 割増履歴 |

**usageGroups**

#### usageGroupsの基本情報

| 名前 | 型 | 説明 |
| --- | --- | --- |
| categoryMain | String | メインカテゴリー |
| stationId | String | ステーションID |
| stationName | String | ステーション名 |
| regionTypeCode | String | リージョン |
| needType | Boolean | 区分カラムの表示有無 |
| totalItems | Integer | UsageGroupごとのUsage総数 |
| totalPrice | Long | 契約割引が適用された利用金額の合計 |
| usagePrice | Long | 利用金額の合計 |
| usageResourceGroups | List&lt;Object&gt; | グループ化された使用量一覧 |
| usages | List&lt;Object&gt; | 詳細な使用量一覧 |

**usageResourceGroups**

| 名前 | 型 | 説明 |
| --- | --- | --- |
| parentResourceId | String | 区分用のparent resource ID |
| parentResourceName | String | 区分用のparent resource Name |
| usages | List&lt;Object&gt; | 詳細な使用量一覧(UsageDTOスキーマ) |

**UsageDTOスキーマ**

| 名前 | 型 | 説明 |
| --- | --- | --- |
| categoryMain | String | メインカテゴリー |
| categorySub | String | サブカテゴリー |
| contractId | String | 契約ID |
| contractPrice | Long | 契約によって計算された利用金額 |
| contractUnitPrice | BigDecimal | 契約単価 |
| counterName | String | Counter Name |
| displayNameEn | String | 課金単位表示名(en) |
| displayNameJa | String | 課金単位表示名(ja) |
| displayNameKo | String | 課金単位表示名(ko) |
| displayNameZh | String | 課金単位表示名(zh) |
| displayOrder | Long | 表示順 |
| parentResourceId | String | 親リソースID |
| parentResourceName | String | 親リソース名 |
| price | Long | 利用金額 |
| productUiId | String | Webサイト商品Ui Id |
| projectId | String | プロジェクトID |
| projectName | String | プロジェクト名 |
| rangeFrom | BigDecimal | 適用開始範囲 |
| regionTypeCode | String | リージョン |
| resourceId | String | リソースID |
| resourceName | String | リソース名 |
| seq | Long | seq |
| stationId | String | ステーションID |
| stationName | String | ステーション名 |
| unit | Long | 課金単位 |
| unitName | String | 単位名 |
| unitPrice | BigDecimal | 単価 |
| usage | BigDecimal | 使用量 |
| useFixPrice | Boolean | 固定金額かどうか |

**usages**

| 名前 | 型 | 説明 |
| --- | --- | --- |
| counterName | String | カウンター名 |
| counterType | String | カウンタータイプ |
| productId | String | 商品ID |
| projectId | String | プロジェクトID |
| resourceId | String | リソースID |
| resourceName | String | リソース名 |
| parentResourceId | String | 親リソースID |
| usage | BigDecimal | 使用量 |
| usedTime | String | 使用時刻 |


## パートナーの請求書照会

パートナーの全請求書を照会します。

!!! tip "パートナー契約の検証"
    当該パートナーが指定された月に有効なパートナー契約状態であったかを確認します。

### 必要な権限
`Partner.Statement.Get`

### リクエスト

```
GET /v1/billing/partners/{partnerId}/payments/{month}/statements
```

### リクエストパラメータ

| 名前 | 区分 | 型 | 必須 | 説明 |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | パートナーID |
| month | Path | String | Y | 利用月(yyyy-MM形式) |
| lang | Header | String | N | 言語設定(デフォルト: ko_KR、設定可能な値: ko_KR、ja_JP、en_US) |

### リクエストボディ

このAPIはリクエストボディを要求しません。

### レスポンス

<details>
  <summary><strong>レスポンス例</strong></summary>

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "SUCCESS"
  },
  "paymentStatements": [
    {
      "uuid": "user123",
      "autoPaymentTypeCode": "CREDIT_CARD",
      "isAutoPayment": true,
      "paymentInfo": "536148******1588",
      "statements": [
        {
          "paymentGroupId": "group123",
          "month": "2024-01-01T00:00:00Z",
          "charge": 100000,
          "supplyAmount": 90909,
          "taxAmount": 9091,
          "totalAmount": 110000,
          "totalCredit": 10000,
          "totalDiscount": 5000,
          "totalExtra": 0,
          "freeCredit": 5000,
          "freeCreditAll": 3000,
          "freeCreditLimit": 2000,
          "paidCredit": 5000,
          "paidCreditAll": 3000,
          "paidCreditLimit": 2000,
          "paymentStatusCode": "PAID",
          "country": "KR",
          "cutoff": 0,
          "lateFee": 0,
          "realSupplyAmount": 90909,
          "realTaxAmount": 9091,
          "receiptStatusCode": "EXIST",
          "refundAccountRegisterStatusCode": "ALLOW",
          "details": [
            {
              "billingGroupId": "billing123",
              "billingGroupName": "基本ビリンググループ",
              "charge": 100000,
              "contractDiscount": 5000,
              "contractExtra": 0,
              "totalAmount": 105000,
              "totalCredit": 10000,
              "totalDiscount": 5000,
              "totalExtra": 0,
              "creditUsages": [
                {
                  "balanceTypeCode": "FREE_CREDIT",
                  "balanceTypeName": "無料クレジット",
                  "i18nBalanceTypeNameMap": {
                    "ko_KR": "無料クレジット"
                  },
                  "usageAmount": 5000
                }
              ],
              "orgList": [
                {
                  "orgId": "org123",
                  "orgName": "テスト組織",
                  "totalAmount": 105000
                }
              ],
              "usageGroups": [
                {
                  "categoryMain": "Compute",
                  "needType": true,
                  "regionTypeCode": "KR1",
                  "stationId": "station1",
                  "stationName": "韓国(パンギョ)リージョン",
                  "totalItems": 10,
                  "totalPrice": 100000,
                  "usagePrice": 105000,
                  "usageResourceGroups": [],
                  "usages": []
                }
              ],
              "billingGroupDiscount": {
                "totalAdjustment": 2000,
                "details": [
                  {
                    "adjustment": 2000,
                    "adjustmentTypeCode": "CONTRACT_DISCOUNT",
                    "description": "契約割引"
                  }
                ]
              },
              "billingGroupExtra": {
                "totalAdjustment": 0,
                "details": []
              },
              "projectDiscount": {
                "totalAdjustment": 3000,
                "details": [
                  {
                    "projectId": "project123",
                    "projectName": "テストプロジェクト",
                    "adjustment": 3000,
                    "adjustmentTypeCode": "CONTRACT_DISCOUNT",
                    "description": "プロジェクト契約割引"
                  }
                ]
              },
              "projectExtra": {
                "totalAdjustment": 0,
                "details": []
              }
            }
          ]
        }
      ]
    }
  ]
}
```

</details>

#### 基本レスポンス構造

| 名前 | 型 | 説明 |
| --- | --- | --- |
| paymentStatements | List&lt;Object&gt; | 請求書一覧 |

**paymentStatements**

| 名前 | 型 | 説明 |
| --- | --- | --- |
| uuid | String | 会員UUID |
| autoPaymentTypeCode | String | 決済手段タイプ<br><br>- PAYCO_CREDIT_CARD: PAYCOクレジットカード<br>- CREDIT_CARD:クレジットカード<br>- INTER_CREDIT_CARD:海外クレジットカード<br>- UNION_PAY:銀聯Pay<br>- JAPAN_BILLING:日本ビリング<br>- ACCOUNT_TRANSFER:口座振替<br>- CREDIT_ALL:一般クレジット<br>- CREDIT_LIMIT:イベントクレジット<br>- ESM:内部費用<br>- ONETIME_PAYMENT: 1回限りの決済<br>- TAX_BILL:税金計算書発行<br>- CONTRACT_BILL:税金計算書発行(別途契約により請求金額調整が発生)<br>- NONE:なし |
| isAutoPayment | Boolean | 自動決済手段かどうか |
| paymentInfo | String | 決済手段情報 |
| statements | List&lt;Object&gt; | ビリンググループ別決済履歴一覧 |

**statements**

#### statementsの基本情報

| 名前 | 型 | 説明 |
| --- | --- | --- |
| paymentGroupId | String | 決済グループID |
| month | String | 利用月 |
| charge | Long | 使用金額 |
| supplyAmount | Long | 供給価額 |
| taxAmount | Long | 付加税額 |
| totalAmount | Long | 最終金額 |
| totalCredit | Long | クレジット総使用金額 |
| totalDiscount | Long | 割引金額 |
| totalExtra | Long | 割増金額 |
| freeCredit | Long | 無料クレジット使用金額 |
| freeCreditAll | Long | 無料全体型クレジット使用金額 |
| freeCreditLimit | Long | 無料制限型クレジット使用金額 |
| paidCredit | Long | 有料クレジット使用金額 |
| paidCreditAll | Long | 有料全体型クレジット使用金額 |
| paidCreditLimit | Long | 有料制限型クレジット使用金額 |
| paymentStatusCode | String | 決済ステータス<br><br>- REGISTERED:登録<br>- READY:決済待ち<br>- PAID:決済完了<br>- ERROR:運営者による確認が必要な状態 |
| country | String | 国コード |
| cutoff | Long | cutoff |
| lateFee | Long | 延滞金額 |
| realSupplyAmount | Long | 実供給価額 |
| realTaxAmount | Long | 実際に決済された付加税 |
| receiptStatusCode | String | 売上伝票ステータスコード<br><br>- NONE:まだ会計チームに売上報告がされておらず、売上伝票を閲覧できない状態<br>- EXIST:最終的な金額調整が完了し、会計チームに売上報告がされたため、売上伝票を閲覧できる状態 |
| refundAccountRegisterStatusCode | String | 返金口座登録の有無の状態<br><br>- ALLOW:返金口座登録がOpenの状態<br>- DENY: Default、返金口座登録がCloseの状態 |
| details | List&lt;Object&gt; | ビリンググループ別詳細履歴一覧 |

**details**

#### detailsの基本情報

| 名前 | 型 | 説明 |
| --- | --- | --- |
| billingGroupId | String | ビリンググループID |
| billingGroupName | String | ビリンググループ名 |
| charge | Long | 利用金額 |
| contractDiscount | Long | 契約割引金額 |
| contractExtra | Long | 契約割増金額 |
| totalAmount | Long | 最終金額 |
| totalCredit | Long | クレジット総使用金額 |
| totalDiscount | Long | 割引金額 |
| totalExtra | Long | 割増金額 |
| creditUsages | List&lt;Object&gt; | クレジット使用金額 |
| orgList | List&lt;Object&gt; | 組織一覧 |
| usageGroups | List&lt;Object&gt; | 使用量グループ一覧 |
| billingGroupDiscount | Object | ビリンググループ割引詳細履歴 |
| billingGroupExtra | Object | ビリンググループ割増詳細履歴 |
| projectDiscount | Object | プロジェクト別割引詳細履歴 |
| projectExtra | Object | プロジェクト別割増詳細履歴 |

**creditUsages**

| 名前 | 型 | 説明 |
| --- | --- | --- |
| balanceTypeCode | String | キャンペーンタイプ(財布タイプ) |
| balanceTypeName | String | キャンペーンタイプ名(財布タイプ名) |
| i18nBalanceTypeNameMap | Object | キャンペーンタイプ名の多言語コード |
| usageAmount | Long | クレジット使用金額 |

**orgList**

| 名前 | 型 | 説明 |
| --- | --- | --- |
| orgId | String | 組織ID |
| orgName | String | 組織名 |
| totalAmount | Long | 組織の最終金額 |

**usageGroups**

| 名前 | 型 | 説明 |
| --- | --- | --- |
| categoryMain | String | メインカテゴリー |
| needType | Boolean | 区分カラムの表示有無 |
| regionTypeCode | String | リージョン |
| stationId | String | ステーションID |
| stationName | String | ステーション名 |
| totalItems | Integer | UsageGroupごとのUsage総数 |
| totalPrice | Long | 契約割引が適用された利用金額の合計 |
| usagePrice | Long | 利用金額の合計 |
| usageResourceGroups | List&lt;Object&gt; | グループ化された使用量一覧 |
| usages | List&lt;Object&gt; | 詳細な使用量一覧 |

**billingGroupDiscount**

| 名前 | 型 | 説明 |
| --- | --- | --- |
| totalAdjustment | Long | 割引金額 |
| details | List&lt;Object&gt; | 詳細履歴 |
| details[].adjustment | Long | 割引金額 |
| details[].adjustmentTypeCode | String | 割引タイプ<br><br>- CONTRACT_EXTRA:契約割増<br>- CONTRACT_PENALTY:契約違約金<br>- CONTRACT_DISCOUNT:契約割引<br>- CONTRACT_PAYBACK:パートナーペイバック<br>- STATIC_EXTRA:固定金額割増<br>- PERCENT_DISCOUNT:パーセント割引<br>- COUPON:クーポン<br>- STATIC_DISCOUNT:固定金額割引<br>- CUTOFF: 500KRW未満切り捨て |
| details[].description | String | 割引履歴 |

**billingGroupExtra**

| 名前 | 型 | 説明 |
| --- | --- | --- |
| totalAdjustment | Long | 割増金額 |
| details | List&lt;Object&gt; | 詳細履歴 |
| details[].adjustment | Long | 割増金額 |
| details[].adjustmentTypeCode | String | 割増タイプ<br><br>- CONTRACT_EXTRA:契約割増<br>- CONTRACT_PENALTY:契約違約金<br>- CONTRACT_DISCOUNT:契約割引<br>- CONTRACT_PAYBACK:パートナーペイバック<br>- STATIC_EXTRA:固定金額割増<br>- PERCENT_DISCOUNT:パーセント割引<br>- COUPON:クーポン<br>- STATIC_DISCOUNT:固定金額割引<br>- CUTOFF: 500KRW未満切り捨て |
| details[].description | String | 割増履歴 |

**projectDiscount**

| 名前 | 型 | 説明 |
| --- | --- | --- |
| totalAdjustment | Long | 割引金額の合計 |
| details | List&lt;Object&gt; | 詳細履歴 |
| details[].projectId | String | プロジェクトID |
| details[].projectName | String | プロジェクト名 |
| details[].adjustment | Long | 割引金額 |
| details[].adjustmentTypeCode | String | 割引タイプ<br><br>- CONTRACT_EXTRA:契約割増<br>- CONTRACT_PENALTY:契約違約金<br>- CONTRACT_DISCOUNT:契約割引<br>- CONTRACT_PAYBACK:パートナーペイバック<br>- STATIC_EXTRA:固定金額割増<br>- PERCENT_DISCOUNT:パーセント割引<br>- COUPON:クーポン<br>- STATIC_DISCOUNT:固定金額割引<br>- CUTOFF: 500KRW未満切り捨て |
| details[].description | String | 割引履歴 |

**projectExtra**

| 名前 | 型 | 説明 |
| --- | --- | --- |
| totalAdjustment | Long | 割増金額の合計 |
| details | List&lt;Object&gt; | 詳細履歴 |
| details[].projectId | String | プロジェクトID |
| details[].projectName | String | プロジェクト名 |
| details[].adjustment | Long | 割増金額 |
| details[].adjustmentTypeCode | String | 割増タイプ<br><br>- CONTRACT_EXTRA:契約割増<br>- CONTRACT_PENALTY:契約違約金<br>- CONTRACT_DISCOUNT:契約割引<br>- CONTRACT_PAYBACK:パートナーペイバック<br>- STATIC_EXTRA:固定金額割増<br>- PERCENT_DISCOUNT:パーセント割引<br>- COUPON:クーポン<br>- STATIC_DISCOUNT:固定金額割引<br>- CUTOFF: 500KRW未満切り捨て |
| details[].description | String | 割増履歴 |


## ソリューションパートナーの自社商品メータリング照会

ソリューションパートナーが自社の商品に関するメータリング情報を照会します。

!!! tip "ソリューションパートナーの検証"
    ソリューションパートナー、またはソリューションパートナーから権限を付与されたユーザーのみが呼び出し可能です。

### 必要な権限
`Partner.Meter.List`

### リクエスト

```
GET /v1/billing/partners/{partnerId}/products/{productId}/meters
```

### リクエストパラメータ

| 名前 | 区分 | 型 | 必須 | 説明 |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | パートナーID |
| productId | Path | String | Y | 商品ID |
| from | Query | String | Y | 照会開始日(yyyy-MM-ddThh:mm:ss.sssZ、含む) |
| to | Query | String | Y | 照会終了日(yyyy-MM-ddThh:mm:ss.sssZ、含まない) |
| counterName | Query | String | Y | カウンター名 |
| meterTimeTypeCode | Query | String | N | メーター時間タイプコード<br><br>- INSERT_TIME:メータリング挿入時間基準<br>- USED_TIME:メータリング発生時間基準 |
| page | Query | Integer | Y | 選択したページ(最小: 1) |
| limit | Query | Integer | Y | ページに表示される項目数(最小: 1、最大: 2000) |

### リクエストボディ

このAPIはリクエストボディを要求しません。

### レスポンス

<details>
  <summary><strong>レスポンス例</strong></summary>

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "SUCCESS"
  },
  "meterList": [
    {
      "appKey": "app123",
      "counterName": "api.calls",
      "counterType": "DELTA",
      "counterUnit": "CALLS",
      "counterVolume": 1000.0,
      "productId": "product123",
      "resourceId": "resource123",
      "resourceName": "api-service",
      "timestamp": "2024-01-01T00:00:00Z",
      "insertTime": "2024-01-01T00:01:00Z"
    }
  ],
  "totalItems": 1
}
```

</details>

| 名前 | 型 | 説明 |
| --- | --- | --- |
| meterList | List&lt;Object&gt; | メータリング一覧 |
| meterList[].appKey | String | 商品アプリキー |
| meterList[].counterName | String | カウンター名 |
| meterList[].counterType | String | カウンタータイプ<br><br>- DELTA:増分値<br>- GAUGE:現在値<br>- HOURLY_LATEST:時間ごとの最新値<br>- DAILY_MAX:日ごとの最大値<br>- MONTHLY_MAX:月ごとの最大値<br>- STATUS:ステータス値 |
| meterList[].counterUnit | String | カウンター単位 |
| meterList[].counterValue | String | 使用状況(counterTypeがSTATUSの場合にのみ使用) |
| meterList[].counterVolume | BigDecimal | カウンターボリューム |
| meterList[].gmid | String | グローバルメータリングID |
| meterList[].insertTime | String | メータリング挿入時刻 |
| meterList[].orgId | String | 組織ID |
| meterList[].parentResourceId | String | 親リソースID |
| meterList[].productId | String | 商品ID |
| meterList[].projectId | String | プロジェクトID |
| meterList[].resourceId | String | リソースID |
| meterList[].resourceName | String | リソース名 |
| meterList[].source | String | メータリングが発生したIPまたはホスト名 |
| meterList[].stationId | String | ステーションID |
| meterList[].timestamp | String | メータリング発生時刻 |
| totalItems | Integer | 全項目数 |


## パートナーユーザーの組織作成

パートナーがパートナーユーザーの組織を作成します。

!!! tip "パートナー契約の検証"
    APIを呼び出した月に、当該パートナーとパートナーユーザーがパートナー契約関係にあったかを確認します。

### 必要な権限
`Partner.Organization.Create`

### リクエスト

```
POST /v1/partners/{partnerId}/partner-users/{partnerUserUuid}/organizations
```

### リクエストパラメータ

| 名前 | 区分 | 型 | 必須 | 説明 |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | パートナーID |
| partnerUserUuid | Path | String | Y | パートナーユーザーUUID |

### リクエストボディ

| 名前 | 型 | 必須 | 説明 |
| --- | --- | --- | --- |
| orgName | String | Y | 作成する組織名(最大120文字) |

### レスポンス

<details>
  <summary><strong>レスポンス例</strong></summary>

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "SUCCESS"
  },
  "orgId": "org-12345",
  "orgName": "新しい組織",
  "ownerId": "owner-uuid-12345",
  "regDateTime": "2024-01-15T10:30:00Z"
}
```

</details>

| 名前 | 型 | 説明 |
| --- | --- | --- |
| orgId | String | 作成された組織ID |
| orgName | String | 組織名 |
| ownerId | String | 組織オーナーUUID |
| regDateTime | String | 登録日時(ISO 8601形式) |


## パートナーユーザーの組織削除

パートナーがパートナーユーザーの組織を削除します。

!!! tip "パートナー契約の検証"
    APIを呼び出した月に当該パートナーとパートナーユーザーがパートナー契約関係にあったか、また削除対象がパートナーユーザーの組織であるかを確認します。

### 必要な権限
`Partner.Organization.Delete`

### リクエスト

```
DELETE /v1/partners/{partnerId}/partner-users/{partnerUserUuid}/organizations/{orgId}
```

### リクエストパラメータ

| 名前 | 区分 | 型 | 必須 | 説明 |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | パートナーID |
| partnerUserUuid | Path | String | Y | パートナーユーザーUUID |
| orgId | Path | String | Y | 削除する組織ID |

### リクエストボディ

このAPIはリクエストボディを要求しません。

### レスポンス

<details>
  <summary><strong>レスポンス例</strong></summary>

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "SUCCESS"
  }
}
```

</details>

## エラーコード

| resultCode | 説明 | 措置 |
| --- | --- | --- |
| -14 | 許可されていない国のIPからのリクエスト | 許可された国からリクエストするか、国別のIP制限ポリシーを確認してください。 |
| -8 | リクエストIPが許可されていない、または組織のIP ACLポリシーによりIP検証に失敗 | 組織のIP ACLに当該IPが登録されているかを確認し、許可されたIP範囲からリクエストしてください。 |
| -7 | 権限が許可されていません | 当該作業に対する権限が許可されていないため、システム管理者にお問い合わせください。 |
| -6 | 呼び出したAPIに対して呼び出し元の認可に失敗した場合に発生するエラー、またはパートナー権限の検証に失敗 | 呼び出し元がAPI呼び出し権限を持っているかを確認し、必要であればシステム管理者に問い合わせて呼び出し権限をリクエストしてください。呼び出しアカウントの権限とリクエストスコープのパートナーIDを点検してください。 |
| -5 | 権限拒否 - オーナーではない、または削除しようとする組織の実際のオーナーがリクエストしたパートナーユーザーと異なる | リクエストしたユーザーが当該組織のオーナーであるかを確認し、対象組織が当該パートナーユーザーの所有であるかを確認してください。 |
| -4 | 権限拒否 - メンバーではない | リクエストしたユーザーが当該パートナーのメンバーであるかを確認し、適切な権限を付与された後に再試行してください。 |
| 404 | 存在しないAPIを呼び出した場合に発生 | 呼び出すAPIのHTTPメソッド、URIを確認してください。 |
| 500 | 異常なシステムエラー | システム管理者にお問い合わせください。 |
| 501 | 不正な日付形式 | 日付パラメータを正しい形式で提供してください。 |
| 502 | 不正なパラメータ | リクエストパラメータの値と形式を確認してください。 |
| 503 | サービス利用不可または照会期間の規則に違反 | サービスが一時的に利用不可能な状態であるため、しばらくしてから再試行するか、照会期間の規則を遵守してリクエストしてください。 |
| 504 | JSONパース失敗 | リクエストボディのJSON形式を確認してください。 |
| 505 | 検証失敗 | リクエストのフィールドの有効性検証を確認してください。 |
| 1000 | パラメータが不正な場合に発生するエラー | リクエストパラメータの形式と値を確認し、正しい値で再試行してください。 |
| 1200 | API呼び出し失敗 | しばらくしてから再試行するか、システムの状態を確認してください。 |
| 10005 | リクエストパラメータが適切でない場合に発生するエラー | リクエストパラメータの必須値や設定可能な値などを確認してください。 |
| 11010 | 使用量照会権限の不足 | 商品/カウンター/組織に対する権限の確認及び付与を行ってください。 |
| 11012 | 組織へのアクセス権限がありません | ユーザーに当該組織へのアクセス権限を付与してください。 |
| 11013 | メンバーがパートナーユーザーではない、または指定したパートナーIDとパートナーユーザーUUIDが一致しない | 当該メンバーが指定された期間にパートナーユーザーであるかを確認し、パートナー関係を再設定してください。パートナーユーザーが当該パートナーに承認・連携されているかを確認してください。 |
| 12000 | プロジェクトが見つかりません | リクエストしたプロジェクトIDが存在するかを確認し、正しいプロジェクトIDで再試行してください。 |
| 12100 | プロジェクトメンバーが存在しない場合に発生するエラー | 存在するプロジェクトメンバーのUUIDを使用してください。 |
| 17001 | アプリキーが見つかりません | アプリキーが正常に発行されたかを確認し、必要に応じて再発行してください。 |
| 17003 | アプリキーとプロジェクト/商品が連携されていません | アプリキーを正しいプロジェクト/商品と連携してください。 |
| 17501 | 組織が見つかりません | 組織IDが存在するかを確認してください。 |
| 18001 | プロジェクトが見つかりません | プロジェクトIDが存在するかを確認してください。 |
| 22001 | パートナーの基本グループがありません | パートナーの基本グループ設定を確認してください。 |
| 22002 | パートナーの決済グループがありません | パートナーの決済グループ設定を確認してください。 |
| 22003 | パートナーの調整値の範囲エラー | パートナーの調整値が許容範囲内であるかを確認してください。 |
| 22004 | ソリューションパートナーの商品ではありません | リクエストした商品が当該ソリューションパートナーの商品であるかを確認してください。 |
| 22005 | ソリューションパートナーではありません | パートナーがソリューションパートナーの資格を持っているかを確認してください。 |
| 22021 | 組織作成時、組織オーナーのアカウントに設定された組織作成数の上限を超えた場合に発生するエラー | 1)使用していない組織を削除して作成可能な組織数を確保してください。<br>2)システム管理者を通じて組織作成の最大数を調整してください。 |
| 22023 | MSPパートナーの上限を超えたため、組織の作成が制限されました | MSPパートナーの上限を調整するか、組織を整理してください。 |
| 23005 | 組織IDに該当する組織が存在しない場合に発生するエラー | システム管理者にお問い合わせください。 |
| 24000 | API連携失敗 | システム管理者にお問い合わせください。 |
| 24001 | アプリキーの有効性検証に失敗 | アプリキーの有効性を確認してください。 |
| 24002 | メンバー情報の有効性検証に失敗 | メンバー情報を確認してください。 |
| 24005 | プロジェクトメンバーがいません | 当該メンバーがプロジェクトに属しているかを確認してください。 |
| 24007 | プロジェクトがありません | プロジェクトIDを確認するか、システム管理者にお問い合わせください。 |
| 25001 | 国別の税率ポリシーがありません | システム管理者にお問い合わせください。 |
| 70013 | 利用中のサービスが存在する場合に発生するエラー | 利用中のサービスを無効化してください。 |
| 70032 | 未払いによる制裁で組織の作成がブロックされました | 未払いを解消し、制裁の解除を要請した後に再試行してください。 |
| 80400 | 不正なリクエスト | リクエストパラメータの形式及び必須値を確認してください。 |
| 80401 | 認証失敗 | 認証トークンの有効性及びログイン状態を確認してください。 |
| 80500 | サーバーエラー | サーバーログを確認後、システム管理者にお問い合わせください。 |
