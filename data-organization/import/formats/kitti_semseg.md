# Use case: upload project in KITTI SemSeg format

Download KITTI [Semantic Segmentation dataset](http://www.cvlibs.net/datasets/kitti/eval_semseg.php?benchmark=semantics2015). As a result you will have `data_semantics.zip` archive. 

It contains two directories:

```
data_semantics
├── testing
│   └── image_2
│       ├── 000000_10.png
│       ├── ...
│       └── 000199_10.png
└── training
    ├── image_2
    │   ├── 000000_10.png
    │   ├── ...
    │   └── 000199_10.png
    ├── instance
    │   ├── 000000_10.png
    │   ├── ...
    │   └── 000199_10.png
    ├── semantic
    │   ├── 000000_10.png
    │   ├── ...
    │   └── 000199_10.png
    └── semantic_rgb
        ├── 000000_10.png
        ├── ...
        └── 000199_10.png
```

To import this dataset to Supervisely you have to perform two steps.

To import annotated data (train images) just drag and drop directory `training` and choose import preset "KITTI".

To import test images just drag and drop directory `image_2` (that locates in  `testing` directory) and choose import preset "Supervisely / Images".
