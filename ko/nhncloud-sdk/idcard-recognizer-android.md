## NHN Cloud > SDK 사용 가이드 > OCR > ID Card (Android)

## 사전 준비

1. [NHN Cloud Console](https://console.nhncloud.com)에서 [AI Service > OCR] 서비스를 활성화합니다.
2. OCR 콘솔에서 AppKey와 SecretKey를 확인합니다.

## 지원 환경

NHN Cloud ID Card Recognizer는 Android 5.1 이상(API level 22 이상)에서 동작합니다.

## 프로젝트 설정

### 의존성 추가

앱의 build.gradle 파일에 nhncloud-idcard-recognizer 의존성을 추가합니다.

```groovy
dependencies {
    ...
    // NHN Cloud ID Card Recognizer
    implementation 'com.nhncloud.android:nhncloud-idcard-recognizer:1.8.1'
}
```

<br>

### CAMERA 권한

ID Card Recognizer를 사용하기 위해서는 **Manifest.permission.CAMERA** 권한이 필요합니다.
ID Card Recognizer를 시작하기 전에 카메라 권한을 획득하세요.

<br>

## Id Card Recognizer 사용

### IdCardRecognizer 인스턴스 생성

ID Card Recognizer 인스턴스를 생성합니다.

```kotlin
val nhnCloudOcr = NhnCloudOcr.newBuilder(context)
        .appKey(APP_KEY)
        .secretKey(SECRET_KEY)
        .build()
val idCardRecognizer = nhnCloudOcr.createIdCardRecognizer()
```

<br>

### IdCardRecognizer 시작하기

IdCardRecognizer의 launch(Activity, IdCardRecognitionCallback) 메서드를 호출하여 신분증 인식을 시작합니다.

```kotlin
IdCardRecognizer.launch(activity) { result, data ->
    if (result.isSuccess) {
        // Success.
    } else {
        // Failure.
    }
}
```

<br>

### 인식 데이터 사용

신분증 인식 성공 시 IdCardData를 상속 구현한 객체로 신분증 인식 데이터가 전달됩니다.
신분증 종류에 따라 주민 등록증은 IdCardResidentData 객체로, 운전 면허증은 IdCardDriverData 객체로 반환됩니다. 

개인정보 보호를 위해 신분증 데이터는 일반 문자열이 아닌 SecureString 객체로 반환됩니다.
SecureString.charAt(index) 메서드는 지정된 index에 있는 문자를 반환합니다.

> IdCardData로 반환되는 신분증 인식 정보를 String 객체로 생성하여 사용하면 보안에 취약합니다.<br>
> 화면에 표시하기 위하여 [SecureTextView 사용](./idcard-recognizer-android/#_18)을 참고하세요.

```kotlin
when (data) {
    //ID card data is a SecureString object.
    is IdCardResidentData -> {
        //Use resident card's data.
        nameSecureTextView.setText(data.name);
        residentNumberSecureTextView.setText(data.residentNumber);
    }
    //Use driver license's data.
    is IdCardDriverData -> {
        ...
    }
}
```

<br>

### 신분증 진위 확인

신분증 진위 확인을 위해서 IdCardAuthenticator 인스턴스를 생성합니다. 
신분증 인식 결과인 IdCardData를 이용해 진위 확인을 요청할 수 있습니다. 

신분증 진위 확인 결과는 Boolean 타입으로 반환됩니다. 

> 진위 확인에 사용되는 IdCardData의 RequestKey는 일회성 값으로 재사용할 수 없습니다.<br>
> RequestKey는 발급 이후 1시간 동안 유효하며 그 이후에는 사용할 수 없습니다.

```kotlin
val authenticator = nhnCloudOcr.createIdCardAuthenticator()
viewModelScope.launch(Dispatchers.IO) {
    try {
        //Use authenticity result
        isAuthenticity = authenticator.authenticate(idCardData)
    } catch (e : OcrException) {
        //Authenticity Error
    }
}
```

authenticateAsync 메서드로 호출을 원할 경우 IdCardAuthenticityCallback을 구현하여 결과를 받을 수 있습니다. 

```kotlin
nhnCloudOcr.createIdCardAuthenticator()
    .authenticateAsync(idCardData) { result, isAuthenticity ->
        if (result.isSuccess) {
            //Use authenticity result
        } else {
            //Authenticity Error
        }
    }
```

<br>

## 신분증 인식 화면 사용자 정의

신분증 인식 화면을 사용자 정의하여 사용할 수 있습니다.
사용자 정의 화면을 구성하려면 IdCardRecognizer 대신 IdCardRecognitionService를 사용해야 합니다.

### IdCardRecognitionService 인스턴스 생성

IdCardRecognitionService 인스턴스를 생성합니다.

```kotlin
val ocrServices = NhnCloudOcrServices.newBuilder(context)
        .appKey(APP_KEY)
        .secretKey(SECRET_KEY)
        .build()
val IdCardRecognitionService = ocrServices.createIdCardRecognitionService()
```

<br>

### IdCardRecognitionService 리스너 등록

setIdCardRecognitionListener() 메서드를 사용하여 리스너를 등록합니다.
신분증이 인식되었을 때 IdCardRecognitionListener를 통해 결과가 통지됩니다.

```kotlin
IdCardRecognitionService.setIdCardRecognitionListener { result, data ->
    if (result.isSuccess) {
        // Recognition success.
        IdCardRecognitionService.stop()
    } else {
        // Recognition failure.
    }
}
```

> 신분증 인식 후 반드시 IdCardRecognitionService.stop()을 호출하여 서비스를 중지해야 합니다.

<br>

### 인식 결과 처리

IdCardRecognitionListener으로 전달되는 IdCardRecognitionData는 신뢰도(confidence rating)와 상관없이 모든 결과를 반환합니다.
따라서 아래와 같이 신뢰도(confidence rating)를 체크하여 보다 정확한 결과를 사용할 수 있습니다.

```kotlin
IdCardRecognitionService.setIdCardRecognitionListener { result, data ->
    if (result.isSuccess && isConfident(data)) {
        // Recognition success.
        IdCardRecognitionService.stop()
    } else {
        // Recognition failure.
    }
}

private fun isConfident(data: IdCardRecognitionData): Boolean {
    //Returns success if the format of the data is correct and all confidences is 0.4 or higher
    when (data) {
        is IdCardResidentRecognitionData -> {
            //Resident number is in "123456-1234567" format.
            val residentNumbers = data.residentNumber.value.split('-')
            if (residentNumbers.size != 2 ||
                residentNumbers[0].length != 6 ||
                residentNumbers[1].length != 7) {
                return false
            }

            //Issued Date is in "yyyy.mm.dd." or "yyyy.mm.dd" format.
            //the month and day can be single digits, such as "yyyy.m.d".
            val dates = data.issueDate.value.split('.')
            if (!(dates.size == 3 || dates.size == 4)) {
                return false
            }

            return data.name.confidence>= 0.4 && 
                    data.residentNumber.confidence >= 0.4 && 
                    data.issueDate.confidence >= 0.4 && 
                    data.issuer.confidence >= 0.4
        }
        is IdCardDriverRecognitionData -> {
            //Resident number is in "123456-1234567" format.
            val residentNumbers = data.residentNumber.value.split('-')
            if (residentNumbers.size != 2 ||
                residentNumbers[0].length != 6 ||
                residentNumbers[1].length != 7) {
                return false
            }

            //driver license number has the format of "12-12-123456-78".
            val driverLicenseNumbers = data.driverLicenseNumber.value.split('-')
            if (driverLicenseNumbers.size != 4 ||
                driverLicenseNumbers[0].length != 2 ||
                driverLicenseNumbers[1].length != 2 ||
                driverLicenseNumbers[2].length != 6 ||
                driverLicenseNumbers[3].length != 2) {
                return false
            }

            //Issued Date is in "yyyy.mm.dd." or "yyyy.mm.dd" format.
            //the month and day can be single digits, such as "yyyy.m.d".
            val dates = data.issueDate.value.split('.')
            if (!(dates.size == 3 || dates.size == 4)) {
                return false
            }

            //The driver type additionally checks the driver license number, serial number, and license type.
            //condition is not checked because there is a case where the value does not exist.
            return data.name.confidence>= 0.4 && 
                    data.residentNumber.confidence >= 0.4 && 
                    data.issueDate.confidence >= 0.4 && 
                    data.issuer.confidence >= 0.4 &&
                    data.driverLicenseNumber.confidence >= 0.4 && 
                    data.licenseType.confidence >= 0.4 && 
                    data.serialNumber.confidence >= 0.4
        }
        else -> error("Invalid data.")
    }
}
```

<br>

### 인식 데이터 사용

신분증 인식 성공 시 IdCardRecognitionData 상속 구현한 객체로 신분증 인식 데이터가 전달됩니다.
신분증 종류에 따라 주민 등록증은 IdCardResidentRecognitionData 객체로, 운전 면허증은 IdCardDriverRecognitionData 객체로 반환됩니다. 

개인정보 보호를 위해 신분증 데이터는 일반 문자열이 아닌 SecureString 객체로 반환됩니다.
SecureString.charAt(index) 메서드는 지정된 index에 있는 문자를 반환합니다.

> IdCardRecognitionData로 반환되는 신분증 인식 정보를 String 객체로 생성하여 사용하면 보안에 취약합니다.<br>
> 화면에 표시하기 위하여 [SecureTextView](./idcard-recognizer-android/#_18)사용을 참고하세요.

```kotlin
when (data) {
    //ID card data is a SecureString object.
    is IdCardResidentRecognitionData -> {
        //Use resident card's data.
        nameSecureTextView.setText(data.name.value);
        residentNumberSecureTextView.setText(data.residentNumber.value);
    }

    is IdCardDriverRecognitionData -> {
        //Use driver license's data.
        ...
    }
}
```

<br>

### 신분증 진위 확인

신분증 진위 확인을 위해서 IdCardAuthenticityService 인스턴스를 생성합니다. 
신분증 인식 결과인 IdCardRecognitionData를 이용해 진위 확인을 요청할 수 있습니다. 

신분증 진위 확인 결과는 Boolean 타입으로 반환됩니다. 

> 진위 확인에 사용되는 IdCardRecognitionData의 RequestKey는 일회성 값으로 재사용할 수 없습니다.<br>
> RequestKey는 발급 이후 1시간 동안 유효하며 그 이후에는 사용할 수 없습니다.

```kotlin
val service = ocrServices.createIdCardAuthenticityService()
viewModelScope.launch(Dispatchers.IO) {
    try {
        //Use authenticity result
        isAuthenticity = service.authenticate(idCardRecognitionData)
    } catch (e : OcrException) {
        //Authenticity Error
    }
}
```

authenticateAsync 메서드로 호출을 원할 경우 IdCardAuthenticityCallback을 구현하여 결과를 받을 수 있습니다. 

```kotlin
ocrServices.createIdCardAuthenticityService()
    .authenticateAsync(idCardRecognitionData) { result, isAuthenticity ->
        if (result.isSuccess) {
            //Use authenticity result
        } else {
            //Authenticity Error
        }
    }
```

<br>

### Camera Preview 구성

Activity 또는 Fragment의 Layout에 아래와 같이 IdCardRecognitionCameraPreview 추가하여 Camera Preview를 구성합니다.

```xml
<androidx.constraintlayout.widget.ConstraintLayout
    xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    xmlns:tools="http://schemas.android.com/tools"
    android:layout_width="match_parent"
    android:layout_height="match_parent">

    <com.nhncloud.android.ocr.idcard.view.IdCardRecognitionCameraPreview
        android:id="@+id/camera_preview"
        android:layout_width="match_parent"
        android:layout_height="match_parent" />

</androidx.constraintlayout.widget.ConstraintLayout>
```

<br>

### 백그라운드 색상 변경

스캔 가이드 영역을 제외한 영역은 반투명하게 보입니다.
이 영역의 색상을 "app:guideBackgroundColor" 속성을 사용하여 설정합니다.

```xml
<com.nhncloud.android.ocr.idcard.view.IdCardRecognitionCameraPreview
    android:id="@+id/camera_preview"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    app:guideBackgroundColor="#33000000" />
```

<br>

### 스캔 가이드 뷰 사용자 정의

스캔 가이드 뷰를 IdCardRecognitionCameraPreview의 하위 뷰로 배치하여 자유롭게 정의할 수 있습니다.
사용자 정의한 가이드 뷰는 "app:guideView" 속성을 사용하여 설정합니다.

> IdCardRecognitionCameraPreview는 ConstraintLayout을 상속 구현되어 있습니다.

스캔 가이드 뷰의 사이즈는 자동으로 조정됩니다.

```xml
<com.nhncloud.android.ocr.idcard.view.IdCardRecognitionCameraPreview
    android:id="@+id/camera_preview"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    app:guideView="@id/guide_view">

    <com.yourapp.view.CustomGuideView
        android:id="@+id/guide_view"
        android:layout_width="0dp"
        android:layout_height="0dp"
        android:layout_marginTop="80dp"
        app:layout_constraintLeft_toLeftOf="parent"
        app:layout_constraintRight_toRightOf="parent">

</com.nhncloud.android.ocr.idcard.view.IdCardRecognitionCameraPreview>
```

<br>

### 신분증 검출 시 가이드 뷰 변경

신분증이 검출되었을 때 스캔 가이드 뷰의 색상 또는 모양을 변경할 수 있습니다.
OcrDetectable 인터페이스를 상속 구현하여 setDetected(Boolean)으로 전달되는 값에 따라 가이드 뷰의 색상 또는 모양을 변경합니다.

```kotlin
class CustomGuideView(
    context: Context, attrs: AttributeSet?
): View(context, attrs), OcrDetectable {
    override fun setDetected(detected: Boolean) {
        if (detected) {
            color = Color.GREEN
        } else {
            color = Color.WHITE
        }
    }
    ...
}
```

<br>

### 서비스 시작

IdCardRecognitionCameraPreview의 인스턴스를 획득하여 IdCardRecognitionService를 시작합니다.

```kotlin
val cameraPreview = findViewById<IdCardRecognitionCameraPreview>(R.id.camera_preview)
try {
    idCardRecognitionService.start(cameraPreview)
} catch (e: IOException) {
    // Camera is not available (in use or does not exist)
}
```

<br>

### 서비스 정지

앱이 백그라운드로 진입 또는 신분증 인식에 성공했을 때 IdCardRecognitionService를 정지합니다.

```kotlin
idCardRecognitionService.stop()
```

<br>

### 서비스 해제

Activity 또는 Fragment의 View가 Destory 되었을 때 IdCardRecognitionService를 해제합니다.

```kotlin
idCardRecognitionService.release();
```

<br>

### IdCardRecognizer Lifecycle 설정

Activity 또는 Fragment의 라이프 사이클에 따라 아래와 같이 호출합니다.

#### Activity

```kotlin
override fun onResume() {
    super.onResume()
    idCardRecognitionService.start(cameraPreview)
}

override fun onPause() {
    super.onPause()
    idCardRecognitionService.stop()
}

override fun onDestroy() {
    super.onDestroy()
    idCardRecognitionService.release()
}
```

#### Fragment

```kotlin
override fun onResume() {
    super.onResume()
    idCardRecognitionService.start(cameraPreview)
}

override fun onPause() {
    super.onPause()
    idCardRecognitionService.stop()
}

override fun onDestroyView() {
    super.onDestroyView()
    idCardRecognitionService.release()
}
```

<br>

### 화면 캡처 방지

화면 캡처 방지를 위해서 Activity의 onCreate()에서 setContentView()가 호출되기 전에 **WindowManager.LayoutParams.FLAG\_SECURE**를 추가합니다.

```kotlin
override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    window.addFlags(WindowManager.LayoutParams.FLAG_SECURE)
    setContentView(R.layout.activity_main)
    ...
}
```

자세한 사항은 [WindowManager.LayoutParams.FLAG\_SECURE](https://developer.android.com/reference/android/view/WindowManager.LayoutParams#FLAG_SECURE)을 참고하세요.

<br>

### 디바이스 체크

ID Card Recognition Service를 시작하기 전에 애플리케이션을 실행하는 기기에서 ID Card Recognition Service를 사용할 수 있는 환경인지 확인할 수 있습니다.
이 검사를 수행하려면 IdCardRecognitionService.isAvailable(Context) 메서드를 사용합니다.

```kotlin
if (IdCardRecognitionService.isAvailable(context)) {
    // ID card recognition service is available.
} else {
    // ID card recognition service is not available.
}
```

<br>

## SecureTextView 사용

개인정보 보호를 위해 신분증 데이터는 일반 문자열이 아닌 SecureString 객체로 반환됩니다.
신분증 인식 정보를 String 객체로 생성하여 사용하면 보안에 취약하며, 데이터를 화면에 표시하기 위해 SecureTextView를 사용할 수 있습니다. 

```xml
<com.nhncloud.android.ocr.SecureTextView
    android:id="@+id/id_card_name_view"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    app:com_nhncloud_text_color="#ffffff"
    app:com_nhncloud_text_size="15sp"
    app:com_nhncloud_text_style="bold"/>
```

SecureTextView의 setText 메서드를 통해 표시할 텍스트를 설정합니다. 
```kotlin
val name = idCardData.name

val idCardNameView = findViewById<SecureTextView>(id_card_name_view)
idCardNameView.setText(name)
```

### SecureTextGroup 사용
여러 줄의 텍스트를 표시해야 한다면 SecureTextGroup을 사용할 수 있습니다. 
```xml
<com.nhncloud.android.ocr.SecureTextGroup
    android:id="@+id/id_card_license_type_view"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    app:com_nhncloud_text_color="#ffffff"
    app:com_nhncloud_text_size="15sp"
    app:com_nhncloud_text_style="bold"
    app:com_nhncloud_letter_spacing="0.3"/>
```

SecureTextGroup의 addTextViews 메서드는 배열을 파라미터로 받아 하나의 요소마다 한 줄의 텍스트로 설정합니다.
```kotlin
//The license type is a SecureString array.
val licenseType = idCardData.idCardLicenseType.split('/')

val idCardLicenseTypeView = findViewById<SecureTextGroup>(id_card_license_type_view)
idCardLicenseTypeView.addTextViews(licenseType)
```


## Class References

### IdCardData

| Method | Returns | Parameters | Descriptions |
| --- | --- | --- | --- |
| getRequestKey | SecureString |  | 신분증 진위 확인에 사용되는 RequestKey를 반환합니다.  |
| getIdType | String |  | 신분증 종류를 반환합니다. ("resident" or "driver") |

<br>

### IdCardResidentData

| Method | Returns | Parameters | Descriptions |
| --- | --- | --- | --- |
| getName | SecureString |  | 이름을 반환합니다. |
| getResidentNumber | SecureString |  | 주민등록번호를 반환합니다. |
| getIssueDate | SecureString |  | 발급 일자를 반환합니다. |
| getIssuer | SecureString |  | 발급 기관을 반환합니다. |

<br>

### IdCardDriverData

| Method | Returns | Parameters | Descriptions |
| --- | --- | --- | --- |
| getName | SecureString |  | 이름을 반환합니다. |
| getResidentNumber | SecureString |  | 주민등록번호를 반환합니다. |
| getIssueDate | SecureString |  | 발급 일자를 반환합니다. |
| getIssuer | SecureString |  | 발급 기관을 반환합니다. |
| getDriverLicenseNumber | SecureString |  | 운전 면허 번호를 반환합니다. |
| getLicenseType | SecureString |  | 면허 종류를 반환합니다.<br>면허 종류가 2개 이상일 경우 문자열 내 "/"로 구분됩니다. |
| getCondition | SecureString |  | 면허 조건을 반환합니다.<br>운전 면허증에 따라 해당 값이 존재하지 않으면 공백으로 반환됩니다. |
| getSerialNumber | SecureString |  | 암호 일련 번호를 반환합니다. |

<br>


### IdCardRecognitionData

| Method | Returns | Parameters | Descriptions |
| --- | --- | --- | --- |
| getOriginBitmap | Bitmap |  | 원본 이미지를 반환합니다. |
| getDetectedBitmap | Bitmap |  | 검출된 이미지를 반환합니다.<br>(가이드 영역의 이미지가 반환됩니다.) |
| getResolution | String |  | 해상도 정보를 반환합니다.<br>(권장 해상도 이상이면 normal, 미만은 low) |
| getRequestKey | String |  | 신분증 진위 확인에 사용되는 RequestKey를 반환합니다.  |
| getIdType | String |  | 신분증 종류를 반환합니다. ("resident" or "driver") |
| getOriginJsonData | String |  | 서버 응답 결과를 반환합니다. |

<br>

### IdCardRecognitionData.IdCardValue

| Method | Returns | Parameters | Descriptions |
| --- | --- | --- | --- |
| getValue | SecureString |  | 신분증 인식 결과를 반환합니다. |
| getConfidence | String |  | 신분증 인식 결과의 신뢰도를 반환합니다. |

<br>

### IdCardResidentRecognitionData

| Method | Returns | Parameters | Descriptions |
| --- | --- | --- | --- |
| getName | IdCardValue |  | 이름을 반환합니다. |
| getResidentNumber | IdCardValue |  | 주민등록번호를 반환합니다. |
| getIssueDate | IdCardValue |  | 발급 일자를 반환합니다. |
| getIssuer | IdCardValue |  | 발급 기관을 반환합니다. |

<br>

### IdCardDriverRecognitionData

| Method | Returns | Parameters | Descriptions |
| --- | --- | --- | --- |
| getName | IdCardValue |  | 이름을 반환합니다. |
| getResidentNumber | IdCardValue |  | 주민등록번호를 반환합니다. |
| getIssueDate | IdCardValue |  | 발급 일자를 반환합니다. |
| getIssuer | IdCardValue |  | 발급 기관을 반환합니다. |
| getDriverLicenseNumber | IdCardValue |  | 운전 면허 번호를 반환합니다. |
| getLicenseType | IdCardValue |  | 면허 종류를 반환합니다.<br>면허 종류가 2개 이상일 경우 문자열 내 "/"로 구분됩니다. |
| getCondition | IdCardValue |  | 면허 조건을 반환합니다.<br>운전 면허증에 따라 해당 값이 존재하지 않으면 공백으로 반환됩니다. |
| getSerialNumber | IdCardValue |  | 암호 일련 번호를 반환합니다. |

<br>

### SecureTextView

| Method | Returns | Parameters | Descriptions |
| --- | --- | --- | --- |
| setText |  | SecureString | SecureTextView에 표시할 텍스트를 설정합니다.  |
| setTextSize | float |  | 텍스트 크기를 설정합니다. <br>크기 단위는 sp, 기본 설정은 14sp입니다. |
| setTextColor | int |  | 텍스트 색상을 설정합니다. <br>기본 설정은 Color.Black(0xFF000000)입니다. |
| setTypefaceStyle | Typeface, int |  | 텍스트 서체와 스타일을 설정합니다. <br>기본 스타일 설정은 Typeface.NORMAL입니다.|

<br>

### SecureTextGroup

| Method | Returns | Parameters | Descriptions |
| --- | --- | --- | --- |
| addTextView |  | SecureString | SecureTextGroup에 표시할 텍스트를 추가합니다.  |
| addTextViews |  | SecureString[] | SecureTextGroup에 표시할 텍스트를 추가합니다.  |
| setTextSize | float |  | 텍스트 크기를 설정합니다. <br>크기 단위는 sp, 기본 설정은 14sp입니다. |
| setTextColor | int |  | 텍스트 색상을 설정합니다. <br>기본 설정은 Color.Black(0xFF000000)입니다. |
| setTypefaceStyle | Typeface, int |  | 텍스트 서체와 스타일을 설정합니다. <br>기본 스타일 설정은 Typeface.NORMAL입니다.|
| setLetterSpacing | float | | 텍스트의 문자 간격을 설정합니다. <br>기본 설정은 0em입니다. 


<br>