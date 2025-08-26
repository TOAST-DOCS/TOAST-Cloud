## NHN Cloud > NHN Cloud Resource Provision Policy 
NHN Cloud provides the Resource Provision Policy to provide stable services to all users and protect them from excessive spending incurred by unintentional resource creation. 

### Resource Provision Policy for Organization/Project 
Resource usage for organization is calculated based on members who registered payment method. For project, it is calculated based on organizations.  

|Resource | Membership Type | Criteria | Capacity | 
|----|----|----|----|
|Organization    | Individual | Per member with registered payment method |3|
|   | Business Owner| Per member with registered payment method |5|
|Project     | Individual | Per organization |5|
|   | Business Owner | Per organization |10|

### Resource Provision Policy for Instance Service  
Resource usage is calculated by the project, and the Resource Provision Policy is applied for each region. 

|Resource | Criteria | Default Amount | Adjustable or Not | Maximum Amount |
|----|----|----|----|----|
|CPU    | Per project |100vCore| O | |
|Memory     | Per project |262,144MB| O | |


### Resource Provision Policy for Block Storage Service  
Resource usage is calculated by the project, and the Resource Provision Policy is applied for each region. 

|Resource | Criteria | Default Amount | Adjustable or Not | Maximum Amount |
|----|----|----|----|----|
|Block Storage| Per project |10240GB| O | |
|Block Storage HDD Type Max Size| Per block storage |2048GB| O | |
|Block Storage SSD Type Max Size| Per block storage |2048GB| O | |
|Block Storage Encrypted HDD Type Max Size| Per block storage |2048GB| O | |
|Block Storage Encrypted SSD Type Max Size| Per block storage |2048GB| O | |
|Snapshot| Per block storage |3| X | |

### Resource Provision Policy for Floating IP Service  
Resource usage is calculated by the project, and the Resource Provision Policy is applied for each region. 

|Resource | Criteria | Default Amount | Adjustable or Not | Maximum Amount |
|----|----|----|----|----|
|Floating IP | Per project |50| O | |


### Resource Provision Policy for VPC Service  
Resource usage is calculated by the project, and the Resource Provision Policy is applied for each region. 

|Resource | Criteria | Default Amount | Adjustable or Not | Maximum Amount |
|----|----|----|----|----|
|VPC | Per project |3| O | |


### Resource Provision Policy for Subnet Service  
Resource usage is calculated by the project, and the Resource Provision Policy is applied for each region. 

|Resource | Criteria | Default Amount | Adjustable or Not | Maximum Amount |
|----|----|----|----|----|
|Subnet | Per VPC |10| O | |
|Static Route | Per subnet | 20 | X | |


### Resource Provision Policy for Routing Service  
Resource usage is calculated by the project, and the Resource Provision Policy is applied for each region. 

|Resource | Criteria | Default Amount | Adjustable or Not | Maximum Amount |
|----|----|----|----|----|
|Routing Table | Per VPC |10| O | |
|Route | Per routing table |10| O | 100 |


### Resource Provision Policy for Peering Gateway Service  
Resource usage is calculated by the project, and the Resource Provision Policy is applied for each region. 

|Resource | Criteria | Default Amount | Adjustable or Not | Maximum Amount |
|----|----|----|----|----|
|Region Peering | Per project  |10 | O | | 
|Project Peering |Per project  |10 | O | |
|Peering Allowed Target|Per project  |10 | O | |


### Resource Provision Policy for Internet Gateway Service  
Resource usage is calculated by the project, and the Resource Provision Policy is applied for each region. 

|Resource | Criteria | Default Amount | Adjustable or Not | Maximum Amount |
|----|----|----|----|----|
|Internet Gateway | Per project |3| O | |


### Resource Provision Policy for NAT Gateway Service  
Resource usage is calculated by the project, and the Resource Provision Policy is applied for each region. 

|Resource | Criteria | Default Amount | Adjustable or Not | Maximum Amount |
|----|----|----|----|----|
|NAT Gateway | Per project | 3 | O | |


### Resource Provision Policy for VPN Gateway(Site-to-Site VPN) Service  
Resource usage is calculated by the project, and the Resource Provision Policy is applied for each region. 

|Resource | Criteria | Default Amount | Adjustable or Not | Maximum Amount |
|----|----|----|----|----|
|VPN Gateway(Site-to-Site VPN) | Per project | 3 | X | | 
|VPN(Site-to-Site VPN) Connection | Per project | 30 | X | |


### Resource Provision Policy for Service Gateway Service  
Resource usage is calculated by the project, and the Resource Provision Policy is applied for each region. 

|Resource | Criteria | Default Amount | Adjustable or Not | Maximum Amount |
|----|----|----|----|----|
|Service Gateway | Per project | 10 | O | | 


### Resource Provision Policy for Traffic Mirroring Service  
Resource usage is calculated by the project, and the Resource Provision Policy is applied for each region. 

|Resource | Criteria | Default Amount | Adjustable or Not | Maximum Amount |
|----|----|----|----|----|
|Traffic Mirroring Session | Per project | 10 | O | |
|Traffic Mirroring Filter Group | Per project | 10 | O | |


### Resource Provision Policy for Network Interface Service  
Resource usage is calculated by the project, and the Resource Provision Policy is applied for each region. 
Network Interface console also displays resources other than user projects, and the resources are not included in the amount.

|Resource | Criteria | Default Amount | Adjustable or Not | Maximum Amount |
|----|----|----|----|----|
| Network Interface | Per project | 500 | O | | 


### Resource Provision Policy for Network ACL Service  
Resource usage is calculated by the project, and the Resource Provision Policy is applied for each region. 

|Resource | Criteria | Default Amount | Adjustable or Not | Maximum Amount |
|----|----|----|----|----|
| Network ACL | Per project | 10 | O | | 
| Network ACL Policy | Per project | 100 | O | | 
| Network ACL Binding | Per project | 100 | O | | 


### Resource Provision Policy for Load Balancer Service  
Resource usage is calculated by the project, and the Resource Provision Policy is applied for each region. 

|Resource | Criteria | Default Amount | Adjustable or Not | Maximum Amount |
|----|----|----|----|----|
|Load Balancer | Per project |10| O | |
|IP Access Control Group    | Per project |10| O | |
|IP Access Control Target | Per IP access control group |1000| O | |
|L7 Policy | Per Listener |10| O | |
|L7 Rule | Per L7 Policy |10| O | |


### Resource Provision Policy for NAS Service  
Resource usage is calculated by the project, and the Resource Provision Policy is applied for each region. 

|Resource | Criteria | Default Amount | Adjustable or Not | Maximum Amount |
|----|----|----|----|----|
| NAS Storage | Per project| 100 | O | |
| NAS Storage Size | Per project | 30TB | O | |
| NAS Storage Max Size | Per NAS storage | 10TB | O | |
| NAS Storage Subnet | Per project | 3 | O | |

### Resource Provision Policy for Storage Gateway Service  
Resource usage is calculated by the project, and the Resource Provision Policy is applied for each region. 

|Resource | Criteria | Default Amount | Adjustable or Not | Maximum Amount |
|----|----|----|----|----|
| Storage Gateway | Per project| 3 | X | |
| Share | Per gateway | 10 | X | |

### Resource Provision Policy for Transit Hub Service  
Resource usage is calculated by the project, and the Resource Provision Policy is applied for each region. 

|Resource | Criteria | Default Amount | Adjustable or Not | Maximum Amount |
|----|----|----|----|----|
| Transit Hub | Per project | 10 | O | |
| Transit Hub Attachment | Per project | 20 | O | |
| Transit Hub Allow Project | Per project | 10 | O | |
| Transit Hub Routing Table | Per project | 20 | O | |
| Transit Hub Routing Rule | Per project | 100 | O | |
| Transit Hub Multicast Domain | Per project | 20 | O | |
| Transit Hub Multicast Group | Per project | 100 | O | |


### Resource Provision Policy for Private DNS Service  
Resource usage is calculated by the project, and the Resource Provision Policy is applied for each region. 

|Resource | Criteria | Default Amount | Adjustable or Not | Maximum Amount |
|----|----|----|----|----|
| Private DNS Zone | Per project | 100 | O | |
| Private DNS Record Set | Per project | 500 | O | |

### Resource Provision Policy for NHN Kubernetes Service (NKS)  
Resource usage is calculated for each project, and the policy is applied by the region. 

|Resources | Criteria | Default Amount | Adjustable or Not | Maximum Amount |
|----|----|----|----|----|
|Cluster	| Per project |3| O | |
|Worker Node Group	 | Per cluster |3 (including default worker node group)| O | |
|Worker Node Count	 | Per worker node group  |10| O | |

### Resource Provision Policy for NHN Container Registry(NCR)
Resource usage is calculated for each project, and the policy is applied by the region. 

|Resources | Criteria | Default Amount | Adjustable or Not | Maximum Amount |
|----|----|----|----|----|
| Number of Registries | Per project | 30 | O | |
| Number of Images | Per registry | 10000 | O | |
| Number of Artifacts | Per image | 10000 | O | |
| Number of Tags | Per artifact | 1000 | O | |
| Number of Manual Scans |  1 day per image | 1 | O | |


### Resource Provision Policy for NHN Container Service(NCS) 
Resource usage is calculated for each project, and the policy is applied by the region. 

|Resources | Criteria | Default Amount | Adjustable or Not | Maximum Amount |
|----|----|----|----|----|
| Workload	| Per project |No limit| O | |
| Task | Per workload | 100 | O | |
| Template | Per project | 1,000 | O | |
| Container | Per template | 10 | O | |
| CPU | Per template | 16vCore | O | | 
| CPU | Per project | 24vCore | O | | 
| Memory | Per template |32,768 MiB | O | 230,400 MiB |
| Memory | Per project |	49,152 MiB | O | |
| GPU | Per template |  7Core | O | |
| GPU | Per project | 7Core | O | |

### Resource Provision Policy for DNS Plus Service 
Resource usage is calculated for each project.

#### DNS
|Resource | Criteria | Default Amount | Adjustable or Not | Maximum Amount |
|----|----|----|----|----|
|Record Set    | Per DNS Zone |5,000| O | |

#### GSLB
|Resource | Criteria | Default Amount | Adjustable or Not | Maximum Amount |
|----|----|----|----|----|
|GSLB    | Per project | 20| O | |
|Pool    | Per project | 20 | O | |
|Pool   | Per GSLB    | 16 | O | |
|Endpoint | Per project | 20 | O | |
|Endpoint| Per pool | 5 | O | |
|Health Check    | Per project | 5 | O | |



### Resource Provision Policy for RDS for MySQL 
|Resource | Criteria | Default Amount | Adjustable or Not | Maximum Amount |
|----|----|----|----|----|
| DB Instance CPU | Per project  | 100vCore | O | |
| DB Instance Memory | Per project  | 262,144MB | O | |
| DB Instance Data Storage | Per project  | 10,240GB | O | | 
| Replica | Per DB Instance Group | 5 | O | |

### Resource Provision Policy for RDS for PostgreSQL 
|Resource | Criteria | Default Amount | Adjustable or Not | Maximum Amount |
|----|----|----|----|----|
| DB Instance CPU | Per project  | 100vCore | O | |
| DB Instance Memory | Per project  | 262,144MB | O | |
| DB Instance Data Storage | Per project  | 10,240GB | O | | 
| Replica | Per DB Instance Group | 5 | O | |

### Resource Provision Policy for RDS for MariaDB
|Resource | Criteria | Default Amount | Adjustable or Not | Maximum Amount |
|----|----|----|----|----|
| DB Instance CPU | Per project  | 100vCore | O | |
| DB Instance Memory | Per project  | 262,144MB | O | |
| DB Instance Data Storage | Per project  | 10,240GB | O | | 
| Replica | Per DB Instance Group | 5 | O | |


### Resource Provision Policy for RDS for MS-SQL 
|Resource | Criteria | Default Amount | Adjustable or Not | Maximum Amount |
|----|----|----|----|----|
| DB Instance CPU | Per project  | 200vCore | O | |
| DB Instance Memory | Per project  | 524,288MB | O | |
| DB Instance Data Storage | Per DB Instance | 2,048GB | O | |
| DB Instance Data Storage | Per project  | 10,240GB | O | | 


### Resource Provision Policy for Network Firewall
| Resource | Criteria | Default Amount | Adjustable or Not | Maximum Amount |
|----|----|----|----|----|
| Number of ACL Policies | Per project | 1,000 | X | | 
| Number of ACL Policy Rules | Per project | 5,000 | X | | 
| Maximum Number of ACL Sessions | Per project | 1,000,000 | X | | 
| Number of NATs | Per project | 200 | X | | 
| Maximum Number of NAT Sessions | Per project | 1,000,000 | X | | 
| Number of Traffic Logs | Per project | 8,000,000 | X | | 
| Number of Gateways | Per project | 10 | X | | 
| Number of Tunnels | Per project | 20 | X | | 

### Resource Provision Policy for Cloud Access
| Resource | Criteria | Default Amount | Adjustable or Not | Maximum Amount |
|----|----|----|----|----|
| Number of User Accounts | Per Project | 20 | X | |
| Number of Concurrent Users | Per Project | 20 | X | |
| Number of ACL Policies | Per Project | 100 | X | |
| Number of ACL Policy Rules | Per Project | 500 | X | |
| Maximum Number of ACL Sessions | Per Project | 10,000 | X | |
| Maximum Number of Tunnel Sessions | Per Project | 10,000 | X | |
| Number of User Policies | Per Project | 50 | X | |
| Number of Accessible Bands | Per User Policy | 3 | X | |
| Number of Internet Block Exception IPs | Per User Policy | 100 | X | |
| Number of Required Software Registrations | Per User Policy | 50 | X | |
| Number of Blocked Software Registrations | Per User Policy | 50 | X | |
| Number of Vaccine Test Registrations | Per User Policy | 50 | X | |
| Number of Traffic Logs | Per Project | 50,000 | X | |
| Number of User Logs | Per Project | 200,000 | X | |

### Resource Provision Policy for Notification Hub

The number of messages sent by the SMS service and the Notification Hub service are added up.
The number of AlimTalk/ FriendTalk messages sent by KakaoTalk Bizmessage service and Notification Hub service are added up.

| Resource | Criteria | Default Amount | Adjustable or Not | Maximum Amount |
|----|----|----|----|----|
| SMS Sent Count | Per organization | 5,000 cases | O | |
| Alimtalk Sent Count | KakaoTalk Channel per day | 1,000 cases | O | |
| FriendTalk Sent Count | KakaoTalk Channel per day | 1,000 cases | O | |

### Resource Provision Policy for SMS
| Resource | Criteria | Default Amount | Adjustable or Not | Maximum Amount |
|----|----|----|----|----|
| Sent Count | Per organization | 5,000 cases | O | |

### Resource Provision Policy for KakaoTalk Bizmessage Service
| Resource | Criteria | Default Amount | Adjustable or Not | Maximum Amount |
|----|----|----|----|----|
| Alimtalk Sent Count | KakaoTalk Channel per day | 1,000 cases | O | |
| FriendTalk Sent Count | KakaoTalk Channel per day | 1,000 cases | O | |

### Resource Provision Policy for Face Recognition Service
| Resource | Criteria | Default Amount | Adjustable or Not | Maximum Amount |
|----|----|----|----|----|
| Number of Groups | Per Face Recognition Service | 5 cases | O | |
| Number of Registered Faces in Group	 | 	Per Face Recognition Service Group | 100,000 cases | O | |

### Resource Provision Policy for AI Fashion
Resource usage is calculated for each project.

| Resource | Criteria | Default Amount | Adjustable or Not | Maximum Amount |
|----|----|----|----|----|
| AI Fashion service count | Per project | 5 | O | | 
| Max Document Count | Per AI Fashion service | 100,000 cases | O | |
| Indexing Request Document Count | Per indexing request | 10,000 cases | O | |
| Indexing Input File Size | Per indexing request | 20MB | O | |

### Resource Provision Policy for OCR
Resource usage is calculated for each project.

| Resource | Criteria | Default Amount | Adjustable or Not | Maximum Amount |
|----|----|----|----|----|
| Requests for Analyzing ID Card | Per OCR service | 100,000 cases | X | |

### Resource Provision Policy for API Gateway Service
Resource usage is calculated for each project, and the policy is applied by the region.

| Resource | Criteria | Default Amount | Adjustable or Not | Maximum Amount |
|----|----|----|----|----|
| API Gateway Service | Per project | 10 | O | |
| Stage | Per API Gateway service | 10 | O | |
| Resource Method | Per API Gateway service | 100 | O | 300 |

### Resource Provision Policy for Log & Crash Search Service
Resource usage is calculated for each project.

| Resource | Criteria | Default Amount | Adjustable or Not | Maximum Amount |
|----|----|----|----|----|
| Number of logs (normal log, crash log) | 1 day | 20,000,000 cases | O | |
| Size of log (normal log, crash log) | 1 case | 8MB | X | |

### Resource Provision Policy for DataFlow Service
Resource usage is calculated for each project, and the policy is applied by the region.

| Resource | Criteria | Default Amount | Adjustable or Not | Maximum Amount |
|----|----|----|----|----|
| CPU | Per project | 10vCore | O | |
| Memory | Per project | 20GB | O | |


### Request for Capacity Adjustment
To increase capacity beyond default volume, send a request to NHN Cloud Customer Center [1:1 Inquiry](https://nhncloud.com/kr/support/inquiry). 
It helps a lot if you fill out the items and volume in need. 

Since it takes 2 to 5 days to process a request, it is recommended to send requests in advance.
