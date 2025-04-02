#> hangul:internal/remove_last_character/remove_last_alphabet/3_or_less
#
## 3 이하
#
# @within hangul:internal/remove_last_character/remove_last_alphabet
# @input
#   storage hangul:temp remove_last_alphabet.last_character_without_last_alphabet
# @output
#   storage hangul: out: string

# first = last_character_without_last_alphabet[0]
data modify storage hangul:temp remove_last_alphabet.first set from \
    storage hangul:temp remove_last_alphabet.last_character_without_last_alphabet[0]
# middle = last_character_without_last_alphabet[1]
data modify storage hangul:temp remove_last_alphabet.middle set from \
    storage hangul:temp remove_last_alphabet.last_character_without_last_alphabet[1]
# last = last_character_without_last_alphabet[2]
data modify storage hangul:temp remove_last_alphabet.last set from \
    storage hangul:temp remove_last_alphabet.last_character_without_last_alphabet[2]

# #can_be_jungseong = can_be_jungseong(last)
data modify storage hangul:temp input.char set value ""
data modify storage hangul:temp input.char set from storage hangul:temp remove_last_alphabet.last
execute store success score #can_be_jungseong hangul run \
    function hangul:can_be_jungseong with storage hangul:temp input

## if middle != null:
data modify storage hangul:temp input.choseong set from \
    storage hangul:temp remove_last_alphabet.first
#   if #can_be_jungseong: combine_character(first, 'middle+last')
execute \
    if data storage hangul:temp remove_last_alphabet.middle \
    if score #can_be_jungseong hangul matches 1 run \
    return run function hangul:internal/remove_last_character/remove_last_alphabet/combine_f_ml
#   else: combine_character(first, middle, last)
execute \
    if data storage hangul:temp remove_last_alphabet.middle \
    if score #can_be_jungseong hangul matches 0 run \
    return run function hangul:internal/remove_last_character/remove_last_alphabet/combine_f_m_l

## else: return first
data modify storage hangul: out set from \
    storage hangul:temp remove_last_alphabet.first

data remove storage hangul:temp remove_last_alphabet