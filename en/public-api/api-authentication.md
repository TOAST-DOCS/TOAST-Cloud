## NHN Cloud > Public API > API Call and Authentication

### Authentication Token
A token of type Bearer for user authentication. Tokens are valid for a default of one day, which can be changed via the provided framework API. If changed, the next token issued will reflect that expiration time.

### Flowchart
#### Issue Token and Call Public API
![img001.png](http://static.toastoven.net/toast/public_api/img01_KO.jpg)

#### Reissue on token expiration
![img002.png](http://static.toastoven.net/toast/public_api/img02_KO.jpg)


### Authentication server domain
`https://oauth.api.nhncloudservice.com/`

### API
#### Issue Token
##### Prerequisites
Follow the steps below to issue a User Access Key ID and Secret Access Key first.
  1. After logging in to the NHN Cloud Console, click Email address > **API Security Settings** in the upper right corner.
  2. Click **Generate User Access Key ID**
  3. Select **Generate User Access Key ID and Secret Access Key** and click Confirm to issue
     - After issuance, the Secret Access Key should be copied and kept separately.
     - The User Access Key ID can be found on the **API Security Settings** page.
##### Request Token Issuance
> `POST /oauth2/token/create`
* Request

| Category | Name | Type | Required | Value                                     | Description                                                                   |
|---------------|------------- | ------------- | ------------- |-------------------------------------------|--------------------------| 
| Header        |  Content-Type | String | Yes | application/x-www-form-urlencoded         |                                                                        |
| Header        |  Authorization | String | Yes | Basic Base64(UserAccessKeyID:SecretAccessKey) | Use the Base64 encoded result of `UserAccessKeyID:SecretAccessKey` followed by `Basic`  | 
| Request Param |  grant_type | String | Yes | client_credentials                        |                                                                    |

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
##### Case-specific request examples
* curl: When including authentication information in the header
    * Notes: `The dXNlckFjY2Vzc0tleTp1c2VyU2VjcmV0S2V5`in Authorization below is the result of base64 encoding `the UserAccessKeyID:SecretAccessKey`.
```sh
curl --request POST 'https://oauth.api.nhncloudservice.com/oauth2/token/create' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Authorization: Basic dXNlckFjY2Vzc0tleTp1c2VyU2VjcmV0S2V5' \
  -d 'grant_type=client_credentials'
```
* curl: When using the -u option
```sh
curl --request POST 'https://oauth.api.nhncloudservice.com/oauth2/token/create' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -u 'UserAccessKeyID:SecretAccessKey' \
  -d 'grant_type=client_credentials'
```
* FeignClient
```java
@FeignCl ient(name = "auth", url = "https://oauth.api.nhncloudservice.com")
public interface AuthClient {
    @PostMapping(value = "/oauth2/token/create", consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    TokenResponse createToken(@RequestHeader("Authorization") String authorization, @RequestParam("grant_type") String grantType);
}
```
* RestTemplate
```java
@Autowired
private RestTemplate restTemplate;

public TokenResponse createToken(String userAccessKeyID, String secretAccessKey) {
    HttpHeaders headers = new HttpHeaders();
    headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
    headers.setBasicAuth(userAccessKeyID, secretAccessKey);

    MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
    params.add("grant_type", "client_credentials");

    HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(params, headers);

    return restTemplate.postForObject("https://oauth.api.nhncloudservice.com/oauth2/token/create", request, TokenResponse.class);
}
```
* When using OpenFeign on Spring Cloud to automatically issue and renew tokens
  > This method is only possible if you are using Spring Boot 3.0 or later. You will need to implement the part of reissuing the token yourself in case you force it to expire via the API.
  > * In case you force an expiration through APIs, you must **implement the reissue part yourself**.

* 1: Add a dependency
```groovy
dependencies {
  implementation 'org.springframework.boot:spring-boot-starter-oauth2-client'
  implementation 'org.springframework.cloud:spring-cloud-starter-openfeign'
}
```

* 2: Define a Feign client
```java
@FeignClient(name = "publicApiClient", url = "https://core.api.nhncloudservice.com")
public interface ExampleApiClient {
  @GetMapping("/v1/organizations")
  String getOrganizations();
}
```

* 3: Security Settings
> The following is an example and should be changed to match your actual security settings.
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

* 4: Set up the oauth2 client and feign
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
  
  /** * /** * AuthorizedClientManager.
  * Interceptor for sending the automatically issued token in the request header when making a Feign request.
  */
  @Bean
  public RequestInterceptor oAuth2AccessTokenInterceptor(OAuth2AuthorizedClientManager authorizedClientManager) {
    // Requests the issued token in the x-nhn-authorization header when making a public API request.
    return new OAuth2AccessTokenInterceptor("Bearer", "x-nhn-authorization", "TokenClient", authorizedClientManager);
  }
}
```
#### Request token expiration
> `POST /oauth2/token/revoke`
* Request

  | Category | Name | Type | Required | Value | Description   |
  |---------------|------------- | ------------- | ------------- |-------------------------------------------|---|
  | Header        |  Content-Type | String | Yes | application/x-www-form-urlencoded         |         |
  | Header        |  Authorization | String | Yes | Basic Base64(UserAccessKeyID:SecretAccessKey) | Use the Base64 encoded result of `UserAccessKeyID:SecretAccessKey` followed by `Basic`  |
  | Request Param |  token | String| Yes | access token    | Issued token    |

* Response
    * HttpStatus 200

##### Case-specific request examples 
* curl: When including authentication information in the header
```sh
curl --request POST 'https://oauth.api.nhncloudservice.com/oauth2/token/revoke' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Authorization: Basic dXNlckFjY2Vzc0tleTp1c2VyU2VjcmV0S2V5' \
  -d 'token=luzocEoQ3tyMvM6pLtoSTHSphgJSGhl5hVvgSstdVQ1X1bZnf9AEMGAcSERIi1Dq0bybSMv0raOcahZjYpZ2biaaoF3jTi9caF5M2TN9F98iZawbBJmN94CPF2Rpe0JI'
```
* curl: When using the -u option
```sh
curl --request POST 'https://oauth.api.nhncloudservice.com/oauth2/token/revoke' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -u 'UserAccessKeyID:SecretAccessKey' \
  -d 'token=luzocEoQ3tyMvM6pLtoSTHSphgJSGhl5hVvgSstdVQ1X1bZnf9AEMGAcSERIi1Dq0bybSMv0raOcahZjYpZ2biaaoF3jTi9caF5M2TN9F98iZawbBJmN94CPF2Rpe0JI'
```
* FeignClient
```java
@FeignClient(name = "auth", url = "https://oauth.api.nhncloudservice.com")
public interface AuthClient {
    @PostMapping(value = "/oauth2/token/revoke", consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    void revokeToken(@RequestHeader("Authorization") String authorization, @RequestParam("token") String token);
}
```
* RestTemplate
```java
@Autowired
private RestTemplate restTemplate;

public void revokeToken(String userAccessKeyID, String secretAccessKey, String token) {
    HttpHeaders headers = new HttpHeaders();
    headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
    headers.setBasicAuth(userAccessKeyID, secretAccessKey);

    MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
    params.add("token", token);

    HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(params, headers);

    restTemplate.postForObject("https://oauth.api.nhncloudservice.com/oauth2/token/revoke", request, Void.class);
}
```

### Use Token
When calling the framework API, a token is included in the `x-nhn-authentication` header to authenticate the caller.<br>
Example
```shell
curl -X GET "https://core.api.nhncloudservice.com/v1.0/organizations" -H "x-nhn-authentication: Bearer {token}"
```

### Error Code
* Error codes that may be returned when calling the token issuance and token expiration request APIs
  * Returns the same error code as [The OAuth 2.0 Authorization Framework](https://datatracker.ietf.org/doc/html/rfc6749#section-5.2).
* Possible error codes returned when using tokens
  * Error codes are specified in the [Framework API](framework-api.md) guide.
