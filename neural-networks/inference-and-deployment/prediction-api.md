# Prediction API

This page describes how to use **Supervisely Prediction API** to make model predictions on images and videos, including object tracking. With the new API you can easily deploy models, make predictions, and process the results.

## Deploy & Connect

Before using the model, you need to deploy a new model or connect to an existing one.

> This page does not cover the deployment process in detail. For more information, please refer to the full [Model API](./model-api.md) documentation.

#### Deploy a new model

To deploy a new model, use the `api.nn.deploy()` method. This method will start a new [Serving App](supervisely-serving-apps.md) in Supervisely, deploy a given model, and return a `ModelAPI` object for running predictions.

{% tabs %}
{% tab title="Custom checkpoint" %}
```python
import supervisely as sly

api = sly.Api()

workspace_id = 555 # <- Use your workspace ID

model = api.nn.deploy(
    model="/path/in/team_files/checkpoint.pt",  # path to your checkpoint in Team Files
    workspace_id=workspace_id
)
```
{% endtab %}
{% tab title="Pretrained checkpoint" %}
```python
import supervisely as sly

api = sly.Api()

workspace_id = 555 # <- Use your workspace ID

model = api.nn.deploy(
    model="rt-detrv2/rt-detrv2-s",  # model identifier in the format "framework/model_name"
    workspace_id=workspace_id
)
```
{% endtab %}
{% endtabs %}

#### Connect to existing model

If your model is already deployed in Supervisely, you just need to connect to it using the `api.nn.connect()` method, providing a `task_id` of the running serving app. This method returns a `ModelAPI` object for running predictions.

```python
import supervisely as sly

api = sly.Api()

# Connect to a deployed model
model = api.nn.connect(
    task_id=122,  # Task ID of a running Serving App in Supervisely
)
```

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
predictions = model.predict(
    input="path/to/image.jpg"
)
```
{% endtab %}

{% tab title="URL" %}
```python
# URL to an image
predictions = model.predict(
    input="https://example.com/image.jpg"
)
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
# You can pass IDs of items from Supervisely platform

# Image ID
predictions = model.predict(image_id=12345)

# List of Image IDs
predictions = model.predict(image_ids=[12345, 67890])

# Project ID
predictions = model.predict(project_id=123)

# Dataset ID
predictions = model.predict(dataset_id=456)

# Video ID
predictions = model.predict(video_id=1212)
```
{% endtab %}

{% endtabs %}

Here's a summary of the input formats accepted by `predict()` and `predict_detached()` methods:

| Input format | Example | Type | Description |
| --- | --- | --- | --- |
| image | `input="path/to/image.jpg"` | `str` or `Path` | Single image file path. |
| URL | `input="https://example.com/image.jpg"` | `str` | URL to an image. |
| PIL | `input=Image.open("path/to/image.jpg")` | `PIL.Image` | Image loaded with PIL library. |
| numpy | `input=np.array(image)` | `np.ndarray` | HWC format with RGB channels uint8 (0-255). |
| list | `input=["image1.jpg", "image2.jpg"]` | `list` | List of images in any format (paths, PIL, np.array, etc.). |
| directory | `input="path/to/directory"` | `str` or `Path` | Path to a directory containing images. Pass `recursive=True` to predict all images in sub-directories |
| video | `input="path/to/video.mp4"` | `str` or `Path` | Video file in formats like MP4, AVI, etc. |
| Supervisely project | `input="path/to/sly_project"` | `str` or `Path` | Path to a local Supervisely project containing images. |
| Project ID | `project_id=123`, `project_ids=[123, 456]` | `int` or `list` | Project ID from Supervisely platform. You can pass either a single ID or a list of IDs in any of `project_id`, `project_ids` arguments. |
| Dataset ID | `dataset_id=123`, `dataset_ids=[123, 456]` | `int` or `list` | Dataset ID from Supervisely platform. You can pass either a single ID or a list of IDs in any of `dataset_id`, `dataset_ids` arguments. |
| Image ID | `image_id=123`, `image_ids=[123, 456]` | `int` or `list` | Image ID from Supervisely platform. You can pass either a single ID or a list of IDs in any of `image_id`, `image_ids` arguments. |
| Video ID | `video_id=123`, `video_ids=[123, 456]` | `int` or `list` | Video ID from Supervisely platform. You can pass either a single ID or a list of IDs in any of `video_id`, `video_ids` arguments. |

### Predict arguments

You can control the prediction process with various arguments, such as inference settings, batch size, image size. Here's a list of available arguments for the `predict()` and `predict_detached()` methods:

| Argument | Type | Default | Description |
| --- | --- | --- | --- |
| `conf` | `float` | `None` | Confidence threshold for filtering out low confident predictions. If `None`, the model's default confidence threshold will be used. |
| `batch_size` | `int` | `None` | Number of images to process in a single batch. If `None`, the model will use its default batch size. |
| `img_size` | `int` or `tuple` | `None` | Size of input images: `int` resizes to a square size, a tuple of (height, width) resizes to exact size. Also applicable to video inference. `None` will use the model's default input size |
| `classes` | `List[str]` | `None` | List of classes to predict |
| `upload_mode` | `str` | `None` | If not `None`, predictions will be uploaded to the platform. Upload modes: `create`, `append`, `replace`, `iou_merge`. See more in [Uploading predictions](#uploading-predictions) section. |
| `recursive` | `bool` | `False` | Whether to search for images in subdirectories. Applicable when the `input` is a directory. |
| `**kwargs` | `dict` | `None` | All additional settings, such as inference settings, sliding window settings and video processing settings can be passed here. See more in [Advanced settings](#predict-settings-kwargs). |

### Prediction result

The `predict()` method always returns a list of `Prediction` objects. Depending on the model type, the `Prediction` can contain bounding boxes, masks, keypoints, or other types of annotations. `Prediction` object also contains annotation in Supervisely format and additional information about the original image source, such as image path, URL, and Supervisely IDs (if applicable). It also provides methods for visualizing the predictions and accessing the original image.

```python
# Predicting multiple images
predictions = model.predict(
    input=["image1.jpg",  "image2.jpg"],
)

# Iterating through predictions
for p in predictions:
    # Model's output
    p.boxes         # np.array of shape (N, 4) with predicted boxes in "xyxy" format
    p.masks         # np.array of shape (N, H, W) with binary masks
    p.scores        # np.array of shape (N,) with predicted confidence scores
    p.classes       # list of predicted class names
    p.class_idxs    # list of predicted class indices (labels)
    p.annotation    # sly.Annotation with predicted objects
    
    # Information about the source image or video
    p.source        # Source of an image. Can be a path, URL, or numpy array, depending on input
    p.name          # The name of image or video file
    p.path          # Path to image or video file
    p.url           # URL of the image if input was a URL
    p.frame_index     # Frame index if input was a video

    # Supervisely IDs
    p.project_id    # Project ID if input was a Supervisely ID
    p.dataset_id    # Dataset ID if input was a Supervisely ID
    p.image_id      # Image ID if input was a Supervisely ID
    p.video_id      # Video ID if input was a Supervisely ID

    # Additional methods
    orig_image = p.load_image()       # Load the original image associated with this prediction
    p.visualize(save_dir="./output")  # Save visualization with predicted annotations
```

#### `Prediction` attributes

The `Prediction` object contains the following attributes:

| Attributes | Type | Description |
| --- | --- | --- |
| `annotation` | `sly.Annotation` | Supervisely annotation containing predicted objects, their classes, geometries, and tags. |
| `boxes` | `np.ndarray` | Array of shape (N, 4) with predicted bounding boxes in "xyxy" format. |
| `masks` | `np.ndarray` | Array of shape (N, H, W) with binary masks for each predicted object. |
| `scores` | `np.ndarray` | Array of shape (N,) with confidence scores for each prediction. |
| `classes` | `List[str]` | List of predicted class names as strings. |
| `class_idxs` | `List[int]` | List of predicted class indices (labels). |
| `source` | `str` or `np.ndarray` | The source of a single input image. Depending on the type of `input`, it can be **image path**, **np.array** of the image, or **URL**. |
| `name` | `str` or `None` | The name of the image file. |
| `path` | `str` or `None` | Path to the image file. Applicable if the input was a local path or directory. |
| `url` | `str` or `None` | URL of the image if the input was a URL. |
| `frame_index` | `int` or `None` | Frame index if the input was a video. |
| `project_id` | `int` or `None` | ID of the Supervisely project associated with this prediction. Applicable if the input was a Supervisely ID. |
| `dataset_id` | `int` or `None` | ID of the Supervisely dataset associated with this prediction. Applicable if the input was a Supervisely ID. |
| `image_id` | `int` or `None` | ID of the image in the Supervisely platform associated with this prediction. Applicable if the input was a Supervisely ID. |
| `video_id` | `int` or `None` | ID of the video in the Supervisely platform associated with this prediction. Applicable if the input was a Supervisely video ID. |

#### `Prediction` methods

The `Prediction` object provides convenient methods for loading the original image and visualizing the predicted annotation.

| Method | Return Type | Description |
| --- | --- | --- |
| `visualize()` | `np.ndarray` | Draws the predicted annotation on the original image. If `save` or `save_dir` is provided, it saves the visualization to the specified path or directory. |
| `load_image()` | `np.ndarray` | Loads the image associated with this prediction. |

#### `visualize(save=None, save_dir=None, **kwargs)`

Visualizes the prediction by drawing annotations on the original image.

**Parameters:**
- `save_path` (`str`, optional): Path where the visualization should be saved. If provided, the method will save the visualization to this path.
- `save_dir` (`str`, optional): Directory where the visualization should be saved. If provided, the method will save the visualization with the same filename as the original image.
- `color` (`List[int]`, optional): Color of the shapes in the visualization.
- `thickness` (`int`, optional): Thickness of line counters. If `None`, the default thickness will be used.
- `opacity` (`float`, optional): Opacity of the shapes. Default is `0.5`.
- `draw_tags` (`bool`, optional): Whether to draw tags, such as confidence score. Default is `False`.
- `fill_rectangles` (`bool`, optional): Whether to fill the shapes with color. Default is `True`.

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
    p.visualize(
        save_dir="./results",
        thickness=2,  # Line thickness
        opacity=0.3,  # Opacity of shapes
        draw_tags=True,  # Draw tags
        fill_rectangles=True,  # Fill shapes with color
    )
```

#### Notes

- The `visualize()` method automatically handles loading the image and drawing the annotations on it.
- When using `save_dir`, the original filename (or image name) will be used for the output file.

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
| `status()` | `dict` | Returns a dictionary containing information about the status of a model and predictions process, including: `progress` (done / total), `message` (status message), `error` (traceback if an error occurred), `context` (project_id, dataset_id, etc.), resources (GPU: allocated by the model, allocated by all processes, total; RAM) |
| `progress()` | `dict` | Returns a progress (done / total) of the prediction process itself. |


```python
# Start predicting images in a directory
session = model.predict_detached(input="path/to/directory")

# Process first 10 images in directory
for i, prediction in enumerate(session):
    if i == 10:
        break
    # Do something with the prediction
    prediction.visualize(save_dir="./output")

# Stop processing images
session.stop()
```

## Uploading predictions

You can upload predictions to the Supervisely platform using the `upload_mode` argument in the `predict()` and `predict_detached()` methods. The available upload modes are:

| Upload Mode | Description |
| --- | --- |
| `create` | Create a new project on the platform and upload predictions to it. |
| `append` | Add new predictions to existing annotations. Only applicable if the input is an existing Project ID, Dataset ID, or Image IDs. |
| `replace` | Replace existing annotations with the new predictions. Only applicable if the input is an existing Project ID, Dataset ID, or Image IDs. |
| `iou_merge` | Append predictions to existing annotations, trying to avoid creating duplicate objects. This mode will check the IoU between each new prediction and existed objects, and filter out predictions which overlap with existed objects with high IoU (by default, the IoU threshold is set to 0.9). Only applicable for bounding box and mask predictions, and for existing Project ID, Dataset ID, or Image IDs. |

Example with uploading predictions to a source project:

```python
# Upload predictions to a project
predictions = model.predict(
    project_id=123,  # Input project ID
    upload_mode="append",  # or "create", "replace", "iou_merge"
)
```

## Predict video

The `predict()` and `predict_detached()` methods can also be used to process video files. The model will process the video frame by frame, returning predictions for each frame.

```python
# Predicting a video file
predictions = model.predict(
    video_id=42,
    stride=1,        # step between frames, 1 means process every frame
    start_frame=0,   # start frame to process (0-based)
    end_frame=2400,  # end frame (exclusive)
    num_frames=400,  # number of frames to process
    duration=10,     # duration in seconds
)

# Iterating frame predictions
for p in predictions:
    p.name  # Name of the video file
    p.frame_index  # Frame index of the prediction
```

#### Video settings

| Argument | Type | Default | Description |
| --- | --- | --- | --- |
| `stride` | `int` | `1` | Step between frames. 1 means process every frame, 2 means process every second frame, etc. |
| `start_frame` | `int` | `0` | Start frame to process (0-based). |
| `end_frame` | `int` | `None` | End frame (exclusive). If `None`, all frames will be processed. |
| `num_frames` | `int` | `None` | Number of frames to process. If `None`, all frames will be processed. |
| `duration` | `int` | `None` | Duration in seconds, the exact number of frames will be calculated based on the video FPS |

## Tracking objects in video

Supervisely now supports **tracking-by-detection** out of the box. We leverage a lightweight tracking algorithm (such as [BoT-SORT](https://github.com/NirAharon/BoT-SORT)) which identifies the unique objects across video frames and assigns IDs to them. This allows us to connect separate detections from different frames into a single track for each object.

To apply tracking via API, first, deploy your detection model or connect to it, and then use the `predict()` method with `tracking=True` parameter. You can also specify tracking configuration parameters by passing `tracking_config={...}` with your custom settings. See all available tracking settings in the [Video Object Tracking](video-object-tracking.md#hyperparameter-configuration).

```python
import supervisely as sly

api = sly.Api()

# Deploy a detector
model = api.nn.deploy(
    model="rt-detrv2/RT-DETRv2-M",
    device="cuda",
    workspace_id=YOUR_WORKSPACE_ID,
)

# Predict and track objects in a single API call
predictions = model.predict(
    video_id=YOUR_VIDEO_ID,  # Video ID in Supervisely
    tracking=True,  # Enable tracking
    tracking_config={
        "tracker": "botsort",  # botsort is a powerful tracking algorithm used by default
        # You can pass other tracking parameters here, see the docs for details
    }
)

# Processing results
for pred in predictions:
    frame_index = pred.frame_index
    annotation = pred.annotation
    track_ids = pred.track_ids
    print(f"Frame {frame_index}: {len(track_ids)} tracks")
```

> You can also use the tracker as a standalone model (without API calls) in your code or application. Read more details in the [Video Object Tracking](video-object-tracking.md).

## Predict settings (kwargs)

Here is a complete list of settings that can be passed to the `predict()` and `predict_detached()` methods in `**kwargs`. Additionally, you can pass the `inference settings` there. The inference settings are specific to the model you use, and can be found in the GUI of the Serving App, or in the model's documentation.

#### Sliding window settings

| Argument | Type | Default | Description |
| --- | --- | --- | --- |
| `sliding_window` | `bool` | `False` | Whether to use sliding window for large images. When `sliding_window=True`, the model will process the image in smaller patches, which is useful for large images. The size of a patch is controlled by `window_size`, and the `img_size` argument will now resize the original image before cropping it into patches. |
| `window_size` | `int` or `tuple` | `None` | Size of a sliding window patch that will be passed to the model. The `window_size` can be a tuple of (height, width) or a single integer for square patches. If `None`, the model's default input size will be used as `window_size`. |
| `overlap` | `float` or `int` | `0.0` | Overlap between sliding windows. Can be a float in range (0-1) representing a fraction of overlap, or an integer representing the overlap in pixels. |

**Example usage:**

```python
# Predicting a large image with sliding window
predictions = model.predict(
    input="path/to/large_image.jpg",
    sliding_window=True,     # Enable sliding window
    window_size=(640, 640),  # Size of sliding window patches
    overlap=0.0,             # 0% overlap between patches
)
```

#### Video settings

| Argument | Type | Default | Description |
| --- | --- | --- | --- |
| `stride` | `int` | `1` | Step between frames. 1 means process every frame, 2 means process every second frame, etc. |
| `start_frame` | `int` | `0` | Start frame to process (0-based). |
| `end_frame` | `int` | `None` | End frame (exclusive). If `None`, all frames will be processed. |
| `num_frames` | `int` | `None` | Number of frames to process. If `None`, all frames will be processed. |
| `duration` | `int` | `None` | Duration in seconds, the exact number of frames will be calculated based on the video FPS |
