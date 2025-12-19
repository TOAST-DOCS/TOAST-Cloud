## NHN Cloud > リソース提供ポリシー

### 用語定義


* ロール(Role)：NHN Cloudが提供するサービスや機能を利用するための役割/権限の束の単位
   * CloudTrail VIEWERロールにORG_DASHBOARD_VIEWER関連ロールと’CloudTrail:EventLog.List’、’CloudTrail:ExternalStorageConfig.Get’などの関連権限で作成されます。

![term_1.png](https://static.toastoven.net/prod_architecture_Icon/consoleuserguide_term_01_251124.png)

<<<<<<< HEAD
* 例：プロジェクトBILLING VIEWERロールは’Project.Payment.Get’関連権限で作成されます。
=======
    * 例：プロジェクトBILLING VIEWERロールは’Project.Payment.Get’関連権限で作成されます。
>>>>>>> origin/alpha
![term_2.png](https://static.toastoven.net/prod_architecture_Icon/consoleuserguide_term_02_251124.png)

* 権限(Permission)： NHN Cloudサービスと機能を利用するための最小単位
    * 権限を束ねてロールグループを作成できます。
    * サービス権限の場合、%サービス名%:%権限名%で表します。
    * 例：
        * Project.Payment.Get権限は利用状況の詳細照会機能を意味します
        * CloudTrail：EventLog.List権限は’CloudTrail’サービスに属する権限であり、イベントログのリスト照会機能を意味します。
* ロールグループ(Role Group)：ロール、関連ロール/権限、権限を組み合わせて作成した束の単位。
    * 例： プロジェクトのロールであるPROJECT MEMBER ADMINとプロジェクトBILLING VIEWERの関連権限であるProject.Payment.Get権限を追加して、ロールグループ「Group A」を作成します。

![term_3.png](https://static.toastoven.net/prod_architecture_Icon/consoleuserguide_term_03_251124.png)

### Organization 

* ポリシー
    * OWNER/ADMIN/ORG_MEMEBER__ADMINは、NHN Cloudで提供するロールと権限を組み合わせて、組織ロールグループを作成できます。
    * 組織メンバーには、作成された組織ロールグループやNHN Cloudで提供するロールを付与できます。

![org_0.png](https://static.toastoven.net/prod_architecture_Icon/consoleuserguide_org_00_251124.png)

* 組織メンバー管理
    * メンバーには、ロールグループとロールの付与が可能です。

| 項目 | 条件設定 |
| --- | ----- |
| ロールグループ | 不可 |
| ロール | 可能 |

![org_1.png](https://static.toastoven.net/prod_architecture_Icon/consoleuserguide_org_01_251124.png)

   * 例：

![org_2.png](https://static.toastoven.net/prod_architecture_Icon/consoleuserguide_org_02_251124.png)

* 上記のように条件を付与した場合、User Aは次のようなロールグループを付与されます。
    * BILLING VIEWERロールは全ての曜日の12時～14時にのみ付与され、CloudTrail VIEWERロールは火曜日にのみ付与されます。
* プロジェクトロールグループ管理
    * メンバーには、ロールグループとロールの付与が可能です。



### Project

* ポリシー
    * ADMIN/PROJECT MEMBER ADMINは、NHN Cloudで提供するロールと権限を組み合わせて、プロジェクトロールグループを作成できます。
    * プロジェクトメンバーには、作成されたロールグループやNHN Cloudで提供するロールを付与できます。

![project_0.png](https://static.toastoven.net/prod_architecture_Icon/consoleuserguide_project_00_251124.png)

* プロジェクトメンバー管理
    * メンバーには、ロールグループとロールの付与が可能です。

      
| 項目 | 条件設定 |
| --- | ----- |
| ロールグループ | 不可 |
| ロール | 可能 |


![project_1.png](https://static.toastoven.net/prod_architecture_Icon/consoleuserguide_project_01_251124.png)

   * 例：

![project_2.png](https://static.toastoven.net/prod_architecture_Icon/consoleuserguide_project_02_251124.png)

   * 上記のように条件を付与した場合、User Aは以下のようなロールグループとロールを付与されます。
       * User AはADMIN、BILLING VIEWERロールは火曜日にのみ付与され、PROJECT SUPPORT ADMINロールは全ての曜日の12～14時にのみ付与されます。


   * 参考事項
       * BILLING VIEWERの上位ロールであるADMINに条件が設定されたため、BILLING VIEWERはADMINの条件を継承して適用されます。


* プロジェクトロールグループ管理
    * メンバーには、ロールグループとロールの付与が可能です。

| 項目 | 拒否設定 | 条件設定 |
| --- | ----- | ----- |
| ロール | 不可 | 可能 |
| 関連ロール | 可能 |不可<br>上位のロールに設定された条件が適用可能な条件である場合、継承されて適用 |
| 関連権限 | 可能 | 不可<br>上位のロールに設定された条件が適用可能な条件である場合、継承されて適用 |
| 権限 | 不可<br>ただし、該当権限が関連権限として拒否設定されている場合、同様に拒否処理 | 可能 |


![project_3.png](https://static.toastoven.net/prod_architecture_Icon/consoleuserguide_project_03_251124.png)

   * 例：

![project_4.png](https://static.toastoven.net/prod_architecture_Icon/consoleuserguide_project_04_251124.png)

   * 上記のように条件を付与したRole Group Aを付与されたメンバーは、以下のようなロールを付与されます。
       * ADMINロールは火曜日にのみ付与されます。
       * PROJECT MEMBER ADMINロール、Project.Product.List権限はADMINの条件を継承して適用されます。
       * ただし、Project.RoleGroup.Create権限はADMINの関連権限としてすでに拒否設定されているため、同様に拒否処理されます。
       
       