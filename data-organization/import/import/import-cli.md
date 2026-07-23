# Import using CLI

Use `supervisely import` when your data is stored on a local machine and you want to start Auto Import from a terminal.

The command runs the Auto Import Docker image locally, mounts your source data into the container as read-only, detects the annotation format, and uploads data to an existing Supervisely project.

{% hint style="info" %}
This method is useful for local datasets that are too large or inconvenient to upload through the browser. Docker has to be installed and available in your terminal.
{% endhint %}

## Prerequisites

Install or update the Supervisely Python package:

```bash
pip3 install --upgrade supervisely
```

Create `~/supervisely.env` with your Supervisely server address and API token:

```text
SERVER_ADDRESS=<server-address>
API_TOKEN=<api-token>
```

You also need an existing destination project. Copy its ID from the project page in Supervisely.

## Import a local directory

```bash
supervisely import <local-source> --project-id <project-id>
```

In the following **required** arguments, replace:

* `<local-source>` with the local directory or file you want to import.
* `<project-id>` with the ID of the destination Supervisely project. Prefix: `--project-id`

In the following **optional** arguments, replace:

* `<dataset-id>` with the ID of an existing dataset in the destination project. Prefix: `--dataset-id`
* `<dataset-name>` with the name of the dataset that will be created if `--dataset-id` is not provided. Prefix: `--dataset-name`
* `<docker-image>` with a custom Auto Import CLI Docker image. Prefix: `--image`
* `<env-file>` with a custom path to the Supervisely credentials file. By default, `~/supervisely.env` is used. Prefix: `--env-file`
* Add the `--import-as-links` flag to import supported link-based datasets without uploading binary files.
* Add the `--dry-run` flag to print the Docker command without running the import.

For example:

```bash
supervisely import ./dataset --project-id 6911 --dataset-name "my dataset"
```

The source path is mounted into the Docker container as read-only. If you pass a directory, it is mounted as `/input`. If you pass a file, its parent directory is mounted and the file is passed to Auto Import inside `/input`.

{% hint style="info" %}
`--import-as-links` is intended for link-based formats, for example CSV, TXT, or TSV files with URLs. It is not a replacement for importing arbitrary local image files without uploading them.
{% endhint %}

## Advanced mode

For most imports, the short command above is enough. Use advanced options when you need to inspect the generated Docker command, use a custom Auto Import image, provide another credentials file, or control where temporary files are stored.

### Check the Docker command

Add `--dry-run` to print the `docker run` command without starting the import:

```bash
supervisely import ./dataset --project-id 6911 --dry-run
```

This is useful before running a large import, because you can check which local path is mounted and which environment variables are passed to Docker.

### Use a custom image or env file

```bash
supervisely import ./dataset \
  --project-id 6911 \
  --dataset-name "my dataset" \
  --env-file ~/supervisely.env \
  --image supervisely/main-import-cli:latest
```

Use `--image` if you want to run a specific Auto Import CLI image tag. By default, the command uses the latest published CLI image.

### Use a custom Docker work directory

Auto Import prepares data before uploading it. For example, it may unpack archives, remove temporary junk files, convert some files, or create intermediate files. By default, these files are stored in a temporary directory inside the Docker container.

For large archives or project structures with many files, Docker may run out of temporary disk space. In this case, run Docker manually and mount a work directory:

```bash
mkdir -p .sly-import-work

docker run --rm \
  --env-file ~/supervisely.env \
  -e PROJECT_ID=6911 \
  -e DATASET_NAME="my dataset" \
  -e SLY_APP_DATA_DIR=/work \
  -v "$PWD/dataset:/input:ro" \
  -v "$PWD/.sly-import-work:/work" \
  supervisely/main-import-cli:latest \
  --input /input \
  --work-dir /work
```

Keep the source dataset mounted as read-only (`/input:ro`). All writable temporary data should go to the work directory.

For a single archive or file, mount the parent directory and pass the file path inside `/input`:

```bash
docker run --rm \
  --env-file ~/supervisely.env \
  -e PROJECT_ID=6911 \
  -e SLY_APP_DATA_DIR=/work \
  -v "$PWD:/input:ro" \
  -v "$PWD/.sly-import-work:/work" \
  supervisely/main-import-cli:latest \
  --input /input/dataset.zip \
  --work-dir /work
```
