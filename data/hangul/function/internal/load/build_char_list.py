# script for hangul:internal/build_char_list
import os

script_dir = os.path.dirname(os.path.abspath(__file__))
output_path = os.path.join(script_dir, "build_char_list.mcfunction")

start = ord("가")
end = ord("힇")

with open(output_path, "w", encoding="utf-8") as f:
    for code in range(start, end + 1):
        f.write(f"data modify storage hangul:const char append value \"{chr(code)}\"\n")