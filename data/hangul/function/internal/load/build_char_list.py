# script for hangul:internal/build_char_list
import os

script_dir = os.path.dirname(os.path.abspath(__file__))
output_path = os.path.join(script_dir, "build_char_list.mcfunction")

start = ord("가")
end = ord("힇")

i = 0
with open(output_path, "w", encoding="utf-8") as f:
    f.write("data modify storage hangul:const char set value { \\\n")
    for code in range(start, end + 1):
        f.write(f"    {i}: \"{chr(code)}\", \\\n")
        i += 1
    f.write("}\n")
    f.write("\nscoreboard players set #is_char_list_built hangul.status 1")