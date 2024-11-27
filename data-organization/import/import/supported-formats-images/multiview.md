# Multi-view images

## Overview

Multi-view mode is a feature that allows you to view and annotate multiple images simultaneously. It is especially useful when you need to label objects from different perspectives, 3D reconstruction images, Autonomous vehicle camera views or depth estimation task images. Labeling in multi-view mode can significantly increase the speed of the labeling process (for example, you don't need to switch between images and select a desired class to label the same object)

Just organize images into groups and drop them to the import. The app will do the rest: it will detect groups, tag images, and activate grouping and multi-view modes in the project settings.

{% hint style="info" %}
Note: To use the multi-view import feature, you need to create a project with the `Multi-view image annotation` setting enabled. You can also enable this setting in the project settings after the import. Here is an illustration of how to upload multi-view images:
{% endhint %}

![Import Multi-view images](https://github.com/supervisely-ecosystem/import-wizard-docs/assets/79905215/81e7c8d1-dc38-4baf-bcef-165521a33c2a)

## Format description

**Supported image formats:** `.jpg`, `.jpeg`, `.mpo`, `.bmp`, `.png`, `.webp`, `.tiff`, `.tif`, `.jfif`, `.avif`, `.heic`, and `.heif`\
**With annotations:** Yes\
**Annotation types:** Tags in Supervisely format\
**Grouped by:** Folders (corresponding tags will be assigned to images)\


### Key Features

* All images in groups in the created project will be tagged
* `Images Grouping` option will be turned on by default in the created project
* Images will be grouped by tag's value
* Tag value is defined by the group directory name
* Works with `.nrrd` image format (2D only)

### How to Use

**1. Prepare structure:**

*   **Archive** `zip`, `tar`, `tar.xz`, `tar.gz`

    ```
      📦 my_project.zip
       ┗ 📂 cars catalog
          ┗ 📂 used cars
             ┣ 📂 105
             ┃  ┣ 🏞️ car_105_front.jpg
             ┃  ┗ 🏞️ car_105_top.jpg
             ┣ 📂 202
             ┃  ┣ 🏞️ car_202_front.jpg
             ┃  ┗ 🏞️ car_202_top.jpg
             ┣ 📂 357
             ┃  ┣ 🏞️ car_357_front.jpg
             ┃  ┗ 🏞️ car_357_top.jpg
             ┣ 🏞️ car_401_front.jpg
             ┣ 🏞️ car_401_top.jpg
             ┗ 🏞️ car_401_side.jpg
    ```
*   **Folder**

    ```
      📂 cars catalog
       ┗ 📂 used cars
          ┣ 📂 car_id_105
          ┃  ┣ 🏞️ car_105_front.jpg
          ┃  ┗ 🏞️ car_105_top.jpg
          ┣ 📂 car_id_202
          ┃  ┣ 🏞️ car_202_front.jpg
          ┃  ┗ 🏞️ car_202_top.jpg
          ┣ 📂 car_id_357
          ┃  ┣ 🏞️ car_357_front.jpg
          ┃  ┗ 🏞️ car_357_top.jpg
          ┣ 🏞️ car_401_front.jpg
          ┣ 🏞️ car_401_top.jpg
          ┗ 🏞️ car_401_side.jpg
    ```

    **Structure explained:**

    * An archive must contain only 1 project directory.
    * Inside the project directory must be 1 dataset directory.
    * Group directories must be populated with images and placed inside the dataset directory. All images inside the group will be tagged with folder name value.
    * All images in the root dataset directory will be uploaded as regular images and will not be tagged.

{% hint style="success" %}
We prepared sample datasets for you to try the import process:

* images: [download ⬇️](https://github.com/supervisely-ecosystem/import-images-groups/releases/download/v0.0.1/cars.catalog.zip)
* NRRD: [download ⬇️](https://github.com/supervisely-ecosystem/import-images-groups/releases/download/v0.0.1/research.zip)
{% endhint %}

*   To display single images switch off `Images Grouping` setting.

    ![Switch off multi view mode](images/multi\_view\_toggle.gif)
*   If you want to disable images grouping for the whole project, go to `Project` → `Settings` → `Visuals` and uncheck

    ![Disable multi view in project settings](images/multi\_view\_1.png)
*   Windowing tool is available when working with `.nrrd` files. It helps to filter pixels to see bones, air, liquids etc.

    ![Nrrd windowing tool](images/multi\_view\_2.png)
*   Images view synchronization

    | Synchronization OFF ![](images/multi\_view\_3.png) | Synchronization ON ![](images/multi\_view\_4.png) |
    | -------------------------------------------------- | ------------------------------------------------- |

## Useful links

*   [\[Supervisely Ecosystem\] Group Images for Multiview Labeling](https://ecosystem.supervisely.com/apps/group-images-for-multiview-labeling)

    ![](https://github.com/supervisely-ecosystem/group-images-for-multiview-labeling/assets/57998637/823cf901-8d8c-4a64-b884-c59f5ff83e93)
*   [\[Supervisely Ecosystem\] Import images groups](https://ecosystem.supervisely.com/apps/import-images-groups)

    ![](https://i.imgur.com/wAiE0ld.png)

## Easy integration for Python developers

Automate processes with multi-view images using Supervisely Python SDK.

```bash
pip install supervisely
```

You can learn more about it in our [Developer Portal](https://developer.supervisely.com/getting-started/python-sdk-tutorials/images/multiview-images), but here we'll just give you a quick examples of how you can get started with multi-view images.

### Upload multi-view images

The following code snippets demonstrate how you can upload your multi-view images with just a few lines of code.

```python
# enable multi-view display in project settings
api.project.set_multiview_settings(project_id)

images_paths = ['path/to/audi_01.png', 'path/to/audi_02.png']

# upload group of images
api.image.upload_multiview_images(dataset_id, "audi", images_paths)
```

In the example above we uploaded two groups of multi-view images. Before or after uploading images, we also need to enable image grouping in the project settings.\

### Group existing images for multi-view

If you already have images in your project and you want to group them for multi-view, you can group them by your own logic.

{% hint style="info" %}
Available starting from version `v6.73.236` of the Supervisely Python SDK.
{% endhint %}

Here is an example of how you can do it with just a single line of code.
```python
images_1 = [2389126, 2389127, 2389128, 2389129, 2389130]
group_name_1 = 'audi'
api.image.group_images_for_multiview(images_1, group_name_1)
```
By default, images will be grouped by the value of the `multiview` tag.
You can change the tag name by passing the `multiview_tag_name` argument.

```python
multiview_tag_name = 'cars'
api.image.group_images_for_multiview(images_1, group_name_1, multiview_tag_name)
```

Let's consider a more complex example.
For instance, you have a project with several datasets containing images of cars. You can group them by dataset name. If there are a lot of images in datasets, we recommend splitting them into smaller groups of 6-12 images (depending on the size of your display).

```python
GROUP_SIZE = 6  # number of images in one group

project_id = 111111
meta_json = api.project.get_meta(project_id, with_settings=True)
meta = sly.ProjectMeta.from_json(meta_json)

datasets = api.dataset.get_list(project_id, recursive=True)
with sly.ApiContext(api, project_id=project_id, project_meta=meta):
    for dataset in datasets:
        images = api.image.get_list(dataset.id, force_metadata_for_links=False)
        image_ids = [image_info.id for image_info in images]

        for idx, ids in enumerate(sly.batched(image_ids, batch_size=GROUP_SIZE)):
            group_name = f"{dataset.name}_{idx}"
            api.image.group_images_for_multiview(ids, group_name)
```

Enabling multi-view mode in the project settings is not required, as it will be done automatically in the `group_images_for_multiview` method.