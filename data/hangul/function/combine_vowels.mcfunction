#> hangul:combine_vowels
#
## 두 모음을 받아 합성하여 겹모음을 생성합니다
#
# @macro
#   vowel1: string
#   vowel2: string
# @output
#   storage hangul: out: string
# @api
# @example
#   /function THIS {vowel1:"ㅗ", vowel2:"ㅏ"}   # ㅘ
#   /function THIS {vowel1:"ㅗ", vowel2:"ㅐ"}   # ㅙ
#   /function THIS {vowel1:"ㅗ", vowel2:"ㅛ"}   # ㅗㅛ

$execute store success score #combine_vowels hangul run \
    data modify storage hangul: out set from storage hangul:const jungseong[{value:"$(vowel1)$(vowel2)"}].combined

$execute if score #combine_vowels hangul matches 0 run \
    data modify storage hangul: out set value "$(vowel1)$(vowel2)"
