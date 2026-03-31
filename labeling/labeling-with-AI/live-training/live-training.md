---
description: >-
  This guide shows how Live Training in Supervisely lets models learn from human annotation in real time, improving predictions and speeding up labeling.
---

# Live Training

## Introduction

Live Training is a novel framework built by Supervisely where AI models train in parallel with human annotation. As annotators label images, the model quickly adapts to the domain-specific data and annotation patterns. After just 5-10 labeled images, it begins generating useful predictions (pre-labels) that accelerate labeling. The quality of these predictions continuously improves with every new image labeled.

By project completion, you get both a fully annotated dataset and a trained model ready for deployment, with accuracy equivalent to a model trained through conventional offline training.
Live Training transforms annotation projects from a multi-week, multi-team coordination challenge into a streamlined single-phase workflow where AI assistance grows naturally from the first annotation onward.

**Live Training solves two critical limitations in AI-assisted annotation:**

Zero-shot foundation models (SAM, GroundingDINO) are helpful in annotating common objects (human, animals, vehicles), but they fail on specialized domains with almost zero assistance.
Conventional workflows such as Human-in-the-loop and Active Learning involve manual coordination that always create coordination overhead and idle time, resulting in high costs and timelines of annotation projects.

## How to use

### Step 1: Launch Live Training

Navigate to the Labeling Tool interface. On the top panel, click the blue ✨ **Auto Labeling** button to open the AI assistance configuration panel, then select the **Live Training** option.
  
<figure><img src="../../../.gitbook/assets/live-training/live-training.jpg" alt="Select Live Training from the Auto Labeling menu"><figcaption></figcaption></figure>

If a Live Training session is already running, you will see it in the dropdown list and can use the existing session. To start a new one, click **Launch App**. 

You will be prompted to select the type of model that fits your annotation task. There are two main options:
- **Live Training Segmentation**
- **Live Training Detection**

This opens the setup interface where you can run the training app session and make the model available for real data processing.
 
<figure><img src="../../../.gitbook/assets/live-training/live-training1.jpg" alt="Launch a new Live Training session and select model type"><figcaption></figcaption></figure>

**Start Live Training**

While the Live Training application is launching, a floating panel will display the progress of the app startup. 

<figure><img src="../../../.gitbook/assets/live-training/live-training-2.jpg" alt="Live Training app startup progress"><figcaption></figcaption></figure>

Once the application is ready, the floating panel will show the **Start Live Training** button. Click this button to confirm the beginning of real-time training and data analysis from that moment onward.

<figure><img src="../../../.gitbook/assets/live-training/live-training-3.jpg" alt="Click Start Live Training to begin"><figcaption></figcaption></figure>

**Configuration Settings**

Additionally, the AI assistance configuration panel includes the following settings:

- **Don't auto-predict if image contains objects** (figures/annotations) — Live Training will not automatically suggest annotations if the current image already contains labeled objects. This is useful when your dataset is partially annotated, or when the image queue loops, and you return to already labeled images.
- **Confidence Threshold** — Defines the prediction confidence level required for the model to start suggesting annotations. Higher values mean the model needs more manually labeled images before it begins generating automatic predictions.


### Step 2: Annotate Initial Samples

Before the model can generate reliable predictions, it requires a small set of labeled images to learn your specific domain. 

1. Fully annotate your first image manually.
2. Click **Finish & Next** to add the image to the training queue and advance to the next one.
3. Repeat this process for at least 2-5 images.

<figure><img src="../../../.gitbook/assets/live-training/live-training4.jpg" alt="Annotate initial samples manually to start training"><figcaption></figcaption></figure>

After annotating just two images, the **Predict** button becomes available. At this early stage, prediction accuracy is low, so Live Training will not auto-suggest annotations yet. You have two options:
- Continue annotating manually to build a stronger baseline dataset.
- Click **Predict** to force the model to generate initial shapes.

<figure><img src="../../../.gitbook/assets/live-training/live-training5.jpg" alt="Predict button appears in the labeling interface"><figcaption></figcaption></figure>

If you request predictions and are unsatisfied with the results, click **Discard** to reject them. Alternatively, you can manually correct the shapes and click **Finish & Next** to feed the corrected data back into the training loop. This continuous feedback is what drives the model's rapid improvement.

<figure><img src="../../../.gitbook/assets/live-training/live-training6.jpg" alt="Model prediction quality improves over time"><figcaption></figcaption></figure>

### Step 3: Labeling with Live Training Assistance

As you feed more corrected annotations into the system, the model's accuracy rapidly improves. Once the model crosses your configured confidence threshold, it transitions from manual prediction to active assistance.

Live Training will now automatically suggest shapes for each new image you open. Simply review the proposed annotations, adjust or delete any incorrect shapes, and accept the correct ones before moving to the next image. 

{% embed url="https://youtu.be/H1aJknl1NtM" %}

### Step 4: Save and Load Your Trained Models

Your active Live Training sessions automatically sync to the **Experiments** page. This centralized dashboard allows you to manage training runs, monitor progress, and reload models to resume training later.

<figure><img src="../../../.gitbook/assets/live-training/live-training-7.jpg" alt="Experiments page showing saved models and checkpoints"><figcaption></figcaption></figure>

The system automatically saves model checkpoints at regular intervals. A checkpoint preserves the exact state of your model weights at a specific point in time. 

{% hint style="success" %}
💡 **Tip**: If your annotation session is paused or interrupted, you can safely resume it later by loading the latest checkpoint from the **Experiments** page without losing any progress.
{% endhint %}

To download or integrate your trained model into a production pipeline, navigate from the **Experiments** page directly to your project's file storage. Here, you can access all saved model files, weights, and configurations.

## Use Cases

Live Training excels in specialized domains where standard foundation models fall short. Explore the real-world examples below to discover how adapting AI on the fly can accelerate your specific annotation workflows and solve complex industry challenges.

<table data-view="cards"><thead><tr><th></th><th></th><th data-hidden data-card-target data-type="content-ref"></th></tr></thead><tbody><tr><td><strong>Automated Tomato Phenotyping and Segmentation</strong></td><td>Live Training on a real-world agricultural segmentation task: extracting phenotypic measurements from tomato fruit cross-sections.</td><td><a href="./use-cases/tomatoes.md">unix-based.md</a></td></tr></tbody></table>