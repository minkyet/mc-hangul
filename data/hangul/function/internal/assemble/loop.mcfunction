#> hangul:internal/assemble/loop
#
## 기존 문자열과 새 문자를 결합합니다
#
# @within hangul:assemble
# @loop recursion
# @input
#   storage hangul:temp assemble.result: string
#   storage hangul:temp assemble.disassembled: string[]
# @output
#   storage hangul:temp assemble.result: string

## get next
data modify storage hangul:temp assemble.next set from storage hangul:temp assemble.disassembled[0]
data remove storage hangul:temp assemble.disassembled[0]

## result = binary_assemble(result, next)
data modify storage hangul:temp input.source set from storage hangul:temp assemble.result
data modify storage hangul:temp input.next_char set from storage hangul:temp assemble.next
function hangul:binary_assemble with storage hangul:temp input
data modify storage hangul:temp assemble.result set from storage hangul: out

## loop
execute if data storage hangul:temp assemble.disassembled[0] run \
    function hangul:internal/assemble/loop