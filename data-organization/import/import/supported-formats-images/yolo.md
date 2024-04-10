<!-- <h1 align="left" style="border-bottom: 0"> <img align="left" src="./images/yolo_logo.png" width="80" style="padding-right: 20px;"> YOLO Format </h1>

<br> -->

# Overview

This converter allows to import images with annotations in [YOLO](https://docs.ultralytics.com/datasets/detect/) format. YOLO format has a config `.yaml` file that contains information about classes and datasets, usually named `data_config.yaml` . Each image should have a corresponding `.txt` file with the same name, which contains information about objects in the image.

⚠️ **Note:** If YOLO project do not contain `data_config.yaml` file, it will use default COCO class names.

![yolo result](./images/yolo_res.png)

<details>
    <summary> Default COCO class names </summary>

```text
names:
  [
    "person",
    "bicycle",
    "car",
    "motorcycle",
    "airplane",
    "bus",
    "train",
    "truck",
    "boat",
    "traffic light",
    "fire hydrant",
    "stop sign",
    "parking meter",
    "bench",
    "bird",
    "cat",
    "dog",
    "horse",
    "sheep",
    "cow",
    "elephant",
    "bear",
    "zebra",
    "giraffe",
    "backpack",
    "umbrella",
    "handbag",
    "tie",
    "suitcase",
    "frisbee",
    "skis",
    "snowboard",
    "sports ball",
    "kite",
    "baseball bat",
    "baseball glove",
    "skateboard",
    "surfboard",
    "tennis racket",
    "bottle",
    "wine glass",
    "cup",
    "fork",
    "knife",
    "spoon",
    "bowl",
    "banana",
    "apple",
    "sandwich",
    "orange",
    "broccoli",
    "carrot",
    "hot dog",
    "pizza",
    "donut",
    "cake",
    "chair",
    "couch",
    "potted plant",
    "bed",
    "dining table",
    "toilet",
    "tv",
    "laptop",
    "mouse",
    "remote",
    "keyboard",
    "cell phone",
    "microwave",
    "oven",
    "toaster",
    "sink",
    "refrigerator",
    "book",
    "clock",
    "vase",
    "scissors",
    "teddy bear",
    "hair drier",
    "toothbrush",
  ]

```

</details>

# Format description

**Supported image formats:** `.jpg`, `.jpeg`, `.mpo`, `.bmp`, `.png`, `.webp`, `.tiff`, `.tif`, and `.jfif`.<br>
**With annotations:** yes<br>
**Supported annotation format:** `.txt`.<br>
**Grouped by:** any structure (uploaded to a single dataset)<br>

# Input files structure

You can download an example of data for import [here](https://github.com/supervisely-ecosystem/import-wizard-docs/files/14919196/sample_yolo.zip).<br>

Recommended directory structure:

```text
project name
 ┣ 📂images
 ┃ ┣ 📂train
 ┃ ┃ ┣ 🖼️IMG_0748.jpeg
 ┃ ┃ ┣ 🖼️IMG_1836.jpeg
 ┃ ┃ ┣ 🖼️IMG_2084.jpeg
 ┃ ┃ ┗ 🖼️IMG_3861.jpeg
 ┃ ┗ 📂val
 ┃ ┃ ┣ 🖼️IMG_4451.jpeg
 ┃ ┃ ┗ 🖼️IMG_8144.jpeg
 ┣ 📂labels
 ┃ ┣ 📂train
 ┃ ┃ ┣ 📜IMG_0748.txt
 ┃ ┃ ┣ 📜IMG_1836.txt
 ┃ ┃ ┣ 📜IMG_2084.txt
 ┃ ┃ ┗ 📜IMG_3861.txt
 ┃ ┗ 📂val
 ┃ ┃ ┣ 📜IMG_4451.txt
 ┃ ┃ ┗ 📜IMG_8144.txt
 ┗ 📜data_config.yaml
```

# Format Config File

File `data_config.yaml` should contain the following keys:
* `names` - a list of class names
* `colors` - a list of class colors in RGB format
* `nc` - the number of classes
* `train` - the path to the train images
* `val` - the path to the validation images

<details>
    <summary>📜data_config.yaml</summary>

```yaml
names: [kiwi, lemon] # class names
colors: [[255, 1, 1], [1, 255, 1]] # class colors
nc: 2 # number of classes
train: ../lemons/images/train # path to train imgs (or "images/train")
val: ../lemons/images/val # path to val imgs (or "images/val")
```

</details>

# Individual Image Annotations

Annotation files are in `.txt` format and should contain object labels on each line.
Box coordinates must be in normalized xywh format (from 0 to 1).
If your boxes are in pixels, you should divide x_center and width by image width, and y_center and height by image height.
Class numbers should be zero-indexed (start with 0).

The Annotation `.txt` file should be formatted with one row per object in:

```text
class_id x_center y_center width height
```

The label file corresponding to the below image contains 2 persons (class 0) and a tie (class 27) from original COCO classes.

📜zidan.txt

```text
0 0.481719 0.634028 0.690625 0.713278
0 0.741094 0.524306 0.314750 0.933389
27 0.364844 0.795833 0.078125 0.400000
```

![yolo coordinates example](./images/yolo_coords.png)

# Useful links
- [YOLO format](https://docs.ultralytics.com/datasets/detect/)
- [[Supervisely Ecosystem] Convert YOLO v5 to Supervisely format](https://ecosystem.supervisely.com/apps/convert-yolov5-to-supervisely-format)
