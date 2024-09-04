# Images

The image labeling toolbox allows you to annotate one image at a time, such as .jpg, .png, .tiff, and many more formats you can [import](broken-reference) to Supervisely.

### Classic vs Version 2.0

We have two versions of the image labeling toolbox: the time proven classic version and it’s successor: the most advanced image labeling toolbox 2.0. By default, we suggest annotating the version 2.0 which has much more functionality and provides better performance and only consider the classic version in case you have a valid reason for that, such as your team got used to it and loves it so much 🙂

Learn more about the updates to our new i**mage annotation tool** in this comprehensive blog post:

{% embed url="https://supervisely.com/blog/releasing-new-image-annotation-tool/#foreword" %}

## Overview

<figure><img src="../../.gitbook/assets/image-toolbox.png" alt=""><figcaption></figcaption></figure>

1. **Home button** — returns user to the main menu (`Projects` page)
2. **Additional controls** — basic settings, such as history of operations, theme, a hotkeys map and more useful features.
3. **Main scene** — annotation area for current image and its labels.
4. **Objects panel** — list of figures on the current image with additional information like classes and tags.
5. **Images/Apps/Settings panel** — list of images in your dataset, list of additional apps you can embed into the labeling toolbox, visualization and other settings.
6. **Instruments panel** — annotation tools used to create annotations.

The **Instruments panel** offering essential tools for completing different annotation tasks:

* [Bounding Box](https://supervisely.com/blog/bounding-box-annotation-for-object-detection/): Best for object detection tasks.
* [Polygon Tool](https://supervisely.com/blog/how-to-use-polygon-anotation-tool-for-image-segmentation/): Ideal for irregular and complex shapes.
* [Brush and Eraser Tool](https://supervisely.com/blog/brush/): Flexible for both polygonal and free-form masks.
* [Mask Pen Tool](https://supervisely.com/blog/mask-pen-tool/): Great for segmenting diverse objects with varying shapes.
* [Smart Tool](https://supervisely.com/blog/smarttool-annotation/): Efficient for quick, AI-assisted segmentation.
* [Graph (Keypoins) Tool](https://supervisely.com/blog/human-pose-estimation/): Best for pose-estimation tasks.

## **Key features of Image Labeling Toolbox Version 2.0**

1. Web-based interfaces — you just need a browser.
2. Fully customizable interface with easy-to-tune visualization settings: light and dark theme, flexible layout, multiple image view modes, multi-spectral view and grid.
3. Supports complex image formats: high-resolution images, high-color depth images with 16-bit per pixel or more, customizable image visualization settings, filter images with conditions, additional image metadata, restore mode and undo/redo functionality.
4. Advanced labeling capabilities: multiple annotation tools - [Bounding Box](https://supervisely.com/blog/bounding-box-annotation-for-object-detection/), [Polygon Tool](https://supervisely.com/blog/how-to-use-polygon-anotation-tool-for-image-segmentation/), [Brush and Eraser Tool](https://supervisely.com/blog/brush/), [Mask Pen Tool](https://supervisely.com/blog/mask-pen-tool/), [Smart Tool](https://supervisely.com/blog/smarttool-annotation/), [Graph (Keypoins) Tool](https://supervisely.com/blog/animal-pose-estimation/), effectively supports 1000+ objects per image, image and object tags and attributes, customizable hotkeys.
5. Collaboration and workflow management features for large annotation teams.
6. Integration with various Neural Networks and AI-assisted annotation tools.
7. Effortless data import and export for seamless sharing across platforms.
8. Compatible with medical, NRRD, NiFTI data.

... and many other cool futures described in [this](https://supervisely.com/blog/releasing-new-image-annotation-tool/#foreword) post!

## Tips for powerful labeling

**Use hotkeys:** check it out and customize hotkeys to switch tools, manipulate objects, and adjust visualization settings, quickly.&#x20;

**Object tags and attributes:** tagging simplifies image and object classification and improves neural network training by accounting for complex patterns and details.

**Utilize AI assistance:** use AI models to pre-label data and save time on manual corrections.&#x20;

**Organize your workspace:** customize the layout and use the multi-image view to handle large datasets.

## Productivity-improving features

### Auto-Object Selection

The auto-selection feature that selects objects when hovering over them optimizes the number of clicks needed for annotation, making the process faster and more convenient. This is especially useful when working with images containing many objects.

### Multi-Image Viewing Mode

The multi-image viewing mode allows you to view multiple images on the scene simultaneously, making it easier to compare annotation results or annotate images together.

### Conditional Image Filtering

Supervisely provides an extensive set of filters for searching images and objects. These filters allow users to fine-tune search criteria and find the necessary images and objects in large datasets.

### Metadata

The Supervisely platform allows viewing and editing metadata and custom data. This is useful for creating more informative and structured datasets, especially when integrating Supervisely with internal systems.

### Grid

The grid feature helps organize the annotation process by dividing the image into uniform areas. This is especially useful when labeling high-resolution images with many small objects.

### Tips and Instructions

The toolbar now includes interactive tips and GIF animations that explain the functionality of each tool. These tips significantly simplify mastering various annotation tools.
