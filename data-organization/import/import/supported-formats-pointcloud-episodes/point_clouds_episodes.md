# Overview

This option allows you to upload point clouds as episodes to the platform without any annotations. All items from the input directory and its subdirectories will be uploaded to a single dataset. If you need to preserve the directory structure, you can use the <a href="https://ecosystem.supervisely.com/apps/import-pointcloud-episode" target="_blank">Import Pointcloud Episodes</a> application from the Supervisely Ecosystem.

# Format description

**Supported image formats:** `.pcd`.<br>
**With annotations:** No<br>
**Supported annotation format:** Not applicable.<br>
**Grouped by:** Any structure (will be uploaded to a single dataset).<br>

# Input files structure

{% hint style="success" %}
Example data: [download ⬇️](https://github.com/supervisely-ecosystem/import-wizard-docs/files/15025197/sample_pcde.zip)
Example data with related images: [download ⬇️](https://github.com/supervisely-ecosystem/import-wizard-docs/files/15025207/sample_pcde_w_rimg.zip)
{% endhint %}

<br>

Recommended directory structure:

```text
📦folder (with related images)          📦folder
 ┣ 📂pointcloud                          ┣ 📂pointcloud
 ┃ ┣ 📦0000000000.pcd                    ┃ ┣ 📦0000000000.pcd
 ┃ ┣ 📦0000000001.pcd                    ┃ ┣ 📦0000000001.pcd
 ┃ ┗ 📦0000000002.pcd                    ┃ ┗ 📦0000000002.pcd
 ┣ 📂related_images                      ┗ 📜frame_pointcloud_map.json
 ┃ ┣ 📂0000000000_pcd
 ┃ ┃ ┣ 🖼️0000000000.png
 ┃ ┃ ┗ 📜0000000000.png.json
 ┃ ┣ 📂0000000001_pcd
 ┃ ┃ ┣ 🖼️0000000001.png
 ┃ ┃ ┗ 📜0000000001.png.json
 ┃ ┣ 📂0000000002_pcd
 ┃ ┃ ┣ 🖼️0000000002.png
 ┃ ┃ ┗ 📜0000000002.png.json
 ┗ 📜frame_pointcloud_map.json                   
```

Frames mapping file structure:

<details>
<summary>📜frame_pointcloud_map.json</summary>

```json
{
    "0": "0000000000.pcd",
    "1": "0000000001.pcd",
    "2": "0000000002.pcd"
}
```
</details>


# Useful links

- <a href="https://ecosystem.supervisely.com/apps/import-pointcloud-episode" target="_blank">[Supervisely Ecosystem] Import Pointcloud Episodes</a>
