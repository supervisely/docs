# Overview

This option allows you to upload point clouds to the platform without any annotations. All items from the input directory and its subdirectories will be uploaded to a single dataset. If you need to preserve the directory structure, you can use the <a href="https://ecosystem.supervisely.com/apps/import-pointcloud-pcd" target="_blank">Import Pointclouds PCD</a> application from the Supervisely Ecosystem.

# Format description

**Supported image formats:** `.pcd`, `.ply`, `.las`, `.laz`.<br>
**With annotations:** No<br>
**Supported annotation format:** Not applicable.<br>
**Grouped by:** Any structure (will be uploaded to a single dataset).<br>

# Input files structure

{% hint style="success" %}
Example data: [download ⬇️](https://github.com/supervisely-ecosystem/import-wizard-docs/files/15025187/sample_pcd.zip)<br>
{% endhint %}

Recommended directory structure:

```text
📦folder
┣ 📦item_01.pcd
┣ 📦item_02.pcd
┣ 📦item_03.pcd
┣ 📦item_04.pcd
┣ 📦item_05.pcd
┣ 📦item_06.pcd
┣ 📦item_07.pcd
┣ 📦item_08.pcd
┣ 📦item_09.pcd
┗ 📦item_10.pcd
```

# Useful links

- <a href="https://ecosystem.supervisely.com/apps/import-pointcloud-pcd" target="_blank">[Supervisely Ecosystem] Import Pointclouds PCD</a>
