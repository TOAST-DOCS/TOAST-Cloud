# TOAST-Cloud

* 처음 Git Clone 수행 시 처리할 사항
    * Terminal에서 아래 명령어를 수행해서 pre-commit hook을 적용 부탁드립니다.

```
echo "./replace.sh" > .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit
```