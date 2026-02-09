# プロジェクト統合Appkey
**NHN Cloud > Public API使用ガイド > API認証方式 > プロジェクト統合Appkey**

プロジェクト統合Appkeyは、NHN Cloudで1つのプロジェクト内の複数のサービスに対して共通して使用できる認証キーです。サービスごとにAppkeyを個別に管理する必要なく、1つのプロジェクト統合Appkeyで該当プロジェクトで使用中の全てのサービスのAPIを効率的に呼び出すことができます。そのため、管理対象のキー数を減らし、ユーザーが直接Appkeyを作成または削除できるため、キー管理が柔軟かつ効率的です。

## プロジェクト統合Appkeyの作成
NHN Cloudコンソールの各プロジェクト画面でプロジェクト統合Appkeyを作成及び管理できます。

1) NHN Cloudコンソールでプロジェクトを選択した後、**プロジェクト管理** タブをクリックします。

2) **APIセキュリティ設定** で **+ Appkey作成** ををクリックします。<br>
![C_project_API_security_ja](http://static.toastoven.net/toast/public_api/C_project_API_security_ja.png)

3) **Appkey作成** モーダルウィンドウで **Appkey名** 入力フィールドに作成するプロジェクト統合Appkeyの名前を入力した後、**確認** をクリックします。<br>
![C_project_API_security_2_ja](http://static.toastoven.net/toast/public_api/C_project_API_security_2_ja.png)


!!! danger "注意"
    プロジェクト統合Appkeyが外部に流出した場合、該当プロジェクト内の全てのサービスAPIが無断で呼び出される可能性があるため、セキュリティ管理には格別の注意が必要です。プロジェクト統合Appkeyを外部ストレージやコードに含めないよう安全に保管し、流出したり流出が疑われる場合は、既存のAppkeyを削除した後、新しいAppkeyを作成して交換してください。


!!! tip "参考"
    * プロジェクト統合Appkeyは全てのPublic APIでサポートされているわけではありません。同じX-TC-APP-KEYヘッダを使用しても、一部のAPIはサービスごとのAppkeyのみをサポートしているため、プロジェクト統合Appkeyが適用されない場合があります。該当APIのガイドを通じてサポート状況を確認してください。
    * プロジェクト統合Appkeyはプロジェクトあたり最大3個まで作成できます。


## APIの呼び出し
プロジェクト統合AppkeyはHTTPリクエストヘッダに含めて送信します。API呼び出し時、以下の例のようにリクエストヘッダにプロジェクト統合Appkeyを設定して呼び出してください。

* HTTPヘッダ形式の例
```
X-TC-APP-KEY: {プロジェクト統合Appkey}
```

ユーザーがHTTPヘッダにキーを含めてサーバーにリクエストを送信すると、サーバーは該当キーの有効性を確認した後、リクエストを承認または拒否します。
