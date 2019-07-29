## TOAST > TOAST SDK使用ガイド > リリースノート > Unity

## 0.15.1 (2019.07.29)

### 공통

* iOS 0.16.1 framework 적용

## 0.15.0 (2019.07.23)

### TOAST IAP

#### 변경 사항

* ActivedPurchases -> ActivatedPurchses
    
## 0.14.0 (2019.07.02)

### TOAST Log & Crash

#### 추가 사항

* Unity Standalone/WebGL 버전 추가
    * Logger
    * Instance Logger

### TOAST IAP

#### 추가 사항

* ActivedPurchases 추가

## 0.13.1 (2019.03.26)

### TOAST Log & Crash

#### 機能改善

* ユニティスレッドではなく、スレッドでもログを送信できるように機能改善。
* ProjectKeyがAppKeyに名称変更。
    *既存のsetProjectKeyは引き続き使用可能。

#### バグ修正

* Android上でクラッシュログの送信時に空の文字列がある場合、SDKの例外ログが送信される問題を解決。

## 0.13.0 (2019.02.26)

### TOAST Log & Crash

#### 追加事項

* クラッシュログをフィルタリングする機能を追加

## 0.12.0 (2019.01.08)

### TOAST IAP

#### 追加事項

* 新規機能追加

## 0.11.0 (2018.12.27)

### TOAST Log & Crash

#### 追加事項

* Unityで発生した予期せぬ例外のログを自動的に送信する機能を追加
* SetCrashListener API追加

## 0.10.0 (2018.11.20)

### TOAST Log & Crash

#### 追加事項

* SetLoggerListener API追加
* Network Insightsサポート

#### 変更事項

* UnityパッケージからmainTemplate.gradle削除
    * mainTemplate.gradle設定はガイド参照

## 0.9.0 (2018.09.04)

### TOAST Log & Crash

#### 追加事項

* 新規機能追加
