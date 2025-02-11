# Custom Model Integration

In this guide, you'll learn how to integrate your custom model for both training and inference on the Supervisely platform. By setting up both a training app and a serving (inference) app in a single repository, you ensure they cooperate seamlessly. This unified approach not only simplifies development and debugging but also guarantees that models produced by your training app can be instantly used by your serving app.

## Overview

When you integrate a custom model into Supervisely, you are creating two closely related apps:

- **Training App**

    This app handles the end-to-end training process of your model from data preparation and hyperparameter configuration to checkpoint creation and evaluation. Some features of the training app relies on the serving app to run the benchmark tests. This means that once the model is trained, the training app uses the serving app’s evaluation capabilities to measure performance and generate benchmark report for best model.

- **Serving (Inference) App**

    This app deploys model as a REST API service. Once model is deployed, user can use it to make predictions on images and videos. The serving app can also be integrated into the annotation toolbox for images and videos.

## Unified Repository

We recommend that both the training and serving apps must reside in the same repository. This design enables shared configurations, dockerfile with dependencies and easier management of common files (e.g., `models.json`, `hyperparameters.yaml`, and `inference_settings.yaml`).

### Common Components

#### Configuration Files

Files like `models.json` list your model configurations, while `hyperparameters.yaml` (for training) and `inference_settings.yaml` (for serving) define essential settings.

**User Interface (GUI) Elements:**

Pre-built GUI templates (based on Supervisely Widgets) are available in both apps, making it easy to navigate settings and monitor progress.

**Benchmarking Integration:**

The training app requires the serving app to run model benchmarks. Once a model is trained, the training app uses the serving app's functionality to serve the best model and evaluate its performance, generating important metrics and benchmark report.