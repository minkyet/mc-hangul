#> hangul:internal/disassemble_complete_character/
#
## 인덱스에 맞는 한글 자모를 반환합니다
#
# @within hangul:disassemble_complete_character
# @macro
#   choseong_index: int
#   jungseong_index: int
#   jongseong_index: int
# @output
#   storage hangul: out

data modify storage hangul: out set value {}

$data modify storage hangul: out.choseong set from \
    storage hangul:const choseong[$(choseong_index)].value
$data modify storage hangul: out.jungseong set from \
    storage hangul:const jungseong[$(jungseong_index)].value
$data modify storage hangul: out.jongseong set from \
    storage hangul:const jongseong[$(jongseong_index)].value