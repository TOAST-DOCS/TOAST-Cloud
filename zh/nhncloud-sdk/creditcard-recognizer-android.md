## NHN Cloud > SDK User Guide > OCR > Credit Card (Android)

## Prerequisites

1. Enable [AI Service > OCR] in [NHN Cloud Console](https://console.nhncloud.com)
2. Check Appkey and SecretKey in OCR Console.

## Supported Environment

NHN Cloud Credit Card Recognizer operates in Android 5.1 or higher (API level 22 or higher).

## Set up Project

### Add Dependency

Add dependencies of nhncloud-creditcard-recognizer to the build.gradle file of the app.

```groovy
dependencies {
    ...
    // NHN Cloud Credit Card Recognizer
    implementation 'com.nhncloud.android:nhncloud-creditcard-recognizer:1.8.1'
}
```

<br>

### CAMERA Permission

To use Credit Card Recognizer, the permission **Manifest.permission.CAMERA** is required. 
You must obtain the Camera permission before using Credit Card Recognizer.

<br>

## Use Credit Card Recognizer

### Create CreditCardRecognizer Instance

Create a Credit Card Recognizer instance.

```kotlin
val creditCardRecognizer = NhnCloudOcr.newBuilder(context)
        .appKey(APP_KEY)
        .secretKey(SECRET_KEY)
        .createCreditCardRecognizer()
```

<br>

### Initiate CreditCardRecognizer

Initiate credit card recognition by calling the CreditCardRecognizer's launch(Activity, CreditCardRecognitionCallback) method.

```kotlin
creditCardRecognizer.launch(activity) { result, data ->
    if (result.isSuccess) {
        // Success.
    } else {
        // Failure.
    }
}
```

<br>

### Use Recognition Data

When credit card recognition is successful, credit card recognition data is transferred to the CreditCardData object.
For privacy protection, the credit card number and expiration date are returned as SecureString objects, not plain strings.
The SecureString.charAt(index) method returns the character at the specified index.

> It is vulnerable to security when you create and use the credit card recognition data that is returned as CreditCardData as a String object.

```kotlin
val cardNumbers = creditCardData.cardNumbers
// firstNumber is a SecureString object.
val firstNumber = cardNumbers[0]
firstNumberTextView1.text = if (firstNumber.isNotEmpty()) firstNumber[0].toString() else ""
firstNumberTextView2.text = if (firstNumber.length > 1) firstNumber[1].toString() else ""
firstNumberTextView4.text = if (firstNumber.length > 2) firstNumber[2].toString() else ""
firstNumberTextView3.text = if (firstNumber.length > 3) firstNumber[3].toString() else ""
```

<br>

## Customize Credit Card Recognition Screen

You can customize and use the credit card recognition screen.
You must use CreditCardRecognitionService instead of CreditCardRecognizer to configure your custom screen.

### Create CreditCardRecognitionService Instance

Create a CreditCardRecognitionService instance.

```kotlin
val creditCardRecognitionService = NhnCloudOcrServices.newBuilder(context)
        .appKey(APP_KEY)
        .secretKey(SECRET_KEY)
        .createCreditCardRecognitionService()
```

<br>

### Register CreditCardRecognitionService Listner

Register a listener using the setCreditCardRecognitionListener() method.
When a credit card is recognized, the result is notified via the CreditCardRecognitionListener.

```kotlin
creditCardRecognitionService.setCreditCardRecognitionListener { result, data ->
    if (result.isSuccess) {
        // Recognition success.
        creditCardRecognitionService.stop()
    } else {
        // Recognition failure.
    }
}
```

> You must stop the service by calling the creditCardRecognitionService.stop() after credit card recognition.

<br>

### Process Recognition Result

CreditCardRecognitionData passed to CreditCardRecognitionListener will return all results regardless of confidence rating.
Therefore, more accurate results can be used by checking the confidence rating as shown below.

```kotlin
creditCardRecognitionService.setCreditCardRecognitionListener { result, data ->
    if (result.isSuccess && isConfident(data)) {
        // Recognition success.
        creditCardRecognitionService.stop()
    } else {
    }
}

private fun isConfident(data: CreditCardRecognitionData): Boolean {
    // Returns success if the number of card numbers is greater than or equal to 3
    // and the confidence is greater than or equal to 0.4.
    // American Express is in the format 1234-123456-12345.
    with (data.cardNumbers) {
        if (size < 3) {
            return false
        }
        for (cardNumber in this) {
            if (cardNumber.confidence < 0.4) {
                return false
            }
        }
    }
    return true
}
```

<br>

### Use Recognition Data

When credit card recognition is successful, credit card recognition data is transferred to the CreditCardRecognitionData object.
For privacy protection, the credit card number and expiration date are returned as SecureString objects, not plain strings.
The SecureString.charAt(index) method returns the character at the specified index.

> It is vulnerable to security when you create and use the credit card recognition data that is returned as CreditCardRecognitionData as a String object.

```kotlin
val cardNumbers = creditCardData.cardNumbers
// firstCardNumber is a SecureString object.
val firstNumber = cardNumbers[0].value
firstNumberTextView1.text = if (firstNumber.isNotEmpty()) firstNumber[0].toString() else ""
firstNumberTextView2.text = if (firstNumber.length > 1) firstNumber[1].toString() else ""
firstNumberTextView4.text = if (firstNumber.length > 2) firstNumber[2].toString() else ""
firstNumberTextView3.text = if (firstNumber.length > 3) firstNumber[3].toString() else ""
```

<br>

### Configure Camera Preview

Add CreditCardRecognitionCameraPreview to Activity or Layout of Fragment as follows to configure Camera Preview.

```xml
<androidx.constraintlayout.widget.ConstraintLayout
    xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    xmlns:tools="http://schemas.android.com/tools"
    android:layout_width="match_parent"
    android:layout_height="match_parent">

    <com.nhncloud.android.ocr.creditcard.view.CreditCardRecognitionCameraPreview
        android:id="@+id/camera_preview"
        android:layout_width="match_parent"
        android:layout_height="match_parent" />

</androidx.constraintlayout.widget.ConstraintLayout>
```

<br>

### Change Background Color

Areas except for the scan guide area appear translucent.
Set the colors of the areas by using the "app:guideBackgroundColor" property.

```xml
<com.nhncloud.android.ocr.creditcard.view.CreditCardRecognitionCameraPreview
    android:id="@+id/camera_preview"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    app:guideBackgroundColor="#33000000" />
```

<br>

### Customize Scan Guide View

You can freely customize the scan guide view by placing it as a subview of the CreditCardRecognitionCameraPreview. 
Configure the user-defined guide view using the "app:guideView" property.

> CreditCardRecognitionCameraPreview is implemented by inheriting ConstraintLayout.

The size of the scan guide view is automatically adjusted.

```xml
<com.nhncloud.android.ocr.creditcard.view.CreditCardRecognitionCameraPreview
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

</com.nhncloud.android.ocr.creditcard.view.CreditCardRecognitionCameraPreview>
```

<br>

### Change Guide View When Credit Card Is Detected

You can change the color or shape of the scan guide view when a credit card is detected.
Change the color or shape of the guide view according to the value passed to setDetected(Boolean) after implementation inheritance of the CreditCardDetectable interface.


```kotlin
class CustomGuideView(
    context: Context, attrs: AttributeSet?
): View(context, attrs), CreditCardDetectable {
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

### Initiate Service

Initiate CreditCardRecognitionService by obtaining the instances of CreditCardRecognitionCameraPreview.

```kotlin
val cameraPreview = findViewById<CreditCardRecognitionCameraPreview>(R.id.camera_preview)
try {
    creditCardRecognitionService.start(cameraPreview)
} catch (e: IOException) {
    // Camera is not available (in use or does not exist)
}
```

<br>

### Stop Service

Stop creditCardRecognitionService when the app enters the background or credit card recognition is successful.

```kotlin
creditCardRecognitionService.stop()
```

<br>

### Release Service

Release creditCardRecognitionService when Activity or Fragment's View is destroyed.

```kotlin
creditCardRecognitionService.release();
```

<br>

### Set CreditCardRecognizer Lifecycle

 Call as follows according to Activity or the lifecycle of Fragment.

#### Activity

```kotlin
override fun onResume() {
    super.onResume()
    creditCardRecognitionService.start(cameraPreview)
}

override fun onPause() {
    super.onPause()
    creditCardRecognitionService.stop()
}

override fun onDestroy() {
    super.onDestroy()
    creditCardRecognitionService.release()
}
```

#### Fragment

```kotlin
override fun onResume() {
    super.onResume()
    creditCardRecognitionService.start(cameraPreview)
}

override fun onPause() {
    super.onPause()
    creditCardRecognitionService.stop()
}

override fun onDestroyView() {
    super.onDestroyView()
    creditCardRecognitionService.release()
}
```

<br>

### Set Scan Direction

Set a direction to scan the credit card.

```kotlin
creditCardRecognitionService.scanOrientation =
    CreditCardScanOrientation.HORIZONTAL // or CreditCardScanOrientation.HORIZONTAL
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

Before starting the Credit Card Recognition service, you can check whether the Credit Card Recognition service is available is on the device running the application.
To perform this check, use the CreditCardRecognitionService.isAvailable(Context) method.

```kotlin
if (CreditCardRecognitionService.isAvailable(context)) {
    // Credit card recognition service is available.
} else {
    // Credit card recognition service is not available.
}
```

<br>

## Use SecureTextView

For privacy reasons, credit card is returned as a SecureString object rather than a plain string.
If credit card recognition information is created and used as a String object, security is vulnerable, and SecureTextView can be used to display the data on the screen.

```xml
<com.nhncloud.android.ocr.SecureTextView
    android:id="@+id/credit_card_first_number_view"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    app:com_nhncloud_text_color="#ffffff"
    app:com_nhncloud_text_size="15sp"
    app:com_nhncloud_text_style="bold"
    app:com_nhncloud_letter_spacing="0.3"/>
```

Set the text to be displayed via the setText method of SecureTextView. 
```kotlin
val cardNumbers = creditCardData.cardNumbers
val firstNumber = cardNumbers[0]
val firstNumberView = findViewById<SecureTextView>(credit_card_first_number_view)
firstNumberView.setText(namfirstNumbere)
```

## Class References

### CreditCardData

| Method | Returns | Parameters | Descriptions |
| --- | --- | --- | --- |
| getFullCardNumber | SecureString |  | Return the full card number. |
| getCardNumbers | SecureString[] |  | Return the array of the card number. |
| getExpirationDate | SecureString |  | Return the expiration date. |

<br>

### CreditCardRecognitionData

| Method | Returns | Parameters | Descriptions |
| --- | --- | --- | --- |
| getOriginBitmap | Bitmap |  | Return the original image. |
| getDetectedBitmap | Bitmap |  | Return the detected image.<br>(The image of the guide area is returned.) |
| getResolution | String |  | Return the resolution information.<br>(Normal when over the recommended resolution, low when below the recommended resolution) |
| getFullCardNumber | SecureString |  | Return the full card number. |
| getCardNumbers | CardNumber[] |  | Return the array of the card number data (CardNumber). |
| getExpirationDate | ExpirationDate |  | Return the expiration date data (ExpirationDate). |
| getOriginJsonData | String |  | Return the server response result. |

<br>

### CreditCardRecognitionData.CardNumber

| Method | Returns | Parameters | Descriptions |
| --- | --- | --- | --- |
| getValue | SecureString |  | Return the card number recognition result. |
| getConfidence | String |  | Return the confidence of the card number recognition result. |
| getCoordinates | Coordinates |  | Return the list of coordinates of the card number recognition area. |

<br>

### CreditCardRecognitionData.ExpirationDate

| Method | Returns | Parameters | Descriptions |
| --- | --- | --- | --- |
| getValue | SecureString |  | Return the expiration date recognition result. |
| getConfidence | String |  | Return the confidence of expiration date recognition result. |
| getCoordinates | Coordinates |  | Return the list of coordinates of expiration date recognition result. |

<br>

### CreditCardRecognitionData.Coordinates

| Method | Returns | Parameters | Descriptions |
| --- | --- | --- | --- |
| getPoints | Point[] |  | Return the array of coordinates (Point). |
| getPoint | Point | int | Return the coordinates<br>- LEFT_TOP: 0<br>- RIGHT_TOP: 1<br>- RIGHT_BOTTOM: 2<br>- LEFT_BOTTOM: 3 |

<br>

### SecureTextView

| Method | Returns | Parameters | Descriptions |
| --- | --- | --- | --- |
| setText |  | SecureString | Set the text to be displayed in SecureTextView.  |
| setTextSize | float |  | Set the text size. <br>The size unit is sp and defaults to 14sp. |
| setTextColor | int |  | Set the text color. <br>The default setting is Color.Black (0xFF000000). |
| setTypefaceStyle | Typeface, int |  | Set the text font and style. <br>The default style setting is Typeface.NORMAL.|
| setLetterSpacing | float | | Set the character spacing for the text. <br>The default setting is 0em.

<br>