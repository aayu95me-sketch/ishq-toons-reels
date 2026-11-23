#!/usr/bin/env bash
# List the biggest frame-to-frame jumps (cuts/seams) in a clip. Usage: seams.sh file.mp4 [top-N]
f="$1"; n="${2:-6}"
ffmpeg -hide_banner -i "$f" -vf "select='gt(scene,0)',metadata=print:file=-" -an -f null - 2>/dev/null \
 | paste - - | sed -E 's/.*pts_time:([0-9.]+).*scene_score=([0-9.]+).*/\1 \2/' \
 | awk '$1>0.1' | sort -k2 -nr | head -"$n"
