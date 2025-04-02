#> hangul:internal/utils/binary_assemble/return_join
#
## remove temp storage + return binary_join(rest, binary_join(last_char, next_char))
#
# @within hangul:internal/utils/binary_assemble
# @input
#   storage hangul:temp binary_assemble.rest: string
#   storage hangul:temp binary_assemble.last_char: string
#   storage hangul:temp binary_assemble.next_char: string
# @output
#   storage hangul: out: string

# last_next = binary_join(last_char, next_char)
data modify storage hangul:temp input.str1 set from storage hangul:temp binary_assemble.last_char
data modify storage hangul:temp input.str2 set from storage hangul:temp binary_assemble.next_char
function hangul:internal/utils/binary_join with storage hangul:temp input
data modify storage hangul:temp binary_assemble.last_next set from storage hangul: out

# out = binary_join(rest, last_next)
data modify storage hangul:temp input.str1 set from storage hangul:temp binary_assemble.rest
data modify storage hangul:temp input.str2 set from storage hangul:temp binary_assemble.last_next
function hangul:internal/utils/binary_join with storage hangul:temp input

# remove temp storage
data remove storage hangul:temp binary_assemble