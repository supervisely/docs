This layer (`line2bitmap`) converts geometry figures (lines) to bitmaps.

```json
{
  "action": "line2bitmap",
  "src": ["$sample1"],
  "dst": "$sample2",
  "settings": {
    "classes_mapping": {
      "some-lines": "some-lines-bitmap"
    },
    "width": 2
  }
}
```

## Settings

- `classes_mapping` — dict where keys are existing classes of shape `line`, and values are new names of classes.
- `width` — line width in pixels.
