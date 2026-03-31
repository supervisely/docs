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

First, enter the Labeling Tool interface. On the top panel, click the blue ✨ **Auto Labeling** button. This opens the AI assistance configuration panel.<br>
Then choose the **Live Training** option.<br>
  
<figure><img src="../../.gitbook/assets/live-training/live-training.jpg" alt=""><figcaption></figcaption></figure>


If a Live Training session is already running, you will see it in the dropdown list. You can use the existing session, or start a new one if needed.<br>

For new session click the **Launch App** - you will be prompted to select the type of model that fits your annotation task. There are two main options: **Live Training Segmentation**, **Live Training Detection**.
This opens the setup interface where you can run the training app session and make the model available for real data processing.<br>
 
<figure><img src="../../.gitbook/assets/live-training/live-training1.jpg" alt=""><figcaption></figcaption></figure>

**Start Live Training**<br>
While the Live Training application is launching, you will see a floating panel displaying the progress of the app startup. 

<figure><img src="../../.gitbook/assets/live-training/live-training-2.jpg" alt=""><figcaption></figcaption></figure>

Once the application is ready, the floating panel will show the **Start Live Training** button. Click this button to confirm the beginning of real-time training and data analysis from that moment onward.

<figure><img src="../../.gitbook/assets/live-training/live-training-3.jpg" alt=""><figcaption></figcaption></figure>

Additionally, the AI assistance configuration panel includes the following settings:

  - **Don't auto-predict if image contains objects** (figures/annotations) — Live Training will not automatically suggest annotations if the current image already contains labeled objects. This is useful when your dataset is partially annotated, or when the image queue loops, and you return to already labeled images.

  - **Confidence Threshold** — defines the prediction confidence level required for the model to start suggesting annotations. Higher values mean the model needs more manually labeled images before it begins generating automatic predictions.


### Step 2: Annotate Initial Samples

Before the model can start generating predictions, it needs a few labeled images for initial training.
Annotate each image completely and click `Finish & Next` to add it to the training data and to proceed to the next image.
The more you annotate, the better the model gets. Once quality is sufficient (depends on threshold settings), it will start suggesting predictions automatically.

<figure><img src="../../.gitbook/assets/live-training/live-training4.jpg" alt=""><figcaption></figcaption></figure>

Even after just 2 annotated images, the **Predict** button will appear. However, at the very beginning, the prediction accuracy will be close to zero, and **Live Training** will not yet suggest annotations automatically.

At this stage, you can continue annotating images manually until the **Live Training** quality improves to an acceptable level. Alternatively, you can already request predictions from Live Training by clicking the **Predict** button.

<figure><img src="../../.gitbook/assets/live-training/live-training5.jpg" alt=""><figcaption></figcaption></figure>

If you are not satisfied with the result, you can reject the proposed annotations by clicking **Discard**, or edit/add shapes and continue training and annotation by clicking **Finish and Next**.

The training quality will improve over time.

<figure><img src="../../.gitbook/assets/live-training/live-training6.jpg" alt=""><figcaption></figcaption></figure>

### Step 3: Labeling with Live Training Assistance

As you can see, the model’s prediction accuracy gradually improves during training. At a certain point, the model begins to automatically suggest shapes (annotations). You can add, modify, or delete them, as well as either accept or reject the suggestions and move on to the next image, where Live Training will again propose annotations.

{% embed url="https://youtu.be/H1aJknl1NtM" %}

### Step 4: Save and Load Your Trained Models

During training, your model automatically appears on the Experiments page. From there, you can access and manage training runs, as well as load a model to continue training at any time.

<figure><img src="../../.gitbook/assets/live-training/live-training-7.jpg" alt=""><figcaption></figcaption></figure>

The Experiments page automatically saves model checkpoints at regular intervals. If training is paused or interrupted, you can resume it later from the latest checkpoint. A checkpoint represents the state of the model weights at a specific point in time, allowing training to continue without losing progress.

Additionally, from the Experiments page, you can navigate to the project’s file storage to locate and access your saved model files and checkpoints.