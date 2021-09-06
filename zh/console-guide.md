## NHN Cloud > 控制台使用指南

NHN Cloud Console起到使用NHN Cloud服务的管理工具及操作窗口的作用。
下面介绍NHN Cloud控制台的基本设置及使用方法。

NHN Cloud Console提供如下功能。

- 管理使用服务所需的基本信息（组织、项目）
- 启用/禁用服务
- 管理使用服务的会员
- 提供付款信息

## 控制台快捷指南
针对控制台提供的基本功能的快捷指南。 

![tutorial_1_en.png](http://static.toastoven.net/toast/console_guide/consoleguide_01_202103_zh.png)
![tutorial_2_en.png](http://static.toastoven.net/toast/console_guide/consoleguide_02_202103_zh.png)
![tutorial_3_en.png](http://static.toastoven.net/toast/console_guide/consoleguide_03_202103_zh.png)
![tutorial_4_en.png](http://static.toastoven.net/toast/console_guide/consoleguide_04_202103_zh.png)
![tutorial_5_en.png](http://static.toastoven.net/toast/console_guide/consoleguide_05_202103_zh.png)


## 组织管理

组织是为高效使用并管理NHN Cloud服务所创建的组。
在组织中用户可以共享并使用相同的服务策略。
通过组织可以高效使用各种NHN Cloud服务。

### 创建组织

- 为使用NHN Cloud服务，需要创建组织。
- 个人/企业会员均可创建组织。
- 创建组织的会员自动成为组织的OWNER。
- 为创建组织，必须登记会员的付款方式。
- 组织管理组织名/域信息。
- 组织的域信息应为必须在服务中使用的信息以及固有信息。

### 组织服务

创建组织后，可选择服务。
可以以组织为单位启用的服务如下。

- Dooray!
- ERP
- Groupware
- Contact Center
- IDC
- CloudTrail

### 创建组织指南

![console_guide_6_en.png](http://static.toastoven.net/toast/console_guide/consoleguide_06_202103_zh.png)

<center>[图 1] 创建组织 </center>

1. 移动至控制台后，在上端菜单中单击**请创建组织。**旁的**+**按钮。
2. 在**创建组织**窗口中输入组织名称。组织名称可使用韩文、英文、特殊字符、数字。
3. 单击**确认**按钮，组织创建完成。
4. 控制台上端菜单中显示创建的组织名称。
5. 单击**设置**按钮，确认创建的组织信息。作为组织的补充信息，输入域信息。域应设置为NHN Cloud中唯一的值。  

### 删除组织

- 仅组织的OWNER可删除组织。
- 为删除组织，应删除所有使用的服务。
- 删除组织时，组织的所有信息将被删除，且无法恢复。

## 管理项目

创建组织后，为使用NHN Cloud服务而创建项目。
在项目中启用项目服务方可使用服务。
项目服务以项目为单位使用，并以此为基准收费。

### 创建项目

- 为创建项目，应创建组织。
- 创建项目的会员拥有项目的ADMIN权限。
- 创建项目时，输入项目名称与项目说明。
- 创建项目后，启用项目服务方可使用服务。
- 创建项目后，若需要合作，可添加为项目会员一起使用。

### 项目服务

创建项目后，可选择服务。
可以以项目为单位启用的服务如下。

- Compute
- Container
- Network
- Storage
- Database
- Game
- Security
- Content Delivery
- Notification
- Mobile Service
- Analytics
- Application Service
- Search
- Dev Tool
- Management
- Bill

### 创建项目指南

![console_guide_7_en.png](http://static.toastoven.net/toast/console_guide/consoleguide_07_202103_zh.png)

<center>[图2] 创建项目 </center>

1. 创建组织后，**创建新项目**按钮激活。单击**创建新项目**按钮，创建项目。
2. 输入**项目名称**与**项目说明**。
3. 单击**确认**按钮，创建项目。
4. 创建项目后，菜单中显示项目名称。
5. 单击**项目设置**按钮，确认项目信息。

### 启用项目服务指南

![console_guide_8_en.png](http://static.toastoven.net/toast/console_guide/consoleguide_08_202103_zh.png)

<center>[图3] 启用项目服务 </center>

1. 创建项目后，单击**选择服务**按钮，可以选择项目中要使用的服务。
2. 在选择服务界面中选择要激活的服务。显示询问是否要激活服务的信息后，单击**确认**。
3. 启用的服务列表可以在控制台左侧菜单中确认。在列表中单击所需服务，显示服务使用界面。

### 删除项目

若项目中没有正在使用的服务，可删除项目。
删除项目时，项目的所有资源将被删除，且无法恢复。
截至目前使用的所有资源的使用明细，可立即付款并删除。
但若不立即付款而删除时，截至目前使用的费用明细将在下一付款日自动要求付款。

## 管理会员 
利用管理会员，可通过各用户验证（登录）及权限赋予进行控制。 
在项目及组织中，可分开管理会员。 
会员分为NHN Cloud会员及IAM会员。

### NHN Cloud会员与IAM会员政策

| 分类           | TOAST.com会员                                               | IAM会员                               |
| :------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| 定义           | \- 针对组织管理的会员<br>\- 同意NHN Cloud使用条款的NHN Cloud会员，具有服务使用责任及义务的会员 <br>\- 在整体NHN Cloud服务中，即使有效会员所属组织被删除，但仍旧作为NHN Cloud会员存在 | \- 针对服务使用的会员<br>\- 不同意NHN Cloud使用条款的会员<br>\- 仅在组织内有效的会员，若所属的组织删除也会被删除的会员 |
| 会员登记方法 | \- 组织的OWNER或ADMIN输入NHN Cloud ID登记          | \- 组织的OWNER或ADMIN输入组织内唯一的ID登记<br>\- 通过与SSO关联/API关联等登记 |
| 会员权限      | \- 组织管理（组织创建/修改/组织会员管理/组织服务管理/付款管理\）<br>\- 创建项目<br>\- 删除项目 | \- 使用组织服务 |
| 访问控制台      | \- 访问NHN Cloud控制台(https://console.toast.com/) <br>\- NHN Cloud> 以会员ID/PW登录<br> | \- 访问IAM控制台（https://组织域.console.toast.com/）<br> \- （Dooray!、ERP服务以相应服务域访问）<br> \- 以组织的OWNER（或ADMIN）设置的ID/PW登录 \- 组织中设置的登录安全（2次验证，按服务设置）验证 |


### 组织会员

- 组织的OWNER可赋予所有权限，申请服务。 
- OWNER可登记会员，赋予各组织管理权限。

| 操作          | 作用                                | OWNER | ADMIN | MEMBER | Billing Viewer | Log Viewer |
| ------------- | ----------------------------------- | ----- | ----- | ------ | -------------- | -------- |
| 管理组织     | 创建组织                           | O     |       |        |                |  |
|               | 修改组织                           | O     | O     |        |                |  |
|               | 删除组织                           | O     |       |        |                |  |
| 管理会员     | 登记组织会员                      | O     | O     |        |                |  |
|               | 删除组织会员                      | O     | O     |        |                |  |
| 管理服务   | 启用组织服务                  | O     | O     |        |                |  |
|               | 禁用组织服务                | O     | O     |        |                |  |
| 管理付款     | 查询申请书                         | O     |       |        |                |  |
|               | 使用现状                           | O     | O     |        | O              |  |
| 管理项目 | 创建项目                       | O     | O     | O      |                |  |
|               | 删除项目（组织的所有项目） | O     | O     |        |                |  |
|               | 删除项目（创建的项目）     | O     | O     | O      |                |  |
| 管理用户Action日志 | 查询用户Action日志            | O     | O     |       |                | O |

### 项目会员

即使不是组织的会员，也可以成为项目的会员。

| 操作        | 作用                                     | ADMIN | MEMBER |  Billing Viewer |
| ----------- | ---------------------------------------- | ----- | ------ |  -------------- |
| 管理登记Member| 登记项目会员                             | O     |        |              |                         
|             | 删除项目会员                              | O     |        |                                     
| 管理服务 | 启用服务                                     | O     |        |                      |                
|             | 使用服务                                 | O     | O      |                      |                
|             | 禁用服务                                 | O     |        |                      |                
| 使用现状     | 使用现状                                 | O     |        | O                  |               
| 管理项目     | 删除项目                                 | O      |          |                   | 

## IAM Console

### IAM控制台登录安全设置
为增强IAM会员的控制台访问安全，提供[登录安全设置]功能。 

![iam_console_login_security_setting_guide_1_en.png](http://static.toastoven.net/toast/console_guide/consoleguide_09_202103_zh.png)

1.访问要在控制台中设置的组织的组织设置页面。 
2.单击IAM控制台的[登录安全设置]按钮。 

#### 2次验证
2次验证可设置为必须。

- 服务
    - 通用设置
    - 按服务（User Console、Dooray、ERP等）类别设置
- 2次验证
    - 不设置：  不进行2次验证，仅输入ID和密码即可登录。 
    - Google OTP：  输入ID和密码，然后输入Google OTP应用提供的One Time Password（一次性密码）并通过验证后即可登录。  
    - 电子邮件：输入ID和密码后，单击发送到电子邮箱的验证按钮，通过验证后即可登录。 
- Exclusion IP
    - 不设置
    - 设置

#### 登录失败安全
可设置为若登录一直失败，等待一定时间后可再次登录。

- 服务
    - 登录失败安全设置无法按服务类别进行不同的设置。仅提供通用设置功能。  
- 登录失败安全
    - 不设置：即使登录失败也可继续尝试登录。 
    - 设置：输入需要的失败次数和锁定时间，登录失败达到该次数时，在相应的锁定时间内无法尝试登录。 

#### 登录会话
根据登录会话设置，登录会话会保持或自动过期。
登录过期后应重新登录方可访问控制台。

- 服务
    - 登录失败安全设置无法按服务类别进行不同的设置。仅提供通用设置功能。
- 登录会话数
    - 设置可以在多个设备中以相同ID同时登录的个数。 
    - 设置为1个时，不可以相同ID同时登录PC、智能手机等其他设备。 
        - 例）PC- 保持登录，智能手机 - 自动退出
- 登录会话保持时间 
    - 设置即使无单击等任何操作也可保持登录的时间。 
    - 若在设置的时间内不进行单击等操作，则自动退出。 
    - 若设置时间过长，则存在安全问题，因此请考虑后设置。


#### IP ACL 
仅允许使用的IP（或IP段）可访问IAM控制台。 

- 服务
    - 通用设置
    - 按服务（User Console、Dooray、ERP等）类别设置
- IP ACL
    - 不设置：所有IP（或IP段）都可访问IAM控制台。 
    - 仅允许使用的IP（或IP段）访问控制台：仅输入的IP（或IP段）可访问控制台。输入允许访问的IP或IP段即可。 
    
#### Organization Role of IAM Members 
- Each organization service (e.g. Online Contact, Dooray!) provides different configuration role. 
- IAM members have the following roles for the use of the Cloud console. 
    - The role of MEMBER is selectively provided only when needed. 
    - IAM members without role cannot create or delete a project, or activate service. Only registered project members can use service.  

| Task     | Role                           | MEMBER |
| ------------- | ----------------------------------- | ----- |
| Service Management | Activating project service | O     |
|               | Deactivating project service | O     |
| Project Management | Creating projects | O     |
|              | Deleting projects (which have been created) | O     |

### Project Members
Even a non-organization member can serve as project member. 
A project member can be given with many roles.  
However, ADMIN and MEMBER who have the same role as SUPER ADMIN with access to all services, cannot have other roles at the same time. 

#### Role of Project Management 
| Task    | Role                                | ADMIN | MEMBER |  BILLING VIEWER |
| ----------- | ---------------------------------------- | ----- | ------ | -------------------- |
| Member Management | Register project members     | O     |        |                   |
|             | Delete project members         | O     |        |                      |
| Service Management | Activate service          | O     |        |                      |
|             | Use service                 | O     | O      |                      |
|             | Deactivate service       | O     |        |                      |
| Usage Status | Status of service use           | O     |       | O                    |
| Project Management | Delete projects           | O     |       |                      |
|              | Delete projects (which have been created) |      | O       |                     |


#### Role of Service Use

| Service | Role | Description |
| --- | --- | --- |
| Infrastructure | ADMIN | Create/Read/Update/Delete Infrastructure Service |
| Infrastructure | MEMBER | Viewer VPC, Security Group, Auto Scale, Load Balancer Services. Create/Read/Update/Delete Other services |
| Container Registry | ADMIN | Create/Read/Update/Delete Container Registry Service |
| Container Registry | VIEWER | Read Container Registry Service |
| DNS Plus | ADMIN | Create/Read/Update/Delete DNS Plus Service |
| Object Storage | ADMIN | Create/Read/Update/Delete Object Storage Service |
| Backup | ADMIN | Create/Read/Update/Delete Backup Service |
| RDS for MySQL | ADMIN | Create/Read/Update/Delete RDS for MySQL Service |
| RDS for MS-SQL | ADMIN | Create/Read/Update/Delete RDS for MS-SQL Service |
| EasyCache | ADMIN | Create/Read/Update/Delete EasyCache Service |
| EasyCache | VIEWER | Read EasyCache Service Replication Group menu, read Monitoring menu |
| Gamebase | ADMIN | Create/Read/Update/Delete Gamebase Service |
| Leaderboard | ADMIN | Create/Read/Update/Delete Leaderboard Service |
| Leaderboard | VIEWER | Read Leaderboard Service |
| Launching | ADMIN | Create/Read/Update/Delete Launching Service |
| Smart Downloader | ADMIN | Create/Read/Update/Delete Smart Downloader Service |
| NHN AppGuard | ADMIN | Create/Read/Update/Delete NHN AppGuard  Service|
| App Security Check | ADMIN | Create/Read/Update/Delete App Security Check Service |
| Server Security Check | ADMIN | Create/Read/Update/Delete Server Security Check  Service |
| Security Monitoring | ADMIN | Create/Read/Update/Delete Security Monitoring Service |
| CAPTCHA | ADMIN | Create/Read/Update/Delete CAPTCHA Service |
| OTP | ADMIN | Create/Read/Update/Delete OTP Service |
| WEB Firewall | ADMIN | Create/Read/Update/Delete WEB Firewall Service |
| Vaccine | ADMIN | Create/Read/Update/Delete Vaccine Service |
| Secure Key Manager | ADMIN | Create/Read/Update/Delete Secure Key Manager Service |
| Secure Key Manager | VIEWER | Read ecure Key Manager Service |
| Security  Compliance | ADMIN | Create/Read/Update/Delete Security Compliance Service|
| DDoS Guard | ADMIN | Create/Read/Update/Delete DDoS Guard Service |
| SIEM | ADMIN | Create/Read/Update/Delete SIEM Service |
| CDN | ADMIN | Create/Read/Update/Delete CDN Service |
| Image | ADMIN | Create/Read/Update/Delete Image Service |
| Push | ADMIN | Create/Read/Update/Delete Push Service |
| SMS | ADMIN | Create/Read/Update/Delete SMS Service |
| Email | ADMIN | Create/Read/Update/Delete Email Service |
| KakaoTalk Bizmessage | ADMIN | Create/Read/Update/Delete KakaoTalk Bizmessage Service |
| Face Recognition | ADMIN | Create/Read/Update/Delete Face Recognition Service |
| AI Fashion |	ADMIN |	Create/Read/Update/Delete AI Fashion Service |
| IAP | ADMIN | Create/Read/Update/Delete IAP Service |
| Mobile Device Info | ADMIN | Create/Read/Update/Delete Mobile Device Info Service |
| Log & Crash Search | ADMIN | Create/Read/Update/Delete Log & Crash Search Service |
| Maps | ADMIN | Create/Read/Update/Delete Maps Service |
| ROLE | ADMIN | Create/Read/Update/Delete ROLE Service |
| API Gateway | ADMIN | Create/Read/Update/Delete API Gateway Service |
| RTCS | ADMIN | Create/Read/Update/Delete RTCS Service |
| ShortURL | ADMIN | Create/Read/Update/Delete ShortURL Service |
| Cheating Detection | ADMIN | Create/Read/Update/Delete Cheating Detection Service |
| Cloud Search | ADMIN | Create/Read/Update/Delete Cloud Search Service |
| Autocomplete | ADMIN | Create/Read/Update/Delete AutocompleteService |
| Corporation Search | ADMIN | Create/Read/Update/Delete Corporation Search Service |
| Address Search | ADMIN | Create/Read/Update/Delete Address Search Service |
| Pipeline | ADMIN | Create/Read/Update/Delete Pipeline Service |
| Deploy | ADMIN | Create/Read/Update/Delete Deploy Service |
| Managed | ADMIN | Create/Read/Update/Delete Managed Service |
| Service Monitoring | ADMIN | Create/Read/Update/Delete Service Monitoring Service |
| Certificate Manager | ADMIN | Create/Read/Update/Delete Certificate Manager Service |
| eTax | ADMIN | Create/Read/Update/Delete eTax Service |
| eTax | VIEWER | Read eTax Service |




## 付款管理

可确认NHN Cloud服务使用费用并付款。
在**查看我的信息 > 付款管理**菜单中可以查看登记付款方式的NHN Cloud会员的申请书与预计付款金额、使用量信息。

提供相应月通过付款方式付款的明细以及以下功能。

- 即时付款：每月8日自动付款前，可通过即时付款功能付款。
- 销售凭证：使用信用卡付款时，可查询销售凭证。
- 税单：使用转账付款时，可查询税务发票。

付款管理请求书中查询到的明细如下。

- 使用金额：计算服务使用量与单价的金额
- 折扣/附加金额：协议折扣、管理员折扣/附加金额等
- 附加税：（使用金额 - 折扣金额 + 附加金额）的10%
- 滞纳金
    - 韩国会员：未缴纳最终金额时，相应金额的2%
    - 日本会员：依据日本消费者合同法，不产生滞纳金。
- 最终付款金额：（使用金额 - 折扣金额 + 附加金额）+ 附加税

