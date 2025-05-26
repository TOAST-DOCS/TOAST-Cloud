#!/bin/bash

echo "public-api 환경별 문서 자동 생성"

# framework-api.md → framework-api-gov.md
sed -e "s|https://core.api.nhncloudservice.com/|https://core.api.gov-nhncloudservice.com/|g" \
    ko/public-api/framework-api.md > ko/public-api/framework-api-gov.md

# api-authentication.md → api-authentication-gov.md
sed -e "s|https://oauth.api.nhncloudservice.com/|https://oauth.api.gov-nhncloudservice.com/|g" \
    -e "s|https://core.api.nhncloudservice.com|https://core.api.gov-nhncloudservice.com|g" \
    -e "s|(framework-api.md)|(framework-api-gov.md)|g" \
    ko/public-api/api-authentication.md > ko/public-api/api-authentication-gov.md

# overview.md → overview-gov.md (링크만 치환)
sed -e "s|(framework-api.md)|(framework-api-gov.md)|g" \
    ko/public-api/overview.md > ko/public-api/overview-gov.md

# release-notes.md → release-notes-gov.md (단순 복사)
cp ko/public-api/release-notes.md ko/public-api/release-notes-gov.md

# git stage에 추가
git add \
  ko/public-api/framework-api-gov.md \
  ko/public-api/api-authentication-gov.md \
  ko/public-api/overview-gov.md \
  ko/public-api/release-notes-gov.md

echo "문서 생성 및 git add 완료"
