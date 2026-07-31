<!-- pre-align:aligned sig=9516cb1f41d0 -->

<a id="nhn-cloud-nhn-cloud-resource-provision-policy"></a>
## NHN Cloud > 리소스 제공 정책 { #nhn-cloud-nhn-cloud-resource-provision-policy }
NHN Cloud는 모든 고객에게 안정적인 서비스를 제공하고, 의도치 않은 리소스 생성으로 인해 발생할 수 있는 지출 등으로부터 사용자를 보호하기 위해 리소스 제공 정책을 아래와 같이 적용합니다.

<a id="resource-provision-policy-for-organizationproject"></a>
### 조직/프로젝트 리소스 제공 정책 { #resource-provision-policy-for-organizationproject }
조직의 리소스는 결제 수단을 등록한 회원을 기준으로 계산되며, 프로젝트는 조직을 기준으로 계산됩니다.

|리소스 | 회원 유형 | 제공 기준 | 제공량 | 
|----|----|----|----|
|조직	| 개인 | 결제 수단을 등록한 회원당 |3개|
|	| 사업자 | 결제 수단을 등록한 회원당 |5개|
|프로젝트	 | 개인 | 조직당 |5개|
|	 | 사업자 | 조직당 |10개|

<a id="resource-provision-policy-for-instance-service"></a>
### Instance 서비스 리소스 제공 정책 { #resource-provision-policy-for-instance-service }
리소스 사용량은 프로젝트별로 계산되며, 리전별로 구분하여 정책이 적용됩니다. 

|리소스 | 제공 기준 | 기본 제공량 | 조정 가능 여부 | 최대 제공량 |
|----|----|----|----|----|
|CPU	| 프로젝트당 |100vCore| O | |
|메모리	 | 프로젝트당 |262,144MB| O | |


<a id="resource-provision-policy-for-block-storage-service"></a>
### Block Storage 서비스 리소스 제공 정책 { #resource-provision-policy-for-block-storage-service }
리소스 사용량은 프로젝트별로 계산되며, 리전별로 구분하여 정책이 적용됩니다. 

|리소스 | 제공 기준 | 기본 제공량 | 조정 가능 여부 | 최대 제공량 |
|----|----|----|----|----|
|블록 스토리지| 프로젝트당 |10240GB| O | |
|블록 스토리지 HDD 타입 최대 크기| 블록 스토리지당 |2048GB| O | |
|블록 스토리지 SSD 타입 최대 크기| 블록 스토리지당 |2048GB| O | |
|블록 스토리지 Encrypted HDD 타입 최대 크기| 블록 스토리지당 |2048GB| O | |
|블록 스토리지 Encrypted SSD 타입 최대 크기| 블록 스토리지당 |2048GB| O | |
|블록 스토리지 당 스냅숏| 블록 스토리지당 |3개| X | |

<a id="resource-provision-policy-for-floating-ip-service"></a>
### Floating IP 서비스 리소스 제공 정책 { #resource-provision-policy-for-floating-ip-service }
리소스 사용량은 프로젝트별로 계산되며, 리전별로 구분하여 정책이 적용됩니다. 

|리소스 | 제공 기준 | 기본 제공량 | 조정 가능 여부 | 최대 제공량 |
|----|----|----|----|----|
|플로팅 IP | 프로젝트당 |50개| O | |

<a id="resource-provision-policy-for-vpc-service"></a>
### VPC 서비스 리소스 제공 정책 { #resource-provision-policy-for-vpc-service }
리소스 사용량은 프로젝트별로 계산되며, 리전별로 구분하여 정책이 적용됩니다. 

|리소스 | 제공 기준 | 기본 제공량 | 조정 가능 여부 | 최대 제공량 |
|----|----|----|----|----|
|VPC | 프로젝트당 |3개| O | |

<a id="resource-provision-policy-for-subnet-service"></a>
### Subnet 서비스 리소스 제공 정책 { #resource-provision-policy-for-subnet-service }
리소스 사용량은 프로젝트별로 계산되며, 리전별로 구분하여 정책이 적용됩니다. 

|리소스 | 제공 기준 | 기본 제공량 | 조정 가능 여부 | 최대 제공량 |
|----|----|----|----|----|
|서브넷 | VPC당 |10개| O | |
|정적 라우트 | 서브넷당 | 20개 | O | |

<a id="resource-provision-policy-for-routing-service"></a>
### Routing 서비스 리소스 제공 정책 { #resource-provision-policy-for-routing-service }
리소스 사용량은 프로젝트별로 계산되며, 리전별로 구분하여 정책이 적용됩니다. 

|리소스 | 제공 기준 | 기본 제공량 | 조정 가능 여부 | 최대 제공량 |
|----|----|----|----|----|
|라우팅 테이블 | VPC당 |10개| O | |
|라우트 | 라우팅 테이블당 |10개| O | 100개 |

<a id="resource-provision-policy-for-peering-gateway-service"></a>
### Peering Gateway 서비스 리소스 제공 정책 { #resource-provision-policy-for-peering-gateway-service }
리소스 사용량은 프로젝트별로 계산되며, 리전별로 구분하여 정책이 적용됩니다. 

|리소스 | 제공 기준 | 기본 제공량 | 조정 가능 여부 | 최대 제공량 |
|----|----|----|----|----|
|리전 피어링 | 프로젝트당 |10개| O | | 
|프로젝트 피어링 | 프로젝트당 |10개| O | | 
|피어링 허용 대상 목록| 프로젝트당 |10개| O | | 

<a id="resource-provision-policy-for-internet-gateway-service"></a>
### Internet Gateway 서비스 리소스 제공 정책 { #resource-provision-policy-for-internet-gateway-service }
리소스 사용량은 프로젝트별로 계산되며, 리전별로 구분하여 정책이 적용됩니다. 

|리소스 | 제공 기준 | 기본 제공량 | 조정 가능 여부 | 최대 제공량 |
|----|----|----|----|----|
|인터넷 게이트웨이 | 프로젝트당	|3개| O | |

<a id="resource-provision-policy-for-nat-gateway-service"></a>
### NAT Gateway 서비스 리소스 제공 정책 { #resource-provision-policy-for-nat-gateway-service }
리소스 사용량은 프로젝트별로 계산되며, 리전별로 구분하여 정책이 적용됩니다. 

|리소스 | 제공 기준 | 기본 제공량 | 조정 가능 여부 | 최대 제공량 |
|----|----|----|----|----|
|NAT 게이트웨이 | 프로젝트당 | 3개 | O | | 

<a id="resource-provision-policy-for-vpn-gatewaysite-to-site-vpn-service"></a>
### VPN Gateway(Site-to-Site VPN) 서비스 리소스 제공 정책 { #resource-provision-policy-for-vpn-gatewaysite-to-site-vpn-service }
리소스 사용량은 프로젝트별로 계산되며, 리전별로 구분하여 정책이 적용됩니다. 

|리소스 | 제공 기준 | 기본 제공량 | 조정 가능 여부 | 최대 제공량 |
|----|----|----|----|----|
|VPN 게이트웨이(Site-to-Site VPN) | 프로젝트당 | 3개 | X | |
|VPN(Site-to-Site VPN) 연결| 프로젝트당 | 30개 | X | |

<a id="resource-provision-policy-for-service-gateway-service"></a>
### Service Gateway 서비스 리소스 제공 정책 { #resource-provision-policy-for-service-gateway-service }
리소스 사용량은 프로젝트별로 계산되며, 리전별로 구분하여 정책이 적용됩니다. 

|리소스 | 제공 기준 | 기본 제공량 | 조정 가능 여부 | 최대 제공량 |
|----|----|----|----|----|
|서비스 게이트웨이 | 프로젝트당 | 10개 | O | |

<a id="resource-provision-policy-for-traffic-mirroring-service"></a>
### Traffic Mirroring 서비스 리소스 제공 정책 { #resource-provision-policy-for-traffic-mirroring-service }
리소스 사용량은 프로젝트별로 계산되며, 리전별로 구분하여 정책이 적용됩니다. 

|리소스 | 제공 기준 | 기본 제공량 | 조정 가능 여부 | 최대 제공량 |
|----|----|----|----|----|
|트래픽 미러링 세션 | 프로젝트당 | 10개 | O | | 
|트래픽 미러링 필터 그룹 | 프로젝트당 | 10개 | O | | 

<a id="resource-provision-policy-for-network-interface-service"></a>
### Network Interface 서비스 리소스 제공 정책 { #resource-provision-policy-for-network-interface-service }
리소스 사용량은 프로젝트별로 계산되며, 리전별로 구분하여 정책이 적용됩니다.
Network Interface 콘솔에는 사용자 프로젝트 외 리소스도 함께 표시될 수 있으며, 해당 리소스는 제공량에 포함되지 않습니다.

|리소스 | 제공 기준 | 기본 제공량 | 조정 가능 여부 | 최대 제공량 |
|----|----|----|----|----|
| 네트워크 인터페이스 | 프로젝트당 | 500개 | O | | 

<a id="resource-provision-policy-for-network-acl-service"></a>
### Network ACL 서비스 리소스 제공 정책 { #resource-provision-policy-for-network-acl-service }
리소스 사용량은 프로젝트별로 계산되며, 리전별로 구분하여 정책이 적용됩니다. 

|리소스 | 제공 기준 | 기본 제공량 | 조정 가능 여부 | 최대 제공량 |
|----|----|----|----|----|
| Network ACL | 프로젝트당 | 10개 | O | | 
| Network ACL 정책 | 프로젝트당 | 100개 | O | | 
| Network ACL 바인딩 | 프로젝트당 | 100개 | O | | 

<a id="resource-provision-policy-for-load-balancer-service"></a>
### Load Balancer 서비스 리소스 제공 정책 { #resource-provision-policy-for-load-balancer-service }
리소스 사용량은 프로젝트별로 계산되며, 리전별로 구분하여 정책이 적용됩니다. 

|리소스 | 제공 기준 | 기본 제공량 | 조정 가능 여부 | 최대 제공량 |
|----|----|----|----|----|
|로드 밸런서 | 프로젝트당 |10개| O | |
|로드 밸런서 리스너 | 로드밸런서당 |50개| O | |
|로드 밸런서 멤버 그룹| 로드밸런서당 |50개| O | |
|로드 밸런서 IP 접근 제어 그룹	| 프로젝트당   |10개| O | |
|로드 밸런서 IP 접근 제어 대상 | IP 접근 제어 그룹당 |1000개| O | |
|로드 밸런서 L7 규칙 | 리스너당 |10개| O | |
|로드 밸런서 L7 조건 | L7 규칙당 |10개| O | |
|SSL 정책 | 프로젝트당 |10개| O | |

<a id="resource-provision-policy-for-load-balancerdsr-service"></a>
### Load Balancer(DSR) 서비스 리소스 제공 정책 { #resource-provision-policy-for-load-balancerdsr-service }
리소스 사용량은 프로젝트별로 계산되며, 리전별로 구분하여 정책이 적용됩니다. 

|리소스 | 제공 기준 | 기본 제공량 | 조정 가능 여부 | 최대 제공량 |
|----|----|----|----|----|
|로드 밸런서(DSR) | 프로젝트당 |10개| O | |
|로드 밸런서(DSR) 멤버 | 로드밸런서(DSR)당 |30개| O | |


<a id="resource-provision-policy-for-nas-service"></a>
### NAS 서비스 리소스 제공 정책 { #resource-provision-policy-for-nas-service }
리소스 사용량은 프로젝트별로 계산되며, 리전별로 구분하여 정책이 적용됩니다. 

|리소스 | 제공 기준 | 기본 제공량 | 조정 가능 여부 | 최대 제공량 |
|----|----|----|----|----|
| NAS 볼륨 | 프로젝트당 | 100개 | O | |
| NAS 볼륨 크기 | 프로젝트당 | 30,000 GB | O | |
| NAS 볼륨 최대 크기 | NAS 볼륨당 | 10,000 GB | O | |
| NAS 볼륨 서브넷 | 프로젝트당 | 3개 | O | |

<a id="resource-provision-policy-for-nas-for-bigdata-service"></a>
### NAS for BigData 서비스 리소스 제공 정책 { #resource-provision-policy-for-nas-for-bigdata-service }
리소스 사용량은 프로젝트별로 계산되며, 리전별로 구분하여 정책이 적용됩니다. 

|리소스 | 제공 기준 | 기본 제공량 | 조정 가능 여부 | 최대 제공량 |
|----|----|----|----|----|
| NAS for BigData 볼륨 | 프로젝트당 | 100개 | O | |
| NAS for BigData 볼륨 크기 | 프로젝트당 | 500,000 GB | O | |
| NAS for BigData 볼륨 최대 크기 | NAS 볼륨당 | 50,000 GB | O | |

<a id="resource-provision-policy-for-storage-gateway-service"></a>
### Storage Gateway 서비스 리소스 제공 정책 { #resource-provision-policy-for-storage-gateway-service }
리소스 사용량은 프로젝트별로 계산되며, 리전별로 구분하여 정책이 적용됩니다. 

|리소스 | 제공 기준 | 기본 제공량 | 조정 가능 여부 | 최대 제공량 |
|----|----|----|----|----|
| 스토리지 게이트웨이 | 프로젝트당 | 3개 | X | |
| 공유 | 게이트웨이당 | 10개 | X | |

<a id="resource-provision-policy-for-transit-hub-service"></a>
### Transit Hub 서비스 리소스 제공 정책 { #resource-provision-policy-for-transit-hub-service }
리소스 사용량은 프로젝트별로 계산되며, 리전별로 구분하여 정책이 적용됩니다. 

|리소스 | 제공 기준 | 기본 제공량 | 조정 가능 여부 | 최대 제공량 |
|----|----|----|----|----|
| 트랜짓 허브 | 프로젝트당 | 10개 | O | |
| 트랜짓 허브 연결 | 프로젝트당 | 20개 | O | |
| 트랜짓 허브 허용 목록 | 프로젝트당 | 10개 | O | |
| 트랜짓 허브 라우팅 테이블 | 프로젝트당 | 20개 | O | |
| 트랜짓 허브 라우팅 룰 | 프로젝트당 | 100개 | O | |
| 트랜짓 허브 멀티캐스트 도메인 | 프로젝트당 | 20개 | O | |
| 트랜짓 허브 멀티캐스트 그룹 | 프로젝트당 | 100개 | O | |

<a id="resource-provision-policy-for-private-dns-service"></a>
### Private DNS 서비스 리소스 제공 정책 { #resource-provision-policy-for-private-dns-service }
리소스 사용량은 프로젝트별로 계산되며, 리전별로 구분하여 정책이 적용됩니다. 

|리소스 | 제공 기준 | 기본 제공량 | 조정 가능 여부 | 최대 제공량 |
|----|----|----|----|----|
| Private DNS Zone | 프로젝트당 | 100개 | O | |
| Private DNS 레코드 세트 | 프로젝트당 | 500개 | O | |

<a id="resource-provision-policy-for-nhn-kubernetes-service-nks"></a>
### NHN Kubernetes Service(NKS) 리소스 제공 정책 { #resource-provision-policy-for-nhn-kubernetes-service-nks }
리소스 사용량은 프로젝트별로 계산되며, 리전별로 구분하여 정책이 적용됩니다.

|리소스 | 제공 기준 | 기본 제공량 | 조정 가능 여부 | 최대 제공량 |
|----|----|----|----|----|
|클러스터	| 프로젝트당 |3개| O | |
|워커 노드 그룹	 | 클러스터당 |3개(기본 워커 노드 그룹 포함)| O | |
|워커 노드 수	 | 워커 노드 그룹당 |10개| O | |

<a id="resource-provision-policy-for-nhn-container-registryncr"></a>
### NHN Container Registry(NCR) 리소스 제공 정책 { #resource-provision-policy-for-nhn-container-registryncr }
리소스 사용량은 프로젝트별로 계산되며, 리전별로 구분하여 정책이 적용됩니다.

|리소스 | 제공 기준 | 기본 제공량 | 조정 가능 여부 | 최대 제공량 |
|----|----|----|----|----|
| 레지스트리 수 | 프로젝트당 | 30개 | O | |
| 이미지 수 | 레지스트리당 | 10000개 | O | |
| 아티팩트 수 | 이미지당 | 10000개 | O | |
| 태그 수 | 아티팩트당 | 1000개 | O | |
| 수동 스캔 수 | 이미지당 1일 | 1개 | O | |


<a id="resource-provision-policy-for-nhn-container-servicencs"></a>
### NHN Container Service(NCS) 리소스 제공 정책 { #resource-provision-policy-for-nhn-container-servicencs }
리소스 사용량은 프로젝트별로 계산되며, 리전별로 구분하여 정책이 적용됩니다.

|리소스 | 제공 기준 | 기본 제공량 | 조정 가능 여부 | 최대 제공량 |
|----|----|----|----|----|
| 워크로드	| 프로젝트당 |제한 없음| O | |
| 작업 | 워크로드당 | 100개 |  O | |
| 템플릿 | 프로젝트당 | 1,000개 | O | | 
| 컨테이너 | 템플릿당 | 10개 | O | |
| CPU | 템플릿당 | 16vCore | O | | 
| CPU | 프로젝트당 | 24vCore | O | | 
| 메모리 | 템플릿당 |32,768 MiB | O | 230,400 MiB |
| 메모리 | 프로젝트당 |	49,152 MiB | O | |
| GPU | 템플릿당 |  7Core | O | |
| GPU | 프로젝트당 | 7Core | O | |


<a id="resource-provision-policy-for-dns-plus-service"></a>
### DNS Plus 서비스 리소스 제공 정책 { #resource-provision-policy-for-dns-plus-service }
리소스 사용량은 프로젝트별로 계산됩니다.

<a id="resource-provision-policy-for-dns-plus-service-dns"></a>
#### DNS
|리소스 | 제공 기준 | 기본 제공량 | 조정 가능 여부 | 최대 제공량 |
|----|----|----|----|----|
|레코드 세트	| DNS Zone당 |5,000개| O | |

<a id="resource-provision-policy-for-dns-plus-service-gslb"></a>
#### GSLB
|리소스 | 제공 기준 | 기본 제공량 | 조정 가능 여부 | 최대 제공량 |
|----|----|----|----|----|
|GSLB	| 프로젝트당 | 20개| O | |
|Pool	| 프로젝트당 | 20개 | O | |
|Pool   | GSLB당    | 16개 | O | |
|엔드포인트 | 프로젝트당 | 20개 | O | |
|엔드포인트 | Pool당 | 5개 | O | |
|헬스 체크	| 프로젝트당 | 5개 | O | |


<a id="resource-provision-policy-for-rds-for-mysql"></a>
### RDS for MySQL 서비스 리소스 제공 정책 { #resource-provision-policy-for-rds-for-mysql }
| 리소스 | 제공 기준 | 기본 제공량 | 조정 가능 여부 | 최대 제공량 |
|----|----|----|----|----|
| DB 인스턴스 CPU | 프로젝트당 | 100vCore | O | |
| DB 인스턴스 메모리 | 프로젝트당 | 262,144MB | O | |
| DB 인스턴스 Data Storage | 프로젝트당 | 10,240GB | O | | 
| 복제본 | DB 인스턴스 그룹당 | 5개 | O | |

<a id="resource-provision-policy-for-rds-for-postgresql"></a>
### RDS for PostgreSQL 서비스 리소스 제공 정책 { #resource-provision-policy-for-rds-for-postgresql }
| 리소스 | 제공 기준 | 기본 제공량 | 조정 가능 여부 | 최대 제공량 |
|----|----|----|----|----|
| DB 인스턴스 CPU | 프로젝트당 | 100vCore | O | |
| DB 인스턴스 메모리 | 프로젝트당 | 262,144MB | O | |
| DB 인스턴스 Data Storage | 프로젝트당 | 10,240GB | O | | 
| 복제본 | DB 인스턴스 그룹당 | 5개 | O | |

<a id="resource-provision-policy-for-rds-for-mariadb"></a>
### RDS for MariaDB 서비스 리소스 제공 정책 { #resource-provision-policy-for-rds-for-mariadb }
| 리소스 | 제공 기준 | 기본 제공량 | 조정 가능 여부 | 최대 제공량 |
|----|----|----|----|----|
| DB 인스턴스 CPU | 프로젝트당 | 100vCore | O | |
| DB 인스턴스 메모리 | 프로젝트당 | 262,144MB | O | |
| DB 인스턴스 Data Storage | 프로젝트당 | 10,240GB | O | | 
| 복제본 | DB 인스턴스 그룹당 | 5개 | O | |


<a id="resource-provision-policy-for-rds-for-ms-sql"></a>
### RDS for MS-SQL 서비스 리소스 제공 정책 { #resource-provision-policy-for-rds-for-ms-sql }
| 리소스 | 제공 기준 | 기본 제공량 | 조정 가능 여부 | 최대 제공량 |
|----|----|----|----|----|
| DB 인스턴스 CPU | 프로젝트당 | 200vCore | O | |
| DB 인스턴스 메모리 | 프로젝트당 | 524,288MB | O | |
| DB 인스턴스 Data Storage | DB 인스턴스당 | 2,048GB | O | | 
| DB 인스턴스 Data Storage | 프로젝트당 | 10,240GB | O | |


<a id="resource-provision-policy-for-network-firewall"></a>
### Network Firewall 서비스 리소스 제공 정책 { #resource-provision-policy-for-network-firewall }
| 리소스 | 제공 기준 | 기본 제공량 | 조정 가능 여부 | 최대 제공량 |
|----|----|----|----|----|
| ACL 정책 개수 | 프로젝트당 | 1,000개 | X | | 
| ACL 정책 룰 개수 | 프로젝트당 | 5,000개 | X | | 
| ACL 최대 세션 개수 | 프로젝트당 | 1,000,000개 | X | | 
| NAT 개수 | 프로젝트당 | 200개 | X | |
| NAT 최대 세션 개수 | 프로젝트당 | 1,000,000개 | X | | 
| 트래픽 로그 건 수 | 프로젝트당 | 8,000,000개 | X | | 
| 게이트웨이 개수 | 프로젝트당 | 10개 | X | |
| 터널 개수 | 프로젝트당 | 20개 | X | |


<a id="resource-provision-policy-for-cloud-access"></a>
### Cloud Access 서비스 리소스 제공 정책 { #resource-provision-policy-for-cloud-access }
| 리소스 | 제공 기준 | 기본 제공량 | 조정 가능 여부 | 최대 제공량 |
|----|----|----|----|----|
| 사용자 계정 개수 | 프로젝트당 | 20개 | X | |
| 동시 접속자 수 | 프로젝트당 | 20명 | X | |
| ACL 정책 개수 | 프로젝트당 | 100개 | X | |
| ACL 정책 룰 개수 | 프로젝트당 | 500개 | X | |
| ACL 최대 세션 개수 | 프로젝트당 | 10,000개 | X | |
| 터널 최대 세션 개수 | 프로젝트당 | 10,000개 | X | |
| 사용자 정책 개수 | 프로젝트당 | 50개 | X | |
| 접근 가능 대역 개수 | 사용자 정책당 | 3개 | X | |
| 인터넷 차단 예외 IP 개수 | 사용자 정책당 | 100개 | X | |
| 필수 소프트웨어 등록 개수 | 사용자 정책당 | 50개 | X | |
| 차단 소프트웨어 등록 개수 | 사용자 정책당 | 50개 | X | |
| 백신 검사 등록 개수 | 사용자 정책당 | 50개 | X | |
| 트래픽 로그 건수 | 프로젝트당 | 50,000개 | X | |
| 사용자 로그 건수 | 프로젝트당 | 200,000개 | X | |


<a id="resource-provision-policy-for-notification-hub"></a>
### Notification Hub 서비스 리소스 제공 정책 { #resource-provision-policy-for-notification-hub }
SMS 서비스와 Notification Hub 서비스의 SMS 발송 건수가 합산되어 계산됩니다.
KakaoTalk Bizmessage 서비스와 Notification Hub 서비스의 알림톡 발송 건수가 합산되어 계산됩니다.

| 리소스 | 제공 기준 | 기본 제공량 | 조정 가능 여부 | 최대 제공량 |
|----|----|----|----|----|
| SMS 발송 건수 | 조직 당 | 5,000건 | O | | 
| 알림톡 발송 건수 | 카카오톡 채널당 1일 | 1,000건 | O | | 

<a id="resource-provision-policy-for-sms"></a>
### SMS 서비스 리소스 제공 정책 { #resource-provision-policy-for-sms }
| 리소스 | 제공 기준 | 기본 제공량 | 조정 가능 여부 | 최대 제공량 |
|----|----|----|----|----|
| 발송 건수 | 조직 당 | 5,000건 | O | | 

<a id="resource-provision-policy-for-kakaotalk-bizmessage-service"></a>
### KakaoTalk Bizmessage 서비스 리소스 제공 정책 { #resource-provision-policy-for-kakaotalk-bizmessage-service }
| 리소스 | 제공 기준 | 기본 제공량 | 조정 가능 여부 | 최대 제공량 |
|----|----|----|----|----|
| 알림톡 발송 건수 | 카카오톡 채널당 1일 | 1,000건 | O | | 

<a id="resource-provision-policy-for-face-recognition-service"></a>
### Face Recognition 서비스 리소스 제공 정책 { #resource-provision-policy-for-face-recognition-service }
리소스 사용량은 프로젝트별로 계산됩니다.

| 리소스 | 제공 기준 | 기본 제공량 | 조정 가능 여부 | 최대 제공량 |
|----|----|----|----|----|
| 그룹 개수 | Face Recognition 서비스당 | 5건 | O | | 
| 그룹 내 얼굴 등록개수 | Face Recognition 서비스 그룹당 | 100,000건 | O | |

<a id="resource-provision-policy-for-ocr"></a>
### OCR 서비스 리소스 제공 정책 { #resource-provision-policy-for-ocr }
리소스 사용량은 프로젝트별로 계산됩니다.

| 리소스 | 제공 기준 | 기본 제공량 | 조정 가능 여부 | 최대 제공량 |
|----|----|----|----|----|
| 신분증 분석 요청 건수 | OCR 서비스당 | 100,000건 | X | | 

<a id="resource-provision-policy-for-api-gateway-service"></a>
### API Gateway 서비스 리소스 제공 정책 { #resource-provision-policy-for-api-gateway-service }
리소스 사용량은 프로젝트별로 계산되며, 리전별로 구분하여 정책이 적용됩니다.

| 리소스 | 제공 기준 | 기본 제공량 | 조정 가능 여부 | 최대 제공량 |
|----|----|----|----|----|
| API Gateway 서비스 | 프로젝트당 | 10개 | O | |
| 스테이지 | API Gateway 서비스당 | 10개 | O | |
| 리소스 메서드 | API Gateway 서비스당 | 100개 | O | 300개 |

<a id="resource-provision-policy-for-log-crash-search-service"></a>
### Log & Crash Search 서비스 리소스 제공 정책 { #resource-provision-policy-for-log-crash-search-service }
리소스 사용량은 프로젝트별로 계산됩니다.

| 리소스 | 제공 기준 | 기본 제공량 | 조정 가능 여부 | 최대 제공량 |
|----|----|----|----|----|
| 로그(일반 로그, 크래시 로그) 건 수 | 1일 | 20,000,000 건 | O | |
| 로그(일반 로그, 크래시 로그) 크기 | 1건 | 8MB | X | |

<a id="resource-provision-policy-for-dataflow-service"></a>
### DataFlow 서비스 리소스 제공 정책 { #resource-provision-policy-for-dataflow-service }
리소스 사용량은 프로젝트별로 계산되며, 리전별로 구분하여 정책이 적용됩니다.

| 리소스 | 제공 기준 | 기본 제공량 | 조정 가능 여부 | 최대 제공량 |
|----|----|----|----|----|
| CPU | 프로젝트당 | 10vCore | O | |
| Memory | 프로젝트당 | 20GB | O | |

<a id="resource-provision-policy-for-easyqueue-service"></a>
### EasyQueue 서비스 리소스 제공 정책 { #resource-provision-policy-for-easyqueue-service }
리소스 사용량은 프로젝트별로 계산되며, 리전별로 구분하여 정책이 적용됩니다.

| 리소스 | 제공 기준 | 기본 제공량 | 조정 가능 여부 | 최대 제공량 |
|----|----|----|----|----|
| 토픽 수 | 프로젝트당 | 10개 | X | |
| 파티션 수 | 프로젝트당 | 64개 | X | |
| 파티션 수 | 토픽 당 | 16개 | X | |

<a id="request-for-capacity-adjustment"></a>
### 리소스 제공량 증설 요청 { #request-for-capacity-adjustment }
제공 정책의 사용량 증설을 원하는 경우 NHN Cloud 고객 센터 [1:1문의](https://nhncloud.com/kr/support/inquiry)로 문의하시면 됩니다. 
요청 시 원하는 항목과 양을 기재하시면 상담이 수월하게 이루어질 수 있습니다. 

요청 후 처리되기까지는 2~5일 정도 소요되므로 실제 필요한 시점보다 미리 신청하시는 것을 권장합니다.
