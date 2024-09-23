# Graph (Keypoints) Tool

## What is Graph Tool?

The **Graph (Keypoints) Tool** is designed for annotating key points on images and videos, providing an accurate way to analyze poses of objects such as humans and animals. This tool is particularly useful for tasks related to pose estimation, including movement tracking, gesture analysis, and behavior understanding.&#x20;

## Video Tutorial

To better understand how to use the **Graph (Keypoints) Tool** for pose estimation, watch our video tutorial. For animal pose estimation, you can also check out the video: [**"ViTPose — How to Use the Best Pose Estimation Model on Animals | Computer Vision Tutorial"**](https://www.youtube.com/watch?v=piryWAGuyZk\&ab\_channel=Supervisely). These tutorials provide straightforward instructions on using the Keypoints Tool for both human and animal pose estimation.

{% embed url="https://www.youtube.com/watch?ab_channel=Supervisely&v=CQBN5e-t_GE" %}

## **How to Use the Graph (Keypoints) Tool**

Follow this step-by-step guide to learn how to use the Graph (Keypoints) Tool effectively for pose annotation:

### **Create a Keypoint Class**

1. On the **Project** page, navigate to the **Definitions** section.
2. Click **+ New Class** and enter a name, select Keypoints shape and choose color.
3. Define the key points and connections:
   * Add key points that represent the object's pose (e.g., head, torso, limbs for a human skeleton).
   * Use the `Add Node` button to place keypoints on an example image, and connect them with the `Add Edge` button to create a complete skeleton structure.
   * Assign descriptive names to each point or edge and click Save to finalize the class template.
4. Your defined keypoint class will be saved and ready to use in annotation tasks.

***

### Manually apply the keypoint template

1. Open an image or video in the Annotation Toolbox.
2. Select the pre-defined keypoint template created in the previous step.
3. Place the points on the image according to the object's pose. To do this, click once on the edges of the object in the image and map them to the keypoints in the template.
4. Correct the existing points using `Drag a point to move`, `Disable/Enable point` and `Remove point` buttons so that they repeat the subject pose.

***

### AI-assisted annotation with VitPose

The **ViTPose** model provides AI-powered assistance for keypoint annotation, enabling automatic pose estimation for animals and humans.

#### **Run Serve ViTPose app.**&#x20;

1. Go to **Ecosystem** page and find the app [Serve ViTPose](https://ecosystem.supervisely.com/apps/vitpose/serve). Also, you can run it from the **Neural Networks** page from the category **Images** → **Pose Estimation (Keypoints)** → **Serve**.
2. **Select the ViTPose+ pre-trained model** for animal pose estimation and the type of animal you're interested in, press `Serve` button and wait for the model to deploy.

{% hint style="info" %}
If you select a model for animal pose estimation, you will also see a list of supported animal species and basic information about the pitfalls of animal pose estimation.
{% endhint %}

#### **Apply** [**ViTPose**](https://ecosystem.supervisely.com/apps/vitpose/serve) **to images in the labeling tool.**&#x20;

3. Run [NN Image Labeling](https://ecosystem.supervisely.com/apps/nn-image-labeling/annotation-tool) app, connect to ViTPose, create a bounding box with the animal's type name, and click on `Apply the model to ROI`.

{% hint style="warning" %}
For the animal pose estimation task, you need to create a bounding box with the class name, which is presented in the list of supported animal species; keypoints skeleton class with the name {yourclassname}keypoints will be created. Otherwise, the keypoints skeleton class with the name animalkeypoints will be created.
{% endhint %}

4. **Correct keypoints.** If there is only a part of the target object on the image, then you can increase the point threshold in app settings to get rid of unnecessary points. Correct the existing points using `Drag a point to move`, `Disable/Enable point`, `Remove point` buttons so that they repeat the animal's pose.

{% hint style="info" %}
**Pro Tip:** Increase the point threshold in app settings to avoid unnecessary key points if only part of the object is visible.
{% endhint %}

***

### **Autolabeling Pipeline: Detection using YOLOv8 + Pose Estimation with ViTPose**

An efficient way to automate pose annotation is by combining **YOLOv8** for object detection with **ViTPose** for pose estimation. This combination significantly reduces manual work and speeds up the annotation process. Steps to use the autolabeling pipeline:

**Run the YOLOv8 app for detection.**

1. Go to the **Ecosystem** page, find and run the [Serve YOLOv8](https://ecosystem.supervisely.com/apps/yolov8/serve) app under **Images → Object Detection → Serve**.
2. Deploy the app as a REST API service and select a pre-trained model based on your task requirements.

**Apply detection and pose estimation models to images project:**

3. Use the [Apply Detection and Pose Estimation Models to Images Project ](https://ecosystem.supervisely.com/apps/apply-det-and-pose-estim-models-to-project)app found in the **Ecosystem** or **Images → Pose Estimation (Keypoints) → Inference interfaces**.
4. Configure the settings, and this app will automatically apply the detection and pose estimation models to your images.

{% hint style="success" %}
**Outcome:** This combination allows you to quickly identify objects and automatically add accurate pose keypoints, even for complex or blurry objects.
{% endhint %}

5. After applying AI-assisted annotation, you may need to fine-tune keypoints manually:

* **Drag Points** to adjust their position.
* **Enable/Disable Points** to toggle visibility as needed.
* **Remove Points** if the AI has incorrectly placed them.

***

## Hotkeys

| Graph (Keypoints) Tool     |                                  |
| -------------------------- | -------------------------------- |
| Place predefined template  | `Left Mouse Click`               |
| Toggle keypoint visibility | `Command (⌘) + Left Mouse Click` |
| Remove keypoint            | `Shift + Left Mouse Click`       |

| Scene Navigation                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Zoom with Mouse wheel. Hold <img src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBzdGFuZGFsb25lPSJubyI/Pgo8IURPQ1RZUEUgc3ZnIFBVQkxJQyAiLS8vVzNDLy9EVEQgU1ZHIDIwMDEwOTA0Ly9FTiIKICJodHRwOi8vd3d3LnczLm9yZy9UUi8yMDAxL1JFQy1TVkctMjAwMTA5MDQvRFREL3N2ZzEwLmR0ZCI+CjxzdmcgdmVyc2lvbj0iMS4wIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciCiB3aWR0aD0iMTAwLjAwMDAwMHB0IiBoZWlnaHQ9IjEwMC4wMDAwMDBwdCIgdmlld0JveD0iMCAwIDEwMC4wMDAwMDAgMTAwLjAwMDAwMCIKIHByZXNlcnZlQXNwZWN0UmF0aW89InhNaWRZTWlkIG1lZXQiPgoKPGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoMC4wMDAwMDAsMTAwLjAwMDAwMCkgc2NhbGUoMC4xMDAwMDAsLTAuMTAwMDAwKSIgc3Ryb2tlPSJub25lIj4KPHBhdGggZD0iTTQzMiA5MTAgYy0xMDUgLTIyIC0yMDQgLTEwNyAtMjQyIC0yMDYgLTI5IC04MCAtMjkgLTMyOCAwIC00MDggMjkKLTc2IDg4IC0xMzkgMTY2IC0xNzcgNTcgLTI4IDc2IC0zMyAxNDQgLTMzIDY4IDAgODcgNSAxNDQgMzMgNzggMzggMTM3IDEwMQoxNjYgMTc3IDI5IDgwIDI5IDMyOCAwIDQwOCAtNTUgMTQ1IC0yMjQgMjM4IC0zNzggMjA2eiBtMjggLTIwNSBsMCAtMTI1IC0xMDYKMCAtMTA3IDAgNyA0MSBjOSA1OSA0MCAxMTMgODUgMTUwIDMzIDI4IDg2IDU1IDExNCA1OCA0IDEgNyAtNTUgNyAtMTI0eiBtMjg4Ci0yODIgYy02IC05NCAtMjkgLTE0NSAtOTAgLTE5NyAtODkgLTc3IC0yMjcgLTc3IC0zMTYgMCAtNjEgNTIgLTg0IDEwMyAtOTAKMTk3IGwtNSA3NyAyNTMgMCAyNTMgMCAtNSAtNzd6Ii8+CjwvZz4KPC9zdmc+Cg==" alt="" data-size="line"> to move scene. |
