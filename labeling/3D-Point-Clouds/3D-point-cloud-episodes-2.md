---
description: >-
    This article about the new labeling interface for 3D Point Clouds in Supervisely that introduces a significantly enhanced workflow, offering extended functionality and improved usability.
---

# New 3D Point Cloud and Episodes Labeling Tool

The 3D Point Cloud labeling tool in Supervisely is designed for visualizing, annotating, and managing complex 3D data collected from sensors such as LiDAR and RADAR. It supports key tasks like object detection and segmentation across static scenes and sequential episodes, making it ideal for applications like autonomous driving.

The latest version introduces a completely redesigned interface that unifies both **single-frame** and **episode-based** workflows. It brings a more streamlined and powerful experience with features such as:

- **AI-assisted tools** for faster and more accurate labeling
- Interactive **3D Object Detection**
- 3D Point Cloud **Ground Segmentation**
- 3D **Cuboid Tracking**
- **Auto Labeling**
- **Synchronized 2D–3D annotation** using photo context images  
- **Timeline navigation** for working with sequential frames  
- **Flexible, resizable UI layout** tailored to your workflow
- **Definitions Panel** for convenient class management and quick object editing
- **Advanced settings** for customizing visual styles and display preferences  

Together, these enhancements provide an integrated and efficient workspace for working with large-scale 3D datasets.


Difference between 3D Point Cloud and 3D Point Cloud Episodes:

**3D Point Cloud**: A static representation of a scene captured at a single moment in time.

**3D Point Cloud Episodes**: A dynamic representation consisting of multiple point clouds collected over time, enabling the analysis of movement and change in the scene.

## 1. 3D AI Assistant

Supervisely's 3D AI assistant is a universal tool for automating 3D point cloud labeling. It covers all types of labeling scenarios for 3D point clouds: 3D object detection, ground segmentation, 3D cuboid tracking, transfer of 2D annotations from photo context images to original 3D point clouds. This tool is class-agnostic - it means that it works with any type of objects regardless of their shape and point density.

### Interactive 3D Object Detection

Select smart tool in left side bar and circle target object. It will automatically generate a 3D cuboid around the selected object.

{% embed url="https://youtu.be/fpWhIdpLHWU?rel=0" %}

### 3D Point Cloud Ground Segmentation

- Detects and annotates the ground level in the 3D scene.
- Fits a horizontal surface through point clusters and creates a flat figure with a `ground` class.
- Useful for scene normalization and filtering.

Click on auto labeling tab and press "Ground segmentation".

{% embed url="https://youtu.be/YkTexmwWuEQ?rel=0" %}

### 3D Cuboid Tracking

The **3D Cuboid Tracking** tool allows you to automatically propagate annotations from one frame to the next. You can choose to track:

- A **single selected object**, or  
- **All objects** in the current scene (if no object is selected)

**Steps to use the tool:**

1. **Select the target(s)**
   - To track **one specific object**, simply **select it** in the scene.
   - To track **all annotated objects**, make sure **no object is selected** in the current frame.

2. **Open tracking settings**
   - Click the **arrow icon** on the **`Track All on Screen`** button.
   - In the settings popup:
     - Choose how many frames the annotations should be propagated to.
     - Select the **direction**: forward or backward.

3. **Run the tracking**
   - Click the main **`Track All on Screen`** button to start.
   - The annotation propagation process will be visualized on the **timeline**.
   - The **progress percentage** will be shown on the **`Track All on Screen`** button itself.
   - When it reaches **100%**, the tracking is complete.

{% embed url="https://youtu.be/c55mYnGox8Q?rel=0" %}

### Auto Labeling

- Automatically detects and annotates objects using pre-trained models.
- Simplifies the process of placing cuboids or segmenting regions of interest in the scene.

**To use the Auto Labeling, follow these steps:**

1. Open the **Auto Labeling tab**. Toggle the **_Highlight object by click_** option to enable it.

2. Make sure a Point Cloud view panel is active or click on one of the 3D view panels to activate it (Top, Side, Front, Perspective).

3. Select the **Cuboid tool** from the toolbar or press the `3` key on your keyboard to activate the Cuboid tool.

4. Click on a target point cluster in the 3D scene. You’ll see a cuboid attached to your mouse cursor. Click once on the desired object in the point cloud — this will place the cuboid.

5. Let the AI auto-label the selected object.

- The Auto Labeling tool will detect the full object in the point cloud and fit a cuboid around it using its internal logic.
- This minimizes manual adjustment and ensures accurate object boundaries.

6. Continue labeling more objects.

- The labeled object will now be **selected automatically**.
- The **Select Figure tool** becomes active by default, while the Cuboid auto-labeling tool remains enabled in the background.
- To label the next object, press `Space` to deselect the current object — the **Cuboid tool reattaches** to your cursor and you’re ready to click on the next group of points.

This loop allows for rapid labeling of multiple objects in sequence with minimal effort.

{% embed url="https://youtu.be/xhQsVn3vwoo" %}

### 2D to 3D Projection

The photo context panel is now an interactive part of the 3D labeling workspace.

You can annotate context images directly using standard image labeling tools. These annotations are automatically synchronized with the 3D space and become part of the same object instance.
2D and 3D annotations now coexist at the same level — edits or creation in one view are instantly reflected in the other. This improves labeling precision and scene understanding, especially when certain features are more visible in 2D.

The system seamlessly combines 2D and 3D perspectives in a single environment — no need to switch tools or views.

{% embed url="https://youtu.be/N7WcULjah7I" %}

**Additional capabilities:**

- 2D masks created on photo context images can be automatically converted into 3D geometry.

- Converted figures are visualized directly in the point cloud view.

- Currently, only masks are supported. Support for 2D bounding boxes is coming soon.

Click on a photo context image, draw a 2D mask, go to the Auto Labeling tab, and press "Create 3D objects from 2D object on camera."

{% hint style="info" %}
**Note**: AI Assistant features are available only to Enterprise customers with the Point Cloud module enabled.
{% endhint %}

## 2. Timeline Support

A full timeline component has been added, similar to the one used in video annotation tools:

- Enables navigation across sequential 3D point cloud frames (episodes).
- Supports annotation and review of dynamic scenes (episodes) across frame sequences.
- Provides a comprehensive overview of frame availability, object presence, and annotation density.

## 3. Modular and Resizable UI Layout

The new interface allows full layout customization:

- Panels such as photo context, camera views, and definitions can be moved and docked anywhere.
- Users can arrange the workspace to fit their own workflow and screen space.
- This flexibility improves usability and efficiency during annotation.

{% embed url="https://youtu.be/TwpyWbaLfZY" %}

In addition to repositioning view panels, the Settings panel provides advanced customization options — such as adjusting cuboid thickness, customizing class appearance, controlling point cloud display settings, toggling object IDs, and more.

<figure><img src="../../.gitbook/assets/3d-pc-episode/3d-pc-settings.jpg" alt=""><figcaption></figcaption></figure>

## 4. Definitions Panel

The **Definitions** panel is now available in the 3D interface, as in image and video tools:

- Provides quick access to classes, tags, tool settings, and object styles.
- Helps manage large taxonomies and maintain consistency across projects.

**Editing**

To change the class of a selected object:
1. Click _**Select Figure**_ tool.
2. Select the object in any of the view panels.
3. In the **Definition panel**, in the row of the selected class, click the mini-icon with two arrows to change the class.

<figure><img src="../../.gitbook/assets/3d-pc-episode/3d-pc-dp-change1.jpg" alt=""><figcaption></figcaption></figure>

### Navigation

<figure><img src="../../.gitbook/assets/3d-pc-episode/3d-pc-orbit-move1.jpg" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/3d-pc-episode/3d-pc-orbit-select2.jpg" alt=""><figcaption></figcaption></figure>

### Hotkeys

<figure><img src="../../.gitbook/assets/3d-pc-episode/3d-pc-hotkeys.jpg" alt=""><figcaption></figcaption></figure>

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