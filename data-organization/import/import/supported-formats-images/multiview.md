# Multiview images

## Overview

Multiview mode is a feature that allows you to view and annotate multiple images simultaneously. It is especially useful when you need to label objects from different perspectives, 3D reconstruction images, Autonomous vehicle camera views or depth estimation task images. Labeling in multiview mode can significantly increase the speed of the labeling process (for example, you don't need to switch between images and select a desired class to label the same object)

Just organize images into groups and drop them to the import. The app will do the rest: it will detect groups, tag images, and activate grouping and multiview modes in the project settings.

{% hint style="info" %}
Note: To use the multiview import feature, you need to create a project with the `Multiview image annotation` setting enabled. You can also enable this setting in the project settings after the import. Here is an illustration of how to upload multiview images:
{% endhint %}

![Import Multiview images](https://github.com/supervisely-ecosystem/import-wizard-docs/assets/79905215/81e7c8d1-dc38-4baf-bcef-165521a33c2a)

Enterprise users have access to "Import as links" option, which supports import of this format with annotations. This option might be beneficial in many cases, as it allows data import to Supervisely platform without re-uploading, maintaining a single source and speeding up import process.

To step up import speed even further you can compress all annotation files (`.json`'s) into an archive and import it together with the images. (Note: This method is format-dependent and may not apply to all formats.)

## Format description

**Supported image formats:** `.jpg`, `.jpeg`, `.mpo`, `.bmp`, `.png`, `.webp`, `.tiff`, `.tif`, `.jfif`, `.avif`, `.heic`, and `.heif`\
**With annotations:** Yes\
**Annotation types:** Tags in Supervisely format\
**Grouped by:** Folders (corresponding tags will be assigned to images)\\

### Key Features

* 🏷️ NEW: Upload multiview project with grouped labels
* All images in groups in the created project will be tagged
* `Images Grouping` option will be turned on by default in the created project
* Images will be grouped by tag's value
* Tag value is defined by the group directory name
* Works with `.nrrd` image format (2D only)

### Supported directory structures

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
*   🏷️ **NEW: Supervisely Project Folder or Archive with label groups**

    This type of structure will work only if you have the required data in the files:

    * All images must be tagged with a group tag of the same value.
    * All necessary labels must be tagged with a label group tag of the same value.
    * The project settings in `meta.json` must contain a `multiView` section with the correct data.

    **Recommended structure**

    ```
    📦archive
     ┗📂project folder
       ┣ 📂dataset_name_01
       ┃  ┣ 📂ann
       ┃  ┃  ┣ 📄106_1.jpeg.json
       ┃  ┃  ┣ 📄106_2.jpeg.json
       ┃  ┃  ┣ 📄106_3.jpeg.json
       ┃  ┃  ┣ 📄107_1.jpeg.json
       ┃  ┃  ┗ ...
       ┃  ┣ 📂img
       ┃  ┃  ┣ 🏞️106_1.jpg
       ┃  ┃  ┣ 🏞️106_2.jpg
       ┃  ┃  ┣ 🏞️106_3.jpg
       ┃  ┃  ┣ 🏞️107_1.jpg
       ┃  ┃  ┗ ...
       ┃  ┗ 📂meta (optional)
       ┃     ┣ 📄106_1.jpeg.json
       ┃     ┣ 📄106_2.jpeg.json
       ┃     ┣ 📄106_3.jpeg.json
       ┃     ┣ 📄107_1.jpeg.json
       ┃     ┗ ...
       ┗ 📄meta.json
    ```

    **Annotation explained:**

    Below is the annotation for each image, for example `106_1.jpeg.json`. Only the lines of interest are shown; other lines are omitted, but the structure is preserved.

    ```json
    {
    	"tags": [
    		{
    			"name": "multiview",
    			"value": "106"
    		}
    	],
    	"objects": [
    		{
    			"classTitle": "Head Light",
    			"tags": [
    				{
    					"name": "@label-group-id",
    					"value": "head-light"
    				}
    			]
    		}
    	]
    }
    ```

    For an image group, an image must be tagged with the `multiview` tag (in our example) and assigned a value that represents the group, such as `106`.

    For a label group, an object (label) must be tagged with the `@label-group-id` tag and assigned a value that represents the group. For example `head-light`

    **Meta explained**

    Required setting for the project to import as multiview. Also shown only lines of interest.

    ```json
    {
    	"projectSettings": {
    		"multiView": {
    			"enabled": true,
    			"tagName": "multiview"
    		}
    	}
    }
    ```

    **Image Labeling Tool Interface**

    * 1 Multiview group
    * 2 Labeling group

    ![Labeling Tool Interface](https://github.com/user-attachments/assets/5283e0b7-eb22-48ce-ae3b-e991191857da)

{% hint style="success" %}
We prepared sample datasets for you to try the import process:

* images: [download ⬇️](https://github.com/supervisely-ecosystem/import-images-groups/releases/download/v0.0.1/cars.catalog.zip)
* NRRD: [download ⬇️](https://github.com/supervisely-ecosystem/import-images-groups/releases/download/v0.0.1/research.zip)
{% endhint %}

*   To display single images switch off `Images Grouping` setting.

    ![Switch off multiview mode](../../../../.gitbook/assets/multi_view_toggle.gif)
*   If you want to disable images grouping for the whole project, go to `Project` → `Settings` → `Visuals` and uncheck

    ![Disable multiview in project settings](../../../../.gitbook/assets/multi_view_1.png)
*   Windowing tool is available when working with `.nrrd` files. It helps to filter pixels to see bones, air, liquids etc.

    ![Nrrd windowing tool](../../../../.gitbook/assets/multi_view_2.png)
*   Images view synchronization

    | Synchronization OFF ![](../../../../.gitbook/assets/multi_view_3.png) | Synchronization ON ![](../../../../.gitbook/assets/multi_view_4.png) |
    | --------------------------------------------------------------------- | -------------------------------------------------------------------- |

## Useful links

*   [\[Supervisely Ecosystem\] Group Images for Multiview Labeling](https://ecosystem.supervisely.com/apps/group-images-for-multiview-labeling)

    ![](https://github.com/supervisely-ecosystem/group-images-for-multiview-labeling/assets/57998637/823cf901-8d8c-4a64-b884-c59f5ff83e93)
*   [\[Supervisely Ecosystem\] Import Multiview Image Groups](https://ecosystem.supervisely.com/apps/import-images-groups)

    ![](https://github.com/user-attachments/assets/1788313e-8ef3-4f42-9277-38e32aa9dfa6)

## Easy integration for Python developers

Automate processes with multiview images using Supervisely Python SDK.

```bash
pip install supervisely
```

You can learn more about it in our [Developer Portal](https://developer.supervisely.com/getting-started/python-sdk-tutorials/images/multiview-images), but here we'll just give you a quick examples of how you can get started with multiview images.

### Upload multiview images

The following code snippets demonstrate how you can upload your multiview images with just a few lines of code.

```python
# enable multiview display in project settings
api.project.set_multiview_settings(project_id)

images_paths = ['path/to/audi_01.png', 'path/to/audi_02.png']

# upload group of images
api.image.upload_multiview_images(dataset_id, "audi", images_paths)
```

In the example above we uploaded two groups of multiview images. Before or after uploading images, we also need to enable image grouping in the project settings.\\

### Group existing images for multiview

{% hint style="info" %}
Available starting from version `v6.73.236` of the Supervisely Python SDK.
{% endhint %}

If you already have images in your project and you want to group them for multiview, you can group them by your own logic. By default, images will be grouped by the value of the `multiview` tag. You can change the tag name by passing the `multiview_tag_name` argument.

Here is an example of how you can do it with just a few lines of code.

```python
images_1 = [2389126, 2389127, 2389128, 2389129, 2389130]
group_name_1 = 'audi'
multiview_tag_name = 'cars' # optional
api.image.group_images_for_multiview(images_1, group_name_1, multiview_tag_name)
```

{% hint style="success" %}
* If the tag does not exist, it will be created automatically.
* If multiview mode is not enabled in the project settings, it will be enabled automatically.
{% endhint %}

Let's consider a more complex example. For instance, you have a project with several datasets containing images and you want to group them by dataset name. Here is an example of how you can do it.

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

{% hint style="info" %}
We recommend grouping images in batches of 6-12 images (depending on the size of your display).
{% endhint %}

### How to upload label groups

{% hint style="info" %}
Available starting from version `v6.73.293` of the Supervisely Python SDK.
{% endhint %}

There are many cases when you need to group labels together. For example, if you have some labels captured from different perspectives that represent one object on different images and you want to analyze the object as a whole and not as separate instances, you can join them into a single group.

**Label group** - is a simple group of objects, that displays the relationship between objects and helps you to quickly locate the object on different images and to avoid labeling the same object multiple times.

![label group example](https://github.com/user-attachments/assets/2552ce5c-76b3-41fd-be12-80d1dd6e834d)

Using the `api.annotation.append_labels_group` method, you can upload labels as a group to images.

Let's group it all together and upload local images and labels to Supervisely using this method.

Our sample data directory structure:

```
 📂 data
 ┣ 📂 images
 ┃ ┣ 🏞️ car_01.jpeg
 ┃ ┣ 🏞️ car_02.jpeg
 ┃ ┗ 🏞️ car_03.jpeg
 ┗ 📂 masks
   ┣ 🏞️ car_01.png
   ┣ 🏞️ car_02.png
   ┗ 🏞️ car_03.png
```

![data sample](https://github.com/user-attachments/assets/746eff69-e3c3-43f8-8094-8b5839dee61f)

⬇️ You can download this sample here: [data.zip](https://github.com/supervisely/developer-portal/releases/download/untagged-6cc0d25bd610d680cc0d/data.zip)

Follow the code below to upload images and labels to Supervisely.

```python
project_id = 56
dataset_id = 196

# GET PROJECT META
meta = sly.ProjectMeta.from_json(api.project.get_meta(project_id, with_settings=True))

# GET OBJ CLASS FROM META BY NAME
obj_cls = meta.get_obj_class("car")
# OR CREATE NEW OBJ CLASS IF NOT EXISTS
# obj_cls = sly.ObjClass(name="car", geometry_type=sly.Rectangle, color=[255, 0, 0])
# UPDATE PROJECT META IF CREATING NEW OBJ CLASS
# meta = meta.add_obj_classes([obj_cls])
# api.project.update_meta(project_id, meta.to_json())

# SET MULTIVIEW SETTINGS
api.project.set_multiview_settings(project_id)

# GET IMAGES AND MASKS PATHS
image_dir = os.path.join("data", "images")
mask_dir = os.path.join("data", "masks")

# SORT PATHS FOR CORRECT LABELS ORDER
image_paths = sorted([os.path.join(image_dir, path) for path in os.listdir(image_dir)])
mask_paths =  sorted([os.path.join(mask_dir, path) for path in os.listdir(mask_dir)])

# CREATE LABELS
labels = []
for image_path, mask_path in zip(image_paths, mask_paths):
    # READ MASK
    bitmap = sly.Bitmap.from_path(mask_path)
    # CREATE LABEL
    label = sly.Label(geometry=bitmap, obj_class=obj_cls)
    labels.append(label)

# UPLOAD IMAGES
image_infos = api.image.upload_multiview_images(dataset_id, "white_car", image_paths)
images_ids = [image_info.id for image_info in image_infos]

# APPEND LABELS TO IMAGES
api.annotation.append_labels_group(
    dataset_id=dataset_id,
    image_ids=images_ids,
    labels=labels,
    project_meta=meta,
)
```

**Result:**

![result](https://github.com/user-attachments/assets/6a89c945-529a-4125-98c3-6d0582ce05dd)
