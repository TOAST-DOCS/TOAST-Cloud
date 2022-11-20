## NHN Cloud > NHN Cloud Resource Provision Policy 
NHN Cloud provides the Resource Provision Policy to provide stable services to all users and protect them from excessive spending incurred by unintentional resource creation. 

### Resource Provision Policy for Organization/Project 
Resource usage for organization is calculated based on members who registered payment method. For project, it is calculated based on organizations.  

|Resource | Criteria | Capacity | 
|----|----|----|
|Organization    | Per member with registered payment method |3|
|Project     | Per organization |5|

### Resource Provision Policy for Infrastructure Service  
Resource usage is calculated by the project, and the Resource Provision Policy is applied for each region. 

|Resource | Criteria | Capacity |
|----|----|----|
|CPU    | Per project |100vCore|
|Memory     | Per project |256GB|
| Key Pair | Per project | 100 |
|Block Storage| Per project |10TB|
|Max Volume Size| Per volume |2048GB|
|Floating IP | Per project |50|
|VPC | Per project |3|
|Subnet | Per VPC |10|
|Routing Table | Per VPC |10|
|Route | Per routing table |10|
|Static Route | Per subnet | 20 |
|Region Peering | Per project |10 | 
|Project Peering |Per project  |10 | 
|Internet Gateway | Per project |3|
|NAT Gateway | Per project | 3 | 
|VPN Gateway(Site-to-Site VPN) | Per VPC | 1 | 
|VPN Gateway(Site-to-Site VPN) Connection | Per subnet | 1 |  
|Service Gateway | Per VPC | 10 | 
| Network Interface | Per project | 500 | 
| Network ACL | Per project | 10 | 
| Network ACL Policy | Per project | 100 | 
| Network ACL Binding | Per project | 100 | 
|Load Balancer | Per project |10|
|IP Access Control Group    | Per project |10|
|IP Access Control Target | Per IP access control group    |1000|

### Resource Provision Policy for NHN Kubernetes Service (NKS)  
Resource usage is calculated for each project, and the policy is applied by the region. 

|Resources | Criteria | Capacity | 
|----|----|----|
|Cluster	| Per project |3|
|Worker Node Group	 | Per cluster |3 (including default worker node group)|
|Worker Node Count	 | Per worker node group  |10|

### Resource Provision Policy for DNS Plus Service 
Resource usage is calculated for each project.

#### DNS
|Resource | Criteria | Capacity |
|----|----|----|
|Record Set    | Per DNS Zone |5,000|

#### GSLB
|Resource | Criteria | Capacity |
|----|----|----|
|GSLB    | Per project | 20|
|Pool    | Per project | 20 |
|Pool   | Per GSLB    | 16 |
|Endpoint | Per project | 20 |
|Endpoint| Per pool | 5 |
|Health Check    | Per project | 5 |

### Resource Provision Policy for KakaoTalk Bizmessage Service
| Resource | Criteria | Capacity |
| -------- | -------- | -------- |
| Alimtalk Delivery Volume | KakaoTalk Channel per day | 1,000 cases |
| FriendTalk Delivery Volume | KakaoTalk Channel per day | 1,000 cases |

### Resource Provision Policy for Document Recognizer
| Resource | Criteria | Capacity |
| -------- | -------- | -------- |
| Requests for Analyzing ID Card | Per Document Recognizer service | 100,000 cases |

### Resource Provision Policy for API Gateway Service
Resource usage is calculated for each project, and the policy is applied by the region.

| Resource | Criteria | Capacity |
| --- | :---: | :---: |
| API Gateway Service | Per project | 10 |
| Stage | Per API Gateway service | 10 |
| Resource Method | Per API Gateway service | 100 |

### Resource Provision Policy for Log & Crash Search Service
Resource usage is calculated for each project.

| Resource | Criteria | Capacity |
| --- | :---: | :---: |
| Number of logs (normal log, crash log) | 1 day | 20,000,000 cases |
| Size of log (normal log, crash log) | 1 case | 8MB |

### Request for Capacity Adjustment
To increase capacity beyond default volume, send a request to NHN Cloud Customer Center [1:1 Inquiry](https://www.toast.com/kr/support/inquiry). 
It helps a lot if you fill out the items and volume in need. 

Since it takes 2 to 5 days to process a request, it is recommended to send requests in advance.
