# User Access Keyトークン

**NHN Cloud > Public API使用ガイド > API認証方式 > User Access Keyトークン**

User Access Keyトークンは、User Access Keyに基づいて発行されるBearerタイプの一時的なアクセストークンです。Bearerトークンは、トークンを所有するユーザーであれば誰でもアクセス権限が付与されるセキュリティトークンの一種で、有効期限を設定できるためリソースを安全に保護できます。
User Access Keyトークンは、属性ベースのアクセス制御方式(ABAC, Attribute-Based Access Control)で動作し、トークンを使用する場合、NHN CloudアカウントまたはIAMアカウントに付与されたロール及び権限が適用されます。したがって、呼び出し可能なAPIは、そのアカウントのロール及び権限の範囲内に制限されます。また、ロールの詳細条件を設定することで精密なアクセス制御が可能です。

## User Access Keyトークンの発行及びPublic API呼び出しの概要

User Access Keyトークンの発行及びAPI呼び出しは、次のようなフローで動作します。

### 新規トークン発行及びAPI呼び出し

![img001.png](http://static.toastoven.net/toast/public_api/img01_JA.png)

### トークン期限切れ時の再発行及びAPI呼び出し

![img002.png](http://static.toastoven.net/toast/public_api/img02_JA.png)


発行されたトークンは有効期間中のみ使用でき(デフォルト: 24時間)、期限切れ後は新たに発行する必要があります。トークンが流出した、または流出が疑われる場合、そのトークンを直ちに失効処理し、必要に応じて再発行する必要があります。


!!! tip "ポイント"
    トークンの有効期間は、NHN Cloudコンソールの **APIセキュリティ設定** メニューで変更できます。
    トークンの有効期間は60秒～86,400秒(24時間)以内で設定できます。
    有効期間を変更する前に発行されたトークンの有効期間は変更されず、トークン有効期間の変更後に新規発行されるトークンから変更後の有効期間が適用されます。


## 事前作業

User Access Keyトークンを発行するには、まずUser Access Key IDとSecret Access Keyを発行する必要があります。NHN Cloudコンソールの **APIセキュリティ設定** メニューで、User Access Keyごとのトークン情報を確認及び管理できます。

1) NHN Cloudコンソールの右上にあるアカウントにマウスカーソルを合わせると表示されるドロップダウンメニューから **APIセキュリティ設定** をクリックします。

2) **+ User Access Key作成**をクリックします。<br>
![C_userAccessKey_1_ja](http://static.toastoven.net/toast/public_api/C_userAccessKey_1_ja.png)

3) **User Access Key作成** モーダルウィンドウで **トークン有効期間**を設定した後、**作成** をクリックします。<br>
![C_userAccessKey_2_ja](http://static.toastoven.net/toast/public_api/C_userAccessKey_2_ja.png)

4) **User Access Key発行完了** モーダルウィンドウで **Secret Access Key**をコピーした後 **確認**をクリックします。<br>
![C_userAccessKey_3_ja](http://static.toastoven.net/toast/public_api/C_userAccessKey_3_ja.png)


!!! danger "注意"
    * モーダルウィンドウを閉じた後は、Secret Access Keyを再度確認することはできません。Secret Access Keyを忘れた場合は再作成が必要になるため、必ずコピーして別途管理してください。
    * User Access KeyまたはSecret Access Keyのいずれかでも流出した、または流出が疑われる場合、そのキーを破棄して新たに発行する必要があります。


## 認証サーバードメイン
認証サーバーのドメインは次のとおりです。

```
https://oauth.api.nhncloudservice.com/
```


## User Access Keyトークンの発行リクエスト
> `POST /oauth2/token/create`

* リクエスト

| 区分 | 名前 | タイプ | 必須 | 値                                     | 説明                                                                   |
|---------------|------------- | ------------- | ------------- |-------------------------------------------|--------------------------| 
| Header        |  Content-Type | String | Yes | application/x-www-form-urlencoded         |                                                                        |
| Header        |  Authorization | String | Yes | Basic Base64(UserAccessKeyID:SecretAccessKey) | `UserAccessKeyID:SecretAccessKey` をBase64エンコードした結果を `Basic ` の後ろに付けて使用 |
| Request Body |  grant_type | String | Yes | client_credentials                        | <ul><li>トークン発行grant_typeはclient_credentialsのみ提供されている</li><li>発行リクエスト時に `grand_type=client_credentials` のように使用</li></ul> |

* レスポンス

| 名前        | タイプ       | 必須 | 説明                           |
|--------------|-------------| ------------- |----------------------------------------|
|  grant_type  | String | Yes | client_credentials                     |   
| access_token | String  | Yes | 発行された Bearerタイプの認証トークン                  | 
| token_type   | String  | Yes | トークンのタイプ                                |
| expires_in   | String  | Yes | 期限切れまでの残り時間(秒単位)を意味し、デフォルトは86,400秒(1日) |

```json
{
    "access_token":"luzocEoQ3tyMvM6pLtoSTHSphgJSGhl5hVvgSstdVQ1X1bZnf9AEMGAcSERIi1Dq0bybSMv0raOcahZjYpZ2biaaoF3jTi9caF5M2TN9F98iZawbBJmN94CPF2Rpe0JI",
    "token_type":"Bearer",
    "expires_in":86400
}
```

### ケース別リクエスト例
#### curl: Headerに認証情報を含める場合


!!! tip "参考"
    以下のAuthorizationにある `dXNlckFjY2Vzc0tleTp1c2VyU2VjcmV0S2V5` は、`UserAccessKeyID:SecretAccessKey` をbase64エンコードした結果です。


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

#### Spring CloudのOpenFeignを使用して自動的にトークンを発行及び更新する場合


!!! tip "参考"
    * この方法は、Spring Boot 3.0以上のバージョンを使用する場合にのみ可能です。
    * APIを利用して強制的に期限切れにした場合に備えるには、トークンを再発行する部分を直接実装する必要があります。


1) 依存関係の追加
```groovy
dependencies {
  implementation 'org.springframework.boot:spring-boot-starter-oauth2-client'
  implementation 'org.springframework.cloud:spring-cloud-starter-openfeign'
}
```


2) Feignクライアント定義
```java
@FeignClient(name = "publicApiClient", url = "https://core.api.nhncloudservice.com")
public interface ExampleApiClient {
  @GetMapping("/v1/organizations")
  String getOrganizations();
}
```

3) セキュリティ設定
以下は例であり、実際に使用するセキュリティ設定に合わせて変更する必要があります。
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

4) oauth2クライアント及びfeign設定
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
  * Feignリクエスト時に自動発行されたトークンをリクエストヘッダに自動的に含めて送信するためのインターセプター
  */
  @Bean
  public RequestInterceptor oAuth2AccessTokenInterceptor(OAuth2AuthorizedClientManager authorizedClientManager) {
    // Public APIリクエスト時、発行されたトークンをx-nhn-authorizationヘッダに含めてリクエストする必要があります。
    return new OAuth2AccessTokenInterceptor("Bearer", "x-nhn-authorization", "TokenClient", authorizedClientManager);
  }
}
```


## User Access Keyトークンの失効リクエスト
> `POST /oauth2/token/revoke`

* リクエスト

| 区分 | 名前 | タイプ | 必須 | 値 | 説明   |
|---------------|------------- | ------------- | ------------- |-------------------------------------------|---|
| Header        |  Content-Type | String | Yes | application/x-www-form-urlencoded         |         |
| Header        |  Authorization | String | Yes | Basic Base64(UserAccessKeyID:SecretAccessKey) | `UserAccessKeyID:SecretAccessKey` をBase64エンコードした結果を `Basic ` の後ろに付けて使用 |
| Request Body |  token | String| Yes | access token    | <ul><li>発行されたトークン</li><li>失効リクエスト時に `token=発行されたトークン` のように使用</li></ul>      |

* レスポンス
    * HttpStatus 200


### ケース別リクエスト例
#### curl: Headerに認証情報を含める場合
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


## User Access Keyトークンの使用
User Access KeyトークンはHTTPリクエストヘッダに含めて送信します。API呼び出し時、以下の例のようにリクエストヘッダにUser Access Keyトークンを設定して呼び出してください。

* HTTPヘッダ形式の例
```
X-NHN-Authorization: Bearer {Access Token}
```

ユーザーがHTTPヘッダにキーを含めてサーバーにリクエストを送信すると、サーバーはトークンの有効性を確認した後、リクエストを承認または拒否します。


!!! tip "参考"
    User Access Keyトークンは、エラー発生時に [The OAuth 2.0 Authorization Framework](https://datatracker.ietf.org/doc/html/rfc6749#section-5.2)と同様のエラーコードを返します。トークンリクエストAPI呼び出し、トークン失効リクエストAPI呼び出し、トークン使用などの状況で返される可能性のあるエラーコードは、[フレームワークAPIガイド](https://docs.nhncloud.com/ko/nhncloud/ko/public-api/framework-api/#_281)で確認できます。

    
