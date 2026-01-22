---
description: >-
  In this guide, you'll learn about AI-driven tools which you can use in Supervisely to optimize your 3D point clouds labeling pipelines.
---

# 3D Point Clouds

## Pretrained models

Using pretrained models for labeling 3D point clouds is a powerful way to automate and accelerate the creation of 3D datasets for applications like autonomous driving, robotics, mapping and augmented reality. Pretrained models for 3D point cloud labeling leverage large-scale 3D datasets and advanced deep-learning architectures to automatically detect and segment objects in LiDAR data. Instead of manually annotating every point or cuboid - a very time-consuming process - pretrained 3D models generate high-quality labels that humans only need to validate or refine.

Supervisely Ecosystem allows to use pretrained models for 3D object detection - such as CenterFormer, CenterPoint, PV-RCNN, Part-A2, 3DSSD, PointPillars and others with the help of [Serve MMDetection3D](https://ecosystem.supervisely.com/apps/mmdetection3d-v1.x/supervisely-serve) app. All these architectures can also be trained on custom dataset with the help of corresponding train app - [Train MMDetection3D](https://ecosystem.supervisely.com/apps/mmdetection3d-v1.x/supervisely-train).

Here is how to apply pretrained 3D object detection model to a sequence of 3D point clouds with the help of [Apply 3D Detection to Pointcloud Project](https://ecosystem.supervisely.com/apps/apply-det3d-to-project-dataset) app:

{% embed url="https://github.com/user-attachments/assets/73e234b7-a6e7-4e89-909b-e73455177906" %}

Result:

<figure><img src="https://github.com/user-attachments/assets/e8f8cd4e-4fc8-4a85-8fb3-d9a2d1f741bf" alt=""><figcaption></figcaption></figure>

## First frame initialized trackers

First-frame initialized trackers for 3D point clouds are tracking models that begin with a single human annotation on the first frame (usually a cuboid or a point-level mask) and then automatically follow that same object through the remainder of the point cloud sequence. This approach mirrors 2D video object tracking, but adapted to the unique geometry, sparsity and motion characteristics of 3D LiDAR data.

How first frame initialized 3D trackers work:

1. Initialization with one annotation - annotator labels the object in the first frame (3D bounding box or oint-wise mask) - it serves as the reference template.

2. Feature extraction - model encodes 3D geometry of the object, surface structure abd motion context.

3. Temporal propagation - for each new LiDAR frame, tracker predicts the object's new pose, estimates displacement and rotation, matches object-specific features (geometry, shape signatures) and applies motion models (Kalman, constant velocity, flow-based).

4. Identity preservation - tracker maintains a persistent object ID, ensiring the same object keeps the same ID across all point clouds in sequence.

5. Optional human corrections - if the tracker begins to make mistakes, a single correction re-stabilizes it  and further frames benefit automatically.

An example of first frame initialized tracker for 3D point clouds in [MBPTrack](https://ecosystem.supervisely.com/apps/mbptrack3d/supervisely_integration/serve), which can be easily used in Supervisely 3D Point Cloud labeling tool:

{% embed url="https://github.com/user-attachments/assets/c8f88dd6-6882-43cd-86c1-7ba1ed16aadd" %}


## 3D AI assistant

Supervisely's 3D AI assistant is a universal tool for automating 3D point cloud labeling. It covers all types of labeling scenarios for 3D point clouds: 3D object detection, ground segmentation, 3D cuboid tracking, transfer of 2D annotations from photo context images to original 3D point clouds. This tool is class-agnostic - it means that it works with any type of objects regardless of their shape and point density without any fine-tuning.

Here is a brief overview of tasks which can be solved with 3D AI assistant:

Interactive 3D object detection:

{% embed url="https://github.com/user-attachments/assets/dd5618d8-410f-4783-b7d7-d5c80974147a" %}

Automatic correction of manually created 3D cuboid:

{% embed url="https://github.com/user-attachments/assets/984e91ba-1237-428f-9857-82f9470c48a7" %}

3D point cloud ground segmentation:

{% embed url="https://github.com/user-attachments/assets/4fc84ce7-60ac-432e-a75a-1257daf88828" %}

3D cuboid tracking:

{% embed url="https://github.com/user-attachments/assets/93ede72a-7003-4e1e-b9d6-aa790487c346" %}

Transfer of annotations from 2D photo context images to 3D point clouds, including:

2D bounding boxes to 3D cuboids:

{% embed url="https://github.com/user-attachments/assets/84b744e5-ade0-49d1-81f1-61e0748726f8" %}

2D masks to 3D masks:

{% embed url="https://github.com/user-attachments/assets/b658cfd4-8d11-498d-90e5-f9b0b7da2ae7" %}

2D polylines to 3D polylines:

{% embed url="https://github.com/user-attachments/assets/3c59ca1a-88a9-4440-bc6a-01a87bdbf2c4" %}

For more details, check our [3D Point Cloud and Episodes](https://docs.supervisely.com/labeling/labeling-toolbox/3d-point-cloud-episodes-2) tutorial.