#!/usr/bin/env bash

set -euo pipefail

source_dir="${1:-sources/videos}"
output_dir="${2:-static/videos/web}"

mkdir -p "$output_dir"

for name in quickly-navigate shift-page-feature advanced-image-filters; do
    input_file="${source_dir}/${name}.mov"

    if [[ ! -f "$input_file" ]]; then
        echo "Missing video source: $input_file" >&2
        exit 1
    fi

    ffmpeg -y -i "$input_file" \
      -vf "fps=24,scale='min(960,iw)':-2:flags=lanczos" \
      -an -c:v libvpx-vp9 -b:v 0 -crf 34 -row-mt 1 -cpu-used 2 \
      "${output_dir}/${name}.webm"

    ffmpeg -y -i "$input_file" \
      -vf "fps=24,scale='min(960,iw)':-2:flags=lanczos" \
      -an -c:v libx264 -preset slow -crf 24 -pix_fmt yuv420p \
      -movflags +faststart \
      "${output_dir}/${name}.mp4"

    ffmpeg -y -ss 0.8 -i "$input_file" -frames:v 1 \
      -vf "scale=960:-2:flags=lanczos" \
      "${output_dir}/${name}-poster.jpg"
done
