#!/usr/bin/env bash
# Usage: qa.sh reel.mp4  -> prints PASS/FAIL checks and writes reel.sheet.jpg (1 frame / 2 s)
set -uo pipefail
f=$1; ok=1
read w h < <(ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=p=0 "$f" | tr ',' ' ')
d=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$f")
a=$(ffprobe -v error -select_streams a -show_entries stream=index -of csv=p=0 "$f")
[ "$w" = 720 ] && [ "$h" = 1280 ] && echo "PASS 9:16 720x1280" || { echo "FAIL size ${w}x${h}"; ok=0; }
awk "BEGIN{exit !($d>=15 && $d<=30)}" && echo "PASS length ${d}s" || { echo "FAIL length ${d}s (want 15-30)"; ok=0; }
[ -z "$a" ] && echo "PASS silent (add song in app)" || { echo "FAIL has audio track"; ok=0; }
bl=$(ffmpeg -v info -i "$f" -vf blackdetect=d=0.3:pix_th=0.1 -an -f null - 2>&1 | grep -c black_start || true)
[ "$bl" = 0 ] && echo "PASS no black gaps" || { echo "FAIL $bl black gap(s)"; ok=0; }
ffmpeg -v error -y -i "$f" -vf "fps=0.5,scale=160:-1,tile=6x2" -frames:v 1 "${f%.mp4}.sheet.jpg"
echo "sheet: ${f%.mp4}.sheet.jpg"; [ $ok = 1 ] && echo "ALL PASS" || exit 1
