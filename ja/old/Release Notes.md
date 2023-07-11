## TOAST Cloud > Release Notes
### 2017.09.21 

#### 기능 개선/변경
##### TC Console
* RTCS 신규상품 추가 
    * RTCS 상품이 신규 출시되었습니다. 
    * RTCS 는 쉽고 빠르게 Web, Mobile App, Desktop Application과 같은 다양한 Device를 실시간으로 연결하고, 메시지를 주고 받을수 있게 해주는 서비스 입니다. 
    * 보다 자세한 사항은 <a href="http://docs.cloud.toast.com/ko/Upcoming%20Products/RTCS/ko/Overview/" target="_blank">RTCS Document 페이지</a> 에서 확인 하실 수 있습니다.


### 2017.08.24

#### 기능 개선/변경
##### TC Console
* Infrastructure 요금 테이블 변경
    * Infrastructure 요금제에 Basic 과 Storage Optimized 요금제가 추가되었습니다.
    * 저사양 Basic 과 High IOPS SSD를 제공하는 Storage Optimized 를 제공 받으실 수 있습니다. 
    * u2 (Basic) 요금제는 BETA 서비스 기간으로 SLA가 보장되지 않습니다. 
    * 자세한 사항은 <a href="https://cloud.toast.com/pricing" target="_blank">TOASTCloud Pricing 페이지</a> 및 요금 계산기에서 확인 하실 수 있습니다. 

* Billing Viewer 권한 추가
    * Project 의 Member 권한 중 사용량 페이지를 조회할 수 있는 Viewer 권한이 추가되었습니다. 
    * Billing Viewer 는 Project 내의 모든 행위는 제한 되며, 이용요금 조회만 가능합니다.

* AppGuard 기간 약정 요금제 추가 
    * AppGuard 의 기간 약정제 요금이 추가되었습니다. 
    * Android, iOS 로 분류되며 보다 자세한 사항은 <a href="https://cloud.toast.com/pricing/security" target="_blank">Security Pricing 페이지</a> 에서 조회 하실 수 있습니다. 

* 요금계산기 추가
    * NAS 상품을 비롯한 Fusion I/O Flavor 가 추가되었습니다.
 
#### 버그 수정
##### TC Console 
* 공지사항 버그 수정
    * 공지사항 ALL, FAQ 카테고리 글자가 나타나지 않는 현상이 수정되었습니다. 
     

### 2017.06.22

#### 기능 개선/변경
##### TC Console
* Managed Service Open
    * TOASTCloud 에서는 관리받기 원하는 인스턴스에 대해 Managed Service를 제공합니다. 
    * Managed Basic, Managed Pro에 따라 세분화된 관리 및 설계를 받으 실 수 있습니다. 

* TOASTCloud 약관 내용 변경
    * Managed Service에 따른 이용약관이 변경되었습니다.
    * 보다 자세한 사항은 <a href="https://cloud.toast.com/support/notice/detail/1453435858K00430" target="_blank">TOASTCloud 공지사항</a> 에서 확인 하실 수 있습니다. 

* Maps 상품 카테고리 변경
    * TOASTCloud Maps 상품이 Upcoming Products 에서 <a href="http://docs.cloud.toast.com/ko/Common/Maps/ko/Overview/" target="_blank">Common</a> 카테고리로 변경 되었습니다.
    * Maps는 6개월간 무료로 이용이 가능합니다.  

### 2017.05.25

#### 기능 개선/변경
##### TC Console
* 프로젝트명 길이제한 변경
    * 프로젝트 생성시 20자로 제한된 프로젝트명 길이가 100자로 변경 되었습니다.

* 다국어 지원 
    * TOASTCloud 언어선택 메뉴에 일본어와 중국어가 추가되었습니다.
    * TOASTCloud 공식 홈페이지 GNB 메뉴의 '언어선택란'에서 확인 하실 수 있습니다.

* 프로젝트 생성 개선
    * Console 페이지 프로젝트 리스트에 +프로젝트 생성 기능이 활성화 되었습니다.

* 프로젝트 리스트 노출 개선 
    * 프로젝트 리스트의 노출 순서가 네이밍 기준으로 변경 되었습니다.  

#### 버그 수정

##### TC Console
* 권한 노출버그 수정
    * 프로젝트의 설정 권한이 없는 Member User에게 Setting Icon이 노출되는 버그가 수정 되었습니다. 


### 2017.04.20

#### 기능 개선/변경
##### TC Console
* Email 상품 유료전환
    * Email 상품이 유료로 전환되었습니다.
    * 이에 따라 <a href="http://docs.cloud.toast.com/ko/Notification/E-mail/ko/Overview/" target="_blank">Notification</a> 에서 Email 상품을 만나 보실 수 있습니다. 

* SMS 080 수신거부 요금추가
    * SMS 080 수신거부 (42원/시간) 이용요금이 추가되었습니다.

* Alimtalk 신규상품 추가
    * 친구 추가없이 메시지를 카카오톡 사용자에게 발송할 수 있는 상품이 출시되었습니다.

#### 버그 수정

##### TC Console
* 사업자명 길이초과 버그
    * 사업자 회원가입시 사업자명이 20글자 이상인 경우 생기는 버그가 수정되었습니다.


### 2017.03.23

#### 기능 개선/변경

##### TC Console
* Maps 신규상품 추가
    * 쉽고 정확한 지도, 검색, 길 찾기 서비스 등 다양한 정보를 제공하는 Maps 상품이 출시되었습니다.
* Member 권한 메시지 개선
    * 프로젝트의 Member 권한으로 상품이용 및 종료시 불필요하게 노출되는 안내 팝업이 수정되었습니다.

#### 버그 수정

##### TC Console
* 사업자 계정 담당자명 미노출 수정
     * 사업자 계정의 정보확인 탭란에서, 담당자명이 노출되지 않는 현상이 수정되었습니다.


### 2017.02.23

#### 기능 개선/변경

##### TC Console
* 요금계산기 링크 추가
    * 메인 페이지에만 존재하던 요금계산기 버튼이 Console 페이지 내 상단 GNB 메뉴에 추가되었습니다.  

#### 버그 수정

##### TC Console
* Console 내 메뉴접기 버튼 클릭시 좌우 컨텐츠 리사이징 버그
     * Infrastructure 상품 페이지에서 메뉴접기 버튼 클릭시, 상품 페이지가 늘어나지 않는 현상 수정되었습니다.

### 2017.01.19

#### 기능 개선/변경

##### TC Console
* 요금계산기 입력필드 길이 제한기능 적용
     * 요금계산기의 수량이 무제한 입력되던 방식에서 일정 범위까지만 입력되도록 수정되었습니다.  


#### 버그 수정

##### TC Console
* 휴대폰 아이디로 로그인시 GNB에 로그인 처리가 되지 않는 현상
     * 로그인시 우측 상단에 로그인 정보가 나오지 않는 현상이 수정되었습니다.


### 2016.12.22

#### 기능 개선/변경

##### TC Console
* SMS 정책변경에 따른 문구수정
    * 과금청책 변경에 따른 문구가 발송에서 수신으로 변경되었습니다.
* Health Dashboard 렌딩페이지 적용
    * Toast Cloud 상품들의 서비스 상황을 한눈에 보이도록 표시되는 페이지가 추가되었습니다.
    * 각 상품들마다 세부 에러 히스토리를 제공하며, 장애 발생시 영향받은 상품을 확인 하실수 있습니다.


#### 버그 수정
##### TC Console
* 요금계산기 '계산기 저장' 클릭시 Download 되는 엑셀 내용의 단위가 일부 수정되었습니다.

### 2016.12.08

#### 기능 개선/변경
##### TC Console
* <a href="http://cloud.toast.com/product/calculator" target="_blank">요금계산기</a> 신규 기능 추가되었습니다.
* 상단에 오픈소스 렌딩페이지 추가되었습니다.
