---
description: >-
  Create image groups inside your dataset by assigning a grouping tag. View and
  label grouped images together, compare annotation results, or couple dependent
  imagery such as .nrrd studies.
---

# Multiview images

Supervisely's MultiView Image Labeling Toolbox allows simultaneous annotation of multiple images on a single screen, significantly streamlining the data annotation process. This guide covers key features, tools, and steps for annotating multiview images, enabling you to build custom training datasets quickly and effectively.

Check out our comprehensive guide on uploading and annotating multiview images for custom training datassets simultaneously using multiview mode.&#x20;

{% embed url="https://supervisely.com/blog/multi-view-image-annotation/" %}

![](<Multi-view images1.gif>)

## Key Features

**Synchronized Views:** Annotate objects on multiple images simultaneously, ideal for multi-spectral images.

**Flexible Grouping:** Group images by various criteria (e.g., camera angles, object classes) to suit your needs.

**Label Groups:** allow multiple labels to be organized under a shared group, making annotation more structured and manageable. Grouped labels are visually connected and can be efficiently managed within the Objects tab.

**Manual Tools:** Use bounding boxes, polygons, masks, brushes, polylines, and keypoints for precise annotations.

**AI-Assisted Segmentation:** Speed up labeling with the Smart Tool, leveraging pre-trained models.

**Python SDK:** Automate annotation tasks and integrate them into your workflow.

## How to Annotate Multiview Images in Supervisely

### Step 1: Structuring Images

Organize images into groups by creating a project directory. Example:

```text
📂 dataset_name
 ┣ 📂 group_name_1
 ┃ ┣ 🏞️ image_1.png
 ┃ ┣ 🏞️ image_2.png
 ┃ ┗ 🏞️ image_3.png
 ┗ 📂 group_name_2
    ┣ 🏞️ image_4.png
    ┣ 🏞️ image_5.png
    ┗ 🏞️ image_6.png
```

### Step 2: Importing Images

Use the Import Wizard or the "Import Images Groups" app to upload and group multiview images. Enable multiview mode in the Labeling Tool for synchronized annotation.

### Step 3: Annotating Images

Annotate multiple images on a single screen using manual tools or the AI-assisted Smart Tool for faster and more accurate labeling. Customize annotations with tags and other attributes.

### Step 4: Exporting Annotations

Export annotations in various formats (e.g., Supervisely JSON, COCO, YOLO) for further processing or model training.

### Step 5: Collaborating with Teams

Use Supervisely's team features to manage labeling jobs, monitor progress, and ensure quality control during large-scale annotation projects.

### Step 6: Converting Existing Projects (Optional)

Convert existing projects to a multiview setup using the "Group Images for MultiView Labeling" app. This enables synchronized annotation for already uploaded images.

## Python SDK Integration

Automate your multiview annotation processes with the Supervisely Python SDK. This allows for efficient batch processing, custom integrations, and more streamlined workflows.

![](<Multi-view images2.png>)

## Video tutorial <a href="#video-tutorial" id="video-tutorial"></a>

In this 4-minute video guide, you will learn how to import multiview images and label them in Supervisely MultiView Image Annotation Tool. The video includes the following steps:

1. Structuring and importing multiview images into Supervisely
2. Annotating multiview images using manual tools
3. Speeding up the annotation process with AI-assisted [Supervisely Smart Tool](https://supervisely.com/blog/smarttool-annotation/)
4. Exploring the synchronized views and labeling in MultiView mode
5. Exporting multiview images with annotations

{% embed url="https://www.youtube.com/watch?ab_channel=Supervisely&v=VIxYBKSyH0I" %}
