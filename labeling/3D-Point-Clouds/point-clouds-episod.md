---
description: >-
    This article about the new labeling interface for 3D Point Clouds in Supervisely that introduces a significantly enhanced workflow, offering extended functionality and improved usability.
---

# Overview: New Interface for 3D Point Cloud Annotation

Supervisely introduces a new, more powerful interface for 3D Point Cloud annotation — replacing the previous version, which is now considered as **legacy**. For compatibility or preference, users can still access the old tool using the **Switch to Legacy Tool button**.

## Key Features

### Unified 2D–3D Annotation with Integrated Photo Context

The photo context panel is now seamlessly integrated into the 3D labeling interface, allowing direct annotation on images linked to 3D point cloud scenes — right inside the labeling workspace.

- You can create and edit masks, bounding boxes, and tags directly on the photo context images.

- These annotations are automatically synchronized with the 3D scene and vice versa — they are a single entity in both views.

- This enables multi-modal annotation in one place, improving efficiency and making it easier to label objects that are better visible in 2D.

- The integration empowers users to understand complex scenes faster and more accurately by combining spatial and visual data.

### Timeline Navigation

The interface introduces a timeline component, similar to the one used in video labeling.

- Provides a comprehensive overview of the dataset across time.

- Enables easy navigation through point cloud frames or scans.

- Supports time-based annotations for episodic or dynamic scenes — ideal for applications like autonomous driving, robotics, or industrial inspection.

- Helps track object movement, instance continuity, and scene evolution frame-by-frame.

### Synchronized 2D–3D Annotations

Annotations across 2D and 3D views are now fully connected — not just linked, but unified.

- An object annotated in the image view appears instantly in 3D, and vice versa.

- Any update in one modality is reflected in the other automatically.

- This powerful feature greatly enhances annotation consistency, scene understanding, and labeling accuracy.

- It allows users to combine the strengths of both perspectives — for example, annotating finer details in 2D while maintaining spatial context in 3D.

### Modular and Flexible Interface

The interface has been redesigned from the ground up for better usability and customization:

- A modern, clean layout with reorganized tools and intuitive controls.

- Users can freely move, resize, and dock panels and tabs to build a personalized workspace.

- Dropdown menus and context-aware actions (currently in development) further streamline the labeling workflow.

- The UI is still evolving — screenshots and walkthroughs will be added when finalized.

{% hint style="info" %}
**Note**: This article focuses on the core functionality. Visual updates and examples will follow in upcoming releases.
{% endhint %}

### Access to Legacy Version

The previous 3D annotation interface is still available as a legacy tool. You can switch to it anytime via the `Switch to Legacy Tool` button.

Legacy documentation remains accessible for teams continuing to use the previous workflow.

## Summary

The new 3D Point Cloud annotation interface in Supervisely is a major step forward. It combines synchronized 2D and 3D annotation, integrated photo context editing, flexible timeline navigation, and a customizable UI — all in a single, unified workspace.

This all-in-one tool transforms how complex 3D scenes are labeled. Whether you’re working with dynamic datasets, combining multi-modal inputs, or just looking for a faster, clearer way to annotate — this interface delivers accuracy, speed, and clarity at scale. It’s not just an upgrade — it’s a game-changer for 3D annotation workflows.