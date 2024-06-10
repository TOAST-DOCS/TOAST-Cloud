## NHN Cloud > コンソール使用ガイド

NHN Cloud Consoleは、NHN Cloudサービスを利用するための管理ツールと作業ウィンドウの役割を担います。
ここではNHN Cloudコンソールの基本的な設定と使用方法を案内します。

NHN Cloud Consoleは下記の機能を提供します。

- サービスを利用するための基本情報管理(組織、プロジェクト)
- サービス有効化/無効化
- サービスを利用するメンバーの管理
- 決済情報提供

## コンソールクイックガイド
コンソールで提供する基本機能のクイックガイドです。 

![tutorial_1_jp.png](http://static.toastoven.net/toast/console_guide/consoleguide_01_202109_jp.png)
![tutorial_2_jp.png](http://static.toastoven.net/toast/console_guide/consoleguide_02_202109_jp.png)

## 組織管理

組織は、NHN Cloudサービスを効率的に使用し、管理するために作られたグループです。
組織では同じサービスポリシーをユーザーに共有して使用できます。
組織を通して多様なNHN Cloudサービスを効率的に使用できます。

### 組織作成

- NHN Cloudサービスを利用するには組織を作成する必要があります。
- 組織は個人/事業者会員、どちらでも作成できます。
- 組織を作成した会員は自動的に組織のOWNERになります。
- 組織を作成するには会員の決済方法が登録されている必要があります。
- 組織は組織名/ドメイン情報を管理します。
- 組織のドメイン情報はサービスで使用する必要がある情報で、固有の情報でなければいけません。

### 組織作成ガイド

![console_guide_1_jp.png](http://static.toastoven.net/toast/console_guide/consoleguide_03_202109_jp.png)
![console_guide_2_jp.png](http://static.toastoven.net/toast/console_guide/consoleguide_04_202109_jp.png)

1. コンソールに移動した後、上段メニューから**組織を作成してください。**横の**+**ボタンをクリックします。
2. **組織作成**ウィンドウで組織名を入力します。組織名には日本語、アルファベット、特殊文字、数字を使用できます。
3. **確認**ボタンをクリックすると組織の作成が完了します。
4. コンソール上段メニューに作成された組織名が表示されます。
5. **設定**ボタンをクリックし、作成された組織情報を確認します。組織の追加情報にドメイン情報を入力します。ドメインはNHN Cloudで唯一の値に設定する必要があります。


### 組織サービス

組織が作成されると、サービスを選択できます。
組織単位で有効にできるサービスは次のとおりです。

- Dooray!
- ERP
- Groupware
- Contact Center
- IDC
- CloudTrail
- Resource Watcher



### 組織の削除

- 組織の削除は組織のOWNERだけができます。
- 組織を削除するには、利用中のサービスをすべて削除する必要があります。
- 組織を削除すると、組織のすべての情報は削除され、復旧できません。

### 組織ガバナンス設定

NHN Cloudサービスを安定的かつ効率的に利用するために必要なポリシーを設定して管理できます。 ログインおよび個人情報など、セキュリティコンプライアンス遵守のための組織の共通ポリシーを策定し、組織内のメンバーがポリシーを遵守できるように管理します。

![console_guide_3_jp.png](http://static.toastoven.net/toast/console_guide/consoleguide_15_202303_jp_new.png)

#### IP ACL設定
許可したIP(またはIP帯域)からのみコンソールにアクセスできます。
Dooray!サービスは各サービスコンソール画面からIP ACLを設定できます。

1. コンソールに移動した後、設定したい組織の組織管理ページに接続します。
2. サブメニューからガバナンス設定を選択します。
3. 組織ガバナンス設定の**IP ACL設定**でIP ACLを設定し、管理できます。
   * サービス設定
       * 共通設定：すべてのサービスに同じようにIP ACLを設定できます。
       * サービスの設定：各サービス(Cloud、Online Contact など)ごとにIP ACLを設定できます。
   * IP ACL
        * 設定しない：すべてのIP(またはIP帯域)からコンソールにアクセスできます。
        * 許可したIP(またはIP帯域)のみコンソールアクセス：入力したIP(またはIP帯域)からのみコンソールにアクセスできます。アクセスを許可するIPまたはIP帯域を入力します。


#### 承認プロセス管理設定
サービス利用時、承認プロセスが必要な場合、承認権限者の承認手続きを進めるサービス別機能を提供します。

* **承認プロセス管理設定**で**設定しない(Default)/設定**を選択できます。
* 承認プロセス管理設定で**設定**を選択すると、各サービスで提供する承認手続きを利用できます。
* 承認プロセス提供サービス
    * Secure Key Manager

#### Instance名管理設定
Instanceサービス利用時、 Instance名管理ルールを設定できます。

* **重複許可管理**を選択すると、 Instance名をユーザーが入力した名前で管理し、重複したInstance名を許可します。
* **Unique管理**を選択すると、Instance名をユーザーが入力した名前とシステムで作成した文字を組み合わせて唯一のInstacne名で管理します。

#### リソース権限制御および接続端末制限設定
運営者が組織のリソースの重要情報を照会する時、ユーザーにメールを送信し、ネットワーク分離PCからのみリソースを確認できるように設定できます

* **リソース権限制御および接続端末制限設定**で**設定しない(Defualt)/設定**を選択できます。
* リソース権限制御および接続端末制限設定で**設定**を選択すると、運営者のリソース照会機能が制限されます。

### IAMガバナンス設定

#### ログインセキュリティ設定

* IAMメンバーのコンソール接続セキュリティを強化するために**ログインセキュリティ設定**機能を提供します。
* すべての組織サービス(Cloud、Online Contact、Dooray!など)に同じように設定したり、サービスごとに設定できます。
![console_guide_4_jp.png](http://static.toastoven.net/toast/console_guide/consoleguide_06_202303_jp.png)

1. コンソールに移動した後、設定したい組織の組織管理ページに接続します。
2. サブメニューのガバナンス設定を選択します。
3. IAMガバナンス設定のログインセキュリティ設定を設定して管理できます。

#### 2次認証

2次認証を必須に設定して使用するようにできます。

* サービス設定
    * 共通設定：すべての組織サービスに同じように2次認証を設定します。
    * サービス別設定：各サービス(Cloud, Online Contact, Dooray!など)ごとに2次認証を設定できます。
* 2次認証設定
    * 設定しない：2次認証を行わず、IDとパスワードの入力だけでログインできます。
    * Google OTP：IDとパスワードを入力した後、Google OTPアプリで提供したOne Time Passwordを入力してログインできます。
    * メール：IDとパスワードを入力した後、メールアドレスに送信された**認証**ボタンをクリックして認証した後、ログインできます。
* 例外IP設定
    * 設定しない：ログイン時、すべてのIP帯域で2次認証後にログインできます。
    * 設定：設定したIPまたはIP帯域からログインした時、2次認証を行わずにログインできます。

#### ログイン失敗セキュリティ

ログインを繰り返し失敗した時、一定時間が経過した後に再度ログインできるように設定できます。

* サービス設定
    * 共通設定：すべての組織サービスに同じように2次認証を設定します。 (サービス別設定機能は未提供)
* ログイン失敗セキュリティ設定
    * 設定しない：ログインに失敗しても継続してログインを試行できます。
    * 設定：失敗回数とロック時間を設定すると、設定した回数ログインに失敗した時、入力したロック時間中はログインを試行できません。

#### ログインセッション

ログインセッション設定に基づいてログインセッションが維持されるか、自動的に終了します。
ログインが終了した後は、再度ログインするとコンソールに接続できます。

* サービス設定
    * 共通設定：すべての組織サービスに同じように2次認証を設定します。 (サービス別設定機能は未提供)
* ログインセッション数
    * 複数の端末から同じIDで同時にログインすることができる数を設定します。
    * 1に設定すると、同じIDでPC、スマートフォンなど複数の端末から同時にログインできません。
  例) PC- ログイン維持。スマートフォン - 自動ログアウト
* ログインセッション維持時間
    * クリックなどの操作がなくてもログインを維持する時間を設定します。
    * 設定した時間の間にクリックなどの操作を行わなかった場合、自動的にログアウトされます。
    * あまりにも長く設定すると、セキュリティ上良くないため、考慮して設定してください。

#### パスワードポリシー設定
* IAMメンバーのパスワードを設定するために、パスワードポリシー設定機能を提供します。
* パスワードポリシーはすべての組織サービス(Cloud, Online Contact, Dooray!など)に同じように設定されます。
* IAMガバナンス設定 > パスワードポリシー設定で管理できます。
    * 基本パスワードポリシー
        * 基本パスワードポリシー下記のような基本パスワードポリシーを提供します。
            * 英字、数字、特殊文字を含めて8桁以上で構成します。
            * 大文字/小文字を区別します。
            * 4桁以上の連続した文字や数字（例：1111、1234、abcdなど）は使用できません。
            * パスワードは90日ごとに変更する必要があり、90日が過ぎるとパスワード変更案内画面が表示されます。
    * ユーザーパスワードポリシー
        * パスワードの最小長さ、パスワードの強度、パスワードの有効期限、パスワードの再利用制限などを設定できるパスワードポリシーを提供します。
            * パスワードの最小長さ：パスワードの最小長さを8～15文字に設定します。 (最大長さは15文字で提供されます。)
            * パスワード強度：連続した文字、大文字、小文字、数字、特殊文字などを組み合わせてパスワードの強度を設定します。
            * パスワードの有効期限：パスワードの有効期限の有無を選択し、設定時に有効期限、有効期限の延長可否を設定します。
            * パスワードの再使用制限：パスワードの再使用制限の有無を選択し、設定時に再使用制限数を1～3の中から選択して設定します。
            * パスワードポリシーの適用時期：パスワード変更時に適用、即時適用から選択してパスワードポリシーの適用時期を設定します。
                * パスワード変更時に適用を選択した場合、IAMメンバーのパスワード変更時に新しいポリシーとして適用されます。
                * 即時適用を選択した場合、パスワード設定後すぐに適用され、IAMメンバーのログイン時に新しいポリシーとして適用されます。

### プロジェクト共通ロールグループ設定

組織に属しているプロジェクトにおいて共通で使用するロールグループを作成し、管理できます。
設定されたロールグループはプロジェクトのロールグループ管理からNHN Cloud会員およびIAMメンバーを選択してロールを一括付与できます。

1. 組織設定を選択した後、プロジェクト共通ロールグループ設定メニューをクリックします。
2. **ロールグループ追加**を選択して、サービスごとにロールを追加します。
3. ロールグループ名、説明を入力し、サービスごとにロールを追加します。
    * ロールグループ名は日本語、アルファベット、特殊文字を使用可能で、最大40文字まで入力できます。
    * 説明は最大100文字まで入力できます。
4. ロールは**サービスごとに細分化された利用ロール**を選択できます。
    * サービス名を左側の領域から検索した後、右側の領域でロールを選択します。
5. 選択されたロールを確認して追加または削除できます。
    * サービス名の横にあるxボタンをクリックして、選択されたサービスを削除できます。
6. 追加ボタンをクリックしてロールグループを追加します。
7. ロールグループが追加されると、ロールグループリストに名前が表示されます。ロールグループ名を選択して、詳細ロール内容を確認できます。
8. ロール追加をクリックすると、3回ロールグループ追加画面に移動します。ロールを追加または削除できます。

## プロジェクト管理

プロジェクトは組織作成後、NHN Cloudサービスを利用するために作成します。
プロジェクトではプロジェクトサービスを有効にして利用できます。
プロジェクトサービスはプロジェクト単位で利用し、これに応じて課金します。

### プロジェクトの作成

* プロジェクトを作成するには、組織を作成する必要があります。
* プロジェクトを作成した会員は、プロジェクトのAdminロールを持ちます。
* プロジェクト作成時、プロジェクト名とプロジェクトの説明を入力します。
* プロジェクト作成後、プロジェクトサービスを有効にして利用できます。
* プロジェクト作成後、協業が必要な場合はプロジェクトメンバーに追加して一緒に使用できます。

### プロジェクト作成ガイド
![console_guide_5_jp.png](http://static.toastoven.net/toast/console_guide/consoleguide_07_202109_jp.png)
![console_guide_6_jp.png](http://static.toastoven.net/toast/console_guide/consoleguide_08_202109_jp.png)


1. 組織を作成すると、**新しいプロジェクト作成**ボタンが有効になります。**新しいプロジェクト作成**ボタンをクリックし、プロジェクトを作成します。
2. **プロジェクト名**と**プロジェクトの説明**を入力します。
3. **確認**ボタンをクリックし、プロジェクトを作成します。
4. プロジェクトが作成されると、メニューにプロジェクト名が表示されます。
5. **プロジェクト設定**ボタンをクリックし、プロジェクト情報を確認します。

### プロジェクトサービス

プロジェクトが作成されると、サービスを選択できます。
プロジェクト単位で有効にすることができるサービスは次のとおりです。

* Compute
* Container
* Network
* Storage
* Database
* Monitoring
* Hybrid & Private Cloud
* Game
* Security
* Content Delivery
* Notification
* AI Service
* Machine Learning
* Application Service
* Mobile Service
* Search
* Data & Analytics
* Dev Tools
* Management
* Bill

### プロジェクトサービス有効化ガイド

![console_guide_6_jp.png](http://static.toastoven.net/toast/console_guide/consoleguide_09_202109_jp.png)
![console_guide_7_jp.png](http://static.toastoven.net/toast/console_guide/consoleguide_10_202109_jp.png)

1. プロジェクト作成後、**サービス選択**ボタンをクリックし、プロジェクトで使用するサービスを選択できます。
2. サービス選択画面で、有効にするサービスを選択します。サービスを有効にするかどうかの確認メッセージが表示されたら、**確認**をクリックします。
3. 有効にしたサービスリストは、コンソール左のメニューで確認できます。リストからサービスをクリックすると、サービス利用画面が表示されます。

### プロジェクトの削除

プロジェクトで利用中のサービスがない場合、プロジェクトを削除できます。
プロジェクトを削除すると、プロジェクトのすべてのリソースは削除され、復旧できません。
現在まで利用したすべてのリソースに対する利用内訳を即時決済して削除できます。
ただし、即時決済せずに削除する場合、現在まで利用した料金内訳は次の決済日に自動請求されます。

## メンバーの管理

メンバーの管理でユーザー別認証(ログイン)とロール付与が行えます。
プロジェクトと組織でメンバー管理を別々に行えます。
メンバーはNHN Cloud会員とIAMメンバーに分けられます。

### NHN Cloud会員とIAMメンバーポリシー

| 区分 | [NHN Cloud](http://nhncloud.com)会員 | IAMメンバー |
| --- | --- | --- |
| 定義      | - 組織管理のためのメンバー<br>- NHN Cloud利用約款に同意したNHN Cloud会員で、サービス利用に対する責任と義務を有するメンバー<br>- NHN Cloudサービス全体で有効なメンバーで、所属した組織が削除されてもNHN Cloud会員に存在 | - サービス利用のためのメンバー<br>- NHN Cloud利用約款に同意しないメンバー<br>- 組織内でのみ有効なメンバー、所属した組織が削除されると削除されるメンバー | 
| メンバー登録方法 | - 組織のOWNERまたはAdminがNHN Cloud IDを入力して登録 | - 組織のOWNERまたはAdminが組織内で唯一のIDを入力して登録<br>- SSO連動/API連携などを通して登録 |
| メンバーロール | - 組織管理(組織作成/修正/組織メンバー管理/組織サービス管理/決済管理)<br>- プロジェクト作成<br>- プロジェクト削除 | - 組織サービス利用 |
| コンソールアクセス | - NHN Cloudコンソール([https://console.nhncloud.com/](https://console.nhncloud.com/))アクセス<br>- NHN Cloud> 会員ID/パスワードでログイン<br>- (任意) 2次(メールまたはSMS)認証 | - IAMコンソール(https://組織ドメイン.console.nhncloud.com/)アクセス<br>- (Dooray!、ERPサービスは該当サービスドメインでアクセス)<br>- 組織のOWNER(またはADMIN)が設定したID/PWでログイン- 組織で設定したログインセキュリティ(2次認証、サービス別設定)認証 |


### 組織メンバー

- 組織のOWNERはアカウントのすべてのロールを付与し、サービスを申請できます。 
- OWNERは会員を登録し、組織別の管理ロールを付与できます。

#### NHN Cloud会員の組織ロール

| 作業 | ロール | OWNER | ADMIN | MEMBER | Billing Viewer | Log Viewer |
| --- | --- | --- | --- | --- | --- | --- |
| 組織管理 | 組織作成 | O |  |  |  |  |
|  | 組織修正 | O | O |  |  |  |
|  | 組織削除 | O |  |  |  |  |
| メンバー管理 | 組織メンバー登録 | O | O |  |  |  |
|  | 組織メンバー削除 | O | O |  |  |  |
| サービス管理 | 組織サービス有効化 | O | O |  |  |  |
|  | 組織サービス無効化 | O | O |  |  |  |
| 決済管理 | 請求書照会 | O |  |  |  |  |
|  | 利用状況 | O | O |  | O |  |
| プロジェクト管理 | プロジェクト作成 | O | O | O |  |  |
|  | プロジェクト削除 | O | O |  |  |  |
| ユーザーActionログの管理 | ユーザーActionログの照会 | O | O |  |  | O |

#### IAMメンバーの組織ロール

* 組織サービスごと(Online Contact、Dooray!など)に設定できるロールが異なります。
* クラウドサービスのロールは下記のとおりです。

| 作業 | ロール | ADMIN | MEMBER | Billing Viewer | Log Viewer |
| --- | --- | --- | --- | --- | --- |
| 組織管理 | 組織修正 | O |  |  |  |
| メンバー管理 | 組織メンバー登録 | O |  |  |  |
|  | 組織メンバー削除 | O |  |  |  |
| サービス管理 | 組織サービス有効化 | O |  |  |  |
|  | 組織サービス無効化 | O |  |  |  |
|  | 利用状況 | O |  | O |  |
| プロジェクト管理 | プロジェクト作成 | O | O |  |  |
|  | プロジェクト削除 | O |  |  |  |
| ユーザーActionログの管理 | ユーザーActionログの照会 | O |  |  | O |

### プロジェクトメンバー

組織のメンバーではなくてもプロジェクトのメンバーになることができます。
プロジェクトメンバーに必要なロールを複数付与できます。 

#### プロジェクト管理ロール

| ロール | 説明 |
| --- | --- |
| ADMIN | プロジェクト全体に対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除) |
| MARKETPLACE_ADMIN | Marketplace サービス Create(作成)、Read(読込)、Update(更新)、Delete(削除) |
| MARKETPLACE_VIEWER | Marketplace サービス Read(読込) |
| MEMBER | プロジェクト内のすべてのサービスCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除) |
| BILLING VIEWER | 利用状況Read(読み取り) |
| PROJECT MANAGEMENT ADMIN | プロジェクト基本情報Update(更新)<br> プロジェクト統合Appkey Create(作成)/Read(読み取り)/Update(更新)/Delete(削除)  <br> プロジェクトサービス有効化(Enable)/無効化(Disable) <br> プロジェクトDelete(削除) |
| PROJECT MANAGEMENT VIEWER | プロジェクト基本情報Read(読み取り)<br> プロジェクト統合Appkey Read(読み取り) |
| PROJECT MEMBER ADMIN | プロジェクトメンバーCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)<br> プロジェクトロールグループCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除) |
| PROJECT MEMBER VIEWER | プロジェクトメンバーRead(読み取り)<br> プロジェクトロールグループRead(読み取り) |
| PROJECT NOTICE GROUP MANAGEMENT ADMIN | プロジェクト通知受信グループの管理Create(作成)/Read(読み取り)/Update(更新)/Delete(削除) <br> プロジェクトメンバーRead(読み取り) <br> プロジェクトロールグループ Read(読み取り)|
| PROJECT NOTICE GROUP MANAGEMENT VIEWER | プロジェクト通知受信グループの管理Read(読み取り) <br> プロジェクトロールグループ Read(読み取り)|
| PROJECT NOTICE MANAGEMENT ADMIN | プロジェクト通知管理 Create(作成)/Read(読取)/Update(更新)/Delete(削除) <br> プロジェクトメンバーRead(読み取り) <br> プロジェクトロールグループ Read(読み取り)| プロジェクト通知受信グループの管理 Read(読取)
| PROJECT NOTICE MANAGEMENT VIEWER | プロジェクト通知管理 Read(読取) <br> プロジェクトロールグループ Read(読み取り)| プロジェクト通知受信グループの管理 Read(読取)
| PROJECT API SECURITY SETTING ADMIN | プロジェクトAPIセキュリティー設定Create(作成)/Read(読み取り)/Update(更新)/Delete(削除)|
| PROJECT QUOTA MANAGEMENT ADMIN| プロジェクトクォーター管理Create(作成)/Read(読み取り)/Update(更新)/Delete(削除)|
| PROJECT QUOTA MANAGEMENT VIEWER| プロジェクトクォーター管理Read(読み取り)|

#### プロジェクト管理機能別権限

| タブ | 機能別実行可能動作 | プロジェクト管理ロール | サービス利用ロール |
| --- | --- | --- | --- |
| ダッシュボード | Read(読込) | ADMIN<br>MEMBER<br>PROJECT MANAGEMENT ADMIN<br>PROJECT MANAGEMENT VIEWER<br>MARKETPLACE\_ADMIN <br>MARKETPLACE\_VIEWER| サービスADMIN<br>サービスPERMISSION<br>サービスVIEWER |
| カスタムダッシュボード | Read(読込) | ADMIN<br>MEMBER<br>PROJECT MANAGEMENT ADMIN<br>PROJECT MANAGEMENT VIEWER<br>MARKETPLACE\_ADMIN <br>MARKETPLACE\_VIEWER | サービス ADMIN<br>サービス PERMISSION<br>サービス VIEWER |
| メンバー管理 | Read(読込) | ADMIN<br>PROJECT MEMBER ADMIN <br>PROJECT MEMBER VIEWER<br>PROJECT NOTICE GROUP MANAGEMENT ADMIN | 権限なし |
| | Create(作成)/Update(更新)/Delete(削除) | ADMIN<br>PROJECT MEMBER ADMIN | 権限なし |
| ロールグループ管理 | ロールグループRead(読込) | ADMIN<br>PROJECT MEMBER ADMIN <br>PROJECT MEMBER VIEWER<br>PROJECT NOTICE GROUP MANAGEMENT ADMIN | 権限なし |
| | ロールグループCreate(作成)/Update(更新)/Delete(削除) | ADMIN<br>PROJECT MEMBER ADMIN | 権限なし |
| | ロールグループメンバータブRead(読込) | ADMIN<br>PROJECT MEMBER ADMIN <br>PROJECT MEMBER VIEWER <br>PROJECT NOTICE GROUP MANAGEMENT ADMIN| 権限なし |
| | ロールグループメンバータブCreate(作成)/Update(更新)/Delete(削除) | ADMIN<br>PROJECT MEMBER ADMIN | 権限なし |
| | ロールグループロールタブRead(読込) | ADMIN<br>PROJECT MEMBER ADMIN<br>PROJECT MEMBER VIEWER<br>PROJECT NOTICE GROUP MANAGEMENT ADMIN | 権限なし |
| | ロールグループロールタブCreate(作成)/Update(更新)/Delete(削除) | ADMIN<br>PROJECT MEMBER ADMIN | 権限なし |
| 通知受信グループの管理 | Read(読込)| ADMIN<br>PROJECT MANAGEMENT ADMIN<br>PROJECT MANAGEMENT VIEWER<br>PROJECT NOTICE GROUP MANAGEMENT ADMIN<br>PROJECT NOTICE GROUP MANAGEMENT VIEWER | 権限なし |
| | Create(作成)/Update(更新)/Delete(削除) | ADMIN<br>PROJECT MANAGEMENT ADMIN<br>PROJECT NOTICE GROUP MANAGEMENT ADMIN | 権限なし |
| 通知管理 | Read(読取)| ADMIN<br>MEMBER<br>PROJECT MANAGEMENT ADMIN<br>PROJECT MANAGEMENT VIEWER<br>PROJECT NOTICE GROUP MANAGEMENT ADMIN<br>PROJECT NOTICE MANAGEMENT ADMIN<br>PROJECT MANAGEMENT VIEWER | サービス ADMIN<br>サービス VIEWER |
| | Create(作成)/Update(更新)/Delete(削除) | ADMIN<br>MEMBER<br>PROJECT MANAGEMENT ADMIN<br>PROJECT NOTICE MANAGEMENT ADMIN | サービス ADMIN|
| 利用状況 | Read(読込) | ADMIN<br>BILLING VIEWER | 権限なし |
| プロジェクト設定 | プロジェクト基本情報Read(読込) | ADMIN<br>MEMBER<br>PROJECT MANAGEMENT ADMIN<br>PROJECT MANAGEMENT VIEWER<br>PROJECT MEMBER ADMIN <br>PROJECT MEMBER VIEWER <br>BILLING VIEWER <br>MARKETPLACE\_ADMIN <br>MARKETPLACE\_VIEWER<br>PROJECT NOTICE GROUP MANAGEMENT ADMIN<br>PROJECT NOTICE GROUP MANAGEMENT VIEWER<br>PROJECT API SECURITY SETTING ADMIN | サービスPERMISSION |
| | プロジェクト基本情報Create(作成)/Update(更新)/Delete(削除) | ADMIN<br>PROJECT MANAGEMENT ADMIN | 権限なし |
| | APIセキュリティー設定Read(読込) | ADMIN<br>PROJECT MANAGEMENT ADMIN<br>PROJECT MANAGEMENT VIEWER<br>MEMBER<br>PROJECT API SECURITY SETTING ADMIN | サービスPERMISSION  |
| | APIセキュリティー設定Create(作成)/Update(更新)/Delete(削除) | ADMIN<br>MEMBER<br>PROJECT MANAGEMENT ADMIN<br>PROJECT API SECURITY SETTING ADMIN | 権限なし |
| | 利用中のサービス(無効)Read(読込) | ADMIN<br>MEMBER<br>PROJECT MANAGEMENT ADMIN<br>PROJECT MANAGEMENT VIEWER<br>MARKETPLACE_ADMIN<br>MARKETPLACE_VIEWER | サービスPERMISSION |
| | 利用中のサービス(無効)Create(作成)/Update(更新)/Delete(削除) | ADMIN<br>PROJECT MANAGEMENT ADMIN(マーケットプレイスサービスは無効化ボタンが無効)<br>MARKETPLACE_ADMIN(プロジェクトサービスは無効化ボタンが無効) | サービスPERMISSION |
| | プロジェクト削除Read(読込) | ADMIN<br>MEMBER<br>PROJECT MANAGEMENT ADMIN<br>PROJECT MANAGEMENT VIEWER<br>PROJECT MEMBER ADMIN <br>PROJECT MEMBER VIEWER <br>BILLING VIEWER <br>MARKETPLACE\_ADMIN <br>MARKETPLACE\_VIEWER | サービスPERMISSION |
| | プロジェクト削除Create(作成)/Update(更新)/Delete(削除) | ADMIN<br>PROJECT MANAGEMENT ADMIN | 権限なし |
| クォーター管理 | Read(読込) | ADMIN<br>MEMBER<br>PROJECT MANAGEMENT ADMIN<br>PROJECT MANAGEMENT VIEWER<br>PROJECT QUOTA MANAGEMENT ADMIN<br>PROJECT QUOTA MANAGEMENT VIEWER | サービスADMIN<br>サービスVIEWER |
| | クォーター調整申請 | ADMIN<br>MEMBER<br>PROJECT MANAGEMENT ADMIN<br>PROJECT QUOTA MANAGEMENT ADMIN | サービスADMIN |

#### サービス利用ロール

| サービス | ロール | 説明 |
| --- | --- | --- |
| Infrastructure | ADMIN | Infrastructureサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除) |
| Infrastructure | MEMBER | VPC, Subnet, Network Interface, Routing, Network ACL, Internet Gateway, Peering Gateway, Colocation Gateway, NAT Gateway, VPC Gateway(Site-to-Site VPN), Service Gateway, Security Group, Load Balancer, NHN Kubernetes Service(NKS), NHN Container Service(NCS), Traffic mirroringサービスに対するRead(読み取り). などなどサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除) |
| Infrastructure | Load Balancer ADMIN | VVPC, Subnet, Network Interface, Routing, Network ACL, Internet Gateway, Peering Gateway, Colocation Gateway, NAT Gateway, VPC Gateway(Site-to-Site VPN), Service Gateway, Security Group, NHN Container Service(NCS), Traffic mirroring Read(読み取り). などなどサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除) |
| Infrastructure | Security Group ADMIN | VPC, Subnet, Network Interface, Routing, Network ACL, Internet Gateway, Peering Gateway, Colocation Gateway, NAT Gateway, VPN Gateway(Site-to-Site VPN), Service Gateway, Load Balancer, NHN Kubernetes Service(NKS), NHN Container Service(NCS), Traffic mirroringサービスに対するRead(読み取り). などなどサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除) |
| Infrastructure | Routing ADMIN | VPC, Subnet, Network Interface, Network ACL, Internet Gateway, Peering Gateway, Colocation Gateway, NAT Gateway, VPN Gateway(Site-to-Site VPN), Service Gateway, Security Group, Load Balancer, NHN Kubernetes Service(NKS), NHN Container Service(NCS), Traffic mirroringサービスRead（読込）。 このほか、サービスCreate(作成)、Read(読込)、Update(更新)、Delete(削除)|
| Infrastructure | NAT Gateway ADMIN | VPC, Subnet, Network Interface, Routing, Network ACL, Internet Gateway, Peering Gateway, Colocation Gateway, VPN Gateway(Site-to-Site VPN), Service Gateway, Security Group, Load Balancer, NHN Kubernetes Service(NKS), NHN Container Service(NCS), Traffic mirroringサービスRead（読込）。 このほか、サービスCreate(作成)、Read(読込)、Update(更新)、Delete(削除)|
| Infrastructure | Service Gateway ADMIN | VPC, Subnet, Network Interface, Routing, Network ACL, Internet Gateway, Peering Gateway, Colocation Gateway, NAT Gateway, VPN Gateway(Site-to-Site VPN), Security Group, Load Balancer, NHN Kubernetes Service(NKS), NHN Container Service(NCS), Traffic mirroringサービスRead（読込）。 このほか、サービスCreate(作成)、Read(読込)、Update(更新)、Delete(削除)|
| Infrastructure | NCS ADMIN | PC, Subnet, Network Interface, Routing, Network ACL, Internet Gateway, Peering Gateway, Colocation Gateway, NAT Gateway, VPC Gateway(Site-to-Site VPN), Service Gateway, Security Group, Load Balancer, NHN Kubernetes Service(NKS), Traffic mirroringサービスに対するRead(読み取り). などなどサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Virtual Desktop | ADMIN | Virtual Desktopサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除) |
| NHN Container Registry (NCR) | ADMIN | NHN Container Registry (NCR)サービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除) |
| NHN Container Registry (NCR) | VIEWER | NHN Container Registry (NCR)サービスに対するRead(読み取り) |
| NHN Container Registry (NCR) | IMAGE UPLOADER | NHN Container Registry (NCR) サービスに対するRead(読み取り), イメージ アップロード , アーティファクト Create(作成), タグ Create(作成) |
| DNS Plus | ADMIN | DNS Plusサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| DNS Plus | VIEWER | DNS Plusサービスに対するRead(読み取り) |
| Object Storage | ADMIN | Object Storageサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Backup | ADMIN | Backupサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| RDS for MySQL | ADMIN | RDS for MySQLサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| RDS for MySQL | VIEWER | RDS for MySQLサービスに対するRead(読み取り) |
| RDS for PostgreSQL | ADMIN | RDS for PostgreSQLサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| RDS for PostgreSQL | VIEWER | RDS for PostgreSQLサービスに対するRead(読み取り) |
| RDS for MariaDB | ADMIN | RDS for MariaDBサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| RDS for MariaDB | VIEWER | RDS for MariaDBサービスに対するRead(読み取り) |
| RDS for MS-SQL | ADMIN | RDS for MS-SQLサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| EasyCache | ADMIN | EasyCacheサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| EasyCache | VIEWER | EasyCacheサービスレプリケーショングループメニューRead(読込)、モニタリングメニューRead(読込) |
| Gamebase | ADMIN | Gamebase サービス Create(作成), Read(読み取り), Update(更新), Delete(削除) |
| Gamebase | ANALYTICS VIEWER - ALL | すべての指標Read(読み取り) |
| Gamebase | ANALYTICS VIEWER - EXCLUDING SALES | 売上を除くすべての指標Read(読み取り) |
| Gamebase | ANALYTICS VIEWER - ONLY REAL-TIME | リアルタイム指標Read(読み取り) |
| Gamebase | APP ADMIN | APPメニューCreate(作成)、Read(読み取り)、Update(更新)、Delete(削除) |
| Gamebase | APP VIEWER | APPメニューRead(読み取り) |
| Gamebase | BAN ADMIN | 利用停止メニューCreate(作成)、Read(読み取り)、Update(更新)、Delete(削除 |
| Gamebase | BAN VIEWER | 利用停止メニューRead(読み取り) |
| Gamebase | COUPON ADMIN | クーポンメニューCreate(作成)、Read(読み取り)、Update(更新)、Delete(削除) |
| Gamebase | COUPON VIEWER | クーポンメニューRead(読み取り) |
| Gamebase | CS ADMIN | サポートメニューCreate(作成)、Read(読み取り)、Update(更新)、Delete(削除) |
| Gamebase | CS INQUIRY SUPPORT | サポートお問い合わせメニューRead(読み取り)、Update(更新)およびメンバーメニューRead(読み取り) |
| Gamebase | IAP ADMIN | 購入メニューCreate(作成)、Read(読み取り)、Update(更新)、Delete(削除) |
| Gamebase | IAP VIEWER | 購入メニューRead(読み取り) |
| Gamebase | LEADERBOARD ADMIN | リーダーボードメニューCreate(作成)、Read(読み取り)、Update(更新)、Delete(削除) |
| Gamebase | LEADERBOARD VIEWER | リーダーボードメニューRead(読み取り) |
| Gamebase | MANAGEMENT ADMIN | 管理メニューCreate(作成)、Read(読み取り)、Update(更新)、Delete(削除) |
| Gamebase | MEMBER ADMIN | メンバーメニューCreate(作成)、Read(読み取り)、Update(更新)、Delete(削除) |
| Gamebase | MEMBER VIEWER | メンバーメニューRead(読み取り) |
| Gamebase | MEMBER FILE DOWNLOAD | メンバーダウンロードメニューRead(読み取り)およびファイルダウンロード |
| Gamebase | OPERATION ADMIN | 運営メニューCreate(作成)、Read(読み取り)、Update(更新)、Delete(削除) |
| Gamebase | OPERATION VIEWER | 運営メニューRead(読み取り) |
| Gamebase | PUSH ADMIN | プッシュメニューCreate(作成)、Read(読み取り)、Update(更新)、Delete(削除) |
| Gamebase | PUSH VIEWER | プッシュメニューRead(読み取り) |
| GameAnvil  | ADMIN | GameAnvil サービス Create(作成)、Read(読込)、Update(更新)、Delete(削除)  |
| GameAnvil  | MEMBER | GameAnvil サービス Read(読込), モニタリング メニュー Create(作成)、Read(読込)、Update(更新)、Delete(削除)  |
| GameAnvil  | VIEWER | GameAnvil サービス Read(読込)  |
| GameStarter  | ADMIN | ゲーム設定, 配布メニュー Create(作成)/ Read(読み取り)/ Update(更新)  |
| GameStarter  | VIEWER | ゲーム設定, 配布メニュー Read(読み取り)  |
| Leaderboard | ADMIN | Leaderboardサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Leaderboard | VIEWER | Leaderboardサービスに対するRead(読み取り) |
| Launching | ADMIN | Launchingサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Smart Downloader | ADMIN | Smart Downloaderサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| NHN AppGuard | ADMIN | AppGuardサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Server Security Check | ADMIN | Server Security Check サービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Security Monitoring | ADMIN | Security Monitoringサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| CAPTCHA | ADMIN | CAPTCHAサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| WEB Firewall | ADMIN | WEB Firewallサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Vaccine | ADMIN | Vaccineサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Secure Key Manager | ADMIN | Secure Key Managerサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Secure Key Manager | APPROVAL ADMIN | Secure Key Manager承認要請に対する承認/拒否/照会および承認要請生成/照会  |
| Secure Key Manager | APPROVAL MEMBER | Secure Key Manager承認要請作成/照会  |
| Secure Key Manager | VIEWER | Secure Key Managerサービスに対するRead(読み取り) |
| Security  Compliance | ADMIN | Security  Complianceサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Webshell Threat Detector | ADMIN | Webshell Threat Detectorサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除) |
| Security Advisor | ADMIN | Security Advisorサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Security Advisor | VIEWER | Security Advisorサービスに対するRead(読み取り)  |
| Network Firewall | ADMIN | Network Firewallサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Network Firewall | VIEWER | Network Firewallサービスに対するRead(読み取り)  |
| CDN | ADMIN | CDNサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Image Manager | ADMIN | Image Managerサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Push | ADMIN | Pushサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除) |
| SMS | ADMIN | SMSサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| SMS | SEND ADMIN | SMSサービス送信メニューCreate(作成)/Read(読み取り) |
| SMS | DELIVERY RESULT ADMIN | SMSサービスSMSリクエスト別照会メニューRead(読み取り)、照会結果ダウンロードCreate(作成), 大量SMS送信照会メニューRead(読み取り)、照会結果ダウンロードCreate(作成), タグSMS送信照会メニューRead(読み取り)、照会結果ダウンロードCreate(作成)  |
| SMS | SETTING ADMIN | SMSサービステンプレート管理メニューCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除), 発信番号 事前登録 メニューCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除), 発信番号照会メニューRead(読み取り), タグ管理メニューCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除), UID管理メニューCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除), Webフック管理メニューCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除), 080受信拒否設定メニューCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除), 送信設定メニューCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除), 統計イベントキー設定メニューCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| SMS | STATISTICS ADMIN | SMSサービス統計メニューRead(読み取り)、照会結果ダウンロードCreate(作成)  |
| RCS Bizmessage | ADMIN | RCS Bizmessageサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Email | ADMIN | Emailサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Email | SEND ADMIN | Emailサービスメール送信メニューCreate(作成)/Read(読み取り) |
| Email | DELIVERY RESULT ADMIN | Emailサービスメールリクエスト別照会メニュー Read(読み取り)、照会結果ダウンロードCreate(作成), メール予約送信照会メニュー Read(読み取り)、照会結果ダウンロードCreate(作成), 大量メール送信照会メニュー Read(読み取り)、照会結果ダウンロードCreate(作成), タグメール送信照会メニュー Read(読み取り)、照会結果ダウンロードCreate(作成)  |
| Email | SETTING ADMIN | Emailサービステンプレート管理メニューCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除), 受信拒否管理メニューCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除), メールドメイン管理メニューCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除), タグ管理メニューCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除), UID管理メニューCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除), 送信設定Create(作成)/Read(読み取り)/Update(更新)/Delete(削除), Webフック管理メニューCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Email | STATISTICS ADMIN | Emailサービス統計照会メニューRead(読み取り)、照会結果ダウンロードCreate(作成)  |
| KakaoTalk Bizmessage | ADMIN | KakaoTalk Bizmessageサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| KakaoTalk Bizmessage | SEND ADMIN | KakaoTalk Bizmessageサービス(お知らせトーク)送信メニューCreate(作成)/Read(読み取り), (カカともへのメッセージ)送信メニューCreate(作成)/Read(読み取り)  |
| KakaoTalk Bizmessage | DELIVERY RESULT ADMIN | KakaoTalk Bizmessageサービス(お知らせトーク)送信結果照会 Read(読み取り)、照会履歴のダウンロードCreate(作成), (お知らせトーク)大量送信照会 Read(読み取り)、照会結果ダウンロードCreate(作成), (カカともへのメッセージ)送信結果照会 Read(読み取り)、照会結果ダウンロードCreate(作成), (カカともへのメッセージ)大量送信照会 Read(読み取り)、照会結果ダウンロードCreate(作成)  |
| KakaoTalk Bizmessage | SETTING ADMIN | KakaoTalk Bizmessageサービス発信プロフィール管理メニューCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除), (お知らせトーク)テンプレート管理メニューCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除), (お知らせトーク)代替送信管理メニューCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除), (お知らせトーク)発信プロフィールグループ管理Create(作成)/Read(読み取り)/Update(更新)/Delete(削除), (カカともへのメッセージ)イメージ管理Create(作成)/Read(読み取り)/Update(更新)/Delete(削除), (カカともへのメッセージ)代替送信管理メニューCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除), 送信設定メニューCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除), Webフック管理メニューCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除), 統計イベントキー 設定メニューCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| KakaoTalk Bizmessage | STATISTICS ADMIN | KakaoTalk Bizmessageサービス統計メニューRead(読み取り)、照会結果ダウンロードCreate(作成)  |
| Face Recognition | ADMIN | Face Recognitionサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| AI Fashion | ADMIN | AI Fashionサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  | 
| OCR | ADMIN | OCRサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  | 
| Text to Speech | ADMIN | Text to Speechサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  | 
| Speech to Text | ADMIN | Speech to Textサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  | 
| Pose Estimation | ADMIN | Pose Estimationサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  | 
| AI EasyMaker | ADMIN | AI EasyMakerサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| IAP | ADMIN | IAPサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Mobile Device Info | ADMIN | Mobile Device Infoサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Log & Crash Search | ADMIN | Log & Crash Searchサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| DataFlow | ADMIN | DataFlowサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| DataQuery | ADMIN | DataQueryサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Maps | ADMIN | Mapsサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| ROLE | ADMIN | ROLEサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| API Gateway | ADMIN | API Gatewayサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| RTCS | ADMIN | RTCSサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| ShortURL | ADMIN | ShortURLサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| File-Crafter | ADMIN | File-Crafterサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Cloud Search | ADMIN | Cloud Searchサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Autocomplete | ADMIN | Autocompleteサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Corporation Search | ADMIN | Corporation Searchサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Word Suggestion | ADMIN | Word Suggestionサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Pipeline | ADMIN | Pipelineサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Deploy | ADMIN | Deployサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Deploy | VIEWER | Deployサービスに対するRead(読み取り)  |
| Managed | ADMIN | Managedサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Service Monitoring | ADMIN | Service Monitoringサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Certificate Manager | ADMIN | Certificate Managerサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| eTax | ADMIN | eTax サービスCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除) |
| eTax | VIEWER | eTaxサービスに対するRead(読み取り) |


#### サービス 有効化 ロール
サービスPERMISSIONロールは、個別サービスを有効化または無効化できます。

| ロール | 説明 |
| --- | --- |
| Service Name PERMISSION | サービス Enable(有効), Disable(無効)  |

## 決済管理

NHN Cloudサービス利用料金を確認し、決済できます。
**情報表示 > 決済管理**メニューで決済方法を登録したNHN Cloud会員の請求書と決済予定金額、使用量情報を確認できます。

決済方法を通して、該当の月に決済する内訳と下記の機能を提供します。

- 即時決済：毎月8日の自動決済前に即時決済機能で決済できます。
- 売上伝票：クレジットカードで決済した場合、売上伝票を照会できます。
- 税金計算書：口座振替で決済した場合、税金計算書を照会できます。

決済管理請求書で照会する内訳は下記のとおりです。

- 利用金額：サービス使用量と単価を計算した金額
- 割引/割増金額：約定割引、管理者割引/割増など
- 付加税：(利用金額 - 割引金額 + 割増金額)の10%
- 延滞料
    - 韓国会員：最終決済金額が未払いの時、該当金額の2%
    - 日本会員：日本消費者契約法により延滞料が発生しません。
- 最終決済金額：(利用金額 - 割引金額 + 割増金額) + 付加税


## 通知管理

通知管理機能は、NHN Cloudで送信する通知ごとに、受信する対象者と通知方法(Email、SMS)を設定できる機能です。

1. **組織 > 通知管理**または**プロジェクト > 通知管理**をクリックします。
    - 組織、プロジェクトごとに受信する通知を管理できます。

2. 通知リストで受信対象者を変更する通知を探し、**受信対象修正 > 修正** ボタンをクリックします。
    - 左側のリストから通知を選択するか、右上の検索領域で通知名、受信先などを検索して通知を探すことができます。
    - 複数の通知の受信者を一度に変更するには、通知のチェックボックスを選択した後、通知リスト上部の**受信対象一括修正**ボタンをクリックします。

3. メンバー、通知受信グループ、**役割別に通知受信対象および通知方法(Email、SMS)**を選択します。
    - 該当通知はWebhookをサポートしていません。
    - 通知ごとにサポートする通知方法が異なります。
    - 受信対象を通知受信グループを追加する場合、そのグループに設定された通知方法と各通知でサポートする通知方法が一致しなければ、その方法で通知を受信できません。

4. **保存**ボタンをクリックして設定内容を保存します。

