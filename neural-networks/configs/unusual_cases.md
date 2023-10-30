# NOT RELEVANT. DEPRECATED. DELETE?
## PSPNet

### Training config
```json
{
  "input_size": {
    "width": 713,
    "height": 713
  },
  "batch_size": {
    "train": 2,
    "val": 1
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
  "epochs": 7,
  "val_every": 0.5,
  "lr": 0.0001,
  "weight_decay": 0.0001,
  "momentum": 0.9,
  "train_beta_gamma": true,
  "update_mean_var": true,
  "gpu_devices": [0],
  "weights_init_type": "transfer_learning"
}
```

Most of training parameters are the same as [general training config](train_config.md). But there are few differences:

`input_size` - 713x713 is a hardcoded parameter and can not be changed not. Work in progress.

`weight_decay`, `momentum`,`train_beta_gamma`,`update_mean_var` - additional training hyperparameters.


## Mask-RCNN

### Training config

Basic config:
```json
{
  "input_size": {
    "width": 512,
    "height": 512
  },
  "batch_size": {
    "train": 8,
    "val": 1
  },
  "dataset_tags": {
  	"train": "train",
    "val": "val"
  },
  "special_classes": {
    "background": "bg",
    "neutral": "neutral"
  },
  "epochs": 3,
  "val_every": 0.5,
  "lr": 0.001,
  "gpu_devices": [0],
  "weights_init_type": "transfer_learning"
}
```

The difference is that field `data_workers` have to be removed. 



