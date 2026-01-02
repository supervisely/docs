# Auto Labeling with AI

## Introduction

Traditional manual data labeling can be time-consuming and expensive. Data annotation automation with AI refers to using machine learning techniques to speed up or replace manual labeling of data. Automated and semi-automated methods use AI to generate labels, suggest annotations or validate human work, significantly reducing annotatrion cost and time.

## How AI automates data annotation

- **Pre-annotation (AI generates initial labels)** - machine learning model automatically labels raw data before humans see it. Annotators then review and correct these labels if necessary. Can potentially speed up labeling process by 30–80%, but pretrained models are not always suitable since every dataset is unique.
- **Weak supervision** - instead of labeling individual samples, humans create rules or heuristics and AI uses them to label datasets. For example, some machine learning models can detect objects on images using text descriptions provided by human annotators. Can be useful for a wide range of use cases without any addtitional fine-tuning.
- **Semi-supervised learning** - annotators label a small part of data, then this small labeled dataset is used to train a model. Trained model annotates unlabeled data, then high-confidence labels are added back to the training set. Efficient when labeled data is scarce.
- **Online learning** - images labeled during data annotation process can be used for training machine learning model. New images are added to training dataset iteratively to launch new training session. Over time, the model learns on human annotations and its predictions require less and less manual correction. Ideal for domain-specific datasets where pretrained models often fail.

## Data labeling automation with AI in Supervisely Ecosystem

Supervisely Ecosystem provides numerous ways of data labeling optimization with AI across several modalities: images, videos, 3D point clouds and DICOM volumes.

[Images](images/README.md)

- [Pretrained models](images/README.md#pretrained-models)
- [Interactive labeling models](images/README.md#interactive-labeling-models)
- [Foundation models](images/README.md#foundation-models)
- [Model ensembles](images/README.md#model-ensembles)
- [Online learning](images/README.md#online-learning)
- [Image filtering](images/README.md#image-filtering)
- [Custom models](images/README.md#custom-models)

[Videos](videos/README.md)

- [Tracking by detection](videos/README.md#tracking-by-detection)
- [First frame initialized trackers](videos/README.md#first-frame-initialized-trackers)
- [Model ensembles](videos/README.md#model-ensembles)

[3D point clouds](3d-point-clouds/README.md)

- [Pretrained models](3d-point-clouds/README.md#pretrained-models)
- [First frame initialized trackers](3d-point-clouds/README.md#first-frame-initialized-trackers)
- [3D AI assistant](3d-point-clouds/README.md#3d-ai-assistant)

[DICOM](dicom/README.md)

- [Interactive labeling models](dicom/README.md#interactive-labeling-models)
- [Volume interpolation](dicom/README.md#volume-interpolation)