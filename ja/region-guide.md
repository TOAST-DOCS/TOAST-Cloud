## NHN Cloud > リージョンガイド
リージョンは、独立していて地理的に隔離されたサーバーの物理的な位置を意味します。
一般的にリージョンは、アベイラビリティゾーンと呼ぶ独立した電源およびネットワークを持つデータセンターで構成され、使用したい地域とサービスに応じてリージョンを選択できます。 <br>
インターネットで、いつどこでも自由にリージョンを選択してNHN Cloudサービスを利用できます。

## NHN Cloudリージョン

NHN Cloudは、安定的なグローバルサービスを提供するために、4個のリージョンを運用しています。
高可用性をサポートするには、複数のアベイラビリティゾーンまたは複数のリージョンにアプリケーションを配布する必要があります。
NHN Cloudユーザーは、サービス地域と目的に応じて使用するリージョンを選択できます。一般的に主なサービス対象になる地域のリージョンを利用すると、短いレスポンス時間が期待できます。

## NHN Cloudリージョン位置
NHN Cloudは、グローバルなサービスを提供するために、多くの地域にリージョンを拡大しています。
![region_guide%2001.png](https://static.toastoven.net/toast/region_guide/Region_guide_2021.png)

## NHN Cloudリージョンサービス

**リージョンサービス**
リージョンサービスは、サービスを提供するリージョンのインフラ環境と国/地域/法律/商品でサービスする内容の制限により、特定地域にのみ提供されるサービスです。
物理的なサービスの提供位置が異なる必要がある場合や、データの二重化構成を行うためにも利用します。
リージョンサービスは、特定リージョンでのみ利用でき、リージョンごとに課金ポリシーが異なる場合があります。

**グローバルサービス**
グローバルサービスは、すべてのリージョンで使用できるサービスです。
すべてのユーザーに同じ機能とポリシー、安定性、ユーザビリティを提供し、すべてのリージョンを選択できます。

**グローバル/リージョン別提供サービス**

| 分類 | サービス名 | グローバル/リージョンサービス | 韓国(パンギョ)リージョン | 韓国(ピョンチョン)リージョン | 日本(東京)リージョン | 米国(カリフォルニア)リージョン |
| --- | ---- | :--------: | :-------: | :-------: | :-------: | :----------: |
| Compute | Instance | リージョン | O | O | O | O |
|  | Ephemeral Storage Instance | リージョン | O | | O | | 
|  | GPU Instance | リージョン | O |  |  |  |
|  | Instance Template | リージョン | O | O | O | O |
|  | Image | リージョン | O | O | O | O |
|  | Image Builder  | リージョン | O | O |  |  |
|  | Auto Scale | リージョン | O | O | O | O |
|  | Virtual Desktop | リージョン | O | O |  |  |
|  | Cloud Functions | リージョン | O |  |  |  |
| Container | NHN Kubernetes Service(NKS) | リージョン | O | O |  |  |
|  | NHN Container Registry (NCR) | リージョン | O | O |  |  |
|  | NHN Container Service(NCS)  | リージョン | O |  |  |  |
| Network | VPC | リージョン | O | O | O | O |
|  | NAT Instance | リージョン | O | O |  |  |
|  | Floating IP | リージョン | O | O | O | O |
|  | Security Groups | リージョン | O | O | O | O |
|  | Network ACL | リージョン | O | O |  |  |
|  | Network Interface | リージョン | O | O | O | O |
|  | Flow Log | リージョン | O | O |  |  |
|  | 一般Load Balancer | リージョン | O | O | O | O |
|  | 専用Load Balancer | リージョン | O | O | O | O |
|  | Transit Hub | リージョン | O | O |  |  |
|  | Internet Gateway | リージョン | O | O | O | O |
|  | Peering Gateway | リージョン | O | O | O | O |
|  | Colocation Gateway | リージョン | O | O |  |  |
|  | NAT Gateway | リージョン | O | O |  |  |
|  | VPN Gateway(Site-to-Site VPN) | リージョン |  | O |  |  |
|  | Service Gateway | リージョン | O | O |  |  |
|  | Traffic Mirroring | リージョン | O | O | | |
|  | Private DNS | リージョン | O | O | | |
|  | DNS Plus | グローバル |  |  |  |  |
|  | Direct Connect | リージョン | O | O | | |
| Storage | Block Storage | リージョン | O | O | O | O |
|  | NAS (offline) | リージョン |  | O  |  | O |
|  | NAS | リージョン | O | O  |  |  |
|  | Object Storage | リージョン | O | O | O | O |
|  | Backup | リージョン | O | O  | O |  |
|  | Storage Gateway | リージョン | O | | | |
|  | Data transporter | リージョン | O | O  |  |  |
| Monitoring | Service Monitoring | グローバル |  |  |  |  |
|  | Cloud Monitoring | グローバル |  |  |  |  |
| Database | RDS for MySQL | リージョン | O | O | O |  |
|  | RDS for PostgreSQL  | リージョン | O |  |  |  |
|  | RDS for MariaDB | リージョン | O |  |  |  |
|  | RDS for MS-SQL | リージョン | O |  |  |  |
|  | EasyCache | リージョン | O | O |  |  |
|  | MS-SQL Instance | リージョン | O | O | O | O |
|  | MySQL Instance | リージョン | O | O | O | O |
|  | PostgreSQL Instance | リージョン | O | O | O | O |
|  | CUBRID Instance  | リージョン | O | O | O | O |
|  | MariaDB Instance  | リージョン | O | O | O | O |
|  | Tibero Instance   | リージョン | O | O | O | O |
|  | Redis Instance | リージョン | O | O | O | O |
| Hybrid & Private Cloud | NHN Cloud Private Deck | リージョン | - | - | - | - |
|  | NHN Cloud Private Station | リージョン | - | - | - | - |
|  | NHN Cloud Private Region | リージョン | - | - | - | - |
|  | NHN Hybrid Cloud | リージョン | O |  |  |  |
| Game | Gamebase | グローバル |  |  |  |  |
|  | GameAnvil | グローバル |  |  |  |  |
|  | GameStarter | グローバル |  |  |  |  |
|  | Leaderboard | グローバル |  |  |  |  |
|  | Launching | グローバル |  |  |  |  |
|  | Smart Downloader | グローバル |  |  |  |  |
| Security | NHN AppGuard | グローバル |  |  |  |  |
|  | App Security Check | リージョン | O |  |  |  |
|  | Server Security Check | リージョン | O | O |  |  |
|  | Security Monitoring | リージョン | O | O |  |  |
|  | Basic Security | リージョン | O |O |  |  |
|  | CAPTCHA | リージョン | O |  |  |  |
|  | Web Firewall | リージョン | O | O  |  |  |
|  | Vaccine | リージョン | O | O |  |  |
|  | Secure Key Manager | グローバル |  |  |  |  |
|  | Security Compliance | グローバル |  |  |  |  |
|  | DDoS Guard | リージョン | O | O  |  |  |
|  | SIEM | リージョン | O |O |  |  |
|  | Webshell Threat Detector | リージョン | O | O |  |  |
|  | Security Advisor | グローバル |  |  |  |  |
|  | Network Firewall | リージョン | O | O |  |  |
|  | NHN Bastion | リージョン | O | O |  |  |
|  | Cloud Access | リージョン | O | O |  |  |
| Content Delivery | CDN | グローバル |  |  |  |  |
|  | Image Manager | リージョン | O |  |  |  |
| Notification | Notification Hub | グローバル |  |  |  |  |
|  | Push | グローバル |  |  |  |  |
|  | SMS | グローバル |  |  |  |  |
|  | RCS Bizmessage | グローバル |  |  |  |  |
|  | Email | グローバル |  |  |  |  |
|  | KakaoTalk Bizmessage | グローバル |  |  |  |  |
| AI Service | Face Recognition | グローバル |  |  |  |  |
|  | AI Fashion | グローバル |  |  |  |  |
|  | OCR | グローバル |  |  |  |  |
|  | Text to Speech | グローバル |  |  |  |  |
|  | Speech to text | グローバル |  |  |  |  |
| Machine Learning | Deep Learning Instance | リージョン | O |  | | |
|  | AI EasyMaker | リージョン | O |  |  |  |
| Application Service | Maps | リージョン | O |  |  |  |
|  | ROLE | グローバル |  |  |  |  |
|  | API Gateway | リージョン | O | O |  |  |
|  | RTCS | グローバル |  |  |  |  |
|  | Short URL | グローバル |  |  |  |  |
|  | JEUS Instance | リージョン | O | O | O | O |
|  | WebtoB Instance | リージョン | O | O | O | O |
|  | Cloud Scheduler | グローバル |  |  |  |  |
| Mobile Service | IAP | グローバル |  |  |  |  |
| Search | Cloud Search | リージョン | O |  |  |  |
|  | Autocomplete | リージョン | O |  |  |  |
|  | Corporation Search | リージョン | O |  |  |  |
| Data & Analytics | Log & Crash Search | グローバル |  |  |  |  |
|  | DataFlow | リージョン | O |  |  |  |
|  | DataQuery | リージョン | O |  |  |  |
|  | Kafka Instance | リージョン | O | O | O | O |
| Dev Tools | Pipeline | リージョン | O |  |  |  |
|  | Deploy | グローバル |  |  |  |  |
| Management | Managed | リージョン | O | O |  |  |
|  | Support Plan | リージョン | O | O |  |  |
|  | Certificate Manager | グローバル |  |  |  |  |
| Bill | eTax | リージョン | O |  |  |  |
| Collaboration | Dooray! | グローバル |  |  |  |  |
| Contact Center | Omni Contact | リージョン | O |  |  |  |
|  | Mobile Contact | リージョン | O |  |  |  |
|  | Contiple | グローバル |  |  |  |  |
| IDC | NCC | リージョン | O |  |  |  |
| Governance & Audit | CloudTrail | グローバル |  |  |  |  |
|  | Resource Watcher | グローバル |  |  |  |  |
