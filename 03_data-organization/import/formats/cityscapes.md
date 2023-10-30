# Use case: upload Cityscapes format

Step 1. Download Cityscapes dataset. Two files: `gtFine_trainvaltest.zip` and `leftImg8bit_trainvaltest.zip`

Step 2. Unpack both archives to the same directory

Step 3. Directory structure have to be the following:

```
.
├── gtFine
│   ├── test
│   │   ├── ...
│   ├── train
│   │   ├── ...
│   └── val
│       ├── ...
└── leftImg8bit
    ├── test
    │   ├── ...
    ├── train
    │   ├── ...
    └── val
        └── ...
```

Step 4. Choose all (two) subdirectories (`gtFine` and `leftImg8bit`) and drag and drop them to browser.    

{% hint style="warning" %}
If you drag and drop parent directory instead of its contents, import will crash.
{% endhint %}
