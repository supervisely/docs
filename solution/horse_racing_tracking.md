# Object Tracking for Horse Racing with DEIM
The Supervisely Team is pleased to share a successful solution for tracking objects in horse racing videos using a [DEIM](https://github.com/Intellindust-AI-Lab/DEIM) detector combined with NvSort tracking algorithm to achieve real-time high-performance object tracking in video streams.

## Description
This project aims to provide an effective automated solution for tracking multiple objects in horse racing videos. The system focuses on identifying and tracking several key elements: horses, drivers, sticks, and other racing-related objects with high accuracy and real-time performance.

The core computer vision task involves Object Detection and Multi-Object Tracking - precisely identifying and tracking objects throughout the video frames. Once these objects are detected and tracked, analysts can monitor race performance, analyze race dynamics, and extract valuable insights from the video footage.

**Data type:** Video  
**Task types:** Object Detection, Multi-Object Tracking  
**Used models:** [DEIM](https://github.com/Intellindust-AI-Lab/DEIM), [Florence 2](https://huggingface.co/microsoft/Florence-2-large), [YOLOv12](https://github.com/ultralytics/ultralytics)  
**Pre-processing:** Active Learning for efficient annotation, zero-shot pre-labeling  
**Object classes:** horse, horse head, rider, number plate, white stick, yellow stick

## Solution Approach

The Supervisely Team focused on finding the optimal solution that can be used to solve this case in the most effective way. The solution is based on the following steps:

1. **Import video files** to the Supervisely platform. The dataset consists of 107 horse racing videos that need to be analyzed.
2. **Data annotation with Active Learning** approach to make the labeling process more efficient. We started with zero-shot pre-labeling using Florence 2 model and iteratively trained custom detectors to improve annotations.
3. **Train Object Detection model** using the [DEIM](https://ecosystem.supervisely.com/apps/deim/supervisely_integration/train) architecture, which significantly outperformed alternative models like YOLOv12 in our tests.
4. **Model optimization and export** to TensorRT for maximum inference speed while maintaining accuracy.
5. **Deployment** with the Nvidia DeepStream framework integrated with NvSORT tracker for an accelerated pipeline that achieves 🔴🔴🔴 170 FPS at 1920x1080 resolution on NVIDIA RTX 4090 GPU.

![Solution Approach](../../assets/solution/object_tracking/solution-approach.png)

The complete workflow of the solution contains several steps, each of them described in the corresponding section below. The solution is implemented using the Supervisely platform and its features, such as video annotation, model training, and deploying optimized inference pipelines.

**Table of Contents:**
1. [Import Data](#1-import-data)
2. [Annotation & Active Learning](#2-annotation--active-learning)
3. [Training](#3-training)
4. [Optimization & Deployment](#4-optimization--deployment)
5. [Additional Resources](#additional-resources)

## 1. Import data

The first step of solving the task is to import the video files into the Supervisely platform. There are plenty of ways to do that, and all of them are described in the [Import](https://docs.supervisely.com/import-and-export/import) section of the Supervisely documentation. In this case, we'll briefly describe one of the options - manual upload of the data from the local machine.

1. Create a new project in Supervisely, name it **Horse Racing Videos**. If your workspace is empty, you can just click the Import Data button.
2. Choose the **Videos** option in the Type of project section, and click **Create**.
3. Next, you can drag and drop your video files into the project.

If you need to import files from a remote server or from Cloud Storage, you can use apps like [Import Videos from Cloud Storage](https://ecosystem.supervisely.com/apps/import-videos-from-cloud-storage) or [Remote Import](https://ecosystem.supervisely.com/apps/remote-import).

## 2. Annotation & Active Learning

For efficient annotation of a large dataset, we implemented an Active Learning approach, which makes the process more effective by iteratively training models and using them to assist in annotation. This approach significantly reduces the manual labeling effort required while maintaining high annotation quality.

### Pre-labeling with Florence 2

In the initial phase when no trained models were available suitable for our task, we utilized the [Florence 2](https://huggingface.co/microsoft/Florence-2-large) model with zero-shot capabilities to generate preliminary annotations for the first 500 frames which were uniformly sampled across the videos.

1. We crafted a custom pipeline for Florence 2 to achieve the best possible accuracy from a zero-shot model
2. Applied this pipeline to automatically pre-label the first 500 frames
3. Sent these preliminary annotations for manual review and correction

After manual correction, we evaluated the quality of pre-labeling with Florence 2. The following results were observed:

| Model | Validation Size | F1-score (avg. per-image) | Average Recall (AR) | mAP* |
|-------|-----------------|---------------------------|---------------------|-----|
| Florence-2 pipeline | 500 frames | 0.4869 | 0.411 | 0.089 |

*\*mAP is reported for reference. It is not the main metric for evaluating pre-labeling quality.*

Despite the Average Precision (mAP) being relatively low, the model actually performed well for initial pre-labeling. The **F1-score** of 0.49 indicates that nearly half of the objects were correctly identified, which is a solid starting point for manual refinement of annotations.

### Active Learning Labeling Process

After obtaining the first 500 annotated frames, we started the iterative process of training and annotation (also known as **human-in-the-loop**). In each iteration, we trained a DEIM model on the currently labeled dataset, used it to pre-label the next batch of images, and then had annotators correct any mistakes. This cycle was repeated until the entire dataset of **6000 frames** was annotated. DEIM models were trained with **640x640** input resolution and architecture **DEIM D-FINE-L**.

We performed **3 iterations** of this process with the following dataset sizes:
- **Iteration 1:** 500 annotated frames
- **Iteration 2:** 2000 annotated frames
- **Iteration 3:** 6000 annotated frames

After this, we re-evaluated each trained model on the final validation set of **725 images**. The results of each iteration are summarized in the table below:

| Iteration | Training Size | Validation Size | mAP  |
|-----------|--------------|-----------------|-------|
| 1         | 400          | 725             | 58.71 |
| 2         | 1675         | 725             | 71.98 |
| 3         | 5275         | 725             | 72.93 |

#### Comparing with YOLOv12

We additionally tested **YOLOv12-L** model using the same dataset and training methodology. YOLOv12-L achieved only **45.53** mAP on the first training iteration, and **53.4** mAP on the final iteration, significantly underperforming compared to **DEIM**. Based on these results, DEIM was confirmed as the superior architecture for this application.

| Model   | Iteration | Training Size | mAP |
|---------|-----------|---------------|------|
| YOLOv12-L | 1         | 400           | 45.53 |
| YOLOv12-L | 3         | 5275          | 53.4  |
| DEIM D-FINE-L | 1         | 400           | 58.71 |
| DEIM D-FINE-L | 3         | 5275          | 72.93 |

## 3. Training

After annotation process was completed with 6000 annotated frames, we proceeded to train the final object detection model. We evaluated two architectures: **YOLOv12-L** and **DEIM D-FINE-L**, and selected the one that provided the best balance of accuracy and inference speed for our specific use case.

**DEIM vs. YOLOv12 Comparison:**

| Model   | Dataset size | mAP | Params | Latency | GFLOPs |
|---------|---------------|-----|--------|---------|--------|
| YOLOv12-L | 6000        | 53.4  | 26.4M   | 6.77ms  | 88.9 |
| DEIM D-FINE-L | 6000    | **72.93** | 31M     | 8.07ms  | 91   |

Based on these results, **DEIM** was confirmed as the superior architecture for this application.

Finally, we trained the **DEIM D-FINE-M** model with **1920x1088** input resolution on the full dataset to maximize model performance. This model will be used for processing video streams with target 1920x1080 resolution.

Final score: 🔴🔴🔴**75.12** mAP (1920x1088)

## 4. Optimization & Deployment

To meet the requirement of processing video at 50+ FPS in 1920x1080 resolution, we implemented several optimization techniques:

### TensorRT Export

We exported our trained model to TensorRT engine. TensorRT provides significant acceleration through hardware-specific optimizations on NVIDIA GPUs.

### Nvidia DeepStream Integration

We integrated our TensorRT-optimized model into the Nvidia DeepStream framework. This framework is designed for high-performance video analytics and supports efficient processing pipelines. It also provides built-in multi-object tracking algorithms. We selected the **NvSORT** tracker for its balance of speed and accuracy.

Our optimized pipeline consists of:
1. Video input at 1920x1080 resolution
2. DEIM detector running on TensorRT in 1920x1088 resolution (add 8px padding)
3. NvSORT tracker for associating detections across frames

This setup achieves real-time performance with 🔴🔴🔴**170 FPS** on NVIDIA RTX 4090 GPU, significantly exceeding the 50 FPS requirement.

> See the details in our repository: [DeepStream](https://github.com/supervisely-research/deepstream/)

---

## Additional Resources

- Annotated dataset with 6000 frames stored in Supervisely Team **"Horse Racing"** (id: 109962), workspace **"PRODUCTION WS"**.
- DEIM model artifacts and details: [DEIM Experiment](https://app.supervisely.com/nn/experiments/47383586)
- DeepStream Pipeline with code and tutorial: [DeepStream Pipeline](https://github.com/supervisely-research/deepstream/)

### Exporting the data

At any time, you can export your assets from the Supervisely platform. This applies to both the data (video files with annotations) and the trained models. There are several ways to download and export the data, which are described in the [Export](https://docs.supervisely.com/import-and-export/export) section of the Supervisely documentation. In this case, we'll briefly describe one of the options - exporting the data from the platform's UI.

#### Exporting the data

To export the video project, you can click on the **Three dots** (1) icon on the project, select the **Download** (2) option and choose the needed format (3). We recommend using the **Supervisely JSON Annotation** format, which will export the project with all annotations and metadata.

![Export Project](../../assets/solution/object_tracking/export1.png)

#### Exporting the models

All of the artifacts that were created during the training process are stored in the Team Files.  
Note: there's no vendor lock in Supervisely, so you can download the models and use them completely outside of the Supervisely platform, for example, in your own Python scripts or in Docker containers.
To download the data, go to the **Files** (1) section in the left sidebar, find the needed file or folder (2), right-click on it, and select the **Download** (3) option.

![Export Model](../../assets/solution/object_tracking/export2.png)
