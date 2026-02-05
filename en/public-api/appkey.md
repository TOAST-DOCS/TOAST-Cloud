# Appkey
**NHN Cloud > Public API > API Authentication Method > Appkey**

An Appkey is a unique authentication key issued for each NHN Cloud service, used to identify the service and validate API requests. The authentication process is simplified as it only requires an Appkey in the API request, eliminating the need for separate user registration, token requests, or renewal procedures.

## View Appkey
Appkeys are issued per service and can be found on each service screen in the NHN Cloud console.
This document uses the Instance service's console screen as an example.

1) In the NHN Cloud console, click **URL & Appkey** in the upper right corner of each service screen.<br>
![C_Appkey_1_en](http://static.toastoven.net/toast/public_api/C_Appkey_1_en.png)

2) **URL & Appkey - {Service name}** In the modal window, view or copy the Appkey , then click **OK**.<br>
![C_Appkey_2_en](http://static.toastoven.net/toast/public_api/C_Appkey_2_en.png)


!!! danger "Caution"
    If your Appkey has been leaked or you suspect unauthorized access, please request a reissuance by going to [Customer Support > Contact Us](https://www.nhncloud.com/kr/support/inquiry) and selecting **{Service Name}/Others** as the **Inquiry Type**.


## View SecretKey
Some NHN Cloud services support SecretKey for access control to APIs.
Like Appkeys, Secret Keys can be found on the dashboard of any service that supports this feature.
In this guide, we use the CDN service's console screen as an example.

1) In the NHN Cloud Console, click **URL & Appkey** in the upper right corner of the Service screen.<br>
![C_SecretKey_1_en](http://static.toastoven.net/toast/public_api/C_SecretKey_1_en.png)

2) **URL & Appkey - {ServiceName}** Copy the SecretKey from the modal window, then click **OK**.<br>
![C_SecretKey_2_en](http://static.toastoven.net/toast/public_api/C_SecretKey_2_en.png)


## Making API Calls
### Appkey
Appkeys are included as either path parameters or in HTTP headers, depending on the service. Please refer to each service's API guide for the specific path format or HTTP header field names required.

#### Path Parameter Method
A method where the Appkey is included as part of the API request URL path.

* Example
```
POST /v1.0/appkeys/{appKey}/
```

#### HTTP Header-based Authentication
A method that validates service requests by including the Appkey in the request header.

* Example
```
X-TC-APP-KEY: {Appkey}
```


!!! danger "Caution"
Appkeys are static keys with no expiration and no built-in authorization features. If a key is exposed, it could lead to unauthorized API calls. Store your keys securely and ensure they are never included in source code or public repositories. If you suspect a leak, you must request a reissuance immediately. You can request a reissuance by navigating to [Customer Support > Contact Us](https://www.nhncloud.com/kr/support/inquiry) and selecting **{Service Name}/Others** as the **Inquiry Type**.


### SecretKey
SecretKeys are used for access control in API requests, and their implementation may vary depending on the service. Please refer to each service's API guide for the specific HTTP header field names required.

#### HTTP Header-based Authentication
A method that validates the service request by including the Secret Key in the request header.

* Example
```
X-SECRET-KEY: {Secretkey}
```
