# Appkey
**NHN Cloud > Public API > API認証方式 > Appkey**

Appkeyは、NHN Cloudの各サービスごとに発行される固有の認証キーであり、APIリクエスト時にサービスの識別と有効性検証に使用されます。認証のための別途のユーザー登録、トークンリクエスト、更新手続きなどは不要で、APIリクエスト時にAppkeyを含めるだけでよいため、認証プロセスが比較的簡単です。

## Appkeyの確認
Appkeyはサービスごとに発行され、NHN Cloudコンソールの各サービス画面で確認できます。
このドキュメントでは、Instanceサービスのコンソール画面を例として使用します。

1) NHN Cloudコンソールの各サービス画面右上にある **URL & Appkey** をクリックします。<br>
![C_Appkey_1_ja](http://static.toastoven.net/toast/public_api/C_Appkey_1_ja.png)

2) **URL & Appkey - {サービス名}** モーダルウィンドウでAppkeyを確認またはコピーした後、**確認**をクリックします。<br>
![C_Appkey_2_ja](http://static.toastoven.net/toast/public_api/C_Appkey_2_ja.png)


!!! danger "注意"
    Appkeyが流出した、または流出が疑われる場合、[サポート > お問い合わせ](https://www.nhncloud.com/jp/support/inquiry)で **お問い合わせタイプ** を **{サービス名}/その他** に選択し、Appkeyの再発行を申請してください。


## SecretKeyの確認
NHN Cloudの一部のサービスでは、APIへのアクセス制御のためにSecretKey(秘密鍵)をサポートしています。
SecretKeyはAppkeyと同様に、SecretKeyをサポートするサービス画面で確認できます。
このドキュメントでは、CDNサービスのコンソール画面を例として使用します。

1) NHN Cloudコンソールのサービス画面右上にある **URL & Appkey** をクリックします。<br>
![C_SecretKey_1_ja](http://static.toastoven.net/toast/public_api/C_SecretKey_1_ja.png)

2) **URL & Appkey - {サービス名}** モーダルウィンドウでSecretKeyをコピーした後、**確認** をクリックします。<br>
![C_SecretKey_2_ja](http://static.toastoven.net/toast/public_api/C_SecretKey_2_ja.png)


## APIの呼び出し
### Appkey
APIリクエスト時、AppkeyはパスパラメータまたはHTTPヘッダに含まれますが、サービスによって使用方法が異なる場合があります。APIリクエスト時に使用するパス形式またはHTTPヘッダフィールド名は、該当サービスのAPIガイドを参照してください。

#### パスパラメータ方式
AppkeyをAPIリクエストの一部として含める方式です。

* 例
```
POST /v1.0/appkeys/{appKey}/
```

#### HTTPヘッダ方式
Appkeyをリクエストのヘッダに含めてサービスの有効性を検証する方式です。

* 例
```
X-TC-APP-KEY: {Appkey}
```


!!! danger "注意"
    Appkeyは有効期限のない固定キーベースの認証方式であり、認可機能がないため、キーが外部に流出した場合、無断でAPIが呼び出される可能性があります。キーは外部ストレージやコードに含まれないよう安全に保管し、流出が疑われる場合は直ちに再発行を依頼する必要があります。[サポート > お問い合わせ](https://www.nhncloud.com/jp/support/inquiry)で **お問い合わせタイプ** を **{サービス名}/その他** に選択し、Appkeyの再発行を依頼できます。


### SecretKey
APIリクエスト時、SecretKeyはアクセス制御のために使用され、サービスによって使用方法が異なる場合があります。APIリクエスト時に使用するHTTPヘッダフィールド名は、該当サービスのAPIガイドを参照してください。

#### HTTPヘッダ方式
SecretKeyをリクエストのヘッダに含めてサービスの有効性を検証する方式です。

* 例
```
X-SECRET-KEY: {Secretkey}
```
