# Integrate Custom Inference

In this section, you'll learn how to integrate your custom inference app using the Supervisely SDK. With custom inference, you can run your own models on the Supervisely platform or even outside of it. This guide uses an object detection model as an example, but the same ideas apply to other model types.

## Overview

In this guide, you'll learn how to extend a Supervisely SDK class and implement the core methods needed for your custom inference solution. Let's dive into the steps:

- Create a custom class by inheriting from a Supervisely inference base class.
- Define key class variables such as `FRAMEWORK_NAME`, `MODELS`, and `INFERENCE_SETTINGS`.
- Implement the `load_model` method to load and prepare your model.
- Implement the `predict` method to run inference on your input data.

Let's see a code example that demonstrates how to implement a custom inference model for object detection and then, we'll break down each part in detail.

We need to implement inference class that inherits from `sly.nn.inference.ObjectDetection`, defines the required class variables, and implements the `load_model` and `predict` methods.

```python
class MyModel(sly.nn.inference.ObjectDetection):
    # Define pretrained models and settings
    FRAMEWORK_NAME = "Custom Framework"
    MODELS = "path/to/models.json"
    INFERENCE_SETTINGS = "path/to/inference_settings.yaml"

    def load_model(self, model_files: dict, model_info: dict, model_source: str, device: str, runtime: str):
        """
        Load and prepare the model for inference.
        """
        # 1️⃣ Retrieve checkpoint and config file paths
        checkpoint_path = model_files["checkpoint"]
        config_path = model_files["config"]

        # 2️⃣ Load the configuration and model checkpoint
        self.cfg = YAMLConfig(config_path, resume=checkpoint_path)
        checkpoint = torch.load(checkpoint_path, map_location="cpu")
        self.model = self.cfg.model

        # 3️⃣ Load state dict and deploy the model to the given device
        state = checkpoint["ema"]["module"]
        self.model.load_state_dict(state)
        self.model.deploy().to(device)
        
        # 4️⃣ Prepare the postprocessor for output formatting
        self.postprocessor = self.cfg.postprocessor.deploy().to(device)

    def predict(self, image_path: str, settings: dict):
        """
        Run inference on the input image and return predictions.
        """
        # 1️⃣ Preprocess the input image (custom implementation required)
        img_input, size_input, orig_target_sizes = self._prepare_input(image_path)
        
        # 2️⃣ Run the model on the preprocessed input
        outputs = self.model(img_input)
        
        # 3️⃣ Postprocess the outputs to extract labels, bounding boxes, and scores
        labels, boxes, scores = self.postprocessor(outputs, orig_target_sizes)
        labels = labels.cpu().numpy()
        boxes = boxes.cpu().numpy()
        scores = scores.cpu().numpy()
        
        # 4️⃣ Format the predictions in a user-friendly format and return them
        predictions = self._format_predictions(labels, boxes, scores, settings)
        return predictions
```

## Getting Started

Before you begin, make sure you have your model files and configuration ready. This tutorial is based on an object detection model, so if you're using a different model type, ensure you inherit from the corresponding Supervisely SDK class.

**Available classes for inheritance:**

- `ObjectDetection`
- `ObjectDetection3D`
- `PoseEstimation`
- `PromptBasedObjectDetection`
- `PromptableSegmentation`
- `SalientObjectSegmentation`
- `SemanticSegmentation`

### Step 1. Inheritance and Class Variables

Your custom inference class inherits from one of the Supervisely inference base classes (in this case, ObjectDetection). You then define key class variables such as:

`FRAMEWORK_NAME`: The name of your model's framework.
`MODELS`: Path to a JSON file with your model configurations.
`INFERENCE_SETTINGS`: Path to a YAML file with additional inference settings.

### Step 2. The load_model Method

**This method is responsible for:**

- Reading the checkpoint and configuration file paths.
- Loading the model configuration using a YAML parser.
- Loading the checkpoint, extracting the model state, and deploying the model to the specified device.
- Preparing the postprocessor, which is used to format the raw output of your model.

### Step 3. The predict Method

**In this method, you:**

- Preprocess the input image (this involves resizing, normalizing, etc.).
- Run the model inference to get raw outputs.
- Use the postprocessor to convert these outputs into meaningful predictions, such as labels, bounding boxes, and confidence scores.
- Format these predictions in a user-friendly structure to return as the final result.
