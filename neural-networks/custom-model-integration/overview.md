# Custom Model Integration

This series will guide you through integrating your custom model (or a custom NN architecture) into the Supervisely Platform. You'll learn how to train your model in Supervisely and deploy it as a service for inference. Don't worry, the [Supervisely SDK](https://github.com/supervisely/supervisely) has been designed to make this process as simple as possible! 😊

## Inference and Training Apps

When you integrate a custom model into Supervisely, you are creating two closely related apps:

- **Inference (Serving) App**

    This is a [Serving App](/neural-networks/inference-and-deployment/supervisely-serving-apps.md) that deploys model as an API service. Once model is deployed, user can make predictions on images and videos. Supervisely SDK provides a convinient `Inference` class with built-in GUI and ready-to-use methods and interfaces for model deployment and inference.

    Read more in [Integrate Custom Inference](./integrate-custom-inference.md).

- **Training App**

    This app handles the training process of your model from data preparation and hyperparameter configuration to checkpoint creation and evaluation. Like in the Inference App, Supervisely SDK provides a `TrainApp` class with built-in GUI and useful methods for development training app.

    Read more in [Integrate Custom Training](./integrate-custom-training.md).

### Shared Repository

We recommend that both the training and serving apps will be implemented in a single GitHub repository. This design enables shared configurations, dockerfile with dependencies and easier management of common files (e.g., `models.json`, configs). However, you can also create separate repositories for each app, but you may miss out on some important features.
