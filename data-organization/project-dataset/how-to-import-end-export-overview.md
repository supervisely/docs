---
description: >-
  This article gives a quick overview of how and where to import or export data in Supervisely, including supported formats, cloud options, and useful tools to get started.
---

# How to import & export

Importing and exporting your data is a key part of working with Supervisely Projects and Datasets. Whether you're just starting a new project or preparing to share results — we’ve made these actions easy, flexible, and powerful.

This page gives you a quick overview of how to import data into Supervisely and how to export your work out — with links to detailed guides for each case.

## Import: how to get data into Supervisely

There are many ways to bring data into Supervisely — from uploading files manually to syncing with cloud storage. Here's the basic flow:

### 1. Where to click

You can start importing from multiple places:

- Context menu of a project or dataset  
- Web UI via Import Apps  
- Team Files (select a folder → right click → Import App)  
- Ecosystem: go to [Import Apps](https://ecosystem.supervisely.com/import)  
- Or use the API / SDK for programmatic imports

You’ll always be able to choose the format and destination dataset.

### 2. What can be imported

Supervisely supports all popular formats and data types:

- Images and annotations (bounding boxes, masks, polygons, keypoints, etc.)
- Videos
- 3D point clouds with context images
- Ready-made datasets (COCO, Cityscapes, VOC, YOLO, etc.)

Check our [Import Apps](https://ecosystem.supervisely.com/import) — there’s probably one for your format. No need to convert manually — Supervisely handles that for you.

---

### 3. Import by link or sync with the cloud

Don’t want to upload gigabytes of data?

You can link files directly from the cloud:

- Use "Import from Cloud" apps to add images/videos by URL (e.g. `https://...` or `s3://...`)
- Supervisely will fetch the files on-the-fly — no need to upload content
- This is perfect for huge datasets or managing storage yourself

Explore how to [Import from Cloud](../import/Import-from-Cloud.md) and use hybrid storage strategies.

## Export: how to get data out of Supervisely

At any point, you can export your annotated projects and datasets to use them elsewhere or create backups.

### 1. Where to click

You can start export:

- From the three-dot menu of a project or dataset → Download
- From the [Ecosystem](https://ecosystem.supervisely.com/export): pick any export app
- Or via SDK / API for full control

### 2. Export formats supported

You can export to many popular formats using built-in or external apps:

- [Supervisely Format](../../supervisely-format.md) — recommended for full fidelity
- [COCO](https://ecosystem.supervisely.com/apps/export-to-coco)  
- [Pascal VOC](https://ecosystem.supervisely.com/apps/export-to-pascal-voc)  
- [YOLOv8](https://ecosystem.supervisely.com/apps/export-to-yolov8)  
- [Cityscapes](https://ecosystem.supervisely.com/apps/export-to-cityscapes)  
- CSV summaries, DOTA, and more

You can also [export subsets only](https://ecosystem.supervisely.com/apps/export-only-labeled-items), like just labeled items.

---

### 3. Export to cloud

No need to download huge archives manually — Supervisely can export your data directly to cloud storage:

- [Export to S3, GCS, Azure](https://ecosystem.supervisely.com/apps/export-project-to-cloud-storage)
- Configurable via interactive UI
- Works with Supervisely format and other types

### 4. For developers: SDK & API

Want more control?

- Use the [Python SDK](https://supervisely.readthedocs.io/en/latest/sdk_packages.html) to convert to COCO, VOC, YOLO, etc.
- Automate with the [API](https://api.docs.supervisely.com/) for bulk operations or custom tools

Example:

```python
sly.Project.download(api, project_id, "./sly_project")

# Convert to COCO
sly.convert.project_to_coco("./sly_project", "./result_coco")