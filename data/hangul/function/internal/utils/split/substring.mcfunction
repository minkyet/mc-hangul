#> hangul:internal/utils/split/substring
#
## 문자열의 첫 문자을 제외한 나머지 문자를 반환합니다
#
# @within hangul:internal/utils/split
# @macro
#   str: string
# @output
#   storage hangul: out: string[]

$data modify storage hangul:temp input.str set value "$(str)"

return run \
    data modify storage hangul: out set string storage hangul:temp input.str 1