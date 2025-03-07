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
📂 dataset_name
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

- **prefix**\_anatomic.nii (or `.nii.gz`)
- **prefix**\_inference.nii (or `.nii.gz`) - all classes in one file

**For instance segmentation:**

- **prefix**\_anatomic.nii (or `.nii.gz`)
- **prefix**\_inference_1.nii (or `.nii.gz`) - first class (may contain multiple objects)
- **prefix**\_inference_2.nii (or `.nii.gz`) - second class (may contain multiple objects)
- ...

The prefix must be one of: `cor`, `sag`, or `axl`. The converter uses these prefixes to group volumes and their annotation files, requiring exactly three volumes — one for each prefix per folder.

Structure example for semantic segmentation:

```text
📂 dataset_name
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
📂 dataset_name
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

# Useful links

- <a href="https://ecosystem.supervisely.com/apps/export-volume-project-to-cloud-storage" target="_blank">[Supervisely Ecosystem] Export volume project to cloud storage</a>
