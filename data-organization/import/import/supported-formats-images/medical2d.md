<!-- <h1 align="left" style="border-bottom: 0"> <img align="left" src="https://github.com/supervisely-ecosystem/import-wizard-docs/assets/48913536/99998ee5-b20c-4104-82af-9a787e863a3b" width="80"> Medical 2D Files Converter </h1>

<br> -->

# Overview

Medical 2D Converter allows to import 2D files with `.nrrd`, `.dcm`, `.nii` and `.nii.gz` extensions. Files with extensions different from `.nrrd` will be converted to `.nrrd`

<details>
<summary><b>What is DCM file?</b></summary>

 <br>

`DCM` file is an image following Digital Imaging and Communications in Medicine (DICOM) format. Format is used to store various medical images like CT scans, MRIs, PET, ultrasound, etc.

Uses `.dcm` and `.DICOM` extensions

</details>

<details>
<summary><b>What is NII file?</b></summary>

 <br>

`NII` format is commonly used to store magnetic resonance imaging (MRI) data.

Uses `.nii` and `.nii.gz` extensions.

</details>

<details>
<summary><b>What is NRRD file?</b></summary>

 <br>

`NRRD` file is a medical imaging format. It is used to store 2D and 3D images along with metadata. It is commonly used in medical imaging.

Uses `.nrrd` extension.

</details>

![Medical data import results](./images/medical2d_result.png)

# Format description

**Supported image formats:** `.nrrd`, `.dcm`, `.nii` and `.nii.gz`<br>
**With annotations:** No<br>
**Grouped by:** Not applicable (yet)<br>

# Input files structure

Example of data for import: ([download ⬇️](https://github.com/supervisely-ecosystem/import-wizard-docs/files/14934438/sample_medical2d.zip))<br>

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

# Useful links

- [[Supervisely Ecosystem] Import dicom studies](https://ecosystem.supervisely.com/apps/import-dicom-studies)
