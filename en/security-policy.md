## NHN Cloud > Security Policy 

NHN Cloud guides for security products, security policy, and vulnerability information, to provide safer security environment.
Security policy is provided as below, to protect customer's resources from new and various types of attacks and security vulnerabilities, and prepare against frequent accidents and threats in the cloud.

## Password Policy 
To set passwords for user accounts (both root and general accounts), general passwords that are easy to guess may be cracked by unauthorized users and obtain role for general or root accounts and access systems. As this may result in the leakage of important data saved in the server or abused as hackers' stop, a safe password must be set and managed. .

### Safe Passwords
Must be comprised of 8 or more characters, in combination of alphabets, numbers, and special characters. Following passwords should be avoided as they are easy to guess: 

- null Passwords
- Comprised only of characters or numbers 
- Same as user ID 
- 4 or more consecutive letters or numbers (for example, 1111, 1234, abcd, etc.)
- Periodic reuses 
- Composed of phone number, birthday, account name, or host name, which are easy to guess 

### NHN Cloud Password Policy 
To protect customer's resources and services, NHN Cloud applies the following as the basic password policy.

- Combined with three types: Alphabets, Numbers, and Special Characters
- Has more than 8 characters

## Anti-DRDoS Policy
Instances exposed to external networks may be abused as stops for Distributed Reflection Denial of Service, or DRDoS attacks, causing service failure or unintentional traffic charges due to abnormal increase in outbound traffic. 

### What is DRDoS (Distributed Reflection Denial of Service)?
DRDoS occurs due to vulnerable settings of applications, such as DNS, NTP, SSDP, or Memcached. This bandwidth amplifying attack technique is widely used for recent hackings, as it creates a large response packet with small request packets by using a number of zombie computers, and causes traffic to be concentrated at a target server.

### Anti-NHN Cloud DRDoS Port Policy
To protect customer's resources and services, NHN Cloud blocks UDP ports which are frequently abused as stops for DRDoS attacks..

### List of Blocked Ports
|Service Name |  Blocked Port  | Blocking Method |Reference|
| ---- | ---- | ---- | ---- |
|Chargen | UDP / 19    | Network ACL | Inaccessible from outside |
|SSDP    | UDP / 1900  | Network ACL | Inaccessible from outside |
|Memcached   | UDP / 11211 | Network ACL | Inaccessible from outside |


## Internet Port Blocking Policy (Inbound) 
To protect customer service, the block-intrusion system is provided as well as security group which is managed under the control of customers.

### NHN Cloud List of Blocked Ports 
|Region | Service Name | Blocked Port | Blocking Method | Remarks |
| ---- | ---- | ---- | ---- | ---- |
| Korea (Pangyo/Pyeongchon) <br> Japan (Tokyo) <br> US (California) | System Terminal Port | TCP/23 | Blocked by network ACLs | Externally inaccessible |

### NHN Cloud(Cloud for public agencies) List of Blocked Ports
|Service Name | Blocked Port | Blocking Method | Remarks|
| ---- | ---- | ---- | ---- |
| System Terminal Port | TCP/22, 23, 3389 | Blocked by network ACLs | Externally inaccessible|
| DBMS Port | TCP, UDP/1433(MS-SQL), 1521(Oracle), 3306(MySQL)  | Blocked by network ACLs | Externally inaccessible|
| Netbios Port | TCP, UDP/135, 137, 138, 139, 445 | Blocked by network ACLs | Externally inaccessible |
| Etc. | TCP/21(FTP), TCP / 5900(VNC) | Blocked by network ACLs | Externally inaccessible |

### How to Apply for More Ports
- Download the excel file below and fill in the form.

[![](https://static.toastoven.net/prod_gov_security/fileicon_download_excel.png)](https://static.toastoven.net/prod_gov_security/Application%20for%20Exception%20from%20NHN%20Cloud%20Firewall%20and%20SSL%20VPN%20Policy_Agency%20Name.xlsx)

- Save file name as “Application for Exception from NHN Cloud Firewall and SSL VPN Policy_JP-Agency Name.xlsx”.
- Submit your inquiry with a file attached via [1:1 Inquiry](https://www.beta-nhncloud.com/kr/support/inquiry?alias=tab3_08) from NHN Cloud (for government agencies). (Processed and replied within 3 days from the date of receipt)