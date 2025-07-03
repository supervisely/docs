# Model API

The `ModelAPI` class is used to interact with a model's server. It provides methods for running inference, loading checkpoints, managing model settings and accessing information about current model. The model's server can be running either in Supervisely, or on a local machine, and the `ModelAPI` class provides a unified interface for both cases.

## Deploy & Connect

Before working with the `ModelAPI` class, you need to deploy a model or connect to an already deployed model. The `sly.Api` provides methods for deploying and connecting to models.

### Deploy

To deploy a new model, use the `api.nn.deploy()` method. This method will start a new Serving App in Supervisely, deploy a given model, and return a `ModelAPI` object for running predictions.

#### Deploy custom checkpoint

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

#### Deploy pretrained checkpoint

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

#### Deploy arguments

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


### Connect

If your model has already been deployed in Supervisely, you just need to connect to it using the `api.nn.connect()` method providing a `task_id` of the running serving app. This method returns a `ModelAPI` object for running predictions. You can also use `url` argument to directly connect to a model's FastAPI server, bypassing the `task_id` argument. This is useful when connecting to a model that was deployed locally or in a Docker container.

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

After you've connected to a model, you have the `ModelAPI` wrapper for running inference, loading checkpoints, and managing the model's state and configuration.

### Predict

The ModelAPI class provides convenient methods for predictions. You can use `predict()` or `predict_detached()` method to run inference. These methods accepts a variety of input formats, including numpy arrays, PIL images, Supervisely Projects and Datasets, and even videos.

The difference between `predict()` and `predict_detached()` is that the first one will wait until all images are processed by a model and then will return a complete list of predictions, while the second one will return a `PredictionSession` immediately, which allows you to track the process in asynchronous, non-blocking mode. The `PredictionSession` object provides methods for checking the status of predictions and iterating over the results as soon as they are processed.

> See the full guide on the usage of predict methods and its settings in [Prediction API](./prediction-api.md).

#### Predict arguments

Here is a full table of `predict()` and `predict_detached()` arguments:

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
| `upload_mode` | `str` | `None` | If not `None`, predictions will be uploaded to the platform. Upload modes: `create`, `append`, `replace`, `iou_merge`. See more in [Uploading predictions](./prediction-api.md#uploading-predictions) section. |
| `recursive` | `bool` | `False` | Whether to search for images in subdirectories. Applicable when the `input` is a directory. |
| `**kwargs` | `dict` | `None` | All additional settings, such as inference settings, sliding window settings and video processing settings can be passed here. See more in [Advanced settings](./prediction-api.md#predict-settings-kwargs). |

### Load checkpoint

The `ModelAPI.load()` method is used to change the deployed model to a different one or load another checkpoint. The method accepts similar arguments to the [`api.nn.deploy()`](#deploy-and-connect) method. You can load a custom checkpoint by providing the path to a checkpoint file in Team Files using `model=` argument. The checkpoint can be in PyTorch format, ONNX format (`.onnx`), or TensorRT format (`.engine`). You can also load a pretrained model by specifying the `model=` argument in the format of `framework/model_name`, for example, `"RT-DETRv2/RT-DETRv2-M"`.

{% tabs %}
{% tab title="Custom checkpoint" %}
```python
# Load custom checkpoint
model.load(
    model="/path/in/team_files/checkpoint.pt",  # Path to your checkpoint in Team Files
)
```
{% endtab %}
{% tab title="Pretrained checkpoint" %}
```python
# Load pretrained checkpoint
model.load(
    model="rt-detrv2/rt-detrv2-s",  # Name of the pretrained model
)
```
{% endtab %}
{% endtabs %}

**Select device**

You can pass `device` argument to specify the device to run the model on. Use `device="cuda:0"` to run the model on the first GPU, or `device="cpu"` to run it on CPU. If not specified, the model will automatically use GPU device if available, otherwise CPU will be used.

{% tabs %}
{% tab title="CUDA device" %}
```python
# Load model on CUDA device
model.load(
    model="/path/in/team_files/checkpoint.pt",  # Path to your checkpoint in Team Files
    device="cuda:0",  # use the first GPU
)
```
{% endtab %}
{% tab title="CPU device" %}
```python
# Load model on CPU
model.load(
    model="/path/in/team_files/checkpoint.pt",  # Path to your checkpoint in Team Files
    device="cpu",  # use CPU
)
```
{% endtab %}
{% endtabs %}

**ONNX / TensorRT runtimes**

To load an exported model, just provide a path in Team Files to that onnx / tensorrt model. If you need to convert a pytorch model or a checkpoint to ONNX / TensorRT format, pass `runtime="onnx"` or `runtime="tensorrt"`.

{% tabs %}
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
{% tab title="Convert to ONNX" %}
```python
# Load pretrained checkpoint and convert to ONNX
model.load(
    model="rt-detrv2/rt-detrv2-s",  # Name of the pretrained model
    runtime="onnx",                 # Will convert the model to ONNX before loading
)
```
{% endtab %}
{% tab title="Convert to TensorRT" %}
```python
# Load pretrained checkpoint and convert to TensorRT
model.load(
    model="rt-detrv2/rt-detrv2-s",  # Name of the pretrained model
    runtime="tensorrt",             # Will convert the model to TensorRT before loading
)
```
{% endtab %}
{% endtabs %}

**Arguments**

Here is a table with description of arguments of the `ModelAPI.load()` method:

| Argument | Type | Description |
| --- | --- | --- |
| `model` | `str` | Can be a path to your checkpoint in Team Files or a pretrained model name in the format `framework/model_name` (e.g., `"rt-detrv2/rt-detrv2-s"`). For a custom checkpoint, the checkpoint can be in PyTorch format (`.pt` or `.pth`), ONNX format (`.onnx`), or TensorRT format (`.engine`). For a pretrained model, the framework name is the name of the corresponding Serving App in Supervisely, and the model name is the name of a pretrained model from the models table in the Serving App. |
| `device` | `str` | Device to run the model on, e.g., `"cuda:0"` or `"cpu"`. If not specified, will automatically use `cuda` device, if available on the agent, otherwise `cpu` will be used. |
| `runtime` | `str` | Runtime to convert the model to before deploying. Options: `"onnx"`, `"tensorrt"`. Used for pretrained checkpoints. |

### Get available models & checkpoints

These methods are used to get all available models and your custom checkpoints in Supervisely. You can use these methods to find the model you want to deploy or load.

#### `list_pretrained_models()`

The `list_pretrained_models()` method returns a list of available pretrained models in the model's framework. You can use this list to find the name of a specific pretrained model you want to deploy.

#### `list_pretrained_model_infos()`

The `list_pretrained_model_infos()` method returns a list of dictionaries with detailed information about each pretrained model. It can be useful for getting more information about each model, such as the model's architecture, evaluation metrics, and other details.

#### `list_experiments()`

The `list_experiments()` returns a list of experiments with your models trained in Supervisely. You can use this to get the Team Files path of a specific checkpoint you want to deploy.

### Get model info

If a model has already loaded, you can use these methods to get information about currently deployed model, such as model name, checkpoint, model's classes, inference settings, etc.

#### `get_info()`

The `get_info()` method returns a dictionary with general information about the deployed model.

#### `get_settings()`

The `get_settings()` method returns a dictionary with the default model's settings, such as confidence threshold, iou threshold, etc. You can override these settings when calling `predict()` or `predict_detached()` methods by passing the settings as keyword arguments (e.g, `predict(image_id=1, iou_threshold=0.5)`).

#### `get_classes()`

The `get_classes()` method returns a list of class names the model can predict. You can also pass a list of class names to the `classes` argument in the `predict()` and `predict_detached()` methods to filter predictions by specific classes.

> Note: the classes are returned in the same order as they are defined in the model's configuration, so the first class in the list corresponds to the 0th class index in the model's output (because the model returns indices, not the class names).

#### `get_model_meta()`

The `get_model_meta()` returns a Supervisely `sly.ProjectMeta` object contains the classes and shapes the model predicts.

### Shutdown

The `shutdown()` method completely stops the model's server. This method will stop the model and the Serving App in the Supervisely platform. After calling this method, the current `ModelAPI` object will no longer be valid, and you will need to deploy another model.