#!/usr/bin/env bash
# Usage: preview.sh reel.mp4 song.m4a -> reel.preview.mp4 (FOR REVIEW ONLY, never upload; real song added in-app)
set -euo pipefail
d=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$1")
ffmpeg -v error -y -i "$1" -stream_loop -1 -i "$2" -map 0:v -map 1:a -c:v copy -c:a aac -t "$d" -af "afade=t=out:st=$(echo "$d-1.5"|bc):d=1.5" "${1%.mp4}.preview.mp4"
echo "${1%.mp4}.preview.mp4"
