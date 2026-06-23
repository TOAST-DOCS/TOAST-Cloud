## NHN Cloud > SDK User Guide > Getting Started > Unity

<a id="supported-environment"></a>

## Supported environment

* Unity 5.5.0 or later
* Android 4.0.3 or later
* iOS 8.0 or later
* XCode Latest version (version 9 or later)

<a id="nhn-cloud-sdk-components"></a>

## NHN Cloud SDK components

The NHN Cloud SDK for Unity consists of the following components:

* [Logger](./log-collector-unity) SDK
* [IAP](./iap-unity) SDK

You can select and apply the features provided by the NHN Cloud SDK that you want to use.

| Unity package | Service |
| --- | --- |
| TOAST-Logger-UnityPlugin.unitypackage | Log & Crash |
| TOAST-IAP-UnityPlugin.unitypackage | IAP |
| TOAST-Sample-UnityPlugin.unitypackage | Sample |

<a id="structure-of-unity-package"></a>

### Unity package structure

The NHN Cloud SDK for Unity has the following folder structure:

| Directory | Description | Unity package |
|---|---|---|
| Toast | Root folder of the NHN Cloud SDK | All |
| Toast/Common | Common module folder of the SDK | All |
| Toast/Logger | Logger module folder | Logger, Sample |
| Toast/IAP | IAP module folder | IAP, Sample |
| Toast/Sample | SDK sample folder | Sample |

<a id="apply-nhn-cloud-sdk-to-unity-projects"></a>

## Apply NHN Cloud SDK to Unity projects

Download the NHN Cloud SDK Unity from the NHN Cloud [Download](../../../Download/#toast-sdk) page.

<a id="import-unity-package"></a>

### Import the Unity package

Double-click the downloaded Unity package to include it in your project.

<a id="run-the-sample"></a>

### Run the sample

The NHN Cloud SDK for Unity has a separate Sample Unity package. To run the sample, follow these steps:

1. Double-click the Sample Unity package to include it in your project.
2. In **File > Build Settings**, add Toast/Sample/Sample.unity to **Scenes In Build**.
3. Build for Android or iOS.
4. Run the built application.

> [Caution] Unity SDK currently supports Android and iOS only.
> It does not work properly in the Unity Editor. (Support planned)

<a id="android-build-setup"></a>

## Android build settings

<a id="unity-play-services-resolver"></a>

### Unity Play Services Resolver

* NHN Cloud SDK Unity (version 0.19.0 or later) is distributed with the Unity Play Services Resolver library.
* This library automatically resolves dependencies on Android-related libraries (e.g., AAR) and copies them to the Unity project.

<a id="using-gradle-build-settings"></a>

#### When using Gradle build settings

* The Gradle build settings are described below.
* Remove the options and the received plugins as described below before using them.
	1. In the Unity Editor, choose **Assets** > **Play Services Resolver** > **Android Resolver** > **Settings**.
	2. In the settings, turn off the **Enable Auto-Resolution** and **Enable Resolution On Build** options.
	3. Remove the AAR files in Assets/Plugins/Android.

<a id="using-the-provided-aar-libraries"></a>

#### Using the provided AAR libraries

* AAR libraries are provided as compressed files.
* Remove the options and the received plugins as described below before using them.
	1. In the Unity Editor, choose **Assets** > **Play Services Resolver** > **Android Resolver** > **Settings**.
	2. In the settings, turn off the **Enable Auto-Resolution** and **Enable Resolution On Build** options.
	3. Remove the AAR files in Assets/Plugins/Android.

<a id="gradle-build-setup"></a>

### Gradle build settings

* NHN Cloud SDK uses Gradle build when building for Android.

<a id="how-to-set-up-gradle-build"></a>

#### How to set up Gradle build
1. Choose **File > Build Settings > Android**.
2. Set **Build System** to **Gradle (New)**.
3. Build.
    - If a signing-related error occurs, turn on the **Development Build** option and proceed with the build.

<a id="create-a-gradle-template-file"></a>

#### Create the Gradle template file
##### 2017.2 or later
- Enable **Custom Gradle Template** in the Publishing Settings of **Edit > Project Settings > Player**.
    - You must select Gradle as the Build System to activate the Custom Gradle Template toggle.
- When you enable the option, mainTemplate.gradle is created in the Assets/Plugins/Android folder.

##### Below 2017.2
- Copy the mainTemplate.gradle file from the Unity installation folder to the Assets/Plugins/Android folder.

> Windows: (Unity installation folder)\Editor\Data\PlaybackEngines\AndroidPlayer\Tools\GradleTemplates
> macOS: (Unity installation folder)/PlaybackEngines/AndroidPlayer/Tools/GradleTemplates

<a id="set-up-maintemplategradle"></a>

#### Set up mainTemplate.gradle
- Add the mavenCentral and Google repositories to mainTemplate.gradle.
- There is an Android Unity plugin for each module. Add the plugin for the module that you want to use to mainTemplate.gradle.
    - For guidance on adding Android Unity plugins, see the guide for each module.

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

### Proguard settings
- If you use Android Unity Plugin version 0.12.0 or later, no additional settings are required.
    - If you want to apply Proguard, update to version 0.12.0 or later.

<a id="android-build-issue-faq"></a>

### Android build failure FAQ

<a id="when-library-conflict-occurs"></a>

#### When a library conflict occurs

> **Build error log**
> com.android.build.api.transform.TransformException:java.util.zip.ZipException: duplicate entry: android/support/annotation/AnimRes.class See the Console for details.

- If the build error log above appears, a library conflict has occurred.
- The NHN Cloud SDK is designed to minimize dependent libraries, but it has a sole dependency on **com.android.support:support-annotations**.
- If the support-annotations library exists in your project as a JAR or AAR file, a library conflict will occur.
- Check the version of support-annotations that exists as a JAR or AAR file and make the following modifications to enable the build.

##### If support-annotations version is 27.1.1 or lower
- Remove the file.

##### If support-annotations version is higher than 27.1.1
- Add `exclude` as follows:
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
- When you configure Gradle and build, the following error may occur:
> No toolchains found in the NDK toolchains folder for ABI with prefix: mips64el-linux-android
- This error occurs because the NDK version is too high and no longer supports mips.
    - This can be resolved by updating the Android Gradle Plugin to version 3.2.1 or later.
    - For certain versions of Unity, the Android Gradle Plugin cannot be updated. In this case, you can resolve the issue by deleting the ndk-bundle folder in the folder where the Android SDK is installed.
    - It is easier to manage versions when the NDK required for IL2CPP builds is managed in a separate folder rather than under the Android SDK.

<a id="ios-build-setup"></a>

## iOS build settings

<a id="modify-xcode-build-settings"></a>

### Modify Xcode build settings
* To use NHN Cloud SDK on iOS, you must add the following settings in Xcode.

<a id="other-linker-flag-option"></a>

#### Other Linker Flag option
* Add **-ObjC** and **-lc++** to the **Other Linker Flags** option.

<a id="enable-bitcode-option"></a>

#### Enable Bitcode option
* Set the **Enable Bitcode** option to **NO**.

<a id="unity-play-services-resolver-2"></a>

### Unity Play Services Resolver

* NHN Cloud SDK Unity (version 0.19.0 or later) is distributed with the Unity Play Services Resolver library.
* This library automatically resolves dependencies on libraries that use iOS CocoaPods.

> [Note] iOS dependencies are identified by using CocoaPods. CocoaPods runs in the post-build processing stage.

* If you use Unity 5.6 or later, an xcworkspace is generated that includes the required NHN Cloud SDK native plugins. You must use the generated xcworkspace instead of the standard Xcode project.
* When using an older version of Unity, dependencies are included in the standard Xcode project.

<a id="using-the-provided-ios-framework"></a>

#### Using the provided iOS framework

* iOS frameworks are provided as compressed files.
* Remove the options as described below before using them.
	1. In the Unity Editor, choose **Assets** > **Play Services Resolver** > **iOS Resolver** > **Settings**.
	2. In the settings, turn off all options.

<a id="initialize-nhn-cloud-sdk"></a>

## Initialize NHN Cloud SDK

To use the NHN Cloud SDK, call the initialization in the `Start` method of one component in the first scene.

> If you call other APIs without initializing, they will not work properly.

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

## Set the user ID

You can set a user ID in the NHN Cloud SDK.
The user ID that you set is used in common across all modules of the NHN Cloud SDK.
Every time you call the log sending API of ToastLogger, the user ID that you set is sent to the server along with the log.

<a id="specification-for-user-id-setting-api"></a>

### User ID setting API specification
```csharp
ToastSdk.UserId = userId;
```

<a id="usage-example-of-user-id-setting"></a>

### User ID setting usage example
```csharp
ToastSdk.UserId = "TOAST";
```

<a id="set-debug-mode"></a>

## Set debug mode

You can set debug mode to check the internal logs of the NHN Cloud SDK.
When you contact NHN Cloud SDK support, enable debug mode before sending your inquiry so that we can provide faster assistance.

<a id="specification-for-debug-mode-setting-api"></a>

### Debug mode setting API specification
```csharp
ToastSdk.DebugMode = true; // or false
```

> [Caution] When releasing a game, you must disable debug mode.

<a id="use-nhn-cloud-service"></a>

## Use NHN Cloud services

* [Log & Crash](./log-collector-unity) user guide
* [IAP](./iap-unity) user guide