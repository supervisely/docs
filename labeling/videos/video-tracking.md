---
hidden: true
---

# Video tracking

One of the most common tasks in the video labeling toolbox is the video tracking. Supervisely has the top AI models and automatic video annotation tools you can use to efficiently track objects on videos.

### What is Visual Object Tracking?

Visual Object Tracking involves predicting the position of a target object in each frame of a video. The primary subtasks in Visual Object Tracking include:

* Single Object Tracking (SOT)
* Multiple Object Tracking (MOT)
* Semi-Supervised Class-Agnostic Multiple Object Tracking
* Video Object Segmentation (VOS)

#### Why video object tracking is challenging

Creating custom datasets for tracking is labor-intensive. For example, a one-hour video at 24 frames per second contains 86,400 frames. If each frame contains 8-12 objects, this results in about a million objects to track. Automating this process with AI models and tools can significantly reduce the workload.

## Deploying an AI tracking model

Apart from other solutions, Supervisely is built like an OS. Instead of having a fixed number of video tracking algorithms, we provide a constantly growing Ecosystem of the best models. Pick the one you like, deploy it on your agent, select it in the Track Settings panel - and enjoy!

{% hint style="info" %}
For our Community Edition users we have a MixFormer model deployed on our GPUs and shared with everyone - but you can always run an agent on your computer and deploy any other model you like!
{% endhint %}

## Some of the integrated AI tracking models:

* [TransT object tracking (CVPR2021)](https://ecosystem.supervisely.com/apps/trans-t/supervisely/serve)
* [MixFormer object tracking (CVPR2022)](https://ecosystem.supervisely.com/apps/mixformer/serve/serve)
* [PIPs object tracking](https://ecosystem.supervisely.com/apps/pips/supervisely/serve)
* [TAP-Net object tracking](https://ecosystem.supervisely.com/apps/serve-tapnet/tapnet/supervisely/serve)
* [CoTracker object tracking](https://ecosystem.supervisely.com/apps/co-tracker/supervisely\_integration/serve)

## Types of Object Tracking

### Single Object Tracking (SOT)

SOT involves tracking one object throughout the video based on a manual annotation on the first frame. The annotation, called a template, is used by a neural network to locate the object in subsequent frames. These models are class-agnostic, meaning they can track any object based on the initial annotation.

#### Models and Tools:

* [MixFormer object tracking (CVPR2022)](https://ecosystem.supervisely.com/apps/mixformer/serve/serve)
* [TransT object tracking (CVPR2021)](https://ecosystem.supervisely.com/apps/trans-t/supervisely/serve)
* [Supervisely Video Labeling Toolbox](https://ecosystem.supervisely.com/annotation\_tools/video-labeling-tool)

#### How to use:

1. **Label the first frame:** Annotate the target object with a bounding box on the first frame.
2. **Track automatically:** Use a class-agnostic neural network to track the object in subsequent frames automatically.

### Multiple Object Tracking (MOT)

MOT detects and tracks multiple objects of predefined classes, estimating their trajectories. The process involves two steps: detecting objects in each frame and associating detections across frames to form tracklets. This approach is known as the Tracking-by-Detection paradigm.

#### Models and Tools:

* YOLO
* DeepSort Algorithm
* **Supervisely Apps:** [Serve YOLO v5](https://ecosystem.supervisely.com/apps/yolov5/supervisely/serve), [Apply NN to Videos Project](https://ecosystem.supervisely.com/apps/apply-nn-to-videos-project)

#### How to use:

1. **Object detection:** Use a detection model like YOLOv5 to predict bounding boxes on each frame.
2. **Tracking algorithm:** Apply a tracking algorithm (e.g., DeepSort) to link detections and form object trajectories.

### Semi-Supervised Class-Agnostic Multiple Object Tracking

This approach combines the simplicity of SOT with the ability to track multiple objects. By applying an SOT model to each object on the first frame, users can track and correct multiple objects simultaneously, enhancing annotation speed and accuracy.

#### How to use:

1. **Apply SOT to each object:** Use an SOT model to track each object from the first frame.
2. **Correct and re-track:** Correct tracking predictions and re-track objects as needed.

### Video Object Segmentation (VOS)

VOS tracks objects in videos using masks instead of bounding boxes. The user labels the object mask on the first frame, and the model segments and tracks the object in subsequent frames.

#### Models and Tools:

* [Segment Anything 2 Model](https://ecosystem.supervisely.com/apps/serve-segment-anything-2)
* [XMem Video Object Segmentation Model](https://ecosystem.supervisely.com/apps/xmem/supervisely\_integration/serve)

#### How to use with steps:

#### Step 1. Connect GPU to Supervisely:

* Use a single command in the terminal to connect your personal computer with GPU to the Supervisely account.
* Watch this [1.5-minute how-to video.](https://youtu.be/aO7Zc4kTrVg)

#### Step 2. Run Segment Anything Model (SAM):

* Deploy the SAM for fast object segmentation on the first frame.
* Start the app, select a pre-trained model, and deploy via the GUI.
* Interactive segmentation allows users to provide feedback to the model by marking positive and negative points on the image.

#### Step 3. Run XMem Model:

* Serve the XMem model on a computer with GPU.
* Go to the Neural Networks page and select the XMem model for video segmentation.

#### Step 4. Segment and Track Objects on Videos:

* Use the video labeling toolbox to select objects and track masks in subsequent frames.
* Apply the tracking algorithm and review results.

Check out our tutorial or or watch this 5-minute video to learn what object tracking is and how to track objects in your videos with the best models and tools.

{% embed url="https://supervisely.com/blog/complete-guide-to-object-tracking-best-ai-models-tools-and-methods-in-2023/" %}

{% embed url="https://www.youtube.com/watch?ab_channel=Supervisely&v=nyMilMvF3FM" %}
