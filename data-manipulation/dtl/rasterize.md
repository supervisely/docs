This layer (`rasterize`) converts all geometry figures to bitmaps.

```json
{
  "action": "rasterize",
  "src": ["$sample1"],
  "dst": "$sample2",
  "settings": {
    "classes_mapping": {
      "some-lines": "some-lines-bitmap",
      "some-polygons": "some-polygons-bitmap"
    }
  }
}
```

## Settings

- `classes_mapping` — dict where keys are existing classes of any geometry shape, and values are new names of classes.

Also you can pass bitmaps figures, it will not be change (only change name if you want). All classes which not presented in `class_mapping` will be unchanged pass throw layer. 
