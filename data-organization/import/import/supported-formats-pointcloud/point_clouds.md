# Overview

This option allows you to upload point clouds to the platform without any annotations. All items from the input directory and its subdirectories will be uploaded to a single dataset. Supported formats are `.pcd`, `.ply`, `.las`, and `.laz`, and they are imported natively without conversion. If you need to preserve the directory structure, you can use the <a href="https://ecosystem.supervisely.com/apps/import-pointcloud-pcd" target="_blank">Import Pointclouds PCD</a> application from the Supervisely Ecosystem.

# Format description

**Supported point cloud formats:** `.pcd`, `.ply`, `.las`, `.laz`.<br>
**With annotations:** No<br>
**Supported annotation format:** Not applicable.<br>
**Grouped by:** Any structure (will be uploaded to a single dataset).<br>

# Why native LAS/LAZ/PLY import matters

Import Wizard loads `.las`, `.laz`, and `.ply` files natively.

`PCD` is a simpler point cloud format. `LAS` / `LAZ` and many `PLY` variants can store richer source data, so native import helps preserve more of the information already present in your files.

Practical advantages:

- **More source attributes preserved**: `LAS` / `LAZ` can contain intensity, return information, classification, GPS time, and other LiDAR-specific fields. `PLY` can contain RGB, normals, and custom per-point properties. With native import, these attributes do not need to be flattened into a simpler intermediate representation.
- **No data loss from PCD conversion**: when point clouds are converted to `PCD`, some source-specific fields may be dropped, remapped, or normalized depending on the conversion path. Native import avoids that lossy step.
- **Smaller files can speed up the workflow**: some source formats, especially compressed `LAZ`, can be much smaller than converted `PCD`. That reduces upload volume, download volume in the labeling tool, and time spent opening dense scenes.
- **Faster time to first annotation**: skipping conversion removes an entire preprocessing stage before import.
- **Immediate benefit from rendering improvements**: once the data is loaded, the WebGPU pipeline can use preserved attributes such as RGB and Intensity while keeping interaction smooth on dense scenes.

# Input files structure

{% hint style="success" %}
Example data: [download ⬇️](https://github.com/supervisely-ecosystem/import-wizard-docs/files/15025187/sample_pcd.zip)
{% endhint %}

Recommended directory structure:

```text
📦 folder
├── 📄 item_01.pcd
├── 📄 item_02.ply
├── 📄 item_03.las
├── 📄 item_04.laz
├── 📄 item_05.pcd
├── 📄 item_06.ply
├── 📄 item_07.las
├── 📄 item_08.laz
├── 📄 item_09.pcd
└── 📄 item_10.ply
```

# Format LAS/LAZ

In Import Wizard, LAS and LAZ files are supported natively, so no conversion to PCD is required.

## Coordinate handling

In Import Wizard, Supervisely preserves source coordinates as provided in the input file.

Coordinate shift is applicable only when using the <a href="https://ecosystem.supervisely.com/apps/import-las-format" target="_blank">Import LAS format</a> app, where LAS/LAZ files are converted to PCD. This app is optional and is not required for Auto Import Wizard.

Example log entry:

```
Applied coordinate shift for filename: X=1234567.89, Y=9876543.21, Z=123.45
```

# Format PLY

In Import Wizard, PLY files are supported natively, so no conversion is required.

If you use the <a href="http://ecosystem.supervisely.com/apps/import-pointcloud-ply" target="_blank">Import Pointcloud PLY</a> app, files are converted from PLY to PCD during import. This app is optional and is not required for Auto Import Wizard.
  
# Useful links

- <a href="https://ecosystem.supervisely.com/apps/import-pointcloud-pcd" target="_blank">[Supervisely Ecosystem] Import Pointclouds PCD</a>
- <a href="https://ecosystem.supervisely.com/apps/import-las-format" target="_blank">[Supervisely Ecosystem] Import LAS format</a>
- <a href="http://ecosystem.supervisely.com/apps/import-pointcloud-ply" target="_blank">[Supervisely Ecosystem] Import Pointcloud PLY</a>
