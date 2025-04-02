#> hangul:internal/utils/link_characters
#
## 연음 법칙을 적용하여 두 개의 한글 문자를 연결합니다
#
# @macro
#   source: string
#   next_char: string
# @output
#   storage hangul: out: string
# @example
#   /function THIS {source:"받", next_char:"ㅏ"}   # 바다
#   /function THIS {source:"밙", next_char:"ㅣ"}   # 반지

$data modify storage hangul:temp link_characters set value {source:"$(source)", next_char:"$(next_char)"}

## if is_hangul_alphabet(next_char) == 0: return binary_join(source, next_char)
data modify storage hangul:temp input.char set from storage hangul:temp link_characters.next_char
execute store success score #is_hangul_alphabet hangul run \
    function hangul:internal/utils/is_hangul_alphabet with storage hangul:temp input
execute if score #is_hangul_alphabet hangul matches 0 run \
    data remove storage hangul:temp link_characters
$execute if score #is_hangul_alphabet hangul matches 0 run \
    return run function hangul:internal/utils/binary_join {str1:"$(source)", str2:"$(next_char)"}

## source_jamo = disassemble(source)
$function hangul:disassemble {str:"$(source)"}
data modify storage hangul:temp link_characters.source_jamo set from storage hangul: out

## last_jamo = execlude_last_element(source_jamo).last
data modify storage hangul:temp input.array set from \
    storage hangul:temp link_characters.source_jamo
function hangul:internal/utils/exclude_last_element with storage hangul:temp input
data modify storage hangul:temp link_characters.last_jamo set from storage hangul: out.last

## combined_next = combine_character(last_jamo, next_char)
data modify storage hangul:temp input.choseong set from \
    storage hangul:temp link_characters.last_jamo
data modify storage hangul:temp input.jungseong set from \
    storage hangul:temp link_characters.next_char
data modify storage hangul:temp input.options set value []
function hangul:combine_character with storage hangul:temp input
data modify storage hangul:temp link_characters.combined_next set from storage hangul: out

## source_removed_last_character = remove_last_character(source)
data modify storage hangul:temp input.str set from \
    storage hangul:temp link_characters.source
function hangul:remove_last_character with storage hangul:temp input
data modify storage hangul:temp link_characters.source_removed_last_character set from storage hangul: out

## return binary_join(source_removed_last_character, combined_next)
data modify storage hangul:temp input.str1 set from \
    storage hangul:temp link_characters.source_removed_last_character
data modify storage hangul:temp input.str2 set from \
    storage hangul:temp link_characters.combined_next
function hangul:internal/utils/binary_join with storage hangul:temp input

data remove storage hangul:temp link_characters
