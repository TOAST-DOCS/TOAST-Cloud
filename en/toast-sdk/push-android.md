## TOAST > TOAST SDK User Guide > TOAST Push > Android

## Prerequisites

1. Install [TOAST SDK](./getting-started-android).
2. [Enable Push service](https://docs.toast.com/en/Notification/Push/en/console-guide/) in [TOAST console](https://console.cloud.toast.com).
3. Check the AppKey in the Push console.

## Guide by Push Provider

* [Firebase Cloud Messaging (FCM) Guide](https://firebase.google.com/docs/cloud-messaging/)
* `Tencent Push Notification (QQ) service ended in November 2020`

## Library Setting

### FCM
* To use TOAST FCM Push, add dependency to build.gradle as below.

```groovy
repositories {
    google()
    mavenCentral()
}

dependencies {
    implementation 'com.toast.android:toast-push-fcm:0.27.4'
    ...
}
```

## Firebase Cloud Messaging Settings

### Add projects and apps

* Create a project in [Firebase console](https://console.firebase.google.com/?hl=en).
* Go to **Project Settings** by clicking the gear button at the top of the console.
* Under **My Apps** in Project Settings, click **Add Firebase to Android App**.
* Enter **Android Package Name**, **App Nickname (optional)** and click the **Register App** button.
* Click the **Download google-services.json** button to download the setting information.
* Move the downloaded **google-services.json** file to your app's module (app level) directory.
* For details, see [Add Firebase to your Android project](https://firebase.google.com/docs/android/setup).

### Set Up build.gradle
#### Root-level build.gradle
* Add code below to root-level build.gradle.

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
* Add the code below to your app module's build.gradle.

```groovy
apply plugin: 'com.android.application'

android {
  // ...
}

// ADD THIS AT THE BOTTOM
apply plugin: 'com.google.gms.google-services'
```

## Push Initialization

* Initialize TOAST Push by calling ToastPush.initialize.
* A [ToastPushConfiguration](./push-android/#toastpushconfiguration) object contains push configuration information.
* A [ToastPushConfiguration](./push-android/#toastpushconfiguration) object can be created using ToastPushConfiguration.Builder.
* Pass the AppKey issued from the Push console as the parameter of ToastPushConfiguration.newBuilder.
* The PushType you want to use must be passed in the initialization call.

### FCM initialization example

```java
ToastPushConfiguration configuration =
    ToastPushConfiguration.newBuilder(context, "YOUR_APP_KEY")
            .build();

ToastPush.initialize(configuration);
```

## Service Login
* All products provided by TOAST SDK (Push, IAP, Log & Crash, etc.) use the same user ID.
    * You can set the user id with [ToastSdk.setUserId](./getting-started-android/#userid).
* It is recommended to implement the user ID setting and token registration functions in the service login step.
* If you set or change the user ID after registering the token, the token information is updated.

### Service login example

```java
public void onLogin(String userId) {
    // Login.
    ToastSdk.setUserId(userId);
    // Token registration, etc.
}
```

## Token Registration
* Use the ToastPush.registerToken() method to send a Push token to the TOAST Push server. In this case, pass whether the user agreed to receive (ToastPushAgreement) as a parameter.
* If a user ID is not set at the time of initial token registration, it is registered using the device identifier.
* When the token is registered successfully, the user can receive a Push message.

### Consent Setting
* In accordance with the provisions of the Information and Communications Network Act (Articles 50 through 50-8), when registering a token, whether or not to receive notification/advertising/night-time advertising push messages must also be inputted. When sending a message, it is automatically filtered based on whether or not the user agreed to receive it.
    * [Shortcut to KISA Guide](https://spam.kisa.or.kr/spam/sub62.do)
    * [Shortcut to the law](http://www.law.go.kr/법령/정보통신망이용촉진및정보보호등에관한법률/%2820130218,11322,20120217%29/제50조)
* Set whether or not the user agreed to receive the push in ToastPushAgreementIt and send it to the TOAST Push server when registering tokens.

### Example of token registration and agreement setting
```java
// Create a receiving agreement setting object
ToastPushAgreement agreement = ToastPushAgreement.newBuilder(true)  // Agree to receive notification messages
        .setAllowAdvertisements(true)       // Agree to receive advertising notification messages
        .setAllowNightAdvertisements(true)  // Agree to receive nigh-time advertising notification messages
        .build();

// Register a token and set receiving agreement
ToastPush.registerToken(context, agreement, new RegisterTokenCallback() {
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
* Query the token information registered in the TOAST Push server.

### Token information query example
```java
ToastPush.queryTokenInfo(context, new QueryTokenInfoCallback() {
    @Override
    public void onQuery(@NonNull PushResult result,
                        @Nullable TokenInfo tokenInfo) {

        if (result.isSuccess()) {
            // Token information query succeeded
            String token = tokenInfo.getToken();
            ToastPushAgreement agreement = tokenInfo.getAgreement();
        } else {
            // Token information query failed
            int code = result.getCode();
            String message = result.getMessage();
        }
    }
});
```

## Token Unregistration
* Unregister the token registered in the TOAST Push server. Unregistered tokens are excluded from targets for sending messages.
* `If you do not want to receive messages after the service logout, you must unregister the token.`
* `Even if the token is unregistered, the notification permission on the device is not revoked.`

> Unregistering a token that has already been unregistered returns success with the message "Already a token has been unregistered".

### Token unregistration example
```java
ToastPush.unregisterToken(mContext, new UnregisterTokenCallback() {
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
* A listener for push message reception can be registered using the ToastPush.setOnReceiveMessageListener function.
* You can check message information through the [ToastPushMessage](./push-android/#toastpushmessage) object passed to OnReceiveMessageListener .
* To be notified of message reception even when the app is not running, you need to register the listener in `Application#onCreate`.

> When receiving a message, a notification is not exposed if the user is using the app (Foreground).
> Foreground status can be checked by isForeground passed to OnReceiveMessageListener#onReceive.

### Example of registering a message reception listener
``` java
public class MyApplication extends Application {
    @Override
    public void onCreate() {
        // ...

        ToastPush.setOnReceiveMessageListener(new OnReceiveMessageListener() {
            @Override
            public void onReceive(@NonNull ToastPushMessage message,
                                  boolean isForeground) {

                // Expose a notification even when the user is using the app
                if (isForeground) {
                    ToastNotification.notify(getApplicationContext(), message);
                }
            }
        });

        // ...
    }
}
```

## Notification Click
* You can be notified via OnClickListener when the app is launched after the user clicks on the exposed notification.
* A listener for notification click can be registered using the ToastNotification.setOnClickListener function.
* To receive notification click notifications even when the app is not running, you need to register the listener in `Application#onCreate`.

### Example of notification click listener registration
```java
public class MyApplication extends Application {
    @Override
    public void onCreate() {
        // ...

        ToastNotification.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(@NonNull ToastPushMessage message) {
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

        ToastNotification.setDefaultChannelName(context, "YOUR_CHANNEL_NAME");

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

        ToastNotificationOptions defaultOptions = new ToastNotificationOptions.Builder()
                .setPriority(NotificationCompat.PRIORITY_HIGH)  // Set notification priority
                .setColor(0x0085AA)                             // Set notification background color
                .setLights(Color.RED, 0, 300)                   // Set LED light
                .setSmallIcon(R.drawable.ic_notification)       // Set small icon
                .setSound(context, R.raw.dingdong1)             // Set notification sound
                .setVibratePattern(new long[] {500, 700, 1000}) // Set vibration pattern
                .enableForeground(true)                         // Set foreground notification exposure
                .enableBadge(true)                              // Set badge icon use
                .build();

        ToastNotification.setDefaultOptions(context, defaultOptions);

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
        ToastNotificationOptions defaultOptions = ToastNotification.getDefaultOptions(context);

        // Create a builder from the notification options object
        ToastNotificationOptions newDefaultOptions = defaultOptions.buildUpon()
                .enableForeground(true)      // Change only the foreground notification exposure status
                .build();

        ToastNotification.setDefaultOptions(context, newDefaultOptions);

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

        ToastNotification.setOnActionListener(new OnActionListener() {
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
* If you need to perform a separate processing after receiving a message or expose a notification by modifying the content of the received message, you must implement a broadcast that inherits and implements [ToastPushMessageReceiver](./push-android/#toastpushmessagereceiver).
* The broadcast that inherits and implements ToastPushMessageReceiver must also be registered in AndroidManifest.xml.
* When a message is received, the received message is sent to the onMessageReceived function.

> **(Caution)**
> 1. If the onMessageReceived function does not request (notify) the notification after receiving the message, the notification is not exposed.
> 2. If you create a notification manually, you must set the Push service intent as the notification's content intent in order to collect metrics. (See the Adding the Metric Collection Feature section below)

### Example of ToastPushMessagingService implementation code
```java
public class MyPushMessageReceiver extends ToastPushMessageReceiver {
    @Override
    public void onMessageReceived(@NonNull Context context,
                                  @NonNull ToastRemoteMessage remoteMessage) {

        // Change channel ID
        remoteMessage.setChannelId("channel");

        // Modify message content
        ToastPushMessage message = remoteMessage.getMessage();
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
            Toast.makeText(context, message.title, Toast.LENGTH_SHORT).show();
        }
    }
}
```

### Example of registering in AndroidManifest.xml
> **(Caution)**
> When using ToastPushMessageReceiver, you must set permission.

```xml
<manifest>
    <application>
    <receiver android:name=".ToastPushSampleReceiver"
        android:permission="${applicationId}.toast.push.permission.RECEIVE">
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
* If you create a notification manually, you must set the intent you created using the getNotificationServiceIntent() function as the notification's content intent in order to use the metrics collection feature.

#### Example of adding the metrics collection feature
```java
public class MyPushMessageReceiver extends ToastPushMessageReceiver {
    @Override
    public void onMessageReceived(@NonNull Context context,
                                  @NonNull ToastRemoteMessage remoteMessage) {

        ToastPushMessage message = remoteMessage.getMessage();

        // Create a user execution intent
        Intent launchIntent = new Intent(context, MainActivity.class);

        PendingIntent contentIntent = PendingIntent.getActivity(
                context,
                REQUEST_CODE,
                launchIntent,
                PendingIntent.FLAG_UPDATE_CURRENT);

        // Provide an execution intent generation feature including the metrics collection
        PendingIntent serviceIntent = getNotificationServiceIntent(context, remoteMessage, contentIntent);

        NotificationCompat.Builder builder = new NotificationCompat.Builder(context, "YOUR_CHANNE_ID");
        // (Omitted)
        builder.setContentIntent(serviceIntent);

        notify(context, builder.build());
    }
}
```

## Using Emoji
> **(Caution)**
> If an emoji that is not supported by the device is used, it may not be displayed.

## User Tag

* The [User Tag](https://https://docs.toast.com/en/Notification/Push/en/console-guide/#tags) feature binds multiple user IDs in one tag and uses it to send messages.
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
ToastPush.addUserTag(tagIds, new UserTagCallback() {
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
ToastPush.setUserTag(tagIds, new UserTagCallback() {
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
ToastPush.getUserTag(new UserTagCallback() {
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
ToastPush.removeUserTag(tagIds, new UserTagCallback() {
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
ToastPush.removeAllUserTag(new UserTagCallback() {
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

## TOAST Push Class Reference
### ToastPushConfiguration
* Push configuration that is passed when TOAST Push is initialized.

```java
/* ToastPushConfiguration.java */
public String getAppKey();
public static Builder newBuilder(@NonNull Context context, @NonNull String appKey);
```

| Method | Returns | |
|---|---|---|
| getAppKey | String | Returns the Push service Appkey. |
| static newBuilder | ToastPushConfiguration.Builder | Creates a builder to create a ToastPushConfiguration object. |

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
public ToastPushAgreement getAgreement();
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
| getAgreement | ToastPushAgreement | Returns whether to agree to notifications/advertising/night-time advertising, etc. |
| getTimeZone | String | Returns the timezone. |
| getCountry | String | Returns the country code. |
| getLanguage | String | Returns the language code. |
| getUserId | String | Returns the user ID. |
| getActivatedDateTime | Date | Returns the date and time of the token's most recent registration. |
| getToken | String | Returns a token. |

### ToastRemoteMessage
* An object returned when receiving a message from a message reception listener or a custom receiver.

``` java
/* ToastRemoteMessage.java */
public String getChannelId();
public void setChannelId(String channelId);
public ToastPushMessage getMessage();
public String getSenderId();
```

| Method | Returns | |
|---|---|---|
| getChannelId | String | Returns the channel ID. |
| setChannelId |  | Sets the channel ID. |
| getMessage | ToastPushMessage | Returns a message object. |
| getSenderId | String | Returns the sender ID. (FCM Only) |

### ToastPushMessage
* An object containing the contents of the received message.

``` java
/* ToastPushMessage.java */
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
public ToastPushMessage getMessage();
public String getUserText();
```

| Method | Returns | |
|---|---|---|
| getActionType | ActionType | Returns the ActionType. |
| getNotificationId | String | Returns the ID of the notification where the action was executed. |
| getNotificationChannel | String | Returns the channel of the notification where the action was executed. |
| getMessage | ToastPushMessage | Returns the message information of the notification where the action was executed. |
| getUserText | RichMessage | Returns the string entered by the user. |

### ToastPushMessageReceiver
* An object that the user must implement for features such as modifying message content, defining execution intent, and generating notifications manually.

``` java
/* ToastPushMessageReceiver.java */
public final boolean isAppForeground();
public final void notify(Context context, ToastRemoteMessage message);
public final void notify(Context context, ToastRemoteMessage message, PendingIntent contentIntent);
public final void notify(Context context, int notificationId, Notification notification);
public final PendingIntent getNotificationServiceIntent(Context context, ToastRemoteMessage message, PendingIntent contentIntent);
```

| Method | Returns | Parameters | |
|---|---|---|---|
| isAppForeground | boolean |  | Returns whether the app is currently in use. |
| notify | | Context, ToastRemoteMessage | Creates and exposes notifications with the default execution intents. |
| notify | | Context, ToastRemoteMessage, PendingIntent | Creates and exposes notifications with a user execution intent. |
| notify | | Context, int, Notification | Exposes user notifications with a specific ID. |
| getNotificationServiceIntent | PendingIntent | Context, ToastRemoteMessage, PendingIntent | Returns a user execution intent that includes sending metrics. |

### ToastNotificationOptions
* An object that sets priority, small icon, background color, LED, vibration, notification sound, and foreground notification exposure information when setting the default notification options.

``` java
/* ToastNotificationOptions.java */
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
| buildUpon | ToastNotificationOptions#Builder | | Returns a builder based on the current option information. |
