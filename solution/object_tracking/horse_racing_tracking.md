# Object Tracking for Horse Racing with DEIM
The Supervisely Team is pleased to share a successful solution for tracking objects in horse racing videos using a [DEIM](https://github.com/DearCaat/DEIM) detector combined with tracking algorithms to achieve high-performance object tracking.

## Description
This project aims to provide an effective automated solution for tracking multiple objects in horse racing videos. The system focuses on identifying and tracking several key elements: horses, drivers, sticks, and other racing-related objects with high accuracy and real-time performance.

The core computer vision task involves Object Detection and Multi-Object Tracking - precisely identifying and tracking objects throughout the video frames. Once these objects are detected and tracked, analysts can monitor race performance, analyze race dynamics, and extract valuable insights from the video footage.

**Data type:** Video  
**Task types:** Object Detection, Multi-Object Tracking  
**Used models:** [DEIM](https://github.com/DearCaat/DEIM), [Florence 2](https://github.com/microsoft/Florence-2), [YOLOv12](https://github.com/ultralytics/ultralytics)  
**Pre-processing:** Active Learning for efficient annotation, zero-shot pre-labeling  

## Solution Approach

The Supervisely Team focused on finding the optimal solution that can be used to solve this case in the most effective way. The solution is based on the following steps:

1. **Import video files** to the Supervisely platform. The dataset consists of 107 horse racing videos that need to be analyzed.
2. **Data annotation** using Active Learning approach to make the labeling process more efficient. We started with zero-shot pre-labeling using Florence 2 model and iteratively trained custom detectors to improve annotations.
3. **Train Object Detection model** using the [DEIM](https://ecosystem.supervisely.com/apps/deim/supervisely_integration/train) architecture, which significantly outperformed alternative models like YOLOv12 in our tests.
4. **Model optimization and export** to TensorRT for maximum inference speed while maintaining accuracy.
5. **Deployment** with the Nvidia DeepStream framework integrated with NvSORT tracker for an accelerated pipeline that achieves 170 FPS at 1920x1088 resolution on NVIDIA RTX 4090 GPU.

![Solution Approach](../../assets/solution/object_tracking/solution-approach.png)

## Solution Overview

The complete workflow of the solution contains several steps, each of them described in the corresponding section below. The solution is implemented using the Supervisely platform and its features, such as video annotation, model training, and deploying optimized inference pipelines.

Table of Contents:
1. [Import Data](#1-import-data)
2. [Annotation](#2-annotation)
3. [Training](#3-training)
4. [Optimization](#4-optimization)
5. [Deployment](#5-deployment)

### 1. Import data

The first step of solving the task is to import the video files into the Supervisely platform. There are plenty of ways to do that, and all of them are described in the [Import](https://docs.supervisely.com/import-and-export/import) section of the Supervisely documentation. In this case, we'll briefly describe one of the options - manual upload of the data from the local machine.

1. Create a new project in Supervisely, name it **Horse Racing Videos**. If your workspace is empty, you can just click the Import Data button.
2. Choose the **Videos** option in the Type of project section, and click **Create**.
3. Next, you can drag and drop your video files into the project.

If you need to import files from a remote server or from Cloud Storage, you can use apps like [Import Videos from Cloud Storage](https://ecosystem.supervisely.com/apps/import-videos-from-cloud-storage) or [Remote Import](https://ecosystem.supervisely.com/apps/remote-import).

### 2. Annotation

For efficient annotation of a large dataset, we implemented an Active Learning approach, which makes the process more effective by iteratively training models and using them to assist in annotation. This approach significantly reduces the manual labeling effort required while maintaining high annotation quality.

#### Bootstrap Phase with Florence 2

In the initial phase when no trained models were available, we utilized the Florence 2 zero-shot model to generate preliminary annotations for the first 500 frames:

1. We crafted a custom pipeline for Florence 2 to achieve the best possible accuracy from a zero-shot model
2. Applied this pipeline to automatically pre-label the first 500 frames
3. Sent these preliminary annotations for manual review and correction

#### Active Learning Iteration Process

After obtaining the first 500 annotated frames, we started the iterative process of training and annotation:

1. **First iteration**:
   - Trained DEIM on 500 manually corrected frames
   - Used this model to pre-label the next 1500 frames
   - Sent pre-labeled frames for manual correction by annotators

2. **Second iteration**:
   - Trained a new DEIM model on 2000 total labeled frames
   - Used this improved model to pre-label the remaining 4000 frames
   - Completed the manual review and correction of these frames

3. **Final training**:
   - Trained the final DEIM model on the complete dataset of 6000 frames
   - Achieved 70.3 mAP on the validation set of 600 images

This approach allowed us to efficiently annotate the necessary frames while continually improving our model's accuracy throughout the process.

#### Annotation Format

The annotations include the following classes:
- Horses
- Drivers
- Sticks
- Other racing-related objects

Each object is annotated with a bounding box that precisely delineates its position in the frame.

### 3. Training

After completing the annotation process, we proceeded to train and evaluate multiple object detection models to identify the best performer for our specific use case.

#### DEIM Model Training

We selected the [DEIM](https://github.com/DearCaat/DEIM) architecture as our primary model due to its superior performance characteristics:

1. Trained the final model on the complete dataset of 6000 annotated frames
2. Configured optimal hyperparameters for horse racing domain
3. Evaluated on a validation set of 600 frames
4. Achieved 70.3 mAP, demonstrating excellent detection capabilities

#### Comparative Analysis

To ensure we selected the best model architecture for our task, we conducted comparative testing:

1. Trained YOLOv12 using the same dataset and training methodology
2. Evaluated YOLOv12 on the same validation set
3. YOLOv12 achieved only 53.4 mAP, significantly underperforming compared to DEIM
4. Based on these results, DEIM was confirmed as the superior architecture for this application

### 4. Optimization

To meet the requirement of processing video at 50+ FPS in 1920x1080 resolution, we implemented several optimization techniques:

#### Model Export and Acceleration

1. Exported the trained DEIM model to TensorRT format
   - TensorRT provides significant acceleration through hardware-specific optimizations
   - Maintained detection accuracy while improving inference speed

2. Optimized model parameters
   - Balanced detection confidence thresholds for optimal accuracy
   - Fine-tuned non-maximum suppression settings to maintain detection quality at high speeds

### 5. Deployment

The final deployment solution combines our optimized detection model with a tracking system to implement a tracking-by-detection approach:

#### Integration with Nvidia DeepStream and NvSORT

1. Configured Nvidia DeepStream framework
   - Integrated our TensorRT-optimized DEIM model
   - Set up the NvSORT tracker for efficient multi-object tracking
   - Optimized pipeline parameters for horse racing video characteristics

2. Performance Results
   - Achieved 170 FPS processing speed at 1920x1088 resolution on NVIDIA RTX 4090 GPU
   - Significantly exceeded the 50 FPS requirement, providing margin for additional processing if needed
   - Maintained high tracking accuracy across diverse racing scenarios

#### Deployment Process

The deployment pipeline is designed for easy integration into existing video processing systems:

1. Video input is processed through the DeepStream framework
2. DEIM detector identifies objects in each frame
3. NvSORT tracker associates detections across frames to maintain consistent object identities
4. Output provides bounding boxes with unique track IDs for each detected object

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
