#> hangul:internal/utils/is_hangul_character
#
## 문자가 완성형 한글 인지 확인합니다
#
# @macro
#   char: string
# @return
# @example
#   /function THIS {char:"가"}      # 1
#   /function THIS {char:"뤫"}      # 1
#   /function THIS {char:"ㄹ"}      # 0
#   /function THIS {char:"ㅞ"}      # 0

$execute if score #$(char) hangul.char matches 1.. run return 1
return fail