# Use case: upload Pascal VOC format

Step 1. Download PascalVoc segmentation dataset

Step 2. Unpack archive

Step 3. Directory structure have to be the following:

```
.
├── ImageSets
│   └── Segmentation
│       ├── train.txt
│       ├── trainval.txt
│       └── val.txt
├── JPEGImages
│   ├── 2007_000032.jpg
│   ├── 2007_000033.jpg
│   ├── ...
├── SegmentationClass
│   ├── 2007_000032.png
│   ├── 2007_000033.png
│   ├── ...
└── SegmentationObject
    ├── 2007_000032.png
    ├── 2007_000033.png
    ├── ...
```

Step 4. Choose all (four) subdirectories and drag and drop them to browser.    

{% hint style="warning" %}
If you will drag and drop parent directory instead of its contents, import will crash.
{% endhint %}
