## NHN Cloud > SDK User Guide > Release Notes > Android

## 1.8.1 (2023. 10. 31.)

### NHN Cloud OCR

#### Improved
* Improved Credit Card Recognizer UI
    * TextView with enhanced security has been applied.

#### Fixed
* Fixed a Camera Focus issue
    * Fixed an issue where Auto Focus does not work on some low-end devices.

## 1.8.0 (September 26, 2023)

### NHN Cloud IAP

#### Improved

* Updated Google Billing Client 5.2.1
    * According to Google's policy, apps targeting Android 14 or later must be updated to NHN Cloud IAP 1.8.0 or later.

### NHN Cloud OCR

#### Improved

* Improved Camera
    * Modified the Camera Preview screen to fill the display.
* Raised the minimum supported version to API 22.

## 1.7.1 (August 29, 2023)

### NHN Cloud IAP

#### Improved

* Improved MyCard test payment
* Raised the minimum supported verson of MyCard to API 21.

## 1.7.0 (July 11, 2023)

### NHN Cloud OCR

#### Added

* Added OCR (ID Card Recognizer)

## 1.6.0 (June 20, 2023)

### NHN Cloud IAP

#### Added

* Added ONE store v21

### NHN Cloud Logger

#### Improved

* Support Android Gradle Plugin 8.0

## 1.5.1 (May 30, 2023)

### NHN Cloud IAP

#### Added

* Added a feature to send payment details
    * You can view payment details on the Transaction tab in the IAP console.

## 1.5.0 (April 5, 2023)

### NHN Cloud SDK

#### Improved

* Improved stability

### NHN Cloud IAP

#### Added

* Added MyCard IAP

## 1.4.3 (March 24, 2023)

### NHN Cloud OCR

#### Fixed

* Fixed a NoClassDefFoundError issue

## 1.4.2 (February 28, 2023)

### NHN Cloud OCR

#### Improved 

* Improved stability

## 1.4.1 (January 11, 2023)

### NHN Cloud Push

#### Improved

* Improved sending push metrics and processing events

## 1.4.0 (November 29, 2022)

### NHN Cloud Logger

#### Added

* Added support for Logger for government agencies

### NHN Cloud OCR

#### Improved

* Improved UI

#### Fixed

* Fixed a crash issue that occurred when initializing camera

### NHN Cloud Push

#### Improved

* Improved sending push events
* Fixed an issue of changing flags in Intent
    * Fixed an issue where, when calling NhnCloudPushMessageReceiver.getContentIntent(), the flags set in the delivered Intent are not maintained. 
    
## 1.3.0 (October 25, 2022)

### NHN Cloud OCR

#### Added

* Added OCR(Credit Card Recognizer)

### NHN Cloud IAP

#### Added

* [All stores] Added APIs for activated subscription query and unconsumed purchase query

### NHN Cloud Push

#### Fixed

* Fixed a bug where click events and metrics cannot be received when using ToastPushMessageReceiver in NHN Cloud SDK 1.0.0 or higher

## 1.2.0 (October 4, 2022)

### NHN Cloud SDK

#### Improved

* Added AndroidX support
    * The minimum supported version has increased to API 16.

### NHN Cloud Push

#### Improved

* Handled issues related to Android 13
    * Added the API to request POST_NOTIFICATION permission.
    * Added the API to create Notification channels.  

## 1.1.0 (September 6, 2022)

### NHN Cloud IAP

#### Added

* Added ONE store v19

#### Improved

* Google payment library Billing Client 5.0.0 has been applied.

## 1.0.0 (July 12, 2022)

### NHN Cloud SDK

#### Improved

* Changed the module name to NHN Cloud Android SDK
	* TOAST Android SDK has been deprecated.

## 0.31.1 (June 14, 2022)

### TOAST Logger

#### Improved

* Improved the stability of TOAST Logger

## 0.31.0 (May 10, 2022)

### TOAST IAP

#### Added

* Added ONE store external payment

### TOAST Push

#### Added

* Added support for multiple Android apps registered in one Firebase project

## 0.30.1 (May 3, 2022)

### TOAST IAP

#### Improved

* Improved the item query logic for ONE store v16

## 0.30.0 (April 26, 2022)

### TOAST Push

#### Added

- Added ADM (Amazon Device Messaging)

## 0.29.2 (March 29, 2022)

### TOAST Push

#### Fixed

* Fixed an issue where, when a token was renewed, the token was not registered

## 0.29.1 (February 22, 2022)

### TOAST Push

#### Fixed

* Fixed a crash issue that occurred when obtaining FCM tokens on devices that do not have Google Play Services installed

## 0.29.0 (December 07, 2021)

### TOAST IAP

#### Added

* Added Huawei store (Huawei App Gallery) support

## 0.28.0 (November 23, 2021)

### TOAST IAP

#### Added

* Added Amazon Appstore support

### TOAST Push

#### Improved

* Handles Android 12
    * Pending intents mutability.
    * Notification trampoline restrictions.
    * Safer component exporting (android.exported).

> Added ToastPushMessageReceiver.getContentIntent() which returns a PendingIntent that can collect metrics when creating a Notification manually.
This replaces ToastPushMessageReceiver.getNotificationServiceIntent(), which has some features that do not work properly in Android 12 or higher.

## 0.27.4 (October 26, 2021)

### TOAST Push

#### Fixed

* Fixed an error where user notification channel settings were initialized

## 0.27.3 (September 28, 2021)

### TOAST IAP

#### Improved

* Improved ONE store v16 test payment process

## 0.27.2 (September 06, 2021)

### TOAST Logger

#### Fixed

* Fixed an error where DeviceModel was displayed as "UNKNOWN"
    * Fixed an error where DeviceModel was displayed as "UNKNOWN" when crash occurred in Unity.

## 0.27.1 (August 24, 2021)

### TOAST IAP

#### Improved

* Improved Google subscription payment process
* Improved ONE store v16 payment process

## 0.27.0 (August 03, 2021)

### TOAST IAP

#### Added

* Added ONE store v16

## 0.26.0 (July 06, 2021)

### TOAST IAP

#### Added

* Added a monthly payment limit feature

### TOAST Push

#### Fixed

* Handled an issue in Firebase Messaging 22.0.0 or higher
    * Fixed an error that occurred in Firebase Messaging 22.0.0 or higher.

## 0.25.0 (April 27, 2021)

### TOAST IAP

#### Added

* Added Google subscription status query API
    * Added the querySubscriptionsStatus API to query Google subscription status.

#### Improved

* Google payment library update
    * Google payment library BillingClient 3.0.3 has been applied.

#### Fixed

* Fixed an error where "Cancel" was returned intermittently on Android 11 or higher.

## 0.24.4 (January 12, 2021)

### TOAST Push

#### Improved

* Improved update logic when updating FCM tokens

### TOAST Gradle Plugin (0.0.1)

#### Added

* Added Symbol Uploader function

## 0.24.3 (December 08, 2020)

### TOAST Push

#### Improved

* Deleted a module due to termination of Tencent QQ service

## 0.24.2 (November 24, 2020)

### TOAST Push

#### Fixed

* Fixed an issue where the token is registered with a device identifier when requesting token registration at the same time as user ID setting

## 0.24.1 (October 30, 2020)

### TOAST IAP

#### Fixed

* Fixed Galaxy Store in-app purchase error
    * Fixed an error where timeout occurred in Galaxy Apps (previous app name of Galaxy Store) 3.x or lower.

## 0.24.0 (October 27, 2020)

### TOAST IAP

#### Added

* Added Galaxy Store

#### Improved

* Google payment library update
    * Google payment library BillingClient 3.0.1 has been applied.
    * From August 2, 2021, all new apps must use payment library version 3 or higher.
    * By November 1, 2021, all updates to existing apps must use payment library version 3 or higher.
    * For details, refer to [Meet Google Play Billing Library Version 3](https://android-developers.googleblog.com/2020/06/meet-google-play-billing-library.html).
* Handled changes in Google subscription status
    * Handled various status changes (grace period, account hold, restore, pause, resubmit subscription, etc.) during lifecycle, such as renewal and expiration of Google subscription payment.

### TOAST Push

#### Improved

* Changed so that the reply button is not created on devices that do not support the notification reply function

#### Fixed

* Fixed a bug where notification channel is newly created under certain circumstances

## 0.23.2 (October 06, 2020)

### TOAST IAP

#### Fixed

* Fixed a subscription issue.
    * Fixed so that an error is not notified through IapService.PurchasesUpdatedListener when subscription is restored by payment method modification in "Account Hold" or "Grace Period" status.

## 0.23.1 (September 11, 2020)

### TOAST Push

#### Improved

* Improved token registration logic

## 0.23.0 (July 28, 2020)

### TOAST Push

#### Added

* Support user tag function

## 0.22.0 (June 23, 2020)

### TOAST IAP

#### Improved

`When updating to TOAST IAP SDK 0.22.0 or higher, you must perform a forced update.`

* Applied Google Play Billing Library BillingClient 2.2.1

### TOAST Push

#### Improved

* Improved the feature to set default notification options

## 0.21.2 (May 26, 2020)

### TOAST Push

#### Improved

* Improved token registration function

## 0.21.1 (April 28, 2020)

### TOAST Push

#### Improved

* Improved stability

### TOAST Logger

#### Improved

* Improved Native Crash Reporting function

## 0.21.0 (March 24, 2020)

### TOAST Logger

#### Added

* Added Native Crash Reporting (NDK) function

### TOAST Push

#### Improved

* Add configurable items to default notification options
    * Added setting on whether or not to expose foreground notifications.
    * Added setting on whether or not to use the badge icon.

## 0.20.3 (February 25, 2020)

### TOAST Push

#### Improved

* Improved token registration function
    * If a user ID is not set at the time of initial token registration, it is registered using the device identifier.
    * After token registration, if the user ID is set or changed using ToastSdk.setUserId(), the token information is updated.

## 0.20.2 (January 21, 2020)

### TOAST Push

#### Improved

* Improved metrics collection function
* Improved logic for creating the default notification channel

## 0.20.1 (January 07, 2020)

### TOAST Push

#### Improved

* Supports Assets resource
    * Supports image resources in the Assets path.
* Improved method of setting the default options
    * You can set the default notification options using metadata in AndroidManifest.

### TOAST IAP

#### Improved
* Enhanced security
    * Internal security policy has been strengthened.

#### Fixed

* Fixed a "Bad base64 Exception" error
    * Fixed an error where "Bad Base64 Exception" occurred when processing a payment that did not use TOAST SDK.

## 0.19.4 (November 26, 2019)

### TOAST Push

#### Improved

* Supports migration of (old) pushsdk data.
    * If updated from (old) pushsdk, all data will be migrated to TOAST SDK.

## 0.19.3 (October 18, 2019)

### TOAST Push

#### Improved

* Improved token registration function.

## 0.19.2 (October 15, 2019)

### TOAST Push

#### Added

* Added notification function when clicking notification.
    * You can register a listener for when the user clicks the notification and the app is launched.
* Supports badge feature.
    * Badge count is exposed on the badge icon and app shortcut screen when receiving notifications.

#### Improved

* Notification default style setting.
    * Notifications that do not contain media are set to BigTextStyle so that messages with more than one line can also be represented.

## 0.19.1 (October 02, 2019)

### TOAST IAP

#### Added

* Added a feature to include user data in the receipt when making a purchase request to the Unity Android IAP Plugin.

## 0.19.0 (October 01, 2019)

### TOAST IAP

#### Added

* Added a feature to include user data in the receipt when making a purchase request to the Android IAP library.

### TOAST Push

#### Improved

* Improved usability of custom message receivers.
    * The user content intent type when requesting notification exposure has been changed to PendingIntent.

## 0.18.0 (August 27, 2019)

### TOAST IAP

#### Added

* Added consumable subscription products.
    * Consumable subscription products have been added to the product type.

#### Fixed

* Fixed an error where payment results are notified more than twice when updating the Google Play Store app.

### TOAST Push

#### Added

* Added a feature to set default notification options.
    * You can set basic options such as small icons, vibration, and notification sound.

## 0.17.1 (July 23, 2019)

### TOAST Push

#### Added

* Added FCM sender ID information in message object when using a custom receiver.

## 0.17.0 (June 25, 2019)

### TOAST Pus

#### Added

* Added token information update function.
    * You can update information such as language and country information.
* Added message reception notification function.
* Added notification function for rich message button actions ("Open", "Dismiss", "Reply", etc.).

#### Improved

* Improved initialization.
    * Initialization can be performed with PushType ("FCM", "TENCENT", etc.).
* Changed notification exposure policy according to app status.
    * Notifications are not exposed when the user is using the app (Foreground).
* Improved usability of custom message receivers.
    * Made it easier to edit custom messages and create notifications.
    * Made it easier to send metrics for custom notifications.

## 0.16.2 (June 21, 2019)

### TOAST IAP

#### Improved

* Improved behavior when user ID is changed
* Improvement of reprocessing of payments before (old) IAP SDK v1.5.3

### TOAST Logger

#### Fixed

* Crash bug fix

## 0.16.1 (May 02, 2019)

### TOAST SDK

#### Fixed

* Removed 'toast-push-tencent' dependencies from 'toast-sdk'.

## 0.16.0 (April 23, 2019)

### TOAST Push

#### Added

* Added Tencent Push.
* Added CustomReceiver.
    * Once the message is received, the message is processed by a user-defined receiver.

## 0.15.0 (March 26, 2019)

### TOAST Log & Crash

#### Improved

* Rename ProjectKey to AppKey
    * setProjectKey is still available

### TOAST IAP

#### Added

* Added chinese markets.

### TOAST Push

#### Added

* Added API to unregister a token.
* Added a feature that sets notification's sound when adding a 'sound' field.
    * Only under Android 8.0

## 0.14.3 (March 08, 2019)

### TOAST IAP

#### Fixed

* Fixed a issue that doesn't work APIs when a application applies Proguard.

## 0.14.2 (March 04, 2019)

### TOAST Push

#### Fixed

* Fixed a crash that occurs when could not obtain a FCM token.

## 0.14.1 (January 29, 2019)

### TOAST IAP

#### Fixed

* Fixed an error that could not reprocess old IAP SDK purchases.

## 0.14.0 (January 08, 2019)

### TOAST IAP

#### Added

* Added TOAST IAP Unity Plugin.

## 0.13.0 (December 27, 2018)

### TOAST Core

#### Improved

* ToastSdk.initialize() is deprecated.
    * It is called automatically on application start.

### TOAST Push

#### Added

* New Functions
    * Firebase Cloud Messaging(FCM)

## 0.12.0 (December 04, 2018)

### TOAST IAP

#### Added

* New Functions
    * Google Play Store (One-Time/Subscription Products)
    * ONE store (One-Time Products)

## 0.11.0 (November 20, 2018)

### TOAST Log & Crash

#### Added

* Network Insights

## 0.9.0 (September 04, 2018)

### TOAST Log & Crash

#### Added

* New Functions
