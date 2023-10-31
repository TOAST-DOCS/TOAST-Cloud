## NHN Cloud > SDK User Guide > OCR > ID Card (Android)

## Prerequisites

1. Enable [AI Service > OCR ] in[NHN Cloud Console](https://console.nhncloud.com).
2. Check Appkey and SecretKey in the OCR console.

## Supported Environment

NHN Cloud ID Card Recognizer operates in Android 5.1 or higher (API level 22 or higher).

## Set up Project

### Add Dependency

Add dependencies of nhncloud-idcard-recognizer to the build.gradle file of the app.

```groovy
dependencies {
    ...
    // NHN Cloud ID Card Recognizer
    implementation 'com.nhncloud.android:nhncloud-idcard-recognizer:1.8.1'
}
```

<br>

### Camera Permission

To use ID Card Recognizer, the permission **Manifest.permission.CAMERA** is required. You must obtain the Camera permission before using ID Card Recognizer.

<br>

## Use ID Card Recognizer

### Create IdCardRecognizer instance

Create an ID Card Recognizer instance.

```kotlin
val nhnCloudOcr = NhnCloudOcr.newBuilder(context)
        .appKey(APP_KEY)
        .secretKey(SECRET_KEY)
        .build()
val idCardRecognizer = nhnCloudOcr.createIdCardRecognizer()
```

<br>

### Get started with CreditCardRecognizer

Initiate ID card recognition by calling the IdCardRecognizer's launch (Activity, IdCardRecognitionCallback) method.

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

### Use Recognition Data

When ID recognition is successful, ID recognition data is passed to an object that inherits and implements IdCardData.
Depending on the ID type, a social security card is returned as an IdCardResidentData object, and a driver's license is returned as an IdCardDriverData object. 

For privacy reasons, ID data is returned as a SecureString object rather than a plain string.
The SecureString.charAt(index) method returns the character at the specified index.

> It is vulnerable to security when you create and use the ID card recognition data that is returned as IdCardData as a String object.<br>
> See [](./idcard-recognizer-android/#_18)Use SecureTextView[](./idcard-recognizer-android/#_18) to display on screen.

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

### Verify ID card authenticity

Create an IdCardAuthenticator instance to verify the authenticity of an ID.
You can request authenticity verification using IdCardData, which is the identification result. 

The ID verification result is returned as a Boolean type. 

> IdCardData's RequestKey used for authenticity verification is a one-time value and cannot be reused.<br>
> Request-Key is valid for 1 hour after issuance and cannot be used after that.

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

If you want to make a call with the authenticateAsync method, you can implement IdCardAuthenticityCallback to receive the result. 

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

## Customize ID recognition screen

You can customize and use the ID card recognition screen.
You must use IdCardRecognitionService instead of IdCardRecognizer to configure your custom screen.

### Create IdCardRecognitionService Instance

Create an IdCardRecognitionService instance.

```kotlin
val ocrServices = NhnCloudOcrServices.newBuilder(context)
        .appKey(APP_KEY)
        .secretKey(SECRET_KEY)
        .build()
val IdCardRecognitionService = ocrServices.createIdCardRecognitionService()
```

<br>

### Register IdCardRecognitionService Listner

Register a listener using the setIdCardRecognitionListener() method.
When an ID card is recognized, the result is notified via the IdCardRecognitionListener.

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

> You must stop the service by calling the IdCardRecognitionService.stop() after ID card recognition.

<br>

### Process Recognition Result

IdCardRecognitionData passed to IdCardRecognitionListener will return all results regardless of confidence rating.
Therefore, more accurate results can be used by checking the confidence rating as shown below.

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

### Use Recognition Data

When ID recognition is successful, ID recognition data is passed to an object implementing IdCardRecognitionData inheritance.
Depending on the ID type, a social security card is returned as an IdCardResidentRecognitionData object, and a driver's license is returned as an IdCardDriverRecognitionData object. 

For privacy reasons, ID data is returned as a SecureString object rather than a plain string.
The SecureString.charAt(index) method returns the character at the specified index.

> It is vulnerable to security when you create and use the ID card recognition data that is returned as IdCardRecognitionData as a String object.<br>
> See [](./idcard-recognizer-android/#_18)Use SecureTextView[](./idcard-recognizer-android/#_18) to display on screen.

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

### Verify ID card authenticity

Create an IdCardAuthenticityService instance to verify the authenticity of an ID card.
You can request authenticity verification using IdCardRecognitionData, which is the ID recognition result. 

The ID verification result is returned as a Boolean type. 

> The RequestKey of IdCardRecognitionData used for authenticity verification is a one-time value and is not reusable.<br>
> Request-Key is valid for 1 hour after issuance and cannot be used after that.

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

If you want to make a call with the authenticateAsync method, you can implement IdCardAuthenticityCallback to receive the result. 

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

### Configure Camera Preview

Add IdCardRecognitionCameraPreview to Activity or Layout of Fragment as follows to configure Camera Preview.

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

### Change Background Color

Areas except for the scan guide area appear translucent.
Configure their colors using the "app:guideBackgroundColor" property.

```xml
<com.nhncloud.android.ocr.idcard.view.IdCardRecognitionCameraPreview
    android:id="@+id/camera_preview"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    app:guideBackgroundColor="#33000000" />
```

<br>

### User-defined Scan Guide View

You can freely define the scan guide view by placing it as a subview of the IdCardRecognitionCameraPreview. Configure the user-defined guide view using the "app:guideView" property.

> IdCardRecognitionCameraPreview is implemented by inheriting ConstraintLayout.

The size of the scan guide view is automatically adjusted.

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

### Change Guide View When ID Card Is Detected

You can change the color or shape of the scan guide view when an ID card is detected.
Change the color or shape of the guide view according to the value passed to setDetected(Boolean) after implementation inheritance of the OcrDetectable interface.

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

### Start Service

Start IdCardRecognitionService by obtaining the instances of IdCardRecognitionCameraPreview.

```kotlin
val cameraPreview = findViewById<IdCardRecognitionCameraPreview>(R.id.camera_preview)
try {
    idCardRecognitionService.start(cameraPreview)
} catch (e: IOException) {
    // Camera is not available (in use or does not exist)
}
```

<br>

### Stop Service

Stop IdCardRecognitionService when the app enters the background or ID card recognition is successful.

```kotlin
idCardRecognitionService.stop()
```

<br>

### Release Service

Release IdCardRecognitionService when Activity or Fragment's View is destroyed.

```kotlin
idCardRecognitionService.release();
```

<br>

### Set IdCardRecognizer Lifecycle

Call as follows according to Activity or the lifecycle of Fragment.

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

### Prevent Screen Capture

To prevent screen capture, add **WindowManager.LayoutParams.FLAG_SECURE** before setContentView() is called from onCreate() of Activity.

```kotlin
override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    window.addFlags(WindowManager.LayoutParams.FLAG_SECURE)
    setContentView(R.layout.activity_main)
    ...
}
```

For more details, see [WindowManager.LayoutParams.FLAG_SECURE](https://developer.android.com/reference/android/view/WindowManager.LayoutParams#FLAG_SECURE).

<br>

### Device Check

Before starting the ID Card Recognition service, you can check whether the ID Card Recognition service is available is on the device running the application.
To perform this check, use the IdCardRecognitionService.isAvailable(Context) method.

```kotlin
if (IdCardRecognitionService.isAvailable(context)) {
    // ID card recognition service is available.
} else {
    // ID card recognition service is not available.
}
```

<br>

## Use SecureTextView

For privacy reasons, ID data is returned as a SecureString object rather than a plain string.
If ID recognition information is created and used as a String object, security is vulnerable, and SecureTextView can be used to display the data on the screen. 

```xml
<com.nhncloud.android.ocr.SecureTextView
    android:id="@+id/id_card_name_view"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    app:com_nhncloud_text_color="#ffffff"
    app:com_nhncloud_text_size="15sp"
    app:com_nhncloud_text_style="bold"/>
```

Set the text to be displayed via the setText method of SecureTextView. 
```kotlin
val name = idCardData.name

val idCardNameView = findViewById<SecureTextView>(id_card_name_view)
idCardNameView.setText(name)
```

### Use SecureTextGroup
If you need to display multiple lines of text, you can use SecureTextGroup. 
```xml
<com.nhncloud.android.ocr.SecureTextGroup
    android:id="@+id/id_card_license_type_view"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    app:com_nhncloud_text_color="#ffffff"
    app:com_nhncloud_text_size="15sp"
    app:com_nhncloud_text_style="bold"/>
```

SecureTextGroup's addTextViews method takes an array as a parameter and sets each element to one line of text.
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
| getRequestKey | SecureString |  | Return the RequestKey used to verify the authenticity of the ID.  |
| getIdType | String |  | Return the ID type. ("resident" or "driver") |

<br>

### IdCardResidentData

| Method | Returns | Parameters | Descriptions |
| --- | --- | --- | --- |
| getName | SecureString |  | Return the name. |
| getResidentNumber | SecureString |  | Return the resident registration number. |
| getIssueDate | SecureString |  | Return the issue date. |
| getIssuer | SecureString |  | Return the issuer. |

<br>

### IdCardDriverData

| Method | Returns | Parameters | Descriptions |
| --- | --- | --- | --- |
| getName | SecureString |  | Return the name. |
| getResidentNumber | SecureString |  | Return the resident registration number. |
| getIssueDate | SecureString |  | Return the issue date. |
| getIssuer | SecureString |  | Return the issuer. |
| getDriverLicenseNumber | SecureString |  | Return the driver's license number. |
| getLicenseType | SecureString |  | Return the license type.<br>If there are two or more license types, they are separated by "/" within the string. |
| getCondition | SecureString |  | Return the license conditions.<br>Depending on your driver's license, if that value doesn't exist, it will return blank. |
| getSerialNumber | SecureString |  | Return the password sequence number. |

<br>


### IdCardRecognitionData

| Method | Returns | Parameters | Descriptions |
| --- | --- | --- | --- |
| getOriginBitmap | Bitmap |  | Return the original image. |
| getDetectedBitmap | Bitmap |  | Return the detected image.<br>(The image of the guide area is returned.) |
| getResolution | String |  | Return the resolution information.<br>(Normal when over the recommended resolution, low when below the recommended resolution) |
| getRequestKey | String |  | Return the RequestKey used to verify the authenticity of the ID.  |
| getIdType | String |  | Return the ID type. ("resident" or "driver") |
| getOriginJsonData | String |  | Return the server response result. |

<br>

### IdCardRecognitionData.IdCardValue

| Method | Returns | Parameters | Descriptions |
| --- | --- | --- | --- |
| getValue | SecureString |  | Return the ID recognition result. |
| getConfidence | String |  | Return the confidence of ID card recognition results. |

<br>

### IdCardResidentRecognitionData

| Method | Returns | Parameters | Descriptions |
| --- | --- | --- | --- |
| getName | IdCardValue |  | Return the name. |
| getResidentNumber | IdCardValue |  | Return the resident registration number. |
| getIssueDate | IdCardValue |  | Return the issue date. |
| getIssuer | IdCardValue |  | Return the issuer. |

<br>

### IdCardDriverRecognitionData

| Method | Returns | Parameters | Descriptions |
| --- | --- | --- | --- |
| getName | IdCardValue |  | Return the name. |
| getResidentNumber | IdCardValue |  | Return the resident registration number. |
| getIssueDate | IdCardValue |  | Return the issue date. |
| getIssuer | IdCardValue |  | Return the issuer. |
| getDriverLicenseNumber | IdCardValue |  | Return the driver's license number. |
| getLicenseType | IdCardValue |  | Return the license type.<br>If there are two or more license types, they are separated by "/" within the string. |
| getCondition | IdCardValue |  | Return the license conditions.<br>Depending on your driver's license, if that value doesn't exist, it will return blank. |
| getSerialNumber | IdCardValue |  | Return the password sequence number. |

<br>

### SecureTextView

| Method | Returns | Parameters | Descriptions |
| --- | --- | --- | --- |
| setText |  | SecureString | Set the text to be displayed in SecureTextView.  |
| setTextSize | float |  | Set the text size. <br>The size unit is sp and defaults to 14sp. |
| setTextColor | int |  | Set the text color. <br>The default setting is Color.Black (0xFF000000). |
| setTypefaceStyle | Typeface, int |  | Set the text font and style. <br>The default style setting is Typeface.NORMAL.|

<br>

### SecureTextGroup

| Method | Returns | Parameters | Descriptions |
| --- | --- | --- | --- |
| addTextView |  | SecureString | Add text to be displayed in the SecureTextGroup.  |
| addTextViews |  | SecureString[] | Add text to be displayed in the SecureTextGroup.  |
| setTextSize | float |  | Set the text size. <br>The size unit is sp and defaults to 14sp. |
| setTextColor | int |  | Set the text color. <br>The default setting is Color.Black (0xFF000000). |
| setTypefaceStyle | Typeface, int |  | Set the text font and style. <br>The default style setting is Typeface.NORMAL.|
| setLetterSpacing | float | | 텍스트의 문자 간격을 설정합니다. <br>기본 설정은 0em입니다. 

<br>