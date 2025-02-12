## Introduction

Supervisely covers the entire model lifecycle, from training to production deployment, enabling you to apply models to images, videos, and 3D data. The Supervisely Platform provides comprehensive support at every stage of the model lifecycle and simplifies model development. In many standard cases, you don't even need to write a single line of code, but for advanced customization, you can!

![The Entire Model Lifecycle](/.gitbook/assets/neural-networks/schema.png)

## Train

In the Supervisely Platform, you can train popular models and frameworks on your data using a convenient UI. The platform's modular design allows you to customize training apps to suit your needs and even integrate your own models and architectures.

- **Train popular models:** [YOLOv8 - YOLOv11](https://ecosystem.supervisely.com/apps/yolov8/train), [RT-DETRv2](https://ecosystem.supervisely.com/apps/rt-detrv2/supervisely_integration/train), [MMDetection](https://ecosystem.supervisely.com/apps/train-mmdetection-v3), [SAM 2.1](https://ecosystem.supervisely.com/apps/serve-segment-anything-2/train).
- **Open source:** All apps and Supervisely SDK are open-source, you can customize them to your needs.
- **No vendor lock:** You aren't locked within Supervisely. Use your trained models outside of Supervisely Platform as standalone PyTorch models or with the help of Python Supervisely SDK.
- **Model Auto-export:** Export PyTorch models to ONNX, TensorRT, OpenVINO runtimes if framework supports it.
- **Automate Training:** Automate model training via API to handle custom model improvement scenarios.
- **Model & Data Versioning:** All your experiments are reproducible. You can "commit" data changes and keep track of model versions.
- **Integrate Custom Models:** You can integrate your own model architectures for training and inference to be seamlessly integrated into the platform.
- **Active Learning support:** Continuous model improvement by learning from newly added data with efficient sampling strategies.
- **Workflow charts:** Visual dashboard that shows every ML operation – from data preparation to model deployment – all in one clear diagram.

## Evaluate

After training, the [Model Evaluation Benchmark](model-evaluation-benchmark) will be automatically launched for the best checkpoint, and you will be able to examine a detailed report with model performance results, which covers a broad set of metrics, charts, and prediction visualizations.

![Evaluation Benchmark Example](/.gitbook/assets/benchmark_report.gif)

- Auto model evaluation after each training session.
- Very detailed evaluation report with a wide set of metrics, charts, and prediction visualizations.
- Currently supported for Detection, Instance segmentation, Semantic segmentation.
- You can launch the evaluation manually for every checkpoint.

## Model Comparison & Versioning

Each model trained in Supervisely is recorded in the Experiments table which displays all your trained models, their metrics, links to train and val datasets, evaluation report, and other useful information. In addition to the evaluation report of a single model, you can generate a comparison report of two or more models allowing you to compare models in as much detail as during the evaluation stage – it will include various pivot tables, charts and comparison tools. Additionally, you can quickly deploy models or fine-tune them right from the Experiments table.

- The Experiments table with all your trained models and experiments.
- Quickly deploy models or fine-tune them right from the Experiments table.
- Generate very detailed comparison reports of two or more models, this includes various pivot tables, charts and comparison tools.
- Data and model versioning.
- Data and model workflow diagrams - to understand, reproduce, track changes of all your ML operations.

## Deploy

After your model has been trained, validated, and is ready for use, you can deploy it as API service in different ways:

1. **[Supervisely Serving Apps](inference-and-deployment/supervisely-serving-apps.md)** within the Platform. Faster and user-friendly way with convenient web UI.  
2. **[Deploy with Supervisely Python SDK](inference-and-deployment/deploy_and_predict_with_supervisely_sdk.md)** for automated model inference: Use Supervisely SDK for deploying models and getting predictions in your code.  
3. **[Using Standalone PyTorch Models](inference-and-deployment/using-standalone-pytorch-models.md)**: You can always download a plain PyTorch checkpoint and use it outside of Supervisely infrastructure in your code, or download its ONNX / TensorRT exported versions.

There is no vendor lock, you can use your models the same way, as if you trained it manually with your own code.

## Predict

After you've deployed a model, you can interact with it in different ways:

1. **Apply model in platform:** If you deployed a model via a [Supervisely Serving App](inference-and-deployment/supervisely-serving-apps.md), you can predict easily with NN Applying app with web UI. [Apply NN to Images](https://ecosystem.supervisely.com/apps/nn-image-labeling/project-dataset), [Apply NN to Videos](https://ecosystem.supervisely.com/apps/apply-nn-to-videos-project).
2. **SessionAPI:** Communicate with the deployed model using [Supervisely python SDK](https://developer.supervisely.com/app-development/neural-network-integration/inference-api-tutorial), which has convenient methods for efficient model inference on images, projects and videos. We also support Tracking-by-detection algorithms, such as BoT-Sort.
3. **Predict with Supervisely SDK:** Deploy a model locally and interact with it through [Inference API](https://developer.supervisely.com/app-development/neural-network-integration/inference-api-tutorial).
4. **Predict with CLI arguments:** In case you [deploying model locally](inference-and-deployment/deploy_and_predict_with_supervisely_sdk.md#deploy-model-as-a-server) or in a [docker container](inference-and-deployment/deploy_and_predict_with_supervisely_sdk.md#deploy-in-docker-container), you can do it with a simple command line interface, and get predictions in a few seconds.
5. **Standalone PyTorch model:** Use your trained checkpoints out of Supervisely infrastructure in your code as a simple pytorch model (see more details in [Using Standalone PyTorch Models](inference-and-deployment/using-standalone-pytorch-models.md)).

With the help of Supervisely SDK and Apps, you can easily apply your model to:

- **Project or dataset of images.**
- **Folder of images** on your machine.
- **Video**. Our SDK automatically breaks video into frames, and the model is applied frame-by-frame.
- **Tracking by detection.** We offer ready-to-use scripts for quickly using your detector for tracking tasks.
- **3D Lidar data and medical data.**

We connect all neural networks together with the use of unified API and data format. Thus, you don't need to write boilerplate code for many use cases, such as, applying a model to a dataset or a video. This allowed us to build a wide ML Ecosystem to cover the entire lifecycle of neural networks: from data labeling to continuous model development.
