# Links from CSV, TXT and TSV

## Overview

You can import Images into Supervisely project using a `.csv`, `.tsv` or `.txt` file. This import converter is designed to help you quickly upload images to Supervisely from a file containing image paths from **Team Files** or URLs from cloud storage or any accessible internet link (✨ **Available only in Enterprise Edition**).

Additionally, you can assign tags to each image by providing a tag column in the input file. This feature is optional, and you can choose to import images without any tags.

## Format description

**Supported file formats:** `.csv`, `.tsv`, and `.txt`.\
**With annotations:** yes (optional)\
**Supported annotation types:** tags\
**Grouped by:** Any structure (will be uploaded as a single dataset)\


### Key Features

* Import Images from **Team Files**
* Import Images by **URLs** from cloud storage or any accessible internet link (✨ **Available only in Enterprise Edition**)
* Supported file formats: `.csv`, `.tsv` or `.txt`
* Automatically **assign Tags** to each Image (_optional_)

### How to Use

All images will be uploaded to a single dataset, so you don't have to worry about the full project structure in Supervisely format. All you need is to prepare a file with URLs or paths and drop this file in quick import.

### Input files structure

{% hint style="success" %}
Example data: [download ⬇️](https://github.com/supervisely-ecosystem/import-wizard-docs/files/14934860/sample\_csv.zip)
{% endhint %}

In your input file, the first column is crucial as it contains either the paths or URLs to the images you want to import. This column is mandatory for the importer to function correctly.

The second column, which contains the tags, is optional. If provided, these tags will be automatically assigned to the corresponding images upon import. If this column is omitted, the images will be imported without any tags.

Yes, tags are optional for each image. If you choose not to assign tags to certain images, simply leave the tag column blank for those images in your input file. The importer will still process these images and upload them without any tags.

#### Delimiters for File Formats

In the context of this importer, we use specific delimiters for different purposes in the `.csv` file:

**Column Delimiter**

* `.csv` - A semicolon (`;`) is used to separate different columns. Each column represents a different attribute, such as the image path/url or the image tag.
* `.tsv` - A tab () is used as a delimiter to separate different columns. Similar to the `.csv` format, each column represents a different attribute.
* `.txt` - Multiple spaces ( ), tabs (), or a semicolon (`;`) can be used to separate different columns in a `.txt` file. Each column represents a different attribute, similar to the `.csv` and `.tsv` formats. Please note, ⚠️ a single space ( ) cannot be used as a delimiter.

**Tag Delimiter**

A comma (`,`) is used to separate different tags assigned to the same image for all file formats. This allows you to assign multiple tags to a single image.

#### Examples

Regardless of the file format you choose (`.csv`, `.tsv`, or `.txt`), you can specify either a path or a URL for each image, but not both in the same file. This means that each file should contain either paths to local images or URLs to internet images, but not a mix of both.

1.  **Team Files**: Create a `.csv` file with columns for the relative path to the image and the image tag.

    ```csv
        path;tag
        /dogs/img_01.jpeg;dog
        /cats/img_02.jpeg;cat
        /horses/img_01.jpeg;horse
    ```
2. **URLs**:

{% hint style="info" %}
✨ Importing images by URLs is available only in [the Enterprise Edition](https://supervisely.com/enterprise/).
{% endhint %}

*   Create a `.txt` file with columns for the full URL-link to the image and the image tag. In this example, tab () delimiters are used.

    ```
        url	tag
        https://images.io/image_example_1.png	tag1,tag2
        https://images.io/image_example_2.png	tag3
        https://images.io/image_example_3.png
    ```
*   Cloud storage link example:

    link structure: `<provider name>://<bucket name>/<path to image>`

    ```csv
    url;tag
    s3://remote-img-test/08. images YOLO masks, bboxes (mix)/ds1_IMG_0748.jpeg;1
    azure://supervisely-test/TEST-NEW-IMPORT/01. images SLY (from export)/ds1/img/IMG_1836.jpeg
    google://sly-dev-test/test_img_new/berries-02.jpeg;3
    ```

## Useful links

*   [\[Supervisely Ecosystem\] Import Images from CSV](https://ecosystem.supervise.ly/apps/import-images-from-csv)

    ![](https://imgur.com/Cqe7fjv.png)
