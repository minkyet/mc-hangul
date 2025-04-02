#> hangul:josa
#
## 한글 문자열에 적절한 조사를 붙여줍니다
#
# @macro
#   str: string
#   josa:
#       | "이/가"
#       | "을/를"
#       | "은/는"
#       | "으로/로"
#       | "와/과"
#       | "이나/나"
#       | "이란/란"
#       | "아/야"
#       | "이랑/랑"
#       | "이에요/예요"
#       | "으로서/로서"
#       | "으로써/로써"
#       | "으로부터/로부터"
#       | "이라/라"
# @output
#   storage hangul: out: string
# @api
# @example
#   /function THIS {str:"두루미", josa:"은/는"}             # 두루미는
#   /function THIS {str:"수학 교사", josa:"으로서/로서"}     # 수학 교사로서
#   /function THIS {str:"플레이어 1", josa:"이/가"}         # 플레이어 1가

## 조사 규칙
#   일반적인 경우: 받침 있으면 전자, 없으면 후자
#   와/과: 반대
#   받침이 'ㄹ'이면서 '로-'조사임: 후자

data remove storage hangul:temp input
data modify storage hangul: out set value "[HangulError]: 적절한 조사 타입이 아닙니다."

## get #josa_code
$scoreboard players operation #josa_code hangul = #$(josa) hangul.jamo
execute if score #josa_code hangul matches 0 run return fail

## get #batchim_code
$function hangul:has_batchim {str: "$(str)"}

## set input
$data modify storage hangul:temp input.str set value "$(str)"

## branch function based on existence of 받침
execute if score #batchim_code hangul matches 0 run \
    return run function hangul:internal/josa/without_batchim with storage hangul:temp input
return run function hangul:internal/josa/with_batchim with storage hangul:temp input
