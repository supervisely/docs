# Overview

{% hint style="success" %}
Easily import your videos with annotations in the Supervisely format. The Supervisely json-based annotation format supports such figures: `rectangle`, `line (polyline)`, `polygon`, `point`, `bitmap` (`mask`), `graph` (`keypoints`). It is a universal format that supports various types of annotations and is used in the Supervisely platform.
{% endhint %}

{% hint style="info" %}
All information about the Supervisely JSON format can be found <a href="https://docs.supervisely.com/data-organization/00_ann_format_navi" target="_blank">here</a>
{% endhint %}

## Format description

**Supported video formats:** `.avi`, `.mp4`, `.3gp`, `.flv`, `.webm`, `.wmv`, `.mov`, and `.mkv` <br>
**With annotations:** yes<br>
**Supported annotation format:** `.json`.<br>
**Data structure:** Information is provided below.

## Input files structure

{% hint style="success" %}
Example data: [download ⬇️](https://github.com/supervisely-ecosystem/import-videos-in-sly-format/files/12546490/my_videos_project.zip).
{% endhint %}

Both directory and archive are supported.

**Recommended directory structure:**

```text
  📦input_folder
   ┣ 📂dataset_name_01
   ┃  ┣ 📂ann
   ┃  ┃  ┣ 📄vid_0748.mp4.json
   ┃  ┃  ┗ 📄vid_8144.mp4.json
   ┃  ┣ 📂video
   ┃  ┃  ┣ 🎬vid_0748.mp4
   ┃  ┃  ┗ 🎬vid_8144.mp4
   ┃  ┗ 📂meta (optional)
   ┃     ┣ 📄vid_0748.mp4.json
   ┃     ┗ 📄vid_8144.mp4.json
   ┣ 📄meta.json
   ┗ 📄key_id_map.json file (optional)
```

**Struggled with the structure?** No worries!
All videos will be uploaded to a single dataset, so you don't have to worry about the full project structure in Supervisely format. All you need is to prepare videos with annotations and `meta.json` file (recommended).

Items even can be placed in any subdirectories or the root directory. Just make sure that the annotation file names match the video file names (e.g. annotaion file `video_1.jpg.json` is for the video `video_1.jpg`) and that the annotation file format is correct (we will provide an example in the next section). The application will do the rest.

Project meta file `meta.json` is recommended to be present in the project directory. It contains classes and tags definitions for the project. If it is not present, it will try to create it from the annotations. Learn more about the `meta.json` file <a href="https://docs.supervisely.com/customization-and-integration/00_ann_format_navi/02_project_classes_and_tags" target="_blank">here</a>.

## Individual Video Annotations

For each video, we store the annotations in a separate `json` file named `video_name.video_format.json` with the following file structure:

![](videos/video_example1.jpg)

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
                [266, 420],
                [847, 845]
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

- `size` - string - is equal to image(frame) size
- `description` - string - (optional) - this field is used to store the text we want to assign to the video. In the labeling intrface it corresponds to the 'data' filed.
- `tags` - **list** of strings that will be interpreted as video <a href="https://docs.supervisely.com/customization-and-integration/00_ann_format_navi/03_supervisely_format_tags" target="_blank">tags</a>
- `key` - string, unique key for a given video (used in key_id_map.json to get the video ID)
- `objects` - **list** of <a href="https://docs.supervisely.com/customization-and-integration/00_ann_format_navi/04_supervisely_format_objects" target="_blank">objects on the video</a>
- `frames` - **list** of frames of which the video consists. List contains only frames with an object from the 'objects' field
  - `index` - integer - number of the current frame
  - `figures` - integer - list of objects which the current frame contains
- `framesCount` - integer - total number of frames in the video
- `objectKey` - string - unique key for a given object (used in key_id_map.json)
- `labelerLogin` - string - the name of a user who created the current figure
- `geometryType` - "cuboid_3d" - class shape
- `geometry` - a dictionary containing indicators of location, rotation and dimensions of cuboids

**Fields definitions for objects field:**

- `key` - string, a unique key for the given object (used in key_id_map.json to get the object ID)
- `classTitle` - string - the title of a class. It's used to identify the class shape from the `meta.json` file
- `tags` - list of strings that will be interpreted as object tags
- `labelerLogin` - string - the name of the user that added this figure to the project

**Fields description for figures field:**

- `key` - string, a unique key for the given figure (used in key_id_map.json to get the figure ID)
- `objectKey` - string, a unique key for the given object (used in key_id_map.json to get the object ID).
- `geometryType` - "rectangle" -class shape
- `geometry` - geometry of the object
- `classTitle` - string - the title of a class. It's used to identify the class shape from the `meta.json` file
- `labelerLogin` - string - the name of the user that added this figure to the current frame

### Key id map file

Key_id_map.json file is optional. It is created when annotating the video inside Supervisely interface and sets the correspondence between the unique identifiers of the video, object and the frame on which the object is located. If you annotate manually, you do not need to create this file. This will not affect the work being done.

Json format of key_id_map.json:

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

- `objects` - dictionary, where the key is a unique string, generated inside Supervisely environment to set correspondence of current object in annotation, and values are unique integer ID corresponding to the current object
- `figures` - dictionary, where the key is a unique string, generated inside Supervisely environment to set correspondence of object on current frame in annotation, and values are unique integer ID corresponding to the current frame
- `videos` - dictionary, where the key is unique string, generated inside Supervisely environment to set correspondence of video in annotation, and value is a unique integer ID corresponding to the current video
- `tags` - dictionary, where the keys are unique strings, generated inside Supervisely environment to set correspondence of tag on current frame in annotation, and values are a unique integer ID corresponding to the current tag

## Useful links

- <a href="https://docs.supervisely.com/customization-and-integration/00_ann_format_navi" target="_blank">Supervisely Annotation Format</a>
- <a href="https://docs.supervisely.com/customization-and-integration/00_ann_format_navi/06_supervisely_format_videos" target="_blank">Supervisely Video Annotation</a>
- <a href="https://developer.supervisely.com/getting-started/command-line-interface/sdk-cli#upload-a-project" target="_blank">[SDK CLI] Upload projects in Supervisely format</a>
- <a href="https://developer.supervisely.com/getting-started/command-line-interface/cli-tool/workflow-automation#upload-projects-in-supervisely-format" target="_blank">[CLI Tool Beta] Upload projects in Supervisely format</a>
- <a href="https://ecosystem.supervisely.com/apps/import-videos-in-sly-format" target="_blank">[Supervisely Ecosystem] Import video in Supervisely format</a>