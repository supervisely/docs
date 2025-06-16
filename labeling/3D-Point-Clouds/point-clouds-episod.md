---
description: >-
    This article about the new labeling interface for 3D Point Clouds in Supervisely that introduces a significantly enhanced workflow, offering extended functionality and improved usability.
---

# Overview: New Interface for 3D Point Cloud Annotation

The new 3D Point Cloud labeling interface in Supervisely brings a powerful, streamlined workflow for annotating complex 3D data. It introduces synchronized 2D–3D annotations, timeline support for sequential scenes, flexible UI layouts, and AI-assisted tools for faster, more accurate labeling — all in a single integrated workspace.

## Key Features

### 1. 3D AI Assistant

Supervisely's 3D AI assistant is a universal tool for automating 3D point cloud labeling. It covers all types of labeling scenarios for 3D point clouds: 3D object detection, ground segmentation, 3D cuboid tracking, transfer of 2D annotations from photo context images to original 3D point clouds. This tool is class-agnostic - it means that it works with any type of objects regardless of their shape and point density.

#### Interactive 3D Object Detection

Select smart tool in left side bar and circle target object. It will automatically generate a 3D cuboid around the selected object.



#### 3D Point Cloud Ground Segmentation

- Detects and annotates the ground level in the 3D scene.
- Fits a horizontal surface through point clusters and creates a flat figure with a `ground` class.
- Useful for scene normalization and filtering.

Click on auto labeling tab and press "Ground segmentation".



#### 3D Cuboid Tracking

- After creating an annotation in one frame, the assistant can automatically propagate it across subsequent frames.
- Helps label dynamic objects in sequential datasets with minimal manual input.
- Uses a dedicated tracking panel, reusing logic from the video tool.



#### Autolabeling

- Automatically detects and annotates objects using pre-trained models.
- Simplifies the process of placing cuboids or segmenting regions of interest in the scene.

Click on auto labeling tab and enable "Highlight object by click" option, then select manual cuboid tabeling tools in left sidebar and set cuboid on target object.

{% embed url="https://drive.google.com/file/d/1z3nqOhkcAg9mOWHvwJqgOWlURSiIYyfJ/view?usp=sharing" %}

#### 2D to 3D Projection

The photo context panel is now an interactive part of the 3D labeling workspace.

You can annotate context images directly using standard image labeling tools. These annotations are automatically synchronized with the 3D space and become part of the same object instance.
2D and 3D annotations now coexist at the same level — edits or creation in one view are instantly reflected in the other. This improves labeling precision and scene understanding, especially when certain features are more visible in 2D.

The system seamlessly combines 2D and 3D perspectives in a single environment — no need to switch tools or views.

{% embed url="https://github.com/user-attachments/assets/54f26537-5b27-4b96-953f-e484701f3244" %}


**Additional capabilities:**

- 2D masks created on photo context images can be automatically converted into 3D geometry.

- Converted figures are visualized directly in the point cloud view.

- Currently, only masks are supported. Support for 2D bounding boxes is coming soon.

Click on a photo context image, draw a 2D mask, go to the Auto Labeling tab, and press "Create 3D objects from 2D object on camera."

<figure><img src="../../.gitbook/assets/3d-pc-episode/3d-pc-Photo Context.jpg" alt=""><figcaption></figcaption></figure>

{% hint style="info" %}
**Note**: AI Assistant features are available only to Enterprise customers with the Point Cloud module enabled.
{% endhint %}

### 2. Timeline Support

A full timeline component has been added, similar to the one used in video annotation tools:

- Enables navigation across sequential 3D point cloud frames (episodes).
- Supports annotation and review of dynamic scenes across frame sequences.
- Provides a comprehensive overview of frame availability, object presence, and annotation density.

### 3. Modular and Resizable UI Layout

The new interface allows full layout customization:

- Panels such as photo context, camera views, and definitions can be moved and docked anywhere.
- Users can arrange the workspace to fit their own workflow and screen space.
- This flexibility improves usability and efficiency during annotation.

{% embed url="https://github.com/user-attachments/assets/b00ce27b-79c2-4597-885b-d5465db99a12" %}


### 4. Definitions Panel

The **Definitions** panel is now available in the 3D interface, as in image and video tools:

- Provides quick access to classes, tags, tool settings, and object styles.
- Helps manage large taxonomies and maintain consistency across projects.

### 6. Smart Tools and Object Detection

In addition to AI Assistant:

- Smart Tools allow selecting regions in the 3D scene and auto-generating fitted cuboids.
- Object Detection uses AI models to detect and place cuboids automatically over recognized shapes.
- Reduces manual effort and improves annotation consistency.

## Summary

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