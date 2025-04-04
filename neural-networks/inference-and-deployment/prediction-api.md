# Prediction API

🔴 -  будем ли мы делать после overview секцию quickstart? и потом на ней ссылки на расширенные доки типа этой где все делали и варианты деплоя будут с аргументами расписаны?
🔴 - runtime? пока не видел - onnx tensorrt - написать что не зависит дать ссылку
🔴 - нужно будет еще написать, в отдельном разделе Advanced что там при запуске есть Restart policy разные и что тогда task_id при рестарте не поменяется. нужно проверить это
🔴 - docker: connect to model
🔴 - team_id по идее можно брать и искать автоматом, задал умару вопрос https://supervisely-team.slack.com/archives/CV28AA11P/p1743760002034969
🔴 - из чекпоинта по идее мы будем доставать всю инфу в том числе framework  и тд, чтобы знать в какой апе стартануть?
🔴 - еще я бы добавил опциональный флаг, что если такая модель раздеплоена, найти ее или раздеплоить как еще одну:
🔴 - еще аргумент checkpoint мне не нравится и еще не понятно как раздеплоить pretrained (тут у меня нет идей, но как-то вкорячить это в метод model = api.nn.deploy(model="/a/b/c.pth") было бы прикольно)
🔴 - может переименовать в deploy?
model = api.nn.deploy(checkpoint="/a/b/c.pth")
model = api.nn.deploy(pretrained="mmmm-coc-aaa"???)
🔴 - дописать в описании что метод сам проверит наличие компьютера с GPU девайса и описать аргшументы? device, agent? 
🔴 - поговорить с денисом и заменить слово agent на machine

Suppose you've trained a new model in Supervisely and want to use it for inference via API. You can do this with ease using the new **Supervisely Prediction API**.

## Deploy & Connect

Before using the model, you need to deploy a new model or connect to an existing one.

{% tabs %}
{% tab title="Deploy a new model" %}
```python
import supervisely as sly

api = sly.Api()

# When you deploy a model, it will automatically connect to it.
model = api.nn.deploy(
    checkpoint="/path/in/team_files/best.pt",  # path to your checkpoint in Team Files
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
{% tab title="Connect to model in Docker" %}
```python
import supervisely as sly

api = sly.Api()

model = api.nn.connect(
    url="http://localhost:8000",  # URL of the Docker container
)
```
{% endtab %}
{% endtabs %}

This guide does not cover the deployment process. Please, see the full documentation in [Deploy API](neural-networks/inference-and-deployment/deploy-api.md).

## Predict

After you've connected to the model, you can use it to make predictions. Here's an example usage:

```python
# Predicting multiple images
predictions = model.predict(
    input=["image1.jpg",  "image2.jpg"],
)

# Iterating through predictions
for p in predictions:
    boxes = p.boxes  # np.array of shape (N, 4) with predicted boxes in "xyxy" format
    masks = p.masks  # np.array of shape (N, H, W) with binary masks
    scores = p.scores  # np.array of shape (N,) with predicted confidence scores
    classes = p.classes  # list of predicted class names
    annotation = p.annotation  # predictions in sly.Annotation format
    p.visualize(save_dir="./output")  # save visualization with predicted annotations
```

### Input format

The model can accept various input formats, including image paths, np.ndarray, Project ID, Image ID and others.

{% tabs %}

{% tab title="image" %}
```python
# Single image file
predictions = model.predict(input="path/to/image.jpg")
```
{% endtab %}

{% tab title="URL" %}
```python
# URL to an image
predictions = model.predict(input="https://example.com/image.jpg")
```
{% endtab %}

{% tab title="PIL" %}
```python
from PIL import Image

# Load image with PIL
image = Image.open("path/to/image.jpg")

predictions = model.predict(
    input=image,
)
```
{% endtab %}

{% tab title="numpy" %}
```python
import numpy as np

# Numpy array of shape (H, W, C) in RGB format
image_np = np.random.randint(low=0, high=255, size=(640, 640, 3), dtype="uint8")

predictions = model.predict(
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

predictions = model.predict(
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

### Prediction result

The `predict()` method returns a list of `Prediction` objects. The `Prediction` class represents the result of a model's prediction operation on an image. It contains annotation data, source information, and provides methods for visualization and data access.

```python
# Predicting multiple images
predictions = model.predict(
    input=["image1.jpg",  "image2.jpg"],
)

# Iterating through predictions
for p in predictions:
    p.annotation    # sly.Annotation with predicted objects
    p.source        # Source of an image. Can be a path, URL, or numpy array
    p.image_path    # Path to the image file
    p.image_url     # URL of the image if input was a URL
    p.image         # np.ndarray image if input was a PIL image or np.array
    p.project_id    # Project ID if input was a Supervisely ID
    p.dataset_id    # Dataset ID if input was a Supervisely ID
    p.image_id      # Image ID if input was a Supervisely ID
    orig_image = p.load_image()       # Load the original image associated with this prediction
    p.visualize(save_dir="./output")  # Save visualization with predicted annotations
    🔴🔴🔴 boxes, masks. etc.
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
🔴🔴🔴 add boxes, masks, etc.

#### `Prediction` methods

The `Prediction` object provides convenient methods for loading the original image and visualizing the predicted annotation.

| Method | Return Type | Description |
| --- | --- | --- |
| `visualize()` | `np.ndarray` | Draws the predicted annotation on the original image. If `save` or `save_dir` is provided, it saves the visualization to the specified path or directory. |
| `load_image()` | `np.ndarray` | Loads the image associated with this prediction. |

#### `visualize(save=None, save_dir=None)`

🔴🔴🔴 add more args from sly.Annotation.draw()

Visualizes the prediction by drawing annotations on the original image.

**Parameters:**
- `save` (`str`, optional): Path where the visualization should be saved. If provided, the method will save the visualization to this path.
- `save_dir` (`str`, optional): Directory where the visualization should be saved. If provided, the method will save the visualization with the same filename as the original image.

**Returns:**
- `np.ndarray`: Numpy array containing the image with visualized predictions (bounding boxes, masks, etc.).

```python
# Process all images in a directory
predictions = model.predict(
    input="path/to/images_directory/",
    recursive=True,  # Include subdirectories
)

# Save all visualizations to an output directory
for p in predictions:
    p.visualize(save_dir="./results")
```

#### Notes

- The `visualize()` method automatically handles loading the image from `image_path` and drawing the annotations on it.
- When using `save_dir`, the original filename from `image_path` is preserved.
- Multiple predictions are returned even for a single image input, so always expect a list of `Prediction` objects.

#### `load_image()`

Loads the original image associated with this prediction. This is useful if you want to access the original image data for further processing or visualization.

```python
# Process all images in a Project
predictions = model.predict(
    project_id=123,  # Project ID
)

os.makedirs("output", exist_ok=True)  # Create output directory if it doesn't exist

# Save all original images to the output directory
for p in predictions:
    orig_image = p.load_image()  # Will download the original image
    img_id = p.image_id  # Image ID in the Supervisely platform
    Image.fromarray(orig_image).save(f"output/prediction_{img_id}.jpg")  # Save the original image
```

#### Notes

- The `load_image()` method will download the original image from the Supervisely platform if the input was an URL, Project ID, Dataset ID, or Image ID.
- If the input was a local path, np.array, or PIL.Image, the original image is already available in the `image` attribute of the `Prediction` object.


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
for p in tqdm(session):
    p.visualize(save_dir=f"./results")  # Save the visualization with predicted annotations
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

## Predict video frame by frame

🔴🔴🔴

The `predict()` and `predict_detached()` methods can also be used to process video files. The model will process the video frame by frame, returning predictions for each frame.

```python
# Predicting a video file
predictions = model.predict(
    video="video.mp4",
    video_settings={
        "stride": 1,        # step between frames, 1 means process every frame
        "start_frame": 0,   # start frame to process (0-based)
        "end_frame": 2400,  # end frame (exclusive)
        "num_frames": 400,  # number of frames to process 
        "duration": 10,     # duration in seconds, will calculate number of frames
    },
)

# Iterating through predictions
for p in predictions:
    p.frame_idx  # Frame index of the prediction
```

## Tracking objects on video

