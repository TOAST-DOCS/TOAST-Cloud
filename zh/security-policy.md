## NHN Cloud > 安全策略

NHN Cloud通过提供安全服务、安全策略、漏洞信息等内容，为客户创造更安全的安全环境。
为保护客户资产免受各种新型攻击技术和安全漏洞的影响，我们提供如下可防范云环境中常见的安全事件及威胁的安全策略。

## 密码策略
用户设置账号（root及一般账号）密码时，若设置易猜测的密码，未经授权的用户可通过猜测密码获取一般账号或root权限，访问系统。这会导致服务器中保存的重要数据泄露或被恶意利用为黑客入侵的中转服务器，因此应设置安全的密码并进行管理。

### 何为安全的密码
由8位以上的英文字母、数字、特殊字符组合构成。不应使用如下可猜测密码。

- null密码
- 仅由字符和数字组成
- 与用户ID相同的密码
- 连续字符或数字（例：1111, 1234, adcd等）
- 定期重新使用密码
- 如电话号码、生日、账号名、主机名等易猜测的密码

### NHN Cloud密码策略
为保护客户宝贵的资产和服务，NHN Cloud默认应用如下密码政策。

- 英文、数字、特殊字符3种组合
- 最少8位以上

## DRDoS攻击阻断策略
若面向外部网络开放的实例被恶意利用为DRDoS入侵的中转站，输出流量会异常增加，这可能导致服务故障或意外的流量计费。

### 什么是DRDoS（Distributed Reflect DoS，分布式反射拒绝服务）？
DRDoS是由DNS, NTP, SSDP, Memcached等应用程序中薄弱的设置导致的。使用大量的僵尸PC，把小型请求数据包做成大型响应数据包，可以使流量集中于目标服务器，因此是最近黑客入侵中常用的带宽渗透性入侵技术。

### NHN Cloud DRDoS端口阻断策略
为保护客户宝贵的资产和服务，NHN Cloud对常被恶意用作DRDoS入侵中转站的UDP端口实施阻断策略。

### 阻断端口列表
| 服务名 | 阻断端口 | 阻断方法 | 备注 |
| ---- | ---- | ---- | ---- |
| Chargen | UDP / 19 | 应用Network ACL阻断 | 外部无法访问 |
| SSDP | UDP / 1900 | 应用Network ACL阻断 | 外部无法访问| 
| Memcached | UDP / 11211 | 应用Network ACL阻断 | 外部无法访问 |

### List of Blocked Internet Ports

#### List of Blocked Internet Ports (NHN Cloud)
| Region |Service Name |  Blocked Port  | Blocking Method |Reference|
| ---- | ---- | ---- | ---- | ---- |
| KOREA(Pangyo/Pyeongchon) <br> JAPAN(Tokyo) <br> USA(California) | System Terminal port | TCP / 23    | Network ACL | Inaccessible from outside |

#### List of Blocked Internet Ports (TOAST G)
|Service Name |  Blocked Port  | Blocking Method |Reference|
| ---- | ---- | ---- | ---- |
| System Terminal port | TCP / 22, 23, 3389 | Network ACL | Inaccessible from outside | 
| DBMS Port | TCP, UDP / 1433(MS-SQL), 1521(Oracle), 3306(MySQL) | Network ACL | Inaccessible from outside | 
| Netbios Port | TCP, UDP / 135, 137, 138, 139, 445 | Network ACL | Inaccessible from outside | 
| etc | TCP / 21(FTP), TCP / 5900(VNC) | Network ACL | Inaccessible from outside | 


### How to Apply for More Ports
- Download the excel file below and fill in the form.

[![](https://static.toastoven.net/prod_gov_security/img_04.png)](https://static.toastoven.net/prod_gov_security/Application%20for%20Exception%20from%20NHN%20Cloud%20Firewall%20and%20SSL%20VPN%20Policy_Agency%20Name.xlsx)

- Save file name as “Application for Exception from NHN Cloud Firewall and SSL VPN Policy_JP-Agency Name.xlsx”.
Send the application over the email like below (to be processed and replied within 3 days after received). 
    - NHN Cloud : support@toast.com
    - TOAST G : support@gov.toast.com
