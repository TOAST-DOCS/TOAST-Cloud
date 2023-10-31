## NHN Cloud > SDK User Guide > Push > Android

## Prerequisites

1. Install [NHN Cloud SDK](./getting-started-android).
2. [Enable Push service](https://nhncloud.com/en/Notification/Push/en/console-guide/) in [NHN Cloud console](https://console.nhncloud.com).
3. Check the AppKey in the Push console.

## Guide by Push Provider

* [Firebase Cloud Messaging (FCM) Guide](https://firebase.google.com/docs/cloud-messaging/)
* `Tencent Push Notification (QQ) service ended in November 2020`

## Library Setting

### FCM
* To use NHN Cloud FCM Push, add a dependency to build.gradle as follows.

```groovy
repositories {
    google()
    mavenCentral()
}

dependencies {
    implementation 'com.nhncloud.android:nhncloud-push-fcm:1.8.1'
    ...
}
```

### ADM

* To use NHN Cloud ADM Push, add a dependency to build.gradle as follows.

```groovy
repositories {
    google()
    mavenCentral()
}

dependencies {
    implementation 'com.nhncloud.android:nhncloud-push-adm:1.8.1'
    ...
}
```

## Firebase Cloud Messaging Settings

### Add the project and app

* Create a project in [Firebase console](https://console.firebase.google.com/?hl=en).
* Go to **Project Settings** by clicking the gear button at the top of the console.
* Under **My Apps** in Project Settings, click **Add Firebase to Android App**.
* Enter **Android Package Name**, **App Nickname (optional)** and click the **Register App** button.
* Click the **Download google-services.json** button to download the setting information.
* Move the downloaded **google-services.json** file to your app's module (app level) directory.
* For details, see [Add Firebase to your Android project](https://firebase.google.com/docs/android/setup).

### Set Up build.gradle
#### Root-level build.gradle
* Add the following code to root-level build.gradle.

```groovy
buildscript {
    // ...
    dependencies {
        // ...
        classpath "com.google.gms:google-services:$google_services_version" // google-services plugin
    }
}

allprojects {
    // ...
    repositories {
        // ...
        google() // Google's Maven repository
    }
}
```

#### App module's build.gradle
* Add the following code to your app module's build.gradle.

```groovy
apply plugin: 'com.android.application'

android {
  // ...
}

// ADD THIS AT THE BOTTOM
apply plugin: 'com.google.gms.google-services'
```

## Amazon Device Messaging Settings

### Add the project and app

* Go to the [Amazon Developer Console](https://developer.amazon.com/settings/console/home).
* Go to **My Apps** in **Apps & Services** at the top.
* In **Add New App**, select **Android** and enter the app information to register the app.
* Enter **Android Package Name**, **App Nickname (optional)** and click the **Register App** button.

### Add the API key

* Select the registered app in **My Apps** and click **App Service** in the left menu.
* Create and register **Security Profile** in Device Messaging.
* Go to **View Security Profile** and generate API Key from the **Android/Kindle Settings** menu.
* Copy the generated API Key and save it as **api_key.txt** file in the **assets** folder of your project.
* For details, refer to [Amazon Device Messaging - Obtain Credentials](https://developer.amazon.com/docs/adm/obtain-credentials.html).

### Download the ADM SDK

* Download the ADM SDK from [Amazon Device Messaging (ADM) SDKs](https://developer.amazon.com/docs/apps-and-games/sdk-downloads.html#adm) of the Amazon Developer site.
* Save the downloaded **amazon-device-messaging-1.2.0.jar** file to the **amazon/libs** folder of your project.

#### App module's build.gradle
```groovy
dependencies {
    //...
    compileOnly files('amazon/libs/amazon-device-messaging-1.2.0.jar')
}
```

### Proguard settings

* If you're using Proguard, add the following to the <b>[proguard-rules.pro](http://proguard-rules.pro)</b> file.

```groovy
-libraryjars amazon/libs/amazon-device-messaging-1.2.0.jar
-dontwarn com.amazon.device.messaging.**
-keep class com.amazon.device.messaging.** { *; }
-keep public class * extends com.amazon.device.messaging.ADMMessageReceiver
-keep public class * extends com.amazon.device.messaging.ADMMessageHandlerBase
-keep public class * extends com.amazon.device.messaging.ADMMessageHandlerJobBase
```

## Push Initialization

* Initialize NHN Cloud Push by calling NhnCloudPush.initialize.
* A [NhnCloudPushConfiguration](./push-android/#nhncloudpushconfiguration) object contains push configuration information.
* A [NhnCloudPushConfiguration](./push-android/#nhncloudpushconfiguration) object can be created using NhnCloudPushConfiguration.Builder.
* Pass the AppKey issued from the Push console as the parameter of NhnCloudPushConfiguration.newBuilder.
* The PushType you want to use must be passed in the initialization call.

### FCM initialization example

```java
NhnCloudPushConfiguration configuration =
    NhnCloudPushConfiguration.newBuilder(context, "YOUR_APP_KEY")
            .build();

NhnCloudPush.initialize(PushType.FCM, configuration);
```

### ADM initialization example

```java
NhnCloudPushConfiguration configuration =
    NhnCloudPushConfiguration.newBuilder(context, "YOUR_APP_KEY")
            .build();

NhnCloudPush.initialize(PushType.ADM, configuration);
```

> NhnCloudPush.initialize(NhnCloudPushConfiguration) has been deprecated.
> PushType is automatically set to FCM when initialized using NhnCloudPush.initialize(NhnCloudPushConfiguration).

## Service Login
* All products provided by NHN Cloud SDK (Push, IAP, Log & Crash, etc.) use the same user ID.
    * You can set the user id with [NhnCloudSdk.setUserId](./getting-started-android/#userid).
* It is recommended to implement the user ID setting and token registration functions in the service login step.
* If you set or change the user ID after registering the token, the token information is updated.

### Service login example

```java
public void onLogin(String userId) {
    // Login.
    NhnCloudSdk.setUserId(userId);
    // Token registration, etc.
}
```

## Token Registration
* Use the NhnCloudPush.registerToken() method to send a Push token to the NHN Cloud Push server. In this case, pass whether the user agreed to receive (NhnCloudPushAgreement) as a parameter.
* If a user ID is not set at the time of initial token registration, it is registered using the device identifier.
* When the token is registered successfully, the user can receive a Push message.

### Consent Setting
* In accordance with the provisions of the Information and Communications Network Act (Articles 50 through 50-8), when registering a token, whether or not to receive notification/advertising/night-time advertising push messages must also be inputted. When sending a message, it is automatically filtered based on whether or not the user agreed to receive it.
    * [Shortcut to KISA Guide](https://www.kisa.or.kr/2060301/form?postSeq=19)
    * [Shortcut to the law](http://www.law.go.kr/법령/정보통신망이용촉진및정보보호등에관한법률/%2820130218,11322,20120217%29/제50조)
* Set whether or not the user agreed to receive the push in NhnCloudPushAgreementIt and send it to the NHN Cloud Push server when registering tokens.

### Example of token registration and agreement setting
```java
// Create a receiving agreement setting object
NhnCloudPushAgreement agreement = NhnCloudPushAgreement.newBuilder(true)  // Agree to receive notification messages
        .setAllowAdvertisements(true)       // Agree to receive advertising notification messages
        .setAllowNightAdvertisements(true)  // Agree to receive nigh-time advertising notification messages
        .build();

// Register a token and set receiving agreement
NhnCloudPush.registerToken(context, agreement, new RegisterTokenCallback() {
    @Override
    public void onRegister(@NonNull PushResult result,
                           @Nullable String token) {

        if (result.isSuccess()) {
            // Token registration succeeded
        } else {
            // Token registration failed
            int code = result.getCode();
            String message = result.getMessage();
        }
    }
});
```

## Token Information Query
* Query the token information registered in the NHN Cloud Push server.

### Token information query example
```java
NhnCloudPush.queryTokenInfo(context, new QueryTokenInfoCallback() {
    @Override
    public void onQuery(@NonNull PushResult result,
                        @Nullable TokenInfo tokenInfo) {

        if (result.isSuccess()) {
            // Token information query succeeded
            String token = tokenInfo.getToken();
            NhnCloudPushAgreement agreement = tokenInfo.getAgreement();
        } else {
            // Token information query failed
            int code = result.getCode();
            String message = result.getMessage();
        }
    }
});
```

## Token Unregistration
* Unregister the token registered in the NHN Cloud Push server. Unregistered tokens are excluded from targets for sending messages.
* `If you do not want to receive messages after the service logout, you must unregister the token.`
* `Even if the token is unregistered, the notification permission on the device is not revoked.`

> Unregistering a token that has already been unregistered returns success with the message "Already a token has been unregistered".

### Token unregistration example
```java
NhnCloudPush.unregisterToken(mContext, new UnregisterTokenCallback() {
    @Override
    public void onUnregister(@NonNull PushResult result,
                             @Nullable String unregisteredToken) {

        if (result.isSuccess()) {
            // Token unregistration succeeded
        } else {
            // Token unregistration failed
            int code = result.getCode();
            String message = result.getMessage();
        }
    }
});
```

## Message Reception
* You can be notified via OnReceiveMessageListener when a push message is received.
* A listener for push message reception can be registered using the NhnCloudPush.setOnReceiveMessageListener function.
* You can check message information through the [NhnCloudPushMessage](./push-android/#nhncloudpushmessage) object passed to OnReceiveMessageListener .
* To be notified of message reception even when the app is not running, you need to register the listener in `Application#onCreate`.

> When receiving a message, a notification is not exposed if the user is using the app (Foreground).
> Foreground status can be checked by isForeground passed to OnReceiveMessageListener#onReceive.

### Example of registering a message reception listener
``` java
public class MyApplication extends Application {
    @Override
    public void onCreate() {
        // ...

        NhnCloudPush.setOnReceiveMessageListener(new OnReceiveMessageListener() {
            @Override
            public void onReceive(@NonNull NhnCloudPushMessage message,
                                  boolean isForeground) {

                // Expose a notification even when the user is using the app
                if (isForeground) {
                    NhnCloudNotification.notify(getApplicationContext(), message);
                }
            }
        });

        // ...
    }
}
```

## Notification Permission

* To display notifications in Android 13 (API level 33) or higher, POST\_NOTIFICATIONS permission is required.
* In NHN Cloud SDK (version 1.2.0 or higher), POST\_NOTIFICATIONS permission is included in the manifest by default.
* To display notifications for an app, runtime permission must be requested, and notifications cannot be displayed for the app until the user assigns the permission.

### Notification Permission of Apps Targeting Android 13(API level 33) or higher

* When targeting Android 13 (API level 33) or higher, notification runtime permission can be requested by using the requestPostNotificationsPermission API.

``` java
if (Build.VERSION.SDK_INT >= 33) {
    NhnCloudNotification.requestPostNotificationsPermission(this, PERMISSION_REQUEST_CODE);
}
```

### Notification Permission of Apps Targeting Android 12 (API level 32) or lower

* When targeting Android 12 (API level 32) or lower and the notification channel is created for the first time in the app in the foreground, Android automatically requests permisssion from the user.
* If you create the notification channel for the first time while the app is running in the background, you won't get a notification until you open the app and the app does not request notification permission from the user.
This means that notifications are not displayed until the user opens the app and accepts the permission.
* When targeting Android 12 (API level 32) or lower, the apps must create the notification channel and request permission from the user when running for the first time.

``` java
if (Build.VERSION.SDK_INT <= 32) {
    NotificationChannel channel = NhnCloudNotification.getNotificationChannel(this);
    if (channel == null) {
        NhnCloudNotification.createNotificationChannel(this);
    }
}
```

## Notification Click
* You can be notified via OnClickListener when the app is launched after the user clicks on the exposed notification.
* A listener for notification click can be registered using the NhnCloudNotification.setOnClickListener function.
* To receive notification click notifications even when the app is not running, you need to register the listener in `Application#onCreate`.

### Example of notification click listener registration
```java
public class MyApplication extends Application {
    @Override
    public void onCreate() {
        // ...

        NhnCloudNotification.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(@NonNull NhnCloudPushMessage message) {
                // Service logic such as page move can be performed based on the message content.
                Map<String, String> extras = message.getExtras();
            }
        });

        // ...
    }
}
```

## Notification Settings

### Default Notification Channel Name Setting
* The notification channel name is the name of the channel exposed in the notification settings in devices running on Android 8.0 (API level 26) or higher.
* If you do not set a separate channel for notifications, notifications are requested through the default notification channel.
* A new default notification channel is created to be applied when setting notification default options.
* It can be registered in `Application#onCreate` or defined as metadata in the AndroidManifest.xml file.

> If you do not set the default notification channel name, it is automatically set as the name of the application.

#### Example of setting the default notification channel name
##### Example of setting in code
```java
public class MyApplication extends Application {
    @Override
    public void onCreate() {
        // ...

        NhnCloudNotification.setDefaultChannelName(context, "YOUR_CHANNEL_NAME");

        // ...
    }
}
```

##### Example of defining as the AndroidManifest.xml metadata
```xml
<!-- Set the default channel name -->
<meta-data android:name="com.toast.sdk.push.notification.default_channel_name"
           android:value="@string/default_notification_channel_name"/>
```

### Notification Preferences Setting
* Set the priority of notifications, small icon, background color, LED light, vibration, and sound.
* Set whether to display notifications when the app is in the foreground state.
* Set whether to use the badge icon.
* In devices running on Android 8.0 (API level 26) or higher, the option is applied only to the default notification channel.
* It can be registered in `Application#onCreate` or defined as metadata in the AndroidManifest.xml file.

#### Example of setting notification default options
##### Example of setting in code
**If you change all notification options**
```java
public class MyApplication extends Application {
    @Override
    public void onCreate() {
        // ...

        NhnCloudNotificationOptions defaultOptions = new NhnCloudNotificationOptions.Builder()
                .setPriority(NotificationCompat.PRIORITY_HIGH)  // Set notification priority
                .setColor(0x0085AA)                             // Set notification background color
                .setLights(Color.RED, 0, 300)                   // Set LED light
                .setSmallIcon(R.drawable.ic_notification)       // Set small icon
                .setSound(context, R.raw.dingdong1)             // Set notification sound
                .setVibratePattern(new long[] {500, 700, 1000}) // Set vibration pattern
                .enableForeground(true)                         // Set foreground notification exposure
                .enableBadge(true)                              // Set badge icon use
                .build();

        NhnCloudNotification.setDefaultOptions(context, defaultOptions);

        // ...
    }
}
```

**If you change only some of the configured notification options**
```java
public class MyApplication extends Application {
    @Override
    public void onCreate() {
        // ...

        // Get the configured default notification options
        NhnCloudNotificationOptions defaultOptions = NhnCloudNotification.getDefaultOptions(context);

        // Create a builder from the notification options object
        NhnCloudNotificationOptions newDefaultOptions = defaultOptions.buildUpon()
                .enableForeground(true)      // Change only the foreground notification exposure status
                .build();

        NhnCloudNotification.setDefaultOptions(context, newDefaultOptions);

        // ...
    }
}
```

##### Example of defining as the AndroidManifest.xml metadata
```xml
<!-- Notification priority -->
<meta-data android:name="com.toast.sdk.push.notification.default_priority"
           android:value="1"/>
<!-- Notification background color -->
<meta-data android:name="com.toast.sdk.push.notification.default_background_color"
           android:resource="@color/defaultNotificationColor"/>
<!-- LED light -->
<meta-data android:name="com.toast.sdk.push.notification.default_light_color"
           android:value="#0000ff"/>
<meta-data android:name="com.toast.sdk.push.notification.default_light_on_ms"
           android:value="0"/>
<meta-data android:name="com.toast.sdk.push.notification.default_light_off_ms"
           android:value="500"/>
<!-- Small icon -->
<meta-data android:name="com.toast.sdk.push.notification.default_small_icon"
           android:resource="@drawable/ic_notification"/>
<!-- Notification sound -->
<meta-data android:name="com.toast.sdk.push.notification.default_sound"
           android:value="notification_sound"/>
<!-- Vibration pattern -->
<meta-data android:name="com.toast.sdk.push.notification.default_vibrate_pattern"
           android:resource="@array/default_vibrate_pattern"/>
<!-- Badge icon use -->
<meta-data android:name="com.toast.sdk.push.notification.badge_enabled"
           android:value="true"/>
<!-- Notification exposure while the app is running -->
<meta-data android:name="com.toast.sdk.push.notification.foreground_enabled"
           android:value="false"/>
```

### Notification Sound Setting
* If you add a sound field when sending a push message, you can set a local resource (mp3, wav) as a notification sound. (Only works in versions below Android 8.0)
* For notification sound, only the local resources in the raw folder under the application resource folder can be used.
    * Example: main/res/raw/notification_sound.wav

## Rich Message

* Rich messages represent an image in the notification, along with the notification's subject and body, and add actions such as buttons and replies.

### Supported Rich Messages

#### Button
| Type | Feature | Action |
| --- | ------- | --- |
| Open App (OPEN_APP) | Run the application | PushAction.ActionType.OPEN_APP |
| Open URL (OPEN_URL) | Go to URL <br/> (run Web URL address or app's custom scheme) | PushAction.ActionType.OPEN_URL |
| Reply (REPLY) | Send a reply from notification | PushAction.ActionType.REPLY |
| Cancel (DISMISS) | Cancel current notification | PushAction.ActionType.DISMISS |

* The REPLY button is available in Android 7.0 (API level 24) or higher.

> Up to 3 buttons per message are supported.

#### Media
* You can specify a file by resource ID in the app, Android Assets file path, or URL.
* Media other than images, such as video and sound, is not supported.
* For image, an image with an aspect ratio of 2:1 is recommended.
    * Small : 512 x 256
    * Medium : 1024 x 512
    * Large : 2048 x 1024

> It takes time to download media files when using a web URL.

#### Large Icon
* You can specify a file by resource ID in the app, Android Assets file path, or URL.
* For images of large icons, a 1:1 ratio is recommended.

> If the image used is not 1:1 ratio, the image may be displayed differently from what you expect because it is forcibly changed to 1:1.

#### Group
* Notifications with the same group key are grouped and displayed.
* This feature is available in Android 7.0 (API level 24) or higher.

### Register notification action listener
* Notifies the notification action listener when the user clicks the button in the notification or the send reply button.
* You can check the action information with the [PushAction](./push-android/#pushaction) object.
* To be notified of receiving messages even when the app is not running, you must register in `Application#onCreate`.

#### Example of notification action listener registration

``` java
public class MyApplication extends Application {
    @Override
    public void onCreate() {
        // ...

        NhnCloudNotification.setOnActionListener(new OnActionListener() {
            @Override
            public void onAction(@NonNull PushAction action) {
                // In case of Reply action, send the content to a service server
                if (action.getActionType() == PushAction.ActionType.REPLY) {
                    // Get the reply content that the user entered
                    String userText = action.getUserText();
                    // Send the user input content to a service server
                }
            }
        });

        // ...
    }
}
```

## User-defined Message Handling
* If you need to perform a separate processing after receiving a message or expose a notification by modifying the content of the received message, you must implement a broadcast that inherits and implements [NhnCloudPushMessageReceiver](./push-android/#nhncloudpushmessagereceiver).
* The broadcast that inherits and implements NhnCloudPushMessageReceiver must also be registered in AndroidManifest.xml.
* When a message is received, the received message is sent to the onMessageReceived function.

> **(Caution)**
> 1. If the onMessageReceived function does not request (notify) the notification after receiving the message, the notification is not exposed.
> 2. If you create a notification manually, you must set the Push service intent as the notification's content intent in order to collect metrics. (See the Adding the Metric Collection Feature section below)

### Example of NhnCloudPushMessagingService implementation code
```java
public class MyPushMessageReceiver extends NhnCloudPushMessageReceiver {
    @Override
    public void onMessageReceived(@NonNull Context context,
                                  @NonNull NhnCloudRemoteMessage remoteMessage) {

        // Change channel ID
        remoteMessage.setChannelId("channel");

        // Modify message content
        NhnCloudPushMessage message = remoteMessage.getMessage();
        CharSequence title = message.getTitle();

        message.setTitle("[Modified] " + title);

        // Set the execution intent (If not set, package's default main activity is executed)
        Intent launchIntent = new Intent(context, MainActivity.class);

        PendingIntent contentIntent = PendingIntent.getActivity(
                context,
                REQUEST_CODE,
                launchIntent,
                PendingIntent.FLAG_UPDATE_CURRENT);

        // If you want to expose the notification based on whether the user is using the app or not
        if (!isAppForeground()) {
            // Create and expose the notification
            notify(context, remoteMessage, contentIntent);

        } else {
            // Expose a specific UI screen
            NhnCloud.makeText(context, message.title, NhnCloud.LENGTH_SHORT).show();
        }
    }
}
```

### Example of registering in AndroidManifest.xml
> **(Caution)**
> 1. When using NhnCloudPushMessageReceiver, you must set permission.
> 2. When targeting API level 31 or higher, you must set the 'exported' attribute.

```xml
<manifest>
    <application>
    <receiver android:name=".NhnCloudPushSampleReceiver"
        android:permission="${applicationId}.toast.push.permission.RECEIVE"
        android:exported="false">
        <intent-filter>
            <action android:name="com.toast.android.push.MESSAGE_EVENT" />
            </intent-filter>
    </receiver>

        <!-- Omitted -->
    </application>

    <!-- Omitted -->
</manifest>
```

### Adding the Metric Collection Feature (FCM Only)
* If you create a notification manually, to use the metric collection feature, you must set the intent you created using the getContentIntent() function as the notification's content intent.

#### Example of adding the metrics collection feature
```java
public class MyPushMessageReceiver extends NhnCloudPushMessageReceiver {
    private NotificationManager mManager = null;

    @Override
    public void onMessageReceived(
            @NonNull Context context,
            @NonNull NhnCloudRemoteMessage remoteMessage) {

        // Obtain the message content
        NhnCloudPushMessage message = remoteMessage.getMessage();

        // Create NotificationManager
        if (mManager == null) {
            mManager = (NotificationManager) context.getSystemService(Context.NOTIFICATION_SERVICE);
            if  (mManager == null) {
                Log.e(TAG, "Failed to get NotificationManager");
                return;
            }
        }

        // Set the channel
        String channelId = "YOUR_CHANNEL_ID";
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            NotificationChannel channel = mManager.getNotificationChannel(channelId);
            if (channel == null) {
                String channelName = "YOUR_CHANNEL_NAME";
                createNotificationChannel(channelId, channelName);
            }
        }

        // Set the launch intent
        Intent launchIntent = new Intent(context, MainActivity.class);

        // Create a content intent that includes sending metrics
        PendingIntent contentIntent;
        contentIntent = getContentIntent(context, remoteMessage, launchIntent);

        // Create a notification
        NotificationCompat.Builder builder = new NotificationCompat.Builder(context, channelId);
        builder.setContentTitle(message.getTitle())
                .setContentText(message.getBody())
                .setSmallIcon(R.drawable.ic_notification)
                .setContentIntent(contentIntent)
                .setAutoCancel(true);
     
        notify(context, NotificationUtils.createNewId(), builder.build());
    }
    ...
}
```

## Using Emoji
> **(Caution)**
> If an emoji that is not supported by the device is used, it may not be displayed.

## User Tag

* The [User Tag](https://nhncloud.com/en/Notification/Push/en/console-guide/#tags) feature binds multiple user IDs in one tag and uses it to send messages.
* It operates based on the tag ID (8-character string) rather than the tag name, and the tag ID can be created and checked in the Console > Tag menu.

### Modify User Tags

#### Example of modifying user tags

* Adds or updates the inputted tag ID list and returns the resulting tag ID list.

```java
// Create a tag ID list to add
Set<String> tagIds = new HashSet<>();
tagIds.add(TAG_ID_1);   // e.g. "ZZPP00b6" (8-character string)
tagIds.add(TAG_ID_2);

// Add the tag ID list of the logged-in user ID
NhnCloudPush.addUserTag(tagIds, new UserTagCallback() {
    @Override
    public void onResult(@NonNull PushResult result, @Nullable Set<String> tagIds) {
        if (result.isSuccess()) {
            // Adding the user tag ID succeeded
        } else {
            // Adding the user tag ID failed
            int errorCode = result.getCode();
            String errorMessage = result.getMessage();
        }
    }
});

// Update the tag ID list of the logged-in user ID (Existing tag ID list is deleted and set to the inputted value)
NhnCloudPush.setUserTag(tagIds, new UserTagCallback() {
    @Override
    public void onResult(@NonNull PushResult result, @Nullable Set<String> tagIds) {
        if (result.isSuccess()) {
            // Updating the user tag ID list succeeded
        } else {
            // Updating the user tag ID list failed
            int errorCode = result.getCode();
            String errorMessage = result.getMessage();
        }
    }
});
```

### Retrieve User Tags

* Returns a list of all tag IDs registered to the current user.

#### Example of retrieving user tags

```java
// Return the whole tag ID list of the logged-in user ID
NhnCloudPush.getUserTag(new UserTagCallback() {
    @Override
    public void onResult(@NonNull PushResult result, @Nullable Set<String> tagIds) {
        if (result.isSuccess()) {
            // Retrieving the user tag ID list succeeded
        } else {
            // Retrieving the user tag ID list failed
            int errorCode = result.getCode();
            String errorMessage = result.getMessage();
        }
    }
});
```

### Delete user tag

#### Example of deleting user tags

* Deletes the inputted user tag ID list and returns the resulting tag ID list.

```java
// Create a tag ID list to delete
Set<String> tagIds = new HashSet<>();
tagIds.add(TAG_ID_1);   // e.g. "ZZPP00b6" (8-character string)
tagIds.add(TAG_ID_2);

// Delete the tag ID list of the logged-in user ID
NhnCloudPush.removeUserTag(tagIds, new UserTagCallback() {
    @Override
    public void onResult(@NonNull PushResult result, @Nullable Set<String> tagIds) {
        if (result.isSuccess()) {
            // Deleting the user tag ID list succeeded
        } else {
            // Deleting the user tag ID list failed
            int errorCode = result.getCode();
            String errorMessage = result.getMessage();
        }
    }
});

// Delete the whole tag ID list of the logged-in user ID
NhnCloudPush.removeAllUserTag(new UserTagCallback() {
    @Override
    public void onResult(@NonNull PushResult result, @Nullable Set<String> tagIds) {
        if (result.isSuccess()) {
            // Deleting the whole user tag succeeded
        } else {
            // Deleting the whole user tag failed
            int errorCode = result.getCode();
            String errorMessage = result.getMessage();
        }
    }
});
```

## NHN Cloud Push Class Reference
### NhnCloudPushConfiguration
* Push configuration that is passed when NHN Cloud Push is initialized.

```java
/* NhnCloudPushConfiguration.java */
public String getAppKey();
public static Builder newBuilder(@NonNull Context context, @NonNull String appKey);
```

| Method | Returns | |
|---|---|---|
| getAppKey | String | Returns the Push service Appkey. |
| static newBuilder | NhnCloudPushConfiguration.Builder | Creates a builder to create a NhnCloudPushConfiguration object. |

### PushResult
* A result object returned in response to the callback when calling an asynchronous API.


```java
/* PushResult.java */
public int getCode();
public String getMessage();
public boolean isSuccess();
public boolean isFailure();
```

| Method | Returns | |
|---|---|---|
| getCode | int | Returns the result code. |
| getMessage | int | Returns the result message. |
| isSuccess | boolean | Returns whether or not it succeeded. |
| isFailure | boolean | Returns whether or not it failed. |

### TokenInfo
* Token information object returned when requesting a token information query.

```java
/* TokenInfo.java */
public String getPushType();
public NhnCloudPushAgreement getAgreement();
public String getTimeZone();
public String getCountry();
public String getLanguage();
public String getUserId();
public Date getActivatedDateTime();
public String getToken();
```

| Method | Returns | |
|---|---|---|
| getPushType | String | Returns a Push type. |
| getAgreement | NhnCloudPushAgreement | Returns whether to agree to notifications/advertising/night-time advertising, etc. |
| getTimeZone | String | Returns the timezone. |
| getCountry | String | Returns the country code. |
| getLanguage | String | Returns the language code. |
| getUserId | String | Returns the user ID. |
| getActivatedDateTime | Date | Returns the date and time of the token's most recent registration. |
| getToken | String | Returns a token. |

### NhnCloudRemoteMessage
* An object returned when receiving a message from a message reception listener or a custom receiver.

``` java
/* NhnCloudRemoteMessage.java */
public String getChannelId();
public void setChannelId(String channelId);
public NhnCloudPushMessage getMessage();
public String getSenderId();
```

| Method | Returns | |
|---|---|---|
| getChannelId | String | Returns the channel ID. |
| setChannelId |  | Sets the channel ID. |
| getMessage | NhnCloudPushMessage | Returns a message object. |
| getSenderId | String | Returns the sender ID. (FCM Only) |

### NhnCloudPushMessage
* An object containing the contents of the received message.

``` java
/* NhnCloudPushMessage.java */
public String getMessageId();
public String getPusyType();
public String getTitle();
public void setTitle(String title);
public String getBody();
public void setBody(String body);
public RichMessage getRichMessage();
public Map<String, String> getExtras();
```

| Method | Returns | |
|---|---|---|
| getMessageId | String | Returns the message identifier. |
| getPusyType | String | Returns the PushType. |
| getTitle | String | Returns the message title. |
| setTitle |  | Sets the message title. |
| getBody | String | Returns the message content. |
| setBody |  | Sets the message content. |
| getRichMessage | RichMessage | Returns rich message information. |
| getExtras |  | Returns all received messages. |


### PushAction
* An object returned when notification action is received.

``` java
/* PushAction.java */
public ActionType getActionType();
public String getNotificationId();
public String getNotificationChannel();
public NhnCloudPushMessage getMessage();
public String getUserText();
```

| Method | Returns | |
|---|---|---|
| getActionType | ActionType | Returns the ActionType. |
| getNotificationId | String | Returns the ID of the notification where the action was executed. |
| getNotificationChannel | String | Returns the channel of the notification where the action was executed. |
| getMessage | NhnCloudPushMessage | Returns the message information of the notification where the action was executed. |
| getUserText | RichMessage | Returns the string entered by the user. |

### NhnCloudPushMessageReceiver
* An object that the user must implement for features such as modifying message content, defining execution intent, and generating notifications manually.

``` java
/* NhnCloudPushMessageReceiver.java */
public final boolean isAppForeground();
public final void notify(Context context, NhnCloudRemoteMessage message);
public final void notify(Context context, NhnCloudRemoteMessage message, PendingIntent contentIntent);
public final void notify(Context context, int notificationId, Notification notification);
@Deprecated
public final PendingIntent getNotificationServiceIntent(Context context, NhnCloudRemoteMessage message, PendingIntent contentIntent);
public final PendingIntent getContentIntent(Context context, NhnCloudRemoteMessage message, Intent launchIntent);
```

| Method | Returns | Parameters | |
|---|---|---|---|
| isAppForeground | boolean |  | Returns whether the app is currently in use. |
| notify | | Context, NhnCloudRemoteMessage | Creates and exposes notifications with the default execution intents. |
| notify | | Context, NhnCloudRemoteMessage, PendingIntent | Creates and exposes notifications with a user execution intent. |
| notify | | Context, int, Notification | Exposes user notifications with a specific ID. |
| @Deprecated <br>getNotificationServiceIntent | PendingIntent | Context, NhnCloudRemoteMessage, PendingIntent | Returns a user launch intent that includes sending metrics. <br> It does not work normally from Android 12 (API level 31) or higher, so you must use getContentIntent() instead. |
| getContentIntent | PendingIntent | Context, NhnCloudRemoteMessage, Intent | Returns a user launch intent that includes sending metrics. |

### NhnCloudNotificationOptions
* An object that sets priority, small icon, background color, LED, vibration, notification sound, and foreground notification exposure information when setting the default notification options.

``` java
/* NhnCloudNotificationOptions.java */
public int getPriority();
public int getSmallIcon();
public int getColor();
public int getLightColor();
public int getLightOnMs();
public int getLightOffMs();
public long[] getVibratePattern();
public Uri getSound();
public boolean isForegroundEnabled();
public boolean isBadgeEnabled();
public Builder buildUpon();
```

| Method | Returns | Parameters | |
|---|---|---|---|
| getPriority | int |  | Returns the priority. |
| getSmallIcon | int | | Returns the resource identifier for the small icon. |
| getColor | int | | Returns the background color. |
| getLightColor | int | | Returns the LED color. |
| getLightOnMs | int | | Returns the time when the LED light is turned on. |
| getLightOffMs | int | | Returns the time when the LED light is turned off. |
| getVibratePattern | long[] | | Returns the pattern of vibrations. |
| getSound | Uri | | Returns the URI of the notification sound. |
| isForegroundEnabled | boolean | | Returns whether or not to use foreground notifications. |
| isBadgeEnabled | boolean | | Returns whether or not to use the badge icon. |
| buildUpon | NhnCloudNotificationOptions#Builder | | Returns a builder based on the current option information. |
