#> hangul:internal/utils/binary_assemble_characters/return_link_characters
#
## remove temp storage + return function link_characters
#
# @within hangul:internal/utils/binary_assemble_characters
# @macro
#   source: str
#   next_char: str
# @output
#   storage hangul: out: string

data remove storage hangul:temp binary_assemble_characters
$return run function hangul:internal/utils/link_characters {source:"$(source)", next_char:"$(next_char)"}