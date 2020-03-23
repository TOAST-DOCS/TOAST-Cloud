## TOAST > TOAST SDK 사용 가이드 > TOAST Log & Crash > Android (NDK)

Android 앱에 네이티브 라이브러리가 포함되어 있는 경우 간단한 빌드 설정으로 네이티브 코드에 대한 전체 스택 추적과 상세한 오류 보고서를 사용할 수 있습니다.

* TOAST Crash Reporter for NDK는 TOAST 0.21.0 이상에서 사용할 수 있습니다.
* TOAST Crash Reporter for NDK는 TOAST Logger 를 통해 크래시 로그를 전송합니다.
* TOAST Logger와 TOAST Crash Reporter for NDK 라이브러리는 동일한 버전을 사용하는 것을 권장합니다.
* TOAST Crash Reporter for NDK는 TOAST Logger 초기화 시에 크래시 감지를 시작합니다.
* TOAST Crash Reporter for NDK를 사용하기 위해서는 r17c이상의 NDK가 필요합니다.


## 사전 준비

1\. [TOAST Log & Crash](./log-collector-android)를 설치합니다.

## 라이브러리 설정
- 아래 코드를 build.gradle에 추가합니다.

```groovy
dependencies {
    implementation 'com.toast.android:toast-logger:0.21.0'
    implementation 'com.toast.android:toast-crash-reporter-ndk:0.21.0'
    ...
}
```