# Overview

{% hint style="success" %}
Easily import your pointcloud episodes with annotations in the Supervisely format. The Supervisely json-based annotation format supports `cuboid_3d` shape figures. It is a universal format that supports various types of annotations and is used in the Supervisely platform.
{% endhint %}

{% hint style="info" %}
All information about the Supervisely JSON format can be found <a href="https://docs.supervise.ly/data-organization/00_ann_format_navi" target="_blank">here</a>
{% endhint %}

# Format description

**Supported point cloud format:** `.pcd`<br>
**With annotations:** yes<br>
**Supported annotation format:** `.json`.<br>
**Data structure:** Information is provided below.

# Input files structure

{% hint style="success" %}
Example data: [download ⬇️](https://github.com/supervisely-ecosystem/demo-kitti-3d-episodes/releases/download/v0.0.1/demo_kitti_pointcloud_episodes.zip).
{% endhint %}

Both directory and archive are supported.

**Recommended directory structure:**

Root folder for the project named `project name`

- `meta.json` file
- `key_id_map.json` file
- Dataset folders, that represents single episode. Each named `dataset_name`, which contains:
  - `annotation.json` - file with whole episode annotation
  - `frame_pointcloud_map.json` - file with pointcloud to episode frame mapping
  - `pointcloud` folder, contains source point cloud files, for example `frame1.pcd, frame2.pcd`
  - `related_images` optional folder, contains photo-context data:
    - Frame folder, each named according to pointcloud (`/related_images/frame1/`), which contains:
      - image files (`.png \ .jpg`)
      - photo context image annotation file (`.json`) - json files, named according to image name (`1.png -> 1.png.json`). Read more in the "Photo context image annotation file" section below.

# Format of Annotations

```json
{
  "description": "",
  "key": "e9f0a3ae21be41d08eec166d454562be",
  "tags": [],
  "objects": [
    {
      "key": "6663ca1d20c74bea83bd48c24568989d",
      "classTitle": "car",
      "tags": []
    }
  ],
  "framesCount": 48,
  "frames": [
    {
      "index": 0,
      "figures": [
        {
          "key": "cb8e067dadfc423aa8575a0c4e62de33",
          "objectKey": "6663ca1d20c74bea83bd48c24568989d",
          "geometryType": "cuboid_3d",
          "geometry": {
            "position": {
              "x": -10.863547325134277,
              "y": -93.57706451416016,
              "z": -4.598618030548096
            },
            "rotation": {
              "x": 0,
              "y": 0,
              "z": 3.250733629393711
            },
            "dimensions": {
              "x": 1.978,
              "y": 4.607,
              "z": 1.552
            }
          }
        }
      ]
    },
    {
      "index": 1,
      "figures": [
        {
          "key": "71e0fe52dc4f4f6aaf059ad095f43c1f",
          "objectKey": "6663ca1d20c74bea83bd48c24568989d",
          "labelerLogin": "username",
          "updatedAt": "2021-11-11T17:19:11.448Z",
          "createdAt": "2021-11-11T16:53:03.670Z",
          "geometryType": "cuboid_3d",
          "geometry": {
            "position": {
              "x": -11.10418701171875,
              "y": -91.33098602294922,
              "z": -4.5446248054504395
            },
            "rotation": {
              "x": 0,
              "y": 0,
              "z": 3.24780199600921
            },
            "dimensions": {
              "x": 1.978,
              "y": 4.607,
              "z": 1.552
            }
          }
        }
      ]
    }
  ]
}
```

**Optional fields and loading**
These fields are optional and are not needed when loading the project.
The server can automatically fill in these fields while project is loading.

- `id` - unique identifier of the current object
- `classId` - unique class identifier of the current object
- `labelerLogin` - string - the name of user who created the current figure
- `createdAt` - string - date and time of figure creation
- `updatedAt` - string - date and time of the last figure update

Main idea of `key` fields and `id` you can see below in "Key id map file" section.

**Fields definitions:**

- `description` - string - (optional) - this field is used to store the text to assign to the sequence.
- `key` - string, unique key for a given sequence (used in key_id_map.json to get the sequence ID)
- `tags` - list of strings that will be interpreted as episode tags
- `objects` - list of objects that may be present on the episode
- `frames` - list of frames of which the episode consists. List contains only frames with an object from the 'objects' field
  - `index` - integer - number of the current frame
  - `figures` - list of figures in the current frame.
- `framesCount` - integer - total number of frames in the episode
- `geometryType` - "cuboid_3d" - class shape

**Fields definitions for `objects` field:**

- `key` - string - unique key for a given object (used in key_id_map.json)
- `classTitle` - string - the title of a class. It's used to identify the class shape from the `meta.json` file
- `tags` - list of strings that will be interpreted as object tags (can be empty)

**Fields description for `figures` field:**

- `key` - string - unique key for a given figure (used in key_id_map.json)
- `objectKey` - string - unique key to link figure to object (used in key_id_map.json)
- `geometryType` - "cuboid_3d" -class shape
- `geometry` - geometry of the object

**Description for `geometry` field:**

- `position` 3D vector X, Y, Z values matches the axes on world coordinates, defined in global frame of reference as:

  - **+x** - forward in the direction of travel ego vehicle
  - **+y** - left
  - **+z** - up

- `dimensions` is 3D vector with:

  - **x** - width
  - **y** - length
  - **z** - height

- `rotation`is 3D Vector with:
  - **x** - pitch
  - **y** - roll
  - **z** - yaw (direction)

Rotation values bound inside \[**-pi** ; **pi** ]
When `yaw = 0` box direction will be strict `+y`

## Key id map file

You can avoid using key-id-map directly with API and SDK to create your own file structure.

The basic idea behind key-id-map is that it maps the unique identifiers of the object to the frame on which the shape is located. The server works with an identifier, but the file system of the loaded project stores these identifiers and object keys on disk, which is necessary for navigation and use of the high-level API and applications.

When loading a `dataset` (sequence), the system returns its identifier, after which it is saved to a file on disk, along with the key of the loaded sequence in key-id-map file.

When uploading `objects` to the server, a sequence ID is required (to determine which sequence the object belongs to), and it can be read from the key-id-map file by key. The system then returns the IDs of the successfully loaded objects.

Then, while `figures` uploading to the server, an object identifier is required (which loaded object the shape belongs to), which can again be read from the key-id-map file.

While annotating the episode inside Supervisely interface key-id-map file is created automatically, and will be downloaded with the entire project.
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
    "e9f0a3ae21be41d08eec166d454562be": 42656
  }
}
```

- `objects` - dictionary, where the key is a unique string, generated inside Supervisely environment to set correspondence of current object in annotation, and values are unique integer ID corresponding to the current object
- `figures` - dictionary, where the key is a unique string, generated inside Supervisely environment to set correspondence of object on current frame in annotation, and values are unique integer ID corresponding to the current frame
- `videos` - dictionary, where the key is unique string, generated inside Supervisely environment to set correspondence of sequence (dataset) in annotation, and value is a unique integer ID corresponding to the current sequence
- `tags` - dictionary, where the keys are unique strings, generated inside Supervisely environment to set correspondence of tag on current frame in annotation, and values are a unique integer ID corresponding to the current tag

- **Key** - <a href="https://docs.python.org/3/library/uuid.html#uuid.uuid4" target="_blank">generated by python3 function `uuid.uuid4().hex`</a>. The unique string. All key values and id's should be unique inside single project and can not be shared between frames\sequences.
- **Value** - returned by server integer identifier while uploading object / figure / sequence / tag

## Format of frame_pointcloud_map.json

This file set mapping between pointcloud files and annotation frames in the correct order.

```json
{
  "0": "frame1.pcd",
  "1": "frame2.pcd",
  "2": "frame3.pcd"
}
```

**Keys** - frame order number\
**Values** - point cloud name (with extension)

## Photo context image annotation file

```json
    {
        "name": "host-a005_cam4_1231201437716091006.jpeg"
        "entityId": 2359620,
        "meta": {
            "deviceId": "CAM_BACK_LEFT",
            "timestamp": "2019-01-11T03:23:57.802Z",
            "sensorsData": {
                "extrinsicMatrix": [
                    -0.8448329028461443,
                    -0.5350302199120708,
                    0.00017334762588639086,
                    -0.012363736761232369,
                    -0.0035124448582330757,
                    0.005222293412494302,
                    -0.9999801949951969,
                    -0.16621728572112304,
                    0.5350187183638307,
                    -0.8448167798004226,
                    -0.006291229448121315,
                    -0.3527897896721229
                ],
                "intrinsicMatrix": [
                    882.42699274,
                    0,
                    602.047851885,
                    0,
                    882.42699274,
                    527.99972239,
                    0,
                    0,
                    1
                ]
            }
        }
    }
```

**Fields description:**

- name - string - Name of image file
- Id - (OPTIONAL) - integer >= 1 ID of the photo in the system. It is not required when upload and is filled in automatically when the project is loaded.
- entityId (OPTIONAL) - integer >= 1 ID of the Point Cloud in the system, that photo attached to. Doesn't required while uploading.
- deviceId - string- Device ID or name.
- timestamp - string <date-time> - Time when the frame occurred in ISO 8601 format
- sensorsData - Sensors data such as Pinhole camera model parameters. See wiki: <a href="https://en.wikipedia.org/wiki/Pinhole_camera_model" target="_blank">Pinhole camera model</a> and <a href="https://docs.opencv.org/2.4/modules/calib3d/doc/camera_calibration_and_3d_reconstruction.html" target="_blank">OpenCV docs for 3D reconstruction</a>.
  - intrinsicMatrix - Array of number <float> - 3x3 flatten matrix (dropped last zeros column) of intrinsic parameters in row-major order, also called camera matrix. It's used to denote camera calibration parameters. See <a href="https://en.wikipedia.org/wiki/Camera_resectioning#Intrinsic_parameters" target="_blank">Intrinsic parameters</a>.
  - extrinsicMatrix - Array of number <float> - 4x3 flatten matrix (dropped last zeros column) of extrinsic parameters in row-major order, also called joint rotation-translation matrix. It's used to denote the coordinate system transformations from 3D world coordinates to 3D camera coordinates. See <a href="https://en.wikipedia.org/wiki/Camera_resectioning#Extrinsic_parameters" target="_blank">Extrinsic_parameters</a>.

# Useful links

- <a href="https://docs.supervisely.com/customization-and-integration/00_ann_format_navi" target="_blank">Supervisely Annotation Format</a>
- <a href="https://docs.supervisely.com/customization-and-integration/00_ann_format_navi/07_supervisely_format_pointcloud_episode#sdk" target="_blank">Supervisely Pointcloud Episodes Annotation</a>
- <a href="https://developer.supervisely.com/getting-started/command-line-interface/sdk-cli#upload-a-project" target="_blank">[SDK CLI] Upload projects in Supervisely format</a>
- <a href="https://developer.supervisely.com/getting-started/command-line-interface/cli-tool/workflow-automation#upload-projects-in-supervisely-format" target="_blank">[Supervisely Ecosystem] Import Pointcloud Episodes in Supervisely</a>
