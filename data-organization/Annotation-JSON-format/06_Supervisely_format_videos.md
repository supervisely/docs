# Single-Video Annotation JSON

For each video file, we store the annotations in a separate json file named `video_name.video_format.json` with the following file structure:

Example:

![](figures\_images/video\_frame.png)

Json format of annotation for video format:

```json
{
    "size": {
        "height": 1080,
        "width": 1920
    },
    "description": "",
    "key": "c8168b43ae1b45c38930f456df9d0f2b",
    "tags": [],
    "objects": [
        {
            "key": "198f727d40c749eebcacc4aed299b39a",
            "classTitle": "rect",
            "tags": [],
            "labelerLogin": "alexxx",
            "updatedAt": "2020-08-23T12:06:11.963Z",
            "createdAt": "2020-08-23T12:06:11.963Z"
        }
    ],
    "frames": [
        {
            "index": 0,
            "figures": [
                {
                    "key": "65f21690780e43b49863c3cbd07eab3a",
                    "objectKey": "198f727d40c749eebcacc4aed299b39a",
                    "geometryType": "rectangle",
                    "geometry": {
                        "points": {
                            "exterior": [
                                [
                                    266,
                                    420
                                ],
                                [
                                    847,
                                    845
                                ]
                            ],
                            "interior": []
                        }
                    },
                    "labelerLogin": "alexxx",
                    "updatedAt": "2020-08-23T12:06:13.544Z",
                    "createdAt": "2020-08-23T12:06:13.544Z"
                }
            ]
        }
    ],
    "framesCount": 375
}
```

**Fields definitions:**

* `size` - string - is equal to image(frame) size
* `description` - string - (optional) - this field is used to store the text we want to assign to the video. In the labeling intrface it corresponds to the 'data' filed.
* `tags` - list of strings that will be interpreted as video tags
* `key` - string, unique key for a given video (used in key\_id\_map.json to get the video ID)
* `objects` - list of objects that may be present on the video
* `frames` - list of frames of which the video consists. List contains only frames with an object from the 'objects' field
  * `index` - integer - number of the current frame
  * `figures` - integer - list of objects which the current frame contains
* `framesCount` - integer - total number of frames in the video
* `objectKey` - string - unique key for a given object (used in `key_id_map.json`)
* `labelerLogin` - string - the name of a user who created the current figure
* `geometryType` - "cuboid\_3d" - class shape
* `geometry` - a dictionary containing indicators of location, rotation and dimensions of cuboids

**Fields definitions for objects field:**

* `key` - string, a unique key for the given object (used in `key_id_map.json` to get the object ID)
* `classTitle` - string - the title of a class. It's used to identify the class shape from the `meta.json` file
* `tags` - list of strings that will be interpreted as object tags
* `labelerLogin` - string - the name of the user that added this figure to the project

**Fields description for figures field:**

* `key` - string, a unique key for the given figure (used in key\_id\_map.json to get the figure ID)
* `objectKey` - string, a unique key for the given object (used in key\_id\_map.json to get the object ID).
* `geometryType` - "rectangle" - class shape
* `geometry` - geometry of the object
* `labelerLogin` - string, the name of the user that added this figure to the current frame
* `createdAt` - string - the date and time when the figure was created in format "YYYY-MM-DDTHH:MM:SS.MMMZ"
* `updatedAt` - string - the date and time when the figure was updated in format "YYYY-MM-DDTHH:MM:SS.MMMZ"
* `meta` - [Optional] dictionary, contains additional information about the figure
* `smartToolInput` - [Optional] dictionary, if the figure was created by smart tool, contains geometries of the box and points
* `priority` - [Optional] integer, priority of the figure
* `trackId` - [Optional] string, if the figure was created by tracker, contains the track ID

## Key id map file

`Key_id_map.json` file is optional. It is created when annotating the video inside Supervisely interface and sets the correspondence between the unique identifiers of the video, object and the frame on which the object is located. If you annotate manually, you do not need to create this file. This will not affect the work being done.

Json format of `key_id_map.json`:

```json
{
    "tags": {},
    "objects": {
        "198f727d40c749eebcacc4aed299b39a": 20520
    },
    "figures": {
        "65f21690780e43b49863c3cbd07eab3a": 503130811
    },
    "videos": {
        "c8168b43ae1b45c38930f456df9d0f2b": 157876296
    }
}
```

Fields definitions:

* `objects` - dictionary, where the key is a unique string, generated inside Supervisely environment to set correspondence of current object in annotation, and values are unique integer ID corresponding to the current object
* `figures` - dictionary, where the key is a unique string, generated inside Supervisely environment to set correspondence of object on current frame in annotation, and values are unique integer ID corresponding to the current frame
* `videos` - dictionary, where the key is unique string, generated inside Supervisely environment to set correspondence of video in annotation, and value is a unique integer ID corresponding to the current video
* `tags` - dictionary, where the keys are unique strings, generated inside Supervisely environment to set correspondence of tag on current frame in annotation, and values are a unique integer ID corresponding to the current tag
