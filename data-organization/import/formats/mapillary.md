# Use case: upload Mapillary format

Step 1. Download Mapillary dataset

Step 2. Unpack archive

Step 3. Directory structure have to be the following:

```
.
├── training
│   ├── images
│   │   ├── 0035fkbjWljhaftpVM37-g.jpg
│   │   ├── 00qclUcInksIYnm19b1Xfw.jpg
│   │   ├── ...
│   ├── instances
│   │   ├── 0035fkbjWljhaftpVM37-g.png
│   │   ├── 00qclUcInksIYnm19b1Xfw.png
│   │   ├── ...
│   └── labels
│       ├── 0035fkbjWljhaftpVM37-g.png
│       ├── 00qclUcInksIYnm19b1Xfw.png
│       ├── ...
└── validation
    ├── images
    │   ├── 03G8WHFnNfiJR-457i0MWQ.jpg
    │   ├── 03T1YjbnUSumHU5n-iYEzA.jpg
    │   ├── ...
    ├── instances
    │   ├── 03G8WHFnNfiJR-457i0MWQ.png
    │   ├── 03T1YjbnUSumHU5n-iYEzA.png
    │   ├── ...
    └── labels
        ├── 03G8WHFnNfiJR-457i0MWQ.png
        ├── 03T1YjbnUSumHU5n-iYEzA.png
        ├── ...

```

Step 4. Choose all (two) subdirectories (`training` and `validation`) and drag and drop them to browser.    

{% hint style="warning" %}
If you will drag and drop parent directory instead of its contents, import will crash.
{% endhint %}
