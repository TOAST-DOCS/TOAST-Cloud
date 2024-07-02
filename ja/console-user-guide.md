## NHN Cloud > リソース提供ポリシー

### 用語定義


* ロール(Role)：NHN Cloudが提供するサービスや機能を利用するための役割/権限の束の単位
    * 例：プロジェクトBILLING VIEWERロールは’Project.Payment.Get’関連権限で作成されます。
![term_1.png](http://static.toastoven.net/toast/console_guide/consoleuserguide_term_01_240610.png)
   * CloudTrail VIEWERロールにORG_DASHBOARD_VIEWER関連ロールと’CloudTrail:EventLog.List’、’CloudTrail:ExternalStorageConfig.Get’などの関連権限で作成されます。
![term_2.png](http://static.toastoven.net/toast/console_guide/consoleuserguide_term_02_240610.png)
* 権限(Permission)： NHN Cloudサービスと機能を利用するための最小単位
    * 権限を束ねてロールグループを作成できます。
    * サービス権限の場合、%サービス名%:%権限名%で表します。
    * 例：
        * Project.Payment.Get権限は利用状況の詳細照会機能を意味します
        * CloudTrail：EventLog.List権限は’CloudTrail’サービスに属する権限であり、イベントログのリスト照会機能を意味します。
* ロールグループ(Role Group)：ロール、関連ロール/権限、権限を組み合わせて作成した束の単位。
    * 例： プロジェクトのロールであるPROJECT MEMBER ADMINとプロジェクトBILLING VIEWERの関連権限であるProject.Payment.Get権限を追加して、ロールグループ「Group A」を作成します。
![term_3.png](http://static.toastoven.net/toast/console_guide/consoleuserguide_term_03_240610.png)

### Organization 

* ポリシー
    * メンバーには、NHN Cloudが提供するロールを付与できます
    * ロールは関連ロールと関連権限を含んでいます。
![org_0.png](http://static.toastoven.net/toast/console_guide/consoleuserguide_org_00_240610.png)
* Manage Organization Member
    * ユーザーにはロール付与が可能
        * 付与時にロールに条件を設定可能

| 項目 | 条件設定 |
| --- | ----- |
| ロール | 不可 |

![org_1.png](http://static.toastoven.net/toast/console_guide/consoleuserguide_org_01_240610.png)
   * 例：
![org_2.png](http://static.toastoven.net/toast/console_guide/consoleuserguide_org_02_240610.png)
   * 上記のように条件を付与した場合、USER AはCloudTrail VIEWERのロールは火曜日のみ付与され、BILLING VIEWERのロールは全ての曜日の12時～14時のみ付与されます。




### Project

* ポリシー
    * ユーザーは、NHN Cloudが提供するロールと権限を組み合わせてロールグループを作成できます。
    * ユーザーには、ユーザーが作成したロールグループやNHN Cloudが提供するロールを付与できます。
![project_0.png](http://static.toastoven.net/toast/console_guide/consoleuserguide_project_00_240610.png)
* Manage Project Member
    * ユーザーにはロールグループ/ロールを付与できます。
        * 付与時、それぞれのロールグループ/ロールに条件を設定可能

      
| 項目 | 条件設定 |
| --- | ----- |
| ロールグループ | 不可 |
| ロール | 不可 |


![project_1.png](http://static.toastoven.net/toast/console_guide/consoleuserguide_project_01_240610.png)
   * 例：
![project_2.png](http://static.toastoven.net/toast/console_guide/consoleuserguide_project_02_240610.png)
   * 上記のように条件を付与した場合、userAは下記のようなロールを付与されます。
       * USER AはPROJECT MEMBER ADMIN、SMS ADMINのロールを火曜日のみ付与され、BILLING VIEWERのロールは全ての曜日の12時～14時のみ付与されます。


   * 例：
![project_3.png](http://static.toastoven.net/toast/console_guide/consoleuserguide_project_03_240610.png)
   * 上記のように条件を付与した場合、userAは下記のようなロールを付与されます。
       * USER AはADMIN、SMS ADMINのロールは火曜日のみ付与され、BILLING VIEWERロールは火曜日の12時～14時のみ付与されます。


   * 参考事項
       * BILLING VIEWERはADMINの関連ロールなので、ADMINの条件とBILLING VIEWERの条件の共通部分で条件が設定されたロールが付与されます。


* Manage Project Role Group
    * ユーザーにはロールグループ/ロールを付与できます。
        * 付与時、それぞれのロールグループ/ロールに条件を設定可能

| 項目 | 拒否設定 | 条件設定 |
| --- | ----- | ----- |
| ロール | 不可 | 可能 |
| 関連ロール | 可能 |ロールの条件を継承<br>ただし、拒否設定した場合のみ別途条件属性が可能。 |
| 関連権限 | 可能 | ロールの条件を継承<br>ただし、拒否設定した場合のみ別途条件属性が可能。 |
| 権限 |  不可| 可能 |


![project_4.png](http://static.toastoven.net/toast/console_guide/consoleuserguide_project_041_240610.png)
   * 例：
![project_5.png](http://static.toastoven.net/toast/console_guide/consoleuserguide_project_05_240610.png)
   * 上記のように条件を付与したGroup Aを付与されたユーザーは下記のようなロールを付与されます。
       * SMS ADMIN、Project.Deleteのロール/権限を除いたADMINのロールを付与されます。
       * ただし、SMS ADMINのロールは火曜日の12時～14時のみ付与されず、それ以外の時間には付与されます。