#> hangul:internal/assemble/return_blank
#
## return ""
#
# @within hangul:assemble
# @output
#   storage hangul: out: ""

data modify storage hangul: out set value ""
data remove storage hangul:temp assemble