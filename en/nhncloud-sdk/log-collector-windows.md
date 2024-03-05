## NHN Cloud > SDK User Guide > Log & Crash > Windows C++

## Prerequisites

1. [Install NHN Cloud SDK](./getting-started-windows)
2. [Enable Log & Crash Search](https://docs.nhncloud.com/en/Data%20&%20Analytics/Log%20&%20Crash%20Search/en/console-guide/) in [NHN Cloud console](https://console.nhncloud.com).
3. [Check AppKey](https://docs.nhncloud.com/en/Data%20&%20Analytics/Log%20&%20Crash%20Search/en/console-guide/#appkey) in Log & Crash Search.

## Initialize NHN Cloud Logger SDK

Set Appkey issued from Log & Crash Search as ProjectKey.


```cpp
...
#include "NHNCloudLogger.h"

nhncloud::logger::NHNCloudLogger* g_nhncloud_lnc = nullptr; // NHN Cloud SDK - Log & crash search
...

// Assign the NHN Cloud SDK instance to a global variable.
g_nhncloud_lnc = nhncloud::logger::NHNCloudLogger::GetInstance();

// When initializing NHNCloudLogger, input necessary configuration information.
nhncloud::logger::NHNCloudLoggerConfiguration* loggerConf = nhncloud::logger::NHNCloudLoggerConfiguration::GetInstance();

...
// Input the Appkey you checked in the Log & Crash Search console.
loggerConf->setProjectKey(appkey);

// Input the version information of the current application. The version information must match the version 
loggerConf->setProjectVersion(version);
...

if (!g_nhncloud_lnc->initialize(loggerConf))
{
	// Initialization failure occurs if it has already been initialized or if the AppKey is not inputted.
	::MessageBox(g_mainWnd, _T("Failed to initialize NHN Cloud SDK."), _T("Alert"), MB_OK);
	return false;
}

```

## Set UserID

User ID can be set for NHN Cloud SDK.
Such set UserID is common for each module of NHN Cloud SDK.
Set User ID is sent to server, along with logs, every time Log Sending API is called.

```cpp
    nhncloud::logger::NHNCloudLogger* pLogger = nhncloud::logger::NHNCloudLogger::GetInstance();
    pLogger->setUserId(pUserID);
    pLogger->getUserId();
```

* setUserId
    * Set a user ID.
* getUserId
    * Get user ID of current setting.

## Send Logs

NHN Cloud Logger provides log sending functions of five levels.

### Send Logs
* Send logs of DEBUG, INFO, WARN, ERROR, FATAL levels explicitly
    * Both of char*, wchar_t* types are supported.
    * userFields is a helper class to make it easier to use the user-defined fields.
```cpp
void debug(const wchar_t* message, NHNCloudLoggerUserFields* userFields = NULL);
void info(const wchar_t* message, NHNCloudLoggerUserFields* userFields = NULL);
void warn(const wchar_t* message, NHNCloudLoggerUserFields* userFields = NULL);
void error(const wchar_t* message, NHNCloudLoggerUserFields* userFields = NULL);
void fatal(const wchar_t* message, NHNCloudLoggerUserFields* userFields = NULL);
```
* Send the log level and message explicitly
```cpp
void log(NHNCLOUD_LOGGER_LEVEL logLevel, const char* message, NHNCloudLoggerUserFields* userFields = nullptr);
```

## Add User-Defined Fields
### Method 1: Use the NHNCloudLogger instance API

* A user-defined field that is managed directly by the NHNCloudLogger instance.

```cpp
bool addUserField(const char* key, const wchar_t* value);
void removeUserField(const char* key);
void clearUserFileds();
...

g_nhncloud_lnc->addUserField("nickname", "randy");
g_nhncloud_lnc->removeUserField("nickname");
g_nhncloud_lnc->cleareUserField();

```

### Method 2 : Use the NHNCloudLoggerUserFields class

```cpp
nhncloud::logger::NHNCloudLoggerUserFields* pUserFieldHelper = nhncloud::logger::NHNCloudLoggerUserFields::GetInstance(); // Get the custom field helper class.

pUserFieldHelper->insert("userCustomKeyHelper01", L"NHNCloudLoggerUserFields 헬퍼 클래스로 추가한 사용자 정의 필드\r\nCustom fields added with the NHNCloudLoggerUserFields helper class");
pUserFieldHelper->insert("userCustomKeyHelper02", L"clear() 함수로 지금껏 정의한 사용자 필드를 간단히 정리할 수 있어요.\r\nWith the clear() function, you can simply clear the custom fields you have defined so far.");
pUserFieldHelper->insert("userCustomKeyHelper03", L"log() 함수로 전송시, NHNCloudLoggerUserFields 클래스에 정의한 사용자 필드들은 로그 객체에 복사됩니다.\r\nWhen sending to the log() function, the user fields defined in the NHNCloudLoggerUserFields class are copied to the log object.");

g_nhncloud_lnc->log(level, pLogMessage, pUserFieldHelper);	 // Send log with user-defined fields.

pUserFieldHelper->clear(); // Delete all user-defined fields configured above.

```

*  User-defined field is same as the value exposed as "Selected Field" in "Log & Crash Search Console" > "Log Search Tab".

#### Restrictions for User-Defined Fields

* Cannot use already [Reserved Fields](./log-collector-reserved-fields).
* Use characters from "A-Z, a-z, 0-9, -, and _" for a field name, starting with "A-Z, or a-z".
* Replace spaces within a field name by "_".


## Collect Crash Logs
* When a crash occurs, the default behavior is to send a crash dump from the executable file including the SDK.
* When a crash occurs, you can expose an error screen to the user and collect additional information.

### Crash Log Collection and Configuration

```cpp

#include "NHNCloudLogger.h"

nhncloud::logger::NHNCloudLogger* g_nhncloud_lnc = nullptr;  // NHN Cloud SDK - Log & crash search
...

// Assign the NHN Cloud SDK instance to a global variable.
g_nhncloud_lnc = nhncloud::logger::NHNCloudLogger::GetInstance();

// When initializing NHNCloudLogger, input necessary configuration information.
nhncloud::logger::NHNCloudLoggerConfiguration* loggerConf = nhncloud::logger::NHNCloudLoggerConfiguration::GetInstance();

...
// Input the AppKey you checked in the Log & Crash Search console.
loggerConf->setProjectKey(appkey);

// Input the version information of the current application. The version information must match the version information inputted during the symbol file registration.
loggerConf->setProjectVersion(version);

// Enable Crash Collection - This is enabled by default. Set to false if you don't want crash collection.
loggerConf->enableCrashReporter(true);

// To use Crash Reporter (CrashReporter.exe) running as a separate process, set enableSilenceMode(false).
loggerConf->enableSilenceMode(false);

// Defines the message to be exposed to the CrashReporter running as a separate process. If not defined, the default message will be shown.
loggerConf->setCrashReporterMessage(NHNCLOUD_LANGUAGE_KOREAN, "An error has occurred...\n");

// If you want to send the crash as a separate process, but do not want to expose the UI to the user, set exposeExternalCrashReporterUI(false).
//loggerConf->exposeExternalCrashReporterUI(false);
...

// After initialization is complete, crash collection becomes available.
if (!g_nhncloud_lnc->initialize(loggerConf))
{
	// Initialization fails if it has already been initialized, or if no Appkey has been entered.
	::MessageBox(g_mainWnd, _T("Failed to initialize NHN Cloud SDK."), _T("Alert"), MB_OK);
	return false;
}

```

###  Test Sending Crash Logs

* To test on crash logs sending, an exception must occur.
* Crash logs are automatically sent by SDK when enableCrashReporter is true.
* Access Violation Example
```cpp

void CsampleDlg::OnBnClickedCrash()
{
    // TODO: Add your control notification handler code here
    int *i = reinterpret_cast<int*>(0x45);
    *i = 5;
}
```

### Interpret Crash Logs

To interpret crashes occurred in NHN Cloud Windows SDK, a symbol file must be created and uploaded to a web console.

#### Create Symbol Files

* To create a symbol file, you must use dump_syms.exe in the path of the distribution file.
* For an easier example, refer to the post-build event of the `nhncloudsdk_example` example project in the distribution file path.
* Run the command prompt to create a .sym file in the following way.
    * sample is the name of the example project.

```
dump_syms sample.pdb > sample.sym
```

* Then, compress sample.sym with zip and [Upload to Console Server](https://docs.nhncloud.com/en/Data%20&%20Analytics/Log%20&%20Crash%20Search/en/console-guide/#symbol-file)
    * The version for console uploads must be the same as the version for setProjectVersion.
