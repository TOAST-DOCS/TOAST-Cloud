<!-- pre-align:aligned sig=244a740a7bef -->

# User Access Key 토큰

**NHN Cloud > Public API 사용 가이드 > API 인증 방식 > User Access Key 토큰**

User Access Key 토큰은 User Access Key를 기반으로 발급되는 Bearer 타입의 일시적 액세스 토큰입니다. Bearer 토큰은 토큰을 소유한 사용자라면 누구나 접근 권한을 부여 받는 보안 토큰의 한 종류로, 유효 기간을 설정할 수 있어 리소스를 안전하게 보호할 수 있습니다.
User Access Key 토큰은 역할 기반 접근 제어 방식(ABAC, attribute-Based Access Control)으로 동작하여 토큰을 사용할 경우 NHN Cloud 계정 또는 IAM 계정에 부여된 역할 및 권한이 적용됩니다. 따라서 호출 가능한 API가 해당 계정의 역할 및 권한 범위 내로 제한됩니다. 또한 역할 상세 조건을 설정하여 정밀한 접근 제어가 가능합니다.

User Access Key 하나로 용도에 따라 서로 다른 형식의 토큰을 발급받을 수 있습니다.

| 토큰 형식 | 발급 API | 사용처 | 유효 시간 | 필요한 User Access Key 형식 |
| --- | --- | --- | --- | --- |
| Opaque | `POST /oauth2/token/create` | NHN Cloud Public API 전반 | 60초~24시간(설정 가능) | Opaque |
| JWT | `POST /oauth2/token/create` | EasyQueue 메시지 전송/수신 | 60초~1시간(설정 가능) | JWT |
| Fernet | `POST /iaas-tokens/v3/auth/tokens` | OpenStack 기반 인프라 서비스(Compute, Block Storage, Network 등) | 12시간 고정 | Opaque |

User Access Key를 생성할 때 선택하는 형식(Opaque / JWT)은 OAuth 2.0 액세스 토큰의 형식입니다. IaaS 토큰은 이와 별개로, Opaque 형식 User Access Key로 OpenStack Keystone의 Fernet 토큰을 발급받습니다.

<a id="overview-of-user-access-key-token-issuance-and-public-api-calls"></a>
## User Access Key 토큰 발급 및 Public API 호출 개요 { #overview-of-user-access-key-token-issuance-and-public-api-calls }

User Access Key 토큰 발급 및 API 호출은 다음과 같은 흐름으로 동작합니다.

<a id="issue-new-tokens-and-making-api-calls"></a>
### 신규 토큰 발급 및 API 호출 { #issue-new-tokens-and-making-api-calls }

![img001.png](http://static.toastoven.net/toast/public_api/img01_KO.png)

<a id="reissue-and-api-calls-on-token-expiration"></a>
### 토큰 만료 시 재발급 및 API 호출 { #reissue-and-api-calls-on-token-expiration }

![img002.png](http://static.toastoven.net/toast/public_api/img02_KO.png)


발급한 토큰은 유효 기간 동안만 사용할 수 있으며(기본값: 24시간), 만료 후에는 새로 발급해야 합니다. 토큰이 유출되었거나 유출이 의심되는 경우 해당 토큰을 즉시 만료 처리하고 필요시 재발급해야 합니다.


!!! tip "알아두기"
    토큰의 유효 시간은 NHN Cloud 콘솔의 **API 보안 설정** 메뉴에서 변경할 수 있습니다.
    Opaque 토큰 유효 시간은 60초 ~ 86,400초(24시간) 내에서 설정할 수 있고, JWT 토큰 유효 시간은 60초 ~ 3,600초(1시간) 내에서 설정할 수 있습니다.
    유효 시간을 수정하기 전에 발급된 토큰의 유효 시간은 변경되지 않으며, 토큰 유효 시간 수정 후 신규로 발급하는 토큰부터 변경된 토큰 유효 시간이 적용됩니다.


<a id="prerequisites"></a>
## 사전 작업 { #prerequisites }

User Access Key 토큰을 발급하려면 먼저 User Access Key ID와 Secret Access Key를 먼저 발급해야 합니다. NHN Cloud 콘솔의 **API 보안 설정** 메뉴에서 User Access Key별 토큰 정보를 확인하고 관리할 수 있습니다.

1) NHN Cloud 콘솔에서 우측 상단의 계정에 마우스 포인터를 올리면 표시되는 드롭다운 메뉴에서 **API 보안 설정**을 클릭합니다.

2) **+ User Access Key 생성**을 클릭합니다.<br>
![C_userAccessKey_1_ko](http://static.toastoven.net/toast/public_api/C_userAccessKey_1_ko.png)
3) **User Access Key 생성** 모달 창에서 **토큰 타입**과 **토큰 유효 시간**을 설정한 뒤 **생성**을 클릭합니다.<br>
    - **Opaque 토큰(기본)**: **Opaque 타입 User Access Key ID와 Secret Access Key 생성**을 선택
    - **JWT 토큰**: **JWT 타입 User Access Key ID와 Secret Access Key 생성**을 선택(현재 EasyQueue 서비스만 지원)<br>
![C_userAccessKey_2_ko](http://static.toastoven.net/toast/public_api/C_userAccessKey_2_ko.png)

4) **User Access Key 발급 완료** 모달 창에서 **Secret Access Key**를 복사한 뒤 **확인**을 클릭합니다.<br>
![C_userAccessKey_3_ko](http://static.toastoven.net/toast/public_api/C_userAccessKey_3_ko.png)


!!! danger "주의"
    * 모달 창을 닫은 뒤에는 Secret Access Key를 다시 확인할 수 없습니다. Secret Access Key를 잊어버릴 경우 재생성해야 하므로 반드시 복사한 뒤 별도로 관리하세요.
    * User Access Key 또는 Secret Access Key 중 하나라도 유출되었거나 유출이 의심되는 경우 해당 키를 폐기하고 새로 발급 받아야 합니다.


<a id="authentication-server-domain"></a>
## 인증 서버 도메인 { #authentication-server-domain }
인증 서버의 도메인은 다음과 같습니다.

```
https://oauth.api.nhncloudservice.com/
```


<a id="request-user-access-key-token-issuance"></a>
## User Access Key 토큰 발급 요청하기 { #request-user-access-key-token-issuance }
> `POST /oauth2/token/create`

<a id="request-opaque-token-issuance"></a>
### Opaque 타입 토큰 발급 요청하기 { #request-opaque-token-issuance }
* 요청

| 구분 | 이름 | 타입 | 필수 | 값                                     | 설명                                                                   |
|---------------|------------- | ------------- | ------------- |-------------------------------------------|--------------------------| 
| Header        |  Content-Type | String | Yes | application/x-www-form-urlencoded         |                                                                        |
| Header        |  Authorization | String | Yes | Basic Base64(UserAccessKeyID:SecretAccessKey) | `UserAccessKeyID:SecretAccessKey` 를 Base64 인코딩한 결과를 `Basic ` 뒤에 붙여서 사용 | 
| Request Body |  grant_type | String | Yes | client_credentials                        | <ul><li>토큰 발급 grant_type은 client_credentials만 제공되고 있음</li><li>발급 요청 시 `grand_type=client_credentials`와 같이 사용</li></ul> |

* 응답

| 이름         | 타입        | 필수 | 설명                            |
|--------------|-------------| ------------- |----------------------------------------|
| access_token | String  | Yes | 발급된 Bearer 타입의 인증 토큰                   | 
| token_type   | String  | Yes | 토큰의 타입                                 |
| expires_in   | String  | Yes | 만료까지 남은 초 단위 시간을 의미하며 기본은 86,400초(하루)임 |

```json
{
    "access_token":"luzocEoQ3tyMvM6pLtoSTHSphgJSGhl5hVvgSstdVQ1X1bZnf9AEMGAcSERIi1Dq0bybSMv0raOcahZjYpZ2biaaoF3jTi9caF5M2TN9F98iZawbBJmN94CPF2Rpe0JI",
    "token_type":"Bearer",
    "expires_in":86400
}
```

<a id="request-jwt-token-issuance"></a>
### JWT 타입 토큰 발급 요청하기 { #request-jwt-token-issuance }

!!! tip "알아두기"
    현재 EasyQueue 서비스만 JWT 토큰을 사용할 수 있습니다.

* 요청

  | 구분 | 이름 | 타입 | 필수 | 값                                     | 설명                                                                   |
  |---------------|------------- | ------------- | ------------- |-------------------------------------------|--------------------------|
  | Header        |  Content-Type | String | Yes | application/x-www-form-urlencoded         |                                                                        |
  | Header        |  Authorization | String | Yes | Basic Base64(UserAccessKeyID:SecretAccessKey) | `UserAccessKeyID:SecretAccessKey`를 Base64 인코딩한 결과를 `Basic` 뒤에 붙여서 사용 |
  | Request Body |  grant_type | String | Yes | client_credentials                        | <ul><li>토큰 발급 grant_type은 client_credentials만 제공되고 있음</li><li>발급 요청 시 `grand_type=client_credentials`와 같이 사용</li></ul> |
  | Request Body |  scope | String | Yes | appKey:{appKey}                | <ul><li>서비스 활성화 후 발급 받은 앱키</li><li>발급 요청 시 `scope=appKey:{appKey}`와 같이 사용</li></ul> |

* 응답

  | 이름         | 타입        | 필수 | 설명                            |
  |--------------|-------------| ------------- |----------------------------------------|
  | access_token | String  | Yes | 발급된 Bearer 타입의 JWT 인증 토큰                   |
  | token_type   | String  | Yes | 토큰의 타입                                 |
  | expires_in   | String  | Yes | 만료까지 남은 초 단위 시간을 의미하며 기본은 3,600(1시간)임 |

```json
{
    "access_token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c",
    "token_type":"Bearer",
    "expires_in":3600
}
```

<a id="case-specific-request-examples"></a>
### 케이스별 요청 예시 { #case-specific-request-examples }
<a id="case-specific-request-examples-curl-when-including-authentication-information-in-the-header"></a>
#### curl: Header에 인증 정보를 포함하는 경우


!!! tip "참고"
    아래 Authorization에 있는 `dXNlckFjY2Vzc0tleTp1c2VyU2VjcmV0S2V5`는 `UserAccessKeyID:SecretAccessKey`를 base64 인코딩한 결과입니다.

* Opaque 타입 토큰

```sh
curl --request POST 'https://oauth.api.nhncloudservice.com/oauth2/token/create' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Authorization: Basic dXNlckFjY2Vzc0tleTp1c2VyU2VjcmV0S2V5' \
  -d 'grant_type=client_credentials'
```

* JWT 타입 토큰

```sh
curl -X POST "https://oauth.api.nhncloudservice.com/oauth2/token/create" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -H "Authorization: Basic dXNlckFjY2Vzc0tleTp1c2VyU2VjcmV0S2V5" \
  -d "grant_type=client_credentials" \
  -d "scope=appKey:r9Zd7vDEmWMfQb00"
```

<a id="case-specific-request-examples-curl-when-using--u-option"></a>
#### curl: -u 옵션을 사용하는 경우

* Opaque 타입 토큰

```sh
curl --request POST 'https://oauth.api.nhncloudservice.com/oauth2/token/create' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -u 'UserAccessKeyID:SecretAccessKey' \
  -d 'grant_type=client_credentials'
```
* JWT 타입 토큰

```sh
curl -X POST "https://oauth.api.nhncloudservice.com/oauth2/token/create" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -u "flyKphnHuI6sDRglmma6:yjZRN9uX71IHAiFS" \
  -d "grant_type=client_credentials" \
  -d "scope=appKey:r9Zd7vDEmWMfQb00"
```

<a id="case-specific-request-examples-feignclient"></a>
#### FeignClient

* Opaque 타입 토큰

```java
@FeignClient(name = "auth", url = "https://oauth.api.nhncloudservice.com")
public interface AuthClient {
    @PostMapping(value = "/oauth2/token/create", consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    TokenResponse createToken(@RequestHeader("Authorization") String authorization, @RequestParam("grant_type") String grantType);
}
```

* JWT 타입 토큰

```java
@FeignClient(name = "auth", url = "https://oauth.api.nhncloudservice.com")
public interface AuthClient {
    @PostMapping(value = "/oauth2/token/create", consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    TokenResponse createToken(@RequestHeader("Authorization") String authorization, 
                              @RequestParam("grant_type") String grantType,
                              @RequestParam("scope") String scope);
}
```

<a id="case-specific-request-examples-resttemplate"></a>
#### RestTemplate

* Opaque 토큰 발급

```java
@Autowired
private RestTemplate restTemplate;

public TokenResponse createToken(String userAccessKeyID, String secretAccessKey) {
    HttpHeaders headers = new HttpHeaders();
    headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
    headers.setBasicAuth(userAccessKeyID, secretAccessKey);

    MultiValueMap<String, String> map = new LinkedMultiValueMap<>();
    map.add("grant_type", "client_credentials");

    HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(map, headers);

    return restTemplate.postForObject("https://oauth.api.nhncloudservice.com/oauth2/token/create", request, TokenResponse.class);
}
```
* JWT 토큰 발급

```java
@Autowired
private RestTemplate restTemplate;
public TokenResponse createJwtToken(String userAccessKeyID, String secretAccessKey, String appKey) {
    HttpHeaders headers = new HttpHeaders();
    headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
    headers.setBasicAuth(userAccessKeyID, secretAccessKey);
	
    MultiValueMap<String, String> map = new LinkedMultiValueMap<>();
    map.add("grant_type", "client_credentials");
    map.add("scope", "appKey:" + appKey);
	
    HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(map, headers);
	
    return restTemplate.postForObject("https://oauth.api.nhncloudservice.com/oauth2/token/create", request, TokenResponse.class);
}
```

<a id="case-specific-request-examples-when-using-openfeign-on-spring-cloud-to-automatically-issue-and-renew-tokens"></a>
#### Spring Cloud의 OpenFeign을 사용하여 자동으로 토큰을 발급 및 갱신하는 경우


!!! tip "참고"
    * 이 방법은 Spring Boot 3.0 이상 버전을 사용하는 경우에만 가능합니다.
    * API를 이용해 강제로 만료시킨 경우를 대비하려면 토큰을 다시 발급하는 부분을 직접 구현해야 합니다.


1) 의존성 추가
```groovy
dependencies {
  implementation 'org.springframework.boot:spring-boot-starter-oauth2-client'
  implementation 'org.springframework.cloud:spring-cloud-starter-openfeign'
}
```


2) Feign 클라이언트 정의
```java
@FeignClient(name = "publicApiClient", url = "https://core.api.nhncloudservice.com")
public interface ExampleApiClient {
  @GetMapping("/v1/organizations")
  String getOrganizations();
}
```

3) 보안 설정
아래는 예시이며, 실제 사용하시는 보안 설정에 맞게 변경해야 합니다.
```java
@Configuration
@EnableWebSecurity
public class SecurityConfig {
  @Bean
  public SecurityFilterChain authorizationServerSecurityFilterChain(HttpSecurity http) throws Exception {
    http.authorizeHttpRequests(authorize -> authorize.anyRequest().permitAll())
        .formLogin(AbstractHttpConfigurer::disable);
    return http.build();
  }
}
```

4) oauth2 클라이언트 및 feign 설정
```java
@Configuration
public class Oauth2Config {

  @Bean
  public ClientRegistrationRepository clientRegistrationRepository() {
    ClientRegistration clientRegistration = ClientRegistration.withRegistrationId("TokenClient")
                                                                 .clientId("UserAccessKeyID")
                                                                 .clientSecret("SecretAccessKey")
                                                                 .authorizationGrantType(AuthorizationGrantType.CLIENT_CREDENTIALS)
                                                                 .tokenUri("https://oauth.api.nhncloudservice.com/oauth2/token/create")
                                                                 .build();
  
    return new InMemoryClientRegistrationRepository(clientRegistration);
  }
  
  @Bean
  public OAuth2AuthorizedClientManager authorizedClientManager(ClientRegistrationRepository clientRegistrationRepository) {
    OAuth2AuthorizedClientService authorizedClientService = new InMemoryOAuth2AuthorizedClientService(clientRegistrationRepository);
    return new AuthorizedClientServiceOAuth2AuthorizedClientManager(clientRegistrationRepository, authorizedClientService);
  }
  
  /**
  * Feign 요청 시 자동으로 발급된 토큰을 자동으로 요청 헤더에 담아서 보내기 위한 인터셉터
  */
  @Bean
  public RequestInterceptor oAuth2AccessTokenInterceptor(OAuth2AuthorizedClientManager authorizedClientManager) {
    // Public API 요청 시 발급된 토큰을 x-nhn-authorization 헤더에 담아서 요청해야 합니다.
    return new OAuth2AccessTokenInterceptor("Bearer", "x-nhn-authorization", "TokenClient", authorizedClientManager);
  }
}
```


<a id="request-user-access-key-token-revocation"></a>
## User Access Key 토큰 만료 요청하기 { #request-user-access-key-token-revocation }
> `POST /oauth2/token/revoke`

!!! tip "알아두기"
    JWT 토큰은 토큰 만료를 지원하지 않습니다.

* 요청

  | 구분 | 이름 | 타입 | 필수 | 값 | 설명   |
  |---------------|------------- | ------------- | ------------- |-------------------------------------------|---|
  | Header        |  Content-Type | String | Yes | application/x-www-form-urlencoded         |         |
  | Header        |  Authorization | String | Yes | Basic Base64(UserAccessKeyID:SecretAccessKey) | `UserAccessKeyID:SecretAccessKey`를 Base64 인코딩한 결과를 `Basic` 뒤에 붙여서 사용 |
  | Request Body |  token | String| Yes | access token    | <ul><li>발급 받은 토큰</li><li>만료 요청 시 `token=발급받은_토큰`과 같이 사용</li></ul>      |

* 응답
    * HttpStatus 200


<a id="request-user-access-key-token-revocation-case-specific-request-examples"></a>
### 케이스별 요청 예시 { #request-user-access-key-token-revocation-case-specific-request-examples }
<a id="request-user-access-key-token-revocation-case-specific-request-examples-curl-when-including-authentication-information-in-the-header"></a>
#### curl: Header에 인증 정보를 포함하는 경우
```sh
curl --request POST 'https://oauth.api.nhncloudservice.com/oauth2/token/revoke' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Authorization: Basic dXNlckFjY2Vzc0tleTp1c2VyU2VjcmV0S2V5' \
  -d 'token=luzocEoQ3tyMvM6pLtoSTHSphgJSGhl5hVvgSstdVQ1X1bZnf9AEMGAcSERIi1Dq0bybSMv0raOcahZjYpZ2biaaoF3jTi9caF5M2TN9F98iZawbBJmN94CPF2Rpe0JI'
```

<a id="request-user-access-key-token-revocation-case-specific-request-examples-curl-when-using-the--u-option"></a>
#### curl: -u 옵션을 사용하는 경우
```sh
curl --request POST 'https://oauth.api.nhncloudservice.com/oauth2/token/revoke' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -u 'UserAccessKeyID:SecretAccessKey' \
  -d 'token=luzocEoQ3tyMvM6pLtoSTHSphgJSGhl5hVvgSstdVQ1X1bZnf9AEMGAcSERIi1Dq0bybSMv0raOcahZjYpZ2biaaoF3jTi9caF5M2TN9F98iZawbBJmN94CPF2Rpe0JI'
```

<a id="request-user-access-key-token-revocation-case-specific-request-examples-feignclient"></a>
#### FeignClient
```java
@FeignClient(name = "auth", url = "https://oauth.api.nhncloudservice.com")
public interface AuthClient {
    @PostMapping(value = "/oauth2/token/revoke", consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    void revokeToken(@RequestHeader("Authorization") String authorization, @RequestParam("token") String token);
}
```

<a id="request-user-access-key-token-revocation-case-specific-request-examples-resttemplate"></a>
#### RestTemplate
```java
@Autowired
private RestTemplate restTemplate;

public void revokeToken(String userAccessKeyID, String secretAccessKey, String token) {
    HttpHeaders headers = new HttpHeaders();
    headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
    headers.setBasicAuth(userAccessKeyID, secretAccessKey);

    MultiValueMap<String, String> map = new LinkedMultiValueMap<>();
    map.add("token", token);

    HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(map, headers);

    restTemplate.postForObject("https://oauth.api.nhncloudservice.com/oauth2/token/revoke", request, Void.class);
}
```


<a id="use-user-access-key-token"></a>
## User Access Key 토큰 사용하기 { #use-user-access-key-token }
User Access Key 토큰은 HTTP 요청 헤더에 포함해 전달합니다. API 호출 시 아래 예시와 같이 요청 헤더에 User Access Key 토큰을 설정해 호출하세요.

* HTTP 헤더 형식 예시
```
X-NHN-Authorization: Bearer {Access Token}
```

사용자가  HTTP 헤더에 키를 담아 서버에 요청을 보내면 서버가 토큰의 유효성을 확인한 뒤 요청을 승인하거나 거부합니다.

    
<a id="get-jwt-public-key"></a>
## JWT Public Key 조회 { #get-jwt-public-key }
> `GET /oauth2/jwks`

!!! tip "알아두기"
    JWT 토큰의 서명을 검증하기 위한 Public Key 목록을 조회합니다.

* 응답

[JWKS(JSON Web Key Set)](https://datatracker.ietf.org/doc/html/rfc7517) 형식으로 Public Key 목록을 반환합니다.

| 이름 | 타입 | 필수 | 설명 |
|------|------|------|------|
| keys | Array | Yes | Public Key 목록 |
| keys[].kty | String | Yes | Key Type(예: RSA) |
| keys[].use | String | Yes | Public Key 사용 목적(예: sig) |
| keys[].kid | String | Yes | Key ID |
| keys[].alg | String | Yes | 알고리즘(예: RS256) |
| keys[].n | String | Yes | RSA Public Key의 Modulus |
| keys[].e | String | Yes | RSA Public Key의 Exponent |

```json
{
  "keys": [
    {
      "kty": "RSA",
      "use": "sig",
      "kid": "example-key-id-1",
      "alg": "RS256",
      "n": "xGOr-H7A-PWBxQcfDpLjJdYTpZDQz_example_modulus_value",
      "e": "AQAB"
    }
  ]
}
```

<a id="request-example"></a>
### 요청 예시 { #request-example }
* curl
```sh
curl -X GET "https://oauth.api.nhncloudservice.com/oauth2/jwks"
```

<a id="public-key-usage-example"></a>
### Public Key 활용 예시 { #public-key-usage-example }
조회한 Public Key를 사용하여 JWT 토큰의 서명을 검증할 수 있습니다. 대부분의 JWT 라이브러리에서 JWKS 형식을 지원합니다.

* Java (nimbus-jose-jwt 사용)
```java
import com.nimbusds.jose.jwk.JWKSet;
import com.nimbusds.jose.jwk.RSAKey;
import com.nimbusds.jwt.SignedJWT;
import java.net.URL;

public void verifyToken(String token) throws Exception {
    // JWKS 엔드포인트에서 Public Key 조회
    JWKSet jwkSet = JWKSet.load(new URL("https://oauth.api.nhncloudservice.com/oauth2/jwks"));
    
    // JWT 파싱
    SignedJWT signedJWT = SignedJWT.parse(token);
    String keyId = signedJWT.getHeader().getKeyID();
    
    // Key ID로 해당 Public Key 찾기
    RSAKey rsaKey = (RSAKey) jwkSet.getKeyByKeyId(keyId);
    
    // 서명 검증
    JWSVerifier verifier = new RSASSAVerifier(rsaKey);
    boolean isValid = signedJWT.verify(verifier);
}
```

!!! tip "알아두기"
    User Access Key 토큰은 오류 발생 시 [The OAuth 2.0 Authorization Framework](https://datatracker.ietf.org/doc/html/rfc6749#section-5.2)와 동일한 오류 코드를 반환합니다. 토큰 요청 API 호출, 토큰 만료 요청 API 호출, 토큰 사용 등의 상황에 반환될 수 있는 오류 코드는 [프레임워크 API 가이드](./framework-api/#_281)에서 확인할 수 있습니다.

    

<a id="issue-iaas-token-with-user-access-key"></a>
## User Access Key로 IaaS 토큰 발급받기 { #issue-iaas-token-with-user-access-key }
> `POST /iaas-tokens/v3/auth/tokens`

User Access Key로 기본 인프라 서비스(IaaS)의 인증 토큰을 발급받을 수 있습니다. 발급받은 IaaS 토큰으로 Compute, Block Storage, Network 등 인프라 리소스 제어 API를 호출합니다.

기본 인프라 서비스의 Identity API를 직접 호출하는 방식과 달리 API 비밀번호를 설정하거나 테넌트 ID를 확인하지 않아도 됩니다. 요청과 응답은 OpenStack Keystone v3 규격을 따르므로 OpenStack CLI와 SDK에서도 사용할 수 있습니다. IaaS 토큰의 사용 방법과 서비스별 엔드포인트는 [IaaS 토큰](./iaas-token/)에서 확인할 수 있습니다.

!!! tip "알아두기"
    * 이 API로 발급한 IaaS 토큰의 유효 시간은 12시간으로 고정되어 있으며 변경할 수 없습니다.
    * 별도의 인증 헤더가 필요하지 않습니다. User Access Key ID와 Secret Access Key를 요청 본문에 담아 전달합니다.

<a id="issue-iaas-token-format"></a>
### 발급되는 토큰 형식 { #issue-iaas-token-format }

IaaS 토큰은 OpenStack Keystone의 Fernet 형식으로 발급됩니다. Fernet 토큰은 사용자, 프로젝트, 역할, 만료 시각 등 인증에 필요한 정보가 토큰 문자열 자체에 암호화되어 담겨 있는 형식으로, `gAAAAA`로 시작하는 문자열입니다.

* 받은 값을 그대로 `X-Auth-Token` 헤더에 전달해야 하며, 토큰 내용을 직접 해석하거나 가공해서는 안 됩니다.
* OpenStack 표준 형식이므로 OpenStack CLI와 SDK에서 그대로 사용할 수 있습니다.
* User Access Key 토큰(Opaque 형식)과는 서로 다른 인증 체계입니다.
* 기본 인프라 서비스 API에는 Fernet 형식의 IaaS 토큰을 사용해야 합니다.
* 그 외 NHN Cloud Public API에는 User Access Key 토큰을 사용해야 합니다.
* 발급 후 12시간 동안 유효합니다. 유효 시간은 변경할 수 없습니다.
* 토큰이 만료되면 재발급해야 합니다.

<a id="issue-iaas-token-prerequisites"></a>
### 사전 조건 { #issue-iaas-token-prerequisites }

* **Opaque 타입**의 User Access Key만 사용할 수 있습니다. JWT 타입 User Access Key로는 IaaS 토큰을 발급받을 수 없습니다.
* 토큰을 발급받을 프로젝트에 Instance 또는 Object Storage 서비스가 활성화되어 있어야 합니다.
* User Access Key를 생성한 계정이 해당 프로젝트 권한을 가지고 있어야 합니다.

<a id="issue-iaas-token-request"></a>
### 요청 { #issue-iaas-token-request }

| 구분           | 이름                                   | 타입     | 필수  | 값                | 설명                                                                                                            |
|--------------|--------------------------------------|--------|-----|------------------|---------------------------------------------------------------------------------------------------------------|
| Header       | Content-Type                         | String | Yes | application/json |                                                                                                                 |
| Request Body | auth.identity.methods                | Array  | Yes | ["password"]     | 인증 방식 목록. `password`만 지원합니다                                                                                   |
| Request Body | auth.identity.password.user.id       | String | Yes |                  | User Access Key ID                                                                                              |
| Request Body | auth.identity.password.user.password | String | Yes |                  | Secret Access Key                                                                                               |
| Request Body | auth.scope.project.id                | String | Yes |                  | 토큰을 발급받을 서비스의 Appkey. Instance 또는 Object Storage의 Appkey를 사용하며, 이 Appkey로 대상 프로젝트를 식별합니다. Appkey 확인 방법은 [Appkey](./appkey/)를 참고하세요 |

<a id="issue-iaas-token-response"></a>
### 응답 { #issue-iaas-token-response }

발급된 IaaS 토큰은 응답 본문이 아닌 `X-Subject-Token` 헤더에 담겨 반환됩니다. 이 값은 OpenStack Keystone의 Fernet 토큰이며, 그대로 `X-Auth-Token` 헤더에 넣어 인프라 리소스 제어 API를 호출합니다.

| 구분     | 이름               | 타입     | 설명                            |
|--------|------------------|--------|-------------------------------|
| Header | X-Subject-Token  | String | 발급된 IaaS 토큰(OpenStack Keystone Fernet 토큰) |
| Body   | token.issued_at  | String | 토큰 발급 시각                      |
| Body   | token.expires_at | String | 토큰 만료 시각. 발급 시각으로부터 12시간 뒤입니다 |
| Body   | token.project    | Object | 토큰이 적용되는 프로젝트 정보              |
| Body   | token.user       | Object | 토큰을 발급받은 사용자 정보               |
| Body   | token.roles      | Array  | 해당 프로젝트에서 사용자에게 부여된 역할 목록     |
| Body   | token.catalog    | Array  | 사용할 수 있는 서비스 엔드포인트 목록         |

<a id="issue-iaas-token-request-example"></a>
### 요청 예시 { #issue-iaas-token-request-example }

* curl

```sh
curl -X POST "https://oauth.api.nhncloudservice.com/iaas-tokens/v3/auth/tokens" \
  -H "Content-Type: application/json" \
  -d '{
        "auth": {
          "identity": {
            "methods": ["password"],
            "password": {
              "user": {
                "id": "flyKphnHuI6sDRglmma6",
                "password": "yjZRN9uX71IHAiFS"
              }
            }
          },
          "scope": {
            "project": {
              "id": "r9Zd7vDEmWMfQb00"
            }
          }
        }
      }'
```

<a id="issue-iaas-token-response-example"></a>
### 응답 예시 { #issue-iaas-token-response-example }

* 응답 헤더

```
HTTP/1.1 201 Created
Content-Type: application/json
X-Subject-Token: gAAAAABnDqW1x3TQZ8kP2mN7vL4hR9sE6yU1aI0oF5cB3dG7jK2nM8pQ4rS6tV9wX1zY
```

* 응답 본문

<details><summary>예시</summary>
<p>

```json
{
  "token": {
    "methods": [
      "password"
    ],
    "issued_at": "2026-10-13T02:35:05.000000Z",
    "expires_at": "2026-10-13T14:35:05.000000Z",
    "project": {
      "id": "f5073eaa26b64cffbee89411df94ce01",
      "name": "example-project",
      "domain": {
        "id": "default",
        "name": "Default"
      }
    },
    "user": {
      "id": "a1b2c3d4e5f6478899aabbccddeeff00",
      "name": "example-user",
      "domain": {
        "id": "default",
        "name": "Default"
      }
    },
    "roles": [
      {
        "id": "21b7753ad7b54f1284af6e292cb35bea",
        "name": "project_reader"
      }
    ],
    "catalog": [
      {
        "type": "compute",
        "name": "nova",
        "endpoints": [
          {
            "region": "KR1",
            "interface": "public",
            "url": "https://kr1-api-instance-infrastructure.nhncloudservice.com/v2/f5073eaa26b64cffbee89411df94ce01"
          }
        ]
      }
    ]
  }
}
```

</p>
</details>

<a id="issue-iaas-token-error-response"></a>
### 오류 응답 { #issue-iaas-token-error-response }

오류가 발생하면 OpenStack Keystone 규격의 오류 응답을 반환합니다.

| HTTP 상태 코드                 | 설명                                                                     |
|---------------------------|------------------------------------------------------------------------|
| 400 Bad Request           | 요청 형식이 올바르지 않은 경우                                                      |
| 401 Unauthorized          | User Access Key 또는 Secret Access Key가 유효하지 않거나, 요청한 Appkey로 토큰을 발급받을 수 없는 경우 |
| 500 Internal Server Error | 서버 내부 오류가 발생한 경우                                                       |

```json
{
  "error": {
    "code": 401,
    "message": "The request you have made requires authentication.",
    "title": "Unauthorized"
  }
}
```

!!! danger "주의"
    * User Access Key 또는 Secret Access Key가 일치하지 않거나 User Access Key가 사용 중지 상태이면 토큰이 발급되지 않습니다.
    * 요청한 Appkey의 프로젝트에 해당 서비스가 활성화되어 있지 않으면 토큰이 발급되지 않습니다.
    * 사용자가 프로젝트에서 권한을 잃을 경우 발급된 IaaS 토큰은 사용할 수 없습니다.
