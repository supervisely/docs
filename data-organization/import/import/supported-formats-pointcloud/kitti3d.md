<h1 align="left" style="border-bottom: 0"> nuScenes </h1>

# Overview

{% hint style="success" %}
Easily import your pointclouds with annotations in the KITTI 3D format.
{% endhint %}

The KITTI dataset is a widely used computer vision dataset for training and evaluating algorithms for tasks like object detection, 3D object tracking, and scene understanding.

# Format description

**Supported point cloud format:** `.bin`<br>
**With annotations:** yes<br>
**Supported annotation format:** `.txt`<br>
**Data structure:** Information is provided below.

# Input files structure

{% hint style="success" %}
Example data: [download ⬇️](https://github.com/user-attachments/files/18378632/kitti3d-sample.zip).
{% endhint %}

Both directory and archive are supported.

**Format directory structure:**

```text
📦kitti3d_project (folder or .tar/.zip archive)
├──📂calib
│   ├──📄000000.txt
│   ├──📄000001.txt
│   ├──📄000002.txt
│   └──📄...
├──📂image_2
│   ├──🏞️000000.png
│   ├──🏞️000001.png
│   ├──🏞️000002.png
│   └──🏞️...
├──📂label_2
│   ├──📄000000.txt
│   ├──📄000001.txt
│   ├──📄000002.txt
│   └──📄...
└──📂velodyne
    ├──📄000000.bin
    ├──📄000001.bin
    ├──📄000002.bin
    └──📄...
```

**The KITTI3D sub-folders are structured as follows:**

- `image_02/` - contains the left color camera images (png)
- `label_02/` - contains the left color camera label files (plain text files)
- `calib/` - contains the calibration for all four cameras (plain text file)
- `velodyne/` - contains KITTI LIDAR point cloud binary files

{% hint style="info" %}
The KITTI 3D format description can be found <a href="https://github.com/yanii/kitti-pcl/blob/master/KITTI_README.TXT" target="_blank">here</a>
{% endhint %}

# KITTI 3D Annotation format

Dataset annotations are stored in plain text files with the `.txt` extension. Each annotation file corresponds to a single image in the dataset and contains annotations for objects in the scene.

### `label.txt`

The label file in the KITTI dataset provides annotations for objects in the scene, such as cars, pedestrians, and cyclists. This information is crucial for training and evaluating object detection and tracking algorithms.

The label file is a plain text file associated with each image in the dataset. Each label file contains a set of lines, with each line representing the annotation for a single object in the corresponding image.

**The format of each line is as follows:**

```text
object_type truncation occlusion alpha left top right bottom height width length x y z rotation_y
```

**Example:**

```text
Car -1.00 -1 1.90 434.56 225.91 592.44 319.73 1.44 1.64 3.78 -3.03 1.57 13.30 1.68 1.00
```

**Fields:**

- `object_type`: The type of the annotated object. This can be one of the following: 'Car', 'Van', 'Truck', 'Pedestrian', 'Person_sitting', 'Cyclist', 'Tram', 'Misc', or 'DontCare'. 'DontCare' is used for objects that are present but ignored for evaluation.
- `truncation`: The fraction of the object that is visible. It is a float value in the range [0.0, 1.0]. A value of 0.0 means the object is fully visible, and 1.0 means the object is completely outside the image frame.
- `occlusion`: The level of occlusion of the object. It is an integer value indicating the degree of occlusion, where 0 means fully visible, and higher values indicate increasing levels of occlusion.
- `alpha`: The observation angle of the object in radians, relative to the camera. It is the angle between the object's heading direction and the positive x-axis of the camera.
- `left`, `top`, `right`, `bottom`: The 2D bounding box coordinates of the object in the image. They represent the pixel locations of the top-left and bottom-right corners of the bounding box.
- `height`, `width`, `length`: The 3D dimensions of the object (height, width, and length) in meters.
- `x`, `y`, `z`: The 3D location of the object's centroid in the camera coordinate system (in meters).
- `rotation_y`: The rotation of the object around the y-axis in camera coordinates, in radians.

### `calib.txt`

The calib.txt file in the KITTI dataset contains calibration information for the sensors used in data collection, such as cameras and LiDAR. This calibration data is essential for projecting 3D points into the image plane, transforming between coordinate systems, and performing accurate object detection and localization.

The file is a plain text file that contains key-value pairs, with each key representing a calibration parameter and its corresponding value being a matrix or vector.

**The format of each line is as follows:**

```text
P0: [3x4 matrix]
P1: [3x4 matrix]
P2: [3x4 matrix]
P3: [3x4 matrix]
R0_rect: [3x3 matrix]
Tr_velo_to_cam: [3x4 matrix]
Tr_imu_to_velo: [3x4 matrix]
```

**Example:**

```text
P0: 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0
P1: 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0
P2: 721.5377197265625 0.0 609.559326171875 0.0 0.0 721.5377197265625 172.85400390625 0.0 0.0 0.0 1.0 0.0
P3: 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0
R0_rect: 1.0 0.0 0.0 0.0 1.0 0.0 0.0 0.0 1.0
Tr_velo_to_cam: 0.00023477392 -0.99994415 -0.010563477 -0.0027968169 0.010449408 0.0105653545 -0.9998896 -0.07510879 0.99994534 0.0001243655 0.010451303 -0.2721328
Tr_imu_to_velo: 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0
```

**Fields:**

- `P0`, `P1`, `P2`, `P3`: The 3x4 projection matrices for the four cameras (left and right color and grayscale). These matrices project 3D points in the camera coordinate system into the 2D image plane.
- `R0_rect`: The 3x3 rectification matrix for aligning the stereo cameras. It rectifies the rotation differences between the cameras to align them for stereo processing.
- `Tr_velo_to_cam`: The 3x4 transformation matrix from the Velodyne LiDAR coordinate system to the camera coordinate system.
- `Tr_imu_to_velo`: The 3x4 transformation matrix from the IMU coordinate system to the Velodyne LiDAR coordinate system.

# Useful links

- <a href="https://www.cvlibs.net/datasets/kitti/" target="_blank">KITTI homepage</a>
- <a href="https://mmdetection3d.readthedocs.io/en/v0.17.3/datasets/kitti_det.html" target="_blank">MMDetection3D Documentation on KITTI 3D dataset</a>