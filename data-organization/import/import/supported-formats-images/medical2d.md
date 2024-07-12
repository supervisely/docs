# Overview

Medical 2D Converter allows to import 2D files with `.nrrd`, `.dcm`, `.nii` and `.nii.gz` extensions. Files with extensions different from `.nrrd` will be converted to `.nrrd`

While this converter primarily supports 2D medical images, it is possible to import 3D files. However, please note that 3D files will be transposed and sliced along the axial plane. This process converts the 3D image into a series of 2D slices, which can then be viewed and analyzed individually.

# Format description

**Supported image formats:** `.nrrd`, `.dcm`, `.nii` and `.nii.gz`<br>
**With annotations:** No<br>
**Grouped by:** Any structure (will be uploaded as a single dataset)<br>

# Input files structure

{% hint style="info" %}
Example data: [download ⬇️](https://github.com/supervisely-ecosystem/import-wizard-docs/files/14934438/sample_medical2d.zip)<br>
{% endhint %}

Recommended directory structure:

```text
  📦project name
  ┣ 📜Image_1.dcm
  ┣ 📜Image_2.dcm
  ┣ 📜Image_3.dcm
  ┣ 📜Image_4.dcm
  ┣ 📜Image_5.DCM
  ┣ 📜Image_6.nrrd
  ┗ 📜Image_7.nii
```


## 2D Medical Image Formats Explained

- **DCM**

  `DCM` file is an image following Digital Imaging and Communications in Medicine (DICOM) format. Format is used to store various medical images like CT scans, MRIs, PET, ultrasound, etc.

  Uses `.dcm` and `.DICOM` extensions

  If your DICOM data contains one of the following metadata fields, it will be used as `group` tag in the project:

    - `StudyInstanceUID`
    - `StudyID`
    - `SeriesInstanceUID`
    - `TreatmentSessionUID`
    - `Manufacturer`
    - `ManufacturerModelName`
    - `Modality`

  Moreover, all other DICOM metadata will be saved as image metadata and can be viewed in the Labeling interface.

  ***

- **NRRD**

  `NRRD` file is a medical imaging format. It is used to store 2D and 3D images along with metadata. It is commonly used in medical imaging.

  Uses `.nrrd` extension.

  ***

- **NII**

  `NII` format is commonly used to store magnetic resonance imaging (MRI) data.

  Uses `.nii` and `.nii.gz` extensions.

![Medical data import results](./images/medical2d_result.png)

# Useful links

- [[Supervisely Ecosystem] Import DICOM studies](https://ecosystem.supervisely.com/apps/import-dicom-studies)
- [Nearly Raw Raster Data (NRRD): Format, Examples etc.](https://teem.sourceforge.net/nrrd/)
- [Overview of The Content of The DICOM Standard](https://dicom.nema.org/medical/dicom/current/output/html/part01.html#chapter_6)
- [Neuroimaging Informatics Technology Initiative (NIfTI)](https://nifti.nimh.nih.gov/)