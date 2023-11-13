## NHN Cloud > SDK 사용 가이드 > IAP > iOS

## Prerequisites

1. [NHN Cloud SDK](./getting-started-ios)를 설치합니다.
2. [NHN Cloud 콘솔](https://console.nhncloud.com)에서 [Mobile Service \> IAP를 활성화](https://docs.nhncloud.com/ko/Mobile%20Service/IAP/ko/console-guide/)합니다.
3. IAP에서 [AppKey를 확인](https://docs.nhncloud.com/ko/Mobile%20Service/IAP/ko/console-guide/#appkey)합니다.

## NHN Cloud IAP 구성

iOS용 NHN Cloud IAP SDK의 구성은 다음과 같습니다.

| Service  | Cocoapods Pod Name | Framework | Dependency | Build Settings |
| --- | --- | --- | --- | --- |
| IAP | NHNCloudIAP | NHNCloudIAP.framework | * StoreKit.framework<br/><br/>[Optional]<br/> * libsqlite3.tdb | |
| Mandatory   | NHNCloudCore<br/>NHNCloudCommon | NHNCloudCore.framework<br/>NHNCloudCommon.framework | | OTHER_LDFLAGS = (<br/>    "-ObjC",<br/>    "-lc++" <br/>); |


## NHN Cloud IAP SDK를 Xcode 프로젝트에 적용

### 1. Cococapods 을 통한 적용

* Podfile을 생성하여 NHN Cloud SDK에 대한 Pod을 추가합니다.

```podspec
platform :ios, '11.0'
use_frameworks!

target '{YOUR PROJECT TARGET NAME}' do
    pod 'NHNCloudIAP'
end
```

### 2. Swift Package Manager를 사용해 NHN Cloud SDK 적용

* XCode에서 **File > Add Packages...** 메뉴를 선택합니다.
* Package URL에 'https://github.com/nhn/nhncloud.ios.sdk'를 넣고 **Add Package** 버튼을 선택합니다.
* NHNCloudIAP를 선택합니다.

![swift_package_manager](https://static.toastoven.net/toastcloud/sdk/ios/swiftpackagemanager01.png)

#### 프로젝트 설정

* **Build Settings**의 **Other Linker Flags**에 **-lc++**와 **-ObjC** 항목을 추가합니다.
    * **Project Target > Build Settings > Linking > Other Linker Flags**
![other_linker_flags](https://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags_202206.png)

### 3. 바이너리를 다운로드하여 NHN Cloud SDK 적용

#### 프레임워크 설정

* NHN Cloud [Downloads](../../../Download/#toast-sdk) 페이지에서 전체 iOS SDK를 다운로드할 수 있습니다.
* Xcode Project에 **NHNCloudIAP.framework**, **NHNCloudCore.framework**, **NHNCloudCommon.framework, StoreKit.framework**를 추가합니다.
* StoreKit.framework는 아래 방법으로 추가할 수 있습니다.
![linked_storekit_frameworks](https://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_StoreKit_202206.png)

![linked_frameworks_iap](https://static.toastoven.net/toastcloud/sdk/ios/iap_link_frameworks_iap_202206.png)

#### 프로젝트 설정

* **Build Settings**의 **Other Linker Flags**에 **-lc++**와 **-ObjC** 항목을 추가합니다.
    * **Project Target > Build Settings > Linking > Other Linker Flags**
![other_linker_flags](https://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags_202206.png)


### Capabilities 설정

* NHN Cloud IAP를 사용하려면 Capabilities에서 **In-App Purchase** 항목을 활성화해야 합니다.
    * **Project Target > Capabilities > In-App Purchase**
![capabilities_iap](https://static.toastoven.net/toastcloud/sdk/ios/capability_iap_202206.png)

## 서비스 로그인

* NHN Cloud SDK에서 제공하는 모든 상품(Log&Crash, IAP, Push, ...)은 하나의 사용자 아이디를 공유합니다.

### 로그인

* `사용자 아이디가 설정되지 않은 상태에서는 구매, 활성화된 상품 조회, 미소비 내역 조회 기능을 사용할 수 없습니다.`

``` objc
// 서비스 로그인 완료 후 사용자 아이디 설정
[NHNCloudSDK setUserID:@"INPUT_USER_ID"];
```

### 로그아웃

``` objc
// 서비스 로그아웃 완료 후 사용자 아이디를 nil로 설정
[NHNCloudSDK setUserID:nil];
```

## NHN Cloud IAP SDK 초기화

* IAP 콘솔에서 발급 받은 [AppKey](https://docs.nhncloud.com/ko/Mobile%20Service/IAP/ko/console-guide/#appkey)를 [NHNCloudIAPConfiguration](./iap-ios/#nhncloudiapconfiguration) 객체에 설정합니다.
* NHN Cloud IAP는 초기화에 [NHNCloudIAPConfiguration](./iap-ios/#nhncloudiapconfiguration) 객체를 파라미터로 사용합니다.

### 초기화 API 명세

``` objc
// 초기화
+ (void)initWithConfiguration:(NHNCloudIAPConfiguration *)configuration;
// Delegate 설정
+ (void)setDelegate:(nullable id<NHNCloudInAppPurchaseDelegate>)delegate;
// 초기화 및 Delegate 설정
+ (void)initWithConfiguration:(NHNCloudIAPConfiguration *)configuration
                     delegate:(nullable id<NHNCloudInAppPurchaseDelegate>)delegate;
```

### Delegate API 명세

* [NHNCloudInAppPurchaseDelegate](./iap-ios/#nhncloudinapppurchasedelegate) 를 등록하면 구매 결과와 프로모션 결제의 진행여부 결정에 대한 통지를 받을 수 있습니다.
    * 프로모션 결제를 SDK에서 진행할지 사용자가 원하는 시점에 직접 결제를 요청할지 결정 할 수 있습니다.
* 재처리에 의해 결제가 완료된 구매 건은 Delegating 되지 않고, 미소비 상품 목록(소모성 상품), 활성화된 구독 목록(구독 상품)에 반영됩니다.
* `결제 결과에 대한 통지를 받기 위해서는 상품 구매 전에 Delegate 가 설정되어 있어야만 합니다.`


``` objc
@protocol NHNCloudInAppPurchaseDelegate <NSObject>

// 구매 성공
- (void)didReceivePurchaseResult:(NHNCloudPurchaseResult *)purchase;

// 구매 실패
- (void)didFailPurchaseProduct:(NSString *)productIdentifier withError:(NSError *)error;

@optional
// 프로모션 결제 진행 방법 선택
- (BOOL)shouldAddStorePurchaseForProduct:(NHNCloudProduct *)product API_AVAILABLE(ios(11.0));
@end
```

### 초기화 과정 예

``` objc
#import <UIKit/UIKit.h>
#import <NHNCloudIAP/NHNCloudIAP.h>

@interface ViewController () <NHNCloudInAppPurchaseDelegate>
@end

@implementation ViewController

- (void)initializeNHNCloudIAP {
    // 초기화 및 Delegate 설정
    NHNCloudIAPConfiguration *configuration = [NHNCloudIAPConfiguration configurationWithAppKey:@"INPUT_YOUE_APPKEY"];

    [NHNCloudIAP initWithConfiguration:configuration delegate:self];
}

// 구매 성공
- (void)didReceivePurchaseResult:(NHNCloudPurchaseResult *)purchase {
    NSLog(@"Successfully purchased");
}

// 구매 실패
- (void)didFailPurchaseProduct:(NSString *)productIdentifier withError:(NSError *)error {
    NSLog(@"Failed to purchase: %@", error);
}

// 프로모션 결제 진행 방법 선택
- (BOOL)shouldAddStorePurchaseForProduct:(NHNCloudProduct *)product {
    /*
    * return YES;
        * 요청한 프로모션 결제를 SDK에서 수행하도록 합니다.
        * 초기화 및 로그인 후 결제창이 출력됩니다.
    */
    return YES;

    /*
    * return NO;
        * 프로모션 결제가 종료됩니다.
        * product 객체를 저장한뒤 이후 원하는 시점에 저장된 객체로 결제를 진행 할 수 있습니다.
    */
    self.promotionProduct = product;
    return NO;
}

@end
```

## 상품 목록 조회

* IAP 콘솔에 등록된 상품이 [NHNCloudProductResponse](./iap-ios/#nhncloudproductresponse) 객체로 반환됩니다.
* IAP 콘솔에 등록된 상품 중 구매 가능한 상품은 products([NHNCloudProduct](./iap-ios/#nhncloudproduct))로 반환됩니다.
* IAP 콘솔에 등록된 상품 중 스토어(Apple)에서 상품 정보를 획득하지 못한 상품은 invalidProducts([NHNCloudProduct](./iap-ios/#nhncloudproduct))로 반환됩니다.

### 상품 목록 조회 API 명세

``` objc
+ (void)requestProductsWithCompletionHandler:(nullable void (^)(NHNCloudProductsResponse * _Nullable response, NSError * _Nullable error))completionHandler;
```

### 상품 목록 조회 API 사용 예

``` objc
[NHNCloudIAP requestProductsWithCompletionHandler:^(NHNCloudProductsResponse *response, NSError *error) {
    if (error == nil) {
        NSArray<NHNCloudProduct *> *products = response.products;
        NSLog(@"Products : %@", products);

        // 스토어로 부터 상품정보를 획득하지 못함
        NSArray<NHNCloudProduct *> *invalidProducts = response.invalidProducts;
        NSLog(@"Invalid Products : %@", invalidProducts);

    } else {
        NSLog(@"Failed to request products: %@", error);
    }
}
```

### 상품 종류

| 상품명    | 상품타입             | 설명                                     |
| ------ | ---------------- | -------------------------------------- |
| 소비성 상품 | NHNCloudProductTypeConsumable     | 소비 가능한 일회성 상품입니다. <br/>게임내 재화, 코인, 반복 구입 가능한 상품등에 사용할 수 있습니다. |
| 자동 갱신형 구독 상품  | NHNCloudProductTypeAutoRenewableSubscription | 지정된 간격 및 가격으로 결제가 자동으로 반복되는 상품입니다, <br>잡지, 음악 스트리밍 접근 허용, 광고 제거등에 사용할 수 있습니다. |
| 자동 갱신형 소비성 구독 상품 | NHNCloudProductTypeConsumableSubscription | 지정된 간격 및 가격으로 결제가 자동으로 반복되는 상품입니다. <br/>지정된 간격 및 가격으로 소비성 상품을 지급하고자 할 때 사용할 수 있습니다. |

> `자동 갱신형 구독 상품의 업그레이드, 다운그레이드, 수정 기능은 지원하지 않습니다.`
> `하나의 구독 그룹에 하나의 상품만 등록해야 합니다.`


``` objc
typedef NS_ENUM(NSInteger, NHNCloudProductType) {
    // 상품종류 획득 실패
    NHNCloudProductTypeUnknown = 0,
    // 소비성 상품
    NHNCloudProductTypeConsumable = 1,
    // 자동 갱신형 구독 상품
    NHNCloudProductTypeAutoRenewableSubscription = 2,
    // 자동 갱신형 소비성 구독 상품
    NHNCloudProductTypeConsumableSubscription = 3
};
```

## 상품 구매

* 구매 결과는 설정된 [NHNCloudInAppPurchaseDelegate](./iap-ios/#nhncloudinapppurchasedelegate)를 통해 전달됩니다.
* 구매 진행 중에 앱이 종료되거나 네트워크 오류 등으로 구매가 중단되었을 경우 다음번 앱 실행의 IAP SDK 초기화 이후 재처리가 진행됩니다.
* 구매 요청시 사용자 데이터 추가가 가능합니다.
* 사용자 데이터는 결제 결과(구매 성공 Delegate, 미소비 결제 내역, 활성화된 구독, 구매 복원)의 [NHNCloudPurchaseResult](./iap-ios/#nhncloudpurchaseresult) 객체에 포함되어 반환됩니다.
* 구매할 수 없는 상품이면 [NHNCloudInAppPurchaseDelegate](./iap-ios/#nhncloudinapppurchasedelegate)를 통해 구매 불가 상품임을 나타내는 오류가 전달됩니다.
* 상품 목록 조회 결과의 [NHNCloudProduct](./iap-ios/#nhncloudproduct) 객체 혹은 상품 아이디를 이용해 구매를 요청합니다.

### 상품 구매 API 명세

``` objc
// 상품 구매 요청
+ (void)purchaseWithProduct:(NHNCloudProduct *)product;
// 상품 구매 요청시 사용자 데이터 추가
+ (void)purchaseWithProduct:(NHNCloudProduct *)product payload:(NSString *)payload;
// 상품 아이디로 구매 요청
+ (void)purchaseWithProductIdentifier:(NSString *)productIdentifier;
// 상품 아이디로 구매 요청시 사용자 데이터 추가
+ (void)purchaseWithProductIdentifier:(NSString *)productIdentifier payload:(NSString *)payload;
```

### 상품 구매 API 사용 예

``` objc
// 상품 구매 요청
[NHNCloudIAP purchaseWithProduct:self.products[0] payload:@"DEVELOPER_PAYLOAD"];
// or
// 상품 아이디로 구매 요청
[NHNCloudIAP purchaseWithProductIdentifier:@"PRODUCT_IDENTIFIER" payload:@"DEVELOPER_PAYLOAD"];
```

## 활성화된 구독 목록 조회

* 현재 사용자 ID 기준으로 활성화된 구독 목록을 조회합니다.
* 결제가 완료된 구독 상품(자동 갱신형 구독, 자동 갱신형 소비성 구독 상품)은 만료되기 전까지 계속 [NHNCloudPurchaseResult](./iap-ios/#nhncloudpurchaseresult) 객체로 반환됩니다.
* 사용자 ID가 같다면 Android에서 구매한 구독 상품도 조회됩니다.

### 활성화된 구독 목록 조회 API 명세

``` objc
// 활성화된 앱스토어 구독 목록 조회하기
+ (void)requestActiveSubscriptionsWithCompletionHandler:(nullable void (^)(NSArray<NHNCloudPurchaseResult *> * _Nullable purchases, NSError * _Nullable error))completionHandler;

// 활성화된 모든 마켓(앱스토어, 구글플레이, 원스토어 등) 구독 목록 조회하기
+ (void)requestAllMarketsActiveSubscriptionsWithCompletionHandler:(nullable void (^)(NSArray<NHNCloudPurchaseResult *> * _Nullable purchases, NSError * _Nullable error))completionHandler;
```

### 활성화된 구독 목록 조회 API 사용 예

``` objc
[NHNCloudIAP requestActiveSubscriptionsWithCompletionHandler:^(NSArray<NHNCloudPurchaseResult *> *purchases, NSError *error) {
    if (error == nil) {
        for (NHNCloudPurchaseResult *purchase in purchases) {
            // 구독 상품 접근 활성화
        }
    } else {
        NSLog(@"Failed to request active purchases : %@", error);
    }
}];
```

## 구매 복원

* 사용자의 AppStore 계정으로 구매한 내역을 기준으로 구매 내역을 복원하여 IAP 콘솔에 반영합니다.
* 구매한 구독 상품이 조회되지 않거나 활성화 되지 않을 경우 사용합니다.
* 만료된 결제건을 포함하여 복원된 결제건이 [NHNCloudPurchaseResult](./iap-ios/#nhncloudpurchaseresult) 객체로 반환됩니다.
* 자동 갱신형 소비성 구독 상품의 경우 반영되지 않은 구매 내역이 존재할 경우 복원 후 미소비 구매 내역에서 조회 가능합니다.

### 구매 복원 API 명세

``` objc
// 구매 복원
+ (void)restoreWithCompletionHandler:(nullable void (^)(NSArray<NHNCloudPurchaseResult *> * _Nullable purchases, NSError * _Nullable error))completionHandler;
```

### 구매 복원 API 사용 예

``` objc
[NHNCloudIAP restoreWithCompletionHandler:^(NSArray<NHNCloudPurchaseResult *> *purchases, NSError *error) {
    if (error == nil) {
        for (NHNCloudPurchaseResult *purchase in purchases) {
            NSLog(@"Restored purchase : %@", purchase);
        }
    } else {
        NSLog(@"Failed to request restore : %@", error);
    }
}];
```

## 미소비 구매 내역 조회

* 소비성 상품의 경우 상품 지급 후에 소비(consume) 처리를 해야 합니다.
* 소비 처리되지 않은 구매 내역이 [NHNCloudPurchaseResult](./iap-ios/#nhncloudpurchaseresult) 객체로 반환됩니다.
* 자동 갱신형 소비성 구독 상품은 갱신 결제가 발생할 때마다 미소비 구매 내역에서 조회 가능합니다.

### 미소비 구매 내역 조회 API 명세

``` objc
// 앱스토어 미소비 구매 내역 조회
+ (void)requestConsumablePurchasesWithCompletionHandler:(nullable void (^)(NSArray<NHNCloudPurchaseResult *> * _Nullable purchases, NSError * _Nullable error))completionHandler;

// 모든 마켓(앱스토어, 구글플레이, 원스토어 등)의 미소비 구매 내역 조회
+ (void)requestAllMarketsConsumablePurchasesWithCompletionHandler:(nullable void (^)(NSArray<NHNCloudPurchaseResult *> * _Nullable purchases, NSError * _Nullable error))completionHandler;
```

### 미소비 구매 내역 조회 API 사용 예

``` objc
[NHNCloudIAP requestConsumablePurchasesWithCompletionHandler:^(NSArray<NHNCloudPurchaseResult *> *purchases, NSError *error) {
    if (error == nil) {
        NSLog(@"Consumable Purchases : %@", purchases);
    } else {
        NSLog(@"Failed to request consumable : %@", error);
    }
}
```

## 소비성 상품 소비

* 소비성 상품의 경우 서비스에 상품 지급 후에 REST API 혹은 SDK의 Consume API로 소비 처리를 해야 합니다.

### 소비 API 명세

``` objc
+ (void)consumeWithPurchaseResult:(NHNCloudPurchaseResult *)result
                completionHandler:(nullable void (^)(NSError * _Nullable error))completionHandler;
```

### 소비 API 사용 예

``` objc
// 미소비 구매 내역 조회
[NHNCloudIAP requestConsumablePurchasesWithCompletionHandler:^(NSArray<NHNCloudPurchaseResult *> *purchases, NSError *error) {
    if (error == nil) {
        for (NHNCloudPurchaseResult *purchaseResult in purchases) {
            // 상품 지급 처리
            // ...

            // 상품 지급 후 소비 처리
            [NHNCloudIAP consumeWithPurchaseResult:purchaseResult
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

* 자동 갱신형 구독 상품을 사용할 경우 사용자에게 구독 관리 페이지를 제공해야 합니다.
> [Apple Guide](https://developer.apple.com/documentation/storekit/in-app_purchase/original_api_for_in-app_purchase/subscriptions_and_offers/handling_subscriptions_billing?language=objc)

* 별도의 UI를 구성하지 않고 아래 URL을 호출해 구독 관리 페이지를 표시해야 합니다.

```
https://apps.apple.com/account/subscriptions
itms-apps://buy.itunes.apple.com/WebObjects/MZFinance.woa/wa/manageSubscription
```

### 구독 관리 페이지 연결 방법

```objc
[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://apps.apple.com/account/subscriptions"] options: @{} completionHandler:nil];
```

또는

```objc
[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://buy.itunes.apple.com/WebObjects/MZFinance.woa/wa/manageSubscriptions"] options: @{} completionHandler:nil];
```

App Store의 구독 관리 페이지로 연결됩니다.

> iOS 기기의 왼쪽 상단의 이전 앱으로 돌아가기에 `Service App`이 나타납니다.

## (구)IAP SDK 호환성 유지

* (구)IAP SDK와의 호환성을 유지할 수 있게 (구)IAP SDK에서 생성된 미완료 구매 건의 재처리 기능을 제공합니다.
* (구)IAP SDK와의 호환성 유지 기능을 사용하려면 `sqlite3 Library(libsqlite3.tdb)`를 추가로 연결(link)해야 합니다.
![linked_sqlite3](https://static.toastoven.net/toastcloud/sdk/ios/iap_link_sqlite3_202206.png)

### 미완료 구매 재처리 API 명세

``` objc
+ (void)processesIncompletePurchasesWithCompletionHandler:(nullable void (^)(NSArray <NHNCloudPurchaseResult *> * _Nullable results, NSError * _Nullable error))completionHandler;
```

### 미완료 구매 재처리 API 사용 예

``` objc
// 미완료 구매 재처리 요청
[NHNCloudIAP processesIncompletePurchasesWithCompletionHandler:^(NSArray<NHNCloudPurchaseResult *> *results, NSError *error) {
    if (error == nil) {
        for (NHNCloudPurchaseResult *purchaseResult in results) {
            // 상품 지급 처리
            // ...

            // 상품 지급 후 소비 처리
            [NHNCloudIAP consumeWithPurchaseResult:purchaseResult
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


## NHN Cloud IAP Class Reference

### NHNCloudIAPConfiguration

NHN Cloud IAP 초기화 메소드의 파라미터로 사용되는 인앱 결제 설정 정보입니다.

```objc
@interface NHNCloudIAPConfiguration : NSObject <NSCoding, NSCopying>

// IAP 서비스 앱 키
@property (nonatomic, copy, readonly) NSString *appKey;
// 서비스 존
@property (nonatomic) NHNCloudServiceZone serviceZone;

+ (instancetype)configurationWithAppKey:(NSString *)appKey;

- (instancetype)initWithAppKey:(NSString *)appKey
NS_SWIFT_NAME(init(appKey:));

@end
```

## NHNCloudInAppPurchaseDelegate

결제 결과를 통지받고 프로모션 결제의 수행 방식을 설정 할 수 있습니다.

```objc
@protocol NHNCloudInAppPurchaseDelegate <NSObject>

// 결제 성공
- (void)didReceivePurchaseResult:(NHNCloudPurchaseResult *)purchase
NS_SWIFT_NAME(didReceivePurchase(purchase:));

// 결제 실패
- (void)didFailPurchaseProduct:(NSString *)productIdentifier withError:(NSError *)error
NS_SWIFT_NAME(didFailPurchase(productIdentifier:error:));

@optional
// 프로모션 결제 진행 방법 선택
- (BOOL)shouldAddStorePurchaseForProduct:(NHNCloudProduct *)product API_AVAILABLE(ios(11.0));

@end
```

## NHNCloudProductResponse

상품 목록 정보를 확인 할 수 있습니다.

```objc
@interface NHNCloudProductsResponse : NSObject <NSCoding, NSCopying>

// IAP 콘솔과 스토어(Apple)에 등록되어 있는 결제에 사용할 수 있는 상품 목록
@property (nonatomic, copy, readonly) NSArray<NHNCloudProduct *> *products;
// 스토어(Apple)에서 상품 정보를 획득하지 못한 상품 목록
@property (nonatomic, copy, readonly) NSArray<NHNCloudProduct *> *invalidProducts;

@end
```

## NHNCloudProduct

NHN Cloud IAP 콘솔에 등록된 상품의 정보를 확인할 수 있습니다.

```objc
@interface NHNCloudProduct : NSObject <NSCoding, NSCopying>

// 상품의 ID
@property (nonatomic, copy, readonly) NSString *productIdentifier;
// 상품 고유 번호
@property (nonatomic, readonly) long productSeq;
// 상품 이름 (IAP Console)
@property (nonatomic, copy, readonly, nullable) NSString *productName;
// 상품 유형
@property (nonatomic, readonly) NHNCloudProductType productType;
// 가격
@property (nonatomic, copy, readonly, nullable) NSDecimalNumber *price;
// 통화
@property (nonatomic, copy, readonly, nullable) NSString *currency;
// 현지 상품 이름 (AppStoreConnect)
@property (nonatomic, copy, readonly, nullable) NSString *localizedTitle;
// 현지 상품 설명 (AppStoreConnect)
@property (nonatomic, copy, readonly, nullable) NSString *localizedDescription;
// 현지 가격
@property (nonatomic, copy, readonly, nullable) NSString *localizedPrice;
// 상품 활성화 여부
@property (nonatomic, readonly, getter=isActive) BOOL active;
// 스토어 코드 "AS"
@property (nonatomic, copy, readonly) NSString *storeCode;

@end
```

## NHNCloudPurchaseResult

결제 정보를 확인할 수 있습니다.

```objc
@interface NHNCloudPurchaseResult : NSObject <NSCoding, NSCopying>

// 사용자 ID
@property (nonatomic, copy, readonly) NSString *userID;
// 스토어 코드 "AS"
@property (nonatomic, copy, readonly) NSString *storeCode;
// 상품의 ID
@property (nonatomic, copy, readonly) NSString *productIdentifier;
// 상품 고유 번호
@property (nonatomic, readonly) long productSeq;
// 상품 유형
@property (nonatomic, readonly) NHNCloudProductType productType;
// 가격
@property (nonatomic, copy, readonly) NSDecimalNumber *price;
// 통화
@property (nonatomic, copy, readonly) NSString *currency;
// 결제 고유 번호결제 ID
@property (nonatomic, copy, readonly) NSString *paymentSeq;
// 소비에 사용되는 토큰
@property (nonatomic, copy, readonly) NSString *accessToken;
// 결제 ID
@property (nonatomic, copy, readonly) NSString *transactionIdentifier;
// 원본 결제 ID
@property (nonatomic, copy, readonly, nullable) NSString *originalTransactionIdentifier;
// 상품 구매 시간
@property (nonatomic, readonly) NSTimeInterval purchaseTime;
// 구독 상품의 만료 시간
@property (nonatomic, readonly) NSTimeInterval expiryTime;
// 프로모션 결제 여부
@property (nonatomic, readonly, getter=isStorePayment) BOOL storePayment;
// 샌드박스 결제 여부
@property (nonatomic, readonly, getter=isSandboxPayment) BOOL sandboxPayment;
// 사용자 데이터
@property (nonatomic, readonly, copy, nullable) NSString *payload;

@end
```

## 에러 코드
```objc
// IAP 기능 관련 에러 코드
static NSString *const NHNCloudIAPErrorDomain = @"com.nhncloud.iap";

typedef NS_ENUM(NSUInteger, NHNCloudIAPError) {
    NHNCloudIAPErrorUnknown = 0,                       // 알 수 없음
    NHNCloudIAPErrorNotInitialized = 1,                // 초기화 하지 않음
    NHNCloudIAPErrorStoreNotAvailable = 2,             // 스토어 사용 불가
    NHNCloudIAPErrorProductNotAvailable = 3,           // 상품 정보 획득 실패
    NHNCloudIAPErrorProductInvalid = 4,                // 원결제의 상품 아이디와 현재 상품 아이디 불일치
    NHNCloudIAPErrorAlreadyOwned = 5,                  // 이미 소유한 상품
    NHNCloudIAPErrorAlreadyInProgress = 6,             // 이미 진행중인 요청 있음
    NHNCloudIAPErrorUserInvalid = 7,                   // 현재 사용자 아이디가 결제 사용자 아이디와 불일치
    NHNCloudIAPErrorPaymentInvalid = 8,                // 결제 추가정보(ApplicationUsername) 획득 실패
    NHNCloudIAPErrorPaymentCancelled = 9,              // 스토어 결제 취소
    NHNCloudIAPErrorPaymentFailed = 10,                // 스토어 결제 실패
    NHNCloudIAPErrorVerifyFailed = 11,                 // 영수증 검증 실패
    NHNCloudIAPErrorChangePurchaseStatusFailed = 12,   // 구매 상태 변경 실패
    NHNCloudIAPErrorPurchaseStatusInvalid = 13,        // 구매 진행 불가 상태
    NHNCloudIAPErrorExpired = 14,                      // 구독 만료
    NHNCloudIAPErrorRenewalPaymentNotFound = 15,       // 영수증내에 갱신 결제와 일치하는 결제 정보가 없음
    NHNCloudIAPErrorRestoreFailed = 16,                // 복원 실패
    NHNCloudIAPErrorPaymentNotAvailable = 17,          // 구매 진행 불가 상태 (e.g. 앱 내 구입 제한 설정)
    NHNCloudIAPErrorPurchaseLimitExceeded = 18,        // 월 구매 한도 초과
};

// 네트워크 관련 에러 코드
static NSString *const NHNCloudHttpErrorDomain = @"com.nhncloud.http";

typedef NS_ENUM(NSUInteger, NHNCloudHttpError) {
    NHNCloudHttpErrorNetworkNotAvailable = 100,        // 네트워크 사용 불가
    NHNCloudHttpErrorRequestFailed = 101,              // HTTP Status Code 가 200이 아니거나 서버에서 요청을 제대로 읽지 못함
    NHNCloudHttpErrorRequestTimeout = 102,             // 타임아웃
    NHNCloudHttpErrorRequestInvalid = 103,             // 잘못된 요청 (파라미터 오류 등)
    NHNCloudHttpErrorURLInvalid = 104,                 // URL 오류
    NHNCloudHttpErrorResponseInvalid = 105,            // 서버 응답 오류
    NHNCloudHttpErrorAlreadyInprogress = 106,          // 동일 요청 이미 수행중
    NHNCloudHttpErrorRequiresSecureConnection = 107,   // Allow Arbitrary Loads 미설정
};
```
