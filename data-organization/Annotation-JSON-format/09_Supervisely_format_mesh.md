# Meshes Annotation

## Project Structure

Root 📁 `project_name` folder named with the project name

- 📄 `meta.json` — project-wide class and tag definitions. See [Project Meta](./02_Project_Classes_And_Tags.md) for the full field reference.
- 📄 `key_id_map.json` — optional mapping between object keys and their numeric IDs in Supervisely.
- 📁 `meshes` — source mesh files in `.ply`, `.stl`, or `.obj` format.
- 📁 `annotations` — one subfolder per mesh file, named after the mesh (e.g. `mesh_01.ply`), each containing:
  - 📄 `annotation.json` — labeled objects for that mesh.
  - 📁 `geometries` — binary `.bin` files, one per object, storing the face index set.

**Example directory layout:**

```
📦 project_name
├── 📂 annotations
│   ├── 📂 mesh_01.ply
│   │   ├── 📄 annotation.json
│   │   └── 📂 geometries
│   │       ├── 📄 4178a5fbc3284da9876d76ef9688de09.indices.bin
│   │       └── 📄 9c3e12ab7f1045bc901d34ef5a72c108.indices.bin
│   └── 📂 mesh_02.ply
│       ├── 📄 annotation.json
│       └── 📂 geometries
│           └── 📄 b2d09f3e1c6840a7882e15cf4d39710a.indices.bin
├── 📂 meshes
│   ├── 📄 mesh_01.ply
│   └── 📄 mesh_02.ply
├── 📄 key_id_map.json
└── 📄 meta.json
```

## Format of `annotation.json`

Each mesh has a corresponding `annotation.json` at `annotations/<mesh_filename>/annotation.json`.

```json
{
  "key": "be08c6a07eb04c9c8861c6b85bc97d61",
  "meshId": 6152776,
  "tags": [],
  "objects": [
    {
      "key": "b0a626eac7a741d39c32fc02ac1db32b",
      "id": 417339,
      "classTitle": "scratch",
      "tags": [],
      "geometryType": "mesh",
      "geometry": {
        "indices": null,
        "indicesPath": "geometries/4178a5fbc3284da9876d76ef9688de09.indices.bin"
      }
    }
  ]
}
```

**Field descriptions:**

| Field | Type | Description |
|---|---|---|
| `key` | string | Unique identifier for this annotation. |
| `meshId` | integer | Numeric ID of the mesh in Supervisely. |
| `tags` | array | Tags applied to the mesh itself (not to individual objects). |
| `objects` | array | List of labeled objects. Each entry describes one annotated region on the mesh. |

**Per-object fields:**

| Field | Type | Description |
|---|---|---|
| `key` | string | Unique identifier for the object, referenced by `key_id_map.json`. |
| `id` | integer | Numeric ID of the object in Supervisely. |
| `classTitle` | string | Name of the annotation class as defined in `meta.json`. |
| `tags` | array | Tags applied to this specific object. |
| `geometryType` | string | Always `"mesh"` for mesh objects. |
| `geometry.indices` | null | Reserved for inline face indices; always `null` when `indicesPath` is used. |
| `geometry.indicesPath` | string | Path to the `.bin` file containing the face index set, relative to the annotation folder. |

## Geometry `.bin` Files

Object geometry is stored as a binary file of 32-bit unsigned integers. Each value is a zero-based face index referring to the triangles in the source mesh. The file contains all face indices belonging to the annotated object — selecting those faces from the mesh reconstructs the labeled region.

The file is named with a hex-encoded UUID and stored under `annotations/<mesh_filename>/geometries/`.

```
geometries/4178a5fbc3284da9876d76ef9688de09.indices.bin
```

## `key_id_map.json`

The optional `key_id_map.json` maps string keys used in annotation files to their numeric IDs in Supervisely. This file is generated automatically when exporting a project from Supervisely and is used for round-trip import.

```json
{
  "tags": {},
  "objects": {
    "b0a626eac7a741d39c32fc02ac1db32b": 417339
  },
  "figures": {}
}
```

