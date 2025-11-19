---
description: >-
  In this guide, you'll learn about AI-driven tools which you can use in Supervisely to optimize your image labeling pipelines.
---

# Images

## Pretrained models

Supervisely Ecosystem contains lots of apps for using neural networks pretrained both on public datasets (e.g. COCO) and on custom datasets (you can use your custom checkpoint for selected architecture).

You can see list of all available neural networks for image labeling by clicking on `App Ecosystem` icon in left sidebar, then go to Categories -> Neural networks -> Images. Supported task types include object detection, semantic / instance segmentation, pose estimation and many others.

It is possible to apply neural networks to both separate images and whole datasets.

You can use [NN Image Labeling](https://ecosystem.supervisely.com/apps/nn-image-labeling/annotation-tool) app for image-level annotation:

For dataset-level annotation, [Apply NN to Images Project](https://ecosystem.supervisely.com/apps/nn-image-labeling/project-dataset) will be more suitable option:


## Interactive labeling models

Interactive labeling approach assumes that annotator will interact with model using input prompts such as foreground / background clicks or bounding boxes. Even though this approach is not fully automatic, it allows to label domain-specific data with decent annotation quality without any additional model fine-tuning / domain adaptation.

Supervisely Ecosystem supports several interactive image labeling models:

- Segment Anything model family ([SAM](https://ecosystem.supervisely.com/apps/serve-segment-anything-model), [SAM 2](https://ecosystem.supervisely.com/apps/serve-segment-anything-2), [SAM-HQ](https://ecosystem.supervisely.com/apps/serve-segment-anything-hq/supervisely_integration/serve))
- [ClickSeg](https://ecosystem.supervisely.com/apps/serve-clickseg)
- [RITM](https://ecosystem.supervisely.com/apps/ritm-interactive-segmentation/supervisely)

All these models can be conveniently used in Image Annotation Tool with the help of Smart Tool instrument:

## Foundation models

Foundation models are large, general-purpose vision models trained on massive, diverse datasets that enable highly accurate and flexible annotation across wide range of domains. Unlike task-specific models, foundation models provide universal visual understanding, allowing them to detect, classify and segment objects with little or no fine-tuning.

These models learn rich, multi-scale visual features from large amounts of images, giving them exceptional ability to generalize well to new environments.

List of supported foundation models includes:

- [Florence 2](https://ecosystem.supervisely.com/apps/serve-florence-2)
- [Kosmos 2](https://ecosystem.supervisely.com/apps/serve-kosmos-2)
- [Molmo](https://ecosystem.supervisely.com/apps/serve-molmo)
- [Grounding DINO](https://ecosystem.supervisely.com/apps/serve-grounding-dino)

In Supervisely, foundation models can be used for both text-to-image and image-to-text inference. Text-to-image inference can be performed in form of text prompt-based object detection.

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

Multi-model detection ensemble is implemented in a form of AI image labeling assistant which combines several foundation models and takes user's annotations to automatically generate input prompts for foundation models and find the one which fits given dataset best. AI image labeling assistant does not require any prompts from user - only at least one labeled image - input prompts generation and model selection will be performed automatically.

## Online learning

Online learning enables a model to continuously improve by training on new human annotations in real time. As annotators correct predictions or add new labels, the model updates its parameters on the fly - it allows to instantly adapt to the dataset’s style, domain and corner cases. Instead of waiting until dataset will be labeled completely, model learns incrementally from each interaction, steadily reducing error rates and boosting pre-labeling quality.

This approach allows the model to rapidly internalize rare classes, domain-specific nuances and ambiguous scenarios as soon as they appear in the labeling workflow. Over time, the model becomes increasingly tailored to the project, leading to fewer manual corrections. Online learning transforms model training into a dynamic feedback loop, where every human interaction makes the system smarter and more efficient.

Supervisely Ecosystem supports online learning for two task types: object detection and semantic segmentation - there is a corresponding app for each task.