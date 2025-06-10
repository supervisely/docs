---
description: >-
 This article provides an overview of the Labeling Quality Control process in image projects using Supervisely’s dedicated functionality.
---

# Labeling Quality Control

We hope you're already familiar with the labeling quality control functionality in **Supervisely** for various project types.
In this article, we will explore the **extended Quality Control** feature for image projects.

To start the review process, a **Labeling Job** of the **Quality Control** type is created. Within this job, the reviewer gets access to the annotated data and can interact with each geometry, class and tag.

## Overview

To start the **extended Quality Control** process in an image project, follow these steps:

1. Open any **Image Project** from the Projects section.
2. In the **`Annotate`** button click the **`v`** arrow on the top right side of the screen.
3. In the dropdown menu, select **Send Sample to QC**.

<figure><img src="../../.gitbook/assets/labeling-quality-control/labeling-q-c-1.jpg" alt=""><figcaption></figcaption></figure>

4. The **Create QC Task** page will open in the Labeling Jobs section.
5. Specify the necessary settings: task name, one or more reviewers, sample size.

    The **sample size** specifies the number of random images that will be taken from this project for validation.

    If you select multiple reviewers, they will receive the same number of random images from the sample.

6. Click **`Creat`** button to start a new labeling task of the **extended Quality Control** type.

<figure><img src="../../.gitbook/assets/labeling-quality-control/labeling-q-c-2.jpg" alt=""><figcaption></figcaption></figure>

When we click the **`Create`** button, a Quality Control Task is immediately created with the status **On Review**.

<figure><img src="../../.gitbook/assets/labeling-quality-control/labeling-q-c-3.jpg" alt=""><figcaption></figcaption></figure>

Clicking on the title of the **Quality Control Task** opens the Labeling Tool with extended quality control functionality:

1. Extended **Accept/Reject** functionality;
2. **Error Region**.

## 1. Extended Accept/Reject Functionality

Each object includes an additional panel called **Quality Check**, which contains two buttons: **`Accept`** and **`Reject`** — used to evaluate both the **geometry** and the **class** of the object.

<figure><img src="../../.gitbook/assets/labeling-quality-control/labeling-q-c-4a.jpg" alt=""><figcaption></figcaption></figure>

This functionality allows the reviewer to indicate exactly what needs to be fixed to the annotator.

 For example, a reviewer can **reject** one or more **classes** or **geometries** in the image, providing detailed feedback on what needs to be fixed. The final click on the main **`Accept`** or **`Reject`** button—applied to the entire image—determines the status of all remaining classes and geometries that haven't been individually reviewed.
 
{% hint style="info" %}
**Note**: This functionality is only displayed for those jobs that were created via the **Send Sample to QC** function.
{% endhint %}

This allows the reviewer to selectively reject only those elements that require changes, while all other classes and geometries will be **automatically** accepted when the reviewer clicks the **main `Accept` button—and vice versa**, if the reviewer accepts only specific elements and then clicks **Reject**, all others will be automatically rejected.

<figure><img src="../../.gitbook/assets/labeling-quality-control/labeling-q-c-5a.jpg" alt=""><figcaption></figcaption></figure>

**Tags** have the same functionality.

<figure><img src="../../.gitbook/assets/labeling-quality-control/labeling-q-c-6a.jpg" alt=""><figcaption></figcaption></figure>

All these buttons **Accept** and **Reject**, which relate to classes, geometries and tags, can also be **unchecked**, that is, the status can be removed.

To view all the statistics for the extended functionality of the **Quality Control** Task, go to the Labeling Jobs section and click the **`Stats`** button under the specific task.

<figure><img src="../../.gitbook/assets/labeling-quality-control/labeling-q-c-7.jpg" alt=""><figcaption></figcaption></figure>
    
In the **QC Stats** section you will see the following metrics:

- **Geometric Accuracy** - ratio of annotation objects with geometry marked as correct, divided by total number of reviewed objects;
- **Class Accuracy** - ratio of annotation objects with class marked as correct, divided by total number of reviewed objects;
- **Tags Accuracy** - ratio of tags marked as correct, divided by total number of reviewed tags;
- **Annotations Recall** - ratio of reviewed annotation objects, divided by total number of anntation objects in the labeling job;
- **Reviewed Annotations** - total number of reviewed and non reviewed annotation objects.

## 2. Error Region

**Error Region** is a tool that can be used to mark problem areas on an image.

<figure><img src="../../.gitbook/assets/labeling-quality-control/labeling-q-c-8.jpg" alt=""><figcaption></figcaption></figure>

In the settings window you can specify the details of the **Error Region**:
1. Annotation or other reason is missing,
2. Specify the class of the missing object (geometry),
3. The number of missing objects (geometry),
4. Leave an explanatory comment.

{% hint style="info" %}
**Note**: This functionality is only displayed for those jobs that were created via the **Send Sample to QC** function.
{% endhint %}

**Technical details of the Error Region function:**

Each **Error Region** label is saved as a hidden class _$sly.error.region_ and is visible in the list of classes in the Project in the Definition tab.