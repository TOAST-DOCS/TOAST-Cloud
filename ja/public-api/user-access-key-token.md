# User Access Keyトークン

**NHN Cloud > Public API使用ガイド > API認証方式 > User Access Keyトークン**

User Access Keyトークンは、User Access Keyに基づいて発行されるBearerタイプの一時的なアクセストークンです。Bearerトークンは、トークンを所有するユーザーであれば誰でもアクセス権限が付与されるセキュリティトークンの一種で、有効期限を設定できるためリソースを安全に保護できます。
User Access Keyトークンは、ロールベースのアクセス制御(ABAC、Attribute-Based Access Control)方式で動作し、トークンを使用する場合はNHN CloudアカウントまたはIAMアカウントに付与されたロール及び権限が適用されます。そのため、呼び出し可能なAPIは該当アカウントのロール及び権限の範囲内に制限されます。また、ロールの詳細条件を設定することで、きめ細かいアクセス制御が可能です。

NHN Cloudは2種類のタイプのトークンを提供します。
- **Opaqueトークン**: 一般的なNHN Cloud APIの呼び出しに使用されるデフォルトのトークンタイプ
- **JWTトークン**: 現在、EasyQueueサービスのメッセージ送受信時にのみ使用可能なトークンタイプ

## User Access Keyトークンの発行及びPublic API呼び出しの概要

User Access Keyトークンの発行及びAPI呼び出しは、次のようなフローで動作します。

### 新規トークン発行及びAPI呼び出し

![img001.png](http://static.toastoven.net/toast/public_api/img01_JA.png)

### トークン期限切れ時の再発行及びAPI呼び出し

![img002.png](http://static.toastoven.net/toast/public_api/img02_JA.png)


発行されたトークンは有効期間中のみ使用でき(デフォルト: 24時間)、期限切れ後は新たに発行する必要があります。トークンが流出した、または流出が疑われる場合、そのトークンを直ちに失効処理し、必要に応じて再発行する必要があります。


!!! tip "ポイント"
    トークンの有効期間は、NHN Cloudコンソールの **APIセキュリティ設定** メニューで変更できます。
    Opaqueトークンの有効時間は60秒～86,400秒(24時間)の範囲で設定でき、JWTトークンの有効時間は60秒～3,600秒(1時間)の範囲で設定できます。
    有効期間を変更する前に発行されたトークンの有効期間は変更されず、トークン有効期間の変更後に新規発行されるトークンから変更後の有効期間が適用されます。


## 事前作業

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


## 認証サーバードメイン
認証サーバーのドメインは次のとおりです。

```
https://oauth.api.nhncloudservice.com/
```


## User Access Keyトークンの発行リクエスト
> `POST /oauth2/token/create`


### Opaqueタイプトークンの発行リクエスト
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

### JWTタイプトークンの発行リクエスト

!!! tip 「ポイント」
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

### ケース別リクエスト例
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

!!! tip 「ポイント」
    JWTトークンはトークンの失効をサポートしていません。

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


## JWT Public Key照会
> `GET /oauth2/jwks`

!!! tip 「ポイント」
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

### リクエスト例
* curl
```sh
curl -X GET "https://oauth.api.nhncloudservice.com/oauth2/jwks"
```

### Public Key活用例
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
    User Access Keyトークンは、エラー発生時に [The OAuth 2.0 Authorization Framework](https://datatracker.ietf.org/doc/html/rfc6749#section-5.2)と同様のエラーコードを返します。トークンリクエストAPI呼び出し、トークン失効リクエストAPI呼び出し、トークン使用などの状況で返される可能性のあるエラーコードは、[フレームワークAPIガイド](https://docs.nhncloud.com/ko/nhncloud/ko/public-api/framework-api/#_281)で確認できます。

    
