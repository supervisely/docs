This layer (`background`) adds background rectangle (size equals to image size) with custom class to image annotations. This layer is used to prepare data to train Neural Network for semantic segmentation.

Example:
``` json
{
  "action": "background",
  "src": ["$data"],
  "dst": "$data_with_bg",
  "settings": {
    "class": "bg"
  }
}
```

This example adds polygon object with class "bg" to the image annotations as bottom layer.

Results:

![](../../assets/legacy/all_images/bg_001.png)

