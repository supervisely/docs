# Fisheye

## Overview

Annotate fisheye images with ease using the fisheye labeling interface in Supervisely.

{% embed url="https://files.gitbook.com/v0/b/gitbook-x-prod.appspot.com/o/spaces%2F9mM1dNm0uHlRsfWgJmow%2Fuploads%2FfQTE2KHt1zzOrlGujqR1%2Ffisheye-cuboid-3d.mp4?alt=media&token=ddcc4708-f94c-432d-8a80-ada377456003&autoplay=1&loop=1" %}
Fisheye labeling interface
{% endembed %}

To use the fisheye labeling interface, you need to:

1. create a project with the `Fisheye` labeling interface enabled.
2. prepare calibration files with parameters for fisheye images (metadata files). Check out the [Fisheye Lens Metadata](fisheye.md#fisheye-lens-metadata) section for more details.
3. import fisheye images with the calibration parameters and annotations (optional).

{% hint style="info" %}
To correctly import fisheye images, all metadata files should be placed **in the directory with the `meta` name**.
{% endhint %}

The `Fisheye` labeling interface in Supervisely provides the new labeling tool 2D Cuboid for annotating objects like cars, pedestrians, and other objects in fisheye images. Learn more about the 2D Cuboid annotation format in the [documentation](../../../Annotation-JSON-format/04_Supervisely_Format_objects.md#cuboids-2d-annotation).

## Labeling Toolbox

After import, fisheye images are annotated in the Image Labeling Toolbox with the **Fisheye labeling interface**. It uses the calibration metadata to project annotations onto the distorted image and includes a special `Cuboid 3D` tool — a 3D cuboid projected onto the 2D fisheye image.

{% hint style="success" %}
Check out the [Fisheye labeling interface](../../../../labeling/images/Fisheye/Fisheye.md) page to learn how to annotate fisheye images in Supervisely.
{% endhint %}

## Description

**Supported image formats:** `.jpg`, `.jpeg`, `.mpo`, `.bmp`, `.png`, `.webp`, `.tiff`, `.tif`, `.jfif`, `.avif`, `.heic`, and `.heif`\
**With annotations:** supported\
**Supported projection:** cylindrical

## Data structure

* **Folder** or **Archive** (`zip`, `tar`)

```text
📦 my_project.zip or 📂 my_project
└── 📂 dataset_01
    ├── 📂 img
    │   ├── 🏞️ car_105.jpg
    │   └── 🏞️ car_202.jpg
    ├── 📂 meta
    │   ├── 📄 car_105.jpg.json     ⬅️ calibration parameters
    │   └── 📄 car_202.jpg.json     ⬅️ calibration parameters
    └── 📂 ann
        ├── 📄 car_105.jpg.json     ⬅️ annotation files (optional)
        └── 📄 car_202.jpg.json     ⬅️ annotation files (optional)
```

The project may contain one or more dataset folders (e.g., `dataset_01`), each with its own `img`, `meta`, and `ann` folders.

The `meta` folder contains metadata files for fisheye images with the calibration parameters. Each metadata file should have the same name as the corresponding image file + `.json` extension.

The `ann` folder contains annotation files in the Supervisely format. Each annotation file should have the same name as the corresponding image file + `.json` extension. Annotation files are optional.

## Fisheye Lens Metadata

It is essential to provide calibration data for fisheye images to allow the fisheye labeling interface to correct the distortion. The calibration data is stored in metadata files in JSON format.

<details>

<summary><strong>Metadata example</strong></summary>

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

Here are the key points and fields descriptions:

- `cameraModel` - the camera projection model. Currently, only `cylindrical_equidist` is supported; support for Equirectangular, Cubemap, Rectilinear (Perspective), and Stereographic projections is in active development.
- `fx`, `fy` - the focal lengths of the camera in pixels.
- `cx`, `cy` - the coordinates of the principal point (optical image center) in pixels, e.g., half of the image width and height for a centered principal point.
- Optionally, the `extrinsic` block with the `quaternion` (rotation) and `translation` (in meters) fields can be provided. It describes the coordinate transformation from the camera coordinate system to the vehicle coordinate system.
- The vehicle coordinate system, which follows the ISO 8855 convention, is anchored to the ground below the midpoint of the rear axle. The X-axis points in the driving direction, the Y-axis points to the left side of the vehicle and the Z-axis points up from the ground.
- The camera sensor's coordinate system is based on OpenCV. The X axis points to the right along the horizontal sensor axis, the Y axis points downwards along the vertical sensor axis and the Z-axis points in viewing direction along the optical axis to maintain the right-handed system.
