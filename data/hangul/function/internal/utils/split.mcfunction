#> hangul:internal/utils/split
#
## 문자열 내 모든 문자를 한 글자씩 분리하여 배열로 만듭니다
#
# @macro
#   str: string
# @output
#   storage hangul: out: string[]
# @example
#   /function THIS {str:"abc d"}        # ["a", "b", "c", " ", "d"]

## set result array
$data modify storage hangul:temp split set value {str:"$(str)", result:[]}

## split
function hangul:internal/utils/split/loop

## set output
data modify storage hangul: out set from storage hangul:temp split.result

# remove temp storage
data remove storage hangul:temp split