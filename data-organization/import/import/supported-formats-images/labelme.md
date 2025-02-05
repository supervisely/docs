# LabelMe

## Overview

This converter allows to import images with `.json` annotations in [LabelMe](https://github.com/labelmeai/labelme?tab=readme-ov-file) format. Supported LabelMe format geometry types: `polygon`, `rectangle`, `circle`, `point`, `linestring`, `mask`, `line`.

![Result of the import](images/labelme\_res.png)

## Format description

**Supported image formats:** `.jpg`, `.jpeg`, `.mpo`, `.bmp`, `.png`, `.webp`, `.tiff`, `.tif`, `.jfif`, `.avif`, `.heic`, and `.heif`\
**With annotations:** yes\
**Supported annotation file extension:** `.json`.\
**Grouped by:** Any structure (will be uploaded as a single dataset)\


## Input files structure

{% hint style="success" %}
Example data: [download ⬇️](https://github.com/user-attachments/files/16179633/labelme\_demo.zip)
{% endhint %}

Example directory structure:

```
  📦input_folder
   ┣ 📂ann
   ┃  ┣ 📄IMG_0748.json
   ┃  ┗ 📄IMG_8144.json
   ┗ 📂img
      ┣ 🏞️IMG_0748.jpeg
      ┗ 🏞️IMG_8144.jpeg

```

## Single-Image Annotation JSON

An annotation file should contain the following fields:

* `shapes` - a list of dictionaries, each containing information about the object
  * `label` - the name of the class
  * `points` - a list of points of the object
  * `mask` - a base64 encoded mask of the object (for `mask` shape type)
  * `shape_type` - the type of the object (one of the following: `polygon`, `rectangle`, `circle`, `point`, `linestring`, `mask`, `line`)
* `imageHeight` - the height of the image
* `imageWidth` - the width of the image

Example of the annotation file:

<details>

<summary>📄IMG_0748.json</summary>

```json
{
  "version": "5.5.0",
  "flags": {},
  "shapes": [
    {
      "label": "cat_polygon",
      "points": [
        [1038.0000000000002, 91.00000000000023],
        [2363.0, 1311.0000000000002],
        [2373.0, 3236.0]
      ],
      "group_id": null,
      "description": "",
      "shape_type": "polygon",
      "flags": {},
      "mask": null
    },
    {
      "label": "cat_rectangle",
      "points": [
        [1033.0000000000002, 76.00000000000023],
        [2368.0, 1311.0000000000002]
      ],
      "group_id": null,
      "description": "",
      "shape_type": "rectangle",
      "flags": {},
      "mask": null
    },
    {
      "label": "cat_circle",
      "points": [
        [1123.0000000000002, 361.0000000000002],
        [1123.0000000000002, 631.0000000000002]
      ],
      "group_id": null,
      "description": "",
      "shape_type": "circle",
      "flags": {},
      "mask": null
    },
    {
      "label": "cat_line",
      "points": [
        [1043.0000000000002, 106.00000000000023],
        [1153.0000000000002, 3251.0]
      ],
      "group_id": null,
      "description": "",
      "shape_type": "line",
      "flags": {},
      "mask": null
    },
    {
      "label": "cat_point",
      "points": [[1038.0000000000002, 101.00000000000023]],
      "group_id": null,
      "description": "",
      "shape_type": "point",
      "flags": {},
      "mask": null
    },
    {
      "label": "cat_polyline",
      "points": [
        [1053.0000000000002, 96.00000000000023],
        [2373.0, 1291.0000000000002],
        [1148.0000000000002, 2171.0],
        [2393.0, 3246.0],
        [2393.0, 3246.0],
        [2393.0, 3246.0]
      ],
      "group_id": null,
      "description": "",
      "shape_type": "linestrip",
      "flags": {},
      "mask": null
    },
    {
      "label": "cat_ai_mask",
      "points": [
        [946.0, 847.0],
        [1665.0, 1346.0]
      ],
      "group_id": null,
      "description": "",
      "shape_type": "mask",
      "flags": {},
      "mask": "iVBORw0KGgoAAAANSU ... ElFTkSuQmCC"
    }
  ],
  "imagePath": "IMG_5853 2.jpg",
  "imageData": "/9j/4AAQSkZJRgAB ...dg+9FFFIo//Z",
  "imageHeight": 3382,
  "imageWidth": 2536
}
```

</details>

## Useful links

* [LabelMe page](https://github.com/labelmeai/labelme?tab=readme-ov-file)
