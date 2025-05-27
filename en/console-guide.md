## NHN Cloud > Console Policy Guide

NHN Cloud console serves as a management tool and task window for using NHN Cloud services.
This document guides you through the basic setup and use of the NHN Cloud console.

NHN Cloud console provides the following features:

- Manage basic information to use services (organization, project)
- Enable/disable services
- Manage members who use services
- Provide billing information

## Quick Guide
This is a quick guide to the basic features provided by the console.

![tutorial_1_en.png](http://static.toastoven.net/toast/console_guide/consoleguide_01_202109_en.png)
![tutorial_2_en.png](http://static.toastoven.net/toast/console_guide/consoleguide_02_202109_en.png)


## Organization Management

An organization is a group that is created to use and manage NHN Cloud services efficiently.
In an organization, users can share and use the same service policy.

### Create an Organization

- To use NHN Cloud services, an organization must be created.
- Both personal and business members can create organizations.
- A member who creates an organization automatically becomes the OWNER of the organization.
- To create an organization, a member's payment method must be registered.
- An organization manages organization name and domain information.
- Domain information of an organization must be unique, because it is required for use by services.

### Guide to Creating an Organization

![console_guide_1_en.png](http://static.toastoven.net/toast/console_guide/consoleguide_03_202109_en.png)
![console_guide_2_en.png](http://static.toastoven.net/toast/console_guide/consoleguide_04_202109_en.png)

1. Go to the console and click the **+** button next to **Create an Organization** in the top menu.
2. In the **Create Organization** window, enter a name for your organization. The organization name can include Korean letters, English letters, special characters, and numbers.
3. Click the **OK** button to complete the organization creation.
4. The created organization name is displayed in the top menu of the console.
5. Click the **Settings** button to check information of the created organization. Enter your domain information as additional information for your organization. The domain must be set as a unique value in NHN Cloud.


### Organization Services

Once the organization is created, you can select services.
Services that can be enabled for each organization include the following:

- Dooray!
- Contact Center
- IDC
- CloudTrail
- Resource Watcher



### Delete an Organization

- An organization can be deleted only by the OWNER of the organization.
- To delete an organization, all the services being used must be deleted.
- When an organization is deleted, all information of the organization is deleted and cannot be restored.

### Organization Governance Setting

You can set and manage policies for stable and efficient use of NHN Cloud services. Set up a common organization policy for security compliance such as login and personal information, so that the members within the organization can comply with the policy.

#### IP ACL Setting
You can use NHN Cloud services with the set IPs (Applicable to: Console, [Framework API](https://docs.nhncloud.com/en/nhncloud/en/public-api/framework-api/), [Notification Hub API](https://docs.nhncloud.com/en/Notification/Notification%20Hub/en/api-guide-v1x0/common-info/))
For Dooray! services, IP ACL can be set on the service's console screen.


1. Go to the console and access the Organization Management page of the organization you want to set up.
2. Select Governance Setting from the submenu.
3. You can set and manage IP ACL under **Set IP ACL** in the Organization Governance Setting.
    * Service setting
        * Common Settings: IP ACL can be set globally for all services.
        * Individual Settings for Each Service: IP ACL can be set for each service (Cloud, Contiple, etc.).
    * IP ACL
        * Not Configured: The console can be accessed from any IPs (or IP range).
        * Console Access Only from Allowed IPs (or IP range): The console can be accessed only from the IPs (or IP range) you entered. Enter the IP or IP range to allow access.
 * Caution: If you also set up overseas access block, even if an IP is registered in the IP ACL, access to the console can be restricted if it is not included in the access allowed countries.

#### Overseas Access Block Settings
If you need to block overseas access, we provide the feature to make the console accessible only from access-allowed countries.

* You can enable or disable the feature in **Overseas Access Block Settings**.
    * Disable: Console access is available in all countries.
    * Enable: Console access is only available in access allowed countries.
* Access Allowed Countries
    * If you have overseas access block set up, you can set which countries are allowed to access.
    * You must select at least one country to allow access.
* Caution: If you set IP ACL together, access to the console can be restricted if the IP ACLs do not include IPs from countries that are allowed to access.       

#### Overseas Access Block Settings
If you need to block overseas access, we provide the feature to make the console accessible only from access-allowed countries.

* You can enable or disable the feature in **Overseas Access Block Settings**.
    * Disable: Console access is available in all countries.
    * Enable: Console access is only available in access allowed countries.
* Access Allowed Countries
    * If you have overseas access block set up, you can set which countries are allowed to access.
    * You must select at least one country to allow access.
* Caution: If you set IP ACL together, access to the console can be restricted if the IP ACLs do not include IPs from countries that are allowed to access.       

 * Caution: If you also set up overseas access block, even if an IP is registered in the IP ACL, access to the console can be restricted if it is not included in the access allowed countries.

#### Overseas Access Block Settings
If you need to block overseas access, we provide the feature to make the console accessible only from access-allowed countries.

* You can enable or disable the feature in **Overseas Access Block Settings**.
    * Disable: Console access is available in all countries.
    * Enable: Console access is only available in access allowed countries.
* Access Allowed Countries
    * If you have overseas access block set up, you can set which countries are allowed to access.
    * You must select at least one country to allow access.
* Caution: If you set IP ACL together, access to the console can be restricted if the IP ACLs do not include IPs from countries that are allowed to access.       

#### Set approval process management
If you need an approval process when using a service, a feature to establish an approval process of the approver is provided for each service.

* You can select **Not Set (Default)** in **Set approval process management.**
* If you select **Set** in Set approval process management, you can use the approval process provided by each service. 
* Services that provide an approval process
    * Secure Key Manager 

#### Set instance name management
When using the instance service, you can set instance name management rules. 

* When selecting **Duplicate allowed management**, the instance name is managed as the name entered by the user, and duplicate instance names are allowed.
* When selecting **Unique management**, the instance name is managed as a unique instance name by combining the name entered by the user and the characters generated by the system.

#### Set control of resource permissions and restriction on terminal access
When NHN Cloud administrator need to view customer's resources (instance, etc.) information for operational purposes, such as responding to failures, users with project ADMIN/MEMBER permissions will be notified by email and the administrator can view the resource information in an isolated environment with enhanced security.

* You can select Disable (Default) in the Set control of resource permissions and restriction on terminal access.
* This setting limits the feature to view customer resources by NHN Cloud administrator, which may cause delays in response in emergency situations such as failures.

#### Privacy Setting
The privacy setting feature is available if you need to protect your privacy.
You can mask personal information that is exposed on the service, or if you need to download personal information, you can make it available only in a separate network environment. 

* Privacy Setting
    * Organization/Project > Manage Member > IAM Member > Download List
        * If not set, any member who can download the IAM member list can download the member list.
        *  If set up, the feature to download member lists is disabled and only exceptionally allowed IPs or IP bands can download member lists.

    * Organization > CloudTrail > Privacy
        * If not set, all members who can view the log list will see the full information in the log list.
        * If set up, personal information (email, name, ID) in the log list is masked.

### IAM Governance Setting

#### Login Security Setting

* To strengthen the console access security of IAM members, **Login Security Setting** feature is provided.
* You can set it globally for all organization services (Cloud, Contiple, Dooray!, etc.), or set it differently for each service.
![console_guide_4_en.png](http://static.toastoven.net/toast/console_guide/consoleguide_06_202303_en.png)

1. Go to the console and access the Organization Management page of the organization you want to set up.
2. Select Governance Setting from the submenu.
3. You can set and manage login security setting in IAM Governance Setting.

#### Two-factor Authentication

You can enable two-factor authentication by setting it as a required feature.

* Service setting
    * Common Settings: Set the two-factor authentication globally for all organization services.
    * Individual Settings for Each Service: You can set two-factor authentication differently for each service (Cloud, Contiple, Dooray!, etc.).
* Two-factor Authentication setting
    * Not Configured: Users can log in by entering their ID and password without two-factor authentication.
    * Google OTP: After entering ID and password, users can log in by entering the One Time Password provided by the Google OTP app.
    * Email: After entering ID and password, users can log in by clicking the **Verify** button sent to their email address for authentication.
* Exclusion IP setting
    * Not Configured: When logging in, users can log in after two-factor authentication from all IP ranges.
    * Configured: Users can log in without two-factor authentication when logging in from the configured IP or IP range.

#### Security for Failed Logins

You can adjust setting so that users can log in again after a certain period of time when they failed to log in repeatedly.

* Service setting
    * Common Setting: Set the two-factor authentication globally for all organization services. (Individual Settings for Each Service is not provided)
* Failure Login Security setting
    * Not Configured: Users can continue to try to log in even if login fails.
    * Configured: If you enter the desired number of failures and lock time, if users fail to log in for the configured number of times, users will not be able to log in during the entered lock time.

#### Login Session

Depending on the login session setting, a login session will be maintained or expire automatically.
After the login expires, the user must log in again to access the console.

* Service setting
    * Common Setting: Set the two-factor authentication globally for all organization services. (Individual Settings for Each Service is not provided)
* Login Session Count
    * Set the number of simultaneous logins with the same ID on multiple devices.
    * If this is set to 1, users cannot log in with the same ID on other devices such as PC or smartphone at the same time.
    E.g.) PC - maintain login, Smartphone - automatically logged out
* Login Session Maintenance Time
    * Set the amount of time to maintain login without any action such as clicking.
    * If a user do not perform any actions such as clicking for a configured period of time, the user will be automatically logged out.
    * Setting it too long is not good for security, so please consider setting it to an appropriate value.

#### Password Policy Settings
* To set passwords for IAM members, the Password Policy Settings is provided.
* The password policy is set the same for all organization services (Cloud, Contiple, Dooray!, etc.).
* Go to **IAM Governance Setting** \> **Password Policy Settings** to manage password policies.
    * Default Password Policy
        * Default password policy is provided as follows.
            * Consists of at least 8 digits, including alphabets, numbers, and special characters.
            * Case sensitive.
            * Unable to use more than four consecutive letters or numbers (for example, 1111, 1234, abcd, etc.).
            * Passwords must be changed every 90 days, and after 90 days, you'll be guided to change your password.
    * User Password Policy
        * Provides password policies that allow you to set minimum password length, password strength, password expiration, password reuse limit, and more.
            * Minimum Password Length: Set the password minimum length to between 8 and 15 characters. (The maximum length is 15 characters.)
            * Password Strength: Set the password strength using a combination of consecutive characters, uppercase, lowercase, numbers, special characters, and more.
            * Password Expiration: Choose whether to expire the password, and set the length of time it expires upon setup, and whether it can be extended upon expiration.
            * Restrict Password Reuse: Choose whether to restrict password reuse and set the number of reuse limits at setup by choosing between 1 and 3.
            * When to Apply Password Policy: Set when the password policy is applied by selecting **Apply on Password Change** or **Apply Immediately** .
                * If **Apply on Password Change** is selected, the new policy applies when an IAM member changes the password.
                * If **Apply Immediately** is selected, the policy applies immediately after the password is set, making it the new policy at the time of IAM member login.

### Project Common role Group Setting

You can create and manage role groups for common use in projects belonging to your organization.
The configured role groups can be used to grant roles in bulk by selecting NHN Cloud members and IAM members in the project's role group management.

1. After selecting Organization Setting, click the Project Common role Group Setting menu.
2. Select **Add role Group** to add roles for each service.
3. Enter the role group name, description, and add roles for each service.
    * The role group name can include Korean letters, English letters, numbers, and special characters, and can contain up to 40 characters.
    * Description is a additional description of the role group, and contain up to 100 characters.
4. roles can be selected from **Detailed Usage roles for Each Service**.
    * After searching for the service name on the left side, select the role on the right side.
5. Check the selected role and add or delete the role.
    * You can delete the selected service by clicking the x button next to the service name.
6. Click the Add button to add a role group.
7. When a role group is added, its name is displayed in the role group list. You can check the detailed role details by selecting the role group name.
8. Clicking Add role leads you to the Add role Group screen in Step 3. You can add or delete roles.

## Project Management

After creating an organization, you can create a project to use NHN Cloud services.
In a project, you can enable project services and use them.
Project services are used on a per-project basis and are billed accordingly.

### Create a Project

* To create a project, you need to create an organization.
* A member who creates a project has ADMIN role for the project.
* When creating a project, enter the project name and project description.
* After creating a project, you can enable project services and use them.
* After creating a project, if collaboration is required, you can add project members to share the project.

### Guide to Creating a Project

![console_guide_5_en.png](http://static.toastoven.net/toast/console_guide/consoleguide_07_202109_en.png)
![console_guide_6_en.png](http://static.toastoven.net/toast/console_guide/consoleguide_08_202109_en.png)

1. After an organization is created, a **Create New Project** button is enabled. Click the **Create New Project** button to create a project.
2. Enter **Project Name** and **Project Description**.
3. Click **Confirm** to create a project.
4. The project name is displayed on the console menu when the project is created.
5. Click the **Project Settings** button to check project information.

### Project Services

Once the project is created, you can select services.
Services that can be enabled for each project include the following:

* Compute
* Container
* Network
* Storage
* Database
* Hybrid & Private Cloud
* Game
* Security
* Content Delivery
* Notification
* AI Service
* Machine Learning
* Application Service
* Mobile Service
* Search
* Data & Analytics
* Dev Tools
* Management
* Bill

### Guide to Enabling Project Services

![console_guide_6_en.png](http://static.toastoven.net/toast/console_guide/consoleguide_09_202109_en.png)
![console_guide_7_en.png](http://static.toastoven.net/toast/console_guide/consoleguide_10_202109_en.png)

1. After creating a project, click the **Select Service** button to select the service to be used in the project.
2. On the Select Service screen, select the service you want to enable. When prompted to enable the service, click **Confirm**.
3. A list of enabled services can be found in the menu on the left side of the console. Click the desired service from the list to display the service page.

### Delete a Project

A project can be deleted if there is no service in use in the project.
When a project is deleted, all resources of the project are deleted and cannot be restored.
You can immediately pay for and delete the usage history for all the resources you have used so far.
However, if you delete the project without paying immediately, the bills used so far will be automatically charged on the next billing date.

## Member Management

Member management allows you to control per-user authentication (login) and authorization.
You can manage members separately in projects and organizations.
Members are classified into NHN Cloud members and IAM members.

### Policy for NHN Cloud Members and IAM Members

| Classification | [NHN Cloud](http://nhncloud.com) Members | IAM Members |
| --- | --- | --- |
| Definition                    | - Members for organization management<br>- NHN Cloud members who consent to Terms of Use and hence are responsible and obligated for the service use <br>- The members are valid throughout the whole NHN Cloud services and remain as NHN Cloud members even if their organizations are deleted. | - Members for the service use<br>- Members who do not consent to the Terms of Use <br>- Members who are valid only within their organizations, and to be disqualified if their organizations are deleted |
| Method of Member Registration | - Owner/Admin of an organization enters NHN Cloud ID for registration | - Owner/Admin of an organization enters unique ID for registration <br>- Register via SSO or API integration |
| Member role              | - Manage organizations (Create/Modify organizations / Manage organization members / Manage organization services /Manage billing)<br>- Create projects<br>- Delete projects | - Use organization services                                 |
| Console Access | - Access NHN Cloud console([https://console.nhncloud.com/](https://console.nhncloud.com/))<br>- NHN Cloud > Log in with member ID/password<br >- (optional) Two-factor (email or SMS) authentication | - IAM console (https://{organization domain}.console.nhncloud.com/) access<br>- Access Dooray! and ERP service with the service domain<br>- Log in with ID/PW set by the organization's OWNER (or ADMIN)<br>- Authenticate with login security set by the organization (two-factor authentication, settings per service) |

### Organization Members

* roles that can be set are different for each organization service (Contiple, Dooray!, etc.).
* Cloud service roles are as follows.
* However, IAM members are granted the NONE role upon enrollment, and must be granted the required role through role settings after enrollment.

#### Organization Management Roles

| Role | Description |
| ---- | ----------- |
| OWNER | Create, Read, Update, Delete, and Delete organizations across the organization, including Organization Management, Member Management, Organization Services Management, Payment Management, and Project Management. |
| ADMIN | Create/Read/Update/Delete for the entire organization, including Organization Management, Member Management, Organization Services Management, Payment Management, Project Management, and more. |
| MEMBER | Create project, read organization dashboard, read project |
| BILLING_VIEWER | Read payment management usage and budget management, and usage status of project in organization. |
| BUDGET_ADMIN | Create, Read, Update, and Delete in budget management |
| BUDGET_VIEWER | Read budget management |
| LOG_VIEWER | Create/Read/Update/Delete user action logs management |
| ORG_DASHBOARD\_ADMIN | Create, Read, Update, and Delete organization dashboard |
| ORG_DASHBOARD\_VIEWER | Read organization dashboard |
| ORG_SUPPORT_ADMIN | Create organization inquiry |
| NONE | Read organization dashboard and organization default settings |

#### Service Use roles

| Service | Role | Description |
| --- | --- | --- |
| CloudTrail | ADMIN | Create, Read, Update, Delete CloudTrail service |
| CloudTrail | VIEWER | Read CloudTrail Service |
| CloudTrail | External Storage Config ADMIN | Create, Read, Update, Delete CloudTrail external storage settings |
| Resource Watcher | ADMIN | Create, Read, Update, and Delete Resource Watcher Service |
| Resource Watcher | VIEWER | Read Resource Watcher Service |


#### Service PERMISSION Role

* The Organization Services PERMISSION role can enable or disable individual services.
* However, services that are enabled at the time of organization creation (CloudTrail, Resource Watcher, etc.) do not provide a separate PERMISSION role.


| Role | Description |
| --- | --- |
| Service Name PERMISSION | Service Enable, Disable  |


### Project Members

* You can grant multiple required roles to project members.

#### Project Management roles

| Role | Description |
| --- | --- |
| ADMIN | Create, Read, Update, Delete for the entire project |
| MARKETPLACE_ADMIN | Marketplace Create, Read, Update, and Delete Services |
| MARKETPLACE_VIEWER | Marketplace Read |
| MEMBER | Create, Read, Update, Delete for all services in the project - Some services excluded (check related roles/permissions)|
| BILLING VIEWER | Read for usage status |
| PROJECT MANAGEMENT ADMIN | Update for project's basic information<br>Create, Read, Update, Delete for project's integrated Appkey<br>Enable, Disable project services<br>Delete for projects |
| PROJECT MANAGEMENT VIEWER | Read for project's basic information<br>Read for project's integrated Appkey |
| PROJECT MEMBER ADMIN | Create, Read, Update, Delete for project members<br>Create, Read, Update, Delete for project's role groups |
| PROJECT MEMBER VIEWER | Read for project members<br>Read for project's role groups |
| PROJECT NOTICE GROUP MANAGEMENT ADMIN | Create, Read, Update, Delete for project's Notification Receiver Group Management <br> Read for project members <br> Read for project's role groups|
| PROJECT NOTICE GROUP MANAGEMENT VIEWER | Read for project's Notification Receiver Group Management <br> Read for project's role groups|
| PROJECT NOTICE MANAGEMENT ADMIN | Create, Read, Update, Delete for project's Notification Management <br> Read for project members <br> Read for project's role groups| Read for project's Notification Receiver Group Management
| PROJECT NOTICE MANAGEMENT VIEWER | Read for project's Notification Management <br> Read for project's role groups| Read for project's Notification Receiver Group Management
| PROJECT API SECURITY SETTING ADMIN | Create, Read, Update, Delete for project's API Security Setting|
| PROJECT API SECURITY SETTING VIEWER | Read for project's API Security Setting|
| PROJECT QUOTA MANAGEMENT ADMIN| Create, Read, Update, Delete for project's Quota Management|
| PROJECT QUOTA MANAGEMENT VIEWER| Read for project's Quota Management|
| PROJECT_SUPPORT_ADMIN| Create project inquiry|
| PROJECT DASHBOARD VIEWER | Read project dashboard|


#### Service Use roles

| Service | Role | Description |
| --- | --- | --- |
| Infrastructure | ADMIN | Create, Read, Update, Delete for Infrastructure Service |
| Infrastructure | MEMBER | Read Network services (except Network Interface, Floating IP), NKS, NCS and Storage Gateway. Create, Read, Update, Delete other services |
| Infrastructure | VIEWER | Read in basic infrastructure services (Key Pair, Direct Connect, NAS (Offline) excluded). Create, Read, Update, and Delete in other services. |
| Infrastructure | Routing ADMIN | RRead Network services (except Network Interface, Floating IP, Routing Table), NKS, NCS and Storage Gateway. Create, Read, Update, Delete other services |
| Infrastructure | Security Group ADMIN | Read Network services (except Network Interface, Floating IP, Security Groups), NKS, NCS and Storage Gateway. Create, Read, Update, Delete other services |
| Infrastructure | Load Balancer ADMIN | Read Network services (except Network Interface, Floating IP, Load Balancer), NKS, NCS and Storage Gateway. Create, Read, Update, Delete other services |
| Infrastructure | Transit Hub ADMIN | Read Network services (except Network Interface, Floating IP, Transit Hub), NKS, NCS and Storage Gateway. Create, Read, Update, Delete other services |
| Infrastructure | Peering Gateway ADMIN | Read Network services (except Network Interface, Floating IP, Peering Gateway), NKS, NCS and Storage Gateway. Create, Read, Update, Delete other services |
| Infrastructure | Colocation Gateway ADMIN | Read Network services (except Network Interface, Floating IP, Colocation Gateway), NKS, NCS and Storage Gateway. Create, Read, Update, Delete other services |
| Infrastructure | NAT Gateway ADMIN | Read Network services (except Network Interface, Floating IP, NAT Gateway), NKS, NCS and Storage Gateway. Create, Read, Update, Delete other services |
| Infrastructure | Service Gateway ADMIN | Read Network services (except Network Interface, Floating IP, Service Gateway), NKS, NCS and Storage Gateway. Create, Read, Update, Delete other services |
| Infrastructure | Private DNS ADMIN | Read Network services (except Network Interface, Floating IP, Private DNS), NKS, NCS and Storage Gateway. Create, Read, Update, Delete other services |
| Infrastructure | Flow Log ADMIN | Read Network services (except Network Interface, Floating IP, Flow Log), NKS, NCS and Storage Gateway. Create, Read, Update, Delete other services |
| Infrastructure | NCS ADMIN | Read Network services (except Network Interface, Floating IP), NKS and Storage Gateway. Create, Read, Update, Delete other services |
| Infrastructure | NKS ADMIN | Read Network services (except Network Interface, Floating IP), NCS and Storage Gateway. Create, Read, Update, Delete other services |
| Virtual Desktop | ADMIN | Create, Read, Update, Delete for Virtual Desktop Service |
| NHN Container Registry (NCR) | ADMIN | Create, Read, Update, Delete for NHN Container Registry (NCR) Service |
| NHN Container Registry (NCR) | VIEWER | Read for NHN Container Registry (NCR) Service |
| NHN Container Registry (NCR) | IMAGE UPLOADER | Read for NHN Container Registry (NCR), Upload Image, Create Artifact, Create Tag |
| DNS Plus | ADMIN | Create, Read, Update, Delete for DNS Plus Service |
| DNS Plus | VIEWER | Read for DNS Plus Service |
| Object Storage | ADMIN | Create, Read, Update, Delete for Object Storage Service |
| Object Storage | Container VIEWER | Read a list of containers in the Object Storage service  |
| Object Storage | Object READER | Read a list of containers in the Object Storage service and details of some of their information. Read a list of objects and their details. Read object download |
| Object Storage | Object WRITER | Read a list of containers in the Object Storage service and details of some of their information. Create, Update, and Delete container management  |
| Object Storage | Object VIEWER | Read a list of containers in the Object Storage service and details of some of their information. Read a list of objects and their details |
| Backup | ADMIN | Create, Read, Update, Delete for Backup Service |
| RDS for MySQL | ADMIN | Create, Read, Update, Delete for RDS for MySQL Service |
| RDS for MySQL | VIEWER | Read for RDS for MySQL Service |
| RDS for MariaDB | ADMIN | Create, Read, Update, Delete for RDS for MariaDB Service |
| RDS for MariaDB | VIEWER | Read for RDS for MariaDB Service |
| RDS for MS-SQL | ADMIN | Create, Read, Update, Delete for RDS for MS-SQL Service |
| EasyCache | ADMIN | Create, Read, Update, Delete for EasyCache Service |
| EasyCache | VIEWER | Read for EasyCache Service Replication Group menu, Read for Monitoring menu |
| Cloud Monitoring | ADMIN | Create, Read, Update, Delete for Cloud Monitoring |
| Cloud Monitoring | VIEWER | Read for Cloud Monitoring |
| Gamebase | ADMIN | Create, Read, Update, Delete for Gamebase Service |
| Gamebase | ANALYTICS VIEWER - ALL | Read for all metrics |
| Gamebase | ANALYTICS VIEWER - EXCLUDING SALES | Read for all metrics except sales |
| Gamebase | ANALYTICS VIEWER - ONLY REAL-TIME | Read for real-time metrics |
| Gamebase | APP ADMIN | Create, Read, Update, Delete for APP menu |
| Gamebase | APP VIEWER | Read for APP menu |
| Gamebase | BAN ADMIN | Create, Read, Update, Delete for Suspended menu |
| Gamebase | BAN VIEWER | Read for Suspended menu |
| Gamebase | COUPON ADMIN | Create, Read, Update, Delete for Coupon menu |
| Gamebase | COUPON VIEWER | Read for Coupon menu |
| Gamebase | CS ADMIN | Create, Read, Update, Delete for Customer Center menu |
| Gamebase | CS INQUIRY SUPPORT | Read, Update for Contact Customer Center menu, Read for member menu |
| Gamebase | IAP ADMIN | Create, Read, Update, Delete for Purchase menu |
| Gamebase | IAP VIEWER | Read for Purchase menu |
| Gamebase | LEADERBOARD ADMIN | Create, Read, Update, Delete for Leaderboard menu |
| Gamebase | LEADERBOARD VIEWER | Read for Leaderboard menu |
| Gamebase | MANAGEMENT ADMIN | Create, Read, Update, Delete for Admin menu |
| Gamebase | MEMBER ADMIN | Create, Read, Update, Delete for Member menu |
| Gamebase | MEMBER VIEWER | Read for Member menu |
| Gamebase | MEMBER FILE DOWNLOAD | Read and Download for menus including Metrics, Sales, Members |
| Gamebase | OPERATION ADMIN | Create, Read, Update, Delete for Operation menu |
| Gamebase | OPERATION VIEWER | Read for Operation menu |
| Gamebase | PUSH ADMIN | Create, Read, Update, Delete for Push menu |
| Gamebase | PUSH VIEWER | Read for Push Menu |
| GameAnvil  | ADMIN | GameAnvil Create, Read, Update, and Delete Services  |
| GameAnvil  | MEMBER | GameAnvil Read Service. Create, Read, Update, or Delete for Monitoring menu |
| GameAnvil  | VIEWER | GameAnvil Read Services  |
| GameStarter  | ADMIN | Create, Read, Update for menus game settings, distribution |
| GameStarter  | VIEWER | Read for menus game settings, distribution |
| Leaderboard | ADMIN | Create, Read, Update, Delete for Leaderboard Service |
| Leaderboard | VIEWER | Read for Leaderboard Service |
| Launching | ADMIN | Create, Read, Update, Delete for Launching Service |
| Smart Downloader | ADMIN | Create, Read, Update, Delete for Smart Downloader Service |
| NHN AppGuard | ADMIN | Create, Read, Update, Delete for NHN AppGuard Service|
| Server Security Check | ADMIN | Create, Read, Update, Delete for Server Security Check  Service |
| Security Monitoring | ADMIN | Create, Read, Update, Delete for Security Monitoring Service |
| CAPTCHA | ADMIN | Create, Read, Update, Delete or CAPTCHA Service |
| WEB Firewall | ADMIN | Create, Read, Update, Delete for WEB Firewall Service |
| Vaccine | ADMIN | Create, Read, Update, Delete for Vaccine Service |
| Secure Key Manager | ADMIN | Create, Read, Update, Delete for Secure Key Manager Service |
| Secure Key Manager | APPROVAL ADMIN | Approve, deny, query,create, query for approval requests for Secure Key Manager Service |
| Secure Key Manager | APPROVAL MEMBER | Create, query for approval requests for Secure Key Manager Service |
| Secure Key Manager | VIEWER | Read for Secure Key Manager Service |
| Security Compliance | ADMIN | Create, Read, Update, Delete for Security Compliance Service|
| Webshell Threat Detector | ADMIN | Create, Read, Update, Delete for Webshell Threat Detector Service |
| Security Advisor | ADMIN | Create, Read, Update, Delete for Security Advisor Service |
| Security Advisor | VIEWER | Read for Security Advisor Service  |
| Network Firewall | ADMIN | Create, Read, Update, Delete for Network Firewall Service  |
| Network Firewall | VIEWER | Read for Network Firewall Service  |
| NHN Bastion | ADMIN | Create, Read, Update, Delete for NHN Bastion Service | 
| NHN Bastion | VIEWER | Read for NHN Bastion Service | 
| NHN Bastion | USER | Use NHN Bastion Service Terminal | 
| CDN | ADMIN | Create, Read, Update, Delete for CDN Service |
| Image Manager | ADMIN | Create, Read, Update, Delete pfor Image Manager Service |
| Notification Hub | ADMIN | Create, Read, Update, Delete for Notification Hub Service |
| Push | ADMIN | Create, Read, Update, Delete for Push Service |
| SMS | ADMIN | Create, Read, Update, Delete for SMS Service |
| SMS | SEND ADMIN | Create, Read in Deliver SMS |
| SMS | DELIVERY RESULT ADMIN | Read in Retrieve by SMS Request, Create Download Search Result, Read in Retrieve Bulk SMS Delivery, Create Download Retrieve Result, Read in Retrieve Tagged SMS Delivery, Create Download Retrieve Result  |
| SMS | SETTING ADMIN | Create, Read, Update, Delete in Manage Templates, Create, Read, Update, Delete in Preregistration Outgoing Numbers, Read in Retrieve Outgoing Number, Create, Read, Update, Delete in Manage Tags, Create, Read, Update, Delete in Manage UIDs, Create, Read, Update, Delete in Manage Webhooks, Create, Read, Update, Delete in Set 080 Call Rejects, Create, Read, Update, Delete in Delivery Setting, Create, Read, Update, Delete in Statistics Event Key |
| SMS | STATISTICS ADMIN | Read in Statistics, Create Download Search Result |
| RCS Bizmessage | ADMIN | Create, Read, Update, Delete for RCS Bizmessage Service |
| Email | ADMIN | Create, Read, Update, Delete for Email Service |
| Email | SEND ADMIN | Create, Read in Deliver Mails |
| Email | DELIVERY RESULT ADMIN | Read in Retrieve by Mail Request, Create Download Search Result<br> Read in Retrieve Scheduled Mail Delivery, Create Download Search Result<br> Read in Retrieve Bulk Mail Delivery, Create Download Search Result<br> Read in Retrieve Tagged Mail Delivery, Create Download Search Result |
| Email | SETTING ADMIN | Create, Read, Update, Delete in Manage Templates<br> Create, Read, Update, Delete in Manage Call Rejects<br> Create, Read, Update, Delete in Manage Mail Domains<br> Create, Read, Update, Delete in Manage Tags<br> Create, Read, Update, Delete in Manage UIDs<br> Create, Read, Update, Delete in Delivery Setting<br> Create, Read, Update, Delete in Manage Webhooks |
| Email | STATISTICS ADMIN | Read in Retrieve Statistics, Create Download Search Result |
| KakaoTalk Bizmessage | ADMIN | Create, Read, Update, Delete for KakaoTalk Bizmessage Service |
| KakaoTalk Bizmessage | SEND ADMIN | (AlimTalk) Create, Read in Send<br> (FriendTalk)Create, Read in Send |
| KakaoTalk Bizmessage | DELIVERY RESULT ADMIN | (AlimTalk) Read Query Delivery Result in KakaoTalk Bizmessage, Create Download Search Result<br> (AlimTalk) Read in Query Mass Delivery, Create Download Search Result<br> (FriendTalk)Read in Query Delivery Result, Create Download Search Result<br> (FriendTalk)Read in Query Mass Delivery, Create Download Search Result |
| KakaoTalk Bizmessage | SETTING ADMIN | Create, Read, Update, Delete in Manage Senders<br> (AlimTalk) Create, Read, Update, Delete in Manage Templates<br> (AlimTalk) Create, Read, Update, Delete in Manage Alternative Delivery<br> (AlimTalk) Create, Read, Update, Delete in Manage sender profile group<br> (FriendTalk)Create, Read, Update, Delete in Manage Images<br> (FriendTalk)Create, Read, Update, Delete in Manage Alternative Delivery |
| KakaoTalk Bizmessage | STATISTICS ADMIN | Read in Statistics, Create Download Search Result |
| Face Recognition | ADMIN | Create, Read, Update, Delete for Face Recognition Service |
| AI Fashion |	ADMIN |	Create, Read, Update, Delete for AI Fashion Service |
| OCR | ADMIN | Create, Read, Update, Delete for OCR | 
| Text to Speech | ADMIN | Create, Read, Update, Delete for Text to Speech |
| Speech to Text | ADMIN | Create, Read, Update, Delete for Speech to Text |
| AI EasyMaker | ADMIN | Create, Read, Update, Delete for AI EasyMaker |
| Maps | ADMIN | Create, Read, Update, Delete for Maps Service |
| ROLE | ADMIN | Create, Read, Update, Delete for ROLE Service |
| API Gateway | ADMIN | Create, Read, Update, Delete for API Gateway Service |
| RTCS | ADMIN | Create, Read, Update, Delete for RTCS Service |
| ShortURL | ADMIN | Create, Read, Update, Delete for ShortURL Service |
| File-Crafter | ADMIN | Create, Read, Update, Delete for File-Crafter Service |
| Cloud Scheduler | ADMIN | Create, Read, Update, Delete for Cloud Scheduler Service |
| IAP | ADMIN | Create, Read, Update, Delete for IAP Service |
| Mobile Device Info | ADMIN | Create, Read, Update, Delete for Mobile Device Info Service |
| Cloud Search | ADMIN | Create, Read, Update, Delete for Cloud Search Service |
| Autocomplete | ADMIN | Create, Read, Update, Delete for AutocompleteService |
| Corporation Search | ADMIN | Create, Read, Update, Delete for Corporation Search Service |
| Log & Crash Search | ADMIN | Create, Read, Update, Delete for Log & Crash Search Service |
| DataFlow | ADMIN | Create, Read, Update, Delete for DataFlow Service |
| DataQuery | ADMIN | Create, Read, Update, Delete for DataQuery Service |
| Pipeline | ADMIN | Create, Read, Update, Delete for Pipeline Service |
| Deploy | ADMIN | Create, Read, Update, Delete for Deploy Service |
| Deploy | VIEWER | Read for Deploy Service |
| Managed | ADMIN | Create, Read, Update, Delete for Managed Service |
| Service Monitoring | ADMIN | Create, Read, Update, Delete for Service Monitoring Service |
| Certificate Manager | ADMIN | Create, Read, Update, Delete for Certificate Manager Service |
| eTax | ADMIN | Create, Read, Update, Delete for eTax Service |
| eTax | VIEWER | Read  for eTax Service |


#### Service PERMISSION Role
Service PERMISSION Role can enable or disable each service.

| Role | Description |
| --- | --- |
| Service Name PERMISSION | Service Enable, Disable  |



## Billing Management

You can check the usage fee for NHN Cloud service and make payment.
In the **View My Info > Manage Billing** menu, you can check the bill, expected payment amount, and usage information of the NHN Cloud member who registered a payment method.

The following features are provided along with the billing details of the payment method for the month.

- Immediate Payment: You can pay with the immediate payment feature before automatic payment that occurs on the 8th of every month.
- Sales slip: If you paid by credit card, you can view the sales slip.
- Tax Invoice: If you paid by bank transfer, you can view your tax invoice.

The details displayed on the payment management invoice are as follows.

- Usage Amount: The amount calculated by service usage and unit price
- Discount/Surcharge Amount: Contract discount, manager discount/surcharge, etc.
- VAT: 10% of (Usage Amount - Discount Amount + Surcharge Amount)
- Late Fee
    - Korean members: In case of non-payment for the Total Amount of Payment, 2% of the amount
    - Japanese members: There is no late fee in accordance with the Japanese Consumer Contract Law.
- Total Amount of Payment: (Usage Amount - Discount Amount + Surcharge Amount) + VAT



## Manage Notifications

Manage Notifications is a feature that allows you to set the recipients and notification method (Email, SMS) for each notification sent by NHN Cloud.

1. Click **Organization > Manage Notifications** or **Project > Manage Notifications**.
    - You can manage the notifications you receive for each of your organizations and projects.

2. Among notifications, find a notification for which you want to change the recipient and go to **Modify Receiver > Modify**.
    - You can find notifications by selecting from the list on the left, or by searching for the notification name, recipient, and more in the top-right search area.
    - To bulk modify recipients of multiple notifications, select the checkboxes of notifications, then click Bulk Modify Receiver at the top of the notification list.

3. Select who should receive notifications and how they should be **notified (Email, SMS) by member, notification recipient group, and role**.
    - Webhook is not supported for the notifications.
    - Notification methods differ depending on notifications.
    - When you add a notification receiver group to Recipient, the notification method set for that group must match the notification method supported by each notification in order to receive notifications.

4. Click **Save** to save your settings.


## Notification Receiver Group Management

Notification Receiver Group Management allows you to set up receiver groups for notifications sent by NHN Cloud.

Email and SMS notifications are supported with receiver settings based on organization/project roles and receiver settings for members.
Webhook notifications provide default webhooks and custom webhooks.
The corresponding notification receiver groups are available when setting up notifications in the **service**.

### Create Notification Receiver Group

1. To create a **notification receiver group**, click **Notification Receiver Group Management** in the organization or project menu.
2. Click ** + Add Notification Receiver Group**.
3. In **Basic information**, enter a name and description for the group receiving notifications.
    - In **Notifications Receiver Group Name**, enter up to 40 characters of Korean, alphanumeric characters, numbers, and special characters
    - In **Description**, enter up to 100 characters without character limit to distinguish the notification receiver group name.

4. **Receiving Role Setting**
    - Organization > Receiving Role Setting
        * Supports setting up email and SMS notifications for organization/project roles, project role groups, and service-specific roles.
    * Project > Receiving Role Setting
        * Supports setting up email and SMS notifications for project roles, project role groups, and service-specific roles.

5. **Receiving Target Manual Setting**
    - You can set your own receivers in Add Notification Receiver Group.
    - Supports setting up email and SMS notifications for each member.

6. **Webhook Settings**
    - When sending out notifications, you can set them to a webhook of your choice.
    - Provides default and custom webhooks by type.  (maximum 5)

### Webhook Settings
1. On the Organization, Project tab, select the ** Notification Receiver Group Management** tab.
2. Select ** +Add Webhook** in the **Webhook Settings** menu at the bottom.
3. The **+ Add webhook** popup provides default and custom webhooks by type.
    - Default Webhook
        - The default webhook can only be sent on service notifications that it supports.
        - Webhook name
            - You can enter a name for the default webhook you want to set up, with no character limit and up to 40 characters.
            - Webhook names cannot be duplicated within the same notification receiver group.
        - Target
            - You can enter a URL to receive the webhook.
        - Secret Key
            - The secret key to encrypt the URI and the id, source, type, and time with the SHA256 hash algorithm.
                - Send Authorization in the default webhook header only if a secret key is set.
                - Example: Authorization : HMAC-SHA256 Signature={encrypted character}"
                    - You can prevent received requests from being tampered with by man-in-the-middle attackers by checking the Authorization Header.
        - The HTTP Mehod is POST and the Request Body is in the format below, with the body field varying by service.
       ```json
       {
          "id": "String",
          "source": "String",
          "specversion": "String",
          "type": "String",
          "body" : "Object"
         }
        ```
    - Custom Webhook
        - Custom webhooks can only be sent on service notifications that support them.
        - Webhook name
            - You can enter a name for the custom webhook you want to set up, up to 40 characters long, with no character limit.
            * Webhook names cannot be duplicated within the same notification receiver group.
        * Send to
            * You can select a destination (custom dashboard or service) to send the webhook to.
            * You can only select menus or services that offer custom webhooks.
        * Target
            * You can enter a URL and HTTP Method to receive the webhook.

          | Target to offer | Range to offer |
          | -- | -- |
          | HTTP Method | POST <br> PUT |
          | Transport Protocol | HTTP<br> HTTPS | 
        - Request data
            - In Request data, you can enter parameters that are provided by the target.
                - You can click Ctrl + Space to see which parameters are supported by that the target.
                - You can see the Value provided in the bottom-right preview.
                    - "alertId": "${alertId}" ,"orgName": "${orgName}"
        - Header
            - You can enter headers to pass to the target.
            - The Content-type header to pass to the target supports application/json and cannot be modified.

          | Header Item | Header Value |
          | -- | -- |
          | Custom-Header1 | Value1 |
          | Custom-Header2 | Value2 | 

        - Enter a name, send to, and receive to, then click **Confirm** to create the webhook.

4. The webhooks you added can be found in the webhook settings list.
    * You can click **View** to see the webhook details.
    * You can edit the webhook information by clicking the pencil icon.
    * You can delete a webhook by clicking the trash can icon.

5. The created webhook is available by adding a **notification receiver group** to the service that provides webhook delivery.


## Technical support

Technical support is a feature that allows you to register or manage inquiries with members of your organization or project.
Registered inquiries are visible to all members within the same organization or project. If necessary, you can leave additional questions to an inquiry registered by another member.

For individual inquiries, use the NHN Cloud Customer Center [1:1](https://www.nhncloud.com/kr/support/inquiry) Inquiry.


### List of Inquiries

1. In the console, click **Organization > Technical Support** or **Project > Technical Support**.
    * You can see a **list of inquiries** received from organizations and projects.

### Submit Inquiry

1. On the **list** screen, click **Submit Inquiry**.
2. Select the type of inquiry you want to submit and complete each field as instructed.
    * The input fields can vary depending on the type of inquiry.
3. Click **Accept** at the bottom.
    * If validation (such as required values) fails, a warning message is exposed in the corresponding input field.

### Submit Additional Questions

1. On the **Inquiry list** screen, click the row of the inquiry that you want to accept additional questions for.
2. Fill out an **additional question** at the bottom of the **Details of Inquiry** section.
3. Click **Submit** in the **Additional Question** section.
    * The additional question and phone number are required.
    * If the phone number listed in the member information exists, the input field is populated with the default value.

### Check Response to Inquiry

1. On the **Inquiry list** screen, click the row of the inquiry you want to see the answer to.
2. You can view your inquiry, additional questions, and answers on the **Details of Inquiry** screen.