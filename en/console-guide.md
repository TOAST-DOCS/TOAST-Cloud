## NHN Cloud > Console User Guide

NHN Cloud console serves as a management tool and task window for using NHN Cloud services.
This document guides you through the basic setup and use of the NHN Cloud console.

NHN Cloud console provides the following features:

- Manage basic information to use services (organization, project)
- Enable/disable services
- Manage members who use services
- Provide billing information

<!-- Video guide is not provided in the translated document -->
<!-- Dummy comment for a video link -->

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
- ERP
- Groupware
- Contact Center
- IDC
- CloudTrail



### Delete an Organization

- An organization can be deleted only by the OWNER of the organization.
- To delete an organization, all the services being used must be deleted.
- When an organization is deleted, all information of the organization is deleted and cannot be restored.

### Organization Governance Setting

Set up a common organization policy for security compliance such as login and personal information, so that the members within the organization can comply with the policy.

#### IP ACL Setting
When IP ACL is set, the console can be accessed from the allowed IPs (or IP range) only.
For Dooray! services, IP ACL can be set on the service's console screen.
![console_guide_3_en.png](http://static.toastoven.net/toast/console_guide/consoleguide_05_202109_en.png)

1. Go to the console and access the Organization Management page of the organization you want to set up.
2. Select Governance Setting from the submenu.
3. You can set and manage IP ACL under **Set IP ACL** in the Organization Governance Setting.
    * Service setting
        * Common Settings: IP ACL can be set globally for all services.
        * Individual Settings for Each Service: IP ACL can be set for each service (Cloud Console, Online Contact, Dooray!, etc.).
    * IP ACL
        * Not Configured: The console can be accessed from any IPs (or IP range).
        * Console Access Only from Allowed IPs (or IP range): The console can be accessed only from the IPs (or IP range) you entered. Enter the IP or IP range to allow access.

### IAM Governance Setting

#### Login Security Setting

* To strengthen the console access security of IAM members, **Login Security Setting** feature is provided.
* You can set it globally for all organization services (Console, Online Contact, Dooray!, etc.), or set it differently for each service.
![console_guide_4_en.png](http://static.toastoven.net/toast/console_guide/consoleguide_06_202109_en.png)

1. Go to the console and access the Organization Management page of the organization you want to set up.
2. Select Governance Setting from the submenu.
3. You can set and manage login security setting in IAM Governance Setting.

#### Two-factor Authentication

You can enable two-factor authentication by setting it as a required feature.

* Service setting
    * Common Settings: Set the two-factor authentication globally for all organization services.
    * Individual Settings for Each Service: You can set two-factor authentication differently for each service (Cloud Console, Online Contact, Dooray!, etc.).
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

### Project Common Permission Group Setting

You can create and manage permission groups for common use in projects belonging to your organization.
The configured permission groups can be used to grant permissions in bulk by selecting NHN Cloud members and IAM members in the project's permission group management.

1. After selecting Organization Setting, click the Project Common Permission Group Setting menu.
2. Select **Add Permission Group** to add permissions for each service.
3. Enter the permission group name, description, and add permissions for each service.
    * The permission group name can include Korean letters, English letters, numbers, and special characters, and can contain up to 40 characters.
    * Description is a additional description of the permission group, and contain up to 100 characters.
4. Permissions can be selected from **Detailed Usage Permissions for Each Service**.
    * After searching for the service name on the left side, select the permission on the right side.
5. Check the selected permission and add or delete the permission.
    * You can delete the selected service by clicking the x button next to the service name.
6. Click the Add button to add a permission group.
7. When a permission group is added, its name is displayed in the permission group list. You can check the detailed permission details by selecting the permission group name.
8. Clicking Add Permission leads you to the Add Permission Group screen in Step 3. You can add or delete permissions.

## Project Management

After creating an organization, you can create a project to use NHN Cloud services.
In a project, you can enable project services and use them.
Project services are used on a per-project basis and are billed accordingly.

### Create a Project

* To create a project, you need to create an organization.
* A member who creates a project has ADMIN permission for the project.
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

| Classification | [NHN Cloud](http://TOAST.com) Members | IAM Members |
| --- | --- | --- |
| Definition                    | - Members for organization management<br>- NHN Cloud members who consent to Terms of Use and hence are responsible and obligated for the service use <br>- The members are valid throughout the whole NHN Cloud services and remain as NHN Cloud members even if their organizations are deleted. | - Members for the service use<br>- Members who do not consent to the Terms of Use <br>- Members who are valid only within their organizations, and to be disqualified if their organizations are deleted |
| Method of Member Registration | - Owner/Admin of an organization enters NHN Cloud ID for registration | - Owner/Admin of an organization enters unique ID for registration <br>- Register via SSO or API integration |
| Member Permission              | - Manage organizations (Create/Modify organizations / Manage organization members / Manage organization services /Manage billing)<br>- Create projects<br>- Delete projects | - Use organization services                                 |
| Console Access | - Access NHN Cloud console([https://console.toast.com/])(https://console.toast.com/)<br>- NHN Cloud > Log in with member ID/password<br >- (optional) Two-factor (email or SMS) authentication | - IAM console (https://{organization domain}.console.toast.com/) access<br>- Access Dooray! and ERP service with the service domain<br>- Log in with ID/PW set by the organization's OWNER (or ADMIN)<br>- Authenticate with login security set by the organization (two-factor authentication, settings per service) |

### Organization Members

* The OWNER of the organization can grant full control of the account and apply for services.
* OWNER can register members and grant management permission for each organization.

#### Organization Permission of NHN Cloud Members 

| Task               | Role                                              | OWNER | ADMIN | MEMBER | Billing Viewer | Log Viewer |
| -------------------- | ------------------------------------------------- | ----- | ----- | ------ | -------------- | ---- |
| Manage Organizations | Create Organizations                              | O     |       |        |                |      |
|                      | Modify Organizations                              | O     | O     |        |                |      |
|                      | Delete Organizations                              | O     |       |        |                |      |
| Manage Members       | Register Organization Members                     | O     | O     |        |                |      |
|                      | Delete Organization Members                       | O     | O     |        |                |      |
| Manage Services      | Enable Organization Services                      | O     | O     |        |                |      |
|                      | Disable Organization Services                     | O     | O     |        |                |      |
| Manage Billing       | Query Bills                                       | O     |       |        |                |      |
|                      | Status of Service Use                             | O     | O     |        | O              |      |
| Manage Projects      | Create Projects                                    | O     | O     | O      |                |      |
|                      | Delete Projects                                   | O     | O     |        |                |      |
| Manage User Action Log | Query User Action Logs                          | O     | O     |        |                |  O   |

#### Organization Permission of IAM Members 

* Permissions that can be set are different for each organization service (Online Contact, Dooray!, etc.).
* Cloud service permissions are as follows.
    * The MEMBER permission can be selectively granted only when needed.
    * If the MEMBER permission is granted, the user can create a project directly.

| Task | Role | MEMBER |
| --- | --- | --- |
| Manage Project | Create Projects | O |

### Project Members

A user can become a member of a project even if the user is not a member of an organization.
You can grant multiple required permissions to project members.

#### Project Management Permissions

| Permission | Description |
| --- | --- |
| ADMIN | Create/Read/Update/Delete permission for the entire project |
| MEMBER | Create/Read/Update/Delete permission for all services in the project |
| BILLING VIEWER | Read permission for usage status |
| PROJECT MANAGEMENT ADMIN | Update for project's basic information<br>Create/Read/Update/Delete permission for project's integrated Appkey<br>Create/Read/Update/Delete permission for project's permission groups<br>Enable/Disable project services<br>Delete for projects |
| PROJECT MANAGEMENT VIEWER | Read permission for project's basic information<br>Read permission for project's integrated Appkey<br>Read permission for project's permission groups |
| PROJECT MEMBER ADMIN | Create/Read/Update/Delete permission for project members |
| PROJECT MEMBER VIEWER | Read permission for project members |

#### Service Use Permissions

| Service | Permission | Description |
| --- | --- | --- |
| Infrastructure | ADMIN | Create/Read/Update/Delete permission for Infrastructure Service |
| Infrastructure | MEMBER | Read permission for VPC, Security Group, Auto Scale, Load Balancer Services. Create/Read/Update/Delete permission for Other services |
| Container Registry | ADMIN | Create/Read/Update/Delete permission for Container Registry Service |
| Container Registry | VIEWER | Read permission for Container Registry Service |
| DNS Plus | ADMIN | Create/Read/Update/Delete permission for DNS Plus Service |
| Object Storage | ADMIN | Create/Read/Update/Delete permission for Object Storage Service |
| Backup | ADMIN | Create/Read/Update/Delete permission for Backup Service |
| RDS for MySQL | ADMIN | Create/Read/Update/Delete permission for RDS for MySQL Service |
| RDS for MySQL | VIEWER | Read permission for RDS for MySQL Service |
| RDS for MariaDB | ADMIN | Create/Read/Update/Delete permission for RDS for MariaDB Service |
| RDS for MariaDB | VIEWER | Read permission for RDS for MariaDB Service |
| RDS for MS-SQL | ADMIN | Create/Read/Update/Delete permission for RDS for MS-SQL Service |
| EasyCache | ADMIN | Create/Read/Update/Delete permission for EasyCache Service |
| EasyCache | VIEWER | Read permission for EasyCache Service Replication Group menu, Read permission for Monitoring menu |
| Gamebase | ADMIN | Create/Read/Update/Delete permission for Gamebase Service |
| Gamebase | ANALYTICS VIEWER - ALL | Read permission for all metrics |
| Gamebase | ANALYTICS VIEWER - EXCLUDING SALES | Read permission for all metrics except sales |
| Gamebase | ANALYTICS VIEWER - ONLY REAL-TIME | Read permission for real-time metrics |
| Gamebase | APP ADMIN | Create, Read, Update, Delete for APP menu |
| Gamebase | APP VIEWER | Read permission for APP menu |
| Gamebase | BAN ADMIN | Create, Read, Update, Delete for Suspended menu |
| Gamebase | BAN VIEWER | Read permission for Suspended menu |
| Gamebase | COUPON ADMIN | Create, Read, Update, Delete for Coupon menu |
| Gamebase | COUPON VIEWER | Read permission for Coupon menu |
| Gamebase | CS ADMIN | Create, Read, Update, Delete for Customer Center menu |
| Gamebase | CS INQUIRY SUPPORT | Read, Update for Contact Customer Center menu, Read permission for member menu |
| Gamebase | IAP ADMIN | Create, Read, Update, Delete for Purchase menu |
| Gamebase | IAP VIEWER | Read permission for Purchase menu |
| Gamebase | LEADERBOARD ADMIN | Create, Read, Update, Delete for Leaderboard menu |
| Gamebase | LEADERBOARD VIEWER | Read permission for Leaderboard menu |
| Gamebase | MANAGEMENT ADMIN | Create, Read, Update, Delete for Admin menu |
| Gamebase | MEMBER ADMIN | Create, Read, Update, Delete for Member menu |
| Gamebase | MEMBER VIEWER | Read permission for Member menu |
| Gamebase | MEMBER FILE DOWNLOAD | Read and Download for menus including Metrics, Sales, Members |
| Gamebase | OPERATION ADMIN | Create, Read, Update, Delete for Operation menu |
| Gamebase | OPERATION VIEWER | Read permission for Operation menu |
| Gamebase | PUSH ADMIN | Create, Read, Update, Delete for Push menu |
| Gamebase | PUSH VIEWER | Read permission for Push Menu |
| Leaderboard | ADMIN | Create/Read/Update/Delete permission for Leaderboard Service |
| Leaderboard | VIEWER | Read permission for Leaderboard Service |
| Launching | ADMIN | Create/Read/Update/Delete permission for Launching Service |
| Smart Downloader | ADMIN | Create/Read/Update/Delete permission for Smart Downloader Service |
| NHN AppGuard | ADMIN | Create/Read/Update/Delete permission for NHN AppGuard Service|
| App Security Check | ADMIN | Create/Read/Update/Delete permission for App Security Check Service |
| Server Security Check | ADMIN | Create/Read/Update/Delete permission for Server Security Check  Service |
| Security Monitoring | ADMIN | Create/Read/Update/Delete permission for Security Monitoring Service |
| CAPTCHA | ADMIN | Create/Read/Update/Delete permission for CAPTCHA Service |
| OTP | ADMIN | Create/Read/Update/Delete permission for OTP Service |
| WEB Firewall | ADMIN | Create/Read/Update/Delete permission for WEB Firewall Service |
| Vaccine | ADMIN | Create/Read/Update/Delete permission for Vaccine Service |
| Secure Key Manager | ADMIN | Create/Read/Update/Delete permission for Secure Key Manager Service |
| Secure Key Manager | VIEWER | Read permission for Secure Key Manager Service |
| Security Compliance | ADMIN | Create/Read/Update/Delete permission for Security Compliance Service|
| DDoS Guard | ADMIN | Create/Read/Update/Delete permission for DDoS Guard Service |
| SIEM | ADMIN | Create/Read/Update/Delete permission for SIEM Service |
| CDN | ADMIN | Create/Read/Update/Delete permission for CDN Service |
| Image | ADMIN | Create/Read/Update/Delete permission for Image Service |
| Push | ADMIN | Create/Read/Update/Delete permission for Push Service |
| SMS | ADMIN | Create/Read/Update/Delete permission for SMS Service |
| Email | ADMIN | Create/Read/Update/Delete permission for Email Service |
| KakaoTalk Bizmessage | ADMIN | Create/Read/Update/Delete permission for KakaoTalk Bizmessage Service |
| Face Recognition | ADMIN | Create/Read/Update/Delete permission for Face Recognition Service |
| AI Fashion |	ADMIN |	Create/Read/Update/Delete permission for AI Fashion Service |
| Document Recognizer | ADMIN | Create/Read/Update/Delete permission for Document Recognizer | 
| Vehicle Plate Recognizer | ADMIN | Create/Read/Update/Delete permission for Vehicle Plate Recognizer | 
| Maps | ADMIN | Create/Read/Update/Delete permission for Maps Service |
| ROLE | ADMIN | Create/Read/Update/Delete permission for ROLE Service |
| API Gateway | ADMIN | Create/Read/Update/Delete permission for API Gateway Service |
| RTCS | ADMIN | Create/Read/Update/Delete permission for RTCS Service |
| ShortURL | ADMIN | Create/Read/Update/Delete permission for ShortURL Service |
| Cheating Detection | ADMIN | Create/Read/Update/Delete permission for Cheating Detection Service |
| IAP | ADMIN | Create/Read/Update/Delete permission for IAP Service |
| Mobile Device Info | ADMIN | Create/Read/Update/Delete permission for Mobile Device Info Service |
| Cloud Search | ADMIN | Create/Read/Update/Delete permission for Cloud Search Service |
| Autocomplete | ADMIN | Create/Read/Update/Delete permission for AutocompleteService |
| Corporation Search | ADMIN | Create/Read/Update/Delete permission for Corporation Search Service |
| Address Search | ADMIN | Create/Read/Update/Delete permission for Address Search Service |
| Log & Crash Search | ADMIN | Create/Read/Update/Delete permission for Log & Crash Search Service |
| Pipeline | ADMIN | Create/Read/Update/Delete permission for Pipeline Service |
| Deploy | ADMIN | Create/Read/Update/Delete permission for Deploy Service |
| Managed | ADMIN | Create/Read/Update/Delete permission for Managed Service |
| Service Monitoring | ADMIN | Create/Read/Update/Delete permission for Service Monitoring Service |
| Certificate Manager | ADMIN | Create/Read/Update/Delete permission for Certificate Manager Service |
| eTax | ADMIN | Create/Read/Update/Delete permission for eTax Service |
| eTax | VIEWER | Read permission for eTax Service |



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
