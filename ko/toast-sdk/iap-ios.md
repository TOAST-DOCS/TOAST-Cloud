## TOAST > TOAST SDK 사용 가이드 > TOAST IAP > iOS

## Prerequisites

1\. [TOAST SDK](./getting-started-ios)를 설치합니다.
2\. [TOAST 콘솔](https://console.cloud.toast.com)에서 [Mobile Service \> IAP를 활성화](https://docs.toast.com/ko/Mobile%20Service/IAP/ko/console-guide/)합니다.
3\. IAP에서 [AppKey를 확인](https://docs.toast.com/ko/Mobile%20Service/IAP/ko/console-guide/#appkey)합니다.

## TOAST IAP 구성

iOS용 TOAST IAP SDK의 구성은 다음과 같습니다.

| Service  | Cocoapods Pod Name | Framework | Dependency | Build Settings |
| --- | --- | --- | --- | --- | 
| TOAST IAP | ToastIAP | ToastIAP.framework | * StoreKit.framework<br/><br/>[Optional]<br/> * libsqlite3.tdb | |
| Mandatory   | ToastCore<br/>ToastCommon | ToastCore.framework<br/>ToastCommon.framework | | OTHER_LDFLAGS = (<br/>    "-ObjC",<br/>    "-lc++" <br/>); |


## TOAST IAP SDK를 Xcode 프로젝트에 적용

### Cococapods 적용

Podfile을 생성하여 TOAST SDK에 대한 Pod을 추가합니다.

```podspec
platform :ios, '8.0'
use_frameworks!

target '{YOUR PROJECT TARGET NAME}' do
    pod 'ToastIAP'
end
```

생성된 Workspace를 열어 사용하려는 SDK를 가져옵니다(import).

```objc
#import <ToastCore/ToastCore.h>
#import <ToastIAP/ToastIAP.h>
```

### 바이너리를 다운로드하여 TOAST SDK 적용 

#### SDK 가져오기(import)

TOAST의 [Downloads](../../../Download/#toast-sdk) 페이지에서 전체 iOS SDK를 다운로드할 수 있습니다.

Xcode Project에 **ToastIAP.framework**, **ToastCore.framework**, **ToastCommon.framework**, `StoreKit.framework`를 추가합니다.

> StoreKit.framework는 아래 방법으로 추가할 수 있습니다.

![linked_storekit_frameworks](http://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_StoreKit.png)

![linked_frameworks_iap](http://static.toastoven.net/toastcloud/sdk/ios/iap_link_frameworks_iap.png)

#### Project Settings

**Build Settings**의 **Other Linker Flags**에 **-lc++**와 **-ObjC** 항목을 추가합니다.

**Project Target > Build Settings > Linking > Other Linker Flags**를 클릭해 추가할 수 있습니다.

![other_linker_flags](http://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags.png)

#### 프레임워크 가져오기 

사용하려는 프레임워크를 가져옵니다(import).

```objc
#import <ToastCore/ToastCore.h>
#import <ToastIAP/ToastIAP.h>
```

## 서비스 로그인

* TOAST SDK에서 제공하는 모든 상품(IAP, Log & Crash, Push등)은 같은 사용자 ID 하나만 사용합니다.

### 로그인

`사용자 ID가 설정되지 않은 상태에서는 구매, 활성화된 상품 조회, 미소비 내역 조회 기능을 사용할 수 없습니다.`

``` objc
// 서비스 로그인 완료 후 사용자 ID 설정
[ToastSDK setUserID:@"INPUT_USER_ID"];
```

### 로그아웃

``` objc
// 서비스 로그아웃 완료 후 사용자 ID를 nil로 설정
[ToastSDK setUserID:nil];
```

## TOAST IAP SDK 초기화

TOAST IAP에서 발급받은 AppKey를 설정합니다.
초기화와 동시에 미완료 구매 건에 대한 재처리가 진행됩니다.
따라서 원활하게 재처리하려면 반드시 사용자 ID를 설정한 후 초기화하십시오.
재처리를 포함해 모든 구매 결과는 Delegate를 통해 전달되므로 Delegate 설정 이후에 초기화하거나, 초기화와 함께 Delegate를 설정하시기를 권장합니다.

``` objc
ToastIAPConfiguration *configuration = [[ToastIAPConfiguration alloc] initWithAppKey:@"INPUT_YOUR_APPKEY"];

[ToastIAP initWithConfiguration:configuration delegate:self];
```

### 초기화 API 명세

``` objc
@interface ToastIAP : NSObject

// 초기화
+ (void)initWithConfiguration:(ToastIAPConfiguration *)configuration;

// Delegate 설정
+ (void)setDelegate:(nullable id<ToastInAppPurchaseDelegate>)delegate;

// 초기화 및 Delegate 설정
+ (void)initWithConfiguration:(ToastIAPConfiguration *)configuration
                     delegate:(nullable id<ToastInAppPurchaseDelegate>)delegate;

// ...

@end
```

### Delegate API 명세

Delegate를 등록하면 결제 후 추가 작업을 진행할 수 있습니다.

``` objc
@protocol ToastInAppPurchaseDelegate <NSObject>

// 구매 성공
- (void)didReceivePurchaseResult:(ToastPurchaseResult *)purchase;

// 구매 실패
- (void)didFailPurchaseProduct:(NSString *)productIdentifier withError:(NSError *)error;

@end
```

### 초기화 과정 예

``` objc
#import <UIKit/UIKit.h>
#import <ToastIAP/ToastIAP.h>

@interface ViewController () <ToastInAppPurchaseDelegate>

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 초기화 및 Delegate 설정
    ToastIAPConfiguration *configuration =[[ToastIAPConfiguration alloc] initWithAppKey:@"INPUT_YOUR_APPKEY"];

    [ToastIAP initWithConfiguration:configuration delegate:self];
}

// 구매 성공
- (void)didReceivePurchaseResult:(ToastPurchaseResult *)purchase {
    NSLog(@"Successfully purchased");
}

// 구매 실패
- (void)didFailPurchaseProduct:(NSString *)productIdentifier withError:(NSError *)error {
    NSLog(@"Failed to purchase: %@", erorr);
}

@end
```

## 상품 목록 조회

IAP 콘솔에 등록되어 있는 상품 중 사용 여부 설정이 USE인 상품의 목록을 조회합니다.
스토어(Apple)에서 상품 정보를 획득하지 못한 상품은 invalidProducts 항목으로 표시됩니다.

### 상품 목록 조회 API 명세

``` objc
@interface ToastIAP : NSObject

// ...

// 상품 목록 조회
+ (void)requestProductsWithCompletionHandler:(nullable void (^)(ToastProductsResponse * _Nullable response, NSError * _Nullable error))completionHandler;

// ...

@end
```

### 상품 목록 조회 API 사용 예

``` objc
[ToastIAP requestProductsWithCompletionHandler:^(ToastProductsResponse *response, NSError *error) {

    if (error == nil) {
        NSArray<ToastProduct *> *products = response.products;
        NSLog(@"Products : %@", products);

        // 스토어로 부터 상품정보를 획득하지 못함
        NSArray<ToastProduct *> *invalidProducts = response.invalidProducts;
        NSLog(@"Invalid Products : %@", invalidProducts);

    } else {
        NSLog(@"Failed to request products: %@", error);
    }
}
```

### 상품 종류

`자동 갱신형 구독 상품의 업그레이드, 다운그레이드, 수정 기능은 지원하지 않습니다.`
하나의 구독 그룹에 하나의 상품만 등록해야 합니다.

``` objc
// 상품종류 획득 실패
ToastProductTypeUnknown = 0

// 소비성 상품
ToastProductTypeConsumable = 1

// 자동 갱신형 구독 상품
ToastProductTypeAutoRenewableSubscription = 2
```

## 상품 구매

구매 결과는 설정된 Delegate를 통해 전달됩니다.
구매 진행 중에 앱이 종료되거나 네트워크 오류 등으로 구매가 중단되었을 경우 앱이 재실행되면, IAP SDK를 초기화할 때 구매 재처리를 진행합니다.

### 상품 객체를 이용한 구매 요청

상품 목록 조회 결과의 ToastProduct 객체를 이용해 구매를 요청합니다.

#### 상품 객체를 이용한 구매 API 명세

``` objc
@interface ToastIAP : NSObject

// ...

// 상품 구매
+ (void)purchaseWithProduct:(ToastProduct *)product;

// ...

@end
```

#### 상품 객체를 이용한 구매 API 사용 예

``` objc
@property (nonatomic) NSArray <ToastProduct *> *products;

// 상품 목록 조회
[ToastIAP requestProductsWithCompletionHandler:^(ToastProductsResponse *response, NSError *error) {

    if (error == nil) {
        // 구매 가능한 상품 목록 저장
        self.products = response.products;

    } else {
        NSLog(@"Failed to request products: %@", error);
    }
}

// 상품 구매 요청
[ToastIAP purchaseWithProduct:self.products[0]];
```

### 상품 ID를 이용한 구매 요청

서비스에서 별도로 상품 목록을 관리하고 있다면, 상품 ID만을 이용해 구매를 요청합니다.
구매할 수 없는 상품이면 Delegate를 통해 구매 불가 상품임을 나타내는 오류가 전달됩니다.

#### 상품 ID를 이용한 구매 API 명세

``` objc
@interface ToastIAP (Additional)

// ...

// 상품 구매
+ (void)purchaseWithProductIdentifier:(NSString *)productIdentifier;

// ...

@end
```

#### 상품 ID를 이용한 구매 API 사용 예

``` objc
// 상품 구매 요청
[ToastIAP purchaseWithProductIdentifier:@"PRODUCT_IDENTIFIER"];
```

## 활성화된 구매 목록 조회

현재 사용자 ID에 활성화된 구매(만료되지 않고 구독 중인 구독 상품) 목록을 조회합니다.
사용자 ID가 같다면 Android에서 구매한 구독 상품도 조회됩니다.

### 활성화된 구매 목록 조회 API 명세

``` objc
@interface ToastIAP : NSObject

// ...

// 활성화된 구매 목록 조회하기
+ (void)requestActivePurchasesWithCompletionHandler:(nullable void (^)(NSArray<ToastPurchaseResult *> * _Nullable purchases, NSError * _Nullable error))completionHandler;

// ...

@end
```

### 활성화된 구매 목록 조회 API 사용 예

``` objc
[ToastIAP requestActivePurchasesWithCompletionHandler:^(NSArray<ToastPurchaseResult *> *purchases, NSError *error) {

    if (error == nil) {
        for (ToastPurchaseResult *purchase in purchases) {
            // 구독 상품 접근 활성화
        }

    } else {
        NSLog(@"Failed to request active purchases : %@", error);
    }
}];
```

## 구매 복원

현재 사용자 ID에서 구매된 항목 중 복원 가능한 구매 목록을 조회합니다.

### 구매 복원 API 명세

``` objc
@interface ToastIAP : NSObject

// ...

// 구매 복원
+ (void)restoreWithCompletionHandler:(nullable void (^)(NSArray<ToastPurchaseResult *> * _Nullable purchases, NSError * _Nullable error))completionHandler;

// ...

@end
```

### 구매 복원 API 사용 예

``` objc
[ToastIAP restoreWithCompletionHandler:^(NSArray<ToastPurchaseResult *> *purchases, NSError *error) {

    if (error == nil) {
        for (ToastPurchaseResult *purchase in purchases) {
            NSLog(@"Restored purchase : %@", purchase);
        }

    } else {
        NSLog(@"Failed to request restore : %@", error);
    }
}];
```

## 미소비 구매 내역 조회

소비성 상품의 경우 상품 지급 후에 소비(consume) 처리를 해야 합니다.
소비 처리되지 않은 구매 내역을 조회합니다.

### 미소비 구매 내역 조회 API 명세

``` objc
@interface ToastIAP : NSObject

// ...

// 미소비 구매 내역 조회
+ (void)requestConsumablePurchasesWithCompletionHandler:(nullable void (^)(NSArray<ToastPurchaseResult *> * _Nullable purchases, NSError * _Nullable error))completionHandler;

// ...

@end
```

### 미소비 구매 내역 조회 API 사용 예

``` objc
[ToastIAP requestConsumablePurchasesWithCompletionHandler:^(NSArray<ToastPurchaseResult *> *purchases, NSError *error) {
    if (error == nil) {
        NSLog(@"Consumable Purchases : %@", purchases);

    } else {
        NSLog(@"Failed to request consumable : %@", error);
    }
}
```

## 소비성 상품 소비

소비성 상품의 경우 서비스에 상품 지급 후에 REST API 혹은 SDK의 Consume API로 소비 처리를 해야 합니다.

### 소비 API 명세

``` objc
@interface ToastIAP (Additional)

// ...

+ (void)consumeWithPurchaseResult:(ToastPurchaseResult *)result
                completionHandler:(nullable void (^)(NSError * _Nullable error))completionHandler;

// ...

@end
```

### 소비 API 사용 예

``` objc
// 미소비 구매 내역 조회
[ToastIAP requestConsumablePurchasesWithCompletionHandler:^(NSArray<ToastPurchaseResult *> *purchases, NSError *error) {
    if (error == nil) {
        for (ToastPurchaseResult *purchaseResult in purchases) {
            // 상품 지급 처리
            // ...

            // 상품 지급 후 소비 처리
            [ToastIAP consumeWithPurchaseResult:purchaseResult
                              completionHandler:^(NSError *error) {
                                    if (error == nil) {
                                        NSLog(@"Successfully consumed");

                                    } else {
                                        NSLog(@"Failed to consume : %@", error);

                                        // 상품 지급 회수
                                        // ...
                                    }
                              }];
        }

    } else {
        NSLog(@"Failed to request consumable : %@", error);
    }
}
```

## 구독 상품 관리 페이지 제공 방법

자동 갱신형 구독 상품을 사용할 경우 사용자에게 구독 관리 페이지를 제공해야 합니다.
> [Apple Guide](https://developer.apple.com/library/archive/documentation/NetworkingInternet/Conceptual/StoreKitGuide/Chapters/Subscriptions.html#//apple_ref/doc/uid/TP40008267-CH7-SW19)

별도의 UI를 구성하지 않고 아래 URL을 호출해 구독 관리 페이지를 표시해야 합니다.
### Safari를 통한 구독 관리 페이지 연결 방법
```
https://buy.itunes.apple.com/WebObjects/MZFinance.woa/wa/manageSubscriptions
```
```objc
[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://buy.itunes.apple.com/WebObjects/MZFinance.woa/wa/manageSubscriptions"]];
```
#### Safari를 통해 관리 페이지를 호출할 때는 다음과 같은 순서로 관리 페이지가 표시됩니다.
1. Safari Open
2. Popup 노출 : itunse Store에서 열겠습니까?
3. iTunse Store Open
4. Popup으로 구독 관리 페이지 연결

> iOS 기기의 왼쪽 상단의 이전 앱으로 돌아가기에 `Safari`가 나타납니다.


### Scheme을 통한 구독 관리 페이지 연결 방법
```
itms-apps://buy.itunes.apple.com/WebObjects/MZFinance.woa/wa/manageSubscriptions
```

```objc
[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://buy.itunes.apple.com/WebObjects/MZFinance.woa/wa/manageSubscriptions"]];
```
#### Scheme을 통해 관리 페이지를 호출할 때는 다음과 같은 순서로 관리 페이지가 표사됩니다.
1. App Store의 구독 관리 페이지가 App To App 호출로 바로 연결됩니다.

> iOS 기기의 왼쪽 상단의 이전 앱으로 돌아가기에 `Service App`이 나타납니다.



## (구)IAP SDK 호환성 유지

(구)IAP SDK와의 호환성을 유지할 수 있게 (구)IAP SDK에서 생성된 미완료 구매 건의 재처리 기능을 제공합니다.
>(구)IAP SDK와의 호환성 유지 기능을 사용하려면 `sqlite3 Library(libsqlite3.tdb)`를 추가로 연결(link)해야 합니다.

![linked_sqlite3](http://static.toastoven.net/toastcloud/sdk/ios/iap_link_sqlite3.png)

### 미완료 결제 재처리 API 명세

``` objc
@interface ToastIAP (Additional)

// ...

+ (void)processesIncompletePurchasesWithCompletionHandler:(nullable void (^)(NSArray <ToastPurchaseResult *> * _Nullable results, NSError * _Nullable error))completionHandler;

// ...

@end
```

### 미완료 결제 재처리 API 사용 예

``` objc
// 미완료 결제 재처리 요청
[ToastIAP processesIncompletePurchasesWithCompletionHandler:^(NSArray<ToastPurchaseResult *> *results, NSError *error) {
    if (error == nil) {
        for (ToastPurchaseResult *purchaseResult in results) {
            // 상품 지급 처리
            // ...

            // 상품 지급 후 소비 처리
            [ToastIAP consumeWithPurchaseResult:purchaseResult
                              completionHandler:^(NSError *error) {
                                    if (error == nil) {
                                        NSLog(@"Successfully consumed");

                                    } else {
                                        NSLog(@"Failed to consume : %@", error);

                                        // 상품 지급 회수
                                        // ...
                                    }
                              }];
        }

    } else {
        NSLog(@"Failed to process incomplete purchases : %@", error);
    }
}];
```

### 에러 코드
```objc
typedef NS_ENUM(NSUInteger, ToastIAPErrorCode) {
    ToastIAPErrorUnknown = 0,                       // 알수 없음
    
    ToastIAPErrorNotInitialized = 1,                // 초기화하지 않음
    ToastIAPErrorStoreNotAvailable = 2,             // 스토어 사용 불가
    ToastIAPErrorProductNotAvailable = 3,           // 상품 정보 획득 실패
    ToastIAPErrorProductInvalid = 4,                // 원결제의 상품 ID와 현재 상품 ID 불일치
    ToastIAPErrorAlreadyOwned = 5,                  // 이미 소유한 상품
    ToastIAPErrorAlreadyInProgress = 6,             // 이미 진행 중인 요청 있음
    ToastIAPErrorUserInvalid = 7,                   // 현재 사용자 ID가 결제 사용자 ID와 불일치
    ToastIAPErrorPaymentInvalid = 8,                // 결제 추가정보(ApplicationUsername) 획득 실패
    ToastIAPErrorPaymentCancelled = 9,              // 스토어 결제 취소
    ToastIAPErrorPaymentFailed = 10,                // 스토어 결제 실패
    ToastIAPErrorVerifyFailed = 11,                 // 영수증 검증 실패
    ToastIAPErrorChangePurchaseStatusFailed = 12,   // 구매 상태 변경 실패
    ToastIAPErrorPurchaseStatusInvalid = 13,        // 구매 진행 불가 상태
    ToastIAPErrorExpired = 14,                      // 구독 만료
    
    ToastIAPErrorNetworkNotAvailable = 100,         // 네트워크 사용 불가
    ToastIAPErrorNetworkFailed = 101,               // HTTP Status Code 가 200이 아님
    ToastIAPErrorTimeout = 102,                     // 타임아웃
    ToastIAPErrorParameterInvalid = 103,            // 요청 파라미터 오류
    ToastIAPErrorResponseInvalid = 104,             // 서버 응답 오류
};
```

