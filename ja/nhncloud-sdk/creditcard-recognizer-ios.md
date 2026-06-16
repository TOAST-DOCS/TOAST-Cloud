<!-- pre-align:aligned sig=5686df8dc3c5 -->

## NHN Cloud > SDK User Guide >OCR > Credit Card (iOS)

<a id="prerequisites"></a>

## 事前準備

1. [NHN Cloud SDK](./getting-started-ios)をインストールします。
2. [NHN Cloud Console](https://console.nhncloud.com)で[AI Service > OCR]サービスを有効にします。
3. OCRコンソールでAppKeyとSecretKeyを確認します。

<br>

<a id="supported-environment"></a>

## サポート環境

NHN Cloud OCRはiOS 11.0以上で動作します。<br>

<a id="configuration-of-nhn-cloud-ocr"></a>

## NHN Cloud OCR構成

iOS用NHN Cloud OCR SDKの構成は次のとおりです。

| Service  | Cocoapods Pod Name | Framework | Dependency | Build Settings |
| --- | --- | --- | --- | --- |
| IAP | NHNCloudOCR | NHNCloudOCR.framework | * Vision.framework<br/> * AVFoundation.framework | |
| Mandatory   | NHNCloudCore<br/>NHNCloudCommon | NHNCloudCore.framework<br/>NHNCloudCommon.framework | | OTHER_LDFLAGS = (<br/>    "-ObjC",<br/>    "-lc++" <br/>); |


<a id="apply-nhn-cloud-ocr-sdk-to-xcode-project"></a>

## NHN Cloud OCR SDKをXcodeプロジェクトに適用

<a id="apply-with-cococapods"></a>

### 1. Cococapodsを利用した適用

* Podfileを作成してNHN Cloud SDKに対するPodを追加します。

```podspec
platform :ios, '11.0'
use_frameworks!

target '{YOUR PROJECT TARGET NAME}' do
    pod 'NHNCloudOCR'
end
```

<a id="apply-nhn-cloud-sdk-using-swift-package-manager"></a>

### 2. Swift Package Managerを使用してNHN Cloud SDK適用

* XCodeで**File > Add Packages...**メニューを選択します。
* Package URLに'https://github.com/nhn/nhncloud.ios.sdk'を入れて**Add Package**ボタンを選択します。
* NHNCloudOCRを選択します。

![swift_package_manager](https://static.toastoven.net/toastcloud/sdk/ios/swiftpackagemanager01.png)

<a id="set-up-project"></a>

#### プロジェクト設定

* **Build Settings**の **Other Linker Flags**に**-lc++**と**-ObjC**項目を追加します。
    * **Project Target > Build Settings > Linking > Other Linker Flags**
![other_linker_flags](https://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags_202206.png)

<a id="download-binaries-and-apply-to-nhn-cloud-sdk"></a>

### 3. バイナリをダウンロードしてNHN Cloud SDK適用

<a id="set-up-framework"></a>

#### フレームワーク設定

* NHN Cloud [Downloads](../../../Download/#toast-sdk)ページで全てのiOS SDKをダウンロードできます。
* Xcode Projectに**NHNCloudOCR.framework**、 **NHNCloudCore.framework**、 **NHNCloudCommon.framework、 vision.framework、 AVFoundation.framework**を追加します。
* vision.frameworkとAVFoundation.frameworkは、以下の方法で追加できます。
![linked_vision_frameworks](https://static.toastoven.net/toastcloud/sdk/ios/linked_vision_frameworks.png)
![linked_avfoundation_frameworks](https://static.toastoven.net/toastcloud/sdk/ios/linked_avfoundation_frameworks.png)
![linked_frameworks_ocr](https://static.toastoven.net/toastcloud/sdk/ios/linked_frameworks_ocr.png)

<a id="set-up-project-2"></a>

#### プロジェクト設定

* **Build Settings**の**Other Linker Flags**に**-lc++**と**-ObjC**項目を追加します。
    * **Project Target > Build Settings > Linking > Other Linker Flags**
![other_linker_flags](https://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags_202206.png)

<a id="initialize-nhncloudocr-sdk"></a>

## NHNCloudOCR SDK初期化
* NHN Cloud Consoleで発行されたAppKeyとSecretをNHNCloudOCRConfigurationオブジェクトに設定します。
  * AI Service -> OCR -> Document OCR -> クレジットカード
* NHNCloudOCRは初期化にNHNCloudOCRConfigurationオブジェクトをパラメータとして使用します。
* カメラ使用権限を取得するためにinfo.plistに以下の内容を追加します。
```
Key : NSCameraUsageDescription
Value： [カメラ権限リクエストメッセージ]
```

<a id="specification-for-initialization-api"></a>

### 初期化API仕様

``` objc
// 初期化
+ (void)initWithConfiguration:(NHNCloudOCRConfiguration *)configuration;

// Delegate設定
+ (void)setCreditCardRecognizerDelegate:(nullable id<NHNCloudCreditCardRecognizerDelegate>)delegate;
```

<a id="specification-for-delegate-api"></a>

### Delegate API仕様
* NHNCloudCreditCardRecognizerDelegateを登録すると、認識結果に対する通知を受け取ることができます。
* OCRが実行中の時、画面のスクリーンキャプチャと動画録画イベントを受信できません。
* SDKで提供する基本画面使用時(NHNCloudCreditCardRecognizerViewController継承実装)閉じる、確認イベントを受信できます。

``` objc
@protocol NHNCloudCreditCardRecognizerDelegate <NSObject>

// クレジットカード認識結果を返す
- (void)didDetectCreditCardInfo:(nullable NHNCloudCreditCardInfo *)cardInfo error:(nullable NSError *)error;

@optional

// スクリーンキャプチャイベント受信
- (void)didDetectCreditCardSecurityEvent:(NHNCloudSecurityEvent)event;

// 閉じるボタンイベント受信(NHNCloudCreditCardRecognizerViewController継承実装時にのみ受信可能)
- (void)creditCardRecognizerViewControllerCancel;

// 確認ボタンイベント受信(NHNCloudCreditCardRecognizerViewController継承実装時にのみ受信可能)
- (void)creditCardRecognizerViewControllerConfirm;

@end
```

<a id="set-up-detected-image-return"></a>

### 検出イメージリターン設定を行う
* OCR結果であるNHNCloudCreditCardInfoデータに検出されたイメージを一緒に返すことができます。
    * デフォルト値は無効です。 
<a id="specification-for-setting-up-detected-image-return-api"></a>

#### 検出イメージリターン設定API仕様 
```objc
@interface NHNCloudOCR : NSObject
//..
+ (void)setDetectedImageReturn:(BOOL)enable;
+ (BOOL)isEnableDetectedImageReturn;
//..
@end
```

<a id="display-recognition-area"></a>

### 認識領域を表示する

<a id="return-recognition-area-api"></a>

#### 認識領域返却API
* OCR結果であるNHNCloudCreditCardInfoデータに認識された領域の座標情報を返すことができます。

```objc
@interface NHNCloudCreditCardInfo : NSObject

// カード番号認識領域
@property(nonatomic, strong, readonly, nullable) NSArray<NSValue *> *numberBoundingBoxes;

// 有効期限認識領域
@property(nonatomic, assign, readonly) CGRect validThruBoundingBox;

@end

```

<a id="draw-on-the-recognition-area-imageview"></a>

#### 認識領域ImageViewに描画

```objc

- (void)viewDidLoad {
    [super viewDidLoad];

    // 認識した画像を返すように設定
    [NHNCloudOCR setDetectedImageReturn:YES];
}

// クレジットカードの認識結果を返す
- (void)didDetectCreditCardInfo:(nullable NHNCloudCreditCardInfo *)cardInfo error:(nullable NSError *)error {

    if (cardInfo.detectedImage != nil) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:cardInfo.detectedImage.image];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
          
        UIGraphicsBeginImageContextWithOptions(imageView.frame.size, NO, 0.0);
        CGContextRef context = UIGraphicsGetCurrentContext();

        [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
        
        // カード番号の認識領域を描画する。
        for (NSValue *rectValue in cardInfo.numberBoundingBoxes) {
            CGRect scaledBoundingBox = [self dividedRect:rectValue.CGRectValue
                                                 // デバイスの解像度を考慮してscaleの値で座標を分割します。
                                                   scale:[UIScreen mainScreen].scale];
            CGContextSetStrokeColorWithColor(context, [UIColor orangeColor].CGColor);
            CGContextSetLineWidth(context, 5.0);
            CGContextStrokeRect(context, scaledBoundingBox);
        }

        CGRect scaledValidThruBoundingBox = [self dividedRect:cardInfo.validThruBoundingBox
                                                        scale:[UIScreen mainScreen].scale];
        // 有効期限の認識領域を描画する。                 
        CGContextSetStrokeColorWithColor(context, [UIColor orangeColor].CGColor);
        CGContextSetLineWidth(context, 5.0);
        CGContextStrokeRect(context, scaledValidThruBoundingBox);
        
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();

        imageView.image = newImage;
                
        [self.view addSubview:imageView];
    }
}

- (CGRect)dividedRect:(CGRect)rect
                scale:(CGFloat)scale {
    return CGRectMake(rect.origin.x / scale, rect.origin.y / scale,
                      rect.size.width / scale, rect.size.height / scale);
}

```

<a id="example-of-initialization-process"></a>

### 初期化プロセス例

``` objc
#import <NHNCloudOCR/NHNCloudOCR.h>

@interface ViewController () <NHNCloudCreditCardRecognizerDelegate>
@end

@implementation ViewController

- (void)initializeOCR {
    // 初期化およびDelegate設定
    NHNCloudOCRConfiguration *configuration = [NHNCloudOCRConfiguration configurationWithAppKey:@"{AppKey}" secret:@"{Secret}"];

    // 検出イメージリターン設定 
    [NHNCloudOCR setDetectedImageReturn:YES];

    // 初期化  
    [NHNCloudOCR initWithConfiguration:configuration];

    // Delegate設定
    [NHNCloudOCR setCreditCardRecognizerDelegate:self];
}

// クレジットカード認識結果を返す
- (void)didDetectCreditCardInfo:(nullable NHNCloudCreditCardInfo *)cardInfo error:(nullable NSError *)error {
    NSLog(@"didDetectCreditCardInfo : cardInfo : %@", cardInfo);
    NSLog(@"didDetectCreditCardInfo : error : %@", error);
}

// スクリーンキャプチャイベント受信
- (void)didDetectCreditCardSecurityEvent:(NHNCloudSecurityEvent)event {

    // スクリーンキャプチャ警告Alert出力例
    if (event == NHNCloudSecurityEventScreenshot || event == NHNCloudSecurityEventScreenRecordingOn) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"キャプチャが検出されました。" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    // 動画録画時、空の画面出力例
    if (event == NHNCloudSecurityEventScreenRecordingOn || event == NHNCloudSecurityEventScreenRecordingOff) {
        if ([[UIScreen mainScreen] isCaptured] ) {
            [[[UIApplication sharedApplication] windows] firstObject].hidden = YES;
        } else {
            [[[UIApplication sharedApplication] windows] firstObject].hidden = NO;
        }
    }
}

// 確認ボタンイベント受信(NHNCloudCreditCardRecognizerViewController継承実装時にのみ受信可能)
- (void)creditCardRecognizerViewControllerConfirm {
    // クレジットカード認識結果画面で確認ボタンを押した場合の処理
}

// 閉じるボタンイベント受信(NHNCloudCreditCardRecognizerViewController継承実装時にのみ受信可能)
- (void)creditCardRecognizerViewControllerCancel {
    // クレジットカードの認識または結果画面で閉じるボタンを押した時の処理
}

@end
```

<a id="how-to-apply-credit-card"></a>

## Credit Card適用方法

<a id="nhncloudcreditcardrecognizerviewcontroller"></a>

### NHNCloudCreditCardRecognizerViewController

<a id="use-credit-card-recognizer-viewcontroller"></a>

#### 1. Credit-Card Recognizer ViewControllerを使用する
* NHNCloudCreditCardRecognizerViewControllerを継承実装したClassをStoryboardのViewControllerに接続して基本UIが適用されたCredit-Card Recognizerを簡単に使用できます。

<a id="create-class"></a>

#### 2. Class作成
![default_viewcontroller](https://static.toastoven.net/toastcloud/sdk/ios/default_viewcontroller.png)
* NHNCloudCreditCardRecognizerViewControllerをsubclassに持つViewController Classを作成します。 


<a id="connect-to-storyboard"></a>

#### 3. Storyboardに接続
![create_viewcontroller](https://static.toastoven.net/toastcloud/sdk/ios/create_viewcontroller.png)
* StoryboardにViewControllerを追加します。

![custom_class](https://static.toastoven.net/toastcloud/sdk/ios/custom_class.png)
* 追加したViewControllerにCustom Classに作成したClassを設定します。

![segue_viewcontroller](https://static.toastoven.net/toastcloud/sdk/ios/segue_viewcontroller.png)
* ViewController Segue Eventを設定します。 

* Delegateを設定し、実装します。 

<a id="customize-nhncloudcreditcardrecognizerserviceviewcontroller"></a>

### NHNCloudCreditCardRecognizerServiceViewControllerカスタマイズ
* NHNCloudCreditCardRecognizerServiceViewControllerを使用してUIをカスタマイズできます。
  * **Credit-Cardガイドの場合、あらかじめ定義された値を使用するため、変更ができません。**

<a id="inherit-nhncloudcreditcardrecognizerserviceviewcontroller"></a>

#### 1. NHNCloudCreditCardRecognizerServiceViewController継承 
* NHNCloudCreditCardRecognizerServiceViewControllerを継承実装してカスタマイズできます。

##### Override関数の仕様
```objc

// ビューがメモリに作成される時、初期設定やデータの準備作業を実行
- (void)viewDidLoad;

// ビューが画面に表示される直前に最後の処理を実行
- (void)viewWillAppear:(BOOL)animated;

// ビューが画面から消える直前にクリーンアップを実行
- (void)viewWillDisappear:(BOOL)animated;

// ビューが画面から完全に消えた後、追加のクリーンアップを実行
- (void)viewDidDisappear:(BOOL)animated;

// Custom UI更新 
- (void)didUpdateCreditCardGuide:(CGRect)rect orientation:(NHNCloudCreditCardOrientation)orientation;

// クレジットカード認識時、UI更新
- (void)imageDidDetect:(BOOL)detected;
```

##### Override使用例
```objc

@interface OCRViewController : NHNCloudCreditCardRecognizerServiceViewController <NHNCloudCreditCardRecognizerDelegate>

@end

@implementation OCRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [NHNCloudOCR setCreditCardRecognizerDelegate:self];
    // Custom UI作成
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self startRunning];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)didUpdateCreditCardGuide:(CGRect)rect orientation:(NHNCloudCreditCardOrientation)orientation {
    [super didUpdateCreditCardGuide:rect orientation:orientation];
    
    // Custom UI更新 
}

- (void)imageDidDetect:(BOOL)detected {
    [super imageDidDetect:detected];

    // クレジットカード認識時、UI更新
}

- (void)didDetectCreditCardInfo:(nullable NHNCloudCreditCardInfo *)cardInfo error:(nullable NSError *)error {
    
    NSLog(@"didDetectCreditCardInfo : cardInfo : %@", cardInfo);
    NSLog(@"didDetectCreditCardInfo : error : %@", error);
}

```


<a id="use-test-environment"></a>

### テスト環境を使用する
* NHNCloudOCR SDKでテストのために提供するCredit-Cardガイドを使用してOCRをテストできます。
  * クレジットカードがCredit-Cardガイド内に存在する場合、OCRが始まります。
    * デフォルト値はhiddenで、目に見えないガイドが存在します。
    * `enableTestGuide`を使用してテスト用のガイドを出力できます。 

<a id="specification-for-credit-card-guide"></a>

#### Credit-CardガイドAPI仕様
```objc
@interface NHNCloudOCRConfiguration : NSObject
- (void)enableTestGuide;
@end
```
<a id="example-of-using-credit-card-guide"></a>

#### Credit-Cardガイドの使用例

```objc
- (void)initializeOCR {
    // 初期化およびDelegate設定
    NHNCloudOCRConfiguration *configuration = [NHNCloudOCRConfiguration configurationWithAppKey:@"{AppKey}" secret:@"{Secret}" ];
    
    [configuration enableTestGuide];
        
    [NHNCloudOCR initWithConfiguration:configuration];

    [NHNCloudOCR setCreditCardRecognizerDelegate:self];
}
```

<a id="control-credit-card-recognizer-viewcontroller"></a>

## Credit-Card Recognizer ViewControllerを制御する

> `Credit Card適用方法`を見てNHNCloudCreditCardRecognizerViewControllerまたはNHNCloudCreditCardRecognizerServiceViewController継承実装必要

<a id="credit-card-recognizer-startstop"></a>

### 1. Credit-Card Recognizerの開始/停止
* Credit-Card Recognizerを開始または停止します。

<a id="specification-for-start-or-stop-credit-card-recognizer"></a>

#### Credit-Card Recognizer開始/停止API仕様
```objc
- (void)startRunning;
- (void)stopRunning;
- (BOOL)isRunning;
```
<a id="example-of-start-or-stop-credit-card-recognizer"></a>

#### Credit-Card Recognizer開始/停止の使用例
```objc
- (void)start {
  [self startRunning];
}

// クレジットカード認識結果を返す
- (void)didDetectCreditCardInfo:(nullable NHNCloudCreditCardInfo *)cardInfo error:(nullable NSError *)error {
    [self stopRunning];
}
```

<a id="rotate-credit-card-guide"></a>

### 2. Credit-Cardガイドの回転
* クレジットカードの方向に合うようにCredit-Cardガイドを回転させることができます。

<a id="specification-for-rotate-credit-card-guide"></a>

#### Credit-Cardガイド回転API仕様
```objc
@property (assign, nonatomic, readonly) CGRect creditCardGuide;
@property (assign, nonatomic, readonly) NHNCloudCreditCardOrientation creditCardGuideOrientation;
- (void)rotateCreditCardGuideOrientation;
```
<a id="example-of-using-rotate-credit-card-guide"></a>

#### Credit-Cardガイド回転の使用例
```objc
typedef NS_ENUM(NSInteger, NHNCloudCreditCardOrientation) {

    NHNCloudCreditCardOrientationPortrait = 0,
    NHNCloudCreditCardOrientationLandscape = 1
};

- (void)rotateButtonAction:(UIButton *)button {

    [self rotateCreditCardGuideOrientation];

    NSLog(@"x: %f y: %f width: %f height: %f", self.creditCardGuide.origin.x,
          self.creditCardGuide.origin.y,
          self.creditCardGuide.size.width,
          self.creditCardGuide.size.height);

    NSLog(@"creditCardGuideOrientation: %ld", self.creditCardGuideOrientation);
}

```

<a id="light-enabledisable"></a>

### 3. フラッシュ有効/無効
* デバイスのカメラフラッシュを有効または無効にします。

<a id="specification-for-enabledisable-light-api"></a>

#### フラッシュ有効/無効API仕様
```objc
- (void)enableTorchMode;
- (void)disableTorchMode;
- (BOOL)isEnableTorchMode;
```
<a id="example-of-enable-or-disable-the-camera-light-of-a-device"></a>

#### フラッシュ有効/無効の使用例
```objc
- (void)torchButtonAction:(UIButton *)button {    
    if ([self isEnableTorchMode] == YES) {
        [self disableTorchMode];
    } else {
        [self enableTorchMode];
    }
}

```


<a id="enabledisable-camera"></a>

### 4. カメラ有効/無効
* デバイスのカメラを有効または無効にします。

<a id="specification-for-enabledisable-camera"></a>

#### カメラ有効/無効API仕様
```objc
- (void)startRunningCamera;
- (void)stopRunningCamera;
- (BOOL)isRunnginCamera;
```
<a id="example-of-enabledisable-camera"></a>

#### カメラ有効/無効使用例
```objc
- (void)cameraButtonAction:(UIButton *)button {    
    if ([self isRunnginCamera] == YES) {
        [self stopRunningCamera];
    } else {
        [self startRunningCamera];
    }
}

```
