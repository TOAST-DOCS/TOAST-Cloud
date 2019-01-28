## TOAST > TOAST SDK 사용 가이드 > TOAST IAP > Android

## 사전 준비

1\. [TOAST SDK](./getting-started-android)를 설치합니다.
2\. [TOAST 콘솔](https://console.cloud.toast.com)에서 [IAP 서비스를 활성화](https://docs.toast.com/ko/Mobile%20Service/IAP/ko/console-guide/#iap-appkey)합니다.
3\. IAP 콘솔에서 [AppKey를 확인](https://docs.toast.com/ko/Mobile%20Service/IAP/ko/console-guide/#appkey)합니다.

## 스토어별 인앱 결제 가이드

- [Android Developers 인앱 결제](https://developer.android.com/google/play/billing)
- [ONE store 인앱결제 API V5 (SDK V17) 안내 및 다운로드](https://dev.onestore.co.kr/devpoc/reference/view/IAP_v17)

## 라이브러리 설정

- Google Play Store의 인앱 결제를 사용하려면 아래와 같이 build.gradle에 의존성을 추가합니다.

```groovy
dependencies {
    implementation 'com.toast.android:toast-iap-google:0.14.1'
    ...
}
```

- ONE store의 인앱 결제를 사용하려면 아래와 같이 build.gradle에 의존성을 추가합니다.

```groovy
dependencies {
    implementation 'com.toast.android:toast-iap-onestore:0.14.1'
    ...
}
```

### 스토어 코드

| 스토어         | 코드         |
| ----------- | ---------- |
| Google Play | "GG"       |
| ONE store   | "ONESTORE" |

> [참고] 스토어 코드는 [IapStoreCode](./iap-android/#iapstorecode) 클래스에 정의되어 있습니다.

## 상품 종류

- 현재 지원하는 상품 종류는 2가지로, 소비성 상품과 구독 상품이 있습니다.

| 상품명    | 상품타입             | 설명                                     |
| ------ | ---------------- | -------------------------------------- |
| 소비성 상품 | "CONSUMABLE"     | 소비 가능한 일회성 상품, 게임내 재화, 미디어 파일은 소비성 상품의 예입니다. |
| 구독 상품  | "AUTO_RENEWABLE" | 지정된 간격 및 가격으로 결제가 자동으로 되풀이되는 상품, <br>온라인 잡지 및 음악 스트리밍 서비스는 구독의 예입니다. |

> [참고] 구독 상품은 **Google Play 스토어**만 지원합니다.

## 인앱 결제 설정

* [ToastIapConfiguration](./iap-android/#toastiapconfiguration) 객체는 인앱 결제 설정 정보를 포함하고 있습니다.
* [ToastIapConfiguration](./iap-android/#toastiapconfiguration) 객체는 [ToastIapConfiguration.Builder](./iap-android/#toastiapconfigurationbuilder)를 사용하여 생성할 수 있습니다.
* IAP 콘솔에서 발급받은 [AppKey](https://docs.toast.com/ko/Mobile%20Service/IAP/ko/console-guide/#appkey)를 setAppKey 메서드를 사용하여 설정합니다.
* setStoreCode 메서드를 사용하여 인앱 결제에 사용할 [스토어 코드](./iap-android/#_3)를 설정합니다.

### 인앱 결제 설정 예시

```java
ToastIapConfiguration configuration =
    ToastIapConfiguration.newBuilder(getApplicationContext())
                .setAppKey(YOUR_APP_KEY)
                .setStoreCode(IapStoreCode.GOOGLE_PLAY_STORE)
                .build();
```

## 인앱 결제 초기화

- ToastIap.initialize() 메소드를 호출하여 TOAST IAP를 초기화 합니다.

### 인앱 결제 초기화 API 명세

* 인앱 결제는 ToastIap.initialize 메서드를 사용하여 초기화합니다.
* ToastIap.initialize 메서드는 [ToastIapConfiguration.Builder](./iap-android/#toastiapconfigurationbuilder)로 생성된 [ToastIapConfiguration](./iap-android/#toastiapconfiguration) 객체를 파라미터로 사용합니다.

```java
/* ToastIap.java */
public static void initialize(ToastIapConfiguration configuration)
```

| Parameters    |                                    |
| ------------- | ---------------------------------- |
| configuration | ToastIapConfiguration: 인앱 결제 설정 정보 |

### 인앱 결제 초기화 예시

- ToastIap를 초기화합니다. 

> [참고] 초기화는 반드시 Application#onCreate에서 진행해야 합니다.
    
```java
public class MainApplication extends Application {
    @Override
    public void onCreate() {
        super.onCreate();
        initializeToastIap();
    }

    /**
     * ToastIap 를 초기화합니다.
     */
    private void initializeToastIap() {
        ToastIapConfiguration configuration = ToastIapConfiguration.newBuilder(getApplicationContext())
                .setAppKey(YOUR_APP_KEY)
                .setStoreCode(IapStoreCode.GOOGLE_PLAY_STORE)
                .build();
        ToastIap.initialize(configuration);
    }
}
```

## 서비스 로그인

* TOAST SDK에서 제공하는 모든 상품(IAP, Log & Crash등)은 하나의 동일한 사용자 아이디를 사용합니다.
    * [ToastSdk.setUserId](https://docs.toast.com/ko/TOAST/ko/toast-sdk/getting-started-android/#userid)로 사용자 아이디를 설정할 수 있습니다.
    * 사용자 아이디를 설정하지 않은 경우, 결제가 진행되지 않습니다.
* 서비스 로그인 단계에서 사용자 아이디 설정, 미소비 결제 내역 조회, 활성화된 구독 상품 조회 기능을 구현하는 것을 권장합니다.

### 로그인

```java
// Login.
ToastSdk.setUserId(userId);
```

### 로그아웃

```java
// Logout.
ToastSdk.setUserId(null);
```

> [참고] 서비스 로그아웃 시 반드시 유저 아이디를 null로 설정해야 프로모션 코드가 리딤되거나 결제 재처리 동작시 잘못된 사용자 아이디로 구매가 진행되는 것을 방지할 수 있습니다.

## 결제 업데이트 리스너 등록

* 결제 결과는 ToastIap에 설정된 [IapService.PurchasesUpdatedListener](./iap-android/#iapservicepurchasesupdatedlistener)를 통해 통지됩니다.
* 결제 업데이트 리스너는 ToastIap.registerPurchasesUpdatedListener 메서드를 사용하여 등록할 수 있습니다.
* [IapService.PurchasesUpdatedListener](./iap-android/#iapservicepurchasesupdatedlistener)를 통해 전달된 [IapPurchaseResult](./iap-android/#iappurchaseresult) 리스트를 통해 결제 정보를 확인할 수 있습니다.

> [참고] 결제 업데이트 리스너는 Activity.onCreate()에서 등록하고 Activity.onDestroy()에서 반드시 해제해야 합니다.

### 결제 업데이트 리스너 등록 API 명세

```java
/* ToastIap.java */
public static void registerPurchasesUpdatedListener(IapService.PurchasesUpdatedListener listener)
public static void unregisterPurchasesUpdatedListener(IapService.PurchasesUpdatedListener listener)
```

| Method                             | Parameters |                                          | Description            |
| ---------------------------------- | ---------- | ---------------------------------------- | ---------------------- |
| registerPurchasesUpdatedListener   | listener   | IapService.<br>PurchasesUpdatedListener: <br>결제 업데이트 리스너 | 결제 업데이트 리스너를 등록합니다.    |
| unregisterPurchasesUpdatedListener | listener   | IapService.<br>PurchasesUpdatedListener: <br>등록 해제할 리스너 | 결제 업데이트 리스너 등록을 해제합니다. |

#### 결제 업데이트 리스너 등록 예시

```java
public class MainActivity extends AppCompatActivity {
    /**
     * 인앱에서 소비성 상품, 구독, 프로모션 상품을 구매했을 때 결과를 통지합니다.
     */
    private IapService.PurchasesUpdatedListener mPurchaseUpdatedListener =
            new IapService.PurchasesUpdatedListener() {
                @Override
                public void onPurchasesUpdated(@NonNull List<IapPurchaseResult> purchaseResults) {
                    for (IapPurchaseResult purchaseResult : purchaseResults) {
                        if (purchaseResult.isSuccess()) {
                            // 성공
                            IapPurchase purchase = purchaseResult.getPurchase();
                        } else {
                            // 실패
                        }
                    }
                }
            };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // onCreate가 호출되었을 때 Listener를 등록합니다.
        ToastIap.registerPurchasesUpdatedListener(mPurchaseUpdatedListener);
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        // onDestroy()가 호출되었을 때 반드시 Listener를 제거합니다.
        ToastIap.unregisterPurchasesUpdatedListener(mPurchaseUpdatedListener);
    }
}
```

## 상품 목록 조회

* IAP 콘솔에 등록된 상품 중 사용 가능한 상품 목록을 조회합니다.
* IAP 콘솔에 등록된 상품 중 구매 가능한 상품은 [IapProductDetails](./iap-android/#iapproductdetails) 리스트(Product Details List)로 반환됩니다.
* IAP 콘솔에 등록된 상품 중 스토어에 등록되지 않은 상품은 [IapProduct](./iap-android/#iapproduct) 리스트(Invalid Product List)로 반환됩니다.

### 상품 목록 조회 API 명세

```java
/* ToastIap.java */
public static void queryProductDetails(Activity activity,
                                       IapService.ProductDetailsResponseListener listener)
```

| Method              | Parameters |                                          |
| ------------------- | ---------- | ---------------------------------------- |
| queryProductDetails | activity   | Activity: 현재 활성화된 Activity               |
|                     | listener   | IapService.<br>ProductDetailsResponseListener: <br>상품 조회 결과 리스너 |


### 상품 목록 조회 예시

```java
/**
 * 구매 가능한 상품을 조회합니다.
 * <p>
 * productDetails : 구매 가능한 상품 목록
 * invalidProducts : TOAST IAP 콘솔에 상품을 등록하였지만 스토어에 등록되지 않은 상품
 */
void queryProductDetails() {
    IapService.ProductDetailsResponseListener responseListener =
            new IapService.ProductDetailsResponseListener() {
                @Override
                public void onProductDetailsResponse(@NonNull IapResult result,
                                                     @Nullable List<IapProductDetails> productDetails,
                                                     @Nullable List<IapProduct> invalidProducts) {
                    if (result.isSuccess()) {
                        // 조회성공
                    } else {
                        // 조회실패
                    }
                }
            }

    ToastIap.queryProductDetails(MainActivity.this, responseListener);
}
```

## 상품 구매 

* TOAST IAP는 스토어에 등록된 상품 ID를 사용하여 상품을 구매할 수 있습니다.
* 상품 정보는 ToastIap.queryProductDetails() 메서드를 호출하여 반환된 [IapProductDetails](./iap-android/#iapproductdetails) 객체에 포함되어있습니다.
* 상품 ID는 IapProductDetails.getProductId() 메서드를 사용하여 획득할 수 있습니다.
* 상품 구매는 [IapPurchaseFlowParams](./iap-android/#iappurchaseflowparams) 객체에 상품 ID를 설정한 후 ToastIap.launchPurchaseFlow() 메서드를 통해 구매 단계를 시작합니다.
* [IapPurchaseFlowParams](./iap-android/#iappurchaseflowparams) 객체는 [IapPurchaseFlowParams.Builder](./iap-android/#iappurchaseflowparamsbuilder)를 사용하여 생성할 수 있습니다.
* 상품 구매 결과는 ToastIap에 등록한 [IapService.PurchasesUpdatedListener](./iap-android/#iapservicepurchasesupdatedlistener)를 통해 반환됩니다.

### 상품 구매 IAP 명세

```java
/* ToastIap.java */
public static void launchPurchaseFlow(Activity activity,
                                      IapPurchaseFlowParams params)
```

| Method             | Parameters |                                   |
| ------------------ | ---------- | --------------------------------- |
| launchPurchaseFlow | activity   | Activity: 현재 활성화된 Activity        |
|                    | params     | IapPurchaseFlowParams: 구매 정보 파라미터 |

### 상품 구매 예시

```java
/**
 * 상품을 구매합니다.
 */
void launchPurchaseFlow(Activity activity, String productId) {
    IapPurchaseFlowParams params = IapPurchaseFlowParams.newBuilder()
            .setProductId(productId)
            .build();
    ToastIap.launchPurchaseFlow(activity, params);
}
```

## 미소비 결제 조회

* 아직 소비되지 않은 일회성 상품(CONSUMABLE) 정보를 조회합니다.
* 사용자에게 상품을 지급된 후 [Consume API](https://docs.toast.com/en/Mobile%20Service/IAP/en/api-guide-for-toast-sdk/#consume-api)를 사용하여 상품을 소비합니다.
* 미소비 결제는 ToastIap.queryConsumablePurchases() 메서드를 사용하여 조회할 수 있습니다.
* 조회 결과는 [IapService.PurchasesResponseListener](./iap-android/#iapservicepurchasesresponselistener)를 통해 [IapPurchase](./iap-android/#iappurchase) 객체 리스트로 반환됩니다.

### 미소비 결제 조회 API 명세

```java
/* ToastIap.java */
public static void queryConsumablePurchases(Activity activity,
                                            IapService.PurchasesResponseListener listener)
```

| Method                   | Parameters |                                          |
| ------------------------ | ---------- | ---------------------------------------- |
| queryConsumablePurchases | activity   | Activity: 현재 활성화된 Activity               |
|                          | listener   | IapService.PurchasesResponseListener: <br>미소비 구매 내역 조회 결과 리스너 |

### 미소비 결제 조회 예시

```java
/**
 * 미소비 결제 내역을 조회합니다.
 */
void queryConsumablePurchases() {
    PurchasesResponseListener responseListenr =
            new IapService.PurchasesResponseListener() {
                @Override
                public void onPurchasesResponse(@NonNull IapResult result,
                                                @Nullable List<IapPurchase> purchases) {
                    if (result.isSuccess()) {
                        // 성공
                    } else {
                        // 실패
                    }
                }
            };
    ToastIap.queryConsumablePurchases(MainActivity.this, responseListenr);
}
```

## 활성화된 구독 조회

* User ID 기준으로 활성화된 구독 상품을 조회할 수 있습니다.
* 결제가 완료된 구독 상품은 사용 기간이 남아 있는 경우 계속해서 조회할 수 있습니다.
* 활성화된 구독은 ToastIap.queryActivatedPurchases() 메서드를 사용하여 조회할 수 있습니다.
* 조회 결과는 [IapService.PurchasesResponseListener](./iap-android/#iapservicepurchasesresponselistener)를 통해 [IapPurchase](./iap-android/#iappurchase) 객체 리스트를 반환됩니다.
* iOS에서 구독한 상품을 Android에서도 조회 가능합니다.

> 현재 구독 상품은 Google Play 스토어만 지원합니다.

### 활성화된 구독 조회 API 명세

```java
/* ToastIap.java */
public static void queryActivatedPurchases(Activity activity,
                                           PurchasesResponseListener listener)
```

| Method                  | Parameters |                                          |
| ----------------------- | ---------- | ---------------------------------------- |
| queryActivatedPurchases | activity   | Activity: 현재 활성화된 Activity               |
|                         | listener   | IapService.PurchasesResponseListener: <br>활성화된 구독 조회 결과 리스너 |

### 활성화된 구독 조회 예시

```java
/**
 * 활성화된 구독 상품 조회
 */
void queryActivatedPurchases() {
    PurchasesResponseListener responseListener =
            new IapService.PurchasesResponseListener() {
                @Override
                public void onPurchasesResponse(@NonNull IapResult result,
                                                @Nullable List<IapPurchase> purchases) {
                    if (result.isSuccess()) {
                        // 성공
                    } else {
                        // 실패
                    }
                }
            };
    ToastIap.queryActivatedPurchases(MainActivity.this, responseListener);
}
```

## TOAST IAP Class Reference

### ToastIapConfiguration

TOAST IAP 초기화 메소드의 파라미터로 사용되는 인앱 결제 설정 정보입니다.

```java
/* ToastIapConfiguration.java */
public String getAppKey();
public String getStoreCode();
```

| Method       | Returns |                                     |
| ------------ | ------- | ----------------------------------- |
| getAppKey    | String  | IAP 서비스 앱 키                         |
| getStoreCode | String  | 스토어 코드 정보 ("GG" or "ONESTORE", ...) |

### ToastIapConfiguration.Builder

IAP 서비스 앱 키, 스토어 종류 등을 입력받아 [ToastIapConfiguration](./iap-android/#toastiapconfiguration) 객체를 생성합니다.

```java
/* ToastIapConfiguration.java */
public void setAppKey(String appKey)
public void setStoreCode(String storeCode)
```

| Method       | Parameters |                     | Description                              |
| ------------ | ---------- | ------------------- | ---------------------------------------- |
| setAppKey    | appKey     | String: IAP 서비스 앱 키 | TOAST IAP 콘솔에서 생성한 앱 키를 설정합니다.      |
| setStoreCode | storeCode  | String: 스토어 코드 정보   | 스토어 코드를 설정합니다.<br>("GG" or "ONESTORE", ...) |

### IapStoreCode

```java
/* IapStoreCode.java */
String GOOGLE_PLAY_STORE
String ONE_STORE
```

* GOOGLE_PLAY_STORE<br>Google Play 스토어 인앱 결제를 사용합니다.<br>Constant Value: "GG"
* ONE_STORE<br>ONE store 인앱 결제를 사용합니다.<br>Constant Value: "ONESTORE"

### IapPurchaseResult

* 결제 결과 및 결제 정보를 포함한 객체입니다.

```java
/* IapPurchaseResult.java */
public IapPurchase getPurchase()
public boolean isSuccess()
public boolean isFailure()
public int getCode()
public String getMessage()
public Throwable getCause()
```

| Method      | Returns     |                                  |
| ----------- | ----------- | -------------------------------- |
| getPurchase | IapPurchase | 결제 정보가 있는 IapPurchase 객체를 반환합니다. |
| getCode     | int         | 결제 결과 코드를 반환합니다.                 |
| getMessage  | String      | 결제 결과 메시지를 반환합니다.                |
| getCause    | Throwable   | 결제 실패 원인를 반환합니다.                 |
| isSuccess   | boolean     | 결제 성공 여부를 반환합니다.                 |
| isFailure   | boolean     | 결제 실패 여부를 반환합니다.                 |

### IapResult 

```java
/* IapResult.java */
public boolean isSuccess()
public boolean isFailure()
public int getCode()
public String getMessage()
public Throwable getCause()
```

| Method     | Returns   |                |
| ---------- | --------- | -------------- |
| getCode    | int       | 결과 코드를 반환합니다.  |
| getMessage | String    | 결과 메시지를 반환합니다. |
| getCause   | Throwable | 실패 원인를 반환합니다.  |
| isSuccess  | boolean   | 성공 여부를 반환합니다.  |
| isFailure  | boolean   | 실패 여부를 반환합니다.  |

### IapPurchase

* IapPurchase 객체로 결제 정보를 확인할 수 있습니다.

```java
/* IapPurchase.java */
public String getPaymentId()
public String getOriginalPaymentId()
public String getPaymentSequence()
public String getProductId()
public String getProductType()
public String getUserId()
public float getPrice()
public String getPriceCurrencyCode()
public String getAccessToken()
public String getPurchaseType()
public String getPurchaseTime()
public String getExpiryTime()
```

| Method               | Returns |                      |
| -------------------- | ------- | -------------------- |
| getPaymentId         | String  | 결제 ID를 반환합니다.        |
| getOriginalPaymentId | String  | 원본 결제 ID를 반환합니다.     |
| getPaymentSequence   | String  | 결제 고유 번호를 반환합니다.     |
| getProductId         | String  | 상품 ID를 반환합니다.        |
| getProductType       | String  | 상품 유형을 반환합니다.        |
| getUserId            | String  | 사용자 ID를 반환합니다.       |
| getPrice             | float   | 가격 정보를 반환합니다.        |
| getPriceCurrencyCode | String  | 통화 정보를 반환합니다.        |
| getAccessToken       | String  | 소비에 사용되는 토큰을 반환합니다.  |
| getPurchaseType      | String  | 상품 유형을 반환합니다.        |
| getPurchaseTime      | long    | 상품 구매 시간을 반환합니다.     |
| getExpiryTime        | long    | 구독 상품의 남은 시간을 반환합니다. |

### IapProductDetails

* IapProductDetails 객체로 상품 상세 정보를 확인할 수 있습니다.
* TOAST IAP 콘솔에 등록된 정보와 Google Play 콘솔 또는 ONE store Developer에 등록된 자세한 정보를 포함합니다.

```java
/* IapProductDetails.java */
public String getProductId()
public String getProductSequence()
public float getPrice()
public String getLocalizedPrice()
public String getPriceCurrencyCode()
public long getPriceAmountMicros()
public String getFreeTrialPeriod()
public String getSubscriptionPeriod()
public String getProductType()
public String getProductTitle()
public String getProductDescription()
public boolean isActivated()
```

| Method                | Returns |                 |
| --------------------- | ------- | --------------- |
| getProductId          | String  | 상품의 ID          |
| getProductSequence    | String  | 상품 고유 번호        |
| getPrice              | float   | 가격              |
| getLocalizedPrice     | String  | 현지 가격           |
| getPriceCurrencyCode  | String  | 통화              |
| getPriceAmountMicros  | long    | 1,000,000 단위 가격 |
| getFreeTrialPeriod    | String  | 무료 사용 기간        |
| getSubscriptionPeriod | String  | 구독 기간           |
| getProductType        | String  | 상품 유형           |
| getProductTitle       | String  | 상품 제목(title)    |
| getProductDescription | String  | 상품 설명           |
| isActivated           | boolean | 상품 활성화 여부       |

### IapProduct

* TOAST IAP 콘솔에 등록된 간략한 정보를 확인할 수 있습니다.

```java
/* IapProduct.java */
public String getProductId()
public String getProductSequence()
public String getProductType()
public String getProductTitle()
public String getProductDescription()
public boolean isActivated()
```

| Method                | Returns |              |
| --------------------- | ------- | ------------ |
| getProductId          | String  | 상품의 ID       |
| getProductSequence    | String  | 상품 고유 번호     |
| getProductType        | String  | 상품 유형        |
| getProductTitle       | String  | 상품 제목(title) |
| getProductDescription | String  | 상품 설명        |
| isActivated           | boolean | 상품 활성화 여부    |

### IapPurchaseFlowParams

* IapPurchaseFlowParams는 구매하려는 상품 정보를 포함합니다.

```java
/* IapPurchaseFlowParams.java */
public String getProductId()
```

| Method       | Returns |       |
| ------------ | ------- | ----- |
| getProductId | String  | 상품 ID |

### IapPurchaseFlowParams.Builder

* IapPurchaseFlowParams 객체를 생성합니다.

```java
/* IapPurchaseFlowParams.java */
public void setProductId(String productId)
```

| Method       | Parameters |               | Description   |
| ------------ | ---------- | ------------- | ------------- |
| setProductId | productId  | String: 상품 ID | 상품 ID를 설정합니다. |

### IapService.PurchasesUpdatedListener

* 결제 정보가 업데이트가 되었을 때 IapService.PurchasesUpdatedListener를 상속 구현한 객체의 onPurchasesUpdated 메서드를 통해 통지됩니다.

```java
void onPurchasesUpdated(List<IapPurchaseResult> purchaseResults)
```

### IapService.PurchasesResponseListener

* 미소비 결제 조회 또는 활성화된 구독 조회 시 IapService.PurchasesResponseListener를 상속 구현한 객체의 onPurchasesResponse 메서드를 통해 통지됩니다.

```java
void onPurchasesResponse(IapResult result,
                         List<IapPurchase> purchaseList)
```

## 오류 코드

### 공통 오류 코드

| RESULT                 | CODE | DESC                                     |
| ---------------------- | ---- | ---------------------------------------- |
| FEATURE_NOT_SUPPORTED  | -2   | 요청한 기능은 지원하지 않습니다.<br>Requested feature is not supported. |
| SERVICE_DISCONNECTED   | -1   | 스토어 서비스가 연결되지 않았습니다.<br>Store service is not connected. |
| OK                     | 0    | 성공.<br>Success.                          |
| USER_CANCELED          | 1    | 사용자 취소.<br>User canceled.                |
| SERVICE_UNAVAILABLE    | 2    | 네트워크가 연결되지 않았습니다.<br>Network connection is down. |
| BILLING_UNAVAILABLE    | 3    | 요청된 유형에 대해 API Version이 지원되지 않습니다.<br>API version is not supported for the type requested. |
| PRODUCT_UNAVAILABLE    | 4    | 요청한 상품을 사용할 수 없습니다.<br>Requested product is not available. |
| DEVELOPER_ERROR        | 5    | 잘못된 인수가 API에 제공되었습니다. 개발 단계에서 발생하는 오류입니다.<br>Developer error. |
| ERROR                  | 6    | API 작업 중 심각한 오류가 발생했습니다.<br>Fatal error during the API action. |
| PRODUCT_ALREADY_OWNED  | 7    | 이미 가지고 있는 상품이므로 구매하지 못했습니다.<br>Failure to purchase since item is already owned. |
| PRODUCT_NOT_OWNED      | 8    | 가지고 있지 않은 상품이므로 소비하지 못합니다.<br>Failure to consume since item is not owned. |
| USER_ID_NOT_REGISTERED | 9    | 사용자 ID가 등록되지 않았습니다.<br>User ID Is not registered. |
| UNDEFINED_ERROR        | 9999 | 정의되지 않은 오류<br>Undefined error.           |

### 서버 오류 코드

| RESULT                 | CODE | DESC                                     |
| ---------------------- | ---- | ---------------------------------------- |
| INACTIVATED_APP        | 101  | 활성화되지 않은 앱입니다.<br>App is not active.     |
| NETOWRK_NOT_CONNECTED  | 102  | 네트워크가 연결되지 않았습니다.<br>Network not connected. |
| VERIFY_PURCHASE_FAILED | 103  | 결제 검증에 실패했습니다.<br>Failure to verify purchase. |
| CONSUMED_PURCHASE      | 104  | 이미 소비된 구매입니다.<br>Purchase already consumed. |
| REFUNDED_PURCHASE      | 105  | 환불된 구매입니다.<br>Purchase already refunded. |

### ONE store 오류 코드

| RESULT                   | CODE | DESC                                     |
| ------------------------ | ---- | ---------------------------------------- |
| ONESTORE_NEED_LOGIN      | 301  | ONE store 서비스에 로그인되어 있지 않습니다.<br>ONE store service is not logged in. |
| ONESTORE_NEED_UPDATE     | 302  | ONE store 서비스가 업데이트 또는 설치되지 않았습니다.<br>ONE store service is not updated or installed. |
| ONESTORE_SECURITY_ERROR  | 303  | 비정상 앱에서 결제를 요청하였습니다.<br>Abnormal purchase request. |
| ONESTORE_PURCHASE_FAILED | 304  | 결제 요청에 실패했습니다.<br>Purchase request failed. |

