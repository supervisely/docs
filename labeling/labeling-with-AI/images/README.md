---
description: >-
  In this guide, you'll learn about AI-driven tools which you can use in Supervisely to optimize your image labeling pipelines.
---

# Images

## Pretrained models

Supervisely Ecosystem contains lots of apps for using neural networks pretrained both on public datasets (e.g. COCO) and on custom datasets (you can use your custom checkpoint for selected architecture).

You can see list of all available neural networks for image labeling by clicking on `App Ecosystem` icon in left sidebar, then go to Categories -> Neural networks -> Images. Supported task types include object detection, semantic / instance segmentation, pose estimation and many others.

{% embed url="https://github.com/user-attachments/assets/09ed3d0d-ffee-4d0f-a8eb-e0e4bb950d51" %}

It is possible to apply neural networks to both separate images and whole datasets.

You can use [NN Image Labeling](https://ecosystem.supervisely.com/apps/nn-image-labeling/annotation-tool) app for image-level annotation:

{% embed url="https://github.com/user-attachments/assets/7e65824c-c0f1-432c-b300-41489b3a5e18" %}

For dataset-level annotation, [Predict App](https://ecosystem.supervisely.com/apps/apply-nn) will be more suitable option. This app allows to conveniently deploy ML models and apply them to input data in just few clicks:

{% embed url="https://github.com/user-attachments/assets/012de0b0-b274-4a90-b253-7bd15e822c40" %}

Some neural networks can take reference objects as input prompts. For example, [OWL-ViT](https://ecosystem.supervisely.com/apps/serve-owl-vit) can take image with bounding box annotation as target object example and detect similar objects on other images. If you want to use OWL-ViT in reference image mode, you can create bounding box for target object and click on "Apply model to ROI" button:

{% embed url="https://github.com/user-attachments/assets/58a378e1-212e-4db6-86bd-a708630820e3" %}

Some computer vision tasks require specific labeling interface - image matting, for example. Image matting is dedicated to separating the foreground object from the background by predicting a high-quality alpha mask. The goal is to precisely estimate the transparency values along object boundaries, particularly around fine structures such as hair, fur, etc. Supervisely Ecosystem provides convenient interface for this computer vision task and a pretrained neural network for fast and precise labeling - [Matte Anything](https://ecosystem.supervisely.com/apps/serve-matte-anything/serving_app) (check our related [blog post](https://supervisely.com/blog/image-matting/) for more details).

Open your images project, open project settings, go to Visuals, select image matting as project labeling interface:

{% embed url="https://github.com/user-attachments/assets/9ce3dba4-96bf-48da-9158-7c7d6f470c13" %}

Select smart tool, create annotation class of shape 'Alpha mask' and draw a bounding box around target object on image (you can also adjust mask by adding positive and negative points if necessary):

{% embed url="https://github.com/user-attachments/assets/6086a807-dcce-4592-a1a9-fc2edd38f8d7" %}

## Interactive labeling models

Interactive labeling approach assumes that annotator will interact with model using input prompts such as foreground / background clicks or bounding boxes. Even though this approach is not fully automatic, it allows to label domain-specific data with decent annotation quality without any additional model fine-tuning / domain adaptation.

Supervisely Ecosystem supports several interactive image labeling models:

- Segment Anything model family ([SAM](https://ecosystem.supervisely.com/apps/serve-segment-anything-model), [SAM-HQ](https://ecosystem.supervisely.com/apps/serve-segment-anything-hq/supervisely_integration/serve), [SAM 2](https://ecosystem.supervisely.com/apps/serve-segment-anything-2), [SAM 3](https://ecosystem.supervisely.com/apps/sam3/serve))
- [ClickSeg](https://ecosystem.supervisely.com/apps/serve-clickseg)
- [RITM](https://ecosystem.supervisely.com/apps/ritm-interactive-segmentation/supervisely)

All these models can be conveniently used in Image Annotation Tool with the help of Smart Tool instrument:

{% embed url="https://github.com/user-attachments/assets/8c11bac3-1c47-4d7f-a2ef-219b62930982" %}

## Foundation models

Foundation models are large, general-purpose vision models trained on massive, diverse datasets that enable highly accurate and flexible annotation across wide range of domains. Unlike task-specific models, foundation models provide universal visual understanding, allowing them to detect, classify and segment objects with little or no fine-tuning.

These models learn rich, multi-scale visual features from large amounts of images, giving them exceptional ability to generalize well to new environments.

List of supported foundation models includes:

- [Florence 2](https://ecosystem.supervisely.com/apps/serve-florence-2)
- [Kosmos 2](https://ecosystem.supervisely.com/apps/serve-kosmos-2)
- [Molmo](https://ecosystem.supervisely.com/apps/serve-molmo)
- [Grounding DINO](https://ecosystem.supervisely.com/apps/serve-grounding-dino)
- [SAM 3](https://ecosystem.supervisely.com/apps/sam3/serve)

In Supervisely, foundation models can be used for both text-to-image and image-to-text inference. Text-to-image inference can be performed in form of text prompt-based object detection:

{% embed url="https://github.com/user-attachments/assets/6716015c-9ba8-4463-8fa0-5ecbf4073de2" %}

Image-to-text inference can be performed via Supervisely Python API (see [visual question answering tutorial](https://docs.supervisely.com/neural-networks/inference-and-deployment/visual-question-answering) for details).

## Model ensembles

Model ensembles combine the strengths of multiple AI models to deliver more accurate, stable and reliable labeling results than any single model can achieve on its own. By aggregating predictions from diverse architectures, model ensembles can significantly improve overall annotation quality.

Cascading models allows system to leverage complementary capabilities: one model may excel at detecting small objects, another at recognizing rare categories and so on.

For data labeling pipelines, model ensembles provide exceptional robustness across domains, higher-confidence pre-labeling and more consistent results in challenging scenes - it makes ensembles a powerful tool for scalable, production-grade labeling workflows.

Supervisely Ecosystem uses model ensembles in two different ways:

- Detection-guided segmentation / pose estimation pipelines
- Multi-model detection ensemble

Detection-guided segmentation / pose estimation pipelines use object detector to produce bounding boxes and then use these bounding boxes as input prompt for segmentation / pose estimation models. It allows to automate usage of models like SAM 2 or VitPose which usually require user interaction for providing input prompts - in given case object detection model is used to generate input prompts instead.

Examples of detection-guided segmentation / pose estimation pipelines in Supervisely Ecosystem - [Apply Florence 2 + SAM 2 to Images Project](https://ecosystem.supervisely.com/apps/apply-florence-2-to-images-project) and [Apply Detection and Pose Estimation Models to Images Project](https://ecosystem.supervisely.com/apps/apply-det-and-pose-estim-models-to-project) apps.

{% embed url="https://github.com/user-attachments/assets/50aa4f26-f128-4088-8811-b68a274ebe94" %}

Multi-model detection ensemble is implemented in a form of AI image labeling assistant which combines several foundation models and takes user's annotations to automatically generate input prompts for foundation models and find the one which fits given dataset best. AI image labeling assistant does not require any prompts from user - only at least one labeled image - input prompts generation and model selection will be performed automatically.

{% embed url="https://github.com/user-attachments/assets/f6770e26-1a0c-4ec2-8349-22cd5d5d3bf7" %}

## Online learning

Online learning enables a model to continuously improve by training on new human annotations in real time. As annotators correct predictions or add new labels, the model updates its parameters on the fly - it allows to instantly adapt to the dataset’s style, domain and corner cases. Instead of waiting until dataset will be labeled completely, model learns incrementally from each interaction, steadily reducing error rates and boosting pre-labeling quality.

This approach allows the model to rapidly internalize rare classes, domain-specific nuances and ambiguous scenarios as soon as they appear in the labeling workflow. Over time, the model becomes increasingly tailored to the project, leading to fewer manual corrections. Online learning transforms model training into a dynamic feedback loop, where every human interaction makes the system smarter and more efficient.

Supervisely Ecosystem supports online learning for two task types: object detection and semantic segmentation - there is a corresponding app for each task. You can see how model predictions are gradually improving step by step:

{% embed url="https://github.com/user-attachments/assets/48086a61-eb37-4600-9549-b41dd6db7f54" %}

## Image filtering

Prompt-based image filtering uses a model that understands both images and text (most commonly [CLIP](https://arxiv.org/abs/2103.00020) or similar vision–language foundation models) to filter large image collections through natural language instructions. You provide a text prompt and the model evaluates each image’s similarity to that text prompt.

Image filtering based on text prompt creates numerous data processing opportunities:

- Selecting relevant images

- Excluding irrelevant ones

- Ranking images by prompt relevance

- Detecting categories without training new models

It works even for concepts the model has never been explicitly trained on, because vision–language models generalize quite well.

How prompt-based image filtering works:

1. Get image embeddings - each image is passed through the vision encoder (e.g. ViT ) to produce image embedding.

2. Get text prompt embeddings - text prompt is passed through the text encoder to produce text embedding.

3. Compare image and text mbeddings - similarity score (usually cosine similarity) shows how close the image is to the prompt in joint embedding space.

4. Filter, rank, or categorize - based on the similarity score, the system keeps matching images, filters out low-scoring ones and sorts images by relevance.

Potential areas of application:

- Zero-shot classification - label images without training a classifier (example prompt: “a photo of a construction helmet” → models finds all images with construction helmets).

- Quality or style filtering - control your dataset quality (example prompt: “blurry image” -> model finds all blurry images).

- Safety and compliance filtering - can be used to enforce privacy or compliance in large datasets (example prompt: “contains a person” -> model finds all images with people)

- Domain-specific filtering - models like CLIP generalize surprisingly well across domains (example prompt: “MRI scan of the abdomen” -> model finds all images with MRI scans of abdomen)

Supervisely Ecosystem allows to filter large datasets conveniently with the help of specific app - [Prompt-based Image Filtering with CLIP](https://ecosystem.supervisely.com/apps/prompt-based-image-filtering) - check out related [blog post](https://supervisely.com/blog/openai-clip-for-image-retrieval-and-filtering-computer-vision-datasets-tutorial/) with video tutorial for details.

Let's assume we have an unfiltered dataset of ~1000 images:

<figure><img src="https://github.com/user-attachments/assets/f3efbfee-58ec-4e1d-b3e0-250c5b3fe323" alt=""><figcaption></figcaption></figure>

Here is how we can filter given dataset to leave only images with lions using Prompt-based Image Filtering with CLIP app:

{% embed url="https://github.com/user-attachments/assets/93a62c1e-73e8-42c5-b4d3-180d0b1784a8" %}

## Custom models

Supervisely Ecosystem allows to use not only integrated neural networks pretrained on public datasets - you can use your own.

Here is a list of possible scenarious for using custom ML models in Supervisely platform:

- If you want to train a model to get a custom checkpoint for some neural network architecture which is already integrated into Supervisely Ecosystem (e.g. YOLO), you can just run corresponding training app (e.g. [Train YOLO](https://ecosystem.supervisely.com/apps/yolo/supervisely_integration/train)) - after the training finishes, you will be able to deploy your trained model as REST API via corresponding serving app (e.g. [Serve YOLO](https://ecosystem.supervisely.com/apps/yolo/supervisely_integration/serve)) - just select "Custom models" tab in app UI and choose your desired checkpoint.

- If you already have a custom checkpoint for some neural network architecture which is not integrated into Supervisely Ecosystem yet - you can easily create your own serving app and release it as a private app - this app will be available only for your account or to those users in your team to whom you grant access. Check out our [custom model integration tutorial](https://docs.supervisely.com/neural-networks/custom-model-integration/integrate-custom-inference) - it will not take a lot of time, you can use ready app template and will have to redefine only several methods. You can create your custom apps not only for inference, but also for [training](https://docs.supervisely.com/neural-networks/custom-model-integration/integrate-custom-training).