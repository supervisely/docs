# Splitting data

Splitting data into training, validation, and testing sets is a common practice in machine learning projects. It helps to evaluate the performance of the model on unseen data and prevent overfitting. In this guide, we'll explore different methods to split data using the Supervisely Ecosystem Apps and the Supervisely Python SDK.

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
