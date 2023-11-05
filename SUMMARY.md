# Table of contents
* [🤖 What's Supervisely](README.md)
* [🚀 Ecosystem of Supervisely Apps](ecosystem/ecosystem.md)
* [💡 FAQ](getting-started/faq.md)

## 📌 Getting started
* [How to import](getting-started/How-to-import.md)
* [How to annotate](getting-started/How-to-annotate.md)
* [How to invite team members](getting-started/Invite-member.md)
* [How to connect agents](getting-started/connect-your-computer/README.md)
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

* [Overview](data-organization/overview.md)
* [Projects](data-organization/project/projects.md)
    * [Datasets](data-organization/project/datasets/datasets.md)
    * [Classes](data-organization/project/classes/classes.md)
    * [Tags](data-organization/project/tags/tags.md)
    * [Statistics](data-organization/project/statistics/statistics.md)
* [Import](data-organization/import/import/import.md)
  * [Import using Web UI](data-organization/import/import/Import-using-Web-UI.md)
  * [Import sample dataset](data-organization/import/import/Import-sample-dataset.md)
  * [Import into an existing dataset](data-organization/import/import/exesting-dataset.md)
  * [Import using Team Files](data-organization/import/import/Import-Team-Files.md)
  * [Import from Cloud](data-organization/import/import/Import-from-Cloud.md)
  * [Import using API & SDK](data-organization/import/import/import-sdk-api.md)
* [Export](data-organization/import/export/export.md)
* [Team Files](data-organization/team-files/README.md)
* [Data usage & Cleanup](data-organization/storage/README.md)
* [Operations with Data](/data-organization/Operations-with-Data/README.md)
  * [Data Filtration](/data-organization/Operations-with-Data/data-filtration.md)
  * [Augmentations](/data-organization/Operations-with-Data/Augmentations.md)
  * [Converting & Splitting data](/data-organization/Operations-with-Data/Converting-Splitdata.md)
  * [Statistics](/data-organization/Operations-with-Data/Statistics.md)
* [Data Commander](data-organization/data-commander/README.md)
    * [Clone Project Meta](data-organization/data-commander/clone-meta.md)

## 📝 Labeling

* [Labeling Toolboxes](labeling/Labeling-toolbox.md)
  * [Images](labeling/images/README.md)
  * [Multi-view images](<labeling/images/Multi-view images/Multi-view-images.md>)
  * [Videos](labeling/videos/README.md)
  * [Video tracking](labeling/videos/video-tracking.md)
  * [3D Point Clouds](labeling/3D-Point-Clouds/3D-Point-Clouds.md)
  * [3D Point Clouds Episodes](labeling/3D-Point-Clouds/3D-Point-Clouds-episod.md)
  * [Sensor-fusion](labeling/3D-Point-Clouds/Sensor-fusion/Sensor-fusion.md)
  * [DICOM](labeling/DICOM/DICOM.md)
* [Labeling Jobs](labeling/jobs/README.md)
  * [Labeling Queues](labeling/jobs/Labeling-Queues.md)
  * [Labeling Consensus](labeling/jobs/Labeling-Consensus.md)
  * [Labeling Statistics](labeling/jobs/Labeling-Statistics.md)

## 🤝 Collaboration

* [Teams & Workspaces](collaboration/teams.md)
* [Members](collaboration/members.md)
* [Issues](labeling/issues/README.md)
* [Guides & Exams](labeling/exams/README.md)
* [Activity Log](collaboration/Activity-Log.md)
* [Sharing](collaboration/sharing.md)

## 🔮 Neural Networks

* [Overview](neural-networks/overview/overview.md)
* [Train custom Neural Networks](neural-networks/custom-nn/custom-nn.md)
* [Run pre-trained models](neural-networks/pre-trained-models.md)

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
    * [Offline usage](enterprise/offline-usage/README.md)
    * [Multi-disk usage](enterprise/multi-disk/README.md)

## 🔧 Customization and Integration 

* [Supervisely .JSON Format](data-organization/Annotation-JSON-format/00_ann_format_navi.md)
    * [Project Structure](data-organization/Annotation-JSON-format/01_Project_Structure_new.md)
    * [Project Classes and Tags](data-organization/Annotation-JSON-format/Project_Classes_And_Tags.md)
    * [Tags](data-organization/Annotation-JSON-format/Supervisely_format_tags.md)
    * [Objects](data-organization/Annotation-JSON-format/Supervisely_Format_objects.md)
    * [Individual Image Annotations](data-organization/Annotation-JSON-format/Supervisely_format_images.md)
    * [Individual Video Annotations](data-organization/Annotation-JSON-format/06_Supervisely_format_videos.md)
    * [Point Cloud Episodes](data-organization/Annotation-JSON-format/07_Supervisely_format_pointcloud_episode.md)
    * [Volumes Annotation](data-organization/Annotation-JSON-format/08_Supervisely_format_volume.md)
* [Developer Portal](https://developer.supervisely.com/)
* [SDK](https://supervisely.readthedocs.io/en/latest/sdk_packages.html)
* [API](https://api.docs.supervisely.com)
  
## 💡 Resources

* [Changelog](https://app.supervisely.com/changelog)
* [GitHub](https://github.com/supervisely/supervisely)
* [Blog](https://supervisely.com/blog/)
