
## NHN Cloud > 리전 가이드
리전은 독립적이고 지리적으로 격리된 서버의 물리적 위치를 의미합니다.
일반적으로 리전은 가용성 영역이라고 부르는 독립된 전원 및 네트워크를 갖춘 데이터 센터로 구성되며, 사용하려는 지역과 서비스에 따라 리전을 선택할 수 있습니다.
인터넷으로 언제 어디서나 자유롭게 리전을 선택하여 NHN Cloud 서비스를 이용하세요.

## NHN Cloud 리전

NHN Cloud는 안정적인 글로벌 서비스 제공을 위해 4개의 리전을 운영하고 있습니다.
고가용성을 지원하기 위해서는 여러 가용성 영역 혹은 복수의 리전에 애플리케이션을 배포해야 합니다.
NHN Cloud 유저는 서비스 지역과 목적에 따라 사용할 리전을 선택할 수 있으며, 일반적으로 서비스 대상이 주로 위치한 지역의 리전을 이용하면 짧은 응답 시간을 기대할 수 있습니다.

## NHN Cloud 리전 위치
NHN Cloud는 글로벌한 서비스 제공을 위해 더 많은 지역으로 리전을 확대하고 있습니다.
![region_guide%2001.png](https://static.toastoven.net/toast/region_guide/Region_guide_2021.png)

## NHN Cloud 리전 서비스
**리전 서비스**
리전 서비스는 서비스를 제공하는 리전의 인프라 환경과 국가/지역/법률/상품에서 서비스하는 내용의 제한에 의해 특정 지역에만 제공되는 서비스입니다.
물리적인 서비스의 제공 위치가 달라야 하거나 데이터의 이중화 구성을 위해서도 이용합니다.
리전 서비스는 특정 리전에서만 이용할 수 있고 리전별로 과금 정책은 다를 수 있습니다.

**글로벌 서비스**
글로벌 서비스는 모든 리전에서 사용할 수 있는 서비스입니다.
모든 사용자에게 동일한 기능과 정책, 안정성, 사용성을 제공하며 모든 리전을 선택하여 사용할 수 있습니다.

**글로벌/리전별 제공 서비스**

| 분류 | 서비스명 | 글로벌/리전 서비스 | 한국(판교) 리전 | 한국(평촌) 리전 | 일본(도쿄) 리전 | 미국(캘리포니아) 리전 |
| --- | ---- | :--------: | :-------: | :-------: | :-------: | :----------: |
| Compute | Instance | 리전 | O | O | O | O |
|  | Ephemeral Storage Instance | 리전 | O | | O | | 
|  | GPU Instance | 리전 | O |  |  |  |
|  | Bare Metal Instance | 리전 | O | | | |
|  | Instance Template | 리전 | O | O | O | O |
|  | Image | 리전 | O | O | O | O |
|  | Image Builder  | 리전 | O | O |  |  |
|  | Auto Scale | 리전 | O | O | O | O |
|  | System Monitoring | 리전 | O | O | O | O |
|  | Virtual Desktop | 리전 | O | O |  |  |
| Container | NHN Kubernetes Service(NKS) | 리전 | O | O |  |  |
|  | NHN Container Registry (NCR) | 리전 | O | O |  |  |
|  | NHN Container Service(NCS)  | 리전 | O |  |  |  |
| Network | VPC | 리전 | O | O | O | O |
|  | NAT Instance | 리전 | O | O |  |  |
|  | Floating IP | 리전 | O | O | O | O |
|  | Security Groups | 리전 | O | O | O | O |
|  | Network ACL | 리전 |  | O |  |  |
|  | Network Interface | 리전 | O | O | O | O |
|  | 일반 Load Balancer | 리전 | O | O | O | O |
|  | 전용 Load Balancer | 리전 | O | O | O | O |
|  | 물리 Load Balancer | 리전 | O | O |  |  |
|  | Transit Hub | 리전 | O | O |  |  |
|  | Internet Gateway | 리전 | O | O | O | O |
|  | Peering Gateway | 리전 | O | O | O | O |
|  | Colocation Gateway | 리전 | O | O |  |  |
|  | NAT Gateway | 리전 | O | O |  |  |
|  | VPN Gateway(Site-to-Site VPN) | 리전 |  | O |  |  |
|  | Service Gateway | 리전 | O | O |  |  |
|  | Traffic Mirroring | 리전 | O | O | | |
|  | Private DNS | 리전 | O | O | | |
|  | DNS Plus | 글로벌 |  |  |  |  |
| Storage | Block Storage | 리전 | O | O | O | O |
|  | NAS (offline) | 리전 | O | O |  | O |
|  | NAS | 리전 | O | O |  |  |
|  | Object Storage | 리전 | O | O | O | O |
|  | Backup | 리전 | O | O | O |  |
|  | Data transporter | 리전 | O | O |  |  |
| Database | RDS for MySQL | 리전 | O | O | O |  |
|  | RDS for MariaDB | 리전 | O |  |  |  |
|  | RDS for MS-SQL | 리전 | O |  |  |  |
|  | EasyCache | 리전 | O | O | O |  |
|  | MS-SQL Instance | 리전 | O | O | O | O |
|  | MySQL Instance | 리전 | O | O | O | O |
|  | PostgreSQL Instance | 리전 | O | O | O | O |
|  | CUBRID Instance  | 리전 | O | O | O | O |
|  | MariaDB Instance  | 리전 | O | O | O | O |
|  | Tibero Instance   | 리전 | O | O | O | O |
|  | Redis Instance | 리전 | O | O | O | O |
| Hybrid & Private Cloud | NHN Private Cloud | 리전 | - | - | - | - |
| Game | Gamebase | 글로벌 |  |  |  |  |
|  | GameAnvil | 글로벌 |  |  |  |  |
|  | GameTalk | 글로벌 | | | | |
|  | GameStarter | 글로벌 |  |  |  |  |
|  | Leaderboard | 글로벌 |  |  |  |  |
|  | Launching | 글로벌 |  |  |  |  |
|  | Smart Downloader | 글로벌 |  |  |  |  |
| Security |NHN AppGuard | 글로벌 |  |  |  |  |
|  | App Security Check | 리전 | O |  |  |  |
|  | Server Security Check | 리전 | O | O |  |  |
|  | Security Monitoring | 리전 | O | O |  |  |
|  | Basic Security | 리전 | O | O |  |  |
|  | CAPTCHA | 리전 | O |  |  |  |
|  | OTP | 리전 | O |  |  |  |
|  | Web Firewall | 리전 | O | O |  |  |
|  | Vaccine | 리전 | O | O |  |  |
|  | Secure Key Manager | 글로벌 |  |  |  |  |
|  | Security Compliance | 글로벌 |  |  |  |  |
|  | DDoS Guard | 리전 | O | O |  |  |
|  | SIEM | 리전 | O | O |  |  |
|  | Webshell Threat Detector | 리전 | O | O |  |  |
|  | Security Advisor | 글로벌 |  |  |  |  |
|  | Network Firewall | 리전 | O | O |  |  |
| Content Delivery | CDN | 글로벌 |  |  |  |  |
|  | Image Manager | 리전 | O |  |  |  |
| Notification | Push | 글로벌 |  |  |  |  |
|  | SMS | 리전 | O |  |  |  |
|  | RCS Bizmessage | 글로벌 |  |  |  |  |
|  | Email | 글로벌 |  |  |  |  |
|  | KakaoTalk Bizmessage | 리전 | O |  |  |  |
| AI Service | Face Recognition | 글로벌 |  |  |  |  |
|  | AI Fashion | 리전 | O | O | O | O |
|  | OCR | 글로벌 |  |  |  |  |
|  | Text to Speech | 글로벌 |  |  |  |  |
|  | Speech to Text | 글로벌 |  |  |  |  |
|  | Pose Estimation | 글로벌 |  |  |  |  |
|  | Cheating Detection | 글로벌 | |  |  |  |
| Machine Learning | Deep Learning Instance | 리전 | O |  | | |
|  | AI EasyMaker | 리전 | O |  |  |  |
| Application Service | Maps | 리전 | O |  |  |  |
|  | ROLE | 글로벌 |  |  |  |  |
|  | API Gateway | 리전 | O | O |  |  |
|  | RTCS | 글로벌 |  |  |  |  |
|  | ShortURL | 글로벌 |  |  |  |  |
|  | JEUS Instance | 리전 | O | O | O | O |
|  | WebtoB Instance | 리전 | O | O | O | O |
| Mobile Service | IAP | 글로벌 |  |  |  |  |
| Search | Cloud Search | 리전 | O |  |  |  |
|  | Autocomplete | 리전 | O |  |  |  |
|  | Corporation Search | 리전 | O |  |  |  |
|  | Word Suggestion | 글로벌 |  |  |  |  |
| Data & Analytics | Log & Crash Search | 글로벌 |  |  |  |  |
|  | DataFlow | 리전 | O |  |  |  |
|  | DataQuery | 리전 | O |  |  |  |
|  | Kafka Instance | 리전 | O | O | O | O |
| Dev Tools | Pipeline | 리전 | O | O |  |  |
|  | Deploy | 글로벌 |  |  |  |  |
| Management | Managed | 리전 | O | O |  |  |
|  | Support Plan | 리전 | O | O |  |  |
|  | Service Monitoring | 글로벌 |  |  |  |  |
|  | Certificate Manager | 글로벌 |  |  |  |  |
| Bill | eTax | 리전 | O |  |  |  |
| Dooray! | Project | 글로벌 |  |  |  |  |
|  | Messenger | 글로벌 |  |  |  |  |
|  | Mail | 글로벌 |  |  |  |  |
|  | Calendar | 글로벌 |  |  |  |  |
|  | Drive | 글로벌 |  |  |  |  |
|  | Contacts | 글로벌 |  |  |  |  |
|  | Wiki | 글로벌 |  |  |  |  |
| Dooray! \| ERP | Human resources | 리전 | O |  |  |  |
|  | Finance | 리전 | O |  |  |  |
| Dooray! \| Groupware | Communication Board | 리전 | O |  |  |  |
|  | Workflow | 리전 | O |  |  |  |
| Contact Center | Omni Contact | 리전 | O |  |  |  |
|  | Mobile Contact | 리전 | O |  |  |  |
|  | Online Contact | 글로벌 |  |  |  |  |
| IDC | NCC | 리전 | O |  |  |  |
| Governance & Audit | CloudTrail | 글로벌 |  |  |  |  |
|  | Resource Watcher | 글로벌 |  |  |  |  |