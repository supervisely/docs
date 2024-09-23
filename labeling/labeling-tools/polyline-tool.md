# Polyline Tool

The **Polyline Tool** is designed for annotating objects with connected lines, allowing users to draw complex, linear shapes by connecting multiple points. This tool is particularly useful for tasks that involve outlining elongated or irregularly shaped objects, such as roads, rivers or contours in an image. It provides a high degree of precision for tasks that require more accuracy than simple bounding boxes.

## **How to Use the Polyline Tool**

Follow these step-by-step instructions to use the Polyline Tool effectively for image annotation:

### **Create a Class with Polyline Shape**

You can create a new class directly from the Annotation Toolbox. To do this:

1. Click on the **Polyline Tool icon** in the toolbar of the labeling interface.
2. Alternatively, select an existing object class or add a new class by clicking **Add new class definition**.
3. In the modal window, enter the class name, choose **Polyline** or **Any shape**, and configure additional settings (e.g., color, hotkeys).
4. Click the **Create** button to add the new class to the definitions list.
5. Select the newly created class and start drawing the polyline around the object in the image or video.

***

### **Manual Annotation Guide**

1. Select the Polyline Tool and click on the image to create the first point.
2. Continue clicking to add additional points, which will be connected by straight lines, forming the polyline.
3. To finish drawing the polyline, press the **SPACE** key.
4. After creating the polyline, you can adjust its shape by dragging any of the points to a new location.
   * Add new points by clicking on the line segment where you want to insert a new point.
   * To remove a point, hold **Shift** and click on the point you wish to delete.
5. Select the polyline you wish to remove and press the **Delete** key on your keyboard.

***

### **Pro Tips**

* **Use the Auto-Select feature** to quickly switch between classes and edit existing polylines.
* Utilize the **Object Color Randomizer** to instantly change the color of polylines, which is especially helpful when multiple objects overlap or when you want to distinguish between different annotations.
* Take advantage of zoom and pan functions to ensure precise placement of points, especially for intricate or detailed areas of the image.

## Hotkeys

| Start & add point             | `Left mouse click` |
| ----------------------------- | ------------------ |
| Add point on the edge         | `Left mouse click` |
| Move point                    | `Drag`             |
| Remove point                  | `Shift + Click`    |
| Finish and start new polyline | `Shift + Click`    |

| Scene Navigation                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Zoom with Mouse wheel. Hold <img src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBzdGFuZGFsb25lPSJubyI/Pgo8IURPQ1RZUEUgc3ZnIFBVQkxJQyAiLS8vVzNDLy9EVEQgU1ZHIDIwMDEwOTA0Ly9FTiIKICJodHRwOi8vd3d3LnczLm9yZy9UUi8yMDAxL1JFQy1TVkctMjAwMTA5MDQvRFREL3N2ZzEwLmR0ZCI+CjxzdmcgdmVyc2lvbj0iMS4wIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciCiB3aWR0aD0iMTAwLjAwMDAwMHB0IiBoZWlnaHQ9IjEwMC4wMDAwMDBwdCIgdmlld0JveD0iMCAwIDEwMC4wMDAwMDAgMTAwLjAwMDAwMCIKIHByZXNlcnZlQXNwZWN0UmF0aW89InhNaWRZTWlkIG1lZXQiPgoKPGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoMC4wMDAwMDAsMTAwLjAwMDAwMCkgc2NhbGUoMC4xMDAwMDAsLTAuMTAwMDAwKSIgc3Ryb2tlPSJub25lIj4KPHBhdGggZD0iTTQzMiA5MTAgYy0xMDUgLTIyIC0yMDQgLTEwNyAtMjQyIC0yMDYgLTI5IC04MCAtMjkgLTMyOCAwIC00MDggMjkKLTc2IDg4IC0xMzkgMTY2IC0xNzcgNTcgLTI4IDc2IC0zMyAxNDQgLTMzIDY4IDAgODcgNSAxNDQgMzMgNzggMzggMTM3IDEwMQoxNjYgMTc3IDI5IDgwIDI5IDMyOCAwIDQwOCAtNTUgMTQ1IC0yMjQgMjM4IC0zNzggMjA2eiBtMjggLTIwNSBsMCAtMTI1IC0xMDYKMCAtMTA3IDAgNyA0MSBjOSA1OSA0MCAxMTMgODUgMTUwIDMzIDI4IDg2IDU1IDExNCA1OCA0IDEgNyAtNTUgNyAtMTI0eiBtMjg4Ci0yODIgYy02IC05NCAtMjkgLTE0NSAtOTAgLTE5NyAtODkgLTc3IC0yMjcgLTc3IC0zMTYgMCAtNjEgNTIgLTg0IDEwMyAtOTAKMTk3IGwtNSA3NyAyNTMgMCAyNTMgMCAtNSAtNzd6Ii8+CjwvZz4KPC9zdmc+Cg==" alt="" data-size="line"> to move scene. |

