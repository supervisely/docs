# Overview

This option uploads audio recordings to the platform without any annotations. All recordings from the input directory and its subdirectories are uploaded to a single dataset.

# Format description

**Supported audio formats:** `.wav`, `.flac`, `.mp3`, `.ogg`, `.m4a`<br>
**With annotations:** No<br>
**Supported annotation format:** Not applicable.<br>
**Grouped by:** Any structure (will be uploaded to a single dataset).<br>

# Input files structure

```text
📦 folder
┣ 📂 bench_a
┃ ┣ 🎵 run_01.wav
┃ ┗ 🎵 run_02.flac
┗ 📂 bench_b
  ┣ 🎵 run_03.mp3
  ┗ 🎵 run_04.m4a
```

Files with other extensions are skipped. Recordings with the same name get a free name in the dataset.

Audio is always uploaded; it cannot be imported as links.
