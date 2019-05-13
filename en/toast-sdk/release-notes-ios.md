## TOAST > User Guide for TOAST SDK > Release Notes > iOS

## 0.14.0 (2019.05.14)

### Common

#### Fixed

* Network error code integration
* Improvement in safety

### TOAST IAP

#### Fixed

* Improved purchasing restore
    * Adds a restore feature for missing payments based on AppStore receipt 
    * Add restore failure error code
* Adding a store request(promotion) flag to the purchase result class
* Expand reprocessing target
* Improve purchase flow

### TOAST Push

#### Fixed

* Improvement in safety
* Adding message id in payload that is passed to delegate
* In the case of VoIP, which does not require consent to receive a advertisement message or a night advertisement message, a message is received regardless of whether the user agrees to receive it or not

## 0.13.0 (2019.03.26)

### Common

#### Fixed

* Improved Usability of Public Class
  * Add Description
  * Support Nullability, NSCoding, NSCopying

### TOAST Core

#### Fixed

* Add Internal Exception Processing

### TOAST Logger

#### Added

* Support for Crash analysis of devices using the arm64e architecture
* Change PLCrashReporter Dependency

#### Fixed

* Change Configuration Interface
  * Deprecate
    * configurationWithProjectKey
  * Add
    * configurationWithAppKey

#### Bug Fixed

* Modify a problem that may not update the UserID of the Log that is sent at the time of UserID setup

### TOAST IAP

#### Fixed

* Add Internal Exception Processing

### TOAST Push

#### Added

* Add unregisterToken API

## 0.12.4 (2019.03.19)

### TOAST Core

#### Fixed

* Add a exception 

## 0.12.3 (2019.02.26)

### TOAST Core, Common

#### Fixed

* Add a exception for util function

### TOAST IAP

#### Fixed

* Add products information caching 
* Add a exception 

## 0.12.2 (2019.02.08) - Hotfix

### TOAST Core

#### Fixed

* Add a defense code for crashes in ToastTransfer

## 0.12.1 (2019.01.08)

### TOAST IAP

#### Fixed

* Fixed an issue where VerifyEnd could not be reprocessed under certain circumstances

## 0.12.0 (2018.12.27)

### TOAST Core

#### Fixed

* Add a defense code for crashes in ToastTransfer

### TOAST Push

#### Fixed 

* New Functions 

### TOAST IAP

#### Fixed

* Added exception handling for UserID verification logic to handle reprocessed transactions delivered by Apple
* Add a defense code for crashes in ToastOperation

## 0.11.1 (2018.12.04)

### TOAST IAP

#### Added 

* New Functions 


## 0.11.0 (2018.11.20)

### TOAST Log & Crash

#### Added 

* Network Insights


## 0.9.0 (2018.09.04)

### TOAST Log & Crash

#### Added

* New Functions
