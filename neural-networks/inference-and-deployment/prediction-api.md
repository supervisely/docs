# Prediction API

Suppose you've trained a new model in Supervisely and want to deploy it for inference. You can do this with ease using the new **Supervisely Prediction API**.

## Connect & Deploy

Before using the model, you need to connect to it. You can either deploy a new model or connect to an existing one.

{% tabs %}
{% tab title="Deploy model" %}
```python
import supervisely as sly

api = sly.Api()

model = api.nn.deploy_custom_model(
    checkpoint_id=12345,  # file id of checkpoint in Team Files
)
```
{% endtab %}
{% tab title="Connect to existed model" %}
```python
import supervisely as sly

api = sly.Api()

model = api.nn.connect(
    task_id=12345,  # Task ID of a running app in Supervisely
)
```
{% endtab %}
{% endtabs %}

## Predict

After you've connected to the model, you can use it to make predictions. The model can accept various input formats, including image path, np.array, Project ID, Image ID and others.

{% tabs %}

{% tab title="image" %}
```python
prediction = model.predict(
    input="path/to/image.jpg",
)
```
{% endtab %}

{% tab title="URL" %}
```python
prediction = model.predict(
    input="https://example.com/image.jpg",
)
```
{% endtab %}

{% tab title="PIL" %}
```python
from PIL import Image

image = Image.open("path/to/image.jpg")
prediction = model.predict(
    input=image,
)
```
{% endtab %}

{% tab title="numpy" %}
```python
import numpy as np

# Numpy array of shape (H, W, C) in RGB format
image_np = np.random.randint(low=0, high=255, size=(640, 640, 3), dtype="uint8")

prediction = model.predict(
    input=image_np,
)
```
{% endtab %}

{% tab title="list" %}
```python
# You can pass a list of images in any format, such as paths, PIL, OpenCV, numpy arrays, etc.
predictions = model.predict(
    input=["image1.jpg", "image2.jpg"],
)
```
{% endtab %}

{% tab title="directory" %}
```python
# You can pass a directory containing images
predictions = model.predict(
    input="path/to/directory",
)
```
{% endtab %}

{% tab title="video" %}
```python
# You can pass a video file
predictions = model.predict(
    input="path/to/video.mp4",
)
```
{% endtab %}

{% tab title="Project" %}
```python
# You can pass a local project containing images
predictions = model.predict(
    input="path/to/sly_project",
)
```
{% endtab %}

{% tab title="Supervisely IDs" %}
```python
# You can pass IDs from Supervisely platform
# - Project ID
# - Dataset ID
# - Image ID
# - List of Image IDs

predictions = model.predict(
    project_id=123,  # Project ID
)

predictions = model.predict(
    dataset_id=456,  # Dataset ID
)

prediction = model.predict(
    image_ids=12345,  # Image ID
)

predictions = model.predict(
    image_ids=[12345, 67890],  # List of Image IDs
)
```
{% endtab %}

{% endtabs %}

### Input formats

| Input | Example | Type | Description |
| --- | --- | --- | --- |
| image | `input="path/to/image.jpg"` | `str` or `Path` | Single image file path. |
| URL | `input="https://example.com/image.jpg"` | `str` | URL to an image. |
| PIL | `input=Image.open("path/to/image.jpg")` | `PIL.Image` | Image loaded with PIL library. |
| numpy | `input=np.array(image)` | `np.ndarray` | HWC format with RGB channels uint8 (0-255). |
| list | `input=["image1.jpg", "image2.jpg"]` | `list` | List of images in any format (paths, PIL, np.array, etc.). |
| directory | `input="path/to/directory"` | `str` or `Path` | Path to a directory containing images. Pass `recursive=True` to predict all images in sub-directories |
| video | `input="path/to/video.mp4"` | `str` or `Path` | Video file in formats like MP4, AVI, etc. |
| Supervisely project | `input="path/to/sly_project"` | `str` or `Path` | Path to a local Supervisely project containing images. |
| Project ID | `project_id=12345` | `int` | Project ID from Supervisely platform. |
| Dataset ID | `dataset_id=12345` | `int` | Dataset ID from Supervisely platform. |
| Image IDs | `image_ids=12345` or `image_ids=[12345, 67890]` | `int` or `list` | Single image ID or list of image IDs from Supervisely platform. |

### Predict arguments

| Argument | Type | Default | Description |
| --- | --- | --- | --- |
| `input` | `str`, `Path`, `np.ndarray`, `PIL.Image`, `list`, `int` | `None` | Input source: local paths, directory, local project, numpy array, PIL.Image, URL, Project ID, Dataset ID, Image IDs |
| `settings` | `dict` | `None` | Inference settings passed to a model for prediction |
| `project_id` | `int` | `None` | Project ID from Supervisely platform |
| `dataset_id` | `int` | `None` | Dataset ID from Supervisely platform |
| `image_ids` | `int` or `list` | `None` | Single image ID or list of image IDs from Supervisely platform |
| `batch_size` | `int` | `None` | Number of images to process in a single batch |
| `img_size` | `int` or `tuple` | `None` | Size of input images: `int` resizes to a square size, a tuple of (height, width) resizes to exact size. `None` will use the model's default input size |
| `classes` | `List[str]` | `None` | List of classes to predict |
| `upload` | `str` | `None` | If not `None`, the prediction will be uploaded on the platform. Upload modes: `append` - add new predictions to existed annotations, `replace` - replace an existing annotation to a new prediction, `create` - create a new project for predictions, `iou_merge` (only for bbox/mask) - append predictions to existing annotations, avoiding creating duplicated labels. |
| `recursive` | `bool` | `False` | Whether to search for images in subdirectories |

### Output format

The `predict()` returns a list of `Prediction` objects, containing annotation data and information about the source image.

| Attributes | Type | Description |
| --- | --- | --- |
| `annotation` | `sly.Annotation` | Supervisely annotation containing predicted objects, their classes, geometries, and tags. |
| `source` | `Any`, `None` | Source of the image used for prediction. Contains the same object as the `input` of `predict` method. Can be a file path, URL, np.array, PIL.Image, etc. Will be `None` if source was a Supervisely ID. |
| `project_id` | `int`, `None` | ID of the Supervisely project associated with this prediction. Applicable if the input was a Supervisely ID |
| `dataset_id` | `int`, `None` | ID of the Supervisely dataset associated with this prediction. Applicable if the input was a Supervisely ID |
| `image_id` | `int`, `None` | ID of the image in the Supervisely platform associated with this prediction. Applicable if the input was a Supervisely ID |

`Prediction` object has additional methods:

| Method | Return Type | Description |
| --- | --- | --- |
| `load_image()` | `np.ndarray` | Loads the image associated with this prediction. |
| `draw()` | | `np.ndarray` | Draws the predicted annotation on the image. |