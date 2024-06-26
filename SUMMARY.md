# Table of contents

* [🤖 What's Supervisely](README.md)
* [🚀 Ecosystem of Supervisely Apps](ecosystem/ecosystem.md)
* [💡 FAQ](getting-started/faq.md)

## 📌 Getting started

* [How to import](getting-started/How-to-import.md)
* [How to annotate](getting-started/How-to-annotate.md)
* [How to invite team members](getting-started/Invite-member.md)
* [How to train models](getting-started/how-to-train-models.md)

## 🔁 Import and Export

* [Import](data-organization/import/import/import.md)
  * [Overview](data-organization/import/import/import.md)
  * [Import using Web UI](data-organization/import/import/Import-using-Web-UI.md)
  * [Import sample dataset](data-organization/import/import/Import-sample-dataset.md)
  * [Import into an existing dataset](data-organization/import/import/exesting-dataset.md)
  * [Import using Team Files](data-organization/import/import/Import-Team-Files.md)
  * [Import from Cloud](data-organization/import/import/Import-from-Cloud.md)
  * [Import using API & SDK](data-organization/import/import/import-sdk-api.md)
  * [Import using agent](data-organization/import/import/import-using-agent/import-using-agent.md)
* [Migrations](data-organization/import/migration/migrations.md)
  * [Roboflow to Supervisely](data-organization/import/migration/roboflow/migration-roboflow.md)
  * [Labelbox to Supervisely](data-organization/import/migration/labelbox/migration-labelbox.md)
  * [V7 to Supervisely](data-organization/import/migration/v7/migration-v7.md)
  * [CVAT to Supervisely](data-organization/import/migration/CVAT/migration-cvat.md)
* [Export](data-organization/import/export/export.md)

## 📂 Data Organization

* [Core concepts](data-organization/overview.md)
* [Projects](data-organization/project/projects.md)
  * [Datasets](data-organization/project/datasets/datasets.md)
  * [Classes](data-organization/project/classes/classes.md)
  * [Tags](data-organization/project/tags/tags.md)
  * [Statistics](data-organization/project/statistics/statistics.md)
* [Team Files](data-organization/team-files/README.md)
* [Data usage & Cleanup](data-organization/storage/README.md)
* [Operations with Data](data-organization/Operations-with-Data/README.md)
  * [Data Filtration](data-organization/Operations-with-Data/data-filtration.md)
  * [Augmentations](data-organization/Operations-with-Data/Augmentations.md)
  * [Converting & Splitting data](data-organization/Operations-with-Data/Converting-Splitdata.md)
  * [Statistics](data-organization/Operations-with-Data/Statistics.md)
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
* [Labeling with AI-Assistance](labeling/AI-labeling/AI-Labeling.md)

## 🤝 Collaboration

* [Teams & workspaces](collaboration/teams.md)
* [Members](collaboration/members.md)
* [Issues](labeling/issues/README.md)
* [Guides & exams](labeling/exams/README.md)
* [Activity log](collaboration/Activity-Log.md)
* [Sharing](collaboration/sharing.md)

## 🖥️ Agents

* [Installation](getting-started/connect-your-computer/README.md)
  * [Linux](getting-started/connect-your-computer/unix-based/unix-based.md)
  * [Windows](getting-started/connect-your-computer/windows-wsl/windows-wsl.md)
  * [AMI AWS](agents/ami/README.md)
  * [Kubernetes](enterprise/kubernetes/installation.md)
* [How agents work](agents/agent/agent.md)
* [Restart and delete agents](agents/add\_delete\_node/add\_delete\_node.md)
* [Status and monitoring](agents/status\_and\_troubleshooting/status.md)
* [Storage and cleanup](agents/agent-storage/agent-storage.md)
* [Integration with Docker](agents/custom-docker-registry/README.md)

## 🔮 Neural Networks

* [Starting with Neural Networks](neural-networks/overview/overview.md)
* [Train custom Neural Networks](neural-networks/custom-nn/custom-nn.md)
* [Run pre-trained models](neural-networks/pre-trained-models.md)

## 👔 Enterprise Edition

* [Get Supervisely](enterprise-edition/get-supervisely/README.md)
  * [Installation](enterprise/installation/README.md)
  * [Post-installation](enterprise/post-installation/README.md)
  * [Upgrade](enterprise/update/upgrade.md)
  * [License Update](enterprise/updating-the-license/README.md)
* [Kubernetes](enterprise-edition/kubernetes/README.md)
  * [Overview](enterprise/kubernetes/overview.md)
  * [Installation](enterprise/kubernetes/installation.md)
  * [Connect cluster](enterprise/kubernetes/agent.md)
* [Advanced Tuning](enterprise-edition/advanced-tuning/README.md)
  * [HTTPS](enterprise/https/index.md)
  * [Remote Storage](enterprise/s3/README.md)
  * [Single Sign-On (SSO)](enterprise/sso/README.md)
  * [CDN](enterprise/cdn/README.md)
  * [Notifications](enterprise/notifications/README.md)
  * [Moving Instance](enterprise/moving/README.md)
  * [Generating Troubleshoot Archive](enterprise/troubleshoot/generating\_ts\_archive.md)
  * [Storage Cleanup](enterprise/cleanup/README.md)
  * [Private Apps](enterprise/private-apps/README.md)
  * [Data Folder](enterprise/data-folder/README.md)
  * [Firewall](enterprise/firewall/README.md)
  * [HTTP Proxy](enterprise/http-proxy/README.md)
  * [Offline usage](enterprise/offline-usage/README.md)
  * [Multi-disk usage](enterprise/multi-disk/README.md)
  * [Managed Postgres](enterprise/managed-postgres/README.md)

## 🔧 Customization and Integration

* [Supervisely .JSON Format](data-organization/Annotation-JSON-format/00\_ann\_format\_navi.md)
  * [Project Structure](data-organization/Annotation-JSON-format/01\_Project\_Structure\_new.md)
  * [Project Classes and Tags](data-organization/Annotation-JSON-format/02\_Project\_Classes\_And\_Tags.md)
  * [Tags](data-organization/Annotation-JSON-format/03\_Supervisely\_format\_tags.md)
  * [Objects](data-organization/Annotation-JSON-format/04\_Supervisely\_Format\_objects.md)
  * [Individual Image Annotations](data-organization/Annotation-JSON-format/05\_Supervisely\_format\_images.md)
  * [Individual Video Annotations](data-organization/Annotation-JSON-format/06\_Supervisely\_format\_videos.md)
  * [Point Cloud Episodes](data-organization/Annotation-JSON-format/07\_Supervisely\_format\_pointcloud\_episode.md)
  * [Volumes Annotation](data-organization/Annotation-JSON-format/08\_Supervisely\_format\_volume.md)
* [Developer Portal](https://developer.supervisely.com/)
* [SDK](https://supervisely.readthedocs.io/en/latest/sdk\_packages.html)
* [API](https://api.docs.supervisely.com)

## 💡 Resources

* [Changelog](https://app.supervisely.com/changelog)
* [GitHub](https://github.com/supervisely/supervisely)
* [Blog](https://supervisely.com/blog/)
* [Ecosystem](https://ecosystem.supervisely.com/)
