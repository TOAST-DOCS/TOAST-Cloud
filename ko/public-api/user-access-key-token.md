# User Access Key 토큰

**NHN Cloud > Public API > API 인증 방식 > User Access Key 토큰**

User Access Key 토큰은 User Access Key를 기반으로 발급되는 Bearer 타입의 일시적 액세스 토큰입니다. Bearer 토큰은 토큰을 소유한 사용자라면 누구나 접근 권한을 부여 받는 보안 토큰의 한 종류로, 유효 기간을 설정할 수 있어 리소스를 안전하게 보호할 수 있습니다.
User Access Key 토큰은 역할 기반 접근 제어 방식(ABAC, attribute-Based Access Control)으로 동작하여 토큰을 사용할 경우 NHN Cloud 계정 또는 IAM 계정에 부여된 역할 및 권한이 적용됩니다. 따라서 호출 가능한 API가 해당 계정의 역할 및 권한 범위 내로 제한됩니다. 또한 역할 상세 조건을 설정하여 정밀한 접근 제어가 가능합니다.

NHN Cloud는 두 가지 타입의 토큰을 제공합니다:
- **Opaque 토큰**: 일반적인 NHN Cloud API 호출에 사용되는 기본 토큰 타입
- **JWT 토큰**: 현재 EasyQueue 상품의 메시지 전송/수신 시애만 사용 가능한 토큰 타입

## User Access Key 토큰 발급 및 Public API 호출 개요

User Access Key 토큰 발급 및 API 호출은 다음과 같은 흐름으로 동작합니다.

### 신규 토큰 발급 및 API 호출

![img001.png](http://static.toastoven.net/toast/public_api/img01_KO.png)

### 토큰 만료 시 재발급 및 API 호출

![img002.png](http://static.toastoven.net/toast/public_api/img02_KO.png)


발급한 토큰은 유효 기간 동안만 사용할 수 있으며(기본값: 24시간), 만료 후에는 새로 발급해야 합니다. 토큰이 유출되었거나 유출이 의심되는 경우 해당 토큰을 즉시 만료 처리하고 필요시 재발급해야 합니다.


!!! tip "알아두기"
    토큰의 유효 시간은 NHN Cloud 콘솔의 **API 보안 설정** 메뉴에서 변경할 수 있습니다.
    Opaque 토큰 유효 시간은 60초~86,400초(24시간) 내에서 설정할 수 있고, JWT 토큰 유효 시간은 60초~3,600초(1시간) 내에서 설정할 수 있습니다.
    유효 시간을 수정하기 전에 발급된 토큰의 유효 시간은 변경되지 않으며, 토큰 유효 시간 수정 후 신규로 발급하는 토큰부터 변경된 토큰 유효 시간이 적용됩니다.


## 사전 작업

User Access Key 토큰을 발급하려면 먼저 User Access Key ID와 Secret Access Key를 먼저 발급해야 합니다. NHN Cloud 콘솔의 **API 보안 설정** 메뉴에서 User Access Key별 토큰 정보를 확인하고 관리할 수 있습니다.

1) NHN Cloud 콘솔에서 우측 상단의 계정에 마우스 포인터를 올리면 표시되는 드롭다운 메뉴에서 **API 보안 설정**을 클릭합니다.

2) **+ User Access Key 생성**을 클릭합니다.<br>
![C_userAccessKey_1_ko](http://static.toastoven.net/toast/public_api/C_userAccessKey_1_ko.png)
3. **User Access Key 생성** 모달 창에서 **토큰 타입**과 **토큰 유효 시간**을 설정한 뒤 **생성**을 클릭합니다.<br>
    - **Opaque 토큰 (기본)**: **Opaque 타입 User Access Key ID와 Secret Access Key 생성**을 선택
    - **JWT 토큰**: **JWT 타입 User Access Key ID와 Secret Access Key 생성**을 선택 (현재 EasyQueue 제품만 지원)<br>
![C_userAccessKey_2_ko](http://static.toastoven.net/toast/public_api/C_userAccessKey_2_ko.png)

4) **User Access Key 발급 완료** 모달 창에서 **Secret Access Key**를 복사한 뒤 **확인**을 클릭합니다.<br>
![C_userAccessKey_3_ko](http://static.toastoven.net/toast/public_api/C_userAccessKey_3_ko.png)


!!! danger "주의"
    * 모달 창을 닫은 뒤에는 Secret Access Key를 다시 확인할 수 없습니다. Secret Access Key를 잊어버릴 경우 재생성해야 하므로 반드시 복사한 뒤 별도로 관리하세요.
    * User Access Key 또는 Secret Access Key 중 하나라도 유출되었거나 유출이 의심되는 경우 해당 키를 폐기하고 새로 발급 받아야 합니다.


## 인증 서버 도메인
인증 서버의 도메인은 다음과 같습니다.

```
https://oauth.api.nhncloudservice.com/
```


## User Access Key 토큰 발급 요청하기
> `POST /oauth2/token/create`

### Opaque 타입 토큰 발급 요청하기
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

### JWT 타입 토큰 발급 요청하기

> **현재 EasyQueue 상품만 JWT 토큰을 사용할 수 있습니다.**

* 요청

  | 구분 | 이름 | 타입 | 필수 | 값                                     | 설명                                                                   |
  |---------------|------------- | ------------- | ------------- |-------------------------------------------|--------------------------|
  | Header        |  Content-Type | String | Yes | application/x-www-form-urlencoded         |                                                                        |
  | Header        |  Authorization | String | Yes | Basic Base64(UserAccessKeyID:SecretAccessKey) | `UserAccessKeyID:SecretAccessKey` 를 Base64 인코딩한 결과를 `Basic ` 뒤에 붙여서 사용 |
  | Request Body |  grant_type | String | Yes | client_credentials                        | <ul><li>토큰 발급 grant_type은 client_credentials만 제공되고 있음</li><li>발급 요청 시 `grand_type=client_credentials`와 같이 사용</li></ul> |
  | Request Body |  scope | String | Yes | appKey:{appKey}                | <ul><li>서비스 활성화 후 발급받은 앱키</li><li>발급 요청 시 `scope=appKey:{appKey}`와 같이 사용</li></ul> |

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

### 케이스별 요청 예시
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

#### curl: -u 옵션을 사용하는 경우
=======

curl: -u 옵션을 사용하는 경우

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


## User Access Key 토큰 만료 요청하기
> `POST /oauth2/token/revoke`
>
> **JWT 토큰은 토큰 만료를 지원하지 않습니다.**

* 요청

  | 구분 | 이름 | 타입 | 필수 | 값 | 설명   |
  |---------------|------------- | ------------- | ------------- |-------------------------------------------|---|
  | Header        |  Content-Type | String | Yes | application/x-www-form-urlencoded         |         |
  | Header        |  Authorization | String | Yes | Basic Base64(UserAccessKeyID:SecretAccessKey) | `UserAccessKeyID:SecretAccessKey` 를 Base64 인코딩한 결과를 `Basic ` 뒤에 붙여서 사용 |
  | Request Body |  token | String| Yes | access token    | <ul><li>발급 받은 토큰</li><li>만료 요청 시 `token=발급받은_토큰`과 같이 사용</li></ul>      |

* 응답
    * HttpStatus 200


### 케이스별 요청 예시 
#### curl: Header에 인증 정보를 포함하는 경우
```sh
curl --request POST 'https://oauth.api.nhncloudservice.com/oauth2/token/revoke' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Authorization: Basic dXNlckFjY2Vzc0tleTp1c2VyU2VjcmV0S2V5' \
  -d 'token=luzocEoQ3tyMvM6pLtoSTHSphgJSGhl5hVvgSstdVQ1X1bZnf9AEMGAcSERIi1Dq0bybSMv0raOcahZjYpZ2biaaoF3jTi9caF5M2TN9F98iZawbBJmN94CPF2Rpe0JI'
```

#### curl: -u 옵션을 사용하는 경우
```sh
curl --request POST 'https://oauth.api.nhncloudservice.com/oauth2/token/revoke' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -u 'UserAccessKeyID:SecretAccessKey' \
  -d 'token=luzocEoQ3tyMvM6pLtoSTHSphgJSGhl5hVvgSstdVQ1X1bZnf9AEMGAcSERIi1Dq0bybSMv0raOcahZjYpZ2biaaoF3jTi9caF5M2TN9F98iZawbBJmN94CPF2Rpe0JI'
```

#### FeignClient
```java
@FeignClient(name = "auth", url = "https://oauth.api.nhncloudservice.com")
public interface AuthClient {
    @PostMapping(value = "/oauth2/token/revoke", consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    void revokeToken(@RequestHeader("Authorization") String authorization, @RequestParam("token") String token);
}
```

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


## User Access Key 토큰 사용하기
User Access Key 토큰은 HTTP 요청 헤더에 포함해 전달합니다. API 호출 시 아래 예시와 같이 요청 헤더에 User Access Key 토큰을 설정해 호출하세요.

* HTTP 헤더 형식 예시
```
X-NHN-Authorization: Bearer {Access Token}
```

사용자가  HTTP 헤더에 키를 담아 서버에 요청을 보내면 서버가 토큰의 유효성을 확인한 뒤 요청을 승인하거나 거부합니다.

    
## JWT Public Key 조회
> `GET /oauth2/jwks`
>
> JWT 토큰의 서명을 검증하기 위한 Public Key 목록을 조회합니다.

* 응답

[JWKS(JSON Web Key Set)](https://datatracker.ietf.org/doc/html/rfc7517) 형식으로 Public Key 목록을 반환합니다.

| 이름 | 타입 | 필수 | 설명 |
|------|------|------|------|
| keys | Array | Yes | Public Key 목록 |
| keys[].kty | String | Yes | Key Type (예: RSA) |
| keys[].use | String | Yes | Public Key 사용 목적 (예: sig) |
| keys[].kid | String | Yes | Key ID |
| keys[].alg | String | Yes | 알고리즘 (예: RS256) |
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

### 요청 예시
* curl
```sh
curl -X GET "https://oauth.api.nhncloudservice.com/oauth2/jwks"
```

### Public Key 활용 예시
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
User Access Key 토큰은 오류 발생 시 [The OAuth 2.0 Authorization Framework](https://datatracker.ietf.org/doc/html/rfc6749#section-5.2)와 동일한 오류 코드를 반환합니다. 토큰 요청 API 호출, 토큰 만료 요청 API 호출, 토큰 사용 등의 상황에 반환될 수 있는 오류 코드는 [프레임워크 API 가이드](https://docs.nhncloud.com/ko/nhncloud/ko/public-api/framework-api/#_281)에서 확인할 수 있습니다.

