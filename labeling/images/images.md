Images panel shows all images of current dataset.

## Overview

![](../../assets/legacy/annotation/images.png)

1. Total number of images in dataset
2. [Filter of images](#filters)
3. Preview picture
4. File name
5. Number of annotations
6. Last modification date (i.e. modification of annotation)
7. Attach [new tag](#tags) to an image
8. Download original image file
9. Delete image and all of its annotations

{% hint style="info" %}
Current image is highlighted in blue color. You can switch between images by clicking on file names in Images Panel or using [Navigation Panel](navigation.md) or using `Left Arrow` and `Right Arrow` hotkeys.
{% endhint %}

## Filters

![Images Filter](../../assets/legacy/annotation/images-filter.png)

If there are a lot of images in dataset, you can use filter popup to leave only images that pass certain conditions or order images.

Open filter popup by clicking `Filter` icon (see [overview](#overview) above)

{% hint style="info" %}
Create [tags](#tags) like `Valid` and `Invalid` to mark images that have correct / incorrect annotations and then apply filter to quickly find images that need additional labeling.
{% endhint %}

{% hint style="info" %}
Choose `Objects count` - `None` to quickly find images that need annotations.
{% endhint %}

## Tags

![Image Tags](../../assets/legacy/annotation/image-tags.png)

Tags are predefined list of keywords to quickly mark images. Tags can be used in [images filter](#filters), [DTL](../../data-manipulation/dtl/index.md) or downloaded along with JSON annotation files.

You can add new image tags on `Project` page under `Tags/Image tags` tab in [dashboard](../../data-organization/projects.md) or right in annotation module using popup displayed on this image above.

{% hint style="success" %}
Assign a hotkey when you add a new tag. Thus you can quickly attach tag to an image by pressing corresponding hotkey on a keyboard.
{% endhint %}

{% hint style="info" %}
Create tag `Valid` and assign it hotkey `V`. Now you can mark images with correct annotation by pressing `V` key on a keyboard and go to the next image by pressing `Right Arrow` key.
{% endhint %}

## Notes

{% hint style="info" %}
Number of images shown in panel is limited to **50**. If current dataset contains more images than that, pagination will be shown below.
{% endhint %}

{% hint style="info" %}
Don't worry about image size. After uploading dataset using [Import](../../data-organization/import-export.md), apart from original images, we generate two more versions: 40x40 compressed preview for `Images Panel` and compressed version of original that is used for showing in annotation module. Original is used in [DTL](../../data-manipulation/dtl/index.md) and in downloads.
{% endhint %}
