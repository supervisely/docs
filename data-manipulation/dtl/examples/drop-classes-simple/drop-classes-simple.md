# Simple case

### Task description

For example you have a dataset where each object instance is segmented as masks. So each pixel is assigned to only one object instance. This case is applicable for such public datasets like Pascal VOC or Mapillary.

Here is an example of an image:

Opacity - 50%:

![](<01 (1).jpg>)

Opacity - 100%:

![](02.jpg)

Let's hide the "Person" object. As you can see the "Car" object is the instance consists of a few not connected areas.

![](<03 (1).jpg>)

For example, you have a dataset with lots of classes. And you want to drop all objects except cars (i.e. to train cars segmentation model).

There are few ways of how we can drop classes inside Supervisely DTL. The result will be the same but both ways are useful.

### Way 1. Drop unnecessary classes in "data" layer.

Go to "DTL" and execute this DTL query:

```json
[
  {
    "dst": "$sample",
    "src": [
      "my_project_masks/*"
    ],
    "action": "data",
    "settings": {
      "classes_mapping": {
        "car_bm": "__default__",
        "__other__": "__ignore__"
      }
    }
  },
  {
    "dst": "my_project_masks_only_car",
    "src": [
      "$sample"
    ],
    "action": "supervisely",
    "settings": {}
  }
]
```

This query is pretty simple. The first "data" layer (`"action": "data"`) defines the project we will transform. Also it defines `classes_mapping`, where `car_bm` class will be kept and other classes will be dropped. The second layer (`"action": "supervisely"`) just defines the name for the resulting project - `my_project_masks_only_car`.

### Way 2. Drop unnecessary classes in "drop\_obj\_by\_class" layer.

Go to "DTL" and execute this DTL query:

```json
[
  {
    "dst": "$sample",
    "src": [
      "my_project_masks/*"
    ],
    "action": "data",
    "settings": {
      "classes_mapping": "default"
    }
  },
  {
    "action": "drop_obj_by_class",
    "src": ["$sample" ],
    "dst": "$sample1",
    "settings": {
      "classes": ["person_bm"]
    }
  },
  {
    "dst": "my_project_masks_only_car_02",
    "src": [
      "$sample1"
    ],
    "action": "supervisely",
    "settings": {}
  }
]
```

The difference is that we didn't drop the objects in the "data" layer. We added the "drop\_obj\_by\_class" layer defining the list of classes we want to drop. This is useful when we want to use some objects in computational graph (i.e. to make some 'tricky' crops and flips based on those objects) but want to drop unnecessary objects at the end of transformation before saving the results.
