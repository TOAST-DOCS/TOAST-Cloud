## NHN Cloud > 리전 가이드
리전은 독립적이고 지리적으로 격리된 서버의 물리적 위치를 의미합니다.
일반적으로 리전은 가용성 영역이라고 부르는 독립된 전원 및 네트워크를 갖춘 데이터 센터로 구성되며, 사용하려는 지역과 서비스에 따라 리전을 선택할 수 있습니다.
인터넷으로 언제 어디서나 자유롭게 리전을 선택하여 NHN Cloud(공공기관용) 서비스를 이용하세요.

## NHN Cloud 리전
NHN Cloud(공공기관용)는 안정적인 글로벌 서비스 제공을 위해 2개의 리전을 운영하고 있습니다.
고가용성을 지원하기 위해서는 여러 가용성 영역 혹은 복수의 리전에 애플리케이션을 배포해야 합니다.
NHN Cloud(공공기관용) 유저는 서비스 지역과 목적에 따라 사용할 리전을 선택할 수 있으며, 일반적으로 서비스 대상이 주로 위치한 지역의 리전을 이용하면 짧은 응답 시간을 기대할 수 있습니다.

## NHN Cloud 리전 서비스
**리전 서비스**
리전 서비스는 서비스를 제공하는 리전의 인프라 환경과 국가/지역/법률/상품에서 서비스하는 내용의 제한에 의해 특정 지역에만 제공되는 서비스입니다.
물리적인 서비스의 제공 위치가 달라야 하거나 데이터의 이중화 구성을 위해서도 이용합니다.
리전 서비스는 특정 리전에서만 이용할 수 있고 리전별로 과금 정책은 다를 수 있습니다.

**글로벌 서비스**
글로벌 서비스는 모든 리전에서 사용할 수 있는 서비스입니다.
모든 사용자에게 동일한 기능과 정책, 안정성, 사용성을 제공하며 모든 리전을 선택하여 사용할 수 있습니다.

**글로벌/리전별 제공 서비스**

| 분류 | 서비스명 | 글로벌/리전 서비스 | 한국(판교) 리전 | 한국(평촌) 리전 | 
| --- | ---- | :--------: | :-------: | :-------: | 
| Compute | Instance | 리전 | O | O | 
|  | GPU Instance | 리전 | O |  |
|  | Instance Template | 리전 | O | O | 
|  | Image | 리전 | O | O | 
|  | Image Builder  | 리전 | O | O |
|  | Auto Scale | 리전 | O | O | 
|  | System Monitoring | 리전 | O | O |
| Container | NHN Kubernetes Service(NKS) | 리전 | O | O |
|  | NHN Container Registry (NCR) | 리전 | O | O |
| Network | VPC | 리전 | O | O |
|  | Floating IP | 리전 | O | O | 
|  | Network ACL | 리전 |  | O |
|  | Security Groups | 리전 | O | O | 
|  | Network Interface | 리전 | O | O | 
|  | 일반 Load Balancer | 리전 | O | O | 
|  | 전용 Load Balancer | 리전 | O | O | 
|  | IPSec VPN | 리전 | O |  |
|  | DNS Plus | 글로벌 |  |  |
|  | Internet Gateway | 리전 | O | O | 
|  | Peering Gateway | 리전 | O | O | 
|  | NAT Instance | 리전 |  | O |
|  | Colocation Gateway | 리전 |  | O |
|  | NAT Gateway | 리전 |  | O |
|  | Service Gateway | 리전 |  | O |
|  | Direct Connect | 리전 | O | O | 
|  | Traffic Mirroring | 리전 |  | O |
|  | Transit Hub  | 리전 |  | O |
| Storage | Block Storage | 리전 | O | O | 
|  | NAS | 리전 |  | O | 
|  | NAS(offline) | 리전 | O |  | 
|  | Object Storage | 리전 | O | O |
|  | Backup | 리전 | O | O | 
| Database | RDS for MySQL | 리전 | O | O |
|  | MS-SQL Instance | 리전 | O | O | 
|  | MySQL Instance | 리전 | O | O | 
|  | PostgreSQL Instance | 리전 | O | O | 
|  | CUBRID Instance  | 리전 | O | O | 
|  | MariaDB Instance  | 리전 | O | O | 
|  | Tibero Instance   | 리전 | O | O | 
|  | Redis Instance | 리전 | O | O | 
| Security | Security Monitoring | 리전 | O |  |
|  | Basic Security | 리전 | O | O | 
|  | Web Firewall | 리전 | O |  |
|  | Vaccine | 리전 | O |  |
|  | Secure Key Manager | 글로벌 |  |  | 
|  | Security Compliance | 글로벌 |  |  | 
|  | CSAP SaaS Guidance | 글로벌 |  |  |
|  | SSL VPN | 리전 | O | O |
|  | DDoS Guard | 리전 | O |  |
|  | SIEM | 리전 | O |  | 
| Content Delivery | CDN | 글로벌 |  |  |
| Application Service | API Gateway | 리전 | O | O | 
| Data & Analytics | Log & Crash Search | 글로벌 |  |  |
|  | Kafka Instance | 리전 | O | O | 
| Dev Tools | Deploy | 글로벌 |  |  | 
| Management | Certificate Manager | 글로벌 |  |  |
| Dooray! | Project | 글로벌 |  |  |
|  | Messenger | 글로벌 |  |  | 
|  | Mail | 글로벌 |  |  | 
|  | Calendar | 글로벌 |  |  |
|  | Drive | 글로벌 |  |  |
|  | Contacts | 글로벌 |  |  |
|  | Wiki | 글로벌 |  |  |
| Governance & Audit | CloudTrail | 글로벌 |  |  | 
|  | Resource Watcher | 글로벌 |  |  |