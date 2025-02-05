# Overview

 With more than 5 years of constant improvement, proved by hundreds of businesses, Supervisely provides a complete set of labeling toolboxes for various modalities and tasks, starting from images, videos, and including even solutions for 3D point clouds and volumetric data.

## Pre-Requirements

Follow those recommendations for the best results:

{% hint style="info" %}
Though we support all common web browsers, we strongly recommend using **Google Chrome** or **Mozilla Firefox**, because we use latest technologies to render annotations. We also advise you to use the latest version of web browser.
{% endhint %}

{% hint style="success" %}
To work with large images and lots of annotations we recommend to use computer with hardware acceleration available. Check if your browser uses hardware acceleration [here](chrome://gpu).
{% endhint %}

## Getting Started

First, [import](../data-organization/import/import/import.md) the dataset you would like to annotate. You can upload images, videos, and many other types of data from your computer or import one of our [sample projects](https://ecosystem.supervisely.com/import+images+project) from the Ecosystem.

To open the labeling toolbox, go to the [Projects](../data-organization/project/projects.md) page, select one of the projects and click on a dataset. Depending on the type of your project, you will see a popup where you can select the right toolbox or, if there is one, the labeling toolbox will open automatically. 

![](new-toolbox.png)

{% hint style="info" %}
When opening a labeling toolbox, you can only annotate a single dataset at a time.
{% endhint %}

{% hint style="success" %}
You can also open the labeling toolbox from a [Labeling Job](jobs/README.md) or the [Ecosystem](https://ecosystem.supervisely.com/annotation_tools/image-labeling-tool-v2) page.
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
         <td><strong>Images labeling toolbox</strong></td>
         <td>The image labeling toolbox allows you to annotate one image at a time, such as .jpg, .png, .tiff, and many more formats you can import to Supervisely.</td>
         <td><a href="images/README.md">Images labeling toolbox</a></td>
      </tr>
    <tr>
         <td><strong>Multiview images</strong></td>
         <td>Create image groups inside your dataset by assigning a grouping tag.</td>
         <td><a href="<images/Multi-view images/Multi-view-images.md>">Multi-view images</a></td>
    </tr>
    <tr>
         <td><strong>Videos labeling toolbox</strong></td>
         <td>Label hours-long videos without cutting them into images. In your browser, with multi-track timeline, built-in object tracking and segments tagging tools.</td>
         <td><a href="videos/README.md">Videos labeling toolbox</a></td>
    </tr>
    <tr>
         <td><strong>Video tracking</strong></td>
         <td>The most simple and straightforward method of importing is uploading your data using one of our Supervisely Apps.</td>
         <td><a href="videos/video-tracking.md">Video tracking</a></td>
    </tr>
    <tr>
         <td><strong>3D Point Clouds</strong></td>
         <td>Label comprehensive 3D scenes from LiDAR or RADAR sensors with additional photo and video context, AI object tracking and point cloud segmentation.</td>
         <td><a href="3D-Point-Clouds/3D-Point-Clouds.md">3D Point Clouds</a></td>
    </tr>
    <tr>
         <td><strong>3D Point Clouds Episodes</strong></td>
         <td>Our toolbox for 3D Point Cloud labeling is a great solution for annotation a single point cloud at a time.</td>
         <td><a href="3D-Point-Clouds/3D-Point-Clouds-episod.md">3D Point Clouds Episodes</a></td>
    </tr>
    <tr>
         <td><strong>Sensor-fusion</strong></td>
         <td>Additionally to a single point cloud and episodes point clouds toolboxes, Supervisely allows you to provide additional photo and video context for accurate labeling.</td>
         <td><a href="3D-Point-Clouds/Sensor-fusion/Sensor-fusion.md">Sensor-fusion</a></td>
    </tr>
    <tr>
         <td><strong>DICOM</strong></td>
         <td>The most simple and straightforward method of importing is uploading your data using one of our Supervisely Apps.</td>
         <td><a href="DICOM/DICOM.md">DICOM</a></td>
    </tr>
   </tbody>
</table>