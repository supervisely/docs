---
description: >-
  In this guide, you'll learn about AI-driven tools which you can use in Supervisely to optimize your DICOM labeling pipelines.
---

# DICOM

## Interactive labeling models

Medical 3D volumes (CT/MRI) can have hundreds of slices per plane. Interactive segmentation models like SAM, RITM and ClickSeg can significantly reduce annotation time - a single slice can be labeled in just few clicks.

After DICOM data is imported to Supervisely, slices are generated in 3 planes: axial, sagittal and coronal. Even though segmentation is done on 2D images, you always know each slice’s location in the 3D volume. In Supervisely DICOM labeling tool you can label volume slices as usual 2D images with the help of interactive segmention models.

This process is repeated for each plane, but not every slice needs to be annotated - you can label only key slices and use [Volume Interpolation](https://ecosystem.supervisely.com/apps/volume-interpolation) app which reconstructs the object across other slices, with the ability to preview and edit in 3D. The Volume Interpolation app uses an [ITK-based implementation](https://github.com/KitwareMedical/ITKContourInterpolation) of morphological contour interpolation. Interpolation is done by first determining correspondence between shapes on adjacent segmented slices by detecting overlaps, then aligning the corresponding shapes, generating a transition sequence of one-pixel dilations, and taking the median as a result.