# Neural Networks Overview

## Intro: Supervisely Neural Network Lifecycle

Supervisely provides a complete ecosystem for developing, training, and deploying neural networks, covering the entire machine learning lifecycle from data preparation to production deployment. Our platform is designed to simplify complex processes of NN model development into a seamless and flexible workflow.

With Supervisely, you can:

- Annotate data with advanced labeling tools and [AI-assisted features](https://supervisely.com/blog/smarttool-annotation/).
- Manage datasets effectively with [AI Search](https://docs.supervisely.com/data-organization/project-dataset/ai-search), organize them, and ensure quality control through interactive dashboards and statistics, see [Quality Assurance and Statistics](/data-organization/project-dataset/quality-assurance-and-statistics/README.md).
- Train state-of-the-art open-source [models](https://ecosystem.supervisely.com/train) on your own hardware or in the cloud.
- Evaluate models with detailed metrics, visualizations, and per-image statistics (check our [Detection Evaluation Dashboard](model-evaluation-benchmark/object-detection.md)).
- Track experiments, compare results, and reproduce any run with [Supervisely Experiments](training/experiments.md).
- Deploy trained models as APIs, Docker containers, or simple Python scripts (see [Inference & Deployment](inference-and-deployment/README.md)).
- Use models for prediction, pre-labeling, and video analysis via [Prediction API](inference-and-deployment/prediction-api.md).
- Continuously improve your models through active learning and human-in-the-loop workflows.
- Export model weights to multiple formats (PyTorch, ONNX, TensorRT) without vendor lock-in. Your checkpoints can be used [outside of Supervisely](inference-and-deployment/using-standalone-pytorch-models.md).

<figure><img src="/.gitbook/assets/neural-networks/training/experiments-scheme.jpg" alt="NN Lifecycle"><figcaption></figcaption></figure>

## Train

In the Supervisely Platform, you can train popular models and frameworks on your data with ease. The platform's modular design allows you to customize training apps to suit your needs and even integrate your own models and architectures. Every training session is tracked in the [Experiments](training/experiments.md) table, which records all relevant information about your models, datasets, and evaluation reports.

<figure><img src="../../.gitbook/assets/neural-networks/training/experiments-location.jpg" alt="Experiment location"><figcaption></figcaption></figure>

- **Train state-of-the-art models:** [YOLOv8 - YOLOv12](https://ecosystem.supervisely.com/apps/yolo/supervisely_integration/train), [RT-DETRv2](https://ecosystem.supervisely.com/apps/rt-detrv2/supervisely_integration/train), [MMDetection](https://ecosystem.supervisely.com/apps/train-mmdetection-v3), [SAM 2.1](https://ecosystem.supervisely.com/apps/serve-segment-anything-2/train).
- **Open source:** All apps and Supervisely SDK are open-source, you can customize them to your needs.
- **No vendor lock:** You aren't locked within Supervisely. Use your trained models outside of Supervisely Platform as standalone PyTorch models or with the help of Supervisely SDK.
- **Model Export:** Export models to ONNX, TensorRT formats for optimized inference.
- **Automate Training:** Automate model training via API to handle custom scenarios.
- **Model & Data Versioning:** All your experiments are reproducible. Whenever you start training, a snapshot of your data is created. You can always return to previous versions of your data and models.
- **Integrate Custom Models:** You can integrate your own model architectures for training and inference to be seamlessly integrated into the platform.
- **Active Learning support:** Continuous model improvement by learning from newly added data with efficient sampling strategies.
- **Workflow charts:** Visual dashboard that shows every ML operation – from data preparation to model deployment – all in one clear diagram.

## Evaluate

In the end of the training, the [Model Evaluation Benchmark](model-evaluation-benchmark) will be launched automatically for the best checkpoint, and you will be able to examine a detailed evaluation report with performance results. It covers a broad set of metrics, charts, and visualizations.

![Evaluation Benchmark Example](/.gitbook/assets/benchmark_report.gif)

- Auto model evaluation after each training session.
- Very detailed evaluation report with a wide set of metrics, charts, and prediction visualizations.
- You can launch the evaluation manually for every checkpoint.
- Currently supported for Detection, Instance segmentation, Semantic segmentation.

## Model Comparison & Versioning

Each model trained in Supervisely is recorded in the [Experiments](training/experiments.md) table which displays all your trained models, their metrics, links to train and val datasets, evaluation report, and other useful information. In addition to the evaluation report of a single model, you can generate a comparison report of two or more models allowing you to compare models in as much detail as during the evaluation stage – it will include various pivot tables, charts and comparison tools. Additionally, you can quickly deploy models or fine-tune them right from the Experiments table.

> Read more in [Experiments](training/experiments.md) documentation.

- The Experiments table with all your trained models and experiments.
- Quickly deploy models or fine-tune them right from the Experiments table.
- Generate very detailed comparison reports of two or more models, this includes various pivot tables, charts and comparison tools.
- Data and model versioning.
- Data and model workflow diagrams - to understand, reproduce, track changes of all your ML operations.

## Deploy

After your model has been trained, validated, and is ready for use, you can deploy it as API service in different ways:

1. **[Supervisely Serving Apps](inference-and-deployment/supervisely-serving-apps.md)** within the Platform. Faster and user-friendly way with convenient web UI.
2. **[Deploy & Predict via API](inference-and-deployment/prediction-api.md)**: Deploy models and get predictions via API in your python code.
3. **[Deploy in Docker](inference-and-deployment/deploy_and_predict_with_supervisely_sdk.md#-deploy-in-docker-container)**: Use Docker containers for deploying your models in a consistent environment.
<!-- 2. **[Deploy with Supervisely Python SDK](inference-and-deployment/deploy_and_predict_with_supervisely_sdk.md)** for automated model inference: Use Supervisely SDK for deploying models and getting predictions in your code.   -->
4. **[Using trained models outside of Supervisely](inference-and-deployment/using-standalone-pytorch-models.md)**: You can always download a plain PyTorch checkpoint and use it outside of Supervisely infrastructure in your code, or download its ONNX / TensorRT exported versions.

There is no vendor lock, you can use your models the same way, as if you trained it manually with your own code.

## Predict

After you've deployed a model, you can interact with it in different ways:

1. **Apply model in platform:** If you deployed a model via a [Supervisely Serving App](inference-and-deployment/supervisely-serving-apps.md), you can predict easily with NN Applying app with web UI. [Apply NN to Images](https://ecosystem.supervisely.com/apps/nn-image-labeling/project-dataset), [Apply NN to Videos](https://ecosystem.supervisely.com/apps/apply-nn-to-videos-project).
2. **Predict via API:** After deploying a model in Supervisely, you can get predictions via [Prediction API](inference-and-deployment/prediction-api.md) in your python code. This is a convenient way to integrate model inference into your existing pipelines.
<!-- 2. **SessionAPI:** Communicate with the deployed model using [Supervisely python SDK](https://developer.supervisely.com/app-development/neural-network-integration/inference-api-tutorial), which has convenient methods for efficient model inference on images, projects and videos. We also support Tracking-by-detection algorithms, such as BoT-Sort. -->
<!-- 3. **Predict with Supervisely SDK:** Deploy a model locally and interact with it through [Inference API](https://developer.supervisely.com/app-development/neural-network-integration/inference-api-tutorial). -->
3. **Predict with CLI arguments:** In case you [deploying model locally](inference-and-deployment/deploy_and_predict_with_supervisely_sdk.md#deploy-model-as-a-server) or in a [docker container](inference-and-deployment/deploy_and_predict_with_supervisely_sdk.md#deploy-in-docker-container), you can do it with a simple command line interface, and get predictions in a few seconds.
4. **Standalone PyTorch model:** You can use your trained checkpoints out of Supervisely infrastructure in your code as a simple pytorch model (see details in [Using Standalone PyTorch Models](inference-and-deployment/using-standalone-pytorch-models.md)).

With the help of Supervisely SDK and Apps, you can easily apply your model to:

- **Project or dataset of images.**
- **Folder of images** on your machine.
- **Video**. Our SDK automatically breaks video into frames, and the model is applied frame-by-frame.
- **Tracking by detection.** We offer ready-to-use scripts for quickly using your detector for tracking tasks.
- **3D Lidar data and medical data.**

We connect all neural networks together with the use of unified API and data format. Thus, you don't need to write boilerplate code for many use cases, such as, applying a model to a dataset or a video. This allowed us to build a wide ML Ecosystem to cover the entire lifecycle of neural networks: from data labeling to continuous model development.
