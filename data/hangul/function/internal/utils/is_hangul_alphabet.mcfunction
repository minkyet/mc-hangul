#> hangul:internal/utils/is_hangul_alphabet
#
## 문자가 한글 음소인지 확인합니다
#
# @macro
#   char: string
# @return
# @example
#   /function THIS {char:"ㄱ"}      # 1
#   /function THIS {char:"ㅘ"}      # 1
#   /function THIS {char:"a"}      # 0
#   /function THIS {char:"과"}      # 0

$data modify storage hangul:temp is_hangul_alphabet set value {char:"$(char)"}

## if length(char) >= 2: fail
execute store result score #length hangul run \
    data get storage hangul:temp is_hangul_alphabet.char
data remove storage hangul:temp is_hangul_alphabet
execute if score #length hangul matches 2.. run return fail

## if exsits in hangul:const : return 1
$execute if data storage hangul:const choseong[{value:"$(char)"}] run return 1
$execute if data storage hangul:const jungseong[{value:"$(char)"}] run return 1
$execute if data storage hangul:const jungseong[{combined:"$(char)"}] run return 1
$execute if data storage hangul:const jongseong[{value:"$(char)"}] run return 1
$execute if data storage hangul:const jongseong[{combined:"$(char)"}] run return 1

## else: fail
return fail