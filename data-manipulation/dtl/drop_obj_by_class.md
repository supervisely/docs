This layer (`drop_obj_by_class`) simply removes annotations of specified classes.

{% hint style="info" %}
You can also use [data](data.md) layer and map unnecessary classes to `__ignore__`.
{% endhint %}

## Settings
- `classes` (type: array of strings)

Annotations of classes from array `classes` will be removed.

```json
{
  "action": "drop_obj_by_class",
  "src": ["$input" ],
  "dst": "$output",
  "settings": {
    "classes": ["class-to-be-removed"]
  }
}
```

## Example

Drop annotations of class `numan`.

![](../../assets/legacy/export/drop-obj-by-class/s-l300.jpg)

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
    "action": "drop_obj_by_class",
    "src": ["$data" ],
    "dst": "$output",
    "settings": {
      "classes": ["human"]
    }
  },
  {
    "dst": "example_drop_noise",
    "src": [
      "$output"
    ],
    "action": "supervisely",
    "settings": {}
  }
]
```
