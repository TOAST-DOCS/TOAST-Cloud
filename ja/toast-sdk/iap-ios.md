## TOAST > TOAST SDK使用ガイド > TOAST IAP > iOS

## Prerequisites

1\. [TOAST SDK](./getting-started-ios)をインストールします。
2\. [TOASTコンソール](https://console.cloud.toast.com)で[Mobile Service \> IAPを有効化](https://docs.toast.com/ko/Mobile%20Service/IAP/ko/console-guide/)します。
3\. IAPで[AppKeyを確認](https://docs.toast.com/ko/Mobile%20Service/IAP/ko/console-guide/#appkey)します。

## TOAST IAP構成

* iOS用TOAST IAP SDKの構成は次のとおりです。

| Service  | Cocoapods Pod Name | Framework | Dependency | Build Settings |
| --- | --- | --- | --- | --- |
| TOAST IAP | ToastIAP | ToastIAP.framework | * StoreKit.framework<br/><br/>[Optional]<br/> * libsqlite3.tdb | |
| Mandatory   | ToastCore<br/>ToastCommon | ToastCore.framework<br/>ToastCommon.framework | | OTHER_LDFLAGS = (<br/>    "-ObjC",<br/>    "-lc++" <br/>); |


## TOAST IAP SDKをXcodeプロジェクトに適用

### 1. Cococapods適用

* Podfileを作成して、TOAST SDKに対するPodを追加します。

```podspec
platform :ios, '9.0'
use_frameworks!

target '{YOUR PROJECT TARGET NAME}' do
    pod 'ToastIAP'
end
```

### 2. バイナリをダウンロードしてTOAST SDKを適用

#### Link Frameworks

* TOASTの[Downloads](../../../Download/#toast-sdk)ページで全体iOS SDKをダウンロードできます。
* Xcode Projectに**ToastIAP.framework**, **ToastCore.framework**, **ToastCommon.framework, StoreKit.framework**を追加します。
* StoreKit.frameworkは、下記の方法で追加できます。
![linked_storekit_frameworks](http://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_StoreKit.png)

![linked_frameworks_iap](http://static.toastoven.net/toastcloud/sdk/ios/iap_link_frameworks_iap.png)

#### Project Settings

* **Build Settings**の**Other Linker Flags**に**-lc++**と**-ObjC**項目を追加します。
    * **Project Target > Build Settings > Linking > Other Linker Flags**
![other_linker_flags](http://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags.png)

### Capabilities Setting

* TOAST IAPを使用するには、Capabilitiesで**In-App Purchase**項目を有効にする必要があります。
    * **Project Target > Capabilities > In-App Purchase**
![capabilities_iap](http://static.toastoven.net/toastcloud/sdk/ios/capability_iap.png)

## サービスログイン

* TOAST SDKで提供するすべてのサービス(IAP、Log & Crash、Pushなど)は、同じユーザーID1つのみ使用します。

### ログイン

* `ユーザーIDが設定されていない状態では、購入、有効になっている商品照会、未消費履歴照会機能を使用できません。`

``` objc
// サービスログイン完了後、ユーザーID設定
[ToastSDK setUserID:@"INPUT_USER_ID"];
```

### ログアウト

``` objc
// サービスログアウト完了後、ユーザーIDをnilに設定
[ToastSDK setUserID:nil];
```

## TOAST IAP SDK初期化

* TOAST IAPで発行されたAppKeyを設定します。
* 初期化と同時に未完了購入の件に対する再処理が行われます。

### 初期化API仕様

``` objc
// 初期化
+ (void)initWithConfiguration:(ToastIAPConfiguration *)configuration;

// Delegate設定
+ (void)setDelegate:(nullable id<ToastInAppPurchaseDelegate>)delegate;

// 初期化およびDelegate設定
+ (void)initWithConfiguration:(ToastIAPConfiguration *)configuration
                     delegate:(nullable id<ToastInAppPurchaseDelegate>)delegate;
```

### Delegate API仕様

* Delegateを登録すると,購入結果の通知を受けることができます。
    * 프로모션 결제를 SDK에서 진행할지 사용자가 원하는 시점에 직접 결제를 요청할지 결정 할 수 있습니다. 
* 再処理により決済が完了した購買件は,Delegatingされず,未消費商品リスト(消耗性商品),活性化された購読リスト(購読商品)に反映されます。
* `決済結果に対する通知を受けるためには,商品購入前にDelegateが設定されていなければなりません。`

``` objc
@protocol ToastInAppPurchaseDelegate <NSObject>

// 購入成功
- (void)didReceivePurchaseResult:(ToastPurchaseResult *)purchase;

// 購入失敗
- (void)didFailPurchaseProduct:(NSString *)productIdentifier withError:(NSError *)error;

@optional
// 프로모션 결제 진행 방법 선택
- (BOOL)shouldAddStorePurchaseForProduct:(ToastProduct *)product API_AVAILABLE(ios(11.0));
@end
```

### 初期化プロセス例

``` objc
#import <UIKit/UIKit.h>
#import <ToastIAP/ToastIAP.h>

@interface ViewController () <ToastInAppPurchaseDelegate>

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 初期化およびDelegate設定
    ToastIAPConfiguration *configuration = [ToastIAPConfiguration configurationWithAppKey:@"INPUT_YOUE_APPKEY"];

    [ToastIAP initWithConfiguration:configuration delegate:self];
}

// 購入成功
- (void)didReceivePurchaseResult:(ToastPurchaseResult *)purchase {
    NSLog(@"Successfully purchased");
}

// 購入失敗
- (void)didFailPurchaseProduct:(NSString *)productIdentifier withError:(NSError *)error {
    NSLog(@"Failed to purchase: %@", erorr);
}

// 프로모션 결제 진행 방법 선택
- (BOOL)shouldAddStorePurchaseForProduct:(ToastProduct *)product {

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

## 商品リスト照会

* IAPコンソールに登録されている商品のうち、使用設定がUSEの商品のリストを照会します。
* ストア(Apple)から商品情報を取得できなかった商品は、invalidProducts項目に表示されます。

### 商品リスト照会API仕様

``` objc
// 商品リスト照会
+ (void)requestProductsWithCompletionHandler:(nullable void (^)(ToastProductsResponse * _Nullable response, NSError * _Nullable error))completionHandler;
```

### 商品リスト照会API使用例

``` objc
[ToastIAP requestProductsWithCompletionHandler:^(ToastProductsResponse *response, NSError *error) {
    if (error == nil) {
        NSArray<ToastProduct *> *products = response.products;
        NSLog(@"Products : %@", products);

        // ストアから商品情報を取得できない
        NSArray<ToastProduct *> *invalidProducts = response.invalidProducts;
        NSLog(@"Invalid Products : %@", invalidProducts);

    } else {
        NSLog(@"Failed to request products: %@", error);
    }
}
```

### 商品の種類

| 상품명    | 상품타입             | 설명                                     |
| ------ | ---------------- | -------------------------------------- |
| 消費性商品 | ToastProductTypeConsumable     | 소비 가능한 일회성 상품입니다. <br/>게임내 재화, 코인, 반복 구입 가능한 상품등에 사용할 수 있습니다. |
| 自動更新型購読商品  | ToastProductTypeAutoRenewableSubscription | 지정된 간격 및 가격으로 결제가 자동으로 반복되는 상품입니다, <br>잡지, 음악 스트리밍 접근 허용, 광고 제거등에 사용할 수 있습니다. |
| 自動更新型消費性購読商品 | ToastProductTypeConsumableSubscription | 지정된 간격 및 가격으로 결제가 자동으로 반복되는 상품입니다. <br/>지정된 간격 및 가격으로 소비성 상품을 지급하고자 할 때 사용할 수 있습니다. | 

> `自動更新型購読商品のアップグレード、ダウングレード、修正機能は、サポートしていません。`
> `1つの購読グループに、1つの商品のみ登録する必要があります。`

``` objc
typedef NS_ENUM(NSInteger, ToastProductType) {
    // 商品種類取得失敗
    ToastProductTypeUnknown = 0,

    // 消費性商品
    ToastProductTypeConsumable = 1,

    // 自動更新型購読商品
    ToastProductTypeAutoRenewableSubscription = 2,

    // 自動更新型消費性購読商品
    ToastProductTypeConsumableSubscription = 3
};
```

## 商品購入

* 購入結果は、設定されたDelegateを通して伝達されます。
* 購買進行中にアプリが終了したり,ネットワークエラーなどで購買が中断された場合,次回のアプリ実行におけるIAP SDK初期化以後,再処理が進みます。
* 구매 요청시 사용자 데이터 추가가 가능합니다.
* 사용자 데이터는 결제 결과(구매 성공 Delegate, 미소비 결제 내역, 활성화된 구독, 구매 복원) 정보에 포함되어 반환됩니다.
* * 상품 목록 조회 결과의 ToastProduct 객체 혹은 상품 아이디를 이용해 구매를 요청합니다.

#### 商品オブジェクトを利用した購入API仕様

``` objc
// 商品購入
+ (void)purchaseWithProduct:(ToastProduct *)product;

// 사용자 데이터를 추가하여 상품 구매
+ (void)purchaseWithProduct:(ToastProduct *)product payload:(NSString *)payload;

// 商品IDを利用した購入要請
+ (void)purchaseWithProductIdentifier:(NSString *)productIdentifier;

// 사용자 데이터를 추가하여 상품 구매
+ (void)purchaseWithProductIdentifier:(NSString *)productIdentifier payload:(NSString *)payload;
@end
```

#### 商品オブジェクトを利用した購入API使用例

``` objc
// 商品購入要請
[ToastIAP purchaseWithProduct:self.products[0] payload:@"DEVELOPER_PAYLOAD"];

// or

// 商品IDを利用した購入要請
[ToastIAP purchaseWithProductIdentifier:@"PRODUCT_IDENTIFIER" payload:@"DEVELOPER_PAYLOAD"];
```

## 有効になっている購読リスト照会

* 현재 사용자 ID 기준으로 활성화된 구독 목록을 조회합니다.
* 결제가 완료된 구독 상품(자동 갱신형 구독, 자동 갱신형 소비성 구독 상품)은 만료되기 전까지 계속 조회할 수 있습니다. 
* 同じユーザーIDであれば、Androidで購入した購読商品も照会されます。

### 有効になっている購読リスト照会API仕様

``` objc
// 有効になっている購読リストを照会する
+ (void)requestActivePurchasesWithCompletionHandler:(nullable void (^)(NSArray<ToastPurchaseResult *> * _Nullable purchases, NSError * _Nullable error))completionHandler;
```

### 有効になっている購読リスト照会API使用例

``` objc
[ToastIAP requestActivePurchasesWithCompletionHandler:^(NSArray<ToastPurchaseResult *> *purchases, NSError *error) {
    if (error == nil) {
        for (ToastPurchaseResult *purchase in purchases) {
            // 購読商品アクセス有効化
        }

    } else {
        NSLog(@"Failed to request active purchases : %@", error);
    }
}];
```

## 購入復元

* 使用者のAppStoreアカウントで購入した内訳を基準に購買内訳を復元し,IAPコンソールに反映します。 
* 購買した購読商品が照会されないか,活性化しない場合に使います。
* 만료된 결제건을 포함하여 복원된 결제건이 결과로 반환됩니다.
* 자동 갱신형 소비성 구독 상품의 경우 반영되지 않은 구매 내역이 존재할 경우 복원 후 미소비 구매 내역에서 조회 가능합니다.

### 購入復元API仕様

``` objc
// 購入復元
+ (void)restoreWithCompletionHandler:(nullable void (^)(NSArray<ToastPurchaseResult *> * _Nullable purchases, NSError * _Nullable error))completionHandler;
@end
```

### 購入復元API使用例

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

## 未消費購入履歴照会

* 消費性商品の場合、商品支給後に消費(consume)処理を行う必要があります。
* 消費処理されていない購入履歴を照会します。
* 자동 갱신형 소비성 구독 상품은 갱신 결제가 발생할 때마다 미소비 구매 내역에서 조회 가능합니다.

### 未消費購入履歴照会API仕様

``` objc
// 未消費購入履歴照会
+ (void)requestConsumablePurchasesWithCompletionHandler:(nullable void (^)(NSArray<ToastPurchaseResult *> * _Nullable purchases, NSError * _Nullable error))completionHandler;
```

### 未消費購入履歴照会API使用例

``` objc
[ToastIAP requestConsumablePurchasesWithCompletionHandler:^(NSArray<ToastPurchaseResult *> *purchases, NSError *error) {
    if (error == nil) {
        NSLog(@"Consumable Purchases : %@", purchases);

    } else {
        NSLog(@"Failed to request consumable : %@", error);
    }
}
```

## 消費性商品の消費

* 消費性商品の場合、サービスに商品支給後にREST APIまたはSDKのConsume APIで消費処理を行う必要があります。

### 消費API仕様

``` objc
+ (void)consumeWithPurchaseResult:(ToastPurchaseResult *)result
                completionHandler:(nullable void (^)(NSError * _Nullable error))completionHandler;
```

### 消費API使用例

``` objc
// 未消費購入履歴照会
[ToastIAP requestConsumablePurchasesWithCompletionHandler:^(NSArray<ToastPurchaseResult *> *purchases, NSError *error) {
    if (error == nil) {
        for (ToastPurchaseResult *purchaseResult in purchases) {
            // 商品支給処理
            // ...

            // 商品支給後に消費処理
            [ToastIAP consumeWithPurchaseResult:purchaseResult
                              completionHandler:^(NSError *error) {
                                    if (error == nil) {
                                        NSLog(@"Successfully consumed");

                                    } else {
                                        NSLog(@"Failed to consume : %@", error);

                                        // 商品支給回数
                                        // ...
                                    }
                              }];
        }

    } else {
        NSLog(@"Failed to request consumable : %@", error);
    }
}
```

## 購読商品管理ページの提供方法

* 自動更新型購読商品を使用する場合、ユーザーに購読管理ページを提供する必要があります。
> [Apple Guide](https://developer.apple.com/library/archive/documentation/NetworkingInternet/Conceptual/StoreKitGuide/Chapters/Subscriptions.html#//apple_ref/doc/uid/TP40008267-CH7-SW19)

* 別途のUIを構成せず、下記URLを呼び出して購読管理ページを表示する必要があります。

### Safariで購読管理ページに接続する方法
```
https://buy.itunes.apple.com/WebObjects/MZFinance.woa/wa/manageSubscriptions
```
```objc
[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://buy.itunes.apple.com/WebObjects/MZFinance.woa/wa/manageSubscriptions"]];
```
#### Safariで管理ページを呼び出す時は、次のような順序で管理ページが表示されます。
1. Safariを開く
2. Popup表示：itunse Storeで開きますか？
3. iTunse Storeを開く
4. Popupで購読管理ページに接続

> iOS端末左上の、以前のアプリに戻るに`Safari`が表示されます。


### Schemeから購読管理ページに接続する方法
```
itms-apps://buy.itunes.apple.com/WebObjects/MZFinance.woa/wa/manageSubscriptions
```

```objc
[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://buy.itunes.apple.com/WebObjects/MZFinance.woa/wa/manageSubscriptions"]];
```
#### Schemeから管理ページを呼び出す時は、次のような順序で管理ページが表示されます。
1. App Storeの購読管理ページがApp To App呼び出しですぐに接続されます。

> iOS端末左上の、以前のアプリに戻るに`Service App`が表示されます。



## (旧)IAP SDK互換性維持

* (旧)IAP SDKとの互換性を維持できるように、(旧)IAP SDKで作成された未完了購入の件の再処理機能を提供します。
* (旧)IAP SDKとの互換性維持機能を使用するには、`sqlite3 Library(libsqlite3.tdb)`を追加で接続(link)する必要があります。
![linked_sqlite3](http://static.toastoven.net/toastcloud/sdk/ios/iap_link_sqlite3.png)

### 未完了購入再処理API仕様

``` objc
+ (void)processesIncompletePurchasesWithCompletionHandler:(nullable void (^)(NSArray <ToastPurchaseResult *> * _Nullable results, NSError * _Nullable error))completionHandler;
```

### 未完了購入再処理API使用例

``` objc
// 未完了購入再処理要請
[ToastIAP processesIncompletePurchasesWithCompletionHandler:^(NSArray<ToastPurchaseResult *> *results, NSError *error) {
    if (error == nil) {
        for (ToastPurchaseResult *purchaseResult in results) {
            // 商品支給処理
            // ...

            // 商品支給後、消費処理
            [ToastIAP consumeWithPurchaseResult:purchaseResult
                              completionHandler:^(NSError *error) {
                                    if (error == nil) {
                                        NSLog(@"Successfully consumed");

                                    } else {
                                        NSLog(@"Failed to consume : %@", error);

                                        // 商品支給回数
                                        // ...
                                    }
                              }];
        }

    } else {
        NSLog(@"Failed to process incomplete purchases : %@", error);
    }
}];
```

### エラーコード
```objc
// IAP エラーコード
static NSString *const ToastIAPErrorDomain = @"com.toast.iap";

typedef NS_ENUM(NSUInteger, ToastIAPErrorCode) {
    ToastIAPErrorUnknown = 0,                       // 不明
    ToastIAPErrorNotInitialized = 1,                // 初期化しない
    ToastIAPErrorStoreNotAvailable = 2,             // ストア使用不可
    ToastIAPErrorProductNotAvailable = 3,           // 商品情報取得に失敗
    ToastIAPErrorProductInvalid = 4,                // 元決済の商品IDと現在の商品IDが不一致
    ToastIAPErrorAlreadyOwned = 5,                  // すでに所有している商品
    ToastIAPErrorAlreadyInProgress = 6,             // すでに進行中の要請あり
    ToastIAPErrorUserInvalid = 7,                   // 現在のユーザーIDが決済ユーザーIDと不一致
    ToastIAPErrorPaymentInvalid = 8,                // 決済追加情報(ApplicationUsername)取得失敗
    ToastIAPErrorPaymentCancelled = 9,              // ストア決済キャンセル
    ToastIAPErrorPaymentFailed = 10,                // ストア決済失敗
    ToastIAPErrorVerifyFailed = 11,                 // 領収書検証失敗
    ToastIAPErrorChangePurchaseStatusFailed = 12,   // 購入状態変更失敗
    ToastIAPErrorPurchaseStatusInvalid = 13,        // 購入進行不可状態
    ToastIAPErrorExpired = 14,                      // 購読満了
    ToastIAPErrorRenewalPaymentNotFound = 15,       // 領収書内に更新決済と一致する決済情報がない
    ToastIAPErrorRestoreFailed = 16,                // 復元に失敗しました
};

// Network エラーコード
static NSString *const ToastHttpErrorDomain = @"com.toast.http";

typedef NS_ENUM(NSUInteger, ToastHttpErrorCode) {
    ToastHttpErrorNetworkNotAvailable = 100,        // ネットワーク使用不可
    ToastHttpErrorRequestFailed = 101,              // HTTP ステータス コードが 200 でないか,要求を読み取れない
    ToastHttpErrorRequestTimeout = 102,             // タイムアウト
    ToastHttpErrorRequestInvalid = 103,             // 要請の誤り
    ToastHttpErrorURLInvalid = 104,                 // URLの誤り
    ToastHttpErrorResponseInvalid = 105,            // 応答の誤り
    ToastHttpErrorAlreadyInprogress = 106,          // 要請がすで進行中
    ToastHttpErrorRequiresSecureConnection = 107,   // Allow Arbitrary Loadsを設定しない
};
```
