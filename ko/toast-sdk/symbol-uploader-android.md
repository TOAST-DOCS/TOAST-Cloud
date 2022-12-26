## NHN Cloud > SDK 사용 가이드 > Log & Crash > Android (Symbol Uploader)

## 사전 준비

1. Android 프로젝트에 [NHN Cloud Logger 를 추가](https://nhncloud.com/ko/TOAST/ko/toast-sdk/log-collector-android/) 합니다.
2. Android 앱에 네이티브 라이브러리가 포함되어 있는 경우 [NHN Cloud Crash Reporter for NDK 를 추가](https://nhncloud.com/ko/TOAST/ko/toast-sdk/log-collector-ndk/) 합니다.

## 라이브러리 설정

프로젝트 수준의 build.gradle 파일에 NHN Cloud Gradle Plugin 을 buildscript 의존성 항목으로 추가합니다.

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

앱 수준의 build.gradle 파일에 NHN Cloud Gradle Plugin 을 적용합니다.

```groovy
// Apply the NHN Cloud Gradle Plugin
apply plugin: 'com.toast.android.toast-services'
```

## mapping.txt 파일 업로드 사용 설정

ProGuard, R8로 코드 난독화가 되어있는 스택 트레이스를 사람이 읽을 수 있는 명료한 코드로 렌더링하기 위해서는 빌드 시 생성된 매핑 파일을 NHN Cloud Log & Crash Search 에 업로드해야합니다.
NHN Cloud Gradle Plugin 에는 매핑 파일 업로드를 자동화하는 `uploadMappingFile{BUILD_VARIANT}` 태스크가 포함되어 있습니다. 이 태스크를 활성화하려면 `mappingFileUploadEnabled` 가 `true` 로 설정되어 있는지 확인합니다.


매핑 파일 업로드 태스크를 활성화 하려면 앱 수준의 build.gradle 파일에서 `mappingFileUploadEnabled` 를 `true` 로 설정합니다.

```groovy
toastServices {
    crashReporter {
        appKey "appKey"
        mappingFileUploadEnabled true
    }
}
```

## Native symbol 파일 업로드 사용 설정

NDK 비정상 종료로 부터 읽기 가능한 스택 트레이스를 생성하려면 NHN Cloud Log & Crash Search 에서 네이티브 바이너리의 심벌에 대해 파악해야합니다.
NHN Cloud Gradle Plugin 에는 네이티브 심벌 파일 업로드를 자동화하는 `uploadSymbolFile{BUILD_VARIANT}` 태스크가 포함되어 있습니다.
이 태스크를 활성화하려면 `nativeSymbolUploadEnabled` 가 `true` 로 설정되어 있는지 확인합니다.

심 파일 업로드 태스크를 활성화 하려면 앱 수준의 build.gradle 파일에서 `nativeSymbolUploadEnabled` 를 `true` 로 설정합니다.

```groovy
toastServices {
    crashReporter {
        appKey "appKey"
        nativeSymbolUploadEnabled true
    }
}
```

## 빌드 변형 구성

Build Types 또는 Product Flavors, Variants 구성에 따라 앱키 및 업로드 활성화 여부를 설정할 수 있습니다.

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

## 파일 업로드 태스크 실행

매핑 파일 또는 네이티브 심벌 파일을 NHN Cloud Log & Crash Search 에 업로드하기 위해서는 업로드 태스크를 명시적으로 호출해야 합니다.
예를 들면 다음과 같습니다.

```
> ./gradlew app:assemble{BUILD_VARIANT}
            app:uploadMappingFile{BUILD_VARIANT}
            app:uploadSymbolFile{BUILD_VARIANT}
```
