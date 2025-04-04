# Prediction API

Suppose you've trained a new model in Supervisely and want to use it for inference. You can do this with ease using the new **Supervisely Prediction API**.

## Connect & Deploy
🔴 - я бы сделал Deploy & Connect

Before using the model, you need to connect to it. You can either deploy a new model or connect to an existing one.

{% tabs %}
{% tab title="Deploy model" %}
```python
import supervisely as sly

api = sly.Api()

model = api.nn.deploy_custom_model( 🔴 - checkpoint_id это прям мне не нравится как новая сущность
    checkpoint_id=12345,  # file id of checkpoint in Team Files
)
🔴 - лучше 
model = api.nn.deploy_custom_model(checkpoint="/a/b/c.pth")
🔴 - team_id по идее можно брать и искать автоматом, задал умару вопрос https://supervisely-team.slack.com/archives/CV28AA11P/p1743760002034969
🔴 - из чекпоинта по идее мы будем доставать всю инфу в том числе framework  и тд, чтобы знать в какой апе стартануть?
🔴 - еще я бы добавил опциональный флаг, что если такая модель раздеплоена, найти ее или раздеплоить как еще одну:
🔴 - еще аргумент checkpoint мне не нравится и еще не понятно как раздеплоить pretrained (тут у меня нет идей, но как-то вкорячить это в метод model = api.nn.deploy(model="/a/b/c.pth") было бы прикольно)
🔴 - может переименовать в deploy?
model = api.nn.deploy(model="/a/b/c.pth")
🔴 - дописать в описании что метод сам проверит наличие компьютера с GPU девайса и описать аргшументы?


```
{% endtab %}
{% tab title="Connect to deployed model" %}
```python
import supervisely as sly

api = sly.Api()

model = api.nn.connect(
    task_id=12345,  # Task ID of a running app in Supervisely
)
🔴 - нужно будет еще написать, в отдельном разделе Advanced что там при запуске есть Restart policy разные и что тогда task_id при рестарте не поменяется. нужно проверить это
```
{% endtab %}
{% endtabs %}

## Predict

After you've connected to the model, you can use it to make predictions. Here's an example usage:

{% tabs %}
{% tab title="sly.Annotation" %}
```python
# Predicting multiple images
predictions = model.predict(
    input=["image1.jpg",  "image2.jpg"],
)

# Iterating through predictions
for prediction in predictions:
    labels = prediction.annotation.labels  # 🔴🔴🔴 labels - термин в контексте моделей обычно используется для обозначения номера класса.
    boxes = [label.geometry.to_bbox() for label in labels]
    masks = [label.geometry for label in labels]
    scores = [tag.value for tag in labels.tags if tag.name == "confidence"]
    classes = [label.obj_class.name for label in labels]
```
{% endtab %}
{% tab title="🔴NEW API🔴" %}
```python
# Predicting multiple images
predictions = model.predict(
    input=["image1.jpg",  "image2.jpg"],
)

# Iterating through predictions
for prediction in predictions:
    boxes = prediction.boxes  # List of predicted boxes (xyxy format)
    masks = prediction.masks  # List of predicted masks (np.ndarray)
    scores = prediction.scores  # List of predicted probabilities
    classes = prediction.classes  # List of predicted classes
    annotation = prediction.to_annotation()  # sly.Annotation with predicted objects
```
{% endtab %}
{% endtabs %}

### Input format

The model can accept various input formats, including image paths, np.ndarray, Project ID, Image ID and others.

{% tabs %}

{% tab title="image" %}
```python
# Single image file
prediction = model.predict(
    input="path/to/image.jpg",
)
```
{% endtab %}

{% tab title="URL" %}
```python
# URL to an image
prediction = model.predict(
    input="https://example.com/image.jpg",
)
```
{% endtab %}

{% tab title="PIL" %}
```python
from PIL import Image

# Load image with PIL
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
# A list of images in any format, such as paths, PIL, np.array, etc.
predictions = model.predict(
    input=["image1.jpg", "image2.jpg"],
)
```
{% endtab %}

{% tab title="directory" %}
```python
# A directory of images
predictions = model.predict(
    input="path/to/directory",
    recursive=True,  # Search for images in sub-directories
)
```
{% endtab %}

{% tab title="video" %}
```python
# A video file
predictions = model.predict(
    input="path/to/video.mp4",
)
```
{% endtab %}

{% tab title="Project" %}
```python
# A local Supervisely Project containing images
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

Here's a summary of the input formats accepted by `predict()` and `predict_detached()` methods:

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

You can control the prediction process with various arguments, such as inference settings, batch size, image size. Here's a list of available arguments for the `predict()` and `predict_detached()` methods:

| Argument | Type | Default | Description |
| --- | --- | --- | --- |
| `input` | `str`, `Path`, `np.ndarray`, `PIL.Image`, `list` | `None` | Input source: local paths, directory, local project, numpy array, PIL.Image, URL |
| `settings` | `dict` | `None` | Inference settings passed to the model for inference |
| `project_id` | `int` | `None` | Project ID from Supervisely platform |
| `dataset_id` | `int` | `None` | Dataset ID from Supervisely platform |
| `image_ids` | `int` or `list` | `None` | Single image ID or list of image IDs from Supervisely platform |
| `batch_size` | `int` | `None` | Number of images to process in a single batch |
| `img_size` | `int` or `tuple` | `None` | Size of input images: `int` resizes to a square size, a tuple of (height, width) resizes to exact size. `None` will use the model's default input size |
| `classes` | `List[str]` | `None` | List of classes to predict |
| `upload` | `str` | `None` | If not `None`, the prediction will be uploaded to the platform. Upload modes: `create`, `append`, `replace`, `iou_merge`. See more in [Uploading predictions](#uploading-predictions) section. |
| `recursive` | `bool` | `False` | Whether to search for images in subdirectories. Applicable for directories only. |

### Output format

The `predict()` method returns a list of `Prediction` objects, containing annotation data and information about the source image.

```python
# Predicting multiple images
predictions = model.predict(
    input=["image1.jpg",  "image2.jpg"],
)

# Iterating through predictions
for prediction in predictions:
    prediction.annotation    # sly.Annotation with predicted objects
    prediction.source        # Source of an image. Will be "image1.jpg" or "image2.jpg" in this example
    prediction.image_path    # Path to the image file
    prediction.image_url     # URL of the image if input was a URL
    prediction.image         # np.ndarray image if input was a PIL image or np.array
    prediction.project_id    # Project ID if input was a Supervisely ID
    prediction.dataset_id    # Dataset ID if input was a Supervisely ID
    prediction.image_id      # Image ID if input was a Supervisely ID
    image = prediction.load_image()    # Load the original image associated with this prediction
    visualization = prediction.draw()  # Draw the predicted annotation on the image
```

#### `Prediction` attributes

The `Prediction` object contains the following attributes:

| Attributes | Type | Description |
| --- | --- | --- |
| `annotation` | `sly.Annotation` | Supervisely annotation containing predicted objects, their classes, geometries, and tags. |
| `source` | `str` or `np.ndarray` | The source of a single input image. Depending on the type of `input`, it can be **image path**, **np.array** of the image, or **URL**. |
| `image_path` | `str` or `None` | Path to the image file. Applicable if the input was a local path or directory |
| `image_url` | `str` or `None` | URL of the image if the input was a URL. |
| `image` | `np.ndarray` or `None` | Image as a numpy array if the input was a numpy array. |
| `project_id` | `int` or `None` | ID of the Supervisely project associated with this prediction. Applicable if the input was a Supervisely ID |
| `dataset_id` | `int` or `None` | ID of the Supervisely dataset associated with this prediction. Applicable if the input was a Supervisely ID |
| `image_id` | `int` or `None` | ID of the image in the Supervisely platform associated with this prediction. Applicable if the input was a Supervisely ID |

#### `Prediction` methods

The `Prediction` object provides methods for loading the original image and visualizing the predicted annotation.

| Method | Return Type | Description |
| --- | --- | --- |
| `load_image()` | `np.ndarray` | Loads the image associated with this prediction. |
| `draw()` | `np.ndarray` | Draws the predicted annotation on the image. |


## Predict Detached

The `predict_detached` method provides an asynchronous, non-blocking approach to running predictions on large datasets or when processing needs to be done in parallel with other operations. Unlike the standard `predict()` method which waits until **all** predictions are complete, `predict_detached` returns a `PredictionSession` object immediately, allowing your application to process predictions as they become available. This can be useful in tracking the progress, or doing other tasks in parallel, while predictions are being processed.

The `predict_detached()` accepts the same arguments as `predict()`, but it returns a `PredictionSession` object instead of a list of predictions.

```python
from tqdm import tqdm

# Start a detached prediction session
# At this point, the model will start making predictions in parallel
session = model.predict_detached(
    input="path/to/directory",
    recursive=True,
)

# Process predictions as they become available
for prediction in tqdm(session):
    objects = prediction.annotation.labels  # List of predicted objects
    boxes = [label.geometry.to_bbox() for label in labels]
```

#### `PredictionSession` methods

The `PredictionSession` object provides methods for managing the prediction process, checking its status, and retrieving predictions.

| Method | Return Type | Description |
| --- | --- | --- |
| `is_done()` | `bool` | Returns `True` if all predictions have been processed or the session was stopped. |
| `next(timeout=None, block=True)` | `Prediction` | Retrieves the next available prediction. If `block=True`, waits until a prediction is available or the timeout (in seconds) is reached. If `block=False`, returns `None` immediately if no prediction is available. |
| `stop()` | None | Stops the prediction process. Any predictions already in the queue will still be available, but no new predictions will be generated. |
| `status()` | `dict` | Returns a dictionary containing session status information including: `progress` (percentage complete), `message` (status message), `error` (traceback if an error occurred), and `context` (project_id, dataset_id, etc.). |


```python
# Start predicting images in a directory
session = model.predict_detached(input="path/to/directory")

# Process first 10 images in directory
for i in range(10):
    if not session.is_done():
        prediction = session.next()

# Stop processing images
session.stop()
```

## Uploading predictions

You can upload predictions to the Supervisely platform using the `upload` argument in the `predict()` and `predict_detached()` methods. The available upload modes are:

| Upload Mode | Description |
| --- | --- |
| `create` | Create a new project on the platform and upload predictions to it. |
| `append` | Add new predictions to existing annotations. Only applicable if the input is an existing Project ID, Dataset ID, or Image IDs. |
| `replace` | Replace existing annotations with the new predictions. Only applicable if the input is an existing Project ID, Dataset ID, or Image IDs. |
| `iou_merge` | Append predictions to existing annotations, trying to avoid creating duplicate objects. This mode will check the IoU between each new prediction and existed objects, and filter out predictions which overlap with existed objects with IoU >= 0.9 (🔴🔴🔴 parameter controlled in `settings`). Only applicable for bounding box and mask predictions, and for existing Project ID, Dataset ID, or Image IDs. |

```python
# Upload predictions to a project
predictions = model.predict(
    project_id=123,  # Input project ID
    upload="append",  # or "create", "replace", "iou_merge"
)
```

## Predict video

🔴🔴🔴

The `predict()` and `predict_detached()` methods can also be used to process video files. The model will process the video frame by frame, returning predictions for each frame.

```python
# Predicting a video file
predictions = model.predict(
    input="video.mp4",
    video_id=5122,     # 🔴🔴🔴 еще один параметр?
    video_params={     # 🔴🔴🔴 как это лучше придумать?
        "stride": 2,
        "start_frame": 120,
        "end_frame": 2400,
        "num_frames": 400,
        "duration": 10,  # duration in seconds
    },
)

# Iterating through predictions
for prediction in predictions:
    prediction.frame_idx  # Frame index of the prediction
```
