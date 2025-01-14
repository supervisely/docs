The [COCO](https://cocodataset.org/#home) format is widely used in the computer vision community and is supported by many popular frameworks and libraries. COCO format is a complex format that can contain multiple types of annotations. Supervisely supports conversions for instances, keypoints, and captions.

For more information on how to import COCO format data into Supervisely, see the [Import from COCO](../../import/import/supported-formats-images/coco.md) guide.

## Converting data using Supervisely Ecosystem Apps

- [Export to COCO](https://ecosystem.supervisely.com/apps/export-to-coco). Convert project to COCO format. It is a simple and efficient way to export your project to COCO format.
- [Export COCO Keypoints](https://ecosystem.supervisely.com/apps/export-coco-keypoints). App converts Supervisely format project to COCO Keypoints format as a downloadable `.tar` archive.

## Converting data using Supervisely Python SDK

Easily convert your data in one line of code using the Supervisely Python SDK.

{% hint style="success" %}

`sly.convert.to_coco()` function automatically detects the input data type and converts it to Pascal VOC format. For example, you can pass a path to a project, sly.Project object, sly.Dataset object, or sly.Annotation object. For each input type, you need to provide dedicated parameters (as shown in the examples below).

```python
sly.convert.to_coco("./sly_project", dest_dir="./result_coco")
# or
sly.convert.to_coco(project, dest_dir="./result_coco")
# or
sly.convert.to_coco(dataset, meta=project.meta, dest_dir="./result_coco")
```

{% endhint %}

Our Python SDK provides a simple way to convert your data to COCO format, allowing you to convert a Project, Dataset, or a single Annotation to COCO format. Each dataset in the project will be converted to a separate COCO dataset. The single `sly.Annotation` object will be converted to a list of COCO annotation format objects.

{% hint style="info" %}
It supports the following geometry types: `sly.Rectangle`, `sly.Bitmap`, `sly.Polygon`, `sly.GraphNodes`.

Enabling the `with_captions` parameter will include captions in the COCO annotations (if present in the project).
{% endhint %}

- Convert a project to COCO format:

```python
# One line of code
sly.convert.to_coco("./sly_project", dest_dir="./result_coco")

# Or using the sly.Project object
project_fs = sly.Project("./sly_project", sly.OpenMode.READ)
project_fs.to_coco("./result_coco")
```

- Convert a specific dataset to COCO format:

```python
ds = project_fs.datasets.get("dataset_name")

sly.convert.to_coco(ds, meta=project_fs.meta, dest_dir="./result_coco")
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
