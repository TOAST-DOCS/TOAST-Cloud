<!-- pre-align:aligned sig=9aeb11dc43e9 -->

# User Access Key Token

**NHN Cloud > Public API User Guide > API Authentication Methods > User Access Key Token**

User Access Key tokens are temporary Bearer tokens issued based on a User Access Key. A Bearer token is a type of security token that grants access to any party in possession of the token. By setting an expiration time, you can ensure the security of your resources.
These tokens operate using Attribute-Based Access Control (ABAC). When using a token, the specific roles and permissions assigned to the NHN Cloud or IAM account are applied, restricting API calls to the authorized scope of that account. Furthermore, you can achieve fine-grained access control by configuring detailed role conditions.

NHN Cloud provides two token types:
- **Opaque token**: The default token type used for general NHN Cloud API calls
- **JWT token**: A token type currently available only for sending and receiving messages in the EasyQueue service

<a id="overview-of-user-access-key-token-issuance-and-public-api-calls"></a>
## Overview of User Access Key Token Issuance and Public API Calls { #overview-of-user-access-key-token-issuance-and-public-api-calls }

Issuing a User Access Key token and calling the API works in the following flow:

<a id="issue-new-tokens-and-making-api-calls"></a>
### Issue new tokens and making API calls { #issue-new-tokens-and-making-api-calls }

![img001.png](http://static.toastoven.net/toast/public_api/img01_EN.png)

<a id="reissue-and-api-calls-on-token-expiration"></a>
### Reissue and API calls on token expiration { #reissue-and-api-calls-on-token-expiration }

![img002.png](http://static.toastoven.net/toast/public_api/img02_EN.png)


Issued tokens are valid only during their expiration period (default: 24 hours) and must be reissued upon expiration. If a token is leaked or suspected to be compromised, you must revoke it immediately and reissue a new one if necessary.


!!! tip "Note"
    You can modify the Token Expiration Time in the **API Security Settings** menu of the NHN Cloud Console.
    The expiration time for Opaque tokens can be set between 60 seconds and 86,400 seconds (24 hours), and the expiration time for JWT tokens can be set between 60 seconds and 3,600 seconds (one hour).
    Changes to the expiration time do not affect tokens issued prior to the update. The new setting will only apply to tokens issued after the modification is saved.


<a id="prerequisites"></a>
## Prerequisites { #prerequisites }

To issue a User Access Key Token, you must first generate a User Access Key ID and Secret Access Key. You can view and manage token information for each User Access Key in the **API Security Settings** menu of the NHN Cloud Console.

1) In the drop-down menu that appears when you hover over your account in the upper-right corner of the NHN Cloud console, click **API Security Settings**.

2) Click **+ Create User Access Key ID**<br>
![C_userAccessKey_1_en](http://static.toastoven.net/toast/public_api/C_userAccessKey_1_en.png)

3) In the **Create User Access Key** modal, set the **Token Type** and **Token Expiration Time**, and then click [Create].<br>
    - **Opaque token (default): Select **Create Opaque Type User Access Key ID and Secret Access Key**
    - **JWT token**: Select **Create JWT Type User Access Key ID and Secret Access Key** (currently supported only in the EasyQueue service)
![C_userAccessKey_2_en](http://static.toastoven.net/toast/public_api/C_userAccessKey_2_en.png)

4) In the **User Access Key Issued** modal, copy the **Secret Access Key** and then click **OK**.<br>
![C_userAccessKey_3_en](http://static.toastoven.net/toast/public_api/C_userAccessKey_3_en.png)


!!! danger "Caution"
    * The Secret Access Key cannot be recovered or viewed once the modal window is closed. If lost, the key must be regenerated; please ensure you copy and store it in a secure location.
    * If either the User Access Key or Secret Access Key is leaked or suspected to be compromised, you must immediately revoke the key and issue a new one.


<a id="authentication-server-domain"></a>
## Authentication Server Domain { #authentication-server-domain }
The authentication domain is as follows:

```
https://oauth.api.nhncloudservice.com/
```

<a id="request-user-access-key-token-issuance"></a>
## Request User Access Key Token Issuance { #request-user-access-key-token-issuance }
> `POST /oauth2/token/create`

<a id="request-opaque-token-issuance"></a>
### Request Opaque Token Issuance { #request-opaque-token-issuance }
* Request

| Category | Name | Type | Required | Value                                     | Description                                                                   |
|---------------|------------- | ------------- | ------------- |-------------------------------------------|--------------------------| 
| Header        |  Content-Type | String | Yes | application/x-www-form-urlencoded         |                                                                        |
| Header        |  Authorization | String | Yes | Basic Base64(UserAccessKeyID:SecretAccessKey) | Use the Base64 encoded result of `UserAccessKeyID:SecretAccessKey` followed by `Basic`  | 
| Request Body |  grant_type | String | Yes | client_credentials                        | <ul><li>Only the client_credentials grant type is currently supported for token issuance</li><li>When requesting a token, use the parameter as follows: `grand_type=client_credentials`</li></ul> |

* Response

| Name         | Type        | Required | Description                            |
|--------------|-------------| ------------- |----------------------------------------|
| access_token | String  | Yes | Authentication token of type Bearer issued                   | 
| token_type   | String  | Yes | Token type                                 |
| expires_in   | String  | Yes | The time in seconds remaining until expiration, which defaults to 86,400 seconds (one day) |

```json
{
    "access_token":"luzocEoQ3tyMvM6pLtoSTHSphgJSGhl5hVvgSstdVQ1X1bZnf9AEMGAcSERIi1Dq0bybSMv0raOcahZjYpZ2biaaoF3jTi9caF5M2TN9F98iZawbBJmN94CPF2Rpe0JI",
    "token_type":"Bearer",
    "expires_in":86400
}
```

<a id="request-jwt-token-issuance"></a>
### Request JWT Token Issuance { #request-jwt-token-issuance }

!!! tip "Note"
    Currently, JWT tokens are available only in the EasyQueue service.

* Request

  | Category | Name | Type | Required | Value                                     | Description                                                                   |
  |---------------|------------- | ------------- | ------------- |-------------------------------------------|--------------------------|
  | Header        |  Content-Type | String | Yes | application/x-www-form-urlencoded         |                                                                        |
| Header        |  Authorization | String | Yes | Basic Base64(UserAccessKeyID:SecretAccessKey) | Use the Base64 encoded result of `UserAccessKeyID:SecretAccessKey` followed by `Basic` |
  | Request Body |  grant_type | String | Yes | client_credentials                        | <ul><li>Only the client_credentials grant type is currently supported for token issuance</li><li>When requesting a token, use the parameter as follows: `grand_type=client_credentials`</li></ul> |
  | Request Body |  scope | String | Yes | appKey:{appKey}                | <ul><li>App key issued after activating the service</li><li>When requesting a token, use the parameter as follows: `scope=appKey:{appKey}`</li></ul> |

* Response

  | Name         | Type        | Required | Description                            |
  |--------------|-------------| ------------- |----------------------------------------|
 | access_token | String  | Yes | Issued JWT authentication token of type Bearer                   |
  | token_type   | String  | Yes | Token type                                 |
  | expires_in   | String  | Yes | The time in seconds remaining until expiration, which defaults to 3,600 seconds (one hour) |

```json
{
    "access_token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c",
    "token_type":"Bearer",
    "expires_in":3600
}
```

<a id="case-specific-request-examples"></a>
### Case-specific request examples { #case-specific-request-examples }
<a id="case-specific-request-examples-curl-when-including-authentication-information-in-the-header"></a>
#### curl: When including authentication information in the header


!!! tip "Notes"
    `The dXNlckFjY2Vzc0tleTp1c2VyU2VjcmV0S2V5`in Authorization below is the result of base64 encoding `the UserAccessKeyID:SecretAccessKey`.

* Opaque token

```sh
curl --request POST 'https://oauth.api.nhncloudservice.com/oauth2/token/create' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Authorization: Basic dXNlckFjY2Vzc0tleTp1c2VyU2VjcmV0S2V5' \
  -d 'grant_type=client_credentials'
```

* JWT token

```sh
curl -X POST "https://oauth.api.nhncloudservice.com/oauth2/token/create" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -H "Authorization: Basic dXNlckFjY2Vzc0tleTp1c2VyU2VjcmV0S2V5" \
  -d "grant_type=client_credentials" \
  -d "scope=appKey:r9Zd7vDEmWMfQb00"
```

<a id="case-specific-request-examples-curl-when-using--u-option"></a>
#### curl: When using -u option

* Opaque token

```sh
curl --request POST 'https://oauth.api.nhncloudservice.com/oauth2/token/create' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -u 'UserAccessKeyID:SecretAccessKey' \
  -d 'grant_type=client_credentials'
```
* JWT token

```sh
curl -X POST "https://oauth.api.nhncloudservice.com/oauth2/token/create" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -u "flyKphnHuI6sDRglmma6:yjZRN9uX71IHAiFS" \
  -d "grant_type=client_credentials" \
  -d "scope=appKey:r9Zd7vDEmWMfQb00"
```

<a id="case-specific-request-examples-feignclient"></a>
#### FeignClient

* Opaque token

```java
@FeignClient(name = "auth", url = "https://oauth.api.nhncloudservice.com")
public interface AuthClient {
    @PostMapping(value = "/oauth2/token/create", consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    TokenResponse createToken(@RequestHeader("Authorization") String authorization, @RequestParam("grant_type") String grantType);
}
```

* JWT token

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

* Opaque token

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
* JWT token

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
#### When using OpenFeign on Spring Cloud to automatically issue and renew tokens


!!! tip "Note"
    * This method is only possible if you are using Spring Boot 3.0 or later.
    * You will need to implement the part of reissuing the token yourself in case you force it to expire via the API.


1) Add Dependency
```groovy
dependencies {
  implementation 'org.springframework.boot:spring-boot-starter-oauth2-client'
  implementation 'org.springframework.cloud:spring-cloud-starter-openfeign'
}
```


2) Define a Feign client
```java
@FeignClient(name = "publicApiClient", url = "https://core.api.nhncloudservice.com")
public interface ExampleApiClient {
  @GetMapping("/v1/organizations")
  String getOrganizations();
}
```

3) Security Settings
The following is an example and should be changed to match your actual security settings:
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

4) Set up the oauth2 client and feign
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
  * Interceptor that automatically retrieves an access token and adds it to the request header for Feign clients
  */
  @Bean
  public RequestInterceptor oAuth2AccessTokenInterceptor(OAuth2AuthorizedClientManager authorizedClientManager) {
    // When making a Public API request, you must include the issued token in the x-nhn-authorization header.
    return new OAuth2AccessTokenInterceptor("Bearer", "x-nhn-authorization", "TokenClient", authorizedClientManager);
  }
}
```


<a id="request-user-access-key-token-revocation"></a>
## Request User Access Key Token Revocation { #request-user-access-key-token-revocation }
> `POST /oauth2/token/revoke`

!!! tip "Note"
    JWT tokens do not support token revocation.

* Request

  | Category | Name | Type | Required | Value | Description   |
  |---------------|------------- | ------------- | ------------- |-------------------------------------------|---|
  | Header        |  Content-Type | String | Yes | application/x-www-form-urlencoded         |         |
  | Header        |  Authorization | String | Yes | Basic Base64(UserAccessKeyID:SecretAccessKey) | Use the Base64 encoded result of `UserAccessKeyID:SecretAccessKey` followed by `Basic`  |
  | Request Body |  token | String| Yes | access token    | <ul><li>Issued token</li><li>When requesting revocation, use the parameter as follows: `token=issued_token`</li></ul>      |

* Response
    * HttpStatus 200


<a id="request-user-access-key-token-revocation-case-specific-request-examples"></a>
### Case-specific request examples { #request-user-access-key-token-revocation-case-specific-request-examples }
<a id="request-user-access-key-token-revocation-case-specific-request-examples-curl-when-including-authentication-information-in-the-header"></a>
#### curl: When including authentication information in the header
```sh
curl --request POST 'https://oauth.api.nhncloudservice.com/oauth2/token/revoke' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Authorization: Basic dXNlckFjY2Vzc0tleTp1c2VyU2VjcmV0S2V5' \
  -d 'token=luzocEoQ3tyMvM6pLtoSTHSphgJSGhl5hVvgSstdVQ1X1bZnf9AEMGAcSERIi1Dq0bybSMv0raOcahZjYpZ2biaaoF3jTi9caF5M2TN9F98iZawbBJmN94CPF2Rpe0JI'
```

<a id="request-user-access-key-token-revocation-case-specific-request-examples-curl-when-using-the--u-option"></a>
#### curl: When using the -u option
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
## Use User Access Key token { #use-user-access-key-token }
User Access Key token is passed via the HTTP request header. When calling an API, include the User Access Key token in the example header as shown in the example below:

* HTTP header format examples
```
X-NHN-Authorization: Bearer {Access Token}
```

When a user sends a request with a key in the HTTP header, the server validates the token and then approves or rejects the request.

    
<a id="get-jwt-public-key"></a>
## Get JWT Public Key { #get-jwt-public-key }
> `GET /oauth2/jwks`

!!! tip "Note"
    Retrieves a list of public keys for verifying JWT token signatures.

* Response

Returns a list of public keys in [JWKS(JSON Web Key Set)](https://datatracker.ietf.org/doc/html/rfc7517) format.

| Name | Type | Required | Description |
|------|------|------|------|
| keys | Array | Yes | List of public keys |
| keys[].kty | String | Yes | Key type (e.g., RSA)
| keys[].use | String | Yes | Purpose of the public key (e.g., sig)
| keys[].kid | String | Yes | Key ID |
| keys[].alg | String | Yes | Algorithm (e.g., RS256) |
| keys[].n | String | Yes | Modulus of the RSA public key |
| keys[].e | String | Yes | Exponent of the RSA public key |

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
### Request Example { #request-example }
* curl
```sh
curl -X GET "https://oauth.api.nhncloudservice.com/oauth2/jwks"
```

<a id="public-key-usage-example"></a>
### Public Key Usage Example { #public-key-usage-example }
Public Key Usage Example / You can verify JWT token signatures using the retrieved public keys. Most JWT libraries support the JWKS format.

* Java (using nimbus-jose-jwt)
```java
import com.nimbusds.jose.jwk.JWKSet;
import com.nimbusds.jose.jwk.RSAKey;
import com.nimbusds.jwt.SignedJWT;
import java.net.URL;

public void verifyToken(String token) throws Exception {
    // Retrieve public keys from the JWKS endpoint
    JWKSet jwkSet = JWKSet.load(new URL("https://oauth.api.nhncloudservice.com/oauth2/jwks"));
    
    // Parse JWT
    SignedJWT signedJWT = SignedJWT.parse(token);
    String keyId = signedJWT.getHeader().getKeyID();
    
    // Find the public key by key ID
    RSAKey rsaKey = (RSAKey) jwkSet.getKeyByKeyId(keyId);
    
    // Verify the signature
    JWSVerifier verifier = new RSASSAVerifier(rsaKey);
    boolean isValid = signedJWT.verify(verifier);
}
```

!!! tip "Note"
    User Access Key Tokens return the same error codes as defined in [The OAuth 2.0 Authorization Framework](https://datatracker.ietf.org/doc/html/rfc6749#section-5.2). For details on error codes returned during token issuance, revocation, or usage, please refer to the [Framework API Guide](https://docs.nhncloud.com/ko/nhncloud/ko/public-api/framework-api/#_281).

    
