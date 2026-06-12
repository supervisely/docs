# Meshes Annotation

## Project Structure

Root 📁 `project_name` folder named with the project name

- 📄 `meta.json` — project-wide class and tag definitions. See [Project Meta](./02_Project_Classes_And_Tags.md) for the full field reference.
- 📁 `<dataset_name>` — one folder per dataset, each containing:
  - 📁 `meshes` — source mesh files in `.ply`, `.stl`, or `.obj` format.
  - 📁 `annotations` — one subfolder per mesh file, named after the mesh (e.g. `mesh_01.ply`), each containing:
    - 📄 `annotation.json` — labels for that mesh.
    - 📁 `geometries` — binary `.bin` files, one per label, storing the vertex index set.
  - 📁 `datasets` — optional; nested datasets, each with the same structure.

**Example directory layout:**

```
📦 project_name
├── 📂 dataset_name
│   ├── 📂 meshes
│   │   ├── 📄 mesh_01.ply
│   │   └── 📄 mesh_02.ply
│   ├── 📂 annotations
│   │   ├── 📂 mesh_01.ply
│   │   │   ├── 📄 annotation.json
│   │   │   └── 📂 geometries
│   │   │       ├── 📄 4178a5fbc3284da9876d76ef9688de09.indices.bin
│   │   │       └── 📄 9c3e12ab7f1045bc901d34ef5a72c108.indices.bin
│   │   └── 📂 mesh_02.ply
│   │       ├── 📄 annotation.json
│   │       └── 📂 geometries
│   │           └── 📄 b2d09f3e1c6840a7882e15cf4d39710a.indices.bin
│   └── 📂 datasets
│       └── 📂 nested_dataset_name
│           ├── 📂 meshes
│           └── 📂 annotations
└── 📄 meta.json
```

## Format of `annotation.json`

Each mesh has a corresponding `annotation.json` at `<dataset_name>/annotations/<mesh_filename>/annotation.json`.

```json
{
  "key": "b4a3dc33f8d842a79b24942f85f3f2ee",
  "meshId": 6228355,
  "tags": [
    {
      "name": "confirmed",
      "tagId": 43398,
      "value": 1,
      "id": 1678691
    }
  ],
  "labels": [
    {
      "key": "6e474a08a13f46bcb4c8ca538c760edb",
      "id": 25782697,
      "classTitle": "scratch",
      "tags": [],
      "geometryType": "mesh",
      "geometry": {
        "indices": null,
        "indicesPath": "geometries/6e474a08a13f46bcb4c8ca538c760edb.indices.bin"
      },
      "priority": 1,
      "customData": {}
    }
  ]
}
```

**Field descriptions:**

| Field | Type | Description |
|---|---|---|
| `key` | string | Unique identifier for this annotation. |
| `meshId` | integer | Numeric ID of the mesh in Supervisely. Written on export; optional on import. |
| `tags` | array | Tags applied to the mesh itself (not to individual labels). |
| `labels` | array | List of labeled objects. Each entry describes one annotated region on the mesh. |

**Per-label fields:**

| Field | Type | Description |
|---|---|---|
| `key` | string | Unique identifier for the label; the geometry `.bin` file is named after it. |
| `id` | integer | Numeric ID of the label in Supervisely. Written on export; optional on import. |
| `classTitle` | string | Name of the annotation class as defined in `meta.json`. |
| `tags` | array | Tags applied to this specific label. |
| `geometryType` | string | Always `"mesh"` for mesh labels. |
| `geometry.indices` | array \| null | Inline vertex indices; `null` when `indicesPath` is used. |
| `geometry.indicesPath` | string | Path to the `.bin` file containing the vertex index set, relative to the annotation folder of the mesh. |
| `priority`, `customData` | — | Optional server-side metadata, written on export. |

## Geometry `.bin` Files

Label geometry is stored as a binary file of little-endian 32-bit unsigned integers. Each value is a zero-based vertex index referring to the vertices of the source mesh. The file contains all vertex indices belonging to the label — selecting those vertices on the mesh reconstructs the labeled region.

The file is named after the label `key` and stored under `annotations/<mesh_filename>/geometries/`.

```
geometries/6e474a08a13f46bcb4c8ca538c760edb.indices.bin
```
