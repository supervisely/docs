# Deploy & Predict with Supervisely Python SDK

This section involves using Python code together with [Supervisely SDK](https://github.com/supervisely/supervisely) to automate deployment and inference in different scenarios and environments. You can deploy either inside the Supervisely Platform on an agent, or outside the platform, directly on your local machine. See the difference in [Overview](overview.md#in-platform-model-deployment-vs-local-deployment). If you need to completely decouple your code from Supervisely SDK, see [Using Standalone PyTorch Models](using-standalone-pytorch-models.md).

## In-Platform Model Deployment

### 1. Deploy

In case of in-platform deployment, running the model will be similar to manually launching the Serving App on the Supervisely Platform. With python SDK you can automate this.

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

Any model deployed on the platform (both manually and through code) works as a service and can accept API requests for inference. So, if you manually served a model on the platform, connect to it, and get predictions using `Session` class:

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

In this section you will deploy a model locally on your machine, outside of Supervisely Platform. In the case of deployment outside of the platform, you don't have the advantages of the Ecosystem, but you get more freedom in how your model will be used in your code.

### How to Use Your Model in Code

This example shows you a simple way to load your checkpoint and get predictions.

pip install supervisely

pip install -r requirements.txt

\<code example\>

### About nn.Inference

### Deploy Model as a Service

