#> hangul:internal/josa/with_batchim
#
## 끝 문자에 받침이 있는 경우의 조사를 부여합니다
#
# @within hangul:josa
# @macro
#   str: string
# @input
#   score #josa_code hangul
#   score #batchim_code hangul

$execute if score #josa_code hangul matches 1 run \
    return run data modify storage hangul: out set value "$(str)이"
$execute if score #josa_code hangul matches 2 run \
    return run data modify storage hangul: out set value "$(str)을"
$execute if score #josa_code hangul matches 3 run \
    return run data modify storage hangul: out set value "$(str)은"
$execute if score #josa_code hangul matches 4 run \
    return run data modify storage hangul: out set value "$(str)과"
$execute if score #josa_code hangul matches 5 run \
    return run data modify storage hangul: out set value "$(str)이나"
$execute if score #josa_code hangul matches 6 run \
    return run data modify storage hangul: out set value "$(str)이란"
$execute if score #josa_code hangul matches 7 run \
    return run data modify storage hangul: out set value "$(str)아"
$execute if score #josa_code hangul matches 8 run \
    return run data modify storage hangul: out set value "$(str)이랑"
$execute if score #josa_code hangul matches 9 run \
    return run data modify storage hangul: out set value "$(str)이에요"
$execute if score #josa_code hangul matches 10 run \
    return run data modify storage hangul: out set value "$(str)이라"

# if #batchim_code == 8('ㄹ'):
$execute if score #batchim_code hangul matches 8 run \
    return run function hangul:internal/josa/with_rieul {str: "$(str)"}

# if #batchim_code != 8('ㄹ'):
$execute if score #josa_code hangul matches 11 run \
    return run data modify storage hangul: out set value "$(str)으로"
$execute if score #josa_code hangul matches 12 run \
    return run data modify storage hangul: out set value "$(str)으로서"
$execute if score #josa_code hangul matches 13 run \
    return run data modify storage hangul: out set value "$(str)으로써"
$execute if score #josa_code hangul matches 14 run \
    return run data modify storage hangul: out set value "$(str)으로부터"