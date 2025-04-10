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

# if !is_hangul_character(source) && !is_hangul_alphabet(source): return fail
$data modify storage hangul:return input.is_hangul_character set value {char:"$(source)"}
$data modify storage hangul:return input.is_hangul_alphabet set value {char:"$(source)"}
execute \
    unless function hangul:internal/return/is_hangul_character \
    unless function hangul:internal/return/is_hangul_alphabet run \
    return run function hangul:internal/utils/binary_assemble_characters/return_fail

# if !is_hangul_alphabet(next_char): return fail
$data modify storage hangul:return input.is_hangul_alphabet set value {char:"$(next_char)"}
execute unless function hangul:internal/return/is_hangul_alphabet run \
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

# if can_be_choseong(last_jamo) && can_be_jungseong(next_char): return link_characters(source, next_char)
data modify storage hangul:return input.can_be_choseong.char set from storage hangul:temp binary_assemble_characters.last_jamo
data modify storage hangul:return input.can_be_jungseong.char set from storage hangul:temp binary_assemble_characters.next_char
execute \
    if function hangul:internal/return/can_be_choseong \
    if function hangul:internal/return/can_be_jungseong run \
    return run function hangul:internal/utils/binary_assemble_characters/return_link_characters

# fixed_consonant = rest_jamos[0]
data modify storage hangul:temp binary_assemble_characters.fixed_consonant set from storage hangul:temp binary_assemble_characters.rest_jamos[0]

## 고 + ㅏ = 과
# last_next = binary_join(last_jamo, next_char)
data modify storage hangul:temp input.str1 set from storage hangul:temp binary_assemble_characters.last_jamo
data modify storage hangul:temp input.str2 set from storage hangul:temp binary_assemble_characters.next_char
function hangul:internal/utils/binary_join with storage hangul:temp input
data modify storage hangul:temp binary_assemble_characters.last_next set from storage hangul: out

# if can_be_jungseong(last_next): return combine_character(fixed_consonant, last_next)
data modify storage hangul:return input.can_be_jungseong.char set from storage hangul:temp binary_assemble_characters.last_next
execute if function hangul:internal/return/can_be_jungseong run \
    return run function hangul:internal/utils/binary_assemble_characters/return_fc_l

## 와 + ㅇ = 왕
# second_last = binary_join(secondary_last_jamo, last_jamo)
data modify storage hangul:temp input.str1 set from storage hangul:temp binary_assemble_characters.secondary_last_jamo
data modify storage hangul:temp input.str2 set from storage hangul:temp binary_assemble_characters.last_jamo
function hangul:internal/utils/binary_join with storage hangul:temp input
data modify storage hangul:temp binary_assemble_characters.second_last set from storage hangul: out

# if can_be_jungseong(second_last) && can_be_jongseong(next_char): return combine_character(fixed_consonant, second_last, next_char)
data modify storage hangul:return input.input.can_be_jungseong set from storage hangul:temp binary_assemble_characters.second_last
data modify storage hangul:return input.input.can_be_jongseong set from storage hangul:temp binary_assemble_characters.next_char
execute \
    if function hangul:internal/return/can_be_jungseong \
    if function hangul:internal/return/can_be_jongseong run \
    return run function hangul:internal/utils/binary_assemble_characters/return_fc_sl_n

## 가 + ㅇ = 강
# if can_be_jungseong(last_jamo) && can_be_jongseong(next_char): return combine_character(fixed_consonant, last_jamo, next_char)
data modify storage hangul:return input.can_be_jungseong.char set from storage hangul:temp binary_assemble_characters.last_jamo
data modify storage hangul:return input.can_be_jongseong.char set from storage hangul:temp binary_assemble_characters.next_char
execute \
    if function hangul:internal/return/can_be_jungseong \
    if function hangul:internal/return/can_be_jongseong run \
    return run function hangul:internal/utils/binary_assemble_characters/return_fc_lj_n

# rest_jamos_12 = binary_join(rest_jamos[1], rest_jamos[2])
data modify storage hangul:temp input.str1 set from storage hangul:temp binary_assemble_characters.rest_jamos[1]
data modify storage hangul:temp input.str2 set from storage hangul:temp binary_assemble_characters.rest_jamos[2]
function hangul:internal/utils/binary_join with storage hangul:temp input
data modify storage hangul:temp binary_assemble_characters.rest_jamos_12 set from storage hangul: out

data modify storage hangul:return input.can_be_jungseong.char set from storage hangul:temp binary_assemble_characters.rest_jamos_12
# if can_be_jungseong(rest_jamos_12): fixed_vowel = rest_jamos_12
execute if function hangul:internal/return/can_be_jungseong run \
    data modify storage hangul:temp binary_assemble_characters.fixed_vowel set from \
        storage hangul:temp binary_assemble_characters.rest_jamos_12
# unless can_be_jungseong(rest_jamos_12): fixed_vowel = rest_jamos[1]
execute unless function hangul:internal/return/can_be_jungseong run \
    data modify storage hangul:temp binary_assemble_characters.fixed_vowel set from \
        storage hangul:temp binary_assemble_characters.rest_jamos[1]

# last_consonant = last_jamo
data modify storage hangul:temp binary_assemble_characters.last_consonant set from \
    storage hangul:temp binary_assemble_characters.last_jamo

## 달 + ㄱ = 닭 / 웰 + ㅂ = 웳
# last_next = binary_join(last_consonant, next_char)
data modify storage hangul:temp input.str1 set from storage hangul:temp binary_assemble_characters.last_consonant
data modify storage hangul:temp input.str2 set from storage hangul:temp binary_assemble_characters.next_char
function hangul:internal/utils/binary_join with storage hangul:temp input
data modify storage hangul:temp binary_assemble_characters.last_next set from storage hangul: out

# if has_single_batchim(source) && can_be_jongseong(last_next): return combine_character(fixed_consonant, fixed_vowel, last_next)
data modify storage hangul:return input.has_single_batchim.str set from storage hangul:temp binary_assemble_characters.source
data modify storage hangul:return input.can_be_jongseong.char set from storage hangul:temp binary_assemble_characters.last_next
execute \
    if function hangul:internal/return/has_single_batchim \
    if function hangul:internal/return/can_be_jongseong run \
    return run function hangul:internal/utils/binary_assemble_characters/return_fc_fv_l

## ㅕ + ㅇ = ㅕㅇ / ㅣ + ㅠ = ㅣㅠ
# return binary_join(source, next_char)
data modify storage hangul:temp input.str1 set from storage hangul:temp binary_assemble_characters.source
data modify storage hangul:temp input.str2 set from storage hangul:temp binary_assemble_characters.next_char
function hangul:internal/utils/binary_join with storage hangul:temp input

data remove storage hangul:temp binary_assemble_characters