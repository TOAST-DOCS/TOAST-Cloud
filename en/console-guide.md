## NHN Cloud > Console User Guide

The console serves as management tool and window for the use of NHN Cloud services.
Basic console settings and its user guide are provided as below to use NHN Cloud Service.

NHN Cloud Console provides the following functions:

- Basic information management to use the service (e.g. organizations, or projects)
- Enable/Disable Service
- Manage members who use the service
- Provide payment information

## Console Quick Guide
![tutorial_1_en.png](http://static.toastoven.net/toast/console_guide/consoleguide_01_202103_en.png)
![tutorial_2_en.png](http://static.toastoven.net/toast/console_guide/consoleguide_02_202103_en.png)
![tutorial_3_en.png](http://static.toastoven.net/toast/console_guide/consoleguide_03_202103_en.png)
![tutorial_4_en.png](http://static.toastoven.net/toast/console_guide/consoleguide_04_202103_en.png)
![tutorial_5_en.png](http://static.toastoven.net/toast/console_guide/consoleguide_05_202103_en.png)


## Organization Management

Organization refers to a group which is made to efficiently use and manage NHN Cloud Service.
In an organization, same service policy can be shared with users.
It helps to make use of NHN Cloud Service more efficiently.  

### Create Organizations

- An organization should be created to use NHN Cloud Service.
- Both personal and business members can create organizations.
- Any member who creates an organization automatically becomes the OWNER of his organization.
- Member’s payment method is required to create an organization.
- Organization is in charge of its name and domain information.
- Domain information of an organization must be unique, as it is required for services.

### Organization Services

After an organization is created, you can select services.
Following services are available at the level of organization:

- Dooray!
- ERP
- Groupware
- Contact Center
- IDC
- CloudTrail

### Guide to Create Organizations

![consoleguide_06_en.png](http://static.toastoven.net/toast/console_guide/consoleguide_06_202103_en.png)

1. Access the console and click **+** next to the **Create an organization** message in the menu on top.
2. On the popup window of **Create Organizations**, enter the name of an organization: all are available including Korean, English, special characters and numbers.
3. Click **OK** and organization is completely created.
4. You can find the organization name just created on top of the console menu
5. Click **Setting** to check information of the created organization. Enter domain information as additional information of the organization: domain must be unique in NHN Cloud.


### Delete Organizations

- Only the OWNER can delete his organization.
- All the services currently in use must be deleted first.
- All information of an organization is to be deleted, along with the deletion of organization, and cannot be recovered.  


## Manage Projects

A project is created to use NHN Cloud Service, after an organization is created.
Enable project services to use a project.
Use and charge services by the project.

### Create Projects

- To create a project, an organization is required.
- A member who creates a project is entitled ADMIN of the project.
- Enter the name and description to create a project.
- Enable project services after a project is created.
- When collaboration is required, add project members to share the project after it is created.

### Project Services

You can select services, once a project is created.
Following services can be enabled by each project:

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


### Guide to Create Projects

![consoleguide_07_en.png](http://static.toastoven.net/toast/console_guide/consoleguide_07_202103_en.png)

1. After an organization is created, **Create New Project** button is enabled: click the button to create a project.
2. Enter **Project Name** and **Project Description**.
3. Click **OK** to create a project.
4. The project name shows on the console menu when the project is created.
5. Click project setting to check project information.

### Guide to Enable Project Service

![consoleguide_08_en.png](http://static.toastoven.net/toast/console_guide/consoleguide_08_202103_en.png)

1. Click **Select Services**, after a project is created, to enable services you need
2. Select services on the page of Select Services. When a message asking for Enable Service shows, click **OK**. 
3. Check the list of enabled services on the left of the console. Click the service you want and the service page will show.

### Delete Projects

A project can be deleted if it has no available services.
All its resources are deleted along with the deletion of a project, and cannot be recovered.
You can immediately pay for all the resources that have used before deleting a project.
However, if it is deleted without paid, all charges up to the moment shall be automatically billed on the next payment date.

## Manage Members

| Classification                | TOAST.com Members                                            | Insider Members of Organization (same as IAM of AWS)         |
| :---------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| Definition                    | \- Members for organization management <br>\- NHN Cloud members who consent to Terms of Use and hence are responsible and obligated for the service use <br>\- The members are valid throughout the whole NHN Cloud Service and remain as NHN Cloud members even if their organizations are deleted. | \- Members for the service use <br>\- Members who do not consent to the Terms of Use <br>\- Members who are valid only within their organizations, and to be disqualified if their organizations are deleted |
| Method of Member Registration | \- Owner/Admin of an organization enters NHN Cloud ID for registration | \- Owner/Admin of an organization enters unique ID for registration <br>\- Register via SSO or API interfaces |
| Member Authority              | \- Actions to manage organizations \(Create/Modify Organizations / Manage Organization Members / Manage Organization Services /Manage Payment \)<br>\- Create Projects<br>\- Delete Projects | \- Use Organization Services                                 |

### IP ACL Settings

Only allowed IP (or IP bandwidth) can access the IAM console. 
For Dooray! Services, IP ACL can be set on the service console screen.

- Service Settings 
    - Common Settings: IP ACL can be globally set to all services.
    - Settings per Service: For each service (Cloud, Online Contactm Workplace | Dooray!, etc.), IP ACL can be set.

- IP ACL Settings
    - Not Set: All IPs (or IP bandwidth) can access the console. 
    - Console Accessible by Allowed IP (or IP bandwidth) Only: Only the entered IP(or IP bandwidth) can access the console.
      Please enter an IP or IP bandwidth to allow access. 

### Security Setting for IAM Console Logins 
To tighten console access security for IAM members, [Login Security Setting] is provided.  

![iam_console_login_security_setting_guide_1_en.png](http://static.toastoven.net/toast/console_guide/consoleguide_09_202103_en.png)

1. Access Organization Setting of an organization to configure on a console. 
2. Click [Login Security Setting] on the IAM console. 

#### Two-factor Authentication 
The two-factor authentication can be made a required setting.    

- Service
    - Common Settings
    - Individual Settings for Each Service (e.g. User Console, Dooray, or ERP)
- Two-factor Authentication 
    - Not Configured: Login is available only by ID and password, without two-factor authentication.  
    - Google OTP:  Enter ID and password, and enter One Time Password provided by Google OTP, to authenticate and log in. 
    - Email: Enter ID and password, and click an authentication button delivered via email address, to authenticate and log in. 
- Exclusion IP
    - Not Configured
    - Configured

#### Security for Failed Logins 
When it fails to log in for many consecutive times, you are allowed to log in after certain time. 

- Service 
    Security setting for failed logins can be differently applied for each service. Only common settings are provided. 
- Security for Failed Logins 
    - Not Configured: Login can be attempted forever even after it fails for many times. 
    - Configured: Enter the number of failure and lock timeout,  and you cannot attempt to log in during such lock timeout if you fail to log in as many as the number. 

#### Login Session 
Depending on the setting of login session, login session may be maintained or automatically expired. 
After login is expired, it is required to log in again to access console. 

- Service 
    Security setting for failed logins can be differently applied for each service. Only common settings are provided. 
- Login Session Count
    - Set the available number of simultaneous logins under same ID on many devices.   
    - If the setting is for 1, no simultaneous login is allowed on other devices, like computers or smartphones. 
        - e.g.) PC-  Login Maintained, Smart phones- Auto Logout 
- Login Session Maintenance Time
    - Configure time to maintain login session even without any actions, like a click. 
    - It is automatically logged out, if there's no action, like a click, during configured time. 
    - Consider the length in the setting, due to security issue. 


#### IP ACL 
Access to IAM console is available only in allowed IPs (or IP bandwidth)
Dooray! Service allows the IP ACL setting on the console page of each service. 

- Service
    - Common Settings
    - Individual Settings for Each Service (e.g. User Console, Dooray, or ERP)
- IP ACL
    - Not Configured: Access to IAM console is available in all IPs (or IP bandwidth) 
    - Console Access for Allowed IPs (or IP bandwidth) Only: Access to console is available only in allowed IPs (or IP bandwidth): enter IPs or IP bandwidth to allow access for.  

### Organization Members

#### Organization Role of NHN Cloud Members 

| Action               | Role                                              | Owner | Admin | Member | Billing Viewer | Log Viewer |
| -------------------- | ------------------------------------------------- | ----- | ----- | ------ | -------------- | ---- |
| Manage Organizations | Create Organizations                              | O     |       |        |                |      |
|                      | Modify Organizations                              | O     | O     |        |                |      |
|                      | Delete Organizations                              | O     |       |        |                |      |
| Manage Members       | Register Organization Members                     | O     | O     |        |                |      |
|                      | Delete Organization Members                       | O     | O     |        |                |      |
| Manage Services      | Enable Organization Services                      | O     | O     |        |                |      |
|                      | Disable Organization Services                     | O     | O     |        |                |      |
| Manage Payment       | Query Bills                                       | O     |       |        |                |      |
|                      | Status of Service Use                             | O     | O     |        | O              |      |
| Manage Projects      | Creat Projects                                    | O     | O     | O      |                |      |
| Manage Projects      | Delete Projects                                   | O     |       |        |                |      |
| Manage User Action Log | Query User Action Logs                          |       |       |        |                |  O   |



#### Organization Role of IAM Members 
- Each organization service (e.g. Online Contact, Dooray!) provides different configuration role. 
- IAM members have the following roles for the use of the Cloud console. 
    - The role of MEMBER is selectively provided only when needed. 
    - IAM members without role cannot create or delete a project, or activate service. Only registered project members can use service.  

| Task     | Role                           | MEMBER |
| ------------- | ----------------------------------- | ----- |
| Project Management | Creating projects | O     |

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
| Bill (e-Tax) | ADMIN | Create/Read/Update/Delete Bill (e-Tax) Service |
| Bill (e-Tax) | VIEWER | Read Bill (e-Tax) Service |



## Billing Management

Supports for NHN Cloud members to check prices and pay bills for NHN Cloud Service.
Billing management provides bills for the NHN Cloud members who registered payment methods, along with estimated amount of payment and usage information.
Go to My Profile > Billing Management to check.

Below functions are provided, along with the history of the month’s payment via registered payment method.

- Immediate Payment: Immediate payment is available on the 15th of every month before automatic payment is processed.  
- Sales Statement: Sales statement can be retrieved for credit card payments.
- Tax Invoice: Tax invoices can be retrieved for payment by bank transfers.

Following are included to the bills for retrieval:

- Charged Amount: Prices for usage amount and service charges
- Discount/Extra Charges: Discounts by contract, or discount/extra charges by administrators
- Additional Tax: 10% of (Charged amount- Discount amount + Amount of extra charges)
- Late Charges: 2% of unpaid amount out of total amount of payment
- Total Amount of Payment: (Charged amount- Discount amount+ Amount of extra charges) + Additional Tax
