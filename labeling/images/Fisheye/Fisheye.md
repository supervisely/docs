# Fisheye

## Overview

Challenging to annotate images with fisheye distortion? Activate the **fisheye labeling interface** in Supervisely to annotate fisheye images with calibration-aware tools, including a 3D cuboid projected onto the image.

{% embed url="https://youtu.be/nWBiSWdZRcY" %}

Fisheye images are a special type of images that are captured with an ultra-wide-angle lens (a.k.a. fisheye lens). The fisheye lens produces strong visual distortion intended to create a wide panoramic or hemispherical image. It is a popular choice for many applications, such as surveillance, automotive, and VR/AR.

Annotation happens directly on the fisheye image: the toolbox reads the camera calibration from the image metadata and uses it to project annotations — most notably the 3D `Cuboid` — onto the distorted image, so figures follow the lens geometry without manual correction.

{% hint style="info" %}
Currently, the toolbox supports the `cylindrical_equidist` camera model for calibration.
{% endhint %}

To use the fisheye labeling interface, follow these steps:

1. create a project with the `Fisheye` labeling interface enabled.
2. prepare calibration files with parameters for fisheye images (metadata files). Check out the [Fisheye Lens Calibration Metadata](Fisheye.md#fisheye-lens-calibration-metadata) section for more details.
3. import fisheye images with the calibration parameters and annotations (optional).

{% hint style="success" %}
Check out the [Import Fisheye Images](../../../data-organization/import/import/supported-formats-images/fisheye.md) page to learn how to structure and import fisheye images with calibration parameters to Supervisely.
{% endhint %}

## Fisheye Lens Calibration Metadata

It is essential to provide calibration data for fisheye images — the fisheye labeling interface uses it to project annotations onto the distorted image. The calibration data is stored in metadata files in JSON format.

Here are the key points and fields descriptions:

- `cameraModel` - the camera projection model. Currently, only `cylindrical_equidist` is supported.
- `fx`, `fy` - the focal lengths of the camera in pixels.
- `cx`, `cy` - the coordinates of the principal point (optical image center) in pixels, e.g., half of the image width and height for a centered principal point.
- Optionally, the `extrinsic` block with the `quaternion` (rotation) and `translation` (in meters) fields can be provided. It describes the coordinate transformation from the camera coordinate system to the vehicle coordinate system.
- The vehicle coordinate system, which follows the ISO 8855 convention, is anchored to the ground below the midpoint of the rear axle. The X-axis points in the driving direction, the Y-axis points to the left side of the vehicle and the Z-axis points up from the ground.
- The camera sensor's coordinate system is based on OpenCV. The X axis points to the right along the horizontal sensor axis, the Y axis points downwards along the vertical sensor axis and the Z-axis points in viewing direction along the optical axis to maintain the right-handed system.

<details>

<summary><strong>Metadata file example</strong></summary>

```
{
  "calibration": {
    "extrinsic": {
      "quaternion": [
        0.39492483984846793,
        -0.5928584556321699,
        -0.5854007522749839,
        0.3871164962798451
      ],
      "translation": [
        -3.819498356,
        -0.070724798,
        0.730674159
      ]
    },
    "intrinsic": {
      "cx": 968,
      "cy": 776,
      "fx": 500,
      "fy": 500,
      "cameraModel": "cylindrical_equidist"
    }
  }
}
```

The `extrinsic` block is optional — the minimal valid metadata file contains only the `intrinsic` block.

</details>

## Tools Panel

The vertical toolbar on the left provides tools for navigating the scene and annotating fisheye images. Only one tool can be active at a time.

### Pan & Zoom Scene (`1`)

Pan and zoom the image. While this tool is active, interactions with annotations on the scene are disabled.

### Select Figure (`2`)

Click a figure on the image to select it, right-click to open the context menu. Hold `Shift` and click (or hold the mouse button) to select multiple figures. Selected figures can be edited, tagged, or deleted from the Objects panel. Zoom with the mouse wheel at any time.

### Cuboid 3D

The signature tool of the fisheye interface — see [Special Tool for Fisheye Images: Cuboid](#special-tool-for-fisheye-images-cuboid-3d) below.

### Bounding Box (Rectangle) Tool (`5`)

Create a box with two clicks, drag its points to edit, move the whole box with `Alt` + hold or `Alt` + arrow keys.

### Oriented Bounding Box Tool

A rectangle with a rotation handle for tilted objects: create with two clicks, rotate by dragging the rotation handle, drag points to edit.

### Polyline Tool (`6`)

Click to add points, click an edge to insert a point, `Shift` + click to remove a point, `Space` to finish and start a new line.

### Polygon Tool (`7`)

Minimum 3 points. Click to add points or insert a point on an edge, finish with `Space` or by clicking the first point. Instead of clicking point by point, hold the mouse button to auto-place points along the cursor path.

## Special Tool for Fisheye Images: Cuboid 3D

The `Fisheye` labeling interface includes the `Cuboid 3D` tool for annotating objects such as cars, pedestrians, and other traffic participants. The created figure has the `Cuboid 2D` geometry — a true **3D cuboid projected onto the 2D image**: it is placed in vehicle-space coordinates, has physical dimensions in meters and rotation angles, and its projection onto the fisheye image is computed from the camera calibration. The dimensions, rotation, and source are shown in the Object Metadata panel.

{% embed url="../../../.gitbook/assets/fisheye/fisheye-cuboid-3d.mp4?alt=media&token=db893ee3-ee05-4b64-8d95-6207392a7a27&autoplay=1&loop=1""}

Check out the [Cuboid](../../../data-organization/Annotation-JSON-format/04_Supervisely_Format_objects.md#cuboids-2d-annotation) section of the documentation to learn more about the 2D `Cuboid` geometry JSON format.

## How to Annotate a Cuboid: Step-by-Step

Follow these steps to label an object with the `Cuboid 3D` tool on an image that has no annotations yet:

1. Open a project with the `Fisheye` labeling interface enabled and open an image in the labeling toolbox. Make sure the image has calibration metadata — the projection is computed from it.
2. Create a new class with the `Cuboid` shape (or select an existing one) in the `Definitions` panel.
3. Select the `Cuboid 3D` tool on the toolbar.
4. Click on the object in the image — a 3D cuboid is placed at that point and projected onto the fisheye image. The annotation is saved automatically.
5. Fit the cuboid to the object using the editing modes that appear below the tool icon:
   - **Rotate** — rotate the cuboid around its axes.
   - **Scale** — change the physical dimensions of the cuboid.
   - **Free transform** — move and adjust the cuboid freely.
   - **Toggle helper lines** — show or hide projection guide lines.
   - **Toggle face selection** — select individual faces of the cuboid for precise fitting.
6. Check the result in the **Object Metadata** panel — it shows the cuboid dimensions in meters and its rotation angles.
7. Repeat the steps for other objects or move to the next image.
