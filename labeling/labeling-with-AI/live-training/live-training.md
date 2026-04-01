---
description: >-
  🔴🔴🔴 This guide shows how Live Training in Supervisely lets models learn from human annotation in real time, improving predictions and speeding up labeling.
layout:
  pagination:
    visible: false
---

# Live Training

## Introduction

Live Training is a novel framework built by Supervisely where AI models train in parallel with human annotation. As annotators label images, the model quickly adapts to the domain-specific data and annotation patterns. After just 5-10 labeled images, it begins generating useful predictions (pre-labels) that accelerate labeling. The quality of these predictions continuously improves with every new image labeled.

By project completion, you get both a fully annotated dataset and a trained model ready for deployment, with accuracy equivalent to a model trained through conventional offline training.

**Live Training solves two limitations in AI-assisted annotation:**

1. Zero-shot foundation models (SAM, GroundingDINO) are helpful in annotating common objects (human, animals, vehicles), but they fail on specialized domains with almost zero assistance.
2. Conventional workflows such as Human-in-the-loop and Active Learning involve manual coordination that always create coordination overhead and idle time, resulting in high costs and timelines of annotation projects.

Live Training approach transforms annotation projects from a multi-week, multi-team coordination challenge into a streamlined single-phase workflow where AI assistance grows naturally from the first annotation onward.

**How it works:**

1. You annotate images in the Labeling Tool as usual (manually, or using other AI-assisted tools).
2. After annotating 2-5 images, the AI model starts generating predictions for each new image.
3. You review and correct the predictions.
4. The model learns from your corrected annotations in real time, improving its accuracy with every new annotation.

## Quickstart

{% hint style="info" %}
🔴🔴🔴 Currently, Live Training is available only in **Enterprise** instances.
{% endhint %}

### 1. Launch Live Training

Navigate to the Labeling Tool interface. On the top panel, click the blue ✨ **Auto Labeling** button to open the AI assistance configuration panel, then select the **Live Training** option.

<figure><img src="../../../.gitbook/assets/live-training/live-training.jpg" alt="Select Live Training from the Auto Labeling menu"><figcaption></figcaption></figure>

If a Live Training session is already running, you will see it in the dropdown list and can use the existing session. To start a new one, click **Launch App**.

Choose the type of model that fits your annotation task. Currently, there are two options:

- **Live Training Segmentation**
- **Live Training Detection**

Configure the app's settings in the modal window and click **Run** to launch the Live Training application.

<!-- 
<figure><img src="../../../.gitbook/assets/live-training/live-training1.jpg" alt="Launch a new Live Training session and select model type"><figcaption></figcaption></figure> -->

Each Live Training session is attached to a specific project and its classes. If you want to use Live Training for a different project, you should launch a new session from that project's labeling interface.

{% hint style="info" %}
💡 Alternatively, you can start Live Training from the Ecosystem, like a regular Supervisely application. In this way you should select the needed project from the app's launch menu.
{% endhint %}

**Start Live Training**

While the Live Training application is launching, a floating panel will display the progress of the app startup.

<figure><img src="../../../.gitbook/assets/live-training/live-training-2.jpg" alt="Live Training app startup progress"><figcaption></figcaption></figure>

Once the application is ready, the floating panel will show the **Start Live Training** button. Ensure you've created all the necessary classes in your project before starting, as Live Training will use only the existing classes for training and prediction. Click this button to confirm the beginning of training.

<figure><img src="../../../.gitbook/assets/live-training/live-training-3.jpg" alt="Click Start Live Training to begin"><figcaption></figcaption></figure>

### 2. Annotate Initial Samples

After you start Live Training, the floating panel will show the status **Annotate 2 more images**. Before the model starts generate predictions, it requires a few labeled images to learn your specific domain.

1. Annotate your first image manually.
2. Click **Finish & Next** button on the floating panel. This will save the annotation and add it to the model training, and you will be taken to the next image.
3. Repeat this process for at least 2-3 images.

<figure><img src="../../../.gitbook/assets/live-training/live-training4.jpg" alt="Annotate initial samples manually to start training"><figcaption></figcaption></figure>

### 3. Learning

After annotating 2-3 initial images, the status will change to **Learning**. At this stage, the model starts learning from your annotations in the background. Continue annotating more images and submitting them to the model by clicking **Finish & Next**. After a short period, the model will begin generating predictions.

### 4. AI Starts Predicting

Once the model has adapted to the initial annotations, it starts generating predictions every time you click **Finish & Next**. Review the model predictions, correct any mistakes, and submit the annotations to further improve the model. At this early stage, results may be rough, you can **Discard** predictions to remove them and annotate manually if the suggestions are not helpful. Use the **Predict** button to generate predictions again after discarding.

The model quality is now displayed in the floating panel, it will be refreshed after every new image labeled.

<figure><img src="../../../.gitbook/assets/live-training/live-training5.jpg" alt="Predict button appears in the labeling interface"><figcaption></figcaption></figure>

### 5. Continuous Improvement

As you continue annotating with the model assistance, the accuracy rapidly improves. The more you annotate, the better the model becomes at understanding your specific data and annotation style. Over time, the model will generate almost perfect predictions, allowing you to simply review and accept them, significantly speeding up your annotation workflow.

<figure><img src="../../../.gitbook/assets/live-training/live-training6.jpg" alt="Model prediction quality improves over time"><figcaption></figcaption></figure>

{% embed url="https://youtu.be/H1aJknl1NtM" %}

## Save & Load Live Training Sessions

Your Live Training sessions automatically sync to the **Experiments** page. This centralized dashboard allows you to manage training runs, monitor progress, and reload models to resume training later.

<figure><img src="../../../.gitbook/assets/live-training/live-training-7.jpg" alt="Experiments page showing saved models and checkpoints"><figcaption></figcaption></figure>

The system automatically saves model checkpoints at regular intervals. A checkpoint preserves the exact state of your model weights at a specific point in time.

{% hint style="success" %}
💡 **Tip**: If your annotation session is paused or interrupted, you can safely resume it later by loading the latest checkpoint from the **Experiments** page without losing any progress.
{% endhint %}

To download or integrate your trained model into a production pipeline, navigate from the **Experiments** page directly to your project's file storage. Here, you can access all saved model files, weights, and configurations.

## Additional Settings

Additionally, the AI assistance configuration panel includes the following settings:

- **Don't auto-predict if image contains objects** (figures/annotations) — Live Training will not automatically suggest annotations if the current image already contains labeled objects. This is useful when your dataset is partially annotated, or when the image queue loops, and you return to already labeled images.
- **Confidence Threshold** — Defines the prediction confidence level required for the model to start suggesting annotations. Higher values mean the model needs more manually labeled images before it begins generating automatic predictions.

## Use Cases

Live Training excels in specialized domains where standard foundation models fall short. Explore the real-world examples below to discover how adapting AI on the fly can accelerate your specific annotation workflows and solve complex industry challenges.

<table data-view="cards"><thead><tr><th></th><th></th><th data-hidden data-card-target data-type="content-ref"></th></tr></thead><tbody><tr><td><strong>Automated Tomato Phenotyping and Segmentation 🍅</strong></td><td>Live Training on a real-world agricultural segmentation task: extracting phenotypic measurements from tomato fruit cross-sections.</td><td><a href="./use-cases/tomatoes.md">unix-based.md</a></td></tr></tbody></table>
