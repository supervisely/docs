# Import

As you already know, we have a concept of [projects and datasets](../../overview.md). Now, how can you import your dataset to Supervisely?

Dataset formats are very different (coco, cityscapes and others), and there are many more modalities (pictures, videos and others), and even just with pictures, there are many variations of file formats.

We don’t want you to convert anything yourself, so, to deal with that, here at Supervisely we’ve put together a number of [Supervisely Apps](https://ecosystem.supervisely.com/import) for every format out there (and if we don’t have one, you can write an [app import yourself](https://supervisely.readthedocs.io/en/latest/sdk_packages.html) or use the [API](https://api.docs.supervisely.com/)).

Using Supervisely Apps or API, you can turn your pictures, videos and annotations into Supervisely projects and datasets: they will be stored in the [Supervisely Format](../../supervisely-format.md) and at any time you can [download](../export/export.md) them in this or another format.

Supervisely has three ways how to store your assets:

**Store files locally**

The default strategy is to place all uploaded and generated assets to the storage on the same server where Supervisely is installed, for example, on a hard drive.

**Store files remotely**

The instance administrator can configure the Supervisely platform to upload and store all generated assets to a remote cloud storage provider, such as S3. This can affect performance, since files need to be transferred over the network, but it is a more reliable method of data storage. This is only available on Enterprise Edition.

**Store individual files remotely (“Import by Link”)**

The hybrid approach that takes the best of both worlds. In this scenario, you don't store files locally (so that generated or uploaded manually files end up on a hard drive), but use [special Supervisely Apps](Import-from-Cloud.md) or API methods to add images or videos to datasets “by link”. That means, that instead of uploading the actual content of the file, you provide a resource url (such as “https://…” or “s3://…”) and Supervisely will not store the content on the platform — instead, it will load it from your remote provider on-fly. This method allows you to import huge datasets almost instantly, but you will have to manage the remote storage yourself.

{% hint style="info" %}

Supervisely calculate file hashes when you upload your assets: because of that, we do not store duplicates.

{% endhint %}

<table data-view="cards">
   <thead>
      <tr>
         <th></th>
         <th></th>
         <th data-hidden data-card-target data-type="content-ref"></th>
      </tr>
   </thead>
   <tbody>
      <tr>
         <td><strong>Import using Web UI</strong></td>
         <td>The most simple and straightforward method of importing is uploading your data using one of our Supervisely Apps.</td>
         <td><a href="Import-using-Web-UI.md">Import using Web UI</a></td>
      </tr>
      <tr>
         <td><strong>Import sample dataset</strong></td>
         <td>Save valuable time by starting with already prepared datasets. We provide access to a variety of ready-made data to speed up your start.</td>
         <td><a href="Import-sample-dataset.md">Import sample dataset</a></td>
      </tr>
      <tr>
         <td><strong>Import into an existing dataset</strong></td>
         <td>It is possible to add more assets such as images to the existing project or dataset.</td>
         <td><a href="exesting-dataset.md">Import into an existing dataset</a></td>
      </tr>
       <tr>
         <td><strong>Import using Team Files</strong></td>
         <td>you can just select the appropriate Supervisely App from the context menu of a folder in your Team Files — and enjoy.</td>
         <td><a href="Import-Team-Files.md">Import using Team Files</a></td>
      </tr>
     <tr>
         <td><strong>Import from Cloud</strong></td>
         <td>Want to contribute to Supervisely? Start with our GitHub page here.</td>
         <td><a href="Import-from-Cloud.md">Import from Cloud</a></td>
      </tr>
      <tr>
         <td><strong>Import using API & SDK</strong></td>
         <td>Save valuable time by starting with already prepared datasets.</td>
         <td><a href="import-sdk-api.md">Import using API & SDK</a></td>
      </tr>
   </tbody>
</table>
