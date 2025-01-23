# 🤖 Supervisely JSON

## Overview

{% hint style="success" %}
Easiest way to import your images with annotations is to use the Supervisely format. Check out the [Supervisely JSON format](../../../Annotation-JSON-format/00\_ann\_format\_navi.md) documentation for more details.
{% endhint %}

The Supervisely json-based annotation format supports such figures: `rectangle`, `line (polyline)`, `polygon`, `point`, `bitmap` (`mask`), `graph` (`keypoints`), `alpha mask`, `2D cuboid`. It is a universal format for various task types and is used in the Supervisely platform.

This format also supports importing images and their annotations directly from cloud storage links.

## Format description

**Supported image formats:** `.jpg`, `.jpeg`, `.mpo`, `.bmp`, `.png`, `.webp`, `.tiff`, `.tif`, `.jfif`, `.avif`, `.heic`, and `.heif`\
**With annotations:** Yes\
**Supported annotation file extension:** `.json`.\
**Grouped by:** Any structure (will be uploaded as a single dataset)\


## Input files structure

{% hint style="success" %}
Example data: [download ⬇️](https://github.com/supervisely-ecosystem/import-images-in-sly-format/files/12537201/robots\_project.zip).
{% endhint %}

Both directory and archive are supported.

**Recommended directory structure:**

```
  📦input_folder
   ┣ 📂dataset_name_01
   ┃  ┣ 📂ann
   ┃  ┃  ┣ 📄IMG_0748.jpeg.json
   ┃  ┃  ┗ 📄IMG_8144.jpeg.json
   ┃  ┣ 📂img
   ┃  ┃  ┣ 🏞️IMG_0748.jpeg
   ┃  ┃  ┗ 🏞️IMG_8144.jpeg
   ┃  ┗ 📂meta (optional)
   ┃     ┣ 📄IMG_0748.jpeg.json
   ┃     ┗ 📄IMG_8144.jpeg.json
   ┗ 📄meta.json
```

Project meta file `meta.json` is recommended to be present in the project directory. It contains classes and tags definitions for the project. If it is not present, app will try to create it from the annotations (if possible). Learn more about the `meta.json` file [here](https://docs.supervisely.com/customization-and-integration/00\_ann\_format\_navi/02\_project\_classes\_and\_tags).

{% hint style="info" %}
**Struggled with the structure?** No worries!

If you don't have the recommended structure, don't worry. You can upload images and annotations in any structure. In this case, the app will upload all images and annotations to a single dataset.

Just make sure that:

* Annotation files are in the `.json` format.
* Annotation files have the corresponding file name to the image file name (e.g. `image_1.jpg.json` is for the image `image_1.jpg`).
* Annotation files have the correct format (look at the example below).
* Image files are in the supported formats (provided above).
* Image and annotation files can be placed in any subdirectories or the root directory.
{% endhint %}

## Individual Image Annotations

For each image, we store the annotations in a separate `json` file named `image_name.image_format.json` with the following file structure:

```json
{
  "description": "food",
  "name": "tomatoes-eggs-dish.jpg",
  "size": {
    "width": 2100,
    "height": 1500
  },
  "tags": [],
  "objects": []
}
```

**Fields definitions:**

* `name` - string - image name
* `description` - string - (optional) - This field is used to store the text we want to assign to the image. In the labeling intrface it corresponds to the 'data' filed.
* `size` - stores image size. Mostly, it is used to get the image size without the actual image reading to speed up some data processing steps.
* `width` - image width in pixels
* `height` - image height in pixels
* `tags` - **list** of strings that will be interpreted as image [tags](https://docs.supervisely.com/customization-and-integration/00\_ann\_format\_navi/03\_supervisely\_format\_tags)
* `objects` - **list** of [objects on the image](https://docs.supervisely.com/customization-and-integration/00\_ann\_format\_navi/04\_supervisely\_format\_objects)

### Image annotation example with objects and tags

![Image annotation example](images/sly\_ann.png)

Example:

```json
{
  "description": "",
  "tags": [
    {
      "id": 86458971,
      "tagId": 28283797,
      "name": "like",
      "value": null,
      "labelerLogin": "alexxx",
      "createdAt": "2020-08-26T09:12:51.155Z",
      "updatedAt": "2020-08-26T09:12:51.155Z"
    },
    {
      "id": 86458968,
      "tagId": 28283798,
      "name": "situated",
      "value": "outside",
      "labelerLogin": "alexxx",
      "createdAt": "2020-08-26T09:07:26.408Z",
      "updatedAt": "2020-08-26T09:07:26.408Z"
    }
  ],
  "size": {
    "height": 952,
    "width": 1200
  },
  "objects": [
    {
      "id": 497521359,
      "classId": 1661571,
      "description": "",
      "geometryType": "bitmap",
      "labelerLogin": "alexxx",
      "createdAt": "2020-08-07T11:09:51.054Z",
      "updatedAt": "2020-08-07T11:09:51.054Z",
      "tags": [],
      "classTitle": "person",
      "bitmap": {
        "data": "eJwBgQd++IlQTkcNChoKAAAADUlIRF",
        "origin": [535, 66]
      }
    },
    {
      "id": 497521358,
      "classId": 1661574,
      "description": "",
      "geometryType": "rectangle",
      "labelerLogin": "alexxx",
      "createdAt": "2020-08-07T11:09:51.054Z",
      "updatedAt": "2020-08-07T11:09:51.054Z",
      "tags": [],
      "classTitle": "bike",
      "points": {
        "exterior": [
          [0, 236],
          [582, 872]
        ],
        "interior": []
      }
    }
  ]
}
```

## Useful links

* [Supervisely Annotation Format](https://developer.supervisely.com/getting-started/supervisely-annotation-format)
* [Supervisely Image Annotation](https://developer.supervisely.com/getting-started/supervisely-annotation-format/images)
* [\[SDK CLI\] Upload projects in Supervisely format](https://developer.supervisely.com/getting-started/command-line-interface/sdk-cli#upload-a-project)
* [\[CLI Tool Beta\] Upload projects in Supervisely format](https://developer.supervisely.com/getting-started/command-line-interface/cli-tool/workflow-automation#upload-projects-in-supervisely-format)
*   [\[Supervisely Ecosystem\] Import images in Supervisely format](https://ecosystem.supervisely.com/apps/import-images-in-sly-format)

    ![](https://i.imgur.com/Y6RcQPT.png)
