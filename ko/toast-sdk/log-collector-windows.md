## TOAST > TOAST SDK 사용 가이드 > TOAST Log & Crash > Windows C++

## 사전 준비

1\. [Install the TOAST SDK](./getting-started-windows)
2\. [TOAST 콘솔](https://console.cloud.toast.com)에서 [Log & Crash Search를 활성화](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/)합니다.
3\. Log & Crash Search에서 [AppKey를 확인](https://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/#appkey)합니다.

## TOAST Logger SDK 초기화

Log & Crash Search에서 발급받은 AppKey를 ProjectKey로 설정합니다.

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

## UserID 설정

ToastSDK에 사용자 ID를 설정할 수 있습니다.
설정한 UserID는 ToastSDK의 각 모듈에서 공통으로 사용됩니다.
ToastLogger의 로그 전송 API를 호출할 때마다 설정한 사용자 ID를 로그와 함께 서버로 전송합니다.


```

ToastLogger* _logger = GetToastLogger();

_logger->setUserId("userId");

_logger->initialize(loggerConf);

_logger->getUserId();
```

* setUserId
    * 사용자 ID를 설정합니다.
* getUserId
    * 현재 설정된 사용자 ID를 얻어옵니다.

## 로그 전송

TOAST Logger는 5가지 레벨의 로그 전송 함수를 제공합니다.

### 로그 전송 

```
// 일반 로그
_logger->log(level, message, _userFieldMap);

// DEBUG 레벨 로그
_logger->debug(level, message, _userFieldMap);

// INFO 레벨 로그
_logger->info(level, message, _userFieldMap);

// WARN 레벨 로그
_logger->warn(String message);

// ERROR 레벨 로그
_logger->error(String message);

// FATAL 레벨 로그
_logger->fatal(String message);
```

## 사용자 정의 필드 추가

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

* 사용자 필드는 특정로그에만 적용하고 싶은 필드 정보를 담습니다.
* ToastLoggerUserFields는 아래와 같은 함수를 지원합니다.
    * insert : 데이터 삽입
    * erase : 데이터 삭제
    * clear : 전체 삭제
    * size : 사이즈
    * find : 데이터 탐색
    * empty : 빈 상태 여부

*  사용자 정의 필드는 **Log & Crash Search > 로그 검색**을 클릭한 후 **로그 검색** 화면의 **선택한 필드**에 표시되는 값과 같습니다. 

#### 커스텀 필드 제약사항

* 이미 [예약된 필드](./log-collector-reserved-fields)는 사용할 수 없습니다.  
* 필드명은 "A-Z, a-z"로 시작하고 "A-Z, a-z, 0-9, -, _" 문자를 사용할 수 있습니다.
* 필드명 내에 공백은 "_"로 치환됩니다.

### addUserField / removeUserFiled / cleareUserField 사용 예

```
_logger->addUserField("nickname", "randy");
_logger->removeUserField("nickname");
_logger->cleareUserField();
```

## 크래시 로그 수집

크래시 리포터(CrashRepoter.exe)는 크래시 정보를 로그로 전송하는 기능을 제공합니다.
크래시가 발생하면 크래시 리포터에서 크래시 정보를 로그로 전송합니다.
ToastLogger를 초기화할 때 크래시 리포터 사용 여부를 설정할 수 있습니다.
크래시 리포터 대화 상자 사용 여부 및 커스텀 메시지를 설정할 수 있습니다. 


### 크래시 로그 활성화 및 크래시 리포터 

```
...
#include "toast/ToastLogger.h"

using namespace toast::logger;
...

ToastLogger* _logger = GetToastLogger();

ToastLoggerConfiguration* loggerConf = GetToastLoggerConfiguration();
...
// 크래시 로그 활성화 여부
loggerConf->enableCrashReporter(true);	
// 크래시 리포터 다이얼로그 사용 여부
loggerConf->enableSilenceMode(false);	
// 크래시 리포터 다이얼로그에 보일 메시지 정의 
// (정의하지 않으면 기본 메시지가 보이게 됩니다.)
loggerConf->setCrashReporterMessage(TOAST_LANGUAGE_KOREAN, "오류가 발생한 상황...\n");
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

### 크래시 로그 전송 테스트 

* 크래시 로그 전송을 테스트하려면 실제로 예외(Exception)가 발생해야 합니다.
* 크래시 로그 전송은 enableCrashReporter가 true인 경우 SDK가 자동으로 실행합니다.

```

void CsampleDlg::OnBnClickedCrash()
{
    // TODO: Add your control notification handler code here
    int *i = reinterpret_cast<int*>(0x45);
    *i = 5;
}
```

### 크래시 로그 해석

TOAST Windows SDK에서 발생한 크래시를 해석하려면 심벌 파일을 생성해 웹 콘솔에 업로드해야 합니다.

#### 심벌 파일 생성

* 심벌 파일을 생성하려면 개발환경에 맞는 dump_syms가 필요합니다.
    * [dump\_syms\_vc1600 : vs2010](http://static.toastoven.net/toastcloud/tools/dump_syms_vc1600.zip)
    * [dump\_syms\_vc1700 : vs2012](http://static.toastoven.net/toastcloud/tools/dump_syms_vc1700.zip)
    * [dump\_syms\_vc1800 : vs2013](http://static.toastoven.net/toastcloud/tools/dump_syms_vc1800.zip)
    * [dump\_syms\_vc1900 : vs2015](http://static.toastoven.net/toastcloud/tools/dump_syms_vc1900.zip)
* 명령 프롬프트를 실행해 아래와 같은 방식으로 .sym 파일을 생성합니다.
    * sample은 예제 프로젝트의 명칭입니다.

```
dump_syms sample.pdb > sample.sym
```

* 이후 sample.sym을 zip으로 압축하여 [콘솔 서버에 업로드](https://alpha-docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/#_25)합니다.
    * 콘솔 업로드할 때 입력하는 버전은, 초기화할 때 setProjectVersion에 입력한 버전과 같은 값이어야 합니다.




