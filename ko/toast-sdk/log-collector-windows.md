## TOAST > TOAST SDK 사용 가이드 > TOAST Log & Crash > Windows C++

## Prerequisites

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
    _logger->initialize(loggerConf);
}
```

### GDPR 사용

GDPR(General Data Protection Regulation, 유럽 개인정보 보호법)을 사용시에는 아래와 같이 TOAST Logger SDK를 초기화합니다. 

```
...
#include "toast/ToastLogger.h"

using namespace toast::logger;
...

ToastLogger* logger = GetToastLogger();

ToastLoggerConfiguration* loggerConf = GetToastLoggerConfiguration();
...
loggerConf->enableApplyGDPR(true);
...

if (_logger != NULL)
{
    _logger->initialize(loggerConf);
}
```

## UserID 설정하기

ToastSDK에 사용자 아이디를 설정할 수 있습니다.
설정한 UserID는 ToastSDK의 각 모듈에서 공통으로 사용됩니다.
ToastLogger의 로그 전송 API를 호출할 때마다 설정한 사용자 아이디를 로그와 함께 서버로 전송합니다.


```

ToastLogger* _logger = GetToastLogger();

_logger->setUserId("userId");

_logger->initialize(loggerConf);

_logger->getUserId();
```

* setUserId
    * 사용자 아이디를 설정합니다.
* getUserId
    * 현재 설정된 사용자 아이디를 얻어옵니다.

## 로그 전송하기

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

*  사용자 정의 필드는 "Log & Crash Search 콘솔" > "Log Search 탭"에 "선택한 필드"로 노출되는 값과 동일합니다.  
즉, Log & Crash Search의 커스텀 파라미터와 동일한 것으로 "field"값의 상세한 제약 사항은 [커스텀 필드의 제약사항](http://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/api-guide/)에서 확인할 수 있습니다.

#### 커스텀 필드 제약사항

* 이미 [예약된 필드](./log-collector-reserved-fields)는 사용할 수 없습니다.  
예약된 필드는 [커스텀 필드의 제약사항](http://docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/api-guide/) 항목의 "기본 파라미터"를 확인하세요.
* 필드명은 "A-Z, a-z"로 시작하고 "A-Z, a-z, 0-9, -, _" 문자를 사용할 수 있습니다.
* 필드명 내에 공백은 "\_"로 치환됩니다.

### addUserField / removeUserFiled / cleareUserField 사용 예

```
_logger->addUserField("nickname", "randy");
_logger->removeUserField("nickname");
_logger->cleareUserField();
```

## 크래시 로그 수집

TOAST Logger가 활성화되면, 윈도우즈 어플리케이션에서 예상치 못한 크래시가 발생한 경우 자동으로 크래시 정보를 서버에 기록합니다.

### 크래시 로그 활성화 및 크래시 리포터 



```
...
#include "toast/ToastLogger.h"

using namespace toast::logger;
...

ToastLogger* logger = GetToastLogger();

ToastLoggerConfiguration* loggerConf = GetToastLoggerConfiguration();
...
loggerConf->enableCrashReporter(true);	// 크래시 리포터 사용 여부 (true: 활성, false: 비활성)
loggerConf->enableSilenceMode(false);	// 다이얼로그 사용 여부 (true: 다이얼로그 보이지 않음, false: 다이얼로그 보임)
loggerConf->setCrashReporterMessage(TOAST_LANGUAGE_KOREAN, "오류가 발생한 상황과 현상, 예상되는 원인을 기술해주시면 문제 해결에 도움이 됩니다.\n"); // 다이얼로그에 보일 메시지 정의 (정의하지 않으면 기본 메시지가 보이게 됩니다.)
...

if (_logger != NULL)
{
    _logger->initialize(loggerConf);
}
```

### 크래시 로그 전송 테스트 

* 크래시 로그 전송을 테스트하기 위해서는 실제로 Exception이 일어나야 합니다.
* 크래시 로그 전송은 enableCrashReporter가 true인 경우 SDK가 자동으로 실행합니다.

```

void CsampleDlg::OnBnClickedCrash()
{
    // TODO: Add your control notification handler code here
    int *i = reinterpret_cast<int*>(0x45);
    *i = 5;
}
```

### 크래시 로그 해석하기

#### 개요

* TOAST Windows SDK에서 발생한 Crash를 해석하기 위해서는 심볼 파일을 생성하여 웹 콘솔에 업로드 해야 합니다.

#### 심볼 파일 생성

* 심볼 파일을 생성하기 위해서는 개발환경에 맞는 dump_syms가 필요합니다.
    * [dump\_syms\_vc1600 : vs2010](http://static.toastoven.net/toastcloud/tools/dump_syms_vc1600.zip)
    * [dump\_syms\_vc1700 : vs2012](http://static.toastoven.net/toastcloud/tools/dump_syms_vc1700.zip)
    * [dump\_syms\_vc1800 : vs2013](http://static.toastoven.net/toastcloud/tools/dump_syms_vc1800.zip)
    * [dump\_syms\_vc1900 : vs2015](http://static.toastoven.net/toastcloud/tools/dump_syms_vc1900.zip)
* 명령 프롬프트를 실행시켜 아래와 같은 방식으로 sym 파일을 생성합니다.
    * sample은 예제 프로젝트의 명칭입니다.

```
dump_syms sample.pdb > sample.sym
```

* 이후 sample.sym을 zip으로 압축하여 [콘솔 서버에 업로드](https://alpha-docs.toast.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/#_25) 합니다.
    * 콘솔 업로드 시 입력하는 버전은 초기화 시, setProjectVersion에 입력한 버전과 동일한 값을 사용해야 합니다.

#### 크래시 발생 시점에 추가 정보를 설정하여 전송하기

크래시 발생 직후, 추가 정보를 설정할 수 있습니다.
setUserField는 크래시 시점과 관계없이 아무 때나 설정할 수 있고, setDataAdapter의 경우 정확히 크래시가 발생한 시점에 추가 정보를 설정할 수 있습니다.

##### setDataAdapter API 명세

```java
static void setDataAdapter(CrashDataAdapter adapter);
```
* CrashDataAdapter의 getUserFields 함수를 통해 리턴하는 Map 자료구조의 키값은 위에서 설명한 setUserField의 "field"값과 동일한 제약 조건을 갖습니다.

##### setDataAdapter 사용 예

```java
ToastLogger.setDataAdapter(new CrashDataAdapter() {
    @Override
    public Map<String, Object> getUserFields() {
        Map<String, Object> userFields = new HashMap<>();
        userFields.put("UserField", "UserValue");
        return userFields;
    }
});
```



