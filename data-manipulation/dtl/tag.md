# Tag

Tag layer (`tag`) adds or removes tags from images. Tags are used for several things, e.g. to split images by folders in save layers or to filter images by tag.

### Settings

```json
{
  "action": "tag",
  "src": ["$sample4"],
  "dst": "$sample5",
  "settings": {
    "tag": "train",
    "action": "add"
  }
}
```

* `tag` — tag title
* `action` (type: enum \[`add`, `delete`]) — possible action (add the tag to image or delete one from image)

### Example

Split data into train and validation sets by adding corresponding tag to each image.

```json
[
  {
    "action": "data",
    "src": ["my_proj/*"],
    "dst": "$data",
    "settings": {
      "classes_mapping": "default"
    }
  },
  {
    "action": "if",
    "src": ["$data"],
    "dst": [
      "$totrain",
      "$toval"
    ],
    "settings": {
      "condition": {
        "probability": 0.95
      }
    }
  },
  {
    "action": "tag",
    "src": ["$totrain"],
    "dst": "$train",
    "settings": {
      "tag": "train",
      "action": "add"
    }
  },
  {
    "action": "tag",
    "src": ["$toval"],
    "dst": "$val",
    "settings": {
      "tag": "val",
      "action": "add"
    }
  },
  {
    "action": "supervisely",
    "src": [
      "$train",
      "$val"
    ],
    "dst": "proj_with_tags",
    "settings": {}
  }
]
```

Computational graph:

![](<../../assets/legacy/all\_images/if\_001 (1).png>)
