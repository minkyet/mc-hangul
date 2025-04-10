#> hangul:internal/remove_last_character/remove_last_alphabet/combine_f_ml
#
## return combine_character(first, 'middle+last')
#
# @within hangul:internal/remove_last_character/remove_last_alphabet/3_or_less
# @input
#   storage hangul:temp remove_last_alphabet.first: string
#   storage hangul:temp remove_last_alphabet.middle: string
#   storage hangul:temp remove_last_alphabet.last: string
# @output
#   storage hangul: out: string

## join middle + last
data modify storage hangul:temp input.str1 set from \
    storage hangul:temp remove_last_alphabet.middle
data modify storage hangul:temp input.str2 set from \
    storage hangul:temp remove_last_alphabet.last
function hangul:internal/utils/binary_join with storage hangul:temp input

## combine_character
data modify storage hangul:temp input.choseong set from \
    storage hangul:temp remove_last_alphabet.first
data modify storage hangul:temp input.jungseong set from storage hangul: out
data modify storage hangul:temp input.options set value {}
function hangul:combine_character with storage hangul:temp input

# data remove storage hangul:temp remove_last_alphabet