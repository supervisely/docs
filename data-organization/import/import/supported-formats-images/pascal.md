# Pascal VOC

## Overview

The Pascal VOC (Visual Object Classes) format stands as one of the benchmarks established relatively early for object classification, segmentation and detection. It furnishes a standardized dataset for identifying object classes, utilizing an XML-based export format that enjoys widespread adoption in computer vision tasks. This converter converts Pascal VOC format to Supervisely format. Learn more how to prepare data in Pascal VOC format and how to import the original Pascal VOC dataset in the [Import Pascal VOC](https://ecosystem.supervisely.com/apps/import-pascal-voc) app.

## Format description

**Supported image formats:** `.jpg`, `.jpeg`, `.mpo`, `.bmp`, `.png`, `.webp`, `.tiff`, `.tif`, `.jfif`, `.avif`, `.heic`, and `.heif`\
**With annotations:** Yes\
**Supported annotation files extensions:** `.xml` (bounding boxes), `.png` (segmentation masks)\
**Grouped by:** Any structure (will be uploaded as a single dataset)\


## Input files structure

{% hint style="success" %}
Example data: [download ⬇️](https://github.com/supervisely-ecosystem/import-pascal-voc/files/12600118/sample\_project.zip)
{% endhint %}

Pascal VOC archive or directory must have the following structure:

```
  📦custom_pascal.tar                    📂custom_pascal_project_dir
   ┗ 📂VOCdevkit                          ┗ 📂VOCdevkit
      ┗ 📂VOC or VOC2012                     ┗ 📂VOC or VOC2012
         ┣ 📂Annotations                        ┣ 📂Annotations
         ┣ 📂ImageSets                          ┣ 📂ImageSets
         ┃  ┣ 📂Mainn                           ┃  ┣ 📂Main
         ┃  ┗ 📂Segmentation                    ┃  ┗ 📂Segmentation
         ┣ 📂JPEGImage                          ┣ 📂JPEGImages
         ┣ 📂SegmentationClasss                 ┣ 📂SegmentationClass
         ┣ 📂SegmentationObject                 ┣ 📂SegmentationObject
         ┗ 📜colors.txt                         ┗ 📜colors.txt
```

**`colors.txt`** file is custom, and not provided in the original Pascal VOC Dataset. File contains information about instance mask colors associated with classes in Pascal VOC format. This file is required by this app, if you are uploading custom dataset. Each line of `colors.txt` file starts with `class_name` and ends with `RGB` values that represent class color.

**`colors.txt`** example:

```txt
neutral 224 224 192
kiwi 255 0 0
lemon 81 198 170
```

{% hint style="info" %}
Action and Layout Classification Image Sets are not supported by import application.
{% endhint %}

## Useful links

* [The PASCAL Visual Object Classes Homepage](http://host.robots.ox.ac.uk/pascal/VOC/)
* [Pascal VOC Ground Truth Annotation](http://host.robots.ox.ac.uk/pascal/VOC/voc2012/htmldoc/devkit\_doc.html#SECTION00035000000000000000)
*   [\[Supervisely Ecosystem\] Import Pascal VOC](https://ecosystem.supervisely.com/apps/import-pascal-voc)

    ![](https://github.com/supervisely-ecosystem/import-pascal-voc/assets/57998637/147d2ad4-327e-462a-b5b5-bc0887ac3c19)
