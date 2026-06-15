<!-- pre-align:aligned sig=58f2c1b24700 -->

## NHN Cloud > SDK User Guide > Release Notes > iOS

<a id="90-2025-04-29"></a>

## 1.9.0 (2025. 04. 29.)
<a id="nhn-cloud-push"></a>

### NHN Cloud Push
<a id="added-features"></a>

#### Added Features 
* Added Notification Hub 
    * NHN Cloud Push SDK supports Notification Hub
    * You can use it by setting the value NHNCloudPushServiceTypeNotificationHub in the serviceType property of NHNCloudPushConfiguration.

<a id="86-2024-11-15"></a>

## 1.8.6 (2024. 11. 15.)
<a id="nhn-cloud-push-2"></a>

### NHN Cloud Push
<a id="improved"></a>

#### Improved
* Added API to set device ID 

<a id="85-2024-10-08"></a>

## 1.8.5 (2024. 10. 08.)
<a id="nhn-cloud-iap"></a>

### NHN Cloud IAP
<a id="improved-2"></a>

#### Improved
* Improved the feature to send payment details

<a id="84-2024-09-11"></a>

## 1.8.4 (2024. 09. 11.)
<a id="nhn-cloud-push-3"></a>

### NHN Cloud Push
<a id="improved-3"></a>

#### Improved
* Fixed duplicate notification issue (iOS 18 Beta)
    * Improved so that duplicate notifications are not received when an application is in the foreground in iOS 18 (OS bugs).

<a id="83-2024-07-23"></a>

## 1.8.3 (2024. 07. 23.)
<a id="common"></a>

### Common
<a id="improved-4"></a>

#### Improved
* Improved stability

<a id="82-2024-06-25"></a>

## 1.8.2 (2024. 06. 25.)
<a id="common-2"></a>

### Common
<a id="improved-5"></a>

#### Improved
* Improved stability

<a id="81-2024-02-27"></a>

## 1.8.1 (2024. 02. 27.)
<a id="common-3"></a>

### Common
<a id="improved-6"></a>

#### Improved
* Applied Privacy manifest

<a id="nhn-cloud-push-4"></a>

### NHN Cloud Push
<a id="improved-7"></a>

#### Improved
* Fixed an issue where message click actions do not work immediately in certain environments

<a id="80-2024-01-23"></a>

## 1.8.0 (2024. 01. 23.)
<a id="nhn-cloud-iap-2"></a>

### NHN Cloud IAP
<a id="improved-8"></a>

#### Improved
* Improved payment verification methods
    * Improved to enable (old) receipt verification in new SDKs
        * [(New) Receipt verification + Notification V2](/Mobile%20Service/IAP/en/console-apple-guide/#new-receipt-verification-notification-v2)
        * [(Old) Receipt verification + Notification V1 (Deprecated)](/Mobile%20Service/IAP/en/console-apple-guide/#old-receipt-verification-notification-v1-soon-to-be-deprecated)

<a id="71-2023-12-19"></a>

## 1.7.1 (2023. 12. 19.)
<a id="common-4"></a>

### Common
<a id="improved-9"></a>

#### Improved
* Signature applied
    * Applied the `NHN Cloud Corp.` signature to the binaries being distributed.

<a id="logger"></a>

### Logger 
<a id="improved-10"></a>

#### Improved
* Improved NetworkInsight stability of Instance Logger

<a id="symboluploaderv004"></a>

### SymbolUploader(v0.0.4)
<a id="improved-11"></a>

#### Improved
* Improved stability

<a id="70-2023-11-14"></a>

## 1.7.0 (2023. 11. 14.)
<a id="common-5"></a>

### Common
<a id="improved-12"></a>

#### Improved
* Raised the minimum supported version
    * 9.0 > 11.0
* Ended support for architectures
    *  i386, armv7s, armv7

<a id="nhn-cloud-iap-3"></a>

### NHN Cloud IAP
<a id="improved-13"></a>

#### Improved
* Changed payment verification methods - [(New) Receipt verification + Notification V2](/Mobile%20Service/IAP/en/console-apple-guide/#new-receipt-verification-notification-v2)

<a id="62-2023-08-29"></a>

## 1.6.2 (2023. 08. 29.)
<a id="common-6"></a>

### Common
<a id="improved-14"></a>

#### Improved
* Fixed an issue where CountryCode is not obtained

<a id="nhn-cloud-ocr"></a>

### NHN Cloud OCR
<a id="added-features-2"></a>

#### Added Features
* Added recognition area in the result of credit card/ID card recognition

<a id="61-2023-07-25"></a>

## 1.6.1 (2023. 07. 25.)
<a id="nhn-cloud-iap-4"></a>

### NHN Cloud IAP
<a id="improved-15"></a>

#### Improved
* Improved the feature to send payment details

<a id="60-2023-07-11"></a>

## 1.6.0 (2023. 07. 11.)
<a id="nhn-cloud-ocr-2"></a>

### NHN Cloud OCR
<a id="added-features-3"></a>

#### Added Features
* Added OCR (ID Card Recognizer)

<a id="50-2023-06-27"></a>

## 1.5.0 (2023. 06. 27.)
<a id="nhn-cloud-push-5"></a>

### NHN Cloud Push
<a id="improved-16"></a>

#### Improved
* Improved the token registration feature
    * Provided the option to register a token regardless of the app's notification permissions.

<a id="symboluploaderv003"></a>

#### SymbolUploader(v0.0.3)
* Improved stability

<a id="40-2023-05-30"></a>

## 1.4.0 (2023. 05. 30.)
<a id="common-7"></a>

### Common
<a id="improved-17"></a>

#### Improved
* Added the SPM(swift package manager) deployment method

<a id="nhn-cloud-iap-5"></a>

### NHN Cloud IAP
<a id="added-featrues"></a>

#### Added Featrues
* Added a feature to send payment details 
    * You can view payment details on the Transaction tab in the IAP console.

<a id="symboluploaderv002"></a>

#### SymbolUploader(v0.0.2)
* Improved run script
    * Added support for Cocoapods, SPM

<a id="31-2023-05-19---hotfix"></a>

## 1.3.1 (2023. 05. 19.) - Hotfix
<a id="nhn-cloud-push-6"></a>

### NHN Cloud Push
<a id="improved-18"></a>

#### Improved
* Improved the token registration feature
    * When registering a token, if the notification setting of the app is disabled, `NHNCloudPushErrorPermissionDenied` is returned again.
    
<a id="30-2023-02-28"></a>

## 1.3.0 (2023. 02. 28.)
<a id="common-8"></a>

### Common
<a id="improved-19"></a>

#### Improved
* Improved stability

<a id="21-2023-01-31"></a>

## 1.2.1 (2023. 01. 31.)
<a id="nhn-cloud-push-7"></a>

### NHN Cloud Push

<a id="improved-20"></a>

#### Improved
* Improved token registration function

<a id="nhn-cloud-ocr-3"></a>

### NHN Cloud OCR
<a id="improved-21"></a>

#### Improved
* Improved credit card recognition performance
* Improved stability

<a id="20-2022-11-29"></a>

## 1.2.0 (2022. 11. 29.)
<a id="nhn-cloud-logger"></a>

### NHN Cloud Logger
<a id="added-features-4"></a>

#### Added Features
* Added support for Logger for government agencies

<a id="nhn-cloud-push-8"></a>

### NHN Cloud Push
<a id="improved-22"></a>

#### Improved
* Improved sending push events

<a id="nhn-cloud-ocr-4"></a>

### NHN Cloud OCR
<a id="improved-23"></a>

#### Improved
* Improved UI

<a id="10-2022-10-25"></a>

## 1.1.0 (2022. 10. 25.)
<a id="common-9"></a>

### Common
<a id="improvements"></a>

#### Improvements
* Improved stability

<a id="nhn-cloud-iap-6"></a>

### NHN Cloud IAP
<a id="added-features-5"></a>

#### Added Features
* [All stores] Added APIs for activated subscription query and unconsumed purchase query

<a id="nhn-cloud-ocr-5"></a>

### NHN Cloud OCR
<a id="added-features-6"></a>

#### Added Features
* Added OCR(Credit Card Recognizer)

<a id="00-2022-07-12"></a>

## 1.0.0 (2022. 07. 12.)
<a id="common-10"></a>

### Common
<a id="improvements-2"></a>

#### Improvements
* Improved stability
* Changed the module name to NHN Cloud SDK
	* TOAST SDK has been deprecated.

<a id="300-2022-03-29"></a>

## 0.30.0 (2022. 03. 29.)
<a id="toast-iap"></a>

### TOAST IAP
<a id="added-features-7"></a>

#### Added Features
* Added a property to check whether the payment is sandbox payment or not (sandboxPayment) to ToastPurchaseResult

<a id="292-2021-11-23"></a>

## 0.29.2 (2021. 11. 23.)
<a id="toast-push"></a>

### TOAST Push

<a id="improvements-3"></a>

#### Improvements
* Improved stability

<a id="291-2021-10-26"></a>

## 0.29.1 (2021. 10. 26.)
<a id="toast-iap-2"></a>

### TOAST IAP
<a id="improvements-4"></a>

#### Improvements
* Improved stability

<a id="290-2021-07-06"></a>

## 0.29.0 (2021. 07. 06.)
<a id="common-11"></a>

### Common
<a id="improvements-5"></a>

#### Improvements
* Improved stability

<a id="toast-iap-3"></a>

### TOAST IAP
<a id="added-features-8"></a>

#### Added Features
* Added a monthly payment limit feature

<a id="280-2021-05-25"></a>

## 0.28.0 (2021. 05. 25.)
<a id="common-12"></a>

### Common
<a id="improvements-6"></a>

#### Improvements
* Added xcframework
    * Added support for arm Simulator

<a id="toast-logger"></a>

### TOAST Logger
<a id="crashreporter-buildinfo-20210525"></a>

#### CrashReporter (BuildInfo 20210525)
* Improved the way to classify architectures
    * Fixed an issue where iOS14 Core Library is not symbolicated

<a id="272-2021-03-23"></a>

## 0.27.2 (2021. 03. 23.)
<a id="common-13"></a>

### Common
<a id="improvements-7"></a>

#### Improvements
* Improved stability

<a id="toast-logger-2"></a>

### TOAST Logger
<a id="symboluploader-v001"></a>

#### SymbolUploader (v0.0.1)
* Added SymbolUploader

<a id="271-2020-11-24"></a>

## 0.27.1 (2020. 11. 24.)
<a id="toast-iap-4"></a>

### TOAST IAP
<a id="improvements-8"></a>

#### Improvements
* Subscription product resubscription error revision (iOS 14 )
- Changed ToastProductsResponse to return nil when failing to get product info from the Appstore

<a id="toast-push-2"></a>

### TOAST Push
<a id="improvements-9"></a>

#### Improvements
* Improved problem where callback did not occur upon a token disable request and there were no registered tokens

<a id="270-2020-09-11"></a>

## 0.27.0 (2020. 09. 11.)
<a id="toast-iap-5"></a>

### TOAST IAP
<a id="added-features-9"></a>

#### Added Features
* Add localized product information (localizedTitle, localizedDescription) to ToastProduct

<a id="improvements-10"></a>

#### Improvements
* Handled iOS 14 beta changes
     * Fixed an issue where payment failure Delegate is not received

<a id="toast-push-3"></a>

### TOAST Push
<a id="improvements-11"></a>

#### Improvements
* Improved stability

<a id="260-2020-07-28"></a>

## 0.26.0 (2020. 07. 28.)
<a id="toast-push-4"></a>

### TOAST Push
<a id="added-features-10"></a>

#### Added Features
* User tag feature support

<a id="251-2020-07-03"></a>

## 0.25.1 (2020. 07. 03.)
<a id="toast-logger-3"></a>

### TOAST Logger
<a id="improvements-12"></a>

#### Improvements
* Improved stability

<a id="toast-push-5"></a>

### TOAST Push
<a id="improvements-13"></a>

#### Improvements
* Improved stability

<a id="250-2020-06-23"></a>

## 0.25.0 (2020. 06. 23.)
<a id="common-14"></a>

### Common
<a id="improvements-14"></a>

#### Improvements
* Improved stability

<a id="toast-push-6"></a>

### TOAST Push
<a id="improvements-15"></a>

#### Improvements
* Separate notification options setting interface

<a id="241-2020-05-26"></a>

## 0.24.1 (2020. 05. 26.)
<a id="toast-push-7"></a>

### TOAST Push
<a id="improvements-16"></a>

#### Improvements
* Improved token registration function

<a id="240-2020-04-28"></a>

## 0.24.0 (2020. 04. 28.)
<a id="common-15"></a>

### Common
* Raised the minimum supported version for TOAST SDK (iOS 8.0 -> iOS 9.0)
* Improved stability

<a id="toast-iap-6"></a>

### TOAST IAP
<a id="added-features-11"></a>

#### Added Features
* Added Optional Delegate to allow you to choose whether to proceed with the promotional payment

<a id="toast-push-8"></a>

### TOAST Push
<a id="improvements-17"></a>

#### Improvements
* Improved stability

<a id="230-2020-03-24"></a>

## 0.23.0 (2020. 03. 24.)
<a id="toast-logger-4"></a>

### TOAST Logger
<a id="improvements-18"></a>

#### Improvements
* Fixed an issue where CrashReport CallStack could contain invalid strings

<a id="toast-push-9"></a>

### TOAST Push
<a id="added-features-12"></a>

#### Added Features
* Added notification option setting function
     * At initialization, it is possible to set whether to expose foreground notifications, use badge icons, and use notification sounds.

<a id="221-2020-02-25"></a>

## 0.22.1 (2020. 02. 25.)
<a id="toast-push-10"></a>

### TOAST Push
<a id="improvements-19"></a>

#### Improvements
* Improved token registration function
    * If a user ID is not set at the time of initial token registration, it is registered using the device identifier.
    * If you set or change the user ID after registering the token, the token information is updated.

<a id="220-2020-02-11"></a>

## 0.22.0 (2020. 02. 11.)
<a id="toast-iap-7"></a>

### TOAST IAP
<a id="improvements-20"></a>

#### Improvements
* Improved stability

<a id="210-2019-12-24"></a>

## 0.21.0 (2019. 12. 24.)
<a id="toast-logger-5"></a>

### TOAST Logger
<a id="improvements-21"></a>

#### Improvements
* Added data to improve the classification method of crash occurrence location

<a id="toast-iap-8"></a>

### TOAST IAP
<a id="improvements-22"></a>

#### Improvements
* Added API security function
* Improved stability
* Defined Swift interface additionally

<a id="201-2019-12-04"></a>

## 0.20.1 (2019. 12. 04.)

<a id="common-16"></a>

### Common

<a id="improvements-23"></a>

#### Improvements

* Improved initialization logic

<a id="200-2019-11-26"></a>

## 0.20.0 (2019. 11. 26.)

<a id="toast-push-11"></a>

### TOAST Push

<a id="improvements-24"></a>

#### Improvements

* Changed token registration/deletion result notification to callback structure, delete delegate
* Added a feature to re-register tokens with previously registered agreement information
* Separated the VoIP function into a submodule
* Defined Swift interface additionally

<a id="193-2019-10-29"></a>

## 0.19.3 (2019. 10. 29.)

<a id="common-17"></a>

### Common

<a id="bug-fixes"></a>

#### Bug Fixes

* Fixed a linker error that occurs under Xcode 11

<a id="192-2019-10-25"></a>

## 0.19.2 (2019. 10. 25.)

<a id="toast-push-12"></a>

### TOAST Push

<a id="improvements-25"></a>

#### Improvements

* Supports migration of (old) TCPushSDK

<a id="191-2019-10-18"></a>

## 0.19.1 (2019. 10. 18.)

<a id="toast-push-13"></a>

### TOAST Push

<a id="improvements-26"></a>

#### Improvements

* Improved token registration function

<a id="190-2019-10-15"></a>

## 0.19.0 (2019. 10. 15.)

<a id="toast-push-14"></a>

### TOAST Push

<a id="added-features-13"></a>

#### Added Features

* Added notification feature for notification execution

<a id="180-2019-10-01"></a>

## 0.18.0 (2019. 10. 01.)

<a id="common-18"></a>

### Common

<a id="improvements-27"></a>

#### Improvements

* Handles iOS 13 / Xcode 11

<a id="toast-iap-9"></a>

### TOAST IAP

<a id="added-features-14"></a>

#### Added Features

* Added user data setting function when requesting a purchase

<a id="improvements-28"></a>

#### Improvements

* Changed to return only the restored payment after performing the restore function

<a id="toast-push-15"></a>

### TOAST Push

<a id="improvements-29"></a>

#### Improvements

* Changed the Nullability property of the ToastPushConfiguration object
* Deleted the sourceType and extension properties of the ToastPushMedia object by improving the rich message generation logic
* Supports Korean URLs in the source information of rich messages

<a id="bug-fixes-2"></a>

#### Bug Fixes

* Fixed a bug where rich messages were not displayed properly when the message reception/checking function is disabled in the console settings
* Fixed a bug where a device token could not be acquired in environments of iOS 13 or higher

<a id="170-2019-08-27"></a>

## 0.17.0 (2019. 08. 27.)

<a id="common-19"></a>

### Common

<a id="improvements-30"></a>

#### Improvements
* Improved stability

<a id="toast-iap-10"></a>

### TOAST IAP

<a id="added-features-15"></a>

#### Added Features

* Added auto-renewable consumable subscription products

<a id="improvements-31"></a>

#### Improvements

* Fixed a problem that a valid product list was returned to invalidProducts when querying the product list

<a id="toast-push-16"></a>

### TOAST Push

<a id="improvements-32"></a>

#### Improvements

* Improved so that the default notification sound is set when sending push messages without setting a notification sounds

<a id="161-2019-07-29"></a>

## 0.16.1 (2019. 07. 29.)

<a id="common-20"></a>

### Common

<a id="improvements-33"></a>

#### Improvements
* Fixed an issue where the country code cannot be obtained

<a id="160-2019-07-23"></a>

## 0.16.0 (2019. 07. 23.)

<a id="toast-logger-6"></a>

### TOAST Logger

<a id="improvements-34"></a>

#### Improvements
* Improved to include symbol string in CrashReport CallStack for binaries with symbols
* Fixed an issue where CrashReport Reason is not displayed

<a id="toast-iap-11"></a>

### TOAST IAP

<a id="improvements-35"></a>

#### Improvements

* Fixed an issue where the status changes from successful payment status to previous payment status
* Fixed an issue where payment was requested when in-app purchases were not allowed
* Improved promotional payment

<a id="toast-push-17"></a>

### TOAST Push

<a id="improvements-36"></a>

#### Improvements

* Changed message/action receiving delegate

<a id="150-2019-06-25"></a>

## 0.15.0 (2019. 06. 25.)

<a id="toast-iap-12"></a>

### TOAST IAP

<a id="improvements-37"></a>

#### Improvements

* Added reprocessing logic for incomplete payment when requesting query for new payment, promotion payment, or unconsumed history

<a id="toast-push-18"></a>

### TOAST Push

<a id="added-features-16"></a>

#### Added Features

* Added country code and language code setting function during initialization
* Added token information update function
* Added notification option setting function

<a id="improvements-38"></a>

#### Improvements

* Changed the default settings of notification options
    * Changed to not display notifications while the app is running
        * For the same behavior as before, check [here](./push-ios/#_6).

<a id="141-2019-05-16"></a>

## 0.14.1 (2019. 05. 16.)

<a id="toast-iap-13"></a>

### TOAST IAP

<a id="improvements-39"></a>

#### Improvements

* Improved an issue where the user purchases the same product as the reprocessing payment case being processed, it is processed as the product owned by the user

<a id="toast-push-19"></a>

### TOAST Push

<a id="improvements-40"></a>

#### Improvements

* Fixed a bug in which the event occurrence time was incorrectly collected according to the device's calendar setting

<a id="140-2019-05-14"></a>

## 0.14.0 (2019. 05. 14.)

<a id="common-21"></a>

### Common

<a id="improvements-41"></a>

#### Improvements

* Integrated network-related error codes
* Improved stability

<a id="toast-iap-14"></a>

### TOAST IAP

<a id="improvements-42"></a>

#### Improvements

* Improved purchase restore function
    * Added a function to restore missing payments based on AppStore purchase history
    * Added restore failure error codes
* Added whether it is store request (promotion) or not to the payment result class
* Expanded reprocessing targets
* Improved payment flow

<a id="toast-push-20"></a>

### TOAST Push

<a id="improvements-43"></a>

#### Improvements

* Improved stability
* Added message ID information to payload information passed to the message-receiving delegate
* In the case of VoIP where agreement to receive advertising messages or night-time advertising messages is unnecessary, messages are received regardless of the agreement for message reception.

<a id="130-2019-03-26"></a>

## 0.13.0 (2019. 03. 26.)

<a id="common-22"></a>

### Common

<a id="improvements-44"></a>

#### Improvements

* Improved usability of Public Class
  * Add Description
  * Support Nullability, NSCoding, NSCopying

<a id="toast-core"></a>

### TOAST Core

<a id="improvements-45"></a>

#### Improvements

* Added internal exception handling

<a id="toast-logger-7"></a>

### TOAST Logger

<a id="added-features-17"></a>

#### Added Features

* Support for crash analysis of devices using arm64e architecture
* Changed PLCrashReporter Dependency

<a id="improvements-46"></a>

#### Improvements

* Changed Configuration Interface
  * Deprecate
    * configurationWithProjectKey
  * Add
    * configurationWithAppKey

* Fixed an issue where the UserID of the transferred log may not be updated depending on the user ID setting time

<a id="toast-iap-15"></a>

### TOAST IAP

<a id="improvements-47"></a>

#### Improvements

* Added internal exception handling

<a id="toast-push-21"></a>

### TOAST Push

<a id="added-features-18"></a>

#### Added Features

* Added token deletion API

<a id="124-2019-03-19"></a>

## 0.12.4 (2019. 03. 19.)

<a id="toast-core-2"></a>

### TOAST Core

<a id="improvements-48"></a>

#### Improvements

* Added exception handling

<a id="123-2019-02-26"></a>

## 0.12.3 (2019. 02. 26.)

<a id="toast-core-common"></a>

### TOAST Core, Common

<a id="improvements-49"></a>

#### Improvements

* Added exception handling for utility function

<a id="toast-iap-16"></a>

### TOAST IAP

<a id="improvements-50"></a>

#### Improvements

* Added product information caching
* Added exception handling

<a id="122-2019-02-08---hotfix"></a>

## 0.12.2 (2019. 02. 08.) - Hotfix

<a id="toast-core-3"></a>

### TOAST Core

<a id="improvements-51"></a>

#### Improvements

* Added defense code to prevent intermittent crashes in ToastTransfer

<a id="121-2019-01-08"></a>

## 0.12.1 (2019. 01. 08.)

<a id="toast-iap-17"></a>

### TOAST IAP

<a id="improvements-52"></a>

#### Improvements

* Fixed an issue where reprocessing of payments whose payment status is VerifyEnd did not work under certain circumstances

<a id="120-2018-12-27"></a>

## 0.12.0 (2018. 12. 27.)

<a id="toast-core-4"></a>

### TOAST Core

<a id="improvements-53"></a>

#### Improvements

* Added defense code to prevent intermittent crashes in ToastTransfer

<a id="toast-push-22"></a>

### TOAST Push

<a id="added-features-19"></a>

#### Added Features

* Added new features

<a id="toast-iap-18"></a>

### TOAST IAP

<a id="improvements-54"></a>

#### Improvements

* Added exception handling of UserID Check logic to enable transaction processing reprocessed by Apple
* Added defense code to prevent intermittent crashes in ToastOperation


<a id="111-2018-12-04"></a>

## 0.11.1 (2018. 12. 04.)

<a id="toast-iap-19"></a>

### TOAST IAP

<a id="added-features-20"></a>

#### Added Features

* Added new features


<a id="110-2018-11-20"></a>

## 0.11.0 (2018. 11. 20.)

<a id="toast-log-crash"></a>

### TOAST Log & Crash

<a id="added-features-21"></a>

#### Added Features

* Added Network Insights function


<a id="90-2018-09-04"></a>

## 0.9.0 (2018. 09. 04.)

<a id="toast-log-crash-2"></a>

### TOAST Log & Crash

<a id="added-features-22"></a>

#### Added Features

* Added new features
