
## A few ways to get instance segmentation

There are a few possible ways to get instance segmentation. First way is to use a neural network specially designed for this task (for example Mask-RCNN). Second way is to build a two steps pipeline: first apply the Faster-RCNN model to detect necessary objects and then for each object apply a segmentation model to segment it. 

Both approaches have their pros and cons. 

If you are going use the model in production (i.e. embed model to some device like car or robot) the first approach it a good choice. It will allow you to get a better speed (frames per second) but it will produce low quality masks (especially near the object edges). 

Here is an example:
![](01.png)

It you have no special requrements for inference time and it is necessary to obtain high quality segmentation masks, the second option is better. A possible use case is when you are going to build a big training dataset and you would like to use neural networks for image pre-segmentation and then manually correct predictions. This approach is significantly faster than manual annotation from scratch. It is also called the Human-In-The-Loop approach. This [tutorial](https://hackernoon.com/releasing-supervisely-person-dataset-for-teaching-machines-to-segment-humans-1f1fc1f28469) shows how we at Supervisely can annotate 5711 images with a small annotation team (only two annotators) in 4 days.

Supervisely supports both approaches. This tutorial shows how to apply a ready to use Mask-RCNN model (from Model Zoo) to your images for instance segmentation.


## Step 1 (optional). Add NN from the Models list. 

If you have already added Mask-RCNN model to your account from the Models list, you can skip this step. 

To add a new architecture with pretrained weights to your account you should go to `Explore` -> `Models`. Find Mask-RCNN, click `Add` and then `Clone`.

![](../../../assets/legacy/nn/mask_rcnn/add_mask.png)

This pre-trained Mask-RCNN model will appear in your account. 

## Step 2 (optional). Upload images.

If you have no any images to test, you should upload them before use NN. Here is the [tutorial](../../../data-organization/import-export.md) on how to upload images to Supervisely.


## Step 3. Apply NN to your images.

Go to "Neural Networks" and press the "Test" button opposite to the model you want to apply to your images. 

![](../../../assets/legacy/nn/mask_rcnn/mask_train.png)

Choose the project that will be used in inference and set inference settings.

![](../../../assets/legacy/nn/mask_rcnn/mask_test_config.png)

The most interesting part here is inference configuration: 

```json
{
  "gpu_devices": [
    0
  ],
  "model_classes": {
    "save_classes": ["car"],
    "add_suffix": "_mrcnn"
  },
  "existing_objects": {
    "save_classes": [],
    "add_suffix": ""
  },
  "mode": {
    "source": "full_image"
  }
}
```

Let's consider the most interesting fields. You will find the entire explanation[here](../../configs/inference_config.md) 

`"source": "full_image"` means that the entire image will be feeded to neural network.

`"gpu_devices": [0]` - defines device_id of GPU we will use for computations. 

`"save_classes": ["car"]` - our NN produces a lof of classes. You can see it in "(4) - Model information". For example, we want to keep objects of class "car" and ignore objects of other classes. If we want to keep all object, just change this field to `"save_classes": "__all__"`


So, If you define all settings, just press "Start inference" button. 

## Step 4. Wait until the task is finished. 

You will be automatically redirected to the "Tasks" list.

You can monitor task logs while waiting.  

![](../../../assets/legacy/nn/mask_rcnn/mask_log.png) 

When the task is finished, you will see resulting project in "Projects" page. Here is the few examples of predictions:

![](09.jpg) 

![](10.jpg)  


