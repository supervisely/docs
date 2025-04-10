# 🤖 Supervisely Extended: Blob

## Overview

When dealing with large quantities of small images (e.g., thousands of images under 100KB each), importing them individually is inefficient. The blob approach combines multiple images into a single archive file, making transfer and storage more efficient.

## Annotations with Blob format

The key advantage of the blob format is that it optimizes storage and transfer of image data without changing how annotations work. When using blob format:

- **Annotations remain in the standard Supervisely JSON format** exactly as described in the [Supervisely JSON](supervisely.md) documentation
- Each annotation file still corresponds to a specific image by name
- All annotation features (rectangles, polygons, masks, etc.) work exactly the same way
- The only difference is how the image data itself is stored and accessed

{% hint style="info" %}
This approach gives you the best of both worlds: efficient storage and transfer of image data while maintaining the flexible and powerful Supervisely annotation system you're already familiar with.
{% endhint %}

### What is a Blob File?

A blob file in Supervisely is essentially a `.tar` archive that contains multiple images bundled together. Instead of storing and transferring each image as a separate file, these images are packed into a single large file (the blob). 

This approach:
- Reduces the number of network requests needed for transfers
- Minimizes filesystem overhead when dealing with many small files

### What is an Offset File?

An offset file `.pkl` is a companion file to the blob archive that contains metadata about where each image is located within the blob file. 

Specifically:
- It maps each image filename to its exact byte position (start and end offsets) in the blob file
- Allows direct extraction of specific images without scanning the entire archive
- Stored as a Python pickle file containing batches of dictionaries with image names as keys and offset positions as values

These two files work together to provide efficient storage and random access to large collections of small images.

Benefits include:

-   Faster import and export speeds
-   Reduced server load
-   More efficient storage on disk


### Offset Representation

The `BlobImageInfo` class of [Supervisely Python SDK](https://supervisely.readthedocs.io/en/latest/index.html) represents image metadata within a blob storage file. It contains information about where the image data is located in the blob file, defined by byte offsets. This class provides methods to manipulate and convert blob image information to formats suitable for storage and API interactions.

{% hint style="success" %} Once blob files are uploaded to Team Files, you can reuse them for multiple projects without re-uploading the images. {% endhint %}

This approach helps optimize the import process for multiple projects since you don't need to re-upload the original images each time. By simply creating and uploading different offset files, you can import different subsets of images from the same blob archive.

### Recommended Project Structure

A typical blob-based project structure looks like this:

```text
📂 project-name
 ┣ 📂 blob
 ┃  ┗ 📦 small_images.tar
 ┣ 📂 dataset-name-001
 ┃  ┣ 📄 small_images_offsets.pkl
 ┃  ┣ 📂 ann
 ┃  ┃  ┣ 📄 small-image-0000001.png.json
 ┃  ┃  ┣ ...
 ┃  ┃  ┗ 📄 small-image-0999999.png.json
 ┗ 📄 meta.json
```

For detailed information about blob project structure, refer to the extended [Project Structure documentation](../../../Annotation-JSON-format/01_Project_Structure_new.md#extended-project-structure).


## Performance Comparison Information

A blob project with 30000 small images (~4KB each) can be:

-   Uploaded `~2x` faster than standard uploads, `~x14` especially using Quick Import
-   Downloaded `~4x` faster than standard downloads, `~22x` especially using fast methods


## Useful links
* [Supervisely Annotation Format](https://developer.supervisely.com/getting-started/supervisely-annotation-format)
* [Supervisely Image Annotation](https://developer.supervisely.com/getting-started/supervisely-annotation-format/images)
* [\[SDK CLI\] Upload projects in Supervisely format](https://developer.supervisely.com/getting-started/command-line-interface/sdk-cli#upload-a-project)
* [\[CLI Tool Beta\] Upload projects in Supervisely format](https://developer.supervisely.com/getting-started/command-line-interface/cli-tool/workflow-automation#upload-projects-in-supervisely-format)
*   [\[Supervisely Ecosystem\] Import images in Supervisely format](https://ecosystem.supervisely.com/apps/import-images-in-sly-format)

    <img src="https://i.imgur.com/Y6RcQPT.png" height="60">
