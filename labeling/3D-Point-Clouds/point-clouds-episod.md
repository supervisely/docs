---
description: >-
    This article about the new labeling interface for 3D Point Clouds in Supervisely that introduces a significantly enhanced workflow, offering extended functionality and improved usability.
---

# Overview: New Interface for 3D Point Cloud Annotation

The new 3D Point Cloud labeling interface in Supervisely brings a powerful, streamlined workflow for annotating complex 3D data. It introduces synchronized 2D–3D annotations, timeline support for sequential scenes, flexible UI layouts, and AI-assisted tools for faster, more accurate labeling — all in a single integrated workspace.

## Key Features

### 1. Unified 2D–3D Annotation with Integrated Photo Context

The photo context panel is now an interactive part of the 3D labeling workspace.

You can draw masks and bounding boxes directly on **context images** using the standard image annotation tools. These annotations are automatically **synchronized with the 3D space** and become part of the same object instance.

2D and 3D annotations now coexist at the same level — edits or creation in one view are instantly reflected in the other. This improves labeling precision and scene understanding, especially when certain features are clearer in 2D.

The system allows combining 2D and 3D perspectives in a single environment without switching tools or views.

<figure><img src="../../.gitbook/assets/3d-pc-episode/3d-pc-Photo Context.jpg" alt=""><figcaption></figcaption></figure>

{% hint style="info" %}
**Note**: Currently, only masks are supported for 2D-to-3D conversion. Bounding box support is in progress.
{% endhint %}

### 2. Time-Based Labeling with Timeline Support

A full timeline component has been added, similar to the one used in video annotation tools:

- Enables navigation across sequential 3D point cloud frames (episodes).
- Supports annotation and review of dynamic scenes across time.
- Provides a comprehensive overview of frame availability, object presence, and annotation density.
- Note: unlike video tools, timeline-based frame tags are not supported. Tags exist only at the object level.

### 3. Modular and Resizable UI Layout

The new interface allows full layout customization:

- Panels such as photo context, camera views, and definitions can be moved and docked anywhere.
- Users can arrange the workspace to fit their own workflow and screen space.
- This flexibility improves usability and efficiency during annotation.
- Fullscreen mode for panels is currently not supported but may be reintroduced in future updates.

<figure><img src="../../.gitbook/assets/3d-pc-episode/3d-pc-Photo Context.jpg" alt=""><figcaption></figcaption></figure>

[Resize UI](https://github.com/supervisely/docs/raw/refs/heads/3d-pcd/.gitbook/assets/3d-pc-episode/3d-pcd-ui-resize.mp4)


### 4. Definitions Panel

The **Definitions** panel is now available in the 3D interface, as in image and video tools:

- Provides quick access to classes, tags, tool settings, and object styles.
- Helps manage large taxonomies and maintain consistency across projects.

### 5. AI Assistant

The new interface includes native support for AI-assisted annotation features, available via a dedicated panel.

#### Autolabeling

- Automatically detects and annotates objects using pre-trained models.
- Simplifies the process of placing cuboids or segmenting regions of interest in the scene.

#### Tracking

- After creating an annotation in one frame, the assistant can automatically propagate it across subsequent frames.
- Helps label dynamic objects in sequential datasets with minimal manual input.
- Uses a dedicated tracking panel, reusing logic from the video tool.

#### Ground Segmentation

- Detects and annotates the ground level in the 3D scene.
- Fits a horizontal surface through point clusters and creates a flat figure with a `ground` class.
- Useful for scene normalization and filtering.

#### 2D to 3D Projection

- Converts 2D masks created on photo context images into 3D geometry.
- The converted figures are visualized directly in the point cloud view.
- Currently supports masks. Support for 2D bounding boxes is being added.

> AI Assistant features are available only to Enterprise customers with the Point Cloud module enabled.

### 6. Smart Tools and Object Detection

In addition to AI Assistant:

- Smart Tools allow selecting regions in the 3D scene and auto-generating fitted cuboids.
- Object Detection uses AI models to detect and place cuboids automatically over recognized shapes.
- Reduces manual effort and improves annotation consistency.

#### Summary

The updated interface for 3D Point Cloud annotation combines powerful capabilities:

- Integrated 2D and 3D annotation tools
- Time-based navigation and frame control
- Modular UI layout with dockable panels
- Built-in AI Assistant for autolabeling, tracking, and segmentation

It offers a complete workspace for multi-modal annotation with high accuracy and scalability. Whether working with static point clouds or dynamic 3D sequences, the new tool provides clarity, control, and performance required for modern annotation workflows.

{% hint style="info" %}
**Note**: The older version of the 3D Point Cloud tool remains available under **legacy** status.

- Users can switch back using the **Switch to Legacy Tool** button.
- Legacy version has a static layout and lacks support for definitions, timeline, and 2D–3D synchronization.
- Further development will focus solely on the new interface.
{% endhint %}