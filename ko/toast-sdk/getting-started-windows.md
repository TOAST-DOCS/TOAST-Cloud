## TOAST > TOAST SDK 사용 가이드 > 시작하기 > Windows

## 지원 환경

* Windows 7
* Windows 10 (32bit/64bit)

## TOAST SDK의 구성

Android 용 TOAST SDK의 구성은 다음과 같습니다.

| Directory | Description | 
|---|---|
| docs/ | Windows SDK 문서 |
| include/toast/ | C++ 해더 파일 |
| windows-sdk/lib32/ | C++ Windows 32bit 라이브러리 |
| windows-sdk/lib64/ | C++ Windows 64bit 라이브러리 |
| windows-sdk-sample/ | 샘플 프로젝트 |

## TOAST SDK를 Visual Studio 프로젝트에 적용하기

### 라이브러리 포함하기 

1. 메뉴바의 Project 탭에서 Properties를 선택합니다.
2. C/C++ > General > Additional Include Directories에서 Sdk의 헤더파일 경로를 설정합니다.
3. Linker > General > Additional Library Directories에서 빌드환경(Debug/Release)과 Target Machine(x86, x64)에 따라 라이브러리를 포함 합니다.
4. Linker > Input > Additional Dependencies에서 빌드환경(Debug/Release)과 Target Machine(x86, x64)에 따라 추가할 lib를 입력합니다.

참고 : https://msdn.microsoft.com/ko-kr/library/ms235636.aspx(https://msdn.microsoft.com/ko-kr/library/ms235636.aspx)

## TOAST SDK 초기화하기

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

## UserID 설정하기

ToastSDK에 사용자 아이디를 설정할 수 있습니다.
설정한 사용자 아이디는 TOAST SDK의 각 모듈에서 다양한 용도로 사용하게 됩니다.
예를 들어 TOAST Logger 에서는 설정한 사용자 아이디를 로그 필드에 넣어서 함께 전송합니다.
따라서 설정한 사용자 아이디를 "UserID" 필드로 Log & Crash Search 콘솔을 통해 손쉽게 필터링하여 조회할 수 있습니다.


```

ToastLogger* _logger = GetToastLogger();

_logger->setUserId("userId");

_logger->initialize(loggerConf);

_logger->getUserId();
```

* setUserId
    * 사용자 아이디를 추가 합니다.
* getUserId
    * 현재 설정되어있는 사용자 아이디를 가지고 옵니다.

## TOAST Service 사용하기

* [TOAST Logger](./log-collector-windows) 사용 가이드

