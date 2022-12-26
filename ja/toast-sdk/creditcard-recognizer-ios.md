## NHN Cloud > SDK User Guide > Document Recognizer > Credit Card (iOS)

## 事前準備

1. [NHN Cloud SDK](./getting-started-ios)をインストールします。
2. [NHN Cloud Console](https://console.nhncloud.com)で[AI Service > Document Recognizer]サービスを有効にします。
3. Document RecognizerコンソールでAppKeyとSecretKeyを確認します。

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

### 2. バイナリをダウンロードしてNHN Cloud SDK適用

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
  * AI Service -> Document Recognizer -> クレジットカード
* NHNCloudOCRは初期化にNHNCloudOCRConfigurationオブジェクトをパラメータとして使用します。
* カメラ使用権限を取得するためにinfo.plistに以下の内容を追加します。
```
Key : NSCameraUsageDescription
Value： [カメラ権限リクエストメッセージ]
```

## 初期化API仕様

``` objc
// 初期化
+ (void)initWithConfiguration:(NHNCloudOCRConfiguration *)configuration;
// Delegate設定
+ (void)setDelegate:(nullable id<NHNCloudCreditCardRecognizerDelegate>)delegate;
// 初期化およびDelegate設定
+ (void)initWithConfiguration:(NHNCloudOCRConfiguration *)configuration
                     delegate:(nullable id<NHNCloudCreditCardRecognizerDelegate>)delegate;
```

### Delegate API仕様
* NHNCloudCreditCardRecognizerDelegateを登録すると、認識結果に対する通知を受け取ることができます。
* OCRが実行中の時、画面のスクリーンキャプチャと動画録画イベントを受信できません。

``` objc
@protocol NHNCloudCreditCardRecognizerDelegate <NSObject>

- (void)didDetectCreditCardInfo:(nullable NHNCloudCreditCardInfo *)cardInfo error:(nullable NSError *)error;
@optional
- (void)didDetectSecurityEvent:(NHNCloudSecurityEvent)event;

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
    [NHNCloudOCR initWithConfiguration:configuration delegate:self];
}

// クレジットカード認識結果を返す
- (void)didDetectCreditCardInfo:(nullable NHNCloudCreditCardInfo *)cardInfo error:(nullable NSError *)error {
    NSLog(@"didDetectCreditCardInfo : cardInfo : %@", cardInfo);
    NSLog(@"didDetectCreditCardInfo : error : %@", error);
}

// スクリーンキャプチャイベント受信
- (void)didDetectSecurityEvent:(NHNCloudSecurityEvent)event {

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

@end
```

## NHNCloudCreditCardRecognizerViewController

### 1. Credit-Card Recognizer ViewControllerを使用する
* NHNCloudCreditCardRecognizerViewControllerを継承実装したClassをStoryboardのViewControllerに接続して基本UIが適用されたCredit-Card Recognizerを簡単に使用できます。

#### Class作成
![default_viewcontroller](https://static.toastoven.net/toastcloud/sdk/ios/default_viewcontroller.png)
* NHNCloudCreditCardRecognizerViewControllerをsubclassに持つViewController Classを作成します。 


#### Storyboardに接続
![create_viewcontroller](https://static.toastoven.net/toastcloud/sdk/ios/create_viewcontroller.png)
* StoryboardにViewControllerを追加します。

![custom_class](https://static.toastoven.net/toastcloud/sdk/ios/custom_class.png)
* 追加したViewControllerにCustom Classに作成したClassを設定します。

![segue_viewcontroller](https://static.toastoven.net/toastcloud/sdk/ios/segue_viewcontroller.png)
* ViewController Segue Eventを設定します。 

* Delegateを設定し、実装します。 

### 2. テスト環境を使用する
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
        
    [NHNCloudOCR initWithConfiguration:configuration delegate:self];
}
```

### 3. Credit-Card Recognizer ViewControllerを制御する
#### 1. Credit-Card Recognizer ViewControllerを開く
* クレジットカード認識のためにクレジットカードリーダーが含まれるViewControllerを開きます。
* SDKで開く方法とViewControllerを返し、開発者が好きな方法で直接開く方法を使用できます。

##### Credit-Card Recognizer ViewController開くAPI仕様

```objc
// CreditCard Recognizer ViewControllerをSDKから出力します。
+ (NHNCloudCreditCardRecognizerViewController *)openCreditCardRecognizerViewController;

// CreditCard Recognizer ViewControllerを返します。ユーザーが直接出力するか、SDKに有効になっているオブジェクトを返すことができます。
+ (nullable NHNCloudCreditCardRecognizerViewController *)creditCardRecognizerViewController;
```

##### Credit-Card Recognizer ViewControllerを開く使用例
```objc
// SDKでRecognizer ViewControllerを開きます。
[NHNCloudOCR openCreditCardRecognizerViewController];

// SDKでRecognizer ViewControllerを返し、開発者が好きな方法で直接開くようにします。
NHNCloudCreditCardRecognizerViewController *creditCardRecognizerViewController = [NHNCloudOCR creditCardRecognizerViewController];
[self presentViewController:creditCardRecognizerViewController animated:YES completion:nil];

```

#### 2. Credit-Card Recognizer ViewController閉じる
* クレジットカードリーダーが含まれるViewControllerを閉じます

##### Credit-Card Recognizer ViewControllerを閉じるAPI仕様

```objc
- (void)dismissViewController;
```

##### Credit-Card Recognizer ViewControllerを閉じる使用例
```objc
- (void)closeButton:(id)sender {
    [[NHNCloudOCR creditCardRecognizerViewController] dismissViewController];
}
```

#### 3. Credit-Card Recognizerの開始/停止
* Credit-Card Recognizerを開始または停止します。

##### Credit-Card Recognizer開始/停止API仕様
```objc
- (void)startRunning;
- (void)stopRunning;
- (BOOL)isRunning;
```
##### Credit-Card Recognizer開始/停止の使用例
```objc

- (void)openAndStart {
  [NHNCloudOCR openCreditCardRecognizerViewController];
  [[NHNCloudOCR creditCardRecognizerViewController] startRunning];
}

// クレジットカード認識結果を返す
- (void)didDetectCreditCardInfo:(nullable NHNCloudCreditCardInfo *)cardInfo error:(nullable NSError *)error {
    [[NHNCloudOCR creditCardRecognizerViewController] stopRunning];
}
```

#### 4. Credit-Cardガイドの回転
* クレジットカードの方向に合うようにCredit-Cardガイドを回転させることができます。

##### Credit-Cardガイド回転API仕様
```objc
@property (assign, nonatomic, readonly) CGRect creditCardGuide;
@property (assign, nonatomic, readonly) NHNCloudCreditCardOrientation creditCardGuideOrientation;
- (void)rotateCreditCardGuideOrientation;
```
##### Credit-Cardガイド回転の使用例
```objc
typedef NS_ENUM(NSInteger, NHNCloudCreditCardOrientation) {

    NHNCloudCreditCardOrientationPortrait = 0,
    NHNCloudCreditCardOrientationLandscape = 1
};

- (void)rotateButtonAction:(UIButton *)button {

    [[NHNCloudOCR creditCardRecognizerViewController] rotateCreditCardGuideOrientation];

    NSLog(@"x: %f y: %f width: %f height: %f", [NHNCloudOCR creditCardRecognizerViewController].creditCardGuide.origin.x,
          [NHNCloudOCR creditCardRecognizerViewController].creditCardGuide.origin.y,
          [NHNCloudOCR creditCardRecognizerViewController].creditCardGuide.size.width,
          [NHNCloudOCR creditCardRecognizerViewController].creditCardGuide.size.height);

    NSLog(@"creditCardGuideOrientation: %ld", [NHNCloudOCR creditCardRecognizerViewController].creditCardGuideOrientation);
}

```

#### 5. フラッシュ有効/無効
* デバイスのカメラフラッシュを有効または無効にします。

##### フラッシュ有効/無効API仕様
```objc
- (void)enableTorchMode;
- (void)disableTorchMode;
- (BOOL)isEnableTorchMode;
```
##### フラッシュ有効/無効の使用例
```objc
- (void)torchButtonAction:(UIButton *)button {    
    if ([[NHNCloudOCR creditCardRecognizerViewController] isEnableTorchMode] == YES) {
        [[NHNCloudOCR creditCardRecognizerViewController] disableTorchMode];
    } else {
        [[NHNCloudOCR creditCardRecognizerViewController] enableTorchMode];
    }
}

```


#### 6. カメラ有効/無効
* デバイスのカメラを有効または無効にします。

##### カメラ有効/無効API仕様
```objc
- (void)startRunningCamera;
- (void)stopRunningCamera;
- (BOOL)isRunnginCamera;
```
##### カメラ有効/無効使用例
```objc
- (void)cameraButtonAction:(UIButton *)button {    
    if ([[NHNCloudOCR creditCardRecognizerViewController] isRunnginCamera] == YES) {
        [[NHNCloudOCR creditCardRecognizerViewController] stopRunningCamera];
    } else {
        [[NHNCloudOCR creditCardRecognizerViewController] startRunningCamera];
    }
}

```

## NHNCloudCreditCardRecognizerServiceViewControllerカスタマイズ
* NHNCloudCreditCardRecognizerServiceViewControllerを使用してUIをカスタマイズできます。
  * **Credit-Cardガイドの場合、あらかじめ定義された値を使用するため、変更ができません。**

### 1. NHNCloudCreditCardRecognizerServiceViewController継承 
* NHNCloudCreditCardRecognizerServiceViewControllerを継承実装してカスタマイズできます。

#### Override関数の仕様
```objc
- (void)viewDidLoad;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (void)viewDidDisappear:(BOOL)animated;
- (void)didUpdateCreditCardGuide:(CGRect)rect orientation:(NHNCloudCreditCardOrientation)orientation;
- (void)imageDidDetect:(BOOL)detected;
```

#### Override使用例
```objc

@interface OCRViewController : NHNCloudCreditCardRecognizerServiceViewController <NHNCloudCreditCardRecognizerDelegate>

@end

@implementation OCRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [NHNCloudOCR setDelegate:self];
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
