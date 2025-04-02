#> hangul:internal/utils/get_char
#
## 인덱스에 해당하는 완성형 한글을 반환합니다
#
# @macro
#   index: int
# @output
#   storage hangul: out: string

$data modify storage hangul: out set from storage hangul:const char[$(index)]