<!-- pre-align:aligned sig=2ef3f6cfec8f -->

## NHN Cloud > SDK User Guide > Getting Started > Windows C++

<a id="supported-environment"></a>

## Supported Environment
* Windows 7
* Windows 8
* Windows 10
* Windows 11

<a id="structure-of-nhn-cloud-sdk"></a>

## Structure of NHN Cloud SDK

NHN Cloud SDK for Windows C++ has the following structure.

| Directory | Description | 
|---|---|
| dump_syms.exe| Extract symbol (*.sym) for crash analysis from PDB (*.pdb) file |
| include| C++ Header file |
| x86| C++ Windows 32bit library |
| x64| C++ Windows 64bit library |
| nhncloudsdk_example | Sample project |

<a id="apply-nhn-cloud-sdk-to-visual-studio-projects"></a>

## Apply NHN Cloud SDK to Visual Studio Projects

Download NHN Cloud Windows C++ SDK from the [Download](../../../Download/#toast-sdk) page of NHN Cloud.

<a id="include-libraries"></a>

### Include Libraries

1. Select **Properties** from **Project** tab on the menu bar.
2. Set the path for SDK header files from **C/C++ > General > Additional Include Directories**.
3. Go to **Linker > General > Additional Library Directories** and include libraries, depending on the build environment (Debug/Release) and target machine (x86 or x64).
4. Go to **Linker > Input > Additional Dependencies** and enter lib to add, depending on the build environment (Debug/Release) and target machine (x86 or x64).
For reference: [https://msdn.microsoft.com/ko-kr/library/ms235636.aspx](https://msdn.microsoft.com/ko-kr/library/ms235636.aspx)

<a id="nhncloudsdkexmple"></a>

### nhncloudsdk_exmple
* This is a sample project written based on Visual Studio 2019.

<a id="use-nhn-cloud-log-crash-search-service"></a>

## Use NHN Cloud Log & Crash Search Service

* User Guide for [Log & Crash](./log-collector-windows)

