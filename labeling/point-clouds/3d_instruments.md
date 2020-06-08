

Instruments panel on the left side of the screen provides tools to create and edit annotations and manipulate scene.

![](images/3d_instruments.PNG)

Only one instrument can be selected at a time.

## Auxiliary tools

Use the following tools to interact with scene and objects on it in a general way. These tools work with all objects of any shape or class.

### Pan & zoom scene tool

![](images/3d_move.png)

Choose this tool to pan and zoom the scene in the main scene or in the any of the additional view winows. While it's active, interactions with annotations on scene are disabled.

### Select figure tool

![](images/3d_drag.png)

Use `Select tool` to select objects (annotations) directly on the scene.

Immediately after selecting a figure, the corresponding editing tool with be enabled and you can start changing the annotation.

{% hint style="info" %}
You can also select annotations by clicking on them in the [figures panel](figures.md).
{% endhint %}

## Annotation tools

Use annotation tools to create new and change the existing figures.

### Shapes & Classes

Currently, each annotation instrument is used to create one of the following shapes:

- Cuboid
- Point (?)
- Point Cloud Pen

In Supervisely you can create objects of a specific shape or of 'Any shape'. So, fore example, if you created class `Road Sign` of the shape `Cuboid`, you can only create road signs with the `Cuboid tool`. However, if you created class `Car` of `Any Shape`, you can use all of the tools available in the interface. 

### Cuboid tool

![](images/3d_cuboid.png)



### Point tool

![](images/3d_point.png)

Create or change figure of `Point` shape. Click anywhere on the scene to create new point, then drag it or press [commit button](#commit-button) to save figure and start new figure.

`Point` shape contains *exactly one point* (aka `Landmark`).


### Point Cloud Pen Tool

![](images/3d_pcd_pen.png)

Create or change figure of `Rectangle` shape. Click anywhere on the scene to create top left point of the rectangle, then click second time to create bottom right point. Drag points or press [commit button](#commit-button) to save figure and start new figure.

`Rectangle` shape contains *exactly two* points.


### Polyline tool

![Polyline tool](../../assets/legacy/annotation/tools/polyline.png)

Create or change figure of `Polyline` shape. Click anywhere on the scene to create first point, then click multiple times to create  new points connected with line. Drag points or press [commit button](#commit-button) to save figure and start new figure.

`Polyline` shape contains *one or more* points.

Polyline tool has several modes:

**Add points consecutively**

![Consecutively](../../assets/legacy/annotation/tools/consecutively.png)

Each click will connect new point with the previously created one.


