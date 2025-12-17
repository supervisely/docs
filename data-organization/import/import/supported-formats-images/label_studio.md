# LabelStudio

## Overview

This converter allows to import images with `.json` annotations in [LabelStudio](https://labelstud.io/guide/export#Label-Studio-JSON-format-of-annotated-tasks) format. Supported LabelStuidio format geometry types: `polygonlabels` (`polygon`), `rectanglelabels` (`rectangle`), `brushlabels` (RLE masks), and `choices` (`tags`)

![Result of the import](../../../../.gitbook/assets/labelstudio_res.png)

## Format description

**Supported image formats:** `.jpg`, `.jpeg`, `.mpo`, `.bmp`, `.png`, `.webp`, `.tiff`, `.tif`, `.jfif`, `.avif`, `.heic`, and `.heif`\
**With annotations:** yes\
**Supported annotation file extension:** `.json`.\
**Grouped by:** Any structure (will be uploaded as a single dataset)\\

## Input files structure

{% hint style="success" %}
Example data: [download ⬇️](https://github.com/user-attachments/files/16183688/label_studio_demo.zip)
{% endhint %}

⚠️ **Note:** image names should correspond to the names in the annotation files (`data` > `image` field in the JSON file).

Example directory structure:

```
  📦input_folder
   ┣ 📂ann
   ┃  ┣ 📄annotation_1.json
   ┃  ┗ 📄annotation_4.json
   ┗ 📂img
      ┣ 🏞️IMG_0748.jpeg
      ┗ 🏞️IMG_8144.jpeg

```

## Single-Image Annotation JSON

An annotation file should contain the following fields:

* `annotations` or `predictions` - a list of dictionaries, each containing annotation for single image
  * `result` - list of dictionaries, each containing information about the objects
    * `original_width` - the width of the original image
    * `original_height` - the height of the original image
    * `value` - a dictionary containing information about the object
      * `polygonlabels`/`rectanglelabels`/`brushlabels`/`choices` - field with the object class name
      * `points` - a list of points of the object (for `polygonlabels` and `rectanglelabels` shape types)
      * `rle` and `format` - a base64 encoded mask of the object (for `mask` shape type)
    * `type` - the type of the object (one of the following: `polygonlabels`, `rectanglelabels`, `brushlabels`, `choices`, `relation`)
* `data` - a dictionary containing information about the image
  * `image` - the path to the image

Example of the annotation file:

<details>

<summary>📄 annotation_1.json</summary>

```json
[
  {
    "id": 13,
    "annotations": [
      {
        "id": 7,
        "completed_by": 1,
        "result": [
          {
            "original_width": 1280,
            "original_height": 853,
            "image_rotation": 0,
            "value": {
              "x": 14.107390372983872,
              "y": 15.524193548387096,
              "width": 61.535093245967744,
              "height": 70.36290322580646,
              "rotation": 0,
              "rectanglelabels": ["Airplane"]
            },
            "id": "eGEJdycmv3",
            "from_name": "label",
            "to_name": "image",
            "type": "rectanglelabels",
            "origin": "manual"
          }
        ],
        "was_cancelled": false,
        "ground_truth": false,
        "created_at": "2024-07-05T13:18:24.130642Z",
        "updated_at": "2024-07-05T13:18:24.130665Z",
        "draft_created_at": null,
        "lead_time": 7.935,
        "prediction": {},
        "result_count": 0,
        "unique_id": "f527f9c8-affe-469b-991a-70ec6fd79e54",
        "import_id": null,
        "last_action": null,
        "task": 13,
        "project": 8,
        "updated_by": 1,
        "parent_prediction": null,
        "parent_annotation": null,
        "last_created_by": null
      }
    ],
    "file_upload": "airplane.jpg",
    "drafts": [],
    "predictions": [],
    "data": {
      "image": "/data/upload/8/airplane.jpg"
    },
    "meta": {},
    "created_at": "2024-07-05T13:18:14.329289Z",
    "updated_at": "2024-07-05T13:18:24.152845Z",
    "inner_id": 1,
    "total_annotations": 1,
    "cancelled_annotations": 0,
    "total_predictions": 0,
    "comment_count": 0,
    "unresolved_comment_count": 0,
    "last_comment_updated_at": null,
    "project": 8,
    "updated_by": 1,
    "comment_authors": []
  }
]
```

</details>

## Useful links

* [LabelStudio GitHub page](https://github.com/HumanSignal/label-studio?tab=readme-ov-file#try-out-label-studio)
* [LabelStudio website](https://labelstud.io/)
