## Overview

This section outlines various approaches of deployment and inference of NN models in Supervisely.

In general, there are 4 different approaches you can deploy and use your models:

- **[Supervisely Serving Apps](supervisely-serving-apps.md)** - A simple and user-friendly way to deploy and use models with a convenient web UI. This is the most common way to deploy models in Supervisely.
- **[Supervisely Prediction API](prediction-api.md)** and **[Supervisely Model API](model-api.md)** for deploying models and getting predictions via API in your python code.
- **[Local Deployment](deploy_and_predict_with_supervisely_sdk.md)**. Deploy NN models on your local machine or a server by yourself. Supervisely SDK offers convenient classes and functions to help you with this task. You can also deploy any model in a 🐋 Docker Container.
- **[Using Trained Models Outside of Supervisely](using-standalone-pytorch-models.md)**: You can always download a plain PyTorch checkpoint and use it outside of Supervisely infrastructure in any of your code (or download its ONNX / TensorRT exported versions).

## 1. Supervisely Serving Apps

This is the most user-friendly variant. Deploy your model via Supervisely **Serving Apps**, such as [Serve YOLOv11](https://ecosystem.supervisely.com/apps/yolov8/serve), [Serve RT-DETRv2](https://ecosystem.supervisely.com/apps/rt-detrv2/supervisely_integration/serve), [Serve SAM 2.1](https://ecosystem.supervisely.com/apps/serve-segment-anything-2), then apply a model using **Applying Apps**, such as [Apply NN to Images](https://ecosystem.supervisely.com/apps/nn-image-labeling/project-dataset), [Apply NN to video](https://ecosystem.supervisely.com/apps/apply-nn-to-videos-project), [NN Image Labeling](https://ecosystem.supervisely.com/apps/nn-image-labeling/annotation-tool).

> For more information see [Supervisely Serving Apps](supervisely-serving-apps.md).

![Serving Apps](/.gitbook/assets/neural-networks/serve-app-list.jpg)

## 2. Supervisely Prediction API

Supervisely API provides a convenient way to deploy your models and get predictions via API in a couple lines of code.

> For more information see [Supervisely Prediction API](prediction-api.md) and [Supervisely Model API](model-api.md).

```python
import supervisely as sly

api = sly.Api()

# 1. Deploy your model
model = api.nn.deploy(
    model="/path/in/team_files/checkpoint.pt",  # path to your checkpoint in Team Files
    device="cuda:0",  # or "cpu"
)

# 2. Predict
predictions = model.predict(
    # Input can accpet various formats: image paths, np.arrays, Supervisely IDs and others.
    input=["path/to/image1.jpg", "path/to/image2.jpg"],
    conf=0.5,      # confidence threshold
    img_size=640,  # image size for inference
    # ... other parameters (see the docs)
)

# 3. Iterate through predictions
for p in predictions:
    boxes = p.boxes  # np.array of shape (N, 4) with predicted boxes in "xyxy" format
    masks = p.masks  # np.array of shape (N, H, W) with binary masks
    scores = p.scores  # np.array of shape (N,) with predicted confidence scores
    classes = p.classes  # list of predicted class names
    annotation = p.annotation  # predictions in sly.Annotation format
    p.visualize(save_dir="./output")  # save visualization with predicted annotations
```

## 3. Local Deployment

Supervisely Team has integrated a lot of different models into the Ecosystem, and they are all open-sourced, so you can use our efforts to deploy any model in your own environment - on your local machine or a server. [Supervisely SDK](https://github.com/supervisely/supervisely) implements a unified interface for neural networks, so you can use the same code for every model that is integrated into Supervisely.

In the case of local deployment, the model will be deployed outside of the Supervisely Platform. This is useful when developing applications that are not directly related to the platform, and you can just use the model itself. Such deployment will still be available via API from your local server, because any Supervisely model is a FastAPI application.

> For more information see [Local Deployment](deploy_and_predict_with_supervisely_sdk.md).

### Docker

You can also deploy any model in a 🐋 Docker Container in a single `docker run` comand. Please, read the [Deploy in Docker](deploy_and_predict_with_supervisely_sdk.md#deploy-in-docker-container) section.


## 4. Using Trained Models Outside of Supervisely

In this approach you completely decouple a model from both the **Supervisely Platform** and **Supervisely SDK**, and you will develop your own code for inference and deployment of that particular model. It's important to understand that for each neural network or a framework, you need to set up an environment and write inference code by yourself, since each model has its own installation instructions and the way of processing inputs and outputs correctly. But, in many cases, Supervisely Team provides code examples of using the model as a standalone PyTorch model. You can find our guidelines on a GitHub repository of the corresponding model. For example, [RT-DETRv2 Demo](https://github.com/supervisely-ecosystem/RT-DETRv2/tree/main/supervisely_integration/demo#readme).

> For more information see [Using trained models outside of Supervisely](using-standalone-pytorch-models.md).