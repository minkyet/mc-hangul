#> hangul:internal/remove_last_character/remove_last_alphabet/3_or_less
#
## 3 이하
#
# @within hangul:internal/remove_last_character/remove_last_alphabet
# @input
#   storage hangul:temp remove_last_alphabet.last_character_without_last_alphabet
# @output
#   storage hangul: out: string

data modify storage hangul:temp remove_last_alphabet.last_character_without_last_alphabet append value ""

# first = last_character_without_last_alphabet[0]
data modify storage hangul:temp remove_last_alphabet.first set from \
    storage hangul:temp remove_last_alphabet.last_character_without_last_alphabet[0]
# middle = last_character_without_last_alphabet[1]
data modify storage hangul:temp remove_last_alphabet.middle set from \
    storage hangul:temp remove_last_alphabet.last_character_without_last_alphabet[1]
# last = last_character_without_last_alphabet[2]
data modify storage hangul:temp remove_last_alphabet.last set from \
    storage hangul:temp remove_last_alphabet.last_character_without_last_alphabet[2]

## if middle != null:
data remove storage hangul:return input
data modify storage hangul:return input.can_be_jungseong.char set from storage hangul:temp remove_last_alphabet.last
#   if can_be_jungseong(last): combine_character(first, 'middle+last')
execute \
    if data storage hangul:temp remove_last_alphabet.middle \
    if function hangul:internal/return/can_be_jungseong run \
    return run function hangul:internal/remove_last_character/remove_last_alphabet/combine_f_ml
#   unless can_be_jungseong(last): combine_character(first, middle, last)
execute \
    if data storage hangul:temp remove_last_alphabet.middle \
    unless function hangul:internal/return/can_be_jungseong run \
    return run function hangul:internal/remove_last_character/remove_last_alphabet/combine_f_m_l

## else: return first
data modify storage hangul: out set from \
    storage hangul:temp remove_last_alphabet.first

data remove storage hangul:temp remove_last_alphabet