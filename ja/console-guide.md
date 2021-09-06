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


![tutorial_1_en.png](http://static.toastoven.net/toast/console_guide/consoleguide_01_202103_ja.png)
![tutorial_2_en.png](http://static.toastoven.net/toast/console_guide/consoleguide_02_202103_ja.png)
![tutorial_3_en.png](http://static.toastoven.net/toast/console_guide/consoleguide_03_202103_ja.png)
![tutorial_4_en.png](http://static.toastoven.net/toast/console_guide/consoleguide_04_202103_ja.png)
![tutorial_5_en.png](http://static.toastoven.net/toast/console_guide/consoleguide_05_202103_ja.png)


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

### 組織サービス

組織が作成されると、サービスを選択できます。
組織単位で有効にできるサービスは次のとおりです。

- Dooray!
- ERP
- Groupware
- Contact Center
- IDC
- CloudTrail

### 組織作成ガイド

![console_guide_1_ko.png](http://static.toastoven.net/toast/console_guide/consoleguide_06_202103_ja.png)

<center>[図1]組織の作成 </center>

1. コンソールに移動した後、上段メニューから**組織を作成してください。**横の**+**ボタンをクリックします。
2. **組織作成**ウィンドウで組織名を入力します。組織名には日本語、アルファベット、特殊文字、数字を使用できます。
3. **確認**ボタンをクリックすると組織作成が完了します。
4. コンソール上段メニューに作成された組織名が表示されます。
5. **設定**ボタンをクリックし、作成された組織情報を確認します。組織の追加情報にドメイン情報を入力します。ドメインはNHN Cloudで唯一の値に設定する必要があります。

### 組織の削除

- 組織の削除は組織のOWNERだけができます。
- 組織を削除するには、利用中のサービスをすべて削除する必要があります。
- 組織を削除すると、組織のすべての情報は削除され、復旧できません。

## プロジェクト管理

プロジェクトは組織作成後、NHN Cloudサービスを利用するために作成します。
プロジェクトではプロジェクトサービスを有効にして利用できます。
プロジェクトサービスはプロジェクト単位で利用し、これに応じて課金します。

### プロジェクトの作成

- プロジェクトを作成するには、組織を作成する必要があります。
- プロジェクトを作成した会員は、プロジェクトのAdmin権限を持ちます。
- プロジェクト作成時、プロジェクト名とプロジェクトの説明を入力します。
- プロジェクト作成後、プロジェクトサービスを有効にして利用できます。
- プロジェクト作成後、協業が必要な場合はプロジェクトメンバーに追加して一緒に使用できます。

### プロジェクトサービス

プロジェクトが作成されると、サービスを選択できます。
プロジェクト単位で有効にできるサービスは次のとおりです。

- Compute
- Container
- Network
- Storage
- Database
- Game
- Security
- Content Delivery
- Notification
- Mobile Service
- Analytics
- Application Service
- Search
- Dev Tool
- Management
- Bill
### プロジェクト作成ガイド

![console_guide_2_ko.png](http://static.toastoven.net/toast/console_guide/consoleguide_07_202103_ja.png)

<center>[図2]プロジェクト作成 </center>

1. 組織を作成すると、**新しいプロジェクト作成**ボタンが有効になります。**新しいプロジェクト作成**ボタンをクリックし、プロジェクトを作成します。
2. **プロジェクト名**と**プロジェクトの説明**を入力します。
3. **確認**ボタンをクリックし、プロジェクトを作成します。
4. プロジェクトが作成されると、メニューにプロジェクト名が表示されます。
5. **プロジェクト設定**ボタンをクリックし、プロジェクト情報を確認します。

### プロジェクトサービス有効化ガイド

![console_guide_3_ko.png](http://static.toastoven.net/toast/console_guide/consoleguide_08_202103_ja.png)

<center>[図3]プロジェクトサービスの有効化 </center>

1. プロジェクト作成後、**サービス選択**ボタンをクリックし、プロジェクトで使用するサービスを選択できます。
2. サービス選択画面で、有効にするサービスを選択します。サービスを有効にするかどうかの確認メッセージが表示されたら、**確認**をクリックします。
3. 有効にしたサービスリストは、コンソール左のメニューで確認できます。リストからサービスをクリックすると、サービス利用画面が表示されます。

### プロジェクトの削除

プロジェクトで利用中のサービスがない場合、プロジェクトを削除できます。
プロジェクトを削除すると、プロジェクトのすべてのリソースは削除され、復旧できません。
現在まで利用したすべてのリソースに対する利用内訳を即時決済して削除できます。
ただし、即時決済せずに削除する場合、現在まで利用した料金内訳は次の決済日に自動請求されます。

## メンバーの管理
メンバーの管理でユーザー別認証(ログイン)と権限付与が行えます。
プロジェクトと組織でメンバー管理を別々に行えます。
メンバーはNHN Cloud会員とIAM会員に分けられます。

### NHN Cloud会員とIAM会員ポリシー

| 区分         | TOAST.com会員                                             | IAM会員                             |
| :------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| 定義        | \- 組織管理のためのメンバー<br>\- NHN Cloud利用約款に同意したNHN Cloud会員で、サービス利用に対する責任と義務を有するメンバー<br>\- NHN Cloudサービス全体で有効なメンバーで、所属した組織が削除されてもNHN Cloud会員に存在 | \- サービス利用のためのメンバー<br>\- NHN Cloud利用約款に同意しないメンバー<br>\- 組織内でのみ有効なメンバー、所属した組織が削除されると削除されるメンバー | 
| メンバー登録方法 | \- 組織のOWNERまたはAdminがNHN Cloud IDを入力して登録        | \- 組織のOWNERまたはAdminが組織内で唯一のIDを入力して登録<br>\- SSO連動/API連携などを通して登録 |
| メンバー権限    | \- 組織管理(組織作成/修正/組織メンバー管理/組織サービス管理/決済管理\)<br>\- プロジェクト作成<br>\- プロジェクト削除 | \- 組織サービス利用 |
| コンソールにアクセス    | \- NHN Cloudコンソール(https://console.toast.com/)にアクセス <br>\- NHN Cloud> 会員ID/PWでログイン<br> (任意)2次(EmailまたはSMS)認証 | \- IAMコンソール(https://組織ドメイン.console.toast.com/)にアクセス<br> \- (Dooray!、ERPサービスは該当のサービスドメインでアクセス)<br> \- 組織のOWNER(またはAdmin)が設定したID/PWでログイン\- 組織で設定したログインセキュリティ(2次認証、サービス別設定)認証 |

### IP ACL設定

許可したIP(またはIP帯域)からのみIAMコンソールにアクセスできます。 
Dooray!サービスは該当サービスのコンソール画面でIP ACLを設定できます。

- サービス設定
    - 共通設定：すべてのサービスに同じようにIP ACLを設定できます。
    - サービス別設定：各サービス(Cloud、Online Contactm Workplace | Dooray!など)ごとにIP ACLを設定できます。    
- IP ACL設定
    - 設定しない：すべてのIP(またはIP帯域)からコンソールにアクセスできます。 
    - 許可したIP(またはIP帯域)のみコンソールにアクセス：入力したIP(またはIP帯域)からのみコンソールにアクセスできます。
    アクセスを許可するIPまたはIP帯域を入力してください。

### IAMコンソールログインセキュリティ設定
- IAM会員のコンソール接続セキュリティを強化するために、**ログインセキュリティ設定**機能を提供します。 


![iam_console_login_security_setting_guide_1_en.png](http://static.toastoven.net/toast/console_guide/consoleguide_09_202103_ja.png)

1. コンソールに移動した後、設定したい組織の組織設定ページに接続します。 
2. IAMコンソールの**ログインセキュリティ設定**ボタンをクリックします。 

#### 2次認証
2次認証を必須に設定できます。

- サービス
    - 共通設定
    - サービス(Cloud Console、 Dooray!、ERPなど)別設定

- 2次認証
    - 設定しない：2次認証を行わず、IDとパスワード入力のみでログインできます。 
    - Google OTP：IDとパスワードを入力した後、Google OTPアプリで提供するOne Time Passwordを入力し、認証後にログインできます。
    - メール：IDとパスワードを入力した後、メールアドレスに送信された**認証**ボタンをクリックして認証後にログインできます。 

- 例外IP
    - 設定しない
    - 設定

#### ログイン失敗セキュリティ
ログインを連続して失敗した時、一定時間経過後に再度ログインできるように設定できます。

- サービス
    - ログイン失敗セキュリティ設定は、サービスごとに別々に設定できません。共通設定機能のみ提供します。
- ログイン失敗セキュリティー
    - 設定しない：ログインに失敗しても継続してログインを試行できます。 
    - 設定：失敗回数とロック時間を入力すると、該当回数ログインに失敗するとロックされ、ロック時間中はログインを試行できません。 

#### ログインセッション
ログインセッション設定に応じてログインセッションが維持または、自動的に終了します。
ログインが終了した後は、再度ログインするとコンソールに接続できます。

- サービス
    - ログイン失敗セキュリティ設定は、サービスごとに別々に設定できません。共通設定機能のみ提供します。
- ログインセッション数
    - 複数の端末で、同じIDで同時にログインできる数を設定します。 
    - 1個に設定すると、同じIDでPC、スマートフォンなど、他の端末で同時にログインできません。 
        - 例) PC- ログイン維持、スマートフォン - 自動ログアウト
- ログインセッション維持時間 
    - クリックなどの作業が何もなくてもログインを維持する時間を設定します。 
    - 設定した時間中にクリックなどの作業を何もしなければ、自動的にログアウトします。 
    - 長めの設定は、セキュリティ上好ましくありません。よく考慮した上で、設定してください。


### 組織メンバー

- 組織のOWNERはアカウントのすべての権限を付与し、サービスを申請できます。 
- OWNERは会員を登録し、組織別の管理権限を付与できます。

#### NHN Cloud会員の組織権限

| 作業        | 役割                               | OWNER | Admin | MEMBER | Billing Viewer | Log Viewer |
| ------------- | ------------------------------- | ----- | ----- | ------ | -------------- | -------- |
| 組織管理   | 組織の作成                           | O     |       |        |                |  |
|               | 組織の修正                       | O     | O     |        |                |  |
|               | 組織の削除                       | O     |       |        |                |  |
| メンバー管理   | 組織メンバーの登録                | O     | O     |        |                |  |
|               | 組織メンバーの削除                | O     | O     |        |                |  |
| サービス管理 | 組織サービスの有効化                | O     | O     |        |                |  |
|               | 組織サービスの無効化              | O     | O     |        |                |  |
| 決済管理   | 請求書の照会                         | O     |       |        |                |  |
|               | 利用状況                         | O     | O     |        | O              |  |
| プロジェクト管理 | プロジェクトの作成              | O     | O     | O      |                |  |
|               | プロジェクトの削除(組織の全体プロジェクト) | O     | O     |        |                |  |
| ユーザーActionログの管理 | ユーザーActionログの照会          | O     | O     |       |                | O |

#### IAM会員の組織権限
- 組織サービスごと(Online Contact、Dooray!など)に設定できる権限が異なります。
- クラウドサービスの権限は下記のとおりです。
    - MEMBER権限は、希望する場合にのみ任意で付与できます。 
    - 権限がないIAM会員は、プロジェクト作成や削除、サービスの有効化などを行うことができません。メンバーに登録されたプロジェクトのみサービスを利用できます。 

| 作業        | 役割                               | MEMBER |
| ------------- | ----------------------------------- | ----- |
| プロジェクト管理 | プロジェクト作成           | O     |

### プロジェクトメンバー

組織のメンバーではなくてもプロジェクトのメンバーになることができます。
プロジェクトメンバーに必要な権限を複数付与できます。 

#### プロジェクト管理権限

| 権限 | 説明 |
| --- | --- |
| ADMIN | プロジェクト全体に対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 |
| MEMBER | プロジェクト内のすべてのサービスCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 |
| BILLING VIEWER | 利用状況Read(読み取り)権限 |
| PROJECT MANAGEMENT ADMIN | プロジェクト基本情報Update(更新)<br> プロジェクト統合Appkey Create(作成)/Read(読み取り)/Update(更新)/Delete(削除) <Br> プロジェクト権限グループCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除) <br> プロジェクトサービス有効化(Enable)/無効化(Disable) <br> プロジェクトDelete(削除)権限 |
| PROJECT MANAGEMENT VIEWER | プロジェクト基本情報Read(読み取り)<br> プロジェクト統合Appkey Read(読み取り)<br> プロジェクト権限グループRead(読み取り)権限 |
| PROJECT MEMBER ADMIN | プロジェクトメンバーCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 |
| PROJECT MEMBER VIEWER | プロジェクトメンバーRead(読み取り)権限 |

#### サービス利用権限

| サービス | 権限 | 説明 |
| --- | --- | --- |
| Infrastructure | ADMIN | Infrastructureサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 |
| Infrastructure | MEMBER | VPC, Security Group, Auto Scale, Load Balancerサービスに対するRead(読み取り. などなどサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 |
| Container Registry | ADMIN | Container Registryサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 |
| Container Registry | VIEWER | Container Registryサービスに対するRead(読み取り |
| DNS Plus | ADMIN | DNS Plusサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 権限 |
| Object Storage | ADMIN | Object Storageサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 権限 |
| Backup | ADMIN | Backupサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 権限 |
| RDS for MySQL | ADMIN | RDS for MySQLサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 権限 |
| RDS for MS-SQL | ADMIN | RDS for MS-SQLサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 権限 |
| EasyCache | ADMIN | EasyCacheサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 権限 |
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
| Leaderboard | ADMIN | Leaderboardサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 権限 |
| Leaderboard | VIEWER | Leaderboardサービスに対するRead(読み取り) |
| Launching | ADMIN | Launchingサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 権限 |
| Smart Downloader | ADMIN | Smart Downloaderサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 権限 |
| NHN AppGuard | ADMIN | AppGuardサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 権限 |
| App Security Check | ADMIN | Security Checkサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 権限 |
| Server Security Check | ADMIN | Server Security Check サービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 権限 |
| Security Monitoring | ADMIN | Security Monitoringサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 権限 |
| CAPTCHA | ADMIN | CAPTCHAサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 権限 |
| OTP | ADMIN | OTPサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 権限 |
| WEB Firewall | ADMIN | WEB Firewallサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 権限 |
| Vaccine | ADMIN | Vaccineサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 権限 |
| Secure Key Manager | ADMIN | Secure Key Managerサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 権限 |
| Secure Key Manager | VIEWER | Secure Key Managerサービスに対するRead(読み取り) |
| Security  Compliance | ADMIN | Security  Complianceサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 権限 |
| DDoS Guard | ADMIN | DDos Guardサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 権限 |
| SIEM | ADMIN | SIEMサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 権限 |
| CDN | ADMIN | CDNサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 権限 |
| Image | ADMIN | Imageサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 権限 |
| Push | ADMIN | Pushサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 権限 |
| SMS | ADMIN | SMSサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 権限 |
| Email | ADMIN | Emailサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 権限 |
| KakaoTalk Bizmessage | ADMIN | KakaoTalk Bizmessageサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 権限 |
| Face Recognition | ADMIN | Face Recognitionサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 権限 |
| AI Fashion | ADMIN | AI Fashionサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 権限 | 
| IAP | ADMIN | IAPサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 権限 |
| Mobile Device Info | ADMIN | Mobile Device Infoサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 権限 |
| Log & Crash Search | ADMIN | Log & Crash Searchサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 権限 |
| Maps | ADMIN | Mapsサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 権限 |
| ROLE | ADMIN | ROLEサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 権限 |
| API Gateway | ADMIN | API Gatewayサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 権限 |
| RTCS | ADMIN | RTCSサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 権限 |
| ShortURL | ADMIN | ShortURLサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 権限 |
| Cheating Detection | ADMIN | Cheating Detectionサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 権限 |
| Cloud Search | ADMIN | Cloud Searchサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 権限 |
| Autocomplete | ADMIN | Autocompleteサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 権限 |
| Corporation Search | ADMIN | Corporation Searchサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 権限 |
| Address Search | ADMIN | Address Searchサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 権限 |
| Pipeline | ADMIN | Pipelineサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 権限 |
| Deploy | ADMIN | Deployサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 権限 |
| Managed | ADMIN | Managedサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 権限 |
| Service Monitoring | ADMIN | Service Monitoringサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 権限 |
| Certificate Manager | ADMIN | Certificate Managerサービスに対するCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 権限 |
| eTax | ADMIN | eTax サービスCreate(作成)/Read(読み取り)/Update(更新)/Delete(削除)権限 |
| eTax | VIEWER | eTaxサービスに対するRead(読み取り)権限 |



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
