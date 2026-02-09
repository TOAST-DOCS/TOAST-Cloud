# User Access Key Token

**NHN Cloud > Public API User Guide > API Authentication Methods > User Access Key Token**

User Access Key tokens are temporary Bearer tokens issued based on a User Access Key. A Bearer token is a type of security token that grants access to any party in possession of the token. By setting an expiration time, you can ensure the security of your resources.
These tokens operate using Attribute-Based Access Control (ABAC). When using a token, the specific roles and permissions assigned to the NHN Cloud or IAM account are applied, restricting API calls to the authorized scope of that account. Furthermore, you can achieve fine-grained access control by configuring detailed role conditions.

## Overview of User Access Key Token Issuance and Public API Calls

Issuing a User Access Key token and calling the API works in the following flow:

### Issue new tokens and making API calls

![img001.png](http://static.toastoven.net/toast/public_api/img01_EN.png)

### Reissue and API calls on token expiration

![img002.png](http://static.toastoven.net/toast/public_api/img02_EN.png)


Issued tokens are valid only during their expiration period (default: 24 hours) and must be reissued upon expiration. If a token is leaked or suspected to be compromised, you must revoke it immediately and reissue a new one if necessary.


!!! tip "Note"
    You can modify the Token Expiration Time in the **API Security Settings** menu of the NHN Cloud Console.
    The expiration time can be set between 60 seconds and 86,400 seconds (24 hours).
    Changes to the expiration time do not affect tokens issued prior to the update. The new setting will only apply to tokens issued after the modification is saved.


## Prerequisites

To issue a User Access Key Token, you must first generate a User Access Key ID and Secret Access Key. You can view and manage token information for each User Access Key in the **API Security Settings** menu of the NHN Cloud Console.

1) In the drop-down menu that appears when you hover over your account in the upper-right corner of the NHN Cloud console, click **API Security Settings**.

2) Click **+ Create User Access Key ID**<br>
![C_userAccessKey_1_en](http://static.toastoven.net/toast/public_api/C_userAccessKey_1_en.png)

3) In the **Create User Access Key** modal window, set the **Token Expiration Time**, and then click **Create**.<br>
![C_userAccessKey_2_en](http://static.toastoven.net/toast/public_api/C_userAccessKey_2_en.png)

4) In the **User Access Key Issued** modal, copy the **Secret Access Key** and then click **OK**.<br>
![C_userAccessKey_3_en](http://static.toastoven.net/toast/public_api/C_userAccessKey_3_en.png)


!!! danger "Caution"
    * The Secret Access Key cannot be recovered or viewed once the modal window is closed. If lost, the key must be regenerated; please ensure you copy and store it in a secure location.
    * If either the User Access Key or Secret Access Key is leaked or suspected to be compromised, you must immediately revoke the key and issue a new one.


## Authentication Server Domain
The authentication domain is as follows:

```
https://oauth.api.nhncloudservice.com/
```

## Request User Access Key Token Issuance
> `POST /oauth2/token/create`

* Request

| Category | Name | Type | Required | Value                                     | Description                                                                   |
|---------------|------------- | ------------- | ------------- |-------------------------------------------|--------------------------| 
| Header        |  Content-Type | String | Yes | application/x-www-form-urlencoded         |                                                                        |
| Header        |  Authorization | String | Yes | Basic Base64(UserAccessKeyID:SecretAccessKey) | Use the Base64 encoded result of `UserAccessKeyID:SecretAccessKey` followed by `Basic`  | 
| Request Body |  grant_type | String | Yes | client_credentials                        | <ul><li>Only the client_credentials grant type is currently supported for token issuance</li><li>When requesting a token, use the parameter as follows: `grand_type=client_credentials`</li></ul> |

* Response

| Name         | Type        | Required | Description                            |
|--------------|-------------| ------------- |----------------------------------------|
|  grant_type  | String | Yes | client_credentials                     |   
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

### Case-specific request examples
#### curl: When including authentication information in the header


!!! tip "Notes"
    `The dXNlckFjY2Vzc0tleTp1c2VyU2VjcmV0S2V5`in Authorization below is the result of base64 encoding `the UserAccessKeyID:SecretAccessKey`.


```sh
curl --request POST 'https://oauth.api.nhncloudservice.com/oauth2/token/create' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Authorization: Basic dXNlckFjY2Vzc0tleTp1c2VyU2VjcmV0S2V5' \
  -d 'grant_type=client_credentials'
```

#### curl: When using -u option
```sh
curl --request POST 'https://oauth.api.nhncloudservice.com/oauth2/token/create' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -u 'UserAccessKeyID:SecretAccessKey' \
  -d 'grant_type=client_credentials'
```

#### FeignClient
```java
@FeignClient(name = "auth", url = "https://oauth.api.nhncloudservice.com")
public interface AuthClient {
    @PostMapping(value = "/oauth2/token/create", consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    TokenResponse createToken(@RequestHeader("Authorization") String authorization, @RequestParam("grant_type") String grantType);
}
```

#### RestTemplate
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


## Request User Access Key Token Revocation
> `POST /oauth2/token/revoke`

* Request

  | Category | Name | Type | Required | Value | Description   |
  |---------------|------------- | ------------- | ------------- |-------------------------------------------|---|
  | Header        |  Content-Type | String | Yes | application/x-www-form-urlencoded         |         |
  | Header        |  Authorization | String | Yes | Basic Base64(UserAccessKeyID:SecretAccessKey) | Use the Base64 encoded result of `UserAccessKeyID:SecretAccessKey` followed by `Basic`  |
  | Request Body |  token | String| Yes | access token    | <ul><li>Issued token</li><li>When requesting revocation, use the parameter as follows: `token=issued_token`</li></ul>      |

* Response
    * HttpStatus 200


### Case-specific request examples 
#### curl: When including authentication information in the header
```sh
curl --request POST 'https://oauth.api.nhncloudservice.com/oauth2/token/revoke' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Authorization: Basic dXNlckFjY2Vzc0tleTp1c2VyU2VjcmV0S2V5' \
  -d 'token=luzocEoQ3tyMvM6pLtoSTHSphgJSGhl5hVvgSstdVQ1X1bZnf9AEMGAcSERIi1Dq0bybSMv0raOcahZjYpZ2biaaoF3jTi9caF5M2TN9F98iZawbBJmN94CPF2Rpe0JI'
```

#### curl: When using the -u option
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


## Use User Access Key token
User Access Key token is passed via the HTTP request header. When calling an API, include the User Access Key token in the example header as shown in the example below:

* HTTP header format examples
```
X-NHN-Authorization: Bearer {Access Token}
```

When a user sends a request with a key in the HTTP header, the server validates the token and then approves or rejects the request.


!!! tip "Note"
    User Access Key Tokens return the same error codes as defined in [The OAuth 2.0 Authorization Framework](https://datatracker.ietf.org/doc/html/rfc6749#section-5.2). For details on error codes returned during token issuance, revocation, or usage, please refer to the [Framework API Guide](https://docs.nhncloud.com/ko/nhncloud/ko/public-api/framework-api/#_281).

    
