# Convert data to Pascal VOC format

## Converting data using Supervisely Ecosystem Apps

- [Export to Pascal VOC](https://ecosystem.supervisely.com/apps/export-to-pascal-voc). Converts Supervisely format project to Pascal VOC and prepares downloadable `.tar` archive.

## Converting data using Supervisely Python SDK

Easily convert your data in one line of code using the Supervisely Python SDK.

{% hint style="info" %}
`sly.convert.to_pascal_voc()` function automatically detects the input data type and converts it to Pascal VOC format. For example, you can pass a path to a project, sly.Project object, sly.Dataset object, or sly.Annotation object. For each input type, you need to provide dedicated parameters (as shown in the examples below).

```python
sly.convert.to_pascal_voc("./sly_project", dest_dir="./pascal_voc")
# or
sly.convert.to_pascal_voc(project, dest_dir="./pascal_voc")
# or
sly.convert.to_pascal_voc(dataset, meta=project.meta, dest_dir="./pascal_voc")
```

{% endhint %}

This converter allows you to convert a Project, Dataset, or a single Annotation to Pascal VOC format. Each dataset in the project will be converted to a separate Pascal VOC dataset. The single `sly.Annotation` object will be converted to a tuple of Pascal VOC annotation format xml object and numpy masks (instances masks and class masks).

- Convert a project to Pascal VOC format:

```python
# One line of code
sly.convert.to_pascal_voc("./sly_project", dest_dir="./result_pascal")

# Or using the sly.Project object
project_fs = sly.Project("./sly_project", sly.OpenMode.READ)
project_fs.to_pascal_voc("./result_pascal")
```

- Convert a specific dataset to Pascal VOC format:

```python
ds = project_fs.datasets.get("dataset_name")

sly.convert.to_pascal_voc(ds, meta=project_fs.meta, dest_dir="./result_pascal")
# Or using the sly.Dataset object
ds.to_pascal_voc(project_fs.meta, dest_dir="./result_pascal")
```

- Convert a single `sly.Annotation` object to Pascal VOC format:

```python
ann = sly.Annotation.from_json(ann_json, meta)
xml, instance_masks, class_masks = ann.to_pascal_voc("image_name")
```
