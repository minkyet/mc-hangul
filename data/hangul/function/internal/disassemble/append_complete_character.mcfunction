#> hangul:internal/disassemble/append_complete_character
#
## 분리된 완성형 한글을 배열에 추가합니다
#
# @within hangul:internal/disassemble/iteration
# @input
#   storage hangul:temp disassemble.iter.choseong: string
#   storage hangul:temp disassemble.iter.jungseong: string
#   storage hangul:temp disassemble.iter.jongseong: string
# @output
#   storage hangul:temp disassemble.result: string[]

## get count
execute store result score #jungseong_count hangul run \
    data get storage hangul:temp disassemble.iter.jungseong
execute store result score #jongseong_count hangul run \
    data get storage hangul:temp disassemble.iter.jongseong

## append

# choseong
data modify storage hangul:temp disassemble.result append from storage hangul:temp disassemble.iter.choseong

# jungseong
execute if score #jungseong_count hangul matches 1 run \
    data modify storage hangul:temp disassemble.result append from storage hangul:temp disassemble.iter.jungseong
execute if score #jungseong_count hangul matches 2 run \
    data modify storage hangul:temp disassemble.result append string storage hangul:temp disassemble.iter.jungseong 0 1
execute if score #jungseong_count hangul matches 2 run \
    data modify storage hangul:temp disassemble.result append string storage hangul:temp disassemble.iter.jungseong 1 2

# jongseong
execute if score #jongseong_count hangul matches 1 run \
    data modify storage hangul:temp disassemble.result append from storage hangul:temp disassemble.iter.jongseong
execute if score #jongseong_count hangul matches 2 run \
    data modify storage hangul:temp disassemble.result append string storage hangul:temp disassemble.iter.jongseong 0 1
execute if score #jongseong_count hangul matches 2 run \
    data modify storage hangul:temp disassemble.result append string storage hangul:temp disassemble.iter.jongseong 1 2