# Custom Model Integration Tutorial 🚀

Welcome to this step-by-step guide on integrating your custom model with the Supervisely SDK! In this tutorial, you'll learn how to use the powerful TrainApp class to train your model effortlessly while taking advantage of Supervisely’s robust infrastructure. We’ll use the [Train RT-DETRv2](https://ecosystem.supervisely.com/apps/rt-detrv2/supervisely_integration/train) implementation as an example throughout this guide.

## Overview

This guide will walk you through the process of:

- Preparing model configuration files 📄
- Learning about dedicated Supervisely `TrainApp` class 🔧
- Integrating your custom model using Supervisely ⚙️
- Finalizing and uploading your training artifacts 📦

### The TrainApp Class

The Supervisely SDK provides a dedicated class called `TrainApp` to help you train your custom model using Supervisely’s infrastructure. This class offers a built-in GUI and manages many essential tasks automatically.

**Key Features of TrainApp**

- Built-in GUI: Simple and easy to follow customizable interface
- Train and Val Splits: Automatically split your dataset into training and validation sets
- Data Preparation: Seamless conversion of Supervisely projects to the required format
- Data Backup: Automatic backup of your dataset with Supervisely’s versioning system
- Model Evaluation: On-demand evaluation (requires a model [serving implementation](https://developer.supervisely.com/app-development/neural-network-integration/inference/overview-nn-integration))
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

|   Parameters    |                        Type                        |                  Description                   |
|:---------------:|:--------------------------------------------------:|:----------------------------------------------:|
| framework_name  |                        str                         |   Name of the ML framework used for training   |
|     models      |       Union\[str, List\[Dict\[str, Any\]\]\]       | Path to `.json` file with model configurations |
| hyperparameters |                        str                         |   Path to hyperparameters in `.yaml` format    |
|   app_options   | Optional\[Union\[str, List\[Dict\[str, Any\]\]\]\] |     Path to options file in `.yaml` format     |
|    work_dir     |                  Optional\[str\]                   |   Local path for storing intermediate files    |

## How to Run and Debug

`TrainApp` is the same Supervisely App, but with a built-in GUI, so you don't have to worry about all the widgets and layout.

You can run and debug your training app locally using the following shell command:

```shell
uvicorn main:train.app --host 0.0.0.0 --port 8000 --ws websockets
```

After running the app, you can access the GUI by opening the following URL in your browser:

```text
http://localhost:8000/
```

{% hint style="info" %}

Please see this [tutorial](https://developer.supervisely.com/app-development/apps-with-gui/hello-world) to learn how to run and debug Supervisely app.

{% endhint %}

If you are a VSCode user, you can create `.vscode/launch.json` configuration to run and debug your training app locally.

**Example `launch.json`**

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Uvicorn Train",
      "type": "debugpy",
      "request": "launch",
      "module": "uvicorn",
      "args": [
        "main:train.app",
        "--host",
        "0.0.0.0",
        "--port",
        "8000",
        "--ws",
        "websockets",
      ],
      "justMyCode": false,
      "env": {
        "PYTHONPATH": "${workspaceFolder}:${PYTHONPATH}",
        "LOG_LEVEL": "DEBUG",
        "DEBUG_APP_DIR": "app_data"
      }
    }
    ]
}
```

## Custom Model Integration Steps

Let's dive into the steps required to integrate your custom model using the `TrainApp` class.

### Step 1. Prepare the Model Configuration List 📑

Create a `models.json` file that holds a list of model configurations. Each entry is a dictionary with model-specific details. These fields are used to populate the model table and can be customized based on your model requirements. This data will be displayed in the GUI for model selection (except for the technical `meta` field, which is required for the `TrainApp` to correctly access model info).

{% hint style="info" %}

📄 See source file for the RT-DETRv2 [models.json](https://github.com/supervisely-ecosystem/RT-DETRv2/blob/main/supervisely_integration/models_v2.json)

{% endhint %}

**Example `models.json`**

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

**Note:**

- The `meta` field holds technical details used by the `TrainApp`:
  - (**required**) `task_type`: The type of task (e.g., object detection)
  - (**required**) `model_name`: Model name
  - (**required**) `model_files`: Paths to the checkpoint and configuration files
    - (**required**) `checkpoint`: Path or URL to the model checkpoint. URL will be downloaded automatically.
    - (**optional**) `config`: Path to the model configuration file

_Example GUI preview:_

![model-selection](https://github.com/user-attachments/assets/753f6f0f-a38f-4d61-accb-dc8ba41777c0)

### Step 2. Prepare Hyperparameters YAML 🔧

Define your default hyperparameters save to a YAML file (e.g., `hyperparameters.yaml`). Path to this file is then passed to the `TrainApp` for training configuration.

You can access hyperparameters later in the code by using `train.hyperparameters` in your training logic.

{% hint style="info" %}

📄 See source file for the RT-DETRv2 [hyperparameters.yaml](https://github.com/supervisely-ecosystem/RT-DETRv2/blob/main/supervisely_integration/train/hyperparameters.yaml)

{% endhint %}

**Example `hyperparameters.yaml`**

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

### Step 3. [Optional] Prepare App Options File ⚙️

You can provide additional options to control the GUI layout and behavior. Create an `app_options.yaml` file to enable or disable features.

**Available options**

<details>
<summary> <b> Click to expand </b> </summary>

- **`device_selector`**
  - **description:** Show CUDA device selector in GUI
  - **default:** `false`
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
- **`collapsable`** | <mark style="color:red">Beta feature</mark>
  - **description:**  Collapse GUI cards on selection
  - **default:** `false`
  - **options:** `true`, `false`
- **`demo`** | <mark style="color:purple">For developers</mark>
  - **description:**  Path to the demo folder containing tutorial data on how to use the model outside of the Supervisely platform
  - **default:** `None`
  - **options:** `path/to/demo/folder`

</details>

{% hint style="info" %}

📄 See source file for the RT-DETRv2 [app_options.yaml](https://github.com/supervisely-ecosystem/RT-DETRv2/blob/main/supervisely_integration/train/app_options.yaml)

{% endhint %}

**Example `app_options.yaml`**

```yaml
device_selector: false
model_benchmark: true
show_logs_in_gui: true
collapsable: false
auto_convert_classes: true
```

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
    framework_name="RT-DETRv2",
    models=f"supervisely_integration/models_v2.json",
    hyperparameters=f"{base_path}/hyperparameters.yaml",
    app_options=f"{base_path}/app_options.yaml",
)
```

#### Step 4.3 [Optional] Register the Inference Class

If you plan to use [model benchmarking](../model-evaluation-benchmark/README.md), register your custom inference class.

Please refer to the [serving implementation](https://developer.supervisely.com/app-development/neural-network-integration/inference/overview-nn-integration) guide for more information.

```python
train.register_inference_class(RTDETRv2)
```

#### Step 4.4 Prepare Training

The `TrainApp` gives you access to the Supervisely [Project](https://supervisely.readthedocs.io/en/latest/sdk/supervisely.project.project.Project.html#supervisely.project.project.Project) containing the `train` and `val` datasets. Convert these datasets to the desired format (e.g., COCO) and run your training routine.

{% hint style="info" %}

Use `train.sly_project` to access the Supervisely project in the training code.

{% endhint %}

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

All training code should be implemented in the `start_training` function using the `@train.start` decorator and should return the experiment information dictionary.

Training logic and loop are inside `solver.fit()` function.

{% hint style="info" %}

📄 See source code for the RT-DETRv2 [main.py](https://github.com/supervisely-ecosystem/RT-DETRv2/blob/main/supervisely_integration/train/main.py)

{% endhint %}

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

    # 4️⃣ Start tensorboard logs
    tensorboard_logs = f"{output_dir}/summary"
    train.start_tensorboard(tensorboard_logs)
    
    # 5️⃣ Start training
    solver = DetSolver(cfg)
    solver.fit()

    # 6️⃣ Return experiment information
    experiment_info = {
        "model_name": train.model_name,
        "model_files": {"config": model_config_path},
        "checkpoints": output_dir,
        "best_checkpoint": "best.pth",
    }
    return experiment_info
```

Returned dictionary should contain the following fields:

- **`model_name`** - Name of the model used for training
- **`model_files`** - Dictionary with paths to additional model files (e.g. `config`)
- **`checkpoints`** - List of checkpoint paths or path to the output directory with checkpoints
- **`best_checkpoint`** - Name of the best checkpoint file

{% hint style="warning" %}

These fields will be validated upon training completion, and if one of them is missing, the training will be considered as failed.

{% endhint %}

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

## Final Steps 🎉

After training is completed successfully, the `TrainApp` will automatically prepare and upload the model and all related files to Supervisely storage. During this finalization phase, TrainApp executes several important steps to ensure your experiment's outputs are correctly validated, processed, and stored.

Standard Supervisely storage path for the experiment: `/experiments/{project_id}_{project_name}/{task_id}_{framework_name}/`

**Here’s what happens:**

1. **Validating of `experiment_info`**
The system checks the `experiment_info` dictionary to ensure all required fields (like model name, file paths, etc.) are correct and complete. This step is essential to prevent any missing or incorrect metadata.

2. **Postprocess Training Artifacts**
Additional processing is applied to the raw training outputs (e.g., cleaning up temporary files, formatting logs, and aggregating metrics) to generate a standardized set of artifacts.

3. **Postprocess Training and Validation Splits**
The splits for training and validation data are further refined if needed. This step ensures consistency and prepares the splits for future reference or re-training if necessary.

4. **Upload Checkpoints to Supervisely Storage**
All model checkpoints (e.g., best, intermediate, and last checkpoints) are automatically uploaded to the Supervisely storage so that they are safely stored and can be accessed later.

5. **Create and Upload model_meta.json**
A metadata file (model_meta.json) is generated, which includes essential details about the model (such as its architecture, training parameters, and version). This file is then uploaded along with other artifacts.

6. **Run Model Benchmarking (if enabled)**
If model benchmarking is enabled in your `app_options`, the system will run automated tests to evaluate model performance. These benchmarks help in comparing the model against standard metrics.

7. **Export Model to ONNX and TensorRT (if enabled)**
For ease of deployment, the model may be automatically exported to additional formats like ONNX and TensorRT. This ensures compatibility with different serving environments.

8. **Generate and Upload Additional Training Files**
Other supplementary files such as logs, experiment reports, and configuration files are packaged and uploaded. These additional artifacts help in future debugging, auditing, or model evaluation.

**Output Artifacts Directory Structure**

Below is an example of how the final output directory might be structured:

```text
📦265_RT-DETRv2
 ┣ 📂checkpoints
 ┃ ┣ 📜best.pth
 ┃ ┣ 📜checkpoint0025.pth
 ┃ ┣ 📜checkpoint0050.pth
 ┃ ┗ 📜last.pth
 ┣ 📂export
 ┃ ┗ 📜best.onnx
 ┣ 📂logs
 ┃ ┗ 📜events.out.tfevents.1738673672.sly-app-265-lghhx.101.0
 ┣ 📜Model Evaluation Report.lnk
 ┣ 📜app_state.json
 ┣ 📜experiment_info.json
 ┣ 📜hyperparameters.yaml
 ┣ 📜model_config.yml
 ┣ 📜model_meta.json
 ┣ 📜open_app.lnk
 ┗ 📜train_val_split.json
```

**Final `experiment_info.json` Example**

This is an example of the final experiment information file that is generated:

```json
{
  "experiment_name": "265_Lemons_RT-DETRv2-M",
  "framework_name": "RT-DETRv2",
  "model_name": "RT-DETRv2-M",
  "task_type": "object detection",
  "project_id": 27,
  "task_id": 265,
  "model_files": {
    "config": "model_config.yml"
  },
  "checkpoints": [
    "checkpoints/best.pth",
    "checkpoints/checkpoint0025.pth",
    "checkpoints/checkpoint0050.pth",
    "checkpoints/last.pth"
  ],
  "best_checkpoint": "best.pth",
  "export": {
    "ONNXRuntime": "export/best.onnx"
  },
  "app_state": "app_state.json",
  "model_meta": "model_meta.json",
  "train_val_split": "train_val_split.json",
  "train_size": 4,
  "val_size": 2,
  "hyperparameters": "hyperparameters.yaml",
  "artifacts_dir": "/experiments/27_Lemons/265_RT-DETRv2/",
  "datetime": "2025-02-04 12:56:57",
  "evaluation_report_id": 21037,
  "evaluation_report_link": "https://app.supervisely.com/model-benchmark?id=21037",
  "evaluation_metrics": {
    "mAP": 1,
    "AP50": 1,
    "AP75": 1,
    "f1": 0.8333333333333333,
    "precision": 1,
    "recall": 0.75,
    "iou": 0.9704312784799517,
    "classification_accuracy": 1,
    "calibration_score": 0.8725475046690554,
    "f1_optimal_conf": 0.5143424272537231,
    "expected_calibration_error": 0.12745249533094466,
    "maximum_calibration_error": 0.35718443564006264
  },
  "logs": {
    "type": "tensorboard",
    "link": "/experiments/27_Lemons/265_RT-DETRv2/logs/"
  }
}
```

**Fields explanation:**

- **experiment_name**, **framework_name**, **model_name**, **task_type**: General metadata about the training experiment.
- **project_id**, **task_id**: IDs used to uniquely identify the project and the training task within Supervisely.
- **model_files**: Contains paths to the model configuration file(s).
- **checkpoints** & **best_checkpoint**: Lists the checkpoints produced during training and indicates the best-performing one.
- **export**: Shows the export file for ONNX (or TensorRT if enabled).
- **app_state**, **model_meta**, **train_val_split**, **hyperparameters**: References to additional configuration and state files.
- **artifacts_dir** & **datetime**: Directory where artifacts are stored and the timestamp of the experiment.
- **evaluation_report** and **evaluation_metrics**: Information from the model benchmarking process (if run).
- **logs**: Location of training logs for review in the Supervisely interface.

## Additional Resources 📚

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

#### Debugging with app_state.json 🐞

The `app_state.json` file captures the state of the `TrainApp` right before training begins. This file is incredibly useful for debugging and troubleshooting issues that might arise during training. It allows developers to quickly restart the training process without having to reconfigure all the settings via the GUI.

You can access `app_state` in the training code by using `train.app_state`.

**Why Use app_state.json?**
- **Quick Debugging:** If something goes wrong during training, you can inspect the app_state.json file to see the exact configuration that was used.
- **Streamlined Re-runs:** Run the training app from an API request without manually reselecting settings every time.
- **State Preservation:** It preserves the state of the training app in a human-readable YAML format.

**How to use app_state.json**

```python
app_state = {...}
train.gui.load_from_app_state(app_state)
```

**Example of `app_state.json`:**

```json
{
  "input": {
    "project_id": 27
  },
  "train_val_split": {
    "method": "random",
    "split": "train",
    "percent": 80
  },
  "classes": ["kiwi", "lemon"],
  "model": {
    "source": "Pretrained models",
    "model_name": "RT-DETRv2-M"
  },
  "hyperparameters": "epoches: 20\nbatch_size: 16\neval_spatial_size: [640, 640]...",
  "options": {
    "model_benchmark": {
      "enable": true,
      "speed_test": false
    },
    "cache_project": true
  }
}
```

#### Fields in app_state.json

**`input`**
- **description:** Contains the input data for the training app.
- **fields:**
  - project_id – The ID of the project to use for training.

**`train_val_split`**
- **description:** Configures how the dataset is split into training and validation sets.
- **fields:**
  - method: The splitting method (e.g., `random`, `tags`, or `datasets`).
  - If method is `random`:
    - split: Specifies which split to use (e.g., train or val).
    - percent: The percentage of the dataset to include for training.
  - If method is `tags`:
    - train_tag: The tag used for the training split.
    - val_tag: The tag used for the validation split.
    - untagged_action: Action for untagged images (options: train, val, or ignore).
  - If method is `datasets`:
    - train_datasets: IDs of datasets used for training.
    - val_datasets: IDs of datasets used for validation.

**`classes`**
- **description:** Lists the classes to be used during training.

**`model`**
- **description:** Specifies the model configuration for training.
- **fields:**
  - source: The model source, such as `Pretrained models` or `Custom model`.
  - If source is `Pretrained models`:
    - model_name: The name of the pretrained model (should match an entry in models.json).
  - If source is `Custom model`:
    - task_id: The training session ID containing the custom checkpoint.
    - checkpoint: The name of the custom checkpoint to be used.

**`hyperparameters`**
- **description:** Contains the hyperparameters (in YAML format) used for training.

**`options`**
- **description:** Provides additional optional configurations for the training app.
- **fields:**
  - model_benchmark: Configuration for model benchmarking.
    - enable: Boolean to enable or disable benchmarking.
    - speed_test: Boolean to enable or disable a speed test.
  - cache_project: Boolean to enable or disable caching of the project.
  - export: Configurations for model export.
    - ONNXRuntime: Option for enabling/disabling ONNX model export.
    - TensorRT: Option for enabling/disabling TensorRT model export.