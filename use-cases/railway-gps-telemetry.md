---
description: Review railway infrastructure footage alongside its GPS route, speed, acceleration and altitude in Supervisely.
---

# Railway Infrastructure Inspection with GPS Telemetry

When reviewing a recording of a railway journey, it is important to understand both what is visible in the frame and where that section of track is located. Video + GPS Telemetry in Supervisely brings the video, route map, and speed, acceleration and altitude charts into one workspace.

## Find a section of track on the map

Select a point on the route in the **Map** tab to jump to the corresponding moment in the video. This is useful when you need to inspect a particular bend, level crossing or infrastructure location without knowing its timestamp.

The video, map marker and telemetry charts are synchronized. Navigating in one view automatically updates the others.

## Investigate events using telemetry

Click a point on a chart to view the corresponding video frames and position along the route. For example, select a drop in speed and check whether it coincides with a bend, an approach to a station or another visible event.

Acceleration peaks can help identify moments of vibration or sudden movement for closer review. They provide a reason to examine the footage, but do not by themselves confirm a track defect.

## Annotate objects and record observations

Pause at a relevant frame to annotate visible railway infrastructure or tag a video segment. Use these annotations to organize observations and prepare data for further review or computer vision model training.

See the [Video Labeling Tool guide](../labeling/labeling-toolbox/videos-3.0.md) for annotation tools and the [Classes and Tags guide](../data-organization/project-dataset/define-classes-tags.md) to configure your annotation categories.

## From a route to a specific frame

1. Upload an original recording with embedded GPS telemetry into a **Telemetry** project.
2. Find a section of interest using the map, telemetry charts or video timeline.
3. Compare the footage with its location and motion data.
4. Annotate objects and tag segments that need attention.

Reviewing video and telemetry together helps you navigate long recordings and examine each section in the context of its position along the route.

[Learn how to create a project and use Video + GPS Telemetry](https://github.com/supervisely/docs/blob/video-gps-telemetry/labeling/videos/video-gps-telemetry.md).
