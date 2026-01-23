# Object detection with YOLO 26

## Overview

YOLO26 is the latest version of YOLO model family developed by [Ultralytics](https://www.ultralytics.com/). It demonstrates decent accuracy in real-time computer vision tasks and proposes accessible deployment. YOLO26 is integrated into Supervisely Ecosystem in the form of [Train YOLO v8-26](https://ecosystem.supervisely.com/apps/yolo/supervisely_integration/train) and [Serve YOLO v8-26 apps](https://ecosystem.supervisely.com/apps/yolo/supervisely_integration/serve) - for training and inference respectively.

<figure><img src="https://github.com/user-attachments/assets/48b2f60a-1c25-4dd1-a235-b676ac3ad39d" alt=""><figcaption></figcaption></figure>

## What's new

**DFL Elimination**

While effective, the Distribution Focal Loss (DFL) module added complexity during export and reduced hardware compatibility. YOLO26 removes DFL entirely, streamlining inference and expanding support for edge and low-power devices.

**True End-to-End, NMS-Free Inference**

Unlike conventional detectors that depend on NMS as a post-processing step, YOLO26 operates as a fully end-to-end model. It produces predictions directly, lowering latency and enabling faster, lighter, and more robust production deployment.

**ProgLoss + STAL**

Enhanced loss designs boost overall detection accuracy, with especially strong gains in small-object detection—crucial for IoT, robotics, aerial imagery, and other edge-focused use cases.

**MuSGD Optimizer**

YOLO26 introduces MuSGD, a hybrid optimizer that blends SGD with Muon. Inspired by Moonshot AI’s Kimi K2, it brings advanced optimization techniques from LLM training into computer vision, resulting in more stable training and quicker convergence.

**Up to 43% Faster CPU Inference**

Purpose-built for edge computing, YOLO26 achieves major CPU inference speedups, delivering real-time performance even on devices without GPUs.

**Enhanced Instance Segmentation**

Adds semantic segmentation loss to improve convergence and upgrades the proto module to exploit multi-scale features, producing higher-quality segmentation masks.

## Getting started: training YOLO26 in Supervisely

This section shows how to train YOLO26 using [Train YOLO v8–26]((https://ecosystem.supervisely.com/apps/yolo/supervisely_integration/train)) app inside Supervisely Ecosystem.

### Prerequisites

- A Supervisely project with annotated images for **object detection** or **instance segmentation**.  
- A running [agent](https://docs.supervisely.com/agents/connect-your-computer) with GPU access (recommended for training).

We will take [Surgical Tools dataset](https://datasetninja.com/labeled-surgical-tools-and-images) from Dataset Ninja as an example.

<figure><img src="https://github.com/user-attachments/assets/34e43529-7b2e-4420-97b4-675140acb6aa" alt=""><figcaption></figcaption></figure>

### Step 1 — Launch the training app

1. Open app ecosystem.  
2. Choose Train YOLO v8 – 26 app.  
3. Select images project for model training.

<figure><img src="https://github.com/user-attachments/assets/eb582192-bc1d-4d89-b9e7-2ba5eb95046c" alt=""><figcaption></figcaption></figure>

Alternatively, you can launch training app from context menu of your images project:

<figure><img src="https://github.com/user-attachments/assets/b239da79-1430-4cd1-8b3e-31c021261d83" alt=""><figcaption></figcaption></figure>

### Step 2 — Choose YOLO26 model variant and task type

1. Select whether to start from Ultralytics checkpoint pretrained on COCO or from a your previous YOLO26 experiment stored in Team Files.
2. Choose one of the available YOLO26 variants, depending on your speed/accuracy and hardware budget.

<figure><img src="https://github.com/user-attachments/assets/c5d041b8-f0b3-4fe5-bd01-2d147abebc6a" alt=""><figcaption></figcaption></figure>

### Step 2 — Configure dataset split

1. Select suitable data split method (random / based on item tags / based on datasets / based on collections).

<figure><img src="https://github.com/user-attachments/assets/c5d041b8-f0b3-4fe5-bd01-2d147abebc6a" alt=""><figcaption></figcaption></figure>

### Step 3 — Select annotation classes for training

1. Pick the subset of classes that YOLO26 should learn (you can train on all or only a part of total).

<figure><img src="https://github.com/user-attachments/assets/25867c61-a201-4922-b191-95fa9e0e60d9" alt=""><figcaption></figcaption></figure>

### Step 5 — Configure training hyperparameters

1. Set training parameters such as batch size, number of epochs, learning rate and many others.

<figure><img src="https://github.com/user-attachments/assets/2f1abd97-3782-4c60-93f4-ce05012fc8a9" alt=""><figcaption></figcaption></figure>

### Step 6 — Run Training

1. Enter an experiment name and click **Start** to launch training.  

<figure><img src="https://github.com/user-attachments/assets/aa587e24-06be-4030-8954-13716820ebba" alt=""><figcaption></figcaption></figure>

2. Monitor training progress epoch by epoch in app UI.

<figure><img src="https://github.com/user-attachments/assets/d688062c-3b7f-47f6-abf7-010a5cc1756d" alt=""><figcaption></figcaption></figure>

3. Click **Open Tensorboard** to monitor key performance metrics and loss function values.

<figure><img src="https://github.com/user-attachments/assets/411f257e-3439-4129-84a3-869f0c5667ef" alt=""><figcaption></figcaption></figure>

4. Once training finishes, links to checkpoints and logs will appear in app UI - they are stored under **Team Files → experiments → <your_experiment_name>**.

<figure><img src="https://github.com/user-attachments/assets/13e5f578-4411-43d1-8a00-b16720557b9c" alt=""><figcaption></figcaption></figure>

## Deploying YOLO26 as a REST API service

Now, when we got custom YOLO26 checkpoint, we can use the **Serve YOLO v8–26** app to deploy YOLO26 models as a REST API service.

### Step 1 — Launch the serve app

1. Run **Serve YOLO v8 – 26** from the Ecosystem. 
2. Choose the target agent (GPU or CPU) that will host the model service.

<figure><img src="https://github.com/user-attachments/assets/e618e083-ac5a-41ef-b65a-c904439b58f7" alt=""><figcaption></figcaption></figure>

### Step 2 — Select model and runtime

1. Choose one either model pretrained on COCO dataset or custom checkpoint fine-tuned on one of your own dataset

<figure><img src="https://github.com/user-attachments/assets/68e45a5d-aee7-465e-8c08-a857545d16c4" alt=""><figcaption></figcaption></figure>

<figure><img src="https://github.com/user-attachments/assets/e404a9d5-479d-4c93-ae88-5c1b494d7023" alt=""><figcaption></figcaption></figure>

2. Pick the runtime engine:
   - **Pytorch** - classic runtime for ML models 
   - **ONNXRuntime**  - acts like a universal translator for ML models, useful if you want framework-agnostic deployment
   - **TensorRT** - high-performance inference runtime which optimizes models specifically for NVIDIA GPUs

<figure><img src="https://github.com/user-attachments/assets/86ea5e40-044c-445e-ac2f-7f1787d61ff7" alt=""><figcaption></figcaption></figure>

### Step 3 — Deploy selected model

1. Click **Serve** and wait for the service status to become **running** in the app UI.  

<figure><img src="https://github.com/user-attachments/assets/8fae6e25-d7d7-4688-91c3-0d15dc0617ce" alt=""><figcaption></figcaption></figure>


## Using trained YOLO26 model inside Supervisely Platform

Supervisely Ecosystem provided convenient apps for labeling data with trained neural networks. You can use [Predict App](https://ecosystem.supervisely.com/apps/apply-nn) to label your data with both pretrained and custom neural networks.

### Step 1 — Launch Predict App

1. Run Predict app from the Ecosystem

<figure><img src="https://github.com/user-attachments/assets/1c35e352-17e4-41a0-87c6-58c2b124c68a" alt=""><figcaption></figcaption></figure>

