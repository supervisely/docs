# convert.sh — Usage Guide

## What the script does

Converts video and GIF files into two formats placed next to the original:
- **`.webm`** — primary format (VP8, smaller file size)
- **`.mp4`** — fallback for browsers without WebM support (H.264)

Audio is stripped (`-an`) — intended for silent demo recordings.

## Requirements

- [`ffmpeg`](https://ffmpeg.org/download.html) must be installed and available in `PATH`
- Works on macOS, Linux, and Windows (Git Bash / WSL)

## Usage

```bash
bash convert.sh <file|folder> [--scale=WIDTH] [--force]
```

### Examples

```bash
# Convert a single file
bash convert.sh demo.gif

# Convert all videos in a folder
bash convert.sh .gitbook/assets/my-feature/

# Resize width to 800px
bash convert.sh demo.mov --scale=800

# Overwrite existing files (with backup)
bash convert.sh .gitbook/assets/ --force
```

### Arguments

| Argument | Description |
|---|---|
| `<file\|folder>` | Path to a file or folder (folder processes top-level files only) |
| `--scale=WIDTH` | Scales video to the given width, preserving aspect ratio. Omit to keep original size |
| `--force` / `-f` | Overwrites existing `.webm`/`.mp4`. Creates a backup (`*.bak.webm` / `*.bak.mp4`) before overwriting |

### Skip logic (without `--force`)

- Source is `.webm` → `.webm` generation is skipped, `.mp4` is still created
- Source is `.mp4` → `.mp4` generation is skipped, `.webm` is still created
- Output file already exists → skipped

---

## Embedding video in GitBook

GitBook does not support the `<video>` HTML tag directly in Markdown. Use a raw HTML block via the GitBook editor (**Insert > HTML block**).

### HTML snippet

```html
<video autoplay loop muted playsinline>
  <source src="../../.gitbook/assets/my-feature/demo.webm" type="video/webm">
  <source src="../../.gitbook/assets/my-feature/demo.mp4" type="video/mp4">
</video>
```

**Attributes:**
- `autoplay` — starts playing automatically
- `loop` — loops the video
- `muted` — required for autoplay in all modern browsers
- `playsinline` — required on iOS Safari to prevent fullscreen takeover
- First `<source>` — WebM (smaller, preferred)
- Second `<source>` — MP4 fallback (Safari, older browsers)

### File paths

Files live in `.gitbook/assets/`. The `src` path in `<source>` is **relative to the current page**.

Example structure:
```
.gitbook/assets/
  my-feature/
    demo.gif          ← original
    demo.webm         ← output (primary)
    demo.mp4          ← output (fallback)
```

Page at `docs/my-feature/overview.md` → path:
```
../../.gitbook/assets/my-feature/demo.webm
```

### Tips

- Use `--scale=800` or `--scale=600` to reduce file size
- Always convert GIFs — they are significantly larger than video formats
- Original files (`.gif`, `.mov`, etc.) can be deleted after verifying the output
