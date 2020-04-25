This layer (`find_contours`) extracts contours from bitmaps and stores results as polygons.

```json
{
  "src": [
    "$sample1"
  ],
  "dst": "$sample2",
  "action": "find_contours",
  "settings": {
    "classes_mapping": {
      "my-mask": "found-contours"
    }
  }
}
```

For each figure of class "my-mask" this will find contours (with OpenCV `findContours`), and the found contours will be stored as objects of shape "polygon" (class "found-contours").

Holes in source masks produce holes in polygons (with two-level hierarchy of borders).

## Settings

- `classes_mapping` — dict where keys are existing classes of shape `bitmap`, and values are new names of classes.

## Example

Example of usage may be found [here](examples/vectorize-bitmap/index.md).
