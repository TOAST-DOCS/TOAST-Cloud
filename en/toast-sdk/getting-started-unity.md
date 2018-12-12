## TOAST > User Guide for TOAST SDK > Getting Started > Unity

## Supporting Environment 

* Unity 5.3.4 or higher
* Android 4.0.3 or higher
* iOS 8.0 or higher
* The latest version of XCode (version 9 or higher)

## Configuration of TOAST SDK

TOAST SDK for Unity is configured as follows: 

* [TOAST Logger](./log-collector-unity) SDK

 TOAST SDK services can be selectively applied for your needs. 

| Unity package | Service |
| --- | --- |
| TOAST-Logger-UnityPlugin.unitypackage | TOAST Log & Crash |
| TOAST-Sample-UnityPlugin.unitypackage | Sample |

### Structure of Unity Package 

TOAST SDK for Unity is structured with folders as follows:  

| Directory | Description | Unity package |
|---|---|---|
| Toast | Root folder of TOAST SDK | All |
| Toast/Common | Common module folder of TOAST SDK | All |
| Toast/Logger | Module folder of TOAST Logger | Logger, Sample |
| Toast/Sample | SDK sample folder | Sample |

## Apply TOAST SDK to Unity Projects 

Download TOAST SDK Unity Package from the following link: 

- [Download](../../../Download/#toast-sdk)

### Import Unity Package 

Double-click the downloaded unity package and include it to the project. 

### Execute Sample 

TOAST SDK for Unity has an additional sample unity package, and below describes how to execute the sample: 

1. Double-click the sample unity package and include it to the project. 
2. Add Toast/Sample/Sample.unity from File > Build Settings, to Scenes in Build.
3. Build in Android or iOS. 
4. Execute the build application. 

> (Caution) Unity SDK currently supports Android and iOS only. 
> Cannot operate in Unity Editor (to be supported in the near future). 

## For Android 

### Gradle Build Setting

* TOAST SDK applies Gradle Build for Android builds.

#### How to Set Gradle Builds
1. Go to File > Build Settings > Android
2. Select Gradle (New) for Build System
3. Build

> For signing-related errors, turn On the Development Build option and proceed with build. 

#### Create Gradle Template Files
##### Feb.2017 or Later  
- Go to Edit > Project Settings > Player and enable Custom Gradle Template for Publishing Settings.
    - Select Gradle for Build System so as to enable the Custom Gradle Template toggle. 
- With the option enabled, mainTemplate.gradle is created in the Assets/Plugins/Android folder. 

##### Before Feb.2017 
- Copy the mainTemplate.gradle in the Unity installation folder to the Assets/Plugins/Android folder. 

> Windows: (Unity installation folder)\Editor\Data\PlaybackEngines\AndroidPlayer\Tools\GradleTemplates
> macOS: (Unity installation folder)/PlaybackEngines/AndroidPlayer/Tools/GradleTemplates

#### mainTemplate.gradle Setting
- JCenter and Google repositories must be added to mainTemplate.gradle.
- Each module has Android Unity plugins, and add a plugin of the module of choice to mainTemplate.gradle.
    - To add Android Unity Plugins, see guides for each module. 

```groovy
allprojects {
    repositories {
        jcenter()
        maven {
            url 'https://maven.google.com'
        }

        flatDir {
            dirs 'libs'
        }
    }
}
```

#### For NDK-related Errors
- After Gradle setting and build, following error may occur: 
> No toolchains found in the NDK toolchains folder for ABI with prefix: mips64el-linux-android
- This error occurs due to a high NDK version which does not support mips. 
    - The solution is to update Android Gradle Plugin to 3.2.1 or higher.
    - For some Unity versions not supporting updates of Android Gradle Plugin, delete the ndk-bundle folder where Android SDK is installed. 
    - NDKs required for the IL2CPP build are recommended to be managed in a separate folder, not under Android SDK. 

### Proguard Setting 
- For 0.12.0 or higher Android Unity Plugin users, no additional setting is necessary. 
    - To apply Proguard, update to 0.12.0 or a higher version. 


## For iOS 

### Modify Xcode Build Settings
* To use TOAST SDK for iOS, add settings as below in Xcode. 

#### Other Linker Flag 
* Add **-ObjC**, **-lc++**  to Other Linker Flag option.  

#### Enable Bitcode 옵션
* Set **NO** for Enable Bitcode.

## Initialize TOAST SDK 

Execute TOAST SDK initialization in one of the starts of components on the initial scene. 

> Other API calls do not operate properly, without initialization. 

```csharp
public class GameStartBehaviour : MonoBehaviour
{
    void Start()
    {
        ToastSdk.Initialize();
    }
}
```

## Set UserID

User ID can be set for TOAST SDK and it is for common usage at each module of TOAST SDK.
Send such set user ID to a server, along with logs, whenever Log Sending API of TOAST Logger is called. 

### Specifications for User ID Setting API  
```csharp
ToastSdk.UserId = userId;
```

### Usage Example of User ID Setting 
```csharp
ToastSdk.UserId = "TOAST";
```

## Set Debug Mode 

To check logs within TOAST SDK, the debug mode can be set. 
To inquire of TOAST SDK, enable the debug mode for faster response.  

### Specifications for Debug Mode Setting API
```csharp
ToastSdk.DebugMode = true; // or false
```

> (Caution) To release a game, the debug mode must be disabled. 

## Use TOAST Service 

* User Guide for [TOAST Log & Crash](./log-collector-unity) 

