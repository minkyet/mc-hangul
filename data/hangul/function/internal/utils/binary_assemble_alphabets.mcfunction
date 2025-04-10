#> hangul:internal/utils/binary_assemble_alphabets
#
## 한글 자모 2개를 합성합니다
#
# @macro
#   source_char: str
#   next_char: str
# @output
#   storage hangul: out: string
# @example
#   /function THIS {source_char:"ㄱ", next_char:"ㅏ"}   # 가
#   /function THIS {source_char:"ㅗ", next_char:"ㅏ"}   # ㅘ
#   /function THIS {source_char:"ㅜ", next_char:"ㅠ"}   # ㅜㅠ

## vowel + vowel
$data modify storage hangul:return input.can_be_jungseong set value {char: "$(source_char)$(next_char)"}
$execute if function hangul:internal/return/can_be_jungseong run \
    return run function hangul:combine_vowels {vowel1:"$(source_char)", vowel2:"$(next_char)"}

## consonant + vowel
$data modify storage hangul:return input.can_be_choseong set value {char: "$(source_char)"}
$data modify storage hangul:return input.can_be_jungseong set value {char: "$(next_char)"}
$execute \
    if function hangul:internal/return/can_be_choseong \
    if function hangul:internal/return/can_be_jungseong run \
    return run function hangul:combine_character {choseong:"$(source_char)", jungseong:"$(next_char)", options:{}}

## join
$data modify storage hangul: out set value "$(source_char)$(next_char)"