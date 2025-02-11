The [COCO](https://cocodataset.org/#home) format is widely used in the computer vision community and is supported by many popular frameworks and libraries. COCO format is a complex format that can contain multiple types of annotations. Supervisely supports conversions for instances, keypoints, and captions.

For more information on how to import COCO format data into Supervisely, see the [Import from COCO](../../import/import/supported-formats-images/coco.md) guide.

## Converting data using Supervisely Ecosystem Apps

- [Export to COCO](https://ecosystem.supervisely.com/apps/export-to-coco). Convert project to COCO format. It is a simple and efficient way to export your project to COCO format.
- [Export COCO Keypoints](https://ecosystem.supervisely.com/apps/export-coco-keypoints). App converts Supervisely format project to COCO Keypoints format as a downloadable `.tar` archive.

## Converting data using Supervisely Python SDK

Our Python SDK provides a simple way to convert your data to COCO format, allowing you to convert a Project or Dataset to COCO format. Easily convert your data in one line of code using the Supervisely Python SDK.

{% hint style="success" %}

`sly.convert.to_coco()` function automatically detects the input data type and converts it to Pascal VOC format. For example, you can pass a path to a project, sly.Project object or sly.Dataset object. To convert a Dataset, you need to provide the project meta information as shown in the example below.

```python
# Project path
sly.convert.to_coco("./sly_project", dest_dir="./result_coco")
# Project object
sly.convert.to_coco(project, dest_dir="./result_coco")
# or Dataset object
sly.convert.to_coco(dataset, dest_dir="./result_coco", meta=project.meta)
```

{% endhint %}

Each dataset in the project will be converted to a separate COCO dataset.

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

sly.convert.to_coco(ds, dest_dir="./result_coco", meta=project_fs.meta)
# Or using the sly.Dataset object
ds.to_coco(project_fs.meta, dest_dir="./result_coco")
```
