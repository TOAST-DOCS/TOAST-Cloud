## NHN Cloud > SDK User Guide > Document Recognizer > Credit Card (iOS)

## Prerequisites

1. Install [NHN Cloud SDK](./getting-started-ios).
2. Enable [AI Service > Document Recognizer] in[NHN Cloud Console](https://console.nhncloud.com).
3. Check Appkey and SecretKey in Document Recognizer Console.

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

### Download binaries and apply to NHN Cloud SDK

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
  * AI Service > Document Recognizer > Credit Card
* NHNCloudOCR uses an NHNCloudOCRConfiguration object as a parameter for initialization.
* To get a permission to use camera, add the following items to info.plist.
```
Key : NSCameraUsageDescription
Value : [Camera Permission Request Message]
```

## Specification for Initialization API

``` objc
// Initialize
+ (void)initWithConfiguration:(NHNCloudOCRConfiguration *)configuration;
// Set Delegate
+ (void)setDelegate:(nullable id<NHNCloudCreditCardRecognizerDelegate>)delegate;
// Initialize and set Delegate
+ (void)initWithConfiguration:(NHNCloudOCRConfiguration *)configuration
                     delegate:(nullable id<NHNCloudCreditCardRecognizerDelegate>)delegate;
```

### Specification for Delegate API
* You can be notified of the recognition result when  NHNCloudCreditCardRecognizerDelegate is registered.
* When OCR is running, you can receive screen capture and video recording events.

``` objc
@protocol NHNCloudCreditCardRecognizerDelegate <NSObject>

- (void)didDetectCreditCardInfo:(nullable NHNCloudCreditCardInfo *)cardInfo error:(nullable NSError *)error;
@optional
- (void)didDetectSecurityEvent:(NHNCloudSecurityEvent)event;

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
    [NHNCloudOCR initWithConfiguration:configuration delegate:self];
}

// Return credit card recognition result
- (void)didDetectCreditCardInfo:(nullable NHNCloudCreditCardInfo *)cardInfo error:(nullable NSError *)error {
    NSLog(@"didDetectCreditCardInfo : cardInfo : %@", cardInfo);
    NSLog(@"didDetectCreditCardInfo : error : %@", error);
}

// Receive screen capture event
- (void)didDetectSecurityEvent:(NHNCloudSecurityEvent)event {

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

@end
```

## NHNCloudCreditCardRecognizerViewController

### 1. Use Credit-Card Recognizer ViewController
* You can easily use Credit-Card Recognizer to which the default UI is applied by connecting the Class implemented with inheritance of NHNCloudCreditCardRecognizerViewController to the ViewController of Storyboard.

#### Create Class 
![default_viewcontroller](https://static.toastoven.net/toastcloud/sdk/ios/default_viewcontroller.png)
* Create ViewController Class that contains NHNCloudCreditCardRecognizerViewController as Subclass. 


#### Connect to Storyboard
![create_viewcontroller](https://static.toastoven.net/toastcloud/sdk/ios/create_viewcontroller.png)
* Add ViewController to Storyboard.

![custom_class](https://static.toastoven.net/toastcloud/sdk/ios/custom_class.png)
* In the added ViewController, configure the class created in Custom Class.

![segue_viewcontroller](https://static.toastoven.net/toastcloud/sdk/ios/segue_viewcontroller.png)
* Set ViewController Segue Event. 

* Set and implement Delegate. 

### 2. Use Test Environment 
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
        
    [NHNCloudOCR initWithConfiguration:configuration delegate:self];
}
```

### 3. Control Credit-Card Recognizer ViewController
#### 1. Open Credit-Card Recognizer ViewController
* For credit card recognition, open ViewController that includes the credit card recognizer.
* You can open the Credit-Card Recognizer VIewController the way developers want by receiving the opening method and ViewController as a return from the SDK.

##### Specification for Open Credit-Card Recognizer ViewControlle API

```objc
// Output CreditCard Recognizer ViewController from the SDK.
+ (NHNCloudCreditCardRecognizerViewController *)openCreditCardRecognizerViewController;

// Return CreditCard Recognizer ViewController. The user can output it directly, or the object activated in the SDK can be returned.
+ (nullable NHNCloudCreditCardRecognizerViewController *)creditCardRecognizerViewController;
```

##### Example of opening Credit-Card Recognizer ViewController
```objc
// Open Recognizer ViewController from the SDK
[NHNCloudOCR openCreditCardRecognizerViewController];

// Let developers open Recognizer ViewController the way they want as the Recognizer ViewController is returned from the SDK.
NHNCloudCreditCardRecognizerViewController *creditCardRecognizerViewController = [NHNCloudOCR creditCardRecognizerViewController];
[self presentViewController:creditCardRecognizerViewController animated:YES completion:nil];

```

#### 2. Close Credit-Card Recognizer ViewController
* Close ViewController that includes credit-card recognizer.

##### Specification for Close Credit-Card Recognizer ViewController API

```objc
- (void)dismissViewController;
```

##### Example of Close Credit-Card Recognizer ViewController
```objc
- (void)closeButton:(id)sender {
    [[NHNCloudOCR creditCardRecognizerViewController] dismissViewController];
}
```

#### 3. Credit-Card Recognizer Initiate/Stop
* Initiate or stop Credit-Card Recognizer.

##### Specification for Initiate/Stop Credit-Card Recognizer.
```objc
- (void)startRunning;
- (void)stopRunning;
- (BOOL)isRunning;
```
##### Example of initiate or stop Credit-Card Recognizer
```objc

- (void)openAndStart {
  [NHNCloudOCR openCreditCardRecognizerViewController];
  [[NHNCloudOCR creditCardRecognizerViewController] startRunning];
}

// Return the credit card recognition result
- (void)didDetectCreditCardInfo:(nullable NHNCloudCreditCardInfo *)cardInfo error:(nullable NSError *)error {
    [[NHNCloudOCR creditCardRecognizerViewController] stopRunning];
}
```

#### 4. Rotate Credit-Card Guide
* You can rotate the Credit-Card guide according to the direction of a credit card.

##### Specification for Rotate Credit-Card Guide
```objc
@property (assign, nonatomic, readonly) CGRect creditCardGuide;
@property (assign, nonatomic, readonly) NHNCloudCreditCardOrientation creditCardGuideOrientation;
- (void)rotateCreditCardGuideOrientation;
```
##### Example of using Rotate Credit-Card Guide
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

#### 5. Enable/Disable Light
* Enable or disable the camera light of a device.

##### Specification for Enable/Disable Light API
```objc
- (void)enableTorchMode;
- (void)disableTorchMode;
- (BOOL)isEnableTorchMode;
```
##### Example of enabling or disabling the camera light of a device.
```objc
- (void)torchButtonAction:(UIButton *)button {    
    if ([[NHNCloudOCR creditCardRecognizerViewController] isEnableTorchMode] == YES) {
        [[NHNCloudOCR creditCardRecognizerViewController] disableTorchMode];
    } else {
        [[NHNCloudOCR creditCardRecognizerViewController] enableTorchMode];
    }
}

```


#### 6. Enable/Disable Camera
* Enable or disable a device’s camera.

##### Specification for Enable/Disable Camera
```objc
- (void)startRunningCamera;
- (void)stopRunningCamera;
- (BOOL)isRunnginCamera;
```
##### Example of enabling or disabling camera
```objc
- (void)cameraButtonAction:(UIButton *)button {    
    if ([[NHNCloudOCR creditCardRecognizerViewController] isRunnginCamera] == YES) {
        [[NHNCloudOCR creditCardRecognizerViewController] stopRunningCamera];
    } else {
        [[NHNCloudOCR creditCardRecognizerViewController] startRunningCamera];
    }
}

```

## Customizing NHNCloudCreditCardRecognizerServiceViewController
* You can perform customizing of NHNCloudCreditCardRecognizerServiceViewController.
  * **The Credit-Card guide cannot be changed because pre-defined values are used.**

### 1. Inherit NHNCloudCreditCardRecognizerServiceViewController 
* You can perform customizing by implementing inheritance of NHNCloudCreditCardRecognizerServiceViewController.

#### Specification for Override Function
```objc
- (void)viewDidLoad;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (void)viewDidDisappear:(BOOL)animated;
- (void)didUpdateCreditCardGuide:(CGRect)rect orientation:(NHNCloudCreditCardOrientation)orientation;
- (void)imageDidDetect:(BOOL)detected;
```

#### Example of using Override
```objc

@interface OCRViewController : NHNCloudCreditCardRecognizerServiceViewController <NHNCloudCreditCardRecognizerDelegate>

@end

@implementation OCRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [NHNCloudOCR setDelegate:self];
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
