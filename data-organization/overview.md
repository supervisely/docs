# Overview

To organize data for labeling and neural net training is not an easy task. If there is no structure, things get messy pretty quick. Learn those essentials to organize your efficiently. ☝️

## 🗂️ Projects

Project is a combination of datasets and related meta information (like classes and tags) and it's a major building block of data organization in Supervisely.

{% page-ref page="project/projects.md" %}

## 📂 Datasets

This is where your labeled and unlabeled images, videos and point clouds live. A dataset is some sort of data folder with stuff to annotate.  

{% hint style="success" %}
You can upload images multiple times, but only one copy will be stored inside Supervisely. This approach allows us to effectively work with cloud storage. Also this has a good effect on system performance and backup speed.
{% endhint %}

{% page-ref page="project/datasets/datasets.md" %}

## 🎨 Classes

Classes are pre-defined types of your annotations, for example Person or Background. Thus, every label you create has defined class.

{% page-ref page="project/classes/classes.md" %}

## 🏷️ Tags

To associate some extra information with annotations (or images, or videos, ...) you can define a Tag, for example `needs_review`.

{% page-ref page="project/tags/tags.md" %}

## Example

For instance, in [Team](../collaboration/teams.md) "Driving Division" you can have a **Workspace** "Pre-Labeling". In this Workspace you can have a Project "Cityscapes" with two Datasets: "Zurich" and "Stuttgart".

There are several classes defined in this Project (and, thus, in every Dataset): a building, a traffic light, a vehicle and so on. All classes are set to the "bitmap" shape, so that there is no way someone will accidentally create some "Cars" with polygon tool (a set of points), and some "Cars" with bitmap tool (a set of pixels).

Also, there are two tags defined: a "vehicle_type" of several pre-defined options ("Bus", "Bicycle", "Train") and a "color" that accepts any string value.

Datasets are used to split data into a "subfolders" to make data management easier. For example, you can then define a [Labeling Job](../labeling/jobs/README.md) to label all Vehicles in Zurich.

{% hint style="info" %}
This is just an example, experiment! Maybe you would like to have projects like "Data from Data from 14 august" or "From Mike" or even "To train v2 (final) (2)" 😃  
{% endhint %}

