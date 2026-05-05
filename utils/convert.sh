#!/usr/bin/env bash
# Usage:
#   convert.sh <file|folder> [--force] [--scale=WIDTH] [--speedup=xN]
#
# Converts video/gif files to .mp4 next to originals.
# Skips .mp4 sources unless --force is passed.
# --force backs up any existing output to <name>.bak.mp4 before overwriting.
# --scale=600 resizes width to 600px keeping aspect ratio (disabled by default).
# Compatible with macOS, Linux, and Windows (Git Bash / WSL).

FORCE=0
SCALE=""
SPEEDUP=""
INPUT=""

for arg in "$@"; do
  case "$arg" in
    --force|-f) FORCE=1 ;;
    --scale=*) SCALE="${arg#--scale=}" ;;
    --speedup=*) SPEEDUP="${arg#--speedup=}" ;;
    *) INPUT="$arg" ;;
  esac
done

if [ -z "$INPUT" ]; then
  echo "Usage: $0 <file|folder> [--force] [--scale=WIDTH] [--speedup=xN]"
  exit 1
fi

convert_file() {
  local src="$1"
  local ext lower_ext dst
  ext="${src##*.}"
  lower_ext=$(echo "$ext" | tr '[:upper:]' '[:lower:]')

  local base="${src%.*}"
  local dst_mp4="${base}.mp4"

  # Build shared scale filter arg
  local vf_filters=()
  if [ -n "$SCALE" ]; then
    vf_filters+=("scale=${SCALE}:-2")
  fi
  if [ -n "$SPEEDUP" ]; then
    local factor="${SPEEDUP#x}"
    vf_filters+=("setpts=PTS/${factor}")
  fi
  local vf_arg=""
  if [ "${#vf_filters[@]}" -gt 0 ]; then
    local IFS_bak="$IFS"
    IFS=','
    vf_arg="-vf ${vf_filters[*]}"
    IFS="$IFS_bak"
  fi

  # Backup helper: copies $1 to $1.bak.ext if it exists and FORCE is set
  backup_if_needed() {
    local f="$1"
    if [ "$FORCE" -eq 1 ] && [ -f "$f" ]; then
      local bak="${f%.*}.bak.${f##*.}"
      echo "Backing up: $f -> $bak"
      cp "$f" "$bak"
    fi
  }

  # --- mp4 ---
  if [ "$lower_ext" = "mp4" ] && [ "$FORCE" -eq 0 ]; then
    echo "Skipping mp4 (already mp4): $src"
  elif [ -f "$dst_mp4" ] && [ "$FORCE" -eq 0 ]; then
    echo "Skipping mp4 (output exists): $dst_mp4"
  else
    backup_if_needed "$dst_mp4"
    echo "Converting to mp4: $src -> $dst_mp4"
    if [ "$src" = "$dst_mp4" ]; then
      local tmp="${dst_mp4%.mp4}.tmp$$.mp4"
      ffmpeg -y -i "$src" -c:v libx264 -preset slow -crf 22 $vf_arg -an "$tmp" && mv "$tmp" "$dst_mp4"
    else
      ffmpeg -y -i "$src" -c:v libx264 -preset slow -crf 22 $vf_arg -an "$dst_mp4"
    fi
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
