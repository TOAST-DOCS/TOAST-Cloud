# User Access Key

**NHN Cloud > Public API > API 인증 방식 > User Access Key**

User Access Key는 NHN Cloud 계정 또는 IAM 계정을 기반으로 발급되는 인증 키로, Secret Access Key와 함께 사용하여 API 요청에 대한 인증 수단으로 활용됩니다. API 요청 시 사용자 단위로 접근 권한을 인증할 수 있으며, 사용자별 세밀한 권한 제어가 가능합니다. 인증된 NHN Cloud 계정 또는 IAM 계정에 부여된 역할 및 권한에 따라 API 호출이 제한되지만, API 버전에 따라 인가 기능이 적용되지 않을 수도 있습니다.


!!! danger "주의"
    * Use Access Key와 Secret Access Key는 유효 기간이 없는 고정 키 기반 인증 방식으로 키가 외부에 노출될 경우 해당 계정의 역할 및 권한 범위 내 모든 API가 무단 호출될 수 있습니다.
    * 키는 외부 저장소 또는 코드에 포함되지 않도록 안전하게 보관하고, 유출이 의심될 경우 즉시 폐기하고 재발급해야 합니다.


## User Access Key 발급하기
NHN Cloud에서 제공하는 API를 사용하려면 User Access Key를 발급해야 합니다. User Access Key는 NHN Cloud 콘솔의 **API 보안 설정**에서 발급할 수 있습니다.

1) NHN Cloud 콘솔에서 우측 상단의 계정에 마우스 포인터를 올리면 표시되는 드롭다운 메뉴에서 **API 보안 설정**을 클릭합니다.

2) **+ User Access Key 생성**을 클릭합니다.<br>
![C_userAccessKey_1_ko](http://static.toastoven.net/toast/public_api/C_userAccessKey_1_ko.png)

3) **User Access Key 생성** 모달 창에서 **토큰 유효 시간**을 설정한 뒤 **생성**을 클릭합니다.<br>
![C_userAccessKey_2_ko](http://static.toastoven.net/toast/public_api/C_userAccessKey_2_ko.png)

4) **User Access Key 발급 완료** 모달 창에서 **Secret Access Key**를 복사한 뒤 **확인**을 클릭합니다.<br>
![C_userAccessKey_3_ko](http://static.toastoven.net/toast/public_api/C_userAccessKey_3_ko.png)


!!! danger "주의"
    * 모달 창을 닫은 뒤에는 Secret Access Key를 다시 확인할 수 없습니다. Secret Access Key를 잊어버릴 경우 재생성해야 하므로 반드시 복사한 뒤 별도로 관리하세요.
    * User Access Key 또는 Secret Access Key 중 하나라도 유출되었거나 유출이 의심되는 경우 해당 키를 폐기하고 새로 발급 받아야 합니다.


!!! tip "알아두기"
    * User Access Key는 NHN Cloud 계정과 IAM 계정당 각각 5개까지 발급할 수 있습니다.
    * User Access Key ID는 90일마다 변경할 것을 권장합니다.


## API 호출하기
User Access Key는 HTTP 요청 헤더에 포함하여 전달합니다. API 호출 시 아래 예시와 같이 헤더에 User Access Key를 설정해 호출하세요.


* HTTP 헤더 형식 예시
```
X-TC-AUTHENTICATION-ID: {User Access Key}
X-TC-AUTHENTICATION-SECRET: {Secret Access Key}
```


사용자가 HTTP 헤더에 키를 담아 서버에 요청을 보내면 서버는 해당 키의 유효성 및 권한을 확인한 뒤 요청을 승인하거나 거부합니다.


