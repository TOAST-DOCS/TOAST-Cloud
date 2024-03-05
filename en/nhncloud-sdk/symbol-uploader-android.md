## NHN Cloud > SDK User Guide > Log & Crash > Android (Symbol Uploader)

## Prerequisites

1. [Add NHN Cloud Logger](https://nhncloud.com/en/TOAST/en/toast-sdk/log-collector-android/) to your Android project.
2. If your Android app includes native libraries, [add NHN Cloud Crash Reporter for NDK](https://nhncloud.com/en/TOAST/en/toast-sdk/log-collector-ndk/).

## Library Setting

Add the NHN Cloud Gradle Plugin as a buildscript dependency to your project-level build.gradle file.

```groovy
buildscript {
    repositories {
        mavenCentral()
    }

    dependencies {
        // ...

        // Add the NHN Cloud Gradle Plugin
        classpath "com.toast.android:toast-gradle-plugin:0.0.1"
    }
}
```

Apply the TOAST Gradle Plugin to your app-level build.gradle file.

```groovy
// Apply the TOAST Gradle Plugin
apply plugin: 'com.toast.android.toast-services'
```

## Enable mapping.txt File Upload

To render the stack trace obfuscated with ProGuard and R8 into clear human-readable code, the mapping file generated at build time must be uploaded to TOAST Log & Crash Search.
TOAST Gradle Plugin includes an `uploadMappingFile{BUILD_VARIANT}` task to automate uploading of the mapping file.  To enable this task, make sure `mappingFileUploadEnabled` is set to `true`.


To enable the mapping file upload task, set `mappingFileUploadEnabled` to `true` in your app-level build.gradle file.

```groovy
toastServices {
    crashReporter {
        appKey "appKey"
        mappingFileUploadEnabled true
    }
}
```

## Enable Native Symbol File Upload

To generate readable stack trace from NDK crashes, NHN Cloud Log & Crash Search needs to know the symbols of native binaries.
NHN Cloud Gradle Plugin includes an `uploadSymbolFile{BUILD_VARIANT}` task to automate uploading of native symbol files.
To enable this task, make sure `nativeSymbolUploadEnabled` is set to `true`.

To enable the symbol file upload task, set `nativeSymbolUploadEnabled` to `true` in your app-level build.gradle file.

```groovy
toastServices {
    crashReporter {
        appKey "appKey"
        nativeSymbolUploadEnabled true
    }
}
```

## Configure Build Variants

You can set whether to enable Appkey and upload according to Build Types, Product Flavors, or Variants configuration.

```groovy
toastServices {
    crashReporter {
        buildTypes {
            debug {
            }
            release {
                mappingFileUploadEnabled true
                nativeSymbolUploadEnabled false
            }
        }
        productFlavors {
            alpha {
                appKey "alphaAppKey"
                serviceZone "ALPHA"
            }
            real {
                appKey "realAppKey"
                serviceZone "REAL"
            }
            staging {
            }
            prod {
            }
        }
        variants {
            realProdRelease.nativeSymbolUploadEnabled = true
        }
    }
}
```

## Execute the File Upload Task

To upload a mapping file or native symbol file to NHN Cloud Log & Crash Search, you must explicitly call the upload task.
For example:

```
> ./gradlew app:assemble{BUILD_VARIANT}
            app:uploadMappingFile{BUILD_VARIANT}
            app:uploadSymbolFile{BUILD_VARIANT}
```
