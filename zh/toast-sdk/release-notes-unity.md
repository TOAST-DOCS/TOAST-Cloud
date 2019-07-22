## TOAST > User Guide for TOAST SDK > Release Notes > Unity

## 0.15.0 (2019.07.23)

### TOAST IAP

#### 변경 사항

* ActivedPurchases -> ActivatedPurchses
    
## 0.14.0 (2019.07.02)

### TOAST Log & Crash

#### 추가 사항

* Unity Standalone/WebGL 버전 추가
    * Logger
    * Instance Logger

### TOAST IAP

#### 추가 사항

* ActivedPurchases 추가

## 0.13.1 (2019.03.26)

### TOAST Log & Crash

#### Improved

* Improved to be able to send logs on non-unity thread.
* Rename ProjectKey to AppKey
    * setProjectKey is still available

#### Fixed

* Fixed a issue that sends a unexpected SDK exception when message is empty in Android.

## 0.13.0 (2019.02.26)

### TOAST Log & Crash

#### Added

* Add a feature that filter crash logs

## 0.12.0 (2019.01.08)

### TOAST IAP

#### Added

* Add module

## 0.11.0 (2018.12.27)

### TOAST Log & Crash

#### Added

* Add a feature that sends automatically unexpected exception logs that occurs in Unity 
* SetCrashListener API

## 0.10.0 (2018.11.20)

### TOAST Log & Crash

#### Added

* SetLoggerListener API 
* Support of Network Insights  

#### Changed 

* Removed mainTemplate.gradle from Unity Package 
    * See guide for setting of mainTemplate.gradle 

## 0.9.0 (2018.09.04)

### TOAST Log & Crash

#### Added

* Add module