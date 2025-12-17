# Fisheye

## Overview

Annotate fisheye images with ease using the fisheye labeling interface in Supervisely.

![](../../../../.gitbook/assets/fisheye_interface-frame.jpg)

To use the fisheye labeling interface, you need to:

1. create a project with the `Fisheye` labeling interface enabled.
2. prepare calibration files with parameters for fisheye images (metadata files). Check out the [Fisheye Lens Metadata](fisheye.md#fisheye-lens-metadata) section for more details.
3. import fisheye images with the calibration parameters and annotations (optional).

{% hint style="info" %}
To correctly import fisheye images, all metadata files should be placed **in the directory with the `meta` name**.
{% endhint %}

The `Fisheye` labeling interface in Supervisely provides the new labeling tool 2D Cuboid for annotating objects like cars, pedestrians, and other objects in fisheye images. Learn more about the 2D Cuboid annotation format in the [documentation](../../../Annotation-JSON-format/04_Supervisely_Format_objects.md#cuboids-2d-annotation).

## Description

**Supported image formats:** `.jpg`, `.jpeg`, `.mpo`, `.bmp`, `.png`, `.webp`, `.tiff`, `.tif`, `.jfif`, `.avif`, `.heic`, and `.heif`\
**With annotations:** supported\
**Supported projectiom:** cylindrical

## Data structure

* **Folder** or **Archive** (`zip`, `tar`)

```
📦 my_project.zip or 📂 my_project
    ┣ 📂 img
    ┃  ┣ 🏞️ car_105.jpg
    ┃  ┗ 🏞️ car_202.jpg
    ┣ 📂 meta
    ┃  ┣ 📄 car_105.jpg.json     ⬅️ calibration parameters
    ┃  ┗ 📄 car_202.jpg.json     ⬅️ calibration parameters
    ┗ 📂 ann
    ┣ 📄 car_105.jpg.json        ⬅️ annotation files (optional)
    ┗ 📄 car_202.jpg.json        ⬅️ annotation files (optional)
```

The `meta` folder contains metadata files for fisheye images with the calibration parameters. Each metadata file should have the same name as the corresponding image file + `.json` extension.

The `ann` folder contains annotation files in the Supervisely format. Each annotation file should have the same name as the corresponding image file + `.json` extension. Annotation files are optional.

## Fisheye Lens Metadata

Extrinsic calibration data is used to describe the coordinate transformation from the camera coordinate system to the vehicle coordinate system

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
      "vfov": 97.9998472,
      "cxOffset": 0.59267,
      "cyOffset": -7.22379,
      "lensCoeffs": {
        "k1": 466.35917211,
        "k2": 32.48178784,
        "k3": -52.1509689,
        "k4": 73.79780387,
        "k5": -30.12830986,
        "k6": -0.37231277
      },
      "aspectRatio": 1.0,
      "cameraModel": "radial_poly"
    }
  }
}
```

</details>

It is essential to provide calibration data for fisheye images to allow the fisheye labeling interface to correct the distortion. The calibration data is stored in metadata files in JSON format.

Here are the key points and fields descriptions:

* Extrinsic calibration data is used to describe the coordinate transformation from the camera coordinate system to the vehicle coordinate system.
* The vehicle coordinate system, which follows the ISO 8855 convention, is anchored to the ground below the midpoint of the rear axle. The X-axis points in the driving direction, the Y-axis points to the left side of the vehicle and the Z-axis points up from the ground.
* The camera sensor's coordinate system is based on OpenCV. The X axis points to the right along the horizontal sensor axis, the Y axis points downwards along the vertical sensor axis and the Z-axis points in viewing direction along the optical axis to maintain the right-handed system.
* The values of the translation are given in meters and the rotation is given as a quaternion.
* The intrinsic calibration is given in a calibration model that describes the radial distortion using an Nth-order polynomial. The radial distortion is given by the formula:

![](../../../../.gitbook/assets/formula.svg)

* Formula: `theta` is the angle of incidence with respect to the optical axis and rho is the distance between the image center and projected point - focal distance.
* Offsets (`cxOffset`, `cyOffset`) of the principal point are given in pixels.
* `vfov` is the vertical field of view of the camera in degrees and the aspect ratio is the ratio of the width to the height of the image.
