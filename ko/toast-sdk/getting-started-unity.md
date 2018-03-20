## TOAST > TOAST SDK 사용 가이드 > 시작하기 > Unity

## Environments

* Android 4.0.3 이상
* iOS 8.0 이상
* Unity 5.3.4 이상

## Component SDKs

Unity 용 TOAST SDK는 다음과 같은 SDK로 구성되어 있습니다.

* [TOAST Logger](./log-collector-unity) SDK
* [TOAST Crash](./crash-reporter-unity) SDK

전체 TOAST SDK 기능이 필요하지 않은 경우 게임에 필요한 SDK만 사용할 수 있습니다.

| Unity package | Service |
| --- | --- |
| TOAST-Logger-UnityPlugin-1.0.0.unitypackage | Log Collection |
| TOAST-Crash-UnityPlugin-1.0.0.unitypackage | Crash Reporter |

### Structure of Unity package

Unity용 TOAST SDK는 다음과 같은 폴더 구조로 되어 있습니다.

| Directory | Description |
|---|---|
| Toast | TOAST SDK의 루트 폴더 |
| Toast/Base | TOAST SDK의 공통 모듈 폴더 |
| Toast/Logger | Log Collection 모듈 폴더 |
| Toast/Crash | Crash Reporter 모듈 폴더 |
| Toast/Sample | SDK 샘플 폴더 |
| Plugins | Gradle 빌드를 위한 mainTemplate.gradle이 있는 폴더 |

## Add TOAST SDK to Your Project

내려받은 유니티 패키지를 더블 클릭하여 프로젝트에 포함합니다.

### Run Sample

Unity 용 TOAST SDK는 Sample을 포함하고 있습니다. Sample을 실행하는 방법은 아래와 같습니다.

1. File > Build Settings 에서 Toast/Sample/Sample.unity 를 Scenes In Build 에 추가합니다.
2. Android 혹은 iOS로 빌드합니다.
3. 빌드된 애플리케이션을 실행합니다.

> (주의) Unity SDK는 현재 Android, iOS만을 지원합니다.
> Unity Editor에서는 정상동작하지 않습니다. (지원 예정)

## Configure

### Build settings for Gradle (Android)

* TOAST SDK는 안드로이드 빌드시 Gradle 빌드를 사용합니다.

#### Gradle 빌드 설정 방법
1. File > Build Settings > Android 선택
2. Build System을 Gradle (New) 로 선택
3. Build
    - Signing 관련 에러가 발생할 경우 Development Build 옵션을 On 하고 빌드를 진행하면 됩니다.

### Player Settings

* Unity에는 TOAST SDK가 서버로 로그를 전송하는데 영향을 주는 몇가지 설정들이 있습니다.
* 이 설정들의 효과를 간략히 설명하고 TOAST SDK의 권장 설정에 대해 설명합니다.

| 목록 | 설정 | 권장 설정 |
| --- | --- | ----- |
| Build Settings | Script Debugging | OFF |
| Player Settings > Debugging and crash reporting | On .Net UnhandledException | Silent Exit |
| Player Settings > Debugging and crash reporting | Enable CrashReport API | Disabled |
| Player Settings > Other Settings | Script Call Optimization | Slow and Safe |

#### Script Debugging

* Crash의 StackTrace에서 Crash가 발생한 LineNumber를 가져옴니다. Release의 경우 OFF로 설정합니다.

#### On .Net UnhandledException

* On .Net UnhandledException를 Crash로 설정할 경우 예외 발생 시, 즉시 앱이 종료됩니다. 
* Silent Exit로 설정해야 Unity Exceptoin을 캡처할 수 있습니다.

#### Enable CrashReport API

* Unity CrashReporter API를 활성화 합니다. Toast Crash SDK를 사용하는 경우 Disabled로 설정합니다.

#### Script Call Optimization

* Runtime C# Crash 로그를 수집하고자 하는 경우 Slow and Safe로 설정해야 합니다.

## Using the TOAST Service

* [Log Collector](./log-collector-unity) 사용 가이드
* [Crash Reporter](./crash-reporter-unity) 사용 가이드

