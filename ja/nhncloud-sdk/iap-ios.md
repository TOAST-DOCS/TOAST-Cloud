## NHN Cloud > SDK使用ガイド > IAP > iOS

## Prerequisites

1\. [NHN Cloud SDK](./getting-started-ios)をインストールします。
2\. [NHN Cloudコンソール](https://console.nhncloud.com)で[Mobile Service \> IAPを有効化](https://docs.nhncloud.com/ja/Mobile%20Service/IAP/ja/console-guide/)します。
3\. IAPで[AppKeyを確認](https://docs.nhncloud.com/ja/Mobile%20Service/IAP/ja/console-guide/#appkey)します。

## NHN Cloud IAP構成

* iOS用NHN Cloud IAP SDKの構成は次のとおりです。

| Service  | Cocoapods Pod Name | Framework | Dependency | Build Settings |
| --- | --- | --- | --- | --- |
| IAP | NHNCloudIAP | NHNCloudIAP.framework | * StoreKit.framework<br/><br/>[Optional]<br/> * libsqlite3.tdb | |
| Mandatory   | NHNCloudCore<br/>NHNCloudCommon | NHNCloudCore.framework<br/>NHNCloudCommon.framework | | OTHER_LDFLAGS = (<br/>    "-ObjC",<br/>    "-lc++" <br/>); |


## NHN Cloud IAP SDKをXcodeプロジェクトに適用

### 1. Cococapods適用

* Podfileを作成して、NHN Cloud SDKに対するPodを追加します。

```podspec
platform :ios, '11.0'
use_frameworks!

target '{YOUR PROJECT TARGET NAME}' do
    pod 'NHNCloudIAP'
end
```

### 2. Swift Package Managerを使用してNHN Cloud SDK適用

* XCodeで**File > Add Packages...**メニューを選択します。
* Package URLに'https://github.com/nhn/nhncloud.ios.sdk'を入れて**Add Package**ボタンを選択します。
* NHNCloudIAPを選択します。

![swift_package_manager](https://static.toastoven.net/toastcloud/sdk/ios/swiftpackagemanager01.png)

#### プロジェクト設定

* **Build Settings**の **Other Linker Flags**に**-lc++**と**-ObjC**項目を追加します。
    * **Project Target > Build Settings > Linking > Other Linker Flags**
![other_linker_flags](https://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags_202206.png)

### 3. バイナリをダウンロードしてNHN Cloud SDKを適用

#### Link Frameworks

* NHN Cloudの[Downloads](../../../Download/#toast-sdk)ページで全体iOS SDKをダウンロードできます。
* Xcode Projectに**NHNCloudIAP.framework**, **NHNCloudCore.framework**, **NHNCloudCommon.framework, StoreKit.framework**を追加します。
* StoreKit.frameworkは、下記の方法で追加できます。
![linked_storekit_frameworks](https://static.toastoven.net/toastcloud/sdk/ios/overview_link_frameworks_StoreKit_202206.png)

![linked_frameworks_iap](https://static.toastoven.net/toastcloud/sdk/ios/iap_link_frameworks_iap_202206.png)

#### プロジェクト設定

* **Build Settings**の**Other Linker Flags**に**-lc++**と**-ObjC**項目を追加します。
    * **Project Target > Build Settings > Linking > Other Linker Flags**
![other_linker_flags](https://static.toastoven.net/toastcloud/sdk/ios/overview_settings_flags_202206.png)


### Capabilities設定

* NHN Cloud IAPを使用するには、Capabilitiesで**In-App Purchase**項目を有効にする必要があります。
    * **Project Target > Capabilities > In-App Purchase**
![capabilities_iap](https://static.toastoven.net/toastcloud/sdk/ios/capability_iap_202206.png)

## サービスログイン

* NHN Cloud SDKで提供するすべてのサービス(IAP、Log & Crash、Pushなど)は、同じユーザーID1つのみ使用します。

### ログイン

* `ユーザーIDが設定されていない状態では、購入、有効になっている商品照会、未消費履歴照会機能を使用できません。`

``` objc
// サービスログイン完了後、ユーザーID設定
[NHNCloudSDK setUserID:@"INPUT_USER_ID"];
```

### ログアウト

``` objc
// サービスログアウト完了後、ユーザーIDをnilに設定
[NHNCloudSDK setUserID:nil];
```

## NHN Cloud IAP SDK初期化

* IAPコンソールで発行された[AppKey](https://docs.nhncloud.com/ja/Mobile%20Service/IAP/ja/console-guide/#appkey)を[NHNCloudIAPConfiguration](./iap-ios/#nhncloudiapconfiguration)オブジェクトに設定します。
* NHN Cloud IAPは初期化に[NHNCloudIAPConfiguration](./iap-ios/#nhncloudiapconfiguration)オブジェクトをパラメータとして使用します。

### 初期化API仕様

``` objc
// 初期化
+ (void)initWithConfiguration:(NHNCloudIAPConfiguration *)configuration;
// Delegate設定
+ (void)setDelegate:(nullable id<NHNCloudInAppPurchaseDelegate>)delegate;
// 初期化およびDelegate設定
+ (void)initWithConfiguration:(NHNCloudIAPConfiguration *)configuration
                     delegate:(nullable id<NHNCloudInAppPurchaseDelegate>)delegate;
```

### Delegate API仕様

* [NHNCloudInAppPurchaseDelegate](./iap-ios/#nhncloudinapppurchasedelegate)を登録すると、購入結果とプロモーション決済を進行するかどうかの決定についての通知を受信できます。
    * プロモーション決済をSDKで行うか、ユーザーが任意の時点で直接決済をリクエストするかを決定できます。
* 再処理により決済が完了した購買件は、Delegatingされず、未消費商品リスト(消耗性商品)、活性化された購読リスト(購読商品)に反映されます。
* `決済結果に対する通知を受けるためには、商品購入前にDelegateが設定されていなければなりません。`


``` objc
@protocol NHNCloudInAppPurchaseDelegate <NSObject>

// 購入成功
- (void)didReceivePurchaseResult:(NHNCloudPurchaseResult *)purchase;
// 購入失敗
- (void)didFailPurchaseProduct:(NSString *)productIdentifier withError:(NSError *)error;

@optional
// プロモーション決済進行方法の選択
- (BOOL)shouldAddStorePurchaseForProduct:(NHNCloudProduct *)product API_AVAILABLE(ios(11.0));
@end
```

### 初期化プロセス例

``` objc
#import <UIKit/UIKit.h>
#import <NHNCloudIAP/NHNCloudIAP.h>

@interface ViewController () <NHNCloudInAppPurchaseDelegate>
@end

@implementation ViewController

- (void)initializeNHNCloudIAP {
    // 初期化およびDelegate設定
    NHNCloudIAPConfiguration *configuration = [NHNCloudIAPConfiguration configurationWithAppKey:@"INPUT_YOUE_APPKEY"];

    [NHNCloudIAP initWithConfiguration:configuration delegate:self];
}

// 購入成功
- (void)didReceivePurchaseResult:(NHNCloudPurchaseResult *)purchase {
    NSLog(@"Successfully purchased");
}

// 購入失敗
- (void)didFailPurchaseProduct:(NSString *)productIdentifier withError:(NSError *)error {
    NSLog(@"Failed to purchase: %@", error);
}

// プロモーション決済進行方法の選択
- (BOOL)shouldAddStorePurchaseForProduct:(NHNCloudProduct *)product {
    /*
    * return YES;
        * リクエストしたプロモーション決済をSDKで行うようにします。
        * 初期化およびログイン後に決済ウィンドウが表示されます。
    */
    return YES;

    /*
    * return NO;
        * プロモーション決済が終了します。
        * productオブジェクトを保存した後、任意の時点で保存されたオブジェクトで決済を行うことができます。
    */
    self.promotionProduct = product;
    return NO;
}

@end
```

## 商品リスト照会

* IAPコンソールに登録された商品が[NHNCloudProductResponse](./iap-ios/#nhncloudproductresponse)オブジェクトで返されます。
* IAPコンソールに登録された商品のうち、購入可能な商品はproducts([NHNCloudProduct](./iap-ios/#nhncloudproduct))として返されます。
* IAPコンソールに登録された商品のうち、ストア(Apple)で商品情報を取得できなかった商品は、invalidProducts([NHNCloudProduct](./iap-ios/#nhncloudproduct))として返されます。

### 商品リスト照会API仕様

``` objc
+ (void)requestProductsWithCompletionHandler:(nullable void (^)(NHNCloudProductsResponse * _Nullable response, NSError * _Nullable error))completionHandler;
```

### 商品リスト照会API使用例

``` objc
[NHNCloudIAP requestProductsWithCompletionHandler:^(NHNCloudProductsResponse *response, NSError *error) {
    if (error == nil) {
        NSArray<NHNCloudProduct *> *products = response.products;
        NSLog(@"Products : %@", products);

        // ストアから商品情報を取得できない
        NSArray<NHNCloudProduct *> *invalidProducts = response.invalidProducts;
        NSLog(@"Invalid Products : %@", invalidProducts);

    } else {
        NSLog(@"Failed to request products: %@", error);
    }
}
```

### 商品の種類

| 商品名 | 商品タイプ        | 説明                                |
| ------ | ---------------- | -------------------------------------- |
| 消費性商品 | NHNCloudProductTypeConsumable     | 消費可能な1回限りの商品です。 <br/>ゲーム内通貨、コイン、繰り返し購入可能な商品などに使用できます。 |
| 自動更新型サブスクリプション商品 | NHNCloudProductTypeAutoRenewableSubscription | 指定された間隔と価格で決済が自動的に繰り返される商品です。<br>雑誌、音楽のストリーミングアクセス許可、広告の除去などに使用できます。 |
| 自動更新型消費性サブスクリプション商品 | NHNCloudProductTypeConsumableSubscription | 指定された間隔と価格で決済が自動的に繰り返される商品です。 <br/>指定された間隔と価格で消費性商品を支給したい時に使用できます。 |

> `自動更新型購読商品のアップグレード、ダウングレード、修正機能は、サポートしていません。`
> `1つの購読グループに、1つの商品のみ登録する必要があります。`


``` objc
typedef NS_ENUM(NSInteger, NHNCloudProductType) {
    // 商品種類取得失敗
    NHNCloudProductTypeUnknown = 0,
    // 消費性商品
    NHNCloudProductTypeConsumable = 1,
    // 自動更新型購読商品
    NHNCloudProductTypeAutoRenewableSubscription = 2,
    // 自動更新型消費性購読商品
    NHNCloudProductTypeConsumableSubscription = 3
};
```

## 商品購入

* 購入結果は、設定された[NHNCloudInAppPurchaseDelegate](./iap-ios/#nhncloudinapppurchasedelegate)を通して伝達されます。
* 購買進行中にアプリが終了したり、ネットワークエラーなどで購買が中断された場合、次回のアプリ実行におけるIAP SDK初期化以後、再処理が進みます。
* 購入リクエスト時にユーザーデータを追加できます。
* ユーザーデータは決済結果(購入成功Delegate、未消費決済履歴、有効なサブスクリプション、購入復元)情報に含まれて返されます。
* 購入できない商品の場合、[NHNCloudInAppPurchaseDelegate](./iap-ios/#nhncloudinapppurchasedelegate)を通して購入不可商品であることを示すエラーが伝達されます。
* 商品リスト照会結果のNHNCloudProductオブジェクトまたは商品IDを利用して購入をリクエストします。

#### 商品オブジェクトを利用した購入API仕様

``` objc
// 商品購入要請
+ (void)purchaseWithProduct:(NHNCloudProduct *)product;
// ユーザーデータを追加して商品購入
+ (void)purchaseWithProduct:(NHNCloudProduct *)product payload:(NSString *)payload;
// 商品IDを利用した購入要請
+ (void)purchaseWithProductIdentifier:(NSString *)productIdentifier;
// 商品IDで購入リクエストした時、ユーザーデータ追加
+ (void)purchaseWithProductIdentifier:(NSString *)productIdentifier payload:(NSString *)payload;
```

#### 商品オブジェクトを利用した購入API使用例

``` objc
// 商品購入要請
[NHNCloudIAP purchaseWithProduct:self.products[0] payload:@"DEVELOPER_PAYLOAD"];
// or
// 商品IDを利用した購入要請
[NHNCloudIAP purchaseWithProductIdentifier:@"PRODUCT_IDENTIFIER" payload:@"DEVELOPER_PAYLOAD"];
```

## 有効になっている購読リスト照会

* 現在のユーザーIDで有効なサブスクリプションリストを照会します。
* 決済が完了したサブスクリプション商品(自動更新型サブスクリプション、自動更新型消費性サブスクリプション商品)は有効期限が切れるまで照会できます。
* 同じユーザーIDであれば、Androidで購入した購読商品も照会されます。

### 有効になっている購読リスト照会API仕様

``` objc
// 有効になっているAppStore購読リストを照会する
+ (void)requestActiveSubscriptionsWithCompletionHandler:(nullable void (^)(NSArray<NHNCloudPurchaseResult *> * _Nullable purchases, NSError * _Nullable error))completionHandler;

// 有効になっているすべてのマーケット(AppStore、Googleプレイ、ONEstoreなど)購読リストを照会する
+ (void)requestAllMarketsActiveSubscriptionsWithCompletionHandler:(nullable void (^)(NSArray<NHNCloudPurchaseResult *> * _Nullable purchases, NSError * _Nullable error))completionHandler;
```

### 有効になっている購読リスト照会API使用例

``` objc
[NHNCloudIAP requestActiveSubscriptionsWithCompletionHandler:^(NSArray<NHNCloudPurchaseResult *> *purchases, NSError *error) {
    if (error == nil) {
        for (NHNCloudPurchaseResult *purchase in purchases) {
            // 購読商品アクセス有効化
        }
    } else {
        NSLog(@"Failed to request active purchases : %@", error);
    }
}];
```

## 購入復元

* 使用者のAppStoreアカウントで購入した内訳を基準に購買内訳を復元し、IAPコンソールに反映します。
* 購買した購読商品が照会されないか、活性化しない場合に使います。
* 有効期限が切れた決済を含めて復元された決済が[NHNCloudPurchaseResult](./iap-ios/#nhncloudpurchaseresult)オブジェクトで返されます。
* 自動更新型消費性サブスクリプション商品の場合、反映されていない購入履歴が存在する場合は復元後に未消費購入履歴から照会が可能です。

### 購入復元API仕様

``` objc
// 購入復元
+ (void)restoreWithCompletionHandler:(nullable void (^)(NSArray<NHNCloudPurchaseResult *> * _Nullable purchases, NSError * _Nullable error))completionHandler;
```

### 購入復元API使用例

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

## 未消費購入履歴照会

* 消費性商品の場合、商品支給後に消費(consume)処理を行う必要があります。
* 消費処理されていない購入履歴が[NHNCloudPurchaseResult](./iap-ios/#nhncloudpurchaseresult)オブジェクトで返されます。
* 自動更新型消費性サブスクリプション商品は、更新決済が発生するたびに未消費購入履歴から照会できます。

### 未消費購入履歴照会API仕様

``` objc
// AppStore未消費購入履歴照会
+ (void)requestConsumablePurchasesWithCompletionHandler:(nullable void (^)(NSArray<NHNCloudPurchaseResult *> * _Nullable purchases, NSError * _Nullable error))completionHandler;

// すべてのマーケット(AppStore、Googleプレイ、ONEstoreなど)の未消費購入履歴の照会
+ (void)requestAllMarketsConsumablePurchasesWithCompletionHandler:(nullable void (^)(NSArray<NHNCloudPurchaseResult *> * _Nullable purchases, NSError * _Nullable error))completionHandler;
```

### 未消費購入履歴照会API使用例

``` objc
[NHNCloudIAP requestConsumablePurchasesWithCompletionHandler:^(NSArray<NHNCloudPurchaseResult *> *purchases, NSError *error) {
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
+ (void)consumeWithPurchaseResult:(NHNCloudPurchaseResult *)result
                completionHandler:(nullable void (^)(NSError * _Nullable error))completionHandler;
```

### 消費API使用例

``` objc
// 未消費購入履歴照会
[NHNCloudIAP requestConsumablePurchasesWithCompletionHandler:^(NSArray<NHNCloudPurchaseResult *> *purchases, NSError *error) {
    if (error == nil) {
        for (NHNCloudPurchaseResult *purchaseResult in purchases) {
            // 商品支給処理
            // ...

            // 商品支給後に消費処理
            [NHNCloudIAP consumeWithPurchaseResult:purchaseResult
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

## サブスクリプション商品管理ページの提供方法

* 自動更新型サブスクリプション商品を使用する場合、ユーザーに購読管理ページを提供する必要があります。
> [Apple Guide](https://developer.apple.com/documentation/storekit/in-app_purchase/original_api_for_in-app_purchase/subscriptions_and_offers/handling_subscriptions_billing?language=objc)

* 別途のUIを構成せず、以下のURLを呼び出して購読管理ページを表示する必要があります。

```
https://apps.apple.com/account/subscriptions
itms-apps://buy.itunes.apple.com/WebObjects/MZFinance.woa/wa/manageSubscription
```

### 購読管理ページへのアクセス方法

```objc
[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://apps.apple.com/account/subscriptions"] options: @{} completionHandler:nil];
```

または

```objc
[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://buy.itunes.apple.com/WebObjects/MZFinance.woa/wa/manageSubscriptions"] options: @{} completionHandler:nil];
```

App Storeの購読管理ページに移動します。

> iOS端末の左上の以前のアプリに戻ると`Service App`が表示されます。

## (旧)IAP SDK互換性維持

* (旧)IAP SDKとの互換性を維持できるように、(旧)IAP SDKで作成された未完了購入の件の再処理機能を提供します。
* (旧)IAP SDKとの互換性維持機能を使用するには、`sqlite3 Library(libsqlite3.tdb)`を追加で接続(link)する必要があります。
![linked_sqlite3](https://static.toastoven.net/toastcloud/sdk/ios/iap_link_sqlite3_202206.png)

### 未完了購入再処理API仕様

``` objc
+ (void)processesIncompletePurchasesWithCompletionHandler:(nullable void (^)(NSArray <NHNCloudPurchaseResult *> * _Nullable results, NSError * _Nullable error))completionHandler;
```

### 未完了購入再処理API使用例

``` objc
// 未完了購入再処理要請
[NHNCloudIAP processesIncompletePurchasesWithCompletionHandler:^(NSArray<NHNCloudPurchaseResult *> *results, NSError *error) {
    if (error == nil) {
        for (NHNCloudPurchaseResult *purchaseResult in results) {
            // 商品支給処理
            // ...

            // 商品支給後、消費処理
            [NHNCloudIAP consumeWithPurchaseResult:purchaseResult
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


## NHN Cloud IAP Class Reference

### NHNCloudIAPConfiguration

NHN Cloud IAP初期化メソッドのパラメータとして使用されるアプリ内決済設定情報です。

```objc
@interface NHNCloudIAPConfiguration : NSObject <NSCoding, NSCopying>

// IAPサービスアプリキー
@property (nonatomic, copy, readonly) NSString *appKey;
// サービスゾーン
@property (nonatomic) NHNCloudServiceZone serviceZone;

+ (instancetype)configurationWithAppKey:(NSString *)appKey;

- (instancetype)initWithAppKey:(NSString *)appKey
NS_SWIFT_NAME(init(appKey:));

@end
```

## NHNCloudInAppPurchaseDelegate

決済結果の通知を受け取り、プロモーション決済の実行方式を設定できます。

```objc
@protocol NHNCloudInAppPurchaseDelegate <NSObject>

// 決済成功
- (void)didReceivePurchaseResult:(NHNCloudPurchaseResult *)purchase
NS_SWIFT_NAME(didReceivePurchase(purchase:));

// 決済失敗
- (void)didFailPurchaseProduct:(NSString *)productIdentifier withError:(NSError *)error
NS_SWIFT_NAME(didFailPurchase(productIdentifier:error:));

@optional
// プロモーション決済進行方法の選択
- (BOOL)shouldAddStorePurchaseForProduct:(NHNCloudProduct *)product API_AVAILABLE(ios(11.0));

@end
```

## NHNCloudProductResponse

商品リスト情報を確認できます。

```objc
@interface NHNCloudProductsResponse : NSObject <NSCoding, NSCopying>

// IAPコンソールとストア(Apple)に登録されている決済に使用することができる商品リスト
@property (nonatomic, copy, readonly) NSArray<NHNCloudProduct *> *products;
// ストア(Apple)で商品情報を取得できなかった商品リスト
@property (nonatomic, copy, readonly) NSArray<NHNCloudProduct *> *invalidProducts;

@end
```

## NHNCloudProduct

NHN Cloud IAPコンソールに登録された商品の情報を確認できます。

```objc
@interface NHNCloudProduct : NSObject <NSCoding, NSCopying>

// 商品のID
@property (nonatomic, copy, readonly) NSString *productIdentifier;
// 商品固有番号
@property (nonatomic, readonly) long productSeq;
// 商品名(IAP Console)
@property (nonatomic, copy, readonly, nullable) NSString *productName;
// 商品タイプ
@property (nonatomic, readonly) NHNCloudProductType productType;
// 価格
@property (nonatomic, copy, readonly, nullable) NSDecimalNumber *price;
// 通貨
@property (nonatomic, copy, readonly, nullable) NSString *currency;
// 現地の商品名(AppStoreConnect)
@property (nonatomic, copy, readonly, nullable) NSString *localizedTitle;
// 現地の商品説明(AppStoreConnect)
@property (nonatomic, copy, readonly, nullable) NSString *localizedDescription;
// 現地価格
@property (nonatomic, copy, readonly, nullable) NSString *localizedPrice;
// 商品有効化状況
@property (nonatomic, readonly, getter=isActive) BOOL active;
// ストアコード"AS"
@property (nonatomic, copy, readonly) NSString *storeCode;

@end
```

## NHNCloudPurchaseResult

決済情報を確認できます。

```objc
@interface NHNCloudPurchaseResult : NSObject <NSCoding, NSCopying>

// ユーザーID
@property (nonatomic, copy, readonly) NSString *userID;
// ストアコード"AS"
@property (nonatomic, copy, readonly) NSString *storeCode;
// 商品のID
@property (nonatomic, copy, readonly) NSString *productIdentifier;
// 商品固有番号
@property (nonatomic, readonly) long productSeq;
// 商品タイプ
@property (nonatomic, readonly) NHNCloudProductType productType;
// 価格
@property (nonatomic, copy, readonly) NSDecimalNumber *price;
// 通貨
@property (nonatomic, copy, readonly) NSString *currency;
// 決済固有番号決済ID
@property (nonatomic, copy, readonly) NSString *paymentSeq;
// 消費に使用されるトークン
@property (nonatomic, copy, readonly) NSString *accessToken;
// 決済ID
@property (nonatomic, copy, readonly) NSString *transactionIdentifier;
// 原本決済ID
@property (nonatomic, copy, readonly, nullable) NSString *originalTransactionIdentifier;
// 商品購入時間
@property (nonatomic, readonly) NSTimeInterval purchaseTime;
// サブスクリプション商品の有効期限
@property (nonatomic, readonly) NSTimeInterval expiryTime;
// プロモーション決済状況
@property (nonatomic, readonly, getter=isStorePayment) BOOL storePayment;
// サンドボックス決済かどうか
@property (nonatomic, readonly, getter=isSandboxPayment) BOOL sandboxPayment;
// ユーザーデータ
@property (nonatomic, readonly, copy, nullable) NSString *payload;

@end
```

### エラーコード
```objc
// IAPエラーコード
static NSString *const NHNCloudIAPErrorDomain = @"com.nhncloud.iap";

typedef NS_ENUM(NSUInteger, NHNCloudIAPError) {
    NHNCloudIAPErrorUnknown = 0,                       // 不明
    NHNCloudIAPErrorNotInitialized = 1,                // 初期化しない
    NHNCloudIAPErrorStoreNotAvailable = 2,             // ストア使用不可
    NHNCloudIAPErrorProductNotAvailable = 3,           // 商品情報取得に失敗
    NHNCloudIAPErrorProductInvalid = 4,                // 元決済の商品IDと現在の商品IDが不一致
    NHNCloudIAPErrorAlreadyOwned = 5,                  // すでに所有している商品
    NHNCloudIAPErrorAlreadyInProgress = 6,             // すでに進行中の要請あり
    NHNCloudIAPErrorUserInvalid = 7,                   // 現在のユーザーIDが決済ユーザーIDと不一致
    NHNCloudIAPErrorPaymentInvalid = 8,                // 決済追加情報(ApplicationUsername)取得失敗
    NHNCloudIAPErrorPaymentCancelled = 9,              // ストア決済キャンセル
    NHNCloudIAPErrorPaymentFailed = 10,                // ストア決済失敗
    NHNCloudIAPErrorVerifyFailed = 11,                 // 領収書検証失敗
    NHNCloudIAPErrorChangePurchaseStatusFailed = 12,   // 購入状態変更失敗
    NHNCloudIAPErrorPurchaseStatusInvalid = 13,        // 購入進行不可状態
    NHNCloudIAPErrorExpired = 14,                      // 購読満了
    NHNCloudIAPErrorRenewalPaymentNotFound = 15,       // 領収書内に更新決済と一致する決済情報がない
    NHNCloudIAPErrorRestoreFailed = 16,                // 復元に失敗しました
    NHNCloudIAPErrorPaymentNotAvailable = 17,          // 購入不可状態(e.g.アプリ内での購入制限設定)
    NHNCloudIAPErrorPurchaseLimitExceeded = 18,        // 月購入限度超過
};

// Networkエラーコード
static NSString *const NHNCloudHttpErrorDomain = @"com.nhncloud.http";

typedef NS_ENUM(NSUInteger, NHNCloudHttpError) {
    NHNCloudHttpErrorNetworkNotAvailable = 100,        // ネットワーク使用不可
    NHNCloudHttpErrorRequestFailed = 101,              // HTTPステータスコードが200でないか、要求を読み取れない
    NHNCloudHttpErrorRequestTimeout = 102,             // タイムアウト
    NHNCloudHttpErrorRequestInvalid = 103,             // 要請の誤り
    NHNCloudHttpErrorURLInvalid = 104,                 // URLの誤り
    NHNCloudHttpErrorResponseInvalid = 105,            // 応答の誤り
    NHNCloudHttpErrorAlreadyInprogress = 106,          // 要請がすでに進行中
    NHNCloudHttpErrorRequiresSecureConnection = 107,   // Allow Arbitrary Loadsを設定しない
};
```
