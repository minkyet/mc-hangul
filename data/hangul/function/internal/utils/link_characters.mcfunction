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
data modify storage hangul:return input.is_hangul_alphabet.char set from storage hangul:temp link_characters.next_char
execute unless function hangul:internal/return/is_hangul_alphabet run \
    return run function hangul:internal/utils/link_characters/return_join

## source_jamo = ...disassemble_complete_character(source)

$function hangul:disassemble_complete_character {char:"$(source)"}
data modify storage hangul:temp link_characters.source_jamo set value []
data modify storage hangul:temp link_characters.source_jamo append from storage hangul: out.choseong
data modify storage hangul:temp link_characters.source_jamo append string storage hangul: out.jungseong 0 1
data modify storage hangul:temp link_characters.source_jamo append string storage hangul: out.jungseong 1 2
data modify storage hangul:temp link_characters.source_jamo append string storage hangul: out.jongseong 0 1
data modify storage hangul:temp link_characters.source_jamo append string storage hangul: out.jongseong 1 2

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
