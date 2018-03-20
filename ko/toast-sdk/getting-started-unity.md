## TOAST > TOAST SDK 사용 가이드 > 시작하기 > Unity

## Environments

* Android 4.0.3 이상
* iOS 8.0 이상
* Unity 5.3.4 이상

## Add TOAST SDK to Your Project

다운로드 받은 유니티 패키지를 더블 클릭하여 프로젝트에 포함시킵니다.

## Configure Unity Build and Player Settings

* Unity에는 TOAST SDK가 서버로 로그를 전송하는데 영향을 주는 몇가지 설정들이 있습니다.
* 이 설정들의 효과를 간략히 설명하고 TOAST SDK의 권장 설정에 대해 설명합니다.

| 목록 | 설정 | 권장 설정 |
| --- | --- | ----- |
| Build Settings | Script Debugging | OFF |
| Player Settings > Debugging and crash reporting | On .Net UnhandledException | Silent Exit |
| Player Settings > Debugging and crash reporting | Enable CrashReport API | Disabled |
| Player Settings > Other Settings | Script Call Optimization | Slow and Safe |

### Script Debugging

* Crash의 StackTrace에서 Crash가 발생한 LineNumber를 가져옴니다. Release의 경우 OFF로 설정합니다.

### On .Net UnhandledException

* On .Net UnhandledException를 Crash로 설정할 경우 예외 발생 시, 즉시 앱이 종료됩니다. 
* Silent Exit로 설정해야 Unity Exceptoin을 캡처할 수 있습니다.

### Enable CrashReport API

* Unity CrashReporter API를 활성화 합니다. Toast Crash SDK를 사용하는 경우 Disabled로 설정합니다.

### Script Call Optimization

* Runtime C# Crash 로그를 수집하고자 하는 경우 Slow and Safe로 설정해야 합니다.

## Using the TOAST Service

* [Log Collector](./log-collector-unity) 사용 가이드
* [Crash Reporter](./crash-reporter-unity) 사용 가이드

