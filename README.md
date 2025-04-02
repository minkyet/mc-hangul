# ⌨ mc-hangul

![thumbnail](pack.png)

mc-hangul은 한글 유틸리티 데이터팩입니다. 조사 붙이기, 자모 분리 / 결합 등의 API 함수가 제공됩니다.

mc-hangul은 [es-hangul](https://es-hangul.slash.page/)의 로직을 기반으로 작성되었으며, 마인크래프트 데이터팩에 맞게 인터페이스 및 로직을 조정했습니다.

## 다운로드

[Releases 페이지](https://github.com/minkyet/mc-hangul/releases)에서 마인크래프트 버전에 맞는 파일을 다운로드하면 됩니다.

## 사용

mc-hangul은 네임스페이스 `hangul`을 사용합니다.

> [!CAUTION]
> `hangul:internal/`로 시작하는 함수는 내부 로직 구현용 함수이므로 사용하지 말아주세요.

API로 제공되는 함수들을 사용하면 `storage hangul: out`에 결과가 출력됩니다.

각 함수들의 사용법은 [API 문서](API_DOC.md)를 참고해주세요.

```js
/function hangul:josa {str:"햄스터", josa:"이/가"}
/data get storage hangul: out   # "햄스터가"
```

## 라이선스

mc-hangul은 [MIT License](LICENSE)를 제공합니다.

-   출처/라이선스 표기
-   상업적/개인적 이용 가능
-   수정/배포 가능