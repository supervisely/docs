Save layer (`save`) allows to export annotations and images. Annotations are stored in .json files. Images are stored in .png or .jpg files (due to format of source image). When exporting annotations, `meta.json` file containing all used classes for project is also exported. Moreover, you can get visual representations of all annotated objects on top of your images by setting `visualize` to true. See example below.

```json
{
  "action": "save",
  "src": [
    "$sample"
  ],
  "dst": "experiment001",
  "settings": {
    "visualize": true
  }
}
```

 * `visualize` — true if visual representations of all annotated objects are generated. Bitmap objects are drawn without modifications, polygons are filled with color associated with the class, for rectangles only borders are drawn.

## Settings
 _Field `visualize` is set to false by default._

## Examples
Export images, annotations and visualisations to `output` archive that you can simply download:

```json
[
  {
    "action": "data",
    "src": [
      "input_project/*"
    ],
    "dst": "$sample",
    "settings": {
      "classes_mapping": "default"
    }
  },
  {
    "action": "save",
    "src": [
      "$sample"
    ],
    "dst": "output",
    "settings": {
      "visualise": true
    }
  }
]
```

## Example of meta.json file

Suppose that "kiwi" and "lemon" classes are defined in "input_project". In that case, `meta.json` file will look the following way:
```json
{
  "classes": [
    {
      "color": "#FF0000",
      "shape": "bitmap",
      "title": "kiwi"
    },
    {
      "color": "#1B00FF",
      "shape": "bitmap",
      "title": "lemon"
    }
  ],
  "tags": [],
}
```

## Visualisation example

If `visualize` attribute is set to `true` then for each images corresponding visualisations are generated. Here is an example
![](../../assets/legacy/export/save_layers/vis_example.png)
