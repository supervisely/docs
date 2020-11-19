# Use case: upload project in Supervisely format

For this case the structure of directory should be the following:

```
my_project
├── meta.json
├── dataset_name_01
│   ├── ann
│   │   ├── img_x.jpeg.json
│   │   ├── img_y.jpeg.json
│   │   └── img_z.jpeg.json
│   └── img
│       ├── img_x.jpeg
│       ├── img_y.jpeg
│       └── img_z.jpeg
├── dataset_name_02
│   ├── ann
│   │   ├── img_x.jpeg.json
│   │   ├── img_y.jpeg.json
│   │   └── img_z.jpeg.json
│   └── img
│       ├── img_x.jpeg
│       ├── img_y.jpeg
│       └── img_z.jpeg
```

Directory "my_project" contains two folders and file `meta.json`. For each folder a corresponding dataset will be created inside the project. As you can see, images are separated from annotations.

{% hint style="info" %}
Let's consider the example above. To upload that project user has to select `meta.json` file and two directories (`dataset_name_01` and `dataset_name_02`) and drag-and-drop these three elements.
{% endhint %}

{% hint style="info" %}
We recomemnd to split images logically into several datasets inside one project.
{% endhint %}

# Read more about Supervisely format

The full specification for the format can be found [here]((../../data-organization/Annotation-JSON-format/00_ann_format_navi.md).
