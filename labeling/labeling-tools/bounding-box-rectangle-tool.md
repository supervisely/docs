---
description: >-
  In this guide, you'll learn how to use bounding boxes in the Supervisely
  annotation toolboxes and explore additional features that can help streamline
  your annotation experience.
---

# Bounding Box (Rectangle) Tool

## What is a Bounding Box?

The[ Bounding Box](https://supervisely.com/blog/bounding-box-annotation-for-object-detection/#what-is-object-detection) is a fundamental tool in Computer Vision used for image annotation, object detection and tracking tasks.&#x20;

Rectangles that precisely enclose an object are commonly referred to as bounding boxes. These boxes are defined by coordinates that indicate the position and size of the object. Coordinates are usually specified as the top-left and bottom-right corners (or alternatively, by the center point, width, and height).

The main goal of a bounding box is to provide a clear boundary that the machine learning model can use to identify and locate objects in images or videos.

<figure><img src="../../.gitbook/assets/easy-clicks.gif" alt=""><figcaption></figcaption></figure>

## Video Tutorial

Watch our 5-minute video tutorial that provides clear and simple instructions on how to create and use Bounding Boxes for image annotation in Supervisely Image Labeling Toolbox.

{% embed url="https://youtu.be/X2qbm0FxN_4?si=AEONjOp4fhJmTzY6" %}

## How to use Bounding Boxes

We'll explore how to manually draw bounding boxes, including feutures and tips for efficiency and accuracy

### Create Bounding Box

You can create a new class directly from the [Annotation Toolbox](https://app.supervisely.com/ecosystem/annotation\_tools/image-labeling-tool-v2?). To do this:

1. Click on the **Rectangle Icon** in the toolbar of the labeling interface or **Add new class definition**.
2. A modal window will appear prompting you to enter the details of the new class.
3. **Enter the Class Name, select Bounding Box shape** and configure any additional settings, such as color or hotkey.
4. Click the `Create` button to add the new bounding box class to the Definitions list.

<div>

<figure><img src="../../.gitbook/assets/create-from-labeling-toolbox.png" alt=""><figcaption></figcaption></figure>

 

<figure><img src="../../.gitbook/assets/create.png" alt=""><figcaption></figcaption></figure>

</div>

### Manual Annotation

To create a bounding box, select the object of interest in the image or video and place a rectangle around it. The fewer clicks required, the more efficient the annotation process will be. You don't have to finish labeling the previous object by pressing `SPACE` to move on to the next one; simply set new points.&#x20;

{% hint style="info" %}
Always aim to create bounding boxes that tightly fit around the object to minimize background noise and enhance model performance.
{% endhint %}

### Tips

* Use **Auto-select** to switch between classes by hovering over the desired object. Also easily edit existing bounding boxes, including those predicted by Neural Networks.
* Use the **Object Color Randomizer** to instantly change the color of any object with a single click, as often as you like. This is particularly useful if you have many objects of the same class, or if they are close together, so you can easily differentiate between bounding boxes.

<figure><img src="../../.gitbook/assets/bbox-labeling.png" alt=""><figcaption></figcaption></figure>

## Hotkeys

Control the BBox tool more efficiently with `HOTKEYS`.

<table data-full-width="false"><thead><tr><th width="454">Bounding Box (Rectangle) Tool</th><th>5</th></tr></thead><tbody><tr><td>Create &#x26; add point </td><td><img src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBzdGFuZGFsb25lPSJubyI/Pgo8IURPQ1RZUEUgc3ZnIFBVQkxJQyAiLS8vVzNDLy9EVEQgU1ZHIDIwMDEwOTA0Ly9FTiIKICJodHRwOi8vd3d3LnczLm9yZy9UUi8yMDAxL1JFQy1TVkctMjAwMTA5MDQvRFREL3N2ZzEwLmR0ZCI+CjxzdmcgdmVyc2lvbj0iMS4wIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciCiB3aWR0aD0iMTAwLjAwMDAwMHB0IiBoZWlnaHQ9IjEwMC4wMDAwMDBwdCIgdmlld0JveD0iMCAwIDEwMC4wMDAwMDAgMTAwLjAwMDAwMCIKIHByZXNlcnZlQXNwZWN0UmF0aW89InhNaWRZTWlkIG1lZXQiPgoKPGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoMC4wMDAwMDAsMTAwLjAwMDAwMCkgc2NhbGUoMC4xMDAwMDAsLTAuMTAwMDAwKSIgc3Ryb2tlPSJub25lIj4KPHBhdGggZD0iTTQzMiA5MTAgYy0xMDUgLTIyIC0yMDQgLTEwNyAtMjQyIC0yMDYgLTI5IC04MCAtMjkgLTMyOCAwIC00MDggMjkKLTc2IDg4IC0xMzkgMTY2IC0xNzcgNTcgLTI4IDc2IC0zMyAxNDQgLTMzIDY4IDAgODcgNSAxNDQgMzMgNzggMzggMTM3IDEwMQoxNjYgMTc3IDI5IDgwIDI5IDMyOCAwIDQwOCAtNTUgMTQ1IC0yMjQgMjM4IC0zNzggMjA2eiBtMTc0IC0xMDEgYzYzIC0yMyAxMjgKLTExMCAxNDAgLTE4OCBsNyAtNDEgLTEwNyAwIC0xMDYgMCAwIDEyNiAwIDEyNSAyMyAtNyBjMTIgLTQgMzIgLTEwIDQzIC0xNXoKbTE0MiAtMzg2IGMtNiAtOTQgLTI5IC0xNDUgLTkwIC0xOTcgLTg5IC03NyAtMjI3IC03NyAtMzE2IDAgLTYxIDUyIC04NCAxMDMKLTkwIDE5NyBsLTUgNzcgMjUzIDAgMjUzIDAgLTUgLTc3eiIvPgo8L2c+Cjwvc3ZnPgo=" alt="" data-size="line">, <img src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBzdGFuZGFsb25lPSJubyI/Pgo8IURPQ1RZUEUgc3ZnIFBVQkxJQyAiLS8vVzNDLy9EVEQgU1ZHIDIwMDEwOTA0Ly9FTiIKICJodHRwOi8vd3d3LnczLm9yZy9UUi8yMDAxL1JFQy1TVkctMjAwMTA5MDQvRFREL3N2ZzEwLmR0ZCI+CjxzdmcgdmVyc2lvbj0iMS4wIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciCiB3aWR0aD0iMTAwLjAwMDAwMHB0IiBoZWlnaHQ9IjEwMC4wMDAwMDBwdCIgdmlld0JveD0iMCAwIDEwMC4wMDAwMDAgMTAwLjAwMDAwMCIKIHByZXNlcnZlQXNwZWN0UmF0aW89InhNaWRZTWlkIG1lZXQiPgoKPGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoMC4wMDAwMDAsMTAwLjAwMDAwMCkgc2NhbGUoMC4xMDAwMDAsLTAuMTAwMDAwKSIgc3Ryb2tlPSJub25lIj4KPHBhdGggZD0iTTQzMiA5MTAgYy0xMDUgLTIyIC0yMDQgLTEwNyAtMjQyIC0yMDYgLTI5IC04MCAtMjkgLTMyOCAwIC00MDggMjkKLTc2IDg4IC0xMzkgMTY2IC0xNzcgNTcgLTI4IDc2IC0zMyAxNDQgLTMzIDY4IDAgODcgNSAxNDQgMzMgNzggMzggMTM3IDEwMQoxNjYgMTc3IDI5IDgwIDI5IDMyOCAwIDQwOCAtNTUgMTQ1IC0yMjQgMjM4IC0zNzggMjA2eiBtMTc0IC0xMDEgYzYzIC0yMyAxMjgKLTExMCAxNDAgLTE4OCBsNyAtNDEgLTEwNyAwIC0xMDYgMCAwIDEyNiAwIDEyNSAyMyAtNyBjMTIgLTQgMzIgLTEwIDQzIC0xNXoKbTE0MiAtMzg2IGMtNiAtOTQgLTI5IC0xNDUgLTkwIC0xOTcgLTg5IC03NyAtMjI3IC03NyAtMzE2IDAgLTYxIDUyIC04NCAxMDMKLTkwIDE5NyBsLTUgNzcgMjUzIDAgMjUzIDAgLTUgLTc3eiIvPgo8L2c+Cjwvc3ZnPgo=" alt="" data-size="line"></td></tr><tr><td>Edit point</td><td>Drag</td></tr><tr><td>Drag bounding box</td><td>Alt + Hold <img src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBzdGFuZGFsb25lPSJubyI/Pgo8IURPQ1RZUEUgc3ZnIFBVQkxJQyAiLS8vVzNDLy9EVEQgU1ZHIDIwMDEwOTA0Ly9FTiIKICJodHRwOi8vd3d3LnczLm9yZy9UUi8yMDAxL1JFQy1TVkctMjAwMTA5MDQvRFREL3N2ZzEwLmR0ZCI+CjxzdmcgdmVyc2lvbj0iMS4wIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciCiB3aWR0aD0iMTAwLjAwMDAwMHB0IiBoZWlnaHQ9IjEwMC4wMDAwMDBwdCIgdmlld0JveD0iMCAwIDEwMC4wMDAwMDAgMTAwLjAwMDAwMCIKIHByZXNlcnZlQXNwZWN0UmF0aW89InhNaWRZTWlkIG1lZXQiPgoKPGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoMC4wMDAwMDAsMTAwLjAwMDAwMCkgc2NhbGUoMC4xMDAwMDAsLTAuMTAwMDAwKSIgc3Ryb2tlPSJub25lIj4KPHBhdGggZD0iTTQzMiA5MTAgYy0xMDUgLTIyIC0yMDQgLTEwNyAtMjQyIC0yMDYgLTI5IC04MCAtMjkgLTMyOCAwIC00MDggMjkKLTc2IDg4IC0xMzkgMTY2IC0xNzcgNTcgLTI4IDc2IC0zMyAxNDQgLTMzIDY4IDAgODcgNSAxNDQgMzMgNzggMzggMTM3IDEwMQoxNjYgMTc3IDI5IDgwIDI5IDMyOCAwIDQwOCAtNTUgMTQ1IC0yMjQgMjM4IC0zNzggMjA2eiBtMTc0IC0xMDEgYzYzIC0yMyAxMjgKLTExMCAxNDAgLTE4OCBsNyAtNDEgLTEwNyAwIC0xMDYgMCAwIDEyNiAwIDEyNSAyMyAtNyBjMTIgLTQgMzIgLTEwIDQzIC0xNXoKbTE0MiAtMzg2IGMtNiAtOTQgLTI5IC0xNDUgLTkwIC0xOTcgLTg5IC03NyAtMjI3IC03NyAtMzE2IDAgLTYxIDUyIC04NCAxMDMKLTkwIDE5NyBsLTUgNzcgMjUzIDAgMjUzIDAgLTUgLTc3eiIvPgo8L2c+Cjwvc3ZnPgo=" alt="" data-size="line"></td></tr><tr><td>Drag bounding box</td><td>Alt + Arrow Keys</td></tr><tr><td><strong>You can create new bounding box immediately after.</strong></td><td></td></tr></tbody></table>

| Scene Navigation                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Zoom with `Mouse wheel`. Hold <img src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBzdGFuZGFsb25lPSJubyI/Pgo8IURPQ1RZUEUgc3ZnIFBVQkxJQyAiLS8vVzNDLy9EVEQgU1ZHIDIwMDEwOTA0Ly9FTiIKICJodHRwOi8vd3d3LnczLm9yZy9UUi8yMDAxL1JFQy1TVkctMjAwMTA5MDQvRFREL3N2ZzEwLmR0ZCI+CjxzdmcgdmVyc2lvbj0iMS4wIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciCiB3aWR0aD0iMTAwLjAwMDAwMHB0IiBoZWlnaHQ9IjEwMC4wMDAwMDBwdCIgdmlld0JveD0iMCAwIDEwMC4wMDAwMDAgMTAwLjAwMDAwMCIKIHByZXNlcnZlQXNwZWN0UmF0aW89InhNaWRZTWlkIG1lZXQiPgoKPGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoMC4wMDAwMDAsMTAwLjAwMDAwMCkgc2NhbGUoMC4xMDAwMDAsLTAuMTAwMDAwKSIgc3Ryb2tlPSJub25lIj4KPHBhdGggZD0iTTQzMiA5MTAgYy0xMDUgLTIyIC0yMDQgLTEwNyAtMjQyIC0yMDYgLTI5IC04MCAtMjkgLTMyOCAwIC00MDggMjkKLTc2IDg4IC0xMzkgMTY2IC0xNzcgNTcgLTI4IDc2IC0zMyAxNDQgLTMzIDY4IDAgODcgNSAxNDQgMzMgNzggMzggMTM3IDEwMQoxNjYgMTc3IDI5IDgwIDI5IDMyOCAwIDQwOCAtNTUgMTQ1IC0yMjQgMjM4IC0zNzggMjA2eiBtMjggLTIwNSBsMCAtMTI1IC0xMDYKMCAtMTA3IDAgNyA0MSBjOSA1OSA0MCAxMTMgODUgMTUwIDMzIDI4IDg2IDU1IDExNCA1OCA0IDEgNyAtNTUgNyAtMTI0eiBtMjg4Ci0yODIgYy02IC05NCAtMjkgLTE0NSAtOTAgLTE5NyAtODkgLTc3IC0yMjcgLTc3IC0zMTYgMCAtNjEgNTIgLTg0IDEwMyAtOTAKMTk3IGwtNSA3NyAyNTMgMCAyNTMgMCAtNSAtNzd6Ii8+CjwvZz4KPC9zdmc+Cg==" alt="" data-size="line"> to move scene. |

## Integrating Bounding Boxes with Semi-Automated and Automated Tools

Bounding boxes can be seamlessly combined with both semi-automated and fully automated object detection tools to improve and speed up your image annotation.

### **Semi-Automated Object Detection with OWL-ViT**

[OWL-ViT](https://ecosystem.supervisely.com/apps/serve-owl-vit?utm\_source=blog) (Vision Transformer for Open-World Localization) uses bounding boxes as a reference to improve object detection. Here’s how it works:

* **Reference Image Mode**: Annotate an object with a bounding box in a reference image, and OWL-ViT will use this to identify similar objects in other images.
* **Text Prompt Mode**: Define objects using text descriptions, and OWL-ViT will detect these objects across your dataset.

### **Automated Pre-Labeling with YOLOv8**

[YOLOv8](https://ecosystem.supervisely.com/apps/yolov8/serve?utm\_source=blog) offers a fully automated approach to object detection. It uses bounding boxes to quickly and accurately label objects in large datasets:

* **Automatic Detection**: YOLOv8 generates bounding boxes around objects without the need for manual input.
* **Batch Processing**: Apply the model to all images in a project for efficient pre-labeling.

For more information on using bounding boxes with [OWL-ViT](https://ecosystem.supervisely.com/apps/serve-owl-vit?utm\_source=blog) and [YOLOv8](https://ecosystem.supervisely.com/apps/yolov8/serve?utm\_source=blog) models, check out our [**comprehensive Bounding Box guide.**](https://supervisely.com/blog/bounding-box-annotation-for-object-detection/#what-is-object-detection)

{% embed url="https://supervisely.com/blog/bounding-box-annotation-for-object-detection/#what-is-object-detection" %}
