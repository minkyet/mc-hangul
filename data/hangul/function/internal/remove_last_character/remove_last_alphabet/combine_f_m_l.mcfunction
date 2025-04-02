#> hangul:internal/remove_last_character/remove_last_alphabet/combine_f_m_l
#
## return combine_character(first, middle, last)
#
# @within hangul:internal/remove_last_character/remove_last_alphabet/3_or_less
# @input
#   storage hangul:temp remove_last_alphabet.first: string
#   storage hangul:temp remove_last_alphabet.middle: string
#   storage hangul:temp remove_last_alphabet.last: string
# @output
#   storage hangul: out: string

data modify storage hangul:temp input.choseong set from \
    storage hangul:temp remove_last_alphabet.first
data modify storage hangul:temp input.jungseong set from \
    storage hangul:temp remove_last_alphabet.middle
data modify storage hangul:temp input.options set value {}
data modify storage hangul:temp input.options.jongseong set from \
    storage hangul:temp remove_last_alphabet.last

function hangul:combine_character with storage hangul:temp input

data remove storage hangul:temp remove_last_alphabet