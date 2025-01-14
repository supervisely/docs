YOLO format is a popular, text-based format for different computer vision tasks, such as object detection, segmentation, and pose estimation.

For more information on how to import YOLO format data into Supervisely, see the [Import from YOLO](../../import/import/supported-formats-images/yolo.md) guide.

## Converting data using Supervisely Ecosystem Apps

- [Convert Supervisely to YOLO v5 format](https://ecosystem.supervisely.com/apps/convert-supervisely-to-yolov5-format). Transform images project in Supervisely (link to format) to YOLO v5 format and prepares downloadable `.tar` archive.
- [Export to YOLOv8 format](https://ecosystem.supervisely.com/apps/export-to-yolov8). Transform datasets from the Supervisely format to the YOLOv8 segmentation format or pose estimation format.

## Converting data using Supervisely Python SDK

Easily convert your data in one line of code using the Supervisely Python SDK.

{% hint style="success" %}

`sly.convert.to_yolo()` function automatically detects the input data type and converts it to Pascal VOC format. For example, you can pass a path to a project, sly.Project object, sly.Dataset object, or sly.Annotation object. For each input type, you need to provide dedicated parameters (as shown in the examples below).

```python
sly.convert.to_yolo("./sly_project", dest_dir="./result_yolo")
# or
sly.convert.to_yolo(project, dest_dir="./result_yolo")
# or
sly.convert.to_yolo(dataset, meta=project.meta, dest_dir="./result_yolo")
```

{% endhint %}

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
sly.convert.to_yolo("./sly_project", dest_dir="./result_yolo")

# Or using the sly.Project object
project_fs = sly.Project("./sly_project", sly.OpenMode.READ)
project_fs.to_yolo("./result_yolo", task_type="segmentation")
```

- Convert a specific dataset to YOLO format:

```python
ds = project_fs.datasets.get("dataset_name")

sly.convert.to_yolo(ds, meta=project_fs.meta, dest_dir="./result_yolo")
# Or using the sly.Dataset object
ds.to_yolo(project_fs.meta, dest_dir="./result_yolo")
```

- Convert a single `sly.Annotation` object to YOLO format:

```python
class_names = [obj_class.name for obj_class in meta.obj_classes]
ann = sly.Annotation.from_json(ann_json, meta)
yolo_lines = ann.to_yolo(class_names, task_type)
```
