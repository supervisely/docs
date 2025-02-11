The Pascal VOC (Visual Object Classes) format stands as one of the benchmarks established relatively early for object classification, segmentation and detection. It furnishes a standardized dataset for identifying object classes, utilizing an XML-based export format that enjoys widespread adoption in computer vision tasks.

For more information on how to import Pascal VOC format data into Supervisely, see the [Import from PascalVOC](../../import/import/supported-formats-images/pascal.md) guide.

## Converting data using Supervisely Ecosystem Apps

- [Export to Pascal VOC](https://ecosystem.supervisely.com/apps/export-to-pascal-voc). Converts Supervisely format project to Pascal VOC and prepares downloadable `.tar` archive.

## Converting data using Supervisely Python SDK

Easily convert your data in one line of code using the Supervisely Python SDK.

{% hint style="info" %}
`sly.convert.to_pascal_voc()` function automatically detects the input data type and converts it to Pascal VOC format. For example, you can pass a path to a project, sly.Project object or sly.Dataset object. To convert a Dataset, you need to provide the project meta information as shown in the example below.

```python
# Project path
sly.convert.to_pascal_voc("./sly_project", dest_dir="./pascal_voc")
# Project object
sly.convert.to_pascal_voc(project, dest_dir="./pascal_voc")
# or Dataset object
sly.convert.to_pascal_voc(dataset, dest_dir="./pascal_voc", meta=project.meta)
```

{% endhint %}

This converter allows you to convert a Project or Dataset. Each dataset in the project will be converted to a separate Pascal VOC dataset.

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

sly.convert.to_pascal_voc(ds, dest_dir="./result_pascal", meta=project_fs.meta)
# Or using the sly.Dataset object
ds.to_pascal_voc(project_fs.meta, dest_dir="./result_pascal")
```
