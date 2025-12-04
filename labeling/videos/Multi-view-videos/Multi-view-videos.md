---
description: >-
  Annotate multiple synchronized videos from different camera angles as a unified scene with shared objects and synchronized playback.
---

# Multiview Videos

## Overview

Multiview mode allows you to work with multiple videos of the same scene captured from different cameras or angles simultaneously. All videos within one dataset form a synchronized multiview group, enabling efficient annotation of complex multi-camera setups.

This is particularly useful for:

- **Autonomous driving** — multiple cameras mounted on a vehicle
- **Surveillance** — security cameras covering the same area from different angles
- **Sports analytics** — tracking athletes from multiple viewpoints
- **3D reconstruction** — multi-camera setups for depth estimation

<!-- TODO: Add screenshot/gif of multiview interface -->

---

## Key Concepts

### Unified Objects

If you have a common object appearing across different videos (e.g., a car visible from front, left, and right cameras), you can annotate it as a **single Supervisely object with a shared ID**.

- The object maintains its identity across all videos in the multiview group
- When you export and re-import the project, the object is recreated as a unified entity
- This enables consistent tracking and analysis across all camera views

### Video-specific Tags

Unlike objects, **tags apply only within a specific video**:

- When you tag a figure, frame, or video, that tag is associated only with that particular video
- Tags are displayed only on the video where they were created
- This allows for view-specific annotations (e.g., "occluded" tag on one camera angle)

### Synchronized Playback

All videos in a multiview group can be played back synchronously:

- Navigate through frames simultaneously across all views
- Configure frame offsets if videos have different starting points
- Maintain temporal alignment for accurate cross-view annotation

---

## How to Create Multiview Project

### Via UI (Drag & Drop)

1. Go to your workspace and start from creating a new project (`+ New` ⇨ `New Project Wizard`)
2. Select **Videos** ⇨ **Multi-view** labeling interface and proceed
3. Press `Import` to open the import app wizard
4. Prepare your data according to the required structure (see below):
   - Create a folder for each multiview group (dataset)
   - Place all camera videos inside the corresponding folder
5. Drag and drop your prepared folder or archive
6. The import app will automatically group videos by datasets

```text
📂 project_name
    ┣ 📂 dataset_01
    ┃  ┣ 🎥 camera_front.mp4
    ┃  ┣ 🎥 camera_left.mp4
    ┃  ┗ 🎥 camera_right.mp4
    ┗ 📂 dataset_03
       ┣ 🎥 camera_front.mp4
       ┣ 🎥 camera_left.mp4
       ┗ 🎥 camera_right.mp4
```

<!-- TODO: Add step-by-step gif -->

<!-- TODO Add sample-->
<!-- 📥 [Download example data](https://github.com/user-attachments/files/23659139/multiview-videos-sample.zip) -->

For detailed import format specification, see [Multiview Import Format](../../../data-organization/import/import/supported-formats-videos/multiview.md).

### Via Python SDK

```python
import supervisely as sly

# Initialize API
api = sly.Api.from_env()

# Create a new project with multiview settings
project = api.project.create(
    workspace_id=WORKSPACE_ID,
    name="My Multiview Project",
    type=sly.ProjectType.VIDEOS,
    change_name_if_conflict=True
)

# Update project settings to enable multiview
api.project.set_multiview_settings(project.id)

# Create a dataset (each dataset = one multiview group)
dataset = api.dataset.create(project.id, "scene_01")

# Upload videos to the dataset
video_paths = [
    "/path/to/camera_front.mp4",
    "/path/to/camera_left.mp4",
    "/path/to/camera_right.mp4"
]

for video_path in video_paths:
    api.video.upload_path(
        dataset_id=dataset.id,
        name=sly.fs.get_file_name_with_ext(video_path),
        path=video_path
    )
```

### Optional: Specify Video Order

To control the order of videos in the multiview labeling interface, you can create a metadata JSON file for each video with the suffix `.meta.json`. This file should include the `videoStreamIndex` to define its position.
For example, for a video named `camera_front.mp4`, create a file named `camera_front.mp4.meta.json` with the following content:

```json
{
  "videoStreamIndex": 0
}
```

```text
📂 project_name
    ┣ 📂 dataset_01
    ┃  ┣ 🎥 camera_front.mp4
    ┃  ┣ 🎥 camera_front.mp4.meta.json  # ⬅︎ meta file with videoStreamIndex
    ┃  ┣ 🎥 camera_left.mp4
    ┃  ┣ 🎥 camera_left.mp4.meta.json  # ⬅︎ meta file with videoStreamIndex
    ┃  ┣ 🎥 camera_right.mp4
    ┃  ┗ 🎥 camera_right.mp4.meta.json  # ⬅︎ meta file with videoStreamIndex
    ┗ 📂 dataset_03
       ┣ 🎥 camera_front.mp4
       ┣ 🎥 camera_left.mp4
       ┗ 🎥 camera_right.mp4
```

---

## Labeling in Multiview Mode

### Interface Overview

The multiview labeling interface displays all videos from the dataset simultaneously:

<!-- TODO: Add annotated screenshot of interface elements -->

- **Video panels** — each video is displayed in its own panel
- **Synchronized timeline** — single timeline controls all videos
- **Objects & Tags panel** — shows objects across all videos and video-specific tags

### Annotating Objects & Tags

{% hint style="info" %}
Note: When annotating in multiview mode, you can create unified objects across videos, but tags remain video-specific.
{% endhint %}

1. **Create an object** on any video using annotation tools (rectangle, polygon, etc.)
2. **The same object** can be annotated on other videos in the group
3. Objects with the same ID are linked across all videos

<!-- TODO: Add gif showing cross-video object annotation -->

<!-- ### Auto-tracking

Multiview mode supports automatic object tracking:

1. **Annotate the first frame** on one or more videos
2. **Select the object** you want to track
3. **Click Track** (or use `Shift + T` shortcut)
4. Configure tracking settings:
   - Select tracking model
   - Choose direction (forward/backward)
   - Set number of frames
5. The tracker will follow the object across frames


{% hint style="info" %}
Tracking is applied per-video. You may need to track the same object separately on each camera view.
{% endhint %} -->
<!-- TODO: Add gif demonstrating autotrack in multiview -->

---

## Export

Use the **Export Videos in Supervisely Format** app to export your multiview project:

- All videos are exported with their annotations in Supervisely format
- Object relationships across videos are preserved via shared object keys
- Metadata files contain `videoStreamIndex` for maintaining video order
- Project meta include settings for multiview configuration

The exported structure can be re-imported to recreate the exact same multiview setup.

---

## Use Cases

| Use Case               | Description                                                                     |
| ---------------------- | ------------------------------------------------------------------------------- |
| **Autonomous Driving** | Annotate objects visible from front, rear, and side cameras as unified entities |
| **Surveillance**       | Track people or vehicles across multiple security cameras                       |
| **Sports Analytics**   | Follow athletes from different camera angles for comprehensive analysis         |
| **Retail Analytics**   | Monitor customer behavior from multiple store cameras                           |
| **3D Reconstruction**  | Annotate corresponding points across stereo or multi-camera setups              |

---

## Useful Links

- [Multiview Import Format Specification](../../../data-organization/import/import/supported-formats-videos/multiview.md)
- [Video Annotation Format](../../../data-organization/Annotation-JSON-format/00_ann_format_navi.md)
- [Export Videos in Supervisely Format](https://ecosystem.supervisely.com/apps/export-videos-in-supervisely-format)
- [Video Labeling Toolbox](../README.md)
