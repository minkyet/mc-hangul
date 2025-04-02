#> hangul:disassemble
#
## 한글 문자열을 글자별로 초성/중성/종성 단위로 완전히 분리하여 배열로 출력합니다.
#
# @macro
#   str: string
# @output
#   storage hangul: out: string[]
# @api
# @example
#   /function THIS {str:"한국"}        # ["ㅎ", "ㅏ", "ㄴ", "ㄱ", "ㅜ", "ㄱ"]
#   /function THIS {str:"파도 소리"}   # ["ㅍ", "ㅏ", "ㄷ", "ㅗ", " ", "ㅅ", "ㅗ", "ㄹ", "ㅣ"]
#   /function THIS {str:"됢"}          # ["ㄷ", "ㅗ", "ㅣ", "ㄹ", "ㅁ"]

data modify storage hangul:temp disassemble set value {result:[]}

## split all characters
$function hangul:internal/utils/split {str:"$(str)"}
data modify storage hangul:temp disassemble.split_str set from storage hangul: out

## disassemble characters by iteration
function hangul:internal/disassemble/iteration

## set output
data modify storage hangul: out set from storage hangul:temp disassemble.result

## remove temp data
# data remove storage hangul:temp disassemble