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
prediction = model.inference_image_id(image_id=123)
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


## Deploy outside of Supervisely

In this section you will deploy a model locally on your machine, outside of Supervisely Platform. In the case of deployment outside of the platform, you don't have the [advantages of the Ecosystem](overview.md#in-platform-model-deployment-vs-local-deployment), but you get more freedom in how your model will be used in your code. This is a more advanced variant, it can slightly differ from one model to another, because you need to set up python environment by yourself, but the main code of loading model and getting predictions will be the same.

There are several variants of how you can use a model locally:

* **[Load and Predict in Your Code](#load-and-predict-in-your-code)**: Load your checkpoint and get predictions in your code or in a script.
* **[Deploy Model as a Server](#deploy-model-as-a-server)**: Deploy your model as a server on your machine, and interact with it through API requests.
  * **[🐋 Deploy in Docker Container](#deploy-in-docker-container)**: Deploy model as a server in a docker container on your local machine.
* **[Deploy Model as a Serving App with web UI](#deploy-model-as-a-serving-app-with-web-ui)**: Deploy model as a server with a web UI, and interact with it through API. ❓ This feature is mostly for debugging and testing of Serving Apps.

### Load and Predict in Your Code

This example shows how to load your checkpoint and get predictions in any of your code. The instructions are similar for other models.

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
from supervisely.nn import ModelSource, RuntimeType
from PIL import Image
import os

# Be sure you are in the root of the RT-DETRv2 repository
from supervisely_integration.serve.rtdetrv2 import RTDETRv2


# Put path to your image here
IMAGE_PATH = "sample_image.jpg"

# Load model
model = RTDETRv2()
# ❌ need fix: use of private method
model._load_model_headless(
    model_files={
        "config": "rtdetrv2_r18vd_120e_coco.yml",
        "checkpoint": os.path.expanduser("~/.cache/supervisely/checkpoints/rtdetrv2_r18vd_120e_coco_rerun_48.1.pth"),
    },
    model_info=model_info,
    model_source=ModelSource.CUSTOM,
    device="cuda",
    runtime=RuntimeType.PYTORCH,
)

# Load image
image = Image.open(IMAGE_PATH).convert("RGB")
img = np.array(image)

# Predict
# ❌ need fix: use of private method
ann = model._inference_auto([img], {"confidence_threshold": 0.5})[0][0]

# Draw predictions
ann.draw_pretty(img)
Image.fromarray(img).save("prediction.jpg")
```

If you need to run the code in your project and not in the root of the repository, you can add the path to the repository into PYTHONPATH, or by the following lines of the beginning of the script:

```python
import sys
sys.path.append("/path/to/RT-DETRv2")
```


### Deploy Model as a Server

#### 🐋 Deploy in Docker Container

### Deploy Model as a Serving App with web UI

