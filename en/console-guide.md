## TOAST > Console User Guide

The console serves as management tool and window for the use of TOAST services.
Basic console settings and its user guide are provided as below to use TOAST Service.

TOAST Console provides the following functions:

- Basic information management to use the service (e.g. organizations, or projects)
- Enable/Disable Service
- Manage members who use the service
- Provide payment information

## Organization Management

Organization refers to a group which is made to efficiently use and manage TOAST Service.
In an organization, same service policy can be shared with users.
It helps to make use of TOAST Service more efficiently.  

### Organization Management Policy

#### Create Organizations

- An organization should be created to use TOAST Service.
- Both personal and business members can create organizations.
- Any member who creates an organization automatically becomes the OWNER of his organization.
- Member’s payment method is required to create an organization.
- Organization is in charge of its name and domain information.
- Domain information of an organization must be unique, as it is required for services.

#### Organization Services

After an organization is created, you can select services.
Following services are available at the level of organization:

- ERP
- Dooray!
- Contact Center
- IDC

#### Organization Members

Organization members are classified into members of TOAST.com and insider members of the organization.  

| Classification                | TOAST.com Members                                            | Insider Members of Organization (same as IAM of AWS)         |
| :---------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| Definition                    | \- Members for organization management <br>\- TOAST members who consent to Terms of Use and hence are responsible and obligated for the service use <br>\- The members are valid throughout the whole TOAST Service and remain as TOAST members even if their organizations are deleted. | \- Members for the service use <br>\- Members who do not consent to the Terms of Use <br>\- Members who are valid only within their organizations, and to be disqualified if their organizations are deleted |
| Method of Member Registration | \- Owner/Admin of an organization enters TOAST ID for registration | \- Owner/Admin of an organization enters unique ID for registration <br>\- Register via SSO or API interfaces |
| Member Authority              | \- Actions to manage organizations \(Create/Modify Organizations / Manage Organization Members / Manage Organization Services /Manage Payment \)<br>\- Create Projects<br>\- Delete Projects | \- Use Organization Services                                 |

Each member of an organization has following roles:

| Action               | Role                                              | Owner | Admin | Member | Billing Viewer | Log Viewer |
| -------------------- | ------------------------------------------------- | ----- | ----- | ------ | -------------- | ---------- |
| Manage Organizations | Create Organizations                              | O     |       |        |                |            |
|                      | Modify Organizations                              | O     | O     |        |                |            |
|                      | Delete Organizations                              | O     |       |        |                |            |
| Manage Members       | Register Organization Members                     | O     | O     |        |                |            |
|                      | Delete Organization Members                       | O     | O     |        |                |            |
| Manage Services      | Enable Organization Services                      | O     | O     |        |                |            |
|                      | Disable Organization Services                     | O     | O     |        |                |            |
| Manage Payment       | Query Bills                                       | O     |       |        |                |            |
|                      | Status of Service Use                             | O     | O     |        | O              |            |
| Manage Projects      | Create Projects                                   | O     | O     | O      |                |            |
|                      | Delete Projects (all projects of an organization) | O     | O     |        |                |            |
|                      | Delete Projects (created projects)                | O     | O     | O      |                |            |
| 사용자 Action 로그 관리  | 사용자 Action 로그 조회                               | O     | O     |        |                | O          |

#### Delete Organizations

- Only the OWNER can delete his organization.
- All the services currently in use must be deleted first.
- All information of an organization is to be deleted, along with the deletion of organization, and cannot be recovered.  

### Guide to Create Organizations

![consoleguide_06_en.png](http://static.toastoven.net/toast/console_guide/consoleguide_06_201812_en.png)

1. Access the console and click **+** next to the **Create an organization** message in the menu on top.
2. On the popup window of **Create Organizations**, enter the name of an organization: all are available including Korean, English, special characters and numbers.
3. Click **OK** and organization is completely created.
4. You can find the organization name just created on top of the console menu
5. Click **Setting** to check information of the created organization. Enter domain information as additional information of the organization: domain must be unique in TOAST.

### Security Setting for IAM Console Logins 
To tighten console access security for IAM members, [Login Security Setting] is provided.  

Same configuration may be applied to all organizations (e.g. Cloud console, Online Contact, or Dooray!), or each service may be diffferently configured. 

![iam_console_login_security_setting_guide_1_ko.png](http://static.toastoven.net/toast/console_guide/consoleguide_09_201903_en.png)

1. Access Organization Setting of an organization to configure on a console. 
2. Click [Login Security Setting] on the IAM console. 

#### Two-factor Authentication 

The two-factor authentication can be made a required setting.    

![iam_console_login_security_setting_guide_2_ko.png](http://static.toastoven.net/toast/console_guide/consoleguide_10_201903_en.png)
- Not Configured: Login is available only by ID and password, without two-factor authentication.  
- Google OTP:  Enter ID and password, and enter One Time Password provided by Google OTP, to authenticate and log in. 
- Email: Enter ID and password, and click an authentication button delivered via email address, to authenticate and log in. 

#### Security for Failed Logins 

When it fails to log in for many consecutive times, you are allowed to log in after certain time. 

Security setting for failed logins can be differently applied for each service. 
Only common settings are provided. 

![iam_console_login_security_setting_guide_3_ko.png](http://static.toastoven.net/toast/console_guide/consoleguide_11_201903_en.png)
- Not Configured: Login can be attempted forever even after it fails for many times. 
- Configured: Enter the number of failure and lock timeout,  and you cannot attempt to log in during such lock timeout if you fail to log in as many as the number. 

#### IP ACL 

Access to IAM console is available only in allowed IPs (or IP bandwidth)

![iam_console_login_security_setting_guide_4_ko.png](http://static.toastoven.net/toast/console_guide/consoleguide_12_201903_en.png)
- Not Configured: Access to IAM console is available in all IPs (or IP bandwidth) 
- Console Access for Allowed IPs (or IP bandwidth) Only: Access to console is available only in allowed IPs (or IP bandwidth): enter IPs or IP bandwidth to allow access for.  

## Manage Projects

A project is created to use TOAST Service, after an organization is created.
Enable project services to use a project.
Use and charge services by the project.

### Project Management Policy

#### Create Projects

- To create a project, an organization is required.
- A member who creates a project is entitled ADMIN of the project.
- Enter the name and description to create a project.
- Enable project services after a project is created.
- When collaboration is required, add project members to share the project after it is created.

#### Project Services

You can select services, once a project is created.
Following services can be enabled by each project:

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

#### Project Members

Project members are also members of TOAST.com. Insider members of an organization will be able to use project services with further functions to be provided.
You can be a project member, if not an organization member.

Each project member has the following roles:

| Action                | Role                                            | ADMIN | MEMBER | Billing Viewer ADMIN | Billing Viewer |
| --------------------- | ----------------------------------------------- | ----- | ------ | -------------------- | -------------- |
| Manage Members        | Register Project Members (ADMIN)                | O     |        |                      |                |
|                       | Delete Project Members (ADMIN)                  | O     |        |                      |                |
|                       | Register Project Members (MEMBER)               | O     |        |                      |                |
|                       | Delete Project Members (MEMBER)                 | O     |        |                      |                |
|                       | Register Project Members (Billing Viewer ADMIN) | O     |        |                      |                |
|                       | Delete Project Members (Billing Viewer ADMIN)   | O     |        |                      |                |
|                       | Register Project Members (Billing Viewer)       | O     |        | O                    |                |
|                       | Delete Project Members (Billing Viewer)         | O     |        | O                    |                |
| Manage Service        | Enable Service                                  | O     |        |                      |                |
|                       | Enable Service                                  | O     | O      |                      |                |
|                       | Disable Service                                 | O     |        |                      |                |
| Status of Service Use | Status of Service Use                           | O     | O      | O                    | O              |

#### Delete Projects

A project can be deleted if it has no available services.
All its resources are deleted along with the deletion of a project, and cannot be recovered.
You can immediately pay for all the resources that have used before deleting a project.
However, if it is deleted without paid, all charges up to the moment shall be automatically billed on the next payment date.

### Guide to Create Projects

![consoleguide_07_en.png](http://static.toastoven.net/toast/console_guide/consoleguide_07_201812_en.png)

1. After an organization is created, **Create New Project** button is enabled: click the button to create a project.
2. Enter **Project Name** and **Project Description**.
3. Click **OK** to create a project.
4. The project name shows on the console menu when the project is created.
5. Click project setting to check project information.

### Guide to Enable Project Service

![consoleguide_08_en.png](http://static.toastoven.net/toast/console_guide/consoleguide_08_201812_en.png)

1. Click **Select Services**, after a project is created, to enable services you need
2. Select services on the page of Select Services. When a message asking for Enable Service shows, click **OK**. When a message guiding to go to the service page, click **OK**.
3. Check the list of enabled services on the left of the console. Click the service you want and the service page will show.

## Billing Management

Supports for TOAST members to check prices and pay bills for TOAST Service.
Billing management provides bills for the TOAST members who registered payment methods, along with estimated amount of payment and usage information.
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
