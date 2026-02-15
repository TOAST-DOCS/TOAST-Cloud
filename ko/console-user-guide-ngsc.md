## NHN Cloud > 콘솔 사용 가이드

### 용어 정의


* 역할(Role): NHN Cloud에서 제공하는 서비스 및 기능을 이용하기 위한 역할/권한 묶음 단위
    * 예: CloudTrail VIEWER 역할은 ORG_DASHBOARD_VIEWER 연관 역할과 ‘CloudTrail:EventLog.List’, ‘CloudTrail:ExternalStorageConfig.Get’ 등의 연관 권한으로 만들어짐

![term_1.png](https://static.toastoven.net/prod_architecture_Icon/consoleuserguide_term_01_251124.png)

   * 예: 프로젝트 BILLING VIEWER 역할은 ‘Project.Payment.Get’ 연관 권한으로 만들어짐

![term_2.png](https://static.toastoven.net/prod_architecture_Icon/consoleuserguide_term_02_251124.png)

* 권한(Permission): NHN Cloud 서비스와 기능을 이용하기 위한 최소 단위
    * 권한을 묶어서 역할 그룹을 생성할 수 있음
    * 서비스 권한의 경우, %서비스명%:%권한명%으로 나타냄
    * 예:
        * Project.Payment.Get 권한은 이용 현황 상세 조회 기능을 의미함
        * CloudTrail: EventLog.List 권한은 ‘CloudTrail’ 서비스에 속한 권한이며, 이벤트 로그 목록 조회 기능을 의미함
* 역할 그룹(Role Group): 역할, 연관 역할/권한, 권한을 조합해서 생성한 묶음 단위
    * 예: 프로젝트 역할인 PROJECT MEMBER ADMIN과 프로젝트 BILLING VIEWER의 연관 권한인 Project.Payment.Get 권한을 추가하여 역할 그룹 ‘Group A’생성

![term_3.png](https://static.toastoven.net/prod_architecture_Icon/consoleuserguide_term_03_251124.png)

### 조직

* 정책
    * OWNER/ADMIN/ORG_MEMBER_ADMIN 역할은 NHN Cloud에서 제공하는 역할과 권한을 조합하여 조직 역할 그룹을 생성할 수 있습니다.
    * 조직 멤버에게는 생성된 조직 역할 그룹이나 NHN Cloud에서 제공하는 역할을 부여할 수 있습니다.

![org_0.png](https://static.toastoven.net/prod_architecture_Icon/consoleuserguide_org_00_251124.png)

* 조직 멤버 관리
    * 멤버에게는 역할 그룹과 역할 부여가 가능합니다.

| 항목 | 조건 설정 |
| --- | ----- |
| 역할 그룹 | 불가능 |
| 역할 | 가능 |

![org_1.png](https://static.toastoven.net/prod_architecture_Icon/consoleuserguide_org_01_251124.png)

   * 예:

![org_2.png](https://static.toastoven.net/prod_architecture_Icon/consoleuserguide_org_02_251124.png)

   * 위와 같이 조건을 부여한 경우 User A는 아래와 같은 역할 그룹을 부여받습니다.
       * BILLING VIEWER 역할은 모든 요일의 12시~14시에만 부여받으며, CloudTrail VIEWER 역할은 화요일에만 부여받게 됩니다.

* 조직 역할 그룹 관리
    * 멤버에게는 역할 그룹과 역할 부여가 가능합니다.

### 프로젝트

* 정책
    * ADMIN/PROJECT MEMBER ADMIN 역할은 NHN Cloud에서 제공하는 역할과 권한을 조합하여 프로젝트 역할 그룹을 생성할 수 있습니다.
    * 프로젝트 멤버에게는 생성된 프로젝트 역할 그룹이나 NHN Cloud에서 제공하는 역할을 부여할 수 있습니다.

![project_0.png](https://static.toastoven.net/prod_architecture_Icon/consoleuserguide_project_00_251124.png)

* 프로젝트 멤버 관리
    * 멤버에게는 역할 그룹과 역할 부여가 가능합니다.
      
| 항목 | 조건 설정 |
| --- | ----- |
| 역할 그룹 | 불가능 |
| 역할 | 가능 |

![project_1.png](https://static.toastoven.net/prod_architecture_Icon/consoleuserguide_project_01_251124.png)

   * 예:

![project_2.png](https://static.toastoven.net/prod_architecture_Icon/consoleuserguide_project_02_251124.png)

   * 위와 같이 조건을 부여한 경우 User A는 아래와 같은 역할 그룹과 역할을 부여받습니다.
       * User A는 ADMIN, BILLING VIEWER 역할을 화요일에만 부여받으며, PROJECT SUPPORT ADMIN 역할은 모든 요일의 12시~14시에만 부여받습니다.
   * 참고 사항
       * BILLING VIEWER의 상위 역할인 ADMIN에 조건이 설정되었으므로 BILLING VIEWER는 ADMIN의 조건을 상속받아 적용됩니다.

* 프로젝트 역할 그룹 관리
    * 멤버에게는 역할 그룹과 역할 부여가 가능합니다.

| 항목 | 거부 설정 | 조건 설정 |
| --- | ----- | ----- |
| 역할 | 불가능 | 가능 |
| 연관 역할 | 가능 | 불가능<br>상위 역할에 설정된 조건이 적용 가능한 조건일 경우 상속되어 적용 |
| 연관 권한 | 가능 | 불가능<br>상위 역할에 설정된 조건이 적용 가능한 조건일 경우 상속되어 적용  |
| 권한 | 불가능<br>단, 해당 권한이 연관 권한으로 거부 설정되어 있는 경우 동일하게 거부 처리 | 가능 |

![project_3.png](https://static.toastoven.net/prod_architecture_Icon/consoleuserguide_project_03_251124.png)

   * 예:

![project_4.png](https://static.toastoven.net/prod_architecture_Icon/consoleuserguide_project_04_251124.png)

   * 위와 같이 조건을 부여한 Role Group A를 부여받은 멤버는 아래와 같은 역할을 부여받습니다.
       * ADMIN 역할은 화요일에만 부여받습니다.
       * PROJECT MEMBER ADMIN 역할, Project.Product.List 권한은 ADMIN의 조건을 상속받아 적용됩니다.
       * 단, Project.RoleGroup.Create 권한은 ADMIN의 연관 권한으로 이미 거부 설정되어 있기 때문에 동일하게 거부 처리됩니다.
