# Overview

{% hint style="success" %}
Import `.ply` mesh files with per-vertex annotations embedded directly in the file. Each annotated vertex is painted with the color of its class (vertex colors are matched against class colors from `meta.json`), and an `object_id` groups vertices into object instances.
{% endhint %}

This is useful when annotations are produced by external pipelines (e.g. 3D segmentation models) that write labels directly into PLY vertex attributes.

# Format description

**Supported mesh formats:** `.ply` (ASCII only)<br>
**With annotations:** yes<br>
**Supported annotation format:** Per-vertex PLY properties + `meta.json`.<br>
**Data structure:** Information is provided below.

# Input files structure

Both directory and archive are supported. Datasets may be nested; the directory hierarchy is preserved as a nested dataset hierarchy. Mesh files placed directly next to `meta.json` are imported into a default dataset.

**Recommended directory structure:**

```text
📦 project name
├── 📂 dataset_name
│   ├── 📄 mesh_01.ply
│   ├── 📄 mesh_02.ply
│   └── 📂 nested_dataset_name
│       └── 📄 mesh_03.ply
└── 📄 meta.json
```

# PLY File Requirements

The `.ply` file must be in **ASCII** format (`format ascii 1.0`; binary PLY is not supported) and must contain per-vertex color properties (`red`, `green`, `blue` or `diffuse_red`, `diffuse_green`, `diffuse_blue`) **and** the `class_id`/`object_id` properties in addition to the standard geometry properties. Files without `class_id` and `object_id` are not recognized as this format.

```
property uchar red
property uchar green
property uchar blue
property int class_id
property int object_id
```

- **Vertex colors** define the class: a vertex whose color exactly matches the color of a class from `meta.json` is annotated with that class.
- **`class_id`** is the annotation marker: a vertex with `class_id = -1` is never imported as annotated, even if its color matches a class. This allows background vertices to coexist with a class of the same color (e.g. white).
- **`object_id`** carries instance segmentation: vertices sharing the same `object_id` are grouped into a single object instance. Vertices with `object_id = -1` are imported as semantic (non-instance) annotation of their class.

**Example PLY header:**

```
ply
format ascii 1.0
element vertex 166428
property float x
property float y
property float z
property uchar red
property uchar green
property uchar blue
property uchar alpha
property int class_id
property int object_id
element face 327618
property list uchar int vertex_indices
end_header
```

**Vertex value conventions:**

| Value                                    | Meaning                                       |
| ---------------------------------------- | --------------------------------------------- |
| color matches a class + `class_id != -1` | Vertex is annotated with that class           |
| `class_id = -1`                          | Vertex is not annotated, regardless of color  |
| color does not match any class           | Vertex is not annotated (background)          |
| `object_id = -1`                         | Vertex does not belong to any object instance |
| `object_id >= 0`                         | Unique object (instance) ID within the mesh   |

{% hint style="info" %}
White (`255 255 255`) is the neutral color written by the export for unannotated vertices of colorless meshes. Thanks to the `class_id`/`object_id` markers it can also be used as a class color.
{% endhint %}

# meta.json

The `meta.json` file defines the classes. Vertex colors in the `.ply` files are matched against the `color` field of each class, so **class colors must be unique**. Classes must have shape `mesh` or `any`, and `projectType` must be `meshes`. The file follows the standard Supervisely project meta format.

**Example `meta.json`:**

```json
{
  "classes": [
    {
      "title": "dot",
      "description": "",
      "shape": "mesh",
      "color": "#FF0000",
      "geometry_config": {},
      "id": 197748,
      "hotkey": ""
    },
    {
      "title": "scratch",
      "description": "",
      "shape": "any",
      "color": "#6200FF",
      "geometry_config": {},
      "id": 197761,
      "hotkey": ""
    }
  ],
  "tags": [
    {
      "name": "significant",
      "value_type": "none",
      "color": "#FFC705",
      "id": 36942,
      "hotkey": "",
      "applicable_type": "all",
      "classes": [],
      "target_type": "all"
    }
  ],
  "projectType": "meshes"
}
```

At least one mesh in the project must contain annotated vertices (colors matching a class), otherwise the format will not be detected.

# Semantic vs Instance Segmentation

The `object_id` value controls how annotated vertices are grouped into objects. Vertices are grouped by the `(class, object_id)` pair:

**Instance segmentation** — give each object its own `object_id` (`>= 0`). Vertices sharing the same `object_id` (and the same class color) are imported as one object instance. This also allows multiple disconnected regions of the mesh to be grouped into a single object: if three separate mesh patches all have the color of class `scratch` and `object_id = 42`, they become a single object of class `scratch`.

```
# two separate scratch instances
x y z <scratch color> <class_id> 42
x y z <scratch color> <class_id> 42
x y z <scratch color> <class_id> 43
x y z <scratch color> <class_id> 43
```

**Semantic segmentation** — set `object_id = -1` for annotated vertices. All vertices of the same class are then merged into a single object per class, even if they form disconnected regions:

```
# one merged "scratch" object, no instances
x y z <scratch color> <class_id> -1
x y z <scratch color> <class_id> -1
x y z <scratch color> <class_id> -1
```

Both modes can be mixed in one file: vertices of a class with `object_id = -1` form one semantic object, while vertices with explicit IDs form separate instances of that class.

{% hint style="warning" %}
An `object_id` is expected to belong to a single class — an object instance cannot span two classes. If the same `object_id` does appear with two different class colors, the import will not fail: the vertices are split into separate objects, one per class.
{% endhint %}

# Mesh Cleanup on Import

The label data baked into the `.ply` files is used only to build the annotations. The mesh files stored on the platform are cleaned up during import: `class_id`/`object_id` properties are removed, and label paint is reset (annotated vertices are repainted with neutral white; if every vertex was annotated, the color properties are removed entirely). Original, non-label vertex colors are preserved.
