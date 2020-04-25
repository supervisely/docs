This layer (`merge_bitmap_masks`) takes all bitmap annotations which has same class name and merge it into single bitmap annotation.

```json
{
  "src": [
    "$sample1"
  ],
  "dst": "$sample2",
  "action": "merge_bitmap_masks",
  "settings": {
    "class": "Bird"
  }
}
```

## Settings

- `class` — name of class for merging.


## Visual example:


Before:

![](../../assets/legacy/all_images/split_mask.png)

After:

![](../../assets/legacy/all_images/merge_masks.png)



## Similar commands:
* [Split Masks](split_masks.md)
