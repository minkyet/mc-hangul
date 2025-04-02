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

# #is_hangul_character_last_char = is_hangul_character(last_char)
data modify storage hangul:temp input.char set from storage hangul:temp binary_assemble.last_char
execute store success score #is_hangul_character_last_char hangul run \
    function hangul:internal/utils/is_hangul_character with storage hangul:temp input
# #is_hangul_alphabet_last_char = is_hangul_alphabet(last_char)
data modify storage hangul:temp input.char set from storage hangul:temp binary_assemble.last_char
execute store success score #is_hangul_alphabet_last_char hangul run \
    function hangul:internal/utils/is_hangul_alphabet with storage hangul:temp input
# #is_hangul_alphabet_next_char = is_hangul_alphabet(next_char)
data modify storage hangul:temp input.char set from storage hangul:temp binary_assemble.next_char
execute store success score #is_hangul_alphabet_next_char hangul run \
    function hangul:internal/utils/is_hangul_alphabet with storage hangul:temp input

# unless #is_hangul_alphabet_next_char: return rest_last_next
execute if score #is_hangul_alphabet_next_char hangul matches 0 run \
    return run function hangul:internal/utils/binary_assemble/return_join
# unless #is_hangul_character_last_char && #is_hangul_alphabet_last_char: return rest_last_next
execute if score #is_hangul_character_last_char hangul matches 0 if score #is_hangul_alphabet_last_char hangul matches 0 run \
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