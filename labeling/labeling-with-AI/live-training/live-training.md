---
description: >-
  🔴🔴🔴 Live Training lets AI models learn from your annotations in real time, delivering increasingly accurate predictions from the very first labeled images — so you finish with both a complete dataset and a trained model.
layout:
  pagination:
    visible: false
---

# Live Training

## Introduction

Live Training is an innovative framework built by Supervisely where AI models train **in parallel with human annotation**. As annotators label images, the model quickly adapts to domain-specific data and annotation patterns. After just 5-10 labeled images, it begins generating useful predictions (*pre-labels*) that accelerate labeling. The quality of these predictions continuously improves with every new image labeled.

By project completion, you get both a fully annotated dataset and a trained model ready for deployment — with accuracy equivalent to a model trained through conventional offline training.

**Live Training solves two key limitations of AI-assisted annotation:**

1. Zero-shot foundation models (SAM, GroundingDINO) work well for common objects (people, animals, vehicles), but fail on specialized domains where they provide almost no assistance.
2. Conventional workflows such as Human-in-the-Loop and Active Learning require manual coordination that creates overhead and idle time, resulting in high costs and extended project timelines.

The Live Training approach transforms annotation projects from a multi-week, multi-team coordination challenge into a streamlined single-phase workflow where AI assistance grows naturally from the first annotation onward.

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

If a Live Training session is already running, it will appear in the dropdown list and you can use the existing session. To start a new one, click **Launch App**.

Choose the model type that fits your annotation task. Currently, there are two options:

- **Live Training Segmentation**
- **Live Training Detection**

Configure the app settings in the modal window and click **Run** to launch the Live Training application.

<!--
<figure><img src="../../../.gitbook/assets/live-training/live-training1.jpg" alt="Launch a new Live Training session and select model type"><figcaption></figcaption></figure> -->

Each Live Training session is attached to a specific project and its classes. To use Live Training for a different project, launch a new session from that project's labeling interface.

{% hint style="success" %}
💡 **Tip**: Alternatively, you can start Live Training from the **Ecosystem**, just like any other Supervisely application. In this case, select the target project from the app's launch menu.
{% endhint %}

**Starting Live Training**

While the Live Training application is launching, a floating panel will display the startup progress.

<figure><img src="../../../.gitbook/assets/live-training/live-training-2.jpg" alt="Live Training app startup progress"><figcaption></figcaption></figure>

Once the application is ready, the floating panel will show the **Start Live Training** button. Make sure you've created all the necessary classes in your project before starting — Live Training will only use classes that already exist when training begins. Click this button to confirm and begin training.

<figure><img src="../../../.gitbook/assets/live-training/live-training-3.jpg" alt="Click Start Live Training to begin"><figcaption></figcaption></figure>

### 2. Annotate Initial Samples

After starting Live Training, the floating panel will show the status **Annotate 2 more images**. Before the model can start generating predictions, it needs a few labeled images to learn your specific domain.

1. Annotate your first image manually.
2. Click the **Finish & Next** button on the floating panel. This saves the annotation, adds it to the model's training data, and takes you to the next image.
3. Repeat this process for at least 2-3 images.

<figure><img src="../../../.gitbook/assets/live-training/live-training4.jpg" alt="Annotate initial samples manually to start training"><figcaption></figcaption></figure>

### 3. Learning

After annotating 2-3 initial images, the status changes to **Learning**. At this stage, the model begins learning from your annotations in the background. Continue annotating and submitting images by clicking **Finish & Next**. After a short while, the model will start generating predictions.

### 4. AI Starts Predicting

Once the model has adapted to the initial annotations, it starts generating predictions every time you click **Finish & Next**. Review the model predictions, correct any mistakes, and submit the annotations to further improve the model. At this early stage, results may be rough — you can click **Discard** to remove predictions and annotate manually if the suggestions aren't helpful. Use the **Predict** button to request new predictions after discarding.

Model quality is now shown in the floating panel and refreshes after each newly labeled image.

<figure><img src="../../../.gitbook/assets/live-training/live-training5.jpg" alt="Predict button appears in the labeling interface"><figcaption></figcaption></figure>

### 5. Continuous Improvement

As you continue annotating with model assistance, accuracy rapidly improves. The more you annotate, the better the model becomes at understanding your specific data and annotation style.

{% hint style="success" %}
Over time, the model will generate nearly perfect predictions, allowing you to simply review and accept them — significantly speeding up your annotation workflow.
{% endhint %}

<figure><img src="../../../.gitbook/assets/live-training/live-training6.jpg" alt="Model prediction quality improves over time"><figcaption></figcaption></figure>

{% embed url="https://youtu.be/H1aJknl1NtM" %}

## Save & Load Live Training Sessions

Your Live Training sessions automatically sync to the **Experiments** page. This centralized dashboard lets you manage training runs, monitor progress, and reload models to resume training later.

<figure><img src="../../../.gitbook/assets/live-training/live-training-7.jpg" alt="Experiments page showing saved models and checkpoints"><figcaption></figcaption></figure>

The system automatically saves model **checkpoints** at regular intervals. A checkpoint preserves the exact state of your model weights at a specific point in time.

{% hint style="success" %}
💡 **Tip**: If your annotation session is paused or interrupted, you can safely resume later by loading the latest checkpoint from the **Experiments** page — no progress will be lost.
{% endhint %}

To download your trained model or integrate it into a production pipeline, navigate to your project's file storage directly from the **Experiments** page. There you'll find all saved model files, weights, and configurations.

## Additional Settings

The AI assistance configuration panel offers the following settings:

- **Don't auto-predict if image contains objects** (figures/annotations) — By default, Live Training suggests predictions for every new image. Enable this option to skip automatic prediction when the current image already contains any labeled objects. This is useful when your dataset is partially annotated.
- **Confidence Threshold** — Filters the detections returned by the model. Only predictions with a confidence score above this threshold will be shown as suggestions. Lower values show more predictions (including uncertain ones), while higher values show only the model's most confident detections. Adjust this to balance recall and precision based on your annotation needs.

## Use Cases

Live Training excels in specialized domains where standard foundation models fall short. Explore the real-world examples below to discover how adapting AI on the fly can accelerate your specific annotation workflows and solve complex industry challenges.

<table data-view="cards"><thead><tr><th></th><th></th><th data-hidden data-card-target data-type="content-ref"></th></tr></thead><tbody><tr><td><strong>Automated Tomato Phenotyping and Segmentation 🍅</strong></td><td>Live Training on a real-world agricultural segmentation task: extracting phenotypic measurements from tomato fruit cross-sections.</td><td><a href="./use-cases/tomatoes.md">unix-based.md</a></td></tr></tbody></table>
