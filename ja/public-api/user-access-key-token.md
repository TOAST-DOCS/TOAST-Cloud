# User Access Keyトークン

**NHN Cloud > Public API > API認証方式 > User Access Keyトークン**

User Access Key 토큰은 User Access Key를 기반으로 발급되는 Bearer 타입의 일시적 액세스 토큰입니다. Bearer 토큰은 토큰을 소유한 사용자라면 누구나 접근 권한을 부여 받는 보안 토큰의 한 종류로, 유효 기간을 설정할 수 있어 리소스를 안전하게 보호할 수 있습니다.
User Access Key 토큰은 역할 기반 접근 제어 방식(ABAC, attribute-Based Access Control)으로 동작하여 토큰을 사용할 경우 NHN Cloud 계정 또는 IAM 계정에 부여된 역할 및 권한이 적용됩니다. 따라서 호출 가능한 API가 해당 계정의 역할 및 권한 범위 내로 제한됩니다. 또한 역할 상세 조건을 설정하여 정밀한 접근 제어가 가능합니다.

## User Access Key 토큰 발급 및 Public API 호출 개요

User Access Key 토큰 발급 및 API 호출은 다음과 같은 흐름으로 동작합니다.

### 신규 토큰 발급 및 API 호출

![img001.png](http://static.toastoven.net/toast/public_api/img01_JA.png)

### 토큰 만료 시 재발급 및 API 호출

![img002.png](http://static.toastoven.net/toast/public_api/img02_JA.png)

발급한 토큰은 유효 기간 동안만 사용할 수 있으며(기본값: 24시간), 만료 후에는 새로 발급해야 합니다. 토큰이 유출되었거나 유출이 의심되는 경우 해당 토큰을 즉시 만료 처리하고 필요시 재발급해야 합니다.

!!! tip "알아두기"
    토큰의 유효 시간은 NHN Cloud 콘솔의 **API 보안 설정** 메뉴에서 변경할 수 있습니다.
    토큰 유효 시간은 60초~86,400초(24시간) 내에서 설정할 수 있습니다.
    유효 시간을 수정하기 전에 발급된 토큰의 유효 시간은 변경되지 않으며, 토큰 유효 시간 수정 후 신규로 발급하는 토큰부터 변경된 토큰 유효 시간이 적용됩니다.

## 인증 서버 도메인
인증 서버의 도메인은 다음과 같습니다.
https://oauth.api.nhncloudservice.com/

## 사전 작업

User Access Key 토큰을 발급하려면 먼저 User Access Key ID와 Secret Access Key를 먼저 발급해야 합니다. NHN Cloud 콘솔의 **API 보안 설정** 메뉴에서 User Access Key별 토큰 정보를 확인하고 관리할 수 있습니다.

1. NHN Cloud 콘솔에서 우측 상단의 계정에 마우스 포인터를 올리면 표시되는 드롭다운 메뉴에서 **API 보안 설정**을 클릭합니다.
2. **+ User Access Key 생성**을 클릭합니다.<br>
![C_userAccessKey_1_ja](http://static.toastoven.net/toast/public_api/C_userAccessKey_1_ja.png)
3. **User Access Key 생성** 모달 창에서 **토큰 유효 시간**을 설정한 뒤 **생성**을 클릭합니다.<br>
![C_userAccessKey_2_ja](http://static.toastoven.net/toast/public_api/C_userAccessKey_2_ja.png)
4. **User Access Key 발급 완료** 모달 창에서 **Secret Access Key**를 복사한 뒤 **확인**을 클릭합니다.<br>
![C_userAccessKey_3_ja](http://static.toastoven.net/toast/public_api/C_userAccessKey_3_ja.png)

!!! danger "주의"
    * 모달 창을 닫은 뒤에는 Secret Access Key를 다시 확인할 수 없습니다. Secret Access Key를 잊어버릴 경우 재생성해야 하므로 반드시 복사한 뒤 별도로 관리하세요.
    * User Access Key 또는 Secret Access Key 중 하나라도 유출되었거나 유출이 의심되는 경우 해당 키를 폐기하고 새로 발급 받아야 합니다.

## User Access Key 토큰 발급 요청하기
> `POST /oauth2/token/create`

* リクエスト

| 区分 | 名前 | タイプ | 必須 | 値                                    | 説明                                                                  |
|---------------|------------- | ------------- | ------------- |-------------------------------------------|--------------------------| 
| Header        |  Content-Type | String | Yes | application/x-www-form-urlencoded         |                                                                        |
| Header        |  Authorization | String | Yes | Basic Base64(UserAccessKeyID:SecretAccessKey) | `UserAccessKeyID:SecretAccessKey`をBase64エンコードした結果を`Basic`の後ろに貼り付けて使用 | 
| Request Body |  grant_type | String | Yes | client_credentials                        | <ul><li>トークン発行grant_typeはclient_credentialsのみ提供されている</li><li>発行リクエスト時に`grand_type=client_credentials`のように使用</li></ul> |

* レスポンス

| 名前        | タイプ       | 必須 | 説明                           |
|--------------|-------------| ------------- |----------------------------------------|
|  grant_type  | String | Yes | client_credentials                     |   
| access_token | String  | Yes | 発行されたBearerタイプの認証トークン               | 
| token_type   | String  | Yes | トークンのタイプ                                |
| expires_in   | String  | Yes | 有効期限までの残り秒単位時間を意味し、デフォルトは86,400秒(1日)です。 |

```json
{
    "access_token":"luzocEoQ3tyMvM6pLtoSTHSphgJSGhl5hVvgSstdVQ1X1bZnf9AEMGAcSERIi1Dq0bybSMv0raOcahZjYpZ2biaaoF3jTi9caF5M2TN9F98iZawbBJmN94CPF2Rpe0JI",
    "token_type":"Bearer",
    "expires_in":86400
}
```
### ケース別リクエスト例
#### curl: Headerに認証情報を含む場合

!!! tip "参考"
    以下のAuthorizationにある`dXNlckFjY2Vzc0tleTp1c2VyU2VjcmV0S2V5`は`UserAccessKeyID:SecretAccessKey`をbase64エンコードした 結果です。

```sh
curl --request POST 'https://oauth.api.nhncloudservice.com/oauth2/token/create' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Authorization: Basic dXNlckFjY2Vzc0tleTp1c2VyU2VjcmV0S2V5' \
  -d 'grant_type=client_credentials'
```
#### curl: -uオプションを使用する場合
```sh
curl --request POST 'https://oauth.api.nhncloudservice.com/oauth2/token/create' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -u 'UserAccessKeyID:SecretAccessKey' \
  -d 'grant_type=client_credentials'
```
#### FeignClient
```java
@FeignCl ient(name = "auth", url = "https://oauth.api.nhncloudservice.com")
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
#### Spring CloudのOpenFeignを使用して自動的にトークンを発行及び更新する場合

!!! tip "参考"
    * この方法はSpring Boot 3.0以上のバージョンを使用する場合のみ可能です。
    * APIを利用して強制的に期限切れにした場合に備えて、トークンを再発行する部分を直接実装する必要があります。

1. 依存関係追加
```groovy
dependencies {
  implementation 'org.springframework.boot:spring-boot-starter-oauth2-client'
  implementation 'org.springframework.cloud:spring-cloud-starter-openfeign'
}
```

2. Feignクライアント定義
```java
@FeignClient(name = "publicApiClient", url = "https://core.api.nhncloudservice.com")
public interface ExampleApiClient {
  @GetMapping("/v1/organizations")
  String getOrganizations();
}
```

3. セキュリティ設定
> 以下は例であり、実際使うセキュリティ設定に合わせて変更する必要があります。
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

4. oauth2クライアント及びfeign設定
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
  * Feignリクエスト時、自動的に発行されたトークンを自動的にリクエストヘッダに入れて送るためのインターセプター
  */
  @Bean
  public RequestInterceptor oAuth2AccessTokenInterceptor(OAuth2AuthorizedClientManager authorizedClientManager) {
    // Public APIリクエスト時、発行されたトークンをx-nhn-authorizationヘッダに入れてリクエストする必要があります。
    return new OAuth2AccessTokenInterceptor("Bearer", "x-nhn-authorization", "TokenClient", authorizedClientManager);
  }
}
```
## User Access Key 토큰 만료 요청하기
> `POST /oauth2/token/revoke`

* リクエスト

  | 区分 | 名前 | タイプ | 必須 | 値 | 説明  |
  |---------------|------------- | ------------- | ------------- |-------------------------------------------|---|
  | Header        |  Content-Type | String | Yes | application/x-www-form-urlencoded         |         |
  | Header        |  Authorization | String | Yes | Basic Base64(UserAccessKeyID:SecretAccessKey) | `UserAccessKeyID:SecretAccessKey`をBase64エンコードした結果を`Basic`の後ろに貼り付けて使用 |
  | Request Body |  token | String| Yes | access token    | <ul><li>発行されたトークン</li><li>期限切れリクエスト時に`token=発行された_トークン`のように使用</li></ul>      |

* レスポンス
    * HttpStatus 200

### ケース別リクエスト例 
#### curl: Headerに認証情報を含む場合

```sh
curl --request POST 'https://oauth.api.nhncloudservice.com/oauth2/token/revoke' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Authorization: Basic dXNlckFjY2Vzc0tleTp1c2VyU2VjcmV0S2V5' \
  -d 'token=luzocEoQ3tyMvM6pLtoSTHSphgJSGhl5hVvgSstdVQ1X1bZnf9AEMGAcSERIi1Dq0bybSMv0raOcahZjYpZ2biaaoF3jTi9caF5M2TN9F98iZawbBJmN94CPF2Rpe0JI'
```
#### curl: -uオプションを使用する場合
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

!!! tip "알아두기"
    User Access Key 토큰은 오류 발생 시 [The OAuth 2.0 Authorization Framework](https://datatracker.ietf.org/doc/html/rfc6749#section-5.2)와 동일한 오류 코드를 반환합니다. 토큰 요청 API 호출, 토큰 만료 요청 API 호출, 토큰 사용 등의 상황에 반환될 수 있는 오류 코드는 [フレームワークAPI](https://docs.nhncloud.com/ja/nhncloud/ja/public-api/framework-api/#_281)에서 확인할 수 있습니다.

    