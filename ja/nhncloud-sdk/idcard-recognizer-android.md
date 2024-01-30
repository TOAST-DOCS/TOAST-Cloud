## NHN Cloud > SDK使用ガイド > OCR > ID Card (Android)

## 事前準備

1. [NHN Cloud Console](https://console.nhncloud.com)で[AI Service > OCR]サービスを有効にします。
2. OCRコンソールでAppKeyとSecretKeyを確認します。

## サポート環境

NHN Cloud ID Card RecognizerはAndroid 5.1以上(API level 22以上)で動作します。

## プロジェクト設定

### 依存関係追加

アプリのbuild.gradleファイルにnhncloud-idcard-recognizer依存関係を追加します。

```groovy
dependencies {
    ...
    // NHN Cloud ID Card Recognizer
    implementation 'com.nhncloud.android:nhncloud-idcard-recognizer:1.8.4'
}
```

<br>

### CAMERA権限

ID Card Recognizerを使用するには **Manifest.permission.CAMERA**権限が必要です。
ID Card Recognizerを起動する前にカメラの権限を取得してください。

<br>

## Id Card Recognizer使用

### IdCardRecognizerインスタンス作成

ID Card Recognizerインスタンスを作成します。

```kotlin
val nhnCloudOcr = NhnCloudOcr.newBuilder(context)
        .appKey(APP_KEY)
        .secretKey(SECRET_KEY)
        .build()
val idCardRecognizer = nhnCloudOcr.createIdCardRecognizer()
```

<br>

### IdCardRecognizerを始める

IdCardRecognizerのlaunch(Activity, IdCardRecognitionCallback)メソッドを呼び出して身分証認識を開始します。

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

### 認識データ使用

IDカード認識に成功すると、IDCardDataを継承実装したオブジェクトにIDカード認識データが渡されます。
身分証明書の種類によって、住民登録証はIdCardResidentDataオブジェクト、運転免許証はIdCardDriverDataオブジェクトが返されます。

個人情報保護のために身分証データは一般文字列ではなくSecureStringオブジェクトで返されます。
SecureString.charAt(index)メソッドは指定されたindexにある文字を返します。

> IdCardDataで返される身分証明書認識情報をStringオブジェクトとして作成して使用するとセキュリティに脆弱です。<br>
> 画面に表示するために[SecureTextView使用](./idcard-recognizer-android/#_18)を参照してください。

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

### 身分証真偽確認

身分証の真偽確認のためにIdCardAuthenticatorインスタンスを作成します。 
身分証認識結果であるIdCardDataを利用して真偽確認をリクエストできます。 

身分証真偽確認結果はBooleanタイプで返されます。 

> 真偽確認に使用されるIdCardDataのRequestKeyは、一度限りの値のため再使用できません。<br>
> RequestKeyは発行後1時間有効で、その後は使用できません。

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

authenticateAsyncメソッドで呼び出したい場合はIdCardAuthenticityCallbackを実装して結果を受け取ることができます。

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

## 身分証認識画面ユーザー定義

身分証認識画面をユーザー定義して使用できます。
ユーザー定義画面を構成するにはIdCardRecognizerの代わりにIdCardRecognitionServiceを使用する必要があります。

### IdCardRecognitionServiceインスタンス作成

IdCardRecognitionServiceインスタンスを作成します。

```kotlin
val ocrServices = NhnCloudOcrServices.newBuilder(context)
        .appKey(APP_KEY)
        .secretKey(SECRET_KEY)
        .build()
val IdCardRecognitionService = ocrServices.createIdCardRecognitionService()
```

<br>

### IdCardRecognitionServiceリスナー登録

setIdCardRecognitionListener()メソッドを使用してリスナーを登録します。
身分証が認識されるとIdCardRecognitionListenerを通じて結果が通知されます。

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

> 身分証認識後、必ずIdCardRecognitionService.stop()を呼び出してサービスを停止する必要があります。

<br>

### 認識結果処理

IdCardRecognitionListenerに渡されるIdCardRecognitionDataは信頼度(confidence rating)に関係なくすべての結果を返します。
したがって、下記のように信頼度(confidence rating)をチェックして、より正確な結果を使用できます。

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

### 認識データ使用

身分証の認識に成功すると、IdCardRecognitionDataを継承して実装したオブジェクトに身分証の認識データが渡されます。
身分証明書の種類によって、住民登録証はIdCardResidentRecognitionDataオブジェクト、運転免許証はIdCardDriverRecognitionDataオブジェクトで返されます。

個人情報保護のために身分証データは一般文字列ではなくSecureStringオブジェクトで返されます。
SecureString.charAt(index)メソッドは指定されたindexにある文字を返します。

> IdCardRecognitionDataで返される身分証認識情報をStringオブジェクトとして作成して使用するとセキュリティに脆弱です。<br>
> 画面に表示するために[SecureTextView](./idcard-recognizer-android/#_18)使用を参照してください。

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

### 身分証真偽確認

身分証真偽確認のためにIdCardAuthenticityServiceインスタンスを作成します。 
身分証認識結果であるIdCardRecognitionDataを利用して真偽確認をリクエストできます。 

身分証真偽確認結果はBooleanタイプで返されます。 

> 真偽確認に使用されるIdCardRecognitionDataのRequestKeyは、一回限りの値のため再使用できません。<br>
> RequestKeyは発行後1時間有効で、その後は使用できません。

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

authenticateAsyncメソッドで呼び出したい場合はIdCardAuthenticityCallbackを実装して結果を受け取ることができます。

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

### Camera Preview構成

ActivityまたはFragmentのLayoutに下記のようにIdCardRecognitionCameraPreview追加してCamera Previewを構成します。

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

### バックグラウンド色の変更

スキャンガイド領域を除外した領域は半透明に見えます。
この領域の色を"app:guideBackgroundColor"プロパティを使用して設定します。

```xml
<com.nhncloud.android.ocr.idcard.view.IdCardRecognitionCameraPreview
    android:id="@+id/camera_preview"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    app:guideBackgroundColor="#33000000" />
```

<br>

### スキャンガイドビューユーザー定義

スキャンガイドビューをIdCardRecognitionCameraPreviewのサブビューとして配置して自由に定義することができます。
カスタマイズしたガイドビューは「app:guideView」プロパティを使用して設定します。

> IdCardRecognitionCameraPreviewはConstraintLayoutを継承実装されています。

スキャンガイドビューのサイズは自動的に調整されます。

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

### 身分証検出時のガイドビュー変更

身分証が検出された時、スキャンガイドビューの色または形を変更できます。
OcrDetectableインターフェイスを継承実装してsetDetected(Boolean)に渡される値に基づいてガイドビューの色または形を変更します。

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

### サービス開始

IdCardRecognitionCameraPreviewのインスタンスを取得してIdCardRecognitionServiceを開始します。

```kotlin
val cameraPreview = findViewById<IdCardRecognitionCameraPreview>(R.id.camera_preview)
try {
    idCardRecognitionService.start(cameraPreview)
} catch (e: IOException) {
    // Camera is not available (in use or does not exist)
}
```

<br>

### サービス停止

アプリがバックグラウンドに切り替わるか身分証認識に成功したとき、IdCardRecognitionServiceを停止します。

```kotlin
idCardRecognitionService.stop()
```

<br>

### サービス解除

ActivityまたはFragmentのViewがDestoryされたとき、IdCardRecognitionServiceを解除します。

```kotlin
idCardRecognitionService.release();
```

<br>

### IdCardRecognizer Lifecycle設定

ActivityまたはFragmentのライフサイクルに基づいて以下のように呼び出します。

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

### 画面キャプチャ防止

画面キャプチャ防止のためにActivityのonCreate()でsetContentView()が呼び出される前に**WindowManager.LayoutParams.FLAG\_SECURE**を追加します。

```kotlin
override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    window.addFlags(WindowManager.LayoutParams.FLAG_SECURE)
    setContentView(R.layout.activity_main)
    ...
}
```

詳細については、 [WindowManager.LayoutParams.FLAG\_SECURE](https://developer.android.com/reference/android/view/WindowManager.LayoutParams#FLAG_SECURE)を参照してください。

<br>

### デバイスチェック

ID Card Recognition Serviceを開始する前に、アプリケーションを実行するデバイスでID Card Recognition Serviceを使用できる環境かどうかを確認できます。
この検査を行うには、IdCardRecognitionService.isAvailable(Context)メソッドを使用します。

```kotlin
if (IdCardRecognitionService.isAvailable(context)) {
    // ID card recognition service is available.
} else {
    // ID card recognition service is not available.
}
```

<br>

## SecureTextView使用

個人情報保護のために身分証データは一般文字列ではなくSecureStringオブジェクトで返されます。
身分証明書認識情報をStringオブジェクトとして使用すると、セキュリティに脆弱であり、データを画面に表示するためにSecureTextViewを使用できます。

```xml
<com.nhncloud.android.ocr.SecureTextView
    android:id="@+id/id_card_name_view"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    app:com_nhncloud_text_color="#ffffff"
    app:com_nhncloud_text_size="15sp"
    app:com_nhncloud_text_style="bold"/>
```

SecureTextViewのsetTextメソッドで表示するテキストを設定します。 
```kotlin
val name = idCardData.name

val idCardNameView = findViewById<SecureTextView>(id_card_name_view)
idCardNameView.setText(name)
```

### SecureTextGroup使用
複数行のテキストを表示する必要がある場合はSecureTextGroupを使用できます。 
```xml
<com.nhncloud.android.ocr.SecureTextGroup
    android:id="@+id/id_card_license_type_view"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    app:com_nhncloud_text_color="#ffffff"
    app:com_nhncloud_text_size="15sp"
    app:com_nhncloud_text_style="bold"/>
```

SecureTextGroupのaddTextViewsメソッドは配列をパラメータとして受け取り、1つの要素ごとに1行のテキストに設定します。
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
| getRequestKey | SecureString |  | 身分証真偽確認に使用されるRequestKeyを返します。  |
| getIdType | String |  | 身分証の種類を返します。 ("resident" or "driver") |

<br>

### IdCardResidentData

| Method | Returns | Parameters | Descriptions |
| --- | --- | --- | --- |
| getName | SecureString |  | 名前を返します。 |
| getResidentNumber | SecureString |  | 住民登録番号を返します。 |
| getIssueDate | SecureString |  | 発行日時を返します。 |
| getIssuer | SecureString |  | 発行機関を返します。 |

<br>

### IdCardDriverData

| Method | Returns | Parameters | Descriptions |
| --- | --- | --- | --- |
| getName | SecureString |  | 名前を返します。 |
| getResidentNumber | SecureString |  | 住民登録番号を返します。 |
| getIssueDate | SecureString |  | 発行日時を返します。 |
| getIssuer | SecureString |  | 発行機関を返します。 |
| getDriverLicenseNumber | SecureString |  | 運転免許番号を返します。 |
| getLicenseType | SecureString |  | 免許の種類を返します。<br>免許の種類が2つ以上の場合、文字列内で「/」で区切られます。 |
| getCondition | SecureString |  | 免許条件を返します。<br>運転免許証に応じて該当値が存在しない場合は空白が返されます。 |
| getSerialNumber | SecureString |  | 暗号一連番号を返します。 |

<br>


### IdCardRecognitionData

| Method | Returns | Parameters | Descriptions |
| --- | --- | --- | --- |
| getOriginBitmap | Bitmap |  | 原本画像を返します。 |
| getDetectedBitmap | Bitmap |  | 検出された画像を返します。<br>(ガイド領域の画像が返されます。) |
| getResolution | String |  | 解像度情報を返します。<br>(推奨解像度以上はnormal、未満はlow) |
| getRequestKey | String |  | 身分証真偽確認に使用されるRequestKeyを返します。  |
| getIdType | String |  | 身分証の種類を返します。 ("resident" or "driver") |
| getOriginJsonData | String |  | サーバーレスポンス結果を返します。 |

<br>

### IdCardRecognitionData.IdCardValue

| Method | Returns | Parameters | Descriptions |
| --- | --- | --- | --- |
| getValue | SecureString |  | 身分証認識結果を返します。 |
| getConfidence | String |  | 身分証認識結果の信頼度を返します。 |

<br>

### IdCardResidentRecognitionData

| Method | Returns | Parameters | Descriptions |
| --- | --- | --- | --- |
| getName | IdCardValue |  | 名前を返します。 |
| getResidentNumber | IdCardValue |  | 住民登録番号を返します。 |
| getIssueDate | IdCardValue |  | 発行日時を返します。 |
| getIssuer | IdCardValue |  | 発行機関を返します。 |

<br>

### IdCardDriverRecognitionData

| Method | Returns | Parameters | Descriptions |
| --- | --- | --- | --- |
| getName | IdCardValue |  | 名前を返します。 |
| getResidentNumber | IdCardValue |  | 住民登録番号を返します。 |
| getIssueDate | IdCardValue |  | 発行日時を返します。 |
| getIssuer | IdCardValue |  | 発行機関を返します。 |
| getDriverLicenseNumber | IdCardValue |  | 運転免許番号を返します。 |
| getLicenseType | IdCardValue |  | 免許の種類を返します。<br>免許の種類が2つ以上の場合、文字列内で「/」で区切られます。 |
| getCondition | IdCardValue |  | 免許条件を返します。<br>運転免許証に応じて該当値が存在しない場合は空白が返されます。 |
| getSerialNumber | IdCardValue |  | 暗号一連番号を返します。 |

<br>

### SecureTextView

| Method | Returns | Parameters | Descriptions |
| --- | --- | --- | --- |
| setText |  | SecureString | SecureTextViewに表示するテキストを設定します。  |
| setTextSize | float |  | テキストサイズを設定します。 <br>サイズ単位はsp、基本設定は14spです。 |
| setTextColor | int |  | テキスト色を設定します。 <br>基本設定はColor.Black(0xFF000000)です。 |
| setTypefaceStyle | Typeface, int |  | テキストの書体とスタイルを設定します。 <br>基本スタイル設定はTypeface.NORMALです。|

<br>

### SecureTextGroup

| Method | Returns | Parameters | Descriptions |
| --- | --- | --- | --- |
| addTextView |  | SecureString | SecureTextGroupに表示するテキストを追加します。  |
| addTextViews |  | SecureString[] | SecureTextGroupに表示するテキストを追加します。  |
| setTextSize | float |  | テキストサイズを設定します。 <br>サイズ単位はsp、基本設定は14spです。 |
| setTextColor | int |  | テキスト色を設定します。 <br>基本設定はColor.Black(0xFF000000)です。 |
| setTypefaceStyle | Typeface, int |  | テキストの書体とスタイルを設定します。 <br>基本スタイル設定はTypeface.NORMALです。|
| setLetterSpacing | float | | 텍스트의 문자 간격을 설정합니다. <br>기본 설정은 0em입니다. 

<br>
