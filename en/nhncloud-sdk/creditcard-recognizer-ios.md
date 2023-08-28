## NHN Cloud > SDK User Guide > OCR > Credit Card (iOS)

## Prerequisites

1. Install [NHN Cloud SDK](./getting-started-ios).
2. Enable [AI Service > OCR ] in[NHN Cloud Console](https://console.nhncloud.com).
3. Check Appkey and SecretKey in the OCR console.

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

### 2. Apply NHN Cloud SDK using Swift Package Manager

* Go to ** File > Add Packages...** in XCode.
* Enter https://github.com/nhn/nhncloud.ios.sdk'를https://github.com/nhn/nhncloud.ios.sdk'를and select the ** button.
* Select NHNCloudOCR.

![swift_package_manager](https://static.toastoven.net/toastcloud/sdk/ios/swiftpackagemanager01.png)

#### Set up Project

* Add **-lc++** and **-ObjC** to **Other Linker Flags** of **Build Settings**.
    * **Project Target > Build Settings > Linking > Other Linker Flags**
![other_linker_flags](https://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags_202206.png)

### Download binaries and apply to NHN Cloud SDK

#### Set up Framework

* You can download the full iOS SDK from the NHN Cloud [Downloads](../../../Download/#toast-sdk) page.
* Add **NHNCloudOCR.framework**, **NHNCloudCore.framework**, and **NHNCloudCommon.framework, vision.framework, AVFoundation.framework** to Xcode Project.
* You can add vision.framework and AVFoundation.framework as follows. 
![linked_vision_frameworks](https://static.toastoven.net/toastcloud/sdk/ios/linked_vision_frameworks.png)
![linked_avfoundation_frameworks](https://static.toastoven.net/toastcloud/sdk/ios/linked_avfoundation_frameworks.png)
![linked_frameworks_ocr](https://static.toastoven.net/toastcloud/sdk/ios/linked_frameworks_ocr.png)

#### Set up Project

* Add **-lc++** and **-ObjC** to **Other Linker Flags** of **Build Settings**.
    * **Project Target > Build Settings > Linking > Other Linker Flags**
![other_linker_flags](https://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags_202206.png)

## Initialize NHNCLOUDOCR SDK
* Set AppKey and Secret issued from NHN Cloud Console in NHNCloudOCRConfiguration object.
  * AI Service -> OCR -> Document OCR -> Credit Card
* NHNCloudOCR uses an NHNCloudOCRConfiguration object as a parameter for initialization.
* To get a permission to use camera, add the following items to info.plist.
```
Key : NSCameraUsageDescription
Value : [Camera Permission Request Message]
```

### Specification for Initialization API

``` objc
// reset
+ (void)initWithConfiguration:(NHNCloudOCRConfiguration *)configuration;

// set delegate
+ (void)setCreditCardRecognizerDelegate:(nullable id<NHNCloudCreditCardRecognizerDelegate>)delegate;
```

### Specification for Delegate API
* You can be notified of the recognition result when  NHNCloudCreditCardRecognizerDelegate is registered.
* When OCR is running, you can receive screen capture and video recording events.
* When using the default screen provided by the SDK (implementing inherited NHNCloudCreditCardRecognizerViewController), close and confirmation events can be received.

``` objc
@protocol NHNCloudCreditCardRecognizerDelegate <NSObject>

// return credit card recognition result
- (void)didDetectCreditCardInfo:(nullable NHNCloudCreditCardInfo *)cardInfo error:(nullable NSError *)error;

@optional

// Receive screen capture events
- (void)didDetectCreditCardSecurityEvent:(NHNCloudSecurityEvent)event;

// Receive the close button event (can only be received when implementing NHNCloudCreditCardRecognizerViewController inheritance)
- (void)creditCardRecognizerViewControllerCancel;

// Receive confirmation button event (received only when inheriting NHNCloudCreditCardRecognizerViewController)
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


### Display Recognition Area

#### Return Recognition Area API
* The coordinate information of the recognized area in NHNCloudCreditCardInfo, which is the OCR result, can be returned.

```objc
@interface NHNCloudCreditCardInfo : NSObject

// Card number recognition area
@property(nonatomic, strong, readonly, nullable) NSArray<NSValue *> *numberBoundingBoxes;

// Expiration period recognition area
@property(nonatomic, assign, readonly) CGRect validThruBoundingBox;

@end

```

#### Draw on the Recognition Area ImageView

```objc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Set up to return recognized image
    [NHNCloudOCR setDetectedImageReturn:YES];
}

// Return credit card recognition result
- (void)didDetectCreditCardInfo:(nullable NHNCloudCreditCardInfo *)cardInfo error:(nullable NSError *)error {

    if (cardInfo.detectedImage != nil) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:cardInfo.detectedImage.image];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
          
        UIGraphicsBeginImageContextWithOptions(imageView.frame.size, NO, 0.0);
        CGContextRef context = UIGraphicsGetCurrentContext();

        [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
        
        // Draw the recognized area for credit card number.
        for (NSValue *rectValue in cardInfo.numberBoundingBoxes) {
            CGRect scaledBoundingBox = [self dividedRect:rectValue.CGRectValue
                                                 // Divide the coordinates by the value of scale based on the device's resolution.
                                                   scale:[UIScreen mainScreen].scale];
            CGContextSetStrokeColorWithColor(context, [UIColor orangeColor].CGColor);
            CGContextSetLineWidth(context, 5.0);
            CGContextStrokeRect(context, scaledBoundingBox);
        }

        CGRect scaledValidThruBoundingBox = [self dividedRect:cardInfo.validThruBoundingBox
                                                        scale:[UIScreen mainScreen].scale];
        // Draw the recognized area for expiration period                                                  
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

### Example of Initialization Process

``` objc
#import <NHNCloudOCR/NHNCloudOCR.h>

@interface ViewController() <NHNCloudCreditCardRecognizerDelegate>
@end

@implementationViewController

- (void)initializeOCR {
    // Initialization and Delegate settings
    NHNCloudOCRConfiguration *configuration = [NHNCloudOCRConfiguration configurationWithAppKey:@"{AppKey}" secret:@"{Secret}"];

    // set detection image return
    [NHNCloudOCR setDetectedImageReturn:YES];

    // reset
    [NHNCloudOCR initWithConfiguration:configuration];

    // set delegate
    [NHNCloudOCR setCreditCardRecognizerDelegate:self];
}

// return credit card recognition result
- (void)didDetectCreditCardInfo:(nullable NHNCloudCreditCardInfo *)cardInfo error:(nullable NSError *)error {
    NSLog(@"didDetectCreditCardInfo : cardInfo : %@", cardInfo);
    NSLog(@"didDetectCreditCardInfo : error : %@", error);
}

// receive screen capture events
- (void)didDetectCreditCardSecurityEvent:(NHNCloudSecurityEvent)event {

    // Example of screen capture alert output
    if (event == NHNCloudSecurityEventScreenshot || event == NHNCloudSecurityEventScreenRecordingOn) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"Capture detected." preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    // Example of outputting a blank screen when recording a video
    if (event == NHNCloudSecurityEventScreenRecordingOn || event == NHNCloudSecurityEventScreenRecordingOff) {
        if ([[UIScreen mainScreen] isCaptured] ) {
            [[[UIApplication sharedApplication] windows] firstObject].hidden = YES;
        } else {
            [[[UIApplication sharedApplication] windows] firstObject]. hidden = NO;
        }
    }
}


// Receive confirmation button event (can be received only when implementing NHNCloudCreditCardRecognizerViewController inheritance)
- (void)creditCardRecognizerViewControllerConfirm {
    // Processing when the OK button is pressed on the credit card recognition result screen
}

// Receive the close button event (can only be received when implementing NHNCloudCreditCardRecognizerViewController inheritance)
- (void)creditCardRecognizerViewControllerCancel {
    // Process when credit card recognition or close button is pressed on result screen
}

@end
```


## How to Apply Credit Card

### NHNCloudCreditCardRecognizerViewController

#### 1. Use Credit-Card Recognizer ViewController
* You can easily use Card-Card Recognizer with the default UI by connecting a class that inherits and implements NHNCloudCreditCardRecognizerViewController to ViewController of Storyboard.

#### 2. Create Class
![default_viewcontroller](https://static.toastoven.net/toastcloud/sdk/ios/default_viewcontroller.png)
* Create a ViewController Class with NHNCloudCreditCardRecognizerViewController as a subclass. 


#### 3. Connect to Storyboard
![create_viewcontroller](https://static.toastoven.net/toastcloud/sdk/ios/create_viewcontroller.png)
* Add ViewController to Storyboard.

![custom_class](https://static.toastoven.net/toastcloud/sdk/ios/custom_class.png)
* Set the created class in Custom Class in the added ViewController.

![segue_viewcontroller](https://static.toastoven.net/toastcloud/sdk/ios/segue_viewcontroller.png)
* Set the ViewController Segue Event. 

* Set up and implement the Delegate. 

### Customize NHNCloudCreditCardRecognizerServiceViewController
* You can customize the UI using NHNCloudCreditCardRecognizerServiceViewController.
  * **The Credit-Card guide cannot be changed because pre-defined values are used.**

#### 1. Inherit NHNCloudCreditCardRecognizerServiceViewController 
* You can perform customizing by implementing inheritance of NHNCloudCreditCardRecognizerServiceViewController.

##### Specification for Override Function
```objc

// Perform some initial setup and data prep work when the view is created in memory
- (void)viewDidLoad;

// Perform the last thing right before the view comes on screen
- (void)viewWillAppear:(BOOL)animated;

// Perform some cleanup right before the view disappears from the screen
- (void)viewWillDisappear:(BOOL)animated;

// Perform additional cleanup after the view is completely off the screen
- (void)viewDidDisappear:(BOOL)animated;

// Update Custom UI
- (void)didUpdateCreditCardGuide:(CGRect)rect orientation:(NHNCloudCreditCardOrientation)orientation;

// Update UI when recognizing credit card
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

    // Update UI when recognizing credit card
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
    // Initialization and Configure Delegate
    NHNCloudOCRConfiguration *configuration = [NHNCloudOCRConfiguration configurationWithAppKey:@"{AppKey}" secret:@"{Secret}" ];
    
    [configuration enableTestGuide];

    [NHNCloudOCR initWithConfiguration:configuration];

    [NHNCloudOCR setCreditCardRecognizerDelegate:self];
}
```

## Control Credit-Card Recognizer ViewController

> Inherit and implement NHNCloudCreditCardRecognizerViewController or NHNCloudCreditCardRecognizerServiceViewController by referring to `How to Apply Credit Card`

### 4. Credit-Card Recognizer Start/Stop
* Start or stop Credit-Card Recognizer.

#### Specification for Start or stop Credit-Card Recognizer.
```objc
- (void)startRunning;
- (void)stopRunning;
- (BOOL)isRunning;
```
#### Example of Start or stop Credit-Card Recognizer
```objc
- (void)start {
  [self startRunning];
}

// return credit card recognition result
- (void)didDetectCreditCardInfo:(nullable NHNCloudCreditCardInfo *)cardInfo error:(nullable NSError *)error {
    [self stopRunning];
}
```

### 5. Rotate Credit-Card Guide
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

### 6. Light Enable/Disable
* Enable or disable the camera light of a device.

#### Specification for Enable/Disable Light API
```objc
- (void)enableTorchMode;
- (void)disableTorchMode;
- (BOOL)isEnableTorchMode;
```
#### Example of Enable or disable the camera light of a device.
```objc
- (void)torchButtonAction:(UIButton *)button {    
    if ([self isEnableTorchMode] == YES) {
        [self disableTorchMode];
    } else {
        [self enableTorchMode];
    }
}

```


### 7. Enable/Disable Camera
* Enable or disable a device’s camera.

#### Specification for Enable/Disable Camera
```objc
- (void)startRunningCamera;
- (void)stopRunningCamera;
- (BOOL)isRunnginCamera;
```
#### Example of Enable/Disable Camera
```objc
- (void)cameraButtonAction:(UIButton *)button {    
    if ([self isRunnginCamera] == YES) {
        [self stopRunningCamera];
    } else {
        [self startRunningCamera];
    }
}

```
