# Overview

{% hint style="success" %}
Easily import your point clouds with annotations in the KITTI-360 format. This converter is designed for the point cloud episodes modality. For the point cloud modality, please refer to <a href="https://docs.supervisely.com/import-and-export/import/supported-annotation-formats/pointclouds/kitti3d" target="_blank">KITTI-3D</a>.
{% endhint %}

The original KITTI-360 is a large-scale annotated dataset recorded in the suburbs of Karlsruhe, Germany, covering 73.7 km of driving with over 320k images and 100k laser scans. It provides both 3D point clouds and 2D images with dense semantic and instance annotations across 19 classes, and maintains consistent instance IDs over time. The data, captured with a 360° sensing setup including fisheye and perspective cameras, a stereo camera, Velodyne, and SICK laser scanners, is precisely geolocalized using an IMU/GPS system.

# Format description

**Supported point cloud format:** `.bin`<br>
**With annotations:** yes<br>
**Supported annotation format:** `.xml`<br>
**Data structure:** Information is provided below.

# Input files structure

{% hint style="success" %}
Example data: [download ⬇️](https://github.com/supervisely-ecosystem/import-kitti-360/releases/download/v0.0.1/Example_1.zip)<br>
{% endhint %}

**Format directory structure:**

```
📦KITTI-360
├──📂calibration
│   ├──📄calib_cam_to_velo.txt
│   ├──📄perspective.txt
│   └──📄...
├──📂data_2d_raw
│   ├──📂2013_05_28_drive_{seq:04}_sync
│   │   ├──📂image_{00|01}
│   │   │   ├──📂data_rect
│   │   │   │   ├──🏞️{frame:010}.png
│   │   │   │   └──🏞️...
│   │   ├──📂image_{02|03}
│   │   │   └──📂...
├──📂data_3d_raw
│   ├──📂2013_05_28_drive_{seq:04}_sync
│   │   ├──📂velodyne_points
│   │   │   ├──📂data
│   │   │   │   ├──📄{frame:010}.bin
│   │   │   │   └──📄...
├──📂data_3d_bboxes
│   ├──📂train
│   │   ├──📄2013_05_28_drive_{seq:04}_sync.xml
│   │   └──📄...
├──📂data_poses
│   ├──📂2013_05_28_drive_{seq:04}_sync
│   │   ├──📄cam0_to_world.txt
└── └── └──📄...
```

{% hint style="info" %}
Information on the KITTI-360 dataset structure can be found <a href="https://www.cvlibs.net/datasets/kitti-360/documentation.php" target="_blank">here</a>
{% endhint %}

# Useful links

- <a href="https://www.cvlibs.net/datasets/kitti-360/index.php" target="_blank">KITTI-360 homepage</a>
- <a href="https://github.com/autonomousvision/kitti360Scripts" target="_blank">KITTI-360 GitHub page</a>