## NHN Cloud > SDK 사용 가이드 > OCR > Credit Card (Android)

## 사전 준비

1. [NHN Cloud Console](https://console.nhncloud.com)에서 [AI Service > OCR] 서비스를 활성화합니다.
2. OCR 콘솔에서 AppKey와 SecretKey를 확인합니다.

## 지원 환경

NHN Cloud Credit Card Recognizer는 Android 5.1 이상(API level 22 이상)에서 동작합니다.

## 프로젝트 설정

### 의존성 추가

앱의 build.gradle 파일에 nhncloud-creditcard-recognizer 의존성을 추가합니다.

```groovy
dependencies {
    ...
    // NHN Cloud Credit Card Recognizer
    implementation 'com.nhncloud.android:nhncloud-creditcard-recognizer:1.8.1'
}
```

<br>

### CAMERA 권한

Credit Card Recognizer를 사용하기 위해서는 **Manifest.permission.CAMERA** 권한이 필요합니다.
Credit Card Recognizer를 시작하기 전에 카메라 권한을 획득하세요.

<br>

## Credit Card Recognizer 사용

### CreditCardRecognizer 인스턴스 생성

Credit Card Recognizer 인스턴스를 생성합니다.

```kotlin
val creditCardRecognizer = NhnCloudOcr.newBuilder(context)
        .appKey(APP_KEY)
        .secretKey(SECRET_KEY)
        .createCreditCardRecognizer()
```

<br>

### CreditCardRecognizer 시작하기

CreditCardRecognizer의 launch(Activity, CreditCardRecognitionCallback) 메서드를 호출하여 신용카드 인식을 시작합니다.

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

### 인식 데이터 사용

신용카드 인식 성공 시 CreditCardData 객체로 신용카드 인식 데이터가 전달됩니다.
개인정보 보호를 위해 신용카드 번호와 유효기간은 일반 문자열이 아닌 SecureString 객체로 반환됩니다.
SecureString.charAt(index) 메서드는 지정된 index에 있는 문자를 반환합니다.

> CreditCardData로 반환되는 신용카드 인식 정보를 String 객체로 생성하여 사용하면 보안에 취약합니다.<br>
> 화면에 표시하기 위하여 [SecureTextView 사용](./creditcard-recognizer-android/#_18)을 참고하세요.

```kotlin
val cardNumbers = creditCardData.cardNumbers
// firstNumber is a SecureString object.
val firstNumber = cardNumbers[0]
firstNumberSecureTextView.setText(firstNumber)
...
```

<br>

## 신용카드 인식 화면 사용자 정의

신용카드 인식 화면을 사용자 정의하여 사용할 수 있습니다.
사용자 정의 화면을 구성하려면 CreditCardRecognizer 대신 CreditCardRecognitionService를 사용해야 합니다.

### CreditCardRecognitionService 인스턴스 생성

CreditCardRecognitionService 인스턴스를 생성합니다.

```kotlin
val creditCardRecognitionService = NhnCloudOcrServices.newBuilder(context)
        .appKey(APP_KEY)
        .secretKey(SECRET_KEY)
        .createCreditCardRecognitionService()
```

<br>

### CreditCardRecognitionService 리스너 등록

setCreditCardRecognitionListener() 메서드를 사용하여 리스너를 등록합니다.
신용카드가 인식되었을 때 CreditCardRecognitionListener를 통해 결과가 통지됩니다.

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

> 카드 인식 후 반드시 creditCardRecognitionService.stop()을 호출하여 서비스를 중지해야 합니다.

<br>

### 인식 결과 처리

CreditCardRecognitionListener으로 전달되는 CreditCardRecognitionData는 신뢰도(confidence rating)와 상관없이 모든 결과를 반환합니다.
따라서 아래와 같이 신뢰도(confidence rating)를 체크하여 보다 정확한 결과를 사용할 수 있습니다.

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

### 인식 데이터 사용

신용카드 인식 성공 시 CreditCardRecognitionData 객체로 신용카드 인식 데이터가 전달됩니다.
개인정보 보호를 위해 신용카드 번호와 유효기간은 일반 문자열이 아닌 SecureString 객체로 반환됩니다.
SecureString.charAt(index) 메서드는 지정된 index에 있는 문자를 반환합니다.

> CreditCardRecognitionData로 반환되는 신용카드 인식 정보를 String 객체로 생성하여 사용하면 보안에 취약합니다.<br>
> 화면에 표시하기 위하여 [SecureTextView](./creditcard-recognizer-android/#_18)사용을 참고하세요.

```kotlin
val cardNumbers = creditCardData.cardNumbers
// firstCardNumber is a SecureString object.
val firstNumber = cardNumbers[0].value
firstNumberSecureTextView.setText(firstNumber)
...
```

<br>

### Camera Preview 구성

Activity 또는 Fragment의 Layout에 아래와 같이 CreditCardRecognitionCameraPreview 추가하여 Camera Preview를 구성합니다.

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

### 백그라운드 색상 변경

스캔 가이드 영역을 제외한 영역은 반투명하게 보입니다.
이 영역의 색상을 "app:guideBackgroundColor" 속성을 사용하여 설정합니다.

```xml
<com.nhncloud.android.ocr.creditcard.view.CreditCardRecognitionCameraPreview
    android:id="@+id/camera_preview"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    app:guideBackgroundColor="#33000000" />
```

<br>

### 스캔 가이드 뷰 사용자 정의

스캔 가이드 뷰를 CreditCardRecognitionCameraPreview의 하위 뷰로 배치하여 자유롭게 정의할 수 있습니다.
사용자 정의한 가이드 뷰는 "app:guideView" 속성을 사용하여 설정합니다.

> CreditCardRecognitionCameraPreview는 ConstraintLayout을 상속 구현되어 있습니다.

스캔 가이드 뷰의 사이즈는 자동으로 조정됩니다.

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

### 신용카드 검출 시 가이드 뷰 변경

신용카드가 검출되었을 때 스캔 가이드 뷰의 색상 또는 모양을 변경할 수 있습니다.
CreditCardDetectable 인터페이스를 상속 구현하여 setDetected(Boolean)으로 전달되는 값에 따라 가이드 뷰의 색상 또는 모양을 변경합니다.

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

### 서비스 시작

CreditCardRecognitionCameraPreview의 인스턴스를 획득하여 CreditCardRecognitionService 시작합니다.

```kotlin
val cameraPreview = findViewById<CreditCardRecognitionCameraPreview>(R.id.camera_preview)
try {
    creditCardRecognitionService.start(cameraPreview)
} catch (e: IOException) {
    // Camera is not available (in use or does not exist)
}
```

<br>

### 서비스 정지

앱이 백그라운드로 진입 또는 신용카드 인식에 성공했을 때 creditCardRecognitionService를 정지합니다.

```kotlin
creditCardRecognitionService.stop()
```

<br>

### 서비스 해제

Activity 또는 Fragment의 View가 Destory 되었을 때 creditCardRecognitionService를 해제합니다.

```kotlin
creditCardRecognitionService.release();
```

<br>

### CreditCardRecognizer Lifecycle 설정

Activity 또는 Fragment의 라이프 사이클에 따라 아래와 같이 호출합니다.

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

### 스캔 방향 설정

신용카드 스캔 방향을 설정합니다.

```kotlin
creditCardRecognitionService.scanOrientation =
    CreditCardScanOrientation.HORIZONTAL // or CreditCardScanOrientation.HORIZONTAL
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

Credit Card Recognition Service를 시작하기 전에 애플리케이션을 실행하는 기기에서 Credit Card Recognition Service를 사용할 수 있는 환경인지 확인할 수 있습니다.
이 검사를 수행하려면 CreditCardRecognitionService.isAvailable(Context) 메서드를 사용합니다.

```kotlin
if (CreditCardRecognitionService.isAvailable(context)) {
    // Credit card recognition service is available.
} else {
    // Credit card recognition service is not available.
}
```
<br>

## SecureTextView 사용

개인정보 보호를 위해 신용카드 데이터는 일반 문자열이 아닌 SecureString 객체로 반환됩니다.
신용카드 인식 정보를 String 객체로 생성하여 사용하면 보안에 취약하며, 데이터를 화면에 표시하기 위해 SecureTextView를 사용할 수 있습니다. 

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

SecureTextView의 setText 메서드를 통해 표시할 텍스트를 설정합니다. 
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
| getFullCardNumber | SecureString |  | 전체 카드 번호를 반환합니다. |
| getCardNumbers | SecureString[] |  | 카드 번호 배열을 반환합니다. |
| getExpirationDate | SecureString |  | 유효 기간을 반환합니다. |

<br>

### CreditCardRecognitionData

| Method | Returns | Parameters | Descriptions |
| --- | --- | --- | --- |
| getOriginBitmap | Bitmap |  | 원본 이미지를 반환합니다. |
| getDetectedBitmap | Bitmap |  | 검출된 이미지를 반환합니다.<br>(가이드 영역의 이미지가 반환됩니다.) |
| getResolution | String |  | 해상도 정보를 반환합니다.<br>(권장 해상도 이상이면 normal, 미만은 low) |
| getFullCardNumber | SecureString |  | 전체 카드 번호를 반환합니다. |
| getCardNumbers | CardNumber[] |  | 카드 번호 데이터(CardNumber)의 배열이 반환됩니다. |
| getExpirationDate | ExpirationDate |  | 유효 기간 데이터(ExpirationDate)가 반환됩니다. |
| getOriginJsonData | String |  | 서버 응답 결과를 반환합니다. |

<br>

### CreditCardRecognitionData.CardNumber

| Method | Returns | Parameters | Descriptions |
| --- | --- | --- | --- |
| getValue | SecureString |  | 카드 번호 인식 결과를 반환합니다. |
| getConfidence | String |  | 카드 번호 인식 결과의 신뢰도를 반환합니다. |
| getCoordinates | Coordinates |  | 카드 번호 인식 영역의 좌표 목록(Coordinates)를 반환합니다. |

<br>

### CreditCardRecognitionData.ExpirationDate

| Method | Returns | Parameters | Descriptions |
| --- | --- | --- | --- |
| getValue | SecureString |  | 유효 기간 인식 결과를 반환합니다. |
| getConfidence | String |  | 유효 기간 인식 결과의 신뢰도를 반환합니다. |
| getCoordinates | Coordinates |  | 유효 기간 인식 영역의 좌표 목록(Coordinates)를 반환합니다. |

<br>

### CreditCardRecognitionData.Coordinates

| Method | Returns | Parameters | Descriptions |
| --- | --- | --- | --- |
| getPoints | Point[] |  | 좌표(Point)의 배열을 반환합니다. |
| getPoint | Point | int | 좌표를 반환합니다.<br>\- LEFT\_TOP: 0<br>\- RIGHT\_TOP: 1<br>\- RIGHT\_BOTTOM: 2<br>\- LEFT\_BOTTOM: 3 |

<br>

### SecureTextView

| Method | Returns | Parameters | Descriptions |
| --- | --- | --- | --- |
| setText |  | SecureString | SecureTextView에 표시할 텍스트를 설정합니다.  |
| setTextSize | float |  | 텍스트 크기를 설정합니다. <br>크기 단위는 sp, 기본 설정은 14sp입니다. |
| setTextColor | int |  | 텍스트 색상을 설정합니다. <br>기본 설정은 Color.Black(0xFF000000)입니다. |
| setTypefaceStyle | Typeface, int |  | 텍스트 서체와 스타일을 설정합니다. <br>기본 스타일 설정은 Typeface.NORMAL입니다.|
| setLetterSpacing | float | | 텍스트의 문자 간격을 설정합니다. <br>기본 설정은 0em입니다. 

<br>