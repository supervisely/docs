# Object Tracking for Horse Racing with DEIM

The Supervisely Team is pleased to share a successful solution for tracking objects in horse racing videos using a [DEIM](https://ecosystem.supervisely.com/apps/deim/supervisely_integration/train) detector combined with **NvSort** tracking algorithm in the accelerated [DeepStream](https://developer.nvidia.com/deepstream-sdk) environment to achieve real-time high-performance object tracking in video streams. We annotated a dataset efficiently using an **Active Learning** approach and pre-labeling pipeline leveraging the [Florence 2](https://huggingface.co/microsoft/Florence-2-large) model to minimize manual labeling efforts. In the results, our optimized pipeline achieves **275 FPS** on NVIDIA RTX 4090 GPU while maintaining high accuracy with **72.93 mAP** for object detection.

## Project Overview

This project aims to provide an effective automated solution for tracking target objects in horse racing videos. The system focuses on identifying and tracking several key elements: horses, drivers, road sticks, and other racing-related objects with high accuracy and real-time performance.

The core computer vision task involves Object Detection and Multi-Object Tracking - precisely identifying and tracking objects throughout the video frames. Once these objects are detected and tracked, analysts can monitor race performance, analyze race dynamics, and extract valuable insights from the video footage.

**Data type:** Video  
**Task types:** Object Detection, Multi-Object Tracking  
**Used models:** [DEIM](https://ecosystem.supervisely.com/apps/deim/supervisely_integration/train), [Florence 2](https://huggingface.co/microsoft/Florence-2-large), [YOLOv12](https://ecosystem.supervisely.com/apps/yolo/supervisely_integration/train)  
**Techniques:** Zero-shot pre-labeling and Active Learning for efficient annotation, TensorRT optimization, Nvidia DeepStream integration with NvSORT tracker.  
**Object classes:** horse, horse head, rider, number plate, white stick, yellow stick

## Solution Approach

The Supervisely Team focused on finding the optimal solution that can be used to solve this case in the most effective way. The solution is based on the following steps:

1. **Import video files** to the Supervisely platform. The dataset consists of 107 horse racing videos that need to be analyzed.
2. **Data annotation with Active Learning** approach to make the labeling process more efficient. We started with zero-shot pre-labeling using [Florence 2](https://huggingface.co/microsoft/Florence-2-large) model and iteratively trained custom detectors to improve annotations.
3. **Train Object Detection model** using the [DEIM](https://ecosystem.supervisely.com/apps/deim/supervisely_integration/train) architecture, which significantly outperformed alternative models like YOLOv12 in our tests.
4. **Model optimization and export** to TensorRT for maximum inference speed while maintaining accuracy.
5. **Deployment** with the Nvidia DeepStream framework integrated with NvSORT tracker for an accelerated pipeline that achieves 275 FPS on NVIDIA RTX 4090 GPU.

![Solution Approach](../../assets/solution/object_tracking/solution-approach.png)

The complete workflow of the solution contains several steps, each of them described in the corresponding section below. The solution is implemented using the Supervisely platform and its features, such as video annotation, model training, and deploying optimized inference pipelines.

**Table of Contents:**
1. [Import Data](#1-import-data)
2. [Annotation & Active Learning](#2-annotation--active-learning)
3. [Training Experiments](#3-training-experiments)
4. [Optimization & Deployment](#4-optimization--deployment)
5. [Exporting Data and Models](#exporting-data-and-models)

## 1. Import data

The first step is to import the video files into the Supervisely platform. There are plenty of ways to do that, and all of them are described in the [Import](https://docs.supervisely.com/import-and-export/import) section of the Supervisely documentation. In this case, we'll briefly describe one of the options - manual upload of the data from the local machine.

1. Create a new project in Supervisely (If your workspace is empty, you can just click the **Import Data** button).
2. Choose the **Videos** option in the **Type** of project section, and click **Create**.
3. Next, **drag & drop** your video files into the project.

If you need to import files from a remote server or from Cloud Storage, you can use apps like [Import Videos from Cloud Storage](https://ecosystem.supervisely.com/apps/import-videos-from-cloud-storage) or [Remote Import](https://ecosystem.supervisely.com/apps/remote-import).

## 2. Annotation & Active Learning

For efficient annotation of a large dataset, we implemented an Active Learning approach, which makes the process more effective by iteratively training models and using them to assist in annotation. This approach significantly reduces the manual labeling effort required while maintaining high annotation quality.

### Pre-labeling with Florence 2

In the initial phase when no trained models were available suitable for our task, we utilized the [Florence 2](https://huggingface.co/microsoft/Florence-2-large) model with zero-shot capabilities to generate preliminary annotations for the first **500 frames** which were uniformly sampled across the videos.

1. Sampled 500 frames from the input videos uniformly.
2. Crafted a custom pipeline for Florence 2 to achieve the best possible accuracy from a zero-shot model
3. Applied this pipeline to automatically pre-label the first 500 frames
4. Sent these preliminary annotations for manual review and correction


After manual correction, we evaluated the quality of pre-labeling with Florence 2.

| Model | Validation Size | F1-score (avg. per-image) | Average Recall (AR) | mAP* |
|-------|-----------------|---------------------------|---------------------|-----|
| Florence-2 pipeline | 500 frames | 0.4869 | 0.411 | 0.089 |

*\*mAP is reported for reference. It is not the main metric for evaluating pre-labeling quality.*

The model performed well for initial pre-labeling. The **F1-score** of 0.49 indicates that nearly half of the objects were correctly identified, which is a solid starting point for manual refinement of annotations.

### Active Learning Labeling Process

After obtaining the first 500 annotated frames, we started the iterative process of training and annotation (also known as **human-in-the-loop**). In each iteration, we trained a [DEIM](https://ecosystem.supervisely.com/apps/deim/supervisely_integration/train) model on the currently labeled dataset, used it to pre-label the next batch of images, and then had annotators correct any mistakes. This cycle was repeated until the entire dataset of **6000 frames** was annotated. DEIM models were trained with **640x640** input resolution and architecture **DEIM D-FINE-L**.

We performed **3 iterations** of this process with the following dataset sizes:
- **Iteration 1:** 500 annotated frames
- **Iteration 2:** 2000 annotated frames
- **Iteration 3:** 6000 annotated frames

After this, we re-evaluated all intermediate models on the final validation set of **725 images**. The results of each iteration are summarized in the table below:

| Iteration | Training Size | Validation Size | mAP  |
|-----------|--------------|-----------------|-------|
| 1         | 400          | 725             | 58.71 |
| 2         | 1675         | 725             | 71.98 |
| 3         | 5275         | 725             | 72.93 |

## 3. Training Experiments

After the annotation process was completed with 6000 annotated frames, we proceeded to train the final object detection model. We evaluated two architectures: **YOLOv12-L** and **DEIM D-FINE-L**, and selected the one that provided the best balance of accuracy and inference speed for our specific use case.

#### Comparing DEIM with YOLOv12

We tested the YOLOv12-L model using the same dataset and training methodology. **YOLOv12-L** achieved only **45.53** mAP on the first training iteration, and **53.4** mAP on the final iteration, significantly underperforming compared to **DEIM**.

| Model   | Iteration | Training Size | mAP |
|---------|-----------|---------------|------|
| YOLOv12-L | 1         | 400           | 45.53 |
| YOLOv12-L | 3         | 5275          | 53.4  |
| DEIM D-FINE-L | 1         | 400           | **58.71** |
| DEIM D-FINE-L | 3         | 5275          | **72.93** |

**Architecture Comparison:**

| Model   | Dataset size | mAP | Params | Latency | GFLOPs |
|---------|---------------|-----|--------|---------|--------|
| YOLOv12-L | 6000        | 53.4  | 26.4M   | 6.77ms  | 88.9 |
| DEIM D-FINE-L | 6000    | **72.93** | 31M     | 8.07ms  | 91   |

Based on these results, **DEIM** was confirmed as the superior architecture for this application.

### Training with Different Resolution

We also experimented with training DEIM model at different input resolutions: **640x640**, **1536x864**, and **1920x1088** (Note, that DEIM input size should be divisible by 32) on the same GPU NVIDIA RTX 4090 with 24GB VRAM. We selected model variants and batch sizes that fit into the GPU memory.

| Model Variant | Input Size | Batch Size | Epochs | mAP   |
|---------------|------------|------------|--------|-------|
| DEIM D-FINE-S | 1536x864   | 4          | 100    | 64.87 |
| DEIM D-FINE-N | 1920x1088  | 12         | 110    | 70.88 |
| DEIM D-FINE-L | 640x640    | 8          | 100    | **72.93** |

We observed that training at higher resolutions did not yield better accuracy. Training at higher resolutions required either smaller batch size or a model variant with fewer parameters to fit into GPU memory. The **DEIM D-FINE-L** model trained at **640x640** resolution achieved the highest mAP of **72.93**.

Finally, we chose the **DEIM D-FINE-L** at **640x640** for further deployment.

## 4. Optimization & Deployment

To meet the requirement of processing video at 50+ FPS in 1920x1080 resolution, we implemented several optimization techniques:

### TensorRT Export

We exported our trained model to TensorRT engine. [TensorRT](https://developer.nvidia.com/tensorrt) provides significant acceleration through hardware-specific optimizations on NVIDIA GPUs.

### Nvidia DeepStream Integration

We integrated our TensorRT-optimized model into the [Nvidia DeepStream](https://developer.nvidia.com/deepstream-sdk) framework. This framework is designed for high-performance video analytics and supports efficient processing pipelines. It also provides built-in multi-object tracking algorithms. We selected the **NvSORT** tracker for its balance of speed and accuracy.

**Our optimized pipeline consists of:**
1. Video input at 1920x1080 resolution
2. DEIM detector running on TensorRT in 640x640 resolution
3. NvSORT tracker for associating detections across frames

This setup achieves real-time performance with **275 FPS** on NVIDIA RTX 4090 GPU, significantly exceeding the 50 FPS requirement.

> See our DeepStream setup guide and details in this repository: [DEIM DeepStream](https://github.com/supervisely-research/deepstream/)

---

## Exporting Data and Models

#### Exporting the data

At any time, you can export your assets from the Supervisely platform. This applies to both the data (video files with annotations) and the trained models. There are several ways to download and export the data, which are described in the [Export](https://docs.supervisely.com/import-and-export/export) section of the Supervisely documentation. In this case, we'll briefly describe one of the options - exporting the data from the platform's UI.

![Export Project](/assets/solution/temporal_action_localization/export1.png)

#### Exporting the models

All of the artifacts that were created during the training process, including the trained models, are stored in the Team Files. You can just right-click on any folder or file and download it to your local machine.

> Note: there's no vendor lock in Supervisely, so you can use the models completely outside of the Supervisely platform, for example, in your own Python scripts or in Docker containers.

![Export Model](/assets/solution/temporal_action_localization/export2.png)
