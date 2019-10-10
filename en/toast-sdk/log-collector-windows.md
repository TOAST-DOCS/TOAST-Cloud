## TOAST > User Guide for TOAST SDK > TOAST Log & Crash > Windows C++

## Prerequisites

1\. [Install TOAST SDK](./getting-started-windows)
2\. [Enable Log & Crash Search](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/) in [TOAST console](https://console.cloud.toast.com).
3\. [Check AppKey](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/#appkey) in Log & Crash Search.

## Initialize TOAST Logger SDK

Set appkey issued from Log & Crash Search as ProjectKey.

```
...
#include "toast/ToastLogger.h"

using namespace toast::logger;
...

ToastLogger* logger = GetToastLogger();

ToastLoggerConfiguration* loggerConf = GetToastLoggerConfiguration();
...
loggerConf->setProjectKey(appkey);
loggerConf->setProjectVersion(version);
...

if (_logger != NULL)
{
    if (_logger->initialize(loggerConf))
	{
		// success
	}
	else
	{
		// fail
	}
}
```

## TOAST Logger SDK 종료

```
DestroyToastLogger();
```

## Set UserID 

User ID can be set for TOAST SDK.
Such set UserID is common for each module of TOAST SDK. 
Set User ID is sent to server, along with logs, every time Log Sending API is called. 


```

ToastLogger* _logger = GetToastLogger();

_logger->setUserId("userId");

_logger->initialize(loggerConf);

_logger->getUserId();
```

* setUserId
    * Set a user ID. 
* getUserId
    * Get user ID of current setting. 

## Send Logs 

TOAST Logger provides log sending functions of five levels. 

### Send Logs  

```
// General logs
_logger->log(level, message, _userFieldMap);

// DEBUG level logs
_logger->debug(level, message, _userFieldMap);

// INFO level logs
_logger->info(level, message, _userFieldMap);

// WARN level logs
_logger->warn(String message);

// ERROR level logs
_logger->error(String message);

// FATAL level logs
_logger->fatal(String message);
```

## Add User-Defined Fields 

```

ToastLoggerUserFields* _userFieldMap = CreateToastLoggerUserFields();

_userFieldMap->insert(key, value);

if (_userFieldMap != NULL)
{
    if (_userFieldMap->size() > 0)
    {
        _logger->log(level, message, _userFieldMap);
    }
    else
    {
        _logger->log(level, message);
    }
}
```

* User-defined fields contain field information as wanted and are applied only to particular logs.
* ToastLoggerUserFields support the following functions: 
    * insert:  Insert data
    * erase: Delete data
    * clear: Delete all 
    * size: Size 
    * find: Search data
    * empty: Whether it is empty 
* User-defined field is same as the value exposed as "Selected Field"in "Log & Crash Search Console" > "Log Search Tab". 
  That is, it is same as custom parameter of Log & Crash Search, and you can find more details on restrictions of "field" value in [Restrictions of Custom Field](http://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/api-guide/).

#### Restrictions for User-Defined Fields

- Cannot use already [Reserved Fields](./log-collector-reserved-fields).  
  Check reserved fields at "Basic Parameters" from [Restrictions of User-Defined Fields](http://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/api-guide/).
- Use characters from "A-Z, a-z, 0-9, -, and _" for a field name, starting with "A-Z, or a-z". 
- Replace spaces within a field name by "_". 

### Usage Example of addUserField / removeUserFiled / cleareUserField 

```
_logger->addUserField("nickname", "randy");
_logger->removeUserField("nickname");
_logger->cleareUserField();
```

## Collect Crash Logs 

Crash reporter (CrashRepoter.exe) sends crash log information to logs. 
Crash information is sent to logs through crash reporter, when a crash occurs. 
Crash reporter can be enabled along with ToastLogger initialization, by setting. 
It is also available to enable crash reporter dialogue box and custom messages.  


### Enable Crash Logs and Crash Reporter  

```
...
#include "toast/ToastLogger.h"

using namespace toast::logger;
...

ToastLogger* _logger = GetToastLogger();

ToastLoggerConfiguration* loggerConf = GetToastLoggerConfiguration();
...
// Whether to enable crash logs 
loggerConf->enableCrashReporter(true);	
// Whether to enable crash reporter dialogue 
loggerConf->enableSilenceMode(false);	
// Define messages for crash reporter dialogue 
// (If not defined, default message shows.)
loggerConf->setCrashReporterMessage(TOAST_LANGUAGE_KOREAN, "Error has occurred...\n");
...

if (_logger != NULL)
{
    bool bInit = _logger->initialize(loggerConf);
	
	// x86에서 pure virtual call / invalid paramenter 크래시 로그 추가	
	if (bInit && enableCrashReport)
	{
#ifndef _WIN64
		SetCrashHandler();
#endif
	}
}
```

###  Test Sending Crash Logs  

* To test on crash logs sending, an exception must occur. 
* Crash logs are automatically sent by SDK when enableCrashReporter is true.

```

void CsampleDlg::OnBnClickedCrash()
{
    // TODO: Add your control notification handler code here
    int *i = reinterpret_cast<int*>(0x45);
    *i = 5;
}
```

### Interpret Crash Logs 

#### Overview

* To interpret crashes occurred in TOAST Windows SDK, a symbol file must be created and uploaded to a web console. 

#### Create Symbol Files 

* Creating a symbol file requires dump_syms appropriate for each development environment. 
    * [dump\_syms\_vc1600 : vs2010](http://static.toastoven.net/toastcloud/tools/dump_syms_vc1600.zip)
    * [dump\_syms\_vc1700 : vs2012](http://static.toastoven.net/toastcloud/tools/dump_syms_vc1700.zip)
    * [dump\_syms\_vc1800 : vs2013](http://static.toastoven.net/toastcloud/tools/dump_syms_vc1800.zip)
    * [dump\_syms\_vc1900 : vs2015](http://static.toastoven.net/toastcloud/tools/dump_syms_vc1900.zip)
* Execute a order prompt to create sym files, like below: 
    * The sample project is called sample. 

```
dump_syms sample.pdb > sample.sym
```

* Then, compress sample.sym with zip and [Upload to Console Server](https://alpha-docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/#_25)
    * The version for console uploads must be the same as the version for setProjectVersion. 



