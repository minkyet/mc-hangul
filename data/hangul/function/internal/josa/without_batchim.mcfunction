#> hangul:internal/josa/with_batchim
#
## 끝 문자에 받침이 없는 경우의 조사를 부여합니다
#
# @within hangul:josa
# @macro
#   str: string
# @input
#   score #josa_code hangul

$execute if score #josa_code hangul matches 1 run \
    return run data modify storage hangul: out set value "$(str)가"
$execute if score #josa_code hangul matches 2 run \
    return run data modify storage hangul: out set value "$(str)를"
$execute if score #josa_code hangul matches 3 run \
    return run data modify storage hangul: out set value "$(str)는"
$execute if score #josa_code hangul matches 4 run \
    return run data modify storage hangul: out set value "$(str)와"
$execute if score #josa_code hangul matches 5 run \
    return run data modify storage hangul: out set value "$(str)나"
$execute if score #josa_code hangul matches 6 run \
    return run data modify storage hangul: out set value "$(str)란"
$execute if score #josa_code hangul matches 7 run \
    return run data modify storage hangul: out set value "$(str)야"
$execute if score #josa_code hangul matches 8 run \
    return run data modify storage hangul: out set value "$(str)랑"
$execute if score #josa_code hangul matches 9 run \
    return run data modify storage hangul: out set value "$(str)예요"
$execute if score #josa_code hangul matches 10 run \
    return run data modify storage hangul: out set value "$(str)라"
$execute if score #josa_code hangul matches 11 run \
    return run data modify storage hangul: out set value "$(str)로"
$execute if score #josa_code hangul matches 12 run \
    return run data modify storage hangul: out set value "$(str)로서"
$execute if score #josa_code hangul matches 13 run \
    return run data modify storage hangul: out set value "$(str)로써"
$execute if score #josa_code hangul matches 14 run \
    return run data modify storage hangul: out set value "$(str)로부터"
