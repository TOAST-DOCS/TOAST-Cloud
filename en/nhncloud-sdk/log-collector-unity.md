## NHN Cloud > SDK User Guide > Log & Crash > Unity

## Prerequisites

1. [Install NHN Cloud SDK](./getting-started-unity)
2. [Enable Log & Crash Search](https://docs.nhncloud.com/ko/Data%20&%20Analytics/Log%20&%20Crash%20Search/ko/console-guide/) in [NHN Cloud console](https://console.nhncloud.com).
3. [Check AppKey](https://docs.nhncloud.com/ko/Data%20&%20Analytics/Log%20&%20Crash%20Search/ko/console-guide/#appkey) in Log & Crash Search.
4. [Initialize NHN Cloud SDK](./getting-started-unity#toast-sdk_1).

## Supported Platforms

- iOS
- Android
- Standalone
- WebGL

## For Android

### Gradle Build Settings

- In the Unity Editor, open the Build Settings windows (Player Settings > Publishing Settings > Build).
- Set the Build System drop-down to Gradle
- Use the Custom Gradle Template checkbox under Build System
- Add below to dependencies of mainTemplate.gradle.

```groovy
apply plugin: 'com.android.application'

repositories {
  mavenCentral()
}

dependencies {
    implementation fileTree(dir: 'libs', include: ['*.jar'])
    implementation 'com.nhncloud.android:nhncloud-unity-logger:1.7.0'
**DEPS**}
```

## For iOS

### Player Settings

- Unity's iOS build setting includes some settings that influence logger's log delivery to a server.
- Below briefly shows effects of such settings and describes recommended settings for a logger.

| Menu                             | List                          | Setting                       | Recommended Setting     |
| -------------------------------- | ----------------------------- | -------------------------- | ------------- |
| Edit > Project Settings > Player | Debugging and crash reporting | On .Net UnhandledException | Silent Exit   |
| Edit > Project Settings > Player | Debugging and crash reporting | Enable CrashReport API     | Disabled      |
| Edit > Project Settings > Player | Other Settings                | Script Call Optimization   | Slow and Safe |

##### On .Net UnhandledException

- **Silent Exit** is recommended.
  - If On .Net UnhandledException is set for Crash, app is closed immediately when an exception occurs.
  - With Silent Exit, Unity Exception can be captured.

##### Enable CrashReport API

- **Disabled** is recommended.
  - Shows whether Unity CrashReporter API is enabled or not.
  - When enabled, it may affect logger's crash log collection.

##### Script Call Optimization

- **Slow and Safe** is recommended.
  - To collect Runtime C# Crash logs, Slow and Safe must be enabled.

## NHN Cloud Logger namespace

```csharp
using Toast.Logger;
```

## Initialize NHN Cloud Logger SDK

Set Appkey issued from Log & Crash Search as ProjectKey.

```csharp
var loggerConfiguration = new ToastLoggerConfiguration
{
    ProjectKey = "YOUR_PROJECT_KEY"
};

ToastLogger.Initialize(loggerConfiguration);
```

## Send Logs

NHN Cloud Logger can send logs of five levels.
User fields may be additionally sent.

### Specification for Log Sending API

```csharp
// DEBUG level logs
ToastLogger.Debug(message);
ToastLogger.Debug(message, userFields);

// INFO level logs
ToastLogger.Info(message);
ToastLogger.Info(message, userFields);

// WARN level logs
ToastLogger.Warn(message);
ToastLogger.Warn(message, userFields);

// ERROR level logs
ToastLogger.Error(message);
ToastLogger.Error(message, userFields);

// FATAL level logs
ToastLogger.Fatal(message);
ToastLogger.Fatal(message, userFields);
```

### Usage Example of Log Sending API

```csharp
ToastLogger.Debug("NHN Cloud Log & Crash Search!", new Dictionary<string, string>
{
    { "Scene", "Main" }
});
```

## Set User-Defined Fields

Set a user-defined field as wanted.
With user-defined field setting, set values are sent to server along with logs, every time Log Sending API is called.

### Specification for User-Defined Field Setting API

```csharp
ToastLogger.SetUserField(userField, userValue);
```

- User-defined field is same as the value exposed as "Selected Field" in "Log & Crash Search Console" > "Log Search Tab".
- If a key is changed for many times, the final value shall be applied.

#### Restrictions of User-Defined Fields

- Cannot use already [Reserved Fields](./log-collector-reserved-fields).
- Use characters from "A-Z, a-z, 0-9, -, and \_" for a field name, starting with "A-Z, or a-z".
- Replace spaces within a field name by "\_".

### Usage Example of User-Defined Field Setting API

```csharp
ToastLogger.SetUserField("GameObject", gameObject.name);
```

## Further Tasks after Sending Logs

- With listener registered, further tasks can be executed after logs are sent.

### Specification for SetLoggerListener API

```csharp
public interface IToastLoggerListener
{
    void OnSuccess(LogEntry log);
    void OnFilter(LogEntry log, LogFilter filter);
    void OnSave(LogEntry log);
    void OnError(LogEntry log, string errorMessage);
}

static void SetLoggerListener(IToastLoggerListener listener);
```

### Usage Example of SetLoggerListener

```csharp
public class SampleLoggerListener : IToastLoggerListener
{
    public void OnSuccess(LogEntry log)
    {
        // Sending logs succeeded
    }

    public void OnFilter(LogEntry log, LogFilter filter)
    {
        // Filter by filter setting
    }

    public void OnSave(LogEntry log)
    {
        // Save within SDK for re-sending if log-sending fails due to network errors
    }

    public void OnError(LogEntry log, string errorMessage)
    {
        // Sending logs failed
    }
}

ToastLogger.SetLoggerListener(new SampleLoggerListener());
```

## Collect Crash Logs

NHN Cloud Logger classifies Unity's crashes into two categories.

- Crash on native platform (app terminated)
- Unexpected exception from Unity (no app terminated)

> **Why is the log outputted as LogException also collected as a crash log?**
> This is because some third-party libraries expose exceptions in user code through LogException.
> If you want to filter out the crash log, refer to **Filtering the Crash Log** below.

With ToastLogger initialized, a crash log is automatically sent when it occurs crash under the mobile environment or when it occurs the unexpected exception in Unity.
To disable crash log delivery, set false for EnableCrashReporter property of the ToastLoggerConfiguration object.
For more information on crash logs of each platform, check the links below:

- [Collect Android Crash Logs](./log-collector-android/#collect-crash-logs)
- [Collect iOS Crash Logs](./log-collector-ios/collect-crash-logs)

```csharp
var loggerConfiguration = new ToastLoggerConfiguration
{
    ProjectKey = "YOUR_PROJECT_KEY",
    EnableCrashReporter = false // Disable crash logs
};
```

> If the User ID is set, you can check the user-specific crash experience in the 'Crash User' section of the Log & Crash Search console.
> User ID setting can be checked in [Getting Started](./getting-started-unity/#set-userid).

## Further Tasks after Sending Crash logs

- With crash listener registered, further tasks can be executed after crash logs are sent.

> ** Crash listener only works when it occurs unexpected exception in Unity **
> Crash listener is not supported for crashes on the native platform.

### Specification for SetCrashListener API

```csharp
public delegate void CrashListener(bool isSuccess, LogEntry logEntry);

public static void SetCrashListener(CrashListener listener);
```

### Usage Example of SetCrashListener API

```csharp
ToastLogger.SetCrashListener((isSuccess, log) =>
{
    if (isSuccess)
    {
        Application.Quit();
    }
});
```

## Filtering the Crash Log

- While using Unity, exception logs or crash logs that you do not want to collect may be collected.
- NHN Cloud Logger supports the feature to filter out the crash logs that you do not want to collect.
  - This feature is specific to exceptions of Unity.

### Specification for AddCrashFilter API

```csharp
public delegate bool CrashFilter(CrashLogData logData);

public class CrashLogData
{
    public LogType LogType { get; }

    public string Condition { get; }

    public string StackTrace { get; }
}

public static void AddCrashFilter(CrashFilter filter);
```

- The properties of CrashLogData is the same as the parameters of [Application.LogCallback](https://docs.unity3d.com/ScriptReference/Application.LogCallback.html).

### Usage Example of AddCrashFilter API

```csharp
ToastLogger.AddCrashFilter(crashLogData => crashLogData.Condition.Contains("UnityEngine.Debug.Log"));
```

## Send Handled Exceptions

Exceptions from a try/catch sentence, as well as general/crash logs, can be sent by using Report API of NHN Cloud Logger.
Such exception logs can be queried by filtering for Handled, from error type of "Log & Crash Search Console" > "App Crash Search Tab".
For more usage details on Log & Crash Console, see [Console User Guide](http://docs.nhncloud.com/ko/Analytics/Log%20&%20Crash%20Search/ko/console-guide/).

### Specification for Handled Exception Log API

```csharp
// Send Handled Exception Logs
var logLevel = ToastLogLevel.ERROR;
ToastLogger.Report(logLevel, message, exception);
```

### Usage Example of Handled Exception Log API

```csharp
try
{
    doSomethingWrong();
}catch(Exception e)
{
    // Debug, Info, Warn, Error, and Fatal are available.
    ToastLogger.Report(ToastLogLevel.ERROR, "YOUR_MESSAGE", exception);
}
```

## Network Insights

Network Insights measure delay time and response values by calling URL registered in console. They may be applied to measure delays and response values of many countries around the world (according to national codes on a device).

> With Network Insights enabled in console, it is requested for one time via URL registered in the console when NHN Cloud Logger is initialized.

### Enable Network Insights

1. Go to [NHN Cloud Console](https://console.nhncloud.com/) and select [Log & Crash Search].
2. Select [Settings].
3. Click the [Setting for Sending Logs] tab.
4. Enable "Network Insights Logs".

### URL Setting

1. Go to [NHN Cloud Console](https://console.nhncloud.com/) and select [Log & Crash Search].
2. Select [Network Insights].
3. Click the [URL Setting] tab.
4. Enter URL to measure and click [Add].
