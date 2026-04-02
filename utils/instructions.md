# convert.sh — Usage Guide

## What the script does

Converts GIF and video files to **`.mp4`** (H.264, no audio) for uploading to GitBook.

Use this script only when looping playback is required (GIF replacement). For all other video content, use YouTube (see below).

## Requirements

- [`ffmpeg`](https://ffmpeg.org/download.html) must be installed and available in `PATH`
- Works on macOS, Linux, and Windows (Git Bash / WSL)

## Usage

```bash
bash convert.sh <file|folder> [--scale=WIDTH] [--force]
```

### Examples

```bash
# Convert a single GIF
bash convert.sh demo.gif

# Convert all files in a folder
bash convert.sh .gitbook/assets/my-feature/

# Resize width to 800px
bash convert.sh demo.gif --scale=800

# Overwrite existing files (with backup)
bash convert.sh .gitbook/assets/ --force
```

### Arguments

| Argument | Description |
|---|---|
| `<file\|folder>` | Path to a file or folder (folder processes top-level files only) |
| `--scale=WIDTH` | Scales video to the given width, preserving aspect ratio. Omit to keep original size |
| `--force` / `-f` | Overwrites existing `.mp4`. Creates a backup (`*.bak.mp4`) before overwriting |

### Skip logic (without `--force`)

- Source is `.mp4` → skipped
- Output file already exists → skipped

---

## When to use what

| Content type | Method |
|---|---|
| GIF replacement / looping demo | Convert to `.mp4`, upload via GitBook interface |
| Any other video content | Upload to YouTube, embed via `{% embed %}` |

---

## Embedding looping MP4 via GitBook interface

GitBook supports uploading `.mp4` files directly through the editor (limit: **2 MB**).

1. In the GitBook editor, place the cursor where you want the video.
2. Click **Insert > File** (or drag and drop the `.mp4` file).
3. GitBook uploads the file and creates an "Insert files" card.
4. Click the **Open** button — the video opens in a new tab.
5. Add `?autoplay=1&loop=1` to the end of the URL and copy the full URL.
6. Paste the URL on the next line and press Enter — an embed will be inserted.
7. Remove the "Insert files" card.

> If the file exceeds 2 MB, re-convert with for example `--scale=800` to reduce size.

---

## Embedding YouTube videos

For all non-looping video content, use YouTube:

1. Create a **playlist** for the documentation section.
2. Set the playlist visibility to **Unlisted** (accessible only by link).
3. Upload all required videos, setting each to **Unlisted** as well.
4. Use consistent thumbnail and title style matching existing videos in other playlists.
5. Embed in the documentation using:

```
{% embed url="https://youtu.be/VIDEO_ID" %}
```

**URL parameters:**
- `autoplay=1` — starts playing automatically
- `loop=1` — loops the video

> **Note:** `loop=1` currently does not work for YouTube embeds in GitBook.

> Do **not** use HTML `<video>` blocks — they are not supported in GitBook.
