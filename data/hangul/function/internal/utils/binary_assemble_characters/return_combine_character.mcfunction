#> hangul:internal/utils/binary_assemble_characters/return_combine_character
#
## remove temp storage + return function combine_character
#
# @within hangul:internal/utils/binary_assemble_characters
# @macro
#   choseong: string
#   jungseong: string
#   options: {
#       jongseong?: string
#   }
# @output
#   storage hangul: out: string

data remove storage hangul:temp binary_assemble_characters
$return run function hangul:combine_character {choseong:"$(choseong)", jungseong:"$(jungseong)", options:$(options)}