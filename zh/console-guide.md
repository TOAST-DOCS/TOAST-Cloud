## TOAST > 控制台使用指南

TOAST Console起到使用TOAST服务的管理工具及操作窗口的作用。
下面介绍TOAST控制台的基本设置及使用方法。

TOAST Console提供如下功能。

- 管理使用服务所需的基本信息（组织、项目）
- 启用/禁用服务
- 管理使用服务的会员
- 提供付款信息

## 控制台快捷指南
针对控制台提供的基本功能的快捷指南。 

![tutorial_1_en.png](http://static.toastoven.net/toast/console_guide/consoleguide_01_201812_en.png)
![tutorial_2_en.png](http://static.toastoven.net/toast/console_guide/consoleguide_02_201812_en.png)
![tutorial_3_en.png](http://static.toastoven.net/toast/console_guide/consoleguide_03_201812_en.png)
![tutorial_4_en.png](http://static.toastoven.net/toast/console_guide/consoleguide_04_201812_en.png)
![tutorial_5_en.png](http://static.toastoven.net/toast/console_guide/consoleguide_05_201812_en.png)


## 组织管理

组织是为高效使用并管理TOAST服务所创建的组。
在组织中用户可以共享并使用相同的服务策略。
通过组织可以高效使用各种TOAST服务。

### 创建组织

- 为使用TOAST服务，需要创建组织。
- 个人/企业会员均可创建组织。
- 创建组织的会员自动成为组织的OWNER。
- 为创建组织，必须登记会员的付款方式。
- 组织管理组织名/域信息。
- 组织的域信息应为必须在服务中使用的信息以及固有信息。

### 组织服务

创建组织后，可选择服务。
可以以组织为单位启用的服务如下。

- ERP
- Dooray!
- Contact Center
- IDC
- CloudTrail

### 创建组织指南

![console_guide_6_en.png](http://static.toastoven.net/toast/console_guide/consoleguide_06_201812_en.png)

<center>[图 1] 创建组织 </center>

1. 移动至控制台后，在上端菜单中单击**请创建组织。**旁的**+**按钮。
2. 在**创建组织**窗口中输入组织名称。组织名称可使用韩文、英文、特殊字符、数字。
3. 单击**确认**按钮，组织创建完成。
4. 控制台上端菜单中显示创建的组织名称。
5. 单击**设置**按钮，确认创建的组织信息。作为组织的补充信息，输入域信息。域应设置为TOAST中唯一的值。  

### 删除组织

- 仅组织的OWNER可删除组织。
- 为删除组织，应删除所有使用的服务。
- 删除组织时，组织的所有信息将被删除，且无法恢复。

## 管理项目

创建组织后，为使用TOAST服务而创建项目。
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
- Storage
- Network
- Database
- Security
- Content Delivery
- Dev Tool
- Management
- Game
- Notification
- Analytics
- Application Service
- Search
- Mobile Service
- Bill

### 创建项目指南

![console_guide_7_en.png](http://static.toastoven.net/toast/console_guide/consoleguide_07_201812_en.png)

<center>[图2] 创建项目 </center>

1. 创建组织后，**创建新项目**按钮激活。单击**创建新项目**按钮，创建项目。
2. 输入**项目名称**与**项目说明**。
3. 单击**确认**按钮，创建项目。
4. 创建项目后，菜单中显示项目名称。
5. 单击**项目设置**按钮，确认项目信息。

### 启用项目服务指南

![console_guide_8_en.png](http://static.toastoven.net/toast/console_guide/consoleguide_08_201812_en.png)

<center>[图3] 启用项目服务 </center>

1. 创建项目后，单击**选择服务**按钮，可以选择项目中要使用的服务。
2. 在选择服务界面中选择要激活的服务。显示询问是否要激活服务的信息后，单击**确认**。显示提示移动至可以使用服务的页面信息后，单击**确认**按钮。
3. 启用的服务列表可以在控制台左侧菜单中确认。在列表中单击所需服务，显示服务使用界面。

### 删除项目

若项目中没有正在使用的服务，可删除项目。
删除项目时，项目的所有资源将被删除，且无法恢复。
截至目前使用的所有资源的使用明细，可立即付款并删除。
但若不立即付款而删除时，截至目前使用的费用明细将在下一付款日自动要求付款。

## 管理会员 
利用管理会员，可通过各用户验证（登录）及权限赋予进行控制。 
在项目及组织中，可分开管理会员。 
会员分为TOAST会员及IAM会员。

### TOAST会员与IAM会员政策

| 分类           | TOAST.com会员                                               | IAM会员                               |
| :------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| 定义           | \- 针对组织管理的会员<br>\- 同意TOAST使用条款的TOAST会员，具有服务使用责任及义务的会员 <br>\- 在整体TOAST服务中，即使有效会员所属组织被删除，但仍旧作为TOAST会员存在 | \- 针对服务使用的会员<br>\- 不同意TOAST使用条款的会员<br>\- 仅在组织内有效的会员，若所属的组织删除也会被删除的会员 |
| 会员登记方法 | \- 组织的OWNER或ADMIN输入TOAST ID登记          | \- 组织的OWNER或ADMIN输入组织内唯一的ID登记<br>\- 通过与SSO关联/API关联等登记 |
| 会员权限      | \- 组织管理（组织创建/修改/组织会员管理/组织服务管理/付款管理\）<br>\- 创建项目<br>\- 删除项目 | \- 使用组织服务 |
| 访问控制台      | \- 访问TOAST控制台(https://console.toast.com/) <br>\- TOAST> 以会员ID/PW登录<br> | \- 访问IAM控制台（https://组织域.console.toast.com/）<br> \- （Dooray!、ERP服务以相应服务域访问）<br> \- 以组织的OWNER（或ADMIN）设置的ID/PW登录 \- 组织中设置的登录安全（2次验证，按服务设置）验证 |

### IAM控制台登录安全设置
为增强IAM会员的控制台访问安全，提供[登录安全设置]功能。 

可对所有的组织服务（Cloud Console, Online Contact, Dooray! 等）进行相同的设置，也可按照各种服务类别进行不同的设置。 

![iam_console_login_security_setting_guide_1_en.png](http://static.toastoven.net/toast/console_guide/consoleguide_09_201903_en.png)

1.访问要在控制台中设置的组织的组织设置页面。 
2.单击IAM控制台的[登录安全设置]按钮。 

#### 2次验证

2次验证可设置为必须。

![iam_console_login_security_setting_guide_2_en.png](http://static.toastoven.net/toast/console_guide/consoleguide_10_201903_en.png)
- 不设置：  不进行2次验证，仅输入ID和密码即可登录。 
- Google OTP：  输入ID和密码，然后输入Google OTP应用提供的One Time Password（一次性密码）并通过验证后即可登录。  
- 电子邮件：输入ID和密码后，单击发送到电子邮箱的验证按钮，通过验证后即可登录。 

#### 登录失败安全

可设置为若登录一直失败，等待一定时间后可再次登录。

登录失败安全设置无法按服务类别进行不同的设置。仅提供通用设置功能。  

![iam_console_login_security_setting_guide_3_en.png](http://static.toastoven.net/toast/console_guide/consoleguide_11_201903_en.png)
- 不设置：即使登录失败也可继续尝试登录。 
- 设置：输入需要的失败次数和锁定时间，登录失败达到该次数时，在相应的锁定时间内无法尝试登录。 

#### IP ACL 

仅允许使用的IP（或IP段）可访问IAM控制台。 

![iam_console_login_security_setting_guide_4_en.png](http://static.toastoven.net/toast/console_guide/consoleguide_13_201903_en.png)
- 不设置：所有IP（或IP段）都可访问IAM控制台。 
- 仅允许使用的IP（或IP段）访问控制台：仅输入的IP（或IP段）可访问控制台。输入允许访问的IP或IP段即可。 


### 组织会员

- 组织的OWNER可赋予所有权限，申请服务。 
- OWNER可登记TOAST会员，赋予各组织管理权限。
- TOAST会员不注册toast.com时，向登记TOAST会员时输入的邮箱发送邀请邮件。

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

项目的会员是toast.com的会员。组织内部会员作为项目会员，可以使用服务的功能预计之后提供。
即使不是组织的会员，也可以成为项目的会员。

| 操作        | 作用                                     | ADMIN | MEMBER | Billing Viewer ADMIN | Billing Viewer |
| ----------- | ---------------------------------------- | ----- | ------ | -------------------- | -------------- |
| 管理登记Member(ADMIN)                              | O     |        |                      |                |
|             | 删除项目会员(ADMIN)                | O     |        |                      |                |
|             | 登记项目会员(MEMBER)               | O     |        |                      |                |
|             | 删除项目会员(MEMBER)               | O     |        |                      |                |
|             | 登记项目会员(Billing Viewer ADMIN) | O     |        |                      |                |
|             | 删除项目会员(Billing Viewer ADMIN) | O     |        |                      |                |
|             | 登记项目会员(Billing Viewer)       | O     |        | O                    |                |
|             | 删除项目会员(Billing Viewer)       | O     |        | O                    |                |
| 管理服务 | 启用服务                            | O     |        |                      |                |
|             | 使用服务                              | O     | O      |                      |                |
|             | 禁用服务                          | O     |        |                      |                |
| 使用现状   | 使用现状                                | O     |        | O                    | O              |


## 付款管理

可确认TOAST服务使用费用并付款。
在**查看我的信息 > 付款管理**菜单中可以查看登记付款方式的TOAST会员的申请书与预计付款金额、使用量信息。

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

