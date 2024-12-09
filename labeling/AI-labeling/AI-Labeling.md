---
description: >-
  Disrupt accustomed approaches and boost both labeling performance and quality
  with the help of interactive smart tools.
---

# Labeling with AI-Assistance

## What is Smart Tool?

**Smart Tool** is a powerful interactive segmentation tool. This powerful tool uses the latest artificial intelligence (AI) technologies to create highly accurate object masks, significantly speeding up the annotation process. With seamless integration of several state-of-the-art neural network models, including Segment Anything 2 (SAM 2), ClickSEG and others, Smart Tool easily adapts to a wide range of use cases and domains.

## Availability of SmartTool

Access to Smart Tool features depends on your Supervisely plan. In the Community version you get access to an already running Smart Tool that works with the ClickSEG or Segment Anything 2 (SAM 2)  model.

## Step-by-Step Usage Guide

### Step 1. Open the Labeling Interface

1. Navigate to your project and open an **Image** or **Video** **Labeling Tool**.
2. Locate and select the **Smart Tool** from the toolbar on the left side of the interface.

### Step 2. Select the Neural Network Model

1. Click on the **Model ID** button in the left toolbar.
2. Choose a neural network model, such as **Segment Anything 2 (SAM 2)**, or **ClickSEG**, depending on your project requirements. The selected model will be activated for segmentation tasks.

### Step 3. Create a Bounding Box

1. Identify the object you want to segment in the image.
2. Click and drag to draw a bounding box around the object.

{% hint style="warning" %}
Ensure that the box includes the object with a 10% padding for better segmentation accuracy.
{% endhint %}

### Step 4. Adjust the Mask with Points

1. Place **positive points** (🟢) on areas of the object you want to include in the mask.
2. Place **negative points** (🔴) on areas you want to exclude (e.g., background or overlapping objects).
3. Adjust the mask by adding or moving points until the segmentation aligns with the object’s boundaries.
4. Press the **SPACE** key to finalize the segmentation mask. The mask will be saved as a labeled object in the project.

### Step 5. Refine the Segmentation (Optional)

1. Use the **Brush**, **Eraser**, or **Pen** tools for manual adjustments:
   * **Brush**: Add to the mask by painting over missing areas.
   * **Eraser**: Remove unwanted parts of the mask.
   * **Pen**: Draw precise boundaries around the object.
2. Press and hold the **SHIFT** key while using the tools to make additional edits.

#### Switch Models for Improved Results (Optional)

1. If the current model doesn’t produce satisfactory results, return to the **Model ID** button.
2. Select a different model and repeat the segmentation steps.
3. Experiment with multiple models to achieve the best performance for your specific dataset.

## Video Tutorial

Master the Smart Tool with our detailed 5-minute video tutorial.

{% embed url="https://www.youtube.com/watch?v=6GYFJo0g6Qs" %}

## SmartTool Deployment

To successfully deploy and run SmartTool models on your own server, you must have a GPU-enabled compute agent. This ensures optimal performance and efficiency of the tool.

We also provide detailed guide on [how to deploy your own computer agent](../../getting-started/connect-your-computer/) to make setting up and using SmartTool easier.

{% hint style="info" %}
**Note:** Using a GPU Compute Agent is an important requirement for SmartTool models to function correctly.
{% endhint %}

## Working with Models

* **Pre-trained Models**: Supervisely provides access to popular models like ClickSEG, RITM, and Segment Anything, ensuring a seamless user experience.
* **Custom Models**: Tailor models to your unique data directly on the platform, with no coding required. Example use cases include agricultural image segmentation and road crack detection.
* **Enterprise Customization**: Private instance administrators can configure preferred models via an intuitive administration panel, enabling enterprise-level flexibility.

### Learn More

In Supervisely, you have the capability to train the Smart Tool specifically for your data directly within the platform, and the best part is, that no coding is required! We're actively experimenting with this feature and are impressed by the results. Feel free to explore other **blog posts** dedicated to this topic.&#x20;

* [How to Train Smart Tool for Precise Cracks Segmentation in Industrial Inspection](https://supervisely.com/blog/industrial-inspection-cracks-segmentation/)
* [Automate manual labeling with custom interactive segmentation model for agricultural images](https://supervisely.com/blog/custom-smarttool-wheat/)
* [Unleash The Power of Domain Adaptation - How to Train Perfect Segmentation Model on Synthetic Data with HRDA](https://supervisely.com/blog/unleash-the-power-of-domain-adaptation-with-HRDA-synthetic-cracks-segmentation/)
* [Lessons Learned From Training a Segmentation Model On Synthetic Data](https://supervisely.com/blog/lessons-learned-from-training-a-segmentation-model-on-synthetic-data/)

## Working with Custom Data

Apart from SmartTool, we have access to a variety of applications tailored for different data handling purposes:

* **SmartTool:** Primarily used for image annotation and labeling.
* [**Apply NN to Images Project:**](https://ecosystem.supervisely.com/apps/nn-image-labeling/project-dataset) Enables the application of neural networks to image projects directly.
* [**NN Image Labeling:**](https://ecosystem.supervisely.com/apps/nn-image-labeling/annotation-tool) Any NN can be integrated into Labeling interface if it has properly implemented serving app (for example: Serve YOLOv5).

**Moreover, we provide various training applications:**

* [Train RITM](https://ecosystem.supervisely.com/apps/ritm-training/supervisely/train)
* [Train YOLOv8](https://ecosystem.supervisely.com/apps/yolov8/train)
* [Train UNet](https://ecosystem.supervisely.com/apps/unet/supervisely/train)
* [Train MMDetection](https://ecosystem.supervisely.com/apps/mmdetection/train)
* [and other](https://ecosystem.supervisely.com/search?q=train)

These tools use training of specific models like RITM, YOLOv8, UNet, and MMDetection, optimizing the image annotation process across diverse data types.

## Different modalities

Another substantial thing about neural networks is that it's easy to adapt it to different modalities. That means, that the Smart Tools not only work on images, but on sequential frames, such as videos or multi-slice medial imaging and even 3D point clouds with more than two dimensions!

<table data-view="cards"><thead><tr><th></th><th data-hidden data-card-cover data-type="files"></th><th data-hidden data-card-target data-type="content-ref"></th></tr></thead><tbody><tr><td><strong>Images</strong></td><td><a href="../ai-images.gif">ai-images.gif</a></td><td><a href="images/">images</a></td></tr><tr><td><strong>Video</strong></td><td><a href="../ai-video.gif">ai-video.gif</a></td><td><a href="videos/">videos</a></td></tr><tr><td><strong>3D Point Cloud</strong></td><td><a href="../ai-pontcloud.gif">ai-pontcloud.gif</a></td><td><a href="3D-Point-Clouds/3D-Point-Clouds.md">3D-Point-Clouds.md</a></td></tr><tr><td><strong>DICOM</strong></td><td><a href="../ai-dicom.gif">ai-dicom.gif</a></td><td><a href="DICOM/DICOM.md">DICOM.md</a></td></tr></tbody></table>

{% hint style="info" %}
Please check the those awesome tutorials and guides:

* [Automate manual labeling with custom interactive segmentation model for agricultural images](https://supervisely.com/blog/custom-smarttool-wheat/)
* [Segment Anything in High Quality (HQ-SAM): a new Foundation Model for Image Segmentation (Tutorial)](https://supervisely.com/blog/segment-anything-in-high-quality-HQ-SAM/)
* [How to Train Smart Tool for Precise Cracks Segmentation in Industrial Inspection](https://supervisely.com/blog/industrial-inspection-cracks-segmentation/)
* [Complete Guide to Object Tracking: Best AI Models, Tools and Methods in 2023](https://supervisely.com/blog/complete-guide-to-object-tracking-best-ai-models-tools-and-methods-in-2023/)
{% endhint %}
