## TOAST > User Guide for TOAST SDK > Getting Started > Windows C++

## Supporting Environment

* Windows 7
* Windows 8
* Windows 10

## Configuration of TOAST SDK

TOAST SDK for Windows C++ is configured as follows:

| Directory | Description |
|---|---|
| docs/ | Windows SDK document |
| include/toast/ | C++ Header file |
| windows-sdk/lib32/ | C++ Windows 32bit library |
| windows-sdk/lib64/ | C++ Windows 64bit library |
| windows-sdk-sample/ | Sample project |

## Apply TOAST SDK to Visual Studio Projects

Download TOAST Windows C++ SDK from the [Download](../../../Download/#toast-sdk) page.

### Include Libraries

1. Select Properties from Project on the menu.
2. Set the route for SDK header files from C/C++ > General > Additional Include Directories.
3. Go to Linker > General > Additional Library Directories, and include library, depending on the build environment (Debug/Release) and target machine (x86 or x64).
4. Go to Linker > Input > Additional Dependencies, and enter lib to add, depending on the build environment (Debug/Release) and target machine (x86 or x64).

For reference: [https://msdn.microsoft.com/ko-kr/library/ms235636.aspx](https://msdn.microsoft.com/ko-kr/library/ms235636.aspx)

### nhncloudsdk_exmple
* Visual Studio 2019 기준으로 작성한 샘플 프로젝트입니다.

## Use NHN Cloud Log & Crash Search Service

* User Guide for [TOAST Log & Crash](./log-collector-windows)

