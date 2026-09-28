---
description: Review video alongside its GPS route, speed, acceleration and altitude in the Video Labeling Tool.
---

# Video + GPS Telemetry

The Telemetry interface brings video, a GPS map and telemetry charts into one labeling workspace. See what the camera recorded, where it was recorded and how the camera was moving.

The **Map** panel displays the recorded route and the current position. The **Telemetry** panel displays speed, acceleration and altitude. During playback, the map marker and chart playhead follow the video timeline.

![Video synchronized with the GPS route marker and telemetry chart playhead](../../.gitbook/assets/GPS-video-how-to-create-3.jpg)

[“Driving in Marin County, CA Countryside”](https://archive.org/details/MarinCountyCADriving) by HelloColby, Internet Archive, [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). Explanatory annotations added.

## Before you start

Use a Supervisely deployment that includes the Telemetry video interface. For Enterprise installations, the license must enable `videosLabelingInterfaces.telemetry`. Contact your administrator if the interface is unavailable.

For Python workflows, install **Supervisely SDK 6.74.39 or later**. The SDK recognizes the interface, but installing it does not add Telemetry to an older platform deployment.

### Supported recordings

| Source | Embedded telemetry format | What to upload |
| --- | --- | --- |
| GoPro | GPMF in a `gpmd` track | The original camera MP4, recorded with GPS enabled and a stable GPS fix (GPS lock) |
| Compatible Insta360 cameras and dashcams | CAMM | A recording containing supported CAMM telemetry |

The camera brand alone does not guarantee GPS data. Available metrics depend on the recording and the camera's sensors.

{% hint style="warning" %}
Upload original GoPro files without re-encoding. Video converters and editors can remove the embedded GPS stream even when the picture looks unchanged. Keep the camera original.
{% endhint %}

## Create a Telemetry project

1. Open your [workspace](../../data-organization/project-dataset/data-structure.md) and launch the [project creation wizard](../../data-organization/project-dataset/create.md).

   ![Open the project creation wizard through New → New project wizard](../../.gitbook/assets/GPS-video-how-to-create-1.jpg)

2. Select **Videos** as the project type and **Telemetry** (`telemetry`) as the labeling interface.

   ![Select the Videos project type and Telemetry labeling interface](../../.gitbook/assets/GPS-video-how-to-create-2.jpg)

3. [Upload the original camera recordings into a dataset](../../data-organization/project-dataset/create.md#creating-a-dataset).
4. Open a video in the [Video Labeling Tool](../labeling-toolbox/videos-3.0.md). Wait for telemetry to load: the **Map** and **Telemetry** panels appear beside the player.
5. Play the video or move to a specific moment on the timeline to inspect the corresponding location and telemetry.

<video controls preload="metadata" src="../../.gitbook/assets/gps-synchronized-navigation.webm">Watch the synchronized navigation demo.</video>

[Watch the synchronized navigation demo](../../.gitbook/assets/gps-synchronized-navigation.webm).

The Marin County example shows a countryside drive recorded on a GoPro with embedded GPS data.

[“Driving in Marin County, CA Countryside”](https://archive.org/details/MarinCountyCADriving) by HelloColby, Internet Archive, [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). Excerpts shown in a recording of the Supervisely interface.

## Navigate using the video, map and telemetry charts

You can move to a specific moment in the recording in three ways:

- **Using the video timeline** — select a moment on the track below the player. See [playback controls](../labeling-toolbox/videos-3.0.md#playback-controls) for playback buttons and frame navigation.
- **Using the Map tab** — click a point on the recorded route.
- **Using the Telemetry tab** — click a moment on the speed, acceleration or altitude chart.

All three navigation methods are synchronized: seeking updates the video frame, the map marker and the chart playhead. Start with whichever view makes the relevant part of the recording easiest to find.

**Use the map to find a specific place.** Select a route point, such as a bend, to see what happened there on video and compare the footage with the telemetry.

**Use the charts to find changes in the metrics.** For example, click a drop in speed on the blue chart. The video and map move to the same moment: you can see whether the slowdown coincided with a bend and check the footage to understand how the vehicle went through it.

See the Video Labeling Tool guide for [annotation tools](../labeling-toolbox/videos-3.0.md#instruments-panel). To configure object categories and tags, see [Classes and Tags](../../data-organization/project-dataset/define-classes-tags.md).

## Read the telemetry charts

The **Telemetry** panel contains three charts. The horizontal axis represents video time, and the orange vertical line marks the current playback position. Use it to match the video frame with the readings on all three charts. The current speed and altitude appear above the charts.

| Chart | What it shows | How to use it |
| --- | --- | --- |
| **Blue — speed, km/h** | The camera's speed according to GPS data. | Find stops, slowdowns and faster sections, then review the corresponding frames. |
| **Red — acceleration, m/s²** | The acceleration magnitude recorded by the camera's sensor. | Find shaking, vibration and sudden movements for closer video review. |
| **Green — altitude, m** | Altitude from the telemetry data. | Compare the video with climbs, descents and altitude changes along the route. |

![Telemetry panel showing speed, acceleration and altitude charts with the current video playhead](../../.gitbook/assets/GPS-video-how-to-read-1.jpg)

**Acceleration is not the same as vehicle acceleration or braking.** The sensor also responds to movement of the camera itself. Its readings may include the effect of gravity, so values around 10 m/s² should not be interpreted directly as vehicle acceleration. A peak helps identify a moment to review, but does not by itself prove that the road has a defect.

**Altitude depends on the reference system and the accuracy of the source data.** A negative value, such as −21 m, does not mean depth and does not by itself indicate an error. Small fluctuations may reflect measurement uncertainty rather than changes in terrain.

To investigate an event, move to the corresponding moment on the video timeline and compare the footage, map position and chart readings.

## Create a project with the Python SDK

For general programmatic upload options, see [Import using API and SDK](../../data-organization/import/import/import-sdk-api.md). The example below creates a Telemetry project.

```bash
python -m pip install "supervisely>=6.74.39"
```

Set the `SERVER_ADDRESS` and `API_TOKEN` environment variables. Set `WORKSPACE_ID` to the destination workspace ID. A team ID and a workspace ID are different values.

```python
import os
from pathlib import Path

import supervisely as sly
from supervisely.project.project_settings import LabelingInterface, ProjectSettings

api = sly.Api.from_env()
settings = ProjectSettings(labeling_interface=LabelingInterface.TELEMETRY)

project = api.project.create(
    workspace_id=int(os.environ["WORKSPACE_ID"]),
    name="Video GPS Telemetry",
    type=sly.ProjectType.VIDEOS,
    settings=settings.to_json(),
)
dataset = api.dataset.create(project.id, "original")

# Use an original camera recording without editing or re-encoding.
video_path = Path("/path/to/GX010001.MP4")
api.video.upload_path(dataset.id, video_path.name, str(video_path))
```

`LabelingInterface.TELEMETRY` serializes to `"telemetry"`. SDK versions earlier than 6.74.39 may raise `ValueError: Invalid labeling interface value: telemetry` when reading the settings of such a project.

## Videos without a GPS lock

A camera may record video without obtaining a valid GPS fix. If a recording has no usable GPS telemetry, the interface displays **“This video has no GPS telemetry”** instead of a route. This is an empty state, not a processing error. A metadata track alone does not mean it contains valid coordinates.

Before recording a new video, enable GPS and wait for a stable GPS lock. Uploading the file again or converting it cannot restore a route that the camera never recorded.

## Troubleshooting

| Problem | What to check |
| --- | --- |
| Telemetry is unavailable during project creation | Check that the platform version supports the interface and that the Enterprise license permits it. |
| The original works, but an edited copy has no route | Editing or conversion may have removed telemetry. Use the original and verify that processing preserves the GPS stream and its timing. |
| An anonymized copy has no route | Check the output in the labeling tool. Successful face or license plate blurring does not guarantee telemetry was preserved. |
| The SDK does not recognize `telemetry` | Upgrade to SDK 6.74.39 or later in the environment running the script or application. |
