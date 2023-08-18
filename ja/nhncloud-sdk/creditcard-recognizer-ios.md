## NHN Cloud > SDK User Guide >OCR > Credit Card (iOS)

## 事前準備

1. [NHN Cloud SDK](./getting-started-ios)をインストールします。
2. [NHN Cloud Console](https://console.nhncloud.com)で[AI Service > OCR]サービスを有効にします。
3. OCRコンソールでAppKeyとSecretKeyを確認します。

<br>

## サポート環境

NHN Cloud OCRはiOS 11.0以上で動作します。<br>

## NHN Cloud OCR構成

iOS用NHN Cloud OCR SDKの構成は次のとおりです。

| Service  | Cocoapods Pod Name | Framework | Dependency | Build Settings |
| --- | --- | --- | --- | --- |
| IAP | NHNCloudOCR | NHNCloudOCR.framework | * Vision.framework<br/> * AVFoundation.framework | |
| Mandatory   | NHNCloudCore<br/>NHNCloudCommon | NHNCloudCore.framework<br/>NHNCloudCommon.framework | | OTHER_LDFLAGS = (<br/>    "-ObjC",<br/>    "-lc++" <br/>); |


## NHN Cloud OCR SDKをXcodeプロジェクトに適用

### 1. Cococapodsを利用した適用

* Podfileを作成してNHN Cloud SDKに対するPodを追加します。

```podspec
platform :ios, '11.0'
use_frameworks!

target '{YOUR PROJECT TARGET NAME}' do
    pod 'NHNCloudOCR'
end
```

### 2. Swift Package Managerを使用してNHN Cloud SDK適用

* XCodeで**File > Add Packages...**メニューを選択します。
* Package URLに'https://github.com/nhn/nhncloud.ios.sdk'を入れて**Add Package**ボタンを選択します。
* NHNCloudOCRを選択します。

![swift_package_manager](https://static.toastoven.net/toastcloud/sdk/ios/swiftpackagemanager01.png)

#### プロジェクト設定

* **Build Settings**の **Other Linker Flags**に**-lc++**と**-ObjC**項目を追加します。
    * **Project Target > Build Settings > Linking > Other Linker Flags**
![other_linker_flags](https://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags_202206.png)

### 3. バイナリをダウンロードしてNHN Cloud SDK適用

#### フレームワーク設定

* NHN Cloud [Downloads](../../../Download/#toast-sdk)ページで全てのiOS SDKをダウンロードできます。
* Xcode Projectに**NHNCloudOCR.framework**、 **NHNCloudCore.framework**、 **NHNCloudCommon.framework、 vision.framework、 AVFoundation.framework**を追加します。
* vision.frameworkとAVFoundation.frameworkは、以下の方法で追加できます。
![linked_vision_frameworks](https://static.toastoven.net/toastcloud/sdk/ios/linked_vision_frameworks.png)
![linked_avfoundation_frameworks](https://static.toastoven.net/toastcloud/sdk/ios/linked_avfoundation_frameworks.png)
![linked_frameworks_ocr](https://static.toastoven.net/toastcloud/sdk/ios/linked_frameworks_ocr.png)

#### プロジェクト設定

* **Build Settings**の**Other Linker Flags**に**-lc++**と**-ObjC**項目を追加します。
    * **Project Target > Build Settings > Linking > Other Linker Flags**
![other_linker_flags](https://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags_202206.png)

## NHNCloudOCR SDK初期化
* NHN Cloud Consoleで発行されたAppKeyとSecretをNHNCloudOCRConfigurationオブジェクトに設定します。
  * AI Service -> OCR -> Document OCR -> クレジットカード
* NHNCloudOCRは初期化にNHNCloudOCRConfigurationオブジェクトをパラメータとして使用します。
* カメラ使用権限を取得するためにinfo.plistに以下の内容を追加します。
```
Key : NSCameraUsageDescription
Value： [カメラ権限リクエストメッセージ]
```

### 初期化API仕様

``` objc
// 初期化
+ (void)initWithConfiguration:(NHNCloudOCRConfiguration *)configuration;

// Delegate設定
+ (void)setCreditCardRecognizerDelegate:(nullable id<NHNCloudCreditCardRecognizerDelegate>)delegate;
```

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

### 検出イメージリターン設定を行う
* OCR結果であるNHNCloudCreditCardInfoデータに検出されたイメージを一緒に返すことができます。
    * デフォルト値は無効です。 
#### 検出イメージリターン設定API仕様 
```objc
@interface NHNCloudOCR : NSObject
//..
+ (void)setDetectedImageReturn:(BOOL)enable;
+ (BOOL)isEnableDetectedImageReturn;
//..
@end
```


### 인식 영역 표시하기

#### 인식 영역 반환 API
* OCR 결과인 NHNCloudCreditCardInfo 데이터에 인식된 영역의 좌표 정보를 반환 받을 수 있습니다.

```objc
@interface NHNCloudCreditCardInfo : NSObject

// 카드 번호 인식 영역
@property(nonatomic, strong, readonly, nullable) NSArray<NSValue *> *numberBoundingBoxes;

// 유효 기간 인식 영역
@property(nonatomic, assign, readonly) CGRect validThruBoundingBox;

@end

```

#### 인식 영역 ImageView에 그리기

```objc

- (void)viewDidLoad {
    [super viewDidLoad];
    // 인식된 이미지를 반환하도록 설정
    [NHNCloudOCR setDetectedImageReturn:YES];
}

// 신용카드 인식 결과 반환
- (void)didDetectCreditCardInfo:(nullable NHNCloudCreditCardInfo *)cardInfo error:(nullable NSError *)error {

    if (cardInfo.detectedImage != nil) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:cardInfo.detectedImage.image];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
          
        UIGraphicsBeginImageContextWithOptions(imageView.frame.size, NO, 0.0);
        CGContextRef context = UIGraphicsGetCurrentContext();

        [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
        
        // 카드 번호의 인식 영역을 그린다.
        for (NSValue *rectValue in cardInfo.numberBoundingBoxes) {
            CGRect scaledBoundingBox = [self dividedRect:rectValue.CGRectValue
                                                 // 디바이스의 해상도를 고려해 scale의 값 만큼 좌표를 나눈다.
                                                   scale:[UIScreen mainScreen].scale];
            CGContextSetStrokeColorWithColor(context, [UIColor orangeColor].CGColor);
            CGContextSetLineWidth(context, 5.0);
            CGContextStrokeRect(context, scaledBoundingBox);
        }

        CGRect scaledValidThruBoundingBox = [self dividedRect:cardInfo.validThruBoundingBox
                                                        scale:[UIScreen mainScreen].scale];
        // 유효 기간의 인식 영역을 그린다.                                                  
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

## Credit Card適用方法

### NHNCloudCreditCardRecognizerViewController

#### 1. Credit-Card Recognizer ViewControllerを使用する
* NHNCloudCreditCardRecognizerViewControllerを継承実装したClassをStoryboardのViewControllerに接続して基本UIが適用されたCredit-Card Recognizerを簡単に使用できます。

#### 2. Class作成
![default_viewcontroller](https://static.toastoven.net/toastcloud/sdk/ios/default_viewcontroller.png)
* NHNCloudCreditCardRecognizerViewControllerをsubclassに持つViewController Classを作成します。 


#### 3. Storyboardに接続
![create_viewcontroller](https://static.toastoven.net/toastcloud/sdk/ios/create_viewcontroller.png)
* StoryboardにViewControllerを追加します。

![custom_class](https://static.toastoven.net/toastcloud/sdk/ios/custom_class.png)
* 追加したViewControllerにCustom Classに作成したClassを設定します。

![segue_viewcontroller](https://static.toastoven.net/toastcloud/sdk/ios/segue_viewcontroller.png)
* ViewController Segue Eventを設定します。 

* Delegateを設定し、実装します。 

### NHNCloudCreditCardRecognizerServiceViewControllerカスタマイズ
* NHNCloudCreditCardRecognizerServiceViewControllerを使用してUIをカスタマイズできます。
  * **Credit-Cardガイドの場合、あらかじめ定義された値を使用するため、変更ができません。**

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


### テスト環境を使用する
* NHNCloudOCR SDKでテストのために提供するCredit-Cardガイドを使用してOCRをテストできます。
  * クレジットカードがCredit-Cardガイド内に存在する場合、OCRが始まります。
    * デフォルト値はhiddenで、目に見えないガイドが存在します。
    * `enableTestGuide`を使用してテスト用のガイドを出力できます。 

#### Credit-CardガイドAPI仕様
```objc
@interface NHNCloudOCRConfiguration : NSObject
- (void)enableTestGuide;
@end
```
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

## Credit-Card Recognizer ViewControllerを制御する

> `Credit Card適用方法`を見てNHNCloudCreditCardRecognizerViewControllerまたはNHNCloudCreditCardRecognizerServiceViewController継承実装必要

### 1. Credit-Card Recognizerの開始/停止
* Credit-Card Recognizerを開始または停止します。

#### Credit-Card Recognizer開始/停止API仕様
```objc
- (void)startRunning;
- (void)stopRunning;
- (BOOL)isRunning;
```
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

### 2. Credit-Cardガイドの回転
* クレジットカードの方向に合うようにCredit-Cardガイドを回転させることができます。

#### Credit-Cardガイド回転API仕様
```objc
@property (assign, nonatomic, readonly) CGRect creditCardGuide;
@property (assign, nonatomic, readonly) NHNCloudCreditCardOrientation creditCardGuideOrientation;
- (void)rotateCreditCardGuideOrientation;
```
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

### 3. フラッシュ有効/無効
* デバイスのカメラフラッシュを有効または無効にします。

#### フラッシュ有効/無効API仕様
```objc
- (void)enableTorchMode;
- (void)disableTorchMode;
- (BOOL)isEnableTorchMode;
```
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


### 4. カメラ有効/無効
* デバイスのカメラを有効または無効にします。

#### カメラ有効/無効API仕様
```objc
- (void)startRunningCamera;
- (void)stopRunningCamera;
- (BOOL)isRunnginCamera;
```
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
