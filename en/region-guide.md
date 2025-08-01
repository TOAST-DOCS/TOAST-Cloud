## NHN Cloud > Guide to NHN Cloud Regions
A region refers to the physical location of an independent and geologically separated server. 
Generally, a region is comprised of a standalone power, the so-called available area, and datacenter equipped with a network, and the user may select a region depending on the region and service. 
Feel free to select your region anytime and anywhere to enjoy NHN Cloud services. 

## NHN Cloud Regions

NHN Cloud operates four regions to provide stable global services. 
To support for high availability, an application must be deployed to many available areas or multiple regions. 
NHN Cloud users are allowed to select regions depending on the service area and purpose, but recommended to select those regions where service targets are mainly located so as to get fast response.   

## Location of TOAT Regions 
NHN Cloud is expanding its regions to make its service globally available.  
![region_guide%2001.png](https://static.toastoven.net/toast/region_guide/Region_guide_2021.png)

## NHN Cloud Regional Service 

**Regional Service**
Regional Service refers to services that are provided only for particular regions due to restrictions in infrastructure and service content of eacy country/region/law/product. 
The service is also provided to serve at different physical locations or to enable redundant data configuration. 
Regional service is available only for a specific region, and each region may provide different pricing policy. 

**Global Service**
Global Service refers to services that are available throughout all regions. 
All users are provided with the same features, policy, stability and usability, by selecting all regions. 

**Globally/Regionally Available Services**

| Category | Service Name | Global/Regional Service | Korea(Pangyo) Region | Korea(Pyeongchon) Region | Japan(Tokyo) Region | US(California) Region |
| --- | ---- | :--------: | :-------: | :-------: | :-------: | :----------: |
| Compute | Instance | Regional | O | O | O | O |
|  | Ephemeral Storage Instance | Regional | O | | O | | 
|  | GPU Instance | Region | O |  |  |  |
|  | Instance Template | Region | O | O | O | O |
|  | Image | Region | O | O | O | O |
|  | Image Builder  | Region | O | O |  |  |
|  | Auto Scale | Region | O | O | O | O |
|  | Virtual Desktop | Regional | O | O |  |  |
|  | Cloud Functions | Regional | O |  |  |  |
| Container | NHN Kubernetes Service(NKS) | Regional | O | O |  |  |
|  | NHN Container Registry (NCR) | Regional | O | O |  |  |
|  | NHN Container Service(NCS)  | Regional | O |  |  |  |
| Network | VPC | Region | O | O | O | O |
|  | NAT Instance | Regional | O | O |  |  |
|  | Floating IP | Regional | O | O | O | O |
|  | Security Groups | Regional | O | O | O | O |
|  | Network ACL | Regional | O | O |  |  |
|  | Network Interface | Regional | O | O | O | O |
|  | Flow Log | Regional | O | O |  |  |
|  | Shared Load Balancer | Regional | O | O | O | O |
|  | Dedicated Load Balancer | Regional | O | O | O | O |
|  | NAT Instance | Regional |  | O |  |  |
|  | Transit Hub | Regional | O | O |  |  |
|  | Internet Gateway | Regional | O | O | O | O |
|  | Peering Gateway | Regional | O | O | O | O |
|  | Colocation Gateway | Regional | O | O |  |  |
|  | NAT Gateway | Regional | O | O |  |  |
|  | VPN Gateway(Site-to-Site VPN) | Regional |  | O |  |  |
|  | Service Gateway | Regional | O | O |  |  |
|  | Traffic Mirroring | Regional | O | O | | |
|  | Private DNS | Regional | O | O | | |
|  | DNS Plus | Global |  |  |  |  |
|  | Direct Connect | Regional | O | O | | |
| Storage | Block Storage | Regional | O | O | O | O |
|  | NAS (offline) | Regional |  | O |  | O |
|  | NAS | Regional | O | O |  |  |
|  | Object Storage | Regional | O | O | O | O |
|  | Backup | Regional | O | O | O |  |
|  | Storage Gateway | Regional | O | | | |
|  | Data transporter | Regional | O | O |  |  |
| Database | RDS for MySQL | Regional | O | O | O |  |
|  | RDS for PostgreSQL  | Regional | O |  |  |  |
|  | RDS for MariaDB | Regional | O |  |  |  |
|  | RDS for MS-SQL | Regional | O |  |  |  |
|  | EasyCache | Regional | O | O |  |  |
|  | MS-SQL Instance | Regional | O | O | O | O |
|  | MySQL Instance | Regional | O | O | O | O |
|  | PostgreSQL Instance  | Regional | O | O | O | O |
|  | CUBRID Instance  | Regional | O | O | O | O |
|  | MariaDB Instance  | Regional | O | O | O | O |
|  | Tibero Instance   | Regional | O | O | O | O |
|  | Redis Instance | Regional | O | O | O | O |
| Monitoring | Service Monitoring | Global |  |  |  |  |
|  | Cloud Monitoring | Global |  |  |  |  |
| Hybrid & Private Cloud | NHN Cloud Private Deck | Regional | - | - | - | - |
|  | NHN Cloud Private Station | Regional | - | - | - | - |
|  | NHN Cloud Private Region | Regional | - | - | - | - |
|  | NHN Hybrid Cloud | Regional | O |  |  |  |
| Game | Gamebase | Global |  |  |  |  |
|  | GameAnvil | Global | | | | |
|  | GameStarter | Global | | | | |
|  | Leaderboard | Global |  |  |  |  |
|  | Launching | Global |  |  |  |  |
|  | Smart Downloader | Global |  |  |  |  |
| Security | NHN AppGuard | Global |  |  |  |  |
|  | App Security Check | Regional | O |  |  |  |
|  | Server Security Check | Regional | O | O |  |  |
|  | Security Monitoring | Regional | O | O |  |  |
|  | Basic Security | Regional | O | O |  |  |
|  | CAPTCHA | Regional | O |  |  |  |
|  | Web Firewall | Regional | O | O  |  |  |
|  | Vaccine | Regional | O | O |  |  |
|  | Secure Key Manager | Global |  |  |  |  |
|  | Security Compliance | Global |  |  |  |  |
|  | DDoS Guard | Regional | O | O |  |  |
|  | SIEM | Global |  |  |  |  |
|  | Webshell Threat Detector | Regional | O | O |  |  |
|  | Security Advisor | Global |  |  |  |  |
|  | Network Firewall | Regional | O | O |  |  |
|  | NHN bastion | Regional | O | O |  |  |
|  | Cloud Access | Regional | O | O |  |  |
| Content Delivery | CDN | Global |  |  |  |  |
|  | Image Manager | Regional | O |  |  |  |
| Notification | Notification Hub | Global |  |  |  |  |
|  | Push | Global |  |  |  |  |
|  | SMS | Global |  |  |  |  |
|  | RCS Bizmessage | Global |  |  |  |  |
|  | Email | Global |  |  |  |  |
|  | KakaoTalk Bizmessage | Global |  |  |  |  |
| AI Service | Face Recognition | Global |  |  |  |  |
|  | AI Fashion | Global |  |  |  |  |
|  | OCR | Global |  |  |  |  |
|  | Text to Speech | Global |  |  |  |  |
|  | Speech to Text | Global |  |  |  |  |
| Machine Learning | Deep Learning Instance | Regional | O |  | | |
|  | AI EasyMaker | Regional | O |  |  |  |
| Application Service | Maps | Regional | O |  |  |  |
|  | ROLE | Global |  |  |  |  |
|  | API Gateway | Regional | O | O |  |  |
|  | RTCS | Global |  |  |  |  |
|  | ShortURL | Global |  |  |  |  |
|  | JEUS Instance | Regional | O | O | O | O |
|  | WebtoB Instance | Regional | O | O | O | O |
|  | Cloud Scheduler | Global |  |  |  |  |
| Mobile Service | IAP | Global |  |  |  |  |
| Search | Cloud Search | Regional | O |  |  |  |
|  | Autocomplete | Regional | O |  |  |  |
|  | Corporation Search | Regional | O |  |  |  |
| Data & Analytics | Log & Crash Search | Global |  |  |  |  |
|  | DataFlow | Regional | O |  |  |  |
|  | DataQuery | Regional | O |  |  |  |
|  | Kafka Instance | Regional | O | O | O | O |
| Dev Tools | Pipeline | Regional | O |  |  |  |
|  | Deploy | Global |  |  |  |  |
| Management | Managed | Regional | O | O |  |  |
|  | Support Plan |  Regional | O | O |  |  |
|  | Certificate Manager | Global |  |  |  |  |
| Bill | eTax | Regional | O |  |  |  |
| Collaboration | Dooray! | Global |  |  |  |  |
| Contact Center | Omni Contact | Regional | O |  |  |  |
|  | Mobile Contact | Regional | O |  |  |  |
|  | Contiple | Global |  |  |  |  |
| IDC | NCC | Regional | O |  |  |  |
| Governance & Audit | CloudTrail | Global |  |  |  |  |
|  | Resource Watcher | Global |  |  |  |  |

