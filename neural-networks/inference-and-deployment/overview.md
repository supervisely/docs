## Overview

This section covers the deployment and inference of models.

In general, there are 3 different ways you can deploy and apply your trained model:

1. **[Supervisely Serving Apps](supervisely-serving-apps.md)** within the Platform. Simple and user-friendly way to deploy a model with convenient web UI.
2. **[Deploy with Supervisely Python SDK](deploy_and_predict_with_supervisely_sdk.md)** for automated model inference: Use Supervisely SDK for deploying models and getting predictions in your code.
3. **[Using Standalone PyTorch Models](using-standalone-pytorch-models.md)**: You can always download a plain PyTorch checkpoint and use it outside of Supervisely infrastructure in your code, or download its ONNX / TensorRT exported versions.

## 1. Supervisely Serving Apps

This is the most user-friendly variant. Deploy your model via Supervisely **Serving Apps**, such as [Serve YOLOv11](https://ecosystem.supervisely.com/apps/yolov8/serve), [Serve RT-DETRv2](https://ecosystem.supervisely.com/apps/rt-detrv2/supervisely_integration/serve), [Serve SAM 2.1](https://ecosystem.supervisely.com/apps/serve-segment-anything-2), then apply a model using **Applying Apps**, such as [Apply NN to Images](https://ecosystem.supervisely.com/apps/nn-image-labeling/project-dataset), [Apply NN to video](https://ecosystem.supervisely.com/apps/apply-nn-to-videos-project), [NN Image Labeling](https://ecosystem.supervisely.com/apps/nn-image-labeling/annotation-tool).

See more information in [Supervisely Serving Apps](supervisely-serving-apps.md).

[ Screenshot ]

## 2. Deploy with Supervisely Python SDK for Automated Inference

This method involves using Python code together with [Supervisely SDK](https://github.com/supervisely/supervisely) to automate deployment and getting predictions in different scenarios and environments. You can deploy your models either inside the Supervisely Platform (on an agent), or outside the platform, directly on your local machine.

If you need to completely decouple your code from Supervisely SDK, see [Using Standalone PyTorch Models](using-standalone-pytorch-models.md) (mostly for data scientists).

### In-Platform Model Deployment vs Local Deployment

**In-Platform Model Deployment**: When deploying inside Supervisely Platform, your model becomes a part of the complete Supervisely Ecosystem. It becomes visible on the platform, has its own ID through which other applications can interact with it, get predictions, and interact with it for other tasks, combining with a unified ML workflow. The platform will help you by tracking all changes of models and data, save the entire history of your ML operations and experiments for reproducing and exploring. See [In-Platform Model Deployment using Supervisely SDK](deploy_and_predict_with_supervisely_sdk.md#in-platform-model-deployment).

**Local Deployment**: In the case of deployment outside Supervisely Platform, you don't have the advantages of the Ecosystem, but you get more freedom in how your model will be deployed. You can deploy your model on different machines using a single script by yourself. This is a more advanced variant that won't suit everyone. See [Local Deployment using Supervisely SDK](deploy_and_predict_with_supervisely_sdk.md#deploy-outside-of-supervisely).

In summary:

1. **In-Platform Model Deployment:**  
   * Model becomes integrated into Supervisely Ecosystem  
   * Gets unique ID for platform-wide access  
   * Other applications can interact with your model  
   * Automatic version tracking of models and data  
   * Full ML operations history is preserved for reproduction and analyzing experiments  
   * Easy integration into ML pipelines

2. **Local Deployment:**  
   * More flexibility in development  
   * Deploy on any server or machine by yourself  
   * Less integrated with platform, no ecosystem benefits  
   * Advanced option for specific use cases

For each option, there are several ways you can deploy the model. See the [In-Platform Deployment](deploy_and_predict_with_supervisely_sdk.md#in-platform-model-deployment) and [Local Deployment](deploy_and_predict_with_supervisely_sdk.md#deploy-outside-of-supervisely) sections for more details.

## 3. Using Standalone PyTorch Models

This is the most advanced way. This method completely decouple you from both Supervisely Platform and Supervisely SDK, and you will develop your own code for inference and deployment. It's also important to understand that for each neural network and framework, you'll need to set up an environment and write inference code by yourself, since each model has its own installation instructions, and the format of inputs and outputs. But, in many cases, we provide our examples of using the model as a standalone PyTorch model. You can find our guidelines on a GitHub repository of the corresponding model. For example, [RT-DETRv2 Demo](https://github.com/supervisely-ecosystem/RT-DETRv2/tree/main/supervisely_integration/demo#readme).

See more information in [Using Standalone PyTorch Models](using-standalone-pytorch-models.md).