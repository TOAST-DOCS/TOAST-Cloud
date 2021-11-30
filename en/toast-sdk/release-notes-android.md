## TOAST > TOAST SDK User Guide > Release Notes > Android

## 0.29.0 (2021.12.07)

#### Added

* 화웨이 스토어(Huawei App Gallery) 추가

## 0.28.0 (2021.11.23)

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

## 0.27.4 (2021.10.26)

### TOAST Push

#### Fixed

* Fixed an error where user notification channel settings were initialized

## 0.27.3 (2021.09.28)

### TOAST IAP

#### Improved

* Improved ONE store v16 test payment process

## 0.27.2 (2021.09.06)

### TOAST Logger

#### Fixed

* Fixed an error where DeviceModel was displayed as "UNKNOWN"
    * Fixed an error where DeviceModel was displayed as "UNKNOWN" when crash occurred in Unity.

## 0.27.1 (2021.08.24)

### TOAST IAP

#### Improved

* Improved Google subscription payment process
* Improved ONE store v16 payment process

## 0.27.0 (2021.08.03)

### TOAST IAP

#### Added

* Added ONE store v16

## 0.26.0 (2021.07.06)

### TOAST IAP

#### Added

* Added a monthly payment limit feature

### TOAST Push

#### Fixed

* Handled an issue in Firebase Messaging 22.0.0 or higher
    * Fixed an error that occurred in Firebase Messaging 22.0.0 or higher.

## 0.25.0 (2021.04.27)

### TOAST IAP

#### Added

* Added Google subscription status query API
    * Added the querySubscriptionsStatus API to query Google subscription status.

#### Improved

* Google payment library update
    * Google payment library BillingClient 3.0.3 has been applied.

#### Fixed

* Fixed an error where "Cancel" was returned intermittently on Android 11 or higher.

## 0.24.4 (2021.01.12)

### TOAST Push

#### Improved

* Improved update logic when updating FCM tokens

### TOAST Gradle Plugin (0.0.1)

#### Added

* Added Symbol Uploader function

## 0.24.3 (2020.12.08)

### TOAST Push

#### Improved

* Deleted a module due to termination of Tencent QQ service

## 0.24.2 (2020.11.24)

### TOAST Push

#### Fixed

* Fixed an issue where the token is registered with a device identifier when requesting token registration at the same time as user ID setting

## 0.24.1 (2020.10.30)

### TOAST IAP

#### Fixed

* Fixed Galaxy Store in-app purchase error
    * Fixed an error where timeout occurred in Galaxy Apps (previous app name of Galaxy Store) 3.x or lower.

## 0.24.0 (2020.10.27)

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

## 0.23.2 (2020.10.06)

### TOAST IAP

#### Fixed

* Fixed a subscription issue.
    * Fixed so that an error is not notified through IapService.PurchasesUpdatedListener when subscription is restored by payment method modification in "Account Hold" or "Grace Period" status.

## 0.23.1 (2020.09.11)

### TOAST Push

#### Improved

* Improved token registration logic

## 0.23.0 (2020.07.28)

### TOAST Push

#### Added

* Support user tag function

## 0.22.0 (2020.06.23)

### TOAST IAP

#### Improved

`When updating to TOAST IAP SDK 0.22.0 or higher, you must perform a forced update.`

* Applied Google Play Billing Library BillingClient 2.2.1

### TOAST Push

#### Improved

* Improved the feature to set default notification options

## 0.21.2 (2020.05.26)

### TOAST Push

#### Improved

* Improved token registration function

## 0.21.1 (2020.04.28)

### TOAST Push

#### Improved

* Improved stability

### TOAST Logger

#### Improved

* Improved Native Crash Reporting function

## 0.21.0 (2020.03.24)

### TOAST Logger

#### Added

* Added Native Crash Reporting (NDK) function

### TOAST Push

#### Improved

* Add configurable items to default notification options
    * Added setting on whether or not to expose foreground notifications.
    * Added setting on whether or not to use the badge icon.

## 0.20.3 (2020.02.25)

### TOAST Push

#### Improved

* Improved token registration function
    * If a user ID is not set at the time of initial token registration, it is registered using the device identifier.
    * After token registration, if the user ID is set or changed using ToastSdk.setUserId(), the token information is updated.

## 0.20.2 (2020.01.21)

### TOAST Push

#### Improved

* Improved metrics collection function
* Improved logic for creating the default notification channel

## 0.20.1 (2020.01.07)

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

## 0.19.4 (2019.11.26)

### TOAST Push

#### Improved

* Supports migration of (old) pushsdk data.
    * If updated from (old) pushsdk, all data will be migrated to TOAST SDK.

## 0.19.3 (2019.10.18)

### TOAST Push

#### Improved

* Improved token registration function.

## 0.19.2 (2019.10.15)

### TOAST Push

#### Added

* Added notification function when clicking notification.
    * You can register a listener for when the user clicks the notification and the app is launched.
* Supports badge feature.
    * Badge count is exposed on the badge icon and app shortcut screen when receiving notifications.

#### Improved

* Notification default style setting.
    * Notifications that do not contain media are set to BigTextStyle so that messages with more than one line can also be represented.

## 0.19.1 (2019.10.02)

### TOAST IAP

#### Added

* Added a feature to include user data in the receipt when making a purchase request to the Unity Android IAP Plugin.

## 0.19.0 (2019.10.01)

### TOAST IAP

#### Added

* Added a feature to include user data in the receipt when making a purchase request to the Android IAP library.

### TOAST Push

#### Improved

* Improved usability of custom message receivers.
    * The user content intent type when requesting notification exposure has been changed to PendingIntent.

## 0.18.0 (2019.08.27)

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

## 0.17.1 (2019.07.23)

### TOAST Push

#### Added

* Added FCM sender ID information in message object when using a custom receiver.

## 0.17.0 (2019.06.25)

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

## 0.16.2 (2019.06.21)

### TOAST IAP

#### Improved

* Improved behavior when user ID is changed
* Improvement of reprocessing of payments before (old) IAP SDK v1.5.3

### TOAST Logger

#### Fixed

* Crash bug fix

## 0.16.1 (2019.05.02)

### TOAST SDK

#### Fixed

* Removed 'toast-push-tencent' dependencies from 'toast-sdk'.

## 0.16.0 (2019.04.23)

### TOAST Push

#### Added

* Added Tencent Push.
* Added CustomReceiver.
    * Once the message is received, the message is processed by a user-defined receiver.

## 0.15.0 (2019.03.26)

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

## 0.14.3 (2019.03.08)

### TOAST IAP

#### Fixed

* Fixed a issue that doesn't work APIs when a application applies Proguard.

## 0.14.2 (2019.03.04)

### TOAST Push

#### Fixed

* Fixed a crash that occurs when could not obtain a FCM token.

## 0.14.1 (2019.01.29)

### TOAST IAP

#### Fixed

* Fixed an error that could not reprocess old IAP SDK purchases.

## 0.14.0 (2019.01.08)

### TOAST IAP

#### Added

* Added TOAST IAP Unity Plugin.

## 0.13.0 (2018.12.27)

### TOAST Core

#### Improved

* ToastSdk.initialize() is deprecated.
    * It is called automatically on application start.

### TOAST Push

#### Added

* New Functions
    * Firebase Cloud Messaging(FCM)

## 0.12.0 (2018.12.04)

### TOAST IAP

#### Added

* New Functions
    * Google Play Store (One-Time/Subscription Products)
    * ONE store (One-Time Products)

## 0.11.0 (2018.11.20)

### TOAST Log & Crash

#### Added

* Network Insights

## 0.9.0 (2018.09.04)

### TOAST Log & Crash

#### Added

* New Functions
