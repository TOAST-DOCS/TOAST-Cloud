## NHN Cloud > SDK User Guide > Log & Crash > Android (NDK)

## Android NDK Crash Report

If your Android app includes native libraries, a simple build setup will enable full stack traces and detailed error reports for native code.

* NHN Cloud Crash Reporter for NDK is available on **NHN Cloud 0.21.0 and higher**.
* NHN Cloud Crash Reporter for NDK sends crash logs through NHN Cloud Logger.
* It is recommended that you **use the same version** of NHN Cloud Logger and NHN Cloud Crash Reporter for NDK libraries.
* NHN Cloud Crash Reporter for NDK starts crash detection at NHN Cloud Logger initialization.
* NHN Cloud Crash Reporter for NDK requires **NDK r17c or higher**.

### Prerequisites

1. Install [NHN Cloud Log & Crash](./log-collector-android).

### Library Setting
- Add dependencies in the app-level build.gradle.

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

### Crash Analysis

* When native crash occurs, dump (.dmp) file is generated.
* The process of interpreting the generated dump file is called **Symbolication**.
* You must upload a symbol file for an accurate stack trace.
* When the symbol file is uploaded, you can check the crash information analyzed in Log & Crash Search Console when a crash occurs.

#### Symbol Upload

* A symbol file is generated as a {library name}.so file in the project's specific path.
* The maximum size of the upload file is 500 MB.
* Compress {library name}.so into {library name}.so.zip and upload it from [Log & Crash Search > Settings > Symbol File].

#### Symbol File Path

- ndk-build: .so file is generated under {PROJECT}/obj/local/{ANDROID_ABI}.
- cmake: .so file is generated under {PROJECT}/build/intermediates/{VARIANTS}/obj/{ANDROID_ABI}.
