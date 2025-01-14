## NHN Cloud > Public API > API呼び出し及び認証

### 認証トークン
ユーザー認証のためのBearerタイプのトークンです。トークンは基本1日有効で、この時間は提供されるフレームワークAPIを通じて変更できます。変更すると、次に発行されるトークンからその有効期限が反映されます。

### 全体フローチャート
#### トークン発行及びPublic API呼び出し
![img001.png](http://static.toastoven.net/toast/public_api/img01_JA.png)

#### トークン有効期限切れ時の再発行
![img002.png](http://static.toastoven.net/toast/public_api/img02_JA.png)


### 認証サーバードメイン
`https://oauth.api.nhncloudservice.com/`

### API
#### トークン発行
##### 事前作業
以下の方法により、User Access Key IDとSecret Access Keyをまず発行します。
  1. NHN Cloudコンソールにログイン後、右上のメールアドレス > **APIセキュリティ設定**メニューをクリック
  2. **User Access Key ID作成**ボタンをクリック
  3. **User Access Key IDとSecret Access Key作成**を選択し、確認クリックして発行
     - 発行後、Secret Access Keyはコピーして別途保管する必要があります。
     - User Access Key IDは**APIセキュリティ設定**ページで確認できます。
##### トークン発行リクエスト
> `POST /oauth2/token/create`
* リクエスト

| 区分 | 名前 | タイプ | 必須 | 値                                    | 説明                                                                  |
|---------------|------------- | ------------- | ------------- |-------------------------------------------|--------------------------| 
| Header        |  Content-Type | String | Yes | application/x-www-form-urlencoded         |                                                                        |
| Header        |  Authorization | String | Yes | Basic Base64(UserAccessKeyID:SecretAccessKey) | `UserAccessKeyID:SecretAccessKey`をBase64エンコードした結果を`Basic`の後ろに貼り付けて使用 | 
| Request Param |  grant_type | String | Yes | client_credentials                        |                                                                    |

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
##### ケース別リクエスト例
* curl: Headerに認証情報を含む場合
    * 参考: 以下のAuthorizationにある`dXNlckFjY2Vzc0tleTp1c2VyU2VjcmV0S2V5`は`UserAccessKeyID:SecretAccessKey`をbase64エンコードした 結果です。
```sh
curl --request POST 'https://oauth.api.nhncloudservice.com/oauth2/token/create' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Authorization: Basic dXNlckFjY2Vzc0tleTp1c2VyU2VjcmV0S2V5' \
  -d 'grant_type=client_credentials'
```
* curl: -uオプションを使用する場合
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
* Spring CloudのOpenFeignを使用して自動的にトークンを発行及び更新する場合
  > この方法はSpring Boot 3.0以上のバージョンを使用する場合のみ可能です。APIを通じて強制的に期限切れさせた場合に備えて、トークンを再発行する部分を直接実装する必要があります。
  > * APIを通じて強制的に期限切れにした場合に備えて、トークンを再発行する部分を**直接実装**する必要があります。

* 1:依存関係追加
```groovy
dependencies {
  implementation 'org.springframework.boot:spring-boot-starter-oauth2-client'
  implementation 'org.springframework.cloud:spring-cloud-starter-openfeign'
}
```

* 2: Feignクライアント定義
```java
@FeignClient(name = "publicApiClient", url = "https://core.api.nhncloudservice.com")
public interface ExampleApiClient {
  @GetMapping("/v1/organizations")
  String getOrganizations();
}
```

* 3:セキュリティ設定
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

* 4: oauth2クライアント及びfeign設定
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
#### トークン有効期限切れリクエスト
> `POST /oauth2/token/revoke`
* リクエスト

  | 区分 | 名前 | タイプ | 必須 | 値 | 説明  |
  |---------------|------------- | ------------- | ------------- |-------------------------------------------|---|
  | Header        |  Content-Type | String | Yes | application/x-www-form-urlencoded         |         |
  | Header        |  Authorization | String | Yes | Basic Base64(UserAccessKeyID:SecretAccessKey) | `UserAccessKeyID:SecretAccessKey`をBase64エンコードした結果を`Basic`の後ろに貼り付けて使用 |
  | Request Param |  token | String| Yes | access token    | 発行されたトークン |

* レスポンス
    * HttpStatus 200

##### ケース別リクエスト例 
* curl: Headerに認証情報を含む場合
```sh
curl --request POST 'https://oauth.api.nhncloudservice.com/oauth2/token/revoke' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Authorization: Basic dXNlckFjY2Vzc0tleTp1c2VyU2VjcmV0S2V5' \
  -d 'token=luzocEoQ3tyMvM6pLtoSTHSphgJSGhl5hVvgSstdVQ1X1bZnf9AEMGAcSERIi1Dq0bybSMv0raOcahZjYpZ2biaaoF3jTi9caF5M2TN9F98iZawbBJmN94CPF2Rpe0JI'
```
* curl: -uオプションを使用する場合
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

### トークン使用
フレームワークAPIを呼び出す時、呼び出し者認証のため`x-nhn-authentication`ヘッダにトークンを入れてリクエスト時に使用します。<br>
例
```shell
curl -X GET "https://core.api.nhncloudservice.com/v1.0/organizations" -H "x-nhn-authentication: Bearer {token}"
```

### エラーコード
* トークン発行及びトークン有効期限切れリクエストAPI呼び出し時に返される可能性のあるエラーコード
  * [The OAuth 2.0 Authorization Framework](https://datatracker.ietf.org/doc/html/rfc6749#section-5.2)と同じエラーコードを返します。
* トークン使用時に返される可能性のあるエラーコード
  * エラーコードは[フレームワークAPI](framework-api.md)ガイドに記載されています。
