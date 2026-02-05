# User Access Key

**NHN Cloud > Public API > API認証方式 > User Access Key**

User Access Keyは、NHN CloudアカウントまたはIAMアカウントに基づいて発行される認証キーであり、Secret Access Keyとともに使用してAPIリクエストの認証手段として活用されます。APIリクエスト時にユーザー単位でアクセス権限を認証でき、ユーザーごとの細かい権限制御が可能です。認証されたNHN CloudアカウントまたはIAMアカウントに付与されたロール及び権限によってAPI呼び出しが制限されますが、APIバージョンによっては認可機能が適用されない場合もあります。


!!! danger "注意"
    * User Access KeyとSecret Access Keyは有効期限のない固定キーベースの認証方式であり、キーが外部に流出した場合、そのアカウントのロール及び権限の範囲内の全てのAPIが無断で呼び出される可能性があります。
    * キーは外部ストレージやコードに含まれないよう安全に保管し、流出が疑われる場合は直ちに破棄して再発行する必要があります。


## User Access Keyの発行
NHN Cloudが提供するAPIを使用するには、User Access Keyを発行する必要があります。User Access Keyは、NHN Cloudコンソールの **APIセキュリティ設定** で発行できます。

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


!!! tip 「ポイント」
    * User Access Keyは、NHN CloudアカウントとIAMアカウントごとにそれぞれ5個まで発行できます。
    * User Access Key IDは90日ごとに変更することを推奨します。


## APIの呼び出し
User Access KeyはHTTPリクエストヘッダに含めて送信します。API呼び出し時、以下の例のようにヘッダにUser Access Keyを設定して呼び出してください。


* HTTPヘッダ形式の例
```
X-TC-AUTHENTICATION-ID: {User Access Key}
X-TC-AUTHENTICATION-SECRET: {Secret Access Key}
```


ユーザーがHTTPヘッダにキーを含めてサーバーにリクエストを送信すると、サーバーは該当キーの有効性及び権限を確認した後、リクエストを承認または拒否します。
