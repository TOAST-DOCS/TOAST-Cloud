## NHN Cloud > NHN Cloud SDK 사용 가이드 > 시작하기 > Windows C++

## 지원 환경

* Windows 7
* Windows 10

## NHN Cloud SDK의 구성

Windows C++ 용 NHN Cloud SDK의 구성은 다음과 같습니다.

| Directory | Description | 
|---|---|
| docs/ | Windows SDK 문서 |
| include/toast/ | C++ 헤더 파일 |
| windows-sdk/lib32/ | C++ Windows 32bit 라이브러리 |
| windows-sdk/lib64/ | C++ Windows 64bit 라이브러리 |
| windows-sdk-sample/ | 샘플 프로젝트 |

## NHN Cloud SDK를 Visual Studio 프로젝트에 적용하기

NHN Cloud의 [Downloads](../../../Download/#toast-sdk) 페이지에서 NHN Cloud Windows C++ SDK를 다운로드합니다.

### 라이브러리 포함

1. 메뉴바의 **Project** 탭에서 **Properties**를 선택합니다.
2. **C/C++ > General > Additional Include Directories**에서 Sdk의 헤더파일 경로를 설정합니다.
3. **Linker > General > Additional Library Directories**에서 빌드환경(Debug/Release)과 Target Machine(x86, x64)에 따라 라이브러리를 포함합니다.
4. **Linker > Input > Additional Dependencies**에서 빌드환경(Debug/Release)과 Target Machine(x86, x64)에 따라 추가할 lib를 입력합니다.

[참고] [https://msdn.microsoft.com/ko-kr/library/ms235636.aspx](https://msdn.microsoft.com/ko-kr/library/ms235636.aspx)

## NHN Cloud Service 사용

* [NHN Cloud Log & Crash](./log-collector-windows) 사용 가이드

