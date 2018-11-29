## TOAST > TOAST SDK 사용 가이드 > TOAST IAP > Android

## Prerequisites

1. [Install the TOAST SDK](./getting-started-android)
2. [TOAST 콘솔](https://console.cloud.toast.com)에서 [Mobile Service \> IAP를 활성화](https://docs.toast.com/ko/Mobile%20Service/IAP/ko/console-guide/)합니다.
3\. IAP에서 [AppKey를 확인](https://docs.toast.com/ko/Mobile%20Service/IAP/ko/console-guide/#appkey)합니다.

## TOAST IAP SDK Android 사용 가이드

### 개발환경
- Android Studio IDE 3.1.4 이상
- Android SDK Version은 4.0.3 (API Level 15) 이상
- Android Stuiod Gradle 설정

### 라이브러리 추가
- implementation을 사용하여, build.gradle에 라이브러리를 추가합니다.

```groovy
dependencies {
    implementation 'com.toast.android:toast-iap-google:0.12.0'
}
```

### 지원 마켓

- TOAST IAP SDK는 Google, OneStore 마켓을 지원합니다.

### TOAST IAP SDK 초기화

- TOAST IAP SDK를 사용하기 위해서는 먼저 ToastSdk를 초기화 해야 합니다.
- 이후 ToastIap를 초기화 합니다. 초기화는 반드시 Application#onCreate에서 진행되어야 합니다.
- YOUR STORE CODE에는 마켓 정보를 입력합니다.
    - IapStoreCode.GOOGLE_PLAY_STORE : Google 마켓
    - IapStoreCode.ONE_STORE : OneStore 마켓

```java
public class MainApplication extends Application {
    @Override
    public void onCreate() {
        super.onCreate();
        initializeToastSdk();
        initializeToastIap();
        ...
    }

    /**
    * ToastSdk 를 초기화합니다.
    *
    * ToastSdk 디버그 모드를 활성화하려면 ToastSdk.setDebugMode(boolean) 호출하여 true 로 설정합니다.
    * <pre>
    * {@code
    * ToastSdk.setDebugMode(true);
    * }
    * </pre>
    */
    private void initializeToastSdk() {
        ToastSdk.setDebugMode(true);
        ToastSdk.initialize(getApplicationContext());
    }

    /**
    * ToastIap 를 초기화합니다.
    */
    private void initializeToastIap() {
        ToastIapConfiguration configuration = ToastIapConfiguration.newBuilder(getApplicationContext())
        .setAppKey(APP_KEY)
        .setStoreCode(YOUR_STORE_CODE)
        .build();
        ToastIap.initialize(configuration);
    }
}
```

### 결제 콜백 관리하기
- 결제 결과를 콜백 받는 PurchasesUpdatedListener를 구현합니다.
- PurchasesUpdatedListener는 onCreate에서 등록하고 onDestroy에서 해제 합니다.

```java
public class MainActivity extends AppCompatActivity {
    private static final String TAG = "MainActivity";
    /**
    * 인앱에서 소비성 상품, 구독, 프로모션 상품을 구매했을 때 결과를 통지합니다.
    */
    private PurchasesUpdatedListener mPurchaseUpdatedListener = new PurchasesUpdatedListener() {
        @Override
        public void onPurchasesUpdated(@NonNull List<IapPurchaseResult> purchaseResults) {
            Log.d(TAG, "Updated purchases.");
            for (IapPurchaseResult purchaseResult : purchaseResults) {
                if (purchaseResult.isSuccess()) {
                    // 성공
                    Log.i(TAG, purchaseResult.toString());
                    IapPurchase purchase = purchaseResult.getPurchase();
                    if (purchase != null) {
                    Log.d(TAG, purchase.toString());
                    }
                } else {
                // 실패
                Log.e(TAG, purchaseResult.toString());
                }
            }
        }
    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // registerPurchaseUpdatedListener
        registerPurchaseUpdatedListener(mPurchaseUpdatedListener);
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        // Activity.onDestroy()가 호출되었을 때 반드시
        // unregisterPurchaseUpdatedListener 를 호출하여 Listener 를 제거해야합니다.
        unregisterPurchaseUpdatedListener(mPurchaseUpdatedListener);
        }

        void registerPurchaseUpdatedListener(@NonNull IapService.PurchasesUpdatedListener listener) {
        ToastIap.registerPurchasesUpdatedListener(listener);
    }

    void unregisterPurchaseUpdatedListener(@NonNull IapService.PurchasesUpdatedListener listener) {
        ToastIap.unregisterPurchasesUpdatedListener(listener);
    }
    ...
}

```

### 로그인 & 로그아웃
- 사용자 아이디는 ToastSdk를 통해 설정합니다.
- 결제 관련 API를 사용하기 전, 반시드 사용자 정보를 입력해야 합니다.
- 사용자 아이디가 설정되지 않은 경우, 결제가 진행되지 않습니다.

```java
public class MainActivity extends AppCompatActivity {
    /**
    * 앱이 로그인 되었을 때 ToastSdk.setUserId()을 호출하여 User Id를 설정해야합니다.
    * ToastIap는 ToastSdk에 설정된 User ID를 사용하여 결제를 진행합니다.
    *
    * User ID 설정 후 미소비 결제 내역 조회 및 활성화된 구독 상품 조회를 진행합니다.
    */
    private void onLogin() {
        // User Id 설정
        ToastSdk.setUserId(USER_ID);

        // 미소비 결제 내역 조회
        queryConsumablePurchases();

        // 활성화된 구독 상품 조회
        queryActivatedPurchases();
    }

    /**
    * 로그아웃이 되었을 때 ToastSdk.setUserId(null)을 호출합니다.
    * Google Play 앱에서 프로모션 코드가 리딤되었을 때 잘못된 User ID로 구매되지 않도록 합니다.
    */
    private void onLogout() {
        ToastSdk.setUserId(null);
    }

    /**
    * 미소비 결제 내역을 조회합니다.
    * 미소비된 결제는 https://api-iap.cloud.toast.com/v1/service/consume API 를 사용하여 상품을 소비합니다.
    */
    void queryConsumablePurchases() {
    ToastIap.queryConsumablePurchases(MainActivity.this, new IapService.PurchasesResponseListener() {
        @Override
        public void onPurchasesResponse(@NonNull IapResult result,
        @Nullable List<IapPurchase> purchases) {
                if (result.isSuccess()) {
                    // 성공
                    Log.i(TAG, result.toString());
                    if (purchases != null) {
                        Log.d(TAG, "Consumable purchase list.");
                        Log.d(TAG, purchases.toString());
                    }
                } else {
                    // 실패
                    Log.e(TAG, result.toString());
                }
            }
        });
    }

    /**
    * 활성화된 구독 상품 조회
    */
    void queryActivatedPurchases() {
        ToastIap.queryActivatedPurchases(MainActivity.this, new IapService.PurchasesResponseListener() {
        @Override
        public void onPurchasesResponse(@NonNull IapResult result,
            @Nullable List<IapPurchase> purchases) {
                if (result.isSuccess()) {
                    // 성공
                    Log.i(TAG, result.toString());
                    if (purchases != null) {
                        Log.d(TAG, "Consumable purchase list.");
                        Log.d(TAG, purchases.toString());
                    }
                } else {
                    // 실패
                    Log.e(TAG, result.toString());
                }
            }
        });
    }
}

```

### 재처리
- 초기화 이후, 발생한 처리되지 않은 결제를 다시 진행시킵니다.
- onResumed에 구현하는 것을 권장합니다.
- 프로모션 상품 등을 처리하기 위해 사용됩니다.

```java
public class MainActivity extends AppCompatActivity {
    ...
    @Override
    protected void onResume() {
        super.onResume();
        // Google Play Store 에서 프로모션이 리딤된 결제 건을 처리하기 위해
        // Activity.onResume() 이 호출 되었을 때
        // queryConsumablePurchases()를 호출하여 프로모션 결제를 처리합니다.
        queryConsumablePurchases();
    }
}
```

### 상품 목록 조회
- TOAST IAP Console에 등록한 상품 목록을 조회합니다.

```java
/**
* 구매 가능한 상품을 조회합니다.
*
* productDetails : 구매 가능한 상품 목록
* invalidProducts : TOAST IAP 콘솔에 상품을 등록하였지만 구글에 등록되지 않은 상품
*/
void queryProductDetails() {
    ToastIap.queryProductDetails(MainActivity.this, new IapService.ProductDetailsResponseListener() {
    @Override
        public void onProductDetailsResponse(@NonNull IapResult result,
        @Nullable List<IapProductDetails> productDetails,
        @Nullable List<IapProduct> invalidProducts) {
            if (result.isSuccess()) {
                // 성공
                Log.i(TAG, result.toString());
                if (productDetails != null) {
                    Log.d(TAG, "Available product list.");
                    Log.d(TAG, productDetails.toString());
                }
                if (invalidProducts != null) {
                    Log.d(TAG, "Invalid product list.");
                    Log.d(TAG, invalidProducts.toString());
                }
            } else {
                // 실패
                Log.e(TAG, result.toString());
            }
        }
    });
}
```

### 구매
- 마켓에서 상품을 구매합니다.
- 이때 입력하는 productId는 마켓에 생성한 값을 사용합니다.

```java
/**
* 상품을 구매합니다.
*/
void launchPurchaseFlow(@NonNull Activity activity, @NonNull String productId) {
    IapPurchaseFlowParams params = IapPurchaseFlowParams.newBuilder()
    .setProductId(productId)
    .build();
    ToastIap.launchPurchaseFlow(activity, params);
}

```


### 일회성 상품 처리

##### 일회성 상품 미소비 내역 조회
- queryPurchases를 호출하여, 소비하지 않은 상품 정보를 조회합니다.
- 소비되지 않은 상품은 consume REST API를 통해 소비할 수 있습니다.

```java
/**
* 미소비 결제 내역을 조회합니다.
* 미소비된 결제는 https://api-iap.cloud.toast.com/v1/service/consume API 를 사용하여 상품을 소비합니다.
*/
void queryConsumablePurchases() {
    ToastIap.queryConsumablePurchases(MainActivity.this, new IapService.PurchasesResponseListener() {
        @Override
        public void onPurchasesResponse(@NonNull IapResult result,
        @Nullable List<IapPurchase> purchases) {
            if (result.isSuccess()) {
                // 성공
                Log.i(TAG, result.toString());
                if (purchases != null) {
                    Log.d(TAG, "Consumable purchase list.");
                    Log.d(TAG, purchases.toString());
                }
            } else {
                // 실패
                Log.e(TAG, result.toString());
            }
        }
    });
}
```

##### 일회성 상품 소비
- 소비하지 않은 상품은 Server To Server로 소비 진행합니다. (권장 사항)
- 소비 REST API를 참고해 주세요.


### 구독 상품 처리

#### 구매한 구독 상품 복원
- 현재 구독 상품은 Google Play Store만 지원합니다.
- 결제가 완료된 구독상품은, queryActivatedPurchases 통해 조회할 수 있습니다.
- 사용기간이 남아있는 경우, 계속해서 queryActivatedPurchases 통해 복원가능합니다.
- iOS에서 구독한 상품을 Android에서도 복원가능합니다. (동일한 유저 ID일  경우)

```java
/**
* 활성화된 구독 상품 조회
*/
void queryActivatedPurchases() {
    ToastIap.queryActivatedPurchases(MainActivity.this, new IapService.PurchasesResponseListener() {
    @Override
    public void onPurchasesResponse(@NonNull IapResult result,
    @Nullable List<IapPurchase> purchases) {
            if (result.isSuccess()) {
                // 성공
                Log.i(TAG, result.toString());
                if (purchases != null) {
                    Log.d(TAG, "Consumable purchase list.");
                    Log.d(TAG, purchases.toString());
                }
            } else {
                // 실패
                Log.e(TAG, result.toString());
            }
        }
    });
}
```

### 에러 코드
