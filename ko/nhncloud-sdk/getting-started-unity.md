## NHN Cloud > SDK 사용 가이드 > 시작하기 > Unity

## 지원 환경

* Unity 5.5.0 이상
* Android 4.0.3 이상
* iOS 8.0 이상
* XCode 최신 버전 (버전 9 이상)

## NHN Cloud SDK의 구성

Unity용 NHN Cloud SDK의 구성은 다음과 같습니다.

* [Logger](./log-collector-unity) SDK
* [IAP](./iap-unity) SDK

NHN Cloud SDK가 제공하는 서비스 중 원하는 기능을 선택하여 적용할 수 있습니다.

| Unity package | Service |
| --- | --- |
| TOAST-Logger-UnityPlugin.unitypackage | Log & Crash |
| TOAST-IAP-UnityPlugin.unitypackage | IAP |
| TOAST-Sample-UnityPlugin.unitypackage | Sample |

### Unity package 구조

Unity 용 NHN Cloud SDK는 다음과 같은 폴더 구조로 되어 있습니다.

| Directory | Description | Unity package |
|---|---|---|
| Toast | NHN Cloud SDK의 루트 폴더 | All |
| Toast/Common | SDK의 공통 모듈 폴더 | All |
| Toast/Logger | Logger 모듈 폴더 | Logger, Sample |
| Toast/IAP | IAP 모듈 폴더 | IAP, Sample |
| Toast/Sample | SDK 샘플 폴더 | Sample |

## NHN Cloud SDK를 Unity 프로젝트에 적용

NHN Cloud의 [Download](../../../Download/#toast-sdk) 페이지에서 NHN Cloud SDK Unity를 다운로드합니다.

### Unity package 가져오기

다운로드한 Unity Package를 더블클릭하여 프로젝트에 포함합니다.

### Sample 실행

Unity 용 NHN Cloud SDK는 별도의 Sample Unity Package가 있습니다. Sample을 실행하는 방법은 다음과 같습니다.

1. Sample Unity Package 를 더블 클릭하여 프로젝트에 포함합니다.
2. **File > Build Settings**에서 Toast/Sample/Sample.unity를 **Scenes In Build**에 추가합니다.
3. Android 혹은 iOS로 빌드합니다.
4. 빌드된 애플리케이션을 실행합니다.

> (주의) Unity SDK는 현재 Android, iOS만을 지원합니다.
> Unity Editor에서는 정상동작하지 않습니다. (지원 예정)

## Android 빌드 설정

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

### Gradle Build 설정

* NHN Cloud SDK는 Android 빌드 시 Gradle 빌드를 사용합니다.

#### Gradle 빌드 설정 방법
1. **File > Build Settings > Android**를 선택합니다.
2. **Build System**을 **Gradle (New)**로 선택
3. Build
    - Signing 관련 에러가 발생할 경우 Development Build 옵션을 On 하고 빌드를 진행하면 됩니다.

#### Gradle Template 파일 생성
##### 2017.2 이상
- **Edit > Project Settings > Player**의 Publishing Settings의 Custom Gradle Template를 활성화합니다.
    - Build System을 Gradle로 선택해야 Custom Gradle Template의 토글이 활성화됩니다.
- 옵션을 활성화하면 Assets/Plugins/Android폴더에 mainTemplate.gradle이 생성됩니다.

##### 2017.2 미만
- Unity 설치 폴더에 있는 mainTemplate.gradle 파일을 Assets/Plugins/Android 폴더로 복사합니다.

> 윈도우 : (유니티 설치 폴더)\Editor\Data\PlaybackEngines\AndroidPlayer\Tools\GradleTemplates
> macOS : (유니티 설치 폴더)/PlaybackEngines/AndroidPlayer/Tools/GradleTemplates

#### mainTemplate.gradle 설정
- mainTemplate.gradle에 mavenCentral와 Google 리포지토리를 추가합니다.
- 각 모듈별로 안드로이드 유니티 플러그인이 있으며, 사용을 원하는 모듈의 플러그인을 mainTemplate.gradle에 추가합니다.
    - 안드로이드 유니티 플러그인 추가에 대한 가이드는 모듈별 가이드를 확인해주세요.

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

### Proguard 설정
- Android Unity Plugin 0.12.0 이상의 버전을 사용하면 별도의 설정이 필요없습니다.
    - Proguard 적용을 원하시는 경우, 0.12.0 이상으로 업데이트 해주시기 바랍니다.

### Android 빌드 실패 FAQ

#### 라이브러리 충돌 발생시

> **빌드 에러 로그**
> com.android.build.api.transform.TransformException:java.util.zip.ZipException: duplicate entry: android/support/annotation/AnimRes.class See the Console for details.

- 만약 위와 같은 빌드 에러 로그가 발생한다면 라이브러리 충돌이 발생한 경우입니다.
- NHN Cloud SDK는 의존 라이브러리를 최대한 가지고 있지 않도록 설계되었지만, 유일하게 **com.android.support:support-annotations** 에 의존하고 있습니다.
- 프로젝트에 support-annotations 라이브러리가 jar 혹은 aar 파일로 존재한다면 라이브러리 충돌이 발생합니다.
- jar 혹은 aar 파일로 존재하는 support-annotations의 버전을 확인해서 아래와 같이 수정해야 빌드가 가능합니다.

##### support-annotations 버전이 27.1.1 이하인 경우
- 해당 파일을 제거 합니다.

##### support-annotations 버전이 27.1.1 초과인 경우
- 아래와 같이 exclude 를 추가합니다.
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

#### NDK 관련 에러 발생시
- Gradle을 설정하고 빌드를 하면, 아래와 같은 에러가 발생할 수 있습니다.
> No toolchains found in the NDK toolchains folder for ABI with prefix: mips64el-linux-android
- 이 에러는 NDK의 버전이 높아서 mips를 지원하지 않게 되면서 발생하는 문제입니다.
    - 이는 Android Gradle Plugin을 3.2.1 이상으로 업데이트하면 해결됩니다.
    - 특정 Unity 버전에서는 Android Gradle Plugin을 업데이트할 수 없기 때문에 Android SDK가 설치된 폴더의 ndk-bundle 폴더를 삭제하면 문제가 해결됩니다.
    - IL2CPP 빌드에 필요한 NDK는 Android SDK 하위가 아닌 별도의 폴더로 관리해야 버전 관리하는 것이 쉽습니다.

## iOS 빌드 설정

### Xcode 빌드 설정 수정
* iOS에서 NHN Cloud SDK를 사용하기 위해서는 Xcode에서 아래 설정을 추가해야 합니다.

#### Other Linker Flag 옵션
* Other Linker Flag 옵션에 **-ObjC**, **-lc++** 을 추가합니다.

#### Enable Bitcode 옵션
* Enable Bitcode 옵션을 **NO**로 설정합니다.

### Unity Play Services Resolver

* NHN Cloud SDK Unity(0.19.0~) 버전에는 Unity Play Services Resolver 라이브러리와 함께 배포됩니다.
* 이 라이브러리는 iOS CocoaPods을 사용하는 라이브러리에 대한 종속성을 자동으로 해결해줍니다.

> 참고) iOS 종속성은 CocoaPods를 사용하여 식별합니다. CocoaPods는 빌드 후 처리단계에서 실행됩니다.

* Unity 5.6이상을 사용하는 경우 필요한 TOAST SDK native plugin을 포하하는 xcworkspace가 생성됩니다. 표준 xcode 프로젝트 대신 생성된 xcworkspace를 사용해야 합니다.
* 이전 버전의 Unity를 사용할 때 종속성이 표준 Xcode 프로젝트에 포함됩니다.

#### iOS framework 제공

* iOS framework들을 압축파일로 첨부해서 제공하고 있습니다.
* 아래와 같이 옵션을 제거하고 사용하시면 됩니다.
	1. Unity 편집기에서 Assets(애셋) > Play Services Resolver(Play 서비스 리졸버) > iOS Resolver(iOS 리졸버) > Settings(세팅)을 선택합니다.
	2. 설정에서 모든 옵션을 끕니다.

## NHN Cloud SDK 초기화

NHN Cloud SDK 사용하기 위해 최초 Scene의 컴포넌트 중 하나의 Start에서 초기화를 수행합니다.

> 초기화를 하지 않고 다른 API를 호출하면 제대로 동작하지 않습니다.

```csharp
public class GameStartBehaviour : MonoBehaviour
{
    void Start()
    {
        ToastSdk.Initialize();
    }
}
```

## UserID 설정

NHN Cloud SDK에 사용자 ID를 설정할 수 있습니다.
설정한 UserID는 NHN Cloud SDK의 각 모듈에서 공통으로 사용됩니다.
ToastLogger의 로그 전송 API를 호출할 때마다 설정한 사용자 아이디를 로그와 함께 서버로 전송합니다.

### UserID 설정 API 명세
```csharp
ToastSdk.UserId = userId;
```

### UserID 설정 사용 예
```csharp
ToastSdk.UserId = "TOAST";
```

## 디버그 모드 설정하기

NHN Cloud SDK의 내부 로그 확인을 위해서 디버그 모드를 설정할 수 있습니다.
NHN Cloud SDK 문의하실 때는 디버그 모드를 활성화해서 전달해 주시면 빠르게 지원해드릴 수  있습니다.

### 디버그 모드 설정 API 명세
```csharp
ToastSdk.DebugMode = true; // or false
```

> (주의) 게임을 릴리스할 경우, 반드시 디버그 모드를 비활성화 해야 합니다.

## NHN Cloud Service 사용하기

* [Log & Crash](./log-collector-unity) 사용 가이드
* [IAP](./iap-unity) 사용 가이드
