---
description: Learn how to import images and a little bit more
---

# How to import

{% hint style="info" %}
This 5-minute tutorial is a part of introduction to Supervisely series. You can complete them one-by-one, in random order, or jump to the rest of the documentation at any moment.

* How to import **(you are here)**
* [How to annotate](How-to-annotate.md)
* [How to invite team members](Invite-member.md)
* [How to connect agents](connect-your-computer/)
* [How to train models](how-to-train-models.md)
{% endhint %}

{% hint style="success" %}
You can learn more about Import, such as importing different formats, import from the cloud or adding data to existing datasets in [this section.](broken-reference)
{% endhint %}

Let's start our journey with Supervisely by uploading our very first image. Of course, you can import more complex dataset formats like COCO, or modalities, such as DICOM, connect a S3 cloud and much more, but let’s begin with a simple one.

We assume that you have already created an account in Supervisely. If not, you can create a free account in our Community Edition [here.](https://app.supervisely.com/signup)

First thing you will see after you login to Supervisely, is your [Projects](../data-organization/project/projects.md) page where you can find your data. But there is nothing here yet — let’s fix that!

<figure><img src="../.gitbook/assets/import-project.png" alt=""><figcaption></figcaption></figure>

1. Click the `Import Data` button. Enter a unique name for the project, keeping in mind that it must be unique in the workspace and case-sensitive. You can also add a description of the project to provide additional information or to track project updates.
2. Next, select the P`roject type` by defining the content modality: images, videos, point clouds, or DICOM 3D volumes.&#x20;

{% hint style="warning" %}
Note that you can't mix multiple content types in the same project, and this setting can't be changed later.
{% endhint %}

3. Choose one of the available interfaces for labeling images (or other data modality). Our interfaces are designed for different industries and annotation scenarios.
4. After completing all required fields and selecting options, click `Create` to complete the project and begin uploading data.

<figure><img src="../.gitbook/assets/create-project-easy.png" alt=""><figcaption></figcaption></figure>

5. In the modal window, drag and drop one or more images in one of the supported formats, such as .jpg, .jpeg, .mpo, .bmp, .png, .webp, .tiff, .tif, .nrrd, .jfif, .avif, .heic, NIfTI, DICOM . You can also check out the supported annotation formats.&#x20;

🤗 Congratulations, the hardest part is over!

<figure><img src="../.gitbook/assets/drag-and-drop.png" alt=""><figcaption></figcaption></figure>

You will be redirected to the Tasks page where you can watch the progress of the application (your files are actually being uploaded to your [Team Files](https://docs.supervisely.com/data-organization/team-files)).&#x20;

You can click **three dots (⋮)** icon and check the application logs.

<figure><img src="../.gitbook/assets/tasks.png" alt=""><figcaption></figcaption></figure>

{% hint style="success" %}
🤓 **Nerd alert! Skip this section if you aren't interested how Supervisely works inside.**

So what is going on here? First, Supervisely will choose one of the connected Agents and ask it to run the “Auto Import'' application. It will spawn a Docker container that will download the GitHub repository with the application code and run python code written with Supervisely SDK.

It will pull your images uploaded to the Team Files in the modal window, convert them, if needed (this particular application maybe does little, but others, like Import COCO format, will transform a lot) and use API to create a Project and add images to it.
{% endhint %}

Once the import is finished, you will see the link to your new project in the `Output` column of the table.

<figure><img src="../.gitbook/assets/projects.png" alt=""><figcaption></figcaption></figure>

All set! Now, in the [next section](How-to-annotate.md), let’s annotate your uploaded images.
