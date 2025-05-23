#> hangul:has_single_batchim
#
## 마지막 글자에 단받침이 있는지 검사합니다
#
# @macro
#   str: string
# @return
# @api
# @example
#   /function THIS {str:"레몬"}     # 1
#   /function THIS {str:"만두"}     # 0
#   /function THIS {str:"생닭"}      # 0

## get last char
$data modify storage hangul:temp input.str set value "$(str)"
data modify storage hangul:temp input.char set string storage hangul:temp input.str -1

## char code
execute store result score #code hangul run \
    function hangul:internal/utils/get_char_code with storage hangul:temp input
execute if score #code hangul matches 0 run return fail

## #batchim_code = (#code - #hangul_start) % #jongseong;
scoreboard players operation #batchim_code hangul = #code hangul
scoreboard players operation #batchim_code hangul -= #hangul_start hangul.const
scoreboard players operation #batchim_code hangul %= #jongseong hangul.const

## return batchim_code
execute if score #batchim_code hangul matches 0 run return fail
execute if score #batchim_code hangul matches 3 run return fail
execute if score #batchim_code hangul matches 5..6 run return fail
execute if score #batchim_code hangul matches 9..15 run return fail
execute if score #batchim_code hangul matches 18 run return fail
return run scoreboard players get #batchim_code hangul
