---
description: >-
  In this guide, you'll learn about AI-driven tools which you can use in Supervisely to optimize your 3D point clouds labeling pipelines.
---

# 3D Point Clouds

## Pretrained models

Using pretrained models for labeling 3D point clouds is a powerful way to automate and accelerate the creation of 3D datasets for applications like autonomous driving, robotics, mapping and augmented reality. Pretrained models for 3D point cloud labeling leverage large-scale 3D datasets and advanced deep-learning architectures to automatically detect and segment objects in LiDAR data. Instead of manually annotating every point or cuboid - a very time-consuming process - pretrained 3D models generate high-quality labels that humans only need to validate or refine.

Supervisely Ecosystem allows to use pretrained models for 3D object detection - such as CenterFormer, CenterPoint, PV-RCNN, Part-A2, 3DSSD, PointPillars and others with the help of [Serve MMDetection3D](https://ecosystem.supervisely.com/apps/mmdetection3d-v1.x/supervisely-serve) app. All these architectures can also be trained on custom dataset with the help of corresponding train app - [Train MMDetection3D](https://ecosystem.supervisely.com/apps/mmdetection3d-v1.x/supervisely-train).

screen_record.mp4

## First frame initialized trackers

First-frame initialized trackers for 3D point clouds are tracking models that begin with a single human annotation on the first frame (usually a cuboid or a point-level mask) and then automatically follow that same object through the remainder of the point cloud sequence. This approach mirrors 2D video object tracking, but adapted to the unique geometry, sparsity and motion characteristics of 3D LiDAR data.

How first frame initialized 3D trackers work:

1. Initialization with one annotation - annotator labels the object in the first frame (3D bounding box or oint-wise mask) - it serves as the reference template.

2. Feature extraction - model encodes 3D geometry of the object, surface structure abd motion context.

3. Temporal propagation - for each new LiDAR frame, tracker predicts the object’s new pose, estimates displacement and rotation, matches object-specific features (geometry, shape signatures) and applies motion models (Kalman, constant velocity, flow-based).

4. Identity preservation - tracker maintains a persistent object ID, ensiring the same object keeps the same ID across all point clouds in sequence.

5. Optional human corrections - if the tracker begins to make mistakes, a single correction re-stabilizes it  and further frames benefit automatically.

An example of first frame initialized tracker for 3D point clouds in MBPTrack, which can be easily used in Supervisely 3D Point Cloud labeling tool.

screen_record.mp4


## 3D AI assistant

Supervisely's 3D AI assistant is a universal tool for automating 3D point cloud labeling. It covers all types of labeling scenarios for 3D point clouds: 3D object detection, ground segmentation, 3D cuboid tracking, transfer of 2D annotations from photo context images to original 3D point clouds. This tool is class-agnostic - it means that it works with any type of objects regardless of their shape and point density without any fine-tuning.

Here is a brief overview of tasks which can be solved with 3D AI assistant:

Interactive 3D object detection:

screen_record.mp4

3D point cloud ground segmentation:

screen_record.mp4

3D cuboid tracking:

screen_record.mp4

Transfer of annotations from 2D photo context images to 3D point clouds:

screen_record.mp4

For more details, check our [3D Point Cloud and Episodes](https://docs.supervisely.com/labeling/labeling-toolbox/3d-point-cloud-episodes-2) tutorial.