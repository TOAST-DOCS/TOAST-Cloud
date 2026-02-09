# 파트너 관리 API 가이드

**NHN Cloud > Public API 사용 가이드 > 파트너 관리 API 가이드**

## 파트너 관리 API 공통 정보

### API 엔드포인트

파트너 관리 API를 호출하기 위한 엔드포인트 정보입니다.<br>
파트너 혹은 파트너에게 권한을 부여 받은 사용자만 호출 가능한 API이며, 일반 사용자는 사용할 수 없습니다.

| 리전     | 엔드포인트 |
|--------| ----- |
| Global | https://core.api.gov-nhncloudservice.com/ |

### 인증 및 권한

파트너 관리 API를 사용하기 위해서는 다음과 같은 인증 헤더가 필요합니다.

| 헤더명 | 설명 |
| --- | --- |
| x-nhn-authorization | API 인증을 위한 토큰([API 인증](api-authentication-gov.md) 참고) |

### 응답 공통 정보

모든 API는 다음과 같은 공통 응답 구조를 가집니다.

<details>
  <summary><strong>성공 응답</strong></summary>

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
  <summary><strong>실패 응답</strong></summary>

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

| 이름 | 타입 | 설명 |
| --- | --- | --- |
| header.isSuccessful | Boolean | 성공 여부 |
| header.resultCode | Integer | 결과 코드(성공 시 0) |
| header.resultMessage | String | 결과 메시지 |

!!! danger "API 응답 필드 확장성"
    API Response는 아래에 명시되지 않은 필드가 추가될 수 있습니다. 새로운 필드가 추가되어도 오류가 발생하지 않도록 주의하세요.


## 파트너 사용자의 조직 사용량 목록 조회

파트너 사용자의 청구 금액, 조직별 사용 금액, 서비스별 사용 금액, 할증 정보를 제공합니다.

!!! tip "파트너 계약 검증"
    해당 파트너와 파트너 사용자가 지정된 월에 파트너 계약을 맺은 상태였는지 확인합니다.

!!! tip "알아두기"
    이용월은 yyyy-MM 형식으로 입력해야 합니다.

### 필요 권한
`Partner.Payment.Get`

### 요청

```
GET /v1/billing/partners/{partnerId}/payments/{month}
```

### 요청 파라미터

| 이름 | 구분 | 타입 | 필수 | 설명 |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | 파트너 ID |
| month | Path | String | Y | 이용월(yyyy-MM 형식) |
| partnerUserUuid | Query | String | Y | 파트너 사용자 UUID |
| lang | Header | String | N | 언어 설정(기본값: ko_KR, 설정 가능한 값: ko_KR, ja_JP, en_US) |

### 요청 본문

이 API는 요청 본문을 요구하지 않습니다.

### 응답

<details>
  <summary><strong>응답 예시</strong></summary>

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

#### 기본 응답 구조

| 이름 | 타입 | 설명 |
| --- | --- | --- |
| payment | PartnerUserOrgUsage | 결제 정보 |

**PartnerUserOrgUsage**

| 이름 | 타입 | 설명 |
| --- | --- | --- |
| charge | Long | 사용 금액+프로젝트 할증 금액 |
| totalAmount | Long | 청구 금액(사용 금액+부가세액) |
| taxAmount | Long | 부가세액 |
| currency | String | 통화<br>lang에 따라서 해당하는 언어로 반환됨 |
| orgList | List&lt;GetPartnerUserOrgUsages&gt; | 조직별 사용량 목록 |
| usageSummaryList | List&lt;UsageSummary&gt; | 사용량 요약 목록 |
| extraSummaryList | List&lt;ProjectExtra&gt; | 프로젝트 할증 요약 목록 |

**GetPartnerUserOrgUsages**

| 이름 | 타입 | 설명 |
| --- | --- | --- |
| orgName | String | 조직 이름 |
| charge | Long | 조직별 사용 금액 |

**UsageSummary**

| 이름 | 타입 | 설명 |
| --- | --- | --- |
| categoryMain | String | 메인 카테고리 |
| categorySub | String | 서브 카테고리 |
| counterName | String | 카운터 이름 |
| displayName | String | 과금 단위 노출 이름(locale별) |
| displayOrder | Integer | 표시순서 |
| price | Long | 이용 금액(파트너용이므로 약정금액은 제공하지 않음) |
| productUiId | String | 홈페이지 서비스 UI ID |
| usage | BigDecimal | 사용량 |

**ProjectExtra**

| 이름 | 타입 | 설명 |
| --- | --- | --- |
| description | String | 할증 설명 |
| extraPrice | Long | 프로젝트 할증금액 |


## 파트너 사용자의 조직 목록 조회

파트너 사용자의 조직 목록을 조회합니다.

!!! tip "파트너 계약 검증"
    해당 파트너와 파트너 사용자가 지정된 월에 파트너 계약을 맺은 상태였는지 확인합니다.

### 필요 권한
`Partner.Organization.List`

### 요청

```
GET /v1/billing/partners/{partnerId}/payments/{month}/organizations
```

### 요청 파라미터

| 이름 | 구분 | 타입 | 필수 | 설명 |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | 파트너 ID |
| month | Path | String | Y | 이용월(yyyy-MM 형식) |
| partnerUserUuid | Query | String | Y | 파트너 사용자 UUID |

### 요청 본문

이 API는 요청 본문을 요구하지 않습니다.

### 응답

<details>
  <summary><strong>응답 예시</strong></summary>

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

| 이름 | 타입 | 설명 |
| --- | --- | --- |
| organizations | List&lt;OrganizationProtocol&gt; | 조직 목록 |

**OrganizationProtocol**

| 이름 | 타입 | 설명 |
| --- | --- | --- |
| orgId | String | 조직 ID |
| orgName | String | 조직 이름 |
| orgStatusCode | String | 조직 상태(STABLE: 정상 상태, CLOSED: 삭제된 상태) |
| orgCreationType | String | 조직 생성 타입(USER: 고객이 생성한 조직, SYSTEM: 시스템에서 만든 조직) |
| cloudType | String | 클라우드 타입 |


## 파트너 사용자의 조직별 청구 금액 조회

특정 조직의 상세한 이용 금액, 할인 및 할증 금액을 조회합니다.

!!! tip "파트너 계약 검증"
    해당 파트너와 파트너 사용자가 지정된 월에 파트너 계약을 맺은 상태였는지, 그리고 해당 조직의 owner가 해당 달에 파트너 사용자였는지 확인합니다.

### 필요 권한
`Partner.Organization.Usage.Get`

### 요청

```
GET /v1/billing/partners/{partnerId}/payments/{month}/organizations/{orgId}/usage
```

### 요청 파라미터

| 이름 | 구분 | 타입 | 필수 | 설명 |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | 파트너 ID |
| month | Path | String | Y | 이용월(yyyy-MM 형식) |
| orgId | Path | String | Y | 조직 ID |
| lang | Header | String | N | 언어 설정(기본값: ko_KR, 설정 가능한 값: ko_KR, ja_JP, en_US) |

### 요청 본문

이 API는 요청 본문을 요구하지 않습니다.

### 응답

<details>
  <summary><strong>응답 예시</strong></summary>

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

#### 기본 응답 구조

| 이름 | 타입 | 설명 |
| --- | --- | --- |
| org | Organization | 조직 정보 |

**Organization**

| 이름 | 타입 | 설명 |
| --- | --- | --- |
| orgId | String | 조직 ID |
| orgName | String | 조직 이름 |
| totalAmount | Long | 조직 최종 금액 |
| usagePrice | Long | 이용 금액 |
| contractUsagePrice | Long | 약정 할인/할증이 적용된 이용 금액 합계 |
| contractDiscountPrice | Long | 약정으로 할인된 금액 |
| contractExtraPrice | Long | 약정으로 할증된 금액 |
| totalCredit | Long | 크레딧 최종 금액 |
| country | String | 국가 코드 |
| creditUsages | List&lt;CreditUsageProtocol&gt; | 크레딧 사용 금액 |
| projectDiscount | PaymentStatementProjectAdjustment | 프로젝트별 할인 상세 내역 목록 |
| projectExtra | PaymentStatementProjectAdjustment | 프로젝트별 할증 상세 내역 목록 |
| projects | List&lt;Project&gt; | 프로젝트 목록 |

**CreditUsageProtocol**

| 이름 | 타입 | 설명 |
| --- | --- | --- |
| balanceTypeCode | String | 캠페인 유형 |
| balanceTypeName | String | 캠페인 유형 이름 |
| i18nBalanceTypeNameMap | Map&lt;String, String&gt; | 캠페인 유형 이름 다국어 코드 |
| usageAmount | Long | 크레딧 사용 금액 |

**PaymentStatementProjectAdjustment**

| 이름 | 타입 | 설명 |
| --- | --- | --- |
| totalAdjustment | Long | 할인/할증 금액 합계 |
| details | List&lt;PaymentStatementProjectAdjustmentDetail&gt; | 상세 내역 |

**PaymentStatementProjectAdjustmentDetail**

| 이름 | 타입 | 설명 |
| --- | --- | --- |
| projectId | String | 프로젝트 ID |
| projectName | String | 프로젝트 이름 |
| adjustment | Long | 할인/할증 금액 |
| adjustmentTypeCode | String | 할인/할증 타입<br>- CONTRACT_EXTRA: 약정 할증<br>- CONTRACT_PENALTY: 약정 위약금<br>- CONTRACT_DISCOUNT: 약정 할인<br>- CONTRACT_PAYBACK: 파트너 페이백<br>- STATIC_EXTRA: 고정 금액 할증<br>- PERCENT_DISCOUNT: 퍼센트 할인<br>- COUPON: 쿠폰<br>- STATIC_DISCOUNT: 고정 금액 할인<br>- CUTOFF: 500원 미만 절사 |
| description | String | 할인/할증 내역 |

**Project**

| 이름 | 타입 | 설명 |
| --- | --- | --- |
| projectId | String | 프로젝트 ID |
| projectName | String | 프로젝트 이름 |
| totalAmount | Long | 프로젝트 최종 금액 |
| usagePrice | Long | 프로젝트 이용 금액 합계 |
| contractUsagePrice | Long | 약정 할인/할증을 적용한 이용 금액 합계 |


## 파트너 사용자의 프로젝트 목록 조회

파트너 사용자의 프로젝트 목록을 조회합니다.

!!! tip "파트너 계약 검증"
    해당 파트너와 파트너 사용자가 지정된 월에 파트너 계약을 맺은 상태였는지 확인합니다.

### 필요 권한
`Partner.Project.List`

### 요청

```
GET /v1/billing/partners/{partnerId}/payments/{month}/projects
```

### 요청 파라미터

| 이름 | 구분 | 타입 | 필수 | 설명 |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | 파트너 ID |
| month | Path | String | Y | 이용월(yyyy-MM 형식) |
| partnerUserUuid | Query | String | Y | 파트너 사용자 UUID |

### 요청 본문

이 API는 요청 본문을 요구하지 않습니다.

### 응답

<details>
  <summary><strong>응답 예시</strong></summary>

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

| 이름 | 타입 | 설명 |
| --- | --- | --- |
| projects | List&lt;ProjectProtocol&gt; | 프로젝트 목록 |

**ProjectProtocol**

| 이름 | 타입 | 설명 |
| --- | --- | --- |
| orgId | String | 조직 ID |
| orgName | String | 조직 이름 |
| orgCreationType | String | 조직 생성 타입<br><br>- USER: 고객이 생성한 조직<br>- SYSTEM: 시스템에서 만든 조직(주로 회원형 마켓플레이스에 사용) |
| orgStatusCode | String | 조직 상태<br><br>- STABLE: 정상 상태<br>- CLOSED: 삭제된 상태 |
| projectId | String | 프로젝트 ID |
| projectName | String | 프로젝트 이름 |
| projectCreationType | String | 프로젝트 생성 타입<br><br>- USER: 고객이 생성한 프로젝트<br>- SYSTEM: 시스템에서 만든 프로젝트(주로 조직 서비스, 회원형 마켓플레이스에서 사용) |
| projectStatusCode | String | 프로젝트 상태<br><br>- STABLE: 정상 상태<br>- CLOSED: 삭제된 상태 |


## 파트너 사용자의 프로젝트 상세 사용량 조회

특정 프로젝트의 상세 사용량을 조회합니다.

!!! danger "주의"
    사용량 조회 시 페이징을 적절히 사용하여 성능을 최적화하세요.

!!! tip "파트너 계약 검증"
    해당 파트너와 파트너 사용자가 지정된 월에 파트너 계약을 맺은 상태였는지, 그리고 해당 프로젝트가 속한 조직의 owner가 해당 달에 파트너 사용자였는지 확인합니다.

### 필요 권한
`Partner.Project.Usage.Get`

### 요청

```
GET /v1/billing/partners/{partnerId}/payments/{month}/projects/{projectId}/usage
```

### 요청 파라미터

| 이름 | 구분 | 타입 | 필수 | 설명 |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | 파트너 ID |
| month | Path | String | Y | 이용월(yyyy-MM 형식) |
| projectId | Path | String | Y | 프로젝트 ID |
| lang | Header | String | N | 언어 설정(기본값: ko_KR, 설정 가능한 값: ko_KR, ja_JP, en_US) |
| usageSchemaTypeCode | Query | String | N | 사용량 포함여부<br>사용량 조회방식을 기존방식으로 할지, 신규 그룹핑된 방식으로 할지 결정<br>(기본값: NO_GROUP)<br><br>- NO_GROUP: 사용량이 그룹핑되지 않고 그대로 노출되는 방식 <br>- GROUP_BY_PARENT_RESOURCE: 부모 리소스 별로 그룹핑은 되지만 구체적인 사용량은 제공하지 않는 방식. 반환되는 totalItems를 통해 부모 리소스가 몇개 존재하는지 확인 가능<br>- GROUP_BY_PARENT_RESOURCE_INCLUDE_USAGES: 부모 리소스 별로 그룹핑 후 어떤 부모 리소스로 그룹핑 되었는지와 그 세부 사용량까지 제공되는 방식 |
| categoryMain | Query | String | N | 메인 카테고리<br>usageSchemaTypeCode가 NO_GROUP인 경우엔 사용 불가능 |
| regionTypeCode | Query | String | N | 리전 타입 코드(최대 20자)<br>usageSchemaTypeCode가 NO_GROUP인 경우엔 사용 불가능 |
| page | Query | Integer | N | 선택한 페이지(기본값: 1, 최소: 1)<br>usageSchemaTypeCode가 NO_GROUP인 경우엔 사용 불가능 |
| limit | Query | Integer | N | 페이지에 노출될 항목 개수, 미기입 시 전체 조회(기본값: 0, 최소:0)<br>usageSchemaTypeCode가 NO_GROUP인 경우엔 사용 불가능 |

### 요청 본문

이 API는 요청 본문을 요구하지 않습니다.

### 응답

<details>
  <summary><strong>응답 예시</strong></summary>

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

#### 기본 응답 구조

| 이름 | 타입 | 설명 |
| --- | --- | --- |
| project | Project | 프로젝트 정보 |

**Project**

| 이름 | 타입 | 설명 |
| --- | --- | --- |
| projectId | String | 프로젝트 ID |
| projectName | String | 프로젝트 이름 |
| totalAmount | Long | 프로젝트 최종 금액 |
| usagePrice | Long | 이용 금액 |
| contractUsagePrice | Long | 약정 할인/할증이 적용된 이용 금액 합계 |
| contractDiscountPrice | Long | 약정으로 할인된 금액 |
| contractExtraPrice | Long | 약정으로 할증된 금액 |
| totalCredit | Long | 크레딧 최종 금액 |
| country | String | 국가 코드 |
| creditUsages | List&lt;CreditUsageProtocol&gt; | 크레딧 사용 금액 |
| projectDiscount | PaymentStatementProjectAdjustment | 프로젝트별 할인 상세 내역 |
| projectExtra | PaymentStatementProjectAdjustment | 프로젝트별 할증 상세 내역 |
| usageGroups | List&lt;UsageGroup&gt; | 사용량 그룹 목록 |

**CreditUsageProtocol**

| 이름 | 타입 | 설명 |
| --- | --- | --- |
| balanceTypeCode | String | 캠페인 유형(돈통 유형) |
| balanceTypeName | String | 캠페인 유형 이름(돈통 유형 이름) |
| i18nBalanceTypeNameMap | Map&lt;String, String&gt; | 캠페인 유형 이름 다국어 코드 |
| usageAmount | Long | 크레딧 사용 금액 |

**PaymentStatementProjectAdjustment**

| 이름 | 타입 | 설명 |
| --- | --- | --- |
| totalAdjustment | Long | 할인/할증 금액 합계 |
| details | List&lt;PaymentStatementProjectAdjustmentDetail&gt; | 상세 내역 |

**PaymentStatementProjectAdjustmentDetail**

| 이름 | 타입 | 설명 |
| --- | --- | --- |
| projectId | String | 프로젝트 ID |
| projectName | String | 프로젝트 이름 |
| adjustment | Long | 할인/할증 금액 |
| adjustmentTypeCode | String | 할인/할증 타입<br>- CONTRACT_EXTRA: 약정 할증<br>- CONTRACT_PENALTY: 약정 위약금<br>- CONTRACT_DISCOUNT: 약정 할인<br>- CONTRACT_PAYBACK: 파트너 페이백<br>- STATIC_EXTRA: 고정 금액 할증<br>- PERCENT_DISCOUNT: 퍼센트 할인<br>- COUPON: 쿠폰<br>- STATIC_DISCOUNT: 고정 금액 할인<br>- CUTOFF: 500원 미만 절사 |
| description | String | 할인/할증 내역 |

**UsageGroup**

| 이름 | 타입 | 설명 |
| --- | --- | --- |
| categoryMain | String | 메인 카테고리 |
| stationId | String | 스테이션 ID |
| stationName | String | 스테이션 이름 |
| regionTypeCode | String | 리전 |
| needType | Boolean | 구분 컬럼 노출 여부 |
| totalItems | Integer | UsageGroup별 Usage 총 개수 |
| totalPrice | Long | 약정 할인 적용된 이용 금액 합계 |
| usagePrice | Long | 이용 금액 합계 |
| usageResourceGroups | List&lt;UsageGroup.UsageResourceGroup&gt; | 그룹핑된 사용량 목록 |
| usages | List&lt;Usage&gt; | 상세 사용량 목록 |

**UsageGroup.UsageResourceGroup**

| 이름 | 타입 | 설명 |
| --- | --- | --- |
| parentResourceId | String | 구분을 위한 parent resource ID |
| parentResourceName | String | 구분을 위한 parent resource Name |
| usages | List&lt;Usage&gt; | 상세 사용량 목록 |

**Usage**

| 이름 | 타입 | 설명 |
| --- | --- | --- |
| categoryMain | String | 메인 카테고리 |
| categorySub | String | 서브 카테고리 |
| contractId | String | 약정 ID |
| contractPrice | Long | 약정으로 계산된 이용 금액 |
| contractUnitPrice | BigDecimal | 약정 단가 |
| counterName | String | 카운터 이름 |
| displayNameEn | String | 과금 단위 노출 이름(en) |
| displayNameJa | String | 과금 단위 노출 이름(ja) |
| displayNameKo | String | 과금 단위 노출 이름(ko) |
| displayNameZh | String | 과금 단위 노출 이름(zh) |
| displayOrder | Long | 표시순서 |
| parentResourceId | String | 부모 리소스 ID |
| parentResourceName | String | 부모 리소스 이름 |
| price | Long | 이용 금액 |
| productUiId | String | 홈페이지 서비스 Ui Id |
| projectId | String | 프로젝트 ID |
| projectName | String | 프로젝트 이름 |
| rangeFrom | BigDecimal | 적용 시작 범위 |
| regionTypeCode | String | 리전 |
| resourceId | String | 리소스 ID |
| resourceName | String | 리소스 이름 |
| seq | Long | seq |
| stationId | String | 스테이션 ID |
| stationName | String | 스테이션 이름 |
| unit | Long | 과금 단위 |
| unitName | String | 단위명 |
| unitPrice | BigDecimal | 단위당 가격 |
| usage | BigDecimal | 사용량 |
| useFixPrice | Boolean | 고정 금액 여부 |

**Usage**

| 이름 | 타입 | 설명 |
| --- | --- | --- |
| counterName | String | 카운터 이름 |
| counterType | String | 카운터 타입 |
| productId | String | 서비스 ID |
| projectId | String | 프로젝트 ID |
| resourceId | String | 리소스 ID |
| resourceName | String | 리소스 이름 |
| parentResourceId | String | 부모 리소스 ID |
| usage | BigDecimal | 사용량 |
| usedTime | String | 사용 시각 |


## 파트너의 청구서 조회

파트너의 전체 청구서를 조회합니다.

!!! tip "파트너 계약 검증"
    해당 파트너가 지정된 월에 유효한 파트너 계약 상태였는지 확인합니다.

### 필요 권한
`Partner.Statement.Get`

### 요청

```
GET /v1/billing/partners/{partnerId}/payments/{month}/statements
```

### 요청 파라미터

| 이름 | 구분 | 타입 | 필수 | 설명 |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | 파트너 ID |
| month | Path | String | Y | 이용월(yyyy-MM 형식) |
| lang | Header | String | N | 언어 설정(기본값: ko_KR, 설정 가능한 값: ko_KR, ja_JP, en_US) |

### 요청 본문

이 API는 요청 본문을 요구하지 않습니다.

### 응답

<details>
  <summary><strong>응답 예시</strong></summary>

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

#### 기본 응답 구조

| 이름 | 타입 | 설명 |
| --- | --- | --- |
| paymentStatements | List&lt;PaymentStatement&gt; | 청구서 목록 |

**PaymentStatement**

| 이름 | 타입 | 설명 |
| --- | --- | --- |
| uuid | String | 회원 UUID |
| autoPaymentTypeCode | String | 결제 수단 타입<br><br>- PAYCO_CREDIT_CARD: 페이코 신용카드<br>- CREDIT_CARD: 신용카드<br>- INTER_CREDIT_CARD: 해외 신용카드<br>- UNION_PAY: 유니온페이<br>- JAPAN_BILLING: 일본 빌링<br>- ACCOUNT_TRANSFER: 계좌 이체<br>- CREDIT_ALL: 일반 크레딧<br>- CREDIT_LIMIT: 이벤트 크레딧<br>- ESM: 내부 비용<br>- ONETIME_PAYMENT: 일회성 결제<br>- TAX_BILL: 세금 계산서 발행<br>- CONTRACT_BILL: 세금 계산서 발행(별도 계약으로 청구 금액 조정 발생)<br>- NONE: 없음 |
| isAutoPayment | Boolean | 자동 결제 수단 여부 |
| paymentInfo | String | 결제 수단 정보 |
| statements | List&lt;PaymentStatement&gt; | 빌링 그룹별 결제 내역 목록 |

**PaymentStatement**

| 이름 | 타입 | 설명 |
| --- | --- | --- |
| paymentGroupId | String | 결제 그룹 ID |
| month | String | 이용월 |
| charge | Long | 사용 금액 |
| supplyAmount | Long | 공급가액 |
| taxAmount | Long | 부가세액 |
| totalAmount | Long | 최종금액 |
| totalCredit | Long | 전체 크레딧 사용 금액 |
| totalDiscount | Long | 할인금액 |
| totalExtra | Long | 할증금액 |
| freeCredit | Long | 무료 크레딧 사용 금액 |
| freeCreditAll | Long | 무료전체형 크레딧 사용 금액 |
| freeCreditLimit | Long | 무료제한형 크레딧 사용 금액 |
| paidCredit | Long | 유료 크레딧 사용 금액 |
| paidCreditAll | Long | 유료전체형 크레딧 사용 금액 |
| paidCreditLimit | Long | 유료제한형 크레딧 사용 금액 |
| paymentStatusCode | String | 결제 상태<br><br>- REGISTERED: 등록<br>- READY: 결제 대기<br>- PAID: 결제 완료<br>- ERROR: 운영자 확인 필요 상태 |
| country | String | 국가 코드 |
| cutoff | Long | cutoff |
| lateFee | Long | 연체금액 |
| realSupplyAmount | Long | 실 공급가액 |
| realTaxAmount | Long | 실 결제된 부가세 |
| receiptStatusCode | String | 매출 전표 상태 코드<br><br>- NONE: 아직 회계팀으로 매출 보고가 되지 않아, 매출 전표를 볼 수 없는 상태<br>- EXIST: 최종 금액 조정이 끝난 후, 회계팀으로 매출 보고가 되어, 매출 전표를 볼 수 있는 상태 |
| refundAccountRegisterStatusCode | String | 환불 계좌 등록 여부 상태<br><br>- ALLOW: 환불 계좌 등록 Open 상태<br>- DENY: Default, 환불 계좌 등록 Close 상태 |
| details | List&lt;PaymentStatementDetail&gt; | 빌링 그룹별 상세 내역 목록 |

**PaymentStatementDetail**

| 이름 | 타입 | 설명 |
| --- | --- | --- |
| billingGroupId | String | 빌링 그룹 ID |
| billingGroupName | String | 빌링 그룹 이름 |
| charge | Long | 이용 금액 |
| contractDiscount | Long | 약정 할인 금액 |
| contractExtra | Long | 약정 할증 금액 |
| totalAmount | Long | 최종 금액 |
| totalCredit | Long | 크레딧 총 사용 금액 |
| totalDiscount | Long | 할인 금액 |
| totalExtra | Long | 할증 금액 |
| creditUsages | List&lt;CreditUsageProtocol&gt; | 크레딧 사용 금액 |
| orgList | List&lt;Organization&gt; | 조직 목록 |
| usageGroups | List&lt;UsageGroup&gt; | 사용량 그룹 목록 |
| billingGroupDiscount | PaymentStatementBillingGroupAdjustment | 빌링 그룹 할인 상세 내역 |
| billingGroupExtra | PaymentStatementBillingGroupAdjustment | 빌링 그룹 할증 상세 내역 |
| projectDiscount | PaymentStatementProjectAdjustment | 프로젝트별 할인 상세 내역 |
| projectExtra | PaymentStatementProjectAdjustment | 프로젝트별 할증 상세 내역 |

**CreditUsageProtocol**

| 이름 | 타입 | 설명 |
| --- | --- | --- |
| balanceTypeCode | String | 캠페인 유형(돈통 유형) |
| balanceTypeName | String | 캠페인 유형 이름(돈통 유형 이름) |
| i18nBalanceTypeNameMap | Map&lt;String, String&gt; | 캠페인 유형 이름 다국어 코드 |
| usageAmount | Long | 크레딧 사용 금액 |

**Organization**

| 이름 | 타입 | 설명 |
| --- | --- | --- |
| orgId | String | 조직 ID |
| orgName | String | 조직 이름 |
| totalAmount | Long | 조직 최종 금액 |

**UsageGroup**

| 이름 | 타입 | 설명 |
| --- | --- | --- |
| categoryMain | String | 메인 카테고리 |
| needType | Boolean | 구분 컬럼 노출 여부 |
| regionTypeCode | String | 리전 |
| stationId | String | 스테이션 ID |
| stationName | String | 스테이션 이름 |
| totalItems | Integer | UsageGroup별 Usage 총 개수 |
| totalPrice | Long | 약정 할인 적용된 이용 금액 합계 |
| usagePrice | Long | 이용 금액 합계 |
| usageResourceGroups | List&lt;UsageGroup.UsageResourceGroup&gt; | 그룹핑된 사용량 목록 |
| usages | List&lt;Usage&gt; | 상세 사용량 목록 |

**PaymentStatementBillingGroupAdjustment**

| 이름 | 타입 | 설명 |
| --- | --- | --- |
| totalAdjustment | Long | 할인/할증 금액 |
| details | List&lt;PaymentStatementAdjustment&gt; | 상세 내역 |

**PaymentStatementAdjustment**

| 이름 | 타입 | 설명 |
| --- | --- | --- |
| adjustment | Long | 할인/할증 금액 |
| adjustmentTypeCode | String | 할인/할증 타입<br><br>- CONTRACT_EXTRA: 약정 할증<br>- CONTRACT_PENALTY: 약정 위약금<br>- CONTRACT_DISCOUNT: 약정 할인<br>- CONTRACT_PAYBACK: 파트너 페이백<br>- STATIC_EXTRA: 고정 금액 할증<br>- PERCENT_DISCOUNT: 퍼센트 할인<br>- COUPON: 쿠폰<br>- STATIC_DISCOUNT: 고정 금액 할인<br>- CUTOFF: 500원 미만 절사 |
| description | String | 할인/할증 내역 |

**PaymentStatementProjectAdjustment**

| 이름 | 타입 | 설명 |
| --- | --- | --- |
| totalAdjustment | Long | 할인/할증 금액 합계 |
| details | List&lt;PaymentStatementProjectAdjustmentDetail&gt; | 상세 내역 |

**PaymentStatementProjectAdjustmentDetail**

| 이름 | 타입 | 설명 |
| --- | --- | --- |
| projectId | String | 프로젝트 ID |
| projectName | String | 프로젝트 이름 |
| adjustment | Long | 할인/할증 금액 |
| adjustmentTypeCode | String | 할인/할증 타입<br><br>- CONTRACT_EXTRA: 약정 할증<br>- CONTRACT_PENALTY: 약정 위약금<br>- CONTRACT_DISCOUNT: 약정 할인<br>- CONTRACT_PAYBACK: 파트너 페이백<br>- STATIC_EXTRA: 고정 금액 할증<br>- PERCENT_DISCOUNT: 퍼센트 할인<br>- COUPON: 쿠폰<br>- STATIC_DISCOUNT: 고정 금액 할인<br>- CUTOFF: 500원 미만 절사 |
| description | String | 할인/할증 내역 |


## 솔루션 파트너의 자기 서비스 미터링 조회

솔루션 파트너가 자신의 서비스에 대한 미터링 정보를 조회합니다.

!!! tip "솔루션 파트너 검증"
    솔루션 파트너이거나, 솔루션 파트너에게 권한을 부여 받은 사용자만 호출 가능합니다.

### 필요 권한
`Partner.Meter.List`

### 요청

```
GET /v1/billing/partners/{partnerId}/products/{productId}/meters
```

### 요청 파라미터

| 이름 | 구분 | 타입 | 필수 | 설명 |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | 파트너 ID |
| productId | Path | String | Y | 서비스 ID |
| from | Query | String | Y | 조회 시작 시간(ISO 8601 형식, 포함) |
| to | Query | String | Y | 조회 종료 시간(ISO 8601 형식, 미포함) |
| counterName | Query | String | Y | 카운터 이름 |
| appKey | Query | String | N | 앱키 |
| meterTimeTypeCode | Query | String | N | 미터 시간 타입 코드<br><br>- INSERT_TIME: 미터링 삽입 시간 기준<br>- USED_TIME: 미터링 발생 시간 기준 |
| page | Query | Integer | Y | 선택한 페이지(최소: 1) |
| limit | Query | Integer | Y | 페이지에 노출될 항목 개수(최소: 1, 최대: 2000) |

### 요청 본문

이 API는 요청 본문을 요구하지 않습니다.

### 응답

<details>
  <summary><strong>응답 예시</strong></summary>

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

| 이름 | 타입 | 설명 |
| --- | --- | --- |
| meterList | List&lt;MeterProtocol&gt; | 미터링 목록 |
| totalItems | Integer | 전체 항목 수 |

**MeterProtocol**

| 이름 | 타입 | 설명 |
| --- | --- | --- |
| appKey | String | 서비스 앱키 |
| counterName | String | 카운터 이름 |
| counterType | String | 카운터 타입<br><br>- DELTA: 증분 값<br>- GAUGE: 현재 값<br>- HOURLY_LATEST: 시간별 최신 값<br>- DAILY_MAX: 일별 최댓값<br>- MONTHLY_MAX: 월별 최댓값<br>- STATUS: 상태 값 |
| counterUnit | String | 카운터 단위 |
| counterValue | String | 사용 현황(counterType이 STATUS인 경우에만 사용) |
| counterVolume | BigDecimal | 카운터 볼륨 |
| gmid | String | 글로벌 미터링 ID |
| insertTime | String | 미터링 삽입 시각 |
| orgId | String | 조직 ID |
| parentResourceId | String | 부모 리소스 ID |
| productId | String | 서비스 ID |
| projectId | String | 프로젝트 ID |
| resourceId | String | 리소스 ID |
| resourceName | String | 리소스 이름 |
| source | String | 미터링이 발생한 IP 또는 호스트 이름 |
| stationId | String | 스테이션 ID |
| timestamp | String | 미터링 발생 시각 |


## 솔루션 파트너의 미터링 삭제

솔루션 파트너가 자신의 서비스에 대한 미터링을 삭제합니다.<br>
이미 청구서가 생성된 이후의 미터링은 삭제를 해도 반영이 되지 않음을 유의해야 하며, 솔루션 파트너가 자신의 서비스 외에 다른 서비스들의 미터링을 삭제하는 것은 불가능합니다.<br>
삭제는 오래 걸릴 수 있는 작업이므로 비동기로 동작하며, 삭제 API 호출 이후 반환된 asyncJobId로 상태를 조회하여 완료 여부를 알 수 있습니다.

!!! tip "솔루션 파트너 검증"
    솔루션 파트너이거나, 솔루션 파트너에게 권한을 부여 받은 사용자만 호출 가능합니다.

### 필요 권한
`Partner.Meter.Delete`

### 요청

```
DELETE /v1/billing/partners/{partnerId}/products/{productId}/meters
```

### 요청 파라미터

| 이름 | 구분 | 타입 | 필수 | 설명 |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | 파트너 ID |
| productId | Path | String | Y | 서비스 ID |


### 요청 본문

<details>
  <summary><strong>예시 코드</strong></summary>

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

| 이름 | 타입 | 필수 | 설명 |
| --- | --- | --- | --- |
| from | String | Y | 조회 시작 시간(ISO 8601 형식, 포함) |
| to | String | Y | 조회 종료 시간(ISO 8601 형식, 미포함) |
| appKey | String | N | 상품 앱키<br>앱키, 혹은 카운터 이름 중 하나는 반드시 있어야 함 |
| counterNames | List&lt;String&gt; | N | 삭제할 카운터 이름 목록<br>앱키, 혹은 카운터 이름 중 하나는 반드시 있어야 함 |


### 응답

<details>
  <summary><strong>응답 예시</strong></summary>

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

| 이름 | 타입 | 설명 |
| --- | --- | --- |
| asyncJobId | String | 실행한 비동기 작업의 ID |


## 솔루션 파트너의 미터링 삭제 확인

미터링 삭제 후 삭제가 완료되었는지 확인합니다.<br>
삭제 API 호출 후 5초 이후 호출하는 것이 안전하며, 바로 호출하면 실패할 수 있으니 주의가 필요합니다.<br>
이후 5초 주기로 호출하여 상태를 확인하는 것을 권장합니다.

!!! tip "솔루션 파트너 검증"
    솔루션 파트너이거나, 솔루션 파트너에게 권한을 부여 받은 사용자만 호출 가능합니다.

!!! danger "미터링 삭제 확인 시 주의 사항"
    한번 정상 삭제를 확인한 후에는 삭제 job이 사라지므로 한번만 호출 가능하며, 두 번째 호출부터는 16500 오류가 반환됩니다.

### 필요 권한
`Partner.Meter.Delete`

### 요청

```
GET /v1/billing/partners/{partnerId}/meters/jobs/{async-job-id}
```

### 요청 파라미터

| 이름 | 구분 | 타입 | 필수 | 설명 |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | 파트너 ID |
| asyncJobId | Path | String | Y | 실행한 비동기 작업의 ID |


### 요청 본문

이 API는 요청 본문을 요구하지 않습니다.

### 응답

<details>
  <summary><strong>응답 예시</strong></summary>

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

| 이름 | 타입 | 설명 |
| --- | --- | --- |
| statusCode | String | 삭제 상태(IN_PROGRESS: 삭제 진행 중, ERROR: 삭제 중 오류 발생, SUCCESS: 삭제 성공) |

## 파트너 사용자의 조직 생성

파트너가 파트너 사용자의 조직을 생성합니다.

!!! tip "파트너 계약 검증"
    API를 호출한 월에 해당 파트너와 파트너 사용자가 파트너 계약 관계였는지 확인합니다.

### 필요 권한
`Partner.Organization.Create`

### 요청

```
POST /v1/partners/{partnerId}/partner-users/{partnerUserUuid}/organizations
```

### 요청 파라미터

| 이름 | 구분 | 타입 | 필수 | 설명 |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | 파트너 ID |
| partnerUserUuid | Path | String | Y | 파트너 사용자 UUID |

### 요청 본문

| 이름 | 타입 | 필수 | 설명 |
| --- | --- | --- | --- |
| orgName | String | Y | 생성할 조직 이름(최대 120자) |

### 응답

<details>
  <summary><strong>응답 예시</strong></summary>

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

| 이름 | 타입 | 설명 |
| --- | --- | --- |
| orgId | String | 생성된 조직 ID |
| orgName | String | 조직 이름 |
| ownerId | String | 조직 Owner UUID |
| regDateTime | String | 등록일시(ISO 8601 형식) |


## 파트너 사용자의 조직 삭제

파트너가 파트너 사용자의 조직을 삭제합니다.

!!! tip "파트너 계약 검증"
    API를 호출한 월에 해당 파트너와 파트너 사용자가 파트너 계약 관계였는지, 그리고 삭제 대상이 파트너 사용자의 조직인지 확인합니다.

### 필요 권한
`Partner.Organization.Delete`

### 요청

```
DELETE /v1/partners/{partnerId}/partner-users/{partnerUserUuid}/organizations/{orgId}
```

### 요청 파라미터

| 이름 | 구분 | 타입 | 필수 | 설명 |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | 파트너 ID |
| partnerUserUuid | Path | String | Y | 파트너 사용자 UUID |
| orgId | Path | String | Y | 삭제할 조직 ID |

### 요청 본문

이 API는 요청 본문을 요구하지 않습니다.

### 응답

<details>
  <summary><strong>응답 예시</strong></summary>

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


## 파트너 또는 파트너 사용자의 활성화된 조직/프로젝트 상품 미터링 조회

미터링 정보를 조회합니다.

### 필요 권한
`Partner.Meter.List`

### 요청

```
POST /v1/billing/partners/{partnerId}/meters/search
```

### 요청 파라미터

| 이름 | 구분 | 타입 | 필수 | 설명 |
| --- | --- | --- | --- | --- |
| partnerId | Path | String | Y | 파트너 ID |
| page | Query | Integer | N | 선택한 페이지(최소: 1) |
| limit | Query | Integer | N | 페이지에 노출될 항목 개수(최소: 1, 최대: 2000) |


### 요청 본문

<details>
  <summary><strong>예시 코드</strong></summary>

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

| 이름 | 타입 | 필수 | 설명 |
| --- | --- | --- | --- |
| from | String | Y | 조회 시작 시간(ISO 8601 형식, 포함) |
| to | String | Y | 조회 종료 시간(ISO 8601 형식, 미포함) |
| appKeys | List&lt;String&gt; | N | 앱키 목록 |
| counterNames | List&lt;String&gt; | N | 카운터 이름 목록 |
| meterTimeTypeCode | String | N | 미터 시간 타입 코드<br>from, to에 대해서 사용 시간으로 검색을 할지, 아니면 요청이 인입된 시간으로 검색을 할지 결정<br>(USED_TIME: 사용 시간(기본값), INSERT_TIME: 인입된 시간) |


### 응답

<details>
  <summary><strong>응답 예시</strong></summary>

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

| 이름 | 타입 | 설명 |
| --- | --- | --- |
| meterList | List&lt;MeterProtocol&gt; | 미터링 목록 |
| totalItems | Integer | 총 개수 |

**MeterProtocol**

| 이름 | 타입 | 설명 |
| --- | --- | --- |
| appKey | String | 앱키 |
| counterName | String | 카운터 이름 |
| counterType | String | 카운터 타입<br><br>- DELTA: 증분 값<br>- GAUGE: 현재 값<br>- HOURLY_LATEST: 시간별 최신 값<br>- DAILY_MAX: 일별 최댓값<br>- MONTHLY_MAX: 월별 최댓값<br>- STATUS: 상태 값 |
| counterUnit | String | 사용량 단위(KB, HOUR 등) |
| counterValue | String | 사용 현황<br>카운터 타입이 STATUS인 경우에만 사용 |
| counterVolume | BigDecimal | 사용량 |
| insertTime | String | 서비스에서 빌링 시스템으로 보낸 시간 |
| orgId | String | 조직 ID |
| parentResourceId | String | 부모 리소스 ID |
| productId | String | 서비스 ID |
| projectId | String | 프로젝트 ID |
| resourceId | String | 리소스 ID |
| resourceName | String | 리소스 이름 |
| stationId | String | 스테이션 ID |
| timestamp | String | 사용한 시간 |


## 오류 코드

| resultCode | 설명 | 조치 |
| --- | --- | --- |
| -14 | 허용되지 않은 국가의 IP에서 요청 | 허용된 국가에서 요청하거나, 국가별 IP 제한 정책을 확인 |
| -8 | 요청 IP가 허용되지 않음 또는 조직 IP ACL 정책에 의해 IP 검증 실패 | 조직 IP ACL에 해당 IP가 등록되었는지 확인하고, 허용된 IP 대역에서 요청 |
| -7 | 권한이 허용되지 않음 | 해당 작업에 대한 권한이 허용되지 않으므로, 시스템 관리자에게 문의 |
| -6 | 호출한 API에 대해 호출자의 인가가 실패했을 때 발생하는 오류 또는 파트너 권한 검증 실패  | 호출자가 API 호출 권한이 있는지 확인하고, 필요하다면 시스템 관리자에게 문의하여 호출 권한을 요청. 호출 계정 권한과 요청 스코프 파트너 ID 점검 |
| -5 | 권한 거부 - 소유자가 아님 또는 삭제하려는 조직의 실제 오너가 요청한 파트너 사용자와 다름 | 요청자가 해당 조직의 소유자인지 확인하고, 대상 조직이 해당 파트너 사용자 소유인지 확인 |
| -4 | 권한 거부 - 멤버가 아님 | 요청자가 해당 파트너의 멤버인지 확인하고, 적절한 권한을 부여 받은 후 재시도 |
| -2 | 파라미터가 잘못될 경우 발생하는 오류 | 요청 파라미터의 형식과 값을 확인하여 올바른 값으로 재시도 |
| 404 | 없는 API 호출 시 발생 | 호출하는 API의 HTTP 메서드, URI를 확인 |
| 500 | 비정상 시스템 오류 | 시스템 관리자에게 문의 |
| 501 | 잘못된 날짜 형식 | 날짜 파라미터를 올바른 형식으로 제공 |
| 502 | 잘못된 파라미터 | 요청 파라미터의 값과 형식 확인 |
| 503 | 서비스 사용 불가 또는 조회 기간 규칙 위반 | 서비스가 일시적으로 사용 불가능한 상태이므로 잠시 후 재시도하거나, 조회 기간 규칙을 준수하여 요청 |
| 504 | JSON 파싱 실패 | 요청 본문의 JSON 형식 확인 |
| 505 | 검증 실패 | 요청의 필드 유효성 검증 확인 |
| 1000 | 파라미터가 잘못될 경우 발생하는 오류 | 요청 파라미터의 형식과 값을 확인하여 올바른 값으로 재시도 |
| 1200 | API 호출 실패 | 잠시 후 재시도하거나, 시스템 상태를 확인 |
| 10005 | 요청 파라미터가 적절하지 않을 때 발생하는 오류 | 요청 파라미터의 필수 값 및 설정 가능한 값 등을 확인 |
| 11010 | 사용량 조회 권한 부족 | 서비스/카운터/조직에 대한 권한 확인 및 부여 |
| 11012 | 조직 접근 권한 없음 | 사용자에게 해당 조직 접근 권한 부여 |
| 11013 | 멤버가 파트너 사용자가 아님 또는 지정한 파트너 ID와 파트너 사용자 UUID가 매칭되지 않음 | 해당 멤버가 지정된 기간에 파트너 사용자인지 확인하고, 파트너 관계를 재설정. 파트너 사용자가 해당 파트너에 승인·연결돼 있는지 확인 |
| 12000 | 프로젝트를 찾을 수 없음 | 요청한 프로젝트 ID가 존재하는지 확인하고, 올바른 프로젝트 ID로 재시도 |
| 12100 | 프로젝트 멤버가 존재하지 않을 때 발생하는 오류 | 존재하는 프로젝트 멤버 UUID 사용 |
| 16500 | 비동기 작업을 찾을 수 없음 | 잘못된 비동기 ID로 요청했는지 확인 |
| 17001 | 앱키를 찾을 수 없음 | 앱키가 정상 발급되었는지 확인 후 필요 시 재발급 |
| 17003 | 앱키와 프로젝트/서비스 연결 없음 | 앱키를 올바른 프로젝트/서비스와 연결 |
| 17501 | 조직을 찾을 수 없음 | 조직 ID 존재 여부 확인 |
| 18001 | 프로젝트를 찾을 수 없음 | 프로젝트 ID 존재 여부 확인 |
| 22001 | 파트너 기본 그룹 없음 | 파트너 기본 그룹 설정 확인 |
| 22002 | 파트너 결제 그룹 없음 | 파트너 결제 그룹 설정 확인 |
| 22003 | 파트너 조정값 범위 오류 | 파트너 조정값이 허용 범위 내인지 확인 |
| 22004 | 솔루션 파트너 서비스 아님 | 요청 서비스가 해당 솔루션 파트너 서비스인지 확인 |
| 22005 | 솔루션 파트너 아님 | 파트너가 솔루션 파트너 자격을 갖추었는지 확인 |
| 22007 | 해당 파트너에게 접근 권한이 없음 | 파트너가 해당 리소스에 접근할 권한이 없는 상태이며, 조회 대상인 리소스가 본인의 리소스거나 아니면 본인이 조회 가능한 대상의 리소스가 맞는지 확인 |
| 22008 | 해당 서비스의 앱키가 아님 | 잘못된 앱키로 요청했는지 확인 |
| 22009 | 해당 서비스의 카운터 이름이 아님 | 잘못된 카운터 이름으로 요청했는지 확인 |
| 22021 | 조직 생성 시, 조직 오너 계정에 설정된 조직 생성 개수 제한을 초과했을 경우 발생하는 오류 | 1) 사용하지 않은 조직을 삭제하여 생성 가능한 조직 개수 확보 <br>2) 시스템 관리자를 통해 조직 생성 최대 개수 조정 |
| 22023 | MSP 파트너 한도를 초과하여 조직 생성이 제한됨 | MSP 파트너 한도 조정 또는 조직 정리 |
| 23005 | 조직 ID에 해당하는 조직이 존재하지 않을 때 발생하는 오류 | 시스템 관리자에게 문의 |
| 24000 | API 연동 실패 | 시스템 관리자에게 문의 |
| 24001 | 앱키 유효성 검증 실패 | 앱키 유효성 확인 |
| 24002 | 멤버 정보 유효성 검증 실패 | 멤버 정보 확인 |
| 24005 | 프로젝트 멤버 없음 | 해당 멤버가 프로젝트에 속해있는지 확인 |
| 24007 | 프로젝트 없음 | 프로젝트 ID 확인 혹은 시스템 관리자에게 문의 |
| 25001 | 국가별 세율 정책 없음 | 시스템 관리자에게 문의 |
| 70013 | 이용 중인서비스가 존재할 때 발생하는 오류 | 이용 중인서비스 비활성화 |
| 70032 | 미납 제재로 조직 생성이 차단됨 | 미납 해소 및 제재 해제 요청 후 재시도 |
| 80400 | 잘못된 요청 | 요청 파라미터 형식 및 필수 값 확인 |
| 80401 | 인증 실패 | 인증 토큰 유효성 및 로그인 상태 확인 |
| 80500 | 서버 오류 | 서버 로그 확인 후 시스템 관리자에게 문의 |