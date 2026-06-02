# Overview

Import point clouds stored in PCD files with semantic segmentation labels stored as a per-point field.

This format is intended for PCD files where every point can have a numeric class identifier. Class names are not stored in the PCD file itself, so a `class_mapping.json` file is required. During import, mapped label IDs are converted to Supervisely point cloud segmentation annotations. Label IDs that are not present in `class_mapping.json` are ignored.

# Format description

**Supported point cloud format:** `.pcd`<br>
**With annotations:** yes<br>
**Supported annotation source:** `classification`, `label`, or `labels` field inside each `.pcd` file<br>
**Required mapping file:** `class_mapping.json`<br>
**Photo context:** not supported<br>
**Data structure:** Information is provided below.

# Input files structure

Example data: [download ⬇️](https://github.com/user-attachments/files/28470515/pcd_semantic_labels_demo.zip).

Both directory and archive are supported.

Recommended directory structure:

```text
📦pcd_with_labels (folder or .tar/.zip archive)
├──📄class_mapping.json
├──📄scene_01.pcd
├──📄scene_02.pcd
├──📄scene_03.pcd
└──📄...
```

Nested directories are supported. The project must contain exactly one `class_mapping.json` file.

# PCD requirements

Each PCD file must contain one semantic label field. The converter checks the following field names in priority order:

- `classification`
- `label`
- `labels`

If none of these fields are present, the PCD file is uploaded without annotation. If more than one of these fields is present in the same PCD file, the converter uses the first available field by this priority order.

Example PCD header:

```text
# .PCD v0.7 - Point Cloud Data file format
VERSION 0.7
FIELDS x y z labels scan_idx timestamp intensity
SIZE 4 4 4 1 4 8 1
TYPE F F F U I I U
COUNT 1 1 1 1 1 1 1
WIDTH 324681
HEIGHT 1
VIEWPOINT 0 0 0 1 0 0 0
POINTS 324681
DATA binary
```

The semantic label field must contain one scalar numeric value per point. Its `COUNT` must be `1`. If the PCD header does not contain a `COUNT` line, all fields are treated as having `COUNT 1` according to the PCD format.

The converter supports PCD `DATA ascii` and `DATA binary`.

# Class mapping

The `class_mapping.json` file must be a flat JSON object. Keys are label IDs, and values are Supervisely class names.

Example:

```json
{
  "1": "person",
  "2": "Ground",
  "3-10": "car"
}
```

Keys can be:

- A concrete label ID, for example `"2"`.
- An inclusive range, for example `"3-10"`.

Values must be non-empty strings.

The example above is interpreted as:

```json
{
  "1": "person",
  "2": "Ground",
  "3": "car",
  "4": "car",
  "5": "car",
  "6": "car",
  "7": "car",
  "8": "car",
  "9": "car",
  "10": "car"
}
```

Overlapping keys are not allowed. For example, the following mapping is invalid because label ID `2` is defined twice:

```json
{
  "2": "Ground",
  "1-3": "car"
}
```

# Conversion behavior

For each PCD file, the converter reads the semantic label value of every point and groups point indices by class name from `class_mapping.json`.

Each mapped class becomes a Supervisely object class with `point_cloud` geometry. Each group of point indices becomes one Supervisely figure:

```json
{
  "geometryType": "point_cloud",
  "geometry": {
    "indices": [5, 7, 17, 28]
  }
}
```

Unmapped label IDs are ignored and do not create classes, objects, or figures. If a PCD file has no semantic label field or none of its label values are present in `class_mapping.json`, that file is uploaded with an empty annotation.

# Notes

PCD does not define an official semantic label field name. The field stores numeric values only. The meaning of those values is dataset-specific and must be provided through `class_mapping.json`.

Photo context images and related image annotations are not supported by this format.

If you want to use ASPRS LAS classification names as a mapping preset, provide them explicitly in `class_mapping.json`. User-definable or reserved ranges can also be represented with range keys if needed.

# Useful links

- <a href="https://pointclouds.org/documentation/tutorials/pcd_file_format.html" target="_blank">PCD file format</a>
- <a href="https://lasformat.org/latest/02.00_definition.html#classification" target="_blank">ASPRS LAS Classification</a>
- <a href="https://developer.supervisely.com/getting-started/supervisely-annotation-format/point-clouds" target="_blank">Supervisely Pointcloud Annotation</a>
