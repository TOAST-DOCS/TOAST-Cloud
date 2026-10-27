<!-- machine_translated: true -->

<!-- pre-align:aligned sig=244a740a7bef -->

# User Access Key Token

**NHN Cloud > Public API User Guide > API Authentication Methods > User Access Key Token**

User Access Key tokens are temporary Bearer tokens issued based on a User Access Key. A Bearer token is a type of security token that grants access to any party in possession of the token. By setting an expiration time, you can ensure the security of your resources.
These tokens operate using Attribute-Based Access Control (ABAC). When using a token, the specific roles and permissions assigned to the NHN Cloud or IAM account are applied, restricting API calls to the authorized scope of that account. Furthermore, you can achieve fine-grained access control by configuring detailed role conditions.

With a single User Access Key, you can issue tokens in different formats depending on the intended use.

| Token Type | Issuance API | Usage | Validity Time | Required User Access Key Format |
| --- | --- | --- | --- | --- |
| Opaque | `POST /oauth2/token/create` | NHN Cloud Public APIs (general) | From 60 seconds to 24 hours (settable) | Opaque |
| JWT | `POST /oauth2/token/create` | EasyQueue message delivery and reception | From 60 seconds to 1 hour (settable) | JWT |
| Fernet | `POST /iaas-tokens/v3/auth/tokens` | OpenStack-based infrastructure services (Compute, Block Storage, Network, etc.) | 12 hours (fixed) | Opaque |

The format (Opaque / JWT) selected when creating a User Access Key is the format of the OAuth 2.0 access token. The IaaS Token is separate from this — it uses an Opaque-format User Access Key to issue a Fernet token from OpenStack Keystone.

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

    

<a id="issue-iaas-token-with-user-access-key"></a>
## Issue IaaS Token with User Access Key { #issue-iaas-token-with-user-access-key }
> `POST /iaas-tokens/v3/auth/tokens`

You can issue an authentication token for the basic infrastructure service (IaaS) using a User Access Key. Use the issued IaaS Token to call APIs for controlling infrastructure resources such as Compute, Block Storage, and Network.

Unlike calling the Identity API of the basic infrastructure service directly, you do not need to configure an API password or check the Tenant ID. Requests and responses follow the OpenStack Keystone v3 specification, so they can also be used with the OpenStack CLI and SDK. For details on how to use IaaS Tokens and service-specific endpoints, see [IaaS Token](./iaas-token/).

!!! tip "Note"
    * The validity time of an IaaS Token issued through this API is fixed at 12 hours and cannot be changed.
    * No separate authentication header is required. Include the User Access Key ID and Secret Access Key in the request body.

<a id="issue-iaas-token-format"></a>
### Issued Token Format { #issue-iaas-token-format }

IaaS tokens are issued in OpenStack Keystone's Fernet format. A Fernet token is a format in which the information required for authentication — such as user, project, role, and expiration time — is encrypted within the token string itself, and the string starts with `gAAAAA`.

* Pass the received value as-is in the `X-Auth-Token` header. Do not attempt to interpret or modify the token contents directly.
* Because this is the standard OpenStack format, you can use it as-is with the OpenStack CLI and SDK.
* This is a different authentication scheme from the User Access Key token (Opaque format).
* You must use a Fernet-format IaaS token for the basic infrastructure service APIs.
* For all other NHN Cloud Public APIs, you must use a User Access Key token.
* The token is valid for 12 hours after issuance. The validity time cannot be changed.
* When the token expires, it must be reissued.

<a id="issue-iaas-token-prerequisites"></a>
### Prerequisites { #issue-iaas-token-prerequisites }

* Only **Opaque type** User Access Keys can be used. IaaS Tokens cannot be issued with JWT type User Access Keys.
* The Instance or Object Storage service must be enabled in the project for which you want to issue a token.
* The account that created the User Access Key must have permission for the relevant project.

<a id="issue-iaas-token-request"></a>
### Request { #issue-iaas-token-request }

| Category       | Name                                   | Type   | Required | Value             | Description                                                                                                            |
|--------------|--------------------------------------|--------|-----|------------------|---------------------------------------------------------------------------------------------------------------|
| Header       | Content-Type                         | String | Yes | application/json |                                                                                                                 |
| Request Body | auth.identity.methods                | Array  | Yes | ["password"]     | List of authentication methods. Only `password` is supported.                                                                                   |
| Request Body | auth.identity.password.user.id       | String | Yes |                  | User Access Key ID                                                                                              |
| Request Body | auth.identity.password.user.password | String | Yes |                  | Secret Access Key                                                                                               |
| Request Body | auth.scope.project.id                | String | Yes |                  | AppKey of the service for which the token is to be issued. Uses the AppKey of Instance or Object Storage, and identifies the Target project with this AppKey. For information on how to check the AppKey, see [Appkey](./appkey/). |

<a id="issue-iaas-token-response"></a>
### Response { #issue-iaas-token-response }

The issued IaaS Token is returned in the `X-Subject-Token` header, not in the response body. This value is an OpenStack Keystone Fernet token, and you use it as-is in the `X-Auth-Token` header to call APIs for controlling infrastructure resources.

| Category | Name               | Type   | Description                                                      |
|----------|--------------------|--------|------------------------------------------------------------------|
| Header   | X-Subject-Token    | String | Issued IaaS Token (OpenStack Keystone Fernet token)                                                |
| Body     | token.issued_at    | String | Token issuance time                                              |
| Body     | token.expires_at   | String | Token expiration time. This is 12 hours after the issuance time. |
| Body     | token.project      | Object | Information about the project to which the token applies         |
| Body     | token.user         | Object | Information about the user who received the token                |
| Body     | token.roles        | Array  | List of roles assigned to the user in the project                |
| Body     | token.catalog      | Array  | List of available service endpoints                              |

<a id="issue-iaas-token-request-example"></a>
### Request Example { #issue-iaas-token-request-example }

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
### Response Examples { #issue-iaas-token-response-example }

* Response Header

```
HTTP/1.1 201 Created
Content-Type: application/json
X-Subject-Token: gAAAAABnDqW1x3TQZ8kP2mN7vL4hR9sE6yU1aI0oF5cB3dG7jK2nM8pQ4rS6tV9wX1zY
```

* Response Body

<details><summary>Example</summary>
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
### Error Response { #issue-iaas-token-error-response }

If an error occurs, an error response in the OpenStack Keystone specification is returned.

| HTTP Status Code | Description |
|---------------------------|------------------------------------------------------------------------|
| 400 Bad Request | The request format is invalid. |
| 401 Unauthorized | The User Access Key or Secret Access Key is invalid, or a token cannot be issued with the requested AppKey. |
| 500 Internal Server Error | An internal server error has occurred. |

```json
{
  "error": {
    "code": 401,
    "message": "The request you have made requires authentication.",
    "title": "Unauthorized"
  }
}
```

!!! danger "Caution"
    * If the User Access Key or Secret Access Key does not match, or if the User Access Key is disabled, a token will not be issued.
    * If the service is not enabled in the project of the requested AppKey, a token will not be issued.
    * If a user loses their permissions within a project, the issued IaaS Token can no longer be used.
