#> hangul:internal/utils/split/loop
#
## 첫 문자를 스토리지에 넣습니다
#
# @loop recursive
# @within hangul:internal/utils/split
# @input
#   storage hangul:temp split.str: string
# @output
#   storage hangul:temp split.result: string[]

## append first character into result
data modify storage hangul:temp split.result append string storage hangul:temp split.str 0 1

## set substring
execute store success score #is_substring_remains hangul run \
    data modify storage hangul:temp split.str set string storage hangul:temp split.str 1
## loop until string empty
execute unless score #is_substring_remains hangul matches 0 run \
    function hangul:internal/utils/split/loop with storage hangul:temp input