#!/usr/bin/env bash
# Usage:
#   convert.sh <file|folder> [--force] [--scale=WIDTH]
#
# Converts video/gif files to .webm and places them next to originals.
# Skips .webm files unless --force is passed.
# --scale=600 resizes width to 600px keeping aspect ratio (disabled by default).
# Compatible with macOS, Linux, and Windows (Git Bash / WSL).

FORCE=0
SCALE=""
INPUT=""

for arg in "$@"; do
  case "$arg" in
    --force|-f) FORCE=1 ;;
    --scale=*) SCALE="${arg#--scale=}" ;;
    *) INPUT="$arg" ;;
  esac
done

if [ -z "$INPUT" ]; then
  echo "Usage: $0 <file|folder> [--force]"
  exit 1
fi

convert_file() {
  local src="$1"
  local ext lower_ext dst
  ext="${src##*.}"
  lower_ext=$(echo "$ext" | tr '[:upper:]' '[:lower:]')

  if [ "$lower_ext" = "webm" ] && [ "$FORCE" -eq 0 ]; then
    echo "Skipping (already webm): $src"
    return
  fi

  dst="${src%.*}.webm"

  if [ -f "$dst" ] && [ "$FORCE" -eq 0 ]; then
    echo "Skipping (output exists): $dst"
    return
  fi

  echo "Converting: $src -> $dst"
  if [ -n "$SCALE" ]; then
    ffmpeg -y -i "$src" -crf 40 -deadline best -vf "scale=${SCALE}:-2" -an "$dst"
  else
    ffmpeg -y -i "$src" -crf 40 -deadline best -an "$dst"
  fi
}

if [ -f "$INPUT" ]; then
  convert_file "$INPUT"
elif [ -d "$INPUT" ]; then
  while IFS= read -r -d '' file; do
    convert_file "$file"
  done < <(find "$INPUT" -maxdepth 1 -type f \( \
    -iname "*.mp4" -o -iname "*.mov" -o -iname "*.avi" -o -iname "*.mkv" \
    -o -iname "*.flv" -o -iname "*.wmv" -o -iname "*.m4v" -o -iname "*.webm" \
    -o -iname "*.gif" -o -iname "*.mpg" -o -iname "*.mpeg" -o -iname "*.ts"  \
    -o -iname "*.3gp" \
  \) -print0)
else
  echo "Error: '$INPUT' is not a valid file or directory."
  exit 1
fi
