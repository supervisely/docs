
<!---
## General information
**Tags**: Image segmentation

[Original paper](https://arxiv.org/abs/1505.04597)


## Description
We slightly customized original architecture. It is fast to train and easy to modificate. It allows multi-gpu training. 


## Implementation
**Train docker image**: [docker.deepsystems.io/supervisely/nn/unet_v2:v1.00_train]()

**Inference docker image**: [docker.deepsystems.io/supervisely/nn/unet_v2:v1.00_inf]()

**Supervisely sources**: [link to github]()


### How to run localy
<span style="color:red">TODO

### How to run with Supervisely Agent
<span style="color:red">TODO
-->

Basic config:
```json
{
  "input_size": {
    "width": 256,
    "height": 256
  },
  "batch_size": {
    "train": 12,
    "val": 6
  },
  "dataset_tags": {
  	"train": "train",
    "val": "val"
  },
  "data_workers": {
    "train": 3,
    "val": 0
  },
  "special_classes": {
    "background": "bg",
    "neutral": "neutral"
  },
  "epochs": 3,
  "val_every": 0.5,
  "lr": 0.0001,
  "gpu_devices": [0],
  "weights_init_type": "transfer_learning"
}
```

`input_size` - input image resolution. If the image size differs from the defined value, it will be resized automatically.

`batch_size` - batch size per single GPU, e.g. if you train NN with 4 GPUs the number of processed images on each iteration equals to `4 * batch_size`       

`dataset_tags` - tags that are used to split input data to train and validation datasets. Default tag for training set is `train`, default tag for validation set is `val`. If you are going to use your custom tags, you shoud define this field otherwise training process will be crash with error. Here is an example of how you can use custom tags for splitting:

```json
...
"dataset_tags": {
	"train": "my_tag_for_train",
	"val": "my_tag_for_val"
},
...
```

`data_workers` - defines the number of threads for batch preparation 

`special_classes` - objects with specified classes will be interpreted in a specific way. The default class name for `background` is `bg`, the default class name for `neutral` is `neutral`. All pixels from `neutral` objects will be ignored in the loss function. Here is an example of how you can use custom tags for `special_classes`:

```json
...
"special_classes": {
	"background": "my_backgroud_name",
	"neutral": "my_neutral_class"
},
...
```

`epochs` - number of training epochs, i.e. how many times NN will look at each image from the training dataset.

`val_every` - defines how frequently validation will be performed. `0.5` means that model wil be validated 2 times per epoch.

`lr` - learning rate

`gpu_devices` - list of GPU devices used in training, e.g. for 4 GPU training you should set `"gpu_devices": [0, 1, 2, 3]` 

`weights_init_type` - how NN weights will be inited. In `"transfer_learning"` mode all possible weights will be transfered except the last layer. In `"continue_training"` mode all weights will be transfered and validation for classes number and classes names order will be performed. 