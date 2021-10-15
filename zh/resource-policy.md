## NHN Cloud > NHN Cloud源提供政策 
NHN Cloud为所有客户提供稳定的服务，为保护客户不因创建意料之外的源而产生支出等，提供源使用量政策。

### Resource Provision Policy for Organization/Project 
Resource usage for organization is calculated based on members who registered payment method. For project, it is calculated based on organizations.  

|Resource | Criteria | Capacity | 
|----|----|----|
|Organization    | Per member with registered payment method |3|
|Project     | Per organization |5|

### 基础设施服务源提供政策 
源使用量按各项目计算，各地区应用另外的源使用量限制政策。

|源 | 提供标准 | 提供量 | 
|----|----|----|
|CPU    | 每个项目 |100vCore|
|内存     | 每个项目 |256GB|
|Block Storage| 每个项目 |10TB|
|Floating IP | 每个项目 |50个|
|VPC | 每个项目 |3个|
|子网 | 每个vpc |10个|
|路由表 | 每个vpc |10个|
|路由 | 每个路由表 |10个|
|互联网网关 | 每个项目    |3个|
|Load Balancer | 每个项目 |10个|
|IP访问控制组    | 每个项目   |10个|
|IP访问控制对象 | 每个IP访问控制组    |1000个|

### Resource Provision Policy for Kubernetes Service  
Resource usage is calculated for each project, and the policy is applied by the region. 

|Resources | Criteria | Capacity | 
|----|----|----|
|Cluster	| Per project |3|
|Worker Node Group	 | Per cluster |3 (including default worker node group)|
|Worker Node Count	| Worker node groups|10|

### DNS Plus施服务源提供政策 
源使用量按各项目计算。

#### DNS
|源 | 提供标准 | 提供量 | 
|----|----|----|
|Record Set    | Per DNS Zone |5,000个|

#### GSLB
|源 | 提供标准 | 提供量 | 
|----|----|----|
|GSLB    | 每个项目 | 20个|
|Pool    | 每个项目 | 20个 |
|Pool   | 每个项目    | 16个 |
|Endpoint | 每个项目 | 20个 |
|Endpoint| 每个项目 | 5个 |
|Health check    | 每个项目 | 5个 |

### KakaoTalk Bizmessage施服务源提供政策 

| 源 | 提供标准 | 提供量 |
| --- | ---- | --- |
| 通知TALK 发送量 |  KakaoTalk Channel 1日毎 | 1,000 件 |
| 好友TALK 发送量 |  KakaoTalk Channel 1日毎 | 1,000 件 |

### Resource Provision Policy for API Gateway Service
Resource usage is calculated for each project, and the policy is applied by the region.

| Resource | Criteria | Capacity |
| --- | :---: | :---: |
| API Gateway Service | Per project | 10 |
| Stage | Per API Gateway service | 50 |
| Resource Method | Per API Gateway service | 300 |

### Resource Provision Policy for Log & Crash Search Service
Resource usage is calculated for each project.

| Resource | Criteria | Capacity |
| --- | :---: | :---: |
| Number of logs (normal log, crash log) | 1 day | 20,000,000 cases |
| Size of log (normal log, crash log) | 1 case | 8MB |

### 申请调整源提供量 
除基本提供量外，若欲额外使用，咨询NHN Cloud客服中心[1:1咨询](https://www.toast.com/kr/support/inquiry)即可。 
申请时，填写欲增加的项目和欲增加的量，可轻松地进行咨询。 

申请后至予以处理需2~5日左右，因此建议相较于实际需要时间提前申请。 
