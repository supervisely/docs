---
description: >-
  Learn how to use labeling toolboxes, create you first annotations and a little
  bit more
---

# How to annotate

{% hint style="info" %}
This 5-minute tutorial is a part of introduction to Supervisely series. You can complete them one-by-one, in random order, or jump to the rest of the documentation at any moment.

* [How to import](How-to-import.md)
* How to annotate **(you are here)**
* [How to invite team members](Invite-member.md)
* [How to connect agents](connect-your-computer/)
* [How to train models](how-to-train-models.md)
{% endhint %}

{% hint style="success" %}
You can learn more about Labeling, such as labeling of videos and 3D point clouds, using AI-assisted labeling and more in [this section.](../labeling/Labeling-toolbox.md)
{% endhint %}

Once you've [uploaded your first images](How-to-import.md), let’s annotate them with our multiple **annotation tools** - [Bounding Box](https://supervisely.com/blog/bounding-box-annotation-for-object-detection/), [Polygon Tool](https://supervisely.com/blog/how-to-use-polygon-anotation-tool-for-image-segmentation/), [Brush and Eraser Tool](https://supervisely.com/blog/brush/), [Mask Pen Tool](https://supervisely.com/blog/mask-pen-tool/), [Smart Tool](https://supervisely.com/blog/smarttool-annotation/), [Graph (Keypoins) Tool](https://supervisely.com/blog/animal-pose-estimation/), effectively supports 1000+ objects per image.

Click on the project you’ve just created. This will open the list of datasets (subfolders) inside your project (you can learn more about data organization [here](../data-organization/overview.md)). Depending on whether you uploaded a set of folders with images or just images directly, there may be one or more datasets.&#x20;

{% hint style="info" %}
Don’t worry — you can move and copy images between datasets (and even projects) using the “three dots” (⋮) or [Data Commander.](../data-organization/data-commander/)&#x20;
{% endhint %}

<figure><img src="../.gitbook/assets/dataset (1).png" alt=""><figcaption></figcaption></figure>

At the top of this page you will find more tabs, such as classes and tags. There you can define a meta information, shared across all of the datasets inside a particular project. Let’s focus on [classes](broken-reference) first.

A class allows you to define a type of your annotations. Every annotation object must have exactly one class. For example, you can define a class “Car” and limit it the shape “bounding box”: now, if you define a [labeling job](../labeling/jobs/) and assign your [team member](../collaboration/members.md) to annotate a bunch of images with “Cars”, they will only be able to place bounding boxes and label them as “Cars” (unless you configure more classes, of course).

Now, let’s go to the classes tab and click the `New` button. Let’s enter some title to it, select a shape (let’s select “bounding box” for this one) and click `Save`.

{% hint style="info" %}
You can select “Any Shape” — that will allow to mark annotations of any shape with this class, so can have both “bounding box” and “mask” marked as this class at the same time. Be worried, that could potentially create issues when you try to train a neural network.
{% endhint %}

<figure><img src="../.gitbook/assets/create-class.png" alt=""><figcaption></figcaption></figure>

Awesome! Now, switch back to the **Data** tab and click on any dataset. Once you're inside the dataset, selecting any image or clicking the `Annotate` button will bring up a dialog asking you to choose a labeling toolbox ( yeah, we have lots!). Select an “Image labeling toolbox 2.0”. A new tab should appear with your dataset in the labeling toolbox.

{% hint style="info" %}
You can label all data in your project at once by using the `Annotate` button on the dataset page.
{% endhint %}

<figure><img src="../.gitbook/assets/open-toolbox.png" alt=""><figcaption></figcaption></figure>

{% hint style="info" %}
You can switch the dark theme to light or back at any time.
{% endhint %}

From the left toolbar select a tool that corresponds to your class shape, in our case, [<mark style="color:blue;">Bounding Box Tool</mark>](https://supervisely.com/blog/bounding-box-annotation-for-object-detection/) to create bounding boxes. You can hover your cursor over the particular tool button and check the description.

Now, let’s hover the cursor over any object on your image and make two clicks to form a rectangle around it. You will see a new object in the right sidebar at the `Objects` tab. Done!

<figure><img src="../.gitbook/assets/car-annotate (1).gif" alt=""><figcaption></figcaption></figure>

You can also check our blog post on how to label with bounding boxes:

{% embed url="https://supervisely.com/blog/bounding-box-annotation-for-object-detection/" %}

You rock! Now, you can explore other labeling tools (such as [polygons](https://supervisely.com/blog/how-to-use-polygon-anotation-tool-for-image-segmentation/), [<mark style="color:blue;">masks</mark>](https://supervisely.com/blog/smarttool-annotation/) or [<mark style="color:blue;">skeleton shapes</mark>](https://supervisely.com/blog/human-pose-estimation/)), more advanced tools, such as video or [<mark style="color:blue;">3D point clouds</mark>](https://supervisely.com/blog/3d-object-interpolation-in-point-clouds/) — or continue our journey and see how [collaboration](../collaboration/members.md) works in Supervisely.
