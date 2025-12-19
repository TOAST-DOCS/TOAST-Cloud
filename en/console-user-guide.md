## NHN Cloud > Console User Guide

### Terminology


* Role: A bundle of roles/permissions to use the services and features provided by NHN Cloud
    * The CloudTrail VIEWER role is created with the related role of ORG_DASHBOARD_VIEWER and related permissions such as 'CloudTrail:EventLog.List', 'CloudTrail:ExternalStorageConfig.Get', etc.

![term_1.png](https://static.toastoven.net/prod_architecture_Icon/consoleuserguide_term_01_251124.png)
* Example: The BILLING VIEWER role for a project is created with the related permission of ‘Project.Payment.Get’

![term_2.png](https://static.toastoven.net/prod_architecture_Icon/consoleuserguide_term_02_251124.png)

* Permission: Minimum unit to use NHN Cloud services and features
    * You can bundle permissions to create role groups
    * Service permissions are represented as %ServiceName%:%PermissionName%
    * Example:
        * Project.Payment.Get permission means the feature to view usage details
        * CloudTrail: EventLog.List permission belongs to the 'CloudTrail' service and means the feature to view the event log list
* A bundled unit created by combining roles, related roles/permissions, and permissions
    * Example: Create a role group 'Group A' by adding the project role PROJECT MEMBER ADMIN and the related permission Project.Payment.Get for the project BILLING VIEWER

![term_3.png](https://static.toastoven.net/prod_architecture_Icon/consoleuserguide_term_03_251124.png)

### Organization 

* Policy
    * OWNER/ADMIN/ORG_MEMEBER__ADMIN can create an organization role group by combining roles and permissions provided by NHN Cloud.
    * Organization members can be granted roles from created organization role groups or roles provided by NHN Cloud.

![org_0.png](https://static.toastoven.net/prod_architecture_Icon/consoleuserguide_org_00_251124.png)

* Manage Organization Member
    * Members can be granted role groups and roles.

| Item | Set Conditions |
| --- | ----- |
| Role Group | Unavailable |
| Role | Available |

![org_1.png](https://static.toastoven.net/prod_architecture_Icon/consoleuserguide_org_01_251124.png)

* Example:

![org_2.png](https://static.toastoven.net/prod_architecture_Icon/consoleuserguide_org_02_251124.png)

* When conditions are given as above, User A is granted the following role groups:
    * The BILLING VIEWER role is granted only between 12PM and 2PM on all days of the week, and the CloudTrail VIEWER role is granted only on Tuesdays.
* Manage Organization Role Group
    * Members can be granted role groups and roles.

### Project

* Policy
    * ADMIN/PROJECT MEMBER ADMIN can create a project role group by combining roles and permissions provided by NHN Cloud.
    * Project members can be granted roles from created organization role groups or roles provided by NHN Cloud.

![project_0.png](https://static.toastoven.net/prod_architecture_Icon/consoleuserguide_project_00_251124.png)

* Manage Project Member
    * Members can be granted role groups and roles.

| Item | Set Conditions |
| --- | ----- |
| Role Group | Unavailable |
| Role | Available |


![project_1.png](https://static.toastoven.net/prod_architecture_Icon/consoleuserguide_project_01_251124.png)

   * Example:

![project_2.png](https://static.toastoven.net/prod_architecture_Icon/consoleuserguide_project_02_251124.png)

   * When conditions are given as above, User A is granted the following role groups and roles:
       * User A is granted the ADMIN and BILLING VIEWER roles only on Tuesdays, and the PROJECT SUPPORT ADMIN role only between 12AM and 2PM on all days of the week.

   * Notes
       * Since the condition is set for ADMIN, which is the parent role of BILLING VIEWER, BILLING VIEWER inherits and applies the condition of ADMIN.

* Manage Project Role Group
    * Can assign role groups/roles to member
        * Can set conditions respectively for role groups/roles when assigned.

| Item | Set Deny | Set Conditions |
| --- | ----- | ----- |
| Role | Unavailable | Available |
| Related role | Available | Unavailable<br>If the conditions set in the upper role are applicable, they are inherited and applied |
| Related permission | Available | Unavailable<br>If the conditions set in the upper role are applicable, they are inherited and applied. |
| Permission | Unavailable<br>However, the permission is already denied as the related permission, so it is also denied.| Available |


![project_3.png](https://static.toastoven.net/prod_architecture_Icon/consoleuserguide_project_03_251124.png)

   * Example:

![project_4.png](https://static.toastoven.net/prod_architecture_Icon/consoleuserguide_project_04_251124.png)

   * Members who are granted Role Group A with the conditions as above are granted the following roles:
       * The ADMIN role is granted only on Tuesdays.
       * The PROJECT MEMBER ADMIN role and Project.Product.List permissions inherit the ADMIN role's conditions and are applied accordingly.
       * However, the Project.RoleGroup.Create permission is already denied as the related permission of ADMIN, so it is also denied.
       