# script for hangul:internal/build_char
import os

script_dir = os.path.dirname(os.path.abspath(__file__))
output_path = os.path.join(script_dir, "build_char.mcfunction")

start = ord("가")
end = ord("힇")

with open(output_path, "w", encoding="utf-8") as f:
    for code in range(start, end + 1):
        f.write(f"scoreboard players set #{chr(code)} hangul.char {code}\n")
    f.write(f"\nscoreboard players set #is_built hangul.status 1")