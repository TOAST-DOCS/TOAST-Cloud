<!-- pre-align:aligned sig=df783d99cb29 -->

## NHN Cloud > SDK User Guide > Release Notes > Android

<a id="121-october-28-2025"></a>

## 1.12.1 (October 28, 2025)

<a id="nhn-cloud-ocr"></a>

### NHN Cloud OCR

<a id="bug-fixes"></a>

#### Bug Fixes

* Respond for foldable devices (Fold series)
    * Fixed an issue where the portrait mode guide area would go off screen during credit card recognition.
* Improved the camera preview synchronization

<a id="120-july-29-2025"></a>

## 1.12.0 (July 29, 2025)

<a id="nhn-cloud-sdk"></a>

### NHN Cloud SDK

<a id="improved"></a>

#### Improved

* Raised the minimum supported version
    * The minimum supported version of Android has been changed from API 16(Android 4.1) to API 22(Android 5.1).
    * Some APIs used in the NHN Cloud Android SDK will soon no longer support TLS 1.0 and TLS 1.1, and will only support TLS 1.2 or higher.	
    * This is a security enhancement measure. Please note that even if you do not update the SDK, some APIs may not function properly when using versions below v1.12.0 in environments running Android 5.1 (API level 22) or lower.
* Supports 16KB page size
    * Starting November 1, 2025, all new apps and app updates targeting Android 15 (API level 34) or higher submitted to Google Play will be required to support 16KB page size on 64-bit devices.
    * NHN Cloud SDK supports 16KB page size.
    * Supported modules
        * NHN Cloud Logger
        * NHN Cloud OCR

<a id="nhn-cloud-ocr-2"></a>

### NHN Cloud OCR

<a id="fixed"></a>

#### Fixed

* Improved the camera preview synchronization
    * Enhanced the synchronization logic between the camera preview display and the Surface buffer resolution.

<a id="111-june-5-2025"></a>

## 1.11.1 (June 5, 2025)

<a id="nhn-cloud-push"></a>

### NHN Cloud Push

<a id="fixed-2"></a>

#### Fixed

* Fixed Notification Hub API domain errors
    * Fixed an incorrectly set Notification Hub API domain to resolve an API call error.

<a id="110-april-29-2025"></a>

## 1.11.0 (April 29, 2025)

<a id="nhn-cloud-push-2"></a>

### NHN Cloud Push

<a id="added"></a>

#### Added

* Added Notification Hub
    * NHN Cloud Push SDK supports Notification Hub.
    * You can use it by setting PushServiceType.NOTIFICATION_HUB in the NhnCloudPushConfiguration.Builder.setServiceType(String) method.

<a id="100-march-25-2025"></a>

## 1.10.0 (March 25, 2025)

<a id="nhn-cloud-iap"></a>

### NHN Cloud IAP

<a id="added-2"></a>

#### Added

* ONE store version integration
    * Integrated ONE store v17, v19, and v21 into one version.
    * The nhncloud-iap-onestore2 module allows you to update ONE store IAP SDK to the integrated version.
    * Integration targets:
        * nhncloud-iap-onestore
        * nhncloud-iap-onestore-v19
        * nhncloud-iap-onestore-v21
* Supports ONE store subscription
    * Supports the subscription service in the ONE store integrated version (nhncloud-iap-onestore2).
    * This allows you to offer recurring payment-based service in ONE store.

<a id="improved-2"></a>

#### Improved

* Supports ONE store payment history logs
    * You can check the payment history logs in the console from ONE store integrated version (nhncloud-iap-onestore2).

<a id="95-january-23-2025"></a>

## 1.9.5 (January 23, 2025)

<a id="nhn-cloud-iap-2"></a>

### NHN Cloud IAP

<a id="improved-3"></a>

#### Improved

* Updated Google Play Billing Library(PBL)
    * Updated Google Play Billing Library(PBL) to 7.1.1.
* Raised the minimum supported version for NHN Cloud IAP Google Library
    * Raised the minimum supported version for NHN Cloud IAP Google Library(nhncloud-iap-google) to 21.

<a id="nhn-cloud-push-3"></a>

### NHN Cloud Push

<a id="improved-4"></a>

#### Improved

* Added Enable Vibration API
    * Added the feature to set whether to vibrate when you receive a notification.
    * You can use enableVibration(boolean) in NhnCloudNotificationOptions.Builder to set whether or not to vibrate.

<a id="94-november-15-2024"></a>

## 1.9.4 (November 15, 2024)

<a id="nhn-cloud-push-4"></a>

### NHN Cloud Push

<a id="improved-5"></a>

#### Improved

* Added the feature to set device ID
    * Added the NhnCloudPush.setDeviceId API to set a user's device ID in the Push service.
    
<a id="93-october-8-2024"></a>

## 1.9.3 (October 8, 2024)

<a id="nhn-cloud-iap-3"></a>

### NHN Cloud IAP

<a id="fixed-3"></a>

#### Fixed

* Fixed an issue in ONE store v19 and v21 where the value returned by the IapProductDetails.getLocalizedPrice() method does not include currency symbols.
    * Fixed to return in local currency format, such as '$1,000'.

<a id="nhn-cloud-push-5"></a>

### NHN Cloud Push

<a id="fixed-4"></a>

#### Fixed

* Fixed an incorrect error when the Google Services configuration file (google-services.json) is missing
    * Fixed an issue where a java.lang.ExceptionInInitializerError occurs instead of a java.lang.IllegalStateException.
    * IllegalStateException now occurs correctly.
    
<a id="92-august-27-2024"></a>

## 1.9.2 (August 27, 2024)

<a id="nhn-cloud-logger"></a>

### NHN Cloud Logger

<a id="fixed-5"></a>

#### Fixed

* Fixed Native Crash Reporting errors
    * Fixed an issue where Native Crash logs were intermittently not reported on certain devices on Android 13 and above.

<a id="nhn-cloud-iap-4"></a>

### NHN Cloud IAP

<a id="improved-6"></a>

#### Improved

* Improved Amazon payment reprocessing
    * Fixed an issue where, while reinstalling the app after uninstalling or deleting app data, failed payments are treated as new purchases when reprocessed.
  
<a id="91-july-23-2024"></a>

## 1.9.1 (July 23. 2024)

<a id="nhn-cloud-iap-5"></a>

### NHN Cloud IAP

<a id="improved-7"></a>

#### Improved

* Improved Amazon payment reprocessing
    * Fixed an issue where, when a payment failed during the purchase process, for example, due to closing the app or blocking the network, the failed payment would be treated as a new purchase when it was reprocessed.
* Updated ONE store SDK v19 (v19.01.00)
    * Apps targeting Android 14 (API Level 34) and above must use iap_sdk-v19.01.00.aar.

<a id="90-may-28-2024"></a>

## 1.9.0 (May 28. 2024)

<a id="nhn-cloud-iap-6"></a>

### NHN Cloud IAP

<a id="improved-8"></a>

#### Improved

* Updated Google Play Billing Library(PBL) 6.2.1
    * According to Google's policy, apps using PBL 5.x must be updated to PBL 6.x from November 1, 2024.
        * New app launched: August 1, 2024
        * Existing app updated: November 1, 2024
    * To support Android 4.4 (API 19), additional setings are required. For more information, see [NHN Cloud > SDK User Guide > IAP > Android](./iap-android).
* Raised the minimum supported version of Google IAP Library(nhncloud-iap-google) to version 19.
* Added the IapResult.NETWORK_ERROR code
    * Replaced IapResult.NETWORK_NOT_CONNECTED with IapResult.NETWORK_ERROR from NHN Cloud IAP 1.9.0.
    * Removed the response code of IapResult.NETWORK_NOT_CONNECTED.
* Added the statuses of **Canceled by USer** and **Pending Payment** to the payment history information.

<a id="fixed-6"></a>

#### Fixed

* Fixed an issue where, when switching the screen orientation after ONE store external payment, the status bar is displayed abnormally.

<a id="86-may-7-2024"></a>

## 1.8.6 (May 7. 2024)

<a id="nhn-cloud-ocr-3"></a>

### NHN Cloud OCR

<a id="fixed-7"></a>

#### Fixed

* Fixed an issue where credit card recognition fails due to network timeout.

<a id="85-february-27-2024"></a>

## 1.8.5 (February 27. 2024)

<a id="nhn-cloud-logger-2"></a>

### NHN Cloud Logger

<a id="fixed-8"></a>

#### Fixed

* Fixed an issue where crash logs are sent in duplicate.

<a id="84-january-25-2024"></a>

## 1.8.4 (January 25, 2024)

<a id="nhn-cloud-sdk-2"></a>

### NHN Cloud SDK

<a id="improved-9"></a>

#### Improved

* Improved stability
    * Fixed abnormal termination when Proguard is not applied

<a id="83-january-23-2024"></a>

## 1.8.3 (January 23, 2024)

<a id="nhn-cloud-iap-7"></a>

### NHN Cloud IAP

<a id="improved-10"></a>

#### Improved

* Updated MyCard SDK
    * Handles Android 14

<a id="82-december-19-2023"></a>

## 1.8.2 (December 19, 2023)

<a id="nhn-cloud-ocr-4"></a>

### NHN Cloud OCR

<a id="improved-11"></a>

#### Improved

* Improved stability

<a id="81-october-31-2023"></a>

## 1.8.1 (October 31, 2023)

<a id="nhn-cloud-ocr-5"></a>

### NHN Cloud OCR

<a id="improved-12"></a>

#### Improved
* Improved Credit Card Recognizer UI
    * TextView with enhanced security has been applied.

<a id="fixed-9"></a>

#### Fixed
* Fixed a Camera Focus issue
    * Fixed an issue where Auto Focus does not work on some low-end devices.

<a id="80-september-26-2023"></a>

## 1.8.0 (September 26, 2023)

<a id="nhn-cloud-iap-8"></a>

### NHN Cloud IAP

<a id="improved-13"></a>

#### Improved

* Updated Google Billing Client 5.2.1
    * According to Google's policy, apps targeting Android 14 or later must be updated to NHN Cloud IAP 1.8.0 or later.

<a id="nhn-cloud-ocr-6"></a>

### NHN Cloud OCR

<a id="improved-14"></a>

#### Improved

* Improved Camera
    * Modified the Camera Preview screen to fill the display.
* Raised the minimum supported version to API 22.

<a id="71-august-29-2023"></a>

## 1.7.1 (August 29, 2023)

<a id="nhn-cloud-iap-9"></a>

### NHN Cloud IAP

<a id="improved-15"></a>

#### Improved

* Improved MyCard test payment
* Raised the minimum supported verson of MyCard to API 21.

<a id="70-july-11-2023"></a>

## 1.7.0 (July 11, 2023)

<a id="nhn-cloud-ocr-7"></a>

### NHN Cloud OCR

<a id="added-3"></a>

#### Added

* Added OCR (ID Card Recognizer)

<a id="60-june-20-2023"></a>

## 1.6.0 (June 20, 2023)

<a id="nhn-cloud-iap-10"></a>

### NHN Cloud IAP

<a id="added-4"></a>

#### Added

* Added ONE store v21

<a id="nhn-cloud-logger-3"></a>

### NHN Cloud Logger

<a id="improved-16"></a>

#### Improved

* Support Android Gradle Plugin 8.0

<a id="51-may-30-2023"></a>

## 1.5.1 (May 30, 2023)

<a id="nhn-cloud-iap-11"></a>

### NHN Cloud IAP

<a id="added-5"></a>

#### Added

* Added a feature to send payment details
    * You can view payment details on the Transaction tab in the IAP console.

<a id="50-april-5-2023"></a>

## 1.5.0 (April 5, 2023)

<a id="nhn-cloud-sdk-3"></a>

### NHN Cloud SDK

<a id="improved-17"></a>

#### Improved

* Improved stability

<a id="nhn-cloud-iap-12"></a>

### NHN Cloud IAP

<a id="added-6"></a>

#### Added

* Added MyCard IAP

<a id="43-march-24-2023"></a>

## 1.4.3 (March 24, 2023)

<a id="nhn-cloud-ocr-8"></a>

### NHN Cloud OCR

<a id="fixed-10"></a>

#### Fixed

* Fixed a NoClassDefFoundError issue

<a id="42-february-28-2023"></a>

## 1.4.2 (February 28, 2023)

<a id="nhn-cloud-ocr-9"></a>

### NHN Cloud OCR

<a id="improved-18"></a>

#### Improved

* Improved stability

<a id="41-january-11-2023"></a>

## 1.4.1 (January 11, 2023)

<a id="nhn-cloud-push-6"></a>

### NHN Cloud Push

<a id="improved-19"></a>

#### Improved

* Improved sending push metrics and processing events

<a id="40-november-29-2022"></a>

## 1.4.0 (November 29, 2022)

<a id="nhn-cloud-logger-4"></a>

### NHN Cloud Logger

<a id="added-7"></a>

#### Added

* Added support for Logger for government agencies

<a id="nhn-cloud-ocr-10"></a>

### NHN Cloud OCR

<a id="improved-20"></a>

#### Improved

* Improved UI

<a id="fixed-11"></a>

#### Fixed

* Fixed a crash issue that occurred when initializing camera

<a id="nhn-cloud-push-7"></a>

### NHN Cloud Push

<a id="improved-21"></a>

#### Improved

* Improved sending push events
* Fixed an issue of changing flags in Intent
    * Fixed an issue where, when calling NhnCloudPushMessageReceiver.getContentIntent(), the flags set in the delivered Intent are not maintained.

<a id="30-october-25-2022"></a>

## 1.3.0 (October 25, 2022)

<a id="nhn-cloud-ocr-11"></a>

### NHN Cloud OCR

<a id="added-8"></a>

#### Added

* Added OCR(Credit Card Recognizer)

<a id="nhn-cloud-iap-13"></a>

### NHN Cloud IAP

<a id="added-9"></a>

#### Added

* [All stores] Added APIs for activated subscription query and unconsumed purchase query

<a id="nhn-cloud-push-8"></a>

### NHN Cloud Push

<a id="fixed-12"></a>

#### Fixed

* Fixed a bug where click events and metrics cannot be received when using ToastPushMessageReceiver in NHN Cloud SDK 1.0.0 or higher

<a id="20-october-4-2022"></a>

## 1.2.0 (October 4, 2022)

<a id="nhn-cloud-sdk-4"></a>

### NHN Cloud SDK

<a id="improved-22"></a>

#### Improved

* Added AndroidX support
    * The minimum supported version has increased to API 16.

<a id="nhn-cloud-push-9"></a>

### NHN Cloud Push

<a id="improved-23"></a>

#### Improved

* Handled issues related to Android 13
    * Added the API to request POST_NOTIFICATION permission.
    * Added the API to create Notification channels.  

<a id="10-september-6-2022"></a>

## 1.1.0 (September 6, 2022)

<a id="nhn-cloud-iap-14"></a>

### NHN Cloud IAP

<a id="added-10"></a>

#### Added

* Added ONE store v19

<a id="improved-24"></a>

#### Improved

* Google payment library Billing Client 5.0.0 has been applied.

<a id="00-july-12-2022"></a>

## 1.0.0 (July 12, 2022)

<a id="nhn-cloud-sdk-5"></a>

### NHN Cloud SDK

<a id="improved-25"></a>

#### Improved

* Changed the module name to NHN Cloud Android SDK
	* TOAST Android SDK has been deprecated.

<a id="311-june-14-2022"></a>

## 0.31.1 (June 14, 2022)

<a id="toast-logger"></a>

### TOAST Logger

<a id="improved-26"></a>

#### Improved

* Improved the stability of TOAST Logger

<a id="310-may-10-2022"></a>

## 0.31.0 (May 10, 2022)

<a id="toast-iap"></a>

### TOAST IAP

<a id="added-11"></a>

#### Added

* Added ONE store external payment

<a id="toast-push"></a>

### TOAST Push

<a id="added-12"></a>

#### Added

* Added support for multiple Android apps registered in one Firebase project

<a id="301-may-3-2022"></a>

## 0.30.1 (May 3, 2022)

<a id="toast-iap-2"></a>

### TOAST IAP

<a id="improved-27"></a>

#### Improved

* Improved the item query logic for ONE store v16

<a id="300-april-26-2022"></a>

## 0.30.0 (April 26, 2022)

<a id="toast-push-2"></a>

### TOAST Push

<a id="added-13"></a>

#### Added

- Added ADM (Amazon Device Messaging)

<a id="292-march-29-2022"></a>

## 0.29.2 (March 29, 2022)

<a id="toast-push-3"></a>

### TOAST Push

<a id="fixed-13"></a>

#### Fixed

* Fixed an issue where, when a token was renewed, the token was not registered

<a id="291-february-22-2022"></a>

## 0.29.1 (February 22, 2022)

<a id="toast-push-4"></a>

### TOAST Push

<a id="fixed-14"></a>

#### Fixed

* Fixed a crash issue that occurred when obtaining FCM tokens on devices that do not have Google Play Services installed

<a id="290-december-07-2021"></a>

## 0.29.0 (December 07, 2021)

<a id="toast-iap-3"></a>

### TOAST IAP

<a id="added-14"></a>

#### Added

* Added Huawei store (Huawei App Gallery) support

<a id="280-november-23-2021"></a>

## 0.28.0 (November 23, 2021)

<a id="toast-iap-4"></a>

### TOAST IAP

<a id="added-15"></a>

#### Added

* Added Amazon Appstore support

<a id="toast-push-5"></a>

### TOAST Push

<a id="improved-28"></a>

#### Improved

* Handles Android 12
    * Pending intents mutability.
    * Notification trampoline restrictions.
    * Safer component exporting (android.exported).

> Added ToastPushMessageReceiver.getContentIntent() which returns a PendingIntent that can collect metrics when creating a Notification manually.
This replaces ToastPushMessageReceiver.getNotificationServiceIntent(), which has some features that do not work properly in Android 12 or higher.

<a id="274-october-26-2021"></a>

## 0.27.4 (October 26, 2021)

<a id="toast-push-6"></a>

### TOAST Push

<a id="fixed-15"></a>

#### Fixed

* Fixed an error where user notification channel settings were initialized

<a id="273-september-28-2021"></a>

## 0.27.3 (September 28, 2021)

<a id="toast-iap-5"></a>

### TOAST IAP

<a id="improved-29"></a>

#### Improved

* Improved ONE store v16 test payment process

<a id="272-september-06-2021"></a>

## 0.27.2 (September 06, 2021)

<a id="toast-logger-2"></a>

### TOAST Logger

<a id="fixed-16"></a>

#### Fixed

* Fixed an error where DeviceModel was displayed as "UNKNOWN"
    * Fixed an error where DeviceModel was displayed as "UNKNOWN" when crash occurred in Unity.

<a id="271-august-24-2021"></a>

## 0.27.1 (August 24, 2021)

<a id="toast-iap-6"></a>

### TOAST IAP

<a id="improved-30"></a>

#### Improved

* Improved Google subscription payment process
* Improved ONE store v16 payment process

<a id="270-august-03-2021"></a>

## 0.27.0 (August 03, 2021)

<a id="toast-iap-7"></a>

### TOAST IAP

<a id="added-16"></a>

#### Added

* Added ONE store v16

<a id="260-july-06-2021"></a>

## 0.26.0 (July 06, 2021)

<a id="toast-iap-8"></a>

### TOAST IAP

<a id="added-17"></a>

#### Added

* Added a monthly payment limit feature

<a id="toast-push-7"></a>

### TOAST Push

<a id="fixed-17"></a>

#### Fixed

* Handled an issue in Firebase Messaging 22.0.0 or higher
    * Fixed an error that occurred in Firebase Messaging 22.0.0 or higher.

<a id="250-april-27-2021"></a>

## 0.25.0 (April 27, 2021)

<a id="toast-iap-9"></a>

### TOAST IAP

<a id="added-18"></a>

#### Added

* Added Google subscription status query API
    * Added the querySubscriptionsStatus API to query Google subscription status.

<a id="improved-31"></a>

#### Improved

* Google payment library update
    * Google payment library BillingClient 3.0.3 has been applied.

<a id="fixed-18"></a>

#### Fixed

* Fixed an error where "Cancel" was returned intermittently on Android 11 or higher.

<a id="244-january-12-2021"></a>

## 0.24.4 (January 12, 2021)

<a id="toast-push-8"></a>

### TOAST Push

<a id="improved-32"></a>

#### Improved

* Improved update logic when updating FCM tokens

<a id="toast-gradle-plugin-001"></a>

### TOAST Gradle Plugin (0.0.1)

<a id="added-19"></a>

#### Added

* Added Symbol Uploader function

<a id="243-december-08-2020"></a>

## 0.24.3 (December 08, 2020)

<a id="toast-push-9"></a>

### TOAST Push

<a id="improved-33"></a>

#### Improved

* Deleted a module due to termination of Tencent QQ service

<a id="242-november-24-2020"></a>

## 0.24.2 (November 24, 2020)

<a id="toast-push-10"></a>

### TOAST Push

<a id="fixed-19"></a>

#### Fixed

* Fixed an issue where the token is registered with a device identifier when requesting token registration at the same time as user ID setting

<a id="241-october-30-2020"></a>

## 0.24.1 (October 30, 2020)

<a id="toast-iap-10"></a>

### TOAST IAP

<a id="fixed-20"></a>

#### Fixed

* Fixed Galaxy Store in-app purchase error
    * Fixed an error where timeout occurred in Galaxy Apps (previous app name of Galaxy Store) 3.x or lower.

<a id="240-october-27-2020"></a>

## 0.24.0 (October 27, 2020)

<a id="toast-iap-11"></a>

### TOAST IAP

<a id="added-20"></a>

#### Added

* Added Galaxy Store

<a id="improved-34"></a>

#### Improved

* Google payment library update
    * Google payment library BillingClient 3.0.1 has been applied.
    * From August 2, 2021, all new apps must use payment library version 3 or higher.
    * By November 1, 2021, all updates to existing apps must use payment library version 3 or higher.
    * For details, refer to [Meet Google Play Billing Library Version 3](https://android-developers.googleblog.com/2020/06/meet-google-play-billing-library.html).
* Handled changes in Google subscription status
    * Handled various status changes (grace period, account hold, restore, pause, resubmit subscription, etc.) during lifecycle, such as renewal and expiration of Google subscription payment.

<a id="toast-push-11"></a>

### TOAST Push

<a id="improved-35"></a>

#### Improved

* Changed so that the reply button is not created on devices that do not support the notification reply function

<a id="fixed-21"></a>

#### Fixed

* Fixed a bug where notification channel is newly created under certain circumstances

<a id="232-october-06-2020"></a>

## 0.23.2 (October 06, 2020)

<a id="toast-iap-12"></a>

### TOAST IAP

<a id="fixed-22"></a>

#### Fixed

* Fixed a subscription issue.
    * Fixed so that an error is not notified through IapService.PurchasesUpdatedListener when subscription is restored by payment method modification in "Account Hold" or "Grace Period" status.

<a id="231-september-11-2020"></a>

## 0.23.1 (September 11, 2020)

<a id="toast-push-12"></a>

### TOAST Push

<a id="improved-36"></a>

#### Improved

* Improved token registration logic

<a id="230-july-28-2020"></a>

## 0.23.0 (July 28, 2020)

<a id="toast-push-13"></a>

### TOAST Push

<a id="added-21"></a>

#### Added

* Support user tag function

<a id="220-june-23-2020"></a>

## 0.22.0 (June 23, 2020)

<a id="toast-iap-13"></a>

### TOAST IAP

<a id="improved-37"></a>

#### Improved

`When updating to TOAST IAP SDK 0.22.0 or higher, you must perform a forced update.`

* Applied Google Play Billing Library BillingClient 2.2.1

<a id="toast-push-14"></a>

### TOAST Push

<a id="improved-38"></a>

#### Improved

* Improved the feature to set default notification options

<a id="212-may-26-2020"></a>

## 0.21.2 (May 26, 2020)

<a id="toast-push-15"></a>

### TOAST Push

<a id="improved-39"></a>

#### Improved

* Improved token registration function

<a id="211-april-28-2020"></a>

## 0.21.1 (April 28, 2020)

<a id="toast-push-16"></a>

### TOAST Push

<a id="improved-40"></a>

#### Improved

* Improved stability

<a id="toast-logger-3"></a>

### TOAST Logger

<a id="improved-41"></a>

#### Improved

* Improved Native Crash Reporting function

<a id="210-march-24-2020"></a>

## 0.21.0 (March 24, 2020)

<a id="toast-logger-4"></a>

### TOAST Logger

<a id="added-22"></a>

#### Added

* Added Native Crash Reporting (NDK) function

<a id="toast-push-17"></a>

### TOAST Push

<a id="improved-42"></a>

#### Improved

* Add configurable items to default notification options
    * Added setting on whether or not to expose foreground notifications.
    * Added setting on whether or not to use the badge icon.

<a id="203-february-25-2020"></a>

## 0.20.3 (February 25, 2020)

<a id="toast-push-18"></a>

### TOAST Push

<a id="improved-43"></a>

#### Improved

* Improved token registration function
    * If a user ID is not set at the time of initial token registration, it is registered using the device identifier.
    * After token registration, if the user ID is set or changed using ToastSdk.setUserId(), the token information is updated.

<a id="202-january-21-2020"></a>

## 0.20.2 (January 21, 2020)

<a id="toast-push-19"></a>

### TOAST Push

<a id="improved-44"></a>

#### Improved

* Improved metrics collection function
* Improved logic for creating the default notification channel

<a id="201-january-07-2020"></a>

## 0.20.1 (January 07, 2020)

<a id="toast-push-20"></a>

### TOAST Push

<a id="improved-45"></a>

#### Improved

* Supports Assets resource
    * Supports image resources in the Assets path.
* Improved method of setting the default options
    * You can set the default notification options using metadata in AndroidManifest.

<a id="toast-iap-14"></a>

### TOAST IAP

<a id="improved-46"></a>

#### Improved
* Enhanced security
    * Internal security policy has been strengthened.

<a id="fixed-23"></a>

#### Fixed

* Fixed a "Bad base64 Exception" error
    * Fixed an error where "Bad Base64 Exception" occurred when processing a payment that did not use TOAST SDK.

<a id="194-november-26-2019"></a>

## 0.19.4 (November 26, 2019)

<a id="toast-push-21"></a>

### TOAST Push

<a id="improved-47"></a>

#### Improved

* Supports migration of (old) pushsdk data.
    * If updated from (old) pushsdk, all data will be migrated to TOAST SDK.

<a id="193-october-18-2019"></a>

## 0.19.3 (October 18, 2019)

<a id="toast-push-22"></a>

### TOAST Push

<a id="improved-48"></a>

#### Improved

* Improved token registration function.

<a id="192-october-15-2019"></a>

## 0.19.2 (October 15, 2019)

<a id="toast-push-23"></a>

### TOAST Push

<a id="added-23"></a>

#### Added

* Added notification function when clicking notification.
    * You can register a listener for when the user clicks the notification and the app is launched.
* Supports badge feature.
    * Badge count is exposed on the badge icon and app shortcut screen when receiving notifications.

<a id="improved-49"></a>

#### Improved

* Notification default style setting.
    * Notifications that do not contain media are set to BigTextStyle so that messages with more than one line can also be represented.

<a id="191-october-02-2019"></a>

## 0.19.1 (October 02, 2019)

<a id="toast-iap-15"></a>

### TOAST IAP

<a id="added-24"></a>

#### Added

* Added a feature to include user data in the receipt when making a purchase request to the Unity Android IAP Plugin.

<a id="190-october-01-2019"></a>

## 0.19.0 (October 01, 2019)

<a id="toast-iap-16"></a>

### TOAST IAP

<a id="added-25"></a>

#### Added

* Added a feature to include user data in the receipt when making a purchase request to the Android IAP library.

<a id="toast-push-24"></a>

### TOAST Push

<a id="improved-50"></a>

#### Improved

* Improved usability of custom message receivers.
    * The user content intent type when requesting notification exposure has been changed to PendingIntent.

<a id="180-august-27-2019"></a>

## 0.18.0 (August 27, 2019)

<a id="toast-iap-17"></a>

### TOAST IAP

<a id="added-26"></a>

#### Added

* Added consumable subscription products.
    * Consumable subscription products have been added to the product type.

<a id="fixed-24"></a>

#### Fixed

* Fixed an error where payment results are notified more than twice when updating the Google Play Store app.

<a id="toast-push-25"></a>

### TOAST Push

<a id="added-27"></a>

#### Added

* Added a feature to set default notification options.
    * You can set basic options such as small icons, vibration, and notification sound.

<a id="171-july-23-2019"></a>

## 0.17.1 (July 23, 2019)

<a id="toast-push-26"></a>

### TOAST Push

<a id="added-28"></a>

#### Added

* Added FCM sender ID information in message object when using a custom receiver.

<a id="170-june-25-2019"></a>

## 0.17.0 (June 25, 2019)

<a id="toast-pus"></a>

### TOAST Pus

<a id="added-29"></a>

#### Added

* Added token information update function.
    * You can update information such as language and country information.
* Added message reception notification function.
* Added notification function for rich message button actions ("Open", "Dismiss", "Reply", etc.).

<a id="improved-51"></a>

#### Improved

* Improved initialization.
    * Initialization can be performed with PushType ("FCM", "TENCENT", etc.).
* Changed notification exposure policy according to app status.
    * Notifications are not exposed when the user is using the app (Foreground).
* Improved usability of custom message receivers.
    * Made it easier to edit custom messages and create notifications.
    * Made it easier to send metrics for custom notifications.

<a id="162-june-21-2019"></a>

## 0.16.2 (June 21, 2019)

<a id="toast-iap-18"></a>

### TOAST IAP

<a id="improved-52"></a>

#### Improved

* Improved behavior when user ID is changed
* Improvement of reprocessing of payments before (old) IAP SDK v1.5.3

<a id="toast-logger-5"></a>

### TOAST Logger

<a id="fixed-25"></a>

#### Fixed

* Crash bug fix

<a id="161-may-02-2019"></a>

## 0.16.1 (May 02, 2019)

<a id="toast-sdk"></a>

### TOAST SDK

<a id="fixed-26"></a>

#### Fixed

* Removed 'toast-push-tencent' dependencies from 'toast-sdk'.

<a id="160-april-23-2019"></a>

## 0.16.0 (April 23, 2019)

<a id="toast-push-27"></a>

### TOAST Push

<a id="added-30"></a>

#### Added

* Added Tencent Push.
* Added CustomReceiver.
    * Once the message is received, the message is processed by a user-defined receiver.

<a id="150-march-26-2019"></a>

## 0.15.0 (March 26, 2019)

<a id="toast-log-crash"></a>

### TOAST Log & Crash

<a id="improved-53"></a>

#### Improved

* Rename ProjectKey to AppKey
    * setProjectKey is still available

<a id="toast-iap-19"></a>

### TOAST IAP

<a id="added-31"></a>

#### Added

* Added chinese markets.

<a id="toast-push-28"></a>

### TOAST Push

<a id="added-32"></a>

#### Added

* Added API to unregister a token.
* Added a feature that sets notification's sound when adding a 'sound' field.
    * Only under Android 8.0

<a id="143-march-08-2019"></a>

## 0.14.3 (March 08, 2019)

<a id="toast-iap-20"></a>

### TOAST IAP

<a id="fixed-27"></a>

#### Fixed

* Fixed a issue that doesn't work APIs when a application applies Proguard.

<a id="142-march-04-2019"></a>

## 0.14.2 (March 04, 2019)

<a id="toast-push-29"></a>

### TOAST Push

<a id="fixed-28"></a>

#### Fixed

* Fixed a crash that occurs when could not obtain a FCM token.

<a id="141-january-29-2019"></a>

## 0.14.1 (January 29, 2019)

<a id="toast-iap-21"></a>

### TOAST IAP

<a id="fixed-29"></a>

#### Fixed

* Fixed an error that could not reprocess old IAP SDK purchases.

<a id="140-january-08-2019"></a>

## 0.14.0 (January 08, 2019)

<a id="toast-iap-22"></a>

### TOAST IAP

<a id="added-33"></a>

#### Added

* Added TOAST IAP Unity Plugin.

<a id="130-december-27-2018"></a>

## 0.13.0 (December 27, 2018)

<a id="toast-core"></a>

### TOAST Core

<a id="improved-54"></a>

#### Improved

* ToastSdk.initialize() is deprecated.
    * It is called automatically on application start.

<a id="toast-push-30"></a>

### TOAST Push

<a id="added-34"></a>

#### Added

* New Functions
    * Firebase Cloud Messaging(FCM)

<a id="120-december-04-2018"></a>

## 0.12.0 (December 04, 2018)

<a id="toast-iap-23"></a>

### TOAST IAP

<a id="added-35"></a>

#### Added

* New Functions
    * Google Play Store (One-Time/Subscription Products)
    * ONE store (One-Time Products)

<a id="110-november-20-2018"></a>

## 0.11.0 (November 20, 2018)

<a id="toast-log-crash-2"></a>

### TOAST Log & Crash

<a id="added-36"></a>

#### Added

* Network Insights

<a id="90-september-04-2018"></a>

## 0.9.0 (September 04, 2018)

<a id="toast-log-crash-3"></a>

### TOAST Log & Crash

<a id="added-37"></a>

#### Added

* New Functions
