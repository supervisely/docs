# Model API

The `ModelAPI` class is used to interact with a model's server. It provides methods for running inference, loading checkpoints, managing model settings and accessing information about current model. The model's server can be running either in Supervisely, or on a local machine, and the `ModelAPI` class provides a unified interface for both cases.

## Deploy & Connect

To deploy a new model, use the `api.nn.deploy()` method. This method will start a new Serving App in Supervisely, deploy a given model, and return a `ModelAPI` object for running predictions.

### Deploy custom checkpoint

To deploy your checkpoint trained in Supervisely, provide the path to a checkpoint file in Team Files using `model=` argument. The checkpoint can be in PyTorch format, ONNX format (`.onnx`), or TensorRT format (`.engine`). The model will be deployed in an optimized runtime if the checkpoint is in ONNX or TensorRT format.

{% tabs %}
{% tab title="Custom checkpoint" %}
```python
import supervisely as sly

api = sly.Api()

# Deploy your checkpoint trained in Supervisely
model = api.nn.deploy(
    model="/path/in/team_files/checkpoint.pt",  # Path to your checkpoint in Team Files
)
```
{% endtab %}
{% tab title="ONNX Runtime" %}
```python
import supervisely as sly

api = sly.Api()

# Use ONNX checkpoint
model = api.nn.deploy(
    model="/path/in/team_files/model.onnx",  # Path to ONNX checkpoint in Team Files
)
```
{% endtab %}
{% tab title="TensorRT" %}
```python
import supervisely as sly

api = sly.Api()

# Use TensorRT checkpoint
model = api.nn.deploy(
    model="/path/in/team_files/model.engine",  # Path to TensorRT checkpoint in Team Files
)
```
{% endtab %}
{% tab title="Convert to TensorRT" %}
```python
import supervisely as sly

api = sly.Api()

# Using pytorch checkpoint and convert to TensorRT
model = api.nn.deploy(
    model="/path/in/team_files/checkpoint.pt",  # Path to your checkpoint in Team Files
    runtime="tensorrt",  # Will convert the model to TensorRT, this will take some time
)
```
{% endtab %}
{% endtabs %}

### Deploy pretrained checkpoint

To deploy a pretrained model, specify the `model=` argument in the format `framework/model_name`, for example, `"RT-DETRv2/RT-DETRv2-M"`. The framework name is the name of the corresponding Serving App in Supervisely, and the model name is the name of a pretrained model from the models table in the Serving App. You can find available models on the page of a Serving App in the Supervisely platform.

To deploy a model in a specific runtime, specify the `runtime=` argument. The model will be converted to the specified runtime if it supported in that framework. The available runtimes are `"onnx"` and `"tensorrt"`.

{% tabs %}
{% tab title="Pretrained checkpoint" %}
```python
import supervisely as sly

api = sly.Api()

# Deploy a pretrained model
model = api.nn.deploy(
    model="rt-detrv2/rt-detrv2-s"  # Model name from a table of pretrained models in the Serving App
)
```
{% endtab %}
{% tab title="Convert to ONNX" %}
```python
import supervisely as sly

api = sly.Api()

# ONNX Runtime
model = api.nn.deploy(
    model="rt-detrv2/rt-detrv2-s"  # Model name from a table of pretrained models in the Serving App
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
    model="rt-detrv2/rt-detrv2-s"  # Model name from a table of pretrained models in the Serving App
    runtime="tensorrt",        # Will convert the model to TensorRT before deploying
)
```
{% endtab %}
{% endtabs %}

### Deploy arguments

You can specify additional arguments for the `api.nn.deploy()` method, such as `device`, `runtime`, and `agent_id`.

| Argument | Type | Description |
| --- | --- | --- |
| `model` | `str` | Can be a path to your checkpoint in Team Files or a pretrained model name in the format `framework/model_name` (e.g., `"rt-detrv2/rt-detrv2-s"`). For a custom checkpoint, the checkpoint can be in PyTorch format (`.pt` or `.pth`), ONNX format (`.onnx`), or TensorRT format (`.engine`). For a pretrained model, the framework name is the name of the corresponding Serving App in Supervisely, and the model name is the name of a pretrained model from the models table in the Serving App. |
| `device` | `str` | Device to run the model on, e.g., `"cuda:0"` or `"cpu"`. If not specified, will automatically use `cuda` device, if available on the agent, otherwise `cpu` will be used. |
| `runtime` | `str` | Runtime to convert the model to before deploying. Options: `"onnx"`, `"tensorrt"`. Used for pretrained checkpoints. |
| `agent_id` | `int` | ID of the Supervisely Agent, a machine that is connected to Supervisely where the model will be deployed. If not specified, the agent will be selected automatically depending on GPU usage. |


#### Notes

- The `api.nn.deploy()` method will start a new Serving App in Supervisely, deploy the model, and return a `ModelAPI` object for running predictions.
- When deploying a custom checkpoint, you need to provide the `checkpoint` argument. When deploying a pretrained model, you need to provide both `framework` and `pretrained_model` arguments.
- The `runtime` argument is used when deploying a pretrained model.
- If `device` argument is not specified, the model will automatically use GPU device if available, otherwise CPU.
- If `agent_id` argument is not specified, the agent will be selected automatically depending on GPU usage.


### Connect to deployed model

If your model is already deployed in Supervisely, you just need to connect to it using the `api.nn.connect()` method and providing a `task_id` of the running serving app. This method returns a `ModelAPI` object for running predictions. You can use `url` argument to directly connect to a model's FastAPI server, bypassing the `task_id` argument. It is useful for connecting to a local models, or models running in Docker containers.

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
from supervisely.nn import ModelAPI

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


## ModelAPI methods

The `ModelAPI` class provides methods for running inference, loading checkpoints, and managing the model's configuration.

### Predict

The ModelAPI class provides convenient methods for predictions. You can use `predict()` or `predict_detached()` methods to run inference on a single image or a batch of images. These methods accepts a variety of input formats, including numpy arrays, PIL images, and Supervisely IDs. The difference between `predict()` and `predict_detached()` is that the first one will wait until all predictions are complete, while the second one will return a `PredictionSession` object immediately, allowing you to process predictions asynchronously, as they become available.

#### Predict arguments

> See the full guide on usage of predict methods and its settings in [Prediction API](./prediction-api.md).

A table of arguments for the `predict()` and `predict_detached()` methods:

| Argument | Type | Default | Description |
| --- | --- | --- | --- |
| `input` | `str`, `Path`, `np.ndarray`, `PIL.Image`, `list` | `None` | Input source: local path to an image or video, directory of images, local Supervisely project, numpy array, PIL.Image, URL |
| `project_id` | `int` or `list` | `None` | Project IDs from Supervisely platform. You can use both `project_id` and `project_ids` arguments, they are aliases. |
| `dataset_id` | `int` or `list` | `None` | Dataset IDs from Supervisely platform. You can use both `dataset_id` and `dataset_ids` arguments, they are aliases. |
| `image_id` | `int` or `list` | `None` | Image IDs from Supervisely platform. You can use both `image_id` and `image_ids` arguments, they are aliases. |
| `video_id` | `int` or `list` | `None` | Video IDs from Supervisely platform. The video will be processed frame by frame. You can use both `video_id` and `video_ids` arguments, they are aliases. |
| `conf` | `float` | `None` | Confidence threshold for filtering out low confident predictions. If `None`, the model's default confidence threshold will be used. |
| `batch_size` | `int` | `None` | Number of images to process in a single batch. If `None`, the model will use its default batch size. |
| `img_size` | `int` or `tuple` | `None` | Size of input images: `int` resizes to a square size, a tuple of (height, width) resizes to exact size. Also applicable to video inference. `None` will use the model's default input size |
| `classes` | `List[str]` | `None` | List of classes to predict |
| `upload` | `str` | `None` | If not `None`, predictions will be uploaded to the platform. Upload modes: `create`, `append`, `replace`, `iou_merge`. See more in [Uploading predictions](#uploading-predictions) section. |
| `recursive` | `bool` | `False` | Whether to search for images in subdirectories. Applicable when the `input` is a directory. |
| `**kwargs` | `dict` | `None` | All additional settings, such as inference settings, sliding window settings and video processing settings can be passed here. See more in [Advanced settings](#predict-settings-kwargs). |


### Predict Detached

### Load checkpoint

{% tabs %}
{% tab title="Custom checkpoint" %}
```python
# Load custom checkpoint
model.load(
    model="/path/in/team_files/checkpoint.pt",  # Path to your checkpoint in Team Files
)
```
{% endtab %}
{% tab title="ONNX checkpoint" %}
```python
# Loading ONNX checkpoint
model.load(
    model="/path/in/team_files/model.onnx",  # Path to ONNX checkpoint in Team Files
)
```
{% endtab %}
{% tab title="TensorRT checkpoint" %}
```python
# Loading TensorRT checkpoint
model.load(
    model="/path/in/team_files/model.engine",  # Path to TensorRT checkpoint in Team Files
)
```
{% endtab %}
{% tab title="Pretrained checkpoint" %}
```python
# Load pretrained checkpoint
model.load(
    model="RT-DETRv2-S",  # Name of the pretrained model
)
```
{% endtab %}
{% tab title="Convert to ONNX" %}
```python
# Load pretrained checkpoint and convert to ONNX
model.load(
    model="RT-DETRv2-S",  # Name of the pretrained model
    runtime="onnx",                  # Will convert the model to ONNX before loading
)
```
{% endtab %}
{% tab title="Convert to TensorRT" %}
```python
# Load pretrained checkpoint and convert to TensorRT
model.load(
    model="RT-DETRv2-S",  # Name of the pretrained model
    runtime="tensorrt",              # Will convert the model to TensorRT before loading
)
```
{% endtab %}
{% endtabs %}

#### Arguments

A table of arguments for the `ModelAPI.load()` method:

| Argument | Type | Description |
| --- | --- | --- |
| `model` | `str` | Path to your checkpoint in Team Files. Can be PyTorch model (`.pt`), ONNX (`.onnx`), or TensorRT (`.engine`) format. |
| `device` | `str` | Device to run the model on, e.g., `"cuda:0"` or `"cpu"`. If not specified, will automatically use GPU device if available, otherwise CPU. |
| `runtime` | `str` | Runtime to convert the model to before deploying. Options: `"onnx"`, `"tensorrt"`. Used for pretrained checkpoints. |
| `agent_id` | `int` | ID of the Supervisely Agent (machine) that is connected to the Supervisely platform where the model should be deployed. Don't need to specify, if the only one agent is connected. |

