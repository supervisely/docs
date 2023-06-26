# If

"if" layer (`if`) is used to split input data to several flows with a specified criterion. Lets consider all possible use cases.

### Use case: split with probability

```json
{
  "action": "if",
  "src": ["$data_input" ],
  "dst": [
    "$data_1",
    "$data_2"
  ],
  "settings": {
    "condition": {
      "probability": 0.95
    }
  }
}
```

In this case input data (image + annotation) will go to the "left" branch (`$data_1` varibable) with probability 95%, to the "right" branch (`$data_2` varibable) with probability 5%.

It can be used in several scenarios.

#### Split data to train and val subsets

First scenario is when we are going to split data into train and validation sets by adding corresponding tag to each image.

```json
[
  {
    "action": "data",
    "src": ["my_proj/*"],
    "dst": "$data",
    "settings": {
      "classes_mapping": "default"
    }
  },
  {
    "action": "if",
    "src": ["$data"],
    "dst": [
      "$totrain",
      "$toval"
    ],
    "settings": {
      "condition": {
        "probability": 0.95
      }
    }
  },
  {
    "action": "tag",
    "src": ["$totrain"],
    "dst": "$train",
    "settings": {
      "tag": "train",
      "action": "add"
    }
  },
  {
    "action": "tag",
    "src": ["$toval"],
    "dst": "$val",
    "settings": {
      "tag": "val",
      "action": "add"
    }
  },
  {
    "action": "supervisely",
    "src": [
      "$train",
      "$val"
    ],
    "dst": "proj_with_tags",
    "settings": {}
  }
]
```

Computational graph:

![](<../../assets/legacy/all\_images/if\_001 (1).png>)

#### Get sample from data

Second scenario is when we are going to get small data sample:

```json
[
  {
    "action": "data",
    "src": ["my_proj/*"],
    "dst": "$data",
    "settings": {
      "classes_mapping": "default"
    }
  },
  {
    "action": "if",
    "src": ["$data"],
    "dst": [
      "$data_sample",
      "$data_ignore"
    ],
    "settings": {
      "condition": {
        "probability": 0.01
      }
    }
  },
  {
    "action": "supervisely",
    "src": ["$data_sample"],
    "dst": "proj_sample",
    "settings": {}
  }
]
```

Computational graph:

![](../../assets/legacy/all\_images/if\_002.png)

We just get 1 persent of data and put it to project `proj_sample`. Other data will be skipped.

### Use case: split data by objects count

This case allows us to split data by objects count (`min_objects_count` value). In the example below, images with equal or more that three objects will be passed to `$data_1` branch, other images — to the `$data_2` branch

```json
{
  "action": "if",
  "src": ["$data_input" ],
  "dst": [
    "$data_1",
    "$data_2"
  ],
  "settings": {
    "condition": {
      "min_objects_count": 3
    }
  }
}
```

Example of full config:

```json
[
  {
    "action": "data",
    "src": ["my_proj/*"],
    "dst": "$data",
    "settings": {
      "classes_mapping": "default"
    }
  },
  {
    "action": "if",
    "src": ["$data" ],
    "dst": [
      "$data_1",
      "$data_2"
    ],
    "settings": {
      "condition": {
        "min_objects_count": 3
      }
    }
  },
  {
    "action": "supervisely",
    "src": ["$data_1"],
    "dst": "proj_filter",
    "settings": {}
  }
]
```

Computational graph:

![](../../assets/legacy/all\_images/if\_004.png)

In this example we put images with `"min_objects_count": 3` to `proj_filter`. Other images are ignored.

### Use case: split by image height or width

For example, we are going to filter images by minimum image height (200 pixels):

```json
{
  "action": "if",
  "src": ["$data_input" ],
  "dst": [
    "$data_1",
    "$data_2"
  ],
  "settings": {
    "condition": {
      "min_height": 200
    }
  }
}
```

The same can be applied to minimum width:

```json
{
  "action": "if",
  "src": ["$data_input" ],
  "dst": [
    "$data_1",
    "$data_2"
  ],
  "settings": {
    "condition": {
      "min_width": 200
    }
  }
}
```

This case is useful when we are going to skip some small images after applying "instance crop" layer.

### Use case: split by tags

This example passes images with tag "party" or "dinner" to the `$data_1` branch, other images are passed to `$data_2` branch.

```json
{
  "action": "if",
  "src": ["$data_input" ],
  "dst": [
    "$data_1",
    "$data_2"
  ],
  "settings": {
    "condition": {
      "tags": ["party", "dinner"]
    }
  }
}
```

### Use case: split by class presence

In this example images which contain any object of some required class (`person` or `dog`) are passed to the `$data_1` branch.

```json
{
  "action": "if",
  "src": ["$data_input" ],
  "dst": [
    "$data_1",
    "$data_2"
  ],
  "settings": {
    "condition": {
      "include_classes": ["person", "dog"]
    }
  }
}
```

### Use case: split by images names in range, and step

Names is ordered alphabetical (a, b ,c ...).

```json
{
  "action": "if",
  "src": ["$data_input" ],
  "dst": [
    "$data_1",
    "$data_2"
  ],
  "settings": {
   "condition": {
        "name_in_range": ["a0100", "a0105"],
        "frame_step": 2
   }
  }
}
```

Should pass images with names \["00100", "00102", "00104"] into first branch (`$data1`) and else into (`$data2`) branch.
