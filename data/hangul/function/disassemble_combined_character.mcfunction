#> hangul:disassemble_combined_character
#
## 겹자음/겹모음을 분해합니다
#
# @macro
#   char: string
# @output
#   storage hangul: out: string
# @api
# @example
#   /function THIS {char:"ㅘ"}      # ㅗㅏ
#   /function THIS {char:"ㄼ"}      # ㄹㅂ

data modify storage hangul: out set value "[HangulError]: 적절한 겹문자가 아닙니다"

$data modify storage hangul: out set from storage hangul:const jungseong[{combined:"$(char)"}].value
$data modify storage hangul: out set from storage hangul:const jongseong[{combined:"$(char)"}].value