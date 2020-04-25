Blur layer (`"action": "blur"`) applies blur filter to the image.

## Median blur

To use median blur (`cv2.medianBlur`) set `name` to `median` and `kernel` to **odd** number.

```json
{
  "action": "blur",
  "src": ["$data1"],
  "dst": "$data2",
  "settings": {
    "name": "median",
    "kernel": 5
  }
}
```

## Gaussian blur

To use gaussian blur (`cv2.GaussianBlur`) set `name` to `gaussian` and `sigma` to object with two numbers: `min` and `max`.

```json
{
  "action": "blur",
  "src": ["$data1"],
  "dst": "$data2",
  "settings": {
    "name": "gaussian",
    "sigma": { "min": 3, "max": 50 }
  }
}
```

![Original image](../../assets/legacy/export/blur/input.jpg)

![Resulting image](../../assets/legacy/export/blur/output.jpg)

## Example

```json
[
  {
    "dst": "$data",
    "src": [
      "example/*"
    ],
    "action": "data",
    "settings": {
      "classes_mapping": "default"
    }
  },
  {
    "dst": "$result",
    "src": [
      "$data"
    ],
    "action": "blur",
    "settings": {
      "name": "gaussian",
      "sigma": {"min": 3, "max": 50 }
    }
  },
  {
    "dst": "example_blur5",
    "src": [
      "$result"
    ],
    "action": "supervisely",
    "settings": {}
  }
]
```
