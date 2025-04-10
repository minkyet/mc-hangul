#> hangul:internal/utils/binary_assemble_characters/return_fc_lj_n
#
## return combine_character(fixed_consonant, last_jamo, next_char)
#
# @within hangul:internal/utils/binary_assemble_characters
# @input
#   storage hangul:temp binary_assemble_characters.fixed_consonant: string
#   storage hangul:temp binary_assemble_characters.last_jamo: string
#   storage hangul:temp binary_assemble_characters.next_char: string
# @output
#   storage hangul: out: string

data modify storage hangul:temp input.choseong set from storage hangul:temp binary_assemble_characters.fixed_consonant
data modify storage hangul:temp input.jungseong set from storage hangul:temp binary_assemble_characters.last_jamo
data modify storage hangul:temp input.options.jongseong set from storage hangul:temp binary_assemble_characters.next_char
function hangul:combine_character with storage hangul:temp input
data remove storage hangul:temp binary_assemble_characters