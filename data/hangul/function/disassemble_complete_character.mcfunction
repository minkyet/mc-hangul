#> hangul:disassemble_complete_character
#
## 완전한 한글 문자를 초성, 중성, 종성으로 분리합니다
#
# @macro
#   char: string
# @output
#   storage hangul: out: {
#       choseong: string,
#       jungseong: string,
#       jongseong: string,
#   }
# @api
# @example
#   /function THIS {char:"궤"}      # {choseong:"ㄱ", jungseong:"ㅜㅔ", jongseong:""}
#   /function THIS {char:"문"}      # {choseong:"ㅁ", jungseong:"ㅜ", jongseong:"ㄴ"}
#   /function THIS {char:"닭"}      # {choseong:"ㄷ", jungseong:"ㅏ", jongseong:"ㄹㄱ"}

data modify storage hangul: out set value "[HangulError]: 완성형 한글이 아닙니다."

## char code
$execute store result score #code hangul run \
    function hangul:internal/utils/get_char_code {char: "$(char)"}
execute if score #code hangul matches 0 run return fail

## diasssamble calculation
# #hangul_code = #code - #hangul_start
scoreboard players operation #hangul_code hangul = #code hangul
scoreboard players operation #hangul_code hangul -= #hangul_start hangul.const

# #jongseong_index = #hangul_code % #jongseong
scoreboard players operation #jongseong_index hangul = #hangul_code hangul
scoreboard players operation #jongseong_index hangul %= #jongseong hangul.const

# #jungseong_index = ((#hangul_code - #jongseong_index) / #jongseong) % #jungseong
scoreboard players operation #jungseong_index hangul = #hangul_code hangul
scoreboard players operation #jungseong_index hangul -= #jongseong_index hangul
scoreboard players operation #jungseong_index hangul /= #jongseong hangul.const
scoreboard players operation #jungseong_index hangul %= #jungseong hangul.const

# #choseong_index = (#hangul_code - #jongseong_index) / #jongseong / #jungseong
scoreboard players operation #choseong_index hangul = #hangul_code hangul
scoreboard players operation #choseong_index hangul -= #jongseong_index hangul
scoreboard players operation #choseong_index hangul /= #jongseong hangul.const
scoreboard players operation #choseong_index hangul /= #jungseong hangul.const

## set input
execute store result storage hangul:temp input.choseong_index int 1 run \
    scoreboard players get #choseong_index hangul
execute store result storage hangul:temp input.jungseong_index int 1 run \
    scoreboard players get #jungseong_index hangul
execute store result storage hangul:temp input.jongseong_index int 1 run \
    scoreboard players get #jongseong_index hangul

## get char from index
function hangul:internal/disassemble_complete_character/ with storage hangul:temp input

return 1