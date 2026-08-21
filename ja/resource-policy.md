<!-- pre-align:aligned sig=9516cb1f41d0 -->

<a id="nhn-cloud-nhn-cloud-resource-provision-policy"></a>
## NHN Cloud > リソース提供ポリシー { #nhn-cloud-nhn-cloud-resource-provision-policy }
NHN Cloudは、全てのお客様に安定的なサービスを提供し、意図しないリソース生成によって発生する支出などからユーザーを保護するためにリソース使用量ポリシーを設定しています。 

<a id="resource-provision-policy-for-organizationproject"></a>
### 組織/プロジェクトリソース提供ポリシー { #resource-provision-policy-for-organizationproject }
組織のリソースは決済方法を登録した会員を基準に計算され、プロジェクトは組織を基準に計算されます。

|リソース | 会員タイプ | 提供基準 | 提供量 | 
|----|----|----|----|
|組織	| 個人 | 決済方法を登録した会員1人ごと|3個|
|	| 事業者 | 決済方法を登録した会員1人ごと|5個|
|プロジェクト	 | 個人 | 組織ごと |5個|
|	 | 事業者 | 組織ごと |10個|

<a id="resource-provision-policy-for-instance-service"></a>
### Instanceリソース提供ポリシー { #resource-provision-policy-for-instance-service }
リソース使用量はプロジェクトごとに計算され、リージョンごとにそれぞれのリソース使用量制限ポリシーが適用されます。

|リソース | 提供基準 | 基本提供量 | 調整の可否 | 最大提供量 |
|----|----|----|----|----|
|CPU	| プロジェクトごと |100vCore| O | |
|メモリ	 | プロジェクトごと |262,144MB| O | |


<a id="resource-provision-policy-for-block-storage-service"></a>
### Block Storageリソース提供ポリシー { #resource-provision-policy-for-block-storage-service }
リソース使用量はプロジェクトごとに計算され、リージョンごとにそれぞれのリソース使用量制限ポリシーが適用されます。

|リソース | 提供基準 | 基本提供量 | 調整の可否 | 最大提供量 |
|----|----|----|----|----|
|Block Storage| プロジェクトごと |10240GB| O | |
|Block Storage HDD Type 最大サイズ| ブロックストレージ毎 |2048GB| O | |
|Block Storage SSD Type 最大サイズ| ブロックストレージ毎 |2048GB| O | |
|Block Storage Encrypted HDD Type 最大サイズ| ブロックストレージ毎 |2048GB| O | |
|Block Storage Encrypted SSD Type 最大サイズ| ブロックストレージ毎 |2048GB| O | |
|Snapshot| ブロックストレージ毎 |3個| X | |

<a id="resource-provision-policy-for-floating-ip-service"></a>
### Floating IPリソース提供ポリシー { #resource-provision-policy-for-floating-ip-service }
リソース使用量はプロジェクトごとに計算され、リージョンごとにそれぞれのリソース使用量制限ポリシーが適用されます。

|リソース | 提供基準 | 基本提供量 | 調整の可否 | 最大提供量 |
|----|----|----|----|----|
|Floating IP | プロジェクトごと |50個| O | |

<a id="resource-provision-policy-for-vpc-service"></a>
### VPCリソース提供ポリシー { #resource-provision-policy-for-vpc-service }
リソース使用量はプロジェクトごとに計算され、リージョンごとにそれぞれのリソース使用量制限ポリシーが適用されます。

|リソース | 提供基準 | 基本提供量 | 調整の可否 | 最大提供量 |
|----|----|----|----|----|
|VPC | プロジェクトごと |3個| O | |


<a id="resource-provision-policy-for-subnet-service"></a>
### Subnetリソース提供ポリシー { #resource-provision-policy-for-subnet-service }
リソース使用量はプロジェクトごとに計算され、リージョンごとにそれぞれのリソース使用量制限ポリシーが適用されます。

|リソース | 提供基準 | 基本提供量 | 調整の可否 | 最大提供量 |
|----|----|----|----|----|
|サブネット | VPCごと |10個| O | |
|静的ルート | サブネットごと | 20個 | O | |


<a id="resource-provision-policy-for-routing-service"></a>
### Routingリソース提供ポリシー { #resource-provision-policy-for-routing-service }
リソース使用量はプロジェクトごとに計算され、リージョンごとにそれぞれのリソース使用量制限ポリシーが適用されます。

|リソース | 提供基準 | 基本提供量 | 調整の可否 | 最大提供量 |
|----|----|----|----|----|
|ルーティングテーブル | VPCごと |10個| O | |
|ルーティング | ルーティングテーブルごと |10個| O | 100個 |



<a id="resource-provision-policy-for-peering-gateway-service"></a>
### Peering Gatewayリソース提供ポリシー { #resource-provision-policy-for-peering-gateway-service }
リソース使用量はプロジェクトごとに計算され、リージョンごとにそれぞれのリソース使用量制限ポリシーが適用されます。

|リソース | 提供基準 | 基本提供量 | 調整の可否 | 最大提供量 |
|----|----|----|----|----|
|リージョンピアリング | プロジェクトごと |10個 | O | | 
|プロジェクトピアリング | プロジェクトごと |10個 | O | | 
|ピアリング 許可 対象 | プロジェクトごと |10個 | O | | 


<a id="resource-provision-policy-for-internet-gateway-service"></a>
### Internet Gateway サービスリソース提供ポリシー { #resource-provision-policy-for-internet-gateway-service }

<!-- TODO: translate body -->

<a id="resource-provision-policy-for-nat-gateway-service"></a>
### NAT Gatewayリソース提供ポリシー { #resource-provision-policy-for-nat-gateway-service }
リソース使用量はプロジェクトごとに計算され、リージョンごとにそれぞれのリソース使用量制限ポリシーが適用されます。

|リソース | 提供基準 | 基本提供量 | 調整の可否 | 最大提供量 |
|----|----|----|----|----|
|NATゲートウェイ | プロジェクトごと | 3個 | O | | 



<a id="resource-provision-policy-for-vpn-gatewaysite-to-site-vpn-service"></a>
### VPN Gateway(Site-to-Site VPN)リソース提供ポリシー { #resource-provision-policy-for-vpn-gatewaysite-to-site-vpn-service }
リソース使用量はプロジェクトごとに計算され、リージョンごとにそれぞれのリソース使用量制限ポリシーが適用されます。

|リソース | 提供基準 | 基本提供量 | 調整の可否 | 最大提供量 |
|----|----|----|----|----|
|VPN ゲートウェイ(Site-to-Site VPN) | プロジェクトごと | 3 | X | | 
|VPN(Site-to-Site VPN) 接続 | プロジェクトごと | 30 | X | |  



<a id="resource-provision-policy-for-service-gateway-service"></a>
### Service Gatewayリソース提供ポリシー { #resource-provision-policy-for-service-gateway-service }
リソース使用量はプロジェクトごとに計算され、リージョンごとにそれぞれのリソース使用量制限ポリシーが適用されます。

|リソース | 提供基準 | 基本提供量 | 調整の可否 | 最大提供量 |
|----|----|----|----|----|
|サービスゲートウェイ | プロジェクトごと | 10個 | O | | 
|ユーザー定義 エンドポイント | プロジェクトごと | 5個 | O | | 



<a id="resource-provision-policy-for-traffic-mirroring-service"></a>
### Traffic Mirroringリソース提供ポリシー { #resource-provision-policy-for-traffic-mirroring-service }
リソース使用量はプロジェクトごとに計算され、リージョンごとにそれぞれのリソース使用量制限ポリシーが適用されます。

|リソース | 提供基準 | 基本提供量 | 調整の可否 | 最大提供量 |
|----|----|----|----|----|
|トラフィックミラーリングセッションの | プロジェクトごと | 10個 | O | | 
|トラフィックミラーリングフィルタグループ | プロジェクトごと | 10個 | O | | 


<a id="resource-provision-policy-for-network-interface-service"></a>
### Network Interfaceリソース提供ポリシー { #resource-provision-policy-for-network-interface-service }
リソース使用量はプロジェクトごとに計算され、リージョンごとにそれぞれのリソース使用量制限ポリシーが適用されます。
Network Interface コンソールには、ユーザープロジェクト以外のリソースも表示される場合がありますが、それらのリソースは提供量には含まれません。

|リソース | 提供基準 | 基本提供量 | 調整の可否 | 最大提供量 |
|----|----|----|----|----|
| Network Interface | プロジェクトごと | 500個 | O | | 


<a id="resource-provision-policy-for-network-acl-service"></a>
### Network ACLリソース提供ポリシー { #resource-provision-policy-for-network-acl-service }
リソース使用量はプロジェクトごとに計算され、リージョンごとにそれぞれのリソース使用量制限ポリシーが適用されます。

|リソース | 提供基準 | 基本提供量 | 調整の可否 | 最大提供量 |
|----|----|----|----|----|
| Network ACL | プロジェクトごと | 10個 | O | | 
| Network ACLポリシー | プロジェクトごと | 100個 | O | | 
| Network ACLバインディング | プロジェクトごと | 100個 | O | | 



<a id="resource-provision-policy-for-load-balancer-service"></a>
### Load Balancerリソース提供ポリシー { #resource-provision-policy-for-load-balancer-service }
リソース使用量はプロジェクトごとに計算され、リージョンごとにそれぞれのリソース使用量制限ポリシーが適用されます。

|リソース | 提供基準 | 基本提供量 | 調整の可否 | 最大提供量 |
|----|----|----|----|----|
|Load Balancer | プロジェクトごと |10個| O | |
|Load Balancer Listener | Load Balancer ごと |50個| O | |
|Load Balancer Member Group| Load Balancer ごと |50個| O | |
|IPアクセス制御グループ	| プロジェクトごと |10個| O | |
|IPアクセス制御対象 | IPアクセス制御グループごと |1000個| O | |
|L7 ポリシー | リスナー毎 |10個| O | |
|L7 ルール | L7ポリシー毎 |10個| O | |
|SSL ポリシー| プロジェクトごと |10個| O | |

<a id="resource-provision-policy-for-load-balancerdsr-service"></a>
### Load Balancer(DSR)リソース提供ポリシー { #resource-provision-policy-for-load-balancerdsr-service }
リソース使用量はプロジェクトごとに計算され、リージョンごとにそれぞれのリソース使用量制限ポリシーが適用されます。

|リソース | 提供基準 | 基本提供量 | 調整の可否 | 最大提供量 |
|----|----|----|----|----|
|Load Balancer(DSR) | プロジェクトごと |10個| O | |
|Load Balancer(DSR) Member| Load Balancer(DSR) ごと |30個| O | |



<a id="resource-provision-policy-for-nas-service"></a>
### NASリソース提供ポリシー { #resource-provision-policy-for-nas-service }
リソース使用量はプロジェクトごとに計算され、リージョンごとにそれぞれのリソース使用量制限ポリシーが適用されます。

|リソース | 提供基準 | 基本提供量 | 調整の可否 | 最大提供量 |
|----|----|----|----|----|
| NAS ボリューム | プロジェクトごと| 100個 | O | |
| NAS ボリューム サイズ | プロジェクトごと | 30,000 GB | O | |
| NAS ボリューム 最大サイズ | NAS ボリュームごと | 10,000 GB | O | |
| NAS ボリューム サブネット | プロジェクトごと | 3個 | O | |

<a id="resource-provision-policy-for-nas-for-bigdata-service"></a>
### NAS for BigDataリソース提供ポリシー { #resource-provision-policy-for-nas-for-bigdata-service }
リソース使用量はプロジェクトごとに計算され、リージョンごとにそれぞれのリソース使用量制限ポリシーが適用されます。

|リソース | 提供基準 | 基本提供量 | 調整の可否 | 最大提供量 |
|----|----|----|----|----|
| NAS for BigData ボリューム | プロジェクトごと| 100個 | O | |
| NAS for BigData ボリューム サイズ | プロジェクトごと | 500,000 GB | O | |
| NAS for BigData ボリューム 最大サイズ | NAS ボリュームごと  | 50,000 GB | O | |

<a id="resource-provision-policy-for-storage-gateway-service"></a>
### Storage Gatewayリソース提供ポリシー { #resource-provision-policy-for-storage-gateway-service }
リソース使用量はプロジェクトごとに計算され、リージョンごとにそれぞれのリソース使用量制限ポリシーが適用されます。

|リソース | 提供基準 | 基本提供量 | 調整の可否 | 最大提供量 |
|----|----|----|----|----|
| ストレージゲートウェイ | プロジェクトごと| 3個 | X | |
| 共有 | ゲートウェイ毎 | 10個 | X | |

<a id="resource-provision-policy-for-transit-hub-service"></a>
### Transit Hubリソース提供ポリシー { #resource-provision-policy-for-transit-hub-service }
リソース使用量はプロジェクトごとに計算され、リージョンごとにそれぞれのリソース使用量制限ポリシーが適用されます。

|リソース | 提供基準 | 基本提供量 | 調整の可否 | 最大提供量 |
|----|----|----|----|----|
| トランジットハブ | プロジェクトごと | 10個 | O | |
| トランジットハブ接続 | プロジェクトごと | 20個 | O | |
| トランジットハブ許可リスト | プロジェクトごと | 10個 | O | |
| トランジットハブルーティングテーブル | プロジェクトごと | 20個 | O | |
| トランジットハブルーティングルール | プロジェクトごと | 100個 | O | |
| トランジットハブマルチキャストドメイン | プロジェクトごと | 20個 | O | |
| トランジットハブマルチキャストグループ | プロジェクトごと | 100個 | O | |

<a id="resource-provision-policy-for-private-dns-service"></a>
### Private DNSリソース提供ポリシー { #resource-provision-policy-for-private-dns-service }
リソース使用量はプロジェクトごとに計算され、リージョンごとにそれぞれのリソース使用量制限ポリシーが適用されます。

|リソース | 提供基準 | 基本提供量 | 調整の可否 | 最大提供量 |
|----|----|----|----|----|
| Private DNS Zone | プロジェクトごと | 100個 | O | |
| Private DNS レコードセット | プロジェクトごと | 500個 | O | |

<a id="resource-provision-policy-for-nhn-kubernetes-service-nks"></a>
### NHN Kubernetes Service(NKS)リソース提供ポリシー { #resource-provision-policy-for-nhn-kubernetes-service-nks }
リソース使用量はプロジェクトごとに計算され、リージョンごとにポリシーが適用されます。

|リソース | 提供基準 | 基本提供量 | 調整の可否 | 最大提供量 |
|----|----|----|----|----|
|クラスター	| プロジェクトごと |3個| O | |
|ワーカーノードグループ	 | クラスターごと |3個(基本ワーカーノードグループを含む)| O | |
|ワーカーノード数	 | ワーカーノードグループ毎 |10個| O | |

<a id="resource-provision-policy-for-nhn-container-registryncr"></a>
### NHN Container Registry(NCR)リソース提供ポリシー { #resource-provision-policy-for-nhn-container-registryncr }
リソース使用量はプロジェクトごとに計算され、リージョンごとにポリシーが適用されます。

|リソース | 提供基準 | 基本提供量 | 調整の可否 | 最大提供量 |
|----|----|----|----|----|
| レジストリ数 | プロジェクト毎 | 30個 | O | |
| イメージ数 | レジストリ毎 | 10000個 | O | |
| アーティファクト数 | イメージ毎 | 10000個 | O | |
| タグ数 | アーティファクト毎 | 1000個 | O | |
| 手動スキャン数 | イメージ毎1日 | 1個 | O | |


<a id="resource-provision-policy-for-nhn-container-servicencs"></a>
### NHN Container Service(NCS)リソース提供ポリシー { #resource-provision-policy-for-nhn-container-servicencs }
リソース使用量はプロジェクトごとに計算され、リージョンごとにポリシーが適用されます。

|リソース | 提供基準 | 基本提供量 | 調整の可否 | 最大提供量 |
|----|----|----|----|----|
| ワークロード	| プロジェクトごと |制限なし| O | |
| 作業 | ワークロードごと | 100個 | O | | 
| テンプレート | プロジェクトごと | 1,000個 | O | | 
| コンテナ | テンプレートごと | 10個 | O | |
| CPU | テンプレートごと | 16vCore | O | | 
| CPU | プロジェクトごと | 24vCore | O | | 
| メモリ | テンプレートごと |32,768 MiB | O | 230,400 MiB |
| メモリ | プロジェクトごと |	49,152 MiB | O | |
| GPU | テンプレートごと |  7Core | O | | 
| GPU | プロジェクトごと | 7Core | O | |


<a id="resource-provision-policy-for-dns-plus-service"></a>
### DNS Plusサービスリソース提供ポリシー { #resource-provision-policy-for-dns-plus-service }
リソース使用量はリージョンの区別なくプロジェクトごとに計算されます。

<a id="resource-provision-policy-for-dns-plus-service-dns"></a>
#### DNS
|リソース | 提供基準 | 基本提供量 | 調整の可否 | 最大提供量 |
|----|----|----|----|----|
|レコードセット	| DNS Zoneごと |5,000個| O | |

<a id="resource-provision-policy-for-dns-plus-service-gslb"></a>
#### GSLB
|リソース | 提供基準 | 基本提供量 | 調整の可否 | 最大提供量 |
|----|----|----|----|----|
|GSLB	| プロジェクトごと | 20個| O | |
|Pool	| プロジェクトごと | 20個 | O | |
|Pool   | GSLBごと   | 16個 | O | |
|エンドポイント | プロジェクトごと | 20個 | O | |
|エンドポイント | Poolごと | 5個 | O | |
|ヘルスチェック	| プロジェクトごと | 5個 | O | |


<a id="resource-provision-policy-for-rds-for-mysql"></a>
### RDS for MySQLサービスリソース提供ポリシー { #resource-provision-policy-for-rds-for-mysql }
|リソース | 提供基準 | 基本提供量 | 調整の可否 | 最大提供量 |
|----|----|----|----|----|
| DB Instance CPU | プロジェクトごと  | 100vCore | O | |
| DB Instance メモリ | プロジェクトごと  | 262,144MB | O | |
| DB Instance データストレージ | プロジェクトごと  | 10,240GB | O | | 
| コピーを| DBインスタンスグループごと | 5個 | O | |

<a id="resource-provision-policy-for-rds-for-postgresql"></a>
### RDS for PostgreSQLサービスリソース提供ポリシー { #resource-provision-policy-for-rds-for-postgresql }
|リソース | 提供基準 | 基本提供量 | 調整の可否 | 最大提供量 |
|----|----|----|----|----|
| DB Instance CPU | プロジェクトごと  | 100vCore | O | |
| DB Instance メモリ | プロジェクトごと  | 262,144MB | O | |
| DB Instance データストレージ | プロジェクトごと  | 10,240GB | O | | 
| コピーを| DBインスタンスグループごと | 5個 | O | |

<a id="resource-provision-policy-for-rds-for-mariadb"></a>
### RDS for MariaDBサービスリソース提供ポリシー { #resource-provision-policy-for-rds-for-mariadb }
|リソース | 提供基準 | 基本提供量 | 調整の可否 | 最大提供量 |
|----|----|----|----|----|
| DB Instance CPU | プロジェクトごと  | 100vCore | O | |
| DB Instance メモリ | プロジェクトごと  | 262,144MB | O | |
| DB Instance データストレージ | プロジェクトごと  | 10,240GB | O | | 
| コピーを| DBインスタンスグループごと | 5個 | O | |


<a id="resource-provision-policy-for-rds-for-ms-sql"></a>
### RDS for MS-SQLサービスリソース提供ポリシー { #resource-provision-policy-for-rds-for-ms-sql }
|リソース | 提供基準 | 基本提供量 | 調整の可否 | 最大提供量 |
|----|----|----|----|----|
| DB Instance CPU | プロジェクトごと  | 200vCore | O | |
| DB Instance メモリ | プロジェクトごと  | 524,288MB | O | |
| DB Instance データストレージ| DB Instanceごと | 2,048GB | O | |
| DB Instance データストレージ | プロジェクトごと  | 10,240GB | O | | 


<a id="resource-provision-policy-for-network-firewall"></a>
### Network Firewallサービスリソース提供ポリシー { #resource-provision-policy-for-network-firewall }
|リソース | 提供基準 | 基本提供量 | 調整の可否 | 最大提供量 |
|----|----|----|----|----|
| ACLポリシー数 | プロジェクトごと | 1,000個 | X | | 
| ACLポリシールール数 | プロジェクトごと | 5,000個 | X | | 
| ACL最大セッション数 | プロジェクトごと | 1,000,000個 | X | |
| NAT数 | プロジェクトごと | 200個 | X | |
| NAT最大セッション数 | プロジェクトごと | 1,000,000個 | X | | 
| トラフィックログ件数 | プロジェクトごと | 8,000,000個 | X | | 
| ゲートウェイ数 | プロジェクトごと | 10個 | X | |
| トンネル数 | プロジェクトごと | 20個 | X | |


<a id="resource-provision-policy-for-cloud-access"></a>
### Cloud Access サービスリソース提供ポリシー { #resource-provision-policy-for-cloud-access }
|リソース | 提供基準 | 基本提供量 | 調整の可否 | 最大提供量 |
|----|----|----|----|----|
| ユーザーアカウント数 | プロジェクト毎 | 20個 | X | |
| 同時接続者数 | プロジェクト毎 | 20人 | X | |
| ACLポリシー数 | プロジェクト毎 | 100個 | X | |
| ACLポリシールール数 | プロジェクト毎 | 500個 | X | |
| ACL最大セッション数 | プロジェクト毎 | 10,000個 | X | |
| トンネル最大セッション数 | プロジェクト毎 | 10,000個 | X | |
| ユーザーポリシー数 | プロジェクト毎 | 50個 | X | |
| アクセス可能帯域数 | ユーザーポリシー毎 | 3個 | X | |
| インターネット遮断例外IP数 | ユーザーポリシー毎 | 100個 | X | |
| 必須ソフトウェア登録数 | ユーザーポリシー毎 | 50個 | X | |
| 遮断ソフトウェア登録数 | ユーザーポリシー毎 | 50個 | X | |
| ワクチン検査登録数 | ユーザーポリシー毎 | 50個 | X | |
| トラフィックログ件数 | プロジェクト毎 | 50,000個 | X | |
| ユーザーログ件数 | プロジェクト毎 | 200,000個 | X | |


<a id="resource-provision-policy-for-notification-hub"></a>
### Notification Hub サービスリソース提供ポリシー { #resource-provision-policy-for-notification-hub }

SMSサービスとNotification HubサービスのSMS送信件数が合算されて計算されます。
KakaoTalk BizmessageサービスとNotification Hubサービスのお知らせトーク送信件数が合算されて計算されます。

| リソース | 提供基準 | 基本提供量 | 調整の可否 | 最大提供量 |
|----|----|----|----|----|
| SMS 送信件数 | 組織ごと  | 5,000件 | O | |
| お知らせトーク送信件数 |  KakaoTalk Channel 1日毎 | 1,000件 | O | |

<a id="resource-provision-policy-for-sms"></a>
### SMSサービスリソース提供ポリシー { #resource-provision-policy-for-sms }
| リソース | 提供基準 | 基本提供量 | 調整の可否 | 最大提供量 |
|----|----|----|----|----|
| 送信件数 | 組織ごと  | 5,000件 | O | |

<a id="resource-provision-policy-for-kakaotalk-bizmessage-service"></a>
### KakaoTalk Bizmessageサービスリソース提供ポリシー { #resource-provision-policy-for-kakaotalk-bizmessage-service }
| リソース | 提供基準 | 基本提供量 | 調整の可否 | 最大提供量 |
|----|----|----|----|----|
| お知らせトーク送信件数 |  KakaoTalk Channel 1日毎 | 1,000件 | O | |

<a id="resource-provision-policy-for-face-recognition-service"></a>
### Face Recognitionサービスリソース提供ポリシー { #resource-provision-policy-for-face-recognition-service }
| リソース | 提供基準 | 基本提供量 | 調整の可否 | 最大提供量 |
|----|----|----|----|----|
| グループ数 |  Face Recognitionサービスごと | 5件 | O | |
| グループ 内の顔登録数 |  Face Recognitionサービスグループごと | 100,000件 | O | |

<a id="resource-provision-policy-for-ocr"></a>
### OCRサービスリソース提供ポリシー { #resource-provision-policy-for-ocr }
リソース使用量はリージョンの区別なくプロジェクトごとに計算されます。

| リソース | 提供基準 | 基本提供量 | 調整の可否 | 最大提供量 |
|----|----|----|----|----|
| 身分証分析リクエスト件数 | OCRサービス毎 | 100,000件 | X | |

<a id="resource-provision-policy-for-api-gateway-service"></a>
### API Gatewayサービスリソース提供ポリシー { #resource-provision-policy-for-api-gateway-service }
リソース使用量はプロジェクトごとに計算され、リージョンごとに区分してポリシーが適用されます。

| リソース | 提供基準 | 基本提供量 | 調整の可否 | 最大提供量 |
|----|----|----|----|----|
| API Gatewayサービス | プロジェクト毎 | 10個 | O | |
| ステージ | API Gatewayサービス毎 | 10個 | O | |
| リソースメソッド | API Gatewayサービス毎 | 100個 | O | 300個 |

<a id="resource-provision-policy-for-log-crash-search-service"></a>
### Log & Crash Search サービスリソース提供ポリシー { #resource-provision-policy-for-log-crash-search-service }
リソース使用量はリージョンの区別なくプロジェクトごとに計算されます。

|リソース | 提供基準 | 基本提供量 | 調整の可否 | 最大提供量 |
|----|----|----|----|----|
| ログ(一般ログ、クラッシュログ) 送信数 | 1日 | 20,000,000 件 | O | |
| ログ(一般ログ、クラッシュログ) 容量 | 1件 | 8MB | X | |

<a id="resource-provision-policy-for-dataflow-service"></a>
### DataFlow サービスリソース提供ポリシー { #resource-provision-policy-for-dataflow-service }
リソース使用量はプロジェクトごとに計算され、リージョンごとに区分してポリシーが適用されます。

|リソース | 提供基準 | 基本提供量 | 調整の可否 | 最大提供量 |
|----|----|----|----|----|
| CPU | プロジェクト当たり | 10vCore | O | |
| メモリ | プロジェクト当たり | 20GB | O | |

<a id="resource-provision-policy-for-easyqueue-service"></a>
### EasyQueue サービスリソース提供ポリシー { #resource-provision-policy-for-easyqueue-service }
リソース使用量はプロジェクトごとに計算され、リージョンごとに区分してポリシーが適用されます。

|リソース | 提供基準 | 基本提供量 | 調整の可否 | 最大提供量 |
|----|----|----|----|----|
| トピック数 | プロジェクトごと | 10個 | X | |
| パーティション数 | プロジェクトごと | 64個 | X | |
| パーティション数 | トピックごと | 16個 | X | |

<a id="request-for-capacity-adjustment"></a>
### リソース提供量調整の申請 { #request-for-capacity-adjustment }
※　2020年4月以降、個人のお客様に対しての提供量調整はFloating IPのみ受け付けております。

基本提供量のほかに追加使用を希望する場合はNHN Cloudカスタマーサービス[1:1問い合わせ](https://nhncloud.com/kr/support/inquiry)を通じてお問い合わせください。
申請の際、追加を希望する項目と必要なリソース量を記入いただくと、相談がスムーズです。

お問い合わせ後手続きが完了するまでには2～5日程度要するため、実際必要なタイミングより前もってご相談いただくことをお勧めします。
