# Overview

This converter allows to import `.PDF` files as images in `.PNG` format.
Each page of the `.PDF` file will be converted to a separate image. The images will have a suffix added to their names to indicate the page number.

# Format description

**Supported image formats:** `.pdf`<br>
**With annotations:** No<br>
**Supported annotation file extension:** Not applicable<br>
**Grouped by:** Any structure (will be uploaded as a single dataset)<br>

![PDF import results](https://github.com/supervisely-ecosystem/import-wizard-docs/assets/48913536/488fec72-f2fe-4078-a4b3-3105a06e1b8a)

# Input files structure

{% hint style="success" %}
Example data: [download ⬇️](https://github.com/supervisely-ecosystem/import-wizard-docs/files/14905329/Sample_PDF.zip)<br>
{% endhint %}

Recommended directory structure:

```text
  📦project name
   ┣ 📜Demo_1.pdf
   ┣ 📜Demo_2.pdf
   ┣ 📜Demo_3.pdf
   ┣ 📜Demo_4.pdf
   ┗ 📜Demo_5.pdf
```

# Useful links

- [[Supervisely Ecosystem] Import PDF as Images](https://ecosystem.supervisely.com/apps/import-pdf-as-images)
