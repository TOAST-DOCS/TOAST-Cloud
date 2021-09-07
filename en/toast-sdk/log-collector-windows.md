## TOAST > User Guide for TOAST SDK > TOAST Log & Crash > Windows C++

## Prerequisites

1. [Install TOAST SDK](./getting-started-windows)
2. [Enable Log & Crash Search](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/) in [TOAST console](https://console.cloud.toast.com).
3. [Check AppKey](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/#appkey) in Log & Crash Search.

## Initialize TOAST Logger SDK

Set appkey issued from Log & Crash Search as ProjectKey.

```
...
#include "toast/ToastLogger.h"

toast::logger::ToastLogger* g_nhncloud_lnc = nullptr;  // NHN Cloud SDK - Log & crash search
...

// 전역 변수에 NHN Cloud SDK 인스턴스를 할당합니다.
g_nhncloud_lnc = toast::logger::ToastLogger::GetInstance();

// ToastLogger를 초기화 할 때, 필요한 설정 정보를 입력합니다.
toast::logger::ToastLoggerConfiguration* loggerConf = toast::logger::ToastLoggerConfiguration::GetInstance();

...
// Log & Crash Search 콘솔에서 확인한 앱키를 입력합니다.
loggerConf->setProjectKey(appkey);

// 현재 어플리케이션의 버전 정보를 입력합니다. 버전 정보는 심볼 파일 등록하는 과정에서 입력하는 버전 정보와 일치해야 합니다.
loggerConf->setProjectVersion(version);
...

if (!g_nhncloud_lnc->initialize(loggerConf))
{
	// 초기화가 실패하는 경우는 이미 초기화 되었거나, 앱키를 입력하지 않은 경우에 발생합니다.
	::MessageBox(g_mainWnd, _T("Failed to initialize NHN Cloud SDK."), _T("Alert"), MB_OK);
	return false;
}

```

## Set UserID

User ID can be set for TOAST SDK.
Such set UserID is common for each module of TOAST SDK.
Set User ID is sent to server, along with logs, every time Log Sending API is called.

```
    toast::logger::ToastLogger* pLogger = toast::logger::ToastLogger::GetInstance();
    pLogger->setUserId(pUserID);
```

* setUserId
    * Set a user ID.
* getUserId
    * Get user ID of current setting.

## Send Logs

TOAST Logger provides log sending functions of five levels.

### Send Logs
* DEBUG, INFO, WARN, ERROR, FATAL 레벨의 로그를 명시적으로 전송
	* char*, wchar_t* 형을 모두 지원합니다.
	* userFields는 사용자 정의 필드를 좀 더 쉽게 사용하기 위한 헬퍼 클래스입니다.
```
void debug(const wchar_t* message, ToastLoggerUserFields* userFields = NULL);
void info(const wchar_t* message, ToastLoggerUserFields* userFields = NULL);
void warn(const wchar_t* message, ToastLoggerUserFields* userFields = NULL);
void error(const wchar_t* message, ToastLoggerUserFields* userFields = NULL);
void fatal(const wchar_t* message, ToastLoggerUserFields* userFields = NULL);
```
* 로그 레벨과, 메시지를 명시적으로 전송
```
void log(TOAST_LOGGER_LEVEL logLevel, const wchar_t* message, ToastLoggerUserFields* userFields = nullptr);
```

## Add User-Defined Fields
### 방법 1 : ToastLogger 인스턴스 API 사용

* ToastLogger 인스턴스에서 직접 관리하는 사용자 정의 필드입니다.

```
bool addUserField(const char* key, const wchar_t* value);
void removeUserField(const char* key);
void clearUserFileds();

...

g_nhncloud_lnc->addUserField("nickname", "randy");
g_nhncloud_lnc->removeUserField("nickname");
g_nhncloud_lnc->cleareUserField();

```

### 방법 2 : ToastLoggerUserFields 클래스 사용

```
toast::logger::ToastLoggerUserFields* pUserFieldHelper = toast::logger::ToastLoggerUserFields::GetInstance();	// 사용자 정의 필드 헬퍼 클래스를 얻어옵니다.

pUserFieldHelper->insert("userCustomKeyHelper01", L"ToastLoggerUserFields 헬퍼 클래스로 추가한 사용자 정의 필드\r\nCustom fields added with the ToastLoggerUserFields helper class");
pUserFieldHelper->insert("userCustomKeyHelper02", L"clear() 함수로 지금껏 정의한 사용자 필드를 간단히 정리할 수 있어요.\r\nWith the clear() function, you can simply clear the custom fields you have defined so far.");
pUserFieldHelper->insert("userCustomKeyHelper03", L"log() 함수로 전송시, ToastLoggerUserFields 클래스에 정의한 사용자 필드들은 로그 객체에 복사됩니다.\r\nWhen sending to the log() function, the user fields defined in the ToastLoggerUserFields class are copied to the log object.");

g_nhncloud_lnc->log(level, pLogMessage, pUserFieldHelper);	// 사용자 정의 필드와 함께 로그를 전송합니다.

pUserFieldHelper->clear(); // 위에서 설정한 사용자 정의 필드를 모두 삭제합니다.

```

* User-defined field is same as the value exposed as "Selected Field" in "Log & Crash Search Console" > "Log Search Tab".

#### Restrictions for User-Defined Fields

- Cannot use already [Reserved Fields](./log-collector-reserved-fields).
- Use characters from "A-Z, a-z, 0-9, -, and _" for a field name, starting with "A-Z, or a-z".
- Replace spaces within a field name by "_".

## Collect Crash Logs

* 크래시가 발생하면, SDK를 포함한 실행 파일에서 크래시 덤프를 전송하는 것이 기본동작입니다.
* 크래시 발생시 사용자에 오류 화면을 노출하고 추가 정보를 수집할 수 있습니다.

### 크래시 로그 수집과 환경 설정

```

#include "toast/ToastLogger.h"

toast::logger::ToastLogger* g_nhncloud_lnc = nullptr;  // NHN Cloud SDK - Log & crash search
...

// 전역 변수에 NHN Cloud SDK 인스턴스를 할당합니다.
g_nhncloud_lnc = toast::logger::ToastLogger::GetInstance();

// ToastLogger를 초기화 할 때, 필요한 설정 정보를 입력합니다.
toast::logger::ToastLoggerConfiguration* loggerConf = toast::logger::ToastLoggerConfiguration::GetInstance();

...
// Log & Crash Search 콘솔에서 확인한 앱키를 입력합니다.
loggerConf->setProjectKey(appkey);

// 현재 어플리케이션의 버전 정보를 입력합니다. 버전 정보는 심볼 파일 등록하는 과정에서 입력하는 버전 정보와 일치해야 합니다.
loggerConf->setProjectVersion(version);

// 크래시 수집 활성화 - 기본적으로 활성화 상태입니다. 크래시 수집을 원하지 않는다면 false로 설정합니다.
loggerConf->enableCrashReporter(true);

// 별도의 프로세스로 동작하는 크래시 리포터(CrashReporter.exe)를 사용하기 위해서는, enableSilenceMode(false)로 설정합니다.
loggerConf->enableSilenceMode(false);

// 별도의 프로세스로 동작하는 크래시 리포터에 노출할 메시지를 정의합니다. 정의하지 않으면 기본 메시지가 보이게 됩니다.
loggerConf->setCrashReporterMessage(TOAST_LANGUAGE_KOREAN, "오류가 발생한 상황...\n");

// 별도의 프로세스로 크래시를 전송하지만, 사용자에 UI를 노출하고 싶지 않을경우는 exposeExternalCrashReporterUI(false)로 설정합니다.
//loggerConf->exposeExternalCrashReporterUI(false);
...

// 초기화가 끝나면, 크래시 수집이 가능합니다.
if (!g_nhncloud_lnc->initialize(loggerConf))
{
	// 초기화가 실패하는 경우는 이미 초기화 되었거나, 앱키를 입력하지 않은 경우에 발생합니다.
	::MessageBox(g_mainWnd, _T("Failed to initialize NHN Cloud SDK."), _T("Alert"), MB_OK);
	return false;
}


```

###  Test Sending Crash Logs

* To test on crash logs sending, an exception must occur.
* Crash logs are automatically sent by SDK when enableCrashReporter is true.
* Access Violation 예제
```

void CsampleDlg::OnBnClickedCrash()
{
    // TODO: Add your control notification handler code here
    int *i = reinterpret_cast<int*>(0x45);
    *i = 5;
}
```

### Interpret Crash Logs

To interpret crashes occurred in TOAST Windows SDK, a symbol file must be created and uploaded to a web console.

#### Create Symbol Files

* 심벌 파일을 생성하려면 배포파일의 경로에서 dump_syms.exe 를 사용해야합니다.
* 좀 더 쉬운 예제는 배포파일 경로에서 `nhncloudsdk_example`예제 프로젝트의 빌드후 이벤트를 참고해주세요.
* 명령 프롬프트를 실행해 아래와 같은 방식으로 .sym 파일을 생성합니다.
    * sample은 예제 프로젝트의 명칭입니다.

```
dump_syms sample.pdb > sample.sym
```

* Then, compress sample.sym with zip and [Upload to Console Server](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/#_24)
    * The version for console uploads must be the same as the version for setProjectVersion.
