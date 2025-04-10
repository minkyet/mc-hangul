#> hangul:internal/remove_last_character/remove_last_alphabet
#
## 문자 하나의 마지막 음소를 제거합니다
#
# @within hangul:remove_last_character
# @macro
#   char: string
# @output
#   storage hangul: out: string
# @example
#   /function THIS {char:"구"}      # ㄱ
#   /function THIS {char:"밤"}      # 바
#   /function THIS {char:"웳"}      # 웰
#   /function THIS {char:"ㅞ"}      # ㅜ
#   /function THIS {char:"ㄼ"}      # ㄹ

data modify storage hangul:temp remove_last_alphabet set value {}

## disassembled_last_character = disassemble(last_character)
$function hangul:disassemble {str:"$(char)"}
data modify storage hangul:temp remove_last_alphabet.disassembled_last_character set from storage hangul: out

## if last character not hangul: return ""
data remove storage hangul:return input
data modify storage hangul:return input.is_hangul_alphabet.char set from \
    storage hangul:temp remove_last_alphabet.disassembled_last_character[0]
execute unless function hangul:internal/return/is_hangul_alphabet run \
    data remove storage hangul:temp remove_last_alphabet
execute unless function hangul:internal/return/is_hangul_alphabet run \
    return run function hangul:internal/remove_last_character/remove_last_alphabet/return_blank

## last_character_without_last_alphabet = exclude_last_element(disassembled_last_character).rest
data modify storage hangul:temp input.array set from storage hangul:temp remove_last_alphabet.disassembled_last_character
function hangul:internal/utils/exclude_last_element with storage hangul:temp input
data modify storage hangul:temp remove_last_alphabet.last_character_without_last_alphabet set from storage hangul: out.rest

## #length = length(last_character_without_last_alphabet)
execute store result score #length hangul run \
    data get storage hangul:temp remove_last_alphabet.last_character_without_last_alphabet

## if #length == 0: return ""
execute if score #length hangul matches 0 run \
    data remove storage hangul:temp remove_last_alphabet
execute if score #length hangul matches 0 run \
    return run data modify storage hangul: out set value ""

## if #length <= 3: return 3_or_less
execute if score #length hangul matches ..3 run \
    return run function hangul:internal/remove_last_character/remove_last_alphabet/3_or_less

## else: 
#   first = last_character_without_last_alphabet[0]
data modify storage hangul:temp remove_last_alphabet.first set from \
    storage hangul:temp remove_last_alphabet.last_character_without_last_alphabet[0]
#   first_jungseong = last_character_without_last_alphabet[1]
data modify storage hangul:temp remove_last_alphabet.first_jungseong set from \
    storage hangul:temp remove_last_alphabet.last_character_without_last_alphabet[1]
#   second_jungseong = last_character_without_last_alphabet[2]
data modify storage hangul:temp remove_last_alphabet.second_jungseong set from \
    storage hangul:temp remove_last_alphabet.last_character_without_last_alphabet[2]
#   first_jongseong = last_character_without_last_alphabet[3]
data modify storage hangul:temp remove_last_alphabet.first_jongseong set from \
    storage hangul:temp remove_last_alphabet.last_character_without_last_alphabet[3]

#   join first_jungseong + second_jungseong
data modify storage hangul:temp input.str1 set from \
    storage hangul:temp remove_last_alphabet.first_jungseong
data modify storage hangul:temp input.str2 set from \
    storage hangul:temp remove_last_alphabet.second_jungseong
function hangul:internal/utils/binary_join with storage hangul:temp input

#   return combine_character(first, 'first_jungseong+second_jungseong', first_jongseong)
data modify storage hangul:temp input.choseong set from \
    storage hangul:temp remove_last_alphabet.first
data modify storage hangul:temp input.jungseong set from \
    storage hangul: out
data modify storage hangul:temp input.options.jongseong set from \
    storage hangul:temp remove_last_alphabet.first_jongseong
function hangul:combine_character with storage hangul:temp input

data remove storage hangul:temp remove_last_alphabet