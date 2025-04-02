#> hangul:internal/utils/binary_join
#
## 두 문자열을 붙입니다
#
# @macro
#   str1: string
#   str2: string
# @output
#   storage hangul: out: string

$data modify storage hangul: out set value "$(str1)$(str2)"