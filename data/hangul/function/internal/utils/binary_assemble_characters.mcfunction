#> hangul:internal/utils/binary_assemble_characters
#
## 한글 문자 2개를 합성합니다
#
# @macro
#   source: string
#   next_char: string
# @output
#   storage hangul: out: string
# @example
#   /function THIS {source:"ㄱ", next_char:"ㅏ"}   # 가
#   /function THIS {source:"가", next_char:"ㅇ"}   # 강
#   /function THIS {source:"깎", next_char:"ㅏ"}   # 까까

$data modify storage hangul:temp binary_assemble_characters set value {source:"$(source)", next_char:"$(next_char)"}

# #is_hangul_character_source = is_hangul_character(source)
$execute store success score #is_hangul_character_source hangul run \
    function hangul:internal/utils/is_hangul_character {char:"$(source)"}
# #is_hangul_alphabet_source = is_hangul_alphabet(source)
$execute store success score #is_hangul_alphabet_source hangul run \
    function hangul:internal/utils/is_hangul_alphabet {char:"$(source)"}
# if !#is_hangul_character_source && !#is_hangul_alphabet_source: return fail
execute \
    if score #is_hangul_character_source hangul matches 0 \
    if score #is_hangul_alphabet_source hangul matches 0 run \
    return run function hangul:internal/utils/binary_assemble_characters/return_fail

# #is_hangul_alphabet_next_char = is_hangul_alphabet(next_char)
$execute store success score #is_hangul_alphabet_next_char hangul run \
    function hangul:internal/utils/is_hangul_alphabet {char:"$(next_char)"}
# if !#is_hangul_alphabet_next_char: return fail
execute if score #is_hangul_alphabet_next_char hangul matches 0 run \
    return run function hangul:internal/utils/binary_assemble_characters/return_fail

# source_jamos = disassemble(source)
$function hangul:disassemble {str:"$(source)"}
data modify storage hangul:temp binary_assemble_characters.source_jamos set from storage hangul: out

## ㄱ + ㅏ = 가 / ㅜ + ㅣ = ㅟ
# #length_source_jamos = length(source_jamos)
execute store result score #length_source_jamos hangul run \
    data get storage hangul:temp binary_assemble_characters.source_jamos
# if #length_source_jamos == 1: return binary_assemble_alphabets(source_jamos[0], next_char)
data modify storage hangul:temp input.source_char set from storage hangul:temp binary_assemble_characters.source_jamos[0]
data modify storage hangul:temp input.next_char set from storage hangul:temp binary_assemble_characters.next_char
execute if score #length_source_jamos hangul matches 1 run \
    return run function hangul:internal/utils/binary_assemble_characters/return_binary_assemble_alphabets with storage hangul:temp input

## 괒 + ㅏ = 과자
# rest_jamos = exclude_last_element(source_jamos).rest
data modify storage hangul:temp input.array set from storage hangul:temp binary_assemble_characters.source_jamos
function hangul:internal/utils/exclude_last_element with storage hangul:temp input
data modify storage hangul:temp binary_assemble_characters.rest_jamos set from storage hangul: out.rest
# last_jamo = exclude_last_element(source_jamos).last
data modify storage hangul:temp binary_assemble_characters.last_jamo set from storage hangul: out.last
# secondary_last_jamo = exclude_last_element(rest_jamos).last
data modify storage hangul:temp input.array set from storage hangul:temp binary_assemble_characters.rest_jamos
function hangul:internal/utils/exclude_last_element with storage hangul:temp input
data modify storage hangul:temp binary_assemble_characters.secondary_last_jamo set from storage hangul: out.last
# #can_be_choseong_last_jamo = can_be_choseong(last_jamo)
data modify storage hangul:temp input.char set from storage hangul:temp binary_assemble_characters.last_jamo
execute store success score #can_be_choseong_last_jamo hangul run \
    function hangul:can_be_choseong with storage hangul:temp input
# #can_be_jungseong_next_char = can_be_jungseong(next_char)
data modify storage hangul:temp input.char set from storage hangul:temp binary_assemble_characters.next_char
execute store success score #can_be_jungseong_next_char hangul run \
    function hangul:can_be_jungseong with storage hangul:temp input
# if #can_be_choseong_last_jamo && #can_be_jungseong_next_char: return link_characters(source, next_char)
data modify storage hangul:temp input.source set from storage hangul:temp binary_assemble_characters.source
data modify storage hangul:temp input.next_char set from storage hangul:temp binary_assemble_characters.next_char
execute if score #can_be_choseong_last_jamo hangul matches 1 if score #can_be_jungseong_next_char hangul matches 1 run \
    return run function hangul:internal/utils/binary_assemble_characters/return_link_characters with storage hangul:temp input

# fixed_consonant = rest_jamos[0]
data modify storage hangul:temp binary_assemble_characters.fixed_consonant set from storage hangul:temp binary_assemble_characters.rest_jamos[0]

## 고 + ㅏ = 과
# last_next = binary_join(last_jamo, next_char)
data modify storage hangul:temp input.str1 set from storage hangul:temp binary_assemble_characters.last_jamo
data modify storage hangul:temp input.str2 set from storage hangul:temp binary_assemble_characters.next_char
function hangul:internal/utils/binary_join with storage hangul:temp input
data modify storage hangul:temp binary_assemble_characters.last_next set from storage hangul: out
# #can_be_jungseong_last_next = can_be_jungseong(last_next)
data modify storage hangul:temp input.char set from storage hangul:temp binary_assemble_characters.last_next
execute store success score #can_be_jungseong_last_next hangul run \
    function hangul:can_be_jungseong with storage hangul:temp input
# if #can_be_jungseong_last_next: return combine_character(fixed_consonant, last_next, [])
data modify storage hangul:temp input.choseong set from storage hangul:temp binary_assemble_characters.fixed_consonant
data modify storage hangul:temp input.jungseong set from storage hangul:temp binary_assemble_characters.last_next
data modify storage hangul:temp input.options set value {}
execute if score #can_be_jungseong_last_next hangul matches 1 run \
    return run function hangul:internal/utils/binary_assemble_characters/return_combine_character with storage hangul:temp input

## 와 + ㅇ = 왕
# second_last = binary_join(secondary_last_jamo, last_jamo)
data modify storage hangul:temp input.str1 set from storage hangul:temp binary_assemble_characters.secondary_last_jamo
data modify storage hangul:temp input.str2 set from storage hangul:temp binary_assemble_characters.last_jamo
function hangul:internal/utils/binary_join with storage hangul:temp input
data modify storage hangul:temp binary_assemble_characters.second_last set from storage hangul: out
# #can_be_jungseong_second_last = can_be_jungseong(second_last)
data modify storage hangul:temp input.char set from storage hangul:temp binary_assemble_characters.second_last
execute store success score #can_be_jungseong_second_last hangul run \
    function hangul:can_be_jungseong with storage hangul:temp input
# #can_be_jongseong_next_char = can_be_jongseong(next_char)
data modify storage hangul:temp input.char set from storage hangul:temp binary_assemble_characters.next_char
execute store success score #can_be_jongseong_next_char hangul run \
    function hangul:can_be_jongseong with storage hangul:temp input
# if #can_be_jungseong_second_last && #can_be_jongseong_next_char: return combine_character(fixed_consonant, second_last, next_char)
data modify storage hangul:temp input.choseong set from storage hangul:temp binary_assemble_characters.fixed_consonant
data modify storage hangul:temp input.jungseong set from storage hangul:temp binary_assemble_characters.second_last
data modify storage hangul:temp input.options.jongseong set from storage hangul:temp binary_assemble_characters.next_char
execute if score #can_be_jungseong_second_last hangul matches 1 if score #can_be_jongseong_next_char hangul matches 1 run \
    return run function hangul:internal/utils/binary_assemble_characters/return_combine_character with storage hangul:temp input

## 가 + ㅇ = 강
# #can_be_jungseong_last_jamo = can_be_jungseong(last_jamo)
data modify storage hangul:temp input.char set from storage hangul:temp binary_assemble_characters.last_jamo
execute store success score #can_be_jungseong_last_jamo hangul run \
    function hangul:can_be_jungseong with storage hangul:temp input
# #can_be_jongseong_next_char = can_be_jongseong(next_char) <- 이거 위에 이미 있음
# if #can_be_jungseong_last_jamo && #can_be_jongseong_next_char: return combine_character(fixed_consonant, last_jamo, next_char)
data modify storage hangul:temp input.choseong set from storage hangul:temp binary_assemble_characters.fixed_consonant
data modify storage hangul:temp input.jungseong set from storage hangul:temp binary_assemble_characters.last_jamo
data modify storage hangul:temp input.options.jongseong set from storage hangul:temp binary_assemble_characters.next_char
execute if score #can_be_jungseong_last_jamo hangul matches 1 if score #can_be_jongseong_next_char hangul matches 1 run \
    return run function hangul:internal/utils/binary_assemble_characters/return_combine_character with storage hangul:temp input

# rest_jamos_12 = binary_join(rest_jamos[1], rest_jamos[2])
data modify storage hangul:temp input.str1 set from storage hangul:temp binary_assemble_characters.rest_jamos[1]
data modify storage hangul:temp input.str2 set from storage hangul:temp binary_assemble_characters.rest_jamos[2]
function hangul:internal/utils/binary_join with storage hangul:temp input
data modify storage hangul:temp binary_assemble_characters.rest_jamos_12 set from storage hangul: out
# #can_be_jungseong_rest_jamos_12 = can_be_jungseong(rest_jamos_12)
data modify storage hangul:temp input.char set from storage hangul:temp binary_assemble_characters.rest_jamos_12
execute store success score #can_be_jungseong_rest_jamos_12 hangul run \
    function hangul:can_be_jungseong with storage hangul:temp input

# if #can_be_jungseong_rest_jamos_12: fixed_vowel = rest_jamos_12
execute if score #can_be_jungseong_rest_jamos_12 hangul matches 1 run \
    data modify storage hangul:temp binary_assemble_characters.fixed_vowel set from storage hangul:temp binary_assemble_characters.rest_jamos_12
# unless #can_be_jungseong_rest_jamos_12: fixed_vowel = rest_jamos[1]
execute if score #can_be_jungseong_rest_jamos_12 hangul matches 0 run \
    data modify storage hangul:temp binary_assemble_characters.fixed_vowel set from storage hangul:temp binary_assemble_characters.rest_jamos[1]

# last_consonant = last_jamo
data modify storage hangul:temp binary_assemble_characters.last_consonant set from storage hangul:temp binary_assemble_characters.last_jamo

## 달 + ㄱ = 닭 / 웰 + ㅂ = 웳
# last_next = binary_join(last_consonant, next_char)
data modify storage hangul:temp input.str1 set from storage hangul:temp binary_assemble_characters.last_consonant
data modify storage hangul:temp input.str2 set from storage hangul:temp binary_assemble_characters.next_char
function hangul:internal/utils/binary_join with storage hangul:temp input
data modify storage hangul:temp binary_assemble_characters.last_next set from storage hangul: out
# #has_single_batchim_source = has_single_batchim(source)
data modify storage hangul:temp input.str set from storage hangul:temp binary_assemble_characters.source
execute store success score #has_single_batchim_source hangul run \
    function hangul:has_single_batchim with storage hangul:temp input
# #can_be_jongseong_last_next = can_be_jongseong(last_next)
data modify storage hangul:temp input.char set from storage hangul:temp binary_assemble_characters.last_next
execute store success score #can_be_jongseong_last_next hangul run \
    function hangul:can_be_jongseong with storage hangul:temp input
# if #has_single_batchim_source && #can_be_jongseong_last_next: return combine_character(fixed_consonant, fixed_vowel, last_next)
data modify storage hangul:temp input.choseong set from storage hangul:temp binary_assemble_characters.fixed_consonant
data modify storage hangul:temp input.jungseong set from storage hangul:temp binary_assemble_characters.fixed_vowel
data modify storage hangul:temp input.options.jongseong set from storage hangul:temp binary_assemble_characters.last_next
execute if score #has_single_batchim_source hangul matches 1 if score #can_be_jongseong_last_next hangul matches 1 run \
    return run function hangul:internal/utils/binary_assemble_characters/return_combine_character with storage hangul:temp input

## ㅕ + ㅇ = ㅕㅇ / ㅣ + ㅠ = ㅣㅠ
# return binary_join(source, next_char)
data modify storage hangul:temp input.str1 set from storage hangul:temp binary_assemble_characters.source
data modify storage hangul:temp input.str2 set from storage hangul:temp binary_assemble_characters.next_char
function hangul:internal/utils/binary_join with storage hangul:temp input

data remove storage hangul:temp binary_assemble_characters