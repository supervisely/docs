# Automatic Video Object Tracking

Object tracking is a technology that automatically monitors object positions in each video frame. Instead of manually labeling thousands of frames, you can use AI models to automate this process. Auto-tracking reduces labeling time by tens of times, ensuring consistent quality and allowing you to process large volumes of data without proportionally increasing your annotation team.

Supervisely offers two main approaches to auto-tracking, each suited for different scenarios.

---

## Two Approaches to Video Object Tracking

There are two fundamentally different ways to track objects in videos, and they differ in how you start the tracking process.

**Tracking-by-Detection** works on completely unlabeled videos. A detector (like YOLO or RT-DETRv2) runs on every frame to find objects of predefined classes, then a tracking algorithm links these detections across frames and assigns each object a unique ID. You press one button on an empty video and get automatic annotations for all objects of the classes your detector can recognize.

**First Frame Initialized Tracking** requires you to manually annotate objects first. You create annotations on the objects you want to track, and then the tracking model follows these specific objects through subsequent frames. The model uses your initial annotations as templates and tracks exactly those objects you selected, regardless of their class.

The key difference: tracking-by-detection creates annotations from scratch automatically on unlabeled video, while first frame initialized tracking continues tracking from your manually created annotations.

---

## 1. Tracking-by-Detection

### What It Is

Tracking-by-Detection is an approach where a detector runs on each video frame to detect objects of predefined classes, and then a tracking algorithm (e.g., BoT-SORT) links these detections between frames and assigns each object a unique ID. The detector finds objects in each frame, the tracker links detections between frames and forms object trajectories, assigning each a unique ID that persists throughout the video.

### When to Use

This method is suitable when you have a detection model (custom-trained or pre-trained) that can predict the object classes you need to track. It works well for scenes with multiple objects of known classes, automatically handles new objects appearing in the frame, and deals with occlusions and scale changes. Best for tasks where you want to automatically label all objects of specific classes without manually annotating each one.

### How to Use

The most convenient way for annotators is to launch tracking-by-detection directly from the labeling tool:

1. Deploy an object detection or segmentation model ([how to deploy a model](../../neural-networks/inference-and-deployment/supervisely-serving-apps.md#how-to-deploy-a-model))
2. Open the video in the labeling tool and click the blue Track button at the top of the interface
3. In the "tracking-by-detection engine" field, select your deployed model and click the "tracking-by-detection" button
4. Annotations with tracks will automatically load into your video

![Tracking in labeling tool](../../.gitbook/assets/neural-networks/tracking_labeling_tool.jpg)

Besides the labeling tool, tracking-by-detection is available through [Predict APP](https://ecosystem.supervisely.com/apps/apply-nn) — a universal application for applying neural networks to video, through [API](../../neural-networks/inference-and-deployment/video-object-tracking.md#option-4-tracking-via-api) for integration into your pipeline, or for [local execution](../../neural-networks/inference-and-deployment/video-object-tracking.md#option-5-run-tracker-locally) in your code via Supervisely SDK.

For a complete guide on tracking-by-detection, parameter configuration, and usage, see the [Video Object Tracking](../../neural-networks/inference-and-deployment/video-object-tracking.md) documentation. Additional information about working in the labeling tool can be found in the [Video Labeling Tool documentation](../labeling-toolbox/videos-3.0.md).

---

## 2. First Frame Initialized Tracking

### What It Is

First Frame Initialized Tracking in Supervisely is implemented through the [Auto Track app](https://ecosystem.supervisely.com/apps/auto-track), which uses class-agnostic tracking models. These models can track any object based on your initial annotation.

The workflow is straightforward: you create annotations (bounding boxes, masks, or skeletons) on the objects you want to track on the current frame, and the model automatically tracks these specific objects through subsequent frames. The neural network uses your annotations as templates and follows the visual characteristics of the selected objects. Class-agnostic means the model doesn't need to know what you're tracking (person, car, animal) — it simply follows the visual features of whatever you've annotated.

### When to Use

This approach is ideal when you need to track specific individual objects rather than all objects of a class. For example, tracking "this particular red car" rather than "all cars", tracking objects without a ready-made detection model, or tracking a small number of specific objects (1-20) in the frame. Also useful for correcting tracking errors — when you need to fix a mistake and re-track an object from the current frame forward.

### How to Use

1. Open [Auto Track app](https://ecosystem.supervisely.com/apps/auto-track) from the Supervisely Ecosystem and click "Run Application" button
2. Select Neural Network models for the geometries you want to track
   - You can also deploy a new model directly from the app UI by clicking "Deploy new model" button, selecting the model, agent, and clicking "Deploy model"
3. Start tracking in Video Labeling Tool:
   - Open your video in Video Labeling Tool
   - Create annotations on the objects you want to track
   - Select "Auto-Track" application in the tracking engine dropdown at the top of the interface
   - The app will automatically track objects when you create or edit them, or click the "track" button to start tracking all objects in the current frame

![Auto-track in labeling tool](../../.gitbook/assets/auto-track.jpg)

For detailed information about Auto Track features and settings, see the [Auto Track app documentation](https://ecosystem.supervisely.com/apps/auto-track). Additional information about the annotation workflow is available in the [Video Labeling Tool](../labeling-toolbox/videos-3.0.md) documentation.

---

## Additional Resources

Complete documentation on [Video Object Tracking](../../neural-networks/inference-and-deployment/video-object-tracking.md) contains detailed descriptions of tracking-by-detection, tracker parameters, and API. A guide to working in the modern video labeling interface can be found in the [Video Labeling Tool 3.0](../labeling-toolbox/videos-3.0.md) documentation. An overview of tracking types and available models is in [Video Tracking Overview](../videos/video-tracking.md). A catalog of all available models and applications is in [Supervisely Ecosystem](https://ecosystem.supervisely.com/).