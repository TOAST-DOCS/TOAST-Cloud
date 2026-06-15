<!-- pre-align:aligned sig=126a8787ad5d -->

## NHN Cloud > SDK User Guide > Push > iOS

<a id="prerequisites"></a>

## Prerequisites

1. Install [NHN Cloud SDK](./getting-started-ios).
2. [Enable Notification \> Push](http://docs.nhncloud.com/en/Notification/Push/en/console-guide/) in [NHN Cloud Console](https://console.nhncloud.com).
3. Check your AppKey in Push.

<a id="apns-guide"></a>

## APNS Guide
* [APNS Guide](https://developer.apple.com/library/archive/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/APNSOverview.html)

<a id="nhn-cloud-push-components"></a>

## NHN Cloud Push Components

* NHN Cloud Push SDK for iOS consists of the following:

| Service  | Cocoapods Pod Name | Framework | Dependency | Build Settings |
| --- | --- | --- | --- | --- |
| Push | NHNCloudPush | NHNCloudPush.framework | UserNotifications.framework<br/><br/>[NHNCloudVoIP]<br/>PushKit.framework<br/>CallKit.framework | |
| Mandatory   | NHNCloudCore<br/>NHNCloudCommon | NHNCloudCore.framework<br/>NHNCloudCommon.framework | | OTHER_LDFLAGS = (<br/>    "-ObjC",<br/>    "-lc++" <br/>); |

<a id="apply-nhn-cloud-push-sdk-to-xcode-projects"></a>

## Apply NHN Cloud Push SDK to Xcode Projects

<a id="apply-using-cococapods"></a>

### 1. Apply using Cococapods

* Create a Podfile and add a pod for NHN Cloud SDK.

``` podspec
platform :ios, '11.0'
use_frameworks!

target '{YOUR PROJECT TARGET NAME}' do
    pod 'NHNCloudPush'
end
```

<a id="apply-nhn-cloud-sdk-with-swift-package-manager"></a>

### 2. Apply NHN Cloud SDK with Swift Package Manager

* Go to **File > Add Packages...** from XCode.
* For the Package URL, enter 'https://github.com/nhn/nhncloud.ios.sdk' and select **Add Package**.
* Select NHNCloudPush.

![swift_package_manager](https://static.toastoven.net/toastcloud/sdk/ios/swiftpackagemanager01.png)

<a id="set-up-project"></a>

#### Set up Project

* Add **-lc++** and **-ObjC** entries to **Other Linker Flags** in **Build Settings**.
    * **Project Target > Build Settings > Linking > Other Linker Flags**
![other_linker_flags](https://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags_202206.png)

<a id="apply-nhn-cloud-sdk-by-downloading-binaries"></a>

### 3. Apply NHN Cloud SDK by Downloading Binaries

<a id="set-up-framework"></a>

#### Set up Framework

* You can download the full iOS SDK from the [Downloads](../../../Download/#toast-sdk) page of NHN Cloud.
* Add **NHNCloudPush.framework**, **NHNCloudCore.framework**, **NHNCloudCommon.framework, UserNotifications.framework** to your Xcode Project.
* UserNotifications.framework can be added in the following way.
![linked_usernotifications_frameworks](https://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_UserNotifications_202206.png)

<a id="set-up-project-2"></a>

#### Set up Project

* Add **-lc++** and **-ObjC** items to **Other Linker Flags** in **Build Settings**.
    * **Project Target > Build Settings > Linking > Other Linker Flags**
![other_linker_flags](https://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags_202206.png)

<a id="capabilities-setup"></a>

### Capabilities Setup

* To use NHN Cloud Push, you must enable **Push Notification** and **Background Modes** items in Capabilities.
    * **Project Target > Signing & Capabilities > + Capability > Push Notification**
![add_capability_push_notifications](https://static.toastoven.net/toastcloud/sdk/ios/add_capability_notifications_202206.png)
    * **Project Target > Signing & Capabilities > + Capability > Background Modes**
![add_capability_background_modes](https://static.toastoven.net/toastcloud/sdk/ios/add_capability_background_modes_202206.png)
    * In **Background Modes** items, **Remote notifications** must be enabled.
![capabilities](https://static.toastoven.net/toastcloud/sdk/ios/push_capabilities_202206.png)

<a id="changes-for-xcode11ios13"></a>

## Changes for Xcode11/iOS13
* VoIP
    * In iOS 13 or higher, if you do not report to CallKit after receiving a VoIP message, the message reception becomes restricted. ([PushKit pushRegistry guide](https://developer.apple.com/documentation/pushkit/pkpushregistrydelegate/2875784-pushregistry))
    * The call reception screen using CallKit must be implemented in the app.

<a id="service-login"></a>

## Service Login

* All products provided by NHN Cloud SDK (Push, IAP, Log & Crash, ...) share one user ID.

<a id="login"></a>

### Login

* `If a user ID is not set at the time of initial token registration, it is registered using the device identifier.` ([Refer to the token registration section](./push-ios/#token-registration))
* `Setting or changing the user ID after token registration will update token information.`

``` objc
// Service login, set the user ID
[NHNCloudSDK setUserID:@"INPUT_USER_ID"];
```

<a id="logout"></a>

### Logout

* `Even if logout occurs, the registered token is not deleted.`

``` objc
// Service logout, set the user ID to nil
[NHNCloudSDK setUserID:nil];
```

<a id="initialize-nhn-cloud-push-sdk"></a>

## Initialize NHN Cloud Push SDK

* `The token registration and query features cannot be used without initialization.`
* Set the Push AppKey issued from the NHN Cloud server in the [NHNCloudPushConfiguration](./push-ios/#nhncloudpushconfiguration)object.
* `In the development environment, the sandbox property of NHNCloudPushConfiguration의 must be set to YES to receive the message sent using the development certificate.'

<a id="specification-for-initialization-api"></a>

### Specification for Initialization API

``` objc
// Initialize and set Delegate
+ (void)initWithConfiguration:(NHNCloudPushConfiguration *)configuration
                     delegate:(nullable id<NHNCloudPushDelegate>)delegate;

// Initialize
+ (void)initWithConfiguration:(NHNCloudPushConfiguration *)configuration;

// Set Delegate
+ (void)setDelegate:(nullable id<NHNCloudPushDelegate>)delegate;
```

<a id="specification-for-delegate-api"></a>

### Specification for Delegate API
* When receiving a notification message while the app is running, the content of the received message is passed to the [NHNCloudPushMessage](./push-ios/#nhncloudpushmessage) object.
* When the app is launched by the user executing (clicking) the notification, the content of the executed notification message is passed to the [NHNCloudPushMessage](./push-ios/#nhncloudpushmessage) object.
* When the user executes (clicks) the button on the notification, the action information of the executed button is passed to the [NHNCloudPushNotificationAction](./push-ios/#nhncloudpushnotificationaction) object.
* `It is recommended to set Delegate in application:didFinishLaunchingWithOptions: function for smooth message reception.`

``` objc
@protocol NHNCloudPushDelegate <NSObject>

@optional

// Receive a message
- (void)didReceiveNotificationWithMessage:(NHNCloudPushMessage *)message;

// Execute notification (click)
- (void)didReceiveNotificationResponseWithMessage:(NHNCloudPushMessage *)message

// Execute notification action (button)
- (void)didReceiveNotificationAction:(NHNCloudPushNotificationAction *)action

@end
```

<a id="settings-when-using-notification-hub"></a>

### Settings when using Notification Hub

* NHN Cloud Push SDK supports Notification Hub.
* You can use it by setting the value NHNCloudPushServiceTypeNotificationHub in the serviceType property of NHNCloudPushConfiguration.
* The default value is NHNCloudPushServiceTypePush, and if not set, the existing Push method is applied.

<a id="notification-initialization-example"></a>

### Notification initialization example

```objc
NHNCloudPushConfiguration *configuration = [[NHNCloudPushConfiguration alloc] initWithAppKey:@"INPUT_YOUR_APPKEY" 
                                                                                 serviceType:NHNCloudPushServiceTypeNotificationHub];
[NHNCloudPush initWithConfiguration:configuration];
```

<a id="example-of-initialization-and-delegate-setting"></a>

### Example of Initialization and Delegate Setting

``` objc
#import <NHNCloudPush/NHNCloudPush.h>

@interface AppDelegate () <UIApplicationDelegate, NHNCloudPushDelegate>

@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // ...

    // Create a configuration object.
    NHNCloudPushConfiguration *configuration = [[NHNCloudPushConfiguration alloc] initWithAppKey:@"INPUT_YOUR_APPKEY"];

#if DEBUG
    // In the development environment (DEBUG), the sandbox property below must be set to YES to receive the message sent using the development certificate.
    configuration.sandbox = YES;
#endif

    // If you want to register the token even if you don't get permission to allow notifications, you should change the value of the alwaysAllowTokenRegistration property to YES. The default value is NO.
    configuration.alwaysAllowTokenRegistration = NO;

    // Set Delegate in tandem with the initialization.
    [NHNCloudPush initWithConfiguration:configuration
                               delegate:self];

    return YES;
}

#pragma mark - NHNCloudPushDelegate
// Receive a message
- (void)didReceiveNotificationWithMessage:(NHNCloudPushMessage *)message {
    // ...
}

// Notification response (execute)
- (void)didReceiveNotificationResponseWithMessage:(NHNCloudPushMessage *)message {
    // ...
}

// Execute notification action (button, reply)
- (void)didReceiveNotificationAction:(NHNCloudPushNotificationAction *)action {
    // ...
}
```

<a id="notification-option-setting"></a>

## Notification Option Setting

* You can set notification options with the [NHNCloudNotificationOptions](./push-ios/#nhncloudnotificationoptions) object.

| Option Name | Description | Default |
| --- | --- | --- |
| foregroundEnabled | Whether to show notifications when the app is in the foreground state | NO |
| badgeEnabled | Whether to use a badge icon | YES |
| soundEnabled | Whether to use a notification sound | YES |

* The default behavior is not to expose notifications when the app is in the foreground state, so if you want notifications to show up, you need to set the notification option.

<a id="specification-for-notification-option-setting-api"></a>

### Specification for Notification Option Setting API

``` objc
+ (void)setNotificationOptions:(nullable NHNCloudNotificationOptions *)options;
```

<a id="example-of-notification-option-setting"></a>

### Example of notification option setting

``` objc
NHNCloudNotificationOptions *options = [[NHNCloudNotificationOptions alloc] init];
options.foregroundEnabled = YES;    // Set the use of foreground notification (default : NO)
options.badgeEnabled = YES;         // Set the use of badge icon (default : YES)
options.soundEnabled = YES;         // Set the use of notification sound (default : YES)

[NHNCloudPush setNotificationOptions:options];
```

<a id="token-registration"></a>

## Token Registration

* Register the issued token information to the NHN Cloud server. At this time,  pass whether or not to agree to receive the push (NHNCloudPushAgreement) as a parameter.
* If this is the first run, ask the user for permission to allow notifications (alwaysAllowTokenRegistration defaults to false).
    * If the value of alwaysAllowTokenRegistration in NHNCloudPushConfiguration is false
        * If permission to allow notifications is not obtained, token registration fails.
    * If the value of alwaysAllowTokenRegistration in NHNCloudPushConfiguration is true
        * Event if permission to allow notifications is not obtained, token can be registered.
* If a user ID is not set at the time of initial token registration, it is registered using the device identifier.

<a id="agreement-setting"></a>

### Agreement Setting

* In accordance with the provisions of the Information and Communications Network Act (Articles 50 through 50-8), when registering a token, whether or not to receive notification/advertising/night-time advertising push messages must also be inputted. When sending a message, it is automatically filtered based on whether or not the user agreed to receive it.
    * [Shortcut to KISA Guide](https://www.kisa.or.kr/2060301/form?postSeq=19)
    * [Shortcut to the law](http://www.law.go.kr/법령/정보통신망이용촉진및정보보호등에관한법률/%2820130218,11322,20120217%29/제50조)
* Set user notification message agreement information in the [NHNCloudPushAgreement](./push-ios/#nhncloudpushagreement) object.

<a id="specification-for-token-registration-and-agreement-setting-api"></a>

### Specification for token registration and agreement setting API

``` objc
// Token registration and agreement setting
+ (void)registerWithAgreement:(NHNCloudPushAgreement *)agreement
            completionHandler:(nullable void (^)(NHNCloudPushTokenInfo * _Nullable tokenInfo, NSError * _Nullable error))completionHandler;

// Register a token using the previously set agreement information
+ (void)registerWithCompletionHandler:(nullable void (^)(NHNCloudPushTokenInfo * _Nullable tokenInfo, NSError * _Nullable error))completionHandler;
```

<a id="example-of-token-registration-and-agreement-setting"></a>

### Example of token registration and agreement setting

``` objc
NHNCloudPushAgreement *agreement = [[NHNCloudPushAgreement alloc] initWithAllowNotifications:YES]; // Agree to receive notification message
agreement.allowAdvertisements = YES;        // Agree to receive advertising notification message
agreement.allowNightAdvertisements = YES;   // Agree to receive night-time advertising notification message

[NHNCloudPush registerWithAgreement:agreement
                  completionHandler:^(NHNCloudPushTokenInfo *tokenInfo, NSError *error) {

    if (error == nil) {
        // Token registration succeeded
        NSLog(@"Successfully registered : %@", tokenInfo.deviceToken);

    } else {
        // Token registration failed
        NSLog(@"Failed to register : %@", error.localizedDescription);
    }
}];
```

<a id="token-information-query"></a>

## Token Information Query

* Query the last successfully registered token and setting information in the current device.
* When the token information query is successful, the setting information of the token is returned to the [NHNCloudPushTokenInfo](./push-ios/#nhncloudpushtokeninfo) object.

<a id="specification-for-token-information-query-api"></a>

### Specification for Token Information Query API

``` objc
+ (void)queryTokenInfoWithCompletionHandler:(void (^)(NHNCloudPushTokenInfo * _Nullable tokenInfo, NSError * _Nullable error))completionHandler;
```

<a id="token-information-query-example"></a>

### Token information query example

``` objc
[NHNCloudPush queryTokenInfoWithCompletionHandler:^(NHNCloudPushTokenInfo *tokenInfo, NSError *error) {
    if (error == nil) {
        // Token information query succeeded
        NSLog(@"Successfully query token info : %@", [tokenInfo description]);

    } else {
        // Token information query failed
        NSLog(@"Failed to query token info : %@", error.localizedDescription);
    }
}];
```

<a id="token-unregistration"></a>

## Token Unregistration

* Unregister the token registered in the NHN Cloud server. Unregistered tokens are excluded from targets for sending messages.
* `If you do not want to receive messages after the service logout, you must unregister the token.`
* `Even if the token is unregistered, the notification permission on the device is not revoked.`

<a id="specification-for-token-unregistration-api"></a>

### Specification for Token Unregistration API

``` objc
+ (void)unregisterWithCompletionHandler:(nullable void (^)(NSString * _Nullable deviceToken, NSError * _Nullable error))completionHandler;
```

<a id="token-unregistration-example"></a>

### Token unregistration example

``` objc
[NHNCloudPush unregisterWithCompletionHandler:^(NSString *deviceToken, NSError *error) {
    if (error == nil) {
        // Token unregistration succeeded
        NSLog(@"Successfully unregistered token : %@", deviceToken);

    } else {
        // Token unregistration failed
        NSLog(@"Failed to unregister : %@", error.localizedDescription);
    }
}];
```

<a id="rich-message"></a>

## Rich Message

* Rich messages represent the media (image, video, audio) in the notification, along with the notification's subject and body, and add actions such as buttons and replies.
* `Rich message reception is supported in iOS 10.0+ or higher.`
* To represent rich messages, you need to implement Notification Service Extension that inherits and implements NHNCloudPushServiceExtension in the user application. (Refer to the [Notification Service Extension](./push-ios/#notification-service-extension) section below for how to add the Notification Service Extension)

<a id="supported-rich-messages"></a>

### Supported Rich Messages

<a id="button"></a>

#### Button

| Type | Feature | Action |
| --- | ------- | --- |
| Open App (OPEN_APP) | Run the application | NHNCloudPushNotificationActionOpenApp |
| Open URL (OPEN_URL) | Go to URL <br/> (run Web URL address or app's custom scheme) | NHNCloudPushNotificationActionOpenURL |
| Reply (REPLY) | Send a reply from notification | NHNCloudPushNotificationActionReply |
| Cancel (DISMISS) | Cancel the current notification | NHNCloudPushNotificationActionDismiss |

> Up to 3 buttons per message are supported.

<a id="media"></a>

#### Media

| Type | Supported formats | Maximum size | Recommendations |
| --- | ------- | --- | --- |
| Image | JPEG, PNG, GIF | 10 MB | Landscape image is recommended <br> Max size: 1038 x 1038 |
| Video | MPEG, MPEG3Video, MPEG4, AVIMovie | 50 MB |  |
| Sound | WaveAudio, MP3, MPEG4Audio | 5 MB |  |

> When a web URL is used, it takes time to download media files.

<a id="metric-collection"></a>

## Metric Collection

* This feature collects metrics for push message reception and user notification execution in the client and sends them to the NHN Cloud server.
* The collected data can be viewed in the Statistics tab.
* `To collect metrics, an Appkey must be defined in Push SDK initialization or info.plist file.`

<a id="received-metric-collection-setting"></a>

### Received Metric Collection Setting

* `Received metrics collection is supported in iOS 10.0+ or higher.`
* Received metrics are automatically collected by the NHN Cloud Push SDK that was added to the Notification Service Extension.
* To collect received metrics, you need to implement Notification Service Extension that inherits and implements NHNCloudPushServiceExtension in the user application. (Refer to the [Notification Service Extension](./push-ios/#notification-service-extension) section below for how to add the Notification Service Extension)
* To enable the collection of received metrics, an Appkey must be defined in the [NHN Cloud Push SDK initialization](./push-ios/#nhn-cloud-push-sdk) in the Notification Service Extension constructor or **extension's info.plist file**.

<a id="example-of-received-metrics-collection-setting-through-initialization"></a>

#### Example of received metrics collection setting through initialization

* `The application and extension are installed together, but since they are on separate sandbox environments, the initialization must be performed in the extension in addition to the initialization in the application.'

``` objc
@implementation NotificationService

- (instancetype)init {
    self = [super init];

    if (self) {
        // Only AppKey needs to be set, because it is used only for sending metrics.
        NHNCloudPushConfiguration *configuration = [[NHNCloudPushConfiguration alloc] initWithAppKey:@"INPUT_YOUR_APPKEY"];

        [NHNCloudPush initWithConfiguration:configuration];
    }

    return self;
}

@end
```

<a id="example-of-received-metrics-collection-setting-through-infoplist-definition"></a>

#### Example of received metrics collection setting through info.plist definition

* Property List

![plist_ext](https://static.toastoven.net/toastcloud/sdk/ios/push_plist_ext_202206.png)

* Source Code

``` xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">

<key>NHNCloudSDK</key>
<dict>
    <key>NHNCloudPush</key>
    <dict>
        <key>AppKey</key>
        <string>[INPUT_YOUR_APPKEY]</string>
    </dict>
</dict>
```

<a id="opened-metric-collection-setting"></a>

### Opened Metric Collection Setting

* Opened metrics are automatically collected from the NHN Cloud Push SDK that was added to the application.
* To enable the collection of opened metrics, an Appkey must be defined in the [NHN Cloud Push SDK initialization](./push-ios/#nhn-cloud-push-sdk) or **application's info.plist file**.

<a id="example-of-opened-metrics-collection-setting-through-infoplist-definition"></a>

#### Example of opened metrics collection setting through info.plist definition

* Property List

![plist_app](https://static.toastoven.net/toastcloud/sdk/ios/push_plist_app_202206.png)

* Source Code

``` xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">

<key>NHNCloudSDK</key>
<dict>
    <key>NHNCloudPush</key>
    <dict>
        <key>AppKey</key>
        <string>[INPUT_YOUR_APPKEY]</string>
    </dict>
</dict>
```

<a id="notification-service-extension"></a>

## Notification Service Extension

* `This is supported from iOS 10.0+.`
* To collect rich messages and received metrics, Notification Service Extension that inherits and implements NHNCloudPushServiceExtension must be implemented in the application.

<a id="create-notification-service-extension"></a>

### Create Notification Service Extension

* **File New > Target > iOS > Notification Service Extension**
![create_ext](https://static.toastoven.net/toastcloud/sdk/ios/push_create_ext_202206.png)

<a id="notification-service-extension-setting"></a>

### Notification Service Extension Setting

* Add the extension's [Project Settings](./push-ios/#project-settings) in the same way as the app's project settings.
* `The extension for iOS is installed along with the app, but they do not share a container because it is on a separate sandbox environment which is separate from the app.'

<a id="notification-service-extension-setting-example"></a>

### Notification Service Extension Setting Example

* The generated NotificationService class must inherit NHNCloudPushServiceExtension .
* If there is no separate custom processing logic, the rich message and received metrics collection feature works just by inheritance.

``` objc
#import <UserNotifications/UserNotifications.h>
#import <NHNCloudPush/NHNCloudPush.h>

@interface NotificationService : NHNCloudPushServiceExtension

@end
```

<a id="user-tag"></a>

## User Tag

* The [User Tag](/Notification/Push/en/console-guide/#tags) feature binds multiple user IDs in one tag and uses it to send messages.
* It operates based on the tag ID (8-character string) rather than the tag name, and the tag ID can be created and checked in the Console > Tag menu.

<a id="specification-for-user-tag-setting-api"></a>

### Specification for User Tag Setting API

``` objc
// Add the tag ID list of the user ID
+ (void)addUserTagWithIdentifiers:(NSSet<NSString *> *)tagIdentifiers
                completionHandler:(nullable void (^)(NSSet<NSString *> * _Nullable tagIdentifiers, NSError * _Nullable error))completionHandler;

// Update the tag ID list of the user ID
+ (void)setUserTagWithIdentifiers:(nullable NSSet<NSString *> *)tagIdentifiers
                completionHandler:(nullable void (^)(NSError * _Nullable error))completionHandler;

// Acquire the tag ID list of the user ID
+ (void)getUserTagWithCompletionHandler:(void (^)(NSSet<NSString *> * _Nullable tagIdentifiers, NSError * _Nullable error))completionHandler;

// Delete the tag ID list of the user ID
+ (void)removeUserTagWithIdentifiers:(NSSet<NSString *> *)tagIdentifiers
                   completionHandler:(nullable void (^)(NSSet<NSString *> * _Nullable tagIdentifiers, NSError * _Nullable error))completionHandler;

// Delete all tags of the user ID
+ (void)removeAllUserTagWithCompletionHandler:(nullable void (^)(NSError * _Nullable error))completionHandler;
```

<a id="modify-user-tags"></a>

### Modify User Tags

<a id="example-of-modifying-user-tags"></a>

#### Example of modifying user tags

* Adds or updates the inputted tag ID list and returns the resulting tag ID list.

``` objc
// Create a tag ID list to add
NSMutableSet<NSString *> *tagIDs = [NSMutableSet set];
[tagIDs addObject:TAG_ID_1];    // e.g. "ZZPP00b6" (8-character string)
[tagIDs addObject:TAG_ID_2];

// Add the tag ID list of the logged-in user ID
[NHNCloudPush addUserTagWithIdentifiers:tagIDs
                      completionHandler:^(NSSet<NSString *> *tagIdentifiers, NSError *error) {

    if (error == nil) {
        // Adding the tag ID list succeeded
    } else {
        // Adding the tag ID list failed
    }
}];

// Update the tag ID list of the logged-in user ID (Existing tag ID list is deleted and set to the inputted value)
[NHNCloudPush setUserTagWithIdentifiers:tagIDs
                      completionHandler:^(NSError *error) {

    if (error == nil) {
        // Updating the tag ID list succeeded
    } else {
        // Updating the tag ID list failed
    }
}];
```

<a id="retrieve-user-tags"></a>

### Retrieve User Tags

* Returns a list of all tag IDs registered to the current user.

<a id="example-of-retrieving-user-tags"></a>

#### Example of retrieving user tags

``` objc
// Returns the whole tag ID list of the logged-in user ID
[NHNCloudPush getUserTagWithCompletionHandler:^(NSSet<NSString *> *tagIdentifiers, NSError *error) {
    if (error == nil) {
        // Tag ID list retrieval succeeded
    } else {
        // Tag ID list retrieval failed
    }
}];
```

<a id="delete-user-tags"></a>

### Delete User Tags

<a id="example-of-deleting-user-tags"></a>

#### Example of deleting user tags

* Deletes the inputted user tag ID list and returns the resulting tag ID list.

``` objc
// Create a tag ID list to delete
NSMutableSet<NSString *> *tagIDs = [NSMutableSet set];
[tagIDs addObject:TAG_ID_1];    // e.g. "ZZPP00b6" (8-character string)
[tagIDs addObject:TAG_ID_2];

// Delete the tag ID list of the logged-in user ID
[NHNCloudPush removeUserTagWithIdentifiers:tagIDs
                         completionHandler:^(NSSet<NSString *> *tagIdentifiers, NSError *error) {
    if (error == nil) {
        // Deleting the tag ID list succeeded
    } else {
        // Deleting the tag ID list failed
    }
}];

// Delete the whole tag ID list of the logged-in user ID
[NHNCloudPush removeAllUserTagWithCompletionHandler:^(NSError *error) {
    if (error == nil) {
        // Deleting the whole user tag succeeded
    } else {
        // Deleting the whole user tag failed
    }
}];
```

<a id="voip"></a>

## VoIP

* `VoIP function is supported from iOS 10.0 or higher.`

<a id="frameworks-setup"></a>

### Frameworks Setup

* To use the VoIP function of NHN Cloud Push, you need to add **PushKit.framework** and **CallKit.framework**.
* PushKit.framework and CallKit.framework can be added in the following way.
![linked_pushkit_frameworks](https://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_PushKit_202206.png)
![linked_callkit_frameworks](https://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_CallKit_202206.png)
![linked_frameworks_push](https://static.toastoven.net/toastcloud/sdk/ios/push_link_frameworks_push_202206.png)

<a id="capabilities-setup-2"></a>

### Capabilities Setup

* **Project Target > Signing & Capabilities > + Capability > Background Modes**
![add_capability_background_modes](https://static.toastoven.net/toastcloud/sdk/ios/add_capability_background_modes_202206.png)

* **Voice over IP** must be enabled.
![capabilities](https://static.toastoven.net/toastcloud/sdk/ios/push_capabilities_voip_202206.png)

<a id="initialization"></a>

### Initialization

* VoIP function is available only when [NHN Cloud Push SDK initialization](./push-ios/#nhn-cloud-push-sdk) has been performed.
* The VoIP function is separated as a submodule of the NHN Cloud Push SDK.

<a id="delegate-setting"></a>

### Delegate Setting

* When a VoIP message is received, the content of the received message is passed to the [NHNCloudPushMessage](./push-ios/#nhncloudpushmessage) object.
* `It is recommended to set Delegate in application:didFinishLaunchingWithOptions: function for smooth message reception.`

<a id="specification-for-delegate-api-2"></a>

#### Specification for Delegate API

``` objc
@protocol NHNCloudVoIPDelegate <NSObject>

// Receive a message
- (void)didReceiveIncomingVoiceCallWithMessage:(NHNCloudPushMessage *)message;

@end
```

<a id="delegate-setting-example"></a>

#### Delegate setting example

``` objc
// Add the VoIP submodule.
#import <NHNCloudPush/NHNCloudVoIP.h>

@interface AppDelegate () <UIApplicationDelegate, NHNCloudVoIPDelegate>

@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // ...

    // Set Delegate.
    [NHNCloudVoIP setDelegate:self];

    return YES;
}

#pragma mark - NHNCloudVoIPDelegate
// Receive a message
- (void)didReceiveIncomingVoiceCallWithMessage:(NHNCloudPushMessage *)message {
    // ...
}
```

<a id="token-registration-2"></a>

### Token Registration

* Register the issued VoIP token information to the NHN Cloud server.
* VoIP function does not require separate user permission and agreement information.

<a id="specification-for-token-registration-api"></a>

#### Specification for Token Registration API

```objc
+ (void)registerWithCompletionHandler:(nullable void (^)(NHNCloudPushTokenInfo * _Nullable tokenInfo, NSError * _Nullable error))completionHandler;
```

<a id="token-registration-example"></a>

#### Token registration example

```objc
[NHNCloudVoIP registerWithCompletionHandler:^(NHNCloudPushTokenInfo *tokenInfo, NSError *error) {
    if (error == nil) {
        // Token registration succeeded
        NSLog(@"Successfully registered : %@", tokenInfo.deviceToken);

    } else {
        // Token registration failed
        NSLog(@"Failed to register : %@", error.localizedDescription);
    }
}];
```

<a id="token-information-query-2"></a>

### Token Information Query

* Query the last successfully registered token and setting information in the current device.
* When the token information query is successful, the setting information of the token is returned to the [NHNCloudPushTokenInfo](./push-ios/#nhncloudpushtokeninfo) object.

<a id="specification-for-token-information-query-api-2"></a>

#### Specification for Token Information Query API

```objc
@interface NHNCloudVoIP : NSObject
+ (void)queryTokenInfoWithCompletionHandler:(void (^)(NHNCloudPushTokenInfo * _Nullable tokenInfo, NSError * _Nullable error))completionHandler;
```

<a id="token-information-query-example-2"></a>

#### Token information query example

```objc
[NHNCloudVoIP queryTokenInfoWithCompletionHandler:^(NHNCloudPushTokenInfo *tokenInfo, NSError *error) {
    if (error == nil) {
        // Token information query succeeded
        NSLog(@"Successfully query token info : %@", [tokenInfo description]);

    } else {
        // Token information query failed
        NSLog(@"Failed to query token info : %@", error.localizedDescription);
    }
}];
```

<a id="token-unregistration-2"></a>

### Token Unregistration

* Unregister the token registered in the NHN Cloud server. Unregistered tokens are excluded from targets for sending messages.
* `If you do not want to receive messages after the service logout, you must unregister the token.`

<a id="specification-for-token-unregistration-api-2"></a>

#### Specification for Token Unregistration API

```objc
+ (void)unregisterWithCompletionHandler:(nullable void (^)(NSString * _Nullable deviceToken, NSError * _Nullable error))completionHandler;
```

<a id="token-unregistration-example-2"></a>

#### Token unregistration example

```objc
[NHNCloudVoIP unregisterWithCompletionHandler:^(NSString *deviceToken, NSError *error) {
    if (error == nil) {
        // Token unregistration succeeded
        NSLog(@"Successfully unregistered token : %@", deviceToken);

    } else {
        // Token unregistration failed
        NSLog(@"Failed to unregister : %@", error.localizedDescription);
    }
}];
```

<a id="error-codes"></a>

## Error Codes

<a id="push-function-error-code"></a>

### Push Function Error Code
```objc
extern NSErrorDomain const NHNCloudPushErrorDomain;

typedef NS_ERROR_ENUM(NHNCloudPushErrorDomain, NHNCloudPushError) {
    NHNCloudPushErrorUnknown = 0,              // Unknown
    NHNCloudPushErrorNotInitialized = 1,       // Not initialized
    NHNCloudPushErrorUserInvalid = 2,          // User ID unset
    NHNCloudPushErrorPermissionDenied = 3,     // Failed to obtain permission
    NHNCloudPushErrorSystemFailed = 4,         // Failure by the system
    NHNCloudPushErrorTokenInvalid = 5,         // Token value unavailable or invalid
    NHNCloudPushErrorAlreadyInProgress = 6,    // Already in progress
    NHNCloudPushErrorParameterInvalid = 7,     // Parameter error
    NHNCloudPushErrorNotSupported = 8,         // Unsupported feature
};
```

<a id="network-error-codes"></a>

### Network Error Codes
``` objc
extern NSErrorDomain const NHNCloudNHNCloudHttpErrorDomain;

typedef NS_ERROR_ENUM(NHNCloudHttpErrorDomain, NHNCloudHttpError) {
    NHNCloudHttpErrorNetworkNotAvailable = 100,        // Network unavailable
    NHNCloudHttpErrorRequestFailed = 101,              // HTTP status code is not 200, or the server could not read the request properly
    NHNCloudHttpErrorRequestTimeout = 102,             // Timeout
    NHNCloudHttpErrorRequestInvalid = 103,             // Invalid request (parameter error, etc.)
    NHNCloudHttpErrorURLInvalid = 104,                 // URL error
    NHNCloudHttpErrorResponseInvalid = 105,            // Server response error
    NHNCloudHttpErrorAlreadyInprogress = 106,          // Same request is already in progress
    NHNCloudHttpErrorRequiresSecureConnection = 107,   // Allow Arbitrary Loads unset
};
```

<a id="nhn-cloud-push-class-reference"></a>

## NHN Cloud Push Class Reference

<a id="nhncloudpushconfiguration"></a>

### NHNCloudPushConfiguration
* Push setting information passed when NHN Cloud Push is initialized.

``` objc
@interface NHNCloudPushConfiguration : NSObject

// Service AppKey
@property (nonatomic, copy, readonly) NSString *appKey;

// Service zone
@property (nonatomic) NHNCloudServiceZone serviceZone;

// Country code (the country code used as a basis time for sending reserved messages)
@property (nonatomic, copy) NSString *countryCode;

// Language code (criteria for language selection when sending multi-language messages)
@property (nonatomic, copy) NSString *languageCode;

// Timezone
@property (nonatomic, copy) NSString *timezone;

// Sandbox (Debug) environment setting
@property (nonatomic) BOOL sandbox;

// Whether to register a token if a user denies permission to allow notifications
@property (nonatomic) BOOL alwaysAllowTokenRegistration;


+ (instancetype)configurationWithAppKey:(NSString *)appKey;

- (instancetype)initWithAppKey:(NSString *)appKey;

@end
```

<a id="nhncloudnotificationoptions"></a>

### NHNCloudNotificationOptions
* Notification setting information passed when NHN Cloud Push is initialized.

``` objc
@interface NHNCloudNotificationOptions : NSObject

// Whether to expose the notification when the app is running
@property (nonatomic) BOOL foregroundEnabled;

// Whether to use a badge icon
@property (nonatomic) BOOL badgeEnabled;

// Whether to use notification sound
@property (nonatomic) BOOL soundEnabled;

@end
```


<a id="nhncloudpushagreement"></a>

### NHNCloudPushAgreement

``` objc
@interface NHNCloudPushAgreement : NSObject

// Whether to agree to show notification
@property (nonatomic, assign) BOOL allowNotifications;

// Whether to agree to show advertising notification
@property (nonatomic, assign) BOOL allowAdvertisements;

// Whether to agree to show night-time advertising notification
@property (nonatomic, assign) BOOL allowNightAdvertisements;


+ (instancetype)agreementWithAllowNotifications:(BOOL)allowNotifications;

* (instancetype)initWithAllowNotifications:(BOOL)allowNotifications;

@end
```

<a id="nhncloudpushmessage"></a>

### NHNCloudPushMessage
* An object returned when receiving a message.

```objc
@interface NHNCloudPushMessage : NSObject

@property (nonatomic, readonly) NSString *identifier;

@property (nonatomic, readonly, nullable) NSString *title;

@property (nonatomic, readonly, nullable) NSString *body;

@property (nonatomic, readonly) NSInteger badge;

@property (nonatomic, readonly, nullable) NHNCloudPushRichMessage *richMessage;

@property (nonatomic, readonly) NSDictionary<NSString *, NSString *> *payload;

@end
```

<a id="nhncloudpushmessage-2"></a>

### NHNCloudPushMessage
* An object containing the contents of the rich message among the received message contents.

```objc
@interface NHNCloudPushRichMessage : NSObject

@property (nonatomic, readonly, nullable) NHNCloudPushMedia *media;

@property (nonatomic, readonly, nullable) NSArray<NHNCloudPushButton *> *buttons;

@end
```

<a id="nhncloudpushmedia"></a>

### NHNCloudPushMedia
* An object containing media contents among the received rich messages.

```objc
@interface NHNCloudPushMedia : NSObject

@property (nonatomic, readonly) NHNCloudPushMediaType mediaType;

@property (nonatomic, readonly) NSString *source;

@end
```

<a id="nhncloudpushbutton"></a>

### NHNCloudPushButton
* An object containing the button contents among the received rich message contents.

```objc
@interface NHNCloudPushButton : NSObject

@property (nonatomic, readonly) NSString *identifier;

@property (nonatomic, readonly) NHNCloudPushButtonType buttonType;

@property (nonatomic, readonly) NSString *name;

@property (nonatomic, readonly, nullable) NSString *link;

@property (nonatomic, readonly, nullable) NSString *hint;

@property (nonatomic, readonly, nullable) NSString *submit;

@end
```

<a id="nhncloudpushnotificationaction"></a>

### NHNCloudPushNotificationAction
* An object returned when notification action (button, reply) is received.

```objc
typedef NS_ENUM(NSInteger, NHNCloudPushNotificationActionType) {
    NHNCloudPushNotificationActionDismiss = 0,
    NHNCloudPushNotificationActionOpenApp = 1,
    NHNCloudPushNotificationActionOpenURL = 2,
    NHNCloudPushNotificationActionReply = 3,
};


@interface NHNCloudPushNotificationAction : NSObject <NSCoding, NSCopying>

@property (nonatomic, readonly) NSString *actionIdentifier;

@property (nonatomic, readonly) NSString *categoryIdentifier;

@property (nonatomic, readonly) NHNCloudPushNotificationActionType actionType;

@property (nonatomic, readonly) NHNCloudPushButton *button;

@property (nonatomic, readonly) NHNCloudPushMessage *message;

@property (nonatomic, readonly, nullable) NSString *userText;

@end
```

<a id="nhncloudpushtokeninfo"></a>

### NHNCloudPushTokenInfo
* A token information object returned when requesting token information query.

``` objc
typedef NSString *NHNCloudPushType NS_STRING_ENUM;
// APNS type
extern NHNCloudPushType const NHNCloudPushTypeAPNS;
// VoIP type
extern NHNCloudPushType const NHNCloudPushTypeVoIP;


@interface NHNCloudPushTokenInfo : NSObject

// User ID
@property (nonatomic, readonly) NSString *userID;

// Token
@property (nonatomic, readonly) NSString *deviceToken;

// Country code
@property (nonatomic, readonly) NSString *countryCode;

// Language setting
@property (nonatomic, readonly) NSString *languageCode;

// Push token type
@property (nonatomic, readonly) NHNCloudPushType pushType;

// Whether to agree to show notification
@property (nonatomic, readonly) BOOL allowNotifications;

// Whether to agree to show advertising notification
@property (nonatomic, readonly) BOOL allowAdvertisements;

// Whether to agree to show night-time advertising notification
@property (nonatomic, readonly) BOOL allowNightAdvertisements;

// Timezone
@property (nonatomic, readonly) NSString *timezone;

// Token update time
@property (nonatomic, readonly) NSString *updateDateTime;

// Whether the token is registered in the sandbox environment
@property (nonatomic, getter=isSandbox) BOOL sandbox;

@end
```