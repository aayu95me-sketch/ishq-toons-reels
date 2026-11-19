#!/usr/bin/env bash
# Usage: stitch.sh out.mp4 clipA.mp4 clipB.mp4 [clipC.mp4 ...]
# Joins 8 s Flow clips with 0.4 s crossfades, 720x1280, 30 fps, silent (song is added in-app).
set -euo pipefail
out=$1; shift; n=$#; X=0.4
inputs=(); for f in "$@"; do inputs+=(-i "$f"); done
fc=""; for i in $(seq 0 $((n-1))); do fc+="[$i:v]scale=720:1280,fps=30,format=yuv420p,setpts=PTS-STARTPTS[v$i];"; done
prev=v0; off=0
for i in $(seq 1 $((n-1))); do
  d=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "${@:$i:1}")
  off=$(echo "$off + $d - $X" | bc); fc+="[$prev][v$i]xfade=transition=fade:duration=$X:offset=$off[x$i];"; prev=x$i
done
ffmpeg -v error -y "${inputs[@]}" -filter_complex "${fc%;}" -map "[$prev]" -an -c:v libx264 -crf 18 -preset slow -movflags +faststart "$out"
echo "made $out"
