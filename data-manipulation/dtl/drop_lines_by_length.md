Layer `drop_lines_by_length` - remove too long or to short lines. Also this layer can drop lines with length in range.

Lines with more than two points also supported. For multi-lines total length is calculated as sum of sections.

```json
{
    "action": "drop_lines_by_length",
    "src": [
      "$sample8"
    ],
    "dst": "$sample9",
    "settings": {
      "lines_class": "A-Line",
      "resolution_compensation": false,
      "invert": false,
      "min_length": 3,
      "max_length": 20
    }
}
```

## Settings

- `lines_class`  - class name of target lines. 

- `resolution_compensation` - used for images with different resolution (scales). If `false` - line length calcalute with pixels. If `true` - in relative units. 

- `min_length` - minimal line length.

- `max_length` - maximal line length.

- `invert` - invert drop results. This mode can be used to remove lines with length in range.

### Resolution compensation 

Guess that we have images with width `1000`px and `2000`px.
Also guess that we want to remove lines with length less than `10`px.

Resolution compenstation based on images width and calculated as: 

`new_min_length = (image_width / 1000) * min_length`

If `resolution_compensation` is enabled, actual minimal line length will be `10`px and `20`px respectively.  
