## NHN Cloud > SDK User Guide > Getting Started > Unity

<a id="supported-environment"></a>

## Supported Environment

* Unity 5.5.0 or higher
* Android 4.0.3 or higher
* iOS 8.0 or higher
* The latest version of XCode (version 9 or higher)

<a id="nhn-cloud-sdk-components"></a>

## NHN Cloud SDK Components

NHN Cloud SDK for Unity consists of the following:

* [Logger](./log-collector-unity) SDK
* [IAP](./iap-unity) SDK

You can selectively apply the required feature among the services provided by NHN Cloud SDK.

| Unity package | Service |
| --- | --- |
| TOAST-Logger-UnityPlugin.unitypackage | Log & Crash |
| TOAST-IAP-UnityPlugin.unitypackage | IAP |
| TOAST-Sample-UnityPlugin.unitypackage | Sample |

<a id="structure-of-unity-package"></a>

### Structure of Unity Package

NHN Cloud SDK for Unity is organized in the following folder structure:

| Directory | Description | Unity package |
|---|---|---|
| Toast | Root folder of NHN Cloud SDK | All |
| Toast/Common | Common module folder of SDK | All |
| Toast/Logger | Module folder of Logger | Logger, Sample |
| Toast/IAP | Module folder of IAP | IAP, Sample |
| Toast/Sample | SDK sample folder | Sample |

<a id="apply-nhn-cloud-sdk-to-unity-projects"></a>

## Apply NHN Cloud SDK to Unity Projects

Download NHN Cloud SDK Unity from the [Download](../../../Download/#toast-sdk) page.

<a id="import-unity-package"></a>

### Import Unity Package

Double-click the downloaded Unity package to include it in the project.

<a id="run-the-sample"></a>

### Run the Sample

NHN Cloud SDK for Unity has an additional Sample Unity Package. The following describes how to execute the sample:

1. Double-click the Sample Unity Package to include it in the project.
2. In **File > Build Settings**, add Toast/Sample/Sample.unity to **Scenes in Build**.
3. Run the build in Android or iOS.
4. Run the built application.

> (Caution) Unity SDK currently supports Android and iOS only.
> It does not operate properly in Unity Editor (to be supported).

<a id="android-build-setup"></a>

## Android Build Setup

<a id="unity-play-services-resolver"></a>

### Unity Play Services Resolver

* NHN Cloud SDK Unity (0.19.0~) version is released with the Unity Play Services Resolver library.
* This library is copied into your Unity project, automatically resolving dependencies on Android-related libraries (e.g. AAR).

<a id="using-gradle-build-settings"></a>

#### Using Gradle build settings

* Gradle build settings are provided below.
* Before using the settings, turn off options and remove the downloaded plugin as follows.
    1. In Unity editor, select Assets > Play Services Resolver > Android Resolver > Settings.
    2. In the settings, turn off "Enable Auto-Resolution" and "Enable Resolution On Build" options.
    3. Remove the AAR file in Assets/Plugins/Android.

<a id="using-the-provided-aar-libraries"></a>

#### Using the provided AAR libraries

* AAR libraries are provided as an attached archive file.
* Before using the libraries, turn off options and remove the downloaded plugin as follows.
    1. In Unity editor, select Assets > Play Services Resolver > Android Resolver > Settings.
    2. In the settings, turn off "Enable Auto-Resolution" and "Enable Resolution On Build" options.
    3. Remove the AAR file in Assets/Plugins/Android.

<a id="gradle-build-setup"></a>

### Gradle Build Setup

* NHN Cloud SDK uses Gradle build for Android builds.

<a id="how-to-set-up-gradle-build"></a>

#### How to Set Up Gradle Build
1. Select **File > Build Settings > Android**.
2. Select **Gradle (New)** for **Build System**.
3. Run the Build.
    - If a signing-related error occurs, turn on the Development Build option and proceed with build.

<a id="create-a-gradle-template-file"></a>

#### Create a Gradle Template File
##### 2017.2 or higher
- Go to **Edit > Project Settings > Player** and enable Custom Gradle Template for Publishing Settings.
    - Select Gradle for Build System to enable the Custom Gradle Template toggle.
- With the option enabled, mainTemplate.gradle is created in the Assets/Plugins/Android folder.

##### Lower than 2017.2
- Copy the mainTemplate.gradle in the Unity installation folder to the Assets/Plugins/Android folder.

> Windows: (Unity installation folder)\Editor\Data\PlaybackEngines\AndroidPlayer\Tools\GradleTemplates
> macOS: (Unity installation folder)/PlaybackEngines/AndroidPlayer/Tools/GradleTemplates

<a id="set-up-maintemplategradle"></a>

#### Set Up mainTemplate.gradle
- Add mavenCentral and Google repositories to mainTemplate.gradle.
- Each module has an Android Unity plugin. Add a plugin of the module that you want to use to mainTemplate.gradle.
    - To add Android Unity Plugins, see the guide for each module.

```groovy
allprojects {
    repositories {
        mavenCentral()
        maven {
            url 'https://maven.google.com'
        }

        flatDir {
            dirs 'libs'
        }
    }
}
```

<a id="proguard-setup"></a>

### Proguard Setup
- If you're using Android Unity Plugin 0.12.0 or higher, no additional setting is necessary.
    - To apply Proguard, update Android Unity Plugin to 0.12.0 or higher.

<a id="android-build-issue-faq"></a>

### Android Build Issue FAQ

<a id="when-library-conflict-occurs"></a>

#### When library conflict occurs

> **Build error log**
> com.android.build.api.transform.TransformException:java.util.zip.ZipException: duplicate entry: android/support/annotation/AnimRes.class See the Console for details.

- If the build error log as above is generated, it indicates library conflict.
- NHN Cloud SDK was designed to have as few dependency libraries as possible, but it has a sole dependency on **com.android.support:support-annotations**.
- If the support-annotations library exists as jar or aar file in the project, library conflict occurs.
- To enable the build, check the version of support-annotations in jar or aar format and take action as follows.

##### If the version of support-annotations is 27.1.1 or lower
- Remove the file.

##### If the version of support-annotations is higher than 27.1.1
- Add an exclude rule as below.
```groovy
if (GradleVersion.current() >= GradleVersion.version("4.2")) {
    implementation('com.toast.android:toast-unity-XXX:X.X.X') {
        exclude group: 'com.android.support', module: 'support-annotations'
    }
} else {
    compile('com.toast.android:toast-unity-XXX:X.X.X') {
        exclude group: 'com.android.support', module: 'support-annotations'
    }
}
```

<a id="when-an-ndk-related-error-occurs"></a>

#### When an NDK-related error occurs
- When you run the build after setting up Gradle, the following error may occur:
> No toolchains found in the NDK toolchains folder for ABI with prefix: mips64el-linux-android
- This error occurs because the NDK version is high and does not support mips.
    - The solution is to update Android Gradle Plugin to 3.2.1 or higher.
    - Some Unity versions do not support update of Android Gradle Plugin. In this case, delete the ndk-bundle folder under the Android SDK installation folder.
    - For easier version management, we recommend you manage NDKs required for the IL2CPP build in a separate folder, not under Android SDK.

<a id="ios-build-setup"></a>

## iOS Build Setup

<a id="modify-xcode-build-settings"></a>

### Modify Xcode Build Settings
* To use NHN Cloud SDK in iOS, add settings as below in Xcode.

<a id="other-linker-flag-option"></a>

#### Other Linker Flag option
* Add **-ObjC**, **-lc++**  to Other Linker Flag option.

<a id="enable-bitcode-option"></a>

#### Enable Bitcode option
* Set Enable Bitcode to **NO**.

<a id="unity-play-services-resolver-2"></a>

### Unity Play Services Resolver

* NHN Cloud SDK Unity (0.19.0~) version is released with the Unity Play Services Resolver library.
* This library automatically resolves the dependency on libraries that use iOS CocoaPods.

> Note) iOS dependency is identified using CocoaPods. CocoaPods is executed in the build post-processing steps.

* If you're using Unity 5.6 or higher, xcworkspace including the necessary TOAST SDK native plugins is created. You must use the created xcworkspace instead of a standard Xcode project.
* When you use the previous Unity version, dependency is included in the normal Xcode project.

<a id="using-the-provided-ios-framework"></a>

#### Using the provided iOS framework

* iOS frameworks are provided as an attached archive file.
* Before using the frameworks, turn off options as follows.
    1. In Unity editor, select Assets > Play Services Resolver > iOS Resolver > Settings.
    2. Turn off all options in the settings.

<a id="initialize-nhn-cloud-sdk"></a>

## Initialize NHN Cloud SDK

To use NHN Cloud SDK, perform initialization in Start of one of components of the first Scene.

> Without initialization, other API calls do not operate properly.

```csharp
public class GameStartBehaviour : MonoBehaviour
{
    void Start()
    {
        ToastSdk.Initialize();
    }
}
```

<a id="set-user-id"></a>

## Set User ID

User ID can be set for NHN Cloud SDK.
The configured User ID is commonly used in each module of NHN Cloud SDK.
Whenever Log Sending API of ToastLogger is called, the configured User ID is sent to a server along with logs.

<a id="specification-for-user-id-setting-api"></a>

### Specification for User ID Setting API
```csharp
ToastSdk.UserId = userId;
```

<a id="usage-example-of-user-id-setting"></a>

### Usage Example of User ID Setting
```csharp
ToastSdk.UserId = "TOAST";
```

<a id="set-debug-mode"></a>

## Set Debug Mode

To check internal logs of NHN Cloud SDK, the debug mode can be set.
When you make an inquiry regarding NHN Cloud SDK, sending the logs with the debug mode enabled can be helpful for faster response.

<a id="specification-for-debug-mode-setting-api"></a>

### Specification for Debug Mode Setting API
```csharp
ToastSdk.DebugMode = true; // or false
```

> [Caution] The debug mode must be disabled before releasing a game.

<a id="use-nhn-cloud-service"></a>

## Use NHN Cloud Service

* User Guide for [Log & Crash](./log-collector-unity)
* User Guide for [IAP](./iap-unity)
