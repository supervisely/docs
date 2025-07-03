# Deploy & Predict with Supervisely SDK

This section involves using Python code together with [Supervisely SDK](https://github.com/supervisely/supervisely) to automate deployment and inference in different scenarios and environments. Supervisely also has a convenient [Prediction API](prediction-api.md) that allows you to deploy models and get predictions in a couple of lines of code (check our [Tutorial](prediction-api.md)).
In this tutorial you will deploy models directly on your local machine. This is a more advanced variant, it can slightly differ from one model to another, because you need to set up python environment by yourself, but the main code of loading model and getting predictions will be the same.

There are several variants of how you can use a model locally:

* **[Load and Predict in Your Code](#load-and-predict-in-your-code)**: Load your checkpoint and get predictions in your code or in a script.
* **[Deploy Model as a Server](#deploy-model-as-a-server)**: Deploy your model as a server on your machine, and interact with it through API requests.
* **[🐋 Deploy in Docker Container](#deploy-in-docker-container)**: Deploy model as a server in a docker container on your local machine.
* **[Deploy Model as a Serving App with web UI](#deploy-model-as-a-serving-app-with-web-ui)**: Deploy model as a server with a web UI and interact with it through API. ❓ - This feature is mostly for debugging and testing purposes.

## Load and Predict in Your Code

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

## Deploy Model as a Server

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
python ./supervisely_integration/serve/main.py deploy \
--model "./models/392_RT-DETRv2/checkpoints/best.pth"
```

This command will start the server on [http://0.0.0.0:8000](http://0.0.0.0:8000) and will be ready to accept API requests for inference.

**Arguments description**

- `mode` - **(required)** mode of operation, can be `deploy` or `predict`.
- `--model` - name of a model from pre-trained models table (see [models.json](../custom-model-integration/integrate-custom-training.md#1-prepare-model-configurations)), or a path to your custom checkpoint file either local path or remote path in Team Files. If not provided the first model from the models table will be loaded.
- `--device` - device to run the model on, can be `cpu` or `cuda`.
- `--runtime` - runtime to run the model on, can be `PyTorch`, `ONNXRuntime` or `TensorRT` if supported.
- `--settings` - inference settings, can be a path to a `.json`, `yaml`, `yml` file or a list of key-value pairs e.g. `--settings confidence_threshold=0.5`.

```bash
PYTHONPATH="${PWD}:${PYTHONPATH}" \
python ./supervisely_integration/serve/main.py deploy \
  --model "RT-DETRv2-S" \
  --device cuda \
  --settings confidence_threshold=0.5
```

For custom model use the path to the checkpoint file:

```bash
PYTHONPATH="${PWD}:${PYTHONPATH}" \
python ./supervisely_integration/serve/main.py deploy \
  --model "./models/392_RT-DETRv2/checkpoints/best.pth" \
  --device cuda \
  --settings confidence_threshold=0.5
```


**If you are a VSCode user you can use the following configurations for your `launch.json` file:**

<details>
<summary> <b> .vscode/launch.json </b> </summary>

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
        "deploy",
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
        "deploy",
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
</details>

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

##### Predict with CLI

Instead of using the `Session`, you can deploy and predict in one command.

```bash
PYTHONPATH="${PWD}:${PYTHONPATH}" \
python ./supervisely_integration/serve/main.py predict "./image.jpg"
```

You can predict both local images or data on Supervisely platform. By default predictions will be saved to `./predictions` directory, you can change it with `--output` argument.

To predict data on the platform use one of the following arguments:

- `--project_id` - id of Supervisely project to predict. If use `--upload` a new project with predictions will be created on the platform.
- `--dataset_id` - id(s) of Supervisely dataset(s) to predict e.g. `--dataset_id "505,506"`. If use `--upload` a new project with predictions will be created on the platform.
- `--image_id` - id of Supervisely image to predict. If `--upload` is passed, prediction will be added to the provided image.

You can specify additional settings:

- `--output` - a local directory where predictions will be saved.
- `--upload` - upload predictions to the platform. Works only with: `--project_id`, `--dataset_id`, `--image_id`.
- `--draw` - save image with prediction visualization in `--output-dir`. Works only with: `input` and `--image_id`.

**Example to predict with CLI arguments:**

```bash
PYTHONPATH="${PWD}:${PYTHONPATH}" \
python ./supervisely_integration/serve/main.py predict \
  "./image.jpg" \
  --model "RT-DETRv2-S" \
  --device cuda \
  --settings confidence_threshold=0.5
```

{% hint style="info" %}

Server will shut down automatically after the prediction is done.

{% endhint %}

## 🐋 Deploy in Docker Container

Deploying in a Docker Container is similar to deployment as a Server. This example is useful when you need to run your model on a remote machine or in a cloud environment.

Use this `docker run` command to deploy a model in a docker container (RT-DETRv2 example):

```bash
docker run \
  --shm-size=1g \
  --runtime=nvidia \
  --env-file ~/supervisely.env \
  --env PYTHONPATH=/app \
  -v ".:/app" \
  -w /app \
  -p 8000:8000 \
  supervisely/rt-detrv2:1.0.11 \
  python3 supervisely_integration/serve/main.py deploy \
  --model "/experiments/27_Lemons/392_RT-DETRv2/checkpoints/best.pth"
```

Put your path to the checkpoint file in the `--model` argument (it can be both the local path or a remote path in Team Files). This will start FastAPI server and load the model for inference. The server will be available on [http://localhost:8000](http://localhost:8000).

#### docker compose

You can also use `docker-compose.yml` file for convenience:

```yaml
services:
  rtdetrv2:
    image: supervisely/rt-detrv2:1.0.11
    shm_size: 1g
    runtime: nvidia
    env_file:
      - ~/supervisely.env # Optional, use only for predictions on the platform
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
    command: [ "deploy", "--model", "./models/392_RT-DETRv2/checkpoints/best.pth" ]
```

#### Predict

After the model is deployed, you can use the `Session` object for inference ([Inference Session API](https://developer.supervisely.com/app-development/neural-network-integration/inference-api-tutorial)) or use CLI arguments to get predictions.

#### Deploy and Predict with CLI arguments

You can use the same arguments as seen in the previous [deploy](#4-deploy) and [predict](#predict-with-cli) sections for running docker container.

Example to deploy model as a server:

```bash
docker run \
  --shm-size=1g \
  --runtime=nvidia \
  --env-file ~/supervisely.env \
  --env PYTHONPATH=/app \
  -v ".:/app" \
  -w /app \
  -p 8000:8000 \
  supervisely/rt-detrv2:1.0.11 \
  python3 supervisely_integration/serve/main.py deploy \
  --model "RT-DETRv2-S"
```

Example to predict with CLI arguments:

```bash
docker run \
  --shm-size=1g \
  --runtime=nvidia \
  --env-file ~/supervisely.env \
  --env PYTHONPATH=/app \
  -v ".:/app" \
  -w /app \
  -p 8000:8000 \
  supervisely/rt-detrv2:1.0.11 \
  python3 supervisely_integration/serve/main.py \
  predict "./image.jpg" \
  --model "RT-DETRv2-S" \
  --device cuda \
  --settings confidence_threshold=0.5
```

{% hint style="info" %}

Container will be stopped automatically after the prediction is done.

{% endhint %}

## Deploy Model as a Serving App with web UI

In this variant, you will run a full [Serving App](supervisely-serving-apps.md) with web UI, in which you can deploy a model. This is useful for debugging and testing purposes, for example, when you're integrating your [Custom Inference App](../custom-model-integration/integrate-custom-inference.md) with the Supervisely Platform.

Follow the steps from the [previous](#deploy-model-as-a-server) section, but instead of running the server, you need to run the following command:

#### Deploy

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
