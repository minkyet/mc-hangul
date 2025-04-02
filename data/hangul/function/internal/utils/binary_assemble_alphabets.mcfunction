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
$execute store success score #can_be_jungseong hangul run \
    function hangul:can_be_jungseong {char: "$(source_char)$(next_char)"}

$execute if score #can_be_jungseong hangul matches 1 run \
    return run function hangul:combine_vowels {vowel1:"$(source_char)", vowel2:"$(next_char)"}

## consonant + vowel
$execute store success score #can_be_jungseong hangul run \
    function hangul:can_be_jungseong {char: "$(next_char)"}
$execute store success score #is_consonant_source hangul run \
    function hangul:can_be_choseong {char: "$(source_char)"}
$execute if score #is_consonant_source hangul matches 1 if score #can_be_jungseong hangul matches 1 run \
    return run function hangul:combine_character {choseong:"$(source_char)", jungseong:"$(next_char)", options:{}}

## join
$data modify storage hangul: out set value "$(source_char)$(next_char)"