# Overview

{% hint style="success" %}
Easily import your point cloud episodes with annotations in the SemanticKITTI format.
{% endhint %}

The SemanticKITTI format is designed for semantic scene understanding of LiDAR sequences. It provides dense point-wise semantic annotations for point cloud episodes, enabling tasks like semantic segmentation, panoptic segmentation, and semantic scene completion. The format supports multiple sequences with semantic classes covering vehicles, buildings, vegetation, road surfaces, and other urban environment objects.

# Input files structure

{% hint style="success" %}
Example data: [download ⬇️](https://github.com/supervisely-ecosystem/demo-semantic-kitti-pointcloud-episodes-annotated/releases/download/v1.0.0/project.zip) - sample data from the official SemanticKITTI dataset<br>
{% endhint %}

**Format directory structure:**

```text
📦SemanticKITTI
├──📂sequences
│   ├──📂00
│   │   ├──📂velodyne
│   │   │   ├──📄000000.bin
│   │   │   ├──📄000001.bin
│   │   │   ├──📄000002.bin
│   │   │   └──📄...
│   │   ├──📂labels
│   │   │   ├──📄000000.label
│   │   │   ├──📄000001.label
│   │   │   ├──📄000002.label
│   │   │   └──📄...
│   │   ├──📄calib.txt
│   │   ├──📄poses.txt
│   │   └──📄times.txt
│   ├──📂01
│   │   ├──📂velodyne
│   │   │   └──📄...
│   │   ├──📂labels
│   │   │   └──📄...
│   │   ├──📄calib.txt
│   │   ├──📄poses.txt
│   │   └──📄times.txt
│   └──📂...
```

**The SemanticKITTI structure is organized as follows:**

- `sequences/` - contains numbered sequence folders
  - `XX/` - sequence folder (e.g., 00, 01, 02...)
    - `velodyne/` - contains LiDAR point cloud files in binary format
    - `labels/` - contains semantic and instance labels for each scan
    - `calib.txt` - calibration file containing projection matrices
    - `poses.txt` - camera poses for each scan
    - `times.txt` - timestamps for each scan

# SemanticKITTI Annotation format

## Point Cloud Files (`.bin`)

Point cloud files are stored in binary format with `.bin` extension. Each file contains a list of 3D points with intensity values.

**Format:** Each point is represented by 4 float32 values:

- `x` - X coordinate (float32)
- `y` - Y coordinate (float32)
- `z` - Z coordinate (float32)
- `intensity` - Reflectance value (float32)

## Label Files (`.label`)

The label files are stored in binary format with the `.label` extension. Each label file corresponds to a single point cloud scan and contains semantic and instance annotations for each point.

**Format:**
Each label is a 32-bit unsigned integer (`uint32_t`) encoding both semantic class and instance ID:

- **Lower 16 bits** - semantic label (class ID)
- **Upper 16 bits** - instance ID (temporally consistent across the sequence)

The instance IDs are consistent over the whole sequence, meaning the same object in different scans gets the same ID. This applies to both moving and static objects.

## Calibration File (`calib.txt`)

The calibration file contains projection matrices for transforming between coordinate systems. It includes:

- `P0`, `P1`, `P2`, `P3` - Camera projection matrices (3x4)
- `Tr` - Transformation matrix from Velodyne to camera coordinates (3x4 or 4x4)

## Poses File (`poses.txt`)

The poses file contains the camera pose (transformation from camera coordinates to world coordinates) for each scan in the sequence. Each line represents a pose as a 3x4 transformation matrix (flattened to 12 values).

**Format:** Each line contains 12 float values representing the first three rows of a 4x4 transformation matrix (the last row is [0, 0, 0, 1]).

## Times File (`times.txt`)

The times file contains timestamps for each scan in the sequence. Each line contains a single float value representing the timestamp in seconds.

# Export

You can export your labeled point cloud episodes data to SemanticKITTI format using the <a href="https://ecosystem.supervisely.com/apps/export-to-semantic-kitti" target="_blank">Export to SemanticKITTI</a> application from the Supervisely Ecosystem.

# License

The SemanticKITTI dataset is distributed under the <a href="https://creativecommons.org/licenses/by-nc-sa/4.0/" target="_blank">Creative Commons Attribution-NonCommercial-ShareAlike 4.0</a> license. You are free to share and adapt the data, but you must give appropriate credit and may not use the work for commercial purposes.

When using the SemanticKITTI dataset, please cite:

```bibtex
@inproceedings{behley2019iccv,
  author = {J. Behley and M. Garbade and A. Milioto and J. Quenzel and S. Behnke and C. Stachniss and J. Gall},
  title = {{SemanticKITTI: A Dataset for Semantic Scene Understanding of LiDAR Sequences}},
  booktitle = {Proc. of the IEEE/CVF International Conf.~on Computer Vision (ICCV)},
  year = {2019}
}
```

And the original KITTI Vision Benchmark:

```bibtex
@inproceedings{geiger2012cvpr,
  author = {A. Geiger and P. Lenz and R. Urtasun},
  title = {{Are we ready for Autonomous Driving? The KITTI Vision Benchmark Suite}},
  booktitle = {Proc.~of the IEEE Conf.~on Computer Vision and Pattern Recognition (CVPR)},
  pages = {3354--3361},
  year = {2012}
}
```
