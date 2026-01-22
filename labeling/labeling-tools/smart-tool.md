# Smart Tool

## What is Smart Tool?

The Smart Tool is an AI-assisted interactive segmentation tool designed to speed up object segmentation tasks. It integrates various neural network models like RITM and Segment Anything, allowing precise mask creation with minimal user input. Users can customize models and annotations for specific task.&#x20;

## Video Tutorial

This tutorial provides clear, step-by-step guidance from a Supervisely expert, demonstrating how to effectively use the Smart Tool for your annotation tasks. To master the efficient use of the **Smart Tool**, watch our 5-minute video tutorial:

{% embed url="https://www.youtube.com/watch?ab_channel=Supervisely&v=6GYFJo0g6Qs" %}

### AI-Powered Segmentation Models

At the heart of the Smart Tool are AI models that predict the boundaries of objects based on minimal user input. It includes models such as:

**RITM (Regional Interactive Segmentation by Mask):** This model allows users to segment objects with a few simple clicks or strokes, ideal for situations where quick segmentation is required.

**Segment Anything (SAM):** SAM is a flexible model that can segment a wide range of objects. With only a rough guide (such as a few markers or a sketch), the model automatically refines and creates highly accurate object boundaries.

These models use machine learning algorithms trained on large datasets, enabling them to predict object contours even in complex or noisy environments.

### Model Switching and Customization

#### **Model Switching**

Different models work better for different types of tasks or images. The Smart Tool allows users to switch between models easily, which is useful when dealing with diverse image sets.&#x20;

**Example:** one model may perform better on medical scans, while another may be more suited for satellite imagery. Users can switch between these models without needing to start the annotation process from scratch.

#### **Model Customization**

Supervisely offers the ability to integrate custom-trained AI models into the Smart Tool. This is particularly useful for specialized tasks where default models may not achieve the desired accuracy. Simply upload and configure your custom model to enhance the tool's capabilities for your unique segmentation requirements.

***

### Key Features

#### **One-Click Object Segmentation**

One of the key features of the Smart Tool is its ability to perform one-click segmentation. With minimal manual interaction, the AI can analyze the entire image and identify object boundaries almost instantly. This greatly reduces the time required to perform segmentation, especially for objects with repetitive or simple shapes.

#### **Manual Editing and Fine-tuning**

While the AI does most of the heavy lifting, manual fine-tuning tools such as the Brush and Pen are available for refining the masks. These tools allow users to:

* **Brush Tool:** Allows you to paint over areas that should be included or excluded from the selection.
* **Pen Tool:** Provides precision for manually outlining intricate parts that the AI might have missed.

***

## How to use the Smart Tool

### Create class with Mask shape

You can create a new class directly from the Annotation Toolbox to use with the Smart Tool. Here's how to do it:

1. Click on the **Smart Tool icon** in the toolbar of the labeling interface.
2. Alternatively, select an existing object class or add a new class by clicking **Add new class definition**.
3. In the modal window, enter the class name, choose **Mask** or **Any shape**, and configure additional settings (e.g., color, hotkeys).
4. Click the **Create** button to add the new class to the definitions list.
5. Select the newly created class and begin segmenting the object with the Smart Tool.

### Manual Annotation Guide

Using the Smart Tool follows a process, ensuring a balance between simplicity and control. Here is a step-by-step guide:

**Choose a Segmentation Model**\
Select an appropriate model (e.g., RITM or SAM) based on your specific task. The model chosen will guide how the AI interprets and processes the image.

**Define Object Boundaries**

{% hint style="info" %}
**Pro Tip**: The initial bounding box doesn't need to be tightly aligned with the object. Leave about 10% padding from the object's boundary to give the model more context.
{% endhint %}

1. Click on the regions or draw rough boundaries around objects in the image.
2. The AI will predict the object segmentation based on this input.
3. To create a bounding box, click to place the top point and then click again for the bottom point in the opposite corner.
4. The neural network will identify the main object within this rectangle.

**Refining AI Predictions**\
Adjust the predictions by adding positive 🟢 or negative 🔴 points around the object:

1. Place a positive point on parts of the object you want included in the mask.
2. Place a negative point on background areas you want excluded.
3. Finalize by pressing the **SPACE** hotkey.

**Fine-Tuning the Segmentation**\
Use the **Brush** or **Pen Tool** for any necessary manual adjustments

* **Add parts**: Select the missing section of the object and draw it in.
* **Delete parts**: Hold the **SHIFT** key and draw over areas you want to remove.

### Pro Tips

* **Initial bounding box placement:** You don't need to draw the bounding box precisely around the object's boundaries. Leave about a **10% padding** around the object. This allows the AI to capture more context, resulting in more accurate segmentation, especially near the object's edges.
* **Model switching for best results:** If you're working with a variety of images or tasks, experiment with different models to identify which one yields the most accurate segmentation for your data.
* **Leverage custom models:** For highly specialized tasks, integrating a custom-trained model can significantly enhance accuracy and efficiency.



***

## Hotkeys

Control the Smart Tool more efficiently with the following hotkeys:

| Detect object inside BBox          | `Left Mouse Click`             |
| ---------------------------------- | ------------------------------ |
| Add positive point                 | `Left Mouse Click`             |
| Add negative point                 | `Shift + Left Mouse Click`     |
| Remove feedback point              | `Alt + Left Mouse Click`       |
| Drag rectangle                     | `Alt + Hold Left Mouse Button` |
| Move rectangle in small increments | `Alt + Arrow Keys`             |

Use **`id`** button to change model. You can deploy more interactive segmentation models in Ecosystem.

| Scene Navigation                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Zoom with Mouse wheel. Hold <img src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBzdGFuZGFsb25lPSJubyI/Pgo8IURPQ1RZUEUgc3ZnIFBVQkxJQyAiLS8vVzNDLy9EVEQgU1ZHIDIwMDEwOTA0Ly9FTiIKICJodHRwOi8vd3d3LnczLm9yZy9UUi8yMDAxL1JFQy1TVkctMjAwMTA5MDQvRFREL3N2ZzEwLmR0ZCI+CjxzdmcgdmVyc2lvbj0iMS4wIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciCiB3aWR0aD0iMTAwLjAwMDAwMHB0IiBoZWlnaHQ9IjEwMC4wMDAwMDBwdCIgdmlld0JveD0iMCAwIDEwMC4wMDAwMDAgMTAwLjAwMDAwMCIKIHByZXNlcnZlQXNwZWN0UmF0aW89InhNaWRZTWlkIG1lZXQiPgoKPGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoMC4wMDAwMDAsMTAwLjAwMDAwMCkgc2NhbGUoMC4xMDAwMDAsLTAuMTAwMDAwKSIgc3Ryb2tlPSJub25lIj4KPHBhdGggZD0iTTQzMiA5MTAgYy0xMDUgLTIyIC0yMDQgLTEwNyAtMjQyIC0yMDYgLTI5IC04MCAtMjkgLTMyOCAwIC00MDggMjkKLTc2IDg4IC0xMzkgMTY2IC0xNzcgNTcgLTI4IDc2IC0zMyAxNDQgLTMzIDY4IDAgODcgNSAxNDQgMzMgNzggMzggMTM3IDEwMQoxNjYgMTc3IDI5IDgwIDI5IDMyOCAwIDQwOCAtNTUgMTQ1IC0yMjQgMjM4IC0zNzggMjA2eiBtMjggLTIwNSBsMCAtMTI1IC0xMDYKMCAtMTA3IDAgNyA0MSBjOSA1OSA0MCAxMTMgODUgMTUwIDMzIDI4IDg2IDU1IDExNCA1OCA0IDEgNyAtNTUgNyAtMTI0eiBtMjg4Ci0yODIgYy02IC05NCAtMjkgLTE0NSAtOTAgLTE5NyAtODkgLTc3IC0yMjcgLTc3IC0zMTYgMCAtNjEgNTIgLTg0IDEwMyAtOTAKMTk3IGwtNSA3NyAyNTMgMCAyNTMgMCAtNSAtNzd6Ii8+CjwvZz4KPC9zdmc+Cg==" alt="" data-size="line"> to move scene. |
