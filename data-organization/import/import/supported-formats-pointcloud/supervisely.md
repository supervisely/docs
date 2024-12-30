<h1 align="left" style="border-bottom: 0"> <img align="left" src="https://github.com/supervisely-ecosystem/import-wizard-docs/releases/download/v0.0.1/sly_logo.png" width="80" style="padding-right: 20px;"> Supervisely Format </h1>

# Overview

Easily import your pointclouds with annotations in the Supervisely format. The Supervisely json-based annotation format supports `cuboid_3d` shape figures. It is a universal format that supports various types of annotations and is used in the Supervisely platform.

> All information about the Supervisely JSON format can be found <a href="https://docs.supervisely.com/data-organization/00_ann_format_navi" target="_blank">here</a>

# Format description

**Supported point cloud format:** `.pcd`<br>
**With annotations:** yes<br>
**Supported annotation format:** `.json`.<br>
**Data structure:** Information is provided below.

# Input files structure

Example data: [download ⬇️](https://github.com/supervisely-ecosystem/demo-pointcloud-project-annotated/releases/download/v0.0.1/demo_pointcloud_project_annotated.zip).

Both directory and archive are supported.

**Recommended directory structure:**

```
📦pointcloud_project (folder or .tar/.zip archive)
├──📄key_id_map.json (optional)
├──📄meta.json
├──📂dataset1
│ ├──📂pointcloud
│ │ ├──📄scene_1.pcd
│ │ ├──📄scene_2.pcd
│ │ └──📄...
│ ├──📂related_images
│ │   ├──📂scene_1_pcd
│ │   │ ├──🏞️scene_1_cam0.png
│ │   │ ├──📄scene_1_cam0.png.json
│ │   │ ├──🏞️scene_1_cam1.png
│ │   │ ├──📄scene_1_cam1.png.json
│ │   │ └──📄...
│ │   ├──📂scene_2_pcd
│ │   │ ├──🏞️scene_2_cam0.png
│ │   │ ├──📄scene_2_cam0.png.json
│ │   │ ├──🏞️scene_2_cam1.png
│ │   │ ├──📄scene_2_cam1.png.json
│ │   │ └──📄...
│ │   └──📂...
│ └──📂ann
│     ├──📄scene_1.pcd.json
│     ├──📄scene_2.pcd.json
│     └──📄...
└──📂dataset...
```

Every `.pcd` file in a sequence has to be stored inside a `pointcloud` folder of datasets.

| Key | Value                                                     |
| --- | --------------------------------------------------------- |
| x   | The x coordinate of the point.                            |
| y   | The y coordinate of the point.                            |
| z   | The z coordinate of the point.                            |
| r   | The red color channel component. An 8-bit value (0-255).  |
| g   | The green color channel component. An 8-bit value (0-255) |
| b   | The blue color channel component. An 8-bit value (0-255)  |

All the positional coordinates (x, y, z) are in meters. Supervisely supports all PCD encoding: ASCII, binary, binary_compressed.

The PCD file format description can be found <a href="https://pointclouds.org/documentation/tutorials/pcd_file_format.html" target="_blank">here</a>

`related_images` optional folder, contains photo-context data:
    - Frame folder, each named according to pointcloud (`/related_images/scene_1_pcd/`), which contains:
      - image files (`.png \ .jpg`)
      - photo context image annotation file (`.json`) - json files, named according to image name (`1.png -> 1.png.json`). Read more in the "Photo context image annotation file" section below.

# Format of Annotations

Point cloud Annotations refer to each point cloud and contains information about labels on the point clouds in the datasets.

A dataset has a list of `objects` that can be shared between some point clouds.

The list of `objects` is defined for the entire dataset, even if the object's figure occurs in only one point cloud.

`Figures` represents individual labels, attached to one single frame and its object.

```json
{
  "description": "",
  "key": "e9f0a3ae21be41d08eec166d454562be",
  "tags": [],
  "objects": [
    {
      "key": "ecb975d70735486b90fe4fdd2be77e3b",
      "classTitle": "Car",
      "tags": [],
      "labelerLogin": "admin",
      "updatedAt": "2022-05-04T00:32:30.872Z",
      "createdAt": "2022-05-04T00:32:30.872Z"
    }
  ],
  "figures": [
    {
      "key": "abbaec8785c1468585f6210c62bb2374",
      "objectKey": "ecb975d70735486b90fe4fdd2be77e3b",
      "geometryType": "cuboid_3d",
      "geometry": {
        "position": {
          "x": 58.756710052490234,
          "y": 4.623323917388916,
          "z": -0.4174150526523591
        },
        "rotation": {
          "x": 0,
          "y": 0,
          "z": -1.77
        },
        "dimensions": {
          "x": 1.59,
          "y": 4.28,
          "z": 1.45
        }
      },
      "labelerLogin": "admin",
      "updatedAt": "2022-05-04T00:32:37.432Z",
      "createdAt": "2022-05-04T00:32:37.432Z"
    }
  ]
}
```

**Optional fields and loading** These fields are optional and are not needed when loading the project. The server can automatically fill in these fields while project is loading.

- `id` - unique identifier of the current object
- `classId` - unique class identifier of the current object
- `labelerLogin` - string - the name of user who created the current figure
- `createdAt` - string - date and time of figure creation
- `updatedAt` - string - date and time of the last figure update

Main idea of `key` fields and `id` you can see below in "Key id map" file section.

**Fields definitions:**

- `description` - string - (optional) - this field is used to store the text to assign to the sequence.
- `key` - string, unique key for a given sequence (used in key_id_map.json to get the sequence ID)
- `tags` - list of strings that will be interpreted as point cloud tags
- `objects` - list of objects that may be present on the dataset
- `geometryType` - "cuboid_3d" or other 3D geometry - class shape

**Fields definitions for `objects` field:**

- `key` - string - unique key for a given object (used in key_id_map.json)
- `classTitle` - string - the title of a class. It's used to identify the class shape from the `meta.json` file
- `tags` - list of strings that will be interpreted as object tags (can be empty)

**Fields description for `figures` field:**

- `key` - string - unique key for a given figure (used in key_id_map.json)
- `objectKey` - string - unique key to link figure to object (used in key_id_map.json)
- `geometryType` - "cuboid_3d" or other 3D geometry -class shape
- `geometry` - geometry of the object

**Description for `geometry` field (cuboid_3d):**

- `position` 3D vector of box center coordinates:
  - **x** - forward in the direction of the object
  - **y** - left
  - **z** - up
- `dimensions` is a 3D vector that scales a cuboid from its local center along x, y, z:
  - **x** - width
  - **y** - length
  - **z** - height
- `rotation` is a 3D Vector that rotates a cuboid along an axis in world space:
  - **x** - pitch
  - **y** - roll
  - **z** - yaw (direction)

Rotation values bound inside \[**-pi** ; **pi**] When `yaw = 0` box direction will be strict `+y`

Read more about the `key_id_map.json` file and photo context annotations in the documentation <a href="https://developer.supervisely.com/getting-started/supervisely-annotation-format/point-clouds#key-id-map-file" target="_blank">here</a>.

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
- <a href="https://developer.supervisely.com/getting-started/supervisely-annotation-format/point-clouds" target="_blank">Supervisely Pointcloud Annotation</a>
- <a href="https://developer.supervisely.com/getting-started/command-line-interface/cli-tool/workflow-automation#upload-projects-in-supervisely-format" target="_blank">[CLI Tool Beta] Upload projects in Supervisely format</a>
- <a href="https://developer.supervisely.com/getting-started/command-line-interface/sdk-cli#upload-a-project" target="_blank">[SDK CLI] Upload projects in Supervisely format</a>
- <a href="https://ecosystem.supervisely.com/apps/import-pointcloud-project" target="_blank">Import Point Cloud Project</a> app.
- <a href="https://ecosystem.supervisely.com/apps/export-pointclouds-project-in-supervisely-format" target="_blank">Export pointclouds project in Supervisely format</a> app.
- <a href="https://ecosystem.supervisely.com/projects/demo-pointcloud-project-annotated" target="_blank">Demo pointcloud project with labels</a>
