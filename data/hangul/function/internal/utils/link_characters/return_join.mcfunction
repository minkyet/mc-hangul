#> hangul:internal/utils/link_characters/return_join
#
## return binary_join
#
# @within hangul:internal/utils/link_characters
# @input
#   storage hangul:temp link_characters.source: string
#   storage hangul:temp link_characters.next_char: string
# @output
#   storage hangul: out

data modify storage hangul:temp input.str1 set from storage hangul:temp link_characters.source
data modify storage hangul:temp input.str2 set from storage hangul:temp link_characters.next_character
function hangul:internal/utils/binary_join with storage hangul:temp input

data remove storage hangul:temp link_characters