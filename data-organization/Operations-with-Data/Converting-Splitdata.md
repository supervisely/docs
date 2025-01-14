# Converting & Splitting data

Converting data into different formats and splitting it into training and testing sets are essential operations in data preparation. In this section, you'll discover tools for efficiently performing these tasks. We have specific applications designed for data conversion and splitting, simplifying these processes. Additionally, you can use the Supervisely Python SDK to convert data to other formats.

## Converting data using Supervisely Ecosystem Apps

- [Convert Supervisely to YOLO v5 format.](https://ecosystem.supervisely.com/apps/convert-supervisely-to-yolov5-format) Transform images project in Supervisely (link to format) to YOLO v5 format and prepares downloadable tar archive.
- [Export to YOLOv8 format](https://ecosystem.supervisely.com/apps/export-to-yolov8) Export project to YOLOv8 segmentation format. It is a simple and efficient way to export your project to YOLOv8 format.
- [Export to COCO](https://ecosystem.supervisely.com/apps/export-to-coco). Convert project to COCO format. It is a simple and efficient way to export your project to COCO format.
- [Convert Class Shape.](https://ecosystem.supervisely.com/apps/convert-class-shape)
  It is often needed to convert labeled objects from one geometry to another while doing computer vision reseach. There are huge number of scenarios , here are some examples:
  - you labeled data with polygons to train semantic segmentation model, and then you decided to try detection model. Therefore you have to convert your labels from polygons to rectangles (bounding boxes)
  - or you applied neural network to images and it produced pre-annotations as bitmaps (masks). Then you want to transform them to polygons for manual correction.
- [Convert Point Clouds project to Episodes.](https://ecosystem.supervisely.com/apps/convert_ptc_to_ptc_episodes) Convert point clouds project to Point Cloud Episodes format. All figures (3D bounding boxes) with the same object_id from different point clouds will be united into tracklets.

  It is a useful app If you have a Point Clouds project and you want to apply 3D tracking tools and export project annotations with tracklets in a convenient-to-use format.

- [Convert labels to rotated bboxes.](https://ecosystem.supervisely.com/apps/convert-labels-to-rotated-bboxes) Convert labels in the project or dataset to rotated bounding boxes (Polygon with properties of rotated bbox). Supported shapes: Polygon, Bitmap, Line, Rectangle or Any Shape with any of the mentioned shapes. Resulting label names will be added suffix ro_bbox, e.g plane -> plane_ro_bbox. Disable Keep original annotations checkbox if you don't want to copy original labels. The application always converts data to the new project, original project will remain unchanged.

- [Convert to semantic segmentation.](https://ecosystem.supervisely.com/apps/convert-to-semantic-segmentation) App converts all supported labels to one bitmap for each supported class. It may be helpful when you change your task from instance to semantic segmentation.

  - Supported classes: Polygon, Bitmap or Any Shape

  - Supported labels: Polygon, Bitmap

    All other shapes will be ignored, and will not be presenting in resulted project.

## Convert data using Supervisely Python SDK

{% hint style="success" %}
**TL;DR:** If you have a local project in Supervisely format and want to convert it to COCO, YOLO, or Pascal VOC format, you can use the following code snippets:

```python
import supervisely as sly

# Convert project to COCO format
sly.convert.project_to_coco("./sly_project", "./result_coco")

# Convert project to YOLO format (you can specify task_type)
sly.convert.project_to_yolo("./sly_project", "./result_yolo")

# Convert project to Pascal VOC format
sly.convert.project_to_pascal_voc("./sly_project", "./result_pascal")
```

You can also convert a dataset-level data or a single annotation to COCO/YOLO/Pascal VOC format. Check the examples below.
{% endhint %}

### Convert to COCO Format

This converter allows you to convert a project, dataset, or a single annotation to COCO format. Each dataset in the project will be converted to a separate COCO dataset. The single `sly.Annotation` object will be converted to a list of COCO annotation format objects.

{% hint style="info" %}
It supports the following geometry types: `sly.Rectangle`, `sly.Bitmap`, `sly.Polygon`, `sly.GraphNodes`.

Enabling the `with_captions` parameter will include captions in the COCO annotations (if present in the project).
{% endhint %}

- Convert a project to COCO format:

```python
# One line of code
sly.convert.project_to_coco("./sly_project", "./result_coco")

# Or using the sly.Project object
project_fs = sly.Project("./sly_project", sly.OpenMode.READ)
project_fs.to_coco("./result_coco")
```

- Convert a specific dataset to COCO format:

```python
for ds in project_fs.datasets:
    # One line of code
    sly.convert.dataset_to_coco(dataset=ds, meta=project_fs.meta, dest_dir="./result_coco")

    # Or using the sly.Dataset object
    ds.to_coco(project_fs.meta, dest_dir="./result_coco")
```

- Convert a single `sly.Annotation` object to COCO format:

```python
coco_instances = dict(
    info=dict(
        description="COCO dataset converted from Supervisely",
        url="None",
        version=str(1.0),
        year=2025,
        contributor="Supervisely",
        date_created="2025-01-01 00:00:00",
    ),
    licenses=[dict(url="None", id=0, name="None")],
    images=[],
    annotations=[],
    categories=get_categories_from_meta(meta),  # [{"supercategory": "lemon", "id": 0, "name": "lemon"}, ...]
)
class_mapping = {obj_cls.name: idx for idx, obj_cls in enumerate(meta.obj_classes)}

# iterate over all annotations in the project and convert them to COCO format
# for example, let's convert only one annotation:
image_id = 1 # image id for the image in COCO annotation file
label_id = 1 # label id for the COCO objects (will be incremented for each object)

ann = sly.Annotation.from_json(ann_json, meta)
ann.to_coco(image_id, class_mapping, coco_instances, label_id)
```

### Convert to YOLO Format

This converter allows you to convert a project, dataset, or a single annotation to YOLO format for **detection**, **segmentation**, and **pose estimation** tasks.

Project and dataset conversion works similarly and will convert all data in the same structure to YOLO format. The single `sly.Annotation` object will be converted to a list of YOLO annotation format lines.

{% hint style="info" %}
It supports the following geometry types:

- **detection**: `sly.Rectangle`, `sly.Bitmap`, `sly.Polygon`, `sly.GraphNodes`, `sly.Polyline`, `sly.AlphaMask`
- **segmentation**: `sly.Polygon`, `sly.Bitmap`, `sly.AlphaMask`
- **pose estimation**: `sly.GraphNodes`

{% endhint %}

- Convert a project to YOLO format:

```python
# One line of code
sly.convert.project_to_yolo("./sly_project", "./result_yolo", task_type="detection")

# Or using the sly.Project object
project_fs = sly.Project("./sly_project", sly.OpenMode.READ)
project_fs.to_yolo("./result_yolo", task_type="segmentation")
```

- Convert a specific dataset to YOLO format:

```python
for ds in project_fs.datasets:
    # One line of code
    sly.convert.dataset_to_yolo(dataset=ds, meta=project_fs.meta, dest_dir="./result_yolo")

    # Or using the sly.Dataset object
    ds.to_yolo(project_fs.meta, dest_dir="./result_yolo")
```

- Convert a single `sly.Annotation` object to YOLO format:

```python
class_names = [obj_class.name for obj_class in meta.obj_classes]
ann = sly.Annotation.from_json(ann_json, meta)
yolo_lines = ann.to_yolo(class_names, task_type)
```

### Convert to Pascal VOC Format

This converter allows you to convert a project, dataset, or a single annotation to Pascal VOC format. Each dataset in the project will be converted to a separate Pascal VOC dataset. The single `sly.Annotation` object will be converted to a tuple of Pascal VOC annotation format xml object and numpy masks (instances masks and class masks).

- Convert a project to Pascal VOC format:

```python
# One line of code
sly.convert.project_to_pascal_voc("./sly_project", "./result_pascal")

# Or using the sly.Project object
project_fs = sly.Project("./sly_project", sly.OpenMode.READ)
project_fs.to_pascal_voc("./result_pascal")
```

- Convert a specific dataset to Pascal VOC format:

```python
for ds in project_fs.datasets:
    # One line of code
    sly.convert.dataset_to_pascal_voc(dataset=ds, meta=project_fs.meta, dest_dir="./result_pascal")

    # Or using the sly.Dataset object
    ds.to_pascal_voc(project_fs.meta, dest_dir="./result_pascal")
```

- Convert a single `sly.Annotation` object to Pascal VOC format:

```python
ann = sly.Annotation.from_json(ann_json, meta)
xml, instance_masks, class_masks = ann.to_pascal_voc("image_name")
```

## Splitting Data Using Supervisely Ecosystem Apps

Splitting data into training and testing sets is a crucial step in machine learning projects. Here are some apps from the Supervisely Ecosystem that can help you with this task:

- [Assign train/val tags to images](https://ecosystem.supervisely.com/apps/tag-train-val-test). This app allows you to assign tags to images in a dataset to split them into training, validation, and testing sets. You can specify the percentage of images for each set and assign tags accordingly. The resulting project can be used in training apps to create sets using tags.

- [Split datasets](https://ecosystem.supervisely.com/apps/split-dataset). This app allows you to split selected datasets into parts according to the specified percentage/number of images/number of parts. You can choose to split the dataset randomly or by the order of images. The resulting datasets can be created in the same project or in a new one.

## Splitting Data Using Supervisely Python SDK

Here is an example of how you can split a project into training and testing sets using the Supervisely Python SDK:

```python
import supervisely as sly

# Read the project
project_fs = sly.Project("./sly_project", sly.OpenMode.READ)
```

- Splitting by percentage:

```python
train_n = int(project_fs.total_items * 0.8)
val_n = project_fs.total_items - train_n
train_set, val_set =  project_fs.get_train_val_splits_by_count("./sly_project", train_n, val_n)
```

- Splitting by dataset names:

```python
train_set, val_set =  project_fs.get_train_val_splits_by_dataset("./sly_project", ["ds1", "ds2"], ["ds3"])
```

- Splitting by tags:

```python
train_set, val_set =  project_fs.get_train_val_splits_by_tag("./sly_project", ["tag1", "tag2"], ["tag3"])
```

All the above methods will return two lists of `ItemInfo` objects that represent the training and validation sets items.

```python
class ItemInfo(NamedTuple):
    dataset_name: str  # Item's dataset name
    name: str  # Item's name
    img_path: str  # Full image file path of item
    ann_path: str  # Full annotation file path of item
```

You can use these items to get the corresponding image name and path, annotation path, and dataset name.

```python
for item in train_set:
    print(f"{item.name=}, {item.img_path=}, {item.ann_path=}")
```
