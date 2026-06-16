<!-- pre-align:aligned sig=baf2528eea97 -->

## NHN Cloud > SDK User Guide > OCR > ID Card (iOS)

<a id="prerequisites"></a>

## Prerequisites

1. Install [NHN Cloud SDK](./getting-started-ios).
2. Enable [AI Service > OCR ] in[NHN Cloud Console](https://console.nhncloud.com).
3. Check Appkey and SecretKey in the OCR console.

<br>

<a id="supported-environment"></a>

## Supported Environment

NHN Cloud OCR operates in iOS 11.0 or higher.<br>

<a id="configuration-of-nhn-cloud-ocr"></a>

## Configuration of NHN Cloud OCR

The configuration of NHN Cloud OCR SDK for iOS is as follows.

| Service  | Cocoapods Pod Name | Framework | Dependency | Build Settings |
| --- | --- | --- | --- | --- |
| OCR | NHNCloudOCR | NHNCloudOCR.framework | \* Vision.framework<br/> \* AVFoundation.framework | |
| Mandatory   | NHNCloudCore<br/>NHNCloudCommon | NHNCloudCore.framework<br/>NHNCloudCommon.framework | | OTHER_LDFLAGS = (<br/>    "-ObjC",<br/>    "-lc++" <br/>); |


<a id="apply-nhn-cloud-ocr-sdk-to-xcode-project"></a>

## Apply NHN Cloud OCR SDK to Xcode Project

<a id="apply-with-cococapods"></a>

### 1. Apply with Cococapods

* Add Pod for NHN Cloud SDK by creating a pod file.

```podspec
platform :ios, '11.0'
use_frameworks!

target '{YOUR PROJECT TARGET NAME}' do
    pod 'NHNCloudOCR'
end
```

<a id="apply-nhn-cloud-sdk-using-swift-package-manager"></a>

### 2. Apply NHN Cloud SDK using Swift Package Manager

* Go to ** File > Add Packages...** in XCode.
* Enter https://github.com/nhn/nhncloud.ios.sdk'를https://github.com/nhn/nhncloud.ios.sdk'를and select the ** button.
* Select NHNCloudOCR.

![swift_package_manager](https://static.toastoven.net/toastcloud/sdk/ios/swiftpackagemanager01.png)

<a id="set-up-project"></a>

#### Set up Project

* Add **-lc++** and **-ObjC** to **Other Linker Flags** of **Build Settings**.
    * **Project Target > Build Settings > Linking > Other Linker Flags**
![other_linker_flags](https://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags_202206.png)

<a id="download-binaries-and-apply-to-nhn-cloud-sdk"></a>

### Download binaries and apply to NHN Cloud SDK

<a id="set-up-framework"></a>

#### Set up Framework

* You can download the full iOS SDK from the NHN Cloud [Downloads](../../../Download/#toast-sdk) page.
* Add **NHNCloudOCR.framework**, **NHNCloudCore.framework**, and **NHNCloudCommon.framework, vision.framework, AVFoundation.framework** to Xcode Project.
* You can add vision.framework and AVFoundation.framework as follows. 
![linked_vision_frameworks](https://static.toastoven.net/toastcloud/sdk/ios/linked_vision_frameworks.png)
![linked_avfoundation_frameworks](https://static.toastoven.net/toastcloud/sdk/ios/linked_avfoundation_frameworks.png)
![linked_frameworks_ocr](https://static.toastoven.net/toastcloud/sdk/ios/linked_frameworks_ocr.png)

<a id="set-up-project-2"></a>

#### Set up Project

* Add **-lc++** and **-ObjC** to **Other Linker Flags** of **Build Settings**.
    * **Project Target > Build Settings > Linking > Other Linker Flags**
![other_linker_flags](https://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags_202206.png)

<a id="initialize-nhncloudocr-sdk"></a>

## Initialize NHNCLOUDOCR SDK
* Set AppKey and Secret issued from NHN Cloud Console in NHNCloudOCRConfiguration object.
  * AI Service -> OCR -> Document OCR -> ID
* NHNCloudOCR uses an NHNCloudOCRConfiguration object as a parameter for initialization.
* To get a permission to use camera, add the following items to info.plist.
```
Key : NSCameraUsageDescription
Value : [Camera Permission Request Message]
```

<a id="specification-for-initialization-api"></a>

### Specification for Initialization API

``` objc
// reset
+ (void)initWithConfiguration:(NHNCloudOCRConfiguration *)configuration;

// set delegate
+ (void)setIDCardRecognizerDelegate:(nullable id<NHNCloudIDCardRecognizerDelegate>)delegate;
```

<a id="specification-for-delegate-api"></a>

### Specification for Delegate API
* You can be notified of the recognition result when NHNCloudIDCardRecognizerDelegate is registered.
* When OCR is running, you can receive screen capture and video recording events.
* When using the default screen provided by the SDK (implementing inherited NHNCloudIDCardRecognizerViewController), close and confirmation events can be received.

``` objc
@protocol NHNCloudIDCardRecognizerDelegate <NSObject>

// return ID recognition result
- (void)didDetectIDCardInfo:(nullable NHNCloudIDCardInfo *)cardInfo error:(nullable NSError *)error;

@optional

// Receive screen capture events
- (void)didDetectIDCardSecurityEvent:(NHNCloudSecurityEvent)event;

// Receive the close button event (can be received only when inheriting NHNCloudIDCardRecognizerViewController)
- (void)IDCardRecognizerViewControllerCancel;

// Receive OK button event (can be received only when inheriting NHNCloudIDCardRecognizerViewController)
- (void)IDCardRecognizerViewControllerConfirm;

@end
```

<a id="set-up-detected-image-return"></a>

### Set up Detected Image Return
* NHNCloudIDCardInfo data, which is the OCR result, can be returned together with the detected image.
    * Default is disabled.
<a id="specification-for-setting-up-detected-image-return-api"></a>

#### Specification for Setting up Detected Image Return API
```objc
@interface NHNCloudOCR : NSObject
//..
+ (void)setDetectedImageReturn:(BOOL)enable;
+ (BOOL)isEnableDetectedImageReturn;
//..
@end
```


<a id="display-recognition-area"></a>

### Display Recognition Area

<a id="return-recognition-area-api"></a>

#### Return Recognition Area API
* The coordinate information of recognized area in the NHNCloudIDCardInfo data, the OCR result, can be returned.

```objc
@interface NHNCloudIDCardInfo: NSObject

// ID card recognition area
@property(nonatomic, strong, readonly, nullable) NSArray<NSValue *> *boundingBoxes;

@end

```

<a id="draw-the-recognition-area-on-imageview"></a>

#### Draw the Recognition area on ImageView

```objc
- (void)viewDidLoad {
    [super viewDidLoad];
    // Set up to return recognized image
    [NHNCloudOCR setDetectedImageReturn:YES];
}

// Return ID card recognition result
- (void)didDetectIDCardInfo:(NHNCloudIDCardInfo *)cardInfo error:(NSError *)error {

    if (cardInfo.detectedImage != nil) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:cardInfo.detectedImage.image];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        // Draw recognition area on imageView
        [self drawBoundingBoxes:cardInfo.boundingBoxes over:imageView];
                
        [self.view addSubview:imageView];
    }
}

- (void)drawBoundingBoxes:(NSArray *)boundingBoxes
                     over:(UIImageView *)imageView {
    UIGraphicsBeginImageContextWithOptions(imageView.frame.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();

    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];

    for (NSValue *rectValue in boundingBoxes) {
        CGRect boundingBox = [self dividedRect:rectValue.CGRectValue
                                         // Divide the coordinates by the value of scale based on the device's resolution.
                                         scale:[UIScreen mainScreen].scale];
        CGContextSetStrokeColorWithColor(context, [UIColor orangeColor].CGColor);
        CGContextSetLineWidth(context, 5.0);
        CGContextStrokeRect(context, boundingBox);
    }

    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    imageView.image = newImage;
}

- (CGRect)dividedRect:(CGRect)rect
                scale:(CGFloat)scale {
    return CGRectMake(rect.origin.x / scale, rect.origin.y / scale,
                      rect.size.width / scale, rect.size.height / scale);
}

```

<a id="example-of-initialization-process"></a>

### Example of Initialization Process

``` objc
#import <NHNCloudOCR/NHNCloudOCR.h>

@interface ViewController () <NHNCloudIDCardRecognizerDelegate>
@end

@implementation ViewController

- (void)initializeOCR {
    // Initialize and Configure Delegate
    NHNCloudOCRConfiguration *configuration = [NHNCloudOCRConfiguration configurationWithAppKey:@"{AppKey}" secret:@"{Secret}"];

    // Set Detected Image Return
    [NHNCloudOCR setDetectedImageReturn:YES];

    // Initialize    
    [NHNCloudOCR initWithConfiguration:configuration];

    // Configure Delegate
    [NHNCloudOCR setIDCardRecognizerDelegate:self];
}

// Return ID Card Recognition Result
- (void)didDetectIDCardInfo:(NHNCloudIDCardInfo *)cardInfo error:(NSError *)error {
    NSLog(@"didDetectIDCardInfo : cardInfo : %@", cardInfo);
    NSLog(@"didDetectIDCardInfo : error : %@", error);
}

// Receive Screen Capture Event
- (void)didDetectIDCardSecurityEvent:(NHNCloudSecurityEvent)event {

    // Example of Screen Capture Alert
    if (event == NHNCloudSecurityEventScreenshot || event == NHNCloudSecurityEventScreenRecordingOn) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"Capture detected." preferredStyle:UIAlertControllerStyleAlert];
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

// Receive Confirm Button Event (Only available for NHNCloudIDCardRecognizerViewController inheritance implementations)
- (void)IDCardRecognizerViewControllerConfirm {
    // When you click the confirm button on the ID card recognition result
}

// Receive Close Button Event (Only available for NHNCloudIDCardRecognizerViewController inheritance implementations)
- (void)IDCardRecognizerViewControllerCancel {
    // When you click the confirm button on the ID card recognition or result screen
}

@end
```

<a id="how-to-apply-id-card"></a>

## How to Apply ID Card

<a id="nhncloudidcardrecognizerviewcontroller"></a>

### NHNCloudIDCardRecognizerViewController

<a id="use-id-card-recognizer-viewcontroller"></a>

#### 1. Use ID-Card Recognizer ViewController
* You can easily use ID-Card Recognizer with the default UI by connecting a class that inherits and implements NHNCloudIDCardRecognizerViewController to ViewController of Storyboard.

<a id="create-class"></a>

#### 2. Create Class
![default_viewcontroller](https://static.toastoven.net/toastcloud/sdk/ios/default_idcard_viewcontroller.png)
* Create a ViewController Class with NHNCloudIDCardRecognizerViewController as a subclass.


<a id="connect-to-storyboard"></a>

#### 3. Connect to Storyboard
![create_viewcontroller](https://static.toastoven.net/toastcloud/sdk/ios/create_viewcontroller.png)
* Add ViewController to Storyboard.

![custom_class](https://static.toastoven.net/toastcloud/sdk/ios/custom_class.png)
* Set the created class in Custom Class in the added ViewController.

![segue_viewcontroller](https://static.toastoven.net/toastcloud/sdk/ios/segue_viewcontroller.png)
* Set the ViewController Segue Event.

* Set up and implement the Delegate.


<a id="customize-nhncloudidcardrecognizerserviceviewcontroller"></a>

### Customize NHNCloudIDCardRecognizerServiceViewController
* You can customize the UI using NHNCloudIDCardRecognizerServiceViewController.
  * **The ID-Card guide cannot be changed because pre-defined values are used.**

<a id="inherit-nhncloudidcardrecognizerserviceviewcontroller"></a>

#### 1. Inherit NHNCloudIDCardRecognizerServiceViewController
* You can perform customizing by implementing inheritance of NHNCloudIDCardRecognizerServiceViewController.

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
- (void)didUpdateIDCardGuide:(CGRect)rect;

// Update UI when recognizing ID
- (void)imageDidDetect:(BOOL)detected;

```

##### Example of using Override
```objc

@interface OCRViewController : NHNCloudIDCardRecognizerServiceViewController <NHNCloudIDCardRecognizerDelegate>

@end

@implementation OCRViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [NHNCloudOCR setIDCardRecognizerDelegate:self];
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

- (void)didUpdateIDCardGuide:(CGRect)rect {
    [super didUpdateIDCardGuide:rect];

    // Update Custom UI
}

- (void)imageDidDetect:(BOOL)detected {
    [super imageDidDetect:detected];

    // Update UI when recognizing ID
}

- (void)didDetectIDCardInfo:(nullable NHNCloudIDCardInfo *)cardInfo error:(nullable NSError *)error {

    NSLog(@"didDetectIDCardInfo : cardInfo : %@", cardInfo);
    NSLog(@"didDetectIDCardInfo : error : %@", error);
}

```

<a id="use-test-environment"></a>

### Use Test Environment
* You can test OCR by using the ID-Card guide provided to test NHNCloudOCR SDK.
  * OCR is initiated when a credit card exists in the ID-Card guide.
    * Default value is hidden so that there is an invisible guide.
    * You can output a guide for testing by using `enableTestGuide`.

##### Specification for ID-Card Guide
```objc
@interface NHNCloudOCRConfiguration : NSObject
- (void)enableTestGuide;
@end
```
##### Example of using ID-Card guide

```objc
- (void)initializeOCR {
    // Initialization and Configure Delegate
    NHNCloudOCRConfiguration *configuration = [NHNCloudOCRConfiguration configurationWithAppKey:@"{AppKey}" secret:@"{Secret}" ];

    [configuration enableTestGuide];

    [NHNCloudOCR initWithConfiguration:configuration];
    [NHNCloudOCR setIDCardRecognizerDelegate:self];
}
```
<a id="control-id-card-recognizer-viewcontroller"></a>

## Control ID-Card Recognizer ViewController
> Inherit and implement NHNCloudIDCardRecognizerViewController or NHNCloudIDCardRecognizerServiceViewController by referring to `How to Apply ID Card`

<a id="startstop-id-card-recognizer"></a>

### 1. Start/Stop ID-Card Recognizer
* Start or stop ID-Card Recognizer.

<a id="specification-for-start-or-stop-id-card-recognizer"></a>

#### Specification for Start or stop ID-Card Recognizer
```objc
- (void)startRunning;
- (void)stopRunning;
- (BOOL)isRunning;
```
<a id="example-of-start-or-stop-id-card-recognizer"></a>

#### Example of Start or stop ID-Card Recognizer
```objc

- (void)start {
  [self startRunning];
}

// return ID recognition result
- (void)didDetectIDCardInfo:(nullable NHNCloudIDCardInfo *)cardInfo error:(nullable NSError *)error {
    [self stopRunning];
}
```

<a id="enabledisable-camera"></a>

### 7. Enable/Disable Camera
* Enable or disable a device’s camera.

<a id="specification-for-enabledisable-camera"></a>

#### Specification for Enable/Disable Camera
```objc
- (void)startRunningCamera;
- (void)stopRunningCamera;
- (BOOL)isRunnginCamera;
```
<a id="example-of-enabledisable-camera"></a>

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

<a id="verify-id-card-authenticity"></a>

## Verify ID Card Authenticity

<a id="verify-id-card-with-recognition-results"></a>

### Verify ID Card with recognition results
* Verify the authenticity of recognized IDs.
* requestKey received as a result of ID recognition is required.

<a id="expiration-of-requestkey"></a>

#### Expiration of requestKey
* Expires after one use as it is a one-time value.
* Expires after 1 hour.

<a id="specification-for-id-card-authenticity-verification"></a>

### Specification for ID Card Authenticity Verification
```objc
+ (void)verificateAuthenticityIDCard:(nonnull NHNCloudIDCardInfo *)IDCardInfo
                   completionHandler:(nullable void (^)(BOOL isAuthenticity, NSError * _Nullable error))completionHandler
```

<a id="example-of-using-id-card-authenticity-verification-api"></a>

### Example of using ID Card Authenticity Verification API
```objc
[NHNCloudOCR verificateAuthenticityIDCard:cardInfo // cardInfo received as a result of didDetectIDCardInfo
                            completionHandler:^(BOOL isAuthenticity, NSError * _Nullable error) {
    if (isAuthenticity) {
        // ID recognition successful
    } else {
        // ID recognition failed
    }
}];
```
