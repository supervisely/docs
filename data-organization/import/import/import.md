# Import 
You already know that we have projects and datasets, catalogs of pictures and videos. You can also [create annotations](../../../labeling/images/README.md) there, but how can you load your data or try supervisely a data sample as an example?

Dataset formats are very different (coco, cityscapes and others), and there are many more modalities (pictures, videos and others), and even just with pictures, there are many variations of file formats.

So that you get pleasure and don’t have to convert anything yourself, here at Supervisely we’ve put together a bunch of [applications](https://app.supervisely.com/ecosystem/import) for all occasions, and if we don’t have one, you can write an [app import yourself](https://developer.supervisely.com/) or use the [API.](https://api.docs.supervisely.com/)

Using applications or methods, you can turn your files of pictures, videos and annotations into projects and datasets into supervisely - they will be stored in our megaformat [Supervisely Fromat](../../Annotation-JSON-format/00_ann_format_navi.md) and at any time you can [download](../export/export.md)    them in this or another format.

**We at Supervisely support three ways to store your assets:**
- Storage in supervisor storage locally, for example on a hard drive (default option)
- Supervisor storage on a remote disk, for example S3 (enterprise only available)
- Storage in external storage Import by “Links”

**When importing we count file hashes and do not initiate upload of duplicates.**