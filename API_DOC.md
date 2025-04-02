# storage API

`storage hangul: out`을 통해 값을 반환하는 함수입니다.

---

## hangul:assemble

```js
hangul:assemble { array: string[] }: string
```

배열에 담긴 한글 문장과 문자를 한글 규칙에 맞게 합성합니다.

```js
/function hangul:assemble {array:["메밀꽃", " ", "피ㄹ", " ㅁ", "ㅜ려", "ㅂ"]}   # "메밀꽃 필 무렵"
/function hangul:assemble {array:["메밀꽃", " ", "필 ", "무렵"]}   # "메밀꽃 필 무렵"
/function hangul:assemble {array:["ㅁ", "ㅔ", "ㅁ", "ㅣ", "ㄹ", "ㄲ", "ㅗ", "ㅊ"]}   # "메밀꽃"
```

## hangul:binary_assemble

```js
hangul:binary_assemble { source: string, next_char: string }: string
```

한글 문장과 한글 문자 하나를 합성합니다.

```js
/function hangul:binary_assemble {source:"나는 따", next_char:"ㄹ"}   # "나는 딸"
/function hangul:binary_assemble {source:"나는 딸", next_char:"ㄱ"}   # "나는 딹"
/function hangul:binary_assemble {source:"나는 딹", next_char:"ㅣ"}   # "나는 딸기"
```

## hangul:combine_character

```js
hangul:combine_character { 
    choseong: string
    jungseong: string
    options: {
        jongseong?: string
    }
}: string
```

초성, 중성, 종성을 받아 하나의 한글 문자를 반환합니다.

```js
/function hangul:combine_character {choseong:"ㄱ", jungseong:"ㅏ", options:{jongseong:"ㅂㅅ"}}   # "값"
/function hangul:combine_character {choseong:"ㅌ", jungseong:"ㅗ", options:{}}   # "토"
```

## hangul:combine_vowels

```js
hangul:combine_vowels { vowel1: string, vowel2: string }: string
```

두 모음을 받아 합성하여 겹모음을 생성합니다.

```js
/function hangul:combine_vowels {vowel1:"ㅗ", vowel2:"ㅏ"}   # "ㅘ"
/function hangul:combine_vowels {vowel1:"ㅗ", vowel2:"ㅐ"}   # "ㅙ"
/function hangul:combine_vowels {vowel1:"ㅗ", vowel2:"ㅛ"}   # "ㅗㅛ"
```

## hangul:disassemble_combined_character

```js
hangul:disassemble_combined_character { char: string }: string
```

겹자음/겹모음을 분해합니다.

```js
/function hangul:disassemble_combined_character {char:"ㅘ"}   # "ㅗㅏ"
/function hangul:disassemble_combined_character {char:"ㄺ"}   # "ㄹㄱ"
```

## hangul:disassemble_complete_character

```js
hangul:disassemble_complete_character { char: string }: {
    choseong: string,
    jungseong: string,
    jongseong: string,
}
```

완전한 한글 문자를 초성, 중성, 종성으로 분리합니다.

```js
/function hangul:disassemble_complete_character {char:"궤"}   # {choseong:"ㄱ", jungseong:"ㅜㅔ", jongseong:""}
/function hangul:disassemble_complete_character {char:"문"}   # {choseong:"ㅁ", jungseong:"ㅜ", jongseong:"ㄴ"}
/function hangul:disassemble_complete_character {char:"닭"}   # {choseong:"ㄷ", jungseong:"ㅏ", jongseong:"ㄹㄱ"}
```

## hangul:disassemble

```js
hangul:disassemble { str: string }: string[]
```

한글 문자열을 글자별로 초성/중성/종성 단위로 완전히 분리하여 배열로 출력합니다.

```js
/function hangul:disassemble {str:"한국"}   # ["ㅎ", "ㅏ", "ㄴ", "ㄱ", "ㅜ", "ㄱ"]
/function hangul:disassemble {str:"파도 소리"}   # ["ㅍ", "ㅏ", "ㄷ", "ㅗ", " ", "ㅅ", "ㅗ", "ㄹ", "ㅣ"]
/function hangul:disassemble {str:"됢"}   # ["ㄷ", "ㅗ", "ㅣ", "ㄹ", "ㅁ"]
```

## hangul:josa

```js
hangul:josa {
    str: string
    josa:
        | "이/가"
        | "을/를"
        | "은/는"
        | "으로/로"
        | "와/과"
        | "이나/나"
        | "이란/란"
        | "아/야"
        | "이랑/랑"
        | "이에요/예요"
        | "으로서/로서"
        | "으로써/로써"
        | "으로부터/로부터"
        | "이라/라" 
}: string
```

한글 문자열에 적절한 조사를 붙여줍니다.

```js
/function hangul:josa {str:"두루미", josa:"은/는"}   # "두루미는"
/function hangul:josa {str:"수학 교사", josa:"으로서/로서"}   # "수학 교사로서"
/function hangul:josa {str:"플레이어 1", josa:"이/가"}   # "플레이어 1가"
```

## hangul:remove_last_character

```js
hangul:remove_last_character { str: string }: string
```

한글 문자열에서 가장 마지막 문자 하나를 제거합니다.

```js
/function hangul:remove_last_character {str:"안녕하세요"}   # "안녕하세ㅇ"
/function hangul:remove_last_character {str:"닭"}   # "달"
/function hangul:remove_last_character {str:"장화"}    # "장호"
```

# return API

`return`을 통해 값을 반환하는 함수입니다.

---

## hangul:can_be_choseong

```js
hangul:can_be_choseong { char: string }: bool
```

문자가 초성으로 위치할 수 있는 문자인지 검사합니다.

```js
/function hangul:can_be_choseong {char:"ㅁ"}   # 1
/function hangul:can_be_choseong {char:"ㅏ"}   # 0
/function hangul:can_be_choseong {char:"ㄹㄱ"}   # 0
```

## hangul:can_be_jungseong

```js
hangul:can_be_jungseong { char: string }: bool
```

문자가 중성으로 위치할 수 있는 문자인지 검사합니다.

```js
/function hangul:can_be_jungseong {char:"ㅔ"}   # 1
/function hangul:can_be_jungseong {char:"ㅜㅔ"}   # 1
/function hangul:can_be_jungseong {char:"ㅁ"}   # 0
```

## hangul:can_be_jongseong

```js
hangul:can_be_jongseong { char: string }: bool
```

문자가 중성으로 위치할 수 있는 문자인지 검사합니다.

```js
/function hangul:can_be_jongseong {char:"ㅁ"}   # 1
/function hangul:can_be_jongseong {char:"ㄹㄱ"}   # 1
/function hangul:can_be_jongseong {char:"ㅔ"}   # 0
```

## hangul:has_batchim

```js
hangul:has_batchim { str: string }: bool
```

마지막 글자에 받침이 있는지 검사합니다.

```js
/function hangul:can_be_jongseong {str:"레몬"}   # 1
/function hangul:can_be_jongseong {str:"만두"}   # 0
/function hangul:can_be_jongseong {str:"abc"}  # 0
```

## hangul:has_single_batchim

```js
hangul:has_batchim { str: string }: bool
```

마지막 글자에 단받침이 있는지 검사합니다.

```js
/function hangul:can_be_jongseong {str:"레몬"}   # 1
/function hangul:can_be_jongseong {str:"만두"}  # 0
/function hangul:can_be_jongseong {str:"생닭"}   # 0
```