#> hangul:internal/disassemble/append_combined_character
#
## 겹문자를 각각 배열에 추가합니다
#
# @within hangul:internal/disassemble/iteration
# @input
#   storage hangul:temp disassemble.first_char: string
# @output
#   storage hangul:temp disassemble.result: string[]

data modify storage hangul:temp input.char set from storage hangul:temp disassemble.first_char
function hangul:disassemble_combined_character with storage hangul:temp input
data modify storage hangul:temp disassemble.result append string storage hangul: out 0 1
data modify storage hangul:temp disassemble.result append string storage hangul: out 1 2