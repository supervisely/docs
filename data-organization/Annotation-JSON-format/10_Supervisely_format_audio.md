# Audio Annotation

## Project Structure

Root 📁 `project_name` folder named with the project name

- 📄 `meta.json` — tag definitions and project settings, including the spectrogram settings. See [Project Meta](./02_Project_Classes_And_Tags.md).
- 📁 `<dataset_name>` — one folder per dataset, each containing:
  - 📁 `audio` — the recordings: `.wav`, `.flac`, `.mp3`, `.ogg` or `.m4a`.
  - 📁 `ann` — one annotation file per recording, named after it (e.g. `recording_01.wav.json`).
  - 📁 `audio_info` — optional; platform information about each recording.
  - 📁 `datasets` — optional; nested datasets, each with the same structure.

## Annotation file

A label on a recording is a tag applied to a range of samples.

```json
{
  "description": "",
  "sampleCount": 48000,
  "sampleRate": 16000,
  "channels": 2,
  "tags": [
    {
      "name": "knock",
      "frameRange": [16000, 23999],
      "channel": 1
    },
    {
      "name": "source",
      "frameRange": [0, 47999],
      "channel": null,
      "value": "engine"
    }
  ]
}
```

- `sampleCount`, `sampleRate`, `channels` — the shape of the recording. The platform does not store them, so they are written on export to make sample ranges convertible to seconds. Optional on import.
- `tags` — the segment labels.
- `name` — the tag's name in `meta.json`.
- `frameRange` — first and last sample of the segment, **both inclusive**, as zero-based indices into the original recording. The name is shared with videos, but for audio the numbers are samples, not frames and not milliseconds: at 16 kHz, `[16000, 23999]` is 1.0 s to 1.5 s.
- `channel` — the zero-based channel the label is about, or `null` for all channels.
- `value` — the tag value, for tags that have one.
- `meta` — optional free-form object, kept as is.
- `tagId`, `id`, `labelerLogin` — written on export and ignored on import.

## Spectrogram settings

The spectrogram settings are a project setting, stored in `meta.json` under `projectSettings.spectrogram`:

```json
{
  "classes": [],
  "tags": [
    { "name": "knock", "value_type": "none", "color": "#148A0F" }
  ],
  "projectType": "audio",
  "projectSettings": {
    "multiView": { "enabled": false, "tagName": null, "tagId": null, "isSynced": false },
    "spectrogram": {
      "scale": "mel",
      "fftSize": 1024,
      "hopLength": 256,
      "window": "hann",
      "melBands": 64,
      "minDb": -100.0,
      "maxDb": 0.0,
      "colormap": "magma",
      "interpolation": "sharp"
    }
  }
}
```

| Field | Values | In the toolbox |
|---|---|---|
| `scale` | `linear`, `log`, `mel` | Frequency display |
| `fftSize` | 32, 64, ..., 32768 | FFT window |
| `hopLength` | integer, at least 1 | Step (samples) |
| `window` | `hann`, `hamming`, `blackman` | Window function |
| `melBands` | 2 to 512 | Mel bands |
| `minDb`, `maxDb` | numbers, `maxDb` greater than `minDb` | Quiet cutoff, Bright cutoff |
| `colormap` | `viridis`, `magma`, `grayscale` | Colors |
| `interpolation` | `sharp`, `smooth` | Display style |

All nine fields are required when `spectrogram` is present. Without it the defaults apply. The channel on screen is not stored: it is chosen while viewing.
