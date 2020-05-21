## TOAST > TOAST Resource Usage Policy 
TOAST provides the Resource Usage Policy to provide stable services to all users and protect them from excessive spending incurred by unintentional resource creation. 

### Resource Usage Policy for Infrastructure Services  
Infrastructure services (e.g. Instance, Network, or Load Balancer) are part of the resource usage policy. 
Resource usage is calculated by project, and the resource usage quota policy is applied for each region. 

|Resources | Criteria | Capacity |
|----|----|----|
|CPU	| Per project |100vCore|
|Memory	 | Per projet |256GB|
|Block Storage| Per project |10TB|
|Floating IP | Per project |50|
|VPC | Per project |3|
|Subnet | Per vpc |10|
|Routing Table | Per vpc |10|
|Route | Per routing table |10|
|Internet Gateway | Per project	|3|
|Load Balancer | Per project |10|
|IP Access Control Group	| Per project |10|
|IP Access Control Target | Per IP access control group	|1000|

### Resource Usage Policy for DNS Plus Services 
DNS Plus services are part of the resource usage policy. 
Resource usage is calculated by project.

#### DNS
|Resources | Criteria | Capacity |
|----|----|----|
|Record Set	| Per DNS Zone |5,000|

#### GSLB
|Resources | Criteria | Capacity |
|----|----|----|
|GSLB	| Per project | 20|
|Pool	| Per project | 20 |
|Pool   | Per GSLB    | 16 |
|Endpoint | Per project | 20 |
|Endpoint| Per Pool | 5 |
|Health check	| Per project | 5 |

### Resource Usage Policy for KakaoTalk Bizmessage
KakaoTalk Bizmessage services are part of the resource usage policy. 

| Resource | Criteria | Capacity |
| -------- | -------- | -------- |
| Alimtalk Delivery Volume | KakaoTalk Channel per day | 1,000 cases |
| FriendTalk Delivery Volume | KakaoTalk Channel per day | 1,000 cases |


### Request for Capacity Adjustment
To increase capacity beyond default volume, send a request to TOAST Customer Center [1:1Inquiries]. 
It helps a lot if you fill out the items and volume in need. 

Since it takes 2 to 5 days to process a reuqest, it is recommended to send requests in advance. 
