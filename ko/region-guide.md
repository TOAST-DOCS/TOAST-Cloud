## TOAST > TOAST 리전 가이드
리전은 독립적이고 지리적으로 격리된 서버의 물리적 위치를 의미합니다.
일반적으로 리전은 가용성 영역이라고 불리는 독립된 전원 및 네트워크를 갖춘 데이터 센터로 구성되며, 사용하려는 지역과 서비스에 따라 리전을 선택할 수 있습니다. <br>
인터넷으로 언제 어디서나 자유롭게 리전을 선택하여 TOAST 서비스를 이용하세요.

## TOAST 리전

TOAST는 안정적인 글로벌 서비스 제공을 위해 4개의 리전을 운영하고 있습니다.<br>
고가용성을 지원하기 위해서는 여러 가용성 영역 혹은 복수의 리전에 애플리케이션을 배포해야 합니다.<br>
TOAST 유저는 서비스 지역과 목적에 따라 사용할 리전을 선택할 수 있으며, 일반적으로 서비스 대상이 주로 위치한 지역의 리전을 이용하면 짧은 응답시간을 기대할 수 있습니다.

## TOAST 리전 위치
TOAST는 글로벌한 서비스 제공을 위해 더 많은 지역으로 리전을 확대하고 있습니다.<br>
![region_guide%2001.png](https://static.toastoven.net/toast/region_guide/region_guide%2001.png)

## TOAST 리전 서비스

**리전 서비스**<br>
리전 서비스는 서비스를 제공하는 리전의 인프라 환경과 국가/ 지역/ 법률 / 상품에서 서비스하는 내용의 제한에 의해 특정 지역에만 제공되는 서비스입니다.<br>
물리적인 서비스의 제공 위치가 달라야 하거나 데이터의 이중화 구성을 위해서도 이용합니다.<br>
리전 서비스는 특정 리전에서만 이용할 수 있고 리전 별로 과금 정책은 상이할 수 있습니다.<br>

**글로벌 서비스**<br>
글로벌 서비스는 모든 리전에서 사용할 수 있는 서비스입니다.<br>
모든 사용자에게 동일한 기능과 정책, 안정성, 사용성을 제공하며 모든 리전을 선택하여 사용할 수 있습니다.<br>

**글로벌/리전별 제공 서비스**<br>

| 분류 | 서비스명 | 글로벌/리전 서비스 | 한국(판교) 리전 | 한국(평촌) 리전 | 일본(도쿄) 리전 | 미국(캘리포니아) 리전 |
| --- | ---- | :--------: | :-------: | :-------: | :-------: | :----------: |
| Compute | Instance | 리전 | O | O | O | O |
|  | GPU Instance | 리전 | O |  |  |  |
|  | Image | 리전 | O | O | O | O |
|  | Auto Scale | 리전 | O | O | O | O |
|  | System Monitoring | 리전 | O | O | O | O |
| Network | VPC | 리전 | O | O | O | O |
|  | 일반 Load Balancer | 리전 | O | O | O | O |
|  | 전용 Load Balancer | 리전 | O | O | O | O |
|  | 물리 Load Balancer | 리전 | O | O |  |  |
|  | DNS Plus | 글로벌 |  |  |  |  |
| Storage | Block Storage | 리전 | O | O | O | O |
|  | NAS (offline) | 리전 | O | O |  | O |
|  | Object Storage | 리전 | O | O | O | O |
|  | Backup | 리전 | O |  | O |  |
| Database | RDS for MySQL | 리전 | O | O | O |  |
|  | EasyCache | 리전 | O |  | O |  |
|  | MS-SQL Instance | 리전 | O | O | O | O |
|  | MySQL Instance | 리전 | O | O | O | O |
| Game | Gamebase | 글로벌 |  |  |  |  |
|  | Leaderboard | 글로벌 |  |  |  |  |
|  | Launching | 글로벌 |  |  |  |  |
|  | Smart Downloader | 글로벌 |  |  |  |  |
| Security | AppGuard | 글로벌 |  |  |  |  |
|  | Security Check | 리전 | O |  |  |  |
|  | Security Monitoring | 리전 | O |  |  |  |
|  | Basic Security | 리전 | O |  |  |  |
|  | Mal-URL Detector | 리전 | O |  |  |  |
|  | CAPTCHA | 리전 | O |  |  |  |
|  | OTP | 리전 | O |  |  |  |
|  | DBSafer | 리전 | O |  |  |  |
|  | Web Firewall | 리전 | O |  |  |  |
|  | Vaccine | 리전 | O |  |  |  |
|  | Secure Key Manager | 글로벌 |  |  |  |  |
| Content Delivery | CDN | 글로벌 |  |  |  |  |
|  | Image | 리전 | O |  |  |  |
| Notification | Push | 글로벌 |  |  |  |  |
|  | SMS | 리전 | O |  |  |  |
|  | Email | 글로벌 |  |  |  |  |
|  | KakaoTalk Bizmessage | 리전 | O |  |  |  |
| Mobile Service | IAP | 글로벌 |  |  |  |  |
|  | Mobile Device Info | 글로벌 |  |  |  |  |
| Analytics | Log & Crash Search | 글로벌 |  |  |  |  |
| Application Service | Maps | 리전 | O |  |  |  |
|  | ROLE | 글로벌 |  |  |  |  |
|  | API Gateway | 리전 | O |  |  |  |
|  | RTCS | 글로벌 |  |  |  |  |
| Search | Cloud Search | 리전 | O |  |  |  |
|  | Autocomplete | 리전 | O |  |  |  |
|  | Corporation Search | 리전 | O |  |  |  |
|  | Address Search | 리전 | O |  |  |  |
| Dev Tools | Deploy | 글로벌 |  |  |  |  |
| Management | Managed | 리전 | O |  |  |  |
|  | Service Monitoring | 리전 | O |  |  |  |
|  | Certificate Manager | 글로벌 |  |  |  |  |
| Workplace | Dooray! | 글로벌 |  |  |  |  |
|  | Messenger | 글로벌 |  |  |  |  |
|  | Mail | 글로벌 |  |  |  |  |
|  | Calendar | 글로벌 |  |  |  |  |
|  | Drive | 글로벌 |  |  |  |  |
|  | Contacts | 글로벌 |  |  |  |  |
|  | Wiki | 글로벌 |  |  |  |  |
| Workplace \| ERP | Human resources | 리전 | O |  |  |  |
|  | Finance | 리전 | O |  |  |  |
| Workplace\| Groupware | Communication Board | 리전 | O |  |  |  |
|  | Workflow | 리전 | O |  |  |  |
| Contact Center | Omni Contact | 리전 | O |  |  |  |
|  | Mobile Contact | 리전 | O |  |  |  |
|  | Online Contact | 글로벌 |  |  |  |  |
| Bill | Bill (e-Tax) | 리전 | O |  |  |  |
| IDC | TCC | 리전 | O |  |  |  |
| Marketplace | Massive Mail Delivery Service(for Japan) | 리전 |  |  | O |  |
|  | Goorm IDE | 리전 | O |  |  |  |
|  | Goorm EDU | 리전 | O |  |  |  |
|  | Goorm DEVTH | 리전 | O |  |  |  |
