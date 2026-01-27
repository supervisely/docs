---
description: >-
  Label comprehensive 3D scenes from LiDAR or RADAR sensors with additional
  photo and video context, AI object tracking and point cloud segmentation.
hidden: true
---

# 3D Point Clouds

Visualization and labeling of spatial point clouds is not a simple task. Supervisely, as a full-stack Computer Vision Platform, covers the entire cycle from annotation to model training and deployment for 3D Point Cloud data, significantly simplifying the annotation process. To successfully complete the annotation project in 3D space, we need to solve three additional challenges and provide:

* **Support for LiDAR, RADAR, multiple cameras, and sensor fusion:** The 3D Point Cloud annotation tool seamlessly integrates data from different modalities, providing a unified platform for annotation and projection across various sensor types.
* **Works with both separate 3D point cloud frames and 3D point cloud episodes:** Our tool is equipped to handle both individual frames and sequences, catering to the needs of different applications, including episodic data analysis.
* **Handy annotation tools for detection and segmentation tasks:** We offer intuitive annotation tools optimized for detection and segmentation tasks, including easy-to-use: Cuboid, Smart Tool and Point Cloud Pen.
* **3D tiles:** Our tool efficiently handles tens of millions of points with ease, thanks to its 3D tiling capabilities. Upload Point Clouds of unlimited size with 3D TILE technology. Speed up the process of loading whole scans, no matter how big the file size. The Supervisely 3D Point Cloud Tool splits point clouds into 3D tiles, then only loads the visible tiles and nearby ones while you're using the interface. You'll save time loading scans, make it easier on your GPU, and keep the labeling experience smooth.

**3D Point Cloud Tool** is a labeling toolbox for visualizing and working with point clouds. It provides a user-friendly interface for loading, viewing and annotating 3D objects represented as point data. This tool can be used to work with **`.pcd`** (point cloud data) files, which are widely used in computer vision applications.



### **3D Object detection and Classification**

Visualization and, especially, labeling of spatial point clouds is not a simple task. Apart from plain and well-understood image labeling, to successfully complete annotation project in 3D space we need to solve three additional challenges and provide:

* User-friendly navigation in three dimensions
* Handy tools for accurate object detection
* Maximum information for correct classification

### **Voyaging the three-dimensional space**

Before you can identify and label an object of interest you need to see it clear from every angle. To let some sunlight into the scene, we have introduced widely known navigation from video games with WASD keyboard controls to move around point cloud and mouse to control the camera angle.

Along with additional viewports with top-side-front perspectives using orthographic projections, it gives accurate representation of what you are dealing with.

![](../../.gitbook/assets/Voyaging.gif)

