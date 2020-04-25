Flip layer (`flip`) simply flips data (image + annotation) vertically or horizontally.

```json
{
  "action": "flip",
  "src": ["$data1"],
  "dst": "$data2",
  "settings": {
    "axis": "vertical"
  }
}
```

`"axis"` field can be one of two values `horizontal` or `vertical`.

Here are the possible results:

![Original image](../../assets/legacy/all_images/flip_001_orig.jpg)

!["axis": "vertical"](../../assets/legacy/all_images/flip_002_vert.jpg)

!["axis": "horizontal"](../../assets/legacy/all_images/flip_003_hor.jpg)

## Example

```json
[
  {
    "dst": "$data",
    "src": [
      "myproj/*"
    ],
    "action": "data",
    "settings": {
      "classes_mapping": "default"
    }
  },
  {
    "dst": "$flip_vert",
    "src": [
      "$data"
    ],
    "action": "flip",
    "settings": {
      "axis": "vertical"
    }
  },
  {
    "dst": "flip_ver",
    "src": [
      "$data",
      "$flip_vert"
    ],
    "action": "supervisely",
    "settings": {}
  }
]
```

![](../../assets/legacy/all_images/flip_004.png)

In this example we just get all data (images + annotations) from project `myproj`, apply vertical flip to images and save both original and flipped version.
