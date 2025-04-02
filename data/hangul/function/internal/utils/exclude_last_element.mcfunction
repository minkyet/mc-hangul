#> hangul:internal/utils/exclude_last_element
#
## 문자열을 나머지 글자와 마지막 글자의 배열로 분리하여 반환합니다
#
# @macro
#   array: string[]
# @output
#   storage hangul: out: {
#       rest: string[],
#       last: string
#   }
# @example
#   /function THIS {array:["가", "나", "다"]}       # {rest:["가", "나"], last:"다"}
#   /function THIS {array:["ㄷ", "ㅏ", "ㄹㄱ"]}     # {rest:["ㄷ", "ㅏ"], last:"ㄹㄱ"}

data modify storage hangul: out set value {}
$data modify storage hangul:temp exclude_last_element set value {array:$(array)}

data modify storage hangul: out.last set from storage hangul:temp exclude_last_element.array[-1]
data modify storage hangul: out.rest set from storage hangul:temp exclude_last_element.array
data remove storage hangul: out.rest[-1]

data remove storage hangul:temp exclude_last_element