#> hangul:internal/utils/binary_assemble_characters/return_fc_fv_l
#
## return combine_character(fixed_consonant, fixed_vowel, last_next)
#
# @within hangul:internal/utils/binary_assemble_characters
# @input
#   storage hangul:temp binary_assemble_characters.fixed_consonant: string
#   storage hangul:temp binary_assemble_characters.fixed_vowel: string
#   storage hangul:temp binary_assemble_characters.last_next: string
# @output
#   storage hangul: out: string

data modify storage hangul:temp input.choseong set from storage hangul:temp binary_assemble_characters.fixed_consonant
data modify storage hangul:temp input.jungseong set from storage hangul:temp binary_assemble_characters.fixed_vowel
data modify storage hangul:temp input.options.jongseong set from storage hangul:temp binary_assemble_characters.last_next
function hangul:combine_character with storage hangul:temp input
data remove storage hangul:temp binary_assemble_characters