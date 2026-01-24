# Overview

This option allows you to upload point clouds to the platform without any annotations. All items from the input directory and its subdirectories will be uploaded to a single dataset. If you need to preserve the directory structure, you can use the <a href="https://ecosystem.supervisely.com/apps/import-pointcloud-pcd" target="_blank">Import Pointclouds PCD</a> application from the Supervisely Ecosystem.

# Format description

**Supported point cloud formats:** `.pcd`, `.ply`, `.las`, `.laz`.<br>
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

# Format LAS/LAZ 

During import, LAS and LAZ files are automatically converted to PCD (Point Cloud Data) format.

## ⚠️ Important: Coordinate Shift

During LAS/LAZ to PCD conversion, **coordinate shift is automatically applied** to all point clouds. This is necessary to:

- Avoid floating-point precision issues with large geodetic coordinates
- Prevent visual artifacts and rendering problems
- Ensure proper visualization in point cloud viewers

The shift values (X, Y, Z offsets) are **logged for each converted file**. Look for messages like:

```
Applied coordinate shift for filename: X=1234567.89, Y=9876543.21, Z=123.45
```

**If you need to use annotations with original LAS files or convert back to LAS format:**

- Save the shift values from the logs
- Add these shift values back to your PCD/annotation coordinates to restore original geodetic coordinates:
  ```
  original_x = pcd_x + shift_x
  original_y = pcd_y + shift_y
  original_z = pcd_z + shift_z
  ```
  
# Useful links

- <a href="https://ecosystem.supervisely.com/apps/import-pointcloud-pcd" target="_blank">[Supervisely Ecosystem] Import Pointclouds PCD</a>
