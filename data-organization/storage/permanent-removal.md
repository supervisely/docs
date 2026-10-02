---
description: >-
  How to permanently prune a Team, Workspace, Project or Dataset: archive first,
  remove permanently as root, and understand how storage is actually reclaimed.
---

# Permanent removal

Regular removal in Supervisely is reversible — a removed Project or Dataset goes to the [Trash Bin](../../collaboration/admin-panel/server-trash-bin.md) and can be restored. Permanent removal is the second, irreversible step: it drops the entity from the database and releases the storage behind it.

This page explains the model, the API methods for every level, and — most importantly — why disk usage does not drop to its final value the moment a removal finishes.

{% hint style="danger" %}
Permanent removal cannot be undone. There is no trash bin, no restore, and no backup taken on your behalf. Export anything you might still need before you start.
{% endhint %}

## The two-step model

Removal is always two steps, at every level:

1. **Archive** — a soft, reversible removal. The entity disappears from the UI and moves to the Trash Bin. Any user with sufficient permissions can do this.
2. **Remove permanently** — a hard, irreversible removal. **Only a root (instance administrator) user can do this.**

Permanent removal only accepts entities that are already archived. If you call it on a live entity, the request is rejected — archive it first.

| Level | Step 1 — archive (soft) | Step 2 — remove permanently (root only) |
| --- | --- | --- |
| Team | `teams.archive` | `teams.remove.permanently` |
| Workspace | `workspaces.archive` | `workspaces.remove.permanently` |
| Project | `projects.archive` | `projects.remove.permanently` |
| Dataset | `datasets.archive` | `datasets.remove.permanently` |

{% hint style="info" %}
`projects.remove` and `datasets.remove` still work as deprecated aliases of `projects.archive` and `datasets.archive`. Prefer the `*.archive` names in new integrations.
{% endhint %}

## API reference

All methods live under `/public/api/v3/` on your instance and authenticate with the `x-api-key` header. See the [API reference](https://api.docs.supervisely.com) for full schemas.

| Method | Request body | Returns |
| --- | --- | --- |
| `teams.archive` | `{"id": 42}` | — |
| `teams.remove.permanently` | `{"teamsIds": [42, 43]}` — max 50 ids | `{"taskId": 987}` |
| `workspaces.archive` | `{"id": 7}` | — |
| `workspaces.remove.permanently` | `{"workspacesIds": [7, 8]}` — max 50 ids | `{"taskId": 988}` |
| `projects.archive` | `{"id": 111}` | — |
| `projects.remove.permanently` | `{"projects": [{"id": 111}], "preserveProjectCard": false}` | — |
| `datasets.archive` | `{"id": 222}` | — |
| `datasets.remove.permanently` | `{"datasets": [{"id": 222}]}` | — |
| `instance.data.cleanup-unused` | — (root only) | `{"taskId": 989}` |

## Finding what is already archived

Permanent removal only accepts entities that are already archived, so you need a way to list
them. Every v3 list method takes a top-level `archived` property:

| Value | Returns |
| --- | --- |
| omitted / `false` | live entities only — the default |
| `true` | archived (Trash Bin) entities instead |
| `"forever"` | archived entities including those already queued for permanent removal, where the entity has that state. Root only |

```bash
curl -X POST "$SERVER_ADDRESS/public/api/v3/projects.list"   -H "x-api-key: $API_TOKEN" -H "Content-Type: application/json"   -d '{"workspaceId": 7, "archived": true}'
```

`teams.list` takes no parent id, `workspaces.list` takes `teamId`, `projects.list` takes
`workspaceId`, and `datasets.list` takes `projectId` — so enumerating a whole instance means
walking those four levels in order.

{% hint style="info" %}
The `archived` property requires Supervisely instance **6.17.22** or newer. On older instances
the list methods are hard-scoped to live entities and there is no way to enumerate the Trash
Bin over the public API.
{% endhint %}

## Team and Workspace removal runs in the background

`teams.remove.permanently` and `workspaces.remove.permanently` return a **task id** immediately and then drain in the background. A single team can hold thousands of projects, files and job artifacts, so the work is deliberately asynchronous.

What this means in practice:

* The Team or Workspace disappears from the UI as soon as the call returns.
* The actual database and storage work continues afterwards. Poll `tasks.info` with the returned `taskId` to follow it.
* When the task reaches `finished`, that entity's own data is gone.
* If a removal fails, the task reaches a terminal `error` status — it does not retry forever. Inspect the task, resolve the cause, and call the method again (see [idempotency](#notes-and-limitations) below).

Project and Dataset removal is synchronous — the call returns when the entity is gone.

## How storage is actually reclaimed

This is the part worth understanding before you measure your bucket.

Image and video data on a Supervisely instance is stored **instance-globally and reference-counted by content hash**. One stored object can be referenced from any number of Projects, Workspaces and Teams — that is what makes cloning a project cheap and what stops duplicate uploads from consuming space twice.

Because of that, permanently removing an entity drops its **references** to the data, not the data itself. The underlying objects are reclaimed once nothing references them any more *and* a grace window has passed. This happens in two waves:

**Wave 1 — inline, during the removal.** Data whose last request is older than `REMOVE_IMAGE_REQUESTED_THRESHOLD` (**12 hours** by default) is reclaimed as part of the removal itself. Recently-requested data is deliberately left alone, so that an in-flight download or an open labeling session is not pulled out from under it.

**Wave 2 — the unused-data garbage collector.** Everything left over is swept by the instance-wide GC, which runs on a **daily schedule** and can also be triggered on demand with `instance.data.cleanup-unused` (root only). The GC applies a **3-day grace window** before reclaiming an unreferenced object, and it also cleans up orphaned figure geometries left behind by removed annotations.

{% hint style="warning" %}
Bucket usage does not drop to its final value the instant a removal finishes. Expect the remainder to be released over the following days as the two waves complete. If storage does not shrink immediately, that is the design, not a failure.
{% endhint %}

## What each level reclaims

Every level releases the data belonging to the entities nested inside it, plus its own artifacts:

* **Team** — Team Files (`teams_storage`), labeling materials, python notebooks, task files, custom data, export archives, and labeling job debug backups. Plus everything in its Workspaces.
* **Workspace** — models and checkpoints (`models/archives`). Plus everything in its Projects.
* **Project / Dataset** — images, videos, point clouds and volume slices (`images/original`, `videos`, `point_clouds`), per-video metadata folders (`videos_meta`), mask and mesh geometries (`figures/geometries`), README images (`assets/projects/images`) and labeling job debug backups (`debug_backups/jobs`).

## Example: pruning a Team end to end

The recipe below archives a Team, removes it permanently, waits for the background task, and then triggers the garbage collector to release the shared data.

### Step 1. Archive the Team

{% tabs %}
{% tab title="cURL" %}
```bash
export SERVER_ADDRESS="https://app.supervisely.com"
export API_TOKEN="<your-api-key>"

curl -X POST "$SERVER_ADDRESS/public/api/v3/teams.archive" \
  -H "x-api-key: $API_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"id": 42}'
```
{% endtab %}

{% tab title="Python SDK" %}
```python
import supervisely as sly

api = sly.Api()

team_id = 42
api.post("teams.archive", {"id": team_id})
```
{% endtab %}
{% endtabs %}

### Step 2. Remove it permanently

This call requires a root user and returns a task id.

{% tabs %}
{% tab title="cURL" %}
```bash
curl -X POST "$SERVER_ADDRESS/public/api/v3/teams.remove.permanently" \
  -H "x-api-key: $API_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"teamsIds": [42]}'

# {"taskId": 987}
```
{% endtab %}

{% tab title="Python SDK" %}
```python
response = api.post("teams.remove.permanently", {"teamsIds": [team_id]})
task_id = response.json()["taskId"]
print(task_id)
# Output: 987
```
{% endtab %}
{% endtabs %}

{% hint style="info" %}
`teamsIds` and `workspacesIds` accept up to **50** ids per call. Split larger cleanups into batches.
{% endhint %}

### Step 3. Poll until the task finishes

{% tabs %}
{% tab title="cURL" %}
```bash
curl -X POST "$SERVER_ADDRESS/public/api/v3/tasks.info" \
  -H "x-api-key: $API_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"id": 987}'
```

Repeat until `status` is `finished`. A `status` of `error` is terminal — the removal stopped and will not resume on its own.
{% endtab %}

{% tab title="Python SDK" %}
```python
import time

while True:
    status = api.task.get_status(task_id)
    print(status)
    if status in (api.task.Status.FINISHED, api.task.Status.ERROR):
        break
    time.sleep(5)

api.task.raise_for_status(status)
```
{% endtab %}
{% endtabs %}

### Step 4. Reclaim the shared data

Once the removal task is `finished`, the Team's references are gone. Trigger the garbage collector to sweep whatever is now unreferenced — or simply wait for the daily run.

{% tabs %}
{% tab title="cURL" %}
```bash
curl -X POST "$SERVER_ADDRESS/public/api/v3/instance.data.cleanup-unused" \
  -H "x-api-key: $API_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{}'

# {"taskId": 989}
```
{% endtab %}

{% tab title="Python SDK" %}
```python
response = api.post("instance.data.cleanup-unused", {})
gc_task_id = response.json()["taskId"]
```
{% endtab %}
{% endtabs %}

Remember that the GC honours the grace windows described above: objects requested within the last 12 hours, and objects that became unreferenced less than 3 days ago, are intentionally left for a later run. Running the cleanup twice in a row will not shorten those windows.

## Projects and Datasets

Projects and Datasets follow the same archive-then-remove sequence, and the Python SDK exposes dedicated helpers for them.

{% tabs %}
{% tab title="Project" %}
```python
import supervisely as sly

api = sly.Api()

project_id = 111

# Step 1: archive (this is what `projects.archive` does)
api.project.remove(project_id)

# Step 2: permanent removal — root only, batches of up to 50 ids
api.project.remove_permanently(project_id)
```
{% endtab %}

{% tab title="Dataset" %}
```python
import supervisely as sly

api = sly.Api()

dataset_id = 222

# Step 1: archive
api.dataset.remove(dataset_id)

# Step 2: permanent removal — root only, batches of up to 50 ids
api.dataset.remove_permanently(dataset_id)
```
{% endtab %}
{% endtabs %}

When passing a list of ids to `remove_permanently`, all ids must belong to the same Team — group them before calling.

{% hint style="warning" %}
Do not confuse `api.project.remove_permanently()` with the SDK's `api.project.archive(id, archive_url)`. The latter is an unrelated legacy method that offloads a project to an external backup archive; it is not the `projects.archive` soft-removal step described on this page.
{% endhint %}

## Emptying the whole Trash Bin from Python

Walking four levels by hand is rarely what you want. The Python SDK wraps the whole sweep:

```python
import supervisely as sly

api = sly.Api.from_env()

# See what is in the Trash Bin before removing anything
for item in api.trash.get_list():
    print(item.type, item.id, item.name)

# Permanently remove all of it, then reclaim the storage
print(api.trash.clear())
# Output: {'team': 1, 'workspace': 0, 'project': 4, 'dataset': 2}
```

`api.trash.get_list()` walks the instance top-down and returns the archived Teams, Workspaces,
Projects and Datasets, skipping anything already covered by an archived parent — removing a
Team removes everything nested inside it, so its Projects are not listed separately.

`api.trash.clear()` removes all of them in the same order, waits for the background Team and
Workspace removal tasks to finish before descending, and then triggers
`instance.data.cleanup-unused`. Both accept `team_id` to restrict the sweep to a single Team,
and `include_datasets=False` to skip the per-Project scan for archived Datasets, which costs
one API call per live Project.

{% hint style="danger" %}
`api.trash.clear()` is irreversible and root only. There is no second Trash Bin behind it.
Always read `api.trash.get_list()` first.
{% endhint %}

{% hint style="warning" %}
The Trash Bin page also lists models, checkpoints, python notebooks and DTL archives. Those
have no public API, so neither the methods on this page nor `api.trash.clear()` touch them —
remove them from the [Server trash bin](../../collaboration/admin-panel/server-trash-bin.md)
page instead.
{% endhint %}

## Notes and limitations

* **The admin Team (id `1`) cannot be removed.** Attempts to archive or permanently remove it are rejected.
* **Permanent removal is idempotent.** Ids that are already removed are silently skipped, so it is safe to retry a batch after a partial failure or a task that ended in `error`.
* **Only archived entities can be removed permanently.** The one exception is `projects.remove.permanently` with `preserveProjectCard: true` — see below.
* **`preserveProjectCard` defaults to `true`.** Pass `false` explicitly whenever you mean to delete the project. A call of `{"projects": [{"id": 111}]}` takes the default, so it keeps the project card, drops only the data, and leaves the row in the Trash Bin — while still answering `{"success": true}`. `api.project.remove_permanently()` and `api.trash.clear()` always send `false`.
* **`preserveProjectCard: true` is a different operation.** Instead of deleting the project, it keeps the project card in place and drops only its data. Use it when you want to retain the project's identity, history and place in the UI while releasing its storage. Because the project itself survives, this variant does **not** require the project to be archived first.

## See also

* [Disk usage & Cleanup](./) — the UI view of storage per Team and Project
* [Server trash bin](../../collaboration/admin-panel/server-trash-bin.md) — restore or delete archived entities from the admin panel
* [Server cleanup](../../collaboration/admin-panel/server-cleanup.md) — find large and unused entities to prune
* [Storage Cleanup](../../enterprise/cleanup/README.md) — instance-level cleanup settings and troubleshooting
