#> hangul:can_be_jongseong
#
## 문자가 종성으로 위치할 수 있는 문자인지 검사합니다
#
# @macro
#   char: string
# @return
# @api
# @example
#   /function THIS {char:"ㅁ"}        # 1
#   /function THIS {char:"ㄹㄱ"}      # 1
#   /function THIS {char:"ㅔ"}        # 0

$return run execute if data storage hangul:const jongseong[{value:"$(char)"}]