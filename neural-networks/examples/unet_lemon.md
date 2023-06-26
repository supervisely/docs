# UNet (Lemon)

### Multi-class image segmentation using UNet V2

In this example, we will consider a semantic segmentation task. To solve this problem we will train a modification of [UNet](https://arxiv.org/abs/1505.04597) - fast, accurate and easy to train segmentation model.

### Add the "lemons" dataset

Signup into to your account and go to `Explore -> Projects`. Here you will find a bunch of ready-to-use datasets.

Click on "lemons\_annotated" and pick a name for your new project. For this tutorial we will use name "lemon". Click "Add to My Projects", choose the name and click "Clone". A new project will appear on your dashboard.

### Data preparation

To train UNet we will use a tiny dataset, containing only 6 images with only one class.

This dataset has few interesting properties:

1. It is small (only 6 annotated images)
2. The classes (background and vessel) are imbalanced in terms of area.
3. Background objects have similarities with target classes

![](../../assets/legacy/nn/unet\_lemon/01.jpg)

Using only 6 images for training is a direct road to overfitting. To train such deep NN we have to prepare a training dataset: perform various data augmentations. Supervisely has Data Transformation Language [(DTL)](../../data-manipulation/dtl/index.md) specially designed for that purpose. Full DTL config:

```json
[
  {
    "dst": "$sample",
    "src": [
      "lemon/*"
    ],
    "action": "data",
    "settings": {
      "classes_mapping": "default"
    }
  },
  {
    "dst": "$fv",
    "src": [
      "$sample"
    ],
    "action": "flip",
    "settings": {
      "axis": "vertical"
    }
  },
  {
    "dst": "$fh",
    "src": [
      "$fv",
      "$sample"
    ],
    "action": "flip",
    "settings": {
      "axis": "horizontal"
    }
  },
  {
    "dst": "$data",
    "src": [
      "$fv",
      "$sample",
      "$fh"
    ],
    "action": "dummy",
    "settings": {}
  },
  {
    "dst": "$data2",
    "src": [
      "$data"
    ],
    "action": "multiply",
    "settings": {
      "multiply": 10
    }
  },
  {
    "dst": "$data3",
    "src": [
      "$data2"
    ],
    "action": "crop",
    "settings": {
      "random_part": {
        "width": {
          "max_percent": 90,
          "min_percent": 70
        },
        "height": {
          "max_percent": 90,
          "min_percent": 70
        },
        "keep_aspect_ratio": false
      }
    }
  },
  {
    "dst": [
      "$totrain",
      "$toval"
    ],
    "src": [
      "$data3",
      "$data"
    ],
    "action": "if",
    "settings": {
      "condition": {
        "probability": 0.95
      }
    }
  },
  {
    "dst": "$train",
    "src": [
      "$totrain"
    ],
    "action": "tag",
    "settings": {
      "tag": "train",
      "action": "add"
    }
  },
  {
    "dst": "$val",
    "src": [
      "$toval"
    ],
    "action": "tag",
    "settings": {
      "tag": "val",
      "action": "add"
    }
  },
  {
    "dst": "$data_with_bg",
    "src": [
      "$train",
      "$val"
    ],
    "action": "background",
    "settings": {
      "class": "bg"
    }
  },
  {
    "dst": "lemon_train",
    "src": [
      "$data_with_bg"
    ],
    "action": "supervisely",
    "settings": {}
  }
]
```

After you open the DTL page and copy this config to the text window, your computational graph should look like this:

![](../../assets/legacy/nn/unet\_lemon/00.png)

So, what's going on here?

1. First, we take the entire project `lemon` (all 6 images with annotations). `"classes_mapping": "default"` means that we will keep original classes as is.
2. Next, we generate vertical flips, then make horizontal flips from both original images and those that were flipped vertically.
3. Then we merge original and flipped images and generate random crops from them.
4. After that we take all images and randomly split all images into two groups: first group will contain 95% percent of images, second group will contain the rest.
5. Tag `train` will be assigned to all images from the first group. Tag `val` will be assigned to the images from the second group. These tags define training and validation sets that will be used on the training stage.
6. Save everything back into Supervisely as a new project

Push "Start" button and at the end we should get a new project `lemon_train`.

Here is the example of an image from `lemon_train`.

![](../../assets/legacy/nn/unet\_lemon/02.jpg)

### Add NN architecture and pretrained weights

If you already have this NN in your account, you can skip this step.

To add anew architecture with pretrained weights to your account you should go to `Exprore` -> `Models`. Find UNet V2 plate, point to it and click `Add model` button. You can use the search function for ease.

![](../../assets/legacy/nn/unet\_vessels/unet\_explore.png)

After that UNetV2 architecture will be added to your account. Also UNetV2 model (VGG weights) will be added to the list of your models. This means that now you can train the NN with your custom data and use pretrained weights for transfer learning.

### Network training

1. Go to `Neural Networks`. Find your model and push the `Train` button. ![](../../assets/legacy/nn/unet\_vessels/unet\_train.png)
2. Now we should select project we will use for training. Select `vessels_train` project and click `Next` button. ![](../../assets/legacy/nn/unet\_vessels/unet\_settings.png)
3. Before starting the training we have to define name of resulting NN, choose one of the node from cluster, and define some training configuration.

Model name: `unet_lemon_01`

Training configuration:

```json
{
  "lr": 0.001,
  "epochs": 15,
  "val_every": 0.5,
  "batch_size": {
    "val": 6,
    "train": 12
  },
  "input_size": {
    "width": 256,
    "height": 256
  },
  "gpu_devices": [
    0,
    1,
    2,
    3
  ],
  "data_workers": {
    "val": 0,
    "train": 3
  },
  "dataset_tags": {
    "val": "val",
    "train": "train"
  },
  "special_classes": {
    "neutral": "neutral",
    "background": "bg"
  },
  "weights_init_type": "transfer_learning"
}
```

Training configuration defines input resolution, batch size, learning rate, list of gpu\_devices used for training and other parameters.

4 . Press the `Run` button.

5 . You will be redirected to the `Tasks` page. Here you can view logs and training charts.

### Test the model

After training is completed you can apply your model to test images.

1. Go to `Neural networks`. Find the model and press the `Test` button in front of it. ![](<../../assets/legacy/nn/unet\_vessels/unet\_test (1).png>)
2. Choose your test project(`lemon_test`) and press `Next` button.

![](../../assets/legacy/nn/unet\_vessels/unet\_test\_set.png)

3. Define the output project name and inference configuration:

Output project name: `inf_01`

```json
{
  "model": {
    "gpu_device": 0
  },
  "mode": {
    "name": "full_image",
    "model_classes": {
      "save_classes": "__all__",
      "add_suffix": "_unet"
    }
  }
}
```

Inference configuration defines the way image will be feeded to the neural network. Supervisely supports a few [inference types](../configs/inference\_config.md) ( image, objects, roi, sliding window). "Full image" inference mode is used in this example.

After inference is completed you find the result project on the "Projects" page.

Here is the examaple of NN predictions: ![](../../assets/legacy/nn/unet\_lemon/10.jpg)
