# 프로젝트 통합 Appkey
**NHN Cloud > Public API > API 인증 방식 > 프로젝트 통합 Appkey**

프로젝트 통합 Appkey는 NHN Cloud에서 하나의 프로젝트 내 여러 서비스에 대해 공통으로 사용할 수 있는 인증 키입니다. 각 서비스마다 Appkey를 개별로 관리할 필요 없이 프로젝트 통합 Appkey 하나로 해당 프로젝트에서 사용 중인 모든 서비스의 API를 효율적으로 호출할 수 있습니다. 따라서 관리 대상 키의 수를 줄이고, 사용자가 직접 Appkey를 생성하거나 삭제할 수 있어 키 관리가 유연하고 효율적입니다.

## 프로젝트 통합 Appkey 생성하기
NHN Cloud 콘솔의 각 프로젝트 화면에서 프로젝트 통합 Appkey를 생성하고 관리할 수 있습니다.

1) NHN Cloud 콘솔에서 프로젝트를 선택한 뒤 **프로젝트 관리** 탭을 클릭합니다.

2) **API 보안 설정**에서 **+ Appkey 생성**을 클릭합니다.<br>
![C_project_API_security_ko](http://static.toastoven.net/toast/public_api/C_project_API_security_ko.png)

3) **Appkey 생성** 모달 창에서 **Appkey 이름** 입력 필드에 생성할 프로젝트 통합 Appkey의 이름을 입력한 뒤 **확인**을 클릭합니다.<br>
![C_project_API_security_2_ko](http://static.toastoven.net/toast/public_api/C_project_API_security_2_ko.png)


!!! danger "주의"
    프로젝트 통합 Appkey가 외부에 노출될 경우 해당 프로젝트 내 모든 서비스 API가 무단 호출될 수 있으므로 보안 관리에 각별한 주의가 필요합니다. 프로젝트 통합 Appkey를 외부 저장소 또는 코드에 포함하지 않도록 안전하게 보관하고, 유출되었거나 유출이 의심되는 경우 기존 Appkey를 삭제한 뒤 새로운 Appkey를 생성해 교체하세요.


!!! tip "알아두기"
    * 프로젝트 통합 Appkey가 모든 Public API에서 지원되지는 않습니다. 동일한 X-TC-APP-KEY 헤더를 사용하더라도 일부 API는 서비스별 Appkey만 지원하므로 프로젝트 통합 Appkey는 적용되지 않을 수 있습니다. 해당 API의 가이드를 통해 지원 여부를 확인하세요.
    * 프로젝트 통합 Appkey는 프로젝트당 최대 3개까지 생성할 수 있습니다.


## API 호출하기
프로젝트 통합 Appkey는 HTTP 요청 헤더에 포함해 전달합니다. API 호출 시 아래 예시와 같이 요청 헤더에 프로젝트 통합 Appkey를 설정해 호출하세요.

* HTTP 헤더 형식 예시
  ```
  X-TC-APP-KEY: {프로젝트 통합 Appkey}
  ```

사용자가 HTTP 헤더에 키를 담아 서버에 요청을 보내면 서버는 해당 키의 유효성을 확인한 뒤 요청을 승인하거나 거부합니다.



