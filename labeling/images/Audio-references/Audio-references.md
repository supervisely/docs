---
description: >-
  Attach voice notes and other recordings to images and listen to them while
  labeling in the Audio references labeling interface for image projects.
---

# Audio references

An image can carry one or more **audio files as references** — a dictated description, a voice note taken at capture time, or the recorded call a screenshot came from. The `Audio references` labeling interface for image projects opens each image with an **Audio** panel and a player, so an annotator can listen to the recording while labeling instead of chasing it down outside the platform.

This is useful whenever the correct label depends on context that is not in the pixels.

{% hint style="info" %}
The `Audio references` labeling interface requires the Supervisely release that adds it; creating such a project from code requires the Supervisely Python SDK release that adds `LabelingInterface.AUDIO_REFERENCES`. Playing audio needs a Supervisely instance running `6.17.25` or newer, and attaching audio needs Supervisely Python SDK version `6.74.36` or newer.
{% endhint %}

To work with audio references:

1. create an image project with the `Audio references` labeling interface — see [Create a project with the Audio references interface](#create-a-project-with-the-audio-references-interface);
2. import the images and attach the recordings with the Python SDK — see [Attaching audio](#attaching-audio);
3. open the dataset in the labeling toolbox and play the recordings from the Audio panel.

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

The `Audio references` labeling interface is the standard image labeling toolbox with the **Audio** panel always shown — all image annotation tools stay available. The panel lists every recording attached to the current image and gives you a player for each one, labelled with the name the reference was created with. Images with no audio show an empty panel.

Multiple recordings per image are supported — one is simply the common case.

## Create a project with the Audio references interface

### In the web interface

1. Start creating a new project and choose the `Images` project type.
2. In the `Labeling interface` step, select `Audio references`. Hover the `?` icon next to it for a short description.
3. Finish creating the project and import your images.

An existing image project can be switched to the interface from its settings: open the project's advanced settings and select `Audio references` as the labeling interface.

### With the Python SDK

Pass the interface in the project settings when you set up the project meta:

```python
import supervisely as sly
from supervisely.project.project_settings import LabelingInterface

api = sly.Api.from_env()

project = api.project.create(
    workspace_id=12,
    name="Operator notes",
    type=sly.ProjectType.IMAGES,
)

settings = sly.ProjectSettings(labeling_interface=LabelingInterface.AUDIO_REFERENCES)
meta = sly.ProjectMeta(project_settings=settings)
api.project.update_meta(project.id, meta)
```

The setting is stored as `labelingInterface: "audio_references"` and is kept by `sly.upload_project` and `sly.download_project`, together with the audio references of the images.

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
