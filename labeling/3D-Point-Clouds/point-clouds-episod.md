---
description: >-
    This article about the new labeling interface for 3D Point Clouds in Supervisely that introduces a significantly enhanced workflow, offering extended functionality and improved usability.
---

# Overview: New Interface for 3D Point Cloud Annotation

The new labeling interface for 3D Point Clouds replaces the previous toolbox, which is now marked as **Legacy**. Users can switch back to the legacy version using the **Switch to Legacy Tool** button if needed.

## Key Features

### Integrated Photo Context Annotation

The photo context panel is now a fully functional part of the labeling interface. It supports direct annotation of images linked to 3D point cloud scenes.

- You can create and edit annotations such as masks, bounding boxes, and tags directly on the images.
- These annotations are synchronized with the 3D scene, allowing for consistent labeling across modalities.
- This integration enables more efficient annotation workflows and better control over complex scenes.

### Timeline Support

The new interface introduces a timeline component similar to the one available in the video labeling tool.

- Allows navigating through point cloud frames or scans.
- Supports time-based annotation and review across episodic datasets.
- Enables users to work with sequential 3D scenes and monitor changes over time.

### Linked 2D–3D Annotations

The new toolbox allows users to link annotations across 2D and 3D views:

- Annotations created on images can be associated with objects in the 3D space.
- Edits made in one view can affect the corresponding annotation in the other.
- This improves annotation consistency and helps identify labeling errors by cross-referencing modalities.

### Updated Interface

The user interface has been redesigned for clarity and extensibility:

- A modern layout with reorganized panels and tools.
- New dropdown menus and contextual actions (currently in development).
- Final appearance may change; screenshots and UI walkthroughs will be added once the interface is finalized.

> **Note**: This documentation focuses on core functionality. Visual updates and examples will be added once the UI stabilizes.

### Access to Legacy Version

The previous point cloud labeling tool remains available under the **Legacy** status.

- You can switch to the legacy tool at any time using the **Switch to Legacy Tool** option in the interface.
- Legacy documentation remains accessible for teams who continue using the previous workflow.

## Summary

The updated interface introduces powerful new tools for annotating 3D point clouds and related images, with full support for time-based annotation and multi-modal synchronization. These enhancements improve the accuracy, scalability, and usability of annotation workflows for 3D datasets.

Additional documentation and examples will follow as the interface nears completion.