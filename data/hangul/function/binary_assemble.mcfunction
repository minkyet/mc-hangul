#> hangul:binary_assemble
#
## 한글 문장과 한글 문자 하나를 합성합니다
#
# @macro
#   source: str
#   next_char: str
# @output
#   storage hangul: out: string
# @api
# @example
#   /function THIS {source:"나", next_char:"ㄴ"}           # 난
#   /function THIS {source:"나는 따", next_char:"ㄹ"}       # 나는 딸
#   /function THIS {source:"나는 딸", next_char:"ㄱ"}       # 나는 딹
#   /function THIS {source:"나는 딹", next_char:"ㅣ"}       # 나는 딸기

$data modify storage hangul:temp binary_assemble set value {source:"$(source)", next_char:"$(next_char)"}

# splited_source = split(source)
$function hangul:internal/utils/split {str:"$(source)"}
data modify storage hangul:temp binary_assemble.splited_source set from storage hangul: out

## unless splited_source[0]: return next_char
execute unless data storage hangul:temp binary_assemble.splited_source[0] run \
    data modify storage hangul: out set from storage hangul:temp binary_assemble.next_char
execute unless data storage hangul:temp binary_assemble.splited_source[0] run \
    return run data remove storage hangul:temp binary_assemble

# rest = source[0:-1]
data modify storage hangul:temp binary_assemble.rest set string storage hangul:temp binary_assemble.source 0 -1
# last_char = exclude_last_element(splited_source).last
data modify storage hangul:temp input.array set from storage hangul:temp binary_assemble.splited_source
function hangul:internal/utils/exclude_last_element with storage hangul:temp input
data modify storage hangul:temp binary_assemble.last_char set from storage hangul: out.last

# unless is_hangul_alphabet(next_char): return rest_last_next
data remove storage hangul:return input
data modify storage hangul:return input.is_hangul_alphabet.char set from storage hangul:temp binary_assemble.next_char
execute unless function hangul:internal/return/is_hangul_alphabet run \
    return run function hangul:internal/utils/binary_assemble/return_join
# unless is_hangul_character(last_char) && is_hangul_alphabet(last_char): return rest_last_next
data modify storage hangul:return input.is_hangul_alphabet.char set from storage hangul:temp binary_assemble.last_char
data modify storage hangul:return input.is_hangul_character.char set from storage hangul:temp binary_assemble.last_char
execute \
    unless function hangul:internal/return/is_hangul_character \
    unless function hangul:internal/return/is_hangul_alphabet run \
    return run function hangul:internal/utils/binary_assemble/return_join

# else : return binary_join(rest, binary_assemble_characters(last_char, next_char))
data modify storage hangul:temp input.source set from storage hangul:temp binary_assemble.last_char
data modify storage hangul:temp input.next_char set from storage hangul:temp binary_assemble.next_char
function hangul:internal/utils/binary_assemble_characters with storage hangul:temp input
data modify storage hangul:temp input.str1 set from storage hangul:temp binary_assemble.rest
data modify storage hangul:temp input.str2 set from storage hangul: out
function hangul:internal/utils/binary_join with storage hangul:temp input

# remove temp storage
data remove storage hangul:temp binary_assemble