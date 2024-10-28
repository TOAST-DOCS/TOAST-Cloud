## NHN Cloud > Public API > API 호출 및 인증

### 인증 토큰
사용자 인증을 위한 Bearer 타입의 토큰입니다. 토큰은 기본 1시간 동안 유효하며, 이 시간은 제공되는 프레임워크 API를 통해 변경할 수 있습니다. 변경 시 다음에 발급되는 토큰부터 해당 만료 시간이 반영됩니다.

### 전체 흐름도
#### 토큰 발급 및 Public API 호출
![img001.png](http://static.toastoven.net/toast/public_api/img01_KO.jpg)

#### 토큰 만료 시 재발급
![img002.png](http://static.toastoven.net/toast/public_api/img02_KO.jpg)


### 인증 서버 도메인
`https://oauth.api.gov-nhncloudservice.com/`

### API
#### 토큰 발급
##### 사전 작업
아래 방법에 따라 User Access Key ID와 Secret Access Key를 우선 발급합니다.
  1. NHN Cloud 콘솔 로그인 후 오른쪽 상단의 메일 주소 > **API 보안 설정** 메뉴 클릭
  2. **User Access Key ID 생성** 버튼 클릭
  3. **User Access Key ID와 Secret Access Key 생성**을 선택하고 확인 클릭하여 발급
     - 발급 후 Secret Access Key는 복사하여 별도 보관해야 합니다.
     - User Access Key ID는 **API 보안 설정** 페이지에서 확인 가능합니다.
##### 토큰 발급 요청
> `POST /oauth2/token/create`
* 요청

    | 구분 | 이름 | 타입 | 필수 | 값                                     | 설명                                                                   |
    |---------------|------------- | ------------- | ------------- |-------------------------------------------|------------------------------------------------------------------------| 
    | Header        |  Content-Type | String | Yes | application/x-www-form-urlencoded         |                                                                        |
    | Header        |  Authorization | String | Yes | Basic Base64(UserAccessKeyID:SecretAccessKey) | `UserAccessKeyID:SecretAccessKey` 를 Base64 인코딩한 결과를 `Basic ` 뒤에 붙여서 사용 || 
    | Request Param |  grant_type | String | Yes | client_credentials                        |                                                                    |

* 응답

  | Name | Type        | Required | Description |
      |------------ |-------------| ------------- | ------------ |
  | Request Param |  grant_type | String | Yes | client_credentials                        |                                                     |   access_token | String  | Yes | 발급된 Bearer 타입의 인증 토큰  |                   |
  |   token_type | String  | Yes | 토큰의 타입  |
  |   expires_in | String  | Yes | 만료까지 남은 초 단위 시간을 의미하며 기본은 86,400초(하루)임  |
  ```json
  {
    "access_token":"luzocEoQ3tyMvM6pLtoSTHSphgJSGhl5hVvgSstdVQ1X1bZnf9AEMGAcSERIi1Dq0bybSMv0raOcahZjYpZ2biaaoF3jTi9caF5M2TN9F98iZawbBJmN94CPF2Rpe0JI",
    "token_type":"Bearer",
    "expires_in":86400
  }
  ```
* 케이스별 요청 예시
    * curl
      * Header에 인증 정보를 포함하는 경우
        ```sh
        curl --request POST 'https://oauth.api.gov-nhncloudservice.com/oauth2/token/create' \
          -H 'Content-Type: application/x-www-form-urlencoded' \
          -H 'Authorization: Basic dXNlckFjY2Vzc0tleTp1c2VyU2VjcmV0S2V5' \
          -d 'grant_type=client_credentials'
        ```
        * 참고: `dXNlckFjY2Vzc0tleTp1c2VyU2VjcmV0S2V5`는 `UserAccessKeyID:SecretAccessKey`를 base64 인코딩한 결과입니다.
      * -u 옵션을 사용하는 경우
        ```sh
        curl --request POST 'https://oauth.api.gov-nhncloudservice.com/oauth2/token/create' \
          -H 'Content-Type: application/x-www-form-urlencoded' \
          -u 'UserAccessKeyID:SecretAccessKey' \
          -d 'grant_type=client_credentials'
        ```
  * FeignClient
    ```java
    @FeignClient(name = "auth", url = "https://oauth.api.gov-nhncloudservice.com")
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

        return restTemplate.postForObject("https://oauth.api.gov-nhncloudservice.com/oauth2/token/create", request, TokenResponse.class);
    }
    ```
  * Spring Cloud의 OpenFeign을 사용하여 자동으로 토큰을 발급 및 갱신하는 경우
    > 이 방법은 Spring Boot 3.0 이상 버전을 사용하는 경우에만 가능합니다. API를 통해 강제로 만료시킨 경우를 대비하기 위해서는 토큰을 다시 발급하는 부분을 직접 구현해야 합니다.
    > * API 를 통해 강제로 만료시킨 경우를 대비하기 위해선 토큰을 다시 발급하는 부분을 **직접 구현**해야 합니다.
    1. 의존성 추가
        ```groovy
        dependencies {
          implementation 'org.springframework.boot:spring-boot-starter-oauth2-client'
          implementation 'org.springframework.cloud:spring-cloud-starter-openfeign'
        }
        ```
    2. Feign 클라이언트 정의
        ```java
        @FeignClient(name = "publicApiClient", url = "https://core.api.gov-nhncloudservice.com")
        public interface ExampleApiClient {
          @GetMapping("/v1/organizations")
          String getOrganizations();
        }
        ```
    3. 보안 설정
       > 아래는 예시이며, 실제 사용하시는 보안 설정에 맞게 변경하셔야 합니다.
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
    4. oauth2 클라이언트 및 feign 설정
       ```java
       @Configuration
       public class Oauth2Config {

          @Bean
          public ClientRegistrationRepository clientRegistrationRepository() {
          	ClientRegistration clientRegistration = ClientRegistration.withRegistrationId("TokenClient")
                                                                         .clientId("UserAccessKeyID")
                                                                         .clientSecret("SecretAccessKey")
                                                                         .authorizationGrantType(AuthorizationGrantType.CLIENT_CREDENTIALS)
                                                                         .tokenUri("https://oauth.api.gov-nhncloudservice.com/oauth2/token/create")
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
#### 토큰 만료 요청
> `POST /oauth2/token/revoke`
* 요청

  | 구분 | 이름 | 타입 | 필수 | 값 | 설명   |
  |---------------|------------- | ------------- | ------------- |-------------------------------------------|---|
  | Header        |  Content-Type | String | Yes | application/x-www-form-urlencoded         |         |
  | Header        |  Authorization | String | Yes | Basic Base64(UserAccessKeyID:SecretAccessKey) | `UserAccessKeyID:SecretAccessKey` 를 Base64 인코딩한 결과를 `Basic ` 뒤에 붙여서 사용 |
  | Request Param |  token | String| Yes | access token    | 발급받은 토큰    |

* 응답 
  * HttpStatus 200

* 케이스별 요청 예시 
  * curl 
    * Header에 인증 정보를 포함하는 경우
      ```sh
      curl --request POST 'https://oauth.api.gov-nhncloudservice.com/oauth2/token/revoke' \
        -H 'Content-Type: application/x-www-form-urlencoded' \
        -H 'Authorization: Basic dXNlckFjY2Vzc0tleTp1c2VyU2VjcmV0S2V5' \
        -d 'token=luzocEoQ3tyMvM6pLtoSTHSphgJSGhl5hVvgSstdVQ1X1bZnf9AEMGAcSERIi1Dq0bybSMv0raOcahZjYpZ2biaaoF3jTi9caF5M2TN9F98iZawbBJmN94CPF2Rpe0JI'
      ```
    * -u 옵션을 사용하는 경우
      ```sh
      curl --request POST 'https://oauth.api.gov-nhncloudservice.com/oauth2/token/revoke' \
        -H 'Content-Type: application/x-www-form-urlencoded' \
        -u 'UserAccessKeyID:SecretAccessKey' \
        -d 'token=luzocEoQ3tyMvM6pLtoSTHSphgJSGhl5hVvgSstdVQ1X1bZnf9AEMGAcSERIi1Dq0bybSMv0raOcahZjYpZ2biaaoF3jTi9caF5M2TN9F98iZawbBJmN94CPF2Rpe0JI'
      ```
  * FeignClient
    ```java
    @FeignClient(name = "auth", url = "https://oauth.api.gov-nhncloudservice.com")
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
    
        restTemplate.postForObject("https://oauth.api.gov-nhncloudservice.com/oauth2/token/revoke", request, Void.class);
    }
    ```

### 토큰 사용
프레임워크 API 호출 시, 호출자 인증을 위해 `x-nhn-authentication` 헤더에 토큰을 담아서 요청 시 사용합니다.
예시
  ```shell
  curl -X GET "https://core.api.gov-nhncloudservice.com/v1.0/organizations" -H "x-nhn-authentication: Bearer {token}"
  ```

### 오류 코드
* 토큰 발급 및 토큰 만료 요청 API 호출 시 반환될 수 있는 오류 코드
  * [The OAuth 2.0 Authorization Framework](https://datatracker.ietf.org/doc/html/rfc6749#section-5.2)와 동일한 오류 코드를 반환합니다.
* 토큰 사용 시 반환될 수 있는 오류 코드
  * 오류 코드는 [프레임워크 API](framework-api.md) 가이드에서 명시하고 있습니다.
