## NHN Cloud > SDK User Guide > Release Notes > Windows C++

## 2.0.0.1 (2022.07.12)
Download : [nhncloud-sdk-windows-2.0.0.1.zip](https://static.toastoven.net/toastcloud/sdk_download/toast/windows/2.0.0/nhncloud-sdk-windows-2.0.0.1.zip)
* Changed the module name to NHNCloudLogger
	* ToastLogger has been deprecated.
* Fixed issues of memory leak when sending logs
* Fixed an issue where User ID is reflected differently according to MBCS or Unicode functions
* Fixed an issue where setting Log Types Filter is not applied when sending crash logs

## 1.0.0.5 (2021.03.31)
Download : [toast-sdk-windows-1.0.0.5.zip](https://static.toastoven.net/toastcloud/sdk_download/toast/windows/1.0.0/toast-sdk-windows-1.0.0.5.zip)
* Bug fixes
* Changed some API interfaces
* Added a feature to validate input values when using custom fields
* Fixed issues of intermittent Base64 decoding failure
* Fixed issues of intermittent failure when sending crash dumps to external processes
* Changed the structure of distributed binary
	* Sample project included

## 0.9.4.3 (2019.10.10)
Download : [toast-sdk-windows-0.9.4.3.zip](https://static.toastoven.net/toastcloud/sdk_download/toast/windows/0.9.4/toast-sdk-windows-0.9.4.3.zip)


### TOAST Log & Crash

#### Bug Fixes

* Fixed an issue where no crash log remains for pure virtual call / invalid parameter on x86

## 0.9.3.0 (2019.07.23)
Download : [toast-sdk-windows-0.9.3.0.zip](https://static.toastoven.net/toastcloud/sdk_download/toast/windows/0.9.3/toast-sdk-windows-0.9.3.0.zip)

### TOAST Log & Crash

#### Added Features

* Initialize() function success/failure handling
	* Changed the return value to bool
* Added SessionId to general log
* When setting information cannot be retrieved, process with the previously saved setting information.
* Provides a static library
	* Visual studio 2015 (vc14) version provided
* Provides xp version

## 0.9.0.12 (2018.09.04)
Download : [toast-sdk-windows-0.9.0.12.zip](https://static.toastoven.net/toastcloud/sdk_download/toast/windows/0.9.0/toast-sdk-windows-0.9.0.12.zip)

### TOAST Log & Crash

#### Added

* New Functions

