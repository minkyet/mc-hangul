#> hangul:internal/utils/is_combined_alphabet
#
## 문자가 겹자음/겹모음인지 확인합니다
#
# @macro
#   char: string
# @return

$execute if data storage hangul:const jungseong[{combined:"$(char)"}] run return 1
$execute if data storage hangul:const jongseong[{combined:"$(char)"}] run return 1
return fail