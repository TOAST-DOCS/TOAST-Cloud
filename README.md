# TOAST-Cloud

* 프레임워크개발팀 public-api 문서작성시 사용
  * 최초 public 환경의 md 만 만들고 수행시 gov 은 자동치환 후 파일생성 -> 커밋
  * 처음 Git Clone 수행 시 처리할 사항
      * Terminal에서 아래 명령어를 수행해서 pre-commit hook을 적용 부탁드립니다.

```
echo "./replace.sh" > .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit
```