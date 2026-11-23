#!/usr/bin/env bash
# Burn hook text (start) and ask text (end) onto a 720x1280 clip. Keeps audio.
# Usage: hooktext.sh in.mp4 out.mp4 "HOOK TEXT" "END TEXT" [hook_secs=1.8] [end_secs=2.2]
in="$1"; out="$2"; hook="$3"; endt="$4"; hs="${5:-1.8}"; es="${6:-2.2}"
F=/usr/share/fonts/opentype/inter/InterDisplay-Bold.otf
d=$(ffprobe -v error -show_entries format=duration -of default=nw=1:nk=1 "$in")
st=$(echo "$d - $es" | bc -l)
printf '%b' "$hook" > /tmp/hook.txt; printf '%b' "$endt" > /tmp/end.txt
ffmpeg -v error -y -i "$in" -vf "drawtext=fontfile=$F:textfile=/tmp/hook.txt:fontsize=64:fontcolor=white:borderw=6:bordercolor=black@0.85:text_align=C:x=(w-tw)/2:y=h*0.16:enable='lt(t,$hs)',drawtext=fontfile=$F:textfile=/tmp/end.txt:fontsize=50:fontcolor=white:borderw=5:bordercolor=black@0.85:text_align=C:x=(w-tw)/2:y=h*0.30:enable='gte(t,$st)'" -c:v libx264 -crf 18 -preset medium -c:a copy "$out"
