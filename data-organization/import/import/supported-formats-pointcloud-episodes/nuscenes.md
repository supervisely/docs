# Overview

{% hint style="success" %}
Easily import your pointclouds with annotations in the nuScenes format.
{% endhint %}

The original nuScenes dataset is a comprehensive, large-scale public dataset designed for autonomous driving research, developed by Motional. It includes 1,000 diverse 20-second driving scenes from Boston and Singapore, featuring dense traffic and challenging conditions. With 1.4M camera images, 390k LIDAR sweeps, and 1.4M RADAR sweeps, it provides extensive multimodal sensor data, including annotations for 23 object classes with 3D bounding boxes at 2Hz and object-level attributes like visibility and activity.

When uploading as Pointcloud Episodes, pointclouds will be grouped by scene and objects will be tracked across a scene.

# Format description

**Supported point cloud format:** `.bin`<br>
**With annotations:** yes<br>
**Supported annotation format:** `.json`<br>
**Data structure:** Information is provided below.

# Input files structure

{% hint style="success" %}
Example data: [download ⬇️](https://github.com/supervisely-ecosystem/import-wizard-docs/releases/download/v0.0.2/nuscenes-mini-sample.zip).
{% endhint %}

Both directory and archive are supported.

**Format directory structure:**

```
📦pointcloud_project (folder or .tar/.zip archive)
├──📂dataset1
│ ├──📂maps
│ │ ├──🏞️36092f0b03a857c6a3403e25b4b7aab3.png
│ │ └──🏞️...
│ ├──📂samples
│ │ ├──📂CAM_BACK
│ │ │ ├──🏞️n008-2018-08-01-15-16-36-0400__CAM_BACK__1533151603537558.jpg
│ │ │ └──🏞️...
│ │ ├──📂CAM_BACK_LEFT
│ │ │ ├──🏞️n008-2018-08-01-15-16-36-0400__CAM_BACK_LEFT__1533151603547405.jpg
│ │ │ └──🏞️...
│ │ ├──📂CAM_BACK_RIGHT
│ │ │ ├──🏞️n008-2018-08-01-15-16-36-0400__CAM_BACK_RIGHT__1533151605028113.jpg
│ │ │ └──🏞️...
│ │ ├──📂CAM_FRONT
│ │ │ ├──🏞️n008-2018-08-01-15-16-36-0400__CAM_FRONT__1533151615912404.jpg
│ │ │ └──🏞️...
│ │ ├──📂CAM_FRONT_LEFT
│ │ │ ├──🏞️n008-2018-08-01-15-16-36-0400__CAM_FRONT_LEFT__1533151614904799.jpg
│ │ │ └──🏞️...
│ │ ├──📂CAM_FRONT_RIGHT
│ │ │ ├──🏞️n008-2018-08-01-15-16-36-0400__CAM_FRONT_RIGHT__1533151611420482.jpg
│ │ │ └──🏞️...
│ │ ├──📂LIDAR_TOP
│ │ │ ├──📄n008-2018-08-01-15-16-36-0400__LIDAR_TOP__1533151611896734.pcd.bin
│ │ │ └──📄...
│ │ ├──📂RADAR_BACK_LEFT
│ │ │ ├──📄n008-2018-08-01-15-16-36-0400__RADAR_BACK_LEFT__1533151610450182.pcd
│ │ │ └──📄...
│ │ ├──📂RADAR_BACK_RIGHT
│ │ │ ├──📄n008-2018-08-01-15-16-36-0400__RADAR_BACK_RIGHT__1533151607538446.pcd
│ │ │ └──📄...
│ │ ├──📂RADAR_FRONT
│ │ │ ├──📄n008-2018-08-01-15-16-36-0400__RADAR_FRONT__1533151610426071.pcd
│ │ │ └──📄...
│ │ ├──📂RADAR_FRONT_LEFT
│ │ │ ├──📄n008-2018-08-01-15-16-36-0400__RADAR_FRONT_LEFT__1533151616430028.pcd
│ │ │ └──📄...
│ │ ├──📂RADAR_FRONT_RIGHT
│ │ │ ├──📄n008-2018-08-01-15-16-36-0400__RADAR_FRONT_RIGHT__1533151609574740.pcd
│ │ └─└──📄...
│ ├──📂sweeps
│ │ ├──📂CAM_BACK
│ │ │ └──🏞️...
│ │ ├──📂CAM_BACK_LEFT
│ │ │ └──🏞️...
│ │ ├──📂CAM_BACK_RIGHT
│ │ │ └──🏞️...
│ │ ├──📂CAM_FRONT
│ │ │ └──🏞️...
│ │ ├──📂CAM_FRONT_LEFT
│ │ │ └──🏞️...
│ │ ├──📂CAM_FRONT_RIGHT
│ │ │ └──🏞️...
│ │ ├──📂LIDAR_TOP
│ │ │ └──📄...
│ │ ├──📂RADAR_BACK_LEFT
│ │ │ └──📄...
│ │ ├──📂RADAR_BACK_RIGHT
│ │ │ └──📄...
│ │ ├──📂RADAR_FRONT
│ │ │ └──📄...
│ │ ├──📂RADAR_FRONT_LEFT
│ │ │ └──📄...
│ │ ├──📂RADAR_FRONT_RIGHT
│ │ └─└──📄...
│ ├──📂v1.0-mini
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
└── └──📄visibility.json
```

Every `.bin` file in a sequence has to be stored inside a `LIDAR_TOP` folder of 'sample' and 'sweeps' folders of dataset.

| Key | Value                                                     |
| --- | --------------------------------------------------------- |
| x   | The x coordinate of the point.                            |
| y   | The y coordinate of the point.                            |
| z   | The z coordinate of the point.                            |
| i   | Intensity of the return signal.                           |
| r   | Ring index.                                               |

{% hint style="info" %}
The nuScenes format description can be found <a href="https://www.nuscenes.org/nuscenes" target="_blank">here</a>
{% endhint %}

# nuScenes' Annotation format

The nuScenes annotations are token-based. The dataset is composed of dozens of scenes, each containing a certain amount of samples (pointclouds). Samples are linked to annotation data through the use of unique identifiers. These tokens ensure that each point cloud frame is accurately associated with its corresponding annotations, camera data, log information, maps, etc. maintaining the integrity and structure of the dataset.

### `attribute.json`

The `attribute.json` file contains metadata about the attributes of objects in the dataset. An attribute is a property of an instance that can change while the category remains the same. Example: a vehicle being parked/stopped/moving, and whether or not a bicycle has a rider.

```json
{
   "token":                   <str> -- Unique record identifier.
   "name":                    <str> -- Attribute name.
   "description":             <str> -- Attribute description.
}
```

### `calibrated_sensor.json`

The `calibrated_sensor.json` file contains calibration data for each sensor used in the dataset. Definition of a particular sensor (lidar/radar/camera) as calibrated on a particular vehicle. All extrinsic parameters are given with respect to the ego vehicle body frame. All camera images come undistorted and rectified.

```json
{
   "token":                   <str> -- Unique record identifier.
   "sensor_token":            <str> -- Foreign key pointing to the sensor type.
   "translation":             <float> [3] -- Coordinate system origin in meters: x, y, z.
   "rotation":                <float> [4] -- Coordinate system orientation as quaternion: w, x, y, z.
   "camera_intrinsic":        <float> [3, 3] -- Intrinsic camera calibration. Empty for sensors that are not cameras.
}
```

### `category.json`

The `category.json` file contains metadata about the categories of objects in the dataset. Taxonomy of object categories (e.g. vehicle, human). Subcategories are delineated by a period (e.g. human.pedestrian.adult).

```json
{
   "token":                   <str> -- Unique record identifier.
   "name":                    <str> -- Category name. Subcategories indicated by period.
   "description":             <str> -- Category description.
   "index":                   <int> -- The index of the label used for efficiency reasons in the .bin label files of nuScenes-lidarseg. This field did not exist previously.
}
```

### `ego_pose.json`

Ego vehicle pose at a particular timestamp. Given with respect to global coordinate system of the log's map. The ego_pose is the output of a lidar map-based localization algorithm described in our paper. The localization is 2-dimensional in the x-y plane.

```json
{
   "token":                   <str> -- Unique record identifier.
   "translation":             <float> [3] -- Coordinate system origin in meters: x, y, z. Note that z is always 0.
   "rotation":                <float> [4] -- Coordinate system orientation as quaternion: w, x, y, z.
   "timestamp":               <int> -- Unix time stamp.
}
```

### `instance.json`

The `instance.json` file contains metadata about each instance in the dataset. An object instance, e.g. particular vehicle. This table is an enumeration of all object instances we observed. Note that instances are not tracked across scenes, only inside a given scene.

```json
{
   "token":                   <str> -- Unique record identifier.
   "category_token":          <str> -- Foreign key pointing to the object category.
   "nbr_annotations":         <int> -- Number of annotations of this instance.
   "first_annotation_token":  <str> -- Foreign key. Points to the first annotation of this instance.
   "last_annotation_token":   <str> -- Foreign key. Points to the last annotation of this instance.
}
```

### `log.json`

The `log.json` file contains information about the log from which the data was extracted.

```json
{
   "token":                   <str> -- Unique record identifier.
   "logfile":                 <str> -- Log file name.
   "vehicle":                 <str> -- Vehicle name.
   "date_captured":           <str> -- Date (YYYY-MM-DD).
   "location":                <str> -- Area where log was captured, e.g. singapore-onenorth.
}
```

### `map.json`

The `map.json` file contains metadata about the map data that is stored as binary semantic masks from a top-down view.

```json
{
   "token":                   <str> -- Unique record identifier.
   "log_tokens":              <str> [n] -- Foreign keys.
   "category":                <str> -- Map category, currently only semantic_prior for drivable surface and sidewalk.
   "filename":                <str> -- Relative path to the file with the map mask.
}
```

### `sample.json`

The `sample.json` file contains metadata about each sample in the dataset. A sample is an annotated keyframe at 2 Hz. The data is collected at (approximately) the same timestamp as part of a single LIDAR sweep.

```json
{
   "token":                   <str> -- Unique record identifier.
   "timestamp":               <int> -- Unix time stamp.
   "scene_token":             <str> -- Foreign key pointing to the scene.
   "next":                    <str> -- Foreign key. Sample that follows this in time. Empty if end of scene.
   "prev":                    <str> -- Foreign key. Sample that precedes this in time. Empty if start of scene.
}
```

### `sample_annotation.json`

The `sample_annotation.json` file contains detailed information about each annotation in the dataset. A bounding box defining the position of an object seen in a sample. All location data is given with respect to the global coordinate system.

```json
{
   "token":                   <str> -- Unique record identifier.
   "sample_token":            <str> -- Foreign key. NOTE: this points to a sample NOT a sample_data since annotations are done on the sample level taking all relevant sample_data into account.
   "instance_token":          <str> -- Foreign key. Which object instance is this annotating. An instance can have multiple annotations over time.
   "attribute_tokens":        <str> [n] -- Foreign keys. List of attributes for this annotation. Attributes can change over time, so they belong here, not in the instance table.
   "visibility_token":        <str> -- Foreign key. Visibility may also change over time. If no visibility is annotated, the token is an empty string.
   "translation":             <float> [3] -- Bounding box location in meters as center_x, center_y, center_z.
   "size":                    <float> [3] -- Bounding box size in meters as width, length, height.
   "rotation":                <float> [4] -- Bounding box orientation as quaternion: w, x, y, z.
   "num_lidar_pts":           <int> -- Number of lidar points in this box. Points are counted during the lidar sweep identified with this sample.
   "num_radar_pts":           <int> -- Number of radar points in this box. Points are counted during the radar sweep identified with this sample. This number is summed across all radar sensors without any invalid point filtering.
   "next":                    <str> -- Foreign key. Sample annotation from the same object instance that follows this in time. Empty if this is the last annotation for this object.
   "prev":                    <str> -- Foreign key. Sample annotation from the same object instance that precedes this in time. Empty if this is the first annotation for this object.
}
```

### `sample_data.json`

The `sample_data.json` file contains metadata about each data sample in the dataset. A sensor data e.g. image, point cloud or radar return. For sample_data with is_key_frame=True, the time-stamps should be very close to the sample it points to. For non key-frames the sample_data points to the sample that follows closest in time.

```json
{
   "token":                   <str> -- Unique record identifier.
   "sample_token":            <str> -- Foreign key. Sample to which this sample_data is associated.
   "ego_pose_token":          <str> -- Foreign key.
   "calibrated_sensor_token": <str> -- Foreign key.
   "filename":                <str> -- Relative path to data-blob on disk.
   "fileformat":              <str> -- Data file format.
   "width":                   <int> -- If the sample data is an image, this is the image width in pixels.
   "height":                  <int> -- If the sample data is an image, this is the image height in pixels.
   "timestamp":               <int> -- Unix time stamp.
   "is_key_frame":            <bool> -- True if sample_data is part of key_frame, else False.
   "next":                    <str> -- Foreign key. Sample data from the same sensor that follows this in time. Empty if end of scene.
   "prev":                    <str> -- Foreign key. Sample data from the same sensor that precedes this in time. Empty if start of scene.
}
```

### `scene.json`

The `scene.json` file contains metadata about each scene in the dataset. A scene is a 20s long sequence of consecutive frames extracted from a log. Multiple scenes can come from the same log. Note that object identities (instance tokens) are not preserved across scenes.

```json
{
   "token":                   <str> -- Unique record identifier.
   "name":                    <str> -- Short string identifier.
   "description":             <str> -- Longer description of the scene.
   "log_token":               <str> -- Foreign key. Points to log from where the data was extracted.
   "nbr_samples":             <int> -- Number of samples in this scene.
   "first_sample_token":      <str> -- Foreign key. Points to the first sample in scene.
   "last_sample_token":       <str> -- Foreign key. Points to the last sample in scene.
}
```

### `sensor.json`

The `sensor.json` file specifies sensor types.

```json
{
   "token":                   <str> -- Unique record identifier.
   "channel":                 <str> -- Sensor channel name.
   "modality":                <str> {camera, lidar, radar} -- Sensor modality. Supports category(ies) in brackets.
}
```

### `visibility.json`

The visibility of an instance is the fraction of annotation visible in all 6 images. Binned into 4 bins 0-40%, 40-60%, 60-80% and 80-100%.

```json
{
   "token":                   <str> -- Unique record identifier.
   "level":                   <str> -- Visibility level.
   "description":             <str> -- Description of visibility level.
}
```

# Useful links

- <a href="https://www.nuscenes.org/nuscenes" target="_blank">nuScenes homepage</a>
- <a href="https://mmdetection3d.readthedocs.io/en/v0.17.1/datasets/nuscenes_det.html" target="_blank">MMDetection3D Documentation on nuScenes dataset</a>
- <a href="https://github.com/nutonomy/nuscenes-devkit" target="_blank">nuScenes devkit GitHub page</a>