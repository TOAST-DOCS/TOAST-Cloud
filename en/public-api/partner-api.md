# Partner Management API Guide

**NHN Cloud > Public API > Partner Management API Guide**

## Common Information for Partner Management API

### API Endpoint

An endpoint information for calling partner management API.<br>
This API can only be called by partners or users authorized by partners, and cannot be used by general users.

| Region     | Endpoint |
|--------| ----- |
| Global | https://core.api.nhncloudservice.com/ |

### Authentication and Permission

The following authentication header is required to use the Partner Management API:

| Header name | Description |
| --- | --- |
| x-nhn-authorization | Refer to the token for API authentication ([API authentication](api-authentication.md)) |

### Response Common Information

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

!!! warning "API Response Field Extensibility"
    API Responses may contain additional fields not specified below. Be careful that new fields are added and no error occurs.


## View Organization Usage List of Partner Users

Provide the partner user's billing amount, usage fee per organization, usage fee per product, and surcharge information.

!!! tip "Verify Partner Agreement"
    Verify that the partner and partner user entered into a partnership agreement in the specified month.

!!! tip "Notice"
    The month of use must be entered in yyyy-MM format.

### Required Permission
`Partner.Payment.Get`

### Request

```
GET /v1/billing/partners/{partnerId}/payments/{month}
```

### Request Parameter

| Name | Category | Type | Required | Description |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | Partner ID |
| month | Path | String | Y | Month of use (yyyy-MM format) |
| partnerUserUuid | Query | String | Y | Partner user UUID |
| lang | Header | String | N | Language setting (default: ko_KR, selectable value: ko_KR, ja_JP, en_US) |

### Request Body

This API does not require a request body.

### Response

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

#### Default Response Structure

| Name | Type | Description |
| --- | --- | --- |
| payment | Object | Payment info |
| payment.charge | Long | Amount used + project surcharge |
| payment.totalAmount | Long | Billing amount (usage amount + VAT) |
| payment.taxAmount | Long | VAT |
| payment.currency | String | Currency<br>Returns in the corresponding language based on lang |
| payment.orgList | List<Object> | Usage list per organization |
| payment.usageSummaryList | List<Object> | Usage summary list |
| payment.extraSummaryList | List<Object> | Project surcharge summary list |

**orgList**

| Name | Type | Description |
| --- | --- | --- |
| orgName | String | Organization name |
| charge | Long | Amount used by organization |

**usageSummaryList**

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

**extraSummaryList**

| Name | Type | Description |
| --- | --- | --- |
| description | String | Surcharge description |
| extraPrice | Long | Project surcharge |


## Retrieve Organization Lists of Partner Users

Retrieve the list of organization users of the partner.

!!! tip "Verify Partner Agreement"
    Verify that the partner and partner user entered into a partnership agreement in the specified month.

### Required Permission
`Partner.Organization.List`

### Request

```
GET /v1/billing/partners/{partnerId}/payments/{month}/organizations
```

### Request Parameter

| Name | Category | Type | Required | Description |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | Partner ID |
| month | Path | String | Y | Usage period (yyyy-MM format) |
| partnerUserUuid | Query | String | Y | Partner User UUID |

### Request Body

This API does not require a request body.

### Response

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

 Name | Type | Description |
| --- | --- | --- |
| organizations | List;Object&gt; | Organization list |
| organizations[].orgId | String | Organization ID |
| organizations[].orgName | String | Organization name |
| organizations[].orgStatusCode | String | Organization status (STABLE: normal status, CLOSED: deleted status |
| organizations[].orgCreationType | String | Organization creation type (USER: customer-created organization, SYSTEM: organization created by the system) |
| organizations[].cloudType | String | Cloud type |


## Retrieve the Billing Amount per Organizations of Partner Users

Retrieve the details of the specific organization's amount used, discount, and surcharge amounts.

!!! tip "Verify Partner Agreement"
    Verify that the partner and partner user in question had a partner agreement in the specified month, and that the owner of the organization in question was a partner user in that month.

### Required Permission
`Partner.Organization.Usage.Get`

### Request

```
GET /v1/billing/partners/{partnerId}/payments/{month}/organizations/{orgId}/usage
```

### Request Parameter

| Name | Category | Type | Required | Description |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | Partner ID |
| month | Path | String | Y | Usage month (yyyy-MM format) |
| orgId | Path | String | Y | organization ID |
| lang | Header | String | N | Language Settings (default: ko\_KR, setable value: ko\_KR, ja\_JP, en\_US)

### Request Body

This API does not require a request body.

### Response

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
        "balanceTypeName": "무료 크레딧",
        "i18nBalanceTypeNameMap": {
          "ko_KR": "무료 크레딧",
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
    },
    "projects": [
      {
        "projectId": "project123",
        "projectName": "테스트 프로젝트",
        "totalAmount": 95000,
        "usagePrice": 100000,
        "contractUsagePrice": 95000
      }
    ]
  }
}
```

</details>

#### Default Response Structure

| Name | Type | Description |
| --- | --- | --- |
| org | Object | Organization information |
| org.orgId | String | Organization ID |
| org.orgName | String | Organization name |
| org.totalAmount | Long | Organization total amount |
| org.usagePrice | Long | Amount used |
| org.contractUsagePrice | Long | Total amount used with commitment-based discounts/commitment underutilization charge |
| org.contractDiscountPrice | Long | Amount discounted by commitment |
| org.contractExtraPrice | Long | Amount surcharged by commitment |
| org.totalCredit | Long | Total Credit Amount |
| org.country | String | Country code |
| org.creditUsages | List<Object> | Credit usage amount |
| org.projectDiscount | Object | List of discount details by project |
| org.projectExtra | Object | List of surcharge details by project |
| org.projects | List<Object> | List of projects |

**creditUsages**

| Name | Type | Description |
| --- | --- | --- |
| balanceTypeCode | String | Campaign type |
| balanceTypeName | String | Campaign type name |
| i18nBalanceTypeNameMap | Object | Campaign type name multilingual code |
| usageAmount | Long | Credit usage amount |

**projectDiscount**

| Name | Type | Description |
| --- | --- | --- |
| totalAdjustment | Long | Total discount amount |
| details | List<Object> | Details |
| details\[].projectId | String | Project ID |
| details\[].projectName | String | Project name |
| details\[].adjustment | Long | Discount amount |
| details\[].adjustmentTypeCode | String | Discount type<br>\- CONTRACT\_EXTRA: Commitment underutilization charge<br>\- CONTRACT\_PENALTY: Cancellation fee<br>\- CONTRACT\_DISCOUNT: Commitment-based discount<br>\- CONTRACT\_PAYBACK: Partner payback<br>\- STATIC\_EXTRA: Fixed amount surcharge<br>\- PERCENT\_DISCOUNT: Percentage discount<br>\- COUPON: Coupon<br>\- STATIC\_DISCOUNT: Fixed amount discount<br>\- CUTOFF: cutoff under 500 won |
| details\[].description | String | Discount details |

**projectExtra**

| Name | Type | Description |
| --- | --- | --- |
| totalAdjustment | Long | Total surcharge |
| details | List<Object> | Details |
| details\[].projectId | String | Project ID |
| details\[].projectName | String | Project name |
| details\[].adjustment | Long | Surcharge |
| details\[].adjustmentTypeCode | String | Surcharge type<br>\- CONTRACT\_EXTRA: Commitment underutilization charge<br>\- CONTRACT\_PENALTY: Cancellation fee<br>\- CONTRACT\_DISCOUNT: Commitment-based discount<br>\- CONTRACT\_PAYBACK: Partner payback<br>\- STATIC\_EXTRA: Fixed amount surcharge<br>\- PERCENT\_DISCOUNT: Percentage discount<br>\- COUPON: Coupon<br>\- STATIC\_DISCOUNT: Fixed amount discount<br>\- CUTOFF: cutoff under 500 won |
| details\[].description | String | Surcharge details |

**projects**

| Name | Type | Description |
| --- | --- | --- |
| projectId | String | Project ID |
| projectName | String | Project name |
| totalAmount | Long | Project final amount |
| usagePrice | Long | Project usage amount total |
| contractUsagePrice | Long | Usage amount total with commitment-based discount/commitment underutilization charge applied |


## Retrieve Project Lists of Partner Users

Retrieves a list of projects of partner users.

!!! tip "Verify Partner Agreement"
    Verify that the partner and partner user entered into a partnership agreement in the specified month.

### Required Permission
`Partner.Project.List`

### Request

```
GET /v1/billing/partners/{partnerId}/payments/{month}/projects
```

### Request Parameter

| Name | Category | Type | Required | Description |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | Partner ID |
| month | Path | String | Y | Usage period (yyyy-MM format) |
| partnerUserUuid | Query | String | Y | Partner User UUID |

### Request Body

This API does not require a request body.

### Response

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
| projects | List<Object> | Project list |
| projects[].orgId | String | Organization ID |
| projects[].orgName | String | Organization name |
| projects[].orgCreationType | String | Organization creation type<br><br>- USER: organization created by customer<br>- SYSTEM: organization created by system (mainly used for member marketplaces) |
| projects[].orgStatusCode | String | Organization status<br><br>- STABLE: normal status<br>- CLOSED: deleted status |
| projects[].projectId | String | Project ID |
| projects[].projectName | String | Project name |
| projects[].projectCreationType | String | Project creation type<br><br>- USER: project created by customer<br>- SYSTEM: project created in the system (mainly used for organization products and member marketplaces) |
| projects[].projectStatusCode | String | Project status<br><br>- STABLE: normal status<br>- CLOSED: deleted status |


## Retrieve Project Usage Details for Partner User

Retrieve the detailed usage of a specific project.

!!! danger "Caution"
    Optimize performance by using paging appropriately when querying usage.

!!! tip "Verify Partner Agreement"
    Verify that the partner and partner user in question had a partner agreement in the specified month, and that the owner of the organization to which the project belongs was a partner user in that month.

### Required Permission
`Partner.Project.Usage.Get`

### Request

```
GET /v1/billing/partners/{partnerId}/payments/{month}/projects/{projectId}/usage
```

### Request Parameter

| Name | Category | Type | Required | Description |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | Partner ID |
| month | Path | String | Y | Month of use (yyyy-MM format) |
| projectId | Path | String | Y | Project ID |
| lang | Header | String | N | Language setting (default: ko_KR, configurable values: ko_KR, ja_JP, en_US) |
| usageSchemaTypeCode | Query | String | N | Include usage<br>Decide whether to use the existing usage inquiry method or the new grouping method<br>(Default: NO_GROUP)<br><br>- NO_GROUP: usage is displayed as is, without being grouped. <br>- GROUP_BY_PARENT_RESOURCE: grouping is done by parent resource, but specific usage is not provided. The totalItems returned allows you to check how many parent resources exist.<br>- GROUP_BY_PARENT_RESOURCE_INCLUDE_USAGES: after grouping parent resources separately, which parent resource is grouped as and how it is used in detail |
| page | Query | Integer | N | Selected page (default: 1, minimum: 1)<br>if usageSchemaTypeCode is NO_GROUP, it is unavailable |
| itemsPerPage | Query | Integer | N | Number of items to be displayed on the page, if not entered, full view (minimum: 0)<br>Not available when usageSchemaTypeCode is NO_GROUP |
| categoryMain | Query | String | N | Main category<br>If usageSchemaTypeCode is NO_GROUP, it cannot be used |
| regionTypeCode | Query | String | N | Region type code (up to 20 characters)<br>If usageSchemaTypeCode is NO_GROUP, it cannot be used |

### Request Body

This API does not require a request body.

### Response

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

#### Default Response Structure

| Name | Type | Description |
| --- | --- | --- |
| project | Object | Project information |
| project.projectId | String | Project ID |
| project.projectName | String | Project name |
| project.totalAmount | Long | Project total amount |
| project.usagePrice | Long | Amount used |
| project.contractUsagePrice | Long | Total usage amount with commitment-based discount/commitment underutilization charge applied |
| project.contractDiscountPrice | Long | Amount discounted by contract |
| project.contractExtraPrice | Long | Amount of commitment underutilization charge |
| project.totalCredit | Long | Total credit amount |
| project.country | String | Country code |
| project.creditUsages | List<Object> | Credit Usage Amount |
| project.projectDiscount | Object | Discount details by project |
| project.projectExtra | Object | Surcharge details by project |
| project.usageGroups | List<Object> | List of usage groups |

**creditUsages**

| Name | Type | Description |
| --- | --- | --- |
| balanceTypeCode | String | Campaign type (balance type) |
| balanceTypeName | String | Campaign type name (balance type name) |
| i18nBalanceTypeNameMap | Object | Campaign type name multilingual code |
| usageAmount | Long | Credit amount used |

**projectDiscount**

| Name | Type | Description |
| --- | --- | --- |
| totalAdjustment | Long | Total discount amount |
| details | List<Object> | Details |
| details[].projectId | String | Project ID |
| details[].projectName | String | Project name |
| details[].adjustment | Long | Discount amount |
| details[].adjustmentTypeCode | String | Discount type<br>- CONTRACT_EXTRA: Commitment underutilization charge<br>- CONTRACT_PENALTY: Cancellation fee<br>- CONTRACT_DISCOUNT: Commitment-based discount<br>- CONTRACT_PAYBACK: Partner payback<br>- STATIC_EXTRA: Fixed amount surcharge<br>- PERCENT_DISCOUNT: Percentage discount<br>- COUPON: Coupon<br>- STATIC_DISCOUNT: Fixed amount discount<br>- CUTOFF: cutoff under 500 won |
| details[].description | String | Discount details |

**projectExtra**

| Name | Type | Description |
| --- | --- | --- |
| totalAdjustment | Long | Total surcharge |
| details | List<Object> | Details |
| details[].projectId | String | Project ID |
| details[].projectName | String | Project name |
| details[].adjustment | Long | Surcharge |
| details[].adjustmentTypeCode | String | Surcharge type<br>- CONTRACT_EXTRA: Commitment underutilization charge<br>- CONTRACT_PENALTY: Cancellation fee<br>- CONTRACT_DISCOUNT: Commitment-based discount<br>- CONTRACT_PAYBACK: Partner payback<br>- STATIC_EXTRA: Fixed amount surcharge<br>- PERCENT_DISCOUNT: Percentage discount<br>- COUPON: Coupon<br>- STATIC_DISCOUNT: Fixed amount discount<br>- CUTOFF: cutoff under 500 won |
| details[].description | String | Surcharge details |

**usageGroups**

#### usageGroups Basic Information

| Name | Type | Description |
| --- | --- | --- |
| categoryMain | String | Main category |
| stationId | String | Station ID |
| stationName | String | Station name |
| regionTypeCode | String | Region |
| needType | Boolean | Whether to display the category column |
| totalItems | Integer | Total number of usages by UsageGroup |
| totalPrice | Long | Total usage amount with commitment-based discount applied |
| usagePrice | Long | Total usage amount |
| usageResourceGroups | List<Object> | Grouped usage list |
| usages | List<Object> | Detailed usage list |

**usageResourceGroups**

| Name | Type | Description |
| --- | --- | --- |
| parentResourceId | String | Parent resource ID for identification |
| parentResourceName | String | Parent resource Name for identification |
| usages | List<Object> | Detailed usage list (UsageDTO schema) |

**UsageDTO Schema**

| Name | Type | Description |
| --- | --- | --- |
| categoryMain | String | Main category |
| categorySub | String | Sub category |
| contractId | String | Agreement ID |
| contractPrice | Long | Usage amount calculated by commitment |
| contractUnitPrice | BigDecimal | Commitment use discount |
| counterName | String | Counter Name |
| displayNameEn | String | Billing unit display name (en) |
| displayNameJa | String | Billing unit display name (ja) |
| displayNameKo | String | Billing unit display name (ko) |
| displayNameZh | String | Billing unit display name (zh) |
| displayOrder | Long | Display order |
| parentResourceId | String | Parent resource ID |
| parentResourceName | String | Parent resource name |
| price | Long | Usage amount |
| productUiId | String | Homepage product UI ID |
| projectId | String | Project ID |
| projectName | String | Project name |
| rangeFrom | BigDecimal | Starting range |
| regionTypeCode | String | Region |
| resourceId | String | Resource ID |
| resourceName | String | Resource name |
| seq | Long | seq |
| stationId | String | Station ID |
| stationName | String | Station name |
| unit | Long | Charging unit |
| unitName | String | Unit name |
| unitPrice | BigDecimal | Price per unit |
| usage | BigDecimal | Usage |
| useFixPrice | Boolean | Fixed price |

**usages**

| Name | Type | Description |
| --- | --- | --- |
| counterName | String | Counter name |
| counterType | String | Counter type |
| productId | String | Product ID |
| projectId | String | Project ID |
| resourceId | String | Resource ID |
| resourceName | String | Resource name |
| parentResourceId | String | Parent resource ID |
| usage | BigDecimal | Usage amount |
| usedTime | String | Usage time |


## Retrieve Partner’s Bill

Retrieve the partner's full bill.

!!! tip "Verify Partner Agreement"
    Verify that the partner in question had a valid partner agreement in the specified month.

### Required Permission
`Partner.Statement.Get`

### Request

```
GET /v1/billing/partners/{partnerId}/payments/{month}/statements
```

### Request Parameter

| Name | Category | Type | Required | Description |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | Partner ID |
| month | Path | String | Y | Month of use (yyyy-MM format) |
| lang | Header | String | N | Language setting (default: ko_KR, configurable values: ko_KR, ja_JP, en_US) |

### Request Body

This API does not require a request body.

### Response

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

#### Default Response Structure

| Name | Type | Description |
| --- | --- | --- |
| paymentStatements | List<Object> | List of bills |

**paymentStatements**

| Name | Type | Description |
| --- | --- | --- |
| uuid | String | Member UUID |
| autoPaymentTypeCode | String | Payment method<br><br>- PAYCO_CREDIT_CARD: Payco credit card<br>- CREDIT_CARD: credit card<br>- INTER_CREDIT_CARD: international credit card<br>- UNION_PAY: Union Pay<br>- JAPAN_BILLING: Japanese billing<br>- ACCOUNT_TRANSFER: account transfer<br>- CREDIT_ALL: general credit<br>- CREDIT_LIMIT: event credit<br>- ESM: Internal cost<br>- ONETIME_PAYMENT: One-time payment<br>- TAX_BILL: Issue a tax bill<br>- CONTRACT_BILL: Issue a tax bill (The amount of the bill may be adjusted through a separate contract)<br>- NONE: none |
| isAutoPayment | Boolean | Whether automatic payment is enabled |
| paymentInfo | String | Payment method information |
| statements | List<Object> | List of payment details by billing group |

**statements**

#### statements Basic Information

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
| realSupplyAmount | Long | Actual Supply Amount |
| realTaxAmount | Long | Actual VAT Paid |
| receiptStatusCode | String | Sales Voucher Status Code<br><br>- NONE: sales have not yet been reported to the accounting team, so sales receipts cannot be viewed.<br>- EXIST: after the final amount adjustment is completed, the sales report is sent to the accounting team, and the sales voucher can be viewed. |
| refundAccountRegisterStatusCode | String | Status of whether the refund account has been registered<br><br>- ALLOW: Open status of refund account registration<br>- DENY: Default, Close status of register refund accounts |
| details | List<Object> | List of details by billing group |

**details**

#### Basic Information for Details

| Name | Type | Description |
| --- | --- | --- |
| billingGroupId | String | Billing group ID |
| billingGroupName | String | Billing group name |
| charge | Long | Amount used |
| contractDiscount | Long | Commitment-based discount amount |
| contractExtra | Long | Commitment underutilization charge amount |
| totalAmount | Long | Final amount |
| totalCredit | Long | Total credit usage amount |
| totalDiscount | Long | Discount amount |
| totalExtra | Long | Surcharge amount |
| creditUsages | List<Object> | Credit usage amount |
| orgList | List<Object> | List of organizations |
| usageGroups | List<Object> | List of usage groups |
| billingGroupDiscount | Object | Billing group discount details |
| billingGroupExtra | Object | Billing group surcharge details |
| projectDiscount | Object | Project-specific discount details |
| projectExtra | Object | Project-specific surcharge details |

**creditUsages**

| Name | Type | Description |
| --- | --- | --- |
| balanceTypeCode | String | Campaign type (balance type) |
| balanceTypeName | String | Campaign type name (balance type name) |
| i18nBalanceTypeNameMap | Object | Campaign type name multilingual code |
| usageAmount | Long | Credit amount used |

**orgList**

| Name | Type | Description |
| --- | --- | --- |
| orgId | String | Organization ID |
| orgName | String | Organization name |
| totalAmount | Long | Organization total amount |

**usageGroups**

| Name | Type | Description |
| --- | --- | --- |
| categoryMain | String | Main category |
| needType | Boolean | Whether to display the category column |
| regionTypeCode | String | Region |
| stationId | String | Station ID |
| stationName | String | Station name |
| totalItems | Integer | Total number of usages by UsageGroup |
| totalPrice | Long | Total usage amount with commitment-based discount discount applied |
| usagePrice | Long | Total usage amount |
| usageResourceGroups | List<Object> | Grouped usage list |
| usages | List<Object> | Detailed usage list |

**billingGroupDiscount**

| Name | Type | Description |
| --- | --- | --- |
| totalAdjustment | Long | Discount amount |
| details | List<Object> | Details |
| details[].adjustment | Long | Discount amount |
| details[].adjustmentTypeCode | String | Discount type<br><br>- CONTRACT_EXTRA: Commitment underutilization charge<br>- CONTRACT_PENALTY: Cancellation fee<br>- CONTRACT_DISCOUNT: Commitment-based discount<br>- CONTRACT_PAYBACK: Partner payback<br>- STATIC_EXTRA: Fixed amount surcharge<br>- PERCENT_DISCOUNT: Percentage discount<br>- COUPON: Coupon<br>- STATIC_DISCOUNT: Fixed amount discount<br>- CUTOFF: cutoff under 500 won |
| details[].description | String | Discount details |

**billingGroupExtra**

| Name | Type | Description |
| --- | --- | --- |
| totalAdjustment | Long | Surcharge amount |
| details | List<Object> | details |
| details[].adjustment | Long | Surcharge amount |
| details[].adjustmentTypeCode | String | Surcharge type<br><br>- CONTRACT_EXTRA: Commitment underutilization charge<br>- CONTRACT_PENALTY: Cancellation fee<br>- CONTRACT_DISCOUNT: Commitment-based discount<br>- CONTRACT_PAYBACK: Partner payback<br>- STATIC_EXTRA: Fixed amount surcharge<br>- PERCENT_DISCOUNT: Percentage discount<br>- COUPON: Coupon<br>- STATIC_DISCOUNT: Fixed amount discount<br>- CUTOFF: cutoff under 500 won |
| details[].description | String | Surcharge details |

**projectDiscount**

| Name | Type | Description |
| --- | --- | --- |
| totalAdjustment | Long | Total discount amount |
| details | List<Object> | Details |
| details[].projectId | String | Project ID |
| details[].projectName | String | Project name |
| details[].adjustment | Long | Discount amount |
| details[].adjustmentTypeCode | String | Discount type<br><br>- CONTRACT_EXTRA: Commitment underutilization charge<br>- CONTRACT_PENALTY: Cancellation fee<br>- CONTRACT_DISCOUNT: Commitment-based discount<br>- CONTRACT_PAYBACK: Partner payback<br>- STATIC_EXTRA: Fixed amount surcharge<br>- PERCENT_DISCOUNT: Percentage discount<br>- COUPON: Coupon<br>- STATIC_DISCOUNT: Fixed amount discount<br>- CUTOFF: cutoff under 500 won |
| details[].description | String | Discount details |

**projectExtra**

| Name | Type | Description |
| --- | --- | --- |
| totalAdjustment | Long | Total surcharge |
| details | List<Object> | Details |
| details[].projectId | String | Project ID |
| details[].projectName | String | Project name |
| details[].adjustment | Long | Surcharge |
| details[].adjustmentTypeCode | String | Surcharge type<br><br>- CONTRACT_EXTRA: Commitment underutilization charge<br>- CONTRACT_PENALTY: Cancellation fee<br>- CONTRACT_DISCOUNT: Commitment-based discount<br>- CONTRACT_PAYBACK: Partner payback<br>- STATIC_EXTRA: Fixed amount surcharge<br>- PERCENT_DISCOUNT: Percentage discount<br>- COUPON: Coupon<br>- STATIC_DISCOUNT: Fixed amount discount<br>- CUTOFF: cutoff under 500 won |
| details[].description | String | Surcharge details |


## Retrieve Self-Product Metering of Solutions Partner

Retrieve metering information for their products by a solution partner.

!!! tip "Verify Solution Partner"
    Only solution partners or users authorized by a solution partner can call this feature.

### Required Permission
`Partner.Meter.List`

### Request

```
GET /v1/billing/partners/{partnerId}/products/{productId}/meters
```

### Request Parameter

| Name | Category | Type | Required | Description |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | Partner ID |
| productId | Path | String | Y | Product ID |
| from | Query | String | Y | Query start date (yyyy-MM-ddThh:mm:ss.sssZ, inclusive) |
| to | Query | String | Y | Query end date (yyyy-MM-ddThh:mm:ss.sssZ, exclusive) |
| counterName | Query | String | Y | Counter name |
| meterTimeTypeCode | Query | String | N | Meter time type code<br><br>- INSERT_TIME: based on metering insertion time<br>- USED_TIME: based on metering insertion time |
| page | Query | Integer | Y | Selected page (minimum: 1) |
| limit | Query | Integer | Y | number of items to be displayed on the page (minimum: 1, max: 2,000) |

### Request Body

This API does not require a request body.

### Response

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
| meterList | List<Object> | Metering list |
| meterList[].appKey | String | Product App Key |
| meterList[].counterName | String | Counter name |
| meterList[].counterType | String | Counter type<br><br>- DELTA: increment value<br>- GAUGE: current value<br>- HOURLY_LATEST: hourly latest value<br>- DAILY_MAX: daily maximum value<br>- MONTHLY_MAX: Monthly maximum value<br>- STATUS: status value |
| meterList[].counterUnit | String | Counter unit |
| meterList[].counterValue | String | Usage status (only used when counterType is STATUS) |
| meterList[].counterVolume | BigDecimal | Counter volume |
| meterList[].gmid | String | Global metering ID |
| meterList[].insertTime | String | Metering insert time |
| meterList[].orgId | String | Organization ID |
| meterList[].parentResourceId | String | Parent resource ID |
| meterList[].productId | String | Product ID |
| meterList[].projectId | String | Project ID |
| meterList[].resourceId | String | Resource ID |
| meterList[].resourceName | String | Resource name |
| meterList[].source | String | IP or host name where metering occurred |
| meterList[].stationId | String | Station ID |
| meterList[].timestamp | String | Metering occurrence time |
| totalItems | Integer | Total number of items |


## Create Organization for Partner User

A partner creates the organization of the partner user.

!!! tip "Verify Partner Agreement"
    Verify if the partner and partner user had a partner contract relationship in the month in which the API was called.

### Required Permission
`Partner.Organization.Create`

### Request

```
POST /v1/partners/{partnerId}/partner-users/{partnerUserUuid}/organizations
```

### Request Parameter

| Name | Category | Type | Required | Description |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | Partner ID |
| partnerUserUuid | Path | String | Y | Partner user UUID |

### Request Body

| Name | Category | Type | Required | Description |
| --- | --- | --- | --- | --- |
| orgName | String | Y | Organization name (up to 120 characters) |

### Response

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


## Delete Organization of Partner User

The partner deletes the organization of the partner user.

!!! tip "Verify Partner Agreement"
    Verify whether the partner and partner user had a partner contract relationship in the month the API was called, and whether the target of the deletion is the partner user's organization.

### Required Permission
`Partner.Organization.Delete`

### Request

```
DELETE /v1/partners/{partnerId}/partner-users/{partnerUserUuid}/organizations/{orgId}
```

### Request Parameter

| Name | Category | Type | Required | Description |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | Partner ID |
| partnerUserUuid | Path | String | Y | Partner User UUID |
| orgId | Path | String | Y | Organization ID to delete |

### Request Body

This API does not require a request body.

### Response

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

## Error Code

| resultCode | Description | Action |
| --- | --- | --- |
| -14 | Request from an IP address not allowed in a country | Request from an allowed country, or check the IP restriction policy for each country |
| -8 | Request IP address not allowed or IP verification failed due to organization IP ACL policy | Check if the IP address is registered in the organization IP ACL, and if the request is from an allowed IP range |
| -7 | Permission denied | Contact your system administrator as you are not authorized to perform the action |
| -6 | An error occurs when the caller's authorization for the called API fails, or partner authorization verification fails | Check if the caller has permission to make API calls and, if necessary, contact your system administrator to request permission. Check the calling account permissions and request scope partner ID |
| -5 | Permission denied - Not the owner or the actual owner of the organization being deleted is different from the requesting partner user | Verify that the requester is the owner of the organization and that the target organization is owned by the partner user |
| -4 | Permission denied - Not a member | Verify that the requester is a member of the partner organization, obtain the appropriate permissions, and retry |
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
| 11,010 | Insufficient permissions to view usage | Check and grant permissions for products/counters/organizations |
| 11,012 | No access to the organization | Grant the user access to the organization |
| 11,013 | The member is not a partner user, or the specified partner ID does not match the partner user UUID | Check whether the member was a partner user during the specified period and reset the partnership. Verify that the partner user is authorized and linked to the partner. |
| 12,000 | Project not found | Verify that the requested project ID exists and retry with the correct project ID. |
| 12,100 | Error when a project member does not exist. | Use an existing project member UUID. |
| 17,001 | App key not found | Verify that the app key was issued correctly and reissue it if necessary. |
| 17,003 | No association between the app key and project/product. | Associate the app key with the correct project/product. |
| 17,501 | Organization not found | Verify that the organization ID exists. |
| 18,001 | Project not found | Verify that the project ID exists. |
| 22,001 | No partner default group. | Verify the partner default group settings. |
| 22,002 | No partner payment group. | Verify the partner payment group settings. |
| 22,003 | Partner adjustment range error. Verify that the partner adjustment value is within the allowable range |
| 22,004 | Not a solution partner product | Verify that the requested product is a solution partner product |
| 22,005 | Not a solution partner | Verify that the partner qualifies as a solution partner |
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