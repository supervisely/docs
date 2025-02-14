# Deploy & Predict with Supervisely SDK

This section involves using Python code together with [Supervisely SDK](https://github.com/supervisely/supervisely) to automate deployment and inference in different scenarios and environments. You can deploy your models either inside the Supervisely Platform (on an agent), or outside the platform, directly on your local machine. See the difference in [Overview](overview.md#in-platform-model-deployment-vs-local-deployment).

## In-Platform Model Deployment

### 1. Deploy

In-platform deployment is similar to manually launching a [Serving App](./supervisely-serving-apps.md) on the Supervisely Platform. With python SDK you can automate this.

{% hint style="info" %}

This method only works for your models trained in Supervisely and stored in Team Files. It also requires Supervisely SDK version `6.73.305` or higher.

{% endhint %}

**Here's how to do it:**

1. Install supervisely SDK if not installed.

```bash
pip install supervisely>=6.73.305
```

2. Go to Team Files and copy the path to your model artifacts (`artifacts_dir`).

![Copy path to artifacts dir](/.gitbook/assets/neural-networks/artifacts_dir.png)

3. Run this code to deploy a model on the platform. Don't forget to fill in your `workspace_id` and `artifacts_dir`.

```python
import os
import supervisely as sly
from dotenv import load_dotenv

# Ensure you've set API_TOKEN and SERVER_ADDRESS environment variables.
load_dotenv(os.path.expanduser("~/supervisely.env"))

api = sly.Api()

# ⬇ Put your workspace_id and artifacts_dir.
workspace_id = 123
artifacts_dir = "/experiments/27_Lemons/265_RT-DETRv2/"

# Deploy model
task_id = api.task.deploy_custom_model(workspace_id, artifacts_dir)
```

### 2. Predict

Any model deployed on the platform (both manually and through the code) works as a service and can accept API requests for inference. After you deployed a model on the platform, connect to it, and get predictions using `Session` class:

{% hint style="info" %}

Learn more about SessionAPI in the [Inference API Tutorial](https://developer.supervisely.com/app-development/neural-network-integration/inference-api-tutorial).

{% endhint %}

```python
from supervisely.nn.inference import Session

# Create Inference Session
# task_id was returned from the previous code
session = sly.nn.inference.Session(api, task_id=task_id)

# Predict Image
image_id = 123  # ⬅ put your image_id from a platform
prediction = session.inference_image_id(image_id)

# Predict Project
project_id = 123  # ⬅ put your project_id from a platform
predictions = session.inference_project_id(project_id)
```

## Deploy outside of Supervisely

In this section you will deploy a model locally on your machine, outside of Supervisely Platform. In the case of deployment outside of the platform, you don't have the [advantages of the Ecosystem](overview.md#in-platform-model-deployment-vs-local-deployment), but you get more freedom in how your model will be used in your code. This is a more advanced variant, it can slightly differ from one model to another, because you need to set up python environment by yourself, but the main code of loading model and getting predictions will be the same.

There are several variants of how you can use a model locally:

* **[Load and Predict in Your Code](#load-and-predict-in-your-code)**: Load your checkpoint and get predictions in your code or in a script.
* **[Deploy Model as a Server](#deploy-model-as-a-server)**: Deploy your model as a server on your machine, and interact with it through API requests.
  * **[🐋 Deploy in Docker Container](#deploy-in-docker-container)**: Deploy model as a server in a docker container on your local machine.
* **[Deploy Model as a Serving App with web UI](#deploy-model-as-a-serving-app-with-web-ui)**: Deploy model as a server with a web UI and interact with it through API. ❓ - This feature is mostly for debugging and testing purposes.

### Load and Predict in Your Code

This example shows how to load your checkpoint and get predictions in any of your code. RT-DETRv2 is used in this example, but the instructions are similar for other models.

#### 1. Clone repository

Clone our [RT-DETRv2](https://github.com/supervisely-ecosystem/RT-DETRv2) fork with the model implementation.

```bash
git clone https://github.com/supervisely-ecosystem/RT-DETRv2
cd RT-DETRv2
```

#### 2. Set up environment

Install [requirements.txt](https://github.com/supervisely-ecosystem/RT-DETRv2/blob/main/rtdetrv2_pytorch/requirements.txt) manually, or use our pre-built docker image ([DockerHub](https://hub.docker.com/r/supervisely/rt-detrv2/tags) | [Dockerfile](https://github.com/supervisely-ecosystem/RT-DETRv2/blob/main/docker/Dockerfile)). Additionally, you need to install Supervisely SDK.

```bash
pip install -r rtdetrv2_pytorch/requirements.txt
pip install supervisely
```

#### 3. Download checkpoint

Download your checkpoint and model files from Team Files.

![Download checkpoint from Team Files](/.gitbook/assets/deploy-predict-download-local.png)

#### 4. Predict

Create `main.py` file in the root of the repository and paste the following code:

```python
import numpy as np
from PIL import Image
import os
import supervisely as sly
from supervisely.nn import ModelSource, RuntimeType

# Be sure you are in the root of the RT-DETRv2 repository
from supervisely_integration.serve.rtdetrv2 import RTDETRv2

# Put your path to image here
IMAGE_PATH = "sample_image.jpg"

# Model config and weights (downloaded from Team Files)
model_files = {
    "checkpoint": "model/rtdetrv2_r18vd_120e_coco_rerun_48.1.pth",
    "config": "model/rtdetrv2_r18vd_120e_coco.yml",
}

# JSON model meta with class names (downloaded from Team Files)
model_meta = sly.io.json.load_json_file("model/model_meta.json")

# Load model
model = RTDETRv2()
model.load_custom_checkpoint(
    model_files=model_files,
    model_meta=model_meta,
    device="cuda",
)

# Load image
image = Image.open(IMAGE_PATH).convert("RGB")
img = np.array(image)

# Predict
ann = model.inference(img, settings={"confidence_threshold": 0.5})

# Draw predictions
ann.draw_pretty(img)
Image.fromarray(img).save("prediction.jpg")
```

This code will load the model, predict the image, and save the result to `prediction.jpg`.

If you need to run the code in your project and not in the root of the repository, you can add the path to the repository into `PYTHONPATH`, or by the following lines at the beginning of the script:

```python
import sys
sys.path.append("/path/to/RT-DETRv2")
```

### Deploy Model as a Server

In this variant, you will deploy a model locally as an API Server with the help of Supervisely SDK. The server will be ready to process API request for inference. It allows you to predict with local images, folders, videos, or remote supervisely projects and datasets (if you provided your Supervisely API token).

#### 1. Clone repository

Clone our [RT-DETRv2](https://github.com/supervisely-ecosystem/RT-DETRv2) fork with the model implementation.

```bash
git clone https://github.com/supervisely-ecosystem/RT-DETRv2
cd RT-DETRv2
```

#### 2. Set up environment

Install [requirements](https://github.com/supervisely-ecosystem/RT-DETRv2/blob/main/rtdetrv2_pytorch/requirements.txt) manually, or use our pre-built docker image ([DockerHub](https://hub.docker.com/r/supervisely/rt-detrv2/tags) | [Dockerfile](https://github.com/supervisely-ecosystem/RT-DETRv2/blob/main/docker/Dockerfile)).

```bash
pip install -r rtdetrv2_pytorch/requirements.txt
pip install supervisely
```

#### 3. Download checkpoint (optional)

{% hint style="info" %}

You can skip this step and pass a remote path to checkpoint in Team Files.

{% endhint %}

Download your checkpoint, model files and `experiment_info.json` from Team Files or the whole artifacts directory.

![Download checkpoint from Team Files](/.gitbook/assets/deploy-predict-download-local-serve.png)

You can place downloaded files in the folder within app repo, for example you can create `models` folder inside root directory of the repository and place all files there.

Your repo should look like this:

```plaintext
📦app-repo-root
 ┣ 📂models
 ┃ ┗ 📂392_RT-DETRv2
 ┃   ┣ 📂checkpoints
 ┃   ┃ ┗ 🔥best.pth
 ┃   ┣ 📜experiment_info.json
 ┃   ┣ 📜model_config.yml
 ┃   ┗ 📜model_meta.json
 ┗ ... other app repository files
```

#### 4. Deploy

To deploy, use `main.py` script to start the server. You need to pass the path to your checkpoint file or the name of the pretrained model using `--model` argument. Like in the previous example, you need to add the path to the repository into `PYTHONPATH`.

```bash
PYTHONPATH="${PWD}:${PYTHONPATH}" \
python ./supervisely_integration/serve/main.py \
--model "models/392_RT-DETRv2/checkpoints/best.pth"
```

This command will start the server on [http://0.0.0.0:8000](http://0.0.0.0:8000) and will be ready to accept API requests for inference.

**If you are a VSCode user you can use the following configurations for your `launch.json` file:**

```json
{
    "version": "0.2.0",
    "configurations": [
    {
      "name": "Local Deploy with local directory",
      "type": "debugpy",
      "request": "launch",
      "program": "${workspaceFolder}/supervisely_integration/serve/main.py",
      "console": "integratedTerminal",
      "justMyCode": false,
      "args": [
        "--model",
        "models/392_RT-DETRv2/checkpoints/best.pth",
      ],
      "env": {
        "PYTHONPATH": "${workspaceFolder}:${PYTHONPATH}",
        "LOG_LEVEL": "DEBUG"
      }
    },
    {
      "name": "Local Deploy with remote directory",
      "type": "debugpy",
      "request": "launch",
      "program": "${workspaceFolder}/supervisely_integration/serve/main.py",
      "console": "integratedTerminal",
      "justMyCode": false,
      "args": [
        "--model",
        "/experiments/27_Lemons/392_RT-DETRv2/checkpoints/best.pth",
      ],
      "env": {
        "PYTHONPATH": "${workspaceFolder}:${PYTHONPATH}",
        "LOG_LEVEL": "DEBUG",
        "TEAM_ID": "4",
      }
    }
    ]
}
```

#### 5. Predict

After the model is deployed, use Supervisely [Inference Session API](https://developer.supervisely.com/app-development/neural-network-integration/inference-api-tutorial) with setting server address to [http://0.0.0.0:8000](http://0.0.0.0:8000).

```python
import os
from dotenv import load_dotenv
import supervisely as sly

load_dotenv(os.path.expanduser("~/supervisely.env"))
api = sly.Api()

# Create Inference Session
session = sly.nn.inference.Session(api, session_url="http://0.0.0.0:8000")

# local image
pred = session.inference_image_path("image_01.jpg")

# batch of images
pred = session.inference_image_paths(["image_01.jpg", "image_02.jpg"])

# remote image on the platform
pred = session.inference_image_id(17551748)
pred = session.inference_image_ids([17551748, 17551750])

# image url
url = "https://images.unsplash.com/photo-1674552791148-c756b0899dba?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80"
pred = session.inference_image_url(url)
```

#### Predict with CLI arguments

Instead of writing code for inference, you can use CLI arguments to get predictions right after the model is loaded. The following arguments are available:

- `--model` - **(required)** a path to your local checkpoint file, or remote path in Team Files. Also, it can be a name of a pre-trained model from [models.json](../custom-model-integration/integrate-custom-training.md#1-prepare-model-configurations) file.
- `--predict-project` - ID of Supervisely project to predict. A new project with predictions will be created on the platform.
- `--predict-dataset` - ID(s) of Supervisely dataset(s) to predict. A new project with predictions will be created on the platform.
- `--predict-image` - path to a local image or image ID in Supervisely.

{% hint style="info" %}

Server will shut down automatically after the prediction is done.

{% endhint %}

<!-- - `--predict` ❌ - a universal argument for input. It can be a local path to image, directory of images, or video.
- `--output` ❌ - a local directory where predictions will be saved.
- `--predict-dir` ❌ - path to a local directory with images to predict. Predictions will be saved in the same directory in Supervisely JSON annotation format.
- `--predict-video` ❌ - path to a local video file. -->

Example usage:

```bash
PYTHONPATH="${PWD}:${PYTHONPATH}" \
python ./supervisely_integration/serve/main.py \
--model "RT-DETRv2-S" \
--predict-image "supervisely_integration/demo/img/coco_sample.jpg"
```

#### 🐋 Deploy in Docker Container

Deploying in a Docker Container is similar to deployment as a Server. This example is useful when you need to run your model on a remote machine or in a cloud environment.

Use this `docker run` command:

```bash
docker run \
  --shm-size=1g \
  --runtime=nvidia \
  --env-file ~/supervisely.env \
  --env PYTHONPATH=/app \
  -v ".:/app" \
  -w /app \
  -p 8000:8000 \
  supervisely/rt-detrv2:1.0.8 \
  python3 supervisely_integration/serve/main.py \
  --model "/experiments/27_Lemons/392_RT-DETRv2/checkpoints/best.pth"
```

You can also use `docker-compose.yml` file to run the container:

```yaml
services:
  rtdetrv2:
    image: supervisely/rt-detrv2:1.0.8
    shm_size: 1g
    runtime: nvidia
    env_file:
      - ~/supervisely.env
    environment:
      - PYTHONPATH=/app
    volumes:
      - .:/app
    working_dir: /app
    ports:
      - "8000:8000"
    expose:
      - "8000"
    entrypoint: [ "python3", "supervisely_integration/serve/main.py" ]
    command: [ "--model", "/experiments/27_Lemons/392_RT-DETRv2/checkpoints/best.pth" ]
```

In the last line, you need to pass the argument for model checkpoint and, optionally, other arguments for prediction (see the [previous](#deploy-model-as-a-server) section).

Put your path to the checkpoint file in the `--model` argument.

This will start the server on [http://0.0.0.0:8000](http://0.0.0.0:8000) in the container and will be ready to accept API requests for inference. You can use the same `Session` object for inference.

### Deploy Model as a Serving App with web UI

In this variant, you will run a full [Serving App](supervisely-serving-apps.md) with web UI, in which you can deploy a model. This is useful for debugging and testing purposes, for example, when you're integrating your [Custom Inference App](../custom-model-integration/integrate-custom-inference.md) with the Supervisely Platform.

Follow the steps from the [previous](#deploy-model-as-a-server) section, but instead of running the server, you need to run the following command:

#### Deploy

Run the following command to start the app server:

```bash
uvicorn main:model.app --app-dir supervisely_integration/serve --host 0.0.0.0 --port 8000 --ws websockets
```

After the app is started, you can open the web UI [http://localhost:8000](http://localhost:8000), and deploy a model through the web interface.

#### Predict

Use the same [SessionAPI](https://developer.supervisely.com/app-development/neural-network-integration/inference-api-tutorial) to get predictions with the server address [http://localhost:8000](http://localhost:8000).

```python
import os
from dotenv import load_dotenv
import supervisely as sly

load_dotenv(os.path.expanduser("~/supervisely.env"))
api = sly.Api()

# Create Inference Session
session = sly.nn.inference.Session(api, session_url="http://localhost:8000")

# local image
pred = session.inference_image_path("image_01.jpg")

# batch of images
pred = session.inference_image_paths(["image_01.jpg", "image_02.jpg"])

# remote image on the platform
pred = session.inference_image_id(17551748)
pred = session.inference_image_ids([17551748, 17551750])

# image url
url = "https://images.unsplash.com/photo-1674552791148-c756b0899dba?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80"
pred = session.inference_image_url(url)
```
