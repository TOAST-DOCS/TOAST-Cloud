## NHN Cloud > 콘솔 사용 가이드

### 용어 정의

* 역할(Role): NHN Cloud에서 제공하는 서비스 및 기능을 이용하기 위한 역할/권한 묶음 단위
    * 예: CloudTrail VIEWER 역할은 ORG_DASHBOARD_VIEWER 연관 역할과 ‘CloudTrail:EventLog.List’, ‘CloudTrail:ExternalStorageConfig.Get’ 등의 연관 권한으로 만들어짐

![term_1.png](http://static.toastoven.net/toast/console_guide/consoleuserguide_term_01_240610.png)

   * 예: 프로젝트 BILLING VIEWER 역할은 ‘Project.Payment.Get’ 연관 권한으로 만들어짐

![term_2.png](http://static.toastoven.net/toast/console_guide/consoleuserguide_term_02_240610.png)

* 권한(Permission): NHN Cloud 서비스와 기능을 이용하기 위한 최소 단위
    * 권한을 묶어서 역할 그룹을 생성할 수 있음
    * 서비스 권한의 경우, %서비스명%:%권한명%으로 나타냄
    * 예:
        * Project.Payment.Get 권한은 이용 현황 상세 조회 기능을 의미함
        * CloudTrail: EventLog.List 권한은 ‘CloudTrail’ 서비스에 속한 권한이며, 이벤트 로그 목록 조회 기능을 의미함
* 역할 그룹(Role Group): 역할, 연관 역할/권한, 권한을 조합해서 생성한 묶음 단위
    * 예: 프로젝트 역할인 PROJECT MEMBER ADMIN과 프로젝트 BILLING VIEWER의 연관 권한인 Project.Payment.Get 권한을 추가하여 역할 그룹 ‘Group A’생성

![term_3.png](http://static.toastoven.net/toast/console_guide/consoleuserguide_term_03_240610.png)

### 조직

* 정책
    * 멤버에게는 NHN Cloud에서 제공하는 역할을 부여할 수 있습니다.
    * 역할은 연관 역할과 연관 권한을 포함하고 있습니다.

![org_0.png](http://static.toastoven.net/toast/console_guide/consoleuserguide_org_00_240610.png)

* 조직 멤버 관리
    * 멤버에게는 역할 부여가 가능
        * 부여 시 역할에 조건 설정 가능

| 항목 | 조건 설정 |
| --- | ----- |
| 역할 | 가능 |

![org_1.png](http://static.toastoven.net/toast/console_guide/consoleuserguide_org_01_240610.png)

   * 예:

![org_2.png](http://static.toastoven.net/toast/console_guide/consoleuserguide_org_02_240610.png)

   * 위와 같이 조건을 부여한 경우 userA는 아래와 같은 역할을 부여받습니다.
       * CloudTrail VIEWER 역할을 화요일에만 부여받으며, BILLING VIEWER 역할은 모든 요일의 12시~14시에만 부여받게 됩니다.

### 프로젝트

* 정책
    * 사용자는 NHN Cloud에서 제공하는 역할과 권한을 조합하여 역할 그룹을 생성할 수 있습니다.
    * 사용자에게는 사용자가 생성한 역할 그룹이나 NHN Cloud에서 제공하는 역할을 부여할 수 있습니다.

![project_0.png](http://static.toastoven.net/toast/console_guide/consoleuserguide_project_00_240610.png)

* 프로젝트 멤버 관리
    * 멤버에게는 역할 그룹/역할 부여가 가능
        * 부여 시 각각 역할 그룹/역할에 조건 설정 가능
      
| 항목 | 조건 설정 |
| --- | ----- |
| 역할 그룹 | 가능 |
| 역할 | 가능 |

![project_1.png](http://static.toastoven.net/toast/console_guide/consoleuserguide_project_01_240610.png)

   * 예:

![project_2.png](http://static.toastoven.net/toast/console_guide/consoleuserguide_project_02_240610.png)

   * 위와 같이 조건을 부여한 경우 userA는 아래와 같은 역할을 부여받습니다.
       * userA는 PROJECT MEMBER ADMIN, SMS ADMIN 역할을 화요일에만 부여받으며, BILLING VIEWER 역할은 모든 요일의 12시~14시에만 부여받게 됩니다.
   * 예:

![project_3.png](http://static.toastoven.net/toast/console_guide/consoleuserguide_project_03_240610.png)

   * 위와 같이 조건을 부여한 경우 userA는 아래와 같은 역할을 부여받습니다.
       * userA는 ADMIN, SMS ADMIN 역할을 화요일에만 부여받으며, BILLING VIEWER 역할은 화요일의 12시~14시에만 부여받습니다.
   * 참고 사항
       * BILLING VIEWER는 ADMIN의 연관 역할이므로 ADMIN의 조건과 BILLING VIEWER 조건의 교집합으로 조건이 설정된 역할을 부여받습니다.

* 프로젝트 역할 그룹 관리
    * 멤버에게는 역할 그룹/역할 부여가 가능
        * 부여 시 각각 역할 그룹/역할에 조건 설정 가능

| 항목 | 거부 설정 | 조건 설정 |
| --- | ----- | ----- |
| 역할 | 불가능 | 가능 |
| 연관 역할 | 가능 | 역할의 조건 상속됨<br>단, 거부 설정한 경우만 별도 조건 속성 가능 |
| 연관 권한 | 가능 | 역할의 조건 상속됨<br>단, 거부 설정한 경우만 별도 조건 속성 가능 |
| 권한 | 불가능 | 가능 |

![project_4.png](http://static.toastoven.net/toast/console_guide/consoleuserguide_project_041_240610.png)

   * 예:

![project_5.png](http://static.toastoven.net/toast/console_guide/consoleuserguide_project_05_240610.png)

   * 위와 같이 조건을 부여한 Group A를 부여받은 멤버는 아래와 같은 역할을 부여받습니다.
       * SMS ADMIN, Project.Delete 역할/권한을 제외한 ADMIN 역할을 부여받습니다.
       * 단, SMS ADMIN 역할은 화요일 중 12시~14시만 부여받지 않고, 이외 시간에는 부여받습니다.
