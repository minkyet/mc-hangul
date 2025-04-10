#> hangul:internal/remove_last_character/remove_last_alphabet/return_blank
#
## return ""
#
# @within hangul:internal/remove_last_character/remove_last_alphabet
# @output
#   storage hangul: out: string

data remove storage hangul:temp remove_last_alphabet
return run data modify storage hangul: out set value ""