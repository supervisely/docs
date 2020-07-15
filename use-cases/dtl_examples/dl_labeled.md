This example shows how to split and download only the labeled data from the project. 

```json
[
  {
    "dst": "$sample",
    "src": [
      "tutorial_project/*"
    ],
    "action": "data",
    "settings": {
      "classes_mapping": "default"
    }
  },
  {
    "dst": [
      "$data_1",
      "$data_2"
    ],
    "src": [
      "$sample"
    ],
    "action": "if",
    "settings": {
      "condition": {
        "min_objects_count": 1
      }
    }
  },
  {
    "dst": "tutorial_project",
    "src": [
      "$data_1"
    ],
    "action": "save",
    "settings": {}
  }
]
```

Computational graph:

![](../../assets/legacy/all_images/if_001.png)

To filter the data we are using the [If]() filter with the parameter 'objects count'. Data can be filtered further by using additional DTL layers.
