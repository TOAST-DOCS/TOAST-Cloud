## TOAST > TOAST SDK 使用ガイド > リリースノート > Unity

## 0.20.0 (2020.03.26)

## plugin version

- Android : 0.21.0
- iOS : 0.23.0

### 버그 수정

- CrashFilter관련 처리에서 Exception 이슈

## 0.19.1 (2020.01.23)

### 버그 수정

- OnHandleException 콜백 호출 이슈

## 0.19.0 (2019.12.27)

### 추가 사항

- Unity Play Services Resolver 적용

## 0.18.0 (2019.12.06)

### 공통

- iOS 0.20.1 framework 적용
- Android 0.19.4 aar 포함해서 배포
- Native Plugin (Windows, MacOS) 배포

## 0.17.0 (2019.10.02)

### TOAST IAP

- 구매 요청시 사용자 데이터 설정 기능 추가

## 0.16.0 (2019.08.28)

### TOAST IAP

#### 변경 사항

- 소비성 구독 상품 추가

## 0.15.1 (2019.07.29)

### 공통

- iOS 0.16.1 framework 적용

## 0.15.0 (2019.07.23)

### TOAST IAP

#### 변경 사항

- ActivedPurchases -> ActivatedPurchses

## 0.14.0 (2019.07.02)

### TOAST Log & Crash

#### 추가 사항

- Unity Standalone/WebGL 버전 추가
  - Logger
  - Instance Logger

### TOAST IAP

#### 추가 사항

- ActivedPurchases 추가

## 0.13.1 (2019.03.26)

### TOAST Log & Crash

#### 機能改善

- ユニティスレッドではなく、スレッドでもログを送信できるように機能改善。
- ProjectKey が AppKey に名称変更。
      \*既存の setProjectKey は引き続き使用可能。

#### バグ修正

- Android 上でクラッシュログの送信時に空の文字列がある場合、SDK の例外ログが送信される問題を解決。

## 0.13.0 (2019.02.26)

### TOAST Log & Crash

#### 追加事項

- クラッシュログをフィルタリングする機能を追加

## 0.12.0 (2019.01.08)

### TOAST IAP

#### 追加事項

- 新規機能追加

## 0.11.0 (2018.12.27)

### TOAST Log & Crash

#### 追加事項

- Unity で発生した予期せぬ例外のログを自動的に送信する機能を追加
- SetCrashListener API 追加

## 0.10.0 (2018.11.20)

### TOAST Log & Crash

#### 追加事項

- SetLoggerListener API 追加
- Network Insights サポート

#### 変更事項

- Unity パッケージから mainTemplate.gradle 削除
  - mainTemplate.gradle 設定はガイド参照

## 0.9.0 (2018.09.04)

### TOAST Log & Crash

#### 追加事項

- 新規機能追加
