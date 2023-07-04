## NHN Cloud > SDK User Guide > OCR > Credit Card (iOS)

## Prerequisites

1. Install [NHN Cloud SDK](./getting-started-ios).
2. Enable [AI Service > OCR] in[NHN Cloud Console](https://console.nhncloud.com).
3. Check Appkey and SecretKey in OCR Console.

<br>

## Supported Environment

NHN Cloud OCR operates in iOS 11.0 or higher.<br>

## Configuration of NHN Cloud OCR

The configuration of NHN Cloud OCR SDK for iOS is as follows.

| Service  | Cocoapods Pod Name | Framework | Dependency | Build Settings |
| --- | --- | --- | --- | --- |
| OCR | NHNCloudOCR | NHNCloudOCR.framework | \* Vision.framework<br/> \* AVFoundation.framework | |
| Mandatory   | NHNCloudCore<br/>NHNCloudCommon | NHNCloudCore.framework<br/>NHNCloudCommon.framework | | OTHER_LDFLAGS = (<br/>    "-ObjC",<br/>    "-lc++" <br/>); |


## Apply NHN Cloud OCR SDK to Xcode Project

### 1. Apply with Cococapods

* Add Pod for NHN Cloud SDK by creating a pod file.

```podspec
platform :ios, '11.0'
use_frameworks!

target '{YOUR PROJECT TARGET NAME}' do
    pod 'NHNCloudOCR'
end
```

### 2. Apply NHN Cloud SDK with with Swift Package Manager

* Go to **File > Add Packages...** from XCode.
* For the Package URL, enter 'https://github.com/nhn/nhncloud.ios.sdk' and select **Add Package**.
* Select NHNCloudOCR.

![swift_package_manager](https://static.toastoven.net/toastcloud/sdk/ios/swiftpackagemanager01.png)

#### Set up Project

* Add **-lc++** and **-ObjC** entries to **Other Linker Flags** in **Build Settings**.
    * **Project Target > Build Settings > Linking > Other Linker Flags**
![other_linker_flags](https://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags_202206.png)

### 3. Apply NHN Cloud SDK by Downloading Binaries

#### Set up Framework

* You can download the full iOS SDK from the NHN Cloud [Downloads](../../../Download/#toast-sdk) page.
* Add  **NHNCloudOCR.framework**, **NHNCloudCore.framework**, and **NHNCloudCommon.framework, vision.framework, AVFoundation.framework** to Xcode Project.
* You can add vision.framework and AVFoundation.framework as follows. 
![linked_vision_frameworks](https://static.toastoven.net/toastcloud/sdk/ios/linked_vision_frameworks.png)
![linked_avfoundation_frameworks](https://static.toastoven.net/toastcloud/sdk/ios/linked_avfoundation_frameworks.png)
![linked_frameworks_ocr](https://static.toastoven.net/toastcloud/sdk/ios/linked_frameworks_ocr.png)

#### Set up Project

* Add **-lc++**  and **-ObjC** to **Other Linker Flags** of **Build Settings**.
    * **Project Target > Build Settings > Linking > Other Linker Flags**
![other_linker_flags](https://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags_202206.png)

## Initialize NHNCLOUDOCR SDK
* Set AppKey and Secret issued from NHN Cloud Console in NHNCloudOCRConfiguration object.
  * AI Service > OCR > Document OCR > Credit Card
* NHNCloudOCR uses an NHNCloudOCRConfiguration object as a parameter for initialization.
* To get a permission to use camera, add the following items to info.plist.
```
Key : NSCameraUsageDescription
Value : [Camera Permission Request Message]
```

### Specification for Initialization API

``` objc
// Initialize
+ (void)initWithConfiguration:(NHNCloudOCRConfiguration *)configuration;

// Set Delegate
+ (void)setCreditCardRecognizerDelegate:(nullable id<NHNCloudCreditCardRecognizerDelegate>)delegate;
```

### Specification for Delegate API
* You can be notified of the recognition result when  NHNCloudCreditCardRecognizerDelegate is registered.
* When OCR is running, you can receive screen capture and video recording events.
* SDK에서 제공하는 기본 화면 사용 시(NHNCloudCreditCardRecognizerViewController 상속 구현) 닫기, 확인 이벤트를 수신 받을 수 있습니다.

``` objc
@protocol NHNCloudCreditCardRecognizerDelegate <NSObject>

// Return credit card recognition result
- (void)didDetectCreditCardInfo:(nullable NHNCloudCreditCardInfo *)cardInfo error:(nullable NSError *)error;

@optional

// Receive screen capture event
- (void)didDetectCreditCardSecurityEvent:(NHNCloudSecurityEvent)event;

// 닫기 버튼 이벤트 수신 (NHNCloudCreditCardRecognizerViewController 상속 구현 시에만 수신 가능)
- (void)creditCardRecognizerViewControllerCancel;

// 확인 버튼 이벤트 수신 (NHNCloudCreditCardRecognizerViewController 상속 구현 시에만 수신 가능)
- (void)creditCardRecognizerViewControllerConfirm;

@end
```

### Set up Detected Image Return
* NHNCloudCreditCardInfo data, which is the OCR result, can be returned together with the detected image. 
    * Default is disabled. 
#### Specification for Setting up Detected Image Return API 
```objc
@interface NHNCloudOCR : NSObject
//..
+ (void)setDetectedImageReturn:(BOOL)enable;
+ (BOOL)isEnableDetectedImageReturn;
//..
@end
```

### Example of Initialization Process

``` objc
#import <NHNCloudOCR/NHNCloudOCR.h>

@interface ViewController () <NHNCloudCreditCardRecognizerDelegate>
@end

@implementation ViewController

- (void)initializeOCR {
    // Initialize and set Delegate
    NHNCloudOCRConfiguration *configuration = [NHNCloudOCRConfiguration configurationWithAppKey:@"{AppKey}" secret:@"{Secret}"];

    // Set detected image return 
    [NHNCloudOCR setDetectedImageReturn:YES];

    // Initialize
    [NHNCloudOCR initWithConfiguration:configuration];

    // Set Delegate
    [NHNCloudOCR setCreditCardRecognizerDelegate:self];
}

// Return credit card recognition result
- (void)didDetectCreditCardInfo:(nullable NHNCloudCreditCardInfo *)cardInfo error:(nullable NSError *)error {
    NSLog(@"didDetectCreditCardInfo : cardInfo : %@", cardInfo);
    NSLog(@"didDetectCreditCardInfo : error : %@", error);
}

// Receive screen capture event
- (void)didDetectCreditCardSecurityEvent:(NHNCloudSecurityEvent)event {

    // Example of screen capture warning alert output
    if (event == NHNCloudSecurityEventScreenshot || event == NHNCloudSecurityEventScreenRecordingOn) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"Capture is detected." preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    // Example of blank screen output when recording video
    if (event == NHNCloudSecurityEventScreenRecordingOn || event == NHNCloudSecurityEventScreenRecordingOff) {
        if ([[UIScreen mainScreen] isCaptured] ) {
            [[[UIApplication sharedApplication] windows] firstObject].hidden = YES;
        } else {
            [[[UIApplication sharedApplication] windows] firstObject].hidden = NO;
        }
    }
}

// 확인 버튼 이벤트 수신 (NHNCloudCreditCardRecognizerViewController 상속 구현 시에만 수신 가능)
- (void)creditCardRecognizerViewControllerConfirm {
    // 신용카드 인식 결과 화면에서 확인 버튼을 눌렀을 때의 처리
}

// 닫기 버튼 이벤트 수신 (NHNCloudCreditCardRecognizerViewController 상속 구현 시에만 수신 가능)
- (void)creditCardRecognizerViewControllerCancel {
    // 신용카드 인식 혹은 결과 화면에서 닫기 버튼을 눌렀을 때의 처리
}

@end
```

## Credit Card 적용 방법

### NHNCloudCreditCardRecognizerViewController

#### 1. Use Credit-Card Recognizer ViewController
* You can easily use Credit-Card Recognizer to which the default UI is applied by connecting the Class implemented with inheritance of NHNCloudCreditCardRecognizerViewController to the ViewController of Storyboard.

#### 2. Create Class 
![default_viewcontroller](https://static.toastoven.net/toastcloud/sdk/ios/default_viewcontroller.png)
* Create ViewController Class that contains NHNCloudCreditCardRecognizerViewController as Subclass. 


#### 3. Connect to Storyboard
![create_viewcontroller](https://static.toastoven.net/toastcloud/sdk/ios/create_viewcontroller.png)
* Add ViewController to Storyboard.

![custom_class](https://static.toastoven.net/toastcloud/sdk/ios/custom_class.png)
* In the added ViewController, configure the class created in Custom Class.

![segue_viewcontroller](https://static.toastoven.net/toastcloud/sdk/ios/segue_viewcontroller.png)
* Set ViewController Segue Event. 

* Set and implement Delegate. 

### Customizing NHNCloudCreditCardRecognizerServiceViewController
* You can perform customizing of NHNCloudCreditCardRecognizerServiceViewController.
  * **The Credit-Card guide cannot be changed because pre-defined values are used.**

#### 1. Inherit NHNCloudCreditCardRecognizerServiceViewController 
* You can perform customizing by implementing inheritance of NHNCloudCreditCardRecognizerServiceViewController.

##### Specification for Override Function
```objc

// 뷰가 메모리에 만들어질 때 초기 설정 및 데이터 준비 작업을 수행
- (void)viewDidLoad;

// 뷰가 화면에 나타나기 직전에 마지막 작업을 수행
- (void)viewWillAppear:(BOOL)animated;

// 뷰가 화면에서 사라지기 직전에 정리 작업을 수행
- (void)viewWillDisappear:(BOOL)animated;

// 뷰가 화면에서 완전히 사라진 후 추가적인 정리 작업을 수행
- (void)viewDidDisappear:(BOOL)animated;

// Update Custom UI
- (void)didUpdateCreditCardGuide:(CGRect)rect orientation:(NHNCloudCreditCardOrientation)orientation;

// Update UI for credit card recognition
- (void)imageDidDetect:(BOOL)detected;
```

##### Example of using Override
```objc

@interface OCRViewController : NHNCloudCreditCardRecognizerServiceViewController <NHNCloudCreditCardRecognizerDelegate>

@end

@implementation OCRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [NHNCloudOCR setCreditCardRecognizerDelegate:self];
    // Create Custom UI
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
    
    // Update Custom UI  
}

- (void)imageDidDetect:(BOOL)detected {
    [super imageDidDetect:detected];

    // Update UI for credit card recognition
}

- (void)didDetectCreditCardInfo:(nullable NHNCloudCreditCardInfo *)cardInfo error:(nullable NSError *)error {
    
    NSLog(@"didDetectCreditCardInfo : cardInfo : %@", cardInfo);
    NSLog(@"didDetectCreditCardInfo : error : %@", error);
}

```

### Use Test Environment 
* You can test OCR by using the Credit-Card guide provided to test NHNCloudOCR SDK.
  * OCR is initiated when a credit card exists in the Credit-Card guide.
    * Default value is hidden so that there is an invisible guide.
    * You can output a guide for testing by using `enableTestGuide`. 

#### Specification for Credit-Card Guide
```objc
@interface NHNCloudOCRConfiguration : NSObject
- (void)enableTestGuide;
@end
```
#### Example of using Credit-Card guide

```objc
- (void)initializeOCR {
    // Initialize and set Delegate
    NHNCloudOCRConfiguration *configuration = [NHNCloudOCRConfiguration configurationWithAppKey:@"{AppKey}" secret:@"{Secret}" ];
    
    [configuration enableTestGuide];
        
    [NHNCloudOCR initWithConfiguration:configuration];

    [NHNCloudOCR setCreditCardRecognizerDelegate:self];
}
```

## Control Credit-Card Recognizer ViewController

> `Credit Card 적용 방법`을 보고 NHNCloudCreditCardRecognizerViewController 또는 NHNCloudCreditCardRecognizerServiceViewController 상속 구현 필요

### 1. Credit-Card Recognizer Initiate/Stop
* Initiate or stop Credit-Card Recognizer.

#### Specification for Initiate/Stop Credit-Card Recognizer.
```objc
- (void)startRunning;
- (void)stopRunning;
- (BOOL)isRunning;
```
#### Example of initiate or stop Credit-Card Recognizer
```objc

- (void)start {
  [self startRunning];
}

// Return the credit card recognition result
- (void)didDetectCreditCardInfo:(nullable NHNCloudCreditCardInfo *)cardInfo error:(nullable NSError *)error {
    [self stopRunning];
}
```

### 2. Rotate Credit-Card Guide
* You can rotate the Credit-Card guide according to the direction of a credit card.

#### Specification for Rotate Credit-Card Guide
```objc
@property (assign, nonatomic, readonly) CGRect creditCardGuide;
@property (assign, nonatomic, readonly) NHNCloudCreditCardOrientation creditCardGuideOrientation;
- (void)rotateCreditCardGuideOrientation;
```
#### Example of using Rotate Credit-Card Guide
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

### 3. Enable/Disable Light
* Enable or disable the camera light of a device.

#### Specification for Enable/Disable Light API
```objc
- (void)enableTorchMode;
- (void)disableTorchMode;
- (BOOL)isEnableTorchMode;
```
#### Example of enabling or disabling the camera light of a device.
```objc
- (void)torchButtonAction:(UIButton *)button {    
    if ([self isEnableTorchMode] == YES) {
        [self disableTorchMode];
    } else {
        [self enableTorchMode];
    }
}

```

### 4. Enable/Disable Camera
* Enable or disable a device’s camera.

#### Specification for Enable/Disable Camera
```objc
- (void)startRunningCamera;
- (void)stopRunningCamera;
- (BOOL)isRunnginCamera;
```
#### Example of enabling or disabling camera
```objc
- (void)cameraButtonAction:(UIButton *)button {    
    if ([self isRunnginCamera] == YES) {
        [self stopRunningCamera];
    } else {
        [self startRunningCamera];
    }
}

```
