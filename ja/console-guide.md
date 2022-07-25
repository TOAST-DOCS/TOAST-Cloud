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



### 組織の削除

- 組織の削除は組織のOWNERだけができます。
- 組織を削除するには、利用中のサービスをすべて削除する必要があります。
- 組織を削除すると、組織のすべての情報は削除され、復旧できません。

### 組織ガバナンス設定

ログインおよび個人情報など、セキュリティコンプライアンス遵守のための組織の共通ポリシーを策定し、組織内のメンバーがポリシーを遵守できるように管理します。

#### IP ACL設定
許可したIP(またはIP帯域)からのみコンソールにアクセスできます。
Dooray!サービスは各サービスコンソール画面からIP ACLを設定できます。
![console_guide_3_jp.png](http://static.toastoven.net/toast/console_guide/consoleguide_05_202109_jp.png)

1. コンソールに移動した後、設定したい組織の組織管理ページに接続します。
2. サブメニューからガバナンス設定を選択します。
3. 組織ガバナンス設定の**IP ACL設定**でIP ACLを設定し、管理できます。
   * サービス設定
       * 共通設定：すべてのサービスに同じようにIP ACLを設定できます。
       * サービスの設定：各サービス(Cloud Console、Online Contact, Dooray!など)ごとにIP ACLを設定できます。
   * IP ACL
        * 設定しない：すべてのIP(またはIP帯域)からコンソールにアクセスできます。
        * 許可したIP(またはIP帯域)のみコンソールアクセス：入力したIP(またはIP帯域)からのみコンソールにアクセスできます。アクセスを許可するIPまたはIP帯域を入力します。

### IAMガバナンス設定

#### ログインセキュリティ設定

* IAMメンバーのコンソール接続セキュリティを強化するために**ログインセキュリティ設定**機能を提供します。
* すべての組織サービス(コンソール、Online Contact、Dooray!など)に同じように設定したり、サービスごとに設定できます。
![console_guide_4_jp.png](http://static.toastoven.net/toast/console_guide/consoleguide_06_202109_jp.png)

1. コンソールに移動した後、設定したい組織の組織管理ページに接続します。
2. サブメニューのガバナンス設定を選択します。
3. IAMガバナンス設定のログインセキュリティ設定を設定して管理できます。

#### 2次認証

2次認証を必須に設定して使用するようにできます。

* サービス設定
    * 共通設定：すべての組織サービスに同じように2次認証を設定します。
    * サービス別設定：各サービス(Cloud Console, Online Contact, Dooray!など)ごとに2次認証を設定できます。
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

### プロジェクト共通役割グループ設定

組織に属しているプロジェクトにおいて共通で使用する役割グループを作成し、管理できます。
設定された役割グループはプロジェクトの役割グループ管理からNHN Cloud会員およびIAMメンバーを選択して役割を一括付与できます。

1. 組織設定を選択した後、プロジェクト共通役割グループ設定メニューをクリックします。
2. **役割グループ追加**を選択して、サービスごとに役割を追加します。
3. 役割グループ名、説明を入力し、サービスごとに役割を追加します。
    * 役割グループ名は日本語、アルファベット、特殊文字を使用可能で、最大40文字まで入力できます。
    * 説明は最大100文字まで入力できます。
4. 役割は**サービスごとに細分化された利用役割**を選択できます。
    * サービス名を左側の領域から検索した後、右側の領域で役割を選択します。
5. 選択された役割を確認して追加または削除できます。
    * サービス名の横にあるxボタンをクリックして、選択されたサービスを削除できます。
6. 追加ボタンをクリックして役割グループを追加します。
7. 役割グループが追加されると、役割グループリストに名前が表示されます。役割グループ名を選択して、詳細役割内容を確認できます。
8. 役割追加をクリックすると、3回役割グループ追加画面に移動します。役割を追加または削除できます。

## プロジェクト管理

プロジェクトは組織作成後、NHN Cloudサービスを利用するために作成します。
プロジェクトではプロジェクトサービスを有効にして利用できます。
プロジェクトサービスはプロジェクト単位で利用し、これに応じて課金します。

### プロジェクトの作成

* プロジェクトを作成するには、組織を作成する必要があります。
* プロジェクトを作成した会員は、プロジェクトのAdmin役割を持ちます。
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
* Game
* Security
* Content Delivery
* Notification
* Mobile Service
* Analytics
* Application Service
* Search
* Dev Tool
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

メンバーの管理でユーザー別認証(ログイン)と役割付与が行えます。
プロジェクトと組織でメンバー管理を別々に行えます。
メンバーはNHN Cloud会員とIAMメンバーに分けられます。

### NHN Cloud会員とIAMメンバーポリシー

| 区分 | [NHN Cloud](http://TOAST.com)会員 | IAMメンバー |
| --- | --- | --- |
| 定義      | - 組織管理のためのメンバー<br>- NHN Cloud利用約款に同意したNHN Cloud会員で、サービス利用に対する責任と義務を有するメンバー<br>- NHN Cloudサービス全体で有効なメンバーで、所属した組織が削除されてもNHN Cloud会員に存在 | - サービス利用のためのメンバー<br>- NHN Cloud利用約款に同意しないメンバー<br>- 組織内でのみ有効なメンバー、所属した組織が削除されると削除されるメンバー | 
| メンバー登録方法 | - 組織のOWNERまたはAdminがNHN Cloud IDを入力して登録 | - 組織のOWNERまたはAdminが組織内で唯一のIDを入力して登録<br>- SSO連動/API連携などを通して登録 |
| メンバー役割 | - 組織管理(組織作成/修正/組織メンバー管理/組織サービス管理/決済管理)<br>- プロジェクト作成<br>- プロジェクト削除 | - 組織サービス利用 |
| コンソールアクセス | - NHN Cloudコンソール([https://console.toast.com/](https://console.toast.com/)アクセス<br>- NHN Cloud> 会員ID/パスワードでログイン<br>- (任意) 2次(メールまたはSMS)認証 | - IAMコンソール([https://組織ドメイン.console.toast.com/](https://%EC%A1%B0%EC%A7%81%EB%8F%84%EB%A9%94%EC%9D%B8.console.toast.com/))アクセス<br>- (Dooray!、ERPサービスは該当サービスドメインでアクセス)<br>- 組織のOWNER(またはADMIN)が設定したID/PWでログイン- 組織で設定したログインセキュリティ(2次認証、サービス別設定)認証 |


### 組織メンバー

- 組織のOWNERはアカウントのすべての役割を付与し、サービスを申請できます。 
- OWNERは会員を登録し、組織別の管理役割を付与できます。

#### NHN Cloud会員の組織役割

| 作業 | 役割 | OWNER | ADMIN | MEMBER | Billing Viewer | Log Viewer |
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

#### IAMメンバーの組織役割

* 組織サービスごと(Online Contact、Dooray!など)に設定できる役割が異なります。
* クラウドサービスの役割は下記のとおりです。
    * MEMBER役割は、希望する場合にのみ任意で付与できます。 
    * 役割がないIAMメンバーは、プロジェクト作成や削除、サービスの有効化などを行うことができません。メンバーに登録されたプロジェクトのみサービスを利用できます。 

| 作業 | 役割 | MEMBER |
| --- | --- | --- |
| プロジェクト管理 | プロジェクト作成 | O |

### プロジェクトメンバー

組織のメンバーではなくてもプロジェクトのメンバーになることができます。
プロジェクトメンバーに必要な役割を複数付与できます。 

#### プロジェクト管理役割

| 役割 | 説明 |
| --- | --- |
| ADMIN | プロジェクト全体に対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除) |
| MEMBER | プロジェクト内のすべてのサービスCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除) |
| BILLING VIEWER | 利用状況Read(読み取り) |
| PROJECT MANAGEMENT ADMIN | プロジェクト基本情報Update(更新)<br> プロジェクト統合Appkey Create(作成)/Read(読み取り)/Update(更新)/Delete(削除) <Br> プロジェクト役割グループCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除) <br> プロジェクトサービス有効化(Enable)/無効化(Disable) <br> プロジェクトDelete(削除) |
| PROJECT MANAGEMENT VIEWER | プロジェクト基本情報Read(読み取り)<br> プロジェクト統合Appkey Read(読み取り)<br> プロジェクト役割グループRead(読み取り) |
| PROJECT MEMBER ADMIN | プロジェクトメンバーCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除) |
| PROJECT MEMBER VIEWER | プロジェクトメンバーRead(読み取り) |

#### サービス利用役割

| サービス | 役割 | 説明 |
| --- | --- | --- |
| Infrastructure | ADMIN | Infrastructureサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除) |
| Infrastructure | MEMBER | VPC, Subnet, Network Interface, Routing, Floating IP, Network ACL, NAT Instance, Internet Gateway, Peering Gateway, Colocation Gateway, NAT Gateway, VPC Gateway(Site-to-Site VPN), Service Gateway, Security Group, Load Balancer, Auto Scaleサービスに対するRead(読み取り. などなどサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除) |
| Infrastructure | Load Balancer ADMIN | VPC, Subnet, Network Interface, Routing, Floating IP, Network ACL, NAT Instance, Internet Gateway, Peering Gateway, Colocation Gateway, NAT Gateway, VPC Gateway(Site-to-Site VPN), Service Gateway, Security Groupサービスに対するRead(読み取り. などなどサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除) |
| Infrastructure | Security Group ADMIN | VPC, Subnet, Network Interface, Routing, Floating IP, Network ACL, NAT Instance, Internet Gateway, Peering Gateway, Colocation Gateway, NAT Gateway, VPN Gateway(Site-to-Site VPN), Service Gateway, Load Balancer, Auto Scaleサービスに対するRead(読み取り. などなどサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除) |
| Virtual Desktop | ADMIN | Virtual Desktopサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除) |
| NHN Container Registry (NCR) | ADMIN | NHN Container Registry (NCR)サービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除) |
| NHN Container Registry (NCR) | VIEWER | NHN Container Registry (NCR)サービスに対するRead(読み取り |
| DNS Plus | ADMIN | DNS Plusサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Object Storage | ADMIN | Object Storageサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Backup | ADMIN | Backupサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| RDS for MySQL | ADMIN | RDS for MySQLサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| RDS for MySQL | VIEWER | RDS for MySQLサービスに対するRead(読み取り) |
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
| GameStarter  | ADMIN | ゲーム設定, 配布メニュー Create(作成)/ Read(読み取り)/ Update(更新)  |
| GameStarter  | VIEWER | ゲーム設定, 配布メニュー Read(読み取り)  |
| Leaderboard | ADMIN | Leaderboardサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Leaderboard | VIEWER | Leaderboardサービスに対するRead(読み取り) |
| Launching | ADMIN | Launchingサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Smart Downloader | ADMIN | Smart Downloaderサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| NHN AppGuard | ADMIN | AppGuardサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| App Security Check | ADMIN | Security Checkサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Server Security Check | ADMIN | Server Security Check サービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Security Monitoring | ADMIN | Security Monitoringサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| CAPTCHA | ADMIN | CAPTCHAサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| OTP | ADMIN | OTPサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| WEB Firewall | ADMIN | WEB Firewallサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Vaccine | ADMIN | Vaccineサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Secure Key Manager | ADMIN | Secure Key Managerサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Secure Key Manager | VIEWER | Secure Key Managerサービスに対するRead(読み取り) |
| Security  Compliance | ADMIN | Security  Complianceサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| DDoS Guard | ADMIN | DDos Guardサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| SIEM | ADMIN | SIEMサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| CDN | ADMIN | CDNサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Image | ADMIN | Imageサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Push | ADMIN | Pushサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除) |
| SMS | ADMIN | SMSサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Email | ADMIN | Emailサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| KakaoTalk Bizmessage | ADMIN | KakaoTalk Bizmessageサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Face Recognition | ADMIN | Face Recognitionサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| AI Fashion | ADMIN | AI Fashionサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  | 
| Document Recognizer | ADMIN | Document Recognizerサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  | 
| Vehicle Plate Recognizer | ADMIN | Vehicle Plate Recognizerサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Text to Speech | ADMIN | Text to Speechサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  | 
| Speech to Text | ADMIN | Speech to Textサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  | 
| Cheating Detection | ADMIN | Cheating Detectionサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| IAP | ADMIN | IAPサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Mobile Device Info | ADMIN | Mobile Device Infoサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Log & Crash Search | ADMIN | Log & Crash Searchサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Maps | ADMIN | Mapsサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| ROLE | ADMIN | ROLEサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| API Gateway | ADMIN | API Gatewayサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| RTCS | ADMIN | RTCSサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| ShortURL | ADMIN | ShortURLサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Cloud Search | ADMIN | Cloud Searchサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Autocomplete | ADMIN | Autocompleteサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Corporation Search | ADMIN | Corporation Searchサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Address Search | ADMIN | Address Searchサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Pipeline | ADMIN | Pipelineサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Deploy | ADMIN | Deployサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Managed | ADMIN | Managedサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Service Monitoring | ADMIN | Service Monitoringサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| Certificate Manager | ADMIN | Certificate Managerサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)  |
| eTax | ADMIN | eTax サービスCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除) |
| eTax | VIEWER | eTaxサービスに対するRead(読み取り) |
| marketplace | ADMIN | marketplaceプロジェクトサービスCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除) |
| marketplace | ADMIN | marketplaceプロジェクトサービスに対するRead(読み取り) |



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
