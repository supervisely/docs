# Import from Cloud

It's also worth mentioning that we have applications to import data not from your computer, but from cloud services.

No matter which method you choose, you have the option to import files by links, meaning they won't be stored directly on the Supervisely disk. These files will only be accessible through the provided links. This method offers flexibility in data management, and you can still use both this approach and the traditional file import for the convenience of your workflows.

## Import images without labels from S3, Google Cloud, Azure and others

[This apps](https://ecosystem.supervisely.com/apps/import-images-from-cloud-storage) allows to import images from most popular cloud storage providers to Supervisely Private instance.

**List of providers:**

* Amazon S3
* Google Cloud Storage (GCS)
* Microsoft Azure
* and others with S3 compatible interfaces

**App supports two types of import:**

* copy images from cloud to Supervisely Storage
* add images by link

{% embed url="https://www.youtube.com/watch?v=LJRA84FXHl4&ab_channel=Supervisely" %}

## Import images **with** labels from S3, Google Cloud, Azure and others

[This app](https://ecosystem.supervisely.com/apps/import-images-in-sly-format-from-cloud-storage) enables the straightforward import of images with associated annotations from various cloud storage services like S3, Google Cloud, Azure, and others. It provides a convenient way to handle annotated images, facilitating effective data management for various purposes. You can learn about Supervisely format [here](../../Annotation-JSON-format/01_Project_Structure_new.md).

## Import videos, point clouds and other from S3, Google Cloud, Azure

[This apps](https://ecosystem.supervisely.com/apps/import-videos-from-cloud-storage) allows to import videos from most popular cloud storage providers to Supervisely Private instance.

List of providers:

* Amazon S3
* Google Cloud Storage (GCS)
* Microsoft Azure
* and others with S3 compatible interfaces

**App supports two types of import:**

1. Copy videos from cloud to Supervisely Storage (pros: fast video streaming, cons: data is duplicated)
2. Add videos by link (pros: data will not be duplicated, cons: video streaming lags are possible - it depends on cloud configuration)

## Import images from disk without copying

You also have the opportunity to use applications [Import images from cloud storage](https://ecosystem.supervisely.com/apps/import-images-from-cloud-storage) and [Import image projects in Supervisely format from cloud storage](https://ecosystem.supervisely.com/apps/import-images-in-sly-format-from-cloud-storage) with the FileSystem serving as the data provider. This provides the capability to import images directly from the disk without copying, offering convenience and efficiency when working with local data.

## Apps for importing public data

* [Pexels downloader](https://ecosystem.supervisely.com/apps/pexels-downloader)
* [Flickr downloader](https://ecosystem.supervisely.com/apps/flickr-downloader)
* [Import Cityscapes](https://ecosystem.supervisely.com/apps/import-cityscapes)

## **Import in Supervisely Format from a Web-server**

[Remote import](https://ecosystem.supervisely.com/apps/remote-import) allows you connect your remote data storage to Supervisely Platform without data duplication.

Most frequent use case is when Enterprise Customer would like to connect huge existing data storage (tens of terabytes) and avoid data duplication. In other cases we recommend to use general import procedure to store data in [Supervisely Data Storage](storage/)

![Remote Import APP](../../../.gitbook/assets/remote-import.png)
