# Model API

The `ModelAPI` class is used to interact with a model's server, which can be running either in Supervisely, or on a local machine. It provides methods for running inference, loading checkpoints, and managing the model's configuration.

## Deploy & Connect

To deploy a new model, use the `api.nn.deploy()` method. This method will start a new Serving App in Supervisely, deploy a given model, and return a `ModelAPI` object for running predictions.

### Deploy custom checkpoint

To deploy your checkpoint trained in Supervisely, you need to provide the path to the checkpoint in Team Files. The checkpoint can be in PyTorch format, ONNX format (`.onnx`), or TensorRT format (`.engine`).

{% tabs %}
{% tab title="Custom checkpoint" %}
```python
import supervisely as sly

api = sly.Api()

# Deploy your checkpoint trained in Supervisely
model = api.nn.deploy(
    checkpoint="/path/in/team_files/checkpoint.pt",  # Path to your checkpoint in Team Files
)
```
{% endtab %}
{% tab title="ONNX Runtime" %}
```python
import supervisely as sly

api = sly.Api()

# Use ONNX checkpoint
model = api.nn.deploy(
    checkpoint="/path/in/team_files/model.onnx",  # Path to ONNX checkpoint in Team Files
)
```
{% endtab %}
{% tab title="TensorRT" %}
```python
import supervisely as sly

api = sly.Api()

# Use TensorRT checkpoint
model = api.nn.deploy(
    checkpoint="/path/in/team_files/model.engine",  # Path to TensorRT checkpoint in Team Files
)
```
{% endtab %}
{% endtabs %}

### Deploy pretrained checkpoint

To deploy a pretrained model, you need to specify two arguments - `framework` and `pretrained_model`. The framework should match the name of the corresponding Serving App in Supervisely, and the model name should be one of the pretrained models from the models' table in the Serving App. You can Specify `runtime` argument to convert the model to ONNX or TensorRT before deploying.

{% tabs %}
{% tab title="Pretrained checkpoint" %}
```python
import supervisely as sly

api = sly.Api()

# Deploy a pretrained model
model = api.nn.deploy(
    framework="RT-DETRv2",    # Name of the corresponding Serving App in Supervisely
    pretrained_model="RT-DETRv2-S"  # Model name from a table of pretrained models in the Serving App
)
```
{% endtab %}
{% tab title="Convert to ONNX" %}
```python
import supervisely as sly

api = sly.Api()

# ONNX Runtime
model = api.nn.deploy(
    framework="RT-DETRv2",     # Name of the corresponding Serving App in Supervisely
    pretrained_model="RT-DETRv2-S",  # Model name from a table of pretrained models in the Serving App
    runtime="onnx",            # Will convert the model to ONNX before deploying
)
```
{% endtab %}
{% tab title="Convert to TensorRT" %}
```python
import supervisely as sly

api = sly.Api()

# TensorRT
model = api.nn.deploy(
    framework="RT-DETRv2",     # Name of the corresponding Serving App in Supervisely
    pretrained_model="RT-DETRv2-S",  # Model name from a table of pretrained models in the Serving App
    runtime="tensorrt",        # Will convert the model to TensorRT before deploying
)
```
{% endtab %}
{% endtabs %}

### Deploy arguments

A table with arguments for the `api.nn.deploy()` method:

| Argument | Type | Description |
| --- | --- | --- |
| `checkpoint` | `str` | Path to your checkpoint in Team Files. Can be PyTorch model (`.pt`), ONNX (`.onnx`), or TensorRT (`.engine`) format. Required when deploying a custom checkpoint. |
| `framework` | `str` | Name of the corresponding Serving App in Supervisely. Required when deploying a pretrained model. |
| `pretrained_model` | `str` | Name of the pretrained model from the models table in the Serving App. Required when deploying a pretrained model. |
| `device` | `str` | Device to run the model on, e.g., `"cuda:0"` or `"cpu"`. If not specified, will automatically use GPU device if available, otherwise CPU. |
| `runtime` | `str` | Runtime to convert the model to before deploying. Options: `"onnx"`, `"tensorrt"`. Used for pretrained checkpoints. |
| `agent_id` | `int` | ID of the Supervisely Agent (machine) that is connected to the Supervisely platform where the model should be deployed. Don't need to specify, if the only one agent is connected. |

#### Notes

- The `api.nn.deploy()` method will start a new Serving App in Supervisely, deploy the model, and return a `ModelAPI` object for running predictions.
- When deploying a custom checkpoint, you need to provide the `checkpoint` argument. When deploying a pretrained model, you need to provide both `framework` and `pretrained_model` arguments.
- The `runtime` argument is used when deploying a pretrained model.
- If `device` argument is not specified, the model will automatically use GPU device if available, otherwise CPU.
- 🔴🔴🔴 (on the fisrt, or on the only one?) If `agent_id` argument is not specified, the model will be deployed on the first available agent.


### Connect to deployed model

If your model is already deployed in Supervisely, you just need to connect to it using the `api.nn.connect()` method, providing a `task_id` of the running serving app. This method returns a `ModelAPI` object for running predictions. You can use `url` argument to directly connect to a model's FastAPI server, bypassing the `task_id` argument.

{% tabs %}
{% tab title="Model in Supervisely" %}
```python
import supervisely as sly

api = sly.Api()

# Connect to a deployed model in Supervisely
model = api.nn.connect(
    task_id=122,  # Task ID of a running app in Supervisely
)
```
{% endtab %}
{% tab title="Local model in Docker Container" %}
```python
🔴🔴🔴 from supervisely.nn import ModelAPI

# sly.Api is not needed
model = ModelAPI(
    url="http://localhost:8000",  # URL of a running model's server in Docker container
)
```
{% endtab %}
{% endtabs %}


#### Connect Arguments

A table with arguments for the `api.nn.connect()` method:

| Argument | Type | Description |
| --- | --- | --- |
| `task_id` | `int` | Task ID of a running Serving App in Supervisely. |
| `url` | `str` | A direct URL to the model's FastAPI server. If provided, `task_id` argument is ignored. |
| `api` | `sly.Api` | Optional, an instance of the Supervisely API. If not provided, a new instance will be created. |


## ModelAPI methods

The `ModelAPI` class provides methods for running inference, loading checkpoints, and managing the model's configuration.

### Predict

### Predict Detached

### Load checkpoint

{% tabs %}
{% tab title="Custom checkpoint" %}
```python
# Load custom checkpoint
model.load_checkpoint(
    checkpoint="/path/in/team_files/checkpoint.pt",  # Path to your checkpoint in Team Files
)
```
{% endtab %}
{% tab title="ONNX checkpoint" %}
```python
# Loading ONNX checkpoint
model.load_checkpoint(
    checkpoint="/path/in/team_files/model.onnx",  # Path to ONNX checkpoint in Team Files
)
```
{% endtab %}
{% tab title="TensorRT checkpoint" %}
```python
# Loading TensorRT checkpoint
model.load_checkpoint(
    checkpoint="/path/in/team_files/model.engine",  # Path to TensorRT checkpoint in Team Files
)
```
{% endtab %}
{% tab title="Pretrained checkpoint" %}
```python
# Load pretrained checkpoint
model.load_checkpoint(
    pretrained_model="RT-DETRv2-S",  # Name of the pretrained model
)
```
{% endtab %}
{% tab title="Convert to ONNX" %}
```python
# Load pretrained checkpoint and convert to ONNX
model.load_checkpoint(
    pretrained_model="RT-DETRv2-S",  # Name of the pretrained model
    runtime="onnx",                  # Will convert the model to ONNX before loading
)
```
{% endtab %}
{% tab title="Convert to TensorRT" %}
```python
# Load pretrained checkpoint and convert to TensorRT
model.load_checkpoint(
    pretrained_model="RT-DETRv2-S",  # Name of the pretrained model
    runtime="tensorrt",              # Will convert the model to TensorRT before loading
)
```
{% endtab %}
{% endtabs %}

#### Arguments

A table of arguments for the `ModelAPI.load_checkpoint()` method:

| Argument | Type | Description |
| --- | --- | --- |
| `checkpoint` | `str` | Path to your checkpoint in Team Files. Can be PyTorch model (`.pt`), ONNX (`.onnx`), or TensorRT (`.engine`) format. Used for loading a custom checkpoint. |
| `pretrained_model` | `str` | Name of the pretrained model from the models table in the Serving App. Used for loading a pretrained model. |
| `device` | `str` | Device to run the model on, e.g., `"cuda:0"` or `"cpu"`. If not specified, will automatically use GPU device if available, otherwise CPU. |
| `runtime` | `str` | Runtime to convert the model to before deploying. Options: `"onnx"`, `"tensorrt"`. Used for pretrained checkpoints. |
| `agent_id` | `int` | ID of the Supervisely Agent (machine) that is connected to the Supervisely platform where the model should be deployed. Don't need to specify, if the only one agent is connected. |

