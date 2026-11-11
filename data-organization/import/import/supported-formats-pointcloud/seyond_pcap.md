# Overview

{% hint style="success" %}
Import Seyond lidar captures (raw `.pcap` files) as point clouds: every lidar frame becomes a point cloud.
{% endhint %}

# Format description

**Supported point cloud format:** `.pcap` (classic libpcap, as written by `tcpdump`; not pcapng)<br>
**Supported lidars:** Seyond Falcon (sphere point cloud packets). Captures from other Seyond models, such as Robin W, are recognised and skipped with a message.<br>
**With annotations:** only labels exported by the **Export Seyond lidar pcap** app<br>
**Data structure:** Information is provided below.

A capture is the lidar's own UDP output recorded to a file, usually one file per sensor every minute. Supervisely does not convert it. The capture is stored once, as an upload, a link to your cloud storage, or a file in Team Files, and every lidar frame in it becomes an item that reuses the file. The labeling tool decodes each frame from the capture.

Each frame gets:

- `meta.frame`: its frame number
- `meta.timestamp`: the capture time of the frame's first packet (UTC). The episode player shows time from it
- `meta.sensorsData.extrinsicMatrix`: the sensor's mount, when `sensors.json` gives it

Frames are numbered in the order they start in the file. The first and last frames of a capture are usually partial sweeps, and they are kept.

# Input files structure

Both directory and archive are supported, and so are links to cloud storage (**Import as Links**).

```text
📦captures (folder or .tar/.zip archive)
├──📄sensors.json (optional)
├──📄truck-1_forwardRight_falcon_2026-08-26--16-48-00.pcap
├──📄truck-1_forwardRight_falcon_2026-08-26--16-49-00.pcap
├──📄truck-1_forwardLeft_falcon_2026-08-26--16-48-00.pcap
└──📄...
```

Captures named `{device}_{location}_{model}_{timestamp}.pcap` are grouped by sensor (`{device}_{location}`). A capture with any other name is its own sensor, named by its file name without the extension.

## Sensor mount: `sensors.json`

A capture does not record how the lidar is mounted. Give each sensor's mount (sensor to world) so the points, and the labels drawn on them, are in vehicle axes. A mount cannot be changed once a frame has labels, so set it at import.

```json
{
  "sensors": {
    "truck-1_forwardRight": {"xyz": [1.2, -0.8, 2.1], "rpyDegrees": [-90, 0, 0]},
    "truck-1_forwardLeft": [1, 0, 0, 0, 0, 0, 1, 0, 0, -1, 0, 0]
  },
  "episodes": {"maxGapSec": 1.0, "maxFrames": 3000}
}
```

- A mount is 12 numbers (a 3×4 row-major matrix), 16 numbers (4×4 with the last row `0 0 0 1`), or `xyz` in metres with `rpy` in radians or `rpyDegrees`. The rotation is `Rz(yaw) · Ry(pitch) · Rx(roll)`.
- It must be a rotation plus a translation, with no scale or mirroring.
- Without a mount, the import still runs and warns that the points stay in the sensor's own axes.

# What the import creates

- A dataset for each capture. A single capture goes into the dataset you import into.
- In each dataset, one point cloud per frame, named `<capture name>_0000.pcap`, `<capture name>_0001.pcap` and so on. `meta.frame` is the frame's number in the capture.
- The `episodes` settings in `sensors.json` are used only by point cloud episodes.

# Export

The **Export Seyond lidar pcap** app exports the captures (each once, byte-identical), the sensors' mounts and the labels. Importing that folder again restores the labels on the same frames.
