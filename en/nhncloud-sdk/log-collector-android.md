## NHN Cloud > SDK User Guide > Log & Crash > Android

## Prerequisites

1. [Install NHN Cloud SDK](./getting-started-android)
2. [Enable Log & Crash Search](https://nhncloud.com/en/Data%20&%20Analytics/Log%20&%20Crash%20Search/en/console-guide/) in [NHN Cloud console](https://console.nhncloud.com).
3. [Check AppKey](https://nhncloud.com/en/Data%20&%20Analytics/Log%20&%20Crash%20Search/en/console-guide/#appkey) from Log & Crash Search.

## Library Setting
- Add the code as below to build.gradle.

```groovy
repositories {
    mavenCentral()
}

dependencies {
    implementation 'com.nhncloud.android:nhncloud-logger:1.8.1'
    ...
}
```

## Initialize NHN Cloud Logger SDK

- Initialization must be performed in Application#onCreate.

> If you use NhnCloudLogger without initialization, an initialization error occurs.

- Set Appkey issued from Log & Crash Search.

```java
// Initialize Logger
NhnCloudLoggerConfiguration configuration = NhnCloudLoggerConfiguration.newBuilder()
        .setAppKey(YOUR_APP_KEY)            // Log & Crash Search AppKey
        .build();

NhnCloudLogger.initialize(configuration);
```

## Send Logs

NHN Cloud Logger provides log-sending functions of five levels.

### Specification for Log Sending API

```java
// DEBUG level logs
static void debug(String message);

// INFO level logs
static void info(String message);

// WARN level logs
static void warn(String message);

// ERROR level logs
static void error(String message);

// FATAL level logs
static void fatal(String message);
```

### Usage Example of Log Sending API

```java
NhnCloudLogger.warn("NHN Cloud Log & Crash Search!");
```

## Set User-Defined Field

Set a user-defined field as wanted.
With user-defined field setting, set values are sent to server along with logs every time Log Sending API is called.

### Specification for setUserField API

```java
static void setUserField(String field, Object value);
```

*  User-defined field is same as the value exposed as "Selected Field"in "Log & Crash Search Console" > "Log Search Tab".

#### Restrictions for User-Defined Fields

* Cannot use already [Reserved Fields](./log-collector-reserved-fields).
* Use characters from "A-Z, a-z, 0-9, -, and _" for a field name, starting with "A-Z, or a-z".
* Replace spaces within a field name by "_".

### Usage Example of setUserField

```java
NhnCloudLogger.setUserField("nickname", "randy");
```

## Further Tasks after Sending Logs

With listener registered, further tasks can be executed after logs are sent.

### Specification for setLoggerListener API

```java
static void setLoggerListener(NhnCloudLoggerListener listener);
```

### Usage Example of setLoggerListener

```java
NhnCloudLogger.setLoggerListener(new NhnCloudLoggerListener() {
    @Override
    public void onSuccess(LogEntry log) {
        // Sending logs succeeded.
    }

    @Override
    public void onFilter(LogEntry log, LogFilter filter) {
        // Filter by filter setting
    }

    @Override
    public void onSave(LogEntry log) {
        // Save within SDK for re-sending if log-sending fails due to network errors
    }

    @Override
    public void onError(LogEntry log, Exception e) {
        // Sending logs failed.
    }
});
```

## Collect Crash Logs

When an unexpected crash occurs in an app, NHN Cloud Logger records such crash information in the server.

### Set Enable Collecting Crash Logs

Sending crash logs can be enabled or disabled by using setEnabledCrashReporter() .

```java
// Initialize Logger
NhnCloudLoggerConfiguration configuration = NhnCloudLoggerConfiguration.newBuilder()
        .setAppKey(YOUR_APP_KEY)            // Log & Crash Search AppKey
        .setEnabledCrashReporter(true)              // Enable or Disable Crash Reporter
        .build();

NhnCloudLogger.initialize(configuration);
```

> If the User ID is set, you can check the user-specific crash experience in the 'Crash User' section of the Log & Crash Search console.
> User ID setting can be checked in [Getting Started](./getting-started-android/#set-userid).

### Use Handled Exception API

For Android platforms, exceptions from a try/catch sentence can be sent by using Handled Exception API of NHN Cloud Logger.
Such exception logs can be queried by filtering for Handled, from error type of "Log & Crash Search Console" > "App Crash Search Tab".
For more usage details on Log & Cash Console, see [Console User Guide](http://nhncloud.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/).

### Specification for Handled Exception Log API

```java
// Send Exception Information
static void report(@NonNull String message, @NonNull Throwable throwable);

// Send Exception Information along with User Fields
static void report(@NonNull String message,
                   @NonNull Throwable throwable,
                   @Nullable Map<String, Object> userFields);
```

### Usage Example

```java
try {
    // User Codes...
} catch (Exception e) {
    Map<String, Object> userFields = new HashMap<>();
    NhnCloudLogger.report("message", e, userFields);
}
```

## Set Additional Information in Time for Crash Occurrence before Sending

Additional information can be set immediately after crash occurs.
setUserField can be set anytime regardless of crash occurrence, whilesetCrashDataAdapter can be set at an accurate timing when a crash occurs.

### Specification for setCrashDataAdapter API

```java
static void setCrashDataAdapter(CrashDataAdapter adapter);
```

* Key values of the Map data structure returned through the getUserFields function of CrashDataAdapter have the same restriction conditions as the "field" value of setUserField described in the above.

### Usage Example of setCrashDataAdapter

```java
NhnCloudLogger.setCrashDataAdapter(new CrashDataAdapter() {
    @Override
    public Map<String, Object> getUserFields() {
        Map<String, Object> userFields = new HashMap<>();
        userFields.put("UserField", "UserValue");
        return userFields;
    }
});
```

## Network Insights

Network Insights measure delay time and response values by calling URL registered in console. They may be applied to measure delays and response vales of many countries around the world (according to national codes on a device).

> With Network Insights enabled in console, it is requested for one time via URL registered in the console when NHN Cloud Logger is initialized.

### Enable Network Insights

Network Insights can be enabled as follows.

1. Go to [NHN Cloud Console](https://console.nhncloud.com/) and select [Log & Crash Search].
2. Select [Settings].
3. Click the [Setting for Sending Logs] tab.
4. Enable "Network Insights Logs".

### URL Setting

URL can be set as follows.

1. Go to [NHN Cloud Console](https://console.nhncloud.com/) and select [Log & Crash Search].
2. Select [Network Insights].
3. Click the [URL Setting] tab.
4. Enter URL to measure and click [Add].
