# High Color Depth

## High Color Depth Images

## Overview

This option allows you to upload images with high color depth to the platform without annotations. All images from the input directory and its subdirectories will be uploaded to a single dataset. All 3 dimensional images will be converted 2D grayscale images in `.nrrd` format by using `cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)` which uses a weighted sum of the color channels, giving more importance to green, followed by red, and the least importance to blue. This weighted conversion better represents human perception of brightness, as the green channel contributes the most.

After uploading high color depth images, you will be able to use windowing feature to adjust the brightness and contrast of the images.

![windowing](../../../../.gitbook/assets/high_color_depth.png)

## Format description

**Supported image formats:** `.exr`, `.hdr` **With annotations:** No\
**Supported annotation format:** Not applicable.\
**Grouped by:** Any structure (will be uploaded as a single dataset).<br>

## Input files structure

Example data: [download ⬇️](https://github.com/user-attachments/files/17310984/high-color-depth-sample.zip)<br>

Recommended directory structure:

```
📦project name
┣ 🖼️IMG_01.exr
┣ 🖼️IMG_02.exr
┣ 🖼️IMG_03.exr
┣ 🖼️IMG_04.exr
┣ 🖼️IMG_05.exr
┣ 🖼️IMG_06.hdr
┣ 🖼️IMG_07.hdr
┣ 🖼️IMG_08.hdr
┣ 🖼️IMG_09.hdr
┗ 🖼️IMG_10.hdr
```
