This layer (`bbox2poly`) converts rectangles ("bounding boxes") to polygons.

```json
{
  "action": "bbox2poly",
  "src": ["$sample1"],
  "dst": "$sample2",
  "settings": {
    "classes_mapping": {
      "awesome-rect": "awesome-poly"
    }
  }
}
```

## Settings

- `classes_mapping` — dict where keys are existing classes of shape `rectangle`, and values are new names of classes.

