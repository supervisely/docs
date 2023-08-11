# Table of contents

* [🤖 What's Supervisely](README.md)

## 📌 Getting started

* [First Steps](getting-started/first-steps.md)
* [FAQ](getting-started/faq.md)
* [Support](getting-started/support.md)
* [Connect your computer](getting-started/connect-your-computer/README.md)
  * [Unix-based](getting-started/connect-your-computer/unix-based/unix-based.md)
  * [Windows WSL](getting-started/connect-your-computer/windows-wsl/windows-wsl.md)
  * [Agents](getting-started/connect-your-computer/agents/README.md)
      * [Agent](getting-started/connect-your-computer/agents/agent/agent.md)
      * [Add / Restart / Delete agent](getting-started/connect-your-computer/agents/add_delete_node/add_delete_node.md)
      * [Agent Status & Troubleshoot Guide](getting-started/connect-your-computer/agents/status_and_troubleshooting/status.md)
      * [Node monitoring](getting-started/connect-your-computer/agents/manage/manage.md)
      * [Agent Storage](getting-started/connect-your-computer/agents/agent-storage/agent-storage.md)
      * [AMI (Amazon)](getting-started/connect-your-computer/agents/ami/README.md)
      * [Clean Up](getting-started/connect-your-computer/agents/clean_up/clean_up.md)
      * [Add docker registry](getting-started/connect-your-computer/agents/custom-docker-registry/README.md)

## 📂 Data Organization

* [Core Concepts](data-organization/core-concepts.md)
* [Projects](data-organization/projects.md)
    * [Datasets](data-organization/datasets.md)
    * [Classes](data-organization/classes.md)
    * [Tags](data-organization/tags.md)
* [Import & Export](data-organization/import-export.md)
    * [Import via Browser](data-organization/import/upload/README.md)
    * [Import via Agent](data-organization/import/agent/README.md)
    * [Import via Links](data-organization/import/links/README.md)
    * Supported Formats
        * [Images](data-organization/import/formats/images.md)
        * [Supervisely](data-organization/import/formats/supervisely.md)
        * [Cityscapes](data-organization/import/formats/cityscapes.md)
        * [Mapillary](data-organization/import/formats/mapillary.md)
        * [Pascal VOC](data-organization/import/formats/pascal_voc.md)
        * [KITTI SemSeg](data-organization/import/formats/kitti_semseg.md)
        * [Videos](data-organization/import/formats/videos.md)
* [Supervisely Format](data-organization/Annotation-JSON-format/00_ann_format_navi.md)
    * [Project Structure](data-organization/Annotation-JSON-format/01_Project_Structure_new.md)
    * [Project Classes and Tags](data-organization/Annotation-JSON-format/02_Project_Classes_And_Tags.md)
    * [Tags](data-organization/Annotation-JSON-format/03_Supervisely_format_tags.md)
    * [Objects](data-organization/Annotation-JSON-format/04_Supervisely_Format_objects.md)
    * [Individual Image Annotations](data-organization/Annotation-JSON-format/05_Supervisely_format_images.md)
    * [Individual Video Annotations](data-organization/Annotation-JSON-format/06_Supervisely_format_videos.md)
    * [Point Cloud Episodes](data-organization/Annotation-JSON-format/07_Supervisely_format_pointcloud_episode.md)
    * [Volumes Annotation](data-organization/Annotation-JSON-format/08_Supervisely_format_volume.md)
* [Storage](data-organization/storage/README.md)

## 📝 Labeling

* Editors
  * [Images](labeling/images/README.md)
    * [Navigation](labeling/images/navigation.md)
    * [Scene](labeling/images/scene.md)
    * [Images](labeling/images/images.md)
    * [Figures](labeling/images/figures.md)
    * [Instruments](labeling/images/instruments.md)
    * [History](labeling/images/history.md)
    * [Smart Tool](labeling/images/smart-tool/README.md)
    * [Smart Tool Apps](labeling/images/smart-tool-apps/README.md)
  * [Videos](labeling/videos/README.md)
  * [Point Clouds](labeling/point-clouds/README.md)
* [Jobs](labeling/jobs/README.md)
* [Issues](labeling/issues/README.md)
* [Guides & Exams](labeling/exams/README.md)

## 🤝 Collaboration

* [Teams & Workspaces](collaboration/teams.md)
* [Members](collaboration/members.md)
* [Sharing](collaboration/sharing.md)

## ⚙ Data Manipulation

* [Python Scripts](data-manipulation/python-scripts.md)
* [Data Commander](data-manipulation/data-commander/README.md)
    * [Clone Project Meta](data-manipulation/data-commander/clone-meta.md)
* [DTL](data-manipulation/dtl/index.md)
    * Data layers
      * [Data](data-manipulation/dtl/data.md)
    * Transformation layers
      * [Approx Vector](data-manipulation/dtl/approx_vector.md)
      * [Background](data-manipulation/dtl/background.md)
      * [BBox to Polygon](data-manipulation/dtl/bbox2poly.md)
      * [Bitmap to Lines](data-manipulation/dtl/bitmap2lines.md)
      * [Bitwise Masks](data-manipulation/dtl/bitwise_masks.md)
      * [Blur](data-manipulation/dtl/blur.md)
      * [Bounding Box](data-manipulation/dtl/bbox.md)
      * [Color Class](data-manipulation/dtl/color_class.md)
      * [Contrast / Brightness](data-manipulation/dtl/contrast_brightness.md)
      * [Crop](data-manipulation/dtl/crop.md)
      * [Dataset](data-manipulation/dtl/dataset.md)
      * [Drop by Class](data-manipulation/dtl/drop_obj_by_class.md)
      * [Drop Lines by Length](data-manipulation/dtl/drop_lines_by_length.md)
      * [Drop Noise](data-manipulation/dtl/drop_noise_from_bitmap.md)
      * [Dummy](data-manipulation/dtl/dummy.md)
      * [Duplicate Objects](data-manipulation/dtl/duplicate_objects.md)
      * [Find Contours](data-manipulation/dtl/find_contours.md)
      * [Flip](data-manipulation/dtl/flip.md)
      * [If](data-manipulation/dtl/if.md)
      * [Instances Crop](data-manipulation/dtl/instances_crop.md)
      * [Line to Bitmap](data-manipulation/dtl/line2bitmap.md)
      * [Merge Masks](data-manipulation/dtl/merge_masks.md)
      * [Multiply](data-manipulation/dtl/multiply.md)
      * [Noise](data-manipulation/dtl/noise.md)
      * [Objects Filter](data-manipulation/dtl/objects_filter.md)
      * [Polygon to Bitmap](data-manipulation/dtl/poly2bitmap.md)
      * [Random Color](data-manipulation/dtl/random_color.md)
      * [Rasterize](data-manipulation/dtl/rasterize.md)
      * [Rename](data-manipulation/dtl/rename.md)
      * [Resize](data-manipulation/dtl/resize.md)
      * [Rotate](data-manipulation/dtl/rotate.md)
      * [Skeletonize](data-manipulation/dtl/skeletonize.md)
      * [Sliding Window](data-manipulation/dtl/sliding_window.md)
      * [Split Masks](data-manipulation/dtl/split_masks.md)
      * [Tag](data-manipulation/dtl/tag.md)
    * Save layers
      * [Save](data-manipulation/dtl/save.md)
      * [Save Masks](data-manipulation/dtl/save_masks.md)
      * [Supervisely](data-manipulation/dtl/supervisely.md)
    * Examples / Use cases
      * [Merge datasets](data-manipulation/dtl/examples/merge_datasets/merge_datasets.md)
      * [Split datasets](data-manipulation/dtl/examples/split_datasets/split_datasets.md)
      * [Resize images](data-manipulation/dtl/examples/resize/resize.md)
      * Drop classes
        * [Simple case](data-manipulation/dtl/examples/drop-classes-simple/drop-classes-simple.md)
        * [Complex case](data-manipulation/dtl/examples/drop-classes-complex/drop-classes-complex.md)
      * [Download filtered data](data-manipulation/dtl/examples/download-filter/download-filter.md)
      * [Vectorize bitmap](data-manipulation/dtl/examples/vectorize-bitmap/index.md)

## 🔮 Neural Networks

* [Basics](neural-networks/overview/overview.md)
    * [Supported NNs](neural-networks/supported_nns.md)
    * [Model Zoo](neural-networks/model-zoo/model-zoo.md)
    * [My Models](neural-networks/my-models/my-models.md)
    * [Checkpoints](neural-networks/checkpoints.md)
    * [NN lifecycle](neural-networks/nn-lifecycle/nn-lifecycle.md)
    * [Training](neural-networks/training/training.md)
    * [Inference](neural-networks/inference/inference.md)
    * [Cleanup Unused Weights](neural-networks/cleanup-unused-weights/README.md)
* [Configurations](neural-networks/configs/overview.md)
  * [Training](neural-networks/configs/train_config.md)
  * [Inference](neural-networks/configs/inference_config.md)
* Examples
  * Train NN on your data
    * [UNet (Vessels)](neural-networks/examples/unet.md)
    * [UNet (Lemon)](neural-networks/examples/unet_lemon.md)
    * [Deeplab](neural-networks/examples/deeplab.md)
    * [Mask R-CNN](neural-networks/examples/mask_rcnn.md)
    * [YOLO V3](neural-networks/examples/yolo_v3/index.md)
  * Use NN from Model Zoo
    * [Mask R-CNN](neural-networks/examples/mrcnn-model-zoo/mrcnn-model-zoo.md)
    * [Faster R-CNN](neural-networks/inference_xxx/faster.md)
* [Smart Tool](neural-networks/examples/smarttool.md)

## 🔧 Customization

* [Developer Portal](https://developer.supervisely.com/)
* [Plugins](customization/plugins/README.md)
  * [Plugin updates and versions](customization/plugins/versions.md)
* [SDK](https://supervisely.readthedocs.io/en/latest/sdk_packages.html)
* [API](https://api.docs.supervisely.com)

## 👔 Enterprise Edition

* Get Supervisely
    * [Installation](enterprise/installation/README.md)
    * [Post-installation](enterprise/post-installation/README.md)
    * [Upgrade](enterprise/update/upgrade.md)
    * [License Update](enterprise/updating-the-license/README.md)
* Kubernetes
    * [Overview](enterprise/kubernetes/overview.md)
    * [Installation](enterprise/kubernetes/installation.md)
    * [Connect cluster](enterprise/kubernetes/agent.md)
* Advanced Tuning
    * [HTTPS](enterprise/https/index.md)
    * [Remote Storage](enterprise/s3/README.md)
    * [External Authorization](enterprise/auth/index.md)
    * [CDN](enterprise/cdn/README.md)
    * [Notifications](enterprise/notifications/README.md)
    * [Moving Instance](enterprise/moving/README.md)
    * [Generating Troubleshoot Archive](enterprise/troubleshoot/generating_ts_archive.md)
    * [Storage Cleanup](enterprise/cleanup/README.md)
    * [Private Apps](enterprise/private-apps/README.md)
    * [Data Folder](enterprise/data-folder/README.md)
    * [Firewall](enterprise/firewall/README.md)
    * [HTTP Proxy](enterprise/http-proxy/README.md)

## 💡 Resources

* Use Cases
    * [Fast person detection](use-cases/fast-person-detection/fast-person-detection.md)
    * [Automatic roads segmentation](use-cases/auto-roads-segm/auto-roads-segm.md)
    * [NNs and irregular image size](use-cases/irregular-image-size/irregular-image-size.md)
    * [How to use neutral class](use-cases/neutral-class/neutral-class.md)
    * [Satellite imagery](use-cases/satellite-imagery/satellite-imagery.md)
    * [Find instances by segmenting object boundaries](use-cases/instance-boundary/instance-boundary.md)
    * [How drones analyse power lines](use-cases/powerlines/powerlines.md)
* [Changelog](https://app.supervisely.com/changelog)
* [GitHub](https://github.com/supervisely/supervisely)
* [Developer Portal](https://developer.supervisely.com)
* [Blog](https://medium.com/@supervisely)
