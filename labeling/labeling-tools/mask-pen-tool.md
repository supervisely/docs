---
description: >-
  Learn how to use the Mask Pen annotation tool, a powerful combination of
  polygonal contours and freeform drawing, to create precise and flexible
  segmentation masks.
---

# Mask Pen Tool

## What is Mask Pen Annotation Tool?

The Mask Pen Tool is a versatile annotation tool that combines the precision of polygonal drawing with the flexibility of freeform brush strokes. This tool allows you to outline objects with both sharp, straight lines and smooth, curved contours, enabling you to create segmentation masks that perfectly match the shape of any object.

The Mask Pen tool helps when objects have a mix of sharp and blurred edges, or when a high level of detail is required in complex environments.

<figure><img src="../../.gitbook/assets/pen-tool.gif" alt=""><figcaption></figcaption></figure>

## Video Tutorial

Watch our comprehensive 5-minute video tutorial where our Supervisely expert guides you through the Mask Pen tool's functionalities.

{% embed url="https://www.youtube.com/watch?v=AyH8k_E3CDo" %}

## How to use Mask Pen Tool <a href="#how-to-use-the-brush-tool" id="how-to-use-the-brush-tool"></a>

Follow these step-by-step instructions to effectively use the Mask Pen tool for image segmentation.

### Create class with Mask shape <a href="#create-class-with-polygon-shape" id="create-class-with-polygon-shape"></a>

You can create a new class directly from the [Annotation Toolbox](https://app.supervisely.com/ecosystem/annotation\_tools/image-labeling-tool-v2?). To do this:

1. Click the **Pen Icon** in the toolbar of the labeling interface.
2. **Or** select an existing object class or add a new class by clicking **Add new class definition**.
3. In the modal window, enter the class name, choose the Mask or Any shape, and configure additional settings (e.g., color, hotkeys).
4. Click the `Create` button to add the new class to the definitions list.
5. Select the newly created class and segment the object with the mask in the image or video.

### Manual Annotation Guide

1. You can start by drawing a polygon or a freehand shape mask around the object area.

* **Polygon Mode:** Click on the image to create points along the boundary of the object. Each click adds a new point, forming a straight line between them. This mode is ideal for objects with well-defined, straight edges.
* **Brush Mode:** Hold the `SHIFT` key to switch between modes and, while holding down the left mouse button, draw free-form shapes. This is useful for objects with irregular boundaries.

2. To **finish** drawing the mask, connect the last point to the starting point or press the `SPACE` key to close the shape. This creates a closed mask around the object.
3. You can easily modify the mask after the figure is completed. To **add parts** to the mask, select the object and draw the new sections you want to include. To **erase parts** of the mask, hold the `SHIFT` key and draw over the area to be removed.

<figure><img src="../../.gitbook/assets/edit-pen.gif" alt=""><figcaption></figcaption></figure>

**Fill holes in the mask**\
If there are gaps or holes in the mask, use the **Bucket Fill** tool to quickly fill them with a single click. The selected object will be highlighted with a grid of dots, indicating the area to be filled.

**Segmentation of partially visible objects**

Unlike a regular polygon, the Mask Pen tool lets you pick spread out parts of an object in the image, even if they're not connected thanks to its integrated brush functions. Each part you select belongs to just one object until you press the `SPACE` key and choose a new shape.

**Split the mask into two figures**\
If you need to split a single mask into multiple separate objects, use the **Polygon Split** tool:

1. Outline the area to be separated and reconnect it to the starting point. Splitting the figure into parts results in multiple objects of the same class, which can then be individually classified.
2. If necessary, **Change the class** of each part of an object. You can opt for two alternative methods:
   * Right-click on the object and chose Change Class, OR
   * Select the object from the right panel and modify its class.
3. Once you've finished adjusting the mask, press `SPACE` or click the first point again to complete the annotation. This will save your changes and create a final segmentation mask.

{% hint style="info" %}
**Hint:** To quickly cut out the specific pixels of an object, click randomly near the object's boundary in areas without nearby objects.
{% endhint %}

<figure><img src="../../.gitbook/assets/split-mask.gif" alt=""><figcaption></figcaption></figure>

### Pro Tips <a href="#tips" id="tips"></a>

* Use the **Object Color Randomizer** to instantly change the color of any object with a single click, as often as you like. This is particularly useful if you have many objects of the same class, or if they are close together, so you can easily differentiate between masks.

Discover all the advanced features and unique applications of the Pen Tool in [our comprehensive blog post](https://supervisely.com/blog/mask-pen-tool/).

{% embed url="https://supervisely.com/blog/mask-pen-tool/" %}

## Hotkeys

Control the Mask Pen tool more efficiently with `HOTKEYS`.

| Mask Pen Tool        | 9                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| -------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Form polygon area    | <img src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBzdGFuZGFsb25lPSJubyI/Pgo8IURPQ1RZUEUgc3ZnIFBVQkxJQyAiLS8vVzNDLy9EVEQgU1ZHIDIwMDEwOTA0Ly9FTiIKICJodHRwOi8vd3d3LnczLm9yZy9UUi8yMDAxL1JFQy1TVkctMjAwMTA5MDQvRFREL3N2ZzEwLmR0ZCI+CjxzdmcgdmVyc2lvbj0iMS4wIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciCiB3aWR0aD0iMTAwLjAwMDAwMHB0IiBoZWlnaHQ9IjEwMC4wMDAwMDBwdCIgdmlld0JveD0iMCAwIDEwMC4wMDAwMDAgMTAwLjAwMDAwMCIKIHByZXNlcnZlQXNwZWN0UmF0aW89InhNaWRZTWlkIG1lZXQiPgoKPGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoMC4wMDAwMDAsMTAwLjAwMDAwMCkgc2NhbGUoMC4xMDAwMDAsLTAuMTAwMDAwKSIgc3Ryb2tlPSJub25lIj4KPHBhdGggZD0iTTQzMiA5MTAgYy0xMDUgLTIyIC0yMDQgLTEwNyAtMjQyIC0yMDYgLTI5IC04MCAtMjkgLTMyOCAwIC00MDggMjkKLTc2IDg4IC0xMzkgMTY2IC0xNzcgNTcgLTI4IDc2IC0zMyAxNDQgLTMzIDY4IDAgODcgNSAxNDQgMzMgNzggMzggMTM3IDEwMQoxNjYgMTc3IDI5IDgwIDI5IDMyOCAwIDQwOCAtNTUgMTQ1IC0yMjQgMjM4IC0zNzggMjA2eiBtMTc0IC0xMDEgYzYzIC0yMyAxMjgKLTExMCAxNDAgLTE4OCBsNyAtNDEgLTEwNyAwIC0xMDYgMCAwIDEyNiAwIDEyNSAyMyAtNyBjMTIgLTQgMzIgLTEwIDQzIC0xNXoKbTE0MiAtMzg2IGMtNiAtOTQgLTI5IC0xNDUgLTkwIC0xOTcgLTg5IC03NyAtMjI3IC03NyAtMzE2IDAgLTYxIDUyIC04NCAxMDMKLTkwIDE5NyBsLTUgNzcgMjUzIDAgMjUzIDAgLTUgLTc3eiIvPgo8L2c+Cjwvc3ZnPgo=" alt="" data-size="line">         |
| Form free shape area | <img src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBzdGFuZGFsb25lPSJubyI/Pgo8IURPQ1RZUEUgc3ZnIFBVQkxJQyAiLS8vVzNDLy9EVEQgU1ZHIDIwMDEwOTA0Ly9FTiIKICJodHRwOi8vd3d3LnczLm9yZy9UUi8yMDAxL1JFQy1TVkctMjAwMTA5MDQvRFREL3N2ZzEwLmR0ZCI+CjxzdmcgdmVyc2lvbj0iMS4wIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciCiB3aWR0aD0iMTAwLjAwMDAwMHB0IiBoZWlnaHQ9IjEwMC4wMDAwMDBwdCIgdmlld0JveD0iMCAwIDEwMC4wMDAwMDAgMTAwLjAwMDAwMCIKIHByZXNlcnZlQXNwZWN0UmF0aW89InhNaWRZTWlkIG1lZXQiPgoKPGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoMC4wMDAwMDAsMTAwLjAwMDAwMCkgc2NhbGUoMC4xMDAwMDAsLTAuMTAwMDAwKSIgc3Ryb2tlPSJub25lIj4KPHBhdGggZD0iTTQzMiA5MTAgYy0xMDUgLTIyIC0yMDQgLTEwNyAtMjQyIC0yMDYgLTI5IC04MCAtMjkgLTMyOCAwIC00MDggMjkKLTc2IDg4IC0xMzkgMTY2IC0xNzcgNTcgLTI4IDc2IC0zMyAxNDQgLTMzIDY4IDAgODcgNSAxNDQgMzMgNzggMzggMTM3IDEwMQoxNjYgMTc3IDI5IDgwIDI5IDMyOCAwIDQwOCAtNTUgMTQ1IC0yMjQgMjM4IC0zNzggMjA2eiBtMTc0IC0xMDEgYzYzIC0yMyAxMjgKLTExMCAxNDAgLTE4OCBsNyAtNDEgLTEwNyAwIC0xMDYgMCAwIDEyNiAwIDEyNSAyMyAtNyBjMTIgLTQgMzIgLTEwIDQzIC0xNXoKbTE0MiAtMzg2IGMtNiAtOTQgLTI5IC0xNDUgLTkwIC0xOTcgLTg5IC03NyAtMjI3IC03NyAtMzE2IDAgLTYxIDUyIC04NCAxMDMKLTkwIDE5NyBsLTUgNzcgMjUzIDAgMjUzIDAgLTUgLTc3eiIvPgo8L2c+Cjwvc3ZnPgo=" alt="" data-size="line"> + Draw  |
| Erase                | Hold Shift                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| Remove point         | Shift + <img src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBzdGFuZGFsb25lPSJubyI/Pgo8IURPQ1RZUEUgc3ZnIFBVQkxJQyAiLS8vVzNDLy9EVEQgU1ZHIDIwMDEwOTA0Ly9FTiIKICJodHRwOi8vd3d3LnczLm9yZy9UUi8yMDAxL1JFQy1TVkctMjAwMTA5MDQvRFREL3N2ZzEwLmR0ZCI+CjxzdmcgdmVyc2lvbj0iMS4wIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciCiB3aWR0aD0iMTAwLjAwMDAwMHB0IiBoZWlnaHQ9IjEwMC4wMDAwMDBwdCIgdmlld0JveD0iMCAwIDEwMC4wMDAwMDAgMTAwLjAwMDAwMCIKIHByZXNlcnZlQXNwZWN0UmF0aW89InhNaWRZTWlkIG1lZXQiPgoKPGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoMC4wMDAwMDAsMTAwLjAwMDAwMCkgc2NhbGUoMC4xMDAwMDAsLTAuMTAwMDAwKSIgc3Ryb2tlPSJub25lIj4KPHBhdGggZD0iTTQzMiA5MTAgYy0xMDUgLTIyIC0yMDQgLTEwNyAtMjQyIC0yMDYgLTI5IC04MCAtMjkgLTMyOCAwIC00MDggMjkKLTc2IDg4IC0xMzkgMTY2IC0xNzcgNTcgLTI4IDc2IC0zMyAxNDQgLTMzIDY4IDAgODcgNSAxNDQgMzMgNzggMzggMTM3IDEwMQoxNjYgMTc3IDI5IDgwIDI5IDMyOCAwIDQwOCAtNTUgMTQ1IC0yMjQgMjM4IC0zNzggMjA2eiBtMTc0IC0xMDEgYzYzIC0yMyAxMjgKLTExMCAxNDAgLTE4OCBsNyAtNDEgLTEwNyAwIC0xMDYgMCAwIDEyNiAwIDEyNSAyMyAtNyBjMTIgLTQgMzIgLTEwIDQzIC0xNXoKbTE0MiAtMzg2IGMtNiAtOTQgLTI5IC0xNDUgLTkwIC0xOTcgLTg5IC03NyAtMjI3IC03NyAtMzE2IDAgLTYxIDUyIC04NCAxMDMKLTkwIDE5NyBsLTUgNzcgMjUzIDAgMjUzIDAgLTUgLTc3eiIvPgo8L2c+Cjwvc3ZnPgo=" alt="" data-size="line"> |
| Finish               | Space                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| Finish               | Click the first point                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |

| Use Polygon Split (to cut mask into two figures) and Bucket Fill (to fill holes) in the tool subpanel                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Finish area using `SPACE` or <img src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBzdGFuZGFsb25lPSJubyI/Pgo8IURPQ1RZUEUgc3ZnIFBVQkxJQyAiLS8vVzNDLy9EVEQgU1ZHIDIwMDEwOTA0Ly9FTiIKICJodHRwOi8vd3d3LnczLm9yZy9UUi8yMDAxL1JFQy1TVkctMjAwMTA5MDQvRFREL3N2ZzEwLmR0ZCI+CjxzdmcgdmVyc2lvbj0iMS4wIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciCiB3aWR0aD0iMTAwLjAwMDAwMHB0IiBoZWlnaHQ9IjEwMC4wMDAwMDBwdCIgdmlld0JveD0iMCAwIDEwMC4wMDAwMDAgMTAwLjAwMDAwMCIKIHByZXNlcnZlQXNwZWN0UmF0aW89InhNaWRZTWlkIG1lZXQiPgoKPGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoMC4wMDAwMDAsMTAwLjAwMDAwMCkgc2NhbGUoMC4xMDAwMDAsLTAuMTAwMDAwKSIgc3Ryb2tlPSJub25lIj4KPHBhdGggZD0iTTQzMiA5MTAgYy0xMDUgLTIyIC0yMDQgLTEwNyAtMjQyIC0yMDYgLTI5IC04MCAtMjkgLTMyOCAwIC00MDggMjkKLTc2IDg4IC0xMzkgMTY2IC0xNzcgNTcgLTI4IDc2IC0zMyAxNDQgLTMzIDY4IDAgODcgNSAxNDQgMzMgNzggMzggMTM3IDEwMQoxNjYgMTc3IDI5IDgwIDI5IDMyOCAwIDQwOCAtNTUgMTQ1IC0yMjQgMjM4IC0zNzggMjA2eiBtMTc0IC0xMDEgYzYzIC0yMyAxMjgKLTExMCAxNDAgLTE4OCBsNyAtNDEgLTEwNyAwIC0xMDYgMCAwIDEyNiAwIDEyNSAyMyAtNyBjMTIgLTQgMzIgLTEwIDQzIC0xNXoKbTE0MiAtMzg2IGMtNiAtOTQgLTI5IC0xNDUgLTkwIC0xOTcgLTg5IC03NyAtMjI3IC03NyAtMzE2IDAgLTYxIDUyIC04NCAxMDMKLTkwIDE5NyBsLTUgNzcgMjUzIDAgMjUzIDAgLTUgLTc3eiIvPgo8L2c+Cjwvc3ZnPgo=" alt="" data-size="line"> the first point. |

|  Scene Navigation                                                 |
| ----------------------------------------------------------------- |
| Zoom with `MOUSE WHEEL`. Hold `RIGHT MOUSE BUTTON` to move scene. |
