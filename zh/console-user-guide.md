## NHN Cloud > Console User Guide

### Terminology

* Role: A bundle of roles/permissions to use the services and features provided by NHN Cloud
    * Example:The BILLING VIEWER role for a project is created with the related permission of ‘Project.Payment.Get’
![term_1.png](http://static.toastoven.net/toast/console_guide/consoleuserguide_term_01_240610.png)
   * The CloudTrail VIEWER role is created with the related role of ORG_DASHBOARD_VIEWER and related permissions such as 'CloudTrail:EventLog.List', 'CloudTrail:ExternalStorageConfig.Get', etc.
![term_2.png](http://static.toastoven.net/toast/console_guide/consoleuserguide_term_02_240610.png)
* Permission: Minimum unit to use NHN Cloud services and features
    * You can bundle permissions to create role groups
    * Service permissions are represented as %ServiceName%:%PermissionName%
    * Example:
        * Project.Payment.Get permission means the feature to view usage details
        * CloudTrail: EventLog.List permission belongs to the 'CloudTrail' service and means the feature to view the event log list
* A bundled unit created by combining roles, related roles/permissions, and permissions
    * Example: Create a role group 'Group A' by adding the project role PROJECT MEMBER ADMIN and the related permission Project.Payment.Get for the project BILLING VIEWER
![term_3.png](http://static.toastoven.net/toast/console_guide/consoleuserguide_term_03_240610.png)

### Organization 

* Policy
    * Members can be assigned roles provided by NHN Cloud.
    * Roles include related roles and permissions.
![org_0.png](http://static.toastoven.net/toast/console_guide/consoleuserguide_org_00_240610.png)
* Manage Organization Member
    * Can assign roles to member
        * Can set conditions for roles when assigned

            | Item | Set Conditions |
            | --- | ----- |
            | Role | Possible |

![org_1.png](http://static.toastoven.net/toast/console_guide/consoleuserguide_org_01_240610.png)
   * Example:
![org_2.png](http://static.toastoven.net/toast/console_guide/consoleuserguide_org_02_240610.png)
   * If the conditions are granted as above, User A will only be granted the CloudTrail VIEWER role on Tuesdays,
the BILLING VIEWER role only from 12:00 to 14:00 on all days of the week.


### Project

* Policy
    * Users can create role groups with any combination of roles and permissions provided by NHN Cloud
    * Users can be granted roles from role groups you create or roles provided by NHN Cloud.
![project_0.png](http://static.toastoven.net/toast/console_guide/consoleuserguide_project_00_240610.png)
* Manage Project Member
    * Can assign role groups/roles to member
        * Can set conditions respectively for role groups/roles when assigned
      
        | Item | Set Conditions |
        | --- | ----- |
        | Role Group | Possible |
        | Role | Possible |
![project_1.png](http://static.toastoven.net/toast/console_guide/consoleuserguide_project_01_240610.png)
   * Example:
![project_2.png](http://static.toastoven.net/toast/console_guide/consoleuserguide_project_02_240610.png)
   * If the conditions are granted as above, User A will be granted the following roles. 
       * User A is granted the PROJECT MEMBER ADMIN and SMS ADMIN roles only on Tuesdays,
and the BILLING VIEWER role is granted only from 12:00 to 14:00 on all days of the week

   * Example:
![project_3.png](http://static.toastoven.net/toast/console_guide/consoleuserguide_project_03_240610.png)
   * If the conditions are given as above, User A will be granted the following roles
       * User A is granted the ADMIN, and SMS ADMIN roles only on Tuesdays, the BILLING VIEWER role is granted only on Tuesdays from 12:00 to 14:00

   * Notes
       * BILLING VIEWER is a related role to ADMIN, so it is granted a role whose conditions are set to the intersection of ADMIN's conditions and BILLING VIEWER's conditions.


* Manage Project Role Group
    * Can assign role groups/roles to member
        * Can set conditions respectively for role groups/roles when assigned

        | Item | Set Deny | Set Conditions |
        | --- | ----- | ----- |
        | Role | Not possible | Possible |
        | Related role | Possible | Role's conditions inherited<br>Separate condition attribute possible, but only if denied |
        | Related permission | Possible | Role's conditions inherited<br>Separate condition attribute possible, but only if denied |
        | Permission |  Not possible| Possible |
![project_4.png](http://static.toastoven.net/toast/console_guide/consoleuserguide_project_041_240610.png)
   * Example:
![project_5.png](http://static.toastoven.net/toast/console_guide/consoleuserguide_project_05_240610.png)
   * User who is granted Group A with the conditions as above are granted the following roles.
       * ADMIN roles except SMS ADMIN and Project.Delete roles/permissions are granted.
       * However, the SMS ADMIN role is only granted on Tuesdays between 12:00 and 14:00, and not at other times