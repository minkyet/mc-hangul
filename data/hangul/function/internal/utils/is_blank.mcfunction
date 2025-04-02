#> hangul:internal/utils/is_blank
#
## 문자가 공백 문자인지 확인합니다
#
# @macro
#   char: string
# @return
# @example
#   /function THIS {char:" "}      # 1
#   /function THIS {char:"\u0020"}      # 1
#   /function THIS {char:"a"}      # 0
#   /function THIS {char:"   "}      # 0

$data modify storage hangul:temp is_blank set value {char:"$(char)"}

## if length(char) >= 2: fail
execute store result score #length hangul run \
    data get storage hangul:temp is_blank.char
data remove storage hangul:temp is_blank
execute if score #length hangul matches 2.. run return fail

## if exsits in hangul:const : return 1
$execute if data storage hangul:const whitespace[{value:"$(char)"}] run return 1

## else: fail
return fail