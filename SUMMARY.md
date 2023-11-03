# Table of contents
## 📌 Introduction
* [🤖 What's Supervisely](README.md)
* Ecosystem of Supervisely Apps

## 📌 Getting started
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

* [Overview](data-organization/overview.md)
* [Projects](data-organization/project/projects.md)
    * [Datasets](data-organization/project/datasets/datasets.md)
    * [Classes](data-organization/project/classes/classes.md)
    * [Tags](data-organization/project/tags/tags.md)
    * [Statistics](data-organization/project/statistics/statistics.md)
    * [Info](data-organization/project/info/info.md)



* [Import & Export](data-organization/import/import.md)
    * [import](data-organization/import/import/import.md)
      * [Import using Web UI](data-organization/import/import/Import-using-Web-UI.md)
        * [Add pictures to an existing dataset or project]()
      * [Import using Team Files]()
      * [Import from Cloud](data-organization/import/import/Import-from-Cloud.md)
      * [Import using API & SDK](data-organization/import/import-sdk-api.md)
      * [Import sample dataset]()



  * [Export](data-organization/import/export/export.md)
    * [Export via SDK/API](data-organization/import/export/export-sdk.md)
    * [Export Applications](data-organization/import/export/export-apps.md)
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

* Labeling Toolboxes 
  * [Images](labeling/images/README.md)
    * [Multi-view images](<labeling/images/Multi-view images/Multi-view images.md>)
  * [Videos](labeling/videos/README.md)
    * [Video tracking](labeling/videos/video-tracking.md)
  * [3D Point Clouds](labeling/3D-Point-Clouds/3D-Point-Clouds.md)
    * [3D Point Clouds Episodes](labeling/3D-Point-Clouds/3D-Point-Clouds-episod.md)
    * [Sensor-fusion](labeling/3D-Point-Clouds/Sensor-fusion/Sensor-fusion.md)
  * [DICOM](labeling/DICOM/DICOM.md)
* [AI Labeling with Supervisely Apps](labeling/AI-Labeling.md)
  *  [Smart Tool](labeling/images/smart-tool-apps/README.md)
* [Custom UIs](labeling/Coustom-UI.md)

## 🤝 Collaboration

* [Teams & Workspaces](collaboration/teams.md)
* [Members](collaboration/members.md)
* [Labeling Jobs](labeling/jobs/README.md)
  * [Labeling Queues](labeling/jobs/Labeling-Queues.md)
  * [Labeling Consensus](labeling/jobs/Labeling-Consensus.md)
  * [Labeling Statistics](labeling/jobs/Labeling-Statistics.md)
* [Issues](labeling/issues/README.md)
* [Guides & Exams](labeling/exams/README.md)
* [Activity Log](collaboration/Activity-Log.md)
* [Sharing](collaboration/sharing.md)



## 🔮 Neural Networks

* Overview


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

* [Developer Portal](https://developer.supervisely.com/)
* [Supervisely .JSON Format](data-organization/Annotation-JSON-format/00_ann_format_navi.md)
    * [Project Structure](data-organization/Annotation-JSON-format/01_Project_Structure_new.md)
    * [Project Classes and Tags](data-organization/Annotation-JSON-format/Project_Classes_And_Tags.md)
    * [Tags](data-organization/Annotation-JSON-format/Supervisely_format_tags.md)
    * [Objects](data-organization/Annotation-JSON-format/Supervisely_Format_objects.md)
    * [Individual Image Annotations](data-organization/Annotation-JSON-format/Supervisely_format_images.md)
    * [Individual Video Annotations](data-organization/Annotation-JSON-format/06_Supervisely_format_videos.md)
    * [Point Cloud Episodes](data-organization/Annotation-JSON-format/07_Supervisely_format_pointcloud_episode.md)
    * [Volumes Annotation](data-organization/Annotation-JSON-format/08_Supervisely_format_volume.md)
* [SDK](https://supervisely.readthedocs.io/en/latest/sdk_packages.html)
* [API](https://api.docs.supervisely.com)
  
## 💡 Resources

* [Changelog](https://app.supervisely.com/changelog)
* [GitHub](https://github.com/supervisely/supervisely)
* [Developer Portal](https://developer.supervisely.com)
* [Blog](https://medium.com/@supervisely)
