# Overview

This option allows you to upload point clouds as episodes to the platform without any annotations. All items from the input directory and its subdirectories will be uploaded to a single dataset. Supported formats are `.pcd`, `.ply`, `.las`, and `.laz`, and they are imported natively without conversion. If you need to preserve the directory structure, you can use the <a href="https://ecosystem.supervisely.com/apps/import-pointcloud-episode" target="_blank">Import Pointcloud Episodes</a> application from the Supervisely Ecosystem.

# Format description

**Supported point cloud episode formats:** `.pcd`, `.ply`, `.las`, `.laz`.<br>
**With annotations:** No<br>
**Supported annotation format:** Not applicable.<br>
**Grouped by:** Any structure (will be uploaded to a single dataset).<br>

# Why native LAS/LAZ/PLY import matters

For point cloud episodes, Import Wizard loads `.las`, `.laz`, and `.ply` frames natively.

`PCD` is a simpler point cloud format. `LAS` / `LAZ` and many `PLY` variants can keep more useful source information per frame, so native import helps preserve the original sequence data.

Practical advantages for multi-frame projects:

- **More source attributes preserved across the sequence**: `LAS` / `LAZ` can keep LiDAR-specific fields such as intensity, return information, and classification. `PLY` can keep RGB, normals, and custom properties. Native import avoids simplifying those frames through an intermediate conversion step.
- **No conversion-related data loss**: when episodes are converted to `PCD`, source-specific fields may be lost or reduced. Native import keeps the original frame content intact.
- **Smaller files can improve sequence loading**: formats such as `LAZ` can be significantly smaller than converted `PCD`, which reduces transfer size and helps large multi-frame projects open faster.
- **Faster project startup**: there is no pre-conversion pipeline before frame mapping and sequence upload.
- **Immediate benefit from WebGPU rendering upgrades**: preserved attributes and dense frames can be rendered directly in the optimized pipeline, which is designed for large scenes and high point counts.

# Input files structure

{% hint style="success" %}
Example data: [download ⬇️](https://github.com/supervisely-ecosystem/import-wizard-docs/files/15025197/sample_pcde.zip)
Example data with related images: [download ⬇️](https://github.com/supervisely-ecosystem/import-wizard-docs/files/15025207/sample_pcde_w_rimg.zip)

{% endhint %}

Recommended directory structure:

```text
📦 folder (with related images)          📦 folder
├── 📂 pointcloud                          ├── 📂 pointcloud
│   ├── 📄 0000000000.pcd                  │   ├── 📄 0000000000.pcd
│   ├── 📄 0000000001.ply                  │   ├── 📄 0000000001.ply
│   ├── 📄 0000000002.las                  │   ├── 📄 0000000002.las
│   └── 📄 0000000003.laz                  │   └── 📄 0000000003.laz
├── 📂 related_images                      └── 📜 frame_pointcloud_map.json
│   ├── 📂 0000000000_pcd
│   │   ├── 🖼️ 0000000000.png
│   │   └── 📜 0000000000.png.json
│   ├── 📂 0000000001_ply
│   │   ├── 🖼️ 0000000001.png
│   │   └── 📜 0000000001.png.json
│   ├── 📂 0000000002_las
│   │   ├── 🖼️ 0000000002.png
│   │   └── 📜 0000000002.png.json
│   ├── 📂 0000000003_laz
│   │   ├── 🖼️ 0000000003.png
│   │   └── 📜 0000000003.png.json
└── 📜 frame_pointcloud_map.json                   
```

Frames mapping file structure:

<details>
<summary>📜 frame_pointcloud_map.json</summary>

```json
{
    "0": "0000000000.pcd",
    "1": "0000000001.ply",
    "2": "0000000002.las",
    "3": "0000000003.laz"
}
```
</details>

# Format LAS/LAZ/PLY

In Import Wizard, LAS/LAZ/PLY files are imported natively without conversion.

# Useful links

- <a href="https://ecosystem.supervisely.com/apps/import-pointcloud-episode" target="_blank">[Supervisely Ecosystem] Import Pointcloud Episodes</a>
