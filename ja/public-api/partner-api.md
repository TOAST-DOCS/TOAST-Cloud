<!-- pre-align:aligned sig=a874d1711b7d -->

# パートナー管理APIガイド

**NHN Cloud > Public API使用ガイド > パートナー管理APIガイド**

<a id="common-information-for-partner-management-api"></a>
## パートナー管理APIの共通情報 { #common-information-for-partner-management-api }

<a id="api-endpoint"></a>
### APIエンドポイント { #api-endpoint }

パートナー管理APIを呼び出すためのエンドポイント情報です。<br>
パートナーまたはパートナーから権限を付与されたユーザーのみが呼び出し可能なAPIであり、一般ユーザーは使用できません。

| リージョン  | エンドポイント |
|--------| ----- |
| Global | https://core.api.nhncloudservice.com/ |

<a id="authentication-and-permission"></a>
### 認証及び権限 { #authentication-and-permission }

パートナー管理APIは、API呼び出し時の認証/認可のためにUser Access Keyトークンを使用します。User Access Keyトークンは、User Access Keyに基づいて発行されるBearerタイプの一時的なアクセストークンです。User Access Keyトークンの発行及び使用に関する詳細は、[User Access Keyトークン](./user-access-key-token/)を参照してください。

| ヘッダ名 | 説明 |
| --- | --- |
| x-nhn-authorization | API認証のためのトークン |

<a id="response-common-information"></a>
### レスポンス共通情報 { #response-common-information }

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

!!! danger "APIレスポンスフィールドの拡張性"
    APIレスポンスには、以下に明記されていないフィールドが追加されることがあります。新しいフィールドが追加されてもエラーが発生しないように注意してください。


<a id="view-organization-usage-list-of-partner-users"></a>
## パートナーユーザーの組織使用量一覧の照会 { #view-organization-usage-list-of-partner-users }

パートナーユーザーの請求金額、組織別使用金額、サービス別使用金額、割増情報を提供します。

!!! tip "パートナー契約の検証"
    当該パートナーとパートナーユーザーが、指定された月にパートナー契約を結んでいた状態であるかを確認します。

!!! tip 「ポイント」
    利用月はyyyy-MM形式で入力する必要があります。

<a id="required-permission"></a>
### 必要な権限 { #required-permission }
`Partner.Payment.Get`

<a id="request"></a>
### リクエスト { #request }

```
GET /v1/billing/partners/{partnerId}/payments/{month}
```

<a id="request-parameter"></a>
### リクエストパラメータ { #request-parameter }

| 名前 | 区分 | 型 | 必須 | 説明 |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | パートナーID |
| month | Path | String | Y | 利用月(yyyy-MM形式) |
| partnerUserUuid | Query | String | Y | パートナーユーザーUUID |
| lang | Header | String | N | 言語設定(デフォルト: ko_KR、設定可能な値: ko_KR、ja_JP、en_US) |

<a id="request-body"></a>
### リクエストボディ { #request-body }

このAPIはリクエストボディを要求しません。

<a id="response"></a>
### レスポンス { #response }

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

<a id="response-default-response-structure"></a>
#### 基本レスポンス構造

| 名前 | 型 | 説明 |
| --- | --- | --- |
| payment | PartnerUserOrgUsage | 決済情報 |

**PartnerUserOrgUsage**

| 名前 | タイプ | 説明 |
| --- | --- | --- |
| charge | Long | 使用金額+プロジェクト割増金額 |
| totalAmount | Long | 請求金額(使用金額+消費税額) |
| taxAmount | Long | 消費税額 |
| currency | String | 通貨<br>langによって該当する言語で返却される |
| orgList | List&lt;GetPartnerUserOrgUsages&gt; | 組織別使用量一覧 |
| usageSummaryList | List&lt;UsageSummary&gt; | 使用量サマリー一覧 |
| extraSummaryList | List&lt;ProjectExtra&gt; | プロジェクト割増サマリー一覧 |

**GetPartnerUserOrgUsages**

| 名前 | 型 | 説明 |
| --- | --- | --- |
| orgName | String | 組織名 |
| charge | Long | 組織別使用金額 |

**UsageSummary**

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

**ProjectExtra**

| 名前 | 型 | 説明 |
| --- | --- | --- |
| description | String | 割増の説明 |
| extraPrice | Long | プロジェクト割増金額 |


<a id="retrieve-organization-lists-of-partner-users"></a>
## パートナーユーザーの組織一覧の照会 { #retrieve-organization-lists-of-partner-users }

パートナーユーザーの組織一覧を照会します。

!!! tip "パートナー契約の検証"
    当該パートナーとパートナーユーザーが、指定された月にパートナー契約を結んでいた状態であるかを確認します。

<a id="retrieve-organization-lists-of-partner-users-required-permission"></a>
### 必要な権限 { #retrieve-organization-lists-of-partner-users-required-permission }
`Partner.Organization.List`

<a id="retrieve-organization-lists-of-partner-users-request"></a>
### リクエスト { #retrieve-organization-lists-of-partner-users-request }

```
GET /v1/billing/partners/{partnerId}/payments/{month}/organizations
```

<a id="retrieve-organization-lists-of-partner-users-request-parameter"></a>
### リクエストパラメータ { #retrieve-organization-lists-of-partner-users-request-parameter }

| 名前 | 区分 | 型 | 必須 | 説明 |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | パートナーID |
| month | Path | String | Y | 利用月(yyyy-MM形式) |
| partnerUserUuid | Query | String | Y | パートナーユーザーUUID |

<a id="retrieve-organization-lists-of-partner-users-request-body"></a>
### リクエストボディ { #retrieve-organization-lists-of-partner-users-request-body }

このAPIはリクエストボディを要求しません。

<a id="retrieve-organization-lists-of-partner-users-response"></a>
### レスポンス { #retrieve-organization-lists-of-partner-users-response }

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
| organizations | List&lt;OrganizationProtocol&gt; | 組織一覧 |

**OrganizationProtocol**

| 名前 | タイプ | 説明 |
| --- | --- | --- |
| orgId | String | 組織ID |
| orgName | String | 組織名 |
| orgStatusCode | String | 組織ステータス(STABLE: 正常状態、CLOSED: 削除された状態) |
| orgCreationType | String | 組織作成タイプ(USER: 顧客が作成した組織、SYSTEM: システムで作成した組織) |
| cloudType | String | クラウドタイプ |


<a id="retrieve-the-billing-amount-per-organizations-of-partner-users"></a>
## パートナーユーザーの組織別請求金額の照会 { #retrieve-the-billing-amount-per-organizations-of-partner-users }

特定組織の詳細な利用金額、割引及び割増金額を照会します。

!!! tip "パートナー契約の検証"
    当該パートナーとパートナーユーザーが指定された月にパートナー契約を結んでいたか、また当該組織のオーナーがその月にパートナーユーザーであったかを確認します。

<a id="retrieve-the-billing-amount-per-organizations-of-partner-users-required-permission"></a>
### 必要な権限 { #retrieve-the-billing-amount-per-organizations-of-partner-users-required-permission }
`Partner.Organization.Usage.Get`

<a id="retrieve-the-billing-amount-per-organizations-of-partner-users-request"></a>
### リクエスト { #retrieve-the-billing-amount-per-organizations-of-partner-users-request }

```
GET /v1/billing/partners/{partnerId}/payments/{month}/organizations/{orgId}/usage
```

<a id="retrieve-the-billing-amount-per-organizations-of-partner-users-request-parameter"></a>
### リクエストパラメータ { #retrieve-the-billing-amount-per-organizations-of-partner-users-request-parameter }

| 名前 | 区分 | 型 | 必須 | 説明 |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | パートナーID |
| month | Path | String | Y | 利用月(yyyy-MM形式) |
| orgId | Path | String | Y | 組織ID |
| lang | Header | String | N | 言語設定(デフォルト: ko_KR、設定可能な値: ko_KR、ja_JP、en_US) |
| isHideContract | Query | Boolean | N | 約定情報の非表示の有無 (デフォルト false / true: partner マスキング適用) |

<a id="retrieve-the-billing-amount-per-organizations-of-partner-users-request-body"></a>
### リクエストボディ { #retrieve-the-billing-amount-per-organizations-of-partner-users-request-body }

このAPIはリクエストボディを要求しません。

<a id="retrieve-the-billing-amount-per-organizations-of-partner-users-response"></a>
### レスポンス { #retrieve-the-billing-amount-per-organizations-of-partner-users-response }

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
    "ocpDiscountPrice": 0,
    "totalDiscount": 5000,
    "totalExtra": 0,
    "prePaidTotalAmount": 0,
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
        "contractUsagePrice": 95000,
        "contractDiscountPrice": 5000,
        "ocpDiscountPrice": 0,
        "contractExtraPrice": 0,
        "prePaidTotalAmount": 0
      }
    ]
  }
}
```

</details>

<a id="retrieve-the-billing-amount-per-organizations-of-partner-users-response-default-response-structure"></a>
#### 基本レスポンス構造

| 名前 | タイプ | 説明 |
| --- | --- | --- |
| org | Organization | 組織情報 |

**Organization**

| 名前 | タイプ | 説明 |
| --- | --- | --- |
| orgId | String | 組織ID |
| orgName | String | 組織名 |
| country | String | 国コード |
| usagePrice | Long | 利用金額 |
| contractUsagePrice | Long | 約定割引/割増が適用された利用金額合計 |
| contractDiscountPrice | Long | 約定による割引金額 |
| ocpDiscountPrice | Long | Optimized Cost Plans(OCPs) 割引金額 |
| contractExtraPrice | Long | 約定による割増金額 |
| totalDiscount | Long | 割引金額合計 |
| totalExtra | Long | 割増金額合計 |
| totalAmount | Long | 組織の最終金額 |
| prePaidTotalAmount | Long | 先払い利用金額 |
| totalCredit | Long | クレジットの最終金額 |
| creditUsages | List&lt;CreditUsageProtocol&gt; | クレジット使用金額 |
| projects | List&lt;Project&gt; | プロジェクト一覧 |
| projectDiscount | PaymentStatementProjectAdjustment | プロジェクト別割引詳細内訳一覧 |
| projectExtra | PaymentStatementProjectAdjustment | プロジェクト別割増詳細内訳一覧 |

**CreditUsageProtocol**

| 名前 | タイプ | 説明 |
| --- | --- | --- |
| balanceTypeCode | String | キャンペーン種別（クレジット種別） |
| balanceTypeName | String | キャンペーン種別名（クレジット種別名） |
| i18nBalanceTypeNameMap | Map&lt;String, String&gt; | キャンペーン種別名の多言語コード |
| usageAmount | Long | クレジット使用金額 |

**Project**

| 名前 | タイプ | 説明 |
| --- | --- | --- |
| projectId | String | プロジェクトID |
| projectName | String | プロジェクト名 |
| totalAmount | Long | プロジェクトの最終金額 |
| usagePrice | Long | プロジェクト利用金額合計 |
| contractUsagePrice | Long | 約定割引/割増を適用した利用金額合計 |
| contractDiscountPrice | Long | 約定による割引金額 |
| ocpDiscountPrice | Long | Optimized Cost Plans(OCPs) 割引金額 |
| contractExtraPrice | Long | 約定による割増金額 |
| prePaidTotalAmount | Long | 先払い利用金額 |

**PaymentStatementProjectAdjustment**

| 名前 | タイプ | 説明 |
| --- | --- | --- |
| totalAdjustment | Long | 割引/割増金額合計 |
| details | List&lt;PaymentStatementProjectAdjustmentDetail&gt; | 詳細内訳 |

**PaymentStatementProjectAdjustmentDetail**

| 名前 | タイプ | 説明 |
| --- | --- | --- |
| projectId | String | プロジェクトID |
| projectName | String | プロジェクト名 |
| adjustment | Long | 割引/割増金額 |
| adjustmentTypeCode | String | 割引/割増タイプ<br>- CONTRACT_EXTRA: 約定割増<br>- CONTRACT_PENALTY: 約定違約金<br>- CONTRACT_DISCOUNT: 約定割引<br>- CONTRACT_PAYBACK: パートナーペイバック<br>- STATIC_EXTRA: 固定金額割増<br>- PERCENT_DISCOUNT: パーセント割引<br>- COUPON: クーポン<br>- STATIC_DISCOUNT: 固定金額割引<br>- CUTOFF: 500ウォン未満切捨て |
| description | String | 割引/割増内訳 |

<a id="retrieve-project-lists-of-partner-users"></a>
## パートナーユーザーのプロジェクト一覧の照会 { #retrieve-project-lists-of-partner-users }

パートナーユーザーのプロジェクト一覧を照会します。

!!! tip "パートナー契約の検証"
    当該パートナーとパートナーユーザーが、指定された月にパートナー契約を結んでいた状態であるかを確認します。

<a id="retrieve-project-lists-of-partner-users-required-permission"></a>
### 必要な権限 { #retrieve-project-lists-of-partner-users-required-permission }
`Partner.Project.List`

<a id="retrieve-project-lists-of-partner-users-request"></a>
### リクエスト { #retrieve-project-lists-of-partner-users-request }

```
GET /v1/billing/partners/{partnerId}/payments/{month}/projects
```

<a id="retrieve-project-lists-of-partner-users-request-parameter"></a>
### リクエストパラメータ { #retrieve-project-lists-of-partner-users-request-parameter }

| 名前 | 区分 | 型 | 必須 | 説明 |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | パートナーID |
| month | Path | String | Y | 利用月(yyyy-MM形式) |
| partnerUserUuid | Query | String | Y | パートナーユーザーUUID |

<a id="retrieve-project-lists-of-partner-users-request-body"></a>
### リクエストボディ { #retrieve-project-lists-of-partner-users-request-body }

このAPIはリクエストボディを要求しません。

<a id="retrieve-project-lists-of-partner-users-response"></a>
### レスポンス { #retrieve-project-lists-of-partner-users-response }

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
| projects | List&lt;ProjectProtocol&gt; | プロジェクト一覧 |

**ProjectProtocol**

| 名前 | タイプ | 説明 |
| --- | --- | --- |
| orgId | String | 組織ID |
| orgName | String | 組織名 |
| orgCreationType | String | 組織作成タイプ<br><br>- USER: 顧客が作成した組織<br>- SYSTEM: システムで作成した組織(主に会員型マーケットプレイスで使用) |
| orgStatusCode | String | 組織ステータス<br><br>- STABLE: 正常状態<br>- CLOSED: 削除された状態 |
| projectId | String | プロジェクトID |
| projectName | String | プロジェクト名 |
| projectCreationType | String | プロジェクト作成タイプ<br><br>- USER: 顧客が作成したプロジェクト<br>- SYSTEM: システムで作成したプロジェクト(主に組織サービス、会員型マーケットプレイスで使用) |
| projectStatusCode | String | プロジェクトステータス<br><br>- STABLE: 正常状態<br>- CLOSED: 削除された状態 |


<a id="retrieve-project-usage-details-for-partner-user"></a>
## パートナーユーザーのプロジェクト詳細使用量の照会 { #retrieve-project-usage-details-for-partner-user }

特定プロジェクトの詳細な使用量を照会します。

!!! danger "注意"
    使用量を照会する際は、ページングを適切に使用してパフォーマンスを最適化してください。

!!! tip "パートナー契約の検証"
    当該パートナーとパートナーユーザーが指定された月にパートナー契約を結んでいたか、また当該プロジェクトが属する組織のオーナーがその月にパートナーユーザーであったかを確認します。

<a id="retrieve-project-usage-details-for-partner-user-required-permission"></a>
### 必要な権限 { #retrieve-project-usage-details-for-partner-user-required-permission }
`Partner.Project.Usage.Get`

<a id="retrieve-project-usage-details-for-partner-user-request"></a>
### リクエスト { #retrieve-project-usage-details-for-partner-user-request }

```
GET /v1/billing/partners/{partnerId}/payments/{month}/projects/{projectId}/usage
```

<a id="retrieve-project-usage-details-for-partner-user-request-parameter"></a>
### リクエストパラメータ { #retrieve-project-usage-details-for-partner-user-request-parameter }

| 名前 | 種類 | タイプ | 必須 | 説明 |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | パートナー ID |
| month | Path | String | Y | 利用月（yyyy-MM 形式） |
| projectId | Path | String | Y | プロジェクト ID |
| lang | Header | String | N | 言語設定（デフォルト値: ko_KR、設定可能な値: ko_KR、ja_JP、en_US） |
| isHideContract | Query | Boolean | N | 約定情報の非表示設定（デフォルト値: false / true: パートナーマスキング適用および creditUsages 除外） |
| usageSchemaTypeCode | Query | String | N | 使用量の含有設定<br>使用量の照会方式を従来の方式にするか、新しいグループ化された方式にするかを決定<br>（デフォルト値: NO_GROUP）<br><br>- NO_GROUP: 使用量がグループ化されずそのまま表示される方式 <br>- GROUP_BY_PARENT_RESOURCE: 親リソース別にグループ化されますが、具体的な使用量は提供されない方式。返される totalItems を通じて、親リソースが何件存在するか確認できます<br>- GROUP_BY_PARENT_RESOURCE_INCLUDE_USAGES: 親リソース別にグループ化した後、どの親リソースにグループ化されたかとその詳細な使用量まで提供される方式 |
| categoryMain | Query | String | N | メインカテゴリ<br>usageSchemaTypeCode が NO_GROUP の場合は使用不可 |
| regionTypeCode | Query | String | N | リージョンタイプコード（最大 20 文字）<br>usageSchemaTypeCode が NO_GROUP の場合は使用不可 |
| stationId | Query | String | N | ステーション ID<br>usageSchemaTypeCode が NO_GROUP の場合は使用不可 |
| page | Query | Integer | N | 選択したページ（デフォルト値: 1、最小: 1）<br>usageSchemaTypeCode が NO_GROUP の場合は使用不可 |
| limit | Query | Integer | N | ページに表示される項目数。未入力の場合は全件取得（デフォルト値: 0、最小: 0）<br>usageSchemaTypeCode が NO_GROUP の場合は使用不可 |

<a id="retrieve-project-usage-details-for-partner-user-request-body"></a>
### リクエストボディ { #retrieve-project-usage-details-for-partner-user-request-body }

このAPIはリクエストボディを要求しません。

<a id="retrieve-project-usage-details-for-partner-user-response"></a>
### レスポンス { #retrieve-project-usage-details-for-partner-user-response }

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

<a id="retrieve-project-usage-details-for-partner-user-response-default-response-structure"></a>
#### 基本レスポンス構造

| 名前 | タイプ | 説明 |
| --- | --- | --- |
| project | Project | プロジェクト情報 |

**Project**

| 名前 | タイプ | 説明 |
| --- | --- | --- |
| projectId | String | プロジェクトID |
| projectName | String | プロジェクト名 |
| country | String | 国コード |
| usagePrice | Long | 利用金額 |
| contractUsagePrice | Long | 約定割引/割増が適用された利用金額の合計 |
| contractDiscountPrice | Long | 約定による割引金額 |
| ocpDiscountPrice | Long | Optimized Cost Plans(OCPs) 割引金額 |
| contractExtraPrice | Long | 約定による割増金額 |
| totalAmount | Long | プロジェクト最終金額 |
| totalDiscount | Long | 合計割引金額 |
| totalExtra | Long | 合計割増金額 |
| prePaidTotalAmount | Long | 前払い利用金額 |
| totalCredit | Long | クレジット最終金額 |
| creditUsages | List&lt;CreditUsageProtocol&gt; | クレジット使用金額 |
| projectDiscount | PaymentStatementProjectAdjustment | プロジェクト別割引詳細内訳 |
| projectExtra | PaymentStatementProjectAdjustment | プロジェクト別割増詳細内訳 |
| usageGroups | List&lt;UsageGroup&gt; | 使用量グループ一覧 |

**CreditUsageProtocol**

| 名前 | タイプ | 説明 |
| --- | --- | --- |
| balanceTypeCode | String | キャンペーンタイプ（資金タイプ） |
| balanceTypeName | String | キャンペーンタイプ名（資金タイプ名） |
| i18nBalanceTypeNameMap | Map&lt;String, String&gt; | キャンペーンタイプ名多言語コード |
| usageAmount | Long | クレジット使用金額 |

**PaymentStatementProjectAdjustment**

| 名前 | タイプ | 説明 |
| --- | --- | --- |
| totalAdjustment | Long | 割引/割増金額の合計 |
| details | List&lt;PaymentStatementProjectAdjustmentDetail&gt; | 詳細内訳 |

**PaymentStatementProjectAdjustmentDetail**

| 名前 | タイプ | 説明 |
| --- | --- | --- |
| projectId | String | プロジェクトID |
| projectName | String | プロジェクト名 |
| adjustment | Long | 割引/割増金額 |
| adjustmentTypeCode | String | 割引/割増タイプ<br>- CONTRACT_EXTRA: 約定割増<br>- CONTRACT_PENALTY: 約定違約金<br>- CONTRACT_DISCOUNT: 約定割引<br>- CONTRACT_PAYBACK: パートナーペイバック<br>- STATIC_EXTRA: 固定金額割増<br>- PERCENT_DISCOUNT: パーセント割引<br>- COUPON: クーポン<br>- STATIC_DISCOUNT: 固定金額割引<br>- CUTOFF: 500ウォン未満切り捨て |
| description | String | 割引/割増内訳 |

**UsageGroup**

| 名前 | タイプ | 説明 |
| --- | --- | --- |
| categoryMain | String | メインカテゴリ |
| regionTypeCode | String | リージョン |
| stationId | String | ステーションID |
| stationName | String | ステーション名 |
| needType | Boolean | 区分カラムの表示有無 |
| usagePrice | Long | 利用金額の合計 |
| totalPrice | Long | 約定割引が適用された利用金額の合計 |
| totalDiscount | Long | 合計割引金額 |
| prePaidTotalAmount | Long | 前払い利用金額 |
| totalItems | Integer | UsageGroup別Usage総数 |
| usages | List&lt;Usage&gt; | 詳細使用量一覧 |
| usageResourceGroups | List&lt;UsageResourceGroup&gt; | グループ化された使用量一覧 |

**UsageResourceGroup**

| 名前 | タイプ | 説明 |
| --- | --- | --- |
| parentResourceId | String | 区分のための親リソースID |
| parentResourceName | String | 区分のための親リソース名 |
| usages | List&lt;Usage&gt; | 詳細使用量一覧 |

**Usage**

| 名前 | タイプ | 説明 |
| --- | --- | --- |
| projectId | String | プロジェクトID |
| projectName | String | プロジェクト名 |
| resourceId | String | リソースID |
| parentResourceId | String | 親リソースID |
| resourceName | String | リソース名 |
| parentResourceName | String | 親リソース名 |
| counterName | String | カウンター名 |
| categoryMain | String | メインカテゴリ |
| categorySub | String | サブカテゴリ |
| productUiId | String | ホームページサービスUI ID |
| regionTypeCode | String | リージョン |
| displayNameKo | String | 課金単位の表示名 (ko) |
| displayNameEn | String | 課金単位の表示名 (en) |
| displayNameJa | String | 課金単位の表示名 (ja) |
| displayNameZh | String | 課金単位の表示名 (zh) |
| usage | Double | 使用量 |
| unit | Long | 課金単位 |
| unitPrice | Double | 単位あたりの価格 |
| unitName | String | 単位名 |
| price | Long | 利用金額 |
| useFixPrice | Boolean | 固定金額の有無 |
| displayOrder | Long | 表示順序 |
| contractId | String | 約定ID |
| contractUnitPrice | Double | 約定単価 |
| contractPrice | Long | 約定で計算された利用金額 |
| discountPrice | Long | 割引金額 |
| discountTypeCode | String | 割引タイプコード<br>BASIC、CONTRACT、OCP |
| prePaidAmount | Long | 前払い利用金額 |
| costPlanOrderId | String | Optimized Cost Plans(OCPs) 注文ID |

<a id="retrieve-partners-bill"></a>
## パートナーの請求書照会 { #retrieve-partners-bill }

パートナーの全請求書を照会します。

!!! tip "パートナー契約の検証"
    当該パートナーが指定された月に有効なパートナー契約状態であったかを確認します。

<a id="retrieve-partners-bill-required-permission"></a>
### 必要な権限 { #retrieve-partners-bill-required-permission }
`Partner.Statement.Get`

<a id="retrieve-partners-bill-request"></a>
### リクエスト { #retrieve-partners-bill-request }

```
GET /v1/billing/partners/{partnerId}/payments/{month}/statements
```

<a id="retrieve-partners-bill-request-parameter"></a>
### リクエストパラメータ { #retrieve-partners-bill-request-parameter }

| 名前 | 区分 | 型 | 必須 | 説明 |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | パートナーID |
| month | Path | String | Y | 利用月(yyyy-MM形式) |
| lang | Header | String | N | 言語設定(デフォルト: ko_KR、設定可能な値: ko_KR、ja_JP、en_US) |

<a id="retrieve-partners-bill-request-body"></a>
### リクエストボディ { #retrieve-partners-bill-request-body }

このAPIはリクエストボディを要求しません。

<a id="retrieve-partners-bill-response"></a>
### レスポンス { #retrieve-partners-bill-response }

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

<a id="retrieve-partners-bill-response-default-response-structure"></a>
#### 基本レスポンス構造

| 名前 | タイプ | 説明 |
| --- | --- | --- |
| paymentStatements | List&lt;PaymentStatement&gt; | 請求書リスト |

**PaymentStatement**

| 名前 | タイプ | 説明 |
| --- | --- | --- |
| uuid | String | メンバー UUID |
| autoPaymentTypeCode | String | 決済手段タイプ<br><br>- PAYCO_CREDIT_CARD: ペイコクレジットカード<br>- CREDIT_CARD: クレジットカード<br>- INTER_CREDIT_CARD: 海外クレジットカード<br>- UNION_PAY: ユニオンペイ<br>- JAPAN_BILLING: 日本ビリング<br>- ACCOUNT_TRANSFER: 口座振替<br>- CREDIT_ALL: 一般クレジット<br>- CREDIT_LIMIT: イベントクレジット<br>- ESM: 内部費用<br>- ONETIME_PAYMENT: 一回払い<br>- TAX_BILL: 税金計算書発行<br>- CONTRACT_BILL: 税金計算書発行（別途契約による請求金額調整あり）<br>- NONE: なし |
| isAutoPayment | Boolean | 自動決済手段かどうか |
| paymentInfo | String | 決済手段情報 |
| statements | List&lt;PaymentStatement&gt; | ビリンググループ別決済明細リスト |

**PaymentStatement**

| 名前 | タイプ | 説明 |
| --- | --- | --- |
| paymentGroupId | String | 決済グループ ID |
| month | String | 利用月 |
| charge | Long | 使用金額 |
| supplyAmount | Long | 供給価額 |
| taxAmount | Long | 付加価値税額 |
| totalAmount | Long | 最終金額 |
| totalCredit | Long | クレジット合計使用金額 |
| totalDiscount | Long | 割引金額 |
| totalExtra | Long | 割増金額 |
| freeCredit | Long | 無料クレジット使用金額 |
| freeCreditAll | Long | 無料全体型クレジット使用金額 |
| freeCreditLimit | Long | 無料制限型クレジット使用金額 |
| paidCredit | Long | 有料クレジット使用金額 |
| paidCreditAll | Long | 有料全体型クレジット使用金額 |
| paidCreditLimit | Long | 有料制限型クレジット使用金額 |
| paymentStatusCode | String | 決済ステータス<br><br>- REGISTERED: 登録<br>- READY: 決済待ち<br>- PAID: 決済完了<br>- ERROR: 運営者確認が必要な状態 |
| country | String | 国コード |
| cutoff | Long | cutoff |
| lateFee | Long | 延滞金額 |
| prePaidTotalAmount | Long | 先払い利用金額 |
| realSupplyAmount | Long | 実際の供給価額 |
| realTaxAmount | Long | 実際に決済された付加価値税 |
| receiptStatusCode | String | 売上伝票ステータスコード<br><br>- NONE: まだ経理チームへの売上報告が行われておらず、売上伝票を確認できない状態<br>- EXIST: 最終金額の調整完了後、経理チームへの売上報告が行われ、売上伝票を確認できる状態 |
| refundAccountRegisterStatusCode | String | 返金口座登録状況<br><br>- ALLOW: 返金口座登録 Open 状態<br>- DENY: Default、返金口座登録 Close 状態 |
| details | List&lt;PaymentStatementDetail&gt; | ビリンググループ別詳細明細リスト |

**PaymentStatementDetail**

| 名前 | タイプ | 説明 |
| --- | --- | --- |
| billingGroupId | String | ビリンググループ ID |
| billingGroupName | String | ビリンググループ名 |
| charge | Long | 利用金額 |
| totalDiscount | Long | 割引金額 |
| totalExtra | Long | 割増金額 |
| totalAmount | Long | 最終金額 |
| contractDiscount | Long | 約定割引金額 |
| contractExtra | Long | 約定割増金額 |
| ocpDiscount | Long | Optimized Cost Plans(OCPs) 割引金額 |
| prePaidTotalAmount | Long | 先払い利用金額 |
| totalCredit | Long | クレジット合計使用金額 |
| creditUsages | List&lt;CreditUsageProtocol&gt; | クレジット使用金額 |
| orgList | List&lt;Organization&gt; | 組織リスト |
| usageGroups | List&lt;UsageGroup&gt; | 使用量グループリスト |
| billingGroupDiscount | PaymentStatementBillingGroupAdjustment | ビリンググループ割引詳細 |
| billingGroupExtra | PaymentStatementBillingGroupAdjustment | ビリンググループ割増詳細 |
| projectDiscount | PaymentStatementProjectAdjustment | プロジェクト別割引詳細 |
| projectExtra | PaymentStatementProjectAdjustment | プロジェクト別割増詳細 |

**CreditUsageProtocol**

| 名前 | タイプ | 説明 |
| --- | --- | --- |
| balanceTypeCode | String | キャンペーンタイプ（残高タイプ） |
| balanceTypeName | String | キャンペーンタイプ名（残高タイプ名） |
| i18nBalanceTypeNameMap | Map&lt;String, String&gt; | キャンペーンタイプ名の多言語コード |
| usageAmount | Long | クレジット使用金額 |

**Organization**

| 名前 | タイプ | 説明 |
| --- | --- | --- |
| orgId | String | 組織 ID |
| orgName | String | 組織名 |
| totalAmount | Long | 組織の最終金額 |
| prePaidTotalAmount | Long | 先払い利用金額 |

**UsageGroup**

| 名前 | タイプ | 説明 |
| --- | --- | --- |
| categoryMain | String | メインカテゴリ |
| regionTypeCode | String | リージョン |
| stationId | String | ステーション ID |
| stationName | String | ステーション名 |
| needType | Boolean | 区分カラムの表示有無 |
| usagePrice | Long | 利用金額合計 |
| totalPrice | Long | 約定割引適用後の利用金額合計 |
| totalDiscount | Long | 割引金額合計 |
| prePaidTotalAmount | Long | 先払い利用金額 |
| totalItems | Integer | UsageGroup ごとの Usage 総数 |
| usages | List&lt;Usage&gt; | 詳細使用量リスト |
| usageResourceGroups | List&lt;UsageResourceGroup&gt; | グループ化された使用量リスト |

**PaymentStatementBillingGroupAdjustment**

| 名前 | タイプ | 説明 |
| --- | --- | --- |
| totalAdjustment | Long | 割引/割増金額合計 |
| details | List&lt;PaymentStatementAdjustment&gt; | 詳細 |

**PaymentStatementAdjustment**

| 名前 | タイプ | 説明 |
| --- | --- | --- |
| adjustment | Long | 割引/割増金額 |
| adjustmentTypeCode | String | 割引/割増タイプ<br><br>- CONTRACT_EXTRA: 約定割増<br>- CONTRACT_PENALTY: 約定違約金<br>- CONTRACT_DISCOUNT: 約定割引<br>- CONTRACT_PAYBACK: パートナーペイバック<br>- STATIC_EXTRA: 固定金額割増<br>- PERCENT_DISCOUNT: パーセント割引<br>- COUPON: クーポン<br>- STATIC_DISCOUNT: 固定金額割引<br>- CUTOFF: 500ウォン未満切捨て |
| description | String | 割引/割増内訳 |

**PaymentStatementProjectAdjustment**

| 名前 | タイプ | 説明 |
| --- | --- | --- |
| totalAdjustment | Long | 割引/割増金額合計 |
| details | List&lt;PaymentStatementProjectAdjustmentDetail&gt; | 詳細 |

**PaymentStatementProjectAdjustmentDetail**

| 名前 | タイプ | 説明 |
| --- | --- | --- |
| projectId | String | プロジェクト ID |
| projectName | String | プロジェクト名 |
| adjustment | Long | 割引/割増金額 |
| adjustmentTypeCode | String | 割引/割増タイプ<br><br>- CONTRACT_EXTRA: 約定割増<br>- CONTRACT_PENALTY: 約定違約金<br>- CONTRACT_DISCOUNT: 約定割引<br>- CONTRACT_PAYBACK: パートナーペイバック<br>- STATIC_EXTRA: 固定金額割増<br>- PERCENT_DISCOUNT: パーセント割引<br>- COUPON: クーポン<br>- STATIC_DISCOUNT: 固定金額割引<br>- CUTOFF: 500ウォン未満切捨て |
| description | String | 割引/割増内訳 |

<a id="retrieve-self-service-metering-of-solutions-partner"></a>
## ソリューションパートナーの自社サービスメータリング照会 { #retrieve-self-service-metering-of-solutions-partner }

ソリューションパートナーが自社のサービスに関するメータリング情報を照会します。

!!! tip "ソリューションパートナーの検証"
    ソリューションパートナー、またはソリューションパートナーから権限を付与されたユーザーのみが呼び出し可能です。

<a id="retrieve-self-service-metering-of-solutions-partner-required-permission"></a>
### 必要な権限 { #retrieve-self-service-metering-of-solutions-partner-required-permission }
`Partner.Meter.List`

<a id="retrieve-self-service-metering-of-solutions-partner-request"></a>
### リクエスト { #retrieve-self-service-metering-of-solutions-partner-request }

```
GET /v1/billing/partners/{partnerId}/products/{productId}/meters
```

<a id="retrieve-self-service-metering-of-solutions-partner-request-parameter"></a>
### リクエストパラメータ { #retrieve-self-service-metering-of-solutions-partner-request-parameter }

| 名前 | 区分 | 型 | 必須 | 説明 |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | パートナーID |
| productId | Path | String | Y | サービスID |
| from | Query | String | Y | 照会開始時間(ISO 8601形式、含む) |
| to | Query | String | Y | 照会終了時間(ISO 8601形式、含まない) |
| counterName | Query | String | Y | カウンター名 |
| appKey | Query | String | N | アプリキーリスト |
| meterTimeTypeCode | Query | String | N | メーター時間タイプコード<br><br>- INSERT_TIME:メータリング挿入時間基準<br>- USED_TIME:メータリング発生時間基準 |
| page | Query | Integer | Y | 選択したページ(最小: 1) |
| limit | Query | Integer | Y | ページに表示される項目数(最小: 1、最大: 2000) |

<a id="retrieve-self-service-metering-of-solutions-partner-request-body"></a>
### リクエストボディ { #retrieve-self-service-metering-of-solutions-partner-request-body }

このAPIはリクエストボディを要求しません。

<a id="retrieve-self-service-metering-of-solutions-partner-response"></a>
### レスポンス { #retrieve-self-service-metering-of-solutions-partner-response }

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
| meterList | List&lt;MeterProtocol&gt; | メータリング一覧 |
| totalItems | Integer | 全項目数 |

**MeterProtocol**

| 名前 | タイプ | 説明 |
| --- | --- | --- |
| appKey | String | サービスアプリキー |
| counterName | String | カウンター名 |
| counterType | String | カウンタータイプ<br><br>- DELTA: 増分値<br>- GAUGE: 現在値<br>- HOURLY_LATEST: 時間別最新値<br>- DAILY_MAX: 日別最大値<br>- MONTHLY_MAX: 月別最大値<br>- STATUS: ステータス値 |
| counterUnit | String | カウンター単位 |
| counterValue | String | 使用状況(counterTypeがSTATUSの場合にのみ使用) |
| counterVolume | BigDecimal | カウンターボリューム |
| gmid | String | グローバルメータリングID |
| insertTime | String | メータリング挿入時刻 |
| orgId | String | 組織ID |
| parentResourceId | String | 親リソースID |
| productId | String | サービスID |
| projectId | String | プロジェクトID |
| resourceId | String | リソースID |
| resourceName | String | リソース名 |
| source | String | メータリングが発生したIPまたはホスト名 |
| stationId | String | ステーションID |
| timestamp | String | メータリング発生時刻 |

<a id="delete-metering-for-solution-partners"></a>
## ソリューションパートナーのメータリング削除 { #delete-metering-for-solution-partners }

ソリューションパートナーが自身のサービスに対するメータリングを削除します。<br>
すでに請求書が生成された後のメータリングは削除しても反映されない点に留意する必要があり、ソリューションパートナーが自身のサービス以外の他のサービスのメータリングを削除することはできません。<br>
削除は時間がかかる作業であるため非同期で動作し、削除API呼び出し後に返却されたasyncJobIdでステータスを照会し、完了可否を確認できます。

!!! tip "ソリューションパートナー検証"
    ソリューションパートナー、またはソリューションパートナーから権限を付与されたユーザーのみ呼び出し可能です。

<a id="delete-metering-for-solution-partners-required-permission"></a>
### 必要権限 { #delete-metering-for-solution-partners-required-permission }
`Partner.Meter.Delete`

<a id="delete-metering-for-solution-partners-request"></a>
### リクエスト { #delete-metering-for-solution-partners-request }

```
DELETE /v1/billing/partners/{partnerId}/products/{productId}/meters
```

<a id="delete-metering-for-solution-partners-request-parameter"></a>
### リクエストパラメータ { #delete-metering-for-solution-partners-request-parameter }

| 名前 | 区分 | タイプ | 必須 | 説明 |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | パートナーID |
| productId | Path | String | Y | サービスID |


<a id="delete-metering-for-solution-partners-request-body"></a>
### リクエスト本文 { #delete-metering-for-solution-partners-request-body }

<details>
  <summary><strong>例示コード</strong></summary>

```json
{
  "from": "2023-12-01T10:00:00Z",
  "to": "2023-12-02T10:00:00Z",
  "appKey": "string",
  "counterNames": [
    "string"
  ]
}
```

</details>

| 名前 | タイプ | 必須 | 説明 |
| --- | --- | --- | --- |
| from | String | Y | 照会開始時間(ISO 8601形式、含む) |
| to | String | Y | 照会終了時間(ISO 8601形式、含まない) |
| appKey | String | N | 商品アプリキー<br>アプリキー、 またはカウンター名のいずれかは必須 |
| counterNames | List&lt;String&gt; | N | 削除するカウンター名リスト<br>アプリキー、またはカウンター名のいずれかは必須 |


<a id="delete-metering-for-solution-partners-response"></a>
### レスポンス { #delete-metering-for-solution-partners-response }

<details>
  <summary><strong>レスポンス例</strong></summary>

```json
{
  "asyncJobId": "string",
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "string"
  }
}
```

</details>

| 名前 | タイプ | 説明 |
| --- | --- | --- |
| asyncJobId | String | 実行した非同期作業のID |


<a id="confirm-deletion-of-solution-partners-metering"></a>
## ソリューションパートナーのメータリング削除確認 { #confirm-deletion-of-solution-partners-metering }

メータリング削除後、削除が完了したか確認します。<br>
削除API呼び出し後、5秒以降に呼び出すのが安全であり、すぐに呼び出すと失敗する可能性があるため注意が必要です。<br>
その後、5秒周期で呼び出してステータスを確認することを推奨します。

!!! tip "ソリューションパートナー検証"
    ソリューションパートナー、またはソリューションパートナーから権限を付与されたユーザーのみ呼び出し可能です。

!!! danger "メータリング削除確認時の注意事項"
    一度正常削除を確認した後は削除jobが消えるため一度のみ呼び出し可能であり、2回目の呼び出しからは16500エラーが返却されます。

<a id="confirm-deletion-of-solution-partners-metering-required-permission"></a>
### 必要権限 { #confirm-deletion-of-solution-partners-metering-required-permission }
`Partner.Meter.Delete`

<a id="confirm-deletion-of-solution-partners-metering-request"></a>
### リクエスト { #confirm-deletion-of-solution-partners-metering-request }

```
GET /v1/billing/partners/{partnerId}/meters/jobs/{async-job-id}
```

<a id="confirm-deletion-of-solution-partners-metering-request-parameter"></a>
### リクエストパラメータ { #confirm-deletion-of-solution-partners-metering-request-parameter }

| 名前 | 区分 | タイプ | 必須 | 説明 |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | パートナーID |
| asyncJobId | Path | String | Y | 実行した非同期作業のID |


<a id="confirm-deletion-of-solution-partners-metering-request-body"></a>
### リクエスト本文 { #confirm-deletion-of-solution-partners-metering-request-body }

このAPIはリクエスト本文を要求しません。

<a id="confirm-deletion-of-solution-partners-metering-response"></a>
### レスポンス { #confirm-deletion-of-solution-partners-metering-response }

<details>
  <summary><strong>レスポンス例</strong></summary>

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "string"
  },
  "statusCode": "IN_PROGRESS"
}
```

</details>

| 名前 | タイプ | 説明 |
| --- | --- | --- |
| statusCode | String | 削除ステータス(IN_PROGRESS: 削除進行中、ERROR: 削除中にエラー発生、SUCCESS: 削除成功) |

<a id="create-organization-for-partner-user"></a>
## パートナーユーザーの組織作成 { #create-organization-for-partner-user }

パートナーがパートナーユーザーの組織を作成します。

!!! tip "パートナー契約の検証"
    APIを呼び出した月に、当該パートナーとパートナーユーザーがパートナー契約関係にあったかを確認します。

<a id="create-organization-for-partner-user-required-permission"></a>
### 必要な権限 { #create-organization-for-partner-user-required-permission }
`Partner.Organization.Create`

<a id="create-organization-for-partner-user-request"></a>
### リクエスト { #create-organization-for-partner-user-request }

```
POST /v1/partners/{partnerId}/partner-users/{partnerUserUuid}/organizations
```

<a id="create-organization-for-partner-user-request-parameter"></a>
### リクエストパラメータ { #create-organization-for-partner-user-request-parameter }

| 名前 | 区分 | 型 | 必須 | 説明 |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | パートナーID |
| partnerUserUuid | Path | String | Y | パートナーユーザーUUID |

<a id="create-organization-for-partner-user-request-body"></a>
### リクエストボディ { #create-organization-for-partner-user-request-body }

| 名前 | 型 | 必須 | 説明 |
| --- | --- | --- | --- |
| orgName | String | Y | 作成する組織名(最大120文字) |

<a id="create-organization-for-partner-user-response"></a>
### レスポンス { #create-organization-for-partner-user-response }

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


<a id="delete-organization-of-partner-user"></a>
## パートナーユーザーの組織削除 { #delete-organization-of-partner-user }

パートナーがパートナーユーザーの組織を削除します。

!!! tip "パートナー契約の検証"
    APIを呼び出した月に当該パートナーとパートナーユーザーがパートナー契約関係にあったか、また削除対象がパートナーユーザーの組織であるかを確認します。

<a id="delete-organization-of-partner-user-required-permission"></a>
### 必要な権限 { #delete-organization-of-partner-user-required-permission }
`Partner.Organization.Delete`

<a id="delete-organization-of-partner-user-request"></a>
### リクエスト { #delete-organization-of-partner-user-request }

```
DELETE /v1/partners/{partnerId}/partner-users/{partnerUserUuid}/organizations/{orgId}
```

<a id="delete-organization-of-partner-user-request-parameter"></a>
### リクエストパラメータ { #delete-organization-of-partner-user-request-parameter }

| 名前 | 区分 | 型 | 必須 | 説明 |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | パートナーID |
| partnerUserUuid | Path | String | Y | パートナーユーザーUUID |
| orgId | Path | String | Y | 削除する組織ID |

<a id="delete-organization-of-partner-user-request-body"></a>
### リクエストボディ { #delete-organization-of-partner-user-request-body }

このAPIはリクエストボディを要求しません。

<a id="delete-organization-of-partner-user-response"></a>
### レスポンス { #delete-organization-of-partner-user-response }

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

<a id="daily-usage-pricing"></a>
## 日別利用金額照会 { #daily-usage-pricing }

パートナーユーザーの日別利用金額詳細明細を照会します。

!!! tip "パートナー契約検証"
    該当パートナーが指定されたプロジェクトや組織のOwnerであるか、Ownerと照会対象日にパートナー契約を締結した状態であったかを確認します。

!!! tip "照会範囲制約"
    - projectIdまたはorgIdのいずれかは必ず設定する必要があります。
    - projectIdとorgIdを同時に設定することはできません。

<a id="required-permissions"></a>
### 必要な権限 { #required-permissions }
`Partner.Daily.Usage.List`

<a id="daily-usage-pricing-request"></a>
### リクエスト { #daily-usage-pricing-request }

```
GET /v1/billing/partners/{partnerId}/daily-usage-prices
```

<a id="request-parameters"></a>
### リクエストパラメータ { #request-parameters }

| 名前 | 区分 | タイプ | 必須 | 説明 |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | パートナーID |
| projectId | Query | String | N | プロジェクトID<br>orgIdと同時に設定不可 |
| orgId | Query | String | N | 組織ID<br>projectIdと同時に設定不可 |
| counterName | Query | String | N | カウンター名 |
| date | Query | String | Y | 照会日(yyyy-MM-dd形式) |
| page | Query | Integer | N | 選択したページ(最小: 1) |
| limit | Query | Integer | N | ページに表示される項目数(最小: 1、最大: 2000) |

<a id="daily-usage-pricing-request-body"></a>
### リクエスト本文 { #daily-usage-pricing-request-body }

このAPIはリクエスト本文を要求しません。

<a id="daily-usage-pricing-response"></a>
### レスポンス { #daily-usage-pricing-response }

<details>
  <summary><strong>レスポンス例</strong></summary>

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "SUCCESS"
  },
  "projectDailyUsagePrices": [
    {
      "basicPrice": 0,
      "billingGroupId": "billing123",
      "contractId": "contract123",
      "contractPrice": 0,
      "counterName": "c2.small",
      "deltaBasicPrice": 0,
      "deltaContractPrice": 0,
      "deltaUsage": 0,
      "metadata": {},
      "orgId": "org123",
      "parentResourceId": "parent-resource-123",
      "parentResourceName": "親リソース",
      "paymentGroupId": "payment123",
      "priceInformation": [
        {}
      ],
      "projectId": "project123",
      "resourceId": "resource123",
      "resourceName": "test-resource",
      "usage": 0,
      "usedDate": "2024-01-01",
      "uuid": "user123"
    }
  ],
  "totalItems": 1
}
```

</details>

<a id="daily-usage-pricing-response-basic-response-structure"></a>
#### 基本レスポンス構造

| 名前 | タイプ | 説明 |
| --- | --- | --- |
| projectDailyUsagePrices | List&lt;DailyUsagePrice&gt; | 日別利用金額一覧 |
| totalItems | Integer | 照会された結果件数 |

**DailyUsagePrice**

| 名前 | タイプ | 説明 |
| --- | --- | --- |
| basicPrice | Long | 従量制金額 |
| billingGroupId | String | ビリンググループID |
| contractId | String | 約定ID |
| contractPrice | Long | 約定金額 |
| counterName | String | カウンター名 |
| deltaBasicPrice | Long | 日別従量制金額 |
| deltaContractPrice | Long | 日別約定金額 |
| deltaUsage | BigDecimal | 日別使用量 |
| metadata | Map&lt;String, Object&gt; | メタデータ |
| orgId | String | 組織ID |
| parentResourceId | String | 親リソースID |
| parentResourceName | String | 親リソース名 |
| paymentGroupId | String | 決済グループID |
| priceInformation | List&lt;Map&lt;String, Object&gt;&gt; | 単価情報 |
| projectId | String | プロジェクトID |
| resourceId | String | リソースID |
| resourceName | String | リソース名 |
| usage | BigDecimal | 使用量 |
| usedDate | String | 使用日時 |
| uuid | String | 会員UUID |


<a id="retrieve-resource-usage-prices-by-tag"></a>
## タグ別リソース利用金額照会 { #retrieve-resource-usage-prices-by-tag }

タグ別に分類されたリソースの利用金額を照会します。

!!! tip "パートナー契約検証"
    該当パートナーが指定されたプロジェクトや組織のOwnerであるか、Ownerと照会対象日にパートナー契約を締結した状態であったかを確認します。

!!! tip "照会範囲制約"
    - projectIdまたはorgIdのいずれかは必ず提供する必要があります。
    - projectIdとorgIdを同時に設定することはできません。
    - tagIdsまたはgroupIdsのいずれかは必ず提供する必要があります。

<a id="retrieve-resource-usage-prices-by-tag-required-permissions"></a>
### 必要な権限 { #retrieve-resource-usage-prices-by-tag-required-permissions }
`Partner.Daily.Usage.List`

<a id="retrieve-resource-usage-prices-by-tag-request"></a>
### リクエスト { #retrieve-resource-usage-prices-by-tag-request }

```
POST /v1/billing/partners/{partnerId}/resource-usage-prices-by-tag
```

<a id="retrieve-resource-usage-prices-by-tag-request-parameters"></a>
### リクエストパラメータ { #retrieve-resource-usage-prices-by-tag-request-parameters }

| 名前 | 区分 | タイプ | 必須 | 説明 |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | パートナーID |
| page | Query | Integer | N | 選択したページ(最小: 1) |
| limit | Query | Integer | N | ページに表示される項目数(最小: 1、最大: 2000) |

<a id="retrieve-resource-usage-prices-by-tag-request-body"></a>
### リクエスト本文 { #retrieve-resource-usage-prices-by-tag-request-body }

<details>
  <summary><strong>リクエスト例</strong></summary>

```json
{
  "date": "2024-01-01",
  "groupIds": [
    "group123"
  ],
  "orgId": "org123",
  "projectId": "project123",
  "searchType": "RESOURCE",
  "tagIds": [
1001
  ]
}
```

</details>

| 名前 | タイプ | 必須 | 説明 |
| --- | --- | --- | --- |
| date | String | Y | 照会開始日(yyyy-MM-dd形式) |
| groupIds | List&lt;String&gt; | N | グループIDリスト<br>tagIdsまたはgroupIdsのいずれかは必須 |
| orgId | String | N | 組織ID<br>projectIdまたはorgIdのいずれかは必須 |
| projectId | String | N | プロジェクトID<br>projectIdまたはorgIdのいずれかは必須 |
| searchType | String | Y | 照会タイプ<br><br>- RESOURCE: リソース別<br>- DAILY: 日別 |
| tagIds | List&lt;Long&gt; | N | タグIDリスト<br>tagIdsまたはgroupIdsのいずれかは必須 |

<a id="retrieve-resource-usage-prices-by-tag-response"></a>
### レスポンス { #retrieve-resource-usage-prices-by-tag-response }

<details>
  <summary><strong>レスポンス例</strong></summary>

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "SUCCESS"
  },
  "resourceUsagePrices": [
    {
      "basicPrice": 100000,
      "billingGroupId": "billing123",
      "billingGroupName": "基本ビリンググループ",
      "categoryMain": "COMPUTE",
      "categorySub": "INSTANCE",
      "contractId": "contract123",
      "contractPrice": 95000,
      "counterName": "c2.small",
      "country": "KR",
      "displayOrder": "1",
      "orgId": "org123",
      "orgName": "テスト組織",
      "parentResourceId": "parent-resource-123",
      "paymentGroupId": "payment123",
      "priceInformation": "単価情報",
      "priceInformations": [
        {
          "basicUnitPrice": 1000.0,
          "contractUnitPrice": 950.0,
          "displayName": {
            "displayNameEn": "c2.small Instance",
            "displayNameJa": "c2.small インスタンス",
            "displayNameKo": "c2.smallインスタンス",
            "displayNameZh": "c2.small 实例"
          },
          "rangeFrom": 0,
          "slidingCalculationTypeCode": "NONE",
          "unit": 1,
          "unitName": "hours"
        }
      ],
      "productId": "compute",
      "productUiId": "compute-instance",
      "projectId": "project123",
      "projectName": "テストプロジェクト",
      "regionTypeCode": "KR",
      "resourceId": "resource123",
      "usage": 100.0,
      "useFixPriceYn": "N",
      "usedDate": "2024-01-01"
    }
  ],
  "totalItems": 1,
  "totalPrice": 95000
}
```

</details>

<a id="retrieve-resource-usage-prices-by-tag-response-basic-response-structure"></a>
#### 基本レスポンス構造

| 名前 | タイプ | 説明 |
| --- | --- | --- |
| resourceUsagePrices | List&lt;ResourceUsagePrice&gt; | リソース利用金額一覧 |
| totalItems | Integer | 照会された結果件数 |
| totalPrice | Long | 全体利用金額 |

**ResourceUsagePrice**

| 名前 | タイプ | 説明 |
| --- | --- | --- |
| basicPrice | Long | 従量制金額 |
| billingGroupId | String | ビリンググループID |
| billingGroupName | String | ビリンググループ名 |
| categoryMain | String | メインカテゴリー |
| categorySub | String | サブカテゴリー |
| contractId | String | 約定ID |
| contractPrice | Long | 約定金額 |
| counterName | String | カウンター名 |
| country | String | サービス国 |
| displayOrder | String | 請求書表示順序 |
| orgId | String | 組織ID |
| orgName | String | 組織名 |
| parentResourceId | String | 親リソースID |
| paymentGroupId | String | 決済グループID |
| priceInformation | String | 単価情報 |
| priceInformations | List&lt;PriceInfo&gt; | 単価情報(詳細) |
| productId | String | サービスID |
| productUiId | String | WebサイトサービスUI ID |
| projectId | String | プロジェクトID |
| projectName | String | プロジェクト名 |
| regionTypeCode | String | リージョンタイプコード |
| resourceId | String | リソースID |
| usage | BigDecimal | 使用量 |
| useFixPriceYn | String | 定額料金使用有無 |
| usedDate | String | 使用日 |

**PriceInfo**

| 名前 | タイプ | 説明 |
| --- | --- | --- |
| basicUnitPrice | BigDecimal | 従量制単位価格 |
| contractUnitPrice | BigDecimal | 約定制単位価格 |
| displayName | DisplayName | 請求書表示名 |
| rangeFrom | BigDecimal | 開始範囲 |
| slidingCalculationTypeCode | String | スライディング料金計算タイプ<br><br>- NONE: なし<br>- SECTION_SUM: 区間合計<br>- SECTION_SELECTED: 区間選択 |
| unit | Long | 単位 |
| unitName | String | 単位名 |

**DisplayName**

| 名前 | タイプ | 説明 |
| --- | --- | --- |
| displayNameEn | String | 請求書表示名(英語) |
| displayNameJa | String | 請求書表示名(日本語) |
| displayNameKo | String | 請求書表示名(韓国語) |
| displayNameZh | String | 請求書表示名(中国語) |


<a id="retrieve-active-organizationproject-product-metering-for-partners-or-partner-users"></a>
## パートナーまたはパートナーユーザーの有効化された組織/プロジェクト商品メータリング照会 { #retrieve-active-organizationproject-product-metering-for-partners-or-partner-users }

メータリング情報を照会します。

<a id="retrieve-active-organizationproject-product-metering-for-partners-or-partner-users-required-permission"></a>
### 必要権限 { #retrieve-active-organizationproject-product-metering-for-partners-or-partner-users-required-permission }
`Partner.Meter.List`

<a id="retrieve-active-organizationproject-product-metering-for-partners-or-partner-users-request"></a>
### リクエスト { #retrieve-active-organizationproject-product-metering-for-partners-or-partner-users-request }

```
POST /v1/billing/partners/{partnerId}/meters/search
```

<a id="retrieve-active-organizationproject-product-metering-for-partners-or-partner-users-request-parameter"></a>
### リクエストパラメータ { #retrieve-active-organizationproject-product-metering-for-partners-or-partner-users-request-parameter }

| 名前 | 区分 | タイプ | 必須 | 説明 |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | パートナーID |
| page | Query | Integer | N | 選択したページ(最小: 1) |
| limit | Query | Integer | N | ページに表示される項目数(最小: 1、最大: 2000) |


<a id="retrieve-active-organizationproject-product-metering-for-partners-or-partner-users-request-body"></a>
### リクエスト本文 { #retrieve-active-organizationproject-product-metering-for-partners-or-partner-users-request-body }

<details>
  <summary><strong>例示コード</strong></summary>

```json
{
  "from": "2023-12-01T10:00:00Z",
  "to": "2023-12-02T10:00:00Z",
  "appKeys": [
    "string"
  ],
  "counterNames": [
    "string"
  ],
  "meterTimeTypeCode": "INSERT_TIME"
}
```

</details>

| 名前 | タイプ | 必須 | 説明 |
| --- | --- | --- | --- |
| from | String | Y | 照会開始時間(ISO 8601形式、含む) |
| to | String | Y | 照会終了時間(ISO 8601形式、含まない) |
| appKeys | List&lt;String&gt; | N | アプリキーリスト |
| counterNames | List&lt;String&gt; | N | カウンター名リスト |
| meterTimeTypeCode | String | N | メーター時間タイプコード<br>from、toに対して使用時間で検索するか、またはリクエストが流入した時間で検索するかを決定<br>(USED_TIME: 使用時間(デフォルト値)、INSERT_TIME: 流入した時間) |


<a id="retrieve-active-organizationproject-product-metering-for-partners-or-partner-users-response"></a>
### レスポンス { #retrieve-active-organizationproject-product-metering-for-partners-or-partner-users-response }

<details>
  <summary><strong>レスポンス例</strong></summary>

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "string"
  },
  "meterList": [
    {
      "appKey": "string",
      "counterName": "string",
      "counterType": "DELTA",
      "counterUnit": "string",
      "counterValue": "string",
      "counterVolume": 0,
      "insertTime": "2023-12-01T10:00:00Z",
      "orgId": "string",
      "parentResourceId": "string",
      "productId": "string",
      "projectId": "string",
      "resourceId": "string",
      "resourceName": "string",
      "stationId": "string",
      "timestamp": "2023-12-01T10:00:00Z"
    }
  ],
  "totalItems": 0
}
```

</details>

| 名前 | タイプ | 説明 |
| --- | --- | --- |
| meterList | List&lt;MeterProtocol&gt; | メータリングリスト |
| totalItems | Integer | 総個数 |

**MeterProtocol**

| 名前 | タイプ | 説明 |
| --- | --- | --- |
| appKey | String | アプリキー |
| counterName | String | カウンター名 |
| counterType | String | カウンタータイプ<br><br>- DELTA: 増分値<br>- GAUGE: 現在値<br>- HOURLY_LATEST: 時間別最新値<br>- DAILY_MAX: 日別最大値<br>- MONTHLY_MAX: 月別最大値<br>- STATUS: ステータス値 |
| counterUnit | String | 使用量単位(KB、HOURなど) |
| counterValue | String | 使用現況<br>カウンタータイプがSTATUSの場合のみ使用 |
| counterVolume | BigDecimal | 使用量 |
| insertTime | String | サービスから課金システムに送信した時間 |
| orgId | String | 組織ID |
| parentResourceId | String | 親リソースID |
| productId | String | サービスID |
| projectId | String | プロジェクトID |
| resourceId | String | リソースID |
| resourceName | String | リソース名 |
| stationId | String | ステーションID |
| timestamp | String | 使用した時間 |

<a id="error-code"></a>
## エラーコード { #error-code }

| resultCode | 説明 | 対処方法 |
| --- | --- | --- |
| -14 | 許可されていない国の IP からのリクエスト | 許可された国からリクエストするか、国別 IP 制限ポリシーを確認します |
| -8 | リクエスト IP が許可されていない、または組織 IP ACL ポリシーによる IP 検証失敗 | 組織 IP ACL に該当 IP が登録されているか確認し、許可された IP 帯域からリクエストします |
| -7 | アクセス許可なし | 該当の操作に対するアクセス許可がないため、システム管理者にお問い合わせください |
| -6 | 呼び出した API に対して呼び出し元の認可が失敗した場合に発生するエラー、またはパートナー権限検証失敗 | 呼び出し元に API 呼び出し権限があるか確認し、必要に応じてシステム管理者に問い合わせて呼び出し権限を申請します。呼び出しアカウントの権限とリクエストスコープのパートナー ID を確認します |
| -5 | アクセス拒否 - 所有者ではない、または削除しようとしている組織の実際のオーナーがリクエストしたパートナーユーザーと異なる | リクエスト元が該当組織の所有者であるか確認し、対象組織が該当パートナーユーザーの所有であるかを確認します |
| -4 | アクセス拒否 - メンバーではない | リクエスト元が該当パートナーのメンバーであるか確認し、適切な権限を付与された後に再試行します |
| -2 | パラメーターが不正な場合に発生するエラー | リクエストパラメーターの形式と値を確認し、正しい値で再試行します |
| 404 | 存在しない API を呼び出した場合に発生 | 呼び出す API の HTTP メソッドと URI を確認します |
| 500 | 異常なシステムエラー | システム管理者にお問い合わせください |
| 501 | 不正な日付形式 | 日付パラメーターを正しい形式で指定します |
| 502 | 不正なパラメーター | リクエストパラメーターの値と形式を確認します |
| 503 | サービス利用不可または照会期間ルール違反 | サービスが一時的に利用不可能な状態のため、しばらく後に再試行するか、照会期間ルールに従ってリクエストします |
| 504 | JSON パース失敗 | リクエスト本文の JSON 形式を確認します |
| 505 | 検証失敗 | リクエストのフィールド有効性検証を確認します |
| 1000 | パラメーターが不正な場合に発生するエラー | リクエストパラメーターの形式と値を確認し、正しい値で再試行します |
| 1200 | API 呼び出し失敗 | しばらく後に再試行するか、システム状態を確認します |
| 10005 | リクエストパラメーターが適切でない場合に発生するエラー | リクエストパラメーターの必須値および設定可能な値などを確認します |
| 11010 | 使用量照会権限不足 | サービス/カウンター/組織に対する権限を確認し、付与します |
| 11012 | 組織へのアクセス権限なし | ユーザーに該当組織へのアクセス権限を付与します |
| 11013 | メンバーがパートナーユーザーではない、または指定したパートナー ID とパートナーユーザー UUID が一致しない | 該当メンバーが指定期間にパートナーユーザーであるか確認し、パートナー関係を再設定します。パートナーユーザーが該当パートナーに承認・連携されているか確認します |
| 12000 | プロジェクトが見つからない | リクエストしたプロジェクト ID が存在するか確認し、正しいプロジェクト ID で再試行します |
| 12100 | プロジェクトメンバーが存在しない場合に発生するエラー | 存在するプロジェクトメンバーの UUID を使用します |
| 16500 | 非同期タスクが見つからない | 不正な非同期 ID でリクエストしていないか確認します |
| 17001 | アプリキーが見つからない | アプリキーが正常に発行されているか確認し、必要に応じて再発行します |
| 17003 | アプリキーとプロジェクト/サービスの紐付けなし | アプリキーを正しいプロジェクト/サービスと紐付けます |
| 17501 | 組織が見つからない | 組織 ID の存在を確認します |
| 18001 | プロジェクトが見つからない | プロジェクト ID の存在を確認します |
| 22001 | パートナーデフォルトグループなし | パートナーデフォルトグループの設定を確認します |
| 22002 | パートナー決済グループなし | パートナー決済グループの設定を確認します |
| 22003 | パートナー調整値範囲エラー | パートナー調整値が許容範囲内であるか確認します |
| 22004 | ソリューションパートナーサービスではない | リクエストサービスが該当ソリューションパートナーサービスであるか確認します |
| 22005 | ソリューションパートナーではない | パートナーがソリューションパートナーの資格を備えているか確認します |
| 22007 | 該当パートナーにアクセス権限なし | パートナーが該当リソースにアクセスする権限がない状態のため、照会対象のリソースが自身のリソースであるか、または自身が照会可能な対象のリソースであるか確認します |
| 22008 | 該当サービスのアプリキーではない | 不正なアプリキーでリクエストしていないか確認します |
| 22009 | 該当サービスのカウンター名ではない | 不正なカウンター名でリクエストしていないか確認します |
| 22021 | 組織作成時、組織オーナーアカウントに設定された組織作成数の上限を超えた場合に発生するエラー | 1) 使用していない組織を削除して作成可能な組織数を確保します <br>2) システム管理者を通じて組織作成の最大数を調整します |
| 22023 | MSP パートナーの上限を超えたため、組織の作成が制限されている | MSP パートナーの上限を調整するか、組織を整理します |
| 23005 | 組織 ID に該当する組織が存在しない場合に発生するエラー | システム管理者にお問い合わせください |
| 24000 | API 連携失敗 | システム管理者にお問い合わせください |
| 24001 | アプリキー有効性検証失敗 | アプリキーの有効性を確認します |
| 24002 | メンバー情報有効性検証失敗 | メンバー情報を確認します |
| 24005 | プロジェクトメンバーなし | 該当メンバーがプロジェクトに所属しているか確認します |
| 24007 | プロジェクトなし | プロジェクト ID を確認するか、システム管理者にお問い合わせください |
| 25001 | 国別税率ポリシーなし | システム管理者にお問い合わせください |
| 70013 | 利用中のサービスが存在する場合に発生するエラー | 利用中のサービスを無効にします |
| 70032 | 未払い制裁により組織の作成がブロックされている | 未払いを解消し、制裁解除を申請した後に再試行します |
| 80400 | 不正なリクエスト | リクエストパラメーターの形式および必須値を確認します |
| 80401 | 認証失敗 | 認証トークンの有効性およびログイン状態を確認します |
| 80500 | サーバーエラー | サーバーログを確認後、システム管理者にお問い合わせください |

