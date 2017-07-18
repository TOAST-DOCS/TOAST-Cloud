## TOAST Cloud Getting Started

TOAST Cloud 웹 페이지는 [표 1]과 같이 **Dev Center, Console 2가지**가 있습니다.

|이름|접속주소|설명|
|---|---|---|
|Dev Center|http://cloud.toast.com|상품, 가격정책 소개, 개발자 지원<br/>(기술문서, FAQ, 1:1 문의)|
|Console|http://console.cloud.toast.com|프로젝트 생성/삭제, 사용정보, 상품 사용, 빌링 정보, 계정 관리 기능 제공|

[표1 TOAST Cloud 제공 웹 페이지]

## 상품정보

Dev Center는 상품 정보를 제공합니다. 상품 정보 외에 개발자 문서, 포럼, FAQ도 볼 수 있습니다. Console에서는 간단하고 직관적인 사용자 인터페이스를 통해 TOAST Cloud 프로젝트, 상품, 빌링 정보 등 모든 리소스를 관리 할 수 있습니다. Console에서 할 수 있는 주요 기능은 다음과 같습니다.
<br>

|종류|관리|
|--|--|
|<br>프로젝트|1. 프로젝트 관리<br> 2. 결제 관리<br> 3. 멤버 관리<br> 4. 인증 관리|
|상품|상품 이용/종료|
|빌링|요금 및 이용내역|
|<br>관리|1. 개인 정보 수정<br> 2. 결제 카드 등록<br> 3. 통합 Appkey 관리|

<br>
## Console 주요기능 및 사용 방법

이 문서에서는 Console에서의 주요 기능의 구체적인 사용 방법에 대하여 알아보겠습니다.

### Console 접속

Console에 접속하는 방법은 다음과 같이 2가지입니다.

|종류|방법|
|---|---|
|**Dev Center 경우**|http://cloud.toast.com 접속 > [Console] 선택|
|**Console 직접 접속**|http://console.cloud.toast.com 접속|

[표2 Console 접속 방법]

Console 메인 페이지로 접속한 후 [Login] 버튼을 클릭하여 로그인을 합니다. TOAST 아이디가 없는 경우 회원가입 후 접속해 주십시오.

![그림 1 TOAST Cloud 로그인 화면](http://static.toastoven.net/toastcloud/static/common/img/cms_img/wconsole/img_paycoadd.png)
<center>[그림 1 TOAST Cloud 로그인 화면]</center>

### 프로젝트 생성

프로젝트 단위로 서비스를 구성할 수 있습니다. 새 프로젝트를 생성하면 생성자에게 자동으로 admin 권한이 부여되고 외부 멤버 초대를 할 수 있습니다.

 > [참고]
 > 프로젝트 멤버 추가 방법은 [프로젝트 멤버 관리] 설명을 참고해 주십시오.

처음 Console에 접속하는 경우 그림과 같은 "Hello world" 프로젝트가 생성되어 있습니다.
새로운 프로젝트를 원하실 경우 [프로젝트 생성] 버튼 클릭 후 입력창에 원하시는 "프로젝트명"을 입력하고 [새 프로젝트 생성] 버튼을 클릭합니다.

![그림 2 새 프로젝트 생성](http://static.toastoven.net/toastcloud/static/common/img/cms_img/wconsole/img_projectenable.png)
<center>[그림 2 새 프로젝트 생성]</center>

프로젝트 생성 완료 후에는 그림 3과 같이 프로젝트 리스트가 나옵니다. admin 권한을 부여 받은 프로젝트인 경우에는 [수정], [삭제] 버튼이 보입니다.

![그림 3 프로젝트 리스트](http://static.toastoven.net/toastcloud/static/common/img/cms_img/wconsole/img_hello.png)
<center>[그림 3 프로젝트 리스트]</center>

[프로젝트이름]을 클릭하면 그림 4와 같이 프로젝트 상품 이용 내역이 나옵니다.

![그림 4 프로젝트 상품 이용 내역](http://static.toastoven.net/toastcloud/static/common/img/cms_img/wconsole/img_helloproject.png)
<center>[그림 4 프로젝트 상품 이용 내역]</center>

### 프로젝트 삭제

프로젝트를 삭제하고자 하는 경우 기존의 이용 중인 모든 상품을 “이용 종료” 시켜야 하며, 프로젝트 삭제 전에 [그림 5]와 같이 전체 상품 상태가 “이용중”이 아닌지 확인합니다. 프로젝트 모든 상품이 비활성화 되어 있으면, 프로젝트명 옆의 [삭제]버튼을 클릭하여 삭제를 수행합니다.

![그림 5 프로젝트 상품 비활상화 상태 확인](http://static.toastoven.net/toastcloud/static/common/img/cms_img/wconsole/img_hellostatus.png)
<center>[그림 5 프로젝트 상품 비활상화 상태 확인]</center>

### 상품 이용내역

처음 프로젝트를 생성하면 다음과 같이 상품이용 내역이 나옵니다. 모든 상품은 이용하기 전 상태임을 알 수 있습니다.

![](http://static.toastoven.net/toastcloud/static/common/img/cms_img/wconsole/img_status.png)

### 상품 활성화

각 상품별 페이지로 들어가면 간략한 상품 소개 화면이 나옵니다. [상품이용] 버튼을 클릭하면 상품 관리화면으로 전환됩니다.

![그림 6 상품 활성화](http://static.toastoven.net/toastcloud/static/common/img/cms_img/wconsole/img_enable.png)
<center>[그림 6 상품 활성화]</center>

> 참고
> 각 상품별 사용법은 [TOAST Cloud > DOCUMENTS]를 참고해 주십시오.

## 프로젝트 멤버 관리

### 프로젝트 멤버 추가

프로젝트 생성자는 admin권한을 가지고 있으며 프로젝트 편집/삭제, 멤버 초대/삭제를 할 수 있습니다.
프로젝트 멤버 추가는 다음과 같이 합니다.

- [Home] > [프로젝트명] > [setting] > [멤버 관리] 탭 클릭
- [멤버 추가] 버튼 클릭
- 초대할 멤버의 이메일 아이디 입력
- 권한을 Admin, Member 중에서 선택
- [확인] 버튼 클릭

![그림 7 프로젝트 멤버 수정](http://static.toastoven.net/toastcloud/static/common/img/cms_img/wconsole/img_memberadd2.png)
<center>[그림 7 프로젝트 멤버 수정]</center>

![그림 8 프로젝트 멤버 추가](http://static.toastoven.net/toastcloud/static/common/img/cms_img/wconsole/img_memberadd1.png)
<center>[그림 8 프로젝트 멤버 추가]</center>

[확인] 버튼 클릭을 클릭하면 프로젝트에 권한 추가가 완료 됩니다. 추가한 사용자 아이디로 로그인하면 권한을 부여받은 프로젝트를 리스트에서 확인할 수 있습니다.

### 프로젝트 권한

프로젝트 Admin/Member별 권한 내역은 다음과 같습니다.

|이름|기능|Admin|Member|
|---|---|---|---|
|Project|추가|O|View|
||삭제|O|View|
|Member|추가|O|X|
||삭제|O|X|
|Product|추가|O|View|
||삭제|O|View|
||설정변경|O|O|
|Billing|결제|O|X|

[표 2 공용 프로젝트 admin/멤버 권한]

|이름|Admin|Member|
|---|---|---|
|Infrastructure(Network 제외)|Edit|Edit|
|Infrastructure(Network)|Edit|View|
|Game Analytics|Edit|Edit|
|Log & Crash Search|Edit|Edit|
|Leaderboard|Edit|Edit|
|Launching|Edit|Edit|
|IAP|Edit|Edit|
|Mobile Test|Edit|Edit|

[표 3 상품 프로젝트 admin/멤버 권한]

## 프로젝트 결제 관리

### 프로젝트 결제 수단 추가

프로젝트 생성 후 [결제 관리] 탭에서 결제수단을 등록 하실 수 있습니다.
결제수단 등록 절차는 다음과 같습니다.

- [Home] > [프로젝트명] > [setting] > [결제 관리] 탭 클릭
- [결제수단 추가] 버튼 클릭
- 결제수단 등록

![그림 9 결제수단 관리](http://static.toastoven.net/toastcloud/static/common/img/cms_img/wconsole/img_creditadd1.png)
<center>[그림 9 결제수단 관리]</center>

## 프로젝트 통합 Appkey 관리

### 프로젝트 통합 Appkey 추가

> 통합 Appkey 란? <br>
> 상품 사용시 각각 상품 고유의 Appkey 가 발급됩니다.
> 다른상품 사용시 Appkey 의 관리를 효율적으로 하기 위해 Alias 형태의 "통합 Appkey" 를 지원합니다.

통합 Appkey 등록 절차는 다음과 같습니다.
- [Home] > [프로젝트명] > [setting] > [인증 관리] 탭 클릭
- [+ Appkey 생성] 버튼 클릭
- 통합 Appkey 등록

![그림 10 인증 관리](http://static.toastoven.net/toastcloud/static/common/img/cms_img/wconsole/img_appkey.png)
<center>[그림 10 인증 관리]</center>

## 맺음말

지금까지 다음과 같은 내용을 알아보았습니다.

 - Console 접속
 - 프로젝트 생성/삭제
 - 상품 이용내역 보기/활성화 하기
 - 프로젝트 멤버 추가하기
 - 결제수단 등록
 - 통합 인증관리
