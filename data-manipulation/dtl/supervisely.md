Supervisely layer (`supervisely`) stores results of data transformations to a new project in your workspace. Remember that you should specify a unique name to your output project. This output project will be created automatically.

{% hint style="info" %}
Supervisely layer doesn't need any settings so just leave this field blank.
{% endhint %}

```json
{
  "action": "supervisely",
  "src": ["$sample"],
  "dst": "output_project",
  "settings": {}
}
```

## Example

In the example below data is read from the project `input_project`. Then it is flipped vertically and finally dropped to the new project `output_project`.

```json
[
  {
    "dst": "$data",
    "src": [
      "input_project/*"
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
    "dst": "output_project",
    "src": [
      "$flip_vert"
    ],
    "action": "supervisely",
    "settings": {}
  }
]
```

Now you can ensure that in project list there is the `output_project`.

![](../../assets/legacy/all_images/screen_supervisely_layer.png)
