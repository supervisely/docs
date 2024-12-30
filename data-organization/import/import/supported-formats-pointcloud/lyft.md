<h1 align="left" style="border-bottom: 0"> LYFT Format </h1>

# Overview

Easily import your pointclouds with annotations in the LYFT format. LYFT is an annotation format used in the well-regarded `Lyft Level 5 Prediction` dataset. 

Originaly, the dataset is suited to be imported as Pointcloud Episodes, even though it is available in Pointcloud format as well.

# Format description

**Supported point cloud format:** `.bin`<br>
**With annotations:** yes<br>
**Supported annotation format:** `.json`<br>
**Data structure:** Information is provided below.

# Input files structure

Example data: [download ⬇️](https://github.com/supervisely/docs/releases/download/v0.0.1/lyft-sample.zip).

Both directory and archive are supported.

**Format directory structure:**

```
📦pointcloud_project (folder or .tar/.zip archive)
├──📂dataset1
│ ├──📂data
│ │ ├──📄attribute.json
│ │ ├──📄calibrated_sensor.json
│ │ ├──📄category.json
│ │ ├──📄ego_pose.json
│ │ ├──📄instance.json
│ │ ├──📄log.json
│ │ ├──📄map.json
│ │ ├──📄sample.json
│ │ ├──📄sample_annotation.json
│ │ ├──📄sample_data.json
│ │ ├──📄scene.json
│ │ ├──📄sensor.json
│ │ └──📄visibility.json
│ ├──📂images
│ │ ├──🏞️host-a101_cam0_0000000000000000001.jpeg
│ │ ├──🏞️host-a101_cam0_0000000000000000002.jpeg
│ │ ├──🏞️host-a101_cam0_0000000000000000003.jpeg
│ │ ├──🏞️host-a101_cam0_0000000000000000004.jpeg
│ │ ├──🏞️host-a101_cam0_0000000000000000005.jpeg
│ │ └──🏞️...
│ ├──📂lidar
│ │ ├──📄host-a101_lidar1_1241893239302414726.bin
│ │ ├──📄host-a101_lidar1_1241893239302414727.bin
│ │ ├──📄host-a101_lidar1_1241893239302414728.bin
│ │ ├──📄host-a101_lidar1_1241893239302414729.bin
│ │ ├──📄host-a101_lidar1_1241893239302414730.bin
│ │ └──📄...
│ └──📂maps
└──   └──🏞️map_raster_palo_alto.png
```

Every `.bin` file in a sequence has to be stored inside a `lidar` folder of dataset.

| Key | Value                                                     |
| --- | --------------------------------------------------------- |
| x   | The x coordinate of the point.                            |
| y   | The y coordinate of the point.                            |
| z   | The z coordinate of the point.                            |
| i   | Intensity of the return signal.                           |
| r   | Ring index.                                               |

The LYFT format description can be found <a href="https://mmdetection3d.readthedocs.io/en/stable/advanced_guides/datasets/lyft.html" target="_blank">here</a>

# LYFT Annotation format

The original LYFT dataset's annotations are token-based. The dataset is composed of dozens of scenes, each consisting of 126 point cloud frames, named samples. Samples are linked to annotation data through the use of unique identifiers, known as tokens. These tokens ensure that each point cloud frame is accurately associated with its corresponding annotations, maintaining the integrity and structure of the dataset.

### `attribute.json`

The `attribute.json` file contains metadata about the attributes of objects in the dataset. Each entry includes a unique token, a name, and a description of the attribute.

Content example:
```json
{
  "description": "",
  "token": "f5081f1e5aa941f9d9f727ad186c8db67b916336f975a2f5d65d14ea01ed098f",
  "name": "object_action_lane_change_right"
},
{
  "token": "1b388c1f5e5149ae173ad3d674e7ad7f1847e213173d14ce5ecf431ad697ca17",
  "description": "",
  "name": "object_action_running"
},
{
  "description": "",
  "token": "17d61007ee69782e0ad8ffa5f8cd4c075f18b4b09e11f0e966bc27026c7929ea",
  "name": "object_action_lane_change_left"
}
```

### `calibrated_sensor.json`

The `calibrated_sensor.json` file contains calibration data for each sensor used in the dataset. This includes information about the sensor's position, orientation, and intrinsic parameters. Each entry in the file is associated with a unique sensor token.

Content example:
```json
{
  "sensor_token": "172a55e2b50f18a6b6d545369a457003c2f3b438d0180b2b4c7819ca29b3f6ab",
  "rotation": [
    -0.4944743277529699,
    0.5037402715904608,
    0.5076908453442883,
    -0.49395433344067297
  ],
  "camera_intrinsic": [
    [
      1112.8384901,
      0,
      958.488205774
    ],
    [
      0,
      1112.8384901,
      539.540735426
    ],
    [
      0,
      0,
      1
    ]
  ],
  "translation": [
    0.8201327486252449,
    -0.002437920474569259,
    1.6531257722973938
  ],
  "token": "59155106c0ac5abe83cb6558ad8ce98400e3c3abf51234734bc89bc9d613470a"
}
```

### `category.json`

The `category.json` file contains metadata about the categories of objects in the dataset. Each entry includes a unique token, a name, and a description of the category.

Contents example:
```json
{
  "description": "",
  "token": "8eccddb83fa7f8f992b2500f2ad658f65c9095588f3bc0ae338d97aff2dbcb9c",
  "name": "car"
},
{
  "description": "",
  "token": "73e8de69959eb9f5b4cd2859e74bec4b5491417336cad63f27e8edb8530ffbf8",
  "name": "pedestrian"
},
{
  "description": "",
  "token": "f81f51e1897311b55c0c6247c3db825466733e08df687c0ea830b026316a1c12",
  "name": "animal"
}
```

### `ego_pose.json`

The `ego_pose.json` file contains the position and orientation of the ego vehicle at each timestamp. Each entry includes a unique token, rotation, translation, and timestamp.

Entry example:
```json
{
  "rotation": [
    -0.6004078747001649,
    -0.0008682874404776075,
    0.0018651459228554213,
    0.7996912850004297
  ],
  "translation": [
    1007.2332778546739,
    1725.4217301399474,
    -24.580000733806127
  ],
  "token": "0c257254dad346c9d90f7970ce2c0b8142f7c6e6a90716f4c0538cd2d2ef77d5",
  "timestamp": 1557858039302414.8
}
```

### `instance.json`

The `instance.json` file contains metadata about each instance in the dataset. Each entry includes a unique token, category token, and tokens linking to the first and last annotations of the instance. The file also includes the number of annotations associated with each instance.

Content example:
```json
{
  "last_annotation_token": "36a6954dcf400dcca8a25353939f106c09d43fcd40a3ba18add54bd149e8afb5",
  "category_token": "8eccddb83fa7f8f992b2500f2ad658f65c9095588f3bc0ae338d97aff2dbcb9c",
  "token": "695097711d9ec763b55f24d04ae9eb51289575645968f00723cee666a9f68c27",
  "first_annotation_token": "2a03c42173cde85f5829995c5851cc81158351e276db493b96946882059a5875",
  "nbr_annotations": 92
}
```

### `log.json`

The `log.json` file contains metadata about the logging information for each scene in the dataset. Each entry includes a unique token, the date the data was captured, the location, the vehicle used, and a token linking to the corresponding map.

```json
{
  "date_captured": "2019-05-14",
  "location": "Palo Alto",
  "token": "da4ed9e02f64c544f4f1f10c6738216dcb0e6b0d50952e158e5589854af9f100",
  "vehicle": "a101",
  "logfile": "",
  "map_token": "53992ee3023e5494b90c316c183be829"
}
```

### `map.json`

The `map.json` file contains metadata about the maps used in the dataset. Each entry represents a single map and includes a unique token, the filename of the map image, the category of the map, and a list of tokens linking to the logs associated with the map itself.

Content example:
```json
  {
    "log_tokens": [
      "da4ed9e02f64c544f4f1f10c6738216dcb0e6b0d50952e158e5589854af9f100",
      "0a6839d6ee6804113bb5591ed99cc70ad883d0cff396e3aec5e76e718771b30e",
      "a939e6edc494777d058c3b1eafb91a7236f6b4ff5e98c9abb1216046a0b3a45f",
      "25721546712bf8ba8729d88992ba2a72ed04918ffda3081cbefe3e1a6c02173f",
      "71dfb15d2f88bf2aab2c5d4800c0d10a76c279b9fda98720781a406cbacc583b",
      "5fbada2dc96f8ae4485af83535d63c24a3116262ae94edd69c4185166d4c5e0e",
      "47ce1d46dc84a54949a350ff4e0cc855fb0cd8ab02246951a10a95ed6b0f863e",
      "b28b767dac46db1659065a51d6453129eeb82bf397fdbb779de95414090d6842",
      "d23bc414dd4c48a55e24d80d86cc54f393ea20649f381af567b53644b761b40a"
    ],
    "token": "53992ee3023e5494b90c316c183be829",
    "filename": "maps/map_raster_palo_alto.png",
    "category": "semantic_prior"
  }
```

### `sample.json`

The `sample.json` file contains metadata about each sample in the dataset. Each sample represents a single point cloud frame and includes tokens linking to related data such as annotations and sensor data. The file also includes information about the sample's position in the sequence and the associated scene.

Single entry example:
```json
{
  "next": "",
  "prev": "",
  "token": "24b0962e44420e6322de3f25d9e4e5cc3c7a348ec00bfa69db21517e4ca92cc8",
  "timestamp": 1557858039302414.8,
  "scene_token": "da4ed9e02f64c544f4f1f10c6738216dcb0e6b0d50952e158e5589854af9f100",
  "data": {
    "CAM_BACK": "542a9e44f2e26221a6aa767c2a9b90a9f692c3aee2edb7145256b61e666633a4",
    "CAM_FRONT_ZOOMED": "9c9bc711d93d728666f5d7499703624249919dd1b290a477fcfa39f41b26259e",
    "LIDAR_FRONT_RIGHT": "8cfae06bc3d5d7f9be081f66157909ff18c9f332cc173d962460239990c7a4ff",
    "CAM_FRONT": "fb40b3b5b9d289cd0e763bec34e327d3317a7b416f787feac0d387363b4d00f0",
    "CAM_FRONT_LEFT": "f47a5d143bcebb24efc269b1a40ecb09440003df2c381a69e67cd2a726b27a0c",
    "CAM_FRONT_RIGHT": "5dc54375a9e14e8398a538ff97fbbee7543b6f5df082c60fc4477c919ba83a40",
    "CAM_BACK_RIGHT": "ae8754c733560aa2506166cfaf559aeba670407631badadb065a9ffe7c337a7d",
    "CAM_BACK_LEFT": "01c0eecd4b56668e949143e02a117b5683025766d186920099d1e918c23c8b4b",
    "LIDAR_TOP": "ec9950f7b5d4ae85ae48d07786e09cebbf4ee771d054353f1e24a95700b4c4af",
    "LIDAR_FRONT_LEFT": "5c3d79e1cf8c8182b2ceefa33af96cbebfc71f92e18bf64eb8d4e0bf162e01d4"
  },
  "anns": [
    "2a03c42173cde85f5829995c5851cc81158351e276db493b96946882059a5875",
    "c3c663ed5e7b6456ab27f09175743a551b0b31676dae71fbeef3420dfc6c7b09",
    "4193e4bf217c8a0ff598d792bdd9d049b496677d5172e38c1ed22394f20274fb",
    "f543b455c7066d7054ed5218670b4432a3fc7a0f57cadb0cb59aa96e8dd1a135",
    "6ef405e1f47a4a234f0bfeeb559d61c70031af6c47bf2e499a31002f845cd403",
    "db7413e79e7df6de53d801e96e26c494caf1d5b709da85aa7bf04e42c76609f5",
    "40eb44f0b586f2b41fb962adca2c1de351b70f3577a382798db2735564566a33",
    "1ab21da1d6f6d88107a5b067ba1f40929a47ae414b72e8bc17d774f281776cb2",
    "3d7bdcb0c99a5ba50cc74b9b9194fe4f2fdfa82a078c8afa561eec9afad052f9",
    "4e00f88a86a5ae6a015d0a58027a280db2aebf13d4626875c877d23cca553d8d",
    "64e6ea3476f64420c76db21b2fa4ec589def2c05ad97d2574ea63f8f0f7f22c9"
  ]
}
```

### `sample_annotation.json`

The `sample_annotation.json` file contains detailed information about each annotation in the dataset. This includes the size, position, and orientation of the annotated objects, as well as tokens linking to related data such as attributes and instances. Each entry in the file represents an instance annotation.

Single entry example:
```json
{
  "token": "2a03c42173cde85f5829995c5851cc81158351e276db493b96946882059a5875",
  "num_lidar_pts": -1,
  "size": [
    1.997,
    5.284,
    1.725
  ],
  "sample_token": "24b0962e44420e6322de3f25d9e4e5cc3c7a348ec00bfa69db21517e4ca92cc8",
  "rotation": [
    0.1539744509331139,
    0,
    0,
    0.9880748293827983
  ],
  "prev": "",
  "translation": [
    1048.155950230245,
    1691.8102354006162,
    -23.304943447792454
  ],
  "num_radar_pts": 0,
  "attribute_tokens": [
    "1ba8c9a8bda54423fa710b0af1441d849ecca8ed7b7f9393ba1794afe4aa6aa2",
    "daf16a3f6499553cc5e1df4a456de5ee46e2e6b06544686d918dfb1ddb088f6f"
  ],
  "next": "9986dac1bcecb560153ab58ae7560028caeed3c1e067b37503cf50932e983afc",
  "instance_token": "695097711d9ec763b55f24d04ae9eb51289575645968f00723cee666a9f68c27",
  "visibility_token": "",
  "category_name": "car"
}
```

### `sample_data.json`

The `sample_data.json` file contains metadata about each data sample in the dataset. This includes information about the sensor used to capture the data, the file format, and the associated tokens for calibration and ego pose. Each entry in the file represents a single data sample, linking it to the corresponding point cloud or image file.

Single entry example:
```json
{
  "width": 1920,
  "height": 1080,
  "calibrated_sensor_token": "59155106c0ac5abe83cb6558ad8ce98400e3c3abf51234734bc89bc9d613470a",
  "token": "542a9e44f2e26221a6aa767c2a9b90a9f692c3aee2edb7145256b61e666633a4",
  "sample_token": "24b0962e44420e6322de3f25d9e4e5cc3c7a348ec00bfa69db21517e4ca92cc8",
  "is_key_frame": true,
  "prev": "",
  "fileformat": "jpeg",
  "ego_pose_token": "0c257254dad346c9d90f7970ce2c0b8142f7c6e6a90716f4c0538cd2d2ef77d5",
  "timestamp": 1557858039200000,
  "next": "8d614daa8d1d48d3af4a0c817b676da1cb3e68f1432296eb52cfc428d0ff4d6d",
  "filename": "images/host-a101_cam3_1241893239200000006.jpeg",
  "sensor_modality": "camera",
  "channel": "CAM_BACK"
}
```

### `scene.json`

The `scene.json` file contains metadata about each scene in the dataset. Each scene is a sequence of point cloud frames captured over a period of time. The file includes tokens linking to the first and last samples in the scene, the number of samples, and a description.

Entry example:
```json
{
  "log_token": "da4ed9e02f64c544f4f1f10c6738216dcb0e6b0d50952e158e5589854af9f100",
  "first_sample_token": "24b0962e44420e6322de3f25d9e4e5cc3c7a348ec00bfa69db21517e4ca92cc8",
  "name": "host-a101-lidar0-1241893239199111666-1241893264098084346",
  "description": "",
  "last_sample_token": "2346756c83f6ae8c4d1adec62b4d0d31b62116d2e1819e96e9512667d15e7cec",
  "nbr_samples": 126,
  "token": "da4ed9e02f64c544f4f1f10c6738216dcb0e6b0d50952e158e5589854af9f100"
}
```

### `sensor.json`

The `sensor.json` file contains metadata about each sensor used in the dataset. This includes information about the sensor's modality (e.g., camera, lidar), the channel it corresponds to, and a unique token for each sensor.

Example entries:
```json
{
  "modality": "camera",
  "channel": "CAM_BACK",
  "token": "172a55e2b50f18a6b6d545369a457003c2f3b438d0180b2b4c7819ca29b3f6ab"
},
{
  "modality": "camera",
  "channel": "CAM_FRONT_ZOOMED",
  "token": "286718e1fbc8c8f0ca441969d91c36a8a809666e049e54ce121636100b520946"
},
{
  "modality": "lidar",
  "channel": "LIDAR_FRONT_RIGHT",
  "token": "953faed96fd3d2fae3ec03cd2838b312b8c1a9bb7a0629481982870cb28acb67"
}
```

### `visibility.json`

The `visibility.json` file contains information about the visibility levels of objects in the dataset. Each entry specifies a visibility level, a description of what that level represents, and a unique token.

Original dataset's file contents:
```json
[
  {
    "level": "v60-80",
    "description": "visibility of whole object is between 60 and 80%",
    "token": "3"
  },
  {
    "level": "v0-40",
    "description": "visibility of whole object is between 0 and 40%",
    "token": "1"
  },
  {
    "level": "v40-60",
    "description": "visibility of whole object is between 40 and 60%",
    "token": "2"
  },
  {
    "level": "v80-100",
    "description": "visibility of whole object is between 80 and 100%",
    "token": "4"
  }
]
```

# Useful links

- <a href="https://mmdetection3d.readthedocs.io/en/stable/advanced_guides/datasets/lyft.html" target="_blank">LYFT Dataset Documentation</a>
- <a href="https://paperswithcode.com/dataset/lyft-level-5-prediction" target="_blank">Papers With Code's paper on LYFT</a>
- <a href="https://github.com/lyft/nuscenes-devkit" target="_blank">Lyft SDK GitHub Page</a>
- <a href="https://www.kaggle.com/competitions/3d-object-detection-for-autonomous-vehicles" target="_blank">"Lyft 3D Object Detection for Autonomous Vehicles" on Kaggle</a>