## NHN Cloud > SDK User Guide > Getting Started > Unity

<a id="supported-environment"></a>

## Supported environment

* Unity 5.5.0 or later
* Android 4.0.3 or later
* iOS 8.0 or later
* Xcode latest version (version 9 or later)

<a id="nhn-cloud-sdk-components"></a>

## NHN Cloud SDK components

The NHN Cloud SDK for Unity consists of the following:

* [Logger](./log-collector-unity) SDK
* [IAP](./iap-unity) SDK

You can select and apply the features you want from the services provided by NHN Cloud SDK.

| Unity package | Service |
| --- | --- |
| TOAST-Logger-UnityPlugin.unitypackage | Log & Crash |
| TOAST-IAP-UnityPlugin.unitypackage | IAP |
| TOAST-Sample-UnityPlugin.unitypackage | Sample |

<a id="structure-of-unity-package"></a>

### Unity package structure

NHN Cloud SDK for Unity has the following folder structure:

| Directory | Description | Unity package |
|---|---|---|
| Toast | Root folder of NHN Cloud SDK | All |
| Toast/Common | Common module folder of the SDK | All |
| Toast/Logger | Logger module folder | Logger, Sample |
| Toast/IAP | IAP module folder | IAP, Sample |
| Toast/Sample | SDK sample folder | Sample |

<a id="apply-nhn-cloud-sdk-to-unity-projects"></a>

## Apply NHN Cloud SDK to a Unity project

Download NHN Cloud SDK Unity from the NHN Cloud [Download](../../../Download/#toast-sdk) page.

<a id="import-unity-package"></a>

### Import a Unity package

Double-click the downloaded Unity Package to include it in the project.

<a id="run-the-sample"></a>

### Run the sample

NHN Cloud SDK for Unity has a separate Sample Unity Package. To run the sample, follow the steps below:

1. Double-click the Sample Unity Package to include it in the project.
2. In **File > Build Settings**, add Toast/Sample/Sample.unity to **Scenes In Build**.
3. Build for Android or iOS.
4. Run the built application.

> [Caution] The Unity SDK currently supports Android and iOS only.
> It does not work correctly in the Unity Editor. (Support is planned.)

<a id="android-build-setup"></a>

## Android build setup

<a id="unity-play-services-resolver"></a>

### Unity Play Services Resolver

* NHN Cloud SDK Unity (version 0.19.0 and later) is distributed with the Unity Play Services Resolver library.
* This library automatically resolves dependencies on Android-related libraries (e.g., AAR) and copies them to your Unity project.

<a id="using-gradle-build-settings"></a>

#### When using Gradle build settings

* The Gradle build settings are described below.
* Remove the options as described below, then remove the downloaded plugin before using it.
	1. In the Unity Editor, choose Assets > Play Services Resolver > Android Resolver > Settings.
	2. In Settings, turn off the **Enable Auto-Resolution** and **Enable Resolution On Build** options.
	3. Remove the AAR files in Assets/Plugins/Android.

<a id="using-the-provided-aar-libraries"></a>

#### Using the provided AAR libraries

* AAR libraries are provided as a compressed archive.
* Remove the options as described below, then remove the downloaded plugin before using it.
	1. In the Unity Editor, choose Assets > Play Services Resolver > Android Resolver > Settings.
	2. In Settings, turn off the **Enable Auto-Resolution** and **Enable Resolution On Build** options.
	3. Remove the AAR files in Assets/Plugins/Android.

<a id="gradle-build-setup"></a>

### Gradle build setup

* NHN Cloud SDK uses a Gradle build when building for Android.

<a id="how-to-set-up-gradle-build"></a>

#### How to set up Gradle build
1. Choose **File > Build Settings > Android**.
2. Select **Gradle (New)** for **Build System**.
3. Build.
    - If a signing-related error occurs, enable the Development Build option and proceed with the build.

<a id="create-a-gradle-template-file"></a>

#### Create a Gradle template file
##### Unity 2017.2 or later
- Enable Custom Gradle Template in the Publishing Settings of **Edit > Project Settings > Player**.
    - You must select Gradle as the Build System to enable the Custom Gradle Template toggle.
- When you enable the option, mainTemplate.gradle is created in the Assets/Plugins/Android folder.

##### Earlier than Unity 2017.2
- Copy the mainTemplate.gradle file from the Unity installation folder to the Assets/Plugins/Android folder.

> Windows: (Unity installation folder)\Editor\Data\PlaybackEngines\AndroidPlayer\Tools\GradleTemplates
> macOS: (Unity installation folder)/PlaybackEngines/AndroidPlayer/Tools/GradleTemplates

<a id="set-up-maintemplategradle"></a>

#### Set up mainTemplate.gradle
- Add the mavenCentral and Google repositories to mainTemplate.gradle.
- Each module has an Android Unity plugin. Add the plugin for the module you want to use to mainTemplate.gradle.
    - For guidance on adding the Android Unity plugin, see the guide for each module.

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

### Proguard setup
- No additional configuration is required if you are using Android Unity Plugin version 0.12.0 or later.
    - If you want to apply Proguard, update to version 0.12.0 or later.

<a id="android-build-issue-faq"></a>

### Android build failure FAQ

<a id="when-library-conflict-occurs"></a>

#### When a library conflict occurs

> **Build error log**
> com.android.build.api.transform.TransformException:java.util.zip.ZipException: duplicate entry: android/support/annotation/AnimRes.class See the Console for details.

- If a build error log like the one above occurs, it indicates a library conflict.
- NHN Cloud SDK is designed to minimize dependencies on external libraries; however, it has a dependency on **com.android.support:support-annotations**.
- A library conflict occurs if the support-annotations library exists as a jar or aar file in the project.
- Check the version of support-annotations that exists as a jar or aar file, and make the following modifications to build successfully.

##### When the support-annotations version is 27.1.1 or below
- Remove the file.

##### When the support-annotations version is above 27.1.1
- Add exclude as shown below.
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
- When you configure Gradle and build, the following error may occur.
> No toolchains found in the NDK toolchains folder for ABI with prefix: mips64el-linux-android
- This error occurs because the NDK version is too high and no longer supports mips.
    - You can resolve this by updating the Android Gradle Plugin to version 3.2.1 or later.
    - For certain Unity versions where you cannot update the Android Gradle Plugin, you can resolve this issue by deleting the ndk-bundle folder in the folder where the Android SDK is installed.
    - The NDK required for IL2CPP builds is easier to manage when stored in a separate folder rather than under the Android SDK directory.

<a id="ios-build-setup"></a>

## iOS build setup

<a id="modify-xcode-build-settings"></a>

### Modify Xcode build settings
* To use NHN Cloud SDK on iOS, you must add the following settings in Xcode.

<a id="other-linker-flag-option"></a>

#### Other Linker Flag option
* Add **-ObjC** and **-lc++** to the Other Linker Flag option.

<a id="enable-bitcode-option"></a>

#### Enable Bitcode option
* Set the Enable Bitcode option to **NO**.

<a id="unity-play-services-resolver-2"></a>

### Unity Play Services Resolver

* NHN Cloud SDK Unity (version 0.19.0 and later) is distributed with the Unity Play Services Resolver library.
* This library automatically resolves dependencies on libraries that use iOS CocoaPods.

> [Note] iOS dependencies are identified using CocoaPods. CocoaPods runs during the post-build processing stage.

* When using Unity 5.6 or later, an xcworkspace that includes the required TOAST SDK native plugin is generated. You must use the generated xcworkspace instead of the standard Xcode project.
* When using an earlier version of Unity, dependencies are included in the standard Xcode project.

<a id="using-the-provided-ios-framework"></a>

#### Using the provided iOS framework

* iOS frameworks are provided as a compressed archive.
* Turn off the options as described below before using them.
	1. In the Unity Editor, choose Assets > Play Services Resolver > iOS Resolver > Settings.
	2. In Settings, turn off all options.

<a id="initialize-nhn-cloud-sdk"></a>

## Initialize NHN Cloud SDK

To use NHN Cloud SDK, perform initialization in the Start method of one of the components in the first scene.

> If you call other APIs without initializing, they will not work correctly.

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

## Set user ID

You can set a user ID in NHN Cloud SDK.
The configured UserID is used commonly across all modules of NHN Cloud SDK.
Each time you call the log sending API of ToastLogger, the configured user ID is sent to the server along with the log.

<a id="specification-for-user-id-setting-api"></a>

### UserID setting API specification
```csharp
ToastSdk.UserId = userId;
```

<a id="usage-example-of-user-id-setting"></a>

### Usage example of user ID setting
```csharp
ToastSdk.UserId = "TOAST";
```

<a id="set-debug-mode"></a>

## Set debug mode

You can set debug mode to check NHN Cloud SDK internal logs.
When contacting support for NHN Cloud SDK, enabling debug mode and sharing it will allow us to assist you more quickly.

<a id="specification-for-debug-mode-setting-api"></a>

### Debug mode setting API specification
```csharp
ToastSdk.DebugMode = true; // or false
```

> [Caution] When releasing a game, you must disable debug mode.

<a id="use-nhn-cloud-service"></a>

## Use NHN Cloud services

* [Log & Crash](./log-collector-unity) User Guide
* [IAP](./iap-unity) User Guide