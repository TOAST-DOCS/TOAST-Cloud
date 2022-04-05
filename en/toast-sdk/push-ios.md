## NHN Cloud > SDK User Guide > Push > iOS

## Prerequisites

1. Install [NHN Cloud SDK](./getting-started-ios).
2. [Enable Notification \> Push](http://docs.toast.com/en/Notification/Push/en/console-guide/) in [NHN Cloud Console](https://console.cloud.toast.com).
3. Check your AppKey in Push.

## APNS Guide
* [APNS Guide](https://developer.apple.com/library/archive/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/APNSOverview.html)

## NHN Cloud Push Components

* NHN Cloud Push SDK for iOS consists of the following:

| Service  | Cocoapods Pod Name | Framework | Dependency | Build Settings |
| --- | --- | --- | --- | --- |
| Push | ToastPush | ToastPush.framework | UserNotifications.framework <br/> <br/> [ToastVoIP] <br/> PushKit.framework <br/> CallKit.framework | |
| Mandatory   | ToastCore <br/> ToastCommon | ToastCore.framework <br/> ToastCommon.framework | | OTHER_LDFLAGS = ( <br/> "-ObjC", <br/> "-lc++" <br/> ); |

## Apply NHN Cloud Push SDK to Xcode Projects

### 1. Apply using Cococapods

* Create a Podfile and add a pod for NHN Cloud SDK.

``` podspec
platform :ios, '9.0'
use_frameworks!

target '{YOUR PROJECT TARGET NAME}' do
    pod 'ToastPush'
end
```

### 2. Apply NHN Cloud SDK by Downloading Binaries

#### Frameworks Setup

* You can download the full iOS SDK from the [Downloads](../../../Download/#toast-sdk) page of NHN Cloud.
* Add **ToastPush.framework**, **ToastCore.framework**, **ToastCommon.framework, UserNotifications.framework** to your Xcode Project.
* UserNotifications.framework can be added in the following way.
![linked_usernotifications_frameworks](http://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_UserNotifications.png)

#### Project Settings

* Add **-lc++** and **-ObjC** items to **Other Linker Flags** in **Build Settings**.
    * **Project Target > Build Settings > Linking > Other Linker Flags**
![other_linker_flags](http://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags.png)

### Capabilities Setup

* To use NHN Cloud Push, you must enable **Push Notification** and **Background Modes** items in Capabilities.
    * **Project Target > Signing & Capabilities > + Capability > Push Notification**
![add_capability_push_notifications](http://static.toastoven.net/toastcloud/sdk/ios/add_capability_notifications.png)
    * **Project Target > Signing & Capabilities > + Capability > Background Modes**
![add_capability_background_modes](http://static.toastoven.net/toastcloud/sdk/ios/add_capability_background_modes.png)
    * In **Background Modes** items, **Remote notifications** must be enabled.
![capabilities](http://static.toastoven.net/toastcloud/sdk/ios/push_capabilities.png)

## Changes for Xcode11/iOS13
* Common
    * Starting with Xcode 11, projects using NHN Cloud SDK version lower than 0.18.0 have a problem where token registration fails on iOS 13.
    * `If you are using Xcode 11 or higher, you must use the TOAST SDK version 0.18.0 or higher. (Xcode 11, iOS 13)`
* VoIP
    * In iOS 13 or higher, if you do not report to CallKit after receiving a VoIP message, the message reception becomes restricted. ([PushKit pushRegistry guide](https://developer.apple.com/documentation/pushkit/pkpushregistrydelegate/2875784-pushregistry))
    * The call reception screen using CallKit must be implemented in the app.

## Service Login

* All products provided by NHN Cloud SDK (Push, IAP, Log & Crash, ...) share one user ID.

### Login

* `If a user ID is not set at the time of initial token registration, it is registered using the device identifier.` ([Refer to the token registration section](https://docs.toast.com/en/TOAST/ko/toast-sdk/push-ios/#_10))
* `Setting or changing the user ID after token registration will update token information.`

``` objc
// Service login, set the user ID
[ToastSDK setUserID:@"INPUT_USER_ID"];
```

### Logout

* `Even if logout occurs, the registered token is not deleted.`

``` objc
// Service logout, set the user ID to nil
[ToastSDK setUserID:nil];
```

## Initialize NHN Cloud Push SDK

* `The token registration and query features cannot be used without initialization.`
* Set the Push AppKey issued from the Toast Cloud server in the [ToastPushConfiguration](./push-ios/#toastpushconfiguration) object.
* `In the development environment, the sandbox property of ToastPushConfiguration must be set to YES to receive the message sent using the development certificate.'

### Specification for Initialization API

``` objc
// Initialize and set Delegate
+ (void)initWithConfiguration:(ToastPushConfiguration *)configuration
                     delegate:(nullable id<ToastPushDelegate>)delegate;

// Initialize
+ (void)initWithConfiguration:(ToastPushConfiguration *)configuration;

// Set Delegate
+ (void)setDelegate:(nullable id<ToastPushDelegate>)delegate;
```

### Specification for Delegate API
* When receiving a notification message while the app is running, the content of the received message is passed to the [ToastPushMessage](./push-ios/#toastpushmessage) object.
* When the app is launched by the user executing (clicking) the notification, the content of the executed notification message is passed to the [ToastPushMessage](./push-ios/#toastpushmessage) object.
* When the user executes (clicks) the button on the notification, the action information of the executed button is passed to the [ToastPushNotificationAction](./push-ios/#toastpushnotificationaction) object.
* `It is recommended to set Delegate in application:didFinishLaunchingWithOptions: function for smooth message reception.`

``` objc
@protocol ToastPushDelegate <NSObject>

@optional

// Receive a message
- (void)didReceiveNotificationWithMessage:(ToastPushMessage *)message;

// Execute notification (click)
- (void)didReceiveNotificationResponseWithMessage:(ToastPushMessage *)message

// Execute notification action (button)
- (void)didReceiveNotificationAction:(ToastPushNotificationAction *)action

@end
```

### Example of Initialization and Delegate Setting

``` objc
#import <ToastPush/ToastPush.h>

@interface AppDelegate () <UIApplicationDelegate, ToastPushDelegate>

@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // ...

    // Create a configuration object.
    ToastPushConfiguration *configuration = [[ToastPushConfiguration alloc] initWithAppKey:@"INPUT_YOUR_APPKEY"];

#if DEBUG
    // In the development environment (DEBUG), the sandbox property below must be set to YES to receive the message sent using the development certificate.
    configuration.sandbox = YES;
#endif

    // Set Delegate in tandem with the initialization.
    [ToastPush initWithConfiguration:configuration
                            delegate:self];

    return YES;
}

#pragma mark - ToastPushDelegate
// Receive a message
- (void)didReceiveNotificationWithMessage:(ToastPushMessage *)message {
    // ...
}

// Notification response (execute)
- (void)didReceiveNotificationResponseWithMessage:(ToastPushMessage *)message {
    // ...
}

// Execute notification action (button, reply)
- (void)didReceiveNotificationAction:(ToastPushNotificationAction *)action {
    // ...
}
```

## Notification Option Setting

* You can set notification options with the [ToastNotificationOptions](./push-ios/#toastnotificationoptions) object.

| Option Name | Description | Default |
| --- | --- | --- |
| foregroundEnabled | Whether to show notifications when the app is in the foreground state | NO |
| badgeEnabled | Whether to use a badge icon | YES |
| soundEnabled | Whether to use a notification sound | YES |

* The default behavior is not to expose notifications when the app is in the foreground state, so if you want notifications to show up, you need to set the notification option.

### Specification for Notification Option Setting API

``` objc
+ (void)setNotificationOptions:(nullable ToastNotificationOptions *)options;
```

### Example of notification option setting

``` objc
ToastNotificationOptions *options = [[ToastNotificationOptions alloc] init];
options.foregroundEnabled = YES;    // Set the use of foreground notification (default : NO)
options.badgeEnabled = YES;         // Set the use of badge icon (default : YES)
options.soundEnabled = YES;         // Set the use of notification sound (default : YES)

[ToastPush setNotificationOptions:options];
```

## Token Registration

* Register the issued token information to the NHN Cloud server. At this time,  pass whether or not to agree to receive the push (ToastPushAgreement) as a parameter.
* If this is the initial execution, request the user for permission to allow notifications. If the permission to allow notifications is not acquired, token registration fails.
* If a user ID is not set at the time of initial token registration, it is registered using the device identifier.

### Agreement Setting

* In accordance with the provisions of the Information and Communications Network Act (Articles 50 through 50-8), when registering a token, whether or not to receive notification/advertising/night-time advertising push messages must also be inputted. When sending a message, it is automatically filtered based on whether or not the user agreed to receive it.
    * [Shortcut to KISA Guide](https://www.kisa.or.kr/2060301/form?postSeq=19)
    * [Shortcut to the law](http://www.law.go.kr/법령/정보통신망이용촉진및정보보호등에관한법률/%2820130218,11322,20120217%29/제50조)
* Set user notification message agreement information in the [ToastPushAgreement](./push-ios/#toastpushagreement) object.

### Specification for token registration and agreement setting API

``` objc
// Token registration and agreement setting
+ (void)registerWithAgreement:(ToastPushAgreement *)agreement
            completionHandler:(nullable void (^)(ToastPushTokenInfo * _Nullable tokenInfo, NSError * _Nullable error))completionHandler;

// Register a token using the previously set agreement information
+ (void)registerWithCompletionHandler:(nullable void (^)(ToastPushTokenInfo * _Nullable tokenInfo, NSError * _Nullable error))completionHandler;
```

### Example of token registration and agreement setting

``` objc
ToastPushAgreement *agreement = [[ToastPushAgreement alloc] initWithAllowNotifications:YES]; // Agree to receive notification message
agreement.allowAdvertisements = YES;        // Agree to receive advertising notification message
agreement.allowNightAdvertisements = YES;   // Agree to receive night-time advertising notification message

[ToastPush registerWithAgreement:agreement
               completionHandler:^(ToastPushTokenInfo *tokenInfo, NSError *error) {

    if (error == nil) {
        // Token registration succeeded
        NSLog(@"Successfully registered : %@", tokenInfo.deviceToken);

    } else {
        // Token registration failed
        NSLog(@"Failed to register : %@", error.localizedDescription);
    }
}];
```

## Token Information Query

* Query the last successfully registered token and setting information in the current device.
* When the token information query is successful, the setting information of the token is returned to the [ToastPushTokenInfo](./push-ios/#toastpushtokeninfo) object.

### Specification for Token Information Query API

``` objc
+ (void)queryTokenInfoWithCompletionHandler:(void (^)(ToastPushTokenInfo * _Nullable tokenInfo, NSError * _Nullable error))completionHandler;
```

### Token information query example

``` objc
[ToastPush queryTokenInfoWithCompletionHandler:^(ToastPushTokenInfo *tokenInfo, NSError *error) {
    if (error == nil) {
        // Token information query succeeded
        NSLog(@"Successfully query token info : %@", [tokenInfo description]);

    } else {
        // Token information query failed
        NSLog(@"Failed to query token info : %@", error.localizedDescription);
    }
}];
```

## Token Unregistration

* Unregister the token registered in the NHN Cloud server. Unregistered tokens are excluded from targets for sending messages.
* `If you do not want to receive messages after the service logout, you must unregister the token.`
* `Even if the token is unregistered, the notification permission on the device is not revoked.`

### Specification for Token Unregistration API

``` objc
+ (void)unregisterWithCompletionHandler:(nullable void (^)(NSString * _Nullable deviceToken, NSError * _Nullable error))completionHandler;
```

### Token unregistration example

``` objc
[ToastPush unregisterWithCompletionHandler:^(NSString *deviceToken, NSError *error) {
    if (error == nil) {
        // Token unregistration succeeded
        NSLog(@"Successfully unregistered token : %@", deviceToken);

    } else {
        // Token unregistration failed
        NSLog(@"Failed to unregister : %@", error.localizedDescription);
    }
}];
```

## Rich Message

* Rich messages represent the media (image, video, audio) in the notification, along with the notification's subject and body, and add actions such as buttons and replies.
* `Rich message reception is supported in iOS 10.0+ or higher.`
* To represent rich messages, you need to implement Notification Service Extension that inherits and implements ToastPushServiceExtension in the user application. (Refer to the [Notification Service Extension](./push-ios/#notification-service-extension) section below for how to add the Notification Service Extension)

### Supported Rich Messages

#### Button

| Type | Feature | Action |
| --- | ------- | --- |
| Open App (OPEN_APP) | Run the application | ToastPushNotificationActionOpenApp |
| Open URL (OPEN_URL) | Go to URL <br/> (run Web URL address or app's custom scheme) | ToastPushNotificationActionOpenURL |
| Reply (REPLY) | Send a reply from notification | ToastPushNotificationActionReply |
| Cancel (DISMISS) | Cancel the current notification | ToastPushNotificationActionDismiss |

> Up to 3 buttons per message are supported.

#### Media

| Type | Supported formats | Maximum size | Recommendations |
| --- | ------- | --- | --- |
| Image | JPEG, PNG, GIF | 10 MB | Landscape image is recommended <br> Max size: 1038 x 1038 |
| Video | MPEG, MPEG3Video, MPEG4, AVIMovie | 50 MB |  |
| Sound | WaveAudio, MP3, MPEG4Audio | 5 MB |  |

> When a web URL is used, it takes time to download media files.

## Metric Collection

* This feature collects metrics for push message reception and user notification execution in the client and sends them to the NHN Cloud server.
* The collected data can be viewed in the Statistics tab.
* `To collect metrics, an Appkey must be defined in Push SDK initialization or info.plist file.`

### Received Metric Collection Setting

* `Received metrics collection is supported in iOS 10.0+ or higher.`
* Received metrics are automatically collected by the Toast Push SDK that was added to the Notification Service Extension.
* To collect received metrics, you need to implement Notification Service Extension that inherits and implements ToastPushServiceExtension in the user application. (Refer to the [Notification Service Extension](./push-ios/#notification-service-extension) section below for how to add the Notification Service Extension)
* To enable the collection of received metrics, an Appkey must be defined in the [NHN Cloud Push SDK initialization](./push-ios/#toast-push-sdk) in the Notification Service Extension constructor or **extension's info.plist file**.

#### Example of received metrics collection setting through initialization

* `The application and extension are installed together, but since they are on separate sandbox environments, the initialization must be performed in the extension in addition to the initialization in the application.'

``` objc
@implementation NotificationService

- (instancetype)init {
    self = [super init];

    if (self) {
        // Only AppKey needs to be set, because it is used only for sending metrics.
        ToastPushConfiguration *configuration = [[ToastPushConfiguration alloc] initWithAppKey:@"INPUT_YOUR_APPKEY"];

        [ToastPush initWithConfiguration:configuration];
    }

    return self;
}

@end
```

#### Example of received metrics collection setting through info.plist definition

* Property List

![plist_ext](http://static.toastoven.net/toastcloud/sdk/ios/push_plist_ext.png)

* Source Code

``` xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">

<key>ToastSDK</key>
<dict>
    <key>ToastPush</key>
    <dict>
        <key>AppKey</key>
        <string>[INPUT_YOUR_APPKEY]</string>
    </dict>
</dict>
```

### Opened Metric Collection Setting

* Opened metrics are automatically collected from the Toast Push SDK that was added to the application.
* To enable the collection of opened metrics, an Appkey must be defined in the [NHN Cloud Push SDK initialization](./push-ios/#toast-push-sdk) or **application's info.plist file**.

#### Example of opened metrics collection setting through info.plist definition

* Property List

![plist_app](http://static.toastoven.net/toastcloud/sdk/ios/push_plist_app.png)

* Source Code

``` xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">

<key>ToastSDK</key>
<dict>
    <key>ToastPush</key>
    <dict>
        <key>AppKey</key>
        <string>[INPUT_YOUR_APPKEY]</string>
    </dict>
</dict>
```

## Notification Service Extension

* `This is supported from iOS 10.0+.`
* To collect rich messages and received metrics, Notification Service Extension that inherits and implements ToastPushServiceExtension must be implemented in the application.

### Create Notification Service Extension

* **File New > Target > iOS > Notification Service Extension**
![create_ext](http://static.toastoven.net/toastcloud/sdk/ios/push_create_ext.png)

### Notification Service Extension Setting

* Add the extension's [Project Settings](./push-ios/#project-settings) in the same way as the app's project settings.
* `The extension for iOS is installed along with the app, but they do not share a container because it is on a separate sandbox environment which is separate from the app.'

### Notification Service Extension Setting Example

* The generated NotificationService class must inherit ToastPushServiceExtension .
* If there is no separate custom processing logic, the rich message and received metrics collection feature works just by inheritance.

``` objc
#import <UserNotifications/UserNotifications.h>
#import <ToastPush/ToastPush.h>

@interface NotificationService : ToastPushServiceExtension

@end
```

## User Tag

* The [User Tag](https://docs.toast.com/en/Notification/Push/en/console-guide/#tags) feature binds multiple user IDs in one tag and uses it to send messages.
* It operates based on the tag ID (8-character string) rather than the tag name, and the tag ID can be created and checked in the Console > Tag menu.

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

### Modify User Tags

#### Example of modifying user tags

* Adds or updates the inputted tag ID list and returns the resulting tag ID list.

``` objc
// Create a tag ID list to add
NSMutableSet<NSString *> *tagIDs = [NSMutableSet set];
[tagIDs addObject:TAG_ID_1];    // e.g. "ZZPP00b6" (8-character string)
[tagIDs addObject:TAG_ID_2];

// Add the tag ID list of the logged-in user ID
[ToastPush addUserTagWithIdentifiers:tagIDs
                    cmpletionHandler:^(NSSet<NSString *> *tagIdentifiers, NSError *error) {

    if (error == nil) {
        // Adding the tag ID list succeeded
    } else {
        // Adding the tag ID list failed
    }
}];

// Update the tag ID list of the logged-in user ID (Existing tag ID list is deleted and set to the inputted value)
[ToastPush setUserTagWithIdentifiers:tagIDs
                    cmpletionHandler:^(NSError *error) {

    if (error == nil) {
        // Updating the tag ID list succeeded
    } else {
        // Updating the tag ID list failed
    }
}];
```

### Retrieve User Tags

* Returns a list of all tag IDs registered to the current user.

#### Example of retrieving user tags

``` objc
// Returns the whole tag ID list of the logged-in user ID
[ToastPush getUserTagWithCompletionHandler:^(NSSet<NSString *> *tagIdentifiers, NSError *error) {
    if (error == nil) {
        // Tag ID list retrieval succeeded
    } else {
        // Tag ID list retrieval failed
    }
}];
```

### Delete User Tags

#### Example of deleting user tags

* Deletes the inputted user tag ID list and returns the resulting tag ID list.

``` objc
// Create a tag ID list to delete
NSMutableSet<NSString *> *tagIDs = [NSMutableSet set];
[tagIDs addObject:TAG_ID_1];    // e.g. "ZZPP00b6" (8-character string)
[tagIDs addObject:TAG_ID_2];

// Delete the tag ID list of the logged-in user ID
[ToastPush removeUserTagWithIdentifiers:tagIDs
                      completionHandler:^(NSSet<NSString *> *tagIdentifiers, NSError *error) {
    if (error == nil) {
        // Deleting the tag ID list succeeded
    } else {
        // Deleting the tag ID list failed
    }
}];

// Delete the whole tag ID list of the logged-in user ID
[ToastPush removeAllUserTagWithCompletionHandler:^(NSError *error) {
    if (error == nil) {
        // Deleting the whole user tag succeeded
    } else {
        // Deleting the whole user tag failed
    }
}];
```

## VoIP

* `VoIP function is supported from iOS 10.0 or higher.`

### Frameworks Setup

* To use the VoIP function of NHN Cloud Push, you need to add **PushKit.framework** and **CallKit.framework**.
* PushKit.framework and CallKit.framework can be added in the following way.
![linked_pushkit_frameworks](http://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_PushKit.png)
![linked_callkit_frameworks](http://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_CallKit.png)
![linked_frameworks_push](http://static.toastoven.net/toastcloud/sdk/ios/push_link_frameworks_push.png)

### Capabilities Setup

* **Project Target > Signing & Capabilities > + Capability > Background Modes**
![add_capability_background_modes](http://static.toastoven.net/toastcloud/sdk/ios/add_capability_background_modes.png)

* **Voice over IP** must be enabled.
![capabilities](http://static.toastoven.net/toastcloud/sdk/ios/push_capabilities_voip.png)

### Initialization

* VoIP function is available only when [NHN Cloud Push SDK initialization](./push-ios/#toast-push-sdk) has been performed.
* The VoIP function is separated as a submodule of the Toast Push SDK.

### Delegate Setting

* When a VoIP message is received, the content of the received message is passed to the [ToastPushMessage](./push-ios/#toastpushmessage) object.
* `It is recommended to set Delegate in application:didFinishLaunchingWithOptions: function for smooth message reception.`

#### Specification for Delegate API

``` objc
@protocol ToastVoIPDelegate <NSObject>

// Receive a message
- (void)didReceiveIncomingVoiceCallWithMessage:(ToastPushMessage *)message;

@end
```

#### Delegate setting example

``` objc
// Add the VoIP submodule.
#import <ToastPush/ToastVoIP.h>

@interface AppDelegate () <UIApplicationDelegate, ToastVoIPDelegate>

@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // ...

    // Set Delegate.
    [ToastVoIP setDelegate:self];

    return YES;
}

#pragma mark - ToastVoIPDelegate
// Receive a message
- (void)didReceiveIncomingVoiceCallWithMessage:(ToastPushMessage *)message {
    // ...
}
```

### Token Registration

* Register the issued VoIP token information to the NHN Cloud server.
* VoIP function does not require separate user permission and agreement information.

#### Specification for Token Registration API

```objc
+ (void)registerWithCompletionHandler:(nullable void (^)(ToastPushTokenInfo * _Nullable tokenInfo, NSError * _Nullable error))completionHandler;
```

#### Token registration example

```objc
[ToastVoIP registerWithCompletionHandler:^(ToastPushTokenInfo *tokenInfo, NSError *error) {
    if (error == nil) {
        // Token registration succeeded
        NSLog(@"Successfully registered : %@", tokenInfo.deviceToken);

    } else {
        // Token registration failed
        NSLog(@"Failed to register : %@", error.localizedDescription);
    }
}];
```

### Token Information Query

* Query the last successfully registered token and setting information in the current device.
* When the token information query is successful, the setting information of the token is returned to the [ToastPushTokenInfo](./push-ios/#toastpushtokeninfo) object.

#### Specification for Token Information Query API

```objc
@interface ToastVoIP : NSObject
+ (void)queryTokenInfoWithCompletionHandler:(void (^)(ToastPushTokenInfo * _Nullable tokenInfo, NSError * _Nullable error))completionHandler;
```

#### Token information query example

```objc
[ToastVoIP queryTokenInfoWithCompletionHandler:^(ToastPushTokenInfo *tokenInfo, NSError *error) {
    if (error == nil) {
        // Token information query succeeded
        NSLog(@"Successfully query token info : %@", [tokenInfo description]);

    } else {
        // Token information query failed
        NSLog(@"Failed to query token info : %@", error.localizedDescription);
    }
}];
```

### Token Unregistration

* Unregister the token registered in the NHN Cloud server. Unregistered tokens are excluded from targets for sending messages.
* `If you do not want to receive messages after the service logout, you must unregister the token.`

#### Specification for Token Unregistration API

```objc
+ (void)unregisterWithCompletionHandler:(nullable void (^)(NSString * _Nullable deviceToken, NSError * _Nullable error))completionHandler;
```

#### Token unregistration example

```objc
[ToastVoIP unregisterWithCompletionHandler:^(NSString *deviceToken, NSError *error) {
    if (error == nil) {
        // Token unregistration succeeded
        NSLog(@"Successfully unregistered token : %@", deviceToken);

    } else {
        // Token unregistration failed
        NSLog(@"Failed to unregister : %@", error.localizedDescription);
    }
}];
```

## Error Codes

### Push Function Error Code
```objc
extern NSErrorDomain const ToastPushErrorDomain;

typedef NS_ERROR_ENUM(ToastPushErrorDomain, ToastPushError) {
    ToastPushErrorUnknown = 0,              // Unknown
    ToastPushErrorNotInitialized = 1,       // Not initialized
    ToastPushErrorUserInvalid = 2,          // User ID unset
    ToastPushErrorPermissionDenied = 3,     // Failed to obtain permission
    ToastPushErrorSystemFailed = 4,         // Failure by the system
    ToastPushErrorTokenInvalid = 5,         // Token value unavailable or invalid
    ToastPushErrorAlreadyInProgress = 6,    // Already in progress
    ToastPushErrorParameterInvalid = 7,     // Parameter error
    ToastPushErrorNotSupported = 8,         // Unsupported feature
};
```

### Network Error Codes
``` objc
extern NSErrorDomain const ToastHttpErrorDomain;

typedef NS_ERROR_ENUM(ToastHttpErrorDomain, ToastHttpError) {
    ToastHttpErrorNetworkNotAvailable = 100,        // Network unavailable
    ToastHttpErrorRequestFailed = 101,              // HTTP status code is not 200, or the server could not read the request properly
    ToastHttpErrorRequestTimeout = 102,             // Timeout
    ToastHttpErrorRequestInvalid = 103,             // Invalid request (parameter error, etc.)
    ToastHttpErrorURLInvalid = 104,                 // URL error
    ToastHttpErrorResponseInvalid = 105,            // Server response error
    ToastHttpErrorAlreadyInprogress = 106,          // Same request is already in progress
    ToastHttpErrorRequiresSecureConnection = 107,   // Allow Arbitrary Loads unset
};
```

## NHN Cloud Push Class Reference

### ToastPushConfiguration
* Push setting information passed when NHN Cloud Push is initialized.

``` objc
@interface ToastPushConfiguration : NSObject

// Service AppKey
@property (nonatomic, copy, readonly) NSString *appKey;

// Service zone
@property (nonatomic) ToastServiceZone serviceZone;

// Country code (the country code used as a basis time for sending reserved messages)
@property (nonatomic, copy) NSString *countryCode;

// Language code (criteria for language selection when sending multi-language messages)
@property (nonatomic, copy) NSString *languageCode;

// Timezone
@property (nonatomic, copy) NSString *timezone;

// Sandbox (Debug) environment setting
@property (nonatomic) BOOL sandbox;


+ (instancetype)configurationWithAppKey:(NSString *)appKey;

- (instancetype)initWithAppKey:(NSString *)appKey;

@end
```

### ToastNotificationOptions
* Notification setting information passed when NHN Cloud Push is initialized.

``` objc
@interface ToastNotificationOptions : NSObject

// Whether to expose the notification when the app is running
@property (nonatomic) BOOL foregroundEnabled;

// Whether to use a badge icon
@property (nonatomic) BOOL badgeEnabled;

// Whether to use notification sound
@property (nonatomic) BOOL soundEnabled;

@end
```


### ToastPushAgreement

``` objc
@interface ToastPushAgreement : NSObject

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

### ToastPushMessage
* An object returned when receiving a message.

```objc
@interface ToastPushMessage : NSObject

@property (nonatomic, readonly) NSString *identifier;

@property (nonatomic, readonly, nullable) NSString *title;

@property (nonatomic, readonly, nullable) NSString *body;

@property (nonatomic, readonly) NSInteger badge;

@property (nonatomic, readonly, nullable) ToastPushRichMessage *richMessage;

@property (nonatomic, readonly) NSDictionary<NSString *, NSString *> *payload;

@end
```

### ToastPushMessage
* An object containing the contents of the rich message among the received message contents.

```objc
@interface ToastPushRichMessage : NSObject

@property (nonatomic, readonly, nullable) ToastPushMedia *media;

@property (nonatomic, readonly, nullable) NSArray<ToastPushButton *> *buttons;

@end
```

### ToastPushMedia
* An object containing media contents among the received rich messages.

```objc
@interface ToastPushMedia : NSObject

@property (nonatomic, readonly) ToastPushMediaType mediaType;

@property (nonatomic, readonly) NSString *source;

@end
```

### ToastPushButton
* An object containing the button contents among the received rich message contents.

```objc
@interface ToastPushButton : NSObject

@property (nonatomic, readonly) NSString *identifier;

@property (nonatomic, readonly) ToastPushButtonType buttonType;

@property (nonatomic, readonly) NSString *name;

@property (nonatomic, readonly, nullable) NSString *link;

@property (nonatomic, readonly, nullable) NSString *hint;

@property (nonatomic, readonly, nullable) NSString *submit;

@end
```

### ToastPushNotificationAction
* An object returned when notification action (button, reply) is received.

```objc
typedef NS_ENUM(NSInteger, ToastPushNotificationActionType) {
    ToastPushNotificationActionDismiss = 0,
    ToastPushNotificationActionOpenApp = 1,
    ToastPushNotificationActionOpenURL = 2,
    ToastPushNotificationActionReply = 3,
};


@interface ToastPushNotificationAction : NSObject <NSCoding, NSCopying>

@property (nonatomic, readonly) NSString *actionIdentifier;

@property (nonatomic, readonly) NSString *categoryIdentifier;

@property (nonatomic, readonly) ToastPushNotificationActionType actionType;

@property (nonatomic, readonly) ToastPushButton *button;

@property (nonatomic, readonly) ToastPushMessage *message;

@property (nonatomic, readonly, nullable) NSString *userText;

@end
```

### ToastPushTokenInfo
* A token information object returned when requesting token information query.

``` objc
typedef NSString *ToastPushType NS_STRING_ENUM;
// APNS type
extern ToastPushType const ToastPushTypeAPNS;
// VoIP type
extern ToastPushType const ToastPushTypeVoIP;


@interface ToastPushTokenInfo : NSObject

// User ID
@property (nonatomic, readonly) NSString *userID;

// Token
@property (nonatomic, readonly) NSString *deviceToken;

// Country code
@property (nonatomic, readonly) NSString *countryCode;

// Language setting
@property (nonatomic, readonly) NSString *languageCode;

// Push token type
@property (nonatomic, readonly) ToastPushType pushType;

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