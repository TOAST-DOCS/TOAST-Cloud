## NHN Cloud > User Guide for NHN Cloud SDK > Getting Started > Unity

## Supporting Environment 

* Unity 5.5.0 or higher
* Android 4.0.3 or higher
* iOS 8.0 or higher
* The latest version of XCode (version 9 or higher)

## Configuration of NHN Cloud SDK

NHN Cloud SDK for Unity is configured as follows: 

* [NHN Cloud Logger](./log-collector-unity) SDK
* [NHN Cloud IAP](./iap-unity) SDK

 NHN Cloud SDK services can be selectively applied for your needs. 

| Unity package | Service |
| --- | --- |
| TOAST-Logger-UnityPlugin.unitypackage | TOAST Log & Crash |
| TOAST-IAP-UnityPlugin.unitypackage | TOAST IAP |
| TOAST-Sample-UnityPlugin.unitypackage | Sample |

### Structure of Unity Package 

NHN Cloud SDK for Unity is structured with folders as follows:  

| Directory | Description | Unity package |
|---|---|---|
| Toast | Root folder of TOAST SDK | All |
| Toast/Common | Common module folder of TOAST SDK | All |
| Toast/Logger | Module folder of TOAST Logger | Logger, Sample |
| Toast/IAP | Module folder of TOAST IAP | IAP, Sample |
| Toast/Sample | SDK sample folder | Sample |

## Apply NHN Cloud SDK to Unity Projects 

Download NHN Cloud SDK Unity Package from the following link: 

- [Download](../../../Download/#toast-sdk)

### Import Unity Package 

Double-click the downloaded unity package and include it to the project. 

### Execute Sample 

NHN Cloud SDK for Unity has an additional sample unity package, and below describes how to execute the sample: 

1. Double-click the sample unity package and include it to the project. 
2. Add NHN Cloud/Sample/Sample.unity from File > Build Settings, to Scenes in Build.
3. Build in Android or iOS. 
4. Execute the build application. 

> (Caution) Unity SDK currently supports Android and iOS only. 
> Cannot operate in Unity Editor (to be supported in the near future). 

## For Android 

### Unity Play Services Resolver 

* NHN Cloud SDK Unity(0.19.0~) 버전에는 Unity Play Services Resolver 라이브러리와 함께 배포됩니다. 
* 이 라이브러리는 안드로이드 관련 라이브러리(예:AAR)에 대한 종속성을 자동으로 해결하여 Unity 프로젝트에 복사됩니다. 

#### Gradle 빌드 설정을 사용할 경우

* Gradle 빌드 설정은 아래에 있습니다. 
* 아래와 같이 옵션을 제거하고 받은 플러그인을 제거하고 사용하시면 됩니다 .
	1. Unity 편집기에서 Assets(애셋) > Play Services Resolver(Play 서비스 리졸버) > Android Resolver(Android 리졸버) > Settings(세팅)을 선택합니다.
	2. 설정에서 "Enable Auto-Resolution"과 "Enable Resolution On Build" 옵션을 끕니다.	
	3. Assets/Plugins/Android에 있는 AAR파일을 제거합니다.
	
#### AAR 라이브러리 제공

* AAR 라이브러리들을 압축파일로 첨부해서 제공하고 있습니다. 
* 아래와 같이 옵션을 제거하고 받은 플러그인을 제거하고 사용하시면 됩니다 .
	1. Unity 편집기에서 Assets(애셋) > Play Services Resolver(Play 서비스 리졸버) > Android Resolver(Android 리졸버) > Settings(세팅)을 선택합니다.
	2. 설정에서 "Enable Auto-Resolution"과 "Enable Resolution On Build" 옵션을 끕니다.
	3. Assets/Plugins/Android에 있는 AAR파일을 제거합니다.

### Gradle Build Setting

* NHN Cloud SDK applies Gradle Build for Android builds.

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
* To use NHN Cloud SDK for iOS, add settings as below in Xcode. 

#### Other Linker Flag 
* Add **-ObjC**, **-lc++**  to Other Linker Flag option.  

#### Enable Bitcode 옵션
* Set **NO** for Enable Bitcode.

### Unity Play Services Resolver 

* NHN Cloud SDK Unity(0.19.0~) 버전에는 Unity Play Services Resolver 라이브러리와 함께 배포됩니다. 
* 이 라이브러리는 iOS CocoaPods을 사용하는 라이브러리에 대한 종속성을 자동으로 해결해줍니다.

> 참고) iOS 종속성은 CocoaPods를 사용하여 식별합니다. CocoaPods는 빌드 후 처리단계에서 실행됩니다.

* Unity 5.6이상을 사용하는 경우 필요한 NHN Cloud SDK native plugin을 포하하는 xcworkspace가 생성됩니다. 표준 xcode 프로젝트 대신 생성된 xcworkspace를 사용해야 합니다.
* 이전 버전의 Unity를 사용할 때 종속성이 표준 Xcode 프로젝트에 포함됩니다.

#### iOS framework 제공

* iOS framework들을 압축파일로 첨부해서 제공하고 있습니다. 
* 아래와 같이 옵션을 제거하고 사용하시면 됩니다. 
	1. Unity 편집기에서 Assets(애셋) > Play Services Resolver(Play 서비스 리졸버) > iOS Resolver(iOS 리졸버) > Settings(세팅)을 선택합니다.
	2. 설정에서 모든 옵션을 끕니다.

## Initialize NHN Cloud SDK 

Execute NHN Cloud SDK initialization in one of the starts of components on the initial scene. 

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

User ID can be set for NHN Cloud SDK and it is for common usage at each module of NHN Cloud SDK.
Send such set user ID to a server, along with logs, whenever Log Sending API of NHN Cloud Logger is called. 

### Specifications for User ID Setting API  
```csharp
ToastSdk.UserId = userId;
```

### Usage Example of User ID Setting 
```csharp
ToastSdk.UserId = "TOAST";
```

## Set Debug Mode 

To check logs within NHN Cloud SDK, the debug mode can be set. 
To inquire of NHN Cloud SDK, enable the debug mode for faster response.  

### Specifications for Debug Mode Setting API
```csharp
ToastSdk.DebugMode = true; // or false
```

> (Caution) To release a game, the debug mode must be disabled. 

## Use NHN Cloud Service 

* User Guide for [NHN Cloud Log & Crash](./log-collector-unity) 
* User Guide for [NHN Cloud IAP](./iap-unity)

