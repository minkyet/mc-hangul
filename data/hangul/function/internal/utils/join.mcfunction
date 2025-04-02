#> hangul:internal/utils/join
#
## 배열에 담긴 문자열을 조인합니다
#
# @macro
#   array: string[]
# @output
#   storage hangul: out: string
# @example
#   /function THIS {array:["a", "bc", " d"]}        # abc d

$data modify storage hangul:temp join set value {array:$(array), result:""}

function hangul:internal/utils/join/loop

data modify storage hangul: out set from storage hangul:temp join.result

data remove storage hangul:temp join