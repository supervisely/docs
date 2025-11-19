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

<table data-view="cards">
   <thead>
      <tr>
         <th></th>
         <th></th>
         <th data-hidden data-card-target data-type="content-ref"></th>
      </tr>
   </thead>
   <tbody>
      <tr>
         <td><strong>Images</strong></td>
         <td>Accelerate image labeling with AI-driven algorithms that instantly detect and segment objects with high accuracy, reducing annotation time by up to 80%.</td>
         <td><a href="images/README.md">Images</a></td>
      </tr>
    <tr>
         <td><strong>Videos</strong></td>
         <td>Level up your frame-level and sequence-level annotations with the help of object detection, object segmentation, object tracking and action recognition ML models.</td>
         <td><a href="videos/README.md">Videos</a></td>
    </tr>
    <tr>
         <td><strong>3D Point Clouds</strong></td>
         <td>Unlock fast and precise 3D annotations with the help spatial understanding and sensor fusion algorithms - perfect for robotics and autonomous systems.</td>
         <td><a href="3d-point-clouds/README.md">3D Point Clouds</a></td>
    </tr>
    <tr>
         <td><strong>DICOM volumes</strong></td>
         <td>Leverage medical imaging AI models to simplify annotation of CT, MRI and X-ray scans.</td>
         <td><a href="dicom/README.md">DICOMs</a></td>
    </tr>
   </tbody>
</table>