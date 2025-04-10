#> hangul:internal/load
#
# @handles #minecraft:load

## init scoreboards
scoreboard objectives add hangul dummy
scoreboard objectives add hangul.status dummy
scoreboard objectives add hangul.const dummy
scoreboard objectives add hangul.jamo dummy
scoreboard objectives add hangul.char dummy

## build charmap
execute unless score #is_built hangul.status matches 1 run \
    function hangul:internal/load/build_char
execute unless score #is_char_list_built hangul.status matches 1 run \
    function hangul:internal/load/build_char_list

## initialize constants
scoreboard players set #hangul_start hangul.const 44032
scoreboard players set #hangul_last hangul.const 55175
scoreboard players set #jungseong hangul.const 21
scoreboard players set #jongseong hangul.const 28

## initialize jamo
scoreboard players set #이/가 hangul.jamo 1
scoreboard players set #을/를 hangul.jamo 2
scoreboard players set #은/는 hangul.jamo 3
scoreboard players set #와/과 hangul.jamo 4
scoreboard players set #이나/나 hangul.jamo 5
scoreboard players set #이란/란 hangul.jamo 6
scoreboard players set #아/야 hangul.jamo 7
scoreboard players set #이랑/랑 hangul.jamo 8
scoreboard players set #이에요/예요 hangul.jamo 9
scoreboard players set #이라/라 hangul.jamo 10
scoreboard players set #으로/로 hangul.jamo 11
scoreboard players set #으로서/로서 hangul.jamo 12
scoreboard players set #으로써/로써 hangul.jamo 13
scoreboard players set #으로부터/로부터 hangul.jamo 14

## initialize hangul storage
data modify storage hangul:const choseong set value [ \
    {value: "ㄱ", index: 0}, \
    {value: "ㄲ", index: 1}, \
    {value: "ㄴ", index: 2}, \
    {value: "ㄷ", index: 3}, \
    {value: "ㄸ", index: 4}, \
    {value: "ㄹ", index: 5}, \
    {value: "ㅁ", index: 6}, \
    {value: "ㅂ", index: 7}, \
    {value: "ㅃ", index: 8}, \
    {value: "ㅅ", index: 9}, \
    {value: "ㅆ", index: 10}, \
    {value: "ㅇ", index: 11}, \
    {value: "ㅈ", index: 12}, \
    {value: "ㅉ", index: 13}, \
    {value: "ㅊ", index: 14}, \
    {value: "ㅋ", index: 15}, \
    {value: "ㅌ", index: 16}, \
    {value: "ㅍ", index: 17}, \
    {value: "ㅎ", index: 18} \
]
data modify storage hangul:const jungseong set value [ \
    {value: "ㅏ", index: 0}, \
    {value: "ㅐ", index: 1}, \
    {value: "ㅑ", index: 2}, \
    {value: "ㅒ", index: 3}, \
    {value: "ㅓ", index: 4}, \
    {value: "ㅔ", index: 5}, \
    {value: "ㅕ", index: 6}, \
    {value: "ㅖ", index: 7}, \
    {value: "ㅗ", index: 8}, \
    {value: "ㅗㅏ", index: 9, combined:"ㅘ"}, \
    {value: "ㅗㅐ", index: 10, combined:"ㅙ"}, \
    {value: "ㅗㅣ", index: 11, combined:"ㅚ"}, \
    {value: "ㅛ", index: 12}, \
    {value: "ㅜ", index: 13}, \
    {value: "ㅜㅓ", index: 14, combined:"ㅝ"}, \
    {value: "ㅜㅔ", index: 15, combined:"ㅞ"}, \
    {value: "ㅜㅣ", index: 16, combined:"ㅟ"}, \
    {value: "ㅠ", index: 17}, \
    {value: "ㅡ", index: 18}, \
    {value: "ㅡㅣ", index: 19, combined:"ㅢ"}, \
    {value: "ㅣ", index: 20} \
]
data modify storage hangul:const jongseong set value [ \
    {value: "", index: 0}, \
    {value: "ㄱ", index: 1}, \
    {value: "ㄲ", index: 2}, \
    {value: "ㄱㅅ", index: 3, combined:"ㄳ"}, \
    {value: "ㄴ", index: 4}, \
    {value: "ㄴㅈ", index: 5, combined:"ㄵ"}, \
    {value: "ㄴㅎ", index: 6, combined:"ㄶ"}, \
    {value: "ㄷ", index: 7}, \
    {value: "ㄹ", index: 8}, \
    {value: "ㄹㄱ", index: 9, combined:"ㄺ"}, \
    {value: "ㄹㅁ", index: 10, combined:"ㄻ"}, \
    {value: "ㄹㅂ", index: 11, combined:"ㄼ"}, \
    {value: "ㄹㅅ", index: 12, combined:"ㄽ"}, \
    {value: "ㄹㅌ", index: 13, combined:"ㄾ"}, \
    {value: "ㄹㅍ", index: 14, combined:"ㄿ"}, \
    {value: "ㄹㅎ", index: 15, combined:"ㅀ"}, \
    {value: "ㅁ", index: 16}, \
    {value: "ㅂ", index: 17}, \
    {value: "ㅂㅅ", index: 18, combined:"ㅄ"}, \
    {value: "ㅅ", index: 19}, \
    {value: "ㅆ", index: 20}, \
    {value: "ㅇ", index: 21}, \
    {value: "ㅈ", index: 22}, \
    {value: "ㅊ", index: 23}, \
    {value: "ㅋ", index: 24}, \
    {value: "ㅌ", index: 25}, \
    {value: "ㅍ", index: 26}, \
    {value: "ㅎ", index: 27} \
]