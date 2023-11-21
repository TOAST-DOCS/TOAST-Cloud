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

### Resource Provision Policy for Infrastructure Service  
Resource usage is calculated by the project, and the Resource Provision Policy is applied for each region. 

|Resource | Criteria | Default Amount | Adjustable or Not | Maximum Amount |
|----|----|----|----|----|
|CPU    | Per project |100vCore| O | |
|Memory     | Per project |256GB| O | |
| Key Pair | Per project | 100 | O | |
|Block Storage| Per project |10TB| O | |
|Max Volume Size| Per volume |2048GB| O | |
|Floating IP | Per project |50| O | |
|VPC | Per project |3| O | |
|Subnet | Per VPC |10| O | |
|Routing Table | Per VPC |10| O | |
|Route | Per routing table |10| O | 100 |
|Static Route | Per subnet | 20 | X | |
|Region Peering | Per project  |10 | O | | 
|Project Peering |Per project  |10 | O | |
|Internet Gateway | Per project |3| O | |
|NAT Gateway | Per project | 3 | O | |
|VPN Gateway(Site-to-Site VPN) | Per VPC | 1 | X | | 
|VPN Gateway(Site-to-Site VPN) Connection | Per subnet | 1 | X | |
|Service Gateway | Per project | 10 | O | | 
|Traffic Mirroring Session | Per project | 10 | O | |
|Traffic Mirroring Filter Group | Per project | 10 | O | |
| Network Interface | Per project | 500 | O | | 
| Network ACL | Per project | 10 | O | | 
| Network ACL Policy | Per project | 100 | O | | 
| Network ACL Binding | Per project | 100 | O | | 
|Load Balancer | Per project |10| O | |
|IP Access Control Group    | Per project |10| O | |
|IP Access Control Target | Per IP access control group |1000| O | |
| NAS volume | Per project| 100 | O | |
| NAS Volume Size | Per project | 30TB | O | |
| NAS Max Volume Size | Per volum | 10TB | O | |
| NAS volume Subnet | Per project | 3 | O | |
| Transit Hub | Per project | 10 | O | |
| Transit Hub Attachment | Per project | 20 | O | |
| Transit Hub Allow Project | Per project | 10 | O | |
| Transit Hub Routing Table | Per project | 20 | O | |
| Transit Hub Routing Association | | No limit | | |
| Transit Hub Routing Propagation | | No limit | | |
| Transit Hub Routing Rule | Per project | 100 | O | |
| Transit Hub Multicast Domain | Per project | 20 | O | |
| Transit Hub Multicast Association | | No limit | | |
| Transit Hub Multicast Group | Per project | 100 | O | |
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

### Resource Provision Policy for KakaoTalk Bizmessage Service
| Resource | Criteria | Default Amount | Adjustable or Not | Maximum Amount |
|----|----|----|----|----|
| Alimtalk Delivery Volume | KakaoTalk Channel per day | 1,000 cases | O | |
| FriendTalk Delivery Volume | KakaoTalk Channel per day | 1,000 cases | O | |

### Resource Provision Policy for Face Recognition Service
| Resource | Criteria | Default Amount | Adjustable or Not | Maximum Amount |
|----|----|----|----|----|
| Number of Groups | Per Face Recognition Service | 5 cases | O | |
| Number of Registered Faces in Group	 | 	Per Face Recognition Service Group | 100,000 cases | O | |

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
Resource usage is calculated for each project.

| Resource | Criteria | Default Amount | Adjustable or Not | Maximum Amount |
|----|----|----|----|----|
| Number of running flows | Per project | 10 | O | |


### Request for Capacity Adjustment
To increase capacity beyond default volume, send a request to NHN Cloud Customer Center [1:1 Inquiry](https://nhncloud.com/kr/support/inquiry). 
It helps a lot if you fill out the items and volume in need. 

Since it takes 2 to 5 days to process a request, it is recommended to send requests in advance.
