This layer (`objects_filter`) deletes annotations less (or greater) than specified size or percentage of image area.

## Settings

- `filter_by`
    - `polygon_sizes`
        - `filtering_classes` (type: array of classes)
        - `area_size` one of
            - `percent` (type: number)
            - `size`:
                - `width` (type: number)
                - `height` (type: number)
        - `comparator` (type: enum ["less", "greater"])
        - `action` (type: enum ["delete"])
        
    or
    
    - `names` (type: array of classes)


## Case: names

```json
{
  "action": "objects_filter",
  "src": ["$sample1"],
  "dst": "$sample2",
  "settings": {
    "filter_by": {
      "names": ["Class A", "Class C"]
    }
  }
}
```

Delete annotations of classes which not present in `names`.


## Case: area percent

```json
{
  "action": "objects_filter",
  "src": ["$sample1"],
  "dst": "$sample2",
  "settings": {
    "filter_by": {
      "polygon_sizes": {
        "filtering_classes": ["person"],
        "area_size": {
          "percent": 5
        },
        "action": "delete",
        "comparator": "less"
      }
    }
  }
}
```

Delete annotations of classes from `filtering_classes` that have area (in percentage of image area) less than specified value of `area_size`.

Use `comparator` = `greater` to delete annotations which area is greater than defined.

## Case: bounding box size

```json
{
  "action": "objects_filter",
  "src": ["$sample1"],
  "dst": "$sample2",
  "settings": {
    "filter_by": {
      "polygon_sizes": {
        "filtering_classes": ["person"],
        "area_size": {
          "width": 10,
          "height": 40
        },
        "action": "delete",
        "comparator": "less"
      }
    }
  }
}
```

Delete annotations of classes from `filtering_classes` that have some side (determined by the annotation bounding box) less than specified value of `width` or `height` correspondingly.

Use `comparator` = `greater` to delete annotations which some side is greater than defined.

## Example

Remove annotations of class `bus` that are smaller than 10% of image area.

```json
[
  {
    "dst": "$data",
    "src": [
      "mini_pascal/*"
    ],
    "action": "data",
    "settings": {
      "classes_mapping": "default"
    }
  },
  {
    "action": "objects_filter",
    "src": ["$data"],
    "dst": "$output",
    "settings": {
      "filter_by": {
        "polygon_sizes": {
          "filtering_classes": ["bus"],
          "area_size": {
            "percent": 10
          },
          "action": "delete",
          "comparator": "less"
        }
      }
    }
  },
  {
    "dst": "example_filter",
    "src": [
      "$output"
    ],
    "action": "supervisely",
    "settings": {}
  }
]
```

