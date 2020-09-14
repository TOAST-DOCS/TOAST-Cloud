## TOAST > TOASTリージョンガイド
リージョンは、独立していて地理的に隔離されたサーバーの物理的な位置を意味します。
一般的にリージョンは、アベイラビリティゾーンと呼ぶ独立した電源およびネットワークを持つデータセンターで構成され、使用したい地域とサービスに応じてリージョンを選択できます。 <br>
インターネットで、いつどこでも自由にリージョンを選択してTOASTサービスを利用できます。

## TOASTリージョン

TOASTは、安定的なグローバルサービスを提供するために、4個のリージョンを運用しています。
高可用性をサポートするには、複数のアベイラビリティゾーンまたは複数のリージョンにアプリケーションを配布する必要があります。
TOASTユーザーは、サービス地域と目的に応じて使用するリージョンを選択できます。一般的に主なサービス対象になる地域のリージョンを利用すると、短いレスポンス時間が期待できます。

## TOASTリージョン位置
TOASTは、グローバルなサービスを提供するために、多くの地域にリージョンを拡大しています。
![region_guide%2001.png](https://static.toastoven.net/toast/region_guide/region_guide%2001.png)

## TOASTリージョンサービス

**リージョンサービス**
リージョンサービスは、サービスを提供するリージョンのインフラ環境と国/地域/法律/商品でサービスする内容の制限により、特定地域にのみ提供されるサービスです。
物理的なサービスの提供位置が異なる必要がある場合や、データの二重化構成を行うためにも利用します。
リージョンサービスは、特定リージョンでのみ利用でき、リージョンごとに課金ポリシーが異なる場合があります。

**グローバルサービス**
グローバルサービスは、すべてのリージョンで使用できるサービスです。
すべてのユーザーに同じ機能とポリシー、安定性、ユーザビリティを提供し、すべてのリージョンを選択できます。

**グローバル/リージョン別提供サービス**

| 分類 | サービス名 | グローバル/リージョンサービス | 韓国(パンギョ)リージョン | 韓国(坪村)リージョン | 日本(東京)リージョン | 米国(カリフォルニア)リージョン |
| --- | ---- | :--------: | :-------: | :-------: | :-------: | :----------: |
| Compute | Instance | リージョン | O | O | O | O |
|  | GPU Instance | リージョン | O |  |  |  |
|  | Image | リージョン | O | O | O | O |
|  | Auto Scale | リージョン | O | O | O | O |
|  | System Monitoring | リージョン | O | O | O | O |
| Container | Kubernetes | リージョン | O |  |  |  |
|  | Container Registry | リージョン | O |  |  |  |
| Network | VPC | リージョン | O | O | O | O |
|  | 一般Load Balancer | リージョン | O | O | O | O |
|  | 専用Load Balancer | リージョン | O | O | O | O |
|  | 物理Load Balancer | リージョン | O | O |  |  |
|  | DNS Plus | グローバル |  |  |  |  |
| Storage | Block Storage | リージョン | O | O | O | O |
|  | NAS (offline) | リージョン | O | O  |  | O |
|  | Object Storage | リージョン | O | O | O | O |
|  | Backup | リージョン | O | O  | O |  |
| Database | RDS for MySQL | リージョン | O | O | O |  |
|  | RDS for MS-SQL | リージョン | O |  |  |  |
|  | EasyCache | リージョン | O |  | O |  |
|  | MS-SQL Instance | リージョン | O | O | O | O |
|  | MySQL Instance | リージョン | O | O | O | O |
| Game | Gamebase | グローバル |  |  |  |  |
|  | Leaderboard | グローバル |  |  |  |  |
|  | Launching | グローバル |  |  |  |  |
|  | Smart Downloader | グローバル |  |  |  |  |
| Security | AppGuard | グローバル |  |  |  |  |
|  | Security Check | リージョン | O |  |  |  |
|  | Security Monitoring | リージョン | O | O |  |  |
|  | Basic Security | リージョン | O |O |  |  |
|  | CAPTCHA | リージョン | O |  |  |  |
|  | OTP | リージョン | O |  |  |  |
|  | DBSafer | リージョン | O | O  |  |  |
|  | Web Firewall | リージョン | O | O  |  |  |
|  | Vaccine | リージョン | O | O |  |  |
|  | Secure Key Manager | グローバル |  |  |  |  |
| Content Delivery | CDN | グローバル |  |  |  |  |
|  | Image | リージョン | O |  |  |  |
| Notification | Push | グローバル |  |  |  |  |
|  | SMS | リージョン | O |  |  |  |
|  | Email | グローバル |  |  |  |  |
|  | KakaoTalk Bizmessage | リージョン | O |  |  |  |
| Mobile Service | IAP | グローバル |  |  |  |  |
|  | Mobile Device Info | グローバル |  |  |  |  |
| Analytics | Log & Crash Search | グローバル |  |  |  |  |
| Application Service | Maps | リージョン | O |  |  |  |
|  | ROLE | グローバル |  |  |  |  |
|  | API Gateway | リージョン | O |  |  |  |
|  | RTCS | グローバル |  |  |  |  |
| Search | Cloud Search | リージョン | O |  |  |  |
|  | Autocomplete | リージョン | O |  |  |  |
|  | Corporation Search | リージョン | O |  |  |  |
|  | Address Search | リージョン | O |  |  |  |
| Dev Tools | Deploy | グローバル |  |  |  |  |
| Management | Managed | リージョン | O | O |  |  |
|  | Service Monitoring | グローバル |  |  |  |  |
|  | Certificate Manager | グローバル |  |  |  |  |
| Workplace Dooray! | Project | グローバル |  |  |  |  |
|  | Messenger | グローバル |  |  |  |  |
|  | Mail | グローバル |  |  |  |  |
|  | Calendar | グローバル |  |  |  |  |
|  | Drive | グローバル |  |  |  |  |
|  | Contacts | グローバル |  |  |  |  |
|  | ウィキ | グローバル |  |  |  |  |
| Workplace \| ERP | Human resources | リージョン | O |  |  |  |
|  | Finance | リージョン | O |  |  |  |
| Workplace\| Groupware | Communication Board | リージョン | O |  |  |  |
|  | Workflow | リージョン | O |  |  |  |
| Contact Center | Omni Contact | リージョン | O |  |  |  |
|  | Mobile Contact | リージョン | O |  |  |  |
|  | Online Contact | グローバル |  |  |  |  |
| Bill | Bill (e-Tax) | リージョン | O |  |  |  |
| IDC | TCC | リージョン | O |  |  |  |
| CloudTail | CloudTail | グローバル |  |  |  |  |
