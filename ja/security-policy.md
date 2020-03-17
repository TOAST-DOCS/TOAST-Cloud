## TOAST > TOASTセキュリティーポリシー

TOASTはより安全なセキュリティー環境を提供するため、セキュリティーサービス、セキュリティーポリシー、脆弱性情報などを案内しています。
多様な新しい攻撃技法とセキュリティー脆弱性から顧客の資産を守るため、クラウド環境で頻繁に発生するセキュリティー事故および脅威に備えられる下記のセキュリティーポリシーを提供します。

## パスワードポリシー
ユーザーアカウント(rootおよびすべての一般アカウント)パスワード設定時、一般的に推測しやすいパスワードを設定すると、悪意を持つユーザーがパスワード代入攻撃により、一般アカウントまたはroot権限を獲得してシステムにアクセスできます。これによりサーバーに保存された重要なデータが流出したり、ハッキング経由地サーバーに悪用される場合があるので、安全なパスワードを設定して管理する必要があります。

### 安全なパスワードとは
アルファベット、数字、特殊文字を組み合わせて8文字以上で構成します。次のように推測できるパスワードを使用してはいけません。

- nullパスワード
- アルファベットまたは数字のみで構成
- ユーザーIDと同じパスワード
- 連続した文字や数字(例： 1111、1234、abcd など)
- 周期的にパスワードを再使用
- 電話番号、誕生日、アカウント名、ホスト名など、推測しやすいパスワード

### TOASTパスワードポリシー
TOASTは顧客の大切な資産とサービスを保護するために、下記のパスワードポリシーを基本適用します。

- アルファベット、数字、特殊文字の3種類を組み合わせる
- 8文字以上

## DRDoS攻撃遮断ポリシー
外部ネットワークにオープンされたインスタンスがDRDoS攻撃の経由地に悪用される場合、 アウトバウンドトラフィックの異常な増加によりサービス障害や意図せぬトラフィック課金が発生する場合があります。

### DRDoS(Distributed Reflect DoS、Dosリフレクション攻撃)とは？
DRDoSはDNS、NTP、SSDP、Memcachedなど、 アプリケーションの設定の脆弱性により発生します。 多数のゾンビコンピューターを利用して小さな要請パケットで大きなレスポンスパケットを作り、対象サーバーにトラフィックを集中させることができるため、最近ハッキング攻撃で多用されている帯域幅侵食型攻撃技法です。

### TOAST DRDoSポート遮断ポリシー
TOASTは顧客の大切な資産とサービスを保護するために、DRDoS攻撃の経由地に頻繁に悪用されるUDPポートに対する遮断ポリシーを適用しています。

### 遮断ポートリスト
| サービス名 |  遮断ポート | 遮断方法 | 備考 |
| ---- | ---- | ---- | ---- |
| Chargen | UDP / 19    | Network ACL遮断適用 |   外部から接続不可 |
| SSDP    | UDP / 1900  | Network ACL遮断適用 | 外部から接続不可 |
| Memcached   | UDP / 11211 | Network ACL遮断適用 | 外部から接続不可 |

### List of Blocked Internet Ports

#### List of Blocked Internet Ports (TOAST)
| Region |Service Name |  Blocked Port  | Blocking Method |Reference|
| ---- | ---- | ---- | ---- | ---- |
| KOREA(Pangyo) <br> JAPAN(Tokyo) <br> USA(California) | System Terminal port | TCP / 23    | Network ACL | Inaccessible from outside |

#### List of Blocked Internet Ports (TOAST G)
|Service Name |  Blocked Port  | Blocking Method |Reference|
| ---- | ---- | ---- | ---- |
| System Terminal port | TCP / 22, 23, 3389 | Network ACL | Inaccessible from outside | 
| DBMS Port | TCP, UDP / 1433(MS-SQL), 1521(Oracle), 3306(MySQL) | Network ACL | Inaccessible from outside | 
| Netbios Port | TCP, UDP / 135, 137, 138, 139, 445 | Network ACL | Inaccessible from outside | 
| etc | TCP / 21(FTP), TCP / 5900(VNC) | Network ACL | Inaccessible from outside | 

ポート遮断ポリシーの詳細については、カスタマーセンターまでお問い合わせください。
