# Move Supervisely to another server

One of the most frequently asked questions is how to move an existing Supervisely instance from one machine/cloud to another machine/cloud? It's actually very easy.

## Step 1. Install Supervisely on a new machine

Install `supervisely-cli` and run `sudo supervisely install-all` to get all the necessary dependencies on a new server. You can check this [document](../installation/README.md#installation). It is a good idea to pick the same config and data folders as on old server, but it is not nessessary.

## Step 2. Move configuration to a new machine

Locate configuration folder on a new and old machine via `sudo supervisely where` command (run on both servers — usually, `/opt/supervisely`).

Now, copy this folder from old machine to a new one — do not forget to copy both `docker-compose.yml` and `.env` files. For example:

```
# on the old server
rsync -azP /opt/supervisely new_server:/opt/supervisely/
```

## Step 3. Move data to a new machine

### If you store data on the local drive

Locate data folder on a new and old machine via `sudo supervisely where data` command (run on both servers — usually, `/supervisely/data`).

First, stop an existing instance via `sudo supervisely stop`. Now, copy the folder from the old machine to the new one. For example: 

```
# on the old server
rsync -azP /supervisely/data new_server:/supervisely/data
```

### If you store data on external storage (i.e. S3)

In this case you will need to copy data from the cloud via some external utility. We suggest to use `minio` as in this [tutorial](/enterprise-edition/advanced-tuning/s3#migration-from-local-storage).

## Step 4. Start the new instance

We are done with the old server — you can run it back again via `sudo superviselu up -d`. On the new machine, login the the docker registry via `sudo supervisely login` and initialise instance via `sudo supervisely upgrade --skip-backup`.
