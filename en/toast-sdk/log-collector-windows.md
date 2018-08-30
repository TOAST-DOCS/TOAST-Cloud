# 개요

TOAST Windows SDK는 로그를 수집 서버에 보내는 기능을 제공합니다.

TOAST Windows SDK 특·장점은 다음과 같습니다.

* 로그를 수집 서버로 보냅니다.
* 앱에서 발생한 크래시 로그를 수집 서버로 보냅니다.
* Log & Crash Search에서 전송된 로그를 조회 및 검색 가능합니다.
* 멀티 쓰레딩 환경에서 동작합니다.
* 지원 환경

```
Windows 7, Windows 10 (32bit/64bit)
```

# 다운로드

[Toast Cloud](http://cloud.toast.com/)에서 TOAST Windows SDK를 받을 수 있습니다.

```
[DOCUMENTS] > [TOAST] > [TOAST SDK 사용 가이드] > [시작하기] > [Windows] 클릭
```

# SDK 구성

TOAST Windows SDK는 다음과 같이 구성되어 있습니다.

```
docs/                                       ; Windows SDK 문서
include/toast/                              ; C++ 해더 파일
windows-sdk/lib32/                          ; C++ Windows 32bit 라이브러리
windows-sdk/lib64/                          ; C++ Windows 64bit 라이브러리
windows-sdk-sample/                         ; 샘플 프로젝트
```

# SDK 설치하기

## 라이브러리 포함하기

1. 메뉴바의 Project 탭에서 Properties를 선택합니다.
2. C/C++ > General > Additional Include Directories에서 Sdk의 헤더파일 경로를 설정합니다.
3. Linker > General > Additional Library Directories에서 빌드환경(Debug/Release)과 Target Machine(x86, x64)에 따라 라이브러리를 포함 합니다.
4. Linker > Input > Additional Dependencies에서 빌드환경(Debug/Release)과 Target Machine(x86, x64)에 따라 추가할 lib를 입력합니다.

참고 : https://msdn.microsoft.com/ko-kr/library/ms235636.aspx

## 적용 예제

```
...
#include "toast/ToastLogger.h"

using namespace toast::logger;
...

ToastLogger* logger = GetToastLogger();

ToastLoggerConfiguration* loggerConf = GetToastLoggerConfiguration();

loggerConf->setProjectKey(appkey);
loggerConf->setProjectVersion(version);

if (_logger != NULL)
{
    _logger->initialize(loggerConf);
}
```

# SDK 기능 설명

### 로그 전송

* 애플리케이션에서 발생하는 로그를 중요도에 따라 INFO, DEBUG, WARN, ERROR, FATAL로 분류하여 로그를 전송할 수 있습니다.

### 커스텀 필드

* 커스텀 필드를 통해 서버에 남기고 싶은 정보를 기록할 수 있습니다. 커스텀 필드는 한번 적용하면 모든 로그에 적용되는 글로벌 커스텀 필드와 사용자가 원하는 로그에만 적용되는 유저 커스텀 필드가 있습니다.

### Crash 탐지 기능

* Crash는 사용자 애플리케리케이션을 종료시키는 RunTime Exception 입니다. Crash가 발생하면 TOAST Windows SDK는 Crash Dump를 생성하여 Log & Crash 서버로 전송합니다. 개발자는 콘솔을 모니터링하거나 알람 통해 오류발생을 인지하며, 해당 이슈를 재현할 수 있는 정보를 제공합니다.
* Crash Dump는 다음과 같은 내용을 포함하고 있습니다.
    * 에러가 발생한 특정지점
    * stack trace, thread 상황, exception분석

### 필터 설정

* Log & Crash 콘설에서 설정 페이지로 이동하면, 로그 수집 필터 조건을 설정할 수 있습니다.

#### 중복 로그 필터

* 중복 로그 필터 설정을 통해, n초 사이에 동일한 로그가 서버로 전송되는 것을 필터링 할 수 있습니다. 이때 동일한 로그의 기준은 메세지, 로그 타입, 로그 소스가 동일한 경우를 말합니다.

#### GDPR 필터

* 2018년 5월 25일부터 시행되는 EU의 개인정보보호 법령에 의하여, 개인정보를 수집하지 않기 위한 필터 입니다. SDK는 수집하지 않지만 Log & Crash 서버에서 사용자의 IP Address 정보를 수집하고 있어, 필요한 경우 GDPR 필터를 사용하여 서버에서 IP Address 정보를 수집하지 않도록 설정해야 합니다.

#### 로그 레벨 필터

* 클라이언트에서 발생하는 특정 로그 레벨의 전송을 무시하는 기능입니다.

#### 로그 타입 필터

* 클라이언트에서 발생하는 특정 로그 타입의 전송을 무시하는 기능입니다.

#### 로그 유형 필터

* 클라이언트에서 발생하는 특정 로그 유형의 전송을 무시하는 기능입니다.

# SDK API 사용법

## 초기화

```

    ToastLoggerConfiguration* loggerConf = GetToastLoggerConfiguration();

    loggerConf->setProjectKey(appkey);
    loggerConf->setProjectVersion(version);
    loggerConf->setServiceZone(serviceZone);
    loggerConf->enableCrashReporter(enableCrashReport);
    loggerConf->enableCrashSilenceMode(enableCrashSilenceMode);
    loggerConf->enableApplyGDPR(enableGDPRFilter);
    loggerConf->setCrashReporterMessage(langType, dialogMessage);
    loggerConf->saveCrashReporterMessageToJson();

	// logger initialize
	ToastLogger* _logger = GetToastLogger();

	if (_logger != NULL)
	{
		_logger->initialize(loggerConf);
	}
```

* setProjectKey
    * 프로젝트 키를 설정 합니다.
* setProjectVersion
    * 프로젝트 버전을 설정 합니다.
* setServiceZone
    * 알파, 리얼 환경을 설정 합니다.
* enableCrashReporter
    * crash 감지 기능을 활성화 합니다. false로 설정 시 crash가 발생하여도, 감지하지 않습니다.
* enableCrashSilenceMode
    * crash 발생 시, 전송 모드 입니다. true인 경우 crash가 발생하면 앱이 자동 종료되면서, 서버로 로그를 남깁니다. false인 경우 carsh가 발생하면 Dialog창이 실행되어 전송 여부를 확인합니다.
* enableApplyGDPR
    * true인 경우 host 아이피 정보를 수집합니다.
* setCrashReporterMessage
    * enableCrashSilenceMode가 false인 상태에서 crash 발생 시 실행되는 Dialog창의 문구를 수정합니다. 문구는 시스템 기본 언어설정에 따르며 KR, EN 2가지 형태로 설정 가능합니다.
* saveCrashReporterMessageToJson
    * setCrashReporterMessage에서 편집한 내용을 저장합니다.

## 사용자 아이디

```

ToastLogger* _logger = GetToastLogger();

_logger->setUserId("userId");

_logger->initialize(loggerConf);

_logger->getUserId();
```

* setUserId
    * 사용자 아이디를 추가 합니다.
* getUserId
    * 현재 설정되어있는 사용자 아이디를 가지고 옵니다,

## 일반 로그 전송

```
_logger->log(level, message, _userFieldMap);
```

* 일반 로그를 전송 합니다. 로그 레벨은 INFO, DEBUG, WARN, ERROR, FATAL 등이 있습니다.

## 글로벌 필드 추가

```
if (_logger != NULL)
{
    _logger->addUserField(key, value);
}
```

* 사용자 필드를 추가합니다. 이렇게 추가된 필드는 모든 종류의 로그에 적용됩니다.

## 사용자 필드 추가

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

## 크래시 로그 전송

```

void CsampleDlg::OnBnClickedCrash()
{
    // TODO: Add your control notification handler code here
    int *i = reinterpret_cast<int*>(0x45);
    *i = 5;
}
```

* 크래시 로그 전송을 테스트하기 위해서는 실제로 Exception이 일어나야 합니다.
* 크래시 로그 전송은 enableCrashReporter가 true인 경우 SDK가 자동으로 실행 합니다.

# 크래시 로그 해석하기

## 개요

* TOAST Windows SDK에서 발생한 Crash를 해석하기 위해서는 심볼 파일을 생성하여 웹 콘솔에 업로드 해야 합니다.

## 심볼 파일 생성

* 심볼 파일을 생성하기 위해서는 개발환경에 맞는 dump_syms가 필요합니다.
    * [dump\_syms\_vc1600 : vs2010](http://static.toastoven.net/toastcloud/tools/dump_syms_vc1600.zip)
    * [dump\_syms\_vc1700 : vs2012](http://static.toastoven.net/toastcloud/tools/dump_syms_vc1700.zip)
    * [dump\_syms\_vc1800 : vs2013](http://static.toastoven.net/toastcloud/tools/dump_syms_vc1800.zip)
    * [dump\_syms\_vc1900 : vs2015](http://static.toastoven.net/toastcloud/tools/dump_syms_vc1900.zip)
* 명령 프롬프트를 실행시켜 아래와 같은 방식으로 sym 파일을 생성 합니다
    * sample은 예제 프로젝트의 명칭 입니다.

```
dump_syms sample.pdb > sample.sym
```

* 이후 sample.sym을 zip으로 압축하여 콘솔 서버에 업로드 합니다.
    * 콘솔 업로드시 입력하는 버전은 초기화 시, setProjectVersion에 입력한 버전과 동일한 값을 사용해야 합니다.