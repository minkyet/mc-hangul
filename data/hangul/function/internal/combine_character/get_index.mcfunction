#> hangul:internal/combine_character/get_index
#
## 초성, 중성, 종성을 받아 각각의 인덱스를 반환합니다
#
# @within hangul:combine_character
# @macro
#   choseong: string
#   jungseong: string
#   jongseong: string
# @output
#   score #choseong_index hangul
#   score #jungseong_index hangul
#   score #jongseong_index hangul

# 초성/중성/종성 인덱스 구하기
$execute store result score #choseong_index hangul run \
    data get storage hangul:const choseong[{value:"$(choseong)"}].index
$execute store result score #jungseong_index hangul run \
    data get storage hangul:const jungseong[{value:"$(jungseong)"}].index
$execute store result score #jongseong_index hangul run \
    data get storage hangul:const jongseong[{value:"$(jongseong)"}].index

