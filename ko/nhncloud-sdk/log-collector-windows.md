## NHN Cloud > SDK 사용 가이드 > Log & Crash > Windows C++

## 사전 준비

1. [Install the NHN Cloud SDK](./getting-started-windows)
2. [NHN Cloud 콘솔](https://console.nhncloud.com)에서 [Log & Crash Search를 활성화](https://docs.nhncloud.com/ko/Data%20&%20Analytics/Log%20&%20Crash%20Search/ko/console-guide/)합니다.
3. Log & Crash Search에서 [AppKey를 확인](https://docs.nhncloud.com/ko/Data%20&%20Analytics/Log%20&%20Crash%20Search/ko/console-guide/#appkey)합니다.

## NHN Cloud SDK 초기화

Log & Crash Search에서 발급 받은 AppKey를 ProjectKey로 설정합니다.

```cpp
...
#include "NHNCloudLogger.h"

nhncloud::logger::NHNCloudLogger* g_nhncloud_lnc = nullptr; // NHN Cloud SDK - Log & crash search
...

// 전역 변수에 NHN Cloud SDK 인스턴스를 할당합니다.
g_nhncloud_lnc = nhncloud::logger::NHNCloudLogger::GetInstance();

// NHNCloudLogger를 초기화 할 때, 필요한 설정 정보를 입력합니다.
nhncloud::logger::NHNCloudLoggerConfiguration* loggerConf = nhncloud::logger::NHNCloudLoggerConfiguration::GetInstance();

...
// Log & Crash Search 콘솔에서 확인한 앱키를 입력합니다.
loggerConf->setProjectKey(appkey);

// 현재 애플리케이션의 버전 정보를 입력합니다. 버전 정보는 심볼 파일 등록하는 과정에서 입력하는 버전 정보와 일치해야 합니다.
loggerConf->setProjectVersion(version);
...

if (!g_nhncloud_lnc->initialize(loggerConf))
{
	// 초기화가 실패하는 경우는 이미 초기화 되었거나, 앱키를 입력하지 않은 경우에 발생합니다.
	::MessageBox(g_mainWnd, _T("Failed to initialize NHN Cloud SDK."), _T("Alert"), MB_OK);
	return false;
}

```

## UserID 설정

사용자 ID를 설정할 수 있습니다.
UserID를 설정하면, 로그 전송 API를 호출할 때 로그와 함께 사용자 ID도 서버로 전송합니다.
사용자 ID는 초기화 전/후 상관 없이 설정 할 수 있습니다.

```cpp
    nhncloud::logger::NHNCloudLogger* pLogger = nhncloud::logger::NHNCloudLogger::GetInstance();
    pLogger->setUserId(pUserID);
    pLogger->getUserId();
```

* setUserId
    * 사용자 ID를 설정합니다.
* getUserId
    * 현재 설정된 사용자 ID를 얻어옵니다.

## 로그 전송

NHN Cloud Logger는 5가지 레벨의 로그 전송 함수를 제공합니다.

### 로그 전송
* DEBUG, INFO, WARN, ERROR, FATAL 레벨의 로그를 명시적으로 전송
	* char*, wchar_t* 형을 모두 지원합니다.
	* userFields는 사용자 정의 필드를 좀 더 쉽게 사용하기 위한 헬퍼 클래스입니다.
```cpp
void debug(const wchar_t* message, NHNCloudLoggerUserFields* userFields = NULL);
void info(const wchar_t* message, NHNCloudLoggerUserFields* userFields = NULL);
void warn(const wchar_t* message, NHNCloudLoggerUserFields* userFields = NULL);
void error(const wchar_t* message, NHNCloudLoggerUserFields* userFields = NULL);
void fatal(const wchar_t* message, NHNCloudLoggerUserFields* userFields = NULL);
```
* 로그 레벨과, 메시지를 명시적으로 전송
```cpp
void log(NHNCLOUD_LOGGER_LEVEL logLevel, const char* message, NHNCloudLoggerUserFields* userFields = nullptr);
```

## 사용자 정의 필드 추가
### 방법 1 : NHNCloudLogger 인스턴스 API 사용

* NHNCloudLogger 인스턴스에서 직접 관리하는 사용자 정의 필드입니다.

```cpp
bool addUserField(const char* key, const wchar_t* value);
void removeUserField(const char* key);
void clearUserFileds();

...

g_nhncloud_lnc->addUserField("nickname", "randy");
g_nhncloud_lnc->removeUserField("nickname");
g_nhncloud_lnc->cleareUserField();

```

### 방법 2 : NHNCloudLoggerUserFields 클래스 사용

```cpp
nhncloud::logger::NHNCloudLoggerUserFields* pUserFieldHelper = nhncloud::logger::NHNCloudLoggerUserFields::GetInstance();	// 사용자 정의 필드 헬퍼 클래스를 얻어옵니다.

pUserFieldHelper->insert("userCustomKeyHelper01", L"NHNCloudLoggerUserFields 헬퍼 클래스로 추가한 사용자 정의 필드\r\nCustom fields added with the NHNCloudLoggerUserFields helper class");
pUserFieldHelper->insert("userCustomKeyHelper02", L"clear() 함수로 지금껏 정의한 사용자 필드를 간단히 정리할 수 있어요.\r\nWith the clear() function, you can simply clear the custom fields you have defined so far.");
pUserFieldHelper->insert("userCustomKeyHelper03", L"log() 함수로 전송시, NHNCloudLoggerUserFields 클래스에 정의한 사용자 필드들은 로그 객체에 복사됩니다.\r\nWhen sending to the log() function, the user fields defined in the NHNCloudLoggerUserFields class are copied to the log object.");

g_nhncloud_lnc->log(level, pLogMessage, pUserFieldHelper);	// 사용자 정의 필드와 함께 로그를 전송합니다.

pUserFieldHelper->clear(); // 위에서 설정한 사용자 정의 필드를 모두 삭제합니다.

```

*  사용자 정의 필드는 **Log & Crash Search > 로그 검색**을 클릭한 후 **로그 검색** 화면의 **선택한 필드**에 표시되는 값과 같습니다.

#### 사용자 정의(커스텀) 필드 제약사항

* 이미 [예약된 필드](./log-collector-reserved-fields)는 사용할 수 없습니다.
* 필드명은 "A-Z, a-z"로 시작하고 "A-Z, a-z, 0-9, -, _" 문자를 사용할 수 있습니다.
* 필드명 내에 공백은 "_"로 치환됩니다.


## 크래시 로그 수집
* 크래시가 발생하면, SDK를 포함한 실행 파일에서 크래시 덤프를 전송하는 것이 기본동작입니다.
* 크래시 발생시 사용자에 오류 화면을 노출하고 추가 정보를 수집할 수 있습니다.

### 크래시 로그 수집과 환경 설정

```cpp

#include "NHNCloudLogger.h"

nhncloud::logger::NHNCloudLogger* g_nhncloud_lnc = nullptr;  // NHN Cloud SDK - Log & crash search
...

// 전역 변수에 NHN Cloud SDK 인스턴스를 할당합니다.
g_nhncloud_lnc = nhncloud::logger::NHNCloudLogger::GetInstance();

// NHNCloudLogger를 초기화 할 때, 필요한 설정 정보를 입력합니다.
nhncloud::logger::NHNCloudLoggerConfiguration* loggerConf = nhncloud::logger::NHNCloudLoggerConfiguration::GetInstance();

...
// Log & Crash Search 콘솔에서 확인한 앱키를 입력합니다.
loggerConf->setProjectKey(appkey);

// 현재 애플리케이션의 버전 정보를 입력합니다. 버전 정보는 심볼 파일 등록하는 과정에서 입력하는 버전 정보와 일치해야 합니다.
loggerConf->setProjectVersion(version);

// 크래시 수집 활성화 - 기본적으로 활성화 상태입니다. 크래시 수집을 원하지 않는다면 false로 설정합니다.
loggerConf->enableCrashReporter(true);

// 별도의 프로세스로 동작하는 크래시 리포터(CrashReporter.exe)를 사용하기 위해서는, enableSilenceMode(false)로 설정합니다.
loggerConf->enableSilenceMode(false);

// 별도의 프로세스로 동작하는 크래시 리포터에 노출할 메시지를 정의합니다. 정의하지 않으면 기본 메시지가 보이게 됩니다.
loggerConf->setCrashReporterMessage(NHNCLOUD_LANGUAGE_KOREAN, "오류가 발생한 상황...\n");

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

### 크래시 로그 전송 테스트

* 크래시 로그 전송을 테스트하려면 실제로 예외(Exception)가 발생해야 합니다.
* 크래시 로그 전송은 enableCrashReporter가 true인 경우 SDK가 자동으로 실행합니다.
* Access Violation 예제
```cpp

void CsampleDlg::OnBnClickedCrash()
{
    // TODO: Add your control notification handler code here
    int *i = reinterpret_cast<int*>(0x45);
    *i = 5;
}
```

### 크래시 로그 해석

NHN Cloud Windows SDK에서 발생한 크래시를 해석하려면 심벌 파일을 생성해 웹 콘솔에 업로드해야 합니다.

#### 심벌 파일 생성

* 심벌 파일을 생성하려면 배포파일의 경로에서 dump_syms.exe 를 사용해야합니다.
* 좀 더 쉬운 예제는 배포파일 경로에서 `nhncloudsdk_example`예제 프로젝트의 빌드후 이벤트를 참고해주세요.
* 명령 프롬프트를 실행해 아래와 같은 방식으로 .sym 파일을 생성합니다.
    * sample은 예제 프로젝트의 명칭입니다.

```
dump_syms sample.pdb > sample.sym
```

* 이후 sample.sym을 zip으로 압축하여 [콘솔 서버에 업로드](https://docs.nhncloud.com/ko/Data%20&%20Analytics/Log%20&%20Crash%20Search/ko/console-guide/#_21)합니다.
    * 콘솔 업로드할 때 입력하는 버전은, 초기화할 때 setProjectVersion에 입력한 버전과 같은 값이어야 합니다.
