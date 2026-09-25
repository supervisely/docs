---
description: >-
  Label audio recordings with time segments on a waveform and a spectrogram,
  with spectrogram settings fixed per project so every label can be reproduced.
---

# Audio

The Audio Labeling Toolbox is a browser-based interface for labeling recordings with **time segments**: acoustic events, speech, machine noise, anything that has a start and an end. It is built for tasks where the evidence is in the frequency content, such as NVH and acoustic quality inspection, bioacoustics, and sound event detection.

* **Waveform and spectrogram** of the same recording on one playhead
* **Segments** labeled with tags, down to a single sample, on all channels or on one channel
* **Whole-recording tags** for classifying a file as a whole
* **Spectrogram settings set once per project**, so every annotator sees the same analysis and the analysis can be reproduced later for training
* **Playback** of the whole recording or of the selection, looped, at 0.25× to 2×

## Create an Audio project

1. Open **Import** → **Create Project**, and choose **Audio** as the type of project. The type cannot be changed later.
2. Click **Create**. The project opens on its datasets page.
3. Import recordings into it — see [Import audio](#import-recordings) below.

Audio projects need a Supervisely license that includes the audio recordings module.

## Import recordings

Supported formats: **WAV, FLAC, MP3, OGG, M4A**.

* **Plain recordings** in any folder structure are uploaded to one dataset, without labels.
* **Supervisely format** keeps datasets, segments, whole-recording tags and the project's spectrogram settings. See [Supervisely audio format](../../data-organization/Annotation-JSON-format/10_Supervisely_format_audio.md).

Use the import wizard on the project, Team Files, Cloud Storage or the [Python SDK](https://developer.supervisely.com/getting-started/python-sdk-tutorials/audio/audio). Audio is always uploaded; it cannot be added by link.

## Layout

The toolbox opens when you click a recording in an Audio project.

1. **Audio** panel — the time ruler, the waveform (top third) and the spectrogram (bottom two thirds), with the transport bar below.
2. **Annotations** and **Recordings** tabs, under the Audio panel.
3. **Labels** and **View** tabs, on the right.
4. **Top bar** — previous and next recording, theme, and the hotkeys reference.

The layout can be rearranged and reset to the default.

## Label a segment

1. Select the **Label range** tool in the left toolbar.
2. Drag across the waveform or the spectrogram to select a range. A plain click only moves the playhead; **Shift**-click selects a single sample.
3. In **Labels**, set **Apply label to** to **Selected range** and click a tag. Tags with a value ask for it first — keys **1**–**9** pick an option, **Enter** saves, **Esc** cancels.

The segment is saved immediately. It covers the selected samples, both ends included, and it is about the channel you are viewing: **Mix** labels all channels, **Ch N** labels channel N only.

A tag's own hotkey applies it to the current selection as well.

### Edit and delete

* **Resize** a segment by dragging its edges; **Alt**-drag moves it. Changes stay a draft until you click the check mark (**Save changes**) or press **Esc** to cancel.
* In **Annotations**, the pencil button opens an editor with **Start**, **End (inclusive)** — in seconds or samples — **Channel** and the tag value.
* The trash button deletes one segment; tick several to delete, show or hide them together.

### Whole-recording tags

Set **Apply label to** to **Entire recording** and click a tag. Tick **Go to next recording after adding** to move on right away. These tags apply to all channels and show as badges above the plots.

## Channels

The headphones menu in the transport bar chooses what you see and hear: **Mix all channels**, or a single **Channel N**. When one channel is selected, segments on other channels are hidden. The choice carries over to the next recording.

## Navigation and playback

* **Scroll** to zoom around the pointer, **Shift**-scroll to pan, or drag the time ruler to scrub.
* The overview strip shows the whole recording: drag the window to pan, drag its edges to zoom, click to jump.
* **Fit recording** (**Alt+F**) shows the whole file.
* **Play selection** and **Loop selection** (**Shift+L**) play just the selected range.
* The time field shows the playhead position; its tooltip shows the sample rate, channel count and length in samples.

| Action | Hotkey |
|---|---|
| Play selection or recording / pause | **Space** |
| Play from playhead / pause | **Shift+Space** |
| Toggle selection loop | **Shift+L** |
| Fit recording | **Alt+F** |
| Undo / redo | **Ctrl+Z** / **Ctrl+Shift+Z** |
| Move playhead by one sample / one second | **←** **→** / **Shift+←** **Shift+→** |
| Go to start / end | **Home** / **End** |
| Cancel a drag or a draft | **Esc** |

## Spectrogram settings

A spectrogram is one of many possible pictures of the same audio, and the settings decide what is visible: a small FFT window separates events in time but blurs close frequencies together, a narrow contrast range hides quiet events. Labels are only comparable if they were drawn on the same picture. That is why the settings belong to the **project**: every recording is shown with them, for everyone.

They are in the **View** tab:

| Setting | Options |
|---|---|
| **Frequency display** | Linear (general purpose), Logarithmic (lower pitches), Mel (speech and hearing) |
| **Detail balance** | Timing, Balanced, Pitch — FFT windows of 512, 2048 and 8192 samples |
| **Colors** | Magma, Viridis, Grayscale |
| **Display style** | Sharp, Smooth |
| **Quiet cutoff** / **Bright cutoff** | the dBFS range the colors span; the quiet cutoff must be lower |
| **Advanced analysis** | **FFT window** (32 to 32768 samples), **Step** in samples, **Window function** (Hann, Hamming, Blackman), **Mel bands** (2 to 512, Mel only) |

The defaults are Linear, a 2048-sample window with a 512-sample step, Hann, 128 mel bands, −100 to 0 dBFS, Magma, Sharp.

{% hint style="warning" %}
Changing a setting applies at once to every recording in the project, for everyone. Existing labels are not changed, but they were drawn on a picture that no longer matches. Choose the settings before labeling starts.
{% endhint %}

Only users who can edit the project can change them. Annotators see the settings locked, with the note that they are configured once for the whole project.

The settings are saved in the project and exported with it, so the same spectrogram can be computed outside Supervisely — for example as training input in PyTorch or TensorFlow. See [Audio in the Python SDK](https://developer.supervisely.com/getting-started/python-sdk-tutorials/audio/audio).

## Browser support

The views are drawn on the GPU with WebGPU, or with WebGL2 where WebGPU is not available — the top bar then shows a **WebGL2** badge. If the browser cannot decode a recording's codec, the toolbox says so; re-encode the recording to WAV or use a browser that supports the codec.
