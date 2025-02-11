# Deploy & Predict with Supervisely SDK

This section involves using Python code together with [Supervisely SDK](https://github.com/supervisely/supervisely) to automate deployment and inference in different scenarios and environments. You can deploy your models either inside the Supervisely Platform (on an agent), or outside the platform, directly on your local machine. See the difference in [Overview](overview.md#in-platform-model-deployment-vs-local-deployment).

## In-Platform Model Deployment

### 1. Deploy

In-platform deployment is similar to manually launching a Serving App on the Supervisely Platform. With python SDK you can automate this.

**Here's how to do it:**

1. Install supervisely SDK if not installed.

```
pip install supervisely
```

2. Run this code to deploy a model on the platform.

❌ *У нас еще нет метода deploy_model*

```python
from dotenv import load_dotenv
import os
import supervisely as sly
from supervisely.nn.deploy import deploy_model

# Ensure you've set API_TOKEN and SERVER_ADDRESS environment variables.
load_dotenv(os.path.expanduser("~/supervisely.env"))

model = deploy_model("your_experiment_name")
```

### 2. Predict

```python
# predict image
prediction = model.inference_image_id(image_id=123)

# predict project
predictions = model.inference_project_id(project_id=123)
```

Any model deployed on the platform (both manually and through the code) works as a service and can accept API requests for inference. So, if you manually served a model on the platform, connect to it, and get predictions using `Session` class:

```python
import supervisely as sly
from supervisely.nn.inference import Session

api = sly.Api()

# Create Inference Session
task_id = 123  # put task_id of a model deployed on the platform
session = sly.nn.inference.Session(api, task_id=task_id)

# Predict
image_id = 123  # put your image_id from a platform
prediction = session.inference_image_id(image_id)
```

Learn more about SessionAPI in the [Inference API Tutorial](https://developer.supervisely.com/app-development/neural-network-integration/inference-api-tutorial).

---

## Deploy outside of Supervisely

In this section you will deploy a model locally on your machine, outside of Supervisely Platform. In the case of deployment outside of the platform, you don't have the [advantages of the Ecosystem](overview.md#in-platform-model-deployment-vs-local-deployment), but you get more freedom in how your model will be used in your code. This is a more advanced variant, it can slightly differ from one model to another, because you need to set up python environment by yourself, but the main code of loading model and getting predictions will be the same.

There are several variants of how you can use a model locally:

* **[Load and Predict in Your Code](#load-and-predict-in-your-code)**: Load your checkpoint and get predictions in your code or in a script.
* **[Deploy Model as a Server](#deploy-model-as-a-server)**: Deploy your model as a server on your machine, and interact with it through API requests.
  * **[🐋 Deploy in Docker Container](#deploy-in-docker-container)**: Deploy model as a server in a docker container on your local machine.
* **[Deploy Model as a Serving App with web UI](#deploy-model-as-a-serving-app-with-web-ui)**: Deploy model as a server with a web UI and interact with it through API. ❓ This feature is mostly for debugging and testing of Serving Apps.


### Load and Predict in Your Code

This example shows how to load your checkpoint and get predictions in any of your code. RT-DETRv2 is used in this example, but the instructions are similar for other models.

1. **Clone** our [RT-DETRv2](https://github.com/supervisely-ecosystem/RT-DETRv2) fork with the model implementation.

```bash
git clone https://github.com/supervisely-ecosystem/RT-DETRv2
cd RT-DETRv2
```

2. **Set up environment:** Install [requirements](https://github.com/supervisely-ecosystem/RT-DETRv2/blob/main/rtdetrv2_pytorch/requirements.txt) manually, or use our pre-built docker image ([DockerHub](https://hub.docker.com/r/supervisely/rt-detrv2/tags) | [Dockerfile](https://github.com/supervisely-ecosystem/RT-DETRv2/blob/main/docker/Dockerfile)). Additionally, you need to install Supervisely SDK.

```bash
pip install -r rtdetrv2_pytorch/requirements.txt
pip install supervisely
```

3. **Download** your checkpoint and model files from Team Files.

![Download checkpoint from Team Files](https://github.com/user-attachments/assets/796bf915-fbaf-4e93-a327-f0caa51dced4)

4. **Predict:** Create `main.py` file in the root of the repository and paste the following code:

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


1. **Clone** our [RT-DETRv2](https://github.com/supervisely-ecosystem/RT-DETRv2) fork with the model implementation.

```bash
git clone https://github.com/supervisely-ecosystem/RT-DETRv2
cd RT-DETRv2
```

2. **Set up environment:**

Install [requirements](https://github.com/supervisely-ecosystem/RT-DETRv2/blob/main/rtdetrv2_pytorch/requirements.txt) manually, or use our pre-built docker image ([DockerHub](https://hub.docker.com/r/supervisely/rt-detrv2/tags) | [Dockerfile](https://github.com/supervisely-ecosystem/RT-DETRv2/blob/main/docker/Dockerfile)).

```bash
pip install -r rtdetrv2_pytorch/requirements.txt
pip install supervisely
```

3. **Download** (optional) your checkpoint and model files from Team Files. Or skip this step and pass a remote path to checkpoint in Team Files.

![Download checkpoint from Team Files](https://github.com/user-attachments/assets/796bf915-fbaf-4e93-a327-f0caa51dced4)

4. **Deploy:**

To deploy, use `main.py` script to start the server. You need to pass the path to your checkpoint file or the name of the pretrained model using `--model` argument. Like in the previous example, you need to add the path to the repository into `PYTHONPATH`.

```bash
PYTHONPATH="${PWD}:${PYTHONPATH}" python ./supervisely_integration/serve/main.py --model ./my_experiments/2315_RT-DETRv2/checkpoints/best.pth
```

This command will start the server on http://0.0.0.0:8000 and will be ready to accept API requests for inference.

5. **Predict**

After the model is deployed, use Supervisely [Inference Session API](https://developer.supervisely.com/app-development/neural-network-integration/inference-api-tutorial) with setting server address to http://0.0.0.0:8000.

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

- `--model` - **(required)** a path to your local checkpoint file, or remote path in Team Files. Also, it can be a name of a pre-trained model.
- `--predict` ❌ - a universal argument for input. It can be a local path to image, directory of images, or video.
- `--output` ❌ - a local directory where predictions will be saved.
- `--predict-image` - path to a local image.
- `--predict-dir` ❌ - path to a local directory with images to predict. Predictions will be saved in the same directory in Supervisely JSON annotation format.
- `--predict-video` ❌ - path to a local video file.
- `--predict-project` - ID of Supervisely project to predict. A new project with predictions will be created on the platform.
- `--predict-dataset` - ID(s) of Supervisely dataset(s) to predict. A new project with predictions will be created on the platform.

Example usage:

```bash
PYTHONPATH="${PWD}:${PYTHONPATH}" python ./supervisely_integration/serve/main.py --model ./my_experiments/2315_RT-DETRv2/checkpoints/best.pth --predict ./supervisely_integration/demo/images
```

🔎 **Нужен отдельный туториал по аргументам на dev portal, и отсюда сделать ссылку туда.**

#### 🐋 Deploy in Docker Container

Deploying in a Docker Container is similar to deployment as a Server. This example is useful when you need to run your model on a remote machine or in a cloud environment.

Use this docker run command:

❌ тут нужно еще с Пашей проверить, что все аргументы рабочие. Пока что примерный список:

```bash
docker run \
  --shm-size=1g \
  --runtime=nvidia \
  --env ENV=production \
  --env PYTHONPATH="${PYTHONPATH}:/app/supervisely_integration/serve" \
  -v ".:/app" \
  -w /app \
  -p 8000:8000 \
  supervisely/rt-detrv2:1.0.7 \
  python3 supervisely_integration/serve/main.py \
    --model "/experiments/553_42201_Animals/2315_RT-DETRv2/checkpoints/best.pth"
```

In the last line, you need to pass the argument for model checkpoint and, optionally, other arguments for prediction (see the [previous](#deploy-model-as-a-server) section).
This will start the server on http://0.0.0.0:8000 in the container and will be ready to accept API requests for inference. You can use the same SessionAPI to get predictions.


### Deploy Model as a Serving App with web UI

In this variant, you will start a [Serving App](supervisely-serving-apps.md) with web UI, in which you can deploy a model.

You need to follow all the steps from the [previous](#deploy-model-as-a-server) section, but instead of running the server, you need to run the following command:

**Deploy:**

```bash
uvicorn main:model.app --app-dir supervisely_integration/serve --host 0.0.0.0 --port 8000 --ws websockets
```
After the app is started, you can open the web UI http://localhost:8000, and deploy a model through the web interface.

**Predict:** Use the same [SessionAPI](https://developer.supervisely.com/app-development/neural-network-integration/inference-api-tutorial) to get predictions with the server address http://localhost:8000.

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
