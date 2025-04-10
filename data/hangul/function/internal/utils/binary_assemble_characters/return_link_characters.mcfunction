#> hangul:internal/utils/binary_assemble_characters/return_link_characters
#
## remove temp storage + return function link_characters
#
# @within hangul:internal/utils/binary_assemble_characters
# @input
#   storage hangul:temp binary_assemble_characters.source: str
#   storage hangul:temp binary_assemble_characters.next_char: str
# @output
#   storage hangul: out: string

data modify storage hangul:temp input.source set from storage hangul:temp binary_assemble_characters.source
data modify storage hangul:temp input.next_char set from storage hangul:temp binary_assemble_characters.next_char
function hangul:internal/utils/link_characters with storage hangul:temp input

data remove storage hangul:temp binary_assemble_characters