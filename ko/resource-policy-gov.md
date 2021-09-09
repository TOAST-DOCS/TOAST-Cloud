

## 리소스 제공 정책 
모든 고객에게 안정적인 서비스를 제공하고, 의도치 않은 리소스 생성으로 인해 발생할 수 있는 지출 등으로부터 사용자를 보호하기 위해 리소스 제공 정책을 아래와 같이 적용합니다.

### 조직/프로젝트 리소스 제공 정책
조직의 리소스는 결제 수단을 등록한 회원을 기준으로 계산되며, 프로젝트는 조직을 기준으로 계산됩니다.

|리소스 | 제공 기준 | 제공량 | 
|----|----|----|
|조직	| 결제 수단을 등록한 회원당 | 999개 |
|프로젝트	 | 조직당 | 999개 |

### 인프라 서비스 리소스 제공 정책 
리소스 사용량은 프로젝트별로 계산됩니다.

|리소스 | 제공 기준 | 제공량 | 
|----|----|----|
|CPU	| 프로젝트당 |100vCore|
|메모리	 | 프로젝트당 |256GB|
|Block Storage| 프로젝트당 |10TB|
|Floating IP | 프로젝트당 |50개|
|VPC | 프로젝트당 |3개|
|서브넷 | VPC당 |10개|
|라우팅 테이블 | VPC당 |10개|
|라우트 | 라우팅 테이블당 |10개|
|인터넷 게이트웨이 | 프로젝트당	|3개|
|Load Balancer | 프로젝트당 |10개|
|IP 접근 제어 그룹	| 프로젝트당   |10개|
|IP 접근 제어 대상 | IP 접근 제어 그룹당	|1000개|

### DNS Plus 서비스 리소스 제공 정책
리소스 사용량은 프로젝트별로 계산됩니다.

#### DNS
|리소스 | 제공 기준 | 제공량 | 
|----|----|----|
|레코드 세트	| DNS Zone당 |5,000개|

#### GSLB
|리소스 | 제공 기준 | 제공량 | 
|----|----|----|
|GSLB	| 프로젝트당 | 20개|
|Pool	| 프로젝트당 | 20개 |
|Pool   | GSLB당    | 16개 |
|엔드포인트 | 프로젝트당 | 20개 |
|엔드포인트 | Pool당 | 5개 |
|헬스 체크	| 프로젝트당 | 5개 |

### 리소스 제공량 증설 요청  
제공 정책의 사용량 증설을 원하는 경우 고객 센터 [1:1문의](https://gov.toast.com/kr/support/inquiry)로 문의하시면 됩니다. 
요청 시 원하는 항목과 양을 기재하시면 상담이 수월하게 이루어질 수 있습니다. 
요청 후 처리되기까지는 2~5일 정도 소요되므로 실제 필요한 시점보다 미리 신청하시는 것을 권장합니다.