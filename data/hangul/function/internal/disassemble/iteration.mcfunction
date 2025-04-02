#> hangul:internal/disassemble/iteration
#
## 각 문자를 반복하여 분리하여 스토리지에 넣습니다
#
# @loop recursive
# @output
#   storage hangul:temp disassemble.result: string[]

## get first character
data modify storage hangul:temp disassemble.first_char set from storage hangul:temp disassemble.split_str[0]
data modify storage hangul:temp input.char set from storage hangul:temp disassemble.first_char
data remove storage hangul:temp disassemble.split_str[0]

## disassemble by each type
# if complete hangul character: append disassembled complete character
execute store success score #is_complete_character hangul run \
    function hangul:disassemble_complete_character with storage hangul:temp input
data modify storage hangul:temp disassemble.iter set from storage hangul: out
execute if score #is_complete_character hangul matches 1 run \
    function hangul:internal/disassemble/append_complete_character

# if combined hangul character: append disassembled combined character
data modify storage hangul:temp input.char set from storage hangul:temp disassemble.first_char
execute store success score #is_combined_alphabet hangul run \
    function hangul:internal/utils/is_combined_alphabet with storage hangul:temp input
execute if score #is_complete_character hangul matches 0 if score #is_combined_alphabet hangul matches 1 run \
    function hangul:internal/disassemble/append_combined_character

# if not hangul character: append character
execute if score #is_complete_character hangul matches 0 if score #is_combined_alphabet hangul matches 0 run \
    data modify storage hangul:temp disassemble.result append from storage hangul:temp disassemble.first_char

## loop
execute if data storage hangul:temp disassemble.split_str[0] run \
    function hangul:internal/disassemble/iteration