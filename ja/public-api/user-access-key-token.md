<!-- machine_translated: true -->

<!-- pre-align:aligned sig=244a740a7bef -->

# User Access Keyトークン

**NHN Cloud > Public API使用ガイド > API認証方式 > User Access Keyトークン**

User Access Keyトークンは、User Access Keyに基づいて発行されるBearerタイプの一時的なアクセストークンです。Bearerトークンは、トークンを所有するユーザーであれば誰でもアクセス権限が付与されるセキュリティトークンの一種で、有効期限を設定できるためリソースを安全に保護できます。
User Access Keyトークンは、ロールベースのアクセス制御(ABAC、Attribute-Based Access Control)方式で動作し、トークンを使用する場合はNHN CloudアカウントまたはIAMアカウントに付与されたロール及び権限が適用されます。そのため、呼び出し可能なAPIは該当アカウントのロール及び権限の範囲内に制限されます。また、ロールの詳細条件を設定することで、きめ細かいアクセス制御が可能です。

1つのUser Access Keyで、用途に応じて異なる形式のトークンを発行できます。

| トークン形式 | 発行API | 使用先 | 有効時間 | 必要なUser Access Key形式 |
| --- | --- | --- | --- | --- |
| Opaque | `POST /oauth2/token/create` | NHN Cloud Public API全般 | 60秒～24時間(設定可) | Opaque |
| JWT | `POST /oauth2/token/create` | EasyQueueメッセージ送受信 | 60秒～1時間(設定可) | JWT |
| Fernet | `POST /iaas-tokens/v3/auth/tokens` | OpenStackベースのインフラサービス(Compute、Block Storage、Networkなど) | 12時間固定 | Opaque |

User Access Keyを作成する際に選択する形式(Opaque / JWT)は、OAuth 2.0アクセストークンの形式です。IaaSトークンはこれとは別に、Opaque形式のUser Access KeyでOpenStack KeystoneのFernetトークンを発行します。

<a id="overview-of-user-access-key-token-issuance-and-public-api-calls"></a>
## User Access Keyトークンの発行及びPublic API呼び出しの概要 { #overview-of-user-access-key-token-issuance-and-public-api-calls }

User Access Keyトークンの発行及びAPI呼び出しは、次のようなフローで動作します。

<a id="issue-new-tokens-and-making-api-calls"></a>
### 新規トークン発行及びAPI呼び出し { #issue-new-tokens-and-making-api-calls }

![img001.png](http://static.toastoven.net/toast/public_api/img01_JA.png)

<a id="reissue-and-api-calls-on-token-expiration"></a>
### トークン期限切れ時の再発行及びAPI呼び出し { #reissue-and-api-calls-on-token-expiration }

![img002.png](http://static.toastoven.net/toast/public_api/img02_JA.png)


発行されたトークンは有効期間中のみ使用でき(デフォルト: 24時間)、期限切れ後は新たに発行する必要があります。トークンが流出した、または流出が疑われる場合、そのトークンを直ちに失効処理し、必要に応じて再発行する必要があります。


!!! tip "ポイント"
    トークンの有効期間は、NHN Cloudコンソールの **APIセキュリティ設定** メニューで変更できます。
    Opaqueトークンの有効時間は60秒～86,400秒(24時間)の範囲で設定でき、JWTトークンの有効時間は60秒～3,600秒(1時間)の範囲で設定できます。
    有効期間を変更する前に発行されたトークンの有効期間は変更されず、トークン有効期間の変更後に新規発行されるトークンから変更後の有効期間が適用されます。


<a id="prerequisites"></a>
## 事前作業 { #prerequisites }

User Access Keyトークンを発行するには、まずUser Access Key IDとSecret Access Keyを発行する必要があります。NHN Cloudコンソールの **APIセキュリティ設定** メニューで、User Access Keyごとのトークン情報を確認及び管理できます。

1) NHN Cloudコンソールの右上にあるアカウントにマウスカーソルを合わせると表示されるドロップダウンメニューから **APIセキュリティ設定** をクリックします。

2) **+ User Access Key作成**をクリックします。<br>
![C_userAccessKey_1_ja](http://static.toastoven.net/toast/public_api/C_userAccessKey_1_ja.png)

3) **User Access Key作成**モーダル画面で**トークンタイプ**と**トークン有効時間**を設定した後、**作成**をクリックします。<br>
- **Opaqueトークン(デフォルト)**: **OpaqueタイプのUser Access Key IDとSecret Access Key作成**を選択
- **JWTトークン**: **JWTタイプのUser Access Key IDとSecret Access Key作成**を選択(現在EasyQueueサービスのみサポート)<br>
![C_userAccessKey_2_ja](http://static.toastoven.net/toast/public_api/C_userAccessKey_2_ja.png)

4) **User Access Key発行完了** モーダルウィンドウで **Secret Access Key**をコピーした後 **確認**をクリックします。<br>
![C_userAccessKey_3_ja](http://static.toastoven.net/toast/public_api/C_userAccessKey_3_ja.png)


!!! danger "注意"
    * モーダルウィンドウを閉じた後は、Secret Access Keyを再度確認することはできません。Secret Access Keyを忘れた場合は再作成が必要になるため、必ずコピーして別途管理してください。
    * User Access KeyまたはSecret Access Keyのいずれかでも流出した、または流出が疑われる場合、そのキーを破棄して新たに発行する必要があります。


<a id="authentication-server-domain"></a>
## 認証サーバードメイン { #authentication-server-domain }
認証サーバーのドメインは次のとおりです。

```
https://oauth.api.nhncloudservice.com/
```


<a id="request-user-access-key-token-issuance"></a>
## User Access Keyトークンの発行リクエスト { #request-user-access-key-token-issuance }
> `POST /oauth2/token/create`


<a id="request-opaque-token-issuance"></a>
### Opaqueタイプトークンの発行リクエスト { #request-opaque-token-issuance }
* リクエスト

| 区分 | 名前 | タイプ | 必須 | 値                                     | 説明                                                                   |
|---------------|------------- | ------------- | ------------- |-------------------------------------------|--------------------------| 
| Header        |  Content-Type | String | Yes | application/x-www-form-urlencoded         |                                                                        |
| Header        |  Authorization | String | Yes | Basic Base64(UserAccessKeyID:SecretAccessKey) | `UserAccessKeyID:SecretAccessKey` をBase64エンコードした結果を `Basic ` の後ろに付けて使用 |
| Request Body |  grant_type | String | Yes | client_credentials                        | <ul><li>トークン発行grant_typeはclient_credentialsのみ提供されている</li><li>発行リクエスト時に `grand_type=client_credentials` のように使用</li></ul> |

* レスポンス

| 名前        | タイプ       | 必須 | 説明                           |
|--------------|-------------| ------------- |----------------------------------------|
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

<a id="request-jwt-token-issuance"></a>
### JWTタイプトークンの発行リクエスト { #request-jwt-token-issuance }

!!! tip "ポイント"
    現在、EasyQueueサービスのみJWTトークンを使用できます。

* リクエスト

| 区分 | 名前 | タイプ | 必須 | 値 | 説明 |
  |---------------|------------- | ------------- | ------------- |-------------------------------------------|--------------------------|
  | Header        |  Content-Type | String | Yes | application/x-www-form-urlencoded         |                                                                        |
| Header | Authorization | String | Yes | Basic Base64(UserAccessKeyID:SecretAccessKey) | `UserAccessKeyID:SecretAccessKey`をBase64エンコードした結果を`Basic`の後ろに付けて使用 |
| Request Body | grant_type | String | Yes | client_credentials | <ul><li>トークン発行のgrant_typeはclient_credentialsのみ提供されています</li><li>発行リクエスト時に`grant_type=client_credentials`のように使用</li></ul> |
| Request Body | scope | String | Yes | appKey:{appKey} | <ul><li>サービス有効化後に発行されたAppKey</li><li>発行リクエスト時に`scope=appKey:{appKey}`のように使用</li></ul> |

* レスポンス

| 名前 | タイプ | 必須 | 説明 |
  |--------------|-------------| ------------- |----------------------------------------|
| access_token | String | Yes | 発行されたBearerタイプのJWT認証トークン |
| token_type | String | Yes | トークンのタイプ |
| expires_in | String | Yes | 期限切れまでの残り時間を秒単位で意味し、デフォルトは3,600(1時間) |

```json
{
    "access_token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c",
    "token_type":"Bearer",
    "expires_in":3600
}
```

<a id="case-specific-request-examples"></a>
### ケース別リクエスト例 { #case-specific-request-examples }
<a id="case-specific-request-examples-curl-when-including-authentication-information-in-the-header"></a>
#### curl: Headerに認証情報を含める場合


!!! tip "参考"
    以下のAuthorizationにある `dXNlckFjY2Vzc0tleTp1c2VyU2VjcmV0S2V5` は、`UserAccessKeyID:SecretAccessKey` をbase64エンコードした結果です。

* Opaqueタイプのトークン

```sh
curl --request POST 'https://oauth.api.nhncloudservice.com/oauth2/token/create' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Authorization: Basic dXNlckFjY2Vzc0tleTp1c2VyU2VjcmV0S2V5' \
  -d 'grant_type=client_credentials'
```

* JWTタイプのトークン

```sh
curl -X POST "https://oauth.api.nhncloudservice.com/oauth2/token/create" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -H "Authorization: Basic dXNlckFjY2Vzc0tleTp1c2VyU2VjcmV0S2V5" \
  -d "grant_type=client_credentials" \
  -d "scope=appKey:r9Zd7vDEmWMfQb00"
```

<a id="case-specific-request-examples-curl-when-using--u-option"></a>
#### curl: -uオプションを使用する場合

* Opaqueタイプのトークン

```sh
curl --request POST 'https://oauth.api.nhncloudservice.com/oauth2/token/create' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -u 'UserAccessKeyID:SecretAccessKey' \
  -d 'grant_type=client_credentials'
```
* JWTタイプのトークン

```sh
curl -X POST "https://oauth.api.nhncloudservice.com/oauth2/token/create" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -u "flyKphnHuI6sDRglmma6:yjZRN9uX71IHAiFS" \
  -d "grant_type=client_credentials" \
  -d "scope=appKey:r9Zd7vDEmWMfQb00"
```

<a id="case-specific-request-examples-feignclient"></a>
#### FeignClient

* Opaqueタイプのトークン

```java
@FeignClient(name = "auth", url = "https://oauth.api.nhncloudservice.com")
public interface AuthClient {
    @PostMapping(value = "/oauth2/token/create", consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    TokenResponse createToken(@RequestHeader("Authorization") String authorization, @RequestParam("grant_type") String grantType);
}
```

* JWTタイプのトークン

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

* Opaqueトークンの発行

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

* JWTトークンの発行

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


<a id="request-user-access-key-token-revocation"></a>
## User Access Keyトークンの失効リクエスト { #request-user-access-key-token-revocation }
> `POST /oauth2/token/revoke`

!!! tip "ポイント"
    JWTトークンはトークンの失効をサポートしていません。

* リクエスト

| 区分 | 名前 | タイプ | 必須 | 値 | 説明   |
|---------------|------------- | ------------- | ------------- |-------------------------------------------|---|
| Header        |  Content-Type | String | Yes | application/x-www-form-urlencoded         |         |
| Header        |  Authorization | String | Yes | Basic Base64(UserAccessKeyID:SecretAccessKey) | `UserAccessKeyID:SecretAccessKey` をBase64エンコードした結果を `Basic ` の後ろに付けて使用 |
| Request Body |  token | String| Yes | access token    | <ul><li>発行されたトークン</li><li>失効リクエスト時に `token=発行されたトークン` のように使用</li></ul>      |

* レスポンス
    * HttpStatus 200


<a id="request-user-access-key-token-revocation-case-specific-request-examples"></a>
### ケース別リクエスト例 { #request-user-access-key-token-revocation-case-specific-request-examples }
<a id="request-user-access-key-token-revocation-case-specific-request-examples-curl-when-including-authentication-information-in-the-header"></a>
#### curl: Headerに認証情報を含める場合
```sh
curl --request POST 'https://oauth.api.nhncloudservice.com/oauth2/token/revoke' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Authorization: Basic dXNlckFjY2Vzc0tleTp1c2VyU2VjcmV0S2V5' \
  -d 'token=luzocEoQ3tyMvM6pLtoSTHSphgJSGhl5hVvgSstdVQ1X1bZnf9AEMGAcSERIi1Dq0bybSMv0raOcahZjYpZ2biaaoF3jTi9caF5M2TN9F98iZawbBJmN94CPF2Rpe0JI'
```

<a id="request-user-access-key-token-revocation-case-specific-request-examples-curl-when-using-the--u-option"></a>
#### curl: -uオプションを使用する場合
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
## User Access Keyトークンの使用 { #use-user-access-key-token }
User Access KeyトークンはHTTPリクエストヘッダに含めて送信します。API呼び出し時、以下の例のようにリクエストヘッダにUser Access Keyトークンを設定して呼び出してください。

* HTTPヘッダ形式の例
```
X-NHN-Authorization: Bearer {Access Token}
```

ユーザーがHTTPヘッダにキーを含めてサーバーにリクエストを送信すると、サーバーはトークンの有効性を確認した後、リクエストを承認または拒否します。


<a id="get-jwt-public-key"></a>
## JWT Public Key照会 { #get-jwt-public-key }
> `GET /oauth2/jwks`

!!! tip "ポイント"
    JWTトークンの署名を検証するためのPublic Key一覧を照会します。

* レスポンス

[JWKS(JSON Web Key Set)](https://datatracker.ietf.org/doc/html/rfc7517)形式でPublic Key一覧を返却します。

| 名前 | タイプ | 必須 | 説明 |
|------|------|------|------|
| keys | Array | Yes | Public Key一覧 |
| keys[].kty | String | Yes | Key Type(例: RSA) |
| keys[].use | String | Yes | Public Keyの使用目的(例: sig) |
| keys[].kid | String | Yes | Key ID |
| keys[].alg | String | Yes | アルゴリズム(例: RS256) |
| keys[].n | String | Yes | RSA Public KeyのModulus |
| keys[].e | String | Yes | RSA Public KeyのExponent |

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
### リクエスト例 { #request-example }
* curl
```sh
curl -X GET "https://oauth.api.nhncloudservice.com/oauth2/jwks"
```

<a id="public-key-usage-example"></a>
### Public Key活用例 { #public-key-usage-example }
照会したPublic Keyを使用して、JWTトークンの署名を検証できます。ほとんどのJWTライブラリでJWKS形式をサポートしています。

* Java (nimbus-jose-jwt使用)
```java
import com.nimbusds.jose.jwk.JWKSet;
import com.nimbusds.jose.jwk.RSAKey;
import com.nimbusds.jwt.SignedJWT;
import java.net.URL;

public void verifyToken(String token) throws Exception {
    // JWKSエンドポイントからPublic Keyを照会
    JWKSet jwkSet = JWKSet.load(new URL("https://oauth.api.nhncloudservice.com/oauth2/jwks"));
    
    // JWTのパース
    SignedJWT signedJWT = SignedJWT.parse(token);
    String keyId = signedJWT.getHeader().getKeyID();
    
    // Key IDで該当するPublic Keyを検索
    RSAKey rsaKey = (RSAKey) jwkSet.getKeyByKeyId(keyId);
    
    // 署名の検証
    JWSVerifier verifier = new RSASSAVerifier(rsaKey);
    boolean isValid = signedJWT.verify(verifier);
}
```

!!! tip "参考"
    User Access Keyトークンは、エラー発生時に [The OAuth 2.0 Authorization Framework](https://datatracker.ietf.org/doc/html/rfc6749#section-5.2)と同様のエラーコードを返します。トークンリクエストAPI呼び出し、トークン失効リクエストAPI呼び出し、トークン使用などの状況で返される可能性のあるエラーコードは、[フレームワークAPIガイド](./framework-api/#_281)で確認できます。

    

<a id="issue-iaas-token-with-user-access-key"></a>
## User Access KeyでIaaSトークンを発行する { #issue-iaas-token-with-user-access-key }
> `POST /iaas-tokens/v3/auth/tokens`

User Access Keyを使用して、基本インフラサービス(IaaS)の認証トークンを発行できます。発行したIaaSトークンを使用して、Compute、Block Storage、Networkなどのインフラリソース制御APIを呼び出します。

基本インフラサービスのIdentity APIを直接呼び出す方式とは異なり、APIパスワードを設定したり、テナントIDを確認したりする必要はありません。リクエストとレスポンスはOpenStack Keystone v3仕様に準拠しているため、OpenStack CLIとSDKでも使用できます。IaaSトークンの使い方とサービス別エンドポイントは[IaaSトークン](./iaas-token/)で確認できます。

!!! tip "ポイント"
    * このAPIで発行したIaaSトークンの有効時間は12時間に固定されており、変更することはできません。
    * 別途の認証ヘッダは必要ありません。User Access Key IDとSecret Access Keyをリクエストボディに含めて送信します。

<a id="issue-iaas-token-format"></a>
### 発行されるトークン形式 { #issue-iaas-token-format }

IaaSトークンはOpenStack KeystoneのFernet形式で発行されます。Fernetトークンは、ユーザー、プロジェクト、ロール、有効期限など認証に必要な情報がトークン文字列自体に暗号化されて含まれる形式で、`gAAAAA`で始まる文字列です。

* 受け取った値をそのまま`X-Auth-Token`ヘッダに渡す必要があり、トークンの内容を直接解析したり加工したりしないでください。
* OpenStack標準形式のため、OpenStack CLIとSDKでそのまま使用できます。
* User Access Keyトークン(Opaque形式)とは異なる認証方式です。
* 基本インフラサービスAPIにはFernet形式のIaaSトークンを使用する必要があります。
* その他のNHN Cloud Public APIにはUser Access Keyトークンを使用する必要があります。
* 発行後12時間有効です。有効時間は変更することはできません。
* トークンの有効期限が切れた場合は再発行する必要があります。

<a id="issue-iaas-token-prerequisites"></a>
### 事前条件 { #issue-iaas-token-prerequisites }

* **Opaqueタイプ**のUser Access Keyのみ使用できます。JWTタイプのUser Access KeyではIaaSトークンを発行できません。
* トークンを発行するプロジェクトにInstanceまたはObject Storageサービスが有効化されている必要があります。
* User Access Keyを作成したアカウントが該当プロジェクトの権限を持っている必要があります。

<a id="issue-iaas-token-request"></a>
### リクエスト { #issue-iaas-token-request }

| 区分           | 名前                                   | タイプ     | 必須  | 値                | 説明                                                                                                            |
|--------------|--------------------------------------|--------|-----|------------------|---------------------------------------------------------------------------------------------------------------|
| Header       | Content-Type                         | String | Yes | application/json |                                                                                                                 |
| Request Body | auth.identity.methods                | Array  | Yes | ["password"]     | 認証方式の一覧です。`password`のみサポートします。                                                                               |
| Request Body | auth.identity.password.user.id       | String | Yes |                  | User Access Key ID                                                                                              |
| Request Body | auth.identity.password.user.password | String | Yes |                  | Secret Access Key                                                                                               |
| Request Body | auth.scope.project.id                | String | Yes |                  | トークンを発行するサービスのAppkey。InstanceまたはObject StorageのAppkeyを使用し、このAppkeyで対象プロジェクトを識別します。Appkeyの確認方法は[Appkey](./appkey/)を参照してください。 |

<a id="issue-iaas-token-response"></a>
### レスポンス { #issue-iaas-token-response }

発行されたIaaSトークンはレスポンス本文ではなく、`X-Subject-Token`ヘッダに格納されて返されます。この値はOpenStack KeystoneのFernetトークンであり、そのまま`X-Auth-Token`ヘッダに入れてインフラリソース制御APIを呼び出します。

| 区分     | 名前               | タイプ     | 説明                            |
|--------|------------------|--------|-------------------------------|
| Header | X-Subject-Token  | String | 発行されたIaaSトークン(OpenStack Keystone Fernetトークン) |
| Body   | token.issued_at  | String | トークン発行時刻                      |
| Body   | token.expires_at | String | トークン有効期限時刻。発行時刻から12時間後です |
| Body   | token.project    | Object | トークンが適用されるプロジェクト情報              |
| Body   | token.user       | Object | トークンを発行されたユーザーの情報               |
| Body   | token.roles      | Array  | 対象プロジェクトでユーザーに付与されたロール一覧     |
| Body   | token.catalog    | Array  | 使用できるサービスエンドポイントの一覧         |

<a id="issue-iaas-token-request-example"></a>
### リクエスト例 { #issue-iaas-token-request-example }

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
### レスポンス例 { #issue-iaas-token-response-example }

* レスポンスヘッダ

```
HTTP/1.1 201 Created
Content-Type: application/json
X-Subject-Token: gAAAAABnDqW1x3TQZ8kP2mN7vL4hR9sE6yU1aI0oF5cB3dG7jK2nM8pQ4rS6tV9wX1zY
```

* レスポンス本文

<details><summary>例</summary>
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
### エラーレスポンス { #issue-iaas-token-error-response }

エラーが発生した場合、OpenStack Keystone仕様のエラーレスポンスを返します。

| HTTPステータスコード              | 説明                                                                     |
|---------------------------|------------------------------------------------------------------------|
| 400 Bad Request           | リクエスト形式が正しくない場合                                                      |
| 401 Unauthorized          | User Access KeyまたはSecret Access Keyが有効でない場合、またはリクエストされたAppkeyでトークンを発行できない場合 |
| 500 Internal Server Error | サーバー内部エラーが発生した場合                                                       |

```json
{
  "error": {
    "code": 401,
    "message": "The request you have made requires authentication.",
    "title": "Unauthorized"
  }
}
```

!!! danger "注意"
    * User Access KeyまたはSecret Access Keyが一致しない場合、またはUser Access Keyが使用停止状態の場合、トークンは発行されません。
    * リクエストされたAppkeyのプロジェクトで該当サービスが有効化されていない場合、トークンは発行されません。
    * ユーザーがプロジェクトで権限を失った場合、発行済みのIaaSトークンは使用できません。
