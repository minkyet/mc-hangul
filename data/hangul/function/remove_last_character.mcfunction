#> hangul:remove_last_character
#
## 한글 문자열에서 가장 마지막 문자 하나를 제거합니다
#
# @macro
#   str: string
# @output
#   storage hangul: out: string
# @api
# @example
#   /function THIS {str:"안녕하세요"}   # 안녕하세ㅇ
#   /function THIS {str:"만둣국"}   # 만둣구
#   /function THIS {str:"닭"}   # 달
#   /function THIS {str:"장화"}   # 장호

$data modify storage hangul:temp remove_last_character set value {str:"$(str)"}

## get last_character
data modify storage hangul:temp remove_last_character.last_character set string \
    storage hangul:temp remove_last_character.str -1

## if last_character == null: return ""
execute unless data storage hangul:temp remove_last_character.last_character run \
    data modify storage hangul: out set value ""
execute unless data storage hangul:temp remove_last_character.last_character run return 1

## result = remove_last_alphabet(last_character)
data modify storage hangul:temp input.char set from \
    storage hangul:temp remove_last_character.last_character
function hangul:internal/remove_last_character/remove_last_alphabet with storage hangul:temp input
data modify storage hangul:temp remove_last_character.result set from storage hangul: out

## return binary_join(str[0:-1], result)
data modify storage hangul:temp input.str1 set string \
    storage hangul:temp remove_last_character.str 0 -1
data modify storage hangul:temp input.str2 set from \
    storage hangul:temp remove_last_character.result
function hangul:internal/utils/binary_join with storage hangul:temp input

data remove storage hangul:temp remove_last_character