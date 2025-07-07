# Overview

This converter allows you to import **NIfTI** files into a Supervisely project. It also supports annotations in the NIfTI format (`.nii` and `.nii.gz`).

The converter supports both **semantic** and **instance segmentation** annotations, as well as import of volumes with no annotations. We will provide an examples of the input structure below.

{% hint style="success" %}
The converter is backwards compatible with the <a href="https://ecosystem.supervisely.com/apps/export-volume-project-to-cloud-storage"> Export volume project to cloud storage </a> application.
{% endhint %}

All volumes from the input directory and its subdirectories will be uploaded to a single dataset

# Format description

**Supported image formats:** `.nii`, `.nii.gz`.<br>
**With annotations:** Yes (semantic and instance segmentation).<br>
**Supported annotation format:** `.nii`, `.nii.gz`.<br>
**Data structure:** Information is provided below.<br>

# Input files structure

### **Example 1: grouped by volume name**

The NIfTI file should be structured as follows:

```text
📂 dataset_name # ⬅︎ may be archive, root files or nested directory instead
├── 📂 CTChest          # ⬅︎ the same name as the volume name
│   │   # ⬇︎ this directory contains annotations for the CTChest volume
│   ├── 🩻 lung.nii.gz
│   └── 🩻 tumor.nii.gz
├── 🩻 CTChest.nii.gz
└── 🩻 Spine.nii.gz     # ⬅︎ this volume has no annotations
```

If the volume has annotations, they should be in the corresponding directory with the same name as the volume (e.g. `CTChest`, without extension).

Annotation files should be named according to the following pattern:

- Name of the class (e.g. `lung`, `tumor`) + `.nii` or `.nii.gz`.<br>
- The class name should be unique for the current volume (e.g. `tumor.nii.gz`, `lung.nii.gz`).
- Annotation files can contain multiple objects of the same class (each object should be represented by a different value in the mask).<br>

### **Example 2: grouped by plane**

The NIfTI file should be structured as follows:

**For semantic segmentation:**

- The filename must contain one of the required plane identifiers: `axl`, `cor`, or `sag`, anywhere in the name.
- The file representing the anatomical volume should have `anatomical` string in it's filename representing the volume type.
- The annotation file for all classes should also include the prefix, volume type label (`inference`, `mask`, `ann` etc.), ending with `.nii` or `.nii.gz`.

**For instance segmentation:**

- The anatomical volume file must include the plane identifier (`axl`, `cor`, or `sag`), `anatomic` type label and end with `.nii` or `.nii.gz`.
- Each annotation file must also include the plane identifier and type label (`inference`, `mask`, `ann` etc.), ending with `.nii` or `.nii.gz`.
- Multiple annotation files per plane are supported, each representing a separate class (and may contain multiple objects).

**Note:** Filenames can include other descriptive parts such as patient or case UIDs, body parts, arbituary strings or other identifiers, as long as the required plane and type identifiers are present and the file extension is `.nii` or `.nii.gz`.

The plane identifier must be one of: `cor`, `sag`, or `axl`. The converter uses these prefixes to group volumes and their annotation files, requiring exactly three volumes — one for each prefix per folder.

Structure example for semantic segmentation:

```text
📂 dataset_name # ⬅︎ may be archive, root files or nested directory instead
├──📄 cls_color_map.txt  # ⬅︎ optional file
├──🩻 axl_anatomic.nii
├──🩻 axl_inference.nii
├──🩻 cor_anatomic.nii
├──🩻 cor_inference.nii
├──🩻 sag_anatomic.nii
└──🩻 sag_inference.nii
```

Structure example for instance segmentation:

```text
📂 dataset_name # ⬅︎ may be archive, root files or nested directory instead
├──📄 cls_color_map.txt  # ⬅︎ optional file
├──🩻 axl_anatomic.nii
├──🩻 axl_inference_1.nii
├──🩻 axl_inference_2.nii
├──🩻 cor_anatomic.nii
├──🩻 cor_inference_1.nii
├──🩻 cor_inference_2.nii
├──🩻 cor_inference_3.nii
├──🩻 sag_anatomic.nii
└──🩻 sag_inference_1.nii
```

### **Example 3: grouped by plane w/ multiple items**

If you need to import multiple items at once, place each item in a separate folder.
The converter supports any folder structure. Folders may be at different levels, and files will be matched by directory (annotation files must be in the same folder as their corresponding volume). All files will be imported into the same dataset.

Structure example for multiple items directory:

```text
📂 dataset_name # ⬅︎ may be archive, root files or nested directory instead
├──📄 cls_color_map.txt  # ⬅︎ optional file
├──📂 item_1
│  ├──🩻 axl_anatomic.nii
│  ├──🩻 axl_inference_1.nii
│  ├──🩻 axl_inference_2.nii
│  ├──🩻 cor_anatomic.nii
│  ├──🩻 cor_inference_1.nii
│  ├──🩻 cor_inference_3.nii
│  └──🩻 sag_anatomic.nii
├──📂 item_2
│  ├──🩻 axl_anatomic.nii
│  ├──🩻 axl_inference_1.nii
│  ├──🩻 axl_inference_2.nii
│  ├──🩻 cor_anatomic.nii
│  ├──🩻 cor_inference_1.nii
│  ├──🩻 cor_inference_3.nii
│  └──🩻 sag_anatomic.nii
├──📂 item_2
│  ├──🩻 axl_anatomic.nii
│  ├──🩻 axl_inference_1.nii
│  ├──🩻 axl_inference_2.nii
│  ├──🩻 cor_anatomic.nii
│  ├──🩻 cor_inference_1.nii
│  ├──🩻 cor_inference_3.nii
│  ├──🩻 sag_anatomic.nii
└──└──🩻 sag_inference_1.nii
```

### Example 4: Upload with scores and comments metadata

Starting from SDK version v6.73.394 and instance version v6.13.8, the converter supports uploading NIfTI files with additional metadata – scores. To upload this metadata, you need to create corresponding `CSV` files for each volume-annotation pair. Make sure that the CSV file name contains `score` (instead of `anatomic` or `inference`) and has the same prefix as the NIfTI file.

Structure example for uploading with scores and comments:

```text
📂 dataset_name # ⬅︎ may be archive, root files or nested directory instead
├──🩻 axl_anatomic.nii
├──🩻 axl_inference.nii
├──🩻 cor_anatomic.nii
├──🩻 cor_inference.nii
├──🩻 sag_anatomic.nii
├──📄 axl_score.csv
├──📄 cor_score.csv
└──📄 sag_score.csv
```

Where the `CSV` files should be structured as follows:

```csv
Layer, Label-2, Label-4, ...
3, 0.8, 0.9, ...
7, 0.7, 0.6, ...
8, 0.4, 0.3, ...
```

![csv_example](https://github.com/supervisely-ecosystem/import-wizard-docs/releases/download/v0.0.3/csv_example.jpg)

where:

- **Layer**: The frame number in the NIfTI file (starting from 1).
- **Label-2, Label-4, ...**: Corresponding labels for the NIfTI file, which contains the `Label-` prefix with the corresponding pixel value in the NIfTI file.

To view the scores and comments in the Labeling Toolbox, you need to enable the "Show Figure Score and Comment" option in the toolbox settings.

![settings](https://github.com/supervisely-ecosystem/import-wizard-docs/releases/download/v0.0.3/settings.jpg)

After enabling this option and uploading the NIfTI files with scores, you will see the scores and comments in the Labeling Toolbox.

![toolbox](https://github.com/supervisely-ecosystem/import-wizard-docs/releases/download/v0.0.3/toolbox.jpg)

**Impotant**: You can import and export scores, but you cannot edit them in the Labeling Toolbox. Comments can be edited in the Labeling Toolbox, but they will not be saved back to the CSV files.

### Class color map file (optional)

The converter will look for an optional `TXT` file in the input directory. If present, it will be used to create the classes with names and colors corresponding to the pixel values in the NIfTI files.

The TXT file should be structured as follows:

```txt
1 Femur 255 0 0
2 Femoral cartilage 0 255 0
3 Tibia 0 0 255
4 Tibia cartilage 255 255 0
5 Patella 0 255 255
6 Patellar cartilage 255 0 255
7 Miniscus 175 175 175
```

where:

- 1, 2, ... are the pixel values in the NIfTI files
- Femur, Femoral cartilage, ... are the names of the classes
- 255, 0, 0, ... are the RGB colors of the classes

# Upload annotations separately

Plane-structured converter supports uploading annotations separately (uploading annotations to existing volumes). This functionality supports both dataset-scope and project-wide annotation imports.

By default, annotations are matched with their corresponding volumes based on filenames. However, a custom mapping can be provided via a `.json` file to explicitly define the mapping.

Input structure example for dataset scope:

```text
🩻 axl_inference_1.nii
🩻 axl_inference_2.nii
🩻 cor_inference_1.nii
🩻 cor_inference_3.nii
📄 color_map.txt # ⬅︎ optional file
📄 mapping.json # ⬅︎ optional file
```

Input structure example for project-wide import:

```text
📄 mapping.json # ⬅︎ optional file
📄 cls_color_map.txt  # ⬅︎ optional file
📂 dataset_name_1
├──🩻 axl_inference_1.nii
├──🩻 axl_inference_2.nii
└──🩻 cor_inference_3.nii
📂 dataset_name_2
├──🩻 axl_inference_1.nii
├──🩻 axl_inference_2.nii
└──🩻 cor_inference_3.nii
📂 dataset_name_3
├──🩻 axl_inference_1.nii
├──🩻 axl_inference_2.nii
└──🩻 cor_inference_3.nii
```

### JSON mapping

Mapping structure should be as follows:

```
{
    "cor_inference_1.nii": 123,
    "sag_mask_2.nii": 456
}
```

Where key should be annotation filename, and volume ID as value

If you want to import annotations for the entire project via a JSON mapping:

1. Pack annotations inside folders with corresponding dataset name as in an example above
2. Specify the dataset name in a `.json` file in a path-like manner (`dataset_name/annotation_filename`)

Example JSON structure with dataset specification:

```
{
    "dataset1/cor_inference_1.nii": 123,
    "dataset2/sag_mask_2.nii": 456
}
```

# Useful links

- <a href="https://ecosystem.supervisely.com/apps/export-volume-project-to-cloud-storage" target="_blank">[Supervisely Ecosystem] Export volume project to cloud storage</a>
