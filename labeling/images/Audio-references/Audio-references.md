---
description: >-
  Attach voice notes and other recordings to images and listen to them in the
  Audio panel of the Image Labeling Toolbox while labeling.
---

# Audio references

An image can carry one or more **audio files as references** — a dictated description, a voice note taken at capture time, or the recorded call a screenshot came from. Opening the image in the Image Labeling Toolbox shows an **Audio** panel with a player, so an annotator can listen to the recording while labeling instead of chasing it down outside the platform.

This is useful whenever the correct label depends on context that is not in the pixels.

## What audio references are not

Audio references are **reference only**:

* The audio is never annotated — no figures, no tags, no geometry, and nothing is written back to it.
* It is not part of the annotation, and it is not included in annotation exports.
* Audio cannot be attached from inside the labeling tool. References are attached programmatically — see [Attaching audio](#attaching-audio) below.

## Where the audio is stored

Only the **URL** of the recording is stored on the image. The audio file itself lives outside the project, normally in [Team Files](../../../data-organization/team-files/README.md), and the player streams it from there.

Two consequences worth knowing before you plan a workflow around this:

* If the audio file is deleted from Team Files, the player stops working. The reference on the image is just a link.
* Copying or exporting a project carries the links, not the recordings. A project imported into a **different** Supervisely instance keeps pointing at the instance the audio came from.

## The Audio panel

The panel appears in the Image Labeling Toolbox for image projects. It lists every recording attached to the current image and gives you a player for each one, labelled with the name the reference was created with. Images with no audio show an empty panel.

Multiple recordings per image are supported — one is simply the common case.

## Attaching audio

Audio is attached with the Python SDK, either while importing images or afterwards. In the simplest form, one call uploads a local file to Team Files and attaches it to the image:

```python
import supervisely as sly

api = sly.Api.from_env()

api.image.upload_audio_reference(
    id=3212008,
    team_id=8,
    path="/home/admin/audio/operator-note.mp3",
    name="Operator note",
)
```

You can also attach a recording that is already hosted, read back what is attached, and attach audio at import time. The full walkthrough, including how audio references survive an export and re-import, is in the [\[Supervisely Developer Portal\] Audio references on images](https://developer.supervisely.com/getting-started/python-sdk-tutorials/images/audio-references).
