# BotSort Tracker — Documentation  

## Introduction  

Tracking is a computer vision task where we follow object movement in a video.  
The algorithm works by the principle of **tracking by detection**:  
1. First, a neural network detects objects on each frame.  
2. Then the tracker “connects the dots” — it links the detected objects between frames and assigns them unique IDs.  

This helps us understand how each object moves, how many there are, and what happens to them during the video.  

Tracking is useful for tasks such as counting people or vehicles, analyzing trajectories, and behavior monitoring.  

### What is BotSort and how it differs  

**BotSort** is a modern tracker that we use as a base.  
In our implementation, we enhance it by integrating an improved OSNet-based ReID (re-identification) module instead of the FastReID version, which makes tracking more stable and reliable. 

#### Our enhancement: ReID with OSNet  

- We integrated ReID mechanism based on the **OSNet x1_0** architecture.  
- This allows us to use the visual appearance of objects, not just bounding box coordinates.  
- As a result, the tracker works better in complex scenes (e.g., when objects overlap).  
- OSNet weights are available here: *[model zoo](https://kaiyangzhou.github.io/deep-person-reid/MODEL_ZOO)*.  

---

## Ways to use the tracker  

You can use the tracker in three ways:  

1. **Apply NN to Video** — through the platform interface.  
2. **Via Prediction API** — programmatic access.  
3. **Apply to existing detections** — if you already have detections.  

---

## Apply NN to Video (through the interface)  

Best for beginners without programming experience.  

1. Deploy a model for Object Detection or Instance Segmentation.  
2. Load the **Apply NN** app, wait until it is ready, and open it.  
3. Select video, model, and classes.  
4. In parameters, enable **Tracking** (check the box).  
5. Choose the algorithm **BotSort** and select the device (CPU or GPU).  
6. In additional settings you can provide hyperparameters (see [Hyperparameter Configuration](##hyperparameter-configuration)).  

Example parameters:  

```yaml
track_high_thresh: 0.6
track_low_thresh: 0.1
new_track_thresh: 0.7
match_thresh: 0.8
with_reid: true
appearance_thresh: 0.25
```

![Screenshot](path_to_file)

## Tracking via prediction API

> [Prediction API documentation](https://docs.supervisely.com/neural-networks/overview-1/prediction-api)

This option is for developers who want to control the tracker from code.

Steps:

1. Deploy a model.
2. Call Prediction API for a video.
3. To enable tracking, add tracking=True in the request.
4. Pass tracker settings via tracking_config.

```python
import supervisely as sly

# API connection
api = sly.Api()
model = api.nn.connect(task_id=YOUR_TASK_ID)

# Video tracking
predictions = model.predict(
    video_id=42,
    start_frame=0,
    num_frames=100,
    tracking=True,
    tracking_config={
        "tracker": "botsort",
        "track_high_thresh": 0.6,
        "track_low_thresh": 0.1,
        "new_track_thresh": 0.7,
        "match_thresh": 0.8,
        "with_reid": True,
        "appearance_thresh": 0.25,
        "proximity_thresh": 0.5
    }
)

# Processing results
for pred in predictions:
    frame_index = pred.frame_index
    annotation = pred.annotation
    track_ids = pred.track_ids
    print(f"Frame {frame_index}: {len(track_ids)} tracks")
```

## Apply tracker to existing detections

If you already have detections, you can apply the tracker directly.

### Method 1: .update()
This method processes frame by frame.
Useful if you want step-by-step control or process long videos in parts.

{% tabs %}
{% tab title="Method 1: .update()" %}
```python
from supervisely.nn.tracker import BotSortTracker
import supervisely as sly
import numpy as np

# Data preparation (assuming you have frames and annotations)
frames = [...]  # list of numpy arrays
annotations = [...]  # list of sly.Annotation

# Tracker initialization
tracker = BotSortTracker(settings={
    "track_high_thresh": 0.6,
    "track_low_thresh": 0.1,
    "new_track_thresh": 0.7,
    "with_reid": True
})

tracker.reset() # reset the tracker, if necessary

for frame, annotation in zip(frames, annotations):
    matches = tracker.update(frame, annotation)
    
    # matches contains detection -> track correspondences
    for match in matches:
        track_id = match["track_id"]
        label = match["label"]
        print(f"Object {label.obj_class.name} assigned track ID: {track_id}")

# After applying .update() method, tracker accumulates video annotations
video_annotation = tracker.video_annotation
```
{% endtab %}
{% tab title="Method 2: .track()" %}
```python
tracker = BotSortTracker(settings={
    "track_high_thresh": 0.6,
    "track_low_thresh": 0.1,
    "new_track_thresh": 0.7,
    "with_reid": True
})

video_annotation = tracker.track(frames, annotations)

```
{% endtab %}
{% endtabs %}

### Method 2: .track()
This method processes the whole video at once.
Best if you already have all frames and predictions and just want one ready-to-use annotation.

```python
tracker = BotSortTracker(settings={
    "track_high_thresh": 0.6,
    "track_low_thresh": 0.1,
    "new_track_thresh": 0.7,
    "with_reid": True
})

video_annotation = tracker.track(frames, annotations)

```
Difference:
- .update() — step-by-step processing for flexibility.
- .track() — one-shot processing for convenience.
Both methods create a video_annotation object where each object is assigned a track_id.

## Hyperparameter Configuration

### Core Tracking Parameters

| Parameter | Default | Description |
|-----------|---------|-------------|
| `track_high_thresh` | 0.6 | High confidence threshold for detections. Detections with confidence above this value are used for primary association |
| `track_low_thresh` | 0.1 | Low confidence threshold. Detections between low and high thresh are used for secondary association |
| `new_track_thresh` | 0.7 | Threshold for creating new tracks. Detections with confidence above this threshold can become new tracks |
| `match_thresh` | 0.8 | IoU threshold for matching detections and tracks. Higher values mean stricter matching conditions |
| `track_buffer` | 30 | Number of frames a lost track remains in memory |
| `min_box_area` | 10.0 | Minimum bounding box area for tracking |

### ReID (Appearance) Parameters

| Parameter | Default | Description |
|-----------|---------|-------------|
| `with_reid` | true | Enable/disable ReID mechanism for enhanced association |
| `appearance_thresh` | 0.25 | Threshold for appearance similarity. Lower values mean stricter matching |
| `proximity_thresh` | 0.5 | Proximity threshold for ReID features |

### Algorithm Configuration

| Parameter | Default | Description |
|-----------|---------|-------------|
| `fuse_score` | false | Whether to fuse detection and ReID scores |
| `ablation` | false | Enable ablation study mode for research purposes |

### Camera Motion Compensation

| Parameter | Default | Description |
|-----------|---------|-------------|
| `cmc_method` | "sparseOptFlow" | Camera motion compensation method. Options: "orb", "sift", "ecc", "sparseOptFlow" |

### Performance & Hardware

| Parameter | Default | Description |
|-----------|---------|-------------|
| `device` | "auto" | Computing device ("cuda", "cpu", "auto"). Auto uses CUDA if available |
| `fp16` | false | Enable half-precision (FP16) computation for faster inference |
| `fps` | 30 | Video FPS for correct track_buffer calculation |


## Visualization

You can visualize the tracker’s results with the visualize function.
It accepts either predictions (from the API) or video annotations (from the tracker), the path to your input video, and the path to save the output video.

Additional options:
- show_labels: Display object labels.
- show_classes: Display object classes.
- show_trajectories: Draw object trajectories.

Both formats are supported:

### Method 1: Predictions

```python
import supervisely as sly
from supervisely.nn.tracker.visualize import visualize

# API connection
api = sly.Api()
model = api.nn.connect(task_id=YOUR_TASK_ID)

# Video tracking
predictions = model.predict(
    video_id=42,
    start_frame=0,
    tracking=True,
)

video_path = "path_to_your_video.avi"
output_path = "path_to_save_result.avi"

visualize(predictions, video_path, output_path, show_classes=False)
```

### Method 2: Video Annotations

```python
frames = [...]  # list of numpy arrays
annotations = [...]  # list of sly.Annotation

tracker = BotSortTracker(settings={
    "track_high_thresh": 0.6,
    "track_low_thresh": 0.1,
    "new_track_thresh": 0.7,
    "with_reid": True
})

video_annotation = tracker.track(frames, annotations)

video_path = "path_to_your_video.avi"
output_path = "path_to_save_result.avi"

visualize(video_annotation, video_path, output_path, show_trajectories=False)
```
The visualization video will be saved in the output_path.

## Metrics Evaluation

If you have ground truth data in the form of video annotations, you can evaluate the tracker’s performance using the evaluate function.
Simply pass predicted annotations and ground truth annotations:


```python
from supervisely.nn.tracker.calculate_metrics import evaluate

metrics = evaluate(video_ann_pred, video_ann_true)
```

The output includes several groups of metrics:

### Basic Detection Metrics  
- **Precision** — ratio of correct detections among all detections.  
- **Recall** — ratio of detected objects among all ground truth objects.  
- **F1** — harmonic mean of precision and recall.  
- **Average IoU** — average overlap between predicted and true bounding boxes.  
### MOT (Multiple Object Tracking) Metrics  
- **MOTA** (Multi-Object Tracking Accuracy) — overall accuracy, combining misses, false positives, and ID switches.  
- **MOTP** (Multi-Object Tracking Precision) — how precisely the tracker matches predicted and true positions.  
- **IDF1** — measures how well object identities are preserved across frames.  
- **ID Switches** — number of times the tracker assigned the wrong ID to the same object.  
- **Fragmentations** — how often a trajectory is broken into parts.  
- **Misses / False Positives** — counts of missed objects and false alarms.  
### Count Metrics  
- **True Positives / False Positives / False Negatives** — raw counts of detection outcomes.  
- **Total GT Objects / Predicted Objects** — number of objects in ground truth and predictions.  

These metrics give both a high-level and detailed view of how well the tracker is performing.  
