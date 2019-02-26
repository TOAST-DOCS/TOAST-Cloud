## TOAST > TOAST SDK使用ガイド > TOAST IAP > iOS

## Prerequisites

1\. [TOAST SDK](./getting-started-ios)をインストールします。
2\. [TOASTコンソール](https://console.cloud.toast.com)で[Mobile Service \> IAPを有効化](https://docs.toast.com/ko/Mobile%20Service/IAP/ko/console-guide/)します。
3\. IAPで[AppKeyを確認](https://docs.toast.com/ko/Mobile%20Service/IAP/ko/console-guide/#appkey)します。

## TOAST IAP構成

iOS用TOAST IAP SDKの構成は次のとおりです。

| Service  | Cocoapods Pod Name | Framework | Dependency | Build Settings |
| --- | --- | --- | --- | --- |
| TOAST IAP | ToastIAP | ToastIAP.framework | * StoreKit.framework<br/><br/>[Optional]<br/> * libsqlite3.tdb | |
| Mandatory   | ToastCore<br/>ToastCommon | ToastCore.framework<br/>ToastCommon.framework | | OTHER_LDFLAGS = (<br/>    "-ObjC",<br/>    "-lc++" <br/>); |


## TOAST IAP SDKをXcodeプロジェクトに適用

### 1. Cococapods適用

Podfileを作成して、TOAST SDKに対するPodを追加します。

```podspec
platform :ios, '8.0'
use_frameworks!

target '{YOUR PROJECT TARGET NAME}' do
    pod 'ToastIAP'
end
```

作成されたWorkspaceを開き、使用するSDKをインポートします(import)。

```objc
#import <ToastCore/ToastCore.h>
#import <ToastIAP/ToastIAP.h>
```

### 2. バイナリをダウンロードしてTOAST SDKを適用

#### SDKをインポート(import)

TOASTの[Downloads](../../../Download/#toast-sdk)ページで全体iOS SDKをダウンロードできます。

Xcode Projectに**ToastIAP.framework**, **ToastCore.framework**, **ToastCommon.framework**, `StoreKit.framework`を追加します。

> StoreKit.frameworkは、下記の方法で追加できます。

![linked_storekit_frameworks](http://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_StoreKit.png)

![linked_frameworks_iap](http://static.toastoven.net/toastcloud/sdk/ios/iap_link_frameworks_iap.png)

#### Project Settings

**Build Settings**の**Other Linker Flags**に**-lc++**と**-ObjC**項目を追加します。

**Project Target > Build Settings > Linking > Other Linker Flags**をクリックして追加できます。

![other_linker_flags](http://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags.png)

#### フレームワークをインポート

使用するフレームワークをインポートします(import)。

```objc
#import <ToastCore/ToastCore.h>
#import <ToastIAP/ToastIAP.h>
```
## Capabilities Setting

TOAST IAPを使用するには、CapabilitiesでIn-App Purchase項目を有効にする必要があります。

**Project Target > Capabilities > In-App Purchase > ON**

![capabilities_iap](http://static.toastoven.net/toastcloud/sdk/ios/capability_iap.png)

## サービスログイン

* TOAST SDKで提供するすべてのサービス(IAP、Log & Crash、Pushなど)は、同じユーザーID1つのみ使用します。

### ログイン

`ユーザーIDが設定されていない状態では、購入、有効になっている商品照会、未消費履歴照会機能を使用できません。`

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

TOAST IAPで発行されたAppKeyを設定します。
初期化と同時に未完了購入の件に対する再処理が行われます。
したがって、円滑に再処理を行うには、必ずユーザーIDを設定した後に初期化してください。
再処理を含むすべての購入結果は、Delegateを通して伝達さるため、Delegate設定後に初期化するか、初期化の際にDelegateを設定することを推奨します。

``` objc
ToastIAPConfiguration *configuration = [ToastIAPConfiguration configurationWithAppKey:@"INPUT_YOUE_APPKEY"];

[ToastIAP initWithConfiguration:configuration delegate:self];
```

### 初期化API仕様

``` objc
@interface ToastIAP : NSObject

// 初期化
+ (void)initWithConfiguration:(ToastIAPConfiguration *)configuration;

// Delegate設定
+ (void)setDelegate:(nullable id<ToastInAppPurchaseDelegate>)delegate;

// 初期化およびDelegate設定
+ (void)initWithConfiguration:(ToastIAPConfiguration *)configuration
                     delegate:(nullable id<ToastInAppPurchaseDelegate>)delegate;

// ...

@end
```

### Delegate API仕様

Delegateを登録すると、購入後に追加作業を進行できます。

``` objc
@protocol ToastInAppPurchaseDelegate <NSObject>

// 購入成功
- (void)didReceivePurchaseResult:(ToastPurchaseResult *)purchase;

// 購入失敗
- (void)didFailPurchaseProduct:(NSString *)productIdentifier withError:(NSError *)error;

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

@end
```

## 商品リスト照会

IAPコンソールに登録されている商品のうち、使用設定がUSEの商品のリストを照会します。
ストア(Apple)から商品情報を取得できなかった商品は、invalidProducts項目に表示されます。

### 商品リスト照会API仕様

``` objc
@interface ToastIAP : NSObject

// ...

// 商品リスト照会
+ (void)requestProductsWithCompletionHandler:(nullable void (^)(ToastProductsResponse * _Nullable response, NSError * _Nullable error))completionHandler;

// ...

@end
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

`自動更新型購読商品のアップグレード、ダウングレード、修正機能は、サポートしていません。`
1つの購読グループに、1つの商品のみ登録する必要があります。

``` objc
// 商品種類取得失敗
ToastProductTypeUnknown = 0

// 消費性商品
ToastProductTypeConsumable = 1

// 自動更新型購読商品
ToastProductTypeAutoRenewableSubscription = 2
```

## 商品購入

購入結果は、設定されたDelegateを通して伝達されます。
購入進行中にアプリが終了したり、ネットワークエラーなどで購入が中断された場合、アプリが再起動されるとIAP SDKを初期化する時に購入の再処理を行います。

### 商品オブジェクトを利用した購入要請

商品リスト照会結果のToastProductオブジェクトを利用して購入を要請します。

#### 商品オブジェクトを利用した購入API仕様

``` objc
@interface ToastIAP : NSObject

// ...

// 商品購入
+ (void)purchaseWithProduct:(ToastProduct *)product;

// ...

@end
```

#### 商品オブジェクトを利用した購入API使用例

``` objc
@property (nonatomic) NSArray <ToastProduct *> *products;

// 商品リスト照会
[ToastIAP requestProductsWithCompletionHandler:^(ToastProductsResponse *response, NSError *error) {

    if (error == nil) {
        // 購入可能な商品リスト保存
        self.products = response.products;

    } else {
        NSLog(@"Failed to request products: %@", error);
    }
}

// 商品購入要請
[ToastIAP purchaseWithProduct:self.products[0]];
```

### 商品IDを利用した購入要請

サービスで別途に商品リストを管理している場合、商品IDのみを利用して購入を要請します。
購入できない商品の場合、Delegateを通して購入不可商品であることを表すエラーが伝達されます。

#### 商品IDを利用した購入API仕様

``` objc
@interface ToastIAP (Additional)

// ...

// 商品購入
+ (void)purchaseWithProductIdentifier:(NSString *)productIdentifier;

// ...

@end
```

#### 商品IDを利用した購入API使用例

``` objc
// 商品購入要請
[ToastIAP purchaseWithProductIdentifier:@"PRODUCT_IDENTIFIER"];
```

## 有効になっている購入リスト照会

現在のユーザーIDにおいて、有効になっている購入(満了しておらず、購読中の購読商品)リストを照会します。
同じユーザーIDであれば、Androidで購入した購読商品も照会されます。

### 有効になっている購入リスト照会API仕様

``` objc
@interface ToastIAP : NSObject

// ...

// 有効になっている購入リストを照会する
+ (void)requestActivePurchasesWithCompletionHandler:(nullable void (^)(NSArray<ToastPurchaseResult *> * _Nullable purchases, NSError * _Nullable error))completionHandler;

// ...

@end
```

### 有効になっている購入リスト照会API使用例

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

現在のユーザーIDで購入した項目のうち、復元可能な購入リストを照会します。

### 購入復元API仕様

``` objc
@interface ToastIAP : NSObject

// ...

// 購入復元
+ (void)restoreWithCompletionHandler:(nullable void (^)(NSArray<ToastPurchaseResult *> * _Nullable purchases, NSError * _Nullable error))completionHandler;

// ...

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

消費性商品の場合、商品支給後に消費(consume)処理を行う必要があります。
消費処理されていない購入履歴を照会します。

### 未消費購入履歴照会API仕様

``` objc
@interface ToastIAP : NSObject

// ...

// 未消費購入履歴照会
+ (void)requestConsumablePurchasesWithCompletionHandler:(nullable void (^)(NSArray<ToastPurchaseResult *> * _Nullable purchases, NSError * _Nullable error))completionHandler;

// ...

@end
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

消費性商品の場合、サービスに商品支給後にREST APIまたはSDKのConsume APIで消費処理を行う必要があります。

### 消費API仕様

``` objc
@interface ToastIAP (Additional)

// ...

+ (void)consumeWithPurchaseResult:(ToastPurchaseResult *)result
                completionHandler:(nullable void (^)(NSError * _Nullable error))completionHandler;

// ...

@end
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

自動更新型購読商品を使用する場合、ユーザーに購読管理ページを提供する必要があります。
> [Apple Guide](https://developer.apple.com/library/archive/documentation/NetworkingInternet/Conceptual/StoreKitGuide/Chapters/Subscriptions.html#//apple_ref/doc/uid/TP40008267-CH7-SW19)

別途のUIを構成せず、下記URLを呼び出して購読管理ページを表示する必要があります。
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

(旧)IAP SDKとの互換性を維持できるように、(旧)IAP SDKで作成された未完了購入の件の再処理機能を提供します。
>(旧)IAP SDKとの互換性維持機能を使用するには、`sqlite3 Library(libsqlite3.tdb)`を追加で接続(link)する必要があります。

![linked_sqlite3](http://static.toastoven.net/toastcloud/sdk/ios/iap_link_sqlite3.png)

### 未完了購入再処理API仕様

``` objc
@interface ToastIAP (Additional)

// ...

+ (void)processesIncompletePurchasesWithCompletionHandler:(nullable void (^)(NSArray <ToastPurchaseResult *> * _Nullable results, NSError * _Nullable error))completionHandler;

// ...

@end
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

    ToastIAPErrorNetworkNotAvailable = 100,         // ネットワーク使用不可
    ToastIAPErrorNetworkFailed = 101,               // HTTP Status Codeが200ではない
    ToastIAPErrorTimeout = 102,                     // タイムアウト
    ToastIAPErrorParameterInvalid = 103,            // 要請パラメータエラー
    ToastIAPErrorResponseInvalid = 104,             // サーバーレスポンスエラー
};
```
