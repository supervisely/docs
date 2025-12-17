# Storage Cleanup

Supervisely has a built-in mechanism to keep your server clean from unused files, but, sometimes, it is not enough. Here are a few notes on how you can clean your instance from files you don't need.

## Manual storage cleanup

To remove projects or models you don't need anymore, please use [Disk Usage](../../data-organization/storage/) page. Do not forget to visit Server Cleanup page as an admin to provide a final confirmation to permanently remove those files from the storage.

## Automatic storage cleanup

Once a day we automatically remove generated archive files for downloading and temporary files created during import. Additionally, we prune old docker images. You can alter how often to perform this cleanup by changing those variables in the `.env` file:

```
CLEANUP_STORAGE_INTERVAL=1 day
CLEANUP_STORAGE_TMP_IMPORT_UNTIL=24h
CLEANUP_STORAGE_ARCHIVES_UNTIL=3 days
CLEANUP_DOCKER_INTERVAL=1 day
CLEANUP_DOCKER_UNTIL=24h
```

## Manual agent cleanup

At the Cluster section for each agent you can [monitor storage](/broken/pages/N4wuosmpY0ZZmmWK0lfz) in real time. You will find there a few buttons that clean agent cache.

## Automatic agent cleanup

There is no automatic agent cleanup at this moment.

## Troubleshoot

Usually, a combination of manual and automatic cleanup procedures keep your instance from bloating, but, if for some reason you can see that occupied disk space keeps growing or you have run into a situation when you have zero free drive space on a system disk and cannot use web interface, check the following folders and run cleanup commands below.

We suggest installing `ncdu` command if possible and use it as `sudo ncdu <folder>` or use `sudo du -sh <folder>`.

### Clean docker images and volumes

**Bloated folder**: `/var/lib/docker/`

**Solution**: Stop Supervisely via `sudo supervisely rm -vfs`. Run `sudo docker system prune -a --volumes`. Run Supervisely back again via `sudo supervisely up -d`.

### Clean agent caches

**Bloated folder**: `~/.supervisely-agent/<agent-token>/`

**Solution**: Run `sudo rm -rf ~/.supervisely-agent/<agent-token>/*`. This will clean up agents' cache. Please note that this would also remove neural network weights checkpoints obtained during training that were not uploaded to the storage.
