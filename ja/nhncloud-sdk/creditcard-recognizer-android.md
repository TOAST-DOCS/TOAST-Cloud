## NHN Cloud > SDK User Guide > OCR > Credit Card (Android)

## 事前準備

1. [NHN Cloud Console](https://console.nhncloud.com)で[AI Service > OCR]サービスを有効にします。
2. OCRコンソールdeAppKeyとSecretKeyを確認します。

## サポート環境

NHN Cloud Credit Card RecognizerはAndroid 5.0以上(API level 21以上)で動作します。

## プロジェクト設定

### 依存関係の追加

アプリのbuild.gradleファイルにnhncloud-creditcard-recognizer依存関係を追加します。
```groovy
dependencies {
    ...
    // NHN Cloud Credit Card Recognizer
    implementation 'com.nhncloud.android:nhncloud-creditcard-recognizer:1.6.0'
}
```

<br>

### CAMERA権限

Credit Card Recognizerを使用するには**Manifest.permission.CAMERA**権限が必要です。
Credit Card Recognizerを始める前にカメラ権限を取得してください。

<br>

## Credit Card Recognizer使用

### CreditCardRecognizerインスタンス作成

Credit Card Recognizerインスタンスを作成します。

```kotlin
val creditCardRecognizer = NhnCloudOcr.newBuilder(context)
        .appKey(APP_KEY)
        .secretKey(SECRET_KEY)
        .createCreditCardRecognizer()
```

<br>

### CreditCardRecognizerをはじめる

CreditCardRecognizerのlaunch(Activity, CreditCardRecognitionCallback)メソッドを呼び出してクレジットカードの認識を開始します。

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

### 認識データ使用

クレジットカードの認識成功時、CreditCardDataオブジェクトにクレジットカード認識データが伝達されます。
個人情報保護のために、クレジットカード番号と有効期限は一般文字列ではないSecureStringオブジェクトで返されます。
SecureString.charAt(index)メソッドは指定されたindexにある文字を返します。

> CreditCardDataで返されるクレジットカード認識情報をStringオブジェクトで作成して使用するとセキュリティに脆弱です。

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

## クレジットカード認識画面のユーザー定義

クレジットカード認識画面をユーザー定義して使用できます。
ユーザー定義画面を構成するにはCreditCardRecognizerの代わりにCreditCardRecognitionServiceを使用する必要があります。

### CreditCardRecognitionServiceインスタンス作成

CreditCardRecognitionServiceインスタンスを作成します。

```kotlin
val creditCardRecognitionService = NhnCloudOcrServices.newBuilder(context)
        .appKey(APP_KEY)
        .secretKey(SECRET_KEY)
        .createCreditCardRecognitionService()
```

<br>

### CreditCardRecognitionServiceリスナー登録

setCreditCardRecognitionListener()メソッドを使用してリスナーを登録します。
クレジットカードが認識された時、CreditCardRecognitionListenerを通じて結果が通知されます。

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

> カード認識後に必ずcreditCardRecognitionService.stop()を呼び出してサービスを停止する必要があります。

<br>

### 認識結果の処理

CreditCardRecognitionListenerに伝達されるCreditCardRecognitionDataは信頼度(confidence rating)に関係なくすべての結果を返します。
したがって、以下のように信頼度(confidence rating)をチェックして、より正確な結果を使用できます。

```kotlin
creditCardRecognitionService.setCreditCardRecognitionListener { result, data ->
    if (result.isSuccess && isConfident(data)) {
        // Recognition success.
        creditCardRecognitionService.stop()
    } else {
    }
}

private fun isConfident(data: CreditCardRecognitionData): Boolean {
    // Returns success when the card number is greater than or equal to 4
    // and the confidence rating is greater than or equal to 0.4.
    with (data.cardNumbers) {
        if (size < 4) {
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

### 認識データの使用

クレジットカードの認識に成功した時、CreditCardRecognitionDataオブジェクトでクレジットカード認識データが伝達されます。
個人情報保護のためにクレジットカード番号と有効期限は一般文字列ではないSecureStringオブジェクトで返されます。
SecureString.charAt(index)メソッドは指定されたindexにある文字を返します。

> CreditCardRecognitionDataで返されるクレジットカード認識情報をStringオブジェクトで作成して使用するとセキュリティに脆弱です。

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

### Camera Preview構成

ActivityまたはFragmentのLayoutに以下のようにCreditCardRecognitionCameraPreviewを追加してCamera Previewを構成します。

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

### バックグラウンドの色を変更

スキャンガイド領域を除く領域は半透明に見えます。
この領域の色を"app:guideBackgroundColor"プロパティを使用して設定します。

```xml
<com.nhncloud.android.ocr.creditcard.view.CreditCardRecognitionCameraPreview
    android:id="@+id/camera_preview"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    app:guideBackgroundColor="#33000000" />
```

<br>

### スキャンガイドビューユーザー定義

スキャンガイドビューをCreditCardRecognitionCameraPreviewの下位ビューとして配置して自由に定義できます。
ユーザー定義したガイドビューは"app:guideView"プロパティを使用して設定します。

> CreditCardRecognitionCameraPreviewはConstraintLayoutを継承実装されています。

スキャンガイドビューのサイズは自動的に調整されます。

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

### クレジットカード検出時のガイドビュー変更

クレジットカードが検出された時、スキャンガイドビューの色または形を変更できます。
CreditCardDetectableインタフェースを継承実装してsetDetected(Boolean)に伝達される値に基づいてガイドビューの色または形を変更します。

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

### サービス開始

CreditCardRecognitionCameraPreviewのインスタンスを取得してCreditCardRecognitionServiceを開始します。

```kotlin
val cameraPreview = findViewById<CreditCardRecognitionCameraPreview>(R.id.camera_preview)
try {
    creditCardRecognitionService.start(cameraPreview)
} catch (e: IOException) {
    // Camera is not available (in use or does not exist)
}
```

<br>

### サービス停止

アプリがバックグラウンドになるか、クレジットカードの認識に成功した時、creditCardRecognitionServiceを停止します。

```kotlin
creditCardRecognitionService.stop()
```

<br>

### サービス解除

ActivityまたはFragmentのViewがDestoryされた時、creditCardRecognitionServiceを解除します。

```kotlin
creditCardRecognitionService.release();
```

<br>

### CreditCardRecognizer Lifecycle設定

ActivityまたはFragmentのライフサイクルに基づいて以下のように呼び出します。

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

### スキャン方向設定

クレジットカードのスキャン方向を設定します。

```kotlin
creditCardRecognitionService.scanOrientation =
    CreditCardScanOrientation.HORIZONTAL // or CreditCardScanOrientation.HORIZONTAL
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

Credit Card Recognition Serviceを起動する前に、アプリケーションを実行する端末でCredit Card Recognition Serviceを使用できる環境であることを確認できます。
この検査を実行するにはCreditCardRecognitionService.isAvailable(Context)メソッドを使用します。

```kotlin
if (CreditCardRecognitionService.isAvailable(context)) {
    // Credit card recognition service is available.
} else {
    // Credit card recognition service is not available.
}
```

## Class References

### CreditCardData

| Method | Returns | Parameters | Descriptions |
| --- | --- | --- | --- |
| getFullCardNumber | SecureString |  | 全てのカード番号を返します。 |
| getCardNumbers | SecureString[] |  | カード番号配列を返します。 |
| getExpirationDate | SecureString |  | 有効期限を返します。 |

<br>

### CreditCardRecognitionData

| Method | Returns | Parameters | Descriptions |
| --- | --- | --- | --- |
| getOriginBitmap | Bitmap |  | 原本イメージを返します。 |
| getDetectedBitmap | Bitmap |  | 検出されたイメージを返します。<br>(ガイド領域のイメージが返されます。) |
| getResolution | String |  | 解像度情報を返します。<br>(推奨解像度以上の場合はnormal、未満はlow) |
| getFullCardNumber | SecureString |  | 全てのカード番号を返します。 |
| getCardNumbers | CardNumber[] |  | カード番号データ(CardNumber)の配列が返されます。 |
| getExpirationDate | ExpirationDate |  | 有効期限データ(ExpirationDate)が返されます。 |
| getOriginJsonData | String |  | サーバーレスポンス結果を返します。 |

<br>

### CreditCardRecognitionData.CardNumber

| Method | Returns | Parameters | Descriptions |
| --- | --- | --- | --- |
| getValue | SecureString |  | カード番号認識結果を返します。 |
| getConfidence | String |  | カード番号認識結果の信頼度を返します。 |
| getCoordinates | Coordinates |  | カード番号認識領域の座標リスト(Coordinates)を返します。 |

<br>

### CreditCardRecognitionData.ExpirationDate

| Method | Returns | Parameters | Descriptions |
| --- | --- | --- | --- |
| getValue | SecureString |  | 有効期限の認識結果を返します。 |
| getConfidence | String |  | 有効期限の認識結果の信頼度を返します。 |
| getCoordinates | Coordinates |  | 有効期限認識領域の座標リスト(Coordinates)を返します。 |

<br>

### CreditCardRecognitionData.Coordinates

| Method | Returns | Parameters | Descriptions |
| --- | --- | --- | --- |
| getPoints | Point[] |  | 座標(Point)の配列を返します。 |
| getPoint | Point | int | 座標を返します。<br>\- LEFT\_TOP: 0<br>\- RIGHT\_TOP: 1<br>\- RIGHT\_BOTTOM: 2<br>\- LEFT\_BOTTOM: 3 |

<br>
