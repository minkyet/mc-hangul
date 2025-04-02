#> hangul:internal/josa/with_rieul
#
## 끝 문자에 받침이 "ㄹ"인 경우의 조사를 부여합니다
#
# @within hangul:internal/josa/with_batchim
# @macro
#   str: string
# @input
#   score #josa_code hangul

$execute if score #josa_code hangul matches 11 run \
    return run data modify storage hangul: out set value "$(str)로"
$execute if score #josa_code hangul matches 12 run \
    return run data modify storage hangul: out set value "$(str)로서"
$execute if score #josa_code hangul matches 13 run \
    return run data modify storage hangul: out set value "$(str)로써"
$execute if score #josa_code hangul matches 14 run \
    return run data modify storage hangul: out set value "$(str)로부터"