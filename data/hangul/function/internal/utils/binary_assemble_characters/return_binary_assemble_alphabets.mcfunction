#> hangul:internal/utils/binary_assemble_characters/return_binary_assemble_alphabets
#
## remove temp storage + return function binary_assemble_alphabets
#
# @within hangul:internal/utils/binary_assemble_characters
# @macro
#   source_char: str
#   next_char: str
# @output
#   storage hangul: out: string

data remove storage hangul:temp binary_assemble_characters
$return run function hangul:internal/utils/binary_assemble_alphabets {source_char:"$(source_char)", next_char:"$(next_char)"}