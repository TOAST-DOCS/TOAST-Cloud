## TOAST > TOAST SDK 사용 가이드 > 시작하기 > Windows C++

## 지원 환경

* Windows 7
* Windows 10

## TOAST SDK의 구성

Windows C++ 용 TOAST SDK의 구성은 다음과 같습니다.

| Directory | Description | 
|---|---|
| docs/ | Windows SDK 문서 |
| include/toast/ | C++ 헤더 파일 |
| windows-sdk/lib32/ | C++ Windows 32bit 라이브러리 |
| windows-sdk/lib64/ | C++ Windows 64bit 라이브러리 |
| windows-sdk-sample/ | 샘플 프로젝트 |

## TOAST SDK를 Visual Studio 프로젝트에 적용하기

아래의 링크에서 TOAST Windows C++ SDK 를 다운로드 받을 수 있습니다.

- [다운로드](../../../Download/#toast-sdk)

### 라이브러리 포함하기 

1. 메뉴바의 Project 탭에서 Properties를 선택합니다.
2. C/C++ > General > Additional Include Directories에서 Sdk의 헤더파일 경로를 설정합니다.
3. Linker > General > Additional Library Directories에서 빌드환경(Debug/Release)과 Target Machine(x86, x64)에 따라 라이브러리를 포함합니다.
4. Linker > Input > Additional Dependencies에서 빌드환경(Debug/Release)과 Target Machine(x86, x64)에 따라 추가할 lib를 입력합니다.

참고 : [https://msdn.microsoft.com/ko-kr/library/ms235636.aspx](https://msdn.microsoft.com/ko-kr/library/ms235636.aspx)

## TOAST Service 사용하기

* [TOAST Log & Crash](./log-collector-windows) 사용 가이드

