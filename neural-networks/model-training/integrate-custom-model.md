
# Custom Model Integration Tutorial 🚀

Welcome to this step-by-step guide on integrating your custom model with the Supervisely SDK! In this tutorial, you'll learn how to use the powerful TrainApp class to train your model effortlessly while taking advantage of Supervisely’s robust infrastructure. We’ll use the [Train RT-DETRv2](https://ecosystem.supervisely.com/apps/rt-detrv2/supervisely_integration/train) implementation as an example throughout this guide.

## Overview

This guide will walk you through the process of:

- Setting up your models configuration 📄
- Preparing hyperparameters in YAML format 🔧
- (Optionally) Configuring app options for enhanced behavior ⚙️
- Integrating your custom model using the Supervisely SDK

### The TrainApp Class

The Supervisely SDK provides a dedicated class called `TrainApp` to help you train your custom model using Supervisely’s infrastructure. This class offers a built-in GUI and manages many essential tasks automatically.

**Key Features of TrainApps**

- Built-in GUI: Simple and easy to follow customizable interface
- Train and Val Splits: Automatically split your dataset into training and validation sets
- Data Preparation: Seamless conversion of Supervisely projects to the required format
- Data Backup: Automatic backup of your dataset with Supervisely’s versioning system
- Model Evaluation: On-demand evaluation (requires a model [serving implementation](link-to-tutorial))
- Model Saving: Automatically save your model and related files to Supervisely storage

#### TrainApp Signature

```python
class TrainApp(
    framework_name: str,
    models: Union[str, List[Dict[str, Any]]],
    hyperparameters: str,
    app_options: Union[str, Dict[str, Any]] = None,
    work_dir: str = None,
)
```

|   Parameters    |                        Type                        |                             Description                             |
|:---------------:|:--------------------------------------------------:|:-------------------------------------------------------------------:|
| framework_name  |                        str                         |             Name of the ML framework used for training              |
|     models      |       Union\[str, List\[Dict\[str, Any\]\]\]       |                    List of model configurations                     |
| hyperparameters |                        str                         |      Path or string content of hyperparameters in YAML format       |
|   app_options   | Optional\[Union\[str, List\[Dict\[str, Any\]\]\]\] |           Options for the application layout and behavior           |
|    work_dir     |                  Optional\[str\]                   | Local path for storing intermediate files |

#### Important TrainApp Attributes

- **`train.work_dir`** - Path to the working directory. Contains intermediate files.
- **`train.output_dir`** - Path to the output directory. Contains training results.

**Project-related Attributes**

- **`train.project_id`** - Supervisely project ID
- **`train.project_name`** - Project name
- **`train.project_info`** - Contains project information(ProjectInfo object)
- **`train.project_meta`** - [ProjectMeta](https://supervisely.readthedocs.io/en/latest/sdk/supervisely.project.project_meta.ProjectMeta.html#supervisely.project.project_meta.ProjectMeta) object with classes/tags info
- **`train.project_dir`** - Project directory path
- **`train.train_dataset_dir`** - Training dataset directory path
- **`train.val_dataset_dir`** - Validation dataset directory path
- **`train.sly_project`** - Supervisely [Project](https://supervisely.readthedocs.io/en/latest/sdk_packages.html#project) object

**Model-related Attributes**

- **`train.model_name`** - Name of the selected model
- **`train.model_source`** - Indicates if the model is pretrained or custom (trained in Supervisely)
- **`train.model_files`** - Dictionary containing paths to model files (e.g., `checkpoint` and optional `config`)
- **`train.model_info`** - Entry from the `models.json` for the selected model
- **`train.hyperparameters`** - Dictionary of selected hyperparameters
- **`train.classes`** - List of selected classes
- **`train.device`** - Selected CUDA device

## Custom Model Integration Steps

Let's dive into the steps required to integrate your custom model using the `TrainApp` class.

### Step 1. Prepare the Model Configuration List 📑

Create a `models.json` file that holds a list of model configurations. Each entry is a dictionary with model-specific details. This data will be used in the GUI for model selection (except for the technical meta field).

**Example `models.json`**

<details>

<summary> <b> Click to expand </b> </summary>

```json
[
    {
        "Model": "RT-DETRv2-S",
        "dataset": "COCO",
        "AP_val": 48.1,
        "Params(M)": 20,
        "FPS(T4)": 217,
        "meta": {
            "task_type": "object detection",
            "model_name": "RT-DETRv2-S",
            "model_files": {
                "checkpoint": "https://github.com/lyuwenyu/storage/releases/download/v0.2/rtdetrv2_r18vd_120e_coco_rerun_48.1.pth",
                "config": "rtdetrv2_r18vd_120e_coco.yml"
            }
        }
    },
    // ... additional models
]
```

</details>

**Note:**

- The `meta` field holds technical details used by the `TrainApp`:
  - `task_type`: The type of task (e.g., object detection)
  - `model_name`: Model name
  - `model_files`: Paths to the checkpoint and configuration files

_Example GUI preview:_

![model-selection](https://github.com/user-attachments/assets/753f6f0f-a38f-4d61-accb-dc8ba41777c0)


### Step 2. Prepare Hyperparameters YAML 🔧

Define your default hyperparameters in a YAML file (e.g., `hyperparameters.yaml`). This file is then passed to the `TrainApp` for training configuration.

**Example `hyperparameters.yaml`**

<details>
<summary> <b> Click to expand </b> </summary>

```yaml
epoches: 50
batch_size: 16
eval_spatial_size: [640, 640]  # height, width

checkpoint_freq: 5
save_optimizer: false
save_ema: false

optimizer:
  type: AdamW
  lr: 0.0001
  betas: [0.9, 0.999]
  weight_decay: 0.0001

clip_max_norm: 0.1

lr_scheduler:
  type: MultiStepLR  # CosineAnnealingLR | OneCycleLR
  milestones: [35, 45]  # epochs
  gamma: 0.1

lr_warmup_scheduler:
  type: LinearWarmup
  warmup_duration: 1000  # steps

use_ema: True 
ema:
  type: ModelEMA
  decay: 0.9999
  warmups: 2000

use_amp: True
```

</details>

### Step 3. [Optional] Prepare App Options File ⚙️

You can provide additional options to control the GUI layout and behavior. Create an `app_options.yaml` file to enable or disable features.

**Available options**

<details>
<summary> <b> Click to expand </b> </summary>

- **`device_selector`**
  - **description:** Show CUDA device selector in GUI
  - **default:** `false
  - **options:** `true`, `false`
- **`model_benchmark`**
  - **description:** Add checkboxes to run model benchmark to the GUI
  - **default:** `false`
  - **options:** `true`, `false`
- **`export_onnx_supported`**
  - **description:** Enable export to ONNX format, requires [export implementation](#link-to-custom-export-tutorial)
  - **default:** `false`
  - **options:** `true`, `false`
- **`export_tensorrt_supported`**
  - **description:** Enable export to TensorRT format, requires [export implementation](#link-to-custom-export-tutorial)
  - **default:** `false`
  - **options:** `true`, `false`
- **`train_logger`**
  - **description:** Comment to use custom tensorboard logger (requires additional implementation). Set to `tensorboard` to use supervisely tensorboard logger.
  - **default:** `None`
  - **options:** `None`, `tensorboard`
- **`show_logs_in_gui`**
  - **description:** Show logs window in GUI during training
  - **default:** `true`
  - **options:** `true`, `false`
- **`auto_convert_classes`**
  - **description:** Automatically converts classes according to the model CV task for model benchmark and creates a new project.
  - **default:** `false`
  - **options:** `true`, `false`
- **`collapsable`** | <span style="color:red">Beta feature</span>
  - **description:**  Collapse GUI cards on selection
  - **default:** `false`
  - **options:** `true`, `false`
- **`demo`** | <span style="color:green">For developers</span>
  - **description:**  Path to the demo folder containing tutorial data on how to use the model outside of the Supervisely platform
  - **default:** `None`
  - **options:** `path/to/demo/folder`

</details>

**Example `app_options.yaml`**

<details>

<summary> <b> Click to expand </b> </summary>

```yaml
device_selector: false
model_benchmark: true
show_logs_in_gui: true
collapsable: false
auto_convert_classes: true
```

</details>

### Step 4. Integrate Your Custom Model 🤖

Now it’s time to integrate your custom model using the TrainApp class. We’ll use the RT-DETRv2 model as an example. You can always refer to the source code for Train RT-DETRv2 on [GitHub](https://github.com/supervisely-ecosystem/RT-DETRv2/tree/main/supervisely_integration/train).

#### Step 4.1 Initialize Your Imports

```python
import os
import shutil
import sys
from multiprocessing import cpu_count

sys.path.insert(0, "rtdetrv2_pytorch")
import yaml

import supervisely as sly
from rtdetrv2_pytorch.src.core import YAMLConfig
from rtdetrv2_pytorch.src.solver import DetSolver
from supervisely.nn import ModelSource, RuntimeType
from supervisely.nn.training.train_app import TrainApp
from supervisely_integration.export import export_onnx, export_tensorrt
from supervisely_integration.serve.rtdetrv2 import RTDETRv2
```

#### Step 4.2 Initialize the `TrainApp`

Create an instance of the `TrainApp` by providing the framework name, model configuration file, hyperparameters file, and app options file.

```python
base_path = "supervisely_integration/train"
train = TrainApp(
    "RT-DETRv2",
    f"supervisely_integration/models_v2.json",
    f"{base_path}/hyperparameters.yaml",
    f"{base_path}/app_options.yaml",
)
```

#### Step 4.3 [Optional] Register the Inference Class

If you plan to use model benchmarking, register your custom inference class.

Please refer to the [serving implementation](#link-to-custom-serving-tutorial) guide for more information.

```python
train.register_inference_class(RTDETRv2)
```

#### Step 4.4 Implement Your Training Logic

The `TrainApp` gives you access to the Supervisely [Project](https://supervisely.readthedocs.io/en/latest/sdk/supervisely.project.project.Project.html#supervisely.project.project.Project) containing the `train` and `val` datasets. Convert these datasets to the desired format (e.g., COCO) and run your training routine.

You can use built-in converters like `to_coco` to convert your datasets to the required format or write your custom converter if required.

**Data Conversion Example:**

```python
def convert_data() -> Tuple[str, str]:
    # Get selected project from TrainApp
    project = train.sly_project
    meta = project.meta

    # Convert train dataset to COCO format
    train_dataset: sly.Dataset = project.datasets.get("train")
    train_ann_path = train_dataset.to_coco(meta, dest_dir=train_dataset.directory)

    # Convert val dataset to COCO format
    val_dataset: sly.Dataset = project.datasets.get("val")
    val_ann_path = val_dataset.to_coco(meta, dest_dir=val_dataset.directory)
    return train_ann_path, val_ann_path
```

**Training Routine with @train.start Decorator:**

All training logic should be implemented in the `start_training` function using the `@train.start` decorator and should return the experiment information dictionary.

```python
@train.start
def start_training():
    # 1️⃣ Convert data to required format
    train_ann_path, val_ann_path = convert_data()

    # 2️⃣ Get the path to the selected checkpoint
    checkpoint = train.model_files["checkpoint"]

    # 3️⃣ Prepare custom config for training
    custom_config_path = prepare_config(train_ann_path, val_ann_path)
    cfg = YAMLConfig(
        custom_config_path,
        tuning=checkpoint,
    )
    output_dir = cfg.output_dir
    os.makedirs(output_dir, exist_ok=True)
    model_config_path = f"{output_dir}/model_config.yml"
    with open(model_config_path, "w") as f:
        yaml.dump(cfg.yaml_cfg, f)
    remove_include(model_config_path)

    # 4️⃣ Start training with tensorboard logs
    tensorboard_logs = f"{output_dir}/summary"
    train.start_tensorboard(tensorboard_logs)
    
    solver = DetSolver(cfg)
    solver.fit()

    # 5️⃣ Return experiment information
    experiment_info = {
        "model_name": train.model_name,
        "model_files": {"config": model_config_path},
        "checkpoints": output_dir,
        "best_checkpoint": "best.pth",
    }
    return experiment_info
```

#### 4.5. Add a Progress Bar with the Train Logger ⏱️

Enhance your training feedback by incorporating a progress bar via the Supervisely `train_logger`.

Simply import `train_logger` from `supervisely.nn.training` and use it in your training loop.

```python
from supervisely.nn.training import train_logger

train_logger.train_started(total_epochs=(args.epoches - start_epcoch))
for epoch in range(start_epcoch, total_epochs):
    train_logger.epoch_started(epoch)
    ...
    train_logger.epoch_finished(epoch, metrics)
train_logger.train_finished()
```
