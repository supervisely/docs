---
description: >-
  Create image groups inside your dataset by assigning a grouping tag. View and
  label grouped images together, compare annotation results or couple dependednt
  imagiary such as .nrrd studies.
---

# Multi-view images

Supervisely's Multi-View Image Labeling Toolbox allows simultaneous annotation of multiple images on a single screen, significantly streamlining the data annotation process. This guide covers key features, tools, and steps for annotating multi-view images, enabling you to build custom training datasets quickly and effectively.

Check out our comprehensive guide on uploading and annotating multi-view images for custom training datassets simultaneously using multi-view mode.&#x20;

{% embed url="https://supervisely.com/blog/multi-view-image-annotation/" %}

![](<Multi-view images1.gif>)

## Key Features

* Synchronized Views: Annotate objects on multiple images simultaneously, ideal for multi-spectral images.
* Flexible Grouping: Group images by various criteria (e.g., camera angles, object classes) to suit your needs.
* Manual Tools: Use bounding boxes, polygons, masks, brushes, polylines, and keypoints for precise annotations.
* AI-Assisted Segmentation: Speed up labeling with the Smart Tool, leveraging pre-trained models.
* Python SDK: Automate annotation tasks and integrate them into your workflow.

## Multi-View Image Annotation Use-Cases

Multi-view image annotation is beneficial across various industries:

* Multispectral Imaging: Essential for agriculture, environmental monitoring, etc.
* Depth Estimation & 3D Reconstruction: Enhances object depth understanding and 3D modeling.
* Autonomous Vehicles & Traffic Monitoring: Improves model training for object detection and navigation.
* 3D Mapping & GEO Localization: Assists in drone-based navigation and other spatial tasks.
* Medical Imaging & Agriculture: Facilitates precise analysis of complex structures.

## How to Annotate Multi-View Images in Supervisely

### Step 1: Structuring Images

Organize images into groups by creating a project directory. Example:

&#x20;📂 dataset\_name

&#x20; ┣ 📂 group\_name\_1

&#x20; ┃ ┣ 🏞️ image\_1.png

&#x20; ┃ ┣ 🏞️ image\_2.png

&#x20; ┃ ┗ 🏞️ image\_3.png

&#x20; ┗ 📂 group\_name\_2

&#x20;   ┣ 🏞️ image\_4.png

&#x20;   ┣ 🏞️ image\_5.png

&#x20;   ┣ 🏞️ image\_6.png

### Step 2: Importing Images

Use the Import Wizard or the "Import Images Groups" app to upload and group multi-view images. Enable multi-view mode in the Labeling Tool for synchronized annotation.

### Step 3: Annotating Images

Annotate multiple images on a single screen using manual tools or the AI-assisted Smart Tool for faster and more accurate labeling. Customize annotations with tags and other attributes.

### Step 4: Exporting Annotations

Export annotations in various formats (e.g., Supervisely JSON, COCO, YOLO) for further processing or model training.

### Step 5: Collaborating with Teams

Use Supervisely's team features to manage labeling jobs, monitor progress, and ensure quality control during large-scale annotation projects.

### Step 6: Converting Existing Projects (Optional)

Convert existing projects to a multi-view setup using the "Group Images for Multi-View Labeling" app. This enables synchronized annotation for already uploaded images.

## Python SDK Integration

Automate your multi-view annotation processes with the Supervisely Python SDK. This allows for efficient batch processing, custom integrations, and more streamlined workflows.

![](<Multi-view images2.png>)

## Video tutorial <a href="#video-tutorial" id="video-tutorial"></a>

In this 4-minute video guide, you will learn how to import multi-view images and label them in Supervisely Multi-View Image Annotation Tool. The video includes the following steps:

1. Structuring and importing multi-view images into Supervisely
2. Annotating multi-view images using manual tools
3. Speeding up the annotation process with AI-assisted [Supervisely Smart Tool](https://supervisely.com/blog/smarttool-annotation/)
4. Exploring the synchronized views and labeling in Multi-View mode
5. Exporting multi-view images with annotations

{% embed url="https://www.youtube.com/watch?ab_channel=Supervisely&v=VIxYBKSyH0I" %}
