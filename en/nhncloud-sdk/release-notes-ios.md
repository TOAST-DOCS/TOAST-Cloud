## NHN Cloud > SDK User Guide > Release Notes > iOS

## 1.7.0 (2023. 11. 14.)
### Common
#### Improved
* Raised the minimum supported version
    * 9.0 > 11.0
* Ended support for architectures
    *  i386, armv7s, armv7

### NHN Cloud IAP
#### Improved
* Changed payment verification methods
  
## 1.6.2 (2023. 08. 29.)
### Common
#### Improved
* Fixed an issue where CountryCode is not obtained

### NHN Cloud OCR
#### Added Features
* Added recognition area in the result of credit card/ID card recognition

## 1.6.1 (2023. 07. 25.)
### NHN Cloud IAP
#### Improved
* Improved the feature to send payment details

## 1.6.0 (2023. 07. 11.)
### NHN Cloud OCR
#### Added Features
* Added OCR (ID Card Recognizer)

## 1.5.0 (2023. 06. 27.)
### NHN Cloud Push
#### Improved
* Improved the token registration feature
    * Provided the option to register a token regardless of the app's notification permissions.

#### SymbolUploader(v0.0.3)
* Improved stability

## 1.4.0 (2023. 05. 30.)
### Common
#### Improved
* Added the SPM(swift package manager) deployment method

### NHN Cloud IAP
#### Added Featrues
* Added a feature to send payment details 
    * You can view payment details on the Transaction tab in the IAP console.

#### SymbolUploader(v0.0.2)
* Improved run script
    * Added support for Cocoapods, SPM

## 1.3.1 (2023. 05. 19.) - Hotfix
### NHN Cloud Push
#### Improved
* Improved the token registration feature
    * When registering a token, if the notification setting of the app is disabled, `NHNCloudPushErrorPermissionDenied` is returned again.
    
## 1.3.0 (2023. 02. 28.)
### Common
#### Improved
* Improved stability

## 1.2.1 (2023. 01. 31.)
### NHN Cloud Push

#### Improved
* Improved token registration function

### NHN Cloud OCR
#### Improved
* Improved credit card recognition performance
* Improved stability

## 1.2.0 (2022. 11. 29.)
### NHN Cloud Logger
#### Added Features
* Added support for Logger for government agencies

### NHN Cloud Push
#### Improved
* Improved sending push events

### NHN Cloud OCR
#### Improved
* Improved UI

## 1.1.0 (2022. 10. 25.)
### Common
#### Improvements
* Improved stability

### NHN Cloud IAP
#### Added Features
* [All stores] Added APIs for activated subscription query and unconsumed purchase query

### NHN Cloud OCR
#### Added Features
* Added OCR(Credit Card Recognizer)

## 1.0.0 (2022. 07. 12.)
### Common
#### Improvements
* Improved stability
* Changed the module name to NHN Cloud SDK
	* TOAST SDK has been deprecated.

## 0.30.0 (2022. 03. 29.)
### TOAST IAP
#### Added Features
* Added a property to check whether the payment is sandbox payment or not (sandboxPayment) to ToastPurchaseResult

## 0.29.2 (2021. 11. 23.)
### TOAST Push

#### Improvements
* Improved stability

## 0.29.1 (2021. 10. 26.)
### TOAST IAP
#### Improvements
* Improved stability

## 0.29.0 (2021. 07. 06.)
### Common
#### Improvements
* Improved stability

### TOAST IAP
#### Added Features
* Added a monthly payment limit feature

## 0.28.0 (2021. 05. 25.)
### Common
#### Improvements
* Added xcframework
    * Added support for arm Simulator

### TOAST Logger
#### CrashReporter (BuildInfo 20210525)
* Improved the way to classify architectures
    * Fixed an issue where iOS14 Core Library is not symbolicated

## 0.27.2 (2021. 03. 23.)
### Common
#### Improvements
* Improved stability

### TOAST Logger
#### SymbolUploader (v0.0.1)
* Added SymbolUploader

## 0.27.1 (2020. 11. 24.)
### TOAST IAP
#### Improvements
* Subscription product resubscription error revision (iOS 14 )
- Changed ToastProductsResponse to return nil when failing to get product info from the Appstore

### TOAST Push
#### Improvements
* Improved problem where callback did not occur upon a token disable request and there were no registered tokens

## 0.27.0 (2020. 09. 11.)
### TOAST IAP
#### Added Features
* Add localized product information (localizedTitle, localizedDescription) to ToastProduct

#### Improvements
* Handled iOS 14 beta changes
     * Fixed an issue where payment failure Delegate is not received

### TOAST Push
#### Improvements
* Improved stability

## 0.26.0 (2020. 07. 28.)
### TOAST Push
#### Added Features
* User tag feature support

## 0.25.1 (2020. 07. 03.)
### TOAST Logger
#### Improvements
* Improved stability

### TOAST Push
#### Improvements
* Improved stability

## 0.25.0 (2020. 06. 23.)
### Common
#### Improvements
* Improved stability

### TOAST Push
#### Improvements
* Separate notification options setting interface

## 0.24.1 (2020. 05. 26.)
### TOAST Push
#### Improvements
* Improved token registration function

## 0.24.0 (2020. 04. 28.)
### Common
* Raised the minimum supported version for TOAST SDK (iOS 8.0 -> iOS 9.0)
* Improved stability

### TOAST IAP
#### Added Features
* Added Optional Delegate to allow you to choose whether to proceed with the promotional payment

### TOAST Push
#### Improvements
* Improved stability

## 0.23.0 (2020. 03. 24.)
### TOAST Logger
#### Improvements
* Fixed an issue where CrashReport CallStack could contain invalid strings

### TOAST Push
#### Added Features
* Added notification option setting function
     * At initialization, it is possible to set whether to expose foreground notifications, use badge icons, and use notification sounds.

## 0.22.1 (2020. 02. 25.)
### TOAST Push
#### Improvements
* Improved token registration function
    * If a user ID is not set at the time of initial token registration, it is registered using the device identifier.
    * If you set or change the user ID after registering the token, the token information is updated.

## 0.22.0 (2020. 02. 11.)
### TOAST IAP
#### Improvements
* Improved stability

## 0.21.0 (2019. 12. 24.)
### TOAST Logger
#### Improvements
* Added data to improve the classification method of crash occurrence location

### TOAST IAP
#### Improvements
* Added API security function
* Improved stability
* Defined Swift interface additionally

## 0.20.1 (2019. 12. 04.)

### Common

#### Improvements

* Improved initialization logic

## 0.20.0 (2019. 11. 26.)

### TOAST Push

#### Improvements

* Changed token registration/deletion result notification to callback structure, delete delegate
* Added a feature to re-register tokens with previously registered agreement information
* Separated the VoIP function into a submodule
* Defined Swift interface additionally

## 0.19.3 (2019. 10. 29.)

### Common

#### Bug Fixes

* Fixed a linker error that occurs under Xcode 11

## 0.19.2 (2019. 10. 25.)

### TOAST Push

#### Improvements

* Supports migration of (old) TCPushSDK

## 0.19.1 (2019. 10. 18.)

### TOAST Push

#### Improvements

* Improved token registration function

## 0.19.0 (2019. 10. 15.)

### TOAST Push

#### Added Features

* Added notification feature for notification execution

## 0.18.0 (2019. 10. 01.)

### Common

#### Improvements

* Handles iOS 13 / Xcode 11

### TOAST IAP

#### Added Features

* Added user data setting function when requesting a purchase

#### Improvements

* Changed to return only the restored payment after performing the restore function

### TOAST Push

#### Improvements

* Changed the Nullability property of the ToastPushConfiguration object
* Deleted the sourceType and extension properties of the ToastPushMedia object by improving the rich message generation logic
* Supports Korean URLs in the source information of rich messages

#### Bug Fixes

* Fixed a bug where rich messages were not displayed properly when the message reception/checking function is disabled in the console settings
* Fixed a bug where a device token could not be acquired in environments of iOS 13 or higher

## 0.17.0 (2019. 08. 27.)

### Common

#### Improvements
* Improved stability

### TOAST IAP

#### Added Features

* Added auto-renewable consumable subscription products

#### Improvements

* Fixed a problem that a valid product list was returned to invalidProducts when querying the product list

### TOAST Push

#### Improvements

* Improved so that the default notification sound is set when sending push messages without setting a notification sounds

## 0.16.1 (2019. 07. 29.)

### Common

#### Improvements
* Fixed an issue where the country code cannot be obtained

## 0.16.0 (2019. 07. 23.)

### TOAST Logger

#### Improvements
* Improved to include symbol string in CrashReport CallStack for binaries with symbols
* Fixed an issue where CrashReport Reason is not displayed

### TOAST IAP

#### Improvements

* Fixed an issue where the status changes from successful payment status to previous payment status
* Fixed an issue where payment was requested when in-app purchases were not allowed
* Improved promotional payment

### TOAST Push

#### Improvements

* Changed message/action receiving delegate

## 0.15.0 (2019. 06. 25.)

### TOAST IAP

#### Improvements

* Added reprocessing logic for incomplete payment when requesting query for new payment, promotion payment, or unconsumed history

### TOAST Push

#### Added Features

* Added country code and language code setting function during initialization
* Added token information update function
* Added notification option setting function

#### Improvements

* Changed the default settings of notification options
    * Changed to not display notifications while the app is running
        * For the same behavior as before, check [here](./push-ios/#_6).

## 0.14.1 (2019. 05. 16.)

### TOAST IAP

#### Improvements

* Improved an issue where the user purchases the same product as the reprocessing payment case being processed, it is processed as the product owned by the user

### TOAST Push

#### Improvements

* Fixed a bug in which the event occurrence time was incorrectly collected according to the device's calendar setting

## 0.14.0 (2019. 05. 14.)

### Common

#### Improvements

* Integrated network-related error codes
* Improved stability

### TOAST IAP

#### Improvements

* Improved purchase restore function
    * Added a function to restore missing payments based on AppStore purchase history
    * Added restore failure error codes
* Added whether it is store request (promotion) or not to the payment result class
* Expanded reprocessing targets
* Improved payment flow

### TOAST Push

#### Improvements

* Improved stability
* Added message ID information to payload information passed to the message-receiving delegate
* In the case of VoIP where agreement to receive advertising messages or night-time advertising messages is unnecessary, messages are received regardless of the agreement for message reception.

## 0.13.0 (2019. 03. 26.)

### Common

#### Improvements

* Improved usability of Public Class
  * Add Description
  * Support Nullability, NSCoding, NSCopying

### TOAST Core

#### Improvements

* Added internal exception handling

### TOAST Logger

#### Added Features

* Support for crash analysis of devices using arm64e architecture
* Changed PLCrashReporter Dependency

#### Improvements

* Changed Configuration Interface
  * Deprecate
    * configurationWithProjectKey
  * Add
    * configurationWithAppKey

* Fixed an issue where the UserID of the transferred log may not be updated depending on the user ID setting time

### TOAST IAP

#### Improvements

* Added internal exception handling

### TOAST Push

#### Added Features

* Added token deletion API

## 0.12.4 (2019. 03. 19.)

### TOAST Core

#### Improvements

* Added exception handling

## 0.12.3 (2019. 02. 26.)

### TOAST Core, Common

#### Improvements

* Added exception handling for utility function

### TOAST IAP

#### Improvements

* Added product information caching
* Added exception handling

## 0.12.2 (2019. 02. 08.) - Hotfix

### TOAST Core

#### Improvements

* Added defense code to prevent intermittent crashes in ToastTransfer

## 0.12.1 (2019. 01. 08.)

### TOAST IAP

#### Improvements

* Fixed an issue where reprocessing of payments whose payment status is VerifyEnd did not work under certain circumstances

## 0.12.0 (2018. 12. 27.)

### TOAST Core

#### Improvements

* Added defense code to prevent intermittent crashes in ToastTransfer

### TOAST Push

#### Added Features

* Added new features

### TOAST IAP

#### Improvements

* Added exception handling of UserID Check logic to enable transaction processing reprocessed by Apple
* Added defense code to prevent intermittent crashes in ToastOperation


## 0.11.1 (2018. 12. 04.)

### TOAST IAP

#### Added Features

* Added new features


## 0.11.0 (2018. 11. 20.)

### TOAST Log & Crash

#### Added Features

* Added Network Insights function


## 0.9.0 (2018. 09. 04.)

### TOAST Log & Crash

#### Added Features

* Added new features
