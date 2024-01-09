# Project Meta: annotation classes, tags and other info

Each project in Supervisely has a set of predetermined classes and tags. This information is called `Project Meta` and stored in a corresponding JSON-based `meta.json` file. This file contains all of the necessary data from the project's classes and tags. Also, it has information about the project's type and settings:

![](../../.gitbook/assets/meta.png)

### Json format for project meta

```json
{
    "classes": [
        {
            "title": "bike",
            "shape": "rectangle",
            "color": "#F6FF00",
            "geometry_config": {},
            "id": 6509759,
            "hotkey": ""
        },
        {
            "title": "car",
            "shape": "polygon",
            "color": "#BE55CE",
            "geometry_config": {},
            "id": 6509764,
            "hotkey": ""            
        },
        {
            "title": "person",
            "shape": "bitmap",
            "color": "#00FF12",
            "geometry_config": {},
            "id": 6509777,
            "hotkey": ""            
        }
    ],
    "tags": [
        {
            "name": "cars_number",
            "color": "#A0A08C",
            "value_type": "any_number",
            "id": 27855,
            "hotkey": "",
            "applicable_type": "all",
            "classes": []            
        },
        {
            "name": "like",
            "color": "#D98F7E",
            "value_type": "none",
            "id": 27856,
            "hotkey": "",
            "applicable_type": "all",
            "classes": []               
        },
        {
            "name": "situated",
            "color": "#855D79",
            "value_type": "oneof_string",
            "values": [
                "inside",
                "outside"
            ],
            "id": 27857,
            "hotkey": "",
            "applicable_type": "all",
            "classes": []               
        },
        {
            "name": "car_color",
            "color": "#ED68A1",
            "value_type": "any_string",
            "id": 27858,
            "hotkey": "",
            "applicable_type": "all",
            "classes": ["car"]
        }
    ],
    "projectType": "images",
    "projectSettings": {
        "multiView": {
            "enabled": true,
            "tagName": "cars_number", 
            "tagId": null, 
            "isSynced": false
        }
    }
}
```

### Fields definitions

* `classes`(string) - list of all possible object classes. Each class has the following fields assigned:
  * `title`(string) - the unique identifier of a class
  * `shape`(string) - class shape, read more [here](../supervisely-annotation-json-format/objects.md#objects)
  * `color`(string) - hex color code
  * `geometry_config`(dictionary) [optional] - additional settings of the geometry. May be used with keypoints.
  * `id` (int) [optional] - the unique identification value of the class on the server
  * `hotkey` (string) [optional] - hotkey for the Labeling Tool to quickly change active annotation class
* `tags`(string) - list of all possible tags that can be assigned to images or objects. Read more [here](../supervisely-annotation-json-format/tags.md)
  * `name`(string) - the unique identifier of a tag
  * `value_type`(string) - one of the possible tag
  * `color`(string) - hex color code  
  * `values`(string) [optional] - initially predefined set of possible values
  * `id` (int) [optional] - the unique identification value of the tag  
  * `hotkey` (string) [optional] - hotkey for the Labeling Tool to quickly assign tag to object or image
  * `applicable_type` (string) [optional] - defines the applicability of Tag only to images (`imagesOnly`), objects (`objectsOnly`), or both (`all`). By default tag can be assigned to both images and objects.
  * `classes` (list of strings) [optional] - defines the applicability of Tag only to certain classes
* `projectType`(string) - one of the possible project types: `images`, `videos`, `volumes`, `point_clouds`, and `point_cloud_episodes`
* `projectSettings`(string) [optional] - additional project properties. For example, multi-view settings. Read more [here](../../getting-started/python-sdk-tutorials/images/multispectral-images.md#advanced-use-supervisely-format-for-multispectral-images)
  * `multiView` - additional properties for the multi-view mode
    * `enabled`(bool) - enable multi-view mode
    * `tagName`(string) (optional) - the name of the tag which will be used as a group tag
    * `tagId`(int) [optional] - the id of the tag which will be used as a group tag
    * `isSynced`(bool) - enable synchronization of views for the multi-view mode

Please note, that it is necessary that the group tag in `multiView` should have the corresponding `name` or the `id` in the `tags` field. Also, the `value_type` *should not be* `none`.
