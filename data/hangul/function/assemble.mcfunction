#> hangul:assemble
#
## 배열에 담긴 한글 문장과 문자를 한글 규칙에 맞게 합성합니다
#
# @macro
#   array: string[]
# @output
#   storage hangul: out: string
# @api
# @example
#   /function THIS {array:["메밀꽃", " ", "피ㄹ", " ㅁ", "ㅜ려", "ㅂ"]}     # 메밀꽃 필 무렵
#   /function THIS {array:["메밀꽃", " ", "필 ", "무렵"]}                   # 메밀꽃 필 무렵
#   /function THIS {array:["ㅁ", "ㅔ", "ㅁ", "ㅣ", "ㄹ", "ㄲ", "ㅗ", "ㅊ"]} # 메밀꽃

$data modify storage hangul:temp assemble set value {array:$(array), result:""}
execute unless data storage hangul:temp assemble.array[0] run \
    return run function hangul:internal/assemble/return_blank

# str = join(array)
data modify storage hangul:temp input.array set from storage hangul:temp assemble.array
function hangul:internal/utils/join with storage hangul:temp input
data modify storage hangul:temp assemble.str set from storage hangul: out
# disassembled = disassemble(str)
data modify storage hangul:temp input.str set from storage hangul:temp assemble.str
function hangul:disassemble with storage hangul:temp input
data modify storage hangul:temp assemble.disassembled set from storage hangul: out

## result = disassembled.reduce(binaryAssemble)
function hangul:internal/assemble/loop
# return result
data modify storage hangul: out set from storage hangul:temp assemble.result

data remove storage hangul:temp assemble