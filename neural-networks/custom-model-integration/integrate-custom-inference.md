# Integrate Custom Inference

## Overview

In this guide, you'll learn how to build a custom [Serving App](../inference-and-deployment/supervisely-serving-apps.md) using the Supervisely SDK. By integrating your own model, you'll be able to deploy it on the Supervisely platform (or externally). In other words, you'll transform your model into a serving app that's ready to be used in production.

**Key Features:**

- **Easily Serve Your Model:** Run inference on your own data through Supervisely platform or locally.
- **Customize Your Solution:** Extend a Supervisely SDK class and implement the core methods needed for your custom inference solution.
- **Debug and Release**: Test locally, debug quickly, and deploy your app for production use.

## Step-by-Step Implementation

To integrate your custom model into the Supervisely platform, follow these steps:

- **Step 1. Prepare Model Configurations:** Create `models.json` file with model configurations and checkpoints.
- **Step 2. Prepare Inference Settings:** Create `inference_settings.yaml` file to define a set of parameters used for inference.
- **Step 3. Prepare App Options:** Create a `app_options.yaml` file to specify additional options for your app.
- **Step 4. Create Inference Class:** Create a python file that contains your custom inference class.
- **Step 5. Implement Required Methods:** Implement the `load_model` and `predict` methods.
- **Step 6. Create Main Script:** Create an entrypoint python script to run and serve your model.

### Implementation Example

```python
import torch
import supervisely as sly

class CustomYOLOInference(sly.nn.inference.ObjectDetection):
    # 1️⃣ Define essential class variables
    FRAMEWORK_NAME = "Custom YOLO"
    MODELS = "src/models.json"  # File containing your model configurations
    INFERENCE_SETTINGS = "src/inference_settings.yaml"  # Additional inference settings
    APP_OPTIONS = "src/app_options.yaml" # [optional] Additional app options


    # 2️⃣ Implement the load_model method
    def load_model(
        self,
        model_files: dict,
        model_info: dict,
        model_source: str,
        device: str,
        runtime: str
    ):
        """
        Load and prepare the model for inference.
        """
        checkpoint_path = model_files["checkpoint"]
        self.model = torch.load(checkpoint_path, map_location=device)
        self.model.to(device)
        self.model.eval()

    # 3️⃣ Prepare the postprocessor (convert raw outputs to predictions)
    def predict(self, image_path: str, settings: dict):
        """
        Run inference on the input image and return predictions.
        """
        img_tensor = self._preprocess_image(image_path)
        outputs = self.model(img_tensor)
        predictions = self._postprocess_outputs(outputs, settings)
        return predictions
```

![Custom Inference GUI](/.gitbook/assets/custom-model-integration/inference-app.png)

### Step 1. Prepare Model Configurations

If you plan to use pretrained checkpoints (e.g., pretrained YOLO checkpoints), you need to create a `models.json` file containing model configurations and weights. This JSON file consists of a list of dictionaries, each detailing a specific model and its checkpoint. The information from this file will populate a table in your app's GUI, allowing users to select a model for inference.

If you only plan to use checkpoints trained in Supervisely with your [Custom Training App](./integrate-custom-training.md), you don't need to create this file.

**Example `models.json`**

```json
[
    {
        "Model": "Custom YOLO-S",
        "Size (pixels)": "640",
        "mAP": "34.3",
        "params (M)": "2.6",
        "FLOPs (B)": "7.7",
        "meta": {
            "task_type": "object detection",
            "model_name": "custom yolo-s",
            "model_files": {"checkpoint": "https://.../yolo-s.pt"}
        }
    },
    // ... additional models
]
```

_Example GUI preview:_

![Model in GUI](/.gitbook/assets/custom-model-integration/inference-models-json.png)

#### Table Fields

Each dictionary item in `models.json` represents a single model as a row, with all its fields, except for the `meta` field, acting as columns. You can customize these fields to display the necessary information about your checkpoints.

#### Technical Field (`meta`)

Each model configuration must have a `meta` field. This field is not displayed in the table but contains essential information required by the `Inference` class to properly download checkpoints and load the model for inference.

Here are the required fields:

- (**required**) `task_type`: A computer vision task type (e.g., object detection).
- (**required**) `model_name`: Model configuration name.
- (**required**) `model_files`: A dict with files needed to load the model, such as model weights, config file. You can extend it with additional files if needed.
  - (**required**) `checkpoint`: Path or URL to the model checkpoint. URL will be downloaded automatically.
  - *(optional)* `config`: Path to the model configuration file.
  - *(optional)* Any additional files can be added to the `model_files` dictionary that are required for your model.

### Step 2. Prepare Inference Settings

Create an `inference_settings.yaml` file to define a set of parameters used for inference.

**Example `inference_settings.yaml`:**

```yaml
# bounding box confidence threshold
conf: 0.25
# intersection over union (IoU) threshold for NMS
iou: 0.7
# use half precision (FP16)
half: False
# maximum number of detections per image
max_det: 300
# whether to use class-agnostic NMS or not
agnostic_nms: False
```

### Step 3. Prepare App Options

By default, the inference app supports two sources of model checkpoints: pretrained checkpoints listed in `models.json` and custom checkpoints trained in Supervisely. If you don't plan to support both, you can disable one in the `app_options.yaml` file.

The `app_options.yaml` file allows you to customize your app. You can enable or disable the pretrained models tab, the custom models tab, and specify supported runtimes, which let users choose a runtime for inference (such as ONNXRuntime or TensorRT).

**Example `app_options.yaml`:**

```yaml
pretrained_models: true
custom_models: true
supported_runtimes: ["pytorch"]
```

**Available options:**

- **`pretrained_models`** – Enables the pretrained models tab in the GUI. These are the checkpoints provided in `models.json`. *(Default: `True`)*
- **`custom_models`** – Enables the custom models tab in the GUI. These are the checkpoints trained in Supervisely using a corresponding training app. *(Default: `True`)*
- **`supported_runtimes`** – Defines a list of runtimes the app supports. Available runtimes: `pytorch`, `onnx`, `tensorrt`. *(Default: `["pytorch"]")*

### Step 4. Create Inference Class

Create a python file (e.g., `src/custom_yolo.py`) that contains your custom inference class with implementation.

**Example custom_yolo.py:**

```python
import supervisely as sly

class CustomYOLOInference(sly.nn.inference.ObjectDetection):
    # Define essential class variables
    FRAMEWORK_NAME = "Custom YOLO"
    MODELS = "src/models.json"  # File containing your model configurations
    INFERENCE_SETTINGS = "src/inference_settings.yaml"  # Additional inference settings
    # ...
```

#### Inheritance

Your custom class should inherit from the appropriate Supervisely base class, depending on Computer Vision task your model solves. For example, if you're working on an object detection model, you should inherit from `sly.nn.inference.ObjectDetection`.

#### Available classes for inheritance

- `ObjectDetection`
- `InstanceSegmentation`
- `SemanticSegmentation`
- `PoseEstimation`
- `ObjectDetection3D`
- `InteractiveSegmentation`
- `SalientObjectSegmentation`
- `Tracking`
- `PromptBasedObjectDetection`
- `PromptableSegmentation`

Each of these classes implements a logic for converting model predictions (`sly.nn.Prediction` objects) to [Supervisely Annotation format](https://developer.supervisely.com/getting-started/supervisely-annotation-format) (`sly.Annotation`).

{% hint style="info" %}
If there is no suitable class for your task, you can inherit from the base class `sly.nn.inference.Inference` and implement the methods responsible for converting predictions to Supervisely format. See the section [Custom Task Type](#custom-task-type).
{% endhint %}

#### Class Variables

In your custom class, define class variables to specify the model framework, paths to model configurations (`models.json`), and inference settings (`inference_settings.yaml`).

**Class variables:**

- **`FRAMEWORK_NAME:`** Name of your model's framework or architecture.
- **`MODELS:`** Path to your `models.json` file.
- **`INFERENCE_SETTINGS:`** Path to your `inference_settings.yaml` settings file.
- **`APP_OPTIONS:`** (Optional) Path to `app_options.yaml` file for additional customization.

### Step 5. Implement Required Methods

#### The `load_model` Method

This method loads the model checkpoint and prepares it for inference. It running after the user selected a model and clicked the "SERVE" button in the GUI.

Let's break down the `load_model` parameters. These parameters contains all the necessary information to load your model and weights:

- **`model_files`:** A dictionary containing paths to the files of a selected model. It will have the same fields as in `model_files` from your `models.json`. All paths are local paths, and URLs are downloaded automatically.
- **`model_info`:** A dictionary containing information about the selected model configuration. If the user selected a pretrained checkpoint, the fields are come from `models.json`, otherwise this will be a dict of [experiment info](./integrate-custom-training.md#experiment-info) from custom model that was trained in Supervisely.
- **`model_source`:** The source of the model (`Pretrained models` or `Custom model`). This can be used to determine where the model checkpoint is coming from and help to load the model properly.
- **`device`:** The device the user selected in the GUI (e.g., `cpu`, `cuda`, `cuda:1`).
- **`runtime`:** The runtime the uses selected for inference (e.g., `pytorch`, `onnx`).

```python
def load_model(
    self,
    model_files: dict,
    model_info: dict,
    model_source: str,
    device: str,
    runtime: str
):
    """
    Load and prepare the model for inference.
    """
    # 1️⃣ Retrieve the checkpoint file path
    checkpoint_path = model_files["checkpoint"]
    
    # 2️⃣ Load the model using PyTorch (simplified for this example)
    self.model = torch.load(checkpoint_path, map_location=device)
    self.model.to(device)
    self.model.eval()
```

#### The `predict` Method

This method pre-processes the input image, runs inference, and then post-processes the outputs to the established format for predictions.

1. **Preprocess the input image:** Read the image, resize it, normalize it, and convert it to a tensor, or do whatever preprocessing is necessary for your model.
2. **Run the model inference:** Pass the preprocessed image through the model and get the raw outputs.
3. **Postprocess the outputs:** Convert the raw outputs to Supervisely prediction objects. The `sly.nn.Prediction` is the base class for this. Depending on your CV task, use the appropriate subclass: `sly.nn.PredictionBBox`, `sly.nn.PredictionMask`, etc.

Here is the list of available subclasses of `sly.nn.Prediction` for different computer vision tasks:

| Task Type | Prediction Class |
| :--- | :--- |
| Object Detection | `sly.nn.PredictionBBox` |
| Instance Segmentation | `sly.nn.PredictionMask` |
| Semantic Segmentation | `sly.nn.PredictionSegmentation` |
| Pose Estimation | `sly.nn.PredictionKeypoints` |
| Object Detection 3D | `sly.nn.PredictionCuboid3d` |
| Interactive Segmentation | `sly.nn.PredictionMask` |
| Tracking | `sly.nn.PredictionBBox` |

{% hint style="info" %}
If no suitable subclass is available, you can create your own *Prediction* class by inheriting from `sly.nn.Prediction` and convert outputs to this class. Also, you need to override additional methods in your `Inference` class. See the section [Custom Task Type](#custom-task-type).
{% endhint %}

```python
from PIL import Image
from typing import List
import supervisely as sly
from torchvision import transforms
import torch

def predict(self, image_path: str, settings: dict) -> List[sly.nn.Prediction]:
    """
    Run inference on the input image and return predictions.
    """
    # 1️⃣ Preprocess the input image
    img = Image.open(image_path).convert("RGB")
    img = img.resize((640, 640))
    img_tensor = transforms.ToTensor()(img).unsqueeze(0)
    
    # 2️⃣ Run the model inference
    with torch.no_grad():
        outputs = self.model(img_tensor)
    
    # 3️⃣ Convert the outputs to sly.nn.Prediction
    confidence_threshold = settings["conf"]  # field from inference_settings.yaml
    predictions = []
    for output in outputs:
        # filter by confidence threshold
        if output["confidence"] >= confidence_threshold:
            # convert xyxy to yxyx
            bbox = output["bbox"]
            bbox_yxyx = [bbox_yxyx[1], bbox_yxyx[0], bbox_yxyx[3], bbox_yxyx[2]]
            # convert label_idx to class name
            class_name = self.classes[output["label"]]
            # create PredictionBBox object
            prediction = sly.nn.PredictionBBox(
                class_name=class_name,
                bbox_yxyx=bbox_yxyx,
                confidence=output["confidence"]
            )
            predictions.append(prediction)
    return predictions
```

#### Custom Task Type

If your model solves a computer vision task that is not covered by the [available Inference subclasses](#available-classes-for-inheritance), you had to implement additional methods responsible for converting predictions to Supervisely format and create your own *Prediction* class inheriting from `sly.nn.Prediction`.

Here is the methods you need to implement:

- **`get_info`** - add your `"task type"` to the dict (see example code).
- **`_get_obj_class_shape`** - Specify the basic geometry class of what your model predicts (e.g., `sly.Rectangle`, `sly.Bitmap`, etc.).
- **`_create_label`** - This method takes a single predicted object (e.g, bbox) from a list of predictions returned by your `predict` method. It must convert an object to a supervisely label (`sly.Label`). The single predicted object is an object of your custom `sly.nn.Prediction`, and you need to convert it to a `sly.Label`.

```python
import supervisely as sly
from supervisely.nn.inference import Inference

# Custom Prediction class
class CustomPredictionBBox(sly.nn.Prediction):
    def __init__(self, class_name, bbox, score):
        self.class_name = class_name
        self.bbox = bbox
        self.score = score

class CustomObjectDetection(Inference):
    # <...> Implement the required methods: predict, load_model

    def get_info(self) -> dict:
        info = super().get_info()
        info["task type"] = "object detection"
        return info

    def _get_obj_class_shape(self):
        return sly.Rectangle

    def _create_label(self, dto: CustomPredictionBBox) -> sly.Label:
        # dto - is a single prediction returned by the `predict` method
        # 1. create a geometry
        obj_class = self.model_meta.get_obj_class(dto.class_name)
        geometry = sly.Rectangle(*dto.bbox_tlbr)
        # 2. add confidence tag
        tags = []
        tags.append(sly.Tag(self._get_confidence_tag_meta(), dto.score))
        # 3. create label
        label = sly.Label(geometry, obj_class, tags)
        return label
```


### Step 6. Create main.py script

Create an entrypoint script (`src/main.py`) that runs when the app starts. This script initializes your inference class and launches a FastAPI server using the `model.serve()` method.

**Example `main.py`**

```python
import supervisely as sly
from custom_yolo import CustomYOLOInference

model = CustomYOLOInference(use_gui=True, use_serving_gui_template=True)
model.serve()
```

## Run and Debug Your App

You can easily debug your code locally in your favorite IDE.

{% hint style="info" %}
We recommend using **Visual Studio Code** IDE, because our repositories have prepared settings for convenient debugging in VSCode. It is the easiest way to start.
{% endhint %}

**For VS Code users**

You can use the following `launch.json` configuration to run and debug your app locally (place it in the `.vscode` directory):

<details>
<summary> <b> .vscode/launch.json </b> </summary>

```json
// .vscode/launch.json

{
  "version": "0.2.0",
  "configurations": [
  {
      "name": "Uvicorn Serve",
      "type": "debugpy",
      "request": "launch",
      "module": "uvicorn",
      "args": [
        "src.main:model.app", // path to your main file and the app object
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
        "DEBUG_APP_DIR": "app_data",
        "DEBUG_WITH_SLY_NET": "1",
        "TEAM_ID": "123",  // put your team id here
      }
    }
  ]
}
```
</details>

### Run the app locally

Run the code in the VSCode debugger by selecting the `Uvicorn Serve` configuration. This will start the app on [http://localhost:8000](http://localhost:8000).

You may need to install additional packages to debug the app locally:

```shell
sudo apt-get install wireguard iproute2
```

**Shell command to run the app:**

```shell
python -m uvicorn src.main:model.app --host 0.0.0.0 --port 8000
```

If everything is set up correctly, you should be able to open the app in your browser at [http://localhost:8000](http://localhost:8000).

### Test that inference works correctly

Serve your model by clicking the "SERVE" button in the GUI. After this, run the following code to test the model inference via API using `SessionJSON` class (see more details in [Inference API Tutorial](https://developer.supervisely.com/app-development/neural-network-integration/inference-api-tutorial)).

```python
from os.path import expanduser
from dotenv import load_dotenv
import supervisely as sly
from supervisely.nn.inference import SessionJSON

# Put your image path here
image_path = "path/to/your/image.jpg"

# Load environment variables
load_dotenv("local.env")
load_dotenv(expanduser("~/supervisely.env"))

app_url = "http://localhost:8000"

api = sly.Api()
session = SessionJSON(api, session_url=app_url)

prediction = session.inference_image_path(image_path)
print(prediction)
print("✅ Success!")
```


## Releasing Your App

Once you've tested the code, it's time to release it into the platform. It can be released as an App that shared with the all Supervisely community, or as your own private App.

Refer to [How to Release your App](https://developer.supervisely.com/app-development/basics/from-script-to-supervisely-app) for all releasing details. For a private app check also [Private App Tutorial](https://developer.supervisely.com/app-development/basics/add-private-app).

In this tutorial we'll quickly observe the key concepts of our app.

### Repository structure

The structure of repository is the following:

```text
📦
├── 📜README.md
├── 📜config.json
├── 📜create_venv.sh
├── 📜requirements.txt
├── 📂docker
│   ├── 🐋Dockerfile
│   └── 📜publish.sh
├── 📜local.env
└── 📂src
    ├── 📜models.json
    ├── 📜inference_settings.yaml
    ├── 📜app_options.yaml
    └── 🐍main.py
    └── 🐍custom_yolo.py
```

Explanation:

- `src/main.py` - main inference script
- `src/models.json` - file with model configurations
- `src/inference_settings.yaml` - file with inference settings
- `src/app_options.yaml` - file with additional app options
- `README.md` - readme of your application, it is the main page of an application in Ecosystem with some images, videos, and how-to-use guides
- `config.json` - configuration of the Supervisely application, which defines the name and description of the app, its context menu, icon, poster, and running settings
- `create_venv.sh` - creates a virtual environment, installs detectron2 and requirements.
- `requirements.txt` - all needed packages, avoid using this file if possible, we recommend to install all dependencies in the Dockerfile.
- `local.env` - file with env variables used for debugging
- `docker` - directory with the custom Dockerfile for this application and the script that builds it and publishes it to the docker registry

### App configuration

App configuration is stored in `config.json` file. A detailed explanation of all possible fields is covered in this [Configuration Tutorial](https://developer.supervisely.com/app-development/basics/app-json-config/config.json). Let's check the config for our current app:

```json
{
  "type": "app",
  "version": "2.0.0",
  "name": "Serve custom YOLO",
  "description": "Custom object detection model integration",
  "categories": [
    "neural network",
    "images",
    "object detection",
    "serve",
    "development"
  ],
  "session_tags": ["deployed_nn"],
  "need_gpu": true,
  "community_agent": false,
  "docker_image": "user/custom-yolo:1.0.0",
  "entrypoint": "python -m uvicorn src.main:model.app --host 0.0.0.0 --port 8000",
  "port": 8000,
  "headless": true
}
```

Here is an explanation for the fields:

- `type` - type of the module in Supervisely Ecosystem
- `version` - version of Supervisely App Engine. Just keep it by default
- `name` - the name of the application
- `description` - the description of the application
- `categories` - these tags are used to place the application in the correct category in Ecosystem.
- `session_tags` - these tags will be assigned to every running session of the application. They can be used by other apps to find and filter all running sessions
- `"need_gpu": true` - should be true if you want to use any `cuda` devices.
- `"community_agent": false` - this means that this app can not be run on the agents started by Supervisely team, so users have to connect their own computers and run the app only on their own agents. Only applicable in Community Edition. Enterprise customers use their private instances so they can ignore current option
- `docker_image` - Docker container will be started from the defined Docker image, github repository will be downloaded and mounted inside the container.
- `entrypoint` - the command that starts our application in a container
- `port` - port inside the container
- `"headless": true` means that the app has no User Interface
