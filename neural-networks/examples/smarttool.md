## Introduction

One of the best properties of Smart tool is that it can be tuned to your particular tasks.

If

 * you need an easier annotation of concrete classes
 * you work with objects of unusual shape or appearance
 * you just want to make Smart tool even smarter

  
You can achieve it by training Smart tool.


The tool is a [neural network model](../overview/overview.md) and in Supervisely it may be trained like all the other models. This tutorial will show you how to train Smart tool to obtain a simple class-agnostic model which is smart enough.

## Data preparation

### Datasets

To get a class-agnostic model it's needed to be trained with a large amount of objects and parts of objects from different classes. We will use the following datasets as a source:

* [Pascal VOC](http://host.robots.ox.ac.uk/pascal/VOC/)
* [Mapillary](https://www.mapillary.com/dataset/vistas)

{% hint style="info" %}
To achieve even more class ignorance one may include other datasets with different classes or even generate some artifical datasets.
{% endhint %}

### Training samples

Our goal is to construct training samples with the following figures:

 * Target object or area to recognize:
    * We'll name it as `obj` class and represent it as a `bitmap`
    * Each training sample must contain one target object
 * Positive and negative points, which are imitating human feedback during annotation:
    * `pos` and `neg` classes correspondingly, with `point` type

<span style="color:red">TODO: add screenshot of some sample with obj, pos & neg

We want the model to "understand" different objects, edges and shapes. It shoul perform reasonable segmentation of a dominant object on the input image. However, the model must be obedient and correct the segmentation based on user feedback, i.e. positive and negative zones.

### Pascal VOC

To [generate training samples](../../data-manipulation/dtl/index.md) from Pascal VOC use the config below.

The following actions will be performed:

1. Crop each source object (excluding the tiny ones) with large padding. Note that the object may be placed not in the center of the result image due to image borders.
2. Mark samples randomly with `train` and `val` tags.
4. Get some number of random crops from each obtained sample (maybe flipped). This is performed because we don't really want to get many samples with clearly distinguishable dominating object. Instead of this we generate "hard" samples on which target objects are shifted randomly and are placed side-by-side with other objects.
5. Exclude samples where target objects are small or missing. Resize images to the required size (model input size)
6. Generate positive and negative points randomly for each sample. Positive points will be placed on target `obj`, and negative ones on the rest of sample image.

```json
[
  {
    "src": [
      "PascalVOC/*"
    ],
    "dst": "$sample-pascal",
    "action": "data",
    "settings": {
      "classes_mapping": {
        "neutral": "unused",
        "__other__": "obj"
      }
    }
  },
  {
    "src": [
      "$sample-pascal"
    ],
    "dst": "$100",
    "action": "objects_filter",
    "settings": {
      "filter_by": {
        "polygon_sizes": {
          "filtering_classes": [
            "obj"
          ],
          "comparator": "less",
          "area_size": {
            "percent": 1
          },
          "action": "delete"
        }
      }
    }
  },
  {
    "src": [
      "$100"
    ],
    "dst": "$101",
    "action": "instances_crop",
    "settings": {
      "classes": [
        "obj"
      ],
      "pad": {
        "sides": {
          "left": "200%",
          "right": "200%",
          "top": "200%",
          "bottom": "200%"
        }
      }
    }
  },
  {
    "src": [
      "$101"
    ],
    "dst": [
      "$102-val",
      "$102-train"
    ],
    "action": "if",
    "settings": {
      "condition": {
        "probability": 0.05
      }
    }
  },
  {
    "src": [
      "$102-val"
    ],
    "dst": "$103-val",
    "action": "tag",
    "settings": {
      "tag": "val",
      "action": "add"
    }
  },
  {
    "src": [
      "$102-train"
    ],
    "dst": "$103-train",
    "action": "tag",
    "settings": {
      "tag": "train",
      "action": "add"
    }
  },
  {
    "src": [
      "$103-val",
      "$103-train"
    ],
    "dst": "$104",
    "action": "flip",
    "settings": {
      "axis": "vertical"
    }
  },
  {
    "src": [
      "$103-val",
      "$103-train",
      "$104"
    ],
    "dst": "$105",
    "action": "multiply",
    "settings": {
      "multiply": 3
    }
  },
  {
    "src": [
      "$105"
    ],
    "dst": "$106",
    "action": "crop",
    "settings": {
      "random_part": {
        "height": {
          "min_percent": 15,
          "max_percent": 95
        },
        "width": {
          "min_percent": 15,
          "max_percent": 95
        }
      }
    }
  },
  {
    "src": [
      "$106"
    ],
    "dst": [
      "$107",
      "$107-unused"
    ],
    "action": "if",
    "settings": {
      "condition": {
        "min_height": 50
      }
    }
  },
  {
    "src": [
      "$107"
    ],
    "dst": [
      "$108",
      "$108-unused"
    ],
    "action": "if",
    "settings": {
      "condition": {
        "min_width": 50
      }
    }
  },
  {
    "src": [
      "$108"
    ],
    "dst": "$109",
    "action": "resize",
    "settings": {
      "width": 256,
      "height": 256,
      "aspect_ratio": {
        "keep": false
      }
    }
  },
  {
    "src": [
      "$109"
    ],
    "dst": "$110",
    "action": "objects_filter",
    "settings": {
      "filter_by": {
        "polygon_sizes": {
          "filtering_classes": [
            "obj"
          ],
          "comparator": "less",
          "area_size": {
            "percent": 15
          },
          "action": "delete"
        }
      }
    }
  },
  {
    "src": [
      "$110"
    ],
    "dst": [
      "$111",
      "$111-unused"
    ],
    "action": "if",
    "settings": {
      "condition": {
        "min_objects_count": 1
      }
    }
  },
  {
    "src": [
      "$111"
    ],
    "dst": "$112",
    "action": "generate_hints",
    "settings": {
      "class": "obj",
      "positive_class": "pos",
      "negative_class": "neg",
      "min_points_number": 1
    }
  },
  {
    "src": [
      "$112"
    ],
    "dst": "smtool_dataset",
    "action": "supervisely",
    "settings": {}
  }
]
```

### Mapillary

To generate training samples from Mapillary use the config below.

The data transformation acts like one for Pascal VOC with two distinctions:

1. Not all source classes are used. Some classes in Mapillary (e.g. `Terrain`) represent "image-level" segmentation figures, and other may be too complicated for our training. The mapping is defined in [Data layer](../../data-manipulation/dtl/data.md).
2. Heavy class imbalance should be eliminated, otherwise the model will be trained mostly on images of cars and traffic signs. Separate "branch" in DTL config is needed to crop frequent objects and to drop the most part of them at random.


```json
[
  {
    "src": [
      "Mapillary/*"
    ],
    "dst": "$sample-mapill",
    "action": "data",
    "settings": {
      "classes_mapping": {
        "Trailer": "obj",
        "Guard Rail": "obj",
        "Bench": "obj",
        "Trash Can": "obj",
        "Fire Hydrant": "obj",
        "Junction Box": "obj",
        "On Rails": "obj",
        "Bike Rack": "obj",
        "Ground Animal": "obj",
        "Phone Booth": "obj",
        "Bus": "obj",
        "Bicyclist": "obj",
        "Mailbox": "obj",
        "Manhole": "obj",
        "Traffic Sign (Back)": "obj_Freq",
        "Banner": "obj",
        "Other Vehicle": "obj",
        "Other Rider": "obj",
        "Motorcyclist": "obj",
        "Street Light": "obj",
        "Catch Basin": "obj",
        "Motorcycle": "obj",
        "Person": "obj",
        "Traffic Sign (Front)": "obj_Freq",
        "Car": "obj_Freq",
        "Caravan": "obj",
        "Billboard": "obj_Freq",
        "Truck": "obj",
        "Boat": "obj",
        "Wheeled Slow": "obj",
        "__other__": "unused"
      }
    }
  },
  {
    "src": [
      "$sample-mapill"
    ],
    "dst": "$100",
    "action": "objects_filter",
    "settings": {
      "filter_by": {
        "polygon_sizes": {
          "filtering_classes": [
            "obj",
            "obj_Car"
          ],
          "comparator": "less",
          "area_size": {
            "percent": 0.1
          },
          "action": "delete"
        }
      }
    }
  },
  {
    "src": [
      "$100"
    ],
    "dst": "$101-obj",
    "action": "instances_crop",
    "settings": {
      "classes": [
        "obj"
      ],
      "pad": {
        "sides": {
          "left": "200%",
          "right": "200%",
          "top": "200%",
          "bottom": "200%"
        }
      }
    }
  },
  {
    "src": [
      "$100"
    ],
    "dst": "$101-obj_Freq",
    "action": "instances_crop",
    "settings": {
      "classes": [
        "obj_Freq"
      ],
      "pad": {
        "sides": {
          "left": "200%",
          "right": "200%",
          "top": "200%",
          "bottom": "200%"
        }
      }
    }
  },
  {
    "src": [
      "$101-obj_Freq"
    ],
    "dst": [
      "$101-obj_Freq-selected",
      "$102-obj_Freq-unused"
    ],
    "action": "if",
    "settings": {
      "condition": {
        "probability": 0.1
      }
    }
  },
  {
    "src": [
      "$101-obj_Freq-selected"
    ],
    "dst": "$101-obj_Freq-renamed",
    "action": "rename",
    "settings": {
      "classes_mapping": {
        "obj_Freq": "obj"
      }
    }
  },
  {
    "src": [
      "$101-obj",
      "$101-obj_Freq-renamed"
    ],
    "dst": [
      "$102-val",
      "$102-train"
    ],
    "action": "if",
    "settings": {
      "condition": {
        "probability": 0.05
      }
    }
  },
  {
    "src": [
      "$102-val"
    ],
    "dst": "$103-val",
    "action": "tag",
    "settings": {
      "tag": "val",
      "action": "add"
    }
  },
  {
    "src": [
      "$102-train"
    ],
    "dst": "$103-train",
    "action": "tag",
    "settings": {
      "tag": "train",
      "action": "add"
    }
  },
  {
    "src": [
      "$103-val",
      "$103-train"
    ],
    "dst": "$104",
    "action": "flip",
    "settings": {
      "axis": "vertical"
    }
  },
  {
    "src": [
      "$103-val",
      "$103-train",
      "$104"
    ],
    "dst": "$105",
    "action": "multiply",
    "settings": {
      "multiply": 3
    }
  },
  {
    "src": [
      "$105"
    ],
    "dst": "$106",
    "action": "crop",
    "settings": {
      "random_part": {
        "height": {
          "min_percent": 15,
          "max_percent": 95
        },
        "width": {
          "min_percent": 15,
          "max_percent": 95
        }
      }
    }
  },
  {
    "src": [
      "$106"
    ],
    "dst": [
      "$107",
      "$107-unused"
    ],
    "action": "if",
    "settings": {
      "condition": {
        "min_height": 50
      }
    }
  },
  {
    "src": [
      "$107"
    ],
    "dst": [
      "$108",
      "$108-unused"
    ],
    "action": "if",
    "settings": {
      "condition": {
        "min_width": 50
      }
    }
  },
  {
    "src": [
      "$108"
    ],
    "dst": "$109",
    "action": "resize",
    "settings": {
      "width": 256,
      "height": 256,
      "aspect_ratio": {
        "keep": false
      }
    }
  },
  {
    "src": [
      "$109"
    ],
    "dst": "$110",
    "action": "objects_filter",
    "settings": {
      "filter_by": {
        "polygon_sizes": {
          "filtering_classes": [
            "obj"
          ],
          "comparator": "less",
          "area_size": {
            "percent": 15
          },
          "action": "delete"
        }
      }
    }
  },
  {
    "src": [
      "$110"
    ],
    "dst": [
      "$111",
      "$111-unused"
    ],
    "action": "if",
    "settings": {
      "condition": {
        "min_objects_count": 1
      }
    }
  },
  {
    "src": [
      "$111"
    ],
    "dst": "$112",
    "action": "generate_hints",
    "settings": {
      "class": "obj",
      "positive_class": "pos",
      "negative_class": "neg",
      "min_points_number": 1
    }
  },
  {
    "src": [
      "$112"
    ],
    "dst": "smtool_dataset",
    "action": "supervisely",
    "settings": {}
  }
]
```

## Training

### Train

With the prepared data we may train Smart tool like any other model.

Consider using a pre-trained model to continue training. One may be found in [Model Zoo](../model-zoo/model-zoo.md).

Here is an example of the training config:

```json
{
  "input_size": {
    "width": 256,
    "height": 256
  },
  "batch_size": {
    "train": 16,
    "val": 16
  },
  "data_workers": {
    "train": 3,
    "val": 0
  },
  "epochs": 30,
  "val_every": 1,
  "lr": 0.1,
  "momentum": 0.9,
  "lr_decreasing": {
      "patience": 10,
      "lr_divisor": 5
  },
  "loss_weights": {
    "main_class": 1,
    "points": 0.5
  },
  "special_classes": {
    "foreground": "obj",
    "background": "bg",
    "neutral": "neutral",
    "pos": "pos",
    "neg": "neg"
  },
  "weights_init_type": "continue_training",
  "gpu_devices": [
    0,
    1,
    2,
    3
  ]
}
```

Note that there are `special_classes` for SmartTool:

- `foreground` means name of "main" class in the input project (model performs binary segmentation, object-vs-background)
- `pos` and `neg` must be points


### Test

Inference can be run on some existing project/dataset like for any other model. Provide a project with points of corresponding "pos" and "neg" classes to look at the model reaction.

Here is an example of inference config:

```json
{
  "model": {
    "gpu_device": 0
  },
  "mode": {
    "name": "full_image",
    "model_classes": {
      "save_classes": [
        "obj"
      ],
      "add_suffix": "_smtool"
    }
  }
}
```

