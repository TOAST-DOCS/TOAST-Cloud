# Project Integrated Appkey
**NHN Cloud > Public API User Guide > API Authentication Method > Project Integrated Appkey**

Project Integrated Appkey is a common authentication key that can be used across multiple services within a single NHN Cloud project. Instead of managing individual keys for each service, a single integrated key allows you to efficiently call APIs for all services active in that project. This reduces the number of keys to manage and provides flexibility and efficiency by allowing users to create or delete Appkeys directly

## Create a Project Integrated Appkey
You can create and manage Project Integrated Appkeys from each project screen in the NHN Cloud console.

1) In the NHN Cloud console, select a project and click **Project Management** tab.

2) In **API Security Settings**, click **+ Generate Appkey**.<br>
![C_project_API_security_en](http://static.toastoven.net/toast/public_api/C_project_API_security_en.png)

3) In the **Create Appkey** modal window, in the Enter **Appkey** name field, type a name for the project integrated Appkey you want to create , and thenclick **OK**.<br>
![C_project_API_security_2_en](http://static.toastoven.net/toast/public_api/C_project_API_security_2_en.png)


!!! danger "Caution"
    If a Project Integrated Appkey is exposed, unauthorized API calls can be made to all services within the project. Therefore, strict security management is required. Avoid embedding the key in code or public repositories. If a leak is suspected, immediately delete the compromised key and replace it with a newly generated one.


!!! tip "Note"
    * Project Integrated Appkey is not supported by all Public APIs. Even when using the same X-TC-APP-KEY header, some APIs only support service-specific Appkeys, meaning the Project Integrated Appkey may not be applicable. Please refer to the specific API guide to confirm support.
    * You can create a maximum of three Project Integrated Appkeys per project.


## Making API Calls
Project Integrated Appkey is passed via the HTTP request header. When calling an API, include the Project Integrated Appkey in the request header as shown in the example below.

* HTTP header format examples
```
X-TC-APP-KEY: {project integrated Appkey}
```

When a user sends a request with a key in the HTTP header, the server validates the key and then approves or rejects the request.
