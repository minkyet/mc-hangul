#> hangul:combine_character
#
## 초성, 중성, 종성을 받아 하나의 한글 문자를 반환합니다
#
# @macro
#   choseong: string
#   jungseong: string
#   options: {
#       jongseong?: string
#   }
# @output
#   storage hangul: out: string
# @api
# @example
#   /function THIS {choseong:"ㄱ", jungseong:"ㅏ", options:{jongseong:"ㅂㅅ"}}   # 값
#   /function THIS {choseong:"ㅌ", jungseong:"ㅗ", options:{}}   # 토

data modify storage hangul: out set value "[HangulError]: 적절한 문자 조합이 아닙니다."

## set input
$data modify storage hangul:temp combine_character set value {choseong:"$(choseong)", jungseong:"$(jungseong)"}
$data modify storage hangul:temp combine_character.options set value $(options)
data modify storage hangul:temp combine_character.jongseong set from storage hangul:temp combine_character.options.jongseong
execute unless data storage hangul:temp combine_character.jongseong run \
    data modify storage hangul:temp combine_character.jongseong set value ""


## check type
data remove storage hangul:return input
data modify storage hangul:return input.can_be_choseong.char set from storage hangul:temp combine_character.choseong
execute unless function hangul:internal/return/can_be_choseong run return fail
data modify storage hangul:return input.can_be_jungseong.char set from storage hangul:temp combine_character.jungseong
execute unless function hangul:internal/return/can_be_jungseong run return fail
data modify storage hangul:return input.can_be_jongseong.char set from storage hangul:temp combine_character.jongseong
execute unless function hangul:internal/return/can_be_jongseong run return fail

## code calculation
# get index
function hangul:internal/combine_character/get_index with storage hangul:temp combine_character

# #consonant = #choseong_index * #jungseong * #jongseong
scoreboard players operation #consonant hangul = #choseong_index hangul
scoreboard players operation #consonant hangul *= #jungseong hangul.const
scoreboard players operation #consonant hangul *= #jongseong hangul.const

# #vowel = #jungseong_index * #jongseong
scoreboard players operation #vowel hangul = #jungseong_index hangul
scoreboard players operation #vowel hangul *= #jongseong hangul.const

# #code = #consonant + #vowel + #jongseong_index
scoreboard players operation #code hangul = #consonant hangul
scoreboard players operation #code hangul += #vowel hangul
scoreboard players operation #code hangul += #jongseong_index hangul

## code to hangul character
execute store result storage hangul:temp combine_character.index int 1 run \
    scoreboard players get #code hangul
function hangul:internal/utils/get_char with storage hangul:temp combine_character

data remove storage hangul:temp combine_character