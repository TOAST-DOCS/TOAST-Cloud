## NHN Cloud > SDK 사용 가이드 > Log & Crash > Android (NDK)

## Android NDK 크래시 보고서

Android 앱에 네이티브 라이브러리가 포함된 경우 간단한 빌드 설정으로 네이티브 코드에 대한 전체 스택 추적과 상세한 오류 보고서를 사용할 수 있습니다.

* NHN Cloud Crash Reporter for NDK는 **NHN Cloud 0.21.0 이상**에서 사용할 수 있습니다.
* NHN Cloud Crash Reporter for NDK는 NHN Cloud Logger를 통해 크래시 로그를 전송합니다.
* NHN Cloud Logger와 NHN Cloud Crash Reporter for NDK 라이브러리는 **동일한 버전을 사용하는 것을 권장**합니다.
* NHN Cloud Crash Reporter for NDK는 NHN Cloud Logger 초기화 시에 크래시 감지를 시작합니다.
* NHN Cloud Crash Reporter for NDK를 사용하기 위해서는 **r17c 이상의 NDK**가 필요합니다.

### 사전 준비

1. [NHN Cloud Log & Crash](./log-collector-android)를 설치합니다.

### 라이브러리 설정
- 앱 수준 build.gradle에서 의존성을 추가합니다.

```groovy
repositories {
    mavenCentral()
}

dependencies {
    // ...
    // Add the NHN Cloud Logger dependency
    implementation 'com.nhncloud.android:nhncloud-logger:1.8.1'

    // Add the NHN Cloud Crash Reporter for NDK dependency
    implementation 'com.nhncloud.android:nhncloud-crash-reporter-ndk:1.8.1'
}
```

### 크래시 분석

* Native 크래시가 발생하면 덤프(.dmp) 파일이 생성됩니다.
* 생성된 덤프 파일을 해석하는 과정을 **Symbolication**이라 합니다.
* 정확한 스택 추적을 위해서는 반드시 심볼 파일을 업로드 해야 합니다.
* 심볼 파일이 업로드되면 크래시 발생 시 Log & Crash Search Console에서 분석된 크래시 정보를 확인할 수 있습니다.

#### 심볼 업로드

* 심볼 파일은 Project 특정 경로에 {library name}.so 파일명으로 생성됩니다.
* 업로드 파일의 최대 크기는 500MB입니다.
* {library name}.so을 {library name}.so.zip으로 압축하여 [Log & Crash Search > 설정 > 심벌 파일]에서 업로드 합니다.

#### 심볼 파일 경로

- ndk-build : {PROJECT}/obj/local/{ANDROID_ABI} 하위에 .so 파일이 생성됩니다.
- cmake : {PROJECT}/build/intermediates/{VARIANTS}/obj/{ANDROID_ABI} 하위에 .so 파일이 생성됩니다.
