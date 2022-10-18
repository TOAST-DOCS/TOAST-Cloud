## NHN Cloud > SDK User Guide > Document Recognizer > Credit Card (iOS)


## Prerequisites

1. [NHN Cloud SDK](./getting-started-ios)를 설치합니다.
2. [NHN Cloud 콘솔](https://console.toast.com)에서 [AI Service > Document Recognizer] 서비스를 활성화합니다.
3. Document Recognizer 콘솔에서 AppKey와 SecretKey를 확인합니다.

<br>

## 지원 환경

NHN Cloud OCR 은 iOS 11.0 이상에서 동작합니다.<br>

## NHN Cloud OCR 구성

iOS용 NHN Cloud OCR SDK의 구성은 다음과 같습니다.

| Service  | Cocoapods Pod Name | Framework | Dependency | Build Settings |
| --- | --- | --- | --- | --- |
| IAP | NHNCloudOCR | NHNCloudOCR.framework | * Vision.framework<br/> * AVFoundation.framework | |
| Mandatory   | NHNCloudCore<br/>NHNCloudCommon | NHNCloudCore.framework<br/>NHNCloudCommon.framework | | OTHER_LDFLAGS = (<br/>    "-ObjC",<br/>    "-lc++" <br/>); |


## NHN Cloud OCR SDK를 Xcode 프로젝트에 적용

### 1. Cococapods 을 통한 적용

* Podfile을 생성하여 NHN Cloud SDK에 대한 Pod을 추가합니다.

```podspec
platform :ios, '11.0'
use_frameworks!

target '{YOUR PROJECT TARGET NAME}' do
    pod 'NHNCloudOCR'
end
```

### 2. 바이너리를 다운로드하여 NHN Cloud SDK 적용

#### 프레임워크 설정

* NHN Cloud [Downloads](../../../Download/#toast-sdk) 페이지에서 전체 iOS SDK를 다운로드할 수 있습니다.
* Xcode Project에 **NHNCloudOCR.framework**, **NHNCloudCore.framework**, **NHNCloudCommon.framework, vision.framework, AVFoundation.framework**를 추가합니다.
* vision.framework와 AVFoundation.framework는 아래 방법으로 추가할 수 있습니다.
![linked_vision_frameworks]()

![linked_frameworks_ocr]()

#### 프로젝트 설정

* **Build Settings**의 **Other Linker Flags**에 **-lc++**와 **-ObjC** 항목을 추가합니다.
    * **Project Target > Build Settings > Linking > Other Linker Flags**
![other_linker_flags](https://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags_202206.png)

## NHNCloudOCR SDK 초기화
* NHNCloud 콘솔에서 발급받은 AppKey와 Secret을 NHNCloudOCRConfiguration 객체에 설정합니다.
  * AI Service -> Document Recognizer -> 신용카드
* NHNCloudOCR은 초기화에 NHNCloudOCRConfiguration 객체를 파라미터로 사용합니다.
* 카메라 사용 권한을 얻기 위해 info.plist에 아래 내용을 추가합니다.
```
Key : NSCameraUsageDescription
Value : [카메라 권한 요청 메세지]
```

## 초기화 API 명세

``` objc
// 초기화
+ (void)initWithConfiguration:(NHNCloudOCRConfiguration *)configuration;
// Delegate 설정
+ (void)setDelegate:(nullable id<NHNCloudCreditCardRecognizerDelegate>)delegate;
// 초기화 및 Delegate 설정
+ (void)initWithConfiguration:(NHNCloudOCRConfiguration *)configuration
                     delegate:(nullable id<NHNCloudCreditCardRecognizerDelegate>)delegate;
```

### Delegate API 명세
* NHNCloudCreditCardRecognizerDelegate 를 등록하면 인식 결과에 대한 통지를 받을 수 있습니다.
* OCR이 실행중일때 화면의 스크린 캡쳐와 동영상 녹화 이벤트를 수신받을 수 있습니다.

``` objc
@protocol NHNCloudCreditCardRecognizerDelegate <NSObject>

- (void)didDetectCreditCardInfo:(nullable NHNCloudCreditCardInfo *)cardInfo error:(nullable NSError *)error;
@optional
- (void)didDetectSecurityEvent:(NHNCloudSecurityEvent)event;

@end
```

### 검출 이미지 반환 설정하기
* OCR 결과인 NHNCloudCreditCardInfo 데이터에 검출된 이미지를 함께 반환 받을 수 있습니다. 
    * 기본값은 비활성화입니다. 
#### 검출 이미지 반환 설정 API 명세 
```objc
@interface NHNCloudOCR : NSObject
//..
+ (void)setDetectedImageReturn:(BOOL)enable;
+ (BOOL)isEnableDetectedImageReturn;
//..
@end
```

### 초기화 과정 예

``` objc
#import <NHNCloudOCR/NHNCloudOCR.h>

@interface ViewController () <NHNCloudCreditCardRecognizerDelegate>
@end

@implementation ViewController

- (void)initializeOCR {
    // 초기화 및 Delegate 설정
    NHNCloudOCRConfiguration *configuration = [NHNCloudOCRConfiguration configurationWithAppKey:@"{AppKey}" secret:@"{Secret}"];

    // 검출 이미지 반환 설정 
    [NHNCloudOCR setDetectedImageReturn:YES];

    // 초기화    
    [NHNCloudOCR initWithConfiguration:configuration delegate:self];
}

// 신용카드 인식 결과 반환
- (void)didDetectCreditCardInfo:(nullable NHNCloudCreditCardInfo *)cardInfo error:(nullable NSError *)error {
    NSLog(@"didDetectCreditCardInfo : cardInfo : %@", cardInfo);
    NSLog(@"didDetectCreditCardInfo : error : %@", error);
}

// 스크린캡쳐 이벤트 수신
- (void)didDetectSecurityEvent:(NHNCloudSecurityEvent)event {

    // 스크린 캡쳐 경고 Alert 출력 예시
    if (event == NHNCloudSecurityEventScreenshot || event == NHNCloudSecurityEventScreenRecordingOn) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"캡쳐가 감지되었습니다." preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    // 동영상 녹화시 빈화면 출력 예시
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

### 1. Credit-Card 가이드 설정하기
* NHNCloudOCR SDK에서 테스트를 위해 제공하는 Credit-Card 가이드를 사용하여 OCR을 테스트 할 수 있습니다.
  * 신용카드가 Credit-Card 가이드안에 존재 할 경우 OCR이 시작됩니다.
    * 기본값은 hidden 으로 눈에 보이지 않는 가이드가 존재합니다.
    * `enableTestGuide`를 사용하여 테스트용 가이드를 출력할 수 있습니다. 

#### Credit-Card 가이드 API 명세
```objc
@interface NHNCloudOCRConfiguration : NSObject
- (void)enableTestGuide;
@end
```
#### Credit-Card 가이드 사용 예

```objc
- (void)initializeOCR {
    // 초기화 및 Delegate 설정
    NHNCloudOCRConfiguration *configuration = [NHNCloudOCRConfiguration configurationWithAppKey:@"{AppKey}" secret:@"{Secret}" secure:YES secureMessage:@"화면 캡쳐가 감지되었습니다."];
    
    [configuration enableTestGuide];
        
    [NHNCloudOCR initWithConfiguration:configuration delegate:self];
}
```


### 2. Credit-Card Recognizer ViewController 열기
* 신용카드 인식을 위해 신용카드 인식기가 포함된 ViewController를 엽니다.
* SDK에서 여는 방법과 ViewController를 반환받아 개발자가 원하는 방법으로 직접 여는 방법을 사용할 수 있습니다.

#### Credit-Card Recognizer ViewController 열기 API 명세

```objc
// CreditCard Recognizer ViewController을 SDK에서 출력합니다.
+ (NHNCloudCreditCardRecognizerViewController *)openCreditCardRecognizerViewController;

// CreditCard Recognizer ViewController을 반환합니다. 사용자가 직접 출력하거나 SDK에 활성화된 객체를 반환 받을 수 있습니다.
+ (nullable NHNCloudCreditCardRecognizerViewController *)creditCardRecognizerViewController;
```

#### Credit-Card Recognizer ViewController 열기 사용 예
```objc
// SDK에서  Recognizer ViewController 를 열게 합니다.
[NHNCloudOCR openCreditCardRecognizerViewController];

// SDK에서  Recognizer ViewController 를 반환받아 개발자가 원하는 방법으로 직접 열게 합니다.
NHNCloudCreditCardRecognizerViewController *creditCardRecognizerViewController = [NHNCloudOCR creditCardRecognizerViewController];
[self presentViewController:creditCardRecognizerViewController animated:YES completion:nil];

```

### 3. Credit-Card Recognizer ViewController 닫기
* 신용카드 인식기가 포함된 ViewController를 닫습니다.

#### Credit-Card Recognizer ViewController 닫기 API 명세

```objc
- (void)dismissViewController;
```

#### Credit-Card Recognizer ViewController 닫기 사용 예
```objc
- (void)closeButton:(id)sender {
    [[NHNCloudOCR creditCardRecognizerViewController] dismissViewController];
}
```

### 4. Credit-Card Recognizer 시작/중지
* Credit-Card Recognizer를 시작하거나 중지합니다.

#### Credit-Card Recognizer 시작/중지 API 명세
```objc
- (void)startRunning;
- (void)stopRunning;
- (BOOL)isRunning;
```
#### Credit-Card Recognizer 시작/중지 사용 예
```objc

- (void)openAndStart {
  [NHNCloudOCR openCreditCardRecognizerViewController];
  [[NHNCloudOCR creditCardRecognizerViewController] startRunning];
}

// 신용카드 인식 결과 반환
- (void)didDetectCreditCardInfo:(nullable NHNCloudCreditCardInfo *)cardInfo error:(nullable NSError *)error {
    [[NHNCloudOCR creditCardRecognizerViewController] stopRunning];
}
```

### 5. Credit-Card 가이드 회전
* 신용카드의 방향에 맞도록 Credit-Card 가이드를 회전 시킬 수 있습니다.

#### Credit-Card 가이드 회전 API 명세
```objc
@property (assign, nonatomic, readonly) CGRect creditCardGuide;
@property (assign, nonatomic, readonly) NHNCloudCreditCardOrientation creditCardGuideOrientation;
- (void)rotateCreditCardGuideOrientation;
```
#### Credit-Card 가이드 회전 사용 예
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

### 6. 라이트 활성/비활성
* 디바이스의 카메라 라이트를 활성화하거나 비활성화 합니다.

#### 라이트 활성/비활성 API 명세
```objc
- (void)torchModeOn;
- (void)torchModeOff;
- (BOOL)torchMode;
```
#### 라이트 활성/비활성 사용 예
```objc
- (void)torchButtonAction:(UIButton *)button {    
    if ([[NHNCloudOCR creditCardRecognizerViewController] torchMode] == YES) {
        [[NHNCloudOCR creditCardRecognizerViewController] torchModeOff];
    } else {
        [[NHNCloudOCR creditCardRecognizerViewController] torchModeOn];
    }
}

```


### 7. 카메라 활성/비활성
* 디바이스의 카메라를 활성화하거나 비활성화 합니다.

#### 카메라 활성/비활성 API 명세
```objc
- (void)startRunningCamera;
- (void)stopRunningCamera;
- (BOOL)isRunnginCamera;
```
#### 카메라 활성/비활성 사용 예
```objc
- (void)cameraButtonAction:(UIButton *)button {    
    if ([[NHNCloudOCR creditCardRecognizerViewController] isRunnginCamera] == YES) {
        [[NHNCloudOCR creditCardRecognizerViewController] stopRunningCamera];
    } else {
        [[NHNCloudOCR creditCardRecognizerViewController] startRunningCamera];
    }
}

```

## NHNCloudCreditCardRecognizerViewController 커스터마이징
* NHNCloudCreditCardRecognizerViewController에 커스터마이징을 수행할 수 있습니다.
  * **Credit-Card 가이드의 경우 미리 정의된 값을 사용하기 때문에 변경이 불가능합니다.**
* 초기화시에 NHNCloudSDK에서 제공하는 기본 UI를 비활성화 해야 합니다. 
```
@interface NHNCloudOCRConfiguration : NSObject

//...

- (void)disableDefaultUI;

//...

@end

- (void)initCustomUI {
    // 초기화 및 Delegate 설정
    NHNCloudOCRConfiguration *configuration = [NHNCloudOCRConfiguration configurationWithAppKey:@"{AppKey}" secret:@"{Secret}"];

    // 기본 UI 비활성화
    [configuration disableDefaultUI];
    
    // 초기화    
    [NHNCloudOCR initWithConfiguration:configuration delegate:self];
}
```


### 1. NHNCloudCreditCardRecognizerViewController 상속 
* NHNCloudCreditCardRecognizerViewController를 상속구현하여 커스터마이징 할 수 있습니다.

#### Override 함수 명세
```objc
- (void)viewDidLoad;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (void)viewDidDisappear:(BOOL)animated;
- (void)didUpdateCreditCardGuide:(CGRect)rect orientation:(NHNCloudCreditCardOrientation)orientation;
```

#### Override 사용 예
```objc

@interface OCRViewController : NHNCloudCreditCardRecognizerViewController <NHNCloudCreditCardRecognizerDelegate>

@end

@implementation OCRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [NHNCloudOCR setDelegate:self];
    // Custom UI 생성 ...
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
    
    // Custom UI 갱신  
}

- (void)didDetectCreditCardInfo:(nullable NHNCloudCreditCardInfo *)cardInfo error:(nullable NSError *)error {
    
    NSLog(@"didDetectCreditCardInfo : cardInfo : %@", cardInfo);
    NSLog(@"didDetectCreditCardInfo : error : %@", error);
}

```
