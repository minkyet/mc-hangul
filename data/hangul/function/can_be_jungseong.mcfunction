#> hangul:can_be_jungseong
#
## 문자가 중성으로 위치할 수 있는 문자인지 검사합니다
#
# @macro
#   char: string
# @return
# @api
# @example
#   /function THIS {char:"ㅔ"}        # 1
#   /function THIS {char:"ㅜㅔ"}      # 1
#   /function THIS {char:"ㅁ"}        # 0

$return run execute if data storage hangul:const jungseong[{value:"$(char)"}]