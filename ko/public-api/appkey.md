# Appkey
**NHN Cloud > Public API > API 인증 방식 > Appkey**

Appkey는 NHN Cloud의 각 서비스별로 발급되는 고유 인증 키로 API 요청 시 서비스 식별과 유효성 검증에 사용됩니다. 인증을 위한 별도의 사용자 등록, 토큰 요청 또는 갱신 절차 없이 API 요청 시 Appkey만 포함하면 되므로 인증 과정이 비교적 간단합니다.

## Appkey 확인하기
Appkey는 서비스별로 발급되며, NHN Cloud 콘솔의 각 서비스 화면에서 확인할 수 있습니다.<br>
이 문서에서는 Instance 서비스의 콘솔 화면을 예시로 사용합니다.

1. NHN Cloud 콘솔의 각 서비스 화면 우측 상단에서 **URL & Appkey**를 클릭합니다.
![C_Appkey_1_ko](http://static.toastoven.net/toast/public_api/C_Appkey_1_ko.png)

2. **URL & Appkey - {서비스명}** 모달 창에서 Appkey를 확인하거나 복사한 뒤 **확인**을 클릭합니다.
![C_Appkey_2_ko](http://static.toastoven.net/toast/public_api/C_Appkey_2_ko.png)

!!! danger "주의"
    Appkey가 유출되었거나 유출이 의심되는 경우 [고객지원 > 문의하기](https://www.nhncloud.com/kr/support/inquiry)에서 **유형**을 **{서비스명}/기타**로 선택하여 Appkey 재발급을 신청하세요.

## SecretKey 확인하기
NHN Cloud의 일부 서비스에서는 API에 대한 접근 제어를 위해 SecretKey(비밀 키)를 지원합니다.<br>
SecretKey는 Appkey와 같이 SecretKey를 지원하는 서비스 화면에서 확인할 수 있습니다.<br>
이 문서에서는 CDN 서비스의 콘솔 화면을 예시로 사용합니다.

1. NHN Cloud 콘솔의 서비스 화면 우측 상단에서 **URL & Appkey**를 클릭합니다.
![C_SecretKey_1_ko](http://static.toastoven.net/toast/public_api/C_SecretKey_1_ko.png)

2. **URL & Appkey - {서비스명}** 모달 창에서 SecretKey를 복사한 뒤 **확인**을 클릭합니다.
![C_SecretKey_2_ko](http://static.toastoven.net/toast/public_api/C_SecretKey_2_ko.png)

## API 요청 방식
### Appkey
API 요청 시 Appkey는 path 파라미터 또는 HTTP 헤더에 포함되며, 서비스에 따라 사용 방식이 달라질 수 있습니다. API 요청 시 사용하는 path 형식 또는 HTTP 헤더 필드 명칭은 해당 서비스의 API 가이드를 참고하세요.

* Path 파라미터 방식<br>
Appkey를 API 요청의 일부로 포함하는 방식입니다.

  * 예시
    ```
    POST /v1.0/appkeys/{appKey}/
    ```

* HTTP 헤더 방식<br>
Appkey를 요청의 헤더에 포함하여 서비스 유효성을 검증하는 방식입니다.

  * 예시
    ```
    X-TC-APP-KEY: {Appkey}
    ```
    
!!! danger "주의"
    Appkey는 유효 기간이 없는 고정 키 기반 인증 방식으로 인가 기능이 없어 키가 외부에 노출될 경우 무단으로 API가 호출될 수 있습니다. 키는 외부 저장소 또는 코드에 포함되지 않도록 안전하게 보관하고, 유출이 의심될 경우 즉시 재발급을 요청해야 합니다. [고객지원 > 문의하기](https://www.nhncloud.com/kr/support/inquiry)에서 **유형**을 **{서비스명}/기타**로 선택하여 Appkey 재발급을 요청할 수 있습니다.

### SecretKey
API 요청 시 SecretKey는 접근 제어를 위해 사용되며, 서비스에 따라 사용 방식이 달라질 수 있습니다. API 요청 시 사용하는 HTTP 헤더 필드 명칭은 해당 서비스의 API 가이드를 참고하세요.

* HTTP 헤더 방식
SecretKey를 요청의 헤더에 포함하여 서비스 유효성을 검증하는 방식입니다.

  * 예시
    ```
    X-SECRET-KEY: {Secretkey}
    ```
