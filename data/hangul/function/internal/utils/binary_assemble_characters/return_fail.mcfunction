#> hangul:internal/utils/binary_assemble_characters/return_fail
#
## remove temp storage + return fail
#
# @within hangul:internal/utils/binary_assemble_characters
# @output
#   storage hangul: out: string

data remove storage hangul:temp binary_assemble_characters
data modify storage hangul: out set value "[HangulError]: 잘못된 입력입니다."
return fail