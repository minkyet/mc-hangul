#> hangul:internal/utils/join/loop
#
## 배열의 첫 원소를 기존 문자열과 조인합니다
#
# @loop recursive
# @within hangul:internal/utils/join
# @input
#   storage hangul:temp join.result: string
#   storage hangul:temp join.array: string[]
# @output
#   storage hangul:temp join.result: string

data modify storage hangul:temp input.str1 set from storage hangul:temp join.result
data modify storage hangul:temp input.str2 set from storage hangul:temp join.array[0]
function hangul:internal/utils/binary_join with storage hangul:temp input

data modify storage hangul:temp join.result set from storage hangul: out
data remove storage hangul:temp join.array[0]

execute if data storage hangul:temp join.array[0] run \
    function hangul:internal/utils/join/loop