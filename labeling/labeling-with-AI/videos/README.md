---
description: >-
  In this guide, you'll learn about AI-driven tools which you can use in Supervisely to optimize your video labeling pipelines.
---

# Videos

## Tracking by detection

Tracking by detection is a two-stage video labeling approach that detects objects in each frame and uses data association algorithms to link detections into continuous object tracks.

How tracking by detection works:

1. Per-frame object detection - a pretrained detector (e.g. YOLO, RT-DETRv2) predicts bounding boxes and class labels for each frame.

2. Association between frames - a tracking algorithm (e.g. DeepSORT, BoT-SORT) matches detections from the current frame with previously tracked objects.

3. Track management - create new object tracks for new detections, terminate tracks for lost detections, extend trajectories frame by frame for stable matches.

4. Output - continuous object IDs, bounding boxes and optional metadata (confidence, motion vectors) across entire video.

Tracking by detection works with any detector, what makes this approach highly scalable.

Supervisely Ecosystem uses enhanced custom implementation of BoT-SORT algorithm (you can read more details about our enhaced version of BoT-SORT [here](https://docs.supervisely.com/neural-networks/inference-and-deployment/video-object-tracking)), which can be used with any detector with the help of corresponding app - [Predict App](https://ecosystem.supervisely.com/apps/apply-nn) - it allows to conveniently deploy ML models and apply them to input data.

{% embed url="https://github.com/user-attachments/assets/dd107021-4a32-4522-942b-66d3bd8f7a1e" %}

## First frame initialized trackers

First frame initialized trackers are video tracking models that are initialized with a manual annotation on the first frame (bounding box, segmentation mask or set of points) and use this initial prompt to track given object throughout the rest of the video. Such models are good at following objects through occlusion, motion blur, scale changes and lighting variations. They are widely used in video labeling pipelines because they provide high-quality, consistent object tracks with minimal user effort.

How first frame initialized trackers work:

1. Initial prompt - annotator provides a mask, box or points on the first frame - it acts as the object definition.

2. Feature extraction - tracker encodes image and prompt into object's vector representations.

3. Temporal propagation - as the video progresses, the model predicts the object's location and segmentation based on past masks or boxes, learned embeddings and temporal attention mechanisms. 

4. Identity preservation - tracker ensures the same object keeps the same ID across video frames.

5. Optional refinement - if the tracker drifts or loses the object, annotator can add manual correction and retrack annotations from the fixed position.

Types of first frame initialized trackers:

1. Mask-initialized trackers - these models start from a segmentation mask. Examples: XMem, SAM 2.

2. Box-initialized trackers - these models start from a bounding box. Examples: TransT, MixFormer, MCITrack.

3. Points-initialized trackers - these models start from a set of points. Examples: TAP-Net, PIPs, CoTracker.

First frame initialized trackers significantly reduce manual work because annotators label only one (or several in case of manual corrections) frame instead of hundreds or thousands.

Supervisely Ecosystem provides convenient usage of modern first frame initialized trackers in Video Annotation Tool. You can use apps specialized for specific figures tracking (e.g. MixFormer - for bounding boxes, SAM 2 - for masks, CoTracker - for keypoints, etc.) or use [Auto Track](https://ecosystem.supervisely.com/apps/auto-track) - unversal tarcking app which allows to deploy necessary trackers and automatically find suitable model for tracking of desired figures:

{% embed url="https://github.com/user-attachments/assets/5714d5d9-dce0-4b64-901e-71cae4d86064" %}

## Model ensembles

Model ensembles in video annotation integrate outputs from multiple computer vision models to achieve superior detection, segmentation and tracking performance across frames. By leveraging diverse architectures such as different object detection and segmentation models, motion estimators and trackers, the system compensates for the weaknesses of individual models and produces more robust video labels.

Example of model ensembles for video annotation is Supervisely's AI image labeling assistant - it can be used for both image and video annotation and works by combining several foundation models to find the algorithm which fits given dataset best. Unlike first frame initialized trackers, AI image labeling assistant automatically detects new objects appearing on frame sequence and tracks them until they disappear. It also overcomes another limitation of first frame initialized trackers - memory consumption. In case of first frame initialized trackers, memory consumption is directly proportional to the number of frames in the sequence. For example, if you will try to track segmentation masks from first frame on 400 frames forward with the help of XMem, you will probably face CUDA Out of Memory Error - GPU memory consumption will be too significant. AI image labeling assistant can label video sequences whose length surpasses 1000 frames in one iteration - GPU memory consumtion will be stable throughout whole labeling process.

{% embed url="https://github.com/user-attachments/assets/6b70ca1d-5651-4b74-bb0b-6d3565f4bcfa" %}