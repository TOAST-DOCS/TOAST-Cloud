<!-- pre-align:aligned sig=a874d1711b7d -->

# Partner Management API Guide

**NHN Cloud > Public API User Guide > Partner Management API Guide**

<a id="common-information-for-partner-management-api"></a>
## Common Information for Partner Management API { #common-information-for-partner-management-api }

<a id="api-endpoint"></a>
### API Endpoint { #api-endpoint }

An endpoint information for calling partner management API.<br>
This API can only be called by partners or users authorized by partners, and cannot be used by general users.

| Region     | Endpoint |
|--------| ----- |
| Global | https://core.api.nhncloudservice.com/ |

<a id="authentication-and-permission"></a>
### Authentication and Permission { #authentication-and-permission }

Partner Management API uses User Access Key tokens for authentication and authorization when making API calls. The User Access Key token is a temporary, Bearer-type access token issued from a User Access Key. For more information on issuing and using User Access Key tokens, please refer to the [User Access Key Token](./user-access-key-token/).

| Header name | Description |
| --- | --- |
| x-nhn-authorization | Refer to the token for API authentication |

<a id="response-common-information"></a>
### Response Common Information { #response-common-information }

All APIs have the following common response structure:

<details>
  <summary><strong>Success Response</strong></summary>

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
  <summary><strong>Failure Response</strong></summary>

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

| Name | Type | Description |
| --- | --- | --- |
| header.isSuccessful | Boolean | Success |
| header.resultCode | Integer | Result code (for success) |
| header.resultMessage | String | Result message |

!!! danger "API Response Field Extensibility"
    API Responses may contain additional fields not specified below. Be careful that new fields are added and no error occurs.


<a id="view-organization-usage-list-of-partner-users"></a>
## View Organization Usage List of Partner Users { #view-organization-usage-list-of-partner-users }

Provide the partner user's billing amount, usage fee per organization, usage fee per service, and surcharge information.

!!! tip "Verify Partner Agreement"
    Verify that the partner and partner user entered into a partnership agreement in the specified month.

!!! tip "Notice"
    The month of use must be entered in yyyy-MM format.

<a id="required-permission"></a>
### Required Permission { #required-permission }
`Partner.Payment.Get`

<a id="request"></a>
### Request { #request }

```
GET /v1/billing/partners/{partnerId}/payments/{month}
```

<a id="request-parameter"></a>
### Request Parameter { #request-parameter }

| Name | Category | Type | Required | Description |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | Partner ID |
| month | Path | String | Y | Month of use (yyyy-MM format) |
| partnerUserUuid | Query | String | Y | Partner user UUID |
| lang | Header | String | N | Language setting (default: ko_KR, selectable value: ko_KR, ja_JP, en_US) |

<a id="request-body"></a>
### Request Body { #request-body }

This API does not require a request body.

<a id="response"></a>
### Response { #response }

<details>
  <summary><strong>Response Example</strong></summary>

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
    "currency": "원",
    "orgList": [
      {
        "orgName": "테스트 조직",
        "charge": 100000
      }
    ],
    "usageSummaryList": [
      {
        "categoryMain": "COMPUTE",
        "categorySub": "INSTANCE",
        "counterName": "c2.small",
        "displayName": "c2.small 인스턴스",
        "displayOrder": 1,
        "price": 50000,
        "usage": 100.0
      }
    ],
    "extraSummaryList": [
      {
        "description": "프로젝트 할증",
        "extraPrice": 5000
      }
    ]
  }
}
```

</details>

<a id="response-default-response-structure"></a>
#### Default Response Structure

| Name | Type | Description |
| --- | --- | --- |
| payment | PartnerUserOrgUsage | Payment info |

**PartnerUserOrgUsage**

| Name | Type | Description |
| --- | --- | --- |
| charge | Long | Usage Amount + Project Surcharge Amount |
| totalAmount | Long | Charge Amount (Usage Amount + VAT) |
| taxAmount | Long | VAT |
| currency | String | Currency<br>Returned in the appropriate language based on lang |
| orgList | List&lt;GetPartnerUserOrgUsages&gt; | Usage List by Organization |
| usageSummaryList | List&lt;UsageSummary&gt; | Usage Summary List |
| extraSummaryList | List&lt;ProjectExtra&gt; | Project Surcharge Summary List |

**GetPartnerUserOrgUsages**

| Name | Type | Description |
| --- | --- | --- |
| orgName | String | Organization name |
| charge | Long | Amount used by organization |

**UsageSummary**

| Name | Type | Description |
| --- | --- | --- |
| categoryMain | String | Main category |
| categorySub | String | Sub category |
| counterName | String | Counter name |
| displayName | String | Billing unit display name (by locale) |
| displayOrder | Integer | Display order |
| price | Long | Amount used (contracted amount not provided as it is for partners) |
| productUiId | String | Homepage service UI ID |
| usage | BigDecimal | Usage amount |

**ProjectExtra**

| Name | Type | Description |
| --- | --- | --- |
| description | String | Surcharge description |
| extraPrice | Long | Project surcharge |


<a id="retrieve-organization-lists-of-partner-users"></a>
## Retrieve Organization Lists of Partner Users { #retrieve-organization-lists-of-partner-users }

Retrieve the list of organization users of the partner.

!!! tip "Verify Partner Agreement"
    Verify that the partner and partner user entered into a partnership agreement in the specified month.

<a id="retrieve-organization-lists-of-partner-users-required-permission"></a>
### Required Permission { #retrieve-organization-lists-of-partner-users-required-permission }
`Partner.Organization.List`

<a id="retrieve-organization-lists-of-partner-users-request"></a>
### Request { #retrieve-organization-lists-of-partner-users-request }

```
GET /v1/billing/partners/{partnerId}/payments/{month}/organizations
```

<a id="retrieve-organization-lists-of-partner-users-request-parameter"></a>
### Request Parameter { #retrieve-organization-lists-of-partner-users-request-parameter }

| Name | Category | Type | Required | Description |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | Partner ID |
| month | Path | String | Y | Usage period (yyyy-MM format) |
| partnerUserUuid | Query | String | Y | Partner User UUID |

<a id="retrieve-organization-lists-of-partner-users-request-body"></a>
### Request Body { #retrieve-organization-lists-of-partner-users-request-body }

This API does not require a request body.

<a id="retrieve-organization-lists-of-partner-users-response"></a>
### Response { #retrieve-organization-lists-of-partner-users-response }

<details>
  <summary><strong>Response Example</strong></summary>

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
      "orgName": "테스트 조직",
      "orgStatusCode": "STABLE",
      "orgCreationType": "USER",
      "cloudType": "PUBLIC"
    }
  ]
}
```

</details>

| Name | Type | Description |
| --- | --- | --- |
| organizations | List&lt;OrganizationProtocol&gt; | Organization List |

**OrganizationProtocol**

| Name | Type | Description |
| --- | --- | --- |
| orgId | String | Organization ID |
| orgName | String | Organization name |
| orgStatusCode | String | Organization status (STABLE: normal status, CLOSED: deleted status) |
| orgCreationType | String | Organization creation type (USER: organization created by customer, SYSTEM: organization created by system) |
| cloudType | String | Cloud type |


<a id="retrieve-the-billing-amount-per-organizations-of-partner-users"></a>
## Retrieve the Billing Amount per Organizations of Partner Users { #retrieve-the-billing-amount-per-organizations-of-partner-users }

Retrieve the details of the specific organization's amount used, discount, and surcharge amounts.

!!! tip "Verify Partner Agreement"
    Verify that the partner and partner user in question had a partner agreement in the specified month, and that the owner of the organization in question was a partner user in that month.

<a id="retrieve-the-billing-amount-per-organizations-of-partner-users-required-permission"></a>
### Required Permission { #retrieve-the-billing-amount-per-organizations-of-partner-users-required-permission }
`Partner.Organization.Usage.Get`

<a id="retrieve-the-billing-amount-per-organizations-of-partner-users-request"></a>
### Request { #retrieve-the-billing-amount-per-organizations-of-partner-users-request }

```
GET /v1/billing/partners/{partnerId}/payments/{month}/organizations/{orgId}/usage
```

<a id="retrieve-the-billing-amount-per-organizations-of-partner-users-request-parameter"></a>
### Request Parameter { #retrieve-the-billing-amount-per-organizations-of-partner-users-request-parameter }

| Name | Category | Type | Required | Description |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | Partner ID |
| month | Path | String | Y | Usage month (yyyy-MM format) |
| orgId | Path | String | Y | Organization ID |
| lang | Header | String | N | Language settings (default: ko_KR, selectable values: ko_KR, ja_JP, en_US) |
| isHideContract | Query | Boolean | N | Whether to hide contract information (default: false / true: apply partner masking and exclude creditUsages) |
| isHideContract | Query | Boolean | N | Whether to hide commitment information (default: false / true: partner masking applied and creditUsages excluded) |

<a id="retrieve-the-billing-amount-per-organizations-of-partner-users-request-body"></a>
### Request Body { #retrieve-the-billing-amount-per-organizations-of-partner-users-request-body }

This API does not require a request body.

<a id="retrieve-the-billing-amount-per-organizations-of-partner-users-response"></a>
### Response { #retrieve-the-billing-amount-per-organizations-of-partner-users-response }

<details>
  <summary><strong>Response Example</strong></summary>

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "SUCCESS"
  },
  "org": {
    "orgId": "org123",
    "orgName": "테스트 조직",
    "country": "KR",
    "usagePrice": 100000,
    "contractUsagePrice": 95000,
    "contractDiscountPrice": 5000,
    "ocpDiscountPrice": 0,
    "contractExtraPrice": 0,
    "totalDiscount": 5000,
    "totalExtra": 0,
    "totalAmount": 95000,
    "prePaidTotalAmount": 0,
    "totalCredit": 0,
    "creditUsages": [
      {
        "balanceTypeCode": "FREE_CREDIT",
        "balanceTypeName": "무료 크레딧",
        "i18nBalanceTypeNameMap": {
          "ko_KR": "무료 크레딧",
          "en_US": "Free Credit"
        },
        "usageAmount": 5000
      }
    ],
    "projects": [
      {
        "projectId": "project123",
        "projectName": "테스트 프로젝트",
        "totalAmount": 95000,
        "usagePrice": 100000,
        "contractUsagePrice": 95000,
        "contractDiscountPrice": 5000,
        "ocpDiscountPrice": 0,
        "contractExtraPrice": 0,
        "prePaidTotalAmount": 0
      }
    ],
    "projectDiscount": {
      "totalAdjustment": 5000,
      "details": [
        {
          "projectId": "project123",
          "projectName": "테스트 프로젝트",
          "adjustment": 5000,
          "adjustmentTypeCode": "CONTRACT_DISCOUNT",
          "description": "약정 할인"
        }
      ]
    },
    "projectExtra": {
      "totalAdjustment": 0,
      "details": []
    }
  }
}
```

</details>

<a id="retrieve-the-billing-amount-per-organizations-of-partner-users-response-default-response-structure"></a>
#### Default Response Structure

| Name | Type | Description |
| --- | --- | --- |
| org | Organization | Organization information |

**Organization**

| Name | Type | Description |
| --- | --- | --- |
| orgId | String | Organization ID |
| orgName | String | Organization name |
| country | String | Country code |
| usagePrice | Long | Usage amount |
| contractUsagePrice | Long | Total usage amount with contract discounts/surcharges applied |
| contractDiscountPrice | Long | Amount discounted by contract |
| ocpDiscountPrice | Long | Optimized Cost Plans (OCPs) discount amount |
| contractExtraPrice | Long | Amount surcharged by contract |
| totalDiscount | Long | Total discount amount |
| totalExtra | Long | Total surcharge amount |
| totalAmount | Long | Final organization amount |
| prePaidTotalAmount | Long | Prepayment usage amount |
| totalCredit | Long | Final credit amount |
| creditUsages | List&lt;CreditUsageProtocol&gt; | Credit usage list |
| projects | List&lt;Project&gt; | Project list |
| projectDiscount | PaymentStatementProjectAdjustment | List of discount details by project |
| projectExtra | PaymentStatementProjectAdjustment | List of surcharge details by project |

**CreditUsageProtocol**

| Name | Type | Description |
| --- | --- | --- |
| balanceTypeCode | String | Campaign type (balance type) |
| balanceTypeName | String | Campaign type name (balance type name) |
| i18nBalanceTypeNameMap | Map&lt;String, String&gt; | Campaign type name multilingual map |
| usageAmount | Long | Credit usage amount |

**Project**

| Name | Type | Description |
| --- | --- | --- |
| projectId | String | Project ID |
| projectName | String | Project name |
| totalAmount | Long | Final project amount |
| usagePrice | Long | Project usage amount total |
| contractUsagePrice | Long | Total usage amount with contract discounts/surcharges applied |
| contractDiscountPrice | Long | Amount discounted by contract |
| ocpDiscountPrice | Long | Optimized Cost Plans(OCPs) discount amount |
| contractExtraPrice | Long | Amount surcharged by contract |
| prePaidTotalAmount | Long | Prepayment usage amount |

**PaymentStatementProjectAdjustment**

| Name | Type | Description |
| --- | --- | --- |
| totalAdjustment | Long | Total discount/surcharge amount |
| details | List&lt;PaymentStatementProjectAdjustmentDetail&gt; | Details |

**PaymentStatementProjectAdjustmentDetail**

| Name | Type | Description |
| --- | --- | --- |
| projectId | String | Project ID |
| projectName | String | Project name |
| adjustment | Long | Discount/surcharge amount |
| adjustmentTypeCode | String | Discount/surcharge type<br>- CONTRACT_EXTRA: Contract surcharge<br>- CONTRACT_PENALTY: Contract penalty<br>- CONTRACT_DISCOUNT: Contract discount<br>- CONTRACT_PAYBACK: Partner payback<br>- STATIC_EXTRA: Fixed amount surcharge<br>- PERCENT_DISCOUNT: Percentage discount<br>- COUPON: Coupon<br>- STATIC_DISCOUNT: Fixed amount discount<br>- CUTOFF: Truncate less than 500 won |
| description | String | Discount/surcharge details |


<a id="retrieve-project-lists-of-partner-users"></a>
## Retrieve Project Lists of Partner Users { #retrieve-project-lists-of-partner-users }

Retrieves a list of projects of partner users.

!!! tip "Verify Partner Agreement"
    Verify that the partner and partner user entered into a partnership agreement in the specified month.

<a id="retrieve-project-lists-of-partner-users-required-permission"></a>
### Required Permission { #retrieve-project-lists-of-partner-users-required-permission }
`Partner.Project.List`

<a id="retrieve-project-lists-of-partner-users-request"></a>
### Request { #retrieve-project-lists-of-partner-users-request }

```
GET /v1/billing/partners/{partnerId}/payments/{month}/projects
```

<a id="retrieve-project-lists-of-partner-users-request-parameter"></a>
### Request Parameter { #retrieve-project-lists-of-partner-users-request-parameter }

| Name | Category | Type | Required | Description |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | Partner ID |
| month | Path | String | Y | Usage period (yyyy-MM format) |
| partnerUserUuid | Query | String | Y | Partner User UUID |

<a id="retrieve-project-lists-of-partner-users-request-body"></a>
### Request Body { #retrieve-project-lists-of-partner-users-request-body }

This API does not require a request body.

<a id="retrieve-project-lists-of-partner-users-response"></a>
### Response { #retrieve-project-lists-of-partner-users-response }

<details>
  <summary><strong>Response Example</strong></summary>

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
      "orgName": "테스트 조직",
      "orgCreationType": "USER",
      "orgStatusCode": "STABLE",
      "projectId": "project123",
      "projectName": "테스트 프로젝트",
      "projectCreationType": "USER",
      "projectStatusCode": "STABLE"
    }
  ]
}
```

</details>

| Name | Type | Description |
| --- | --- | --- |
| projects | List&lt;ProjectProtocol&gt; | Project List |

**ProjectProtocol**

| Name | Type | Description |
| --- | --- | --- |
| orgId | String | Organization ID |
| orgName | String | Organization Name |
| orgCreationType | String | Organization Creation Type<br><br>- USER: Customer-created organization<br>- SYSTEM: system-created organization (primarily used in membership marketplaces) |
| orgStatusCode | String | Organization Status<br><br>- STABLE: normal status<br>- CLOSED: Deleted status |
| projectId | String | Project ID |
| projectName | String | Project Name |
| projectCreationType | String | Project Creation Type<br><br>- USER: Customer-created project<br>- SYSTEM: System-created project (primarily used in organization services and membership marketplaces) |
| projectStatusCode | String | Project Status<br><br>- STABLE: normal status<br>- CLOSED: Deleted status |


<a id="retrieve-project-usage-details-for-partner-user"></a>
## Retrieve Project Usage Details for Partner User { #retrieve-project-usage-details-for-partner-user }

Retrieve the detailed usage of a specific project.

!!! danger "Caution"
    Optimize performance by using paging appropriately when querying usage.

!!! tip "Verify Partner Agreement"
    Verify that the partner and partner user in question had a partner agreement in the specified month, and that the owner of the organization to which the project belongs was a partner user in that month.

<a id="retrieve-project-usage-details-for-partner-user-required-permission"></a>
### Required Permission { #retrieve-project-usage-details-for-partner-user-required-permission }
`Partner.Project.Usage.Get`

<a id="retrieve-project-usage-details-for-partner-user-request"></a>
### Request { #retrieve-project-usage-details-for-partner-user-request }

```
GET /v1/billing/partners/{partnerId}/payments/{month}/projects/{projectId}/usage
```

<a id="retrieve-project-usage-details-for-partner-user-request-parameter"></a>
### Request Parameter { #retrieve-project-usage-details-for-partner-user-request-parameter }

| Name | Category | Type | Required | Description |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | Partner ID |
| month | Path | String | Y | Month of use (yyyy-MM format) |
| projectId | Path | String | Y | Project ID |
| lang | Header | String | N | Language setting (default: ko_KR, configurable values: ko_KR, ja_JP, en_US) |
| isHideContract | Query | Boolean | N | Whether to hide contract information (default: false / true: apply partner masking and exclude creditUsages) |
| usageSchemaTypeCode | Query | String | N | Include usage<br>Decide whether to use the existing usage inquiry method or the new grouping method<br>(Default: NO_GROUP)<br><br>- NO_GROUP: usage is displayed as is, without being grouped. <br>- GROUP_BY_PARENT_RESOURCE: grouping is done by parent resource, but specific usage is not provided. The totalItems returned allows you to check how many parent resources exist.<br>- GROUP_BY_PARENT_RESOURCE_INCLUDE_USAGES: after grouping parent resources separately, which parent resource is grouped as and how it is used in detail |
| categoryMain | Query | String | N | Main category<br>If usageSchemaTypeCode is NO_GROUP, it cannot be used |
| regionTypeCode | Query | String | N | Region type code (up to 20 characters)<br>If usageSchemaTypeCode is NO_GROUP, it cannot be used |
| stationId | Query | String | N | Station ID<br>If usageSchemaTypeCode is NO_GROUP, it cannot be used |
| page | Query | Integer | N | Selected page (default: 1, minimum: 1)<br>if usageSchemaTypeCode is NO_GROUP, it is unavailable |
| limit | Query | Integer | N | Number of items to be displayed on the page, if not entered, full view (default: 0, minimum: 0)<br>Not available when usageSchemaTypeCode is NO_GROUP |

<a id="retrieve-project-usage-details-for-partner-user-request-body"></a>
### Request Body { #retrieve-project-usage-details-for-partner-user-request-body }

This API does not require a request body.

<a id="retrieve-project-usage-details-for-partner-user-response"></a>
### Response { #retrieve-project-usage-details-for-partner-user-response }

<details>
  <summary><strong>Response Example</strong></summary>

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "SUCCESS"
  },
  "project": {
    "projectId": "project123",
    "projectName": "테스트 프로젝트",
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
        "balanceTypeName": "무료 크레딧",
        "usageAmount": 5000
      }
    ],
    "projectDiscount": {
      "totalAdjustment": 2000,
      "details": [
        {
          "projectId": "project123",
          "projectName": "테스트 프로젝트",
          "adjustment": 2000,
          "adjustmentTypeCode": "CONTRACT_DISCOUNT",
          "description": "약정 할인"
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
        "stationName": "한국(판교) 리전",
        "regionTypeCode": "KR",
        "needType": false,
        "totalItems": 1,
        "totalPrice": 45000,
        "usagePrice": 45000,
        "usageResourceGroups": [
          {
            "parentResourceId": "parent-resource-123",
            "parentResourceName": "부모 리소스",
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
                "displayNameKo": "c2.small 인스턴스",
                "displayNameZh": "c2.small 实例",
                "displayOrder": 1,
                "parentResourceId": "parent-resource-123",
                "parentResourceName": "부모 리소스",
                "price": 24000,
                "productUiId": "compute-instance",
                "projectId": "project123",
                "projectName": "테스트 프로젝트",
                "rangeFrom": 0,
                "regionTypeCode": "KR",
                "resourceId": "resource123",
                "resourceName": "test-instance",
                "seq": 1,
                "stationId": "KR1",
                "stationName": "한국(판교) 리전",
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
#### Default Response Structure

| Name | Type | Description |
| --- | --- | --- |
| project | Project | Project Information |

**Project**

| Name | Type | Description |
| --- | --- | --- |
| projectId | String | Project ID |
| projectName | String | Project name |
| country | String | Country code |
| usagePrice | Long | Usage amount |
| contractUsagePrice | Long | Total usage amount with contract discounts/surcharges applied |
| contractDiscountPrice | Long | Amount discounted by contract |
| ocpDiscountPrice | Long | Optimized Cost Plans(OCPs) discount amount |
| contractExtraPrice | Long | Amount surcharged by contract |
| totalAmount | Long | Final project amount |
| totalDiscount | Long | Total discount amount |
| totalExtra | Long | Total surcharge amount |
| prePaidTotalAmount | Long | Prepayment usage amount |
| totalCredit | Long | Final credit amount |
| creditUsages | List&lt;CreditUsageProtocol&gt; | Credit usage list |
| projectDiscount | PaymentStatementProjectAdjustment | Project-specific discount details |
| projectExtra | PaymentStatementProjectAdjustment | Project-specific surcharge details |
| usageGroups | List&lt;UsageGroup&gt; | Usage group list |

**CreditUsageProtocol**

| Name | Type | Description |
| --- | --- | --- |
| balanceTypeCode | String | Campaign type (balance type) |
| balanceTypeName | String | Campaign type name (balance type name) |
| i18nBalanceTypeNameMap | Map&lt;String, String&gt; | Campaign type name multilingual map |
| usageAmount | Long | Credit amount used |

**PaymentStatementProjectAdjustment**

| Name | Type | Description |
| --- | --- | --- |
| totalAdjustment | Long | Total discount/surcharge amount |
| details | List&lt;PaymentStatementProjectAdjustmentDetail&gt; | Details |

**PaymentStatementProjectAdjustmentDetail**

| Name | Type | Description |
| --- | --- | --- |
| projectId | String | Project ID |
| projectName | String | Project name |
| adjustment | Long | Discount/surcharge amount |
| adjustmentTypeCode | String | Discount/surcharge type<br>- CONTRACT_EXTRA: contract surcharge<br>- CONTRACT_PENALTY: contract penalty<br>- CONTRACT_DISCOUNT: contract discount<br>- CONTRACT_PAYBACK: partner payback<br>- STATIC_EXTRA: fixed amount surcharge<br>- PERCENT_DISCOUNT: percentage discount<br>- COUPON: coupon<br>- STATIC_DISCOUNT: fixed amount discount<br>- CUTOFF: truncate less than 500 won |
| description | String | Discount/surcharge details |

**UsageGroup**

| Name | Type | Description |
| --- | --- | --- |
| categoryMain | String | Main category |
| regionTypeCode | String | Region |
| stationId | String | Station ID |
| stationName | String | Station name |
| needType | Boolean | Whether to display the category column |
| usagePrice | Long | Total usage amount |
| totalPrice | Long | Total usage amount with commitment-based discount applied |
| totalDiscount | Long | Total discount amount |
| prePaidTotalAmount | Long | Prepayment usage amount |
| totalItems | Integer | Total number of usages per UsageGroup |
| usages | List&lt;Usage&gt; | Detailed usage list |
| usageResourceGroups | List&lt;UsageResourceGroup&gt; | Grouped usage list |

**UsageResourceGroup**

| Name | Type | Description |
| --- | --- | --- |
| parentResourceId | String | Parent resource ID for identification |
| parentResourceName | String | Parent resource name for identification |
| usages | List&lt;Usage&gt; | Detailed usage list |

**Usage**

| Name | Type | Description |
| --- | --- | --- |
| projectId | String | Project ID |
| projectName | String | Project name |
| resourceId | String | Resource ID |
| parentResourceId | String | Parent resource ID |
| resourceName | String | Resource name |
| parentResourceName | String | Parent resource name |
| counterName | String | Counter name |
| categoryMain | String | Main category |
| categorySub | String | Sub category |
| productUiId | String | Homepage service UI ID |
| regionTypeCode | String | Region |
| displayNameKo | String | Billing unit display name (ko) |
| displayNameEn | String | Billing unit display name (en) |
| displayNameJa | String | Billing unit display name (ja) |
| displayNameZh | String | Billing unit display name (zh) |
| usage | Double | Usage |
| unit | Long | Charging unit |
| unitPrice | Double | Price per unit |
| unitName | String | Unit name |
| price | Long | Usage amount |
| useFixPrice | Boolean | Fixed price |
| displayOrder | Long | Display order |
| contractId | String | Agreement ID |
| contractUnitPrice | Double | Commitment unit price |
| contractPrice | Long | Usage amount calculated by commitment |
| discountPrice | Long | Discount amount |
| discountTypeCode | String | Discount type code<br>BASIC, CONTRACT, OCP |
| prePaidAmount | Long | Prepayment usage amount |
| costPlanOrderId | String | Optimized Cost Plans(OCPs) order ID |


<a id="retrieve-partners-bill"></a>
## Retrieve Partner’s Bill { #retrieve-partners-bill }

Retrieve the partner's full bill.

!!! tip "Verify Partner Agreement"
    Verify that the partner in question had a valid partner agreement in the specified month.

<a id="retrieve-partners-bill-required-permission"></a>
### Required Permission { #retrieve-partners-bill-required-permission }
`Partner.Statement.Get`

<a id="retrieve-partners-bill-request"></a>
### Request { #retrieve-partners-bill-request }

```
GET /v1/billing/partners/{partnerId}/payments/{month}/statements
```

<a id="retrieve-partners-bill-request-parameter"></a>
### Request Parameter { #retrieve-partners-bill-request-parameter }

| Name | Category | Type | Required | Description |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | Partner ID |
| month | Path | String | Y | Month of use (yyyy-MM format) |
| lang | Header | String | N | Language setting (default: ko_KR, configurable values: ko_KR, ja_JP, en_US) |

<a id="retrieve-partners-bill-request-body"></a>
### Request Body { #retrieve-partners-bill-request-body }

This API does not require a request body.

<a id="retrieve-partners-bill-response"></a>
### Response { #retrieve-partners-bill-response }

<details>
  <summary><strong>Response Example</strong></summary>

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
              "billingGroupName": "기본 빌링 그룹",
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
                  "balanceTypeName": "무료 크레딧",
                  "i18nBalanceTypeNameMap": {
                    "ko_KR": "무료 크레딧"
                  },
                  "usageAmount": 5000
                }
              ],
              "orgList": [
                {
                  "orgId": "org123",
                  "orgName": "테스트 조직",
                  "totalAmount": 105000
                }
              ],
              "usageGroups": [
                {
                  "categoryMain": "Compute",
                  "needType": true,
                  "regionTypeCode": "KR1",
                  "stationId": "station1",
                  "stationName": "한국(판교) 리전",
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
                    "description": "약정 할인"
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
                    "projectName": "테스트 프로젝트",
                    "adjustment": 3000,
                    "adjustmentTypeCode": "CONTRACT_DISCOUNT",
                    "description": "프로젝트 약정 할인"
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
#### Default Response Structure

| Name | Type | Description |
| --- | --- | --- |
| paymentStatements | List&lt;PaymentStatement&gt; | List of bills |

**PaymentStatement**

| Name | Type | Description |
| --- | --- | --- |
| uuid | String | Member UUID |
| autoPaymentTypeCode | String | Payment method<br><br>- PAYCO_CREDIT_CARD: Payco credit card<br>- CREDIT_CARD: credit card<br>- INTER_CREDIT_CARD: international credit card<br>- UNION_PAY: Union Pay<br>- JAPAN_BILLING: Japanese billing<br>- ACCOUNT_TRANSFER: account transfer<br>- CREDIT_ALL: general credit<br>- CREDIT_LIMIT: event credit<br>- ESM: Internal cost<br>- ONETIME_PAYMENT: One-time payment<br>- TAX_BILL: Issue a tax bill<br>- CONTRACT_BILL: Issue a tax bill (The amount of the bill may be adjusted through a separate contract)<br>- NONE: none |
| isAutoPayment | Boolean | Whether automatic payment is enabled |
| paymentInfo | String | Payment method information |
| statements | List&lt;PaymentStatement&gt; | List of payment details by billing group |

**PaymentStatement**

| Name | Type | Description |
| --- | --- | --- |
| paymentGroupId | String | Payment group ID |
| month | String | Month of use |
| charge | Long | Amount used |
| supplyAmount | Long | Supply amount |
| taxAmount | Long | VAT |
| totalAmount | Long | Final amount |
| totalCredit | Long | Total credit used |
| totalDiscount | Long | Discount amount |
| totalExtra | Long | Surcharge amount |
| freeCredit | Long | Free credit used |
| freeCreditAll | Long | Free all credit used |
| freeCreditLimit | Long | Free limited credit used |
| paidCredit | Long | Paid credit used |
| paidCreditAll | Long | Paid all credit used |
| paidCreditLimit | Long | Paid limited credit used |
| paymentStatusCode | String | Payment status<br><br>- REGISTERED: register<br>- READY: pending payment<br>- PAID: paid<br>- ERROR: operator Verification Required Status |
| country | String | Country Code |
| cutoff | Long | cutoff |
| lateFee | Long | Overdue Amount |
| prePaidTotalAmount | Long | Prepayment usage amount |
| realSupplyAmount | Long | Actual Supply Amount |
| realTaxAmount | Long | Actual VAT Paid |
| receiptStatusCode | String | Sales Voucher Status Code<br><br>- NONE: sales have not yet been reported to the accounting team, so sales receipts cannot be viewed.<br>- EXIST: after the final amount adjustment is completed, the sales report is sent to the accounting team, and the sales voucher can be viewed. |
| refundAccountRegisterStatusCode | String | Status of whether the refund account has been registered<br><br>- ALLOW: Open status of refund account registration<br>- DENY: Default, Close status of register refund accounts |
| details | List&lt;PaymentStatementDetail&gt; | List of details by billing group |

**PaymentStatementDetail**

| Name | Type | Description |
| --- | --- | --- |
| billingGroupId | String | Billing group ID |
| billingGroupName | String | Billing group name |
| charge | Long | Amount used |
| totalDiscount | Long | Discount amount |
| totalExtra | Long | Surcharge amount |
| totalAmount | Long | Final amount |
| contractDiscount | Long | Commitment-based discount amount |
| contractExtra | Long | Commitment underutilization charge amount |
| ocpDiscount | Long | Optimized Cost Plans(OCPs) discount amount |
| prePaidTotalAmount | Long | Prepayment usage amount |
| totalCredit | Long | Total credit usage amount |
| creditUsages | List&lt;CreditUsageProtocol&gt; | Credit usage list |
| orgList | List&lt;Organization&gt; | List of organizations |
| usageGroups | List&lt;UsageGroup&gt; | List of usage groups |
| billingGroupDiscount | PaymentStatementBillingGroupAdjustment | Billing group discount details |
| billingGroupExtra | PaymentStatementBillingGroupAdjustment | Billing group surcharge details |
| projectDiscount | PaymentStatementProjectAdjustment | Project-specific discount details |
| projectExtra | PaymentStatementProjectAdjustment | Project-specific surcharge details |

**CreditUsageProtocol**

| Name | Type | Description |
| --- | --- | --- |
| balanceTypeCode | String | Campaign type (balance type) |
| balanceTypeName | String | Campaign type name (balance type name) |
| i18nBalanceTypeNameMap | Map&lt;String, String&gt; | Campaign type name multilingual map |
| usageAmount | Long | Credit amount used |

**Organization**

| Name | Type | Description |
| --- | --- | --- |
| orgId | String | Organization ID |
| orgName | String | Organization name |
| totalAmount | Long | Organization total amount |
| prePaidTotalAmount | Long | Prepayment usage amount |

**UsageGroup**

| Name | Type | Description |
| --- | --- | --- |
| categoryMain | String | Main category |
| regionTypeCode | String | Region |
| stationId | String | Station ID |
| stationName | String | Station name |
| needType | Boolean | Whether to display the category column |
| usagePrice | Long | Total usage amount |
| totalPrice | Long | Total usage amount with commitment-based discount applied |
| totalDiscount | Long | Total discount amount |
| prePaidTotalAmount | Long | Prepayment usage amount |
| totalItems | Integer | Total number of usages per UsageGroup |
| usages | List&lt;Usage&gt; | Detailed usage list |
| usageResourceGroups | List&lt;UsageResourceGroup&gt; | Grouped usage list |

**PaymentStatementBillingGroupAdjustment**

| Name | Type | Description |
| --- | --- | --- |
| totalAdjustment | Long | Total discount/surcharge amount |
| details | List&lt;PaymentStatementAdjustment&gt; | Details |

**PaymentStatementAdjustment**

| Name | Type | Description |
| --- | --- | --- |
| adjustment | Long | Discount/surcharge amount |
| adjustmentTypeCode | String | Discount/surcharge type<br><br>- CONTRACT_EXTRA: Contract surcharge<br>- CONTRACT_PENALTY: Contract penalty<br>- CONTRACT_DISCOUNT: Contract discount<br>- CONTRACT_PAYBACK: Partner payback<br>- STATIC_EXTRA: Fixed amount surcharge<br>- PERCENT_DISCOUNT: Percentage discount<br>- COUPON: Coupon<br>- STATIC_DISCOUNT: Fixed amount discount<br>- CUTOFF: Truncate less than 500 won |
| description | String | Discount/surcharge details |

**PaymentStatementProjectAdjustment**

| Name | Type | Description |
| --- | --- | --- |
| totalAdjustment | Long | Total discount/surcharge amount |
| details | List&lt;PaymentStatementProjectAdjustmentDetail&gt; | Details |

**PaymentStatementProjectAdjustmentDetail**

| Name | Type | Description |
| --- | --- | --- |
| projectId | String | Project ID |
| projectName | String | Project name |
| adjustment | Long | Discount/surcharge amount |
| adjustmentTypeCode | String | Discount/surcharge type<br><br>- CONTRACT_EXTRA: Contract surcharge<br>- CONTRACT_PENALTY: Contract penalty<br>- CONTRACT_DISCOUNT: Contract discount<br>- CONTRACT_PAYBACK: Partner payback<br>- STATIC_EXTRA: Fixed amount surcharge<br>- PERCENT_DISCOUNT: Percentage discount<br>- COUPON: Coupon<br>- STATIC_DISCOUNT: Fixed amount discount<br>- CUTOFF: Truncate less than 500 won |
| description | String | Discount/surcharge details |


<a id="retrieve-self-service-metering-of-solutions-partner"></a>
## Retrieve Self-Service Metering of Solutions Partner { #retrieve-self-service-metering-of-solutions-partner }

Retrieve metering information for their services by a solution partner.

!!! tip "Verify Solution Partner"
    Only solution partners or users authorized by a solution partner can call this feature.

<a id="retrieve-self-service-metering-of-solutions-partner-required-permission"></a>
### Required Permission { #retrieve-self-service-metering-of-solutions-partner-required-permission }
`Partner.Meter.List`

<a id="retrieve-self-service-metering-of-solutions-partner-request"></a>
### Request { #retrieve-self-service-metering-of-solutions-partner-request }

```
GET /v1/billing/partners/{partnerId}/products/{productId}/meters
```

<a id="retrieve-self-service-metering-of-solutions-partner-request-parameter"></a>
### Request Parameter { #retrieve-self-service-metering-of-solutions-partner-request-parameter }

| Name | Category | Type | Required | Description |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | Partner ID |
| productId | Path | String | Y | Service ID |
| from | Query | String | Y | Query start time (ISO 8601 format, inclusive) |
| to | Query | String | Y | Query end time (ISO 8601 format, exclusive) |
| counterName | Query | String | Y | Counter name |
| appKey | Query | String | N | Product App Key |
| meterTimeTypeCode | Query | String | N | Meter time type code<br><br>- INSERT_TIME: based on metering insertion time<br>- USED_TIME: based on metering insertion time |
| page | Query | Integer | Y | Selected page (minimum: 1) |
| limit | Query | Integer | Y | number of items to be displayed on the page (minimum: 1, max: 2,000) |

<a id="retrieve-self-service-metering-of-solutions-partner-request-body"></a>
### Request Body { #retrieve-self-service-metering-of-solutions-partner-request-body }

This API does not require a request body.

<a id="retrieve-self-service-metering-of-solutions-partner-response"></a>
### Response { #retrieve-self-service-metering-of-solutions-partner-response }

<details>
  <summary><strong>Response Example</strong></summary>

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

| Name | Type | Description |
| --- | --- | --- |
| meterList | List&lt;MeterProtocol&gt; | Metering list |
| totalItems | Integer | Total number of items |

**MeterProtocol**

| Name | Type | Description |
| --- | --- | --- |
| appKey | String | Service app key |
| counterName | String | Counter name |
| counterType | String | Counter type <br><br>- DELTA: Incremental value <br>- GAUGE: Current value <br>- HOURLY_LATEST: Latest hourly value <br>- DAILY_MAX: Daily maximum value <br>- MONTHLY_MAX: Monthly maximum value <br>- STATUS: Status value |
| counterUnit | String | Counter unit |
| counterValue | String | Usage status (only used when counterType is STATUS) |
| counterVolume | BigDecimal | Counter volume |
| gmid | String | Global metering ID |
| insertTime | String | Metering insert time |
| orgId | String | Organization ID |
| parentResourceId | String | Parent resource ID |
| productId | String | Service ID |
| projectId | String | Project ID |
| resourceId | String | Resource ID |
| resourceName | String | Resource name |
| source | String | IP or hostname where metering occurred |
| stationId | String | Station ID |
| timestamp | String | Metering occurrence time |


<a id="delete-metering-for-solution-partners"></a>
## Delete Metering for Solution Partners { #delete-metering-for-solution-partners }

Deletes metering data for a service owned by the solution partner.<br>
Deletions will not be reflected in invoices that have already been created. Partners are strictly limited to managing their own services and cannot delete metering data for services owned by others.<br>
This is an asynchronous operation due to the potential processing time. After calling the Delete API, use the returned asyncJobId to poll the job status and verify completion.

!!! tip "Verify Solution Partner"
    Only Solution Partners or users authorized by a Solution Partner can call this.

<a id="delete-metering-for-solution-partners-required-permission"></a>
### Required Permission { #delete-metering-for-solution-partners-required-permission }
`Partner.Meter.Delete`

<a id="delete-metering-for-solution-partners-request"></a>
### Request { #delete-metering-for-solution-partners-request }

```
DELETE /v1/billing/partners/{partnerId}/products/{productId}/meters
```

<a id="delete-metering-for-solution-partners-request-parameter"></a>
### Request Parameter { #delete-metering-for-solution-partners-request-parameter }

| Name | Category | Type | Required | Description |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | Partner ID |
| productId | Path | String | Y | Service ID |


<a id="delete-metering-for-solution-partners-request-body"></a>
### Request Body { #delete-metering-for-solution-partners-request-body }

<details>
  <summary><strong>Example code</strong></summary>

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

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| from | String | Y | Query start time (ISO 8601 format, inclusive) |
| to | String | Y | Query end time (ISO 8601 format, exclusive) |
| appKey | String | N | Product App Key<br>Either the app key or counter name must be present |
| counterNames | List&lt;String&gt; | N | List of counter names to delete<br>Either the app key or counter name must be present |


<a id="delete-metering-for-solution-partners-response"></a>
### Response { #delete-metering-for-solution-partners-response }

<details>
  <summary><strong>Response example</strong></summary>

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

| Name | Type | Description |
| --- | --- | --- |
| asyncJobId | String | ID of the asynchronous job being executed |


<a id="confirm-deletion-of-solution-partners-metering"></a>
## Confirm Deletion of Solution Partner's Metering { #confirm-deletion-of-solution-partners-metering }

Verifies that the deletion is complete.<br>
It is recommended to wait at least 5 seconds before the first verification call, as immediate requests may fail due to processing time.<br>
We suggest polling every 5 seconds thereafter to check the status.

!!! tip "Verify Soltion Partner"
    Access is restricted to Solution Partners and their authorized users.

!!! danger "Cautions for Deleting Metering Configurations"
    Once a deletion is confirmed, the deletion job is removed. This endpoint can only be called once; subsequent attempts will return a 16500 error.

<a id="confirm-deletion-of-solution-partners-metering-required-permission"></a>
### Required Permission { #confirm-deletion-of-solution-partners-metering-required-permission }
`Partner.Meter.Delete`

<a id="confirm-deletion-of-solution-partners-metering-request"></a>
### Request { #confirm-deletion-of-solution-partners-metering-request }

```
GET /v1/billing/partners/{partnerId}/meters/jobs/{async-job-id}
```

<a id="confirm-deletion-of-solution-partners-metering-request-parameter"></a>
### Request Parameter { #confirm-deletion-of-solution-partners-metering-request-parameter }

| Name | Category | Type | Required | Description |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | Partner ID |
| asyncJobId | Path | String | Y | ID of the asynchronous job executed |


<a id="confirm-deletion-of-solution-partners-metering-request-body"></a>
### Request Body { #confirm-deletion-of-solution-partners-metering-request-body }

This API does not require a request body.

<a id="confirm-deletion-of-solution-partners-metering-response"></a>
### Response { #confirm-deletion-of-solution-partners-metering-response }

<details>
  <summary><strong>Response example</strong></summary>

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

| Name | Type | Description |
| --- | --- | --- |
| statusCode | String | Deletion status (IN_PROGRESS: deletion in progress, ERROR: an error occurred during deletion, SUCCESS: deleted successfully) |

<a id="create-organization-for-partner-user"></a>
## Create Organization for Partner User { #create-organization-for-partner-user }

A partner creates the organization of the partner user.

!!! tip "Verify Partner Agreement"
    Verify if the partner and partner user had a partner contract relationship in the month in which the API was called.

<a id="create-organization-for-partner-user-required-permission"></a>
### Required Permission { #create-organization-for-partner-user-required-permission }
`Partner.Organization.Create`

<a id="create-organization-for-partner-user-request"></a>
### Request { #create-organization-for-partner-user-request }

```
POST /v1/partners/{partnerId}/partner-users/{partnerUserUuid}/organizations
```

<a id="create-organization-for-partner-user-request-parameter"></a>
### Request Parameter { #create-organization-for-partner-user-request-parameter }

| Name | Category | Type | Required | Description |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | Partner ID |
| partnerUserUuid | Path | String | Y | Partner user UUID |

<a id="create-organization-for-partner-user-request-body"></a>
### Request Body { #create-organization-for-partner-user-request-body }

| Name | Category | Type | Required | Description |
| --- | --- | --- | --- | --- |
| orgName | String | Y | Organization name (up to 120 characters) |

<a id="create-organization-for-partner-user-response"></a>
### Response { #create-organization-for-partner-user-response }

<details>
  <summary><strong>Response Example</strong></summary>

```json
{
  "header": {
    "isSuccessful": true,
    "resultCode": 0,
    "resultMessage": "SUCCESS"
  },
  "orgId": "org-12345",
  "orgName": "새로운 조직",
  "ownerId": "owner-uuid-12345",
  "regDateTime": "2024-01-15T10:30:00Z"
}
```

</details>

| Name | Type | Description |
| --- | --- | --- |
| orgId | String | Generated organization ID |
| orgName | String | Organization name |
| ownerId | String | Organization Owner UUID |
| regDateTime | String | Registration date and time (ISO 8601 format) |


<a id="delete-organization-of-partner-user"></a>
## Delete Organization of Partner User { #delete-organization-of-partner-user }

The partner deletes the organization of the partner user.

!!! tip "Verify Partner Agreement"
    Verify whether the partner and partner user had a partner contract relationship in the month the API was called, and whether the target of the deletion is the partner user's organization.

<a id="delete-organization-of-partner-user-required-permission"></a>
### Required Permission { #delete-organization-of-partner-user-required-permission }
`Partner.Organization.Delete`

<a id="delete-organization-of-partner-user-request"></a>
### Request { #delete-organization-of-partner-user-request }

```
DELETE /v1/partners/{partnerId}/partner-users/{partnerUserUuid}/organizations/{orgId}
```

<a id="delete-organization-of-partner-user-request-parameter"></a>
### Request Parameter { #delete-organization-of-partner-user-request-parameter }

| Name | Category | Type | Required | Description |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | Partner ID |
| partnerUserUuid | Path | String | Y | Partner User UUID |
| orgId | Path | String | Y | Organization ID to delete |

<a id="delete-organization-of-partner-user-request-body"></a>
### Request Body { #delete-organization-of-partner-user-request-body }

This API does not require a request body.

<a id="delete-organization-of-partner-user-response"></a>
### Response { #delete-organization-of-partner-user-response }

<details>
  <summary><strong>Response Example</strong></summary>

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
## Daily Usage Pricing { #daily-usage-pricing }

Retrieve details of a partner user's daily usage fees.

!!! tip "Verify Partner Agreement"
Checks whether the partner is the owner of a given project or organization, or has a partner agreement with the owner on the date being queried.

!!! note "Query Scope Restrictions"
- Either projectId or orgId must be set.
- Both projectId and orgId cannot be set simultaneously.

<a id="required-permissions"></a>
### Required Permissions { #required-permissions }
`Partner.Daily.Usage.List`

<a id="daily-usage-pricing-request"></a>
### Request { #daily-usage-pricing-request }

```
GET /v1/billing/partners/{partnerId}/daily-usage-prices
```

<a id="request-parameters"></a>
### Request Parameters { #request-parameters }

| Name | Category | Type | Required | Description |
| --- | --- | --- | --- |
| partnerId | Path | String | Y | Partner ID |
| projectId | Query | String | N | Project ID<br>Cannot be set simultaneously with orgId |
| orgId | Query | String | N | Organization ID<br>Cannot be set simultaneously with projectId |
| counterName | Query | String | N | Counter name |
| date | Query | String | Y | View date (yyyy-MM-dd format) |
| page | Query | Integer | N | Selected page (minimum: 1) |
| limit | Query | Integer | N | Number of items to display on the page (minimum: 1, maximum: 2,000) |

<a id="daily-usage-pricing-request-body"></a>
### Request Body { #daily-usage-pricing-request-body }

This API does not require a request body.

<a id="daily-usage-pricing-response"></a>
### Response { #daily-usage-pricing-response }

<details>
<summary><strong>Example Response</strong></summary>

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
      "parentResourceName": "parent resource",
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
#### Basic Response Structure

| Name | Type | Description |
| --- | --- | --- |
| projectDailyUsagePrices | List&lt;DailyUsagePrice&gt; | List of daily usage prices |
| totalItems | Integer | Number of results retrieved |

**DailyUsagePrice**

| Name | Type | Description |
| --- | --- | --- |
| basicPrice | Long | Pay-as-you-go price |
| billingGroupId | String | Billing group ID |
| contractId | String | Agreement ID |
| contractPrice | Long | Agreement price |
| counterName | String | Counter name |
| deltaBasicPrice | Long | Daily Pay-as-you-go price |
| deltaContractPrice | Long | Daily Agreement price |
| deltaUsage | BigDecimal | Daily usage |
| metadata | Map&lt;String, Object&gt; | Metadata |
| orgId | String | Organization ID |
| parentResourceId | String | Parent Resource ID |
| parentResourceName | String | Parent Resource Name |
| paymentGroupId | String | Payment Group ID |
| priceInformation | List&lt;Map&lt;String, Object&gt;&gt; | Unit Price Information |
| projectId | String | Project ID |
| resourceId | String | Resource ID |
| resourceName | String | Resource Name |
| usage | BigDecimal | Usage |
| usedDate | String | Usage Date |
| uuid | String | Member UUID |


<a id="retrieve-resource-usage-prices-by-tag"></a>
## Retrieve Resource Usage Prices by Tag { #retrieve-resource-usage-prices-by-tag }

Retrieve resource usage prices categorized by tag.

!!! tip "Verify Partner Agreement"
Checks whether the partner is the owner of the given project or organization, or has a partner agreement with the owner on the date of the query.

!!! tip "Query Scope Restrictions"
- Either projectId or orgId must be provided.
- Both projectId and orgId cannot be set simultaneously.
- Either tagIds or groupIds must be provided.

<a id="retrieve-resource-usage-prices-by-tag-required-permissions"></a>
### Required Permissions { #retrieve-resource-usage-prices-by-tag-required-permissions }
`Partner.Daily.Usage.List`

<a id="retrieve-resource-usage-prices-by-tag-request"></a>
### Request { #retrieve-resource-usage-prices-by-tag-request }

```
POST /v1/billing/partners/{partnerId}/resource-usage-prices-by-tag
```

<a id="retrieve-resource-usage-prices-by-tag-request-parameters"></a>
### Request Parameters { #retrieve-resource-usage-prices-by-tag-request-parameters }

| Name | Category | Type | Required | Description |
| --- | --- | --- | --- |
| partnerId | Path | String | Y | Partner ID |
| page | Query | Integer | N | Selected page (minimum: 1) |
| limit | Query | Integer | N | Number of items to display on the page (minimum: 1, maximum: 2,000) |

<a id="retrieve-resource-usage-prices-by-tag-request-body"></a>
### Request Body { #retrieve-resource-usage-prices-by-tag-request-body }

<details>
<summary><strong>Example Request</strong></summary>

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

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| date | String | Y | Query start date (in yyyy-MM-dd format) |
| groupIds | List&lt;String&gt; | N | List of group IDs<br>Either tagIds or groupIds is required |
| orgId | String | N | Organization ID<br>Either projectId or orgId is required |
| projectId | String | N | Project ID<br>Either projectId or orgId is required |
| searchType | String | Y | Query type<br><br>- RESOURCE: By resource<br>- DAILY: By day |
| tagIds | List&lt;Long&gt; | N | List of tag IDs<br>Either tagIds or groupIds is required |

<a id="retrieve-resource-usage-prices-by-tag-response"></a>
### Response { #retrieve-resource-usage-prices-by-tag-response }

<details>
<summary><strong>Example Response</strong></summary>

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
      "billingGroupName": "basic billing group",
      "categoryMain": "COMPUTE",
      "categorySub": "INSTANCE",
      "contractId": "contract123",
      "contractPrice": 95000,
      "counterName": "c2.small",
      "country": "KR",
      "displayOrder": "1",
      "orgId": "org123",
      "orgName": "test organization",
      "parentResourceId": "parent-resource-123",
      "paymentGroupId": "payment123",
      "priceInformation": "unit price info",
      "priceInformations": [
        {
          "basicUnitPrice": 1000.0,
          "contractUnitPrice": 950.0,
          "displayName": {
            "displayNameEn": "c2.small Instance",
            "displayNameJa": "c2.small インスタンス",
            "displayNameKo": "c2.small 인스턴스",
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
      "projectName": "test project",
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
#### Basic Response Structure

| Name | Type | Description |
| --- | --- | --- |
| resourceUsagePrices | List&lt;ResourceUsagePrice&gt; | List of resource usage prices |
| totalItems | Integer | Number of results retrieved |
| totalPrice | Long | Total usage price |

**ResourceUsagePrice**

| Name | Type | Description |
| --- | --- | --- |
| basicPrice | Long | Pay-as-you-go price |
| billingGroupId | String | Billing group ID |
| billingGroupName | String | Billing group name |
| categoryMain | String | Main category |
| categorySub | String | Subcategory |
| contractId | String | Agreement ID |
| contractPrice | Long | Agreement price |
| counterName | String | Counter name |
| country | String | Service country |
| displayOrder | String | Bill Display Order |
| orgId | String | Organization ID |
| orgName | String | Organization Name |
| parentResourceId | String | Parent Resource ID |
| paymentGroupId | String | Payment Group ID |
| priceInformation | String | Unit Price Information |
| priceInformations | List&lt;PriceInfo&gt; | Unit Price Information (Details) |
| productId | String | Service ID |
| productUiId | String | Homepage Service UI ID |
| projectId | String | Project ID |
| projectName | String | Project Name |
| regionTypeCode | String | Region Type Code |
| resourceId | String | Resource ID |
| usage | BigDecimal | Usage |
| useFixPriceYn | String | Whether to use a flat rate |
| usedDate | String | Usage Date |

**PriceInfo**

| Name | Type | Description |
| --- | --- | --- |
| basicUnitPrice | BigDecimal | Metered Unit Price |
| contractUnitPrice | BigDecimal | Contracted Unit Price |
| displayName | DisplayName | Bill Display Name |
| rangeFrom | BigDecimal | Starting Range |
| slidingCalculationTypeCode | String | Sliding Calculation Type <br><br>- NONE: None <br>- SECTION_SUM: Section Sum <br>- SECTION_SELECTED: Section Selection |
| unit | Long | Unit |
| unitName | String | Unit Name |

**DisplayName**

| Name | Type | Description |
| --- | --- | --- |
| displayNameEn | String | Bill Display Name (English) |
| displayNameJa | String | Bill Display Name (Japanese) |
| displayNameKo | String | Bill Display Name (Korean) |
| displayNameZh | String | Invoice Exposure Name (Chinese) |

<a id="retrieve-active-organizationproject-product-metering-for-partners-or-partner-users"></a>
## Retrieve Active Organization/Project Product Metering for Partners or Partner Users { #retrieve-active-organizationproject-product-metering-for-partners-or-partner-users }

Retrieve the metering information.

<a id="retrieve-active-organizationproject-product-metering-for-partners-or-partner-users-required-permission"></a>
### Required Permission { #retrieve-active-organizationproject-product-metering-for-partners-or-partner-users-required-permission }
`Partner.Meter.List`

<a id="retrieve-active-organizationproject-product-metering-for-partners-or-partner-users-request"></a>
### Request { #retrieve-active-organizationproject-product-metering-for-partners-or-partner-users-request }

```
POST /v1/billing/partners/{partnerId}/meters/search
```

<a id="retrieve-active-organizationproject-product-metering-for-partners-or-partner-users-request-parameter"></a>
### Request Parameter { #retrieve-active-organizationproject-product-metering-for-partners-or-partner-users-request-parameter }

| Name | Category | Type | Required | Description |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | Partner ID |
| page | Query | Integer | N | Selected page (minimum: 1) |
| limit | Query | Integer | N | Number of items to display on the page (minimum: 1, maximum: 2,000) |


<a id="retrieve-active-organizationproject-product-metering-for-partners-or-partner-users-request-body"></a>
### Request Body { #retrieve-active-organizationproject-product-metering-for-partners-or-partner-users-request-body }

<details>
  <summary><strong>Example Code</strong></summary>

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

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| from | String | Y | Query start time (ISO 8601 format, inclusive) |
| to | String | Y | Query end time (ISO 8601 format, exclusive) |
| appKeys | List&lt;String&gt; | N | List of app keys |
| counterNames | List&lt;String&gt; | N | List of counter names |
| meterTimeTypeCode | String | N | Meter time type code<br>Determines whether to search by used time or by the time the request was inserted for from and to<br>(USED_TIME: used time (default), INSERT_TIME: inserted time) |


<a id="retrieve-active-organizationproject-product-metering-for-partners-or-partner-users-response"></a>
### Response { #retrieve-active-organizationproject-product-metering-for-partners-or-partner-users-response }

<details>
  <summary><strong>Response example</strong></summary>

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

| Name | Type | Description |
| --- | --- | --- |
| meterList | List&lt;MeterProtocol&gt; | Metering List |
| totalItems | Integer | Total Count |

**MeterProtocol**

| Name | Type | Description |
| --- | --- | --- |
| appKey | String | App Key |
| counterName | String | Counter Name |
| counterType | String | Counter Type <br><br>- DELTA: incremental value <br>- GAUGE: current value <br>- HOURLY_LATEST: latest hourly value <br>- DAILY_MAX: maximum daily value <br>- MONTHLY_MAX: maximum monthly value <br>- STATUS: status value |
| counterUnit | String | Usage Unit (KB, HOUR, etc.) |
| counterValue | String | Usage Status<br>Used only when counter type is STATUS |
| counterVolume | BigDecimal | Usage |
| insertTime | String | Time spent from service to billing system |
| orgId | String | Organization ID |
| parentResourceId | String | Parent resource ID |
| productId | String | Service ID |
| projectId | String | Project ID |
| resourceId | String | Resource ID |
| resourceName | String | Resource name |
| stationId | String | Station ID |
| timestamp | String | Usage time |

<a id="error-code"></a>
## Error Code { #error-code }

| resultCode | Description | Action |
| --- | --- | --- |
| -14 | Request from an IP address not allowed in a country | Request from an allowed country, or check the IP restriction policy for each country |
| -8 | Request IP address not allowed or IP verification failed due to organization IP ACL policy | Check if the IP address is registered in the organization IP ACL, and if the request is from an allowed IP range |
| -7 | Permission denied | Contact your system administrator as you are not authorized to perform the action |
| -6 | An error occurs when the caller's authorization for the called API fails, or partner authorization verification fails | Check if the caller has permission to make API calls and, if necessary, contact your system administrator to request permission. Check the calling account permissions and request scope partner ID |
| -5 | Permission denied - Not the owner or the actual owner of the organization being deleted is different from the requesting partner user | Verify that the requester is the owner of the organization and that the target organization is owned by the partner user |
| -4 | Permission denied - Not a member | Verify that the requester is a member of the partner organization, obtain the appropriate permissions, and retry |
| -2 | Error when parameters are invalid | Check the format and values ​​of the request parameters and retry with the correct values ​​|
| 404 | Occurs when calling a non-existent API | Check the HTTP method and URI of the calling API |
| 500 | Abnormal system error | Contact your system administrator |
| 501 | Invalid date format | The date parameter was provided in the correct format |
| 502 | Invalid parameter | Check the values ​​and formats of the request parameters |
| 503 | Service unavailable or query period rules violated | The service is temporarily unavailable. Retry later or comply with the query period rules |
| 504 | JSON parsing failure | Check the JSON format of the request body |
| 505 | Validation failure | Check the field validation in the request |
| 1,000 | Error when parameters are incorrect | Check the format and values ​​of the request parameters and retry with the correct values ​​|
| 1,200 | API call failed | Retry later or check the system status |
| 10,005 | Error when request parameters are incorrect | Check the required and configurable values ​​for the request parameters |
| 11,010 | Insufficient permissions to view usage | Check and grant permissions for services/counters/organizations |
| 11,012 | No access to the organization | Grant the user access to the organization |
| 11,013 | The member is not a partner user, or the specified partner ID does not match the partner user UUID | Check whether the member was a partner user during the specified period and reset the partnership. Verify that the partner user is authorized and linked to the partner. |
| 12,000 | Project not found | Verify that the requested project ID exists and retry with the correct project ID. |
| 12,100 | Error when a project member does not exist. | Use an existing project member UUID. |
| 16500 | Asynchronous Job Not Found | The specified Asynchronous ID is invalid or does not exist. Verify that you have entered the correct Async ID |
| 17,001 | App key not found | Verify that the app key was issued correctly and reissue it if necessary. |
| 17,003 | No association between the app key and project/service. | Associate the app key with the correct project/service. |
| 17,501 | Organization not found | Verify that the organization ID exists. |
| 18,001 | Project not found | Verify that the project ID exists. |
| 22,001 | No partner default group. | Verify the partner default group settings. |
| 22,002 | No partner payment group. | Verify the partner payment group settings. |
| 22,003 | Partner adjustment range error. Verify that the partner adjustment value is within the allowable range |
| 22,004 | Not a solution partner service | Verify that the requested service is a solution partner service |
| 22,005 | Not a solution partner | Verify that the partner qualifies as a solution partner |
| 22,007 | The partner does not have permission to access the resource | Verify that the target resource belongs to you or that you have the necessary access rights |
| 22,008 | The request was made with an incorrect AppKey | Check if the AppKey associated with the service is valid and correctly entered |
| 22,009 | The requested counter name is not recognized | Verify the counter name for the service and try again |
| 22,021 | An error occurs when the number of organizations created exceeds the limit set for the organization owner account when creating an organization | 1) Delete unused organizations to secure the number of organizations that can be created. <br>2) Adjust the maximum number of organization creations through the system administrator |
| 22,023 | Organization creation is restricted due to exceeding the MSP partner limit | Adjust the MSP partner limit or organize the organization |
| 23,005 | An error occurs when an organization corresponding to the organization ID does not exist | Contact the system administrator |
| 24,000 | API integration failure | Contact the system administrator |
| 24,001 | App key validation failure | Check the app key validity |
| 24,002 | Member information validation failure | Check member information |
| 24,005 | No project members | Check if the member belongs to a project |
| 24,007 | No project | Check the project ID or contact the system administrator |
| 25,001 | No country-specific tax policy | Contact the system administrator |
| 70,013 | An error occurs when a service in use exists | Disable the service in use |
| 70,032 | Organization creation blocked due to non-payment sanctions | Request to resolve non-payment and lift sanctions, then retry |
| 80,400 | Invalid request | Check request parameter format and required values ​​|
| 80,401 | Authentication failure | Check authentication token validity and login status |
| 80,500 | Server error | Check server logs and contact your system administrator |