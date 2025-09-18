# Object Tracking for Horse Racing with DEIM

The Supervisely Team is pleased to share a successful solution for tracking objects in horse racing videos using a [DEIM](https://ecosystem.supervisely.com/apps/deim/supervisely_integration/train) detector combined with **NvSort** tracking algorithm  within NVIDIA's accelerated [DeepStream](https://developer.nvidia.com/deepstream-sdk) environment to achieve real-time, high-performance object tracking in video streams. We efficiently annotated our dataset using an **Active Learning** approach and a pre-labeling pipeline that leverages [Florence 2](https://huggingface.co/microsoft/Florence-2-large) model to minimize manual labeling efforts. Our optimized pipeline achieves **275 FPS** on NVIDIA RTX 4090 GPU while maintaining high detection accuracy with **72.93 mAP**.

## Project Overview

This project delivers an automated solution for tracking objects in horse racing videos with high accuracy and real-time performance. The system identifies and tracks essential racing elements including horses, riders, horse numbers, and other race-related objects throughout video sequences.

Our solution combines two core computer vision techniques: **Object Detection** (locating objects in individual frames) and **Multi-Object Tracking** (following objects across consecutive frames). This enables analysts to monitor race performance, study racing dynamics, and extract actionable insights from video footage.

**Data type:** Video  
**Task types:** Object Detection, Multi-Object Tracking  
**Models used:** [DEIM](https://ecosystem.supervisely.com/apps/deim/supervisely_integration/train), [Florence 2](https://huggingface.co/microsoft/Florence-2-large), [YOLOv12](https://ecosystem.supervisely.com/apps/yolo/supervisely_integration/train)  
**Key techniques:** Zero-shot pre-labeling with Active Learning for efficient annotation, TensorRT optimization, NVIDIA DeepStream integration with NvSORT tracker  
**Target objects:** horse, horse head, rider, number plate, white stick, yellow stick

## Solution Approach

Our team focused on finding the optimal solution that can be used to solve this case in the most effective way. The solution follows these key steps:

1. **Video Import**: Upload 107 horse racing videos to the Supervisely platform for processing and analysis.
2. **Smart Data Annotation**: Implement an Active Learning approach to streamline the labeling process. We begin with zero-shot pre-labeling using [Florence 2](https://huggingface.co/microsoft/Florence-2-large) model, then iteratively train custom detectors to continuously improve annotation quality.
3. **Model Training**: Train our object detection model using [DEIM](https://ecosystem.supervisely.com/apps/deim/supervisely_integration/train) architecture, which demonstrated superior performance compared to alternative models like YOLOv12 in our testing.
4. **Performance Optimization**: Export the trained model to TensorRT format to maximize inference speed while preserving detection accuracy.
5. **Production Deployment**: Deploy using NVIDIA's DeepStream framework integrated with the NvSORT tracker, creating an accelerated pipeline that achieves 275 FPS on NVIDIA RTX 4090 GPU.

![Solution Approach](/assets/solution/object_tracking/solution-approach.png)

The solution is implemented using the Supervisely platform and its features, such as video annotation, model training, and deploying optimized inference pipelines. Each step is detailed in the corresponding sections below.


**Table of Contents:**

1. [Import Data](#id-1.-import-data)
2. [Annotation & Active Learning](#id-2.-annotation-and-active-learning)
3. [Training Experiments](#id-3.-training-experiments)
4. [Optimization & Deployment](#id-4.-optimization-and-deployment)
5. [Exporting Data and Models](#id-5.-exporting-data-and-models)

## 1. Import data

The first step is to import the video files into the Supervisely platform. There are plenty of ways to do that, and all of them are described in the [Import](/data-organization/import/import/import.md) section of the Supervisely documentation. In this case, we'll briefly describe one of the options - manual upload of the data from the local machine.

1. Create a new project in Supervisely (If your workspace is empty, you can just click the **Import Data** button).
2. Choose the **Videos** option in the **Type** of project section, and click **Create**.
3. Next, **drag & drop** your video files into the project.

If you need to import files from a remote server or from Cloud Storage, you can use apps like [Import Videos from Cloud Storage](https://ecosystem.supervisely.com/apps/import-videos-from-cloud-storage) or [Remote Import](https://ecosystem.supervisely.com/apps/remote-import).

## 2. Annotation & Active Learning

For efficient annotation of a large dataset, we implemented an Active Learning approach, which makes the process more effective by iteratively training models and using them to assist in annotation. This approach significantly reduces the manual labeling effort required while maintaining high annotation quality.

### Pre-labeling with Florence 2

In the initial phase when no trained models were available suitable for our task, we utilized [Florence 2](https://huggingface.co/microsoft/Florence-2-large) model with zero-shot capabilities to generate preliminary annotations for the first **500 frames** which were uniformly sampled across the videos.

1. Sampled 500 frames from the input videos uniformly.
2. Crafted a custom pipeline for Florence 2 to achieve the best possible accuracy from a zero-shot model
3. Applied this pipeline to automatically pre-label the first 500 frames
4. Sent these preliminary annotations for manual review and correction

After manual correction, we evaluated the quality of pre-labeling with Florence 2.

| Model | Validation Size | F1-score (avg. per-image) | Average Recall (AR) | mAP* |
|-------|-----------------|---------------------------|---------------------|-----|
| Florence-2 pipeline | 500 frames | 0.4869 | 0.411 | 0.089 |

*\*mAP is reported for reference. It is not the main metric for evaluating pre-labeling quality.*

The model performed quite well for initial pre-labeling. The **F1-score** of 0.49 indicates that nearly half of the objects were correctly identified, which is a solid starting point for manual refinement of annotations.

![Florence 2 Auto Pre-labeling](/assets/solution/horse-racing/florence2-prelabeling.jpg)

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

![DEIM vs YOLOv12 Comparison](/assets/solution/horse-racing/deim-vs-yolo.png)

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

<figure><img src=".gitbook/assets/demo.webm" alt=""><figcaption><p>Demo video</p></figcaption></figure>

{% hint style="info" %}
See our DeepStream setup guide and other details in this repository: [DEIM DeepStream](https://github.com/supervisely-research/deepstream/)
{% endhint %}

## 5. Exporting Data and Models

#### Exporting the data

At any time, you can export your assets from the Supervisely platform. This applies to both the data (video files with annotations) and the trained models. There are several ways to download and export the data, which are described in the [Export](/data-organization/import/export/export.md) section of the Supervisely documentation. In this case, we'll briefly describe one of the options - exporting the data from the platform's UI.

![Export Project](/assets/solution/horse-racing/download-data.png)

#### Exporting the models

All of the artifacts that were created during the training process, including the trained models, are stored in the Team Files. You can just right-click on any folder or file and download it to your local machine.

> Note: there's no vendor lock in Supervisely, so you can use the models completely outside of the Supervisely platform, for example, in your own Python scripts or in Docker containers.

![Export Model](/assets/solution/horse-racing/download-model.png)

{% hint style="info" %}
Check our documentation on how you can use and deploy trained models: [Inference & Deployment](/neural-networks/inference-and-deployment/README.md)
{% endhint %}