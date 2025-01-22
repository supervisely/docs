## Introduction

Supervisely covers the entire model lifecycle from training to production deployment and applying model to images, video, and 3D data. Supervisely Platform offers comprehensive support in each step of the model lifecycle and ease your model development. In many standard cases, you don't even need to write a single line of code, but for extensive customization, you can!

![][image1]

## Train

In Supervisely Platform you can train popular models and frameworks on your data with the help of convenient UI, and the modular design of the platform enables you to modify train apps for you needs and even integrate your custom models and architectures.

- Train popular models, such as [YOLOv8 - YOLOv11](https://ecosystem.supervisely.com/apps/yolov8/train), [RT-DETRv2](https://ecosystem.supervisely.com/apps/rt-detrv2/supervisely_integration/train), [MMDetection](https://ecosystem.supervisely.com/apps/train-mmdetection-v3), [SAM 2](https://ecosystem.supervisely.com/apps/serve-segment-anything-2/train).
- Open source.
- No vendor lock: use your models out of Supervisely Platform as standalone PyTorch models or within Python Supervisely SDK.
- Auto export to ONNX, TensorRT, Pytorch, OpenVINO runtimes if framework supports it.
- Auto-training: Automate model training via API to handle custom model improvement scenarios.
- Tracking of data changes and model versions – all your experiments are reproducible.
- Integrate training of your custom models and architectures.
- Active Learning support: continuous model improvement by learning from newly added data with efficient sampling strategies.
- Workflow charts: Visual dashboard that shows every ML operation – from data preparation to model deployment – all in one clear diagram.

## Evaluate

After training, the [Model Evaluation Benchmark](model-evaluation-benchmark) will be automatically launched for the best checkpoint, and you will be able to examine a detailed report with model performance results, which covers a broad set of metrics, charts, and prediction visualizations.

- Auto model evaluation after each training session.
- Very detailed evaluation report with a wide set of metrics, charts, and prediction visualizations.
- Currently supported for Detection, Instance segmentation, Semantic segmentation.
- You can launch the evaluation manually for every checkpoint.

![][image2]

## Model Comparison & Versioning

Each model trained in Supervisely is recorded in the Experiments table, which displays all your trained models, their metrics, links to train and val datasets, evaluation report, and other useful information. In addition to the evaluation report of a single model, you can generate a comparison report of two or more models, which allows you to compare models in as much detail as during the evaluation stage – it will include various pivot tables, charts and comparison tools. Additionally, you can quickly deploy models or fine-tune them right from the Experiments table.

- The Experiments table with all your trained models and experiments.
- Quickly deploy models or fine-tune them right from the Experiments table.
- Generate very detailed comparison reports of two or more models, this includes various pivot tables, charts and comparison tools.
- Data and model versioning.
- Data and model workflow diagrams - to understand, reproduce, track changes of all your ML operations.

**Experiments (скриншот):**

![][image3]

## Deploy

After your model has been trained, validated, and is ready for use, you can deploy it as API service in different ways:

1. **In-Platform serve:** Deploy it via Serving Apps in Supervisely Platform.
2. **Local deployment:** You can just download a checkpoint and deploy it locally on your machine, or use it as a standalone PyTorch model in your scripts.
3. **Docker Container:** Deploy a model in a docker container on your local machine.

Thus, there is no vendor lock, you can use your models the same way, as if you trained it manually with your own code.

## Predict

After you've deployed a model, you can interact with your model in different ways:

1. **Apply model in platform:** Use convenient Supervisely Apps with GUI to get predictions. [Apply NN to Images](https://ecosystem.supervisely.com/apps/nn-image-labeling/project-dataset), [Apply NN to Videos](https://ecosystem.supervisely.com/apps/apply-nn-to-videos-project).
2. **SessionAPI:** Communicate with deployed model using our python SDK, which has convenient methods for efficient model inference on images, projects, and even videos. We also support Tracking-by-detection algorithms, such as BoT-Sort.
3. **Predict with Supervisely SDK:** Deploy a model locally and interact with it through Supervisely SDK.
4. **Predict with CLI arguments:** Interact with model through CLI commands, or within Docker Container.
5. **Standalone PyTorch model:** Use your trained checkpoints out of Supervisely infrastructure in your code as a simple pytorch model.

With the help of Supervisely SDK and Apps, you can easily apply your model to:

- **Project or dataset of images.**
- **Folder of images** on your machine.
- **Video**. Our SDK automatically breaks video into frames, and the model is applied frame-by-frame.
- **Tracking by detection.** We offer ready-to-use scripts for quickly using your detector for tracking tasks.
- **3D Lidar data and medical data.**

We connect all neural networks together with the use of unified API and data format. Thus, you don't need to write boilerplate code for many use cases, such as, applying a model to a dataset or a video. This allowed us to build a wide ML Ecosystem to cover the entire lifecycle of neural networks: from data labeling to continuous model development.
